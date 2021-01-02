local random = math.random
local sqrt = math.sqrt
local ln = math.log
local cos = math.cos
local sin = math.sin
local pi2 = 2*math.pi


--------------------------------------------------------------------------------
-- Generate random number with at least 60 bits of randomness
-- (on my machine random() was 15-bit)
--------------------------------------------------------------------------------
local function rand60()
    return random() + random()/(2^15) + random()/(2^30) + random()/(2^45)
end


--------------------------------------------------------------------------------
-- Generate random gaussian-distributed value
--------------------------------------------------------------------------------
local function gauss_random(x0,sigma)
    local u,v = rand60(),rand60()
    if u == 0.0 then return gauss_random(x0,sigma) end -- Remove singularity
    if u > 1 then u = 1 end --gauss_random returns nan, because rand60() can return 1.00001

    local r = sqrt(-2 * ln(u))
    local x,y = r * cos(pi2*v)
    return x*(sigma or 0.5) + (x0 or 0)
end

--------------------------------------------------------------------------------
-- Generates random failure time given MTBF in units of time
-- Returns true if device has failued, given MTBF and timestep
--------------------------------------------------------------------------------
local function check_failure(mtbf,dt)
    local probability = dt/mtbf
    return rand60() < probability
end




--------------------------------------------------------------------------------
-- Failure simulator
--------------------------------------------------------------------------------
FailSim = {}
FailSim.Objects = {}




--------------------------------------------------------------------------------
-- Parameter description
--      nominal_value       Nominal value of the parameter
--      value               (same)
--      precision           Precision of real value vs nominal value
--      instance_precision  Precision of a single event vs real value
--      varies              If true, "Value()" returns a slightly varying result each time
--      min
--      max                 Parameter will be clamped to these
--------------------------------------------------------------------------------
function FailSim.AddParameter(object, name, a, b)
    if not FailSim.Objects[object] then
        FailSim.Objects[object] = { Parameters = {}, FailurePoints = {}, Age = 0.0, Stress = 1.0 }
    end

    -- Create description
    local d = a
    if type(d) ~= "table" then
        d = {
            nominal_value = a,
            precision = b
        }
    end
    d.nominal_value = d.nominal_value or d.value or 0               -- Nominal value of the parameter
    d.precision = d.precision or 0.05                               -- Precision with which parameter is defined
    d.instance_precision = d.instance_precision or d.precision      -- Precision of every 'event' this parameter defines

    -- Add new parameter
    local parameter = {
        object = object,
        name = name,
        failures = {}, -- List of failures for this parameter
    }
    for k,v in pairs(d) do parameter[k] = v end

    -- Calculate current (initial) value of the parameter
    parameter.value = gauss_random(d.nominal_value,d.nominal_value*d.precision)
    parameter.start_value = parameter.value

    -- Store it
    FailSim.Objects[object].Parameters[name] = parameter
    return parameter.value
end




--------------------------------------------------------------------------------
-- Failure types
--
-- age_drift (drift of parameter with time)
--      const   value       Average drift over mean time period
--      const   mean_time   Period of drift
--
--------------------------------------------------------------------------------
-- (shared parameters)
--      const   mean_time   Mean time between failures of this kind
--
-- on (fails to 1.0)
-- off (fails to 0.0)
-- value (parameter fails to specific value)
--      const   value       Value to which it fails
--
-- precision (loss of precision)
--      const   value       How much tolerance must be added
--      const   precision   How well tolerance is defined
--
-- shift (change in value)
--      const   value       How much must be added/subtracted
--      const   precision   Precision of 'value'
--
--
--------------------------------------------------------------------------------
function FailSim.AddFailurePoint(object, param_name, failure_name, d)
    if not FailSim.Objects[object] then
        FailSim.Objects[object] = { Parameters = {}, FailurePoints = {}, Age = 0.0 }
    end

    -- Create description
    d.value = d.value or 0                                  -- Some failure parameter
    d.precision = d.precision or 0.10                       -- Precision of 'value'
    d.mean_time = d.mean_time or d.mtbf or
        (1/d.mfr) or (1/d.mean_fail_rate) or 1e9            -- Mean time to failure, seconds
    d.time_precision = d.time_precision or d.dmtbf or 0.25  -- Precision of Mtime
    d.duration_precision = d.duration_precision or 0.50     -- Precision of duration

    -- Add new failure point
    local failure = {
        object          = object,
        parameter_name  = param_name,           -- Name of failing parameter
        name            = failure_name,         -- Name of failure
    }
    for k,v in pairs(d) do failure[k] = v end

    -- Special logic
    if failure.type == "on" then
        failure.type = "value"
        failure.value = 1.0
    elseif failure.type == "off" then
        failure.type = "value"
        failure.value = 0.0
    end

    -- Add to list of failures
    table.insert(FailSim.Objects[object].FailurePoints,failure)
    -- Return failure description
    return failure
end



--------------------------------------------------------------------------------
-- Process failures and add object age
--------------------------------------------------------------------------------
local function doFailure(parameter,v)
    if v.type == "value" then
        parameter.oldvalue = parameter.value
        parameter.value = v.value
        parameter.failures[v] = v
    elseif v.type == "precision" then
        parameter.oldinstance_precision = parameter.instance_precision
        parameter.instance_precision = parameter.instance_precision +
          math.abs(gauss_random(v.value,v.value*v.precision))
        parameter.failures[v] = v
    elseif v.type == "shift" then
        parameter.oldvalue = parameter.value
        parameter.value = parameter.value +
          math.abs(gauss_random(v.value,v.value*v.precision))
        parameter.failures[v] = v
    end
    --[[if v.duration then
        parameter.failure_end_age = object.Age +
            gauss_random(v.duration,v.duration*v.duration_precision)
    end]]--
end

function FailSim.Age(object, delta_time)
    local object = FailSim.Objects[object]
    if not object then return end

    -- Age the object by given value
    object.Age = object.Age + delta_time

    -- Check if any of the objects failure points must be triggered
    for k,v in pairs(object.FailurePoints) do
        local parameter = object.Parameters[v.parameter_name]
        if parameter and ((not parameter.failures[v]) or (v.recurring)) then
            -- Drift of parameters over time at certain speed
            if v.type == "age_drift" then
                local dxdt = v.value / failure.fail_age --gauss_random(v.value / v.mean_time,v.sigma)
                parameter.value = parameter.value + dxdt*dt
            end

            -- Single-event failures
            if check_failure(v.mean_time,delta_time) then
                doFailure(parameter,v)
            end
        end
    end
end

function FailSim.RandomFailure()
    -- List all failures
    local failureList = {}
    for _,object in pairs(FailSim.Objects) do
        for k,v in pairs(object.FailurePoints) do
            table.insert(failureList,v)
        end
    end

    -- Get random failure
    local count = #failureList
    local i = math.floor(rand60()*count)+1
    if i > count then i = count end
    if i < 1 then i = 1 end

    local failure = failureList[i]
    local parameter = FailSim.Objects[failure.object].Parameters[failure.parameter_name]
    print("Generated random failure from total of "..count.." failures:")
    print("[!FAIL!] "..failure.name.." in "..(failure.object.Name or "?"))
    doFailure(parameter,failure)
end




--------------------------------------------------------------------------------
-- Return value of the parameter
--------------------------------------------------------------------------------
function FailSim.Value(object,name)
    local cobject = FailSim.Objects[object]
    if not cobject then return end
    local parameter = cobject.Parameters[name]
    if not parameter then return end

    -- Generate value
    local value
    if parameter.varies then
        local instance_sigma = parameter.value*parameter.instance_precision
        value = gauss_random(parameter.value,instance_sigma)
    else
        value = parameter.value
    end

    -- Clamp it
    if parameter.min then value = math.max(parameter.min,value) end
    if parameter.max then value = math.min(parameter.max,value) end

    -- Return
    if value~=value then
        print("WARNING!!!",object.Name,name,value)
    end
    return value
end

function FailSim.ResetParameter(object,name,value)
    local object = FailSim.Objects[object]
    if not object then return end
    local parameter = object.Parameters[name]
    if not parameter then return end

    parameter.failures = {}
    parameter.value = value or
        gauss_random(parameter.nominal_value,parameter.nominal_value*parameter.precision)
end




--------------------------------------------------------------------------------
-- Return failures report for object
--------------------------------------------------------------------------------
function FailSim.Report(obj,type)
    if not obj then
        print("Listing all failures:")
        for k,v in pairs(FailSim.Objects) do
            FailSim.Report(k,type)
        end
        print("...done!")
        return
    end
    local object = FailSim.Objects[obj]
    if not object then return end

    -- Table of failures
    if type == "parameters" then
        for k,v in pairs(object.Parameters) do
            print((obj.Name or "Unknown object")..": "..k)
        end
    end
    if type == "failure_points" then
        for k,v in pairs(object.FailurePoints) do
            print((obj.Name or "Unknown object")..": "..v.name.." ("..v.parameter_name..")")
        end
    end
    if type == "failures" then
        local any = false
        for k,v in pairs(object.Parameters) do
            for k2,v2 in pairs(v.failures) do
                print((obj.Name or "Unknown object")..": "..v2.name)
                any = true
            end
        end
    end
end

function FailSim.Reset()
    for k,v in pairs(FailSim.Objects) do
        for k2,v2 in pairs(v.Parameters) do
            FailSim.ResetParameter(v,v2,0)
            --if v2.oldvalue then v2.value = v2.oldvalue end
            --if v2.oldinstance_precision then v2.instance_precision = v2.oldinstance_precision end
            --v2.failures = {}
            --[[print("!",k,v,k2,v2)]]
        end
        --[[for k2,v2 in pairs(v.FailurePoints) do
            --FailSim.Objects.Parameters[k2] = 0
            for k3,v3 in pairs(v2) do
                print("#",k3,v3)
            end
            print("@",k,v,k2,v2)
        end]]
        --FailSim.ResetParameter(v,v.Name,v.Value)
    end
    --object.FailurePoints
end
--[[
Metrostroi = { DefineSystem = function() end }
math.randomseed(os.time())

TRAIN_SYSTEM = {}
dofile("sys_relay.lua")
RELAY = TRAIN_SYSTEM

RELAY:Initialize()

-- Start switching
local i = 0
local x = 0
for t = 0.0, 200000.0, 0.5 do
    function CurTime() return t end

        if (i % 8) == 0 then

        if RELAY.Value ~= 0 then
            print("RELAY WRONG VALUE AFTER",x,"CYCLES")
            print(FailSim.Report(RELAY))
            error()
        end

        RELAY:TriggerInput("Open",1.0)
        x = x + 1
    elseif (i % 8) == 2 then
        if RELAY.Value ~= 1 then
            print("RELAY FAILED TO OPEN AFTER",x,"CYCLES")
            print(FailSim.Report(RELAY))
            error()
        end
    elseif (i % 8) == 4 then
        if RELAY.Value ~= 1 then
            print("RELAY WRONG VALUE AFTER",x,"CYCLES")
            print(FailSim.Report(RELAY))
            error()
        end

        RELAY:TriggerInput("Close",1.0)
        x = x + 1
    elseif (i % 8) == 6 then
        if RELAY.Value ~= 0 then
            print("RELAY FAILED TO CLOSE AFTER",x,"CYCLES")
            print(FailSim.Report(RELAY))
            error()
        end
    end

    RELAY:Think()
    i = i + 1
end]]--
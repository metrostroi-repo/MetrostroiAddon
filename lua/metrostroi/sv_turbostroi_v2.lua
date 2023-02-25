--------------------------------------------------------------------------------
-- Simulation acceleration DLL support
--------------------------------------------------------------------------------
if not TURBOSTROI and (not Turbostroi or not Turbostroi.SetMTAffinityMask) then return end
local turbostroiTrains = {}
if Turbostroi and not TURBOSTROI then
    local FPS = 1/engine.TickInterval()
    local messageTimeout = 0
    local messageCounter = 0
    local dataCache = {{},{}}

    local SendMessage = Turbostroi.SendMessage
    local RecvMessages = Turbostroi.RecvMessages
    local RecvMessage = Turbostroi.RecvMessage
    local ReadAvailable = Turbostroi.ReadAvailable

    local unpack = unpack

    hook.Add("EntityRemoved","Turbostroi",function(ent)
        if dataCache[ent] then
            dataCache[ent] = nil
        end
        if turbostroiTrains[ent] then
            turbostroiTrains[ent] = nil
        end
    end)
    for k,ent in pairs(ents.GetAll()) do
        if ent.Base == "gmod_subway_base" and not ent.NoTrain and not ent.DontAccelerateSimulation then
            turbostroiTrains[ent] = true
        end
    end
    hook.Add("OnEntityCreated","Turbostroi",function(ent)
        timer.Simple(0,function()
            if IsValid(ent) and ent.Base == "gmod_subway_base" and not ent.NoTrain and not ent.DontAccelerateSimulation then
                turbostroiTrains[ent] = true
            end
        end)
    end)
    local id,system,name,index,value
    local msg_count = 0
    local idActionTable = {
        [1] = function (train)
            if train.Systems[system] then
                train.Systems[system][name] = value
                if train.TriggerTurbostroiInput then train:TriggerTurbostroiInput(system,name,value) end
            end
        end,
        [2] = function (train)
            if index == 0 and name ~= "bass" then index = nil end
            if value == 0 and name ~= "bass" then value = nil end
            if name == "" then name = nil end
                --net.WriteString(name)
            train:PlayOnce(system,name,index,value)
        end,
        [3] = function (train)
            if name == "on" then
                --print("[!]Wire "..index.." starts update! Value "..value)
                dataCache[train]["wiresW"][index] = value
                --train:WriteTrainWire(index,value)
                if not train.TrainWireWritersID[index] then train.TrainWireWritersID[index] = true end
                train.TrainWireTurbostroi[index] = value
                if train.TriggerTurbostroiInput then train:TriggerTurbostroiInput("TrainWire",index,value) end
            else
                --print("[!]Wire "..index.." stop update!")
                dataCache[train]["wiresW"][index] = nil
            end
        end,
        [4] = function (train)
            if train.Systems[system] then
                train.Systems[system]:TriggerInput(name,value)
            end
        end,
        [5] = function (train)
            for twid,value in pairs(dataCache[train]["wiresW"]) do
                --train:WriteTrainWire(twid,value)
            end
        end,
        [6] = function (train)
            if IsValid(Player(index)) then
                if value==0 then
                    Player(index):PrintMessage( HUD_PRINTCONSOLE, "--START" )
                    -- print("--START")
                end
                Player(index):PrintMessage( HUD_PRINTCONSOLE, system )
                -- print(system)
            end
        end,
    }
    local function updateTrains(trains)
        --local recvMessage = Turbostroi.RecvMessage
        -- Get data packets from simulation
        for train in pairs(trains) do
            if not dataCache[train] then
                if not SendMessage(train,5,"","",0,0) then return end
                dataCache[train] = {wiresW = {}}

                for sys_name,system in pairs(train.Systems) do
                    if system.OutputsList and system.DontAccelerateSimulation then
                        for _,name in pairs(system.OutputsList) do
                            local value = system[name] or 0
                            if type(value) == "boolean" then value = value and 1 or 0 end
                            if type(value) == "number" then
                                if not dataCache[train][sys_name] then dataCache[train][sys_name] = {} end
                                dataCache[train][sys_name][name] = math.Round(value)
                            end
                        end
                    end
                end
            end
            msg_count = ReadAvailable(train)
            for _ = 1, msg_count do
                id,system,name,index,value = RecvMessage(train)

                idActionTable[id](train)
                messageCounter = messageCounter + 1

            end
        end
        -- Send train wire values
        -- Output all system values
        for train in pairs(trains) do
            if train.ReadTrainWire then
                for i in pairs(train.TrainWires) do
                    if not dataCache[train]["wires"] then dataCache[train]["wires"] = {} end
                    if dataCache[train]["wires"][i] ~= train:ReadTrainWire(i) then
                        if SendMessage(train,3,"","",i,train:ReadTrainWire(i)) then
                            dataCache[train]["wires"][i] = train:ReadTrainWire(i)
                        end
                    end
                end
                for sys_name,system in pairs(train.Systems) do
                    if system.OutputsList and system.DontAccelerateSimulation then
                        for _,name in pairs(system.OutputsList) do
                            local value = system[name] or 0
                            if type(value) == "boolean" then
                                value = value and 1 or 0
                            end
                            if type(value) == "number" then
                                value = math.Round(value,1)
                                if not dataCache[train][sys_name] then dataCache[train][sys_name] = {} end
                                if dataCache[train][sys_name][name] ~= value then
                                    if SendMessage(train,1,sys_name,name,0,value) then
                                        dataCache[train][sys_name][name] = value
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if Turbostroi then
        concommand.Add("metrostroi_turbostroi_run",function(ply,_,_,cmd)
            if not IsValid(ply) or not ply:IsSuperAdmin() then return end
            local train = ply:GetTrain()
            if IsValid(train) then
                -- print(cmd:sub(1,2),cmd:sub(3,4))
                SendMessage(train,6,cmd:sub(1,255),cmd:sub(256,511),ply:UserID(),0)
            end
        end)
        function Turbostroi.TriggerInput(train,system,name,value)
            local v = value or 0
            if type(value) == "boolean" then v = value and 1 or 0 end
                SendMessage(train,4,system,name,0,v)
            --end
        end
        CreateConVar("turbostroi_main_cores",1, FCVAR_ARCHIVE,"Set cores for main thread")
        CreateConVar("turbostroi_train_cores",254, FCVAR_ARCHIVE,"Set cores for train threads")
        cvars.AddChangeCallback("turbostroi_main_cores", function(cvar, old, value)
            Turbostroi.SetMTAffinityMask(tonumber(value) or 1) -- CPU5 CPU4 on 6 core --NEWTURBOSTROI
        end, "turbostroi")
        cvars.AddChangeCallback("turbostroi_train_cores", function(cvar, old, value)
            Turbostroi.SetSTAffinityMask(tonumber(value) or 254) -- 0 - disabled --NEWTURBOSTROI
        end, "turbostroi")
        Turbostroi.SetMTAffinityMask(GetConVar("turbostroi_main_cores"):GetInt() or 1) -- CPU5 CPU4 on 6 core --NEWTURBOSTROI
        Turbostroi.SetSTAffinityMask(GetConVar("turbostroi_train_cores"):GetInt() or 254) -- 0 - disabled --NEWTURBOSTROI
        Turbostroi.SetSimulationFPS(FPS)
        hook.Add("Think", "Turbostroi_Think", function()
            if not Turbostroi then return end
            updateTrains(turbostroiTrains)
            --[[
            -- HACK
            GLOBAL_SKIP_TRAIN_SYSTEMS = nil

            -- Print stats
                if ((CurTime() - messageTimeout) > 1.0) then
                messageTimeout = CurTime()
                RunConsoleCommand("say",Format("Metrostroi: %d messages per second (%d per tick)",messageCounter,messageCounter / FPS))
                messageCounter = 0
            end]]
        end)
    end
    return
end




--------------------------------------------------------------------------------
-- Turbostroi scripts
--------------------------------------------------------------------------------
-- NEW API
local OSes = {
    Windows = "win32",
    Windows64 = "win64",
    Linux = "linux",
    Linux64 = "linux64",
    BSD = "linux",
    POSIX = "linux",
    OSX = "osx",
}
local dllPath = "./garrysmod/lua/bin/gmsv_turbostroi_"..(OSes[jit.os] or "win32")..".dll"

local ffi = require("ffi")
ffi.cdef[[
bool ThreadSendMessage(void *p, int message, const char* system_name, const char* name, double index, double value);
int ThreadReadAvailable(void* p);
typedef struct {
    int message;
    char system_name[64];
    char name[64];
    double index;
    double value;
} thread_msg;
thread_msg ThreadRecvMessage(void* p);
]]

local TS = ffi.load(dllPath)

Metrostroi = {}
local dataCache = {wires = {},wiresW = {},wiresL = {}}
Metrostroi.BaseSystems = {} -- Systems that can be loaded
Metrostroi.Systems = {} -- Constructors for systems

LoadSystems = {} -- Systems that must be loaded/initialized
GlobalTrain = {} -- Train emulator
GlobalTrain.Systems = {} -- Train systems
GlobalTrain.TrainWires = {}
GlobalTrain.WriteTrainWires = {}

TimeMinus = 0
_Time = 0
function CurTime()
    --return CurrentTime-TimeMinus
    return _Time
end
--function CurTime() return os.clock() end

function Metrostroi.DefineSystem(name)
    TRAIN_SYSTEM = {}
    Metrostroi.BaseSystems[name] = TRAIN_SYSTEM

    -- Create constructor
    Metrostroi.Systems[name] = function(train,...)
        local tbl = { _base = name }
        local TRAIN_SYSTEM = Metrostroi.BaseSystems[tbl._base]
        if not TRAIN_SYSTEM then print("No system: "..tbl._base) return end
        for k,v in pairs(TRAIN_SYSTEM) do
            if type(v) == "function" then
                tbl[k] = function(...)
                    if not Metrostroi.BaseSystems[tbl._base][k] then
                        print("ERROR",k,tbl._base)
                    end
                    return Metrostroi.BaseSystems[tbl._base][k](...)
                end
            else
                tbl[k] = v
            end
        end

        tbl.Initialize = tbl.Initialize or function() end
        tbl.Think = tbl.Think or function() end
        tbl.Inputs = tbl.Inputs or function() return {} end
        tbl.Outputs = tbl.Outputs or function() return {} end
        tbl.TriggerInput = tbl.TriggerInput or function() end
        tbl.TriggerOutput = tbl.TriggerOutput or function() end

        tbl.Train = train
        tbl:Initialize(...)
        tbl.OutputsList = tbl:Outputs()
        tbl.InputsList = tbl:Inputs()
        tbl.IsInput = {}
        for k,v in pairs(tbl.InputsList) do tbl.IsInput[v] = true end
        return tbl
    end
end

function GlobalTrain.LoadSystem(self,a,b,...)
    local name
    local sys_name
    if b then
        name = b
        sys_name = a
    else
        name = a
        sys_name = a
    end

    if not Metrostroi.Systems[name] then print("Error: No system defined: "..name) return end
    if self.Systems[sys_name] then print("Error: System already defined: "..sys_name)  return end

    self[sys_name] = Metrostroi.Systems[name](self,...)
    self[sys_name].Name = sys_name
    self[sys_name].BaseName = name
    self.Systems[sys_name] = self[sys_name]

    -- Don't simulate on here
    local no_acceleration = Metrostroi.BaseSystems[name].DontAccelerateSimulation
    if no_acceleration then
        self.Systems[sys_name].Think = function() end
        self.Systems[sys_name].TriggerInput = function(train,name,value)
            local v = value or 0
            if type(value) == "boolean" then v = value and 1 or 0 end
            TS.ThreadSendMessage(_userdata, 4,sys_name,name,0,v)
        end -- replace with new api

    --Precache values
    elseif self[sys_name].OutputsList then
        dataCache[sys_name] = {}
        for _,name in pairs(self[sys_name].OutputsList) do
            dataCache[sys_name][name] = 0--self[sys_name][name] or 0
        end
    end
end

function GlobalTrain.PlayOnce(self,soundid,location,range,pitch)
    TS.ThreadSendMessage(_userdata, 2,soundid or "",location or "",range or 0,pitch or 0) -- replace with new api
end

function GlobalTrain.ReadTrainWire(self,n)
    return self.TrainWires[n] or 0
end

function GlobalTrain.WriteTrainWire(self,n,v)
    self.WriteTrainWires[n] = v
end


GlobalTrain.DeltaTime = 0.33

--------------------------------------------------------------------------------
-- Main train code (turbostroi side)
--------------------------------------------------------------------------------
print("[!] Train initialized!")
function Think(skipped)
    -- This is just blatant copy paste from init.lua of base train entity
    local self = GlobalTrain

    --[[ if skipped then
        self.BeSkip = self.BeSkip or CurTime()
        return
    else
        self.PrevTime = self.PrevTime or CurTime()
        if self.BeSkip then
            --print(1,(CurTime()-self.BeSkip)-0.03)
            TimeMinus = TimeMinus + math.max(0,(CurTime()-self.BeSkip)-0.03)
            --print(2,TimeMinus)
            self.BeSkip = false
        end
    end--]]

    -- Is initialized?
    if not self.Initialized then
        Initialize()
        return
    end

    self.DeltaTime = (CurrentTime - self.PrevTime)--self.DeltaTime+math.min(0.02,((CurrentTime - self.PrevTime)-self.DeltaTime)*0.1)
    self.PrevTime = CurrentTime
    if skipped or self.DeltaTime<=0 then return end
    _Time = _Time+self.DeltaTime

    -- Perform data exchange
    DataExchange()

    -- Simulate according to schedule
    for i,s in ipairs(self.Schedule) do
        for k,v in ipairs(s) do
            v:Think(self.DeltaTime / (v.SubIterations or 1),i)
        end
    end
end

function Initialize()
    if not CurrentTime then return end
    print("[!] Loading systems")
    local time = os.clock()
    for k,v in pairs(LoadSystems) do
        GlobalTrain:LoadSystem(k,v)
    end
    print(string.format("[!] -Took %.2fs",os.clock()-time))
    GlobalTrain.PrevTime = CurrentTime
    local iterationsCount = 1
    if (not GlobalTrain.Schedule) or (iterationsCount ~= GlobalTrain.Schedule.IterationsCount) then
        GlobalTrain.Schedule = { IterationsCount = iterationsCount }
        local SystemIterations = {}

        -- Find max number of iterations
        local maxIterations = 0
        for k,v in pairs(GlobalTrain.Systems) do
            SystemIterations[k] = (v.SubIterations or 1)
            maxIterations = math.max(maxIterations,(v.SubIterations or 1))
        end

        -- Create a schedule of simulation
        for iteration=1,maxIterations do
            GlobalTrain.Schedule[iteration] = {}
            -- Populate schedule
            for k,v in pairs(GlobalTrain.Systems) do
                if ((iteration)%(maxIterations/(v.SubIterations or 1))) == 0 then
                    table.insert(GlobalTrain.Schedule[iteration],v)
                end

            end
        end
    end
    GlobalTrain.Initialized = true
end
local msg_data
local msg_count = 0
local id,system,name,index,value
function DataExchange()
    -- Get data packets
    msg_count = TS.ThreadReadAvailable(_userdata)
    for i = 1, msg_count do
        msg_data = TS.ThreadRecvMessage(_userdata)
        if msg_data.message == 1 then
            local system_name = ffi.string(msg_data.system_name)
            if GlobalTrain.Systems[system_name] then
                GlobalTrain.Systems[system_name][ffi.string(msg_data.name)] = msg_data.value
            end
        end
        if msg_data.message == 3 then
            dataCache["wiresW"][msg_data.index] = msg_data.value
        end
        if msg_data.message == 4 then
            local system_name = ffi.string(msg_data.system_name)
            if GlobalTrain.Systems[system_name] then
                GlobalTrain.Systems[system_name]:TriggerInput(ffi.string(msg_data.name),msg_data.value)
            end
        end
        if msg_data.message == 5 then
            dataCache["wiresL"] = {}
        end
        if msg_data.message == 6 then
            local scr = [[
            local _retdata=""
            local print = function(...)
                for k,v in ipairs({...}) do _retdata = _retdata..tostring(v).."\t" end
                _retdata = _retdata.."\n"
            end
            ]]
            scr = scr..ffi.string(msg_data.system_name)..ffi.string(msg_data.name).."\n"
            scr = scr.."return _retdata"
            local data,err = loadstring(scr)
            if data then
                local ret = tostring(data()) or "N\\A"
                for i=0,math.ceil(#ret/63) do
                    TS.ThreadSendMessage(_userdata, 6, ret:sub(i*63,(i+1)*63-1), "",msg_data.index,i)
                end
            else
                print(err)
                TS.ThreadSendMessage(_userdata, 6, tostring(err), "",msg_data.index,0)
            end
            --Turbostroi.SendMessage(train,6,cmd:sub(1,255),cmd:sub(256,511),ply:UserID(),0)
        end
    end
    for twid,value in pairs(dataCache["wiresW"]) do
        GlobalTrain.TrainWires[twid] = value
    end

    -- Output all variable values
    for sys_name,system in pairs(GlobalTrain.Systems) do
        if system.OutputsList and (not system.DontAccelerateSimulation) then
            for _,name in pairs(system.OutputsList) do
                local value = (system[name] or 0)
                --if type(value) == "boolean" then value = value and 1 or 0 end
                if not dataCache[sys_name] then print(sys_name) end
                if dataCache[sys_name][name] ~= value then
                    --print(sys_name,name,value)
                    --if SendMessage(1,sys_name,name,0,tonumber(value) or 0) then -- OLD API
                    if TS.ThreadSendMessage(_userdata, 1, sys_name , name, 0, tonumber(value) or 0) then -- NEW API
                        dataCache[sys_name][name] = value
                    end
                end
            end
        end
    end

    -- Output train wire writes
    for twID,value in pairs(GlobalTrain.WriteTrainWires) do
        --local value = tonumber(value) or 0
        if dataCache["wires"][twID] ~= value then
            dataCache["wires"][twID] = value
            dataCache["wiresL"][twID] = false
        end
        if not dataCache["wiresL"][twID] or dataCache["wiresL"][twID]~=GlobalTrain.PrevTime then
            --SendMessage(3,"","on",tonumber(twID) or 0,dataCache["wires"][twID]) -- OLD API
            TS.ThreadSendMessage(_userdata, 3, "", "on", tonumber(twID) or 0, dataCache["wires"][twID]) -- NEW API
            --print("[!]Wire "..twID.." starts update! Value "..dataCache["wires"][twID])
        end
        GlobalTrain.WriteTrainWires[twID] = nil
        dataCache["wiresL"][twID] = CurTime()
    end
    for twID,time in pairs(dataCache["wiresL"]) do
        if time~=CurTime() then
            TS.ThreadSendMessage(_userdata,3, "", "off", tonumber(twID) or 0, 0)
            --print("[!]Wire "..twID.." stops update!")
            dataCache["wiresL"][twID] = nil
        end
    end
    --SendMessage(5,"","",0,0) -- OLD API
    --C.ThreadSendMessage(_userdata, 5,"","",0,0) -- NEW API
    --print(string.format("%s %s",count,#msgCache))
    --count = 0

end

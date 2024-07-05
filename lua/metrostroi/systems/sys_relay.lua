--------------------------------------------------------------------------------
-- Generic relay with configureable parameters
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("Relay")

local relay_types = {
    ["PK-162"] = {
        hasCoil = true,
        pneumatic       = true,
        contactor       = true,
        pickup_current = 0.015*math.random() + 0.085,
    },
    ["Switch"] = {
        contactor       = true,
    },
    ["GV_10ZH"] = {
        contactor       = true,
        normally_closed = true,
    },
    ["VA21-29"] = {
        contactor       = true,
        normally_closed = true,
        bass = true,
    },
    ["AVU-045"] = {
        bass    = true,
    },
    ["Switch"] = {
        close_time = 0,
        open_time = 0,
    },
    ["ARS"] = {
        hasCoil = true,
        close_time = 0,
        open_time = 0,
    },
    ["ARS-DOP"] = {
        hasCoil = true,
        pickup_current = 0.01*math.random() + 0.04,
    },
    ["KPD-110E"] = {
        hasCoil = true,
        coil_res = 50,
    },
    ["REV-813T"] = {
        hasCoil = true,
    },
    ["REV-814T"] = {
        hasCoil = true,
    },
    ["REV-811T"] = {
        hasCoil = true,
    },
    ["REV-821"] = {
        hasCoil = true,
    },
    ["PR-143"] = {
        hasCoil = true,
    },
    ["KPP-113"] = {
        hasCoil = true,
        coil_res = 156,
    },
    ["KPD-110"] = {
        hasCoil = true,
        coil_res = math.random(247,273),
    },
    ["KPP-110"] = {
        hasCoil = true,
        coil_res = 85,
    },
    ["REM-651D"] = {
        hasCoil = true,
    },
    ["R-52B"] = {
        hasCoil = true,
    },
    ["RPUZ-114-T-UHLZA"] = {
        hasCoil = true,
    },
    ["TRTP-115"] = {
        hasCoil = true,
    },
}

function TRAIN_SYSTEM:Initialize(parameters,extra_parameters)
    ----------------------------------------------------------------------------
    -- Initialize parameters
    if not parameters then parameters = {} end
    if type(parameters) ~= "table" then
        relay_type = parameters
        if relay_types[relay_type] then
            parameters = relay_types[relay_type]
        else
            --print("[sys_relay.lua] Unknown relay type: "..parameters, self.Name)
            parameters = {}
        end
        parameters.relay_type = relay_type
    end

    -- Create new table
    local old_param = parameters
    parameters = {} for k,v in pairs(old_param) do parameters[k] = v end

    -- Add extra parameters
    if type(extra_parameters) == "table" then
        for k,v in pairs(extra_parameters) do
            parameters[k] = v
        end
    end

    -- Contactors have different failure modes
    parameters.contactor        = parameters.contactor or false
    -- Should the relay be initialized in 'closed' state
    parameters.normally_closed  = parameters.normally_closed or false
    -- Time in which relay will close (seconds)
    parameters.close_time       = parameters.close_time or 0.050
    -- Time in which relay will open (seconds)
    parameters.open_time        = parameters.open_time or 0.050
    -- Is relay latched (stays in its position even without voltage)
    parameters.latched          = parameters.latched or false
    -- Should relay be spring-returned to initial position
    parameters.returns          = parameters.returns or (not parameters.latched)
    -- Trigger level for the relay
    parameters.trigger_level    = parameters.trigger_level or 0.5
    -- Relay pickup current, A 
    parameters.pickup_current   = parameters.pickup_current or 0.008*math.random() + 0.028
    -- Relay holding current, A
    parameters.holding_current  = parameters.holding_current or 0.006*math.random() + 0.011
    -- Relay coil resistance, Ohm
    parameters.coil_res         = parameters.coil_res or parameters.hasCoil and math.random(100,300) or 1e12
    for k,v in pairs(parameters) do
        self[k] = v
    end

    ----------------------------------------------------------------------------
    -- Relay parameters
    if self.close_time == 0 then
        FailSim.AddParameter(self,"CloseTime",      { value = parameters.close_time})
    else
        FailSim.AddParameter(self,"CloseTime",      { value = parameters.close_time, precision = self.contactor and 0.35 or 0.10, min = 0.010, varies = true })
    end
    if self.open_time == 0 then
        FailSim.AddParameter(self,"OpenTime",       { value = parameters.open_time})
    else
        FailSim.AddParameter(self,"OpenTime",       { value = parameters.open_time, precision = self.contactor and 0.35 or 0.10, min = 0.010, varies = true })
    end
    -- Did relay short-circuit?
    FailSim.AddParameter(self,"ShortCircuit",   { value = 0.000, precision = 0.00 })
    -- Was there a spurious trip?
    FailSim.AddParameter(self,"SpuriousTrip",   { value = 0.000, precision = 0.00 })

    -- Calculate failure parameters
    local MTBF = parameters.MTBF or 1000000 -- cycles, mean time between failures
    local MFR = 1/MTBF   -- cycles^-1, total failure rate
    local openWeight,closeWeight
    -- FIXME
    openWeight = self.open_weight or 0.25
    closeWeight = self.close_weight or 0.25
    --[[if self.Contactor then
        openWeight = 0.25
        closeWeight = 0.25
    elseif self.NormallyOpen then
        openWeight = 0.4
        closeWeight = 0.1
    else
        openWeight = 0.1
        closeWeight = 0.4
    end]]--

    -- Add failure points
    FailSim.AddFailurePoint(self,   "CloseTime", "Mechanical problem (close time not nominal)",
        { type = "precision",   value = 0.5,    mfr = MFR*0.65*openWeight, recurring = true } )
    FailSim.AddFailurePoint(self,   "OpenTime", "Mechanical problem (open time not nominal)",
        { type = "precision",   value = 0.5,    mfr = MFR*0.65*closeWeight , recurring = true } )
    FailSim.AddFailurePoint(self,   "CloseTime", "Stuck closed",
        { type = "value",       value = 1e9,    mfr = MFR*0.65*openWeight, dmtbf = 0.2 } )
    FailSim.AddFailurePoint(self,   "OpenTime", "Stuck open",
        { type = "value",       value = 1e9,    mfr = MFR*0.65*closeWeight , dmtbf = 0.4 } )
    FailSim.AddFailurePoint(self,   "SpuriousTrip", "Spurious trip",
        { type = "on",                          mfr = MFR*0.20, dmtbf = 0.4 } )
    --FailSim.AddFailurePoint(self, "ShortCircuit", "Short-circuit",
        --{ type = "on",                            mfr = MFR*0.15, dmtbf = 0.2 } )



    ----------------------------------------------------------------------------
    -- Initial relay state
    if self.normally_closed then
        self.TargetValue = 1.0
        self.Value = 1.0
    else
        self.TargetValue = self.defaultvalue or 0.0
        self.Value = self.defaultvalue or 0.0
    end
    -- Time when relay should change its value
    self.Time = 0
    self.ChangeTime = nil
    self.Blocked = 0
    -- Extra fields for current sim
    self.Current = 0
    -- This increases precision at cost of perfomance
    self.SubIterations = parameters.iterations or 1--relay
end

function TRAIN_SYSTEM:Inputs()
    return { "Open","Close","+","-","Set","Toggle","Block","OpenBypass","Check","OpenTime","CloseTime"}
end

function TRAIN_SYSTEM:Outputs()
    return { "Value" , "Blocked", "TargetValue", "pickup_current" , "holding_current" , "Current" , "hasCoil" }
end


function TRAIN_SYSTEM:TriggerInput(name,value)
    -- Boolean values accepted
    if type(value) == "boolean" then value = value and 1 or 0 end
    if name == "OpenTime" then
        self.open_time = value
        FailSim.AddParameter(self,"OpenTime",       { value = self.open_time})
    end
    if name == "CloseTime" then
        self.close_time = value
        FailSim.AddParameter(self,"CloseTime",      { value = self.close_time})
    end
    if name == "Reset" then
        if self.normally_closed then
            self:TriggerInput("Set",1)
        else
            self:TriggerInput("Set",self.defaultvalue or 0.0)
        end
    end
        --print(name)
    if name == "Check" then
        if value < 0 and self.Value == 1 then
            self:TriggerInput("Set",0)
            --self:TriggerInput("Set",0)
            self.Train:PlayOnce("av_off","cabin",0.7,70)
        end
        return
    end
    if value == -1 and self.relay_type == "VA21-29" then
        self:TriggerInput("Set",0)
        return
    end
    if name == "OpenBypass" then
        if (not self.ChangeTime) and (self.TargetValue ~= 0.0) then
            self.ChangeTime = self.Time + FailSim.Value(self,"OpenTime")
        end
        self.TargetValue = 0.0
        if self.ChangeTime==self.Time and self.Train.DeltaTime then self:Think(self.Train.DeltaTime) end

        return
    end

    if self.Blocked > 0 and name ~= "Block" and (name == "Close" and self.relay_type == "PK-162" or self.relay_type ~= "PK-162") then return end

    -- Open/close coils of the relay
    if (name == "Block") then
        self.Blocked = value
    elseif (name == "Close") and (value > self.trigger_level) and (self.Value ~= 1.0 or self.TargetValue ~= 1.0) then --(self.TargetValue ~= 1.0 and self.rpb))
        if self.pneumatic and self.Train.Pneumatic.TrainLinePressure < 3 then return end
        if (not self.ChangeTime) or (self.TargetValue ~= 1.0) then
            self.ChangeTime = self.Time + FailSim.Value(self,"CloseTime")
        end
        if self.Value == 1.0 then self.ChangeTime = nil end
        self.TargetValue = 1.0
        if self.ChangeTime==self.Time and self.Train.DeltaTime then self:Think(self.Train.DeltaTime) end

    elseif (name == "Open") and (value > self.trigger_level) and (self.Value ~= 0.0 or self.TargetValue ~= 0.0) then
        if (not self.ChangeTime) or (self.TargetValue ~= 0.0) then
            self.ChangeTime = self.Time + FailSim.Value(self,"OpenTime")
        end
        self.TargetValue = 0.0
        if self.ChangeTime==self.Time and self.Train.DeltaTime then self:Think(self.Train.DeltaTime) end

    elseif name == "NoOpenTime" and value > 0 then
        self.ChangeTime = self.Time
    elseif (name == "+") and (self.Value < (self.maxvalue or self.three_position and 2 or 1)) and value > 0 then
        self.ChangeTime = self.Time + FailSim.Value(self,"CloseTime")
        self.TargetValue = math.min(self.maxvalue or self.three_position and 2 or 1,self.Value+1)
        if self.ChangeTime==self.Time and self.Train.DeltaTime then self:Think(self.Train.DeltaTime) end

    elseif (name == "-") and (self.Value > 0) and value > 0 then
        self.ChangeTime = self.Time + FailSim.Value(self,"OpenTime")
        self.TargetValue = math.max(0.0,self.Value-1)
        if self.ChangeTime==self.Time and self.Train.DeltaTime then self:Think(self.Train.DeltaTime) end

    elseif name == "Set" then
        if self.pneumatic and value > 0 and self.Train.Pneumatic.TrainLinePressure < 3 then return end
        if self.maxvalue then
            if not self.ChangeTime then
                self.ChangeTime = self.Time + FailSim.Value(self,"OpenTime")
            end
            self.TargetValue = math.max(0.0,math.min(self.maxvalue,math.floor(value)))
            if self.ChangeTime==self.Time and self.Train.DeltaTime then self:Think(self.Train.DeltaTime) end

        elseif self.three_position then
            if not self.ChangeTime then
                self.ChangeTime = self.Time + FailSim.Value(self,"OpenTime")
            end
            self.TargetValue = math.max(0.0,math.min(2.0,math.floor(value)))
            if self.ChangeTime==self.Time and self.Train.DeltaTime then self:Think(self.Train.DeltaTime) end

        else
            if value > self.trigger_level
            then self:TriggerInput("Close",self.trigger_level+1)
            else self:TriggerInput("Open",self.trigger_level+1)
            end
        end
    elseif (name == "Toggle") and (value > 0.5) then
        if self.maxvalue then
            self:TriggerInput("Set",self.Value > self.maxvalue-1 and 0 or self.Value+1)
        elseif self.three_position then
            self:TriggerInput("Set",self.Value > 1 and 0 or self.Value+1)
        else
            self:TriggerInput("Set",(1.0 - self.Value)*(self.trigger_level+1))
        end
    end
end

function TRAIN_SYSTEM:Think(dT)
    --print(self.relay_type)
    self.Time = self.Time + dT
    -- Short-circuited relay
    if FailSim.Value(self,"ShortCircuit") > 0.5 then
        self.Value = 1.0
        return
    end
    -- Spurious trip
    if FailSim.Value(self,"SpuriousTrip") > 0.5 then
        self.SpuriousTripTimer = self.Time + (0.5 + 2.5*math.random())
        FailSim.ResetParameter(self,"SpuriousTrip",0.0)
        FailSim.Age(self,1)

        -- Simulate switch right away
        self.Value = 1.0 - self.Value
        self.TargetValue = self.Value
        self.ChangeTime = nil
    end
    if self.SpuriousTripTimer and (self.Time > self.SpuriousTripTimer) then
        self.Value = self.TargetValue
        self.SpuriousTripTimer = nil
    end

    if self.hasCoil then
        self.Current = self.TargetValue*self.Train.Battery.eds_eq/self.coil_res
    end

    if self.hasCoil and self.Value > 0.5 and self.Current < self.holding_current then
        self:TriggerInput("Open",1)
    end
    -- Switch relay
    if self.ChangeTime and (self.Time > self.ChangeTime) and not self.SpuriousTripTimer then
        if self.TargetValue > 0.5 and self.Current >= self.pickup_current or self.TargetValue < 0.5 and self.Current < self.holding_current or not self.hasCoil then
            if self.bass and self.Value ~= self.TargetValue then
                if self.bass_separate then
                    if self.TargetValue > 0 then
                        self.Train:PlayOnce(self.Name.."_on","bass",1)
                    else
                        self.Train:PlayOnce(self.Name.."_off","bass",1)
                    end
                else
                    self.Train:PlayOnce(self.Name,"bass",self.TargetValue)
                end
            end
            self.Value = self.TargetValue
            self.ChangeTime = nil

            -- Age relay a little
            FailSim.Age(self,1)
        end
    end
end

--------------------------------------------------------------------------------
-- "KSAUP" safety system for 81-502
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_502_KSAUP")

function TRAIN_SYSTEM:Initialize()
    self.Power = 0

    self.SpeedoTimer = 0--CurTime()
    self.Speed = 0

    --Inputs
    self.KZP = 0
    self.KDZ = 0
    self.KRR = 0
    self.KRR2 = 0
    self.KOS = 0
    self.DT = 0
    self.VRD = 0

    self.F1 = 0

    self["1"] = 0
    self["17"] = 0
    self["6"] = 0
    self["2"] = 0
    self["20"] = 0
    self["25"] = 0
    self["3"] = 0
    self[44] = 0
    self[46] = 0
    self["31"] = 0
    self["32"] = 0
    self["16"] = 0
    --Outputs
    self[1] = 0
    self[2] = 0
    self[3] = 0
    self[6] = 0
    self[8] = 0
    self["8a"] = 0
    self[17] = 0
    self[20] = 0
    self[25] = 0
    self[31] = 0
    self[32] = 0
    self[16] = 0

    self.Ring = 0

    self.RD = 0
    self.DoorsLeft = 0
    self.DoorsRight = 0
end
function TRAIN_SYSTEM:ClientInitialize()
end

function TRAIN_SYSTEM:Inputs()
    return {
        "CommandDoorsLeft","CommandDoorsRight",
        "CommandDrive", "CommandBrake","CommandBrakeCount","CommandBrakeElapsed"
    }
end
function TRAIN_SYSTEM:Outputs()
    return { "Power","Speed" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    --[[ if name == "CommandBrakeElapsed" and self.KRR2 == 0 and self.KRR1 > 0 and value ~= -1 and self.CrossCount then
        if self.Stage1 and value > 1 then self.Stage2Prepared = true end

        if self.CrossCount > 10 then self.Station = true end
        self.CrossCount = self.CrossCount+1
        if value*1000 < 80+46+2*(8*1.5) then
            if not self.Stage1 and self.BrakeProgramm then
                self.Stage1 = true
                self:SetTargetKPRK(14)
            end
            if self.Stage2Prepared then
                self.Stage2 = true
            end
        end
        --if self.VAV > 0 then print(self.Stage1,self.Stage2Prepared,self.Stage2,value*1000) end
    end
    if name == "CommandBrake" and self.KRR2 == 0 and self.KRR1 > 0 then
        self.BrakeProgramm = self.LAVT > 0
        self.CommandDrive = false
        self.DriveCommand = false

        if self.TargetKPRK and self.LastBrakeProgrammLoss and CurTime()-self.LastBrakeProgrammLoss > 0.3 then self:SetTargetKPRK(self.TargetKPRK+1) end
        if value<0 then self:SetTargetKPRK(-value) end
        self.LastBrakeProgrammLoss = value == 0 and CurTime()
        if self.BrakeProgrammLossDistance and self.BrakeProgrammLossDistance>15 then
            self.BrakeProgrammCurrentDistance=0
        elseif value == 0 then
            self.BrakeProgrammLossDistance = 0
        end
        if value ~= 0 then
            self.CrossCount = 0
        else
            self.CrossCount = nil
        end
    end
    if name == "CommandDrive" then
        if value < 0 then
            self.CommandDrive = false
            self.DriveCommand = false
            self.BrakeProgramm = false
        elseif value > 0 then
            self.CommandDrive = value
        else
            self.CommandDrive = false
        end
    end--]]
    if name == "CommandDoorsLeft" then self.DoorsLeft = value end
    if name == "CommandDoorsRight" then self.DoorsRight = value end
end

function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    if Train.Electric.Type ~= 2 then return end
    local ALS = Train.ALSCoil
    local speed = math.Round(ALS.Speed or 0,1)

    self.SpeedoTimer = self.SpeedoTimer or CurTime()
    if CurTime()-self.SpeedoTimer > 0.4 then
        local time = (CurTime()-self.SpeedoTimer)
        self.Speed = math.max(0,self.Speed+(speed-self.Speed)*(0.4+math.max(0,math.min((self.Speed-5)*0.2,0.4))))
        self.SpeedoTimer = CurTime()
    end

    local Power = self.Power > 0
    local RR = Power and self.KRR > 0
    -- ALS, ARS state
    --local EnableARS = power and RVForward and (not Train.A42 or Train.A42.Value > 0) and Train.ARS.Value > 0
    --local EnableALS = power and (not Train.A43 or Train.A43.Value > 0) and Train.ALS.Value > 0
    local ALSCoils = (Power and(RR or self.KRR2==0)) and 1 or 0
    if ALSCoils ~= ALS.Enabled then
        ALS:TriggerInput("Enable",ALSCoils)
    end
    --ALS

    self.KVT = self.KOS > 0
    local ring = false
    local brake = false
    if RR then
        local Vlimit = 0
        if ALS.F4 > 0 then Vlimit = 40 end
        if ALS.F3 > 0 then Vlimit = 60 end
        if ALS.F2 > 0 then Vlimit = 70 end
        if ALS.F1 > 0 then Vlimit = 80 end
        if self.RD > 0 then Vlimit = 0 end
        if self.KOS > 0 and (ALS.F5 == 0 or ALS.F6 > 0 or self.RD > 0) then Vlimit = 20 end
        -- Determine next limit and current limit

        if ALS.F5 > 0 and self.F5Ring == nil then self.F5Ring = true end
        if ALS.F5 <= 0 and self.F5Ring ~= nil then self.F5Ring = nil end
        if self.F5Ring and speed < 0.1 then self.F5Ring = false end

        --if Vlimit ~= 20 and (ALS.F5 == 0 or self.RD > 0) and self.KVT then Vlimit = 20 end
        --if Vlimit < 20 then print("???",self.Vlimit) end
        --local zero = (ALS.NoFreq+ALS.RealF5) > 0
        -- Enable PV1 and disassembly when we overspeed
        if speed > Vlimit+0.5 and not self.ElectricBrake then
            self.ElectricBrake = true
            self.Alarm = true
        end
        if self.KVT then
            self.Alarm = false
        end
        --We can disable brake, if speed < Vdop and electric brake
        if speed <= Vlimit-2.5 and self.ElectricBrake and not self.Alarm then
            self.ElectricBrake = false
            self.Alarm = false
        end
        if speed < 1 then
            if Vlimit >= 20 and self["1"] > 0 or self["6"] > 0 and self.KVT then
                self.RollingBrake = false
            elseif self["1"] == 0 then
                self.RollingBrake = true
            end
        elseif self.KVT or self["1"] > 0 then
            self.RollingBrake = false
        elseif speed < 12 then
            self.RollingBrake = true
        end

        ring = self.Alarm or self.F5Ring or Vlimit == 20 and speed > Vlimit

        if speed > 0 or self.DT <= 0 then
            self[16] = 1
        else
            self[16] = 0
        end
    else
        self.SpeedLimit = 0
        self.ElectricBrake = false
        self.RollingBrake = false
        self.Alarm = false
        self.F5Ring = nil
        self[16] = 0
    end
    if Power then
        local NoFreq = math.max(0,1-(ALS.F5+ALS.F4+ALS.F3+ALS.F2+ALS.F1+ALS.F6))
        if self.VRD > 0 and ALS.F5 > 0 and ALS.F6 == 0 then self.RD = 1 end
        if ALS.F5 == 0 or ALS.F6 > 0 then self.RD = 0 end
        local Brake = (self.ElectricBrake or self.RollingBrake) and 1 or 0
        local Drive = 1*(1-Brake)

        if Brake > 0 and self.BrakeT == 0 and not self.BrakeTTimer then self.BrakeTTimer= CurTime() end
        if Brake <= 0 and self.BrakeTTimer then
            self.BrakeTTimer = nil
            self.BrakeT = 0
        end
        if self.BrakeTTimer and CurTime()-self.BrakeTTimer > 2 then self.BrakeT = 1 end
        self.BrakeT = self.BrakeT or 0
        self[1] = self["1"]*Drive
        --print(self.Train,2,self[1])
        self[2] = self["2"]+self.BrakeT
        self[3] = Brake
        if not RR then
            self[8] = 0--self.KRR2 == 0 and 1 or 0
            self[6]= 0
        elseif Brake > 0 and speed < 1 then
            if self[6] > 0 then
                self.BrakeTTimer = CurTime()-1.6
                self.BrakeT = 0
            end
            self[8] = self.BrakeT
            self[6] = 0
        else
            self[8] = Brake*self.BrakeT
            self[6] = Brake
        end
        self[17] = self["17"]*(1-self[6])
        self[20] = self["20"]+Brake
        self[25] = self["25"]*(1-Brake)
        self[31] = self["31"]*(1-self["16"])*(self.DoorsLeft+NoFreq)
        self[32] = self["32"]*(1-self["16"])*(self.DoorsRight+NoFreq)

        self.Ring = (ring) and 1 or 0

        self["8a"] = self.KRR
    else
        self[1] = 0
        --print(self.Train,2,self[1])
        self[2] = 0--self["2"]
        self[3] = 0
        self[8] = 0
        self["8a"] = 0
        self[6] = 0
        self[17] = 0--self["17"]
        self[20] = 0--self["20"]
        self[25] = 0--self["25"]
        self[31] = self["31"] --0
        self[32] = self["32"] --0

        self.Ring = 0
    end
end

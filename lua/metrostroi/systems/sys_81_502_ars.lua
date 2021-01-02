--------------------------------------------------------------------------------
-- 81-502 NVL-Type safety system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_502_ARS")

function TRAIN_SYSTEM:Initialize()
    self.KVD = 0
    self.Power = 0

    self.F6 = 0
    self.F5 = 0
    self.F4 = 0
    self.F3 = 0
    self.F2 = 0
    self.F1 = 0
    self.NoFreq = 0

    self.RPB = 0
    --Inputs
    self.F1 = 0

    self["1"] = 0
    self["17"] = 0
    self["6"] = 0
    self["6R"] = 0
    self["2"] = 0
    self["20"] = 0
    self["25"] = 0
    self["3"] = 0

    self[44] = 0
    self[48] = 0
    --Outputs
    self[1] = 0
    self[2] = 0
    self[3] = 0
    self[6] = 0
    self[8] = 0
    self[17] = 0
    self[20] = 0
    self[25] = 0

    self.Ring = 0
    self.BrakeT = 0
end
function TRAIN_SYSTEM:ClientInitialize()
end

function TRAIN_SYSTEM:Inputs()
    return {}
end
function TRAIN_SYSTEM:Outputs()
    return { "Power","Speed", "F6","F5","F4","F3","F2","F1","NoFreq","KVD" }
end

if not math.Round then
    function math.Round( num, idp )

        local mult = 10 ^ ( idp or 0 )
        return math.floor( num * mult + 0.5 ) / mult

    end
end
function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    if Train.Electric.Type ~= 1 then return end
    local ALS = Train.ALSCoil
    local speed = math.Round(ALS.Speed or 0,1)

    local Power = self.Power > 0
    local VRD = Train.VRD.Value > 0
    -- ALS, ARS state
    --local EnableARS = power and RVForward and (not Train.A42 or Train.A42.Value > 0) and Train.ARS.Value > 0
    --local EnableALS = power and (not Train.A43 or Train.A43.Value > 0) and Train.ALS.Value > 0

    if self.ALS ~= ALS.Enabled then
        ALS:TriggerInput("Enable",self.ALS)
    end
    self.RPB = Power and 1 or 0
    self.F6 = ALS.F6
    self.F5 = ALS.F5
    self.F4 = ALS.F4
    self.F3 = ALS.F3
    self.F2 = ALS.F2
    self.F1 = ALS.F1
    self.NoFreq = ALS.NoFreq

    if ALS.Enabled == 0 and VRD then self.NoFreq = 1 end
    --ALS
    if Power then
        local Vlimit = -10
        if self.F4 > 0 then Vlimit = 40 end
        if self.F3 > 0 then Vlimit = 60 end
        if self.F2 > 0 then Vlimit = 70 end
        if self.F1 > 0 then Vlimit = 80 end
        if VRD and Vlimit > 20 then Vlimit = 20 end
        -- Determine next limit and current limit
        self.SpeedLimit = Vlimit
    else
        self.SpeedLimit = 0
    end
    local KVT = Train.KB.Value+Train.PB.Value > 0
    if Power then
        if self.NoFreq ~= self.PrevNoFreq then
            self.IgnorePedal = CurTime()
            self.PrevNoFreq = self.NoFreq
        end
        if not KVT and self.IgnorePedal then self.IgnorePedal = false end
        if self.IgnorePedal and CurTime()-self.IgnorePedal > 2 then KVT = false end

        local zero = self.F5 > 0 and self.F6 == 0
        if not VRD or not zero then self.VRD = false end
        if VRD and zero and speed == 0 then self.VRD = true end


        local SpeedLimit = self.SpeedLimit
        if (self.F6 > 0 or self.NoFreq > 0 or self.VRD) and KVT then SpeedLimit = 20 end
        if self.Started and speed > 0.1 then SpeedLimit = 0 end
        if self.Started and speed <= 0.1 then self.Started = false end
        -- Enable PV1 and disassembly when we overspeed
        SpeedLimit = SpeedLimit*1.03
        if speed > SpeedLimit+0.5 and not self.ElectricBrake then
            self.ElectricBrake = true
            self.ARSRing = speed > 0
        end
        --We can disable brake, if speed < Vdop and electric brake
        if self.ARSRing and KVT then self.ARSRing = false end
        if speed <= SpeedLimit and self.ElectricBrake and not self.ARSRing then
            self.ElectricBrake = false
        end
        if speed < 3 and self["1"] == 0 then self.RO = true end
        if self["1"] > 0 then self.RO = false end
        if self.NoFreq > 0 and KVT then self.RO = false end


        local Brake = (self.ElectricBrake or (Power and self.ALS+self.NoFreq==0)) and 1 or 0
        local Drive = 1*(1-Brake)
        if Drive == 0 then self.KVD  = 1
        elseif self["6"] == 0 then self.KVD  = 0 end
        if Brake > 0 and self.BrakeT == 0 and not self.BrakeTTimer then self.BrakeTTimer= CurTime() end
        if Brake <= 0 and self.BrakeTTimer then
            self.BrakeTTimer = nil
        end
        if self["6R"] == 0 and SpeedLimit <= 20 or self.BrakeTTimer and CurTime()-self.BrakeTTimer > 3.5 then
            self.BrakeT = 1
        elseif not self.BrakeTTimer then self.BrakeT = 0 end
        if self.ElectricBrake and (self["6"] > 0 and not self.PN1Timer or self["6"] == 0) then
            self.PN1Timer = CurTime()
            self.PN1OffTimer = 3.5-math.max(0,(speed-20))/60*2.5
        end
        if not self.ElectricBrake then self.PN1Timer = false end
        self[1] = self["1"]*Drive*(1-self.KVD)
        self[2] = self["2"]+Brake
        self[3] = Brake
        self[6] = Brake
        self[8] = Brake*self.BrakeT
        self[17] = self["17"]*(1-Brake)
        self[20] = self["20"]+Brake
        self[25] = self["25"]*(1-Brake)
        self[44] = (self.RO or self.PN1Timer and CurTime()-self.PN1Timer < self.PN1OffTimer) and 1 or 0
        self[48] = self[44]
        self.Ring = (self.ARSRing) and 1 or 0
    else
        self.ElectricBrake = true
        self.ARSRing = true
        self.Started = true
        self.RO = false
        self.VRD = false
        self.BrakeT = 0
        self.PN1Timer = false

        self[1] = 0
        self[2] = self["2"]
        self[3] = 0
        self[6] = 0
        self[8] = 0
        self[17] = self["17"]
        self[20] = self["20"]
        self[25] = self["25"]
        self[44] = 0
        self[48] = 0

        self.KVD  = 0
        self.Ring = 0
    end

end

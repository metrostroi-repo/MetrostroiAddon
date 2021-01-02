--------------------------------------------------------------------------------
-- Блок контроля безопасности движения 718
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_718_BKBD")

function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("ALSCoil")
    self.Power = 0
    self.FMM1 = 0

    self.KB = 0
    self.Ring = 0
    self.KRH = 0
    self.Drive = 0
    self.Brake = 0
    self.EPKContacts = 0
    self.V0 = 0

    self.F1 = 0
    self.F2 = 0
    self.F3 = 0
    self.F4 = 0
    self.F5 = 0
    self.F6 = 0
    self.RealF5 = 0
    self.NoFreq = 0
    -- Реле педали бдительности (РПБ)
    self.Train:LoadSystem("RPB","Relay","REV-813T", { bass = true, open_time = 2.5,})
    self.Train:LoadSystem("ROT1","Relay","", { bass = true})
    self.Train:LoadSystem("ROT2","Relay","", { bass = true})


    self.Train:LoadSystem("ARS_NG","Relay","")
    self.Train:LoadSystem("ARS_NH","Relay","")
    self.Train:LoadSystem("KPK1","Relay","")
    self.Train:LoadSystem("KPK2","Relay","")
end

function TRAIN_SYSTEM:Inputs()
	return {  }
end

local outputs = {"NoFreq","F5","F4","F3","F2","F1"}
function TRAIN_SYSTEM:Outputs()
	return outputs
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end
if not math.Round then
    function math.Round( num, idp )

        local mult = 10 ^ ( idp or 0 )
        return math.floor( num * mult + 0.5 ) / mult

    end
end

--A48-self.PBPower
--KRU*A42+A48*KV*A79 - self.FMM1
--KRU*A17+A48*KV*A29- self.FMM2
function TRAIN_SYSTEM:Think()
    local Train = self.Train
    local ALS = Train.ALSCoil
    local speed = math.Round(ALS.Speed or 0,1)
    local BUP = Train.BUP
    local EnableALS = (Train.BKBD.Power75V+self.Power)

    Train.FMM1:TriggerInput("Set",self.FMM1)
    Train.FMM2:TriggerInput("Set",self.FMM2)
    self.PBPower = 1
    self.KPK1 = self.FMM1
    if EnableALS ~= ALS.Enabled then
        ALS:TriggerInput("Enable",EnableALS)
    end
    if self.Power12V > 0 then
        self.NoFreq = ALS.NoFreq
        self.F1 = ALS.F1*(1-self.NoFreq)
        self.F2 = ALS.F2*(1-self.NoFreq)
        self.F3 = ALS.F3*(1-self.NoFreq)
        self.F4 = ALS.F4*(1-self.NoFreq)
        self.F5 = ALS.F5*(1-self.NoFreq)
        self.F6 = ALS.F6*(1-self.NoFreq)
        self.RealF5 = self.F5*(1-(self.F4+self.F3+self.F2+self.F1))
        self.NoFreq = self.NoFreq + (1-math.min(1,self.F5+self.F4+self.F3+self.F2+self.F1))
    else
        self.F1 = 0
        self.F2 = 0
        self.F3 = 0
        self.F4 = 0
        self.F5 = 0
        self.F6 = 0
        self.RealF5 = 0
        self.NoFreq = 0
    end

    -- ARS system placeholder logic
    if EnableALS then
        local TwoToSix = self.TwoToSix  > 0
        if (ALS.F1+ALS.F2+ALS.F3+ALS.F4+ALS.F5+ALS.F6+self.NoFreq) == 0 then self.NoFreq = 1 end
        local Vlimit = 0
        if self.F4 > 0 then Vlimit = 40 end
        if self.F3 > 0 then Vlimit = 60 end
        if self.F2 > 0 then Vlimit = 70 end
        if self.F1 > 0 then Vlimit = 80 end
        -- Determine next limit and current limit
        self.SpeedLimit = Vlimit
        self.NextLimit = Vlimit
        if self.F1 > 0 then self.NextLimit = 80 end
        if self.F2 > 0 then self.NextLimit = 70 end
        if self.F3 > 0 then self.NextLimit = 60 end
        if self.F4 > 0 then self.NextLimit = 40 end
        if self.F5 > 0 then self.NextLimit = 20 end
        if not TwoToSix and (self.NextLimit ~= math.max(20,Vlimit) or self.F6 > 0) then
            self.SpeedLimit = 0
            self.NextLimit = self.SpeedLimit
            self.NoFreq = 1
            self.F1 = 0
            self.F2 = 0
            self.F3 = 0
            self.F4 = 0
            self.F5 = 0
            self.F6 = 0
            self.RealF5 = 0
        elseif TwoToSix and (self.NextLimit == math.max(20,Vlimit) and self.F6 == 0) then
            self.SpeedLimit = math.min(40,self.SpeedLimit)
            self.NextLimit = math.min(40,self.NextLimit)
        end
        if self.AttentionPedal then self.SpeedLimit = self.SpeedLimit > 40 and 40 or 0 end
        if TwoToSix and self.F4 > 0 and self.F6 > 0 then
            self.LN = 1
        elseif not TwoToSix then
            self.LN = 0
        end
    else
        local V = math.floor(speed +0.05)
        self.SpeedLimit = 0
        self.NextLimit = 0
    end

    if self.Power > 0 then
        self.KVT = self.KB>0
        --[[ if PB and not self.AttentionPedalTimer and not self.Overspeed then
            self.AttentionPedalTimer = CurTime() + 1
        end

        if PB and self.AttentionPedalTimer and (CurTime() - self.AttentionPedalTimer) > 0  then
            self.AttentionPedal = true
        end
        if not PB and (self.AttentionPedalTimer or self.AttentionPedal) then
            self.AttentionPedal = false
            self.AttentionPedalTimer = nil
        end
        if PB or Train.SB9.Value > 0.5 then self.KVT = true end
        if not PB and Train.SB9.Value < 0.5 then self.KVT = false end
--]]
        -- Ignore pedal
        --[[ if self.IgnorePedal and self.KVT then
            self.KVT = false
        else
            self.IgnorePedal = false
        end--]]

        --if self.EnableARS ~= EnableARS then Train.EPKContacts:TriggerInput("Set",Train.EPKContacts.Value) end
        local SpeedLimit = self.LN == 0 and TwoToSix and self.SpeedLimit > 40 and 40 or self.SpeedLimit
        if SpeedLimit < 20 and self.KVT then SpeedLimit = 20 end
        -- Check absolute stop
        if self.NoFreq ~= self.PrevNoFreq and BUP.IT < 1 then
            self.IgnorePedal = self.NoFreq > 0 and BUP.IT < 1
            self.PrevNoFreq = self.NoFreq
        end
        local zero = (self.NoFreq+self.RealF5) > 0
        -- Enable PV1 and disassembly when we overspeed
        if speed > SpeedLimit+0.5 and not self.Disassembly then
            if zero then
                self.Disassembly = CurTime()-2
            else
                self.Disassembly = CurTime()
            end
            self.ElectricBrake = true
            self.ARSRing = true
        end
        if self.KVT and self.ARSRing then self.ARSRing = false end
        --We can disable brake, if speed < Vdop-3 and electric brake
        if not self.ARSRing and speed <= SpeedLimit-3 and self.ElectricBrake then
            self.ElectricBrake = false
            self.Disassembly = false
            self.PneumaticBrake2 = false
        end
        --We can disable ring if speed < Vdop and not electric brake
        if self.KVT and speed <= SpeedLimit and not self.ElectricBrake and self.ARSRing then self.ARSRing = false end
        --Disable PN1 when we overspeed and time of overspeed < 1.5
        --[[ if speed <= SpeedLimit and self.Disassembly and CurTime()-self.Disassembly < 1.5 then
            self.Disassembly = false
            self.ElectricBrake = false
        end--]]
        --PN2 when we brake to 0 speed
        if self.Disassembly and self.ElectricBrake and speed < 0.25 then self.PneumaticBrake2 = true end

        -- AntiRolling
        local Drive = self.KRH > 0
        -- Engage RO
        if speed < 3 and self.RO ~= true and not Drive and self.KDReadyToRelease ~= false then self.RO = true end
        -- Check RO when we starting
        if self.RO and self.RO ~= true and (speed > 5 or CurTime()-self.RO > 7) then
            self.RO = nil
            self.PneumaticBrake2 = self.NoFreq == 0 and speed <= 5
            self.KDReadyToRelease = nil
        end
        -- Disable PN1 and start RO timer
        if Drive and self.RO == true then
            self.RO = CurTime()
        end

        -- Kiyv door close cancel pneumatic brake 1 command trigger
        --[[ if self.KiyvMode then
            -- Prepare
            if Train.KD.Value == 0 then self.KDReadyToRelease = true end
            -- Release brakes and give RO additional time
            if (Train.KD.Value == 1) and self.KDReadyToRelease then
                self.KDReadyToRelease = false
                self.RO = CurTime() + 1.5
            end
        end--]]

        --[[ local delay = 3.5
        if 10 < speed and speed < 30 then delay = 5.5 end
        if speed < 3 then delay = 10 end
        if (self.ElectricBrake or speed < 0.2) and Train:ReadTrainWire(34) == 0 then
            if not self.EPKTimer then self.EPKTimer = CurTime() end
        else
            self.EPKTimer = nil
        end
        if self.EPKTimer and CurTime()-self.EPKTimer > delay then Train.EPKContacts:TriggerInput("Open",1) end
--]]
        -- ARS signals
        local Ebrake, Abrake, Pbrake1,Pbrake2 =
            ((self.ElectricBrake) and 1 or 0),
            ((self.Disassembly or self.ARSRing or self.ElectricBrake or zero and not self.KVT)  and 1 or 0),
            ((self.Disassembly and (zero or CurTime()-self.Disassembly < 1.5)  or self.RO == true) and 1 or 0),
            ((self.PneumaticBrake2 or zero and not self.KVT) and 1 or 0)
        -- Apply ARS system commands

        self.Drive = 1-(Ebrake+Abrake)
        self.DriveR = self.Drive
        self.Brake = Ebrake
        self.EPKContacts = 1
        self.OKT = self.IKT
        self.Ring = self.ARSRing and 1 or 0
        self.V0 = self.RO == true and 1 or 0
    else
        --if Train.EPK.Value == 0 then Train.EPKContacts:TriggerInput("Set",1) end
        self.ARSRing = true
        self.ElectricBrake = true
        self.PneumaticBrake1 = false
        self.PneumaticBrake2 = true
        self.Disassembly = CurTime()-5
        self.EPKTimer = false
        self.RO = true

        self.Drive = 0
        self.Brake = 0
        --self.DriveR = 0
        self.EPKContacts = 0
        self.IKT = 0
        self.OKT = 0
        self.Ring = 0
        self.V0 = 0
    end
end

--------------------------------------------------------------------------------
-- 81-720 "BARS" safety system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_720_BARS")
TRAIN_SYSTEM.DontAccelerateSimulation = true


function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("ALSCoil")

    -- Internal state
    self.Active = 0

    self.SpeedLimit = 0
    self.NextLimit = 0
    self.Ring = 0
    self.Overspeed = false

    self.Brake = false
    self.Brake2 = false
    self.Drive = false
    self.Braking = false
    self.LN = false
    self.PN1 = 0
    self.PN2 = 0
    self.BTB = 0
    self.BTBReady = 0
    self.BINoFreq = 0

    self.BIAccel = 0
end

function TRAIN_SYSTEM:Outputs()
    return {"Active","Ring","Brake","Brake2","Drive","PN1","PN2", "SpeedLimit", "BTB","BINoFreq","BIAccel"}
end

function TRAIN_SYSTEM:Inputs()
    return {}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end

function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    local ALS = Train.ALSCoil
    local Power = Train.Electric.Battery80V > 62 and (Train.SF7.Value > 0.5 and (Train.BARSBlock.Value == 0 or Train.BARSBlock.Value == 2) or Train.SF4.Value > 0.5 and Train.BARSBlock.Value <= 1) and (Train.RV["KRO5-6"] == 0 or Train.RV["KRR15-16"] > 0) and Train.ALS.Value == 0
    local UOS = (Train.BARSBlock.Value == 3 or Train.SF7.Value < 0.5 and Train.BARSBlock.Value == 1 or Train.SF4.Value < 0.5 and Train.BARSBlock.Value == 2) and (Train.RV["KRO5-6"] == 0 or Train.RV["KRR15-16"] > 0) and Train.ALS.Value == 0
    local EnableALS = Train.Electric.Battery80V > 62 and (1-Train.RV["KRO5-6"]) + Train.RV["KRR15-16"] > 0

    local TwoToSix = Train.ALSFreq.Value  > 0
    if EnableALS ~= (ALS.Enabled==1) then
        ALS:TriggerInput("Enable",EnableALS and 1 or 0)
    end

    self.NoFreq = ALS.NoFreq > 0
    self.BINoFreq = ALS.NoFreq
    self.F1 = ALS.F1 > 0 and not self.NoFreq
    self.F2 = ALS.F2 > 0 and not self.NoFreq
    self.F3 = ALS.F3 > 0 and not self.NoFreq
    self.F4 = ALS.F4 > 0 and not self.NoFreq
    self.F5 = ALS.F5 > 0 and not self.NoFreq
    self.F6 = ALS.F6 > 0 and not self.NoFreq
    self.RealF5 = self.F5 and not self.F4 and not self.F3 and not self.F2 and not self.F1
    -- Speed check and update speed data
    if CurTime() - (self.LastSpeedCheck or 0) > 0.5 then
        self.LastSpeedCheck = CurTime()
        self.Speed = math.Round(Train.Speed or 0,1)
    end
    -- ARS system placeholder logic
    self.KB = (Train.PB.Value > 0.5 or Train.Attention.Value > 0.5)
    self.KVT = (Train.AttentionBrake.Value > 0.5)
    local Active = Power-- and Train.ALS.Value == 0-- and Train.BUKP.Active > 0 and Train.BUV.Reverser ~= 0
    if not self.Ready then Active = false end
    local Emer = Active and Train.RV["KRR15-16"] > 0

    local KMState = Train.Panel.Controller
    local BUPKMState = Train.BUKP.ControllerState
    if Emer then
        KMState = (Train.EmerX1.Value > 0 or Train.EmerX2.Value > 0) and 1 or 0
        BUPKMState = (Train.EmerX1.Value > 0 or Train.EmerX2.Value > 0) and 1 or 0
    end
    if EnableALS then
        local V = math.floor(self.Speed +0.05)
        local Vlimit = 20
        local VLimit2
        if self.F4 then Vlimit = 40 end
        if self.F3 then Vlimit = 60 end
        if self.F2 then Vlimit = 70 end
        if self.F1 then Vlimit = 80 end

        --if (    self.KB) and (Vlimit ~= 0) and (V > Vlimit) then self.Overspeed = true end
        --if (    self.KB) and (Vlimit == 0) and (V > 20) then self.Overspeed = true end
        --if (not self.KB) and (V > Vlimit) and (V > (self.RealNoFreq and 0 or 3)) then self.Overspeed = true end
        --if (    self.KB) and (Vlimit == 0) and self.Train.ARSType and self.Train.ARSType == 3 and not self.Train["PA-KSD"].VRD then self.Overspeed = true end
        --self.Ring = self.Overspeed and (speed > 5)

        -- Determine next limit and current limit
        self.SpeedLimit = VLimit2 or Vlimit+0.5
        self.NextLimit = VLimit2 or Vlimit
        if self.F1 then self.NextLimit = 80 end
        if self.F2 then self.NextLimit = 70 end
        if self.F3 then self.NextLimit = 60 end
        if self.F4 then self.NextLimit = 40 end
        if self.F5 then self.NextLimit = 20 end
        if not TwoToSix and (self.NextLimit ~= math.max(20,Vlimit) or self.F6) then
            self.SpeedLimit = 0
            self.NextLimit = self.SpeedLimit
            self.NoFreq = true
            self.BINoFreq = 1
        end
        if TwoToSix and self.F4 and self.F6 then
            self.LN = true
        end
        if self.SpeedLimit < 20 and self.KB then
            self.SpeedLimit = 20
        end
    else
        self.SpeedLimit = 0
        self.NextLimit = 0
    end

    if Active then
        if self.Speed <= 0.1 then
            self.BTB = 1
        end
        local speed = self.Speed*Train.SpeedSign
        local Drive = self.Drive > 0
        local Brake = self.Brake > 0
        local SpeedLimit = self.SpeedLimit
        if TwoToSix and (not self.LN or self.NextLimit == math.max(20,SpeedLimit) and self.F6 == 0) then
            SpeedLimit = math.min(40,SpeedLimit)
        end
        if self.KB then SpeedLimit = 20 end

        if self.Speed > SpeedLimit
             --or (self.F1 or self.F2 or self.F3 or self.F4) and self.KB and speed > 20
             or (self.NoFreq or self.RealF5) and not self.KB and self.Speed > 0.1
             or self.Braking and not Brake then
             if not Brake and (SpeedLimit > 20 or self.Speed > 0) then
                 self.Braking = CurTime()
                 self.PN1Timer = CurTime()
             end
             if not Brake and (SpeedLimit > 20 or self.Speed > 0) then self.Ringing = true end
             Brake = true
        elseif self.Speed < SpeedLimit and not self.Braking and KMState <= 0 then
            Brake = false
        end
        if (self.Ringing or self.Braking) and self.KVT then
            self.Braking = false
            self.Ringing = false
        end
        --Emer brake if we braking and speed < 4.5
        if Brake and self.Speed > 0.1 and self.Speed < 4.5 then self.BTB = 0 end

        --Противоскат
        if self.Speed < 0.2 and self.PN2 == 0 and (BUPKMState <= 0 or self.Drive == 0) then
            self.PN2 = 1
            self.Starting = nil
        end
        if (BUPKMState > 0 and self.Drive > 0) and self.PN2 > 0 then
            if not self.Starting  then
                self.Starting = CurTime()
            end
            self.PN2 = 0
        end
        if speed < -0.2 and not self.RollingTimer and not self.RollingBraking then self.RollingTimer = CurTime() end
        if speed >= -0.2 and self.RollingTimer and (CurTime()-self.RollingTimer < 3 or not self.RollingBraking) then self.RollingTimer = nil end
        if speed < -0.2 and self.RollingTimer and CurTime()-self.RollingTimer > 3 and not self.RollingBraking then
            self.RollingBraking = CurTime()
            self.RollingTimer = nil
        end
        if self.RollingBraking and KMState > 0 then self.RollingBraking = CurTime() end
        if self.RollingBraking and CurTime()-self.RollingBraking > 1.5 then self.RollingBraking = nil end
        if self.Starting and CurTime() - self.Starting > 6 then
            if self.Speed < 1.5 and not self.KB then self.RollingBraking = CurTime() end
            self.Starting = nil
        end
        if self.RollingBraking then self.BTB = 0 end
        if self.PN2 > 0 and self.Speed > 0.1 then self.BTB = 0 end
        --Brake efficiency check
        if Brake and Train.Acceleration > -0.8 and self.Speed > 0 and not self.BrakeEfficiency then self.BrakeEfficiency = CurTime() end
        local btbtimer = self.Speed > 43 and 3.8 or 3.5
        if (not Brake or Train.Acceleration <= -0.1 or self.Speed == 0) and self.BrakeEfficiency and CurTime()-self.BrakeEfficiency < btbtimer then self.BrakeEfficiency = nil end
        --if self.BrakeEfficiency and KMState <= 0 and self.Speed < 0.1 then self.BrakeEfficiency = nil end
        if self.BrakeEfficiency and CurTime()-self.BrakeEfficiency >= btbtimer then
            self.BTB = 0
            self.BrakeEfficiency = nil
        end
        --Disable PN1 if not braking or passed 1.5s
        if self.PN1Timer and (CurTime()-self.PN1Timer > 1--[[ 1.5--]]  or not Brake) then self.PN1Timer = nil end
        if self.Speed > SpeedLimit-1.1 and KMState > 0 then
            self.DisableDrive = true
            self.ControllerInDrive = KMState > 0
        end
        if self.Speed < SpeedLimit-3 and KMState <= 0 then
            self.DisableDrive = false
            self.ControllerInDrive = false
        end
        if self.ControllerInDrive and (not self.DisableDrive or KMState <= 0) then self.ControllerInDrive = false end
        if self.DisableDrive and not self.ControllerInDrive and KMState > 0 then
            self.Braking = CurTime()
            self.PN1Timer = CurTime()
            self.Ringing = true
            Brake = true
        end
        --[[
        Drive = not self.DisableDrive and (
                                    (self.NoFreq or self.RealF5) and self.KB
                                    or not self.NoFreq and not self.RealF5
                                 ) and not Brake and not Brake2
        self.PN1 = self.PN1Timer and 1 or 0
        self.Ring = self.Ringing and 1 or 0
        self.Brake = Brake and 1 or 0
        self.Brake2 = Brake2 and 1 or 0
        self.Drive = Drive and 1 or 0]]
        Drive = not self.DisableDrive and (
                                    (self.NoFreq or self.RealF5) and self.KB
                                    or not self.NoFreq and not self.RealF5
                                 ) and not Brake and not Brake2
        self.PN1 = self.PN1Timer and 1 or 0
        self.Ring = self.Ringing and 1 or 0
        self.Brake = Brake and 1 or 0
        self.Brake2 = Brake2 and 1 or 0
        self.Drive = Drive and 1 or 0
        if Emer then
            if self.PN2 > 0 or self.Brake > 0 and self.Drive == 0 then
                self.BTB = 0
            end
        end
    else
        if Train.ALS.Value > 0 then
            --[[  Устройства БАРС, или при следовании с отключёнными устройствами БАРС, устройство ограничения скорости (УОС) передают информацию о допустимой скорости и фактической скорости движения поезда в БУП. В зависимости от информации БУП разрешает движение, отключает тяговый режим, выдаёт команду на торможение.]]
            self.PN1 = 0
            self.PN2 = 0
            self.Ring = 0
            self.Brake = 0
            self.Brake2 = 0
            self.Drive = 1

            self.BTB = 1
            self.DisableDrive = false
        elseif UOS then
            self.BTB = (self.KB and not self.UOSBraking) and 1 or 0
            self.Brake = 0

            if not Emer and self.Speed > 20.5 then self.UOSBraking = true end
            if Emer or self.UOSBraking and self.Speed == 0 then self.UOSBraking = false end

            self.Drive = self.UOSBraking and 0 or Train.KAH.Value
            self.Ring = 0
            self.PN1 = 0
            self.PN2 = (self.UOSBraking or BUPKMState <= 0 and self.Speed < 0.2) and 1 or 0
            self.DisableDrive = self.Speed > 18.9 or self.DisableDrive and KMState > 0
        else
            self.BTB = 0
            self.Brake = 0
            self.Drive = 0
            self.Ring = 0
            self.PN1 = 0
            self.PN2 = 0
        end
        self.Starting = nil
        self.Braking = false
        self.Ringing = false
        self.LN = false
    end
    if Train.BUKP.State < 5 or not Power then
        self.BTB = (not UOS and Train.ALS.Value == 0)  and 0 or self.BTB
        self.Ready = false
    end
    if Power and Train.BUKP.State == 5 and KMState <=0 and self.Speed < 1.8 and not self.Ready then
        self.BTB = 1
        self.PN2 = 1
        self.Ready = true
    end
    self.Active = Active and 1 or 0
    self.BIAccel = self.BIAccel + (ALS.Acceleration-self.BIAccel)*dT*2

end

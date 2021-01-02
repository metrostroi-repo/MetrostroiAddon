--------------------------------------------------------------------------------
-- БАРС для 81-722
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_722_BARS")
TRAIN_SYSTEM.DontAccelerateSimulation = true


function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("ALSCoil")
    self.Power = 0
    self.ARSPower = 0

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
    self.PN1 = 0
    self.PN2 = 0
    self.RVTB = 0


    self.NoFreq = 0
    self.F1 = 0
    self.F2 = 0
    self.F3 = 0
    self.F4 = 0
    self.F5 = 0
    self.F6 = 0
end

function TRAIN_SYSTEM:Outputs()
    return {"Active","Ring","Brake","Brake2","Drive","PN1","PN2", "SpeedLimit", "RVTB"}
end

function TRAIN_SYSTEM:Inputs()
    return {"NoFreq","F1","F2","F3","F4","F5","F6"}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end

function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    local ALS = Train.ALSCoil
    local speed = ALS.Speed
    local Power = self.Power
    local EnableALS = Power and Train.ALS.Value > 0.5-- and Train.BUKP.Active > 0
    if EnableALS ~= (ALS.Enabled==1) then
        ALS:TriggerInput("Enable",EnableALS and 1 or 0)
    end

    self.NoFreq = ALS.NoFreq
    self.F1 = ALS.F1
    self.F2 = ALS.F2
    self.F3 = ALS.F3
    self.F4 = ALS.F4
    self.F5 = ALS.F5
    self.F6 = ALS.F6
    self.RealF5 = self.F5*(1-self.F6)
    if (self.F1+self.F2+self.F3+self.F4+self.F5+self.F6) == 0 then self.NoFreq = 1 end

    -- Speed check and update speed data
    if CurTime() - (self.LastSpeedCheck or 0) > 0.5 then
        self.LastSpeedCheck = CurTime()
    end
    -- ARS system placeholder logic
    self.KVT = (Train.PB.Value > 0.5 or Train.Vigilance.Value > 0.5)-- and not self.PBBlock
    --[[if self.PBBlock == nil and self.NoFreq then
        self.PBBlock = Train.PB.Value > 0.5 or Train.Vigilance.Value > 0.5
    end
    if self.PBBlock and Train.PB.Value < 0.5 and Train.Vigilance.Value < 0.5 then self.PBBlock = false end
    if self.PBBlock ~= nil and not self.NoFreq then self.PBBlock = nil end]]
    local Active = Power and self.ARSPower
    if self.KVT and not self.AttentionPedalTimer then
        self.AttentionPedalTimer = CurTime() + 1
    end

    if self.KVT and self.AttentionPedalTimer and (CurTime() - self.AttentionPedalTimer) > 0  then
        self.AttentionPedal = true
    end
    if not self.KVT and (self.AttentionPedalTimer or self.AttentionPedal) then
        self.AttentionPedal = false
        self.AttentionPedalTimer = nil
    end
    if EnableALS then
        local V = math.floor(speed +0.05)
        local Vlimit = 0
        if self.F4 then Vlimit = 40 end
        if self.F3 then Vlimit = 60 end
        if self.F2 then Vlimit = 70 end
        if self.F1 then Vlimit = 80 end

        --if (    self.KVT) and (Vlimit ~= 0) and (V > Vlimit) then self.Overspeed = true end
        --if (    self.KVT) and (Vlimit == 0) and (V > 20) then self.Overspeed = true end
        --if (not self.KVT) and (V > Vlimit) and (V > (self.RealNoFreq and 0 or 3)) then self.Overspeed = true end
        --if (    self.KVT) and (Vlimit == 0) and self.Train.ARSType and self.Train.ARSType == 3 and not self.Train["PA-KSD"].VRD then self.Overspeed = true end
        --self.Ring = self.Overspeed and (speed > 5)

        -- Determine next limit and current limit
        self.SpeedLimit = Vlimit+0.5
        self.NextLimit = Vlimit
        if self.F1 then self.NextLimit = 80 end
        if self.F2 then self.NextLimit = 70 end
        if self.F3 then self.NextLimit = 60 end
        if self.F4 then self.NextLimit = 40 end
        if self.F5 then self.NextLimit = 20 end
    else
        local V = math.floor(speed +0.05)
        self.SpeedLimit = 0
        self.NextLimit = 0
    end

    if Active then
        if Train.Pneumatic.RVTBLeak == 0 then
            self.RVTB = 1
        end
        if self.Starting and CurTime() - self.Starting > 7 then
            if speed > 7 then
                self.Starting = nil
            else
                self.Starting = false
            end
        end
        if speed < 0.1 and self.Starting == false and self.KVT then
            self.Starting = nil
        end
        local Drive = self.Drive > 0
        local Brake = self.Brake > 0
        local Brake2 = self.Brake2 > 0
        local SpeedLimit = self.SpeedLimit
        if self.SpeedLimit < 20 then SpeedLimit = 20 end
        if self.AttentionPedal or Train.VRD.Value > 0.5 then SpeedLimit = 20 end
        if speed > SpeedLimit
             or (self.Starting == false or self.Starting and CurTime() - self.Starting > 7)
             --or (self.F1 or self.F2 or self.F3 or self.F4) and self.KVT and speed > 20
             or not EnableALS and not self.NoFreq
             or (self.NoFreq) and not self.KVT
             or not self.NoFreq and self.RealF5 and (not self.KVT or not self.F6 and not self.VRD)
             or self.Braking and not Brake then
             if not Brake and self.SpeedLimit > 20 then self.Braking = true end
             if not Brake and (self.SpeedLimit > 20 or speed > 0.1) then self.Ringing = true end
             Brake = true
        elseif speed < SpeedLimit and not self.Braking then
            Brake = false
            Brake2 = false
        end
        if (self.Braking or self.Ringing) and self.KVT and (self.NoFreq or EnableALS) then
            self.Braking = false
            self.Ringing = false
        end
        if self.Ringing and self.KVT then
            self.Ringing = false
        end
        if self.Ringing then
            self.RVTB = 0
        end
        if speed < 3 and self.PN1 == 0 and Train.BUKP.PowerCommand <= 0 then
            self.PN1 = 1
            self.PN2Timer = CurTime()
            if self.Starting then self.Starting = nil end
        end
        if (Train.BUKP.PowerCommand > 0.1 or self.NoFreq and self.KVT) and self.PN1 > 0 then
            if not self.Starting and not self.NoFreq  then
                self.Starting = CurTime()
            end
            self.PN1 = 0
        end
        if self.PN1 > 0 and (--[[ Train.BUKP.PN2 > 0 or --]] self.PN2Timer and CurTime()-self.PN2Timer > 1) and self.PN2 == 0 then
            self.PN2 = 1
            self.PN2Timer = nil
        end
        if self.PN1 < 1 then self.PN2 = 0 end
        if self.BPSArmed then self.PN2 = 1 end

        if Brake and not Brake2 and not self.Brake2Timer then self.Brake2Timer = CurTime() end
        if Brake and not Brake2 and self.Brake2Timer and CurTime() - self.Brake2Timer > 1.5 then
            self.Brake2Timer = nil
            Brake2 = true
        end
        if not Brake and (Brake2 or self.Brake2Timer) then
            self.Brake2Timer = nil
            Brake2 = false
        end
        if Train.VRD.Value > 0.5 and self.RealF5 and self.VRD == nil then
            self.VRD = false
        end
        if (Train.VRD.Value < 0.5 or not self.RealF5) and self.VRD ~= nil then
            self.VRD = nil
        end
        if self.VRD == false and speed <= 0.1 then
            self.VRD = true
        end

        --[[ self.BPSMeter = self.BPSMeter or 0
        if Train.Speed*Train.SpeedSign < 0 or self.BPSMeter < 0 then
            self.BPSMeter = self.BPSMeter + math.min(0,Train.Speed*Train.SpeedSign*1000/3600)*dT
            if Train.Speed*Train.SpeedSign > 0.1 then
                self.BPSMeter = 0
            end
            if -self.BPSMeter > 1.5 then
                self.BPSArmed = true
            end
        end
        if Train.BUV.Reverser == 0 and self.BPSArmed then self.BPSArmed = nil end--]]
        --speed >= SpeedLimit-3 and (Train.BUKP.PowerCommand > 5 or Train:ReadTrainWire(19) > 0) or
        self.DriveOff = speed >= SpeedLimit-2
        Drive = not self.DriveOff and (
                                    not self.NoFreq and EnableALS and self.RealF5 and self.KVT and (self.F6 or self.VRD)
                                    or (self.NoFreq or not EnableALS) and self.KVT
                                    or not self.NoFreq and EnableALS and not self.RealF5
                                 )  and not Brake and not self.BPSArmed
        self.Ring = self.Ringing and 1 or 0
        self.Brake = Brake and 1 or 0
        self.Brake2 = Brake2 and 1 or 0
        self.Drive = Drive and 1 or 0
        if self.RVTBReset then
            self.RVTB = 1
            self.RVTBReset = false
        end
    else
        if self.RVTB == 0 and not self.RVTBReset then
            if not self.RVTBResetTimer then self.RVTBResetTimer = CurTime() end
        end
        if not self.RVTBReset and self.RVTB == 1 or self.RVTBResetTimer and CurTime()-self.RVTBResetTimer > 3 then
            self.RVTBReset = trueя
            self.RVTBResetTimer = nil
        end
        self.RVTB = (self.KVT or Train.VAH.Value > 0.5) and 1 or 0
        self.Brake = 0
        self.Brake2 = 0
        self.Brake2Timer = nil
        self.Drive = 0
        self.Ring = 0
        self.PN1 = 0
        self.PN2 = Train.RCARS.Value*Train.BUKP.Active
        self.Starting = nil
        self.Braking = true
        self.Ringing = true
        self.BPSArmed = nil
    end
    self.Active = Active and 1 or 0
end

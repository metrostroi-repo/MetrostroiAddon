--------------------------------------------------------------------------------
-- 81-722 "BARS" safety system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_722_BARS")
TRAIN_SYSTEM.DontAccelerateSimulation = true

local function C(x) return x and 1 or 0 end
local min = math.min

function TRAIN_SYSTEM:Initialize()
    self.Power = 0
    self.ARSPower = 0
    self.ALSPower = 0

    self.SpeedLimit = 0
    self.NextLimit = 0

    self.Enabled = 0

    --Timers
    self.DriveTimer = false
    self.BrakeTimer = false
    self.EKTimer = false



    self.ROCh = false
    self.RSS = false
    self.RSS = false
    self.RO = false
    self.EK = false
    self.R2O = false
    self.ROD = false

    self.KSR = false
    self.KMO = false
    self.KRT = false
    self.BR1 = false
    self.BR2 = false
    self.RUVD = false
    self.PTR = false

    self.RNT = false

    self.NoFreq = 0
    self.F1 = 0
    self.F2 = 0
    self.F3 = 0
    self.F4 = 0
    self.F5 = 0
    self.F6 = 0

    --OUT
    self.MOT = 0
    self.T1 = 0
    self.T2 = 0
    self.Ring = 0
    self.EPK = 0
    self.V1 = 0
    self.V2 = 0
end

function TRAIN_SYSTEM:Outputs()
    return {"MOT","T1","T2","Ring","EPK","V1","ALSPower","Enabled"}
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
    local ARSPower = Train.Panel.ARSPower>0
    local ALSPower = Train.Panel.ALSPower
    if ALSPower ~= ALS.Enabled then
        ALS:TriggerInput("Enable",ALSPower)
    end
    local FreqCode = bit.bor(ALS.F1*1,ALS.F2*2,ALS.F3*4,ALS.F4*8,ALS.F5*16,ALS.F6*32,ALSPower*64)
    if self.FreqCode ~= FreqCode then
        if not self.FreqCodeTimer then self.FreqCodeTimer = CurTime() end
        if self.FreqCodeTimer and CurTime()-self.FreqCodeTimer>0.8 then
            self.FreqCode = FreqCode
            self.FreqCodeTimer = nil

            self.F1 = ALS.F1*ALSPower
            self.F2 = ALS.F2*ALSPower
            self.F3 = ALS.F3*ALSPower
            self.F4 = ALS.F4*ALSPower
            self.F5 = ALS.F5*ALSPower
            self.F6 = ALS.F6*ALSPower
            self.NoFreq = (1-math.min(1,(self.F1+self.F2+self.F3+self.F4+self.F5+self.F6)))*ALSPower
        end
    elseif self.FreqCodeTimer then
        self.FreqCodeTimer = nil
    end
    if ARSPower and self.Enabled==0 then
        self.EK = speed < 0.5
        self.Enabled = self.EK and 1 or 0
    elseif ARSPower then
        local States = Train.BUKP.States
        self.KB = (Train.Vigilance.Value+Train.PB.Value) > 0
        self.VRD = Train.VRD.Value > 0
        local pos = Train.BUKP.Active>0 and (States.Brake and -States.DriveStrength or States.DriveStrength) or -1

        local Vzad = 20
        if self.F4 > 0 then Vzad = 40 end
        if self.F3 > 0 then Vzad = 60 end
        if self.F2 > 0 then Vzad = 70 end
        if self.F1 > 0 then Vzad = 80 end
        if Vzad ~= 20 and (self.VRD or self.KB) then Vzad = 20 end
        if self.F5 > 0 and self.F6 == 0 and self.VRD and not self.AcceptF5 and speed < 0.1 then
            self.AcceptF5 = true
        elseif self.F5 == 0 or self.F6 > 0 or self.F5>0 and not self.VRD then
            self.AcceptF5 = false
        end

        if speed>Vzad-1.5 then self.ROD = true elseif speed<Vzad-2 then self.ROD = false end
        if speed>5 or not self.ROCh and self.KB  then self.RO = false elseif speed<3 then self.RO = true end
        if speed>20 then self.R2O = false elseif speed<19 then self.R2O = true end
        if Vzad<=20 or speed>Vzad then self.RSS = false elseif speed<Vzad-1.5 then self.RSS = true end
        self.KMO = pos<=0
        self.KRT = pos<0 or Train.BUKP.LPT
        self.ROCh = self.NoFreq == 0
        if self.RO and not self.KMO and self.ROCh then
            if not self.DriveTimer then self.DriveTimer = CurTime() end
        elseif self.DriveTimer then
            self.DriveTimer = false
        end
        if self.ROCh and self.F5>0 and self.F6==0 and not self.AcceptF5 or self.DriveTimer and CurTime()-self.DriveTimer>7 then
            self.RSS = false
            self.R2O = false
        end

        self.BR2 = self.KB and not self.ROCh and not self.BR1
        self.BR1 = self.KB and (self.BR1 or self.ROCh) and not self.BR2
        self.KSR = (self.KSR or self.RNT) and self.RSS or self.R2O and (self.BR1 and self.ROCh or self.BR2)

        self.RNT = (self.BR1 or self.BR2) or self.RNT and (self.KSR or self.KRT)
        self.RUVD = (self.RUVD or self.KMO) and self.KSR
        --print(self.BrakeTimer)
        if not self.RUVD--[[  and self.ROCh--]]  then
            if not self.BrakeTimer then self.BrakeTimer = CurTime() end
        elseif self.BrakeTimer then
            self.BrakeTimer = false
        end
        self.PTR = (self.BrakeTimer and CurTime()-self.BrakeTimer > 1.5)
        if not self.RNT or not self.RUVD and (Train.Acceleration > -0.8 and speed>3) then
            if not self.EKTimer then self.EKTimer = CurTime() end
        elseif self.EKTimer then
            self.EKTimer = false
        end
        if self.EKTimer and CurTime()-self.EKTimer > 3 then self.EK=false end
        --print(Format("RNT:%s BR1:%s BR2:%s KSR:%s KRT:%s",self.RNT,self.BR1,self.BR2,self.KSR,self.KRT))
        --print(Format("RNT:%s KMO:%s KSR:%s RUVD:%s PTR:%s",self.RNT and 1 or 0,self.KMO and 1 or 0,self.KSR and 1 or 0,self.RUVD and 1 or 0,self.PTR and 1 or 0))
        self.MOT = (self.RUVD and not self.ROD) and 1 or 0
        self.T1 = self.RUVD and 0 or 1
        self.T2 = self.PTR and 1 or 0
        self.Ring = self.RNT and 0 or 1
        self.EPK = self.EK and 1 or 0
        self.V1 = (self.RO and self.KMO) and 1 or 0
        self.V2 = speed<0.5 and self.V1 or 0
    else
        self.Enabled = 0

        --Timers
        self.DriveTimer = false
        self.BrakeTimer = false
        self.EKTimer = false

        self.AcceptF5 = false


        self.ROCh = false
        self.RSS = false
        self.RSS = false
        self.RO = false
        self.EK = false
        self.R2O = false
        self.ROD = false

        self.KSR = false
        self.KMO = false
        self.KRT = false
        self.BR1 = false
        self.BR2 = false
        self.RUVD = false
        self.PTR = false

        self.RNT = false

        self.VRD = false

        self.MOT = 0
        self.T1 = 0
        self.T2 = 0
        self.Ring = 0
        self.EPK = 0
        self.V1 = 0
        self.V2 = 0
    end
end

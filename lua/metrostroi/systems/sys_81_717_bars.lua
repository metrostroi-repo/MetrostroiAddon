--------------------------------------------------------------------------------
-- 81-717 "BARS" safety system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_717_BARS")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("ALSCoil")
    self.Train:LoadSystem("EPKC","Relay")
    self.Train:LoadSystem("ROT1","Relay","",{bass=true})
    self.Train:LoadSystem("ROT2","Relay","",{bass=true})

    self.Power = 0
    self.ARSPower = 0
    self.ALSPower = 0
    self.Speed = 0
    self.SpeedLimit = 0
    self.NextLimit = 0

    self.Enabled = false

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
    self.BR1 = false
    self.BR2 = false
    self.RUVD = false
    self.PTR = false

    self.RNT = false

    self.Rolling = false
    self.Rolled = false

    self.NoFreq = 0
    self.F1 = 0
    self.F2 = 0
    self.F3 = 0
    self.F4 = 0
    self.F5 = 0
    self.F6 = 0

    self.DA = 0
    self.KB = 0
    self.VRD = 0
    self.KRO = 0
    self.KRX = 0
    self.KRT = 0
    self.KT = 0
    --OUT
    self["33G"] = 0
    self["33Zh"] = 0
    self["6"] = 0
    self["8"] = 0
    self.Ring = 0
    self.EPK = 0
    self["48"] = 0
    self.KVD = 0
    self.LKT = 0
end

function TRAIN_SYSTEM:Outputs()
    return {"KVD","Ring","KVD","Speed","NoFreq","F1","F2","F3","F4","F5","F6"}
end

function TRAIN_SYSTEM:Inputs()
    return {}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end

function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    local ALS = Train.ALSCoil
    local speed = ALS.Speed
    local speedS = speed*ALS.SpeedSign
    self.SpeedoTimer = self.SpeedoTimer or CurTime()
    if CurTime()-self.SpeedoTimer > 0.4 then
        local time = (CurTime()-self.SpeedoTimer)
        self.Speed = math.max(0,self.Speed+(speed-self.Speed)*(0.4+math.max(0,math.min((self.Speed-5)*0.2,0.4))))
        self.SpeedoTimer = CurTime()
    end
    if Train.Electric.Type > 4 then return end
    local ARSPower = self.ARSPower
    local ALSPower = self.ALSPower
    if self.ALS ~= ALS.Enabled then
        ALS:TriggerInput("Enable",self.ALS)
    end
    local FreqCode = bit.bor(ALS.F1*1,ALS.F2*2,ALS.F3*4,ALS.F4*8,ALS.F5*16,ALSPower*32,ARSPower*64)
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
            self.NoFreq = (1-math.min(1,(self.F1+self.F2+self.F3+self.F4+self.F5)))*(ALSPower+ARSPower)
        end
    elseif self.FreqCodeTimer then
        self.FreqCodeTimer = nil
    end
    self.F6 = ALS.F6*ALSPower
    if ARSPower>0 and not self.Enabled then
        self.Enabled = speed < 0.1
        self.EK = self.Enabled
        self.OnTimer = CurTime()
    elseif ARSPower>0 then

        local Vzad = 20
        if self.F4 > 0 then Vzad = 40 end
        if self.F3 > 0 then Vzad = 60 end
        if self.F2 > 0 then Vzad = 70 end
        if self.F1 > 0 then Vzad = 80 end
        if Vzad ~= 20 and (self.VRD>0 or self.KB>0) then Vzad = 20 end
        if self.F5 > 0 and self.F6 == 0 and self.VRD>0 and not self.AcceptF5 and speed < 0.1 then
            self.AcceptF5 = true
        elseif self.F5 == 0 or self.F6 > 0 or self.F5>0 and self.VRD==0 then
            self.AcceptF5 = false
        end
        if speed>Vzad-1 then self.ROD = true elseif speed<Vzad-2 then self.ROD = false end
        if speed>5 or not self.ROCh and self.KB>0  then self.RO = false elseif speed<3 then self.RO = true end
        if speed>20 then self.R2O = false elseif speed<19 then self.R2O = true end
        if Vzad<=20 or speed>Vzad then self.RSS = false elseif speed<Vzad-1 then self.RSS = true end
        KRO = self.KRO>0
        KRT = self.KRT>0
        self.ROCh = self.NoFreq == 0

        if self.RO and self.KRH>0 and self.ROCh then
            if not self.DriveTimer then self.DriveTimer = CurTime() end
        elseif self.DriveTimer then
            self.DriveTimer = false
        end
        if self.ROCh and self.F5>0 and self.F6==0 and not self.AcceptF5 or self.DriveTimer and CurTime()-self.DriveTimer>7 then
            self.RSS = false
            self.R2O = false
        end
--[[
        if speedS < -0.05 and not self.Rolling then self.Rolling = 0 end
        if self.Rolling and self.Rolling < 0 then self.Rolling = false end
        if self.Rolling then
            local rolled = -speedS/3600*1000*dT
            if math.abs(rolled) >0.001 then
                self.Rolling = self.Rolling + rolled
            end
        end

        if not self.Rolled and self.Rolling and self.Rolling > 0.5+self.KRH*2.5 then
            self.Rolled = self.KRH
        end
        if self.Rolled then
            if self.Rolled == 0 and self.KRH > 0 then
                self.Rolled = false
                self.Rolling = false
            end
            if self.KRH == 0 then self.Rolled = 0 end
        end
--]]
        self.BR2 = self.KB>0 and not self.ROCh and (not self.BR1 or not self.OldF5)
        self.BR1 = self.KB>0 and (self.BR1 or self.ROCh) and not self.BR2
        self.KSR = not self.OnTimer and ((self.KSR or self.RNT) and self.RSS or self.R2O and (self.BR1 and self.ROCh or self.BR2))
        self.OldF5 = self.F5>0

        self.RNT = (self.BR1 or self.BR2) or self.RNT and (self.KSR or KRT and (not self.RUVD or self.R2O))
        self.RUVD = (self.RUVD or self.KRH==0) and self.KSR
        if not self.RUVD--[[  and self.ROCh--]]  then
            if not self.BrakeTimer then self.BrakeTimer = CurTime() end
        elseif self.BrakeTimer then
            self.BrakeTimer = false
        end
        self.PTR = (self.BrakeTimer and (self.DA==0 --[[ or not self.ROCh--]]  or CurTime()-self.BrakeTimer > 1.5))
        if not self.RNT or (not self.RUVD or self.RO and self.KRH==0) and self.KT==0 then
            if not self.EKTimer then self.EKTimer = CurTime() end
        elseif self.EKTimer then
            self.EKTimer = false
        end
        if self.EKTimer and CurTime()-self.EKTimer > ((10<speed and speed<30) and 5.5 or 3.3) then self.EK=false end
        --print(Format("RNT:%s BR1:%s BR2:%s KSR:%s KRT:%s",self.RNT,self.BR1,self.BR2,self.KSR,KRT))
        --print(Format("RNT:%s KRO:%s KSR:%s RUVD:%s PTR:%s",self.RNT and 1 or 0,KRO and 1 or 0,self.KSR and 1 or 0,self.RUVD and 1 or 0,self.PTR and 1 or 0))
        self["33G"] = (self.RUVD and not self.ROD and not self.Rolled) and self.DA or 0
        self["33Zh"] = self.ROD and 0 or 1

        self.KVD = math.min(1,(1-self["33G"])+self.KVD*(self.KRT+self.KRH))
        self["33G"] = self["33G"]*(1-self.KVD)

        self["6"] = self.RUVD and 0 or self.DA
        self["8"] = (self.PTR or self.Rolled) and 1 or 0
        self.Ring = self.RNT and 0 or 1
        self.EPK = self.EK and 1 or 0
        self["48"] = (self.RO and self.KRH==0 or not KRT and self.BrakeTimer and CurTime()-self.BrakeTimer < 0.8 or self.Rolled) and 1 or 0
        self.LKT = 1
        if self.OnTimer and CurTime()-self.OnTimer>0.05 then self.OnTimer = false end
    else
        self.Enabled = false

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
        self.BR1 = false
        self.BR2 = false
        self.RUVD = false
        self.PTR = false

        self.RNT = false


        self.KRO = 0
        self.KRX = 0
        self.KRT = 0

        self["33G"] = 0
        self["33Zh"] = 0
        self.KVD = 0
        self["6"] = 0
        self["8"] = 0
        self.Ring = 0
        self.EPK = 0
        self["48"] = 0
        self.LKT = 0
        self.OnTimer = false
    end
end

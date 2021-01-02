--------------------------------------------------------------------------------
-- ARS-MP safety system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("ARS_MP")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("UOS","Relay","Switch", {bass = true})
    self.Train:LoadSystem("ALSFreq","Relay","Switch",{bass=true})
    self.Train:LoadSystem("AB1","Relay","Switch",{bass=true})
    self.Train:LoadSystem("AB2","Relay","Switch",{bass=true})
    self.Train:LoadSystem("EPKContacts","Relay","",{close_time = 3})
    self.Train:LoadSystem("ROT1","Relay","", { bass = true})
    self.Train:LoadSystem("ROT2","Relay","", { bass = true})

    self.Train:LoadSystem("EPKC","Relay")
    -- Internal state
    self.SpeedLimit = 0
    self.NextLimit = 0
    self.AB = 0
    self.AV = 0
    self.AV1 = 0
    self.ARSRing = 0
    self.KRT = 0
    self.KRO = 0
    self.KRH = 0
    --[[ self.Overspeed = false
    self.RUVD = false
    self.PneumaticBrake1 = false
    self.PneumaticBrake2 = true
    self.AttentionPedal = false--]]

    self.KVT = false
    self.LN = 0
    self["2"] = 0
    self["25"] = 0
    self["20"] = 0
    self["33G"] = 0
    self["33"] = 0
    self["17"] = 0
    self["8"] = 0
    self["44"] = 0
    self["48"] = 0

    self.EK = 1

    self.F6 = 0
    self.F5 = 0
    self.PrevF5 = 0
    self.F4 = 0
    self.F3 = 0
    self.F2 = 0
    self.F1 = 0
    self.NoFreq = 0
    self.PrevNoFreq = 0

    self.ARS = 0
    self.AB = 0
    self.AV = 0
    self.AV1 = 0

    self.ABReady = 0

    -- Lamps
    ---self.LKT = false
    self.LVD = 0
    self.Ring = 0
end

function TRAIN_SYSTEM:Outputs()
    return {
        --"2","25","20","33G","33","17","8","44","48",
        "NoFreq","F1","F2","F3","F4","F5","F6","LN","ARS","AB","KT","LVD","ABReady"
    }
end

function TRAIN_SYSTEM:Inputs()
    return { "IgnoreThisARS","AttentionPedal","Ring" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end


function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    local ALS = Train.ALSCoil
    local speed = math.Round(ALS.Speed or 0,1)

    local power = self.GE > 0
    local TwoToSix = self.Freq  > 0
    -- ALS, ARS state

    if power and not self.EnableARSTimer then
        self.EnableARSTimer = CurTime()+1+math.random()*9
    elseif not power and self.EnableARSTimer then
        self.EnableARSTimer = nil
    end

    if ALS.Enabled~=self.ALS then
        ALS:TriggerInput("Enable",self.ALS)
    end
    local Power = self.EnableARSTimer and CurTime()-self.EnableARSTimer > 0

    local KVT = self.KB > 0

    local F1 = ALS.F1*self.ALS
    local F2 = ALS.F2*self.ALS
    local F3 = ALS.F3*self.ALS
    local F4 = ALS.F4*self.ALS
    local F5 = ALS.F5*self.ALS
    local F6 = ALS.F6*self.ALS
    local FreqCount = F1+F2+F3+F4+F5+F6
    local TwoFreq = FreqCount==2
    if self.AB > 0 then
        if FreqCount>0 then self.AB = 0 end
        F1 = 1
        F2 = 0
        F3 = 0
        F4 = 0
        F5 = 0
        F6 = 0
    elseif TwoToSix and not TwoFreq then
        F1 = 0
        F2 = 0
        F3 = 0
        F4 = math.min(1,F1+F2+F3+F4)
    elseif not TwoToSix and TwoFreq then
        F1 = 0
        F2 = 0
        F3 = 0
        F4 = 0
        F5 = 0
        F6 = 0
    end
    local FreqCode = bit.bor(F1*1,F2*2,F3*4,F4*8,F5*16,F6*32,self.ALS*64,self.GE*128)
    if self.FreqCode ~= FreqCode then
        if not self.FreqCodeTimer then self.FreqCodeTimer = CurTime() end
        if self.FreqCodeTimer and CurTime()-self.FreqCodeTimer>0.8 then
            self.FreqCode = FreqCode
            self.FreqCodeTimer = nil

            self.F1 = F1
            self.F2 = F2
            self.F3 = F3
            self.F4 = F4
            self.F5 = F5
            self.F6 = F6
            self.NoFreq = (1-math.min(1,(self.F1+self.F2+self.F3+self.F4+self.F5+self.F6)))*math.min(1,self.ALS+self.GE)
        end
    elseif self.FreqCodeTimer then
        self.FreqCodeTimer = nil
    end
    if power or self.ALS > 0 --[[ or self.AB > 0--]]  then
        local Vlimit = 20
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

        if self.F4 > 0 and self.F6 > 0 then
            self.NG = true
        end
        if TwoToSix and self.LN==0 and self.AB==0 then self.SpeedLimit=20 end
        if KVT and self.SpeedLimit <= 40 then self.SpeedLimit = 20 end
        if KVT and self.SpeedLimit > 40 then self.SpeedLimit = 40 end
    else
        self.F1 = 0
        self.F2 = 0
        self.F3 = 0
        self.F4 = 0
        self.F5 = 0
        self.F6 = 0
        self.SpeedLimit = 0
        self.NextLimit = 0
        self.NoFreq = 0
        self.FreqCodeTimer = nil
        self.FreqCode = 0
    end
    if Power then
        self.ABReady = self.NoFreq*(1-self.AB)
        local ABAccept = self.NoFreq--[[ *ALS.Enabled--]]  > 0
        if ABAccept and not self.ABPressed1 and Train.AB1.Value > 0 then self.ABPressed1 = CurTime() end
        if ABAccept and not self.ABPressed2 and Train.AB2.Value > 0 then self.ABPressed2 = CurTime() end
        if not ABAccept or Train.AB1.Value == 0 then self.ABPressed1 = nil end
        if not ABAccept or Train.AB2.Value == 0 then self.ABPressed2 = nil end
        if self.ABPressed1 and self.ABPressed2 and math.abs(self.ABPressed1-self.ABPressed2) < 1 then
            self.AB = 1
        end
        self.ARS = 1-self.AB
        local NoFreq = (self.Freq>0 and self.LN==0) or self.NoFreq>0
        self.BR2 = KVT and NoFreq and not self.BR1
        self.BR1 = KVT and (self.BR1 or not NoFreq) and not self.BR2


        local SpeedLimit = self.SpeedLimit
        if (speed > SpeedLimit) and not self.RUVD or SpeedLimit<=20 and not (self.BR1 or self.BR2) then
            self.RUVD = true
            self.RNT = self.RNT or self.KRT==0
        elseif speed < SpeedLimit-0.5 and self.RUVD and not self.RNT then
            self.RUVD = false
        end
        if (self.BR1 or self.BR2) and self.RNT then
            self.RNT = false
        end
        if self.RO==true and self.KRH > 0 then
            self.RO = CurTime()
        end
        if self.RO and self.RO~=true and CurTime()-self.RO >7 then
            self.RO = false
            if speed<5 and not NoFreq then self.ROBrake = true end
        end
        if self.RO and speed > 5 then self.RO = false end
        if self.RO~=true and speed <= 5 and self.KRH == 0 then self.RO = true end
        if self.RO and self.BR2 then self.RO = false end

        if self.RUVD then
            if not self.PN1Timer then self.PN1Timer = CurTime()+3.5-math.max(0,(speed-20))/60*2.5 end
            if not self.TW8Timer then self.TW8Timer = self.SpeedLimit<=20 and CurTime()-3 or CurTime() end
        end
        if not self.RUVD then
            if self.PN1Timer then self.PN1Timer = false end
            if self.TW8Timer then self.TW8Timer = false end
        end

        local brake = (self.RUVD or self.ROBrake) and 1 or 0
        local pn1 = (self.RO == true or (self.PN1Timer and CurTime()-self.PN1Timer < 0)) and 1 or 0
        local pn2 = (self.TW8Timer and CurTime()-self.TW8Timer > 2.7) and 1 or 0

        self["33"] = (1-self.LVD)
        self["33G"] = brake
        self["17"] = (1-self.LVD)
        self["2"] = brake*self.KRT
        self["20"] = brake
        self["25"] = (1-self.LVD)
        self["44"] = pn1
        self["48"] = pn1
        self["8"] = brake*pn2
        self.Ring = self.RNT and 1 or 0

        local delay = 3.5
        if 10 < speed and speed < 30 then delay = 5.5 end
        if speed < 3 then delay = 10 end
        if (self.RUVD or speed<5 and not NoFreq) and self.KT == 0 then
            if not self.EPKTimer then self.EPKTimer = CurTime() end
        else
            self.EPKTimer = nil
        end
        if self.EPKTimer and CurTime()-self.EPKTimer > delay then
            self.EK = 0
        end
        self.LVD = math.min(1-self.KRO,self.LVD+brake)
        self.LN = self.NG and self.Freq or 0
    else
        self.BR1 = 0
        self.BR2 = 0
        self.EK = 1
        self.AB = 0
        self.ARS = 0
        self.LN = 0
        self.NG = false
        self.ABPressed1 = nil
        self.ABPressed2 = nil
        self.Ring = 0
        self.ROBrake = false
        self.LVD = 0
        self.ABReady = 0

        self.RUVD = true
        self.RNT = true

        self["33"] = 0
        self["33G"] = 0
        self["17"] = 0
        self["2"] = 0
        self["20"] = 0
        self["25"] = 0
        self["44"] = 0
        self["48"] = 0
        self["8"] = 0
    end


    self.EPK = self.GE*self.EK
    --Train:WriteTrainWire(90,self.EPK*(1-Train.ARS.Value))
    --Train.EPKC:TriggerInput("Set",self.EPK+Train:ReadTrainWire(90))
    Train.EPKC:TriggerInput("Set",self.EPK)
end

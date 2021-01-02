--------------------------------------------------------------------------------
-- 81-718 power supply unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_718_BBE")

function TRAIN_SYSTEM:Initialize()
    self.Active = 0
    self.KM1 = 0
    self.KM2 = 0

    self.KMPower = 0

    self.Activate = 0
    self.Deactivate = 0
    self.Error = 0
end

function TRAIN_SYSTEM:Inputs()
    return { "Enable"  }
end

function TRAIN_SYSTEM:Outputs()
    return { "KM1","KM2" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "Enable" then
        self.Active = 1
    end
end

function TRAIN_SYSTEM:Think()
    local Train = self.Train
    if self.Activate > 0 then self.Active = 1 end
    if self.Deactivate > 0 then self.Active = 0 end
    if self.Power == 0 or self.Active == 0 then
        self.KM1 = 0
        self.KM2 = 0
        return
    end


    if Train.Electric.Main750V > 200 then
        self.KM1 = self.Active*self.KMPower
        self.KM2 = self.KMPower*self.KM2Power
    else
        self.KM1 = 0
    end

    if self.KM1 == 0 and self.KM2 > 0 and (not self.LightTimer) then
        self.LightTimer = CurTime()
    end
    if (self.KM1 > 0 or self.KM2 == 0) and self.LightTimer then
        self.LightTimer = nil
    end
    if self.LightTimer and CurTime()-self.LightTimer > 27 then
        self.KM2 = 0
    end
end

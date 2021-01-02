--------------------------------------------------------------------------------
-- SPB Anti rolling unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_502_BPS")

function TRAIN_SYSTEM:Initialize()
    self.Power = 0

    self.KRR = 0
    self.KRH = 0

    self[8] = 0
    self[39] = 0

    self.PowerLamp = 0
    self.ErrorLamp = 0
    self.FailLamp = 0
    self.Rolling = false
    self.Rolled = false
end

function TRAIN_SYSTEM:Inputs()
    return {}
end
function TRAIN_SYSTEM:Outputs()
    return { "PowerLamp","ErrorLamp","FailLamp" }
end

function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    if Train.Electric.Type ~= 1 then return end
    local ALS = Train.ALSCoil
    local speed = ALS.Speed*ALS.SpeedSign


    local Work = self.Power*(1-self.KRR)
    self.FailLamp = 0

    if Work > 0 then
        if speed < -0.05 and not self.Rolling then self.Rolling = 0 end
        if self.Rolling and self.Rolling < 0 then self.Rolling = false end
        if self.Rolling then
            local rolled = -speed/3600*1000*dT
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
        self.ErrorLamp = (self.Rolling and self.Rolling > 0.1 or self.KRH > 0 and speed <= 0.05) and 1 or 0
        self.PowerLamp = 1-self.ErrorLamp
    else
        self.PowerLamp = 0
        self.ErrorLamp = 0
        self.Rolling = false
        self.Rolled = false
    end

    self[8] = self.Rolled and 1 or 0
    self[39] = self.Rolled and 1 or 0
end

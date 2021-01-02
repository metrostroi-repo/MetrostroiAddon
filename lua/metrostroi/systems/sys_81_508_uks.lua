--------------------------------------------------------------------------------
-- 81-508 UKS system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_508_UKS")

function TRAIN_SYSTEM:Initialize(parameters)
    self.UKSEngaged = 0
    self.UKSTriggered = 0
    self.UKSEmerTriggered = 0
    self.Train:LoadSystem("UKSDisconnect","Relay","Switch", {bass = true,normally_closed = true})
end

function TRAIN_SYSTEM:Outputs()
    return { "UKSEngaged", "UKSTriggered", "UKSEmerTriggered" }
end

function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    self.UKSEngaged = Train.UAVA.Value*Train.UKSDisconnect.Value
    if self.UKSEngaged > 0 then
        local speed = Train.ALSCoil.Speed*Train.ALSCoil.SpeedSign
        if speed > 34 then
            self.UKSTriggered = 1
            if speed > 40 then
                self.UKSEmerTriggered = 1
            end
        elseif speed < 31 and self.UKSEmerTriggered == 0 then
            self.UKSTriggered = 0
            self.UKSEmerTriggered = 0
        elseif speed < 1 then
            self.UKSTriggered = 0
            self.UKSEmerTriggered = 0
        end
    else
        self.UKSTriggered = 0
        self.UKSEmerTriggered = 0
    end
end

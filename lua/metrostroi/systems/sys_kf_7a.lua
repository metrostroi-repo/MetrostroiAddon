--------------------------------------------------------------------------------
-- HV Rheostats (KF-7A) for 81-702
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("KF_7A")

function TRAIN_SYSTEM:Initialize()
    self.Resistors = {
        ["P20-P21"] = 0.169,
        ["P21-P22"] = 0.019,
        ["P23-P24"] = 0.169,
        ["P24-P25"] = 0.019,
    }

    for k,v in pairs(self.Resistors) do
        self[k] = v
    end
end
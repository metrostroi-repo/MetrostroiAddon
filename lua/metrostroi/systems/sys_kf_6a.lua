--------------------------------------------------------------------------------
-- HV Rheostats (KF-6A) for 81-702, used on underground subway lines
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("KF_6A")

function TRAIN_SYSTEM:Initialize()
    self.Resistors = {
        ["P1-P2"] = 0.333,
        ["P2-P3"] = 0.25,
        ["P3-P4"] = 0.221,
        ["P4-P11"] = 0.19,
        ["P10-P13"] = 0.441,
        ["P13-P11"] = 2.205,
        ["P12-P11"] = 1.185,
        ["P9-P10"] = 0.197,
        ["P8-P9"] = 0.208,
        ["P7-P8"] = 0.263,
        ["P6-P7"] = 0.331,
        ["P14-P1"] = 0.5+0.07,
    }
    self.ResistorTemperatures = {
        ["P1-P2"] = 1,
        ["P2-P3"] = 1,
        ["P3-P4"] = 1,
        ["P4-P11"] = 1,

        ["P9-P10"] = 2,
        ["P8-P9"] = 2,
        ["P7-P8"] = 2,
        ["P6-P7"] = 2,
    }
    self.Overheating = {}

    for k,v in pairs(self.Resistors) do
        self[k] = v
        self.Overheating[k] = 0
    end
end

function TRAIN_SYSTEM:Think(dT)
    -- Temperature coefficient
    local a = 0.0001

    -- Update resistances
    if self.Train.Electric then
        for k,v in pairs(self.ResistorTemperatures) do
            -- Get temperature
            local T = self.Train.Electric["T"..v] or 25
            local O = self.Train.Electric["Overheat"..v] or 0

            -- Calculate new resistance
            self[k] = self.Resistors[k]*(1.0 + a*(T-25) - math.log(1-O))
        end
    end
end
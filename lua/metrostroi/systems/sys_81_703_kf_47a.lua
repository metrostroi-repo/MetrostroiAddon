--------------------------------------------------------------------------------
-- HV rheostats case (KF-47a) for 81-703
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_703_KF_47A")

function TRAIN_SYSTEM:Initialize()
    self.Resistors = {
        ["L1-L2"] = 0.84,
        ["L4-L5"] = 1.46,
        ["P1-P3"]   = 0.70+0.09,
        ["P3-P4"]   = 0.13,
        ["P4-P5"]   = 0.224,
        ["P5-P6"]   = 0.184,
        ["P6-P7"]   = 0.224,
        ["P7-P8"]   = 0.224,
        ["P8-P9"]   = 0.183,
        ["P9-P10"]  = 0.13,
        ["P10-P11"] = 0.136,
        ["P11-P12"] = 1.004,
        ["P12-P13"] = 0.57,
        ["P11-P14"]  = 0.59,

        ["P15-P16"] = 0.31,
        ["P16-P17"] = 1.15,
        ["P17-P18"] = 0.13,
        ["P18-P19"] = 0.224,
        ["P19-P20"] = 0.184,
        ["P20-P21"] = 0.224,
        ["P21-P22"] = 0.224,
        ["P22-P23"] = 0.184,
        ["P23-P24"] = 0.13,
        ["P24-P25"] = 0.13,
        ["P25-P26"] = 0.79,
        ["P25-P27"] = 0.59,
    }
    self.ResistorTemperatures = {
        ["L1-L2"] = 1,
        ["L4-L5"] = 1,
        ["P1-P3"]   = 1,
        ["P3-P4"]   = 1,
        ["P4-P5"]   = 1,
        ["P5-P6"]   = 1,
        ["P6-P7"]   = 1,
        ["P7-P8"]   = 1,
        ["P8-P9"]   = 1,
        ["P9-P10"]  = 1,
        ["P10-P11"] = 1,
        ["P11-P12"] = 1,
        ["P12-P13"] = 1,
        ["P11-P14"]  = 1,

        ["P15-P16"] = 2,
        ["P16-P17"] = 2,
        ["P17-P18"] = 2,
        ["P18-P19"] = 2,
        ["P19-P20"] = 2,
        ["P20-P21"] = 2,
        ["P21-P22"] = 2,
        ["P22-P23"] = 2,
        ["P23-P24"] = 2,
        ["P24-P25"] = 2,
        ["P25-P26"] = 2,
        ["P25-P27"] = 2,
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
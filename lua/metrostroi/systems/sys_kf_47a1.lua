--------------------------------------------------------------------------------
-- HV Rheostats (KF-47A1)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("KF_47A1")

function TRAIN_SYSTEM:Initialize()
    self.Resistors = {
        ["L12-L13"] = 1.730,
        ["P13_12"] = 0.485,
        ["P12_11"] = 0.945,
        ["P10_9"] = 0.144,
        ["P9_8"] = 0.19,
        ["P8_7"] = 0.22,
        ["L8_P1"] = 2.0835,--2.016,--1.9
        ["L8_6"] =  0.49,--0.485
        ["P11_10"] = 0.144,--0.123-0.05, --P11-10
        ["P27"] = 2.66,--2.95
        ["L12_P76"] = 0.367*0.6,--0.367,--0.485
        ["P24_25"] = 0.145*0.6,--0.145,--0.144
        ["P4_6"] = 0.12,
        ["P6_7"] = 0.22,
        ["P3_4"] = 0.144,
        ["P17_18"] = 0.12,
        ["P18_20"] = 0.19,
        ["P20_21"] = 0.22,
        ["P21_22"] = 0.22,
        ["P22_23"] = 0.19,
        ["P23_24"] = 0.144,
        ["P25_26"] = 0.711,
    }
    self.ResistorTemperatures = {
        ["L12-L13"] = 1,
        ["P13_12"] = 1,
        ["P12_11"] = 1,
        ["P10_9"] = 1,
        ["P9_8"] = 1,
        ["P8_7"] = 1,
        ["L8_P1"] = 1,
        ["L8_6"] = 1,
        ["P11_10"] = 1,
        ["P27"] = 1,
        ["L12_P76"] = 1,
        ["P24_25"] = 1,
        ["P4_6"] = 1,
        ["P6_7"] = 1,
        ["P3_4"] = 1,
        ["P17_18"] = 1,
        ["P18_20"] = 1,
        ["P20_21"] = 1,
        ["P21_22"] = 1,
        ["P22_23"] = 1,
        ["P23_24"] = 1,
        ["P25_26"] = 1,

        ["P13_12"] = 1,
        ["P12_11"] = 1,
        ["P10_9"] = 1,
        ["P9_8"] = 1,
        ["P8_7"] = 1,
        ["L8_P1"] = 1,
        ["L8_6"] = 1,
        ["P11_10"] = 1,
        ["P27"] = 1,
        ["L12_P76"] = 1,
        ["P24_25"] = 1,
        ["P4_6"] = 1,
        ["P6_7"] = 1,
        ["P3_4"] = 1,
        ["P17_18"] = 1,
        ["P18_20"] = 1,
        ["P20_21"] = 1,
        ["P21_22"] = 1,
        ["P22_23"] = 1,
        ["P23_24"] = 1,
        ["P25_26"] = 1,
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
--------------------------------------------------------------------------------
-- HV Rheostats (KF-47A)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("KF_47A")

function TRAIN_SYSTEM:Initialize()
    self.Resistors = {
        ["L12-L13"] = 1.730,
        ["P1-P3"]   = 0.715,
        ["P3-P4"]   = 0.144,
        ["P4-P5"]   = 0.223,
        ["P5-P6"]   = 0.190,
        ["P6-P7"]   = 0.223,
        ["P7-P8"]   = 0.223,
        ["P8-P9"]   = 0.190,
        ["P9-P10"]  = 0.144,
        ["P10-P11"] = 0.144,
        ["P11-P12"] = 1.070,
        ["P12-P13"] = 0.485,
        
        ["P3-P14"]  = 1.622,
        ["P13-P42"] = 0.285,

        ["P16-P17"] = 0.485,
        ["P17-P18"] = 0.120,
        ["P18-P19"] = 0.223,
        ["P19-P20"] = 0.190,
        ["P20-P21"] = 0.223,
        ["P21-P22"] = 0.223,
        ["P22-P23"] = 0.190,
        ["P23-P24"] = 0.144,
        ["P24-P25"] = 0.144,
        ["P25-P26"] = 0.714,
        ["P17-P76"] = 0.244,
        ["P76-P27"] = 1.710,

        ["L2-L4"]   = 1.140,
        ["L24-L39"] = 0.970,
        ["L40-L63"] = 0.970,
    }
    self.ResistorTemperatures = {
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
        ["P1-P3"]   = 1,
        ["P3-P14"]  = 1,
        ["P13-P42"] = 1,

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
        ["P17-P76"] = 2,
        ["P76-P27"] = 2,
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
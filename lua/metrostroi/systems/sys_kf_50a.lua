--------------------------------------------------------------------------------
-- HV Rheostats (KF-50A)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("KF_50A")

function TRAIN_SYSTEM:Initialize()
    self.Resistors = {
        ["L25-P37"] = 0.282, --703
        ["P35-K2"]  = 0.042,
        ["L26-P31"] = 0.282, --703

        --[[ Train.KF_50A--]] ["P29-P28"] = 0.052,
        --[[ Train.KF_50A--]] ["P30-P29"] = 0.01125,
        --[[ Train.KF_50A--]] ["P31-P30"] = 0.01625,
        --[[ Train.KF_50A--]] ["L76-P31"] = 0.0325,
        --[[ Train.KF_50A--]] ["P35-L18"] = 0.052,
        --[[ Train.KF_50A--]] ["P36-P35"] = 0.01125,
        --[[ Train.KF_50A--]] ["P37-P36"] = 0.01625,
        --[[ Train.KF_50A--]] ["L74-P37"] = 0.0325,
    }

    for k,v in pairs(self.Resistors) do
        self[k] = v
    end
end
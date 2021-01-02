--------------------------------------------------------------------------------
-- "BPSN" Power supply
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("BPSN")

function TRAIN_SYSTEM:Initialize()
    self.X2 = {
        [2] = 0,
        [3] = 0,
        [4] = 0,
        [5] = 0, -- Out only
        [6] = 0,
        [7] = 0,
    }
    self.X2_2 = 0
    self.X6_2 = 0
    self.X2_1 = 0

    self.Active = 0
    self.Train:LoadSystem("ConverterProtection","Relay","Switch", {bass = true})
end

function TRAIN_SYSTEM:Inputs()
    return { "5x2", "6x2", "7x2", "2x2" }
end

function TRAIN_SYSTEM:Outputs()
    return { "X2_2", "X6_2" }
end


function TRAIN_SYSTEM:TriggerInput(name,value)
    local idx = tonumber(name:sub(1,1)) or 0
    if self.X2[idx] then
        self.X2[idx] = value > 0.5 and 1.0 or 0
    end
end

function TRAIN_SYSTEM:Think()
    local Train = self.Train
    -- Get high-voltage input
    self.X2_1 = Train.KPP.Value * (1-Train.RZP.Value) -- P4
    -- Get battery input
    local XT3_1 = self.X2[5]*self.X2_1
    if Train.Electric.Aux750V*self.X2_1 > 975 then
        Train.RZP:TriggerInput("Close",1)
        self.X2_1 = 0
        XT3_1 = 0
    end

    -- Check if enable signal is present
    self.Active = XT3_1>0 and 1 or 0
    self.X2_2 = Train.Electric.Aux750V*self.Active
    self.X6_2 = self.Active
end
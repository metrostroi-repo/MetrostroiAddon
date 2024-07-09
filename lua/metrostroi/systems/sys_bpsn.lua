--------------------------------------------------------------------------------
-- "BPSN" Power supply
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("BPSN")
TRAIN_SYSTEM.DontAccelerateSimulation = true

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

    self.OutputVoltage              = 76        -- volts
    self.IResistance                = 0.01      -- Ohm (сам выдумал, примерно на полтора порядка ниже, чем у АКБ)
    self.car_control_load           = 0         -- Amp
    self.Icosume                    = 0         -- 3rd rail current consumption, amp
    self.Iout                       = 0         -- output current, amp
    self.VoltageOut                 = 0

    self.Active = 0
    self.Train:LoadSystem("ConverterProtection","Relay","Switch", {bass = true})
end

function TRAIN_SYSTEM:Inputs()
    return { "5x2", "6x2", "7x2", "2x2" }
end

function TRAIN_SYSTEM:Outputs()
    return { "X2_2", "X6_2", "car_control_load", "VoltageOut", "OutputVoltage", "Icosume", "Iout" }
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
    -- X2_1 now indicates that primary converter is operating
    self.X2_1 = (Train.Electric.Aux750V > 550 and 1 or 0) * Train.KPP.Value * (1-Train.RZP.Value)
    if Train.Electric.Aux750V >= 550 then
        self.VoltageOut = self.X2_1*(self.OutputVoltage + (Train.Electric.Aux750V - 550)*8/425)
    else
        self.VoltageOut = math.max(0,self.X2_1*(Train.Electric.Aux750V - 300)*76/300)
    end
    self.Icosume = Train.NR.Value*self.VoltageOut*self.Iout/(Train.Electric.Aux750V > 0 and Train.Electric.Aux750V or 1)
    
    -- Get battery input
    local XT3_1 = self.X2[5]*self.X2_1
    if Train.Electric.Aux750V*self.X2_1 > 975 or self.Icosume > 28 then     -- should be 25 - 30 amp
        Train.RZP:TriggerInput("Close",1)
        --print("self.Icosume = "..self.Icosume, "Train.Electric.Aux750V = "..Train.Electric.Aux750V, "self.Iout = "..self.Iout)
        --print("Train.Battery.eds_eq = "..Train.Battery.eds_eq, "self.VoltageOut = "..self.VoltageOut)
        self.X2_1 = 0
        XT3_1 = 0
    end
    -- Check if enable signal is present
    self.Active = XT3_1>0 and 1 or 0
    self.X2_2 = Train.Electric.Aux750V*self.Active      -- radio, asnp etc.
    self.X6_2 = Train.KVP.Value--self.Active            -- mainlights
end
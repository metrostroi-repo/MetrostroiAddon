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

    self.OutputVoltage              = 76                    -- volts
    self.IResistance                = 0.01                  -- Ohm (сам выдумал, примерно на полтора порядка ниже, чем у АКБ)
    self.Icosume                    = 0                     -- 3rd rail current consumption, amp
    self.Iout                       = 0                     -- output current, amp
    self.VoltageOut                 = 0
    self.ISumpSetpoint              = math.random(25,30)    -- overload consumption current protection setpoint
    self.EnvTemp                    = 20                    -- Celcius degree
    self.Temp                       = self.EnvTemp          -- internal temperature
    self.TempThreshold              = 90                    -- overheat protection threshold
    self.TempHyst                   = 5                     -- temperature threshold hysteresis

    self.Q                          = 0
    self.Q_p                        = 0
    self.Q_i                        = 0

    self.Active = 0
    self.Train:LoadSystem("ConverterProtection","Relay","Switch", {bass = true})
end

function TRAIN_SYSTEM:Inputs()
    return { "5x2", "6x2", "7x2", "2x2" }
end

function TRAIN_SYSTEM:Outputs()
    return { "X2_2", "X6_2", "VoltageOut", "OutputVoltage", "Icosume", "Iout", "Temp" }
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
    self.X2_1 = (Train.Electric.Aux750V > 300 and 1 or 0) * Train.KPP.Value * (1-Train.RZP.Value)
    if Train.Electric.Aux750V >= 550 then
        self.VoltageOut = self.X2_1*(self.OutputVoltage + (Train.Electric.Aux750V - 550)*8/425)
    else
        self.VoltageOut = math.max(0,self.X2_1*(Train.Electric.Aux750V - 300)*76/300)
    end

    self.Icosume = self.VoltageOut*self.Iout/(Train.Electric.Aux750V > 0 and Train.Electric.Aux750V or 1)
    
    -- temperature calculations (ugly af)
    --local alpha_p = math.exp(-0.025*(self.Temp - self.EnvTemp)+1.2)
    --self.dQ = self.Icosume^2*self.IResistance*Train.DeltaTime
    ----self.Q = self.Q + self.dQ
    --self.Q_i = 4*math.exp(0.04*(self.Temp - self.EnvTemp)-4.6)
    --self.Q_p = alpha_p*self.dQ
    --self.Temp = math.min(120, math.max(self.EnvTemp,self.Temp + self.Q_p - self.Q_i*Train.DeltaTime))
    --self.Temp = 20

    -- Get battery input
    local XT3_1 = self.X2[5]*self.X2_1
    if Train.Electric.Aux750V*self.X2_1 > 975 or self.Icosume > self.ISumpSetpoint then
        Train.RZP:TriggerInput("Close",1)
        --print "-------------------------------------------------------------------------------------------\n"
        --print(Format("Сработала защита БПСН вагона %s:",Train.WagonNumber))
        --print(Format("I потр = %.2f A\tI вых = %.2f A\tI уст = %.2f A\tU кс = %.1f B", self.Icosume, self.Iout, self.ISumpSetpoint, Train.Electric.Aux750V))
        --print("Train.Battery.eds_eq = "..Train.Battery.eds_eq, "self.VoltageOut = "..self.VoltageOut)
        self.X2_1 = 0
        XT3_1 = 0
    end
    -- Check if enable signal is present
    self.Active = XT3_1>0 and 1 or 0
    self.X2_2 = Train.Electric.Aux750V*self.Active      -- radio, asnp etc.
    self.X6_2 = Train.KVP.Value--self.Active            -- mainlights
end
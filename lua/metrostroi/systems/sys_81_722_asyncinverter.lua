--------------------------------------------------------------------------------
-- 81-722 async inverter and motors
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_722_AsyncInverter")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize()
    -- Train state/sensors
    self.Voltage = 750              -- External voltage
    self.Speed = 0                  -- Speed of train in km/h

    -- Physics state
    self.RotationRate = 0.0         -- Rate of engine rotation, rpm
    self.Torque = 0.0               -- Relative units of torque
    self.TargetTorque = 0.0         -- Target torque, that inverter will hold

    -- Inverter state
    self.Mode = 0                   -- 0: coast, 1: drive, -1: brake
    self.Power = 0
    self.EDone = 0
    self.State = 0.0                -- Inverter on/off
    self.InverterFrequency = 0.0    -- Output per-phase frequency, Hz
    self.InverterVoltage = 0.0      -- Output per-phase voltage, V
    --self.InverterGenFrequency = 0.0   -- Invertors generator frequency, Hz
    self.Current = 0.0              -- Total electric current, A

    -- Inverter input signals
    self.Voltage = 750              -- Third rail voltage
    self.Drive = 0                  -- Drive mode signal
    self.Brake = 0                  -- Brake model signal
    self.State = 0                  -- Power level (PWM)
    self.Power1 = 0
    self.Power2 = 0
    self.Power3 = 0
end

function TRAIN_SYSTEM:Inputs()
    return { "Voltage", "Speed",
             "Drive", "Brake", "Power",}
end

function TRAIN_SYSTEM:Outputs()
    return { "Drive","Brake","Mode","Torque", "Current", "State", "InverterFrequency","EDone","Power" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if self[name] then self[name] = value end
end

local function lerp(min,max, alpha)
    return min + math.min(1,math.max(0,alpha))*(max-min)
end
local function interpolate(tbl, num)
  for i=1,#tbl do
    local curr,next = tbl[i],tbl[i+1]
    if not next then
      return curr[2]
    elseif curr[1] <= num and num <= next[1] then
      return curr[2] + (next[2]-curr[2])*((num-curr[1])/(next[1]-curr[1]))
    end
  end
end
TRAIN_SYSTEM.xF = {
    {
        {
            {0, 0.80},
            {1, 1.57},
            {2, 2.90},
            {3, 4.25},
            {5, 7.01},
            {7, 9.83},
            {10, 14.19},
            {12, 17.20},
            {13, 18.70},
            {15, 21.80},
            {17, 24.25},
            {18, 25.45},
            {19, 26.70},
            {20, 27.90},
            {27, 36.55},
            {30, 40.60},
            {40, 54.15},
            {60, 81.20},
            {80, 108.30}
        },{
            {0, 0.35},
            {1, 1.43},
            {2, 2.598},
            {3, 3.86},
            {5, 6.38},
            {7, 8.95},
            {10, 12.865},
            {12, 15.50},
            {13, 16.83},
            {15, 19.49},
            {17, 21.92},
            {18, 23.12},
            {19, 24.34},
            {20, 25.625},
            {30, 38.44},
            {40, 51.25},
            {60, 76.87},
            {80, 102.50}
        },{
            {300.374, 0}, {308.958, 0.05}, {318.122, 0.1}, {327.922, 0.15},
            {338.424, 0.2}, {349.703, 0.25}, {361.842, 0.3}, {374.937, 0.35},
            {389.096, 0.4}, {404.442, 0.45}, {421.117, 0.5}, {439.278, 0.55},
            {459.104, 0.6}, {480.793, 0.65}, {504.563, 0.7}, {530.643, 0.75},
            {559.258, 0.8}, {590.6, 0.85}, {624.772, 0.9}, {661.668, 0.95},
            {700.77, 1}
        }
   },{
         {
            {0, 3.5},
            {4.5, 3.50},
            {5.0, 4.73},
            {7.5, 7.5},
            {10, 10.3},
            {15, 15.95},
            {20, 21.55},
            {23, 25.25},
            {25, 27.7},
            {30, 33.9},
            {35, 40.1},
            {40, 46.3},
            {50, 57.87},
            {60, 69.45},
            {70, 81.0},
            {80, 92.6},
            {100, 115.8}
         },{
            {0, 4.5},
            {4.5, 4.50},
            {5.0, 5.625},
            {7.5, 8.66},
            {10, 11.71},
            {15, 17.80},
            {20, 23.88},
            {23, 27.68},
            {25, 30.22},
            {30, 36.34},
            {35, 42.4},
            {40, 48.46},
            {45, 54.51},
            {50, 60.57},
            {60, 72.68},
            {70, 84.8},
            {80, 96.91},
            {100, 121.13}
         },{
             {-699.034, 0}, {-663.137, 0.05}, {-629.719, 0.1}, {-598.679, 0.15},
             {-569.872, 0.2}, {-543.14, 0.25}, {-518.319, 0.3}, {-495.252,0.35},
             {-473.788, 0.4}, {-453.789, 0.45}, {-435.127, 0.5}, {-417.686, 0.55},
             {-401.36, 0.6}, {-386.056, 0.65}, {-371.685,0.7}, {-358.172, 0.75}, {-345.446, 0.8},
             {-333.444, 0.85}, {-322.109, 0.9}, {-311.39, 0.95}, {-301.239, 1}
         }
    }
}
function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    local V = self.Speed

    self.Voltage = Train.TR.Main750V

    -- Generate on/off signal
    local TargetMode = 0
    if self.Brake*self.Power > 0.5 and (self.Mode<0 or self.Voltage>550) then
        TargetMode = -1
    elseif self.Drive*self.Power > 0.5 then
        TargetMode = 1
    end
    self.EDone = self.Brake*((self.Speed<=5 or self.Speed<=10 and (self.Mode>=0 or self.EDone > 0) or self.Mode>=0 and self.Voltage<550) and 1 or 0)
    -- Check correct mode
    if TargetMode ~= self.Mode then
         if self.State < 0.01 then
             self.Mode = TargetMode
         end
     end
    if self.Power == 0 or (self.Voltage < 550 and self.Mode > 0) then
        self.Mode = 0
    end

    local Inverter_PWM0 = 1.5     -- PWM On
    local Inverter_PWM1 = 2--TargetMode==0 and 0.5 or 1.5     -- PWM Off
    -- PWM target command
    -- Adjust state as defined by mode
    if self.Mode == TargetMode and TargetMode ~= 0 and self.EDone ==0 then
        local torque = math.abs(self.Torque)
        --print(self.State,torque,self.TargetTorque,(self.TargetTorque-torque))
        self.State = math.max(0, math.min(1, self.State + (self.TargetTorque-torque)*Inverter_PWM0*dT))
        --[[ if torque < self.TargetTorque then
        self.State = math.max(0, math.min(1, self.State + (self.TargetTorque-torque)*Inverter_PWM0*dT))
        elseif torque > self.TargetTorque then
        self.State = math.max(0, math.min(1, self.State + (self.TargetTorque-torque)*Inverter_PWM1*dT))
        --self.State = math.max(0, math.min(1, self.State - Inverter_PWM1*dT*(self.TargetTorque-torque)))
        end--]]
    else
        self.State = math.max(0, self.State - Inverter_PWM1*dT)
    end
    -- Generate voltage/frequency
    local V = self.Speed
    if self.Mode == 1 then -- Drive mode
        local Power = lerp(0.0, 1.0, self.State)--- + 0.80*self.Power1 + 0.90*self.Power2 + 1.00*self.Power3)
        local f1 = interpolate(self.xF[1][1], V)
        local f2 = interpolate(self.xF[1][2], V)
        local w = interpolate(self.xF[1][3], 700)--200+Train.Pneumatic.WeightLoadRatio*600)
        self.InverterFrequency =  f1*(1-w) + f2*w
        local Vmin = 200
        local Vtrans = 20
        self.InverterVoltage = math.min(self.Voltage,lerp(Vmin, 750, V/Vtrans)*Power)

    elseif self.Mode == -1 then -- Brake mode
        local Power = lerp(0.0, 1.0, self.State)--- + 0.80*self.Power1 + 0.90*self.Power2 + 1.00*self.Power3)
        local f1 = interpolate(self.xF[2][1], V)
        local f2 = interpolate(self.xF[2][2], V)
        local w = interpolate(self.xF[2][3], 700)--200+Train.Pneumatic.WeightLoadRatio*600)
        self.InverterFrequency =  f1*(1-w) + f2*w

        local Vmin = 600
        local Vtrans = 20
        self.InverterVoltage = lerp(Vmin, 925*2, V/Vtrans)*Power
    else -- Coast mode
        self.InverterVoltage = 0
        self.InverterFrequency = 0.1
    end


    --------------------------------------------------------------------------------------------------------------------
    -- PWM generator model
    --------------------------------------------------------------------------------------------------------------------
    -- Voltage set by inverter
    local V = self.InverterVoltage * self.State -- V
    -- Frequency set by inverter
    local f = self.InverterFrequency -- Hz
--[[
    -- PWM pulses per sync period
    local PWMn = 1
    if self.Speed <   60 then PWMn = 2 end
    if self.Speed <   40 then PWMn = 4 end
    if self.Speed <   29 then PWMn = 6 end
    if self.Speed <   23 then PWMn = 8 end

    -- Get frequency of the generator
    self.InverterGenFrequency = self.InverterFrequency*PWMn
    self.InverterGenFrequency2 = self.InverterFrequency*PWMn]]


    --------------------------------------------------------------------------------------------------------------------
    -- Asynchronous inverter physics model/engine model
    --------------------------------------------------------------------------------------------------------------------
    -- Physical parameters for the engine
    local P = 4     -- No of poles          Poles in the engine
    local Rs = 0.04 -- Ohm                  Active stator resistance
    local Rr = 0.04 -- Ohm                  Active rotor resistance
    local Xs = 1.4  -- Ohm reactive         Reactive stator resistance
    local Xr = 1.4  -- Ohm reactive         Reactive rotor resistance
    local Xm = 30   -- Ohm reactive         Air gap reactive resistance
 -- Get rate of engine rotation
    local n = 3000 * (self.Speed/80)
    self.RotationRate = self.RotationRate + 5.0 * (n - self.RotationRate) * dT

    -- Synchronous RPM, synchronous rate and slip
    local ns = 120*(f/P)            -- rpm
    local ws = (2*math.pi*ns)/60    -- rad/sec
    local s = (ns - n)/ns           -- slip

    -- Asynchronous engine physics model
    local K = 2*Rr*Rs*s*Xm^2 + Rr^2 * (Rs^2 + (Xm + Xs)^2) + s^2 * (Rs^2 * (Xm + Xr)^2 + (Xr*Xs + Xm*(Xr + Xs))^2)
    local Is_real =  (  V*(Rr^2 * Rs + Rr * s * Xm^2 + Rs * s^2 * (Xm + Xr)^2)  ) / (  K  )
    local Is_imag = -(  V*(Rr^2 * (Xm + Xs) + s^2 * (Xm + Xr) * (Xr*Xs + Xm*(Xr + Xs)))  ) / (  K  )
    local Ir_real =  (  s*V*Xm*(Rs*s*(Xm + Xr) + Rr*(Xm + Xs))  ) / (  K  )
    local Ir_imag = -(  s*V*Xm*(-Rr*Rs + s*(Xr*Xs + Xm*(Xr + Xs)))  ) / (  K  )

    -- Convert to real/phase shift
    local Is_abs = math.sqrt(Is_real^2 + Is_imag^2)
    local Ir_abs = math.sqrt(Ir_real^2 + Ir_imag^2)
    local Is_arg = math.atan2(Is_imag, Is_real)
    local Ir_arg = math.atan2(Ir_imag, Ir_real)

    -- Get total current through stator, rotor
    local Is_total = 2*3*Is_abs*(Is_arg + math.pi/2)
    local Ir_total = 2*3*Ir_abs*(Ir_arg + math.pi/2)

    -- Calculate total torque
    local T_total = ( (  2*3*((Ir_abs^2)*Rr)/(math.max(1e-5,ws))  )*(Ir_arg + math.pi/2) )/14.1

    -- Output torque
    self.Current = Is_total
    self.Torque = T_total
    --[[print(string.format("V=%.1f km/h  Torque=%.2f m/s2  I=%.1f A  s=%.4f | Inverter S=%.0f%% V=%.0f V  F=%.1f Hz (%.1f Hz)  %s",
        self.Speed, T_total, Is_total, s, self.State*100, V, f, self.InverterGenFrequency, ((self.Mode == 1) and "Drive" or ((self.Mode == -1) and "Brake" or "Coast"))
        ))]]
end

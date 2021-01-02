--------------------------------------------------------------------------------
-- Contactors switch (EKG) base
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("EKG")

function TRAIN_SYSTEM:Initialize()
    -- Controller configuration
    self.Configuration = self.Configuration or {
        [ 1] = { 0, 0 },
        [ 2] = { 1, 1 },
    }

    -- Resistance value of all contactors
    for k,v in ipairs(self.Configuration[1]) do self[k] = 1e15 end
    for k,v in ipairs(self.Configuration[1]) do self[k.."_v"] = 0 end
    for k,v in ipairs(self.Configuration[1]) do self[k.."_contactor"] = 0 end
    -- Rate of rotation (positions per second
    self.RotationRate = self.RotationRate or 1.0/0.12
    self.OverrideRate = self.OverrideRate or {}

    -- Initialize motor state and position
    self.Position = 1           -- Current literal position
    self.Velocity = 0           -- Current velocity
    self.SelectedPosition = 1   -- Currently selected set of contactors
    self.MotorState = 0         -- State of motor (1 go, -1 brake)
    self.MotorCoilState = 1     -- State of the motor coil (selects direction)
    self.RKM1 = 0               -- Intermediate position contactor
    self.RKM2 = 0               -- Intermediate position contactor
    self.RKP = 0                -- Final position contactor

    -- Max position
    self.MaxPosition = #self.Configuration

    -- Use more iterations to make sure rotation of the rotor passes through all positions
    self.SubIterations = 16
end

function TRAIN_SYSTEM:Inputs()
    return { "MotorState", "MotorCoilState" }
end

function TRAIN_SYSTEM:Outputs()
    return { "Position", "Velocity", "MotorState", "MotorCoilState", "RKM1", "RKM2", "RKP","SelectedPosition" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "MotorState" then
        self.MotorState =  value
    elseif name == "MotorCoilState" then
        self.MotorCoilState = value
    end
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "MotorState" then
        if value > 0.5 then
            self.MotorState =  1.0
        elseif value < -0.5 then
            self.MotorState = -1.0
        else
            self.MotorState = 0.0
        end
    elseif name == "MotorCoilState" then
        self.MotorCoilState = value
    end
end

function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train

    -- Get currently selected position
    local position = math.floor(self.Position+0.5)
    if position < 1 then position = 1 end
    if position > self.MaxPosition then position = self.MaxPosition end

    -- Lock contacts as defined in the configuration
    for k,v in ipairs(self.Configuration[position]) do
        self[k] = 1e-15 + 1e15 * (1-v)
        self[k.."_v"] = v
        self[k.."_contactor"] = v
    end

    -- Start or stop motor rotation
    --[[ local rate = self.OverrideRate[position] or self.RotationRate
    if self.MotorState >  0 then
        self.Velocity = rate*math.max(-1,math.min(1,self.MotorCoilState))
    end
    if self.MotorState <  0 and self.Velocity ~= 0 then
        self.Velocity = 0
        local pos = (position-self.Position)
        self.Position = position--math.max(position-0.02,math.min(self.Position,position+0.02))
        --self.StopTimer = CurTime()
    end--]]

    -- Move motor
    local threshold = self.RotationRate*dT -- Maximum single step of motor per frame
    --print(self.Name,self.Velocity,math.min(threshold,self.Velocity * dT),threshold)

    local rate = self.OverrideRate[position] or self.RotationRate
    if self.MotorState ==  1.0 then
        self.Velocity = rate*math.max(-1,math.min(1,self.MotorCoilState))
    end
    if self.MotorState == -1.0 then
        self.Velocity = 0
    end
    self.Position = self.Position + math.min(threshold,self.Velocity * dT)
    -- Limit motor from moving too far
    --self.WrapsAround = false
    if not self.WrapsAround then
        if self.Position > self.MaxPosition+0.1 then
            self.Position = self.MaxPosition+0.1
            self.Velocity = 0.0
            self.MotorState = 0.0
        end
        if self.Position < 0.9 then
            self.Position = 0.9
            self.Velocity = 0.0
            self.MotorState = 0.0
        end
    else
        if self.Position > self.MaxPosition+1.0 then self.Position = -1.0 end
        if self.Position < -1.0  then self.Position = self.MaxPosition+1.0 end
    end

    local BadValues = self.Position < 0.9 or self.Position > self.MaxPosition+0.1
    -- Update position contactors
    local f = self.Position - position
    self.RKM1 = ((f < -0.30) or  (f > 0.30)) and 1 or 0
    self.RKM2 = not BadValues and ((f < -0.40) or  (f > 0.40)) and 1 or 0
    self.RKP  = ((f > -0.10) and (f < 0.10)) and 1 or 0
    -- Update position readout
    if ((f > -0.40) and (f < 0.40)) then self.SelectedPosition = position end
end

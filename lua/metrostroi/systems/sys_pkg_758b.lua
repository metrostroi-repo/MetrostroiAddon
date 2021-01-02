--------------------------------------------------------------------------------
-- Pneumatic rheostat controller (PKG-758B) for 81-702,
-- used on underground subway lines
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PKG_758B")

function TRAIN_SYSTEM:Initialize()
    -- Controller configuration
    self.Configuration = self.Configuration or {
    --   ##      1  2  3  4  5  6  7  8  9 10 11 12 13 14
        [ 1] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        [ 2] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        [ 3] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0},
        [ 4] = { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0},
        [ 5] = { 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0},
        [ 6] = { 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0},
        [ 7] = { 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0},
        [ 8] = { 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0},
        [ 9] = { 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0},
        [10] = { 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0},
        [11] = { 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0},
        [12] = { 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0},
        [13] = { 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0},

        [14] = { 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1},
        [15] = { 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 1},
        [16] = { 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 1},
        [17] = { 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1},
        [18] = { 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1},
        [19] = { 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1},
        [20] = { 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    }

    -- Resistance value of all contactors
    for k,v in ipairs(self.Configuration[1]) do self[k] = 1e15 end
    --Contacts
    self.PV1 = 0
    self.PV2 = 0
    self.PV3 = 0
    self.PV4 = 0

    self.P1 = 0

    self.RK1 = false
    self.RK2 = false

    self.CylinderPosition = 0

    self.Position = 1           -- Current literal position
    self.Velocity = 0           -- Current velocity
    self.SelectedPosition = 1   -- Currently selected set of contactors

    self.RotationRate = 1.0/0.30*2

    self.MaxPosition = #self.Configuration
    self.SubIterations = 4
end

function TRAIN_SYSTEM:Inputs()
    return {"RK1","RK2"}
end
function TRAIN_SYSTEM:Outputs()
    return {"Position","SelectedPosition","PV1","PV2","PV3","PV4","CylinderVelocity"}
end
function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "RK1" then
        self.RK1 = value>0
    end
    if name == "RK2" then
        self.RK2 = value>0
    end
end
function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    local position = math.floor(self.Position+0.5)
    local rate = self.RotationRate
    local threshold = self.RotationRate*dT
    local f = self.Position - position
    if position < 1 then position = 1 end
    if position > self.MaxPosition then position = self.MaxPosition end

    -- Lock contacts as defined in the configuration
    for k,v in ipairs(self.Configuration[position]) do
        self[k] = 1e-15 + 1e15 * (1-v)
    end

    if self.RK1 and self.CylinderPosition > 0 and self.CylinderVelocity==0 then
        self.CylinderVelocity =  -threshold
        self.Train:PlayOnce("prk1","bass",1)
        --prk1
    elseif self.RK2 and self.CylinderPosition < 1 and self.CylinderVelocity==0 then
        self.CylinderVelocity =  threshold
        self.Train:PlayOnce("prk1","bass",1)
    elseif (self.CylinderPosition==0 or self.CylinderPosition==1) and self.CylinderVelocity~=0 then
        self.CylinderVelocity = 0
        self.Train:PlayOnce("prk2","bass",1)
    end
    self.CylinderPosition = math.max(0,math.min(1,self.CylinderPosition + self.CylinderVelocity))

    if 0 < self.CylinderPosition and self.CylinderPosition < 1 then
        if self.CylinderVelocity > 0 then
            self.Position = self.Position + (1-self.CylinderPosition)/rate
        else
            self.Position = self.Position + (self.CylinderPosition)/rate
        end
    elseif self.Position%2 == self.CylinderPosition then
        self.CylinderPosition = (1-self.CylinderPosition)
    else
        self.Position = self.Position-f
    end
    -- Limit motor from moving too far
    --self.WrapsAround = false
    if self.Position > self.MaxPosition+0.5 then self.Position = 0.5 end
    if self.Position < 0  then self.Position = self.MaxPosition end

    --local BadValues = self.Position < 0.9 or self.Position > self.MaxPosition+0.1
    -- Update position contactors
    --self.RKM1 = ((f < -0.30) or  (f > 0.30)) and 1 or 0
    --self.RKM2 = not BadValues and ((f < -0.40) or  (f > 0.40)) and 1 or 0
    --self.RKP  = ((f > -0.10) and (f < 0.10)) and 1 or 0
    -- Update position readout
    if -0.15 < f and f < 0.40 then self.SelectedPosition = position end

    self.PV1 = (-0.15 < f and f < 0.22) and 1 or 0
    self.PV2 = (-0.15 > f or f > 0.22) and 1 or 0
    self.PV3 = self.SelectedPosition%2
    self.PV4 = 1-self.PV3

    self.P1 = self.Configuration[position][15]
end

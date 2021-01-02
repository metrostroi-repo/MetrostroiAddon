--------------------------------------------------------------------------------
-- 81-720 train horn
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_720_Horn")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.Active = false
end

function TRAIN_SYSTEM:Outputs() --"21",
    return { "Active" }
end

function TRAIN_SYSTEM:Inputs()
    return { "Engage"}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "Engage" then
        self.Active = value > 0.5
    end
end

function TRAIN_SYSTEM:Think()
    self.Train:SetNW2Bool("HornState",self.Active or self.Train.Electric.V1 > 0)
end

function TRAIN_SYSTEM:ClientThink(dT)
    local active = self.Train:GetNW2Bool("HornState",false)
    self.Active = self.Active

    -- Calculate pitch
    local absolutePitch  = 1 - math.exp(-10*self.Train:GetPackedRatio("TL"))
    local absoluteVolume = 1 - math.exp(-4*self.Train:GetPackedRatio("TL"))
    local pitch = 1
    -- Play horn sound
    self.Train:SetSoundState("horn",self.Active and absoluteVolume or 0,absolutePitch*pitch,nil,1.09)
    --[[
    if (self.Active ~= active) and (not active) then
        if absolutePitch > 0.2 then
            self.Train:PlayOnce(self.Train:GetNW2Bool("HornType",false) and "horn3_end" or "horn3_end","cabin",1.09,101.5*absolutePitch*pitch) --0.85
        end
    end]]
    --[[
    if (self.Active ~= active) and (active) then
        self.Train.Transient = -5.0
    end]]
    self.Active = active
end

--------------------------------------------------------------------------------
-- Rheostat controller for 81-502/81-703/81-707 (ЕКГ-17A)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("EKG_18B")

function TRAIN_SYSTEM:Initialize()
    -- Rheostat configuration
    self.Configuration = {
    --   ##      1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22
        [ 1] = { 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1 },-- PS
        [ 2] = { 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0 },-- PP
        [ 3] = { 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0 },-- PT1
        [ 4] = { 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0 },-- PT2 (not used)
    }
    self.WrapsAround = true
    Metrostroi.BaseSystems["EKG"].Initialize(self)

    -- Rate of rotation (positions per second
    self.RotationRate = 1.0/0.30

    -- Реле РПУ
    self.Train:LoadSystem("RPU","Relay","RPU-3",{normal_level = 2})

    self.PMPos = 0
end

function TRAIN_SYSTEM:Inputs(...)
    return Metrostroi.BaseSystems["EKG"].Inputs(self,...)
end
function TRAIN_SYSTEM:Outputs(...)
    return Metrostroi.BaseSystems["EKG"].Outputs(self,...)
end
function TRAIN_SYSTEM:TriggerInput(...)
    return Metrostroi.BaseSystems["EKG"].TriggerInput(self,...)
end
function TRAIN_SYSTEM:Think(...)
    if self.OldSelectedPosition ~= self.SelectedPosition then
        self.Train:PlayOnce("pkg",tostring(self.SelectedPosition),1)
        self.OldSelectedPosition =  self.SelectedPosition
    end
    self.PMPos = (1.25 < self.Position and self.Position < 1.75 or 3.25 < self.Position and self.Position < 3.75) and 1 or 0
    return Metrostroi.BaseSystems["EKG"].Think(self,...)
end

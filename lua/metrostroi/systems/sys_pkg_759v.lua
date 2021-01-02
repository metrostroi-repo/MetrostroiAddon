--------------------------------------------------------------------------------
-- Reverser and relays panel (PKG-759V) for 81-702,
-- used on round subway lines
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PKG_759V")

function TRAIN_SYSTEM:Initialize()
    self.Configuration = {
    --   ##      1  2  3  4  5  6  7  8  9 10 11 12
        [ 1] = { 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1},-- X
        [ 2] = { 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0},-- T
    }
    Metrostroi.BaseSystems["PKG_759B"].Initialize(self)
end

function TRAIN_SYSTEM:Inputs(...)
    return Metrostroi.BaseSystems["PKG_759B"].Inputs(self,...)
end
function TRAIN_SYSTEM:Outputs(...)
    return Metrostroi.BaseSystems["PKG_759B"].Outputs(self,...)
end
function TRAIN_SYSTEM:TriggerInput(...)
    return Metrostroi.BaseSystems["PKG_759B"].TriggerInput(self,...)
end
function TRAIN_SYSTEM:Think(...)
    return Metrostroi.BaseSystems["PKG_759B"].Think(self,...)
end
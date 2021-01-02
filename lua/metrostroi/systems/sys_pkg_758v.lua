--------------------------------------------------------------------------------
-- Pneumatic rheostat controller (PKG-758V) for 81-702,
-- used on ground subway lines
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PKG_758V")

function TRAIN_SYSTEM:Initialize()
    -- Controller configuration
    self.Configuration = {
    --   ##      1  2  3  4  5  6  7  8  9 10 11 12 13 14  П1
        [ 1] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        [ 2] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0},
        [ 3] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0},
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
    Metrostroi.BaseSystems["PKG_758B"].Initialize(self)
end

function TRAIN_SYSTEM:Inputs(...)
    return Metrostroi.BaseSystems["PKG_758B"].Inputs(self,...)
end
function TRAIN_SYSTEM:Outputs(...)
    return Metrostroi.BaseSystems["PKG_758B"].Outputs(self,...)
end
function TRAIN_SYSTEM:TriggerInput(...)
    return Metrostroi.BaseSystems["PKG_758B"].TriggerInput(self,...)
end
function TRAIN_SYSTEM:Think(...)
    return Metrostroi.BaseSystems["PKG_758B"].Think(self,...)
end
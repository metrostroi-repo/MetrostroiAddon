--------------------------------------------------------------------------------
-- 81-720 eletric pass schemes
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_720_PassScheme")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
end

if TURBOSTROI then return end

function TRAIN_SYSTEM:Initialize()
    self.PassSchemeCurr = -1
    self.PassSchemeNext = 0
    self.PassSchemePath = false
end
function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
    if textdata == "Current" then self.Curr = numdata end
    if textdata == "Arrival" then self.Next = numdata end
    if textdata == "Path" then self.Path = numdata end
end
function TRAIN_SYSTEM:Think()
    local Train = self.Train
    if Train.Panel.PassSchemeWork>0 then
        self.PassSchemeCurr = self.Curr or -1
        self.PassSchemeNext = self.Next or 0
        self.PassSchemePath = self.Path--not Train.BUV.RevOrientation and self.Path or Train.BUV.RevOrientation and not self.Path
        --if self.RevOrientation then self.PassSchemePath = not self.PassSchemePath end
    elseif Train.Panel.PassSchemePower>0 then
        self.PassSchemeCurr = -1
        self.PassSchemeNext = 0
        self.PassSchemePath = false--Train.BUV.RevOrientation
    else
        self.PassSchemeCurr = 0
        self.PassSchemeNext = 0
        self.PassSchemePath = false
    end
end

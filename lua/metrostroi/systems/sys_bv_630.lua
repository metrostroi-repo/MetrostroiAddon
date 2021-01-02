--------------------------------------------------------------------------------
-- Fast-switch BV-630
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("BV_630")

function TRAIN_SYSTEM:Initialize()
    self.State = 0
    self.Power = 0
end

function TRAIN_SYSTEM:Inputs()
    return { "Enable", "Disable", "Power" }
end
function TRAIN_SYSTEM:Outputs()
    return { "State" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "Enable" and value > 0 then self.State = 1 end
    if name == "Disable" and value > 0 then self.State = 0 end
    if name == "Power" then self.Power = value end
end

function TRAIN_SYSTEM:Think()
    if self.Power > 0 then
        local Train = self.Train
        if math.abs(Train.Electric.I24) > 800 then self.State = 0 end
        if math.abs(Train.Electric.I13) > 800 then self.State = 0 end
        if math.abs(Train.Electric.Itotal) > 1500 then self.State = 0 end
    else self.State = 0 end
end

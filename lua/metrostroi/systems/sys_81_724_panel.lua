--------------------------------------------------------------------------------
-- 81-724 controller panel
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_724_Panel")

function TRAIN_SYSTEM:Initialize()
    --Автоматы ВЗ
    self.Train:LoadSystem("SF31","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF32","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF33","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF34","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF35","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF36","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF37","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF38","Relay","Switch",{bass=true})
    self.Train:LoadSystem("SF41","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF42","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF43","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF44","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF45","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF46","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF47","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF48","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF49","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF51","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF52","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF53","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF54","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF55","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF56","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF57","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF58","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("SF59","Relay","Switch",{bass=true,normally_closed = true})

    self.V4 = 0
    self.AnnouncerPlaying = 0
    self.PassSchemePowerL = 0
    self.PassSchemePowerR = 0

    self.EmergencyLights = 0
    self.MainLights = 0

    self.DoorsW = 0
    self.BrW = 0
end

function TRAIN_SYSTEM:Inputs()
    return { }
end

function TRAIN_SYSTEM:Outputs()
    return { "EmergencyLights","MainLights","V4","AnnouncerPlaying","PassSchemePowerL", "PassSchemePowerR","DoorsW","BrW"}
end
function TRAIN_SYSTEM:TriggerInput(name,value)
end
function TRAIN_SYSTEM:Think()
end

--------------------------------------------------------------------------------
-- 81-721 controller panel
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_721_Panel")

function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("Battery","Relay","Switch",{normally_closed = true,bass=true})
    --Автоматы ВЗ
    self.Train:LoadSystem("SFV1","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV2","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV3","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV4","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV5","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV6","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV7","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV8","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV9","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV10","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV11","Relay","Switch",{normally_closed = true,bass=true})

    self.Train:LoadSystem("SFV12","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV13","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV14","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV15","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV16","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV17","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV18","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV19","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV20","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV21","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV22","Relay","Switch",{normally_closed = true,bass=true})

    self.Train:LoadSystem("SFV23","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV24","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV25","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV26","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV27","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV28","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV29","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV30","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV31","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV32","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV33","Relay","Switch",{normally_closed = true,bass=true})

    self.AnnouncerPlaying = 0

    self.TickerPower = 0
    self.PassSchemePower = 0
    self.TickerWork = 0
    self.PassSchemeWork = 0

    self.PCBKPower = 0
end

function TRAIN_SYSTEM:Inputs()
    return { }
end

function TRAIN_SYSTEM:Outputs()
    return { "AnnouncerPlaying","TickerPower","PassSchemePower","TickerWork","PassSchemeWork","PCBKPower", }
end
function TRAIN_SYSTEM:TriggerInput(name,value)
end
function TRAIN_SYSTEM:Think()
end

--------------------------------------------------------------------------------
-- Relays and switches panel (PR-109A)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PR_109A")

function TRAIN_SYSTEM:Initialize()
    -- Реле
--  self.Train:LoadSystem("PRV","Relay","REV-813T", { bass = true, open_time = 2.5,})
    -- Реле педали бдительности (РПБ)
    self.Train:LoadSystem("RPB","Relay","REV-813T", { bass = true, open_time = 2.5,})
    -- Реле
    self.Train:LoadSystem("RNVT","Relay","REV-813T", { bass = true, open_time = 2.5,})

    -- Контактор включения провода 1 и 5 (Р1-Р5)
    self.Train:LoadSystem("R1_5","Relay","KPD-110E",{ bass = true })

    -- Реле заряда
    self.Train:LoadSystem("RZ","Relay","REV-811T",{bass = true })
    self.Train:LoadSystem("PRV","Relay","REV-811T",{close_time=0.6,bass = true })
    -- Контактор дверей (КД)
    self.Train:LoadSystem("RD","Relay","REV-811T",{ bass = true })
    self.Train:LoadSystem("RV3","Relay","REV-813T",{ open_time = 2.3 })
    self.Train:LoadSystem("KD","Relay","REV-811T",{ bass = true })
    self.Train:LoadSystem("RKTT","Relay","R-52B")
    -- Реле остановки (РО)
    self.Train:LoadSystem("RO","Relay","KPD-110E",{ bass = true })
end

function TRAIN_SYSTEM:Think()
    local Train = self.Train
    self.RKTTCurrent = Train.Electric.IRT2
    self.RKTTClose  = 440 - 120*(1-self.Train.Pneumatic.WeightLoadRatio)*Train.RUTavt-230*math.max(0,1-Train.RUTreg) --125
    self.RKTTOpen = 520 - 120*(1-self.Train.Pneumatic.WeightLoadRatio)*Train.RUTavt-230*math.max(0,1-Train.RUTreg) --130
    if self.RKTTCurrent < self.RKTTClose then
        Train.RKTT:TriggerInput("Set",false)
    else
        Train.RKTT:TriggerInput("Set",self.RKTTCurrent >= self.RKTTOpen)
    end
end

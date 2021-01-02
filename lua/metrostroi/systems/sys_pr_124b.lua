--------------------------------------------------------------------------------
-- Relays and switches panel (PR-124B)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PR_124B")

function TRAIN_SYSTEM:Initialize()
    -- Контактор включения провода 1 (Р1-Р5)
    self.Train:LoadSystem("R1_5","Relay","KPD-110E",{ bass = true })
    -- Контактор 6-ого провода (К6)
    self.Train:LoadSystem("K6","Relay","KPD-110E",{ bass = true, close_time = 0.12})
    -- Реле времени торможения (РВТ)
    self.Train:LoadSystem("RVT","Relay","REV-811T", { bass   = true, open_time = 0.5, close_time = 0.12})--(self.Train.Electric.TrainSolver:find("81-") and 0.3 or 0.7)
    -- Реле педали бдительности (РПБ)
    self.Train:LoadSystem("RPB","Relay","REV-813T", { bass = true, open_time = 2.5,})
    -- РВ-2
    self.Train:LoadSystem("RV_2","Relay","REV-813T",{ close_time = 2.5})

    -- Реле заряда
    self.Train:LoadSystem("RZ","Relay","REV-811T",{bass = true })
    self.Train:LoadSystem("PRV","Relay","REV-811T",{close_time=0.6,bass = true })
    -- Контактор 25ого провода (К25)
    self.Train:LoadSystem("K25","Relay","PR-143",{bass = true})
    -- Контактор дверей (КД)
    --self.Train:LoadSystem("RD","Relay","REV-811T",{ bass = true })
    --self.Train:LoadSystem("RV3","Relay","REV-813T",{ open_time = 2.3 })
    --self.Train:LoadSystem("KD","Relay","REV-811T",{ bass = true })
    --self.Train:LoadSystem("RKTT","Relay","R-52B")
    --[[ -- Реле остановки (РО)
    self.Train:LoadSystem("RO","Relay","KPD-110E",{ bass = true, close_time = 0.1})--]]
end

function TRAIN_SYSTEM:Think()
    local Train = self.Train
    self.RKTTCurrent = Train.Electric.IRT2
    self.RKTTClose  = 370 - 80*(1-self.Train.Pneumatic.WeightLoadRatio)*Train.RUTavt --125
    self.RKTTOpen = 450 - 80*(1-self.Train.Pneumatic.WeightLoadRatio)*Train.RUTavt --130
    if self.RKTTCurrent < self.RKTTClose then
        Train.RKTT:TriggerInput("Set",false)
    else
        Train.RKTT:TriggerInput("Set",self.RKTTCurrent >= self.RKTTOpen)
    end
end

--------------------------------------------------------------------------------
-- Relays panel (PR-143, PR=144)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PR_14X_Panels")

function TRAIN_SYSTEM:Initialize()
    ----------------------------------------------------------------------------
    -- ПР-143
    ----------------------------------------------------------------------------
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



    ----------------------------------------------------------------------------
    -- ПР-144
    ----------------------------------------------------------------------------
    -- Контактор 25ого провода (К25)
    self.Train:LoadSystem("K25","Relay","PR-143",{bass = true})
    -- Реле-повторитель провода 8 (РП8)
    self.Train:LoadSystem("Rp8","Relay","REV-811T",{open_time = 0.2,bass = true })
    -- Контактор дверей (КД)
    self.Train:LoadSystem("KD","Relay","REV-811T",{ bass = true })
    -- Реле остановки (РО)
    self.Train:LoadSystem("RO","Relay","KPD-110E",{ bass = true--[[ , close_time = 0.1--]] })
end

function TRAIN_SYSTEM:Think()
end

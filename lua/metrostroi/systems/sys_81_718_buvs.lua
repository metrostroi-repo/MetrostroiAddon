--------------------------------------------------------------------------------
-- 81-717 ventilation switching unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_718_BUVS")

function TRAIN_SYSTEM:Initialize()
    self.KM1 = 0 --Контактор вентиляции агрегатов 1 группы
    self.KM2 = 0 --Контактор вентиляции агрегатов 2 группы
    self.KM3 = 0 --Реле наличия минимального тока
    self.KM4 = 0 --Реле контроля наличия тормозного тока

    self.KV1 = 0
end

function TRAIN_SYSTEM:Inputs()
	return {  }
end

function TRAIN_SYSTEM:Outputs()
	return { "KM1","KM2" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end

function TRAIN_SYSTEM:Think()
    local Train = self.Train
    self.RKTTCurrent = math.abs(Train.Electric.I13) + math.abs(Train.Electric.I24)
    self.RKTTClose  = 275 + 100*self.Train.Pneumatic.WeightLoadRatio --125
    self.RKTTOpen = 370 + 130*self.Train.Pneumatic.WeightLoadRatio --130
    if self.RKTTCurrent < self.RKTTClose then
        self.KM4 = 0
    else
        self.KM4 = self.RKTTCurrent >= self.RKTTOpen
    end
end

--------------------------------------------------------------------------------
-- 81-718 additional switch equipment unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_718_BKVA")

function TRAIN_SYSTEM:Initialize()
    self.KM1 = 0 --Контактор включения электропечи
    self.KM2 = 0 --Контактор включения электрокомпрессора
    self.KM3 = 0 --Контактора включения цепей управления вагоном
    self.KM4 = 0 --Реле дверей
    self.KM5 = 0 --Контактор подвозбудителя
end

function TRAIN_SYSTEM:Inputs()
	return {  }
end

function TRAIN_SYSTEM:Outputs()
	return {  }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end

function TRAIN_SYSTEM:Think()
end

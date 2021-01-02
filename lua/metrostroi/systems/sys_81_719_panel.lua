--------------------------------------------------------------------------------
-- 81-719 controller panel
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_719_Panel")

function TRAIN_SYSTEM:Initialize()
    -- Выключатель батареи (ВБ)
    self.Train:LoadSystem("VB","Relay","Switch",{bass = true})

    self.Train:LoadSystem("SF2" ,"Relay","Switch", {bass = true, normally_closed = true})   --Поездное питание
    self.Train:LoadSystem("SF3" ,"Relay","Switch", {bass = true, normally_closed = true})   --Вагонное питание, ЦУВ
    self.Train:LoadSystem("SF4" ,"Relay","Switch", {bass = true, normally_closed = true})   --Питание БУВ, ПТТИ, БСКА, ЦУВ
    self.Train:LoadSystem("SF5" ,"Relay","Switch", {bass = true, normally_closed = true})   --Управление БКЦУ
    self.Train:LoadSystem("SF10","Relay","Switch", {bass = true, normally_closed = true})   --Вентиляторы 1 группа
    self.Train:LoadSystem("SF11","Relay","Switch", {bass = true, normally_closed = true})   --Вентиляторы 2 группа
    self.Train:LoadSystem("SF12","Relay","Switch", {bass = true, normally_closed = true})   --Включение ББЭ
    self.Train:LoadSystem("SF13","Relay","Switch", {bass = true, normally_closed = true})   --Отключение ББЭ
    self.Train:LoadSystem("SF14","Relay","Switch", {bass = true, normally_closed = true})   --Контактор ЦУВ
    self.Train:LoadSystem("SF15","Relay","Switch", {bass = true, normally_closed = true})   --Резервное включение ЦУВ
    self.Train:LoadSystem("SF16","Relay","Switch", {bass = true, normally_closed = true})   --Управление освещением салона
    self.Train:LoadSystem("SF17","Relay","Switch", {bass = true, normally_closed = true})   --Закрытие дверей
    self.Train:LoadSystem("SF18","Relay","Switch", {bass = true, normally_closed = true})   --Открытие левых дверей
    self.Train:LoadSystem("SF19","Relay","Switch", {bass = true, normally_closed = true})   --Резервное закрытие дверей
    self.Train:LoadSystem("SF20","Relay","Switch", {bass = true, normally_closed = true})   --Открытие правых дверей
    self.Train:LoadSystem("SF21","Relay","Switch", {bass = true, normally_closed = true})   --Основное управление МК
    self.Train:LoadSystem("SF22","Relay","Switch", {bass = true, normally_closed = true})   --Резервное управление МК
    self.Train:LoadSystem("SF23","Relay","Switch", {bass = true, normally_closed = true})   --Контактор 1 группы вентиляторов
    self.Train:LoadSystem("SF24","Relay","Switch", {bass = true, normally_closed = true})   --Контактор 2 группы вентиляторов
    self.Train:LoadSystem("SF25","Relay","Switch", {bass = true, normally_closed = true})   --Токоприемники 1 группы
    self.Train:LoadSystem("SF26","Relay","Switch", {bass = true, normally_closed = true})   --ВЗ№1
    self.Train:LoadSystem("SF27","Relay","Switch", {bass = true, normally_closed = true})   --Питание БВА(Блока Автоматических Выключателей)

    self.Train:LoadSystem("SF29","Relay","Switch", {bass = true, normally_closed = true})   --ВЗ№2

    self.Train:LoadSystem("SF34","Relay","Switch", {bass = true, normally_closed = true})   --Питание 1 группы вентиляторов
    self.Train:LoadSystem("SF35","Relay","Switch", {bass = true, normally_closed = true})   --Питание 2 группы вентиляторов

    self.Train:LoadSystem("SF42","Relay","Switch", {bass = true, normally_closed = true})   --Подвозбуждение
    self.Train:LoadSystem("SF43","Relay","Switch", {bass = true, normally_closed = true})   --Аварийное освещение салона
    self.Train:LoadSystem("SF44","Relay","Switch", {bass = true, normally_closed = true})   --Питание освещения салона
    self.Train:LoadSystem("SF45","Relay","Switch", {bass = true, normally_closed = true})   --Управление контакторами ББЭ, освещения салона
    self.Train:LoadSystem("SF46","Relay","Switch", {bass = true, normally_closed = true})   --Питание управления БВА

    self.Train:LoadSystem("SF56","Relay","Switch", {bass = true})   --Электро-компрессор(промежуточный вагон)

    self.Train:LoadSystem("SF72","Relay","Switch", {bass = true, normally_closed = true})   --Стояночный тормоз


    --[[ ----------------- ППУ -----------------
    self.Train:LoadSystem("SBU1" ,"Relay","Switch") --ХОД 1
    self.Train:LoadSystem("SBU2" ,"Relay","Switch") --ВЗ
    self.Train:LoadSystem("SAU2" ,"Relay","Switch") --Компрессор
    self.Train:LoadSystem("SBU3" ,"Relay","Switch") --Откл. БВ
    self.Train:LoadSystem("SBU4" ,"Relay","Switch") --Вкл. ББЭ--]]
    self.EL1 = 0
    self.EL3_6 = 0
    self.EL7_30 = 0
    self.HL13 = 0
    self.HL46 = 0
    self.HL25 = 0
    self.HL6 = 0
    self.TW28 = 0

    self.AnnouncerPlaying = 0
    self.AnnouncerBuzz = 0

    self.V1 = 0
end

local outputs = {"EL1","EL3_6","EL7_30","HL13","HL46","HL25","HL6","TW28","V1","AnnouncerPlaying","AnnouncerBuzz",}
function TRAIN_SYSTEM:ClientInitialize()
end

function TRAIN_SYSTEM:Outputs()
    return outputs
end


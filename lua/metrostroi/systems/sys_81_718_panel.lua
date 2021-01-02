--------------------------------------------------------------------------------
-- 81-718 controller panel
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_718_Panel")

function TRAIN_SYSTEM:Initialize()
    -- Выключатель батареи (ВБ)
    self.Train:LoadSystem("VB","Relay","Switch",{bass = true})
    self.Train:LoadSystem("RC","Relay","Switch",{bass = true, normally_closed=true})
    self.Train:LoadSystem("VTPR","Relay","Switch",{bass = true, maxvalue=3})
    self.Train:LoadSystem("PVK","Relay","Switch",{maxvalue=2,bass=true})

    self.Train:LoadSystem("PB","Relay","Switch",{bass = true})

    self.Train:LoadSystem("SF2" ,"Relay","Switch", {bass = true, normally_closed = true})   --Поездное питание
    self.Train:LoadSystem("SF3" ,"Relay","Switch", {bass = true, normally_closed = true})   --Вагонное питание, ЦУВ
    self.Train:LoadSystem("SF4" ,"Relay","Switch", {bass = true, normally_closed = true})   --Питание БУВ, ПТТИ, БСКА, ЦУВ
    self.Train:LoadSystem("SF5" ,"Relay","Switch", {bass = true, normally_closed = true})   --Управление БКЦУ
    self.Train:LoadSystem("SF6" ,"Relay","Switch", {bass = true, normally_closed = true})   --Управление поездом основное
    self.Train:LoadSystem("SF7" ,"Relay","Switch", {bass = true, normally_closed = true})   --ББЭ, Мотор-компрессор
    self.Train:LoadSystem("SF8" ,"Relay","Switch", {bass = true, normally_closed = true})   --Двери
    self.Train:LoadSystem("SF9" ,"Relay","Switch", {bass = true, normally_closed = true})   --Управление поездом резервное
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

    self.Train:LoadSystem("SF40","Relay","Switch", {bass = true, normally_closed = true})   --ВЗ№2
    self.Train:LoadSystem("SF41","Relay","Switch", {bass = true, normally_closed = true})   --Фары
    self.Train:LoadSystem("SF42","Relay","Switch", {bass = true, normally_closed = true})   --Подвозбуждение
    self.Train:LoadSystem("SF43","Relay","Switch", {bass = true, normally_closed = true})   --Аварийное освещение салона
    self.Train:LoadSystem("SF44","Relay","Switch", {bass = true, normally_closed = true})   --Питание освещения салона
    self.Train:LoadSystem("SF45","Relay","Switch", {bass = true, normally_closed = true})   --Управление контакторами ББЭ, освещения салона
    self.Train:LoadSystem("SF46","Relay","Switch", {bass = true, normally_closed = true})   --Питание управления БВА

    self.Train:LoadSystem("SF50","Relay","Switch", {bass = true, normally_closed = true})   --Скоростемер
    self.Train:LoadSystem("SF51","Relay","Switch", {bass = true, normally_closed = true})   --Основное питание АРС
    self.Train:LoadSystem("SF52","Relay","Switch", {bass = true, normally_closed = true})   --Резервное питание АРС
    self.Train:LoadSystem("SF53","Relay","Switch", {bass = true, normally_closed = true})   --Тормозные цепи АРС
    self.Train:LoadSystem("SF54","Relay","Switch", {bass = true, normally_closed = true})   --Радиооповещение 50А
    self.Train:LoadSystem("SF55","Relay","Switch", {bass = true})   --СОТ3
    self.Train:LoadSystem("SF56","Relay","Switch", {bass = true})   --Электро-компрессор(промежуточный вагон)

    self.Train:LoadSystem("SF60","Relay","Switch", {bass = true, normally_closed = true})   --12V АРС
    self.Train:LoadSystem("SF61","Relay","Switch", {bass = true, normally_closed = true})   --50V АРС(ФММ1)

    self.Train:LoadSystem("SF63","Relay","Switch", {bass = true, normally_closed = true})   --Радиостанция

    self.Train:LoadSystem("SF65","Relay","Switch", {bass = true, normally_closed = true})   --Вентиляция кабины

    self.Train:LoadSystem("SF71","Relay","Switch", {bass = true, normally_closed = true})   --Экстренная связь
    self.Train:LoadSystem("SF72","Relay","Switch", {bass = true, normally_closed = true})   --Стояночный тормоз
    self.Train:LoadSystem("SF73","Relay","Switch", {bass = true, normally_closed = true})   --Гребнесмазыватель

    self.Train:LoadSystem("SF76","Relay","Switch", {bass = true, normally_closed = true})   --Пожарная сигнализация
    self.Train:LoadSystem("SF77","Relay","Switch", {bass = true, normally_closed = true})   --Аварийный ход основное управление
    self.Train:LoadSystem("SF78","Relay","Switch", {bass = true, normally_closed = true})   --Аварийный ход резервное управление


    ----------------- ОПУ -----------------
    self.Train:LoadSystem("SA1/1","Relay","Switch", {bass = true}) --Фары
    self.Train:LoadSystem("SA2/1","Relay","Switch", {bass = true}) --Фары
    self.Train:LoadSystem("SA4/1","Relay","Switch", {bass = true}) --Подсвет приборов
    self.Train:LoadSystem("SA5/1","Relay","Switch", {bass = true, normally_closed = true}) --Яркость табло

    self.Train:LoadSystem("SA2" ,"Relay","Switch", {bass = true}) --Двери аварийные

    self.Train:LoadSystem("SA5" ,"Relay","Switch", {bass = true}) --Закрытие дверей

    self.Train:LoadSystem("SA7" ,"Relay","Switch", {bass = true}) --Сторона дверей
    self.Train:LoadSystem("SA8" ,"Relay","Switch", {bass = true}) --ВАХ
    self.Train:LoadSystem("SA9" ,"Relay","Switch", {bass = true}) --Откл. АВУ

    self.Train:LoadSystem("SA13","Relay","Switch", {bass = true}) --АРС
    self.Train:LoadSystem("SA14","Relay","Switch", {bass = true}) --АРС-Р
    self.Train:LoadSystem("SA15","Relay","Switch", {bass = true, normally_closed = true}) --АЛС
    self.Train:LoadSystem("SA16","Relay","Switch", {bass = true}) --Вкл. МК

    self.Train:LoadSystem("SB1" ,"Relay","Switch", {bass = true}) --Открытие левых дверей
    self.HL3 = 0 --Лампа левых дверей
    self.Train:LoadSystem("SB2" ,"Relay","Switch", {bass = true}) --Открытие правых дверей
    self.HL4 = 0 --Лампа првых дверей
    self.Train:LoadSystem("SB3" ,"Relay","Switch", {bass = true}) --Закрытие дверей резервное
    self.Train:LoadSystem("SB4" ,"Relay","Switch", {bass = true}) --Проверка работы
    self.HL5 = 0 --СН
    self.Train:LoadSystem("SB5" ,"Relay","Switch", {bass = true}) --Передача управления
    self.Train:LoadSystem("SB6" ,"Relay","Switch", {bass = true}) --Ход аварийный
    self.Train:LoadSystem("SB7" ,"Relay","Switch", {bass = true}) --Ход маневровый
    self.Train:LoadSystem("SB6K" ,"Relay","Switch", {bass = true, normally_closed = true})
    self.Train:LoadSystem("SB7K" ,"Relay","Switch", {bass = true, normally_closed = true})
    self.Train:LoadSystem("SB8" ,"Relay","Switch", {bass = true}) --КБ1
    self.Train:LoadSystem("SB9" ,"Relay","Switch", {bass = true}) --КБ2
    self.Train:LoadSystem("SB10","Relay","Switch", {bass = true}) --Программа 1
    self.Train:LoadSystem("SB11","Relay","Switch", {bass = true}) --Программа 2
    self.Train:LoadSystem("SB12","Relay","Switch", {bass = true}) --Возврат защиты, вкл. БВА
    self.Train:LoadSystem("SB13","Relay","Switch", {bass = true}) --Откл. БВА
    self.HL6 = 6 --Защита
    self.Train:LoadSystem("SB14","Relay","Switch", {bass = true}) --Рез. МК
    self.Train:LoadSystem("SB15","Relay","Switch", {bass = true}) --Вкл. ББЭ
    self.Train:LoadSystem("SB16","Relay","Switch", {bass = true}) --Откл. ББЭ
    self.HL7 = 0 --Лампа неисправности ББЭ
    ----------------- ПЛД -----------------
    self.Train:LoadSystem("SA6" ,"Relay","Switch",{bass = true,normally_closed = true}) --Закрытие дверей
    self.Train:LoadSystem("SA24","Relay","Switch", {bass = true}) --Открытие левых дверей
    self.Train:LoadSystem("SB20","Relay","Switch", {bass = true}) --Программа 1
    self.Train:LoadSystem("SB21","Relay","Switch", {bass = true}) --Программа 2

    ----------------- ВПУ -----------------
    self.Train:LoadSystem("SAP3" ,"Relay","Switch", {bass = true}) --УНЧ
    self.Train:LoadSystem("SAP8" ,"Relay","Switch", {bass = true}) --Освещение салона
    self.Train:LoadSystem("SAP9" ,"Relay","Switch", {bass = true}) --Вентиляция 1 группа
    self.Train:LoadSystem("SAP10","Relay","Switch", {bass = true}) --Вентиляция 2 группа
    self.Train:LoadSystem("SAP11","Relay","Switch", {bass = true}) --Отопление
    self.Train:LoadSystem("SAP12","Relay","Switch", {bass = true}) --Освещение отсека
    self.Train:LoadSystem("SAP13","Relay","Switch", {bass = true}) --Освещение кабины
    self.Train:LoadSystem("SAP14","Relay","Switch", {bass = true}) --Дешифратор
    self.Train:LoadSystem("SAP23","Relay","Switch", {bass = true}) --ВП
    self.Train:LoadSystem("SAP24","Relay","Switch", {bass = true}) --ВОВТ
    self.Train:LoadSystem("SAP26","Relay","Switch", {bass = true}) --УОС
    self.Train:LoadSystem("SAP36","Relay","Switch", {bass = true}) --КЭС
    self.Train:LoadSystem("SAP39","Relay","Switch", {bass = true}) --КР

    self.Train:LoadSystem("SBP4" ,"Relay","Switch", {bass = true}) --Резервное открытие левых дверей
    self.Train:LoadSystem("SBP6" ,"Relay","Switch", {bass = true}) --Резервное открытие првых дверей
    self.Train:LoadSystem("SBP22","Relay","Switch", {bass = true}) --Проверка работоспособности
    ----------------- ПРУ -----------------
    self.Train:LoadSystem("SBR14","Relay","Switch", {bass = true}) --Рез. ход 1
    self.Train:LoadSystem("SBR15","Relay","Switch", {bass = true}) --Рез. ход 2
    self.Train:LoadSystem("SBR16","Relay","Switch", {bass = true}) --Авар. ход

    ----------------- БЗОС ----------------
    self.Train:LoadSystem("SAB1","Relay","Switch",{normally_closed=true,bass = true}) --Охранная сигнализация

    --[[ ----------------- ППУ -----------------
    self.Train:LoadSystem("SBU1" ,"Relay","Switch") --ХОД 1
    self.Train:LoadSystem("SBU2" ,"Relay","Switch") --ВЗ
    self.Train:LoadSystem("SAU2" ,"Relay","Switch") --Компрессор
    self.Train:LoadSystem("SBU3" ,"Relay","Switch") --Откл. БВ
    self.Train:LoadSystem("SBU4" ,"Relay","Switch") --Вкл. ББЭ--]]
    self.H11 = 0
    self.HL17 = 0
    self.HL20 = 0
    self.EL2 = 0
    self.EL1 = 0
    self.EL3_6 = 0
    self.EL7_30 = 0
    self.EL31 = 0
    self.V1 = 0
    self.SD = 0
    self.KT = 0
    self.ST = 0
    self.KES = 0
    self.CUV = 0
    self.AVU = 0
    self.KVD = 0
    self.VS1 = 0
    self.VS2 = 0
    self.HL3 = 0
    self.HL4 = 0
    self.HL5 = 0
    self.HL7 = 0
    self.HL13 = 0
    self.HL46 = 0
    self.HL17 = 0
    self.HL20 = 0
    self.HL25 = 0
    self.HL6 = 0
    self.HL52 = 0

    self.LN = 0
    self.RS = 0
    self.AR80 = 0
    self.AR70 = 0
    self.AR60 = 0
    self.AR40 = 0
    self.AR0 = 0
    self.AR04 = 0

    self.TW28 = 0

    self.RouteNumber = 0
    self.VD1 = 0

    self.V1 = 0

    --БУП Выходные сигналы
    self.BOX = 0
    self.BOT = 0
    self.BOU1 = 0
    self.BOU2 = 0
    self.BOV = 0
    self.BON = 0
    self.BO0 = 0
    self.BOZPT = 0

    self.VPR = 0
    --self.BOBBUP = 0

    self.AnnouncerPlaying = 0
    self.AnnouncerBuzz = 0

    self.Speedometer = 0

    self.M1 = 0
end

local outputs = {"H11","HL17","HL20","EL2","EL1","EL3_6","EL7_30","EL31","V1","SD","KT","ST","KES","CUV","AVU","KVD","VS1","VS2","HL3","HL4","HL5","HL7","HL13","HL46","HL17","HL20","HL25","HL6","HL52","LN","RS","AR80","AR70","AR60","AR40","AR0","AR04","TW28","RouteNumber","VD1","V1",
                "BOX","BOT","BOU1","BOU2","BOV","BON","BO0","BOZPT",--"BOBBUP",
                "VPR","Speedometer","M1",
                "AnnouncerPlaying","AnnouncerBuzz",
}
function TRAIN_SYSTEM:ClientInitialize()
end

function TRAIN_SYSTEM:Outputs()
    return outputs
end


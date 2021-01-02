--------------------------------------------------------------------------------
-- 81-717 "PA" safety system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
--[[
а)  включение  ПА-М  и начальное тестирование:
    V 1)  включение  ПА-М;
    V 2)  алгоритм определения положения реверсивной рукоятки (РР);
    V 3)  функции доступа к системе:
        –  вход в систему с кодом доступа электромеханика, тестовый контроль    аппаратуры;
        –  вход в систему с кодом доступа машиниста и приемка состава;
    4)  алгоритм взаимодействия ПА-М и БАРС;
    5)  выход из депо, переход в режим «Работа»;
б)  алгоритмы контроля пневматических систем поезда:
    1)  алгоритм контроля отпуска тормозов;
    2)  алгоритм контроля работы воздухораспределителей;
    3)  алгоритм контроля включения вентилей замещения В1 и В2;
    4)  алгоритм контроля отключения вентилей замещения В1 и В2;
в)  алгоритмы регулирования скорости:
    1)  алгоритм формирования допустимой скорости движения по перегону;
    2)  регулирование скорости в режиме КС  и  ОС;
    V 3)  регулирование скорости в режиме КС при значении  Vд = 0;
    4)  алгоритм контроля эффективности торможения;
г)  алгоритм управления поездом на станции в режимах КС и ОС:
    1)  фиксация станции;
    2)  осаживание поезда;
    3)  процедура открытия/закрытия дверей на станции;
    4)  отправление со станции;
    5)  движение при переезде поездом зоны ОПВ на станции;
    6)  оборот на промежуточной станции;
д)  проезд станции без остановки (транзитом);
е)  алгоритм перехода на другую линию;
ж)  управление поездом на перегоне:
    1)  управление поездом при потере контроля дверей на перегоне;
    2)  функция открытия дверей на перегоне по запросу машиниста;

з)  алгоритм коррекции пройденного пути;
и)  алгоритм коррекции значений коэффициентов  (бандажа);
к)  осаживание при пожаре;
л)  алгоритм контроля скатывания поезда (режим КС);
м)  алгоритм проверки «противоскатывания» поезда;
н)  алгоритм движения по станционным путям;
о)  алгоритм работы ПА-М в режиме резервного управления поездом;
п)  организация работы терминала машиниста.

2.1.5  При обнаружении ПА-М пропадания сигнала КД она формирует команду ОХТ и ожидает запрос на разрешение движения без КД.
2.1.6  При пропадании сигнала КСОТ ПА-М автоматически переходит в режим ОС, дальнейшее движение поезда возможно при нажатой ПБ. При появлении сигнала КСОТ происходит автоматический переход в КС.
2.1.7  ПА-М не позволяет производить открытие дверей на перегоне, кроме случая выполнения машинистом запроса на открытие дверей только после полной остановки поезда.
2.1.8  ПА-М блокирует возможность движения состава при Vд = 0. Движение при Vд = 0 возможно со скоростью не более 20 км/ч при нажатой ПБ и включенном тумблере ВРД или введенном запросе машиниста  «Движение при Vд = 0».
2.1.9  ПА-М не производит автоматического открытия дверей на станции при отсутствии радиосвязи с СА КСД.
2.1.10  ПА-М блокирует открытие дверей на станции со стороны, противоположной стороне платформы.
2.1.11  ПА-М запрещает осаживание поезда на станции открытого типа при проезде зоны ОПВ и разрешает на станции закрытого типа при проезде зоны ОПВ не более 3 м.
2.1.12  ПА-М запрещает движение со скоростью более 20 км/ч при нажатой ПБ независимо от значения Vд.
2.1.13  ПА-М в режимах КС и ОС блокирует возможность проследования станции без остановки, кроме случая введения машинистом запроса на проследование станции транзитом.
2.2.3.2  Перед включением ПА-М проверить включенное состояние переключателей РЦ1, РЦ2, автоматических выключателей А58, А59, А61 и включенное состояние выключателя ВАУ (положение «ВКЛ»).

2.3.3 Управление поездом при отсутствии кодирования (НЧ)
2.3.3.1 Функция формирования допустимой скорости движения:
    а) При наезде на Vд = НЧ выдается значение предыдущей допустимой скорости, пока непройдет 0.8 секунды с момента наезда на Vд = НЧ и поезд не проедет 12 – 20 м (в зависимостиот скорости движения поезда);
    б) При несовпадении данных полученных от двух плат ФФК или получении недостовер-ных данных по одной из них (при получении частот вне диапазона значений или двойных час-тот и т.д.) формируется Vд = НЧ через 1,5 секунды и после прохождения поездом 12 – 20 м(в зависимости от скорости движения поезда);
    в) На стоящем поезде (при скорости менее 0.1 м/с), при пропадании частоты смена допус-тимой скорости производится через 2,5 с, не дожидаясь прохождения составом 12 м.2.3.3.2 Функция управления поездом при наезде на рельсовую цепь с отсутствием коди-рования (НЧ):
    а) При наезде на рельсовую цепь с отсутствием кодирования (НЧ) выдается зуммер;
    б) ПА М формирует последовательность команд ОХТ → Т2;
    в) После нажатия ПБ зуммер отключается;
    г) Торможение (Т2) продолжается до полной остановки, а после остановки поезда ПА-М формирует команду В1;
    д) При отпущенной ПБ ПА-М формирует команду ОХТ + В1;
    е) При установленном в положение «0» КВ и нажатой ПБ ПА-М формирует команду ОД;
    ж) После перевода КВ в положение ХОД движение поезда возможно со скоростью не более 20 км/ч при нажатой ПБ.
    2.3.4 Возможность проследования блок-участка с Vд = 0
2.3.4.1 При наезде на рельсовую цепь с Vд = 0 за 100 метров до станции с путевым разви- тием, разрешается дальнейшее движение без остановки со скоростью не более 20 км/ч при ус- ловии нажатой ПБ.
2.3.4.2 В остальных случаях при наезде на Vд = 0 происходит торможение до полной ос- тановки.
2.3.4.3 При смене допустимой скорости с Vд ≠ 0 на Vд = 0 ПА-М должна сформировать последовательность команд ОХТ → Т2 до остановки поезда, с выдачей зуммера.
2.3.4.4 После остановки поезда и нажатии ПБ команда Т2 + В1 меняется на ОХТ + В1.
2.3.4.5 При последующем отпуске ПБ, зуммер отключается.
2.3.4.6 При переводе КВ в положение ХОД назначение ходового режима запрещается, и на дисплее ТМ появляется подсказка «Движение при Vд = 0».
2.3.4.7 После остановки поезда возобновление движения со скоростью не более 20 км/ч возможно при условии нажатой ПБ и наличия сигнала ВРД (включен выключатель ВРД).
2.3.4.8 После остановки поезда возобновление движения со скоростью не более 20 км/ч возможно при условии нажатой ПБ и введения на блоке ТМ запроса «Движение при Vд = 0».
2.3.4.9 Для ввода запроса необходимо последовательно нажать на ТМ клавишу «F», за- тем выбрать пункт меню, нажав клавишу «5».
2.3.4.10 На дисплее ТМ появится «Запрос на разрешение продолжения движения при Vд = 0» (рисунок 11).
2.3.4.11 При нажатии клавиши «Esc» произойдет возврат к предыдущему кадру без раз- решения продолжения движения (режим ОХТ + В1).
2.3.4.12 При нажатии клавиши « ←⏐» ПА М разрешит продолжение движения при Vд = 0, а на ТМ произойдет возврат к предыдущему кадру и на время 7 секунд появится под- сказка «Разрешено движение при Vд = 0».
2.3.4.13 Режим ОХТ + В1 сменится на ОД + В1 при нажатой ПБ.
2.3.4.14 При появлении Vд ≠ 0 запрос «движение при Vд = 0» автоматически снимается.
]]

Metrostroi.DefineSystem("PAM")
TRAIN_SYSTEM.DontAccelerateSimulation = true
TRAIN_SYSTEM.TriggerNames = {
    "PAM7",
    "PAM8",
    "PAM9",
    "PAMLeft",
    "PAMRight",
    "PAM4",
    "PAM5",
    "PAM6",
    "PAMUp",
    "PAM1",
    "PAM2",
    "PAM3",
    "PAMDown",
    "PAM0",
    "PAMEnter",
    "PAMEsc",
    "PAMF",
    "PAMM",
    "PAMP",
    "PAMKeyB",
}

function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("PAM_VV")
    self.Train:LoadSystem("KSD_R","Relay")
    self.Train:LoadSystem("KSD_VAU","Relay",nil,{close_time=0.1})
    --self.Train:LoadSystem("KSZD","Relay","Switch",{ bass = true })
    --self.Train:LoadSystem("VZP","Relay","Switch",{ bass = true })
    --self.Train:LoadSystem("VAU","Relay","Switch",{ bass = true, normally_closed = true })
    --self.Train:LoadSystem("RC2","Relay","Switch",{ bass = true, normally_closed = true })


    self.Triggers = {}
    self.Touches = {}
    for k,v in pairs(self.TriggerNames) do
        self.Train:LoadSystem(v,"Relay","Switch",{ bass = true })
        self.Triggers[k] = false
        self.Touches[k] = false
    end

    self.NoFreq = 0
    self.F6 = 0
    self.F5 = 0
    self.F4 = 0
    self.F3 = 0
    self.F2 = 0
    self.F1 = 0

    self["2"] = 0 --Вращение РК
    self["3"] = 0 --Ход 3
    self["8"] = 0 --Замещение электрического торможения
    self["16"] = 0 --Закрытие дверей
    self["17"] = 0  -- Разрешение восстановления реле перегрузки
    self["19"] = 0 -- Разрешение замещения электрического торможения
    self["20"] = 0 -- Включение двигателей
    self["20X"] = 0 -- Разрешение включения двигателей в ходовые режимы
    self["025"] = 0 -- Разрешение ручного торможения
    self["25"] = 0 -- Ручное торможение
    self["31"] = 0 --Открытие открытия левых дверей
    self["32"] = 0 --Открытие правых дверей
    self["33"] = 0 --Включение ходового режима
    self["033"] = 0 --Разрешение включения ходового режима
    self["33G"] = 0 --Включение режима торможения
    self["39"] = 0 --Включение вентиля замещения № 2
    self["7GA"] = 0 --Включение вентиля замещения № 2
    self["48"] = 0 --Включение вентиля замещения № 1
    self.EPK = 0


    self.Ring = 0

    self.State = 0
    self.Selected = 1

    self.Keyboard = false

    self.Station = ""
    self.Path = ""
    self.RouteNumber = ""
    self.DriverNumber = ""
    --self:SetDriveMode = "Zero"
    --self.CurrentDoorMode = "DO"
    --self.CurrentPneumoMode = "NT"
    self.Speed = 0
    self.SpeedLimit = 0
    self.Acceleration = 0
    self.ErrorTimers = {}
    self.Timers = {}
end


--if TURBOSTROI then return end
function TRAIN_SYSTEM:Inputs()
    return { "KSDMode" }
end
function TRAIN_SYSTEM:Outputs()
    return {
        "2","3","8","16","17","19","20","20X","025","25","31","32","33","033","33G","39","7GA","48","EPK",
        "Ring", "NoFreq", "F5", "F4", "F3", "F2", "F1"
    }
end

if CLIENT then
    local function createFont(name,font,size)
        surface.CreateFont("Metrostroi_"..name, {
            font = font,
            size = size,
            weight = 800,
            blursize = false,
            antialias = true,
            underline = false,
            italic = false,
            strikeout = false,
            symbol = false,
            rotary = false,
            shadow = false,
            additive = false,
            outline = false,
            extended = true,
            scanlines = false,
        })
    end
    createFont("PAM15","Arial",15)
    createFont("PAM19","Arial",19)
    createFont("PAM20","Arial",20)
    createFont("PAM21","Arial",21)
    createFont("PAM24","Arial",24)
    createFont("PAM25","Arial",25)
    createFont("PAM26","Arial",26)
    createFont("PAM27","Arial",27)
    createFont("PAM28","Arial",28)
    createFont("PAM29","Arial",29)
    createFont("PAM30","Arial",30)
    createFont("PAM31","Arial",31)
    createFont("PAM35","Arial",35)
    createFont("PAM45","Arial",45)
    createFont("PAM60","Arial",60)

    function TRAIN_SYSTEM:ClientThink()
        if not self.Train:ShouldDrawPanel("PAMScreen") then return end
        if self.FilterMag then
            render.PopFilterMag()
            render.PopFilterMin()
        end

        self.FilterMag = true

        render.PushRenderTarget(self.Train.PAM,0,0,1024, 512)
        render.Clear(0, 0, 0, 0)
        cam.Start2D()
            render.SetScissorRect(0, 0, 640, 480, true)
            render.PushFilterMag( TEXFILTER.POINT )
            render.PushFilterMin( TEXFILTER.POINT )
            surface.SetDrawColor(0,0,0)
            surface.DrawRect(0,0,640,480)
            if true then self:PAMScreen(self.Train) end
            render.SetScissorRect(0, 0, 0, 0, false)
            render.PopFilterMag()
            render.PopFilterMin()
        cam.End2D()
        render.PopRenderTarget()
        self.FilterMag = false
    end

    local button = {"button_lt","button_lc","button_lb","button_ct","button_cc","button_cb"}
    local button_p = {"button_p_lt","button_p_lc","button_p_lb","button_p_ct","button_p_cc","button_p_cb"}
    local button_s = {"button_s_lt","button_s_lc","button_s_lb","button_s_ct","button_s_cc","button_s_cb"}

    local textbox = {
        "textbox_corner_tl","textbox_corner_t","textbox_corner_tr",
        "textbox_corner_l","textbox_corner_r",
        "textbox_corner_bl","textbox_corner_b","textbox_corner_br",
    }
    local speed = {
        "speed_tl","speed_t","speed_tr",
        "speed_l","speed_c","speed_r",
        "speed_bl","speed_b","speed_br",
    }
    local window = {
        "window_tl","window_tc","window_tr",
        "window_cl","window_cc","window_cr",
        "window_bl","window_bc","window_br",
    }
    local function replaceNames(tbl,path)
        for k,v in pairs(tbl) do tbl[k] = surface.GetTextureID((path or "models/metrostroi_train/81-717/screens/pa/buttons/")..v) end
    end
    replaceNames(button)
    replaceNames(button_p)
    replaceNames(button_s)
    replaceNames(textbox)
    replaceNames(speed)
    replaceNames(window,"models/metrostroi_train/81-717/screens/pa/window/")
    local function drawButton(x,y,w,h,button,color)
        --[[ surface.SetDrawColor(255,0,0)
        surface.DrawLine(x,y,x+w,y)
        surface.DrawLine(x+w,y,x+w,y+h)
        surface.DrawLine(x,y+h,x+w,y+h)
        surface.DrawLine(x,y,x,y+h)--]]
        if not button then return end
        w = math.max(w-16,0)
        h = math.max(h-16,0)
        surface.SetDrawColor(color or Color(255,255,255))
        surface.SetTexture(button[1])
        surface.DrawTexturedRect(x,y,8,8)
        surface.DrawTexturedRectUV(x+w+8,y,8,8,1,0,0,1)
        if h > 0 then
            surface.SetTexture(button[2])
            surface.DrawTexturedRect(x,y+8,8,h)
            surface.SetTexture(button[2])
            surface.DrawTexturedRectUV(x+w+8,y+8,8,h,1,0,0,1)
            --surface.DrawTexturedRectUV(x+8,y,w,h,0,0,1*(w/8),1)
        end
        if w > 0 then
            surface.SetTexture(button[4])
            surface.DrawTexturedRectUV(x+8,y,w,8,0,0,1*(w/8),1)
            surface.SetTexture(button[5])
            surface.DrawTexturedRect(x+8,y+8,w,h)
            surface.SetTexture(button[6])
            surface.DrawTexturedRectUV(x+8,y+h+8,w,8,0,0,1*(w/8),1)
        end
        surface.SetTexture(button[3])
        surface.DrawTexturedRect(x,y+h+8,8,8)
        surface.DrawTexturedRectUV(x+w+8,y+h+8,8,8,1,0,0,1)
        --surface.SetTexture(button[3])
        --surface.DrawTexturedRect(x+w+8,y,8,h,0)
    end
    local function drawWindow(x,y,w,h,text)
        w = math.max(w-16,0)
        h = math.max(h-40,0)
        --Color(74,95,148)
        surface.SetDrawColor(color or Color(255,255,255))
        --surface.DrawRect(x+4,y+4,w,h)
        surface.SetTexture(window[1])
        surface.DrawTexturedRect(x,y,8,32)
        surface.SetTexture(window[2])
        surface.DrawTexturedRect(x+8,y,w,32)
        surface.SetTexture(window[3])
        surface.DrawTexturedRect(x+w+8,y,8,32)
        draw.SimpleText(text,"Metrostroi_PAM19",x+8+w/2,y+18, Color(28,35,53),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        draw.SimpleText(text,"Metrostroi_PAM19",x+8+w/2,y+16, col or Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

        surface.SetDrawColor(color or Color(255,255,255))
        surface.SetTexture(window[4])
        surface.DrawTexturedRect(x,y+32,8,h)
        surface.SetTexture(window[5])
        surface.DrawTexturedRect(x+8,y+32,w,h)
        surface.SetTexture(window[6])
        surface.DrawTexturedRect(x+w+8,y+32,8,h)

        surface.SetTexture(window[7])
        surface.DrawTexturedRect(x,y+h+32,8,4)
        surface.SetTexture(window[8])
        surface.DrawTexturedRect(x+8,y+h+32,w,4)
        surface.SetTexture(window[9])
        surface.DrawTexturedRect(x+w+8,y+h+32,8,4)

        --draw.SimpleText(text,font,x+w/2+4,y+h/2+4, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        --surface.SetTexture(button[3])
        --surface.DrawTexturedRect(x+w+8,y,8,h,0)
    end
    local function drawTextBox(x,y,w,h,text,font,color)
        --[[ surface.SetDrawColor(255,0,0)
        surface.DrawLine(x,y,x+w,y)
        surface.DrawLine(x+w,y,x+w,y+h)
        surface.DrawLine(x,y+h,x+w,y+h)
        surface.DrawLine(x,y,x,y+h)--]]

        w = math.max(w-8,0)
        h = math.max(h-8,0)
        surface.SetDrawColor(color or Color(255,255,255))
        surface.DrawRect(x+4,y+4,w,h)
        surface.SetTexture(textbox[1])
        surface.DrawTexturedRect(x,y,4,4)
        surface.SetTexture(textbox[2])
        surface.DrawTexturedRect(x+4,y,w,4)
        surface.SetTexture(textbox[3])
        surface.DrawTexturedRect(x+w+4,y,4,4)

        surface.SetTexture(textbox[4])
        surface.DrawTexturedRect(x,y+4,4,h)
        surface.SetTexture(textbox[5])
        surface.DrawTexturedRect(x+w+4,y+4,4,h)

        surface.SetTexture(textbox[6])
        surface.DrawTexturedRect(x,y+h+4,4,4)
        surface.SetTexture(textbox[7])
        surface.DrawTexturedRect(x+4,y+h+4,w,4)
        surface.SetTexture(textbox[8])
        surface.DrawTexturedRect(x+w+4,y+h+4,4,4)

        draw.SimpleText(text,font,x+w/2+4,y+h/2+4, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end
    local function drawSpeed(x,y,w,h,color)
        --[[
        surface.SetDrawColor(255,0,0)
        surface.DrawLine(x,y,x+w,y)
        surface.DrawLine(x+w,y,x+w,y+h)
        surface.DrawLine(x,y+h,x+w,y+h)
        surface.DrawLine(x,y,x,y+h)--]]
        --w = math.max(w-8,0)
        h = math.max(h-8,0)
        if w < -4 then return end
        surface.SetDrawColor(color or Color(255,255,255))
        --surface.DrawRect(x+4,y+4,w,h)
        surface.SetTexture(speed[1])
        surface.DrawTexturedRect(x,y,4,4)
        surface.SetTexture(speed[2])
        surface.DrawTexturedRect(x+4,y,w,4)
        surface.SetTexture(speed[3])
        surface.DrawTexturedRect(x+w+4,y,4,4)

        surface.SetTexture(speed[4])
        surface.DrawTexturedRect(x,y+4,4,h)
        surface.SetTexture(speed[5])
        surface.DrawTexturedRectUV(x+4,y+4,w,h,0,0,1*(w/19),1)
        surface.SetTexture(speed[6])
        surface.DrawTexturedRect(x+w+4,y+4,4,h)

        surface.SetTexture(speed[7])
        surface.DrawTexturedRect(x,y+h+4,4,4)
        surface.SetTexture(speed[8])
        surface.DrawTexturedRect(x+4,y+h+4,w,4)
        surface.SetTexture(speed[9])
        surface.DrawTexturedRect(x+w+4,y+h+4,4,4)
    end
    local function buttonWTextC(x,y,w,h,text,font,color,button,buttoncolor)
        drawButton(x,y,w,h,button,buttoncolor)
        draw.SimpleText(text,font,x+w/2,y+h/2, color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end

    function drawFrame(tex,x,y,w,h,alpha)
        x,y,w,h = x or 0,y or 0,w or 1024,h or 512
        surface.SetTexture(tex)
        surface.SetDrawColor(255,255,255,alpha)
        surface.DrawTexturedRect(x,y,w,h)
        --surface.DrawTexturedRectRotated(x+w/2,y+h/2,w,h,0)
    end

    function stateDebug(Train)
        draw.SimpleText(Format("St  = %.02f",Train:GetNW2Float("PAM:TrackS",-1)),"Metrostroi_PAM30",5,20, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText(Format("S   = %.02f",Train:GetNW2Float("PAM:S",-1)),"Metrostroi_PAM30",5,20+20*1, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText(Format("Sd  = %.02f",Train:GetNW2Float("PAM:Sd",-1)),"Metrostroi_PAM30",5,20+20*2, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText(Format("S2  = %.02f",Train:GetNW2Float("PAM:S2",-1)),"Metrostroi_PAM30",5,20+20*3, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText(Format("S2d = %.02f",Train:GetNW2Float("PAM:S2d",-1)),"Metrostroi_PAM30",5,20+20*4, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText(Format("SSd = %.02f",Train:GetNW2Float("PAM:S",-1)-Train:GetNW2Float("PAM:S2",-1)),"Metrostroi_PAM30",5,20+20*5, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

        draw.SimpleText(Format("SensID = %0.1f",Train:GetNW2Float("PAM:LastSensorDist",-1)),"Metrostroi_PAM30",5,20+20*7, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText(Format("SensD  = %0.1f",Train:GetNW2Float("PAM:SensorDist",-1)),"Metrostroi_PAM30",5,20+20*8, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText(Format("SensT  = %0.1f",Train:GetNW2Float("PAM:LastSensorTime",-1)),"Metrostroi_PAM30",5,20+20*9, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText(Format("SensD1 = %0.3f",Train:GetNW2Float("PAM:LastSensorDiff",-1)),"Metrostroi_PAM30",5,20+20*10, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText(Format("SensD2 = %0.3f",Train:GetNW2Float("PAM:LastSensorDiff2",-1)),"Metrostroi_PAM30",5,20+20*11, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

        draw.SimpleText(Format("Sig = %s",Train:GetNW2String("PAM:Signal","n\\a")),"Metrostroi_PAM30",5,20+20*13, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

        draw.SimpleText(Format("ST  = %d",Train:GetNW2Int("PAM:Station",-1)),"Metrostroi_PAM30",5,20+20*15, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText(Format("STd = %0.2f",Train:GetNW2Float("PAM:StationS",-1)),"Metrostroi_PAM30",5,20+20*16, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText(Format("STD = %0.1f",Train:GetNW2Float("PAM:StationD",-1)),"Metrostroi_PAM30",5,20+20*17, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end

    local state1_nkr = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/state1_nkr")
    local state1_kr = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/state1_kr")
    local function State1(Train)
        local reverser = Train:GetNW2Bool("PAM:Reverser")
        local xmin = reverser and 36 or 0
        drawFrame(reverser and state1_kr or state1_nkr)
        local Stest,SSetup,SBack = Train:GetNW2Bool("PAM:GoodTest"),Train:GetNW2Bool("PAM:GoodSetup"),Train:GetNW2Int("PAM:GoodBack",0)
        if Stest then
            draw.SimpleText("НОРМА","Metrostroi_PAM28",431,163+38*0-xmin, Color(0,165,13),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        else
            draw.SimpleText("НЕ НОРМА","Metrostroi_PAM28",431,163+38*0-xmin, Color(213,18,8),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end
        if SSetup then
            draw.SimpleText("НОРМА","Metrostroi_PAM28",431,163+38*1-xmin, Color(0,165,13),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        else
            draw.SimpleText("НЕ НОРМА","Metrostroi_PAM28",431,163+38*1-xmin, Color(213,18,8),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end
        if SBack==1 then
            draw.SimpleText("НОРМА","Metrostroi_PAM28",431,163+38*2-xmin, Color(0,165,13),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        elseif SBack==-1 then
            draw.SimpleText("НЕ НОРМА","Metrostroi_PAM28",431,163+38*2-xmin, Color(213,18,8),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        else
            draw.SimpleText("НЕТ СВЯЗИ","Metrostroi_PAM28",431,163+38*2-xmin, Color(125,125,125),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end
        draw.SimpleText("2.2","Metrostroi_PAM28",431-5,163+38*3-xmin, Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)


        draw.SimpleText("ПСР не подключен","Metrostroi_PAM27",315,318-xmin, Color(213,18,8),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

        buttonWTextC(542,352-xmin,77,51,"Esc","Metrostroi_PAM30",Color(0,0,0), Train:GetNW2Bool("PAM:KeyEsc") and button_p or button)
        if reverser then
            buttonWTextC(320-55,410,110,51,"Enter","Metrostroi_PAM30", Color(0,0,0), Train:GetNW2Bool("PAM:KeyEnter") and button_p or button)
            --buttonWTextC(320-55,410,110,51,"Enter","Metrostroi_PAM30", SSetup and Color(0,0,0) or Color(124,124,124), (SSetup and Train:GetNW2Bool("PAM:KeyEnter")) and button_p or button)
        end
    end
    local state1_errs = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/state1_errs")
    local function State1_5(Train)
        drawFrame(state1_errs)
        local backPA = Train:GetNW2Int("PAM:GoodBack",0)
        for i=0,7 do
            if i~=4 or Train:GetNW2Bool("PAM:GoodSetup") then
                draw.SimpleText("НОРМА","Metrostroi_PAM28",302,164+31*i, Color(0,165,13),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            else
                draw.SimpleText("НЕ НОРМА","Metrostroi_PAM28",302,164+31*i, Color(213,18,8),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            end
            if backPA ==0 then
                draw.SimpleText("НЕТ СВЯЗИ","Metrostroi_PAM28",471,164+31*i, Color(125,125,125),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            elseif i==4 and backPA == -1 then
                draw.SimpleText("НЕ НОРМА","Metrostroi_PAM28",471,164+31*i, Color(213,18,8),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            else
                draw.SimpleText("НОРМА","Metrostroi_PAM28",471,164+31*i, Color(0,165,13),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            end
        end
        buttonWTextC(320-82,408,164,51,"Закрыть","Metrostroi_PAM30",Color(0,0,0), Train:GetNW2Bool("PAM:KeyEsc") and button_p or button)
    end
    local state2 = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/state2")
    local tbl = {
        1,"Выход на линию",
        2,"Перезапуск",
        false,"Назад",
        "M","Технологическое меню",
    }
    local function State2(Train)
        drawFrame(state2)
        local sel = Train:GetNW2Int("PAM:Selected",1)
        for i=1,#tbl/2 do
            local color = i==sel and Color(255,255,255) or Color(0,0,0)
            local y = 121+59*(i-1)+25
            if i~=2 or Train:GetNW2Bool("PAM:HaveRestart") then
                if i==4 then y=y+69 end
                drawButton(320-298,y-25,596,50, i==sel and button_s or button)
                draw.SimpleText(tbl[i*2],"Metrostroi_PAM28",320-98,y, color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                if tbl[i*2-1] then
                    draw.SimpleText(tbl[i*2-1],"Metrostroi_PAM28",320-292,y, color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    if i==4 then
                        Metrostroi.DrawLine(320-290,y+13,320-272,y+13,color,3)
                    else
                        Metrostroi.DrawLine(320-290,y+13,320-277,y+13,color,3)
                    end
                end
            end
        end
    end

    local keyboard_na = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/keyboard_na")
    local keyboard = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/keyboard")
    local keys = {
                        "P",
          "F" , "Up" ,  "M",
        "Left","Down","Right",
          "1" , "2"  ,  "3",
          "4" , "5"  ,  "6",
          "7" , "8"  ,  "9",
        "Esc" , "0"  ,"Enter",
    }
    local keysConv = {Up="▲",Left="◄",Down="▼",Right="►",}
    local function drawKeyboard(Train,x,y)
        local selected = Train:GetNW2String("PAM:Touching","") ~= ""
        drawFrame(selected and keyboard or keyboard_na,x,y,256,512)
        local colors = Color(0,0,0,255*0.3)
        for i,keyName in ipairs(keys) do
            local touched = not selected and Train:GetNW2String("PAM:LastToucn") == keyName
            local touching = Train:GetNW2String("PAM:Touching") == keyName
            local col = Color(255,255,255,colors.a)
            if touching then col = Color(245,46,18) end
            if touched then
                col = Color(255,255,255)
            end
            local key = i+1
            local xp = key%3
            local yp = math.floor(key/3)
            buttonWTextC(x+5+60*xp,y+32+49*yp,60,49,keysConv[keyName] or keyName,"Metrostroi_PAM27",Color(0,0,0), Train:GetNW2Bool("PAM:Key"..keyName) and button_p or button,col)
        end
    end
    local combobox = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/combobox")
    local combobox_g = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/combobox_g")
    local function comboBox(Train,x,y)
        local count = Train:GetNW2Int("PAM:ElemCount",0)
        if count <= 0 then return end
        local w,h = 260,163
        drawFrame(combobox,x,y,256,256)
        for i=1,Train:GetNW2String("PAM:ElemCount",0) do
            local text = Train:GetNW2String("PAM:Elem"..i)
            local tab = text:find("\t")
            if tab then
                draw.SimpleText(text:sub(1,tab-1),"Metrostroi_PAM20",x+13,y+27-10+18*(i-1), Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText(text:sub(tab+1,-1),"Metrostroi_PAM20",x+13+35,y+27-10+18*(i-1), Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            else
                draw.SimpleText(text,"Metrostroi_PAM20",x+13,y+27-5+18*(i-1), Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            end
            --x+28+18*i Train:SetNW2String("PAM:Elem"..iS,id.."\t"..(name or id))
        end
        --[[ surface.SetDrawColor(Color(255,0,0))
        surface.DrawLine(x+219,y+5,x+219+31,y+5)
        surface.DrawLine(x+219,y+5,x+219,y+5+15)
        surface.DrawLine(x+219,y+5+15,x+219+31,y+5+15)
        surface.DrawLine(x+219+31,y+5,x+219+31,y+5+15)

        surface.SetDrawColor(Color(0,255,0))
        surface.DrawLine(x+219,y+128,x+219+31,y+128)
        surface.DrawLine(x+219,y+128,x+219,y+128+14)
        surface.DrawLine(x+219,y+128+14,x+219+31,y+128+14)
        surface.DrawLine(x+219+31,y+128,x+219+31,y+128+14)

        surface.SetDrawColor(Color(0,0,255))
        surface.DrawLine(x+219,y+143,x+219+31,y+143)
        surface.DrawLine(x+219,y+143,x+219,y+143+14)
        surface.DrawLine(x+219,y+143+14,x+219+31,y+143+14)
        surface.DrawLine(x+219+31,y+143,x+219+31,y+143+14)--]]

    end
    local state3 = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/state3")
    local state3k = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/state3k")
    local keyb_icon = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/buttons/keyb_icon")
    local function State3(Train)
        local selected = Train:GetNW2String("PAM:Touching") ~= ""
        local keyboard = Train:GetNW2Bool("PAM:Keyboard")
        if keyboard then drawFrame(state3k,640-512,nil,512) else drawFrame(state3) end
        local sel = Train:GetNW2Int("PAM:Selected",1)
        local xadd = keyboard and 1 or 0
        drawTextBox(374,103+35*0,210,35,Train:GetNW2String("PAM:StationS",""),"Metrostroi_PAM30",not selected and sel == 1 and Color(79,252,246))
        drawTextBox(374,103+35*1,210,35,Train:GetNW2String("PAM:PathS",""),"Metrostroi_PAM30",not selected and sel == 2 and Color(79,252,246))
        drawTextBox(374,103+35*2,210,35,Train:GetNW2String("PAM:RouteNumber",""),"Metrostroi_PAM30",not selected and sel == 3 and Color(79,252,246))
        drawTextBox(374,103+35*3,210,35,Train:GetNW2String("PAM:DriverNumber",""),"Metrostroi_PAM30",not selected and sel == 4 and Color(79,252,246))
        drawTextBox(374,103+35*4,210,35,os.date("!%d.%m.%y %H:%M:%S",Metrostroi.GetSyncTime()),"Metrostroi_PAM30",sel == 5 and Color(79,252,246))
        if sel==1 then comboBox(Train,374,103+35*1) end
        local err = Train:GetNW2String("PAM:EnterError","")
        if err ~= "" then draw.SimpleText(err,"Metrostroi_PAM30",320+xadd*90,300, Color(213,18,8),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end
        local currStation = Train:GetNW2String("PAM:CurrentStationS")
        if currStation ~= "" then draw.SimpleText(currStation,"Metrostroi_PAM30",320+xadd*90,330, Color(0,165,13),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end
        buttonWTextC(156+xadd*127,369,120,51,"Ввод","Metrostroi_PAM30",Color(0,0,0), Train:GetNW2Bool("PAM:KeyEnter") and button_p or button)
        buttonWTextC(286+xadd*127,369,120,51,"Назад","Metrostroi_PAM30",Color(0,0,0), Train:GetNW2Bool("PAM:KeyEsc") and button_p or button)
        if Train:GetNW2Bool("PAM:KeyKeyB") or keyboard then drawButton(443+xadd*100,369,40,51, keyboard and button_p or button) end
        surface.SetDrawColor(255,255,255)
        surface.SetTexture(keyb_icon)
        surface.DrawTexturedRect(447+xadd*100,363,32,64)
        if keyboard then drawKeyboard(Train,22,47) end
    end
    local state35 = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/state35")
    local state35k = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/state35k")
    local function State35(Train)
        local selected = Train:GetNW2String("PAM:Touching") ~= ""
        local keyboard = Train:GetNW2Bool("PAM:Keyboard")

        if keyboard then drawFrame(state35k,640-512,nil,512) else drawFrame(state35) end
        local sel = Train:GetNW2Int("PAM:Selected",1)
        local xadd = keyboard and 1 or 0
        drawTextBox(374,103+35*0,210,35,Train:GetNW2String("PAM:StationS",""),"Metrostroi_PAM30",not selected and sel == 1 and Color(79,252,246))
        drawTextBox(374,103+35*1,210,35,Train:GetNW2String("PAM:PathS",""),"Metrostroi_PAM30",not selected and sel == 2 and Color(79,252,246))
        if sel==1 then comboBox(Train,374,103+35*1) end
        local err = Train:GetNW2String("PAM:EnterError","")
        if err ~= "" then draw.SimpleText(err,"Metrostroi_PAM30",320+xadd*90,260, Color(213,18,8),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end
        local currStation = Train:GetNW2String("PAM:CurrentStationS")
        if currStation ~= "" then draw.SimpleText(currStation,"Metrostroi_PAM30",320+xadd*90,330, Color(0,165,13),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end

        buttonWTextC(156+xadd*127,369,120,51,"Ввод","Metrostroi_PAM30",Color(0,0,0), Train:GetNW2Bool("PAM:KeyEnter") and button_p or button)
        buttonWTextC(286+xadd*127,369,120,51,"Назад","Metrostroi_PAM30",Color(0,0,0), Train:GetNW2Bool("PAM:KeyEsc") and button_p or button)

        if Train:GetNW2Bool("PAM:KeyKeyB") or keyboard then drawButton(443+xadd*100,369,40,51, keyboard and button_p or button) end
        surface.SetDrawColor(255,255,255)
        surface.SetTexture(keyb_icon)
        surface.DrawTexturedRect(447+xadd*100,363,32,64)

        if keyboard then drawKeyboard(Train,22,47,selected) end
    end

    local state4 = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/state4")
    local function State4(Train)
        drawFrame(state4)
        buttonWTextC(320-19,278,76,38,"Ввод","Metrostroi_PAM30",Color(0,0,0), Train:GetNW2Bool("PAM:KeyEnter") and button_p or button)
    end

    local function drawText2(x,y,text,state,col)
        if state then
            draw.SimpleText(text,"Metrostroi_PAM30",x,y, col or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        else
            draw.SimpleText(text,"Metrostroi_PAM30",x+1,y+1, Color(173,178,172),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            draw.SimpleText(text,"Metrostroi_PAM30",x,y, col or Color(142,147,146),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
    end
    local driveModes = {
        [0]="?",
        "ОС",
        "КС",
        "АВ",
        "ОР",
        "КР",
    }

    local KVModes = {
        [-4]="Т2",
        [-3]="Т1а",
        [-2]="Т1",
        [-1]="ОХТ",
        [0]="ОД",
        [1]="Х1",
        [2]="Х2",
        [3]="Х3",
    }
    local menus = {
        {"Проверка","скатывания"},
        {"Движение","без КД"},
        "Смена линии",
        {"Движение","транзитом"},
        {"Движение"," при Vд=0"},
        {"Открытие дверей","на перегоне"},
        {"Движение","без контроля ЛПТ"},
        {"Зонный","оборот"},
        {"Фиксация","станции"},
        [12]="Закрыть"
    }
    local acceptions = {
        [-7] = "Подтверди переход на другую линию",
        [-6] = "Подтверди осаживание при пожаре",
        [-4] = {"Подтверди движение по станционным","путям"},
        [-3] = "Подтверди переход в ОС",
        [-2] = "Подтверди переход в КС",
        [-1] = "Подтверди переход в АВ",
        "Подтвердите проверку скатывания",
        "Подтвердите движение без КД",
        "Подтвердите смену линии",
        "Подтвердите движение транзитом",
        "Подтвердите движение при Vд = 0",
        "Подтвердите открытие дверей на перегоне",
        "Подтвердите движение без контроля ЛПТ",
        "Подтвердите зонный оборот",
        [11]="Подтвердите отмену проверки скатывания",
        [12]="Подтвердите отмену движения без КД",
        [13]="Подтвердите отмену смены линии",
        [14]="Подтвердите отмену движения транзитом",
        [15]="Подтвердите отмену движения при Vд = 0",
        [16]={"Подтвердите отмену открытия дверей на","перегоне"},
        [17]="Подтвердите восстановление контроля ЛПТ",
        [18]="Подтвердите отмену зонного оборота",
    }
    local menusReset = {
        {"Проверка","скатывания"},
        {"Движение","без КД"},
        "Смена линии",
        "Транзит",
        {"Движение"," при Vд=0"},
        {"Открытие дверей","на перегоне"},
        {"Движение","без контроля ЛПТ"},
        "Оборот",
        [11]="Закрыть"
    }

    local errors = {
        "Открой правые двери",
        "Открой левые двери",
        "Переведи РР вперед",
        "Нет контроля открытия дверей",
        "Нет контроля закрытия дверей",
        "Нет блокировки дверей",
        "Разблокируй двери",
        "Не открыл двери! Подтвердись ПБ",
        "Несработка ДКП! Зафиксируйте станцию",
        "Отпусти пневмотормоз",
        "Выключите тумблер ВЗП",
        "Движение при Vд=0",
        "Нет набора скорости",
        "Для перехода сбросьте с хода",
        "Доложи диспетчеру Vд=0",
        "Выход на линию",
        "Установи реверсивную рукоятку",
        "Необходимо дополнительное включение",
        "РР в другой голове",
        "Переход в ОС",
        "Переход в КС",
        "Постоянное электропитание на КДЛ/КДП",
        "Введён транзит",
        "Отсутствует КСОТ",
        "Оборот",
        "Режим ОС",
        "Открой двери станции",
        "Перейди в КС",
        "Нет питания на 34 проводе(ЛКТ)",
        "Есть притание на 34 проводе",

        [51]={"Контроль дверей отменён"},
        [52]={"Контроль дверей восстановлен"},
        [53]={"Движение по станционным","путям запрещено",true},
        [54]={"Разрешено движение","при Vд = 0"},
        [55]={"Движение по станционным","путям разрешено"},
        [56]={"Открытие дверей на","перегоне разрешено"},
        [57]={"Открытие дверей на","перегоне запрещено",true},
        [58]={"Контроль ЛПТ отменён"},
        [59]={"Контроль ЛПТ","восстановлен"},
        [60]={"Движение под оборот","разрешено"},
        [61]={"Движение под оборот","запрещено",true},
        [62]={"Оборот отменён"},
        [63]={"Транзит разрешён"},
        [64]={"Транзит запрещён",true},
        [65]={"Транзит отменён"},
        [66]={"Осаживание при пожаре","разрешено"},
        [67]={"Осаживание при пожаре","запрещено",true},
        [68] = {"Режим КС разрешён"},
        [69] = {"Режим КС запрещён",true},
        [70] = {"Режим ОС разрешён"},
        [71] = {"Движение по станционным","путям",true},
        [72] = {"Проверка скатывания","запрещена",true}
    }
    local state5 = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/state5_main")
    local state5k = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/state5k_main")
    local state5b = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/state5b_main")
    local state5kb = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/state5kb_main")
    local question = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/question")
    local function State5(Train,isARS)
        local speed = Train:GetNW2Int("PAM:Vf")
        local mode = Train:GetNW2Int("PAM:Mode",0)
        local currentStation = Train:GetNW2String("PAM:CurrentStation")
        local targetStation = Train:GetNW2String("PAM:TargetStation")
        local speedLimit = Train:GetNW2Int("PAM:SpeedLimit")

        local driveMode = Train:GetNW2Int("PAM:DriveMode",0)
        local KVMode = Train:GetNW2Int("PAM:KVMode",0)

        local state = Train:GetNW2Int("PAM:State5",-1)
        local stateAcc = Train:GetNW2Int("PAM:State5Accept",0)
        local sel = Train:GetNW2Int("PAM:Selected",1)
        local block = state~=-1 or stateAcc~=0

        local ksd = Train:GetNW2Bool("PAM:KSD")

        surface.SetDrawColor(1,54,2)
        surface.DrawRect(2,70,541,35)
        if Train:GetNW2Bool("PAM:OXT") then
            drawSpeed(3,71,542/100*speed-5,33,Color(240,240,40))
        else
            drawSpeed(3,71,542/100*speed-5,33,Color(40,220,40))
        end
        if block then
            drawFrame(ksd and state5kb or state5b)
        else
            drawFrame(ksd and state5k or state5)
        end


        local date = Metrostroi.GetSyncTime()
        draw.SimpleText(os.date("!%d.%m.%y",date),"Metrostroi_PAM24",57,11, Color(199,199,199),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        draw.SimpleText(os.date("!%H:%M:%S",date),"Metrostroi_PAM28",59,32, Color(199,199,199),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

        --Train:GetNW2Int("PAM:Vf")
        --Train:GetNW2Int("PAM:Vd")
        --Train:GetNW2String("PAM:RC")
        --Train:GetNW2Float("PAM:S")
        --Линия
        draw.SimpleText(isARS and "?" or Train:GetNW2String("PAM:Line"),"Metrostroi_PAM28",239,13, Color(222,234,58),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        --Путь
        draw.SimpleText(isARS and "?" or Train:GetNW2String("PAM:Path"),"Metrostroi_PAM28",371,13, Color(222,234,58),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

        --Текущая
        draw.SimpleText(speed,"Metrostroi_PAM45",605,67, Color(20,239,32),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
        --Ограничение
        if speedLimit == -1 then
            draw.SimpleText("НЧ","Metrostroi_PAM45",605,104, Color(232,13,12),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
        elseif speedLimit <= 20 then
            draw.SimpleText(speedLimit,"Metrostroi_PAM45",605,104, Color(232,13,12),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
        else
            draw.SimpleText(speedLimit,"Metrostroi_PAM45",605,104, Color(246,242,0),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
        end

        if Train:GetNW2Bool("PAM:State5_5") then draw.SimpleText("Vд=0","Metrostroi_PAM28",145,70, Color(225,235,110),TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM) end
        if Train:GetNW2Bool("PAM:State5_2") then draw.SimpleText("КД","Metrostroi_PAM28",195,70, Color(225,235,110),TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM) end
        if Train:GetNW2Bool("PAM:State5_4") then draw.SimpleText("ТР","Metrostroi_PAM28",235,70, Color(225,235,110),TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM) end
        if Train:GetNW2Bool("PAM:State5_8") then draw.SimpleText("ОБ","Metrostroi_PAM28",275,70, Color(225,235,110),TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM) end
        if Train:GetNW2Bool("PAM:State5_3") then draw.SimpleText("СЛ","Metrostroi_PAM28",315,70, Color(225,235,110),TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM) end
        if Train:GetNW2Bool("PAM:State5_7") then draw.SimpleText("ЛПТ","Metrostroi_PAM28",365,70, Color(225,235,110),TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM) end
        if Train:GetNW2Bool("PAM:State5_6") then draw.SimpleText("ДП","Metrostroi_PAM28",420,70, Color(225,235,110),TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM) end

        if speedLimit == -1 then
            draw.SimpleText("НЧ","Metrostroi_PAM24",5,122, Color(232,13,12),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            Metrostroi.DrawLine(6,68,6,107,Color(246,242,0),3)
        elseif speedLimit == 0 then
            draw.SimpleText(0,"Metrostroi_PAM24",5,122, Color(232,13,12),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            Metrostroi.DrawLine(6,68,6,107,Color(246,242,0),3)
        elseif speedLimit <= 20 then
            draw.SimpleText(0,"Metrostroi_PAM24",5+5.42*20,122, Color(232,13,12),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            Metrostroi.DrawLine(6+5.42*20,68,6+5.42*20,107,Color(246,242,0),3)
        else
            draw.SimpleText(speedLimit,"Metrostroi_PAM24",5+5.42*speedLimit,122, Color(246,242,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            Metrostroi.DrawLine(6+5.42*speedLimit,68,6+5.42*speedLimit,107,Color(246,242,0),3)
        end

        local mess = Train:GetNW2Int("PAM:CurrentMessage",0)
        if mode == 6 then
            if mess==0 then mess = 21 end
        elseif mode == 3 then
            draw.SimpleText("T   = 00:00:00","Metrostroi_PAM31",0,412, Color(20,239,32),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText("пр","Metrostroi_PAM15",20,416, Color(20,239,32),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText(Format("Нагон=  0  с"),"Metrostroi_PAM28",175,411, Color(20,239,32),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText(Format("T    ="),"Metrostroi_PAM28",355,411, Color(20,239,32),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText("ост","Metrostroi_PAM15",374,416, Color(20,239,32),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText(math.Clamp(Train:GetNW2Int("PAM:BoardTime",0),-999,999),"Metrostroi_PAM28",443,411, Color(20,239,32),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText("с","Metrostroi_PAM28",470+3,411, Color(20,239,32),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            draw.SimpleText(Format("S=%.2fм",Train:GetNW2Float("PAM:S")),"Metrostroi_PAM31",639,412, Color(20,239,32),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)

            if not Train:GetNW2Bool("PAM:Shunt") then
                if mess == 0 then
                    draw.SimpleText(currentStation,"Metrostroi_PAM35",320,222, Color(20,239,32),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText(Format("%d путь",Train:GetNW2String("PAM:Path")),"Metrostroi_PAM35",320,258, Color(20,239,32),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                end
                if targetStation=="оборот" then
                    draw.SimpleText("оборот","Metrostroi_PAM26",639,11, Color(154,154,154),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
                else
                    draw.SimpleText(Format("до %s",targetStation),"Metrostroi_PAM26",639,11, Color(154,154,154),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
                end
                draw.SimpleText(currentStation,"Metrostroi_PAM25",639,34, Color(20,239,32),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
            end

        elseif mode == 2 then
            draw.SimpleText(Format("РЦ= %s",Train:GetNW2String("PAM:RC")),"Metrostroi_PAM31",0,412, Color(27,234,30),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            --draw.SimpleText(Format("Пикет="),"Metrostroi_PAM28",141,411, Color(27,234,30),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText(Format("Уклон= %d",Train:GetNW2Int("PAM:Slope",0)),"Metrostroi_PAM28",349,411, Color(27,234,30),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText(Format("S=%.2fм",Train:GetNW2Float("PAM:S")),"Metrostroi_PAM31",639,412, Color(27,234,30),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
            draw.SimpleText(Format("до %s",targetStation),"Metrostroi_PAM26",639,11, Color(154,154,154),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
            draw.SimpleText(currentStation,"Metrostroi_PAM25",639,34, Color(154,154,154),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
        elseif mode == 4 or mode == 5 then
            draw.SimpleText("РЦ= ","Metrostroi_PAM31",0,412, Color(27,234,30),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            --draw.SimpleText(Format("Пикет="),"Metrostroi_PAM28",141,411, Color(27,234,30),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText("Уклон=","Metrostroi_PAM28",349,411, Color(27,234,30),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText(Format("S=%.2fм",Train:GetNW2Float("PAM:S")),"Metrostroi_PAM31",639,412, Color(27,234,30),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
            draw.SimpleText(mode == 5 and "депо" or "оборот","Metrostroi_PAM26",639,11, Color(154,154,154),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
            draw.SimpleText(currentStation,"Metrostroi_PAM25",639,34, Color(154,154,154),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
        elseif not isARS then
            draw.SimpleText("РЦ=","Metrostroi_PAM31",0,412, Color(27,234,30),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            --draw.SimpleText("Пикет=","Metrostroi_PAM28",141,411, Color(27,234,30),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText("Уклон=","Metrostroi_PAM28",349,411, Color(27,234,30),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText(Format("S=%.2fм",Train:GetNW2Float("PAM:S")),"Metrostroi_PAM31",639,412, Color(27,234,30),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
            draw.SimpleText("выход на линию","Metrostroi_PAM26",639,11, Color(154,154,154),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
            draw.SimpleText(currentStation,"Metrostroi_PAM25",639,34, Color(154,154,154),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
        else
            draw.SimpleText("Режим АРС","Metrostroi_PAM60",320,200, Color(238,129,31),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
        if mess>0 then
            local mess = errors[50+mess]
            if #mess == 1 or #mess==2 and mess[2]==true then
                draw.SimpleText(mess[1],"Metrostroi_PAM35",320,240, mess[2] and Color(238,129,31) or Color(20,239,32),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            else
                draw.SimpleText(mess[1],"Metrostroi_PAM35",320,222, mess[3] and Color(238,129,31) or Color(20,239,32),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText(mess[2],"Metrostroi_PAM35",320,258, mess[3] and Color(238,129,31) or Color(20,239,32),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            end
        end
        local err = Train:GetNW2Int("PAM:CurrentError",0)
        if err>0 then
            draw.SimpleText(errors[err],"Metrostroi_PAM31",10,385, Color(225,235,110),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end

        --local function draw
        draw.SimpleText("1 АВ","Metrostroi_PAM29",3,173, Color(206,206,206),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        Metrostroi.DrawLine(4,173+14,16,173+14,Color(206,206,206),3)
        draw.SimpleText("1 АВ","Metrostroi_PAM29",2,172, Color(140,140,140),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        Metrostroi.DrawLine(3,172+14,15,172+14,Color(140,140,140),3)
        draw.SimpleText("7 Лин","Metrostroi_PAM29",570+1,262+1, Color(206,206,206),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        Metrostroi.DrawLine(571,262+14+1,584,262+14+1,Color(206,206,206),3)
        draw.SimpleText("7 Лин","Metrostroi_PAM29",570,262, Color(140,140,140),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        Metrostroi.DrawLine(570,262+14,583,262+14,Color(140,140,140),3)
        if isARS then
            draw.SimpleText("P Маш","Metrostroi_PAM29",3,306, Color(206,206,206),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            Metrostroi.DrawLine(4,305+14,18,305+14,Color(206,206,206),3)
            draw.SimpleText("P Маш","Metrostroi_PAM29",2,305, Color(140,140,140),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            Metrostroi.DrawLine(3,304+14,17,304+14,Color(140,140,140),3)

            draw.SimpleText("4 СтП","Metrostroi_PAM29",571,171, Color(206,206,206),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            Metrostroi.DrawLine(571,171+14,584,171+14,Color(206,206,206),3)
            draw.SimpleText("4 СтП","Metrostroi_PAM29",570,170, Color(140,140,140),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            Metrostroi.DrawLine(570,170+14,583,170+14,Color(140,140,140),3)

            draw.SimpleText("6 Пож","Metrostroi_PAM29",571,217, Color(206,206,206),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            Metrostroi.DrawLine(571,216+15,584,216+15,Color(206,206,206),3)
            draw.SimpleText("6 Пож","Metrostroi_PAM29",570,216, Color(140,140,140),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            Metrostroi.DrawLine(570,216+14,583,216+14,Color(140,140,140),3)
            draw.SimpleText("8 Отм","Metrostroi_PAM29",571,309, Color(206,206,206),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            Metrostroi.DrawLine(571,308+15,584,308+15,Color(206,206,206),3)
            draw.SimpleText("8 Отм","Metrostroi_PAM29",570,308, Color(140,140,140),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            Metrostroi.DrawLine(570,308+14,583,308+14,Color(140,140,140),3)
            draw.SimpleText("9 ФСт","Metrostroi_PAM29",571,355, Color(206,206,206),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            Metrostroi.DrawLine(571,354+15,584,354+15,Color(206,206,206),3)
            draw.SimpleText("9 ФСт","Metrostroi_PAM29",570,354, Color(140,140,140),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            Metrostroi.DrawLine(570,354+14,583,354+14,Color(140,140,140),3)
            for i=block and 1 or 0,0,-1 do
                local blocked = i==0 and block
                draw.SimpleText("2 КС","Metrostroi_PAM29",2+i,218+i, ((driveMode==2 or driveMode==4) and i==0) and Color(85,75,225) or blocked and Color(140,140,140) or Color(206,206,206),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                Metrostroi.DrawLine(3+i,218+14+i,15+i,218+14+i,((driveMode==2 or driveMode==4) and i==0) and Color(85,75,225) or blocked and Color(140,140,140) or Color(206,206,206),3)
                if ksd then
                    draw.SimpleText("3 ОС","Metrostroi_PAM29",2+i,264+i, ((driveMode==1 or driveMode==5) and i==0) and Color(85,75,225) or blocked and Color(140,140,140) or Color(206,206,206),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    Metrostroi.DrawLine(3+i,264+14+i,15+i,264+14+i,((driveMode==1 or driveMode==5) and i==0) and Color(85,75,225) or blocked and Color(140,140,140) or Color(206,206,206),3)
                end
                draw.SimpleText("8 Отм","Metrostroi_PAM29",570+i,308+i, blocked and Color(140,140,140) or Color(206,206,206),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                Metrostroi.DrawLine(570+i,308+14+i,583+i,308+14+i,blocked and Color(140,140,140) or Color(206,206,206),3)
            end
        else
            for i=block and 1 or 0,0,-1 do
                local blocked = i==0 and block
                draw.SimpleText("2 КС","Metrostroi_PAM29",2+i,218+i, ((driveMode==2 or driveMode==4) and i==0) and Color(85,75,225) or blocked and Color(140,140,140) or Color(206,206,206),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                Metrostroi.DrawLine(3+i,218+14+i,15+i,218+14+i,((driveMode==2 or driveMode==4) and i==0) and Color(85,75,225) or blocked and Color(140,140,140) or Color(206,206,206),3)
                if ksd then
                    draw.SimpleText("3 ОС","Metrostroi_PAM29",2+i,264+i, ((driveMode==1 or driveMode==5) and i==0) and Color(85,75,225) or blocked and Color(140,140,140) or Color(206,206,206),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    Metrostroi.DrawLine(3+i,264+14+i,15+i,264+14+i,((driveMode==1 or driveMode==5) and i==0) and Color(85,75,225) or blocked and Color(140,140,140) or Color(206,206,206),3)
                end
                draw.SimpleText("P Маш","Metrostroi_PAM29",2+i,305+i, blocked and Color(140,140,140) or Color(206,206,206),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                Metrostroi.DrawLine(3+i,304+14+i,17+i,304+14+i,blocked and Color(140,140,140) or Color(206,206,206),3)


                draw.SimpleText("4 СтП","Metrostroi_PAM29",570+i,170+i, blocked and Color(140,140,140) or Color(206,206,206),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                Metrostroi.DrawLine(570+i,170+14+i,583+i,170+14+i,blocked and Color(140,140,140) or Color(206,206,206),3)
                draw.SimpleText("6 Пож","Metrostroi_PAM29",570+i,216+i, (Train:GetNW2Bool("PAM:State5_-6") and i==0) and Color(85,75,225) or blocked and Color(140,140,140) or Color(206,206,206),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                Metrostroi.DrawLine(570+i,216+14+i,583+i,216+14+i,(Train:GetNW2Bool("PAM:State5_-6") and i==0) and Color(85,75,225) or blocked and Color(140,140,140) or Color(206,206,206),3)
                --draw.SimpleText("7 Лин","Metrostroi_PAM29",570+i,262+i, blocked and Color(140,140,140) or Color(206,206,206),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                --Metrostroi.DrawLine(570+i,262+14+i,583,262+14+i,blocked and Color(140,140,140) or Color(206,206,206),3)
                draw.SimpleText("8 Отм","Metrostroi_PAM29",570+i,308+i, blocked and Color(140,140,140) or Color(206,206,206),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                Metrostroi.DrawLine(570+i,308+14+i,583+i,308+14+i,blocked and Color(140,140,140) or Color(206,206,206),3)
                draw.SimpleText("9 ФСт","Metrostroi_PAM29",570+i,354+i, (mode == 3 and i==0) and Color(85,75,225) or blocked and Color(140,140,140) or Color(206,206,206),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                Metrostroi.DrawLine(570+i,354+14+i,583+i,354+14+i,(mode == 3 and i==0) and Color(85,75,225) or blocked and Color(140,140,140) or Color(206,206,206),3)
            end
        end
        if state==0 then
            surface.SetDrawColor(192,192,192,255)
            surface.DrawRect(0,119,636,248,0)
            for i,text in pairs(menus) do
                local color = (i==3 or isARS and (i==3 or i==4 or i==8 or i==9)) and Color(113,113,113) or i==sel and Color(255,255,255) or Color(0,0,0)

                local x,y = 212*((i-1)%3),119+(math.ceil(i/3)-1)*62
                drawButton(x,y,212,62, i==sel and button_s or button)
                if type(text)=="table" then
                    draw.SimpleText(text[1],"Metrostroi_PAM21",x+106+10,y+31-12, color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText(text[2],"Metrostroi_PAM21",x+106+10,y+31+12, color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                else
                    draw.SimpleText(text,"Metrostroi_PAM21",x+106+10,y+31, color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                end
                if i<12 then
                    draw.SimpleText(i%10,"Metrostroi_PAM35",x+17,y+31, color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    Metrostroi.DrawLine(x+10,y+48,x+24,y+48,color,3)
                end
            end
        elseif state==8 then
            drawWindow(0,120, 640,241,"Зонный оборот")
            local count = Train:GetNW2Int("PAM:ElemCount",0)
            for i=1,math.min(9,Train:GetNW2String("PAM:ElemCount",0)) do
                local selected = i==sel
                local color = selected and Color(255,255,255) or Color(0,0,0)

                local x,y = 4+210*((i-1)%3),152+(math.ceil(i/3)-1)*50
                drawButton(x,y,210,50, selected and button_s or button)
                local text = Train:GetNW2String("PAM:Elem"..i)
                draw.SimpleText(text:sub(1,-2),selected and "Metrostroi_PAM20" or "Metrostroi_PAM21",x+106+10,y+24-10, color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                if text[#text]=="1" then
                    draw.SimpleText("(непр) оборот",selected and "Metrostroi_PAM20" or "Metrostroi_PAM21",x+106+10,y+24+10, color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                else
                    draw.SimpleText("оборот",selected and "Metrostroi_PAM20" or "Metrostroi_PAM21",x+106+10,y+24+10, color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                end
                draw.SimpleText(i%10,"Metrostroi_PAM31",x+17,y+24, color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                Metrostroi.DrawLine(x+10,y+37,x+24,y+37,color,2)
                --x+28+18*i Train:SetNW2String("PAM:Elem"..iS,id.."\t"..(name or id))
            end
            buttonWTextC(4+210*1.5-145,152+3*50,140,50,"Да - Enter","Metrostroi_PAM25",Color(0,0,0),Train:GetNW2Bool("PAM:KeyEnter") and button_p or button)
            buttonWTextC(4+210*1.5+5,152+3*50,140,50,"Нет - Esc","Metrostroi_PAM25",Color(0,0,0),Train:GetNW2Bool("PAM:KeyEsc") and button_p or button)
            if Train:GetNW2Bool("PAM:ElemCountStart") then
                buttonWTextC(4+210*0,152+3*50,80,50,"◄","Metrostroi_PAM25",Color(0,0,0),Train:GetNW2Bool("PAM:KeyLeft") and button_p or button)
            end
            if Train:GetNW2Bool("PAM:ElemCountEnd") then
                buttonWTextC(4+210*3-80,152+3*50,80,50,"►","Metrostroi_PAM25",Color(0,0,0),Train:GetNW2Bool("PAM:KeyRight") and button_p or button)
            end
        elseif state==-8 then
            drawWindow(0,120, 640,241,"Введенные запросы")
            for i,text in pairs(menusReset) do
                if Train:GetNW2Bool("PAM:State5_"..i) or i==11 then
                    local selected = i==sel
                    local disabled = i==5 or i==6
                    local color = disabled and Color(113,113,113) or selected and Color(255,255,255) or Color(0,0,0)

                    local x,y = 4+210*((i-1)%3),152+(math.ceil(i/3)-1)*50
                    drawButton(x,y,209,49, selected and button_s or button)
                    if type(text)=="table" then
                        draw.SimpleText(text[1],selected and "Metrostroi_PAM20" or "Metrostroi_PAM21",x+106+10,y+24-10, color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        draw.SimpleText(text[2],selected and "Metrostroi_PAM20" or "Metrostroi_PAM21",x+106+10,y+24+10, color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    else
                        draw.SimpleText(text,selected and "Metrostroi_PAM20" or "Metrostroi_PAM21",x+106+10,y+24, color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    end
                    if i<11 and not disabled then
                        draw.SimpleText(i%10,"Metrostroi_PAM31",x+17,y+24, color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        Metrostroi.DrawLine(x+10,y+37,x+24,y+37,color,2)
                    end
                end
            end
            Metrostroi.DrawLine(4,202,640-8,202,Color(113,113,113),2)
            Metrostroi.DrawLine(4,252,640-8,252,Color(113,113,113),2)
            Metrostroi.DrawLine(4,302,640-8,302,Color(113,113,113),2)
            Metrostroi.DrawLine(214,154,214,351,Color(113,113,113),2)
            Metrostroi.DrawLine(424,154,424,351,Color(113,113,113),2)
        elseif state==1 then
            drawWindow(82,160, 484,180,"Режим проверки скатывания")
            buttonWTextC(139,270,370,50,"Завершить скатывание (Esc)","Metrostroi_PAM30",Color(0,0,0), Train:GetNW2Bool("PAM:KeyEsc") and button_p or button)
            local dist = Train:GetNW2Float("PAM:RollDist",0)
            draw.SimpleText("Скатывание на","Metrostroi_PAM30",110,225, Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

            draw.SimpleText(Format("%.2f",dist),"Metrostroi_PAM35",380,225, Color(0,0,0),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)

            draw.SimpleText("м","Metrostroi_PAM30",395,225, Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            if dist >= 0 then
                draw.SimpleText("вперед","Metrostroi_PAM30",440,225, Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            else
                draw.SimpleText("назад","Metrostroi_PAM30",440,225, Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            end
        elseif state==-5 then
            local selected = Train:GetNW2String("PAM:Touching") ~= ""
            local keyboard = Train:GetNW2Bool("PAM:Keyboard")

            drawWindow(keyboard and 80+112 or 80,145,keyboard and 480-(112-79) or 480,261,"Смена машиниста")
            local sel = Train:GetNW2Int("PAM:Selected",1)
            local xadd = keyboard and 1 or 0
            if keyboard then
                draw.SimpleText("Номер маршрута","Metrostroi_PAM27",99+112-10,201, Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText("Табельный номер","Metrostroi_PAM27",99+112-10,201+39, Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            else
                draw.SimpleText("Номер маршрута","Metrostroi_PAM27",99,201, Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText("Табельный номер","Metrostroi_PAM27",99,201+39, Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            end
            drawTextBox(320+102*xadd,190+39*0,225-15*xadd,31,Train:GetNW2String("PAM:RouteNumber",""),"Metrostroi_PAM30",not selected and sel == 1 and Color(79,252,246))
            drawTextBox(320+102*xadd,190+39*1,225-15*xadd,31,Train:GetNW2String("PAM:DriverNumber",""),"Metrostroi_PAM30",not selected and sel == 2 and Color(79,252,246))
            local err = Train:GetNW2String("PAM:EnterError","")
            if err ~= "" then draw.SimpleText(err,"Metrostroi_PAM30",325+xadd*90,275, Color(213,18,8),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end

            buttonWTextC(190+xadd*79,320,75+1*65,50,"Ввод","Metrostroi_PAM30",Color(0,0,0), Train:GetNW2Bool("PAM:KeyEnter") and button_p or button)
            buttonWTextC(288+42+10+xadd*79,320,120+1*20,50,"Закрыть","Metrostroi_PAM30",Color(0,0,0), Train:GetNW2Bool("PAM:KeyEsc") and button_p or button)

            if Train:GetNW2Bool("PAM:KeyKeyB") or keyboard then drawButton(501+xadd*79,320,40,51, keyboard and button_p or button) end
            surface.SetDrawColor(255,255,255)
            surface.SetTexture(keyb_icon)
            surface.DrawTexturedRect(505+xadd*79,314,32,64)

            if keyboard then drawKeyboard(Train,0,47,selected) end
        elseif state==9 then
            local selected = Train:GetNW2String("PAM:Touching") ~= ""
            local keyboard = Train:GetNW2Bool("PAM:Keyboard")

            drawWindow(keyboard and 82+130 or 82,145,keyboard and 484-(130-40) or 484,261,"Фиксация станции")
            local sel = Train:GetNW2Int("PAM:Selected",1)
            local xadd = keyboard and 1 or 0
            if keyboard then
                draw.SimpleText("Станция","Metrostroi_PAM27",99+130,201, Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText("Путь","Metrostroi_PAM27",99+130,201+39, Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            else
                draw.SimpleText("Код станции","Metrostroi_PAM27",99,201, Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText("Номер пути","Metrostroi_PAM27",99,201+39, Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            end
            drawTextBox(322+40*xadd,190+39*0,229,31,Train:GetNW2String("PAM:StationS",""),"Metrostroi_PAM30",not selected and sel == 1 and Color(79,252,246))
            drawTextBox(322+40*xadd,190+39*1,229,31,Train:GetNW2String("PAM:PathS",""),"Metrostroi_PAM30",not selected and sel == 2 and Color(79,252,246))
            local err = Train:GetNW2String("PAM:EnterError","")
            if err ~= "" then draw.SimpleText(err,"Metrostroi_PAM30",325+xadd*90,275, Color(213,18,8),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end
            local currStation = Train:GetNW2String("PAM:CurrentStationS")
            if currStation ~= "" then draw.SimpleText(currStation,"Metrostroi_PAM30",325+xadd*90,301, Color(0,165,13),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end

            buttonWTextC(190+xadd*39,320,75+xadd*65,50,"Ввод","Metrostroi_PAM30",Color(0,0,0), Train:GetNW2Bool("PAM:KeyEnter") and button_p or button)
            buttonWTextC(288+xadd*(42+39+10),320,120+xadd*20,50,"Закрыть","Metrostroi_PAM30",Color(0,0,0), Train:GetNW2Bool("PAM:KeyEsc") and button_p or button)

            if Train:GetNW2Bool("PAM:KeyKeyB") or keyboard then drawButton(501+xadd*40,320,40,51, keyboard and button_p or button) end
            surface.SetDrawColor(255,255,255)
            surface.SetTexture(keyb_icon)
            surface.DrawTexturedRect(505+xadd*40,314,32,64)

            if sel==1 then comboBox(Train,320+40*xadd,200+29*1) end
            if keyboard then drawKeyboard(Train,10,47,selected) end
        end
        if stateAcc ~= 0 then
            local text = acceptions[stateAcc]
            surface.SetFont("Metrostroi_PAM21")
            local y,x=21
            if type(text) == "table" then
                x = surface.GetTextSize(text[1])
                y=42
            else x = surface.GetTextSize(text) end
            drawWindow(320-x/2-36,240-72-16,x+72,128+y+16,"Подтверждение")
            surface.SetTexture(question)
            surface.DrawTexturedRect(296-x/2,200,32,32)
            if type(text) == "table" then
                draw.SimpleText(text[1],"Metrostroi_PAM21",336-x/2,210, Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText(text[2],"Metrostroi_PAM21",336-x/2,210+21, Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            else
                draw.SimpleText(text,"Metrostroi_PAM21",336-x/2,210, Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            end

            buttonWTextC(194,219+y,120,50,"Да - Enter","Metrostroi_PAM21",Color(0,0,0), Train:GetNW2Bool("PAM:KeyEnter") and button_p or button)
            buttonWTextC(326,219+y,120,50,"Нет - Esc","Metrostroi_PAM21",Color(0,0,0), Train:GetNW2Bool("PAM:KeyEsc") and button_p or button)
        end


        drawText2(201,441,Format("%s = %s",driveModes[driveMode],KVModes[KVMode]),true)

        local VZ = Train:GetNW2Int("PAM:V",0)
        if VZ > 0 then
            drawText2(307,441,"В"..VZ,true)
        elseif VZ==-1 then
            drawText2(307,441,"ЭПК",true)
        else
            drawText2(307,441,"В",false)
        end

        drawText2(386,441,"ЛПТ",Train:GetNW2Bool("PAM:LPT"))
        local KD = Train:GetNW2Int("PAM:KD",2)
        if KD == 2 then
            drawText2(465,441,"КД",true,Color(213,15,15))
        elseif KD==1 then
            drawText2(465-1,441-1,"КД",false,Color(238,129,31))
        else
            drawText2(465,441,"КД",true,Color(0,0,0))
        end

        if ksd then
            drawText2(320,467,"Зона ОПВ",Train:GetNW2Bool("PAM:OPV"))
        else
            drawText2(181.5,467,"АРС",Train:GetNW2Bool("PAM:KVARS"))
            drawText2(273.5,467,"ПСР",false)
            drawText2(365.5,467,"ВРД",Train:GetNW2Bool("PAM:VRD"))
            drawText2(458,467,"ОПВ",Train:GetNW2Bool("PAM:OPV"))
        end
    end
    local function drawBlink_(x,y) if CurTime()%0.4 > 0.2 then draw.SimpleText("_","Metrostroi_PAM30",x, y,Color(150,150,150),TEXT_ALIGN_LEFT,TEXT_ALIGN_BOTTOM) end end
    local bios_splash = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/bios_splash")
    local splash = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/splash")
    local splash_egg = surface.GetTextureID("models/metrostroi_train/81-717/screens/pa/splash_egg")
    function TRAIN_SYSTEM:PAMScreen(Train)
        --surface.SetTexture(splash_egg)
        --surface.SetDrawColor(255,255,255)
        --surface.DrawTexturedRectRotated(512,256,1024,512,0)

        local state = Train:GetNW2Float("PAM:State",0)

        if state ~= 0 and state ~= -1 and state ~= -0.5 then
            surface.SetDrawColor(50,50,50,100)
            surface.DrawRect(0,0,640,480,0)
            if state == -100 then stateDebug(Train) end
            if state < 0 then
                local time = Train:GetNW2Float("PAM:StartTimer",0)
                if state == -2 then
                    if time > 0.4 then drawBlink_(620,440) else drawBlink_(5,20) end
                end
                if state == -3 then drawFrame(bios_splash) end
                if state == -4 then
                    if time > 0.5 then drawBlink_(5,40) else drawBlink_(5,20) end
                end
                if state == -5 then drawFrame(splash) end
            end

            if state == 1 then State1(Train) end
            if state == 1.5 then State1_5(Train) end
            if state == 2 then State2(Train) end
            if state == 3 then State3(Train) end
            if state == 3.5 then State35(Train) end
            if state == 4 then State4(Train) end
            if state == 5 then State5(Train) end
            if state == 6 then State5(Train,true) end
            surface.SetDrawColor(0,0,0,150)
            surface.DrawRect(0,0,640,480,0)
        end
    end
    return
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "KSDMode" then
        self.PAKSD = value>0
        self.Train:SetNW2Bool("PAM:KSD",self.PAKSD)
    end
end

function TRAIN_SYSTEM:UpdateStationList(entered,id)
    local Train = self.Train
    if not entered or #entered < 1 or #entered > 2 then
        Train:SetNW2Int("PAM:ElemCount",0)
        self.ScrollCount = 0
        self.Scroll = 0
        return
    end
    local iS = 0
    if #entered < 3 then
        local line = tonumber(entered[1])
        local tbl = Metrostroi.PAMStations[line]
        if id then
            if tbl then
                for k,station in ipairs(tbl) do
                    if string.find(tostring(station.id),"^"..entered) then
                        if iS < 8+self.Scroll and iS >= self.Scroll and (iS+1-self.Scroll)==id then
                            return station.id
                        end
                        iS = iS + 1
                    end
                end
            end
            return
        else
            self.LineS = line
            if tbl then
                for k,station in ipairs(tbl) do
                    if string.find(tostring(station.id),"^"..entered) then
                        if iS < 8+self.Scroll and iS >= self.Scroll then
                            local id,name = station.id,station.name
                            Train:SetNW2String("PAM:Elem"..(iS+1-self.Scroll),id.."\t"..(name or id))
                        end
                        iS = iS + 1
                    end
                end
            end
        end
    end
    Train:SetNW2Int("PAM:ElemCount",math.min(8,iS))
    self.ScrollCount = iS
    self.Scroll = math.Clamp(self.Scroll,0,math.max(0,self.ScrollCount-8))
    --end
end
function TRAIN_SYSTEM:UpdateLastStationList()
    local Train = self.Train
    local iS = 0
    local dist = self.Distance
    local line = self.Line
    local path = tonumber(self.Path)
    local tbl = Metrostroi.PAMConfTest and Metrostroi.PAMConfTest[line] and Metrostroi.PAMConfTest[line][path]
    if not tbl then return end
    self.Scroll = math.Clamp(self.Scroll,0,math.max(0,math.ceil(((self.ScrollCount or 0)-9)/9)*9))
    self.DeadlockS = nil
    local curr
    if self.Mode==2 or self.Mode==3 and not self.Shunt then
        for i,stat in ipairs(tbl[1].stations) do
            if i<#tbl[1].stations  then
                if not curr and tostring(self.Station)==tostring(stat.id) then
                    curr=i
                end
                if curr and i>=curr and stat.isLast then
                    if iS < 9+self.Scroll and iS >= self.Scroll then
                        local id = (iS+1-self.Scroll)
                        Train:SetNW2String("PAM:Elem"..id,stat.name..(stat.isInWrong and 1 or 0))
                        if self.Selected == id then self.DeadlockS = stat end
                    end
                    iS = iS + 1
                end
            end
        end
    end
    if self.Selected>0 and self.DeadlockS == nil then self.Selected = 0 end
    Train:SetNW2Int("PAM:ElemCount",math.min(10,iS-self.Scroll))
    Train:SetNW2Bool("PAM:ElemCountStart",self.Scroll>=9)
    Train:SetNW2Bool("PAM:ElemCountEnd",(iS-self.Scroll)>9)
    self.ScrollCount = iS
    self.Scroll = math.Clamp(self.Scroll,0,math.max(0,math.ceil((self.ScrollCount-9)/9)*9))
    --end
end
function TRAIN_SYSTEM:Trigger(name,value,press)
    local Train = self.Train
    Train:SetNW2Bool("PAM:Key"..name,value)
    if press and value then
        self.Train:PlayOnce("pa_"..name:lower(),"bass",1)
    end
    if name == "KeyB" and not value then self.Keyboard = not self.Keyboard end
    if self.State == 1 and not value then
        if name == "Esc" then self:SetState(1.5,0.1) end
        if name == "Enter" and self.ReverserWrench then
            if self.GoodSetup then
                self:SetState(2,0.1)
            else
                self:SetState(6,0.1)
            end
        end
    elseif self.State == 1.5 and name == "Esc" and not value then
        self:SetState(1,0.1)
    elseif self.State == 2 then
        if name == "Down" and value then
            self.Selected = self.Selected < 4 and self.Selected+1 or 1
            if not self.HaveRestart and self.Selected == 2 then self.Selected = 3 end
        end
        if name == "Up" and value then
            self.Selected = self.Selected > 1 and self.Selected-1 or 4
            if not self.HaveRestart and self.Selected == 2 then self.Selected = 1 end
        end
        if name == "1" and value then self.Selected = 1 end
        if name == "2" and self.HaveRestart and value then self.Selected = 2 end
        if name == "Esc" and value then self.Selected = 3 end
        if name == "M" and value then self.Selected = 4 end
        if (name == "Esc" or name == "Enter") and not value and self.Selected == 3 then self:SetState(1,0.1) end
        if (name == "1" or name == "Enter") and not value and self.Selected == 1 then self:SetState(3,0.1) end
        if self.HaveRestart and (name == "2" or name == "Enter") and not value and self.Selected == 2 then self:SetState(3.5,0.1) end
        if (name == "M" or name == "Enter") and not value and self.Selected == 4 then self:SetState(2,0.1) end
    elseif self.State == 3 then
        if name == "Down" and value then self.Selected = self.Selected < 4 and self.Selected+1 or 1 end
        if name == "Up" and value then self.Selected = self.Selected > 1 and self.Selected-1 or 4 end
        local num = tonumber(name)
        if num and value then
            if self.Selected == 1 and #self.StationS < 3 then
                self.StationS = self.StationS..num
                self.Scroll = 0
                self:UpdateStationList(self.StationS)
            end
            if self.Selected == 2 and #self.PathS < #tostring(Metrostroi.LineCount) then self.PathS = self.PathS..num end
            if self.Selected == 3 and #self.RouteNumberS < 3 then self.RouteNumberS = self.RouteNumberS..num end
            if self.Selected == 4 and #self.DriverNumberS < 4 then self.DriverNumberS = self.DriverNumberS..num end
        end
        if name == "Left" and value then
            if self.Selected == 1 then
                self.StationS = self.StationS:sub(1,-2)
                self.Scroll = 0
                self:UpdateStationList(self.StationS)
            end
            if self.Selected == 2 then self.PathS = self.PathS:sub(1,-2) end
            if self.Selected == 3 then self.RouteNumberS = self.RouteNumberS:sub(1,-2) end
            if self.Selected == 4 then self.DriverNumberS = self.DriverNumberS:sub(1,-2) end
        end
        if name == "Esc" and not value then self:SetState(2,0.1) end
        if name == "Enter" and not value then
            if #self.StationS < 3 or not Metrostroi.PAMStations[self.LineS] or not Metrostroi.PAMStations[self.LineS][tonumber(self.StationS)] then
                Train:SetNW2String("PAM:EnterError","Неверный номер станции")
            elseif #self.PathS < #tostring(Metrostroi.LineCount) or not Metrostroi.PAMConfTest[self.LineS][tonumber(self.PathS)] then
                Train:SetNW2String("PAM:EnterError","Неверный номер пути")
            elseif #self.RouteNumberS < 3 then
                Train:SetNW2String("PAM:EnterError","Неверный номер маршрута")
            elseif #self.DriverNumberS < 4 then
                Train:SetNW2String("PAM:EnterError","Неверный табельный номер")
            else
                self:SetState(4,0.1)
            end
        end
    elseif self.State == 3.5 then
        if name == "Down" and value then self.Selected = self.Selected < 2 and self.Selected+1 or 1 end
        if name == "Up" and value then self.Selected = self.Selected > 1 and self.Selected-1 or 2 end
        local num = tonumber(name)
        if num and value then
            if self.Selected == 1 and #self.StationS < 3 then
                self.StationS = self.StationS..num
                self.Scroll = 0
                self:UpdateStationList(self.StationS)
            end
            if self.Selected == 2 and #self.PathS < 1 then self.PathS = self.PathS..num end
        end
        if name == "Left" and value then
            if self.Selected == 1 then
                self.StationS = self.StationS:sub(1,-2)
                self.Scroll = 0
                self:UpdateStationList(self.StationS)
            end
            if self.Selected == 2 then self.PathS = self.PathS:sub(1,-2) end
        end
        if name == "Esc" and not value then self:SetState(2,0.1) end
        if name == "Enter" and not value then
            if #self.StationS < 3 or not Metrostroi.PAMStations[self.LineS] or not Metrostroi.PAMStations[self.LineS][tonumber(self.StationS)] then
                Train:SetNW2String("PAM:EnterError","Неверный номер станции")
            elseif #self.PathS < #tostring(Metrostroi.LineCount) or not Metrostroi.PAMConfTest[self.Line][tonumber(self.PathS)] then
                Train:SetNW2String("PAM:EnterError","Неверный номер пути")
            else
                self:SetState(5,0.1)
            end
        end
    elseif self.State == 4 and not self.Stopping and name == "Enter" and not value then
        self:SetState(5,0.1)
    elseif self.State >= 5 then
        local char = tonumber(name)
        --if char and not value and self.Selected == char then self.State5 = char+1 end
        if self.State5Accept then
            local PAM_VV = Train.PAM_VV
            if name == "Enter" and not value then
                if self.State5Accept == 1 then
                    if PAM_VV.KD < 1 and not self.NoKD and PAM_VV.KRU == 0 then
                        self:Message(22)
                    else
                        self.State5 = 1
                    end
                elseif self.State5Accept == 2 then
                    self.NoKD = true
                    self:Message(1)
                elseif self.State5Accept == 4 then
                    if self.State == 5 and (self.Mode == 2 or self.Mode == 3) then
                        self.Transit = true
                        self:Message(13)
                    else
                        self:Message(14)
                    end
                elseif self.State5Accept == 5 and self.ZeroStopped then
                    self.Vd0 = true
                    self:Message(4)
                elseif self.State5Accept == 6 then
                    if self.Speed<2.5 and (PAM_VV.LPT>0 or self.NoLPT or PAM_VV.V1>0) then
                        self.OpenDoors = true
                        self:Message(6)
                    else
                        self.OpenDoors = false
                        self:Message(7)
                    end
                elseif self.State5Accept == -6 then
                    local prev = self:FindPrevStation()
                    if self.State == 5 and (self.StationTable and (prev and self.Distance-prev.pos < 120 or self.Distance-self.StationTable.pos<120) and self.Speed<0.2) then
                        self.FireBack = prev
                        self:Message(16)
                    else
                        self.FireBack = false
                        self:Message(17)
                    end
                elseif self.State5Accept == -1 then
                    --AV
                elseif self.State5Accept == -2 then
                    if PAM_VV.KSOT == 0 or not self.ControlMode2 then
                        self:Error(24,true,7,true)
                        self:Message(19)
                    else
                        self.ControlMode=2
                        self.ControlModeAuto = false
                        self:Message(18)
                    end
                elseif self.State5Accept == -3 then
                    self.ControlMode=1
                    self.ControlModeAuto = false
                    self:Message(20)
                elseif self.State5Accept == -4 then
                    if self.State == 5 and (self.Speed<0.2 and (self.StationTable.isLast or self.StationTable.hasSwitches)) then
                        self:Message(5)
                        self.Shunt = true
                    else
                        self:Message(3)
                    end
                elseif self.State5Accept == 7 then
                    self.NoLPT = true
                    self:Message(8)
                elseif self.State5Accept == 12 then
                    self.NoKD = false
                    self:Message(2)
                elseif self.State5Accept == 14 then
                    self.Transit = false
                    self:Message(15)
                elseif self.State5Accept == 15 then self.Vd0 = false
                elseif self.State5Accept == 16 then self.OpenDoors = false
                elseif self.State5Accept == 17 then
                    self.NoLPT = false
                    self:Message(9)
                elseif self.State5Accept == 18 then
                    self.Deadlock = nil
                    self:Message(12)
                else
                    self.State5 = self.State5Accept
                    if self.State5 == 8 then
                        self.Selected = 0
                        self.Scroll = 0
                        self:UpdateLastStationList()
                    end
                end
                self.State5Accept = nil
            end
            if name == "Esc" and not value then self.State5 = nil self.State5Accept = nil end
        elseif self.State5 == 0 then
            if char and value and char ~= 3 and (self.State == 5 or (char==1 or char==2 or 5<=char and char<=7)) then self.Selected = char end
            if char and not value and char==self.Selected then
                self.State5 = nil
                if char == 9 and self.State == 5 then
                    self:Trigger("9",true)
                    self:Trigger("9",false)
                else
                    self.State5Accept = char
                end
            end
            if name == "Esc" and value then self.Selected = 12 end
            if name == "Esc" and not value and self.Selected == 12 then self.State5 = nil end
        elseif self.State5 == 8 then
            if name == "Esc" and not value then
                self.State5 = nil
                self.DeadlockS = nil
            end
            if name == "Enter" and not value then
                self.State5 = nil
                if true or not self.Transit then
                    self.Deadlock = self.DeadlockS
                    self:Message(10)
                else
                    self:Message(11)
                end
            end
            if (name == "Left" or name == "Right") and not value then
                self.Scroll = name == "Right" and self.Scroll+9 or math.max(self.Scroll-9,0)
                self.Selected = 0
                self:UpdateLastStationList()
            end
            if char and value then
                self.Selected = char
                self:UpdateLastStationList()
            end
        elseif self.State5 == -8 then
            local charAccept = char and Train:GetNW2Bool("PAM:State5_"..char)
            if charAccept and value and (char~=5 and char~=6) then self.Selected = char end
            if charAccept and not value and char==self.Selected then
                self.State5 = nil
                self.State5Accept = 10+char
            end
            if name == "Esc" and value then self.Selected = 11 end
            if name == "Esc" and not value and self.Selected == 11 then self.State5 = nil end
        elseif self.State5 == 1 then
            if name == "Esc" and not value then
                self.State5 = nil
                Train:SetNW2Float("PAM:RollDist",0)
            end
        elseif self.State5 == -5 then
            if name == "Down" and value then self.Selected = self.Selected < 2 and self.Selected+1 or 1 end
            if name == "Up" and value then self.Selected = self.Selected > 1 and self.Selected-1 or 2 end
            local num = tonumber(name)
            if num and value then
                if self.Selected == 1 and #self.RouteNumberS < 3 then self.RouteNumberS = self.RouteNumberS..num end
                if self.Selected == 2 and #self.DriverNumberS < 4 then self.DriverNumberS = self.DriverNumberS..num end
            end
            if name == "Left" and value then
                if self.Selected == 1 then self.RouteNumberS = self.RouteNumberS:sub(1,-2) end
                if self.Selected == 2 then self.DriverNumberS = self.DriverNumberS:sub(1,-2) end
            end
            if name == "Esc" and not value then self.State5 = nil end
            if name == "Enter" and not value then
                if #self.RouteNumberS < 3 then
                    Train:SetNW2String("PAM:EnterError","Неверный номер маршрута")
                elseif #self.DriverNumberS < 4 then
                    Train:SetNW2String("PAM:EnterError","Неверный табельный номер")
                else
                    self.RouteNumber = self.RouteNumberS
                    self.DriverNumber = self.DriverNumberS
                    self.RouteNumberS = nil
                    self.DriverNumberS = nil
                    self.State5 = nil
                end
            end
        elseif self.State5 == 9 then
            if name == "Down" and value then self.Selected = self.Selected < 2 and self.Selected+1 or 1 end
            if name == "Up" and value then self.Selected = self.Selected > 1 and self.Selected-1 or 2 end
            local num = tonumber(name)
            if num and value then
                if self.Selected == 1 and #self.StationS < 3 then
                    self.StationS = self.StationS..num
                    self.Scroll = 0
                    self:UpdateStationList(self.StationS)
                end
                if self.Selected == 2 and #self.PathS < 1 then self.PathS = self.PathS..num end
            end
            if name == "Left" and value then
                if self.Selected == 1 then
                    self.StationS = self.StationS:sub(1,-2)
                    self.Scroll = 0
                    self:UpdateStationList(self.StationS)
                end
                if self.Selected == 2 then self.PathS = self.PathS:sub(1,-2) end
            end
            if name == "Esc" and not value then
                self.State5 = nil
            end
            if name == "Enter" and not value then
                if #self.StationS < 3 or not Metrostroi.PAMStations[self.Line] or not Metrostroi.PAMStations[self.Line][tonumber(self.StationS)] then
                    Train:SetNW2String("PAM:EnterError","Неверный номер станции")
                elseif #self.PathS < #tostring(Metrostroi.LineCount) or not Metrostroi.PAMConfTest[self.Line][tonumber(self.PathS)] then
                    Train:SetNW2String("PAM:EnterError","Неверный номер пути")
                else
                    if self.Speed < 2.5 then
                        self.Station = self.StationS
                        self.Path = self.PathS
                        self:SetMode(1)
                        self.Distance = self.StationTable.pos+0.001
                        self:SetMode(3)
                        self:FindSensor(self.Distance,true)
                    end
                    self.StationS = nil
                    self.PathS = nil
                    self.State5 = nil
                end
            end
        else
            if name == "F" and value then
                self.State5 = 0
                self.Selected = 1
            end

            --if name == "1" and value then self.State5Accept=-1 end
            if name == "2" and value then self.State5Accept=-2 end
            if name == "3" and self.PAKSD and value then self.State5Accept=-3 end
            if self.State==5 then
                if name == "P" and value then
                    self.State5 = -5
                    self.Selected = 1
                    self.RouteNumberS = ""
                    self.DriverNumberS = ""
                    self.KeyboardX,self.KeyboardY = 0,47
                    Train:SetNW2String("PAM:EnterError","")
                end
                if name == "4" and value then self.State5Accept=-4 end
                if name == "6" and value then self.State5Accept=-6 end
                --if name == "7" and value then self.State5Accept=-7 end
                if name == "8" and value then self.State5=-8 self.Selected = 0 end
                if name == "9" and value then
                    self.State5=9
                    self.Selected = 1
                    self.StationS = ""--tostring(self.Station)
                    self.PathS = ""--tostring(self.Path)
                    self.KeyboardX,self.KeyboardY = 10,47
                    Train:SetNW2String("PAM:EnterError","")
                    self:UpdateStationList(self.StationS)
                end
            end
        end
    end
end
local keys = {
                    "P",
      "F" , "Up" ,  "M",
    "Left","Down","Right",
      "1" , "2"  ,  "3",
      "4" , "5"  ,  "6",
      "7" , "8"  ,  "9",
    "Esc" , "0"  ,"Enter",
}
local acceptions = {
    [-7] = 1,
    [-6] = 1,
    [-4] = 2,
    [-3] = 1,
    [-2] = 1,
    [-1] = 1,
    1,1,1,1,1,1,1,1,
    [11]=1,
    [12]=1,
    [13]=1,
    [14]=1,
    [15]=1,
    [16]=2,
    [17]=1,
    [18]=1,
}
local acceptionsReset = {
    1,1,1,1,1,2,1,1,
}
function TRAIN_SYSTEM:Touch(value,x,y)
    local Train = self.Train
    Train:SetNW2String("PAM:Touching","")
    if self.Keyboard and (self.State==3 or self.State==3.5 or self.State==5 and self.State5==9) then
        for i,keyName in ipairs(keys) do
            local key = i+1
            local xp = key%3
            local yp = math.floor(key/3)
            if math.InRangeXYR(x,y,self.KeyboardX+5+60*xp,self.KeyboardY+33+49*yp,60,49) then
                self.Touches[keyName] = true
                Train:SetNW2String("PAM:LastToucn",keyName)
                if value then Train:SetNW2String("PAM:Touching",keyName) end
                break
            end
        end
    end
    if not value then
        for k in pairs(self.Touches) do self.Touches[k] = false end
        return
    end
    if self.State == 1 then
        if value and math.InRangeXYR(x,y,542,self.ReverserWrench and 316 or 352,77,51) then self.Touches["Esc"] = true return end
        if value and math.InRangeXYR(x,y,265,410,110,51) then self.Touches["Enter"] = true return end
    elseif self.State == 1.5 then
        if value and math.InRangeXYR(x,y,238,408,164,51) then self.Touches["Esc"] = true return end
    elseif self.State == 2 then
        if math.InRangeXYR(x,y,320-298,121+59*0,596,50) then self.Touches["1"] = true return end
        if math.InRangeXYR(x,y,320-298,121+59*1,596,50) then self.Touches["2"] = true return end
        if math.InRangeXYR(x,y,320-298,121+59*2,596,50) then self.Touches["Esc"] = true return end
        if math.InRangeXYR(x,y,320-298,121+59*4+10,596,50) then self.Touches["M"] = true return end
    elseif self.State == 3 or self.State == 3.5 then
        if self.Selected==1 and self.ScrollCount and self.ScrollCount > 0 then
            local xa,ya = 374,103+35*1
            if math.InRangeXYR(x,y,xa+219,ya+5,31,15) or math.InRangeXYR(x,y,xa+219,ya+128,31,14) then
                self.Scroll = math.max(self.Scroll-1,0)
                self:UpdateStationList(self.StationS)
                return
            elseif math.InRangeXYR(x,y,xa+219,ya+143,31,14) then
                self.Scroll = math.Clamp(self.Scroll+1,0,math.max(0,self.ScrollCount-8))
                self:UpdateStationList(self.StationS)
                return
            end

            for i=1,math.min(8,self.ScrollCount) do
                if math.InRangeXYR(x,y,xa+13,ya+27-10+18*(i-1)-9,200,17) then
                    local st = self:UpdateStationList(self.StationS,i)
                    self.StationS = st and tostring(st) or self.StationS
                    self:UpdateStationList(self.StationS)
                    return
                end
            end
        else
            for i=0,self.State==3.5 and 1 or 3 do
                if math.InRangeXYR(x,y,374,103+35*i,210,35) then self.Selected = i+1 return end
            end
        end
        if self.Keyboard then
            if math.InRangeXYR(x,y,156+127,369,120,51) then self.Touches["Enter"] = true return end
            if math.InRangeXYR(x,y,286+127,369,120,51) then self.Touches["Esc"] = true return end
            if math.InRangeXYR(x,y,443+100,369,40,51) then self.Touches["KeyB"] = true return end
        else
            if math.InRangeXYR(x,y,156,369,120,51) then self.Touches["Enter"] = true return end
            if math.InRangeXYR(x,y,286,369,120,51) then self.Touches["Esc"] = true return end
            if math.InRangeXYR(x,y,443,369,40,51) then self.Touches["KeyB"] = true return end
        end
    elseif self.State == 4 and  math.InRangeXYR(x,y,320-19,278,76,38) then
        self.Touches["Enter"] = true
        return
    elseif self.State >= 5 then
        if self.State5Accept and self.State5Accept ~= 0 then
            local ya = acceptions[self.State5Accept]*21
            if math.InRangeXYR(x,y,194,219+ya,120,50) then self.Touches["Enter"] = true return end
            if math.InRangeXYR(x,y,326,219+ya,120,50) then self.Touches["Esc"] = true return end
        elseif self.State5==0 then
            for i=1,10 do
                if i==10 then i=12 end
                if math.InRangeXYR(x,y,212*((i-1)%3),119+(math.ceil(i/3)-1)*62,212,62) then
                    if i==12 then
                        self.Touches["Esc"] = true
                        return
                    else
                        self.Touches[tostring(i%10)] = true
                        return
                    end
                end
            end
        elseif self.State5==-8 then
            for i=1,9 do
                if i==9 then i=11 end
                if math.InRangeXYR(x,y,4+210*((i-1)%3),152+(math.ceil(i/3)-1)*50,209,49) then
                    if i==11 then
                        self.Touches["Esc"] = true
                        return
                    else
                        self.Touches[tostring(i%10)] = true
                        return
                    end
                end
            end
        elseif self.State5 == 1 then
            if math.InRangeXYR(x,y,139,270,370,50) then self.Touches["Esc"] = true return end
        elseif self.State5 == 8 then
            if self.ScrollCount and self.ScrollCount > 0 then
                for i=1,math.min(9,Train:GetNW2String("PAM:ElemCount",0)) do
                    if math.InRangeXYR(x,y,4+210*((i-1)%3),152+(math.ceil(i/3)-1)*50,210,50) then self.Touches[tostring(i)] = true return end
                end
                if math.InRangeXYR(x,y,4+210*0,152+3*50,80,50) then self.Touches["Left"] = true return end
                if math.InRangeXYR(x,y,4+210*3-80,152+3*50,80,50) then self.Touches["Right"] = true return end
            end
            if math.InRangeXYR(x,y,4+210*1.5-145,152+3*50,140,50) then self.Touches["Enter"] = true return end
            if math.InRangeXYR(x,y,4+210*1.5+5,152+3*50,140,50) then self.Touches["Esc"] = true return end
        elseif self.State5 == -5 then
            local xadd = (self.Keyboard and 1 or 0)
            for i=0,1 do
                if math.InRangeXYR(x,y,320+102*(self.Keyboard and 1 or 0),190+39*i,225-15*xadd,31) then self.Selected = i+1 return end
            end
            if math.InRangeXYR(x,y,190+xadd*79,320,140,50) then self.Touches["Enter"] = true return end
            if math.InRangeXYR(x,y,340+xadd*79,320,140,50) then self.Touches["Esc"] = true return end
            if math.InRangeXYR(x,y,501+xadd*79,320,40,51) then self.Touches["KeyB"] = true return end
        elseif self.State5 == 9 then
            if self.Selected==1 and self.ScrollCount and self.ScrollCount > 0 then
                local xa,ya = 320+40*(self.Keyboard and 1 or 0),229
                if math.InRangeXYR(x,y,xa+219,ya+5,31,15) or math.InRangeXYR(x,y,xa+219,ya+128,31,14) then
                    self.Scroll = math.max(self.Scroll-1,0)
                    self:UpdateStationList(self.StationS)
                    return
                elseif math.InRangeXYR(x,y,xa+219,ya+143,31,14) then
                    self.Scroll = math.Clamp(self.Scroll+1,0,self.ScrollCount-8)
                    self:UpdateStationList(self.StationS)
                    return
                end

                for i=1,math.min(8,self.ScrollCount) do
                    if math.InRangeXYR(x,y,xa+13,ya+27-10+18*(i-1)-9,200,17) then
                        local st = self:UpdateStationList(self.StationS,i)
                        self.StationS = st and tostring(st) or self.StationS
                        self:UpdateStationList(self.StationS)
                        return
                    end
                end
            else
                for i=0,1 do
                    if math.InRangeXYR(x,y,322+40*(self.Keyboard and 1 or 0),190+39*i,229,31) then self.Selected = i+1 return end
                end
            end
            if self.Keyboard then
                if math.InRangeXYR(x,y,190+1*39,320,75+1*65,50) then self.Touches["Enter"] = true return end
                if math.InRangeXYR(x,y,288+1*(42+39+10),320,120+1*20,50) then self.Touches["Esc"] = true return end
                if math.InRangeXYR(x,y,501+1*40,320,40,51) then self.Touches["KeyB"] = true return end
            else
                if math.InRangeXYR(x,y,190+0*39,320,75+0*65,50) then self.Touches["Enter"] = true return end
                if math.InRangeXYR(x,y,288+0*(42+39+10),320,120+0*20,50) then self.Touches["Esc"] = true return end
                if math.InRangeXYR(x,y,501+0*40,320,40,51) then self.Touches["KeyB"] = true return end
            end
        else
            if math.InRangeXYR(x,y,0,429,136,51) then self.Touches["F"] = true return end
            if math.InRangeXYR(x,y,3,289,80,35) then  self.Touches["P"] = true return end

            for i=0,2 do
                if math.InRangeXYR(x,y,2,157+i*46,70,35) then self.Touches[tostring(i+1)] = true end
            end
            for i=0,4 do
                if math.InRangeXYR(x,y,570,155+i*46,70,35) then self.Touches[i==0 and "4" or tostring(i+5)] = true end
            end
        end
    end
end

TRAIN_SYSTEM.DriveModesConv = {
    AT  = -4,
    AT1 = -4,
    VPR = -3,
    ST  = -2,
    OXT = -1,
    OD  = 0,
    X1  = 1,
    X2  = 2,
    X3  = 3,
}
TRAIN_SYSTEM.DriveModes = {
    --Priority  2   3   8  017  19  20 20X  25 025  33 033 33G
    X3   = {1,  1,  1,  0,  0,  1,  1,  1,  0,  1,  1,  1,  0},
    X2   = {2,  1,  0,  0,  0,  1,  1,  1,  0,  1,  1,  1,  0},
    X1   = {3,  0,  0,  0,  0,  1,  1,  1,  0,  1,  1,  1,  0},
    OD   = {4,  0,  0,  0,  1,  1,  0,  1,  0,  1,  0,  1,  0},
    OXT  = {5,  0,  0,  0,  1,  1,  0,  0,  0,  1,  0,  0,  0},
    ST   = {6,  0,  0,  0,  0,  0,  1,  0,  0,  1,  0,  0,  1},
    VPR  = {7,  1,  0,  0,  0,  0,  1,  0,  1,  1,  0,  0,  1},
    AT1  = {8,  1,  0,  0,  0,  1,  1,  0,  0,  0,  0,  0,  1},
    AT   = {9,  1,  0,  1,  0,  0,  1,  0,  0,  0,  0,  0,  1},
    Zero = {10, 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
}
function TRAIN_SYSTEM:SetDriveMode(curMode,override)
    local mode = self.DriveModes[curMode]
    if mode and mode[1] > self.CurrentDriveModePriority then
        self.CurrentDriveMode = mode
        self.CurrentDriveModePriority = mode[1]
        self.DriveMode = curMode
    end
end
TRAIN_SYSTEM.PneumoModes = {
    --Priority  39  48
    NT   = {1,  0,  0,},
    V1   = {2,  0,  1,},
    V2   = {3,  1,  0,},
    V12  = {4,  1,  1,},
}
function TRAIN_SYSTEM:SetDoorMode(curMode,override)
    local mode = self.DoorModes[curMode]
    self.CurrentDoorMode = mode
    self.DoorMode = curMode
end
TRAIN_SYSTEM.DoorModes = {
    --    16  31  32
    ZD = {1,  0,  0,},
    DL = {0,  1,  0,},
    DP = {0,  0,  1,},
    DO = {0,  0,  0,},
}
function TRAIN_SYSTEM:SetPneumoMode(curMode,override)
    if self.CurrentPneumoModePriority==2 and curMode=="V2" then
        curMode = "V12"
    end
    if self.CurrentPneumoModePriority==3 and curMode=="V1" then
        curMode = "V12"
    end
    local mode = self.PneumoModes[curMode]
    if mode and (override or mode[1] > self.CurrentPneumoModePriority) then
        self.CurrentPneumoMode = mode
        self.CurrentPneumoModePriority = mode[1]
        self.PneumoMode = curMode
    end
end

function TRAIN_SYSTEM:TriggerSensor(coil,plate)
    if self.SensorEnabled then
        --self.Distance = plate.TrackX
        local line = self.Line
        local path = tonumber(self.Path)
        local tbl = Metrostroi.PAMConfTest and Metrostroi.PAMConfTest[line] and Metrostroi.PAMConfTest[line][path]
        if not tbl then return end
        if self.Mode == 1 then
            --Ищем позицию нашей станции
            --[[ local pos
            for i,stat in ipairs(tbl[1].stations) do
                if stat.id == tonumber(self.Station) then
                    pos = stat.pos
                    break
                end
            end--]]
            --Ищем ближайший датчик на станции в районе 200м
            --[[ for i,sensor in ipairs(tbl[1].sensors) do
                if pos-sensor<200 then
                    sensorDist = sensor
                    break
                end
            end--]]
            self:FindSensor(self.StationTable.linkedSensor or false)
            if self.NextSensorDist then
                --print(Format("SENSOR: New pos: %.2fm",self.NextSensorDist))
                self.Distance = self.NextSensorDist
                self.SensorError = false
                self:SetMode(2)
                self:FindSensor()
            else
                --print(Format("SENSOR: Error! Can't find good detector near station %s",self.Station))
            end
            self.AlwaysSensor = false
        else
            --Ищем ближайший сенсор от нас для коррекции пути
            --[[ local nearest,sensorDist
            for i,sensor in ipairs(tbl[1].sensors) do
                if not nearest or math.abs(sensor-self.Distance)<nearest then
                    nearest = math.abs(sensor-self.Distance)
                    sensorDist = sensor
                end
            end--]]
            if self.NextSensorDist then
                --print(Format("SENSOR:Old pos: %.2fm, New pos: %.2fm, delta:%.2fm",self.Distance,self.NextSensorDist,self.NextSensorDist-self.Distance))
                self.Distance = self.NextSensorDist--sensorDist
                self.SensorError = false
                self:FindSensor()
            else
                --print("SENSOR: Unknown error in sensors database")
            end
            self.AlwaysSensor = false
        end
    end
end

function TRAIN_SYSTEM:FindSensor(sens,nearest)
    local line = self.Line
    local path = tonumber(self.Path)
    local tbl = Metrostroi.PAMConfTest and Metrostroi.PAMConfTest[line] and Metrostroi.PAMConfTest[line][path]
    if not tbl then return end
    if nearest then
        local dist = self.Distance
        for i,sens in ipairs(tbl[1].sensors) do
            if sens > dist then
                self.NextSensor = i
                break
            end
        end
    elseif sens~=nil then
        self.NextSensor = sens
    else
        self.NextSensor = self.NextSensor + 1
    end
    self.NextSensorDist = tbl[1].sensors[self.NextSensor]
end

function TRAIN_SYSTEM:FindNextSignal()
    local dist = self.Distance
    local line = self.Line
    local path = tonumber(self.Path)
    local tbl = Metrostroi.PAMConfTest and Metrostroi.PAMConfTest[line] and Metrostroi.PAMConfTest[line][path]
    if not tbl then return end
    for i,sig in ipairs(tbl[1].signals) do
        if sig[2] > dist then
            return sig[1]
        end
    end
end

function TRAIN_SYSTEM:FindNextSlope()
    local dist = self.Distance
    local line = self.Line
    local path = tonumber(self.Path)
    local tbl = Metrostroi.PAMConfTest and Metrostroi.PAMConfTest[line] and Metrostroi.PAMConfTest[line][path]
    if not tbl then return 0 end
    local stbl = tbl[1].slopes
    if not stbl then return 0 end
    for i,slp in ipairs(stbl) do
        if slp[2] > dist then
            return stbl[i-1] and stbl[i-1][1] or 0
        end
    end
end

function TRAIN_SYSTEM:FindNextStation()
    local dist = self.Distance
    local line = self.Line
    local path = tonumber(self.Path)
    local tbl = Metrostroi.PAMConfTest and Metrostroi.PAMConfTest[line] and Metrostroi.PAMConfTest[line][path]
    if not tbl then return end
    for i,stat in ipairs(tbl[1].stations) do
        if stat.pos-10 > dist then
            return stat,tbl[1].stations[i-1]
        end
    end
end
function TRAIN_SYSTEM:FindPrevStation()
    local dist = self.Distance
    local line = self.Line
    local path = tonumber(self.Path)
    local tbl = Metrostroi.PAMConfTest and Metrostroi.PAMConfTest[line] and Metrostroi.PAMConfTest[line][path]
    if not tbl then return end
    for i,stat in ipairs(tbl[1].stations) do
        if stat.pos+120 > dist then
            return stat
        end
    end
end
function TRAIN_SYSTEM:FindStation(line,path,stationIndex)
    local tbl = Metrostroi.PAMConfTest and Metrostroi.PAMConfTest[line] and Metrostroi.PAMConfTest[line][tonumber(path) or 1]
    if not tbl then return end
    for i,v in ipairs(tbl[1].stations) do
        if v.id == tonumber(stationIndex) then return v,tbl[1].stations[i-1] end
    end
    return station and station.id
end
function TRAIN_SYSTEM:FindFirstStation()
    local dist = self.Distance
    local line = self.Line
    local path = tonumber(self.Path)
    local tbl = Metrostroi.PAMConfTest and Metrostroi.PAMConfTest[line] and Metrostroi.PAMConfTest[line][path]
    if not tbl then return end
    return tbl[1].stations[1].id
end
function TRAIN_SYSTEM:FindLastStation()
    local dist = self.Distance
    local line = self.Line
    local path = tonumber(self.Path)
    local tbl = Metrostroi.PAMConfTest and Metrostroi.PAMConfTest[line] and Metrostroi.PAMConfTest[line][path]
    if not tbl then return end
    return tbl[1].stations[#tbl[1].stations]
end
function TRAIN_SYSTEM:Message(id)
    self.CurrentMessage = id
    self.MessageTimer = CurTime()
end
local errorsRing = {
    true ,true ,nil  ,false,nil  ,nil  ,true ,true ,
    true ,nil  ,nil  ,nil  ,false,nil  ,false,nil  ,
    nil  ,nil  ,nil  ,nil  ,nil  ,true ,nil  ,false,
    nil  ,nil  ,false,nil  ,nil  ,false,nil  ,nil  ,
}
function TRAIN_SYSTEM:Error(id,state,time,removeOnTimer)
    if (state or removeOnTimer and self.ErrorTimers[id] and CurTime()-self.ErrorTimers[id]<time) and (not self.ErrorTimers[self.CurrentError] or not self.ErrorTimers[id] and (not time or CurTime()-self.ErrorTimers[self.CurrentError]<time) or self.ErrorTimers[id] and self.ErrorTimers[self.CurrentError] <= self.ErrorTimers[id]) then
        if not self.ErrorTimers[id] then
            self.ErrorTimers[id] = CurTime()
        end
        if not time or CurTime()-self.ErrorTimers[id]<time then
            self.CurrentError = id
        end
    elseif not state and self.ErrorTimers[id] then
        self.ErrorTimers[id] = nil
    end
end
function TRAIN_SYSTEM:SetWaitTimer(time)
    self.ChangeTimer = CurTime()+time
end
function TRAIN_SYSTEM:SetState(state,time)
    if state>=2 then
        self.Selected = 1
    end
    if state == 2 then
        self.LineS = self.Line or self.LineS
        self.PathS = tostring(self.Path) or self.PathS
        self.StationS = tostring(self.Station) or self.StationS
        self.RouteNumberS = self.RouteNumber or self.RouteNumberS
        self.DriverNumberS = self.DriverNumber or self.DriverNumberS

        self.HaveRestart =  #self.DriverNumber == 4 and #self.RouteNumber == 3
            and Metrostroi.PAMConfTest[self.LineS]
            and Metrostroi.PAMConfTest[self.LineS][tonumber(self.PathS)]
            and Metrostroi.PAMStations[self.LineS][tonumber(self.StationS)]
        self.Train:SetNW2Bool("PAM:HaveRestart",self.HaveRestart)
    elseif state == 3 or state == 3.5 then
        self.KeyboardX,self.KeyboardY = 22,47

        if state == 3 then
            self.StationS = ""
            self.PathS = ""
            self.RouteNumberS = ""
            self.DriverNumberS = ""
        end

        self:UpdateStationList(self.StationS)
        self.Train:SetNW2String("PAM:EnterError","")
    elseif state == 4 then
        self.CheckRing = true
    elseif state == 5 then
        self.Line = tonumber(self.LineS)
        self.Station = tonumber(self.StationS)
        self.Path = tonumber(self.PathS)
        self.RouteNumber = self.RouteNumberS
        self.DriverNumber = self.DriverNumberS
        self.LineS = nil
        self.StationS = nil
        self.PathS = nil
        self.RouteNumberS = nil
        self.DriverNumberS = nil

        self:SetMode(1)
        self.EPKActive = true
        self.ControlMode = 2
        self.State5 = nil
    elseif state == 6 then
        self:SetMode(0)
        self.EPKActive = true
        self.ControlMode = 2
        self.State5 = nil
    end
    self.State = state
    if time then self.ChangeTimer = CurTime()+time end
end

function TRAIN_SYSTEM:SetMode(mode)
    self.Mode = mode
    if mode==0 then
        self.Transit = false
        self.FireBack = false
        self.Shunt = false
        self.AntiMiss = false
    elseif mode==1 then
        self.Distance = 0
        self.StationTable,self.PrevStationTable = self:FindStation(self.Line,self.Path,self.Station)
        self.LastStationTable = self:FindLastStation()
        self.SensorError = false
        self.Deadlock = nil
        self.FireBack = false
        self.Shunt = false
        self.AntiMiss = false
    elseif mode == 2 then
        self.AntiMiss = false
        self.FireBack = false
    elseif mode == 3 then
        self.Transit = false
        self.FireBack = false
        self.Shunt = false
        self.AntiMiss = false
    elseif mode == 6 then
        self.Shunt = false
    end
end

function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
    if self.CANIgnore and CurTime()-self.CANIgnore < 2 then return end
    if sourceid == self.Train:GetWagonNumber() then return end
    if self.State == 0 then return end
    if textdata == "Check" then
        self:CANWrite("Answer",{
            Errors = not self.GoodSetup,
            State=self.State,
            Mode = self.Mode,
            Line = self.Line,
            Path = self.Path,
            Station = self.Station,
            RouteNumber = self.RouteNumber,
            DriverNumber = self.DriverNumber,
            Deadlock = self.Deadlock and self.Deadlock.id,
            RR = self.ReverserWrench,
        })
    elseif textdata == "Answer" then
        if not self.BackPA then
            self.BackPA = {
                id=sourceid,
                LastAnswer = CurTime(),
                state = numdata
            }
        elseif self.BackPA.id ~= sourceid then
            self.BackPA = nil
            self.CANIgnore = CurTime()
        else
            self.BackPA.LastAnswer = CurTime()
            self.BackPA.state = numdata
        end
        local back = self.BackPA and self.BackPA.state
        if back and back.RR and self.State>0 then
            if self.State<4 and back.State==4 then self.State = 4 end
            if self.State<5 and back.State==5 then self.EPKActive = true self.State = 5 self.ControlMode = 2 end
            if self.State==5 then
                self.Line = back.Line
                self.Path = back.Path=="2" and "1" or "2"
                self.RouteNumber = back.RouteNumber
                self.DriverNumber = back.DriverNumber
                self.Deadlock = self.Mode==4 and self.Deadlock or nil
                self.Shunt = back.Shunt
                if self.Station ~= back.Station or not self.BackRR or self.BackMode~=back.Mode then
                    local line = self.Line
                    local path = tonumber(self.Path)
                    local tbl = Metrostroi.PAMConfTest and Metrostroi.PAMConfTest[line] and Metrostroi.PAMConfTest[line][path]
                    for k,v in ipairs(tbl[1].stations) do
                        if v.id == tonumber(back.Station) then
                            self.Station = back.Station
                            self.StationTable = v
                            self.Distance = v.pos
                            self.PrevStationTable = tbl[1].stations[k-1]
                            self.LastStationTable = self:FindLastStation()
                            self.AlwaysSensor = true
                            self:FindSensor(self.StationTable.linkedSensor or false)
                            self.AddDistance = 100+math.random()*50
                        end
                    end
                    self.BackMode = back.Mode
                end

                local deadlock
                if back.Deadlock and not self.Deadlock then
                    local line = self.Line
                    local path = tonumber(self.Path)
                    local tbl = Metrostroi.PAMConfTest and Metrostroi.PAMConfTest[line] and Metrostroi.PAMConfTest[line][path]
                    for k,v in ipairs(tbl[1].stations) do
                        if back.Deadlock and v.id == back.Deadlock and tonumber(back.Station) == back.Deadlock and not self.StationTable.isInWrong then
                            self.Deadlock = v
                            self.Mode = 4
                            self.AddDistance = false
                            self.AntiMiss = false
                            deadlock = true
                        end
                    end
                end
                if back.Mode<=4 and (not self.Deadlock or self.StationTable.isInWrong) then
                    self.Mode = math.min(2,back.Mode)
                    self.AntiMiss = false
                end
                if (back.Mode==5 or back.Mode==1) and self.Mode~=1 then self:SetMode(1) end
                if back.Mode==6 then
                    self:SetMode(1)
                    self:SetMode(6)
                end
            end
        end
        self.BackRR = back and back.RR
    end

end
function TRAIN_SYSTEM:CANWrite(name,value,number)
    if self.State == 0 then return end
    if self.CANIgnore and CurTime()-self.CANIgnore < 1 then return end
    local source = self.Train:GetWagonNumber()
    self.Train:CANWrite("PAM",source,"PAM",number,name,value)
end
function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    if Train.Electric.Type < 4 then return end
    self.OldDriveModePriority = self.CurrentDriveModePriority or 0
    self.CurrentDriveModePriority = 0
    self.CurrentPneumoModePriority = 0

    local PAM_VV = Train.PAM_VV
    local Power = PAM_VV.Power > 0
    local ALS = Train.ALSCoil
    local BackReverser = PAM_VV.KRR2 > 0
    local BackActive =  PAM_VV.KRR1 > 0
    local RR = (PAM_VV.KRR > 0 or PAM_VV.KRU > 0) and not BackActive
    if RR and self.AddDistance then
        if not self.Deadlock then self.Distance = self.Distance-self.AddDistance end
        self.AddDistance = false
    end
    if Power and self.State == 0 then
        self.State = -0.5
        self.StartTimer = CurTime()
    end
    if not Power and self.State ~= 0 then
        self.State = 0
        for k,v in pairs(self.TriggerNames) do
            self.Triggers[v] = false
            self.Touches[v:sub(4,-1)] = false
        end
        self.BackCheckTimer = false
        self.BackPA = nil
    end
    if self.State == -0.5 and CurTime()-self.StartTimer > 0.05 then self.State = -1 self.StartTimer = CurTime() end
    if self.State == -1 and CurTime()-self.StartTimer > 5 then self.State = -2 self.StartTimer = CurTime()  self:SetWaitTimer(0.2) end
    if self.State == -2 and CurTime()-self.StartTimer > 0.8 then self.State = -3 self.StartTimer = CurTime()  self:SetWaitTimer(1) end
    if self.State == -3 and CurTime()-self.StartTimer > 3 then self.State = -4 self.StartTimer = CurTime() end
    if self.State == -4 and CurTime()-self.StartTimer > 2 then self.State = -5 self.StartTimer = CurTime() self:SetWaitTimer(1) end
    if self.State == -4 and CurTime()-self.StartTimer > 2 then self.State = -5 self.StartTimer = CurTime() self:SetWaitTimer(1) end
    if self.State == -5 and CurTime()-self.StartTimer > 5 then self.State = 1 self.StartTimer = CurTime() self:SetWaitTimer(0.2) end
    if self.State == -5 and PAM_VV.LPT > 0 then
        if PAM_VV.KGR==0 and self.WaitingX==nil then
            self.WaitingX = false
        elseif PAM_VV.KGR>0 and self.WaitingX==false then
            self.WaitingX = true
        elseif PAM_VV.KGR==0 and self.WaitingX then
            self:SetState(6,0.1)
        end
    else
        self.WaitingX = nil
    end
    if self.ChangeTimer and CurTime()-self.ChangeTimer > 0 then self.ChangeTimer = nil end

    local ALSOn = (self.State>0 and RR) and 1 or 0
    if self.PAKSD and ALSOn ~= ALS.Enabled then
        ALS:TriggerInput("Enable",ALSOn)
    end

    self.Speed = ALS.Speed--math.Round(ALS.Speed or 0,1)
    local speed = self.Speed
    local speedMpS = speed/3600*1000
    local speedMpSSigned = speedMpS*ALS.SpeedSign
    local accel = ALS.Acceleration
    if self.State > 0 or self.State<-3 then
        for k,v in pairs(self.TriggerNames) do
            local name = v:sub(4,-1)
            local val = Train[v].Value > 0.5
            if (self.Touches[name] or val) ~= self.Triggers[v] then
                self.Triggers[v] = self.Touches[name] or val
                self:Trigger(name,self.Triggers[v],val == self.Triggers[v])
            end
        end
        if (not self.BackCheckTimer or CurTime()-self.BackCheckTimer > 1) then
            self:CANWrite("Check")
            self.BackCheckTimer = CurTime()
        end
        if self.BackPA and CurTime()-self.BackPA.LastAnswer > 2 then
            self.BackPA = nil
        end

        local ALSSh = (1-Train.ALS.Value)*Train.VRD.Value --ALS Shunt
        local Vd = -1
        if ALS.F5*(1-ALSSh) > 0 then Vd = 0 end
        if ALS.F4*(1-ALSSh) > 0 then Vd = 40 end
        if ALS.F3*(1-ALSSh) > 0 then Vd = 60 end
        if ALS.F2*(1-ALSSh) > 0 then Vd = 70 end
        if ALS.F1*(1-ALSSh) > 0 then Vd = 80 end
        if Vd ~= self.SpeedLimit then
            if Vd == -1 and not self.FQChagneTimer then
                self.FQChagneTimer = CurTime()
            end
            if Vd ~= -1 or self.FQChagneTimer and (speedMpS <= 0.1 and CurTime()-self.FQChagneTimer > 2.5 or speedMpS >= 0.1 and CurTime()-self.FQChagneTimer > 0.8) then
                self.SpeedLimit = Vd
                self.FQChagneTimer = nil
            end
        end
        if self.PAKSD then --ALS outputs for KSD
            self.F5 = self.SpeedLimit==0 and 1 or 0
            self.F4 = self.SpeedLimit==40 and 1 or 0
            self.F3 = self.SpeedLimit==60 and 1 or 0
            self.F2 = self.SpeedLimit==70 and 1 or 0
            self.F1 = self.SpeedLimit==80 and 1 or 0
            self.F6 = self.SpeedLimit>-1 and ALS.F6 or 0
        end
        self.NoFreq = self.SpeedLimit==-1 and 1 or 0
    elseif self.State==-0.5 then
        self.NoFreq = 1
        self.F6 = 1
        self.F5 = 1
        self.F4 = 1
        self.F3 = 1
        self.F2 = 1
        self.F1 = 1
    else
        self.NoFreq = 0
        self.F6 = 0
        self.F5 = 0
        self.F4 = 0
        self.F3 = 0
        self.F2 = 0
        self.F1 = 0
    end
    Train:SetNW2Float("PAM:State",self.ChangeTimer and -10 or self.State)
    if self.StartTimer then Train:SetNW2Float("PAM:StartTimer",CurTime()-self.StartTimer) end

    --if self.WorkTimer and CurTime()- self.WorkTimer < 0.1 then return end
    --self.WorkTimer = CurTime() --CHECK
    local Ring = false
    if self.State <= 0 then
        self["2"] = 0
        self["3"] = 0
        self["8"] = 0
        self["17"] = 0
        self["19"] = 0
        self["20"] = 0
        self["20X"] = 0
        self["25"] = 0
        self["025"] = 0
        self["33"] = 0
        self["033"] = 0
        self["33G"] = 0
        self["16"] = 0
        self["31"] = 0
        self["32"] = 0
        self["39"] = 0
        self["7GA"] = 0
        self["48"] = 0
        self.EPK = 0

        self.Ring = self.State==-0.5 and 1 or 0
        self.Mode = 0
        self.SensorEnabled = false
        return
    end
    self.GoodSetup = not not Metrostroi.PAMConfTest
    self.ReverserWrench = PAM_VV.KRR > 0
    self.CurrentError = 0

    if self.State == 1 or self.State == 1.5 then
        Train:SetNW2Bool("PAM:GoodTest",true)
        Train:SetNW2Bool("PAM:GoodSetup",self.GoodSetup)
        Train:SetNW2Int("PAM:GoodBack",self.BackPA~=nil and (self.BackPA.state.Errors and -1 or 1) or 0 )

    end
    if self.State == 3 or self.State==5 and self.State5 == -5  then
        Train:SetNW2String("PAM:RouteNumber",self.RouteNumberS)
        Train:SetNW2String("PAM:DriverNumber",self.DriverNumberS)
    end
    if self.State == 3 or self.State == 3.5 or self.State==5 and self.State5 == 9 then
        if self.StationS ~= "" then
            local st = self:FindStation(self.LineS,self.PathS,self.StationS)
            Train:SetNW2String("PAM:CurrentStationS",st and (st.name or st.id) or "")
        else
            Train:SetNW2String("PAM:CurrentStationS", "")
        end
        Train:SetNW2String("PAM:StationS",self.StationS)
        Train:SetNW2String("PAM:LineS",self.LineS)
        Train:SetNW2String("PAM:PathS",self.PathS)
    end
    if self.State < 4 then
        self:SetDriveMode("OXT")
        self:SetDoorMode("DO")
        self:SetPneumoMode("NT")
        self["7GA"] = 0
        --[[ if PAM_VV.KB==0 then
            self:SetPneumoMode("V2")
        else
            self:SetPneumoMode("NT")
        end--]]
        self.SensorEnabled = false
        if (not self.ReverserWrench or not self.GoodSetup) and self.State >= 2 then
            self:SetState(1,0.1)
        end
    else
        self["7GA"] = PAM_VV.KSOT+PAM_VV.KB
        if self.CheckRing and PAM_VV.KB > 0 then self.CheckRing = false end
    end
    if self.State == 4 then
        self.SensorEnabled = false
        Ring = self.CheckRing

        self:SetDriveMode("OD")
        self:SetPneumoMode("NT")
        self:SetDoorMode("DO")
        if RR then
            self:SetDoorMode(PAM_VV.KDP>0 and "DP"or PAM_VV.KDL > 0 and "DL" or "DO")
            if speed>0.2 then self.Stopping = true end
            if speed<=0.2 and PAM_VV.KGR>0 and PAM_VV.KB>0 then self.Stopping = false end
            if self.Stopping then
                self:SetDriveMode("AT")
                self:SetPneumoMode("V2")
            end
        end
    else
        self.Stopping = false
    end
    if self.State >= 5 then
        self:Error(17,not RR and not BackActive)
        self:Error(19,BackActive)
        --Drive block after drive reset
        if self.OldDriveModePriority>4 and PAM_VV.KGR==0 then
            self:SetDriveMode("OXT")
        else
            self:SetDriveMode("OD")
        end
        self:SetDoorMode("DO")

        if not RR and not BackActive then
            self:SetPneumoMode("V1")
        else
            self:SetPneumoMode("NT")
        end


        local stationLast = ""
        local station = ""
        local signal = ""
        local slope = 0
        local dist = 1337
        local opv = false
        --Distance count
        if not self.Distance and self.State == 5 then self.Distance = self.StationTable and self.StationTable.pos or 0 end
        if self.Mode~=6 and self.Distance then
            local pos = Metrostroi.TrainPositions[Train];pos = pos and pos[1]
            local delta = speedMpS*dT
            if pos and pos.path ~= self.OldPath then
                self.OldPath = pos.path
                self.OldPos = pos.x+Train.PosX
                delta = speedMpS*dT
            elseif pos then
                local x = pos.x+Train.PosX
                delta = (x-self.OldPos)*(Metrostroi.TrainDirections[Train] and 1 or -1)
                self.OldPos = x
            end
            self.Distance = self.Distance + delta
        end

        if self.Mode == 1 then
            stationLast = "выход на линию"
            if self.StationTable then station = self.StationTable.name end
            dist = 3072-self.Distance
        elseif self.Mode == 2 or self.Mode == 3 then
            local lasttbl = self.Deadlock or self.LastStationTable
            if self.Mode == 3 and lasttbl and lasttbl.id==self.StationTable.id then
                stationLast = "оборот"
            else
                stationLast = lasttbl and lasttbl.name_last or "?"
            end
            dist = self.StationTable.pos-self.Distance
            station = self.StationTable.name
            signal = self:FindNextSignal()
            slope = self:FindNextSlope()
            if self.PrevStationTable then
                local dist = self.PrevStationTable.pos-self.Distance
                local opvDist = self.PrevStationTable.isHorlift and 0.45 or 3
                opv = -opvDist < dist and dist < opvDist
            end
            if not opv then
                local opvDist = self.StationTable.isHorlift and 0.45 or 3
                opv = -opvDist < dist and dist < opvDist
            end
        elseif self.Mode == 4 or self.Mode == 5  then
            stationLast = "оборот"
            station = self.StationTable.name
            if self.Mode == 5 then
                dist = 3072-self.Distance
                opv =  true
            else
                dist = self.StationTable.dist_last_end-self.Distance
                local opvDist = self.StationTable.isHorlift and 0.45 or 3
                opv =  self.Distance > self.StationTable.dist_last_start
                if not opv then
                    local   dist = self.StationTable.pos-self.Distance
                    local opvDist = self.StationTable.isHorlift and 0.45 or 3
                    opv = -opvDist < dist and dist < opvDist
                end
            end
        end

        local OXT = false
        if RR then
            if (self.Mode~=2 and self.Mode~=3) or self.NextSensorDist and math.abs(self.Distance-self.NextSensorDist)<=20 or self.AlwaysSensor then
                self.SensorEnabled =true
            elseif self.SensorEnabled then
                if self.Mode==2 and self.SensorError==nil then
                    self.SensorError = true
                end
                self.SensorEnabled = nil
            end

            if self.State~=6 and ((self.Mode==2 or self.Mode==3) and (dist < -3 and (self.Transit or not self.AntiMiss)) or self.OpenControl == false and speed > 0.2  or self.Mode == 4 and dist<0) then
                local oldSt = self.StationTable
                if not self.Shunt then self.StationTable,self.PrevStationTable = self:FindNextStation() end

                if self.Mode == 4 and dist<0 then
                    self.Mode = 5

                    self.StationTable = oldSt
                elseif self.StationTable then
                    if self.Shunt then
                        self:SetMode(6)
                    elseif self.Deadlock and oldSt.id == self.Deadlock.id then
                        self.Mode=4

                        self.StationTable=self.Deadlock
                        self.Deadlock = nil
                    elseif self.Mode == 3 then
                        self:SetMode(2)
                    end
                elseif oldSt and oldSt.isLast and oldSt.dist_last_end then
                    self.Mode = 4
                    self.StationTable = oldSt
                else
                    self.Station = self:FindFirstStation()
                    self:SetMode(1)
                end
                self.Station = self.StationTable.id
                self.OpenControl = nil
            end

            if self.Mode==2 and dist<=200 then
                local line = self.Line
                local path = tonumber(self.Path)
                local tbl = Metrostroi.PAMConfTest and Metrostroi.PAMConfTest[line] and Metrostroi.PAMConfTest[line][path]
                if self.StationBrakeRing==nil and tbl and tbl[1].sensors[self.StationTable.linkedSensor] and tbl[1].sensors[self.StationTable.linkedSensor]<self.Distance then
                    self.StationBrakeRing = PAM_VV.KRT==0 and PAM_VV.KET==0 and CurTime()
                elseif self.StationBrakeRing and CurTime()-self.StationBrakeRing>0.2 then self.StationBrakeRing = false end
            elseif self.StationBrakeRing==false or self.StationBrakeRing and CurTime()-self.StationBrakeRing > 0.5 then
                self.StationBrakeRing = nil
            end

            local CanOpen = PAM_VV.KRH==0 and (PAM_VV.LPT > 0 or self.NoLPT and PAM_VV.V1>0)
            if ((opv or self.Mode==5) and speed < 0.5 or (self.OpenDoors and speed < 2.5 or not self.GoodSetup)) and CanOpen then
                self:SetDoorMode((not self.OpenControl and (PAM_VV.ZD>0 or self.DoorMode=="ZD")) and "ZD" or "DO")
                local err
                if (self.Mode > 3 or self.OpenDoors or not self.GoodSetup) then
                    local Open = PAM_VV.KDL > 0 or PAM_VV.KDP > 0
                    if Open and PAM_VV.ZD == 0 then
                        self:SetDoorMode(PAM_VV.KDP > 0 and "DP"or "DL")
                        if not self.OpenControl then self.OpenControl = CurTime() end
                        if not self.OpeningTimer and PAM_VV.KD>0 then self.OpeningTimer = CurTime() end
                    end
                    if Open and PAM_VV.ZD>0 and not self.OpenTimer then
                        self.OpenTimer = CurTime()
                    elseif (not Open or PAM_VV.ZD==0) and self.OpenTimer then
                        self.OpenTimer = nil
                    end
                    --TODO: При открытии контроль 16 провода, через 0.7с при наличии 16 провода сообщение "Разблокируйте двери"
                    --TODO: При нажатии на кнопку>2.5с и не пропадании КД подсказка "Нет контроля открытия дверей
                elseif self.Mode<=3 then
                    local stationTable = dist>10 and self.PrevStationTable or self.StationTable
                    local Open = PAM_VV.KDL > 0 or PAM_VV.KDP > 0
                    local CanOpen = not self.Transit and (PAM_VV.KDL > 0 and not stationTable.rightDoors or PAM_VV.KDP > 0 and stationTable.rightDoors)
                    if PAM_VV.ZD==0 and CanOpen then
                        self:SetDoorMode(stationTable.rightDoors and "DP"or "DL")
                        if opv and (stationTable==self.StationTable or self.FireBack) then
                            self:SetMode(3)
                        end
                        if not self.OpenControl then self.OpenControl = CurTime() end
                        if not self.OpeningTimer and PAM_VV.KD>0 then self.OpeningTimer = CurTime() end
                    else
                        self.OpeningTimer = false
                        self:Error(1,Open and not CanOpen and not self.Transit and stationTable.rightDoors)
                        self:Error(2,Open and not CanOpen and not self.Transit and not stationTable.rightDoors)
                        self:Error(23,Open and not CanOpen and self.Transit)
                    end
                    if CanOpen and PAM_VV.ZD>0 and not self.OpenTimer then
                        self.OpenTimer = CurTime()
                    elseif (not CanOpen or PAM_VV.ZD==0) and self.OpenTimer then
                        self.OpenTimer = nil
                    end
                    --TODO: При открытии контроль 16 провода, через 0.7с при наличии 16 провода сообщение "Разблокируйте двери"
                    --TODO: При нажатии на кнопку>2.5с и не пропадании КД подсказка "Нет контроля открытия дверей
                end
                if self.OpeningTimer and (CurTime()-self.OpeningTimer>2.7 and PAM_VV.KD==0 or not RR) then self.OpeningTimer = false end
                self:Error(4,self.OpeningTimer and CurTime()-self.OpeningTimer>2.7)
                --TODO: Для режима "3" на станции закрытого типа сообщение "Откройте двери станции" при отсутствии КД(контроллируемом) и наличии частоты
                --      Отмена сообщения на КБ либо появлении 0(с отменой ходового режима)
            else
                if not CanOpen or PAM_VV.ZD>0 or self.DoorMode=="ZD" then self:SetDoorMode("ZD") end
                self.OpenDoors = false
                self.OpenTimer = false
                self.OpeningTimer = false
            end

            if self.OpenControl and  self.Mode==3 and self.StationTable.isHorlift and self.SpeedLimit~=0 then
                if not self.StationDoorsTimer then self.StationDoorsTimer = CurTime() end
                if PAM_VV.KB>0 and self.StationDoorsTimer~=true and self.StationDoorsTimer>2.5 then self.StationDoorsTimer = true end
            else
                self.StationDoorsTimer = nil
            end
            --self:Error(10,self.KDTimer and not self.OpenControl,7,true)
            self:Error(5,self.KDTimer and not self.OpenControl)
            self:Error(27,self.StationDoorsTimer and self.StationDoorsTimer~=true and CurTime()-self.StationDoorsTimer>2.5)

            self:Error(7,self.OpenTimer and CurTime()-self.OpenTimer>0.7)
            self:Error(9,self.SensorError and PAM_VV.ZD==0 and (PAM_VV.KDL>0 or PAM_VV.KDP>0))
            if PAM_VV.KDL>0 or PAM_VV.KDP>0 then
                if not self.KDLPTimer then self.KDLPTimer = CurTime() end
            elseif self.KDLPTimer then self.KDLPTimer = nil end
            self:Error(22,self.KDLPTimer and CurTime()-self.KDLPTimer>10)

            --Disable NoKD if we got KD
            if self.NoKD and PAM_VV.KD>0 and not self.KDOnTime then self.KDOnTime = CurTime() end
            if self.NoKD or PAM_VV.KSZD>0 then self:SetDoorMode("ZD") end
            if self.KDOnTime and PAM_VV.KD>0 and CurTime()-self.KDOnTime>5 then self.KDOnTime = false self.NoKD = false end
            if self.KDOnTime and PAM_VV.KD==0 then self.KDOnTime = false end
            if PAM_VV.KRU>0 and PAM_VV.ZD==0 then self:SetPneumoMode("V2") end

            --Movement block by 64tw
            if PAM_VV.I33*PAM_VV.LPT>0 and not self.NoLPT then
                if not self.LPTTimer then self.LPTTimer = CurTime() end
            elseif self.LPTTimer and (PAM_VV.KGR>0 or self.NoLPT or CurTime()-self.LPTTimer<=6.5) then
                self.LPTTimer = nil
            end
            self:Error(10,self.LPTTimer and CurTime()-self.LPTTimer > 6.5)


            local speedLimit = math.max(21,self.SpeedLimit+1)
            if self.SpeedLimit == -1 and (self.Mode == 1 or self.Mode == 5)  then
                speedLimit = 16
            elseif self.ControlMode == 1 then
                speedLimit =  (self.SpeedLimit > 40 and 36 or 21)*PAM_VV.KB
            elseif PAM_VV.KB>0 then
                speedLimit=21
            elseif self.Mode==6 then
                speedLimit =  math.min(41,speedLimit)
            end
            --KS Mode
            if self.SpeedLimit <= 20 then
                if not self.ZeroStopped and speed <= 0.2 then
                    self.ZeroStopped = true
                end
                local station = (self.Mode==1 or self.Mode==2) and dist<=100
                if self.ZeroStopped == nil and speed > 0.2 then
                    self.ZeroStopped = self.Mode>3 or station and not self.Transit
                end
                if self.ZeroStopped and PAM_VV.KB == 0 or self.SpeedLimit~=-1 and ((ALS.F6==0 and not station or self.Transit) and not self.Vd0) then
                    self:SetDriveMode("OXT")
                    OXT = true
                    speedLimit=0
                end
                if not self.ZeroStopped or speed > 0.2 and PAM_VV.KB == 0 then speedLimit = 0 end
                if self.SpeedLimit~=-1 then
                    if not self.ZeroTimer then self.ZeroTimer = CurTime() end
                else
                    self.ZeroTimer = nil
                end
                self:Error(12,self.SpeedLimit==0 and PAM_VV.KGR==0 and OXT and PAM_VV.KB>0)
                self:Error(15,self.ZeroTimer and CurTime()-self.ZeroTimer>30,7,true)
            else
                self.ZeroStopped = nil
                self.ZeroTimer = nil
            end

            self:Error(26,self.ControlMode==1 and PAM_VV.KB==0 and PAM_VV.KGR==0)

            if self.SpeedLimit>20 or self.SpeedLimit == -1 then self.Vd0 = false end
            if not self.PAKSD and self.SpeedLimit==20 and PAM_VV.VRD>0 then self.Vd0 = true end

            local speedLimitMpS = speedLimit/3600*1000
            local timeAdd = (1-PAM_VV.I33G*1+PAM_VV.I33*1)

            self.Acceleration = self.Acceleration+(accel-self.Acceleration)*dT*1
            if speedMpS+self.Acceleration*timeAdd > speedLimitMpS and speed>0.2 or self.STTimer then
                local ST,AT = false,false
                if not self.OXTTimer then self.OXTTimer = CurTime() end
                if speed > speedLimit or self.OXTTimer and CurTime()-self.OXTTimer > 1.5 then
                    ST = true
                    if not self.STTimer then
                        self.STTimer = CurTime()
                        self.RingArmed = PAM_VV.KRT==0 and CurTime()
                        self.STV1Timer = PAM_VV.KRT==0 and CurTime()
                    end
                end
                if speed > speedLimit or self.STTimer and CurTime()-self.STTimer > 1 then
                    AT = true
                end
                if self.STV1Timer and CurTime()-self.STV1Timer < 0.7 then self:SetPneumoMode("V1") end
                if AT then
                    self:SetDriveMode("AT")
                elseif ST then
                    self:SetDriveMode("ST")
                else
                    self:SetDriveMode("OXT")
                end
                if speed < speedLimit-2 and not self.RingArmed then self.STTimer = false end

                if (AT or ST) and accel>-0.7 then
                    if not self.EKTimer then self.EKTimer = CurTime() end
                elseif self.EKTimer then
                    self.EKTimer = false
                end
                if self.EKTimer and CurTime()-self.EKTimer > ((10<speed and speed<30) and 5.5 or 3.3) then self.EPKActive=false end
                OXT = true
            else
                self.STTimer  = false
                self.OXTTimer = false
                self.STV1Timer = nil
                self.EKTimer = false
            end

            if not self.RollingCheckRolled and (speed < 2.5 or self.Stopped) and PAM_VV.KRH == 0 and (self.NoFreq==0 or PAM_VV.KB==0) then
                self:SetPneumoMode("V1")
                if not self.V1Stop and PAM_VV.KET==0 then self.V1Stop = CurTime() end
                if PAM_VV.KET>0 and self.V1Stop then
                    if not self.V1StopTimer then self.V1StopTimer = CurTime() end
                    if self.V1StopTimer and CurTime()-self.V1StopTimer>1 then
                        self.V1StopTimer = nil
                        self.V1Stop = nil
                    end
                end
                if not self.Stopped then self.Stopped = true end
                if self.Stopped and speed>5.5 then
                    self.Stopped = 1
                end
                if self.Stopped==1  then self:SetPneumoMode("V2") end
                self.Starting = (speed>0.2 or PAM_VV.KRH>0 or PAM_VV.KGR==0) and self.Starting
            elseif not self.RollingCheckRolled then
                if self.Stopped then
                    self.Stopped = false
                    self.Starting = self.NoFreq==0 and CurTime()
                end
                if self.Starting and CurTime()-self.Starting<4.5 and speed>0.5 then self.Starting = nil end
            end

            if self.Starting and CurTime()-self.Starting>=4.5 then self:SetDriveMode("AT") end
            if not self.Stopped then self.V1Stop = nil end
            self:Error(13,self.Starting and CurTime()-self.Starting>=4.5)

            if speedMpSSigned < -0.01 and not self.Rolling and not self.FireBack then self.Rolling = 0 end
            if self.Rolling and self.Rolling < 0 then self.Rolling = false end
            if self.Rolling then
                local rolled = -speedMpSSigned*dT
                if math.abs(rolled) >0.001 then
                    self.Rolling = self.Rolling + rolled
                end
            end
            if not self.Rolled and self.Rolling and self.Rolling > 0.5+PAM_VV.KRH*2.5 then
                self.Rolled = PAM_VV.KRH
            end
            if self.Rolled then
                if self.Rolled>0 then
                    self:SetDriveMode("OXT")
                end
                if self.Rolled == 0 and PAM_VV.KRH > 0 then
                    self.Rolled = false
                    self.Rolling = false
                end
                if PAM_VV.KRH == 0 then self.Rolled = 0 end
                self:SetPneumoMode("V2")
            end

            if self.Transit and self.Mode == 2 then
                local lasttbl = self.Deadlock or self.LastStationTable
                local last = lasttbl and lasttbl.id==self.StationTable.id
                if last and (dist-10) < (speedMpS^2-3.8*speedMpS)/2.2 and speed>14 or not last and (dist-10)<(speedMpS^2-8.3*speedMpS)/2.2 and speed>30 then
                    self.TransitBraking = last and 10 or 30
                end
                if self.TransitBraking and speed>self.TransitBraking and dist<120 then
                    self:SetDriveMode("AT")
                elseif self.TransitBraking then
                    self.TransitBraking = false
                end
            end
            --[[ if (self.Mode==2 or self.Mode==3) then
                if self.AntiMiss == nil then
                    local SchemeEngageDistance,_ACCEL,_ACCEL2
                    local currA = -math.min(0,Train.Acceleration)
                    _ACCEL = 1.61
                    _ACCEL2 = _ACCEL*2
                    local _SCHTime
                    if PAM_VV.KRT>0 then
                        --local speed = 45
                        --local speedMpS = speed/3600*1000
                        _SCHTime = (
                            (
                                math.Clamp(((18-PAM_VV.KPRK)/17)^1.5*(55-(speed-5))/55,0,1)^1.1
                            )*2.2-math.Clamp(PAM_VV.KPRK-14,0,4)/4*3.3*math.Clamp((16-(speed-3))/16,0,1)^2.2
                        )*math.Clamp((0.5-currA),0,1)
                        --_SCHTime = ((math.Clamp((PAM_VV.KPRK-1)/17*(55-(10-5))/55,0,1)^1.1)*2.2-math.Clamp(PAM_VV.KPRK-12,0,6)/6*3-3.5*math.Clamp((16-(10-3))/16,0,1)^2.2)*math.Clamp((0.8-currA)/0.8,0.2,1)
                        SchemeEngageDistance = speedMpS*_SCHTime+(_ACCEL*(_SCHTime^2))/2-(2.0)*math.Clamp((7-(speed-3))/7,0,1)
                    else
                        _SCHTime = ((math.Clamp((55-(speed-5))/55,0,1)^1.2)*1.85+1-3.5*math.Clamp((16-(speed-3))/16,0,1)^1.7)*math.Clamp((_ACCEL-currA)/_ACCEL,0,1)
                        SchemeEngageDistance = speedMpS*_SCHTime+(_ACCEL*(_SCHTime^2))/2
                    end
                    --SchemeEngageDistance = speedMS*_SCHTime+(_ACCEL*(_SCHTime^2))/2
                    if not self.Transit and speed>0.2 and (dist-SchemeEngageDistance) < (speedMpS^2)/_ACCEL2 and not self.AntiMiss then
                        self.AntiMiss = opv and 2 or 1
                        print("ENGAGED "..dist)
                    elseif self.Transit then
                        local lasttbl = self.Deadlock or self.LastStationTable
                        local last = (lasttbl and lasttbl.id==self.StationTable.id) and 10 or 30
                        if (dist-SchemeEngageDistance) < (speedMpS^2-(last/3600*1000)*speedMpS)/_ACCEL2 and not self.AntiMiss then
                        self.AntiMiss = opv and 2 or 1
                        print("ENGAGED "..dist)
                    end
                end
            end--]]
            if (opv or dist<0) and speed<=0.2 then
                self.AntiMissStation = true
            elseif dist>0 and not opv then
                self.AntiMissStation = false
            end
            if not self.Transit and (self.Mode==2 or self.Mode==3) and not BackReverser then
                if self.AntiMiss == nil or self.AntiMiss==1 then
                    local SchemeEngageDistance,_ACCEL,_ACCEL2
                    local currA = -math.min(0,Train.Acceleration)
                    _ACCEL = 1.61
                    _ACCEL2 = _ACCEL*2
                    local _SCHTime
                    if PAM_VV.KRT>0 or PAM_VV.LPT>0 or speed<6 then
                        --local speed = 45
                        --local speedMpS = speed/3600*1000
                        _SCHTime = (
                            (
                                math.Clamp(((18-PAM_VV.KPRK)/17)^1.5*(55-(speed-5))/55,0,1)^1.1
                            )*2.2-math.Clamp(PAM_VV.KPRK-14,0,4)/4*3.3*math.Clamp((16-(speed-3))/16,0,1)^2.2
                        )*math.Clamp((0.5-currA),0,1)
                        --_SCHTime = ((math.Clamp((PAM_VV.KPRK-1)/17*(55-(10-5))/55,0,1)^1.1)*2.2-math.Clamp(PAM_VV.KPRK-12,0,6)/6*3-3.5*math.Clamp((16-(10-3))/16,0,1)^2.2)*math.Clamp((0.8-currA)/0.8,0.2,1)
                        SchemeEngageDistance = speedMpS*_SCHTime+(_ACCEL*(_SCHTime^2))/2-(2.0)*math.Clamp((7-(speed-3))/7,0,1)

                        if dist<20 and speed<23 then
                            SchemeEngageDistance = SchemeEngageDistance-math.Clamp((dist-3)/17,0,1)*2
                        end
                    else
                        _SCHTime = ((math.Clamp((55-(speed-5))/55,0,1)^1.2)*1.85+1-3.5*math.Clamp((16-(speed-3))/16,0,1)^1.7)*math.Clamp((_ACCEL-currA)/_ACCEL,0,1)
                        SchemeEngageDistance = speedMpS*_SCHTime+(_ACCEL*(_SCHTime^2))/2
                    end
                    --SchemeEngageDistance = speedMS*_SCHTime+(_ACCEL*(_SCHTime^2))/2
                    local badAccel = (dist-SchemeEngageDistance) < (speedMpS^2)/_ACCEL2
                    if speed>0.2 and badAccel and self.AntiMiss==nil then
                        self.AntiMiss = self.AntiMissStation and 2 or 1
                        self.AntiMissBlock = CurTime()
                    end
                    if self.AntiMiss and not badAccel and CurTime()-self.AntiMissBlock>0.8 and PAM_VV.KB>0 then
                        self.AntiMiss = nil
                    end
                end
                if self.AntiMiss then
                    self:SetDriveMode("AT")
                    self:SetPneumoMode("V1")
                    if speed<6 then
                        self:SetPneumoMode("V2")
                    end
                    if speed < 0.2 and ((self.AntiMiss==2 or -3<=dist) and PAM_VV.KB>0 or self.AntiMiss==1) then
                        self.AntiMiss = self.AntiMiss==1 and nil
                    end
                end
                if self.AntiMiss==false and self.Mode==2 and dist > 150 then self.AntiMiss = nil end
            elseif self.AntiMiss then
                self.AntiMiss = nil
            end
        else
            self.LPTTimer = nil

            self.StationBrakeRing = nil
            self.SensorEnabled = nil

            self.OpenTimer = false
            self.OpeningTimer = false

            self.KDTimer = nil
            self.OpenDoors = false

            self.StationDoorsTimer = nil

            self.ZeroStopped = nil
            self.ZeroTimer = nil

            self.STTimer  = false
            self.OXTTimer = false
            self.STV1Timer = nil

            self.Starting = nil
            self.Stopped = false
            self.Rolled = false
            self.Rolling = false
            if self.AntiMiss then self.AntiMiss = nil end
        end

        if (self.OpenControl~=true or PAM_VV.K16>0) and PAM_VV.KD==0 then
            if not self.KDTimer then self.KDTimer = CurTime() end
            if self.KDTimer and CurTime()-self.KDTimer>5 then self.OpenControl = false end
        else
            self.KDTimer = nil
        end
        if self.OpenControl and self.OpenControl~=true and PAM_VV.KD > 0 then self.OpenControl = CurTime() end
        if self.OpenControl==true and PAM_VV.KD > 0 then self.OpenControl = false end
        if self.OpenControl and self.OpenControl ~= true and CurTime()-self.OpenControl > 1 then self.OpenControl = true end

        Train:SetNW2Int("PAM:Mode",self.Mode)
        self:Error(8,self.State==5 and RR and (self.AntiMiss==2 or dist<-3 and self.AntiMiss))
        Train:SetNW2Bool("PAM:Shunt",self.Shunt)
        --  DO: Движение по станционным путям
        --      Включается на станциях с путевым развитием при фактической скорости 0 или нахождении в зоне ОПВ
        --      Автоматически вводится после передачи управления при отсутствии связи между головой и хвостом
        --      Не контролирует пройденный путь и отменяется при фиксации
        --      Разрешает движение со скоростью не более 40, а при ограничении 20 не делает предварительную остановку

        --TODO: Смена линии
        --      Возможно назначить в любой момент до отправления со станции с передаточной ветвью
        --      Видны все станции по ходу движения, имеющие передаточную ветвь
        --      Автмоатическая фиксация станции
        --      При ограничении 20 не делает предварительную остановку

        --  DO: Транзит
        --      Ограничение скорости проезда ОПВ 29км\\ч и 10 на конечных
        --      При запрещающем показании светофора у выходных светофоров торможенеи до полной остановки

        --Block door open without all conditions
        --  DO: При наличии 16 провода и отсутвии 15го в течении 5 секунд подсказка "Нет контроля закрытия дверей"


        --if  PAM_VV.K16>0  and PAM_VV.KD==0 and not self.KDTimer then self.KDTimer = CurTime() end
        --if (PAM_VV.K16==0 or  PAM_VV.KD>0) and     self.KDTimer then self.KDTimer = nil end

        --Get controller state
        local driveModeKV = 0
        if PAM_VV.KGR == 0 then
            driveModeKV = 1+PAM_VV.I2+PAM_VV.I3
        elseif PAM_VV.I33G > 0 then
            driveModeKV = -2-PAM_VV.I2*2+PAM_VV.I25
        end

        --Fire rolling back logic
        if self.FireBack then
            local opvDist = self.FireBack.isHorlift and -0.45 or -1
            if self.FireBack.pos-self.Distance>opvDist then
                self.StationTable=self.FireBack
                self:SetDriveMode("OXT")
                self:SetPneumoMode("V1")
                if speed>5.4 then self:SetPneumoMode("V2") end
                if speed<0.2 then self.FireBack = false end
            end
        end

        local No34 = self.V1Stop and CurTime()-self.V1Stop > 4
        self.ControlMode2 = (PAM_VV.KVARS > 0 or self.PAKSD) and not No34 and PAM_VV.KSOT > 0
        local mode = self.ControlMode2 and 2 or 1

        if self.ControlMode~=mode and (mode==1 or self.ControlModeAuto) then
            self.ControlMode = mode
            self.ControlModeAuto = true
        end
        if RR then
            self:Error(20,self.ControlModeAuto and self.ControlMode==1,No34 and 14 or 7,true)
            self:Error(21,self.ControlModeAuto and self.ControlMode==2,7,true)
            self:Error(29,No34,7,true)
            self:Error(30,self.No34 and not No34,7,true)
            self.No34 = No34
        end

        self:Error(24,false,7,true)

        local BlockBack = self.State==6 or not self.FireBack and self.Mode>2 and (not self.StationTable.isHorlift or dist > -.45 or dist < -6 or speed>=3.6)
        if (driveModeKV>=0 or PAM_VV.KRU > 0) and (
                --TODO аппаратура отменяет ходвоой режим и назначает ВЗ№1 при подезде к рейке
                not RR or
                BackReverser and BlockBack
                or self.FireBack and speed>10
                or self.LPTTimer and CurTime()-self.LPTTimer>6.5
                or self.ControlMode==1 and PAM_VV.KB==0
                or  PAM_VV.KD < 1 and not self.NoKD and PAM_VV.KRU == 0
                or PAM_VV.KTARS > 0) then
            self:SetDriveMode("OXT")
        end
        self:Error(3,BackReverser and BlockBack and not BackActive)

        --Rolling check
        if self.State5==1 then
            if not self.RollingCheckRolled then self.RollingCheckRolled = 0 end
            local rolled = speedMpSSigned*dT
            if math.abs(rolled) >0.001 then
                self.RollingCheckRolled = self.RollingCheckRolled + rolled
                Train:SetNW2Float("PAM:RollDist",self.RollingCheckRolled)
            end
            if self.RollingCheckRolled > 2.5 or self.RollingCheckRolled < -0.3 then
                self.Stopped = true
                self.RollingCheckRolled = false
                self.State5 = nil
                Train:SetNW2Float("PAM:RollDist",0)
            end
            if self.NoFreq>0 and PAM_VV.KB==0 then
                self:SetPneumoMode("V2")
            end
        else
            self.RollingCheckRolled = false
        end

        --if RR and self.ControlMode==1 and PAM_VV.KB==0 then self:SetPneumoMode("V2") end
        if self.PneumoMode == "V1" or self.PneumoMode == "V12" then
            if PAM_VV.V1==0 and not self.V1Timer then self.V1Timer = CurTime() end
            if PAM_VV.V1>0 then
                if self.V1Timer then self.V1Timer = nil end
                if PAM_VV.LPT==0 and not self.V1ETimer then self.V1ETimer = CurTime() end
                if PAM_VV.LPT>0 and PAM_VV.V2==0 and self.V1ETimer then self.V1ETimer = nil end
            end
        else
            self.V1Timer = nil
            self.V1ETimer = nil
        end
        if self.V1Timer and CurTime()-self.V1Timer > 2 then self:SetPneumoMode("V2") end
        if self.V1ETimer and CurTime()-self.V1ETimer > 2.5 then self:SetPneumoMode("V2") end

        if self.PneumoMode == "V2" or self.PneumoMode == "V12" then
            if PAM_VV.V2==0 and not self.V2Timer then self.V2ETimer = CurTime() end
            if PAM_VV.V2>0 then
                if self.V2Timer then self.V2Timer = nil end
                if PAM_VV.LPT==0 and not self.V2ETimer then self.V2ETimer = CurTime() end
                if PAM_VV.LPT>0 and self.V2ETimer then self.V2ETimer = nil end
            end
        else
            self.V2Timer = nil
            self.V2ETimer = nil
        end
        if speed<2.5 and (PAM_VV.KB > 0 or not RR) then self.EPKActive = true end
        if self.RingArmed and CurTime()-self.RingArmed>3 then self.EPKActive = false end
        if self.V2ETimer and CurTime()-self.V2ETimer>2 then self.EPKActive = false end

        if self.Mode==3 then
            if self.BoardRing==nil and Train.BoardTimer and Train.BoardTimer<-2 and PAM_VV.KD==0 then self.BoardRing = CurTime() end
            if self.BoardRing and (PAM_VV.KB>0 or PAM_VV.KD>0 or CurTime()-self.BoardRing>2) then self.BoardRing = false end
        else
            self.BoardRing = nil
        end

        if self.RingArmed and PAM_VV.KB > 0 then self.RingArmed = false end
        if self.CurrentErrorR ~= self.CurrentError then
            self.CurrentErrorR = self.CurrentError
            self.CurrentErrorRing = errorsRing[self.CurrentError]==false and CurTime()
        end
        Ring = self.RingArmed or self.BoardRing or self.StationBrakeRing or errorsRing[self.CurrentError] or self.CurrentErrorRing and CurTime()-self.CurrentErrorRing<1.5 or self.CheckRing
        Train:SetNW2Int("PAM:DriveMode",self.ControlMode+PAM_VV.KRU*3)
        local driveMode = self.DriveModesConv[self.DriveMode]
        Train:SetNW2Int("PAM:KVMode",driveMode>0 and math.max(driveMode,driveModeKV) or driveMode<0 and math.min(driveMode,driveModeKV) or driveModeKV)
        Train:SetNW2String("PAM:CurrentStation",station)
        Train:SetNW2String("PAM:TargetStation",stationLast)
        Train:SetNW2Int("PAM:BoardTime",Train.BoardTimer or 0)
        Train:SetNW2Int("PAM:CurrentError",self.CurrentError or 0)

        if self.MessageTimer and CurTime()-self.MessageTimer > 4 then
            self.CurrentMessage = 0
            self.MessageTimer = false
        end
        Train:SetNW2Int("PAM:CurrentMessage",self.CurrentMessage or 0)

        Train:SetNW2Bool("PAM:OXT",OXT)
        Train:SetNW2Int("PAM:Vf",speed)
        Train:SetNW2Int("PAM:SpeedLimit",self.SpeedLimit)
        Train:SetNW2String("PAM:RC",signal)
        Train:SetNW2Int("PAM:Slope",slope)
        Train:SetNW2Float("PAM:S",dist)
        Train:SetNW2Int("PAM:V",not self.EPKActive and -1 or PAM_VV.V2 > 0 and 2 or PAM_VV.V1 > 0 and (false and 2 or 1) or 0)
        Train:SetNW2Bool("PAM:LPT",PAM_VV.LPT > 0)
        Train:SetNW2Bool("PAM:KD",self.OpenControl==true and 1 or PAM_VV.KD <= 0 and 2 or 0)
        Train:SetNW2Bool("PAM:KVARS",PAM_VV.KVARS > 0)
        Train:SetNW2Bool("PAM:VRD",PAM_VV.VRD > 0)
        Train:SetNW2Bool("PAM:OPV",opv)
        Train:SetNW2Bool("PAM:State5_-6",not not self.FireBack) --Vд=0
        Train:SetNW2Bool("PAM:State5_5",self.Vd0) --Vд=0
        Train:SetNW2Bool("PAM:State5_2",self.NoKD) --КД
        Train:SetNW2Bool("PAM:State5_4",self.Transit) --ТР
        Train:SetNW2Bool("PAM:State5_8",not not self.Deadlock) --ОБ
        --Train:SetNW2Bool("PAM:State5_3") --СЛ
        Train:SetNW2Bool("PAM:State5_7",self.NoLPT) --ЛПТ
        Train:SetNW2Bool("PAM:State5_6",self.OpenDoors) --ОДП
    end
    if self.CurrentDriveMode then
        self["2"] = self.CurrentDriveMode[2]
        self["3"] = self.CurrentDriveMode[3]
        local pr8 = self.CurrentDriveMode[4]
        if pr8 ~= self.Target8 then
            if pr8 == 0 or self.pr8Timer and CurTime()-self.pr8Timer > 1.5 then
                self.Target8 = pr8
                self.pr8Timer = nil
            end
            if pr8 > 0 and not self.pr8Timer then self.pr8Timer = CurTime() end
        end
        if pr8 == 0 and self.pr8Timer then self.pr8Timer = CurTime() end
        self["8"] = self.Target8+self.CurrentDriveMode[13]*(PAM_VV.KRU+self.NoFreq)
        self["17"] = self.CurrentDriveMode[5]
        self["19"] = self.CurrentDriveMode[6]
        self["20"] = self.CurrentDriveMode[7]
        self["20X"] = self.CurrentDriveMode[8]
        self["25"] = self.CurrentDriveMode[9]
        self["025"] = self.CurrentDriveMode[10]
        self["33"] = self.CurrentDriveMode[11]
        self["033"] = self.CurrentDriveMode[12]
        self["33G"] = self.CurrentDriveMode[13]*(1-PAM_VV.KRU)
    end
    if self.CurrentDoorMode then
        self["16"] = self.CurrentDoorMode[1]
        self["31"] = self.CurrentDoorMode[2]
        self["32"] = self.CurrentDoorMode[3]
    end
    if self.CurrentPneumoMode then
        self["39"] = self.CurrentPneumoMode[2]
        self["48"] = self.CurrentPneumoMode[3]
    end
    self.EPK = (self.State==4 or (self.State==5 or self.State==6) and RR and self.EPKActive) and 1 or 0
    self.Ring = (Ring) and 1 or 0
    Train:SetNW2String("PAM:Station",self.Station)
    Train:SetNW2String("PAM:Line",self.Line)
    Train:SetNW2String("PAM:Path",self.Path)
    Train:SetNW2Bool("PAM:Reverser",self.ReverserWrench)
    Train:SetNW2Bool("PAM:Keyboard",self.Keyboard)
    Train:SetNW2Bool("PAM:Selected",self.Selected)
    Train:SetNW2Int("PAM:State5",self.State5)
    Train:SetNW2Int("PAM:State5Accept",self.State5Accept)
end
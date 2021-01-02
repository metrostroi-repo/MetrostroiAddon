--------------------------------------------------------------------------------
-- All the models, materials, sounds belong to their corresponding authors. Permission is granted to only distribute these models through Garry's Mod Steam Workshop and the official Metrostroi GitHub accounts for use with Garry's Mod and Metrostroi Subway Simulator.
--
-- It is forbidden to use any of these models, materials, sounds and other content for any commercial purposes without an explicit permission from the authors. It is forbidden to make any changes in these files in any derivative projects without an explicit permission from the author.
--
-- The following models are (C) 2015-2018 oldy (Aleksandr Kravchenko). All rights reserved.
-- models\metrostroi_train\81-502:
-- - 81-502  (Ema-502 head)
-- - 81-501  (Em-501 intermediate)
-- models\metrostroi_train\81-702:
-- - 81-702  (D head)
-- - 81-702  (D intermediate)
-- models\metrostroi_train\81-703:
-- - 81-703  (E head)
-- - 81-508  (E intermediate)
-- models\metrostroi_train\81-707:
-- - 81-707  (Ezh head)
-- - 81-708  (Ezh1 intermediate)
-- models\metrostroi_train\81-710:
-- - 81-710  (Ezh3 head)
-- - 81-508T (Em-508T intermediate)
-- models\metrostroi_train\81-717:
-- - 81-717  (Moscow head)
-- - 81-714  (Moscow intermediate)
-- - 81-717  (St. Petersburg head)
-- - 81-714  (St. Petersburg intermediate)
-- models\metrostroi_train\81-718:
-- - 81-718  (TISU head)
-- - 81-719  (TISU intermediate)
-- models\metrostroi_train\81-720:
-- - 81-720  (Yauza head)
-- - 81-721  (Yauza intermediate)
-- - 81-722  (Yubileyniy head)
-- models\metrostroi_train\81-722:
-- - 81-723  (Yubileyniy intermediate motor)
-- - 81-724  (Yubileyniy intermediate trailer)
--------------------------------------------------------------------------------
include("shared.lua")

--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.AutoAnimNames = {}
ENT.ClientSounds = {}

ENT.ClientProps["schemes"] = {
    model = "models/metrostroi_train/81-717/labels/schemes.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
    callback = function(ent)
        ent.PassSchemesDone = false
    end,
}
ENT.ClientProps["salon"] = {
    model = "models/metrostroi_train/81-718/interior_int.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["seats"] = {
    model = "models/metrostroi_train/81-717/couch_old_int.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}

ENT.ClientProps["seats_old_cap"] = {
    model = "models/metrostroi_train/81-717/couch_cap_l.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0)
}
ENT.ClientProps["seats_old_cap_o"] = {
    model = "models/metrostroi_train/81-717/couch_cap_l.mdl",
    pos = Vector(-285,410,13),
    ang = Angle(0,70,-70),
    hideseat=0.8,
}
ENT.ClientProps["otsek_cap_l"] = {
    model = "models/metrostroi_train/81-717/otsek_cap_l.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=0.8,
}
ENT.ClientProps["otsek_cap_r"] = {
    model = "models/metrostroi_train/81-717/otsek_cap_r.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=0.8,
}

local function placeLamps(name)
    if not ENT.ButtonMap[name] or not ENT.ButtonMap[name].buttons then return end
    local nAdd = name:sub(name:find("_")+1,-1)
    for i,button in pairs(ENT.ButtonMap[name].buttons) do
        button.ID = nAdd..button.ID
        button.model = {
            --model = "models/metrostroi_train/81/lamp.mdl", z = -25,
            lamp = {
                speed=16,
                model = "models/metrostroi_train/common/lamps/svetodiod2.mdl",
                z=-5.5,
                var=button.var,
                color=button.col=="y" and Color(255,168,0) or button.col=="r" and Color(255,56,30) or button.col=="g" and Color(175,250,20) or Color(255,255,255)}
        }
        button.var=nil
    end
end
ENT.ButtonMap["BUV_MPS"] = {
    pos = Vector(-425,60+1,-15),
    ang = Angle(0,0,90),
    width = 30,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "PROV", x=5+8*0,y=15+5*2,  radius=3,col="g",var="VIPROV", tooltip="Проверка",},
        {ID = "AVR",  x=5+8*0,y=15+5*3,  radius=3,col="r",var="VIAVR",  tooltip="Отключение режимов",},
        {ID = "TARS", x=5+8*0,y=15+5*9,  radius=3,col="g",var="VITARS", tooltip="Тормоз БКБД",},
        {ID = "X" ,   x=5+8*0,y=15+5*10, radius=3,col="g",var="VIX",    tooltip="Код режима \"Ход\"",},

        {ID = "NZ",   x=5+8*1,y=15+5*0,  radius=3,col="g",var="VINZ",   tooltip="Назад",},
        {ID = "NZR",  x=5+8*1,y=15+5*1,  radius=3,col="g",var="VINR",   tooltip="Резервный назад",},
        {ID = "PROV0",x=5+8*1,y=15+5*2,  radius=3,col="g",var="VIPROV0",tooltip="Проверка работы",},
        {ID = "SK",   x=5+8*1,y=15+5*3,  radius=3,col="g",var="",       tooltip="Скорость",},
        {ID = "T",    x=5+8*1,y=15+5*9,  radius=3,col="g",var="VIT",    tooltip="Код режима \"Тормоз\"",},
        {ID = "XR",   x=5+8*1,y=15+5*10, radius=3,col="g",var="VIXP",   tooltip="Резервный ход 1",},
        {ID = "U1",   x=5+8*1,y=15+5*11, radius=3,col="g",var="VIU1",   tooltip="Уставка 1",},
        {ID = "U2",   x=5+8*1,y=15+5*12, radius=3,col="g",var="VIU2",   tooltip="Уставка 2",},

        {ID = "VP",   x=5+8*2,y=15+5*0,  radius=3,col="g",var="VIVP",   tooltip="Вперёд",},
        {ID = "VPR",  x=5+8*2,y=15+5*1,  radius=3,col="g",var="VIVR",   tooltip="Резервный вперед",},
        {ID = "VZ",   x=5+8*2,y=15+5*2.5,radius=3,col="g",var="VIVZ",   tooltip="Возврат защиты",},
        {ID = "XM",   x=5+8*2,y=15+5*10, radius=3,col="g",var="VIM",    tooltip="Маневровый ход",},
        {ID = "U1R",  x=5+8*2,y=15+5*11, radius=3,col="g",var="VIU1R",  tooltip="Резервный ход 2",},
    }
}
ENT.ButtonMap["BUV_MVD"] = {
    pos = Vector(-425+1.8,60+1,-15),
    ang = Angle(0,0,90),
    width = 20,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "OTK",  x=2+8*1,y=15+5*4.5,radius=3,col="r",var="VOTK",    tooltip="Отказ режимов",},
        {ID = "RP",   x=2+8*1,y=15+5*6.9,radius=3,col="r",var="VRP",     tooltip="Сработка РП",},
    }
}

ENT.ButtonMap["BUV_MALP1"] = {
    pos = Vector(-425+3,60+1,-15),
    ang = Angle(0,0,90),
    width = 30,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "MZK", x=11+8*0,y=15+5*2,  radius=3,col="r",var="VMZK",   tooltip="Мгновенный запрет ключа",},
        {ID = "FM",  x=11+8*0,y=15+5*3,  radius=3,col="r",var="VFM",    tooltip="Напряжение на фильтре выше 1000 вольт",},
        {ID = "400", x=11+8*0,y=15+5*4,  radius=3,col="g",var="VU400",  tooltip="Наличие400 вольт",},
        {ID = "50" , x=11+8*0,y=15+5*5,  radius=3,col="g",var="VE1350", tooltip="Наличие тока якоря Гр А",},
        {ID = "DIF", x=11+8*0,y=15+5*6,  radius=3,col="g",var="VDIF",   tooltip="Разность токов гр А,В",},
        {ID = "650", x=11+8*0,y=15+5*7,  radius=3,col="r",var="VE13650",tooltip="Ток якоря Гр А выше 650 ампер",},
        {ID = "0",   x=11+8*0,y=15+5*8,  radius=3,col="r",var="VE130",  tooltip="Якорный ток Гр А отсутствует",},
        {ID = "ARS", x=11+8*0,y=15+5*9,  radius=3,col="r",var="",       tooltip="Срыв частотного запуска",},
        {ID = "ITA", x=11+8*0,y=15+5*10, radius=3,col="r",var="",       tooltip="Пробой тормозного тиристора Гр А > 100a",},

        {ID = "TR",  x=11+8*1,y=15+5*5.5,radius=3,col="g",var="",       tooltip="Наличие реостатного тока более 100 а Гр А",},
        {ID = "SN",  x=11+8*1,y=15+5*7.3,radius=3,col="r",var="VSN",     tooltip="Силовая схема не собрана",},
        {ID = "VN",  x=11+8*1,y=15+5*9,  radius=3,col="r",var="",       tooltip="Неисправность вентиляторов",},
    }
}
ENT.ButtonMap["BUV_MALP2"] = {
    pos = Vector(-425+4.8,60+1,-15),
    ang = Angle(0,0,90),
    width = 30,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "MSU", x=11+8*0,y=15+5*2,  radius=3,col="r",var="VMSU",   tooltip="Мгновенный сброс уставки",},
        {ID = "800", x=11+8*0,y=15+5*3,  radius=3,col="g",var="VU800",  tooltip="Напряжение сети 800 вольт",},
        {ID = "975", x=11+8*0,y=15+5*4,  radius=3,col="g",var="VU975",  tooltip="Максимальное напряжение сети ",},
        {ID = "50" , x=11+8*0,y=15+5*5,  radius=3,col="g",var="VE2450", tooltip="Наличие тока якоря Гр B",},
        {ID = "650", x=11+8*0,y=15+5*7,  radius=3,col="r",var="VE24650",tooltip="Ток якоря Гр B выше 650 ампер",},
        {ID = "0",   x=11+8*0,y=15+5*8,  radius=3,col="r",var="VE240",  tooltip="Якорный ток Гр B отсутствует",},
        {ID = "BV",  x=11+8*0,y=15+5*9,  radius=3,col="r",var="VBV",    tooltip="Сработала БВ",},
        {ID = "ITB", x=11+8*0,y=15+5*10, radius=3,col="r",var="",       tooltip="Пробой тормозного тиристора Гр B > 100a",},
    }
}
ENT.ButtonMap["BUV_MIV"] = {
    pos = Vector(-425+6.6,60+1,-15),
    ang = Angle(0,0,90),
    width = 30,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "33",  x=11+8*0,y=15+5*3.7,radius=3,col="g",var="VZZ",     tooltip="Частотный запуск завершен",},
        {ID = "V1",  x=11+8*0,y=15+5*5,  radius=3,col="g",var="VV1",     tooltip="Вентиль1",},
        {ID = "SMA", x=11+8*0,y=15+5*6.3,radius=3,col="g",var="VSMA",    tooltip="Сигнал максимальный Гр А",},
        {ID = "SMB", x=11+8*0,y=15+5*7.6,radius=3,col="g",var="VSMB",    tooltip="Сигнал максимальный Гр В",},
    }
}

ENT.ButtonMap["BUV_MGR"] = {
    pos = Vector(-425,60+1,-23),
    ang = Angle(0,0,90),
    width = 30,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "TP1", x=5+8*0,y=15+5*2,   radius=3,col="y",var="VITP1", tooltip="Прижатие токоприемника 1",},
        {ID = "TP3", x=5+8*0,y=15+5*3.5, radius=3,col="y",var="VITP3", tooltip="Прижатие токоприемника 3",},
        {ID = "KHA", x=5+8*0,y=15+5*9,   radius=3,col="y",var="VIKX",  tooltip="Включение контакторов хода группы А",},
        {ID = "KTA", x=5+8*0,y=15+5*10.5,radius=3,col="y",var="VIKT",  tooltip="Включение контакторов тормоза группы А",},

        {ID = "TP2", x=5+8*1,y=15+5*2,   radius=3,col="y",var="VITP2", tooltip="Прижатие токоприемника 2",},
        {ID = "TP4", x=5+8*1,y=15+5*3.5, radius=3,col="y",var="VITP4", tooltip="Прижатие токоприемника 4",},
        {ID = "KHB", x=5+8*1,y=15+5*9,   radius=3,col="y",var="VIKX",  tooltip="Включение контакторов хода группы B",},
        {ID = "KTB", x=5+8*1,y=15+5*10.5,radius=3,col="y",var="VIKT",  tooltip="Включение контакторов тормоза группы B",},
        {ID = "KRV", x=5+8*1,y=15+5*12,  radius=3,col="y",var="VIRV",  tooltip="Включение контакторов реверса вперёд",},

        {ID = "NV",  x=5+8*2,y=15+5*1,   radius=3,col="r",var="",      tooltip="Неисправность вентилятора ПТТИ",},
        {ID = "BV",  x=5+8*2,y=15+5*3,   radius=3,col="g",var="VIBV",  tooltip="БВ взведён",},
        {ID = "LK",  x=5+8*2,y=15+5*10,  radius=3,col="y",var="VILT",  tooltip="Включение линейного контактора",},
        {ID = "KRN", x=5+8*2,y=15+5*12,  radius=3,col="y",var="VIRN",  tooltip="Включение контакторов реверса назад",},
    }
}
ENT.ButtonMap["BUV_MLUA"] = {
    pos = Vector(-425+1.8,60+1,-23),
    ang = Angle(0,0,90),
    width = 20,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "KT",  x=10+8*0,y=17+5*3,  radius=3,col="g",var="VOKT",  tooltip="Команда тормоза",},
        {ID = "XH",  x=10+8*0,y=17+5*4,  radius=3,col="g",var="VOKX",  tooltip="Команда хода",},
        {ID = "VP",  x=10+8*0,y=17+5*5,  radius=3,col="g",var="VOVP",  tooltip="Команда включения реверса вперёд",},
        {ID = "NZ",  x=10+8*0,y=17+5*6,  radius=3,col="g",var="VONZ",  tooltip="Команда включения реверса назад",},
        {ID = "SS",  x=10+8*0,y=17+5*7,  radius=3,col="g",var="VSS",   tooltip="Сигнал собранной схемы",},

        {ID = "PV",  x=10+8*0,y=17+5*9,  radius=3,col="g",var="",      tooltip="Команда включения подвозбудителя",},

        {ID = "LK",  x=10+8*0,y=17+5*11, radius=3,col="g",var="VOLK",  tooltip="Команда включения линейного конатктора",},
    }
}
ENT.ButtonMap["BUV_MUVK1"] = {
    pos = Vector(-425+3,60+1,-23),
    ang = Angle(0,0,90),
    width = 40,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "V1",  x=11+8*0,y=19+5*2,  radius=3,col="g",var="VOV1",  tooltip="Управление катушкой ВЗ№1",},
        {ID = "KT",  x=11+8*0,y=19+5*3,  radius=3,col="g",var="VOKT",  tooltip="Управление контакторами тормоза",},
        {ID = "KH",  x=11+8*0,y=19+5*4,  radius=3,col="g",var="VOKX",  tooltip="Управление контакторами хода",},
        {ID = "LK",  x=11+8*0,y=19+5*5,  radius=3,col="g",var="VOLK",  tooltip="Управление линейным контактором",},
        {ID = "PV",  x=11+8*0,y=19+5*6,  radius=3,col="g",var="",      tooltip="Управление подвозбудителем",},
        {ID = "NZ",  x=11+8*0,y=19+5*7,  radius=3,col="g",var="VONZ",  tooltip="Управление реверсом Назад",},

        {ID = "SN",  x=11+8*1,y=19+5*2,  radius=3,col="r",var="VOSN",  tooltip="Силовая схема вагона не собрана",},
    }
}
ENT.ButtonMap["BUV_MUVK2"] = {
    pos = Vector(-425+5.5,60+1,-23),
    ang = Angle(0,0,90),
    width = 30,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "RTM", x=11+8*0,y=19+5*2,  radius=3,col="g",var="VORKT", tooltip="Управление реле минимального тока",},
        {ID = "RKT", x=11+8*0,y=19+5*3,  radius=3,col="g",var="VORMT", tooltip="Управление реле контроля торможения",},
        {ID = "RP",  x=11+8*0,y=19+5*4,  radius=3,col="r",var="VORP",  tooltip="Сработка защиты",},
        {ID = "OTK", x=11+8*0,y=19+5*5,  radius=3,col="r",var="OIZ",   tooltip="Отказ вагона",},
        {ID = "75",  x=11+8*0,y=19+5*6,  radius=3,col="g",var="VO75V", tooltip="Резервное питание БУВ",},
        {ID = "VP",  x=11+8*0,y=19+5*7,  radius=3,col="g",var="VOVP",  tooltip="Управление реверсом Вперед",},
    }
}
---[[
placeLamps("BUV_MPS")
placeLamps("BUV_MVD")
placeLamps("BUV_MALP1")
placeLamps("BUV_MALP2")
placeLamps("BUV_MIV")
placeLamps("BUV_MGR")
placeLamps("BUV_MLUA")
placeLamps("BUV_MUVK1")
placeLamps("BUV_MUVK2")
--]]


ENT.ButtonMap["FrontPneumatic"] = {
    pos = Vector(470-9,-45.0,-58.0+5),
    ang = Angle(0,90,90),
    width = 900,
    height = 100,
    scale = 0.1,

    buttons = {
        {ID = "FrontBrakeLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip="",var="FbI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
        {ID = "FrontTrainLineIsolationToggle",x=500, y=0, w=400, h=100, tooltip="",var="FtI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
    }
}
ENT.ClientProps["FrontBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(449+11, -31, -62),
    ang = Angle(-15,-90,0),
    hide = 2,
}
ENT.ClientProps["FrontTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(449+11, 31, -62),
    ang = Angle( 15,-90,0),
    hide = 2,
}
ENT.ClientSounds["ParkingBrake"] = {{"ParkingBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["FrontBrakeLineIsolation"] = {{"FrontBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["FrontTrainLineIsolation"] = {{"FrontTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}

ENT.ButtonMap["RearPneumatic"] = {
    pos = Vector(-473-1,45.0,-58.0+5),
    ang = Angle(0,270,90),
    width = 1050,
    height = 100,
    scale = 0.1,

    buttons = {
        {ID = "RearTrainLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip="",var="RtI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
        {ID = "RearBrakeLineIsolationToggle",x=500, y=0, w=400, h=100, tooltip="",var="RbI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
        {ID = "ParkingBrakeToggle",x=900, y=0, w=150, h=100, tooltip="",var="ParkingBrake"},
    }
}
ENT.ClientProps["RearTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(-450-22, -34, -62),
    ang = Angle(-15,90,0),
    hide = 2,
}
ENT.ClientProps["RearBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(-450-22, 34, -62),
    ang = Angle( 15,90,0),
}
ENT.ClientProps["ParkingBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_white.mdl",
    pos = Vector(-450-22, -55, -62),
    ang = Angle(-15,90,0),
    hide = 0.5,
}
ENT.ClientSounds["RearBrakeLineIsolation"] = {{"RearBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["RearTrainLineIsolation"] = {{"RearTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}

ENT.ButtonMap["GV"] = {
    pos = Vector(170-3-9.5+22,50+20,-60+2+5),
    ang = Angle(0,225-15,90),
    width = 260,
    height = 260,
    scale = 0.1,
    buttons = {
        {ID = "GVToggle",x=0, y=0, w= 260,h = 260, tooltip="", model = {
            var="GV",sndid = "gv",
            sndvol = 0.8,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            snd = function(val) return val and "gv_f" or "gv_b" end,
            states={"Train.Buttons.Disconnected","Train.Buttons.On"}
        }},
    }
}
ENT.ClientProps["gv"] = {
    model = "models/metrostroi/81-717/gv.mdl",
    pos = Vector(153.5-3-9.5+22,36+20,-78+2+5),
    ang = Angle(-90,90,-90),
    hide = 0.5,
}
ENT.ClientProps["gv_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["gv"].pos,
    ang = Angle(-90,0,0),
    hide = 0.5,
}

ENT.ButtonMap["AirDistributor"] = {
    pos = Vector(-185,-68,-50),
    ang = Angle(0,0,90),
    width = 170,
    height = 80,
    scale = 0.1,
    hideseat=0.1,
    hide=true,
    screenHide = true,

    buttons = {
        {ID = "AirDistributorDisconnectToggle",x=0,y=0,w= 170,h = 80,tooltip="",var="AD",states={"Train.Buttons.On","Train.Buttons.Off"}},
    }
}

-- Battery panel
ENT.ButtonMap["Battery"] = {
    pos = Vector(-470.0,-10,50.6),
    ang = Angle(0,-90,180),
    width = 100,
    height = 100,
    scale = 0.08,
    hide=0.8,

    buttons = {
        {ID = "VBToggle", x=0, y=0, w=100, h=100, tooltip="ВБ: Выключатель батареи", model = {
            model = "models/metrostroi_train/81-717/battery_enabler.mdl",
            var="VB",speed=0.5,vmin=1,vmax=0.8,
            sndvol = 0.8, snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["Voltages"] = {
    pos = Vector(-464.3,-15.2,60.7),
    ang = Angle(0,90,90),
    width = 145,
    height = 75,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "!BatteryVoltage", x=0, y=0, w=72.5,h=75, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BatteryVoltage"),ent:GetPackedRatio("BatteryVoltage")*150) end},
        {ID = "!BatteryCurrent", x=72.5, y=0, w=72.5,h=75, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BatteryCurrent"),ent:GetPackedRatio("BatteryCurrent")*500) end},
    }
}
ENT.ButtonMap["Pressures"] = {
    pos = Vector(-464.3,6.3,61),
    ang = Angle(0,90,90),
    width = 160,
    height = 80,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "!BCPressure", x=0, y=0, w=80,h=80, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BCPressure"),ent:GetPackedRatio("BCPressure")*6) end},
        {ID = "!BLTLPressure", x=80, y=0, w=80,h=80, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BLTLPressure"),ent:GetPackedRatio("TLPressure")*16,ent:GetPackedRatio("BLPressure")*16) end},
    }
}
ENT.ButtonMap["couch_cap"] = {
    pos = Vector(-460,60,0),
    ang = Angle(0,0,70),
    width = 1000,
    height = 600,
    scale = 0.0625,
    hide=0.8,
    buttons = {
        {ID = "CouchCap",x=0,y=0,w=1000,h=600, tooltip=""}
    }
}
ENT.ButtonMap["couch_cap_o"] = {
    pos = Vector(-464,-21,-45),
    ang = Angle(0,70,5),
    width = 1100,
    height = 380,
    scale = 0.0625,
    hide=0.8,
    buttons = {
        {ID = "CouchCap",x=0,y=0,w=1100,h=380, tooltip=""}
    }
}
ENT.ButtonMap["PVZ"] = {
    pos = Vector(-456,60,-15),
    ang = Angle(0,0,90),
    width = 350,
    height = 105,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "SF4Toggle",x=25*1,y=60*0,w=25,h=45,tooltip=""},
        {ID = "SF27Toggle",x=25*2,y=60*0,w=25,h=45,tooltip=""},
        {ID = "SF46Toggle",x=25*3,y=60*0,w=25,h=45,tooltip=""},
        {ID = "SF12Toggle",x=25*4,y=60*0,w=25,h=45,tooltip=""},
        {ID = "SF13Toggle",x=25*5,y=60*0,w=25,h=45,tooltip=""},
        {ID = "SF45Toggle",x=25*6,y=60*0,w=25,h=45,tooltip=""},
        {ID = "SF16Toggle",x=25*7,y=60*0,w=25,h=45,tooltip=""},
        {ID = "SF44Toggle",x=25*8,y=60*0,w=25,h=45,tooltip=""},
        {ID = "SF43Toggle",x=25*9,y=60*0,w=25,h=45,tooltip=""},
        {ID = "SF14Toggle",x=25*10,y=60*0,w=25,h=45,tooltip=""},
        {ID = "SF15Toggle",x=25*11,y=60*0,w=25,h=45,tooltip=""},
        {ID = "SF25Toggle",x=25*12,y=60*0,w=25,h=45,tooltip=""},
        {ID = "SF72Toggle",x=25*13,y=60*0,w=25,h=45,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "SF56Toggle",x=25*0,y=60*1,w=25,h=45,tooltip=""},
        {ID = "SF29Toggle",x=25*1,y=60*1,w=25,h=45,tooltip=""},
        {ID = "SF26Toggle",x=25*2,y=60*1,w=25,h=45,tooltip=""},
        {ID = "SF42Toggle",x=25*3,y=60*1,w=25,h=45,tooltip=""},
        {ID = "SF18Toggle",x=25*4,y=60*1,w=25,h=45,tooltip=""},
        {ID = "SF20Toggle",x=25*5,y=60*1,w=25,h=45,tooltip=""},
        {ID = "SF17Toggle",x=25*6,y=60*1,w=25,h=45,tooltip=""},
        {ID = "SF19Toggle",x=25*7,y=60*1,w=25,h=45,tooltip=""},
        {ID = "SF21Toggle",x=25*8,y=60*1,w=25,h=45,tooltip=""},
        {ID = "SF22Toggle",x=25*9,y=60*1,w=25,h=45,tooltip=""},
        {ID = "SF34Toggle",x=25*10,y=60*1,w=25,h=45,tooltip=""},
        {ID = "SF35Toggle",x=25*11,y=60*1,w=25,h=45,tooltip=""},
        {ID = "SF23Toggle",x=25*12,y=60*1,w=25,h=45,tooltip=""},
        {ID = "SF24Toggle",x=25*13,y=60*1,w=25,h=45,tooltip=""},
    }
}
for i,button in pairs(ENT.ButtonMap.PVZ.buttons) do
    button.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",
        var=button.ID:Replace("Toggle",""),speed=8,z=-15,
        sndvol = 0.8,snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
    }
end


ENT.ButtonMap["FrontDoor"] = {
    pos = Vector(470-11,16,48.4-2),
    ang = Angle(0,-90,90),
    width = 642,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "FrontDoor",x=0,y=0,w=642,h=1900, tooltip="Передняя дверь", model = {
            var="door1",sndid="door1",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
ENT.ClientProps["door1"] = {
    model = "models/metrostroi_train/81-718/door_torec.mdl",
    pos = Vector(459.2,-15.9,-2.7),
    ang = Angle(0,89.5,0),
    hide=2,
}

ENT.ButtonMap["RearDoor"] = {
    pos = Vector(-470-3,-16,48.4-2),
    ang = Angle(0,90,90),
    width = 642,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=642,h=1900, tooltip="Задняя дверь", model = {
            var="door2",sndid="door2",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
ENT.ClientProps["door2"] = {
    model = "models/metrostroi_train/81-718/door_torec.mdl",
    pos = Vector(-472.5,15.75,-2.7),
    ang = Angle(0,-90,0),
    hide=2,
}


ENT.ClientProps["train_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(-465.05,14.2,58.55),
    ang = Angle(-90,0,180),
    hideseat=0.8,
}
ENT.ClientProps["brake_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_tm.mdl",
    pos = Vector(-465.01,14.2,58.55),
    ang = Angle(-90,0,180),
    hideseat=0.8,
}
ENT.ClientProps["brake_cylinder"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(-464.94,9.0,58.45),
    ang = Angle(-90,0,180),
    hideseat=0.8,
}
--------------------------------------------------------------------------------
ENT.ClientProps["voltmeter"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(-464.80,-13.07,56.81),
    ang = Angle(-90,0,180),
    hideseat=0.8,
    bscale = Vector(1.2,1.2,1.65)
}
ENT.ClientProps["ampermeter"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(-464.80,-8.04,56.81),
    ang = Angle(-90,0,180),
    hideseat=0.8,
    bscale = Vector(1.2,1.2,1.65)
}

ENT.ClientProps["bortlamps1"] = {
    model = "models/metrostroi_train/81-502/bort_lamps_body.mdl",
    pos = Vector(-52,67,45.5),
    ang = Angle(0,0,0),
    hide = 2,
}
ENT.ClientProps["bortlamp1_w"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_b.mdl",
    pos = ENT.ClientProps.bortlamps1.pos+Vector(0,0.9,3.25),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamp1_g"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_g.mdl",
    pos = ENT.ClientProps.bortlamps1.pos+Vector(0,0.9,-0.1),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamp1_y"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_y.mdl",
    pos = ENT.ClientProps.bortlamps1.pos+Vector(0,0.9,-3.3),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamps2"] = {
    model = "models/metrostroi_train/81-717/bort_lamps_body.mdl",
    pos = Vector(39,-67,45.5),
    ang = Angle(0,180,0),
    hide = 2,
}
ENT.ClientProps["bortlamp2_w"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_b.mdl",
    pos = ENT.ClientProps.bortlamps2.pos+Vector(0,-0.9,3.25),
    ang = Angle(0,180,0),
    nohide = true,
}
ENT.ClientProps["bortlamp2_g"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_g.mdl",
    pos = ENT.ClientProps.bortlamps2.pos+Vector(0,-0.9,-0.1),
    ang = Angle(0,180,0),
    nohide = true,
}
ENT.ClientProps["bortlamp2_y"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_y.mdl",
    pos = ENT.ClientProps.bortlamps2.pos+Vector(0,-0.9,-3.3),
    ang = Angle(0,180,0),
    nohide = true,
}
--[[
ENT.ClientProps["bortlamps3"] = {
    model = "models/metrostroi_train/81-502/bort_lamps_body.mdl",
    pos = Vector(-6.5,67,51.2),
    ang = Angle(90,0,0),
    hide = 2,
}
ENT.ClientProps["bortlamp3_w"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_b.mdl",
    pos = ENT.ClientProps.bortlamps3.pos+Vector(3.28,0.9,-0.02),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamp3_g"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_g.mdl",
    pos = ENT.ClientProps.bortlamps3.pos+Vector(-0.06,0.9,-0.02),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamp3_y"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_y.mdl",
    pos = ENT.ClientProps.bortlamps3.pos+Vector(-3.33,0.9,-0.02),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamps4"] = {
    model = "models/metrostroi_train/81-502/bort_lamps_body.mdl",
    pos = Vector(-6.5,-67,51.2),
    ang = Angle(90,180,0),
    hide = 2,
}
ENT.ClientProps["bortlamp4_w"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_b.mdl",
    pos = ENT.ClientProps.bortlamps4.pos+Vector(-3.28,-0.9,-0.02),
    ang = Angle(0,180,0),
    nohide = true,
}
ENT.ClientProps["bortlamp4_g"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_g.mdl",
    pos = ENT.ClientProps.bortlamps4.pos+Vector(0.06,-0.9,-0.02),
    ang = Angle(0,180,0),
    nohide = true,
}
ENT.ClientProps["bortlamp4_y"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_y.mdl",
    pos = ENT.ClientProps.bortlamps4.pos+Vector(3.33,-0.9,-0.02),
    ang = Angle(0,180,0),
    nohide = true,
}--]]
--------------------------------------------------------------------------------
-- Add doors
--[[ local function GetDoorPosition(i,k,j)
    if j == 0
    then return Vector(338.2-230.1*i+(1-k)*0.8,-65.449*(1-2*k),0.761)
    else return Vector(338.2-230.1*i+(1-k)*0.8,-65.449*(1-2*k),0.761)
    end
end
for i=0,3 do
    for k=0,1 do
        ENT.ClientProps["door"..i.."x"..k.."a"] = {
            model = "models/metrostroi_train/81-718/door_right.mdl",
            pos = GetDoorPosition(i,k,0),
            ang = Angle(0,90 +180*k,0),
            hide = 2,
        }
        ENT.ClientProps["door"..i.."x"..k.."b"] = {
            model = "models/metrostroi_train/81-718/door_left.mdl",
            pos = GetDoorPosition(i,k,1),
            ang = Angle(0,90 +180*k,0),
            hide = 2,
        }
    end
end--]]
ENT.ClientProps["door0x1"] = {
    model = "models/metrostroi_train/81-718/81-718_doors_pos1.mdl",
    pos = Vector(338.445,65.164,0.807),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x1"] = {
    model = "models/metrostroi_train/81-718/81-718_doors_pos2.mdl",
    pos = Vector(108.324,65.164,0.807),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x1"] = {
    model = "models/metrostroi_train/81-718/81-718_doors_pos3.mdl",
    pos = Vector(-122.182+0.4,65.164,0.807),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x1"] = {
    model = "models/metrostroi_train/81-718/81-718_doors_pos4.mdl",
    pos = Vector(-351.531,65.164,0.807),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door0x0"] = {
    model = "models/metrostroi_train/81-718/81-718_doors_pos4.mdl",
    pos = Vector(338.445,-65.164,0.807),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x0"] = {
    model = "models/metrostroi_train/81-718/81-718_doors_pos3.mdl",
    pos = Vector(108.324,-65.164,0.807),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x0"] = {
    model = "models/metrostroi_train/81-718/81-718_doors_pos2.mdl",
    pos = Vector(-122.182+0.6,-65.164,0.807),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x0"] = {
    model = "models/metrostroi_train/81-718/81-718_doors_pos1.mdl",
    pos = Vector(-351.531,-65.164,0.807),
    ang = Angle(0,90,0),
    hide = 2.0,
}

local xpos = {
    -417.6,
    -354.2,
    -285.5,
    -236.0,
    -186.6,
    -123,
    -55.62,
    -11.79+5.7,
    46.24-2.8,
    104.27+2.65,
    162.30+12.25,
    220.33+3.8,
    278.36-4.9,
    336.3+5.6,
    394.24+11.25,
}
for i = 0,29 do
    ENT.ClientProps["lamp1_"..i+1] = {
        model = "models/metrostroi_train/81-717/lamps/lamp_typ2.mdl",
        pos = Vector(xpos[math.floor(i/2)+1], 29.7-(i%2)*59.4, 63.3),
        ang = Angle(0,0,-8+(i%2)*16),
        hide = 1.1,
    }
end
local yventpos = {
    -414.5+0*117,
    -414.5+1*117+6.2,
    -414.5+2*117+5,
    -414.5+3*117+2,
    -414.5+4*117-6.2,
    -414.5+5*117-9,
    -414.5+6*117-10.2,
    -414.5+7*117-4,
}
for i=1,8 do
    ENT.ClientProps["vent"..i] = {
        model = "models/metrostroi_train/81-720/vent.mdl",
        pos = Vector(yventpos[i],0,62),
        ang = Angle(0,0,0),
        hide = 1.1,
    }
end
for i=0,3 do
    ENT.ClientProps["TrainNumberL"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(41+16+i*6.6-5*6.6/2,67.4,-17.8),
        ang = Angle(0,180,0),
        skin=i,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
    ENT.ClientProps["TrainNumberR"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(64+16-i*6.6-5*6.6/2,-67.4,-17.8),
        ang = Angle(0,0,0),
        skin=i,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end

ENT.Lights = {
    [11] = { "dynamiclight",    Vector( 200, 0, -20), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400 , fov=180,farz = 128, changable = true  },
    [12] = { "dynamiclight",    Vector(   0, 0, -20), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400, fov=180,farz = 128, changable = true  },
    [13] = { "dynamiclight",    Vector(-200, 0, -20), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400 , fov=180,farz = 128, changable = true  },

    -- Side lights
    [15] = { "light",Vector(-52,67,45.5)+Vector(0,0.9,3.25), Angle(0,0,0), Color(254,254,254), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [16] = { "light",Vector(-52,67,45.5)+Vector(0,0.9,-0.02), Angle(0,0,0), Color(40,240,122), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [17] = { "light",Vector(-52,67,45.5)+Vector(0,0.9,-3.3), Angle(0,0,0), Color(254,210,18), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [18] = { "light",Vector(39,-67,45.5)+Vector(0,-0.9,3.25), Angle(0,0,0), Color(254,254,254), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [19] = { "light",Vector(39,-67,45.5)+Vector(0,-0.9,-0.02), Angle(0,0,0), Color(40,240,122), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [20] = { "light",Vector(39,-67,45.5)+Vector(0,-0.9,-3.3), Angle(0,0,0), Color(254,210,18), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
}

local tbl = {[0]=-0.25,0.00,0.04,0.09,0.13,0.17,0.20,0.27,0.33,0.42,0.56,0.73,1.00}
function ENT:Initialize()
    self.BaseClass.Initialize(self)
    --self.Train:SetPackedRatio("EmergencyValve_dPdT", leak)
    --self.Train:SetPackedRatio("EmergencyValveEPK_dPdT", leak)
    --self.Train:SetPackedRatio("EmergencyBrakeValve_dPdT", leak)

    self.CraneRamp = 0
    self.ReleasedPdT = 0
    self.EmergencyValveRamp = 0
    self.EmergencyValveEPKRamp = 0
    self.EmergencyBrakeValveRamp = 0
    self.FrontLeak = 0
    self.RearLeak = 0

    self.TISUVol = 0
    self.TISUFreq = 0

    self.VentRand = {}
    self.VentState = {}
    self.VentVol = {}
    for i=1,8 do
        self.VentRand[i] = math.Rand(0.5,2)
        self.VentState[i] = 0
        self.VentVol[i] = 0
    end
end
function ENT:UpdateWagonNumber()
    for i=0,3 do
        local count = self.WagonNumber < 250 and 3 or 4
        self:ShowHide("TrainNumberL"..i,i<count)
        self:ShowHide("TrainNumberR"..i,i<count)
        if i< count and self.WagonNumber then
            local leftNum,rightNum = self.ClientEnts["TrainNumberL"..i],self.ClientEnts["TrainNumberR"..i]
            local num = math.floor(self.WagonNumber%(10^(i+1))/10^i)
            if IsValid(leftNum) then
                leftNum:SetPos(self:LocalToWorld(Vector(41+16+i*6.6-count*6.6/2,67.4,-17.8)))
                leftNum:SetSkin(num)
            end
            if IsValid(rightNum) then
                rightNum:SetPos(self:LocalToWorld(Vector(64+16-i*6.6-count*6.6/2,-67.4,-17.8)))
                rightNum:SetSkin(num)
            end
        end
    end
end
--------------------------------------------------------------------------------
local Cpos = {
    0,0.22,0.429,0.513,0.597,0.825,1
}

function ENT:Think()
    --if LocalPlayer():SteamID() == "STEAM_0:0:48355213" then return end
    self.BaseClass.Think(self)
    local dT = self.DeltaTime

    if not self.RenderClientEnts or self.CreatingCSEnts then
        self.TISUFreq = 13
        return
    end

    if self.Scheme ~= self:GetNW2Int("Scheme",1) then
        self.PassSchemesDone = false
        self.Scheme = self:GetNW2Int("Scheme",1)
    end
    if not self.PassSchemesDone and IsValid(self.ClientEnts.schemes) then
        local scheme = Metrostroi.Skins["717_new_schemes"] and Metrostroi.Skins["717_new_schemes"][self.Scheme]
        self.ClientEnts.schemes:SetSubMaterial(1,scheme and scheme[1])
        self.PassSchemesDone = true
    end

    local Bortlamp_w = self:Animate("Bortlamp_w",self:GetPackedBool("DoorsW") and 1 or 0,0,1,16,false)
    local Bortlamp_g = self:Animate("Bortlamp_g",self:GetPackedBool("GRP") and 1 or 0,0,1,16,false)
    local Bortlamp_y = self:Animate("Bortlamp_y",self:GetPackedBool("BrW") and 1 or 0,0,1,16,false)
    self:ShowHideSmooth("bortlamp1_w",Bortlamp_w)
    self:ShowHideSmooth("bortlamp1_g",Bortlamp_g)
    self:ShowHideSmooth("bortlamp1_y",Bortlamp_y)
    self:ShowHideSmooth("bortlamp2_w",Bortlamp_w)
    self:ShowHideSmooth("bortlamp2_g",Bortlamp_g)
    self:ShowHideSmooth("bortlamp2_y",Bortlamp_y)
    self:SetLightPower(15, Bortlamp_w > 0.5)
    self:SetLightPower(18, Bortlamp_w > 0.5)
    self:SetLightPower(16, Bortlamp_g > 0.5)
    self:SetLightPower(19, Bortlamp_g > 0.5)
    self:SetLightPower(17, Bortlamp_y > 0.5)
    self:SetLightPower(20, Bortlamp_y > 0.5)

    local activeLights = 0
    for i = 1,30 do
        local colV = self:GetNW2Vector("lamp"..i)
        local col = Color(colV.x,colV.y,colV.z)
        local state = self:Animate("Lamp1_"..i,self:GetPackedBool("lightsActive"..i) and 1 or 0,0,1,6,false)
        self:ShowHideSmooth("lamp1_"..i,state,col)
        activeLights = activeLights + state
    end
    for i=11,13 do
        local col = self:GetNW2Vector("lampD"..i)
        if self.LightsOverride[i].vec ~= col then
            self.LightsOverride[i].vec = col
            self.LightsOverride[i][4] = Color(col.x,col.y,col.z)
            self:SetLightPower(i, false)
        else
            self:SetLightPower(i, activeLights > 0,activeLights/30)
        end
    end
    self:Animate("brake_line",      self:GetPackedRatio("BLPressure"),0.14, 0.875,  256,2)--,,0.01)
    self:Animate("train_line",      self:GetPackedRatio("TLPressure"),0.14, 0.875,  256,2)--,,0.01)
    self:Animate("brake_cylinder",  self:GetPackedRatio("BCPressure"),0.14, 0.875,  256,2)--,,0.03)
    self:Animate("voltmeter",       self:GetPackedRatio("BatteryVoltage"),0.601, 0.400)
    self:Animate("ampermeter",      0.5+self:GetPackedRatio("BatteryCurrent"),0.604, 0.398)

    local capOpened = self:GetPackedBool("CouchCap")
    self:ShowHide("seats_old_cap_o",capOpened)
    self:ShowHide("seats_old_cap",not capOpened)
    self:HidePanel("couch_cap",capOpened)
    self:HidePanel("couch_cap_o",not capOpened)
    self:HidePanel("PVZ",not capOpened)
    self:ShowHide("otsek_cap_r",not capOpened)
    self:HidePanel("BUV_MPS",not capOpened)
    self:HidePanel("BUV_MVD",not capOpened)
    self:HidePanel("BUV_MALP1",not capOpened)
    self:HidePanel("BUV_MALP2",not capOpened)
    self:HidePanel("BUV_MIV",not capOpened)
    self:HidePanel("BUV_MGR",not capOpened)
    self:HidePanel("BUV_MLUA",not capOpened)
    self:HidePanel("BUV_MUVK1",not capOpened)
    self:HidePanel("BUV_MUVK2",not capOpened)

    --self:Animate("Autodrive",     self:GetPackedBool(132) and 1 or 0, 0,1, 16, false)
    local door1 = self:Animate("door1",self:GetPackedBool("FrontDoor") and 1 or 0,0,0.25,4,0.5)
    local door2 = self:Animate("door2",self:GetPackedBool("RearDoor") and (capOpened and 0.25 or 1) or 0,0,0.25,4,0.5)
    if self.Door1 ~= (door1 > 0) then
        self.Door1 = door1 > 0
        self:PlayOnce("door1","bass",self.Door1 and 1 or 0)
    end
    if self.Door2 ~= (door2 > 0) then
        self.Door2 = door2 > 0
        self:PlayOnce("door2","bass",self.Door2 and 1 or 0)
    end

    self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,1, 3, false)
    self:Animate("FrontTrain",  self:GetNW2Bool("FtI") and 1 or 0,0,1, 3, false)
    self:Animate("RearBrake",   self:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    self:Animate("RearTrain",   self:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)
    self:Animate("ParkingBrake",    self:GetPackedBool("ParkingBrake") and 1 or 0,1,0, 3, false)

    --print(self.ClientProps["a0"])
    -- Main switch
    if self.LastGVValue ~= self:GetPackedBool("GV") then
        self.ResetTime = CurTime()+1.5
        self.LastGVValue = self:GetPackedBool("GV")
    end
    self:Animate("gv_wrench",self.LastGVValue and 1 or 0,0.5,0.9,128,1,false)
    self:ShowHideSmooth("gv_wrench",    CurTime() < self.ResetTime and 1 or 0.1)
    --self:InitializeSounds()
    if not self.DoorStates then self.DoorStates = {} end
    if not self.DoorLoopStates then self.DoorLoopStates = {} end
    for i=0,3 do
        for k=0,1 do
            local st = k==1 and "DoorL" or "DoorR"
            local doorstate = self:GetPackedBool(st)
            local id,sid = st..(i+1),"door"..i.."x"..k
            local state = self:GetPackedRatio(id)
            --print(state,self.DoorStates[state])
            if (state ~= 1 and state ~= 0) ~= self.DoorStates[id] then
                if doorstate and state < 1 or not doorstate and state > 0 then
                else
                    if state > 0 then
                        self:PlayOnce(sid.."o","",1,math.Rand(0.8,1.2))
                    else
                        self:PlayOnce(sid.."c","",1,math.Rand(0.8,1.2))
                    end
                end
                self.DoorStates[id] = (state ~= 1 and state ~= 0)
            end
            if (state ~= 1 and state ~= 0) then
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) + 2*self.DeltaTime,0,1)
            else
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) - 6*self.DeltaTime,0,1)
            end
            self:SetSoundState(sid.."r",self.DoorLoopStates[id],0.8+self.DoorLoopStates[id]*0.2)
            local n_l = "door"..i.."x"..k--.."a"
            --local n_r = "door"..i.."x"..k.."b"
            local dlo = 1
            if self.Anims[n_l] then
                dlo = math.abs(state-(self.Anims[n_l] and self.Anims[n_l].oldival or 0))
                if dlo <= 0 and self.Anims[n_l].oldspeed then dlo = self.Anims[n_l].oldspeed/14 end
            end

            self:Animate(n_l,state,0,1, dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
            --self:Animate(n_r,state,0,1, dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
        end
    end

    local speed = self:GetPackedRatio("Speed", 0)*100
    local ventSpeedAdd = math.Clamp(speed/30,0,1)

    local v1state = self:GetPackedBool("Vent1Work")
    local v2state = self:GetPackedBool("Vent2Work")
    for i=1,8 do
        local rand = self.VentRand[i]
        local vol = self.VentVol[i]
        local even = i%2 == 0
        local work = (even and v1state or not even and v2state)
        local target = math.min(1,(work and 1 or 0)+ventSpeedAdd*rand*0.4)*2
        if self.VentVol[i] < target then
            self.VentVol[i] = math.min(target,vol + dT/1.5*rand)
        elseif self.VentVol[i] > target then
            self.VentVol[i] = math.max(0,vol - dT/8*rand*(vol*0.3))
        end
        self.VentState[i] = (self.VentState[i] + 10*((self.VentVol[i]/2)^3)*dT)%1
        local vol1 = math.max(0,self.VentVol[i]-1)
        local vol2 = math.max(0,(self.VentVol[i-1] or self.VentVol[i+1])-1)
        self:SetSoundState("vent"..i,vol1*(0.7+vol2*0.3),0.5+0.5*vol1+math.Rand(-0.01,0.01))
        if IsValid(self.ClientEnts["vent"..i]) then
            self.ClientEnts["vent"..i]:SetPoseParameter("position",self.VentState[i])
        end
    end

    local dT = self.DeltaTime
    local rollingi = math.min(1,self.TunnelCoeff+math.Clamp((self.StreetCoeff-0.82)/0.3,0,1))
    local rollings = math.max(self.TunnelCoeff*0.6,self.StreetCoeff)
    local speed = self:GetPackedRatio("Speed")*100.0
    local rol5 = math.Clamp(speed/1,0,1)*(1-math.Clamp((speed-3)/8,0,1))
    local rol10 = math.Clamp(speed/12,0,1)*(1-math.Clamp((speed-25)/8,0,1))
    local rol40p = Lerp((speed-25)/12,0.6,1)
    local rol40 = math.Clamp((speed-23)/8,0,1)*(1-math.Clamp((speed-55)/8,0,1))
    local rol40p = Lerp((speed-23)/50,0.6,1)
    local rol70 = math.Clamp((speed-50)/8,0,1)*(1-math.Clamp((speed-72)/5,0,1))
    local rol70p = Lerp(0.8+(speed-65)/25*0.2,0.8,1.2)
    local rol80 = math.Clamp((speed-70)/5,0,1)
    local rol80p = Lerp(0.8+(speed-72)/15*0.2,0.8,1.2)
    self:SetSoundState("rolling_5",math.min(1,rollingi*(1-rollings)+rollings*0.8)*rol5,1)
    self:SetSoundState("rolling_10",rollingi*rol10,1)
    self:SetSoundState("rolling_40",rollingi*rol40,rol40p)
    self:SetSoundState("rolling_70",rollingi*rol70,rol70p)
    self:SetSoundState("rolling_80",rollingi*rol80,rol80p)
--[[
    local rol_motors = math.Clamp((speed-55)/10,0,1) ---ANY IDEAS?? MOTORS BACKGROUND SOUNDS AT HISPEED
    local rol_motorsp = Lerp((speed-72)/25*0.2,0.85,1.1)
    self:SetSoundState("rolling_motors",rol_motors,rol_motorsp) ---ANY IDEAS??--]]

    local rol10 = math.Clamp(speed/15,0,1)*(1-math.Clamp((speed-18)/35,0,1))
    local rol10p = Lerp((speed-15)/14,0.6,0.78)
    local rol40 = math.Clamp((speed-18)/35,0,1)*(1-math.Clamp((speed-55)/40,0,1))
    local rol40p = Lerp((speed-15)/66,0.6,1.3)
    local rol70 = math.Clamp((speed-55)/20,0,1)--*(1-math.Clamp((speed-72)/5,0,1))
    local rol70p = Lerp((speed-55)/27,0.78,1.15)
    --local rol80 = math.Clamp((speed-70)/5,0,1)
    --local rol80p = Lerp(0.8+(speed-72)/15*0.2,0.8,1.2)
    self:SetSoundState("rolling_low"    ,rol10*rollings,rol10p) --15
    self:SetSoundState("rolling_medium2",rol40*rollings,rol40p) --57
    --self:SetSoundState("rolling_medium1",0 or rol40*rollings,rol40p) --57
    self:SetSoundState("rolling_high2"  ,rol70*rollings,rol70p) --70

    self.ReleasedPdT = math.Clamp(self.ReleasedPdT + 2*(-self:GetPackedRatio("BrakeCylinderPressure_dPdT",0)-self.ReleasedPdT)*dT,0,1)
    local release1 = math.Clamp((self.ReleasedPdT-0.1)/0.8,0,1)^2
    self:SetSoundState("release1",release1,1)
    self:SetSoundState("release2",(math.Clamp(0.3-release1,0,0.3)/0.3)*(release1/0.3),1.0)
    local parking_brake = self:GetPackedRatio("ParkingBrakePressure_dPdT",0)
    local parking_brake_abs = math.Clamp(math.abs(parking_brake)-0.3,0,1)
    if self.ParkingBrake1 ~= (parking_brake<1) then
        self.ParkingBrake1 = (parking_brake<1)
        if self.ParkingBrake1 then self:PlayOnce("parking_brake_en","bass",1,1) end
    end
    if self.ParkingBrake2 ~= (parking_brake>-0.8) then
        self.ParkingBrake2 = (parking_brake>-0.8)
        if self.ParkingBrake2 then self:PlayOnce("parking_brake_rel","bass",0.6,1) end
    end
    self:SetSoundState("parking_brake",parking_brake_abs,1)
    self.FrontLeak = math.Clamp(self.FrontLeak + 10*(-self:GetPackedRatio("FrontLeak")-self.FrontLeak)*dT,0,1)
    self.RearLeak = math.Clamp(self.RearLeak + 10*(-self:GetPackedRatio("RearLeak")-self.RearLeak)*dT,0,1)
    self:SetSoundState("front_isolation",self.FrontLeak,0.9+0.2*self.FrontLeak)
    self:SetSoundState("rear_isolation",self.RearLeak,0.9+0.2*self.RearLeak)

    self:SetSoundState("compressor",self:GetPackedBool("Compressor") and 0.6 or 0,1)
    self:SetSoundState("compressor2",self:GetPackedBool("Compressor") and 0.8 or 0,1)

    local state = self:GetPackedRatio("RNState")
    local freq = math.max(1,self:GetNW2Int("RNFreq",0))

    self.TISUVol = math.Clamp(self.TISUVol+(state-self.TISUVol)*dT*8,0,1)
    if freq > 12 then
        self.TISUFreq = 12
    elseif freq > self.TISUFreq then
        self.TISUFreq = math.min(self.TISUFreq+dT/2*12,12)
    elseif freq < self.TISUFreq then
        self.TISUFreq = freq--math.max(self.TISUFreq-dT/2*12,0)
    end
    local fq = 0.25+tbl[math.Round(self.TISUFreq)]*0.75
    self:SetSoundState("tisu",self.TISUVol,fq)--]]

    self:SetSoundState("bpsn",self:GetPackedBool("BBE") and 1 or 0,1.0) --FIXME громкость по другому

    local work = self:GetPackedBool("AnnPlay")
    local buzz = self:GetPackedBool("AnnBuzz") and self:GetNW2Int("AnnouncerBuzz",-1) > 0
    for k in ipairs(self.AnnouncerPositions) do
        self:SetSoundState("announcer_buzz"..k,(buzz and work) and 1 or 0,1)
    end
    for k,v in ipairs(self.AnnouncerPositions) do
        if IsValid(self.Sounds["announcer"..k]) then
            self.Sounds["announcer"..k]:SetVolume(work  and (v[3] or 1)  or 0)
        end
    end
end

function ENT:OnAnnouncer(volume)
    return self:GetPackedBool("AnnPlay") and volume  or 0
end

function ENT:Draw()
    self.BaseClass.Draw(self)
end
function ENT:DrawPost()
end

function ENT:OnButtonPressed(button)
end

function ENT:OnPlay(soundid,location,range,pitch)
    if location == "stop" then
        if IsValid(self.Sounds[soundid]) then
            self.Sounds[soundid]:Pause()
            self.Sounds[soundid]:SetTime(0)
        end
        return
    end
    if soundid == "K1" then
        local id = range > 0 and "k1_on" or "k1_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["k1_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    if soundid == "K2" then
        local id = range > 0 and "k2_on" or "k2_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["k2_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    if soundid == "K3" then
        local id = range > 0 and "k3_on" or "k3_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["k3_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    if soundid == "KMR1" then
        local id = range > 0 and "kmr1_on" or "kmr1_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["kmr1_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    if soundid == "KMR2" then
        local id = range > 0 and "kmr2_on" or "kmr2_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["kmr2_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    if soundid == "brake" then
        self:PlayOnce("brake_f",location,range,pitch)
        self:PlayOnce("brake_b",location,range,pitch)
        return
    end
    if soundid == "QF1" then
        local id = range > 0 and "qf1_on" or "qf1_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["qf1_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    return soundid,location,range,pitch
end
Metrostroi.GenerateClientProps()

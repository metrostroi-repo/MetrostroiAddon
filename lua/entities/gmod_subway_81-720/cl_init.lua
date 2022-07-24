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
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.AutoAnimNames = {}
ENT.ClientSounds = {}
--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false
ENT.ButtonMap["PUU"] = {
    pos = Vector(480.5-0.5,41,-19.4+2.0), --446 -- 14 -- -0,5
    ang = Angle(0,-90,50),
    width = 750,
    height = 135,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "!DoorsClosed",x=45.5, y=30.5, radius=8, tooltip = "Двери закрыты",model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="DoorsClosed",z=-7, color=Color(120,255,50)},
            sprite = {bright=0.4,size=0.25,scale=0.02,vscale=0.02,color=Color(175,250,20),z=-2},
        }},
        {ID = "StandToggle",x=96, y=30.5, radius=15, tooltip = "Стоянка",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-5, ang=180,
            var="Stand",speed=12, vmin=0, vmax=1,
            sndvol = 0.5, snd = function(val) return val and "switch_on" or "switch_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "TickerToggle",x=137.5, y=30.5, radius=15, tooltip = "Бегущая строка",model = {
            model = "models/metrostroi_train/81-720/buttons/b2.mdl",z=6,
            lamp = {model = "models/metrostroi_train/81-720/buttons/l3.mdl",var="TickerLamp",color=Color(200,150,60), anim=true,
            lcolor=Color(200,150,60),lz = 16,lbright=2,lfov=140,lfar=16,lnear=8,lshadows=0},
            var="Ticker",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.03,color=Color(200,150,60),z=0},
        }},
        {ID = "KAHToggle",x=137.5+37.83*2, y=30.5, radius=15, tooltip = "КАХ",model = {
            model = "models/metrostroi_train/81-720/buttons/b5.mdl",z=6,
            lamp = {model = "models/metrostroi_train/81-720/buttons/l3.mdl",var="KAHLamp",color=Color(160,255,220), anim=true,
            lcolor=Color(160,255,220),lz = 10,lbright=2,lfov=155,lfar=16,lnear=8,lshadows=0},
            var="KAH",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.03,color=Color(160,255,220),z=0},
        }},
        {ID = "KAHkToggle",x=137.5+37.83*2-20, y=30.5+10, w=40,h=20, tooltip="Крышка кнопки КАХ\nKAH button cover", model = {
            model = "models/metrostroi_train/81/krishka.mdl", ang = 0, z = 1,
            var="KAHk",speed=8,min=0.43,max=0.68, disable="KAHToggle",
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=70,x=15,y=-45,z=3,var="KAHPl", ID="KAHPl",},
            sndvol = 1, snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
        {ID = "ALSToggle",x=137.5+37.83*3, y=30.5, radius=15, tooltip = "АЛС",model = {
            model = "models/metrostroi_train/81-720/buttons/b6.mdl",z=6,
            lamp = {model = "models/metrostroi_train/81-720/buttons/l3.mdl",var="ALSLamp",color=Color(255,80,100), anim=true,
            lcolor=Color(255,80,100),lz = 10,lbright=2,lfov=155,lfar=16,lnear=8,lshadows=0},
            var="ALS",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.03,color=Color(255,80,100),z=0},
        }},
        {ID = "ALSkToggle",x=137.5+37.83*3-20, y=30.5+10, w=40,h=20, tooltip="Крышка кнопки АЛС\nALS button cover", model = {
            model = "models/metrostroi_train/81/krishka.mdl", ang = 0, z = 1,
            var="ALSk",speed=8,min=0.43,max=0.68, disable="ALSToggle",
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=180-70,x=-5,y=-45,z=3,var="ALSPl", ID="ALSPl",},
            sndvol = 1, snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
        {ID = "FDepotToggle",x=137.5+37.83*4, y=30.5, radius=15, tooltip = "Выезд из депо",model = {
            model = "models/metrostroi_train/81-720/buttons/b4.mdl",z=6,
            var="FDepot",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "!HVoltage",x=137.5+37.83*5, y=30.5, radius=8, tooltip = "Сеть контактная",model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="HVoltage",z=-7, color=Color(255,120,50)},
            sprite = {bright=0.4,size=0.25,scale=0.02,vscale=0.02,color=Color(255,120,50),z=-2},
        }},
        {ID = "PassSchemeToggle",x=137.5+37.83*6, y=30.5, radius=15, tooltip = "Табло наддверное",model = {
            model = "models/metrostroi_train/81-720/buttons/b4.mdl",z=6,
            lamp = {model = "models/metrostroi_train/81-720/buttons/l1.mdl",var="PassSchemeLamp",anim=true,
            lcolor=Color(255,255,255),lz = 16,lbright=2,lfov=140,lfar=16,lnear=8,lshadows=0},
            var="PassScheme",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.03,color=Color(255,255,255),z=0},
        }},
        {ID = "EmergencyCompressorSet",x=138+37.83*7, y=30.5, radius=15, tooltip = "Компрессор резервный",model = {
            model = "models/metrostroi_train/81-720/buttons/b7.mdl",z=7,
            var="EmergencyCompressor",speed=12, vmin=0, vmax=0.9,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EnableBVSet",x=137.5+37.83*8, y=30.5, radius=15, tooltip = "Включение защиты",model = {
            model = "models/metrostroi_train/81-720/buttons/b5.mdl",z=6,
            var="EnableBV",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "DisableBVSet",x=137.5+37.83*9, y=30.5, radius=15, tooltip = "Отключение БВ",model = {
            model = "models/metrostroi_train/81-720/buttons/b6.mdl",z=6,
            var="DisableBV",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "RingSet",x=137.5+37.83*10, y=30.5, radius=15, tooltip = "Передача управления(звонок)",model = {
            model = "models/metrostroi_train/81-720/buttons/b4.mdl",z=6,
            var="Ring",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_Program2Set",x=566.63+36.5*0, y=30.5, radius=15, tooltip = "Программа 2",model = {
            model = "models/metrostroi_train/81-720/buttons/b3.mdl",z=6,--blue
            var="R_Program2",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_AnnouncerToggle",x=566.63+36.5*1, y=30.5, radius=15, tooltip = "Информатор",model = {
            model = "models/metrostroi_train/81-720/buttons/b3.mdl",z=6,--blue
            lamp = {model = "models/metrostroi_train/81-720/buttons/l1.mdl",var="R_AnnouncerLamp",anim=true, color=Color(50,150,200),
            lcolor=Color(50,150,200),lz = 16,lbright=2,lfov=140,lfar=4,lnear=2,lshadows=0},
            var="R_Announcer",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.03,color=Color(50,150,200),z=0},
        }},
        {ID = "R_LineToggle",x=566.63+35.75*2, y=30.5, radius=15, tooltip = "Линия",model = {
            model = "models/metrostroi_train/81-720/buttons/b3.mdl",z=6,--blue
            lamp = {model = "models/metrostroi_train/81-720/buttons/l3.mdl",var="R_LineLamp",anim=true, color=Color(50,150,200),
            lcolor=Color(50,150,200),lz = 16,lbright=2,lfov=140,lfar=4,lnear=2,lshadows=0},
            var="R_Line",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.03,color=Color(50,150,200),z=0},
        }},
        {ID = "R_EmerSet",x=566.63+35.5*3, y=30.5, radius=15, tooltip = "Связь экстренная",model = {
            model = "models/metrostroi_train/81-720/buttons/b3.mdl",z=6,--blue
            var="R_Emer",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_Program1Set",x=566.63+35.2*4, y=30.5, radius=15, tooltip = "Пуск записи",model = {
            model = "models/metrostroi_train/81-720/buttons/b5.mdl",z=6,--blue
            var="R_Program1",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},

        {ID = "EnableBVEmerSet",x=42, y=110, radius=15, tooltip = "Возврат БВ резервный",model = {
            model = "models/metrostroi_train/81-720/button_circle2.mdl",z=3,
            var="EnableBVEmer",speed=12, vmin=0, vmax=0.9,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmergencyControlsToggle",x=566.63+36.5*1, y=90, radius=15, tooltip = "Управление резервное",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2,
            var="EmergencyControls",speed=12, vmin=0, vmax=1, ang=180,
            sndvol = 0.5, snd = function(val) return val and "switch_on" or "switch_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "WiperToggle",x=566.63+35.75*1.5, y=90, radius=15, tooltip = "Стекло-очиститель",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2,
            var="Wiper",speed=12, vmin=0, vmax=1, ang=180,
            sndvol = 0.5, snd = function(val) return val and "switch_on" or "switch_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},

        {ID = "!VDop",x=289, y=76, w=107, h=6, tooltip = "Допустимаяя скорость",tooltipFunc = function(ent)
            if(ent:GetNW2Bool("BISpeedLimitBlink")) then
                return Format(Metrostroi.GetPhrase("Train.Buttons.SpeedLimit"),ent:GetNW2Int("BISpeedLimit"))
                    .." ("..Metrostroi.GetPhrase("Train.Buttons.04")..")" or ""
            elseif ent:GetNW2Int("BISpeedLimit") ~= 100 then
                return Format(Metrostroi.GetPhrase("Train.Buttons.SpeedLimit"),ent:GetNW2Int("BISpeedLimit"))
            end
        end},
        {ID = "!VFact",x=289, y=76+9, w=107, h=6, tooltip = "Фактическая скорость",tooltipFunc = function(ent) return ent:GetNW2Int("BISpeed") ~= -1 and Format(Metrostroi.GetPhrase("Train.Buttons.Speed"),ent:GetNW2Int("BISpeed")) end},
        {ID = "!VPred",x=289, y=76+17, w=107, h=6, tooltip = "Предупредительная скорость",tooltipFunc = function(ent) return ent:GetNW2Int("BISpeedLimitNext") ~= 100 and Format(Metrostroi.GetPhrase("Train.Buttons.SpeedLimitNext"),ent:GetNW2Int("BISpeedLimitNext")) end},

        {ID = "!VFact2",x=403, y=75, w=26, h=28, tooltip = "Допустимаяя скорость",tooltipFunc = function(ent)
            if ent:GetNW2Bool("BISpeedLimitBlink") then
                return Format(Metrostroi.GetPhrase("Train.Buttons.SpeedAll"),ent:GetNW2Int("BISpeed"),ent:GetNW2Int("BISpeedLimit")).." ("..Metrostroi.GetPhrase("Train.Buttons.04")..")" or ""
            elseif ent:GetNW2Int("BISpeed") ~= -1 then
                return Format(Metrostroi.GetPhrase("Train.Buttons.SpeedAll"),ent:GetNW2Int("BISpeed"),ent:GetNW2Int("BISpeedLimit"))
            end
        end},

        {ID = "!Acc",x=436, y=86, w=80, h=6, tooltip = "Ускорение",tooltipFunc = function(ent)
            if ent:GetPackedRatio("BIAccel",0) <= -10 then
                return Metrostroi.GetPhrase("Common.ARS.AO")
            else
                return Format(Metrostroi.GetPhrase("Train.Buttons.Acceleration"),ent:GetPackedRatio("BIAccel",0))
            end
        end},
        {ID = "!Forw",x=525, y=80, w=18, h=10, tooltip = "Движение вперёд"},
        {ID = "!Back",x=525, y=90, w=18, h=10, tooltip = "Движение назад"},
    }
}

ENT.ButtonMap["PUL"] = {
    pos = Vector(473,36,-26.6+1.6), --446 -- 14 -- -0,5
    ang = Angle(0,-90,21.5),
    width = 100,
    height = 280,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "DoorSelectLToggle",x=33, y=79.5, radius=15, tooltip = "Выбор левых дверей",model = {
            model = "models/metrostroi_train/81-720/buttons/b4.mdl",z=-6,
            lamp = {model = "models/metrostroi_train/81-720/buttons/l1.mdl",var="DoorLeftLamp",z=0,anim=true,
            lcolor=Color(255,255,255),lz = 16,lbright=2,lfov=140,lfar=16,lnear=8,lshadows=0},
            var="DoorSelectL",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.03,color=Color(255,255,255),z=0},
        }},
        {ID = "DoorSelectRToggle",x=78.5, y=79.5, radius=15, tooltip = "Выбор правых дверей",model = {
            model = "models/metrostroi_train/81-720/buttons/b4.mdl",z=-6,
            lamp = {model = "models/metrostroi_train/81-720/buttons/l3.mdl",var="DoorRightLamp",z=0,anim=true,
            lcolor=Color(255,255,255),lz = 16,lbright=2,lfov=140,lfar=16,lnear=8,lshadows=0},
            var="DoorSelectR",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.03,color=Color(255,255,255),z=0},
        }},
        {ID = "DoorBlockToggle",x=65, y=126.5, radius=15, tooltip = "Блокировка дверей",model = {
            model = "models/metrostroi_train/81-720/buttons/b6.mdl",z=-6,
            lamp = {model = "models/metrostroi_train/81-720/buttons/l3.mdl",var="DoorBlockLamp",z=0,anim=true,color=Color(255,80,100),
            lcolor=Color(255,80,100),lz = 16,lbright=2,lfov=140,lfar=16,lnear=8,lshadows=0},
            var="DoorBlock",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.03,color=Color(255,80,100),z=0},
        }},
        {ID = "!DoorLeftLamp",x=47.4, y=148.5, radius=8, tooltip = "Работа кнопки левых дверей",model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="DoorLeftLamp",z=-3, color=Color(120,255,50)},
            sprite = {bright=0.4,size=0.25,scale=0.02,vscale=0.02,color=Color(175,250,20),z=-1},
        }},

        {ID = "DoorLeftSet",x=49, y=197, radius=15, tooltip = "Левые двери",model = {
            model = "models/metrostroi_train/81-720/button_circle1.mdl",z=-2, ang=0,
            var="DoorLeft",speed=12, vmin=0, vmax=1,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["PUR"] = {
    pos = Vector(473,11,-26.6+1.6), --446 -- 14 -- -0,5
    ang = Angle(0,-90,21.5),
    width = 210,
    height = 280,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "AccelRateSet",x=13, y=79.5, radius=15, tooltip = "Темп разгона(Режим подъём)",model = {
            model = "models/metrostroi_train/81-720/buttons/b4.mdl",z=-6,
            var="AccelRate",speed=12, vmin=0, vmax=1,
            lamp = {model = "models/metrostroi_train/81-720/buttons/l1.mdl",var="AccelRateLamp",anim=true,
            lcolor=Color(255,255,255),lz = 16,lbright=2,lfov=140,lfar=16,lnear=8,lshadows=0},
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.03,color=Color(255,255,255),z=0},
        }},
        {ID = "EmerBrakeAddSet",x=58.5, y=79.5, radius=15, tooltip = "(резервный) Тормоз",model = {
            model = "models/metrostroi_train/81-720/buttons/b2.mdl",z=-6,
            var="EmerBrakeAdd",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmerBrakeReleaseSet",x=103, y=79.5, radius=15, tooltip = "(резервный) Отпуск",model = {
            model = "models/metrostroi_train/81-720/buttons/b5.mdl",z=-6,
            var="EmerBrakeRelease",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmerBrakeToggle",x=149, y=79.5, radius=15, tooltip = "Тормоз резервный",model = {
            model = "models/metrostroi_train/81-720/buttons/b6.mdl",z=-6,
            lamp = {model = "models/metrostroi_train/81-720/buttons/l3.mdl",var="EmerBrakeWork",z=0,anim=true,color=Color(255,80,100),
            lcolor=Color(255,80,100),lz = 16,lbright=2,lfov=140,lfar=16,lnear=8,lshadows=0},
            var="EmerBrake",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            tooltipFunc = function(ent) return Format("%s%s",ent:GetPackedBool("EmerBrakeWork") and Metrostroi.GetPhrase("Train.Buttons.Active").."," or "",Metrostroi.GetPhrase(ent:GetPackedBool("EmerBrake") and "Train.Buttons.On" or "Train.Buttons.Off")) end,
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.03,color=Color(255,80,100),z=0},
        }},
        {ID = "EmergencyBrakeToggle",x=188, y=79.5, radius=15, tooltip = "Тормоз экстренный",model = {
            model = "models/metrostroi_train/81-720/tumbler2.mdl",z=-2, ang=180,
            var="EmergencyBrake",speed=12, vmin=0, vmax=1,
            sndvol = 0.5, snd = function(val) return val and "switch_on" or "switch_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},

        {ID = "DoorCloseToggle",x=13, y=119, radius=15, tooltip = "Закрытие дверей",model = {
            model = "models/metrostroi_train/81-720/buttons/b5.mdl",z=-6,
            lamp = {model = "models/metrostroi_train/81-720/buttons/l1.mdl",var="DoorCloseLamp",z=0,anim=true,color=Color(80,255,100),
            lcolor=Color(80,255,100),lz = 16,lbright=2,lfov=140,lfar=4,lnear=2,lshadows=0},
            var="DoorClose",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.03,color=Color(80,255,100),z=0},
        }},
        {ID = "AttentionMessageSet",x=58.5, y=119, radius=15, tooltip = "Восприятие сообщения",model = {
            model = "models/metrostroi_train/81-720/buttons/b6.mdl",z=-6,
            var="AttentionMessage",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "AttentionSet",x=103, y=119, radius=15, tooltip = "Бдительность",model = {
            model = "models/metrostroi_train/81-720/buttons/b6.mdl",z=-6,
            var="Attention",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "AttentionBrakeSet",x=149, y=119, radius=15, tooltip = "Восприятие торможения",model = {
            model = "models/metrostroi_train/81-720/buttons/b6.mdl",z=-6,
            var="AttentionBrake",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "HornBSet",x=26, y=196, radius=15, tooltip = "Сигнал",model = {
            model = "models/metrostroi_train/81-720/button_circle1.mdl",z=-2, ang=0,
            var="HornB",speed=12, vmin=0, vmax=1,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "DoorRightSet",x=111, y=196, radius=15, tooltip = "Прав двери",model = {
            model = "models/metrostroi_train/81-720/button_circle1.mdl",z=-2, ang=0,
            var="DoorRight",speed=12, vmin=0, vmax=1,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "!DoorRightLamp",x=108.7, y=143.7, radius=8, tooltip = "Работа кнопки правых дверей",model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="DoorRightLamp",z=-3, color=Color(120,255,50)},
            sprite = {bright=0.4,size=0.25,scale=0.02,vscale=0.02,color=Color(175,250,20),z=-1},
        }},
    }
}
ENT.ButtonMap["RV"] = {
    pos = Vector(473.65,55,-16.65),
    ang = Angle(-1,-90+3,27),
    width = 120,
    height = 250,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "EmerX1Set",x=95, y=53, radius=15, tooltip = "Ход 1 резервный",model = {
            model = "models/metrostroi_train/81-720/button_circle3.mdl",z=3,
            var="EmerX1",speed=12, vmin=0, vmax=0.9,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmerX2Set",x=96, y=125, radius=15, tooltip = "Ход 2 резервный",model = {
            model = "models/metrostroi_train/81-720/button_circle3.mdl",z=3,
            var="EmerX2",speed=12, vmin=0, vmax=0.9,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmerCloseDoorsSet",x=97, y=190, radius=15, tooltip = "Закрытие дверей резервное",model = {
            model = "models/metrostroi_train/81-720/button_circle3.mdl",z=3,
            var="EmerCloseDoors",speed=12, vmin=0, vmax=0.9,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmergencyDoorsToggle",x=60, y=110, radius=15, tooltip = "Двери резервные",model = {
            model = "models/metrostroi_train/81-720/tumbler2.mdl",z=-2,
            var="EmergencyDoors",speed=12, vmin=0, vmax=1, ang=180,
            sndvol = 0.5, snd = function(val) return val and "switch_on" or "switch_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["PneumoHelper1"] = {
    pos = Vector(471,59,24),
    ang = Angle(0,-30,90),
    width = 70,
    height = 76,
    scale = 0.0625,

    buttons = {
        {ID = "!BrakeCylinder",x=35, y=38, radius=38, tooltip = "Тормозной цилиндр",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BCPressure"),ent:GetPackedRatio("BC")*6) end},
    }
}
ENT.ButtonMap["PneumoHelper2"] = {
    pos = Vector(474,58.5,6.5),
    ang = Angle(0,-30,90),
    width = 70,
    height = 76,
    scale = 0.0625,

    buttons = {
        {ID = "!BrakeTrainLine",x=35, y=38, radius=38, tooltip = "Красная - тормозная, чёрная - напорная магистраль",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BLTLPressure"),ent:GetPackedRatio("TL")*16,ent:GetPackedRatio("BL")*16) end},
    }
}
ENT.ButtonMap["VoltHelper1"] = {
    pos = Vector(476,60.5,0.9),
    ang = Angle(0,-39,90),
    width = 60,
    height = 60,
    scale = 0.0625,

    buttons = {
        {ID = "!Battery",x=0, y=0, w=60, h=60, tooltip = "Вольтметр бортовой сети(батарея)",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BatteryVoltage"),ent:GetPackedRatio("LV")*150) end},
    }
}
ENT.ButtonMap["VoltHelper2"] = {
    pos = Vector(476,60.5,-5),
    ang = Angle(0,-43,90),
    width = 60,
    height = 190,
    scale = 0.0625,

    buttons = {
        {ID = "!HV",x=0, y=0, w=60, h=60, tooltip = "Киловольтметр высокого напряжения(контактный рельс)",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesVoltage"),ent:GetPackedRatio("HV")*1000) end},
        {ID = "!I1_3",x=0, y=65, w=60, h=60, tooltip = "Ток 1-й группы тяговых двигателей",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesCurrent"),ent:GetPackedRatio("I13")*1000-500) end},
        {ID = "!I2_4",x=0, y=130, w=60, h=60, tooltip = "Ток 2-й группы тяговых двигателей",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesCurrent"),ent:GetPackedRatio("I24")*1000-500) end},
    }
}
ENT.ButtonMap["ASNP"] = {
    pos = Vector(409.4,-10.3,44), --446 -- 14 -- -0,5
    ang = Angle(0,92,90),
    width = 180,
    height = 100,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "R_ASNPMenuSet",x=28, y=90, radius=8, tooltip = "АСНП: Меню",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",
            var="R_ASNPMenu",speed=12, vmin=0, vmax=0.9,
            sndvol = 0.5,snd = function(val) return val and "pnm_button1_on" or "pnm_button1_off" end,
            sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "R_ASNPUpSet",x=150, y=38-8, radius=8, tooltip = "АСНП: Вверх",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",
            var="R_ASNPUp",speed=12, vmin=0, vmax=0.9,
            sndvol = 0.5,snd = function(val) return val and "pnm_button1_on" or "pnm_button2_off" end,
            sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "R_ASNPDownSet",x=150, y=38+8, radius=8, tooltip = "АСНП: Вниз",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",
            var="R_ASNPDown",speed=12, vmin=0, vmax=0.9,
            sndvol = 0.5,snd = function(val) return val and "pnm_button2_on" or "pnm_button1_off" end,
            sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "R_ASNPOnToggle",x=20, y=38, radius=8, tooltip = "АСНП: Включение",model = {
            model = "models/metrostroi_train/81-720/tumbler2.mdl", ang=0,
            var="R_ASNPOn",speed=12, vmin=1, vmax=0,
            sndvol = 0.5,snd = function(val) return val and "pnm_on" or "pnm_off" end,
            sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["ASNPScreen"] = {
    pos = Vector(409.0,-8.3,42.4), --446 -- 14 -- -0,5
    ang = Angle(0,92,90),
    width = 512,
    height = 128,
    scale = 0.025/2,
    hide=0.8,
}
ENT.ButtonMap["IGLAButtons"] = {
    pos = Vector(409.7,35.6,26.45), --446 -- 14 -- -0,5
    ang = Angle(0,83.3,90),
    width = 87,
    height = 70,
    scale = 0.0701,
    hideseat=0.2,
    buttons = {
        {ID = "IGLA1USet",x=11, y=39, w=12, h=7, tooltip="ИГЛА: Первая кнопка вверх"},
        {ID = "IGLA1Set",x=11, y=46, w=12, h=7, tooltip="ИГЛА: Первая кнопка"},
        {ID = "IGLA1DSet",x=11, y=53, w=12, h=7, tooltip="ИГЛА: Первая кнопка вниз"},
        {ID = "IGLA2USet",x=65, y=39, w=12, h=7, tooltip="ИГЛА: Вторая кнопка вверх"},
        {ID = "IGLA2Set",x=65, y=46, w=12, h=7, tooltip="ИГЛА: Вторая кнопка"},
        {ID = "IGLA2DSet",x=65, y=53, w=12, h=7, tooltip="ИГЛА: Вторая кнопка вниз"},
        {ID = "!IGLASR",x=17.9, y=10.5, radius=3, tooltip="ИГЛА: SR", model = {
            lamp = {speed=16,model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl", var="IGLASR",color=Color(175,250,20),z=-3.5},
            sprite = {bright=0.4,size=0.25,scale=0.02,vscale=0.02,color=Color(175,250,20),z=-1},
        }},
        {ID = "!IGLARX",x=27.5, y=10.5, radius=3, tooltip="ИГЛА: RX", model = {
            lamp = {speed=16,model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl", var="IGLARX",color=Color(255,56,30),z=-3.5},
            sprite = {bright=0.4,size=0.25,scale=0.02,vscale=0.02,color=Color(255,56,30),z=-1},
        }},
        {ID = "!IGLAErr",x=40.5, y=10.5, radius=3, tooltip="ИГЛА: Отказ", model = {
            lamp = {speed=16,model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl", var="IGLAErr",color=Color(255,168,0),z=-3.5},
            sprite = {bright=0.4,size=0.25,scale=0.02,vscale=0.02,color=Color(255,168,0),z=-1},
        }},
        {ID = "!IGLAOSP",x=50, y=10.5, radius=3, tooltip="ИГЛА: ОСП", model = {
            lamp = {speed=16,model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl", var="IGLAOSP",color=Color(175,250,20),z=-3.5},
            sprite = {bright=0.4,size=0.25,scale=0.02,vscale=0.02,color=Color(175,250,20),z=-1},
        }},
        {ID = "!IGLAPI",x=59.5, y=10.5, radius=3, tooltip="ИГЛА: ПИ", model = {
            lamp = {speed=16,model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl", var="IGLAPI",color=Color(255,56,30),z=-3.5},
            sprite = {bright=0.4,size=0.25,scale=0.02,vscale=0.02,color=Color(255,56,30),z=-1},
        }},
        {ID = "!IGLAOff",x=69, y=10.5, radius=3, tooltip="ИГЛА: Откл", model = {
            lamp = {speed=16,model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl", var="IGLAOff",color=Color(255,56,30),z=-3.5},
            sprite = {bright=0.4,size=0.25,scale=0.02,vscale=0.02,color=Color(255,56,30),z=-1},
        }},
    }
}
--color=Color(175,250,20) green
--color=Color(255,56,30)  red
--color=Color(255,168,000) yellow
ENT.ButtonMap["IGLA"] = {
    pos = Vector(409.75,36.5,24.7), --446 -- 14 -- -0,5
    ang = Angle(0,83.3,90),
    width = 512,
    height = 128,
    scale = 0.025/2.96,
    hide=0.8,
}
ENT.ButtonMap["Tickers"] = {
    pos = Vector(-460.5,-31.5,54.8), --446 -- 14 -- -0,5
    ang = Angle(0,90,90),
    width = 852,
    height = 64,
    scale = 0.074,
    hide=true,
    hideseat=1,
}
ENT.ButtonMap["BackVent"] = {
    pos = Vector(407.5,20,27.6), --446 -- 14 -- -0,5
    ang = Angle(0,83,90),
    width = 400,
    height = 150,
    scale = 0.0625,
    hide=0.8,

    buttons = {
    {ID = "!VentCondMode",x=173, y=33, radius=0, model = {
        model = "models/metrostroi_train/81-720/rc_rotator1.mdl",z=10,ang=-91,
        sndvol = 0.8, snd = function(val) return val and "switch_batt_on" or "switch_batt_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        getfunc = function(ent) return ent:GetPackedRatio("VentCondMode") end,var="VentCondMode",
        speed=4, min=0.76,max=0.0
    }},
    {ID = "VentCondMode-",x=143,y=13,w=30,h=40,tooltip="Режим работы вентилятора: +",states={"Train.Buttons.Vent","Train.Buttons.Off","Train.Buttons.Cooling","Train.Buttons.Heating"},varTooltip = function(ent) return ent:GetPackedRatio("VentCondMode") end,},
    {ID = "VentCondMode+",x=173,y=13,w=30,h=40,tooltip="Режим работы вентилятора: -",states={"Train.Buttons.Vent","Train.Buttons.Off","Train.Buttons.Cooling","Train.Buttons.Heating"},varTooltip = function(ent) return ent:GetPackedRatio("VentCondMode") end,},
    {ID = "!VentHeatMode",x=80, y=60.5, radius=0,model = {
        model = "models/metrostroi_train/81-720/rc_rotator1.mdl",z=10,ang=-91,
        sndvol = 0.8, snd = function(val) return val and "switch_batt_on" or "switch_batt_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        --getfunc = function(ent) return ent:GetPackedRatio("VentHeatMode") end,
        var="VentHeatMode",
        speed=4, min=0.25,max=0.75
    }},
    {ID = "VentHeatMode+",x=50,y=40.5,w=30,h=40,tooltip="+",var="VentHeatMode"},
    {ID = "VentHeatMode-",x=80,y=40.5,w=30,h=40,tooltip="-",var="VentHeatMode"},
    {ID = "!VentStrengthMode",x=173, y=108, radius=0, model = {
        model = "models/metrostroi_train/81-720/rc_rotator1.mdl",z=10,ang=-91,
        sndvol = 0.8, snd = function(val) return val and "switch_batt_on" or "switch_batt_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        getfunc = function(ent) return ent:GetPackedRatio("VentStrengthMode") end,var="VentStrengthMode",
        speed=4, min=0.76,max=0.0
    }},
    {ID = "VentStrengthMode-",x=143,y=88,w=30,h=40,tooltip="Сила вентилятора: +",states={"Train.Buttons.Low","Train.Buttons.Low","Train.Buttons.Off","Train.Buttons.High"},varTooltip = function(ent) return ent:GetPackedRatio("VentStrengthMode") end,},
    {ID = "VentStrengthMode+",x=173,y=88,w=30,h=40,tooltip="Сила вентилятора: -",states={"Train.Buttons.Low","Train.Buttons.Low","Train.Buttons.Off","Train.Buttons.High"},varTooltip = function(ent) return ent:GetPackedRatio("VentStrengthMode") end,},
    }
}

ENT.ButtonMap["BackPPZ"] = {
    pos = Vector(407.5,20,12.6), --446 -- 14 -- -0,5
    ang = Angle(0,83,90),
    width = 400,
    height = 310,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "SF1Toggle",x=61.5+0*28.8, y=73, w=20,h=40, tooltip = "SF1: Питание общее",},
        {ID = "SF2Toggle",x=61.5+1*28.8, y=73, w=20,h=40, tooltip = "SF2: Управление основное",},
        {ID = "SF3Toggle",x=61.5+2*28.8, y=73, w=20,h=40, tooltip = "SF3: Управление резервное",},
        {ID = "SF4Toggle",x=61.5+3*28.8, y=73, w=20,h=40, tooltip = "SF4: БАРС",},
        {ID = "SF5Toggle",x=61.5+4*28.8, y=73, w=20,h=40, tooltip = "SF5: БУП",},
        {ID = "SF6Toggle",x=61.5+5*28.8, y=73, w=20,h=40, tooltip = "SF6: БЦКУ",},
        {ID = "SF7Toggle",x=61.5+6*28.8, y=73, w=20,h=40, tooltip = "SF7: ППО",},
        {ID = "SF8Toggle",x=61.5+7*28.8, y=73, w=20,h=40, tooltip = "SF8: Оповещение",},
        {ID = "SF9Toggle",x=61.5+8*28.8, y=73, w=20,h=40, tooltip = "SF9: Радиосвязь",},
        {ID = "SF10Toggle",x=61.5+9*28.8, y=73, w=20,h=40, tooltip = "SF10: Ориентация вагона",},
        {ID = "SF11Toggle",x=61.5+10*28.8, y=73, w=20,h=40, tooltip = "SF11: Направление движения"},

        {ID = "SF12Toggle",x=61.5+0*28.8, y=224.5, w=20,h=40, tooltip = "SF12: Фары 1-й группы",},
        {ID = "SF13Toggle",x=61.5+1*28.8, y=224.5, w=20,h=40, tooltip = "SF13: Фары 2-й группы",},
        {ID = "SF14Toggle",x=61.5+2*28.8, y=224.5, w=20,h=40, tooltip = "SF14: Огни габаритные",},
        {ID = "SF15Toggle",x=61.5+3*28.8, y=224.5, w=20,h=40, tooltip = "SF15: Освещение кабины",},
        {ID = "SF16Toggle",x=61.5+4*28.8, y=224.5, w=20,h=40, tooltip = "SF16: Отопление",},
        {ID = "SF17Toggle",x=61.5+5*28.8, y=224.5, w=20,h=40, tooltip = "SF17: Кондиционер кабины",},
        {ID = "SF18Toggle",x=61.5+6*28.8, y=224.5, w=20,h=40, tooltip = "SF18: Гребнесмазыватель",},
        {ID = "SF19Toggle",x=61.5+7*28.8, y=224.5, w=20,h=40, tooltip = "SF19: Питание КРМ основное",},
        {ID = "SF20Toggle",x=61.5+8*28.8, y=224.5, w=20,h=40, tooltip = "SF20: Питание КРМ резервное",},
        {ID = "SF21Toggle",x=61.5+9*28.8, y=224.5, w=20,h=40, tooltip = "SF21: Двери открытие",},
        {ID = "SF22Toggle",x=61.5+10*28.8, y=224.5, w=20,h=40, tooltip = "SF22: Двери закрытие"},
    }
}

for k,buttbl in ipairs(ENT.ButtonMap["BackPPZ"].buttons) do
    buttbl.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",z=-16, ang=-90,
        var=buttbl.ID:Replace("Toggle",""),speed=9, vmin=0,vmax=1,
        sndvol = 0.8, snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
    }
end
ENT.ButtonMap["PVZ"] = {
    pos = Vector(383.4,52,5), --446 -- 14 -- -0,5
    ang = Angle(0,0,92),
    width = 330,
    height = 350,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "SFV1Toggle",x=0*30, y=0, w=30,h=50, tooltip = "SF1: Питание цепей управления вагона",},
        {ID = "SFV2Toggle",x=1*30, y=0, w=30,h=50, tooltip = "SF2: Питание БУВ",},
        {ID = "SFV3Toggle",x=2*30, y=0, w=30,h=50, tooltip = "SF3: Питание БУТП",},
        {ID = "SFV4Toggle",x=3*30, y=0, w=30,h=50, tooltip = "SF4: БУТП Управление",},
        {ID = "SFV5Toggle",x=4*30, y=0, w=30,h=50, tooltip = "SF5: БУТП Управление резервное",},
        {ID = "SFV6Toggle",x=5*30, y=0, w=30,h=50, tooltip = "SF6: БУТП Питание",},
        {ID = "SFV7Toggle",x=6*30, y=0, w=30,h=50, tooltip = "SF7: ББЭ",},
        {ID = "SFV8Toggle",x=7*30, y=0, w=30,h=50, tooltip = "SF8: БВ управление",},
        {ID = "SFV9Toggle",x=8*30, y=0, w=30,h=50, tooltip = "SF9: БВ питание",},
        {ID = "SFV10Toggle",x=9*30, y=0, w=30,h=50, tooltip = "SF10: ППО",},
        {ID = "SFV11Toggle",x=10*30, y=0, w=30,h=50, tooltip = "SF11: Мотор-компрессор"},

        {ID = "SFV12Toggle",x=0*30, y=150, w=30,h=50, tooltip = "SF12: Двери закрытие",},
        {ID = "SFV13Toggle",x=1*30, y=150, w=30,h=50, tooltip = "SF13: Двери открытие левых",},
        {ID = "SFV14Toggle",x=2*30, y=150, w=30,h=50, tooltip = "SF14: Двери открытие правых",},
        {ID = "SFV15Toggle",x=3*30, y=150, w=30,h=50, tooltip = "SF15: Двери торцевые",},
        {ID = "SFV16Toggle",x=4*30, y=150, w=30,h=50, tooltip = "SF16: Оповещение",},
        {ID = "SFV17Toggle",x=5*30, y=150, w=30,h=50, tooltip = "SF17: Экстренная связь",},
        {ID = "SFV18Toggle",x=6*30, y=150, w=30,h=50, tooltip = "SF18: Резерв",},
        {ID = "SFV19Toggle",x=7*30, y=150, w=30,h=50, tooltip = "SF19: Освещение салона питание",},
        {ID = "SFV20Toggle",x=8*30, y=150, w=30,h=50, tooltip = "SF20: Освещение салона аварийное",},
        {ID = "SFV21Toggle",x=9*30, y=150, w=30,h=50, tooltip = "SF21: Датчик скорости",},
        {ID = "SFV22Toggle",x=10*30, y=150, w=30,h=50, tooltip = "SF22: Тормоз стояночный"},

        {ID = "SFV23Toggle",x=0*30, y=300, w=30,h=50, tooltip = "SF23: Вентиляция управление 1-я группа",},
        {ID = "SFV24Toggle",x=1*30, y=300, w=30,h=50, tooltip = "SF24: Вентиляция управление 2-я группа",},
        {ID = "SFV25Toggle",x=2*30, y=300, w=30,h=50, tooltip = "SF25: Вентиляция питание 1-я группа",},
        {ID = "SFV26Toggle",x=3*30, y=300, w=30,h=50, tooltip = "SF26: Вентиляция питание 2-я группа",},
        {ID = "SFV27Toggle",x=4*30, y=300, w=30,h=50, tooltip = "SF27: Питание возбудителя FIXME",},
        {ID = "SFV28Toggle",x=5*30, y=300, w=30,h=50, tooltip = "SF28: Питание ЗКК FIXME",},
        {ID = "SFV29Toggle",x=6*30, y=300, w=30,h=50, tooltip = "SF29: Токоприёмники",},
        {ID = "SFV30Toggle",x=7*30, y=300, w=30,h=50, tooltip = "SF30: Табло",},
        {ID = "SFV31Toggle",x=8*30, y=300, w=30,h=50, tooltip = "SF31: Резерв",},
        {ID = "SFV32Toggle",x=9*30, y=300, w=30,h=50, tooltip = "SF32: Резерв",},
        {ID = "SFV33Toggle",x=10*30, y=300, w=30,h=50, tooltip = "SF33: Резерв"},
    }
}

for k,buttbl in ipairs(ENT.ButtonMap["PVZ"].buttons) do
    buttbl.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",z=-16, ang=-90,
        var=buttbl.ID:Replace("Toggle",""),speed=9, vmin=0,vmax=1,
        sndvol = 0.8, snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
    }
end

ENT.ButtonMap["BackDown"] = {
    pos = Vector(407.65,20,-13), --446 -- 14 -- -0,5
    ang = Angle(0,83.5,90),
    width = 400,
    height = 330,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "Pant1Toggle",x=85, y=62, radius=12, tooltip = "Отжатие токоприёмников 1-й группы",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=0, ang=180,
            var="Pant1",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Pant2Toggle",x=105, y=62, radius=12, tooltip = "Отжатие токоприёмников 2-й группы",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=0, ang=180,
            var="Pant2",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vent1Toggle",x=148, y=62, radius=12, tooltip = "Вентиляция 1-я группа",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=0, ang=180,
            var="Vent1",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vent2Toggle",x=168, y=62, radius=12, tooltip = "Вентиляция 2-я группа",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=0, ang=180,
            var="Vent2",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VentToggle",x=204, y=62, radius=12, model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=0, ang=180,
            var="Vent",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "PassLightToggle",x=240, y=62, radius=12, tooltip = "Освещение салона",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=0, ang=180,
            var="PassLight",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CabLightToggle",x=260, y=62, radius=12, tooltip = "Освещение кабины",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=0, ang=180,
            var="CabLight",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Headlights1Toggle",x=315, y=62, radius=12, tooltip = "Фары 1-я группа",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=0, ang=180,
            var="Headlights1",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Headlights2Toggle",x=335, y=62, radius=12, tooltip = "Фары 2-я группа",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=0, ang=180,
            var="Headlights2",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},

        {ID = "ParkingBrakeToggle",x=81, y=118, radius=12, tooltip = "Стояночный тормоз",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=0, ang=180,
            var="ParkingBrake",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "TorecDoorsToggle",x=111, y=118, radius=12, tooltip = "Двери торцевые",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=0, ang=180,
            var="TorecDoors",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "BBERToggle",x=142, y=118, radius=12, tooltip = "ББЭ Резервнео включение",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=0, ang=180,
            var="BBER",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "BBEToggle",x=173, y=118, radius=12, tooltip = "ББЭ",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=0, ang=180,
            var="BBE",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CompressorToggle",x=204, y=118, radius=12, tooltip = "Компрессор",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=0, ang=180,
            var="Compressor",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CabLightStrengthToggle",x=235, y=118, radius=12, tooltip = "Сила освещения кабины",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=0, ang=180,
            var="CabLightStrength",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            states = {"Train.Buttons.Low","Train.Buttons.High"}
        }},
        {ID = "AppLights1Toggle",x=308, y=118, radius=12, tooltip = "Освещение аппаратного отсека",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=0, ang=180,
            var="AppLights1",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "AppLights2Toggle",x=341, y=118, radius=12, model = { --FIXME WHAT IS THIS?
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=0, ang=180,
            var="AppLights2",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},


        {ID = "!BARSBlock",x=214, y=211, radius=0, model = {
            model = "models/metrostroi_train/81-720/rc_rotator1.mdl",z=12,
            getfunc = function(ent) return ent:GetPackedRatio("BARSBlock") end,var="BARSBlock",
            plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=-90,x=0,y=40,z=-5,var="BARSBlockPl", ID="BARSBlockPl",},
            speed=6, min=0.5,max=0.15,
            sndvol = 1, snd = function(_,val) return val==3 and "switch_batt_on" or val == 0 and "switch_batt_off" or "switch_batt" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "BARSBlock-",x=184,y=201,w=30,h=40,tooltip="Блокировка неисправных БАРСов: -",model={
            plomb = {var="BARSBlockPl", ID="BARSBlockPl", },
            varTooltip = function(ent) return ent:GetPackedRatio("BARSBlock") end,states = {"Train.Buttons.Off","Train.Buttons.BARS1","Train.Buttons.BARS2","Train.Buttons.BARS12"}
        }},
        {ID = "BARSBlock+",x=204,y=201,w=30,h=40,tooltip="Блокировка неисправных БАРСов: +", model={
            plomb = {var="BARSBlockPl", ID="BARSBlockPl", },
            varTooltip = function(ent) return ent:GetPackedRatio("BARSBlock") end,states = {"Train.Buttons.Off","Train.Buttons.BARS1","Train.Buttons.BARS2","Train.Buttons.BARS12"}
        }},
        {ID = "BatteryToggle",x=334, y=211, radius=20, tooltip = "Выключатель батареи",model = {
            model = "models/metrostroi_train/81-720/rc_rotator1.mdl",z=12, ang=90,
            var="Battery",speed=2,
            sndvol = 1, snd = function(val) return val and "switch_batt_on" or "switch_batt_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            vmin=0.15, vmax=0
        }},

        {ID = "ALSFreqToggle",x=334, y=295, radius=12, tooltip = "Дешифратор АЛС",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=3, ang=90,
            var="ALSFreq",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Freq1/5","Train.Buttons.Freq2/6"}
        }},
    }
}
ENT.ButtonMap["VityazButtons"] = {
    pos = Vector(468.1,-10.25,-32.3),
    ang = Angle(0,-89,36),
    width = 110,
    height = 80,
    scale = 0.0625,
    hideseat=0.2,
    buttons = {
        {ID = "VityazF1Set",x=1, y=0, w=20,h=20, tooltip = "Витязь: F1",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_f1.mdl",z=0, ang=0,var="VityazF1",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz3_press" or "button_vityaz3_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazF2Set",x=1, y=20, w=20,h=20, tooltip = "Витязь: Следующая страница",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_f2.mdl",z=0, ang=0,var="VityazF2",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz2_press" or "button_vityaz2_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazF3Set",x=1, y=40, w=20,h=20, tooltip = "Витязь: Предыдущая страница",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_f3.mdl",z=0, ang=0,var="VityazF3",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazF4Set",x=1, y=60, w=20,h=20, tooltip = "Витязь: Штатный режим",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_f4.mdl",z=0, ang=0,var="VityazF4",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz4_press" or "button_vityaz4_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},

        {ID = "Vityaz1Set",x=30, y=0, w=20,h=20, tooltip = "Витязь: 1",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_1.mdl",z=0, ang=0, var="Vityaz1",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz4Set",x=30, y=20, w=20,h=20, tooltip = "Витязь: 4",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_4.mdl",z=0, ang=0, var="Vityaz4",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz2_press" or "button_vityaz2_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz7Set",x=30, y=40, w=20,h=20, tooltip = "Витязь: 7",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_7.mdl",z=0, ang=0, var="Vityaz7",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz2Set",x=47, y=0, w=20,h=20, tooltip = "Витязь: 2",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_2.mdl",z=0, ang=0, var="Vityaz2",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz3_press" or "button_vityaz3_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz5Set",x=47, y=20, w=20,h=20, tooltip = "Витязь: 5",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_5.mdl",z=0, ang=0, var="Vityaz5",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz8Set",x=47, y=40, w=20,h=20, tooltip = "Витязь: 8",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_8.mdl",z=0, ang=0, var="Vityaz8",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz4_press" or "button_vityaz4_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz0Set",x=47, y=60, w=20,h=20, tooltip = "Витязь: 0",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_0.mdl",z=0, ang=0, var="Vityaz0",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz2_press" or "button_vityaz2_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz3Set",x=64, y=0, w=20,h=20, tooltip = "Витязь: 3",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_3.mdl",z=0, ang=0, var="Vityaz3",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz3_press" or "button_vityaz3_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz6Set",x=64, y=20, w=20,h=20, tooltip = "Витязь: 6",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_6.mdl",z=0, ang=0, var="Vityaz6",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz4_press" or "button_vityaz4_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz9Set",x=64, y=40, w=20,h=20, tooltip = "Витязь: 9",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_9.mdl",z=0, ang=0, var="Vityaz9",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazF5Set",x=64, y=60, w=20,h=20, tooltip = "Витязь: ЗВ",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_f5.mdl",z=0, ang=0, var="VityazF5",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz3_press" or "button_vityaz3_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazF6Set",x=91, y=0, w=20,h=20, tooltip = "Витязь: Вверх\\Скорость",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_f6.mdl",z=0, ang=0, var="VityazF6",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz2_press" or "button_vityaz2_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazF7Set",x=91, y=20, w=20,h=20, tooltip = "Витязь: Вниз\\Токи",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_f7.mdl",z=0, ang=0, var="VityazF7",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz4_press" or "button_vityaz4_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazF8Set",x=91, y=40, w=20,h=20, tooltip = "Витязь: Ввод\\Вагонное оборудование",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_f8.mdl",z=0, ang=0, var="VityazF8",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazF9Set",x=91, y=60, w=20,h=20, tooltip = "Витязь: Выбор\\Управление вагонным оборудованием",model = {
            model = "models/metrostroi_train/81-720/vyitaz/v_f9.mdl",z=0, ang=0, var="VityazF9",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz2_press" or "button_vityaz2_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["BTO"] = {
    pos = Vector(445,-21,-61), --446 -- 14 -- -0,5
    ang = Angle(0,0,0),
    width = 224,
    height = 50,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "K29Toggle", x=24,  y=26, radius=25, tooltip="КРМШ", model = {
            model = "models/metrostroi_train/81-720/720_cran.mdl", ang=-90,
            var="K29",speed=4, max=0.28,
            states={"Train.Buttons.Closed","Train.Buttons.Opened"}
        }},
        {ID = "UAVAToggle", x=24+200,  y=26, radius=25, tooltip="УАВА", model = {
            model = "models/metrostroi_train/81-720/720_cran.mdl", ang=-90,
            plomb = {var="UAVAPl", ID="UAVAPl", },
            var="UAVA",speed=4, max=0.28
        }},
    }
}

ENT.ButtonMap["FrontPneumatic"] = {
    pos = Vector(470-9+38,-45.0+13,-58.0+5-6),
    ang = Angle(0,90,90),
    width = 600,
    height = 100,
    scale = 0.1,

    buttons = {
        {ID = "FrontBrakeLineIsolationToggle",x=000, y=0, w=300, h=100, tooltip="",var="FbI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
        {ID = "FrontTrainLineIsolationToggle",x=300, y=0, w=300, h=100, tooltip="",var="FtI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
    }
}
ENT.ClientProps["FrontBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(449+48, -23, -69),
    ang = Angle(-15,-90,0),
    hide = 2,30
}
ENT.ClientProps["FrontTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(449+48, 23, -69),
    ang = Angle( 15,-90,0),
    hide = 2,
}
ENT.ClientSounds["FrontBrakeLineIsolation"] = {{"FrontBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["FrontTrainLineIsolation"] = {{"FrontTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}


ENT.ButtonMap["RearPneumatic"] = {
    pos = Vector(-473-0.5+4,42,-58.0+5-6),
    ang = Angle(0,270,90),
    width = 800,
    height = 100,
    scale = 0.1,

    buttons = {
        {ID = "RearTrainLineIsolationToggle",x=400, y=0, w=400, h=100, tooltip="",var="RtI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
        {ID = "RearBrakeLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip="",var="RbI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
    }
}
ENT.ClientProps["RearTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(-450-18, -30, -69),
    ang = Angle(-15,90,0),
    hide = 2,
}
ENT.ClientProps["RearBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(-450-18, 30, -69),
    ang = Angle( 15,90,0),
    hide = 2,
}
ENT.ClientSounds["RearBrakeLineIsolation"] = {{"RearBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["RearTrainLineIsolation"] = {{"RearTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}

ENT.ButtonMap["PassengerDoor"] = {
    pos = Vector(380,-55,40), --28
    ang = Angle(0,90,90),
    width = 730,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=730,h=2000, tooltip="Дверь в кабину машиниста из салона\nPass door", model = {
            var="PassengerDoor",sndid="door_cab_m",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
ENT.ButtonMap["PassengerDoor2"] = {
    pos = Vector(380,-18.5,40), --28
    ang = Angle(0,-90,90),
    width = 730,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=730,h=2000, tooltip="Дверь в кабину машиниста из салона\nPass door"},
    }
}

if not ENT.ClientSounds["OtsekDoor"] then ENT.ClientSounds["OtsekDoor"] = {} end --FIXME перенести нахуй в шеерд
table.insert(ENT.ClientSounds["OtsekDoor"],{"door_cab_o",function(ent,var) return var>0 and "door_cab_open" or "door_cab_close" end,1,1,90,1e3,Angle(-90,0,0)})
ENT.ButtonMap["CabinDoorL"] = {
    pos = Vector(420,64,40),
    ang = Angle(0,0,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoorLeft",x=0,y=0,w=642,h=2000, tooltip="Дверь в кабину машиниста\nCabin door", model = {
            var="CabinDoorLeft",sndid="door_cab_l",
            sndvol = 1, snd = function(_,val) return val == 1 and "door_cab_open" or val == 2 and "door_cab_roll" or val == 0 and "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
ENT.ButtonMap["CabinDoorR"] = {
    pos = Vector(451,-64,40),
    ang = Angle(0,180,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoorRight",x=0,y=0,w=642,h=2000, tooltip="Дверь в кабину машиниста\nCabin door", model = {
            var="CabinDoorRight",sndid="door_cab_r",
            sndvol = 1, snd = function(_,val) return val == 1 and "door_cab_open" or val == 2 and "door_cab_roll" or val == 0 and "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
ENT.ButtonMap["RearDoor"] = {
    pos = Vector(-465,16,42),
    ang = Angle(0,-90,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=642,h=2000, tooltip="Передняя дверь\nFront door", model = {
            var="RearDoor",sndid="door_cab_t",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
ENT.ButtonMap["RearDoor1"] = {
    pos = Vector(-465,16-32,42),
    ang = Angle(0,90,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=642,h=2000, tooltip="Передняя дверь\nFront door"},
    }
}


for i=0,3 do
    ENT.ClientProps["TrainNumberL"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(57+i*6.6-4*6.6/2,66.3,18),
        ang = Angle(0,180,-5),
        skin=0,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end
for i=0,3 do
    ENT.ClientProps["TrainNumberR"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(61+i*6.6-4*6.6/2,-66.3,18),
        ang = Angle(0,0,-5),
        skin=0,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end


ENT.ClientProps["salon"] = {
    model = "models/metrostroi_train/81-720/720_salon.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["salon_glass"] = {
    model = "models/metrostroi_train/81-720/glass_red.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["RedLights"] = {
    model = "models/metrostroi_train/81-720/720_redlights.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["HeadLights"] = {
    model = "models/metrostroi_train/81-720/720_headights.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["HeadLights_full"] = {
    model = "models/metrostroi_train/81-720/720_headights2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["route"] = {
    model = "models/metrostroi_train/81-720/720_label.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
    callback = function(ent)
        ent.LastStation.Reloaded = false
    end,
}
ENT.ButtonMap["LastStation"] = {
    pos = Vector(474,-15.6,46.7),
    ang = Angle(0,90,90),
    width = 800,
    height = 205,
    scale = 0.0625,
    buttons = {
        {ID = "LastStation-",x=000,y=0,w=400,h=205, tooltip=""},
        {ID = "LastStation+",x=400,y=0,w=400,h=205, tooltip=""},
    }
}
ENT.ButtonMap["Route"] = {
    pos = Vector(474,37,46.7),
    ang = Angle(0,90,90),
    width = 200,
    height = 205,
    scale = 0.0625,
    buttons = {
        {ID = "RouteNumber1+",x=0  ,y=0,w=100,h=100,tooltip=""},
        {ID = "RouteNumber2+",x=100,y=0,w=100,h=100,tooltip=""},
        {ID = "RouteNumber1-",x=0  ,y=100,w=100,h=100,tooltip=""},
        {ID = "RouteNumber2-",x=100,y=100,w=100,h=100,tooltip=""},
    }
}
ENT.ClientProps["route1"] = {
    model = "models/metrostroi_train/81-720/route/route1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
}
ENT.ClientProps["route2"] = {
    model = "models/metrostroi_train/81-720/route/route2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
}

ENT.ClientProps["lamp_f"] = {
    model = "models/metrostroi_train/81-720/lamp_revers_up.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=0.8,
}
ENT.ClientProps["lamp_b"] = {
    model = "models/metrostroi_train/81-720/lamp_revers_down.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=0.8,
}
ENT.ClientProps["underwagon"] = {
    model = "models/metrostroi_train/81-720/721_underwagon.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=0.8,
}

ENT.ClientProps["fireextinguisher"] = {
    model = "models/metrostroi_train/81-502/fireextinguisher.mdl",
    pos = Vector(-3,88,-7),
    ang = Angle(0,0,0),
    hideseat = 0.8,
}


---Segments
ENT.ClientProps["acceleration_minus1"] = {
    model = "models/metrostroi_train/81-720/segments/acceleration_minus.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    skin = 0,
    color = Color(255,50,50),
    hideseat = 0.8,
}
ENT.ClientProps["acceleration_minus2"] = {
    model = "models/metrostroi_train/81-720/segments/acceleration_minus.mdl",
    pos = Vector(0,1.28,0),
    ang = Angle(0,0,0),
    skin = 0,
    color = Color(255,50,50),
    hideseat = 0.8,
}
ENT.ClientProps["acceleration_plus1"] = {
    model = "models/metrostroi_train/81-720/segments/acceleration_plus.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    skin = 0,
    color = Color(255,50,50),
    hideseat = 0.8,
}
ENT.ClientProps["acceleration_plus2"] = {
    model = "models/metrostroi_train/81-720/segments/acceleration_plus.mdl",
    pos = Vector(0,-1.28,0),
    ang = Angle(0,0,0),
    skin = 0,
    color = Color(255,50,50),
    hideseat = 0.8,
}
ENT.ClientProps["speedl"] = {
    model = "models/metrostroi_train/81-720/720_speed_light.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(150,200,150),
    hideseat = 0.8,
}
ENT.ClientProps["speed1"] = {
    model = "models/metrostroi_train/81-720/digits/digit.mdl",
    pos = Vector(477.45,15.28+0.05,-22.17),
    ang = Angle(130,0,0),
    color = Color(20,255,50),
    hideseat = 0.2,
}
ENT.ClientProps["speed2"] = {
    model = "models/metrostroi_train/81-720/digits/digit.mdl",
    pos = Vector(477.45,14.86-0.05,-22.17),
    ang = Angle(130,0,0),
    color = Color(20,255,50),
    hideseat = 0.2,
}
for i=1,5 do
    ENT.ClientProps["speeddop"..i] = {
        model = "models/metrostroi_train/81-720/segments/speed_red.mdl",
        pos = Vector(0,1.305*(i-1),0),
        ang = Angle(0,0,0),
        skin = 0,
        color = Color(255,55,55),
        hideseat = 0.8,
    }
end
for i=1,5 do
    ENT.ClientProps["speedfact"..i] = {
        model = "models/metrostroi_train/81-720/segments/speed_green.mdl",
        pos = Vector(0,-1.305*(i-1),0),
        ang = Angle(0,0,0),
        skin = 0,
        color = Color(90,255,80),
        hideseat = 0.8,
    }
end
for i=1,5 do
    ENT.ClientProps["speedrek"..i] = {
        model = "models/metrostroi_train/81-720/segments/speed_yellow.mdl",
        pos = Vector(0,1.305*(i-1),0),
        ang = Angle(0,0,0),
        skin = 0,
        color = Color(255,255,60),
        hideseat = 0.8,
    }
end

ENT.ClientProps["brake_cylinder"] = {
    model = "models/metrostroi_train/equipment/arrow_nm.mdl",
    pos = Vector(473.396637,58.499859,21.514017),
    ang = Angle(-43.000000,-31.000000,-269.000000),
    hideseat = 0.2,
}
ENT.ClientProps["train_line"] = {
    model = "models/metrostroi_train/equipment/arrow_nm.mdl",
    pos = Vector(476.289825,57.939251,3.990869),
    ang = Angle(-43.000000,-28.833702,-272.772339),
    hideseat = 0.2,
}
ENT.ClientProps["brake_line"] = {
    model = "models/metrostroi_train/equipment/arrow_tm.mdl",
    pos = Vector(476.279297,57.921833,3.991589),
    ang = Angle(-43.000000,-28.833702,-272.772339),
    hideseat = 0.2,
}

ENT.ClientProps["volt_lv"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(477.452179,59.365273,-1.443494),
    ang = Angle(41.227245,-37.233719,92.130653),
    hideseat = 0.2,
}--1,0.712

ENT.ClientProps["volt_hv"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(477.370789,59.209976,-7.437835),
    ang = Angle(46.156513,-41.354576,94.116631),
    hideseat = 0.2,
}--1,0.733



ENT.ClientProps["amp_i13"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(477.418518,59.158699,-11.648458),
    ang = Angle(42.932121,-41.354576,94.116631),
    hideseat = 0.2,
}--1,0.722
ENT.ClientProps["amp_i24"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(477.513031,59.213814,-15.593397),
    ang = Angle(45.002529,-41.354576,94.116631),
    hideseat = 0.2,
}--1,0.726

---Подсветка
ENT.ClientProps["ticker"] = {
    model = "models/metrostroi_train/81-720/720_tablo.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 1.5,
}
ENT.ClientProps["lamps_emer"] = {
    model = "models/metrostroi_train/81-720/720_lamps_emer.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(245,238,223),
    hide = 1.5,
}
ENT.ClientProps["lamps_full"] = {
    model = "models/metrostroi_train/81-720/720_lamps_full.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(245,238,223),
    hide = 1.5,
}
ENT.ClientProps["cab_emer"] = {
    model = "models/metrostroi_train/81-720/720_lamps_cab1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat = 1.1,
    color = Color(206,162,153),
}
ENT.ClientProps["cab_full"] = {
    model = "models/metrostroi_train/81-720/720_lamps_cab2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat = 1.1,
    color = Color(206,162,153),
}
ENT.ClientProps["cabine"] = {
    model = "models/metrostroi_train/81-720/720_cab.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2,
}
ENT.ClientProps["PassSchemes"] = {
    model = "models/metrostroi_train/81-720/720_sarmat_l.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 1.5,
    callback = function(ent)
        ent.PassSchemesDone = false
    end,
}
ENT.ClientProps["PassSchemesR"] = {
    model = "models/metrostroi_train/81-720/720_sarmat_r.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 1.5,
    callback = function(ent)
        ent.PassSchemesDone = false
    end,
}
for i=1,5 do
    ENT.ClientProps["led_l_f"..i] = {
        model = "models/metrostroi_train/81-720/720_led_l_r.mdl",
        pos = Vector((i-1)*10.5+0.2,0,0),
        ang = Angle(0,0,0),
        skin=6,
        hideseat = 1.5,
    }
    ENT.ClientProps["led_l_b"..i] = {
        model = "models/metrostroi_train/81-720/720_led_l.mdl",
        pos = Vector(-(i-1)*10.5-0.2,0,0),
        ang = Angle(0,0,0),
        skin=6,
        hideseat = 1.5,
    }

    ENT.ClientProps["led_r_f"..i] = {
        model = "models/metrostroi_train/81-720/720_led_r.mdl",
        pos = Vector((i-1)*10.5+0.2,0,0),
        ang = Angle(0,0,0),
        skin=6,
        hideseat = 1.5,
    }

    ENT.ClientProps["led_r_b"..i] = {
        model = "models/metrostroi_train/81-720/720_led_r_r.mdl",
        pos = Vector(-(i-1)*10.5-0.2,0,0),
        ang = Angle(0,0,0),
        skin=6,
        hideseat = 1.5,
    }
end

ENT.ButtonMap["GV"] = {
    pos = Vector(128,63,-52-15),
    ang = Angle(0,180,90),
    width = 170,
    height = 150,
    scale = 0.1,
    buttons = {
        {ID = "GVToggle",x=0, y=0, w= 170,h = 150, tooltip="Разъединитель БРУ (ГВ)", model = {
            var="GV",sndid = "gv_wrench",
            sndvol = 0.8,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            snd = function(val) return val and "gv_f" or "gv_b" end,
            states={"Train.Buttons.Disconnected","Train.Buttons.On"}
        }},
    }
}
ENT.ClientProps["gv_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = Vector(126.4,50,-60-23.5),
    ang = Angle(-90,0,0),
    hide = 0.5,
}

local yventpos = {
    -414.5+0*117,
    -414.5+1*117+6.2,
    -414.5+2*117+5,
    -414.5+3*117+2,
    -414.5+4*117+0.5,
    -414.5+5*117-2.3,
    -414.5+6*117-2.3,
}
for i=1,7 do
    ENT.ClientProps["vent"..i] = {
        model = "models/metrostroi_train/81-720/vent.mdl",
        pos = Vector(yventpos[i],0,57.2),
        ang = Angle(0,0,0),
        hideseat=0.8,
    }
end
--------------------------------------------------------------------------------
-- Add doors
--------------------------------------------------------------------------------
--[[ local function GetDoorPosition(i,k,j)
    if j == 0
    then return Vector(377.0 - 36.0 + 1*(k) - 230*i,-64*(1-2*k),-10)
    else return Vector(377.0 - 36.0 + 1*(k) - 230*i,-64*(1-2*k),-10)
    end
end
for i=0,3 do
    for k=0,1 do
        ENT.ClientProps["door"..i.."x"..k.."a"] = {
            model = "models/metrostroi_train/81-720/81-720_door_l.mdl",
            pos = GetDoorPosition(i,k,0),
            ang = Angle(0,90 +180*k,0),
            hide = 2,
        }
        ENT.ClientProps["door"..i.."x"..k.."b"] = {
            model = "models/metrostroi_train/81-720/81-720_door_r.mdl",
            pos = GetDoorPosition(i,k,1),
            ang = Angle(0,90 +180*k,0),
            hide = 2,
        }
    end
end--]]

ENT.ClientProps["door0x1"] = {
    model = "models/metrostroi_train/81-720/81-720_doors_pos1.mdl",
    pos = Vector( 341.539,63.171,-11.1),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x1"] = {
    model = "models/metrostroi_train/81-720/81-720_doors_pos2.mdl",
    pos = Vector( 111.38,63.171,-11.1),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x1"] = {
    model = "models/metrostroi_train/81-720/81-720_doors_pos3.mdl",
    pos = Vector(-117.756,63.171,-11.1),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x1"] = {
    model = "models/metrostroi_train/81-720/81-720_doors_pos4.mdl",
    pos = Vector(-348.72,63.171,-11.1),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door0x0"] = {
    model = "models/metrostroi_train/81-720/81-720_doors_pos4.mdl",
    pos = Vector( 341.539,-63.171,-11.1),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x0"] = {
    model = "models/metrostroi_train/81-720/81-720_doors_pos3.mdl",
    pos = Vector( 111.38,-63.171,-11.1),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x0"] = {
    model = "models/metrostroi_train/81-720/81-720_doors_pos2.mdl",
    pos = Vector(-117.756,-63.171,-11.1),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x0"] = {
    model = "models/metrostroi_train/81-720/81-720_doors_pos1.mdl",
    pos = Vector(-348.72,-63.171,-11.1),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door_cab_m"] = {
    model = "models/metrostroi_train/81-720/720_door_cab.mdl",
    pos = Vector(374.9,-45.5+25.5,-12.3),
    ang = Angle(0,-90-1,0),
    hide = 2,
}
ENT.ClientProps["door_cab_o"] = {
    model = "models/metrostroi_train/81-720/720_cab_otsek.mdl",
    pos = Vector(374.9,26,-15),
    ang = Angle(0,-90+0.45,-0.15),
    hide = 2,
}
ENT.ClientProps["door_cab_l"] = {
    model = "models/metrostroi_train/81-720/720_door_cab_l.mdl",
    pos = Vector(419.4, 62.3,-10),
    ang = Angle(0,-90,0),
    hide = 2,
}
ENT.ClientProps["door_cab_r"] = {
    model = "models/metrostroi_train/81-720/720_door_cab_r.mdl",
    pos = Vector(419.4,-62.3,-10),
    ang = Angle(0,-90,0),
    hide = 2,
}
ENT.ClientProps["door_cab_t"] = {
    model = "models/metrostroi_train/81-720/720_door_tor.mdl",
    pos = Vector(-467.5,17,-10),
    ang = Angle(0,-91,-0),
    hide = 2,
}
ENT.ClientProps["KRO"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = Vector(463.445343,53.273838,-21.1),
    ang = Angle(180,90+13,180+28),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientProps["KRR"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = Vector(470.430176,53.971645,-17.4),
    ang = Angle(180,90+13,180+28),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientProps["controller"] = {
    model = "models/metrostroi_train/81-720/720_kv.mdl",
    pos = Vector(458.484589,25.265604,-29.164625),
    ang = Angle(0.000000,-90.000000,23.699429),
    hideseat = 0.2,
}

ENT.ClientProps["km013"] = {
    model = "models/metrostroi_train/81-720/720_km013.mdl",
    pos = Vector(443,-14.8,-47.9),
    ang = Angle(180,90,-110),
    hideseat = 0.2,
}
if not ENT.ClientSounds["br_013"] then ENT.ClientSounds["br_013"] = {} end
table.insert(ENT.ClientSounds["br_013"],{"km013",function(ent,_,var) return "br_013" end,0.7,1,35,1e3,Angle(-90,0,0)})

ENT.ClientProps["PB"] = {
    model = "models/metrostroi_train/81-720/720_pb.mdl",
    pos = Vector(467.138672,39.572510,-47.119862),
    ang = Angle(0.000000,-90.000000,0.000000),
    hideseat = 0.2,
}
if not ENT.ClientSounds["PB"] then ENT.ClientSounds["PB"] = {} end
table.insert(ENT.ClientSounds["PB"],{"PB",function(ent,var) return var > 0 and "pb_on" or "pb_off" end,1,1,30,1e3,Angle(-90,0,0)})

ENT.Lights = {
    -- Headlight glow
    [1] = { "headlight",Vector(495,0,-40),Angle(0,0,0),Color(216,161,92),farz=5144,brightness = 4, hfov=105,vfov=105, texture = "models/metrostroi_train/equipment/headlight",shadows = 1,headlight=true},
    [31]  = { "light",Vector(500,-35,-29), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02.vmt" },
    [32]  = { "light",Vector(500, 35,-29), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02.vmt" },
    -- Reverse
    [2] = { "headlight",        Vector(495,0,-40), Angle(0,0,0), Color(255,0,0), fov=170 ,brightness = 0.1, farz=450,texture = "models/metrostroi_train/equipment/headlight2",shadows = 0,backlight=true},
    [33] = { "light",Vector(500,-50, -29), Angle(0,0,0), Color(255,50,50),     brightness = 0.1, scale = 1.5, texture = "sprites/light_glow02.vmt"  },
    [34] = { "light",Vector(500, 50, -29), Angle(0,0,0), Color(255,50,50),     brightness = 0.1, scale = 1.5, texture = "sprites/light_glow02.vmt"  },
    [35] = { "light",Vector(500,-50, -75), Angle(0,0,0), Color(255,50,50),     brightness = 0.1, scale = 1.5, texture = "sprites/light_glow02.vmt"  },
    [36] = { "light",Vector(500, 50, -75), Angle(0,0,0), Color(255,50,50),     brightness = 0.1, scale = 1.5, texture = "sprites/light_glow02.vmt"  },
    -- Apparats
    [3] = { "headlight",        Vector(380,40,43.9), Angle(50,40,-0), Color(206,135,80), hfov=100, vfov=100,farz=200,brightness = 6,shadows=1},
    -- Cabin
    [10] = { "dynamiclight",    Vector( 440, 0, 13), Angle(0,0,0), Color(206,135,80), brightness = 0.7, distance = 550 },
    -- Interior
    [15] = { "dynamiclight",    Vector(-350, 0, 10), Angle(0,0,0), Color(238,238,197), brightness = 0.75, distance = 500, fov=180,farz = 128 },
    [16] = { "dynamiclight",    Vector(-60, 0, 10), Angle(0,0,0), Color(238,238,197), brightness = 0.75, distance = 500, fov=180,farz = 128 },
    [17] = { "dynamiclight",    Vector( 230, 0, 10), Angle(0,0,0), Color(238,238,197), brightness = 0.75, distance = 500, fov=180,farz = 128 },
}

ENT.ButtonMap["Vityaz"] = {
    pos = Vector(479.5,-10.7,-22.25),
    ang = Angle(0,-90,38.2),
    width = 800,
    height = 795,
    scale = 0.00725,
    hideseat = 0.2,
}
function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.Vityaz = self:CreateRT("721Vityaz",1024,1024)
    self.ASNP = self:CreateRT("721ASNP",512,128)
    self.IGLA = self:CreateRT("720IGLA",512,128)
    self.Tickers = self:CreateRT("721Ticker",1024,64)
    render.PushRenderTarget(self.Tickers,0,0,1024, 64)
    render.Clear(0, 0, 0, 0)
    render.PopRenderTarget()
    self.ReleasedPdT = 0
    self.CraneRamp = 0
    self.CraneRRamp = 0
    self.EmergencyValveRamp = 0
    self.FrontLeak = 0
    self.RearLeak = 0

    self.ParkingBrake = 0

    self.PreviousRingState = false
    self.PreviousCompressorState = false
    self.TISUVol = 0


    self.EmergencyValveRamp = 0

    self.VentRand = {}
    self.VentState = {}
    self.VentVol = {}
    for i=1,7 do
        self.VentRand[i] = math.Rand(0.5,2)
        self.VentState[i] = 0
        self.VentVol[i] = 0
    end
end
function ENT:UpdateWagonNumber()
    for i=0,3 do
        --self:ShowHide("TrainNumberL"..i,i<count)
        --self:ShowHide("TrainNumberR"..i,i<count)
        --if i< count then
            local num = math.floor(self.WagonNumber%(10^(i+1))/10^i)
            local leftNum,rightNum = self.ClientEnts["TrainNumberL"..i],self.ClientEnts["TrainNumberR"..i]
            if IsValid(leftNum) then
                leftNum:SetPos(self:LocalToWorld(Vector(60+i*6.6-4*6.6/2,66.3,18)))
                leftNum:SetSkin(num)
            end
            if IsValid(rightNum) then
                rightNum:SetPos(self:LocalToWorld(Vector(53-i*6.6+4*6.6/2,-66.3,18)))
                rightNum:SetSkin(num)
            end
        --end
    end
end
local Cpos = {
    0,0.24,0.5,0.55,0.6,1
}
function ENT:Think()
    self.BaseClass.Think(self)
    if not self.RenderClientEnts or self.CreatingCSEnts then
        return
    end
    if not self.PassSchemesDone then
        local sarmat = self.ClientEnts.PassSchemes
        local sarmatr = self.ClientEnts.PassSchemesR
        local scheme = Metrostroi.Skins["720_schemes"] and Metrostroi.Skins["720_schemes"][self.Scheme]
        if IsValid(sarmat) and IsValid(sarmatr) and scheme then
            if self:GetNW2Bool("PassSchemesInvert") then
                sarmat:SetSubMaterial(0,scheme[2])
                sarmatr:SetSubMaterial(0,scheme[1])
            else
                sarmat:SetSubMaterial(0,scheme[1])
                sarmatr:SetSubMaterial(0,scheme[2])
            end
            self.PassSchemesDone = true
        end
    end

    if self.Scheme ~= self:GetNW2Int("Scheme",1) then
        self.PassSchemesDone = false
        self.Scheme = self:GetNW2Int("Scheme",1)
    end
    if self.InvertSchemes ~= self:GetNW2Bool("PassSchemesInvert",false) then
        self.PassSchemesDone=false
        self.InvertSchemes = self:GetNW2Bool("PassSchemesInvert",false)
    end

    self:SetLightPower(3,self.Door5 and self:GetPackedBool("AppLights"),self:GetPackedBool("AppLights") and 1 or 0)
    local passlight = self:GetPackedRatio("SalonLighting")
    self:SetLightPower(15,passlight>0,passlight)
    self:SetLightPower(16,passlight>0,passlight)
    self:SetLightPower(17,passlight>0,passlight)
    --ANIMS
    self:Animate("brake_line", self:GetPackedRatio("BL"), 0, 0.753,  256,2)
    self:Animate("train_line", self:GetPackedRatio("TL"),   0, 0.753,  4096,2)
    self:Animate("brake_cylinder", self:GetPackedRatio("BC"), 0, 0.746,  64,12)
    self:Animate("volt_lv",self:GetPackedRatio("LV"),1,0.712,92,2)
    self:Animate("volt_hv",self:GetPackedRatio("HV"),1,0.726,92,2)
    self:Animate("amp_i13",self:GetPackedRatio("I13"),1,0.722,92,2)
    self:Animate("amp_i24",self:GetPackedRatio("I24"),1,0.726,92,2)
    self:Animate("controller", (self:GetPackedRatio("Controller")+3)/7, 0, 0.39,  3,false)

    self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,1, 3, false)
    self:Animate("FrontTrain",  self:GetNW2Bool("FtI") and 1 or 0,0,1, 3, false)
    self:Animate("RearBrake",   self:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    self:Animate("RearTrain",   self:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)

    if self.LastGVValue ~= self:GetPackedBool("GV") then
        self.ResetTime = CurTime()+1.5
        self.LastGVValue = self:GetPackedBool("GV")
    end
    self:Animate("gv_wrench",self.LastGVValue and 1 or 0,0.5,1,128,1,false)
    self:ShowHideSmooth("gv_wrench",    CurTime() < self.ResetTime and 1 or 0.1)
    --self:Animate("controller", (self:GetPackedRatio("Controller")+3)/6, 0.75, 0.15,  2,false)
    --self:SetPackedRatio("BL", self.Pneumatic.BrakeLinePressure/16.0)
    --self:SetPackedRatio("TL", self.Pneumatic.TrainLinePressure/16.0)
    --self:SetPackedRatio("BC", math.min(3.2,self.Pneumatic.BrakeCylinderPressure)/6.0)

    self:Animate("KRO", self:GetPackedRatio("KRO",0), 0.3, 0.75,  3,false)
    self:Animate("KRR", self:GetPackedRatio("KRR",0), 0.3, 0.8,  3,false)
    self:ShowHide("KRO",self:GetNW2Int("Wrench",0) == 1)
    self:ShowHide("KRR",self:GetNW2Int("Wrench",0) == 2)
    self:Animate("km013", Cpos[self:GetPackedRatio("Cran")] or 0, 0, 0.7,  2,false)
    self:Animate("PB",  self:GetPackedBool("PB") and 1 or 0,0,0.2,  8,false)

    self:ShowHideSmooth("lamps_emer",self:Animate("LampsEmer",passlight == 0.4 and 1 or 0,0,1,5,false))
    self:ShowHideSmooth("lamps_full",self:Animate("LampsFull",passlight == 1 and 1 or 0,0,1,5,false))

    local cab_lamp = self:Animate("cab_lamp",self:GetPackedBool("CabinEnabledFull") and 1 or self:GetPackedBool("CabinEnabledEmer") and 0.5 or 0,0,1,5,false)
    self:SetLightPower(10,cab_lamp>0,cab_lamp)
    self:ShowHideSmooth("cab_emer",cab_lamp)
    self:ShowHideSmooth("cab_full",cab_lamp)

    self:ShowHideSmooth("lamp_f",self:Animate("lamp_forw",self:GetPackedBool("BIForward") and 1 or 0,0,1,5,false))
    self:ShowHideSmooth("lamp_b",self:Animate("lamp_back",self:GetPackedBool("BIBack") and 1 or 0,0,1,5,false))


    local accel = self:GetPackedRatio("BIAccel",0)
    --if -0.05 < accel and accel < 0.05 then accel = 0 end
    local speed = self:GetNW2Int("BISpeed",0)--CurTime()%5*20
    local limit = self:GetNW2Int("BISpeedLimit",0)
    if IsValid(self.ClientEnts["acceleration_minus1"]) and IsValid(self.ClientEnts["acceleration_minus2"]) then
        self.ClientEnts["acceleration_minus1"]:SetSkin(math.Clamp(-accel*14,0,10))
        self.ClientEnts["acceleration_minus2"]:SetSkin(math.Clamp(-accel*14-12,0,9))
    end
    if IsValid(self.ClientEnts["acceleration_plus1"]) and IsValid(self.ClientEnts["acceleration_plus2"]) then
        self.ClientEnts["acceleration_plus1"]:SetSkin(math.Clamp(accel*14,0,10))
        self.ClientEnts["acceleration_plus2"]:SetSkin(math.Clamp(accel*14-12,0,9))
    end
    self:ShowHide("speedl",speed ~= -1)
    self:ShowHide("speed1",speed ~= -1)
    self:ShowHide("speed2",speed ~= -1)
    if speed ~= -1 then
        local blink = self:GetNW2Bool("BISpeedLimitBlink")
        if blink and CurTime()%1 <=0.5 then
            limit = 98
        end
        local nxt = self:GetNW2Int("BISpeedLimitNext",0)
        for i=1,5 do
            if IsValid(self.ClientEnts["speeddop"..i]) then self.ClientEnts["speeddop"..i]:SetSkin(math.Clamp(50-limit/2-(i-1)*10,0,10)) end
            if IsValid(self.ClientEnts["speedfact"..i]) then self.ClientEnts["speedfact"..i]:SetSkin(math.Clamp(speed/2-(i-1)*10,0,10)) end
            if IsValid(self.ClientEnts["speedrek"..i]) then self.ClientEnts["speedrek"..i]:SetSkin(math.Clamp(50-nxt/2-(i-1)*10,0,10)) end
        end
        if IsValid(self.ClientEnts["speed1"]) then self.ClientEnts["speed1"]:SetSkin(speed/10) end
        if IsValid(self.ClientEnts["speed2"]) then self.ClientEnts["speed2"]:SetSkin(speed%10) end
    else
        for i=1,5 do
            if IsValid(self.ClientEnts["speeddop"..i]) then self.ClientEnts["speeddop"..i]:SetSkin(0) end
            if IsValid(self.ClientEnts["speedfact"..i]) then self.ClientEnts["speedfact"..i]:SetSkin(0) end
            if IsValid(self.ClientEnts["speedrek"..i]) then self.ClientEnts["speedrek"..i]:SetSkin(0) end
        end
    end

    local HL1 = self:Animate("headlights",self:GetPackedBool("HeadlightsEnabled1") and 1 or 0,0,1,4,false)
    local HL2 = self:Animate("headlights_full",self:GetPackedBool("HeadlightsEnabled2") and 1 or 0,0,1,4,false)
    local RL = self:Animate("backlights",self:GetPackedBool("BacklightsEnabled") and 1 or 0,0,1,4,false)
    self:ShowHideSmooth("HeadLights",HL1)
    self:ShowHideSmooth("HeadLights_full",HL2)
    self:ShowHideSmooth("RedLights",RL)
    local headlights = HL1*0.4+HL2*0.6
    self:SetLightPower(1,headlights>0,headlights)
    self:SetLightPower(31,headlights>0,headlights)
    self:SetLightPower(32,headlights>0,headlights)
    self:SetLightPower(2,RL>0,RL)
    self:SetLightPower(33,RL>0,RL)
    self:SetLightPower(34,RL>0,RL)
    self:SetLightPower(35,RL>0,RL)
    self:SetLightPower(36,RL>0,RL)
    if IsValid(self.GlowingLights[1]) then
        if self:GetPackedRatio("Headlights") < 1 and self.GlowingLights[1]:GetFarZ() ~= 4096 then
            self.GlowingLights[1]:SetFarZ(4096)
        end
        if self:GetPackedRatio("Headlights") == 1 and self.GlowingLights[1]:GetFarZ() ~= 5144 then
            self.GlowingLights[1]:SetFarZ(5144)
        end
    end

    local scurr = self:GetNW2Int("PassSchemesLED")
    local snext = self:GetNW2Int("PassSchemesLEDN")
    local led_back = self:GetPackedBool("PassSchemesLEDO",false)
    if self:GetPackedBool("PassSchemesInvert",false)  then led_back = not led_back end
    local ledwork = scurr~=0 or snext~=0
    for i=1,5 do
        self:ShowHide("led_l_f"..i,not led_back and ledwork)
        self:ShowHide("led_l_b"..i,led_back and ledwork)
        self:ShowHide("led_r_f"..i,not led_back and ledwork)
        self:ShowHide("led_r_b"..i,led_back and ledwork)
    end
    local led = scurr
    if snext ~= 0 and CurTime()%.5 > .25 then led = led + snext end
    if scurr < 0 then led = math.floor(CurTime()%5*6.2) end
    if led_back then
        if ledwork then
            for i=1,5 do
                if IsValid(self.ClientEnts["led_l_b"..i]) then self.ClientEnts["led_l_b"..i]:SetSkin(math.Clamp(led-((i-1)*6),0,6)) end
                if IsValid(self.ClientEnts["led_r_b"..i]) then self.ClientEnts["led_r_b"..i]:SetSkin(math.Clamp(led-((i-1)*6),0,6)) end
            end
        end
    else
        if ledwork then
            for i=1,5 do
                if IsValid(self.ClientEnts["led_l_f"..i]) then self.ClientEnts["led_l_f"..i]:SetSkin(math.Clamp(led-((i-1)*6),0,6)) end
                if IsValid(self.ClientEnts["led_r_f"..i]) then self.ClientEnts["led_r_f"..i]:SetSkin(math.Clamp(led-((i-1)*6),0,6)) end
            end
        end
    end
    --
    --print(self:GetPackedRatio("async2vol"), self:GetPackedRatio("async2"))
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
                        self:PlayOnce(sid.."o","",1,math.Rand(0.9,1.1))
                    else
                        self:PlayOnce(sid.."c","",1,math.Rand(0.9,1.1))
                    end
                end
                self.DoorStates[id] = (state ~= 1 and state ~= 0)
            end
            if (state ~= 1 and state ~= 0) then
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) + 2*self.DeltaTime,0,1)
            else
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) - 6*self.DeltaTime,0,1)
            end
            self:SetSoundState(sid.."r",self.DoorLoopStates[id],0.9+self.DoorLoopStates[id]*0.1)
            local n_l = "door"..i.."x"..k--.."a"
            --local n_r = "door"..i.."x"..k.."b"
            local dlo = 1
            --local dro = 1
            if self.Anims[n_l] then
                dlo = math.abs(state-(self.Anims[n_l] and self.Anims[n_l].oldival or 0))
                if dlo <= 0 and self.Anims[n_l].oldspeed then dlo = self.Anims[n_l].oldspeed/15 end
            end
            --[[ if self.Anims[n_r] then
                dro = math.abs(state-self.Anims[n_r].oldival)
                if dro <= 0 and self.Anims[n_r].oldspeed then dro = self.Anims[n_r].oldspeed/15 end
            end--]]
            self:Animate(n_l,state,0.02,1, dlo*15,false)--0.8 + (-0.2+0.4*math.random()),0)
            --self:Animate(n_r,state,0,1, dro*15,false)--0.8 + (-0.2+0.4*math.random()),0)
        end
    end
    local door_m = self:GetPackedBool("PassengerDoor")
    local door_l = self:GetPackedBool("CabinDoorLeft")
    local door_r = self:GetPackedBool("CabinDoorRight")
    local door_o = self:GetPackedBool("OtsekDoor") or self.CurrentCamera == 7
    local door_t = self:GetPackedBool("RearDoor")
    local door_cab_m = self:Animate("door_cab_m",door_m and 1 or -0.05,0,0.235, 8, 0.05)
    local door_cab_l = self:Animate("door_cab_l",door_l and 1 or -0.1,1,0.75, 2, 0.5)
    local door_cab_r = self:Animate("door_cab_r",door_r and 1 or -0.1,0,0.25, 2, 0.5)
    local door_cab_o = self:Animate("door_cab_o",door_o and 1 or -0.05,0,0.3, 8, 0.05)
    local door_cab_t = self:Animate("door_cab_t",door_t and 1 or -0.05,0,0.25, 8, 0.05)

    local door1s = (door_cab_m > 0 or door_m)
    if self.Door1 ~= door1s then
        self.Door1 = door1s
        self:PlayOnce("PassengerDoor","bass",door1s and 1 or 0)
    end
    --local door_cab_l = self.Anims["door_cab_l"].val or 0
    local door2s = door_cab_l > 0.75 and door_cab_l < 1 and 2 or (door_cab_l == 0.75 and 3 or door_l and 1 or 0)
    if self.Door2 ~= door2s or self.DoorCL ~= door_l then
        self.DoorCL = door_l
        self.Door2 = door2s
        self:PlayOnce("CabinDoorLeft","bass",door2s)
    end
    local door3s = door_cab_r > 0 and door_cab_r < 0.25 and 2 or (door_cab_r == 0.25 and 3 or door_r and 1 or 0)
    if self.Door3 ~= door3s or self.DoorCR ~= door_r then
        self.DoorCR = door_r
        self.Door3 = door3s
        self:PlayOnce("CabinDoorRight","bass",door3s)
    end
    local door4s = (door_cab_t > 0 or door_t)
    if self.Door4 ~= door4s then
        self.Door4 = door4s
        self:PlayOnce("RearDoor","bass",door4s and 1 or 0)
    end
    local door5s = (door_cab_o > 0 or door_o)
    if self.Door5 ~= door5s then
        self.Door5 = door5s
        self:PlayOnce("OtsekDoor","bass",door5s and 1 or 0)
    end
    self:HidePanel("PVZ",not self.Door5)

    local dT = self.DeltaTime

    local dPdT = self:GetPackedRatio("BrakeCylinderPressure_dPdT")
    self.ReleasedPdT = math.Clamp(self.ReleasedPdT + 4*(-self:GetPackedRatio("BrakeCylinderPressure_dPdT",0)-self.ReleasedPdT)*dT,0,1)
    --print(dPdT)
    self:SetSoundState("release",math.Clamp(self.ReleasedPdT,0,1)^1.65,1.0)

    local parking_brake = math.max(0,-self:GetPackedRatio("ParkingBrakePressure_dPdT",0))
    self.ParkingBrake = self.ParkingBrake+(parking_brake-self.ParkingBrake)*dT*10
    self:SetSoundState("parking_brake",self.ParkingBrake,1.4)

    self.FrontLeak = math.Clamp(self.FrontLeak + 10*(-self:GetPackedRatio("FrontLeak")-self.FrontLeak)*dT,0,1)
    self.RearLeak = math.Clamp(self.RearLeak + 10*(-self:GetPackedRatio("RearLeak")-self.RearLeak)*dT,0,1)
    self:SetSoundState("front_isolation",self.FrontLeak,0.9+0.2*self.FrontLeak)
    self:SetSoundState("rear_isolation",self.RearLeak,0.9+0.2*self.RearLeak)

    local ramp = self:GetPackedRatio("Crane_dPdT",0)
    if ramp > 0 then
        self.CraneRamp = self.CraneRamp + ((0.2*ramp)-self.CraneRamp)*dT
    else
        self.CraneRamp = self.CraneRamp + ((0.9*ramp)-self.CraneRamp)*dT
    end
    self.CraneRRamp = math.Clamp(self.CraneRRamp + 1.0*((1*ramp)-self.CraneRRamp)*dT,0,1)
    self:SetSoundState("crane013_release",self.CraneRRamp^1.5,1.0)
    self:SetSoundState("crane013_brake",math.Clamp(-self.CraneRamp*1.5,0,1)^1.3,1.0)
    self:SetSoundState("crane013_brake2",math.Clamp(-self.CraneRamp*1.5-0.95,0,1.5)^2,1.0)

    local emergencyValve = self:GetPackedRatio("EmergencyValve_dPdT", 0)^0.4*1.2
    self.EmergencyValveRamp = math.Clamp(self.EmergencyValveRamp + (emergencyValve-self.EmergencyValveRamp)*dT*16,0,1)
    self:SetSoundState("emer_brake",self.EmergencyValveRamp,1.0)


    local state = self:GetPackedBool("RingEnabled")
    self:SetSoundState("ring",state and 0.40 or 0,1)
    local state = self:GetPackedBool("CompressorWork")
    self:SetSoundState("compressor",state and 1 or 0,1)
    local state = self:GetPackedBool("WorkBeep")
    self:SetSoundState("work_beep",state and 1 or 0,1)


    local speed = self:GetPackedRatio("Speed", 0)

    local ventSpeedAdd = math.Clamp(speed/30,0,1)

    local v1state = self:GetPackedBool("Vent1Work")
    local v2state = self:GetPackedBool("Vent2Work")
    for i=1,7 do
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
    --Vector(409,25.6,-26.3)
    local speed = self:GetPackedRatio("Speed", 0)
    --local rol10 = math.Clamp(speed/5,0,1)*(1-math.Clamp((speed-50)/8,0,1))
    --local rol70 = math.Clamp((speed-50)/8,0,1)
    local rollingi = math.min(1,self.TunnelCoeff+math.Clamp((self.StreetCoeff-0.82)/0.5,0,1))
    local rollings = math.max(self.TunnelCoeff*0.6,self.StreetCoeff)
    local rol10 = math.Clamp(speed/12,0,1)*(1-math.Clamp((speed-20)/12,0,1))
    local rol10p = Lerp((speed-12)/12,0.9,1.1)
    local rol30 = math.Clamp((speed-20)/12,0,1)*(1-math.Clamp((speed-40)/12,0,1))
    local rol30p = Lerp((speed-15)/30,0.8,1.2)
    local rol55 = math.Clamp((speed-40)/12,0,1)*(1-math.Clamp((speed-65)/15,0,1))
    local rol55p = Lerp(0.8+(speed-43)/24,0.8,1.2)
    local rol75 = math.Clamp((speed-65)/15,0,1)
    local rol75p = Lerp(0.8+(speed-67)/16,0.8,1.2)
    self:SetSoundState("rolling_10",rollingi*rol10,rol10p)
    self:SetSoundState("rolling_30",rollingi*rol30,rol30p)
    self:SetSoundState("rolling_55",rollingi*rol55,rol55p)
    self:SetSoundState("rolling_75",rollingi*rol75,rol75p)

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
    --rolling_10
    --rolling_45
    --rolling_60
    --rolling_70
    local state = self:GetPackedRatio("RNState")
    self.TISUVol = math.Clamp(self.TISUVol+(state-self.TISUVol)*dT*8,0,1)
    self:SetSoundState("tisu", self.TISUVol, 1)
    self:SetSoundState("tisu2", self.TISUVol, 1)
    --self:SetSoundState("tisu3", 0 or self.TISUVol, 1)
    self:SetSoundState("bbe", self:GetPackedBool("BBEWork") and 1 or 0, 1)

    local work = self:GetPackedBool("AnnPlay")
    for k,v in ipairs(self.AnnouncerPositions) do
        if IsValid(self.Sounds["announcer"..k]) then
            self.Sounds["announcer"..k]:SetVolume(work and (v[3] or 1)  or 0)
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
    self.RTMaterial:SetTexture("$basetexture", self.Vityaz)
    self:DrawOnPanel("Vityaz",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512-10,512-80,1024-20,1024-160,0)
    end)
    self.RTMaterial:SetTexture("$basetexture", self.ASNP)
    self:DrawOnPanel("ASNPScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(256,64,512,128,0)
    end)
    self.RTMaterial:SetTexture("$basetexture", self.IGLA)
    self:DrawOnPanel("IGLA",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(256,64,512,128,0)
    end)
    self.RTMaterial:SetTexture("$basetexture", self.Tickers)
    self:DrawOnPanel("Tickers",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,32+8,1024+16,64+16,0)
    end)
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
    if soundid == "QF1" then
        local id = range > 0 and "qf1_on" or "qf1_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["qf1_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    return soundid,location,range,pitch
end
Metrostroi.GenerateClientProps()
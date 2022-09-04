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
ENT.ButtonMap["PU1"] = {
    pos = Vector(471,41,-15.45), --446 -- 14 -- -0,5
    ang = Angle(0.5,-90,6.5),
    width = 230,
    height = 200,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "MirrorHeatingSet",x=93.5+36*2, y=100-18*2, radius=15, tooltip = "Отопление зеркал",model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl", z=2,
            var="MirrorHeating",speed=12, min=0,max=0.6,
            lamp = {model = "models/metrostroi_train/81-722/lamp_yellow.mdl",var="MirrorHeatingEnabled",z=0,anim=true,
            lcolor=Color(255,255,60),lz = 12,lbright=3,lfov=140,lfar=16,lnear=8,lshadows=0,},
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
            sndmin = 90, sndmax = 1e3,
        }},
        {ID = "DoorLeft2Set",x=93.5+36*3, y=100-18*3, radius=15, tooltip = "Двери левые",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl", z=2,
            var="DoorLeft2",speed=12, min=0,max=0.6,
            lamp = {model = "models/metrostroi_train/81-722/lamp_black.mdl",var="DoorLeftLamp",z=0,anim=true,
            lcolor=Color(255,255,255),lz = 12,lbright=3,lfov=140,lfar=16,lnear=8,lshadows=0,},
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
            sndmin = 90, sndmax = 1e3,
            sprite = {bright=0.4,size=0.25,scale=0.03,vscale=0.02,color=Color(255,255,255),z=3}
        }},
        {ID = "Zaglushka1",x=93.5+36*1, y=100-18*1+58*0,model = {
            model = "models/metrostroi_train/81-722/zaglushka.mdl", z=5,
        }},
        {ID = "Zaglushka2",x=93.5+36*0, y=100-18*0+58*0,model = {
            model = "models/metrostroi_train/81-722/zaglushka.mdl", z=5,
        }},
        {ID = "DoorBackSet",x=93.5+36*0, y=100-18*0+58*1, radius=15, tooltip = "Открытие правых дверей хвостового вагона",model = {
            model = "models/metrostroi_train/81-722/button_black.mdl", z=2,
            var="DoorBack",speed=12, min=0,max=0.6,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
            sndmin = 90, sndmax = 1e3,
        }},
        {ID = "EmergencyDriveSet",x=93.5+36*1, y=100-18*1+58*1, radius=15, tooltip = "Аварийный ход",model = {
            model = "models/metrostroi_train/81-722/button_red.mdl", z=2,
            var="EmergencyDrive",speed=12, min=0,max=0.6,
            lamp = {model = "models/metrostroi_train/81-722/lamp_red.mdl",var="EmergencyDriveL",z=0,anim=true,
            lcolor=Color(255,40,20),lz = 12,lbright=3,lfov=140,lfar=16,lnear=8,lshadows=0,},
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
            sndmin = 90, sndmax = 1e3,
            sprite = {bright=0.4,size=0.25,scale=0.03,vscale=0.02,color=Color(255,40,20),z=3},
            tooltipFunc = function(ent) return ent:GetPackedBool("EmergencyDriveL") and Metrostroi.GetPhrase("Train.Buttons.AHActive") end
        }},
        {ID = "MicrophoneSet",x=93.5+36*2, y=100-18*2+58*1, radius=15, tooltip = "Микрофон",model = {
            model = "models/metrostroi_train/81-722/button_blue.mdl", z=2,
            var="Microphone",speed=12, min=0,max=0.6,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
            sndmin = 90, sndmax = 1e3,
        }},
        {ID = "DoorLeft1Set",x=93.5+36*3, y=100-18*3+58*1, radius=15, tooltip = "Двери левые",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl", z=2,
            var="DoorLeft1",speed=12, min=0,max=0.6,
            lamp = {model = "models/metrostroi_train/81-722/lamp_black.mdl",var="DoorLeftLamp",z=0, anim=true,
            lcolor=Color(255,255,255),lz = 12,lbright=3,lfov=140,lfar=16,lnear=8,lshadows=0,},
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
            sndmin = 90, sndmax = 1e3,
            sprite = {bright=0.4,size=0.25,scale=0.03,vscale=0.02,color=Color(255,255,255),z=3}
        }},
    }
}

ENT.ButtonMap["PU2"] = {
    pos = Vector(472,25.5,-15.5), --446 -- 14 -- -0,5
    ang = Angle(0,-90,6.5),
    width = 325,
    height = 173,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "ARSToggle",x=35+50*1, y=45-18*0, radius=16, tooltip="АРС: Автоматическое регулирвоание скорости",model = {
            model = "models/metrostroi_train/81-722/tumbler.mdl", z=2, ang=180,
            var="ARS",speed=16, min=0.0, max=1,
            sndvol = 0.4, snd = function(val) return val and "switch_panel_up" or "switch_panel_down" end,
            sndmin = 90, sndmax = 1e3,
        }},
        {ID = "ALSToggle",x=35+50*2, y=45-18*0, radius=16, tooltip = "АЛС:Автоматическая локомотивная сигнализация",model = {
            model = "models/metrostroi_train/81-722/tumbler.mdl", z=2, ang=180,
            var="ALS",speed=16, min=0.0, max=1.0,
            sndvol = 0.4, snd = function(val) return val and "switch_panel_up" or "switch_panel_down" end,
            sndmin = 90, sndmax = 1e3,
        }},
        {ID = "GlassWasherSet",x=35+50*3, y=45-18*0, radius=15, tooltip = "Омыватель стекла",model = {
            model = "models/metrostroi_train/81-722/button_black.mdl", z=2, ang=180,
            var="GlassWasher",speed=12, min=0,max=0.6,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
            sndmin = 90, sndmax = 1e3,
        }},
        {ID = "GlassCleaner",x=35+50*4, y=45-18*0, radius=0,model = {
            model = "models/metrostroi_train/81-722/tumbler.mdl", z=2, ang=180,
            getfunc = function(ent) return ent:GetPackedRatio("GlassCleaner") end, var="GlassCleaner",
            speed=8,min=0.0, max=1.0,
            sndvol = 0.4, snd = function(val,val2) return val2 == 1 and "switch_panel_mid" or val and "switch_panel_up" or "switch_panel_down" end,
            sndmin = 90, sndmax = 1e3,
        }},
        {ID="GlassCleaner+",x=35+50*4-16, y=45-18*0-20, w=32,h=20, tooltip="Стеклоочиститель(вверх)",tooltipFunc = function(ent) return ent:GetPackedRatio("GlassCleaner") > 0 and tostring(math.floor(ent:GetPackedRatio("GlassCleaner")*2)) or Metrostroi.GetPhrase("Train.Buttons.Off") end},
        {ID="GlassCleaner-",x=35+50*4-16, y=45-18*0, w=32,h=20, tooltip="Стеклоочиститель(вниз)",tooltipFunc = function(ent) return ent:GetPackedRatio("GlassCleaner") > 0 and tostring(math.floor(ent:GetPackedRatio("GlassCleaner")*2)) or Metrostroi.GetPhrase("Train.Buttons.Off") end},
        {ID = "EmergencyBrakeTPlusKToggle",         x=35+50*5+4-20, y=45-18*0-4-30, w=40,h=20, tooltip="Крышка кнопки Аварийный тормоз \"Т+\"", model = {
            plomb = {var="EmergencyBrakeTPlusKPl", ID="EmergencyBrakeTPlusKPl",},
            var="EmergencyBrakeTPlusK",speed=8,min=1,max=0, disable="EmergencyBrakeTPlusSet",
            model = "models/metrostroi_train/81-722/button_krishka.mdl", ang = 180, z = 6, x=14.5,y=20,
            noTooltip = true,
        }},
        {ID = "EmergencyBrakeTPlusSet",x=35+50*5+4, y=45-18*0-4, radius=24, tooltip = "Аварийный тормоз \"Т+\"",model = {
            model = "models/metrostroi_train/81-722/button_red.mdl", z=2, ang=180,
            lamp = {model = "models/metrostroi_train/81-722/lamp_red.mdl",var="EmergencyBrakeTPlusL",z=0,anim=true},
            var="EmergencyBrakeTPlus",speed=12,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
            sndmin = 90, sndmax = 1e3,
            tooltipFunc = function(ent) return ent:GetPackedBool("EmergencyBrakeTPlusL") and Metrostroi.GetPhrase("Train.Buttons.AHActive") end
        }},

        {ID = "EmergencyBrakeToggle",x=31+51*5+3, y=45+90*0.5, radius=16, tooltip = "Экстренное торможение",model = {
            model = "models/metrostroi_train/81-722/button_emer.mdl", z=9, ang=180,
            var="EmergencyBrake",speed=12, min=0,max=0.6,
            sndvol = 0.4, snd = function(val) return val and "switch_emer_on" or "switch_emer_off" end,
            sndmin = 90, sndmax = 1e3,
        }},

        {ID = "VigilanceSet",x=31+50*0, y=45+90*1, radius=24, tooltip = "Бдительность",model = {
            model = "models/metrostroi_train/81-722/button_emer_b.mdl", z=9, ang=180,
            var="Vigilance",speed=12,
            sndvol = 0.4, snd = function(val) return val and "switch_kb_on" or "switch_kb_off" end,
            sndmin = 90, sndmax = 1e3,
        }},
        {ID = "Zaglushka",x=31+50*1, y=45+90*1,model = {
            model = "models/metrostroi_train/81-722/zaglushka.mdl", z=5,
        }},
        {ID = "Headlights",x=31+51*2, y=45+90*1, radius=0,model = {
            model = "models/metrostroi_train/81-722/tumbler.mdl", z=2, ang=180,
            getfunc = function(ent) return ent:GetPackedRatio("Headlights") end, var="Headlights",
            speed=8, min=0.0, max=1.0,
            sndvol = 0.4, snd = function(val,val2) return val2 == 1 and "switch_panel_mid" or val and "switch_panel_up" or "switch_panel_down" end,
            sndmin = 90, sndmax = 1e3,
        }},
        {ID="Headlights+",x=31+51*2-16, y=45+90*1-20, w=32,h=20, tooltip="Фары(вверх)",states={"Train.Buttons.Off","Train.Buttons.LNear","Train.Buttons.LFar"},varTooltip = function(ent) return ent:GetPackedRatio("Headlights") end},
        {ID="Headlights-",x=31+51*2-16, y=45+90*1, w=32,h=20, tooltip="Фары(вниз)",states={"Train.Buttons.Off","Train.Buttons.LNear","Train.Buttons.LFar"},varTooltip = function(ent) return ent:GetPackedRatio("Headlights") end},
        {ID = "DoorSelectToggle",x=31+51*3+1, y=45+90*1, radius=16,tooltip="Закрытие дверей",model = {
            model = "models/metrostroi_train/81-722/tumbler.mdl", z=2, ang=90,
            var="DoorSelect",speed=16, min=0.0, max=1.0,
            sndvol = 0.4, snd = function(val,val2) return val and "switch_panel_up" or "switch_panel_down" end,
            sndmin = 90, sndmax = 1e3,
            states={"Train.Buttons.Left","Train.Buttons.Right"}
        }},
        {ID = "DoorClose",x=31+51*4, y=45+90*1, radius=0,model = {
            model = "models/metrostroi_train/81-722/tumbler.mdl", z=2, ang=180,
            getfunc = function(ent) return ent:GetPackedRatio("DoorClose") end, var="DoorClose",
            speed=10,  min=0,max=1,
            sndvol = 0.4, snd = function(val,val2) return val2 == 1 and "switch_panel_mid" or val and "switch_panel_up" or "switch_panel_down" end,
            sndmin = 90, sndmax = 1e3,
        }},
        {ID="DoorClose+",x=31+51*4-16, y=45+90*1-20, w=32,h=20, tooltip="Закрытие дверей(вверх)",states={"Train.Buttons.DoorCloseM","Train.Buttons.Off","Train.Buttons.DoorCloseA"},varTooltip = function(ent) return ent:GetPackedRatio("DoorClose") end},
        {ID="DoorClose-",x=31+51*4-16, y=45+90*1, w=32,h=20, tooltip="Закрытие дверей(вниз)",states={"Train.Buttons.DoorCloseM","Train.Buttons.Off","Train.Buttons.DoorCloseA"},varTooltip = function(ent) return ent:GetPackedRatio("DoorClose") end},
        {ID = "DoorRightSet",x=31+51*5+3, y=45+90*1, radius=16, tooltip = "Открытие правых дверей",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl", z=2, ang=180,
            var="DoorRight",speed=12,
            lamp = {model = "models/metrostroi_train/81-722/lamp_black.mdl",var="DoorRightLamp",z=0, anim=true,
            lcolor=Color(255,255,255),lz = 12,lbright=3,lfov=140,lfar=16,lnear=8,lshadows=0,},
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
            sndmin = 90, sndmax = 1e3,
            sprite = {bright=0.4,size=0.25,scale=0.03,vscale=0.02,color=Color(255,255,255),z=3}
        }},
    }
}

local CompressorPos = {0,0.26,0.46,0.76,1}
ENT.ButtonMap["BI3"] = {
    pos = Vector(479.4,-4,-4), --446 -- 14 -- -0,5
    ang = Angle(0,-90-27,67),
    width = 200,
    height = 200,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "KROToggle",x=53, y=128, radius=0, model = {
            model = "models/metrostroi_train/81-722/tumbler_reversor.mdl",ang = 90, z=8,
            getfunc = function(ent) return ent:GetPackedRatio("ReverserPosition") end,
            var="KRO",speed=4.1, min=0.75,max=0.27,
            sndvol = 0.4, snd = function(val,val2) return val2 == 1 and "multiswitch_panel_mid" or val and "multiswitch_panel_min" or "multiswitch_panel_max" end,
            sndmin = 90, sndmax = 1e3,
        }},
        {ID="KRO+",x=53-16, y=128-16, w=32,h=16, tooltip="Направление движения(вверх)",states = {"Train.Buttons.Back","Train.Buttons.0","Train.Buttons.Forward"},varTooltip = function(ent) return ent:GetPackedRatio("ReverserPosition") end,},
        {ID="KRO-",x=53-16, y=128, w=32,h=16, tooltip="Направление движения(вниз)",states = {"Train.Buttons.Back","Train.Buttons.0","Train.Buttons.Forward"},varTooltip = function(ent) return ent:GetPackedRatio("ReverserPosition") end,},
        {ID = "RingSet",x=127, y=65, radius=16, tooltip = "Звонок",model = {
            model = "models/metrostroi_train/81-722/button_black.mdl", z=2,
            var="Ring",speed=12,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
            sndmin = 90, sndmax = 1e3,
        }},
        {ID = "Compressor",x=78, y=170, radius=0, model = {
            model = "models/metrostroi_train/81-722/tumbler_reversor.mdl",ang = 90, z=8,
            getfunc = function(ent) return CompressorPos[ent:GetPackedRatio("CompressorPosition")+1] end,
            var="Compressor",speed=3, min=0.1,max=0.75,
            sndvol = 0.4, snd = function(val,val2) return val2 == 4 and "multiswitch_panel_max" or not val and "multiswitch_panel_min" or "multiswitch_panel_mid" end,
            sndmin = 90, sndmax = 1e3,
        }},
        {ID="Compressor-",x=78-20, y=170-16, w=20,h=32, tooltip="Компрессоры(-)",states = {"Train.Buttons.Off","Train.Buttons.Auto","Train.Buttons.VTRH1","Train.Buttons.VTRH2","Train.Buttons.VTRAll"},varTooltip = function(ent) return ent:GetPackedRatio("CompressorPosition")/4 end,},
        {ID="Compressor+",x=78, y=170-16, w=20,h=32, tooltip="Компрессоры(+)",states = {"Train.Buttons.Off","Train.Buttons.Auto","Train.Buttons.VTRH1","Train.Buttons.VTRH2","Train.Buttons.VTRAll"},varTooltip = function(ent) return ent:GetPackedRatio("CompressorPosition")/4 end,},

        {ID="!BrakeCylinder",x=65, y=55,radius=35, tooltip="Тормозной цилиндр",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BCPressure"),ent:GetPackedRatio("BCPressure")*6) end},
        {ID="!BrakeTrainLine",x=126, y=128,radius=35, tooltip="Красная - тормозная, чёрная - напорная магистраль",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BLTLPressure"),ent:GetPackedRatio("TLPressure")*16,ent:GetPackedRatio("BLPressure")*16) end},
    }
}

ENT.ButtonMap["PPZ"] = {
    pos = Vector(406+0.55,35,27), --446 -- 14 -- -0,5
    ang = Angle(0,90,90),
    width = 260,
    height = 215,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "SF1Toggle", x=0+15.15*0,  y=40+167*0, w=15,h=45, tooltip="SF1:Бортовая сеть (управление)"},
        {ID = "SF2Toggle", x=0+15.15*1,  y=40+167*0, w=15,h=45, tooltip="SF2:Активная кабина"},
        {ID = "SF3Toggle", x=0+15.15*2,  y=40+167*0, w=15,h=45, tooltip="SF3:Управление основное"},
        {ID = "SF4Toggle", x=0+15.15*3,  y=40+167*0, w=15,h=45, tooltip="SF4:Управление резервное"},
        {ID = "SF5Toggle", x=0+15.15*4,  y=40+167*0, w=15,h=45, tooltip="SF5:Управление РВТБ"},
        {ID = "SF6Toggle", x=0+15.15*5,  y=40+167*0, w=15,h=45, tooltip="SF6:Питание крана машиниста"},
        {ID = "SF7Toggle", x=0+15.15*6,  y=40+167*0, w=15,h=45, tooltip="SF7:Двери(управление)"},
        {ID = "SF8Toggle", x=0+15.15*7,  y=40+167*0, w=15,h=45, tooltip="SF8:БАРС 1"},
        {ID = "SF9Toggle", x=0+15.15*8,  y=40+167*0, w=15,h=45, tooltip="SF9:БАРС 2"},
        {ID = "R_UPOToggle", x=0+15.15*9,  y=40+167*0, w=15,h=45, tooltip="SF: УПО1"},
        {ID = "SF01Toggle", x=0+15.15*10,  y=40+167*0, w=15,h=45, tooltip="SF01:"},
        {ID = "SF10Toggle", x=0+15.15*11,  y=40+167*0, w=15,h=45, tooltip="SF10:БРПИ-М1"},
        {ID = "SF11Toggle", x=0+15.15*12,  y=40+167*0, w=15,h=45, tooltip="SF11:БРПИ-М2"},
        {ID = "SF12Toggle", x=0+15.15*13,  y=40+167*0, w=15,h=45, tooltip="SF12:Пожарная система"},
        {ID = "SF13Toggle", x=0+15.15*14,  y=40+167*0, w=15,h=45, tooltip="SF13:Токоприёмник, короткозамыкатель"},
        {ID = "SF02Toggle", x=0+15.15*15,  y=40+167*0, w=15,h=45, tooltip="SF02:"},

        {ID = "SF14Toggle", x=0+15.15*0,  y=40+125*1, w=15,h=45, tooltip="SF14:Радиосвязь 1"},
        {ID = "SF15Toggle", x=0+15.15*1,  y=40+125*1, w=15,h=45, tooltip="SF15:Радиосвязь 2"},
        {ID = "SF16Toggle", x=0+15.15*2,  y=40+125*1, w=15,h=45, tooltip="SF16:ЦИС 1 (монитор)"},
        {ID = "SF17Toggle", x=0+15.15*3,  y=40+125*1, w=15,h=45, tooltip="SF17:ЦИС 2 (ЦИК)"},
        {ID = "SF18Toggle", x=0+15.15*4,  y=40+125*1, w=15,h=45, tooltip="SF18:ЦИС 3"},
        {ID = "SF19Toggle", x=0+15.15*5,  y=40+125*1, w=15,h=45, tooltip="SF19:БУКП, УПИ"},
        {ID = "SF20Toggle", x=0+15.15*6,  y=40+125*1, w=15,h=45, tooltip="SF20:Монитор"},
        {ID = "SF21Toggle", x=0+15.15*7,  y=40+125*1, w=15,h=45, tooltip="SF21:Ориентация"},
        {ID = "SF22Toggle", x=0+15.15*8,  y=40+125*1, w=15,h=45, tooltip="SF22:Габаритные огни АБ"},
        {ID = "SF23Toggle", x=0+15.15*9,  y=40+125*1, w=15,h=45, tooltip="SF23:Фары, габаритные огни"},
        {ID = "SF24Toggle", x=0+15.15*10,  y=40+125*1, w=15,h=45, tooltip="SF24:СОСД"},
        {ID = "SF25Toggle", x=0+15.15*11,  y=40+125*1, w=15,h=45, tooltip="SF25:Освещение кабины"},
        {ID = "SF26Toggle", x=0+15.15*12,  y=40+125*1, w=15,h=45, tooltip="SF26:Кондиционер кабины"},
        {ID = "SF27Toggle", x=0+15.15*13,  y=40+125*1, w=15,h=45, tooltip="SF27:Стеклоочиститель, омыватель, гудок"},
        {ID = "SF03Toggle", x=0+15.15*14,  y=40+125*1, w=15,h=45, tooltip="SF03:"},
        {ID = "SF04Toggle", x=0+15.15*15,  y=40+125*1, w=15,h=45, tooltip="SF04:"},

    }
}
for i,button in pairs(ENT.ButtonMap.PPZ.buttons) do
    --if button.ID:sub(1,2) == "SF" then
        button.model = {
            model = "models/metrostroi_train/81-722/av1.mdl", z=-8,
            var=button.ID:Replace("Toggle",""),speed=8, ang=Angle(90,0,180),
            min=0, max=1,
            sndvol = 0.2, snd = function(val) return val and "sf_on" or "sf_off" end,
            sndmin = 90, sndmax = 1e3,
        }
    --end
end
ENT.ButtonMap["PVZ"] = {
    pos = Vector(-460.5,28,-12), --446 -- 14 -- -0,5
    ang = Angle(0,90-11,90),
    width = 137,
    height = 450,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "SF31Toggle", x=0+15.15*0,  y=40+167*0, w=15,h=45, tooltip="SF31:Поездной питающий провод"},
        {ID = "1:SF31Toggle", x=0+15.15*1,  y=40+167*0, w=15,h=45, tooltip="SF31:Поездной питающий провод"},
        {ID = "SF32Toggle", x=0+15.15*2,  y=40+167*0, w=15,h=45, tooltip="SF32:Бортовая сеть управление"},
        {ID = "SF33Toggle", x=0+15.15*3,  y=40+167*0, w=15,h=45, tooltip="SF33:Питание цепей управленяи"},
        {ID = "SF34Toggle", x=0+15.15*4,  y=40+167*0, w=15,h=45, tooltip="SF34:ЦИС левый"},
        {ID = "SF35Toggle", x=0+15.15*5,  y=40+167*0, w=15,h=45, tooltip="SF35:ЦИС правый"},
        {ID = "SF36Toggle", x=0+15.15*6,  y=40+167*0, w=15,h=45, tooltip="SF36:Бортовая сигнализация"},
        {ID = "SF37Toggle", x=0+15.15*7,  y=40+167*0, w=15,h=45, tooltip="SF37:Отжатие токоприёмников"},
        {ID = "SF38Toggle", x=0+15.15*8,  y=40+167*0, w=15,h=45, tooltip="SF38:Резерв"},

        {ID = "SF41Toggle", x=0+15.15*0,  y=40+167*1, w=15,h=45, tooltip="SF41:Двери открытие левые"},
        {ID = "SF42Toggle", x=0+15.15*1,  y=40+167*1, w=15,h=45, tooltip="SF42:Двери открытие правые"},
        {ID = "SF43Toggle", x=0+15.15*2,  y=40+167*1, w=15,h=45, tooltip="SF43:Двери закрытие"},
        {ID = "SF44Toggle", x=0+15.15*3,  y=40+167*1, w=15,h=45, tooltip="SF44:Двери торцевые"},
        {ID = "SF45Toggle", x=0+15.15*4,  y=40+167*1, w=15,h=45, tooltip="SF45:Освещение салона питание"},
        {ID = "SF46Toggle", x=0+15.15*5,  y=40+167*1, w=15,h=45, tooltip="SF46:Освещение салона аварийное"},
        {ID = "SF47Toggle", x=0+15.15*6,  y=40+167*1, w=15,h=45, tooltip="SF47:Вентиляция 1 группа"},
        {ID = "SF48Toggle", x=0+15.15*7,  y=40+167*1, w=15,h=45, tooltip="SF48:Вентиляция 2 группа"},
        {ID = "SF49Toggle", x=0+15.15*8,  y=40+167*1, w=15,h=45, tooltip="SF49:Счётчик"},

        {ID = "SF51Toggle", x=0+15.15*0,  y=40+167*2, w=15,h=45, tooltip="SF51:БУВ"},
        {ID = "SF52Toggle", x=0+15.15*1,  y=40+167*2, w=15,h=45, tooltip="SF52:БОДВ"},
        {ID = "SF53Toggle", x=0+15.15*2,  y=40+167*2, w=15,h=45, tooltip="SF53:ПСН"},
        {ID = "SF54Toggle", x=0+15.15*3,  y=40+167*2, w=15,h=45, tooltip="SF54:Осушитель"},
        {ID = "SF55Toggle", x=0+15.15*4,  y=40+167*2, w=15,h=45, tooltip="SF55:БУФТ"},
        {ID = "SF56Toggle", x=0+15.15*5,  y=40+167*2, w=15,h=45, tooltip="SF56:Инвертор инвертор"},
        {ID = "SF57Toggle", x=0+15.15*6,  y=40+167*2, w=15,h=45, tooltip="SF57:Инвертор обогрев"},
        {ID = "SF58Toggle", x=0+15.15*7,  y=40+167*2, w=15,h=45, tooltip="SF58:ЦУВ основное"},
        {ID = "SF59Toggle", x=0+15.15*8,  y=40+167*2, w=15,h=45, tooltip="SF59:ЦУВ резервное"},
    }
}
for i,button in pairs(ENT.ButtonMap.PVZ.buttons) do
    --if button.ID:sub(1,2) == "SF" then
        button.model = {
            model = "models/metrostroi_train/81-722/av1.mdl", z=-8,
            var=button.ID:Replace("Toggle",""):Replace("1:",""),speed=16, ang=Angle(90,0,180),
            min=0, max=1,
            sndvol = 0.2, snd = function(val) return val and "sf_on" or "sf_off" end,
            sndmin = 90, sndmax = 1e3,
        }
    --end
end
ENT.ButtonMap["PPZB"] = {
    pos = Vector(406+0.2,45.4,3.2), --446 -- 14 -- -0,5
    ang = Angle(0,90,90),
    width = 130,
    height = 110,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "PSNToggleSet", x=24+40*0 , y=26 + 60*0, radius=20, tooltip="Зарядка АКБ", model = {
            model = "models/metrostroi_train/81-722/button_blue.mdl",
            var="PSNToggle",speed=12, min=0,max=0.6,
            lamp = {model = "models/metrostroi_train/81-722/lamp_blue.mdl",var="PSNEnabled",z=0,anim=true},
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
            sndmin = 90, sndmax = 1e3,
        }},
        {ID = "BattOnSet", x=24+40*1 , y=26 + 60*0, radius=20, tooltip="Включение источника питания бортовой сети", model = {
            model = "models/metrostroi_train/81-722/button_green.mdl",
            var="BattOn",speed=12, min=0,max=0.6,
            lamp = {model = "models/metrostroi_train/81-722/lamp_green.mdl",var="BattOnL",z=0,anim=true,
            lcolor=Color(60,255,40),lz = 12,lbright=3,lfov=130,lfar=16,lnear=8,lshadows=0,},
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
            sndmin = 90, sndmax = 1e3,
            sprite = {bright=0.4,size=0.25,scale=0.03,vscale=0.02,color=Color(60,255,40),z=3},
            tooltipFunc = function(ent) return ent:GetPackedBool("BattOnL") and Metrostroi.GetPhrase("Train.Buttons.BattOn") end
        }},
        {ID = "BattOffSet", x=24+40*2 , y=26 + 60*0, radius=20, tooltip="Отключение источника питания бортовой сети", model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl",
            var="BattOff",speed=12, min=0,max=0.6,
            lamp = {model = "models/metrostroi_train/81-722/lamp_yellow.mdl",var="BattOffL",z=0,anim=true,
            lcolor=Color(255,255,60),lz = 12,lbright=3,lfov=130,lfar=16,lnear=8,lshadows=0,},
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
            sndmin = 90, sndmax = 1e3,
            sprite = {bright=0.4,size=0.25,scale=0.03,vscale=0.02,color=Color(255,255,60),z=3},
            tooltipFunc = function(ent) return ent:GetPackedBool("BattOffL") and Metrostroi.GetPhrase("Train.Buttons.BattOff") end
        }},
        {ID = "TorecDoorUnlockSet", x=24+40*0 , y=26 + 60*1, radius=20, tooltip="Разблокировка торцевых дверей", model = {
            model = "models/metrostroi_train/81-722/button_black.mdl",
            var="TorecDoorUnlock",speed=12, min=0,max=0.6,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
            sndmin = 90, sndmax = 1e3,
        }},
        {ID = "SCEnable", x=24+40*1 , y=26 + 60*1, radius=20, tooltip="Короткозамыкатель", model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl",
            lamp = {model = "models/metrostroi_train/81-722/lamp_yellow.mdl",var="SCEnable",
            lcolor=Color(255,255,60),lz = 12,lbright=3,lfov=130,lfar=16,lnear=8,lshadows=0}
        }},
        {ID = "SOSD", x=24+40*2 , y=26 + 60*1, radius=20, tooltip="СОСД", model = {
            model = "models/metrostroi_train/81-722/button_white.mdl",
            lamp = {model = "models/metrostroi_train/81-722/lamp_black.mdl",var="SOSDLamp",
            lcolor=Color(255,255,255),lz = 12,lbright=3,lfov=130,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.4,size=0.25,scale=0.03,vscale=0.02,color=Color(255,255,255),z=3}
        }},

    }
}

ENT.ButtonMap["PVM"] = {
    pos = Vector(406.5,32.4,-6), --446 -- 14 -- -0,5
    ang = Angle(0,90,90),
    width = 325,
    height = 120,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "PassLightToggle", x=20+47*0,  y=34+65*0, radius=14, tooltip="Освещение салона"},
        {ID = "PassVent", x=20+47*1,  y=34+65*0, radius=0},
        {ID="PassVent-",x=20+47*1-16, y=34+65*0-16, w=16,h=32, tooltip="Вентиляция салона(-)",varTooltip = function(ent) return ent:GetPackedRatio("PassVent") end,states = {"Train.Buttons.VentEmer","Train.Buttons.Off","Train.Buttons.VentAuto","Train.Buttons.Vent1/2","Train.Buttons.VentAll"}},
        {ID="PassVent+",x=20+47*1, y=34+65*0-16, w=16,h=32, tooltip="Вентиляция салона(+)",varTooltip = function(ent) return ent:GetPackedRatio("PassVent") end,states = {"Train.Buttons.VentEmer","Train.Buttons.Off","Train.Buttons.VentAuto","Train.Buttons.Vent1/2","Train.Buttons.VentAll"}},
        --{ID = "Switch3", x=20+48*2,  y=15+70*0, radius=15, tooltip="SF1:"},
        {ID = "VKFToggle", x=20+47*3,  y=34+65*0, radius=14, tooltip="ВКФ"},
        {ID = "ParkingBrakeToggle", x=20+47*4,  y=34+65*0, radius=14, tooltip="Стояночный тормоз"},
        {ID = "VRDToggle", x=20+47*5,  y=34+65*0, radius=14, tooltip="ВРД"},
        {ID = "SOSDEnableToggle", x=20+47*6,  y=34+65*0, radius=14, tooltip="СОСД"},

        {ID = "VRU", x=20+47*0,  y=34+65*1, radius=0},
        {ID="VRU-",x=20+47*0-16, y=34+65*1-16, w=16,h=32, tooltip="ВРУ(-)",varTooltip = function(ent) return ent:GetPackedRatio("VRU") end,states = {"Train.Buttons.VRUAH","Train.Buttons.0","Train.Buttons.VRUOn"}},
        {ID="VRU+",x=20+47*0, y=34+65*1-16, w=16,h=32, tooltip="ВРУ(+)",varTooltip = function(ent) return ent:GetPackedRatio("VRU") end,states = {"Train.Buttons.VRUAH","Train.Buttons.0","Train.Buttons.VRUOn"}},
        {ID = "VADToggle", x=20+47*1,  y=34+65*1, radius=15, tooltip="Движение без контроля дверей"},
        {ID = "VAHToggle", x=20+47*2,  y=34+65*1, radius=15, tooltip="Движение без педали бдительности"},
        {ID = "EmergencyRadioPowerToggle", x=20+47*3,  y=34+65*1, radius=15, tooltip="Аварийное питание радиостанции"},
        {ID = "BARSMode", x=20+47*4,  y=34+65*1, radius=0},
        {ID="BARSMode-",x=20+47*4-16, y=34+65*1-16, w=16,h=32, tooltip="Режимы БАРС(влево)",varTooltip = function(ent) return ent:GetPackedRatio("BARSMode") end,states = {"Train.Buttons.BARS1","Train.Buttons.0","Train.Buttons.BARS2"}},
        {ID="BARSMode+",x=20+47*4, y=34+65*1-16, w=16,h=32, tooltip="Режимы БАРС(вправо)",varTooltip = function(ent) return ent:GetPackedRatio("BARSMode") end,states = {"Train.Buttons.BARS1","Train.Buttons.0","Train.Buttons.BARS2"}},
        {ID = "PantSC", x=20+47*5,  y=34+65*1, radius=0},
        {ID="PantSC-",x=20+47*5-16, y=34+65*1-16, w=16,h=32, tooltip="Токоприёмники и короткозамыкатель(-)",varTooltip = function(ent) return ent:GetPackedRatio("PantSC") end,states = {"Train.Buttons.PantSC","Train.Buttons.VTRAll","Train.Buttons.VTRH1","Train.Buttons.VTRH2","Train.Buttons.Off"}},
        {ID="PantSC+",x=20+47*5, y=34+65*1-16, w=16,h=32, tooltip="Токоприёмники и короткозамыкатель(+)",varTooltip = function(ent) return ent:GetPackedRatio("PantSC") end,states = {"Train.Buttons.PantSC","Train.Buttons.VTRAll","Train.Buttons.VTRH1","Train.Buttons.VTRH2","Train.Buttons.Off"}},
        {ID = "RCARSToggle", x=20+47*6,  y=34+65*1, radius=15, tooltip="РЦ АРС"},

    }
}
local spec = {
    PassLight = {0.6,0.5},
    PassVent = {0.2,0.8,true},
    SOSDEnable = {0.6,0.5},
    VRU = {0.35,0.65,true},
    BARSMode = {0.35,0.65,true},
    PantSC = {0.34,0.995,true},
    RCARS = {0.6,0.5},
}
local snds = {
    PassVent = 4,
    BARSMode = 3,
    PantSC = 4,
}
local plombs = {
    ["VRU"] = "VRUPl",
    ["VRU-"] = "VRUPl",
    ["VRU+"] = "VRUPl",
    ["VADToggle"] = "VADPl",
    ["VAHToggle"] = "VAHPl",
    ["EmergencyRadioPowerToggle"] = "EmergencyRadioPowerPl",
    ["BARSMode"] = "BARSModePl",
    ["BARSMode-"] = "BARSModePl",
    ["BARSMode+"] = "BARSModePl",
    ["PantSC"] = "PantSCPl",
    ["PantSC-"] = "PantSCPl",
    ["PantSC+"] = "PantSCPl",
    ["RCARSToggle"] = "RCARSPl",

}
for i,button in pairs(ENT.ButtonMap.PVM.buttons) do
    if not button.ID:find("[+-]$") then
        local tbl = spec[button.ID:Replace("Toggle","")]
        button.model = {
            model = "models/metrostroi_train/81-722/tumbler_reversor.mdl",
            var=button.ID:Replace("Toggle",""),
            speed=8, min=0.5,max=0.6, z=6, ang=-182
        }
        if tbl then
            button.model.min = tbl[1]
            button.model.max = tbl[2]
            button.model.speed = 2/math.abs(tbl[1]-tbl[2])
            if tbl[3] then
                local id = button.model.var
                button.model.getfunc = function(ent)  return ent:GetPackedRatio(id) end
            end
        end
        local stbl = snds[button.ID:Replace("Toggle","")]
        if stbl then
            local mx = stbl
            button.model.snd = function(val,val2) return val2 == mx and "multiswitch_panel_max" or not val and "multiswitch_panel_min" or "multiswitch_panel_mid" end
        elseif tbl and tbl[1] == 0.6 then
            button.model.snd = function(val) return val and "multiswitch_panel_min" or "multiswitch_panel_max" end
        else
            button.model.snd = function(val) return val and "multiswitch_panel_max" or "multiswitch_panel_min" end
        end
        button.model.sndvol = 0.5
        button.model.sndmin = 90
        button.model.sndmax = 1e3
    end
    if plombs[button.ID] then
        if not button.model then
            button.model = {plomb = {var=plombs[button.ID], ID=plombs[button.ID], }}
        else
            button.model.plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=-90,x=0,y=40,z=-10,var=plombs[button.ID], ID=plombs[button.ID],}
        end
    end
end
ENT.ButtonMap["BTO"] = {
    pos = Vector(458,56.5,-61), --446 -- 14 -- -0,5
    ang = Angle(0,0,0),
    width = 270,
    height = 50,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "K29Toggle", x=24,  y=26, radius=25, tooltip="КРМШ", model = {
            model = "models/metrostroi_train/81-722/81-722_kran_krmh.mdl", ang=Angle(0,0,180),
            var="K29",speed=4, max=0.5,
            states={"Train.Buttons.Closed","Train.Buttons.Opened"}
        }},
        {ID = "K9Toggle", x=240,  y=15, radius=25, tooltip="РВТБ", model = {
            model = "models/metrostroi_train/81-722/81-722_kran_krmh.mdl", ang=Angle(0,0,180),
            plomb = {var="K9Pl", ID="K9Pl", },
            var="K9",speed=4, min=0.5,max=0,
            states={"Train.Buttons.Closed","Train.Buttons.Opened"}
        }},

    }
}


ENT.ButtonMap["Isolations"] = {
    pos = Vector(407.25,36,-61), --446 -- 14 -- -0,5
    ang = Angle(0,90,0),
    width = 270,
    height = 50,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "FrontBrakeLineIsolationToggle", x=21,  y=28, radius=25, tooltip="Концевой кран тормозной магистрали", model = {
            model = "models/metrostroi_train/81-722/81-722_kran_tm.mdl", ang=Angle(0,0,180),
            var="FrontBrakeLineIsolation",speed=4, min=0.25,max=0,
            states={"Train.Buttons.Opened","Train.Buttons.Closed"}
        }},
        {ID = "FrontTrainLineIsolationToggle", x=219,  y=23, radius=25, tooltip="Концевой кран напорной магистрали", model = {
            model = "models/metrostroi_train/81-722/81-722_kran_nm.mdl", ang=Angle(0,0,180),
            var="FrontTrainLineIsolation",speed=4, min=0.25,max=0,
            states={"Train.Buttons.Opened","Train.Buttons.Closed"}
        }},

    }
}
ENT.ButtonMap["RearPneumatic"] = {
    pos = Vector(-473,45.0,-58.0),
    ang = Angle(0,270,90),
    width = 900,
    height = 100,
    scale = 0.1,

    buttons = {
        {ID = "RearBrakeLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip="",var="RbI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
        {ID = "RearTrainLineIsolationToggle",x=500, y=0, w=400, h=100, tooltip="",var="RtI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
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

ENT.ButtonMap["StopKran"] = {
    pos = Vector(419,-56.5,5), --446 -- 14 -- -0,5
    ang = Angle(0,95,90),
    width = 190,
    height = 200,
    scale = 0.0625,

    buttons = {
        {ID = "UAVAToggle", x=0,  y=0, w=95,h=200, tooltip="Выключатель автостопа",model = {
            plomb = {var="UAVAPl", ID="UAVAPl", },
        }},
        {ID = "EmergencyBrakeValveToggle", x=95,  y=0, w=95,h=200, tooltip="Стопкран", tooltip="",tooltip="",states={"Train.Buttons.Closed","Train.Buttons.Opened"},var="EmergencyBrakeValve"},

    }
}
ENT.ClientProps["UAVA"] = {
    model = "models/metrostroi_train/81-722/81-722_kran.mdl",
    pos = Vector(418.9,-56.14,1.5),
    ang = Angle(0,-111,0),
    hide=0.8,
}
ENT.ClientProps["EmergencyBrakeValve"] = {
    model = "models/metrostroi_train/81-722/81-722_autostop.mdl",
    pos = Vector(418.25,-49.2,1.3),
    ang = Angle(0,-90,0),
    hide=0.8,
}

ENT.ButtonMap["Lighting"] = {
    pos = Vector(458.03,46,-23), --446 -- 14 -- -0,5
    ang = Angle(0,-90,90),
    width = 205,
    height = 50,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "CabinLightToggle", x=70,  y=30, radius=nil, model = {
            model = "models/metrostroi_train/81-722/button_rot.mdl", ang=45,
            getfunc = function(ent) return ent:GetPackedRatio("CabinLight") end,
            var="CabinLight",speed=4.1, min=0,max=0.27,
            sndvol = 0.4, snd = function(val,val2) return val2 == 1 and "multiswitch_panel_mid" or val and "multiswitch_panel_min" or "multiswitch_panel_max" end,
            sndmin = 90, sndmax = 1e3,
        }},
        {ID="CabinLight-",x=60-8, y=15, w=20,h=30, tooltip="Освещение кабины(влево)"},
        {ID="CabinLight+",x=60+8, y=15, w=20,h=30, tooltip="Освещение кабины(вправо)"},
        {ID = "PanelLightToggle", x=140,  y=30, radius=15, tooltip="Освещение пульта", model = {
            model = "models/metrostroi_train/81-722/button_rot.mdl", ang=45,
            var="PanelLight",speed=8.2, min=0,max=0.27,
            sndvol = 0.4, snd = function(val,val2) return val and "multiswitch_panel_max" or "multiswitch_panel_min" end,
            sndmin = 90, sndmax = 1e3,
        }},

    }
}
ENT.ButtonMap["HelperLamps"] = {
    pos = Vector(476,22.4,-12),
    ang = Angle(0,-90,66.5),
    width = 125,
    height = 40,
    scale = 0.0625,
    buttons = {
        {ID="!LRD",x=0, y=5,w=15,h=10, tooltip="ЛРД: Лампа разрешающая движение(разрешение движения под 0)",model = {
            name="lamp_lrd",lamp = {speed=10,model = "models/metrostroi_train/81-722/lamp_lrd.mdl",z=7.7,ang=Angle(0,0,90),var="LampLRD"},
            sprite = {bright=0.3,size=0.15,scale=0.03,vscale=0.02,color=Color(20,250,20),z=7.7}
        }},
        {ID="!LPT",x=21*1, y=5,w=15,h=10, tooltip="ЛПТ: Лампа включение пневмотормоза",model = {
            name="lamp_lpt",lamp = {speed=10,model = "models/metrostroi_train/81-722/lamp_lpt.mdl",z=7.7,ang=Angle(0,0,90),var="LampLPT"},
            sprite = {bright=0.3,size=0.15,scale=0.03,vscale=0.02,color=Color(250,250,20),z=7.7}
        }},
        {ID="!RS",x=21*2, y=5,w=15,h=10, tooltip="Р/С: Лампа аварийного питания радиостанции",model = {
            name="lamp_rc",lamp = {speed=10,model = "models/metrostroi_train/81-722/lamp_rc.mdl",z=7.7,ang=Angle(0,0,90),var="LampRC"},
            sprite = {bright=0.3,size=0.15,scale=0.03,vscale=0.02,color=Color(250,120,20),z=7.7}
        }},
        {ID="!AVS",x=21*3, y=5,w=15,h=10, tooltip="АВС Лампа низкого давления ТМ",model = {
            name="lamp_abc",lamp = {speed=10,model = "models/metrostroi_train/81-722/lamp_abc.mdl",z=7.7,ang=Angle(0,0,90),var="LampAVS"},
            sprite = {bright=0.3,size=0.15,scale=0.03,vscale=0.02,color=Color(250,120,20),z=7.7}
        }},
        {ID="!LSD",x=21*4, y=5,w=15,h=10, tooltip="ЛСД: Лампа сигнализации закрытия дверей",model = {
            name="lamp_lsd",lamp = {speed=10,model = "models/metrostroi_train/81-722/lamp_lsd.mdl",z=7.7,ang=Angle(0,0,90),var="LampSD"},
            sprite = {bright=0.3,size=0.15,scale=0.03,vscale=0.02,color=Color(250,250,250),z=7.7}
        }},
        {ID="!RU",x=21*5, y=5,w=15,h=10, tooltip="РУ: Лампа выключения Реле Управления",model = {
            name="lamp_ru",lamp = {speed=10,model = "models/metrostroi_train/81-722/lamp_ru.mdl",z=7.7,ang=Angle(0,0,90),var="LampRU"},
            sprite = {bright=0.3,size=0.15,scale=0.03,vscale=0.02,color=Color(250,120,20),z=7.7}
        }},

        {ID="!04",x=0, y=23,w=15,h=10, tooltip="НЧ: Лампа отсутствия частоты (0км\\ч)",model = {
            name="lamp_nch",lamp = {speed=10,model = "models/metrostroi_train/81-722/lamp_nch.mdl",z=7.7,ang=Angle(0,0,90),var="Lamp04"},
            sprite = {bright=0.3,size=0.15,scale=0.03,vscale=0.02,color=Color(250,120,20),z=7.7}
        }},
        {ID="!00",x=21*1, y=23,w=15,h=10, tooltip="0: Лампа ограничения в 0км\\ч",model = {
            name="lamp_0",lamp = {speed=10,model = "models/metrostroi_train/81-722/lamp_0.mdl",z=7.7,ang=Angle(0,0,90),var="Lamp0"},
            sprite = {bright=0.3,size=0.15,scale=0.03,vscale=0.02,color=Color(250,120,20),z=7.7}
        }},
        {ID="!40",x=21*2, y=23,w=15,h=10, tooltip="40: Лампа ограничения в 40км\\ч",model = {
            name="lamp_40",lamp = {speed=10,model = "models/metrostroi_train/81-722/lamp_40.mdl",z=7.7,ang=Angle(0,0,90),var="Lamp40"},
            sprite = {bright=0.3,size=0.15,scale=0.03,vscale=0.02,color=Color(250,250,20),z=7.7}
        }},
        {ID="!60",x=21*3, y=23,w=15,h=10, tooltip="60 Лампа ограничения в 60км\\ч",model = {
            name="lamp_60",lamp = {speed=10,model = "models/metrostroi_train/81-722/lamp_60.mdl",z=7.7,ang=Angle(0,0,90),var="Lamp60"},
            sprite = {bright=0.3,size=0.15,scale=0.03,vscale=0.02,color=Color(20,250,20),z=7.7}
        }},
        {ID="!70",x=21*4, y=23,w=15,h=10, tooltip="70: Лампа ограничения в 70км\\ч",model = {
            name="lamp_70",lamp = {speed=10,model = "models/metrostroi_train/81-722/lamp_70.mdl",z=7.7,ang=Angle(0,0,90),var="Lamp70"},
            sprite = {bright=0.3,size=0.15,scale=0.03,vscale=0.02,color=Color(20,250,20),z=7.7}
        }},
        {ID="!80",x=21*5, y=23,w=15,h=10, tooltip="80: Лампа ограничения в 80км\\ч",model = {
            name="lamp_80",lamp = {speed=10,model = "models/metrostroi_train/81-722/lamp_80.mdl",z=7.7,ang=Angle(0,0,90),var="Lamp80"},
            sprite = {bright=0.3,size=0.15,scale=0.03,vscale=0.02,color=Color(20,250,20),z=7.7}
        }},
    }
}

ENT.ButtonMap["PassengerDoor"] = {
    pos = Vector(380,-46,40), --28
    ang = Angle(0,90,90),
    width = 730,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=730,h=2000, tooltip="Дверь в кабину машиниста из салона\nPass door", model = {
            var="PassengerDoor",sndid="door_cab_m",
            sndvol = 1, snd = function(val) return val and "door_cab_open" or "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
ENT.ButtonMap["PassengerDoor1"] = {
    pos = Vector(380,-46+36.5,40), --28
    ang = Angle(0,-90,90),
    width = 730,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=730,h=2000, tooltip="Дверь в кабину машиниста из салона\nPass door"},
    }
}
ENT.ButtonMap["CabinDoorL"] = {
    pos = Vector(420,64,40),
    ang = Angle(0,0,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoorLeft",x=0,y=0,w=642,h=2000, tooltip="Дверь в кабину машиниста\nCabin door", model = {
            var="CabinDoorLeft",sndid="door_cab_l",
            sndvol = 1, snd = function(val) return val and "door_cab_open" or "door_cab_close" end,
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
            sndvol = 1, snd = function(val) return val and "door_cab_open" or "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
ENT.ButtonMap["RearDoor"] = {
    pos = Vector(-468,-17,41.3), --28
    ang = Angle(0,90,90),
    width = 680,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=680,h=2000, tooltip="Задняя дверь\nFront door", model = {
            var="RearDoor",sndid="door_cab_t",
            sndvol = 1, snd = function(val) return val and "door_cab_open" or "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
for i=0,4 do
    ENT.ClientProps["TrainNumberL"..i] = {
        model = "models/metrostroi_train/81-714_mmz/bortnumber_" .. i .. ".mdl",
        pos = Vector(60+i*6.6-4*6.6/2,66.3,18),
        ang = Angle(-5,90,0),
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end
for i=0,4 do
    ENT.ClientProps["TrainNumberR"..i] = {
        model = "models/metrostroi_train/81-714_mmz/bortnumber_" .. i .. ".mdl",
        pos = Vector(53-i*6.6+4*6.6/2,-66.3,18),
        ang = Angle(-5,270,0),
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end
--[[ ENT.ClientProps["controller"] = {
    model = "models/metrostroi_train/81-722/kv.mdl",
    pos = Vector(466.7,0.5,-16.22),
    ang = Angle(0,-90,13),
    hideseat = 0.2,
}--]]
ENT.ClientProps["controller"] = {
    model = "models/metrostroi_train/81-722/81-722_controller.mdl",
    pos = Vector(466.7,0.2,-16.9),
    ang = Angle(0,90,-6),
    hide = 2,
}
ENT.ClientProps["km013"] = {
    model = "models/metrostroi_train/81-722/km013.mdl",
    pos = Vector(461.15,-9.6,-20.9),
    ang = Angle(30,-13,90),
    hideseat = 0.2,
}
ENT.ClientProps["PB"] = {
    model = "models/metrostroi_train/81-720/720_pb.mdl",
    pos = Vector(477.101044,3.367028,-35.271423),
    ang = Angle(0.000000,-90.000000,7.500821),
    hideseat = 0.2,
}
if not ENT.ClientSounds["br_013"] then ENT.ClientSounds["br_013"] = {} end
table.insert(ENT.ClientSounds["br_013"],{"km013",function(ent,_,var) return "br_013" end,0.7,1,50,1e3,Angle(-90,0,0)})
if not ENT.ClientSounds["PB"] then ENT.ClientSounds["PB"] = {} end
table.insert(ENT.ClientSounds["PB"],{"PB",function(ent,var) return var > 0 and "pb_on" or "pb_off" end,0.5,1,50,1e3,Angle(-90,0,0)})

ENT.ClientProps["brake_cylinder"] = {
    model = "models/metrostroi_train/81-722/arrow_b.mdl",
    pos = Vector(476.615895,-7.037693,-7.269770),
    ang = Angle(65.500000,-180.000000,24.549999),
    hideseat = 0.2,
}
ENT.ClientProps["train_line"] = {
    model = "models/metrostroi_train/81-722/arrow_b.mdl",
    pos = Vector(473.217255+0.08,-9.719269,-11.526619),
    ang = Angle(65.500000,-180.000000,24.549999),
    hideseat = 0.2,
}
ENT.ClientProps["brake_line"] = {
    model = "models/metrostroi_train/81-722/arrow_r.mdl",
    pos = Vector(473.199066+0.08,-9.710060,-11.518258),
    ang = Angle(65.500000,-180.000000,24.549999),
    hideseat = 0.2,
}
ENT.ClientProps["volt_lv"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(407.372620,6.614372,16.246759),
    hideseat = 0.2,
    ang = Angle(35,90.000000,90.000000),
}
ENT.ClientProps["volt_hv"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(407.372620,6.614372,11.339066),
    ang = Angle(35,90.000000,90.000000),
    hideseat = 0.2,
}
ENT.ClientProps["salon"] = {
    model = "models/metrostroi_train/81-722/722_salon1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}

ENT.ClientProps["cabine"] = {
    model = "models/metrostroi_train/81-722/722_cabine.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["led"] = {
    model = "models/metrostroi_train/81-722/led_reflect.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["underwagon"] = {
    model = "models/metrostroi_train/81-722/722_underwagon.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["sarmat"] = {
    model = "models/metrostroi_train/81-722/722_sarmat_l.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 1.5,
    callback = function(ent)
        ent.PassSchemesDone = false
    end,
}
ENT.ClientProps["sarmatr"] = {
    model = "models/metrostroi_train/81-722/722_sarmat_r.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 1.5,
    callback = function(ent)
        ent.PassSchemesDone = false
    end,
}
ENT.ClientProps["HeadLights"] = {
    model = "models/metrostroi_train/81-722/722_headlight.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["HeadLightsH"] = {
    model = "models/metrostroi_train/81-722/722_headlight_half.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["RedLights"] = {
    model = "models/metrostroi_train/81-722/722_hred.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}

for i=1,4 do
    ENT.ClientProps["led_l_f"..i] = {
        model = "models/metrostroi_train/81-722/722_led_l_r.mdl",
        pos = Vector((i-1)*9.15,0,0),
        ang = Angle(0,0,0),
        skin=0,
        hideseat = 1.5,
    }
    ENT.ClientProps["led_l_b"..i] = {
        model = "models/metrostroi_train/81-722/722_led_l.mdl",
        pos = Vector(0.1-(i-1)*9.15,0,0),
        ang = Angle(0,0,0),
        skin=0,
        hideseat = 1.5,
    }

    ENT.ClientProps["led_r_f"..i] = {
        model = "models/metrostroi_train/81-722/722_led_r.mdl",
        pos = Vector(-0.2+(i-1)*9.15,0,0),
        ang = Angle(0,0,0),
        skin=0,
        hideseat = 1.5,
    }
    ENT.ClientProps["led_r_b"..i] = {
        model = "models/metrostroi_train/81-722/722_led_r_r.mdl",
        pos = Vector(-0.2-(i-1)*9.15,0,0),
        ang = Angle(0,0,0),
        skin=0,
        hideseat = 1.5,
    }
end

ENT.ClientProps["doorl_l"] = {
    model = "models/metrostroi_train/81-722/722_doorlamp_l.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2,
}
ENT.ClientProps["doorl_r"] = {
    model = "models/metrostroi_train/81-722/722_doorlamp_r.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2,
}

ENT.ClientProps["bortlamp_lsd"] = {
    model = "models/metrostroi_train/81-722/722_bortlamp1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamp_pneumo"] = {
    model = "models/metrostroi_train/81-722/722_bortlamp2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamp_bv"] = {
    model = "models/metrostroi_train/81-722/722_bortlamp3.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["fireextinguisher"] = {
    model = "models/metrostroi_train/81-502/fireextinguisher.mdl",
    pos = Vector(64,6,-8),
    ang = Angle(0,0,0),
    hideseat = 1,
}

ENT.ClientProps["lamps_salon"] = {
    model = "models/metrostroi_train/81-722/722_lamps_full.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 1.5,
}

ENT.ClientProps["lamps_cab_e"] = {
    model = "models/metrostroi_train/81-722/722_lamps_cab1.mdl",
    pos = Vector(0,0,-0.01),
    ang = Angle(0,0,0),
    hideseat = 0.8,
}
ENT.ClientProps["lamps_cab_f"] = {
    model = "models/metrostroi_train/81-722/722_lamps_cab2.mdl",
    pos = Vector(0,0,-0.01),
    ang = Angle(0,0,0),
    hideseat = 0.8,
}

ENT.ClientProps["rvs"] = {
    model = "models/metrostroi_train/81-722/722_rvclight.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(255,200,150),
    hideseat = 0.8,
}
ENT.ClientProps["otsek1"] = {
    model = "models/metrostroi_train/81-722/81-722_otsek1.mdl",
    pos = Vector(-454,-54.6,-29.2),
    ang = Angle(0,-90,0),
    hideseat=1.7,
}
ENT.ClientProps["otsek2"] = {
    model = "models/metrostroi_train/81-722/81-722_otsek2.mdl",
    pos = Vector(-454,54.4,-29.2),
    ang = Angle(0,-90,0),
    hideseat=1.7,
}

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
            model = "models/metrostroi_train/81-722/81-722_door_l.mdl",
            pos = GetDoorPosition(i,k,0),
            ang = Angle(0,90 +180*k,0),
            hide = 2,
        }
        ENT.ClientProps["door"..i.."x"..k.."b"] = {
            model = "models/metrostroi_train/81-722/81-722_door_r.mdl",
            pos = GetDoorPosition(i,k,1),
            ang = Angle(0,90 +180*k,0),
            hide = 2,
        }
    end
end--]]
ENT.ClientProps["door0x1"] = {
    model = "models/metrostroi_train/81-722/81-722_doors_pos1.mdl",
    pos = Vector( 341.539,63.171,-11.1),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x1"] = {
    model = "models/metrostroi_train/81-722/81-722_doors_pos2.mdl",
    pos = Vector( 111.38,63.171,-11.1),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x1"] = {
    model = "models/metrostroi_train/81-722/81-722_doors_pos3.mdl",
    pos = Vector(-117.756,63.171,-11.1),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x1"] = {
    model = "models/metrostroi_train/81-722/81-722_doors_pos4.mdl",
    pos = Vector(-348.72,63.171,-11.1),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door0x0"] = {
    model = "models/metrostroi_train/81-722/81-722_doors_pos4.mdl",
    pos = Vector( 341.539,-63.171,-11.1),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x0"] = {
    model = "models/metrostroi_train/81-722/81-722_doors_pos3.mdl",
    pos = Vector( 111.38,-63.171,-11.1),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x0"] = {
    model = "models/metrostroi_train/81-722/81-722_doors_pos2.mdl",
    pos = Vector(-117.756,-63.171,-11.1),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x0"] = {
    model = "models/metrostroi_train/81-722/81-722_doors_pos1.mdl",
    pos = Vector(-348.72,-63.171,-11.1),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door_cab_m"] = {
    model = "models/metrostroi_train/81-722/81-722_door_cab_m.mdl",
    pos = Vector(377.9,-45.5,-10.75),
    ang = Angle(0,-90+0.45,-0.15),
    hide=2,
}
ENT.ClientProps["door_cab_l"] = {
    model = "models/metrostroi_train/81-722/81-722_door_cab_l.mdl",
    pos = Vector(420, 58.3,-1),
    ang = Angle(0,-90,0),
    hide=2,
}
ENT.ClientProps["door_cab_r"] = {
    model = "models/metrostroi_train/81-722/81-722_door_cab_r.mdl",
    pos = Vector(419.4,-58.3,-1),
    ang = Angle(0,-90,0),
    hide=2,
}
ENT.ClientProps["door_cab_t"] = {
    model = "models/metrostroi_train/81-722/81-722_door_cab_t.mdl",
    pos = Vector(-466.7,18,-9),
    ang = Angle(0,-90,-0.15),
    hide=2,
}

ENT.ButtonMap["Vityaz"] = {
    pos = Vector(478.57,0+11.1,-5.7),
    ang = Angle(0,-90,66),
    width = 800,
    height = 600,
    scale = 0.02*0.62,
    sensor = true,
    system = "MFDU",
    hideseat=0.2,
    buttons = {
        {ID = "!VityazLamp",x=-40, y=690, radius=8, model = {
            lamp = {
                model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",
                var="VityazLamp",
                z=-14,
                color=Color(175,250,20)
            },
            sprite = {bright=0.15,size=0.15,scale=0.03,vscale=0.02,color=Color(100,255,20),z=5}
        }},
    }
}

ENT.ButtonMap["Sarmat"] = {
    pos = Vector(470.85,41.65,-6.2),
    ang = Angle(0.2,-64,67),
    width = 1024,
    height = 640,
    scale = 0.02*0.567,
    sensor = true,
    system = "SarmatUPO",
    hideseat=0.2,
    hide=true,
}

for i=1,3 do
    ENT.ClientProps["route_number"..i] = {
        model = "models/metrostroi_train/81-722/digits/digit.mdl",
        pos = Vector(477.58,41.85-(i-1)*0.5,-2.82),
        ang = Angle(0,180,0),
        color=Color(255,115,91),
        hideseat=0.2,
    }
end
ENT.ButtonMap["RouteNumberSet"] = {
    pos = Vector(477,42.6,-2.75),
    ang = Angle(0,-90,0),
    width = 30,
    height = 10,
    scale = 0.085,
    buttons = {
        {ID = "RouteNumber1Set",x=0,y=0,w=10,h=10, tooltip="Первая цифра"},
        {ID = "RouteNumber2Set",x=10,y=0,w=10,h=10, tooltip="Вторая цифра"},
        {ID = "RouteNumber3Set",x=20,y=0,w=10,h=10, tooltip="Третья цифра"},
    }
}
ENT.ButtonMap["RouteNumber"] = {
    pos = Vector(485.4,32.6,-4.55),
    ang = Angle(0,90+5,88),
    width = (7*8)*3+1*8*2,
    height = 14*8,
    scale = 0.23/4/(14/16),

    hide=2,
}
ENT.ButtonMap["LastStation"] = {
    pos = Vector(473.8,-12.5,43.5),
    ang = Angle(0,90,90),
    width = 512,
    height = 64,
    scale = 0.1,

    hide=2,
}
ENT.ButtonMap["Tickers"] = {
    pos = Vector(-455.4,-11.1,52.8),
    ang = Angle(0,90,90),
    width = 512,
    height = 64,
    scale = 0.094,
    hideseat=1.5,
}
ENT.ButtonMap["SarmatButtons"] = {
    pos = Vector(476.2,30.2,-6.4),
    ang = Angle(0.2,-64,67),
    width = 26,
    height = 108,
    scale = 0.0625,

    buttons = {
        {ID = "SarmatUpSet",x=6,y=2,w=14,h=13, tooltip="САРМАТ: Вверх"},
        {ID = "SarmatDownSet",x=6,y=2+13*1,w=14,h=13, tooltip="САРМАТ: Вниз"},
        {ID = "SarmatEnterSet",x=6,y=2+13*2,w=14,h=13, tooltip="САРМАТ: Enter"},
        {ID = "SarmatEscSet",x=6,y=2+13*3,w=14,h=13, tooltip="САРМАТ: Esc"},
        {ID = "SarmatF1Set",x=6,y=2+13*4,w=14,h=13, tooltip="САРМАТ: F1"},
        {ID = "SarmatF2Set",x=6,y=2+13*5,w=14,h=13, tooltip="САРМАТ: F2"},
        {ID = "SarmatF3Set",x=6,y=2+13*6,w=14,h=13, tooltip="САРМАТ: F3"},
        {ID = "SarmatF4Set",x=6,y=2+13*7,w=14,h=13, tooltip="САРМАТ: F4"},
    }
}
ENT.ButtonMap["BMP"] = {
    pos = Vector(468.5,25,-15.43),
    ang = Angle(0,-90,7),
    width = 36,
    height = 36,
    scale = 0.0625,

    buttons = {
        {ID = "SarmatPathSet",x=6,y=4,w=13,h=14, tooltip="САРМАТ: Путь"},
        {ID = "SarmatLineSet",x=6,y=18,w=13,h=14, tooltip="САРМАТ: Линия"},
        {ID = "SarmatZeroSet",x=19,y=4,w=13,h=14, tooltip="САРМАТ: >0<"},
        {ID = "SarmatStartSet",x=19,y=18,w=13,h=14, tooltip="САРМАТ: Пуск"},
    }
}
ENT.Lights = {
    -- Headlight glow
    [1] = { "headlight",    Vector(492,0,-37), Angle(0,0,0), Color(200,200,255), fov=90 ,brightness = 6, texture = "models/metrostroi_train/equipment/headlight2",shadows = 1,headlight=true},
    [2] = { "headlight",    Vector(493+15,0,60), Angle(0,0,0), Color(255,10,0), fov=140 ,brightness = 2, farz=450,texture = "models/metrostroi_train/equipment/headlight2",shadows = 0,backlight=true},
    [31]  = { "light",      Vector(493  ,   -60, -36), Angle(0,0,0), Color(200,255,255), brightness = 0.5, scale = 2.5, texture = "sprites/light_glow02.vmt" },
    [32]  = { "light",      Vector(493  ,   62, -36), Angle(0,0,0), Color(200,255,255), brightness = 0.5, scale = 2.5, texture = "sprites/light_glow02.vmt" },
    [33]  = { "light",      Vector(490,   -65, 15), Angle(0,0,0), Color(255,50,50), brightness = 0.2, scale = 4, texture = "sprites/light_glow02.vmt" },
    [34]  = { "light",      Vector(489,   60, 15), Angle(0,0,0), Color(255,50,50), brightness = 0.2, scale = 4, texture = "sprites/light_glow02.vmt" },
    --SOSD
    [3] = { "headlight",    Vector( 425,-65,-65),   Angle(25,-90,0),Color(255,255,255),brightness = 0.5,distance = 400 ,fov=120,shadows = 1 },
    -- Cabin
    [10] = { "dynamiclight",Vector( 440, 0, 14), Angle(0,0,0), Color(255,255,255), brightness = 0.25, distance = 550 },
     -- Interior
    [11] = { "dynamiclight",Vector( 180+30, 0, -5), Angle(0,0,0), Color(230,230,255), brightness = 3, distance = 260},
    [12] = { "dynamiclight",Vector( -50+30, 0, -5), Angle(0,0,0), Color(230,230,255), brightness = 3, distance = 260},
    [13] = { "dynamiclight",Vector(-280+30, 0, -5), Angle(0,0,0), Color(230,230,255), brightness = 3, distance = 260},
    -- Console
    [14] = { "headlight",   Vector(473.5,-9.71,-9.30), Angle(81,0,0), Color(200,110,20), farz = 8.6, nearz = 1, shadows = 1, brightness = 10.0, fov = 130},
    [15] = { "headlight",   Vector(476.8,-7.04,-5.06), Angle(81,0,0), Color(200,110,20), farz = 8.6, nearz = 1, shadows = 1, brightness = 10.0, fov = 130},
    [16] = { "headlight",   Vector(474.9,-3,-2.45), Angle(110,-13,0), Color(180,180,255), farz = 24.6, nearz = 2, shadows = 1, brightness = 1, fov = 172.99},
    [17] = { "headlight",   Vector(471.9,30,-1.75), Angle(110,22,0), Color(180,180,255), farz =26.9, nearz = 2, shadows = 1, brightness = 2, fov = 171.99},
    -- Side lights
    [20] = { "light",       Vector(-46.4, 66,28.1)+Vector(0, 0,4.1), Angle(0,0,0), Color(254,254,254), brightness = 0.4, scale = 0.1, texture = "sprites/light_glow02.vmt" },
    [21] = { "light",       Vector(-46.4, 66,28.1)+Vector(0, 0.4,-0), Angle(0,0,0), Color(254,210,18), brightness = 0.3, scale = 0.1, texture = "sprites/light_glow02.vmt" },
    [22] = { "light",       Vector(-46.4, 66,28.1)+Vector(0, 0.8,-4.1), Angle(0,0,0), Color(40,240,122), brightness = 0.3, scale = 0.1, texture = "sprites/light_glow02.vmt" },
    
    [23] = { "light",       Vector(-46.4,-66,28.1)+Vector(0,-0,4.1), Angle(0,0,0), Color(254,254,254), brightness = 0.4, scale = 0.1, texture = "sprites/light_glow02.vmt" },
    [24] = { "light",       Vector(-46.4,-66,28.1)+Vector(0,-0.4,-0), Angle(0,0,0), Color(254,210,18), brightness = 0.3, scale = 0.1, texture = "sprites/light_glow02.vmt" },
    [25] = { "light",       Vector(-46.4,-66,28.1)+Vector(0,-0.8,-4.1), Angle(0,0,0), Color(40,240,122), brightness = 0.3, scale = 0.1, texture = "sprites/light_glow02.vmt" },
    lamps_cab_e = {"light", Vector(444,-42.4,46), Angle(0,0,0),Color(255,255,255),brightness = 0.4, scale = 0.8, texture = "sprites/light_glow02", hidden="lamps_cab_e"},
    lamps_cab_f = {"light", Vector(444, 42.4,46), Angle(0,0,0),Color(255,255,255),brightness = 0.4, scale = 0.8, texture = "sprites/light_glow02", hidden="lamps_cab_f"},
}
function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.Vityaz = self:CreateRT("721Vityaz",1024,1024)
    self.PAM = self:CreateRT("717PAM",1024,512)
    self.Tickers = self:CreateRT("721Tickers",1024,128)
    self.Sarmat = self:CreateRT("721Sarmat",1024,1024)
    self.RouteNumber = self:CreateRT("721RouteNumber",256,128)
    self.LastStation = self:CreateRT("721LastStation",512,64)
    self.ReleasedPdT = 0
    self.CraneRamp = 0
    self.CraneRRamp = 0
    self.ReleasedPdT = 0
    self.EmergencyValveRamp = 0
    self.EmergencyValveEPKRamp = 0
    self.EmergencyBrakeValveRamp = 0
    self.FrontLeak = 0
    self.RearLeak = 0
    self.PreviousRingState = false
    self.PreviousCompressorState = false
    self.CompressorVol = 0
    self.ParkingBrake = 0
    self.BrakeCylinder = 0.5
    self.BPSNBuzzVolume = 0

end
local bortnumber_format = "models/metrostroi_train/81-714_mmz/bortnumber_%d.mdl"
function ENT:UpdateWagonNumber()
    local count = math.max(4,math.ceil(math.log10(self.WagonNumber+1)))
    for i=0,4 do
        --self:ShowHide("TrainNumberL"..i,i<count)
        --self:ShowHide("TrainNumberR"..i,i<count)
        --if i< count then
        local leftNum,rightNum = self.ClientEnts["TrainNumberL"..i],self.ClientEnts["TrainNumberR"..i]
        local num = math.floor(self.WagonNumber%(10^(i+1))/10^i)
        if IsValid(leftNum) then
            leftNum:SetPos(self:LocalToWorld(Vector(60+i*6.6-count*6.6/2,66.3,18)))
            leftNum:SetModel(Format(bortnumber_format, num))
        end
        if IsValid(rightNum) then
            rightNum:SetPos(self:LocalToWorld(Vector(53-i*6.6+count*6.6/2,-66.3,18)))
            rightNum:SetModel(Format(bortnumber_format, num))
        end
        --end
    end
end
local Cpos = {
    0,0.24,0.5,0.55,0.6,1
}
local conPos = {
    0,0.22,0.41,0.6,0.8,1
}
function ENT:Think()
    self.BaseClass.Think(self)
    if not self.RenderClientEnts or self.CreatingCSEnts then
        return
    end

    if not self.PassSchemesDone then
        local sarmat,sarmatr = self.ClientEnts.sarmat,self.ClientEnts.sarmatr
        local scheme = Metrostroi.Skins["722_schemes"] and Metrostroi.Skins["722_schemes"][self.Scheme]
        if IsValid(sarmat) and IsValid(sarmatr) and scheme then
            if self:GetNW2Bool("SarmatInvert") then
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
    if self.InvertSchemes ~= self:GetNW2Bool("SarmatInvert",false) then
        self.PassSchemesDone=false
        self.InvertSchemes = self:GetNW2Bool("SarmatInvert",false)
    end
    
    local Headlight = self:GetPackedRatio("Headlight")
    self:SetLightPower(1,Headlight>0,Headlight)
    self:SetLightPower(31,Headlight>0,Headlight)
    self:SetLightPower(32,Headlight>0,Headlight)
    self:SetLightPower(2,self:GetPackedBool("RedLights"))
    self:SetLightPower(33,self:GetPackedBool("RedLights"))
    self:SetLightPower(34,self:GetPackedBool("RedLights"))
    if IsValid(self.GlowingLights[1]) then
        if self:GetPackedRatio("Headlights") < 1 and self.GlowingLights[1]:GetFarZ() ~= 7000 then
            self.GlowingLights[1]:SetFarZ(7000)
        end
        if self:GetPackedRatio("Headlights") == 1 and self.GlowingLights[1]:GetFarZ() ~= 8192 then
            self.GlowingLights[1]:SetFarZ(8192)
        end
    end
    self:SetLightPower(3,self:GetPackedBool("SOSD"))
    local cablight = self:GetPackedRatio("CabLights")
    self:SetLightPower(10,cablight>0,cablight)
    self:SetLightPower("lamps_cab_e",cablight>0,cablight)
    self:SetLightPower("lamps_cab_f",cablight>0.3,cablight)
    
    local passlight = self:GetPackedRatio("SalonLighting")
    self:SetLightPower(11,passlight>0,passlight)
    self:SetLightPower(12,passlight>0,passlight)
    self:SetLightPower(13,passlight>0,passlight)
    
    self:SetLightPower(14,self:GetPackedBool("PanelLighting"))
    self:SetLightPower(15,self:GetPackedBool("PanelLighting"))
    self:SetLightPower(16,self:GetPackedBool("PanelLighting"))
    self:SetLightPower(17,self:GetPackedBool("PanelLighting"))

    local BortLSD,BortPneumo,BortBV = self:GetPackedBool("BortLSD"),self:GetPackedBool("BortPneumo"),self:GetPackedBool("BortBV")
    self:ShowHide("bortlamp_lsd",BortLSD)
    self:ShowHide("bortlamp_pneumo",BortPneumo)
    self:ShowHide("bortlamp_bv",BortBV)
    self:SetLightPower(20,BortLSD,1)
    self:SetLightPower(23,BortLSD,1)
    self:SetLightPower(21,BortPneumo,1)
    self:SetLightPower(24,BortPneumo,1)
    self:SetLightPower(22,BortBV,1)
    self:SetLightPower(25,BortBV,1)
    
    self:ShowHide("led",self:GetPackedBool("PanelLighting"))
    --ANIMS
    self:Animate("brake_line", self:GetPackedRatio("BLPressure"), 0.037, 0.795,  256,2)
    self:Animate("train_line", self:GetPackedRatio("TLPressure"),   0.037, 0.795,  4096,2)
    --print(math.max(0,(self:GetPackedRatio("BC")-self.BrakeCylinder)*math.Rand(-1,1)*1.5))

    local anim = self:Animate("brake_cylindera", self:GetPackedRatio("BCPressure"), 0, 1,  32,1)
    self.BrakeCylinder = math.Clamp(self.BrakeCylinder + (anim-self.BrakeCylinder)*self.DeltaTime*5 - math.min(0,(self.BrakeCylinder-anim)*math.Rand(0,1)*10)*(self.DeltaTime*33),0,1)
    self:Animate("brake_cylinder", self.BrakeCylinder, 0.016, 0.78,  1000,5)
    self:Animate("volt_lv",self:GetPackedRatio("LV"),1,0.68,92,2)
    self:Animate("volt_hv",self:GetPackedRatio("HighVoltage"),1,0.68,92,2)

    self:Animate("controller", conPos[self:GetPackedRatio("ControllerPosition")+4], 0.316, 0.66,  2,false)
    --self:Animate("controller", (self:GetPackedRatio("Controller")+3)/6, 0.75, 0.15,  2,false)
    --self:SetPackedRatio("BL", self.Pneumatic.BrakeLinePressure/16.0)
    --self:SetPackedRatio("TL", self.Pneumatic.TrainLinePressure/16.0)
    --self:SetPackedRatio("BC", math.min(3.2,self.Pneumatic.BrakeCylinderPressure)/6.0)
    self:Animate("km013", Cpos[self:GetPackedRatio("CranePosition")] or 0, 0.5, 0.15,  2,false)
    self:Animate("PB",  self:GetPackedBool("PB") and 1 or 0,0,0.2,  8,false)

    self:Animate("UAVA", self:GetPackedBool("UAVA") and 1 or 0, 0, 0.25,  6,false)
    self:Animate("EmergencyBrakeValve", self:GetPackedBool("EmergencyBrakeValve") and 1 or 0, 0, 0.3,  6,false)
    self:ShowHide("HeadLights",self:GetPackedBool("Headlights2"))
    self:ShowHide("HeadLightsH",self:GetPackedBool("Headlights1"))

    self:ShowHide("RedLights",self:GetPackedBool("RedLights"))

    self:ShowHideSmooth("lamps_salon",self:GetPackedRatio("SalonLighting"))

    self:ShowHide("lamps_cab_e",cablight>0)
    self:ShowHide("lamps_cab_f",cablight>0.3)
    self:ShowHide("doorl_l",self:GetPackedBool("DoorAlarmL"))
    self:ShowHide("doorl_r",self:GetPackedBool("DoorAlarmR"))
    --Радио
    self:ShowHide("rvs",self:GetPackedBool("RadioRVS"))

    self:Animate("RearBrake",   self:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    self:Animate("RearTrain",   self:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)

    local led_back = self:GetPackedBool("PassSchemesLEDO",false)
    if self:GetPackedBool("SarmatInvert",false) then led_back = not led_back end
    local sleft,sright = self:GetPackedBool("SarmatLeft"),self:GetPackedBool("SarmatRight")
    for i=1,4 do
        self:ShowHide("led_l_f"..i,not led_back and sleft)
        self:ShowHide("led_l_b"..i,led_back and sleft)
        self:ShowHide("led_r_f"..i,not led_back and sright)
        self:ShowHide("led_r_b"..i,led_back and sright)
    end
    local scurr = self:GetNW2Int("PassSchemesLED")
    local snext = self:GetNW2Int("PassSchemesLEDN")
    local led = scurr
    if snext ~= 0 and CurTime()%2 > 1 then led = led + snext end
    if scurr < 0 then led = math.floor(CurTime()%16.5*2) end
    if led_back then
        if sleft then
            for i=1,4 do if IsValid(self.ClientEnts["led_l_b"..i]) then self.ClientEnts["led_l_b"..i]:SetSkin(math.Clamp(led-((i-1)*8),0,8)) end end
        end
        if sright then
            for i=1,4 do if IsValid(self.ClientEnts["led_r_b"..i]) then self.ClientEnts["led_r_b"..i]:SetSkin(math.Clamp(led-((i-1)*8),0,8)) end end
        end
    else
        if sleft then
            for i=1,4 do if IsValid(self.ClientEnts["led_l_f"..i]) then self.ClientEnts["led_l_f"..i]:SetSkin(math.Clamp(led-((i-1)*8),0,8)) end end
        end
        if sright then
            for i=1,4 do if IsValid(self.ClientEnts["led_r_f"..i]) then self.ClientEnts["led_r_f"..i]:SetSkin(math.Clamp(led-((i-1)*8),0,8)) end end
        end
    end

    local rnwork = self:GetNW2Bool("RouteNumberWork")
    local rn =  self:GetNW2Int("RouteNumberSet")
    for i=1,3 do
        self:ShowHide("route_number"..i,rnwork)
        if rnwork and IsValid(self.ClientEnts["route_number"..i]) then
            local number = math.floor(rn/10^(3-i)) % 10
            --local d1 = math.floor(num) % 10
            --local d2 = math.floor(num / 10) % 10
            --local d3 = math.floor(num / 100) % 10
            self.ClientEnts["route_number"..i]:SetSkin(number)
        end
    end
    --self:Animate("brake_cylinder", 0/6, 0.016, 0.78,  2,false)
    --self:Animate("brake_line", 0/16, 0.037, 0.795,  2,false)
    --self:Animate("train_line", 0/16, 0.037, 0.795,  2,false)
    --
    local playL = false
    local playR = false
    local anim = 0--math.Round(CurTime()%5/5)
    for i=0,3 do
        for k=0,1 do
            local st = k==1 and "DoorL" or "DoorR"
            local doorstate = self:GetPackedBool(st)
            local id,sid = st..(i+1),"door"..i.."x"..k
            if not self.DoorStates then self.DoorStates = {} end
            local state = self:GetPackedRatio(id)
            --print(state,self.DoorStates[state])
            if (state ~= 1 and state ~= 0) ~= self.DoorStates[id] then
                if doorstate and state < 1 or not doorstate and state > 0 then
                    --self:PlayOnce("doors","",1,1)
                else
                    self:PlayOnce(sid.."c","",0.15,math.Rand(0.9,1.1))
                end
                self.DoorStates[id] = (state ~= 1 and state ~= 0)
            end
            if (state ~= 1 and state ~= 0) and k==1 then playL = true end
            if (state ~= 1 and state ~= 0) and k==0 then playR = true end
            local n_l = "door"..i.."x"..k--.."a"
            --local n_r = "door"..i.."x"..k.."b"
            self:Animate(n_l,state,0,1, 0.5,false)--0.8 + (-0.2+0.4*math.random()),0)
            --self:Animate(n_r,state,0,1, 0.5,false)--0.8 + (-0.2+0.4*math.random()),0)
        end
    end
    if playL ~= self.LeftDoorState then
        if playL then self:PlayOnce("doors","",0.6,1) end
        self.LeftDoorState = playL
    end
    if playR ~= self.RightDoorState then
        if playR then  self:PlayOnce("doors","",0.6,1) end
        self.RightDoorState = playR
    end
    if playL or playR then
        --if not self:PlayOnce("doors","",1,1)
        self.DoorSoundState = math.Clamp((self.DoorSoundState or 0) + 0.75*self.DeltaTime,0,0.5)
    else
        self.DoorSoundState = math.Clamp((self.DoorSoundState or 0) - 0.5*self.DeltaTime,0,0.5)
    end
    --print(self.DoorSoundState)
    self:SetSoundState("doorl",self.DoorSoundState or 0,1)


    local door_m = self:GetPackedBool("PassengerDoor")
    local door_l = self:GetPackedBool("CabinDoorLeft")
    local door_r = self:GetPackedBool("CabinDoorRight")
    local door_t = self:GetPackedBool("RearDoor")
    local door_cab_m = self:Animate("door_cab_m",door_m and 1 or -0.05,0,0.25, 8, 0.05)
    local door_cab_l = self:Animate("door_cab_l",door_l and 1 or -0.1,0,0.344, 4, 0.5)
    local door_cab_r = self:Animate("door_cab_r",door_r and 1 or -0.1,1,0.7, 4, 0.5)
    local door_cab_t = self:Animate("door_cab_t",door_t and 1 or -0.05,1,0.75, 8, 0.05)

    local door1s = (door_cab_m > 0 or door_m)
    if self.Door1 ~= door1s then
        self.Door1 = door1s
        self:PlayOnce("PassengerDoor","bass",door1s and 1 or 0)
    end
    local door2s = (door_cab_l > 0 or door_l)
    if self.Door2 ~= door2s then
        self.DoorCL = door_l
        self.Door2 = door2s
        self:PlayOnce("CabinDoorLeft","bass",door2s and 1 or 0)
    end
    local door3s = (door_cab_r < 1 or door_r)
    if self.Door3 ~= door3s then
        self.DoorCR = door_r
        self.Door3 = door3s
        self:PlayOnce("CabinDoorRight","bass",door3s and 1 or 0)
    end
    local door4s = (door_cab_t < 1 or door_t)
    if self.Door4 ~= door4s then
        self.Door4 = door4s
        self:PlayOnce("RearDoor","bass",door4s and 1 or 0)
    end

    local dT = self.DeltaTime

    local parking_brake = math.max(0,-self:GetPackedRatio("ParkingBrakePressure_dPdT",0))
    self.ParkingBrake = self.ParkingBrake+(parking_brake-self.ParkingBrake)*dT*10
    self:SetSoundState("parking_brake",self.ParkingBrake,1.4)

    local dPdT = self:GetPackedRatio("BrakeCylinderPressure_dPdT")
    self.ReleasedPdT = math.Clamp(self.ReleasedPdT + 2*(-self:GetPackedRatio("BrakeCylinderPressure_dPdT",0)-self.ReleasedPdT)*dT,0,1)
    local release1 = math.Clamp(self.ReleasedPdT,0,1)^2
    self:SetSoundState("release",release1,1)

    self:SetSoundState("ring",self:GetPackedBool("RingEnabledBARS") and 1 or 0,1)
    self:SetSoundState("ring2",self:GetPackedBool("RingEnabled") and 1 or 0,1)

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

    local emergencyValveEPK = self:GetPackedRatio("EmergencyValveEPK_dPdT",0)
    self.EmergencyValveEPKRamp = math.Clamp(self.EmergencyValveEPKRamp + 1.0*((0.5*emergencyValveEPK)-self.EmergencyValveEPKRamp)*dT,0,1)
    if self.EmergencyValveEPKRamp < 0.01 then self.EmergencyValveEPKRamp = 0 end
    self:SetSoundState("epk_brake",self.EmergencyValveEPKRamp,1.0)

    local emergencyBrakeValve = self:GetPackedRatio("EmergencyBrakeValve_dPdT", 0)
    self.EmergencyBrakeValveRamp = math.Clamp(self.EmergencyBrakeValveRamp + (emergencyBrakeValve-self.EmergencyBrakeValveRamp)*dT*8,0,1)
    self:SetSoundState("valve_brake",self.EmergencyBrakeValveRamp,0.8+math.min(0.4,self.EmergencyBrakeValveRamp*0.8))


    local emergencyValve = self:GetPackedRatio("EmergencyValve_dPdT", 0)^0.4*1.2
    self.EmergencyValveRamp = math.Clamp(self.EmergencyValveRamp + (emergencyValve-self.EmergencyValveRamp)*dT*16,0,1)
    self:SetSoundState("emer_brake",self.EmergencyValveRamp,1.0)

    local state = self:GetPackedBool("CompressorWork")
    if self.CompressorVol < 1 and state then
        self.CompressorVol = math.min(1,self.CompressorVol + 5*dT)
    elseif self.CompressorVol > 0 and not state then
        self.CompressorVol = math.max(0,self.CompressorVol - 3*dT)
    end
    --if state then
        self:SetSoundState("compressor",self.CompressorVol,0.8+0.2*self.CompressorVol)
    --else
        --self:SetSoundState("compressor",0,0)
    --end
    self.PreviousCompressorState = state
    local rollingi = math.min(1,self.TunnelCoeff+math.Clamp((self.StreetCoeff-0.82)/0.5,0,1))
    local rollings = math.max(self.TunnelCoeff*0.6,self.StreetCoeff)
    local tunstreet = (rollingi+rollings*0.2)
    local speed = self:GetPackedRatio("Speed", 0)
    local rol10 = math.Clamp(speed/25,0,1)*(1-math.Clamp((speed-25)/8,0,1))
    local rol45 = math.Clamp((speed-23)/8,0,1)*(1-math.Clamp((speed-50)/8,0,1))
    local rol45p = Lerp((speed-25)/25,0.8,1)
    local rol60 = math.Clamp((speed-50)/8,0,1)*(1-math.Clamp((speed-65)/5,0,1))
    local rol60p = Lerp((speed-50)/15,0.8,1)
    local rol70 = math.Clamp((speed-65)/5,0,1)
    local rol70p = Lerp((speed-65)/25,0.8,1.2)
    self:SetSoundState("rolling_10",rollingi*rol10,1)
    self:SetSoundState("rolling_45",rollingi*rol45,1)
    self:SetSoundState("rolling_60",rollingi*rol60,1)
    self:SetSoundState("rolling_70",rollingi*rol70,1)


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

    --local state = (RealTime()%4/3)^1.5
    --local strength = 1--self:GetPackedRatio("asyncstate")*(1-math.Clamp((speed-15)/15,0,1))
    local state = self:GetPackedRatio("asynccurrent")--^1.5--RealTime()%2.5/2
    local strength = self:GetPackedRatio("asyncstate")*(1-math.Clamp((speed-15)/15,0,1))
    self:SetSoundState("test_async1", tunstreet*math.Clamp((state)/0.3+0.2,0,1)*strength, 0.6+math.Clamp(state,0,1)*0.4)
    self:SetSoundState("test_async1_2",tunstreet*math.Clamp((state-0.75)/0.05,0,1)*strength, 0.6+math.Clamp((state-0.8)/0.2,0,1)*0.14)
    self:SetSoundState("test_async1_3",tunstreet*math.Clamp((state-0.7)/0.1,0,1)*strength, 0.87)
    self:SetSoundState("test_async2", tunstreet*math.Clamp(math.max(0,(state)/0.3+0.2),0,1)*strength, 0.55+math.Clamp(state,0,1)*0.45)
    self:SetSoundState("test_async3", tunstreet*math.Clamp(math.max(0,(state-0.7)/0.1),0,1)*strength, 1)
    self:SetSoundState("test_async3_2", tunstreet*math.Clamp((state-0.415)/0.1,0,1)*(1-math.Clamp((state-1.1)/0.3,0,0.5))*strength, 0.48+math.Clamp(state,0,1)*0.72)
    self:SetSoundState("battery_off_loop", self:GetPackedBool("BattPressed") and 1 or 0,1)
    self:SetSoundState("async_p2", tunstreet*(math.Clamp((speed-5)/5,0,1)*0.1+math.Clamp((speed-14)/10,0,1)*0.9)*(1-math.Clamp((speed-27)/4,0,1))*self:GetPackedRatio("asyncstate"), speed/36)
    self:SetSoundState("async_p3", tunstreet*(math.Clamp((speed-7)/5,0,1)*0.1+math.Clamp((speed-17)/10,0,1)*0.9)*(1-math.Clamp((speed-30)/4,0,1))*self:GetPackedRatio("asyncstate"), speed/42)
    self:SetSoundState("engine_loud", tunstreet*math.Clamp((speed-10)/15,0,1)*(1-math.Clamp((speed-30)/40,0,0.6))*self:GetPackedRatio("asyncstate"), speed/20)
    self:SetSoundState("chopper", tunstreet*self:GetPackedRatio("chopper"), 1)

    local work = self:GetPackedBool("AnnPlay")
    local UPO = work and self:GetPackedBool("AnnPlayUPO")

    local noise = self:GetNW2Int("AnnouncerNoise", -1)
    local volume = self:GetNW2Float("UPOVolume",1)
    local noisevolume = self:GetNW2Float("UPONoiseVolume",1)
    local buzzvolume = volume
    if self.Sounds["announcer1"] and IsValid(self.Sounds["announcer1"]) then buzzvolume = UPO and (1-(self.Sounds["announcer1"]:GetLevel())*math.Rand(0.9,3))*buzzvolume*2 or 0 end
    if self.BPSNBuzzVolume > buzzvolume then
        self.BPSNBuzzVolume = math.Clamp(self.BPSNBuzzVolume + 8*(buzzvolume-self.BPSNBuzzVolume)*dT,0.1,1)
    else
        self.BPSNBuzzVolume = math.Clamp(self.BPSNBuzzVolume + 0.4*(buzzvolume-self.BPSNBuzzVolume)*dT,0.1,1)
    end

    for k,v in ipairs(self.AnnouncerPositions) do
        self:SetSoundState("announcer_noiseW"..k,UPO and noisevolume*volume*0.7 or 0,1)
        for i=1,3 do
            self:SetSoundState(Format("announcer_noise%d_%d",i,k),(UPO and i==noise) and volume*self.BPSNBuzzVolume*self:GetNW2Float("UPOBuzzVolume",1)*0.7 or 0,1)
        end

        if IsValid(self.Sounds["announcer"..k]) then self.Sounds["announcer"..k]:SetVolume(work and v[3]*(UPO and volume or 1) or 0) end
    end
end

function ENT:OnAnnouncer(volume)
    local work = self:GetPackedBool("AnnPlay")
    local UPO = work and self:GetPackedBool("AnnPlayUPO")

    return work and volume*(UPO and self:GetNW2Float("UPOVolume",1) or 1) or 0
end

function ENT:Draw()
    self.BaseClass.Draw(self)
end

local CamRTM = Material( "pp/rt" )
function ENT:DrawPost()
    self.RTMaterial:SetTexture("$basetexture", self.Vityaz)
    self:DrawOnPanel("Vityaz",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,512,1024,1024,0)
    end)
    --[[ self.RTMaterial:SetTexture("$basetexture", self.PAM)
    self:DrawOnPanel("PAMScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,256,1024,512,0)
    end)--]]
    self.RTMaterial:SetTexture("$basetexture", self.Sarmat)
    self:DrawOnPanel("Sarmat",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,512,1024,1024,0)

        --surface.SetMaterial(self.RTMaterial2)
        --surface.SetDrawColor(255,255,255)
        --self.RTMaterial2:SetTexture("$basetexture", self.SarmatUPO.Cam1)
        --surface.DrawTexturedRectRotated(384,128,256,256,0)
        --self.RTMaterial2:SetTexture("$basetexture", self.SarmatUPO.Cam2)
        --surface.DrawTexturedRectRotated(128,128,256,256,0)
    end)
    self.RTMaterial:SetTexture("$basetexture", self.LastStation)
    self:DrawOnPanel("LastStation",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(256,32,512,64,0)
    end)
    self.RTMaterial:SetTexture("$basetexture", self.Tickers)
    self:DrawOnPanel("Tickers",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(256,32,512,64,0)
    end)
    self.RTMaterial:SetTexture("$basetexture", self.RouteNumber)
    self:DrawOnPanel("RouteNumber",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(128,64,256,128,0)
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
    if soundid == "BatteryOn" and range > 0 then
        return "battery_on_1",location,1,pitch
    end
    if soundid == "BatteryOff" then
        return range > 0 and "battery_off_1" or "battery_off_2",location,1,pitch
    end
    return soundid,location,range,pitch
end
local dist = {
    PPZ = 550,
    PPZB = 550,
    PVM = 550,
}
for id,panel in pairs(ENT.ButtonMap) do
    if not panel.buttons then continue end
    for k,v in pairs(panel.buttons) do
        if v.model then
            local dist = dist[id] or 150
            if v.model.model then
                v.model.hideseat=dist
            elseif v.model.lamp then
                v.model.lamp.hideseat=dist
            end
        end
    end
end
Metrostroi.GenerateClientProps()

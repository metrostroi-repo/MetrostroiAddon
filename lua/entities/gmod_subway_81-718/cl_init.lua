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
ENT.ClientProps["BUP"] = {
    model = "models/metrostroi_train/81-718/81-718_dinas11.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0.000000,0.000000,0.000000),
    hide=2,
}
ENT.ClientProps["Cabine"] = {
    model = "models/metrostroi_train/81-718/81-718_cabine.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0.000000,0.000000,0.000000),
    hide=3.6,
}
ENT.ClientProps["RedLights"] = {
    model = "models/metrostroi_train/81-718/red_light.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0.000000,0.000000,0.000000),
    hide=2,
}
ENT.ClientProps["destination"] = {
    model = "models/metrostroi_train/81-718/labels/destination.mdl",
    pos = Vector(0,0,-1),
    ang = Angle(0,0,0),
    hide=2,
    callback = function(ent)
        ent.LastStation.Reloaded = false
    end,
}
ENT.ButtonMap["LastStation"] = {
    pos = Vector(462.5,-27.4,-2.7),
    ang = Angle(0,90,90),
    width = 876,
    height = 131,
    scale = 0.0625,
    buttons = {
        {ID = "LastStation-",x=000,y=0,w=438,h=131, tooltip=""},
        {ID = "LastStation+",x=438,y=0,w=438,h=131, tooltip=""},
    }
}
ENT.ClientProps["salon"] = {
    model = "models/metrostroi_train/81-718/interior.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["route"] = {
    model = "models/metrostroi_train/81-718/marshrut_number_body.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["route1"] = {
    model = "models/metrostroi_train/81-718/lamps/segment_spb.mdl",
    pos = Vector(463.15,35.8,38.2),
    ang = Angle(90,16,0),
    color = Color(241,10,70),
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
    hide=2,
}
ENT.ClientProps["route2"] = {
    model = "models/metrostroi_train/81-718/lamps/segment_spb.mdl",
    pos = Vector(461.85,40.3,38.2),
    ang = Angle(90,16,0),
    color = Color(241,10,70),
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
    hide=2,
}
ENT.ButtonMap["Route"] = {
    pos = Vector(457.1,41.6,47.2),
    ang = Angle(0,270+16,90),
    width = 153,
    height = 180,
    scale = 0.0625,
    buttons = {
        {ID = "RouteNumber1+",x=76.5*0,y=0,w=76.5,h=90,tooltip=""},
        {ID = "RouteNumber2+",x=76.5*1,y=0,w=76.5,h=90,tooltip=""},
        {ID = "RouteNumber1-",x=76.5*0,y=90,w=76.5,h=90,tooltip=""},
        {ID = "RouteNumber2-",x=76.5*1,y=90,w=76.5,h=90,tooltip=""},
    }
}
ENT.ClientProps["route1_s"] = {
    model = "models/metrostroi_train/81-717/segments/segment_mvm.mdl",
    pos = Vector(458.2,39.7,35.1),
    ang = Angle(90,180+16,0),
    color = Color(175,250,20),
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
    hideseat=0.2,
}
ENT.ClientProps["route2_s"] = {
    model = "models/metrostroi_train/81-717/segments/segment_mvm.mdl",
    pos = Vector(458.4,39,35.1),
    ang = Angle(90,180+16,0),
    color = Color(175,250,20),
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
    hideseat=0.2,
}
ENT.ClientProps["route1_r"] = {
    model = "models/metrostroi_train/81-718/lamps/segment_spb.mdl",
    pos = Vector(463.15+1-0.2,35.8+2,38.2-3),
    ang = Angle(90,180+16,0),
    color = Color(120.50,5.00,35.00),
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
    hideseat=0.8,
}
ENT.ClientProps["route2_r"] = {
    model = "models/metrostroi_train/81-718/lamps/segment_spb.mdl",
    pos = Vector(461.85+1-0.2,40.3+2,38.2-3),
    ang = Angle(90,180+16,0),
    color = Color(120.50,5.00,35.00),
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
    hideseat=0.8,
}
ENT.ClientProps["seats"] = {
    model = "models/metrostroi_train/81-717/couch_old.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["Headlights_1"] = {
    model = "models/metrostroi_train/81-718/headlights.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["Headlights_2"] = {
    model = "models/metrostroi_train/81-718/headlights2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}

ENT.ClientProps["couch_cap"] = {
    model = "models/metrostroi_train/81-717/couch_cap_l.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=0.8,
}

ENT.ClientProps["door_otsek1"] = {
    model = "models/metrostroi_train/81-717/door_otsek1.mdl",
    pos = Vector(375.35,-15.324,5.167),
    ang = Angle(0,-90,0),
    hideseat=1.7,
}
ENT.ClientProps["door_otsek2"] = {
    model = "models/metrostroi_train/81-717/door_otsek2.mdl",
    pos = Vector(375.35,-59.65,5.167),
    ang = Angle(0,-90,0),
    hideseat=1.7,
}
ENT.ClientProps["cap_l"] = {
    model = "models/metrostroi_train/81-717/couch_cap_r.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=0.8,
}

ENT.ClientProps["train_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(460.909851,-27.286127,2.136254),
    ang = Angle(-90.000000,-18.529299,0.000000),
    hideseat = 0.2,
}
ENT.ClientProps["brake_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_tm.mdl",
    pos = Vector(460.897827,-27.245167,2.136254),
    ang = Angle(-90.000000,-18.529299,0.000000),
    hideseat = 0.2,
}


ENT.ClientProps["brake_cylinder"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(459.103638,-33.373646,2.136254),
    ang = Angle(-90.000000,-18.529299,0.000000),
    hideseat = 0.2,
}



ENT.ClientProps["kru_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = Vector(451+3.1,24+2,-1-8.5),
    ang = Angle(180,90+6,180+11),
    hideseat=0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}

ENT.ClientProps["kr_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = Vector(444+2.5,24+2,-2.7-8+0.1),
    ang = Angle(180,90+6,180+11),
    hideseat=0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}

ENT.ClientProps["controller"] = {
    model = "models/metrostroi_train/81-718/718_kv.mdl",
    pos = Vector(443.8+1.5,18,-2-8),
    ang = Angle(0,-90,11),
    --bscale = Vector(0.4*4,0.6*4,1),
    color = Color(150,150,150),
    hideseat=0.2,
}

--var="ZS",vmin=0,vmax=1,min=0,max=1,speed=16,damping=false,
-- Main panel
ENT.ButtonMap["Main"] = {
    pos = Vector(454,10.5,-9.9), --446 -- 14 -- -0,5
    ang = Angle(0,-90,11.3),
    width = 472,
    height = 190,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "SA5Toggle", x=30, y=65, radius=24, tooltip="Закрытие дверей", model = {
            model = "models/metrostroi_train/switches/vudwhite.mdl", z=-20,
            var="SA5",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SB3Set",         x=81, y=32, radius=20, tooltip="КРЗД", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z=-9, vmin=1, vmax=0,
            var="SB3",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {   ID = "SA7Toggle",x=85, y=90, radius=20, tooltip="Выбор стороны", model = {
            model = "models/metrostroi_train/81-508/em508_switcher.mdl",z=-15,
            var="SA7",speed=6,ang=90-90,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            disableoff = "SB1Set",disableon = "SB2Set",
            states={"Train.Buttons.Left","Train.Buttons.Right"}
        }},

        {ID = "SB1Set",x=31, y=148, radius=20, tooltip="Двери левые", model = {
            model = "models/metrostroi_train/81-502/buttons/button_717_1.mdl",vmin=1,vmax=0,z=-14,
            var="SB1",speed=16,
            lamp = {model = "models/metrostroi_train/81-717/buttons/lamp_button_2.mdl",anim=true,var="HL3",speed=6,z=2.2,
            lcolor=Color(255,130,40),lz = 16,lfov=160,lfar=5,lnear=1,lshadows=0},
            sprite = {bright=0.2,size=.5,scale=0.1,z=6,color=Color(255,130,40)},
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "SB2Set",x=82, y=148, radius=20, tooltip="Двери правые", model = {
            model = "models/metrostroi_train/81-502/buttons/button_717_1.mdl",vmin=1,vmax=0,z=-14,
            var="SB2",speed=16,
            lamp = {model = "models/metrostroi_train/81-717/buttons/lamp_button_2.mdl",anim=true,var="HL4",speed=6,z=2.2,
            lcolor=Color(255,130,40),lz = 16,lfov=160,lfar=5,lnear=1,lshadows=0},
            sprite = {bright=0.2,size=.5,scale=0.1,z=6,color=Color(255,130,40)},
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "!SB1K",x=31, y=148, radius=0, model = {
            model = "models/metrostroi_train/81-703/cabin_doors_cover.mdl",ang = Angle(0,180,180),z=-2,y=-30,vmin=0.83,vmax=1,
            var="SA7",speed=1,
            sndvol = 0.10, snd = function(val) return val and "kr_left" or "kr_right" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "!SB2K",x=82, y=148, radius=0, model = {
            model = "models/metrostroi_train/81-703/cabin_doors_cover.mdl",ang = Angle(0,180,180),z=-2,y=-30,vmin=0,vmax=0.17,
            var="SA7",speed=1,
            sndvol = 0.10, snd = function(val) return val and "kr_left" or "kr_right" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},


        {ID = "SA8Toggle",x=136, y=32, radius=20, tooltip="Выключатель аварийного хода", model = {
            model = "models/metrostroi_train/81-508/em508_switcher.mdl",z=-15,
            var="SA8",speed=16,ang=180-90,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=0,y=28,z=15,var="SA8Pl", ID="SA8Pl",},
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SB4Set",x=136, y=91, radius=20, tooltip="Проверка", model = {
            model = "models/metrostroi_train/81-502/buttons/button_717_1.mdl",vmin=1,vmax=0,z=-12,
            var="SB4",speed=16,
            lamp = {model = "models/metrostroi_train/81-717/buttons/lamp_button_2.mdl",anim=true,var="HL5",speed=6,z=2.2,
            lcolor=Color(255,130,40),lz = 16,lfov=160,lfar=5,lnear=1,lshadows=0},
            sprite = {bright=0.2,size=.5,scale=0.1,z=6,color=Color(255,130,40)},
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            tooltipFunc = function(ent) return ent:GetPackedBool("HL5") and Metrostroi.GetPhrase("Train.Buttons.HL5") end
        }},
        {ID = "SB5Set",x=136, y=148, radius=20, tooltip="Передача управления(звонок)", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",vmin=1,vmax=0,z=-9,
            var="SB5",speed=16,
            --lamp = {model = "models/metrostroi_train/81-717/buttons/lamp_button_2.mdl",anim=true,var="RZP",speed=9,z=2.2,
            --lcolor=Color(255,130,40),lz = 16,lfov=160,lfar=16,lnear=8,lshadows=0},
            --sprite = {bright=0.2,size=.5,scale=0.1,z=6,color=Color(255,130,40)},
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},


        {ID = "SA9Toggle",x=186, y=32, radius=20, tooltip="Откл. АВУ", model = {
            model = "models/metrostroi_train/81-508/em508_switcher.mdl",z=-15,
            var="SA9",speed=16,ang=180-90,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=0,y=28,z=15,var="SA9Pl", ID="SA9Pl",},
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},


        {ID = "SA13Toggle",x=291, y=32, radius=20, tooltip="АРС", model = {
            model = "models/metrostroi_train/81-508/em508_switcher.mdl",z=-15,
            var="SA13",speed=16,ang=180-90,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SA14Toggle",x=316, y=32, radius=20, tooltip="АРС-Р", model = {
            model = "models/metrostroi_train/81-508/em508_switcher.mdl",z=-15,
            var="SA14",speed=16,ang=180-90,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SA15Toggle",x=341, y=32, radius=20, tooltip="АЛС", model = {
            model = "models/metrostroi_train/81-508/em508_switcher.mdl",z=-15,
            var="SA15",speed=16,ang=180-90,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},

        {ID = "SA2Toggle",x=236, y=32, radius=20, tooltip="Выключатель аварийный дверей", model = {
            model = "models/metrostroi_train/81-508/em508_switcher.mdl",z=-15,
            var="SA2",speed=16,ang=180-90,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=0,y=28,z=15,var="SA2Pl", ID="SA2Pl",},
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},

        {ID = "SB6KToggle",x=186, y=88, radius=20, tooltip="Крышка хода аварийного", model = {
            model = "models/metrostroi_train/81-508/em508_switcher.mdl",z=-15,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=3,y=23,z=15,var="SB6Pl", ID="SB6Pl",},
            var="SB6K",speed=5,ang=90-90,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            disable = "SB6Set",
            noTooltip = true,
        }},
        {ID = "!SB6K",x=233, y=95, radius=0, model = {
            model = "models/metrostroi_train/81-703/cabin_doors_cover.mdl",ang = Angle(0,180,180),z=-2,y=-30,vmin=0.17,vmax=0,
            var="SB6K",speed=1,
            sndvol = 0.10, snd = function(val) return val and "kr_left" or "kr_right" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "SB6Set",x=233, y=95, radius=20, tooltip="Ход аварийный", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",vmin=1,vmax=0,z=-11,
            var="SB6",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "SB7KToggle",x=186, y=146, radius=20, tooltip="Крышка хода маневрового", model = {
            model = "models/metrostroi_train/81-508/em508_switcher.mdl",z=-15,
            var="SB7K",speed=5,ang=90-90,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            disable = "SB7Set",
            noTooltip = true,
        }},
        {ID = "!SB7K",x=233, y=152, radius=nil, model = {
            model = "models/metrostroi_train/81-703/cabin_doors_cover.mdl",ang = Angle(0,180,180),z=-2,y=-30,vmin=0.17,vmax=0,
            var="SB7K",speed=1,
            sndvol = 0.10, snd = function(val) return val and "kr_left" or "kr_right" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},

        {ID = "SB7Set",x=233, y=152, radius=20, tooltip="Ход маневровый", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", vmin=1, vmax=0, z=-11,
            var="SB7",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},

        {ID = "SB8Set",x=291, y=95, radius=20, tooltip="КБ1", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl", vmin=1, vmax=0, z=-9,
            var="SB8",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "SB10Set",x=291, y=152, radius=20, tooltip="Программа 1", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", vmin=1, vmax=0, z=-10,
            var="SB10",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},

        {ID = "SB9Set",x=341, y=95, radius=20, tooltip="КБ2", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", vmin=1, vmax=0, z=-9,
            var="SB9",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "SB11Set",x=341, y=152, radius=20, tooltip="Программа 2", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", vmin=1, vmax=0, z=-10,
            var="SB11",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},



        {ID = "SA16Toggle",x=397.5, y=30, radius=20, tooltip="Компрессор", model = {
            model = "models/metrostroi_train/81-508/em508_switcher.mdl",z=-15,
            var="SA16",speed=16,ang=180-90,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SB12Set",x=398, y=95, radius=20, tooltip="Включение БВА", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl", vmin=1, vmax=0, z=-9,
            var="SB12",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "SB13Set",x=398, y=148, radius=20, tooltip="Отключение БВА", model = {
            model = "models/metrostroi_train/81-502/buttons/button_717_1.mdl",vmin=1,vmax=0,z=-12,
            lamp = {model = "models/metrostroi_train/81-717/buttons/lamp_button_2.mdl",anim=true,var="HL6",getfunc = function(ent) return ent:GetPackedRatio("HL6") end,speed=6,z=2.2,
            lcolor=Color(255,130,40),lz = 16,lfov=160,lfar=5,lnear=1,lshadows=0},
            sprite = {bright=0.2,size=.5,scale=0.1,z=6,color=Color(255,130,40)},
            var="SB13",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            tooltipFunc = function(ent) return ent:GetPackedBool("HL6") and Metrostroi.GetPhrase("Train.Buttons.HL6") end
        }},

        {ID = "SB14Set",x=452, y=34, radius=20, tooltip="Резервный мотор-компрессор", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", vmin=1, vmax=0, z=-9,
            var="SB14",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "SB15Set",x=452, y=95, radius=20, tooltip="Включение ББЭ", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl", vmin=1, vmax=0, z=-9,
            var="SB15",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "SB16Set",x=452, y=148, radius=20, tooltip="Отключение ББЭ", model = {
            model = "models/metrostroi_train/81-502/buttons/button_717_1.mdl",vmin=1,vmax=0,z=-12,
            lamp = {model = "models/metrostroi_train/81-717/buttons/lamp_button_2.mdl",anim=true,var="HL7",speed=6,z=2.2,
            lcolor=Color(255,130,40),lz = 16,lfov=160,lfar=5,lnear=1,lshadows=0},
            sprite = {bright=0.2,size=.5,scale=0.1,z=6,color=Color(255,130,40)},
            var="SB16",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            tooltipFunc = function(ent) return ent:GetPackedBool("HL7") and Metrostroi.GetPhrase("Train.Buttons.HL7") end
        }},
    }
}
ENT.ButtonMap["Left"] = {
    pos = Vector(456.9,10,5-7.5), --446 -- 14 -- -0,5
    ang = Angle(0,-90,90-14.971),
    width = 85,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "!BatteryVoltage", x=0,y=0,w=85,h=110,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BatteryVoltage"),ent:GetPackedRatio("BatteryVoltage")*150) end},
    }
}
ENT.ButtonMap["Right"] = {
    pos = Vector(456.9,-13.1,5-7.5), --446 -- 14 -- -0,5
    ang = Angle(0,-90,90-14.971),
    width = 110,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "SA1/1Toggle",x=55-38, y=93, radius=10, tooltip="Фары 1 группа", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",ang = 180,z=-3.5,
            var="SA1/1",speed=16,ang=180,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SA2/1Toggle",x=55-19, y=93, radius=10, tooltip="Фары 2 группа", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",ang = 180,z=-3.5,
            var="SA2/1",speed=16,ang=180,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SA5/1Toggle",x=55+19, y=93, radius=10, tooltip="Яркость табло", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",ang = 180,z=-3.5,
            var="SA5/1",speed=16,ang=180,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.LHalf","Train.Buttons.LFull"}
        }},
        {ID = "SA4/1Toggle",x=55+38, y=93, radius=10, tooltip="Подсветка приборов", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",ang = 180,z=-3.5,
            var="SA4/1",speed=16,ang=180,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["HelperPanel"] = {
    pos = Vector(446.8,62.6,17.75),
    ang = Angle(0,0,90),
    width = 76,
    height = 305,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "SA6Toggle",x=0,y=0,w=76,h=86,tooltip="",model = {
            model = "models/metrostroi_train/switches/vudbrown.mdl",z=25,
            var="SA6",speed=6,
            sndvol = 1,snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "SA24Set",x=0,y=86,w=76,h=86,tooltip="",model = {
            model = "models/metrostroi_train/switches/vudbrown.mdl",z=25,
            var="SA24",speed=6,
            sndvol = 1,snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "SB20Set",x=38,y=230,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="SB20",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button2_off" end,
            sndmin = 60,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "SB21Set",x=38,y=285,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="SB21",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button3_off" end,
            sndmin = 60,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["CabVent"] = {
    pos = Vector(456.8,45.8,-13),
    ang = Angle(0,-90,0),
    width = 70,
    height = 62,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID="PVK-",x=0, y=0, w=35,h=62, tooltip="",states={"Train.Buttons.Off","Train.Buttons.VentHalf","Train.Buttons.VentFull"},varTooltip = function(ent) return ent:GetPackedRatio("PVK") end,},
        {ID = "!PVK",x=35,y=31,model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_common001.mdl",ang = 180,z=15,
            getfunc = function(ent) return ent:GetPackedRatio("PVK") end, var="PVK",speed=4,min=1,max=0.75,
            sndvol = 1,snd = function(val,val2) return "pvk"..val2 end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID="PVK+",x=35, y=0, w=35,h=62, tooltip="",states={"Train.Buttons.Off","Train.Buttons.VentHalf","Train.Buttons.VentFull"},varTooltip = function(ent) return ent:GetPackedRatio("PVK") end,},
    }
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
                model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",
                bscale = Vector(0.7,0.7,0.7),
                z=-5,
                var=button.var,
                color=button.col=="y" and Color(255,168,0) or button.col=="r" and Color(255,56,30) or button.col=="g" and Color(175,250,20) or Color(255,255,255),
            },
            sprite = {bright=0.5,size=0.25,scale=0.01,color=button.col=="y" and Color(255,168,0) or button.col=="r" and Color(255,56,30) or button.col=="g" and Color(175,250,20) or Color(255,255,255),z=-3,}
        }
        button.var=nil
    end
end
ENT.ButtonMap["BUP_MVSU"] = {
    pos = Vector(456.6,-27,-9.7),
    ang = Angle(0,-90,10.3),
    width = 25,
    height = 70,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "KDV",  x=8.5+6.15*0,y=0+4.44*4,  radius=3,col="g",var="BIKDV", tooltip="ДВ",},
        {ID = "BDV",  x=8.5+6.15*0,y=0+4.44*5,  radius=3,col="r",var="BINKDV", tooltip="ДВ",},
        {ID = "PB",   x=8.5+6.15*0,y=0+4.44*7,  radius=3,col="g",var="BIPB",  tooltip="ПБ",},
        {ID = "ARS",  x=8.5+6.15*0,y=0+4.44*8,  radius=3,col="r",var="BIARS", tooltip="АРС",},
        {ID = "AVT",  x=8.5+6.15*0,y=0+4.44*10, radius=3,col="r",var="BIAVT", tooltip="АВТ",},
        {ID = "KVV",  x=8.5+6.15*1,y=1+4.26*1,  radius=3,col="g",var="BIV",   tooltip="В",},
        {ID = "KVN",  x=8.5+6.15*1,y=1+4.26*2.1,  radius=3,col="g",var="BIN",   tooltip="Н",},
        {ID = "KVX3", x=8.5+6.15*1,y=0+4.46*4,  radius=3,col="g",var="BIX3",  tooltip="Х3",},
        {ID = "KVX2", x=8.5+6.15*1,y=0+4.46*5,  radius=3,col="g",var="BIX2",  tooltip="Х2",},
        {ID = "KVX1", x=8.5+6.15*1,y=0+4.46*6,  radius=3,col="g",var="BIX1",  tooltip="Х1",},
        {ID = "KV0",  x=8.5+6.15*1,y=0+4.46*7,  radius=3,col="g",var="BI0",   tooltip="0",},
        {ID = "KVT1", x=8.5+6.15*1,y=0+4.46*8,  radius=3,col="g",var="BIT1",  tooltip="Т1",},
        {ID = "KVT2", x=8.5+6.15*1,y=0+4.46*9,  radius=3,col="g",var="BIT2",  tooltip="Т2",},
        {ID = "KVT3", x=8.5+6.15*1,y=0+4.46*10, radius=3,col="g",var="BIT3",  tooltip="Т3",},
        {ID = "PVU",  x=8.5+6.15*1,y=1+4.26*12, radius=3,col="r",var="BIPVU", tooltip="ПВУ",},
        {ID = "RPB",  x=8.5+6.15*1,y=1+4.26*13.1,radius=3,col="r",var="BIRPB", tooltip="РПБ",},

        {ID = "ARSX", x=8.5+6.15*2,y=1+4.26*1,   radius=3,col="g",var="BIX",   tooltip="X",},
        {ID = "ARST", x=8.5+6.15*2,y=1+4.26*2.1, radius=3,col="r",var="BIT",   tooltip="T",},
        {ID = "ARSX3",x=8.5+6.15*2,y=0+4.46*4,   radius=3,col="g",var="BIBX3",  tooltip="Х3",},
        {ID = "ARSX2",x=8.5+6.15*2,y=0+4.46*5,   radius=3,col="g",var="BIBX2",  tooltip="Х2",},
        {ID = "ARSX1",x=8.5+6.15*2,y=0+4.46*6,   radius=3,col="g",var="BIBX1",  tooltip="Х1",},
        {ID = "ARS0", x=8.5+6.15*2,y=0+4.46*7,   radius=3,col="g",var="BIB0",   tooltip="0",},
        {ID = "ARST1",x=8.5+6.15*2,y=0+4.46*8,   radius=3,col="g",var="BIBT1",  tooltip="Т1",},
        {ID = "ARST2",x=8.5+6.15*2,y=0+4.46*9,   radius=3,col="g",var="BIBT2",  tooltip="Т2",},
        {ID = "ARST3",x=8.5+6.15*2,y=0+4.46*10,  radius=3,col="g",var="BIBT3",  tooltip="Т3",},
        {ID = "ROT",  x=8.5+6.15*2,y=1+4.26*12,  radius=3,col="r",var="BIROT", tooltip="РОТ",},
        {ID = "SOT",  x=8.5+6.15*2,y=1+4.26*13.1,radius=3,col="r",var="BISOT", tooltip="СОТ",},
    }
}

ENT.ButtonMap["BUP_MLUP"] = {
    pos = Vector(456.6,-27-1.8,-9.7),
    ang = Angle(0,-90,10.3),
    width = 10,
    height = 70,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "VP",   x=5+8*0,y=-1+4.8*3,     radius=3,col="g",var="BV",   tooltip="ВП",},
        {ID = "NZ",   x=5+8*0,y=-1+4.8*4,     radius=3,col="g",var="BN",   tooltip="НЗ",},
        {ID = "BUP",  x=5+8*0,y=-1+4.8*5,     radius=3,col="r",var="BBBUP", tooltip="БЛ БУП",},
        {ID = "V0",   x=5+8*0,y=-2.5+4.8*7-1, radius=3,col="r",var="BV0",   tooltip="V=0",},
        {ID = "KU",   x=5+8*0,y=-2.5+4.8*8-1, radius=3,col="r",var="BEKV",  tooltip="КУ",},
        {ID = "BAV",  x=5+8*0,y=-2.5+4.8*9-1, radius=3,col="r",var="BEBAV", tooltip="БАВ",},
        {ID = "KR",   x=5+8*0,y=-2.5+4.8*10-1,radius=3,col="r",var="BEKR",  tooltip="КР",},
        {ID = "ARS",  x=5+8*0,y=-2.5+4.8*11-1,radius=3,col="r",var="BEARS", tooltip="АРС",},
    }
}
ENT.ButtonMap["BUP_MUVS1"] = {
    pos = Vector(456.6,-27-2.75,-9.7),
    ang = Angle(0,-90,10.3),
    width = 10,
    height = 70,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "VP",   x=5+8*0,y=-0.7+4.7*3,  radius=3,col="g",var="BOV",   tooltip="ВП",},
        {ID = "NZ",   x=5+8*0,y=-0.7+4.7*4,  radius=3,col="g",var="BON",   tooltip="НЗ",},
        {ID = "X",    x=5+8*0,y= 0.9+4.7*5,radius=3,col="g",var="BOX",   tooltip="Х",},
        {ID = "T",    x=5+8*0,y= 0.9+4.7*6,radius=3,col="r",var="BOT",   tooltip="Т",},
        {ID = "U1",   x=5+8*0,y= 0.9+4.7*7,radius=3,col="g",var="BOU1",  tooltip="Уставка 1",},
        {ID = "U2",   x=5+8*0,y= 0.9+4.7*8,radius=3,col="g",var="BOU2",  tooltip="Уставка 2",},
        {ID = "BAV",  x=5+8*0,y= 2.2+4.7*9, radius=3,col="g",var="BOBBAV",tooltip="БЛ БАВ",},
        {ID = "BUP",  x=5+8*0,y= 2.2+4.7*10,radius=3,col="g",var="BOBBUP",tooltip="БЛ БУВ",},
    }
}
ENT.ButtonMap["BUP_MUVS2"] = {
    pos = Vector(456.6,-27-4.25,-9.7),
    ang = Angle(0,-90,10.3),
    width = 10,
    height = 70,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "0",    x=5+8*0,y=0.8+4.35*5.6,radius=3,col="g",var="BO0",   tooltip="Выбег",},
        {ID = "ZPT",  x=5+8*0,y=0.8+4.35*7.8,radius=3,col="r",var="BOZPT", tooltip="ЗПТ",},
    }
}
ENT.ButtonMap["BUP_MS"] = {
    pos = Vector(456.6,-27-5.15,-9.7),
    ang = Angle(0,-90,10.3),
    width = 10,
    height = 70,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "MS",    x=5+8*0,y=1.3+4.35*6,radius=3,col="g",var="BMS",   tooltip="Норма",},
    }
}
ENT.ButtonMap["BUP_MP"] = {
    pos = Vector(456.6,-27-6.68,-9.7),
    ang = Angle(0,-90,10.3),
    width = 10,
    height = 70,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "MP",    x=5+8*0,y=2.7+4.35*9,radius=3,col="g",var="BMP",   tooltip="Норма",},
    }
}
---[[
ENT.ButtonMap["BUV_MPS"] = {
    pos = Vector(378.5,-32,-28+43.5),
    ang = Angle(0,-90,90),
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
    pos = Vector(378.5,-32-1.8,-28+43.5),
    ang = Angle(0,-90,90),
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
    pos = Vector(378.5,-32-3,-28+43.5),
    ang = Angle(0,-90,90),
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
    pos = Vector(378.5,-32-4.8,-28+43.5),
    ang = Angle(0,-90,90),
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
    pos = Vector(378.5,-32-6.6,-28+43.5),
    ang = Angle(0,-90,90),
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
    pos = Vector(378.5,-32,-35+43.5),
    ang = Angle(0,-90,90),
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
    pos = Vector(378.5,-32-1.8,-35+43.5),
    ang = Angle(0,-90,90),
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
    pos = Vector(378.5,-32-3,-35+43.5),
    ang = Angle(0,-90,90),
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
    pos = Vector(378.5,-32-5.5,-35+43.5),
    ang = Angle(0,-90,90),
    width = 30,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "RTM", x=11+8*0,y=19+5*2,  radius=3,col="g",var="VORKT", tooltip="Управление реле минимального тока",},
        {ID = "RKT", x=11+8*0,y=19+5*3,  radius=3,col="g",var="VORMT", tooltip="Управление реле контроля торможения",},
        {ID = "RP",  x=11+8*0,y=19+5*4,  radius=3,col="r",var="VORP",  tooltip="Сработка защиты",},
        {ID = "OTK", x=11+8*0,y=19+5*5,  radius=3,col="r",var="VOOIZ",   tooltip="Отказ вагона",},
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

placeLamps("BUP_MVSU")
placeLamps("BUP_MLUP")
placeLamps("BUP_MUVS1")
placeLamps("BUP_MUVS2")
placeLamps("BUP_MS")
placeLamps("BUP_MP")

ENT.ButtonMap["DriverValveDisconnect"] = {
    pos = Vector(452.13,-27.45,-4.2-9),
    ang = Angle(0,-90,0),
    width = 259,
    height = 80,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "DriverValveDisconnectToggle", x=0, y=10, w=70, h=70, tooltip="Клапан разобщения", model = {
            var="DriverValveDisconnect",--sndid="brake_disconnect",
            sndvol = 1, snd = function(val) return "disconnect_valve" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            model = "models/metrostroi_train/81-718/disconnect_valve.mdl", ang=90,z=13,
            speed=4, min=1,max=0.75,
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
        {ID = "ParkingBrakeToggle", x=82.5, y=10, w=70, h=70, tooltip="Стояночный тормоз", model = {
            var="ParkingBrake",--sndid="brake_disconnect2",
            sndvol = 1, snd = function(val) return "disconnect_valve" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            model = "models/metrostroi_train/81-718/disconnect_valve.mdl", ang=90,z=13,
            speed=4, min=1,max=0.75,
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
        {ID = "EPKToggle", x=188, y=0, w=70, h=70, tooltip="ЭПВ: Электропневматический вентиль АРС", model = {
            var="EPK",--sndid="brake_disconnect2",
            sndvol = 1, snd = function(val) return "disconnect_valve" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            model = "models/metrostroi_train/81-718/disconnect_valve.mdl", ang=90,z=13,
            speed=4, min=1,max=0.75,
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
    }
}

ENT.ButtonMap["KR"] = {
    pos = Vector(460.3,28.5,-2.3-6.2), --446 -- 14 -- -0,5
    ang = Angle(0,-90,11),
    width = 180,
    height = 40,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "SBR14Set",x=20, y=20, radius=20, tooltip="Резервный ход 1", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl", vmin=1, vmax=0, z=-3,
            var="SBR14",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "SBR16Set",x=90, y=20, radius=20, tooltip="КАХ", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl", vmin=1, vmax=0, z=-3,
            var="SBR16",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "SBR15Set",x=160, y=20, radius=20, tooltip="Резервный ход 2", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl", vmin=1, vmax=0, z=-3,
            var="SBR15",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["BackPPZ"] = {
    pos = Vector(408,-55.3,49.75), --446 -- 14 -- -0,5
    ang = Angle(0,90,90),
    width = 450,
    height = 320,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "SF51Toggle",x=0*35.5, y=73, w=20,h=40, tooltip = "SF51: Основное питание АРС",},
        {ID = "SF52Toggle",x=1*35.5, y=73, w=20,h=40, tooltip = "SF52: Резервное питание АРС",},
        {ID = "SF53Toggle",x=2*35.5, y=73, w=20,h=40, tooltip = "SF53: Тормозные цепи АРС",},
        {ID = "SF60Toggle",x=3*35.5, y=73, w=20,h=40, tooltip = "SF60: 12V АРС",},
        {ID = "SF61Toggle",x=4*35.5, y=73, w=20,h=40, tooltip = "SF61: 50V АРС(ФММ1)",},
        {ID = "SF77Toggle",x=5*35.5, y=73, w=20,h=40, tooltip = "SF77: Аварийный ход основное управление",},
        {ID = "SF78Toggle",x=6*35.5, y=73, w=20,h=40, tooltip = "SF78: Аварийный ход резервное управление",},
        {ID = "SF40Toggle",x=7*35.5, y=73, w=20,h=40, tooltip = "SF40: Вентиль №2",},
        {ID = "SF41Toggle",x=8*35.5, y=73, w=20,h=40, tooltip = "SF41: Фары",},
        {ID = "SF8Toggle" ,x=9*35.5, y=73, w=20,h=40, tooltip = "SF8: Двери",},
        {ID = "SF10Toggle",x=10*35.5, y=73, w=20,h=40, tooltip = "SF10:Вентиляторы 1 группа"},
        {ID = "SF11Toggle",x=11*35.5, y=73, w=20,h=40, tooltip = "SF11:Вентиляторы 2 группа"},
        {ID = "SF7Toggle" ,x=12*35.5, y=73, w=20,h=40, tooltip = "SF7: ББЭ, Мотор-компрессор"},

        {ID = "SF50Toggle",x=0*35.5, y=275, w=20,h=40, tooltip = "SF50: Скоростимер",},
        {ID = "SF76Toggle",x=1*35.5, y=275, w=20,h=40, tooltip = "SF76: Пожарная сигнализация",},
        {ID = "SF73Toggle",x=2*35.5, y=275, w=20,h=40, tooltip = "SF73: Гребнесмазыватель",},
        {ID = "SF3Toggle" ,x=3*35.5, y=275, w=20,h=40, tooltip = "SF3: Вагонное питание, ЦУВ",},
        {ID = "SF71Toggle",x=4*35.5, y=275, w=20,h=40, tooltip = "SF71: Экстренная связь",},
        {ID = "SF63Toggle",x=5*35.5, y=275, w=20,h=40, tooltip = "SF63: Радиостанция",},
        {ID = "SF54Toggle",x=6*35.5, y=275, w=20,h=40, tooltip = "SF54: Радиооповещение 50А",},
        {ID = "SF65Toggle",x=7*35.5, y=275, w=20,h=40, tooltip = "SF65: Вентиляция кабины",},
        {ID = "SF55Toggle",x=8*35.5, y=275, w=20,h=40, tooltip = "SF55: СОТ-3",},
        {ID = "SF9Toggle" ,x=9*35.5, y=275, w=20,h=40, tooltip = "SF9: Управление поездом резервное",},
        {ID = "SF6Toggle",x=10*35.5, y=275, w=20,h=40, tooltip = "SF6: Управление поездом основное"},
        {ID = "SF5Toggle",x=11*35.5, y=275, w=20,h=40, tooltip = "SF5: Управление БКЦУ"},
        {ID = "SF2Toggle" ,x=12*35.5, y=275, w=20,h=40, tooltip = "SF2: Поездное питание"},
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
    pos = Vector(392,-25,-20),
    ang = Angle(0,270,90),
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
        --{ID = "SF56Toggle",x=25*0,y=60*1,w=25,h=45,tooltip=""},
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
        model = "models/metrostroi_train/81-720/button_av1.mdl",z=-25,
        var=button.ID:Replace("Toggle",""),speed=8,
        sndvol = 0.8,snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
    }
end
ENT.ButtonMap["VPU"] = {
    pos = Vector(407.4,-55.3,27),
    ang = Angle(0,90,93),
    width = 450,
    height = 100,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "SAP8Toggle",x=60, y=31, radius=10, tooltip="Освещение салона", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",z=-2,
            var="SAP8",speed=16,ang=180,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SAP13Toggle",x=91, y=31, radius=10, tooltip="Освещение кабины", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",z=-2,
            var="SAP13",speed=16,ang=180,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SAP36Toggle",x=245, y=31, radius=10, tooltip="Включение контроля экстренной связи", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",z=-2,
            var="SAP36",speed=16,ang=180,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SAP12Toggle",x=330, y=31, radius=10, tooltip="Освещение отсека", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",z=-2,
            var="SAP12",speed=16,ang=180,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SAP11Toggle",x=365, y=31, radius=10, tooltip="Включение отопления кабины", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",z=-2,
            var="SAP11",speed=16,ang=180,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SAP23Toggle",x=400, y=31, radius=10, tooltip="Режим \"Вспомогательный поезд\"", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",z=-2,
            var="SAP23",speed=16,ang=180,
            plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=270-30,x=-13,y=25,z=0,var="SAP23Pl", ID="SAP23Pl",},
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},


        {ID = "SAP9Toggle",x=60, y=85, radius=10, tooltip="Вентиляция 1 группа", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",z=-2,
            var="SAP9",speed=16,ang=180,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SAP10Toggle",x=91, y=85, radius=10, tooltip="Вентиляция 2 группа", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",z=-2,
            var="SAP10",speed=16,ang=180,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},

        {ID = "SAP3Toggle",x=116, y=85, radius=10, tooltip="УНЧ", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",z=-2,
            var="SAP3",speed=16,ang=180,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SAP39Toggle",x=165, y=85, radius=10, tooltip="КГ", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",z=-2,
            var="SAP39",speed=16,ang=180,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SBP22Set",x=209, y=80, radius=20, tooltip="Проверка работоспособности", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", vmin=1, vmax=0, z=-3,
            var="SBP22",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "SBP6Set",x=246, y=80, radius=20, tooltip="Резерв двери правые", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", vmin=1, vmax=0, z=-3,
            var="SBP6",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "SBP4Set",x=283, y=80, radius=20, tooltip="Резерв двери левые", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", vmin=1, vmax=0, z=-3,
            var="SBP4",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "SAP14Toggle",x=330, y=85, radius=10, tooltip="Переключение режима дешифратора АЛС (вверх 2/6, вниз 1/5)", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",z=-2,
            var="SAP14",speed=16,ang=180,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Freq1/5","Train.Buttons.Freq2/6"}
        }},
        {ID = "SAP26Toggle",x=365, y=85, radius=10, tooltip="УОС: Устройство ограничения скорости(езда без ЭПК\\ЭПВ)", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",z=-2,
            var="SAP26",speed=16,ang=180,
            plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=328,x=19,y=15,z=0,var="SAP26Pl", ID="SAP26Pl",},
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SAP24Toggle",x=400, y=85, radius=10, tooltip="ВОВТ: Выключатель отключения вентильных тормозов", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",z=-2,
            var="SAP24",speed=16,ang=180,vmin=1,vmax=0,
            plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=90-30,x=-1+13,y=-25,z=0,var="SAP24Pl", ID="SAP24Pl",},
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["Battery"] = {
    pos = Vector(404.0,-55.3,7.2),
    ang = Angle(0,90,0),
    width = 450,
    height = 100,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "RCToggle", x=150, y=40, radius=30, tooltip="РЦ-1: Разъединитель цепей АРС\nRC-1: ARS circuits disconnect", model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_common001.mdl",ang=180,z=12,
            var="RC",speed=1,vmin=1,vmax=0.87,
            plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=230,x=-34,y=34,var="RCPl",ID="RCPl",z=-14,},
            sndvol = 0.8, snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VBToggle", x=225, y=40, radius=30, tooltip="ВБ: Выключатель батареи\nVB: Battery on/off", model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_common005.mdl",ang=180,z=12,
            var="VB",speed=1,vmin=1,vmax=0.87,
            sndvol = 0.8, snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VTPR", x=300, y=40, radius=0, model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_common006.mdl",ang=180,z=12,
            var="VTPR",speed=2,min=1,max=0.61,getfunc = function(ent) return ent:GetPackedRatio("VTPR") end,
            sndvol = 0.8, snd = function(_,val) return val%2>0 and "pak_on" or "pak_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID="VTPR-",x=300-30, y=40-30, w=30,h=60, tooltip="ВТПР(влево)",states = {"Train.Buttons.0","Train.Buttons.VTRAll","Train.Buttons.VTRF","Train.Buttons.VTRB"},varTooltip = function(ent) return ent:GetPackedRatio("VTPR") end,},
        {ID="VTPR+",x=300   , y=40-30, w=30,h=60, tooltip="ВТПР(вправо)",states = {"Train.Buttons.0","Train.Buttons.VTRAll","Train.Buttons.VTRF","Train.Buttons.VTRB"},varTooltip = function(ent) return ent:GetPackedRatio("VTPR") end,},
    }
}

local strength = {
    [0] = 0.86,
    [1] = 0.29,
    [2] = 0.71,
    [3] = 0.71,
    [4] = 0.57,
    [5] = 0.71,
    [6] = 0.86,
    [7] = 0.43,
    [8] = 1.00,
    [9] = 0.86,
}
-- ARS/Speedometer panel
ENT.ButtonMap["ARS"] = {
    pos = Vector(459.95,7-4,4.9-9),
    ang = Angle(0,-90,90-14.971),
    width = 235,
    height = 85,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "!Speedometer1",  x=107,y=6,w=13,h=22,tooltip="Индикатор скорости", model = {
            name="SPU_Speed2",model = "models/metrostroi_train/81-717/segments/segment_mvm.mdl", color=Color(175,250,20),skin=0,z=1,ang=Angle(0,0,-90),
            tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.Speed"),math.floor(ent:GetPackedRatio("Speed")*100)) end,
            sprite = {bright=0.1,size=.5,scale=0.02,vscale=0.025,z=1,color=Color(225,250,20),aa=true,getfunc= function(ent)
                if not ent:GetPackedBool("Speedometer") then return 0 end
                return strength[math.floor(ent:GetPackedRatio("Speed")*10)%10]
            end},
        }},
        {ID = "!Speedometer2",  x=118,y=6,w=13,h=22,tooltip="Индикатор скорости", model = {
            name="SPU_Speed1",model = "models/metrostroi_train/81-717/segments/segment_mvm.mdl", color=Color(175,250,20),skin=0,z=1,ang=Angle(0,0,-90),
            tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.Speed"),math.floor(ent:GetPackedRatio("Speed")*100)) end,
            sprite = {bright=0.1,size=.5,scale=0.02,vscale=0.025,z=1,color=Color(225,250,20),aa=true,getfunc= function(ent)
                if not ent:GetPackedBool("Speedometer") then return 0 end
                return strength[math.floor(ent:GetPackedRatio("Speed")*100)%10]
            end},
        }},

        {ID = "!SD",       x=9,y=7,w=33,h=13,tooltip="СД: Лампа сигнализации дверей поезда (двери закрыты)",model = {
            name="SPU_SD",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/big_g.mdl",z=1, var="SPU_SD", getfunc=function(ent) return ent:GetPackedBool("SPU_SD") and (ent:GetPackedBool("VD1") and 1 or 0.8) or 0 end},
            sprite = {bright=0.5,size=0.25,scale=0.05,vscale=0.02,color=Color(125,200,15),z=-1,aa=true}
        }},
        {ID = "!KT",       x=48,y=7,w=33,h=13,tooltip="КТ: Лампа контроля торможения",model = {
            name="SPU_KT",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/big_g.mdl",z=1, var="SPU_KT", getfunc=function(ent) return ent:GetPackedBool("SPU_KT") and (ent:GetPackedBool("VD1") and 1 or 0.8) or 0 end},
            sprite = {bright=0.5,size=0.25,scale=0.05,vscale=0.02,color=Color(125,200,15),z=-1,aa=true}
        }},
        {ID = "!RS",       x=158.5,y=7,w=33,h=13,tooltip="РС: Лампа равенства скоростей",model = {
            name="SPU_RS",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/big_g.mdl",z=1, var="SPU_RS", getfunc=function(ent) return ent:GetPackedBool("SPU_RS") and (ent:GetPackedBool("VD1") and 1 or 0.8) or 0 end},
            sprite = {bright=0.5,size=0.25,scale=0.05,vscale=0.02,color=Color(125,200,15),z=-1,aa=true}
        }},
        {ID = "!SK",       x=196.5,y=7,w=33,h=13,tooltip="СН: Лампа соответствия направления движения",model = {
            name="SPU_SK",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/big_g.mdl",z=1, var="SPU_SN", getfunc=function(ent) return ent:GetPackedBool("SPU_SN") and (ent:GetPackedBool("VD1") and 1 or 0.8) or 0 end},
            sprite = {bright=0.5,size=0.25,scale=0.05,vscale=0.02,color=Color(125,200,15),z=-1,aa=true}
        }},

        {ID = "!04",       x=9,y=33.5,w=33,h=13,tooltip="ОЧ: Лампа отсутствия частоты",model = {
            name="SPU_04",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/big_r.mdl",z=1, var="SPU_04", getfunc=function(ent) return ent:GetPackedBool("SPU_04") and (ent:GetPackedBool("VD1") and 1 or 0.8) or 0 end},
            sprite = {bright=0.5,size=0.25,scale=0.05,vscale=0.02,color=Color(255,20,40),z=-1,aa=true}
        }},
        {ID = "!0",       x=48,y=33.5,w=33,h=13,tooltip="0: Лампа разрешённой скорости 0 км\\ч",model = {
            name="SPU_0",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/big_r.mdl",z=1, var="SPU_00", getfunc=function(ent) return ent:GetPackedBool("SPU_00") and (ent:GetPackedBool("VD1") and 1 or 0.8) or 0 end},
            sprite = {bright=0.5,size=0.25,scale=0.05,vscale=0.02,color=Color(255,20,40),z=-1,aa=true}
        }},
        {ID = "!40",       x=84,y=33.5,w=33,h=13,tooltip="40: Лампа разрешённой скорости 40 км\\ч",model = {
            name="SPU_40",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/big_y.mdl",z=1, var="SPU_40", getfunc=function(ent) return ent:GetPackedBool("SPU_40") and (ent:GetPackedBool("VD1") and 1 or 0.8) or 0 end},
            sprite = {bright=0.5,size=0.25,scale=0.05,vscale=0.02,color=Color(150,100,30),z=-1,aa=true}
        }},
        {ID = "!60",       x=121,y=33.5,w=33,h=13,tooltip="60: Лампа разрешённой скорости 60 км\\ч",model = {
            name="SPU_60",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/big_g.mdl",z=1, var="SPU_60", getfunc=function(ent) return ent:GetPackedBool("SPU_60") and (ent:GetPackedBool("VD1") and 1 or 0.8) or 0 end},
            sprite = {bright=0.5,size=0.25,scale=0.05,vscale=0.02,color=Color(125,200,15),z=-1,aa=true}
        }},
        {ID = "!70",       x=158.5,y=33.5,w=33,h=13,tooltip="70: Лампа разрешённой скорости 70 км\\ч",model = {
            name="SPU_70",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/big_g.mdl",z=1, var="SPU_70", getfunc=function(ent) return ent:GetPackedBool("SPU_70") and (ent:GetPackedBool("VD1") and 1 or 0.8) or 0 end},
            sprite = {bright=0.5,size=0.25,scale=0.05,vscale=0.02,color=Color(125,200,15),z=-1,aa=true}
        }},
        {ID = "!80",       x=196.5,y=33.5,w=33,h=13,tooltip="80: Лампа разрешённой скорости 80 км\\ч",model = {
            name="SPU_80",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/big_g.mdl",z=1, var="SPU_80", getfunc=function(ent) return ent:GetPackedBool("SPU_80") and (ent:GetPackedBool("VD1") and 1 or 0.8) or 0 end},
            sprite = {bright=0.5,size=0.25,scale=0.05,vscale=0.02,color=Color(125,200,15),z=-1,aa=true}
        }},

        {ID = "!KES",       x=15,y=60.5,w=18,h=13,tooltip="КЭС: Контроль экстренной связи",model = {
            name="SPU_KES",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/litlle_r.mdl",z=1, var="SPU_KES", getfunc=function(ent) return ent:GetPackedBool("SPU_KES") and (ent:GetPackedBool("VD1") and 1 or 0.8) or 0 end},
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.02,color=Color(255,20,40),z=-1,aa=true}
        }},
        {ID = "!ST",       x=34,y=60.5,w=18,h=13,tooltip="СТ: Применение пневматического торможения или сработка стояночного тормоза",model = {
            name="SPU_ST",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/litlle_r.mdl",z=1, var="SPU_ST", getfunc=function(ent) return ent:GetPackedBool("SPU_ST") and (ent:GetPackedBool("VD1") and 1 or 0.8) or 0 end},
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.02,color=Color(255,20,40),z=-1,aa=true}
        }},
        {ID = "!CUV",       x=53,y=60.5,w=18,h=13,tooltip="ЦУВ: Невключение ЦУВ на вагоне",model = {
            name="SPU_CUV",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/litlle_r.mdl",z=1, var="SPU_CUV"},
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.02,color=Color(255,20,40),z=-1,aa=true}
        }},
        {ID = "!AVU",       x=72,y=60.5,w=18,h=13,tooltip="АВУ: Сработка АВУ",model = {
            name="SPU_AVU",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/litlle_r.mdl",z=1, var="SPU_AVU", getfunc=function(ent) return ent:GetPackedBool("SPU_AVU") and (ent:GetPackedBool("VD1") and 1 or 0.8) or 0 end},
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.02,color=Color(255,20,40),z=-1,aa=true}
        }},
        {ID = "!AIP",       x=91,y=60.5,w=18,h=13,tooltip="АИП",model = {
            name="SPU_AIP",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/litlle_r.mdl",z=1, var="SPU_AIP"},
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.02,color=Color(255,20,40),z=-1,aa=true}
        }},

        {ID = "!RIP",       x=148,y=60.5,w=18,h=13,tooltip="РИП",model = {
            name="SPU_RIP",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/little_g.mdl",z=1, var="SPU_RIP"},
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.02,color=Color(125,200,15),z=-1,aa=true}
        }},
        {ID = "!KVD",       x=167,y=60.5,w=18,h=13,tooltip="КВД: Лампа выключения ходового режима системой АРС",model = {
            name="SPU_KVD",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/little_g.mdl",z=1, var="SPU_KVD", getfunc=function(ent) return ent:GetPackedBool("SPU_KVD") and (ent:GetPackedBool("VD1") and 1 or 0.8) or 0 end},
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.02,color=Color(125,200,15),z=-1,aa=true}
        }},
        {ID = "!VS1",       x=186,y=60.5,w=18,h=13,tooltip="ВС1: Выключенное состояние вентиляции 1 группы",model = {
            name="SPU_VS1",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/little_g.mdl",z=1, var="SPU_VS1"},
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.02,color=Color(125,200,15),z=-1,aa=true}
        }},
        {ID = "!VS2",       x=205,y=60.5,w=18,h=13,tooltip="ВС2: Выключенное состояние вентиляции 2 группы",model = {
            name="SPU_VS2",lamp = {speed=10,model = "models/metrostroi_train/81-718/lamps/little_g.mdl",z=1, var="SPU_VS2"},
            sprite = {bright=0.5,size=0.25,scale=0.03,vscale=0.02,color=Color(125,200,15),z=-1,aa=true}
        }},
    }
}
ENT.ButtonMap["BZOS"] = {
    pos = Vector(435.5,-62.6,-5.5),
    ang = Angle(0,180,90),
    width = 16,
    height = 60,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "!VH2",x=8, y=19, radius=4, tooltip="Лампа тревоги охранной сигнализации", model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl",z=-1,var="VH2",color=Color(255,56,30)},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(255,56,30),z=0,}
        }},
        {ID = "!VH1",x=8, y=30, radius=4, tooltip="Лампа включения охранной сигнализации", model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl",z=-1,var="VH1",color=Color(175,250,20)},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(175,250,20),z=0,}
        }},
        {ID = "SAB1Toggle",x=8, y=45, radius=8, tooltip="Выключатель охранной сигнализации", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=-4,
            var="SAB1",speed=16,
            sndvol = 0.5,snd = function(val) return val and "pnm_on" or "pnm_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["UAVAPanel"] = {
    pos = Vector(450,-48,-6),
    ang = Angle(0,270,90),
    width = 180,
    height = 200,
    scale = 0.0625,

    buttons = {
        {ID = "UAVAToggle",x=0, y=0, w=60, h=200, tooltip="УАВА: Включение автоматического выключателя автостопа", model = {
            plomb = {var="UAVAPl", ID="UAVAPl",},
            var="UAVA",
            sndid="UAVALever",sndvol = 1, snd = function(val) return val and "uava_on" or "uava_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "UAVACToggle",x=60, y=0, w=120, h=200, tooltip="Восстановление контактов УАВА",var="UAVAC",states={"Train.Buttons.UAVAOff","Train.Buttons.UAVAOn"}},
    }
}

ENT.ButtonMap["Stopkran"] = {
    pos = Vector(402,62,16.90),
    ang = Angle(0,0,90),
    width = 200,
    height = 1300,
    scale = 0.1/2,
        buttons = {
            {ID = "EmergencyBrakeValveToggle",x=0,y=0,w=200,h=1300,tooltip="", tooltip="",tooltip="",states={"Train.Buttons.Closed","Train.Buttons.Opened"},var="EmergencyBrakeValve"},
    }
}
ENT.ClientProps["stopkran"] = {
    model = "models/metrostroi_train/81-717/stop_mvm.mdl",
    pos = Vector(409.45,62.15,11.40),
    ang = Angle(0,0,0),
    hideseat=0.2,
}
ENT.ClientSounds["EmergencyBrakeValve"] = {{"stopkran",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}

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
ENT.ClientSounds["FrontBrakeLineIsolation"] = {{"FrontBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["FrontTrainLineIsolation"] = {{"FrontTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}

ENT.ButtonMap["RearPneumatic"] = {
    pos = Vector(-473-1,45.0,-58.0+5),
    ang = Angle(0,270,90),
    width = 900,
    height = 100,
    scale = 0.1,

    buttons = {
        {ID = "RearTrainLineIsolationToggle",x=500, y=0, w=400, h=100, tooltip="",var="RtI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
        {ID = "RearBrakeLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip="",var="RbI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
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
    hide = 2,
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
ENT.ButtonMap["CabinDoor"] = {
    pos = Vector(414.5,64,56.7),
    ang = Angle(0,0,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoor",x=0,y=0,w=642,h=2000, tooltip="Дверь в кабину машиниста", model = {
            var="door2",sndid="door2",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
ENT.ButtonMap["OtsekDoor1"] = {
    pos = Vector(394.5,26,11.6),
    ang = Angle(0,180,90),
    width = 310,
    height = 130,
    scale = 0.1/2,
    buttons = {
        {ID = "OtsekDoor1",x=0,y=0,w=310,h=130,tooltip="",model = {
            var="OtsekDoor1",sndid="door_otsek1",
            sndvol = 1,snd = function(val) return "otsek_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            states = {"Train.Buttons.Closed","Train.Buttons.Opened"}
        }},
    }
}
ENT.ButtonMap["OtsekDoor2"] = {
    pos = Vector(394.5,26,-14),
    ang = Angle(0,180,90),
    width = 310,
    height = 130,
    scale = 0.1/2,
    buttons = {
        {ID = "OtsekDoor2",x=0,y=0,w=310,h=130,tooltip="",model = {
            var="OtsekDoor2",sndid="door_otsek2",
            sndvol = 1,snd = function(val) return "otsek_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            states = {"Train.Buttons.Closed","Train.Buttons.Opened"}
        }},
    }
}

ENT.ButtonMap["PassengerDoor"] = {
    pos = Vector(390-12.2,29,50.6),--28
    ang = Angle(0,90,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=642,h=2000,tooltip="",model = {
            var="door3",sndid="door3",
            sndvol = 1,snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
ENT.ButtonMap["PassengerDoor1"] = {
    pos = Vector(390-12.2,29+32,50.6),--28
    ang = Angle(0,-90,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=642,h=2000,tooltip=""},
    }
}
ENT.ButtonMap["CabinDoor"] = {
    pos = Vector(411,64,50),
    ang = Angle(0,0,90),
    width = 665,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoor",x=0,y=0,w=665,h=2000,tooltip="",model = {
            var="door2",sndid="door2",
            sndvol = 1,snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
ENT.ButtonMap["RearDoor"] = {
    pos = Vector(-470-3,-16,48.4-2),
    ang = Angle(0,90,90),
    width = 642,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=642,h=1900,tooltip="",model = {
            var="door1",sndid="door1",
            sndvol = 1,snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
ENT.ButtonMap["PneumaticPanels"] = {
    pos = Vector(461,-23,6),
    ang = Angle(0,-108,90),
    width = 230,
    height = 120,
    scale = 0.0625,

    buttons = {
        {ID = "!BLTLPressure", x=65, y=62, radius=45, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BLTLPressure"),ent:GetPackedRatio("TLPressure")*16,ent:GetPackedRatio("BLPressure")*16) end},
        {ID = "!BCPressure", x=166, y=62, radius=45, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BCPressure"),ent:GetPackedRatio("BCPressure")*6) end},
    }
}
ENT.ButtonMap["HVMeters"] = {
    pos = Vector(430.3,-63,-5.5),
    ang = Angle(0,-180,90),
    width = 205,
    height = 30,
    scale = 0.0625,

    buttons = {
        {ID = "!I13", x=0, y=0, w=46, h=30, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesCurrent"),ent:GetPackedRatio("EnginesCurrent13")*1000-500) end},
        {ID = "!I24", x=52, y=0, w=46, h=30, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesCurrent"),ent:GetPackedRatio("EnginesCurrent24")*1000-500) end},
        {ID = "!HVVoltage", x=104, y=0, w=46, h=30, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesVoltage"),ent:GetPackedRatio("EnginesVoltage")*1000) end},
        {ID = "!BatteryCurrent", x=159, y=0, w=46, h=30, tooltip="", tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BatteryCurrent"),ent:GetPackedRatio("BatteryCurrent")*150) end},
    }
}
--------------------------------------------------------------------------------
ENT.ClientProps["brake013"] = {
    model = "models/metrostroi_train/81-717/cran13.mdl",
    pos = Vector(439,-24.3,-12.0),
    ang = Angle(0,-180,0),
    hideseat = 0.2,
}
if not ENT.ClientSounds["br_013"] then ENT.ClientSounds["br_013"] = {} end
table.insert(ENT.ClientSounds["br_013"],{"brake013",function(ent,_,var) return "br_013" end,0.7,1,50,1e3,Angle(-90,0,0)})
--------------------------------------------------------------------------------
ENT.ClientProps["ampermeter1"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(428.886963,-63.118961,-7.808218),
    ang = Angle(180.000000,0.000000,-90.000000),
    bscale = Vector(1,1,0.95),
    hideseat = 0.2,
}
ENT.ClientProps["ampermeter2"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(428.886963-3.16,-63.118961,-7.808218),
    ang = Angle(180.000000,0.000000,-90.000000),
    bscale = Vector(1,1,0.95),
    hideseat = 0.2,
}
ENT.ClientProps["voltmeter"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(428.886963-3.16*2.06,-63.118961,-7.91),
    ang = Angle(180.000000,0.000000,-90.000000),
    bscale = Vector(1,1,0.95),
    hideseat = 0.2,
}
ENT.ClientProps["ampermeter3"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(428.886963-3.16*3.145,-63.118961,-7.91),
    ang = Angle(180.000000,0.000000,-90.000000),
    bscale = Vector(1,1,0.95),
    hideseat = 0.2,
}
ENT.ClientProps["volt1"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(458.416321,7.570844,-8.262030),
    ang = Angle(0.000000,-90.000000,87.000000),
    bscale = Vector(1,1,1.47),
    hideseat = 0.2,
}



ENT.ClientProps["bortlamps1"] = {
    model = "models/metrostroi_train/81-718/bort_lamps_body.mdl",
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
    model = "models/metrostroi_train/81-718/bort_lamps_body.mdl",
    pos = Vector(39,-67,45.5),
    ang = Angle(0,180,0),
    hide = 2,
}
ENT.ClientProps["bortlamp2_w"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_b.mdl",
    pos = ENT.ClientProps.bortlamps2.pos+Vector(0,-0.85,3.2),
    ang = Angle(0,180,0),
    nohide = true,
}
ENT.ClientProps["bortlamp2_g"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_g.mdl",
    pos = ENT.ClientProps.bortlamps2.pos+Vector(0,-0.85,-0.1),
    ang = Angle(0,180,0),
    nohide = true,
}
ENT.ClientProps["bortlamp2_y"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_y.mdl",
    pos = ENT.ClientProps.bortlamps2.pos+Vector(0,-0.85,-3.35),
    ang = Angle(0,180,0),
    nohide = true,
}
--------------------------------------------------------------------------------
ENT.ClientProps["PB"] = {
    model = "models/metrostroi_train/81-707/pedal.mdl",
    pos = Vector(451.472687,19.217855,-38.302654),
    ang = Angle(0.000000,-90.000000,40.000000),
    hideseat=0.2,
}

if not ENT.ClientSounds["PB"] then ENT.ClientSounds["PB"] = {} end
table.insert(ENT.ClientSounds["PB"],{"PB",function(ent,var) return var > 0 and "pb_on" or "pb_off" end,1,1,35,1e3,Angle(-90,0,0)})
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
ENT.ClientProps["Lamp_RTM"] = {
    model = "models/metrostroi_train/81-717/rtmlamp.mdl",
    pos = Vector(408.6,-51.3,10.7),
    ang = Angle(0.000000,180.000000,0.000000),
    hideseat = 0.2,
}
ENT.ClientProps["door1"] = {
    model = "models/metrostroi_train/81-718/door_torec.mdl",
    pos = Vector(-473.749,15.924,-1.926),
    ang = Angle(0,-90,0),
    hide = 2,
}
ENT.ClientProps["door2"] = {
    model = "models/metrostroi_train/81-717/cab_door.mdl",
    pos = Vector(377.322,28.267,-1.599),
    ang = Angle(0,-90,0),
    hide = 2,
}
ENT.ClientProps["door3"] = {
    model = "models/metrostroi_train/81-718/door_cabine.mdl",
    pos = Vector(443.493,65.111,0.277),
    ang = Angle(0,-90,0),
    hide = 2,
}

ENT.ClientProps["UAVALever"] = {
    model = "models/metrostroi_train/81-703/cabin_uava.mdl",
    pos = Vector(451.8,-55.9,-15.6),
    ang = Angle(3,-180,0),
    hideseat=0.2,
}
ENT.ClientProps["E_informator"] = {
    model = "models/metrostroi_train/equipment/rri_informator_portable.mdl",
    pos = Vector(390,-29.5,-34),
    ang = Angle(0,180,0),
    hideseat=0.2,
}
ENT.ButtonMap["RRIScreen"] = {
    pos = ENT.ClientProps["E_informator"].pos-Vector(2,-2.9,-5),
    ang = Angle(0,-90,90),
    width = 121,
    height = 103,
    scale = 0.07,
    hide=true,
    hideseat=0.2,

    buttons = {
        {ID = "RRIUp",x=30,y=60,radius=10,tooltip=""},
        {ID = "RRIDown",x=30,y=80,radius=10,tooltip=""},
        {ID = "RRILeft",x=20,y=70,radius=10,tooltip=""},
        {ID = "RRIRight",x=40,y=70,radius=10,tooltip=""},
    }
}
ENT.ButtonMap["RRI"] = {
    pos = ENT.ClientProps["E_informator"].pos-Vector(-0.65,-0.5,-5),
    ang = Angle(0,-90,0),
    width = 60,
    height = 25,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        --[[ {ID = "RRIEnableToggle",x=10,y=12.5,radius=10,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",ang = 180,z=-4,
            var="RRIEnable",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "!RRIRewind",x=30,y=12.5,radius=0,model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_b_a.mdl",ang = 180,z=-3,
            getfunc = function(ent) return ent:GetPackedRatio("RRIRewind") end,
            var="RRIRewind",speed=8,
            sndvol = 0.5,snd = function(_,val) return val==2 and "triple_0-up" or val==0 and "triple_0-down" or "triple_up-0" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "RRIRewindSet2",x=30-5,y=12.5-10,w=10,h=10,tooltip=""},
        {ID = "RRIRewindSet0",x=30-5,y=12.5,w=10,h=10,tooltip=""},

        {ID = "RRIAmplifierToggle",x=50,y=12.5,radius=10,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",ang = 180,z=-4,
            var="RRIAmplifier",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},--]]
        {ID = "!RRIOn",x=70,y=12.5,radius=10,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",z = -13,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=62,x=-0.3,y=-0.3,z=20.6, var="RRIOn", color=Color(210,170,255)},
        }},
    }
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
    336.3,
}
for i = 0,27 do
    ENT.ClientProps["lamp1_"..i+1] = {
        model = "models/metrostroi_train/81-717/lamps/lamp_typ2.mdl",
        pos = Vector(xpos[math.floor(i/2)+1], 29.7-(i%2)*59.4, 63.3),
        ang = Angle(0,0,-8+(i%2)*16),
        hideseat = 1.1,
    }
end
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
        pos = Vector(yventpos[i],0,62),
        ang = Angle(0,0,0),
        hide = 1.1,
    }
end
ENT.ClientProps["lampcab1"] = {
    model = "models/metrostroi_train/81-717/lamps/lamp_typ2.mdl",
    pos = Vector(441.6,0,55.5),
    ang = Angle(0,-90,0),
    color=Color(214*1,181*1.1,124*1.1),
    hideseat=0.2,
}
ENT.ClientProps["lampcab2"] = {
    model = "models/metrostroi_train/81-717/lamps/lamp_typ2.mdl",
    pos = Vector(426.7,0,55.5),
    ang = Angle(0,-90,0),
    color=Color(214,181,124),
    hideseat=0.2,
}
ENT.Lights = {
    [40] = { "headlight",Vector(456.94,7.668623,-1.99856),Angle(124.000000,180.000000,0.000000),Color(54,135,0),farz = 9,nearz = 1,shadows = 0,brightness = 4,fov = 80, hidden = "volt1" },
    [41] = { "headlight",Vector(459.34,-28.504929,4.271693),Angle(122.713928,210.196899,45.703571),Color(255,130,25),farz = 9,nearz = 1,shadows = 1,brightness = 2,fov = 110, hidden = "brake_line" },
    [42] = { "headlight",Vector(457.08,-34.343376,4.464308),Angle(122.713928,210.196899,45.703571),Color(255,130,25),farz = 9,nearz = 1,shadows = 1,brightness = 2,fov = 110, hidden = "brake_line" },
    [43] = { "headlight",Vector(428.88,-62.986473,-4.12),Angle(96.323837,89.479485,-2.365463),Color(0,187,20),farz = 9,nearz = 1,shadows = 0,brightness = 2,fov = 80, hidden = "ampermeter1" },
    [44] = { "headlight",Vector(425.71,-62.986473,-4.12),Angle(96.323837,89.479485,-2.365463),Color(0,187,20),farz = 9,nearz = 1,shadows = 0,brightness = 2,fov = 80, hidden = "ampermeter2" },
    [45] = { "headlight",Vector(422.32,-62.986473,-4.12),Angle(96.323837,89.479485,-2.365463),Color(110,162,222),farz = 9,nearz = 1,shadows = 0,brightness = 2,fov = 80, hidden = "ampermeter3" },
    [46] = { "headlight",Vector(418.89,-62.986473,-4.12),Angle(96.323837,89.479485,-2.365463),Color(110,162,222),farz = 9,nearz = 1,shadows = 0,brightness = 2,fov = 80, hidden = "voltmeter" },
    -- Headlight glow
    [1] = { "headlight",        Vector(460,0,-40), Angle(0,0,0), Color(216,161,92), fov=90,farz=5144,brightness = 4, texture = "models/metrostroi_train/equipment/headlight",shadows = 1,headlight=true},
    [2] = { "headlight",        Vector(460,0,50), Angle(-20,0,0), Color(255,0,0), fov=160 ,brightness = 0.3, farz=450,texture = "models/metrostroi_train/equipment/headlight2",shadows = 0,backlight=true},

    [3] = { "headlight",        Vector(365,-9,50), Angle(50,40,-0), Color(206,135,80), hfov=80, vfov=80,farz=100,brightness = 6,shadows=1},
    [4] = { "headlight",        Vector(365,-51,50), Angle(50,40,-0), Color(206,135,80), hfov=80, vfov=80,farz=100,brightness = 6,shadows=1},

    -- Reverse
    [8] = { "light",Vector(465,-46.8, 52.8) , Angle(0,0,0), Color(255,50,50),     brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02", size = 2  },
    [9] = { "light",Vector(465, 47, 52.8)   , Angle(0,0,0), Color(255,50,50),     brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02", size = 2  },

    [11] = { "dynamiclight",    Vector( 200, 0, -0), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400 , fov=180,farz = 128, changable = true  },
    [12] = { "dynamiclight",    Vector(   0, 0, -0), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400, fov=180,farz = 128, changable = true  },
    [13] = { "dynamiclight",    Vector(-200, 0, -0), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400 , fov=180,farz = 128, changable = true  },

    [10] = { "dynamiclight",        Vector( 435, 0, 20), Angle(0,0,0), Color(216,161,92), distance = 550, brightness = 0.3,hidden = "Cabine"},
    -- Side lights
    [15] = { "light",Vector(-52,67,45.5)+Vector(0,0.9,3.25), Angle(0,0,0), Color(254,254,254), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [16] = { "light",Vector(-52,67,45.5)+Vector(0,0.9,-0.02), Angle(0,0,0), Color(40,240,122), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [17] = { "light",Vector(-52,67,45.5)+Vector(0,0.9,-3.3), Angle(0,0,0), Color(254,210,18), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [18] = { "light",Vector(39,-67,45.5)+Vector(0,-0.9,3.25), Angle(0,0,0), Color(254,254,254), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [19] = { "light",Vector(39,-67,45.5)+Vector(0,-0.9,-0.02), Angle(0,0,0), Color(40,240,122), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [20] = { "light",Vector(39,-67,45.5)+Vector(0,-0.9,-3.3), Angle(0,0,0), Color(254,210,18), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },

    [30]  = { "light",           Vector(465,-16,-29), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02", size = 2},
    [31]  = { "light",           Vector(465, 16,-29), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02", size = 2},

    Lamp_RTM = {"light", Vector(408.6,-51.3,10.7), Angle(0,0,0),Color(255,180,60),brightness = 0.4,scale = 0.03, texture = "sprites/light_glow02", hidden="Lamp_RTM"},
}

--[[
ENT.ClientProps["helper_light"] = {
    model = "models/props_junk/PopCan01a.mdl",
    pos = Vector(456.691284,14.138382,6.584029),
    ang = Angle(-136.613632,-95.636734,137.434570),
}]]

--ENT.AutoPos = {Vector(407.3,-10.5,47),Vector(419.3,-57.5,47.5)}
--local X = Material( "metrostroi_skins/81-717/6.png")

local tbl = {[0]=-0.25,0.00,0.04,0.09,0.13,0.17,0.20,0.27,0.33,0.42,0.56,0.73,1.00}
function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.RRIScreen = self:CreateRT("717RRI",128,128)

    self.CraneRamp = 0
    self.CraneRRamp = 0
    self.ReleasedPdT = 0
    self.EmergencyValveRamp = 0
    self.EmergencyValveEPKRamp = 0
    self.EmergencyBrakeValveRamp = 0
    self.FrontLeak = 0
    self.RearLeak = 0

    self.TISUVol = 0
    self.TISUFreq = 0

    self.VentCab = 0

    self.VentRand = {}
    self.VentState = {}
    self.VentVol = {}
    for i=1,7 do
        self.VentRand[i] = math.Rand(0.5,2)
        self.VentState[i] = 0
        self.VentVol[i] = 0
    end
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
function ENT:UpdateWagonNumber()
    local count = self.WagonNumber < 250 and 3 or 4
    for i=0,3 do
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

    self:SetLightPower(40,self:GetPackedBool("PanelLights"))
    self:SetLightPower(41,self:GetPackedBool("PanelLights"))
    self:SetLightPower(42,self:GetPackedBool("PanelLights"))
    self:SetLightPower(43,self:GetPackedBool("PanelLights"))
    self:SetLightPower(44,self:GetPackedBool("PanelLights"))
    self:SetLightPower(45,self:GetPackedBool("PanelLights"))
    self:SetLightPower(46,self:GetPackedBool("PanelLights"))

    local EL1 = self:Animate("Cablights1",self:GetPackedBool("Cablights1") and 1 or 0,0,1,6,false)
    local EL2 = self:Animate("Cablights2",self:GetPackedBool("Cablights2") and 1 or 0,0,1,6,false)
    self:ShowHideSmooth("lampcab1",EL1)
    self:ShowHideSmooth("lampcab2",EL2)
    local cabStrength = EL1*0.5+EL2*0.5
    self:SetLightPower(10,cabStrength > 0,cabStrength)

    local HL1 = self:Animate("Headlights1",self:GetPackedBool("Headlights1") and 1 or 0,0,1,6,false)
    local HL2 = self:Animate("Headlights2",self:GetPackedBool("Headlights2") and 1 or 0,0,1,6,false)
    local RL = self:Animate("RedLights_a",self:GetPackedBool("RedLights") and 1 or 0,0,1,6,false)
    self:ShowHideSmooth("Headlights_1",HL1)
    self:ShowHideSmooth("Headlights_2",HL2)
    local bright = HL1*0.5 + HL2*0.5
    self:SetLightPower(30,bright > 0,bright)
    self:SetLightPower(31,bright > 0,bright)

    self:ShowHideSmooth("RedLights",RL)
    self:SetLightPower(8,RL > 0,RL)
    self:SetLightPower(9,RL > 0,RL)

    local headlight = HL1*0.6+HL2*0.4
    self:SetLightPower(1,headlight>0,headlight)
    self:SetLightPower(2,self:GetPackedBool("RedLights"),RL)

    if IsValid(self.GlowingLights[1]) then
        if self:GetPackedRatio("Headlight") < 0.5 and self.GlowingLights[1]:GetFarZ() ~= 3144 then
            self.GlowingLights[1]:SetFarZ(3144)
        end
        if self:GetPackedRatio("Headlight") > 0.5 and self.GlowingLights[1]:GetFarZ() ~= 5144 then
            self.GlowingLights[1]:SetFarZ(5144)
        end
    end

    local RN = self:GetPackedBool("RouteNumberWork",false)

    self:ShowHide("route1",RN)
    self:ShowHide("route2",RN)
    self:ShowHide("route1_r",RN)
    self:ShowHide("route2_r",RN)
    self:ShowHide("route1_s",RN)
    self:ShowHide("route2_s",RN)

    local lamps_rtm = self:Animate("lamps_rtm",self:GetPackedBool("VPR") and 1 or 0,0,1,8,false)
    self:SetSoundState("vpr",lamps_rtm>0 and 1 or 0,1)
    self:ShowHideSmooth("Lamp_RTM",lamps_rtm or 0)
    self:SetLightPower("Lamp_RTM",lamps_rtm > 0, lamps_rtm)

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
    for i = 1,28 do
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
            self:SetLightPower(i, activeLights > 0,activeLights/28)
        end
    end
    self:Animate("brake_line", self:GetPackedRatio("BLPressure"), 0.14, 0.873,  64,12)--256,2)
    self:Animate("train_line", self:GetPackedRatio("TLPressure"),   0.145, 0.876,  64,12)--4096,2)
    self:Animate("brake_cylinder", self:GetPackedRatio("BCPressure"), 0.142, 0.874,  64,12)--64,12)

    self:Animate("brake013", Cpos[self:GetPackedRatio("B013")] or 0, 0.03, 0.458,  256,24)
    self:Animate("controller", (self:GetPackedRatio("Controller")+3)/6, 0.05, 0.33,  3,false)
    self:Animate("kr_wrench", self:GetPackedRatio("KR",0),0.3+0.05,0.8-0.05,  3,false)
    self:Animate("kru_wrench", self:GetPackedRatio("KRU",0),0.3+0.05,0.8-0.05,  3,false)
    self:ShowHide("kr_wrench",self:GetNW2Int("Wrench",0) == 1)
    self:ShowHide("kru_wrench",self:GetNW2Int("Wrench",0) == 2)

    self:Animate("volt1", self:GetPackedRatio("BatteryVoltage"), 0.867,0.626,45,2)
    self:Animate("voltmeter",self:GetPackedRatio("EnginesVoltage"),0.866, 0.621-0.008,nil,nil)
    self:Animate("ampermeter1",self:GetPackedRatio("EnginesCurrent13"),0.859+0.003, 0.625-0.003,nil,nil)
    self:Animate("ampermeter2",self:GetPackedRatio("EnginesCurrent24"),0.859+0.003, 0.625-0.003,nil,nil)
    self:Animate("ampermeter3",self:GetPackedRatio("BatteryCurrent"),0.859+0.01, 0.625-0.01,nil,nil)

    self:Animate("UAVALever",   self:GetPackedBool("UAVA") and 1 or 0,     0,0.6, 128,  3,false)
    self:Animate("PB",self:GetPackedBool("PB") and 1 or 0,0,0.2,  12,false)
    self:Animate("stopkran",   self:GetPackedBool("EmergencyBrakeValve") and 0 or 1,     0.25,0, 128,  3,false)
    --self:Animate("Autodrive",     self:GetPackedBool(132) and 1 or 0, 0,1, 16, false)

    local otsek1 = self:Animate("door_otsek1",self:GetPackedBool("OtsekDoor1") and 1 or 0,0,0.25,4,0.5)
    local otsek2 = self:Animate("door_otsek2",(self:GetPackedBool("OtsekDoor2") or self.CurrentCamera == 9) and 1 or 0,0,0.25,4,0.5)
    self:HidePanel("PVZ",otsek2<=0)
    self:HidePanel("BUV_MPS",otsek2<=0)
    self:HidePanel("BUV_MVD",otsek2<=0)
    self:HidePanel("BUV_MALP1",otsek2<=0)
    self:HidePanel("BUV_MALP2",otsek2<=0)
    self:HidePanel("BUV_MIV",otsek2<=0)
    self:HidePanel("BUV_MGR",otsek2<=0)
    self:HidePanel("BUV_MLUA",otsek2<=0)
    self:HidePanel("BUV_MUVK1",otsek2<=0)
    self:HidePanel("BUV_MUVK2",otsek2<=0)

    self:HidePanel("RRI",otsek2<=0)
    self:HidePanel("RRIScreen",otsek2<=0)
    self:ShowHide("E_informator",otsek2>0)

    local door1 = self:Animate("door1",self:GetPackedBool("RearDoor") and 1 or 0,0,0.25,4,0.5)
    local door2 = self:Animate("door2",self:GetPackedBool("PassengerDoor") and 1 or 0,1,0.8,4,0.5)
    local door3 = self:Animate("door3",self:GetPackedBool("CabinDoor") and 1 or 0,0,0.25,4,0.5)
    if self.Door1 ~= (door1 > 0) then
        self.Door1 = door1 > 0
        self:PlayOnce("door1","bass",self.Door1 and 1 or 0)
    end
    if self.Door2 ~= (door2 < 1) then
        self.Door2 = door2 < 1
        self:PlayOnce("door2","bass",self.Door2 and 1 or 0)
    end
    if self.Door3 ~= (door3 > 0) then
        self.Door3 = door3 > 0
        self:PlayOnce("door3","bass",self.Door3 and 1 or 0)
    end
    if self.Otsek1 ~= (otsek1 > 0) then
        self.Otsek1 = otsek1 > 0
        if not self.Otsek1 then
            self:PlayOnce("door_otsek1","bass",1)
        end
    end
    if self.Otsek2 ~= (otsek2 > 0) then
        self.Otsek2 = otsek2 > 0
        if not self.Otsek2 then
            self:PlayOnce("door_otsek2","bass",1)
        end
    end

    self:SetLightPower(3,self.Otsek1 and self:GetPackedBool("AppLights"))
    self:SetLightPower(4,self.Otsek2 and self:GetPackedBool("AppLights"))
    self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,1, 3, false)
    self:Animate("FrontTrain",  self:GetNW2Bool("FtI") and 1 or 0,0,1, 3, false)
    self:Animate("RearBrake",   self:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    self:Animate("RearTrain",   self:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)


    self:ShowHide("SPU_Speed1",self:GetPackedBool("Speedometer"))
    self:ShowHide("SPU_Speed2",self:GetPackedBool("Speedometer"))
    if self:GetPackedBool("Speedometer") then
        local speed = self:GetPackedRatio("Speed")*100.0
        if IsValid(self.ClientEnts["SPU_Speed1"])then self.ClientEnts["SPU_Speed1"]:SetSkin(math.floor(speed)%10) end
        if IsValid(self.ClientEnts["SPU_Speed2"])then self.ClientEnts["SPU_Speed2"]:SetSkin(math.floor(speed/10)) end
    end
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

    --[[local dT = self.DeltaTime
    --self.TunnelCoeff = 0.8
    --self.StreetCoeff = 0
    local rollingi = math.min(1,self.TunnelCoeff+math.Clamp((self.StreetCoeff-0.82)/0.3,0,1))
    local rollings = math.max(self.TunnelCoeff*0.6,self.StreetCoeff)
    --if self:EntIndex() == 3239 then LocalPlayer():ChatPrint(Format("T: %.2f, S: %.2f",rollingi,rollings)) end
    -- Brake-related sounds
    local dT = self.DeltaTime
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
    self:SetSoundState("rolling_80",rollingi*rol80,rol80p)]]

    local dT = self.DeltaTime
    local rollingi = math.min(1,self.TunnelCoeff+math.Clamp((self.StreetCoeff-0.82)/0.3,0,1))
    local rollings = math.max(self.TunnelCoeff*0.6,self.StreetCoeff)
    local speed = self:GetPackedRatio("Speed")*100.0
    local rol5 = math.Clamp(speed/1,0,1)*(1-math.Clamp((speed-3)/8,0,1))
    local rol10 = math.Clamp(speed/12,0,1)*(1-math.Clamp((speed-25)/8,0,1))
    local rol40p = Lerp((speed-25)/12,0.6,1)
    --local rol40 = math.Clamp((speed-23)/8,0,1)*(1-math.Clamp((speed-55)/8,0,1))
    --local rol40p = Lerp((speed-23)/50,0.6,1)
    --local rol70 = math.Clamp((speed-50)/8,0,1)*(1-math.Clamp((speed-72)/5,0,1))
    --local rol70p = Lerp(0.8+(speed-65)/25*0.2,0.8,1.2)
    --local rol80 = math.Clamp((speed-70)/5,0,1)
    --local rol80p = Lerp(0.8+(speed-72)/15*0.2,0.8,1.2)
    self:SetSoundState("rolling_5",math.min(1,rollingi*(1-rollings)+rollings*0.8)*rol5,1)
    self:SetSoundState("rolling_10",rollingi*rol10,1)
    --self:SetSoundState("rolling_40",0*rollingi*rol40,rol40p)
    --self:SetSoundState("rolling_70",0*rollingi*rol70,rol70p)
    --self:SetSoundState("rolling_80",0*rollingi*rol80,rol80p)


    local rol32 = math.Clamp((speed-25)/13,0,1)*(1-math.Clamp((speed-40)/10,0,1))
    local rol32p = Lerp((speed-20)/50,0.8,1.2)
    local rol68 = math.Clamp((speed-40)/10,0,1)*(1-math.Clamp((speed-50)/20,0,1))
    local rol68p = Lerp(0.6+(speed-68)/26*0.2,0.6,1.4)
    local rol75 = math.Clamp((speed-55)/20,0,1)
    local rol75p = Lerp(0.8+(speed-75)/15*0.2,0.6,1.2)
    self:SetSoundState("rolling_32",rollingi*rol32,rol32p)
    self:SetSoundState("rolling_68",rollingi*rol68,rol68p)
    self:SetSoundState("rolling_75",rollingi*rol75,rol75p)
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
    local emer_brake = math.Clamp((self.EmergencyValveRamp-0.9)/0.05,0,1)
    local emer_brake2 = math.Clamp((self.EmergencyValveRamp-0.2)/0.4,0,1)*(1-math.Clamp((self.EmergencyValveRamp-0.9)/0.1,0,1))
    self:SetSoundState("emer_brake",emer_brake,1)
    self:SetSoundState("emer_brake2",emer_brake2,math.min(1,0.8+0.2*emer_brake2))
    --self:SetSoundState("emer_brake",self.EmergencyValveRamp*0.8,1)
    --self:SetSoundState("emer_brake",self.EmergencyValveRamp*0.8,1)
    -- Compressor
    self:SetSoundState("compressor",self:GetPackedBool("Compressor") and 0.6 or 0,1)
    self:SetSoundState("compressor2",self:GetPackedBool("Compressor") and 0.8 or 0,1)

    local vCstate = self:GetPackedRatio("M1")/2
    if self.VentCab < vCstate then
        self.VentCab = math.min(1,self.VentCab + dT/2.7)
    elseif self.VentCab > vCstate then
        self.VentCab = math.max(0,self.VentCab - dT/2.7)
    end
    self:SetSoundState("vent_cabl",math.Clamp(self.VentCab*2,0,1) ,1)
    self:SetSoundState("vent_cabh",math.Clamp((self.VentCab-0.5)*2,0,1),1)

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

    self:SetSoundState("ring",(self:GetPackedBool("Ring") or self:GetPackedBool("RingBZOS") and RealTime()%0.8<0.35) and 1 or 0,0.95)

    self:SetSoundState("bpsn",self:GetPackedBool("BBE") and 1 or 0,1.0) --FIXME громкость по другому

    local cabspeaker = self:GetPackedBool("AnnCab")
    local work = self:GetPackedBool("AnnPlay")
    local buzz = self:GetPackedBool("AnnBuzz") and self:GetNW2Int("AnnouncerBuzz",-1) > 0
    for k in ipairs(self.AnnouncerPositions) do
        self:SetSoundState("announcer_buzz"..k,(buzz and (k ~= 1 and work or k==1 and cabspeaker)) and 1 or 0,1)
    end
    for k,v in ipairs(self.AnnouncerPositions) do
        if IsValid(self.Sounds["announcer"..k]) then
            self.Sounds["announcer"..k]:SetVolume((k ~= 1 and work or k==1 and cabspeaker) and (v[3] or 1)  or 0)
        end
    end
end

function ENT:OnAnnouncer(volume,id)
    local cabspeaker = self:GetPackedBool("AnnCab")
    local work = self:GetPackedBool("AnnPlay")
    return (id ~= 1 and work or id == 1 and cabspeaker) and volume  or 0
end

function ENT:Draw()
    self.BaseClass.Draw(self)
end
function ENT:DrawPost()
    self.RTMaterial:SetTexture("$basetexture", self.RRIScreen)
    self:DrawOnPanel("RRIScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(64,64,128,128,0)
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
    if location == "bass" then
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
        if soundid == "UAVAC" then
            return "uava_reset",location,range,pitch
        end
    end
    return soundid,location,range,pitch
end
Metrostroi.GenerateClientProps()

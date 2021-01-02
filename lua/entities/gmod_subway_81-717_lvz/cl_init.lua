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


ENT.ClientProps["salon"] = {
    model = "models/metrostroi_train/81-717/interior_spb.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["salon_add"] = {
    model = "models/metrostroi_train/81-717/717_spb_features.mdl",
    pos = Vector(-48.5,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["osp_label"] = {
    model = "models/metrostroi_train/81-717/labels/label_spb1.mdl",
    pos = Vector(374.470795,42.140141,53.182781),
    ang = Angle(0.000000,0.000000,0.000000),
    hide=1,
}
ENT.ClientProps["body_additional"] = {
    model = "models/metrostroi_train/81-717/717_body_additional_spb_013.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["uss_lamps1"] = {
    model = "models/metrostroi_train/81-717/lamps_nvl2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=1,
}
ENT.ButtonMap["USS1"] = {
    pos = Vector(459.08,-26.07,17.8),
    ang = Angle(0,-127,90),
    width = 40,
    height = 70,
    scale = 0.0588,
    hideseat = 0.2,

    buttons = {
        {ID = "!NMPressureLow", x=20, y=7, radius=8, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",z = -3.8,color = Color(255,50,45), var="NMLow"},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(255,50,45),z=-1.4,}
        }},
        {ID = "!UAVATriggered", x=20, y=34, radius=8, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",z = -3.8,color = Color(255,50,45), var="UAVATriggered"},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(255,50,45),z=-1.4,}
        }},
    }
}
ENT.ClientProps["uss_lamps2"] = {
    model = "models/metrostroi_train/81-717/lamps_nvl1.mdl",
    pos = Vector(-0.15,0,0.4),
    ang = Angle(0,0,0),
    hideseat=1,
}
ENT.ClientProps["schemes"] = {
    model = "models/metrostroi_train/81-717/labels/schemes.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
    callback = function(ent)
        ent.PassSchemesDone = false
    end,
}
ENT.ClientProps["sosd_lamp"] = {
    model = "models/metrostroi_train/81-717/sosd_lamp.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["brake_valve_334"] = {
    model = "models/metrostroi_train/81-717/brake_valves/334.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=1,
}
ENT.ClientProps["brake_valve_013"] = {
    model = "models/metrostroi_train/81-717/brake_valves/013.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=1,
}
ENT.ClientProps["lamps"] = {
    model = "models/metrostroi_train/81-717/lamps_type1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=1.5,
}
ENT.ClientProps["seats_old"] = {
    model = "models/metrostroi_train/81-717/couch_old.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=1.5,
}
ENT.ClientProps["seats_old_cap"] = {
    model = "models/metrostroi_train/81-717/couch_cap_l.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=0.8,
}
ENT.ClientProps["seats_new"] = {
    model = "models/metrostroi_train/81-717/couch_new.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=1.5,
    callback = function(ent)
        ent.NewBlueSeats = false
    end,
}
ENT.ClientProps["seats_new_cap"] = {
    model = "models/metrostroi_train/81-717/couch_new_cap.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=0.8,
    callback = function(ent)
        ent.NewBlueSeats = false
    end,
}
ENT.ClientProps["handrails_old"] = {
    model = "models/metrostroi_train/81-717/handlers_old.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=1.5,
}
ENT.ClientProps["handrails_new"] = {
    model = "models/metrostroi_train/81-717/handlers_new.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=1.5,
}
ENT.ClientProps["mask222_lvz"] = {
    model = "models/metrostroi_train/81-717/mask_spb_222.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["mask22_1"] = {
    model = "models/metrostroi_train/81-717/mask_22.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["mask22_2"] = {
    model = "models/metrostroi_train/81-717/mask_22s.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["Headlights222_1"] = {
    model = "models/metrostroi_train/81-717/lamps/headlights_222_group1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["Headlights222_2"] = {
    model = "models/metrostroi_train/81-717/lamps/headlights_222_group2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["Headlights22_1"] = {
    model = "models/metrostroi_train/81-717/lamps/headlights_22_group2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["Headlights22_2"] = {
    model = "models/metrostroi_train/81-717/lamps/headlights_22_group1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["RedLights"] = {
    model = "models/metrostroi_train/81-717/lamps/redlights.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
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
ENT.ClientProps["door1"] = {
    model = "models/metrostroi_train/81-717/door_torec_spb.mdl",
    pos = Vector(-472.5,15.75,-2.7),
    ang = Angle(0,-90,0),
    hide=2,
}
ENT.ClientProps["door2"] = {
    model = "models/metrostroi_train/81-717/cab_door.mdl",
    pos = Vector(377.322,28.267,-1.599),
    ang = Angle(0,-90,0),
    hide=2,
}
ENT.ClientProps["door3"] = {
    model = "models/metrostroi_train/81-717/door_cabine_spb.mdl",
    pos = Vector(443.493,65.111,0.277),
    ang = Angle(0,-90,0),
    hide=2,
}
ENT.ClientProps["cabine_old"] = {
    model = "models/metrostroi_train/81-717/cabine_spb_central.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["cabine_new"] = {
    model = "models/metrostroi_train/81-717/cabine_kvr.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["Controller_body"] = {
    model = "models/metrostroi_train/81-717/pult/body_spb_yellow.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2.5,
}
ENT.ClientProps["Controller_panel_old"] = {
    model = "models/metrostroi_train/81-717/pult/pult_spb_yellow.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color=Color(255,255,255),
    hideseat=0.8,
}
ENT.ClientProps["Controller_panel_new"] = {
    model = "models/metrostroi_train/81-717/pult/pult_spb_new.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color=Color(255,235,230),
    hideseat=0.8,
}
ENT.ClientProps["Controller_puav"] = {
    model = "models/metrostroi_train/81-717/pult/puav_new.mdl",
    pos = Vector(0.2,-0.2,0.1),
    ang = Angle(0,0,0),
    hideseat=0.8,
}
ENT.ClientProps["Controller_puav1"] = {
    model = "models/metrostroi_train/81-717/pult/puav_old.mdl",
    pos = Vector(454.172425-6,0.080645,0.967742-5.4),
    ang = Angle(0,0,0),
    hideseat=0.2,
}
ENT.ClientProps["SPBARS"] = {
    model = "models/metrostroi_train/81-717/pult/ars_spb_yellow.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=0.8,
}
ENT.ClientProps["Controller"] = {
    model = "models/metrostroi_train/81-717/kv_white.mdl",
    pos = Vector(435.848,16.1,-19.779+4.75),
    ang = Angle(0,-90,-32),
    hideseat=0.2,
}

ENT.ButtonMap["Block5_6_old"] = {
    pos = Vector(455.0-6,12.3,2.5-10.5+5.35),--446 -- 14 -- -0,5
    ang = Angle(0,-90,44),
    width = 480,
    height = 225,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "1:R_UPOToggle",x=43+24*0,y=40,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=-3,
            var="R_UPO",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:R_VPRToggle",x=43+24*1,y=40,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=-3,
            var="R_VPR",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=90+70,x=-1-20,y=-24+12,z=-1,var="R_VPRPl",ID="R_VPRPl",},
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:R_GToggle",x=43+24*2,y=40,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=-3,
            var="R_G",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},

        {ID = "1:KVTSet",x=292,y=40,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",z = -3,
            var="KVT",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button1_off" end,
            sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},

        {ID = "!OhSigLamp1",x=332,y=40,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",z = -10,color=Color(127,127,127),
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=63,x=-0.3,y=-0.3,z=20.6,var="OhSigLamp",color=Color(255,60,40)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(255,60,40)},
        }},
        {ID = "1:VZ1Set",x=370,y=35--[[ 40--]] ,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="VZ1",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button2_off" end,
            sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "!SPLight1",x=408,y=40,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",ignorepanel = true,skin = 1,z = -10,color=Color(127,127,127),
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=63,x=-0.3,y=-0.3,z=20.6,var="LSP",color=Color(100,255,50)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(100,255,50)},
        }},

        {ID = "1:OhrSigToggle",x=349,y=66,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=-5,
            var="OhrSig",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},

        {ID = "1:VUD1Toggle",x=62,y=101,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-5,ang=0,
            var="VUD1",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            states={"Train.Buttons.Unlocked","Train.Buttons.Locked"},
        }},
        {ID = "1:KDLSet",x=62,y=173,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/button_717_3.mdl",
            var="KDL",speed=16,vmin=1,vmax=0,z=-2,
            lamp = {model = "models/metrostroi_train/81-717/buttons/lamp_button_1.mdl",anim=true,var="DoorsLeftL",speed=9,z=2.2,color=Color(255,130,80),
            lcolor=Color(255,110,40),lz = 8,lfov=145,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.2,size=.485,scale=0.1,z=5,color=Color(255,130,80)},
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:KDLKToggle",x=42,y=183,w=40,h=20,tooltip="",model = {
            var="KDLK",speed=8,min=0.32,max=0.678,disable="1:KDLSet",
            model = "models/metrostroi_train/81/krishka.mdl",ang = 0,z = -2.5,
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
        {ID = "1:KDLRSet",x=155,y=173,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/button_717_3.mdl",
            var="KDLR",speed=16,vmin=1,vmax=0,z=-2,
            lamp = {model = "models/metrostroi_train/81-717/buttons/lamp_button_1.mdl",anim=true,var="DoorsLeftL",speed=9,z=2.2,color=Color(255,130,80),
            lcolor=Color(255,110,40),lz = 8,lfov=145,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.2,size=.485,scale=0.1,z=5,color=Color(255,130,80)},
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:KDLRKToggle",x=135,y=183,w=40,h=20,tooltip="",model = {
            model = "models/metrostroi_train/81/krishka.mdl",ang = 0,z = -2.5,
            var="KDLRK",speed=8,min=0.32,max=0.678,disable="1:KDLRSet",
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
        {ID = "1:DoorSelectToggle",x=107,y=184,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-8,
            var="DoorSelect",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            states={"Train.Buttons.Left","Train.Buttons.Right"}
        }},
        {ID = "1:KRZDSet",x=155,y=86,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="KRZD",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:VozvratRPSet",x=107,y=131,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="VozvratRP",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},

        {ID = "!GreenRPLight1",x=155,y=134,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",z = -6,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=2,x=-0.3,y=-0.3,z=20.6,var="GRP",color=Color(100,255,100)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(100,255,100)},
        }},
        {ID = "!RZPLight1",x=332,y=98,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",z = -6,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=63,x=-0.3,y=-0.3,z=20.6,var="RZP",color=Color(255,60,40)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(255,60,40)},
        }},
        {ID = "!LKVPLight1",x=377,y=98,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",z = -6,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=25,x=-0.3,y=-0.3,z=20.6,var="LKVP",color=Color(255,170,110)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(255,170,110)},
        }},

        {ID = "1:ConverterProtectionSet",x=332,y=133,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z=-3,
            var="ConverterProtection",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:KSNSet",x=377,y=133,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z=-3,
            var="KSN",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button1_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:RingSet",x=422,y=133,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z=-3,
            var="Ring",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},

        {ID = "1:ARSToggle",x=234,y=134,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-6,ang=180,
            var="ARS",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:ALSToggle",x=265,y=134,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",ang = 180,z=-6,
            var="ALS",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "!AVULight1",x=297,y=134,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",skin = 1,z = -10,color=Color(127,127,127),
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=62,x=-0.3,y=-0.3,z=20.6,var="AVU",color=Color(255,60,40)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(255,60,40)},
        }},

        {ID = "1:OVTToggle",x=240.2,y=181.2,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-8,ang=180,
            var="OVT",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=24,z=2,var="OVTPl",ID="OVTPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:OtklAVUToggle",x=278.2,y=181.2,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-8,ang=180,
            var="OtklAVU",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=24,z=2,var="OtklAVUPl",ID="OtklAVUPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:L_1Toggle",x=316.3,y=181.2,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-8,
            var="L_1",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:L_2Toggle",x=354,y=181.2,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-8,
            var="L_2",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:L_3Toggle",x=392,y=181.2,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-8,
            var="L_3",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["Block5_6_old_paksd"] = {
    pos = Vector(455.0-6,12.3,2.5-10.5+5.35),--446 -- 14 -- -0,5
    ang = Angle(0,-90,44),
    width = 480,
    height = 225,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "3:R_VPRToggle",x=40+24*1,y=40,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=-3,
            var="R_VPR",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=90+70,x=-1-20,y=-24+12,z=-1,var="R_VPRPl",ID="R_VPRPl",},
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "3:R_GToggle",x=40+24*2,y=40,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=-3,
            var="R_G",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "3:R_UPOToggle",x=47+24*3,y=40,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=-3,
            var="R_UPO",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},

        {ID = "3:KVTSet",x=290,y=40,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",z = -3,
            var="KVT",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button1_off" end,
            sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},

        {ID = "3:VZ1Set",x=370,y=35--[[ 40--]] ,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="VZ1",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button2_off" end,
            sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "!SPLight3",x=408,y=40,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",ignorepanel = true,skin = 1,z = -10,color=Color(127,127,127),
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=63,x=-0.3,y=-0.3,z=20.6,var="LSP",color=Color(100,255,50)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(100,255,50)},
        }},

        {ID = "!AVULight3",x=352,y=70,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",skin = 1,z = -10,color=Color(127,127,127),
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=62,x=-0.3,y=-0.3,z=20.6,var="AVU",color=Color(255,60,40)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(255,60,40)},
        }},

        {ID = "3:VUD1Toggle",x=62,y=101,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-5,ang=0,
            var="VUD1",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            states={"Train.Buttons.Unlocked","Train.Buttons.Locked"},
        }},
        {ID = "3:KDLSet",x=62,y=173,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/button_717_3.mdl",
            var="KDL",speed=16,vmin=1,vmax=0,z=-2,
            lamp = {model = "models/metrostroi_train/81-717/buttons/lamp_button_1.mdl",anim=true,var="DoorsLeftL",speed=9,z=2.2,color=Color(255,130,80),
            lcolor=Color(255,110,40),lz = 8,lfov=145,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.2,size=.485,scale=0.1,z=5,color=Color(255,130,80)},
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "3:KDLKToggle",x=42,y=183,w=40,h=20,tooltip="",model = {
            var="KDLK",speed=8,min=0.32,max=0.678,disable="3:KDLSet",
            model = "models/metrostroi_train/81/krishka.mdl",ang = 0,z = -2.5,
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
        {ID = "3:KDLRSet",x=155,y=173,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/button_717_3.mdl",
            var="KDLR",speed=16,vmin=1,vmax=0,z=-2,
            lamp = {model = "models/metrostroi_train/81-717/buttons/lamp_button_1.mdl",anim=true,var="DoorsLeftL",speed=9,z=2.2,color=Color(255,130,80),
            lcolor=Color(255,110,40),lz = 8,lfov=145,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.2,size=.485,scale=0.1,z=5,color=Color(255,130,80)},
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "3:KDLRKToggle",x=135,y=183,w=40,h=20,tooltip="",model = {
            model = "models/metrostroi_train/81/krishka.mdl",ang = 0,z = -2.5,
            var="KDLRK",speed=8,min=0.32,max=0.678,disable="3:KDLRSet",
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
        {ID = "3:DoorSelectToggle",x=107,y=184,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-8,
            var="DoorSelect",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            states={"Train.Buttons.Left","Train.Buttons.Right"}
        }},
        {ID = "3:KRZDSet",x=155,y=86,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="KRZD",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "3:VozvratRPSet",x=111,y=131,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="VozvratRP",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button1_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},

        {ID = "!GreenRPLight3",x=155,y=134,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",z = -6,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=2,x=-0.3,y=-0.3,z=20.6,var="GRP",color=Color(100,255,100)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(100,255,100)},
        }},
        {ID = "!RZPLight3",x=332,y=98,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",z = -6,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=63,x=-0.3,y=-0.3,z=20.6,var="RZP",color=Color(255,60,40)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(255,60,40)},
        }},
        {ID = "!LKVPLight3",x=377,y=98,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",z = -6,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=25,x=-0.3,y=-0.3,z=20.6,var="LKVP",color=Color(255,170,110)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(255,170,110)},
        }},

        {ID = "3:OtklAVUToggle",x=240.2,y=92,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-6.5,ang=180,
            var="OtklAVU",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=24,z=1.5,var="OtklAVUPl",ID="OtklAVUPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},

        {ID = "3:ConverterProtectionSet",x=332,y=133,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z=-3,
            var="ConverterProtection",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "3:KSNSet",x=377,y=133,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z=-3,
            var="KSN",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "3:RingSet",x=422,y=133,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z=-3,
            var="Ring",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},

        {ID = "!VPA1",x=265,y=137,radius=0,model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_b_a.mdl",ang = 180,z=-3,
            getfunc = function(ent) return ent:GetPackedBool("VPAOn") and 1 or (ent:GetPackedBool("VPAOff") and 0 or 0.5) end,
            var="VPA",speed=16,
        }},
        {ID = "1:VPAOnSet",x=265-10,y=137-20,w=20,h=20,tooltip="",model = {
            var="VPAOn",sndid = "!VPA1",
            sndvol = 0.5,snd = function(val) return val and "triple_0-down" or "triple_down-0" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            noTooltip=false,states={"Train.Buttons.0","Train.Buttons.On"}
        }},
        {ID = "1:VPAOffSet",x=265-10,y=137,w=20,h=20,tooltip="",model = {
            var="VPAOff",sndid = "!VPA1",
            sndvol = 0.5,snd = function(val) return val and "triple_0-up" or "triple_up-0" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            noTooltip=false,states={"Train.Buttons.0","Train.Buttons.Off"}
        }},

        {ID = "3:OVTToggle",x=240.2,y=181.2,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-8,ang=180,
            var="OVT",speed=16,vmin=1,vmax=0,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=90,x=1,y=-27,z=3,var="OVTPl",ID="OVTPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "3:L_1Toggle",x=316.3,y=181.2,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-8,
            var="L_1",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "3:L_2Toggle",x=354,y=181.2,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-8,
            var="L_2",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "3:L_3Toggle",x=392,y=181.2,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-8,
            var="L_3",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["Block5_6_kvr"] = {
    pos = Vector(455.0-6,12.3,2.5-10.5+5.35),--446 -- 14 -- -0,5
    ang = Angle(0,-90,44),
    width = 480,
    height = 225,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {   ID = "2:R_VPRToggle",x=65+42*0,y=34,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-6,
            var="R_VPR",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=90+70,x=-1-20,y=-24+11,z=2,var="R_VPRPl",ID="R_VPRPl",},
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {   ID = "2:R_GToggle",x=65+42*1,y=34,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-6,
            var="R_G",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {   ID = "2:R_UPOToggle",x=65+42*2,y=34,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-6,
            var="R_UPO",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},

        {   ID = "2:KVTSet",x=238,y=39,radius=20,tooltip="",model = {
                model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",z = -3,
                var="KVT",speed=16,vmin=1,vmax=0,
                sndvol = 0.07,snd = function(val) return val and "button1_on" or "button1_off" end,
                sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:VZ1Set",x=359,y=39,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="VZ1",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button2_off" end,
            sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "!OhSigLamp2",x=420,y=39,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-717/lamps/ad22_lamp.mdl",ignorepanel = true,color=Color(165,15,25),
            lamp = {model = "models/metrostroi_train/81-717/lamps/ad22_emissive.mdl",var="OhSigLamp",color=Color(255,25,40),
            lcolor=Color(255,25,40),lz = 12,lfov=152,lbright=1,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.4,size=.5,scale=0.06,z=5,color=Color(255,25,40)},
        }},

        --{ID = "2:AutodriveToggle",x=420,y=92,radius=20,tooltip=""},

        {ID = "2:VUD1Toggle",x=65,y=101,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-8,ang=0,
            var="VUD1",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            states={"Train.Buttons.Unlocked","Train.Buttons.Locked"},
        }},
        {ID = "2:KDLSet",x=65,y=173,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",
            var="KDL",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "!KDLLight2",x=65,y=130,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-717/lamps/ad22_lamp.mdl",ignorepanel = true,color=Color(185,195,210),
            lamp = {model = "models/metrostroi_train/81-717/lamps/ad22_emissive.mdl",var="DoorsLeftL",color=Color(255,255,255),
            lcolor=Color(255,255,255),lz = 12,lfov=156,lbright=1,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.3,size=.5,scale=0.06,z=5,color=Color(255,255,255)},
        }},
        {ID = "2:KDLKToggle",x=45,y=183,w=40,h=20,tooltip="",model = {
            var="KDLK",speed=8,min=0.32,max=0.68,disable="2:KDLSet",
            model = "models/metrostroi_train/81/krishka.mdl",ang = 0,z = -3,
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
        {ID = "2:KDLRSet",x=155,y=173,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",
            var="KDLR",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "!KDLRLight2",x=155,y=130,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-717/lamps/ad22_lamp.mdl",ignorepanel = true,color=Color(185,195,210),
            lamp = {model = "models/metrostroi_train/81-717/lamps/ad22_emissive.mdl",var="DoorsLeftL",color=Color(255,255,255),
            lcolor=Color(255,255,255),lz = 12,lfov=156,lbright=1,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.4,size=.5,scale=0.06,z=5,color=Color(255,255,255)},
        }},
        {ID = "2:KDLRKToggle",x=135,y=183,w=40,h=20,tooltip="",model = {
            model = "models/metrostroi_train/81/krishka.mdl",ang = 0,z = -3,
            var="KDLRK",speed=8,min=0.32,max=0.68,disable="2:KDLRSet",
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
        {ID = "2:DoorSelectToggle",x=107,y=184,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-8,
            var="DoorSelect",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            states={"Train.Buttons.Left","Train.Buttons.Right"}
        }},
        {ID = "2:KRZDSet",x=153,y=85,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="KRZD",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:VozvratRPSet",x=107,y=134,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="VozvratRP",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button1_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "!GreenRPLight2",x=107,y=95,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-717/lamps/ad22_lamp.mdl",ignorepanel = true,color=Color(30,160,100),
            lamp = {model = "models/metrostroi_train/81-717/lamps/ad22_emissive.mdl",var="GRP",color=Color(50,255,160),
            lcolor=Color(50,255,160),lz = 12,lfov=154,lbright=1,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.4,size=.5,scale=0.06,z=5,color=Color(50,255,160)},
        }},

        {ID = "!RZPLight2",x=309,y=81,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-717/lamps/ad22_lamp.mdl",ignorepanel = true,color=Color(165,15,25),
            lamp = {model = "models/metrostroi_train/81-717/lamps/ad22_emissive.mdl",var="RZP",color=Color(255,25,40),
            lcolor=Color(255,25,40),lz = 12,lfov=152,lbright=1,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.4,size=.5,scale=0.06,z=5,color=Color(255,25,40)},
        }},
        {ID = "!LKVPLight2",x=348,y=81,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-717/lamps/ad22_lamp.mdl",ignorepanel = true,color=Color(5,125,185),
            lamp = {model = "models/metrostroi_train/81-717/lamps/ad22_emissive.mdl",var="LKVP",color=Color(15,180,255),
            lcolor=Color(15,180,255),lz = 12,lfov=158,lbright=1,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.4,size=.5,scale=0.06,z=5,color=Color(15,180,255)},
        }},
        {ID = "2:OhrSigToggle",x=420,y=81,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=-3,
            var="OhrSig",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},

        {ID = "2:ConverterProtectionSet",x=316,y=133,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z=-3,
            var="ConverterProtection",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:KSNSet",x=369,y=133,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z=-3,
            var="KSN",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button1_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:RingSet",x=422,y=133,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z=-3,
            var="Ring",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},

        {ID = "2:ARSToggle",x=238,y=136,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",ang = 180,z=-6,
            var="ARS",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:ALSToggle",x=265,y=136,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",ang = 180,z=-6,
            var="ALS",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "!VPA2",x=252,y=136,radius=0,model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_b_a.mdl",ang = 180,z=-3,
            getfunc = function(ent) return ent:GetPackedBool("VPAOn") and 1 or (ent:GetPackedBool("VPAOff") and 0 or 0.5) end,
            var="VPA",speed=16,
            labels={{model="models/metrostroi_train/81-717/labels/label_717_plane_small.mdl",skin=1,ang=Angle(-90,90,0),z=0,x=0,y=-19,scale=2.5}}
        }},
        {ID = "2:VPAOnSet",x=252-10,y=136-20,w=20,h=20,tooltip="",model = {
            var="VPAOn",sndid = "!VPA2",
            sndvol = 0.5,snd = function(val) return val and "triple_0-down" or "triple_down-0" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            noTooltip=false,states={"Train.Buttons.0","Train.Buttons.On"}
        }},
        {ID = "2:VPAOffSet",x=252-10,y=136,w=20,h=20,tooltip="",model = {
            var="VPAOff",sndid = "!VPA2",
            sndvol = 0.5,snd = function(val) return val and "triple_0-up" or "triple_up-0" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            noTooltip=false,states={"Train.Buttons.0","Train.Buttons.Off"}
        }},

        {ID = "2:OVTToggle",x=240,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-8,ang=180,
            var="OVT",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=24,z=2,var="OVTPl",ID="OVTPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:OtklAVUToggle",x=279,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-8,ang=180,
            var="OtklAVU",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=24,z=2,var="OtklAVUPl",ID="OtklAVUPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "!AVULight2",x=316,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-717/lamps/ad22_lamp.mdl",ignorepanel = true,color=Color(165,15,25),
            lamp = {model = "models/metrostroi_train/81-717/lamps/ad22_emissive.mdl",var="AVU",color=Color(255,25,40),
            lcolor=Color(255,25,40),lz = 12,lfov=152,lbright=1,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.4,size=.5,scale=0.06,z=5,color=Color(255,25,40)},
        }},
        {ID = "2:L_1Toggle",x=354,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-8,ang=180,
            var="L_1",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:L_2Toggle",x=392,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-8,ang=180,
            var="L_2",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:L_3Toggle",x=430,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-8,ang=180,
            var="L_3",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}

-- Front panel
ENT.ButtonMap["Block7_old"] = {
    pos = Vector(446.22,-17.6,-5.48+5.35),
    ang = Angle(0,-90,58),
    width = 195,
    height = 240,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "1:L_4Toggle",x=43,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-4,
            var="L_4",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:VUSToggle",x=76,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-4,
            var="VUS",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:VADToggle",x=109,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-4,
            var="VAD",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=28,z=4,var="VADPl",ID="VADPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:VAHToggle",x=142,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-4,
            var="VAH",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=28,z=4,var="VAHPl",ID="VAHPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},

        {ID = "1:KRPSet",x=43,y=30,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",
            var="KRP",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button1_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:RezMKSet",x=43,y=83,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",
            var="RezMK",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},

        {ID = "1:KDPSet",x=101,y=127,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/button_717_3.mdl",
            lamp = {model = "models/metrostroi_train/81-717/buttons/lamp_button_1.mdl",anim=true,var="DoorsRightL",speed=9,z=2.2,color=Color(255,130,80),
            lcolor=Color(255,110,40),lz = 8,lfov=145,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.2,size=.485,scale=0.1,z=5,color=Color(255,130,80)},
            var="KDP",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:KDPKToggle",x=81,y=137,w=40,h=20,tooltip="",model = {
            model = "models/metrostroi_train/81/krishka.mdl",ang = 0,z = -1,
            var="KDPK",speed=8,min=0.33,max=0.68,disable="1:KDPSet",
            getfunc = function(ent) return ent:GetPackedBool("KDPK") and 1 or math.max(0,(ent.Anims["1:VADToggle"].val-0.5)*2 or 0)*0.16 end,
            sndvol = 1,snd = function(val,realval) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            noTooltip = true,
        }},

        {ID = "!1:PNT",x=135,y=130,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",skin = 4,z = -1,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=81,x=-0.3,y=-0.3,z=20.6,var="PN",color=Color(255,130,90)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(255,130,90)},
        }},
    }
}
ENT.ButtonMap["Block7_kvr"] = {
    pos = Vector(446.22,-17.6,-5.48+5.35),
    ang = Angle(0,-90,58),
    width = 195,
    height = 240,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "2:L_4Toggle",x=43,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-4,
            var="L_4",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:VUSToggle",x=76,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-4,
            var="VUS",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:VADToggle",x=109,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-4,
            var="VAD",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=28,z=4,var="VADPl",ID="VADPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:VAHToggle",x=142,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-4,
            var="VAH",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=28,z=4,var="VAHPl",ID="VAHPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},

        {ID = "2:KRPSet",x=43,y=30,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",
            var="KRP",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button1_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:RezMKSet",x=43,y=83,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",
            var="RezMK",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},

        {ID = "!KDPLight2",x=65,y=127,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-717/lamps/ad22_lamp.mdl",ignorepanel = true,color=Color(185,195,210),z=5,
            lamp = {model = "models/metrostroi_train/81-717/lamps/ad22_emissive.mdl",var="DoorsRightL",color=Color(255,255,255),
            lcolor=Color(255,255,255),lz = 12,lfov=155,lbright=1,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.4,size=.5,scale=0.06,z=5,color=Color(255,255,255)},
        }},
        {ID = "2:KDPSet",x=101,y=127,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",
            var="KDP",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:KDPKToggle",x=81,y=137,w=40,h=20,tooltip="",model = {
            model = "models/metrostroi_train/81/krishka.mdl",ang = 0,z = -1,
            var="KDPK",speed=8,min=0.33,max=0.685,disable="2:KDPSet",
            getfunc = function(ent) return ent:GetPackedBool("KDPK") and 1 or math.max(0,(ent.Anims["2:VADToggle"].val-0.5)*2 or 0)*0.24 end,
            sndvol = 1,snd = function(val,realval) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            noTooltip = true,
        }},

        {ID = "!2:PNT",x=137,y=127,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-717/lamps/ad22_lamp.mdl",ignorepanel = true,color=Color(165,125,45),z=5,
            lamp = {model = "models/metrostroi_train/81-717/lamps/ad22_emissive.mdl",var="PN",color=Color(255,195,70),
            lcolor=Color(255,195,70),lz = 12,lfov=160,lbright=1,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.4,size=.5,scale=0.06,z=5,color=Color(255,195,70)},
        }},
    }
}

-- BPSN panel
ENT.ButtonMap["Block1"] = {
    pos = Vector(450.4,28.2,1.3+5.35),
    ang = Angle(0,-90,58),
    width = 290,
    height = 120,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "!BatteryVoltage",x=220,y=60,tooltip="",radius=60,tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BatteryVoltage"),ent:GetPackedRatio("BatteryVoltage")*150) end},
        {ID = "VMKToggle",x=38,y=30,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-5,
            var="VMK",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "BPSNonToggle",x=79,y=30,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-5,
            var="BPSNon",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},

        {ID = "Radio13Set",x=79,y=80,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",
            var="Radio13",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button1_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "ARS13Set",x=128,y=80,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",
            var="ARS13",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button2_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
    }
}


ENT.ButtonMap["Block3"] = {
    pos = Vector(450.4,-10,1.3+5.35),
    ang = Angle(0,-90,58),
    width = 290,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "!BLTLPressure", x=62, y=55, radius=55, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BLTLPressure"),ent:GetPackedRatio("TLPressure")*16,ent:GetPackedRatio("BLPressure")*16) end},
        {ID = "!BCPressure", x=182, y=55, radius=55, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BCPressure"),ent:GetPackedRatio("BCPressure")*6) end},
        {ID = "!NMPressureLow2", x=134.5, y=90, radius=8, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",z = -3.2,color = Color(255,50,45), var="NMLow", hidden = "!NMPressureLow2"},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(255,50,45),z=-0.6,}
        }},
        {ID = "!UAVATriggered2", x=255.5, y=92.1, radius=8, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",z = -3.2,color = Color(255,50,45), var="UAVATriggered", hidden = "!UAVATriggered2"},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(255,50,45),z=-0.6,}
        }},
    }
}
-- Front panel
ENT.ButtonMap["PUAVO"] = {
    pos = Vector(446.4,27.9,0),
    ang = Angle(0,-90,58),
    width = 260,
    height = 240,
    scale = 0.0625,
    hideseat=0.2,


    buttons = {
        {ID = "!OK16",x=32,y=66+43*0,radius=10,tooltip="",model = {
            name="PUOKI",model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",z = -8,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=63,x=-0.3,y=-0.3,z=20.6,var="PUK16",color=Color(255,170,110)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(255,170,110)},
        }},
        {ID = "!OLRS",x=32,y=66+43*0.95,radius=10,tooltip="",model = {
            name="PUOLRS",model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",z = -8,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=63,x=-0.3,y=-0.3,z=20.6,var="PULRS",color=Color(100,255,100)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(100,255,100)},
        }},
        {ID = "!OKI1",x=32,y=66+43*2,radius=10,tooltip="",model = {
            name="PUOKI1",model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",z = -8,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=63,x=-0.3,y=-0.3,z=20.6,var="PUKI1",color=Color(255,60,40)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(255,60,40)},
        }},
        {ID = "!OKI2",x=32,y=66+43*3,radius=10,tooltip="",model = {
            name="PUOKI2",model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",z = -8,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=63,x=-0.3,y=-0.3,z=20.6,var="PUKI2",color=Color(255,60,40)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(255,60,40)},
        }},
        {ID = "!OOS",x=79,y=66+43*0.95,radius=10,tooltip="",model = {
            name="PUOOS",model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",z = -8,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=63,x=-0.3,y=-0.3,z=20.6,var="PUOS",color=Color(255,130,90)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(255,130,90)},
        }},
        {ID = "1:KHSet",x=79,y=66+43*2.2,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -2,
            var="KH",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button2_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:KSZDSet",x=79,y=66+43*3.2,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",z = -2,
            var="KSZD",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button1_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "!OAVT",x=130,y=66+43*0.95,radius=10,tooltip="",model = {
            name="PUOAVT",model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",z = -8,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=63,x=-0.3,y=-0.3,z=20.6,var="PUAVT",color=Color(100,255,100)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(100,255,100)},
        }},
        {ID = "1:VAVToggle",x=130,y=66+43*2.2,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=0,
            var="VAV",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
        {ID = "1:VZPToggle",x=130,y=66+43*3.2,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=0,
            var="VZP",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
    }
}
ENT.ButtonMap["PUAVOScreen"] = {
    pos = ENT.ButtonMap.PUAVO.pos-Vector(2.2,4.8,0.5),
    ang = Angle(0,-90,57.0),
    width = 512,
    height = 128,
    scale = 0.011,
    hideseat=0.2,
    hide=true,
}
-- Front panel
ENT.ButtonMap["PUAVN"] = {
    pos = Vector(446.4,27.7,0.15),
    ang = Angle(0,-90,58),
    width = 260,
    height = 240,
    scale = 0.056,
    hideseat=0.2,

    buttons = {
        {ID = "!K16",x=47.5,y=21.5,w=10,h=10,tooltip="",model = {
            name="PUKI",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-6,var="PUK16"},
            sprite = {bright=0.1,size=0.25,scale=0.02,color=Color(255,240,40),z=-3,aa=false}
        }},
        {ID = "!OS",x=47.5,y=21.5+14.1*1,w=10,h=10,tooltip="",model = {
            name="PUOS",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-6,var="PUOS"},
            sprite = {bright=0.1,size=0.25,scale=0.02,color=Color(255,240,40),z=-3,aa=false}
        }},
        {ID = "!AVT",x=47.5,y=21.5+14.1*2,w=10,h=10,tooltip="",model = {
            name="PUAVT",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-6,color=Color(175,250,20),var="PUAVT"},
            sprite = {bright=0.1,size=0.25,scale=0.02,color=Color(175,250,20),z=-3,aa=false}
        }},
        {ID = "!LRS",x=47.5,y=21.5+14.1*3,w=10,h=10,tooltip="",model = {
            name="PULRS",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-6,color=Color(175,250,20),var="PULRS"},
            sprite = {bright=0.1,size=0.25,scale=0.02,color=Color(175,250,20),z=-3,aa=false}
        }},
        {ID = "!KI1",x=47.5,y=21.5+14.1*4,w=10,h=10,tooltip="",model = {
            name="PUKI1",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ra.mdl",z=-6,var="PUKI1"},
            sprite = {bright=0.1,size=0.25,scale=0.02,color=Color(255,20,40),z=-3,aa=false}
        }},
        {ID = "!KI2",x=47.5,y=21.5+14.1*5,w=10,h=10,tooltip="",model = {
            name="PUKI2",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ra.mdl",z=-6,var="PUKI2"},
            sprite = {bright=0.1,size=0.25,scale=0.02,color=Color(255,20,40),z=-3,aa=false}
        }},
        {ID = "!ARSOch",x=219,y=21.5,w=10,h=10,tooltip="",model = {
            name="PUOCh",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ra.mdl",z=-6,var="PU04"},
            sprite = {bright=0.1,size=0.25,scale=0.02,color=Color(255,20,40),z=-3,aa=false}
        }},
        {ID = "!ARS0",x=219,y=21.5+13.5*1,w=10,h=10,tooltip="",model = {
            name="PU0",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ra.mdl",z=-6,var="PU0"},
            sprite = {bright=0.1,size=0.25,scale=0.02,color=Color(255,20,40),z=-3,aa=false}
        }},
        {ID = "!ARS40",x=219,y=21.5+13.5*2,w=10,h=10,tooltip="",model = {
            name="PU40",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-6,var="PU40"},
            sprite = {bright=0.1,size=0.25,scale=0.02,color=Color(255,240,40),z=-3,aa=false}
        }},
        {ID = "!ARS60",x=219,y=21.5+13.5*3,w=10,h=10,tooltip="",model = {
            name="PU60",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-6,color=Color(175,250,20),var="PU60"},
            sprite = {bright=0.1,size=0.25,scale=0.02,color=Color(175,250,20),z=-3,aa=false}
        }},
        {ID = "!ARS70",x=219,y=21.5+13.5*4,w=10,h=10,tooltip="",model = {
            name="PU70",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-6,color=Color(175,250,20),var="PU70"},
            sprite = {bright=0.1,size=0.25,scale=0.02,color=Color(175,250,20),z=-3,aa=false}
        }},
        {ID = "!ARS80",x=219,y=21.5+13.5*5,w=10,h=10,tooltip="",model = {
            name="PU80",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-6,color=Color(175,250,20),var="PU80"},
            sprite = {bright=0.1,size=0.25,scale=0.02,color=Color(175,250,20),z=-3,aa=false}
        }},
        {ID = "KHSet",x=109,y=132,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -2,
            var="KH",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button1_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "KSZDSet",x=167,y=132,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -2,
            var="KSZD",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button2_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},

        {ID = "VAVToggle",x=90,y=183,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_b_a.mdl",ang = 180,z=1,
            var="VAV",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            labels={{model="models/metrostroi_train/81-717/labels/label_717_plane.mdl",skin=18,ang=Angle(-90,90,0),z=0,x=47.5,y=20,scale=1.5}}
        }},
        {ID = "VZPToggle",x=185,y=183,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_b_a.mdl",ang = 180,z=1,
            var="VZP",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
    }
}
ENT.ButtonMap["PUAVNScreen"] = {
    pos = ENT.ButtonMap.PUAVN.pos-Vector(1.9,4.94,0.65),
    ang = Angle(0,-90,58.0),
    width = 512,
    height = 128,
    scale = 0.0115,
    hideseat=0.2,
    hide=true,
}
ENT.ButtonMap["PUAVNLights"] = {
    pos = ENT.ButtonMap.PUAVN.pos-Vector(3.27,4.9,2.3),
    ang = Angle(0,-90,58.0),
    width = 13,
    height = 24,
    scale = 0.056,
    hideseat=0.2,
    buttons = {
        {ID = "!PU",x=6 ,y=4+12.3,w=3,h=3,model = {
            name="BURPower",lamp = {speed=24,model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",color=Color(175,250,20),z=-5.5,var="BURPower"},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(175,250,20),z=-1,}
        }},
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
ENT.ButtonMap["Block2"] = {
    pos = Vector(450.4+0.35,10.0,1.3+5.35),
    ang = Angle(0,-90,58),
    width = 300,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "!Speedometer1",x=137,y=29,w=17,h=25,tooltip="",model = {
            name="SSpeed2",model = "models/metrostroi_train/81-717/segments/segment_spb.mdl",color=Color(175,250,20),skin=0,z=0.1,ang=Angle(0,0,-90),
            tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.Speed"),ent:GetNW2Int("ALSSpeed")) end,
            sprite = {bright=0.1,size=.5,scale=0.055,vscale=0.065,z=1,color=Color(225,250,20),aa=true,getfunc= function(ent)
                if not ent:GetPackedBool("LUDS") then return 0 end
                return strength[math.floor(ent:GetNW2Int("ALSSpeed")*0.1)%10]
            end},
        }},
        {ID = "!Speedometer2",x=158,y=29,w=17,h=25,tooltip="",model = {
            name="SSpeed1",model = "models/metrostroi_train/81-717/segments/segment_spb.mdl",color=Color(175,250,20),skin=0,z=0.1,ang=Angle(0,0,-90),
            tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.Speed"),ent:GetNW2Int("ALSSpeed")) end,
            sprite = {bright=0.1,size=.5,scale=0.055,vscale=0.065,z=1,color=Color(225,250,20),aa=true,getfunc= function(ent)
                if not ent:GetPackedBool("LUDS") then return 0 end
                return strength[math.floor(ent:GetNW2Int("ALSSpeed"))%10]
            end},
        }},

        {ID = "!ARSOch",x=100,y=33,w=10,h=10,tooltip="",model = {
            name="SAOCh",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ra.mdl",z=-0.2,var="AR04"},
            sprite = {bright=0.1,size=0.25,scale=0.03,color=Color(255,20,40),z=-1,aa=true}
        }},
        {ID = "!ARS0",x=89,y=33+10.9*0,w=10,h=10,tooltip="",model = {
            name="SA0",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ra.mdl",z=-0.2,var="AR0"},
            sprite = {bright=0.1,size=0.25,scale=0.03,color=Color(255,20,40),z=-1,aa=true}
        }},
        {ID = "!ARS40",x=89,y=33+10.9*1,w=10,h=10,tooltip="",model = {
            name="SA40",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-0.2,var="AR40"},
            sprite = {bright=0.1,size=0.25,scale=0.03,color=Color(255,240,40),z=-1,aa=true}
        }},
        {ID = "!ARS60",x=89,y=33+10.9*2,w=10,h=10,tooltip="",model = {
            name="SA60",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-0.2,color=Color(175,250,20),var="AR60"},
            sprite = {bright=0.1,size=0.25,scale=0.03,color=Color(175,250,20),z=-1,aa=true}
        }},
        {ID = "!ARS70",x=89,y=33+10.9*3,w=10,h=10,tooltip="",model = {
            name="SA70",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-0.2,color=Color(175,250,20),var="AR70"},
            sprite = {bright=0.1,size=0.25,scale=0.03,color=Color(175,250,20),z=-1,aa=true}
        }},
        {ID = "!ARS80",x=89,y=33+10.9*4,w=10,h=10,tooltip="",model = {
            name="SA80",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-0.2,color=Color(175,250,20),var="AR80"},
            sprite = {bright=0.1,size=0.25,scale=0.03,color=Color(175,250,20),z=-1,aa=true}
        }},

        {ID = "!LampLSD1",x=191.0,y=34.2,w=10,h=4,tooltip="",model = {
            name="SSD1",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-0.2,color=Color(175,250,20),var="SD"},
            sprite = {bright=0.05,size=0.25,scale=0.03,color=Color(175,250,20),z=-1,aa=true}
        }},
        {ID = "!LampLSD2",x=201.2,y=34.2,w=10,h=4,tooltip="",model = {
            name="SSD2",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-0.2,ang=90,color=Color(175,250,20),var="SD"},
            sprite = {bright=0.05,size=0.25,scale=0.03,color=Color(175,250,20),z=-1,aa=true}
        }},

        {ID = "!LampLVD",x=191.3,y=43.8+8.8*0,w=10,h=4,tooltip="",model = {
            name="SVD",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",var="A04",z=-0.2,color=Color(175,250,20),var="VD"},
            sprite = {bright=0.05,size=0.25,scale=0.04,vscale=0.02, color=Color(175,250,20),z=-1,aa=true}
        }},
        {ID = "!LampLHRK",x=191.3,y=43.8+8.8*1,w=10,h=4,tooltip="",model = {
            name="SRK",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-0.2,var="HRK"},
            sprite = {bright=0.05,size=0.25,scale=0.04,vscale=0.02, color=Color(255,240,40),z=-1,aa=true}
        }},
        {ID = "!LampLST",x=191.3,y=43.8+8.8*2,w=10,h=4,tooltip="",model = {
            name="SST",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-0.2,var="ST"},
            sprite = {bright=0.05,size=0.25,scale=0.04,vscale=0.02, color=Color(255,240,40),z=-1,aa=true}
        }},
        {ID = "!LampLRD",x=191.3,y=43.8+8.8*3,w=10,h=4,tooltip="",model = {
            name="SRD",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-0.2,color=Color(175,250,20),var="LRD"},
            sprite = {bright=0.05,size=0.25,scale=0.04,vscale=0.02, color=Color(175,250,20),z=-1,aa=true}
        }},


        {ID = "!LampRP",x=209.8,y=43.9+8.8*0,w=10,h=4,tooltip="",model = {
            name="SRP",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_rb.mdl",z=-0.2,var="RP",getfunc = function(ent) return math.Clamp((ent:GetPackedRatio("RPR")-0.42)*7,0,1) end},
            sprite = {bright=0.05,size=0.25,scale=0.04,vscale=0.02, color=Color(255,20,40),z=-1,aa=true}
        }},
        {ID = "!LampLSN",x=219.8,y=43.9+8.8*0,w=10,h=4,tooltip="",model = {
            name="SSN",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_rb.mdl",z=-0.2,ang=-90,var="SN",getfunc = function(ent) return ent:GetPackedRatio("RPR")^0.9*1.1 end},
            sprite = {bright=0.05,size=0.25,scale=0.04,vscale=0.02, color=Color(255,20,40),z=-1,aa=true}
        }},

        --{x=2031 + 2*0,y=223 + 192*0,w=10,h=10,tooltip="",radius=10},
        {ID = "!LampLKVD",x=219,y=43.8+8.8*1,w=10,h=4,tooltip="",model = {
            name="SKVD",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-0.2,var="KVD"},
            sprite = {bright=0.05,size=0.25,scale=0.04,vscale=0.02, color=Color(255,180,40),z=-1,aa=true}
        }},
        {ID = "!LampLKT",x=219,y=43.8+8.8*2,w=10,h=4,tooltip="",model = {
            name="SKT",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-0.2,var="KT"},
            sprite = {bright=0.05,size=0.25,scale=0.04,vscale=0.02, color=Color(255,180,40),z=-1,aa=true}
        }},
        {ID = "!LampDV",x=219,y=43.8+8.8*3,w=10,h=4,tooltip="",model = {
            name="SDV",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-0.2,color=Color(175,250,20),var="DV"},
            sprite = {bright=0.05,size=0.25,scale=0.03,color=Color(255,20,40),z=-1,aa=true}
        }},

        {ID = "!SpeedFact1",x=133.1,y=73.6,w=23.7,h=8,tooltip="",model = {
            name="SpeedFact1",model = "models/metrostroi_train/81-717/lamps/indicators.mdl",z=0.15,color=Color(175,250,20),skin=10,ang=90,
            tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.Speed"),ent:GetPackedRatio("Speed")*100) end
        }},
        {ID = "!SpeedFact2",x=133.1+23.7,y=73.6,w=23.7,h=8,tooltip="",model = {
            name="SpeedFact2",model = "models/metrostroi_train/81-717/lamps/indicators.mdl",z=0.15,color=Color(175,250,20),skin=10,ang=90,
            tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.Speed"),ent:GetPackedRatio("Speed")*100) end
        }},

        {ID = "!ARSL20",x=140,y=83,w=5,h=10,tooltip="",model = {
            name="SAL20",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/triangle_red.mdl",z=-0.3,var="AR20"},
            sprite = {bright=0.05,size=0.25,scale=0.02,color=Color(255,20,40),z=-1,aa=true}
        }},
        {ID = "!ARSL40",x=140+4.3*2,y=83,w=5,h=10,tooltip="",model = {
            name="SAL40",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/triangle_yellow.mdl",z=-0.3,var="AR40"},
            sprite = {bright=0.05,size=0.25,scale=0.02,color=Color(255,240,40),z=-1,aa=true}
        }},
        {ID = "!ARSL60",x=140+4.3*(3+1.1),y=83,w=5,h=10,tooltip="",model = {
            name="SAL60",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/triangle_yellow.mdl",color=Color(175,250,20),z=-0.3,var="AR60"},
            sprite = {bright=0.05,size=0.25,scale=0.02,color=Color(175,250,20),z=-1,aa=true}
        }},
        {ID = "!ARSL70",x=140+4.3*(4+1.2),y=83,w=5,h=10,tooltip="",model = {
            name="SAL70",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/triangle_yellow.mdl",color=Color(175,250,20),z=-0.3,var="AR70"},
            sprite = {bright=0.05,size=0.25,scale=0.02,color=Color(175,250,20),z=-1,aa=true}
        }},
        {ID = "!ARSL80",x=140+4.3*(5+1.3),y=83,w=5,h=10,tooltip="",model = {
            name="SAL80",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/triangle_yellow.mdl",color=Color(175,250,20),z=-0.3,var="AR80"},
            sprite = {bright=0.05,size=0.25,scale=0.02,color=Color(175,250,20),z=-1,aa=true}
        }},
        --[[
        {ID = "!LampLN",x=217-0.5*0 ,y=34.6 + 20.7*1,w=10,h=10,tooltip="",model = {
            name="SHLN",lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl",color=Color(175,250,20),z=0,var="LN"},
        }},
        {ID = "!LampLRS",x=271.5-1*1,y=34.6 + 20.5*1,w=10,h=10,tooltip="",model = {
            name="SHRS",lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl",color=Color(175,250,20),z=0,var="RS"},
        }},]]
    }
}
ENT.ClientProps["pam"] = {
    model = "models/metrostroi_train/81-717/81-717_pampanel.mdl",
    pos = Vector(-0.2,0,0),--Vector(454.172425-6,0.080645,0.967742-5.4),
    ang = Angle(0,0,0),
    hideseat=0.8,
}
ENT.ButtonMap["PAM"] = {
    --pos = Vector(455.22,-34.35,24.15-13),
    pos = Vector(445.3-4.7-0.2,27.1,-9.3),
    ang = Angle(0,-90,58),
    --pos = ENT.ClientProps["pam"].pos+Vector(0.72,4.65,-9.85),
    --ang = ENT.ClientProps["pam"].ang,
    width = 265,
    height = 20,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "2:KSZDSet",x=163,y=10,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -2,
            var="KSZD",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},

        {ID = "2:VZPToggle",x=190,y=10,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_b_a.mdl",ang = 180,z=0,
            var="VZP",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
    }
}
ENT.ButtonMap["PAM1"] = {
    --pos = Vector(455.22-6,-34.35-8.5,24.15),
    pos = Vector(445.3-0.2,27.1,-2),
    ang = Angle(0,-90,58),
    width = 40,
    height = 135,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {

        {ID = "PAMPSet",x=6.9+13.45*2,y=23,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_p.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_p.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAMP",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},

        {ID = "PAMFSet",x=6.9+13.45*0,y=49+13*0,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_f.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_f.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAMF",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
        {ID = "PAMUpSet",x=6.9+13.45*1,y=49+13*0,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_up.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_up.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAMUp",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
        {ID = "PAMMSet",x=6.9+13.45*2,y=49+13*0,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_m.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_m.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAMM",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
        --[=[ {ID = "PAMLeftSet",x=6.9+13.45*0,y=49+13*1,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_left.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_left.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAMLeft",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},--]=]
        {ID = "PAMLeftSet",x=6.9+13.45*0,y=49+13*1,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_left.mdl",ang = 0,z=2.65,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_left.mdl",z=-0.2-2.65,anim=true,var="PAPower" },
            var="PAMLeft",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
        {ID = "PAMDownSet",x=6.9+13.45*1,y=49+13*1,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_down.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_down.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAMDown",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
        {ID = "PAMRightSet",x=6.9+13.45*2,y=49+13*1,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_right.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_right.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAMRight",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},


        {ID = "PAM1Set",x=6.9+13.45*0,y=86+12.9*0,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_1.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_1.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM1",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
        {ID = "PAM2Set",x=6.9+13.45*1,y=86+12.9*0,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_2.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_2.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM2",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
        {ID = "PAM3Set",x=6.9+13.45*2,y=86+12.9*0,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_3.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_3.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM3",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
        {ID = "PAM4Set",x=6.9+13.45*0,y=86+12.9*1,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_4.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_4.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM4",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
        {ID = "PAM5Set",x=6.9+13.45*1,y=86+12.9*1,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_5.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_5.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM5",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
        {ID = "PAM6Set",x=6.9+13.45*2,y=86+12.9*1,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_6.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_6.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM6",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
        {ID = "PAM7Set",x=6.9+13.45*0,y=86+12.9*2,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_7.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_7.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM7",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
        {ID = "PAM8Set",x=6.9+13.45*1,y=86+12.9*2,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_8.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_8.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM8",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
        {ID = "PAM9Set",x=6.9+13.45*2,y=86+12.9*2,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_9.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_9.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM9",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
        {ID = "PAMEscSet",x=6.9+13.45*0,y=86+12.9*3,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_esc.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_esc.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAMEsc",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
        {ID = "PAM0Set",x=6.9+13.45*1,y=86+12.9*3,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_0.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_0.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM0",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
        {ID = "PAMEnterSet",x=6.9+13.45*2,y=86+12.9*3,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_enter.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_enter.mdl",z=2.4,anim=true,var="PAPower" },
            var="PAMEnter",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
        }},
    }
}
ENT.ButtonMap["PAMScreen"] = {
    --pos = Vector(455.15,-34.35,24.15),
    pos = Vector(445.03-0.2,22.95,-1.84),
    ang = Angle(0,-90,58),
    width = 640,
    height = 480,
    scale = 0.025/1.9,
    sensor = true,
    system = "PAM",

    hideseat=0.2,
    hide=true,
}
local plombed = {A41Toggle=true,AISToggle=true}
ENT.ButtonMap["AV_C"] = {
    pos = Vector(396,-17.5,44.6),
    ang = Angle(0,90,90),
    width = 680,
    height = 590,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "A53Toggle",x=30+36.7*0,y=60+157*0,radius=25,tooltip=""},
        {ID = "A56Toggle",x=30+36.7*1,y=60+157*0,radius=25,tooltip=""},
        {ID = "A54Toggle",x=30+36.7*2,y=60+157*0,radius=25,tooltip=""},
        {ID = "A17Toggle",x=30+36.7*3,y=60+157*0,radius=25,tooltip=""},
        {ID = "A44Toggle",x=30+36.7*4,y=60+157*0,radius=25,tooltip=""},
        {ID = "A39Toggle",x=30+36.7*5,y=60+157*0,radius=25,tooltip=""},
        {ID = "A70Toggle",x=30+36.7*6,y=60+157*0,radius=25,tooltip=""},
        {ID = "A14Toggle",x=30+36.7*7,y=60+157*0,radius=25,tooltip=""},
        {ID = "A74Toggle",x=30+36.7*8,y=60+157*0,radius=25,tooltip=""},
        {ID = "A26Toggle",x=30+36.7*9,y=60+157*0,radius=25,tooltip=""},
        {ID = "AR63Toggle",x=30+36.7*10,y=60+157*0,radius=25,tooltip=""},
        {ID = "AS1Toggle",x=30+36.7*11,y=60+157*0,radius=25,tooltip=""},
        {ID = "A13Toggle",x=30+36.7*12,y=60+157*0,radius=25,tooltip=""},
        {ID = "A21Toggle",x=30+36.7*13,y=60+157*0,radius=25,tooltip=""},
        {ID = "A31Toggle",x=30+36.7*14,y=60+157*0,radius=25,tooltip=""},
        {ID = "A32Toggle",x=30+36.7*15,y=60+157*0,radius=25,tooltip=""},
        {ID = "A16Toggle",x=30+36.7*16,y=60+157*0,radius=25,tooltip=""},
        {ID = "A12Toggle",x=30+36.7*17,y=60+157*0,radius=25,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "A24Toggle",x=30+36.7*0,y=60+157*1,radius=25,tooltip=""},
        {ID = "A49Toggle",x=30+36.7*1,y=60+157*1,radius=25,tooltip=""},
        {ID = "A27Toggle",x=30+36.7*2,y=60+157*1,radius=25,tooltip=""},
        {ID = "A72Toggle",x=30+36.7*3,y=60+157*1,radius=25,tooltip=""},
        {ID = "A50Toggle",x=30+36.7*4,y=60+157*1,radius=25,tooltip=""},
        {ID = "A15Toggle",x=30+36.7*5,y=60+157*1,radius=25,tooltip="",lab=8},
        {ID = "AISToggle",x=30+36.7*6,y=60+157*1,radius=25,tooltip="",lab=0},
        {ID = "AV3Toggle",x=30+36.7*7,y=60+157*1,radius=25,tooltip="",lab=1},
        {ID = "AV1Toggle",x=30+36.7*8,y=60+157*1,radius=25,tooltip="",lab=2},
        {ID = "A58Toggle",x=30+36.7*9,y=60+157*1,radius=25,tooltip="",lab=3},
        {ID = "A59Toggle",x=30+36.7*10,y=60+157*1,radius=25,tooltip="",lab=4},
        {ID = "A61Toggle",x=30+36.7*11,y=60+157*1,radius=25,tooltip="",lab=5},
        {ID = "P:A58Toggle",x=30+36.7*9,y=60+157*1,radius=25,tooltip=""},
        {ID = "P:A59Toggle",x=30+36.7*10,y=60+157*1,radius=25,tooltip="",lab2=true},
        {ID = "P:A61Toggle",x=30+36.7*11,y=60+157*1,radius=25,tooltip=""},
        {ID = "A29Toggle",x=30+36.7*12,y=60+157*1,radius=25,tooltip=""},
        {ID = "A46Toggle",x=30+36.7*13,y=60+157*1,radius=25,tooltip=""},
        {ID = "A47Toggle",x=30+36.7*14,y=60+157*1,radius=25,tooltip="",lab=17},
        {ID = "A71Toggle",x=30+36.7*15,y=60+157*1,radius=25,tooltip=""},
        {ID = "A7Toggle",x=30+36.7*16,y=60+157*1,radius=25,tooltip=""},
        {ID = "A9Toggle",x=30+36.7*17,y=60+157*1,radius=25,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "A84Toggle",x=30+36.7*0,y=60+157*2,radius=25,tooltip=""},
        {ID = "A8Toggle",x=30+36.7*1,y=60+157*2,radius=25,tooltip=""},
        {ID = "A52Toggle",x=30+36.7*2,y=60+157*2,radius=25,tooltip=""},
        {ID = "A19Toggle",x=30+36.7*3,y=60+157*2,radius=25,tooltip=""},
        {ID = "A48Toggle",x=30+36.7*4,y=60+157*2,radius=25,tooltip=""},
        {ID = "A10Toggle",x=30+36.7*5,y=60+157*2,radius=25,tooltip=""},
        {ID = "A22Toggle",x=30+36.7*6,y=60+157*2,radius=25,tooltip=""},
        {ID = "A30Toggle",x=30+36.7*7,y=60+157*2,radius=25,tooltip=""},
        {ID = "A1Toggle",x=30+36.7*8,y=60+157*2,radius=25,tooltip=""},
        {ID = "A2Toggle",x=30+36.7*9,y=60+157*2,radius=25,tooltip=""},
        {ID = "A3Toggle",x=30+36.7*10,y=60+157*2,radius=25,tooltip=""},
        {ID = "A4Toggle",x=30+36.7*11,y=60+157*2,radius=25,tooltip=""},
        {ID = "A5Toggle",x=30+36.7*12,y=60+157*2,radius=25,tooltip=""},
        {ID = "A6Toggle",x=30+36.7*13,y=60+157*2,radius=25,tooltip=""},
        {ID = "A18Toggle",x=30+36.7*14,y=60+157*2,radius=25,tooltip=""},
        {ID = "A73Toggle",x=30+36.7*15,y=60+157*2,radius=25,tooltip=""},
        {ID = "A20Toggle",x=30+36.7*16,y=60+157*2,radius=25,tooltip=""},
        {ID = "A25Toggle",x=30+36.7*17,y=60+157*2,radius=25,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "A11Toggle",x=30+36.7*0,y=60+157*3,radius=25,tooltip=""},
        {ID = "A37Toggle",x=30+36.7*1,y=60+157*3,radius=25,tooltip=""},
        {ID = "A45Toggle",x=30+36.7*2,y=60+157*3,radius=25,tooltip=""},
        {ID = "A38Toggle",x=30+36.7*3,y=60+157*3,radius=25,tooltip=""},
        {ID = "A51Toggle",x=30+36.7*4,y=60+157*3,radius=25,tooltip=""},
        {ID = "A65Toggle",x=30+36.7*5,y=60+157*3,radius=25,tooltip=""},
        {ID = "A06Toggle",x=30+36.7*6,y=60+157*3,radius=25,tooltip=""},
        {ID = "A42Toggle",x=30+36.7*7,y=60+157*3,radius=25,tooltip=""},
        {ID = "A43Toggle",x=30+36.7*8,y=60+157*3,radius=25,tooltip="",lab=6},
        {ID = "A41Toggle",x=30+36.7*9,y=60+157*3,radius=25,tooltip=""},
        {ID = "A40Toggle",x=30+36.7*10,y=60+157*3,radius=25,tooltip=""},
        {ID = "A75Toggle",x=30+36.7*11,y=60+157*3,radius=25,tooltip=""},
        {ID = "A76Toggle",x=30+36.7*12,y=60+157*3,radius=25,tooltip=""},
        {ID = "A60Toggle",x=30+36.7*13,y=60+157*3,radius=25,tooltip=""},
        {ID = "A55Toggle",x=30+36.7*14,y=60+157*3,radius=25,tooltip="",lab=7},
        {ID = "A57Toggle",x=30+36.7*15,y=60+157*3,radius=25,tooltip=""},
        {ID = "A66Toggle",x=30+36.7*16,y=60+157*3,radius=25,tooltip=""},
        {ID = "A28Toggle",x=30+36.7*17,y=60+157*3,radius=25,tooltip=""},
    }
}
for i,button in pairs(ENT.ButtonMap.AV_C.buttons) do
    button.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",z=-25,
        var=button.ID:gsub("Toggle",""):gsub("[^:]+:",""),speed=8,
        sndvol = 0.8,snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
    }
    if plombed[button.ID] then
        button.model.plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=Angle(0,45,90),x=0,y=-37,z=32,var=button.ID:Replace("Toggle","Pl"), ID=button.ID:Replace("Toggle","Pl"),}
    end
    if button.lab then
        button.model.labels={{model="models/metrostroi_train/81-717/labels/label_717.mdl",skin=button.lab,ang=Angle(-90,90,0),z=40,x=2,y=(6<=button.lab and button.lab<=7) and -62 or -65}}
    end
    if button.lab2 then
        button.model.labels = button.model.labels or {}
        table.insert(button.model.labels,{model="models/metrostroi_train/81-717/labels/label_717paksd.mdl",skin=0,ang=Angle(-90,90,0),z=40,x=2,y=-65})
    end
    button.ID = "1:"..button.ID
end
ENT.ButtonMap["Battery_C"] = {
    pos = Vector(410.0,-57,35),
    ang = Angle(0,90,90),
    width = 180,
    height = 530,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "1:RC1Toggle",x=40,y=240+50,radius=40,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_rc1.mdl",z=17,ang=180,
            var="RC1",speed=0.5,vmin=1,vmax=0.87,
            plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=230,x=-28,y=28,var="RC1Pl",ID="RC1Pl",z=-15,},
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "1P:RC1Toggle",x=40,y=240+50,radius=40,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_rcvay.mdl",z=17,ang=180,
            var="RC1",speed=0.5,vmin=1,vmax=0.87,
            plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=230,x=-28,y=28,var="RC1Pl",ID="RC1Pl",z=-15,},
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:RC2Toggle",x=40,y=340+50,radius=40,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_rc2.mdl",z=17,ang=180,
            var="RC2",speed=0.5,vmin=1,vmax=0.87,
            plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=230,x=-28,y=28,var="RC2Pl",ID="RC2Pl",z=-15,},
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:VBToggle",x=40,y=440+50,radius=40,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_vb.mdl",z=17,ang=180,
            var="VB",speed=0.5,vmin=1,vmax=0.87,
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:VAUToggle",x=140,y=340+50,radius=40,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_rcvay.mdl",z=17,ang=180,
            var="VAU",speed=0.5,vmin=1,vmax=0.87,
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["VRD_C"] = {
    pos = Vector(410.0,-34,56),
    ang = Angle(0,90,90),
    width = 50,
    height = 50,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "1:VRDToggle",x=25,y=25,radius=25,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_vb.mdl",z=14,ang=180,
            var="VRD",speed=0.5,vmin=1,vmax=0.87,
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["SOSD_C"] = {
    pos = Vector(396-1,0.5,57.5),
    ang = Angle(0,90,90),
    width = 100,
    height = 136,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "1:VSOSDToggle",x=0, y=0, w=100, h=136,tooltip="",model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=14,ang=90,z=20.9,x=0,y=-12.5}},
            var="VSOSD",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["AV_R"] = {
    pos = Vector(398.5+11,-52.9+0.75,37.1),
    ang = Angle(0,90,90),
    width = 398,
    height = 358,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "A11Toggle",x=29.3*0,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A17Toggle",x=29.3*1,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A44Toggle",x=29.3*2,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A58Toggle",x=29.3*3,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A59Toggle",x=29.3*4,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A61Toggle",x=29.3*5,y=154*0,w=25,h=45,tooltip=""},
        {ID = "P:A58Toggle",x=29.3*3,y=154*0,w=25,h=45,tooltip=""},
        {ID = "P:A59Toggle",x=29.3*4,y=154*0,w=25,h=45,tooltip=""},
        {ID = "P:A61Toggle",x=29.3*5,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A21Toggle",x=29.3*6,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A49Toggle",x=29.3*7,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A27Toggle",x=29.3*8,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A10Toggle",x=29.3*9,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A53Toggle",x=29.3*10,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A54Toggle",x=29.3*11,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A84Toggle",x=29.3*12,y=154*0,w=25,h=45,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "A78Toggle",x=29.3*0,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A48Toggle",x=29.3*1,y=154*1,w=25,h=45,tooltip=""},
        {ID = "ABKToggle",x=29.3*2,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A29Toggle",x=29.3*3,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A46Toggle",x=29.3*4,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A47Toggle",x=29.3*5,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A43Toggle",x=29.3*6,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A42Toggle",x=29.3*7,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A74Toggle",x=29.3*8,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A73Toggle",x=29.3*9,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A71Toggle",x=29.3*10,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A41Toggle",x=29.3*11,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A45Toggle",x=29.3*12,y=154*1,w=25,h=45,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "A75Toggle",x=29.3*0,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A8Toggle",x=29.3*1,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A52Toggle",x=29.3*2,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A72Toggle",x=29.3*3,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A31Toggle",x=29.3*4,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A32Toggle",x=29.3*5,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A13Toggle",x=29.3*6,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A1Toggle",x=29.3*7,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A20Toggle",x=29.3*8,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A25Toggle",x=29.3*9,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A30Toggle",x=29.3*10,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A56Toggle",x=29.3*11,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A65Toggle",x=29.3*12,y=154*2,w=25,h=45,tooltip=""},
    }
}
for i,button in pairs(ENT.ButtonMap.AV_R.buttons) do
    button.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",z=-25,
        var=button.ID:gsub("Toggle",""):gsub("[^:]+:",""),speed=8,
        sndvol = 0.8,snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
    }
    if plombed[button.ID] then
        button.model.plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=Angle(0,25,45),x=19,y=-30,z=24,var=button.ID:Replace("Toggle","Pl"), ID=button.ID:Replace("Toggle","Pl"),}
    end
end
ENT.ButtonMap["AV_S"] = {
    pos = Vector(392,-33,-20),
    ang = Angle(0,270,90),
    width = 275,
    height = 165,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "A2Toggle",x=25*0,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A3Toggle",x=25*1,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A4Toggle",x=25*2,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A5Toggle",x=25*3,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A6Toggle",x=25*4,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A70Toggle",x=25*5,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A14Toggle",x=25*6,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A39Toggle",x=25*7,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A28Toggle",x=25*8,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A38Toggle",x=25*9,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A22Toggle",x=25*10,y=60*0,w=25,h=45,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "A12Toggle",x=25*0,y=60*1,w=25,h=45,tooltip=""},
        {ID = "A16Toggle",x=25*1,y=60*1,w=25,h=45,tooltip=""},
        {ID = "A37Toggle",x=25*2,y=60*1,w=25,h=45,tooltip=""},
        {ID = "A51Toggle",x=25*3,y=60*1,w=25,h=45,tooltip=""},
        {ID = "A24Toggle",x=25*4,y=60*1,w=25,h=45,tooltip=""},
        {ID = "A19Toggle",x=25*5,y=60*1,w=25,h=45,tooltip=""},
        {ID = "A18Toggle",x=25*7,y=60*1,w=25,h=45,tooltip=""},
        {ID = "A40Toggle",x=25*8,y=60*1,w=25,h=45,tooltip=""},
        {ID = "A15Toggle",x=25*9,y=60*1,w=25,h=45,tooltip=""},
        {ID = "A50Toggle",x=25*10,y=60*1,w=25,h=45,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "AISToggle",x=25*2,y=60*2,w=25,h=45,tooltip=""},
        {ID = "AV3Toggle",x=25*3,y=60*2,w=25,h=45,tooltip=""},
        {ID = "AV1Toggle",x=25*4,y=60*2,w=25,h=45,tooltip=""},
        {ID = "A55Toggle",x=25*5,y=60*2,w=25,h=45,tooltip=""},
        {ID = "A57Toggle",x=25*6,y=60*2,w=25,h=45,tooltip=""},
        {ID = "A60Toggle",x=25*7,y=60*2,w=25,h=45,tooltip=""},
        {ID = "A7Toggle",x=25*8,y=60*2,w=25,h=45,tooltip=""},
        {ID = "A9Toggle",x=25*9,y=60*2,w=25,h=45,tooltip=""},
    }
}
for i,button in pairs(ENT.ButtonMap.AV_S.buttons) do
    button.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",z=-25,
        var=button.ID:Replace("Toggle",""),speed=8,
        sndvol = 0.8,snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
    }
    if plombed[button.ID] then
        button.model.plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=Angle(0,45,90),x=0,y=-37,z=32,var=button.ID:Replace("Toggle","Pl"), ID=button.ID:Replace("Toggle","Pl"),}
    end
end
ENT.ButtonMap["Battery_R"] = {
    pos = Vector(410.0,-54.25,8),
    ang = Angle(0,90,90),
    width = 440,
    height = 157,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "2:RC1Toggle",x=64,y=40,radius=40,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_rc1.mdl",z=17,ang=180,
            var="RC1",speed=0.5,vmin=1,vmax=0.87,
            plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=230,x=-28,y=28,var="RC1Pl",ID="RC1Pl",z=-15,},
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "2P:RC1Toggle",x=64,y=40,radius=40,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_rcvay.mdl",z=17,ang=180,
            var="RC1",speed=0.5,vmin=1,vmax=0.87,
            plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=230,x=-28,y=28,var="RC1Pl",ID="RC1Pl",z=-15,},
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        --{ID = "1:RC1Pl",x=45,y=108,radius=20,tooltip=""},
        {ID = "2:VBToggle",x=220,y=40,radius=40,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_vb.mdl",z=17,ang=180,
            var="VB",speed=0.5,vmin=1,vmax=0.87,
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:RC2Toggle",x=376,y=40,radius=40,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_rc2.mdl",z=17,ang=180,
            var="RC2",speed=0.5,vmin=1,vmax=0.87,
            plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=230,x=-28,y=28,var="RC2Pl",ID="RC2Pl",z=-15,},
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:VAUToggle",x=142,y=117,radius=40,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_rcvay.mdl",z=17,ang=180,
            var="VAU",speed=0.5,vmin=1,vmax=0.87,
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:VRDToggle",x=298,y=117,radius=25,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_vb.mdl",z=14,ang=180,
            var="VRD",speed=0.5,vmin=1,vmax=0.87,
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["SOSD_R"] = {
    pos = Vector(410.0,-59,38),
    ang = Angle(0,90,90),
    width = 100,
    height = 136,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "2:VSOSDToggle",x=0, y=0, w=100, h=136,radius=25,tooltip="",model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=14,ang=90,z=20.9,x=0,y=-12.5}},
            var="VSOSD",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["CabVent_C"] = {
    pos = Vector(455.35,46.35,-13.02),
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

-- Train driver helpers panel
ENT.ButtonMap["HelperPanel_C"] = {
    pos = Vector(446.5,62.6,18.7),
    ang = Angle(0,0,90),
    width = 76,
    height = 242,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "VUD2Toggle",x=0,y=0,w=76,h=86,tooltip="",model = {
            model = "models/metrostroi_train/switches/vudbrown.mdl",z=25,
            var="VUD2",speed=6,
            sndvol = 1,snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            states={"Train.Buttons.Unlocked","Train.Buttons.Locked"},
        }},
        {ID = "VDLSet",x=0,y=90,w=76,h=86,tooltip="",model = {
            model = "models/metrostroi_train/switches/vudbrown.mdl",z=25,
            var="VDL",speed=6,
            sndvol = 1,snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "VOPDSet",x=38,y=235,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",z = -3,
            var="VOPD",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button2_off" end,
            sndmin = 60,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["HelperPanel_R"] = table.Copy(ENT.ButtonMap["HelperPanel_C"])
ENT.ButtonMap["HelperPanel_R"].pos = ENT.ButtonMap["HelperPanel_R"].pos - Vector(-0.4,0,-0.4)
for k,v in pairs(ENT.ButtonMap["HelperPanel_R"].buttons) do v.ID = "1:"..v.ID end
--[[
-- Pneumatic instrument panel
ENT.ButtonMap["PneumaticPanels"] = {
    pos = Vector(459.6,-9.0,13.4),
    ang = Angle(0,-90,56.5),
    width = 310,
    height = 120,
    scale = 0.0625,

    buttons = {
        {ID = "!CylinderPressure",x=200,y=55,radius=55,tooltip=""},
        {ID = "!LinePressure",x=65,y=55,radius=55,tooltip=""},
    }
}--]]
ENT.ButtonMap["ParkingBrake"] = {
    pos = Vector(456.777527-3,5,-30),
    ang = Angle(0,-90,60),
    width = 200,
    height = 120,
    scale = 0.0625,

    buttons = {
        {ID = "ParkingBrakeToggle",x=0,y=0,w=200,h=120,tooltip="",model = {
            var="ParkingBrake",sndid="parking_brake",
            sndvol = 1,snd = function(val) return "disconnect_valve" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
    }
}



ENT.ButtonMap["EPKDisconnect"] = {
    pos = Vector(439.0,-43.3,-33),
    ang = Angle(0,-90,0),
    width = 200,
    height = 120,
    scale = 0.0625,

    buttons = {
        {ID = "EPKToggle",x=0,y=0,w=200,h=120,tooltip="",model = {
            var="EPK",sndid="EPK_disconnect",
            sndvol = 1,snd = function(val) return "disconnect_valve" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
    }
}

ENT.ClientProps["reverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = Vector(438,-29.9,-14.9),
    ang = Angle(-90-22,180,90),
    hideseat=0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientProps["krureverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = Vector(443.8,-24.5,-3.2),
    ang = Angle(0,-90,60),
    hideseat=0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}

ENT.ButtonMap["HVMeters_O"] = {
    pos = Vector(453.3,-28.7,20.1),
    ang = Angle(0,-130,90),
    width = 68,
    height = 138,
    scale = 0.0625,

    buttons = {
        {ID = "!EnginesCurrent", x=0, y=0, w=68, h=64, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesCurrent"),ent:GetPackedRatio("EnginesCurrent")*1000-500) end},
        {ID = "!HighVoltage", x=0, y=74, w=68, h=64, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesVoltage"),ent:GetPackedRatio("EnginesVoltage")*1000) end},
    }
}
ENT.ButtonMap["HVMeters_N"] = {
    pos = Vector(455.2,-26.5,15),
    ang = Angle(0,-120,90),
    width = 145,
    height = 45,
    scale = 0.0625,

    buttons = {
        {ID = "!HighVoltage", x=0, y=0, w=65, h=45, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesVoltage"),ent:GetPackedRatio("EnginesVoltage")*1000) end},
        {ID = "!EnginesCurrent", x=75, y=0, w=70, h=45, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesCurrent"),ent:GetPackedRatio("EnginesCurrent")*1000-500) end},
    }
}

-- UAVA
ENT.ButtonMap["UAVAPanel"] = {
    pos = Vector(423,-57,-25.0),
    ang = Angle(0,180,90),
    width = 180,
    height = 200,
    scale = 0.0625,

    buttons = {
        {ID = "UAVAToggle",x=0, y=0, w=60, h=200, tooltip="", model = {
            plomb = {var="UAVAPl", ID="UAVAPl",},
            var="UAVA",
            sndid="UAVALever",sndvol = 1, snd = function(val) return val and "uava_on" or "uava_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "UAVACToggle",x=60, y=0, w=120, h=200, tooltip="",var="UAVAC",states={"Train.Buttons.UAVAOff","Train.Buttons.UAVAOn"}},
    }
}
ENT.ClientProps["UAVALever"] = {
    model = "models/metrostroi_train/81-703/cabin_uava.mdl",
    pos = Vector(422.7,-59.4,-31.6),
    ang = Angle(3,-180,0),
    hideseat=0.2,
}

ENT.ButtonMap["Stopkran"] = {
    pos = Vector(401,62,17),
    ang = Angle(0,0,90),
    width = 200,
    height = 1300,
    scale = 0.1/2,
    buttons = {
        {ID = "EmergencyBrakeValveToggle",x=0,y=0,w=200,h=1300,tooltip="", tooltip="",tooltip="",states={"Train.Buttons.Closed","Train.Buttons.Opened"},var="EmergencyBrakeValve"},
    }
}
ENT.ClientProps["stopkran"] = {
    model = "models/metrostroi_train/81-717/stop_spb.mdl",
    pos = Vector(408.45,62.15,11.5),
    ang = Angle(0,0,0),
    hideseat=0.2,
}
ENT.ClientSounds["EmergencyBrakeValve"] = {{"stopkran",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ButtonMap["DriverValveBLDisconnect"] = {
    pos = Vector(426.1,-27.3,-20),
    ang = Angle(90,-150,90),
    width = 200,
    height = 100,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveBLDisconnectToggle", x=0, y=0, w=200, h=100, tooltip="", model = {
            var="DriverValveBLDisconnect",sndid="brake_disconnect",
            sndvol = 1, snd = function(val) return "disconnect_valve" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
    }
}
ENT.ButtonMap["DriverValveTLDisconnect"] = {
    pos = Vector(429.3,-23,-15),
    ang = Angle(90,-150,90),
    width = 200,
    height = 90,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveTLDisconnectToggle", x=0, y=0, w=200, h=90, tooltip="", model = {
            var="DriverValveTLDisconnect",sndid="train_disconnect",
            sndvol = 1, snd = function(val) return val and "pneumo_TL_open" or "pneumo_TL_disconnect" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
    }
}
ENT.ButtonMap["EPKDisconnect"] = {
    pos = Vector(435,-40,-23),
    ang = Angle(0,-90-45,45),
    width = 200,
    height = 120,
    scale = 0.0625,

    buttons = {
        {ID = "EPKToggle",x=0,y=0,w=200,h=120,tooltip="",model = {
            var="EPK",--,sndid="EPK_disconnect",
            --sndvol = 1,snd = function(val) return "disconnect_valve" end,
            --sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
    }
}
ENT.ButtonMap["EPVDisconnect"] = {
    pos = Vector(435,-40,-23),
    ang = Angle(0,-90-45,45),
    width = 200,
    height = 120,
    scale = 0.0625,

    buttons = {
        {ID = "EPKToggle",x=0,y=0,w=200,h=120,tooltip="",model = {
            var="EPK",--,sndid="EPK_disconnect",
            --sndvol = 1,snd = function(val) return "disconnect_valve" end,
            --sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
    }
}
ENT.ClientProps["brake_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran1.mdl",
    pos = Vector(427.3,-28.9,-32.5),
    ang = Angle(90,-60,90),
    hideseat=0.2,
}
ENT.ClientSounds["EPK"] = {
    {"EPK_disconnect",function() return "disconnect_valve" end,1,1,90,1e3,Angle(-90,0,0)},
    {"EPV_disconnect",function() return "disconnect_valve" end,1,1,90,1e3,Angle(-90,0,0)},
}
ENT.ClientProps["EPK_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran1.mdl",
    pos = Vector(432.4,-44.25,-24.7),
    ang = Angle(0,-90,0),
    hideseat=0.2,
}
ENT.ClientProps["EPV_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran1.mdl",
    pos = Vector(431.15,-43.5,-24.7),
    ang = Angle(0,-90,0),
    hideseat=0.2,
}
ENT.ClientProps["train_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran3.mdl",
    pos = Vector(430.1,-24.0,-24.1),
    ang = Angle(90,-60,90),
    hideseat=0.2,
}

ENT.ButtonMap["DriverValveDisconnect"] = {
    pos = Vector(425,-23,-27),
    ang = Angle(90,-150,90),
    width = 200,
    height = 90,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveDisconnectToggle",x=0,y=0,w=200,h=90,tooltip="",model = {
            var="DriverValveDisconnect",sndid="valve_disconnect",
            sndvol = 1,snd = function(val) return "disconnect_valve" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
    }
}
ENT.ClientProps["valve_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran3.mdl",
    pos = Vector(428.15,-22.95,-37.43),
    ang = Angle(90,240+2,90),
    hideseat=0.2,
}

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
    pos = Vector(170-3-9.5,50+20,-60+2),
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
    pos = Vector(153.5-3-9.5,36+20,-78+2),
    ang = Angle(-90,90,-90),
    color = Color(150,255,255),
    hide = 0.5,
}
ENT.ClientProps["gv_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["gv"].pos,
    ang = Angle(-90,0,0),
    hide = 0.5,
}


ENT.ClientProps["parking_brake"] = {
    model = "models/metrostroi_train/81-707/cran3.mdl",
    pos = Vector(453.6,-0.25,-39.8),
    ang = Angle(120,0,180),
    hideseat=0.2,
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

for i=0,4 do
    ENT.ClientProps["TrainNumberL"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(43+i*6.4,67.2,-12),
        ang = Angle(0,180,0),
        skin=i,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
    ENT.ClientProps["TrainNumberR"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(64-i*6.4,-67.2,-12),
        ang = Angle(0,0,0),
        skin=i,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end

ENT.ButtonMap["Route"] = {
    pos = Vector(458.20,37.9,-2.3),
    ang = Angle(0,99,90),
    width = 230,
    height = 130,
    scale = 0.0625,
    buttons = {
        {ID = "RouteNumber1+",x=76.5*0,y=0,w=76.5,h=65,tooltip=""},
        {ID = "RouteNumber2+",x=76.5*1,y=0,w=76.5,h=65,tooltip=""},
        {ID = "RouteNumber3+",x=76.5*2,y=0,w=76.5,h=65,tooltip=""},
        {ID = "RouteNumber1-",x=76.5*0,y=65,w=76.5,h=65,tooltip=""},
        {ID = "RouteNumber2-",x=76.5*1,y=65,w=76.5,h=65,tooltip=""},
        {ID = "RouteNumber3-",x=76.5*2,y=65,w=76.5,h=65,tooltip=""},
    }
}

ENT.ClientProps["route1"] = {
    model = "models/metrostroi_train/81-502/route/route_number.mdl",
    pos = Vector(457.80,40.16,-6.3),
    ang = Angle(90,189,180),
    skin=2,
    hide = 1.5,
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
}
ENT.ClientProps["route2"] = {
    model = "models/metrostroi_train/81-502/route/route_number.mdl",
    pos = Vector(457.03,45.03,-6.3),
    ang = Angle(90,189,180),
    skin=2,
    hide = 1.5,
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
}
ENT.ClientProps["route3"] = {
    model = "models/metrostroi_train/81-502/route/route_number.mdl",
    pos = Vector(456.30,49.72,-6.3),
    ang = Angle(90,189,180),
    skin=8,
    hide = 1.5,
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
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
ENT.ButtonMap["OtsekDoor1"] = {
    pos = Vector(394.5,28,12.6),
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
    pos = Vector(394.5,28,-15.5),
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
    pos = Vector(414.5,64,56.7),
    ang = Angle(0,0,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoor",x=0,y=0,w=642,h=2000,tooltip="",model = {
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
--[[ ENT.ButtonMap["LeftMirror"] = {
    pos = Vector(469.9,72.75,37.4),
    ang = Angle(0,-60,90),
    width = 128,
    height = 256,
    scale = 0.06,
}
ENT.ButtonMap["RightMirror"] = {
    pos = Vector(470.0+3.4,-72.75+6,37.4),
    ang = Angle(0,-60-60,90),
    width = 128,
    height = 256,
    scale = 0.06,
}--]]
--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false
ENT.ClientProps["brake013"] = {
    model = "models/metrostroi_train/81-717/cran13.mdl",
    pos = Vector(431.5,-20.3,-10.2),
    ang = Angle(0,180,0),
    hideseat = 0.2,
}
ENT.ClientProps["brake334"] = {
    model = "models/metrostroi_train/81-703/cabin_cran_334.mdl",
    pos = Vector(432.27,-22.83,-8.2),
    ang = Angle(0,-230,0),
    hideseat = 0.2,
}
if not ENT.ClientSounds["br_013"] then ENT.ClientSounds["br_013"] = {} end
table.insert(ENT.ClientSounds["br_013"],{"brake013",function(ent,_,var) return "br_013" end,0.7,1,50,1e3,Angle(-90,0,0)})
if not ENT.ClientSounds["br_334"] then ENT.ClientSounds["br_334"] = {} end
table.insert(ENT.ClientSounds["br_334"],{"brake334",function(ent,_,var) return "br_334_"..var end,1,1,50,1e3,Angle(-90,0,0)})
--------------------------------------------------------------------------------

ENT.ClientProps["PB"] = {
    model = "models/metrostroi_train/81-720/720_pb.mdl",
    pos = Vector(450, 18, -37),
    ang = Angle(0,-90,8),
    hideseat = 0.2,
}
if not ENT.ClientSounds["PB"] then ENT.ClientSounds["PB"] = {} end
table.insert(ENT.ClientSounds["PB"],{"PB",function(ent,var) return var > 0 and "pb_on" or "pb_off" end,1,1,50,1e3,Angle(-90,0,0)})

ENT.ClientProps["train_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(450.665070,-15.255391,-3.192689+5.35),
    ang = Angle(-62.299999,-33.400002,0.000000),
    hideseat = 0.2,
}
ENT.ClientProps["brake_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_tm.mdl",
    pos = Vector(450.684143,-15.267894,-3.204609+5.35),
    ang = Angle(-62.299999,-33.400002,0.000000),
    hideseat = 0.2,
}
ENT.ClientProps["brake_cylinder"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(450.535736,-22.815704,-3.113149+5.35),
    ang = Angle(-62.299999,-33.400002,0.000000),
    hideseat = 0.2,
}
ENT.ClientProps["ampermeter"] = {
    model = "models/metrostroi/81-717/volt_arrow.mdl",
    pos = Vector(452.269592,-30.540430,16.922098),
    ang = Angle(90.500000,0.000000,40.000000),
    hideseat = 0.2,
}
ENT.ClientProps["voltmeter"] = {
    model = "models/metrostroi/81-717/volt_arrow.mdl",
    pos = Vector(452.246277,-30.519978,12.287716),
    ang = Angle(90.500000,0.000000,40.000000),
    hideseat = 0.2,
}

ENT.ClientProps["voltmeter2"] = {
    model = "models/metrostroi/81-717/volt_arrow.mdl",
    pos = Vector(454.6,-28.33,12.1),
    ang = Angle(90.500000,0.000000,30.500000),
    hideseat = 0.2,
}
ENT.ClientProps["ampermeter2"] = {
    model = "models/metrostroi/81-717/volt_arrow.mdl",
    pos = Vector(452.3,-32.45,12.1),
    ang = Angle(90.500000,0.000000,30.500000),
    hideseat = 0.2,
}
ENT.ClientProps["volt1"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(449.501740,15.141174,0.812889),
    ang = Angle(-58.299999,0.000000,27.968136),
    bscale = Vector(1,1,1.47),
    hideseat = 0.2,
}

ENT.ClientProps["bortlamps1"] = {
    model = "models/metrostroi_train/81-717/bort_lamps_body.mdl",
    pos = Vector(-52,67,45.5),
    ang = Angle(0,0,0),
    hide = 2,
}
ENT.ClientProps["bortlamp1_w"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_b.mdl",
    pos = ENT.ClientProps.bortlamps1.pos+Vector(0,0.85,3.2),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamp1_g"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_g.mdl",
    pos = ENT.ClientProps.bortlamps1.pos+Vector(0,0.85,-0.1),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamp1_y"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_y.mdl",
    pos = ENT.ClientProps.bortlamps1.pos+Vector(0,0.85,-3.35),
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
-- Add doors
--[[ local function GetDoorPosition(i,k,j)
    if j == 0
    then return Vector(338.0-230.1*i+(1-k)*0.8,-65*(1-2*k),0.761)
    else return Vector(338.2-230.1*i+(1-k)*0.8,-65*(1-2*k),0.761)
    end
end
for i=0,3 do
    for k=0,1 do
        ENT.ClientProps["door"..i.."x"..k.."a"] = {
            model = "models/metrostroi_train/81-717/door_right_spb.mdl",
            pos = GetDoorPosition(i,k,0),
            ang = Angle(0,90 +180*k,0),
            hide = 2,
        }
        ENT.ClientProps["door"..i.."x"..k.."b"] = {
            model = "models/metrostroi_train/81-717/door_left_spb.mdl",
            pos = GetDoorPosition(i,k,1),
            ang = Angle(0,90 +180*k,0),
            hide = 2,
        }
    end
end--]]
ENT.ClientProps["door0x1"] = {
    model = "models/metrostroi_train/81-717/81-717_doors_spb_pos1.mdl",
    pos = Vector(338.445+1.2-2.2,65.164,0.807),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x1"] = {
    model = "models/metrostroi_train/81-717/81-717_doors_spb_pos2.mdl",
    pos = Vector(108.324+1.2-2.2,65.164,0.807),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x1"] = {
    model = "models/metrostroi_train/81-717/81-717_doors_spb_pos3.mdl",
    pos = Vector(-122.182+1.6-2.2,65.164,0.807),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x1"] = {
    model = "models/metrostroi_train/81-717/81-717_doors_spb_pos4.mdl",
    pos = Vector(-351.531+0.8-2.2,65.164,0.807),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door0x0"] = {
    model = "models/metrostroi_train/81-717/81-717_doors_spb_pos4.mdl",
    pos = Vector(338.445+1.2,-65.164,0.807),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x0"] = {
    model = "models/metrostroi_train/81-717/81-717_doors_spb_pos3.mdl",
    pos = Vector(108.324+1.2,-65.164,0.807),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x0"] = {
    model = "models/metrostroi_train/81-717/81-717_doors_spb_pos2.mdl",
    pos = Vector(-122.182+1.6,-65.164,0.807),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x0"] = {
    model = "models/metrostroi_train/81-717/81-717_doors_spb_pos1.mdl",
    pos = Vector(-351.531+0.8,-65.164,0.807),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["Lamp_RTM"] = {
    model = "models/metrostroi_train/81-717/rtmlamp.mdl",
    pos = Vector(448.35,-33.95,-3.9),
    ang = Angle(0,-35,0),
    hideseat = 0.2,
}
ENT.ClientProps["Lamps_cab1"] = {
    model = "models/metrostroi_train/81-717/lamps/lamp_cabine1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat = 0.9,
}
ENT.ClientProps["Lamps_cab2"] = {
    model = "models/metrostroi_train/81-717/lamps/lamp_cabine2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat = 0.9,
}
ENT.ClientProps["Lamps2_cab1"] = {
    model = "models/metrostroi_train/81-717/lamps/lamp_cabine1.mdl",
    pos = Vector(0.5,0,-0.7),
    ang = Angle(0,0,0),
    hideseat = 0.9,
}
ENT.ClientProps["Lamps2_cab2"] = {
    model = "models/metrostroi_train/81-717/lamps/lamp_cabine2.mdl",
    pos = Vector(0,0,-0.8),
    ang = Angle(0,0,0),
    hideseat = 0.9,
}
for i = 0,11 do
    --[[ local b = 15--math.random()*15
    local g = 15--b+math.random()*(15-b)
    if math.random() > 0.4 then
        g = math.random()*15
        b = g
    else
        g = 15
        b = -10+math.random()*25
    end--]]
    ENT.ClientProps["lamp1_"..i+1] = {
        model = "models/metrostroi_train/81-717/lamps/lamp_typ1.mdl",
        pos = Vector(333.949 - 66.66*i,0,67.7),
        ang = Angle(0,0,0),
        --color = Color(255,235+g,235+b),
        color = Color(255,255,255),
        hideseat = 1.1,
    }
end
--[[
local pos = Vector(454.3,-28.3,12+3.5)
local ang = Angle(60,-30,180)
ENT.ClientProps["TEST"] = {
    model = "models/metrostroi_train/81/334cran.mdl",
    pos = pos,
    ang = ang,
    scale=0.1,
}--]]
ENT.Lights = {
    [1] = { "headlight",Vector(460,0,-40),Angle(0,0,0),Color(216,161,92),farz=5144,brightness = 4, fov=100, texture = "models/metrostroi_train/equipment/headlight",shadows = 1,headlight=true},
    [2] = { "headlight",        Vector(460,0,50), Angle(-20,0,0), Color(255,0,0), fov=160 ,brightness = 0.3, farz=450,texture = "models/metrostroi_train/equipment/headlight2",shadows = 0,backlight=true},

    [3] = { "headlight",        Vector(365,-9,50), Angle(50,40,-0), Color(206,135,80), hfov=80, vfov=80,farz=100,brightness = 6,shadows=1, hidden="salon"},
    [4] = { "headlight",        Vector(365,-51,50), Angle(50,40,-0), Color(206,135,80), hfov=80, vfov=80,farz=100,brightness = 6,shadows=1, hidden="salon"},

    -- Reverse
    [8] = { "light",Vector(465,-45, 52), Angle(0,0,0), Color(255,50,50),     brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02", size=2 },
    [9] = { "light",Vector(465, 45, 52), Angle(0,0,0), Color(255,50,50),     brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02", size=2 },

    -- Cabin
    [10] = { "dynamiclight",        Vector( 425, 0, 30), Angle(0,0,0), Color(216,161,92), distance = 550, brightness = 0.25, hidden = "salon"},

    -- Interior
    [11] = { "dynamiclight",    Vector( 200, 0, 0), Angle(0,0,0), Color(255,245,245), brightness = 3, distance = 400 , fov=180,farz = 128, changable = true },
    [12] = { "dynamiclight",    Vector(   0, 0, 0), Angle(0,0,0), Color(255,245,245), brightness = 3, distance = 400, fov=180,farz = 128, changable = true },
    [13] = { "dynamiclight",    Vector(-200, 0, 0), Angle(0,0,0), Color(255,245,245), brightness = 3, distance = 400 , fov=180,farz = 128, changable = true },

    -- Side lights
    [15] = { "light",Vector(-52,67,45.5)+Vector(0,0.9,3.25), Angle(0,0,0), Color(254,254,254), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [16] = { "light",Vector(-52,67,45.5)+Vector(0,0.9,-0.02), Angle(0,0,0), Color(40,240,122), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [17] = { "light",Vector(-52,67,45.5)+Vector(0,0.9,-3.3), Angle(0,0,0), Color(254,210,18), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [18] = { "light",Vector(39,-67,45.5)+Vector(0,-0.9,3.25), Angle(0,0,0), Color(254,254,254), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [19] = { "light",Vector(39,-67,45.5)+Vector(0,-0.9,-0.02), Angle(0,0,0), Color(40,240,122), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [20] = { "light",Vector(39,-67,45.5)+Vector(0,-0.9,-3.3), Angle(0,0,0), Color(254,210,18), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },

    [30]  = { "light",           Vector(455  ,   -45, -23.5), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02", changable = true, size = 2},
    [31]  = { "light",           Vector(455  ,   45, -23.5), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02", changable = true, size = 2},
    [32]  = { "light",           Vector(455  ,   0, 52), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02", changable = true, size = 2},

    -- Manometers
    [40] = { "headlight",Vector(451.9,-13.5,-2+5.35),Angle(52.571899-15-5,-129.269775+25+15,49.853062) ,Color(255,130,25),farz = 8,nearz = 2,shadows = 1,brightness = 1,fov = 145, hidden = "Controller_body" },
    [41] = { "headlight",Vector(451.8,-21,-2+5.35),Angle(52.571899-15-5,-129.269775+25+15,49.853062),Color(255,130,25),farz = 8,nearz = 2,shadows = 1,brightness = 1,fov = 140, hidden = "Controller_body" },
    [42] = { "headlight",Vector(450.3,13.1,-4.4+5.35),Angle(-136.613632-33,-95.636734-28,137.434570),Color(255,130,25),farz = 8,nearz = 2,shadows = 0,brightness = 1.5,fov = 120, hidden = "Controller_body" },
    -- Voltmeter
    [44] = { "headlight",Vector(450.273468,-32.306019,13.236823),Angle(-18.000000,25.541767,-90.600349),Color(255,130,25),farz = 10,nearz = 2,shadows = 1,brightness = 1,fov = 100, hidden = "Controller_body" },
    [45] = { "headlight",Vector(450.273468,-32.306019,18.236823),Angle(-12.000000,25.541767,-90.600349),Color(255,130,25),farz = 10,nearz = 2,shadows = 1,brightness = 1,fov = 100, hidden = "Controller_body" },

    [46] = { "headlight",Vector(452,-32.2,12+3.5),Angle(60,-30,180),Color(255,130,25),farz = 8,nearz = 2,shadows = 0,brightness = 1,fov = 130, hidden = "Controller_body" },
    [47] = { "headlight",Vector(454.3,-28.3,12+3.5),Angle(60,-30,180),Color(255,130,25),farz = 8,nearz = 2,shadows = 0,brightness = 1,fov = 130, hidden = "Controller_body" },


    -- Manometers
    [50] = { "headlight",Vector(451.9,-13.5,-2+5.35),Angle(52.571899-15-5,-129.269775+25+15,49.853062) ,Color(200,200,255),farz = 8,nearz = 2,shadows = 1,brightness = 2,fov = 145, hidden = "Controller_body" },
    [51] = { "headlight",Vector(451.8,-21,-2+5.35),Angle(52.571899-15-5,-129.269775+25+15,49.853062),Color(200,200,255),farz = 8,nearz = 2,shadows = 1,brightness = 2,fov = 140, hidden = "Controller_body" },
    [52] = { "headlight",Vector(450.3,13.1,-4.4+5.35),Angle(-136.613632-33,-95.636734-28,137.434570),Color(200,200,255),farz = 8,nearz = 2,shadows = 0,brightness = 2.5,fov = 120, hidden = "Controller_body" },
    -- Voltmeter
    [54] = { "headlight",Vector(450.273468,-32.306019,13.236823),Angle(-18.000000,25.541767,-90.600349),Color(200,200,255),farz = 10,nearz = 2,shadows = 1,brightness = 2,fov = 100, hidden = "Controller_body" },
    [55] = { "headlight",Vector(450.273468,-32.306019,18.236823),Angle(-12.000000,25.541767,-90.600349),Color(200,200,255),farz = 10,nearz = 2,shadows = 1,brightness = 2,fov = 100, hidden = "Controller_body" },

    [56] = { "headlight",Vector(452,-32.2,12+3.5),Angle(60,-30,180),Color(200,200,255),farz = 8,nearz = 2,shadows = 0,brightness = 2,fov = 130, hidden = "Controller_body" },
    [57] = { "headlight",Vector(454.3,-28.3,12+3.5),Angle(60,-30,180),Color(200,200,255),farz = 8,nearz = 2,shadows = 0,brightness = 2,fov = 130, hidden = "Controller_body" },

    [70] = { "headlight",Vector( 425,-56,-70),Angle(0,-90,0),Color(255,220,180),brightness = 0.3,distance = 300 ,fov=120,shadows = 1, texture="effects/flashlight/soft", hidden = "Controller_body" },

    Lamp_RTM = {"light", Vector(448.35,-33.95,-3.9), Angle(0,0,0),Color(255,180,60),brightness = 0.4,scale = 0.03, texture = "sprites/light_glow02", hidden = "Lamp_RTM"},

    Lamps_cab1 = {"light", Vector(396.5,14.8,53), Angle(0,0,0),Color(255,220,180),brightness = 0.25,scale = 0.2, texture = "sprites/light_glow02", hidden = "Lamps_cab1"},
    Lamps_cab2 = {"light", Vector(428,-1.5,60), Angle(0,0,0),Color(255,220,180),brightness = 0.35,scale = 0.25, texture = "sprites/light_glow02", hidden = "Lamps_cab2"},
    Lamps2_cab1 = {"light", Vector(396.5,14.8,52.5), Angle(0,0,0),Color(255,220,180),brightness = 0.25,scale = 0.2, texture = "sprites/light_glow02", hidden = "Lamps2_cab1"},
    Lamps2_cab2 = {"light", Vector(428,-1.3,59.2), Angle(0,0,0),Color(255,220,180),brightness = 0.35,scale = 0.25, texture = "sprites/light_glow02", hidden = "Lamps2_cab2"},
}

--ENT.AutoPos = {Vector(407.3,-10.5,47),Vector(419.3,-57.5,47.5)}
--local X = Material( "metrostroi_skins/81-717/6.png")

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    --self.Train:SetPackedRatio("EmergencyValve_dPdT",leak)
    --self.Train:SetPackedRatio("EmergencyValveEPK_dPdT",leak)
    --self.Train:SetPackedRatio("EmergencyBrakeValve_dPdT",leak)
    self.PUAV = self:CreateRT("717PUAV",512,128)
    self.PAM = self:CreateRT("717PAM",1024,512)
    self.LeftMirror = self:CreateRT("LeftMirror",128,256)
    self.RightMirror = self:CreateRT("RightMirror",128,256)

    self.CraneRamp = 0
    self.CraneRRamp = 0
    self.ReleasedPdT = 0
    self.EmergencyValveRamp = 0
    self.EmergencyValveEPKRamp = 0
    self.EmergencyBrakeValveRamp = 0
    self.FrontLeak = 0
    self.RearLeak = 0

    self.VentCab = 0

    self.BPSNBuzzVolume = 0
end

function ENT:UpdateWagonNumber()
    local count = math.max(4,math.ceil(math.log10(self.WagonNumber+1)))
    for i=0,4 do
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
local Cpos = {
    0,0.2,0.4,0.5,0.6,0.8,1
}
--------------------------------------------------------------------------------
function ENT:Think()
    self.BaseClass.Think(self)
    if not self.RenderClientEnts or self.CreatingCSEnts then
        self.RKTimer = nil
        self.OldBPSNType = nil

        self.RingType = nil
        self.LastStation = false
        return
    end

    if self.Scheme ~= self:GetNW2Int("Scheme",1) then
        self.PassSchemesDone = false
        self.Scheme = self:GetNW2Int("Scheme",1)
    end
    if self.RelaysConfig ~= self:GetNW2String("RelaysConfig") then
        self.RelaysConfig = self:GetNW2String("RelaysConfig")
        self:SetRelays()
    end
    if not self.PassSchemesDone and IsValid(self.ClientEnts.schemes) then
        local scheme = Metrostroi.Skins["717_new_schemes"] and Metrostroi.Skins["717_new_schemes"][self.Scheme]
        self.ClientEnts.schemes:SetSubMaterial(1,scheme and scheme[1])
        self.PassSchemesDone = true
    end
    if self.NewBlueSeats ~= self:GetNW2Bool("NewSeatsBlue") then
        self.NewBlueSeats = self:GetNW2Bool("NewSeatsBlue")
        if IsValid(self.ClientEnts.seats_new) then
            self.ClientEnts.seats_new:SetSubMaterial(0,self.NewBlueSeats and "models/metrostroi_train/81-717/interior_kvr_blue" or "")
        end
        if IsValid(self.ClientEnts.seats_new_cap_o) then
            self.ClientEnts.seats_new_cap_o:SetSubMaterial(0,self.NewBlueSeats and "models/metrostroi_train/81-717/interior_kvr_blue" or "")
        end
    end

    local WhitePLights = self:GetNW2Bool("WhitePLights")
    self:SetLightPower(40,not WhitePLights and self:GetPackedBool("PanelLights"))
    self:SetLightPower(41,not WhitePLights and self:GetPackedBool("PanelLights"))
    self:SetLightPower(42,not WhitePLights and self:GetPackedBool("PanelLights"))
    self:SetLightPower(50,WhitePLights and self:GetPackedBool("PanelLights"))
    self:SetLightPower(51,WhitePLights and self:GetPackedBool("PanelLights"))
    self:SetLightPower(52,WhitePLights and self:GetPackedBool("PanelLights"))

    local sosd = self:Animate("SOSD",self:GetPackedBool("SOSDL") and 1 or 0,0,1,6,false)
    self:ShowHideSmooth("sosd_lamp",sosd)
    self:SetLightPower(70,sosd>0,sosd)

    local mask = self:GetNW2Int("MaskType",1)
    if self.MaskType ~= mask then
        self:ShowHide("mask22_1",mask==1)
        self:ShowHide("mask22_2",mask==2)
        self:ShowHide("mask222_lvz",mask==3)
        self:ShowHideSmooth("Headlights222_1",0)
        self:ShowHideSmooth("Headlights222_2",0)
        self:ShowHideSmooth("Headlights22_1",0)
        self:ShowHideSmooth("Headlights22_2",0)
        --[[if mask == 3 then
            self.LightsOverride[30][2] = Vector(465,-48, -23.5)
            self.LightsOverride[31][2] = Vector(465,48 , -23.5)
            self.LightsOverride[32][2] = Vector(465,0  , -23.5)
        elseif mask < 3 then
            self.LightsOverride[30][2] = Vector(465,-45, -23.5)
            self.LightsOverride[31][2] = Vector(465,45 , -23.5)
            self.LightsOverride[32][2] = Vector(465,0  , 52)
        end]]
    end

    local HL1 = self:Animate("Headlights1",self:GetPackedBool("Headlights1") and 1 or 0,0,1,6,false)
    local HL2 = self:Animate("Headlights2",self:GetPackedBool("Headlights2") and 1 or 0,0,1,6,false)
    local RL = self:Animate("RedLights_a",self:GetPackedBool("RedLights") and 1 or 0,0,1,6,false)
    if mask == 3 then
        self:ShowHideSmooth("Headlights222_1",HL1)
        self:ShowHideSmooth("Headlights222_2",HL2)
    elseif mask < 3 then
        self:ShowHideSmooth("Headlights22_1",HL1)
        self:ShowHideSmooth("Headlights22_2",HL2)
    end

    self:ShowHideSmooth("RedLights",RL)
    self:SetLightPower(8,RL > 0,RL)
    self:SetLightPower(9,RL > 0,RL)

    local headlight = HL1*0.6+HL2*0.4
    self:SetLightPower(1,headlight>0,headlight)
    self:SetLightPower(2,self:GetPackedBool("RedLights"),RL)
    self:SetLightPower(30,headlight > 0,headlight)
    self:SetLightPower(31,headlight > 0,headlight)
    self:SetLightPower(32,mask==3 and headlight > 0,headlight)


    if IsValid(self.GlowingLights[1]) then
        if not self:GetPackedBool("Headlights1") and self.GlowingLights[1]:GetFarZ() ~= 3144 then
            self.GlowingLights[1]:SetFarZ(3144)
        end
        if self:GetPackedBool("Headlights1") and self.GlowingLights[1]:GetFarZ() ~= 5144 then
            self.GlowingLights[1]:SetFarZ(5144)
        end
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
    self:SetLightPower(15, Bortlamp_w > 0, Bortlamp_w)
    self:SetLightPower(18, Bortlamp_w > 0, Bortlamp_w)
    self:SetLightPower(16, Bortlamp_g > 0, Bortlamp_g)
    self:SetLightPower(19, Bortlamp_g > 0, Bortlamp_g)
    self:SetLightPower(17, Bortlamp_y > 0, Bortlamp_y)
    self:SetLightPower(20, Bortlamp_y > 0, Bortlamp_y)

    self:Animate("Controller",self:GetPackedRatio("ControllerPosition"),0.3,0.02,2,false)

    self:Animate("reverser",self:GetNW2Int("ReverserPosition")/2,0,0.27,4,false)
    self:Animate("krureverser",self:GetNW2Int("KRUPosition")/2,0.53,0.95,4,false)
    self:ShowHide("reverser",self:GetNW2Int("WrenchMode",0)==1)
    self:ShowHide("krureverser",self:GetNW2Int("WrenchMode",0)==2)

    local newSeats = self:GetNW2Bool("NewSeats")
    self:ShowHide("seats_old",not newSeats)
    self:ShowHide("seats_old_cap",not newSeats)
    self:ShowHide("seats_new",newSeats)
    self:ShowHide("seats_new_cap",newSeats)
    self:Animate("PB",self:GetPackedBool("PB") and 1 or 0,0,0.2,  12,false)
    self:Animate("UAVALever",   self:GetPackedBool("UAVA") and 1 or 0,     0,0.6, 128,  3,false)
    self:Animate("parking_brake",   self:GetPackedBool("ParkingBrake") and 1 or 0,0.25,0,  4,false)
    self:Animate("EPK_disconnect",   self:GetPackedBool("EPK") and 1 or 0,0.25,0,  4,false)
    self:Animate("EPV_disconnect",   self:GetPackedBool("EPK") and 1 or 0,0.25,0,  4,false)
    self:Animate("brake_disconnect",self:GetPackedBool("DriverValveBLDisconnect") and 1 or 0,0.25,0,  4,false)
    self:Animate("train_disconnect",self:GetPackedBool("DriverValveTLDisconnect") and 1 or 0,0.25,0,  4,false)
    self:Animate("valve_disconnect",self:GetPackedBool("DriverValveDisconnect") and 1 or 0,0.25,0,  4,false)
    self:Animate("stopkran",   self:GetPackedBool("EmergencyBrakeValve") and 0 or 1,     0.25,0, 128,  3,false)

    self:Animate("brake334",self:GetPackedRatio("CranePosition")/5,0.35,0.65,256,24)
    self:Animate("brake013",        Cpos[self:GetPackedRatio("CranePosition")] or 0, 0.03, 0.458,  256,24)

    self:Animate("UAVALever",   self:GetPackedBool("UAVA") and 1 or 0,     0,0.6, 128,  3,false)

    self:Animate("brake_line",self:GetPackedRatio("BLPressure"),0.143,0.88,256,2)--,0.01)
    self:Animate("train_line",self:GetPackedRatio("TLPressure"),0.143,0.88,256,0)--,0.01)
    self:Animate("brake_cylinder",self:GetPackedRatio("BCPressure"),0.134,0.874,256,2)--,0.03)

    self:Animate("voltmeter",self:GetPackedRatio("EnginesVoltage"),0.396,0.658,nil,nil)--,256,2,0.01)
    self:Animate("ampermeter",self:GetPackedRatio("EnginesCurrent"),0.39,0.655,nil,nil,256,2,0.01)
    self:Animate("voltmeter2",self:GetPackedRatio("EnginesVoltage"),0.398-0.002,0.648+0.002,nil,nil)--,256,2,0.01)
    self:Animate("ampermeter2",self:GetPackedRatio("EnginesCurrent"),0.398-0.009,0.648+0.008,nil,nil,256,2,0.01)
    self:Animate("volt1",self:GetPackedRatio("BatteryVoltage"),0.625,0.376,256,0.2,false)
    --self:Animate("voltmeter",0.5 or self:GetPackedRatio("EnginesVoltage"),0.396,0.658,nil,nil)--,256,2,0.01)
    --self:Animate("ampermeter",0.5 or self:GetPackedRatio("EnginesCurrent"),0.39,0.655,nil,nil,256,2,0.01)
    self:Animate("stopkran",   self:GetPackedBool("EmergencyBrakeValve") and 0 or 1,     0.25,0, 128,  3,false)

    self:ShowHide("SSpeed1",self:GetPackedBool("LUDS"))
    self:ShowHide("SSpeed2",self:GetPackedBool("LUDS"))
    self:ShowHide("SpeedFact1",self:GetPackedBool("LUDS"))
    self:ShowHide("SpeedFact2",self:GetPackedBool("LUDS"))
    if self:GetPackedBool("LUDS") then
        local speed = self:GetNW2Int("ALSSpeed")
        if IsValid(self.ClientEnts["SSpeed1"])then self.ClientEnts["SSpeed1"]:SetSkin(math.floor(speed)%10) end
        if IsValid(self.ClientEnts["SSpeed2"])then self.ClientEnts["SSpeed2"]:SetSkin(math.floor(speed*0.1)%10) end
        for i=1,2 do
            if IsValid(self.ClientEnts["SpeedFact"..i]) then self.ClientEnts["SpeedFact"..i]:SetSkin(math.ceil(math.Clamp((speed-4)/5-(i-1)*10,0,10))) end
        end
    end


    local otsek1 = self:Animate("door_otsek1",self:GetPackedBool("OtsekDoor1") and 1 or 0,0,0.25,4,0.5)
    local otsek2 = self:Animate("door_otsek2",self:GetPackedBool("OtsekDoor2") and 1 or 0,0,0.25,4,0.5)
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
    self:SetLightPower(3,self.Otsek1 and self:GetPackedBool("EqLights"))
    self:SetLightPower(4,self.Otsek2 and self:GetPackedBool("EqLights"))

    local activeLights = 0
    for i = 1,12 do
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
            self:SetLightPower(i, activeLights > 0,activeLights/12)
        end
    end

    if self.KVR ~= self:GetNW2Bool("KVR") or self.Type ~= self:GetNW2Int("AVType",1) then
        self.KVR = self:GetNW2Bool("KVR")
        self.Type = self:GetNW2Int("AVType",1)
        self.RingTypePA = nil
        self.RingType = nil
        self:ShowHide("cabine_old",not self.KVR)
        self:HidePanel("HVMeters_O",self.KVR)
        self:HidePanel("HVMeters_N",not self.KVR)
        self:ShowHide("Controller_panel_old",not self.KVR)
        self:ShowHide("voltmeter",not self.KVR)
        self:ShowHide("ampermeter",not self.KVR)
        self:HidePanel("HelperPanel_C",self.KVR)
        self:HidePanel("Battery_C",self.KVR)
        self:HidePanel("Block5_6_old",self.KVR or self.Type==4)
        self:HidePanel("Block5_6_old_paksd",self.KVR or self.Type~=4)
        self:HidePanel("Block7_old",self.KVR)
        self:HidePanel("AV_C",self.KVR)
        self:HidePanel("VRD_C",self.KVR)
        self:HidePanel("SOSD_C",self.KVR)
        self:ShowHide("Controller_panel_new",self.KVR)
        self:ShowHide("cabine_new",self.KVR)
        self:ShowHide("voltmeter2",self.KVR)
        self:ShowHide("ampermeter2",self.KVR)
        self:HidePanel("HelperPanel_R",not self.KVR)
        self:HidePanel("Battery_R",not self.KVR)
        self:HidePanel("Block5_6_kvr",not self.KVR)
        self:HidePanel("Block7_kvr",not self.KVR)
        self:HidePanel("AV_R",not self.KVR)
        self:HidePanel("AV_S",not self.KVR)
        --self:HidePanel("BUD_R",not self.KVR)
        self:HidePanel("SOSD_R",not self.KVR)
        self:ShowHide("handrails_old",not self.KVR)
        self:ShowHide("handrails_new",self.KVR)

        self:ShowHide("ARS13Set",not self.KVR)
        self:ShowHide("Radio13Set",not self.KVR)
        self:ShowHide("Controller_puav",self.Type == 2)
        self:ShowHide("pam",self.Type~=2)
        self:HidePanel("PUAVO",self.Type~=1)
        self:HidePanel("PUAVOScreen",self.Type~=1)
        self:HidePanel("PUAVN",self.Type~=2)
        self:HidePanel("PUAVNLights",self.Type~=2)
        self:HidePanel("PUAVNScreen",self.Type~=2)
        self:HidePanel("PAMScreen",self.Type==2)
        self:HidePanel("PAM",self.Type==2)
        self:HidePanel("PAM1",self.Type==2)
        self:ShowHide("1P:RC1Toggle",self.Type==4)
        self:ShowHide("1P:RC1Toggle_pl",self.Type==4)
        self:ShowHide("1:RC2Toggle",self.Type~=4)
        self:ShowHide("1:RC2Toggle_pl",self.Type~=4)
        self:ShowHide("1:RC1Toggle",self.Type~=4)
        self:ShowHide("1:RC1Toggle_pl",self.Type~=4)
        self:ShowHide("1:VAUToggle",self.Type~=4)
        self:ShowHide("1:VRDToggle",self.Type~=4)
        self:ShowHide("2P:RC1Toggle",self.Type==4)
        self:ShowHide("2P:RC1Toggle_pl",self.Type==4)
        self:ShowHide("2:RC2Toggle",self.Type~=4)
        self:ShowHide("2:RC2Toggle_pl",self.Type~=4)
        self:ShowHide("2:RC1Toggle",self.Type~=4)
        self:ShowHide("2:RC1Toggle_pl",self.Type~=4)
        self:ShowHide("2:VAUToggle",self.Type~=4)
        self:ShowHide("2:VRDToggle",self.Type~=4)
        self:ShowHide("Controller_puav1",self.Type == 1)
        self:ShowHide("2:ARSToggle",self.Type~=4)
        self:ShowHide("2:ALSToggle",self.Type~=4)
        self:ShowHide("!VPA2",self.Type==4)
        self:ShowHide("!VPA2_label1",self.Type==4)
        self:ShowHide("2:VPAOnSet",self.Type==4)
        self:ShowHide("2:VPAOffSet",self.Type==4)
        self:ShowHide("1:A55Toggle_label1",self.Type==2)
        self:ShowHide("1:A58Toggle_label1",self.Type==2)
        self:ShowHide("1:A59Toggle_label1",self.Type==2)
        self:ShowHide("1:A61Toggle_label1",self.Type==2)
        self:ShowHide("1:P:A59Toggle_label1",self.Type~=2)
        self:ShowHide("1:A58Toggle",self.Type==2)
        self:ShowHide("1:A59Toggle",self.Type==2)
        self:ShowHide("1:A61Toggle",self.Type==2)
        self:ShowHide("1:P:A58Toggle",self.Type~=2)
        self:ShowHide("1:P:A59Toggle",self.Type~=2)
        self:ShowHide("1:P:A61Toggle",self.Type~=2)
        self:ShowHide("A58Toggle",self.Type==2)
        self:ShowHide("A59Toggle",self.Type==2)
        self:ShowHide("A61Toggle",self.Type==2)
        self:ShowHide("P:A58Toggle",self.Type~=2)
        self:ShowHide("P:A59Toggle",self.Type~=2)
        self:ShowHide("P:A61Toggle",self.Type~=2)
        self:ShowHideSmooth("Lamps2_cab2",0)
        self:ShowHideSmooth("Lamps2_cab1",0)
        self:ShowHideSmooth("Lamps_cab2",0)
        self:ShowHideSmooth("Lamps_cab1",0)
        self:ShowHideSmooth("Lamp_RTM",0)
        self:SetLightPower("Lamp_RTM",false,0)
        self:SetLightPower("Lamps_cab1",false,0)
        self:SetLightPower("Lamps_cab2",false,0)
        self:SetLightPower("Lamps2_cab1",false,0)
        self:SetLightPower("Lamps2_cab2",false,0)
        self:ShowHide("VAVToggle_label1",self.Type == 2 and self:GetNW2Bool("SBPP"))

        self:SetLightPower(44,false)
        self:SetLightPower(45,false)
        self:SetLightPower(46,false)
        self:SetLightPower(47,false)
        self:SetLightPower(54,false)
        self:SetLightPower(55,false)
        self:SetLightPower(56,false)
        self:SetLightPower(57,false)
    end

    if self.USS ~= self:GetNW2Bool("NewUSS") then
        self:ShowHide("uss_lamps1",not self:GetNW2Bool("NewUSS"))
        self:HidePanel("USS1",self:GetNW2Bool("NewUSS"))
        self:ShowHide("uss_lamps2",self:GetNW2Bool("NewUSS"))
        self:ShowHide("!NMPressureLow2",self:GetNW2Bool("NewUSS"))
        self:ShowHide("!UAVATriggered2",self:GetNW2Bool("NewUSS"))
        self:ShowHide("!NMPressureLow2_lamp",self:GetNW2Bool("NewUSS"))
        self:ShowHide("!UAVATriggered2_lamp",self:GetNW2Bool("NewUSS"))
        self.USS = self:GetNW2Bool("NewUSS")
    end

    local lamps_cab2 = self:Animate("lamps_cab2",self:GetPackedBool("EqLights") and 1 or 0,0,1,5,false)
    local lamps_cab1 = self:Animate("lamps_cab1",self:GetPackedBool("CabLights") and 1 or 0,0,1,5,false)
    local lamps_rtm = self:Animate("lamps_rtm",self:GetPackedBool("VPR") and 1 or 0,0,1,8,false)
    local cabStrength = (lamps_cab1*0.3+lamps_cab2*0.7)^1.5
    self:SetLightPower(10,cabStrength > 0, cabStrength)
    if self.KVR then
        self:ShowHideSmooth("Lamps_cab2",lamps_cab2)
        self:ShowHideSmooth("Lamps_cab1",lamps_cab1)
        self:SetLightPower("Lamps_cab1", lamps_cab1 > 0,lamps_cab1)
        self:SetLightPower("Lamps_cab2", lamps_cab2 > 0,lamps_cab2)
        self:SetLightPower(46,not WhitePLights and self:GetPackedBool("PanelLights"))
        self:SetLightPower(47,not WhitePLights and self:GetPackedBool("PanelLights"))
        self:SetLightPower(56,WhitePLights and self:GetPackedBool("PanelLights"))
        self:SetLightPower(57,WhitePLights and self:GetPackedBool("PanelLights"))
    else
        self:ShowHideSmooth("Lamps2_cab2",lamps_cab2)
        self:ShowHideSmooth("Lamps2_cab1",lamps_cab1)
        self:SetLightPower("Lamps2_cab1", lamps_cab1 > 0,lamps_cab1)
        self:SetLightPower("Lamps2_cab2", lamps_cab2 > 0,lamps_cab2)
        self:ShowHideSmooth("Lamp_RTM",lamps_rtm)
        self:SetLightPower("Lamp_RTM",lamps_rtm > 0,lamps_rtm)
        self:SetLightPower(44,not WhitePLights and self:GetPackedBool("PanelLights"))
        self:SetLightPower(45,not WhitePLights and self:GetPackedBool("PanelLights"))
        self:SetLightPower(54,WhitePLights and self:GetPackedBool("PanelLights"))
        self:SetLightPower(55,WhitePLights and self:GetPackedBool("PanelLights"))
    end
    self:SetSoundState("vpr",lamps_rtm>0 and 1 or 0,1)

    self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,1, 3, false)
    self:Animate("FrontTrain",  self:GetNW2Bool("FtI") and 1 or 0,0,1, 3, false)
    self:Animate("RearBrake",   self:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    self:Animate("RearTrain",   self:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)

    local c013 = self:GetNW2Int("Crane",0)==1
    self:ShowHide("brake_valve_334",not c013)
    self:ShowHide("brake334",not c013)
    self:ShowHide("brake_disconnect",not c013)
    self:ShowHide("train_disconnect",not c013)
    self:HidePanel("DriverValveBLDisconnect",c013)
    self:HidePanel("DriverValveTLDisconnect",c013)
    self:HidePanel("EPKDisconnect",c013)
    self:ShowHide("EPK_disconnect",not c013)
    self:ShowHide("brake_valve_013",c013)
    self:ShowHide("brake013",c013)
    self:ShowHide("valve_disconnect",c013)
    self:ShowHide("EPV_disconnect",c013)
    self:HidePanel("EPVDisconnect",not c013)
    self:HidePanel("DriverValveDisconnect",not c013)
    --[[ -- Animate AV switches
    for i in ipairs(self.Panel.AVMap) do
        local value = self:GetPackedBool(64+(i-1)) and 1 or 0
        self:Animate("a"..(i-1),value,0,1,8,false)
        self:Animate("1_a"..(i-1),value,0,1,8,false)
    end--]]
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
            self:Animate(n_l,state,0,0.95,dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
            --self:Animate(n_r,state,0,1,dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
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

    --local rolm = math.Clamp(speed/30,0,1)*(1-math.Clamp((speed-35)/40,0,1))
    --local rolh = math.Clamp((speed-35)/40,0,1.5)+math.Clamp((speed-65)/15,0,1)
    --self:SetSoundState("rolling_medium",rollingi*rolm,Lerp((speed-8)/106,0.6,1)) --57
    --self:SetSoundState("rolling_high"  ,rollingi*rolh,rol70p) --70

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
    if c013 then
        if ramp > 0 then
            self.CraneRamp = self.CraneRamp + ((0.2*ramp)-self.CraneRamp)*dT
        else
            self.CraneRamp = self.CraneRamp + ((0.9*ramp)-self.CraneRamp)*dT
        end
        self.CraneRRamp = math.Clamp(self.CraneRRamp + 1.0*((1*ramp)-self.CraneRRamp)*dT,0,1)
        self:SetSoundState("crane334_brake",0,1.0)
        self:SetSoundState("crane334_brake_reflection",0,1.0)
        self:SetSoundState("crane334_brake_slow",0,1.0)
        self:SetSoundState("crane334_release",0,1.0)
        self:SetSoundState("crane013_release",self.CraneRRamp^1.5,1.0)
        self:SetSoundState("crane013_brake",math.Clamp(-self.CraneRamp*1.5,0,1)^1.3,1.0)
        self:SetSoundState("crane013_brake2",math.Clamp(-self.CraneRamp*1.5-0.95,0,1.5)^2,1.0)
    else
        self:SetSoundState("crane013_brake",0,1.0)
        self:SetSoundState("crane013_release",0,1.0)
        --self:SetSoundState("crane013_release",0,1.0)

        self.CraneRamp = math.Clamp(self.CraneRamp + 8.0*((1*self:GetPackedRatio("Crane_dPdT",0))-self.CraneRamp)*dT,-1,1)

        self:SetSoundState("crane334_brake_low",math.Clamp((-self.CraneRamp)*2,0,1)^2,1)
        local high = math.Clamp(((-self.CraneRamp)-0.5)/0.5,0,1)^1
        self:SetSoundState("crane334_brake_high",high,1.0)
        self:SetSoundState("crane013_brake2",high*2,1.0)
        self:SetSoundState("crane334_brake_eq_high",--[[ math.Clamp(-self.CraneRamp*0,0,1)---]] math.Clamp(-self:GetPackedRatio("ReservoirPressure_dPdT")-0.2,0,1)^0.8*1,1)
        self:SetSoundState("crane334_brake_eq_low",--[[ math.Clamp(-self.CraneRamp*0,0,1)---]] math.Clamp(-self:GetPackedRatio("ReservoirPressure_dPdT")-0.4,0,1)^0.8*1.3,1)

        self:SetSoundState("crane334_release",math.Clamp(self.CraneRamp,0,1)^2,1.0)
    end
    local emergencyValveEPK = self:GetPackedRatio("EmergencyValveEPK_dPdT",0)
    self.EmergencyValveEPKRamp = math.Clamp(self.EmergencyValveEPKRamp + 1.0*((0.5*emergencyValveEPK)-self.EmergencyValveEPKRamp)*dT,0,1)
    self:SetSoundState("epk_brake",self.EmergencyValveEPKRamp,1.0)
    --[[ if emergencyValveEPK > 0 and not self.EmergencyValveEPKStart then
        self:PlayOnce("epk_brake_start","bass",1,1)
        self.EmergencyValveEPKStart = true
    end--]]
    if emergencyValveEPK <= 0 and self.EmergencyValveEPKStart then
        self.EmergencyValveEPKStart = false
    end

    local emergencyBrakeValve = self:GetPackedRatio("EmergencyBrakeValve_dPdT", 0)
    self.EmergencyBrakeValveRamp = math.Clamp(self.EmergencyBrakeValveRamp + (emergencyBrakeValve-self.EmergencyBrakeValveRamp)*dT*8,0,1)
    self:SetSoundState("valve_brake",self.EmergencyBrakeValveRamp,0.8+math.min(0.4,self.EmergencyBrakeValveRamp*0.8))

    local emergencyValve = self:GetPackedRatio("EmergencyValve_dPdT", 0)^0.4*1.2
    self.EmergencyValveRamp = math.Clamp(self.EmergencyValveRamp + (emergencyValve-self.EmergencyValveRamp)*dT*16,0,1)
    local emer_brake = math.Clamp((self.EmergencyValveRamp-0.9)/0.05,0,1)
    local emer_brake2 = math.Clamp((self.EmergencyValveRamp-0.2)/0.4,0,1)*(1-math.Clamp((self.EmergencyValveRamp-0.9)/0.1,0,1))
    self:SetSoundState("emer_brake",emer_brake,1)
    self:SetSoundState("emer_brake2",emer_brake2,math.min(1,0.8+0.2*emer_brake2))
    -- Compressor
    self:SetSoundState("compressor",self:GetPackedBool("Compressor") and 0.6 or 0,1)
    self:SetSoundState("compressor2",self:GetPackedBool("Compressor") and 0.8 or 0,1)

    local vCstate = self:GetPackedRatio("M8")/2
    if self.VentCab < vCstate then
        self.VentCab = math.min(1,self.VentCab + dT/2.7)
    elseif self.VentCab > vCstate then
        self.VentCab = math.max(0,self.VentCab - dT/2.7)
    end
    self:SetSoundState("vent_cabl",math.Clamp(self.VentCab*2,0,1) ,1)
    self:SetSoundState("vent_cabh",math.Clamp((self.VentCab-0.5)*2,0,1),1)

    if self.RingType ~= self:GetNW2Int("RingType",1) then
        self.RingType = self:GetNW2Int("RingType",1)
        self:SetSoundState(self.RingName,0,0)

        self.RingName = "ring3"
        self.RingPitch = 1
        if self.RingType == 2 then
            self.RingName = "ring2"
        elseif self.RingType==3 then
            self.RingPitch = 0.8
        elseif self.RingType==4 then
            self.RingName = "ring"
        end
    end
    if self.RingTypePA ~= self:GetNW2Int("RingTypePA",1) then
        self.RingTypePA = self:GetNW2Int("RingTypePA",1)
        self:SetSoundState(self.PARingName,0,0)

        self.RingPitchPA = 1
        if self.Type==2 then
            self.PARingName = "pu_ring2"
            if self.RingTypePA == 2 then
                self.PARingName = "pu_ring"
            elseif self.RingTypePA==3 then
                self.RingPitchPA = 0.8
            end
        else
            self.PARingName = "pa_ring"
            if self.RingTypePA == 2 then
                self.RingPitchPA = 0.8
            elseif self.RingTypePA == 3 then
                self.PARingName = "pa_ring2"
            end
        end
    end
    -- ARS/ringer alert
    self:SetSoundState(self.RingName,self:GetPackedBool("Buzzer") and 0.6 or 0,self.RingPitch)
    if self:GetPackedBool("PURingZ") and not self.PUZeroTimer  then self.PUZeroTimer = RealTime() end
    if not self:GetPackedBool("PURingZ") and self.PUZeroTimer  then self.PUZeroTimer = nil end
    local pTime = self.PUZeroTimer and RealTime()-self.PUZeroTimer
    self:SetSoundState(self.PARingName,(self.Type~=2 and self:GetPackedBool("PURing") or self.Type==2 and (self:GetPackedBool("PURing") or pTime and (pTime < 3 or pTime%1 > 0.5) and pTime<=7))  and 0.6 or 0,self.RingPitchPA)--0.79

    if self:GetPackedBool("RK") then self.RKTimer = CurTime() end
    self:SetSoundState("rk",(self.RKTimer and (CurTime() - self.RKTimer) < 0.2) and 0.7 or 0,1)

    self.BPSNType = self:GetNW2Int("BPSNType",5)
    if not self.OldBPSNType then self.OldBPSNType = self.BPSNType end
    if self.BPSNType ~= self.OldBPSNType then
        for i=1,4 do
            self:SetSoundState("bpsn"..i,0,1.0)
        end
    end
    self.OldBPSNType = self.BPSNType
    if self.BPSNType<5 then
        self:SetSoundState("bpsn"..self.BPSNType,self:GetPackedBool("BPSN") and 1 or 0,1) --FIXME громкость по другому
    end

    local cabspeaker = self:GetPackedBool("AnnCab")
    local work = self:GetPackedBool("AnnPlay")
    local buzz = self:GetPackedBool("AnnBuzz") and self:GetNW2Int("AnnouncerBuzz")
    local noise = self:GetNW2Int("AnnouncerNoise", -1)
    local volume = self:GetNW2Float("UPOVolume",1)
    local noisevolume = self:GetNW2Float("UPONoiseVolume",1)

    local buzzvolume = volume
    if self.Sounds["announcer2"] and IsValid(self.Sounds["announcer2"]) then buzzvolume = (1-(self.Sounds["announcer2"]:GetLevel())*math.Rand(0.9,3))*buzzvolume end
    if self.BPSNBuzzVolume > buzzvolume then
        self.BPSNBuzzVolume = math.Clamp(self.BPSNBuzzVolume + 8*(buzzvolume-self.BPSNBuzzVolume)*dT,0.1,1)
    else
        self.BPSNBuzzVolume = math.Clamp(self.BPSNBuzzVolume + 0.4*(buzzvolume-self.BPSNBuzzVolume)*dT,0.1,1)
    end

    for k,v in ipairs(self.AnnouncerPositions) do
        local play = k==1 and cabspeaker or k~=1 and work
        self:SetSoundState("announcer_noiseW"..k,play and noisevolume*volume or 0,1)
        for i=1,3 do
            self:SetSoundState(Format("announcer_noise%d_%d",i,k),(play and i==noise) and volume*self.BPSNBuzzVolume*self:GetNW2Float("UPOBuzzVolume",1) or 0,1)
        end
        for i=1,2 do
            self:SetSoundState(Format("announcer_buzz%d_%d",i,k),(play and i==buzz) and volume*self.BPSNBuzzVolume*self:GetNW2Float("UPOBuzzVolume",1) or 0,1)
        end
        if IsValid(self.Sounds["announcer"..k]) then self.Sounds["announcer"..k]:SetVolume((k ~= 1 and work or k==1 and cabspeaker) and  v[3]*volume or 0) end
    end
end

function ENT:OnAnnouncer(volume,id)
    local cabspeaker = self:GetPackedBool("AnnCab")
    local work = self:GetPackedBool("AnnPlay")
    return (id ~= 1 and work or id == 1 and cabspeaker) and self:GetNW2Float("UPOVolume",1)*volume  or 0
end

function ENT:Draw()
    self.BaseClass.Draw(self)
end
function ENT:DrawPost()

    self.RTMaterial:SetTexture("$basetexture",self.PUAV)
    self:DrawOnPanel("PUAVOScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(256,64,512,128,0)
    end)
    self:DrawOnPanel("PUAVNScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(256,64,512,128,0)
    end)
    self.RTMaterial:SetTexture("$basetexture",self.PAM)
    self:DrawOnPanel("PAMScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,256,1024,512,0)
    end)
    self:DrawOnPanel("AirDistributor",function()
        draw.DrawText(self:GetNW2Bool("AD") and "Air Distributor ON" or "Air Distributor OFF","Trebuchet24",0,0,Color(0,0,0,255))
    end)
end

function ENT:OnButtonPressed(button)
    if button == "ShowHelp" then
        RunConsoleCommand("metrostroi_train_manual")
    end
end

function ENT:OnPlay(soundid,location,range,pitch)
    if location == "stop" then
        if IsValid(self.Sounds[soundid]) then
            self.Sounds[soundid]:Pause()
            self.Sounds[soundid]:SetTime(0)
        end
        return
    end
    if soundid == "pkg" then return end
    if location == "bass" then
        if soundid == "VDOL" then
            return range > 0 and "vdol_on" or "vdol_off",location,1,pitch
        end
        if soundid == "VDOP" then
            return range > 0 and "vdor_on" or "vdor_off",location,1,pitch
        end
        if soundid == "VDZ" then
            return range > 0 and "vdz_on" or "vdz_off",location,1,pitch
        end
        if soundid:sub(1,4) == "IGLA" then
            return range > 0 and "igla_on" or "igla_off",location,1,pitch
        end
        if soundid == "lk2c" then
            local speed = self:GetPackedRatio("Speed")
            self.SoundPositions[soundid][1] = 350-Lerp(speed/0.1,0,250)
            return soundid,location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "LK2" then
            local speed = self:GetPackedRatio("Speed")
            if range == 0 and speed < 20 and self:GetPackedRatio("EnginesCurrent") > 0.55 then
                self:PlayOnce("lk2c","bass",1,pitch)
            end
            local id = range > 0 and "lk2_on" or "lk2_off"
            self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
            return id,location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "LK3" then
            local speed = self:GetPackedRatio("Speed")
            local id = range > 0 and "lk3_on" or "lk3_off"
            self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
            return id,location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "LK5" and range > 0 then
            local speed = self:GetPackedRatio("Speed")
            self.SoundPositions["lk5_on"][1] = 350-Lerp(speed/0.1,0,250)
            return "lk5_on",location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "brake" then
            self:PlayOnce("brake_f",location,range,pitch)
            self:PlayOnce("brake_b",location,range,pitch)
            return
        end
        if soundid == "RVT" then
            return range > 0 and "rvt_on" or "rvt_off",location,1,pitch
        end
        if soundid == "K6" then
            return range > 0 and "k6_on" or  "k6_off",location,1,pitch
        end
        if soundid == "R1_5" then
            return range > 0 and "r1_5_on" or "r1_5_off",location,1,pitch
        end
        if soundid == "RPB" then
            return range > 0 and "rpb_on" or "rpb_off",location,1,pitch
        end
        if soundid == "KD" then
            return range > 0 and "kd_on" or "kd_off",location,1,pitch
        end
        if soundid == "KK" then
            return range > 0 and "kk_on" or "kk_on",location,1,0.6+range*0.1
        end
        if soundid == "K25" then
            return range > 0 and "k25_on" or "k25_off",location,1,pitch
        end
        if soundid == "RO" then
            return range > 0 and "ro_on" or "ro_off",location,1,pitch
        end
        if soundid == "Rp8" then
            return range > 0 and "rp8_on" or "rp8_off",location,1,pitch
        end
        if soundid == "ROT" then
            return range > 0 and "rot_on" or "rot_off",location,1,pitch
        end
        if soundid == "AVU" then
            return range > 0 and "avu_on" or "avu_off",location,1,0.9
        end
        if soundid == "UAVAC" then
            return "uava_reset",location,range,pitch
        end
    elseif soundid:sub(1,4)=="kv70" and self:GetNW2Bool("SecondKV") then return soundid.."_2",location,range,pitch end
    return soundid,location,range,pitch
end
Metrostroi.GenerateClientProps()
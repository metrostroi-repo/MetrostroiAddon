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

-- Main panel

ENT.ButtonMap["Main"] = {
    pos = Vector(451.5+6.0,-15.92,-8.9),
    ang = Angle(0,-90.8,13),
    width = 750,
    height = 240,
    scale = 0.0588,
    hideseat = 0.2,

    buttons = {
        ---Блок САММ
        { ID = "V1Toggle",   x=35, y=30, w=45,h=80, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudblack.mdl", z=-29,
            var="V1",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SAMMSchemeOffSet", x=46, y=61+15+48*2, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl", z = -1,
            var="SAMMSchemeOff",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button1_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "SAMMStartSet", x=46+44*1, y=61+15+48*2, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", z = -1,
            var="SAMMStart",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "SAMMResetSet", x=46+44*2, y=61+15+48*2, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", z = -1,
            var="SAMMReset",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "SAMMXTLamp", x=46+29*3, y=61+15+48*1, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl", skin = 2, z = -0,
            --lamp = {model = "models/metrostroi_train/81/lamp_on.mdl",z = -1.7, var=""}
        }},
        {ID = "SAMMSignal1", x=58+29*3, y=32, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl", skin = 4, z = -0,
            --lamp = {model = "models/metrostroi_train/81/lamp_on.mdl",z = -1.7, var=""--[[ , var="SAMMOn"--]] }
        }},
        {ID = "SAMMSignal2", x=54+29*2, y=32, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl", skin = 4, z = -0,
            --lamp = {model = "models/metrostroi_train/81/lamp_on.mdl",z = -1.7, var=""--[[ , var="SAMMBlok"--]] }
        }},
        {ID = "SAMMOnToggle", x=58+29*3, y=69, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=1,
            var="SAMMOn",speed=16,
            sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SAMMUnitToggle", x=54+29*2, y=69, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=1,
            var="SAMMUnit",speed=16,
            sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SAMMX2Toggle", x=46+29*2, y=61+15+48*1, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=1,
            var="SAMMX2",speed=16,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SAMMAheadToggle", x=46+29*1, y=61+15+48*1, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=1,
            var="SAMMAhead",speed=16,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "SAMMAcceptToggle", x=46, y=61+15+48*1, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=1,
            var="SAMMAccept",speed=16,
            sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        ---Блок Основной
        {ID = "KU8Set",         x=227, y=61, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl", z = -1,
            var="KU8",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_Program1Set",          x=227, y=61+48*1, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", z = -1,
            var="R_Program1",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_Program2Set",          x=227, y=61+48*2, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", z = -1,
            var="R_Program2",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VU14Toggle",   x=258, y=61+4, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=-2,
            var="VU14",speed=16,
            sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.LNear","Train.Buttons.LFar"},
        }},
        {ID = "GLightsToggle",   x=258, y=61+4+48*1, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=-2,
            var="GLights",speed=16,
            sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "VAHToggle",   x=258, y=61+4+48*2, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=-2,
            var="VAH",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=24,z=-2,var="VAHPl", ID="VAHPl",},
            sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "V4Set",           x=292, y=61+3+48*1, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", z = -1,
            var="V4",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "V5Set",          x=341, y=61+3+48*1, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", z = -1,
            var="V5",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KU11Set",         x=292, y=61+6.5+48*2, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl", z = -1,
            var="KU11",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KVTSet",         x=341, y=61+6.5+48*2, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", z = -1,
            var="KVT",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KBSet",          x=340, y=61+1, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", z = -1,
            var="KB",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button3_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "!LKVT",         x=292, y=61+1, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_kblamp.mdl", skin = 2, z = 5,-- color = Color(60,255,255),
            lamp = {model = "models/metrostroi_train/81-710/ezh3_kblamp2.mdl",z = 5-4,color = Color(255,150,150), var="LKVT",
            lcolor=Color(255,50,20),lz = 20,lbright=2,lfov=130,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.4,size=0.25,scale=0.07,color=Color(255,50,20),z=6}
        }},
        {ID = "ARSToggle",   x=374, y=61+4, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=-2,
            var="ARS",speed=16,
            sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_UNchToggle",    x=374, y=61+4+48, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=-2,
            var="R_UNch",speed=16,
            sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "V2Toggle",     x=493, y=55, w=45,h=80, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudblack.mdl", z=-30,
            var="V2",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Unlocked","Train.Buttons.Locked"},
        }},
        {ID = "R_RadioToggle",   x=374, y=160, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",ang = 180,z=-2,
            var="R_Radio",speed=16,
            sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "ALSToggle",   x=374+40, y=61+2, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=-2,
            var="ALS",speed=16,
            sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "KU9Set",            x=374+43, y=58+47*1, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", z = -1,
            var="KU9",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "RingSet",         x=374+40, y=61+1+47*2, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", z = -1,
            var="Ring",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "PLightsToggle",   x=372+40*2, y=61+7, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=-2,
            var="PLights",speed=16,
            sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "V10Set", x=374+40*2, y=61+4+48, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",ang = 180,z=-2,
            var="V10",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button1_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KU7Set",  x=374+40*2+12+45, y=61+4+48*2, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",ang = 180,z=-2,
            var="KU7",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button1_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KU12Set",  x=374+40*2+12, y=61+4+48*2, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",ang = 180,z=-2,
            var="KU12",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button3_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},

        ---Блок Резервный
        {ID = "Custom4Set",  x=610, y=61+4+48*2, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",ang = 180,z=-2,
            var="Custom4",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KU15Set",    x=610+48*2, y=61+4+48*2, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",ang = 180,z=-2,
            var="KU15",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button1_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KU10Set",  x=610+48*1, y=61+4+48*2, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",ang = 180,z=-2,
            var="KU10",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button3_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "RSTToggle",   x=693+30, y=61+2+48, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=-2,
            var="RST",speed=16,
            sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_GToggle",   x=693, y=61+2+48, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=-2,
            var="R_G",speed=16,
            sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "Custom1Toggle",   x=600, y=80, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=-2,
            var="Custom1",speed=16,
            sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "Custom2Toggle",  x=600+25, y=80, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=-2,
            var="Custom2",speed=16,
            sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "Custom3Toggle",  x=600+50, y=80, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=-2,
            var="Custom3",speed=16,
            sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "!AnnPlay", x=693-25, y=61+2+48, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl", z = -4.1,
            --lamp = {model = "models/metrostroi_train/81/lamp_on.mdl",skin = 2, var="AnnPlay"}
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=75,x=-0.3,y=-0.3,z=22,color=Color(255,130,90),var="AnnPlay",getfunc=function(ent) return (ent.AnnLamp or 0)^1.5*2 end},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(255,130,90)},
        }},
    }
}

ENT.ButtonMap["Panel"] = {
    pos = Vector(451.5+9.3,-16.5,-3),
    ang = Angle(0,-93.7,62),
    width = 750,
    height = 110,
    scale = 0.0588,
    buttons = {
    --ARS
    {ID = "!L0", x=272,y=12,tooltip="",w=22, h=13, model = {
        sprite = {bright=0.20,size=0.25,scale=0.05,vscale=0.04,color=Color(255, 180, 25),y=-1,z=-3,lamp="light_0",hidden="ezh3_l0"}
    }},
    {ID = "!L04", x=309,y=12,tooltip="",w=22, h=13, model = {
        sprite = {bright=0.20,size=0.25,scale=0.05,vscale=0.04,color=Color(255, 180, 25),y=-1,z=-3,lamp="light_OCh",hidden="ezh3_loch"}
    }},
    {ID = "!L40", x=272,y=50,tooltip="",w=22, h=13, model = {
        sprite = {bright=0.20,size=0.25,scale=0.05,vscale=0.04,color=Color(255, 251, 148),y=-2,z=-3,lamp="light_40",hidden="ezh3_l40"}
    }},
    {ID = "!L60", x=309,y=50,tooltip="",w=22, h=13, model = {
        sprite = {bright=0.20,size=0.25,scale=0.05,vscale=0.04,color=Color(116, 212, 163),y=-2,z=-3,lamp="light_60",hidden="ezh3_l60"}
    }},
    {ID = "!L70", x=272,y=85,tooltip="",w=22, h=13, model = {
        sprite = {bright=0.20,size=0.25,scale=0.05,vscale=0.04,color=Color(116, 212, 163),y=0,z=-3,lamp="light_70",hidden="ezh3_l70"}
    }},
    {ID = "!L80", x=309,y=85,tooltip="",w=22, h=13, model = {
        sprite = {bright=0.20,size=0.25,scale=0.05,vscale=0.04,color=Color(104, 190, 146),y=0,z=-3,lamp="light_80",hidden="ezh3_l80"}
    }},

    {ID = "!LKT", x=272+189,y=17,tooltip="",w=22, h=13, model = {
        sprite = {bright=0.20,size=0.25,scale=0.05,vscale=0.04,color=Color(255, 200, 25),y=-1,z=-3,lamp="light_KT",hidden="ezh3_lkt"}
    }},
    {ID = "!LSN", x=309+189,y=17,tooltip="",w=22, h=13, model = {
        sprite = {bright=0.20,size=0.25,scale=0.05,vscale=0.04,color=Color(255, 180, 25),y=-1,z=-3,lamp="light_rRP",hidden="ezh3_lrp"}
    }},
    {ID = "!LKVD", x=272+189,y=50,tooltip="",w=22, h=13, model = {
        sprite = {bright=0.20,size=0.25,scale=0.05,vscale=0.04,color=Color(255, 251, 148),y=0,z=-3,lamp="light_KVD",hidden="ezh3_lkvd"}
    }},
    {ID = "!LRP", x=309+189,y=50,tooltip="",w=22, h=13, model = {
        sprite = {bright=0.20,size=0.25,scale=0.05,vscale=0.04,color=Color(76, 167, 121),y=0,z=-3,lamp="Green_rp",hidden="ezh3_lrpgreen"}
    }},
    {ID = "!LPU", x=272+189,y=83,tooltip="",w=22, h=13--[[, model = {
        sprite = {bright=0 or 0.15,size=0.25,scale=0.06,vscale=0.04,color=Color(255,20,40),y=-4,z=-3,lamp="LPU",hidden="ezh3_lpu"}
    }]]},
    {ID = "!LSD", x=309+189,y=83,tooltip="",w=22, h=13, model = {
        sprite = {bright=0.20,size=0.25,scale=0.05,vscale=0.04,color=Color(136, 159, 211),y=0,z=-3,lamp="light_SD",hidden="ezh3_lsd"}
    }},

    {ID = "!BatteryVoltage", x=120-80,y=25,tooltip="",w=60, h=50,tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BatteryVoltage"),ent:GetPackedRatio("BatteryVoltage")*100) end},
    {ID = "!EnginesCurrent", x=120-8,y=25,tooltip="",w=60, h=50,tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesCurrent"),ent:GetPackedRatio("EnginesCurrent")*1000-500) end},
    {ID = "!HighVoltage", x=120+80-18,y=25,tooltip="",w=60, h=50,tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.HighVoltage"),ent:GetPackedRatio("EnginesVoltage")*1000) end},
    {ID = "!Speedometer", x=352,y=25,tooltip="",w=85, h=70,tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.Speed"),ent:GetPackedRatio("Speed")*100) end},
    {ID = "!BLTLPressure", x=588,y=65,tooltip="",radius=40,tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BLTLPressure"),ent:GetPackedRatio("TLPressure")*16,ent:GetPackedRatio("BLPressure")*16) end},
    {ID = "!BCPressure", x=688,y=65,tooltip="",radius=40,tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BCPressure"),ent:GetPackedRatio("BCPressure")*6) end},
    }
}

--[[
ENT.ButtonMap["Back2"] = {
    pos = Vector(405.5,25.9,4.0),
    ang = Angle(0,90,90),
    width = 280,
    height = 340,
    scale = 0.1088,

    buttons = {
    {ID="!HVHuse",x=0, y=12, w=280, h=130, tooltip=""},
    {ID="!AKBCharge",x=0, y=170, w=300, h=270, tooltip=""},
    {ID="!Heater",x=280, y=170, w=80, h=300, tooltip=""},
    }
}
--]]

ENT.ButtonMap["RUM"] = {
    pos = Vector(406.45,-56.75,16.7),
    ang = Angle(0,90,90),
    width = 140,
    height = 250,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "RUMToggle",   x=0, y=0, w=140, h=250, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_sammrc.mdl", ang = Angle(90,180+45,0), z=-20,y=117,
            var="RUM",speed=2, vmax=0.3, vmin=0.7,
            plomb = {var="RUMPl", ID="RUMPl",},
            sndvol = 0.5, snd = function(val) return val and "samm_0-2" or "samm_2-0" end,
            sndmin = 60, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ClientProps["rum_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ButtonMap["RUM"].pos+Vector(-1.1,4.35,-15.15),
    ang = Angle(0,270-93,180),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}

--VU Panel
ENT.ButtonMap["VU"] = {
    pos = Vector(456+11,-16.55,-4.0),
    ang = Angle(0,180,90),
    width = 120,
    height = 120,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "VUToggle", x=60, y=60, radius=60, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            var="VU",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}
ENT.ButtonMap["VUHelper"] = {
    pos = Vector(458,-14,-4.0),
    ang = Angle(0,-45,90),
    width = 80,
    height = 80,
    scale = 0.0625,

    buttons = {
        {ID = "VUToggle", x=40, y=40, radius=40, tooltip=""},
    }
}


ENT.ButtonMap["Stopkran"] = {
    pos = Vector(461.6,27,3),
    ang = Angle(0,-90,90),
    width = 200,
    height = 1300,
    scale = 0.1/2,
        buttons = {
            {ID = "EmergencyBrakeValveToggle",x=0, y=0, w=200, h=1300, tooltip="",states={"Train.Buttons.Closed","Train.Buttons.Opened"},var="EmergencyBrakeValve"},
    }
}

ENT.ButtonMap["AVMain"] = {
    pos = Vector(405.5,37.8,36),
    ang = Angle(0,90,90),
    width = 335,
    height = 270,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "AVToggle", x=0, y=0, w=300, h=380, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_av8r.mdl", z=23, ang = Angle(90,0,0),
            var="AV",speed=0.85, vmin=0.73,vmax=0.80,
            sndvol = 1, snd = function(val) return val and "av8_on" or "av8_off" end,
        }},
    }
}


ENT.ButtonMap["KRR"] = {
    pos = Vector(403,-20.5-0.5,3),
    ang = Angle(0,90,90),
    width = 20,
    height = 20,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "KRRSet",         x=10, y=10, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",
            var="KRR",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button1_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}
---AV1 Panel
ENT.ButtonMap["AV1"] = {
    pos = Vector(403.5,39,18),
    ang = Angle(0,90,90),
    width = 290+0,
    height = 155,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "VU3Toggle", x=0, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_black.mdl", z=20, ang = 180,
            var="VU3",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "VU2Toggle", x=110, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_black.mdl", z=20, ang = 180,
            var="VU2",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "VU1Toggle", x=220, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_black.mdl", z=20, ang = 180,
            var="VU1",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}

local corr = -1.5
ENT.ButtonMap["ASNP"] = {
    pos = Vector(459.491-corr,-54.762-corr-0.1,8.675),
    ang = Angle(-.4,210,90),
    width = 150,
    height = 130,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "R_ASNPMenuSet",x=72.8, y=65.3, radius=8, tooltip = "АСНП: Меню",model = {
            model = "models/metrostroi_train/81-710/asotp_pu_menu_button.mdl",
            var="R_ASNPMenu",speed=12, vmin=0, vmax=1, ang=Angle(0,90,-90), z=-1,
            sndvol = 0.5,snd = function(val) return val and "pnm_button2_on" or "pnm_button2_on" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_ASNPUpSet",x=131.8, y=23, radius=8, tooltip = "АСНП: Вверх",model = {
            model = "models/metrostroi_train/81-710/asotp_pu_triangle_button.mdl",
            var="R_ASNPUp",speed=12, vmin=0, vmax=1, ang=Angle(0,90,-90), z=-3,
            sndvol = 0.5,snd = function(val) return val and "pnm_button1_on" or "pnm_button2_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_ASNPDownSet",x=131.8, y=41, radius=8, tooltip = "АСНП: Вниз",model = {
            model = "models/metrostroi_train/81-710/asotp_pu_triangle_button.mdl",
            var="R_ASNPDown",speed=12, vmin=0, vmax=1, ang=Angle(0,90,90), z=-3,
            sndvol = 0.5,snd = function(val) return val and "pnm_button2_on" or "pnm_button1_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_ASNPPathToggle",x=9, y=29, radius=8, tooltip = "АСНП: Установка пути",model = {
            model = "models/metrostroi_train/81-710/asotp_pu_track_tumbler.mdl", ang = Angle(0,90,-90), z=-3,
            var="R_ASNPPath",speed=12, vmin=1, vmax=0,
            sndvol = 0.5,snd = function(val) return val and "pnm_on" or "pnm_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_ASNPOnToggle",x=33.5, y=91, radius=25, tooltip = "АСНП: Включение",model = {
            model = "models/metrostroi_train/81-710/asotp_pu_power_tumbler.mdl", ang=Angle(0,90,-90), z = -24.5,
            var="R_ASNPOn",speed=12, vmin=0, vmax=1,
            sndvol = 0.5,snd = function(val) return val and "pnm_on" or "pnm_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["ASNPScreen"] = {
    pos = Vector(459.48,-54.73,7.5),
    ang = Angle(0,210,90),
    width = 512,
    height = 128,
    scale = 0.025/2.52,
    hideseat = 0.2,
    hide=true,
}

ENT.ButtonMap["IGLAButtons"] = {
    pos = Vector(459.744-corr-0.8,-54.596-corr-0.8,18),
    ang = Angle(-0,210,90),
    width = 120,
    height = 80,
    scale = 0.0625,
    hideseat = 0.2,
    buttons = {
        -- {ID = "IGLA1USet",x=19, y=55.5, w=18, h=7, tooltip=""},
        {ID = "IGLA1Set",x=15.3, y=60.2, w=18, h=7, tooltip="", model = {
            model = "models/metrostroi_train/81-710/asotp_pu_rect_button.mdl", z=-3, ang=Angle(90,90,180),
            var="IGLA1",speed=12,vmin=0,vmax=1,
            sndvol = 1, snd = function(val) return val and "vu223_on" or "vu223_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        -- {ID = "IGLA1DSet",x=19, y=65.5, w=18, h=7, tooltip=""},
        -- {ID = "IGLA2USet",x=85, y=55.5, w=18, h=7, tooltip=""},
        {ID = "IGLA2Set",x=82.5, y=60.2, w=18, h=7, tooltip="", model = {
            model = "models/metrostroi_train/81-710/asotp_pu_rect_button.mdl", z=-3, ang=Angle(90,90,180),
            var="IGLA2",speed=12,vmin=0,vmax=1,
            sndvol = 1, snd = function(val) return val and "vu223_on" or "vu223_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        -- {ID = "IGLA2DSet",x=85, y=65.5, w=18, h=7, tooltip=""},
        {ID = "!IGLASR",x=24.5, y=14.5, radius=3, tooltip="", model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl", var="IGLASR",color=Color(175,250,20),z=-5},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(175,250,20),z=-5,}
        }},
        {ID = "!IGLARX",x=37, y=14.5, radius=3, tooltip="", model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl", var="IGLARX",color=Color(255,56,30),z=-5},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(255,56,30),z=-5,}
        }},
        {ID = "!IGLAErr",x=54, y=14.5, radius=3, tooltip="", model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl", var="IGLAErr",color=Color(255,168,000),z=-5},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(255,168,000),z=-5,}
        }},
        {ID = "!IGLAOSP",x=66, y=14.5, radius=3, tooltip="", model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl", var="IGLAOSP",color=Color(175,250,20),z=-5},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(175,250,20),z=-5,}
        }},
        {ID = "!IGLAPI",x=79, y=14.5, radius=3, tooltip="", model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl", var="IGLAPI",color=Color(255,56,30),z=-5},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(255,56,30),z=-5,}
        }},
        {ID = "!IGLAOff",x=91, y=14.5, radius=3, tooltip="", model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl", var="IGLAOff",color=Color(255,56,30),z=-5},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(255,56,30),z=-5,}
        }},
    }
}
ENT.ButtonMap["IGLA"] = {
    pos = Vector(459.8,-54.65,16.2),
    ang = Angle(-0,210,90),
    width = 512,
    height = 128,
    scale = 0.025/2.36,
    hideseat = 0.2,
    hide=true,
}

ENT.ClientProps["E_informator"] = {
    model = "models/metrostroi_train/equipment/rri_informator_portable.mdl",
    pos = Vector(404.7,-25,-14-4),
    ang = Angle(0,0,0),
    hideseat = 0.2,
}
ENT.ButtonMap["RRI"] = {
    pos = ENT.ClientProps["E_informator"].pos+Vector(-0.65,-0.5,5),
    ang = Angle(0,90,0),
    width = 60,
    height = 25,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "RRIEnableToggle",x=10,y=12.5,radius=10,tooltip="",model = {
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
        }},
        {ID = "!RRIOn",x=70,y=12.5,radius=10,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",z = -13,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=62,x=-0.3,y=-0.3,z=20.6, var="RRIOn", color=Color(210,170,255),
            getfunc=function(ent,min,max,var) return ent:GetPackedBool(var) and (1-(ent.AnnLamp or 0)^1.5*0.6) or 0 end,},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(210,170,255)},
        }},
    }
}
ENT.ButtonMap["RRIScreen"] = {
    pos = ENT.ClientProps["E_informator"].pos+Vector(2,-2.9,5),
    ang = Angle(0,90,90),
    width = 121,
    height = 103,
    scale = 0.07,
    hideseat = 0.2,
    hide=true,

    buttons = {
        {ID = "RRIUp",x=30,y=60,radius=10,tooltip=""},
        {ID = "RRIDown",x=30,y=80,radius=10,tooltip=""},
        {ID = "RRILeft",x=20,y=70,radius=10,tooltip=""},
        {ID = "RRIRight",x=40,y=70,radius=10,tooltip=""},
    }
}
-- Battery panel
ENT.ButtonMap["Battery"] = {
    pos = Vector(403.5,21.24+1,20.5),
    ang = Angle(0,90,90),
    width = 250,
    height = 140,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "VBToggle", x=0, y=0, w=250, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_black_3.mdl", z=15, ang=Angle(90,0,180),
            var="VB",speed=6,vmin=1,vmax=0,
            sndvol = 1, snd = function(val) return val and "vu223_on" or "vu223_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}

-- Parking brake panel
ENT.ButtonMap["ParkingBrake"] = {
    pos = Vector(457,45.0,-2.0),
    ang = Angle(0,-83,90),
    width = 300,
    height = 400,
    scale = 0.0625,

    buttons = {
        {ID = "ParkingBrakeLeft",x=0, y=0, w=150, h=400, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.ParkingBrake"),ent:GetPackedRatio("ManualBrake")*100) end},
        {ID = "ParkingBrakeRight",x=150, y=0, w=150, h=400, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.ParkingBrake"),ent:GetPackedRatio("ManualBrake")*100) end},
    }
}


-- Train driver helpers panel
ENT.ButtonMap["HelperPanel"] = {
    pos = Vector(452.5+1.6,59.5,22.44),
    ang = Angle(0,-53,90),
    width = 60,
    height = 235,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "V6Set",          x=30, y=149, radius=30, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudwhite.mdl", z=-5, color = Color(255,255,255),
            var="V6",speed=12, max=0.5,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "V3Toggle",          x=30, y=40, radius=30, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudwhite.mdl", z=-5, color = Color(255,255,255),
            var="V3",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Unlocked","Train.Buttons.Locked"},
        }},
        {ID = "R_Program1HSet",  x=14, y=220, radius=15, tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = 8,
            labels={{model="models/metrostroi_train/81-702/labels/vu_labels.mdl",skin=7,ang=90,z=2,x=0,y=24}},
            var="R_Program1H",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button3_off" end,
            sndmin = 60,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "R_Program2HSet",  x=44, y=220, radius=15, tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = 8,
            labels={{model="models/metrostroi_train/81-702/labels/vu_labels.mdl",skin=8,ang=90,z=2,x=0,y=24}},
            var="R_Program2H",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button3_off" end,            sndmin = 60,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}


ENT.ButtonMap["DriverValveBLTLDisconnect"] = {
    pos = Vector(427,-60.78,-22.65),
    ang = Angle(0,90,0),
    width = 170,
    height = 100,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveBLDisconnectToggle", x=0, y=0, w=95, h=100, tooltip="", model = {
            var="DriverValveBLDisconnect",sndid="brake_disconnect",
            sndvol = 1, snd = function(val) return "disconnect_valve" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
        {ID = "DriverValveTLDisconnectToggle", x=95, y=0, w=75, h=100, tooltip="", model = {
            var="DriverValveTLDisconnect",sndid="train_disconnect",
            sndvol = 1, snd = function(val) return val and "pneumo_TL_open" or "pneumo_TL_disconnect" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
    }
}

ENT.ButtonMap["EPKDisconnect"] = {
    pos = Vector(433,-60.78,-28.65),
    ang = Angle(0,90,0),
    width = 150,
    height = 100,
    scale = 0.0625,

    buttons = {
        {ID = "EPKToggle", x=0, y=0, w=150, h=100, tooltip="", model = {
            var="EPK",sndid="EPK_disconnect",
            sndvol = 1, snd = function(val) return "disconnect_valve" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
    }
}

ENT.ButtonMap["FrontPneumatic"] = {
    pos = Vector(470,-45.0,-58.0),
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
    pos = Vector(450+19, -30, -68.5),
    ang = Angle(-15,-90,0),
    hide = 2,
}
ENT.ClientProps["FrontTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(450+19, 30.5, -68.5),
    ang = Angle( 15,-90,0),
    hide = 2,
}
ENT.ClientSounds["FrontBrakeLineIsolation"] = {{"FrontBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["FrontTrainLineIsolation"] = {{"FrontTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
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
    pos = Vector(-450-21, -30.5, -68.5),
    ang = Angle( 15,90,0),
    hide = 2,
}
ENT.ClientProps["RearBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(-450-21, 30, -68.5),
    ang = Angle(-15,90,0),
    hide = 2,
}
ENT.ClientSounds["RearBrakeLineIsolation"] = {{"RearBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["RearTrainLineIsolation"] = {{"RearTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}

ENT.ButtonMap["GV"] = {
    pos = Vector(170-3,50+20,-60),
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
    pos = Vector(153.5-3,36+20,-78),
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

ENT.ButtonMap["AirDistributor"] = {
    pos = Vector(-215,69,-60),
    ang = Angle(0,180,90),
    width = 170,
    height = 260,
    scale = 0.1,
    hideseat=0.1,
    hide=true,
    screenHide = true,

    buttons = {
        {ID = "AirDistributorDisconnectToggle",x=0, y=0, w= 170,h = 260, tooltip="",var="AD",states={"Train.Buttons.On","Train.Buttons.Off"}},
    }
}

-- UAVA
ENT.ButtonMap["UAVAPanel"] = {
    pos = Vector(453.5,56,-5),
    ang = Angle(0,-70,90),
    width = 180,
    height = 200,
    scale = 0.0625,

    buttons = {
        {ID = "UAVAToggle",x=0, y=0, w=60, h=200, tooltip="", model = {
            plomb = {var="UAVAPl", ID="UAVAPl",},
            var="UAVA",
            sndid="UAVALever",sndvol = 1, snd = function(val) return val and "uava_on" or "uava_off" end,
            sndmin=30, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "UAVACToggle",x=60, y=0, w=120, h=200, tooltip="",var="UAVAC",states={"Train.Buttons.UAVAOff","Train.Buttons.UAVAOn"}},
    }
}

ENT.ClientProps["tab"] = {
    model = "models/metrostroi_train/Equipment/tab.mdl",
    pos = Vector(-0.0,0,-0),
    ang = Angle(0,0,0),
    skin = 3,
    hide = 2,
}
ENT.ButtonMap["Route"] = {
    pos = Vector(465.7,35.3,2),
    ang = Angle(0,98,90),
    width = 153,
    height = 130,
    scale = 0.0625,
    buttons = {
        {ID = "RouteNumber1+",x=76.5*0,y=0, w=76.5,h=65, tooltip=""},
        {ID = "RouteNumber2+",x=76.5*1,y=0, w=76.5,h=65, tooltip=""},
        {ID = "RouteNumber1-",x=76.5*0,y=65,w=76.5,h=65, tooltip=""},
        {ID = "RouteNumber2-",x=76.5*1,y=65,w=76.5,h=65, tooltip=""},
    }
}
ENT.ClientProps["route"] = {
    model = "models/metrostroi_train/common/routes/ezh/route_holder.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2,
}
ENT.ClientProps["route1"] = {
    model = "models/metrostroi_train/common/routes/ezh/route_number1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
    hide = 2,
}
ENT.ClientProps["route2"] = {
    model = "models/metrostroi_train/common/routes/ezh/route_number2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2,
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
}

ENT.ButtonMap["FrontDoor"] = {
    pos = Vector(468,16,43.4),
    ang = Angle(0,-90,90),
    width = 642,
    height = 1780,
    scale = 0.1/2,
    buttons = {
        {ID = "FrontDoor",x=0,y=0,w=642,h=1900, tooltip="", model = {
            var="door1",sndid="door1",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}

ENT.ButtonMap["CabinDoor"] = {
    pos = Vector(416,64,43.4),
    ang = Angle(0,0,90),
    width = 642,
    height = 1780,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoor",x=0,y=0,w=642,h=2000, tooltip="", model = {
            var="door4",sndid="door4",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}

ENT.ButtonMap["PassengerDoor"] = {
    pos = Vector(384,-16,43.4),
    ang = Angle(0,90,90),
    width = 642,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=642,h=2000, tooltip="", model = {
            var="door3",sndid="door3",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
ENT.ButtonMap["PassengerDoor1"] = {
    pos = Vector(384,16,43.4),
    ang = Angle(0,-90,90),
    width = 642,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=642,h=2000, tooltip="", model = {
            var="door3",sndid="door3",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
ENT.ButtonMap["RearDoor"] = {
    pos = Vector(-470,-16,41),
    ang = Angle(0,90,90),
    width = 700,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=700,h=1900, tooltip="", model = {
            var="door2",sndid="door2",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin=90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
--High voltage fuses
ENT.ClientProps["PR1Fuse"] = {
    model = "models/metrostroi_train/81-717/BP15_sg.mdl",
    pos = Vector(405.7,30.17,-2.1),
    ang = Angle(0,0,0),
    scale = 2.25,
}
ENT.ClientProps["PR2Fuse"] = {
    model = "models/metrostroi_train/81-717/BP15_sg.mdl",
    pos = Vector(405.7,30.17+(2.75*1),-2.1),
    ang = Angle(0,0,0),
    scale = 2.25,
}
ENT.ClientProps["PR5Fuse"] = {
    model = "models/metrostroi_train/81-717/BP15_sg.mdl",
    pos = Vector(405.7,30.17+(2.75*2),-2.1),
    ang = Angle(0,0,0),
    scale = 2.25,
}
ENT.ClientProps["PR11Fuse"] = {
    model = "models/metrostroi_train/81-717/BP15_sg.mdl",
    pos = Vector(405.7,30.17+(2.75*3),-2.1),
    ang = Angle(0,0,0),
    scale = 2.25,
}
ENT.ClientProps["PR4Fuse"] = {
    model = "models/metrostroi_train/81-717/BP15_sg.mdl",
    pos = Vector(405.7,30.17+(2.75*4),-2.1),
    ang = Angle(0,0,0),
    scale = 2.25,
}
ENT.ClientProps["PR9Fuse"] = {
    model = "models/metrostroi_train/81-717/BP15_sg.mdl",
    pos = Vector(405.7,30.17+(2.75*5),-2.1),
    ang = Angle(0,0,0),
    scale = 2.25,
}
ENT.ClientProps["PR6Fuse"] = {
    model = "models/metrostroi_train/81-717/BP15_sg.mdl",
    pos = Vector(405.7,30.17+(2.75*6),-2.1),
    ang = Angle(0,0,0),
    scale = 2.25,
}
ENT.ClientProps["PR8Fuse"] = {
    model = "models/metrostroi_train/81-717/BP15_sg.mdl",
    pos = Vector(405.7,30.17+(2.75*7),-2.1),
    ang = Angle(0,0,0),
    scale = 2.25,
}
ENT.ClientProps["PR12Fuse"] = {
    model = "models/metrostroi_train/81-717/BP15_sg.mdl",
    pos = Vector(405.7,30.17+(2.75*8),-2.1),
    ang = Angle(0,0,0),
    scale = 2.25,
}
ENT.ClientProps["PR1Cap"] = {
    model = "models/metrostroi_train/81-717/BP15.mdl",
    pos = Vector(403.9,30.17+(2.75*0),-2.45),
    ang = Angle(-90,0,180),
    scale = 0.94,
}
ENT.ClientProps["PR2Cap"] = {
    model = "models/metrostroi_train/81-717/BP15.mdl",
    pos = Vector(403.9,30.17+(2.75*1),-2.45),
    ang = Angle(-90,0,180),
    scale = 0.94,
}
ENT.ClientProps["PR5Cap"] = {
    model = "models/metrostroi_train/81-717/BP15.mdl",
    pos = Vector(403.9,30.17+(2.75*2),-2.45),
    ang = Angle(-90,0,180),
    scale = 0.94,
}
ENT.ClientProps["PR11Cap"] = {
    model = "models/metrostroi_train/81-717/BP15.mdl",
    pos = Vector(403.9,30.17+(2.75*3),-2.45),
    ang = Angle(-90,0,180),
    scale = 0.94,
}
ENT.ClientProps["PR4Cap"] = {
    model = "models/metrostroi_train/81-717/BP15.mdl",
    pos = Vector(403.9,30.17+(2.75*4),-2.45),
    ang = Angle(-90,0,180),
    scale = 0.94,
}
ENT.ClientProps["PR9Cap"] = {
    model = "models/metrostroi_train/81-717/BP15.mdl",
    pos = Vector(403.9,30.17+(2.75*5),-2.45),
    ang = Angle(-90,0,180),
    scale = 0.94,
}
ENT.ClientProps["PR6Cap"] = {
    model = "models/metrostroi_train/81-717/BP15.mdl",
    pos = Vector(403.9,30.17+(2.75*6),-2.45),
    ang = Angle(-90,0,180),
    scale = 0.94,
}
ENT.ClientProps["PR8Cap"] = {
    model = "models/metrostroi_train/81-717/BP15.mdl",
    pos = Vector(403.9,30.17+(2.75*7),-2.45),
    ang = Angle(-90,0,180),
    scale = 0.94,
}
ENT.ClientProps["PR12Cap"] = {
    model = "models/metrostroi_train/81-717/BP15.mdl",
    pos = Vector(403.9,30.17+(2.75*8),-2.45),
    ang = Angle(-90,0,180),
    scale = 0.94,
}

ENT.ButtonMap["HighVoltFuse"] = {
    pos = Vector(406,28.3,-4),
    ang = Angle(-90,180,0),
    width = 75,
    height = 410,
    scale = 0.0625,
    hide=0.8,
    buttons = { --высота, ширина между ними
        {ID = "PR1Toggle", x=0+35*1,y=30+44.1*0,radius=25,tooltip=""},
        {ID = "PR2Toggle", x=0+35*1,y=30+44.1*1,radius=25,tooltip=""},
        {ID = "PR5Toggle", x=0+35*1,y=30+44.1*2,radius=25,tooltip=""},
        {ID = "PR11Toggle",x=0+35*1,y=30+44.1*3,radius=25,tooltip=""},
        {ID = "PR4Toggle", x=0+35*1,y=30+44.1*4,radius=25,tooltip=""},
        {ID = "PR9Toggle", x=0+35*1,y=30+44.1*5,radius=25,tooltip=""},
        {ID = "PR6Toggle", x=0+35*1,y=30+44.1*6,radius=25,tooltip=""},
        {ID = "PR8Toggle", x=0+35*1,y=30+44.1*7,radius=25,tooltip=""},
        {ID = "PR12Toggle",x=0+35*1,y=30+44.1*8,radius=25,tooltip=""},
    }
}
for i,button in pairs(ENT.ButtonMap.HighVoltFuse.buttons) do
    button.model = {
        var=button.ID:Replace("Toggle",""), 
        sndid=button.ID:Replace("Toggle","Fuse"),
        sndvol = 0.2, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
        sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
          noTooltip = true
    }
end
ENT.ButtonMap["HighVoltFuseHolder"] = {
    pos = Vector(407.35,28.3,-9),
    ang = Angle(-90,180,0),
    width = 75,
    height = 410,
    scale = 0.0625,
    hide=0.8,
    buttons = { --ширина между ними, высота
        {ID = "PR1CapToggle", x=0+35*1,y=30+44.1*0,radius=25,tooltip=""},
        {ID = "PR2CapToggle", x=0+35*1,y=30+44.1*1,radius=25,tooltip=""},
        {ID = "PR5CapToggle", x=0+35*1,y=30+44.1*2,radius=25,tooltip=""},
        {ID = "PR11CapToggle",x=0+35*1,y=30+44.1*3,radius=25,tooltip=""},
        {ID = "PR4CapToggle", x=0+35*1,y=30+44.1*4,radius=25,tooltip=""},
        {ID = "PR9CapToggle", x=0+35*1,y=30+44.1*5,radius=25,tooltip=""},
        {ID = "PR6CapToggle", x=0+35*1,y=30+44.1*6,radius=25,tooltip=""},
        {ID = "PR8CapToggle", x=0+35*1,y=30+44.1*7,radius=25,tooltip=""},
        {ID = "PR12CapToggle",x=0+35*1,y=30+44.1*8,radius=25,tooltip=""},
    }
}
for i,button in pairs(ENT.ButtonMap.HighVoltFuseHolder.buttons) do
    button.model = {
        var=button.ID:Replace("Toggle",""), 
        sndid=button.ID:Replace("CapToggle","Cap"),
        sndvol = 1, snd = function(val) return val and "fusecap_open" or "fusecap_close" end,
        sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        noTooltip = true,
    }
end
ENT.ClientProps["FuN0_Holder"] = {
    model = "models/metrostroi_train/81-717/BP15.mdl",
    pos = Vector(403.08,-33,29),
    ang = Angle(-90,180,0),
    hideseat = 0.2,
    scale = 0.94,
}
ENT.ClientProps["FuN1_Holder"] = {
    model = "models/metrostroi_train/81-717/BP15.mdl",
    pos = Vector(403.08,-24.4,26.2),
    ang = Angle(-90,180,0),
    hideseat = 0.2,
    scale = 0.94,
}
ENT.ClientProps["FuN2_Holder"] = {
    model = "models/metrostroi_train/81-717/BP15.mdl",
    pos = Vector(403.08,-21.6,26.0),
    ang = Angle(-90,180,0),
    hideseat = 0.2,
    scale = 0.94,
}
ENT.ClientProps["FuN3_Holder"] = {
    model = "models/metrostroi_train/81-717/BP15.mdl",
    pos = Vector(403.08,-19,10.0),
    ang = Angle(-90,180,0),
    hideseat = 0.2,
    scale = 0.94,
}
--Low voltage fuses
ENT.ClientProps["fusebox"] = {
    model = "models/metrostroi_train/81-710/electric/fusebox.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,-90,0),
    hideseat = 1.0,
}
ENT.ClientProps["fusebox_cover"] = {
    model = "models/metrostroi_train/81-710/electric/fusebox_cover.mdl",
    pos = Vector(405.1,-33.42,5),
    ang = Angle(0,-90,0),
    hideseat = 1.0,
}
ENT.ButtonMap["FuseboxCoverC"] = {
    pos = Vector(405,-45.55,-4),
    ang = Angle(-90,180,0),
    width = 150,
    height = 380, 
    scale = 0.0625,
    hide=0.8,
    buttons = {
        {ID = "FBoxCover",x=0,y=0,w=150,h=380, tooltip ="", model = {
        var="fusebox_cover", sndid="fusebox_cover", 
        sndvol = 1.2, snd = function(val) return val and "fusebox_open" or "fusebox_close"  end,
        sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        noTooltip = true,
        }},
    }
}
ENT.ButtonMap["FuseboxCoverO"] = {
    pos = Vector(405,-45.55,6),
    ang = Angle(-90,180,0),
    width = 150,
    height = 380, 
    scale = 0.0625,
    hide=0.8,
    buttons = {
        {ID = "FBoxCover",x=0,y=0,w=150,h=380, tooltip ="", model = {
            noTooltip = true,
        }},
    }
}
ENT.ButtonMap["Fusebox"] = {
    pos = Vector(404,-45.55,-3),
    ang = Angle(-90,180,0),
    width = 300,
    height = 380, 
    scale = 0.0625,
    hide=0.8,
    buttons = {
        {ID = "PRL13Toggle", x=128+56*2,y=21+27*0,w=40,h=15,tooltip="", model = {
            var="PRL13", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
            lamp = {
                 model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", ang = Angle(0,90,0), var = "PRL13", anim = true
            }}
        },
        {ID = "PRL31Toggle", x=128+56*2,y=21+27*1,w=40,h=15,tooltip="", model = {
            var="PRL31", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1, ang = Angle(0,90,0), var = "PRL31", anim = true
            }}
        },
        {ID = "PRL17Toggle", x=128+56*2,y=21+27*2,w=40,h=15,tooltip="", model = {
            var="PRL17", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1, ang = Angle(0,90,0), var = "PRL17", anim = true
            }}
        },
        {ID = "PRL25Toggle",x=128+56*2,y=21+27*3,w=40,h=15,tooltip="", model = {
            var="PRL25", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1, ang = Angle(0,90,0), scale = 1.2, var = "PRL25", anim = true
            }}
        },
        {ID = "PRL18Toggle", x=128+56*2,y=21+27*4,w=40,h=15,tooltip="", model = {
            var="PRL18", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1, ang = Angle(0,90,0), var = "PRL18", anim = true
            }}
        },
        {ID = "PRL24Toggle", x=128+56*2,y=21+27*5,w=40,h=15,tooltip="", model = {
            var="PRL24", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1, ang = Angle(0,90,0), scale = 1.2, var = "PRL24", anim = true
            }}
        },
        {ID = "PRL19Toggle", x=128+56*2,y=21+27*6,w=40,h=15,tooltip="", model = {
            var="PRL19", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.2, ang = Angle(0,90,0), var = "PRL19", anim = true
            }}
        },
        {ID = "PRL6AToggle", x=128+56*2,y=21+27*7,w=40,h=15,tooltip="", model = {
            var="PRL6A", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.2, ang = Angle(0,90,0), scale = 1.2, var = "PRL6A", anim = true
            }}
        },
        {ID = "PRL4AToggle",x=128+56*2,y=21+27*8,w=40,h=15,tooltip="", model = {
            var="PRL4A", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.2, ang = Angle(0,90,0), var = "PRL4A", anim = true
            }}
        },
        {ID = "PRL16Toggle", x=128+56*2,y=21+27*9,w=40,h=15,tooltip="", model = {
            var="PRL16", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.2, ang = Angle(0,90,0), var = "PRL16", anim = true
            }}
        },
        {ID = "PRL28Toggle", x=128+56*2,y=21+27*10,w=40,h=15,tooltip="", model = {
            var="PRL28", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.7, ang = Angle(0,90,0), var = "PRL28", anim = true
            }}
        },
        {ID = "PRL2AToggle", x=128+56*2,y=21+27*11,w=40,h=15,tooltip="", model = {
            var="PRL2A", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.2, ang = Angle(0,90,0), var = "PRL2A", anim = true
            }}
        },
        {ID = "PRL34Toggle",x=128+56*2,y=21+27*12,w=40,h=15,tooltip="", model = {
            var="PRL34", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.2, ang = Angle(0,90,0), var = "PRL34", anim = true
            }}
        },
        --Нижний ряд
        {ID = "PRL23Toggle", x=110+56*1,y=21+27*0,w=40,h=15,tooltip="", model = {
            var="PRL23", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 0.7, ang = Angle(0,90,0), var = "PRL23", anim = true
            }}
        },
        {ID = "PRL15Toggle", x=110+56*1,y=21+27*1,w=40,h=15,tooltip="", model = {
            var="PRL15", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 0.7, ang = Angle(0,90,0), var = "PRL15", anim = true
            }}
        },
        {ID = "PRL22Toggle", x=110+56*1,y=21+27*2,w=40,h=15,tooltip="", model = {
            var="PRL22", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.2, ang = Angle(0,90,0), var = "PRL22", anim = true
            }}
        },
        {ID = "PRL20Toggle", x=110+56*1,y=21+27*3,w=40,h=15,tooltip="", model = {
            var="PRL20", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.2, x = -9, ang = Angle(0,90,0), var = "PRL20", anim = true
            }}
        },
        {ID = "PRL21Toggle",x=110+56*1,y=21+27*4,w=40,h=15,tooltip="", model = {
            var="PRL21", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.2, ang = Angle(0,90,0), var = "PRL21", anim = true
            }}
        },
        {ID = "PRL32Toggle", x=110+56*1,y=21+27*5,w=40,h=15,tooltip="", model = {
            var="PRL32", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.2, x = -9, ang = Angle(0,90,0), var = "PRL32", anim = true
            }}
        },
        {ID = "PRL30Toggle",x=110+56*1,y=21+27*6,w=40,h=15,tooltip="", model = {
            var="PRL30", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.2, ang = Angle(0,90,0), var = "PRL30", anim = true
            }}
        },
        {ID = "PRL1AToggle", x=110+56*1,y=21+27*7,w=40,h=15,tooltip="", model = {
            var="PRL1A", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.2, x = -9, ang = Angle(0,90,0), var = "PRL1A", anim = true
            }}
        },
        {ID = "PRL14Toggle",x=110+56*1,y=21+27*8,w=40,h=15,tooltip="", model = {
            var="PRL14", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.2, ang = Angle(0,90,0), var = "PRL14", anim = true
            }}
        }, 
        {ID = "PRL26Toggle", x=110+56*1,y=21+27*9,w=40,h=15,tooltip="", model = {
            var="PRL26", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.2, ang = Angle(0,90,0), var = "PRL26", anim = true
            }}
        },
        {ID = "PRL12Toggle",x=110+56*1,y=21+27*10,w=40,h=15,tooltip="", model = {
            var="PRL12", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.2, ang = Angle(0,90,0), var = "PRL12", anim = true
            }}
        },
        {ID = "PRL3AToggle", x=110+56*1,y=21+27*11,w=40,h=15,tooltip="", model = {
            var="PRL3A", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.2, ang = Angle(0,90,0), var = "PRL3A", anim = true
            }}
        },
        {ID = "PRL33Toggle",x=110+56*1,y=21+27*12,w=40,h=15,tooltip="", model = {
            var="PRL33", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.2, ang = Angle(0,90,0), var = "PRL33", anim = true
            }}
        },
    }
}

--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false
if not ENT.ClientSounds["br_334"] then ENT.ClientSounds["br_334"] = {} end
table.insert(ENT.ClientSounds["br_334"],{"brake",function(ent,_,var) return "br_334_"..var end,1,1,50,1e3,Angle(-90,0,0)})
ENT.ClientProps["brake334"] = {
    model = "models/metrostroi_train/81-703/cabin_cran_334.mdl",
    pos = Vector(448.62+3.6,-56.5,-38.0),
    ang = Angle(0,-150,0),
    hideseat = 0.2,
}
ENT.ClientProps["brake"] = {
    model = "models/metrostroi_train/81-710/ezh3_km334.mdl",
    pos = Vector(448.62+3.2,-48.69,-15.0),
    ang = Angle(0,-90+2,90-27),
    hideseat = 0.2,
}
ENT.ClientProps["controller"] = {
    model = "models/metrostroi_train/81-710/ezh3_kv.mdl",
    pos = Vector(451.36+2,-26.45,-17),
    ang = Angle(0,-91,60),
    hideseat = 0.2,
}


ENT.ClientProps["reverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = Vector(452.95,-21.00,-15.9),
    ang = Angle(180,89,180),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
--[[ ENT.ClientProps["reverser"] = {
    model = "models/metrostroi/81-717/reverser.mdl",
    pos = ENT.ClientProps["controller"].pos+Vector(0,0.35,-0.6),
    ang = Angle(0,45,90)
}--]]
ENT.ClientProps["krureverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = Vector(404.8+0.45,-23.5,-2.2),
    ang = Angle(30+180,90,90),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientProps["rcureverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["reverser"].pos+Vector(-4.1,-0.65,-0.9),
    ang = Angle(180,180-25,180),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientProps["brake_disconnect"] = {
    model = "models/metrostroi_train/81-710/ezh3_red_brake.mdl",
    pos = Vector(430.7,-58.8,-21.2),
    ang = Angle(0,270,0),
    hideseat = 0.2,
}
ENT.ClientProps["train_disconnect"] = {
    model = "models/metrostroi_train/81-710/ezh3_blue_brake.mdl",
    pos = Vector(430.7+0.5,-56.50,-25.51),
    ang = Angle(0,270,0),
    hideseat = 0.2,
}
ENT.ClientProps["EPK_disconnect"] = {
    model = "models/metrostroi_train/81-710/ezh3_epk.mdl",
    pos = Vector(430.7+7.17,-56.7,-29.11),
    ang = Angle(0,270,0),
    hideseat = 0.2,
}

ENT.ClientProps["EmergencyBrakeValve"] = {
    model = "models/metrostroi_train/81-710/ezh3_stopkran.mdl",
    pos = Vector(454+10.34,24.45,-2.39),
    ang = Angle(0,180,0),
    hideseat = 0.2,
}


ENT.ClientProps["parking_brake"] = {
    model = "models/metrostroi_train/81-703/cabin_parking.mdl",
    pos = Vector(449.118378+7.6,33.493385+2,-14.713276),
    ang = Angle(-90.000000,7,0.000000),
    hideseat = 0.2,
}

--------------------------------------------------------------------------------
ENT.ClientProps["train_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(457.441650,-50.929134,-6.880497),
    ang = Angle(-130.645157,119.032257,-130.645157),
    hideseat = 0.2,
}
ENT.ClientProps["brake_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_tm.mdl",
    pos = Vector(457.549988,-50.889999,-6.960000),
    ang = Angle(-130.645157,119.032257,-130.645157),
    hideseat = 0.2,
}
ENT.ClientProps["brake_cylinder"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(457.100006,-56.860001,-6.950000),
    ang = Angle(-130.645157,124.838707,-136.451614),
    hideseat = 0.2,
}
----------------------------------------------------------------
ENT.ClientProps["voltmeter"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(448.201+9.90,-28.78,-6.69),
    ang = Angle(-62,0,0),
    hideseat = 0.2,
}

ENT.ClientProps["ampermeter"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(448.20+10.09,-24.66,-6.69),
    ang = Angle(-62,0,0),
    hideseat = 0.2,
}

ENT.ClientProps["volt1"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(448.20+10.35,-20.57,-6.69),
    ang = Angle(-62,0,0),
    hideseat = 0.2,
}
ENT.ClientProps["speed1"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(457.175720,-39.546356,-8.339609),
    ang = Angle(-61.5,-5,0),
    bscale = Vector(1,1,1.5),
    hideseat = 0.2,
}

--------------------------------------------------------------------------------
--[[ENT.ClientProps["book"] = {
    model = "models/props_lab/binderredlabel.mdl",
    pos = Vector(401.763123,-32.429512,48.305576),
    ang = Angle(53,0,90),
}]]

ENT.ClientProps["salon"] = {
    model = "models/metrostroi_train/81-710/ezh3_salon.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2.0,
}
ENT.ClientProps["salon3"] = {
    model = "models/metrostroi_train/81-710/ezh3_cabine.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2.0,
}
ENT.ClientProps["salon2"] = {
    model = "models/metrostroi_train/81-508/81-508_underwagon.mdl",
    pos = Vector(0.2,0,-18),
    ang = Angle(0,0,0),
    hide = 2.0,
}
ENT.ClientProps["asotp"] = {
    model = "models/metrostroi_train/81-710/710_asotp_new.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat = 1.0,
}

--Gauges light switch mesh
ENT.ClientProps["Gauges_lit"] = {
    model = "models/metrostroi_train/81-710/710_gaugeslit.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat = 1.0,
}
--Panel lamps
ENT.ClientProps["ezh3_l0"] = {
    model = "models/metrostroi_train/81-710/ezh3_l0.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
    hideseat = 1.0,
}
ENT.ClientProps["ezh3_loch"] = {
    model = "models/metrostroi_train/81-710/ezh3_loch.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
    hideseat = 1.0,
}
ENT.ClientProps["ezh3_l40"] = {
    model = "models/metrostroi_train/81-710/ezh3_l40.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
    hideseat = 1.0,
}
ENT.ClientProps["ezh3_l60"] = {
    model = "models/metrostroi_train/81-710/ezh3_l60.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
    hideseat = 1.0,
}
ENT.ClientProps["ezh3_l70"] = {
    model = "models/metrostroi_train/81-710/ezh3_l70.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
    hideseat = 1.0,
}
ENT.ClientProps["ezh3_l80"] = {
    model = "models/metrostroi_train/81-710/ezh3_l80.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
    hideseat = 1.0,
}
ENT.ClientProps["ezh3_lkt"] = {
    model = "models/metrostroi_train/81-710/ezh3_lkt.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
    hideseat = 1.0,
}
ENT.ClientProps["ezh3_lkvd"] = {
    model = "models/metrostroi_train/81-710/ezh3_lkvd.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
    hideseat = 1.0,
}
ENT.ClientProps["ezh3_lpu"] = {
    model = "models/metrostroi_train/81-710/ezh3_lpu.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
    hideseat = 1.0,
}
ENT.ClientProps["ezh3_lsd"] = {
    model = "models/metrostroi_train/81-710/ezh3_lsd.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
    hideseat = 1.0,
}
ENT.ClientProps["ezh3_lrp"] = {
    model = "models/metrostroi_train/81-710/ezh3_lrp.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
    hideseat = 1.0,
}
ENT.ClientProps["ezh3_lrpgreen"] = {
    model = "models/metrostroi_train/81-710/ezh3_lrpgreen.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
    hideseat = 1.0,
}
ENT.ClientProps["ezh3_lamp1"] = {
    model = "models/metrostroi_train/81-710/ezh3_lamposv1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(215,255,255),
    hideseat = 1.0,
}
ENT.ClientProps["ezh3_lamp2"] = {
    model = "models/metrostroi_train/81-502/cabin_lamp_light.mdl",
    pos = Vector(0,-0.05,0.17),
    ang = Angle(0,0,0),
    hide = 0.8,
}
ENT.ClientProps["Lamps_emer1"] = {
    model = "models/metrostroi_train/81-502/lights_emer2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    --color=Color(255,150,150),
    hide = 2,
}
ENT.ClientProps["Lamps_emer2"] = {
    model = "models/metrostroi_train/81-502/lights_emer.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    --color=Color(255,150,150),
    hide = 2,
}
ENT.ClientProps["Lamps_half1"] = {
    model = "models/metrostroi_train/81-502/lights_group1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["Lamps_half2"] = {
    model = "models/metrostroi_train/81-502/lights_group2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide = true,
}

ENT.ClientProps["PB"] = {
    model = "models/metrostroi_train/81-707/pedal.mdl",
    pos = Vector(458.320068,-40.480316,-35.155365),
    ang = Angle(90,0,0),
    hideseat = 0.2,
}
if not ENT.ClientSounds["PB"] then ENT.ClientSounds["PB"] = {} end
table.insert(ENT.ClientSounds["PB"],{"PB",function(ent,var) return var > 0 and "pb_on" or "pb_off" end,1,1,35,1e3,Angle(-90,0,0)})

--------------------------------------------------------------------------------
-- Add doors
--[[ local function GetDoorPosition(i,k,j)
    if j == 0
    then return Vector(344.9-0.1*k     - 233.6*i,-63.86*(1-2.02*k),-5.75)
    else return Vector(344.9-0.1*(1-k) - 233.6*i,-63.86*(1-2.02*k),-5.75)
    end
end
for i=0,3 do
    for k=0,1 do
        ENT.ClientProps["door"..i.."x"..k.."a"] = {
            model = "models/metrostroi_train/81-710/81-710_door_right.mdl",
            pos = GetDoorPosition(i,k,0),
            ang = Angle(0,90 + 180*k,0),
            hide = 2,
        }
        ENT.ClientProps["door"..i.."x"..k.."b"] = {
            model = "models/metrostroi_train/81-710/81-710_door_left.mdl",
            pos = GetDoorPosition(i,k,1),
            ang = Angle(0,90 + 180*k,0),
            hide = 2,
        }
    end
end--]]
ENT.ClientProps["door0x1"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos1.mdl",
    pos = Vector(344.692,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x1"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos2.mdl",
    pos = Vector(110.668,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x1"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos3.mdl",
    pos = Vector(-122.718,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x1"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos4.mdl",
    pos = Vector(-356.091,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door0x0"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos4.mdl",
    pos = Vector(344.692,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x0"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos3.mdl",
    pos = Vector(110.668,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x0"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos2.mdl",
    pos = Vector(-122.718,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x0"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos1.mdl",
    pos = Vector(-356.091,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1"] = {
    model = "models/metrostroi_train/81-710/ezh3_door_noars_with_marshrut.mdl",
    pos = Vector(460.62+7.4,-14.53,-7.6),
    ang = Angle(0,-90,0),
    hide = 2,
    callback = function(ent)
        ent.LastStation.Reloaded = false
    end,
}
ENT.ButtonMap["LastStation"] = {
    pos = Vector(460.62+7.4,-14.53,2),
    ang = Angle(0,90,90),
    width = 500,
    height = 150,
    scale = 0.0625,
    buttons = {
        {ID = "LastStation-",x=000,y=0,w=250,h=150, tooltip=""},
        {ID = "LastStation+",x=250,y=0,w=250,h=150, tooltip=""},
    }
}
ENT.ClientProps["door2"] = {
    model = "models/metrostroi_train/81-710/81-710_door_tor.mdl",
    pos = Vector(-469.8,16.53,-8.2),
    ang = Angle(0,90,0),
    hide = 2,
}
ENT.ClientProps["door3"] = {
    model = "models/metrostroi_train/81-710/81-710_door_interior_a.mdl",
    pos = Vector(382.3,-15,-9.4),
    ang = Angle(0,90,0),
    hide = 2,
}
ENT.ClientProps["door4"] = {
    model = "models/metrostroi_train/81-710/81-710_door_cab.mdl",
    pos = Vector(411.17+7.6,66.05,-6.38),
    ang = Angle(0,-90,0),
    hide = 2,
}
ENT.ClientProps["UAVALever"] = {
    model = "models/metrostroi_train/81-703/cabin_uava.mdl",
    pos = Vector(449+7.7,56.0,-10.24349),
    ang = Angle(0,-90+10,0),
    hideseat = 0.8,
}
ENT.ClientProps["RedLight2"] = {
    model = "models/metrostroi_train/81-710/81-710_red_light_l.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0.000000),
    nohide=true,
}
ENT.ClientProps["RedLight1"] = {
    model = "models/metrostroi_train/81-710/81-710_red_light_r.mdl",
    pos = Vector(0,0,0), --скорректировать и заменитть
    ang = Angle(0,0,0.000000),
    nohide=true,
}
ENT.ClientProps["DistantLights"] = {
    model = "models/metrostroi_train/81-703/81-703_projcetor_light.mdl",
    pos = Vector(-23+8.0,1,-191),
    ang = Angle(00.000000,0.000000,0.000000),
    nohide=true,
}
ENT.ClientProps["WhiteLights"] = {
    model = "models/metrostroi_train/81-703/81-703_front_light.mdl",
    pos = Vector(-23+7.3,1,-191),
    ang = Angle(0,0,0),
    nohide=true,
}


for i=0,3 do
    ENT.ClientProps["TrainNumberL"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(295+i*6.6-4*6.6/2,69,-26),
        ang = Angle(180,0,180),
        skin=0,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
    ENT.ClientProps["TrainNumberR"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(295-i*6.6-4*6.6/2,-66.2,-26),
        ang = Angle(0,0,0),
        skin=0,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end
ENT.Lights = {
    [1] = { "headlight",        Vector(470,0,-35), Angle(0,0,0), Color(200,130,88), brightness = 4 , fov=100, texture = "models/metrostroi_train/equipment/headlight",shadows = 1,headlight=true},
    [2] = { "headlight",        Vector(460,0,45), Angle(-20,0,0), Color(255,0,0), fov=164 ,brightness = 0.3, farz=250,texture = "models/metrostroi_train/equipment/headlight2",shadows = 0,backlight=true},
    [3] = { "headlight",        Vector(460,0,45), Angle(-20,0,0), Color(255,0,0), fov=164 ,brightness = 0.3, farz=250,texture = "models/metrostroi_train/equipment/headlight2",shadows = 0,backlight=true},

    [19] = { "headlight",     Vector(458.467194,-39.912831,-5.513901), Angle(45,-0.000000,0.000000), Color(255,145,25), farz = 16.7, nearz = 1, shadows = 1, brightness = 2, fov = 155,panellight=true,hidden = "Gauges_lit"},
    --manometers
    [20] = { "headlight",      Vector(457.679059,-50.208813,-5.092313), Angle(45,0.000000,0.000000), Color(255,145,25), farz = 16, nearz = 1, shadows = 1, brightness = 2, fov = 155,panellight=true,hidden = "Gauges_lit"},
    [21] = { "headlight",       Vector(457.579059,-57.208813,-4.092313), Angle(45,0.000000,0.000000), Color(255,145,25), farz = 16, nearz = 1, shadows = 1, brightness = 2, fov = 150,panellight=true,hidden = "Gauges_lit"},
    [22] = { "headlight",       Vector(432+18.5,-33.5,47.2), Angle(90,0,0), Color(252, 157, 77), farz = 200, nearz = 0.1, shadows = 0,  brightness = 0.3, fov = 160, texture = "models/metrostroi_train/equipment/headlight",hidden = "ezh3_lamp1"},
    --[24] = { "headlight",       Vector(448.20+9.4,-55.86,-4.8), Angle(93,0,60), Color(255,145,25), farz = 15, nearz = 1, shadows = 1, brightness = 0, fov = 80},
    --cabinlight

    [9] = { "dynamiclight",    Vector(200, 0, -5), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 200},
    [10] = { "dynamiclight",    Vector(-150, 0, -5), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 200},
    [11] = { "dynamiclight",    Vector( 200, 0, -5), Angle(0,0,0), Color(255,220,180), brightness = 4, distance = 260},
    [12] = { "dynamiclight",    Vector(   0, 0, -5), Angle(0,0,0), Color(255,220,180), brightness = 4, distance = 260},
    [13] = { "dynamiclight",    Vector(-260, 0, -5), Angle(0,0,0), Color(255,220,180), brightness = 4, distance = 260},

    -- Cabin
    [23] = { "dynamiclight",        Vector(432,-10.0,20), Angle(0,0,0), Color(252, 157, 77), brightness = 0.0005, distance = 600, hidden = "salon3"},

    [5] =   { "light",           Vector(465+5,-32, 48), Angle(0,0,0), Color(255,50,50),     brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2 },
    [6] =   { "light",           Vector(465+5, 32, 48), Angle(0,0,0), Color(255,50,50),     brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2 },
    [30]  = { "light",           Vector(465+5  ,   -45, -37), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2 },
    [31]  = { "light",           Vector(465+5  ,   45, -37), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2 },
    [32]  = { "light",           Vector(465+5  ,   0, 48), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02", size = 2 },

    ezh3_lamp1 = {"light", Vector(451,-33.5,47.2), Angle(0,0,0),Color(255,220,180),brightness = 0.35,scale = 0.4, texture = "sprites/light_glow02", hidden = "ezh3_lamp1"},
    ezh3_lamp2 = {"light", Vector(404,1.2,56), Angle(0,0,0),Color(255,220,180),brightness = 0.25,scale = 0.3, texture = "sprites/light_glow02", hidden = "ezh3_lamp2"},
}
function ENT:Initialize()
    self.BaseClass.Initialize(self)

    self.FrontLeak = 0
    self.RearLeak = 0

    --self.Train:SetPackedRatio("EmergencyValve_dPdT", leak)
    --self.Train:SetPackedRatio("EmergencyValveEPK_dPdT", leak)
    --self.Train:SetPackedRatio("EmergencyBrakeValve_dPdT", leak)
    self.ASNP = self:CreateRT("710ASNP",512,128)
    self.IGLA = self:CreateRT("710IGLA",512,128)
    self.RRIScreen = self:CreateRT("710RRI",128,128)
    self.CraneRamp = 0
    self.ReleasedPdT = 0
    self.EmergencyValveRamp = 0
    self.EmergencyValveEPKRamp = 0
    self.EmergencyBrakeValveRamp = 0
end

function ENT:UpdateWagonNumber()
    for i=0,3 do
        local leftNum,rightNum = self.ClientEnts["TrainNumberL"..i],self.ClientEnts["TrainNumberR"..i]
        local num = math.floor(self.WagonNumber%(10^(i+1))/10^i)
        if IsValid(leftNum) then
            leftNum:SetPos(self:LocalToWorld(Vector(295+i*6.6-3*6.6/2,69,-26)))
            leftNum:SetSkin(num)
        end
        if IsValid(rightNum) then
            rightNum:SetPos(self:LocalToWorld(Vector(-280-i*6.6-3*6.6/2,-66.4,-26)))
            rightNum:SetSkin(num)
        end
    end
end

local kruPos = {0,0.2,0.8,1}
--------------------------------------------------------------------------------
function ENT:Think()
    self.BaseClass.Think(self)
    if not self.RenderClientEnts or self.CreatingCSEnts then
        return
    end

    local val = self:Animate("gauges_lit",self:GetPackedBool("GaugeLights") and 1 or 0,0,1,12,false)
    self:ShowHideSmooth("Gauges_lit",val)
    self:SetLightPower(19,val>0,val)--self:GetPackedBool("PanelLights"))
    self:SetLightPower(20,val>0,val)--self:GetPackedBool("PanelLights"))
    self:SetLightPower(21,val>0,val)--self:GetPackedBool("PanelLights"))

    local typ = self:GetNW2Int("AnnType",1)
    self:HidePanel("RRI",typ~=1)
    self:HidePanel("RRIScreen",typ~=1 or self.CurrentCamera ~= 9)
    self:ShowHide("E_informator",typ==1)
    self:HidePanel("ASNP",typ~=2)
    self:HidePanel("ASNPScreen",typ~=2)
    self:HidePanel("IGLAButtons",typ~=2)
    self:HidePanel("IGLA",typ~=2)
    self:ShowHide("asotp",typ==2)

    -- Parking brake animation
    self.TrueBrakeAngle = self.TrueBrakeAngle or 0
    self.TrueBrakeAngle = self.TrueBrakeAngle + (self:GetPackedRatio("ManualBrake")*360*3.2 - self.TrueBrakeAngle)*2.0*(self.DeltaTime or 0)
    if self.ClientEnts and self.ClientEnts["parking_brake"] then
        self.ClientEnts["parking_brake"]:SetPoseParameter("position",1.0-((self.TrueBrakeAngle % 360)/360))
    end
    local BAsnd = math.floor(self.TrueBrakeAngle/10)
    if self.BrakeAngleSND ~= BAsnd then
        if not IsValid(self.Sounds["parking_brake_rolling"]) or self.Sounds["parking_brake_rolling"]:GetState() ~= GMOD_CHANNEL_PLAYING then
            self:PlayOnce("parking_brake_rolling","bass",1,1)
        end
        self.BrakeAngleSND = BAsnd
    end
     
    --Fuses animate
    local fusepanelC = self:HidePanel("FuseboxCoverC", not self:GetPackedBool("FuseboxCover")) 
    local fusepanelO = self:HidePanel("FuseboxCoverO", self:GetPackedBool("FuseboxCover"))
    for i=1,12 do 
        self:ShowHide("PR"..i.."Toggle", self:GetPackedBool("PR"..i.."Cover"))
        if (self:Animate("PR"..i.."Cap", self:GetPackedBool("PR"..i.."Cover") and 0.99 or 0,0,1,4,false) >= 0.01) then
            self:ShowHideSmooth("PR"..i.."Fuse", ((self:GetPackedBool("PR"..i.."FState") and 1 or 0) - (self:Animate("PR"..i.."Fuse",self:GetPackedBool("PR"..i.."FState") and 0 or 1,0,1,5,false))))
        else
            self:ShowHide("PR"..i.."Fuse",1)
        end
    end
    
    local fusebox_cover = self:Animate("fusebox_cover", self:GetPackedBool("FuseboxCover") and 1 or 0,0,1,8,1)
    if self.FboxCover ~= (fusebox_cover > 0) then
        self.FboxCover = fusebox_cover > 0
        self:PlayOnce("fusebox_cover","bass",self.FboxCover and 1 or 0)
    end
	self:HidePanel("Fusebox", fusebox_cover == 0)

    local Lamps = self:GetPackedRatio("LampsStrength")
    local emer1 = self:Animate("lamps_emer1",self:GetPackedBool("Lamps_emer1") and 1 or 0,0,1,5,false)
    local cab = self:Animate("lamps_cab",self:GetPackedBool("Lamps_cab") and 1 or 0,0,1,5,false)
    local emer2 = self:Animate("lamps_emer2",self:GetPackedBool("Lamps_emer2") and 1 or 0,0,1,5,false)
    local half1 = self:Animate("lamps_half1",self:GetPackedBool("Lamps_half1") and 0.4+Lamps*0.6 or 0,0,1,5,false)
    local half2 = self:Animate("lamps_half2",self:GetPackedBool("Lamps_half2") and 0.4+Lamps*0.6 or 0,0,1,5,false) 
    self:ShowHideSmooth("Lamps_emer1",emer1)
    self:ShowHideSmooth("ezh3_lamp2",cab)
    self:ShowHideSmooth("Lamps_emer2",emer2)
    self:ShowHideSmooth("Lamps_half1",half1,Color(255,105+half1*150,105+half1*150))
    self:ShowHideSmooth("Lamps_half2",half2,Color(255,105+half2*150,105+half2*150))
    
    self:SetLightPower(23, cab > 0,cab)
    self:SetLightPower("ezh3_lamp2",cab > 0,cab)
    if not self:GetPackedBool("Lamps_half1") then
        self:SetLightPower(9,emer1 > 0,emer1*0.2+emer2*0.8)
        self:SetLightPower(10,emer2 > 0,emer2)
        self:SetLightPower(11, false)
        self:SetLightPower(12, false)
        self:SetLightPower(13, false)
    else
        self:SetLightPower(9,false)
        self:SetLightPower(10,false)
        self:SetLightPower(11, half1 > 0, half1*0.1+half2*0.9)
        self:SetLightPower(12, half1 > 0, half1*0.4+half2*0.6)
        self:SetLightPower(13, half1 > 0, half1*0.9+half2*0.1)
    end

    local HL1 = self:Animate("whitelights",self:GetPackedBool("HeadLights1") and 1 or 0,0,1,5,false)
    local HL2 = self:Animate("distantlights",self:GetPackedBool("HeadLights2") and 1 or 0,0,1,5,false)
    local RL1 = self:Animate("redlight1",self:GetPackedBool("RedLights1") and 1 or 0,0,1,5,false)
    local RL2 = self:Animate("redlight2",self:GetPackedBool("RedLights2") and 1 or 0,0,1,5,false)
    self:ShowHideSmooth("WhiteLights",HL1)
    self:ShowHideSmooth("DistantLights",HL2)
    self:ShowHideSmooth("RedLight1",RL1)
    self:ShowHideSmooth("RedLight2",RL2)
    self:SetLightPower(2,RL1 > 0, RL1)
    self:SetLightPower(3,RL2 > 0, RL2)
    self:SetLightPower(5,RL1 > 0, RL1)
    self:SetLightPower(6,RL2 > 0, RL2)
    self:SetLightPower(30,HL1 > 0, HL1)
    self:SetLightPower(31,HL1 > 0, HL1)
    self:SetLightPower(32,HL2 > 0, HL2)

    local bright = HL1*0.3+HL2*0.7
    self:SetLightPower(1,bright>0,bright)

    if IsValid(self.GlowingLights[1]) then
        if not self:GetPackedBool("HeadLights1") and self.GlowingLights[1]:GetFarZ() ~= 3144 then
            self.GlowingLights[1]:SetFarZ(3144)
        end
        if self:GetPackedBool("HeadLights1") and self.GlowingLights[1]:GetFarZ() ~= 5144 then
            self.GlowingLights[1]:SetFarZ(5144)
        end
    end

    local panel = self:Animate("L_2",self:GetPackedBool("PanelLights") and 1 or 0,0,1,5,false)
    self:ShowHideSmooth("ezh3_lamp1",panel)
    self:SetLightPower("ezh3_lamp1",panel > 0,panel)
    self:SetLightPower(22,panel > 0,panel)

    self:ShowHideSmooth("ezh3_lkvd",self:Animate("light_KVD",self:GetPackedBool("KVD") and 1 or 0,0,1,5,false))
    self:ShowHideSmooth("ezh3_lkt",self:Animate("light_KT",self:GetPackedBool("KT") and 1 or 0,0,1,5,false))
    self:ShowHideSmooth("ezh3_lrpgreen",self:Animate("Green_rp",self:GetPackedBool("GRP") and 1 or 0,0,1,5,false))
    self:ShowHideSmooth("ezh3_lrp",self:Animate("light_rRP",self:GetPackedRatio("LSN"),0,1,5,false))
    self:ShowHideSmooth("ezh3_lsd",self:Animate("light_SD",self:GetPackedBool("SD") and 1 or 0,0,1,5,false))
    self:ShowHideSmooth("ezh3_lpu",self:Animate("LPU",self:GetPackedBool("LPU") and 1 or 0,0,1,5,false))
    ---ARS
    self:ShowHideSmooth("ezh3_loch",self:Animate("light_OCh",self:GetPackedBool("AR04") and 1 or 0,0,1,5,false))
    self:ShowHideSmooth("ezh3_l0",self:Animate("light_0",self:GetPackedBool("AR0") and 1 or 0,0,1,5,false))
    self:ShowHideSmooth("ezh3_l40",self:Animate("light_40",self:GetPackedBool("AR40") and 1 or 0,0,1,5,false))
    self:ShowHideSmooth("ezh3_l60",self:Animate("light_60",self:GetPackedBool("AR60") and 1 or 0,0,1,5,false))
    self:ShowHideSmooth("ezh3_l80",self:Animate("light_80",self:GetPackedBool("AR80") and 1 or 0,0,1,8,false))
    self:ShowHideSmooth("ezh3_l70",self:Animate("light_70",self:GetPackedBool("AR70") and 1 or 0,0,1,6,false))

    self:Animate("PB",self:GetPackedBool("PB") and 0 or 1,0,0.2,  12,false)
    self:Animate("UAVALever",   self:GetPackedBool("UAVA") and 1 or 0,     0,0.6, 128,  3,false)
    self:Animate("brake_disconnect",self:GetPackedBool("DriverValveBLDisconnect") and 1 or 0,0.5,0,  4,false)
    self:Animate("train_disconnect",self:GetPackedBool("DriverValveTLDisconnect") and 1 or 0,0.5,0,  4,false)
    self:Animate("EPK_disconnect",self:GetPackedBool("EPK") and 1 or 0,0.5,0,  3,false)
    self:Animate("EmergencyBrakeValve", self:GetPackedBool("EmergencyBrakeValve") and 1 or 0,0.5,0, 7, false)

    self:Animate("brake",self:GetPackedRatio("CranePosition"),0.06, 0.39,5000,100)
    self:AnimateFrom("brake334","brake",-0.05, 1.1)
    self:Animate("controller",self:GetNW2Int("ControllerPosition")/7, 0.38, 0.04,  2,false)
    self:Animate("reverser",self:GetPackedRatio("ReverserPosition"),0.6, 0.4,  4,false)
    self:Animate("rcureverser",self:GetPackedBool("RCUPosition") and 1 or 0,0.77,0,3,false)
    self:Animate("krureverser",self:GetNW2Int("KRUPosition")/3,0.6,1,3,false)

    self:ShowHide("reverser",self:GetNW2Int("WrenchMode",0)==1)
    self:ShowHide("krureverser",self:GetNW2Int("WrenchMode",0)==2)
    self:ShowHide("rcureverser",self:GetNW2Int("WrenchMode",0)==3)


    self:ShowHide("rum_wrench",self.RUMResetTime and CurTime()-self.RUMResetTime<1.5)
    if IsValid(self.ClientEnts.rum_wrench) and self.Anims.RUMToggle then
        self.ClientEnts.rum_wrench:SetPoseParameter("position",1-self.Anims.RUMToggle.value)
    end
    if self.LastRUMValue ~= self:GetPackedBool("RUM") then
        self.RUMResetTime = CurTime()+1.5
        self.LastRUMValue = self:GetPackedBool("RUM")
    end

    ---Animate brakes
    self:Animate("brake_line",self:GetPackedRatio("BLPressure"), 0.044, 0.778,  256,3)--,,0.01)
    self:Animate("train_line",self:GetPackedRatio("TLPressure"), 0.044, 0.778,  256,2)--,,0.01)
    self:Animate("brake_cylinder",self:GetPackedRatio("BCPressure"), 0.052, 0.794,nil,2)--,,0.03)
    self:Animate("voltmeter",self:GetPackedRatio("EnginesVoltage"), 0.632,0.36,92,2)
    self:Animate("ampermeter",self:GetPackedRatio("EnginesCurrent"), 0.632,0.36,nil, nil,92,20,3)
    self:Animate("volt1",self:GetPackedRatio("BatteryVoltage"),0.613,0.455,72,2)
    self:Animate("speed1",self:GetPackedRatio("Speed"),0.645, 0.363, nil, nil,  90,200,20)


    local door2 = self:Animate("door2", self:GetPackedBool("RearDoor") and 0.99 or 0,0,0.25, 8, 1)
    local door1 = self:Animate("door1", self:GetPackedBool("FrontDoor") and 0.99 or 0,0,0.22, 8, 1)
    local door3 = self:Animate("door3", self:GetPackedBool("PassengerDoor") and 0.99 or 0,1,0.62, 8, 1)
    local door4 = self:Animate("door4", self:GetPackedBool("CabinDoor") and 0.99 or 0,1,0.78, 8, 1)

    if self.Door1 ~= (door1 > 0) then
        self.Door1 = door1 > 0
        self:PlayOnce("door1","bass",self.Door1 and 1 or 0)
    end
    if self.Door2 ~= (door2 > 0) then
        self.Door2 = door2 > 0
        self:PlayOnce("door2","bass",self.Door2 and 1 or 0)
    end
    if self.Door3 ~= (door3 < 1) then
        self.Door3 = door3 < 1
        self:PlayOnce("door3","bass",self.Door3 and 1 or 0)
    end
    if self.Door4 ~= (door4 < 1) then
        self.Door4 = door4 < 1
        self:PlayOnce("door4","bass",self.Door4 and 1 or 0)
    end

    self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,1, 3, false)
    self:Animate("FrontTrain",  self:GetNW2Bool("FtI") and 1 or 0,0,1, 3, false)
    self:Animate("RearBrake",   self:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    self:Animate("RearTrain",   self:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)

    -- Main switch
    if self.LastGVValue ~= self:GetPackedBool("GV") then
        self.ResetTime = CurTime()+1.5
        self.LastGVValue = self:GetPackedBool("GV")
    end
    self:Animate("gv_wrench",self.LastGVValue and 1 or 0,0.5,0.9,128,1,false)
    self:ShowHideSmooth("gv_wrench",    CurTime() < self.ResetTime and 1 or 0.1)

    -- Animate doors
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
            --local dro = 1
            if self.Anims[n_l] then
                dlo = math.abs(state-(self.Anims[n_l] and self.Anims[n_l].oldival or 0))
                if dlo <= 0 and self.Anims[n_l].oldspeed then dlo = self.Anims[n_l].oldspeed/14 end
            end
            self:Animate(n_l,state,0,1, dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
            --self:Animate(n_r,state,0,1, dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
        end
    end

     -- Brake-related sounds
    local dT = self.DeltaTime
    --self.TunnelCoeff = 0.8
    --self.StreetCoeff = 0
    local rollingi = math.min(1,self.TunnelCoeff+math.Clamp((self.StreetCoeff-0.82)/0.3,0,1))
    local rollings = math.max(self.TunnelCoeff*1,self.StreetCoeff)
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
    self:SetSoundState("rolling_80",rollingi*rol80,rol80p)

    local rol_motors = math.Clamp((speed-20)/40,0,1)
    self:SetSoundState("rolling_motors",math.max(rollingi,rollings*0.3)*rol_motors,speed/56)

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

    self.FrontLeak = math.Clamp(self.FrontLeak + 10*(-self:GetPackedRatio("FrontLeak")-self.FrontLeak)*dT,0,1)
    self.RearLeak = math.Clamp(self.RearLeak + 10*(-self:GetPackedRatio("RearLeak")-self.RearLeak)*dT,0,1)
    self:SetSoundState("front_isolation",self.FrontLeak,0.9+0.2*self.FrontLeak)
    self:SetSoundState("rear_isolation",self.RearLeak,0.9+0.2*self.RearLeak)

    self.CraneRamp = math.Clamp(self.CraneRamp + 8.0*((1*self:GetPackedRatio("Crane_dPdT",0))-self.CraneRamp)*dT,-1,1)
    self:SetSoundState("crane334_brake_low",math.Clamp((-self.CraneRamp)*2,0,1)^2,1)
    local high = math.Clamp(((-self.CraneRamp)-0.5)/0.5,0,1)^1
    self:SetSoundState("crane334_brake_high",high,1.0)
    self:SetSoundState("crane013_brake2",high*2,1.0)
    self:SetSoundState("crane334_brake_eq_high",--[[ math.Clamp(-self.CraneRamp*0,0,1)---]] math.Clamp(-self:GetPackedRatio("ReservoirPressure_dPdT")-0.2,0,1)^0.8*1,1)
    self:SetSoundState("crane334_brake_eq_low",--[[ math.Clamp(-self.CraneRamp*0,0,1)---]] math.Clamp(-self:GetPackedRatio("ReservoirPressure_dPdT")-0.4,0,1)^0.8*1.3,1)

    self:SetSoundState("crane334_release",math.Clamp(self.CraneRamp,0,1)^2,1.0)

    local emergencyValveEPK = self:GetPackedRatio("EmergencyValveEPK_dPdT",0)
    self.EmergencyValveEPKRamp = math.Clamp(self.EmergencyValveEPKRamp + 1.0*((0.5*emergencyValveEPK)-self.EmergencyValveEPKRamp)*dT,0,1)
    if self.EmergencyValveEPKRamp < 0.01 then self.EmergencyValveEPKRamp = 0 end
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
    self:SetSoundState("valve_brake",self.EmergencyBrakeValveRamp,0.8+self.EmergencyBrakeValveRamp*0.4)

    local emergencyValve = self:GetPackedRatio("EmergencyValve_dPdT", 0)^0.4*1.2
    self.EmergencyValveRamp = math.Clamp(self.EmergencyValveRamp + (emergencyValve-self.EmergencyValveRamp)*dT*16,0,1)
    local emer_brake = math.Clamp((self.EmergencyValveRamp-0.9)/0.05,0,1)
    local emer_brake2 = math.Clamp((self.EmergencyValveRamp-0.2)/0.4,0,1)*(1-math.Clamp((self.EmergencyValveRamp-0.9)/0.1,0,1))
    self:SetSoundState("emer_brake",emer_brake,1)
    self:SetSoundState("emer_brake2",emer_brake2,math.min(1,0.8+0.2*emer_brake2))

    -- Compressor
    local compressorvoltage = Lerp(self:GetPackedRatio("LampsStrength"),0.75,1.05)
    local compressorb = self:GetPackedBool("AV") and compressorvoltage or 1
    local compressorspeed = self:GetPackedBool("VB") and compressorb or 0
    local state = self:GetPackedBool("Compressor")
    self:SetSoundState("compressor",state and 0.6 or 0,compressorspeed or 0)

    -- ARS/ringer alert
    self:SetSoundState("ring",self:GetPackedBool("RingEnabled") and 1 or 0,1)

    self:SetSoundState("vpr",self:GetPackedBool("VPR") and 1 or 0,1)

    self:SetSoundState("rt300",self:GetPackedBool("RT300") and 1 or 0,1)


    -- RK rotation
    if self:GetPackedBool("RK") then self.RKTimer = CurTime() end
    state = (CurTime() - (self.RKTimer or 0)) < 0.2
    self.PreviousRKState = self.PreviousRKState or false
    if self.PreviousRKState ~= state then
        self.PreviousRKState = state
        if state then
            self:SetSoundState("rk",0.7,1)
        else
            self:SetSoundState("rk",0,0)
        end
    end

    local cabspeaker = self:GetPackedBool("AnnCab")
    local work = self:GetPackedBool("AnnPlay")
    local noise = self:GetNW2Int("AnnouncerBuzz",-1) > 0
    self.NoiseVolume = self.NoiseVolume or 0
    self.AnnLamp = self.AnnLamp or 0

    --if self.AnnVolume > annvolume then
    --[[ else
        self.AnnVolume = math.Clamp(self.AnnVolume + 0.5*(annvolume-self.AnnVolume)*dT,0.1,1)
    end--]]

    local noisevolume = 1
    if work and self.Sounds["announcer1"] and IsValid(self.Sounds["announcer1"]) then noisevolume = (1-(self.Sounds["announcer1"]:GetLevel())*math.Rand(0.9,3))*1 end
    if self.NoiseVolume > noisevolume then
        self.NoiseVolume = math.Clamp(self.NoiseVolume + 8*(noisevolume-self.NoiseVolume)*dT,0.1,1)
    else
        self.NoiseVolume = math.Clamp(self.NoiseVolume + 0.5*(noisevolume-self.NoiseVolume)*dT,0.1,1)
    end
    local annvolume = self.Sounds.announcer1 and IsValid(self.Sounds.announcer1) and self.Sounds.announcer1:GetLevel()*math.Rand(0.9,3) or 0

    local lamp = math.max(annvolume,noise and self.NoiseVolume or 0)

    self.AnnLamp = math.Clamp(self.AnnLamp + 8*(lamp-self.AnnLamp)*dT,0,1)
    if self.AnnLamp < 0.01 then self.AnnLamp=0 end
    for k,v in ipairs(self.AnnouncerPositions) do
        for i=1,2 do
            self:SetSoundState(Format("announcer_noise%d_%d",i,k),noise and (k ~= 1 and work or k==1 and cabspeaker) and self.NoiseVolume*(v[3] or 1) or 0,1)
        end
        if IsValid(self.Sounds["announcer"..k]) then self.Sounds["announcer"..k]:SetVolume((k ~= 1 and work or k==1 and cabspeaker) and (v[3] or 1) or 0) end
    end
end

function ENT:OnAnnouncer(volume, id)
    local cabspeaker = self:GetPackedBool("AnnCab")
    local work = self:GetPackedBool("AnnPlay")
    return (id ~= 1 and work or id == 1 and cabspeaker) and volume  or 0
end

function ENT:Draw()
    self.BaseClass.Draw(self)
end
function ENT:DrawPost()
    self.RTMaterial:SetTexture("$basetexture", self.IGLA)
    self:DrawOnPanel("IGLA",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(256,64+22,512,128+22,0)
    end)

    self.RTMaterial:SetTexture("$basetexture", self.ASNP)
    self:DrawOnPanel("ASNPScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(256,64,512,128,0)
    end)

    self:DrawOnPanel("AirDistributor",function()
        draw.DrawText(self:GetNW2Bool("AD") and "Air Distributor ON" or "Air Distributor OFF","Trebuchet24",0,0,Color(0,0,0,255))
    end)
    if true or self.CurrentCamera == 5 then
        self.RTMaterial:SetTexture("$basetexture", self.RRIScreen)
        self:DrawOnPanel("RRIScreen",function(...)
            surface.SetMaterial(self.RTMaterial)
            surface.SetDrawColor(255,255,255)
            surface.DrawTexturedRectRotated(64,64,128,128,0)
        end)
        self.RRI.CanDraw = true
    end
end

function ENT:OnButtonPressed(button)
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
        if soundid == "LK2" then
            local speed = self:GetPackedRatio("Speed")
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
        if soundid == "RVT" then
            return range > 0 and "rvt_on" or "rvt_off",location,1,pitch
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
        if soundid == "K25" then
            return range > 0 and "k25_on" or "k25_off",location,1,pitch
        end
        if soundid == "KK" then
            return range > 0 and "kk_on" or "kk_off",location,1,pitch--0.8
        end
        if soundid == "RO" then
            return range > 0 and "ro_on" or nil,location,1,pitch
        end
        if soundid == "AVU" then
            return range > 0 and "avu_on" or "avu_off",location,1,0.9
        end
        if soundid == "brake" then
            self:PlayOnce("brake_f",location,range,pitch)
            self:PlayOnce("brake_b",location,range,pitch)
            return
        end
        if soundid == "UAVAC" then
            return "uava_reset",location,range,pitch
        end
    end
    return soundid,location,range,pitch
end

Metrostroi.GenerateClientProps()

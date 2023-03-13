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

---Вагон типа Е
--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.AutoAnimNames = {}
ENT.ClientSounds = {}

ENT.ButtonMap["PanelLamp"] = {
    pos = Vector(443.5,-57.31,42),
    ang = Angle(180,275,-5),
    width = 100,
    height = 200,
    scale = 0.0588,

    buttons = {
        {ID = "PanelLampToggle", x=0, y=0, w=100, h=200, tooltip="",var="PanelLights"},
    }
}

-- Main panel
ENT.ButtonMap["Main"] = {
    pos = Vector(452.4-0.3,-30.1-1,-7.29+0.15),
    ang = Angle(0,-90,90-20),
    width = 315,
    height = 240,
    scale = 0.0588,
    hideseat=0.2,

    buttons = {
        ----Лампы
        --{ID = "RK",           x=41.0+41.7*2,y=58.4, radius=20, tooltip="", model = {
        --  lamp = {model = "models/metrostroi_train/81-703/cabin_lamp_red2.mdl",color = Color(255,160,160),z = 10, var="RK"}
        --}},
        {ID = "PP1",            x=42.0+41.7*0,y=58.3, radius=20, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-703/cabin_lamp_green.mdl",color = Color(98,178,178),z = 10, var="PP1"},
            sprite = {bright=0.25,size=0.25,scale=0.07,color=Color(40,255,100),z=12,}
        }},
        {ID = "PP6",            x=42.5+41.7*1,y=58.3, radius=20, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-703/cabin_lamp_white.mdl",color = Color(178,126,84),z = 10, var="PP6"},
            sprite = {bright=0.25,size=0.25,scale=0.07,color=Color(255,180,160),z=12,}
        }},
        {ID = "RRP",            x=42.0+41.7*2,y=58.3, radius=20, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-703/cabin_lamp_red3.mdl",color = Color(178,112,112),z = 10, var="RRP", getfunc = function(ent,min,max) return ent:GetPackedRatio("RRP") end},
            sprite = {bright=0.25,size=0.25,scale=0.07,color=Color(255,60,60),z=12,}
        }},
        {ID = "GRP",            x=41.0+41.7*3,y=58.3, radius=20, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-703/cabin_lamp_green.mdl",color = Color(98,178,178),z = 10, var="GRP"},
            sprite = {bright=0.25,size=0.25,scale=0.07,color=Color(40,255,100),z=12,}
        }},
        {ID = "SD",         x=41.3+41.7*4,y=58.3, radius=20, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-703/cabin_lamp_white.mdl",color = Color(91,91,178),z = 10, var="SD",},
            sprite = {bright=0.25,size=0.25,scale=0.07,color=Color(100,120,255),z=12,}
        }},
        {ID = "SDW",         x=40.9+41.7*5,y=58.3, radius=20, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-703/cabin_lamp_white.mdl",color = Color(178,126,112),z = 10, var="SDW",},
            sprite = {bright=0.25,size=0.25,scale=0.07,color=Color(255,180,160),z=12,}
        }},
        ----Кнопки
        {   ID = "KU4Set",  x=35.8+44*0, y=127.3, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-703/cabin_button_black.mdl",ang = 180,z=2,
            var="KU4",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button1_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {   ID = "KU5Set",  x=35.8+44*1, y=127.3, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-703/cabin_button_black.mdl",ang = 180,z=2,
            var="KU5",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button3_on" or "button1_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {   ID = "KU9Set",  x=35.8+44*2, y=127.3, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-703/cabin_button_black.mdl",ang = 180,z=2,
            var="KU9",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button1_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {   ID = "KU8Set",  x=35.8+44*3, y=127.3, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-703/cabin_button_red.mdl",ang = 180,z=2,
            var="KU8",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button1_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {   ID = "KU10Set", x=195.5, y=171.8, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-703/cabin_button_red.mdl",ang = 180,z=2,
            var="KU10",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {   ID = "KU11Set", x=35.8+44*4, y=127.3, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-703/cabin_button_black.mdl",ang = 180,z=2,
            var="KU11",speed=16,vmin=0,vmax=1,
            sndvol = 0.10, snd = function(val) return val and "button1_on" or "button1_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {   ID = "KU7Set",  x=35.8+44*5, y=127.3, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-703/cabin_button_red.mdl",ang = 180,z=2,
            var="KU7",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {   ID = "KU7KToggle", x=35.8+44*5, y=127.3-34, radius=15, tooltip="", model = {
            model = "models/metrostroi_train/81-703/cabin_doors_cover.mdl",ang = 110,z=11,vmin=0.21,vmax=0.0,
            var="KU7K",speed=1.5,disableinv="KU7Set",
            sndvol = 0.10, snd = function(val) return val and "kr_left" or "kr_right" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            varTooltip = true,
        }},
        {   ID = "KU6Set",  x=96.8, y=171.8, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-703/cabin_button_black.mdl",ang = 180,z=2,
            var="KU6",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {   ID = "KU6KToggle", x=96.8+5, y=171.8-34, radius=15, tooltip="", model = {
            model = "models/metrostroi_train/81-703/cabin_doors_cover.mdl",ang = 180-10,z=11,vmin=0,vmax=0.21,
            var="KU6K",speed=1.5,disableinv="KU6Set",
            sndvol = 0.10, snd = function(val) return val and "kr_left" or "kr_right" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            varTooltip = true,
        }},
        {   ID = "KU1Toggle",   x=49,y=190,radius=20, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudblack.mdl", z=-19,
            var="KU1",speed=6, vmin=1,vmax=0,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {   ID = "KU2Toggle",   x=245,y=190,radius=20, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudblack.mdl", z=-19,
            var="KU2",speed=6, vmin=1,vmax=0,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Unlocked","Train.Buttons.Locked"},
        }},
        {   ID = "KU12Toggle",  x=145,y=190,radius=20, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudblack.mdl", z=-19,
            var="KU12",speed=6, vmin=1,vmax=0,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}

local function addTW10Cosume(panelName,ignores)
    for _,button in pairs(ENT.ButtonMap[panelName].buttons) do
        if not button.model or not button.model.lamp then continue end
        if not table.HasValue(ignores or {},button.ID) then
            local rand1 = 0.1
            local rand2 = math.Rand(0.6,3.5)
            if button.model.lamp.getfunc then
                local oldgetfunc = button.model.lamp.getfunc
                button.model.lamp.getfunc = function(ent,vmin,vmax,var)
                    return (rand1+ent:GetPackedRatio("LampsCount")^rand2)*oldgetfunc(ent,vmin,vmax,var)
                end
            else
                button.model.lamp.getfunc = function(ent,_,_,var) return ent:GetPackedBool(var) and rand1+ent:GetPackedRatio("LampsCount")^rand2 or 0 end
            end
        end

    end
end

addTW10Cosume("Main")

--VU Panel
ENT.ButtonMap["VU"] = {
    pos = Vector(456,-17.80,20),
    ang = Angle(0,270,90),
    width = 70,
    height = 100,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {   ID = "VUToggle",    x=0, y=0, w=70, h=100, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            var="VU",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}

ENT.ButtonMap["VU4"] = {
    pos = Vector(459,25.15-1,36.5),
    ang = Angle(0,270,90),
    width = 100,
    height = 220,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {   ID = "KU16Toggle",  x=0, y=110, w=100, h=110, tooltip="", model = {
            model = "models/metrostroi_train/81-702/buttons/vu_13b.mdl", z=20, ang=Angle(-90,0,0),
            var="KU16",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu13a_on" or "vu13a_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}


ENT.ButtonMap["Stopkran"] = {
    pos = Vector(459,27,20.7),
    ang = Angle(0,-90,90),
    width = 200,
    height = 1300,
    scale = 0.1/2,
    buttons = {
        {ID = "EmergencyBrakeValveToggle",x=0, y=0, w=200, h=1300, tooltip="", tooltip="",tooltip="",states={"Train.Buttons.Closed","Train.Buttons.Opened"},var="EmergencyBrakeValve"},
    }
}
ENT.ClientProps["stopkran"] = {
    model = "models/metrostroi_train/81-717/stop_mvm.mdl",
    pos = Vector(456,21.2,13),
    ang = Angle(0,270,0),
    hide = 0.8,
}

ENT.ButtonMap["AVMain"] = {
    pos = Vector(397.5-0.4,38.8-1,36),
    ang = Angle(0,90,90),
    width = 335,
    height = 380,
    scale = 0.0625,
    hide=0.8,

    buttons = {
            {ID = "AVToggle", x=0, y=0, w=300, h=380, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_av8r.mdl", z=80, ang = Angle(90,0,0),
            var="AV",speed=0.85, vmin=0.73,vmax=0.80,
            sndvol = 1, snd = function(val) return val and "av8_on" or "av8_off" end,
        }},
    }
}


---AV1 Panel
ENT.ButtonMap["AV1"] = {
    pos = Vector(397.5,41,18),
    ang = Angle(0,90,90),
    width = 290+0,
    height = 155,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "VU3Toggle", x=0, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            var="VU3",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "VU2Toggle", x=110, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            var="VU2",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "VU1Toggle", x=220, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            var="VU1",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}

ENT.ClientProps["tab"] = {
    model = "models/metrostroi_train/Equipment/tab.mdl",
    pos = Vector(12.0-0.4,0,-2),
    ang = Angle(0,0,0),
    skin = 0,
    hide = 2,
}

ENT.ButtonMap["AV2"] = {
    pos = Vector(397.5-0.4,25.40-1,31.1),
    ang = Angle(0,90,90),
    width = 180,
    height = 136,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "RSTToggle", x=0, y=0, w=100, h=136, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=3,ang=90,z=20.9,x=0,y=-12.5}},
            var="RST",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
}
}

-- Battery panel
ENT.ButtonMap["Battery"] = {
    pos = Vector(398.98-0.4,23.24-1,22.5),
    ang = Angle(0,90,90),
    width = 250,
    height = 160,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "VBToggle", x=0, y=0, w=250, h=160, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_brown_3.mdl", z=15, ang = 180,
            var="VB",speed=6,
            sndvol = 0.8, snd = function(val) return val and "vu223_on" or "vu223_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}



-- Parking brake panel
ENT.ButtonMap["ParkingBrake"] = {
    pos = Vector(448,45.5,-2.0),
    ang = Angle(0,-83,90),
    width = 340,
    height = 400,
    scale = 0.0625,

    buttons = {
        {ID = "ParkingBrakeLeft",x=0, y=0, w=170, h=400, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.ParkingBrake"),ent:GetPackedRatio("ManualBrake")*100) end},
        {ID = "ParkingBrakeRight",x=170, y=0, w=170, h=400, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.ParkingBrake"),ent:GetPackedRatio("ManualBrake")*100) end},
    }
}

-- Train driver helpers panel
ENT.ButtonMap["HelperPanel"] = {
    pos = Vector(446.8,59.2,23),
    ang = Angle(0,-53,90),
    width = 60,
    height = 250,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "KU13Set",             x=0, y=0, w=60,h=100, tooltip="", model = {
            model = "models/metrostroi_train/81-702/buttons/vu_13b.mdl", z=17, ang=Angle(-90,0,0),
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=9,ang=90,z=10,x=0,y=-13.5}},
            var="KU13",speed=6,
            sndvol = 1, snd = function(val) return val and "vu13a_on" or "vu13a_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "KU3Toggle",           x=0, y=110, w=60,h=100, tooltip="", model = {
            model = "models/metrostroi_train/81-702/buttons/vu_13b.mdl", z=17, ang=Angle(-90,0,0),
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=10,ang=90,z=10,x=0,y=-13.5}},
            var="KU3",speed=6,
            sndvol = 1, snd = function(val) return val and "vu13a_on" or "vu13a_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Unlocked","Train.Buttons.Locked"},
        }},
        {ID = "R_Program1Set",  x=14, y=235, radius=15, tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = 0,
            labels={{model="models/metrostroi_train/81-702/labels/vu_labels.mdl",skin=7,ang=90,z=2,x=0,y=-24}},
            var="R_Program1",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button3_off" end,
            sndmin = 60,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "R_Program2Set",  x=46, y=235, radius=15, tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = 0,
            labels={{model="models/metrostroi_train/81-702/labels/vu_labels.mdl",skin=8,ang=90,z=2,x=0,y=-24}},
            var="R_Program2",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button3_off" end,            sndmin = 60,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}


ENT.ButtonMap["HVMeters"] = {
    pos = Vector(450.5,-56.7,34.5),
    ang = Angle(0,-150,90),
    width = 64,
    height = 128,
    scale = 0.0625,

    buttons = {
        {ID = "!EnginesCurrent", x=0, y=0, w=64, h=60, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesCurrent"),ent:GetPackedRatio("EnginesCurrent")*1000-500) end},
        {ID = "!EnginesVoltage", x=0, y=68, w=64, h=60, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesVoltage"),ent:GetPackedRatio("EnginesVoltage")*1000) end},
    }
}
ENT.ButtonMap["Speedometer"] = {
    pos = Vector(451.2,-51.7,22.5),
    ang = Angle(0,-148,89),
    width = 150,
    height = 150,
    scale = 0.0625,

    buttons = {
        {ID = "!Speedometer", x=0, y=0, w=150, h=150, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.Speed"),ent:GetPackedRatio("Speed")*100) end},
    }
}
ENT.ButtonMap["BLTLPressure"] = {
    pos = Vector(452.4,-53.4,10.5),
    ang = Angle(0,-138,90),
    width = 114,
    height = 114,
    scale = 0.0625,

    buttons = {
        {ID = "!BLTLPressure", x=57,y=57,radius=57,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BLTLPressure"),ent:GetPackedRatio("TLPressure")*16,ent:GetPackedRatio("BLPressure")*16) end},
    }
}
ENT.ButtonMap["BCPressure"] = {
    pos = Vector(453,-50.2,4.2),
    ang = Angle(0,-100,90),

    width = 78,
    height = 78,
    scale = 0.0625,

    buttons = {
        {ID = "!BCPressure", x=39,y=39,radius=39,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BCPressure"),ent:GetPackedRatio("BCPressure")*6) end},
    }
}
ENT.ButtonMap["BatteryVoltage"] = {
    pos = Vector(455.6,-18,10.8),
    ang = Angle(0,270,90),
    width = 60,
    height = 60,
    scale = 0.0625,

    buttons = {
        {ID = "!BatteryVoltage", x=0,y=0,w=60,h=60,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BatteryVoltage"),ent:GetPackedRatio("BatteryVoltage")*150) end},
    }
}


ENT.ButtonMap["DriverValveBLDisconnect"] = {
    pos = Vector(443.5,-53,-37.61),
    ang = Angle(-90,0,0),
    width = 200,
    height = 90,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveBLDisconnectToggle", x=0, y=0, w=200, h=90, tooltip="", model = {
            var="DriverValveBLDisconnect",sndid="brake_disconnect",
            sndvol = 1, snd = function(val) return "disconnect_valve" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
    }
}
ENT.ButtonMap["DriverValveTLDisconnect"] = {
    pos = Vector(447,-48,-31),
    ang = Angle(-90,-10,0),
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

ENT.ButtonMap["FrontPneumatic"] = {
    pos = Vector(463,-45.0,-58.0),
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
    pos = Vector(450+10, -30, -69),
    ang = Angle(0,-90,0),
    hide = 0.5,
}
ENT.ClientProps["FrontTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(450+10, 31, -69),
    ang = Angle(0,-90,0),
    hide = 0.5,
}
ENT.ClientSounds["FrontBrakeLineIsolation"] = {{"FrontBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["FrontTrainLineIsolation"] = {{"FrontTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ButtonMap["RearPneumatic"] = {
    pos = Vector(-473+6,45.0,-58.0),
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
    pos = Vector(-450-14, -30, -69),
    ang = Angle(0,90,0),
    hide = 0.5,
}
ENT.ClientProps["RearBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(-450-14, 31, -69),
    ang = Angle(0,90,0),
    hide = 0.5,
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
    pos = Vector(453-5,56,-3),
    ang = Angle(0,-70,90),
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
end
for i=0,3 do
    ENT.ClientProps["TrainNumberR"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(295+i*6.6-4*6.6/2,-66.4,-26),
        ang = Angle(0,0,0),
        skin=0,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end
ENT.ButtonMap["FrontDoor"] = {
    pos = Vector(460.7,16-1,40),
    ang = Angle(0,-90,90),
    width = 650,
    height = 1850,
    scale = 0.1/2,
    buttons = {
        {ID = "FrontDoor",x=0,y=0,w=650,h=1850, tooltip="", model = {
            var="door1",sndid="door1",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}

ENT.ButtonMap["CabinDoor"] = {
    pos = Vector(411,66,40),
    ang = Angle(0,0,90),
    width = 642,
    height = 1850,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoor",x=0,y=0,w=642,h=1850, tooltip="", model = {
            var="door4",sndid="door4",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}

ENT.ButtonMap["PassengerDoor"] = {
    pos = Vector(395.2,-16,37),
    ang = Angle(0,90,90),
    width = 642,
    height = 1850,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=642,h=1850, tooltip="", model = {
            var="door3",sndid="door3",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
ENT.ButtonMap["PassengerDoor2"] = {
    pos = Vector(395.2,16,37),
    ang = Angle(0,-90,90),
    width = 642,
    height = 1850,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=642,h=1850, tooltip=""},
    }
}

ENT.ButtonMap["RearDoor"] = {
    pos = Vector(-464,-16,37),
    ang = Angle(0,90,90),
    width = 650,
    height = 1850,
    scale = 0.1/2,
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=650,h=1850, tooltip="", model = {
            var="door2",sndid="door2",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false
if not ENT.ClientSounds["br_334"] then ENT.ClientSounds["br_334"] = {} end
table.insert(ENT.ClientSounds["br_334"],{"brake",function(ent,_,var) return "br_334_"..var end,1,1,50,1e3,Angle(-90,0,0)})
ENT.ClientProps["brake"] = {
    model = "models/metrostroi_train/81-703/cabin_cran_334.mdl",
    pos = Vector(448.91,-52.62,-4.37),
    ang = Angle(0.000000,-133.000000,0.000000),
    hideseat = 0.2,
}



ENT.ClientProps["controller"] = {
    model = "models/metrostroi_train/81-707/kv_ezh.mdl",
    pos = Vector(450.6,-22.73,-5.90),
    ang = Angle(0,180+15,0),
    hideseat = 0.2,
}

ENT.ClientProps["reverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["controller"].pos+Vector(0,0,-0.8),
    ang = Angle(180,90,180),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientProps["rcureverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["controller"].pos+Vector(-4.6,-0.1,-1.5),
    ang = Angle(180,180-20,180),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientProps["brake_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran1.mdl",
    pos = Vector(447.2-4.7,-58.5+2.0,-34),
    ang = Angle(7,88,-90),
    hideseat = 0.2,
}
ENT.ClientProps["train_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran3.mdl",
    pos = Vector(450.4-4.5,-54.35+2.55,-27.45),
    ang = Angle(92,-100,90),
    hideseat = 0.2,
}
ENT.ClientProps["parking_brake"] = {
    model = "models/metrostroi_train/81-703/cabin_parking.mdl",
    pos = Vector(449.735626,35.158592,-14.843545),
    ang = Angle(-90.000000,8.000000,0.000000),
    hideseat = 0.2,
}


--------------------------------------------------------------------------------
ENT.ClientProps["train_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_e_nm.mdl",
    pos = Vector(450.183258,-56.169998,5.598449),
    ang = Angle(170.000000,-138.000000,90.000000),
    hideseat = 0.2,
}

ENT.ClientProps["brake_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_e_tm.mdl",
    pos = Vector(450.149994,-56.150002,5.526259),
    ang = Angle(170.000000,-138.000000,90.000000),
    hideseat = 0.2,
}

ENT.ClientProps["brake_cylinder"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(453.210052,-52.644321,1.665846),
    ang = Angle(-124.500000,78.000000,-90.000000),
    hideseat = 0.2,
}

----------------------------------------------------------------
ENT.ClientProps["voltmeter"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(448.880005,-57.949409,27.453575),
    ang = Angle(-90.000000,0.000000,-59.500000),
    hideseat = 0.2,
}

ENT.ClientProps["ampermeter"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(448.904572,-57.946339,31.797873),
    ang = Angle(-90.000000,0.000000,-59.500000),
    hideseat = 0.2,
}


ENT.ClientProps["volt1"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(455.646423,-19.933491,7.878962),
    ang = Angle(-90.000000,0.000000,0.000000),
    hideseat = 0.2,
}


ENT.ClientProps["speed1"] = {
    model = "models/metrostroi_train/Equipment/arrow_voltmeter_old.mdl",
    pos = Vector(445.700012,-56.200001,15.704302),
    ang = Angle(90.000000,125.038704,2.903226),
    hideseat = 0.2,
}
ENT.ClientProps["salon"] = {
    model = "models/metrostroi_train/81-703/703_salon.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2.0,
}
ENT.ClientProps["E_informator"] = {
    model = "models/metrostroi_train/equipment/rri_informator_portable.mdl",
    pos = Vector(404.7-5.1,-51,1),
    ang = Angle(0,0,0),
    hideseat=0.2,
}
ENT.ClientProps["fireextinguisher"] = {
    model = "models/metrostroi_train/81-502/fireextinguisher.mdl",
    pos = Vector(-10,107,0),
    ang = Angle(0,0,0),
    hideseat = 2,
}
ENT.ClientProps["sunprotectors"] = {
    model = "models/metrostroi_train/81-502/sun_protectors.mdl",
    pos = Vector(-8,0,0),
    ang = Angle(0,0,0),
    hide = 2,
}
ENT.ButtonMap["RRI"] = {
    pos = ENT.ClientProps["E_informator"].pos+Vector(-0.6,-0.5,5),
    ang = Angle(0,90,0),
    width = 60,
    height = 25,
    scale = 0.0625,
    hideseat=0.2,

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
            lamp = { model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=62,x=-0.3,y=-0.3,z=20.6, var="RRIOn", color=Color(210,170,255), getfunc=function(ent,min,max,var) return ent:GetPackedBool(var) and (1-(ent.AnnLamp or 0)^1.5*0.6) or 0 end, },
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(210,170,255)},
        }},
    }
}
ENT.ButtonMap["RRIScreen"] = {
    pos = ENT.ClientProps["E_informator"].pos+Vector(1.95,-2.9,5),
    ang = Angle(0,90,90),
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


ENT.ClientProps["mirrors"] = {
    model = "models/metrostroi_train/81-502/mirrors_ema.mdl",
    pos = Vector(-7.7,0,0),
    ang = Angle(0,0,0),
    hide = 2.0,
}
ENT.ClientProps["salon3"] = {
    model = "models/metrostroi_train/81-703/703_cabine.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["salon2"] = {
    model = "models/metrostroi_train/81-703/81-703_Underwagon.mdl",
    pos = Vector(-23.5,0,-191),
    ang = Angle(0,0,0),
    hide=2,
}

ENT.ClientProps["Lamps_cab1"] = {
    model = "models/metrostroi_train/81-502/cabin_lamp_light.mdl",
    pos = Vector(-5.556452,-0.075187,0.965615),
    ang = Angle(0,0,0),
    hide = 0.8,
}
ENT.ClientProps["Lamps_pult"] = {
    model = "models/metrostroi_train/equipment/lamp_gauges.mdl",
    pos = Vector(446.027-9.5,-55.398,42.27),
    ang = Angle(-4.305,6.175,8),
    hideseat = 0.2,
}
ENT.ClientProps["Lamps_emer1"] = {
    model = "models/metrostroi_train/81-703/lights_emer2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 1.5,
}
ENT.ClientProps["Lamps_emer2"] = {
    model = "models/metrostroi_train/81-703/lights_emer.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 1.5,
}
ENT.ClientProps["Lamps_half1"] = {
    model = "models/metrostroi_train/81-703/lights_group1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["Lamps_half2"] = {
    model = "models/metrostroi_train/81-703/lights_group2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["Lamp_RTM"] = {
	model = "models/metrostroi_train/81-717/rtmlamp.mdl",
	pos = Vector(407.801178,-58.29,19.73),
	ang = Angle(0.000000,-90.000000,0.000000),
	hideseat = 1,
    scale=0.82,
}

--------------------------------------------------------------------------------
-- Add doors
--[[ local function GetDoorPosition(i,k,j)
    if j == 0
    then return Vector(323.0 - 0.5*k     - 0.8*(1-k) - 233.5*i,-62.8*(1-2.045*k),-5.3)
    else return Vector(323.0 - 0.5*(1-k) - 0.8*(1-k) - 233.5*i,-62.8*(1-2.045*k),-5.3)
    end
end
for i=0,3 do
    for k=0,1 do
        ENT.ClientProps["door"..i.."x"..k.."a"] = {
            model = "models/metrostroi_train/81-703/81-703_door_right.mdl",
            pos = GetDoorPosition(i,k,0),
            ang = Angle(0,90 + 180*k,0),
            hide = 2,
        }
        ENT.ClientProps["door"..i.."x"..k.."b"] = {
            model = "models/metrostroi_train/81-703/81-703_door_left.mdl",
            pos = GetDoorPosition(i,k,1),
            ang = Angle(0,90 + 180*k,0),
            hide = 2,
        }
    end
end--]]
ENT.ClientProps["door0x1"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos1.mdl",
    pos = Vector(344.692-22,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x1"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos2.mdl",
    pos = Vector(110.668-22,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x1"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos3.mdl",
    pos = Vector(-122.718-22,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x1"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos4.mdl",
    pos = Vector(-356.091-22,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door0x0"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos4.mdl",
    pos = Vector(344.692-22.5,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x0"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos3.mdl",
    pos = Vector(110.668-22.5,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x0"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos2.mdl",
    pos = Vector(-122.718-22.5,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x0"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos1.mdl",
    pos = Vector(-356.091-22.5,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1"] = {
    model = "models/metrostroi_train/81-710/ezh3_door_noars_with_marshrut.mdl",
    pos = Vector(460.349304,-14.530000,-6.986293),
    ang = Angle(0.000000,-90.000000,0.000000),
    hide = 2,
    callback = function(ent)
        ent.LastStation.Reloaded = false
    end,
}
ENT.ButtonMap["LastStation"] = {
    pos = Vector(459.9,-14.53,3),
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
    model = "models/metrostroi_train/81-703/81-703_door_tor.mdl",
    pos = Vector(-463.935913,16.530001,-7.556937),
    ang = Angle(0.000000,-270.000000,0.000000),
    hide = 2,
}


ENT.ClientProps["door3"] = {
    model = "models/metrostroi_train/81-703/81-703_door_interior_a.mdl",
    pos = Vector(395.6,-15,-8,5),
    ang = Angle(0.000000,90.000000,0.000000),
    hide = 2,
}


ENT.ClientProps["door4"] = {
    model = "models/metrostroi_train/81-710/81-710_door_cab.mdl",
    pos = Vector(410.954041,66.258118,-5.998950),
    ang = Angle(0.000000,-90.000000,0.000000),
    hide = 2,
}



ENT.ClientProps["UAVALever"] = {
    model = "models/metrostroi_train/81-703/cabin_uava.mdl",
    pos = Vector(450.264801,56.001812,-9.879532),
    ang = Angle(0,-90+10,0),
    hideseat = 0.8,
}




ENT.ClientProps["RedLights"] = {
    model = "models/metrostroi_train/81-703/81-703_red_light.mdl",
    pos = Vector(-23,1,-191),
    ang = Angle(0,0,0.000000),
    nohide = true
}
ENT.ClientProps["DistantLights"] = {
    model = "models/metrostroi_train/81-703/81-703_projcetor_light.mdl",
    pos = Vector(-23,1,-191),
    ang = Angle(00.000000,0.000000,0.000000),
    nohide = true
}
ENT.ClientProps["WhiteLights"] = {
    model = "models/metrostroi_train/81-703/81-703_front_light.mdl",
    pos = Vector(-23,1,-191),
    ang = Angle(0,0,0),
    nohide = true
}

ENT.ButtonMap["Route"] = {
    pos = Vector(465.7-7,35.3,2),
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
    pos = Vector(-7,0,0),
    ang = Angle(0,0,0),
    hide = 2,
}
ENT.ClientProps["route1"] = {
    model = "models/metrostroi_train/common/routes/ezh/route_number1.mdl",
    pos = Vector(-7,0,0),
    ang = Angle(0,0,0),
    hide = 2,
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
}
ENT.ClientProps["route2"] = {
    model = "models/metrostroi_train/common/routes/ezh/route_number2.mdl",
    pos = Vector(-7,0,0),
    ang = Angle(0,0,0),
    hide = 2,
}

ENT.Lights = {
    [1] = { "headlight",        Vector(475,0,-20), Angle(0,0,0), Color(188,130,88), brightness = 5 ,fov = 90, texture = "models/metrostroi_train/equipment/headlight",shadows = 1,headlight=true},
    [2] = { "headlight",        Vector(465,0,45), Angle(-20,0,0), Color(255,0,0), fov=164 ,brightness = 0.3, farz=250,texture = "models/metrostroi_train/equipment/headlight2",shadows = 0,backlight=true},
    [21] = { "headlight",       Vector(441,-40.0,40.2), Angle(75,-25,0), Color(255,130,88), fov=125, farz=80,brightness = 4,shadows = 1, texture = "models/metrostroi_train/equipment/headlight", hidden = "Lamps_pult"},
	[22] = { "headlight",       Vector(441,-55.0,35.2), Angle(0,0,0), Color(255,130,88), fov=125, farz=65,brightness = 6,shadows = 0, texture = "models/metrostroi_train/equipment/headlight", hidden = "Lamps_pult"},

    -- Emergency lit
    [9] = { "dynamiclight",    Vector(200, 0, -5), Angle(0,0,0), Color(255, 176, 59), brightness = 2, distance = 200},
    [10] = { "dynamiclight",    Vector(-150, 0, -5), Angle(0,0,0), Color(255, 176, 59), brightness = 2, distance = 200},
    [11] = { "dynamiclight",    Vector( 200, 0, -5), Angle(0,0,0), Color(255, 176, 59), brightness = 3, distance = 260},
    [12] = { "dynamiclight",    Vector(   0, 0, -5), Angle(0,0,0), Color(255, 176, 59), brightness = 3, distance = 260},
    [13] = { "dynamiclight",    Vector(-260, 0, -5), Angle(0,0,0), Color(255, 176, 59), brightness = 3, distance = 260},
    -- Cabin
    [23] = { "dynamiclight",        Vector(425,0,40),  Angle(0,0,0), Color(252, 157, 77), brightness = 0.0007, distance = 600, hidden = "salon3"},

    [5] =   { "light",           Vector(465+5,-32, 48), Angle(0,0,0), Color(255,50,50),     brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2 },
    [6] =   { "light",           Vector(465+5, 32, 48), Angle(0,0,0), Color(255,50,50),     brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2 },
    [30]  = { "light",           Vector(465+5,-45, -37), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2 },
    [31]  = { "light",           Vector(465+5, 45, -37), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2 },
    [32]  = { "light",           Vector(465+5, 0 , 48), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02", size = 2 },

    Lamps_pult = {"light", Vector(436.5,-55.5,42), Angle(0,0,0),Color(255,220,180),brightness = 0.35,scale = 0.4, texture = "sprites/light_glow02", hidden = "Lamps_pult"},
    Lamps_cab = {"light", Vector(399,1.2,57.5), Angle(0,0,0),Color(255,220,180),brightness = 0.25,scale = 0.3, texture = "sprites/light_glow02", hidden = "Lamps_cab1"},
    Lamp_RTM = {"light", Vector(407.801178,-58.29,19.73), Angle(0,0,0),Color(255,180,60),brightness = 0.4,scale = 0.03, texture = "sprites/light_glow02", hidden = "Lamp_RTM"},
}
function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.RRIScreen = self:CreateRT("717RRI",128,128)

    self.FrontLeak = 0
    self.RearLeak = 0

    self.CraneRamp = 0
    self.ReleasedPdT = 0
    self.EmergencyValveRamp = 0
    self.EmergencyValveEPKRamp = 0
    self.EmergencyBrakeValveRamp = 0

    self.OldZPos = 0
    self.OldSpeedoDelta = 0
    self.SpeedoDelta = 0
end
function ENT:UpdateWagonNumber()
    for i=0,3 do
        local leftNum,rightNum = self.ClientEnts["TrainNumberL"..i],self.ClientEnts["TrainNumberR"..i]
        local num = math.floor(self.WagonNumber%(10^(i+1))/10^i)
        if IsValid(leftNum) then
            leftNum:SetPos(self:LocalToWorld(Vector(410-15+i*6.6-3*6.6/2,69,-26)))
            leftNum:SetSkin(num)
        end
        if IsValid(rightNum) then
            rightNum:SetPos(self:LocalToWorld(Vector(-392-15-i*6.6-3*6.6/2,-66.6,-26)))
            rightNum:SetSkin(num)
        end
    end
end
--------------------------------------------------------------------------------
function ENT:Think()
    self.BaseClass.Think(self)
    if not self.RenderClientEnts then
        return
    end

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
    local Lamps = self:GetPackedRatio("LampsStrength")

    local emer1 = self:Animate("lamps_emer1",self:GetPackedBool("Lamps_emer1") and 1 or 0,0,1,5,false)
    local cab = self:Animate("lamps_cab",self:GetPackedBool("Lamps_cab") and 1 or 0,0,1,5,false)
    local emer2 = self:Animate("lamps_emer2",self:GetPackedBool("Lamps_emer2") and 1 or 0,0,1,5,false)
    local half1 = self:Animate("lamps_half1",self:GetPackedBool("Lamps_half1") and 0.4+Lamps*0.6 or 0,0,1,5,false)
    local half2 = self:Animate("lamps_half2",self:GetPackedBool("Lamps_half2") and 0.4+Lamps*0.6 or 0,0,1,5,false)

    self:ShowHideSmooth("Lamps_emer1",emer1)
    self:ShowHideSmooth("Lamps_cab1",cab)
    self:ShowHideSmooth("Lamps_emer2",emer2)
    self:ShowHideSmooth("Lamps_half1",half1,Color(255,105+half1*150,105+half1*150))
    self:ShowHideSmooth("Lamps_half2",half2,Color(255,105+half2*150,105+half2*150))
    self:SetLightPower(23, cab > 0,cab)
    self:SetLightPower("Lamps_cab", cab > 0,cab)
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

    self:Animate("UAVALever",   self:GetPackedBool("UAVA") and 1 or 0,     0,0.6, 128,  3,false)
    self:Animate("stopkran",   self:GetPackedBool("EmergencyBrakeValve") and 1 or 0,     0,0.25, 256,  3,false)

    self:Animate("brake_disconnect",self:GetPackedBool("DriverValveBLDisconnect") and 0 or 1,0.25,0.5,  4,false)
    self:Animate("train_disconnect",self:GetPackedBool("DriverValveTLDisconnect") and 1 or 0,0.25,0,  4,false)

    local HL1 = self:Animate("whitelights",self:GetPackedBool("HeadLights1") and 1 or 0,0,1,5,false)
    local HL2 = self:Animate("distantlights",self:GetPackedBool("HeadLights2") and 1 or 0,0,1,5,false)
    local RL = self:Animate("redlights",self:GetPackedBool("RedLight") and 1 or 0,0,1,5,false)

    self:ShowHideSmooth("WhiteLights",HL1)
    self:ShowHideSmooth("DistantLights",HL2)
    self:ShowHideSmooth("RedLights",RL)
    self:SetLightPower(5,RL > 0,RL)
    self:SetLightPower(6,RL > 0,RL)
    self:SetLightPower(30,HL1 > 0, HL1)
    self:SetLightPower(31,HL1 > 0, HL1)
    self:SetLightPower(32,HL2 > 0, HL2)

    local bright = HL1*0.3+HL2*0.7
    self:SetLightPower(1,bright>0,bright)
    self:SetLightPower(2,RL>0,RL)

    local PL = HL1*self:Animate("lamps_pult",self:GetPackedBool("PanelLights") and 1 or 0,0,1,12,false)
    self:ShowHideSmooth("Lamps_pult",PL)
    self:SetLightPower("Lamps_pult",PL>0,PL)
    self:SetLightPower(21,PL>0,PL)
    self:SetLightPower(22,PL>0,PL)

    if IsValid(self.GlowingLights[1]) then
        if not self:GetPackedBool("HeadLights1") and self.GlowingLights[1]:GetFarZ() ~= 3144 then
            self.GlowingLights[1]:SetFarZ(3144)
        end
        if self:GetPackedBool("HeadLights1") and self.GlowingLights[1]:GetFarZ() ~= 5144 then
            self.GlowingLights[1]:SetFarZ(5144)
        end
    end

    self:HidePanel("RRIScreen",self.CurrentCamera~=5)

    -- Simulate pressure gauges getting stuck a little
    self:Animate("brake",1-self:GetPackedRatio("CranePosition"),           0.00, 0.48,  256,24)
    self:Animate("controller",self:GetPackedRatio("ControllerPosition"),             0, 0.31,  2,false)
    self:Animate("reverser",self:GetPackedRatio("ReverserPosition"),0.6, 0.4,  4,false)
    self:Animate("rcureverser",self:GetPackedBool("RCUPosition") and 1 or 0,0.77,0,3,false)
    self:ShowHide("reverser",self:GetNW2Int("WrenchMode",0)==1)
    self:ShowHide("rcureverser",self:GetNW2Int("WrenchMode",0)==3)
    self:Animate("volt1",self:GetPackedRatio("BatteryVoltage"),0.62,0.38,45,3)

    self:Animate("brake_line",self:GetPackedRatio("BLPressure"),0.6285, 0.84,  256,2)--,,0.01)
    self:Animate("train_line",self:GetPackedRatio("TLPressure"),0.6285, 0.843,  256,2)--,,0.01)
    self:Animate("brake_cylinder",self:GetPackedRatio("BCPressure"),0.04, 0.83,  256,2)--,,0.03)
    local voltage = math.min(1,self:GetPackedRatio("EnginesVoltage"))
    local current = self:GetPackedRatio("EnginesCurrent")
    self:Animate("voltmeter",       voltage >= 0.7 and voltage-(voltage/12*(voltage-(voltage >= 0.85 and 0.3 or 0.5))) or voltage,              0.62875,0.367,92,2)
    self:Animate("ampermeter",      current<0.49 and  current-current/((1-current)*10+current*10) or current,             0.617,0.383,                nil, nil,  92,20,3)

    local speed = self:GetPackedRatio("Speed")*100
    --Speedo swing
    local vec = -(self:LocalToWorld(Vector(445.7,-56.2,15.7))*self:GetUp()).z
    local posdelta = math.Clamp((vec-self.OldZPos)*(2+speed/90),-0.4,0.4)
    local delta = (self.OldSpeedoDelta-posdelta)

    self.SpeedoDelta = self.SpeedoDelta+(delta-self.SpeedoDelta)*2*0.02--*self.DeltaTime
    local speed1 = math.Clamp(self:GetPackedRatio("Speed")+self.SpeedoDelta,0,1)
    self.OldZPos = vec
    self.OldSpeedoDelta = posdelta

    -- Rotate wheel
    self:Animate("speed1",      speed1 > 0.41 and speed1-(speed1/12*(speed1-(speed1 > 0.95 and 0.634 or 0.3))) or speed1,         0.76, 0.97895,              nil, nil,  256,2,0.01)

    ----
    local door2 = self:Animate("door2", self:GetPackedBool("RearDoor") and 0.99 or 0,0,0.25, 8, 1)
    local door1 = self:Animate("door1", self:GetPackedBool("FrontDoor") and 0.99 or 0,0,0.22, 8, 1)
    local door3 = self:Animate("door3", self:GetPackedBool("PassengerDoor") and 0.99 or 0,1,0.48, 8, 1)
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
    if not self.DoorStates then self.DoorStates = {} end
    if not self.DoorLoopStates then self.DoorLoopStates = {} end
    for i=0,3 do
        for k=0,1 do
            local st = k==1 and "DoorL" or "DoorR"
            local doorstate = self:GetPackedBool(st)
            local id,sid = st..(i+1),"door"..i.."x"..k
            local state = self:GetPackedRatio(id)
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
            self:SetSoundState(sid.."r",self.DoorLoopStates[id],0.66+self.DoorLoopStates[id]*0.2)
            local n_l = "door"..i.."x"..k--.."a"
            --local n_r = "door"..i.."x"..k.."b"
            local dlo = 1
            --local dro = 1
            if self.Anims[n_l] then
                dlo = math.abs(state-(self.Anims[n_l] and self.Anims[n_l].oldival or 0))
                if dlo <= 0 and self.Anims[n_l].oldspeed then
                    dlo = self.Anims[n_l].oldspeed/14
                end
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
	local compressorvoltage = Lerp(self:GetPackedRatio("LampsStrength"),0.75,1.05)
	local compressorb = self:GetPackedBool("AV") and compressorvoltage or 1
	local compressorspeed = self:GetPackedBool("VB") and compressorb or 0
    local state = self:GetPackedBool("Compressor")
    self:SetSoundState("compressor",state and 0.6 or 0,compressorspeed or 0)

    -- RK rotation
    if self:GetPackedBool("RK") then self.RKTimer = CurTime() end
    state = (CurTime() - (self.RKTimer or 0)) < 0.2
    self.PreviousRKState = self.PreviousRKState or false
    if self.PreviousRKState ~= state then
        self.PreviousRKState = state
        if state then
            self:SetSoundState("rk",0.25,1)
        else
            self:SetSoundState("rk",0,0)
        end
    end
    -- ARS/ringer alert
    self:SetSoundState("ring_old",self:GetPackedBool("Ring") and 0.4 or 0,0.98)

    local lamps_rtm = self:Animate("lamps_rtm",self:GetPackedBool("VPR") and 1 or 0,0,1,8,false)
    self:SetLightPower("Lamp_RTM",lamps_rtm > 0,lamps_rtm)
    self:ShowHideSmooth("Lamp_RTM",lamps_rtm)
    self:SetSoundState("vpr",self:GetPackedBool("VPR") and 1 or 0,1)

    local work = self:GetPackedBool("AnnPlay")
    local noise = self:GetNW2Int("AnnouncerBuzz",-1) > 0
    self.NoiseVolume = self.NoiseVolume or 0
    self.AnnLamp = self.AnnLamp or 0
    local noisevolume = 1
    if self.Sounds["announcer1"] and IsValid(self.Sounds["announcer1"]) then noisevolume = (1-(self.Sounds["announcer1"]:GetLevel())*math.Rand(0.9,3))*1 end
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
            self:SetSoundState(Format("announcer_noise%d_%d",i,k),noise and self.NoiseVolume*(v[3] or 1) or 0,1)
        end
        if IsValid(self.Sounds["announcer"..k]) then self.Sounds["announcer"..k]:SetVolume(work and (v[3] or 1) or 0) end
    end
end

function ENT:OnAnnouncer(volume)
    return self:GetPackedBool("AnnPlay") and volume  or 0
end

function ENT:Draw()
    self.BaseClass.Draw(self)
end
function ENT:DrawPost()
    self:DrawOnPanel("AirDistributor",function()
        draw.DrawText(self:GetNW2Bool("AD") and "Air Distributor ON" or "Air Distributor OFF","Trebuchet24",0,0,Color(0,0,0,255))
    end)
    self.RTMaterial:SetTexture("$basetexture", self.RRIScreen)
    self:DrawOnPanel("RRIScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(64,64,128,128,0)
    end)
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
        if soundid == "LK2" then
            local speed = self:GetPackedRatio("Speed")
            local id = range > 0 and "lk2_on" or "lk2_off"
            self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
            return id,location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "LK3" then
            local speed = self:GetPackedRatio("Speed")
            local id = range > 0 and "lk4_on" or "lk4_off"
            self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
            return id,location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "KK" then
            return range > 0 and "kk_on" or "kk_off",location,1,pitch--0.8
        end
        if soundid == "AVU" then
            return range > 0 and "avu_on" or "avu_off",location,1,0.6
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

local dist = {
    Back1 = 550,
    AVMain = 550,
    AV1 = 550,
    AV2 = 550,
    Battery = 550,
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
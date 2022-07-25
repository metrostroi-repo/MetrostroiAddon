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

ENT.ButtonMap["PanelLamp"] = {
    pos = Vector(456,-53,30),
    ang = Angle(186,-37,6),
    width = 100,
    height = 200,
    scale = 0.0588,

    buttons = {
        {ID = "PanelLampToggle", x=0, y=0, w=100, h=200, tooltip="",var="PanelLights"},
    }
}

-- Main panel
ENT.ButtonMap["MainL"] = {
    pos = Vector(460.4,-37.98,-11.15),
    ang = Angle(0.5,-98,70),
    width = 83.5,
    height = 20,
    scale = 0.0588,
    hideseat=0.2,

    buttons = {
        ----Лампы
        {ID = "!RedRP",         x=10,y=10, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-703/cabin_lamp_red3.mdl",z=1,color = Color(178,112,112), var="RRP", getfunc = function(ent,min,max) return ent:GetPackedRatio("RRP") end},
            sprite = {bright=0.1,size=0.25,scale=0.07,color=Color(255,60,60),z=3,}
        }},
        {ID = "!GreenRP",       x=40.71,y=10, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-703/cabin_lamp_green.mdl",z=1,color = Color(98,178,178), var="GRP"},
            sprite = {bright=0.1,size=0.25,scale=0.07,color=Color(40,255,100),z=3,}
        }},
        {ID = "!Blue",          x=73.50,y=10, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-703/cabin_lamp_white.mdl",z=1,color = Color(112,140,178), var="SD",},
            sprite = {bright=0.1,size=0.25,scale=0.07,color=Color(60,200,255),z=3,}
        }},
    }
}
ENT.ButtonMap["MainB"] = {
    pos = Vector(460.8,-34.9,-15.3),
    ang = Angle(0,-96,65),
    width = 218,
    height = 90,
    scale = 0.0588,
    hideseat=0.2,

    buttons = {
        ----Кнопки
        {   ID = "KU7Toggle",   x=0+56*0,y=0,w=50,h=90, tooltip="", model = {
            model = "models/metrostroi_train/81-702/buttons/vu_13b.mdl", ang=Angle(-90,0,0),
            labels={{model="models/metrostroi_train/81-702/labels/vu_labels.mdl",skin=3,ang=90,z=10,x=0,y=-13.5}},
            var="KU7",speed=6,
            sndvol = 1, snd = function(val) return val and "vu13a_on" or "vu13a_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Unlocked","Train.Buttons.Locked"},
        }},

        {   ID = "KU6Set",  x=0+56*1, y=0, w=50,h=90, tooltip="", model = {
            model = "models/metrostroi_train/81-702/buttons/vu_13b.mdl", ang=Angle(-90,0,0),
            labels={{model="models/metrostroi_train/81-702/labels/vu_labels.mdl",skin=4,ang=90,z=10,x=0,y=-13.5}},
            var="KU6",speed=6,
            sndvol = 1, snd = function(val) return val and "vu13a_on" or "vu13a_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {   ID = "VRPSet",  x=0+56*2, y=0, w=50,h=90, tooltip="", model = {
            model = "models/metrostroi_train/81-702/buttons/vu_13b.mdl", ang=Angle(-90,0,0),
            labels={{model="models/metrostroi_train/81-702/labels/vu_labels.mdl",skin=5,ang=90,z=10,x=0,y=-13.5}},
            var="VRP",speed=6,
            sndvol = 1, snd = function(val) return val and "vu13a_on" or "vu13a_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {   ID = "KU3Toggle",   x=0+56*3,y=0,w=50,h=90, tooltip="", model = {
            model = "models/metrostroi_train/81-702/buttons/vu_13b.mdl", ang=Angle(-90,0,0),
            labels={{model="models/metrostroi_train/81-702/labels/vu_labels.mdl",skin=6,ang=90,z=10,x=0,y=-13.5}},
            var="KU3",speed=6,
            sndvol = 1, snd = function(val) return val and "vu13a_on" or "vu13a_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}

--VU Panel
ENT.ButtonMap["VU"] = {
    pos = Vector(462,-17.1,22.5),
    ang = Angle(0,270,90),
    width = 103,
    height = 390,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {   ID = "VUToggle",    x=0, y=0, w=88, h=80, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=0, ang = 180,
			labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            plomb = {model = "models/metrostroi_train/equipment/vu_plomb_right.mdl",ang=Angle(-90,90,0),x=25,y=33.2,z=9.3,var="VUPl", ID="VUPl",},
            var="VU",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu220b1_on" or "vu220b1_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {   ID = "KU1Set",  x=33, y=120+90*0,w=70,h=90, tooltip="", model = {
            model = "models/metrostroi_train/81-702/buttons/vu_13b.mdl", z=8, ang=Angle(-90,0,0),
            labels={{model="models/metrostroi_train/81-702/labels/vu_labels.mdl",skin=0,ang=90,z=10,x=0,y=-13.5}},
            var="KU1",speed=6,
            sndvol = 1, snd = function(val) return val and "vu13a_on" or "vu13a_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {   ID = "KU2Set",  x=33, y=120+90*1,w=70,h=90, tooltip="", model = {
            model = "models/metrostroi_train/81-702/buttons/vu_13b.mdl", z=8, ang=Angle(-90,0,0),
            labels={{model="models/metrostroi_train/81-702/labels/vu_labels.mdl",skin=1,ang=90,z=10,x=0,y=-13.5}},
            var="KU2",speed=6,
            sndvol = 1, snd = function(val) return val and "vu13a_on" or "vu13a_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {   ID = "SNSet",       x=33, y=120+90*2,w=70,h=90, tooltip="", model = {
            model = "models/metrostroi_train/81-702/buttons/vu_13b.mdl", z=8, ang=Angle(-90,0,0),
            labels={{model="models/metrostroi_train/81-702/labels/vu_labels.mdl",skin=2,ang=90,z=10,x=0,y=-13.5}},
            var="SN",speed=6,
            sndvol = 1, snd = function(val) return val and "vu13a_on" or "vu13a_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}
--VU Panel
ENT.ButtonMap["KU5"] = {
    pos = Vector(461.2,-17.8,-2),
    ang = Angle(0,270,90),
    width = 140,
    height = 80,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {   ID = "KU5Set",      x=0, y=0, w=140,h=80, tooltip="", model = {
            model = "models/metrostroi_train/81-702/buttons/emer_doors.mdl", z=0, ang=Angle(-90,0,0),
            var="KU5",speed=12,
            sndvol = 0.1, snd = function(val) return val and "vu220b1_on" or "vu220b1_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["Stopkran"] = {
    pos = Vector(464,27,10),
    ang = Angle(0,-90,90),
    width = 200,
    height = 1300,
    scale = 0.1/2,
        buttons = {
            {ID = "EmergencyBrakeValveToggle",x=0, y=0, w=200, h=1300, tooltip="", tooltip="",tooltip="",states={"Train.Buttons.Closed","Train.Buttons.Opened"},var="EmergencyBrakeValve"},
    }
}

ENT.ButtonMap["AVMain"] = {
    pos = Vector(409,-38.5,31.5),
    ang = Angle(0,90,90),
    width = 335,
    height = 380,
    scale = 0.0625,
    hide=0.8,

    buttons = {
            {ID = "AVToggle", x=0, y=0, w=300, h=380, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_av8r.mdl", z=80, ang = Angle(90,0,0),
            var="AV",speed=0.85, vmin=0.73,vmax=0.80,
            sndvol = 1, snd = function(val) return val and "av1a_on" or "av1a_off" end,
        }},
    }
}

---AV1 Panel
ENT.ButtonMap["AV1"] = {
    pos = Vector(409.63,41,34.3),
    ang = Angle(0,90,90),
    width = 320,
    height = 500,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "VU3Toggle", x=220, y=294, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=20, ang = 180,
			labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            var="VU3",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu220b1_on" or "vu220b1_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "VU2Toggle", x=20, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=20, ang = 180,
			labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            var="VU2",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu220b1_on" or "vu220b1_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "VU1Toggle", x=120, y=110, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=20, ang = 180,
			labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            var="VU1",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu220b1_on" or "vu220b1_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}

ENT.ClientProps["tab"] = {
    model = "models/metrostroi_train/Equipment/tab.mdl",
    pos = Vector(23.8,0,-3),
    ang = Angle(0,0,0),
    skin = 5,
    hide = 2,
}
-- Battery panel
ENT.ButtonMap["Battery"] = {
    pos = Vector(410.1,16.5,34.5),
    ang = Angle(0,90,90),
    width = 250,
    height = 140,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "VBToggle", x=0, y=0, w=250, h=140, tooltip="", model = {
            model = "models/metrostroi_train/81-702/buttons/vb_1.mdl", color=Color(255,255,255), z=18, ang = Angle(-90,180,0),
            var="VB",speed=6,vmin=1,vmax=0,
            sndvol = 0.8, snd = function(val) return val and "vb1a_on" or "vb1a_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}




ENT.ButtonMap["KU9"] = {
    pos = Vector(410.1,33.9,23.5),
    ang = Angle(0,90,90),
    width = 50,
    height = 70,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "KU9Set", x=0, y=0, w=50, h=70, tooltip="", model = {
            model = "models/metrostroi_train/81-702/buttons/ku122.mdl", z=5, ang = Angle(-90,180,0),
            var="KU9",speed=12,vmin=0,vmax=1,
            sndvol = 0.1, snd = function(val) return val and "prk1" or "button1_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}
-- Parking brake panel
ENT.ButtonMap["ParkingBrake"] = {
    pos = Vector(455,47.8,-2.0),
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
    pos = Vector(449.45,59.99,24.64),
    ang = Angle(0,0,90),
    width = 60,
    height = 200,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "KU10Set",x=0, y=0, w=60,h=100, tooltip="", model = {
            model = "models/metrostroi_train/81-702/buttons/vu_13b.mdl", z=-3, ang=Angle(-90,0,0),
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=9,ang=90,z=10,x=0,y=-13.5}},
            var="KU10",speed=6,
            sndvol = 1, snd = function(val) return val and "vu13a_on" or "vu13a_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "KU8Toggle",x=0, y=100, w=60,h=100, tooltip="", model = {
            model = "models/metrostroi_train/81-702/buttons/vu_13b.mdl", z=-3, ang=Angle(-90,0,0),
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=10,ang=90,z=10,x=0,y=-13.5}},
            var="KU8",speed=6,
            sndvol = 1, snd = function(val) return val and "vu13a_on" or "vu13a_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Unlocked","Train.Buttons.Locked"},
        }},
    }
}


ENT.ButtonMap["HVMeters"] = {
    pos = Vector(454.1,-55.7,23.4),
    ang = Angle(0,-145,90),
    width = 55,
    height = 55,
    scale = 0.0625,

    buttons = {
        {ID = "!EnginesVoltage", x=0, y=0, w=55, h=55, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesVoltage"),ent:GetPackedRatio("EnginesVoltage")*1000) end},
    }
}
ENT.ButtonMap["Speedometer"] = {
    pos = Vector(456.2,-53.6,18.5),
    ang = Angle(0,-148,89),
    width = 135,
    height = 135,
    scale = 0.0625,

    buttons = {
        {ID = "!Speedometer", x=0, y=0, w=135, h=135, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.Speed"),ent:GetPackedRatio("Speed")*100) end},
    }
}
ENT.ButtonMap["BLTLPressure"] = {
    pos = Vector(456.5,-55,8.8),
    ang = Angle(0,-138,90),
    width = 120,
    height = 120,
    scale = 0.0625,

    buttons = {
        {ID = "!BLTLPressure", x=60,y=60,radius=60,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BLTLPressure"),ent:GetPackedRatio("TLPressure")*16,ent:GetPackedRatio("BLPressure")*16) end},
    }
}
ENT.ButtonMap["BCPressure"] = {
    pos = Vector(454.3,-55.5,0.7),
    ang = Angle(0,-143,90),

    width = 68,
    height = 68,
    scale = 0.0625,

    buttons = {
        {ID = "!BCPressure", x=34,y=34,radius=34,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BCPressure"),ent:GetPackedRatio("BCPressure")*6) end},
    }
}
ENT.ButtonMap["BatteryVoltage"] = {
    pos = Vector(410.1,22.5,15.5),
    ang = Angle(0,90,90),
    width = 60,
    height = 60,
    scale = 0.0625,

    buttons = {
        {ID = "!BatteryVoltage", x=0,y=0,w=60,h=60,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BatteryVoltage"),ent:GetPackedRatio("BatteryVoltage")*150) end},
    }
}

ENT.ButtonMap["DriverValveBLDisconnect"] = {
    pos = Vector(449,-54,-37.61),
    ang = Angle(-90,-10,0),
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
    pos = Vector(452,-50,-30),
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
--[[
ENT.ButtonMap["Meters"] = {
    pos = Vector(454.95213,-55.696617,27.528275),
    ang = Angle(0,-180+38,90),
    width = 73,
    height = 73,
    scale = 0.0625,

    buttons = {
        {ID = "!TotalVoltmeter", x=13, y=22, w=60, h=50, tooltip=""},
        --{ID = "!TotalAmpermeter", x=13, y=81, w=60, h=50, tooltip=""},
    }
}
ENT.ButtonMap["Speedometer"] = {
    pos = Vector(455,-55.25582,17.324441),
    ang = Angle(0,-149,90),
    width = 110,
    height = 110,
    scale = 0.0625,

    buttons = {
        {ID = "!Speedometer", x=0, y=0, w=110, h=110, tooltip=""},
    }
}--]]

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
    pos = Vector(450+19, -29, -68),
    ang = Angle(0,-90,0),
    hide = 0.5,
}
ENT.ClientProps["FrontTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(450+19, 30, -68),
    ang = Angle(0,-90,0),
    hide = 0.5,
}
ENT.ClientSounds["FrontBrakeLineIsolation"] = {{"FrontBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["FrontTrainLineIsolation"] = {{"FrontTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ButtonMap["RearPneumatic"] = {
    pos = Vector(-473-1,45.0,-58.0),
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
    pos = Vector(-450-22, -30, -68),
    ang = Angle(0,90,0),
    hide = 0.5,
}
ENT.ClientProps["RearBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(-450-22, 29, -68),
    ang = Angle(0,90,0),
    hide = 0.5,
}
ENT.ClientSounds["RearBrakeLineIsolation"] = {{"RearBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["RearTrainLineIsolation"] = {{"RearTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}


ENT.ButtonMap["GV"] = {
    pos = Vector(170,50,-60),
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
    pos = Vector(153.5,36,-78),
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
    pos = Vector(453,60,-7),
    ang = Angle(0,-70,90),
    width = 180,
    height = 170,
    scale = 0.0625,

    buttons = {
        {ID = "UAVAToggle",x=0, y=0, w=60, h=170, tooltip="", model = {
            plomb = {var="UAVAPl", ID="UAVAPl"},
            var="UAVA",
            sndid="UAVALever",sndvol = 1, snd = function(val) return val and "uava_on" or "uava_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "UAVACToggle",x=60, y=0, w=120, h=170, tooltip="",var="UAVAC",states={"Train.Buttons.UAVAOff","Train.Buttons.UAVAOn"}},
    }
}

for i=0,3 do
    ENT.ClientProps["TrainNumberL"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(400+i*6.6-4*6.6/2,67.5,-26),
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
        pos = Vector(-405-i*6.6-4*6.6/2,-67.4,-26),
        ang = Angle(0,0,0),
        skin=0,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end
ENT.ButtonMap["FrontDoor"] = {
    pos = Vector(468,16,37),
    ang = Angle(0,-90,90),
    width = 650,
    height = 1780,
    scale = 0.1/2,
    buttons = {
        {ID = "FrontDoor",x=0,y=0,w=650,h=1780, tooltip="", model = {
            var="door1",sndid="door1",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}

ENT.ButtonMap["CabinDoor"] = {
    pos = Vector(415,64,37),
    ang = Angle(0,0,90),
    width = 642,
    height = 1780,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoor",x=0,y=0,w=642,h=1780, tooltip="", model = {
            var="door4",sndid="door4",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}

ENT.ButtonMap["PassengerDoor"] = {
    pos = Vector(400+7.6,-16,37),
    ang = Angle(0,90,90),
    width = 642,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=642,h=1900, tooltip="", model = {
            var="door3",sndid="door3",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
ENT.ButtonMap["PassengerDoor1"] = {
    pos = Vector(400+7,16,37),
    ang = Angle(0,-90,90),
    width = 642,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=642,h=1900, tooltip=""},
    }
}

ENT.ButtonMap["RearDoor"] = {
    pos = Vector(-472,-16,37),
    ang = Angle(0,90,90),
    width = 650,
    height = 1780,
    scale = 0.1/2,
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=650,h=1780, tooltip="", model = {
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
    pos = Vector(453.213806,-54.919998,-8.500000),
    ang = Angle(0.000000,-133.000000,0.000000),
    hideseat = 0.2,
}
ENT.ClientProps["controller"] = {
    model = "models/metrostroi_train/81-702/kv_d.mdl",
    pos = Vector(453.813934,-20.614157,-9.466090),
    ang = Angle(0,195.000000,0),
    hideseat = 0.2,
}

ENT.ClientProps["reverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = Vector(453.8,-21,-15),
    ang = Angle(180,90,180),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientProps["rcureverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = Vector(411.9+0.3,-26.15,-11.3),
    ang = Angle(90+45,0,-90),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientProps["brake_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran1.mdl",
    pos = Vector(447.2,-58.5,-32.05),
    ang = Angle(0,88,-90),
    hideseat = 0.2,
}
ENT.ClientProps["train_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran3.mdl",
    pos = Vector(450.4,-54.35,-26.25),
    ang = Angle(90,-100,90),
    hideseat = 0.2,
}

ENT.ClientProps["parking_brake"] = {
    model = "models/metrostroi_train/81-703/cabin_parking.mdl",
    pos = Vector(456.591827,37.367580,-16.614565),
    ang = Angle(-90.000000,8.000000,0.000000),
    hideseat = 0.2,
}


--------------------------------------------------------------------------------
ENT.ClientProps["train_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_e_nm.mdl",
    pos = Vector(453.808746,-57.777153,3.555025),
    ang = Angle(170.000000,-143.000000,90.000000),
    hideseat = 0.2,
}

ENT.ClientProps["brake_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_e_tm.mdl",
    pos = Vector(453.851135,-57.825100,3.558732),
    ang = Angle(170.000000,-143.000000,90.000000),
    hideseat = 0.2,
}

ENT.ClientProps["brake_cylinder"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(452.788696,-57.193684,-1.326352),
    ang = Angle(-124.500000,37.000000,-90.000000),
    hideseat = 0.2,
}
----------------------------------------------------------------
ENT.ClientProps["voltmeter"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(452.729889,-56.791126,21.017803),
    ang = Angle(-90.000000,0.000000,-55.130001),
    hideseat = 0.2,
}

--[[
ENT.ClientProps["ampermeter"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(450.284607-1.0,-56.987834,30.5+1.0),
    ang = Angle(-90,0,-60)
}
]]
ENT.ClientProps["volt1"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(410.788452,24.423306,12.815310),
    ang = Angle(-90.000000,89.500000,90.000000),
    hideseat = 0.2,
}

ENT.ClientProps["speed1"] = {
    model = "models/metrostroi_train/Equipment/arrow_voltmeter_old.mdl",
    pos = Vector(450.787781,-57.760075,11.812588),
    ang = Angle(-90,-16.708426,-39.648327),
    hideseat = 0.2,
}
--------------------------------------------------------------------------------

ENT.ClientProps["salon"] = {
    model = "models/metrostroi_train/81-702/81-702_salon.mdl",
    pos = Vector(0.0,0,0),
    ang = Angle(0,0,0),
    hide = 2.0,
}

ENT.ClientProps["salon2"] = {
    model = "models/metrostroi_train/81-702/81-702_cabine.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2,
}
ENT.ClientProps["Lamps_pult"] = {
    model = "models/metrostroi_train/equipment/lamp_gauges_d.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=2,
}
ENT.ClientProps["Lamps_emer1"] = {
    model = "models/metrostroi_train/81-702/light_emer2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    --color=Color(255,150,150),
    hide = 1.5,
}

ENT.ClientProps["Lamps_emer2"] = {
    model = "models/metrostroi_train/81-702/light_emer.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    --color=Color(255,150,150),
    hide = 1.5,
}
ENT.ClientProps["Lamps_cab1"] = {
    model = "models/metrostroi_train/81-702/light_cabine.mdl",
    pos = Vector(411.975,0,42.535),
    ang = Angle(0,0,0),
    hide = 0.8,
}

ENT.ClientProps["Lamps_half1"] = {
    model = "models/metrostroi_train/81-702/light_group1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 1.5,
}
ENT.ClientProps["Lamps_half2"] = {
    model = "models/metrostroi_train/81-702/light_group2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 1.5,
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

addTW10Cosume("MainL")

--------------------------------------------------------------------------------
-- Add doors
--[[ local function GetDoorPosition(i,k,j)
    if j == 0
    then return Vector(349.45 - 1*k     - 232.202*i,-64.6*(1-2*k),-8.728)
    else return Vector(349.45 - 1*(1-k) - 232.202*i,-64.6*(1-2*k),-8.728)
    end
end
for i=0,3 do
    for k=0,1 do
        ENT.ClientProps["door"..i.."x"..k.."a"] = {
            model = "models/metrostroi_train/81-702/81-702_door_right.mdl",
            pos = GetDoorPosition(i,k,0),
            ang = Angle(0,90 + 180*k,0),
            hide = 2,
        }
        ENT.ClientProps["door"..i.."x"..k.."b"] = {
            model = "models/metrostroi_train/81-702/81-702_door_left.mdl",
            pos = GetDoorPosition(i,k,1),
            ang = Angle(0,90 + 180*k,0),
            hide = 2,
        }
    end
end--]]
ENT.ClientProps["door0x1"] = {
    model = "models/metrostroi_train/81-702/81-702_doors_pos1.mdl",
    pos = Vector(349.5,64.8,-8.85),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x1"] = {
    model = "models/metrostroi_train/81-702/81-702_doors_pos2.mdl",
    pos = Vector(117.12,64.8,-8.85),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x1"] = {
    model = "models/metrostroi_train/81-702/81-702_doors_pos3.mdl",
    pos = Vector(-115.12,64.8,-8.85),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x1"] = {
    model = "models/metrostroi_train/81-702/81-702_doors_pos4.mdl",
    pos = Vector(-347.698,64.8,-8.85),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door0x0"] = {
    model = "models/metrostroi_train/81-702/81-702_doors_pos4.mdl",
    pos = Vector(349.5,-64.8,-8.85),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x0"] = {
    model = "models/metrostroi_train/81-702/81-702_doors_pos3.mdl",
    pos = Vector(117.12,-64.8,-8.85),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x0"] = {
    model = "models/metrostroi_train/81-702/81-702_doors_pos2.mdl",
    pos = Vector(-115.12,-64.8,-8.85),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x0"] = {
    model = "models/metrostroi_train/81-702/81-702_doors_pos1.mdl",
    pos = Vector(-347.698,-64.8,-8.85),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1"] = {
    model = "models/metrostroi_train/81-702/81-702_door_torec.mdl",
    pos = Vector(466.422,-16.306,-9.987),
    ang = Angle(0,-90,0),
    hide = 2,
}
ENT.ClientProps["door2"] = {
    model = "models/metrostroi_train/81-702/81-702_door_torec.mdl",
    pos = Vector(-471.062,16.047,-9.987),
    ang = Angle(0,90,0),
    hide = 2,
}
ENT.ClientProps["door3"] = {
    model = "models/metrostroi_train/81-702/81-702_door_salon.mdl",
    pos = Vector(409.613,-15.765,-10.239),
    ang = Angle(0,-90,0),
    hide = 2,
}
ENT.ClientProps["door4"] = {
    model = "models/metrostroi_train/81-702/81-702_door_cab.mdl",
    pos = Vector(416.706,63.461,-8.38),
    ang = Angle(0,-90,0),
    hide = 2,
}

ENT.ClientProps["UAVALever"] = {
    model = "models/metrostroi_train/81-703/cabin_uava.mdl",
    pos = Vector(456.04598,60.4,-13),
    ang = Angle(0,-90+10,0),
    hideseat = 0.8,
}

ENT.ClientProps["EmergencyBrakeValve"] = {
    model = "models/metrostroi_train/81-710/ezh3_stopkran.mdl",
    pos = Vector(463.8,20.7,3.6),
    ang = Angle(0,180,0),
    hide = 0.8,
}


ENT.ClientProps["WhiteLights"] = {
    model = "models/metrostroi_train/81-702/81-702_front_light.mdl",
    pos = Vector(470,0.5,-42),
    ang = Angle(0,0,0),
    nohide=true
}

ENT.Lights = {
    [1] = { "headlight",        Vector(475,0,-20), Angle(0,0,0), Color(188,130,88), brightness = 5 ,fov = 90, texture = "models/metrostroi_train/equipment/headlight",shadows = 1,headlight=true},
    [22] = { "headlight",       Vector(450,-40.5,40.2), Angle(90,0,0), Color(255,130,88), fov=125,farz=80,brightness = 2,shadows = 1, texture = "models/metrostroi_train/equipment/headlight", hidden = "Lamps_pult"},

    [9] = { "dynamiclight",    Vector(200, 0, -5), Angle(0,0,0), Color(255, 176, 59), brightness = 2, distance = 200},
    [10] = { "dynamiclight",    Vector(-150, 0, -5), Angle(0,0,0), Color(255, 176, 59), brightness = 2, distance = 200},
    [11] = { "dynamiclight",    Vector( 200, 0, -5), Angle(0,0,0), Color(255, 176, 59), brightness = 4, distance = 260},
    [12] = { "dynamiclight",    Vector(   0, 0, -5), Angle(0,0,0), Color(255, 176, 59), brightness = 4, distance = 260},
    [13] = { "dynamiclight",    Vector(-260, 0, -5), Angle(0,0,0), Color(255, 176, 59), brightness = 4, distance = 260},

    [23] = { "dynamiclight",        Vector(425,0,35), Angle(0,0,0), Color(252, 157, 77), brightness = 0.0005, distance = 600, hidden = "salon2"},
    -- Interior
    [30]  = { "light",           Vector(465+5  ,   -47, -41), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2 },
    [31]  = { "light",           Vector(465+5  ,   47, -41), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2 },
    [32]  = { "light",           Vector(465+5  ,   0, 46), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2, texture = "sprites/light_glow02", size = 2 },

    Lamps_pult = {"light", Vector(450,-55,31), Angle(0,0,0),Color(255,220,180),brightness = 0.35,scale = 0.4, texture = "sprites/light_glow02", hidden = "Lamps_pult"},
    Lamps_cab = {"light", Vector(412,0,42.5), Angle(0,0,0),Color(255,220,180),brightness = 0.25,scale = 0.3, texture = "sprites/light_glow02", hidden = "Lamps_cab1"},
}
function ENT:Initialize()
    self.BaseClass.Initialize(self)

    self.FrontLeak = 0
    self.RearLeak = 0

    self.CraneRamp = 0
    self.ReleasedPdT = 0
    self.EmergencyValveRamp = 0
    self.EmergencyValveEPKRamp = 0
    self.EmergencyBrakeValveRamp = 0
end
function ENT:UpdateWagonNumber()
    local count = math.max(3,math.ceil(math.log10(self.WagonNumber+1)))
    for i=0,3 do
        self:ShowHide("TrainNumberL"..i,i<count)
        self:ShowHide("TrainNumberR"..i,i<count)
        local leftNum,rightNum = self.ClientEnts["TrainNumberL"..i],self.ClientEnts["TrainNumberR"..i]
        if i<count and self.WagonNumber then
            local num = math.floor(self.WagonNumber%(10^(i+1))/10^i)
            if IsValid(leftNum) then
                leftNum:SetPos(self:LocalToWorld(Vector(400+i*6.6-4*6.6/2,67.5,-26)))
                leftNum:SetSkin(num)
            end
            if IsValid(rightNum) then
                rightNum:SetPos(self:LocalToWorld(Vector(-405-i*6.6-4*6.6/2,-67.4,-26)))
                rightNum:SetSkin(num)
            end
        end
    end
end

local controller = {
    0,0.1,0.2,0.44,0.665,0.76,0.855
}
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
    local half1 = self:GetPackedBool("Lamps_half1")
    local half2 = self:GetPackedBool("Lamps_half2")
    local emer1 = self:GetPackedBool("lamps_emer1")
    local emer2 = self:GetPackedBool("Lamps_emer2")

    local emer1S = self:Animate("lamps_emer1",(not half2 and emer1) and 1 or 0,0,1,5,false)
    local cab1S = self:Animate("lamps_cab1",emer1 and 1 or 0,0,1,5,false)
    local emer2S = self:Animate("lamps_emer2",(not half2 and not half1 and emer2) and 1 or 0,0,1,5,false)
    local half1S = self:Animate("lamps_half1",half1 and 0.4+Lamps*0.6 or 0,0,1,5,false)
    local half2S = self:Animate("lamps_half2",half2 and 0.4+Lamps*0.6 or 0,0,1,5,false)

    self:ShowHideSmooth("Lamps_emer1",emer1S)
    self:ShowHideSmooth("Lamps_cab1",cab1S)
    self:ShowHideSmooth("Lamps_emer2",emer2S)
    self:ShowHideSmooth("Lamps_half1",half1S,Color(255,105+half1S*150,105+half1S*150))
    self:ShowHideSmooth("Lamps_half2",half2S,Color(255,105+half2S*150,105+half2S*150))

    self:SetLightPower(23, cab1S > 0,cab1S)
    self:SetLightPower("Lamps_cab", cab1S > 0,cab1S)
    if not half1 then
        self:SetLightPower(9,emer1S > 0,emer1S*0.2+emer2S*0.8)
        self:SetLightPower(10,emer2S > 0,emer2S)
        self:SetLightPower(11, false)
        self:SetLightPower(12, false)
        self:SetLightPower(13, false)
    else
        self:SetLightPower(9,false)
        self:SetLightPower(10,false)
        self:SetLightPower(11, half1S > 0, half1S*0.3+half2S*0.7)
        self:SetLightPower(12, half1S > 0, half1S*0.3+half2S*0.7)
        self:SetLightPower(13, half1S > 0, half1S*0.3+half2S*0.7)
    end

    self:Animate("UAVALever",   self:GetPackedBool("UAVA") and 1 or 0,     0,0.6, 128,  3,false)
    self:Animate("EmergencyBrakeValve",   self:GetPackedBool("EmergencyBrakeValve") and 1 or 0,     0.5,0, 64,  3,false)

    self:Animate("brake_disconnect",self:GetPackedBool("DriverValveBLDisconnect") and 0 or 1,0.25,0.5,  4,false)
    self:Animate("train_disconnect",self:GetPackedBool("DriverValveTLDisconnect") and 1 or 0,0.25,0,  4,false)

    local HL1 = self:Animate("whitelights",self:GetPackedBool("HeadLights1") and 1 or 0,0,1,5,false)
    local HL2 = self:Animate("distantlights",self:GetPackedBool("HeadLights2") and 1 or 0,0,1,5,false)

    self:ShowHideSmooth("WhiteLights",HL1)
    self:ShowHideSmooth("DistantLights",HL2)
    self:SetLightPower(30,HL1 > 0,HL1)
    self:SetLightPower(31,HL1 > 0,HL1)
    self:SetLightPower(32,HL2 > 0,HL2)

    local PL = HL1*self:Animate("lamps_pult",self:GetPackedBool("PanelLights") and 1 or 0,0,1,12,false)
    self:ShowHideSmooth("Lamps_pult",PL)
    self:SetLightPower(22,PL>0,PL)
    self:SetLightPower("Lamps_pult",PL>0,PL)

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

    -- Simulate pressure gauges getting stuck a little
    self:Animate("brake",1-self:GetPackedRatio("CranePosition"),0.00, 0.48,  256,24)
    self:Animate("controller",controller[self:GetNW2Int("ControllerPosition",0)+1],0.148, 0.333,  2,false)
    self:Animate("reverser",self:GetPackedRatio("ReverserPosition"),0.6, 0.4,  4,false)
    self:Animate("volt1",self:GetPackedRatio("BatteryVoltage"),0.63,0.39,45,3)
    self:Animate("rcureverser",self:GetPackedBool("RCUPosition") and 1 or 0,0,0.5,3,false)
    self:ShowHide("reverser",self:GetNW2Int("WrenchMode",0)==1)
    self:ShowHide("rcureverser",self:GetNW2Int("WrenchMode",0)==3)

    self:Animate("brake_line",self:GetPackedRatio("BLPressure"),0.625, 0.839,  256,2)--,,0.01)
    self:Animate("train_line",self:GetPackedRatio("TLPressure"),0.625, 0.839,  256,2)--,,0.01)
    self:Animate("brake_cylinder",self:GetPackedRatio("BCPressure"),0.04, 0.808,  256,2)--,,0.03)
    self:Animate("voltmeter",self:GetPackedRatio("EnginesVoltage"),0.64,0.355,92,2)
    self:Animate("ampermeter",self:GetPackedRatio("EnginesCurrent"),0.617,0.383,                nil, nil,  92,20,3)

    local wheel_radius = 0.5*44.1 -- units
    local speed = self:GetPackedRatio("Speed")*100
    local ang_vel = speed/(2*math.pi*wheel_radius+math.random(0,40))

    --self:Animate("speed1",        self:GetPackedRatio("Speed") > 0.5 and self:GetPackedRatio("Speed")-(self:GetPackedRatio("Speed")/10*(self:GetPackedRatio("Speed")-0.4)) or self:GetPackedRatio("Speed"),           0.76, 0.9725,               nil, nil,  256,2,0.01)

    local speed1 = math.min(1,self:GetPackedRatio("Speed"))
    -- Rotate wheel
    self:Animate("speed1",      speed1 > 0.41 and speed1-(speed1/12*(speed1-(speed1 > 0.95 and 0.634 or 0.3))) or speed1,           0.269, 0.55,                nil, nil,  256,2,0.01)

    ----
    local door2 = self:Animate("door2", self:GetPackedBool("RearDoor") and 0.99 or 0,0,0.25, 8, 1)
    local door1 = self:Animate("door1", self:GetPackedBool("FrontDoor") and 0.99 or 0,0,0.22, 8, 1)
    local door3 = self:Animate("door3", self:GetPackedBool("PassengerDoor") and 0.99 or 0,1,0.79, 8, 1)
    local door4 = self:Animate("door4", self:GetPackedBool("CabinDoor") and 0.99 or 0,1,0.77, 8, 1)

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
                    if doorstate then
                        self:PlayOnce(sid.."so","",1,math.Rand(0.8,1.2))
                    else
                        self:PlayOnce(sid.."sc","",1,math.Rand(0.8,1.2))
                    end
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

    local rol_motors = math.Clamp((speed-15)/40,0,1)
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
    self:SetSoundState("rolling_medium1",rol40*rollings,rol40p) --57
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
    self:SetSoundState("rk",(CurTime() - (self.RKTimer or 0)) < 0.2 and 0.7 or 0,1)

    local work = self:GetPackedBool("AnnPlay")
    local noise = self:GetNW2Int("AnnouncerBuzz",-1) > 0
    self.NoiseVolume = self.NoiseVolume or 0
    local noisevolume = 1
    if self.Sounds["announcer1"] and IsValid(self.Sounds["announcer1"]) then noisevolume = (1-(self.Sounds["announcer1"]:GetLevel())*math.Rand(0.9,3))*1 end
    if self.NoiseVolume > noisevolume then
        self.NoiseVolume = math.Clamp(self.NoiseVolume + 8*(noisevolume-self.NoiseVolume)*dT,0.1,1)
    else
        self.NoiseVolume = math.Clamp(self.NoiseVolume + 0.5*(noisevolume-self.NoiseVolume)*dT,0.1,1)
    end
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
        if soundid == "LK1" then
            local speed = self:GetPackedRatio("Speed")
            local id = range > 0 and "lk4_on" or "lk4_off"
            self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
            return id,location,1-Lerp(speed/10,0.2,0.8),pitch
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
        if soundid == "M" then
            local speed = self:GetPackedRatio("Speed")
            local id = range > 0 and "lk4_on" or "lk4_off"
            self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
            return id,location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "RKR" then
            local speed = self:GetPackedRatio("Speed")
            self.SoundPositions[soundid][1] = 440-Lerp(speed/0.1,0,330)
            return soundid,location,1-Lerp(speed/10,0.2,0.8),pitch
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

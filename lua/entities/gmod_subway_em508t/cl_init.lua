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
--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.AutoAnimNames = {}
ENT.ClientSounds = {}

-- Main panel
ENT.ButtonMap["Main"] = {
    pos = Vector(451.5+6.6,-31.78,-10.01),
    ang = Angle(0,-88,90-20),
    width = 240,
    height = 200,
    scale = 0.0588,
    hideseat = 0.2,

    buttons = {
        ----Лампы
        {ID = "!RedRP", x=70+33*0,y=22, radius=20, tooltip="", model = {
        sprite = {bright=0.2,size=0.25,scale=0.07,color=Color(255,93,0),z=7,lamp="light_rRP",hidden="ezh3_lrp"}
    }},
        {ID = "!GreenRP",x=70+33*1,y=22, radius=20, tooltip="", model = {
        sprite = {bright=0.2,size=0.25,scale=0.07,color=Color(8, 255, 170),z=7,lamp="Green_rp",hidden="ezh3_lrpgreen"}
    }},
        {ID = "!SD",        x=70+33*3,y=22, radius=20, tooltip="", model = {
        sprite = {bright=0.2,size=0.25,scale=0.07,color=Color(53, 147, 255),z=7,lamp="light_SD",hidden="ezh3_lsd"}
    }},
        ----Кнопки

        {   ID = "KU12Set", x=31, y=90, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudblack.mdl", z=-39,
            var="KU12",speed=9,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {   ID = "KU11Set", x=31+45*1, y=90, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudblack.mdl", z=-39,
            var="KU11",speed=9,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {   ID = "KU9Set",  x=31+45*2, y=90, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudblack.mdl", z=-39,
            var="KU9",speed=9,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {   ID = "KU8Set",  x=31+45*3, y=90, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudblack.mdl", z=-39,
            var="KU8",speed=9,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {   ID = "V2Toggle",    x=31+45*4, y=90, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudblack.mdl", z=-39,
            var="V2",speed=9,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Unlocked","Train.Buttons.Locked"},
        }},
        {   ID = "V1Toggle",    x=31+45*4, y=90+65, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudblack.mdl", z=-45,
            var="V1",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {   ID = "V4Set",   x=31, y=90+65, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudblack.mdl", z=-45,
            var="V4",speed=9,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {   ID = "V5Set",   x=31+45, y=90+65, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudblack.mdl", z=-45,
            var="V5",speed=9,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},

        {   ID = "KU15Set", x=31+45*3, y=90+65, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudblack.mdl", z=-45,
            var="KU15",speed=9,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "KU7Set",         x=28+45*4, y=35, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", z = -3,
            var="KU7",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "V10Set",         x=31, y=35, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", z = -3,
            var="V10",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},

    }
}

--VU Panel
ENT.ButtonMap["VU"] = {
    pos = Vector(456+7.6,-16.15,20.0),
    ang = Angle(0,270,90),
    width = 120,
    height = 120,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "VUToggle", x=60, y=60, radius=60, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            plomb = {model = "models/metrostroi_train/equipment/vu_plomb_right.mdl",ang=Angle(-90,90,0),x=25,y=33.2,z=9.3,var="VUPl", ID="VUPl",},
            var="VU",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}

ENT.ButtonMap["Stopkran"] = {
    pos = Vector(461.6,27,3),
    ang = Angle(0,-90,90),
    width = 200,
    height = 1300,
    scale = 0.1/2,
        buttons = {
            {ID = "EmergencyBrakeValveToggle",x=0, y=0, w=200, h=1300, tooltip="", tooltip="",tooltip="",states={"Train.Buttons.Closed","Train.Buttons.Opened"},var="EmergencyBrakeValve"},
    }
}

ENT.ButtonMap["VU14"] = {
    pos = Vector(467,25.15-1,36.5),
    ang = Angle(0,270,90),
    width = 100,
    height = 220,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {   ID = "VU14Toggle",  x=0, y=110, w=100, h=110, tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            var="VU14",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
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

---AV1 Panel
ENT.ButtonMap["AV1"] = {
    pos = Vector(403.5,39.3,18),
    ang = Angle(0,90,90),
    width = 340,
    height = 140,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "VU3Toggle", x=0, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            var="VU3",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "VU2Toggle", x=120, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            var="VU2",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "VU1Toggle", x=240, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            var="VU1",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
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
    }
}


ENT.ButtonMap["HVMeters"] = {
    pos = Vector(458.3+2,-56.4,34.4),
    ang = Angle(0,-149,90),

    width = 66,
    height = 129,
    scale = 0.0625,

    buttons = {
        {ID = "!EnginesVoltage", x=0,y=0,w=66,h=60,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesVoltage"),ent:GetPackedRatio("EnginesVoltage")*1000) end},
        {ID = "!EnginesCurrent", x=0,y=69,w=66,h=60,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesCurrent"),ent:GetPackedRatio("EnginesCurrent")*1000-500) end},
    }
}

ENT.ButtonMap["BLTLPressure"] = {
    pos = Vector(459.4,-54.8,10.8),
    ang = Angle(0,-90-58,90),

    width = 76,
    height = 76,
    scale = 0.0625,

    buttons = {
        {ID = "!BLTLPressure", x=38,y=38,radius=38,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BLTLPressure"),ent:GetPackedRatio("TLPressure")*16,ent:GetPackedRatio("BLPressure")*16) end},
    }
}
ENT.ButtonMap["BCPressure"] = {
    pos = Vector(461,-50.3,4.1),
    ang = Angle(0,-90-12,90),

    width = 76,
    height = 76,
    scale = 0.0625,

    buttons = {
        {ID = "!BCPressure", x=38,y=38,radius=38,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BCPressure"),ent:GetPackedRatio("BCPressure")*6) end},
    }
}
ENT.ButtonMap["BatteryVoltage"] = {
    pos = Vector(463.2,-17.8,10.9),
    ang = Angle(0,270,90),
    width = 68,
    height = 68,
    scale = 0.0625,

    buttons = {
        {ID = "!BatteryVoltage", x=0,y=0,w=68,h=68,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BatteryVoltage"),ent:GetPackedRatio("BatteryVoltage")*150) end},
    }
}
ENT.ButtonMap["DriverValveBLDisconnect"] = {
    pos = Vector(450.50,-51,-36.5),
    ang = Angle(-90,0,0),
    width = 200,
    height = 100,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveBLDisconnectToggle", x=0, y=0, w=200, h=100, tooltip="", model = {
            var="DriverValveBLDisconnect",sndid="brake_disconnect",
            sndvol = 1, snd = function(val) return "disconnect_valve" end,
            sndmin=30, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
    }
}
ENT.ButtonMap["DriverValveTLDisconnect"] = {
    pos = Vector(447+5,-46,-31),
    ang = Angle(-90,-10,0),
    width = 200,
    height = 90,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveTLDisconnectToggle", x=0, y=0, w=200, h=90, tooltip="", model = {
            var="DriverValveTLDisconnect",sndid="train_disconnect",
            sndvol = 1, snd = function(val) return val and "pneumo_TL_open" or "pneumo_TL_disconnect" end,
            sndmin=30, sndmax = 1e3, sndang = Angle(-90,0,0),
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
    buttons = {
        {ID = "AirDistributorDisconnectToggle",x=0, y=0, w= 170,h = 260, tooltip="",var="AD",states={"Train.Buttons.On","Train.Buttons.Off"}},
    }
}
ENT.ClientProps["tab"] = {
    model = "models/metrostroi_train/Equipment/tab.mdl",
    pos = Vector(16,0,-0),
    ang = Angle(0,0,0),
    skin = 4,
    hide = 2,
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
    pos = Vector(417,64,43.4),
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
    pos = Vector(400,-16,41),
    ang = Angle(0,90,90),
    width = 700,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=700,h=1900, tooltip="", model = {
            var="door3",sndid="door3",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin=90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}

ENT.ButtonMap["PassengerDoor1"] = {
    pos = Vector(400,19,41),
    ang = Angle(0,-90,90),
    width = 700,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=700,h=1900, tooltip=""},
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
          speed=3,
        sndid=button.ID:Replace("Toggle","Fuse"),
        sndvol = 0.3, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
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
        {ID = "PRL29Toggle", x=110+56*1,y=21+27*11,w=40,h=15,tooltip="", model = {
            var="PRL29", speed=3, sndid="fusebox_cover", 
            sndvol = 0.1, snd = function(val) return val and "fuseh_in" or "fuseh_out" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            --noTooltip = true,
            lamp = {
                model = "models/metrostroi_train/81-717/BP15_sg_small.mdl", y = 1.2, ang = Angle(0,90,0), var = "PRL29", anim = true
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
ENT.ClientProps["brake"] = {
    model = "models/metrostroi_train/81-703/cabin_cran_334.mdl",
    pos = Vector(448.62+7.87,-52.46,-4.1),
    ang = Angle(0,-133,0),
    hideseat = 0.2,
}
ENT.ClientProps["controller"] = {
    model = "models/metrostroi_train/81-502/kv_black.mdl",
    pos = Vector(451.36+6.6,-22.73,-5.8),
    ang = Angle(0,180+15,0),
    hideseat = 0.2,
}

ENT.ClientProps["reverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["controller"].pos+Vector(0.2,0,-0.8),
    ang = Angle(180,90,180),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientProps["rcureverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["controller"].pos+Vector(-4.3,-0.1,-1.7),
    ang = Angle(180,180-25,180),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientProps["brake_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran1.mdl",
    pos = Vector(449.90,-56.47,-33.9),
    ang = Angle(7,87,-90),
    hideseat = 0.2,
}
ENT.ClientProps["train_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran3.mdl",
    pos = Vector(453.5,-51.8,-27.5),
    ang = Angle(7,79,-90),
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
    pos = Vector(457.794739,-56.465096,8.386459),
    ang = Angle(223.061493,34.678856,-91.599998),
    hideseat = 0.2,
}
ENT.ClientProps["brake_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_tm.mdl",
    pos = Vector(457.821289,-56.505123,8.385479),
    ang = Angle(223.061493,34.678856,-91.599998),
    hideseat = 0.2,
}



ENT.ClientProps["brake_cylinder"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(461.239777,-52.704826,1.709025),
    ang = Angle(273.924652,82.289345,-94.823410),
    hideseat = 0.2,
}

----------------------------------------------------------------
ENT.ClientProps["ampermeter"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(458.591003,-57.667469,26.812176),
    ang = Angle(-90.053635,-58.525883,0.000000),
    bscale = Vector(1,1,1.3),
    hideseat = 0.2,
}

ENT.ClientProps["voltmeter"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(458.522430,-57.706245,31.200829),
    ang = Angle(-90.053635,-58.525883,0.000000),
    bscale = Vector(1,1,1.3),
    hideseat = 0.2,
}

ENT.ClientProps["volt1"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(463.263306,-19.963984,7.809407),
    ang = Angle(-90.000000,0.000000,0.000000),
    bscale = Vector(1,1,1.3),
    hideseat = 0.2,
}


ENT.ClientProps["ezh3_lsd"] = {
    model = "models/metrostroi_train/81-710/em508t_lsd.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat = 1.0,
}
ENT.ClientProps["ezh3_lrp"] = {
    model = "models/metrostroi_train/81-710/em508t_lrpred.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat = 1.0,
}
ENT.ClientProps["ezh3_lrpgreen"] = {
    model = "models/metrostroi_train/81-710/em508t_lrpgreen.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat = 1.0,
}
--------------------------------------------------------------------------------
ENT.ClientProps["salon"] = {
    model = "models/metrostroi_train/81-710/508t_salon.mdl",
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

ENT.ClientProps["Lamps_pult"] = {
    model = "models/metrostroi_train/equipment/lamp_gauges.mdl",
    pos = Vector(446.027,-55.398,42.27),
    ang = Angle(-4.305,6.175,8),
    hideseat = 0.2,
}
ENT.ClientProps["Lamps_emer1"] = {
    model = "models/metrostroi_train/81-502/lights_emer2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2,
}
ENT.ClientProps["Lamps_emer2"] = {
    model = "models/metrostroi_train/81-502/lights_emer.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
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
ENT.ClientProps["Lamps_cab1"] = {
    model = "models/metrostroi_train/81-502/cabin_lamp_light.mdl",
    pos = Vector(0,-0.05,0),
    ang = Angle(0,0,0),
    hide = 0.8,
}
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
    model = "models/metrostroi_train/81-710/81-710_door_tor.mdl",
    pos = Vector(460.62+7.4,-14.53,-7.6),
    ang = Angle(0,-90,0),
    hide = 2,
}
ENT.ClientProps["door2"] = {
    model = "models/metrostroi_train/81-710/81-710_door_tor.mdl",
    pos = Vector(-469.8,16.53,-8.2),
    ang = Angle(0,90,0),
    hide = 2,
}
ENT.ClientProps["door3"] = {
    model = "models/metrostroi_train/81-710/81-710_door_interior_a.mdl",
    pos = Vector(382.3+19,-15,-7),
    ang = Angle(0,90,0),
    hide = 2,
}
ENT.ClientProps["door4"] = {
    model = "models/metrostroi_train/81-710/81-710_door_cab.mdl",
    pos = Vector(411.17+7.6,66.05,-6.38),
    ang = Angle(0,-90,0),
    hide = 2,
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

    [22] = { "headlight",       Vector(445,-55,41), Angle(75, 70,45), Color(190, 130, 88), fov=110, farz=65, brightness = 3, shadows = 1, texture = "models/metrostroi_train/equipment/headlight", hidden="Lamps_pult"},

    [9] = { "dynamiclight",    Vector(200, 0, -5), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 200},
    [10] = { "dynamiclight",    Vector(-150, 0, -5), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 200},
    [11] = { "dynamiclight",    Vector( 200, 0, -5), Angle(0,0,0), Color(255,220,180), brightness = 4, distance = 260},
    [12] = { "dynamiclight",    Vector(   0, 0, -5), Angle(0,0,0), Color(255,220,180), brightness = 4, distance = 260},
    [13] = { "dynamiclight",    Vector(-260, 0, -5), Angle(0,0,0), Color(255,220,180), brightness = 4, distance = 260},
    [5] =   { "light",           Vector(465+5,-32, 48), Angle(0,0,0), Color(255,50,50),     brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2 },
    [6] =   { "light",           Vector(465+5, 32, 48), Angle(0,0,0), Color(255,50,50),     brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2 },

    -- Cabin
    [23] = { "dynamiclight",        Vector(432,-10.0,20), Angle(0,0,0), Color(252, 157, 77), brightness = 0.0005, distance = 600, hidden = "salon"},

    [30]  = { "light",           Vector(465+5  ,   -45, -37), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2 },
    [31]  = { "light",           Vector(465+5  ,   45, -37), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2 },
    [32]  = { "light",           Vector(465+5  ,   0, 48), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02", size = 2 },

    Lamps_pult = {"light", Vector(445.5,-55.5,42), Angle(0,0,0),Color(255,220,180),brightness = 0.35,scale = 0.4, texture = "sprites/light_glow02", hidden = "Lamps_pult"},
    Lamps_cab = {"light", Vector(404,1.2,56), Angle(0,0,0),Color(255,220,180),brightness = 0.25,scale = 0.3, texture = "sprites/light_glow02", hidden = "Lamps_cab1"},
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
    for i=0,3 do
        local leftNum,rightNum = self.ClientEnts["TrainNumberL"..i],self.ClientEnts["TrainNumberR"..i]
        local num = math.floor(self.WagonNumber%(10^(i+1))/10^i)
        if IsValid(leftNum) then
            leftNum:SetPos(self:LocalToWorld(Vector(295+i*6.6-4*6.6/2,68.8,-26)))
            leftNum:SetSkin(num)
        end
        if IsValid(rightNum) then
            rightNum:SetPos(self:LocalToWorld(Vector(-280-i*6.6-4*6.6/2,-66.1,-26)))
            rightNum:SetSkin(num)
        end
    end
end
--------------------------------------------------------------------------------
function ENT:Think()
    self.BaseClass.Think(self)
    if not self.RenderClientEnts or self.CreatingCSEnts then
        self.Number = 0
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
     
    --Fuses animate
    local fusepanelC = self:HidePanel("FuseboxCoverC", not self:GetPackedBool("FuseboxCover")) 
    local fusepanelC = self:HidePanel("FuseboxCoverO", self:GetPackedBool("FuseboxCover"))
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
    ---
    local HL1 = self:Animate("whitelights",self:GetPackedBool("HeadLights1") and 1 or 0,0,1,5,false)
    local HL2 = self:Animate("distantlights",self:GetPackedBool("HeadLights2") and 1 or 0,0,1,5,false)
    local RL1 = self:Animate("redlight1",self:GetPackedBool("RedLights1") and 1 or 0,0,1,5,false)
    local RL2 = self:Animate("redlight2",self:GetPackedBool("RedLights2") and 1 or 0,0,1,5,false)
    self:SetLightPower(30,HL1 > 0, HL1)
    self:SetLightPower(31,HL1 > 0, HL1)
    self:SetLightPower(32,HL2 > 0, HL2)
    self:ShowHideSmooth("WhiteLights",HL1)
    self:ShowHideSmooth("DistantLights",HL2)
    self:SetLightPower("Lamps_pult",HL1>0,HL1)
    self:ShowHideSmooth("Lamps_pult",HL1)
    self:SetLightPower(22,HL1>0,HL1)
    
    self:ShowHideSmooth("RedLight1",RL1)
    self:ShowHideSmooth("RedLight2",RL2)
    self:SetLightPower(2,RL1 > 0, RL1)
    self:SetLightPower(3,RL2 > 0, RL2)
    self:SetLightPower(5,RL1 > 0, RL1)
    self:SetLightPower(6,RL2 > 0, RL2)

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
    self:SetLightPower("Lamps_cab",cab > 0,cab)
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

    self:Animate("brake_disconnect",self:GetPackedBool("DriverValveBLDisconnect") and 1 or 0,0.5,0.25,  4,false)
    self:Animate("train_disconnect",self:GetPackedBool("DriverValveTLDisconnect") and 1 or 0,0.5,0.25,  4,false)
    self:Animate("EmergencyBrakeValve", self:GetPackedBool("EmergencyBrakeValve") and 1 or 0,0.5,0, 7, false)

    self:Animate("brake", self:GetPackedRatio("CranePosition"), 0.00, 0.48,  256,nil)
    self:Animate("controller",self:GetPackedRatio("ControllerPosition"),0, 0.31,  2,false)
    self:Animate("reverser",self:GetPackedRatio("ReverserPosition"),0.6, 0.4,  4,false)
    self:Animate("rcureverser",self:GetPackedBool("RCUPosition") and 1 or 0,0.77,0,3,false)
    self:Animate("volt1", self:GetPackedRatio("BatteryVoltage"),0.6182,0.39,45,3)

    self:ShowHide("reverser",self:GetNW2Int("WrenchMode",0)==1)
    self:ShowHide("rcureverser",self:GetNW2Int("WrenchMode",0)==3)

    self:ShowHideSmooth("ezh3_lrpgreen",self:Animate("Green_rp",self:GetPackedBool("GRP") and 1 or 0,0,1,5,false))
    self:ShowHideSmooth("ezh3_lrp",self:Animate("light_rRP",self:GetPackedRatio("RRP"),0,1,5,false))
    self:ShowHideSmooth("ezh3_lsd",self:Animate("light_SD",self:GetPackedBool("SD") and 1 or 0,0,1,5,false))
    ---Animate brakes
    self:Animate("brake_line",     self:GetPackedRatio("BLPressure"),0, 0.754, 359,3)--,,0.01)
    self:Animate("train_line",     self:GetPackedRatio("TLPressure"),0, 0.754, 359,3)--,,0.01)
    self:Animate("brake_cylinder", self:GetPackedRatio("BCPressure")^0.98, 0.154, 0.87, 359,3)--,,0.03)
    self:Animate("voltmeter",self:GetPackedRatio("EnginesVoltage"),0.623,0.38,92,2)
    self:Animate("ampermeter",self:GetPackedRatio("EnginesCurrent"),0.629,0.373,92,2)

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
    --ring
    self:SetSoundState("ring",self:GetPackedBool("RingEnabled") and 1 or 0,1)
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


function ENT:DrawPost()
    self:DrawOnPanel("AirDistributor",function()
        draw.DrawText(self:GetNW2Bool("AD") and "Air Distributor ON" or "Air Distributor OFF","Trebuchet24",0,0,Color(0,0,0,255))
    end)
end
function ENT:OnButtonPressed(button)

    if button == "PrevSign" then
        self.InfoTableTimeout = CurTime() + 2.0
    end
    if button == "NextSign" then
        self.InfoTableTimeout = CurTime() + 2.0
    end

    if button and button:sub(1,3) == "Num" then
        self.InfoTableTimeout = CurTime() + 2.0
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
        if soundid == "RO" then
            return range > 0 and "ro_on" or nil,location,1,pitch
        end
        if soundid == "AVU" then
            return range > 0 and "avu_on" or "avu_off",location,1,0.6
        end
        if soundid == "brake" then
            self:PlayOnce("brake_f",location,range,pitch)
            self:PlayOnce("brake_b",location,range,pitch)
            return
        end
    end
    return soundid,location,range,pitch
end


local dist = {
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

local dist = {}
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

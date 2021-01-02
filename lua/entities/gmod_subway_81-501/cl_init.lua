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

---Вагон типа Еж
--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.ClientSounds = {}

local function addTW10Cosume(panelName,ignores)
    for _,button in pairs(ENT.ButtonMap[panelName].buttons) do
        if not button.model or not button.model.lamp then continue end
        if not table.HasValue(ignores or {},button.ID) then
            local rand1 = 0.1
            local rand2 = math.Rand(0.5,3.5)
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

ENT.ButtonMap["PanelLamp"] = {
    pos = Vector(453.7,-57.31,42),
    ang = Angle(180,275,-5),
    width = 100,
    height = 200,
    scale = 0.0588,

    buttons = {
        {ID = "PanelLampToggle", x=0, y=0, w=100, h=200, tooltip=""},
    }
}

ENT.ButtonMap["Main"] = {
    pos = Vector(457.6,-32,-8.0),
    ang = Angle(0,-90,70),
    width = 260,
    height = 240,
    scale = 0.0588,
    hideseat = 0.2,

    buttons = {
        {ID = "!GRP", x=25+41.7*3,y=29, radius=20, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-703/cabin_lamp_green.mdl",color = Color(140,255,255),z = 10, var="GRP",}
        }},
        {ID = "!RRP", x=25+41.7*4,y=29, radius=20, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-703/cabin_lamp_red3.mdl",color = Color(255,160,160),z = 10, var="RRP", getfunc = function(ent,min,max) return ent:GetPackedRatio("RRP") end}
        }},
        {ID = "!SD", x=25+41.7*5,y=29, radius=20, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-703/cabin_lamp_white.mdl",color = Color(255,255,255),z = 10, var="DoorsWC",}
        }},
        {ID = "LOnSet", x=30+40*0, y=100, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="LOn",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "LOffSet", x=30+40*1, y=100, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="LOff",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VozvratRPSet", x=30+40*2, y=100, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="VozvratRP",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KSNSet", x=30+40*3, y=100, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="KSN",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KRZDSet", x=30+40*4, y=100, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="KRZD",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KDLSet", x=30+40*5, y=100, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="KDL",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},

        {ID = "KDPSet", x=40+44.75*1, y=155, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="KDP",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},


        {ID = "VMKToggle",x=28,y=155-5,radius=20, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudwhite.mdl", z=-23,
            var="VMK",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "VUDToggle",x=232,y=155-5,radius=20, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudwhite.mdl", z=-23,
            var="VUD",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}
addTW10Cosume("Main")
--addTW10Cosume("Lamps1_2")
--addTW10Cosume("Lamps1_2")

--VU Panel
ENT.ButtonMap["VU"] = {
    pos = Vector(466.2,-16,14),
    ang = Angle(0,270-7,90),
    width = 100,
    height = 110,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "VUToggle", x=0, y=0, w=100, h=110, tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            plomb = {model = "models/metrostroi_train/equipment/vu_plomb_right.mdl",ang=Angle(-90,90,0),x=25,y=33.2,z=9.3,var="VUPl", ID="VUPl",},
            var="VU",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}

ENT.ButtonMap["Stopkran"] = {
    pos = Vector(463,28.5,5),
    ang = Angle(0,-90,90),
    width = 200,
    height = 1300,
    scale = 0.1/2,
        buttons = {
            {ID = "EmergencyBrakeValveToggle",x=0, y=0, w=200, h=1300, tooltip=""},
    }
}
ENT.ClientProps["stopkran"] = {
    model = "models/metrostroi_train/81-717/stop_spb.mdl",
    pos = Vector(464.5-0.1,24.4,-3),
    ang = Angle(0,270,0),
    hide = 0.8,
}
ENT.ClientSounds["EmergencyBrakeValve"] = {{"stopkran",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}

ENT.ButtonMap["AVMain"] = {
    pos = Vector(403.5,40.8,42),
    ang = Angle(0,90,90),
    width = 290,
    height = 270,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
            {ID = "AVToggle", x=0, y=0, w=290, h=270, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_av8r.mdl",x=-35, y=140, z=55, ang = Angle(90,0,0),
            var="AV",speed=0.85, vmin=0.73,vmax=0.80,
            sndvol = 1, snd = function(val) return val and "av8_on" or "av8_off" end,
        }},
    }
}


ENT.ButtonMap["AV1"] = {
    pos = Vector(403.5,39.2,18),
    ang = Angle(0,90,90),
    width = 320,
    height = 140,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "VU3Toggle", x=0, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            var="VU3",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "VU2Toggle", x=110, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            var="VU2",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "VU1Toggle", x=220, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            var="VU1",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}

-- Battery panel
ENT.ButtonMap["Battery"] = {
    pos = Vector(403.5,22,20.3),
    ang = Angle(0,90,90),
    width = 250,
    height = 140,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "VBToggle", x=0, y=0, w=250, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_black_2.mdl", z=15, ang=Angle(90,0,180),
            labels={
                {model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=3,ang=90,z=20.9,x=-50,y=-12.5},
                {model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=3,ang=90,z=20.9,x=50,y=-12.5},
            },
            var="VB",speed=6,vmin=1,vmax=0,
            sndvol = 1, snd = function(val) return val and "vu223_on" or "vu223_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}

-- Parking brake panel
ENT.ButtonMap["ParkingBrake"] = {
    pos = Vector(457,46,-2.0),
    ang = Angle(0,-83,90),
    width = 340,
    height = 400,
    scale = 0.0625,

    buttons = {
        {ID = "ParkingBrakeLeft",x=0, y=0, w=170, h=400, tooltip=""},
        {ID = "ParkingBrakeRight",x=170, y=0, w=170, h=400, tooltip=""},
    }
}

-- Train driver helpers panel
ENT.ButtonMap["HelperPanel"] = {
    pos = Vector(453.6,59.15,24.5),
    ang = Angle(0,-53,90),
    width = 60,
    height = 280,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "VDLSet", x=10, y=32, w=40,h=80, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudwhite.mdl", z=-19, color = Color(255,255,255),
            var="VDL",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["BCPressure"] = {
    pos = Vector(461,-50.5,7.6),
    ang = Angle(0,-90-30,90),

    width = 76,
    height = 76,
    scale = 0.0625,

    buttons = {
        {ID = "!BCPressure", x=38,y=38,radius=38,tooltip=""},
    }
}
ENT.ButtonMap["BLTLPressure"] = {
    pos = Vector(458,-54.5,7.6),
    ang = Angle(0,-90-30,90),

    width = 76,
    height = 76,
    scale = 0.0625,

    buttons = {
        {ID = "!BLTLPressure", x=38,y=38,radius=38,tooltip=""},
    }
}
ENT.ButtonMap["HVMeters"] = {
    pos = Vector(458.3,-55.4,36),
    ang = Angle(0,-115.3,90),

    width = 66,
    height = 152,
    scale = 0.0625,

    buttons = {
        {ID = "!EnginesVoltage", x=0,y=0,w=66,h=72,tooltip=""},
        {ID = "!EnginesCurrent", x=0,y=79,w=66,h=72,tooltip=""},
    }
}
ENT.ButtonMap["DriverValveBLDisconnect"] = {
    pos = Vector(450.5,-53,-37.61),
    ang = Angle(-90,0,0),
    width = 200,
    height = 90,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveBLDisconnectToggle", x=0, y=0, w=200, h=100, tooltip="", model = {
            var="DriverValveBLDisconnect",sndid="brake_disconnect",
            sndvol = 1, snd = function(val) return "disconnect_valve" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["DriverValveTLDisconnect"] = {
    pos = Vector(447+5,-47,-31),
    ang = Angle(-90,-10,0),
    width = 200,
    height = 90,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveTLDisconnectToggle", x=0, y=0, w=200, h=90, tooltip="", model = {
            var="DriverValveTLDisconnect",sndid="train_disconnect",
            sndvol = 1, snd = function(val) return val and "pneumo_TL_open" or "pneumo_TL_disconnect" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["FrontPneumatic"] = {
    pos = Vector(470,-45.0,-58.0),
    ang = Angle(0,90,90),
    width = 900,
    height = 100,
    scale = 0.1,
    hideseat=0.2,
    hide=true,
    screenHide = true,

    buttons = {
        {ID = "FrontBrakeLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip=""},
        {ID = "FrontTrainLineIsolationToggle",x=500, y=0, w=400, h=100, tooltip=""},
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
    hideseat=0.2,
    hide=true,
    screenHide = true,

    buttons = {
        {ID = "RearBrakeLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip=""},
        {ID = "RearTrainLineIsolationToggle",x=500, y=0, w=400, h=100, tooltip=""},
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
        {ID = "AirDistributorDisconnectToggle",x=0, y=0, w= 170,h = 260, tooltip=""},
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
    pos = Vector(468,16,43.4),
    ang = Angle(0,-90,90),
    width = 650,
    height = 1780,
    scale = 0.1/2,
    buttons = {
        {ID = "FrontDoor",x=0,y=0,w=642,h=1900, tooltip="", model = {
            var="door1",sndid="door1",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
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
            var="door2",sndid="door2",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}

-- AV panel
ENT.ButtonMap["AV"] = {
    pos = Vector(403.5,-58.2,27.5),
    ang = Angle(0,90,90),
    width = 85*7,
    height = 120,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "KSDToggle",x=85*4,y=0,w=85,h=120 , tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=9,ang=90,z=20.9,x=0,y=-12.5}},
            var="KSD",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "KPVUToggle",x=85*5,y=0,w=85,h=120 , tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=10,ang=90,z=20.9,x=0,y=-12.5}},
            var="KPVU",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}

ENT.ButtonMap["FrontDoor"] = {
    pos = Vector(468,16,43.4),
    ang = Angle(0,-90,90),
    width = 650,
    height = 1780,
    scale = 0.1/2,
    buttons = {
        {ID = "FrontDoor",x=0,y=0,w=642,h=1900, tooltip="", model = {
            var="door1",sndid="door1",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["CabinDoor"] = {
    pos = Vector(417,64,43.4),
    ang = Angle(0,0,90),
    width = 680,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoor",x=0,y=0,w=680,h=2000, tooltip="", model = {
            var="door4",sndid="door4",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["PassengerDoor"] = {
    pos = Vector(384+18,-16,38),
    ang = Angle(0,90,90),
    width = 700,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=700,h=1900, tooltip="", model = {
            var="door3",sndid="door3",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["PassengerDoor1"] = {
    pos = Vector(384+18,19,38),
    ang = Angle(0,-90,90),
    width = 700,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=700,h=1900, tooltip=""},
    }
}
ENT.ButtonMap["RearDoor"] = {
    pos = Vector(-470,-16,38),
    ang = Angle(0,90,90),
    width = 700,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=700,h=1900, tooltip="", model = {
            var="door2",sndid="door2",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}
--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false
if not ENT.ClientSounds["br_334"] then ENT.ClientSounds["br_334"] = {} end
table.insert(ENT.ClientSounds["br_334"],{"brake",function(ent,_,var) return "br_334_"..var end,1,1,50,1e3,Angle(-90,0,0)})
ENT.ClientProps["brake"] = {
    model = "models/metrostroi_train/81-703/cabin_cran_334.mdl",
    pos = Vector(456.55,-52.55,-4.5),
    ang = Angle(0,-133,0),
    hideseat = 0.2,
}
ENT.ClientProps["controller"] = {
    model = "models/metrostroi_train/81-502/kv_white.mdl",
    pos = Vector(458.00,-23,-6),
    ang = Angle(0,180+5,0),
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
    pos = ENT.ClientProps["controller"].pos+Vector(-4.5,0.2,-1.5),
    ang = Angle(180,180-25,180),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientProps["brake_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran1.mdl",
    pos = Vector(450,-56.5,-34),
    ang = Angle(0,88,-90),
    hideseat = 0.2,
}
ENT.ClientProps["train_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran3.mdl",
    pos = Vector(453.5,-51.8,-27.33),
    ang = Angle(90,-100,90),
    hideseat = 0.2,
}

ENT.ClientProps["parking_brake"] = {
    model = "models/metrostroi_train/81-703/cabin_parking.mdl",
    pos = Vector(456.8,35,-14.71),
    ang = Angle(-90.00,7,0.00),
    hideseat = 0.2,
}

--------------------------------------------------------------------------------
ENT.ClientProps["train_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(457.085846,-56.869980,5.294523),
    ang = Angle(222.000000,58.730000,-91.599998),
    hideseat = 0.2,
}

ENT.ClientProps["brake_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_tm.mdl",
    pos = Vector(457.045593,-56.880123,5.298195),
    ang = Angle(223.123093,58.730000,-91.599998),
    hideseat = 0.2,
}


ENT.ClientProps["brake_cylinder"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(460.125610,-52.790321,5.260011),
    ang = Angle(222,59.75,-89.15),
    hideseat = 0.2,
}

----------------------------------------------------------------
ENT.ClientProps["voltmeter"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(457.766754,-57.440155,33.01),
    ang = Angle(-90.000000,0.000000,-25.100000),
    hideseat = 0.2,
}
ENT.ClientProps["ampermeter"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(457.750427,-57.475105,28.29),
    ang = Angle(-90.000000,0.000000,-25.100000),
    hideseat = 0.2,
}



ENT.ClientProps["Ema_salon"] = {
    model = "models/metrostroi_train/81-502/ema_salon_501.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2.0,
}
ENT.ClientProps["Ema_salon2"] = {
    model = "models/metrostroi_train/81-508/81-508_underwagon.mdl",
    pos = Vector(0,1,-18),
    ang = Angle(0,0,0),
    hide = 2.0,
}

ENT.ClientProps["bortlamps1"] = {
    model = "models/metrostroi_train/81-502/bort_lamps_body.mdl",
    pos = Vector(414.5,68.5,37),
    ang = Angle(0,0,0),
    hide = 2,
}
ENT.ClientProps["bortlamp1_w"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_b.mdl",
    pos = Vector(414.5,69.4,37+3.25),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamp1_g"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_g.mdl",
    pos = Vector(414.5,69.4,37-0.02),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamp1_y"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_y.mdl",
    pos = Vector(414.5,69.4,37-3.3),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamps2"] = {
    model = "models/metrostroi_train/81-502/bort_lamps_body.mdl",
    pos = Vector(414.5,-65.5,37),
    ang = Angle(0,180,0),
    hide = 2,
}
ENT.ClientProps["bortlamp2_w"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_b.mdl",
    pos = Vector(414.5,-66.4,37+3.25),
    ang = Angle(0,180,0),
    nohide = true,
}
ENT.ClientProps["bortlamp2_g"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_g.mdl",
    pos = Vector(414.5,-66.4,37-0.02),
    ang = Angle(0,180,0),
    nohide = true,
}
ENT.ClientProps["bortlamp2_y"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_y.mdl",
    pos = Vector(414.5,-66.4,37-3.3),
    ang = Angle(0,180,0),
    nohide = true,
}

ENT.ClientProps["Ema_cabine"] = {
    model = "models/metrostroi_train/81-502/ema501_cabine.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2.0,
}


ENT.ClientProps["Lamps_cab1"] = {
    model = "models/metrostroi_train/81-502/cabin_lamp_light.mdl",
    pos = Vector(0,-0.05,-0.2),
    ang = Angle(0,0,0),
    hide = 0.8,
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
    color=Color(255,255,255),
    hide = 1.5,
}
ENT.ClientProps["Lamps_emer2"] = {
    model = "models/metrostroi_train/81-502/lights_emer.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color=Color(255,255,255),
    hide = 1.5,
}
ENT.ClientProps["Lamps_half1"] = {
    model = "models/metrostroi_train/81-502/lights_group1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 1.5,
}
ENT.ClientProps["Lamps_half2"] = {
    model = "models/metrostroi_train/81-502/light_group2_501.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 1.5,
}



--------------------------------------------------------------------------------
-- Add doors
--[=[
local function GetDoorPosition(i,k,j)
    if j == 0
    then return Vector(344.9-0.1*k     - 233.6*i,-63.86*(1-2.02*k),-5.75)
    else return Vector(344.9-0.1*(1-k) - 233.6*i,-63.86*(1-2.02*k),-5.75)
    end
end
for i=0,3 do
    for k=0,1 do
        ENT.ClientProps["door"..i.."x"..k.."a"] = {
            model = "models/metrostroi_train/81-502/81-502_door_right.mdl",
            pos = GetDoorPosition(i,k,0),
            ang = Angle(0,90 + 180*k,0),
            hide = 2.0,
        }
        --[[ ENT.ClientProps["door"..i.."x"..k.."b"] = {
            model = "models/metrostroi_train/81-502/81-502_door_left.mdl",
            pos = GetDoorPosition(i,k,1),
            ang = Angle(0,90 + 180*k,0),
            hide = 2.0,
        }--]]
    end
end--]=]
ENT.ClientProps["door0x1"] = {
    model = "models/metrostroi_train/81-502/81-502_doors_pos1.mdl",
    pos = Vector(344.692,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x1"] = {
    model = "models/metrostroi_train/81-502/81-502_doors_pos2.mdl",
    pos = Vector(110.668,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x1"] = {
    model = "models/metrostroi_train/81-502/81-502_doors_pos3.mdl",
    pos = Vector(-122.718,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x1"] = {
    model = "models/metrostroi_train/81-502/81-502_doors_pos4.mdl",
    pos = Vector(-356.091,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door0x0"] = {
    model = "models/metrostroi_train/81-502/81-502_doors_pos4.mdl",
    pos = Vector(344.692,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x0"] = {
    model = "models/metrostroi_train/81-502/81-502_doors_pos3.mdl",
    pos = Vector(110.668,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x0"] = {
    model = "models/metrostroi_train/81-502/81-502_doors_pos2.mdl",
    pos = Vector(-122.718,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x0"] = {
    model = "models/metrostroi_train/81-502/81-502_doors_pos1.mdl",
    pos = Vector(-356.091,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1"] = {
    model = "models/metrostroi_train/81-502/81-502_door_tor.mdl",
    pos = Vector(460.62+7.4,-14.53,-7.23),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door2"] = {
    model = "models/metrostroi_train/81-502/81-502_door_tor.mdl",
    pos = Vector(-462.6-8,16.53,-7.24),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door3"] = {
    model = "models/metrostroi_train/81-502/81-502_door_interior.mdl",
    pos = Vector(401.50,-15,-7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door4"] = {
    model = "models/metrostroi_train/81-502/81-502_door_cab.mdl",
    pos = Vector(411.17+7.6,66.05,-6.38),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["DistantLights"] = {
    model = "models/metrostroi_train/81-703/81-703_projcetor_light.mdl",
    pos = Vector(-23+8.0,1,-191),
    ang = Angle(00.000000,0.000000,0.000000),
    nohide = true,
}
ENT.ClientProps["WhiteLights"] = {
    model = "models/metrostroi_train/81-703/81-703_front_light.mdl",
    pos = Vector(-23+7.6,1,-191),
    ang = Angle(0,0,0),
    nohide = true,
}

ENT.ClientProps["tab"] = {
    model = "models/metrostroi_train/Equipment/tab.mdl",
    pos = Vector(16,0,-0),
    ang = Angle(0,0,0),
    skin = 6,
    hide = 2.0,
}



ENT.Lights = {
    [1] = { "headlight",        Vector(475,0,-20), Angle(0,0,0), Color(169,130,88), brightness = 3 ,fov = 90, texture = "models/metrostroi_train/equipment/headlight",shadows = 1,headlight=true},
    [22] = { "headlight",       Vector(445,-55,40), Angle(75, 70,45), Color(190, 130, 88), hfov=110, vfov=110,farz=65,brightness = 2,shadows = 1, texture = "effects/flashlight/soft"},
}

function ENT:Initialize()
    self.BaseClass.Initialize(self)

    self.FrontLeak = 0
    self.RearLeak = 0

    self.CraneRamp = 0
    self.ReleasedPdT = 0
    self.EmergencyValveRamp = 0
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
            rightNum:SetPos(self:LocalToWorld(Vector(-280-i*6.6-3*6.6/2,-66.6,-26)))
            rightNum:SetSkin(num)
        end
    end
end

--------------------------------------------------------------------------------
function ENT:Think()
    self.BaseClass.Think(self)
    if not self.RenderClientEnts or self.CreatingCSEnts then
        return
    end

    local Lamps = self:GetPackedRatio("LampsStrength")
    local half1 = self:GetPackedBool("Lamps_half1")
    local half2 = self:GetPackedBool("Lamps_half2")
    local emer1 = self:GetPackedBool("lamps_emer1")
    local emer2 = self:GetPackedBool("Lamps_emer2")
    self:ShowHideSmooth("Lamps_emer1",self:Animate("lamps_emer1",(not half1 and emer1) and 1 or 0,0,1,5,false))
    self:ShowHideSmooth("Lamps_cab1",self:Animate("lamps_cab1",emer1 and 1 or 0,0,1,5,false))
    self:ShowHideSmooth("Lamps_emer2",self:Animate("lamps_emer2",(not half2 and not half1 and emer2) and 1 or 0,0,1,5,false))
    local half1 = self:Animate("lamps_half1",half1 and 0.4+Lamps*0.6 or 0,0,1,5,false)
    local half2 = self:Animate("lamps_half2",half2 and 0.4+Lamps*0.6 or 0,0,1,5,false)
    self:ShowHideSmooth("Lamps_half1",half1,Color(255,105+half1*150,105+half1*150))
    self:ShowHideSmooth("Lamps_half2",half2,Color(255,105+half2*150,105+half2*150))

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

    local HL1 = self:Animate("whitelights",self:GetPackedBool("HeadLights1") and 1 or 0,0,1,5,false)
    local HL2 = self:Animate("distantlights",self:GetPackedBool("HeadLights2") and 1 or 0,0,1,5,false)

    self:ShowHideSmooth("WhiteLights",HL1)
    self:ShowHideSmooth("DistantLights",HL2)

    local PL = HL1*self:Animate("lamps_pult",self:GetPackedBool("PanelLights") and 1 or 0,0,1,12,false)
    self:ShowHideSmooth("Lamps_pult",PL)
    self:SetLightPower(22,IsValid(self.ClientEnts.Lamps_pult) and PL>0,PL)

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

    local Bortlamp_w = self:Animate("Bortlamp_w",self:GetPackedBool("DoorsW") and 1 or 0,0,1,16,false)
    local Bortlamp_g = self:Animate("Bortlamp_g",self:GetPackedBool("GRP") and 1 or 0,0,1,16,false)
    local Bortlamp_y = self:Animate("Bortlamp_y",self:GetPackedBool("BrY") and 1 or 0,0,1,16,false)
    self:ShowHideSmooth("bortlamp1_w",Bortlamp_w)
    self:ShowHideSmooth("bortlamp1_g",Bortlamp_g)
    self:ShowHideSmooth("bortlamp1_y",Bortlamp_y)
    self:ShowHideSmooth("bortlamp2_w",Bortlamp_w)
    self:ShowHideSmooth("bortlamp2_g",Bortlamp_g)
    self:ShowHideSmooth("bortlamp2_y",Bortlamp_y)

    self:Animate("brake_disconnect",self:GetPackedBool("DriverValveBLDisconnect") and 0 or 1,0.25,0.5,  4,false)
    self:Animate("train_disconnect",self:GetPackedBool("DriverValveTLDisconnect") and 1 or 0,0.25,0,  4,false)
    self:Animate("stopkran",   self:GetPackedBool("EmergencyBrakeValve") and 1 or 0,     0,0.23, 256,  3,false)

    -- Simulate pressure gauges getting stuck a little
    self:Animate("brake",self:GetPackedRatio("CranePosition"), 0.00, 0.48, 256, 24)
    self:Animate("controller", self:GetPackedRatio("ControllerPosition"),0, 0.31,2,false)
    self:Animate("reverser",self:GetPackedRatio("ReverserPosition"),0.6, 0.4,  4,false)
    self:Animate("rcureverser",self:GetPackedBool("RCUPosition") and 1 or 0,0.77,0,3,false)

    self:ShowHide("reverser",self:GetNW2Int("WrenchMode",0)==1)
    self:ShowHide("rcureverser",self:GetNW2Int("WrenchMode",0)==3)

    ---Animate brakes
    self:Animate("brake_line",     self:GetPackedRatio("BLPressure")^0.96,0, 0.745, 359,3)--,,0.01)
    self:Animate("train_line",     self:GetPackedRatio("TLPressure")^0.96,0, 0.745, 359,3)--,,0.01)
    self:Animate("brake_cylinder", self:GetPackedRatio("BCPressure"),             0.0, 0.75, 359,3)--,,0.03)
    self:Animate("voltmeter",      self:GetPackedRatio("EnginesVoltage"),              0.631,0.376-0.01,60,3)
    self:Animate("ampermeter",     self:GetPackedRatio("EnginesCurrent"),             0.655,0.35,60,3)

    local door2 = self:Animate("door2", self:GetPackedBool("RearDoor") and 1 or 0,0,0.25, 8, 1)
    local door1 = self:Animate("door1", self:GetPackedBool("FrontDoor") and 1 or 0,0,0.22, 8, 1)
    local door3 = self:Animate("door3", self:GetPackedBool("PassengerDoor") and 1 or 0,1,0.79, 8, 1)
    local door4 = self:Animate("door4", self:GetPackedBool("CabinDoor") and 1 or 0,1,0.77, 8, 1)

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
                --if doorstate and state < 1 or not doorstate and state > 0 then
                --else
                if doorstate and state == 1 or not doorstate and state == 0 then
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
                if dlo <= 0 and self.Anims[n_l].oldspeed then
                    dlo = self.Anims[n_l].oldspeed/14
                end
            end
            self:Animate(n_l,state,0.01,1, dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
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
    --self:SetSoundState("emer_brake",self.EmergencyValveRamp*0.8,1)
    --self:SetSoundState("emer_brake",self.EmergencyValveRamp*0.8,1)

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

    local work = self:GetPackedBool("AnnPlay")
    local noise = self:GetNW2Int("AnnouncerNoise", -1)

    local volume = self:GetNW2Float("UPOVolume",0.6)
    local noisevolume = self:GetNW2Float("UPONoiseVolume",0.6)

    self.BPSNBuzzVolume = self.BPSNBuzzVolume or 0
    local buzzvolume = volume
    if self.Sounds["announcer1"] and IsValid(self.Sounds["announcer1"]) then buzzvolume = (1-(self.Sounds["announcer1"]:GetLevel())*math.Rand(0.9,3))*buzzvolume*2 end
    if self.BPSNBuzzVolume > buzzvolume then
        self.BPSNBuzzVolume = math.Clamp(self.BPSNBuzzVolume + 8*(buzzvolume-self.BPSNBuzzVolume)*dT,0.1,1)
    else
        self.BPSNBuzzVolume = math.Clamp(self.BPSNBuzzVolume + 0.4*(buzzvolume-self.BPSNBuzzVolume)*dT,0.1,1)
    end

    for k,v in ipairs(self.AnnouncerPositions) do
        volume = volume*(v[3] or 1)
        self:SetSoundState("announcer_noiseW"..k,noise>-1 and noisevolume*volume or 0,1)
        for i=1,3 do
            self:SetSoundState(Format("announcer_noise%d_%d",i,k),(work and i==noise) and volume*self.BPSNBuzzVolume*self:GetNW2Float("UPOBuzzVolume",1) or 0,1)
        end
    end
    for k,v in ipairs(self.AnnouncerPositions) do
        if self.Sounds["announcer"..k] and IsValid(self.Sounds["announcer"..k]) then self.Sounds["announcer"..k]:SetVolume(work and v[3]*volume or 0) end
    end
end

function ENT:Draw()
    self.BaseClass.Draw(self)
end
function ENT:DrawPost(special)
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
        if soundid:sub(1,4) == "IGLA" then
            return range > 0 and "igla_on" or "igla_off",location,1,pitch
        end
        if soundid == "LK2" then
            local speed = self:GetPackedRatio("Speed")
            local id = range > 0 and "lk2_on" or "lk2_off"
            self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
            return id,location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "LK5" then
            local speed = self:GetPackedRatio("Speed")
            local id = range > 0 and "lk5_on" or "lk5_off"
            self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
            return id,location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "LK4" then
            local speed = self:GetPackedRatio("Speed")
            local id = range > 0 and "lk4_on" or "lk4_off"
            self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
            return id,location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "KK" then
            return range > 0 and "kk_on" or "kk_off",location,1,pitch--0.8
        end
        if soundid == "RPB" then
            return range > 0 and "rpb_on" or "rpb_off",location,1,pitch
        end
        if soundid == "KD" then
            return range > 0 and "kd_on" or "kd_off",location,1,pitch
        end
        if soundid == "AVU" then
            return range > 0 and "avu_on" or "avu_off",location,1,1
        end
        if soundid == "brake" then
            self:PlayOnce("brake_f",location,range,pitch)
            self:PlayOnce("brake_b",location,range,pitch)
            return
        end
    end
    return soundid,location,range,pitch
end

Metrostroi.GenerateClientProps()

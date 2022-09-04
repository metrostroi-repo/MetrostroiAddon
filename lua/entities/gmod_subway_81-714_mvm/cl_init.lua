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
ENT.ClientSounds = {}
ENT.AutoAnims = {}
ENT.AutoAnimNames = {}

ENT.ClientProps["salon"] = {
    model = "models/metrostroi_train/81-717/interior_mvm_int.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
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
ENT.ClientProps["lamps1"] = {
    model = "models/metrostroi_train/81-717/lamps_type1_int.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=1.5,
}
ENT.ClientProps["lamps2"] = {
    model = "models/metrostroi_train/81-717/lamps_type2_interim.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=1.5,
}
ENT.ClientProps["body_additional"] = {
    model = "models/metrostroi_train/81-717/714_body_additional.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["seats_old"] = {
    model = "models/metrostroi_train/81-717/couch_old_int.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=1.5,
}
ENT.ClientProps["handrails_old"] = {
    model = "models/metrostroi_train/81-717/handlers_old_int.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["seats_new"] = {
    model = "models/metrostroi_train/81-717/couch_new_int.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=1.5,
}
ENT.ClientProps["handrails_new"] = {
    model = "models/metrostroi_train/81-717/handlers_new_int.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["seats_old_cap"] = {
    model = "models/metrostroi_train/81-717/couch_cap_l.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=0.8,
}
ENT.ClientProps["seats_old_cap_o"] = {
    model = "models/metrostroi_train/81-717/couch_cap_l.mdl",
    pos = Vector(-285,410,13),
    ang = Angle(0,70,-70),
    hideseat=0.8,
}
ENT.ClientProps["seats_new_cap"] = {
    model = "models/metrostroi_train/81-717/couch_new_cap.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=0.8,
}
ENT.ClientProps["seats_new_cap_o"] = {
    model = "models/metrostroi_train/81-717/couch_new_cap.mdl",
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
    pos = Vector(449+11, -34, -62),
    ang = Angle( 15,-90,0),
    hide = 2,
}
ENT.ClientProps["FrontTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(449+11, 34, -62),
    ang = Angle(-15,-90,0),
    hide = 2,
}
ENT.ClientSounds["FrontBrakeLineIsolation"] = {{"FrontBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["FrontTrainLineIsolation"] = {{"FrontTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}


ENT.ButtonMap["RearPneumatic"] = {
    pos = Vector(-473-0.5,45.0,-58.0+5),
    ang = Angle(0,270,90),
    width = 1050,
    height = 100,
    scale = 0.1,

    buttons = {
        {ID = "RearTrainLineIsolationToggle",x=500, y=0, w=400, h=100, tooltip="",var="RtI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
        {ID = "RearBrakeLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip="",var="RbI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
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
ENT.ClientSounds["ParkingBrake"] = {{"ParkingBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["RearBrakeLineIsolation"] = {{"RearBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["RearTrainLineIsolation"] = {{"RearTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}

ENT.ButtonMap["GV"] = {
    pos = Vector(-165,-50+20-40,-60+2),
    ang = Angle(0,225-15-180,90),
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
    pos = Vector(-153.5,36+20-115,-78+3),
    ang = Angle(-90,90-180,-90),
    color = Color(150,255,255),
    hide = 0.5,
}
ENT.ClientProps["gv_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["gv"].pos,
    ang = Angle(-90,180,0),
    hide = 0.5,
}

ENT.ButtonMap["AirDistributor"] = {
    pos = Vector(185,68,-50),
    ang = Angle(0,180,90),
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
ENT.ButtonMap["Stopkran"] = {
    pos = Vector(397-13.1,60,0),
    ang = Angle(0,0,70),
    width = 1000,
    height = 600,
    scale = 0.0625,
    hide=0.8,
    buttons = {
        {ID = "EmergencyBrakeValveToggle",x=0,y=0,w=1000,h=600,tooltip="", tooltip="",tooltip="",states={"Train.Buttons.Closed","Train.Buttons.Opened"},var="EmergencyBrakeValve"},
    }
}
ENT.ButtonMap["AV_S"] = {
    pos = Vector(-456,60,-15),
    ang = Angle(0,0,90),
    width = 325,
    height = 205,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "A53Toggle",x=25*0,y=80*0,w=25,h=45,tooltip=""},
        {ID = "A56Toggle",x=25*1,y=80*0,w=25,h=45,tooltip=""},
        {ID = "A54Toggle",x=25*2,y=80*0,w=25,h=45,tooltip=""},
        {ID = "A24Toggle",x=25*3,y=80*0,w=25,h=45,tooltip=""},
        {ID = "A39Toggle",x=25*4,y=80*0,w=25,h=45,tooltip=""},
        {ID = "A23Toggle",x=25*5,y=80*0,w=25,h=45,tooltip=""},
        {ID = "A14Toggle",x=25*6,y=80*0,w=25,h=45,tooltip=""},
        {ID = "A13Toggle",x=25*7,y=80*0,w=25,h=45,tooltip=""},
        {ID = "A32Toggle",x=25*8,y=80*0,w=25,h=45,tooltip=""},
        {ID = "A31Toggle",x=25*9,y=80*0,w=25,h=45,tooltip=""},
        {ID = "A16Toggle",x=25*10,y=80*0,w=25,h=45,tooltip=""},
        {ID = "A12Toggle",x=25*11,y=80*0,w=25,h=45,tooltip=""},
        {ID = "A49Toggle",x=25*12,y=80*0,w=25,h=45,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "A15Toggle",x=25*0,y=80*1,w=25,h=45,tooltip=""},
        {ID = "A27Toggle",x=25*1,y=80*1,w=25,h=45,tooltip=""},
        {ID = "A50Toggle",x=25*2,y=80*1,w=25,h=45,tooltip=""},
        {ID = "A8Toggle",x=25*3,y=80*1,w=25,h=45,tooltip=""},
        {ID = "A52Toggle",x=25*4,y=80*1,w=25,h=45,tooltip=""},
        {ID = "A19Toggle",x=25*5,y=80*1,w=25,h=45,tooltip=""},
        {ID = "A10Toggle",x=25*6,y=80*1,w=25,h=45,tooltip=""},
        {ID = "A22Toggle",x=25*7,y=80*1,w=25,h=45,tooltip=""},
        {ID = "A30Toggle",x=25*8,y=80*1,w=25,h=45,tooltip=""},
        {ID = "A1Toggle",x=25*9,y=80*1,w=25,h=45,tooltip=""},
        {ID = "A2Toggle",x=25*10,y=80*1,w=25,h=45,tooltip=""},
        {ID = "A3Toggle",x=25*11,y=80*1,w=25,h=45,tooltip=""},
        {ID = "A4Toggle",x=25*12,y=80*1,w=25,h=45,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "A5Toggle",x=25*0,y=80*2,w=25,h=45,tooltip=""},
        {ID = "A6Toggle",x=25*1,y=80*2,w=25,h=45,tooltip=""},
        {ID = "A72Toggle",x=25*2,y=80*2,w=25,h=45,tooltip=""},
        {ID = "A38Toggle",x=25*3,y=80*2,w=25,h=45,tooltip=""},
        {ID = "A20Toggle",x=25*4,y=80*2,w=25,h=45,tooltip=""},
        {ID = "A25Toggle",x=25*5,y=80*2,w=25,h=45,tooltip=""},
        {ID = "A37Toggle",x=25*6,y=80*2,w=25,h=45,tooltip=""},
        {ID = "A55Toggle",x=25*7,y=80*2,w=25,h=45,tooltip=""},
        {ID = "A45Toggle",x=25*8,y=80*2,w=25,h=45,tooltip=""},
        {ID = "A66Toggle",x=25*9,y=80*2,w=25,h=45,tooltip=""},
        {ID = "A51Toggle",x=25*10,y=80*2,w=25,h=45,tooltip=""},
        {ID = "A65Toggle",x=25*11,y=80*2,w=25,h=45,tooltip=""},
        {ID = "A28Toggle",x=25*12,y=80*2,w=25,h=45,tooltip=""},
    }
}
for i,button in pairs(ENT.ButtonMap.AV_S.buttons) do
    button.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",
        var=button.ID:Replace("Toggle",""),speed=8,z=-15,
        sndvol = 0.8,snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
    }
    button.ID = "1:"..button.ID
end
ENT.ButtonMap["AV_T"] = {
    pos = Vector(-468,23,-18),
    ang = Angle(0,80,90),
    width = 225,
    height = 45,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "A70Toggle",x=25*0,y=0,w=25,h=45,tooltip=""},
        {ID = "AV2Toggle",x=25*1,y=0,w=25,h=45,tooltip=""},
        {ID = "AV3Toggle",x=25*2,y=0,w=25,h=45,tooltip=""},
        {ID = "AV4Toggle",x=25*3,y=0,w=25,h=45,tooltip=""},
        {ID = "AV5Toggle",x=25*4,y=0,w=25,h=45,tooltip=""},
        {ID = "A18Toggle",x=25*5,y=0,w=25,h=45,tooltip=""},
        --{ID = "A81Toggle",x=25*5,y=0,w=25,h=45,tooltip=""},
        {ID = "AV6Toggle",x=25*6,y=0,w=25,h=45,tooltip=""},
        {ID = "A80Toggle",x=25*7,y=0,w=25,h=45,tooltip=""},
        --{ID = "A18Toggle",x=25*8,y=0,w=25,h=45,tooltip=""},
    }
}
for i,button in pairs(ENT.ButtonMap.AV_T.buttons) do
    button.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",
        var=button.ID:Replace("Toggle",""),speed=8,z=-15,
        sndvol = 0.8,snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
    }
    button.ID = "1:"..button.ID
end

ENT.ButtonMap["DriverValveBLTLDisconnect"] = {
    pos = Vector(-466,44,-18),
    ang = Angle(0,80,90),
    width = 160,
    height = 140,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveBLDisconnectToggle", x=0, y=0, w=80, h=140, tooltip="", model = {
            var="DriverValveBLDisconnect",sndid="brake_disconnect",
            sndvol = 1, snd = function(val) return "disconnect_valve" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
        {ID = "DriverValveTLDisconnectToggle", x=80, y=0, w=80, h=140, tooltip="", model = {
            var="DriverValveTLDisconnect",sndid="train_disconnect",
            sndvol = 1, snd = function(val) return val and "pneumo_TL_open" or "pneumo_TL_disconnect" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
    }
}

ENT.ClientProps["brake_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran1.mdl",
    pos = Vector(-466,47,-24),
    ang = Angle(90,80,90),
    hideseat=0.2,
}
ENT.ClientProps["train_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran3.mdl",
    pos = Vector(-465,51,-24),
    ang = Angle(90,80,90),
    hideseat=0.2,
}
ENT.ClientProps["brake013"] = {
    model = "models/metrostroi_train/81-717/cran13.mdl",
    pos = Vector(-466,49,-10),
    ang = Angle(0,58,0),
    hideseat = 0.2,
}
ENT.ClientProps["brake334"] = {
    model = "models/metrostroi_train/81-703/cabin_cran_334.mdl",
    pos = Vector(-466,49,-10),
    ang = Angle(0,-50,0),
    hideseat = 0.2,
}
if not ENT.ClientSounds["br_013"] then ENT.ClientSounds["br_013"] = {} end
table.insert(ENT.ClientSounds["br_013"],{"brake013",function(ent,_,var) return "br_013" end,0.7,1,50,1e3,Angle(-90,0,0)})
if not ENT.ClientSounds["br_334"] then ENT.ClientSounds["br_334"] = {} end
table.insert(ENT.ClientSounds["br_334"],{"brake334",function(ent,_,var) return "br_334_"..var end,1,1,50,1e3,Angle(-90,0,0)})

ENT.ButtonMap["Shunt"] = {
    pos = Vector(-468,28,-5),
    ang = Angle(0,80,90),
    width = 206,
    height = 200,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "BPSNonToggle",x=39,y=30,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-5,
            var="BPSNon",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "!RZPLight",x=39,y=130,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",z = -4,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=2,x=-0.3,y=-0.3,z=20.6,var="RZP",color=Color(255,60,40)}
        }},
        {ID = "ConverterProtectionSet",x=39,y=180,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="ConverterProtection",speed=16,min=1,max=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "L_1Toggle",x=80,y=30,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-5,
            var="L_1",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end, sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "OtklBVSet",x=80,y=130,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="OtklBV",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button1_off" end, sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "StartSet",x=80,y=180,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="Start",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button2_off" end, sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "VozvratRPSet",x=121,y=180,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="VozvratRP",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button1_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},

        {ID = "RV", x=176, y=140, radius=0, model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_common001.mdl",ang=270,z=12,
            var="RV",speed=2,min=1,max=0.5,getfunc = function(ent) return ent:GetPackedRatio("RV") end,
            sndvol = 0.8, snd = function(_,val) return val%2>0 and "pak_on" or "pak_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID="RV-",x=176-30, y=140-30, w=30,h=60, tooltip="ВТПР(влево)",states={"Train.Buttons.Back","Train.Buttons.0","Train.Buttons.Forward"},varTooltip = function(ent) return ent:GetPackedRatio("RV") end,},
        {ID="RV+",x=176   , y=140-30, w=30,h=60, tooltip="ВТПР(вправо)",states={"Train.Buttons.Back","Train.Buttons.0","Train.Buttons.Forward"},varTooltip = function(ent) return ent:GetPackedRatio("RV") end,},
    }
}

ENT.ButtonMap["VU"] = {
    pos = Vector(-468.7,24,-5),
    ang = Angle(0,80,90),
    width = 60,
    height = 120,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "A84Toggle", x=0, y=0, w=60,h=120, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=-20, ang = Angle(180,-90,0),
            plomb = {model = "models/metrostroi_train/equipment/vu_plomb_right.mdl",ang=Angle(-90,90,0),x=25,y=33.2,z=9.3,var="A84Pl", ID="A84Pl",},
            var="A84",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}

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
    model = "models/metrostroi_train/81-717/door_torec.mdl",
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
    model = "models/metrostroi_train/81-717/door_torec.mdl",
    pos = Vector(-472.5,15.75,-2.7),
    ang = Angle(0,-90,0),
    hide=2,
}

--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false


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
    model = "models/metrostroi_train/81-717/81-717_doors_pos1.mdl",
    pos = Vector(338.445,65.164,0.807),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x1"] = {
    model = "models/metrostroi_train/81-717/81-717_doors_pos2.mdl",
    pos = Vector(108.324,65.164,0.807),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x1"] = {
    model = "models/metrostroi_train/81-717/81-717_doors_pos3.mdl",
    pos = Vector(-121.682,65.164,0.807),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x1"] = {
    model = "models/metrostroi_train/81-717/81-717_doors_pos4.mdl",
    pos = Vector(-351.531,65.164,0.807),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door0x0"] = {
    model = "models/metrostroi_train/81-717/81-717_doors_pos4.mdl",
    pos = Vector(338.445,-65.164,0.807),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x0"] = {
    model = "models/metrostroi_train/81-717/81-717_doors_pos3.mdl",
    pos = Vector(108.324,-65.164,0.807),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x0"] = {
    model = "models/metrostroi_train/81-717/81-717_doors_pos2.mdl",
    pos = Vector(-121.682,-65.164,0.807),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x0"] = {
    model = "models/metrostroi_train/81-717/81-717_doors_pos1.mdl",
    pos = Vector(-351.531,-65.164,0.807),
    ang = Angle(0,90,0),
    hide = 2.0,
}
for i = 0,12 do
    local b = 15--math.random()*15
    local g = 15--b+math.random()*(15-b)
    if math.random() > 0.4 then
        g = math.random()*15
        b = g
    else
        g = 15
        b = -10+math.random()*25
    end
    ENT.ClientProps["lamp1_"..i+1] = {
        model = "models/metrostroi_train/81-717/lamps/lamp_typ1.mdl",
        pos = Vector(394.5- 66.65*i, 0, 67.608),
        ang = Angle(0,0,0),
        color = Color(255,235+g,235+b),
        hideseat = 1.1,
    }
end
for i = 0,26 do
    --[[local r = 15--math.random()*15
    local g = 15--b+math.random()*(15-b)
    if math.random() > 0.4 then
        r = math.random()*15
        g = r
    else
        r = 15
        g = -20+math.random()*20
    end--]]
    ENT.ClientProps["lamp2_"..i+1] = {
        model = "models/metrostroi_train/81-717/lamps/lamp_typ2.mdl",
        pos = Vector(354.1 - 32.832*(i-2),0,68.2),
        ang = Angle(0,0,0),
        --color = Color(245+r,228+g,189),
        color = Color(255,255,255),
        hideseat = 1.1,
    }
end
for i=0,4 do
    ENT.ClientProps["TrainNumberL"..i] = {
        model = "models/metrostroi_train/81-714_mmz/bortnumber_" .. i .. ".mdl",
        pos = Vector(41+16+i*6.6-5*6.6/2,67.4,-17.8),
        ang = Angle(0,90,0),
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
    ENT.ClientProps["TrainNumberR"..i] = {
        model = "models/metrostroi_train/81-714_mmz/bortnumber_" .. i .. ".mdl",
        pos = Vector(64+16-i*6.6-5*6.6/2,-67.4,-17.8),
        ang = Angle(0,270,0),
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end
ENT.Lights = {
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

    [21] = { "light",Vector(-6.5,67,51.2)+Vector(3.25,0.9,-0.02), Angle(0,0,0), Color(254,254,254), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [22] = { "light",Vector(-6.5,67,51.2)+Vector(-0.06,0.9,-0.02), Angle(0,0,0), Color(40,240,122), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [23] = { "light",Vector(-6.5,67,51.2)+Vector(-3.33,0.9,-0.02), Angle(0,0,0), Color(254,210,18), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [24] = { "light",Vector(-6.5,-67,51.2)+Vector(3.33,-0.9,-0.02), Angle(0,0,0), Color(254,254,254), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [25] = { "light",Vector(-6.5,-67,51.2)+Vector(0.06,-0.9,-0.02), Angle(0,0,0), Color(40,240,122), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [26] = { "light",Vector(-6.5,-67,51.2)+Vector(-3.28,-0.9,-0.02), Angle(0,0,0), Color(254,210,18), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
}
--------------------------------------------------------------------------------
local bortnumber_format = "models/metrostroi_train/81-714_mmz/bortnumber_%d.mdl"
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
                leftNum:SetModel(Format(bortnumber_format, num))
            end
            if IsValid(rightNum) then
                rightNum:SetPos(self:LocalToWorld(Vector(64+16-i*6.6-count*6.6/2,-67.4,-17.8)))
                rightNum:SetModel(Format(bortnumber_format, num))
            end
        end
    end
end
function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.CraneRamp = 0
    self.CraneLRamp = 0
    self.CraneRRamp = 0
    self.EmergencyBrakeValveRamp = 0
    self.ReleasedPdT = 0
    self.FrontLeak = 0
    self.RearLeak = 0

    self.VentG1 = 0
    self.VentG2 = 0

    self.Door1 = false
    self.Door2 = false

    self.ParkingBrake1 = true
    self.ParkingBrake2 = true
    self.DoorStates = {}
    self.DoorLoopStates = {}
    for i=0,3 do
        for k=0,1 do
            self.DoorStates[(k==1 and "DoorL" or "DoorR")..(i+1)] = false
        end
    end
end
--------------------------------------------------------------------------------
local Cpos = {
    0,0.2,0.4,0.5,0.6,0.8,1
}
function ENT:Think()
    self.BaseClass.Think(self)
    if self.FirstTick~=false and (not self.RenderClientEnts or self.CreatingCSEnts) then
        self.RKTimer = nil
        self.OldBPSNType = nil
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
    self:ShowHideSmooth("bortlamp3_w",Bortlamp_w)
    self:ShowHideSmooth("bortlamp3_g",Bortlamp_g)
    self:ShowHideSmooth("bortlamp3_y",Bortlamp_y)
    self:ShowHideSmooth("bortlamp4_w",Bortlamp_w)
    self:ShowHideSmooth("bortlamp4_g",Bortlamp_g)
    self:ShowHideSmooth("bortlamp4_y",Bortlamp_y)
    self:SetLightPower(15, Bortlamp_w > 0, Bortlamp_w)
    self:SetLightPower(18, Bortlamp_w > 0, Bortlamp_w)
    self:SetLightPower(16, Bortlamp_g > 0, Bortlamp_g)
    self:SetLightPower(19, Bortlamp_g > 0, Bortlamp_g)
    self:SetLightPower(17, Bortlamp_y > 0, Bortlamp_y)
    self:SetLightPower(20, Bortlamp_y > 0, Bortlamp_y)

    local dot5 = self:GetNW2Bool("Dot5")
    local lvz = self:GetNW2Bool("LVZ")
    local custom = self:GetNW2Bool("Custom")
    local newSeats = self:GetNW2Bool("NewSeats")
    self:ShowHide("handrails_old",not dot5)
    self:ShowHide("handrails_new",dot5)
    self:ShowHide("seats_old",not newSeats)
    self:ShowHide("seats_new",newSeats)

    local capOpened = self:GetPackedBool("CouchCap")
    local c013 = self:GetPackedBool("Crane013")
    self:ShowHide("seats_old_cap_o",capOpened and not newSeats)
    self:ShowHide("seats_old_cap",not capOpened and not newSeats)
    self:ShowHide("seats_new_cap_o",capOpened and newSeats)
    self:ShowHide("seats_new_cap",not capOpened and newSeats)
    self:HidePanel("couch_cap",capOpened)
    self:HidePanel("couch_cap_o",not capOpened)
    self:HidePanel("AV_S",not capOpened)
    self:HidePanel("AV_T",not capOpened)
    -- self:HidePanel("Stopkran",not capOpened)
    self:ShowHide("otsek_cap_r",not capOpened)
    self:ShowHide("brake334",capOpened and not c013)
    self:ShowHide("brake013",capOpened and c013)
    self:ShowHide("brake_disconnect",capOpened)
    self:ShowHide("train_disconnect",capOpened)
    self:HidePanel("DriverValveBLTLDisconnect",not capOpened)
    self:HidePanel("Shunt",not capOpened)
    self:HidePanel("VU",not capOpened)

    self:Animate("brake_disconnect",self:GetPackedBool("DriverValveBLDisconnect") and 1 or 0,0.25,0,  4,false)
    self:Animate("train_disconnect",self:GetPackedBool("DriverValveTLDisconnect") and 1 or 0,0.25,0,  4,false)
    self:Animate("brake334",self:GetPackedRatio("CranePosition")/5,0.35,0.65,256,24)
    self:Animate("brake013",Cpos[self:GetPackedRatio("CranePosition")] or 0, 0.03, 0.458,  256,24)

    self:Animate("brake_line",      self:GetPackedRatio("BLPressure"),0.14, 0.875,  256,2)--,,0.01)
    self:Animate("train_line",      self:GetPackedRatio("TLPressure"),0.14, 0.875,  256,2)--,,0.01)
    self:Animate("brake_cylinder",  self:GetPackedRatio("BCPressure"),0.14, 0.875,  256,2)--,,0.03)
    self:Animate("voltmeter",       self:GetPackedRatio("BatteryVoltage"),0.601, 0.400)
    self:Animate("ampermeter",      0.5+self:GetPackedRatio("BatteryCurrent"),0.604, 0.398)

    local typ = self:GetNW2Int("LampType",1)
    if self.LampType ~= typ then
        self.LampType = typ
        for i=1,27 do
            if i<=13 then
                self:ShowHide("lamp1_"..i,typ==1)
            end
            self:ShowHide("lamp2_"..i,typ==2)
        end
        self:ShowHide("lamps1",typ==1)
        self:ShowHide("lamps2",typ==2)
    end
    local activeLights = 0
    local maxLights
    if typ == 1 then
        for i = 1,13 do
            local colV = self:GetNW2Vector("lamp"..i)
            local col = Color(colV.x,colV.y,colV.z)
            local state = self:Animate("Lamp1_"..i,self:GetPackedBool("lightsActive"..i) and 1 or 0,0,1,6,false)
            self:ShowHideSmooth("lamp1_"..i,state,col)
            activeLights = activeLights + state
        end
        maxLights = 13
    else
        for i = 1,27 do
            local colV = self:GetNW2Vector("lamp"..i)
            local col = Color(colV.x,colV.y,colV.z)
            local state = self:Animate("Lamp2_"..i,self:GetPackedBool("lightsActive"..i) and 1 or 0,0,1,6,false)
            self:ShowHideSmooth("lamp2_"..i,state,col)
            activeLights = activeLights + state
        end
        maxLights = 27
    end
    for i=11,13 do
        local col = self:GetNW2Vector("lampD"..i)
        if self.LightsOverride[i].vec ~= col then
            self.LightsOverride[i].vec = col
            self.LightsOverride[i][4] = Color(col.x,col.y,col.z)
            self:SetLightPower(i, false)
        else
            self:SetLightPower(i, activeLights > 0,activeLights/maxLights)
        end
    end

    local door1 = self:Animate("door1", self:GetPackedBool("FrontDoor") and 0.99 or 0,0,0.25, 4, 0.5)
    local door2 = self:Animate("door2", self:GetPackedBool("RearDoor") and (capOpened and 0.25 or 0.99) or 0,0,0.25, 4, 0.5)

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

    -- Main switch
    if self.LastGVValue ~= self:GetPackedBool("GV") then
        self.ResetTime = CurTime()+1.5
        self.LastGVValue = self:GetPackedBool("GV")
    end
    self:Animate("gv_wrench",self.LastGVValue and 1 or 0,0.5,0.9,128,1,false)
    self:ShowHideSmooth("gv_wrench",    CurTime() < self.ResetTime and 1 or 0.1)

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
            self:Animate(n_l,state,0,0.95, dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
            --self:Animate(n_r,state,0,1, dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
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
        self:SetSoundState("crane013_brake",math.Clamp(-self.CraneRamp*1.5-0.1,0,1)^1.3,1.0)
        local loudV = self:GetNW2Float("Crane013Loud",0)
        if loudV>0 then
            if ramp>0 then
                self.CraneLRamp = self.CraneLRamp + (math.min(ramp,0)-self.CraneLRamp)*dT*0.5
            else
                self.CraneLRamp = self.CraneLRamp + (math.min(ramp,0)-self.CraneLRamp)*dT*1
            end
            self:SetSoundState("crane013_brake_l",(math.Clamp(-self.CraneRamp*2.5-0.1,0,1)^1.3)*(1-math.Clamp((-self.CraneLRamp-loudV)*3,0,1)),1.12-math.Clamp((-self.CraneLRamp-0.15)*2,0,1)*0.12)
        else
            self:SetSoundState("crane013_brake_l",0,1)
        end
        self:SetSoundState("crane013_brake2",math.Clamp(-self.CraneRamp*1.5-0.95,0,1.5)^2,1.0)
    else
        self:SetSoundState("crane013_brake",0,1.0)
        self:SetSoundState("crane013_release",0,1.0)
        --self:SetSoundState("crane013_brake2",0,1.0)

        self.CraneRamp = math.Clamp(self.CraneRamp + 8.0*((1*self:GetPackedRatio("Crane_dPdT",0))-self.CraneRamp)*dT,-1,1)

        self:SetSoundState("crane334_brake_low",math.Clamp((-self.CraneRamp)*2,0,1)^2,1)
        local high = math.Clamp(((-self.CraneRamp)-0.5)/0.5,0,1)^1
        self:SetSoundState("crane334_brake_high",high,1.0)
        self:SetSoundState("crane013_brake2",high*2,1.0)
        self:SetSoundState("crane334_brake_eq_high",--[[ math.Clamp(-self.CraneRamp*0,0,1)---]] math.Clamp(-self:GetPackedRatio("ReservoirPressure_dPdT")-0.2,0,1)^0.8*1,1)
        self:SetSoundState("crane334_brake_eq_low",--[[ math.Clamp(-self.CraneRamp*0,0,1)---]] math.Clamp(-self:GetPackedRatio("ReservoirPressure_dPdT")-0.4,0,1)^0.8*1.3,1)

        self:SetSoundState("crane334_release",math.Clamp(self.CraneRamp,0,1)^2,1.0)
    end
    local emergencyBrakeValve = self:GetPackedRatio("EmergencyBrakeValve_dPdT", 0)
    self.EmergencyBrakeValveRamp = math.Clamp(self.EmergencyBrakeValveRamp + (emergencyBrakeValve-self.EmergencyBrakeValveRamp)*dT*8,0,1)
    self:SetSoundState("valve_brake",self.EmergencyBrakeValveRamp,0.8+math.min(0.4,self.EmergencyBrakeValveRamp*0.8))

    -- Compressor
    self:SetSoundState("compressor",self:GetPackedBool("Compressor") and 0.6 or 0,1)
    self:SetSoundState("compressor2",self:GetPackedBool("Compressor") and 0.8 or 0,1)

    local v1state = self:GetPackedBool("M1_3") and 1 or 0
    local v2state = self:GetPackedBool("M4_7") and 1 or 0
    self.VentG1 = math.Clamp(self.VentG1 + dT/2.7*(v1state*2-1),0,1)
    self.VentG2 = math.Clamp(self.VentG2 + dT/2.7*(v2state*2-1),0,1)

    for i=1,8 do
        if i<4 or i==8 then
            self:SetSoundState("vent"..i,self.VentG1,1)
        else
            self:SetSoundState("vent"..i,self.VentG2,1)
        end
    end

    -- RK rotation
    if self:GetPackedBool("RK") then self.RKTimer = CurTime() end
    self:SetSoundState("rk",(self.RKTimer and (CurTime() - self.RKTimer) < 0.2) and 0.7 or 0,1)

    -- BPSN sound
    self.BPSNType = self:GetNW2Int("BPSNType",13)
    if not self.OldBPSNType then self.OldBPSNType = self.BPSNType end
    if self.BPSNType ~= self.OldBPSNType then
        for i=1,12 do
            self:SetSoundState("bpsn"..i,0,1.0)
        end
    end
    self.OldBPSNType = self.BPSNType
    if self.BPSNType<13 then
        self:SetSoundState("bpsn"..self.BPSNType,self:GetPackedBool("BPSN") and 1 or 0,1) --FIXME громкость по другому
    end

    local work = self:GetPackedBool("AnnPlay")
    local buzz = self:GetPackedBool("AnnBuzz") and self:GetNW2Int("AnnouncerBuzz",-1) > 0
    local buzz_old = self:GetNW2Int("AnnouncerBuzz",-1) == 2
    for k in ipairs(self.AnnouncerPositions) do
        self:SetSoundState("announcer_buzz"..k,(buzz and work and not buzz_old) and 1 or 0,1)
        self:SetSoundState("announcer_buzz_o"..k,(buzz and work and buzz_old) and 1 or 0,1)
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
            self.SoundPositions["lk5_on"][1] = 440-Lerp(speed/0.1,0,330)
            return "lk5_on",location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "brake" then
            self:PlayOnce("brake_f",location,range,pitch)
            self:PlayOnce("brake_b",location,range,pitch)
            return
        end
        if soundid == "KK" then
            return range > 0 and "kk_on" or "kk_off",location,1,0.8
        end
    end
    return soundid,location,range,pitch
end
Metrostroi.GenerateClientProps()

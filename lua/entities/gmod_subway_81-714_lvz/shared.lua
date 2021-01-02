ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "Metrostroi (trains)"
ENT.SkinsType = "81-714_mvm"
ENT.Model = "models/metrostroi_train/81-717/81-717_spb_int.mdl"

ENT.Spawnable       = true
ENT.AdminSpawnable  = false
ENT.DontAccelerateSimulation = false

function ENT:PassengerCapacity()
    return 300
end

function ENT:GetStandingArea()
    return Vector(-450,-30,-48),Vector(380,30,-48)
end

local function GetDoorPosition(i,k)
    return Vector(359.0 - 35/2 - 229.5*i,-65*(1-2*k),7.5)
end
ENT.AnnouncerPositions = {
    {Vector(-3,-60, 62),300,0.2},
    {Vector(-3,60 ,62),300,0.2},
}
ENT.Cameras = {
    {Vector(-434,20,-13),Angle(0,135,0),"Train.714.Shunt","Shunt"},
    {Vector(450+7,0,30),Angle(60,0,0),"Train.Common.CouplerCamera"},
    {Vector(-471,0,30),Angle(60,180,0),"Train.Common.CouplerCamera"},
}
function ENT:InitializeSounds()
    self.BaseClass.InitializeSounds(self)
    self.SoundNames["rolling_5"] = {loop=true,"subway_trains/common/junk/junk_background3.wav"}
    self.SoundNames["rolling_10"] = {loop=true,"subway_trains/717/rolling/10_rolling.wav"}
    self.SoundNames["rolling_40"] = {loop=true,"subway_trains/717/rolling/40_rolling.wav"}
    self.SoundNames["rolling_70"] = {loop=true,"subway_trains/717/rolling/70_rolling.wav"}
    self.SoundNames["rolling_80"] = {loop=true,"subway_trains/717/rolling/80_rolling.wav"}
    self.SoundPositions["rolling_5"] = {480,1e12,Vector(0,0,0),0.15}
    self.SoundPositions["rolling_10"] = {480,1e12,Vector(0,0,0),0.20}
    self.SoundPositions["rolling_40"] = {480,1e12,Vector(0,0,0),0.55}
    self.SoundPositions["rolling_70"] = {480,1e12,Vector(0,0,0),0.60}
    self.SoundPositions["rolling_80"] = {480,1e12,Vector(0,0,0),0.75}
    self.SoundNames["rolling_motors"] = {loop=true,"subway_trains/common/junk/wind_background1.wav"}
    self.SoundNames["rolling_motors2"] = {loop=true,"subway_trains/common/junk/wind_background1.wav"}
    self.SoundPositions["rolling_motors"] = {250,1e12,Vector(200,0,0),0.33}
    self.SoundPositions["rolling_motors2"] = {250,1e12,Vector(-250,0,0),0.33}
    self.SoundNames["rolling_low"] = {loop=true,"subway_trains/717/rolling/rolling_outside_low.wav"}
    self.SoundNames["rolling_medium1"] = {loop=true,"subway_trains/717/rolling/rolling_outside_medium1.wav"}
    self.SoundNames["rolling_medium2"] = {loop=true,"subway_trains/717/rolling/rolling_outside_medium2.wav"}
    self.SoundNames["rolling_high2"] = {loop=true,"subway_trains/717/rolling/rolling_outside_high2.wav"}
    self.SoundPositions["rolling_low"] = {480,1e12,Vector(0,0,0),0.6}
    self.SoundPositions["rolling_medium1"] = {480,1e12,Vector(0,0,0),0.90}
    self.SoundPositions["rolling_medium2"] = {480,1e12,Vector(0,0,0),0.90}
    self.SoundPositions["rolling_high2"] = {480,1e12,Vector(0,0,0),1.00}

    self.SoundNames["pneumo_disconnect2"] = "subway_trains/common/pneumatic/pneumo_close.mp3"
    self.SoundNames["pneumo_disconnect1"] = {
        "subway_trains/common/pneumatic/pneumo_open.mp3",
        "subway_trains/common/pneumatic/pneumo_open2.mp3",
    }
    self.SoundPositions["pneumo_disconnect2"] = {60,1e9,Vector(431.8,-24.1+1.5,-33.7),1}
    self.SoundPositions["pneumo_disconnect1"] = {60,1e9,Vector(431.8,-24.1+1.5,-33.7),1}

    --self.SoundNames["avu_off"] = "subway_trains/717/relays/lsd_2.mp3"
    --self.SoundNames["avu_on"] = "subway_trains/717/relays/relay_on.mp3"
    --self.SoundPositions["avu_off"] = {60,1e9, Vector(436.0,-63,-25),1}
    --self.SoundNames["r1_5_close"] = {"subway_trains/drive_on3.wav","subway_trains/drive_on4.wav"}
    self.SoundNames["bpsn1"] = {"subway_trains/717/bpsn/bpsn_piter.wav", loop=true}
    self.SoundNames["bpsn2"] = {"subway_trains/717/bpsn/bpsn_spb.wav", loop=true}
    self.SoundNames["bpsn3"] = {"subway_trains/717/bpsn/bpsn_nnov.wav", loop=true}
    self.SoundNames["bpsn4"] = {"subway_trains/717/bpsn/bpsn_1.wav", loop=true}
    self.SoundPositions["bpsn1"] = {500,1e9,Vector(0,45,-448),0.04}
    self.SoundPositions["bpsn2"] = {500,1e9,Vector(0,45,-448),0.025}
    self.SoundPositions["bpsn3"] = {500,1e9,Vector(0,45,-448),0.03}
    self.SoundPositions["bpsn4"] = {500,1e9,Vector(0,45,-448),0.02}

    --Подвагонка
    self.SoundNames["lk2_on"] = "subway_trains/717/pneumo/lk2_on.mp3"
    self.SoundNames["lk5_on"] = "subway_trains/717/pneumo/lk1_on.mp3"
    self.SoundNames["lk2_off"] = "subway_trains/717/pneumo/lk2_off.mp3"
    self.SoundNames["lk3_on"] = "subway_trains/717/pneumo/lk3_on.mp3"
    self.SoundNames["lk3_off"] = "subway_trains/717/pneumo/lk3_off.mp3"
    --self.SoundNames["ksh1_off"] = "subway_trains/717/pneumo/ksh1.mp3"
    self.SoundPositions["lk2_on"] = {440,1e9,Vector(-60,-40,-66),0.22}
    self.SoundPositions["lk5_on"] = {440,1e9,Vector(-60,-40,-66),0.30}
    self.SoundPositions["lk2_off"] = self.SoundPositions["lk2_on"]
    self.SoundPositions["lk3_on"] = self.SoundPositions["lk2_on"]
    self.SoundPositions["lk3_off"] = self.SoundPositions["lk2_on"]

    self.SoundNames["compressor"] = {loop=2.0,"subway_trains/d/pneumatic/compressor/compessor_d_start.wav","subway_trains/d/pneumatic/compressor/compessor_d_loop.wav", "subway_trains/d/pneumatic/compressor/compessor_d_end.wav"}
    self.SoundNames["compressor2"] = {loop=1.79,"subway_trains/717/compressor/compressor_717_start2.wav","subway_trains/717/compressor/compressor_717_loop2.wav", "subway_trains/717/compressor/compressor_717_stop2.wav"}
    self.SoundPositions["compressor"] = {600,1e9,Vector(-118,-40,-66),0.15}
    self.SoundPositions["compressor2"] = {480,1e9,Vector(-118,-40,-66),0.55}
    self.SoundNames["rk"] = {loop=0.8,"subway_trains/717/rk/rk_start.wav","subway_trains/717/rk/rk_spin.wav","subway_trains/717/rk/rk_stop.mp3"}
    self.SoundPositions["rk"] = {70,1e3,Vector(110,-40,-75),0.5}

    for i=1,8 do
        self.SoundNames["vent"..i] = {loop=true,"subway_trains/717/vent/vent_cab_"..(i>=7 and "low" or "high")..".wav"}
    end
    self.SoundPositions["vent1"] = {160,1e9,Vector(225,  -50, -37.5)}
    self.SoundPositions["vent2"] = {160,1e9,Vector(-5,    50, -37.5)}
    self.SoundPositions["vent3"] = {160,1e9,Vector(-230, -50, -37.5)}
    self.SoundPositions["vent8"] = {120,1e9,Vector(416,   50, -37.5)}
    self.SoundPositions["vent4"] = {160,1e9,Vector(225,   50, -37.5)}
    self.SoundPositions["vent5"] = {160,1e9,Vector(-5,   -50, -37.5)}
    self.SoundPositions["vent6"] = {160,1e9,Vector(-230,  50, -37.5)}
    self.SoundPositions["vent7"] = {120,1e9,Vector(-432, -50, -37.5)}

    self.SoundNames["vu22_on"] = {"subway_trains/ezh3/vu/vu22_on1.mp3", "subway_trains/ezh3/vu/vu22_on2.mp3", "subway_trains/ezh3/vu/vu22_on3.mp3"}
    self.SoundNames["vu22_off"] = {"subway_trains/ezh3/vu/vu22_off1.mp3", "subway_trains/ezh3/vu/vu22_off2.mp3", "subway_trains/ezh3/vu/vu22_off3.mp3"}
    self.SoundNames["switch_off"] = {
        "subway_trains/717/switches/tumbler_slim_off1.mp3",
        "subway_trains/717/switches/tumbler_slim_off2.mp3",
        "subway_trains/717/switches/tumbler_slim_off3.mp3",
        "subway_trains/717/switches/tumbler_slim_off4.mp3",
    }
    self.SoundNames["switch_on"] = {
        "subway_trains/717/switches/tumbler_slim_on1.mp3",
        "subway_trains/717/switches/tumbler_slim_on2.mp3",
        "subway_trains/717/switches/tumbler_slim_on3.mp3",
        "subway_trains/717/switches/tumbler_slim_on4.mp3",
    }
    self.SoundNames["button1_off"] = {
        "subway_trains/717/switches/button1_off1.mp3",
        "subway_trains/717/switches/button1_off2.mp3",
        "subway_trains/717/switches/button1_off3.mp3",
    }
    self.SoundNames["button1_on"] = {
        "subway_trains/717/switches/button1_on1.mp3",
        "subway_trains/717/switches/button1_on2.mp3",
        "subway_trains/717/switches/button1_on3.mp3",
    }
    self.SoundNames["button2_off"] = {
        "subway_trains/717/switches/button2_off1.mp3",
        "subway_trains/717/switches/button2_off2.mp3",
    }
    self.SoundNames["button2_on"] = {
        "subway_trains/717/switches/button2_on1.mp3",
        "subway_trains/717/switches/button2_on2.mp3",
    }
    self.SoundNames["button3_off"] = {
        "subway_trains/717/switches/button3_off1.mp3",
        "subway_trains/717/switches/button3_off2.mp3",
    }
    self.SoundNames["button3_on"] = {
        "subway_trains/717/switches/button3_on1.mp3",
        "subway_trains/717/switches/button3_on2.mp3",
    }

    self.SoundPositions["uava_reset"] = {80,1e9,Vector(429.6,-60.8,-15.9),0.95}
    self.SoundNames["gv_f"] = {"subway_trains/717/kv70/reverser_0-b_1.mp3","subway_trains/717/kv70/reverser_0-b_2.mp3"}
    self.SoundNames["gv_b"] = {"subway_trains/717/kv70/reverser_b-0_1.mp3","subway_trains/717/kv70/reverser_b-0_2.mp3"}

    self.SoundNames["pneumo_TL_open"] = {
        "subway_trains/ezh3/pneumatic/brake_line_on.mp3",
        "subway_trains/ezh3/pneumatic/brake_line_on2.mp3",
    }
    self.SoundNames["pneumo_TL_disconnect"] = {
        "subway_trains/common/334/334_close.mp3",
    }
    self.SoundPositions["pneumo_TL_open"] = {60,1e9,Vector(431.8,-24.1+1.5,-33.7),0.7}
    self.SoundPositions["pneumo_TL_disconnect"] = {60,1e9,Vector(431.8,-24.1+1.5,-33.7),0.7}
    self.SoundNames["pneumo_BL_disconnect"] = {
        "subway_trains/common/334/334_close.mp3",
    }
    self.SoundNames["disconnect_valve"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"

    self.SoundNames["brake_f"] = {"subway_trains/common/pneumatic/vz_brake_on2.mp3","subway_trains/common/pneumatic/vz_brake_on3.mp3","subway_trains/common/pneumatic/vz_brake_on4.mp3"}
    self.SoundPositions["brake_f"] = {50,1e9,Vector(317-8,0,-82),0.13}
    self.SoundNames["brake_b"] = self.SoundNames["brake_f"]
    self.SoundPositions["brake_b"] = {50,1e9,Vector(-317+0,0,-82),0.13}
    self.SoundNames["release1"] = {loop=true,"subway_trains/common/pneumatic/release_0.wav"}
    self.SoundPositions["release1"] = {350,1e9,Vector(-183,0,-70),1}
    self.SoundNames["release2"] = {loop=true,"subway_trains/common/pneumatic/release_low.wav"}
    self.SoundPositions["release2"] = {350,1e9,Vector(-183,0,-70),0.4}

    self.SoundNames["parking_brake"] = {loop=true,"subway_trains/common/pneumatic/parking_brake.wav"}
    self.SoundNames["parking_brake_en"] = "subway_trains/common/pneumatic/parking_brake_stop.mp3"
    self.SoundNames["parking_brake_rel"] = "subway_trains/common/pneumatic/parking_brake_stop2.mp3"
    self.SoundPositions["parking_brake"] = {80,1e9,Vector(-454, -55,-63),0.6}
    self.SoundPositions["parking_brake_en"] = self.SoundPositions["parking_brake"]
    self.SoundPositions["parking_brake_rel"] = self.SoundPositions["parking_brake"]
    self.SoundNames["front_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["front_isolation"] = {300,1e9,Vector(443, 0,-63),1}
    self.SoundNames["rear_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["rear_isolation"] = {300,1e9,Vector(-456, 0,-63),1}

    self.SoundNames["crane013_brake"] = {loop=true,"subway_trains/common/pneumatic/release_2.wav"}
    self.SoundPositions["crane013_brake"] = {80,1e9,Vector(-466,51,-12),0.86}
    self.SoundNames["crane013_brake2"] = {loop=true,"subway_trains/common/pneumatic/013_brake2.wav"}
    self.SoundPositions["crane013_brake2"] = {80,1e9,Vector(-466,51,-12),0.86}
    self.SoundNames["crane013_brake_l"] = {loop=true,"subway_trains/common/pneumatic/013_brake_loud2.wav"}
    self.SoundPositions["crane013_brake_l"] = {80,1e9,Vector(-466,51,-12),0.7}
    self.SoundNames["crane013_release"] = {loop=true,"subway_trains/common/pneumatic/013_release.wav"}
    self.SoundPositions["crane013_release"] = {80,1e9,Vector(-466,51,-12),0.4}
    self.SoundNames["crane334_brake_high"] = {loop=true,"subway_trains/common/pneumatic/334_brake.wav"}
    self.SoundPositions["crane334_brake_high"] = {80,1e9,Vector(-466,51,-12),0.85}
    self.SoundNames["crane334_brake_low"] = {loop=true,"subway_trains/common/pneumatic/334_brake_slow.wav"}
    self.SoundPositions["crane334_brake_low"] = {80,1e9,Vector(-466,51,-12),0.75}
    self.SoundNames["crane334_brake_2"] = {loop=true,"subway_trains/common/pneumatic/334_brake_slow.wav"}
    self.SoundPositions["crane334_brake_2"] = {80,1e9,Vector(-466,51,-12),0.85}
    self.SoundNames["crane334_brake_eq_high"] = {loop=true,"subway_trains/common/pneumatic/334_release_reservuar.wav"}
    self.SoundPositions["crane334_brake_eq_high"] = {80,1e9,Vector(-466,51,-70),0.2}
    self.SoundNames["crane334_brake_eq_low"] = {loop=true,"subway_trains/common/pneumatic/334_brake_slow2.wav"}
    self.SoundPositions["crane334_brake_eq_low"] = {80,1e9,Vector(-466,51,-70),0.2}
    self.SoundNames["crane334_release"] = {loop=true,"subway_trains/common/pneumatic/334_release3.wav"}
    self.SoundPositions["crane334_release"] = {80,1e9,Vector(-466,51,-12),0.2}
    self.SoundNames["crane334_release_2"] = {loop=true,"subway_trains/common/pneumatic/334_release2.wav"}
    self.SoundPositions["crane334_release_2"] = {80,1e9,Vector(-466,51,-12),0.2}

    self.SoundNames["valve_brake"] = {loop=true,"subway_trains/common/pneumatic/epv_loop.wav"}
    self.SoundPositions["valve_brake"] = {80,1e9,Vector(-430,-662,-22),1}

    self.SoundNames["pak_on"] = "subway_trains/717/switches/rc_on.mp3"
    self.SoundNames["pak_off"] = "subway_trains/717/switches/rc_off.mp3"

    self.SoundNames["cab_door_open"] = "subway_trains/common/door/cab/door_open.mp3"
    self.SoundNames["cab_door_close"] = "subway_trains/common/door/cab/door_close.mp3"

    self.SoundNames["horn"] = {loop=0.6,"subway_trains/common/pneumatic/horn/horn3_start.wav","subway_trains/common/pneumatic/horn/horn3_loop.wav", "subway_trains/common/pneumatic/horn/horn3_end.wav"}
    self.SoundPositions["horn"] = {1100,1e9,Vector(-470,0,-55),1}

    --DOORS
    self.SoundNames["vdol_on"] = {
        "subway_trains/common/pneumatic/door_valve/VDO_on.mp3",
        "subway_trains/common/pneumatic/door_valve/VDO2_on.mp3",
    }
    self.SoundNames["vdol_off"] = {
        "subway_trains/common/pneumatic/door_valve/VDO_off.mp3",
        "subway_trains/common/pneumatic/door_valve/VDO2_off.mp3",
    }
    self.SoundPositions["vdol_on"] = {300,1e9,Vector(-420,45,-30),1}
    self.SoundPositions["vdol_off"] = {300,1e9,Vector(-420,45,-30),0.4}
    self.SoundNames["vdor_on"] = self.SoundNames["vdol_on"]
    self.SoundNames["vdor_off"] = self.SoundNames["vdol_off"]
    self.SoundPositions["vdor_on"] = self.SoundPositions["vdol_on"]
    self.SoundPositions["vdor_off"] = self.SoundPositions["vdol_off"]
    self.SoundNames["vdz_on"] = {
        "subway_trains/common/pneumatic/door_valve/VDZ_on.mp3",
        "subway_trains/common/pneumatic/door_valve/VDZ2_on.mp3",
        "subway_trains/common/pneumatic/door_valve/VDZ3_on.mp3",
    }
    self.SoundNames["vdz_off"] = {
        "subway_trains/common/pneumatic/door_valve/VDZ_off.mp3",
        "subway_trains/common/pneumatic/door_valve/VDZ2_off.mp3",
        "subway_trains/common/pneumatic/door_valve/VDZ3_off.mp3",
    }
    self.SoundPositions["vdz_on"] = {60,1e9,Vector(-420,45,-30),1}
    self.SoundPositions["vdz_off"] = {60,1e9,Vector(-420,45,-30),0.4}

    self.SoundNames["RKR"] = "subway_trains/common/pneumatic/RKR2.mp3"
    self.SoundPositions["RKR"] = {330,1e9,Vector(-27,-40,-66),0.22}

    self.SoundNames["PN2end"] = {"subway_trains/common/pneumatic/vz2_end.mp3","subway_trains/common/pneumatic/vz2_end_2.mp3","subway_trains/common/pneumatic/vz2_end_3.mp3","subway_trains/common/pneumatic/vz2_end_4.mp3"}
    self.SoundPositions["PN2end"] = {350,1e9,Vector(-183,0,-70),0.3}
    for i=0,3 do
        for k=0,1 do
            self.SoundNames["door"..i.."x"..k.."r"] = {"subway_trains/common/door/door_roll.wav",loop=true}
            self.SoundPositions["door"..i.."x"..k.."r"] = {150,1e9,GetDoorPosition(i,k),0.11}
            self.SoundNames["door"..i.."x"..k.."o"] = {"subway_trains/common/door/door_open_end5.mp3","subway_trains/common/door/door_open_end6.mp3","subway_trains/common/door/door_open_end7.mp3"}
            self.SoundPositions["door"..i.."x"..k.."o"] = {350,1e9,GetDoorPosition(i,k),2}
            self.SoundNames["door"..i.."x"..k.."c"] = {"subway_trains/common/door/door_close_end.mp3","subway_trains/common/door/door_close_end2.mp3","subway_trains/common/door/door_close_end3.mp3","subway_trains/common/door/door_close_end4.mp3","subway_trains/common/door/door_close_end5.mp3"}
            self.SoundPositions["door"..i.."x"..k.."c"] = {400,1e9,GetDoorPosition(i,k),2}
        end
    end

    for k,v in ipairs(self.AnnouncerPositions) do
        self.SoundNames["announcer_buzz1_"..k] = {loop=true,"subway_announcers/upo/noiseT.wav"}
        self.SoundPositions["announcer_buzz1_"..k] = {v[2] or 300,1e9,v[1],v[3]*0.6}
        self.SoundNames["announcer_buzz2_"..k] = {loop=true,"subway_announcers/upo/noiseT2.wav"}
        self.SoundPositions["announcer_buzz2_"..k] = {v[2] or 300,1e9,v[1],v[3]*0.4 }
        self.SoundNames["announcer_noise1_"..k] = {loop=true,"subway_announcers/upo/noiseS1.wav"}
        self.SoundPositions["announcer_noise1_"..k] = {v[2] or 300,1e9,v[1],v[3]*0.2}
        self.SoundNames["announcer_noise2_"..k] = {loop=true,"subway_announcers/upo/noiseS2.wav"}
        self.SoundPositions["announcer_noise2_"..k] = {v[2] or 300,1e9,v[1],v[3]*0.2}
        self.SoundNames["announcer_noise3_"..k] = {loop=true,"subway_announcers/upo/noiseS3.wav"}
        self.SoundPositions["announcer_noise3_"..k] = {v[2] or 300,1e9,v[1],v[3]*0.2}
        self.SoundNames["announcer_noiseW"..k] = {loop=true,"subway_announcers/upo/noiseW.wav"}
        self.SoundPositions["announcer_noiseW"..k] = {v[2] or 300,1e9,v[1],v[3]*0.2}
    end
end
function ENT:PostInitializeSystems()
    self.Electric:TriggerInput("NoRT2",1)
    self.Electric:TriggerInput("HaveRO",1)
    self.Electric:TriggerInput("GreenRPRKR",0)
    self.Electric:TriggerInput("Type",self.Electric.LVZ_2)
    self.Electric:TriggerInput("X2PS",1)
end
function ENT:InitializeSystems()
    -- Электросистема 81-710
    self:LoadSystem("Electric","81_714_Electric")

    -- Токоприёмник
    self:LoadSystem("TR","TR_3B")
    -- Электротяговые двигатели
    self:LoadSystem("Engines","DK_117DM")

    -- Резисторы для реостата/пусковых сопротивлений
    self:LoadSystem("KF_47A","KF_47A1")
    -- Резисторы для ослабления возбуждения
    self:LoadSystem("KF_50A")
    -- Ящик с предохранителями
    self:LoadSystem("YAP_57")

    -- Реостатный контроллер для управления пусковыми сопротивления
    self:LoadSystem("RheostatController","EKG_17B")
    -- Групповой переключатель положений
    self:LoadSystem("PositionSwitch","PKG_761")
    self:LoadSystem("Reverser","PR_722D")

    -- Ящики с реле и контакторами
    self:LoadSystem("BV","BV_630")
    self:LoadSystem("LK_755A")
    self:LoadSystem("YAR_13B","YAR_13B_SPB")
    self:LoadSystem("YAR_27")
    self:LoadSystem("YAK_36")
    self:LoadSystem("YAK_37E")
    self:LoadSystem("YAS_44V")
    self:LoadSystem("YARD_2")

    -- Панель управления 81-710
    self:LoadSystem("Panel","81_714_Panel")
    -- Пневмосистема 81-710
    self:LoadSystem("Pneumatic","81_717_Pneumatic",{br013_1 = true})
    -- Everything else
    self:LoadSystem("Battery")
    self:LoadSystem("PowerSupply","BPSN")
    self:LoadSystem("Announcer","81_71_Announcer")

    self:LoadSystem("Horn")

    self:LoadSystem("IGLA_PCBK")
end

ENT.SubwayTrain = {
    Type = "81",
    Name = "81-714.5m",
    Manufacturer = "LVZ",
    WagType = 2,
    EKKType = 717,
}

ENT.NumberRanges = {
    {
        true,
        {
            --717
            7375,7376,7377,7378,7379,7380,7381,7382,7383,7384,7385,7386,7387,7388,7389,7399,7400,7401,7402,7403,7404,7405,7406,7407,7408,7409,7410,7411,7412,7413,7427,7428,7429,7431,7432,7433,7434,7435,7436,7437,7438,7439,7440,7441,7442,7443,7444,7445,7446,7447,7448,7449,7450,7451,7452,7453,7454,7455,7456,7457,7458,7459,7460,7461,7462,7463,7464,7465,7466,7467,7468,7469,7470,7471,7472,7473,7474,7475,7476,7477,7478,7479,7480,7481,7482,7483,7484,7485,7597,7598,7599,7600,7601,7602,7603,7604,7605,7606,7607,7608,7609,7610,7611,7612,7613,7614,7615,7616,7617,7618,7619,7676,7677,7678,7679,7680,7681,7682,7683,7684,7685,7686,7687,7691,7692,7699,7700,7701,7707,7708,7709,7710,7711,7712,7713,7720,7722,7723,7731,7733,7765,7773,7774,7775,7776,7777,7778,7780,7781,7782,7785,7794,7797,7803,7804,7805,7808,7809,7810,7813,7814,7815,7816,7849,7850,7851,7852,7853,7854,7855,7856,7857,7858,7859,7860,7861,7862,7863,7864,7865,7866,7867,7868,7869,7870,7871,7872,7873,7874,7875,7938,7943,7944,7945,7946,7947,7948,7949,8011,8013,8014,8015,8016,8022,8028,8030,8033,8034,8035,8037,8041,8057,8058,8059,8060,8061,8066,8067,8068,8069,8070,8077,8082,8085,8147,8150,8151,8152,8154,8178,8179,8180,8181,
            -- голубой с белым пластик и квр сидухи
            9350,9352,9353,9354,9355,
            --717.5
            8194,8195,8196,8197,11056,11057,11058,11059,11100,11101,11102,11103,11108,11297,11298,11300,11301,

        },
    },
    {
        true,
        {
            --714 - ПУАВ
            7392,7393,7396,7398,8143,8144,8145,8146,8161,8162,8170,8171,8172,8173,8182,8183,8184,8186,8187,8188,8189,
            --714.5 - ПУАВ
            8190,8191,8192,8193,8198,8199,8200,8201,8202,8308,8310,8311,8313,8314,8315,8316,8317,8318,8319,8320,8321,8330,8331,8332,8333,8334,8336,8337,8338,8339,8340,8341,8342,8389,8390,8391,8392,8393,8394,8395,8396,8397,8398,8399,11000,11001,11002,11003,11004,11005,11006,11007,11008,11009,11010,11011,11012,11013,11014,11055,11064,11065,11066,11067,11068,11080,11081,11082,11083,11085,11086,11087,11088,11104,11105,11106,11107,11167,11168,11173,11174,11181,11182,11187,11189,11190,11191,11192,11196,11249,11306,
        }
    },
    {
        true,
        {
            --714
            7392,7398,8174,8175,8176,8177,
            --714.5
            11060,11061,11062,11063,11073,11074,11077,11078,11084,11109,11188,11209,11210,11215,11220,11246,11247,11258,11259,11260,11261,11262,11263,11271,11273,11284,11285,11292,11293,11294,11296,11322,11323,11377,11378,
        }
    },
}

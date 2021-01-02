ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "Metrostroi (trains)"
ENT.SkinsType = "81-717_mvm"
ENT.Model = "models/metrostroi_train/81-717/81-717_mvm_int.mdl"

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
    {Vector(-3,-60, 62),300,0.3},
    {Vector(-3,60 ,62),300,0.3},
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
    self.SoundNames["bpsn1"] = {"subway_trains/717/bpsn/bpsn_ohigh.wav", loop=true}
    self.SoundNames["bpsn2"] = {"subway_trains/717/bpsn/old.wav", loop=true}
    self.SoundNames["bpsn3"] = {"subway_trains/717/bpsn/bpsn_olow.wav", loop=true}
    self.SoundNames["bpsn4"] = {"subway_trains/717/bpsn/bpsn_spb.wav", loop=true}
    self.SoundNames["bpsn5"] = {"subway_trains/717/bpsn/bpsn_tkl.wav", loop=true}
    self.SoundNames["bpsn6"] = {"subway_trains/717/bpsn/bpsn_nnov.wav", loop=true}
    self.SoundNames["bpsn7"] = {"subway_trains/717/bpsn/bpsn_kiyv.wav", loop=true}
    self.SoundNames["bpsn8"] = {"subway_trains/717/bpsn/bpsn_old.wav", loop=true}
    self.SoundNames["bpsn9"] = {"subway_trains/717/bpsn/bpsn_1.wav", loop=true}
    self.SoundNames["bpsn10"] = {"subway_trains/717/bpsn/bpsn_2.wav", loop=true}
    self.SoundNames["bpsn11"] = {"subway_trains/717/bpsn/bpsn_piter.wav", loop=true}
    self.SoundNames["bpsn12"] = {"subway_trains/717/bpsn/bpsn1.wav", loop=true}
    self.SoundPositions["bpsn1"] = {500,1e9,Vector(0,45,-448),0.02}
    self.SoundPositions["bpsn2"] = {500,1e9,Vector(0,45,-448),0.03}
    self.SoundPositions["bpsn3"] = {500,1e9,Vector(0,45,-448),0.02}
    self.SoundPositions["bpsn4"] = {500,1e9,Vector(0,45,-448),0.025}
    self.SoundPositions["bpsn5"] = {500,1e9,Vector(0,45,-448),0.08}
    self.SoundPositions["bpsn6"] = {500,1e9,Vector(0,45,-448),0.03}
    self.SoundPositions["bpsn7"] = {500,1e9,Vector(0,45,-448),0.02}
    self.SoundPositions["bpsn8"] = {500,1e9,Vector(0,45,-448),0.03}
    self.SoundPositions["bpsn9"] = {500,1e9,Vector(0,45,-448),0.02}
    self.SoundPositions["bpsn10"] = {500,1e9,Vector(0,45,-448),0.02}
    self.SoundPositions["bpsn11"] = {500,1e9,Vector(0,45,-448),0.04}
    self.SoundPositions["bpsn12"] = {500,1e9,Vector(0,45,-448),0.04}

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
    self.SoundPositions["vent1"] = {160,1e9,Vector(225,  -50, -37.5),0.23}
    self.SoundPositions["vent2"] = {160,1e9,Vector(-5,    50, -37.5),0.23}
    self.SoundPositions["vent3"] = {160,1e9,Vector(-230, -50, -37.5),0.23}
    self.SoundPositions["vent8"] = {120,1e9,Vector(416,   50, -37.5),0.23}
    self.SoundPositions["vent4"] = {160,1e9,Vector(225,   50, -37.5),0.23}
    self.SoundPositions["vent5"] = {160,1e9,Vector(-5,   -50, -37.5),0.23}
    self.SoundPositions["vent6"] = {160,1e9,Vector(-230,  50, -37.5),0.23}
    self.SoundPositions["vent7"] = {120,1e9,Vector(-432, -50, -37.5),0.23}

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
    self.SoundNames["vdol_loud"] = "subway_trains/common/pneumatic/door_valve/vdo3_on.mp3"
    self.SoundNames["vdop_loud"] = self.SoundNames["vdol_loud"]
    self.SoundPositions["vdol_loud"] = {100,1e9,Vector(-420,45,-30),1}
    self.SoundPositions["vdop_loud"] = self.SoundPositions["vdol_loud"]
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
        self.SoundNames["announcer_buzz"..k] = {loop=true,"subway_announcers/asnp/bpsn_ann.wav"}
        self.SoundPositions["announcer_buzz"..k] = {v[2] or 600,1e9,v[1],v[3]/4}
    end
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
    self:LoadSystem("Reverser","PR_722D")
    self:LoadSystem("RheostatController","EKG_17B")
    -- Групповой переключатель положений
    self:LoadSystem("PositionSwitch","PKG_761")

    -- Ящики с реле и контакторами
    self:LoadSystem("BV","BV_630")
    self:LoadSystem("LK_755A")
    self:LoadSystem("YAR_13B")
    self:LoadSystem("YAR_27")
    self:LoadSystem("YAK_36")
    self:LoadSystem("YAK_37E")
    self:LoadSystem("YAS_44V")
    self:LoadSystem("YARD_2")

    self:LoadSystem("Horn")

    self:LoadSystem("IGLA_PCBK")
    -- Панель управления 81-710
    self:LoadSystem("Panel","81_714_Panel")
    -- Пневмосистема 81-710
    self:LoadSystem("Pneumatic","81_717_Pneumatic",{br013_1 = true})
    -- Everything else
    self:LoadSystem("Battery")
    self:LoadSystem("PowerSupply","BPSN")
    self:LoadSystem("Announcer","81_71_Announcer")
end
-- LVZ,Dot5,NewSeats,NewBL,PassTexture,MVM
ENT.NumberRanges = {

    --714 МВМ
    {
        true,
        {0413,0414,0415,0416,0417,0418,0419,0420,0430,0431,0432,0433,0434,0435,0436,0437,0438,0439,0440,0441,0442,0443,0444,0445,0446,0447,0448,0449,0450,0451,0452,0453,0455,0456,0457,0458,0460,0461,0462,0464,0465,0466,0467,0468,0469,0470,0471,0472,0473,0474,0475,0476,0477,0478,0479,0480,0481,0482,0483,0484,0485,0486,0487,0488,0489,0490,0491,0492,0493,0494,0495,0496},
        {false,false,true ,true,{"Def_717MSKWhite","Def_717MSKWood4"}}
    },
    {
        true,
        {9495,9505,9526,9533,9539,9543,9545,9548,9549,9552,9569,9577,9579,9589,9591,9593,9597,9603,9605,9613,9614,9615,9619,9621,9631,9654,9656,9657,9660,9661,9662,9664,9665,9667,9668,9673,9676,9677,9678,9682,9683,9684,9686,9687,9689,9690,9691,9692,9693,9694,9695,9698,9699,9700,9701,9702,9703,9704,9705,9706,9707,9708,9710,9711,9712,9714,9716,9717,9718,9731,9732,9734,9735,9736,9744,9748,9749,9751,9752,9753,9755,9765,9766,9775,9778,9782,9783,9788,9789,9790,9791,9792,9793,9794,9796,9799,9800,9801,9802,9805,9806,9807,9808,9809,9810,9811,9812,9813,9814,9815,9816,9817,9818,9819,9821,9822,9823,9824,9825,9826,9827,9828,9832,9833,9834,9835,9837,9838,9839,9840,9841,9843,9844,9845,9846,9847,9848,9849,9850,9851,9852,9853,9854,9855,9856,9857,9858,9859,9884,9885,9886,9887,9888,9889,9890,9891,9892,9893,9894,9895,9896,9897,9898,9899,9900,9901,9902,9903,9904,9905,9906,9907,9908,9909,9910,9911,9912,9913,9914,9915,9916,9917,9918,9919,9920,9921,9922,9926,9927,9928,9929,9930,9931,9932,9933,9934,9935,9936,9937,9938,9939,9940,9941,9942,9943,9944,9945,9946,9947,9948,9953,9954,9955,9956,9957,9958,9965,9966,9967,9968,9969,9970,9971,9972,9973,9977,9978,9979,9981,9982,9983,9984,9985,9986,9987,9988,9989,9990,9991,9992,9993},
        {false,false,false,true,{"Def_717MSKBlue","Def_717MSKWhite",--[[ "Def_717MSKWood",--]] "Def_717MSKWood2"}}
    },
    --714 ЛВЗ
    {
        true,
        {7237,7317,7327,7334,7336,7339,7340,7343,7345,7346,7347,7356,7366,7420,7423,7424,7426,7491,7492,7493,7494,7495,7496,7497,7498,7499,7500,7501,7502,7503,7505,7506,7507,7508,7509,7510,7511,7512,7514,7517,7519,7520,7521,7522,7523,7524,7525,7528,7529,7530,7531,7532,7534,7535,7536,7537,7538,7539,7540,7541,7542,7543,7544,7545,7547,7549,7550,7551,7552,7553,7554,7555,7559,7561,7563,7564,7565,7566,7567,7568,7569,7570,7572,7573,7574,7575,7576,7578,7579,7580,7581,7582,7583,7585,7587,7589,7590,7591,7592,7593,7594,7595,7596,7620,7621,7622,7623,7624,7625,7627,7628,7629,7630,7631,7633,7634,7637,7639,7640,7641,7642,7643,7644,7646,7647,7648,7650,7651,7693,7695,7696,7697,7698,7703,7704,7705,7706,7732,7734,7738,7739,7740,7741,7742,7743,7744,7745,7746,7747,7748,7749,7750,7751,7752,7753,7754,7755,7756,7757,7758,7759,7760,7761,7762,7763,7764,7766,7767,7768,7769,7770,7771,7772,7876,7878,7879,7880,7882,7883,7887,7890,7891,7892,7893,7894,7895,7896,7897,7898,7899,7900,7901,7902,7903,7904,7905,7906,7907,7908,7909,7910,7911,7912,7913,7914,7915,7916,7917,7918,7920,7921,7922,7923,7924,7925,7926,7927,7928,7929,7930,7931,7933,7935,7937,7950,7951,7952,7953,7954,7955,7956,7957,7958,7959,7960,7961,7968,7969,7970,7971,7972,7973,7979,7981,7982,7983,7984,7985,7986,7987,7988,7989,7990,7991,7992,7994,7995,7996,7997,8012,8018,8020,8021,8023,8024,8025,8026,8036,8043,8044,8045,8046,8053,8062,8063,8064,8065,8071,8072,8073,8074,8075,8076,8078,8079,8080,8081,8083,8084,8086,8087,8088,8089,8093,8094,8095,8096,8097,8098,8099,8100,8101,8102,8103,8104,8105,8106,8107,8110,8111,8113,8114,8115,8116,8117,8135,8136,8137,8138,8139,8140,8141,8142,},
        --{true,false,false,false,{"Def_717MSKWhite","Def_717MSKWood4"},true}
        {true,false,false ,true,{"Def_717MSKWhite","Def_717MSKWood4"}}
    },
    --717.5 МВМ
    {
        true,
        {0497,0498,0499,0500,0501,0502,0503,0504,0505,0506,0507,0508,0509,0510,0511,0512,0513,0514,0515,0516,0517,0518,0519,0520,0521,0522,0523,0524,0525,0526,0527,0528,0529,0530,0531,0532,0533,0534,0535,0536,0536,0538,0539,0540,0541,0542,0543,0544,0545,0546,0547,0548,0549,0550,0551,0552,0553,0554},
        --{false, true,false,true,{"Def_717MSKWhite","Def_717MSKWood4"},true,true}
        {false, false,false,true,{"Def_717MSKWhite","Def_717MSKWood4"}}
    },
    {
        true,
        {0623,0624,0625,0626,0627,0628,0629,0630,0631,0632,0633,0634,0635,0636,0637,0638,0639,0640,0641,0642,0643,0644,0645,0646,0647,0648,0649,0650,0651,0652,0653,0654,0655,0656,0657,0658,0662,0663,0664,0665,0666,0667,0668,0669,0670,0671,0672,0673,0674,0682,0684,0685,0686,0687,0688,0689,0690,0691,0692,0693,0694,0695,0696,0697,0698,0699,0703,0704,0705,0712,0713,074,0715,0722,0723,0724,0725,0726,0727,0728,0729,0730,0731,0732,0733,0734,0735,0736,0737,0738,0739,0752,0753,0754,0755,0756,0757,0758,0759,0760,0761,0762,0763,0764,0765,0766,0767,0768,0769,0770,0771,0781,0782,0783,0786,0787,0788,0795,0796,0797,0798,0802,0803,0804,0805,0806,0807,0808,0809,0810,0811,0812,0813,0814,0818,0819,0820,0821,0822,0823,0824,0825,0826,0827,0828,0829,0830,0831,0833,0834,0835,0836,0837,0838,0839,0840,0841,0842,0843,0844,0845,0846,0847,0848,0849,0855,0856,0857,0858,0859,0860,0861,0862,0863,0864,0867,0872,0874,0875,0876,0877,0880,0881,0882,0883,0884,0885,0886,0887,0890,0891,0892,0893,0894,0895,0896,0897,0902,0903,0904,0905,0906,0907,0908,0909,0916,0917,0918},
        {false, true,true ,true,{"Def_717MSKWhite","Def_717MSKWood4"}}
    },
    --717.5 ЛВЗ
    {
        true,
        {8204,8205,8207,8208,8209,8210,8211,8212,8213,8214,8216,8217,8218,8219,8220,8221,8222,8223,8224,8225,8226,8227,8228,8229,8230,8231,8232,8233,8234,8235,8236,8237,8238,8239,8270,8271,8272,8273,8274,8275,8276,8278,8279,8280,8281,8282,8283,8284,828,8286,8287,8288,8289,8290,8291,8292,8293,8294,8295,8296,8297,8298,8299,8300,8301,8302,8303,8304,8305,8306,8307,8309,8312,8343,8360,8361,8362,8363,8364,8365,8366,8367,8368,8368,8370,8377,8378,8379,8380,8381,8382,8383,8384,8385,8386,8387,8388},
        {true , true,false,true,{"Def_717MSKWhite","Def_717MSKWood4"}}
    },
    {
        true,
        {11021,11022,11023,11024,11025,11026,11029,11030,11031,11032,11033,11034,11035,11036,11037,11038,11039,11040,11075,11076,11079,11089,11092,11093,11094,11095,11096,11097,11098,11099,1117,11119,11120,11121,11122,11123,1112411125,11126,11127,11128,11129,11130,11131,11132,11133,11139,11140,11142,11143,11144,11145,11146,11147,11148,11149,11150,11151,11152,11153,11154,11155,11158,11159,11160,11161,11162,11163,11164,11165,11166,11169,11170,11171,11172,11175,11176,11177,11178,11179,11180,11183,11184,11185,11186,11193,11194,11195,11197,11198,11199,11200,11201,11202,11203,11204,11205,11206,11207,11208,11212,11213,11214,11216,11217,11218,11219,11221,11222,11223,11224,11226,11227,11228,11229,11230,11231,11232,11233,11234,11235,11236,11237,11238,11239,11240,11248,11250,11251,11252,11253,11256,11257,11264,11265,11266,11267,11268,11269,11270,11272,11274,11275,11276,11277,11278,11279,11280,11281,11282,11283,11286,11287,11288,11289,11290,11291,11295,11299,11307,11308,11309,11310,11311,11312,11313,11314,11315,11317,11318,11319,11320,11321,11324,11325,11326,11327,11328,11329,11330,11331,11332,11333,11334,11358,11359,11361,11363,11365,11366,11376},
        {true , true,true ,true,{"Def_717MSKWhite","Def_717MSKWood4"}}
    },
}

function ENT:PostInitializeSystems()
    self.Electric:TriggerInput("NoRT2",0)
    self.Electric:TriggerInput("GreenRPRKR",0)
    self.Electric:TriggerInput("Type",self.Electric.MVM)
    self.Electric:TriggerInput("X2PS",0)
    self.Electric:TriggerInput("HaveVentilation",1)
end
---------------------------------------------------
-- Defined train information
-- Types of wagon(for wagon limit system):
-- 0 = Head or intherim
-- 1 = Only head
-- 2 = Only intherim
---------------------------------------------------
ENT.SubwayTrain = {
    Type = "81",
    Name = "81-714.5m",
    WagType = 2,
    Manufacturer = "MVM",
    EKKType = 717,
}

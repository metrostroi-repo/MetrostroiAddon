ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "Metrostroi (trains)"
ENT.SkinsType = "81-718"
ENT.Model = "models/metrostroi_train/81-718/81-718.mdl"

ENT.Spawnable       = true
ENT.AdminSpawnable  = false
ENT.DontAccelerateSimulation = false
function ENT:PassengerCapacity()
    return 300
end

function ENT:GetStandingArea()
    return Vector(-450,-30,-48),Vector(378,30,-48)
end

local function GetDoorPosition(i,k)
    return Vector(359.0 - 35/2 - 229.5*i,-65*(1-2*k),7.5)
end
ENT.AnnouncerPositions = {
    {Vector(420,-49 ,61),120,0.4},
    {Vector(-3,-60, 62),300,0.3},
    {Vector(-3,60 ,62),300,0.3},
}
ENT.Cameras = {
    {Vector(407.5+46,-31,-3),Angle(80,0,0),"Train.718.BUP"},
    {Vector(407.5+20,-40,40),Angle(0,180,0),"Train.718.PPZ"},
    {Vector(407.5+20,-40,24),Angle(0,180,0),"Train.718.VPU"},
    {Vector(407.5+10,-41,18),Angle(45,180,0),"Train.717.VB"},
    {Vector(407.5+30,-60,-0),Angle(40,0,0),"Train.Common.UAVA"},
    {Vector(407.5+30,-35,-0),Angle(45,0,0),"Train.Common.PneumoPanels"},
    {Vector(407.5+42,40,10),Angle(0,90,0),"Train.Common.HelpersPanel"},
    {Vector(407.5+20,-45,-7),Angle(0,-90,0),"Train.Common.Voltmeters"},
    {Vector(407.5-29,-30,-30),Angle(10,0,0),"Train.Common.RRI"},
    {Vector(407.5+40,33.5,40)  ,Angle(0,16,0),"Train.Common.RouteNumber"},
    {Vector(407.5+75,0.3,1)   ,Angle(20,180,0),"Train.Common.LastStation"},
    {Vector(450+7,0,35),Angle(60,0,0),"Train.Common.CouplerCamera"},
}
local yventpos = {
    -414.5+0*117,
    -414.5+1*117+6.2,
    -414.5+2*117+5,
    -414.5+3*117+2,
    -414.5+4*117+0.5,
    -414.5+5*117-2.3,
    -414.5+6*117-2.3,
}
function ENT:InitializeSounds()
    self.BaseClass.InitializeSounds(self)
    self.SoundNames["tisu"]   = {"subway_trains/718/tisu.wav",loop = true}
    self.SoundPositions["tisu"] = {400,1e9,Vector(0,0,-448),0.7} --FIXME: Pos

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

    self.SoundNames["bpsn"] = {"subway_trains/717/bpsn/bpsn_2.wav", loop=true}
    self.SoundPositions["bpsn"] = {400,1e9,Vector(0,45,-448),0.02}
    self.SoundNames["compressor"] = {loop=2.0,"subway_trains/d/pneumatic/compressor/compessor_d_start.wav","subway_trains/d/pneumatic/compressor/compessor_d_loop.wav", "subway_trains/d/pneumatic/compressor/compessor_d_end.wav"}
    self.SoundNames["compressor2"] = {loop=1.79,"subway_trains/717/compressor/compressor_717_start2.wav","subway_trains/717/compressor/compressor_717_loop2.wav", "subway_trains/717/compressor/compressor_717_stop2.wav"}
    self.SoundPositions["compressor"] = {600,1e9,Vector(-118,-40,-66),0.15}
    self.SoundPositions["compressor2"] = {480,1e9,Vector(-118,-40,-66),0.55}

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
    self.SoundPositions["parking_brake"] = {80,1e9,Vector(449,-34,-40),0.6}
    self.SoundPositions["parking_brake_en"] = self.SoundPositions["parking_brake"]
    self.SoundPositions["parking_brake_rel"] = self.SoundPositions["parking_brake"]
    self.SoundNames["front_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["front_isolation"] = {300,1e9,Vector(443, 0,-63),1}
    self.SoundNames["rear_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["rear_isolation"] = {300,1e9,Vector(-456, 0,-63),1}

    self.SoundNames["crane013_brake"] = {loop=true,"subway_trains/common/pneumatic/release_2.wav"}
    self.SoundPositions["crane013_brake"] = {80,1e9,Vector(431.5,-20.3,-12),0.86}
    self.SoundNames["crane013_brake2"] = {loop=true,"subway_trains/common/pneumatic/013_brake2.wav"}
    self.SoundPositions["crane013_brake2"] = {80,1e9,Vector(431.5,-20.3,-12),0.86}
    self.SoundNames["crane013_release"] = {loop=true,"subway_trains/common/pneumatic/013_release.wav"}
    self.SoundPositions["crane013_release"] = {80,1e9,Vector(431.5,-20.3,-12),0.4}

    self.SoundNames["epk_brake"] = {loop=true,"subway_trains/common/pneumatic/epv_loop.wav"}
    self.SoundPositions["epk_brake"] = {80,1e9,Vector(437.2,-53.1,-32.0),0.65}

    self.SoundNames["valve_brake"] = {loop=true,"subway_trains/common/pneumatic/epv_loop.wav"}
    self.SoundPositions["valve_brake"] = {80,1e9,Vector(408.45,62.15,11.5),1}

    self.SoundNames["emer_brake"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop.wav"}
    self.SoundNames["emer_brake2"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop_2.wav"}
    self.SoundPositions["emer_brake"] = {600,1e9,Vector(345,-55,-84),0.95}
    self.SoundPositions["emer_brake2"] = {600,1e9,Vector(345,-55,-84),1}

    self.SoundNames["kr_left"] = "subway_trains/ezh3/controller/krishechka_left.mp3"
    self.SoundNames["kr_right"] = "subway_trains/ezh3/controller/krishechka_right.mp3"

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

    self.SoundNames["switchbl_off"] = {
        "subway_trains/717/switches/tumbler_fatb_off1.mp3",
        "subway_trains/717/switches/tumbler_fatb_off2.mp3",
        "subway_trains/717/switches/tumbler_fatb_off3.mp3",
    }
    self.SoundNames["switchbl_on"] = {
        "subway_trains/717/switches/tumbler_fatb_on1.mp3",
        "subway_trains/717/switches/tumbler_fatb_on2.mp3",
        "subway_trains/717/switches/tumbler_fatb_on3.mp3",
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
    self.SoundNames["button4_off"] = {
        "subway_trains/717/switches/button4_off1.mp3",
        "subway_trains/717/switches/button4_off2.mp3",
    }
    self.SoundNames["button4_on"] = {
        "subway_trains/717/switches/button4_on1.mp3",
        "subway_trains/717/switches/button4_on2.mp3",
    }
    self.SoundNames["uava_reset"] = {
        "subway_trains/common/uava/uava_reset1.mp3",
        "subway_trains/common/uava/uava_reset2.mp3",
        "subway_trains/common/uava/uava_reset4.mp3",
    }
    self.SoundPositions["uava_reset"] = {120,1e9,Vector(429.6,-60.8,-15.9),0.95}
    self.SoundNames["gv_f"] = {"subway_trains/717/kv70/reverser_0-b_1.mp3","subway_trains/717/kv70/reverser_0-b_2.mp3"}
    self.SoundNames["gv_b"] = {"subway_trains/717/kv70/reverser_b-0_1.mp3","subway_trains/717/kv70/reverser_b-0_2.mp3"}
    self.SoundNames["pak_on"] = "subway_trains/717/switches/rc_on.mp3"
    self.SoundNames["pak_off"] = "subway_trains/717/switches/rc_off.mp3"

    self.SoundNames["pneumo_disconnect2"] = "subway_trains/common/pneumatic/pneumo_close.mp3"
    self.SoundNames["pneumo_disconnect1"] = {
        "subway_trains/common/pneumatic/pneumo_open.mp3",
        "subway_trains/common/pneumatic/pneumo_open2.mp3",
    }
    self.SoundPositions["pneumo_disconnect2"] = {60,1e9,Vector(431.8,-24.1+1.5,-33.7),1}
    self.SoundPositions["pneumo_disconnect1"] = {60,1e9,Vector(431.8,-24.1+1.5,-33.7),1}

    self.SoundNames["disconnect_valve"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"

    self.SoundNames["KV_-3_-2"] = "subway_trains/720/controller/t3_t2.mp3"
    self.SoundNames["KV_-2_-1"] = "subway_trains/720/controller/t2_t1.mp3"
    self.SoundNames["KV_-1_0"] = "subway_trains/720/controller/t1_0.mp3"
    self.SoundNames["KV_0_1"] = "subway_trains/720/controller/0_x1.mp3"
    self.SoundNames["KV_1_2"] = "subway_trains/720/controller/x1_x2.mp3"
    self.SoundNames["KV_2_3"] = "subway_trains/720/controller/x3_x4.mp3"
    self.SoundNames["KV_3_2"] = "subway_trains/720/controller/x4_x3.mp3"
    self.SoundNames["KV_2_1"] = "subway_trains/720/controller/x2_x1.mp3"
    self.SoundNames["KV_1_0"] = "subway_trains/720/controller/x1_0.mp3"
    self.SoundNames["KV_0_-1"] = "subway_trains/720/controller/0_t1.mp3"
    self.SoundNames["KV_-1_-2"] = "subway_trains/720/controller/t1_t2.mp3"
    self.SoundNames["KV_-2_-3"] = "subway_trains/720/controller/t2_t3.mp3"
    self.SoundPositions["KV_-3_-2"] = {80,1e9,Vector(443.8,18,-2),0.85}
    self.SoundPositions["KV_-2_-1"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_-1_0"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_0_1"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_1_2"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_2_3"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_3_4"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_4_3"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_3_2"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_2_1"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_1_0"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_0_-1"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_-1_-2"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_-2_-3"] = self.SoundPositions["KV_-3_-2"]

    self.SoundNames["kr_in"] = {
        "subway_trains/717/kru/kru_insert1.mp3",
        "subway_trains/717/kru/kru_insert2.mp3"
    }
    self.SoundNames["kr_out"] = {
        "subway_trains/717/kru/kru_eject1.mp3",
        "subway_trains/717/kru/kru_eject2.mp3",
        "subway_trains/717/kru/kru_eject3.mp3",
    }
    self.SoundNames["kr_-1_0"] = {
        "subway_trains/717/kru/kru0-1_1.mp3",
        "subway_trains/717/kru/kru0-1_2.mp3",
        "subway_trains/717/kru/kru0-1_3.mp3",
        "subway_trains/717/kru/kru0-1_4.mp3",
    }
    self.SoundNames["kr_0_1"] = {
        "subway_trains/717/kru/kru1-2_1.mp3",
        "subway_trains/717/kru/kru1-2_2.mp3",
        "subway_trains/717/kru/kru1-2_3.mp3",
        "subway_trains/717/kru/kru1-2_4.mp3",
    }
    self.SoundNames["kr_1_0"] = {
        "subway_trains/717/kru/kru2-1_1.mp3",
        "subway_trains/717/kru/kru2-1_2.mp3",
        "subway_trains/717/kru/kru2-1_3.mp3",
        "subway_trains/717/kru/kru2-1_4.mp3",
    }
    self.SoundNames["kr_0_-1"] = {
        "subway_trains/717/kru/kru1-0_1.mp3",
        "subway_trains/717/kru/kru1-0_2.mp3",
        "subway_trains/717/kru/kru1-0_3.mp3",
        "subway_trains/717/kru/kru1-0_4.mp3",
    }
    self.SoundPositions["kr_in"] = {80,1e9,Vector(444+2.5,24+2,-2.7-8)}
    self.SoundPositions["kr_out"] = self.SoundPositions["kr_in"]
    self.SoundPositions["kr_-1_0"] = self.SoundPositions["kr_in"]
    self.SoundPositions["kr_0_1"] = self.SoundPositions["kr_in"]
    self.SoundPositions["kr_1_0"] = self.SoundPositions["kr_in"]
    self.SoundPositions["kr_0_-1"] = self.SoundPositions["kr_in"]

    self.SoundNames["kru_in"] = self.SoundNames["kr_in"]
    self.SoundNames["kru_out"] = self.SoundNames["kr_out"]
    self.SoundNames["kru_-1_0"] = self.SoundNames["kr_-1_0"]
    self.SoundNames["kru_0_1"] = self.SoundNames["kr_0_1"]
    self.SoundNames["kru_1_0"] = self.SoundNames["kr_1_0"]
    self.SoundNames["kru_0_-1"] = self.SoundNames["kr_0_-1"]
    self.SoundPositions["kru_in"] = {80,1e9,Vector(451+3.2,24+2,-1-8)}
    self.SoundPositions["kru_out"] = self.SoundPositions["kru_in"]
    self.SoundPositions["kru_-1_0"] = self.SoundPositions["kru_in"]
    self.SoundPositions["kru_0_1"] = self.SoundPositions["kru_in"]
    self.SoundPositions["kru_1_0"] = self.SoundPositions["kru_in"]
    self.SoundPositions["kru_0_-1"] = self.SoundPositions["kru_in"]

    self.SoundNames["pvk2"] = "subway_trains/717/switches/vent1-2.mp3"
    self.SoundNames["pvk1"] = "subway_trains/717/switches/vent2-1.mp3"
    self.SoundNames["pvk0"] = "subway_trains/717/switches/vent1-0.mp3"
    self.SoundNames["vent_cabl"] = {loop=true,"subway_trains/717/vent/vent_cab_low.wav"}
    self.SoundPositions["vent_cabl"] = {140,1e9,Vector(456.8,45.8,-13),0.66}
    self.SoundNames["vent_cabh"] = {loop=true,"subway_trains/717/vent/vent_cab_high.wav"}
    self.SoundPositions["vent_cabh"] = self.SoundPositions["vent_cabl"]

    self.SoundNames["k2_on"] = "subway_trains/717/pneumo/lk2_on.mp3"
    self.SoundNames["k2_off"] = "subway_trains/717/pneumo/lk2_off.mp3"
    self.SoundNames["k1_on"] = "subway_trains/717/pneumo/lk1_on.mp3"
    self.SoundNames["k3_on"] = self.SoundNames["k2_on"]
    self.SoundNames["kmr1_on"] = self.SoundNames["k1_on"]
    self.SoundNames["kmr2_on"] = self.SoundNames["k1_on"]
    self.SoundNames["k1_off"] = self.SoundNames["k2_off"]
    self.SoundNames["k3_off"] = self.SoundNames["k2_off"]
    self.SoundNames["kmr1_off"] = self.SoundNames["k2_off"]
    self.SoundNames["kmr2_off"] = self.SoundNames["k2_off"]
    --self.SoundNames["ksh1_off"] = "subway_trains/717/pneumo/ksh1.mp3"
    self.SoundPositions["k2_on"] = {440,1e9,Vector(-60,-40,-66),0.22}
    self.SoundPositions["k1_on"] = {440,1e9,Vector(-60,-40,-66),0.3}
    self.SoundPositions["k2_off"] = self.SoundPositions["k2_on"]
    self.SoundPositions["k3_off"] = self.SoundPositions["k2_on"]
    self.SoundPositions["k3_on"] = self.SoundPositions["k2_on"]
    self.SoundPositions["k3_off"] = self.SoundPositions["k2_on"]
    self.SoundPositions["kmr1_on"] = self.SoundPositions["k2_on"]
    self.SoundPositions["kmr1_off"] = self.SoundPositions["k2_on"]
    self.SoundPositions["kmr2_on"] = self.SoundPositions["k2_on"]
    self.SoundPositions["kmr2_off"] = self.SoundPositions["k2_on"]
    --self.SoundPositions["ksh1_off"] = self.SoundPositions["lk1_on"]

    self.SoundNames["qf1_on"] = "subway_trains/717/pneumo/ksh1.mp3"
    self.SoundNames["qf1_off"] = "subway_trains/717/pneumo/ksh1.mp3"
    self.SoundPositions["qf1_on"] = self.SoundPositions["k2_on"]
    self.SoundPositions["qf1_off"] = self.SoundPositions["k2_on"]

    self.SoundNames["horn"] = {loop=0.6,"subway_trains/common/pneumatic/horn/horn3_start.wav","subway_trains/common/pneumatic/horn/horn3_loop.wav", "subway_trains/common/pneumatic/horn/horn3_end.wav"}
    self.SoundPositions["horn"] = {1100,1e9,Vector(500,0,-30)}

    self.SoundNames["ring"] = {loop=0.1,"subway_trains/717/ring/ringch_start.wav","subway_trains/717/ring/ringch_loop.wav","subway_trains/717/ring/ringch_end.wav"}
    self.SoundPositions["ring"] = {100,1e9,Vector(459,6,10),0.45}

    self.SoundNames["vpr"] = {loop=0.8,"subway_trains/common/other/radio/vpr_start.wav","subway_trains/common/other/radio/vpr_loop.wav","subway_trains/common/other/radio/vpr_off.wav"}
    self.SoundPositions["vpr"] = {60,1e9,Vector(430,-40 ,50),0.05}

    self.SoundNames["cab_door_open"] = "subway_trains/common/door/cab/door_open.mp3"
    self.SoundNames["cab_door_close"] = "subway_trains/common/door/cab/door_close.mp3"
    self.SoundNames["otsek_door_open"] = {"subway_trains/720/door/door_torec_open.mp3","subway_trains/720/door/door_torec_open2.mp3"}
    self.SoundNames["otsek_door_close"] = {"subway_trains/720/door/door_torec_close.mp3","subway_trains/720/door/door_torec_close2.mp3"}

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
    for i=1,7 do
        self.SoundNames["vent"..i] = {loop=true,"subway_trains/720/vent_mix.wav"}
        self.SoundPositions["vent"..i] = {100,1e9,Vector(yventpos[i],0,30),0.12}
    end
    for k,v in ipairs(self.AnnouncerPositions) do
        self.SoundNames["announcer_buzz"..k] = {loop=true,"subway_announcers/asnp/bpsn_ann.wav"}
        self.SoundPositions["announcer_buzz"..k] = {v[2] or 600,1e9,v[1],v[3]/8}
    end
end
function ENT:InitializeSystems()
    self:LoadSystem("Electric","81_718_Electric")
    -- Токоприёмник
    self:LoadSystem("TR","TR_3B")
    -- Электротяговые двигатели
    self:LoadSystem("Engines","DK_117DM")

    self:LoadSystem("BBE","81_718_BBE")
    self:LoadSystem("BKVA","81_718_BKVA")
    self:LoadSystem("BSKA","81_718_BSKA")
    self:LoadSystem("BUVS","81_718_BUVS")
    self:LoadSystem("PTTI","81_718_PTTI")

    self:LoadSystem("Panel","81_718_Panel")
    self:LoadSystem("KR","81_718_KR")
    self:LoadSystem("KRU","81_718_KRU")
    self:LoadSystem("BKCU","81_718_BKCU")

    self:LoadSystem("BUP","81_718_BUP")
    self:LoadSystem("BUV","81_718_BUV")
    self:LoadSystem("BVA","81_718_BVA")
    self:LoadSystem("BKBD","81_718_BKBD")
    self:LoadSystem("BZOS","81_718_BZOS")

    --self:LoadSystem("IGLA_CBKI","IGLA_CBKI1")
    --self:LoadSystem("IGLA_PCBK")

    self:LoadSystem("Announcer","81_71_Announcer", "AnnouncementsASNP")

    self:LoadSystem("RRI","81_71_RRI",Metrostroi.ASNPSetup)
    self:LoadSystem("RRI_VV","81_71_RRI_VV")
    --self:LoadSystem("ASNP","81_71_ASNP")

    -- Пневмосистема 81-710
    self:LoadSystem("Pneumatic","81_718_Pneumatic")
    self:LoadSystem("Battery","81_718_Battery")

    self:LoadSystem("Horn","81_722_Horn")

    self:LoadSystem("RouteNumber","81_718_RouteNumber")
    self:LoadSystem("LastStation","81_71_LastStation","717","destination")
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
    Name = "81-718",
    WagType = 1,
    Manufacturer = "MVM",
    ALS = {
        HaveAutostop = true,
        TwoToSix = true,
        RSAs325Hz = true,
        Aproove0As325Hz = false,
    },
    Announcer = {
    },
    EKKType = 718,
}
ENT.NumberRanges = {{0001,0100},{250,500}}
ENT.Spawner = {
    model = {
        "models/metrostroi_train/81-718/81-718.mdl",
        "models/metrostroi_train/81-718/81-718_dinas11.mdl",
        "models/metrostroi_train/81-718/81-718_cabine.mdl",
        "models/metrostroi_train/81-718/interior.mdl",
        "models/metrostroi_train/81-718/marshrut_number_body.mdl",
        "models/metrostroi_train/81-717/couch_old.mdl",
        "models/metrostroi_train/81-717/couch_cap_l.mdl",
        "models/metrostroi_train/81-717/couch_cap_r.mdl",
    },
    interim = "gmod_subway_81-719",
    Metrostroi.Skins.GetTable("Texture","Spawner.Texture",false,"train"),
    Metrostroi.Skins.GetTable("PassTexture","Spawner.PassTexture",false,"pass"),
    --Metrostroi.Skins.GetTable("CabTexture","Spawner.CabTexture",false,"cab"),
    {"Announcer","Spawner.718.Announcer","List",function()
        local Announcer = {}
        for k,v in pairs(Metrostroi.AnnouncementsASNP or {}) do if not v.asnp then Announcer[k] = v.name or k end end
        return Announcer
    end},
    {"Scheme","Spawner.718.Schemes","List",function()
        local Schemes = {}
        for k,v in pairs(Metrostroi.Skins["717_new_schemes"] or {}) do Schemes[k] = v.name or k end
        return Schemes
    end},
    {"SpawnMode","Spawner.718.SpawnMode","List",{"Spawner.718.SpawnMode.Full","Spawner.718.SpawnMode.Deadlock","Spawner.718.SpawnMode.NightDeadlock","Spawner.718.SpawnMode.Depot"}, nil,function(ent,val,rot,i,wagnum,rclk)
        if rclk then return end
        if ent._SpawnerStarted~=val then
            ent.VB:TriggerInput("Set",val<=2 and 1 or 0)
            ent.ParkingBrake:TriggerInput("Set",val==3 and 1 or 0)
            if ent.SF51  then
                local first = i==1 or _LastSpawner~=CurTime()
                ent.SF55:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SF63:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SF41:TriggerInput("Set",val<=3 and 1 or 0)
                ent.SF50:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SF54:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SAP3:TriggerInput("Set",val==1 and 1 or 0)
                ent["SA1/1"]:TriggerInput("Set",val==1 and 1 or 0)
                ent.SA13:TriggerInput("Set",(ent.Plombs.RC and val==1 and first) and 1 or 0)
                ent.SA16:TriggerInput("Set",(val==1 and first) and 1 or 0)
                ent.SAP8:TriggerInput("Set",(val==1 and first) and 1 or 0)
                ent.SAP9:TriggerInput("Set",val==1 and 1 or 0)
                --ent.SAP10:TriggerInput("Set",val==1 and 1 or 0)
                _LastSpawner=CurTime()
                ent.CabinDoor = val==4 and first
                ent.PassengerDoor = val==4
                ent.RearDoor = val==4
                ent.EPK:TriggerInput("Set",(ent.Plombs.RC and val==1) and 1 or 0)
            else
                ent.FrontDoor = val==4
                ent.RearDoor = val==4
            end
            if val == 1 then
                ent.BVA:TriggerInput("Enable",1)
                ent.BBE:TriggerInput("Enable",1)
            end
            ent.GV:TriggerInput("Set",val<4 and 1 or 0)
            ent._SpawnerStarted = val
        end
        ent.Pneumatic.TrainLinePressure = val==3 and math.random()*4 or val==2 and 4.5+math.random()*3 or 7.6+math.random()*0.6
        if val==4 then ent.Pneumatic.BrakeLinePressure = 5.2 end
    end},
}--]]

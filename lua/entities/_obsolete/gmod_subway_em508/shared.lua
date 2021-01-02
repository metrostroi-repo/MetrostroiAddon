ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.PrintName       = "Entities.Em508"
ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "Metrostroi (trains)"

ENT.Spawnable       = true
ENT.AdminSpawnable  = false

function ENT:PassengerCapacity()
    return 300
end

function ENT:GetStandingArea()
    return Vector(-450,-30,-45),Vector(380,30,-45)
end

local function GetDoorPosition(i,k)
    return Vector(359.0 - 35/2 - 229.5*i,-65*(1-2*k),7.5)
end
ENT.AnnouncerPositions = {
    {Vector(412,-49 ,61),80,1},
    {Vector(-3,-60, 62),300,1},
    {Vector(-3,60 ,62),300,1},
}
ENT.Cameras = {
    {Vector(407.5+15,32,16),Angle(0,180,0),"Train.703.Breakers1"},
    {Vector(407.5+11,46,20),Angle(0,180,0),"Train.703.Breakers2"},
    {Vector(407.5+28,48,16),Angle(0,40,0),"Train.703.Left"},
    {Vector(407.5+11,37,-5),Angle(0,0,0),"Train.703.Parking"},
    {Vector(407.5+29,-45,43),Angle(0,-90,0),"Train.703.ASNP"},
    {Vector(407.5+10,-45,7),Angle(0,-90,0),"Train.703.IGLA"},
}


function ENT:InitializeSounds()
    self.BaseClass.InitializeSounds(self)
    self.SoundNames["rolling_10"] = {loop=true,"subway_trains/717/rolling/10_rolling.wav"}
    self.SoundNames["rolling_40"] = {loop=true,"subway_trains/717/rolling/40_rolling.wav"}
    self.SoundNames["rolling_70"] = {loop=true,"subway_trains/717/rolling/70_rolling.wav"}
    self.SoundNames["rolling_80"] = {loop=true,"subway_trains/717/rolling/80_rolling.wav"}
    self.SoundPositions["rolling_10"] = {1200,1e9,Vector(0,0,0),1}
    self.SoundPositions["rolling_40"] = self.SoundPositions["rolling_10"]
    self.SoundPositions["rolling_70"] = self.SoundPositions["rolling_10"]
    self.SoundPositions["rolling_80"] = self.SoundPositions["rolling_10"]
    self.SoundNames["pneumo_disconnect2"] = "subway_trains/common/pneumatic/pneumo_close.mp3"
    self.SoundNames["pneumo_disconnect1"] = {
        "subway_trains/common/pneumatic/pneumo_open.mp3",
        "subway_trains/common/pneumatic/pneumo_open2.mp3",
    }
    self.SoundPositions["pneumo_disconnect2"] = {60,1e9,Vector(431.8,-50.1+1.5,-33.7),1}
    self.SoundPositions["pneumo_disconnect1"] = {60,1e9,Vector(431.8,-50.1+1.5,-33.7),1}
    self.SoundNames["epv_on"]           = "subway_trains/common/pneumatic/epv_on.mp3"
    self.SoundNames["epv_off"]          = "subway_trains/common/pneumatic/epv_off.mp3"
    self.SoundPositions["epv_on"] = {100,1e9,Vector(437.2,-53.1,-32.0),1}
    self.SoundPositions["epv_off"] = {100,1e9,Vector(437.2,-53.1,-32.0),1}
    self.SoundPositions["epv_off"] = {60,1e9,Vector(437.2,-53.1,-32.0),1}
    -- Релюшки
    self.SoundNames["rpb_off"] = "subway_trains/717/relays/lsd_2.mp3"
    self.SoundNames["rpb_on"] = "subway_trains/717/relays/relay_on.mp3"
    self.SoundPositions["rpb_on"] = {100,1e9,Vector(400,25,-35),1}
    self.SoundPositions["rpb_off"] = {100,1e9,Vector(400,25,-35),1}
    self.SoundNames["rvt_on"] = {
        "subway_trains/717/relays/brake_on1.mp3",
    }
    self.SoundNames["rvt_off"] = {
        "subway_trains/717/relays/brake_off1.mp3",
        "subway_trains/717/relays/brake_off2.mp3",
        "subway_trains/717/relays/brake_off3.mp3",
    }
    self.SoundPositions["rvt_on"] = {100,1e9,Vector(400,25,-35),1}
    self.SoundPositions["rvt_off"] = {100,1e9,Vector(400,25,-35),1}
    if self.Breakers then
            self.SoundNames["r1_5_on"] = "subway_trains/717/relays/drive_on1.mp3"
    else
            self.SoundNames["r1_5_on"] = "subway_trains/717/relays/drive2_on.mp3"
    end
    self.SoundNames["r1_5_off"] = "subway_trains/717/relays/drive_off.mp3"
    self.SoundPositions["r1_5_on"] = {100,1e9,Vector(400,25,-35),1}
    self.SoundPositions["r1_5_off"] = {100,1e9,Vector(400,25,-35),1}

    self.SoundNames["kd_off"] = "subway_trains/717/relays/lsd_2.mp3"
    self.SoundNames["kd_on"] = "subway_trains/717/relays/lsd_1.mp3"
    self.SoundPositions["kd_on"] = {100,1e9,Vector(400,25,-35),1}
    self.SoundPositions["kd_off"] = {100,1e9,Vector(400,25,-35),1}
    self.SoundNames["k25_off"] = "subway_trains/717/relays/lsd_2.mp3"
    self.SoundNames["k25_on"] = "subway_trains/717/relays/relay_on.mp3"
    self.SoundPositions["k25_on"] = {120,1e9,Vector(400,25,-35),1}
    self.SoundPositions["k25_off"] = {120,1e9,Vector(400,25,-35),1}
    self.SoundNames["ro_off"] = "subway_trains/717/relays/lsd_2.mp3"
    self.SoundNames["ro_on"] = "subway_trains/717/relays/RO_on.mp3"
    self.SoundPositions["ro_on"] = {140,1e9,Vector(400,25,-35),1}
    self.SoundPositions["ro_off"] = {140,1e9,Vector(400,25,-35),1}


    self.SoundNames["avu_off"] = "subway_trains/717/relays/lsd_2.mp3"
    self.SoundNames["avu_on"] = "subway_trains/717/relays/relay_on.mp3"
    self.SoundPositions["avu_on"] = {60,1e9, Vector(400,-40,-45),1}
    self.SoundPositions["avu_off"] = {60,1e9, Vector(400,-40,-45),1}
    --Подвагонка
    self.SoundNames["lk2_on"] = "subway_trains/717/pneumatic/lk/lk2_on.mp3"
    self.SoundNames["lk2_off"] = "subway_trains/717/pneumatic/lk/lk2_off.mp3"
    self.SoundNames["lk3_on"] = "subway_trains/717/pneumatic/lk/lk3_on.mp3"
    self.SoundNames["lk3_off"] = "subway_trains/717/pneumatic/lk/lk3_off.mp3"
    self.SoundPositions["lk2_on"] = {440,1e9,Vector(-60,-40,-66),0.2}
    self.SoundPositions["lk2_off"] = {400,1e9,Vector(-60,-40,-66),0.6}
    self.SoundPositions["lk3_on"] = {440,1e9,Vector(-60,-40,-66),0.2}
    self.SoundPositions["lk3_off"] = {400,1e9,Vector(-60,-40,-66),0.6}

    self.SoundNames["compressor"] = {loop=2.0,"subway_trains/ezh/compressor/ezh_compressor_start.mp3","subway_trains/ezh/compressor/ezh_compressor_loop.mp3", "subway_trains/ezh/compressor/ezh_compressor_end.mp3"}
    self.SoundPositions["compressor"] = {700,1e9,Vector(-118,-40,-66)}
    self.SoundNames["rk"] = {"subway_trains/717/rk/rk_start.wav","subway_trains/717/rk/rk_spin.wav","subway_trains/717/rk/rk_stop.mp3"}
    self.SoundPositions["rk"] = {70,1e3,Vector(110,-40,-75)}

    self.SoundNames["ezh3_revers_0-f"] = {"subway_trains/717/kv70/reverser_0-f_1.mp3","subway_trains/717/kv70/reverser_0-f_2.mp3"}
    self.SoundNames["ezh3_revers_f-0"] = {"subway_trains/717/kv70/reverser_f-0_1.mp3","subway_trains/717/kv70/reverser_f-0_2.mp3"}
    self.SoundNames["ezh3_revers_0-b"] = {"subway_trains/717/kv70/reverser_0-b_1.mp3","subway_trains/717/kv70/reverser_0-b_2.mp3"}
    self.SoundNames["ezh3_revers_b-0"] = {"subway_trains/717/kv70/reverser_b-0_1.mp3","subway_trains/717/kv70/reverser_b-0_2.mp3"}
    self.SoundNames["revers_in"] = {"subway_trains/ezh3/kv66/revers_in.wav"}
    self.SoundNames["revers_out"] = {"subway_trains/ezh3/kv66/revers_out.wav"}
    self.SoundPositions["ezh3_revers_0-f"] = {80,1e9,Vector(445.5,-32+1.7,-7.5)}
    self.SoundPositions["ezh3_revers_f-0"] = {80,1e9,Vector(445.5,-32+1.7,-7.5)}
    self.SoundPositions["ezh3_revers_0-b"] = {80,1e9,Vector(445.5,-32+1.7,-7.5)}
    self.SoundPositions["ezh3_revers_b-0"] = {80,1e9,Vector(445.5,-32+1.7,-7.5)}
    self.SoundPositions["ezh3_revers_in"] = {80,1e9,Vector(445.5,-32+1.7,-7.5)}
    self.SoundPositions["ezh3_revers_out"] = {80,1e9,Vector(445.5,-32+1.7,-7.5)}

    self.SoundNames["kru_in"] = {
        "subway_trains/717/kru/kru_insert1.mp3",
        "subway_trains/717/kru/kru_insert2.mp3"
    }
    self.SoundPositions["kru_in"] = {80,1e9,Vector(452.3,-24.0,4.0)}
    self.SoundNames["kru_out"] = {
        "subway_trains/717/kru/kru_eject1.mp3",
        "subway_trains/717/kru/kru_eject2.mp3",
        "subway_trains/717/kru/kru_eject3.mp3",
    }
    self.SoundPositions["kru_out"] = {80,1e9,Vector(452.3,-24.0,4.0)}

    self.SoundNames["kru_0_1"] = {
        "subway_trains/717/kru/kru0-1_1.mp3",
        "subway_trains/717/kru/kru0-1_2.mp3",
        "subway_trains/717/kru/kru0-1_3.mp3",
        "subway_trains/717/kru/kru0-1_4.mp3",
    }
    self.SoundNames["kru_1_2"] = {
        "subway_trains/717/kru/kru1-2_1.mp3",
        "subway_trains/717/kru/kru1-2_2.mp3",
        "subway_trains/717/kru/kru1-2_3.mp3",
        "subway_trains/717/kru/kru1-2_4.mp3",
    }
    self.SoundNames["kru_2_1"] = {
        "subway_trains/717/kru/kru2-1_1.mp3",
        "subway_trains/717/kru/kru2-1_2.mp3",
        "subway_trains/717/kru/kru2-1_3.mp3",
        "subway_trains/717/kru/kru2-1_4.mp3",
    }
    self.SoundNames["kru_1_0"] = {
        "subway_trains/717/kru/kru1-0_1.mp3",
        "subway_trains/717/kru/kru1-0_2.mp3",
        "subway_trains/717/kru/kru1-0_3.mp3",
        "subway_trains/717/kru/kru1-0_4.mp3",
    }
    self.SoundNames["kru_2_3"] = {
        "subway_trains/717/kru/kru2-3_1.mp3",
        "subway_trains/717/kru/kru2-3_2.mp3",
        "subway_trains/717/kru/kru2-3_3.mp3",
        "subway_trains/717/kru/kru2-3_4.mp3",
    }
    self.SoundNames["kru_3_2"] = {
        "subway_trains/717/kru/kru3-2_1.mp3",
        "subway_trains/717/kru/kru3-2_2.mp3",
        "subway_trains/717/kru/kru3-2_3.mp3",
        "subway_trains/717/kru/kru3-2_4.mp3",
    }
    self.SoundPositions["kru_0_1"] = {80,1e9,Vector(452.3,-24.0,4.0)}
    self.SoundPositions["kru_1_2"] = {80,1e9,Vector(452.3,-24.0,4.0)}
    self.SoundPositions["kru_2_1"] = {80,1e9,Vector(452.3,-24.0,4.0)}
    self.SoundPositions["kru_1_0"] = {80,1e9,Vector(452.3,-24.0,4.0)}
    self.SoundPositions["kru_2_3"] = {80,1e9,Vector(452.3,-24.0,4.0)}
    self.SoundPositions["kru_3_2"] = {80,1e9,Vector(452.3,-24.0,4.0)}

    self.SoundNames["kr_open"] = {
        "subway_trains/717/cover/cover_open1.mp3",
        "subway_trains/717/cover/cover_open2.mp3",
        "subway_trains/717/cover/cover_open3.mp3",
    }
    self.SoundNames["kr_close"] = {
        "subway_trains/717/cover/cover_close1.mp3",
        "subway_trains/717/cover/cover_close2.mp3",
        "subway_trains/717/cover/cover_close3.mp3",
    }

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

    self.SoundNames["triple_down-0"] = {
        "subway_trains/717/switches/tumbler_triple_down-0_1.mp3",
        "subway_trains/717/switches/tumbler_triple_down-0_2.mp3",
    }
    self.SoundNames["triple_0-up"] = {
        "subway_trains/717/switches/tumbler_triple_0-up_1.mp3",
        "subway_trains/717/switches/tumbler_triple_0-up_2.mp3",
    }
    self.SoundNames["triple_up-0"] = {
        "subway_trains/717/switches/tumbler_triple_up-0_1.mp3",
        "subway_trains/717/switches/tumbler_triple_up-0_2.mp3",
    }
    self.SoundNames["triple_0-down"] = {
        "subway_trains/717/switches/tumbler_triple_0-down_1.mp3",
        "subway_trains/717/switches/tumbler_triple_0-down_2.mp3",
    }
    self.SoundNames["button1_off"] = {
        "subway_trains/ezh3/switches/button_off1.mp3",
        "subway_trains/ezh3/switches/button_off2.mp3",
    }
    self.SoundNames["button1_on"] = {
        "subway_trains/ezh3/switches/button_on1.mp3",
        "subway_trains/ezh3/switches/button_on2.mp3",
    }
    self.SoundNames["button2_off"] = {
        "subway_trains/ezh3/switches/button_off3.mp3",
        "subway_trains/ezh3/switches/button_off4.mp3",
    }
    self.SoundNames["button2_on"] = {
        "subway_trains/ezh3/switches/button_on3.mp3",
        "subway_trains/ezh3/switches/button_on4.mp3",
    }
    self.SoundNames["button3_off"] = {
        "subway_trains/ezh3/switches/button_off6.mp3",
        "subway_trains/ezh3/switches/button_off5.mp3",
    }
    self.SoundNames["button3_on"] = {
        "subway_trains/ezh3/switches/button_on5.mp3",
        "subway_trains/ezh3/switches/button_on6.mp3",
    }
    self.SoundNames["button4_off"] = {
        "subway_trains/ezh3/switches/button_on1.mp3",
        "subway_trains/ezh3/switches/button_on2.mp3",
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
    self.SoundPositions["uava_reset"] = {80,1e9,Vector(449+7.7,56.0,-10.24349),0.6}
    self.SoundNames["gv_f"] = self.SoundNames["revers_0-b"]
    self.SoundNames["gv_b"] = self.SoundNames["revers_b-0"]
    self.SoundPositions["gv_f"]     = {80,1e2,Vector(120,62.0+0.0,-60),0.5}
    self.SoundPositions["gv_b"]     = {80,1e2,Vector(120,62.0+0.0,-60),0.5}

        --Краны
    self.SoundNames["brake"] = {"subway_trains/common/pneumatic/vz_brake_on1.mp3","subway_trains/common/pneumatic/vz_brake_on2.mp3"}
    self.SoundPositions["brake"] = {600,1e9,Vector(0,0,0),0.5}
    self.SoundNames["release1"] = {loop=true,"subway_trains/common/pneumatic/release.wav"} --TODO разделение отпуска и срыва по позициям в кабине\вне
    self.SoundPositions["release1"] = {1200,1e9,Vector(-183,0,-70)}
    self.SoundNames["crane334_brake"] = {loop=true,"subway_trains/common/pneumatic/334_brake.wav"} --TODO добавить жужжащий звук
    self.SoundPositions["crane334_brake"] = {180,1e9,Vector(440,-55.75,-10)}
    self.SoundNames["crane334_brake_slow"] = {loop=true,"subway_trains/common/pneumatic/334_brake_slow.wav"} --TODO добавить жужжащий звук
    self.SoundPositions["crane334_brake_slow"] = {180,1e9,Vector(440,-55.75,-10)}
    self.SoundNames["crane334_release"] = {loop=true,"subway_trains/common/pneumatic/334_release.wav"}
    self.SoundPositions["crane334_release"] = {180,1e9,Vector(440,-55.75,-10)}

    self.SoundNames["epk_brake"] = {loop=true,"subway_trains/common/pneumatic/epv_loop.wav"}
    self.SoundPositions["epk_brake"] = {200,1e9,Vector(437.2,-53.1,-50.0)}
    self.SoundNames["epk_brake_start"]          = "subway_trains/common/pneumatic/epv_start.mp3"
    self.SoundPositions["epk_brake_start"]  = self.SoundPositions["epk_brake"]

    self.SoundNames["valve_brake"] = {loop=true,"subway_trains/common/pneumatic/epv_loop.wav"}
    self.SoundPositions["valve_brake"] = {200,1e9,Vector(402,-63,-50)}
    self.SoundNames["valve_brake_start"]            = "subway_trains/common/pneumatic/epv_start.mp3"
    self.SoundPositions["valve_brake_start"]  = self.SoundPositions["valve_brake"]

    self.SoundNames["emer_brake"] = {loop=true,"subway_trains/common/pneumatic/epv_loop.wav"}
    self.SoundPositions["emer_brake"] = {200,1e9,Vector(380,-45,-75)}
    self.SoundNames["emer_brake_start"]         = "subway_trains/common/pneumatic/epv_start.mp3"
    self.SoundPositions["emer_brake_start"]  = self.SoundPositions["emer_brake"]

    self.SoundNames["pneumo_TL_open"] = {
        "subway_trains/common/334/334_open.mp3",
    }
    self.SoundNames["pneumo_TL_disconnect"] = {
        "subway_trains/common/334/334_close.mp3",
    }
    self.SoundNames["pneumo_BL_disconnect"] = {
        "subway_trains/common/334/334_close.mp3",
    }

    self.SoundNames["pak_on"] = "subway_trains/717/switches/rc_on.mp3"
    self.SoundNames["pak_off"] = "subway_trains/717/switches/rc_off.mp3"

    --self.SoundNames["kv70_fix_on"] = {"subway_trains/717/kv70/kv70_fix_on1.mp3","subway_trains/717/kv70/kv70_fix_on2.mp3"}
--  self.SoundNames["kv70_fix_off"] = {"subway_trains/717/kv70/kv70_fix_off1.mp3","subway_trains/717/kv70/kv70_fix_off2.mp3"}
    self.SoundNames["kv40_0_t1"] = {"subway_trains/ezh/kv40/kv40_0_T1.mp3"}
    self.SoundNames["kv40_t1_0"] = {"subway_trains/ezh/kv40/kv40_T1_0.mp3"}
    self.SoundNames["kv40_t1_t1a"] = {"subway_trains/ezh/kv40/kv40_T1_T1A.mp3"}
    self.SoundNames["kv40_t1a_t1"] = {"subway_trains/ezh/kv40/kv40_T1A_T1.mp3"}
    self.SoundNames["kv40_t1a_t2"] = {"subway_trains/ezh/kv40/kv40_T1A_T2.mp3"}
    self.SoundNames["kv40_t2_t1a"] = {"subway_trains/ezh/kv40/kv40_T2_T1A.mp3"}
    self.SoundNames["kv40_0_x1"] = {"subway_trains/ezh/kv40/kv40_0_X1.mp3"}
    self.SoundNames["kv40_x1_0"] = {"subway_trains/ezh/kv40/kv40_X1_0.mp3"}
    self.SoundNames["kv40_x1_x2"] = {"subway_trains/ezh/kv40/kv40_X1_X2.mp3"}
    self.SoundNames["kv40_x2_x1"] = {"subway_trains/ezh/kv40/kv40_X2_X1.mp3"}
    self.SoundNames["kv40_x2_x3"] = {"subway_trains/ezh/kv40/kv40_X2_X3.mp3"}
    self.SoundNames["kv40_x3_x2"] = {"subway_trains/ezh/kv40/kv40_X3_X2.mp3"}
    --self.SoundPositions["kv70_fix_on"] = {100,1e9,Vector(442.2,-40,-16.2),2}
    --self.SoundPositions["kv70_fix_off"] = {100,1e9,Vector(442.2,-40,-16.2),2}
    self.SoundPositions["kv40_0_t1"] = {100,1e9,Vector(442.2,-40,-16.2),2}
    self.SoundPositions["kv40_t1_0"] = self.SoundPositions["kv40_0_t1"]
    self.SoundPositions["kv40_t1_t1a"] = self.SoundPositions["kv40_0_t1"]
    self.SoundPositions["kv40_t1a_t1"] = self.SoundPositions["kv40_0_t1"]
    self.SoundPositions["kv40_t1a_t2"] = self.SoundPositions["kv40_0_t1"]
    self.SoundPositions["kv40_t2_t1a"] = self.SoundPositions["kv40_0_t1"]
    self.SoundPositions["kv40_0_x1"] = self.SoundPositions["kv40_0_t1"]
    self.SoundPositions["kv40_x1_0"] = self.SoundPositions["kv40_0_t1"]
    self.SoundPositions["kv40_x1_x2"] = self.SoundPositions["kv40_0_t1"]
    self.SoundPositions["kv40_x2_x1"] = self.SoundPositions["kv40_0_t1"]
    self.SoundPositions["kv40_x2_x3"] = self.SoundPositions["kv40_0_t1"]
    self.SoundPositions["kv40_x3_x2"] = self.SoundPositions["kv40_0_t1"]

    self.SoundNames["ring"] = {"subway_trains/717/ring/ring_start.wav","subway_trains/717/ring/ring_loop.wav","subway_trains/717/ring/ring_end.wav"}
    self.SoundPositions["ring"] = {100,1e9,Vector(400,-40,50)}

    self.SoundNames["ring2"] = {loop=0.1,"subway_trains/717/ring/ringc_start.wav","subway_trains/717/ring/ringc_loop.wav","subway_trains/717/ring/ringc_end.mp3"}
    self.SoundPositions["ring2"] = {100,1e9,Vector(400,-40,50)}

    self.SoundNames["ring_old"] = {loop=0.15,"subway_trains/717/ring/ringo_start.wav","subway_trains/717/ring/ringo_loop.wav","subway_trains/717/ring/ringo_end.mp3"}
    self.SoundPositions["ring_old"] = {100,1e9,Vector(400,-40,50)}

    self.SoundNames["cab_door_open"] = {
        "subway_trains/common/door/cab/cab_door_open2.mp3",
        "subway_trains/common/door/cab/cab_door_open.mp3",
    }
    self.SoundPositions["cab_door_open"] = {100,1e9,Vector(400,-40,50)}

    self.SoundNames["cab_door_close"] = {
        "subway_trains/common/door/cab/cab_door_close2.mp3",
        "subway_trains/common/door/cab/cab_door_close.mp3",
    }

    self.SoundNames["parking_brake_rolling"] = {"subway_trains/ezh3/parking_brake_rolling1.mp3","subway_trains/ezh3/parking_brake_rolling2.mp3","subway_trains/ezh3/parking_brake_rolling3.mp3","subway_trains/ezh3/parking_brake_rolling4.mp3"}
    self.SoundPositions["parking_brake_rolling"] = {120,1e9,Vector(449.118378+7.6,33.493385,-14.713276)}
    self.SoundNames["av8_on"] = {"subway_trains/common/switches/av8/av8_on.mp3","subway_trains/common/switches/av8/av8_on2.mp3"}
    self.SoundNames["av8_off"] = {"subway_trains/common/switches/av8/av8_off.mp3","subway_trains/common/switches/av8/av8_off2.mp3"}
    self.SoundPositions["av8_on"] = {100,1e9,Vector(405,40,30)}
    self.SoundPositions["av8_off"] = {100,1e9,Vector(405,40,30)}

    self.SoundNames["vu22_on"] = {"subway_trains/ezh3/vu/vu22_on1.mp3", "subway_trains/ezh3/vu/vu22_on2.mp3", "subway_trains/ezh3/vu/vu22_on3.mp3"}
    self.SoundNames["vu22_off"] = {"subway_trains/ezh3/vu/vu22_off1.mp3", "subway_trains/ezh3/vu/vu22_off2.mp3", "subway_trains/ezh3/vu/vu22_off3.mp3"}
    self.SoundNames["vu223_on"] = {"subway_trains/common/switches/vu22/vu22_3_on.mp3"}
    self.SoundNames["vu223_off"] = {"subway_trains/common/switches/vu22/vu22_3_off.mp3"}

    self.SoundNames["igla_on"]  = "subway_trains/common/other/igla/igla_on1.mp3"
    self.SoundNames["igla_off"] = "subway_trains/common/other/igla/igla_off2.mp3"
    self.SoundNames["igla_start1"]  = "subway_trains/common/other/igla/igla2_start1.mp3"
    self.SoundNames["igla_start2"]  = "subway_trains/common/other/igla/igla2_start2.mp3"
    self.SoundPositions["igla_on"] = {50,1e9,Vector(420.4-0.6,-56.1-0.15,9.87-1.15),0.3}
    self.SoundPositions["igla_off"] = {50,1e9,Vector(420.4-0.6,-56.1-0.15,9.87-1.15),0.3}
    self.SoundPositions["igla_start1"] = {50,1e9,Vector(420.4-0.6,-56.1-0.15,9.87-1.15),0.3}
    self.SoundPositions["igla_start2"] = {50,1e9,Vector(420.4-0.6,-56.1-0.15,9.87-1.15),0.2}

    self.SoundNames["upps"]         = {"subway_trains/common/other/upps/upps1.mp3","subway_trains/common/other/upps/upps2.mp3"}
    self.SoundPositions["upps"] = {60,1e9,Vector(443,-64,4),0.5}

    self.SoundNames["pnm_on"]           = {"subway_trains/common/pnm/pnm_switch_on.mp3","subway_trains/common/pnm/pnm_switch_on2.mp3"}
    self.SoundNames["pnm_off"]          = {"subway_trains/common/pnm/pnm_switch_off.mp3","subway_trains/common/pnm/pnm_switch_off2.mp3"}
    self.SoundNames["pnm_button1_on"]           = {
        "subway_trains/common/pnm/pnm_button_push.mp3",
        "subway_trains/common/pnm/pnm_button_push2.mp3",
        "subway_trains/common/pnm/pnm_button_push3.mp3",
    }

    self.SoundNames["pnm_button2_on"]           = {
        "subway_trains/common/pnm/pnm_button_push4.mp3",
        "subway_trains/common/pnm/pnm_button_push5.mp3",
        "subway_trains/common/pnm/pnm_button_push6.mp3",
    }

    self.SoundNames["pnm_button1_off"]          = {
        "subway_trains/common/pnm/pnm_button_release.mp3",
        "subway_trains/common/pnm/pnm_button_release2.mp3",
        "subway_trains/common/pnm/pnm_button_release3.mp3",
    }

    self.SoundNames["pnm_button2_off"]          = {
        "subway_trains/common/pnm/pnm_button_release4.mp3",
        "subway_trains/common/pnm/pnm_button_release5.mp3",
        "subway_trains/common/pnm/pnm_button_release6.mp3",
    }

    self.SoundNames["horn1"] = {loop=0.6,"subway_trains/common/pneumatic/horn/horn1_start.wav","subway_trains/common/pneumatic/horn/horn1_loop.wav", "subway_trains/common/pneumatic/horn/horn1_end.mp3"}
    self.SoundNames["horn2"] = {loop=0.8,"subway_trains/common/pneumatic/horn/horn3_start.wav","subway_trains/common/pneumatic/horn/horn3_loop.wav", "subway_trains/common/pneumatic/horn/horn3_end.wav"}
    self.SoundPositions["horn1"] = {1100,1e9,Vector(450,0,-55)}
    self.SoundPositions["horn2"] = self.SoundPositions["horn1"]

    --DOORS
    self.SoundNames["vdol_on"] = {
        "subway_trains/common/pneumatic/door_valve/VDO_on.mp3",
        "subway_trains/common/pneumatic/door_valve/VDO2_on.mp3",
    }
    self.SoundNames["vdol_off"] = {
        "subway_trains/common/pneumatic/door_valve/VDO_off.mp3",
        "subway_trains/common/pneumatic/door_valve/VDO2_off.mp3",
    }
    self.SoundPositions["vdol_on"] = {100,1e9,Vector(410,20,-45)}
    self.SoundPositions["vdol_off"] = self.SoundPositions["vdol_on"]
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
    self.SoundPositions["vdz_on"] = {100,1e9,Vector(410,20,-45)}
    self.SoundPositions["vdz_off"] = {100,1e9,Vector(410,20,-45)}

    for i=0,3 do
        for k=0,1 do
            self.SoundNames["door"..i.."x"..k.."r"] = {"subway_trains/common/door/door_roll.wav",loop=true}
            self.SoundPositions["door"..i.."x"..k.."r"] = {150,1e9,GetDoorPosition(i,k),0.2}
            self.SoundNames["door"..i.."x"..k.."o"] = {"subway_trains/common/door/door_open_end1.mp3","subway_trains/common/door/door_open_end2.mp3","subway_trains/common/door/door_open_end3.mp3","subway_trains/common/door/door_open_end4.mp3"}
            self.SoundPositions["door"..i.."x"..k.."o"] = {300,1e9,GetDoorPosition(i,k),1}
            self.SoundNames["door"..i.."x"..k.."c"] = {"subway_trains/common/door/door_close_end.mp3","subway_trains/common/door/door_close_end2.mp3","subway_trains/common/door/door_close_end3.mp3"}
            self.SoundPositions["door"..i.."x"..k.."c"] = self.SoundPositions["door"..i.."x"..k.."o"]
        end
    end
    self.SoundNames["PN2end"] = "subway_trains/common/pneumatic/vz2_end.mp3"
    self.SoundPositions["PN2end"] = {600,1e9,Vector(-183,0,-70),0.5}


    for k,v in ipairs(self.AnnouncerPositions) do
        self.SoundNames["announcer_noise1_"..k] = {loop=true,"subway_announcers/upo/noiseS1.wav"}
        self.SoundPositions["announcer_noise1_"..k] = {v[2] or 300,1e9,v[1],v[3]*0.5}
        self.SoundNames["announcer_noise2_"..k] = {loop=true,"subway_announcers/upo/noiseS2.wav"}
        self.SoundPositions["announcer_noise2_"..k] = {v[2] or 300,1e9,v[1],v[3]*0.5}
    end
end

function ENT:InitializeSystems()
    -- Электросистема Е (АРС)
    self:LoadSystem("Electric","81_701_Electric")

    -- Токоприёмник
    self:LoadSystem("TR","TR_3B")
    -- Электротяговые двигатели
    self:LoadSystem("Engines","DK_108D")

    -- Резисторы для реостата/пусковых сопротивлений
    self:LoadSystem("KF_47A","KF_47A6")
    -- Резисторы для ослабления возбуждения
    self:LoadSystem("KF_50A")
    -- Ящик с предохранителями
    self:LoadSystem("YAP_57")

    -- Резисторы для цепей управления
    --self:LoadSystem("YAS_44V")
    -- Реостатный контроллер для управления пусковыми сопротивления
    self:LoadSystem("RheostatController","EKG_17B")
    -- Групповой переключатель положений
    self:LoadSystem("PositionSwitch","EKG_18B")
    -- Кулачковый контроллер
    self:LoadSystem("KV","KV_40")
    -- Контроллер резервного управления (KRP)
    self:LoadSystem("KRU")


    -- Ящики с реле и контакторами
    self:LoadSystem("LK_755A")
    self:LoadSystem("YAR_13A","YAR_15A")
    self:LoadSystem("YAR_27")
    self:LoadSystem("YAK_36")
    self:LoadSystem("YAK_37E")
    self:LoadSystem("YAS_44V")
    self:LoadSystem("YARD_2")
    self:LoadSystem("PR_14X_Panels")

    -- Пневмосистема 81-710
    self:LoadSystem("Pneumatic","81_717_Pneumatic")
    self.Pneumatic.ValveType = 1
    -- Панель управления Еж АРС МП
    self:LoadSystem("Panel","81_508_Panel")
    -- Everything else
    self:LoadSystem("Battery")
    self:LoadSystem("PowerSupply","DIP_01K")
    --self:LoadSystem("DURA")
    self:LoadSystem("ALS_ARS","NoARS")

    self:LoadSystem("ASNP31","Relay","Switch")
    self:LoadSystem("ASNP32","Relay","Switch")
    self:LoadSystem("Horn")

    self:LoadSystem("Announcer","81_722_Announcer", "AnnouncementsASNP")
    self:LoadSystem("ASNP","81_71_ASNP")
    self:LoadSystem("IGLA_CBKI","IGLA_CBKI2")
    self:LoadSystem("IGLA_PCBK")
end

ENT.SubwayTrain = {
    Type = "E",
    Name = "Em508",
    WagType = 0,
    ARS = {
        HaveASNP = true,
        NoEPK = true,
    },
    ALS = {
        HaveAutostop = true,
    },
    EKKType = 703,
    NoFrontEKK=true,
}
ENT.NumberRanges = {{3905,3954},{6001,6100},{6201,6251}}

local Texture = {}
for k,v in pairs(Metrostroi.Skins["train"]) do
    if v.typ == "em508" then Texture[k] = v.name or k end
end
local PassTexture = {}
for k,v in pairs(Metrostroi.Skins["pass"] or {}) do
    if v.typ == "em508" then PassTexture[k] = v.name or k end
end
local CabTexture = {}
for k,v in pairs(Metrostroi.Skins["cab"] or {}) do
    if v.typ == "em508" then CabTexture[k] = v.name or k end
end
local Announcer = {}
for k,v in pairs(Metrostroi.AnnouncementsASNP or {}) do Announcer[k] = v.name or k end
ENT.Spawner = {
    model = "models/metrostroi_train/81-508/81-508.mdl",
    interim = "gmod_subway_em508_int",
    func = function(ent,i,maxi)
        if i > 1 and i < maxi then
            ent.VU:TriggerInput("Set",0)
            ent.UAVA:TriggerInput("Set",1)
            ent.Plombs.VU = false
            ent.Plombs.UAVA = nil
        else
            ent.VU:TriggerInput("Set",1)
            ent.UAVA:TriggerInput("Set",0)
            ent.Plombs.VU = nil
            ent.Plombs.UAVA = true
        end
    end,
    Metrostroi.Skins.GetTable("Texture","Texture",Texture,"train"),
    Metrostroi.Skins.GetTable("PassTexture","PassTexture",PassTexture,"pass"),
    Metrostroi.Skins.GetTable("CabTexture","CabTexture",CabTexture,"cab"),
    {"Announcer","Announcer","List",Announcer},
    {"HornType","Piter horn","Boolean"},
    {"NM","NM","Slider",1,0,9.0,8.2,function(ent,val) ent.Pneumatic.TrainLinePressure = val end},
    {"Battery","Battery","Boolean",true,function(ent,val) ent.VB:TriggerInput("Set",val) end},
    {"AV8B","AV8B","Boolean",true,function(ent,val) ent.AV8B:TriggerInput("Set",val) end},
    {"DoorsL","DoorsL","Boolean",false, function(ent,val,rot)
            if rot then
                ent.Pneumatic.RightDoorState = val  and {1,1,1,1} or {0,0,0,0}
            else
                ent.Pneumatic.LeftDoorState = val  and {1,1,1,1} or {0,0,0,0}
            end
    end},
    {"DoorsR","DoorsR","Boolean",false, function(ent,val,rot)
            if rot then
                ent.Pneumatic.LeftDoorState = val  and {1,1,1,1} or {0,0,0,0}
            else
                ent.Pneumatic.RightDoorState = val  and {1,1,1,1} or {0,0,0,0}
            end
    end},
    {"GV","GV","Boolean",true,function(ent,val) ent.GV:TriggerInput("Set",val) end},
}

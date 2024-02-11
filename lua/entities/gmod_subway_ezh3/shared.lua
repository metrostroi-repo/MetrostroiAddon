ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.PrintName       = "Ezh-3 (81-710)"
ENT.Author          = "oldy, glebqip"
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "Metrostroi (trains)"
ENT.SkinsType = "81-710"
ENT.Model = "models/metrostroi_train/81-710/81-710.mdl"

ENT.Spawnable       = true
ENT.AdminSpawnable  = false
ENT.DontAccelerateSimulation = false

function ENT:PassengerCapacity()
    return 300
end

function ENT:GetStandingArea()
    return Vector(-450,-30,-55),Vector(380,30,-55)
end

local function GetDoorPosition(i,k)
    return Vector(359.0 - 35/2 - 229.5*i,-65*(1-2*k),7.5)
end

ENT.MirrorCams = {
    Vector(441,72,15),Angle(1,180,0),15,
    Vector(441,-72,15),Angle(1,180,0),15,
}

ENT.AnnouncerPositions = {
    {Vector(420,-38.2 ,40),80,0.4},
    {Vector(-3,-60, 62),300,0.3},
    {Vector(-3,60 ,62),300,0.3},
}

ENT.Cameras = {
    {Vector(407.5+43,-4,-6),Angle(0,-40,0),"Common.ALL.VU"},
    {Vector(407.5+18,32,21),Angle(0,180,0),"Train.703.Breakers1"},
    {Vector(407.5+18,50,24),Angle(5,180,0),"Train.703.Breakers2"},
    {Vector(407.5+18,-52.5,10),Angle(10,180,0),"Train.703.RCARS"},
    {Vector(407.5+34,48,16),Angle(0,37,0),"Train.Common.HelpersPanel"},
    {Vector(407.5+30,40,5) ,Angle(30,10,0),"Train.703.Parking"},
    {Vector(407.5+45,-52.4,4),Angle(0,-40,0),"Train.Common.ASNP","ASNP"},
    {Vector(407.5+45,-50.3,12),Angle(0,-40,0),"Train.Common.IGLA","IGLAButtons"},
    {Vector(407.5+10,-24,-3-4),Angle(35,180,0),"Train.Common.RRI","RRI"},
    {Vector(407.5+68,40,2)  ,Angle(20,180,0),"Train.Common.RouteNumber"},
    {Vector(407.5+80,0,6)   ,Angle(20,180,0),"Train.Common.LastStation"},
    {Vector(450+13,0,26),Angle(60,0,0),"Train.Common.CouplerCamera"},
}

-- Setup door positions
ENT.LeftDoorPositions = {}
ENT.RightDoorPositions = {}
for i=0,3 do
    table.insert(ENT.LeftDoorPositions,GetDoorPosition(i,1))
    table.insert(ENT.RightDoorPositions,GetDoorPosition(i,0))
end

function ENT:InitializeSounds()
     self.BaseClass.InitializeSounds(self)
    self.SoundNames["rolling_5"] = {loop=true,"subway_trains/common/junk/junk_background3.wav"}
    self.SoundNames["rolling_10"] = {loop=true,"subway_trains/717/rolling/10_rolling.wav"}
    self.SoundNames["rolling_40"] = {loop=true,"subway_trains/717/rolling/40_rolling.wav"}
    self.SoundNames["rolling_70"] = {loop=true,"subway_trains/717/rolling/70_rolling.wav"}
    self.SoundNames["rolling_80"] = {loop=true,"subway_trains/717/rolling/80_rolling.wav"}
    self.SoundPositions["rolling_5"] = {480,1e12,Vector(0,0,0),0.10}
    self.SoundPositions["rolling_10"] = {480,1e12,Vector(0,0,0),0.17}
    self.SoundPositions["rolling_40"] = {480,1e12,Vector(0,0,0),0.40}
    self.SoundPositions["rolling_70"] = {480,1e12,Vector(0,0,0),0.46}
    self.SoundPositions["rolling_80"] = {480,1e12,Vector(0,0,0),0.60}

    self.SoundNames["rolling_motors"] = {loop=true,"subway_trains/ezh/rolling/rolling_motors.wav"}
    self.SoundPositions["rolling_motors"] = {480,1e12,Vector(0,0,0),.4}

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
    self.SoundNames["rvt_on"] = "subway_trains/717/relays/new/rvt_on1.mp3"
    self.SoundNames["rvt_off"] = "subway_trains/717/relays/new/rvt_off3.mp3"
    self.SoundPositions["rvt_on"] = {100,1e9,Vector(400,25,-35),1}
    self.SoundPositions["rvt_off"] = {100,1e9,Vector(400,25,-35),1}
    --self.SoundNames["r1_5_on"] = "subway_trains/717/relays/new/k6_on1.mp3"
    self.SoundNames["r1_5_on"] = "subway_trains/ezh3/relays/r1_5_on.mp3"
    self.SoundNames["r1_5_off"] =  "subway_trains/717/relays/new/r1_5_off.mp3"
    self.SoundPositions["r1_5_on"] = {100,1e9,Vector(400,25,-35),1}
    self.SoundPositions["r1_5_off"] = {100,1e9,Vector(400,25,-35),1}

    self.SoundNames["kd_off"] = "subway_trains/717/relays/lsd_2.mp3"
    self.SoundNames["kd_on"] = "subway_trains/717/relays/new/kd_on.mp3"
    self.SoundPositions["kd_on"] = {100,1e9,Vector(400,25,-35),1}
    self.SoundPositions["kd_off"] = {100,1e9,Vector(400,25,-35),1}

    self.SoundNames["k25_on"] = "subway_trains/717/relays/new/k6_on1.mp3"
    --self.SoundNames["k25_off"] = "subway_trains/717/relays/new/r1_5_off.mp3"
    self.SoundNames["k25_off"] = "subway_trains/ezh3/relays/ro_on.mp3"
    self.SoundPositions["k25_on"] = {120,1e9,Vector(400,25,-35),1}
    self.SoundPositions["k25_off"] = {120,1e9,Vector(400,25,-35),1}
    self.SoundNames["ro_on"] = "subway_trains/717/relays/ro_on.mp3"
    self.SoundNames["ro_off"] = "subway_trains/717/relays/new/ro_off.mp3"
    self.SoundPositions["ro_on"] = {140,1e9,Vector(400,-40,55),1}
    self.SoundPositions["ro_off"] = {140,1e9,Vector(400,-40,55),1}

    self.SoundNames["avu_off"] = "subway_trains/common/pneumatic/ak11b_off.mp3"
    self.SoundNames["avu_on"] = "subway_trains/common/pneumatic/ak11b_on.mp3"
    self.SoundPositions["avu_on"] = {60,1e9, Vector(449+7.7,56.0,-10.24349),0.7}
    self.SoundPositions["avu_off"] = self.SoundPositions["avu_on"]
    --Подвагонка
    self.SoundNames["lk2_on"] = "subway_trains/717/pneumo/lk2_on.mp3"
    self.SoundNames["lk2_off"] = "subway_trains/717/pneumo/lk2_off.mp3"
    self.SoundNames["lk5_on"] = "subway_trains/717/pneumo/lk1_on.mp3"
    self.SoundNames["lk5_off"] = "subway_trains/717/pneumo/lk2_off.mp3"
    self.SoundNames["lk3_on"] = "subway_trains/717/pneumo/lk3_on.mp3"
    self.SoundNames["lk3_off"] = "subway_trains/717/pneumo/lk3_off.mp3"
    self.SoundPositions["lk2_on"] = {440,1e9,Vector(-60,-40,-66),0.22}
    self.SoundPositions["lk2_off"] = self.SoundPositions["lk2_on"]
    self.SoundPositions["lk5_on"] = {440,1e9,Vector(-60,-40,-66),0.30}
    self.SoundPositions["lk5_off"] = self.SoundPositions["lk2_off"]
    self.SoundPositions["lk3_on"] = self.SoundPositions["lk2_on"]
    self.SoundPositions["lk3_off"] = self.SoundPositions["lk2_off"]

    self.SoundNames["compressor"] = {loop=1.79,"subway_trains/ezh/compressor/ezh_compressor_start.wav","subway_trains/ezh/compressor/ezh_compressor_loop.wav", "subway_trains/ezh/compressor/ezh_compressor_end.wav"}
    self.SoundPositions["compressor"] = {485,1e9,Vector(-118,-40,-66),0.55}
    self.SoundNames["compressor_reflection"] = {"subway_trains/common/junk/junk_background2.wav"}
    self.SoundPositions["compressor_reflection"] = {150,1e9,Vector(300,0,0)}
    self.SoundPositions["compressor_reflection"] = {150,1e9,Vector(-300,0,0)}
    self.SoundNames["rk"] = {"subway_trains/ezh/rk/rk_start.wav","subway_trains/ezh/rk/rk_spin.wav","subway_trains/ezh/rk/rk_stop.wav"}
    self.SoundPositions["rk"] = {50,1e9,Vector(110,-40,-75),0.22}

    self.SoundNames["ezh3_revers_0-f"] = {"subway_trains/717/kv70/reverser_0-f_1.mp3","subway_trains/717/kv70/reverser_0-f_2.mp3"}
    self.SoundNames["ezh3_revers_f-0"] = {"subway_trains/717/kv70/reverser_f-0_1.mp3","subway_trains/717/kv70/reverser_f-0_2.mp3"}
    self.SoundNames["ezh3_revers_0-b"] = {"subway_trains/717/kv70/reverser_0-b_1.mp3","subway_trains/717/kv70/reverser_0-b_2.mp3"}
    self.SoundNames["ezh3_revers_b-0"] = {"subway_trains/717/kv70/reverser_b-0_1.mp3","subway_trains/717/kv70/reverser_b-0_2.mp3"}
    self.SoundNames["revers_in"] = {"subway_trains/ezh3/kv66/revers_in.mp3"}
    self.SoundNames["revers_out"] = {"subway_trains/ezh3/kv66/revers_out.mp3"}
    self.SoundNames["rcu_in"] = {"subway_trains/ezh3/kv66/revers_in.mp3"}
    self.SoundNames["rcu_out"] = {"subway_trains/ezh3/kv66/revers_out.mp3"}
    self.SoundNames["rcu_on"] = {"subway_trains/ezh3/kv66/rcu_on.mp3","subway_trains/ezh3/kv66/rcu_on2.mp3"}
    self.SoundNames["rcu_off"] = "subway_trains/ezh3/kv66/rcu_off.mp3"
    self.SoundPositions["ezh3_revers_0-f"] = {80,1e9,Vector(453,-21.00,-16.0)}
    self.SoundPositions["ezh3_revers_f-0"] = {80,1e9,Vector(453,-21.00,-16.0)}
    self.SoundPositions["ezh3_revers_0-b"] = {80,1e9,Vector(453,-21.00,-16.0)}
    self.SoundPositions["ezh3_revers_b-0"] = {80,1e9,Vector(453,-21.00,-16.0)}
    self.SoundPositions["revers_in"] = {80,1e9,Vector(453,-21.00,-16.0)}
    self.SoundPositions["revers_out"] = {80,1e9,Vector(453,-21.00,-16.0)}
    self.SoundPositions["rcu_on"] = self.SoundPositions["ezh3_revers_0-f"]
    self.SoundPositions["rcu_off"] = self.SoundPositions["rcu_on"]
    self.SoundPositions["rcu_in"] = self.SoundPositions["rcu_on"]
    self.SoundPositions["rcu_out"] = self.SoundPositions["rcu_on"]

    self.SoundNames["kru_in"] = {
        "subway_trains/717/kru/kru_insert1.mp3",
        "subway_trains/717/kru/kru_insert2.mp3"
    }
    self.SoundNames["kru_out"] = {
        "subway_trains/717/kru/kru_eject1.mp3",
        "subway_trains/717/kru/kru_eject2.mp3",
        "subway_trains/717/kru/kru_eject3.mp3",
    }
    self.SoundPositions["kru_in"] = {80,1e9,Vector(404.8,-23.5,-2.2)}
    self.SoundPositions["kru_out"] = self.SoundPositions["kru_in"]

    self.SoundNames["kru_0_1"] = {
        "subway_trains/717/kru/kru0-1_1.mp3",
        "subway_trains/717/kru/kru0-1_2.mp3",
        "subway_trains/717/kru/kru0-1_3.mp3",
        "subway_trains/717/kru/kru0-1_4.mp3",
    }
    self.SoundNames["kru_1_2"] = {
        "subway_trains/717/kru/kru0-1_1.mp3",
        "subway_trains/717/kru/kru0-1_2.mp3",
        "subway_trains/717/kru/kru0-1_3.mp3",
        "subway_trains/717/kru/kru0-1_4.mp3",
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
        "subway_trains/717/kru/kru1-2_1.mp3",
        "subway_trains/717/kru/kru1-2_2.mp3",
        "subway_trains/717/kru/kru1-2_3.mp3",
        "subway_trains/717/kru/kru1-2_4.mp3",
    }
    self.SoundNames["kru_3_2"] = {
        "subway_trains/717/kru/kru2-1_1.mp3",
        "subway_trains/717/kru/kru2-1_2.mp3",
        "subway_trains/717/kru/kru2-1_3.mp3",
        "subway_trains/717/kru/kru2-1_4.mp3",
    }
    self.SoundPositions["kru_0_1"] = self.SoundPositions["kru_in"]
    self.SoundPositions["kru_1_2"] = self.SoundPositions["kru_in"]
    self.SoundPositions["kru_2_1"] = self.SoundPositions["kru_in"]
    self.SoundPositions["kru_1_0"] = self.SoundPositions["kru_in"]
    self.SoundPositions["kru_2_3"] = self.SoundPositions["kru_in"]
    self.SoundPositions["kru_3_2"] = self.SoundPositions["kru_in"]

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
    self.SoundNames["gv_f"] = self.SoundNames["ezh3_revers_0-b"]
    self.SoundNames["gv_b"] = self.SoundNames["ezh3_revers_b-0"]
    self.SoundPositions["gv_f"]     = {80,1e2,Vector(120,62.0+0.0,-60),0.5}
    self.SoundPositions["gv_b"]     = self.SoundPositions["gv_f"]
     
    self.SoundNames["fuseh_in"] = {
        "subway_trains/710/fuseh_in_1.mp3",
        "subway_trains/710/fuseh_in_2.mp3",
        "subway_trains/710/fuseh_in_3.mp3",
    }
    self.SoundPositions["fuseh_in"] = {80,1e2,Vector(449+7,56.0,-10.24349),0.6}
    
     self.SoundNames["fuseh_out"] = {
        "subway_trains/710/fuseh_out_1.mp3",
        "subway_trains/710/fuseh_out_2.mp3",
        "subway_trains/710/fuseh_out_3.mp3",
    }
    self.SoundPositions["fuseh_in"] = {80,1e2,Vector(449+7.7,56.0,-10.24349),0.6}

    self.SoundNames["fusecap_open"] = {
        "subway_trains/710/fusecap_open_1.mp3",
        "subway_trains/710/fusecap_open_2.mp3",
    }
    self.SoundPositions["fusecap_open"] = {80,1e2,Vector(449+7,56.0,-10.24349),0.6}
    
     self.SoundNames["fusecap_close"] = {
        "subway_trains/710/fusecap_close_1.mp3",
        "subway_trains/710/fusecap_close_2.mp3",
    }
    self.SoundPositions["fusecap_close"] = {80,1e2,Vector(449+7.7,56.0,-10.24349),0.6}
    
     self.SoundNames["fusebox_open"] = {
        "subway_trains/710/fusebox_open_1.mp3",
        "subway_trains/710/fusebox_open_2.mp3",
    }
    self.SoundPositions["fusebox_open"] = {80,1e2,Vector(449+7,56.0,-10.24349),0.6}
    
     self.SoundNames["fusebox_close"] = {
        "subway_trains/710/fusebox_close_1.mp3",
        "subway_trains/710/fusebox_close_2.mp3",
    }
    self.SoundPositions["fusebox_close"] = {80,1e2,Vector(449+7.7,56.0,-10.24349),0.6}


    --Краны
    self.SoundNames["brake_f"] = {"subway_trains/common/pneumatic/vz_brake_on2.mp3","subway_trains/common/pneumatic/vz_brake_on3.mp3","subway_trains/common/pneumatic/vz_brake_on4.mp3"}
    self.SoundPositions["brake_f"] = {50,1e9,Vector(317-8,0,-82),0.13}
    self.SoundNames["brake_b"] = self.SoundNames["brake_f"]
    self.SoundPositions["brake_b"] = {50,1e9,Vector(-317+0,0,-82),0.13}
    self.SoundNames["release1"] = {loop=true,"subway_trains/common/pneumatic/release_0.wav"}
    self.SoundPositions["release1"] = {350,1e9,Vector(-183,0,-70),1}
    self.SoundNames["release2"] = {loop=true,"subway_trains/common/pneumatic/release_low.wav"}
    self.SoundPositions["release2"] = {350,1e9,Vector(-183,0,-70),0.4}

    self.SoundNames["front_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["front_isolation"] = {300,1e9,Vector(452, 0,-63),1}
    self.SoundNames["rear_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["rear_isolation"] = {300,1e9,Vector(-456, 0,-63),1}

    self.SoundNames["crane013_brake2"] = {loop=true,"subway_trains/common/pneumatic/013_brake2.wav"}
    self.SoundPositions["crane013_brake2"] = {80,1e9,Vector(452.22,-56.5,-38.0),0.86}
    self.SoundNames["crane334_brake_high"] = {loop=true,"subway_trains/common/pneumatic/334_brake.wav"}
    self.SoundPositions["crane334_brake_high"] = {80,1e9,Vector(452.22,-56.5,-38.0),0.85}
    self.SoundNames["crane334_brake_low"] = {loop=true,"subway_trains/common/pneumatic/334_brake_slow.wav"}
    self.SoundPositions["crane334_brake_low"] = {80,1e9,Vector(452.22,-56.5,-38.0),0.75}
    self.SoundNames["crane334_brake_2"] = {loop=true,"subway_trains/common/pneumatic/334_brake_slow.wav"}
    self.SoundPositions["crane334_brake_2"] = {80,1e9,Vector(452.22,-56.5,-38.0),0.85}
    self.SoundNames["crane334_brake_eq_high"] = {loop=true,"subway_trains/common/pneumatic/334_release_reservuar.wav"}
    self.SoundPositions["crane334_brake_eq_high"] = {80,1e9,Vector(452.22,-56.5,-70),0.45}
    self.SoundNames["crane334_brake_eq_low"] = {loop=true,"subway_trains/common/pneumatic/334_brake_slow2.wav"}
    self.SoundPositions["crane334_brake_eq_low"] = {80,1e9,Vector(452.22,-56.5,-70),0.45}
    self.SoundNames["crane334_release"] = {loop=true,"subway_trains/common/pneumatic/334_release3.wav"}
    self.SoundPositions["crane334_release"] = {80,1e9,Vector(452.22,-56.5,-38.0),0.2}
    self.SoundNames["crane334_release_2"] = {loop=true,"subway_trains/common/pneumatic/334_release2.wav"}
    self.SoundPositions["crane334_release_2"] = {80,1e9,Vector(452.22,-56.5,-38.0),0.2}

    self.SoundNames["valve_brake"] = {loop=true,"subway_trains/common/pneumatic/epv_loop.wav"}
    self.SoundPositions["valve_brake"] = {400,1e9,Vector(464.40,24.4,-50),1}

    --self.SoundNames["emer_brake"] = {loop=0.8,"subway_trains/common/pneumatic/autostop_start.wav","subway_trains/common/pneumatic/autostop_loop.wav", "subway_trains/common/pneumatic/autostop_end.wav"}
    self.SoundNames["emer_brake"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop.wav"}
    self.SoundNames["emer_brake2"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop_2.wav"}
    self.SoundPositions["emer_brake"] = {600,1e9,Vector(380,-65,-75)}
    self.SoundPositions["emer_brake2"] = self.SoundPositions["emer_brake"]

    self.SoundNames["epk_brake"] = {loop=true,"subway_trains/common/pneumatic/epv_loop.wav"}
    self.SoundPositions["epk_brake"] = {80,1e9,Vector(437.2,-63.1,-50.0),0.65}


    self.SoundNames["pak_on"] = "subway_trains/717/switches/rc_on.mp3"
    self.SoundNames["pak_off"] = "subway_trains/717/switches/rc_off.mp3"

    self.SoundNames["kv70_fix_on"] = {"subway_trains/717/kv70/kv70_fix_on1.mp3","subway_trains/717/kv70/kv70_fix_on2.mp3"}
    self.SoundNames["kv70_fix_off"] = {"subway_trains/717/kv70/kv70_fix_off1.mp3","subway_trains/717/kv70/kv70_fix_off2.mp3"}
    self.SoundNames["kv66_0_t1"] = {"subway_trains/ezh3/kv66/ezh3_0_T1.mp3"}
    self.SoundNames["kv66_t1_0"] = {"subway_trains/ezh3/kv66/ezh3_T1_0.mp3"}
    self.SoundNames["kv66_t1_t1a"] = {"subway_trains/ezh3/kv66/ezh3_T1_T1A.mp3"}
    self.SoundNames["kv66_t1a_t1"] = {"subway_trains/ezh3/kv66/ezh3_T1A_T1.mp3"}
    self.SoundNames["kv66_t1a_t2"] = {"subway_trains/ezh3/kv66/ezh3_T1A_T2.mp3"}
    self.SoundNames["kv66_t2_t1a"] = {"subway_trains/ezh3/kv66/ezh3_T2_T1A.mp3"}
    self.SoundNames["kv66_0_x1"] = {"subway_trains/ezh3/kv66/ezh3_0_X1.mp3"}
    self.SoundNames["kv66_x1_0"] = {"subway_trains/ezh3/kv66/ezh3_X1_0.mp3"}
    self.SoundNames["kv66_x1_x2"] = {"subway_trains/ezh3/kv66/ezh3_X1_X2.mp3"}
    self.SoundNames["kv66_x2_x1"] = {"subway_trains/ezh3/kv66/ezh3_X2_X1.mp3"}
    self.SoundNames["kv66_x2_x3"] = {"subway_trains/ezh3/kv66/ezh3_X2_X3.mp3"}
    self.SoundNames["kv66_x3_x2"] = {"subway_trains/ezh3/kv66/ezh3_X3_X2.mp3"}
    self.SoundPositions["kv70_fix_on"] =    {100,1e9,Vector(453.36,-26.45,-17),0.67}
    self.SoundPositions["kv70_fix_off"] =   {100,1e9,Vector(453.36,-26.45,-17),0.67}
    self.SoundPositions["kv66_0_t1"] =      {100,1e9,Vector(453.36,-26.45,-17),0.67}
    self.SoundPositions["kv66_t1_0_fix"] =  {100,1e9,Vector(453.36,-26.45,-17),0.67}
    self.SoundPositions["kv66_t1_0"] =      {100,1e9,Vector(453.36,-26.45,-17),0.67}
    self.SoundPositions["kv66_t1_t1a"] =    {100,1e9,Vector(453.36,-26.45,-17),0.67}
    self.SoundPositions["kv66_t1a_t1"] =    {100,1e9,Vector(453.36,-26.45,-17),0.67}
    self.SoundPositions["kv66_t1a_t2"] =    {100,1e9,Vector(453.36,-26.45,-17),0.67}
    self.SoundPositions["kv66_t2_t1a"] =    {100,1e9,Vector(453.36,-26.45,-17),0.67}
    self.SoundPositions["kv66_0_x1"] =      {100,1e9,Vector(453.36,-26.45,-17),0.67}
    self.SoundPositions["kv66_x1_0"] =      {100,1e9,Vector(453.36,-26.45,-17),0.67}
    self.SoundPositions["kv66_x1_x2"] =     {100,1e9,Vector(453.36,-26.45,-17),0.67}
    self.SoundPositions["kv66_x2_x1"] =     {100,1e9,Vector(453.36,-26.45,-17),0.67}
    self.SoundPositions["kv66_x2_x3"] =     {100,1e9,Vector(453.36,-26.45,-17),0.67}
    self.SoundPositions["kv66_x3_x2"] =     {100,1e9,Vector(453.36,-26.45,-17),0.67}


    self.SoundNames["samm_revers_in"] = {"subway_trains/ezh3/rc_ars/reversor_rc_in.mp3"}
    self.SoundNames["samm_revers_out"] = {"subway_trains/ezh3/rc_ars/reversor_rc_in.mp3"}
    self.SoundNames["samm_0-1"] = {"subway_trains/ezh3/rc_ars/0-1.mp3"}
    self.SoundNames["samm_0-2"] = {"subway_trains/ezh3/rc_ars/0-2.mp3"}
    self.SoundNames["samm_2-0"] = {"subway_trains/ezh3/rc_ars/2-0.mp3"}
    self.SoundPositions["samm_0-2"] = {60,1e9,Vector(442.2-6,-50,-10)}
    self.SoundPositions["samm_2-0"] = {60,1e9,Vector(442.2-6,-50,-10)}
    self.SoundPositions["samm_0-1"] = {60,1e9,Vector(442.2-6,-50,-10)}
    self.SoundPositions["samm_revers_out"] = {60,1e9,Vector(442.2-6,-50,-10)}
    self.SoundPositions["samm_revers_in"] = {60,1e9,Vector(442.2-6,-50,-10)}

    self.SoundNames["ring"] = {loop=0.15,"subway_trains/717/ring/ringo_start.wav","subway_trains/717/ring/ringo_loop.wav","subway_trains/717/ring/ringo_end.mp3"}--{loop=0.15,"subway_trains/717/ring/ring_start.wav","subway_trains/717/ring/ring_loop.wav","subway_trains/717/ring/ring_end.wav"}
    self.SoundPositions["ring"] = {60,1e9,Vector(400,-30,55),0.5}--{100,1e9,Vector(445,-55,-15),0.2}

    self.SoundNames["vpr"] = {loop=0.8,"subway_trains/common/other/radio/vpr_start.wav","subway_trains/common/other/radio/vpr_loop.wav","subway_trains/common/other/radio/vpr_off.wav"}
    self.SoundPositions["vpr"] = {60,1e9,Vector(420,-38.2 ,40),0.05}

    self.SoundNames["cab_door_open"] = "subway_trains/common/door/cab/door_open.mp3"
    self.SoundNames["cab_door_close"] = "subway_trains/common/door/cab/door_close.mp3"

    self.SoundNames["parking_brake_rolling"] = {"subway_trains/ezh3/parking_brake_rolling1.mp3","subway_trains/ezh3/parking_brake_rolling2.mp3","subway_trains/ezh3/parking_brake_rolling3.mp3","subway_trains/ezh3/parking_brake_rolling4.mp3"}
    self.SoundPositions["parking_brake_rolling"] = {65,1e9,Vector(449.118378+7.6,33.493385,-14.713276),0.1}
    self.SoundNames["av8_on"] = {"subway_trains/common/switches/av8/av8_on.mp3","subway_trains/common/switches/av8/av8_on2.mp3"}
    self.SoundNames["av8_off"] = {"subway_trains/common/switches/av8/av8_off.mp3","subway_trains/common/switches/av8/av8_off2.mp3"}
    self.SoundPositions["av8_on"] = {100,1e9,Vector(405,40,30)}
    self.SoundPositions["av8_off"] = {100,1e9,Vector(405,40,30)}

    self.SoundNames["vu22_on"] = {"subway_trains/ezh3/vu/vu22_on1.mp3", "subway_trains/ezh3/vu/vu22_on2.mp3", "subway_trains/ezh3/vu/vu22_on3.mp3"}
    self.SoundNames["vu22_off"] = {"subway_trains/ezh3/vu/vu22_off1.mp3", "subway_trains/ezh3/vu/vu22_off2.mp3", "subway_trains/ezh3/vu/vu22_off3.mp3"}
    self.SoundNames["vu223_on"] = {"subway_trains/common/switches/vu22/vu22_3_on.mp3"}
    self.SoundNames["vu223_off"] = {"subway_trains/common/switches/vu22/vu22_3_off.mp3"}

    self.SoundNames["pneumo_TL_open"] = {
        "subway_trains/common/334/334_open.mp3",
    }
    self.SoundNames["pneumo_TL_disconnect"] = {
        "subway_trains/common/334/334_close.mp3",
    }
    self.SoundNames["pneumo_BL_disconnect"] = {
        "subway_trains/common/334/334_close.mp3",
    }
        self.SoundNames["disconnect_valve"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"

    self.SoundNames["pneumo_idle"] = {
        "subway_trains/ezh3/pneumatic/idle.wav",
    }
    self.SoundPositions["pneumo_idle"] = {150,1e9,Vector(438.50,-50,-40),1}

    self.SoundNames["igla_on"]  = "subway_trains/common/other/igla/igla_on1.mp3"
    self.SoundNames["igla_off"] = "subway_trains/common/other/igla/igla_off2.mp3"
    self.SoundNames["igla_start1"]  = "subway_trains/common/other/igla/igla2_start1.mp3"
    self.SoundNames["igla_start2"]  = "subway_trains/common/other/igla/igla2_start2.mp3"
    self.SoundPositions["igla_on"] = {50,1e9,Vector(460.5,-54.3,12.67),0.3}
    self.SoundPositions["igla_off"] = {50,1e9,Vector(460.5,-54.3,12.67),0.3}
    self.SoundPositions["igla_start1"] = {50,1e9,Vector(460.5,-54.3,12.67),0.3}
    self.SoundPositions["igla_start2"] = {50,1e9,Vector(460.5,-54.3,12.67),0.2}

    self.SoundNames["upps"]         = {"subway_trains/common/other/upps/upps1.mp3","subway_trains/common/other/upps/upps2.mp3"}
    self.SoundPositions["upps"] = {60,1e9,Vector(443,-64,4),0.5}

    self.SoundNames["pnm_on"]           = {"subway_trains/common/pnm/pnm_switch_on.mp3","subway_trains/common/pnm/pnm_switch_on2.mp3"}
    self.SoundNames["pnm_off"]          = "subway_trains/common/pnm/pnm_switch_off.mp3"
    self.SoundNames["pnm_button1_on"]           = {
        "subway_trains/common/pnm/pnm_button_push.mp3",
        "subway_trains/common/pnm/pnm_button_push2.mp3",
    }

    self.SoundNames["pnm_button2_on"]           = {
        "subway_trains/common/pnm/pnm_button_push3.mp3",
        "subway_trains/common/pnm/pnm_button_push4.mp3",
    }

    self.SoundNames["pnm_button1_off"]          = {
        "subway_trains/common/pnm/pnm_button_release.mp3",
        "subway_trains/common/pnm/pnm_button_release2.mp3",
        "subway_trains/common/pnm/pnm_button_release3.mp3",
    }

    self.SoundNames["pnm_button2_off"]          = {
        "subway_trains/common/pnm/pnm_button_release4.mp3",
        "subway_trains/common/pnm/pnm_button_release5.mp3",
    }

    self.SoundNames["horn"] = {loop=0.6,"subway_trains/common/pneumatic/horn/horn3_start.wav","subway_trains/common/pneumatic/horn/horn3_loop.wav", "subway_trains/common/pneumatic/horn/horn3_end.wav"}
    self.SoundPositions["horn"] = {1100,1e9,Vector(450,-20,-55)}

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
    self.SoundPositions["vdol_off"] = {100,1e9,Vector(410,20,-45)}
    self.SoundNames["vdor_on"] = self.SoundNames["vdol_on"]
    self.SoundNames["vdor_off"] = self.SoundNames["vdol_off"]
    self.SoundPositions["vdor_on"] = self.SoundPositions["vdol_on"]
    self.SoundPositions["vdor_off"] = self.SoundPositions["vdol_off"]
    for i=1,5 do
        self.SoundNames["vdol_loud"..i] = "subway_trains/common/pneumatic/door_valve/vdo"..(2+i).."_on.mp3"
        self.SoundNames["vdop_loud"..i] = self.SoundNames["vdol_loud"..i]
        self.SoundNames["vzd_loud"..i] = self.SoundNames["vdol_loud"..i]
        self.SoundPositions["vdol_loud"..i] = {100,1e9,Vector(410,20,-45),1}
        self.SoundPositions["vdop_loud"..i] = self.SoundPositions["vdol_loud"..i]
        self.SoundPositions["vzd_loud"..i] = self.SoundPositions["vdol_loud"..i]
    end
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

    self.SoundNames["kk_off"] = "subway_trains/common/pneumatic/ak11b_off2.mp3"
    self.SoundNames["kk_on"] = "subway_trains/common/pneumatic/ak11b_on2.mp3"
    self.SoundPositions["kk_on"] = {100,1e9,Vector(407,-55,-5),0.3}
    self.SoundPositions["kk_off"] = {100,1e9,Vector(407,-55,-5),0.3}

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
    self.SoundNames["PN2end"] = {"subway_trains/common/pneumatic/vz2_end.mp3","subway_trains/common/pneumatic/vz2_end_2.mp3","subway_trains/common/pneumatic/vz2_end_3.mp3","subway_trains/common/pneumatic/vz2_end_4.mp3"}
    self.SoundPositions["PN2end"] = {350,1e9,Vector(-183,0,-70),0.3}

    self.SoundNames["rt300"] = {loop=true,"subway_trains/ezh3/rt300a_idle.wav"}
    self.SoundPositions["rt300"] = {60,1e9,Vector(414.5,-17,47),0.01}

    for k,v in ipairs(self.AnnouncerPositions) do
        self.SoundNames["announcer_noise1_"..k] = {loop=true,"subway_announcers/upo/noiseS1.wav"}
        self.SoundPositions["announcer_noise1_"..k] = {v[2] or 300,1e9,v[1],v[3]*0.5}
        self.SoundNames["announcer_noise2_"..k] = {loop=true,"subway_announcers/upo/noiseS2.wav"}
        self.SoundPositions["announcer_noise2_"..k] = {v[2] or 300,1e9,v[1],v[3]*0.5}
    end
end

function ENT:InitializeSystems()
    -- Электросистема Е (АРС)
    self:LoadSystem("Electric","81_710_Electric")

    -- Токоприёмник
    self:LoadSystem("TR","TR_3B")
    -- Электротяговые двигатели
    self:LoadSystem("Engines","DK_116A")

    -- Резисторы для реостата/пусковых сопротивлений
    self:LoadSystem("KF_47A")
    -- Резисторы для ослабления возбуждения
    self:LoadSystem("KF_50A")
    -- Ящик с предохранителями
    self:LoadSystem("YAP_57")

    -- Резисторы для цепей управления
    --self:LoadSystem("YAS_44V")
    self:LoadSystem("Reverser","PR_722D")
    -- Реостатный контроллер для управления пусковыми сопротивления
    self:LoadSystem("RheostatController","EKG_17B")
    -- Групповой переключатель положений
    self:LoadSystem("PositionSwitch","EKG_18B")
    -- Кулачковый контроллер
    self:LoadSystem("KV","KV_66")
    ---- Контроллер резервного управления (KRP)
    self:LoadSystem("KRU")


    -- Ящики с реле и контакторами
    self:LoadSystem("LK_755A")
    self:LoadSystem("YAR_15A")
    self:LoadSystem("YAR_27")
    self:LoadSystem("YAK_37A")
    self:LoadSystem("YAK_36")
    self:LoadSystem("YAS_44V")
    self:LoadSystem("YARD_2")
    self:LoadSystem("PR_124B")

    -- Пневмосистема 81-703
    self:LoadSystem("Pneumatic","81_703_Pneumatic")
    -- Панель управления Еж3
    self:LoadSystem("Panel","81_710_Panel")
    -- Everything else
    self:LoadSystem("Battery")
    self:LoadSystem("Horn")

    self:LoadSystem("Announcer","81_71_Announcer", "AnnouncementsASNP")
    self:LoadSystem("ASNP","81_71_ASNP")
    self:LoadSystem("ASNP_VV","81_71_ASNP_VV")
    self:LoadSystem("RRI","81_71_RRI")
    self:LoadSystem("RRI_VV","81_71_RRI_VV")

    self:LoadSystem("ALS_ARS","ALS_ARS_Ezh3")
    --self:LoadSystem("ALSCoil")

    self:LoadSystem("IGLA_CBKI","IGLA_CBKI2")

    self:LoadSystem("RouteNumber","81_71_RouteNumber",2)
    self:LoadSystem("LastStation","81_71_LastStation","710","door1")
    self:LoadSystem("IGLA_PCBK")
end
function ENT:PostInitializeSystems()
    self.Electric:TriggerInput("RRI",1)
    self.YAR_27:TriggerInput("NoRKTT",1)
    self.YAR_15A:TriggerInput("WithFuse",1)
    self.Pneumatic:TriggerInput("PowerWithFuse",1)
end

ENT.SubwayTrain = {
    Type = "E",
    Name = "Ezh3",
    WagType = 0,
    ALS = {
        HaveAutostop = true,
        TwoToSix = false,
        RSAs325Hz = false,
        Aproove0As325Hz = false,
    },
    EKKType = 710,
}
ENT.NumberRanges = {{5561,5999},{9000,9049}}

ENT.Spawner = {
    model = {
        "models/metrostroi_train/81-710/81-710.mdl",
        {"models/metrostroi_train/81-710/ezh3_salon.mdl",pos = Vector(0,0,0)},
        {"models/metrostroi_train/81-710/ezh3_cabine.mdl",pos = Vector(0,0,0)},
        {"models/metrostroi_train/81-703/81-703_Underwagon.mdl",pos = Vector(-23.5,0,-191)},
    },
    interim = "gmod_subway_em508t",
    func = function(ent,i,maxi)
        if ent:GetClass() == "gmod_subway_ezh3" then
            ent.VU:TriggerInput("Set",1)
            ent.UAVA:TriggerInput("Set",0)
            ent.Plombs.VU = nil
            ent.Plombs.UAVA = true
        else
            ent.VU:TriggerInput("Set",0)
            ent.UAVA:TriggerInput("Set",1)
            ent.Plombs.VU = true
            ent.Plombs.UAVA = nil
               ent.PRL26:TriggerInput("Set",0)
               ent.PRL12:TriggerInput("Set",0)
        end
    end,
    Metrostroi.Skins.GetTable("Texture","Texture",false,"train"),
    Metrostroi.Skins.GetTable("PassTexture","PassTexture",false,"pass"),
    Metrostroi.Skins.GetTable("CabTexture","CabTexture",false,"cab"),
    {"Announcer","Spawner.710.Announcer","List",function()
        local Announcer = {}
        if Metrostroi.AnnouncementsRRI then
            table.insert(Announcer,Metrostroi.GetPhrase("Spawner.710.RRI"))
        end
        for k,v in pairs(Metrostroi.AnnouncementsASNP or {}) do if not v.asnp then Announcer[k+1] = v.name or k end end
        return Announcer
    end, nil,function(ent,val,rot,i,wagnum,rclk)
        if Metrostroi.AnnouncementsRRI and val==1 then
            ent:SetNW2Int("AnnType",1)
            ent:SetNW2Int("Announcer",1)
        else
            ent:SetNW2Int("Announcer",val-1)
            ent:SetNW2Int("AnnType",2)
        end
    end},
    {"SpawnMode","Spawner.Common.SpawnMode","List",{"Spawner.Common.SpawnMode.Full","Spawner.Common.SpawnMode.Deadlock","Spawner.Common.SpawnMode.NightDeadlock","Spawner.Common.SpawnMode.Depot"}, nil,function(ent,val,rot,i,wagnum,rclk)
        if rclk then return end
        if ent._SpawnerStarted~=val then
            ent.VB:TriggerInput("Set",val<=2 and 1 or 0)
            ent.AV:TriggerInput("Set",val<=2 and 1 or 0)
            if ent.RRI  then
                local first = i==1 or _LastSpawner~=CurTime()
                ent.VU2:TriggerInput("Set",(val<=2 and first) and 1 or 0)
                ent.ARS:TriggerInput("Set",(val<=2 and ent.Plombs.RUM) and 1 or 0)
                ent.ALS:TriggerInput("Set",val<=2 and 1 or 0)
                ent.EPK:TriggerInput("Set",(val<=2 and ent.Plombs.RUM) and 1 or 0)
                ent.RRIEnable:TriggerInput("Set",val<=1 and 1 or 0)
                ent.RRIAmplifier:TriggerInput("Set",val<=1 and 1 or 0)
                ent.R_ASNPOn:TriggerInput("Set",val<=2 and 1 or 0)
                ent.R_UNch:TriggerInput("Set",(val<=1 and first) and 1 or 0)
                ent.R_Radio:TriggerInput("Set",(val<=1 and first) and 1 or 0)
                ent.R_G:TriggerInput("Set",(val<=1 and first) and 1 or 0)
                ent.R_ZS:TriggerInput("Set",(val<=1 and first) and 1 or 0)
                ent.RST:TriggerInput("Set",(val<=1 and first) and 1 or 0)
                ent.V1:TriggerInput("Set",(val==1 and first) and 1 or 0)
                _LastSpawner=CurTime()
                ent.CabinDoor = val==4 and first
                ent.PassengerDoor = val==4
                ent.RearDoor = val==4
                ent.DriverValveTLDisconnect:TriggerInput("Set",(val==4 and first) and 1 or 0)
                ent.DriverValveBLDisconnect:TriggerInput("Set",(val==4 and first) and 1 or 0)
            else
                ent.VU2:TriggerInput("Set",0)
                ent.FrontDoor = val==4
                ent.RearDoor = val==4
            end
            ent.Pneumatic.RightDoorState = val==4 and {1,1,1,1} or {0,0,0,0}
            ent.Pneumatic.DoorRight = val==4
            ent.Pneumatic.LeftDoorState = val==4 and {1,1,1,1} or {0,0,0,0}
            ent.Pneumatic.DoorLeft = val==4
            ent.GV:TriggerInput("Set",val<4 and 1 or 0)
            ent._SpawnerStarted = val
        end
        if val==1 then ent.KO:TriggerInput("Close",1) else ent.KO:TriggerInput("Open",1) end
        ent.Pneumatic.TrainLinePressure = val==3 and math.random()*4 or val==2 and 4.5+math.random()*3 or 7.6+math.random()*0.6
        ent.Pneumatic.BrakeLinePressure = val == 4 and 5.2 or val == 1 and 2.3 or math.min(ent.Pneumatic.TrainLinePressure+0.25,math.random()*4)
        ent.Pneumatic.ReservoirPressure = val == 4 and 5.2 or val == 1 and 2.3 or math.min(ent.Pneumatic.TrainLinePressure+0.25,math.random()*4)
    end},
}

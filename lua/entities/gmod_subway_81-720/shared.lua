ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "Metrostroi (trains)"
ENT.SkinsType = "81-720"
ENT.Model = "models/metrostroi_train/81-720/81-720.mdl"

ENT.Spawnable       = true
ENT.AdminSpawnable  = true
ENT.DontAccelerateSimulation = false

function ENT:PassengerCapacity()
    return 300
end

function ENT:GetStandingArea()
    return Vector(-460,-30,-60),Vector(360,30,-60)
end
local function GetDoorPosition(i,k)
    return Vector(377.0 - 36.0 + 1*(k) - 230*i,-64*(1-2*k),-10)
end
local yventpos = {
    -414.5+0*117,
    -414.5+1*117+6.2,
    -414.5+2*117+5,
    -414.5+3*117+2,
    -414.5+4*117+0.5,
    -414.5+5*117-2.3,
    -414.5+6*117,
}
function ENT:InitializeSounds()
    self.BaseClass.InitializeSounds(self)
    self.SoundNames["tisu"]   = {"subway_trains/720/tisu.wav",loop = true}
    self.SoundPositions["tisu"] = {400,1e9,Vector(0,0,-448),0.11} --FIXME: Pos
    self.SoundNames["tisu2"]   = {"subway_trains/720/tisu4.wav",loop = true}
    self.SoundPositions["tisu2"] = {50,1e9,Vector(439,13,-40),0.15} --FIXME: Pos
    self.SoundNames["tisu3"]   = {"subway_trains/720/tisu3.wav",loop = true}
    self.SoundPositions["tisu3"] = {400,1e9,Vector(0,0,-448),0.11} --FIXME: Pos
    self.SoundNames["bbe"]   = {"subway_trains/720/bbe.wav",loop = true}
    self.SoundPositions["bbe"] = {400,1e9,Vector(0,0,-448),0.016*0.5} --FIXME: Pos
    for i=1,7 do
        self.SoundNames["vent"..i] = {loop=true,"subway_trains/720/vent_mix.wav"}
        self.SoundPositions["vent"..i] = {130,1e9,Vector(yventpos[i],0,30),0.11}
    end

    self.SoundNames["ring"] = {loop=0.0,"subway_trains/720/ring/ring_start.wav","subway_trains/720/ring/ring_loop.wav","subway_trains/720/ring/ring_end.wav"}
    self.SoundPositions["ring"] = {100,1e9,Vector(409,25.6,-26.3),0.45}

    self.SoundNames["compressor"] = {loop=2,"subway_trains/720/compressor/compressor720_start.wav","subway_trains/720/compressor/compressor720_loop.wav","subway_trains/720/compressor/compressor720_stop.wav"}
    self.SoundPositions["compressor"] = {485,1e9,Vector(-118,-40,-66),0.35}
    self.SoundNames["compressor_pn"] = "subway_trains/722/compressor_pssh.mp3"
    self.SoundPositions["compressor_pn"] = {485,1e9,Vector(-118,-40,-66),0.45} --FIXME: Pos

    self.SoundNames["release"] = {loop=true,"subway_trains/720/pneumo_release.wav"}
    --self.SoundNames["release"] = {loop=true,"subway_trains/common/pneumatic/release_2.wav"}
    self.SoundPositions["release"] = {485,1e9,Vector(-183,0,-70),0.55}
    self.SoundNames["parking_brake"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop.wav"}
    self.SoundPositions["parking_brake"] = {400,1e9,Vector(-183,0,-70),0.95}
    self.SoundNames["crane013_brake"] = {loop=true,"subway_trains/common/pneumatic/release_2.wav"}
    self.SoundPositions["crane013_brake"] = {80,1e9,Vector(443,-14.8,-47.9),0.86}
    self.SoundNames["crane013_brake2"] = {loop=true,"subway_trains/common/pneumatic/013_brake2.wav"}
    self.SoundPositions["crane013_brake2"] = {80,1e9,Vector(443,-14.8,-47.9),0.86}
    self.SoundNames["crane013_release"] = {loop=true,"subway_trains/common/pneumatic/013_release.wav"}
    self.SoundPositions["crane013_release"] = {80,1e9,Vector(443,-14.8,-47.9),0.4}

    self.SoundNames["front_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["front_isolation"] = {300,1e9,Vector(443, 0,-63),1}
    self.SoundNames["rear_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["rear_isolation"] = {300,1e9,Vector(-456, 0,-63),1}

    self.SoundNames["pneumo_disconnect_close"] = {"subway_trains/720/013_close1.mp3","subway_trains/720/013_close2.mp3","subway_trains/720/013_close3.mp3"}
    self.SoundNames["pneumo_disconnect_open"] = {
        "subway_trains/720/013_open1.mp3",
        "subway_trains/720/013_open2.mp3",
        "subway_trains/720/013_open3.mp3",
        "subway_trains/720/013_open4.mp3",
    }
    self.SoundPositions["pneumo_disconnect_close"] = {485,1e9,Vector(495,40,-55),0.4}
    self.SoundPositions["pneumo_disconnect_open"] = {485,1e9,Vector(495,40,-55),0.4}
    self.SoundNames["disconnect_valve"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"

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
    self.SoundPositions["horn"] = {1100,1e9,Vector(500,0,-30),0.8}

    self.SoundNames["KV_-3_-2"] = "subway_trains/720/controller/t3_t2.mp3"
    self.SoundNames["KV_-2_-1"] = "subway_trains/720/controller/t2_t1.mp3"
    self.SoundNames["KV_-1_0"] = "subway_trains/720/controller/t1_0.mp3"
    self.SoundNames["KV_0_1"] = "subway_trains/720/controller/0_x1.mp3"
    self.SoundNames["KV_1_2"] = "subway_trains/720/controller/x1_x2.mp3"
    self.SoundNames["KV_2_3"] = "subway_trains/720/controller/x2_x3.mp3"
    self.SoundNames["KV_3_4"] = "subway_trains/720/controller/x3_x4.mp3"
    self.SoundNames["KV_4_3"] = "subway_trains/720/controller/x4_x3.mp3"
    self.SoundNames["KV_3_2"] = "subway_trains/720/controller/x3_x2.mp3"
    self.SoundNames["KV_2_1"] = "subway_trains/720/controller/x2_x1.mp3"
    self.SoundNames["KV_1_0"] = "subway_trains/720/controller/x1_0.mp3"
    self.SoundNames["KV_0_-1"] = "subway_trains/720/controller/0_t1.mp3"
    self.SoundNames["KV_-1_-2"] = "subway_trains/720/controller/t1_t2.mp3"
    self.SoundNames["KV_-2_-3"] = "subway_trains/720/controller/t2_t3.mp3"
    self.SoundPositions["KV_-3_-2"] = {80,1e9,Vector(461.8,25.3,-27.7)}
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

    self.SoundNames["kro_in"] = {
        "subway_trains/717/kru/kru_insert1.mp3",
        "subway_trains/717/kru/kru_insert2.mp3"
    }
    self.SoundNames["kro_out"] = {
        "subway_trains/717/kru/kru_eject1.mp3",
        "subway_trains/717/kru/kru_eject2.mp3",
        "subway_trains/717/kru/kru_eject3.mp3",
    }
    self.SoundNames["kro_-1_0"] = {
        "subway_trains/717/kru/kru0-1_1.mp3",
        "subway_trains/717/kru/kru0-1_2.mp3",
        "subway_trains/717/kru/kru0-1_3.mp3",
        "subway_trains/717/kru/kru0-1_4.mp3",
    }
    self.SoundNames["kro_0_1"] = {
        "subway_trains/717/kru/kru1-2_1.mp3",
        "subway_trains/717/kru/kru1-2_2.mp3",
        "subway_trains/717/kru/kru1-2_3.mp3",
        "subway_trains/717/kru/kru1-2_4.mp3",
    }
    self.SoundNames["kro_1_0"] = {
        "subway_trains/717/kru/kru2-1_1.mp3",
        "subway_trains/717/kru/kru2-1_2.mp3",
        "subway_trains/717/kru/kru2-1_3.mp3",
        "subway_trains/717/kru/kru2-1_4.mp3",
    }
    self.SoundNames["kro_0_-1"] = {
        "subway_trains/717/kru/kru1-0_1.mp3",
        "subway_trains/717/kru/kru1-0_2.mp3",
        "subway_trains/717/kru/kru1-0_3.mp3",
        "subway_trains/717/kru/kru1-0_4.mp3",
    }
    self.SoundPositions["kro_in"] = {80,1e9,Vector(463.4,53.3,-21.1)}
    self.SoundPositions["kro_out"] = self.SoundPositions["kro_in"]
    self.SoundPositions["kro_-1_0"] = self.SoundPositions["kro_in"]
    self.SoundPositions["kro_0_1"] = self.SoundPositions["kro_in"]
    self.SoundPositions["kro_1_0"] = self.SoundPositions["kro_in"]
    self.SoundPositions["kro_0_-1"] = self.SoundPositions["kro_in"]

    self.SoundNames["krr_in"] = self.SoundNames["kro_in"]
    self.SoundNames["krr_out"] = self.SoundNames["kro_out"]
    self.SoundNames["krr_-1_0"] = self.SoundNames["kro_-1_0"]
    self.SoundNames["krr_0_1"] = self.SoundNames["kro_0_1"]
    self.SoundNames["krr_1_0"] = self.SoundNames["kro_1_0"]
    self.SoundNames["krr_0_-1"] = self.SoundNames["kro_0_-1"]
    self.SoundPositions["krr_in"] = {80,1e9,Vector(470.4,53.9,-17.3)}
    self.SoundPositions["krr_out"] = self.SoundPositions["krr_in"]
    self.SoundPositions["krr_-1_0"] = self.SoundPositions["krr_in"]
    self.SoundPositions["krr_0_1"] = self.SoundPositions["krr_in"]
    self.SoundPositions["krr_1_0"] = self.SoundPositions["krr_in"]
    self.SoundPositions["krr_0_-1"] = self.SoundPositions["krr_in"]

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
    self.SoundPositions["k2_on"] = {440,1e9,Vector(-60,-40,-66),0.45}
    self.SoundPositions["k1_on"] = {440,1e9,Vector(-60,-40,-66),0.6}
    self.SoundPositions["k2_off"] = self.SoundPositions["k2_on"]
    self.SoundPositions["k3_off"] = self.SoundPositions["k2_on"]
    self.SoundPositions["k3_on"] = self.SoundPositions["k2_on"]
    self.SoundPositions["k3_off"] = self.SoundPositions["k2_on"]
    self.SoundPositions["kmr1_on"] = self.SoundPositions["k2_on"]
    self.SoundPositions["kmr1_off"] = self.SoundPositions["k2_on"]
    self.SoundPositions["kmr2_on"] = self.SoundPositions["k2_on"]
    self.SoundPositions["kmr2_off"] = self.SoundPositions["k2_on"]

    self.SoundNames["switch_batt_on"] = {"subway_trains/720/switches/batt_on.mp3","subway_trains/720/switches/batt_on2.mp3"}
    self.SoundNames["switch_batt_off"] = {"subway_trains/720/switches/batt_off.mp3","subway_trains/720/switches/batt_off2.mp3"}

    self.SoundNames["switch_batt"] = {"subway_trains/720/switches/batt_on.mp3","subway_trains/720/switches/batt_on2.mp3","subway_trains/720/switches/batt_off.mp3","subway_trains/720/switches/batt_off2.mp3"}

    self.SoundNames["switch_pvz_on"] = {"subway_trains/720/switches/switchb_on.mp3","subway_trains/720/switches/switchp_on.mp3"}
    self.SoundNames["switch_pvz_off"] = {"subway_trains/720/switches/switchb_off.mp3","subway_trains/720/switches/switchp_off.mp3"}

    self.SoundNames["switch_on"] = {"subway_trains/720/switches/switchp_on.mp3","subway_trains/720/switches/switchp_on2.mp3","subway_trains/720/switches/switchp_on3.mp3"}
    self.SoundNames["switch_off"] = {"subway_trains/720/switches/switchp_off.mp3","subway_trains/720/switches/switchp_off2.mp3","subway_trains/720/switches/switchp_off3.mp3"}

    self.SoundNames["button_vityaz1_press"] = {"subway_trains/720/switches/buttv_press.mp3","subway_trains/720/switches/buttv_press2.mp3","subway_trains/720/switches/buttv_press3.mp3"}
    self.SoundNames["button_vityaz1_release"] = {"subway_trains/720/switches/buttv_release.mp3","subway_trains/720/switches/buttv_release2.mp3","subway_trains/720/switches/buttv_release3.mp3"}
    self.SoundNames["button_vityaz2_press"] = {"subway_trains/720/switches/buttv_press4.mp3","subway_trains/720/switches/buttv_press5.mp3","subway_trains/720/switches/buttv_press6.mp3"}
    self.SoundNames["button_vityaz2_release"] = {"subway_trains/720/switches/buttv_release4.mp3","subway_trains/720/switches/buttv_release5.mp3","subway_trains/720/switches/buttv_release6.mp3"}
    self.SoundNames["button_vityaz3_press"] = {"subway_trains/720/switches/buttv_press.mp3","subway_trains/720/switches/buttv_press3.mp3","subway_trains/720/switches/buttv_press7.mp3","subway_trains/720/switches/buttv_press8.mp3"}
    self.SoundNames["button_vityaz3_release"] = {"subway_trains/720/switches/buttv_release.mp3","subway_trains/720/switches/buttv_release3.mp3","subway_trains/720/switches/buttv_release7.mp3","subway_trains/720/switches/buttv_release8.mp3"}
    self.SoundNames["button_vityaz4_press"] = {"subway_trains/720/switches/buttv3_press.mp3","subway_trains/720/switches/buttv_press2.mp3","subway_trains/720/switches/buttv_press.mp3","subway_trains/720/switches/buttv_press8.mp3"}
    self.SoundNames["button_vityaz4_release"] = {"subway_trains/720/switches/buttv4_release.mp3","subway_trains/720/switches/buttv_release5.mp3","subway_trains/720/switches/buttv_release7.mp3","subway_trains/720/switches/buttv_release6.mp3"}

    self.SoundNames["button_press"] = {"subway_trains/720/switches/butt_press.mp3","subway_trains/720/switches/butt_press2.mp3","subway_trains/720/switches/butt_press3.mp3"}
    self.SoundNames["button_release"] = {"subway_trains/720/switches/butt_release.mp3","subway_trains/720/switches/butt_release2.mp3","subway_trains/720/switches/butt_release3.mp3"}

    self.SoundNames["button_square_press"] = "subway_trains/720/switches/butts_press.mp3"
    self.SoundNames["button_square_release"] = "subway_trains/720/switches/butts_release.mp3"

    self.SoundNames["button_square_on"] = {"subway_trains/720/switches/butts_on.mp3","subway_trains/720/switches/butts_on2.mp3"}
    self.SoundNames["button_square_off"] = {"subway_trains/720/switches/butts_off.mp3","subway_trains/720/switches/butts_off2.mp3"}

    self.SoundNames["door_cab_open"] = {"subway_trains/720/door/door_torec_open.mp3","subway_trains/720/door/door_torec_open2.mp3"}
    self.SoundNames["door_cab_close"] = {"subway_trains/720/door/door_torec_close.mp3","subway_trains/720/door/door_torec_close2.mp3"}
    self.SoundNames["door_cab_roll"] = {"subway_trains/720/door/cabdoor_roll1.mp3","subway_trains/720/door/cabdoor_roll2.mp3","subway_trains/720/door/cabdoor_roll3.mp3","subway_trains/720/door/cabdoor_roll4.mp3"}
    self.SoundNames["cab_door_open"] = "subway_trains/common/door/cab/door_open.mp3"
    self.SoundNames["cab_door_close"] = "subway_trains/common/door/cab/door_close.mp3"

    self.SoundNames["rolling_10"] = {loop=true,"subway_trains/720/rolling/rolling_10.wav"}
    self.SoundNames["rolling_30"] = {loop=true,"subway_trains/720/rolling/rolling_30.wav"}
    self.SoundNames["rolling_55"] = {loop=true,"subway_trains/720/rolling/rolling_55.wav"}
    self.SoundNames["rolling_75"] = {loop=true,"subway_trains/720/rolling/rolling_75.wav"}
    self.SoundPositions["rolling_10"] = {485,1e9,Vector(0,0,0),0.33}
    self.SoundPositions["rolling_30"] = {485,1e9,Vector(0,0,0),0.7}
    self.SoundPositions["rolling_55"] = {485,1e9,Vector(0,0,0),0.85}
    self.SoundPositions["rolling_75"] = {485,1e9,Vector(0,0,0),0.90}
    self.SoundNames["rolling_low"] = {loop=true,"subway_trains/717/rolling/rolling_outside_low.wav"}
    self.SoundNames["rolling_medium1"] = {loop=true,"subway_trains/717/rolling/rolling_outside_medium1.wav"}
    self.SoundNames["rolling_medium2"] = {loop=true,"subway_trains/717/rolling/rolling_outside_medium2.wav"}
    self.SoundNames["rolling_high2"] = {loop=true,"subway_trains/717/rolling/rolling_outside_high2.wav"}
    self.SoundPositions["rolling_low"] = {480,1e12,Vector(0,0,0),0.6*0.4}
    self.SoundPositions["rolling_medium1"] = {480,1e12,Vector(0,0,0),0.90*0.4}
    self.SoundPositions["rolling_medium2"] = {480,1e12,Vector(0,0,0),0.90*0.4}
    self.SoundPositions["rolling_high2"] = {480,1e12,Vector(0,0,0),1.00*0.4}


    self.SoundNames["gv_f"] = {"subway_trains/717/kv70/reverser_0-b_1.mp3","subway_trains/717/kv70/reverser_0-b_2.mp3"}
    self.SoundNames["gv_b"] = {"subway_trains/717/kv70/reverser_b-0_1.mp3","subway_trains/717/kv70/reverser_b-0_2.mp3"}
    self.SoundPositions["gv_f"] = {80,1e9,Vector(126.4,50,-60-23.5),0.8}
    self.SoundPositions["gv_b"] = {80,1e9,Vector(126.4,50,-60-23.5),0.8}

    --self.SoundNames["doors"] = "subway_trains/720/door/door_roll.mp3"
    --self.SoundNames["doorl"] = {loop=true,"subway_trains/722/door_loop.wav"}
    --self.SoundPositions["doors"] = {300,1e9,Vector(0,0,0),0.5}
    --self.SoundPositions["doorl"] = {300,1e9,Vector(0,0,0),0.5}
    for i=0,3 do
        for k=0,1 do
            self.SoundNames["door"..i.."x"..k.."r"] = {"subway_trains/720/door/door_loop.wav",loop=true}
            self.SoundPositions["door"..i.."x"..k.."r"] = {100,1e9,GetDoorPosition(i,k),0.07}
            self.SoundNames["door"..i.."x"..k.."o"] = {"subway_trains/720/door/door_open_end4.mp3","subway_trains/720/door/door_open_end3.mp3"}
            self.SoundPositions["door"..i.."x"..k.."o"] = {150,1e9,GetDoorPosition(i,k),0.55}
            self.SoundNames["door"..i.."x"..k.."c"] = {"subway_trains/720/door/door_close_end4.mp3","subway_trains/720/door/door_close_end5.mp3","subway_trains/720/door/door_close_end3.mp3"}
            self.SoundPositions["door"..i.."x"..k.."c"] = {250,1e9,GetDoorPosition(i,k),0.55}
        end
    end

    self.SoundNames["work_beep"] = {loop=true,"subway_trains/720/work_beep_loop.wav"}
    self.SoundPositions["work_beep"] = {65,1e9,Vector(0,23,10),0.03}
    self.SoundNames["batt_on"] = "subway_trains/720/batt_on.mp3"
    self.SoundPositions["batt_on"] = {400,1e9,Vector(126.4,50,-60-23.5),0.23}

    self.SoundNames["igla_on"]  = "subway_trains/common/other/igla/igla_on1.mp3"
    self.SoundNames["igla_off"] = "subway_trains/common/other/igla/igla_off2.mp3"
    self.SoundNames["igla_start1"]  = "subway_trains/common/other/igla/igla2_start1.mp3"
    self.SoundNames["igla_start2"]  = "subway_trains/common/other/igla/igla2_start2.mp3"
    self.SoundPositions["igla_on"] = {50,1e9,Vector(409.75,37.5,24.7),0.05}
    self.SoundPositions["igla_off"] = {50,1e9,Vector(409.75,37.5,24.7),0.05}
    self.SoundPositions["igla_start1"] = {50,1e9,Vector(409.75,37.5,24.7),0.05}
    self.SoundPositions["igla_start2"] = {50,1e9,Vector(409.75,37.5,24.7),0.05}


    self.SoundNames["emer_brake"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop.wav"}
    self.SoundPositions["emer_brake"] = {90,1e9,Vector(380,-45,-75),0.85}

    for i = 1,10 do
        local id1 = Format("b1tunnel_%d",i)
        local id2 = Format("b2tunnel_%d",i)
        self.SoundPositions[id1.."a"] = {500,1e9,Vector( 317-5,0,-84),0.5}
        self.SoundPositions[id1.."b"] = self.SoundPositions[id1.."a"]
        self.SoundPositions[id2.."a"] = {500,1e9,Vector(-317+0,0,-84),0.5}
        self.SoundPositions[id2.."b"] = self.SoundPositions[id2.."a"]
    end
    for i = 1,14 do
        local id1 = Format("b1street_%d",i)
        local id2 = Format("b2street_%d",i)
        self.SoundPositions[id1.."a"] = {500,1e9,Vector( 317-5,0,-84),0.5}
        self.SoundPositions[id1.."b"] = self.SoundPositions[id1.."a"]
        self.SoundPositions[id2.."a"] = {500,1e9,Vector(-317+0,0,-84),0.5}
        self.SoundPositions[id2.."b"] = self.SoundPositions[id2.."a"]
    end
end

function ENT:InitializeSystems()
    self:LoadSystem("TR","TR_3B")
    self:LoadSystem("Engines","DK_120AM")
    self:LoadSystem("Electric","81_720_Electric")
    self:LoadSystem("BPTI","81_720_BPTI")
    self:LoadSystem("RV","81_720_RV")


    self:LoadSystem("BUKP","81_720_BUKP")
    self:LoadSystem("BUV","81_720_BUV")

    self:LoadSystem("BARS","81_720_BARS")

    self:LoadSystem("Pneumatic","81_720_Pneumatic")
    self:LoadSystem("Horn","81_720_Horn")


    self:LoadSystem("Panel","81_720_Panel")

    self:LoadSystem("Announcer","81_71_Announcer", "AnnouncementsASNP")
    self:LoadSystem("ASNP","81_71_ASNP")
    self:LoadSystem("ASNP_VV","81_71_ASNP_VV")

    self:LoadSystem("Tickers","81_720_Ticker")
    self:LoadSystem("PassSchemes","81_720_PassScheme")


    self:LoadSystem("IGLA_CBKI","81_720_IGLA_CBKI2")
    self:LoadSystem("IGLA_PCBK","81_720_IGLA_PCBK")


    self:LoadSystem("RouteNumber","81_71_RouteNumber",2)
    self:LoadSystem("LastStation","81_71_LastStation","720","route")
end
ENT.AnnouncerPositions = {}
for i=1,3 do
    table.insert(ENT.AnnouncerPositions,{Vector(188-(i-1)*230+38,47*(i%2 > 0 and -1 or 1) ,44),200,0.15})
end
ENT.Cameras = {
    {Vector(407.5+17,32,22),Angle(0,180-7,0),"Train.720.CameraCond"},
    {Vector(407.5+17,32,3),Angle(0,180-7,0),"Train.720.CameraPPZ"},
    {Vector(407.5+17,32,-19.5),Angle(0,180-7,0),"Train.720.CameraPV"},
    {Vector(407.5+10,-4,40),Angle(0,180+5,0),"Train.Common.ASNP"},
    {Vector(407.5+50,-14,-15),Angle(90-46,0,0),"Train.720.CameraVityaz"},
    {Vector(407.5+40,-35,-30),Angle(60,90,0),"Train.720.CameraKRMH"},
    {Vector(380,35,-5),Angle(0,60,0),"Train.720.CameraPVZ"},
    {Vector(407.5+90,43.5,47),Angle(15,180,0),"Train.Common.RouteNumber"},
    {Vector(407.5+90,10,47)  ,Angle(15,180,0),"Train.Common.LastStation"},
    {Vector(450+40,0,20),Angle(60,0,0),"Train.Common.CouplerCamera"},
}
---------------------------------------------------
-- Defined train information
-- Types of wagon(for wagon limit system):
-- 0 = Head or intherim
-- 1 = Only head
-- 2 = Only intherim
---------------------------------------------------
ENT.SubwayTrain = {
    Type = "81-720",
    Name = "81-720",
    WagType = 1,
    Manufacturer = "MVM",
    ALS = {
        HaveAutostop = true,
        TwoToSix = true,
        RSAs325Hz = true,
        Aproove0As325Hz = false,
    },
    EKKType = 720
}
ENT.NumberRanges = {{0007,0099}}

ENT.Spawner = {
    model = {
        "models/metrostroi_train/81-720/81-720.mdl",
        "models/metrostroi_train/81-720/720_cab.mdl",
        "models/metrostroi_train/81-720/720_salon.mdl",
        "models/metrostroi_train/81-720/glass_red.mdl",
        "models/metrostroi_train/81-720/721_underwagon.mdl",
    },
    interim = "gmod_subway_81-721",
    postfunc = function(trains,WagNum)
        for i=1,#trains do
            local ent = trains[i]
            if not ent.BUKP then continue end
            ent.BUKP.WagNum = WagNum
            ent.BUKP.Trains = {}
            local first,last = 1,#trains
            for i1=1,#trains do
                local tent = trains[i==1 and i1 or #trains-i1+1]
                ent.BUKP.Trains[i1] = tent:GetWagonNumber()
                ent.BUKP.Trains[tent:GetWagonNumber()] = {}
            end
        end
    end,
    Metrostroi.Skins.GetTable("Texture","Spawner.Texture",false,"train"),
    Metrostroi.Skins.GetTable("PassTexture","Spawner.PassTexture",false,"pass"),
    Metrostroi.Skins.GetTable("CabTexture","Spawner.CabTexture",false,"cab"),
    {"Announcer","Spawner.720.Announcer","List",function()
        local Announcer = {}
        for k,v in pairs(Metrostroi.AnnouncementsASNP or {}) do if not v.riu then Announcer[k] = v.name or k end end
        return Announcer
    end},
    {"Scheme","Spawner.720.Schemes","List",function()
        local Schemes = {}
        for k,v in pairs(Metrostroi.Skins["720_schemes"] or {}) do Schemes[k] = v.name or k end
        return Schemes
    end},
    {"PassSchemesInvert","Spawner.720.InvertSchemes","Boolean",false,function(ent,val,rot) ent:SetNW2Bool("PassSchemesInvert",rot and not val or not rot and val) end},
    {"SpawnMode","Spawner.Common.SpawnMode","List",{"Spawner.Common.SpawnMode.Full","Spawner.Common.SpawnMode.Deadlock","Spawner.Common.SpawnMode.NightDeadlock","Spawner.Common.SpawnMode.Depot"}, nil,function(ent,val,rot,i,wagnum,rclk)
        if rclk then return end
        if ent._SpawnerStarted~=val then
            ent.Battery:TriggerInput("Set",val<=2 and 1 or 0)
            if ent.SF1  then
                local first = i==1 or _LastSpawner~=CurTime()
                ent.Ticker:TriggerInput("Set",val==1 and 1 or 0)
                ent.Vent1:TriggerInput("Set",val==1 and 1 or 0)
                --ent.Vent2:TriggerInput("Set",val==1 and 1 or 0)
                ent.PassLight:TriggerInput("Set",val==1 and 1 or 0)
                ent.Headlights1:TriggerInput("Set",val==1 and 1 or 0)
                ent.CabLight:TriggerInput("Set",val==1 and 1 or 0)
                ent.BBE:TriggerInput("Set",val==1 and 1 or 0)
                ent.Compressor:TriggerInput("Set",val==1 and 1 or 0)
                ent.PassScheme:TriggerInput("Set",val==1 and 1 or 0)
                ent.R_Announcer:TriggerInput("Set",val<=2 and 1 or 0)
                ent.R_ASNPOn:TriggerInput("Set",val<=2 and 1 or 0)
                if val==1 then
                    timer.Simple(1,function()
                        if not IsValid(ent) then return end
                        ent.BUKP.State=2
                    end)
                end
                ent.SF4:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SF5:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SF6:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SF12:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SF13:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SF15:TriggerInput("Set",val<=2 and 1 or 0)

                _LastSpawner=CurTime()
                ent.CabinDoorLeft = val==4 and first
                ent.CabinDoorRight = val==4 and first
                ent.PassengerDoor = val==4
                ent.RearDoor = val==4
            else
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
        if val==1 then ent.BV:TriggerInput("Close",1) end
        ent.Pneumatic.TrainLinePressure = val==3 and math.random()*4 or val==2 and 4.5+math.random()*3 or 7.6+math.random()*0.6
    end},
    --{"GV","Spawner.717.GV","Boolean",true,function(ent,val) ent.GV:TriggerInput("Set",val) end},
    --{"PB","Spawner.717.PB","Boolean",false,function(ent,val) ent.ParkingBrake:TriggerInput("Set",val) end},
}

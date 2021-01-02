ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "Metrostroi (trains)"
ENT.SkinsType = "81-722"
ENT.Model = "models/metrostroi_train/81-722/81-722.mdl"

ENT.Spawnable       = true
ENT.AdminSpawnable  = false
ENT.DontAccelerateSimulation = false

function ENT:PassengerCapacity()
    return 300
end

function ENT:GetStandingArea()
    return Vector(-450,-30,-62),Vector(380,30,-62)
end

ENT.AnnouncerPositions = {
}
for i=1,4 do
    table.insert(ENT.AnnouncerPositions,{Vector(323-(i-1)*230+37.5,47 ,44),100,0.1})
    table.insert(ENT.AnnouncerPositions,{Vector(323-(i-1)*230,-47,44),100,0.1})
end
ENT.Cameras = {
    {Vector(407.5+10,44,20),Angle(0,180,0),"Train.722.Breakers"},
    {Vector(407.5+5,50,0),Angle(0,180,0),"Train.722.PU2_1"},
    {Vector(407.5+10,43,-10),Angle(0,180,0),"Train.722.PU2_2"},
    {Vector(407.5+60,6,-4.5),Angle(25,0,0),"Train.722.Vityaz"},
    {Vector(407.5+57,31,-6),Angle(25,30,0),"Train.722.SARMAT"},
    {Vector(407.5+40,40,-25),Angle(0,0,0),"Train.722.CabLights"},
    {Vector(407.5+67.5,41.4,5),Angle(75,0,0),"Train.Common.RouteNumber"},
    {Vector(407.5+15,44,-40),Angle(57,180,0),"Train.722.Disconnects"},
    {Vector(407.5+40,45,-40),Angle(45,30,0),"Train.722.KRMH"},
    {Vector(450+38,11,20),Angle(60,0,0),"Train.Common.CouplerCamera"},
}
function ENT:InitializeSounds()
    self.BaseClass.InitializeSounds(self)
    self.SoundNames["test_async1"]   = {"subway_trains/722/engines/inverter_1000.wav",loop = true}
    self.SoundNames["test_async1_2"]   = {"subway_trains/722/engines/inverter_1000.wav",loop = true}
    self.SoundNames["test_async1_3"]   = {"subway_trains/722/engines/inverter_1000.wav",loop = true}
    self.SoundNames["test_async2"]   = {"subway_trains/722/engines/inverter_2000.wav",loop = true}
    self.SoundNames["test_async3"]   = {"subway_trains/722/engines/inverter_2800.wav",loop = true}
    self.SoundNames["test_async3_2"]   = {"subway_trains/722/engines/inverter_2800.wav",loop = true}
    self.SoundPositions["test_async1"] = {400,1e9,Vector(0,0,0),0.5}
    self.SoundPositions["test_async1_2"] = {400,1e9,Vector(0,0,0),0.1}
    self.SoundPositions["test_async1_3"] = {400,1e9,Vector(0,0,0),0.1}
    self.SoundPositions["test_async2"] = {400,1e9,Vector(0,0,0),0.1}
    self.SoundPositions["test_async3"] = {400,1e9,Vector(0,0,0),0.1}
    self.SoundPositions["test_async3_2"] = self.SoundPositions["test_async3"]
    self.SoundNames["async_p2"]   = {"subway_trains/722/engines/inverter_1000.wav",loop = true}
    self.SoundPositions["async_p2"] = {400,1e9,Vector(0,0,0),1}
    self.SoundNames["async_p3"]   = {"subway_trains/722/engines/inverter_1000.wav",loop = true}
    self.SoundPositions["async_p3"] = {400,1e9,Vector(0,0,0),1}
    self.SoundNames["engine_loud"]   = {"subway_trains/722/engines/engine_loud.wav",loop = true}
    self.SoundPositions["engine_loud"] = {400,1e9,Vector(0,0,0),0.2}
    self.SoundNames["chopper"]   = {"subway_trains/722/chopper.wav",loop = true}
    self.SoundPositions["chopper"] = {400,1e9,Vector(0,0,0),0.03}

    self.SoundNames["battery_on_1"]   = "subway_trains/722/battery/battery_off_1.mp3"
    self.SoundPositions["battery_on_1"] = {100,1e9,Vector(182,50,-75),0.5}
    self.SoundNames["battery_off_1"]   = "subway_trains/722/battery/battery_off_1.mp3"
    self.SoundPositions["battery_off_1"] = {100,1e9,Vector(182,50,-75),0.5}
    self.SoundNames["battery_off_2"]   = "subway_trains/722/battery/battery_off_2.mp3"
    self.SoundPositions["battery_off_2"] = {100,1e9,Vector(182,50,-75),0.5}
    self.SoundNames["battery_off_stop"]   = "subway_trains/722/battery/battery_off_stop.mp3"
    self.SoundPositions["battery_off_stop"] = {120,1e9,Vector(182,50,-75),0.5}
    self.SoundNames["battery_pneumo"]   = "subway_trains/722/battery/battery_pneumo.mp3"
    self.SoundPositions["battery_pneumo"] = {200,1e9,Vector(182,50,-75),0.1}
    self.SoundNames["battery_off_loop"]   = {loop=true,"subway_trains/722/battery/battery_off_loop.wav"}
    self.SoundPositions["battery_off_loop"] = {100,1e9,Vector(182,50,-75),0.02}

    self.SoundNames["compressor"] = {loop=true,"subway_trains/722/compressol_loop.wav"}
    self.SoundPositions["compressor"] = {485,1e9,Vector(-118,-40,-66),0.75} --FIXME: Pos
    self.SoundNames["compressor_pn"] = "subway_trains/722/compressor_pssh.mp3"
    self.SoundPositions["compressor_pn"] = {485,1e9,Vector(-118,-40,-66),0.75} --FIXME: Pos

    self.SoundNames["release"] = {loop=true,"subway_trains/722/pneumo_release2.wav"}
    self.SoundPositions["release"] = {320,1e9,Vector(-183,0,-70),0.1} --FIXME: Pos
    self.SoundNames["parking_brake"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop.wav"}
    self.SoundPositions["parking_brake"] = {400,1e9,Vector(-183,0,-70),0.95}
    self.SoundNames["crane013_brake"] = {loop=true,"subway_trains/common/pneumatic/release_2.wav"}
    self.SoundPositions["crane013_brake"] = {80,1e9,Vector(475,-10,-47.9),0.86}
    self.SoundNames["crane013_brake2"] = {loop=true,"subway_trains/common/pneumatic/013_brake2.wav"}
    self.SoundPositions["crane013_brake2"] = {80,1e9,Vector(475,-10,-47.9),0.86}
    self.SoundNames["crane013_release"] = {loop=true,"subway_trains/common/pneumatic/013_release.wav"}
    self.SoundPositions["crane013_release"] = {80,1e9,Vector(475,-10,-47.9),0.4}
    self.SoundNames["pneumo_disconnect_close"] = {"subway_trains/722/013_close1.mp3","subway_trains/722/013_close2.mp3","subway_trains/722/013_close3.mp3"}
    self.SoundNames["pneumo_disconnect_open"] = {
        "subway_trains/722/013_open1.mp3",
        "subway_trains/722/013_open2.mp3",
        "subway_trains/722/013_open3.mp3",
        "subway_trains/722/013_open4.mp3",
    }
    self.SoundPositions["pneumo_disconnect_close"] = {100,1e9,Vector(411,45,-61),0.2}
    self.SoundPositions["pneumo_disconnect_open"] = {100,1e9,Vector(411,45,-61),0.2}

    self.SoundNames["front_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["front_isolation"] = {300,1e9,Vector(500, 0,-63),1}
    self.SoundNames["rear_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["rear_isolation"] = {300,1e9,Vector(-469, 0,-63),1}

    self.SoundNames["ring"] = {loop=0,"subway_trains/722/ring1_loop.wav","subway_trains/722/ring1_loop.wav","subway_trains/722/ring1_end.wav"}
    self.SoundPositions["ring"] = {100,1e9,Vector(406+0.2,36.3,-2.7),1}
    self.SoundNames["ring2"] = {loop=true,"subway_trains/722/ring2_loop.wav"} --FIXME: Sarmat
    self.SoundPositions["ring2"] = {100,1e9,Vector(406+0.2,36.3+1.5,-2.7),1}

    self.SoundNames["rolling_10"] = {loop=true,"subway_trains/722/rolling_10.wav"}
    self.SoundNames["rolling_45"] = {loop=true,"subway_trains/722/rolling_45.wav"}
    self.SoundNames["rolling_60"] = {loop=true,"subway_trains/722/rolling_60.wav"}
    self.SoundNames["rolling_70"] = {loop=true,"subway_trains/722/rolling_70.wav"}
    self.SoundPositions["rolling_10"] = {485,1e9,Vector(0,0,0),0.20}
    self.SoundPositions["rolling_45"] = {485,1e9,Vector(0,0,0),0.50}
    self.SoundPositions["rolling_60"] = {485,1e9,Vector(0,0,0),0.55}
    self.SoundPositions["rolling_70"] = {485,1e9,Vector(0,0,0),0.60}
    self.SoundNames["rolling_low"] = {loop=true,"subway_trains/717/rolling/rolling_outside_low.wav"}
    self.SoundNames["rolling_medium1"] = {loop=true,"subway_trains/717/rolling/rolling_outside_medium1.wav"}
    self.SoundNames["rolling_medium2"] = {loop=true,"subway_trains/717/rolling/rolling_outside_medium2.wav"}
    self.SoundNames["rolling_high2"] = {loop=true,"subway_trains/717/rolling/rolling_outside_high2.wav"}
    self.SoundPositions["rolling_low"] = {480,1e12,Vector(0,0,0),0.6*0.4}
    self.SoundPositions["rolling_medium1"] = {480,1e12,Vector(0,0,0),0.90*0.4}
    self.SoundPositions["rolling_medium2"] = {480,1e12,Vector(0,0,0),0.90*0.4}
    self.SoundPositions["rolling_high2"] = {480,1e12,Vector(0,0,0),1.00*0.4}

    self.SoundNames["horn"] = {loop=0.6,"subway_trains/common/pneumatic/horn/horn3_start.wav","subway_trains/common/pneumatic/horn/horn3_loop.wav", "subway_trains/common/pneumatic/horn/horn3_end.wav"}
    self.SoundPositions["horn"] = {1100,1e9,Vector(500,0,-30)}

    self.SoundNames["disconnect_valve"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"

    self.SoundNames["KU_-3_-2"] = "subway_trains/722/kuau/x_xp.mp3"
    self.SoundNames["KU_-2_-1"] = "subway_trains/722/kuau/xp_x2.mp3"
    self.SoundNames["KU_-1_0"] = "subway_trains/722/kuau/x_xp.mp3"
    self.SoundNames["KU_0_1"] = "subway_trains/722/kuau/0_x.mp3"
    self.SoundNames["KU_1_2"] = "subway_trains/722/kuau/x_xp.mp3"
    self.SoundNames["KU_2_1"] = "subway_trains/722/kuau/xp_x2.mp3"
    self.SoundNames["KU_1_0"] = "subway_trains/722/kuau/x_xp.mp3"
    self.SoundNames["KU_0_-1"] = "subway_trains/722/kuau/0_x.mp3"
    self.SoundNames["KU_-1_-2"] = "subway_trains/722/kuau/x_xp.mp3"
    self.SoundNames["KU_-2_-3"] = "subway_trains/722/kuau/xp_x.mp3"
    self.SoundPositions["KU_-3_-2"] = {90,1e3,Vector(466.7,0.2,-16.9),0.4}
    self.SoundPositions["KU_-2_-1"] = self.SoundPositions["KU_-3_-2"]
    self.SoundPositions["KU_-1_0"] = self.SoundPositions["KU_-3_-2"]
    self.SoundPositions["KU_0_1"] = self.SoundPositions["KU_-3_-2"]
    self.SoundPositions["KU_1_2"] = self.SoundPositions["KU_-3_-2"]
    self.SoundPositions["KU_2_1"] = self.SoundPositions["KU_-3_-2"]
    self.SoundPositions["KU_1_0"] = self.SoundPositions["KU_-3_-2"]
    self.SoundPositions["KU_0_-1"] = self.SoundPositions["KU_-3_-2"]
    self.SoundPositions["KU_-1_-2"] = self.SoundPositions["KU_-3_-2"]
    self.SoundPositions["KU_-2_-3"] = self.SoundPositions["KU_-3_-2"]

    self.SoundNames["sf_on"] = "subway_trains/722/switches/sf_on.mp3"
    self.SoundNames["sf_off"] = "subway_trains/722/switches/sf_off.mp3"

    self.SoundNames["button_on"] = {"subway_trains/722/switches/button_press1.mp3","subway_trains/722/switches/button_press2.mp3","subway_trains/722/switches/button_press3.mp3"}
    self.SoundNames["button_off"] = {"subway_trains/722/switches/button_release1.mp3","subway_trains/722/switches/button_release2.mp3","subway_trains/722/switches/button_release3.mp3"}

    self.SoundNames["switch_emer_on"] = "subway_trains/722/switches/big_red_e_on.mp3"
    self.SoundNames["switch_emer_off"] = "subway_trains/722/switches/big_red_e_off.mp3"

    self.SoundNames["blinker_on1"] = {"subway_trains/722/blinker_on.mp3","subway_trains/722/blinker_on2.mp3","subway_trains/722/blinker_on3.mp3","subway_trains/722/blinker_on4.mp3","subway_trains/722/blinker_on5.mp3"}
    self.SoundNames["blinker_off1"] = {"subway_trains/722/blinker_off.mp3","subway_trains/722/blinker_off2.mp3","subway_trains/722/blinker_off3.mp3","subway_trains/722/blinker_off4.mp3","subway_trains/722/blinker_off5.mp3"}
    self.SoundNames["blinker_on2"] = self.SoundNames["blinker_on1"]
    self.SoundNames["blinker_off2"] = self.SoundNames["blinker_off1"]
    self.SoundPositions["blinker_on1"] = {30,1e9,Vector(481,39.3,-7.2),0.01}
    self.SoundPositions["blinker_off1"] = self.SoundPositions["blinker_on1"]
    self.SoundPositions["blinker_on2"] = self.SoundPositions["blinker_on1"]
    self.SoundPositions["blinker_off2"] = self.SoundPositions["blinker_on1"]

    self.SoundNames["switch_kb_on"] = "subway_trains/722/switches/big_red_kb_on.mp3"
    self.SoundNames["switch_kb_off"] = "subway_trains/722/switches/big_red_kb_off.mp3"

    self.SoundNames["switch_panel_up"] = "subway_trains/722/switches/panel_switch_up.mp3"
    self.SoundNames["switch_panel_mid"] = "subway_trains/722/switches/panel_switch_mid.mp3"
    self.SoundNames["switch_panel_down"] = "subway_trains/722/switches/panel_switch_down.mp3"

    self.SoundNames["multiswitch_panel_max"] = "subway_trains/722/switches/multi_switch_panel_max.mp3"
    self.SoundNames["multiswitch_panel_mid"] = {"subway_trains/722/switches/multi_switch_panel_mid.mp3","subway_trains/722/switches/multi_switch_panel_mid2.mp3"}
    self.SoundNames["multiswitch_panel_min"] = "subway_trains/722/switches/multi_switch_panel_min.mp3"

    self.SoundNames["door_cab_open"] = "subway_trains/common/door/cab/door_open.mp3"
    self.SoundNames["door_cab_close"] = "subway_trains/common/door/cab/door_close.mp3"

    self.SoundNames["door_alarm"] = "subway_trains/722/door_alarm.mp3"
    self.SoundPositions["door_alarm"] = {485,1e9,Vector(0,0,0),0.2}

    local function GetDoorPosition(i,k,j)
        if j == 0
        then return Vector(377.0 - 36.0 + 1*(k) - 230*i,-64*(1-2*k),-10)
        else return Vector(377.0 - 36.0 + 1*(k) - 230*i,-64*(1-2*k),-10)
        end
    end
    self.SoundNames["doors"] = "subway_trains/722/door_start.mp3"
    self.SoundNames["doorl"] = {loop=true,"subway_trains/722/door_loop.wav"}
    self.SoundPositions["doors"] = {300,1e9,Vector(0,0,0),0.2}
    self.SoundPositions["doorl"] = {300,1e9,Vector(0,0,0),0.2}
    for i=0,3 do
        for k=0,1 do
            self.SoundNames["door"..i.."x"..k.."c"] = "subway_trains/722/door_close.mp3"
            self.SoundPositions["door"..i.."x"..k.."c"] = {485,1e9,GetDoorPosition(i,k,0),0.2}
        end
    end
    self.SoundNames["door_alarm"] = {"subway_trains/722/door_alarm.mp3"}
    self.SoundPositions["door_alarm"] = {485,1e9,Vector(0,0,0),0.25}


    self.SoundNames["epk_brake"] = {loop=true,"subway_trains/common/pneumatic/epv_loop.wav"}
    self.SoundPositions["epk_brake"] = {80,1e9,Vector(458,56.5,-61),0.65}

    self.SoundNames["valve_brake"] = {loop=true,"subway_trains/common/pneumatic/epv_loop.wav"}
    self.SoundPositions["valve_brake"] = {400,1e9,Vector(418.25,-49.2,1.3),1}

    self.SoundNames["emer_brake"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop.wav"}
    self.SoundPositions["emer_brake"] = {600,1e9,Vector(380,-45,-75),0.95}

    for i = 1,10 do
        local id1 = Format("b1tunnel_%d",i)
        local id2 = Format("b2tunnel_%d",i)
        self.SoundPositions[id1.."a"] = {700*0.75,1e9,Vector( 317-5,0,-84),1*0.5}
        self.SoundPositions[id1.."b"] = self.SoundPositions[id1.."a"]
        self.SoundPositions[id2.."a"] = {700*0.75,1e9,Vector(-317+0,0,-84),1*0.5}
        self.SoundPositions[id2.."b"] = self.SoundPositions[id2.."a"]
    end
    for i = 1,14 do
        local id1 = Format("b1street_%d",i)
        local id2 = Format("b2street_%d",i)
        self.SoundPositions[id1.."a"] = {700,1e9,Vector( 317-5,0,-84),1.5*0.5}
        self.SoundPositions[id1.."b"] = self.SoundPositions[id1.."a"]
        self.SoundPositions[id2.."a"] = {700,1e9,Vector(-317+0,0,-84),1.5*0.5}
        self.SoundPositions[id2.."b"] = self.SoundPositions[id2.."a"]
    end
    for k,v in ipairs(self.AnnouncerPositions) do
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
function ENT:InitializeSystems()
    self:LoadSystem("TR","TR_3B")
    self:LoadSystem("Electric","81_722_Electric")
    self:LoadSystem("BKCU","81_722_UPI")

    self:LoadSystem("AsyncInverter","81_722_AsyncInverter")

    self:LoadSystem("BUKP","81_722_BUKP")
    self:LoadSystem("MFDU","81_722_MFDU")
    self:LoadSystem("BUKV","81_722_BUKV")
    self:LoadSystem("RouteNumberSys","81_722_RouteNumber")

    self:LoadSystem("BARS","81_722_BARS")
    self:LoadSystem("ALSCoil")

    --self:LoadSystem("PAM")

    self:LoadSystem("Pneumatic","81_722_Pneumatic")
    self:LoadSystem("Horn","81_722_Horn")


    self:LoadSystem("Panel","81_722_Panel")

    self:LoadSystem("Announcer","81_71_Announcer", "AnnouncementsSarmatUPO")
    self:LoadSystem("SarmatUPO","81_722_sarmat")
    self:LoadSystem("UPO","81_71_UPO")
    self:LoadSystem("Tickers","81_722_Tickers")
    self:LoadSystem("PassSchemes","81_722_PassScheme")

end

function ENT:PostInitializeSystems()
    self.Electric:TriggerInput("Type",self.Electric.T722)
    self.UPO:TriggerInput("ArriveRandom",1)
end

---------------------------------------------------
-- Defined train information
-- Types of wagon(for wagon limit system):
-- 0 = Head or intherim
-- 1 = Only head
-- 2 = Only intherim
---------------------------------------------------
ENT.SubwayTrain = {
    Type = "81-722",
    Name = "81-722",
    WagType = 1,
    Manufacturer = "MVM",
    ALS = {
        HaveAutostop = true,
        TwoToSix = false,
        RSAs325Hz = false,
        Aproove0As325Hz = true,
    },
    EKKType = 722,
    NoFrontEKK=true,
}
ENT.NumberRanges = {{22001,22100}}

ENT.Spawner = {
    model = {
        "models/metrostroi_train/81-722/81-722.mdl",
        "models/metrostroi_train/81-722/722_salon1.mdl",
        "models/metrostroi_train/81-722/722_cabine.mdl",
        "models/metrostroi_train/81-722/722_underwagon.mdl",
        "models/metrostroi_train/81-722/722_sarmat_l.mdl",
        "models/metrostroi_train/81-722/722_sarmat_r.mdl",
    },
    spawnfunc = function(i,tbls,tblt)
        local WagNum = tbls.WagNum
        if 1<i and i<WagNum  then
            if WagNum ~= 3 and (WagNum >= 6) and (i < WagNum/2 or i > WagNum/2+1) then
                return "gmod_subway_81-723"
            else
                return "gmod_subway_81-724"
            end
        else
            return "gmod_subway_81-722"
        end
    end,
    --WagNumTable = {2,3,4,6,8},
    WagNumTable = {3,6,8},
    Metrostroi.Skins.GetTable("Texture","Spawner.Texture",false,"train"),
    Metrostroi.Skins.GetTable("PassTexture","Spawner.PassTexture",false,"pass"),
    Metrostroi.Skins.GetTable("CabTexture","Spawner.CabTexture",false,"cab"),
    {"Announcer","Spawner.722.Announcer","List",function()
        local Announcer = {}
        for k,v in pairs(Metrostroi.AnnouncementsSarmatUPO or {}) do Announcer[k] = v.name or k end
        return Announcer
    end},
    {"Scheme","Spawner.722.Schemes","List",function()
        local Schemes = {}
        for k,v in pairs(Metrostroi.Skins["722_schemes"] or {}) do Schemes[k] = v.name or k end
        return Schemes
    end},
    {"SarmatInvert","Spawner.722.InvertSchemes","Boolean",false,function(ent,val,rot) ent:SetNW2Bool("SarmatInvert",val and not rot or not val and rot) end},
    {"SpawnMode","Spawner.Common.SpawnMode","List",{"Spawner.Common.SpawnMode.Full","Spawner.Common.SpawnMode.Deadlock","Spawner.Common.SpawnMode.NightDeadlock","Spawner.Common.SpawnMode.Depot"}, nil,function(ent,val,rot,i,wagnum,rclk)
        if rclk then return end
        if ent._SpawnerStarted~=val then
            ent.Battery:TriggerInput("Set",val<=2 and 1 or 0)
            if ent.SF1  then
                local first = i==1 or _LastSpawner~=CurTime()
                ent.ALS:TriggerInput("Set",val==1 and 1 or 0)
                ent.Headlights:TriggerInput("Set",val==1 and 1 or 0)
                ent.CabinLight:TriggerInput("Set",val==1 and 1 or 0)
                ent.Compressor:TriggerInput("Set",val==1 and 1 or 0)
                ent.PassLight:TriggerInput("Set",val==1 and 1 or 0)
                ent.VKF:TriggerInput("Set",val==3 and 1 or 0)
                ent.SOSDEnable:TriggerInput("Set",(first and val==1) and 1 or 0)
                ent.SF8:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SF9:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SF16:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SF17:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SF19:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SF20:TriggerInput("Set",val<=2 and 1 or 0)

                _LastSpawner=CurTime()
                ent.CabinDoorLeft = val==4 and first
                ent.CabinDoorRight = val==4 and first
                ent.PassengerDoor = val==4
                ent.RearDoor = val==4
            else
                ent.FrontDoor = val==4
                ent.RearDoor = val==4
            end
            --ent.GV:TriggerInput("Set",val<4 and 1 or 0)
            ent._SpawnerStarted = val
        end
        ent.Pneumatic.TrainLinePressure = val==3 and math.random()*4 or val==2 and 4.5+math.random()*3 or 7.6+math.random()*0.6
    end},
    --{"GV","Spawner.717.GV","Boolean",true,function(ent,val) ent.GV:TriggerInput("Set",val) end},
    --{"PB","Spawner.717.PB","Boolean",false,function(ent,val) ent.ParkingBrake:TriggerInput("Set",val) end},
}

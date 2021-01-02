ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "Metrostroi (trains)"
ENT.SkinsType = "81-722"
ENT.Model = "models/metrostroi_train/81-722/81-724.mdl"

ENT.Spawnable       = true
ENT.AdminSpawnable  = false
ENT.DontAccelerateSimulation = false

function ENT:PassengerCapacity()
    return 300
end

function ENT:GetStandingArea()
    return Vector(-450,-30,-62),Vector(380,30,-62)
end

function ENT:InitializeSounds()
    self.BaseClass.InitializeSounds(self)
    self.SoundNames["release"] = {loop=true,"subway_trains/722/pneumo_release2.wav"}
    self.SoundPositions["release"] = {320,1e9,Vector(-183,0,-70),0.1} --FIXME: Pos
    self.SoundNames["parking_brake"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop.wav"}
    self.SoundPositions["parking_brake"] = {400,1e9,Vector(-183,0,-70),0.95}
    self.SoundNames["disconnect_valve"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"

    self.SoundNames["front_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["front_isolation"] = {300,1e9,Vector(462, 0,-63),1}
    self.SoundNames["rear_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["rear_isolation"] = {300,1e9,Vector(-469, 0,-63),1}

    self.SoundNames["sf_on"] = "subway_trains/722/switches/sf_on.mp3"
    self.SoundNames["sf_off"] = "subway_trains/722/switches/sf_off.mp3"

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

    self.SoundNames["battery_on_1"]   = "subway_trains/722/battery/battery_off_1.mp3"
    self.SoundPositions["battery_on_1"] = {100,1e9,Vector(182,50,-75),0.5}
    self.SoundNames["battery_off_1"]   = "subway_trains/722/battery/battery_off_1.mp3"
    self.SoundPositions["battery_off_1"] = {100,1e9,Vector(182,50,-75),0.5}
    self.SoundNames["battery_off_2"]   = "subway_trains/722/battery/battery_off_2.mp3"
    self.SoundPositions["battery_off_2"] = {100,1e9,Vector(182,50,-75),0.5}
    self.SoundNames["battery_off_stop"]   = "subway_trains/722/battery/battery_off_stop.mp3"
    self.SoundPositions["battery_off_stop"] = {120,1e9,Vector(182,50,-75),0.5}
    self.SoundNames["battery_pneumo"]   = "subway_trains/722/battery/battery_pneumo.mp3"
    self.SoundPositions["battery_pneumo"] = {120,1e9,Vector(182,50,-75),0.1}
    self.SoundNames["battery_off_loop"]   = {loop=true,"subway_trains/722/battery/battery_off_loop.wav"}
    self.SoundPositions["battery_off_loop"] = {100,1e9,Vector(182,50,-75),0.02}

    self.SoundNames["door_alarm"] = "subway_trains/722/door_alarm.mp3"
    self.SoundPositions["door_alarm"] = {800,1e9,Vector(0,0,0),0.5}

    self.SoundNames["door_cab_open"] = "subway_trains/common/door/cab/door_open.mp3"
    self.SoundNames["door_cab_close"] = "subway_trains/common/door/cab/door_close.mp3"

    local function GetDoorPosition(i,k,j)
        if j == 0
        then return Vector(377.0 - 36.0 + 1*(k) - 230*i,-64*(1-2*k),-10)
        else return Vector(377.0 - 36.0 + 1*(k) - 230*i,-64*(1-2*k),-10)
        end
    end
    self.SoundNames["doors"] = "subway_trains/722/door_start.mp3"
    self.SoundNames["doorl"] = {loop=true,"subway_trains/722/door_loop.wav"}
    self.SoundPositions["doors"] = {300,1e9,Vector(0,0,0),0.5}
    self.SoundPositions["doorl"] = {300,1e9,Vector(0,0,0),0.5}
    for i=0,3 do
        for k=0,1 do
            self.SoundNames["door"..i.."x"..k.."c"] = "subway_trains/722/door_close.mp3"
            self.SoundPositions["door"..i.."x"..k.."c"] = {800,1e9,GetDoorPosition(i,k,0),0.2}
        end
    end
    self.SoundNames["door_alarm"] = {"subway_trains/722/door_alarm.mp3"}
    self.SoundPositions["door_alarm"] = {800,1e9,Vector(0,0,0),0.5}
    for i = 1,10 do
        local id1 = Format("b1tunnel_%d",i)
        local id2 = Format("b2tunnel_%d",i)
        self.SoundPositions[id1.."a"] = {700*0.75,1e9,Vector( 317-5,0,-84),1*0.5}
        self.SoundPositions[id1.."b"] = self.SoundPositions[id1.."a"]
        self.SoundPositions[id2.."a"] = {700*0.75,1e9,Vector(-317+0,0,-84),1*0.5}
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

    self:LoadSystem("AsyncInverter","81_722_AsyncInverter")

    self:LoadSystem("BUKV","81_722_BUKV")

    self:LoadSystem("Pneumatic","81_722_Pneumatic")
    --self:LoadSystem("Horn","81_722_Horn")


    self:LoadSystem("Panel","81_724_Panel")

    self:LoadSystem("Announcer","81_71_Announcer", "AnnouncementsSarmatUPO")
    self:LoadSystem("Tickers","81_722_Tickers")
    self:LoadSystem("PassSchemes","81_722_PassScheme")

end

function ENT:PostInitializeSystems()
    self.Electric:TriggerInput("Type",self.Electric.T724)
end

ENT.AnnouncerPositions = {
}
for i=1,4 do
    table.insert(ENT.AnnouncerPositions,{Vector(323-(i-1)*230+37.5,47 ,44),100,0.1})
    table.insert(ENT.AnnouncerPositions,{Vector(323-(i-1)*230,-47,44),100,0.1})
end
---------------------------------------------------
-- Defined train information
-- Types(for wagon limit system):
-- 0 = Head or intherim
-- 1 = Only head
-- 2 = Only intherim
---------------------------------------------------
ENT.SubwayTrain = {
    Type = "81-722",
    Name = "81-723",
    WagType = 2,
    Manufacturer = "MVM",
    EKKType = 722,
}
ENT.NumberRanges = {{24001,24200}}

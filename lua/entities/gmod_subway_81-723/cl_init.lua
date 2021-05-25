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
ENT.AutoAnims = {}
ENT.AutoAnimNames = {}
ENT.ClientSounds = {}
--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false
ENT.ButtonMap["PVZ"] = {
    pos = Vector(-461,28,-12), --446 -- 14 -- -0,5
    ang = Angle(0,90-10,90),
    width = 137,
    height = 450,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "SF31Toggle", x=0+15.15*0,  y=40+167*0, w=15,h=45, tooltip="SF31:Поездной питающий провод"},
        {ID = "1:SF31Toggle", x=0+15.15*1,  y=40+167*0, w=15,h=45, tooltip="SF31:Поездной питающий провод"},
        {ID = "SF32Toggle", x=0+15.15*2,  y=40+167*0, w=15,h=45, tooltip="SF32:Бортовая сеть управление"},
        {ID = "SF33Toggle", x=0+15.15*3,  y=40+167*0, w=15,h=45, tooltip="SF33:Питание цепей управленяи"},
        {ID = "SF34Toggle", x=0+15.15*4,  y=40+167*0, w=15,h=45, tooltip="SF34:ЦИС левый"},
        {ID = "SF35Toggle", x=0+15.15*5,  y=40+167*0, w=15,h=45, tooltip="SF35:ЦИС правый"},
        {ID = "SF36Toggle", x=0+15.15*6,  y=40+167*0, w=15,h=45, tooltip="SF36:Бортовая сигнализация"},
        {ID = "SF37Toggle", x=0+15.15*7,  y=40+167*0, w=15,h=45, tooltip="SF37:Отжатие токоприёмников"},
        {ID = "SF38Toggle", x=0+15.15*8,  y=40+167*0, w=15,h=45, tooltip="SF38:Резерв"},

        {ID = "SF41Toggle", x=0+15.15*0,  y=40+167*1, w=15,h=45, tooltip="SF41:Двери открытие левые"},
        {ID = "SF42Toggle", x=0+15.15*1,  y=40+167*1, w=15,h=45, tooltip="SF42:Двери открытие правые"},
        {ID = "SF43Toggle", x=0+15.15*2,  y=40+167*1, w=15,h=45, tooltip="SF43:Двери закрытие"},
        {ID = "SF44Toggle", x=0+15.15*3,  y=40+167*1, w=15,h=45, tooltip="SF44:Двери торцевые"},
        {ID = "SF45Toggle", x=0+15.15*4,  y=40+167*1, w=15,h=45, tooltip="SF45:Освещение салона питание"},
        {ID = "SF46Toggle", x=0+15.15*5,  y=40+167*1, w=15,h=45, tooltip="SF46:Освещение салона аварийное"},
        {ID = "SF47Toggle", x=0+15.15*6,  y=40+167*1, w=15,h=45, tooltip="SF47:Вентиляция 1 группа"},
        {ID = "SF48Toggle", x=0+15.15*7,  y=40+167*1, w=15,h=45, tooltip="SF48:Вентиляция 2 группа"},
        {ID = "SF49Toggle", x=0+15.15*8,  y=40+167*1, w=15,h=45, tooltip="SF49:Счётчик"},

        {ID = "SF51Toggle", x=0+15.15*0,  y=40+167*2, w=15,h=45, tooltip="SF51:БУВ"},
        {ID = "SF52Toggle", x=0+15.15*1,  y=40+167*2, w=15,h=45, tooltip="SF52:БОДВ"},
        {ID = "SF53Toggle", x=0+15.15*2,  y=40+167*2, w=15,h=45, tooltip="SF53:ПСН"},
        {ID = "SF54Toggle", x=0+15.15*3,  y=40+167*2, w=15,h=45, tooltip="SF54:Осушитель"},
        {ID = "SF55Toggle", x=0+15.15*4,  y=40+167*2, w=15,h=45, tooltip="SF55:БУФТ"},
        {ID = "SF56Toggle", x=0+15.15*5,  y=40+167*2, w=15,h=45, tooltip="SF56:Инвертор инвертор"},
        {ID = "SF57Toggle", x=0+15.15*6,  y=40+167*2, w=15,h=45, tooltip="SF57:Инвертор обогрев"},
        {ID = "SF58Toggle", x=0+15.15*7,  y=40+167*2, w=15,h=45, tooltip="SF58:ЦУВ основное"},
        {ID = "SF59Toggle", x=0+15.15*8,  y=40+167*2, w=15,h=45, tooltip="SF59:ЦУВ резервное"},
    }
}
for i,button in pairs(ENT.ButtonMap.PVZ.buttons) do
    --if button.ID:sub(1,2) == "SF" then
        button.model = {
            model = "models/metrostroi_train/81-722/av1.mdl", z=-8,
            var=button.ID:Replace("Toggle",""):Replace("1:",""),speed=16, ang=Angle(90,0,180),
            min=0, max=1,
            sndvol = 0.4, snd = function(val) return val and "sf_on" or "sf_off" end,
            sndmin = 90, sndmax = 1e3,
        }
    --end
end

ENT.ButtonMap["FrontPneumatic"] = {
    pos = Vector(468.0,-45.0,-58.5),
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
    pos = Vector(449+13, -30+0.5, -69),
    ang = Angle( 15,-90,0),
    hide = 2,30
}
ENT.ClientProps["FrontTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(449+13, 30+0.5, -69),
    ang = Angle(-15,-90,0),
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

    buttons = {
        {ID = "RearBrakeLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip="",var="RbI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
        {ID = "RearTrainLineIsolationToggle",x=500, y=0, w=400, h=100, tooltip="",var="RtI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
    }
}
ENT.ClientProps["RearTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(-450-18, -30, -69),
    ang = Angle(-15,90,0),
    hide = 2,
}
ENT.ClientProps["RearBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(-450-18, 30, -69),
    ang = Angle( 15,90,0),
    hide = 2,
}
ENT.ClientSounds["RearBrakeLineIsolation"] = {{"RearBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["RearTrainLineIsolation"] = {{"RearTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}

ENT.ButtonMap["FrontDoor"] = {
    pos = Vector(462,17,41.3), --28
    ang = Angle(0,-90,90),
    width = 680,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "FrontDoor",x=0,y=0,w=680,h=2000, tooltip="Передняя дверь", model = {
            var="FrontDoor",sndid="door_cab_f",
            sndvol = 1, snd = function(val) return val and "door_cab_open" or "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
ENT.ButtonMap["RearDoor"] = {
    pos = Vector(-468,-17,41.3), --28
    ang = Angle(0,90,90),
    width = 680,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=680,h=2000, tooltip="Задняя дверь", model = {
            var="RearDoor",sndid="door_cab_b",
            sndvol = 1, snd = function(val) return val and "door_cab_open" or "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
for i=0,4 do
    ENT.ClientProps["TrainNumberL"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(60+i*6.6-4*6.6/2,66.3,18),
        ang = Angle(0,180,-5),
        skin=0,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end
for i=0,4 do
    ENT.ClientProps["TrainNumberR"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(53-i*6.6+4*6.6/2,-66.3,18),
        ang = Angle(0,0,-5),
        skin=0,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end
ENT.ClientProps["salon"] = {
    model = "models/metrostroi_train/81-722/723_salon1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["salon2"] = {
    model = "models/metrostroi_train/81-722/723_salon2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["underwagon"] = {
    model = "models/metrostroi_train/81-722/723_underwagon.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
--------------------------------------------------------------------------------
-- Add doors
--------------------------------------------------------------------------------
--[[ local function GetDoorPosition(i,k,j)
    if j == 0
    then return Vector(377.0 - 36.0 + 1*(k) - 230*i,-64*(1-2*k),-10)
    else return Vector(377.0 - 36.0 + 1*(k) - 230*i,-64*(1-2*k),-10)
    end
end
for i=0,3 do
    for k=0,1 do
        ENT.ClientProps["door"..i.."x"..k.."a"] = {
            model = "models/metrostroi_train/81-722/81-722_door_l.mdl",
            pos = GetDoorPosition(i,k,0),
            ang = Angle(0,90 +180*k,0),
            hide = 2,
        }
        ENT.ClientProps["door"..i.."x"..k.."b"] = {
            model = "models/metrostroi_train/81-722/81-722_door_r.mdl",
            pos = GetDoorPosition(i,k,1),
            ang = Angle(0,90 +180*k,0),
            hide = 2,
        }
    end
end--]]
ENT.ClientProps["door0x1"] = {
    model = "models/metrostroi_train/81-722/81-722_doors_pos1.mdl",
    pos = Vector( 341.539,63.171,-11.1),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x1"] = {
    model = "models/metrostroi_train/81-722/81-722_doors_pos2.mdl",
    pos = Vector( 111.38,63.171,-11.1),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x1"] = {
    model = "models/metrostroi_train/81-722/81-722_doors_pos3.mdl",
    pos = Vector(-117.756,63.171,-11.1),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x1"] = {
    model = "models/metrostroi_train/81-722/81-722_doors_pos4.mdl",
    pos = Vector(-348.72,63.171,-11.1),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door0x0"] = {
    model = "models/metrostroi_train/81-722/81-722_doors_pos4.mdl",
    pos = Vector( 341.539,-63.171,-11.1),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x0"] = {
    model = "models/metrostroi_train/81-722/81-722_doors_pos3.mdl",
    pos = Vector( 111.38,-63.171,-11.1),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x0"] = {
    model = "models/metrostroi_train/81-722/81-722_doors_pos2.mdl",
    pos = Vector(-117.756,-63.171,-11.1),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x0"] = {
    model = "models/metrostroi_train/81-722/81-722_doors_pos1.mdl",
    pos = Vector(-348.72,-63.171,-11.1),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door_cab_f"] = {
    model = "models/metrostroi_train/81-722/81-722_door_cab_t.mdl",
    pos = Vector(460.4,-18,-9),
    ang = Angle(0,90,-0.15),
    hide=2,
}
ENT.ClientProps["door_cab_b"] = {
    model = "models/metrostroi_train/81-722/81-722_door_cab_t.mdl",
    pos = Vector(-466.7,18,-9),
    ang = Angle(0,-90,-0.15),
    hide=2,
}

ENT.ClientProps["sarmat"] = {
    model = "models/metrostroi_train/81-722/722_sarmat_l.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 1.5,
    callback = function(ent)
        ent.PassSchemesDone = false
    end,
}
ENT.ClientProps["sarmatr"] = {
    model = "models/metrostroi_train/81-722/722_sarmat_r.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 1.5,
    callback = function(ent)
        ent.PassSchemesDone = false
    end,
}

for i=1,4 do
    ENT.ClientProps["led_l_f"..i] = {
        model = "models/metrostroi_train/81-722/722_led_l_r.mdl",
        pos = Vector((i-1)*9.15,0,0),
        ang = Angle(0,0,0),
        skin=0,
        hideseat = 1.5,
    }
    ENT.ClientProps["led_l_b"..i] = {
        model = "models/metrostroi_train/81-722/722_led_l.mdl",
        pos = Vector(0.1-(i-1)*9.15,0,0),
        ang = Angle(0,0,0),
        skin=0,
        hideseat = 1.5,
    }

    ENT.ClientProps["led_r_f"..i] = {
        model = "models/metrostroi_train/81-722/722_led_r.mdl",
        pos = Vector(-0.2+(i-1)*9.15,0,0),
        ang = Angle(0,0,0),
        skin=0,
        hideseat = 1.5,
    }
    ENT.ClientProps["led_r_b"..i] = {
        model = "models/metrostroi_train/81-722/722_led_r_r.mdl",
        pos = Vector(-0.2-(i-1)*9.15,0,0),
        ang = Angle(0,0,0),
        skin=0,
        hideseat = 1.5,
    }
end

ENT.ClientProps["doorl_l"] = {
    model = "models/metrostroi_train/81-722/722_doorlamp_l.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2,
}
ENT.ClientProps["doorl_r"] = {
    model = "models/metrostroi_train/81-722/722_doorlamp_r.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2,
}

ENT.ClientProps["bortlamp_lsd"] = {
    model = "models/metrostroi_train/81-722/722_bortlamp1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamp_pneumo"] = {
    model = "models/metrostroi_train/81-722/722_bortlamp2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamp_bv"] = {
    model = "models/metrostroi_train/81-722/722_bortlamp3.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide = true,
}

ENT.ClientProps["lamps_salon"] = {
    model = "models/metrostroi_train/81-722/723_lamps_full.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 1.5,
}

ENT.ClientProps["otsek1"] = {
    model = "models/metrostroi_train/81-722/81-722_otsek1.mdl",
    pos = Vector(-454,-54.6,-29.2),
    ang = Angle(0,-90,0),
    hideseat=1.7,
}
ENT.ClientProps["otsek2"] = {
    model = "models/metrostroi_train/81-722/81-722_otsek2.mdl",
    pos = Vector(-454,54.4,-29.2),
    ang = Angle(0,-90,0),
    hideseat=1.7,
}
ENT.ClientProps["otsek3"] = {
    model = "models/metrostroi_train/81-722/81-722_otsek1.mdl",
    pos = Vector(448,54.6,-29.2),
    ang = Angle(0,90,0),
    hideseat=1.7,
}
ENT.ClientProps["otsek4"] = {
    model = "models/metrostroi_train/81-722/81-722_otsek2.mdl",
    pos = Vector(448,-54.4,-29.2),
    ang = Angle(0,90,0),
    hideseat=1.7,
}

ENT.Lights = {
    [10] = { "dynamiclight",    Vector( 430, 0, 40), Angle(0,0,0), Color(255,255,255), brightness = 0.05, distance = 550 },

    -- Interior
    [11] = { "dynamiclight",    Vector( 180+30, 0, -5), Angle(0,0,0), Color(230,230,255), brightness = 3, distance = 260},
    [12] = { "dynamiclight",    Vector( -50+30, 0, -5), Angle(0,0,0), Color(230,230,255), brightness = 3, distance = 260},
    [13] = { "dynamiclight",    Vector(-280+30, 0, -5), Angle(0,0,0), Color(230,230,255), brightness = 3, distance = 260},

    [15] = { "light",Vector(-46.4, 66,28.1)+Vector(0, 0,4.1), Angle(0,0,0), Color(254,254,254), brightness = 0.4, scale = 0.1, texture = "sprites/light_glow02.vmt" },
    [16] = { "light",Vector(-46.4, 66,28.1)+Vector(0, 0.4,-0), Angle(0,0,0), Color(254,210,18), brightness = 0.3, scale = 0.1, texture = "sprites/light_glow02.vmt" },
    [17] = { "light",Vector(-46.4, 66,28.1)+Vector(0, 0.8,-4.1), Angle(0,0,0), Color(40,240,122), brightness = 0.3, scale = 0.1, texture = "sprites/light_glow02.vmt" },
    [18] = { "light",Vector(-46.4,-66,28.1)+Vector(0,-0,4.1), Angle(0,0,0), Color(254,254,254), brightness = 0.4, scale = 0.1, texture = "sprites/light_glow02.vmt" },
    [19] = { "light",Vector(-46.4,-66,28.1)+Vector(0,-0.4,-0), Angle(0,0,0), Color(254,210,18), brightness = 0.3, scale = 0.1, texture = "sprites/light_glow02.vmt" },
    [20] = { "light",Vector(-46.4,-66,28.1)+Vector(0,-0.8,-4.1), Angle(0,0,0), Color(40,240,122), brightness = 0.3, scale = 0.1, texture = "sprites/light_glow02.vmt" },
}

ENT.ButtonMap["Tickers1"] = {
    pos = Vector(-455.4,-11.1,52.8),
    ang = Angle(0,90,90),
    width = 300,
    height = 64,
    scale = 0.094,
    hideseat=1.5,
}
ENT.ButtonMap["Tickers2"] = {
    pos = Vector(2,-11.3,52.5),
    ang = Angle(0,90,90+10),
    width = 300,
    height = 64,
    scale = 0.099,
    hideseat=1.5,
}
ENT.ButtonMap["Tickers3"] = {
    pos = Vector(-5,11.3,52.7),
    ang = Angle(0,-90,90+10),
    width = 300,
    height = 64,
    scale = 0.1,
    hideseat=1.5,
}
ENT.ButtonMap["Tickers4"] = {
    pos = Vector(449.3,11.1,52.8),
    ang = Angle(0,-90,90),
    width = 300,
    height = 64,
    scale = 0.094,
    hideseat=1.5,
}
function ENT:Initialize()
    self.BaseClass.Initialize(self)

    self.Tickers = self:CreateRT("721Tickers",1024,128)

    self.FrontLeak = 0
    self.RearLeak = 0

    self.ReleasedPdT = 0
    self.PreviousCompressorState = false
    self.CompressorVol = 0
    self.ParkingBrake = 0
    self.BPSNBuzzVolume = 0
end
function ENT:UpdateWagonNumber()
    local count = math.max(4,math.ceil(math.log10(self.WagonNumber+1)))
    for i=0,4 do
        --self:ShowHide("TrainNumberL"..i,i<count)
        --self:ShowHide("TrainNumberR"..i,i<count)
        --if i< count then
        local leftNum,rightNum = self.ClientEnts["TrainNumberL"..i],self.ClientEnts["TrainNumberR"..i]
        local num = math.floor(self.WagonNumber%(10^(i+1))/10^i)
        if IsValid(leftNum) then
            leftNum:SetPos(self:LocalToWorld(Vector(60+i*6.6-count*6.6/2,66.3,18)))
            leftNum:SetSkin(num)
        end
        if IsValid(rightNum) then
            rightNum:SetPos(self:LocalToWorld(Vector(53-i*6.6+count*6.6/2,-66.3,18)))
            rightNum:SetSkin(num)
        end
        --end
    end
end
function ENT:Think()
    self.BaseClass.Think(self)
    if not self.RenderClientEnts or self.CreatingCSEnts then
        return
    end

    if not self.PassSchemesDone then
        local sarmat,sarmatr = self.ClientEnts.sarmat,self.ClientEnts.sarmatr
        local scheme = Metrostroi.Skins["722_schemes"] and Metrostroi.Skins["722_schemes"][self.Scheme]
        if IsValid(sarmat) and IsValid(sarmatr) and scheme then
            if self:GetNW2Bool("SarmatInvert") then
                sarmat:SetSubMaterial(0,scheme[2])
                sarmatr:SetSubMaterial(0,scheme[1])
            else
                sarmat:SetSubMaterial(0,scheme[1])
                sarmatr:SetSubMaterial(0,scheme[2])
            end
            self.PassSchemesDone = true
        end
    end

    if self.Scheme ~= self:GetNW2Int("Scheme",1) then
        self.PassSchemesDone = false
        self.Scheme = self:GetNW2Int("Scheme",1)
    end
    if self.InvertSchemes ~= self:GetNW2Bool("SarmatInvert",false) then
        self.PassSchemesDone=false
        self.InvertSchemes = self:GetNW2Bool("SarmatInvert",false)
    end
    
    local passlight = self:GetPackedRatio("SalonLighting")
    self:SetLightPower(11,passlight > 0, passlight)
    self:SetLightPower(12,passlight > 0, passlight)
    self:SetLightPower(13,passlight > 0, passlight)

    local BortLSD,BortPneumo,BortBV = self:GetPackedBool("BortLSD"),self:GetPackedBool("BortPneumo"),self:GetPackedBool("BortBV")
    self:ShowHide("bortlamp_lsd",BortLSD)
    self:ShowHide("bortlamp_pneumo",BortPneumo)
    self:ShowHide("bortlamp_bv",BortBV)
    self:SetLightPower(15,BortLSD,1)
    self:SetLightPower(18,BortLSD,1)
    self:SetLightPower(16,BortPneumo,1)
    self:SetLightPower(19,BortPneumo,1)
    self:SetLightPower(17,BortBV,1)
    self:SetLightPower(20,BortBV,1)

    self:ShowHideSmooth("lamps_salon",self:GetPackedRatio("SalonLighting"))
    self:ShowHide("doorl_l",self:GetPackedBool("DoorAlarmL"))
    self:ShowHide("doorl_r",self:GetPackedBool("DoorAlarmR"))

    self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,1, 3, false)
    self:Animate("FrontTrain",  self:GetNW2Bool("FtI") and 1 or 0,0,1, 3, false)
    self:Animate("RearBrake",   self:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    self:Animate("RearTrain",   self:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)

    local led_back = self:GetPackedBool("PassSchemesLEDO",false)
    if self:GetPackedBool("SarmatInvert",false) then led_back = not led_back end
    local sleft,sright = self:GetPackedBool("SarmatLeft"),self:GetPackedBool("SarmatRight")
    for i=1,4 do
        self:ShowHide("led_l_f"..i,not led_back and sleft)
        self:ShowHide("led_l_b"..i,led_back and sleft)
        self:ShowHide("led_r_f"..i,not led_back and sright)
        self:ShowHide("led_r_b"..i,led_back and sright)
    end
    local scurr = self:GetNW2Int("PassSchemesLED")
    local snext = self:GetNW2Int("PassSchemesLEDN")
    local led = scurr
    if snext ~= 0 and CurTime()%2 > 1 then led = led + snext end
    if scurr < 0 then led = math.floor(CurTime()%16.5*2) end
    if led_back then
        if sleft then
            for i=1,4 do if IsValid(self.ClientEnts["led_l_b"..i]) then self.ClientEnts["led_l_b"..i]:SetSkin(math.Clamp(led-((i-1)*8),0,8)) end end
        end
        if sright then
            for i=1,4 do if IsValid(self.ClientEnts["led_r_b"..i]) then self.ClientEnts["led_r_b"..i]:SetSkin(math.Clamp(led-((i-1)*8),0,8)) end end
        end
    else
        if sleft then
            for i=1,4 do if IsValid(self.ClientEnts["led_l_f"..i]) then self.ClientEnts["led_l_f"..i]:SetSkin(math.Clamp(led-((i-1)*8),0,8)) end end
        end
        if sright then
            for i=1,4 do if IsValid(self.ClientEnts["led_r_f"..i]) then self.ClientEnts["led_r_f"..i]:SetSkin(math.Clamp(led-((i-1)*8),0,8)) end end
        end
    end

    local playL = false
    local playR = false
    for i=0,3 do
        for k=0,1 do
            local st = k==1 and "DoorL" or "DoorR"
            local doorstate = self:GetPackedBool(st)
            local id,sid = st..(i+1),"door"..i.."x"..k
            if not self.DoorStates then self.DoorStates = {} end
            local state = self:GetPackedRatio(id)
            --print(state,self.DoorStates[state])
            if (state ~= 1 and state ~= 0) ~= self.DoorStates[id] then
                if doorstate and state < 1 or not doorstate and state > 0 then
                    --self:PlayOnce("doors","",1,1)
                else
                    self:PlayOnce(sid.."c","",0.15,math.Rand(0.9,1.1))
                end
                self.DoorStates[id] = (state ~= 1 and state ~= 0)
            end
            if (state ~= 1 and state ~= 0) and k==1 then playL = true end
            if (state ~= 1 and state ~= 0) and k==0 then playR = true end
            local n_l = "door"..i.."x"..k--.."a"
            --local n_r = "door"..i.."x"..k.."b"
            self:Animate(n_l,state,0,1, 0.5,false)--0.8 + (-0.2+0.4*math.random()),0)
            --self:Animate(n_r,state,0,1, 0.5,false)--0.8 + (-0.2+0.4*math.random()),0)
        end
    end
    if playL ~= self.LeftDoorState then
        if playL then self:PlayOnce("doors","",0.6,1) end
        self.LeftDoorState = playL
    end
    if playR ~= self.RightDoorState then
        if playR then  self:PlayOnce("doors","",0.6,1) end
        self.RightDoorState = playR
    end
    if playL or playR then
        --if not self:PlayOnce("doors","",1,1)
        self.DoorSoundState = math.Clamp((self.DoorSoundState or 0) + 0.75*self.DeltaTime,0,0.5)
    else
        self.DoorSoundState = math.Clamp((self.DoorSoundState or 0) - 0.5*self.DeltaTime,0,0.5)
    end
    --print(self.DoorSoundState)
    self:SetSoundState("doorl",self.DoorSoundState or 0,1)


    local door_f = self:GetPackedBool("FrontDoor")
    local door_b = self:GetPackedBool("RearDoor")
    local door_cab_f = self:Animate("door_cab_f",door_f and 1 or -0.05,1,0.75, 8, 0.05)
    local door_cab_b = self:Animate("door_cab_b",door_b and 1 or -0.05,1,0.75, 8, 0.05)

    local door1s = (door_cab_f < 1 or door_f)
    if self.Door1 ~= door1s then
        self.Door1 = door1s
        self:PlayOnce("FrontDoor","bass",door1s and 1 or 0)
    end
    local door2s = (door_cab_b < 1 or door_b)
    if self.Door2 ~= door2s then
        self.Door2 = door2s
        self:PlayOnce("RearDoor","bass",door2s and 1 or 0)
    end

    local dT = self.DeltaTime

    self.FrontLeak = math.Clamp(self.FrontLeak + 10*(-self:GetPackedRatio("FrontLeak")-self.FrontLeak)*dT,0,1)
    self.RearLeak = math.Clamp(self.RearLeak + 10*(-self:GetPackedRatio("RearLeak")-self.RearLeak)*dT,0,1)
    self:SetSoundState("front_isolation",self.FrontLeak,0.9+0.2*self.FrontLeak)
    self:SetSoundState("rear_isolation",self.RearLeak,0.9+0.2*self.RearLeak)

    local parking_brake = math.max(0,-self:GetPackedRatio("ParkingBrakePressure_dPdT",0))
    self.ParkingBrake = self.ParkingBrake+(parking_brake-self.ParkingBrake)*dT*10
    self:SetSoundState("parking_brake",self.ParkingBrake,1.4)

    local dPdT = self:GetPackedRatio("BrakeCylinderPressure_dPdT")
    self.ReleasedPdT = math.Clamp(self.ReleasedPdT + 4*(-self:GetPackedRatio("BrakeCylinderPressure_dPdT",0)-self.ReleasedPdT)*dT,0,1)
    --print(dPdT)
    self:SetSoundState("release",math.Clamp(self.ReleasedPdT,0,1)^1.65,1.0)


    local state = self:GetPackedBool("CompressorWork")
    --self.PreviousCompressorState = self.PreviousCompressorState or false
    if self.CompressorVol < 1 and state then
        self.CompressorVol = math.min(1,self.CompressorVol + 5*dT)
    elseif self.CompressorVol > 0 and not state then
        self.CompressorVol = math.max(0,self.CompressorVol - 3*dT)
    end
    --if state then
        self:SetSoundState("compressor",self.CompressorVol,0.8+0.2*self.CompressorVol)
    --else
        --[[if not state and self.PreviousCompressorState ~= state then
            self:PlayOnce("compressor_pn","cabin",1,1)
        end]]
        --self:SetSoundState("compressor",0,0)
    --end
    self.PreviousCompressorState = state
    local rollingi = math.min(1,self.TunnelCoeff+math.Clamp((self.StreetCoeff-0.82)/0.5,0,1))
    local rollings = math.max(self.TunnelCoeff*0.6,self.StreetCoeff)
    local tunstreet = (rollingi+rollings*0.2)
    local speed = self:GetPackedRatio("Speed", 0)
    local rol10 = math.Clamp(speed/25,0,1)*(1-math.Clamp((speed-25)/8,0,1))
    local rol45 = math.Clamp((speed-23)/8,0,1)*(1-math.Clamp((speed-50)/8,0,1))
    local rol45p = Lerp((speed-25)/25,0.8,1)
    local rol60 = math.Clamp((speed-50)/8,0,1)*(1-math.Clamp((speed-65)/5,0,1))
    local rol60p = Lerp((speed-50)/15,0.8,1)
    local rol70 = math.Clamp((speed-65)/5,0,1)
    local rol70p = Lerp((speed-65)/25,0.8,1.2)
    self:SetSoundState("rolling_10",rollingi*rol10,1)
    self:SetSoundState("rolling_45",rollingi*rol45,1)
    self:SetSoundState("rolling_60",rollingi*rol60,1)
    self:SetSoundState("rolling_70",rollingi*rol70,1)


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

    local state = self:GetPackedRatio("asynccurrent")--^1.5--RealTime()%2.5/2
    local strength = self:GetPackedRatio("asyncstate")*(1-math.Clamp((speed-15)/15,0,1))
    self:SetSoundState("test_async1", tunstreet*math.Clamp(state/0.5,0,1)*strength, 0.6+math.Clamp(state,0,1)*0.4)
    self:SetSoundState("test_async1_2",tunstreet*math.Clamp((state-0.75)/0.05,0,1)*strength, 0.6+math.Clamp((state-0.8)/0.2,0,1)*0.14)
    self:SetSoundState("test_async1_3",tunstreet*math.Clamp((state-0.7)/0.1,0,1)*strength, 0.87)
    self:SetSoundState("test_async2", tunstreet*math.Clamp(math.max(0,state/0.5),0,1)*strength, 0.55+math.Clamp(state,0,1)*0.45)
    self:SetSoundState("test_async3", tunstreet*math.Clamp(math.max(0,(state-0.7)/0.1),0,1)*strength, 1)
    self:SetSoundState("test_async3_2", tunstreet*math.Clamp((state-0.415)/0.1,0,1)*(1-math.Clamp((state-1.1)/0.3,0,0.5))*strength, 0.48+math.Clamp(state,0,1)*0.72)
    self:SetSoundState("battery_off_loop", self:GetPackedBool("BattPressed") and 1 or 0,1)
    self:SetSoundState("async_p2", tunstreet*(math.Clamp((speed-5)/5,0,1)*0.1+math.Clamp((speed-40)/10,0,1)*0.9)*(1-math.Clamp((speed-27)/4,0,1))*self:GetPackedRatio("asyncstate"), speed/36)
    self:SetSoundState("async_p3", tunstreet*(math.Clamp((speed-7)/5,0,1)*0.1+math.Clamp((speed-17)/10,0,1)*0.9)*(1-math.Clamp((speed-30)/4,0,1))*self:GetPackedRatio("asyncstate"), speed/42)
    self:SetSoundState("engine_loud", tunstreet*math.Clamp((speed-10)/15,0,1)*(1-math.Clamp((speed-30)/40,0,0.6))*self:GetPackedRatio("asyncstate"), speed/20)
    self:SetSoundState("chopper", tunstreet*self:GetPackedRatio("chopper"), 1)

    local work = self:GetPackedBool("AnnPlay")
    local UPO = work and self:GetPackedBool("AnnPlayUPO")

    local noise = self:GetNW2Int("AnnouncerNoise", -1)
    local volume = self:GetNW2Float("UPOVolume",1)
    local noisevolume = self:GetNW2Float("UPONoiseVolume",1)
    local buzzvolume = volume
    if self.Sounds["announcer1"] and IsValid(self.Sounds["announcer1"]) then buzzvolume = UPO and (1-(self.Sounds["announcer1"]:GetLevel())*math.Rand(0.9,3))*buzzvolume*2 or 0 end
    if self.BPSNBuzzVolume > buzzvolume then
        self.BPSNBuzzVolume = math.Clamp(self.BPSNBuzzVolume + 8*(buzzvolume-self.BPSNBuzzVolume)*dT,0.1,1)
    else
        self.BPSNBuzzVolume = math.Clamp(self.BPSNBuzzVolume + 0.4*(buzzvolume-self.BPSNBuzzVolume)*dT,0.1,1)
    end

    for k,v in ipairs(self.AnnouncerPositions) do
        self:SetSoundState("announcer_noiseW"..k,UPO and noisevolume*volume*0.7 or 0,1)
        for i=1,3 do
            self:SetSoundState(Format("announcer_noise%d_%d",i,k),(UPO and i==noise) and volume*self.BPSNBuzzVolume*self:GetNW2Float("UPOBuzzVolume",1)*0.7 or 0,1)
        end

        if IsValid(self.Sounds["announcer"..k]) then self.Sounds["announcer"..k]:SetVolume(work and v[3]*(UPO and volume or 1) or 0) end
    end
end

function ENT:OnAnnouncer(volume)
    local work = self:GetPackedBool("AnnPlay")
    local UPO = work and self:GetPackedBool("AnnPlayUPO")

    return work and volume*(UPO and self:GetNW2Float("UPOVolume",1) or 1) or 0
end

function ENT:Draw()
    self.BaseClass.Draw(self)
end

function ENT:DrawPost()
    self.RTMaterial:SetTexture("$basetexture", self.Tickers)
    surface.SetMaterial(self.RTMaterial)
    surface.SetDrawColor(255,255,255)
    for i=1,4 do
        self:DrawOnPanel("Tickers"..i,function(...)
            if (i==2 or i==3) then
                surface.DrawTexturedRectRotated(245,32,490,64,0)
            else
                surface.DrawTexturedRectRotated(256,32,512,64,0)
            end
        end)
    end
end
function ENT:OnButtonPressed(button)
end

function ENT:OnPlay(soundid,location,range,pitch)
    if location == "stop" then
        if IsValid(self.Sounds[soundid]) then
            self.Sounds[soundid]:Pause()
            self.Sounds[soundid]:SetTime(0)
        end
        return
    end
    if soundid == "BatteryOn" and range > 0 then
        return "battery_on_1",location,1,pitch
    end
    if soundid == "BatteryOff" then
        return range > 0 and "battery_off_1" or "battery_off_2",location,1,pitch
    end
    return soundid,location,range,pitch
end

local dist = {}
for id,panel in pairs(ENT.ButtonMap) do
    if not panel.buttons then continue end
    for k,v in pairs(panel.buttons) do
        if v.model then
            local dist = dist[id] or 150
            if v.model.model then
                v.model.hideseat=dist
            elseif v.model.lamp then
                v.model.lamp.hideseat=dist
            end
        end
    end
end
Metrostroi.GenerateClientProps()
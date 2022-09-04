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
    pos = Vector(450,53,-12), --446 -- 14 -- -0,5
    ang = Angle(0,-90+10,90),
    width = 330,
    height = 350,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "SFV1Toggle",x=0*30, y=0, w=30,h=50, tooltip = "SF1: Питание цепей управления вагона",},
        {ID = "SFV2Toggle",x=1*30, y=0, w=30,h=50, tooltip = "SF2: Питание БУВ",},
        {ID = "SFV3Toggle",x=2*30, y=0, w=30,h=50, tooltip = "SF3: Питание БУТП",},
        {ID = "SFV4Toggle",x=3*30, y=0, w=30,h=50, tooltip = "SF4: БУТП Управление",},
        {ID = "SFV5Toggle",x=4*30, y=0, w=30,h=50, tooltip = "SF5: БУТП Управление резервное",},
        {ID = "SFV6Toggle",x=5*30, y=0, w=30,h=50, tooltip = "SF6: БУТП Питание",},
        {ID = "SFV7Toggle",x=6*30, y=0, w=30,h=50, tooltip = "SF7: ББЭ",},
        {ID = "SFV8Toggle",x=7*30, y=0, w=30,h=50, tooltip = "SF8: БВ управление",},
        {ID = "SFV9Toggle",x=8*30, y=0, w=30,h=50, tooltip = "SF9: БВ питание",},
        {ID = "SFV10Toggle",x=9*30, y=0, w=30,h=50, tooltip = "SF10: ППО",},
        {ID = "SFV11Toggle",x=10*30, y=0, w=30,h=50, tooltip = "SF11: Мотор-компрессор"},

        {ID = "SFV12Toggle",x=0*30, y=150, w=30,h=50, tooltip = "SF12: Двери закрытие",},
        {ID = "SFV13Toggle",x=1*30, y=150, w=30,h=50, tooltip = "SF13: Двери открытие левых",},
        {ID = "SFV14Toggle",x=2*30, y=150, w=30,h=50, tooltip = "SF14: Двери открытие правых",},
        {ID = "SFV15Toggle",x=3*30, y=150, w=30,h=50, tooltip = "SF15: Двери торцевые",},
        {ID = "SFV16Toggle",x=4*30, y=150, w=30,h=50, tooltip = "SF16: Оповещение",},
        {ID = "SFV17Toggle",x=5*30, y=150, w=30,h=50, tooltip = "SF17: Экстренная связь",},
        {ID = "SFV18Toggle",x=6*30, y=150, w=30,h=50, tooltip = "SF18: Резерв",},
        {ID = "SFV19Toggle",x=7*30, y=150, w=30,h=50, tooltip = "SF19: Освещение салона питание",},
        {ID = "SFV20Toggle",x=8*30, y=150, w=30,h=50, tooltip = "SF20: Освещение салона аварийное",},
        {ID = "SFV21Toggle",x=9*30, y=150, w=30,h=50, tooltip = "SF21: Датчик скорости",},
        {ID = "SFV22Toggle",x=10*30, y=150, w=30,h=50, tooltip = "SF22: Тормоз стояночный"},

        {ID = "SFV23Toggle",x=0*30, y=300, w=30,h=50, tooltip = "SF23: Вентиляция управление 1-я группа",},
        {ID = "SFV24Toggle",x=1*30, y=300, w=30,h=50, tooltip = "SF24: Вентиляция управление 2-я группа",},
        {ID = "SFV25Toggle",x=2*30, y=300, w=30,h=50, tooltip = "SF25: Вентиляция питание 1-я группа",},
        {ID = "SFV26Toggle",x=3*30, y=300, w=30,h=50, tooltip = "SF26: Вентиляция питание 2-я группа",},
        {ID = "SFV27Toggle",x=4*30, y=300, w=30,h=50, tooltip = "SF27: Питание возбудителя FIXME",},
        {ID = "SFV28Toggle",x=5*30, y=300, w=30,h=50, tooltip = "SF28: Питание ЗКК FIXME",},
        {ID = "SFV29Toggle",x=6*30, y=300, w=30,h=50, tooltip = "SF29: Токоприёмники",},
        {ID = "SFV30Toggle",x=7*30, y=300, w=30,h=50, tooltip = "SF30: Табло",},
        {ID = "SFV31Toggle",x=8*30, y=300, w=30,h=50, tooltip = "SF31: Резерв",},
        {ID = "SFV32Toggle",x=9*30, y=300, w=30,h=50, tooltip = "SF32: Резерв",},
        {ID = "SFV33Toggle",x=10*30, y=300, w=30,h=50, tooltip = "SF33: Резерв"},
    }
}
for k,buttbl in ipairs(ENT.ButtonMap["PVZ"].buttons) do
    buttbl.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",z=-16, ang=-90,
        var=buttbl.ID:Replace("Toggle",""),speed=9, vmin=0,vmax=1,
        sndvol = 0.8, snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
    }
end

ENT.ButtonMap["Battery"] = {
    pos = Vector(455,19.1,-11.5), --446 -- 14 -- -0,5
    ang = Angle(0,0,90),
    width = 80,
    height = 80,
    scale = 0.0625,

    buttons = {
        {ID = "BatteryToggle",x=0, y=0, w=80,h=80   , tooltip = "Батарея", model = {
            model = "models/metrostroi_train/81-717/battery_enabler.mdl",
            var="Battery",speed=0.5,vmin=1,vmax=0.8,
            sndvol = 0.8, snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["RearDoor"] = {
    pos = Vector(-465,16-32,42),
    ang = Angle(0,90,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=642,h=2000, tooltip="Задняя дверь\nRear door", model = {
            var="RearDoor",sndid="door_cab_b",
            sndvol = 1, snd = function(val) return val and "door_cab_open" or "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}


ENT.ButtonMap["FrontPneumatic"] = {
    pos = Vector(470-9+5,-42,-58.0+5-6),
    ang = Angle(0,90,90),
    width = 800,
    height = 100,
    scale = 0.1,

    buttons = {
        {ID = "FrontBrakeLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip="",var="FbI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
        {ID = "FrontTrainLineIsolationToggle",x=400, y=0, w=400, h=100, tooltip="",var="FtI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
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
    pos = Vector(-473-0.5+4,42,-58.0+5-6),
    ang = Angle(0,270,90),
    width = 800,
    height = 100,
    scale = 0.1,

    buttons = {
        {ID = "RearBrakeLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip="",var="RbI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
        {ID = "RearTrainLineIsolationToggle",x=400, y=0, w=400, h=100, tooltip="",var="RtI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
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
    pos = Vector(462,16.5,42),
    ang = Angle(0,-90,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "FrontDoor",x=0,y=0,w=642,h=2000, tooltip="Передняя дверь\nFront door", model = {
            var="FrontDoor",sndid="door_cab_f",
            sndvol = 1, snd = function(val) return val and "door_cab_open" or "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
for i=0,3 do
    ENT.ClientProps["TrainNumberL"..i] = {
        model = "models/metrostroi_train/81-714_mmz/bortnumber_" .. i .. ".mdl",
        pos = Vector(57+i*6.6-4*6.6/2,66.3,18),
        ang = Angle(-5,90,0),
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end
for i=0,3 do
    ENT.ClientProps["TrainNumberR"..i] = {
        model = "models/metrostroi_train/81-714_mmz/bortnumber_" .. i .. ".mdl",
        pos = Vector(61+i*6.6-4*6.6/2,-66.3,18),
        ang = Angle(-5,270,0),
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end
ENT.ButtonMap["Tickers"] = {
    pos = Vector(-460.5,-31.5,54.8), --446 -- 14 -- -0,5
    ang = Angle(0,90,90),
    width = 852,
    height = 64,
    scale = 0.074,
    hide=true,
    hideseat=1,
}
ENT.ClientProps["salon"] = {
    model = "models/metrostroi_train/81-720/721_salon.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=1.5,
}
ENT.ClientProps["underwagon"] = {
    model = "models/metrostroi_train/81-720/721_underwagon.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=1,
}
ENT.ClientProps["tickers"] = {
    model = "models/metrostroi_train/81-720/720_tablo.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=1.5,
}
ENT.ClientProps["lamps_emer"] = {
    model = "models/metrostroi_train/81-720/720_lamps_emer.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(245,238,223),
    hide=1.5,
}
ENT.ClientProps["lamps_full"] = {
    model = "models/metrostroi_train/81-720/720_lamps_full.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(245,238,223),
    hide=1.5,
}
ENT.ClientProps["PassSchemes"] = {
    model = "models/metrostroi_train/81-720/720_sarmat_l.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=1.5,
    callback = function(ent)
        ent.PassSchemesDone = false
    end,
}
ENT.ClientProps["PassSchemesR"] = {
    model = "models/metrostroi_train/81-720/720_sarmat_r.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=1.5,
    callback = function(ent)
        ent.PassSchemesDone = false
    end,
}
for i=1,5 do
    ENT.ClientProps["led_l_f"..i] = {
        model = "models/metrostroi_train/81-720/720_led_l_r.mdl",
        pos = Vector((i-1)*10.5+0.2,0,0),
        ang = Angle(0,0,0),
        skin=6,
        hideseat = 1.5,
    }
    ENT.ClientProps["led_l_b"..i] = {
        model = "models/metrostroi_train/81-720/720_led_l.mdl",
        pos = Vector(-(i-1)*10.5-0.2,0,0),
        ang = Angle(0,0,0),
        skin=6,
        hideseat = 1.5,
    }

    ENT.ClientProps["led_r_f"..i] = {
        model = "models/metrostroi_train/81-720/720_led_r.mdl",
        pos = Vector((i-1)*10.5+0.2,0,0),
        ang = Angle(0,0,0),
        skin=6,
        hideseat = 1.5,
    }

    ENT.ClientProps["led_r_b"..i] = {
        model = "models/metrostroi_train/81-720/720_led_r_r.mdl",
        pos = Vector(-(i-1)*10.5-0.2,0,0),
        ang = Angle(0,0,0),
        skin=6,
        hideseat = 1.5,
    }
end
ENT.ButtonMap["GV"] = {
    pos = Vector(128,63,-52-15),
    ang = Angle(0,180,90),
    width = 170,
    height = 150,
    scale = 0.1,
    buttons = {
        {ID = "GVToggle",x=0, y=0, w= 170,h = 150, tooltip="Разъединитель БРУ (ГВ)", model = {
            var="GV",sndid = "gv_wrench",
            sndvol = 0.8,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            snd = function(val) return val and "gv_f" or "gv_b" end,
            states={"Train.Buttons.Disconnected","Train.Buttons.On"}
        }},
    }
}
ENT.ClientProps["gv_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = Vector(126.4,50,-60-23.5),
    ang = Angle(-90,0,0),
    hide = 0.5,
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
            model = "models/metrostroi_train/81-720/81-720_door_l.mdl",
            pos = GetDoorPosition(i,k,0),
            ang = Angle(0,90 +180*k,0),
            hide = 2,
        }
        ENT.ClientProps["door"..i.."x"..k.."b"] = {
            model = "models/metrostroi_train/81-720/81-720_door_r.mdl",
            pos = GetDoorPosition(i,k,1),
            ang = Angle(0,90 +180*k,0),
            hide = 2,
        }
    end
end--]]

ENT.ClientProps["door0x1"] = {
    model = "models/metrostroi_train/81-720/81-720_doors_pos1.mdl",
    pos = Vector( 341.539,63.171,-11.1),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x1"] = {
    model = "models/metrostroi_train/81-720/81-720_doors_pos2.mdl",
    pos = Vector( 111.38,63.171,-11.1),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x1"] = {
    model = "models/metrostroi_train/81-720/81-720_doors_pos3.mdl",
    pos = Vector(-117.756,63.171,-11.1),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x1"] = {
    model = "models/metrostroi_train/81-720/81-720_doors_pos4.mdl",
    pos = Vector(-348.72,63.171,-11.1),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door0x0"] = {
    model = "models/metrostroi_train/81-720/81-720_doors_pos4.mdl",
    pos = Vector( 341.539,-63.171,-11.1),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x0"] = {
    model = "models/metrostroi_train/81-720/81-720_doors_pos3.mdl",
    pos = Vector( 111.38,-63.171,-11.1),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x0"] = {
    model = "models/metrostroi_train/81-720/81-720_doors_pos2.mdl",
    pos = Vector(-117.756,-63.171,-11.1),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x0"] = {
    model = "models/metrostroi_train/81-720/81-720_doors_pos1.mdl",
    pos = Vector(-348.72,-63.171,-11.1),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door_cab_f"] = {
    model = "models/metrostroi_train/81-720/720_door_tor.mdl",
    pos = Vector(462,-17,-10),
    ang = Angle(0,89,0),
    hide=2
}
ENT.ClientProps["door_cab_b"] = {
    model = "models/metrostroi_train/81-720/720_door_tor.mdl",
    pos = Vector(-466.2,17,-10),
    ang = Angle(0,-91,-0.15),
    hide=2
}

local yventpos = {
    -414.5+0*117,
    -414.5+1*117+6.2,
    -414.5+2*117+5,
    -414.5+3*117+2,
    -414.5+4*117+0.5,
    -414.5+5*117-2.3,
    -414.5+6*117-2.3,
    -414.5+7*117+4,
}
for i=1,8 do
    ENT.ClientProps["vent"..i] = {
        model = "models/metrostroi_train/81-720/vent.mdl",
        pos = Vector(yventpos[i],0,57.2),
        ang = Angle(0,0,0),
        hideseat=0.8,
    }
end
ENT.Lights = {
    -- Interior
    [15] = { "dynamiclight",    Vector(-330, 0, 10), Angle(0,0,0), Color(238,238,197), brightness = 0.5, distance = 500, fov=180,farz = 128 },
    [16] = { "dynamiclight",    Vector(-0, 0, 10), Angle(0,0,0), Color(238,238,197), brightness = 0.5, distance = 500, fov=180,farz = 128 },
    [17] = { "dynamiclight",    Vector( 330, 0, 10), Angle(0,0,0), Color(238,238,197), brightness = 0.5, distance = 500, fov=180,farz = 128 },
}

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.Tickers = self:CreateRT("721Ticker",1024,64)
    render.PushRenderTarget(self.Tickers,0,0,1024, 64)
    render.Clear(0, 0, 0, 0)
    render.PopRenderTarget()
    self.ReleasedPdT = 0
    self.PreviousCompressorState = false
    self.CompressorVol = 0
    self.TISUVol = 0

    self.FrontLeak = 0
    self.RearLeak = 0

    self.ParkingBrake = 0

    self.VentRand = {}
    self.VentState = {}
    self.VentVol = {}
    for i=1,8 do
    self.VentRand[i] = math.Rand(0.5,2)
    self.VentState[i] = 0
    self.VentVol[i] = 0
    end
end
local bortnumber_format = "models/metrostroi_train/81-714_mmz/bortnumber_%d.mdl"
function ENT:UpdateWagonNumber()
    for i=0,3 do
        --self:ShowHide("TrainNumberL"..i,i<count)
        --self:ShowHide("TrainNumberR"..i,i<count)
        --if i< count then
            local num = math.floor(self.WagonNumber%(10^(i+1))/10^i)
            local leftNum,rightNum = self.ClientEnts["TrainNumberL"..i],self.ClientEnts["TrainNumberR"..i]
            if IsValid(leftNum) then
                leftNum:SetPos(self:LocalToWorld(Vector(60+i*6.6-4*6.6/2,66.3,18)))
                leftNum:SetModel(Format(bortnumber_format, num))
            end
            if IsValid(rightNum) then
                rightNum:SetPos(self:LocalToWorld(Vector(53-i*6.6+4*6.6/2,-66.3,18)))
                rightNum:SetModel(Format(bortnumber_format, num))
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
        local sarmat = self.ClientEnts.PassSchemes
        local sarmatr = self.ClientEnts.PassSchemesR
        local scheme = Metrostroi.Skins["720_schemes"] and Metrostroi.Skins["720_schemes"][self.Scheme]
        if IsValid(sarmat) and IsValid(sarmatr) and scheme then
            if self:GetNW2Bool("PassSchemesInvert") then
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
    if self.InvertSchemes ~= self:GetNW2Bool("PassSchemesInvert",false) then
        self.PassSchemesDone=false
        self.InvertSchemes = self:GetNW2Bool("PassSchemesInvert",false)
    end
    
    local passlight = self:GetPackedRatio("SalonLighting")
    self:SetLightPower(15,passlight > 0, passlight)
    self:SetLightPower(16,passlight > 0, passlight)
    self:SetLightPower(17,passlight > 0, passlight)

    if self.LastGVValue ~= self:GetPackedBool("GV") then
        self.ResetTime = CurTime()+1.5
        self.LastGVValue = self:GetPackedBool("GV")
    end
    self:Animate("gv_wrench",self.LastGVValue and 1 or 0,0.5,1,128,1,false)
    self:ShowHideSmooth("gv_wrench",    CurTime() < self.ResetTime and 1 or 0.1)

    local dT = self.DeltaTime

    local parking_brake = math.max(0,-self:GetPackedRatio("ParkingBrakePressure_dPdT",0))
    self.ParkingBrake = self.ParkingBrake+(parking_brake-self.ParkingBrake)*dT*10
    self:SetSoundState("parking_brake",self.ParkingBrake,1.4)

    local dPdT = self:GetPackedRatio("BrakeCylinderPressure_dPdT")
    self.ReleasedPdT = math.Clamp(self.ReleasedPdT + 4*(-self:GetPackedRatio("BrakeCylinderPressure_dPdT",0)-self.ReleasedPdT)*dT,0,1)
    --print(dPdT)
    self:SetSoundState("release",math.Clamp(self.ReleasedPdT,0,1)^1.65,1.0)

    self:ShowHideSmooth("lamps_emer",self:Animate("LampsEmer",self:GetPackedRatio("SalonLighting") == 0.4 and 1 or 0,0,1,5,false))
    self:ShowHideSmooth("lamps_full",self:Animate("LampsFull",self:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,1,5,false))

    self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,1, 3, false)
    self:Animate("FrontTrain",  self:GetNW2Bool("FtI") and 1 or 0,0,1, 3, false)
    self:Animate("RearBrake",   self:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    self:Animate("RearTrain",   self:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)

    local scurr = self:GetNW2Int("PassSchemesLED")
    local snext = self:GetNW2Int("PassSchemesLEDN")
    local led_back = self:GetPackedBool("PassSchemesLEDO",false)
    if self:GetPackedBool("PassSchemesInvert",false)  then led_back = not led_back end
    local ledwork = scurr~=0 or snext~=0
    for i=1,5 do
        self:ShowHide("led_l_f"..i,not led_back and ledwork)
        self:ShowHide("led_l_b"..i,led_back and ledwork)
        self:ShowHide("led_r_f"..i,not led_back and ledwork)
        self:ShowHide("led_r_b"..i,led_back and ledwork)
    end
    local led = scurr
    if snext ~= 0 and CurTime()%.5 > .25 then led = led + snext end
    if scurr < 0 then led = math.floor(CurTime()%5*6.2) end
    if led_back then
        if ledwork then
            for i=1,5 do
                if IsValid(self.ClientEnts["led_l_b"..i]) then self.ClientEnts["led_l_b"..i]:SetSkin(math.Clamp(led-((i-1)*6),0,6)) end
                if IsValid(self.ClientEnts["led_r_b"..i]) then self.ClientEnts["led_r_b"..i]:SetSkin(math.Clamp(led-((i-1)*6),0,6)) end
            end
        end
    else
        if ledwork then
            for i=1,5 do
                if IsValid(self.ClientEnts["led_l_f"..i]) then self.ClientEnts["led_l_f"..i]:SetSkin(math.Clamp(led-((i-1)*6),0,6)) end
                if IsValid(self.ClientEnts["led_r_f"..i]) then self.ClientEnts["led_r_f"..i]:SetSkin(math.Clamp(led-((i-1)*6),0,6)) end
            end
        end
    end
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
                        self:PlayOnce(sid.."o","",1,math.Rand(0.9,1.1))
                    else
                        self:PlayOnce(sid.."c","",1,math.Rand(0.9,1.1))
                    end
                end
                self.DoorStates[id] = (state ~= 1 and state ~= 0)
            end
            if (state ~= 1 and state ~= 0) then
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) + 2*self.DeltaTime,0,1)
            else
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) - 6*self.DeltaTime,0,1)
            end
            self:SetSoundState(sid.."r",self.DoorLoopStates[id],0.9+self.DoorLoopStates[id]*0.1)
            local n_l = "door"..i.."x"..k--.."a"
            --local n_r = "door"..i.."x"..k.."b"
            local dlo = 1
            --local dro = 1
            if self.Anims[n_l] then
                dlo = math.abs(state-(self.Anims[n_l] and self.Anims[n_l].oldival or 0))
                if dlo <= 0 and self.Anims[n_l].oldspeed then dlo = self.Anims[n_l].oldspeed/15 end
            end
            --[[ if self.Anims[n_r] then
                dro = math.abs(state-self.Anims[n_r].oldival)
                if dro <= 0 and self.Anims[n_r].oldspeed then dro = self.Anims[n_r].oldspeed/15 end
            end--]]
            self:Animate(n_l,state,0.02,1, dlo*15,false)--0.8 + (-0.2+0.4*math.random()),0)
            --self:Animate(n_r,state,0,1, dro*15,false)--0.8 + (-0.2+0.4*math.random()),0)
        end
    end
    local door_f = self:GetPackedBool("FrontDoor")
    local door_b = self:GetPackedBool("RearDoor")
    local door_cab_f = self:Animate("door_cab_f",door_f and 1 or -0.05,0,0.235, 8, 0.05)
    local door_cab_b = self:Animate("door_cab_b",door_b and 1 or -0.05,0,0.25, 8, 0.05)

    local door1s = (door_cab_f > 0 or door_f)
    if self.Door1 ~= door1s then
        self.Door1 = door1s
        self:PlayOnce("FrontDoor","bass",door1s and 1 or 0)
    end
    local door2s = (door_cab_b > 0 or door_b)
    if self.Door2 ~= door2s then
        self.Door2 = door2s
        self:PlayOnce("RearDoor","bass",door2s and 1 or 0)
    end

    local speed = self:GetPackedRatio("Speed", 0)

    local ventSpeedAdd = math.Clamp(speed/30,0,1)

    local v1state = self:GetPackedBool("Vent1Work")
    local v2state = self:GetPackedBool("Vent2Work")
    for i=1,8 do
        local rand = self.VentRand[i]
        local vol = self.VentVol[i]
        local even = i%2 == 0
        local work = (even and v1state or not even and v2state)
        local target = math.min(1,(work and 1 or 0)+ventSpeedAdd*rand*0.4)*2
        if self.VentVol[i] < target then
            self.VentVol[i] = math.min(target,vol + dT/1.5*rand)
        elseif self.VentVol[i] > target then
            self.VentVol[i] = math.max(0,vol - dT/8*rand*(vol*0.3))
        end
        self.VentState[i] = (self.VentState[i] + 10*((self.VentVol[i]/2)^3)*dT)%1
        local vol1 = math.max(0,self.VentVol[i]-1)
        local vol2 = math.max(0,(self.VentVol[i-1] or self.VentVol[i+1])-1)
        self:SetSoundState("vent"..i,vol1*(0.7+vol2*0.3),0.5+0.5*vol1+math.Rand(-0.01,0.01))
        if IsValid(self.ClientEnts["vent"..i]) then
            self.ClientEnts["vent"..i]:SetPoseParameter("position",self.VentState[i])
        end
    end
    self:SetSoundState("compressor",self:GetPackedBool("CompressorWork") and 1 or 0,1)

    local speed = self:GetPackedRatio("Speed", 0)
    --local rol10 = math.Clamp(speed/5,0,1)*(1-math.Clamp((speed-50)/8,0,1))
    --local rol70 = math.Clamp((speed-50)/8,0,1)
    local rollingi = math.min(1,self.TunnelCoeff+math.Clamp((self.StreetCoeff-0.82)/0.5,0,1))
    local rollings = math.max(self.TunnelCoeff*0.6,self.StreetCoeff)
    local rol10 = math.Clamp(speed/12,0,1)*(1-math.Clamp((speed-20)/12,0,1))
    local rol10p = Lerp((speed-12)/12,0.9,1.1)
    local rol30 = math.Clamp((speed-20)/12,0,1)*(1-math.Clamp((speed-40)/12,0,1))
    local rol30p = Lerp((speed-15)/30,0.8,1.2)
    local rol55 = math.Clamp((speed-40)/12,0,1)*(1-math.Clamp((speed-65)/15,0,1))
    local rol55p = Lerp(0.8+(speed-43)/24,0.8,1.2)
    local rol75 = math.Clamp((speed-65)/15,0,1)
    local rol75p = Lerp(0.8+(speed-67)/16,0.8,1.2)
    self:SetSoundState("rolling_10",rollingi*rol10,rol10p)
    self:SetSoundState("rolling_30",rollingi*rol30,rol30p)
    self:SetSoundState("rolling_55",rollingi*rol55,rol55p)
    self:SetSoundState("rolling_75",rollingi*rol75,rol75p)

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

    local state = self:GetPackedRatio("RNState")
    self.TISUVol = math.Clamp(self.TISUVol+(state-self.TISUVol)*dT*8,0,1)
    self:SetSoundState("tisu", self.TISUVol, 1)
    self:SetSoundState("bbe", self:GetPackedBool("BBEWork") and 1 or 0, 1)

    local work = self:GetPackedBool("AnnPlay")
    for k,v in ipairs(self.AnnouncerPositions) do
        if IsValid(self.Sounds["announcer"..k]) then
            self.Sounds["announcer"..k]:SetVolume(work and (v[3] or 1)  or 0)
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
    self.RTMaterial:SetTexture("$basetexture", self.Tickers)
    self:DrawOnPanel("Tickers",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,32+8,1024+16,64+16,0)
    end)
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
    if soundid == "K1" then
        local id = range > 0 and "k1_on" or "k1_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["k1_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    if soundid == "K2" then
        local id = range > 0 and "k2_on" or "k2_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["k2_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    if soundid == "K3" then
        local id = range > 0 and "k3_on" or "k3_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["k3_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    if soundid == "KMR1" then
        local id = range > 0 and "kmr1_on" or "kmr1_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["kmr1_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    if soundid == "KMR2" then
        local id = range > 0 and "kmr2_on" or "kmr2_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["kmr2_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    if soundid == "QF1" then
        local id = range > 0 and "qf1_on" or "qf1_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["qf1_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    return soundid,location,range,pitch
end
Metrostroi.GenerateClientProps()
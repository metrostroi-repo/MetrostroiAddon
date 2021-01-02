--------------------------------------------------------------------------------
-- 81-720 controller panel
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_720_Panel")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("Stand","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Ticker","Relay","Switch",{bass=true})
    self.Train:LoadSystem("KAH","Relay","Switch",{bass=true})
    self.Train:LoadSystem("KAHk","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("ALS","Relay","Switch",{bass=true})
    self.Train:LoadSystem("ALSk","Relay","Switch",{bass=true,normally_closed = true})
    self.Train:LoadSystem("FDepot","Relay","Switch",{bass=true})
    self.Train:LoadSystem("PassScheme","Relay","Switch",{bass=true})
    self.Train:LoadSystem("EmergencyCompressor","Relay","Switch",{bass=true})--
    self.Train:LoadSystem("EnableBV","Relay","Switch",{bass=true})
    self.Train:LoadSystem("EnableBVEmer","Relay","Switch",{bass=true})
    self.Train:LoadSystem("DisableBV","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Ring","Relay","Switch",{bass=true})
    self.Train:LoadSystem("R_Program2","Relay","Switch",{bass=true})
    self.Train:LoadSystem("R_Announcer","Relay","Switch",{bass=true})
    self.Train:LoadSystem("R_Line","Relay","Switch",{bass=true})
    self.Train:LoadSystem("R_Emer","Relay","Switch",{bass=true})
    self.Train:LoadSystem("R_Program1","Relay","Switch",{bass=true})

    self.Train:LoadSystem("EmergencyControls","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Wiper","Relay","Switch",{bass=true})


    self.Train:LoadSystem("DoorSelectL","Relay","Switch",{bass=true})
    self.Train:LoadSystem("DoorSelectR","Relay","Switch",{bass=true})
    self.Train:LoadSystem("DoorBlock","Relay","Switch",{bass=true})
    self.Train:LoadSystem("DoorLeft","Relay","Switch",{bass=true})
    self.Train:LoadSystem("AccelRate","Relay","Switch",{bass=true})
    self.Train:LoadSystem("EmerBrakeAdd","Relay","Switch",{bass=true})
    self.Train:LoadSystem("EmerBrakeRelease","Relay","Switch",{bass=true})
    self.Train:LoadSystem("EmerBrake","Relay","Switch",{bass=true})
    self.Train:LoadSystem("EmergencyBrake","Relay","Switch",{bass=true})
    self.Train:LoadSystem("DoorRight","Relay","Switch",{bass=true})
    self.Train:LoadSystem("HornB","Relay","Switch",{bass=true})

    self.Train:LoadSystem("DoorClose","Relay","Switch",{bass=true})
    self.Train:LoadSystem("AttentionMessage","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Attention","Relay","Switch",{bass=true})
    self.Train:LoadSystem("AttentionBrake","Relay","Switch",{bass=true})

    self.Train:LoadSystem("VentCondMode","Relay","Switch",{maxvalue=3,defaultvalue=2,bass=true})
    self.Train:LoadSystem("VentStrengthMode","Relay","Switch",{maxvalue=3,defaultvalue=2,bass=true})
    self.Train:LoadSystem("VentHeatMode","Relay","Switch",{maxvalue=1,defaultvalue=0,bass=true})

    self.Train:LoadSystem("EmerX1","Relay","Switch",{bass=true})
    self.Train:LoadSystem("EmerX2","Relay","Switch",{bass=true})
    self.Train:LoadSystem("EmerCloseDoors","Relay","Switch",{bass=true})
    self.Train:LoadSystem("EmergencyDoors","Relay","Switch",{bass=true})

    self.Train:LoadSystem("SF1","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF2","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF3","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF4","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF5","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF6","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF7","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF8","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF9","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF10","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF11","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF12","Relay","Switch",{normally_closed = true,bass=true})

    self.Train:LoadSystem("SF13","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF14","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF15","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF16","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF17","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF18","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF19","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF20","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF21","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF22","Relay","Switch",{normally_closed = true,bass=true})


    self.Train:LoadSystem("SFV1","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV2","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV3","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV4","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV5","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV6","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV7","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV8","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV9","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV10","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV11","Relay","Switch",{normally_closed = true,bass=true})

    self.Train:LoadSystem("SFV12","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV13","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV14","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV15","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV16","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV17","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV18","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV19","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV20","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV21","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV22","Relay","Switch",{normally_closed = true,bass=true})

    self.Train:LoadSystem("SFV23","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV24","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV25","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV26","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV27","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV28","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV29","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV30","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV31","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV32","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SFV33","Relay","Switch",{normally_closed = true,bass=true})

    self.Train:LoadSystem("Pant1","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Pant2","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vent1","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vent2","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vent","Relay","Switch",{bass=true})
    self.Train:LoadSystem("PassLight","Relay","Switch",{bass=true})
    self.Train:LoadSystem("CabLight","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Headlights1","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Headlights2","Relay","Switch",{bass=true})
    self.Train:LoadSystem("ParkingBrake","Relay","Switch",{bass=true})
    self.Train:LoadSystem("TorecDoors","Relay","Switch",{bass=true})
    self.Train:LoadSystem("BBER","Relay","Switch",{bass=true})
    self.Train:LoadSystem("BBE","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Compressor","Relay","Switch",{bass=true})
    self.Train:LoadSystem("CabLightStrength","Relay","Switch",{bass=true})
    self.Train:LoadSystem("AppLights1","Relay","Switch",{bass=true})
    self.Train:LoadSystem("AppLights2","Relay","Switch",{bass=true})

    self.Train:LoadSystem("BARSBlock","Relay","Switch",{maxvalue=3,defaultvalue=0,bass=true})
    self.Train:LoadSystem("Battery","Relay","Switch",{bass=true})

    self.Train:LoadSystem("ALSFreq","Relay","Switch",{bass=true})

    self.Train:LoadSystem("PB","Relay","Switch",{bass=true})
    self.Controller = 0
    self.TargetController = 0

    self.Headlights1 = 0
    self.Headlights2 = 0
    self.RedLights = 0
    self.DoorLeft = 0
    self.DoorRight = 0
    self.EmerBrakeWork = 0
    self.Ticker = 0
    self.KAH = 0
    self.ALS = 0
    self.PassScheme = 0
    self.R_Announcer = 0
    self.R_Line = 0
    self.AccelRate = 0
    self.DoorClose = 0
    self.DoorBlock = 0
    self.EqLights = 0
    self.CabLights = 0
    self.AnnouncerPlaying = 0

    self.TickerPower = 0
    self.PassSchemePower = 0
    self.TickerWork = 0
    self.PassSchemeWork = 0
    self.PassSchemeControl = 0

    self.CBKIPower = 0
    self.PCBKPower = 0
end

function TRAIN_SYSTEM:Inputs()
    return { "KVUp", "KVDown", "KV1", "KV2", "KV3", "KV4", "KV5", "KV6", "KV7", "KV8", "ControllerUnlock"}
end

function TRAIN_SYSTEM:Outputs()
    return { "Controller","Headlights1","Headlights2","RedLights","DoorLeft","DoorRight","EmerBrakeWork","Ticker","KAH","ALS","PassScheme","R_Announcer","R_Line","AccelRate","DoorClose","DoorBlock","EqLights","CabLights","AnnouncerPlaying","TickerPower","PassSchemePower","TickerWork","PassSchemeWork","PassSchemeControl","CBKIPower","PCBKPower", }
end
--if not TURBOSTROI then return end
function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "KVUp" and value > 0 and self.Controller < 4 then
        if self.TargetController+1 == 0 and not self.Locker then return end
        self.TargetController = self.TargetController + 1
    end
    if name == "KVDown" and value > 0 and self.TargetController > -3 then
        self.TargetController = self.TargetController - 1
    end
    if name == "KV4" and value > 0 then self.TargetController = 4 end
    if name == "KV3" and value > 0 then self.TargetController = 3 end
    if name == "KV2" and value > 0 then self.TargetController = 2 end
    if name == "KV1" and value > 0 then self.TargetController = 1 end
    if name == "KV5" and value > 0 then self.TargetController = 0 end
    if name == "KV6" and value > 0 then self.TargetController = -1 end
    if name == "KV7" and value > 0 then self.TargetController = -2 end
    if name == "KV8" and value > 0 then self.TargetController = -3 end
    if name == "ControllerUnlock" then self.Locker = value > 0.5 end
    self.ControllerTimer = CurTime()-1
end
function TRAIN_SYSTEM:Think()
    if self.ControllerTimer and CurTime() - self.ControllerTimer > 0.06 and self.Controller ~= self.TargetController then
        local previousPosition = self.Controller
        self.ControllerTimer = CurTime()
        if self.TargetController > self.Controller then
            self.Controller = self.Controller + 1
        else
            self.Controller = self.Controller - 1
        end
        self.Train:PlayOnce("KV_"..previousPosition.."_"..self.Controller, "cabin",0.5)
    end
    if self.Controller == self.TargetController then
        self.ControllerTimer = nil
    end
end

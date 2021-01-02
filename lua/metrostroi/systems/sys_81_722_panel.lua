--------------------------------------------------------------------------------
-- 81-722 controller panel
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_722_Panel")
TRAIN_SYSTEM.DontAccelerateSimulation = false
function TRAIN_SYSTEM:Initialize()
    --Автоматы ПЗ
    self.Train:LoadSystem("SF1","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF2","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF3","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF4","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF5","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF6","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF7","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF8","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF9","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("R_UPO","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF01","Relay","Switch",{bass=true})
    self.Train:LoadSystem("SF10","Relay","Switch",{bass=true})
    self.Train:LoadSystem("SF11","Relay","Switch",{bass=true})
    self.Train:LoadSystem("SF12","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF13","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF02","Relay","Switch",{bass=true})
    self.Train:LoadSystem("SF14","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF15","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF16","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF17","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF18","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF19","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF20","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF21","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF22","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF23","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF24","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF25","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF26","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF27","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF03","Relay","Switch",{bass=true})
    self.Train:LoadSystem("SF04","Relay","Switch",{bass=true})

    --Автоматы ВЗ
    self.Train:LoadSystem("SF31","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF32","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF33","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF34","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF35","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF36","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF37","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF38","Relay","Switch",{bass=true})
    self.Train:LoadSystem("SF41","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF42","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF43","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF44","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF45","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF46","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF47","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF48","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF49","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF51","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF52","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF53","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF54","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF55","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF56","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF57","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF58","Relay","Switch",{normally_closed = true,bass=true})
    self.Train:LoadSystem("SF59","Relay","Switch",{normally_closed = true,bass=true})
    --Задняя панель кнопок
    self.Train:LoadSystem("PSNToggle","Relay","Switch",{bass=true})
    self.Train:LoadSystem("BattOn","Relay","Switch",{bass=true})
    self.Train:LoadSystem("BattOff","Relay","Switch",{bass=true})
    self.Train:LoadSystem("TorecDoorUnlock","Relay","Switch",{bass=true})

    --
    self.Train:LoadSystem("PassLight","Relay","Switch",{bass=true})
    self.Train:LoadSystem("PassVent","Relay","Switch",{maxvalue=4,defaultvalue=1,bass=true})
    self.Train:LoadSystem("VKF","Relay","Switch",{bass=true})
    self.Train:LoadSystem("ParkingBrake","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VRD","Relay","Switch",{bass=true})
    self.Train:LoadSystem("SOSDEnable","Relay","Switch",{bass=true})
    --
    self.Train:LoadSystem("VRU","Relay","Switch",{maxvalue=2,defaultvalue=1,bass=true})
    self.Train:LoadSystem("VAD","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VAH","Relay","Switch",{bass=true})
    self.Train:LoadSystem("EmergencyRadioPower","Relay","Switch",{bass=true})
    self.Train:LoadSystem("BARSMode","Relay","Switch",{maxvalue=2,defaultvalue=1,bass=true})
    self.Train:LoadSystem("PantSC","Relay","Switch",{maxvalue=4,defaultvalue=1,bass=true})
    self.Train:LoadSystem("RCARS","Relay","Switch",{defaultvalue=1,bass=true})

    --Пульт управления 1
    self.Train:LoadSystem("MirrorHeating","Relay","Switch",{bass=true})
    self.Train:LoadSystem("DoorLeft2","Relay","Switch",{bass=true})
    --
    self.Train:LoadSystem("DoorBack","Relay","Switch",{bass=true})
    self.Train:LoadSystem("EmergencyDrive","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Microphone","Relay","Switch",{bass=true})
    self.Train:LoadSystem("DoorLeft1","Relay","Switch",{bass=true})

    self.Train:LoadSystem("ARS","Relay","Switch",{bass=true})
    self.Train:LoadSystem("ALS","Relay","Switch",{bass=true})
    self.Train:LoadSystem("GlassWasher","Relay","Switch",{bass=true})
    self.Train:LoadSystem("GlassCleaner","Relay","Switch",{maxvalue = 2,bass=true})
    self.Train:LoadSystem("EmergencyBrakeTPlus","Relay","Switch",{bass=true})
    self.Train:LoadSystem("EmergencyBrakeTPlusK","Relay","Switch",{defaultvalue=1})
    self.Train:LoadSystem("EmergencyBrake","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vigilance","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Headlights","Relay","Switch",{maxvalue = 2,bass=true})
    self.Train:LoadSystem("DoorSelect","Relay","Switch",{bass=true})
    self.Train:LoadSystem("DoorClose","Relay","Switch",{maxvalue = 2,defaultvalue=1,bass=true})
    self.Train:LoadSystem("DoorRight","Relay","Switch",{bass=true})

    self.Train:LoadSystem("KRO","Relay","Switch",{maxvalue = 2,defaultvalue=1,bass=true})
    self.Train:LoadSystem("Compressor","Relay","Switch",{maxvalue=4,defaultvalue=0,bass=true})
    self.Train:LoadSystem("Ring","Relay","Switch",{bass=true})
    --Освещение
    self.Train:LoadSystem("CabinLight","Relay","Switch",{maxvalue=2,defaultvalue=0,bass=true})
    self.Train:LoadSystem("PanelLight","Relay","Switch",{bass=true})

    self.Train:LoadSystem("PB","Relay","Switch",{bass=true})
    self.Controller = 0
    self.TargetController = 0


    self.BattOn = 0
    self.BattOff = 0
    self.SOSDL = 0

    self.RS = 0
    self.AVS = 0
    self.RU = 0

    self.EmergencyDriveL = 0
    self.EmergencyBrakeTPlusL = 0

    self.DoorLeftL = 0
    self.DoorRightL = 0
    self.MFDUPowerL = 0

    self.CabLights = 0
    self.PanelLights = 0

    self.Headlights1 = 0
    self.Headlights2 = 0
    self.RedLights = 0

    self.EmergencyLights = 0
    self.MainLights = 0

    self.V4 = 0

    self.UPOPower = 0
    self.AnnouncerPlaying = 0

    self.SOSD = 0

    self.PassSchemePowerL = 0
    self.PassSchemePowerR = 0

    self.DoorsW = 0
    self.BrW = 0
    self.GRP = 0

    self.RC = 0
    self.VPR1 = 0
    self.VPR2 = 0

    self.BARSPower = 0
    self.ARSPower = 0
    self.ALSPower = 0
end

function TRAIN_SYSTEM:Inputs()
    return { "KVUp", "KVDown", "KV1", "KV2", "KV4", "KV5", "KV6", "KV7", }
end

function TRAIN_SYSTEM:Outputs()
    return { "Controller","BattOn","BattOff","SOSDL","RS","AVS","RU","EmergencyDriveL","EmergencyBrakeTPlusL","DoorLeftL","DoorRightL","MFDUPowerL","CabLights","PanelLights","Headlights1","Headlights2","RedLights","EmergencyLights","MainLights", "V4","SOSD","UPOPower","AnnouncerPlaying", "PassSchemePowerL", "PassSchemePowerR","DoorsW","BrW","GRP","RC","VPR1","VPR2","BARSPower","ARSPower","ALSPower"}
end
--if not TURBOSTROI then return end
function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "KVUp" and value > 0 and self.Controller < 2 then
        self.TargetController = self.TargetController + 1
        if self.TargetController <= -2 then
            self.TargetController = -1
        end
    end
    if name == "KVUp" and value == 0 and self.TargetController == 2 then
        self.TargetController = self.TargetController - 1
    end
    if name == "KVDown" and value > 0 and self.TargetController > -2 then
        self.TargetController = self.TargetController - 1
    end
    if name == "KVDown" and value == 0 and self.TargetController == -2 then
        self.TargetController = self.TargetController + 1
    end
    if name == "KV1"  then
        self.KV1Pressed = value > 0
        if value then
            self.TargetController = 1
        end
    end
    if name == "KV2" then
        if value > 0 then
            self.TargetController = 2
        elseif self.TargetController == 2 then
            self.TargetController = 1
        end
    end
    if name == "KV4" and value > 0 then
        self.TargetController = 0
    end
    if name == "KV5" then
        self.KV5Pressed = value > 0
        if value then
            self.TargetController = -1
        end
    end
    if name == "KV6" then
        if value > 0 then
            self.TargetController = -2
        elseif self.TargetController == -2 then
            self.TargetController = -1
        end
    end
    if name == "KV7" then
        self.TargetController = -3
    end
    self.ControllerTimer = CurTime()-1
end
function TRAIN_SYSTEM:Think()
    if self.Controller ~= self.TargetController and not self.ControllerTimer then
        self.ControllerTimer = CurTime()-1
    end
    if self.KV1Pressed then
        if self.Train.BUKP.PowerPrecent > 25 then
            self.TargetController = 0
        else
            self.TargetController = 1
        end
    end
    if self.KV5Pressed then
        if self.Train.BUKP.PowerPrecent < -25 then
            self.TargetController = 0
        else
            self.TargetController = -1
        end
    end
    if self.ControllerTimer and CurTime() - self.ControllerTimer > 0.1 and self.Controller ~= self.TargetController then
        local previousPosition = self.Controller
        self.ControllerTimer = CurTime()
        if self.TargetController > self.Controller then
            self.Controller = self.Controller + 1
        else
            self.Controller = self.Controller - 1
        end
        self.Train:PlayOnce("KU_"..previousPosition.."_"..self.Controller, "cabin",0.5)
    end

    if self.Controller == self.TargetController then
        self.ControllerTimer = nil
    end
end

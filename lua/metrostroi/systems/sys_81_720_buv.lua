--------------------------------------------------------------------------------
-- 81-720 wagon control unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_720_BUV")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    if not TURBOSTROI then
        self.TrainIndex = self.Train:GetWagonNumber()
    end
    self.Battery = false
    self.Power = 0
    self.States = {}
    self.Commands = {}

    self.Slope = false

    self.BBE = 0
    self.MK = 0

    self.Reverser = 0
    self.PN2 = 0
    self.Brake = 0
    self.Drive = 0
    self.DriveStrength = 0
    self.Disassembly = 0

    self.Vent1 = 0
    self.Vent2 = 0

    self.CurTime = CurTime()

    self.FirstHalf = false
end

function TRAIN_SYSTEM:Outputs()
    return {"Brake", "Drive", "DriveStrength", "Disassembly" ,"BBE","MK","Vent1","Vent2"}
end

function TRAIN_SYSTEM:Inputs()
    return {}
end
function TRAIN_SYSTEM:CState(name,value)
    if self.CurrentBUP and (self.Reset or self.States[name] ~= value) then
        self.States[name] = value
        self.Train:CANWrite("BUV",self.Train:GetWagonNumber(),"BUKP",self.CurrentBUP,name,value)
    end
end
-- Door8Closed t/f
-- Door7Closed t/f
-- Door6Closed t/f
-- Door5Closed t/f
-- Door4Closed t/f
-- Door3Closed t/f
-- Door2Closed t/f
-- Door1Closed t/f
-- NoAssembly t/f
-- ParkingBrakeEnabled t/f
-- BEPPBroken t/f
-- EmergencyBrake t/f
-- ReserveChannelBraking t/f
-- PTEnabled t/f
-- PTBad t/f
-- PTReady t/f
-- PTReplace t/f
-- TLPressure 0-10
-- BLPressure 0-10
-- BCPressure 0-6
-- HPPressure 0-6
-- WeightLoad 0-1
-- PantDisabled t/f
-- EnginesBroken t/f
-- BBEEnabled t/f
-- BBEBroken t/f
-- HVBad t/f
-- LVBad t/f
-- EnginesDone t/f
-- EnginesBrakeBroke t/f
-- PassLightEnabled t/f
-- BVEnabled t/f
-- DriveStrength ~
-- BrakeStrength ~
-- VagEqConsumption 0-60A
-- HVVoltage 0-1500A
-- LVVoltage 0-100A
-- MKVoltage 0-50A
-- VentEnabled t/f
-- HeatEnabled t/f
-- MKWork --Исправность МК
-- BUVWork --Исправность БУВ
-- WagNOrientated t/f
-- Orientation t/f
function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
    if textdata == "BUPWork" and not numdata then
        self.Commands[sourceid] = {}
    elseif textdata == "Orientate" then
        self.OrientateBUP = sourceid
        self.FirstHalf = numdata
        self.Reset = CurTime()
    elseif self.CurrentBUP then
        if not self.Commands[sourceid] then self.Commands[sourceid] = {} end
        self.Commands[sourceid][textdata] = numdata
    end
end
function TRAIN_SYSTEM:Get(id)
    local Commands = self.Commands[self.CurrentBUP]
    if Commands then
        return Commands[id]
    end
end
function TRAIN_SYSTEM:TriggerInput(name,value)
end

function TRAIN_SYSTEM:Think()
    if CurTime()-self.CurTime < 0.1 then return end
    self.DeltaTime = CurTime()-self.CurTime
    self.CurTime = CurTime()

    local Train = self.Train
    local wagcount = #Train.WagonList

    self.Power = Train.Electric.Battery80V > 62 and 1 or 0
    self.State = self.Power > 0 and Train.SFV2.Value > 0.5
    if self.State then
        if not self.States.BUVWork then
            self.Train:CANWrite("BUV",Train:GetWagonNumber(),"BUKP",nil,"Get",1)
        end
        for i=1,4 do
            self:CState("Door"..i.."Closed", Train.Pneumatic.LeftDoorState[i] == 0)
            self:CState("Door"..(i+4).."Closed", Train.Pneumatic.RightDoorState[i] == 0)
        end
        self:CState("DoorTorec", Train.RearDoor or Train.FrontDoor)
        self:CState("DoorBack", Train.PassengerDoor or Train.CabinDoorLeft or Train.CabinDoorRight)
        self:CState("EmPT",Train:ReadTrainWire(28) > 0)
        self:CState("NoAssembly", Train.KMR1.Value == 0 and Train.KMR2.Value == 0 or Train.K2.Value == 0 and Train.K3.Value==0)
        self:CState("ParkingBrakeEnabled", Train.Pneumatic.ParkingBrakePressure < 3)
        self:CState("BEPPBroken", false)
        self:CState("EmergencyBrakeGood", Train.Pneumatic.BrakeCylinderPressure >= (2.6+Train.Pneumatic.WeightLoadRatio*0.6)-0.1)
        self:CState("EmergencyBrake", self.States.EmergencyBrakeGood--[[  and Train:ReadTrainWire(27) == 0--]] )
        self:CState("ReserveChannelBraking", Train:ReadTrainWire(28)>0)
        self:CState("PTEnabled", Train.Pneumatic.BrakeCylinderPressure > 0.2)
        self:CState("PTBad", false)
        self:CState("PTReady", Train.Pneumatic.AirDistributorPressure >= (2.6+Train.Pneumatic.WeightLoadRatio*0.6)-0.1)
        self:CState("PTReplace", self.PTReplace and CurTime()-self.PTReplace > 1.5)
        self:CState("BTBReady", Train.Pneumatic.BTBReady)
        self:CState("TLPressure", math.Round(Train.Pneumatic.TrainLinePressure,1))
        self:CState("BLPressure", math.Round(Train.Pneumatic.BrakeLinePressure,1))
        self:CState("BCPressure", math.Round(Train.Pneumatic.BrakeCylinderPressure,1))
        self:CState("HPPressure", math.Round(Train.Pneumatic.AirDistributorPressure,1))
        self:CState("WeightLoad", math.Round(Train.Pneumatic.WeightLoadRatio,2))
        self:CState("PantDisabled", self.Pant)
        self:CState("EnginesBroken", false)
        self:CState("BBEEnabled", self.BBE)
        self:CState("BBEBroken", false)
        self:CState("HVBad", Train.Electric.Power750V < 550)
        self:CState("LVBad", Train.Electric.Battery80V < 62)
        self:CState("EnginesDone", self.EnginesDone)-- and math.abs(Train.Speed) < 7.5)
        --self:CState("EnginesBrakeBroke", (self:Get("Brake") or 0) > 0 and Train.BV.Value == 0 or Train.Electric.IT > 0 and Train.K3.Value == 0)
        self:CState("EnginesBrakeBroke", (self:Get("Brake") or 0) > 0 and (Train.BV.Value == 0 or Train.K3.Value == 0))
        self:CState("PassLightEnabled", self.MainLights)
        self:CState("BVEnabled", Train.BV.Value > 0)
        self:CState("DriveStrength", math.min(0,Train.Engines.BogeyMoment*2))
        self:CState("BrakeStrength", math.max(0,Train.Engines.BogeyMoment*2))
        self:CState("VagEqConsumption", 15)--15-25
        self:CState("I13", math.Round(Train.Electric.I13,1))
        self:CState("I24", math.Round(Train.Electric.I24,1))
        self:CState("HVVoltage", math.floor(Train.Electric.Main750V))
        self:CState("LVVoltage", math.floor(Train.Electric.Battery80V))
        self:CState("MKVoltage", math.Round(Train.Electric.BVKA_KM1*math.Rand(9,13),1))
        self:CState("Vent1Enabled", Train.Electric.Vent1>0)
        self:CState("Vent2Enabled", Train.Electric.Vent2>0)
        self:CState("HeatEnabled", false)
        self:CState("MKWork", Train.Pneumatic.Compressor)
        self:CState("BUVWork", true)
        self:CState("WagNOrientated", self.Orientation  == self.RevOrientation)
        self:CState("Orientation", self.Orientation)
        self:CState("BadCombination", (Train:ReadTrainWire(3)*Train:ReadTrainWire(4)) > 0)
    else
        self:CState("BUVWork", false)
        for k,v in pairs(self.Commands) do
            self.Commands[k] = false
        end
    end

    if self.Reset and self.Reset ~= CurTime() then
        self.Reset = nil
    end
    self.BBE = not self:Get("PVU8") and self:Get("BBE") and Train.SFV7.Value or 0
    if Train.Electric.Main750V < 650 or Train.Electric.Main750V > 975 then self.BBE = 0 end
    if self.BBE == 0 and self.MainLights and not self.MainLightsTimer then self.MainLightsTimer = CurTime() end
    if self.BBE > 0 or not self.MainLights or self.MainLightsTimer and CurTime()-self.MainLightsTimer > 20 then self.MainLightsTimer = nil end
    if (self:Get("BVOn") or Train:ReadTrainWire(2) > 0) then
        Train.BV:TriggerInput("Close",Train.SFV8.Value*Train.SFV9.Value)
    end
    if self:Get("BVOff") and Train.SFV8.Value > 0 then
        Train.BV:TriggerInput("Open",1)
    end
    self.MainLights = not self:Get("PVU5") and (self.BBE > 0 or self.MainLightsTimer) and Train.SFV19.Value > 0.5 and self:Get("PassLight")
    if self:Get("Slope") then self.Slope = CurTime() end
    if not self:Get("Slope") and self.Slope and Train.Pneumatic.BrakeCylinderPressure < 0.5 then self.Slope = false end
    --self.Reverser = Train:ReadTrainWire(12)
    local brake = self:Get("Brake") or 0
    local strength = not self:Get("PVU9") and (self.Slope or brake>0 and Train.Pneumatic.BrakeCylinderPressure < 1.5 or brake==0 and Train.Pneumatic.BrakeCylinderPressure < 0.5) and self:Get("DriveStrength") or 0
    local drive = math.min(1,(1-brake)*strength)
    if strength == 0 then
        brake=0
        drive=0
    end
    if brake>0 and Train.BPTI.State~=-1 and math.abs(Train.Speed) < 10 then
        self.Brake = 0
    else
        self.Brake = brake
    end
    self.Drive = drive
    self.BlockTorec = not self:Get("PVU6") and self:Get("DoorTorec") and Train.SFV15.Value > 0
    self.DriveStrength = strength
    if brake == 0 then
        self.EnginesDone = false
    elseif Train.BPTI.State == -1 and (Train.BPTI.RNState == 1 and Train.Electric.I13>math.min(-130,-Train.Electric.ISet*0.75)) or Train.BPTI.State~=-1 and math.abs(Train.Speed) < 10  then
        self.EnginesDone = true
    end

    local PTReplace = self.States.EnginesBrakeBroke
    if PTReplace and not self.PTReplace then
        self.PTReplace =  CurTime()
        if Train.K3.Value*Train.BV.Value ~= 0 then
            self.PTReplace = self.PTReplace + 1.3
        end
        if Train.BV.Value == 0 or self:Get("PVU9")  then
            self.PTReplace = self.PTReplace - 1.2
        end
    end
    if not PTReplace and self.PTReplace then self.PTReplace = nil end

    local PN =  self.PTReplace and CurTime()-self.PTReplace > 1.2 or self.States.EnginesDone
    self.PN1 = (self:Get("PN1") and self:Get("PN1") > 0) or PN and (self:Get("DriveStrength") and self:Get("DriveStrength") > 0)
    --print(self:Get("DriveStrength"),Train.K1.Value,Train.Electric.Itotal,Train.Electric.Drive,Train.BUV.Brake)
    self.PN2 = (self:Get("PN2") and self:Get("PN2") > 0) or PN and (self:Get("DriveStrength") and self:Get("DriveStrength") > 2)

    self.MK = not self:Get("PVU3") and self:Get("Compressor") and 1 or 0

    self.OpenLeft = not self:Get("PVU2") and self:Get("OpenLeft") and self.Orientation or self:Get("OpenRight") and not self.Orientation
    self.OpenRight = not self:Get("PVU2") and self:Get("OpenRight") and self.Orientation or self:Get("OpenLeft") and not self.Orientation
    self.CloseDoors = self:Get("PVU2") or self:Get("CloseDoors")

    self.Vent1 = not self:Get("PVU7") and self:Get("Vent1") and 1 or 0
    self.Vent2 =  not self:Get("PVU7") and self:Get("Vent1") and self:Get("Vent2") and 1 or 0
    self.Orientation = Train:ReadTrainWire(3) > 0
    self.RevOrientation = Train:ReadTrainWire(4) > 0
    --print(Train:ReadTrainWire(3),Train:ReadTrainWire(4))
    --if self.Orientation == self.RevOrientation then print(Train:ReadTrainWire(3),Train:ReadTrainWire(4)) end
    local BadOrientation = self.Orientation and self.Orientation  == self.RevOrientation
    if self.State and self.Orientation ~= self.RevOrientation then
        if not self.BadOrientation and self.OrientateBUP and (not self.Commands[self.OrientateBUP] or self.Orientation and self.Commands.Forward ~= self.OrientateBUP or self.RevOrientation and self.Commands.Back ~= self.OrientateBUP) then
            --print(Train:GetWagonNumber(),"New BUP",self.Orientation and "Forward" or "Back",self.OrientateBUP)
            if self.Orientation then self.Commands.Forward = self.OrientateBUP else self.Commands.Back = self.OrientateBUP end
            self.OrientateBUP = nil
        end
    end

    local ReOrientation = self.State and (self.Orientation or self.RevOrientation) and (self.Orientation ~= self.PrevOrientation or self.RevOrientation ~= self.PrevRevOrientation or self.CurrentBUP ~= (self.Orientation and self.Commands.Forward or self.Commands.Back))
    if ReOrientation then
        self.CurrentBUP = self.Orientation and self.Commands.Forward or self.Commands.Back
        --print(Train:GetWagonNumber(),"Reorientate",self.Orientation and "Forward" or "Back",self.CurrentBUP)
        self.Reset = CurTime()
        if self.CurrentBUP then
            self.Commands[self.CurrentBUP]  = {}
            Train:CANWrite("BUV",Train:GetWagonNumber(),"BUKP",self.CurrentBUP,"Get")
        end
    end
    self.BadOrientation = BadOrientation
    self.PrevOrientation = self.Train:ReadTrainWire(3) > 0
    self.PrevRevOrientation = self.Train:ReadTrainWire(4) > 0
    if Train.SFV29.Value > 0 then
        if self:Get("PVU4") or --[[ Train.Electric.Main750V < 20 and --]] (self:Get("TP1") and self.FirstHalf or self:Get("TP2") and not self.FirstHalf) then
            self.Pant = true
        else
            self.Pant = false
        end
    end
end

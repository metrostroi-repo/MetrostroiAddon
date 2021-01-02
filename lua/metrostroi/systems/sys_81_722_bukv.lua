--------------------------------------------------------------------------------
-- 81-722 wagon control unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_722_BUKV")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.Power = 0
    self.Commands = {}
    self.States = {}

    self.Drive = 0
    self.Brake = 0
    self.Strength = 0
    self.CurTime = CurTime()

    self.DisableLights = 0
    self.EnableLights = 0
    self.VentMode = 0
    self.DisablePSN = 0
    self.DisableTP = 0
    self.EnableMK = 0
    self.DisablePant = 0
end

function TRAIN_SYSTEM:Outputs()
    return {"Power","Drive","Brake","Strength","DisableLights","EnableLights","DisablePSN","EnableMK","DisableTP","DisablePant","VentMode"}
end

function TRAIN_SYSTEM:CState(name,value)
    if self.CurrentBUP and  (self.Reset or self.States[name] ~= value) then
        self.States[name] = value
        self.Train:CANWrite("BUKV",self.TrainIndex,"BUKP",self.CurrentBUP or false,name,value)
    end
end
function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
    if textdata == "Init" and not numdata then
        local Train = self.Train
        self.Commands[sourceid] = {}
        Train:CANWrite("BUKV",self.TrainIndex,"BUKP",sourceid,"Init",{
            front=Train.FrontTrain and Train.FrontTrain.BUKV and Train.FrontTrain.BUKV.TrainIndex,
            rear=Train.RearTrain and Train.RearTrain.BUKV and Train.RearTrain.BUKV.TrainIndex,
            type=Train.Electric.Type
        })
    elseif textdata == "Get" then
        self.Reset = CurTime()
    elseif textdata == "Orientate" then
        self.OrientateBUP = sourceid
        self.FirstHalf = numdata
        self.FirstGroup = numdata
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

function TRAIN_SYSTEM:Inputs()
    return {}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end
function TRAIN_SYSTEM:Think()
    if CurTime()-self.CurTime < 0.1 then return end
    self.CurTime = CurTime()

    local Train = self.Train
    local wagcount = #Train.WagonList
    self.Power = Train.Electric.Power
    self.State = self.Power > 0 and Train.SF51.Value > 0.5
    self.TrainIndex = Train:GetWagonNumber()
    if self.State then
        if not self.States.BUKVTimer then
            self.Train:CANWrite("BUKV",Train:GetWagonNumber(),"BUKP",nil,"Get",1)
        end
        --[[ for i=1,4 do
            self:CState("Door"..i.."Closed", Train.Pneumatic.LeftDoorState[i] == 0)
            self:CState("Door"..(i+4).."Closed", Train.Pneumatic.RightDoorState[i] == 0)
        end--]]
        --self:CState("DoorTorec", Train.RearDoor or Train.FrontDoor)
        --self:CState("DoorBack", Train.PassengerDoor or Train.CabinDoorLeft or Train.CabinDoorRight)
        --self:CState("EmPT",Train:ReadTrainWire(28) > 0)
        --self:CState("NoAssembly", Train.K3_4.Value == 0)
        --self:CState("ParkingBrakeEnabled", Train.Pneumatic.ParkingBrakePressure < 2.95)
        --self:CState("BEPPBroken", false)
        -- self:CState("EmergencyBrakeGood", Train.Pneumatic.BrakeCylinderPressure >= (2.4+Train.Pneumatic.WeightLoadRatio*0.9)-0.1)
        -- self:CState("ReserveChannelBraking", Train:ReadTrainWire(28)>0)
        -- self:CState("PTEnabled", Train.Pneumatic.BrakeCylinderPressure > 0.2)
        -- self:CState("PTBad", false)
        -- self:CState("PTReady", Train.Pneumatic.AirDistributorPressure >= (2.4+Train.Pneumatic.WeightLoadRatio*0.9)-0.1)
        -- self:CState("PTReplace", self.PTReplace and CurTime()-self.PTReplace > 1.5)
        -- self:CState("BTBReady", Train.Pneumatic.BTBReady)
        --self:CState("TLPressure", math.Round(Train.Pneumatic.TrainLinePressure,1))
        --self:CState("BLPressure", math.Round(Train.Pneumatic.BrakeLinePressure,1))
        --self:CState("BCPressure", math.Round(Train.Pneumatic.BrakeCylinderPressure,1))
        --self:CState("HPPressure", math.Round(Train.Pneumatic.AirDistributorPressure,1))
        --self:CState("WeightLoad", math.Round(Train.Pneumatic.WeightLoadRatio,2))
        -- self:CState("PantDisabled", self.Pant)
        -- self:CState("EnginesBroken", false)
        -- self:CState("BBEEnabled", self.BBE)
        -- self:CState("BBEBroken", false)
        -- self:CState("HVBad", Train.Electric.Power750V < 550)
        -- self:CState("LVBad", Train.Electric.Battery80V < 62)
        -- self:CState("EnginesDone", self.EnginesDone)-- and math.abs(Train.Speed) < 7.5)
        -- self:CState("EnginesBrakeBroke", (self:Get("Brake") or 0) > 0 and Train.BV.Value == 0 or Train.Electric.Brake > 0 and (Train.K3_4.Value*Train.K5_6.Value == 0))
        -- self:CState("PassLightEnabled", self.MainLights)
        -- self:CState("BVEnabled", Train.BV.Value > 0)
        -- self:CState("DriveStrength", math.min(0,Train.Engines.BogeyMoment*2))
        -- self:CState("BrakeStrength", math.max(0,Train.Engines.BogeyMoment*2))
        -- self:CState("VagEqConsumption", 15)--15-25
        --self:CState("LVVoltage", math.floor(Train.Electric.Battery80V))
        --self:CState("MKVoltage", math.Round(Train.Electric.BVKA_KM1*math.Rand(9,13),1))
        -- self:CState("Vent1Enabled", Train.Electric.Vent1>0)
        -- self:CState("Vent2Enabled", Train.Electric.Vent2>0)
        -- self:CState("HeatEnabled", false)
        self:CState("WagNOrientated", self.Orientation  == self.RevOrientation)
        self:CState("Orientation", self.Orientation)
        self:CState("BadCombination", (Train:ReadTrainWire(3)*Train:ReadTrainWire(4)) > 0)

        local BUFTPower = Train.Electric.BUFT > 0
        local Pneumatic = Train.Pneumatic
        self:CState("BLPressure", BUFTPower and math.Round(Pneumatic.BrakeLinePressure,1) or 0)
        self:CState("TLPressure", BUFTPower and math.Round(Pneumatic.TrainLinePressure,1) or 0)
        self:CState("BCPressure", BUFTPower and math.Round(Pneumatic.BrakeCylinderPressure,1) or 0)
        self:CState("SKPressure", BUFTPower and math.Round(Pneumatic.AirDistributorPressure,1) or 0)
        self:CState("PBPressure", BUFTPower and math.Round(Pneumatic.ParkingBrakePressure,1) or 0)
        self:CState("WeightLoad", BUFTPower and math.Round(Pneumatic.WeightLoadRatio,2) or 0)
        self:CState("EmergencyBrake",BUFTPower and Pneumatic.EmergencyBrakeActive)
        local closed = true
        for i=1,4 do
            self:CState("Door"..i.."Closed", Train.Pneumatic.LeftDoorState[i] == 0)
            self:CState("Door"..(i+4).."Closed", Train.Pneumatic.RightDoorState[i] == 0)
            if Train.Pneumatic.LeftDoorState[i] > 0 or Train.Pneumatic.RightDoorState[i] > 0 then closed = false end
        end
        self:CState("DoorsClosed", closed)
        self:CState("TPEnabled", true)--FIXME
        self:CState("TRear", Train.RearDoor)
        if Train.Electric.HaveBUKP==0 then
            self:CState("TFront", Train.FrontDoor)
        else
            self:CState("TFront", Train.PassengerDoor)
            self:CState("TLeft", Train.CabinDoorLeft)
            self:CState("TRight", Train.CabinDoorRight)
        end
        self:CState("DPBD1", Train.Panel.BrW>0)
        self:CState("LVVoltage", Train.Electric.Power*65)
        if Train.Electric.HaveAsyncInverter>0 then
            self:CState("MKWork", Train.Pneumatic.Compressor)
            self:CState("PSNWork", Train.Electric.PSN>0)

            local Electric = Train.Electric
            local AsyncInverter = Train.AsyncInverter
            self:CState("HVVoltage", math.floor(Electric.Main750V))
            self:CState("Current", math.Round(AsyncInverter.Current,1))
            self:CState("DTorque", math.max(0,math.Round(AsyncInverter.Torque,1)))
            self:CState("BTorque", math.max(0,-math.Round(AsyncInverter.Torque,1)))

            self:CState("AsyncOverheat", false) --FIXME
            self:CState("AsyncAssembly", AsyncInverter.Mode~=0 and (AsyncInverter.Mode==self.Drive*(1-self.Brake) or AsyncInverter.Mode*(-1)==self.Brake*(1-self.Drive)))
            self:CState("AsyncFail", AsyncInverter.Mode==0 and (self.Drive>0 and self.Brake>0) or AsyncInverter.Power == 0)
            self:CState("AsyncEFail", (AsyncInverter.Mode==0 or AsyncInverter.EDone > 0) and self.Brake>0) --FIXME
            --self:CState("AsyncBroken",  AsyncInverter.Power == 0) --FIXME
            self:CState("AsyncProtection",  AsyncInverter.Power == 0) --FIXME
            self:CState("BVState", not self:Get("PVU5")) --FIXME
            self:CState("AsyncEDone", AsyncInverter.EDone>0) --FIXME

            self:CState("NoHV", Electric.Main750V < 550)

            local TR = Train.TR
            self:CState("PantDisabled", TR.ContactState1==0 and TR.ContactState2==0 and TR.ContactState3==0 and TR.ContactState4==0)
            self:CState("DisablePant", self.DisablePant>0)
        else
            local speed = Train.Speed
            self.EDone = self.Brake*((speed<=5 or speed<=10 and (self.Mode==0 or self.EDone > 0)) and 1 or 0)
            self.Mode = self.Brake
            self:CState("AsyncEDone", self.EDone>0) --FIXME
        end
        self:CState("LightsEnabled", Train.Panel.MainLights>0) --FIXME
        self:CState("Vent1Enabled", Train.Electric.Vent1>0)
        self:CState("Vent2Enabled", Train.Electric.Vent2>0)
        --? Сигнал датчика  противозажатия дверей
        --! Сигнал датчика положения токоприёмников
        --? Сигнал датчика состояния замка торцевой двери
        --? Сигнал датчика исправности мотор-компрессора
        --! Сигнал датчика  положения блок-тормоза 5 – 8
        --? Сигнал датчика перегрева букс 1 – 4
        --? Сигнал датчика перегрева букс 5 – 8
        --? Ток потребления МК
        --? Ток потребления ВО
        --? Сигнал датчика замыкания 75 В на корпус
        --? Состояние петли безопасности
        --? Неисправность вентилятора тормозного реостата

        self:CState("PVU1", self:Get("PVU1"))
        self:CState("PVU2", self:Get("PVU2"))
        self:CState("PVU3", self:Get("PVU3"))
        self:CState("PVU4", self:Get("PVU4"))
        self:CState("PVU5", self:Get("PVU5"))
        self:CState("PVU6", self:Get("PVU6"))
        self:CState("BUKVTimer", math.floor((CurTime()*2)%10))
    elseif self.States.BUKVTimer then
        for k,v in pairs(self.Commands) do
            self.Commands[k] = false
        end
        for k,v in pairs(self.States) do
            self.States[k] = false
        end
    end

    if self.Reset and self.Reset ~= CurTime() then
        self.Reset = nil
    end

    if self.Emer ~= Train.Electric.Emer then
        self.Emer = Train.Electric.Emer
        if self.Emer > 0 then
            for i=1,6 do
                self.States["PVU"..i] = false
            end
        end
    end

    local PTReplace = self.States.AsyncEFail
    if PTReplace and not self.PTReplace and Train.Electric.HaveAsyncInverter>0 then
        self.PTReplace =  CurTime()
        if self.States.AsyncProtection == 0 or self:Get("PVU5")  or self:Get("PVU6")  then
            self.PTReplace = self.PTReplace - 1.2
        elseif self.States.AsyncAssembly then
            self.PTReplace = self.PTReplace + 1.3
        end
    end
    if not PTReplace and self.PTReplace then self.PTReplace = nil end
    local PN =  self.PTReplace and CurTime()-self.PTReplace > 1.2 or self.States.AsyncEDone
    self.PN1 = self:Get("PN1") or PN and (self:Get("DriveStrength") and self:Get("DriveStrength") > 0) or self:Get("ARSBrake") and (Train.Electric.Type>1 or not self.States.AsyncAssembly)
    self.PN2 = self:Get("PN2") or PN and (self:Get("DriveStrength") and (not self.States.AsyncEDone and self:Get("DriveStrength") > 0.2 or self:Get("BrakeTPlus")))

    --self.MK = (not self:Get("PVU3") and self:Get("Compressor"))and 1 or 0

    self.OpenLeft = not self:Get("PVU1") and (self:Get("OpenLeft") and self.Orientation or self:Get("OpenRight") and not self.Orientation)
    self.OpenRight = not self:Get("PVU1") and (self:Get("OpenRight") and self.Orientation or self:Get("OpenLeft") and not self.Orientation)
    self.OpenRightBack = self:Get("OpenRightBack") and Train.Electric.HaveBUKP>0
    self.CloseDoors = self:Get("PVU1") or self:Get("CloseDoors")
    local strength,brake = self:Get("DriveStrength") or 0,self:Get("Brake") and 1 or 0
    self.Drive = (1-brake)*(strength>0 and 1 or 0)
    self.Brake = brake*(strength>0 and 1 or 0)
    local BCPressure = self.States.BCPressure or 0
    if self.Brake>0 and BCPressure < 1.5 or self.Drive>0 and BCPressure < 0.5 then
        self.Strength = strength*100
    else
        self.Strength = 0
    end
    local clRing = self:Get("CloseRing")
    if self.CloseRing ~= clRing then
        self.CloseRing = clRing
        if clRing then Train:PlayOnce("door_alarm",1,1) end
    end
    self.DisableLights = self:Get("PVU2") and 1 or 0
    self.EnableLights = self:Get("PassLight") and 1 or 0
    self.DisablePSN = self:Get("PVU3") and 1 or 0
    self.EnableMK = (not self:Get("PVU4") and self:Get("Compressor")) and 1 or 0
    self.DisableTP = (self:Get("PVU5") or self:Get("PVU6")) and 1 or 0
    self.DisablePant = self:Get("DisablePant") and 1 or 0
    self.ParkingBrake = self:Get("ParkingBrake")
    local vent = self:Get("PassVent") or 0
    if vent==1 then
        self.VentMode = Train.Pneumatic.WeightLoadRatio>0.6 and 2 or Train.Pneumatic.WeightLoadRatio>0.1 and 1 or 0
    elseif vent>1 then
        self.VentMode = vent-1
    else
        self.VentMode = vent
    end

    self.Orientation = Train:ReadTrainWire(4) > 0
    self.RevOrientation = Train:ReadTrainWire(3) > 0
    local BadOrientation = false
    if self.Orientation and self.Orientation  == self.RevOrientation then
        self.Orientation = false
        self.RevOrientation = false
        BadOrientation = true
    end
    if self.State and self.Orientation ~= self.RevOrientation then
        if not self.BadOrientation and self.OrientateBUP and (not self.Commands[self.OrientateBUP] or self.Orientation and self.Commands.Forward ~= self.OrientateBUP or self.RevOrientation and self.Commands.Back ~= self.OrientateBUP) then
            if self.Orientation then self.Commands.Forward = self.OrientateBUP else self.Commands.Back = self.OrientateBUP end
            self.OrientateBUP = nil
        elseif BadOrientation then
            self.OrientateBUP = nil
        end
    elseif not self.State then self.OrientateBUP = nil end
    local ReOrientation = self.State and (self.Orientation or self.RevOrientation) and (self.Orientation ~= self.PrevOrientation or self.RevOrientation ~= self.PrevRevOrientation or self.CurrentBUP ~= (self.Orientation and self.Commands.Forward or self.Commands.Back))
    if ReOrientation then
        self.CurrentBUP = self.Orientation and self.Commands.Forward or self.Commands.Back
        self.Reset = CurTime()
        if self.CurrentBUP then
            self.Commands[self.CurrentBUP]  = {}
            Train:CANWrite("BUKV",Train:GetWagonNumber(),"BUKP",self.CurrentBUP,"Get")
        end
    end
    self.BadOrientation = BadOrientation
    self.PrevOrientation = self.State and self.Train:ReadTrainWire(4) > 0
    self.PrevRevOrientation = self.State and self.Train:ReadTrainWire(3) > 0
end
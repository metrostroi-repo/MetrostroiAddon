--------------------------------------------------------------------------------
-- 81-722 electric schemes
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_722_Electric")
TRAIN_SYSTEM.DontAccelerateSimulation = false

local function Clamp(val,min,max)
    return math.max(min,math.min(max,val))
end

TRAIN_SYSTEM.T722 = 0
TRAIN_SYSTEM.T723 = 1
TRAIN_SYSTEM.T724 = 2
function TRAIN_SYSTEM:Initialize()
    self.Type = self.Type or self.T722
    self.HaveBUKP = 0--self.HaveBUKP or self.Type==self.T722 and 1 or 0
    self.HaveAsyncInverter = 0--self.HaveAsyncInverter or self.Type<self.T724 and 1 or 0

    self.Train:LoadSystem("Battery","Relay","")
    self.Train:LoadSystem("BatteryOn","Relay",nil,{bass=true,open_time=0,close_time=3})
    self.Train:LoadSystem("BatteryOff","Relay",nil,{bass=true,open_time=0,close_time=3})

    self.Power = 0
    self.BatterySound = 0
    self.CabActive = 0
    self.CabActiveVRU = 0
    self.Emer = 0

    self.BUFT =0

    self.AsyncEmer = 0
    self.AsyncActive = 0
    self.Reverser = 0

    self.BTBPower = 0
    self.BTB = 0

    self.Main750V = 0
    self.Aux750V  = 0
    self.Power750V = 0

    self.MK = 0
    self.PSN = 0
    self.Vent1 = 0
    self.Vent2 = 0
    self.LightsHV = 0
    self.DisablePant = 0

    self.V1 = 0
    self.V6Power = 0
    self.LSD = 0

    self.Recurperation = 0
    self.Iexit = 0
    self.Chopper = 0

    self.ElectricEnergyUsed = 0
    self.ElectricEnergyDissipated = 0
end


function TRAIN_SYSTEM:Inputs()
    return { "Type"}
end

function TRAIN_SYSTEM:Outputs()
    return {
        "Main750V","Aux750V","Power750V",
        "Type","HaveBUKP","HaveAsyncInverter","Power","BatterySound","CabActive","CabActiveVRU","Emer","BUFT","AsyncEmer","AsyncActive","Reverser","BTB","BTBPower","BARSPower","V6Power","LSD",
        "PSN","Vent1","Vent2","MK","DisablePant","V1",
        "Recurperation","Iexit","Chopper","ElectricEnergyUsed","ElectricEnergyDissipated","EnergyChange","Itotal"
}
end
function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "Type" then
        self.Type = value
        self.HaveBUKP = self.Type==self.T722 and 1 or 0
        self.HaveAsyncInverter = self.Type<self.T724 and 1 or 0
    end
end

local S = {}
local function C(x) return x and 1 or 0 end
local min = math.min
local wires = {5,6,8,-8,9,12,13,15,19,24,26,32,33,34,36,50}

function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    local Panel = Train.Panel
    local BUKV = Train.BUKV
    local W  = Train.TrainWires
    if not W then
        W = {}
        for _,v in ipairs(wires) do W[v] = 0 end
        Train.TrainWires = W
    end
    for _,v in ipairs(wires) do W[v] = min(Train:ReadTrainWire(v),1) end

    self.Main750V = Train.TR.Main750V
    self.Aux750V  = Train.TR.Main750V
    self.Power750V = self.Main750V--*Train.BRU.Value


    ----------------------------------------------------------------------------
    -- Some internal electric
    ----------------------------------------------------------------------------

    local BO = min(1,Train.Battery.Value+W[50]*Train.SF31.Value)
    self.Power = BO

    if self.HaveBUKP > 0 then
        Train:WriteTrainWire(5,Train.SF1.Value*(Train.BattOn.Value+BO*(1-Train.Battery.Value)))
        Train:WriteTrainWire(6,BO*Train.SF1.Value*(Train.BattOff.Value+Train.BatteryOff.Value))
        S["RU"] = BO*Train.SF4.Value*C(Train.VRU.Value==0)
        self.CabActiveVRU = BO*C(Train.VRU.Value==2)*Train.SF2.Value
        self.CabActive = BO*C(Train.VRU.Value>0)*((self.CabActiveVRU+Train.BUKP.Active)*Train.SF3.Value+S["RU"])*Train.SF2.Value
        Panel.LRU = BO*(1-self.CabActive)
        Panel.AVS = BO*Train.Pneumatic.SD2
        Panel.EmergencyDriveL = S["RU"]
        Panel.EmergencyBrakeTPlusL = S["RU"]

        S["RV"] = BO*self.CabActive*Train.SF2.Value
        Train:WriteTrainWire(4,S["RV"]*Train.SF21.Value)
        Train:WriteTrainWire(3,0)
        S["RVnE"] = BO*self.CabActive*Train.SF2.Value
        Train:WriteTrainWire(12,math.max(S["RV"]*C(Train.KRO.Value==2)+S["RU"]))
        Train:WriteTrainWire(13,S["RVnE"]*C(Train.KRO.Value==0))
        Train:WriteTrainWire(36,BO*Train.SF3.Value*C(Train.VRU.Value >0)*self.CabActive)
        Train:WriteTrainWire(34,S["RU"])
        Train:WriteTrainWire(19,S["RU"]*Train.EmergencyDrive.Value)

        Train:WriteTrainWire(27,BO*S["RU"])
        Train:WriteTrainWire(29,self.BTB*S["RU"]*(C(Panel.Controller<=-2)+Train.EmergencyBrakeTPlus.Value))
        Train:WriteTrainWire(30,self.BTB*S["RU"]*C(Panel.Controller<=-1))

        Panel.V4 = (S["RVnE"]*C(Train.KRO.Value~=1)+S["RU"])*Train.SF6.Value

        Train:WriteTrainWire(-8,BO*min(1,(S["RV"]+S["RU"]))*Train.SF7.Value)
        Train:WriteTrainWire(9,W[8]*(1-self.CabActive)*C(Train.VRU.Value==1)*Train.SF7.Value)
        self.LSD = W[9]*Train.SF7.Value

        S["V6m"] =  min(1,Train.BARS.EPK*Train.RCARS.Value+(1-Train.RCARS.Value)*(Train.PB.Value+Train.VAH.Value))
        local BTB = Panel.V4*(1-Train.Pneumatic.SD2)*S["V6m"]
        --Train:WriteTrainWire(24,BTB*(1-Train.EmergencyBrake.Value))
        --Train:WriteTrainWire(25,BTB == 0 and W[26] > 0 and W[24]*self.BTB or 0)

        self.V6Power = BO*Train.SF5.Value*S["V6m"]

        if BTB > 0 then
            if self.BTBTimer == nil then self.BTBTimer = CurTime() end
            if self.BTBTimer and CurTime()-self.BTBTimer>0.3 then self.BTBTimer = false end
        else
            self.BTBTimer = nil
        end
        self.BTBPower = BTB
        self.BTB = min(1,(self.BTBTimer~=false and 1 or 0)+self.BTB*W[26])
        if BTB > 0 and W[26]==0 and not self.TestTimer then
            self.TestTimer = CurTime()
        elseif W[26]>0 and self.TestTimer then
            self.TestTimer = nil
        end
        S["NEmergencyBrake"] = (1-Train.EmergencyBrake.Value)*C(Panel.Controller~=-3)
        Train:WriteTrainWire(26,(1-BTB)*W[24]*S["NEmergencyBrake"])
        Train:WriteTrainWire(24,BTB*S["NEmergencyBrake"])
        Train:WriteTrainWire(25,BTB*self.BTB*(self.KTR==3 and 0 or 1))

        Train:WriteTrainWire(37,(S["RU"]+Train.BUKP.DoorRight)*Train.SF7.Value*Train.DoorRight.Value)
        Train:WriteTrainWire(38,(S["RU"]+Train.BUKP.DoorLeft)*Train.SF7.Value*(Train.DoorLeft1.Value+Train.DoorLeft2.Value))
        Train:WriteTrainWire(39,S["RU"]*Train.SF7.Value*C(Train.DoorClose.Value==0))


        Panel.BattOn = BO
        Panel.BattOff = BO*Train.BatteryOff.Value

        Panel.RC = Train.EmergencyRadioPower.Value
        Panel.CabLights = (BO*Train.CabinLight.Value/2+Panel.RC*0.5--[[ *(0.5-Train.PanelLight.Value/4)--]] )*Train.SF25.Value
        Panel.VPR1 = (BO+Panel.RC)*Train.SF14.Value
        Panel.VPR2 = (BO+Panel.RC)*Train.SF15.Value
        Panel.PanelLights = BO*Train.PanelLight.Value*Train.SF25.Value


        Panel.Headlights1 = (S["RV"]+S["RU"])*C(Train.KRO.Value==2)*Train.SF22.Value*C(Train.Headlights.Value==1)
        Panel.Headlights2 = (S["RV"]+S["RU"])*C(Train.KRO.Value==2)*Train.SF22.Value*C(Train.Headlights.Value==2)
        Panel.RedLights = (BO*Train.SF22.Value+Train.VKF.Value*Train.SF23.Value)*(1-S["RVnE"]+C(Train.KRO.Value<2))
        Panel.SOSD = S["RV"]*Train.SF7.Value*Train.SF24.Value*Train.BUKP.SOSD*(1-self.LSD)
        Panel.BARSPower = BO*min(1,(Train.SF8.Value*C(Train.BARSMode.Value > 0)+Train.SF9.Value*C(Train.BARSMode.Value < 2))*Train.RCARS.Value)
        Panel.ARSPower = Panel.BARSPower*(1-Train.BUKP.Back)*Train.ARS.Value
        Panel.ALSPower = Panel.BARSPower*(1-Train.BUKP.Back)*Train.ALS.Value

        Panel.UPOPower = BO*S["RV"]*Train.R_UPO.Value
        Train:WriteTrainWire(15,BO*(Train.UPO.LineOut*Train.SarmatUPO.UPOActive+Train.SarmatUPO.LineOut))
        --print(W[15],Train.UPO.LineOut*Train.SarmatUPO.UPOActive,Train.SarmatUPO.LineOut)

        self.Emer = S["RU"]
    end
    S["DoorsP"] = BO*Train.SF36.Value
    Train:WriteTrainWire(8,W[-8]*S["DoorsP"]*Train.S1.Value)

    Panel.DoorsW = S["DoorsP"]*(1-Train.S1.Value)
    Panel.BrW = BO*Train.SF36.Value*Train.Pneumatic.SD3
    Panel.AnnouncerPlaying = W[15]
    S["WagP"] = Train.Battery.Value*Train.SF33.Value
    if self.HaveAsyncInverter > 0 then
        local Async = Train.AsyncInverter
        local HV = BO*C(550 < self.Aux750V and self.Aux750V < 975)
        self.AsyncEmer = W[34]*Train.SF59.Value
        self.AsyncActive = min(1,W[36]*Train.SF58.Value+self.AsyncEmer)
        self.Reverser = self.AsyncActive*(W[12]-W[13])
        Panel.GRP = BO*((1-Train.SF56.Value)+BUKV.DisableTP)


        Async:TriggerInput("Power",BO*Train.SF56.Value*(1-BUKV.DisableTP))

        local command = 0

        if self.AsyncEmer > 0 then
            command = self.AsyncEmer*W[19]
            Async:TriggerInput("Drive",command)
            Async:TriggerInput("Brake",0)
        else
            Async:TriggerInput("Drive",BUKV.Drive)
            Async:TriggerInput("Brake",BUKV.Brake)
            command = (BUKV.Strength/100)*(BUKV.Drive-BUKV.Brake)
        end
        --print(Format("%.2f %.2f %d %.2f",command,Async.Speed,Async.Mode,Async.State))
        local speed = math.abs(Async.Speed)
        if command > 0 then
            Async:TriggerInput("TargetTorque",(math.abs(command)^0.75)*(1.0+Clamp(speed/15,0,1)-Clamp((speed-30)/35,0,2))*(1+Train.Pneumatic.WeightLoadRatio*0.3))
        elseif command < 0 then
            Async:TriggerInput("TargetTorque",Clamp((speed-2)/6,0,1)*math.abs(command)*2.4*(1+Train.Pneumatic.WeightLoadRatio*0.3))
        else
            Async:TriggerInput("TargetTorque",0)
        end

        self.PSN = HV*(1-BUKV.DisablePSN)
        self.LightsHV = min(1,self.PSN+self.LightsHV)*BUKV.EnableLights
        if self.PSN == 0 then
            if not self.PassLightsTimer then self.PassLightsTimer = CurTime() end
            if self.PassLightsTimer and CurTime()-self.PassLightsTimer > 20 then self.LightsHV = 0 end
        elseif self.PassLightsTimer then
            self.PassLightsTimer = nil
        end
        Train:WriteTrainWire(32,self.LightsHV)
        Train:WriteTrainWire(33,self.PSN)
        self.MK = self.PSN*BUKV.EnableMK

        self.DisablePant = BO*BUKV.DisablePant*Train.SF37.Value

        self.EnergyChange = Async.Mode>0 and (Async.Current^2)*2.8 or 0
        self.Itotal = Async.Current
        --[[ if self.Main750V > 900 or Async.Mode>0 then
            self.Recurperation = false
        elseif self.Main750V < 875 and Async.Mode<0 then
        end--]]
        if Async.Mode<0 and Async.State>0 then
            self.Recurperation = self.Main750V < 940 and 1 or 0
            self.Iexit = self.Iexit+(-Async.Current*2*self.Recurperation-self.Iexit)*dT*2
            --[[ if self.Main750V>550 then
                self.Iexit = self.Iexit+(-Async.Current*2*self.Recurperation-self.Iexit)*dT*2
            else
                self.Iexit = 0
            end--]]
            self.Chopper = (self.Main750V>910 or self.Main750V<550)  and 1 or 0
        else
            self.Recurperation = 0
            self.Iexit = 0
            self.Chopper = 0
        end
        --print(self.Recurperation,self.Iexit,self.Main750V)
        self.ElectricEnergyUsed = self.ElectricEnergyUsed + math.max(0,self.EnergyChange)*dT
        self.ElectricEnergyDissipated = self.ElectricEnergyDissipated + math.max(0,-self.EnergyChange)*dT
    end
    local vent = Train.BUKV.VentMode
    self.Vent1 = (BO*C(vent==-1)+W[33]*C(vent>0))*Train.SF47.Value
    self.Vent2 =W[33]*C(vent>1)*Train.SF48.Value
    Panel.MainLights = W[32]*Train.SF45.Value*(1-BUKV.DisableLights)
    Panel.EmergencyLights = S["WagP"]*Train.SF45.Value*Train.SF46.Value
    self.BUFT = BO*Train.SF55.Value
    Train.BatteryOn:TriggerInput("Set",W[5]*Train.SF32.Value)
    Train.BatteryOff:TriggerInput("Set",W[6]*Train.SF32.Value)
    local BatterySound = (1-Train.Battery.Value)*Train.BatteryOn.TargetValue+Train.Battery.Value*Train.BatteryOff.TargetValue
    if BatterySound~=self.BatterySound then
        self.BatterySound = BatterySound
        if BatterySound>0 then  Train:PlayOnce("battery_pneumo","bass",1) end
    end
    Train.Battery:TriggerInput("Close",Train.BatteryOn.Value)
    Train.Battery:TriggerInput("Open",Train.BatteryOff.Value)
    Train:WriteTrainWire(50,Train.Battery.Value)


    Panel.PassSchemePowerL = BO*Train.SF34.Value
    Panel.PassSchemePowerR = BO*Train.SF35.Value
    --self.Train:LoadSystem("BatteryOn","Relay",nil,{open_time=0.6,close_time=8})
    --self.Train:LoadSystem("BatteryOff","Relay",nil,{open_time=0.6,close_time=8})
        --[[ --OU
        Train:WriteTrainWire(34,P*(Train.RV["KRO1-2"]*Train.SF2.Value + Train.RV["KRR1-2"]*Train.SF3.Value))
        --RU
        Train:WriteTrainWire(36,Train.SF3.Value*Train.EmergencyControls.Value)

        --XOD1
        Train:WriteTrainWire(19,P*Train.RV["KRR7-8"]*Train.SF10.Value*Train.BARS.BTB*Train.EmerX1.Value)
        --XOD2
        Train:WriteTrainWire(45,P*Train.RV["KRR7-8"]*Train.SF10.Value*Train.BARS.BTB*Train.EmerX2.Value)

        --ORIENTATION

        --PARKING
        Train:WriteTrainWire(11,P*Train.ParkingBrake.Value)
        local KM1 = P*Train.SF6.Value*Train.RV["KRO11-12"]
        local KM2 = P*Train.SF6.Value*Train.RV["KRO15-16"]
        --REVERSER
        Train:WriteTrainWire(12,P*(Train.RV["KRR3-4"]+KM1)*Train.SF11.Value)
        Train:WriteTrainWire(13,P*(Train.RV["KRR9-10"]+KM2)*Train.SF11.Value)

        --EMER BRAKE
        --BTB
        Train:WriteTrainWire(10,P*Train.EmergencyCompressor.Value)

        Train:WriteTrainWire(40,P*Train.EmergencyDoors.Value)
        Train:WriteTrainWire(39,P*Train.SF22.Value*Train.EmerCloseDoors.Value)
        Train:WriteTrainWire(38,P*Train.SF21.Value*Train.DoorLeft.Value)
        Train:WriteTrainWire(37,P*Train.SF21.Value*Train.DoorRight.Value)
        --]]
end

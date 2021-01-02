AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner
ENT.SyncTable = {
    "SF1","SF2","SF3","SF4","SF5","SF6","SF7","SF8","SF9","R_UPO","SF01","SF10","SF11","SF12","SF13","SF02",
    "SF14","SF15","SF16","SF17","SF18","SF19","SF20","SF21","SF22","SF23","SF24","SF25","SF26","SF27","SF03","SF04",

    "SF31","SF32","SF33","SF34","SF35","SF36","SF37","SF38","SF41","SF42","SF43","SF44","SF45","SF46","SF47","SF48","SF49","SF51","SF52","SF53","SF54","SF55","SF56","SF57","SF58","SF59",

    "PSNToggle","BattOn","BattOff","TorecDoorUnlock",

    "PassLight","VKF","ParkingBrake","VRD","SOSDEnable","VAD","VAH","EmergencyRadioPower","RCARS",

    "MirrorHeating","DoorLeft2","DoorBack","EmergencyDrive","Microphone","DoorLeft1",

    "ARS","ALS","GlassWasher","EmergencyBrakeTPlus","EmergencyBrakeTPlusK","EmergencyBrake","Vigilance","DoorSelect","DoorRight",

    "PanelLight",

    "Ring",

    "K9", "K29",

    "EmergencyBrakeValve","UAVA",

    "FrontBrakeLineIsolation","FrontTrainLineIsolation",
    "RearBrakeLineIsolation","RearTrainLineIsolation",
    "PB",

}
--------------------------------------------------------------------------------
function ENT:Initialize()
    self.Plombs = {
        EmergencyBrakeTPlusK = true,
        VRU=true,
        VAH = true,
        VAD=true,
        EmergencyRadioPower = true,
        BARSMode = true,
        PantSC = true,
        RCARS = true,
        K9 = true,
        UAVA = true,
        Init=true,
    }
    -- Set model and initialize
    self:SetModel("models/metrostroi_train/81-722/81-722.mdl")
    self.BaseClass.Initialize(self)
    self:SetPos(self:GetPos() + Vector(0,0,140))

    -- Create seat entities
    self.DriverSeat = self:CreateSeat("driver",Vector(450-2,11,-35+2))
    self.InstructorsSeat = self:CreateSeat("instructor",Vector(430,35,-30))
    self.InstructorsSeat2 = self:CreateSeat("instructor",Vector(430,-20,-30))

    -- Hide seats
    self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.DriverSeat:SetColor(Color(0,0,0,0))
    self.InstructorsSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.InstructorsSeat:SetColor(Color(0,0,0,0))
    self.InstructorsSeat2:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.InstructorsSeat2:SetColor(Color(0,0,0,0))

    -- Create bogeys
    self.FrontBogey = self:CreateBogey(Vector( 322,0,-90),Angle(0,180,0),true,"722")
    self.RearBogey  = self:CreateBogey(Vector(-333,0,-90),Angle(0,0,0),false,"722")
    self.FrontBogey:SetNWBool("Async",true)
    self.RearBogey:SetNWBool("Async",true)
    self.FrontBogey:SetNWFloat("SqualPitch",0.75)
    self.RearBogey:SetNWFloat("SqualPitch",0.75)
    self.FrontBogey:SetNWBool("DisableEngines",true)
    self.RearBogey:SetNWBool("DisableEngines",true)
    if Metrostroi.BogeyOldMap then
        self.FrontCouple = self:CreateCouple(Vector( 448-6,0,-77),Angle(0,0,0),true,"722")
        self.RearCouple  = self:CreateCouple(Vector(-419.5-7.5+6,0,-77),Angle(0,180,0),false,"717")
    else
        self.FrontCouple = self:CreateCouple(Vector( 454    -8,0,-79),Angle(0,0,0),true,"722")
        self.RearCouple  = self:CreateCouple(Vector(-419-6.8+8,0,-79),Angle(0,180,0),false,"717")
    end
    self.FrontBogey.DisableSound = 1
    self.RearBogey.DisableSound = 1

    -- Initialize key mapping
    self.KeyMap = {
        [KEY_W] = "PanelKVUp",
        [KEY_S] = "PanelKVDown",
        [KEY_1] = "PanelKV1",
        [KEY_2] = "PanelKV2",
        [KEY_3] = "PanelKV2",
        [KEY_4] = "PanelKV4",
        [KEY_5] = "PanelKV5",
        [KEY_6] = "PanelKV6",
        [KEY_7] = "PanelKV7",
        [KEY_8] = "EmergencyDriveSet",

        [KEY_0] = "KRO+",
        [KEY_9] = "KRO-",
        [KEY_V] = "DoorCloseA",
        [KEY_A] = "DoorLeft",
        [KEY_D] = "DoorRight",
        [KEY_SPACE] = "PBSet",
        [KEY_BACKSPACE] = {"EmergencyBrakeToggle",helper="EmergencyBrakeValveToggle"},
        [KEY_PAD_ENTER] = "KVWrenchKV",
        [KEY_LSHIFT] = {
            [KEY_2] = "RingSet",
            [KEY_S] = "PanelKV7",
            [KEY_V] = "DoorCloseM",
            [KEY_SPACE] = "VigilanceSet",

            [KEY_PAD_ENTER] = "KVWrenchNone",
        },
        [KEY_LALT] = {
            [KEY_UP] = "SarmatUpSet",
            [KEY_DOWN] = "SarmatDownSet",
            [KEY_RIGHT] = "SarmatEnterSet",
            [KEY_LEFT] = "SarmatEscSet",
            [KEY_PAD_1] = "SarmatF1Set",
            [KEY_PAD_2] = "SarmatF2Set",
            [KEY_PAD_3] = "SarmatF3Set",
            [KEY_PAD_4] = "SarmatF4Set",
        },

        [KEY_F] = "PneumaticBrakeUp",
        [KEY_R] = "PneumaticBrakeDown",
        [KEY_PAD_1] = "PneumaticBrakeSet1",
        [KEY_PAD_2] = "PneumaticBrakeSet2",
        [KEY_PAD_3] = "PneumaticBrakeSet3",
        [KEY_PAD_4] = "PneumaticBrakeSet4",
        [KEY_PAD_5] = "PneumaticBrakeSet5",
        [KEY_PAD_6] = "PneumaticBrakeSet6",
        [KEY_PAD_MULTIPLY] = "EmergencyDriveSet",

        [KEY_L] = "HornEngage",
    }
    self.TrainWireInverts = { [8]=true }
    -- Cross connections in train wires
    self.TrainWireCrossConnections = {
        [4] = 3, -- Orientation F<->B
        [13] = 12, -- Reverser F<->B
        [38] = 37, -- Doors L<->R
    }

    self.InteractionZones = {
        {
            ID = "RearTrainLineIsolationToggle",
            Pos = Vector(-469.8, -34, -65), Radius = 8,
        },
        {
            ID = "RearBrakeLineIsolationToggle",
            Pos = Vector(-469.8, 35, -65), Radius = 8,
        },
        {
            ID = "RearDoor",
            Pos = Vector(-464.8, -38, 0), Radius = 20,
        },
        {
            ID = "PassengerDoor",
            Pos = Vector(374, -7, 0), Radius = 13,
        },
        {
            ID = "CabinDoorLeft",
            Pos = Vector(400, 62, -7), Radius = 20,
        },
        {
            ID = "CabinDoorLeft",
            Pos = Vector(400, 62, -30), Radius = 20,
        },
        {
            ID = "CabinDoorRight",
            Pos = Vector(400, -62, -7), Radius = 20,
        },
        {
            ID = "CabinDoorRight",
            Pos = Vector(400, -62, -30), Radius = 20,
        },
    }

    self.Lights = {
        [1]  = { "light",           Vector(493  ,   -60, -36), Angle(0,0,0), Color(200,255,255), brightness = 0.5, scale = 2.5, texture = "sprites/light_glow02.vmt" },
        [2]  = { "light",           Vector(493  ,   62, -36), Angle(0,0,0), Color(200,255,255), brightness = 0.5, scale = 2.5, texture = "sprites/light_glow02.vmt" },
        [3]  = { "light",           Vector(490,   -65, 15), Angle(0,0,0), Color(255,50,50), brightness = 0.2, scale = 4, texture = "sprites/light_glow02.vmt" },
        [4]  = { "light",           Vector(489,   60, 15), Angle(0,0,0), Color(255,50,50), brightness = 0.2, scale = 4, texture = "sprites/light_glow02.vmt" },
        [10] = { "dynamiclight",    Vector( 440, 0, 14), Angle(0,0,0), Color(255,255,255), brightness = 0.25, distance = 550 },
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

    self.PassengerDoor = false
    self.CabinDoorLeft = false
    self.CabinDoorRight = false
    self.RearDoor = false

    self:SetNW2Float("UPONoiseVolume",math.Rand(0,0.3))
    self:SetNW2Float("UPOVolume",math.Rand(0.8,1))

    self.Scheme = 1
end

function ENT:NonSupportTrigger()
    self.VAH:TriggerInput("Set",1)
    self.RCARS:TriggerInput("Set",0)
    self.K9:TriggerInput("Set",0)
    self.Plombs.VAH = nil
    self.Plombs.RCARS = nil
    self.Plombs.K9 = nil
end

function ENT:OnUPOArrived()
    return self.SarmatUPO:TriggerInput("CheckUPO")
end

--------------------------------------------------------------------------------
function ENT:Think()
    local retVal = self.BaseClass.Think(self)
    local power = self.BUKV.Power > 0

    --self:SetPackedRatio("async1", math.min(self.Speed/7,self.AsyncInverter.State*math.Clamp(1+(self.Speed-15)/120,1,2)))
    --self:SetPackedRatio("async1state", self.AsyncInverter.State)
    --self:SetPackedRatio("asyncfreq", self.AsyncInverter.InverterFrequency)
    --print()
    if self.AsyncInverter.State==1 then
        local state = math.abs(self.AsyncInverter.InverterFrequency/13)--(10+8*math.Clamp((self.AsyncInverter.State-0.4)/0.4,0,1)))
        self:SetPackedRatio("asynccurrent", math.Clamp(state*(state+self.AsyncInverter.State/1),0,1))
    else
        local state = math.abs(self.AsyncInverter.InverterFrequency/(11+self.AsyncInverter.State*5))--(10+8*math.Clamp((self.AsyncInverter.State-0.4)/0.4,0,1)))
        self:SetPackedRatio("asynccurrent", math.Clamp(state*(state+self.AsyncInverter.State/1),0,1))
    end
    self:SetPackedRatio("asyncstate", math.Clamp(self.AsyncInverter.State/0.2*math.abs(self.AsyncInverter.Current)/100,0,1))
    self:SetPackedRatio("chopper", math.Clamp(self.Electric.Chopper>0 and self.Electric.Iexit/100 or 0,0,1))
    --print(self.Electric.Chopper,self.Electric.Iexit/100)

    self:SetPackedBool("BattOnL",self.Panel.BattOn)
    self:SetPackedBool("BattOffL",self.Panel.BattOff)

    self:SetPackedBool("BattPressed",self.Electric.BatterySound>0)

    self:SetPackedRatio("ControllerPosition",self.Panel.Controller)
    self:SetPackedRatio("ReverserPosition",self.KRO.Value/2)
    self:SetPackedRatio("CompressorPosition",self.Compressor.Value)
    self:SetPackedRatio("PassVent",self.PassVent.Value/4)
    self:SetPackedRatio("VRU",self.VRU.Value/2)
    self:SetPackedRatio("BARSMode",self.BARSMode.Value/2)
    self:SetPackedRatio("PantSC",self.PantSC.Value/4)
    self:SetPackedRatio("GlassCleaner",self.GlassCleaner.Value/2)
    self:SetPackedRatio("Headlights",self.Headlights.Value/2)
    self:SetPackedRatio("DoorClose",self.DoorClose.Value/2)
    self:SetPackedRatio("CabinLight",self.CabinLight.Value/2)
    self:SetPackedBool("LampLPT",self.BUKP.LPT)
    self:SetPackedBool("LampRU",self.Panel.LRU)
    self:SetPackedBool("LampAVS",self.Panel.AVS)
    self:SetPackedBool("LampRC",self.Panel.RC)
    self:SetPackedBool("LampSD",self.Electric.LSD > 0)

    self:SetPackedBool("RadioRVS",self.Panel.VPR1>0)
    self:SetPackedBool("RadioMotorola",self.Panel.VPR2>0)

    self:SetPackedBool("LampLRD",self.BARS.F6 > 0)
    self:SetPackedBool("Lamp04",self.BARS.NoFreq > 0)
    self:SetPackedBool("Lamp0",self.BARS.F5 > 0)
    self:SetPackedBool("Lamp40",self.BARS.F4 > 0)
    self:SetPackedBool("Lamp60",self.BARS.F3 > 0)
    self:SetPackedBool("Lamp70",self.BARS.F2 > 0)
    self:SetPackedBool("Lamp80",self.BARS.F1 > 0)

    local cablight = self.Panel.CabLights
    self:SetLightPower(10,cablight > 0,cablight)
    self:SetPackedBool("CabinEnabledEmer", cablight > 0)
    self:SetPackedBool("CabinEnabledFull", cablight > 0.3)
    self:SetPackedBool("PanelLighting",self.Panel.PanelLights>0)
    local HeadlightsPower = self.Panel.Headlights2 > 0 and 1 or self.Panel.Headlights1 > 0 and 0.5 or 0
    self:SetPackedBool("Headlights1",self.Panel.Headlights1 > 0)
    self:SetPackedBool("Headlights2",self.Panel.Headlights2 > 0)

    self:SetLightPower(1,HeadlightsPower > 0,HeadlightsPower^0.5)
    self:SetLightPower(2,HeadlightsPower > 0,HeadlightsPower^0.5)
    self:SetPackedRatio("Headlight",HeadlightsPower)
    self:SetPackedBool("RedLights",self.Panel.RedLights>0)
    self:SetLightPower(3,self.Panel.RedLights>0)
    self:SetLightPower(4,self.Panel.RedLights>0)

    local passlight = math.min(1,self.Panel.MainLights+self.Panel.EmergencyLights*0.3)
    --self:SetLightPower(11,power and mul > 0, mul)
    self:SetLightPower(11,passlight > 0, passlight)
    self:SetLightPower(12,passlight > 0, passlight)
    self:SetLightPower(13,passlight > 0, passlight)
    self:SetPackedRatio("SalonLighting",passlight)

    self:SetPackedBool("CompressorWork",self.Pneumatic.Compressor)

    self:SetPackedBool("DoorLeftLamp",self.BUKP.DoorLeft)
    self:SetPackedBool("DoorRightLamp",self.BUKP.DoorRight)
    self:SetPackedBool("EmergencyBrakeTPlusL",self.Panel.EmergencyBrakeTPlusL > 0)
    self:SetPackedBool("EmergencyDriveL",self.Panel.EmergencyDriveL > 0)

    --self:SetPackedRatio("BatteryVoltage",(self.BUKV.Battery and (self.BUKV.PSN and 82 or 65) or 0)/150)
    self:SetPackedRatio("HighVoltage",self.TR.Main750V/1000)
    self:SetPackedRatio("LV",(self.Electric.Power*(65+15*self:ReadTrainWire(33)))/150)
    self:SetPackedRatio("CranePosition", self.Pneumatic.DriverValvePosition)
    self:SetPackedRatio("BLPressure", self.Pneumatic.BrakeLinePressure/16.0)
    self:SetPackedRatio("TLPressure", self.Pneumatic.TrainLinePressure/16.0)
    self:SetPackedRatio("BCPressure", math.min(3.2,self.Pneumatic.BrakeCylinderPressure)/6.0)

    self:SetPackedBool("SOSD",self.Panel.SOSD>0)
    self:SetPackedBool("SOSDLamp",self.BUKP.SOSD>0)
    self.SOSD = self.Panel.SOSD>0


    self:SetPackedBool("BortPneumo",self.Panel.BrW>0)
    self:SetPackedBool("BortLSD",self.Panel.DoorsW>0)
    self:SetPackedBool("BortBV",self.Panel.GRP>0)
    self:SetLightPower(15, self.Panel.DoorsW > 0.5,1)
    self:SetLightPower(18, self.Panel.DoorsW > 0.5,1)
    self:SetLightPower(16, self.Panel.BrW > 0.5,1)
    self:SetLightPower(19, self.Panel.BrW > 0.5,1)
    self:SetLightPower(17, self.Panel.GRP > 0.5,1)
    self:SetLightPower(20, self.Panel.GRP > 0.5,1)

    self:SetPackedBool("RingEnabled",self.BUKP.Ring)
    self:SetPackedBool("RingEnabledBARS",self.BARS.Ring>0)

    self:SetPackedBool("DoorAlarmL",self.BUKV.CloseRing)
    self:SetPackedBool("DoorAlarmR",self.BUKV.CloseRing)

    self:SetNW2Int("PassSchemesLED",self.PassSchemes.PassSchemeCurr)
    self:SetNW2Int("PassSchemesLEDN",self.PassSchemes.PassSchemeNext)
    self:SetPackedBool("PassSchemesLEDO",self.PassSchemes.PassSchemePath)
    self:SetPackedBool("SarmatLeft",self.Panel.PassSchemePowerL)
    self:SetPackedBool("SarmatRight",self.Panel.PassSchemePowerR)

    self:SetPackedBool("PassengerDoor",self.PassengerDoor)
    self:SetPackedBool("CabinDoorLeft",self.CabinDoorLeft)
    self:SetPackedBool("CabinDoorRight",self.CabinDoorRight)
    self:SetPackedBool("RearDoor",self.RearDoor)

    self:SetNW2Bool("VityazLamp", self.MFDU.State~=0)

    self:SetPackedBool("AnnPlay",self.Panel.AnnouncerPlaying > 0)
    self:SetPackedBool("AnnPlayUPO",self.Announcer.AnnTable=="AnnouncementsUPO")
    --print(self.Panel.AnnouncerPlaying,self.UPO.LineOut)

    self:SetPackedRatio("Speed", self.Speed)
    self.AsyncInverter:TriggerInput("Speed",self.Speed)
    if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and not self.IgnoreEngine then
        local A = self.AsyncInverter.Torque
        self.FrontBogey.MotorForce = 39000+5000*(A < 0 and 1 or 0)--35300
        self.FrontBogey.Reversed = self.Electric.Reverser < 0
        self.FrontBogey.DisableSound = 1
        self.FrontBogey.DisableContacts = self.Electric.DisablePant > 0
        self.RearBogey.MotorForce  = 39000+5000*(A < 0 and 1 or 0)--35300
        self.RearBogey.Reversed = self.Electric.Reverser > 0
        self.RearBogey.DisableSound = 1
        self.RearBogey.DisableContacts = self.Electric.DisablePant > 0

        -- These corrections are required to beat source engine friction at very low values of motor power
        local P = math.max(0,0.04449 + 1.06879*math.abs(A) - 0.465729*A^2)
        if math.abs(A) > 0.4 then P = math.abs(A) end
        if math.abs(A) < 0.05 then P = 0 end
        if self.Speed < 10 then P = P*(1.0 + 0.5*(10.0-self.Speed)/10.0) end
        self.RearBogey.MotorPower  = P*0.5*((A > 0) and 1 or -1)
        self.FrontBogey.MotorPower = P*0.5*((A > 0) and 1 or -1)

        -- Apply brakes
        self.FrontBogey.PneumaticBrakeForce = 50000.0--3000 --40000
        self.FrontBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.FrontBogey.ParkingBrakePressure = math.max(0,(3-self.Pneumatic.ParkingBrakePressure)/3)
        self.FrontBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
        self.RearBogey.PneumaticBrakeForce = 50000.0--3000 --40000
        self.RearBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.RearBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
    end
    if true then return retVal end
    self:SetPackedRatio("async1", math.min(self.Speed/7,self.AsyncInverter.State*math.Clamp(1+(self.Speed-15)/120,1,2)))
    self:SetPackedRatio("async1state", self.AsyncInverter.State)
    self:SetPackedRatio("asyncfreq", self.AsyncInverter.InverterFrequency)

    self:SetPackedRatio("Speed", self.Speed)


    --self:SetPackedRatio("TrainLine",7.3/16)
    --self:SetPackedRatio("BrakeLine",5.2/16)
    --self:SetPackedRatio("BrakeCylinder",self.AsyncInverter.PN1*1.1/6)
    self:SetPackedBool("BattEnabled",self.BUKV.Battery)
    self:SetPackedBool("BattOffLight",self.BUKV.BatteryTimer2)
    self:SetPackedBool("PSNEnabled",self.BUKV.PSN)

    self:SetPackedBool("LampLRD",power and (self.ALSCoil.F6*self.ALSCoil.RealF5) > 0)
    self:SetPackedBool("Lamp04",self.ALSCoil.NoFreq > 0 or power and (self.ALSCoil.Enabled == 0 and self.VRD.Value > 0))
    self:SetPackedBool("Lamp0",self.ALSCoil.F5 > 0)
    self:SetPackedBool("Lamp40",self.ALSCoil.F4 > 0)
    self:SetPackedBool("Lamp60",self.ALSCoil.F3 > 0)
    self:SetPackedBool("Lamp70",self.ALSCoil.F2 > 0)
    self:SetPackedBool("Lamp80",self.ALSCoil.F1 > 0)

    --Радио
    self:SetPackedBool("RadioRVS",(power or self.EmergencyRadioPower.Value > 0.5) and self.SF14.Value > 0.5)
    self:SetPackedBool("RadioMotorola",(power or self.EmergencyRadioPower.Value > 0.5) and self.SF15.Value > 0.5)


    self:SetNW2Int("SarmatLED",self.BUKV.SarmatLED)
    self:SetNW2Int("SarmatLEDN",self.BUKV.SarmadLEDNext)

    self:SetNW2Int("TickersLine",self.BUKV.SarmatLine)
    self:SetNW2Int("TickersStation",self.BUKV.SarmatStation)
    self:SetNW2Bool("TickersArrived",self.BUKV.SarmatArrived)
    self:SetNW2Bool("TickersLast",self.BUKV.SarmatLast)

    self:SetPackedBool("SarmatLEDO",self.BUKV.SarmatPath)
    self:SetPackedBool("SarmatLeft",power and self.SF34.Value > 0)
    self:SetPackedBool("SarmatRight",power and self.SF35.Value > 0)

    self:SetPackedBool("DoorLeftLamp",power and not self.BUKP.BlockLeft)
    self:SetPackedBool("DoorRightLamp",power and not self.BUKP.BlockRight)

    self:SetPackedBool("CompressorWork",self.Pneumatic.Compressor)

    self:SetPackedBool("RingEnabled",self.BUKP.Ring)
    self:SetPackedBool("RingEnabledARS",self.BUKP.RingARS)

    self:SetPackedBool("BortPneumo",power and self.Pneumatic.BrakeCylinderPressure > 0.2)
    self:SetPackedBool("BortLSD",power and (self.LeftDoorsOpen or self.RightDoorsOpen))
    self:SetPackedBool("BortBV",power and self.BUKV.BV == 0)


    self.SOSD = self.BUKV.SOSDEnabled and (self.LeftDoorsOpen or self.RightDoorsOpen)
    self:SetPackedBool("SOSDLamp",self.BUKV.SOSDEnabled)
    --self:SetPackedBool("DoorAlarm",self.BUKV.DoorAlarm)
    if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and not self.IgnoreEngine then
        local A = self.AsyncInverter.Torque
        self.FrontBogey.MotorForce = 39000+10500*(A < 0 and 1 or 0)--35300
        self.FrontBogey.Reversed = self:ReadTrainWire(13) > 0
        self.FrontBogey.DisableSound = 3
        self.RearBogey.MotorForce  = 39000+10500*(A < 0 and 1 or 0)--35300
        self.RearBogey.Reversed = self:ReadTrainWire(13) == 0
        self.RearBogey.DisableSound = 3

        -- These corrections are required to beat source engine friction at very low values of motor power
        local P = math.max(0,0.04449 + 1.06879*math.abs(A) - 0.465729*A^2)
        if math.abs(A) > 0.4 then P = math.abs(A) end
        if math.abs(A) < 0.05 then P = 0 end
        if self.Speed < 10 then P = P*(1.0 + 0.5*(10.0-self.Speed)/10.0) end
        self.RearBogey.MotorPower  = P*0.5*((A > 0) and 1 or -1)
        self.FrontBogey.MotorPower = P*0.5*((A > 0) and 1 or -1)

        -- Apply brakes
        self.FrontBogey.PneumaticBrakeForce = 50000.0+5000+4500 --40000
        self.FrontBogey.BrakeCylinderPressure = math.max(self.Pneumatic.BrakeCylinderPressure,(2.95-self.Pneumatic.ParkingBrakePressure)/2)
        self.FrontBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
        self.RearBogey.PneumaticBrakeForce = 50000.0+5000+4500 --40000
        self.RearBogey.BrakeCylinderPressure = math.max(self.Pneumatic.BrakeCylinderPressure,(2.95-self.Pneumatic.ParkingBrakePressure))
        self.RearBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
    end
    return retVal
end


function ENT:OnCouple(train,isfront)
    if isfront and self.FrontAutoCouple then
        self.FrontBrakeLineIsolation:TriggerInput("Open",1.0)
        self.FrontTrainLineIsolation:TriggerInput("Open",1.0)
        self.FrontAutoCouple = false
    elseif not isfront and self.RearAutoCouple then
        self.RearBrakeLineIsolation:TriggerInput("Open",1.0)
        self.RearTrainLineIsolation:TriggerInput("Open",1.0)
        self.RearAutoCouple = false
    end
    self.BaseClass.OnCouple(self,train,isfront)
end

function ENT:OnButtonPress(button,ply)
    if string.find(button,"PneumaticBrakeSet") then
        self.Pneumatic:TriggerInput("BrakeSet",tonumber(button:sub(-1,-1)))
        return
    end
    if button == "PassengerDoor" then self.PassengerDoor = not self.PassengerDoor end
    if button == "CabinDoorLeft" then self.CabinDoorLeft = not self.CabinDoorLeft end
    if button == "CabinDoorRight" then self.CabinDoorRight = not self.CabinDoorRight end
    if button == "RearDoor" then self.RearDoor = not self.RearDoor end
    if button == "DoorLeft" then
        self.DoorSelect:TriggerInput("Set",0)
        self.DoorLeft1:TriggerInput("Set",1)
    end
    if button == "DoorRight" then
        self.DoorSelect:TriggerInput("Set",1)
        self.DoorRight:TriggerInput("Set",1)
    end
    if button == "DoorCloseA" then
        if self.DoorClose.Value == 1 then
            self.DoorClose:TriggerInput("Set",2)
        else
            self.DoorClose:TriggerInput("Set",1)
        end
    end
    if button == "DoorCloseM" then
        if self.DoorClose.Value == 1 then
            self.DoorClose:TriggerInput("Set",0)
        else
            self.DoorClose:TriggerInput("Set",1)
        end
    end
end
function ENT:OnButtonRelease(button,ply)
    if string.find(button,"PneumaticBrakeSet") then
        if button == "PneumaticBrakeSet1" and (self.Pneumatic.DriverValvePosition == 1) then
            self.Pneumatic:TriggerInput("BrakeSet",2)
        end
        return
    end
    if button == "DoorLeft" then
        self.DoorLeft1:TriggerInput("Set",0)
    end
    if button == "DoorRight" then
        self.DoorRight:TriggerInput("Set",0)
    end
end

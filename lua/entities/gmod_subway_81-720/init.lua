AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner
ENT.SyncTable = {
    "EnableBVEmer","Ticker","KAH","KAHk","ALS","ALSk","FDepot","PassScheme","EnableBV","DisableBV","Ring","R_Program2","R_Announcer","R_Line","R_Emer","R_Program1",
    "DoorSelectL","DoorSelectR","DoorBlock",
    "EmerBrakeAdd","EmerBrakeRelease","EmerBrake","DoorClose","AttentionMessage","Attention","AttentionBrake","EmergencyBrake",
    "SF1","SF2","SF3","SF4","SF5","SF6","SF7","SF8","SF9","SF10","SF11","SF12",
    "SF13","SF14","SF15","SF16","SF17","SF18","SF19","SF20","SF21","SF22",

    "SFV1","SFV2","SFV3","SFV4","SFV5","SFV6","SFV7","SFV8","SFV9","SFV10","SFV11",
    "SFV12","SFV13","SFV14","SFV15","SFV16","SFV17","SFV18","SFV19","SFV20","SFV21","SFV22",
    "SFV23","SFV24","SFV25","SFV26","SFV27","SFV28","SFV29","SFV30","SFV31","SFV32","SFV33",

    "Stand","EmergencyCompressor","EmergencyControls","Wiper","DoorLeft","AccelRate","HornB","DoorRight",

    "Pant1","Pant2","Vent1","Vent2","Vent","PassLight","CabLight","Headlights1","Headlights2",
    "ParkingBrake","TorecDoors","BBER","BBE","Compressor","CabLightStrength","AppLights1","AppLights2",
    "Battery", "ALSFreq",
    "VityazF1", "VityazF2", "VityazF3", "VityazF4", "Vityaz1",  "Vityaz4",  "Vityaz7",  "Vityaz2",  "Vityaz5",  "Vityaz8",  "Vityaz0",  "Vityaz3",  "Vityaz6",  "Vityaz9",  "VityazF5", "VityazF6", "VityazF7", "VityazF8", "VityazF9",
    "K29", "UAVA",
    "EmerX1","EmerX2","EmerCloseDoors","EmergencyDoors",
    "R_ASNPMenu","R_ASNPUp","R_ASNPDown","R_ASNPOn",
    "VentHeatMode",

    "RearBrakeLineIsolation","RearTrainLineIsolation",
    "FrontBrakeLineIsolation","FrontTrainLineIsolation",
    "PB",   "GV",
}
--------------------------------------------------------------------------------
function ENT:Initialize()
    -- Set model and initialize
    self:SetModel("models/metrostroi_train/81-720/81-720.mdl")
    self.BaseClass.Initialize(self)
    self:SetPos(self:GetPos() + Vector(0,0,150))
    self.Plombs = {
        KAH = {true,"KAHk"},
        KAHk = true,
        ALS = {true,"ALSk"},
        ALSk = true,
        BARSBlock = true,
        UAVA = true,
        Init = true,
    }

    -- Create seat entities
    self.DriverSeat = self:CreateSeat("driver",Vector(439,13,-40))
    self.InstructorsSeat = self:CreateSeat("instructor",Vector(445,50,-50),Angle(0,40,0),"models/vehicles/prisoner_pod_inner.mdl")
    self.InstructorsSeat2 = self:CreateSeat("instructor",Vector(435,35,-50),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")
    self.InstructorsSeat3 = self:CreateSeat("instructor",Vector(435,-45,-50),Angle(0,90+40,0),"models/vehicles/prisoner_pod_inner.mdl")
    self.InstructorsSeat4 = self:CreateSeat("instructor",Vector(425,-25,-50),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")

    -- Hide seats
    self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.DriverSeat:SetColor(Color(0,0,0,0))
    self.InstructorsSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.InstructorsSeat:SetColor(Color(0,0,0,0))
    self.InstructorsSeat2:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.InstructorsSeat2:SetColor(Color(0,0,0,0))
    self.InstructorsSeat3:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.InstructorsSeat3:SetColor(Color(0,0,0,0))
    self.InstructorsSeat4:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.InstructorsSeat4:SetColor(Color(0,0,0,0))

    -- Create bogeys
    if Metrostroi.BogeyOldMap then
        self.FrontBogey = self:CreateBogey(Vector( 350,-1,-91),Angle(0,180,0),true,"720")
        self.RearBogey  = self:CreateBogey(Vector(-320,1,-91),Angle(0,0,0),false,"720")
        self.FrontCouple = self:CreateCouple(Vector( 448,0,-79),Angle(0,0,0),true,"717")
        self.RearCouple  = self:CreateCouple(Vector(-419.5-6.8,0,-79),Angle(0,180,0),false,"717")
    else
        self.FrontBogey = self:CreateBogey(Vector( 350,-1,-91),Angle(0,180,0),true,"720")
        self.RearBogey  = self:CreateBogey(Vector(-320,1,-91),Angle(0,0,0),false,"720")
        self.FrontCouple = self:CreateCouple(Vector( 454    -8,0,-79),Angle(0,0,0),true,"717")
        self.RearCouple  = self:CreateCouple(Vector(-419-6.8+8,0,-79),Angle(0,180,0),false,"717")
    end
    self.FrontBogey:SetNWBool("Async",true)
    self.RearBogey:SetNWBool("Async",true)
    self.FrontBogey:SetNWInt("MotorSoundType",2)
    self.RearBogey:SetNWInt("MotorSoundType",2)
    local rand = math.random()*0.05
    self.FrontBogey:SetNWFloat("SqualPitch",1.45+rand)
    self.RearBogey:SetNWFloat("SqualPitch",1.45+rand)
    self.FrontCouple.EKKDisconnected = true

    -- Initialize key mapping
    self.KeyMap = {
        [KEY_W] = "PanelKVUp",
        [KEY_S] = "PanelKVDown",
        [KEY_1] = "PanelKV1",
        [KEY_2] = "PanelKV2",
        [KEY_3] = "PanelKV3",
        [KEY_4] = "PanelKV4",
        [KEY_5] = "PanelKV5",
        [KEY_6] = "PanelKV6",
        [KEY_7] = "PanelKV7",
        [KEY_8] = "PanelKV8",
        [KEY_9] = "KRO-",
        [KEY_0] = "KRO+",

        [KEY_A] = "DoorLeft",
        [KEY_D] = "DoorRight",
        [KEY_V] = "DoorClose",
        [KEY_G] = "EnableBVSet",
        [KEY_SPACE] = {
            def="PBSet",
            [KEY_LSHIFT] = "AttentionBrakeSet",
        },

        [KEY_PAD_ENTER] = "KVWrenchKV",
        [KEY_EQUAL] = "R_Program1Set",
        [KEY_RBRACKET] = "R_Program1Set",
        [KEY_MINUS] = "R_Program2Set",
        [KEY_LSHIFT] = {
            def="PanelControllerUnlock",
            [KEY_SPACE] = "AttentionBrakeSet",
            [KEY_V] = "EmergencyDoorsToggle",
            [KEY_7] = "WrenchNone",
            [KEY_8] = "WrenchKRR",
            [KEY_9] = "WrenchKRO9",
            [KEY_0] = "WrenchKRO",
            [KEY_G] = "EnableBVEmerSet",
            [KEY_2] = "RingSet",
            [KEY_L] = "HornEngage",

            [KEY_PAD_ENTER] = "KVWrenchNone",
        },
        [KEY_LALT] = {
            [KEY_V] = "DoorCloseToggle",
            [KEY_PAD_1] = "Vityaz1Set",
            [KEY_PAD_2] = "Vityaz2Set",
            [KEY_PAD_3] = "Vityaz3Set",
            [KEY_PAD_4] = "Vityaz4Set",
            [KEY_PAD_5] = "Vityaz5Set",
            [KEY_PAD_6] = "Vityaz6Set",
            [KEY_PAD_7] = "Vityaz7Set",
            [KEY_PAD_8] = "Vityaz8Set",
            [KEY_PAD_9] = "Vityaz9Set",
            [KEY_PAD_0] = "Vityaz0Set",
            [KEY_PAD_DECIMAL] = "VityazF5Set",
            [KEY_PAD_ENTER] = "VityazF8Set",
            [KEY_UP] = "VityazF6Set",
            [KEY_LEFT] = "VityazF5Set",
            [KEY_DOWN] = "VityazF7Set",
            [KEY_RIGHT] = "VityazF9Set",
            [KEY_PAD_MINUS] = "VityazF2Set",
            [KEY_PAD_PLUS] = "VityazF3Set",
            [KEY_PAD_MULTIPLY] = "VityazF4Set",
            [KEY_PAD_DIVIDE] = "VityazF1Set",
            [KEY_SPACE] = "AttentionMessageSet",
        },
        [KEY_PAD_PLUS] = "EmerBrakeAddSet",
        [KEY_PAD_MINUS] = "EmerBrakeReleaseSet",
        [KEY_F] = "PneumaticBrakeUp",
        [KEY_R] = "PneumaticBrakeDown",
        [KEY_PAD_1] = "PneumaticBrakeSet1",
        [KEY_PAD_2] = "PneumaticBrakeSet2",
        [KEY_PAD_3] = "PneumaticBrakeSet3",
        [KEY_PAD_4] = "PneumaticBrakeSet4",
        [KEY_PAD_5] = "PneumaticBrakeSet5",
        [KEY_PAD_6] = "PneumaticBrakeSet6",

        [KEY_PAD_DIVIDE] = "EmerX1Set",
        [KEY_PAD_MULTIPLY] = "EmerX2Set",
        [KEY_PAD_9] = "EmerBrakeToggle",

        [KEY_BACKSPACE] = "EmergencyBrakeToggle",
        [KEY_L] = "HornBSet",
    }
    self.KeyMap[KEY_RALT] = self.KeyMap[KEY_LALT]
    self.KeyMap[KEY_RSHIFT] = self.KeyMap[KEY_LSHIFT]
    self.KeyMap[KEY_RCONTROL] = self.KeyMap[KEY_LCONTROL]
    -- Cross connections in train wires
    self.TrainWireCrossConnections = {
        [4] = 3, -- Orientation F<->B
        [13] = 12, -- Reverser F<->B
        [38] = 37, -- Doors L<->R
    }

    self.Lights = {
        [1]  = { "light",Vector(500,-35,-29), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02.vmt" },
        [2]  = { "light",Vector(500, 35,-29), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02.vmt" },

        [3] = { "light",Vector(500,-50, -29), Angle(0,0,0), Color(255,50,50),     brightness = 0.1, scale = 1.5, texture = "sprites/light_glow02.vmt"  },
        [4] = { "light",Vector(500, 50, -29), Angle(0,0,0), Color(255,50,50),     brightness = 0.1, scale = 1.5, texture = "sprites/light_glow02.vmt"  },
        [5] = { "light",Vector(500,-50, -75), Angle(0,0,0), Color(255,50,50),     brightness = 0.1, scale = 1.5, texture = "sprites/light_glow02.vmt"  },
        [6] = { "light",Vector(500, 50, -75), Angle(0,0,0), Color(255,50,50),     brightness = 0.1, scale = 1.5, texture = "sprites/light_glow02.vmt"  },

        [10] = { "dynamiclight",    Vector( 440, 0, 13), Angle(0,0,0), Color(206,135,80), brightness = 0.7, distance = 550 },
        -- Interior
        --[11] = { "dynamiclight",  Vector( 200, 0, 10), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400 , fov=180,farz = 128
        [15] = { "dynamiclight",    Vector(-350, 0, 10), Angle(0,0,0), Color(238,238,197), brightness = 0.75, distance = 500, fov=180,farz = 128 },
        [16] = { "dynamiclight",    Vector(-60, 0, 10), Angle(0,0,0), Color(238,238,197), brightness = 0.75, distance = 500, fov=180,farz = 128 },
        [17] = { "dynamiclight",    Vector( 230, 0, 10), Angle(0,0,0), Color(238,238,197), brightness = 0.75, distance = 500, fov=180,farz = 128 },
        --[13] = { "dynamiclight",  Vector(-200, 0, 10), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400 , fov=180,farz = 128 },
        --[11] = { "dynamiclight",  Vector( 100, 0, 10), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400 , fov=180,farz = 128 },
        --[12] = { "dynamiclight",  Vector( 100, 0, 10), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400, fov=180,farz = 128 },
    }
    self.InteractionZones = {
        {   Pos = Vector(466, 64, 30),
            Radius = 48,
            ID = "CabinDoorLeft" },
        {   Pos = Vector(466, 64, -30),
            Radius = 48,
            ID = "CabinDoorLeft" },
        {   Pos = Vector(466, -60, 30),
            Radius = 48,
            ID = "CabinDoorRight" },
        {   Pos = Vector(466, -60, -30),
            Radius = 48,
            ID = "CabinDoorRight" },
        {   Pos = Vector(378, 39, 50),
            Radius = 32,
            ID = "OtsekDoor" },
        {   Pos = Vector(378, 39, 11),
            Radius = 32,
            ID = "OtsekDoor" },
        {
            ID = "FrontBrakeLineIsolationToggle",
            Pos = Vector(495, -22, -60), Radius = 16,
        },
        {
            ID = "FrontTrainLineIsolationToggle",
            Pos = Vector(495, 22, -60), Radius = 16,
        },
        {
            ID = "RearBrakeLineIsolationToggle",
            Pos = Vector(-470, 30, -60), Radius = 16,
        },
        {
            ID = "RearTrainLineIsolationToggle",
            Pos = Vector(-470, -30, -60), Radius = 16,
        },
        {
            ID = "RearDoor",
            Pos = Vector(-464.8,-30,0), Radius = 20,
        },
        {
            ID = "GVToggle",
            Pos = Vector(128,60,-75), Radius = 20,
        },
        {
            ID = "AirDistributorDisconnectToggle",
            Pos = Vector(-177, -66, -50), Radius = 20,
        },
    }
    self.PassengerDoor = false
    self.CabinDoorLeft = false
    self.CabinDoorRight = false
    self.RearDoor = false
    self.OtsekDoor = false
    self.WrenchMode = 0
end

function ENT:NonSupportTrigger()
    self.ALS:TriggerInput("Set",1)
    self.ALSk:TriggerInput("Set",1)
    self.BARSBlock:TriggerInput("Set",3)
    self.Plombs.ALS = nil
    self.Plombs.ALSk = nil
    self.Plombs.BARSBlock = nil
end

--------------------------------------------------------------------------------
function ENT:Think()
    local retVal = self.BaseClass.Think(self)
    local power = self.Electric.Battery80V > 62
    --print(self,self.BPTI.T,self.BPTI.State)
    --[[ if self.BUV.Brake > 0 then
        self:SetPackedRatio("RNState", power and (Train.K2.Value>0 or Train.K3.Value>0) and self.Electric.RN > 0 and (1-self.Electric.RNState)+math.Clamp(1-(math.abs(self.Electric.Itotal)-50)/50,0,1) or 1)
    else
        self:SetPackedRatio("RNState", power and (Train.K2.Value>0 or Train.K3.Value>0) and self.Electric.RN > 0 and self.Electric.RNState+math.Clamp(1-(math.abs(self.Electric.Itotal)-50)/50,0,1) or 1)
    end--]]
    if self.BPTI.State < 0 then
        self:SetPackedRatio("RNState", ((self.BPTI.RNState)-0.25)*math.Clamp((math.abs(self.Electric.Itotal/2)-30-self.Speed*2)/20,0,1))
        --self:SetNW2Int("RNFreq", 13)
    else--if self.BPTI.State > 0 then
        self:SetPackedRatio("RNState", (0.75-self.BPTI.RNState)*math.Clamp((math.abs(self.Electric.Itotal/2)-30-self.Speed*2)/20,0,1))
        --self:SetNW2Int("RNFreq", ((self.BPTI.FreqState or 0)-1/3)/(2/3)*12)
    --[[ else
        self:SetPackedRatio("RNState", 0)--]]
    end

    self:SetPackedRatio("Speed", self.Speed)
    self:SetNW2Int("Wrench",self.WrenchMode)
    self:SetPackedRatio("Controller",self.Panel.Controller)
    self:SetPackedRatio("KRO",(self.RV.KROPosition+1)/2)
    self:SetPackedRatio("KRR",(self.RV.KRRPosition+1)/2)
    self:SetPackedRatio("VentCondMode",self.VentCondMode.Value/3)
    self:SetPackedRatio("VentStrengthMode",self.VentStrengthMode.Value/3)
    --self:SetPackedRatio("VentHeatMode",self.VentHeatMode.Value/2)
    self:SetPackedRatio("BARSBlock",self.BARSBlock.Value/3)

    self:SetPackedBool("BBEWork",power and self.BUV.BBE > 0)
    self:SetPackedBool("WorkBeep",power)

    --print(0.4+math.max(0,math.min(1,1-(self.Speed-30)/30))*0.5)
    --print((80-self.Engines.Speed))
    self:SetPackedBool("HeadlightsEnabled1",self.Panel.Headlights1>0)
    self:SetPackedBool("HeadlightsEnabled2",self.Panel.Headlights2>0)
    local headlights = self.Panel.Headlights1*0.5+self.Panel.Headlights2*0.5
    local redlights = self.Panel.RedLights>0
    self:SetPackedBool("BacklightsEnabled",redlights)
    self:SetLightPower(1,headlights>0,headlights)
    self:SetLightPower(2,headlights>0,headlights)
    self:SetLightPower(3,redlights)
    self:SetLightPower(4,redlights)
    self:SetLightPower(5,redlights)
    self:SetLightPower(6,redlights)
    local cablight = self.Panel.CabLights
    self:SetLightPower(10,cablight > 0 ,cablight)
    self:SetPackedBool("CabinEnabledEmer", cablight > 0)
    self:SetPackedBool("CabinEnabledFull", cablight > 0.5)
    local passlight = power and (self.BUV.MainLights and 1 or self.SFV20.Value > 0.5 and 0.4) or 0
    self:SetLightPower(15,passlight > 0, passlight)
    self:SetLightPower(16,passlight > 0, passlight)
    self:SetLightPower(17,passlight > 0, passlight)
    self:SetPackedRatio("SalonLighting",passlight)
    --self:SetPackedRatio("TrainLine",7.3/16)
    --self:SetPackedRatio("BrakeLine",5.2/16)
    --self:SetPackedRatio("BrakeCylinder",self.AsyncInverter.PN1*1.1/6)
    if self:GetWagonNumber() == 37 then
        --self.BV:TriggerInput("Set",0)
    end
    self:SetPackedRatio("BIAccel",power and self.BARS.BIAccel or 0)
    self:SetNW2Int("BISpeed",power and self.Speed or -1)--CurTime()%5*20
    self:SetNW2Bool("BISpeedLimitBlink",power and self.BARS.BINoFreq > 0)
    self:SetNW2Int("BISpeedLimit",power and self.BARS.SpeedLimit or 100)
    self:SetNW2Int("BISpeedLimitNext",power and self.BARS.NextLimit or 100)
    self:SetNW2Bool("BIForward",power and self.BARS.BIDirection >= 0)--power and (self.RV["KRO3-4"] > 0 or self.RV["KRR5-6"] > 0) and self.BARS.Speed > -0.2)
    self:SetNW2Bool("BIBack",power and self.BARS.BIDirection <= 0)--power and (self.RV["KRO3-4"] > 0 or self.RV["KRR5-6"] > 0) and self.BARS.Speed < 0.2)
    self:SetNW2Bool("DoorsClosed",power and self.BUKP.DoorClosed)
    self:SetNW2Bool("HVoltage",power and self.BUKP.HVBad)
    self:SetNW2Bool("DoorLeftLamp",self.Panel.DoorLeft>0)
    self:SetNW2Bool("DoorRightLamp",self.Panel.DoorRight>0)
    self:SetNW2Bool("EmerBrakeWork",self.Panel.EmerBrakeWork>0)
    self:SetNW2Bool("TickerLamp",self.Panel.Ticker>0)
    self:SetNW2Bool("KAHLamp",self.Panel.KAH>0)
    self:SetNW2Bool("ALSLamp",self.Panel.ALS>0)
    self:SetNW2Bool("PassSchemeLamp",self.Panel.PassScheme>0)
    self:SetNW2Bool("R_AnnouncerLamp",self.Panel.R_Announcer>0)
    self:SetNW2Bool("R_LineLamp",self.Panel.R_Line>0)
    self:SetNW2Bool("AccelRateLamp",power and self.BUKP.Slope)
    self:SetNW2Bool("DoorCloseLamp",self.Panel.DoorClose>0)
    self:SetNW2Bool("DoorBlockLamp",self.Panel.DoorBlock>0)
    self:SetPackedBool("AppLights", self.Panel.EqLights>0)

    self:SetPackedRatio("LV",self.Electric.Battery80V/150)
    self:SetPackedRatio("HV",self.Electric.Main750V/1000)
    self:SetPackedRatio("I13",(self.Electric.I13+500)/1000)
    self:SetPackedRatio("I24",(self.Electric.I24+500)/1000)
    self:SetPackedBool("PassengerDoor",self.PassengerDoor)
    self:SetPackedBool("CabinDoorLeft",self.CabinDoorLeft)
    self:SetPackedBool("CabinDoorRight",self.CabinDoorRight)
    self:SetPackedBool("RearDoor",self.RearDoor)
    self:SetPackedBool("OtsekDoor",self.OtsekDoor)
    self:SetPackedBool("CompressorWork",self.Pneumatic.Compressor)
    self:SetPackedBool("Vent1Work",self.Electric.Vent1>0)
    self:SetPackedBool("Vent2Work",self.Electric.Vent2>0)
    self:SetPackedBool("RingEnabled",self.BUKP.Ring)

    self:SetNW2Int("PassSchemesLED",self.PassSchemes.PassSchemeCurr)
    self:SetNW2Int("PassSchemesLEDN",self.PassSchemes.PassSchemeNext)
    self:SetPackedBool("PassSchemesLEDO",self.PassSchemes.PassSchemePath)

    self:SetPackedBool("AnnPlay",self.Panel.AnnouncerPlaying > 0)

    self:SetPackedRatio("Cran", self.Pneumatic.DriverValvePosition)
    self:SetPackedRatio("BL", self.Pneumatic.BrakeLinePressure/16.0)
    self:SetPackedRatio("TL", self.Pneumatic.TrainLinePressure/16.0)
    self:SetPackedRatio("BC", math.min(3.2,self.Pneumatic.BrakeCylinderPressure)/6.0)
    self.Engines:TriggerInput("Speed",self.Speed)

    if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and not self.IgnoreEngine then
        local A = 2*self.Engines.BogeyMoment
        self.FrontBogey.MotorForce = (24000+3000*(A < 0 and 1 or 0))--*add--35300+10000*(A < 0 and 1 or 0)
        self.FrontBogey.Reversed = self.KMR2.Value > 0
        self.FrontBogey.DisableSound = 0
        self.RearBogey.MotorForce  = (24000+3000*(A < 0 and 1 or 0))--*add--+5000--35300
        self.RearBogey.Reversed = self.KMR1.Value > 0
        self.RearBogey.DisableSound = 0

        -- These corrections are required to beat source engine friction at very low values of motor power
        local P = math.max(0,0.04449 + 1.06879*math.abs(A) - 0.465729*A^2)
        if math.abs(A) > 0.4 then P = math.abs(A) end
        if math.abs(A) < 0.05 then P = 0 end
        if self.Speed < 10 then P = P*(1.0 + 0.5*(10.0-self.Speed)/10.0) end
        self.RearBogey.MotorPower  = P*0.5*((A > 0) and 1 or -1)
        self.FrontBogey.MotorPower = P*0.5*((A > 0) and 1 or -1)

        -- Apply brakes
        self.FrontBogey.PneumaticBrakeForce = (50000.0--[[ +5000+10000--]] ) --40000
        self.FrontBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.FrontBogey.ParkingBrakePressure = math.max(0,(3-self.Pneumatic.ParkingBrakePressure)/3)/2
        self.FrontBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
        self.FrontBogey.DisableContacts = self.BUV.Pant
        self.RearBogey.PneumaticBrakeForce = (50000.0--[[ +5000+10000--]] ) --40000
        self.RearBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.RearBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
        self.RearBogey.ParkingBrakePressure = math.max(0,(3-self.Pneumatic.ParkingBrakePressure)/3)/2
        self.RearBogey.DisableContacts = self.BUV.Pant
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
    if button == "OtsekDoor" then self.OtsekDoor = not self.OtsekDoor end
    if button == "CabinDoorRight" then self.CabinDoorRight = not self.CabinDoorRight end
    if button == "RearDoor" and (self.RearDoor or not self.BUV.BlockTorec) then self.RearDoor = not self.RearDoor end
    if button == "DoorLeft" then
        self.DoorSelectL:TriggerInput("Set",1)
        self.DoorSelectR:TriggerInput("Set",0)
        if self.EmergencyDoors.Value == 1 or self.DoorClose.Value == 0 then
            self.DoorLeft:TriggerInput("Set",1)
        end
    end
    if button == "DoorRight" then
        self.DoorSelectL:TriggerInput("Set",0)
        self.DoorSelectR:TriggerInput("Set",1)
        if self.EmergencyDoors.Value == 1 or self.DoorClose.Value == 0 then
          self.DoorRight:TriggerInput("Set",1)
        end
    end
    if button == "DoorClose" then
        if self.EmergencyDoors.Value == 1 then
            self.EmerCloseDoors:TriggerInput("Set",1)
        else
                 self.DoorClose:TriggerInput("Set",1-self.DoorClose.Value)
            self.EmerCloseDoors:TriggerInput("Set",0)
        end
    end
    if button == "KRO+" then
        if self.WrenchMode == 1 then
            self.RV:TriggerInput("KROSet",self.RV.KROPosition+1)
        elseif self.WrenchMode == 2 then
            self.RV:TriggerInput("KRRSet",self.RV.KRRPosition+1)
        end
    end
    if button == "KRO-" then
        if self.WrenchMode == 1 then
            self.RV:TriggerInput("KROSet",self.RV.KROPosition-1)
        elseif self.WrenchMode == 2 then
            self.RV:TriggerInput("KRRSet",self.RV.KRRPosition-1)
        end
    end
    if button == "WrenchKRO" or button == "WrenchKRO9" then
        if self.WrenchMode == 0 then
            self:PlayOnce("kro_in","cabin",1)
            self.WrenchMode = 1
        else
            self:OnButtonPress(button == "WrenchKRO9" and "KRO-" or "KRO+")
        end
    end
    if button == "WrenchKRR" then
        if self.WrenchMode == 0 then
            self:PlayOnce("krr_in","cabin",1)
            self.WrenchMode = 2
        end
    end
    if button == "WrenchNone" then
        if self.WrenchMode ~= 0 then
            if self.WrenchMode == 2 and self.RV.KRRPosition == 0 then
                self:PlayOnce("krr_out","cabin",1,1)
                self.WrenchMode = 0
            elseif self.WrenchMode == 1 and self.RV.KROPosition == 0 then
                self:PlayOnce("kro_out","cabin",1,1)
                self.WrenchMode = 0
            end
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
        self.DoorLeft:TriggerInput("Set",0)
    end
    if button == "DoorRight" then
        self.DoorRight:TriggerInput("Set",0)
    end
    if button == "DoorClose" then
         self.EmerCloseDoors:TriggerInput("Set",0)
    end
end

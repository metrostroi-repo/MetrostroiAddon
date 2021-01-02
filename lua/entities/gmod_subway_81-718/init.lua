AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner

--"DURASelectMain","DURASelectAlternate","DURAToggleChannel","DURAPowerToggle",
ENT.SyncTable = {
    "SA5","SB3","SA7","SB1","SB2","SA8","SB4","SB5","SA9","SA13","SA14","SA15","SA2","SB6","SB7","SB8","SB10","SB9","SB11","SA16","SB12","SB13","SB14","SB15","SB16",
    "SB6K","SB7K",
    "SA1/1","SA2/1","SA4/1","SA5/1",
    "SBR14","SBR15","SBR16",
    "SA6","SA24","SB20","SB21",
    "SF56","SF51","SF52","SF53","SF60","SF61","SF77","SF78","SF40","SF41","SF8","SF11","SF10","SF7","SF50","SF76","SF73","SF3","SF71","SF63","SF54","SF65","SF55","SF9","SF6","SF5","SF2",
    "SF4","SF27","SF46","SF12","SF13","SF45","SF16","SF44","SF43","SF14","SF15","SF25","SF72","SF29","SF26","SF42","SF18","SF20","SF17","SF19","SF21","SF22","SF34","SF35","SF23","SF24",
    "RC","VB","VTPR",
    "DriverValveDisconnect","EPK","ParkingBrake","UAVA","PB","EmergencyBrakeValve","GV",
    "SAP8","SAP13","SAP36","SAP12","SAP11","SAP23","SAP9","SAP10","SAP3","SAP39","SBP22","SBP6","SBP4","SAP14","SAP26","SAP24","SAB1",
}

function ENT:Initialize()
    self.Plombs = {
        SA8 = true,
        SA9 = true,
        SA2 = true,
        SAP23 = true,
        SAP24 = true,
        SB6 = true,
        RC = true,
        SAP26 = true,
        UAVA = true,
        Init = true,
    }

    self:SetModel("models/metrostroi_train/81-718/81-718.mdl")
    self.BaseClass.Initialize(self)
    self:SetPos(self:GetPos() + Vector(0,0,140))

    -- Create seat entities
    self.DriverSeat = self:CreateSeat("driver",Vector(417+5,-4,-28))
    self.InstructorsSeat = self:CreateSeat("instructor",Vector(425,50,-28),Angle(0,270,0))
    self.ExtraSeat1 = self:CreateSeat("instructor",Vector(410,35,-43),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")
    self.ExtraSeat2 = self:CreateSeat("instructor",Vector(433,-45,-43),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")
    self.ExtraSeat3 = self:CreateSeat("instructor",Vector(402,50,-43),Angle(0,50,0),"models/vehicles/prisoner_pod_inner.mdl")

    -- Hide seats
    self.DriverSeat:SetColor(Color(0,0,0,0))
    self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.InstructorsSeat:SetColor(Color(0,0,0,0))
    self.InstructorsSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.ExtraSeat1:SetColor(Color(0,0,0,0))
    self.ExtraSeat1:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.ExtraSeat2:SetColor(Color(0,0,0,0))
    self.ExtraSeat2:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.ExtraSeat3:SetColor(Color(0,0,0,0))
    self.ExtraSeat3:SetRenderMode(RENDERMODE_TRANSALPHA)

    -- Create bogeys
    if Metrostroi.BogeyOldMap then
        self.FrontBogey = self:CreateBogey(Vector( 317-5,0,-84),Angle(0,180,0),true,"717")
        self.RearBogey  = self:CreateBogey(Vector(-317+0,0,-84),Angle(0,0,0),false,"717")
        self.FrontCouple = self:CreateCouple(Vector( 419.5,0,-62),Angle(0,0,0),true,"717")
        self.RearCouple  = self:CreateCouple(Vector(-419.5-6.545,0,-62),Angle(0,180,0),false,"717")
    else
        self.FrontBogey = self:CreateBogey(Vector( 317-11,0,-80),Angle(0,180,0),true,"717")
        self.RearBogey  = self:CreateBogey(Vector(-317+0,0,-80),Angle(0,0,0),false,"717")
        self.RearCouple  = self:CreateCouple(Vector(-423+2,0,-66),Angle(0,180,0),false,"717")
        self.FrontCouple = self:CreateCouple(Vector( 410-3,0,-66),Angle(0,0,0),true,"717")
    end
    local pneumoPow = 1.0+(math.random()^0.4)*0.3
    self.FrontBogey.PneumaticPow = pneumoPow
    self.RearBogey.PneumaticPow = pneumoPow
    -- Initialize key mapping
    self.KeyMap = {
        [KEY_W] = "BKCUKVUp",
        [KEY_S] = "BKCUKVDown",
        [KEY_1] = "BKCUKV1",
        [KEY_2] = "BKCUKV2",
        [KEY_3] = "BKCUKV3",
        [KEY_4] = "BKCUKV4",
        [KEY_5] = "BKCUKV5",
        [KEY_6] = "BKCUKV6",
        [KEY_7] = "BKCUKV7",
        [KEY_8] = "BKCUKV8",
        [KEY_9] = "KR-",
        [KEY_0] = "KR+",

        [KEY_A] = {"SB1",helper="SA24Set"},
        [KEY_D] = "SB2",
        [KEY_V] = {"SA5Toggle",helper="SA6Toggle"},
        [KEY_G] = "SB12Set",
        [KEY_SPACE] = "PBSet",

        [KEY_EQUAL] = {"SB10Set",helper="SB20Set"},
        [KEY_MINUS] = {"SB11Set",helper="SB21Set"},

        [KEY_PAD_ENTER] = "WrenchKR",
        [KEY_PAD_0] = "DriverValveDisconnectToggle",
        [KEY_PAD_DECIMAL] = "EPKToggle",
        [KEY_LSHIFT] = {
            def="BKCUControllerUnlock",
            [KEY_SPACE] = "KVTSet",

            [KEY_7] = "WrenchNone",
            [KEY_8] = "WrenchKRU",
            [KEY_9] = "WrenchKR",
            [KEY_0] = "WrenchKR",
            --[KEY_G] = "EnableBVEmerSet",
            [KEY_1] = "SB7",
            [KEY_2] = "SB5Set",
            [KEY_L] = "DriverValveDisconnectToggle",

            [KEY_PAD_ENTER] = "KVWrenchNone",
        },
        [KEY_LALT] = {
            [KEY_UP] = "RRIUp",
            [KEY_DOWN] = "RRIDown",
            [KEY_LEFT] = "RRILeft",
            [KEY_RIGHT] = "RRIRight",
        },

        [KEY_F] = "PneumaticBrakeUp",
        [KEY_R] = "PneumaticBrakeDown",
        [KEY_PAD_1] = "PneumaticBrakeSet1",
        [KEY_PAD_2] = "PneumaticBrakeSet2",
        [KEY_PAD_3] = "PneumaticBrakeSet3",
        [KEY_PAD_4] = "PneumaticBrakeSet4",
        [KEY_PAD_5] = "PneumaticBrakeSet5",
        [KEY_PAD_6] = "PneumaticBrakeSet6",
        [KEY_PAD_7] = "PneumaticBrakeSet7",

        [KEY_PAD_DIVIDE] = "SBR14Set",
        [KEY_PAD_MULTIPLY] = "SBR15Set",
        [KEY_PAD_MINUS] = "SB6",
        --[KEY_PAD_9] = "EmerBrakeToggle",

        [KEY_BACKSPACE] = {"EmergencyBrake",helper="EmergencyBrakeValveToggle"},
        [KEY_L] = "HornEngage",
    }
    self.KeyMap[KEY_RALT] = self.KeyMap[KEY_LALT]
    self.KeyMap[KEY_RSHIFT] = self.KeyMap[KEY_LSHIFT]
    self.KeyMap[KEY_RCONTROL] = self.KeyMap[KEY_LCONTROL]


    self.InteractionZones = {
        {
            ID = "FrontBrakeLineIsolationToggle",
            Pos = Vector(461.5, -34, -53), Radius = 8,
        },
        {
            ID = "FrontTrainLineIsolationToggle",
            Pos = Vector(461.5, 33, -53), Radius = 8,
        },
        {
            ID = "RearBrakeLineIsolationToggle",
            Pos = Vector(-474.5, 33, -53), Radius = 8,
        },
        {
            ID = "RearTrainLineIsolationToggle",
            Pos = Vector(-474.5, -34, -53), Radius = 8,
        },
        {
            ID = "CabinDoor",
            Pos = Vector(456,66,3), Radius = 12,
        },
        {
            ID = "CabinDoor",
            Pos = Vector(385,66,0), Radius = 16,
        },
        {
            ID = "RearDoor",
            Pos = Vector(-464.8,-35,4), Radius = 20,
        },
        {
            ID = "PassengerDoor",
            Pos = Vector(375.5,13.5,12), Radius = 20,
        },
        {
            ID = "GVToggle",
            Pos = Vector(162.50,62,-59), Radius = 10,
        },
        {
            ID = "AirDistributorDisconnectToggle",
            Pos = Vector(-177, -66, -50), Radius = 20,
        },
    }

    self.Lights = {
        [2] = { "glow",             Vector(466,-24,-32), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 1 },
        [3] = { "glow",             Vector(466,-15,-32), Angle(0,0,0),Color(255,220,180), brightness = 1, scale = 1 },
        [4] = { "glow",             Vector(466,-6, -32), Angle(0,0,0),  Color(255,220,180), brightness = 1, scale = 1 },
        [5] = { "glow",             Vector(466, 7, -32), Angle(0,0,0),  Color(255,220,180), brightness = 1, scale = 1 },
        [6] = { "glow",             Vector(466, 17,-32), Angle(0,0,0),Color(255,220,180), brightness = 1, scale = 1 },
        [7] = { "glow",             Vector(466, 26,-32), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 1 },

        -- Reverse
        [8] = { "light",Vector(465,-46.8, 52.8) , Angle(0,0,0), Color(255,50,50),     brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02.vmt"  },
        [9] = { "light",Vector(465, 47, 52.8)   , Angle(0,0,0), Color(255,50,50),     brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02.vmt"  },

        [11] = { "dynamiclight",    Vector( 200, 0, -0), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400 , fov=180,farz = 128 },
        [12] = { "dynamiclight",    Vector(   0, 0, -0), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400, fov=180,farz = 128 },
        [13] = { "dynamiclight",    Vector(-200, 0, -0), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400 , fov=180,farz = 128 },

        [10] = { "dynamiclight",        Vector( 435, 0, 20), Angle(0,0,0), Color(216,161,92), distance = 550, brightness = 0.3},
        -- Side lights
        [15] = { "light",Vector(-52,67,45.5)+Vector(0,0.9,3.25), Angle(0,0,0), Color(254,254,254), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [16] = { "light",Vector(-52,67,45.5)+Vector(0,0.9,-0.02), Angle(0,0,0), Color(40,240,122), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [17] = { "light",Vector(-52,67,45.5)+Vector(0,0.9,-3.3), Angle(0,0,0), Color(254,210,18), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [18] = { "light",Vector(39,-67,45.5)+Vector(0,-0.9,3.25), Angle(0,0,0), Color(254,254,254), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [19] = { "light",Vector(39,-67,45.5)+Vector(0,-0.9,-0.02), Angle(0,0,0), Color(40,240,122), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [20] = { "light",Vector(39,-67,45.5)+Vector(0,-0.9,-3.3), Angle(0,0,0), Color(254,210,18), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },

        [30]  = { "light",           Vector(465,-16,-29), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02.vmt" },
        [31]  = { "light",           Vector(465, 16,-29), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02.vmt" },
    }

    -- Cross connections in train wires
    self.TrainWireInverts = {
        [11] = true,
        [34] = true,
    }
    self.TrainWireCrossConnections = {
        [5] = 6, -- Reverser F<->B
        [24] = 25, --VTP
        [36] = 37, -- Doors L<->R
        [57] = 58, -- ReverserR F<->B
    }

    -- Setup door positions
    self.LeftDoorPositions = {}
    self.RightDoorPositions = {}
    for i=0,3 do
        table.insert(self.LeftDoorPositions,Vector(353.0 - 35*0.5 - 231*i,65,-1.8))
        table.insert(self.RightDoorPositions,Vector(353.0 - 35*0.5 - 231*i,-65,-1.8))
    end

    -- KV wrench mode
    self.KVWrenchMode = 0

    -- BPSN type
    self:SetNW2Int("BPSNType",self.BPSNType or 2+math.floor(Metrostroi.PeriodRandomNumber("BPSN")*7+0.5))

    self.RearDoor = false
    self.FrontDoor = false
    self.CabinDoor = false
    self.PassengerDoor = false
    self.OtsekDoor1 = false
    self.OtsekDoor2 = false

    self.Lamps = {
        broken = {},
    }
    local rand = math.random() > 0.8 and 1 or math.random(0.95,0.99)
    for i = 1,28 do
        if math.random() > rand then self.Lamps.broken[i] = math.random() > 0.5 end
    end

    self.WrenchMode = 0

    self:TrainSpawnerUpdate()
end

function ENT:NonSupportTrigger()
    self.RC:TriggerInput("Set",0)
    self.SB6:TriggerInput("Set",1)
    self.SB6K:TriggerInput("Set",0)
    self.SB6:TriggerInput("Block",1)
    self.SAP24:TriggerInput("Set",1)
    self.SA8:TriggerInput("Set",1)
    self.SAP26:TriggerInput("Set",1)
    self.EPK:TriggerInput("Set",0)
    self.SA13:TriggerInput("Set",0)
    self.Plombs.SA8 = nil
    self.Plombs.SAP24 = nil
    self.Plombs.SB6 = nil
    self.Plombs.RC = nil
    self.Plombs.SAP26 = nil
end

function ENT:UpdateLampsColors()
    self.LampType = math.Round(math.random()^0.5)+1
    self:SetNW2Int("LampType",self.LampType)

    local lCol,lCount = Vector(),0
    local rnd1,rnd2,col = 0.7+math.random()*0.3,math.random()
    local typ = math.Round(math.random())
    local r,g = 15,15
    for i = 1,28 do
        local chtp = math.random() > rnd1
        if typ == 0 and not chtp or typ == 1 and chtp then
            if math.random() > rnd2 then
                r = -20+math.random()*25
                g = 0
            else
                g = -5+math.random()*15
                r = g
            end
            col = Vector(245+r,228+g,189)
        else
            if math.random() > rnd2 then
                g = math.random()*15
                b = g
            else
                g = 15
                b = -10+math.random()*25
            end
            col = Vector(255,235+g,235+b)
        end
        lCol = lCol + col
        lCount = lCount + 1
        if i%9.3<1 then
            local id = 9+math.ceil(i/9.3)
            self:SetLightPower(id,false)

            local tcol = (lCol/lCount)/255
            self.Lights[id][4] = Vector(tcol.r,tcol.g^3,tcol.b^3)*255
            lCol = Vector() lCount = 0
        end
        self:SetNW2Vector("lamp"..i,col)
    end
end
function ENT:TrainSpawnerUpdate()
    self:UpdateLampsColors()
end

--------------------------------------------------------------------------------
function ENT:Think()
    local Panel = self.Panel
    -- Initialize key mapping
    self.RetVal = self.BaseClass.Think(self)

    self:SetLightPower(8,Panel.H11 > 0)
    self:SetLightPower(9,Panel.H11 > 0)

    local lightGroup1 = Panel.HL17 > 0
    local lightGroup2 = Panel.HL20 > 0
    local bright = (lightGroup1 and 0.5 or 0)+(lightGroup2 and 0.5 or 0)
    --self:SetLightPower(2,lightGroup1,bright)
    --self:SetLightPower(3,lightGroup2,bright)
    --self:SetLightPower(4,lightGroup1,bright)
    --self:SetLightPower(5,lightGroup2,bright)
    --self:SetLightPower(6,lightGroup1,bright)
    --self:SetLightPower(7,lightGroup2,bright)

    self:SetPackedRatio("VTPR", self.VTPR.Value/3)
    self:SetPackedRatio("B013", self.Pneumatic.RealDriverValvePosition)

    self:SetNW2Int("Wrench",self.WrenchMode)
    self:SetPackedRatio("Controller",self.BKCU.Controller)
    self:SetPackedRatio("KR",(self.KR.Position+1)/2)
    self:SetPackedRatio("KRU",(self.KRU.Position+1)/2)

    self:SetPackedBool("RRIOn",self.RRI_VV.Power>0)
    self:SetPackedBool("AnnBuzz",Panel.AnnouncerBuzz > 0)
    self:SetPackedBool("AnnPlay",Panel.AnnouncerPlaying > 0)
    self:SetPackedBool("AnnCab",self.RRI_VV.CabinSpeakerPower > 0)


    -- Interior/cabin lights
    if Panel.EL2*Panel.EL1 > 0 then
        self:SetLightPower(10,true,1)
    elseif Panel.EL1 > 0 then
        self:SetLightPower(10,true,0.5)
    elseif Panel.EL2 > 0 then
        self:SetLightPower(10,true,0.5)
    else
        self:SetLightPower(10,false)
    end
    self:SetPackedBool("Cablights1",Panel.EL1 > 0)
    self:SetPackedBool("Cablights2",Panel.EL2 > 0)
    self:SetPackedBool("Headlights1",Panel.HL17 > 0)
    self:SetPackedBool("Headlights2",Panel.HL20 > 0)
    self:SetPackedBool("RedLights",Panel.H11 > 0)
    self:SetPackedBool("PanelLights",Panel.HL52 > 0)
    self:SetPackedBool("AppLights",Panel.EL31 > 0)
    self:SetLightPower(30,lightGroup1 or lightGroup2,bright)
    self:SetLightPower(31,lightGroup1 or lightGroup2,bright)

    local lightsActive1 = Panel.EL3_6 > 0
    local lightsActive2 = Panel.EL7_30 > 0
    local mul = 0
    for i = 1,28 do
        if (lightsActive2 or (lightsActive1 and math.ceil((i+5)%8)==math.ceil(i/7)%2)) then
            if not self.Lamps[i] and not self.Lamps.broken[i] then self.Lamps[i] = CurTime() + math.Rand(0.1,math.Rand(0.5,2)) end
        else
            self.Lamps[i] = nil
        end
        if (self.Lamps[i] and CurTime() - self.Lamps[i] > 0) then
            mul = mul + 1
            self:SetPackedBool("lightsActive"..i,true)
        else
            self:SetPackedBool("lightsActive"..i,false)
        end
    end
    self:SetLightPower(11,mul > 0, mul/28)
    self:SetLightPower(12,mul > 0, mul/28)
    self:SetLightPower(13,mul > 0, mul/28)

    self:SetPackedBool("BBE",self.BBE.KM1 > 0)
    self:SetPackedBool("Compressor",self.KK.Value)
    if self.PTTI.State < 0 then
        self:SetPackedRatio("RNState", ((self.PTTI.RNState)-0.25)*math.Clamp((math.abs(self.Electric.Itotal/2)-30-self.Speed*2)/20,0,1))
        self:SetNW2Int("RNFreq", 13)
    else
        self:SetPackedRatio("RNState", (0.75-self.PTTI.RNState)*math.Clamp((math.abs(self.Electric.Itotal/2)-30-self.Speed*2)/20,0,1))
        self:SetNW2Int("RNFreq", ((self.PTTI.FreqState or 0)-1/3)/(2/3)*12)
    end
    local power = false--Panel.V1 > 0.5
    self:SetNW2Bool("ASNPPlay",power and self:ReadTrainWire(47) > 0)
    --СПУ
    self:SetPackedBool("SPU_SD",Panel.SD > 0)
    self:SetPackedBool("SPU_KT",Panel.KT > 0)
    self:SetPackedBool("SPU_RS",Panel.RS)
    self:SetPackedBool("SPU_SN",Panel.LN)
    self:SetPackedBool("SPU_04",Panel.AR04 > 0)
    self:SetPackedBool("SPU_00",Panel.AR0 > 0)
    self:SetPackedBool("SPU_40",Panel.AR40 > 0)
    self:SetPackedBool("SPU_60",Panel.AR60 > 0)
    self:SetPackedBool("SPU_70",Panel.AR70 > 0)
    self:SetPackedBool("SPU_80",Panel.AR80 > 0)
    self:SetPackedBool("SPU_KES",Panel.KES > 0)
    self:SetPackedBool("SPU_ST",Panel.ST > 0)
    self:SetPackedBool("SPU_CUV",Panel.CUV > 0)
    self:SetPackedBool("SPU_AVU",Panel.AVU > 0)
    --self:SetPackedBool("SPU_AIP",false)
    --self:SetPackedBool("SPU_RIP",false)
    self:SetPackedBool("SPU_KVD",Panel.KVD > 0)
    self:SetPackedBool("SPU_VS1",Panel.VS1 > 0)
    self:SetPackedBool("SPU_VS2",Panel.VS2 > 0)
    --Лампы МВСУ
    self:SetPackedBool("BIPB", self.BUP.IPB > 0)

    self:SetPackedBool("BIV", self.BUP.IV > 0)
    self:SetPackedBool("BIN", self.BUP.IN > 0)
    self:SetPackedBool("BIX3",self.BUP.IX3 > 0)
    self:SetPackedBool("BIX2",self.BUP.IX2 > 0)
    self:SetPackedBool("BIX1",self.BUP.IX1 > 0)
    self:SetPackedBool("BI0", self.BUP.I0 > 0)
    self:SetPackedBool("BIT1",self.BUP.IT1 > 0)
    self:SetPackedBool("BIT2",self.BUP.IT2 > 0)
    self:SetPackedBool("BIT3",self.BUP.IT3 > 0)
    --self:SetPackedBool("BIBX3",self.BUP.IBX3 > 0)
    --self:SetPackedBool("BIBX2",self.BUP.IBX2 > 0)
    --self:SetPackedBool("BIBX1",self.BUP.IBX1 > 0)
    self:SetPackedBool("BIB0", self.BUP.IB0 > 0)
    --self:SetPackedBool("BIBT1",self.BUP.IBT1 > 0)
    --self:SetPackedBool("BIBT2",self.BUP.IBT2 > 0)
    --self:SetPackedBool("BIBT3",self.BUP.IBT3 > 0)
    self:SetPackedBool("BIX", self.BUP.IX > 0)
    self:SetPackedBool("BIT", self.BUP.IT > 0)
    self:SetPackedBool("BIKDV",self.BUP.IKDV > 0)
    self:SetPackedBool("BINKDV",self.BUP.INKDV > 0)
    self:SetPackedBool("BIPB",self.BUP.IPB > 0)
    self:SetPackedBool("BIARS",self.BUP.IARS > 0)
    self:SetPackedBool("BIAVT",self.BUP.IAVT > 0)
    self:SetPackedBool("BIPVU",self.BUP.IPVU > 0)
    self:SetPackedBool("BIRPB",self.BUP.IRPB > 0)
    self:SetPackedBool("BIROT",self.BUP.IROT > 0)
    self:SetPackedBool("BISOT",self.BUP.ISOT > 0)

    self:SetPackedBool("BBBUP", self.BUP.BBUP > 0)
    self:SetPackedBool("BV0", self.BUP.V0 > 0)
    self:SetPackedBool("BEKV",self.BUP.EKV > 0)
    self:SetPackedBool("BEBAV",self.BUP.EBAV > 0)
    self:SetPackedBool("BEKR",self.BUP.EKR > 0)
    self:SetPackedBool("BEARS", self.BUP.EARS > 0)

    self:SetPackedBool("BV",self.BUP.OV > 0)
    self:SetPackedBool("BN", self.BUP.ON > 0)

    self:SetPackedBool("BOX", Panel.BOX > 0)
    self:SetPackedBool("BOT", Panel.BOT > 0)
    self:SetPackedBool("BOU1",Panel.BOU1 > 0)
    self:SetPackedBool("BOU2",Panel.BOU2 > 0)
    self:SetPackedBool("BOV",Panel.BOV > 0)
    self:SetPackedBool("BON", Panel.BON > 0)
    self:SetPackedBool("BO0",Panel.BO0 > 0)
    self:SetPackedBool("BOZPT",Panel.BOZPT > 0)
    self:SetPackedBool("BOBBAV",self.BUP.OBBAV > 0)
    self:SetPackedBool("BOBBUP",self.BUP.OBBUP > 0)
    self:SetPackedBool("BMS",self.BUP.Power > 0)
    self:SetPackedBool("BMP",self.BUP.Power > 0)

    if self.OtsekDoor2 then
        --Лампы БУВ
        --МВД
        self:SetPackedBool("VOTK",self.BUV.OTK > 0)
        self:SetPackedBool("VRP",self.BUV.RP > 0)
        --МАЛП1,2
        self:SetPackedBool("VFM",self.BUV.FM > 0)
        self:SetPackedBool("VU400",self.BUV.U400 > 0)
        self:SetPackedBool("VE1350",self.BUV.E1350 > 0)

        self:SetPackedBool("VDIF",self.BUV.DIF > 0)
        self:SetPackedBool("VE13650",self.BUV.E13650 > 0)
        self:SetPackedBool("VE130",self.BUV.E130 > 0)
        self:SetPackedBool("VSN",self.BUV.SN > 0)

        self:SetPackedBool("VU800",self.BUV.U800 > 0)
        self:SetPackedBool("VU975",self.BUV.U975 > 0)
        self:SetPackedBool("VE2450",self.BUV.E2450 > 0)
        self:SetPackedBool("VE24650",self.BUV.E24650 > 0)
        self:SetPackedBool("VE240",self.BUV.E240 > 0)
        self:SetPackedBool("VBV",self.BUV.BV > 0)

        self:SetPackedBool("VMSU",self.BUV.MSU > 0)
        self:SetPackedBool("VMZK",self.BUV.MZK > 0)
        --МИВ
        self:SetPackedBool("VZZ",self.BUV.ZZ > 0)
        self:SetPackedBool("VV1",self.BUV.V1 > 0)
        self:SetPackedBool("VSMA",self.BUV.SMA > 0)
        self:SetPackedBool("VSMB",self.BUV.SMB > 0)

        self:SetPackedBool("VIVP",self.BUV.IVP > 0)
    	self:SetPackedBool("VINZ",self.BUV.INZ > 0)
    	self:SetPackedBool("VIVR",self.BUV.IVR > 0)
    	self:SetPackedBool("VINR",self.BUV.INR > 0)

        self:SetPackedBool("VIX",self.BUV.IX > 0)
    	self:SetPackedBool("VIT",self.BUV.IT > 0)
    	self:SetPackedBool("VIU1",self.BUV.IU1 > 0)
    	self:SetPackedBool("VIU2",self.BUV.IU2 > 0)
    	self:SetPackedBool("VIM",self.BUV.IM > 0)
    	self:SetPackedBool("VIXP",self.BUV.IXP > 0)
    	self:SetPackedBool("VIU1R",self.BUV.IU1R > 0)

        self:SetPackedBool("VITARS",self.BUV.ITARS > 0)
    	self:SetPackedBool("VITEM",self.BUV.ITEM > 0)
    	self:SetPackedBool("VIAVR",self.BUV.IAVR > 0)

        self:SetPackedBool("VIPROV",self.BUV.IPROV > 0)
    	self:SetPackedBool("VIPROV0",self.BUV.IPROV0 > 0)
    	self:SetPackedBool("VIVZ",self.BUV.IVZ > 0)

        self:SetPackedBool("VITP1",self.BUV.ITP1 > 0)
        self:SetPackedBool("VITP2",self.BUV.ITP2 > 0)
        self:SetPackedBool("VITP3",self.BUV.ITP3 > 0)
        self:SetPackedBool("VITP4",self.BUV.ITP4 > 0)
    	self:SetPackedBool("VIKX",self.BUV.IKX > 0)
    	self:SetPackedBool("VIKT",self.BUV.IKT > 0)
    	self:SetPackedBool("VILT",self.BUV.ILT > 0)
    	self:SetPackedBool("VIRV",self.BUV.IRV > 0)
    	self:SetPackedBool("VIRN",self.BUV.IRN > 0)
    	self:SetPackedBool("VIBV",self.BUV.IBV > 0)

        self:SetPackedBool("VOVP",self.BUV.OVP > 0)
    	self:SetPackedBool("VONZ",self.BUV.ONZ > 0)
    	self:SetPackedBool("VOLK",self.BUV.OLK > 0)
    	self:SetPackedBool("VOKX",self.BUV.OKX > 0)
    	self:SetPackedBool("VOKT",self.BUV.OKT > 0)
    	self:SetPackedBool("VOPV",self.BUV.OPV > 0)
        self:SetPackedBool("VOSN",self.BUV.OSN > 0)
        self:SetPackedBool("VOOIZ",self.BUV.OIZ > 0)
    	self:SetPackedBool("VORP",self.BUV.ORP > 0)

        self:SetPackedBool("VOV1",self.BUV.OV1 > 0)
    	self:SetPackedBool("VORKT",self.BUV.ORKT > 0)
        self:SetPackedBool("VORMT",self.BUV.ORMT > 0)
        self:SetPackedBool("VO75V",self.BUV.O75V > 0)

        self:SetPackedBool("VSS",self.BUV.SS > 0)
    end

    --Лампы
    self:SetPackedBool("HL3",Panel.HL3 > 0)
    self:SetPackedBool("HL4",Panel.HL4 > 0)
    self:SetPackedBool("HL5",Panel.HL5 > 0)
    self:SetPackedBool("HL7",Panel.HL7 > 0)
    self:SetPackedBool("HL13",Panel.HL13 > 0)
    self:SetPackedBool("HL46",Panel.HL46 > 0)
    self:SetPackedBool("HL17",Panel.HL17 > 0)
    self:SetPackedBool("HL20",Panel.HL20 > 0)
    self:SetPackedBool("HL25",Panel.HL25 > 0)
    self:SetPackedBool("HL25",Panel.HL25 > 0)
    local TW28 = 0
    if Panel.HL6 > 0 then
        local wags = #self.WagonList
        for i,v in ipairs(self.WagonList) do
            TW28 = TW28+(v.Panel.TW28 or 0)/wags
        end
    end
    --self:SetPackedRatio("HL6",HL6)
    self:SetPackedRatio("HL6",math.Clamp(TW28^0.7,0,1))
    self:SetPackedBool("VD1",Panel.VD1 > 0)
    self:SetPackedBool("RouteNumberWork",Panel.RouteNumber > 0)

    self:SetLightPower(15, Panel.HL13 > 0.5)
    self:SetLightPower(18, Panel.HL13 > 0.5)
    self:SetLightPower(16, Panel.HL25 > 0.5)
    self:SetLightPower(19, Panel.HL25 > 0.5)
    self:SetLightPower(17, Panel.HL46 > 0.5)
    self:SetLightPower(20, Panel.HL46 > 0.5)
    self:SetPackedBool("DoorsW",Panel.HL13 > 0)
    self:SetPackedBool("GRP",Panel.HL25 > 0)
    self:SetPackedBool("BrW",Panel.HL46 > 0)
    self:SetPackedBool("VPR",Panel.VPR > 0)

    self:SetPackedBool("Speedometer",Panel.Speedometer > 0)

    self:SetPackedBool("VH1",self.BZOS.VH1 > 0)
    self:SetPackedBool("VH2",self.BZOS.VH2 > 0)
    self:SetPackedRatio("M1",Panel.M1)
    self:SetPackedRatio("PVK",self.PVK.Value/2)


    self:SetPackedBool("RearDoor",self.RearDoor)
    self:SetPackedBool("PassengerDoor",self.PassengerDoor)
    self:SetPackedBool("CabinDoor",self.CabinDoor)
    self:SetPackedBool("OtsekDoor1",self.OtsekDoor1)
    self:SetPackedBool("OtsekDoor2",self.OtsekDoor2)

    self:SetPackedRatio("Speed", self.Speed/100)

    self:SetPackedBool("Vent1Work",self.BUVS.KM1>0)
    self:SetPackedBool("Vent2Work",self.BUVS.KM2>0)

    self:SetPackedRatio("BLPressure", self.Pneumatic.BrakeLinePressure/16.0)
    self:SetPackedRatio("TLPressure", self.Pneumatic.TrainLinePressure/16.0)
    self:SetPackedRatio("BCPressure", math.min(3.2,self.Pneumatic.BrakeCylinderPressure)/6.0)

    self:SetPackedRatio("EnginesVoltage", self.Electric.Power750V/1000.0)
    self:SetPackedRatio("EnginesCurrent", 0.5 + 0.5*(self.Electric.I24/500.0))
    self:SetPackedRatio("BatteryVoltage",Panel["V1"]*self.Battery.Voltage/150.0)

    --self.PB:TriggerInput("Set",0)
    --self.SB6:TriggerInput("Set",0)
    self:SetPackedBool("Ring",self.BZOS.Ring >= 1)
    self:SetPackedBool("RingBZOS",self.BZOS.Ring>0)
    -- Exchange some parameters between engines, pneumatic system, and real world
    self.Engines:TriggerInput("Speed",self.Speed)
    if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and not self.IgnoreEngine then
        local A = 2*self.Engines.BogeyMoment
        --self.FrontBogey.MotorForce = 27000+1000*(A < 0 and 1 or 0)
        --self.RearBogey.MotorForce  = 27000+1000*(A < 0 and 1 or 0)
        self.FrontBogey.MotorForce = 22500+5000*(A < 0 and 1 or 0)*math.max(self.KMR1.Value,self.KMR2.Value)
        self.RearBogey.MotorForce  = 22500+5000*(A < 0 and 1 or 0)*math.max(self.KMR1.Value,self.KMR2.Value)
        self.FrontBogey.Reversed = (self.KMR2.Value > 0.5)
        self.RearBogey.Reversed = (self.KMR1.Value > 0.5)
        -- These corrections are required to beat source engine friction at very low values of motor power
        local P = math.max(0,0.04449 + 1.06879*math.abs(A) - 0.465729*A^2)
        if math.abs(A) > 0.4 then P = math.abs(A) end
        --if math.abs(A) < 0.05 then P = 0 end
        if self.Speed < 10 and A > 0 then P = P*(1.0 + 2.5*(10.0-self.Speed)/10.0) end
        self.RearBogey.MotorPower  = P*0.5*((A > 0) and 1 or -1)
        self.FrontBogey.MotorPower = P*0.5*((A > 0) and 1 or -1)
        --self.RearBogey.MotorPower  = P*0.5
        --self.FrontBogey.MotorPower = P*0.5

        --self.Acc = (self.Acc or 0)*0.95 + self.Acceleration*0.05
        --print(self.Acc)

        -- Apply brakes
        self.FrontBogey.PneumaticBrakeForce = 50000.0-2000
        self.FrontBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.FrontBogey.ParkingBrakePressure = math.max(0,(2.6-self.Pneumatic.ParkingBrakePressure)/2.6)
        self.FrontBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
        self.FrontBogey.DisableContacts = self.U5.Value>0
        self.RearBogey.PneumaticBrakeForce = 50000.0-2000
        self.RearBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.RearBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
        self.RearBogey.DisableContacts = self.U5.Value>0
        --self.RearBogey.ParkingBrake = self.ParkingBrake.Value > 0.5
    end
    self:GenerateJerks()

    return self.RetVal
end

function ENT:TriggerTurbostroiInput(sys,name,val)
    self.BaseClass.TriggerTurbostroiInput(self,sys,name,val)
end

--------------------------------------------------------------------------------
function ENT:OnButtonPress(button,ply)
    if string.find(button,"PneumaticBrakeSet") then
        self.Pneumatic:TriggerInput("BrakeSet",tonumber(button:sub(-1,-1)))
        return
    end
    if button == "RearDoor" then self.RearDoor = not self.RearDoor end
    if button == "PassengerDoor" then self.PassengerDoor = not self.PassengerDoor end
    if button == "CabinDoor" then self.CabinDoor = not self.CabinDoor end
    if button == "OtsekDoor1" then self.OtsekDoor1 = not self.OtsekDoor1 end
    if button == "OtsekDoor2" then self.OtsekDoor2 = not self.OtsekDoor2 end
    if button == "KR+" then
        if self.WrenchMode == 1 then
            self.KR:TriggerInput("Set",self.KR.Position+1)
        elseif self.WrenchMode == 2 then
            self.KRU:TriggerInput("Set",self.KRU.Position+1)
        end
    end
    if button == "KR-" then
        if self.WrenchMode == 1 then
            self.KR:TriggerInput("Set",self.KR.Position-1)
        elseif self.WrenchMode == 2 then
            self.KRU:TriggerInput("Set",self.KRU.Position-1)
        end
    end
    if button == "EmergencyBrake" then
        self.BKCU:TriggerInput("KV7",1)
        self.Pneumatic:TriggerInput("BrakeSet",7)
        return
    end
    if button == "WrenchKR" then
        if self.WrenchMode == 0 then
            self:PlayOnce("kr_in","cabin",1)
            self.WrenchMode = 1
        end
    end
    if button == "WrenchKRU" then
        if self.WrenchMode == 0 then
            self:PlayOnce("kru_in","cabin",1)
            self.WrenchMode = 2
        end
    end
    if button == "WrenchNone" then
        if self.WrenchMode ~= 0 then
            if self.WrenchMode == 2 and self.KRU.Position == 0 then
                self:PlayOnce("kru_out","cabin",1,1)
                self.WrenchMode = 0
            elseif self.WrenchMode == 1 and self.KR.Position == 0 then
                self:PlayOnce("kr_out","cabin",1,1)
                self.WrenchMode = 0
            end
        end
    end
    if button == "SB1" then
        self.SA7:TriggerInput("Open",1)
        self.SB1:TriggerInput("Set",1-self.SA5.Value)
    end
    if button == "SB2" then
        self.SA7:TriggerInput("Close",1)
        self.SB2:TriggerInput("Set",1-self.SA5.Value)
    end
    if button == "SB6" then
        if self.WrenchMode==2 then
            self.SBR16:TriggerInput("Set",1)
        elseif not self.Plombs.SB6 then
            self.SB6K:TriggerInput("Set",0)
            self.SB6:TriggerInput("Set",1)
        end
    end
    if button == "SB7" then
        --self.BKCU:TriggerInput("KV1",1)
        self.SB7K:TriggerInput("Set",0)
        self.SB7:TriggerInput("Set",1)
    end
end

function ENT:OnButtonRelease(button)
    if string.find(button,"PneumaticBrakeSet") then
        if button == "PneumaticBrakeSet1" and (self.Pneumatic.DriverValvePosition == 1) then
            self.Pneumatic:TriggerInput("BrakeSet",2)
        end
        return
    end
    if button == "SB1" then
        self.SB1:TriggerInput("Set",0)
    end
    if button == "SB2" then
        self.SB2:TriggerInput("Set",0)
    end
    if button == "SB6" then
        if not self.Plombs.SB6 then self.SB6:TriggerInput("Set",0) end
        self.SBR16:TriggerInput("Set",0)
    end
    if button == "SB7" then
        self.SB7:TriggerInput("Set",0)
    end
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

function ENT:OnTrainWireError(k)
end
function ENT:OnPlay(soundid,location,range,pitch)
    return soundid,location,range,pitch
end

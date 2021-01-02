AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner

--"DURASelectMain","DURASelectAlternate","DURAToggleChannel","DURAPowerToggle",
ENT.SyncTable = {
    "R_UNch","R_ZS","R_G","R_UPO","KVT",
    "VZ1","VUD1","KDL","KDLR","KDLK","KDLRK","KDP","KDPK","DoorSelect",
    "KRZD","R_VPR","VozvratRP","AVU","KVP","ConverterProtection","RZP",--"SP","GreenRP",
    "VPAOn","VPAOff",
    "KSN","Ring","ARS","ALS","OtklAVU","TormAT","L_1","L_2","L_3","OhrSig",
    "VMK","BPSNon","RezMK","ARS13","Radio13","L_4","VUS","VAH","VAD","KRP","OVT",
    "EmergencyBrakeValve",
    "AIS","AV3","AV1","A53","A55","A56","A54","A17","A44","A39","A70","A14","A74","A26","AR63","AS1","A13","A21","A31","A32","A16","A12","A24","A49","A27","A72","A50","AV3","AV6","A29","A46","A47","A71","A7","A9","A84","A8","A52","A19","A48","A10","A22","A30","A1","A2","A3","A4","A5","A6","A18","A73","A20","A25","A11","A37","A45","A38","A51","A65","A42","A43","A41","A40","A75","A76","A60","A57","A28",
    "A58","A59","A61","A15","A66",
    "RC1","VB","VRD","PB", "UAVA",
    "DriverValveBLDisconnect","DriverValveTLDisconnect","DriverValveDisconnect","ParkingBrake","EPK",
    "VUD2","VDL","VOPD","Wiper", "GV", "RC2","VAU",
    "KH","VAV","KSZD","VZP","VSOSD",
    "PAM7","PAM8","PAM9","PAMLeft","PAMRight","PAM4","PAM5","PAM6","PAMUp","PAM1","PAM2","PAM3","PAMDown","PAM0","PAMEnter","PAMEsc","PAMF","PAMM","PAMP",
}
ENT.SyncFunctions = {
    ""
}
function ENT:Initialize()
    self.Plombs = {
        VAH = true,
        VAD = true,
        OtklAVU = true,
        OVT = true,
        R_VPR = true,
        A41=true,
        AIS=true,
        --TormAT = true,
        --KAH = {true,"KAHK"},
        --KAHK = true,
        RC1 = true,
        RC2 = true,
        UAVA = true,
        Init = true,
    }
    -- Set model and initialize
    self.MaskType = 1
    self.LampType = 1
    self.WorkingLights = 6
    self:SetModel("models/metrostroi_train/81-717/81-717_spb.mdl")
    self.BaseClass.Initialize(self)
    self:SetPos(self:GetPos() + Vector(0,0,140))

    -- Create seat entities
    self.DriverSeat = self:CreateSeat("driver",Vector(417,0,-22.5))
    self.InstructorsSeat = self:CreateSeat("instructor",Vector(425,50,-28+3),Angle(0,270,0))
    self.ExtraSeat1 = self:CreateSeat("instructor",Vector(410,30,-43),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")
    self.ExtraSeat2 = self:CreateSeat("instructor",Vector(422,-45,-43),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")
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
        self.FrontCouple = self:CreateCouple(Vector( 419.5,0,-62),Angle(0,0,0),true,"722")
        self.RearCouple  = self:CreateCouple(Vector(-419.5-6.545,0,-62),Angle(0,180,0),false,"717")
    else
        self.FrontBogey = self:CreateBogey(Vector( 317-11,0,-80),Angle(0,180,0),true,"717")
        self.RearBogey  = self:CreateBogey(Vector(-317+0,0,-80),Angle(0,0,0),false,"717")
        self.FrontCouple = self:CreateCouple(Vector( 410-3,0,-66),Angle(0,0,0),true,"722")
        self.RearCouple  = self:CreateCouple(Vector(-423+2,0,-66),Angle(0,180,0),false,"717")
    end
    local pneumoPow = 1.1+(math.random()^0.4)*0.3
    self.FrontBogey.PneumaticPow = pneumoPow
    self.RearBogey.PneumaticPow = pneumoPow

    -- Initialize key mapping
    self.KeyMap = {
        [KEY_1] = "KVSetX1B",
        [KEY_2] = "KVSetX2",
        [KEY_3] = "KVSetX3",
        [KEY_4] = "KVSet0",
        [KEY_5] = "KVSetT1B",
        [KEY_6] = "KVSetT1AB",
        [KEY_7] = "KVSetT2",
        [KEY_8] = "KRPSet",

        [KEY_EQUAL] = "R_Program1Set",
        [KEY_MINUS] = "R_Program2Set",

        [KEY_G] = "VozvratRPSet",

        [KEY_0] = "KVReverserUp",
        [KEY_9] = "KVReverserDown",
        [KEY_PAD_PLUS] = "KVReverserUp",
        [KEY_PAD_MINUS] = "KVReverserDown",
        [KEY_W] = "KVUp",
        [KEY_S] = "KVDown",
        [KEY_F] = "PneumaticBrakeUp",
        [KEY_R] = "PneumaticBrakeDown",

        [KEY_A] = {"KDL",helper="VDLSet"},
        [KEY_D] = "KDP",
        [KEY_V] = {"VUD1Toggle",helper="VUD2Toggle"},
        [KEY_L] = "HornEngage",
        [KEY_N] = "VZ1Set",
        [KEY_PAD_1] = "PneumaticBrakeSet1",
        [KEY_PAD_2] = "PneumaticBrakeSet2",
        [KEY_PAD_3] = "PneumaticBrakeSet3",
        [KEY_PAD_4] = "PneumaticBrakeSet4",
        [KEY_PAD_5] = "PneumaticBrakeSet5",
        [KEY_PAD_6] = "PneumaticBrakeSet6",
        [KEY_PAD_7] = "PneumaticBrakeSet7",
        [KEY_PAD_DIVIDE] = "KRPSet",
        [KEY_PAD_MULTIPLY] = "KAHSet",

        [KEY_SPACE] = "PBSet",
        [KEY_BACKSPACE] = {"EmergencyBrake",helper="EmergencyBrakeValveToggle"},

        [KEY_PAD_ENTER] = "KVWrenchKV",
        [KEY_PAD_0] = "DriverValveDisconnect",
        [KEY_PAD_DECIMAL] = "EPKToggle",
        [KEY_LSHIFT] = {
            def="KV_Unlock",
            [KEY_SPACE] = "KVTSet",
            [KEY_V] = "KSZDSet",
            [KEY_R] = "VZPToggle",

            [KEY_2] = "RingSet",
            [KEY_4] = "KVSet0Fast",
            [KEY_L] = "DriverValveDisconnect",

            [KEY_7] = "KVWrenchNone",
            [KEY_8] = "KVWrenchKRU",
            [KEY_9] = "KVWrenchKV",
            [KEY_0] = "KVWrenchKV",
            [KEY_6] = "KVSetT1A",

            [KEY_PAD_ENTER] = "KVWrenchNone",
        },

        [KEY_LALT] = {
            [KEY_V] = "VUD1Toggle",
            [KEY_L] = "EPKToggle",
            [KEY_PAD_PLUS] = "Custom2Set",
            [KEY_PAD_MINUS] = "Custom1Set",
            [KEY_PAD_ENTER] = "Custom3Set",
            [KEY_PAD_ENTER] = "Custom3Set",
            [KEY_PAD_MULTIPLY] = "CustomCToggle",
            [KEY_PAD_7] = "PAM7Set",
            [KEY_PAD_8] = "PAM8Set",
            [KEY_PAD_9] = "PAM9Set",
            [KEY_LEFT] = "PAMLeftSet",
            [KEY_RIGHT] = "PAMRightSet",
            [KEY_PAD_4] = "PAM4Set",
            [KEY_PAD_5] = "PAM5Set",
            [KEY_PAD_6] = "PAM6Set",
            [KEY_UP] = "PAMUpSet",
            [KEY_PAD_1] = "PAM1Set",
            [KEY_PAD_2] = "PAM2Set",
            [KEY_PAD_3] = "PAM3Set",
            [KEY_DOWN] = "PAMDownSet",
            [KEY_PAD_0] = "PAM0Set",
            [KEY_PAD_ENTER] = "PAMEnterSet",
            [KEY_PAD_DECIMAL] = "PAMEscSet",
            [KEY_PAD_DIVIDE] = "PAMFSet",
            [KEY_PAD_MULTIPLY] = "PAMMSet",
            [KEY_PAD_MINUS] = "PAMPSet",
        },
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
            Pos = Vector(140.50,62,-64), Radius = 10,
        },
        {
            ID = "AirDistributorDisconnectToggle",
            Pos = Vector(-177, -66, -50), Radius = 20,
        },
    }

    local vX = Angle(0,-90-0.2,56.3):Forward() -- For ARS panel
    local vY = Angle(0,-90-0.2,56.3):Right()
    self.Lights = {
        -- Headlight glow
        --[1] = { "headlight",      Vector(465,0,-20), Angle(0,0,0), Color(216,161,92), fov = 100, farz=6144,brightness = 4},

        -- Head (type 1)
        [2] = { "glow",             Vector(470,-51,-19), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 1.0 },
        [3] = { "glow",             Vector(472,-40, -19), Angle(0,0,0),Color(255,220,180), brightness = 1, scale = 1.0 },
        [4] = { "glow",             Vector(0,0, 0), Angle(0,0,0),  Color(255,220,180), brightness = 1, scale = 1.0 },
        [5] = { "glow",             Vector(0, 0, 0), Angle(0,0,0),  Color(255,220,180), brightness = 1, scale = 1.0 },
        [6] = { "glow",             Vector(472, 41, -19), Angle(0,0,0),Color(255,220,180), brightness = 1, scale = 1.0 },
        [7] = { "glow",             Vector(470, 53,-19), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 1.0 },

        -- Reverse
        [8] = { "light",Vector(465,-45, 52), Angle(0,0,0), Color(255,50,50),     brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02.vmt"  },
        [9] = { "light",Vector(465, 45, 52), Angle(0,0,0), Color(255,50,50),     brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02.vmt"  },

        -- Cabin
        [10] = { "dynamiclight",        Vector( 425, 0, 30), Angle(0,0,0), Color(216,161,92), distance = 550, brightness = 0.25},

        -- Interior
        [11] = { "dynamiclight",    Vector( 200, 0, 0), Angle(0,0,0), Color(255,245,245), brightness = 3, distance = 400 , fov=180,farz = 128 },
        [12] = { "dynamiclight",    Vector(   0, 0, 0), Angle(0,0,0), Color(255,245,245), brightness = 3, distance = 400, fov=180,farz = 128 },
        [13] = { "dynamiclight",    Vector(-200, 0, 0), Angle(0,0,0), Color(255,245,245), brightness = 3, distance = 400 , fov=180,farz = 128 },

        -- Side lights
        [15] = { "light",Vector(-52,67,45.5)+Vector(0,0.9,3.25), Angle(0,0,0), Color(254,254,254), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [16] = { "light",Vector(-52,67,45.5)+Vector(0,0.9,-0.02), Angle(0,0,0), Color(40,240,122), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [17] = { "light",Vector(-52,67,45.5)+Vector(0,0.9,-3.3), Angle(0,0,0), Color(254,210,18), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [18] = { "light",Vector(39,-67,45.5)+Vector(0,-0.9,3.25), Angle(0,0,0), Color(254,254,254), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [19] = { "light",Vector(39,-67,45.5)+Vector(0,-0.9,-0.02), Angle(0,0,0), Color(40,240,122), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [20] = { "light",Vector(39,-67,45.5)+Vector(0,-0.9,-3.3), Angle(0,0,0), Color(254,210,18), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },

        [30]  = { "light",           Vector(465  ,   -45, -23.5), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02.vmt" },
        [31]  = { "light",           Vector(465  ,   45, -23.5), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02.vmt" },
        [32]  = { "light",           Vector(465  ,   0, 52), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02.vmt" },
    }
    -- Cross connections in train wires
    self.TrainWireInverts = {
        [28] = true,
        [34] = true,
    }
    self.TrainWireCrossConnections = {
        [5] = 4, -- Reverser F<->B
        [31] = 32, -- Doors L<->R
        [53] = 54,
    }

    -- Setup door positions
    self.LeftDoorPositions = {}
    self.RightDoorPositions = {}
    for i=0,3 do
        table.insert(self.LeftDoorPositions,Vector(353.0 - 35*0.5 - 231*i,65,-1.8))
        table.insert(self.RightDoorPositions,Vector(353.0 - 35*0.5 - 231*i,-65,-1.8))
    end


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
    for i = 1,12 do
        if math.random() > rand then self.Lamps.broken[i] = math.random() > 0.5 end
    end

    self:SetNW2Int("Type",self:GetNW2Int("Type",2))
    self:TrainSpawnerUpdate()
    self:OnButtonPress("KVWrenchNone")
end

function ENT:TriggerLightSensor(coil,plate)
    if self.LightSensor then
        self.PAM:TriggerSensor(coil,plate)
    end
end
function ENT:UpdateLampsColors()
    local lCol,lCount = Vector(),0
    if self.LampType == 1 then
        local r,g,col = 15,15
        local typ = math.Round(math.random())
        local rnd =  0.5+math.random()*0.5
        for i = 1,13 do
            local chtp = math.random() > rnd

            if typ == 0 and not chtp or typ == 1 and chtp then
                g = math.random()*15
                col=Vector(240+g,240+g,255)
            else
                b = -5+math.random()*20
                col = Vector(255,255,235+b)
            end
            lCol = lCol + col
            lCount = lCount + 1
            if i%4==0 then
                local id = 10+math.ceil(i/4)
                self:SetLightPower(id,false)

                local tcol = (lCol/lCount)/255
                self.Lights[id][4] = Vector(tcol.r,tcol.g^3,tcol.b^3)*255
                lCol = Vector()
                lCount = 0
            end
            self:SetNW2Vector("lamp"..i,col)
        end
    else
        local rnd1,rnd2,col = 0.7+math.random()*0.3,math.random()
        local typ = math.Round(math.random())
        local r,g = 15,15
        for i = 1,25 do
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
            if i%8.3<1 then
                local id = 9+math.ceil(i/8.3)
                self:SetLightPower(id,false)

                local tcol = (lCol/lCount)/255
                self.Lights[id][4] = Vector(tcol.r,tcol.g^3,tcol.b^3)*255
                lCol = Vector() lCount = 0
            end
            self:SetNW2Vector("lamp"..i,col)
        end
    end
end
function ENT:TrainSpawnerUpdate()
    local typ = self:GetNW2Int("Type")
    local num = self.WagonNumber
    math.randomseed(num+817171)
    local kvr=false
    local seats=false
    local mask = 3
    local passtex = "Def_717SPBWhite"
    local cabtex = "Def_PUAV"
    local ring,puring = math.ceil(math.random()*4)
    self:SetNW2Int("RingType",ring)
    if typ == 1 then --PAKSDM
        self.Electric:TriggerInput("X2PS",0)
        self.Electric:TriggerInput("Type",self.Electric.LVZ_4)
        self.PAM:TriggerInput("KSDMode",1)
        self:SetNW2Int("AVType",4)
        kvr = num>=8875 or math.random()>0.5
        passtex = kvr and
        (num<=8888 and "Def_717SPBWhite"
            or num <10000 and "Def_717SPBWood3"
            or "Def_717SPBCyan")
        or "Def_717SPBWhite"
        cabtex = kvr and "Def_PAKSD2" or "Def_PAKSD"

        self:SetNW2Int("RingTypePA",math.ceil(math.random()*3))

        if kvr then
            self.UPO.Buzz = math.random() > 0.7 and 2 or math.random() > 0.7 and 1
        else
            self.UPO.Buzz = math.random() > 0.4 and 2 or math.random() > 0.4 and 1
        end
        if not IsValid(self.LightSensor) then
            self.LightSensor = self:AddLightSensor(Vector(0,0,0),Angle(0,0,0),"models/metrostroi_train/81-717/rfid_reader.mdl")
        end
        SafeRemoveEntity(self.LeftAutoCoil)
        SafeRemoveEntity(self.RightAutoCoil)
        SafeRemoveEntity(self.SBPPSensor)
        self:SetNW2Bool("NewUSS",kvr or math.random()>0.3)
    elseif typ == 2 then --PUAV
        self.Electric:TriggerInput("X2PS",1)
        self.Electric:TriggerInput("Type",self.Electric.LVZ_2)
        self.PAM:TriggerInput("KSDMode",0)
        self:SetNW2Int("AVType",2)
        seats = math.random()>0.2

        repeat
            puring = math.ceil(math.random()*3)
        until puring~=ring
        self:SetNW2Int("RingTypePA",puring)
        self.UPO.Buzz = math.random() > 0.6 and 2 or math.random() > 0.6 and 1
        if self.SBPP then
            if not IsValid(self.SBPPSensor) then
                self.SBPPSensor = self:AddLightSensor(Vector(0,0,0),Angle(0,0,0),"models/metrostroi_train/81-717/dkp_reader.mdl")
            end
            SafeRemoveEntity(self.LeftAutoCoil)
            SafeRemoveEntity(self.RightAutoCoil)
        else
            if not IsValid(self.LeftAutoCoil) then self.LeftAutoCoil = self:AddAutodriveCoil(self.FrontBogey,false) end
            if not IsValid(self.RightAutoCoil) then self.RightAutoCoil = self:AddAutodriveCoil(self.FrontBogey,true) end
            SafeRemoveEntity(self.SBPPSensor)
        end
        SafeRemoveEntity(self.LightSensor)
        self:SetNW2Bool("NewUSS",kvr or math.random()>0.3)
    elseif typ == 3 then --PAM
        --[[ self.Electric:TriggerInput("X2PS",1)
        self.Electric:TriggerInput("Type",self.Electric.LVZ_3)
        self:SetNW2Int("MaskType",3)
        self:SetNW2Int("Crane",1)
        self:SetNW2Int("AVType",3)
        self:SetNW2Bool("KVR",true)
        --]]
        self.Electric:TriggerInput("X2PS",1)
        self.Electric:TriggerInput("Type",self.Electric.LVZ_3)
        self:SetNW2Int("AVType",3)
        kvr = true
        passtex = 10000<=num and num<=10072 and "Def_717SPBCyan"
                or num==10177 and "Def_717SPBWood"
                or num == 10178 and "Def_717SPBWood2"
                or "Def_717SPBWhite"

        self:SetNW2Int("RingTypePA",math.ceil(math.random()*3))
        self.UPO.Buzz = math.random() > 0.6 and 2 or math.random() > 0.6 and 1

        if not IsValid(self.LightSensor) then self.LightSensor = self:AddLightSensor(Vector(0,0,0),Angle(0,0,0),"models/metrostroi_train/81-717/rfid_reader.mdl") end
        SafeRemoveEntity(self.LeftAutoCoil)
        SafeRemoveEntity(self.RightAutoCoil)
        SafeRemoveEntity(self.SBPPSensor)
        self:SetNW2Bool("NewUSS",true)
    end

    local bpsn = math.ceil(math.random()*4)
    self:SetNW2Int("BPSNType",math.random()>0.2 and 5 or bpsn)
    self:SetNW2Int("MaskType",not kvr and (8400<=num and num<=8599) and math.ceil(math.random()*3) or 3)
    self:SetNW2Bool("WhitePLights",math.random()>0.5)
    self:SetNW2Int("Crane",kvr and 1 or 0)
    self:SetNW2Bool("KVR",kvr)
    self:SetNW2String("PassTexture",passtex)
    self:SetNW2String("CabTexture",cabtex)
    self:SetNW2Bool("NewSeats",kvr or seats)
    self.Pneumatic.ValveType = self:GetNW2Int("Crane",1)+1
    self.Announcer.AnnouncerType = self:GetNW2Int("Announcer",1)
    self:UpdateTextures()
    self:UpdateLampsColors()

    self:SetNW2Float("UPONoiseVolume",math.Rand(0,0.4))
    self:SetNW2Float("UPOVolume",math.Rand(0.9,1))
    self:SetNW2Float("UPOBuzzVolume",math.Rand(0.6,0.9))
    local used = {}
    local str = ""
    for i,k in ipairs(self.PR14XRelaysOrder) do
        local v = self.PR14XRelays[k]
        repeat
            local rndi = math.ceil(math.random()*#v)
            if not used[v[rndi][1]] then
                str = str..rndi
                used[v[rndi][1]] = true
                break
            end
        until not used[v[rndi][1]]
        --print(k,v)
    end
    self:SetNW2String("RelaysConfig",str)

    local pneumoPow = 1.3+(math.random()^1.2)*0.3
    if IsValid(self.FrontBogey) then
        self.FrontBogey:SetNW2Int("SquealType",math.floor(math.random()*7)+1)
        self.FrontBogey.PneumaticPow = pneumoPow
    end
    if IsValid(self.RearBogey) then
        self.RearBogey:SetNW2Int("SquealType",math.floor(math.random()*7)+1)
        self.RearBogey.PneumaticPow = pneumoPow
    end
    self:SetNW2Bool("SecondKV",math.random()>0.7)
    math.randomseed(os.time())
end
--[[
local LK = {}
local PKG = 0
local RK = 0
local KV = 0
local OldTime
]]

function ENT:NonSupportTrigger()
    self.RC1:TriggerInput("Set",0)
    self.RC2:TriggerInput("Set",0)
    self.VAU:TriggerInput("Set",0)
    self.VAH:TriggerInput("Set",1)
    self.OVT:TriggerInput("Set",1)
    self.EPK:TriggerInput("Set",0)
    self.ARS:TriggerInput("Set",0)
    self.ALS:TriggerInput("Set",0)
    self.VAU:TriggerInput("Set",0)
    self.KSD_VAU:TriggerInput("Set",0)
    self.Plombs.RC1 = nil
    self.Plombs.RC2 = nil
    self.Plombs.VAU = nil
    self.Plombs.VAH = nil
    self.Plombs.OVT = nil
end
--------------------------------------------------------------------------------
function ENT:Think()
    self.RetVal = self.BaseClass.Think(self)
    -- Reverser lights
    local brightness = math.min(1,self.Panel.Headlights1)*0.60 +
                        math.min(1,self.Panel.Headlights2)*0.40

    self:SetPackedBool("Headlights1",self.Panel.Headlights1 > 0)
    self:SetPackedBool("Headlights2",self.Panel.Headlights2 > 0)
    self:SetPackedBool("RedLights",self.Panel.RedLight2 > 0)
    self:SetPackedBool("CabLights",self.Panel.CabLights>0)
    self:SetPackedBool("EqLights",self.Panel.EqLights>0)
    -- Interior/cabin lights

    if (self.Panel.EqLights > 0.5) and (self.Panel.CabLights > 0.5) then
        self:SetLightPower(10,true,1)
    elseif (self.Panel.CabLights > 0.5) then
        self:SetLightPower(10,true,0.1)
    elseif self.Panel.EqLights > 0.5 then
        self:SetLightPower(10,true,0.6)
    else
        self:SetLightPower(10,false)
    end

    self:SetPackedBool("PanelLights",self.Panel.PanelLights > 0.5)
    self:SetPackedBool("BURPower",self.Panel.BURPower>0)

    --self:SetLightPower(30, (self.Panel.CabinLight > 0.5), 0.03 + 0.97*self.L_2.Value)

    self:SetLightPower(30,brightness > 0,brightness)
    self:SetLightPower(31,brightness > 0,brightness)
    self:SetLightPower(32,self:GetNW2Int("MaskType")==3 and brightness > 0,brightness)
    self:SetLightPower(8,self.Panel.RedLight2>0,1)
    self:SetLightPower(9,self.Panel.RedLight1>0,1)
    local lightsActive1 = self.Panel.EmergencyLights > 0
    local lightsActive2 = self.Panel.MainLights > 0.0
    local mul = 0
    local LampCount  = self.LampType==2 and 25 or 12
    local Ip = self.LampType==2 and 7 or 3.6
    local Im = 0
    for i = 1,LampCount do
        if (lightsActive2 or (lightsActive1 and math.ceil((i+Ip-Im)%Ip)==1)) then
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
    self:SetLightPower(11, mul > 0,mul/LampCount)
    self:SetLightPower(12, mul > 0,mul/LampCount)
    self:SetLightPower(13, mul > 0,mul/LampCount)

    self:SetPackedBool("DoorsLeftL",self.Panel.DoorsLeft > 0.5)
    self:SetPackedBool("DoorsRightL",self.Panel.DoorsRight > 0.5)

    -- Side lights
    self:SetLightPower(15,self.Panel.DoorsW > 0.5)
    self:SetLightPower(18,self.Panel.DoorsW > 0.5)
    self:SetLightPower(16,self.Panel.GreenRP > 0.5)
    self:SetLightPower(19,self.Panel.GreenRP > 0.5)
    self:SetLightPower(17,self.Panel.BrW > 0.5)
    self:SetLightPower(20,self.Panel.BrW > 0.5)
    self:SetPackedBool("DoorsW",self.Panel.DoorsW > 0)
    self:SetPackedBool("GRP",self.Panel.GreenRP > 0)
    self:SetPackedBool("BrW",self.Panel.BrW > 0)

    -- Switch and button states
    self:SetPackedBool(0,self:IsWrenchPresent())
    self:SetPackedBool("AVU",self.Panel.AVU > 0.5)
    self:SetPackedBool("OhSigLamp",self.Panel.OhrSig > 0.5)
    self:SetPackedBool("LKVP",self.Panel.LKVP > 0)
    --self:SetPackedBool("LSP",(self.Electric.Overheat1 > 0) or (self.Electric.Overheat2 > 0))
    self:SetPackedBool("RZP",self.Panel.RZP > 0)
    self:SetPackedBool("KUP",self.Panel.KUP > 0.5)
    self:SetPackedBool("PN", self.Panel.BrT > 0.5)
    self:SetPackedBool("VPR",self.Panel.VPR > 0)

    -- Signal if doors are open or no to platform simulation
    self.LeftDoorsOpen =
        (self.Pneumatic.LeftDoorState[1] > 0.5) or
        (self.Pneumatic.LeftDoorState[2] > 0.5) or
        (self.Pneumatic.LeftDoorState[3] > 0.5) or
        (self.Pneumatic.LeftDoorState[4] > 0.5)
    self.RightDoorsOpen =
        (self.Pneumatic.RightDoorState[1] > 0.5) or
        (self.Pneumatic.RightDoorState[2] > 0.5) or
        (self.Pneumatic.RightDoorState[3] > 0.5) or
        (self.Pneumatic.RightDoorState[4] > 0.5)

    -- DIP/power
    self:SetPackedBool("LUDS",self.Panel.LUDS > 0.5)

    self:SetPackedBool("HRK",self.Panel.LhRK > 0)
    self:SetPackedBool("KVC",self.Panel.KVC > 0)
    -- Red RP
    local TW18 = 0
    if self.Panel.LSN > 0 then
        local wags = #self.WagonList
        for i,v in ipairs(self.WagonList) do
            TW18 = TW18+(v.Panel.TW18 or 0)/wags
        end
    end

    self:SetPackedBool("RP",TW18 > 0.5)
    self:SetPackedBool("SN",TW18 > 0)
    -- Green RP
    ----self:SetLightPower(22,self.Panel.GreenRP > 0.5)
    -- Cabin heating
    ----self:SetLightPower(26,self.Panel.KUP > 0.5)
    -- AVU
    --21.3 -0.4 5.05
        -- AVU
    ----self:SetLightPower(23,self.Panel.AVU > 0.5)
    -- SD
    self:SetPackedBool("SD",self.Panel.SD > 0.5)
    if self:GetNW2Int("AVType")==4 then
        self:SetPackedBool("AR04",self.PAM.NoFreq > 0)
        self:SetPackedBool("AR20",(self.PAM.NoFreq > 0 or self.PAM.F5 > 0))
        self:SetPackedBool("AR0",self.PAM.F5 > 0)
        self:SetPackedBool("AR40",self.PAM.F4 > 0)
        self:SetPackedBool("AR60",self.PAM.F3 > 0)
        self:SetPackedBool("AR70",self.PAM.F2 > 0)
        self:SetPackedBool("AR80",self.PAM.F1 > 0)
    else
        self:SetPackedBool("AR04",self.ALS_ARS.NoFreq > 0)
        self:SetPackedBool("AR20",(self.ALS_ARS.NoFreq > 0 or self.ALS_ARS.F5 > 0))
        self:SetPackedBool("AR0",self.ALS_ARS.F5 > 0)
        self:SetPackedBool("AR40",self.ALS_ARS.F4 > 0)
        self:SetPackedBool("AR60",self.ALS_ARS.F3 > 0)
        self:SetPackedBool("AR70",self.ALS_ARS.F2 > 0)
        self:SetPackedBool("AR80",self.ALS_ARS.F1 > 0)
    end
    if self:GetNW2Int("AVType")>2 then self:SetPackedBool("PAPower",self.PAM.State~=0) end
    -- KT
    self:SetPackedBool("KT",self.Panel.KT > 0)
    -- ЛРД
    self:SetPackedBool("LRD",self:GetNW2Int("AVType")<=2 and self.ALS_ARS.F6>0)
    -- KVD
    self:SetPackedBool("KVD",self.Panel.LKVD > 0.5)
    -- LST
    self:SetPackedBool("ST",self.Panel.LST > 0.5)
    -- LVD
    self:SetPackedBool("VD",self.Panel.LVD > 0.5)
    -- LKVC
    --PUAV
    if self:GetNW2Int("AVType")<=2 then
        --print(self.PUAV.SetDoorMode)
        self:SetPackedBool("PUK16",self.PUAV.LK16 > 0)--self:ReadTrainWire(16) > 0)
        self:SetPackedBool("PUOS",self.PUAV.LOS > 0)--self.RC1.Value == 0)
        self:SetPackedBool("PUAVT",self.PUAV.LAVT > 0)--self.AVT.Value == 0)
        self:SetPackedBool("PULRS",self.PUAV.LRS > 0)--self.ALS_ARS.EnableARS)
        self:SetPackedBool("PUKI1",self.PUAV.LKI1 > 0)--CurTime()%0.2>0.1)
        self:SetPackedBool("PUKI2",self.PUAV.LKI2 > 0)--CurTime()%0.2<0.1)
        --self:SetPackedBool("AR20",(self.PUAV.NoFreq > 0 or self.PUAV.F5 > 0))
        self:SetPackedBool("PU04",self.PUAV.NoFreq > 0)
        self:SetPackedBool("PU0",self.PUAV.F5 > 0)
        self:SetPackedBool("PU40",self.PUAV.F4 > 0)
        self:SetPackedBool("PU60",self.PUAV.F3 > 0)
        self:SetPackedBool("PU70",self.PUAV.F2 > 0)
        self:SetPackedBool("PU80",self.PUAV.F1 > 0)
        self:SetPackedBool("PURing",self.PUAV.Ring>0)
        self:SetPackedBool("PURingZ",self.PUAV.RingZero>0)
    else
        self:SetPackedBool("PURing",self.PAM.Ring>0)
    end
    self:SetPackedBool("NMLow",self.Panel.NMLow > 0)
    self:SetPackedBool("UAVATriggered",self.Panel.UAVATriggered > 0 and CurTime()%0.4>0.2)

    ----self:SetLightPower(24,(self.PowerSupply.XT3_1 > 0) and (self.Panel.V1 > 0.5))
    -- LRS
    self:SetPackedBool("RS",self.ALS_ARS.F6 > 0)

    self:SetPackedBool("SOSDL",self.Panel.SOSD>0)
    self.SOSD = self.Panel.SOSD>0

    -- Feed packed floats
    self:SetNW2Int("WrenchMode",self.KVWrenchMode)
    self:SetPackedRatio("PVK",self.PVK.Value/2)
    self:SetPackedRatio("M8",self.Panel.M8)
    self:SetPackedRatio("CranePosition", self.Pneumatic.RealDriverValvePosition)
    self:SetPackedRatio("ControllerPosition", (self.KV.ControllerPosition+3)/7)
    self:SetNW2Int("ReverserPosition", (self.KV.ReverserPosition+1))
    self:SetNW2Int("KRUPosition", self.KRU.Position)
    if self.Pneumatic.ValveType == 1 then
        self:SetPackedRatio("BLPressure", self.Pneumatic.ReservoirPressure/16.0)
    else
        self:SetPackedRatio("BLPressure", self.Pneumatic.BrakeLinePressure/16.0)
    end
    self:SetPackedRatio("TLPressure", self.Pneumatic.TrainLinePressure/16.0)
    self:SetPackedRatio("BCPressure", self.Pneumatic.BrakeCylinderPressure/6.0)
    self:SetPackedRatio("EnginesVoltage", self.Electric.Aux750V/1000.0)
    self:SetPackedRatio("EnginesCurrent", 0.5 + 0.5*(self.Electric.I24/500.0))
    self:SetPackedRatio("BatteryVoltage",self.Panel["V1"]*self.Battery.Voltage/150.0)
    self:SetPackedBool("Compressor",self.Pneumatic.Compressor > 0)
    self:SetPackedBool("Buzzer",self.Panel.Ring > 0)
    self:SetPackedBool("RK",self.RheostatController.Velocity ~= 0.0)

    self:SetPackedBool("BPSN",self.PowerSupply.X2_2 > 0)

    self:SetPackedBool("RearDoor",self.RearDoor)
    self:SetPackedBool("FrontDoor",self.FrontDoor)
    self:SetPackedBool("PassengerDoor",self.PassengerDoor)
    self:SetPackedBool("CabinDoor",self.CabinDoor)
    self:SetPackedBool("OtsekDoor1",self.OtsekDoor1)
    self:SetPackedBool("OtsekDoor2",self.OtsekDoor2)
    self:SetPackedRatio("Speed", self.Speed/100)
    self:SetNW2Int("ALSSpeed", self.ALS_ARS.Speed)

    --self:SetPackedBool("buzz",self:ReadTrainWire(47) ~= -1 and self.PowerSupply.XT3_1 > 0)
    --self:SetPackedBool("buzz_cab",self.R_G.Value == 1.0 and self.PowerSupply.XT3_1 > 0)
    self:SetPackedBool("AnnBuzz",self.Panel.AnnouncerBuzz > 0)
    self:SetPackedBool("AnnPlay",self.Panel.AnnouncerPlaying > 0)
    self:SetPackedBool("AnnCab",self.ASNP_VV.CabinSpeakerPower > 0)

    -- Exchange some parameters between engines, pneumatic system, and real world
    self.Engines:TriggerInput("Speed",self.Speed)
    if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and not self.IgnoreEngine then
        --[[
        if not self.AccelTimer and self:ReadTrainWire(1) > 0 then
            self.AccelTimer = CurTime()
            self.SpeedState = 0
        end
        if self.AccelTimer and self:ReadTrainWire(1) == 0 then
            self.AccelTimer = nil
        end
        if self.AccelTimer and self.Speed >= 30 and self.SpeedState == 0 then print("30:8",CurTime()-self.AccelTimer) self.SpeedState = 1 end
        if self.AccelTimer and self.Speed >= 60 and self.SpeedState == 1 then print("60:20",CurTime()-self.AccelTimer) self.SpeedState = 2 end
        if self.AccelTimer and self.Speed >= 80 and self.SpeedState == 2 then print("80:36",CurTime()-self.AccelTimer) self.SpeedState = 3 end


        if not self.BrakeTimer and self:ReadTrainWire(6) > 0 then
            self.BrakeTimer = CurTime()
            self.SpeedState = 0
            print("Brake start",self.Speed)--CurTime()-self.BrakeTimer)
        end
        if self.BrakeTimer and self:ReadTrainWire(6) == 0 then
            self.BrakeTimer = nil
        end
        if self.BrakeTimer and self.Speed <= 60 and self.SpeedState == 0 then print("60:4.8",CurTime()-self.BrakeTimer) self.SpeedState = 1 end
        if self.BrakeTimer and self.Speed <= 10 and self.SpeedState == 1 then print("10:15.55",CurTime()-self.BrakeTimer) self.SpeedState = 2 end
        --]]
        --if self:EntIndex() == 0778 then print(self.RheostatController.Velocity,self.RheostatController.RKP,self.RheostatController.Position) end
        --if self:EntIndex() == 1419 then RunConsoleCommand("say",self.Electric.I13,self.RUT.Value,self.RheostatController.Position) end
        local A = 2*self.Engines.BogeyMoment
        self.FrontBogey.MotorForce = 22500+5500*(A < 0 and 1 or 0)
        self.FrontBogey.Reversed = (self.Reverser.NZ > 0.5)
        self.RearBogey.MotorForce  = 22500+5500*(A < 0 and 1 or 0)
        self.RearBogey.Reversed = (self.Reverser.VP > 0.5)
        -- These corrections are required to beat source engine friction at very low values of motor power
        local A = 2*self.Engines.BogeyMoment
        --[[ if self.Speed < 15 then
            local pow = 1-0.7*(15.0-self.Speed)/15.0
            A = A < 0 and -math.abs(A)^pow or A^pow
        end--]]
        local P = math.max(0,0.04449 + 1.06879*math.abs(A) - 0.465729*A^2)
        if math.abs(A) > 0.4 then P = math.abs(A) end
        if math.abs(A) < 0.05 then P = 0 end
        if self.Speed < 10 then P = P*(1.0 + 0.5*(10.0-self.Speed)/10.0) end
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
        self.RearBogey.PneumaticBrakeForce = 50000.0-2000
        self.RearBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.RearBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
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

    if button == "KVUp" then self.KV:TriggerInput("ControllerUp",1.0) end
    if button == "KVDown" then self.KV:TriggerInput("ControllerDown",1.0) end
    if button == "KV_Unlock" then self.KV:TriggerInput("ControllerUnlock",1.0) end
    if (self.KVWrenchMode == 2) and (button == "KVReverserUp") then self.KRU:TriggerInput("Up",1) end
    if (self.KVWrenchMode == 2) and (button == "KVReverserDown") then self.KRU:TriggerInput("Down",1) end
    if (self.KVWrenchMode == 2) and (button == "KVSetX1") then self.KRU:TriggerInput("SetX1",1) end
    if (self.KVWrenchMode == 2) and (button == "KVSetX1B") then self.KRU:TriggerInput("SetX2",1) end
    if (self.KVWrenchMode == 2) and (button == "KVSet0") then self.KRU:TriggerInput("Set0",1) end

    if button == "KVSetT1B" then
        if self.KV.ControllerPosition == -1 then
            self.KV:TriggerInput("ControllerSet",-2)
        else
            self.KV:TriggerInput("ControllerSet",-1)
        end
    end
    if button == "KVSetX1B" then
        if self.KV.ControllerPosition == 1 then
            self.KV:TriggerInput("ControllerSet",2)
        else
            self.KV:TriggerInput("ControllerSet",1)
        end
    end
    if button == "KVSetT1AB" then
        if self.KV.ControllerPosition == -2 then
            self.KV:TriggerInput("ControllerSet",-1)
        else
            self.KV:TriggerInput("ControllerSet",-2)
        end
    end
    if button == "KVWrenchKV" then
        if self.KVWrenchMode == 0  then
            self:PlayOnce("revers_in","cabin",0.7)
            self.KVWrenchMode = 1
            self.KV:TriggerInput("Enabled",1)
        end
    end
    if button == "KVWrenchNone" then
        if self.KVWrenchMode ~= 0 and self.KV.ReverserPosition == 0 and self.KRU.Position == 0 then
            if self.KVWrenchMode == 2 then
                self:PlayOnce("kru_out","cabin",0.7)
            else
                self:PlayOnce("revers_out","cabin",0.7)
            end
            self.KVWrenchMode = 0
            self.KV:TriggerInput("Enabled",0)
            self.KRU:TriggerInput("Enabled",0)
        end
    end
    if button == "KVWrenchKRU" then
        if self.KVWrenchMode == 0 then
            self:PlayOnce("kru_in","cabin",0.7)
            self.KVWrenchMode = 2
            self.KRU:TriggerInput("Enabled",1)
        end
    end
    --if button == "KVT2Set" then self.KVT:TriggerInput("Close",1) end
    if button == "KDL" and self.VUD1.Value < 1 then self.KDL:TriggerInput("Close",1) end
    if button == "KDP" and self.VUD1.Value < 1 then self.KDP:TriggerInput("Close",1) end
    if button == "VDL" and self.VUD1.Value < 1 then self.VDL:TriggerInput("Close",1) end
    if button == "EmergencyBrake" then
        self.KV:TriggerInput("ControllerSet",-3)
        self.Pneumatic:TriggerInput("BrakeSet",7)
        return
    end

    if (button == "VDL") or (button == "KDL") then
        self.DoorSelect:TriggerInput("Open",1)
        self.KDLK:TriggerInput("Open",1)
    end
    if (button == "KDP") then
        self.DoorSelect:TriggerInput("Close",1)
        self.KDPK:TriggerInput("Open",1)
    end
    if (button == "VUD1Set") or (button == "VUD1Toggle") or
       (button == "VUD2Set") or (button == "VUD2Toggle") then
        self.VDL:TriggerInput("Open",1)
        self.KDL:TriggerInput("Open",1)
        self.KDP:TriggerInput("Open",1)
    end
    --print(button)
    -- Special sounds
    if button == "DriverValveDisconnect" then
        if self.Pneumatic.ValveType == 1 then
            if self.DriverValveBLDisconnect.Value == 0 or self.DriverValveTLDisconnect.Value == 0 then
                self.DriverValveBLDisconnect:TriggerInput("Set",1)
                self.DriverValveTLDisconnect:TriggerInput("Set",1)
            else
                self.DriverValveBLDisconnect:TriggerInput("Set",0)
                self.DriverValveTLDisconnect:TriggerInput("Set",0)
            end
        else
            if self.DriverValveDisconnect.Value == 1.0 then
                self.DriverValveDisconnect:TriggerInput("Set",0)
            else
                self.DriverValveDisconnect:TriggerInput("Set",1)
            end
        end
        return
    end
end

function ENT:OnButtonRelease(button)
    if string.find(button,"PneumaticBrakeSet") then
        if button == "PneumaticBrakeSet1" and (self.Pneumatic.DriverValvePosition == 1) then
            self.Pneumatic:TriggerInput("BrakeSet",2)
        end
        return
    end
    if button == "KDL" then self.KDL:TriggerInput("Open",1) end
    if button == "KDP" then self.KDP:TriggerInput("Open",1) end
    if button == "VDL" then self.VDL:TriggerInput("Open",1) end
    if button == "KV_Unlock" then
        self.KV:TriggerInput("ControllerUnlock",0.0)
    end

    if button == "KVSetT1AB" then
        if self.KV.ControllerPosition > -2 then
            self.KV:TriggerInput("ControllerSet",-2)
        end
    end
    if button == "KVSetX1B" then
        if self.KV.ControllerPosition > 1 then
            self.KV:TriggerInput("ControllerSet",1)
        end
    end
    if button == "KVSetT1B" then
        if self.KV.ControllerPosition < -1 then
            self.KV:TriggerInput("ControllerSet",-1)
        end
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

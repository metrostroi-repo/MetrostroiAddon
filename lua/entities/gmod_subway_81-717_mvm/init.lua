AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner

--"DURASelectMain","DURASelectAlternate","DURAToggleChannel","DURAPowerToggle",
ENT.SyncTable = {
    "CustomC","Custom1","Custom2","Custom3","CustomD",
    "CustomE","CustomF","CustomG","R_UNch","R_ZS","R_G","R_Radio","R_Program1","R_Program2","R_Program1H","R_Program2H","KVT","KVTR",
    "VZ1","VUD1","KDL","KDLR","KDLK","KDP","KDLRK","DoorSelect",
    "KRZD","R_VPR","VozvratRP","AVU","KVP","ConverterProtection","RZP",--"SP","GreenRP",
    "KSN","ARS","ARSR","ALS","OtklAVU","OtklBV","OtklBVK","OVT","L_1","L_2","L_3","VP","DIPoff",
    "VMK","BPSNon","RezMK","ARS13","L_4","VUS","VAH","VAD","KRP","VKST",
    "KAH","KAHK","KDPK",
    "A53","A56","A54","A17","A44","A39","A70","A14","A74","A26","AR63","AS1","A13","A21","A31","A32","A16","A12","A24","A49","A27","A72","A50","A29","A46","A47","A71","A7","A9","A84","A8","A52","A19","A48","A10","A22","A30","A1","A2","A3","A4","A5","A6","A18","A73","A20","A25","A11","A37","A45","A38","A51","A65","A66","A42","A43","A41","A40","A75","A76","A60","A58","A57","A59","A28",
    "AV2","AV3","AV4","AV5","AV6","AV1",
    "AIS","A15","A81","A68","A80",
    "RC1","VB","BPS","UOS", "PB", "UAVA","UAVAC",
    "DriverValveBLDisconnect","DriverValveTLDisconnect","DriverValveDisconnect","ParkingBrake","EPK","EmergencyBrakeValve",
    "VUD2","VDL","Wiper", "GV",
    "R_ASNPMenu","R_ASNPUp","R_ASNPDown","R_ASNPOn"
    , "ALSFreq","Ring","VBD",
    "V11","V12","V13","UPPS_On","SAB1"
}
ENT.SyncFunctions = {
    ""
}
function ENT:Initialize()
    self.Plombs = {
        VAH = true,
        VP = true,
        OtklAVU = true,
        OVT = true,
        --KAH = {true,"KAHK"},
        KAH = {true},
        OtklBV = {true},
        RC1 = true,
        UOS = true,
        VBD = true,
        UAVA = true,
        UPPS_On = true,
        Init = true,
    }
    -- Set model and initialize
    self.MaskType = 10
    self.LampType = 1
    self:SetModel("models/metrostroi_train/81-717/81-717_mvm.mdl")
    self:SetRenderMode(RENDERMODE_TRANSALPHA)
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
        self.FrontCouple = self:CreateCouple(Vector( 419.5,0,-62),Angle(0,0,0),true,"717")
        self.RearCouple  = self:CreateCouple(Vector(-419.5-6.545,0,-62),Angle(0,180,0),false,"717")
    else
        self.FrontBogey = self:CreateBogey(Vector( 317-11,0,-80),Angle(0,180,0),true,"717")
        self.RearBogey  = self:CreateBogey(Vector(-317+0,0,-80),Angle(0,0,0),false,"717")
        self.RearCouple  = self:CreateCouple(Vector(-421,0,-66),Angle(0,180,0),false,"717")
        self.FrontCouple = self:CreateCouple(Vector( 410-3,0,-66),Angle(0,0,0),true,"717")
    end
    local pneumoPow = 0.8+(math.random()^1.55)*0.4
    self.FrontBogey.PneumaticPow = pneumoPow
    self.RearBogey.PneumaticPow = pneumoPow
    self.FrontCouple.EKKDisconnected = true

    self.LightSensor = self:AddLightSensor(Vector(414-7.5,-130,-100),Angle(0,90,0))
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

        [KEY_EQUAL] = {"R_Program1Set",helper="R_Program1HSet"},
        [KEY_MINUS] = {"R_Program2Set",helper="R_Program2HSet"},

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
        [KEY_PAD_MULTIPLY] = "KAH",

        [KEY_SPACE] = "PBSet",
        [KEY_BACKSPACE] = {"EmergencyBrake",helper="EmergencyBrakeValveToggle"},

        [KEY_PAD_ENTER] = "KVWrenchKV",
        [KEY_PAD_0] = "DriverValveDisconnect",
        [KEY_PAD_DECIMAL] = "EPKToggle",
        [KEY_LSHIFT] = {
            def="KV_Unlock",
            [KEY_SPACE] = "KVT",

            [KEY_2] = "RingSet",
            [KEY_4] = "KVSet0Fast",
            [KEY_L] = "DriverValveDisconnect",

            [KEY_7] = "KVWrenchNone",
            [KEY_8] = "KVWrenchKRU",
            [KEY_9] = "KVWrenchKV9",
            [KEY_0] = "KVWrenchKV",
            [KEY_6] = "KVSetT1A",
        },
        [KEY_LALT] = {
            [KEY_V] = "VUD1Toggle",
            [KEY_L] = "EPKToggle",
            [KEY_RIGHT] = "R_ASNPMenuSet",
            [KEY_UP] = "R_ASNPUpSet",
            [KEY_DOWN] = "R_ASNPDownSet",
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
        {
            ID = "AutostopValveToggle",
            Pos = Vector(377, -66, -50), Radius = 20,
        },
    }

    local vX = Angle(0,-90-0.2,56.3):Forward() -- For ARS panel
    local vY = Angle(0,-90-0.2,56.3):Right()
    -- Cross connections in train wires
    self.TrainWireInverts = {
        [28] = true,
        [34] = true,
    }
    self.TrainWireCrossConnections = {
        [5] = 4, -- Reverser F<->B
        [31] = 32, -- Doors L<->R
    }

    self.RearDoor = false
    self.CabinDoor = false
    self.PassengerDoor = false
    self.OtsekDoor1 = false
    self.OtsekDoor2 = false

    self.Lamps = {
        broken = {},
    }
    local rand = math.random() > 0.8 and 1 or math.random(0.95,0.99)
    for i = 1,25 do
        if math.random() > rand then self.Lamps.broken[i] = math.random() > 0.5 end
    end

    self:TrainSpawnerUpdate()
    self:OnButtonPress("KVWrenchNone")
end
function ENT:TriggerLightSensor(coil,plate)
    if plate.PlateType == METROSTROI_UPPSSENSOR then
        self.UPPS:TriggerSensor(coil,plate)
    end
end

function ENT:NonSupportTrigger()
    self.RC1:TriggerInput("Set",0)
    self.UOS:TriggerInput("Set",1)
    self.KAH:TriggerInput("Set",1)
    self.KAH:TriggerInput("Block",1)
    self.KAHK:TriggerInput("Set",0)
    self.VAH:TriggerInput("Set",1)
    self.OVT:TriggerInput("Set",1)
    self.EPK:TriggerInput("Set",0)
    self.ARS:TriggerInput("Set",0)
    self.ALS:TriggerInput("Set",0)
    self.Plombs.RC1 = nil
    self.Plombs.UOS = nil
    self.Plombs.KAH = nil
    self.Plombs.VAH = nil
    self.Plombs.OVT = nil
end

function ENT:UpdateLampsColors()
    local lCol,lCount = Vector(),0
    local rand = math.random() > 0.8 and 1 or math.random(0.95,0.99)
    if self.LampType == 1 then
        local r,g,col = 15,15
        local typ = math.Round(math.random())
        local rnd =  0.5+math.random()*0.5
        for i = 1,12 do
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

                local tcol = (lCol/lCount)/255
                --self.Lights[id][4] = Vector(tcol.r,tcol.g^3,tcol.b^3)*255
                self:SetNW2Vector("lampD"..id,Vector(tcol.r,tcol.g^3,tcol.b^3)*255)
                lCol = Vector()
                lCount = 0
            end
            self:SetNW2Vector("lamp"..i,col)
            self.Lamps.broken[i] = math.random() > rand and math.random() > 0.7
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

                local tcol = (lCol/lCount)/255
                    --self.Lights[id][4] = Vector(tcol.r,tcol.g^3,tcol.b^3)*255
                    self:SetNW2Vector("lampD"..id,Vector(tcol.r,tcol.g^3,tcol.b^3)*255)
                lCol = Vector() lCount = 0
            end
            self:SetNW2Vector("lamp"..i,col)
            self.Lamps.broken[i] = math.random() > rand and math.random() > 0.7
        end
    end
end
--[[
local function rnd(num,max)
    local ceil = math.abs(math.ceil(num%max-(max/2)))
    if ceil==0 then ceil=1 end
    return math.ceil(num%ceil/(max/2))
end--]]
function ENT:TrainSpawnerUpdate()
--[[
    self.Texture = self:GetNW2String("Texture")
    self.PassTexture = self:GetNW2String("PassTexture")
    self.CabTexture = self:GetNW2String("CabTexture")
    local texture = Metrostroi.Skins["train"][self.Texture]
    local passtexture = Metrostroi.Skins["pass"][self.PassTexture]
    local cabintexture = Metrostroi.Skins["cab"][self.CabTexture]

    for k in pairs(self:GetMaterials()) do
        self:SetSubMaterial(k-1,"")
    end
    for k,v in pairs(self:GetMaterials()) do
        if v == "models/metrostroi_train/81/int02" then
            if not Metrostroi.Skins["717_schemes"] or not Metrostroi.Skins["717_schemes"]["m"] then
                self:SetSubMaterial(k-1,Metrostroi.Skins["717_schemes"][""])
            else
                if not self.Adverts or self.Adverts ~= 4 then
                    self:SetSubMaterial(k-1,Metrostroi.Skins["717_schemes"]["m"].adv)
                else
                    self:SetSubMaterial(k-1,Metrostroi.Skins["717_schemes"]["m"].clean)
                end
            end
        elseif v == "models/metrostroi_train/81/tabl" then
            if not self.SignsList then
                self:PrepareSigns()
            end
            if self.SignsList[self.SignsIndex] then self:SetSubMaterial(k-1,self.SignsList[self.SignsIndex][1]) end
        end
        local tex = string.Explode("/",v)
        tex = tex[#tex]
        if cabintexture and cabintexture.textures[tex] then
            self:SetSubMaterial(k-1,cabintexture.textures[tex])
        end
        if passtexture and passtexture.textures[tex] then
            self:SetSubMaterial(k-1,passtexture.textures[tex])
        end
        if texture and texture.textures[tex] then
            self:SetSubMaterial(k-1,texture.textures[tex])
        end
    end--]]
    --self:SetNW2String("PassTexture","Def_717MSKBlue")
    --
    local num = self.WagonNumber
    self:SetNW2Bool("Custom",self.CustomSettings)
    math.randomseed(num+817171)
    if self.CustomSettings then
    --{"Type","Spawner.717.Type","List",{"Spawner.717.Type.717","Spawner.717.Type.7175"}},
    --{"Cran","Spawner.717.CranType","List",{"334","013"}},
    --{"BodyType","Spawner.717.BodyType","List",{"Spawner.717.Type.MVM","Spawner.717.Type.LVZ","Spawner.717.Type.SPB"}},
    --{"HandRail","Spawner.717.HandRail","List",{"Spawner.717.Common.Random","Spawner.717.Common.Old","Spawner.717.Common.New"}},
    --{"SeatType","Spawner.717.SeatType","List",{"Spawner.717.Common.Random","Spawner.717.Common.Old","Spawner.717.Common.New"}},
    --{"LampType","Spawner.717.LampType","List",{"Spawner.717.Common.Random","Spawner.717.Lamp.LPV02","Spawner.717.Lamp.LLV01"}},
    --{"ARSType","Spawner.717.ARS","List",{"Spawner.717.Common.Random","Spawner.717.ARS.1","Spawner.717.ARS.2","Spawner.717.ARS.3"--[[,"Spawner.717.ARS.4"]]}},
    ----{"MaskType","Spawner.717.MaskType","List",{"2-2","2-2-2","Spawner.717.MaskType.1","Spawner.717.MaskType.2","1-1","Spawner.717.MaskType.3"}},
    --{"BPSNType","Spawner.717.BPSNType","List",{"Spawner.717.Common.Random","Spawner.717.BPSNType.1","Spawner.717.BPSNType.2","Spawner.717.BPSNType.3","Spawner.717.BPSNType.4","Spawner.717.BPSNType.5","Spawner.717.BPSNType.6","Spawner.717.BPSNType.7","Spawner.717.BPSNType.8","Spawner.717.BPSNType.9","Spawner.717.BPSNType.10","Spawner.717.BPSNType.11","Spawner.717.BPSNType.12","Spawner.717.BPSNType.13"}},
    --{"RingType","Spawner.717.RingType","List",{"Spawner.717.Common.Random","Spawner.717.RingType.1","Spawner.717.RingType.2","Spawner.717.RingType.3","Spawner.717.RingType.4","Spawner.717.RingType.5","Spawner.717.RingType.6","Spawner.717.RingType.7","Spawner.717.RingType.8"}},

        local dot5 = self:GetNW2Int("Type")==2
        local typ = self:GetNW2Int("BodyType")
        if typ==2 then
            self:SetModel("models/metrostroi_train/81-717/81-717_lvz.mdl")
        else
            self:SetModel("models/metrostroi_train/81-717/81-717_mvm.mdl")
        end
        self:SetNW2Int("Crane",self:GetNW2Int("Cran"))

        local lampType = self:GetNW2Int("LampType")
        local ARSType = self:GetNW2Int("ARSType")
        local RingType = self:GetNW2Int("RingType")
        local BPSNType = self:GetNW2Int("BPSNType")
        local SeatType = self:GetNW2Int("SeatType")
        self:SetNW2Bool("HandRails",dot5)
        self:SetNW2Bool("Dot5",dot5)
        self:SetNW2Bool("LVZ",typ==2)
        self:SetNW2Int("LampType",lampType==1 and (math.random()>0.5 and 2 or 1) or lampType-1)

        self.NewBortlamps = typ~=2 or math.random()>0.5
        --local mask = typ[6]==true or  typ[6] and typ[6](num,tex)
        --self:SetNW2Bool("Mask",mask)
        if ARSType == 1 then
            ARSType = math.ceil(math.random()*4+0.5)
        else ARSType = ARSType-1 end
        self:SetNW2Int("ARSType",ARSType)
        self:SetNW2Int("KVType",math.ceil(math.random()*3+0.5))
        self:SetNW2Bool("NewBortlamps",self.NewBortlamps)
        self:SetNW2Int("BPSNType",BPSNType==1 and math.ceil(math.random()*12+0.5) or BPSNType-1)
        self:SetNW2Int("RingType",RingType==1 and math.ceil(math.random()*8+0.5) or RingType-1)
        if SeatType==1 then
            self:SetNW2Int("SeatType",math.random(1,2))
        else
            self:SetNW2Int("SeatType",SeatType-1)
        end
    else
        local typ = self.WagonNumberConf or {}
        local lvz = typ[1]
        self.Dot5 = typ[2]
        self.NewBortlamps = typ[4]
        if lvz then
            self:SetModel("models/metrostroi_train/81-717/81-717_lvz.mdl")
        else
            self:SetModel("models/metrostroi_train/81-717/81-717_mvm.mdl")
        end
        self:SetNW2Bool("Dot5",self.Dot5)
        self:SetNW2Bool("LVZ",lvz)
        self:SetNW2Int("SeatType",typ[3] and 2 or 1)
        self:SetNW2Bool("NewBortlamps",self.NewBortlamps)
        self:SetNW2Int("LampType",math.random()>0.5 and 2 or 1)

        local tex = typ[5] and typ[5][math.random(1,#typ[5])] or "Def_717MSKWhite"
        self:SetNW2String("PassTexture",tex)
        local mask = typ[6]==true or  typ[6] and typ[6](num,tex)
        self:SetNW2Int("MaskType",mask and 3 or 1)
        self:SetNW2String("CabTexture",typ[7] and ((lvz and math.random()>0.2) and "Def_ClassicY" or "Def_ClassicG") or ((lvz and math.random()>0.2) and "Def_HammeriteY" or "Def_HammeriteG"))
        local ARSchance = math.random()
        self:SetNW2Int("ARSType",(not mask and not self.Dot5 and not lvz or ARSchance>0.8) and (ARSchance>0.93 and 5 or 4) or ARSchance>0.54 and (ARSchance>0.75 and 3 or 2) or 1)
        local KVChance = math.random()
        local RingChance = math.random()
        if self.Dot5 then
            self:SetNW2Int("KVType",math.Clamp(math.floor(KVChance*4)+1,1,4))
            if RingChance>0.7 then
                self:SetNW2Int("RingType",RingChance>0.8 and 9 or RingChance>0.9 and 6 or 5)
            elseif RingChance>0.45 then
                self:SetNW2Int("RingType",RingChance>0.67 and 8 or 7)
            else
                self:SetNW2Int("RingType",math.Clamp(math.floor(KVChance/0.45*4)+1,1,4))
            end
        else
            if RingChance>0.6 then
                self:SetNW2Int("RingType",RingChance>0.8 and 9 or RingChance>0.9 and 6 or 5)
            else
                self:SetNW2Int("RingType",math.Clamp(math.floor(KVChance/0.9*4)+1,1,4))
            end
            self:SetNW2Int("KVType",math.Clamp(math.floor(KVChance*3)+1,1,3))
        end
        local oldType = not self.Dot5 and not mask and not lvz
        self:SetNW2String("Texture",oldType and "Def_717MSKClassic3" or "Def_717MSKClassic1")
        self:SetNW2Int("BPSNType",oldType and (math.random()>0.7 and 2 or 1) or 2+math.Clamp(math.floor(math.random()*11)+1,1,11))

        self:SetNW2Int("Crane",not oldType and 2 or 1)
        if self.Dot5 then
            self.FrontCouple.CoupleType = "717"
        else
            self.FrontCouple.CoupleType = "702"
        end
        self.RearCouple.CoupleType = self.FrontCouple.CoupleType
        self.FrontCouple:SetParameters()
        self.RearCouple:SetParameters()

        --self.ARSType = self:GetNW2Int("ARSType",1)
        self.MaskType = self:GetNW2Int("MaskType",1)
        self.SeatType = self:GetNW2Int("SeatType",1)
        self.HandRail = self:GetNW2Int("HandRail",1)
        self.BortLampType = self:GetNW2Int("BortLampType",1)


    end
    --[[
    local mask = self:GetNW2Int("MaskType",3)
    if mask == 3 then
        self.Lights[30][2] = Vector(465,-48, -23.5)
        self.Lights[31][2] = Vector(465,48 , -23.5)
        self.Lights[32][2] = Vector(465,0  , -23.5)
    else
        self.Lights[30][2] = Vector(465,-45, -23.5)
        self.Lights[31][2] = Vector(465,45 , -23.5)
        self.Lights[32][2] = Vector(465,0  , 52)
    end]]
    self.Announcer.AnnouncerType = self:GetNW2Int("Announcer",1)
    self.LampType = self:GetNW2Int("LampType",1)
    self.Pneumatic.ValveType = self:GetNW2Int("Crane",1)
    self:SetPackedBool("Crane013",self.Pneumatic.ValveType == 2)
    self:SetNW2Float("Crane013Loud",(self.Pneumatic.ValveType == 2 and math.random()>0.9) and 1.1+math.random()*0.3 or 0)
    self:UpdateLampsColors()
    self:UpdateTextures()
    --[[ local scheme = Metrostroi.Skins["722_schemes"] and Metrostroi.Skins["722_schemes"][self.Scheme]
    if IsValid(sarmat) and IsValid(sarmatr) and scheme then
        if self:GetNW2Bool("SarmatInvert") then
            sarmat:SetSubMaterial(0,scheme[2])
            sarmatr:SetSubMaterial(0,scheme[1])
        else
            sarmat:SetSubMaterial(0,scheme[1])
            sarmatr:SetSubMaterial(0,scheme[2])
        end
        self.PassSchemesDone = true
    end--]]
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
    end
    self:SetNW2String("RelaysConfig",str)

    local pneumoPow = 0.8+(math.random()^1.55)*0.4
    if IsValid(self.FrontBogey) then
        self.FrontBogey:SetNW2Int("SquealType",math.floor(math.random(4,7)))
        self.FrontBogey.PneumaticPow = pneumoPow
    end
    if IsValid(self.RearBogey) then
        self.RearBogey:SetNW2Int("SquealType",math.floor(math.random(4,7)))
        self.RearBogey.PneumaticPow = pneumoPow
    end
    self.Pneumatic.VDLoud = math.random()<0.06 and 0.9+math.random()*0.2
    if self.Pneumatic.VDLoud then self.Pneumatic.VDLoudID = math.random(1,5) end
    self:SetNW2Bool("SecondKV",math.random()>0.7)
    math.randomseed(os.time())
end

--------------------------------------------------------------------------------
function ENT:Think()
    self.RetVal = self.BaseClass.Think(self)

    local Panel = self.Panel
    local Pneumatic = self.Pneumatic
    local power = Panel.V1 > -1.5
    local brightness = math.min(1,Panel.Headlights1)*0.60 +
                        math.min(1,Panel.Headlights2)*0.40
    --local T = {}

    self:SetPackedBool("Headlights1",Panel.Headlights1 > 0)
    self:SetPackedBool("Headlights2",Panel.Headlights2 > 0)
    self:SetPackedBool("RedLights",Panel.RedLight2 > 0)
    self:SetPackedBool("CabLights",Panel.CabLights>0)
    self:SetPackedBool("EqLights",Panel.EqLights>0)

    self:SetPackedBool("PanelLights",Panel.PanelLights > 0.5)

    local lightsActive1 = Panel.EmergencyLights > 0
    local lightsActive2 = Panel.MainLights > 0.0
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
            self:SetPackedBool("lightsActive"..i,true)
        else
            self:SetPackedBool("lightsActive"..i,false)
        end
    end
	
    if self:ReadTrainWire(4)*self:ReadTrainWire(5)*self:ReadTrainWire(10) > 0 then
        self.A54:TriggerInput("Set",0)
    end

    -- Door button lights
    self:SetPackedBool("DoorsLeftL",Panel.DoorsLeft > 0.5)
    self:SetPackedBool("DoorsRightL",Panel.DoorsRight > 0.5)
    self:SetPackedBool("DoorsW",Panel.DoorsW > 0)
    self:SetPackedBool("GRP",Panel.GreenRP > 0)
    self:SetPackedBool("BrW",Panel.BrW > 0)
    self:SetPackedBool("VH1",self.BZOS.VH1 > 0)
    self:SetPackedBool("VH2",self.BZOS.VH2 > 0)

    -- Switch and button states
    self:SetPackedBool("GreenRP",Panel.GreenRP > 0.5)
    self:SetPackedBool("AVU",Panel.AVU > 0.5)
    self:SetPackedBool("LKVP",Panel.LKVP > 0)
    self:SetPackedBool("RZP",Panel.RZP > 0)
    self:SetPackedBool("KUP",Panel.KUP > 0.5)
    self:SetPackedBool("PN", Panel.BrT > 0.5)
    self:SetPackedBool("VPR",Panel.VPR > 0)

    -- Signal if doors are open or no to platform simulation
    self.LeftDoorsOpen =  (Pneumatic.LeftDoorState[1] > 0.5)  or (Pneumatic.LeftDoorState[2] > 0.5)  or (Pneumatic.LeftDoorState[3] > 0.5)  or (Pneumatic.LeftDoorState[4] > 0.5)
    self.RightDoorsOpen = (Pneumatic.RightDoorState[1] > 0.5) or (Pneumatic.RightDoorState[2] > 0.5) or (Pneumatic.RightDoorState[3] > 0.5) or (Pneumatic.RightDoorState[4] > 0.5)

    -- DIP/power
    self:SetPackedBool("LUDS",Panel.LUDS > 0.5)

    -- Red RP
    local TW18 = 0
    if Panel.LSN > 0 then
        local wags = #self.WagonList
        for i,v in ipairs(self.WagonList) do
            TW18 = TW18+(v.Panel.TW18 or 0)/wags
        end
    end
    self:SetPackedBool("RP",TW18 > 0.5)
    self:SetPackedBool("SN",TW18 > 0)
    self:SetPackedRatio("RPR",math.Clamp(TW18^0.7,0,1))

    self:SetPackedBool("SD",Panel.SD > 0.5)

    self:SetPackedBool("AR04",Panel.AR04 > 0)
    self:SetPackedBool("AR0",Panel.AR0 > 0)
    self:SetPackedBool("AR40",Panel.AR40 > 0)
    self:SetPackedBool("AR60",Panel.AR60 > 0)
    self:SetPackedBool("AR70",Panel.AR70 > 0)
    self:SetPackedBool("AR80",Panel.AR80 > 0)
    --]]
    local drv = self:GetDriver()
    self:SetPackedBool("GLIB",power and IsValid(drv) and drv:SteamID() == "STEAM_0:1:31566374")
    self:SetPackedBool("LEKK",Panel.LEKK > 0)
    self:SetPackedBool("LN",Panel.LN > 0)
    self:SetPackedBool("ST",Panel.LST > 0)
    self:SetPackedBool("VD",Panel.LVD > 0)
    self:SetPackedBool("KVD",Panel.LKVD > 0)
    self:SetPackedBool("RS",Panel.RS > 0)
    self:SetPackedBool("OneFreq",Panel.OneFreq > 0)
    self:SetPackedBool("HRK",Panel.LhRK > 0)
    self:SetPackedBool("KVC",Panel.KVC > 0)
    self:SetPackedBool("KT",Panel.KT>0)
    self:SetPackedRatio("PVK",self.PVK.Value/2)
    self:SetPackedBool("L1",Panel.L1 > 0)
    self:SetPackedBool("M1_3",Panel.M1_3 > 0)
    self:SetPackedBool("M4_7",Panel.M4_7 > 0)
    self:SetPackedRatio("M8",Panel.M8)
    self:SetPackedBool("IST",Panel.IST > 0)
    self:SetPackedBool("ISTLamp",Panel.IST > 0 and CurTime() % 0.333 > 0.166)
    self:SetNW2Int("WrenchMode",self.KVWrenchMode)
    self:SetPackedBool("ReverserPresent",self.KVWrenchMode and self.KVWrenchMode>0)
    self:SetPackedRatio("CranePosition", Pneumatic.RealDriverValvePosition)
    self:SetPackedRatio("ControllerPosition", (self.KV.ControllerPosition+3)/7)
    self:SetNW2Int("ReverserPosition", (self.KV.ReverserPosition+1))
    self:SetNW2Int("KRUPosition", self.KRU.Position)

    if Pneumatic.ValveType == 1 then
        self:SetPackedRatio("BLPressure", Pneumatic.ReservoirPressure/16.0)
    else
        self:SetPackedRatio("BLPressure", Pneumatic.BrakeLinePressure/16.0)
    end
    self:SetPackedRatio("TLPressure", Pneumatic.TrainLinePressure/16.0)
    self:SetPackedRatio("BCPressure", Pneumatic.BrakeCylinderPressure/6.0)
    self:SetPackedRatio("EnginesVoltage", self.Electric.Aux750V/1000.0)
    self:SetPackedRatio("EnginesCurrent2",  0.5 + 0.5*(self.Electric.I13/500.0))
    self:SetPackedRatio("EnginesCurrent", 0.5 + 0.5*(self.Electric.I24/500.0))

----------------------------------*****************************--------------------------------
    --10th wire voltage readout imitation depending on the BPSNs and EKK state, not on the wagon battery switch state
    -- PC  power converter; CC  control circuits
    local hvcounter = 0
    local hvcar = nil
    local vdrop = 1.125*(#self.WagonList)
    for k,v in ipairs(self.WagonList) do
	if v.PowerSupply.X2_2 > 0 and v.A24.Value > 0 then
            hvcounter = hvcounter + 1
            hvcar = hvcar or v
            vdrop = vdrop - 1.125
        else
            vdrop = vdrop - ((v.A56.Value == 0 and 0.4 or (v.VB.Value == 0 and 0.4 or 0)) + (v.LK4.Value == 0 and 0.725 or 0))
        end
    end
    local PCV_o = hvcounter > 0 and math.Clamp(76+(hvcar.Electric.Aux750V - 600)*8/375, 76, 84) - vdrop or self.WagonList[1].Battery.Voltage
    --imitating converter overload protection only when control circuits are energized and at least one PC on the train is off; pretty useless btw (but fun)
    local pcloadratio = #self.WagonList/(hvcounter > 0 and hvcounter or 0.5)
    local _A = 25*(6 - 6/(5.01))                                            --assuming one PC on 6 cars can work for 25 secs while the cars' CCs are energized
    if pcloadratio > 1 and pcloadratio <= #self.WagonList and self.LK4.Value > 0 and self.PowerSupply.X2_2 > 0 and not self.pcrlxtimer then
        self.pcprotimer = self.pcprotimer or CurTime()
        --hyperbolic function of PC operating time depending on load coeff
        if CurTime() - self.pcprotimer > _A/(pcloadratio - 6/5.01) then
            self.pcrlxtimer = CurTime()
        end
    else
        if self.pcrlxtimer then
            if CurTime() - self.pcrlxtimer < 30 then 			      --30 seconds relaxation time before PC overload protecion can be reset
                self.RZP:TriggerInput("Close",1)
            else
                self.pcrlxtimer = nil
            end
        else
            self.pcprotimer = nil
        end
    end
    self.PowerSupply:TriggerInput("3x2",self.pcrlxtimer and 1 or 0)     --BPSN overheat protection in case of RZP button is being pressed constantly
----------------------------------*****************************--------------------------------

    self:SetPackedRatio("BatteryVoltage",Panel["V1"]*PCV_o/150.0)
    
    self:SetPackedBool("Compressor",Pneumatic.Compressor > 0)
    self:SetPackedBool("Buzzer",Panel.Ring >= 1)
    self:SetPackedBool("BuzzerBZOS",Panel.Ring>0 and Panel.Ring<1)
    self:SetPackedBool("RK",self.RheostatController.Velocity ~= 0.0)

    self:SetPackedBool("BPSN",self.PowerSupply.X2_2 > 0)

    self:SetPackedBool("RearDoor",self.RearDoor)
    self:SetPackedBool("PassengerDoor",self.PassengerDoor)
    self:SetPackedBool("CabinDoor",self.CabinDoor)
    self:SetPackedBool("OtsekDoor1",self.OtsekDoor1)
    self:SetPackedBool("OtsekDoor2",self.OtsekDoor2)

    self:SetPackedBool("AnnBuzz",Panel.AnnouncerBuzz > 0)
    self:SetPackedBool("AnnPlay",Panel.AnnouncerPlaying > 0)
    self:SetPackedBool("AnnCab",self.ASNP_VV.CabinSpeakerPower > 0)
    -- Exchange some parameters between engines, pneumatic system, and real world
    self.Engines:TriggerInput("Speed",self.Speed)
    self:SetPackedRatio("Speed", self.Speed/100 or 0.5 or 0.85-(((CurTime()%36/36)^0.8)*8.5)/10 or self.Speed/100)
    if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and not self.IgnoreEngine then
        local A = 2*self.Engines.BogeyMoment
        --self.FrontBogey.MotorForce = 27000+1000*(A < 0 and 1 or 0)
        --self.RearBogey.MotorForce  = 27000+1000*(A < 0 and 1 or 0)
        self.FrontBogey.MotorForce = 22500+5500*(A < 0 and 1 or 0)
        self.RearBogey.MotorForce  = 22500+5500*(A < 0 and 1 or 0)
        self.FrontBogey.Reversed = (self.Reverser.NZ > 0.5)
        self.RearBogey.Reversed = (self.Reverser.VP > 0.5)

        -- These corrections are required to beat source engine friction at very low values of motor power
        local P = math.max(0,0.04449 + 1.06879*math.abs(A) - 0.465729*A^2)
        if math.abs(A) > 0.4 then P = math.abs(A) end
        if math.abs(A) < 0.05 then P = 0 end
        if self.Speed < 10 then P = P*(1.0 + 0.5*(10.0-self.Speed)/10.0) end
        self.RearBogey.MotorPower  = P*0.5*((A > 0) and 1 or -1)
        self.FrontBogey.MotorPower = P*0.5*((A > 0) and 1 or -1)
        --self.RearBogey.MotorPower  = P*0.5
        --self.FrontBogey.MotorPower = P*0.5

        --self.Acc = (self.Acc or 0)*0.95 + self.Acceleration*0.05

        -- Apply brakes
        self.FrontBogey.PneumaticBrakeForce = 50000.0-2000
        self.FrontBogey.BrakeCylinderPressure = Pneumatic.BrakeCylinderPressure
        self.FrontBogey.ParkingBrakePressure = math.max(0,(2.6-Pneumatic.ParkingBrakePressure)/2.6)/2
        self.FrontBogey.BrakeCylinderPressure_dPdT = -Pneumatic.BrakeCylinderPressure_dPdT
        self.RearBogey.PneumaticBrakeForce = 50000.0-2000
        self.RearBogey.BrakeCylinderPressure = Pneumatic.BrakeCylinderPressure
        self.RearBogey.BrakeCylinderPressure_dPdT = -Pneumatic.BrakeCylinderPressure_dPdT
        self.RearBogey.ParkingBrakePressure = math.max(0,(2.6-Pneumatic.ParkingBrakePressure)/2.6)/2
    end

    self:GenerateJerks()

    return self.RetVal
end

function ENT:TriggerTurbostroiInput(sys,name,val)
    self.BaseClass.TriggerTurbostroiInput(self,sys,name,val)
end

function ENT:PhysicsCollide( colData )
end
--------------------------------------------------------------------------------
function ENT:OnButtonPress(button,ply)
    if string.find(button,"PneumaticBrakeSet") then
        self.Pneumatic:TriggerInput("BrakeSet",tonumber(button:sub(-1,-1)))
        return
    end
    if button == "IGLA23" then
        self.IGLA2:TriggerInput("Set",1)
        self.IGLA3:TriggerInput("Set",1)
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
    if (self.KVWrenchMode == 2) and (button == "KVSetX1B") then self.KRU:TriggerInput("SetX1",1) end
    if (self.KVWrenchMode == 2) and (button == "KVSetX2") then self.KRU:TriggerInput("SetX2",1) end
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

    if button == "KVWrenchKV" or button == "KVWrenchKV9" then
        if self.KVWrenchMode == 0  then
            self:PlayOnce("revers_in","cabin",0.7)
            self.KVWrenchMode = 1
            self.KV:TriggerInput("Enabled",1)
        else
            self:TriggerInput(button == "KVWrenchKV9" and "KVReverserDown" or "KVReverserUp",1)
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
    if button == "KAH" and not self.Plombs.KAH then
        self.KAHK:TriggerInput("Open",1)
        self.KAH:TriggerInput("Close",1)
    end
    if button == "KDL" and self.VUD1.Value < 1 then self.KDL:TriggerInput("Close",1) end
    if button == "KDP" and self.VUD1.Value < 1 then self.KDP:TriggerInput("Close",1) end
    if button == "VDL" and self.VUD1.Value < 1 then self.VDL:TriggerInput("Close",1) end
    if button == "EmergencyBrake" then
        self.KV:TriggerInput("ControllerSet",-3)
        self.Pneumatic:TriggerInput("BrakeSet",7)
        return
    end

    if button == "KVT" then
        self.KVT:TriggerInput("Set",1)
        self.KVTR:TriggerInput("Set",1)
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
    if button == "KAH" then
        self.KAH:TriggerInput("Open",1)
    end
    if button == "KDL" then self.KDL:TriggerInput("Open",1) end
    if button == "KDP" then self.KDP:TriggerInput("Open",1) end
    if button == "VDL" then self.VDL:TriggerInput("Open",1) end
    if button == "KV_Unlock" then
        self.KV:TriggerInput("ControllerUnlock",0.0)
    end

    if button == "IGLA23" then
        self.IGLA2:TriggerInput("Set",0)
        self.IGLA3:TriggerInput("Set",0)
    end

    if button == "KVT" then
        self.KVT:TriggerInput("Set",0)
        self.KVTR:TriggerInput("Set",0)
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

function ENT:OnTrainWireError(k)
end
function ENT:OnPlay(soundid,location,range,pitch)
    if soundid == "pkg" and self.LK1.Value > 0 and math.floor(self.PositionSwitch.Position+0.5) == 2 then
        return "lk2_off",location,range,pitch
    end
    return soundid,location,range,pitch
end

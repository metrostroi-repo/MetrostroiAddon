AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner

ENT.SyncTable = {
    "VB","GV","ParkingBrake",
    "SF4","SF27","SF46","SF12","SF13","SF45","SF16","SF44","SF43","SF14","SF15","SF25","SF72","SF56","SF29","SF26","SF42","SF18","SF20","SF17","SF19","SF21","SF22","SF34","SF35","SF23","SF24",
}

function ENT:Initialize()
    self.Plombs = {
        Init = true,
    }

    self:SetModel("models/metrostroi_train/81-718/81-718_int.mdl")
    self.BaseClass.Initialize(self)
    self:SetPos(self:GetPos() + Vector(0,0,140))

    -- Create seat entities
    self.DriverSeat = self:CreateSeat("driver",Vector(-415-16,0,-48+2.5+6),Angle(0,-90,0),"models/vehicles/prisoner_pod_inner.mdl")

    -- Hide seats
    self.DriverSeat:SetColor(Color(0,0,0,0))
    self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)

    -- Create bogeys
    if Metrostroi.BogeyOldMap then
        self.FrontBogey = self:CreateBogey(Vector( 317-5,0,-84),Angle(0,180,0),true,"717")
        self.RearBogey  = self:CreateBogey(Vector(-317+0,0,-84),Angle(0,0,0),false,"717")
        self.FrontCouple = self:CreateCouple(Vector( 414+6.545,0,-62),Angle(0,0,0),true,"717")
        self.RearCouple  = self:CreateCouple(Vector(-419.5-6.545,0,-62),Angle(0,180,0),false,"717")
    else
        self.FrontBogey = self:CreateBogey(Vector( 317-11,0,-80),Angle(0,180,0),true,"717")
        self.RearBogey  = self:CreateBogey(Vector(-317+0,0,-80),Angle(0,0,0),false,"717")
        self.FrontCouple = self:CreateCouple(Vector( 410-2,0,-66),Angle(0,0,0),true,"717")
        self.RearCouple  = self:CreateCouple(Vector(-423+2,0,-66),Angle(0,180,0),false,"717")
    end
    local pneumoPow = 1.0+(math.random()^0.4)*0.3
    self.FrontBogey.PneumaticPow = pneumoPow
    self.RearBogey.PneumaticPow = pneumoPow
    -- Initialize key mapping
    self.KeyMap = {
        [KEY_F] = "PneumaticBrakeUp",
        [KEY_R] = "PneumaticBrakeDown",
        [KEY_PAD_1] = "PneumaticBrakeSet1",
        [KEY_PAD_2] = "PneumaticBrakeSet2",
        [KEY_PAD_3] = "PneumaticBrakeSet3",
        [KEY_PAD_4] = "PneumaticBrakeSet4",
        [KEY_PAD_5] = "PneumaticBrakeSet5",
        [KEY_PAD_6] = "PneumaticBrakeSet6",
        [KEY_PAD_7] = "PneumaticBrakeSet7",
        [KEY_PAD_0] = "DriverValveDisconnect",

        [KEY_LSHIFT] = {
            [KEY_L] = "DriverValveDisconnectToggle",
        },

        [KEY_RSHIFT] = {
            [KEY_L] = "DriverValveDisconnectToggle",
        },
    }


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
            ID = "ParkingBrakeToggle",
            Pos = Vector(-469, 54.5, -53), Radius = 8,
        },
        {
            ID = "FrontDoor",
            Pos = Vector(451.5,35,4), Radius = 20,
        },
        {
            ID = "RearDoor",
            Pos = Vector(-464.8,-35,4), Radius = 20,
        },
        {
            ID = "GVToggle",
            Pos = Vector(162.50,62,-59), Radius = 10,
        },
        {
            ID = "VBToggle",
            Pos = Vector(-470 -15, 53), Radius = 20,
        },
        {
            ID = "AirDistributorDisconnectToggle",
            Pos = Vector(-177, -66, -50), Radius = 20,
        },
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

    -- KV wrench mode
    self.KVWrenchMode = 0

    self.RearDoor = false
    self.FrontDoor = false

    self.Lamps = {
        broken = {},
    }
    local rand = math.random() > 0.8 and 1 or math.random(0.95,0.99)
    for i = 1,30 do
        if math.random() > rand then self.Lamps.broken[i] = math.random() > 0.5 end
    end

    self.WrenchMode = 0

    self:TrainSpawnerUpdate()
end
function ENT:UpdateLampsColors()
    self.LampType = math.Round(math.random()^0.5)+1
    self:SetNW2Int("LampType",self.LampType)

    local lCol,lCount = Vector(),0
    local rnd1,rnd2,col = 0.7+math.random()*0.3,math.random()
    local typ = math.Round(math.random())
    local r,g = 15,15
    for i = 1,30 do
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

            local tcol = (lCol/lCount)/255
            --self.Lights[id][4] = Vector(tcol.r,tcol.g^3,tcol.b^3)*255
            self:SetNW2Vector("lampD"..id,Vector(tcol.r,tcol.g^3,tcol.b^3)*255)
            lCol = Vector() lCount = 0
        end
        self:SetNW2Vector("lamp"..i,col)
    end
end
function ENT:TrainSpawnerUpdate()
    self:UpdateLampsColors()
    self.Pneumatic.VDLoud = math.random()<0.06 and 0.9+math.random()*0.2
    if self.Pneumatic.VDLoud then self.Pneumatic.VDLoudID = math.random(1,5) end
end

--------------------------------------------------------------------------------
function ENT:Think()
    local Panel = self.Panel
    -- Initialize key mapping
    self.RetVal = self.BaseClass.Think(self)

    self:SetNW2Int("Wrench",self.WrenchMode)

    local lightsActive1 = self.Panel.EL3_6 > 0
    local lightsActive2 = self.Panel.EL7_30 > 0
    for i = 1,30 do
        if (lightsActive2 or (lightsActive1 and math.ceil((i+5)%8)==math.ceil(i/7)%2)) then
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

    self:SetPackedBool("AnnBuzz",Panel.AnnouncerBuzz > 0)
    self:SetPackedBool("AnnPlay",Panel.AnnouncerPlaying > 0)

    self:SetPackedBool("BBE",self.BBE.KM1 > 0)
    self:SetPackedBool("Compressor",self.KK.Value)
    if self.PTTI.State < 0 then
        self:SetPackedRatio("RNState", ((self.PTTI.RNState)-0.25)*math.Clamp((math.abs(self.Electric.Itotal/2)-30-self.Speed*2)/20,0,1))
        self:SetNW2Int("RNFreq", 13)
    else
        self:SetPackedRatio("RNState", (0.75-self.PTTI.RNState)*math.Clamp((math.abs(self.Electric.Itotal/2)-30-self.Speed*2)/20,0,1))
        self:SetNW2Int("RNFreq", ((self.PTTI.FreqState or 0)-1/3)/(2/3)*12)
    end
    local power = false--self.Panel.V1 > 0.5
    self:SetNW2Bool("ASNPPlay",power and self:ReadTrainWire(47) > 0)

    if self.CouchCap then
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

    self:SetPackedBool("DoorsW",self.Panel.HL13 > 0)
    self:SetPackedBool("GRP",self.Panel.HL25 > 0)
    self:SetPackedBool("BrW",self.Panel.HL46 > 0)


    self:SetPackedBool("RearDoor",self.RearDoor)
    self:SetPackedBool("FrontDoor",self.FrontDoor)
    self:SetPackedBool("CouchCap",self.CouchCap)

    self:SetPackedRatio("Speed", self.Speed/100)

    self:SetPackedBool("Vent1Work",self.BUVS.KV1>0)
    self:SetPackedBool("Vent2Work",self.BUVS.KV2>0)

    self:SetPackedRatio("BLPressure", self.Pneumatic.BrakeLinePressure/16.0)
    self:SetPackedRatio("TLPressure", self.Pneumatic.TrainLinePressure/16.0)
    self:SetPackedRatio("BCPressure", math.min(3.2,self.Pneumatic.BrakeCylinderPressure)/6.0)

    self:SetPackedRatio("BatteryVoltage",Panel["V1"]*self.Battery.Voltage/150.0)
    self:SetPackedRatio("BatteryCurrent",Panel["V1"]*math.Clamp((self.Battery.Voltage-75)*0.01,-0.01,1))

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
        self.FrontBogey.ParkingBrakePressure = math.max(0,(2.6-self.Pneumatic.ParkingBrakePressure)/2.6)/2
        self.FrontBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
        self.FrontBogey.DisableContacts = self.U5.Value>0
        self.RearBogey.PneumaticBrakeForce = 50000.0-2000
        self.RearBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.RearBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
        self.RearBogey.ParkingBrakePressure = math.max(0,(2.6-self.Pneumatic.ParkingBrakePressure)/2.6)/2
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
    if button == "FrontDoor" then self.FrontDoor = not self.FrontDoor end
    if button == "CouchCap" then self.CouchCap = not self.CouchCap end
end

function ENT:OnButtonRelease(button)
    if string.find(button,"PneumaticBrakeSet") then
        local pos = tonumber(button:sub(-1,-1))
        if button == "PneumaticBrakeSet1" then
            self.Pneumatic:TriggerInput("BrakeSet",2)
        end
        return
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

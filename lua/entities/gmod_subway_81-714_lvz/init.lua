AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner
ENT.SyncTable = {
    "A53","A56","A54","A24","A39","A23","A14","A13","A31","A32","A16","A12","A49","A15","A27","A50","A8","A52","A19","A10","A22","A30","A1","A2","A3","A4","A5","A6","A72","A38","A20","A25","A37","A55","A45","A66","A51","A65","A28",
    "A70","A81","A80","A18",
    "VB","GV",
    "DriverValveBLDisconnect","DriverValveTLDisconnect","ParkingBrake",
    "A84","BPSNon","ConverterProtection","L_1","Start","VozvratRP","EmergencyBrakeValve"
}

function ENT:Initialize()
    self.Plombs = {
        A84 = true,
        Init = true,
    }
    self.LampType = 1

    -- Set model and initialize
    self:SetModel("models/metrostroi_train/81-717/81-717_spb_int.mdl")
    self.BaseClass.Initialize(self)
    self:SetPos(self:GetPos() + Vector(0,0,140))

    -- Create seat entities
    self.DriverSeat = self:CreateSeat("driver",Vector(-415-16,0,-48+2.5+6),Angle(0,-90,0),"models/vehicles/prisoner_pod_inner.mdl")
    --self.InstructorsSeat = self:CreateSeat("instructor",Vector(430,47,-27+2.5),Angle(0,-90,0))

    -- Hide seats
    self.DriverSeat:SetColor(Color(0,0,0,0))
    self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
    --self.InstructorsSeat:SetColor(Color(0,0,0,0))
    --self.InstructorsSeat:SetRenderMode(RENDERMODE_TRANSALPHA)

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

    local pneumoPow = 1.1+(math.random()^0.4)*0.3
    self.FrontBogey.PneumaticPow = pneumoPow
    self.RearBogey.PneumaticPow = pneumoPow

    -- Initialize key mapping
    self.KeyMap = {
        [KEY_1] = "StartSet",
        [KEY_8] = "StartSet",
        [KEY_W] = "StartSet",
        [KEY_PAD_DIVIDE] = "StartSet",
        [KEY_0] = "RV+",
        [KEY_9] = "RV-",
        [KEY_PAD_PLUS] = "RV+",
        [KEY_PAD_MINUS] = "RV-",
        [KEY_G] = "VozvratRPSet",
        [KEY_L] = "HornEngage",

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

        [KEY_BACKSPACE] = "EmergencyBrakeValveToggle",

        [KEY_LSHIFT] = {
            [KEY_L] = "DriverValveDisconnect",
        },

        [KEY_RSHIFT] = {
            [KEY_L] = "DriverValveDisconnect",
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
            Pos = Vector(-469, -54.5, -53), Radius = 8,
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
            Pos = Vector(140.50,62,-64), Radius = 10,
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
    self.BattCurrent = 0
    self.eds_eq = 0

    -- Cross connections in train wires
    self.TrainWireInverts = {
        [28] = true,
        [34] = true,
    }
    self.TrainWireCrossConnections = {
        [5] = 4, -- Reverser F<->B
        [31] = 32, -- Doors L<->R
    }

    -- BPSN type
    self.BPSNType = self.BPSNType or 2+math.floor(Metrostroi.PeriodRandomNumber()*7+0.5)
    self:SetNW2Int("BPSNType",self.BPSNType)
    self.OldTexture = 0

    self.Lamps = {
        broken = {},
    }
    local rand = math.random() > 0.95 and 1 or math.random(0.95,0.99)
    for i = 1,23 do
        if math.random() > rand then self.Lamps.broken[i] = math.random() > 0.7 end
    end

    self:TrainSpawnerUpdate()
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

                local tcol = (lCol/lCount)/255
                self:SetNW2Vector("lampD"..id,Vector(tcol.r,tcol.g^3,tcol.b^3)*255)
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

                local tcol = (lCol/lCount)/255
                self.Lights[id][4] = Vector(tcol.r,tcol.g^3,tcol.b^3)*255
                self:SetNW2Vector("lampD"..id,Vector(tcol.r,tcol.g^3,tcol.b^3)*255)
                lCol = Vector() lCount = 0
            end
            self:SetNW2Vector("lamp"..i,col)
        end
    end
end

function ENT:TrainSpawnerUpdate()
    local typ = self:GetNW2Int("Type")
    local num = self.WagonNumber
    self.Battery:TriggerInput("CarType",1)
    self.Battery:TriggerInput("InitialVoltage",math.random(62,75))
    self.Battery:TriggerInput("Dischargeable",self:GetNW2Bool("BattCharge"))
    math.randomseed(num+817171)
    local kvr=false
    local passtex = "Def_717SPBWhite"
    local cabtex = "Def_PUAV"
    if typ == 1 then --PAKSDM
        self.Electric:TriggerInput("X2PS",0)
        self.Electric:TriggerInput("Type",self.Electric.LVZ_4)
        seats = math.random()>0.2 or (9000<=num and num<=9999)
        kvr = num>=8194 --or math.random()>0.5
        passtex = (9000<=num and num<=9999) and "Def_717SPBBlue" or kvr and (math.random()>0.5 and "Def_717SPBCyan") or "Def_717SPBWhite"

    elseif typ == 2 then --PUAV
        self.Electric:TriggerInput("X2PS",1)
        self.Electric:TriggerInput("Type",self.Electric.LVZ_2)
        seats = math.random()>0.2
        local pass = math.ceil(math.random()*3)
        kvr = num>=8189
        passtex = kvr and (pass==1 and "Def_717SPBWood3" or pass==2 and "Def_717SPBCyan") or "Def_717SPBWhite"

    elseif typ == 3 then --PAM
        self.Electric:TriggerInput("X2PS",1)
        self.Electric:TriggerInput("Type",self.Electric.LVZ_3)
        seats = math.random()>0.2
        kvr = num>=11060 --or math.random()>0.5
        passtex = kvr and (math.random()>0.5 and "Def_717SPBCyan") or "Def_717SPBWhite"

    end

    local bpsn = math.ceil(math.random()*4)
    self:SetNW2Int("BPSNType",math.random()>0.2 and 5 or bpsn)
    self:SetNW2Int("Crane",kvr and 1 or 0)
    self:SetNW2Bool("KVR",kvr)
    if not self.CustomSettings then
        self:SetNW2String("Texture","Def_717SPBDef")
        self:SetNW2String("PassTexture",passtex)
        self:SetNW2String("CabTexture",cabtex)
        self:SetNW2Bool("NewSeats",seats)
    else
        self:SetNW2Bool("NewSeats",self:GetNW2Int("SeatType") == 4 or self:GetNW2Int("SeatType") == 3 or self:GetNW2Int("SeatType") == 1 and math.random()>0.5)--(kvr or seats))
        self:SetNW2Bool("NewSeatsBlue",self:GetNW2Int("SeatType") == 4 or self:GetNW2Bool("NewSeats") and self:GetNW2Int("SeatType") == 1 and math.random()>0.5)
    end
    self.Pneumatic.ValveType = self:GetNW2Int("Crane",1)+1
    self.Announcer.AnnouncerType = self:GetNW2Int("Announcer",1)
    self:UpdateTextures()
    self:UpdateLampsColors()

    self:SetNW2Float("UPONoiseVolume",math.Rand(0,0.4))
    self:SetNW2Float("UPOVolume",math.Rand(0.9,1))
    self:SetNW2Float("UPOBuzzVolume",math.Rand(0.6,0.9))

    local pneumoPow = 1.3+(math.random()^1.2)*0.3
    if IsValid(self.FrontBogey) then
        self.FrontBogey:SetNW2Int("SquealType",math.floor(math.random()*7)+1)
        self.FrontBogey.PneumaticPow = pneumoPow
    end
    if IsValid(self.RearBogey) then
        self.RearBogey:SetNW2Int("SquealType",math.floor(math.random()*7)+1)
        self.RearBogey.PneumaticPow = pneumoPow
    end
    math.randomseed(os.time())
end

--------------------------------------------------------------------------------
function ENT:Think()
    local retVal = self.BaseClass.Think(self)
    local Panel = self.Panel
    local Pneumatic = self.Pneumatic

    local lightsActive1 = Panel.EmergencyLights > 0
    local lightsActive2 = Panel.MainLights > 0.0
    local LampCount  = self.LampType==2 and 27 or 13
    local Ip = self.LampType==2 and 7 or 3.6
    local Im = self.LampType==2 and 2 or 1
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

    self:SetPackedBool("DoorsW",Panel.DoorsW > 0)
    self:SetPackedBool("GRP",Panel.GreenRP > 0)
    self:SetPackedBool("BrW",Panel.BrW > 0)
    --[[if not self.KEKTimer or CurTime()-self.KEKTimer > 3 then
        self.KEKTimer = CurTime()
        local text = ""
        if Panel.DoorsW > 0 then text = text .." белая лампа дверей" end
        if Panel.BrW > 0 then text = text .." желтая лампа пневмотормоза" end
        if Panel.GreenRP > 0 then text = text .." зелёная лампа РП" end
        if text ~= "" then text = " горит"..text end
        if self.Speed <= 0.5 then text = text .." он стоит"
        elseif self.Electric.I13 > 10 then text = text.." он разгоняется"
        elseif self.Electric.I13 < -10 then text = text.." он тормозит ЭДТ"
        elseif self.Pneumatic.BrakeCylinderPressure > 0.2 then
            if self.Electric.I13 < -10 then
                text = text.." и пневматикой"
            else
                text = text.." он тормозит пневматикой"
            end
        else text = text .." он едет" end
        if self.Speed > 0.5 then text = text..Format(" со скоростью %02d км/ч и ускорением %.1f м/c",self.Speed, self.Acceleration) end

        if text ~= "" then RunConsoleCommand("say","ВНИМАНИЕ ВСЕМ!!! У "..self:CPPIGetOwner():GetName().." вагон "..self:GetWagonNumber()..text.."!!!") end
    end
    if Panel.GreenRP > 0 and (not self.KEKTimer or CurTime()-self.KEKTimer > 3) then
        self.KEKTimer = CurTime()
        RunConsoleCommand("say","ВНИМАНИЕ ВСЕМ!!! У "..self:CPPIGetOwner():GetName().." ВАГОН"..self:GetWagonNumber().." СЛУЧИЛОСЬ ЗНАМЕНАТЕЛЬНОЕ СОБЫТИЕ!!! У НЕГО ЗАГОРЕЛАСЬ ЗЕЛЁНАЯЛ ЛАМПА РП!!!")
    end]]
    self:SetPackedBool("M1_3",Panel.M1_3 > 0)
    self:SetPackedBool("M4_7",Panel.M4_7 > 0)

    -- Signal if doors are open or no to platform simulation
    self.LeftDoorsOpen =
        (Pneumatic.LeftDoorState[1] > 0.5) or
        (Pneumatic.LeftDoorState[2] > 0.5) or
        (Pneumatic.LeftDoorState[3] > 0.5) or
        (Pneumatic.LeftDoorState[4] > 0.5)
    self.RightDoorsOpen =
        (Pneumatic.RightDoorState[1] > 0.5) or
        (Pneumatic.RightDoorState[2] > 0.5) or
        (Pneumatic.RightDoorState[3] > 0.5) or
        (Pneumatic.RightDoorState[4] > 0.5)

    --self:SetPackedRatio("Crane", Pneumatic.RealDriverValvePosition)
    --self:SetPackedRatio("Controller", (self.KV.ControllerPosition+3)/7)
    if Pneumatic.ValveType == 1 then
        self:SetPackedRatio("BLPressure", Pneumatic.ReservoirPressure/16.0)
    else
        self:SetPackedRatio("BLPressure", Pneumatic.BrakeLinePressure/16.0)
    end
    self:SetPackedRatio("TLPressure", Pneumatic.TrainLinePressure/16.0)
    self:SetPackedRatio("BCPressure", Pneumatic.BrakeCylinderPressure/6.0)

    self:SetPackedRatio("BatteryVoltage",(self.eds_eq)/150.0)
    self:SetPackedRatio("BatteryCurrent",self.BattCurrent/1000)
    self:SetPackedRatio("EnginesCurrent", 0.5 + 0.5*(self.Electric.I24/500.0))

    self:SetPackedBool("Compressor",Pneumatic.Compressor > 0)
    self:SetPackedBool("RK",self.RheostatController.Velocity ~= 0.0)
    self:SetPackedBool("BPSN",self.PowerSupply.X2_2 > 0)
    self:SetPackedRatio("RV",self.RV.Value/2)
    self:SetPackedRatio("CranePosition", Pneumatic.RealDriverValvePosition)
    self:SetPackedBool("RZP",Panel.RZP > 0)


    self:SetPackedBool("FrontDoor",self.FrontDoor)
    self:SetPackedBool("RearDoor",self.RearDoor)
    self:SetPackedBool("CouchCap",self.CouchCap)

    self:SetPackedBool("AnnouncerBuzz",Panel.AnnouncerBuzz > 0)
    self:SetPackedBool("AnnPlay",Panel.AnnouncerPlaying > 0)

    self:SetPackedRatio("Speed", self.Speed/100)
    self.Engines:TriggerInput("Speed",self.Speed)
    if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and not self.IgnoreEngine then
        local A = 2*self.Engines.BogeyMoment
        --self.FrontBogey.MotorForce = 27000+1000*(A < 0 and 1 or 0)
        --self.RearBogey.MotorForce  = 27000+1000*(A < 0 and 1 or 0)
        self.FrontBogey.MotorForce = 22500+5500*(A < 0 and 1 or 0)
        self.RearBogey.MotorForce  = 22500+5500*(A < 0 and 1 or 0)
        self.FrontBogey.Reversed = (self.Reverser.NZ > 0.5)
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

        -- Apply brakes
        self.FrontBogey.PneumaticBrakeForce = 50000.0-2000
        self.FrontBogey.BrakeCylinderPressure = Pneumatic.BrakeCylinderPressure
        self.FrontBogey.ParkingBrakePressure = math.max(0,(2.6-Pneumatic.ParkingBrakePressure)/2.6)/2
        self.FrontBogey.BrakeCylinderPressure_dPdT = -Pneumatic.BrakeCylinderPressure_dPdT
        self.RearBogey.PneumaticBrakeForce = 50000.0-2000
        self.RearBogey.BrakeCylinderPressure = Pneumatic.BrakeCylinderPressure
        self.RearBogey.BrakeCylinderPressure_dPdT = -Pneumatic.BrakeCylinderPressure_dPdT
        self.RearBogey.ParkingBrakePressure = math.max(0,(2.6-Pneumatic.ParkingBrakePressure)/2.6)/2
        --self.RearBogey.ParkingBrake = self.ParkingBrake.Value > 0.5
    end

    self:GenerateJerks()

    -- Send networked variables
    --self:SendPackedData()
    return retVal
end


--------------------------------------------------------------------------------
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
    if button == "FrontDoor" then self.FrontDoor = not self.FrontDoor end
    if button == "RearDoor" then self.RearDoor = not self.RearDoor end
    if button == "CouchCap" then
        if self.CouchCap and self.Pneumatic.DriverValvePosition>2 then return end
        self.CouchCap = not self.CouchCap
    end
    if not self.CouchCap and (not button:find("VB") and not button:find("GV") and not button:find("Isolation") and not button:find("Parking") and not button:find("Air")) then return true end

    if button == "DriverValveDisconnect" then
        if self.DriverValveBLDisconnect.Value == 0 or self.DriverValveTLDisconnect.Value == 0 then
            self.DriverValveBLDisconnect:TriggerInput("Set",1)
            self.DriverValveTLDisconnect:TriggerInput("Set",1)
        else
            self.DriverValveBLDisconnect:TriggerInput("Set",0)
            self.DriverValveTLDisconnect:TriggerInput("Set",0)
        end
        return
    end
    if string.find(button,"PneumaticBrakeSet") then
        self.Pneumatic:TriggerInput("BrakeSet",tonumber(button:sub(-1,-1)))
        return
    end
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
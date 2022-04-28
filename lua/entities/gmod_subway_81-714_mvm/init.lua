AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner
ENT.SyncTable = {
    "A53","A56","A54","A24","A39","A23","A14","A13","A31","A32",
    "A16","A12","A49","A15","A27","A50","A8","A52","A19","A10",
    "A22","A30","A1","A2","A3","A4","A5","A6","A72","A38","A20",
    "A25","A37","A55","A45","A66","A51","A65","A28","A70","AV2",
    "AV3","AV4","AV5","A81","AV6","A80","A18",
    "VB","GV",
    "DriverValveBLDisconnect","DriverValveTLDisconnect","ParkingBrake",
    "A84","BPSNon","ConverterProtection","L_1","OtklBV","Start","VozvratRP","EmergencyBrakeValve"
}

function ENT:Initialize()
    self.Plombs = {
        A84 = true,
        Init = true,
    }
    self.LampType = 1

    -- Set model and initialize
    self:SetModel("models/metrostroi_train/81-717/81-717_mvm_int.mdl")
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
        self.FrontCouple = self:CreateCouple(Vector( 420.54,0,-62),Angle(0,0,0),true,"717")
        self.RearCouple  = self:CreateCouple(Vector(-426.04,0,-62),Angle(0,180,0),false,"717")
    else
        self.FrontBogey = self:CreateBogey(Vector( 317-11,0,-80),Angle(0,180,0),true,"717")
        self.RearBogey  = self:CreateBogey(Vector(-317+0,0,-80),Angle(0,0,0),false,"717")
        self.FrontCouple = self:CreateCouple(Vector( 408,0,-66),Angle(0,0,0),true,"717")
        self.RearCouple  = self:CreateCouple(Vector(-421,0,-66),Angle(0,180,0),false,"717")
    end

    local pneumoPow = 0.8+(math.random()^1.55)*0.4
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

    -- Cross connections in train wires
    self.TrainWireInverts = {
        [28] = true,
        [34] = true,
    }
    self.TrainWireCrossConnections = {
        [5] = 4, -- Reverser F<->B
        [31] = 32, -- Doors L<->R
    }

    self.Lamps = {
        broken = {},
    }
    local rand = math.random() > 0.8 and 1 or math.random(0.95,0.99)
    for i = 1,27 do
        if math.random() > rand then self.Lamps.broken[i] = math.random() > 0.5 end
    end

    self:SetNW2Int("Type",self:GetNW2Int("Type",2))
    self:TrainSpawnerUpdate()
end

function ENT:UpdateLampsColors()
    local lCol,lCount = Vector(),0
    local rand = math.random() > 0.8 and 1 or math.random(0.95,0.99)
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
        for i = 1,27 do
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

function ENT:TrainSpawnerUpdate()
    self:SetNW2Bool("Custom",self.CustomSettings)
    local num = self.WagonNumber
    math.randomseed(num+817171)
    if self.CustomSettings then
        local dot5 = self:GetNW2Int("Type")==2
        local typ = self:GetNW2Int("BodyType")
        self:SetNW2Int("Crane",self:GetNW2Int("Cran"))

        local lampType = self:GetNW2Int("LampType")
        local BPSNType = self:GetNW2Int("BPSNType")
        local SeatType = self:GetNW2Int("SeatType")
        self:SetNW2Bool("Dot5",dot5)
        self:SetNW2Int("LampType",lampType==1 and (math.random()>0.5 and 2 or 1) or lampType-1)
        self:SetNW2Int("BPSNType",BPSNType==1 and math.ceil(math.random()*12+0.5) or BPSNType-1)
        if SeatType==1 then
            self:SetNW2Bool("NewSeats",math.random()>0.5)
        else
            self:SetNW2Bool("NewSeats",SeatType==3)
        end
    else
        local num = self.WagonNumber
        local typ = self.WagonNumberConf or {}
        local lvz = typ[1]
        self.Dot5 = typ[2]
        self.NewBortlamps = typ[4]
        if lvz then
            --self:SetModel("models/metrostroi_train/81-717/81-717_lvz.mdl")
            self:SetModel("models/metrostroi_train/81-717/81-717_mvm_int.mdl")
        else
            self:SetModel("models/metrostroi_train/81-717/81-717_mvm_int.mdl")
        end
        self:SetNW2Bool("Dot5",self.Dot5)
        self:SetNW2Bool("LVZ",lvz)
        self:SetNW2Bool("NewSeats",typ[3])
        self:SetNW2Bool("NewBortlamps",self.NewBortlamps)

        self:SetNW2Int("LampType",math.random()>0.5 and 2 or 1)

        local tex = typ[5] and typ[5][math.random(1,#typ[5])] or "Def_717MSKWhite"
        self:SetNW2String("PassTexture",tex)
        local oldType = not self.Dot5 and not typ[3] and not lvz
        self:SetNW2Int("BPSNType",oldType and (math.random()>0.7 and 2 or 1) or 2+math.Clamp(math.floor(math.random()*11)+1,1,11))

        self:SetNW2Int("Crane",not self.Dot5 and 2 or 1)
        if self.Dot5 then
            self.FrontCouple.CoupleType = "717"
        else
            self.FrontCouple.CoupleType = "702"
        end
        self.RearCouple.CoupleType = self.FrontCouple.CoupleType
        self.FrontCouple:SetParameters()
        self.RearCouple:SetParameters()
        self:SetNW2String("Texture","Def_717MSKClassic1")
        --self.ARSType = self:GetNW2Int("ARSType",1)
    end
    self.LampType = self:GetNW2Int("LampType",1)
    self.Pneumatic.ValveType = self:GetNW2Int("Crane",1)
    self.Announcer.AnnouncerType = self:GetNW2Int("Announcer",1)

    self.WorkingLights = 6
    self:SetPackedBool("Crane013",self.Pneumatic.ValveType == 2)
    self:UpdateTextures()
    self:UpdateLampsColors()

    local pneumoPow = 0.8+(math.random()^1.55)*0.4
    if IsValid(self.FrontBogey) then
        self.FrontBogey.PneumaticPow = pneumoPow
    end
    if IsValid(self.RearBogey) then
        self.RearBogey.PneumaticPow = pneumoPow
    end
    self.Pneumatic.VDLoud = math.random()<0.06 and 0.9+math.random()*0.2
    if self.Pneumatic.VDLoud then self.Pneumatic.VDLoudID = math.random(1,5) end
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

----------------------------------*****************************--------------------------------
    --10th wire voltage readout imitation depending on the BPSNs and EKK state, not on the wagon battery switch state
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
    local _A = 25*(6 - 6/(5.01))                                          --assuming one PC on 6 cars can work for 25 secs while the cars' CCs are energized
    if pcloadratio > 1 and pcloadratio <= #self.WagonList and self.LK4.Value > 0 and self.PowerSupply.X2_2 > 0 and not self.pcrlxtimer then
        self.pcprotimer = self.pcprotimer or CurTime()
        --hyperbolic function of PC operating time depending on load coeff
        if CurTime() - self.pcprotimer > _A/(pcloadratio - 6/5.01) then
            self.pcrlxtimer = CurTime()
        end
    else
        if self.pcrlxtimer then
            if CurTime() - self.pcrlxtimer < 30 then                                  --30 seconds relaxation time before PC overload protecion can be reset
                self.RZP:TriggerInput("Close",1)
            else
                self.pcrlxtimer = nil
            end
        else
            self.pcprotimer = nil
        end
    end
    self.PowerSupply:TriggerInput("3x2",self.pcrlxtimer and 1 or 0) 	        --BPSN overheat protection in case of RZP button is being pressed constantly
----------------------------------*****************************--------------------------------
    
    self:SetPackedRatio("BatteryVoltage",Panel["V1"]*PCV_o/150.0)
    self:SetPackedRatio("BatteryCurrent",Panel["V1"]*math.Clamp((self.Battery.Voltage-75)*0.01,-0.01,1))
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

    self:SetPackedBool("AnnBuzz",Panel.AnnouncerBuzz > 0)
    self:SetPackedBool("AnnPlay",Panel.AnnouncerPlaying > 0)
    -- Exchange some parameters between engines, pneumatic system, and real world
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

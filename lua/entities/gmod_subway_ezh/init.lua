AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner

--"DURASelectMain","DURASelectAlternate","DURAToggleChannel","DURAPowerToggle",
ENT.SyncTable = {
    "VB","AV","VU","VU1","VU2","VU3","DoorSelect","KU4","KU5","KU9","KU15","KU14","KU1","VAH","VAD","KU16","KU2","KU3","KU3L","KU13","KU6","KU7","KU10","KU8","KU11","KRR","OtklAVU","ARS","ALS","KVT","KB","KAH","R_UNch","R_ZS","R_G","R_Radio","R_Program1","R_Program2","R_Program1H","R_Program2H","RC1","ALSFreq","PB","KU6K","RST","UOS",
    "AB1","AB2",
    "RRIEnable","RRIAmplifier",
    "DriverValveBLDisconnect","DriverValveTLDisconnect","EPK","EmergencyBrakeValve","UAVA","UAVAC",
    "GV",
    "R_ASNPOn","R_ASNPDown","R_ASNPUp","R_ASNPPath","R_ASNPMenu","IGLA1","IGLA2",
}
ENT.SyncFunctions = {
    ""
}

function ENT:Initialize()

    self.Plombs = {
        KAH = true,
        OtklAVU = true,
        RC1 = true,
        ALS = true,
        UOS = true,
        RST = true,
        Init = true,
        UAVA = true,
    }
    -- Set model and initialize
    self:SetModel("models/metrostroi_train/81-710/81-710.mdl")
    self.BaseClass.Initialize(self)
    self:SetPos(self:GetPos() + Vector(0,0,140))

    -- Create seat entities
    self.DriverSeat = self:CreateSeat("driver",Vector(425+3,-39.4,-31.5),Angle(0,0,0))
    self.InstructorsSeat = self:CreateSeat("instructor",Vector(430,40,-48),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")
    self.ExtraSeat1 = self:CreateSeat("instructor",Vector(443,0,-48+6+2.5),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")
    self.ExtraSeat2 = self:CreateSeat("instructor",Vector(420,-20,-48+6),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")
    -- Hide seats
    self.DriverSeat:SetColor(Color(0,0,0,0))
    self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.InstructorsSeat:SetColor(Color(0,0,0,0))
    self.InstructorsSeat:SetRenderMode(RENDERMODE_TRANSALPHA)

    self.ExtraSeat1:SetColor(Color(0,0,0,0))
    self.ExtraSeat1:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.ExtraSeat2:SetColor(Color(0,0,0,0))
    self.ExtraSeat2:SetRenderMode(RENDERMODE_TRANSALPHA)

    -- Create bogeys
    if Metrostroi.BogeyOldMap then
        self.FrontBogey = self:CreateBogey(Vector( 317-5,1.3,-89),Angle(0,180,0),true,"717")
        self.RearBogey  = self:CreateBogey(Vector(-317+0,1.3,-89),Angle(0,0,0),false,"717")
        self.FrontCouple = self:CreateCouple(Vector( 419.5+3.5,1.3,-75),Angle(0,0,0),true,"702")
        self.RearCouple  = self:CreateCouple(Vector(-421.5-3.5,1.3,-75),Angle(0,180,0),false,"702")
    else
        self.FrontBogey = self:CreateBogey(Vector( 317-11,1.0,-85),Angle(0,180,0),true,"717")
        self.RearBogey  = self:CreateBogey(Vector(-317+0,1.3,-85),Angle(0,0,0),false,"717")
        self.FrontCouple = self:CreateCouple(Vector( 421-4-3.6+4.5,1.0,-72),Angle(0,0,0),true,"702")
        self.RearCouple  = self:CreateCouple(Vector(-421+2+3.6-4.5,1.3,-72),Angle(0,180,0),false,"702")
    end
    self.FrontBogey:SetNWInt("MotorSoundType",0)
    self.RearBogey:SetNWInt("MotorSoundType",0)
    self.FrontBogey.PneumaticPow = 1.5
    self.RearBogey.PneumaticPow = 1.5
    self.FrontCouple.EKKDisconnected = true

    -- Initialize key mapping
    self.KeyMap = {
        [KEY_1] = "KVSetX1B",
        [KEY_2] = "KVSetX2",
        [KEY_3] = "KVSetX3",
        [KEY_4] = "KVSet0",
        [KEY_5] = "KVSetT1B",
        [KEY_6] = "KVSetT1AB",
        [KEY_7] = "KVSetT2",

        [KEY_EQUAL] = {"R_Program1Set",helper="R_Program1HSet"},
        [KEY_MINUS] = {"R_Program2Set",helper="R_Program2HSet"},

        [KEY_G] = "KU9Set",

        [KEY_0] = "KVReverserUp",
        [KEY_9] = "KVReverserDown",
        [KEY_PAD_PLUS] = "KVReverserUp",
        [KEY_PAD_MINUS] = "KVReverserDown",
        [KEY_W] = "KVUp",
        [KEY_S] = "KVDown",
        [KEY_F] = "PneumaticBrakeUp",
        [KEY_R] = "PneumaticBrakeDown",

        [KEY_A] = {"KU6",helper="KU13Set"},
        [KEY_D] = "KU7",
        [KEY_V] = {"KU2Toggle",helper="KU3Toggle"},
        [KEY_L] = "HornEngage",
        [KEY_PAD_1] = "PneumaticBrakeSet1",
        [KEY_PAD_2] = "PneumaticBrakeSet2",
        [KEY_PAD_3] = "PneumaticBrakeSet3",
        [KEY_PAD_4] = "PneumaticBrakeSet4",
        [KEY_PAD_5] = "PneumaticBrakeSet5",
        [KEY_PAD_DIVIDE] = "KU14Set",

        [KEY_SPACE] = "PBSet",
        [KEY_BACKSPACE] = {"EmergencyBrake",helper="EmergencyBrakeValveToggle"},

        [KEY_PAD_ENTER] = "KVWrenchKV",
        [KEY_PAD_0] = "DriverValveDisconnect",
        [KEY_PAD_DECIMAL] = "EPKToggle",
        [KEY_LSHIFT] = {
            [KEY_W] = "KVUp_Unlocked",
            [KEY_SPACE] = "KVTSet",

            [KEY_1] = "KU4Set",
            [KEY_2] = "KU5Set",
            [KEY_4] = "KVSet0Fast",
            [KEY_L] = "DriverValveDisconnect",

            [KEY_7] = "KVWrenchNone",
            [KEY_8] = "KVWrenchKRU",
            [KEY_9] = "KVWrenchKV9",
            [KEY_0] = "KVWrenchKV",
            [KEY_6] = "KVSetT1A",

            [KEY_PAD_ENTER] = "KVWrenchNone",
        },
        [KEY_LALT] = {
            [KEY_V] = "KU2Toggle",
            [KEY_L] = "EPKToggle",
            [KEY_UP] = "ANNUp",
            [KEY_DOWN] = "ANNDown",
            [KEY_LEFT] = "ANNLeft",
            [KEY_RIGHT] = "ANNRight",
        },
    }
    self.KeyMap[KEY_RALT] = self.KeyMap[KEY_LALT]
    self.KeyMap[KEY_RSHIFT] = self.KeyMap[KEY_LSHIFT]
    self.KeyMap[KEY_RCONTROL] = self.KeyMap[KEY_LCONTROL]

    self.InteractionZones = {
        {
            ID = "FrontBrakeLineIsolationToggle",
            Pos = Vector(469, -29, -62), Radius = 8,
        },
        {
            ID = "FrontTrainLineIsolationToggle",
            Pos = Vector(469, 29, -62), Radius = 8,
        },
        {
            ID = "RearBrakeLineIsolationToggle",
            Pos = Vector(-474, 30, -62), Radius = 8,
        },
        {
            ID = "RearTrainLineIsolationToggle",
            Pos = Vector(-474, -30, -62), Radius = 8,
        },
        {
            ID = "FrontDoor",
            Pos = Vector(469,32,-10), Radius = 12,
        },
        {
            ID = "CabinDoor",
            Pos = Vector(469,58,-10), Radius = 10,
        },
        {
            ID = "CabinDoor",
            Pos = Vector(469,58,-30), Radius = 10,
        },
        {
            ID = "CabinDoor",
            Pos = Vector(390,64,-10), Radius = 16,
        },
        {
            ID = "PassengerDoor",
            Pos = Vector(389,35,8), Radius = 16,
        },
        {
            ID = "RearDoor",
            Pos = Vector(-469,-35,-10), Radius = 20,
        },
        {
            ID = "GVToggle",
            Pos = Vector(155,63.7,-75), Radius = 10,
        },
        {
            ID = "AirDistributorDisconnectToggle",
            Pos = Vector(-224.5, 50, -66), Radius = 20,
        },
    }

    -- Cross connections in train wires
    self.TrainWireInverts = {
        --[18] = true,
        [34] = true,
    }
    self.TrainWireCrossConnections = {
        [5] = 4, -- Reverser F<->B
        [31] = 32, -- Doors L<->R
    }

    -- KV wrench mode
    self:OnButtonPress("KVWrenchNone")

    -- Parking brake ratio
    self.ManualBrake = 0.0
    self.RearDoor = false
    self.FrontDoor = false
    self.CabinDoor = false
    self.PassengerDoor = false

    self:TrainSpawnerUpdate()
end

function ENT:NonSupportTrigger()
    self.KAH:TriggerInput("Set",1)
    self.UOS:TriggerInput("Set",1)
    self.RC1:TriggerInput("Set",0)
    self.EPK:TriggerInput("Set",0)
    self.ARS:TriggerInput("Set",0)
    self.Plombs.KAH = nil
    self.Plombs.UOS = nil
    self.Plombs.RC1 = nil
end

function ENT:TrainSpawnerUpdate()
    if self:GetNW2Int("TrainType",1) == 1 then
        self.Announcer:TriggerInput("Reset","AnnouncementsRRI")
        self.Electric:TriggerInput("RRI",1)

        self.RRI:TriggerInput("Disable",0)
        self.ASNP:TriggerInput("Disable",1)
        self.IGLA_CBKI:TriggerInput("Disable",1)
        self:SetNW2Int("Announcer",1)
    elseif self:GetNW2Int("TrainType",1) == 2 then
        self.Announcer:TriggerInput("Reset","AnnouncementsASNP")
        self.Electric:TriggerInput("RRI",0)

        self.RRI:TriggerInput("Disable",1)
        self.ASNP:TriggerInput("Disable",0)
        self.IGLA_CBKI:TriggerInput("Disable",0)
    end
    self.Pneumatic.VDLoud = math.random()<0.06 and 0.9+math.random()*0.2
    if self.Pneumatic.VDLoud then self.Pneumatic.VDLoudID = math.random(1,5) end
end

--------------------------------------------------------------------------------
function ENT:Think()
    local RetVal = self.BaseClass.Think(self)
    local Panel = self.Panel
    local ALS_ARS = self.ALS_ARS
    local Pneumatic = self.Pneumatic
    self:SetPackedBool("RedLight",Panel.RedLights > 0)
    self:SetPackedBool("Headlights1",Panel.Headlights1 > 0)
    self:SetPackedBool("Headlights2",Panel.Headlights2 > 0)

    self:SetPackedBool("PanelLights",self.PanelLamp.Value > 0.5)

    local power = Panel.V1 > 0.5
    self:SetPackedBool("V1",power)
    local lightsActive2 = math.min(1,Panel.MainLights2)
    local lightsActive1 = math.min(1,Panel.MainLights1)^2
    local emerActive1 = Panel.EmergencyLights1
    local emerActive2 = Panel.EmergencyLights2
    self:SetPackedBool("Lamps_emer1",emerActive1 > 0 and lightsActive1 == 0)
    self:SetPackedBool("Lamps_cab",emerActive1 > 0)
    self:SetPackedBool("Lamps_emer2",emerActive2 > 0)
    self:SetPackedBool("Lamps_half1",lightsActive1 > 0)
    self:SetPackedBool("Lamps_half2",lightsActive2 > 0)
    self:SetPackedRatio("LampsStrength",lightsActive1)

    -- Switch and button states
    --self:SetPackedBool(0,self:IsWrenchPresent())

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


    self:SetPackedBool("RRIOn",self.RRI_VV.Power>0)
    self:SetPackedRatio("RRIRewind",self.RRIRewind.Value/2)

    local TW18 = 0
    if Panel.RRP > 0 then
        local wags = #self.WagonList
        for _,v in ipairs(self.WagonList) do
            TW18 = TW18+(v.Panel.TW18 or 0)/wags
        end
    end
    self:SetPackedBool("RP",TW18 > 0.5)
    self:SetPackedRatio("LSN",math.Clamp(TW18^0.7,0,1))
    self:SetPackedBool("GRP",Panel.GRP > 0)
    self:SetPackedBool("SD",Panel.SD > 0)
    self.TrueBrakeAngle = self.TrueBrakeAngle or 0
    if self.TrueBrakeAngle < 0.001 and self.ManualBrake < self.TrueBrakeAngle then self.TrueBrakeAngle = self.ManualBrake end
    if self.TrueBrakeAngle > 0.999 and self.ManualBrake > self.TrueBrakeAngle then self.TrueBrakeAngle = self.ManualBrake end
    self.TrueBrakeAngle = self.TrueBrakeAngle + (self.ManualBrake - self.TrueBrakeAngle)*2.0*(self.DeltaTime or 0)
    self:SetPackedRatio("ManualBrake",self.TrueBrakeAngle)
    self:SetPackedBool("SEQ",Panel.Sequence > 0)
        -- OCh
    self:SetPackedBool("04",ALS_ARS.NoFreq > 0)
    -- 0
    self:SetPackedBool("00",ALS_ARS.F5 > 0)
    -- 40
    self:SetPackedBool("40",ALS_ARS.F4 > 0)
    -- 60
    self:SetPackedBool("60",ALS_ARS.F3 > 0)
    -- 70
    self:SetPackedBool("70",ALS_ARS.F2 > 0)
    -- 80
    self:SetPackedBool("80",ALS_ARS.F1 > 0)
    -- ЛН
    self:SetPackedBool("LN",ALS_ARS.LN > 0)
    self:SetPackedBool("AB",ALS_ARS.AB > 0)
    self:SetPackedBool("ABLamp",ALS_ARS.ABReady > 0)
    self:SetPackedBool("L_ARS",ALS_ARS.ARS > 0)
    self:SetPackedBool("L_AV",ALS_ARS.AV > 0)
    self:SetPackedBool("L_AV1",ALS_ARS.AV1 > 0)

    self:SetPackedBool("KT",Panel.KT > 0)
    self:SetPackedBool("KVD",ALS_ARS.LVD > 0)
    self:SetPackedBool("RS",ALS_ARS.F6 > 0)

    self:SetPackedBool("AVU",Panel.AVU > 0.5)

    self:SetPackedBool("Ring",Panel.Ring > 0.5)
    -- Секвенция (задействие РПУ, замыкание РВЗ)
    --self:SetPackedBool("LPU",(self.RPU.Value == 1.0) and (self:ReadTrainWire(1) > 0.5 or self:ReadTrainWire(6) > 0.5))

    self:SetNW2Int("WrenchMode",self.KVWrenchMode)
    self:SetPackedBool("Compressor",Pneumatic.Compressor == 1.0)
    self:SetPackedBool("RK",self.RheostatController.Velocity ~= 0.0)
    self:SetPackedBool("RearDoor",self.RearDoor)
    self:SetPackedBool("FrontDoor",self.FrontDoor)
    self:SetPackedBool("PassengerDoor",self.PassengerDoor)
    self:SetPackedBool("CabinDoor",self.CabinDoor)
    self:SetPackedBool("AnnPlay",Panel.AnnouncerPlaying > 0)

    self:SetPackedBool("VPR",Panel.VPR > 0)

    self:SetPackedRatio("CranePosition", Pneumatic.DriverValvePosition/7)
    self:SetPackedRatio("ControllerPosition", (self.KV.ControllerPosition+3)/7)
    self:SetPackedRatio("ReverserPosition", 1-(self.KV.ReverserPosition+1)/2)
    self:SetPackedRatio("KRUPosition", self.KRU.Position/3)
    self:SetPackedBool("RCUPosition", self.KV.RCU > 0)
    self:SetPackedRatio("BLPressure", Pneumatic.ReservoirPressure/16.0)
    self:SetPackedRatio("TLPressure", Pneumatic.TrainLinePressure/16.0)
    self:SetPackedRatio("BCPressure",  math.min(2.7,Pneumatic.BrakeCylinderPressure)/6.0)
    self:SetPackedRatio("EnginesVoltage", self.Engines.E24/2000.0)
    self:SetPackedRatio("EnginesCurrent", 0.5 + 0.5*(self.Electric.I24/500.0))
    self:SetPackedRatio("BatteryVoltage",Panel["V1"]*self.Battery.Voltage/150.0)

    -- Update ARS system (no ars on E)
    self:SetPackedRatio("ALSSpeed", self.ALSCoil.Speed/100.0)
    self:SetPackedRatio("Speed", self.Speed/100)

    -- Exchange some parameters between engines, pneumatic system, and real world
    self.Engines:TriggerInput("Speed",self.Speed)
    --self.Engines:TriggerInput("Speed",CurTime()%5>2.5 and 120 or 82)
    if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and not self.IgnoreEngine then
        local A = 2*self.Engines.BogeyMoment
        self.FrontBogey.MotorForce = 22050+3000*(A < 0 and 1 or 0)
        self.FrontBogey.Reversed = (self.Reverser.NZ > 0.5)
        self.RearBogey.MotorForce  = 22050+3000*(A < 0 and 1 or 0)
        self.RearBogey.Reversed = (self.Reverser.VP > 0.5)

        -- These corrections are required to beat source engine friction at very low values of motor power
        local P = math.max(0,0.04449 + 1.06879*math.abs(A) - 0.465729*A^2)
        if math.abs(A) > 0.4 then P = math.abs(A) end
        if math.abs(A) < 0.05 then P = 0 end
        if self.Speed < 10 then P = P*(1.0 + 0.5*(10.0-self.Speed)/10.0) end
        self.RearBogey.MotorPower  = P*0.5*((A > 0) and 1 or -1)
        self.FrontBogey.MotorPower = P*0.5*((A > 0) and 1 or -1)

        -- Apply brakes
        local add = 1
        if math.abs(self:GetAngles().pitch) > 4 then
            add = math.min((math.abs(self:GetAngles().pitch)-4)/2,1)*2
        end
        self.FrontBogey.PneumaticBrakeForce = 50000.0-2000
        self.FrontBogey.BrakeCylinderPressure = Pneumatic.BrakeCylinderPressure*add
        self.FrontBogey.BrakeCylinderPressure_dPdT = -Pneumatic.BrakeCylinderPressure_dPdT
        self.FrontBogey.ParkingBrakePressure = self.ManualBrake
        self.RearBogey.PneumaticBrakeForce = 50000.0-2000
        self.RearBogey.BrakeCylinderPressure = Pneumatic.BrakeCylinderPressure*add
        self.RearBogey.BrakeCylinderPressure_dPdT = -Pneumatic.BrakeCylinderPressure_dPdT
    end

    self:GenerateJerks()

    return RetVal
end

--------------------------------------------------------------------------------
function ENT:OnButtonPress(button,ply)
    if string.find(button,"PneumaticBrakeSet") then
        self.Pneumatic:TriggerInput("BrakeSet",tonumber(button:sub(-1,-1)))
        return
    end

    if button:sub(1,3) == "ANN" then
        local ID = button:sub(4,-1)
        if self:GetNW2Int("TrainType",1) == 1 then
            self.RRI:TriggerInput(ID,1)
        elseif ID == "Up" then
            self.R_ASNPUp:TriggerInput("Set",1)
        elseif ID == "Down" then
            self.R_ASNPDown:TriggerInput("Set",1)
        elseif ID == "Right" then
            self.R_ASNPMenu:TriggerInput("Set",1)
        end
        return
    end

    -- Parking brake
    if button == "ParkingBrakeLeft" then self.ManualBrake = math.max(0.0,(self.ManualBrake or 0) - 0.05) end
    if button == "ParkingBrakeRight" then self.ManualBrake = math.min(1.0,(self.ManualBrake or 0) + 0.05) end
    if string.find(button,"PneumaticBrakeSet") then
        self.Pneumatic:TriggerInput("BrakeSet",tonumber(button:sub(-1,-1)))
        return
    end
    if button == "FrontDoor" then self.FrontDoor = not self.FrontDoor end
    if button == "RearDoor" then self.RearDoor = not self.RearDoor end
    if button == "PassengerDoor" then self.PassengerDoor = not self.PassengerDoor end
    if button == "CabinDoor" then self.CabinDoor = not self.CabinDoor end

    -- Parking brake
    if button == "ManualBrakeLeft" then
        self.ManualBrake = math.max(0.0,self.ManualBrake - 0.008)
        if self.ManualBrake == 0.0 then return end
    end
    if button == "ManualBrakeRight" then
        self.ManualBrake = math.min(1.0,self.ManualBrake + 0.008)
        if self.ManualBrake == 1.0 then return end
    end

    if button == "KVUp" then
        if self.KV.ControllerPosition ~= -1 then
            self.KV:TriggerInput("ControllerUp",1.0)
        end
    end
    if button == "KVUp_Unlocked" then
        self.KV:TriggerInput("ControllerUp",1.0)
    end
    if button == "KVDown" then
        self.KV:TriggerInput("ControllerDown",1.0)
    end

    if (self.KVWrenchMode == 3) and (button == "KVReverserUp") then self.KV:TriggerInput("RCU",1) end
    if (self.KVWrenchMode == 3) and (button == "KVReverserDown") then self.KV:TriggerInput("RCU",0) end
    -- KRU
    if (self.KVWrenchMode == 2) and (button == "KVReverserUp") then self.KRU:TriggerInput("Up",1) end
    if (self.KVWrenchMode == 2) and (button == "KVReverserDown") then self.KRU:TriggerInput("Down",1) end
    if (self.KVWrenchMode == 2) and (button == "KVSetX1B") then self.KRU:TriggerInput("SetX1",1) end
    if (self.KVWrenchMode == 2) and (button == "KVSetX2") then self.KRU:TriggerInput("SetX2",1) end
    if (self.KVWrenchMode == 2) and (button == "KVSetX3") then self.KRU:TriggerInput("SetX3",1) end
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
        if self.KVWrenchMode == 0 then
            self:PlayOnce("revers_in","cabin",0.7)
            self.KVWrenchMode = 3
        elseif self.KVWrenchMode ~= 0 and self.KV.ReverserPosition == 0 and self.KRU.Position == 0 then
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
    if button == "KU6" and not self.KU7Pressed and self.KU7.Value == 0 then self.KU6K:TriggerInput("Open",1)  end
    if button == "KU7" and not self.KU6Pressed and self.KU6.Value == 0 then self.KU6K:TriggerInput("Close",1)  end
    if button == "KU6" and not self.KU7Pressed and self.KU2.Value < 1 and self.KU7.Value == 0 then self.KU6:TriggerInput("Close",1)  end
    if button == "KU7" and not self.KU6Pressed and self.KU2.Value < 1 and self.KU6.Value == 0 then self.KU7:TriggerInput("Close",1)  end
    if button == "KU6" then self.KU6Pressed = true end
    if button == "KU7" then self.KU7Pressed = true end

    if button == "EmergencyBrake" then
        self.KV:TriggerInput("ControllerSet",-3)
        self.Pneumatic:TriggerInput("BrakeSet",7)
        self.DriverValveBLDisconnect:TriggerInput("Set",1)
        return
    end
    if button == "DriverValveDisconnect" then
        if self.DriverValveBLDisconnect.Value == 0 or self.DriverValveTLDisconnect.Value == 0 then
            self.DriverValveBLDisconnect:TriggerInput("Set",1)
            self.DriverValveTLDisconnect:TriggerInput("Set",1)
        else
            --self:PlayOnce("pneumo_disconnect1","cabin",0.9)
            self.DriverValveBLDisconnect:TriggerInput("Set",0)
            self.DriverValveTLDisconnect:TriggerInput("Set",0)
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
    if button == "KU6" and self.KU2.Value < 1 then self.KU6:TriggerInput("Open",1) end
    if button == "KU7" and self.KU2.Value < 1 then self.KU7:TriggerInput("Open",1) end
    if button == "KU6" then self.KU6Pressed = false end
    if button == "KU7" then self.KU7Pressed = false end
    if button == "KVSetT1AB" then
        if self.KV.ControllerPosition > -3 then
            self.KV:TriggerInput("ControllerSet",-2)
        end
    end

    if button:sub(1,3) == "ANN" then
        local ID = button:sub(4,-1)
        if self:GetNW2Int("TrainType",1) == 1 then
            self.RRI:TriggerInput(ID,0)
        elseif ID == "Up" then
            self.R_ASNPUp:TriggerInput("Set",0)
        elseif ID == "Down" then
            self.R_ASNPDown:TriggerInput("Set",0)
        elseif ID == "Right" then
            self.R_ASNPMenu:TriggerInput("Set",0)
        end
        return
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
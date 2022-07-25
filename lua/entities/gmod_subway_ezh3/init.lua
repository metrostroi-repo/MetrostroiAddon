AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner

--"DURASelectMain","DURASelectAlternate","DURAToggleChannel","DURAPowerToggle",
ENT.SyncTable = {
    "VB","DoorSelect","V4","V5","KU9","KU15","V1","VU14","V2","V3","V6","KU12","KU7","V10","KU8","OtklAVU","KU10","KU11","KRR","R_UNch","R_ZS","R_G","R_Radio","R_Program1","R_Program2","Ring","PB","RC1","VAH","VAD","ARS","ALS","KVT","KB","KAH","VU1","VU2","VU3","AV","VU","PLights","GLights","RST","RUM","KRR",
    "R_Program1H","R_Program2H",
    "SAMMSchemeOff","SAMMStart","SAMMReset","SAMMOn","SAMMBlok","SAMMX2","SAMMAhead","SAMMAccept","SAMMUnit",
    "RRIEnable","RRIAmplifier",
    "DriverValveBLDisconnect","DriverValveTLDisconnect","EPK","EmergencyBrakeValve","UAVA","UAVAC",
    "GV",
    "R_ASNPOn","R_ASNPDown","R_ASNPUp","R_ASNPPath","R_ASNPMenu","IGLA1","IGLA2",
}

function ENT:Initialize()
    self.Plombs = {
        VAH = true,
        RUM = true,
        UAVA = true,
        Init = true,
    }
    -- Set model and initialize
    self:SetModel("models/metrostroi_train/81-710/81-710.mdl")
    self.BaseClass.Initialize(self)
    self:SetPos(self:GetPos() + Vector(0,0,140))

    -- Create seat entities
    self.DriverSeat = self:CreateSeat("driver",Vector(425+5,-39,-31.5),Angle(0,0,0))
    self.InstructorsSeat = self:CreateSeat("instructor",Vector(430,40,-52),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")
    self.ExtraSeat1 = self:CreateSeat("instructor",Vector(443,0,-52),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")
    self.ExtraSeat2 = self:CreateSeat("instructor",Vector(420,-20,-52),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")

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
    --.FrontBogey = self:CreateBogey(Vector( 320,0,-75),Angle(0,180,0),true)
    --self.RearBogey  = self:CreateBogey(Vector(-320,0,-75),Angle(0,0,0),false)

    if Metrostroi.BogeyOldMap then
        self.FrontBogey = self:CreateBogey(Vector( 317-5,0,-89),Angle(0,180,0),true,"717")
        self.RearBogey  = self:CreateBogey(Vector(-317+0,0,-89),Angle(0,0,0),false,"717")
        self.FrontCouple = self:CreateCouple(Vector( 419.5+3.5,0,-75),Angle(0,0,0),true,"702")
        self.RearCouple  = self:CreateCouple(Vector(-421.5-3.5,0,-75),Angle(0,180,0),false,"702")
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
        [KEY_8] = "KU10Set",

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

        [KEY_A] = {"KU12",helper="V6Set"},
        [KEY_D] = "KU7",
        [KEY_V] = {"V2Toggle",helper="V3Toggle"},
        [KEY_L] = "HornEngage",
        [KEY_PAD_1] = "PneumaticBrakeSet1",
        [KEY_PAD_2] = "PneumaticBrakeSet2",
        [KEY_PAD_3] = "PneumaticBrakeSet3",
        [KEY_PAD_4] = "PneumaticBrakeSet4",
        [KEY_PAD_5] = "PneumaticBrakeSet5",
        [KEY_PAD_DIVIDE] = "KU10Set",
        [KEY_PAD_MULTIPLY] = "KAHSet",

        [KEY_SPACE] = {
            def="PBSet",
            [KEY_LSHIFT] = "KVTSet",
        },
        [KEY_BACKSPACE] = {"EmergencyBrake",helper="EmergencyBrakeValveToggle"},

        [KEY_PAD_ENTER] = "KVWrenchKV",
        [KEY_PAD_0] = "DriverValveDisconnect",
        [KEY_PAD_DECIMAL] = "EPKToggle",
        [KEY_LSHIFT] = {
            [KEY_W] = "KVUp_Unlocked",
            [KEY_SPACE] = "KVTSet",

            [KEY_1] = "V4Set",
            [KEY_2] = "RingSet",
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
            [KEY_V] = "V2Toggle",
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
        [21] = true,
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

--  self.A5:TriggerInput("Set",0)
    self:TrainSpawnerUpdate()
end

function ENT:NonSupportTrigger()
    self.RUM:TriggerInput("Set",0)
    self.VAH:TriggerInput("Set",1)
    self.Plombs.RUM = nil
    self.Plombs.VAH = nil
    self.EPK:TriggerInput("Set",0)
    self.ARS:TriggerInput("Set",0)
end

function ENT:TrainSpawnerUpdate()
    if self:GetNW2Int("AnnType",1) == 1 then
        self.Announcer:TriggerInput("Reset","AnnouncementsRRI")
        self.Electric:TriggerInput("RRI",1)

        self.RRI:TriggerInput("Disable",0)
        self.ASNP:TriggerInput("Disable",1)
        self.IGLA_CBKI:TriggerInput("Disable",1)
    elseif self:GetNW2Int("AnnType",1) == 2 then
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
    local Pneumatic = self.Pneumatic
    self:SetPackedBool("PanelLights",Panel.PanelLights> 0.5)
    self:SetPackedBool("GaugeLights",Panel.GaugeLights > 0.5)
    self:SetPackedBool("RedLight",Panel.RedLights>0)
    self:SetPackedBool("Headlights1",Panel.Headlights1 > 0)
    self:SetPackedBool("Headlights2",Panel.Headlights2 > 0)

    local power = Panel.V1 > 0.5
    self:SetPackedBool("V1p",power)
    local lightsActive2 = math.min(1,Panel.MainLights2)
    local lightsActive1 = math.min(1,Panel.MainLights1)^2
    local emerActive1 = Panel.EmergencyLights1
    local emerActive2 = Panel.EmergencyLights2

    self:SetPackedBool("Lamps_cab",emerActive1 > 0)
    self:SetPackedBool("Lamps_emer2",emerActive2 > 0)
    self:SetPackedBool("Lamps_half1",lightsActive1 > 0)
    self:SetPackedBool("Lamps_half2",lightsActive2 > 0)
    self:SetPackedRatio("LampsStrength",lightsActive1)

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
    --self:SetPackedBool("RP",TW18 > 0.5)
    self:SetPackedRatio("LSN",math.Clamp(TW18^0.7,0,1))
    self:SetPackedBool("GRP",Panel.GRP > 0)
    self:SetPackedBool("SD",Panel.SD > 0)

    self.TrueBrakeAngle = self.TrueBrakeAngle or 0
    if self.TrueBrakeAngle < 0.001 and self.ManualBrake < self.TrueBrakeAngle then self.TrueBrakeAngle = self.ManualBrake end
    if self.TrueBrakeAngle > 0.999 and self.ManualBrake > self.TrueBrakeAngle then self.TrueBrakeAngle = self.ManualBrake end
    self.TrueBrakeAngle = self.TrueBrakeAngle + (self.ManualBrake - self.TrueBrakeAngle)*2.0*(self.DeltaTime or 0)
    self:SetPackedRatio("ManualBrake",self.TrueBrakeAngle)

    self:SetPackedBool("LKVT",Panel.LKVT > 0)
    self:SetPackedBool("KT",Panel.KT > 0)
    self:SetPackedBool("AVU",Panel.AVU > 0.5)
    self:SetPackedBool("RingEnabled",Panel.Ring > 0.5)

    self:SetNW2Int("WrenchMode",self.KVWrenchMode)
    self:SetPackedBool("Compressor",Pneumatic.Compressor == 1.0)
    self:SetPackedBool("RK",self.RheostatController.Velocity ~= 0.0)
    self:SetPackedBool("RearDoor",self.RearDoor)
    self:SetPackedBool("FrontDoor",self.FrontDoor)
    self:SetPackedBool("PassengerDoor",self.PassengerDoor)
    self:SetPackedBool("CabinDoor",self.CabinDoor)
    self:SetPackedBool("AnnPlay",Panel.AnnouncerPlaying > 0)
    if self:GetNW2Int("AnnType",1) == 1 then
        self:SetPackedBool("AnnCab",self.RRI_VV.CabinSpeakerPower > 0)
    else
        self:SetPackedBool("AnnCab",self.ASNP_VV.CabinSpeakerPower > 0)
    end

    self:SetPackedBool("VPR",Panel.VPR > 0)

    self:SetPackedRatio("CranePosition", Pneumatic.DriverValvePosition/7)
    self:SetNW2Int("ControllerPosition", (self.KV.ControllerPosition+3))
    self:SetPackedRatio("ReverserPosition", 1-(self.KV.ReverserPosition+1)/2)
    self:SetNW2Int("KRUPosition", self.KRU.Position)
    self:SetPackedBool("RCUPosition", self.KV.RCU > 0)
    self:SetPackedRatio("BLPressure", Pneumatic.ReservoirPressure/16.0)
    self:SetPackedRatio("TLPressure", Pneumatic.TrainLinePressure/16.0)
    self:SetPackedRatio("BCPressure",  math.min(2.7,Pneumatic.BrakeCylinderPressure)/6.0)
    self:SetPackedRatio("EnginesVoltage", self.Electric.Main750V/1000.0)
    self:SetPackedRatio("BatteryVoltage",Panel["V1"]*self.Battery.Voltage/150.0)
    self:SetPackedRatio("EnginesCurrent", 0.5 + 0.5*(self.Electric.I24/500.0))

    self:SetPackedBool("RT300",self.Electric.ThyristorControllerPower*self.Electric.ThyristorControllerWork>0)

    self:SetPackedBool("AR04",Panel.AR04 > 0)
    self:SetPackedBool("AR0",Panel.AR0 > 0)
    self:SetPackedBool("AR40",Panel.AR40 > 0)
    self:SetPackedBool("AR60",Panel.AR60 > 0)
    self:SetPackedBool("AR70",Panel.AR70 > 0)
    self:SetPackedBool("AR80",Panel.AR80 > 0)
    self:SetPackedBool("KT",Panel.KT)
    self:SetPackedBool("KVD",Panel.KVD > 0)

    self:SetPackedRatio("Speed", self.Speed/100)
    -- Exchange some parameters between engines, pneumatic system, and real world
    self.Engines:TriggerInput("Speed",self.Speed)
    if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and not self.IgnoreEngine then
        local A = 2*self.Engines.BogeyMoment
        self.FrontBogey.MotorForce = 22500+3000*(A < 0 and 1 or 0)
        self.FrontBogey.Reversed = (self.Reverser.NZ > 0.5)
        self.RearBogey.MotorForce  = 22500+3000*(A < 0 and 1 or 0)
        self.RearBogey.Reversed = (self.Reverser.VP > 0.5)

        -- These corrections are required to beat source engine friction at very low values of motor power
        local A = 2*self.Engines.BogeyMoment
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

    if button:sub(1,3) == "ANN" then
        local ID = button:sub(4,-1)
        if self:GetNW2Int("AnnType",1) == 1 then
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
    if button == "KU12" and self.V2.Value < 1 then
        self.KU7:TriggerInput("Open",1)
        self.KU12:TriggerInput("Close",1)
    end
    if button == "KU7" and self.V2.Value < 1 then
        self.KU12:TriggerInput("Open",1)
        self.KU7:TriggerInput("Close",1)
    end

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
    if button == "KU12" and self.V2.Value < 1 then self.KU12:TriggerInput("Open",1) end
    if button == "KU7" and self.V2.Value < 1 then self.KU7:TriggerInput("Open",1) end
    if button == "KVSetT1AB" then
        if self.KV.ControllerPosition > -3 then
            self.KV:TriggerInput("ControllerSet",-2)
        end
    end

    if button:sub(1,3) == "ANN" then
        local ID = button:sub(4,-1)
        if self:GetNW2Int("AnnType",1) == 1 then
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

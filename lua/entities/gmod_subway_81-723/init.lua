AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner
ENT.SyncTable = {
    "SF31","SF32","SF33","SF34","SF35","SF36","SF37","SF38","SF41","SF42","SF43","SF44","SF45","SF46","SF47","SF48","SF49","SF51","SF52","SF53","SF54","SF55","SF56","SF57","SF58","SF59",

    "FrontBrakeLineIsolation","FrontTrainLineIsolation",
    "RearBrakeLineIsolation","RearTrainLineIsolation",
}
--------------------------------------------------------------------------------
function ENT:Initialize()
    -- Set model and initialize
    self:SetModel("models/metrostroi_train/81-722/81-723.mdl")
    self.BaseClass.Initialize(self)
    self:SetPos(self:GetPos() + Vector(0,0,140))

    -- Create seat entities
    self.DriverSeat = self:CreateSeat("instructor",Vector(450,11,-35))

    -- Hide seats
    self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.DriverSeat:SetColor(Color(0,0,0,0))

    -- Create bogeys
    self.FrontBogey = self:CreateBogey(Vector( 322,0,-90),Angle(0,180,0),true,"722")
    self.RearBogey  = self:CreateBogey(Vector(-333,0,-90),Angle(0,0,0),false,"722")
    self.FrontBogey:SetNWBool("Async",true)
    self.RearBogey:SetNWBool("Async",true)
    self.FrontBogey:SetNWFloat("SqualPitch",0.8)
    self.RearBogey:SetNWFloat("SqualPitch",0.8)
    self.FrontBogey:SetNWBool("DisableEngines",true)
    self.RearBogey:SetNWBool("DisableEngines",true)
    if Metrostroi.BogeyOldMap then
        self.FrontCouple = self:CreateCouple(Vector( 413.7+7.5,0,-77),Angle(0,0,0),true,"717")
        self.RearCouple  = self:CreateCouple(Vector(-419-7.5,0,-77),Angle(0,180,0),false,"717")
    else
        self.FrontCouple = self:CreateCouple(Vector( 420    -8,0,-79),Angle(0,0,0),true,"717")
        self.RearCouple  = self:CreateCouple(Vector(-419-6.8+8,0,-79),Angle(0,180,0),false,"717")
    end
    self.FrontBogey.DisableSound = 1
    self.RearBogey.DisableSound = 1

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
            ID = "FrontBrakeLineIsolationToggle",
            Pos = Vector(463.3, -34, -65), Radius = 8,
        },
        {
            ID = "FrontTrainLineIsolationToggle",
            Pos = Vector(463.3, 35, -65), Radius = 8,
        },
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
            ID = "FrontDoor",
            Pos = Vector(457.8, 36, 0), Radius = 20,
        },
    }
    
    self.FrontDoor = false
    self.RearDoor = false

    self:SetNW2Float("UPONoiseVolume",math.Rand(0,0.3))
    self:SetNW2Float("UPOVolume",math.Rand(0.8,1))
end

--------------------------------------------------------------------------------
function ENT:Think()
    local retVal = self.BaseClass.Think(self)
    local power = self.BUKV.Power > 0

    if self.AsyncInverter.State==1 then
        local state = math.abs(self.AsyncInverter.InverterFrequency/13)--(10+8*math.Clamp((self.AsyncInverter.State-0.4)/0.4,0,1)))
        self:SetPackedRatio("asynccurrent", math.Clamp(state*(state+self.AsyncInverter.State/1),0,1))
    else
        local state = math.abs(self.AsyncInverter.InverterFrequency/(11+self.AsyncInverter.State*5))--(10+8*math.Clamp((self.AsyncInverter.State-0.4)/0.4,0,1)))
        self:SetPackedRatio("asynccurrent", math.Clamp(state*(state+self.AsyncInverter.State/1),0,1))
    end
    self:SetPackedRatio("asyncstate", math.Clamp(self.AsyncInverter.State/0.2*math.abs(self.AsyncInverter.Current)/100,0,1))
    self:SetPackedRatio("chopper", math.Clamp(self.Electric.Chopper>0 and self.Electric.Iexit/100 or 0,0,1))

    self:SetPackedRatio("Speed", self.Speed)
    self:SetPackedRatio("SalonLighting",math.min(1,self.Panel.MainLights+self.Panel.EmergencyLights*0.3))

    --self:SetPackedBool("BattPressed",self.BUKV.BatteryPressed)

    self:SetNW2Int("PassSchemesLED",self.PassSchemes.PassSchemeCurr)
    self:SetNW2Int("PassSchemesLEDN",self.PassSchemes.PassSchemeNext)
    self:SetPackedBool("PassSchemesLEDO",self.PassSchemes.PassSchemePath)
    self:SetPackedBool("SarmatLeft",self.Panel.PassSchemePowerL)
    self:SetPackedBool("SarmatRight",self.Panel.PassSchemePowerR)

    self:SetPackedBool("CompressorWork",self.Pneumatic.Compressor)

    --self:SetPackedRatio("Cran", self.Pneumatic.DriverValvePosition)
    --self:SetPackedRatio("BL", self.Pneumatic.BrakeLinePressure/16.0)
    --self:SetPackedRatio("TL", self.Pneumatic.TrainLinePressure/16.0)
    --self:SetPackedRatio("BC", math.min(3.2,self.Pneumatic.BrakeCylinderPressure)/6.0)

    self:SetPackedBool("FrontDoor",self.FrontDoor)
    self:SetPackedBool("RearDoor",self.RearDoor)

    self:SetPackedBool("BortPneumo",self.Panel.BrW>0)
    self:SetPackedBool("BortLSD",self.Panel.DoorsW>0)
    self:SetPackedBool("BortBV",self.Panel.GRP>0)

    self:SetPackedBool("DoorAlarmL",self.BUKV.CloseRing)
    self:SetPackedBool("DoorAlarmR",self.BUKV.CloseRing)

    self:SetNW2Int("PassSchemesLED",self.PassSchemes.PassSchemeCurr)
    self:SetNW2Int("PassSchemesLEDN",self.PassSchemes.PassSchemeNext)
    self:SetPackedBool("PassSchemesLEDO",self.PassSchemes.PassSchemePath)
    self:SetPackedBool("SarmatLeft",self.Panel.PassSchemePowerL)
    self:SetPackedBool("SarmatRight",self.Panel.PassSchemePowerR)

    self:SetPackedBool("AnnPlay",self.Panel.AnnouncerPlaying > 0)
    self:SetPackedBool("AnnPlayUPO",self.Announcer.AnnTable=="AnnouncementsUPO")

    self.AsyncInverter:TriggerInput("Speed",self.Speed)
    if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and not self.IgnoreEngine then
        local A = self.AsyncInverter.Torque
        self.FrontBogey.MotorForce = 43000+9000*(A < 0 and 1 or 0)--35300
        self.FrontBogey.Reversed = self.Electric.Reverser < 0
        self.FrontBogey.DisableSound = 1
        self.FrontBogey.DisableContacts = self.Electric.DisablePant > 0
        self.RearBogey.MotorForce  = 43000+9000*(A < 0 and 1 or 0)--35300
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
        self.FrontBogey.ParkingBrakePressure = math.max(0,(3-self.Pneumatic.ParkingBrakePressure)/3)/2
        self.FrontBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
        self.RearBogey.PneumaticBrakeForce = 50000.0--3000 --40000
        self.RearBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.RearBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
        self.RearBogey.ParkingBrakePressure = math.max(0,(3-self.Pneumatic.ParkingBrakePressure)/3)/2
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
    if button == "FrontDoor" then self.FrontDoor = not self.FrontDoor end
    if button == "RearDoor" then self.RearDoor = not self.RearDoor end
end

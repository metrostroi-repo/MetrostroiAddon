--92 ЮНИТА РАССТОЯНИЕ МЕЖДУ СЦЕПКОЙ И ПЕРВОЙ КОЛПАРОЙ

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("metrostroi_bogey_contact")

local DECOUPLE_TIMEOUT      = 2     -- Time after decoupling furing wich a bogey cannot couple
local COUPLE_MAX_DISTANCE   = 20    -- Maximum distance between couple offsets
local COUPLE_MAX_ANGLE      = 18    -- Maximum angle between bogeys on couple


--------------------------------------------------------------------------------
COUPLE_MAX_DISTANCE = COUPLE_MAX_DISTANCE ^ 2
COUPLE_MAX_ANGLE = math.cos(math.rad(COUPLE_MAX_ANGLE))

--------------------------------------------------------------------------------
ENT.Types = {
    ["702"] = {
        "models/metrostroi_train/bogey/metro_bogey_702.mdl",
        Vector(0,0.0,-7),Angle(0,90,0),"models/metrostroi_train/bogey/metro_wheels_702.mdl",
        Vector(0,-61,-14),Vector(0,61,-14),
        nil,
        Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),
    },
    ["717"] = {
        "models/metrostroi_train/bogey/metro_bogey_717.mdl",
        Vector(0,0.0,-10),Angle(0,90,0),"models/metrostroi_train/bogey/metro_wheels_collector.mdl",
        Vector(0,-61,-14),Vector(0,61,-14),
        nil,
        Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),
    },
    ["720"] = {
        "models/metrostroi_train/bogey/metro_bogey_collector.mdl",
        Vector(0,0.0,-10),Angle(0,90,0),"models/metrostroi_train/bogey/metro_wheels_collector.mdl",
        Vector(0,-61,-14),Vector(0,61,-14),
        nil,
        Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),

    },
    ["722"] = {
        "models/metrostroi_train/bogey/metro_bogey_async.mdl",
        Vector(0,0.0,-10),Angle(0,90,0),"models/metrostroi_train/bogey/metro_wheels_collector.mdl",
        Vector(0,-61,-14),Vector(0,61,-14),
        nil,
        Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),
    },
    tatra={
        "models/metrostroi/tatra_t3/tatra_bogey.mdl",
        Vector(0,0.0,-3),Angle(0,90,0),nil,
        Vector(0,-61,-14),Vector(0,61,-14),
        nil,
        Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),
    },
    def={
        "models/metrostroi/metro/metro_bogey.mdl",
        Vector(0,0.0,-10),Angle(0,90,0),nil,
        Vector(0,-61,-14),Vector(0,61,-14),
        nil,
        Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),
    },
}

ENT.SnakePos = Vector(-168.25,0,6.5)
ENT.SnakeAng = Angle(0,90,0)
function ENT:SetParameters()
    local typ = self.Types[self.BogeyType or "717"]
    self:SetModel(typ and typ[1] or "models/metrostroi/metro/metro_bogey.mdl")
    self.PantLPos = typ and typ[5]
    self.PantRPos = typ and typ[6]
    self.BogeyOffset = typ and typ[7]
    self.PantLCPos = typ and typ[8]
    self.PantRCPos = typ and typ[9]
end
function ENT:Initialize()
    self:SetParameters()
    if not self.NoPhysics then
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
    end
    self:SetUseType(SIMPLE_USE)

    -- Set proper parameters for the bogey
    if IsValid(self:GetPhysicsObject()) then
        self.PhysObj = self:GetPhysicsObject()
        self.Mass = 5000
        self.PhysObj:SetMass(self.Mass)
    end

    -- Store coupling point offset
    self.CouplingPointOffset = Vector(-168.13,0,0)

    -- Create wire controls
    if Wire_CreateInputs then
        self.Inputs = Wire_CreateInputs(self,{
            "BrakeCylinderPressure",
            "MotorCommand", "MotorForce", "MotorReversed",
            "DisableSound" })
        self.Outputs = Wire_CreateOutputs(self,{
            "Speed", "BrakeCylinderPressure","Voltage"
        })
    end

    -- Setup default motor state
    self.Reversed = false
    self.MotorForce = 30000.0
    self.MotorPower = 0.0
    self.Speed = 0
    self.SpeedSign = 1
    self.Acceleration = 0
    self.PneumaticBrakeForce = 100000.0
    self.DisableSound = 0

    self.Variables = {}

    -- Pressure in brake cylinder
    self.BrakeCylinderPressure = 0.0 -- atm

    self.Voltage = 0
    self.VoltageDrop = 0
    self.DropByPeople = 0
    self.ContactStates = { false, false }
    self.DisableContacts = false
    self.DisableContactsManual = false
    self.DisableParking = false
    self.NextStates = { false,false }
    self.Connectors = { }
    self.CheckTimeout = 0

    if self:GetNW2Int("SquealType",0)==0 then
        self:SetNW2Int("SquealType",math.floor(math.random()*4)+1)
    end
end

function ENT:InitializeWheels()
    -- Create missing wheels
    if IsValid(self.Wheels) then SafeRemoveEntity(self.Wheels) end
    local wheels = ents.Create("gmod_train_wheels")
    local typ = self.Types[self.BogeyType or "717"]
    wheels.Model = typ[4]
    if typ and typ[3] then wheels:SetAngles(self:LocalToWorldAngles(typ[3])) end
    if typ and typ[2] then wheels:SetPos(self:LocalToWorld(typ[2])) end

    wheels.WheelType = self.BogeyType
    wheels.NoPhysics = self.NoPhysics
    wheels:Spawn()

    if self.NoPhysics then
        wheels:SetParent(self)
    else
        constraint.Weld(self,wheels,0,0,0,1,0)
    end

    -- Assign ownership
    local train = self:GetNW2Entity("TrainEntity")
    if IsValid(self:GetPlayer()) then
        wheels:SetPlayer(self:GetPlayer())
    elseif IsValid(train) and IsValid(train:GetPlayer()) then
        wheels:SetPlayer(train:GetPlayer())
    end

    if CPPI and IsValid(self:CPPIGetOwner()) then
        wheels:CPPISetOwner(self:CPPIGetOwner())
    elseif CPPI and IsValid(train) and IsValid(train:CPPIGetOwner()) then
        wheels:CPPISetOwner(train:CPPIGetOwner())
    end

    if (IsValid(wheels:GetPhysicsObject())) then
        wheels.PhysObj = wheels:GetPhysicsObject()
    end
    
    
    wheels:SetNW2Entity("TrainBogey",self)
    self.Wheels = wheels
end

function ENT:OnRemove()
    SafeRemoveEntity(self.Wheels)
    if self.CoupledBogey ~= nil then
        self:Decouple()
    end
end

function ENT:GetDebugVars()
    return self.Variables
end

function ENT:TriggerInput(iname, value)
    if iname == "BrakeCylinderPressure" then
        self.BrakeCylinderPressure = value
    elseif iname == "MotorCommand" then
        self.MotorPower = value
    elseif iname == "MotorForce" then
        self.MotorForce = value
    elseif iname == "MotorReversed" then
        self.Reversed = value > 0.5
    elseif iname == "DisableSound" then
        self.DisableSound = math.max(0,math.min(3,math.floor(value)))
    end
end

--[[ Checks if there's an advballsocket between two entities
local function AreCoupled(ent1,ent2)
    if ent1.CoupledBogey or ent2.CoupledBogey then return false end
    local constrainttable = constraint.FindConstraints(ent1,"AdvBallsocket")
    local coupled = false
    for k,v in pairs(constrainttable) do
        if v.Type == "AdvBallsocket" then
            if( (v.Ent1 == ent1 or v.Ent1 == ent2) and (v.Ent2 == ent1 or v.Ent2 == ent2)) then
                coupled = true
            end
        end
    end

    return coupled
end]]

-- Adv ballsockets ents by their CouplingPointOffset
function ENT:Couple(ent)
    if IsValid(constraint.AdvBallsocket(
        self,
        ent,
        0, --bone
        0, --bone
        self.CouplingPointOffset,
        ent.CouplingPointOffset,
        0, --forcelimit
        0, --torquelimit
        -25, --xmin
        -10, --ymin
        -25, --zmin
        25, --xmax
        10, --ymax
        25, --zmax
        0, --xfric
        0, --yfric
        0, --zfric
        0, --rotonly
        1 --nocollide
    )) then
        sound.Play("subway_trains/bogey/couple.mp3",(self:GetPos()+ent:GetPos())/2,70,100,1)

        self:OnCouple(ent)
        ent:OnCouple(self)
    end
end

local function AreInCoupleDistance(ent1,ent2)
    return ent2:LocalToWorld(ent2.CouplingPointOffset):DistToSqr(ent1:LocalToWorld(ent1.CouplingPointOffset)) < COUPLE_MAX_DISTANCE
end

local function AreFacingEachother(ent1,ent2)
    return ent1:GetForward():Dot(ent2:GetForward()) < -COUPLE_MAX_ANGLE
end

function ENT:IsInTimeOut()
    return (((self.DeCoupleTime or 0) + DECOUPLE_TIMEOUT) > CurTime())
end

function ENT:CanCouple()
    if self.CoupledBogey then return false end
    if self:IsInTimeOut() then return false end
    if not constraint.CanConstrain(self,0) then return false end
    return true
end

-- This feels so wrong, any ideas how to improve this?
local function CanCoupleTogether(ent1,ent2)
    if ent1.DontHaveCoupler or ent2.DontHaveCoupler then return false end
    if      ent2:GetClass() ~= ent1:GetClass() then return false end
    --if not (ent1.CanCouple and ent1:CanCouple()) then return false end
    --if not (ent2.CanCouple and ent2:CanCouple()) then return false end
    if not AreInCoupleDistance(ent1,ent2) then return false end
    if not AreFacingEachother(ent1,ent2) then return false end
    return true
end

-- Used the couple with other bogeys
function ENT:StartTouch(ent)
    if CanCoupleTogether(self,ent) then
        self:Couple(ent)
    end
end


util.AddNetworkString("metrostroi-bogey-menu")
-- Used to decouple
function ENT:Use(ply)
    net.Start("metrostroi-bogey-menu")
        net.WriteEntity(self)
        net.WriteBool(game.SinglePlayer() or not self.CPPICanUse or self:CPPICanUse(ply))
        net.WriteBool(self.DisableContactsManual)
        net.WriteBool(self.ParkingBrakePressure~=nil)
        net.WriteBool(self.DisableParking)
    net.Send(ply)
end

net.Receive("metrostroi-bogey-menu",function(_,ply)
    local bogey = net.ReadEntity()

    if not game.SinglePlayer() and bogey.CPPICanUse and not bogey:CPPICanUse(ply) then return end
    local id = net.ReadUInt(8)
    if id==0 then
        bogey.DisableContactsManual = not bogey.DisableContactsManual
    end
    if id==1 then
        bogey.DisableParking = not bogey.DisableParking
    end
end)

function ENT:ConnectDisconnect(status)
    local isfront = self:GetNW2Bool("IsForwardBogey")
    local train = self:GetNW2Entity("TrainEntity")
    if IsValid(train) then
        if status ~= nil then
            if status then train:OnBogeyConnect(self, isfront) else train:OnBogeyDisconnect(self, isfront) end
        else
            if (train.FrontCoupledBogeyDisconnect and isfront) or (train.RearCoupledBogeyDisconnect and not isfront) then
                train:OnBogeyConnect(self, isfront)
                if IsValid(self.CoupledBogey) then self.CoupledBogey:ConnectDisconnect(true) end
                return
            end
            if (not train.FrontCoupledBogeyDisconnect and isfront) or (not train.RearCoupledBogeyDisconnect and not isfront) then
                train:OnBogeyDisconnect(self, isfront)
                if IsValid(self.CoupledBogey) then self.CoupledBogey:ConnectDisconnect(false) end
                return
            end
        end
    end
end

function ENT:GetConnectDisconnect()
    local isfront = self:GetNW2Bool("IsForwardBogey")
    local train = self:GetNW2Entity("TrainEntity")
    if IsValid(train) then
        if (train.FrontCoupledBogeyDisconnect and isfront) or (train.RearCoupledBogeyDisconnect and not isfront) then
            return false
        end
        if (not train.FrontCoupledBogeyDisconnect and isfront) or (not train.RearCoupledBogeyDisconnect and not isfront) then
            return true
        end
    end
end

local function removeAdvBallSocketBetweenEnts(ent1,ent2)
    local constrainttable = constraint.FindConstraints(ent1,"AdvBallsocket")
    for k,v in pairs(constrainttable) do
        if (v.Ent1 == ent1 or v.Ent1 == ent2) and (v.Ent2 == ent1 or v.Ent2 == ent2) then
            v.Constraint:Remove()
        end
    end
end

function ENT:Decouple()
    if self.CoupledBogey then
        sound.Play("buttons/lever8.wav",(self:GetPos()+self.CoupledBogey:GetPos())/2)
        removeAdvBallSocketBetweenEnts(self,self.CoupledBogey)

        self.CoupledBogey.CoupledBogey = nil
        self.CoupledBogey:Decouple()
        self.CoupledBogey = nil
    end

    -- Above this runs on initiator, below runs on both
    self.DeCoupleTime = CurTime()
    self:OnDecouple()
end


function ENT:OnCouple(ent)
    self.CoupledBogey = ent

    --Call OnCouple on our parent train as well
    local parent = self:GetNW2Entity("TrainEntity")
    local isforward = self:GetNW2Bool("IsForwardBogey")
    if IsValid(parent) then
        parent:OnCouple(ent,isforward)
    end
    if self.OnCoupleSpawner then self:OnCoupleSpawner() end
end

function ENT:OnDecouple()
    --Call OnDecouple on our parent train as well
    local parent = self:GetNW2Entity("TrainEntity")
    local isforward = self:GetNW2Bool("IsForwardBogey")

    if IsValid(parent) then
        parent:OnDecouple(isforward)
    end
end

local traceResultTbl = {
    AllSolid    = false,
    Contents    = 0,
    DispFlags   = 0,
    Entity      = Entity(0),
    Fraction    = 1,
    FractionLeftSolid = 0,
    Hit         = false,
    HitBox      = 0,
    HitGroup    = 0,
    HitNoDraw   = false,
    HitNonWorld = false,
    HitNormal   = Vector(0,0,0),
    HitPos      = Vector(0,0,0),
    HitSky      = false,
    HitTexture  = "**empty**",
    HitWorld    = false,
    MatType     = 0,
    Normal      = Vector(0,0,0),
    PhysicsBone = 0,
    StartPos    = Vector(0,0,0),
    StartSolid  = false,
    SurfaceFlags = 0,
    SurfaceProps = 0,
}

local traceDataTbl = {
    start = Vector(0,0,0),
    endpos = Vector(0,0,0),
    mask = MASK_SOLID,
    collisiongroup = COLLISION_GROUP_NONE,
    ignoreworld = false,
    whitelist = true,
    filter = { "player", "gmod_track_udochka" },
    output = traceResultTbl
}

function ENT:CheckContact(pos,dir,id,cpos)
    traceDataTbl.start = self:LocalToWorld(pos + dir)
    traceDataTbl.endpos = self:LocalToWorld(cpos + Vector(0,0,-10))
    local result = util.TraceLine(traceDataTbl)

    -- Draw traceline
    -- debugoverlay.Text(traceDataTbl.start, "START", 0.25, false)
    -- debugoverlay.Text(traceDataTbl.endpos, "END", 0.25, false)
    -- debugoverlay.Line(traceDataTbl.start, traceDataTbl.endpos, 0.25, Color(255,127,0), true)
    -- if (result.Hit) then
    --     debugoverlay.Text(result.HitPos, Format("HIT (f:%0.2f)", result.Fraction), 0.25, false)
    --     debugoverlay.Sphere(result.HitPos, 0.5, 0.25, Color(0,255,0), true)
    -- end

    if not result.Hit then return false end
    if result.HitWorld then return true end

    local traceEnt = result.Entity
    local entClass = traceEnt:GetClass()
    if entClass == "gmod_track_udochka" then
        if not self.Connectors[id] and not traceEnt.Timer and traceEnt.CoupledWith ~= self then
            --local vec = Vector(pos.y < 0 and 1 or 1.1,pos.y < 0 and -1 or 1.05, 1)
            traceEnt:SetPos(self:LocalToWorld(cpos))
            traceEnt:SetAngles(self:GetAngles())
            if IsValid(constraint.Weld(self,traceEnt,0,0,33000,true,false)) then
                traceEnt:SetPos(self:LocalToWorld(cpos))
                traceEnt:SetAngles(self:GetAngles())
                traceEnt.Coupled = self
                traceEnt.ConnectorID = id
                sound.Play("udochka_connect.wav",traceEnt:GetPos())
                self.Connectors[id] = traceEnt
                DropEntityIfHeld(traceEnt)
            end
        end
        return false
    elseif entClass == "player" then
        if self.Voltage > 40 then
            local pPos = traceEnt:GetPos()
            self.VoltageDropByTouch = (self.VoltageDropByTouch or 0) + 1
            util.BlastDamage(traceEnt,traceEnt,pPos,64,3.0*self.Voltage)

            local effectdata = EffectData()
            effectdata:SetOrigin(pPos + Vector(0,0,-16+math.random()*(40+0)))
            util.Effect("cball_explode",effectdata,true,true)
            sound.Play("ambient/energy/zap"..math.random(1,3)..".wav",pPos,75,math.random(100,150),1.0)
        end
        return false
    end

    return true
end

local C_Require3rdRail = GetConVar("metrostroi_train_requirethirdrail")

function ENT:CheckVoltage(dT)
    -- Check contact states
    if (CurTime() - self.CheckTimeout) <= 0.25 then return end
    self.CheckTimeout = CurTime()
    local supported = C_Require3rdRail:GetInt() > 0 and Metrostroi.MapHasFullSupport()
    local feeder = self.Feeder and Metrostroi.Voltages[self.Feeder]
    local contacts = not self.DisableContacts and not self.DisableContactsManual
    local volt = contacts and (feeder or Metrostroi.Voltage or 750) or 0

    -- Non-metrostroi maps
    if not supported then
        self.Voltage = volt
        self.NextStates[1] = contacts
        self.NextStates[2] = contacts
        self.ContactStates = self.NextStates 
        return
    end

    self.VoltageDropByTouch = 0
    self.NextStates[1] = contacts and self:CheckContact(self.PantLPos,Vector(0,-10,0),1,self.PantLCPos)
    self.NextStates[2] = contacts and self:CheckContact(self.PantRPos,Vector(0, 10,0),2,self.PantRCPos)

    -- Detect changes in contact states
    for i=1,2 do
        local state = self.NextStates[i]
        if state ~= self.ContactStates[i] then
            self.ContactStates[i] = state
            if not state then continue end
            
            net.Start("metrostroi_bogey_contact")
                net.WriteEntity(self) -- Bogey
                net.WriteUInt(i-1,1) -- PantNum
                net.WriteVector(i == 1 and self.PantLPos or self.PantRPos) -- PantPos
                net.WriteUInt((math.random() > math.Clamp(1-(self.MotorPower/2),0,1)) and 1 or 0,1) -- Sparking probability
            net.Broadcast()
        end
    end

    -- Voltage spikes
    self.VoltageDrop = math.max(-30,math.min(30,self.VoltageDrop + (0 - self.VoltageDrop)*10*dT))

    -- Detect voltage
    self.Voltage = 0
    self.DropByPeople = 0
    for i=1,2 do
        if self.ContactStates[i] then
            self.Voltage = volt + self.VoltageDrop
        elseif IsValid(self.Connectors[i]) and self.Connectors[i].Coupled == self then
            self.Voltage = self.Connectors[i].Power and Metrostroi.Voltage or 0
        end
    end
    if self.VoltageDropByTouch > 0 then
        local Rperson = 0.613
        local Iperson = Metrostroi.Voltage / (Rperson/(self.VoltageDropByTouch + 1e-9))
        self.DropByPeople = Iperson
    end
end

function ENT:Think()
    -- Re-initialize wheels
    if not IsValid(self.Wheels) or self.Wheels:GetNW2Entity("TrainBogey") ~= self then
        self:InitializeWheels()

        constraint.NoCollide(self.Wheels,self,0,0)
        if IsValid(self:GetNW2Entity("TrainEntity")) then
            constraint.NoCollide(self.Wheels,self:GetNW2Entity("TrainEntity"),0,0)
        end
    end

    -- Update timing
    self.PrevTime = self.PrevTime or CurTime()
    self.DeltaTime = (CurTime() - self.PrevTime)
    self.PrevTime = CurTime()

    self:SetNW2Entity("TrainWheels",self.Wheels)
    self:CheckVoltage(self.DeltaTime)

    -- Skip physics related stuff
    if self.NoPhysics or not self.Wheels.PhysObj:IsValid() then
        self:SetMotorPower(self.MotorPower or 0)
        self:SetSpeed(self.Speed or 0)
        self:NextThink(CurTime())
        return true
    end

    local physObj = self.PhysObj
    local ang = self:GetAngles()
    local angForward = ang:Forward()
    local angRight = ang:Right()
    local vel = self:GetVelocity()

    -- Get speed of bogey in km/h
    local localSpeed = -vel:Dot(angForward) * 0.06858
    local absSpeed = math.abs(localSpeed)
    if self.Reversed then localSpeed = -localSpeed end

    local sign = 1
    if localSpeed < 0 then sign = -1 end
    self.Speed = absSpeed
    self.SpeedSign = self.Reversed and -sign or sign

    -- Calculate acceleration in m/s
    self.Acceleration = 0.277778*(self.Speed - (self.PrevSpeed or 0)) / self.DeltaTime
    self.PrevSpeed = self.Speed

    -- Add variables to debugger
    self.Variables["Speed"] = self.Speed
    self.Variables["Acceleration"] = self.Acceleration

    -- Calculate motor power
    local motorPower = 0.0
    if self.MotorPower > 0.0 then
        motorPower = math.Clamp(self.MotorPower, -1, 1)
    else
        motorPower = math.Clamp(self.MotorPower*sign, -1, 1)
    end
    -- Increace forces on slopes
    local slopemul = 1
    local pitch = ang.pitch*sign
    if motorPower < 0 and pitch > 3 then
        slopemul = slopemul + math.Clamp((math.abs(pitch)-3)/3,0,1)
    else
        slopemul = slopemul + math.Clamp((pitch-3)/3,0,1)*1.5
    end

    -- Final brake cylinder pressure
    local pneumaticPow = self.PneumaticPow or 1
    local pB = not self.DisableParking and self.ParkingBrakePressure or 0
    local BrakeCP = (((self.BrakeCylinderPressure/2.7+pB/1.6)^pneumaticPow)*2.7)/4.5-- + (self.ParkingBrake and 1 or 0)
    if (BrakeCP*4.5 > 1.5-math.Clamp(math.abs(pitch)/1,0,1)) and (absSpeed < 1) then
        self.Wheels.PhysObj:SetMaterial("gmod_silent")
    else
        self.Wheels.PhysObj:SetMaterial("gmod_ice")
    end

    -- Calculate forces
    local motorForce = self.MotorForce*motorPower*slopemul
    local pneumaticFactor = math.Clamp(0.5*self.Speed,0,1)*(1+math.Clamp((2-self.Speed)/2,0,1)*0.5)
    local pneumaticForce = 0
    if BrakeCP >= 0.05 then
        local slopemulBr = 1
        if -3 > pitch or pitch > 3 then
            slopemulBr = 1 + math.Clamp((math.abs(pitch)-3)/3,0,1)*0.7
        end
        pneumaticForce = -sign*pneumaticFactor*self.PneumaticBrakeForce*BrakeCP*slopemulBr
    end

    -- Compensate forward friction
    local compensateA = self.Speed / 86
    local compensateF = sign * self.Mass * compensateA
    -- Apply sideways friction
    local sideSpeed = -vel:Dot(angRight) * 0.06858
    if sideSpeed < 0.5 then sideSpeed = 0 end
    local sideForce = sideSpeed * 0.5 * self.Mass

    -- Apply force
    local dt_scale = 66.6/(1/self.DeltaTime)
    --print(pneumaticForce)
    local force = dt_scale*(motorForce + pneumaticForce + compensateF)

    local side_force = dt_scale*(sideForce)

    if self.Reversed then
        physObj:ApplyForceCenter( angForward*force + angRight*side_force)
    else
        physObj:ApplyForceCenter(-angForward*force + angRight*side_force)
    end

    -- Apply Z axis damping
    local avel = physObj:GetAngleVelocity()
    local avelz = math.min(20,math.max(-20,avel.z))
    local damping = Vector(0,0,-avelz) * 0.75 * dt_scale
    physObj:AddAngleVelocity(damping)

    -- Calculate brake squeal
    self.SquealSensitivity = 1
    local BCPress = math.abs(self.BrakeCylinderPressure)
    self.RattleRandom = self.RattleRandom or 0.5+math.random()*0.2
    local PnF1 = math.Clamp((BCPress-0.6)/0.6,0,2)
    local PnF2 = math.Clamp((BCPress-self.RattleRandom)/0.6,0,2)
    local brakeSqueal = (PnF1*PnF2)*pneumaticFactor

    --local brakeSqueal2 = (PnF1*PnF3)*pneumaticFactor
    -- Send parameters to client
    if self.DisableSound < 1 then
        self:SetMotorPower(motorPower)
    end

    if self.DisableSound < 2 then
        self:SetNW2Int("BrakeSqueal",(self:GetNWBool("Async") and (self.BrakeCylinderPressure-0.9)/1.7 or brakeSqueal)*20)
    end
    if self.DisableSound < 3 then
        self:SetSpeed(absSpeed)
    end

    -- Trigger outputs
    if Wire_TriggerOutput then
        Wire_TriggerOutput(self, "Speed", absSpeed)
        Wire_TriggerOutput(self, "Voltage", self.Voltage)
        Wire_TriggerOutput(self, "BrakeCylinderPressure", self.BrakeCylinderPressure)
    end
    
    self:NextThink(CurTime())
    return true
end



--------------------------------------------------------------------------------
-- Default spawn function
--------------------------------------------------------------------------------
function ENT:SpawnFunction(ply, tr)
    local verticaloffset = 40 -- Offset for the train model, gmod seems to add z by default, nvm its you adding 170 :V
    local distancecap = 2000 -- When to ignore hitpos and spawn at set distanace
    local pos, ang = nil
    local inhibitrerail = false

    if tr.Hit then
        -- Setup trace to find out of this is a track
        local tracesetup = {}
        tracesetup.start=tr.HitPos
        tracesetup.endpos=tr.HitPos+tr.HitNormal*80
        tracesetup.filter=ply

        local tracedata = util.TraceLine(tracesetup)

        if tracedata.Hit then
            -- Trackspawn
            pos = (tr.HitPos + tracedata.HitPos)/2 + Vector(0,0,verticaloffset)
            ang = tracedata.HitNormal
            ang:Rotate(Angle(0,90,0))
            ang = ang:Angle()
            -- Bit ugly because Rotate() messes with the orthogonal vector | Orthogonal? I wrote "origional?!" :V
        else
            -- Regular spawn
            if tr.HitPos:Distance(tr.StartPos) > distancecap then
                -- Spawnpos is far away, put it at distancecap instead
                pos = tr.StartPos + tr.Normal * distancecap
                inhibitrerail = true
            else
                -- Spawn is near
                pos = tr.HitPos + tr.HitNormal * verticaloffset
            end
            ang = Angle(0,tr.Normal:Angle().y,0)
        end
    else
        -- Trace didn't hit anything, spawn at distancecap
        pos = tr.StartPos + tr.Normal * distancecap
        ang = Angle(0,tr.Normal:Angle().y,0)
    end

    local ent = ents.Create(self.ClassName)
    ent:SetPos(pos)
    ent:SetAngles(ang)
    ent:Spawn()
    ent:Activate()

    if not inhibitrerail then Metrostroi.RerailBogey(ent) end
    return ent
end

function ENT:AcceptInput(inputName, activator, called, data)
    if inputName == "OnFeederIn" then
        self.Feeder = tonumber(data)
        if self.Feeder and not Metrostroi.Voltages[self.Feeder] then
            Metrostroi.Voltages[self.Feeder] = 0
            Metrostroi.Currents[self.Feeder] = 0
        end
    elseif inputName == "OnFeederOut" then
        self.Feeder = nil
    end
end

Metrostroi.OptimisationPatch()
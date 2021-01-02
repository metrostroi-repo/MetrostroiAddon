--92 ЮНИТА РАССТОЯНИЕ МЕЖДУ СЦЕПКОЙ И ПЕРВОЙ КОЛПАРОЙ

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local DECOUPLE_TIMEOUT      = 2     -- Time after decoupling furing wich a bogey cannot couple
local COUPLE_MAX_DISTANCE   = 20    -- Maximum distance between couple offsets
local COUPLE_MAX_ANGLE      = 18    -- Maximum angle between bogeys on couple


--------------------------------------------------------------------------------
COUPLE_MAX_DISTANCE = COUPLE_MAX_DISTANCE ^ 2
COUPLE_MAX_ANGLE = math.cos(math.rad(COUPLE_MAX_ANGLE))

--------------------------------------------------------------------------------
--[[ function ENT:PreEntityCopy()
    local BogeyDupe = {}
    if IsValid(self.Wheels) then
        BogeyDupe.Wheels = self.Wheels:EntIndex()
    end
    BogeyDupe.BogeyType = self.BogeyType
    if WireAddon then
        BogeyDupe.WireData = WireLib.BuildDupeInfo( self.Entity )
    end
    BogeyDupe.NoPhysics = self.NoPhysics


    duplicator.StoreEntityModifier(self, "BogeyDupe", BogeyDupe)
end
duplicator.RegisterEntityModifier( "BogeyDupe" , function() end)
--Model,WheelPos,WheelAng,WheelModel,PantLPos,PantRPos,BogeyOffset,{ConnectorPositions}--]]
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
--[[ function ENT:PostEntityPaste(ply,ent,createdEntities)
    local BogeyDupe = ent.EntityMods.BogeyDupe
    if IsValid(self.Wheels) then
        self.Wheels:SetParent()
        self.Wheels:Remove()
    end
    self.Wheels = createdEntities[BogeyDupe.Wheels]
    self.BogeyType = BogeyDupe.BogeyType
    local typ = self.Types[self.BogeyType or "717"]
    self:SetModel(typ and typ[1] or "models/metrostroi/metro/metro_bogey.mdl")
    if IsValid(self.Wheels) then
        if self.BogeyType == "tatra" then
            self.Wheels:SetPos(self:LocalToWorld(Vector(0,0.0,-3)))
            self.Wheels:SetAngles(self:GetAngles() + Angle(0,0,0))
        else
            self.Wheels:SetPos(self:LocalToWorld(Vector(0,0.0,-10)))
            self.Wheels:SetAngles(self:GetAngles() + Angle(0,90,0))
        end
        self.Wheels.WheelType = self.BogeyType
        self.Wheels.NoPhysics = BogeyDupe.NoPhysics

        if self.NoPhysics then
            self.Wheels:SetParent(self)
        else
            self.Wheels:PhysicsInit(SOLID_VPHYSICS)
            self.Wheels:SetMoveType(MOVETYPE_VPHYSICS)
            self.Wheels:SetSolid(SOLID_VPHYSICS)
            constraint.Weld(self,self.Wheels,0,0,0,1,0)
        end
        if CPPI then self.Wheels:CPPISetOwner(self:CPPIGetOwner()) end
        self.Wheels:SetNW2Entity("TrainBogey",self)
    end
end--]]

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
        self:GetPhysicsObject():SetMass(5000)
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

    self.Angle = 0

    self.Variables = {}

    -- Pressure in brake cylinder
    self.BrakeCylinderPressure = 0.0 -- atm

    self.Voltage = 0
    self.VoltageDrop = 0
    self.DropByPeople = 0
    self.PlayTime = { 0, 0 }
    self.ContactStates = { false, false }
    self.ContactDisables = {false,false}
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
    if not IsValid(self.Wheels) then
        --print(1)
        local wheels = ents.Create("gmod_train_wheels")
        local typ = self.Types[self.BogeyType or "717"]
        wheels.Model = typ[4]
        if typ and typ[3] then wheels:SetAngles(self:LocalToWorldAngles(typ[3])) end
        if typ and typ[2] then wheels:SetPos(self:LocalToWorld(typ[2])) end

        --wheels = ents.Create("gmod_subway_wheels")
        --wheels:SetPos(self:LocalToWorld(Vector(0,0.0,-10)))
        --wheels:SetAngles(self:GetAngles() + Angle(0,90,0))
        wheels.WheelType = self.BogeyType
        wheels.NoPhysics = self.NoPhysics
        wheels:Spawn()

        if self.NoPhysics then
            wheels:SetParent(self)
        else
            constraint.Weld(self,wheels,0,0,0,1,0)
        end
        if CPPI then wheels:CPPISetOwner(self:CPPIGetOwner() or self:GetNW2Entity("TrainEntity"):GetOwner()) end
        wheels:SetNW2Entity("TrainBogey",self)
        self.Wheels = wheels
    end
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

-- Checks if there's an advballsocket between two entities
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
end

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

local function AreInCoupleDistance(ent,self)
    return self:LocalToWorld(self.CouplingPointOffset):DistToSqr(ent:LocalToWorld(ent.CouplingPointOffset)) < COUPLE_MAX_DISTANCE
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
    if not (ent1.CanCouple and ent1:CanCouple()) then return false end
    if not (ent2.CanCouple and ent2:CanCouple()) then return false end
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

function ENT:CheckContact(pos,dir,id,cpos)
    local result = util.TraceHull({
        start = self:LocalToWorld(pos),
        endpos = self:LocalToWorld(pos + dir*10),
        mask = -1,
        filter = { self:GetNW2Entity("TrainEntity"), self },
        mins = Vector( -2, -2, -2 ),
        maxs = Vector( 2, 2, 2 )
    })

    if not result.Hit then return end
    if result.HitWorld then return true end
    local traceEnt = result.Entity
    if result.Entity:GetClass() == "gmod_track_udochka" then
        if not traceEnt.Timer and traceEnt.CoupledWith ~= self then
            --local vec = Vector(pos.y < 0 and 1 or 1.1,pos.y < 0 and -1 or 1.05, 1)
            traceEnt:SetPos(self:LocalToWorld(cpos))
            traceEnt:SetAngles(self:GetAngles())
            if IsValid(constraint.Weld(self,traceEnt,0,0,33000,true,false)) then
                traceEnt:SetPos(self:LocalToWorld(cpos))
                traceEnt:SetAngles(self:GetAngles())
                traceEnt.Coupled = self
                sound.Play("udochka_connect.wav",traceEnt:GetPos())
                self.Connectors[id] = traceEnt
                timer.Simple(0,function()
                    if IsValid(traceEnt) and traceEnt:IsPlayerHolding()  then
                        traceEnt:ForcePlayerDrop()
                        if traceEnt.LastPickup and traceEnt.LastPickup:IsPlayer()  then
                            traceEnt.LastPickup:DropObject()
                        end
                    end
                end)
            end
        end
        return false
    elseif traceEnt:GetClass() == "player" then
        --self.T:WorldToLocal(Entity(3208):GetPos())
        if self.Voltage < 40 then return end
        local pos = traceEnt:GetPos()
        self.VoltageDropByTouch = (self.VoltageDropByTouch or 0) + 1
        util.BlastDamage(traceEnt,traceEnt,pos,64,3.0*self.Voltage)

        local effectdata = EffectData()
        effectdata:SetOrigin(pos + Vector(0,0,-16+math.random()*(40+0)))
        util.Effect("cball_explode",effectdata,true,true)
        sound.Play("ambient/energy/zap"..math.random(1,3)..".wav",pos,75,math.random(100,150),1.0)
        return
    end
    return result.Hit
end

function ENT:CheckVoltage(dT)
    -- Check contact states
    if (CurTime() - self.CheckTimeout) > 0.25 then
        self.CheckTimeout = CurTime()
        self.VoltageDropByTouch = 0
        self.NextStates[1] = not self.DisableContacts and not self.DisableContactsManual and not self.ContactDisables[1] and self:CheckContact(self.PantLPos,Vector(0,-1,0),1,self.PantLCPos)
        self.NextStates[2] = not self.DisableContacts and not self.DisableContactsManual and not self.ContactDisables[2] and self:CheckContact(self.PantRPos,Vector(0, 1,0),2,self.PantRCPos)
        -- Detect changes in contact states
        for i=1,2 do
            local state = self.NextStates[i]
            if state ~= self.ContactStates[i] then
                self.ContactStates[i] = state

                if state then
                    self.VoltageDrop = -40*(0.5 + 0.5*math.random())

                    local dt = CurTime() - self.PlayTime[i]
                    self.PlayTime[i] = CurTime()

                    local volume = 0.53
                    if dt < 1.0 then volume = 0.43 end
                    if i == 1 then sound.Play("subway_trains/bogey/tr_"..math.random(1,5)..".wav",self:LocalToWorld(self.PantLPos),65,math.random(90,120),volume) end
                    if i == 2 then sound.Play("subway_trains/bogey/tr_"..math.random(1,5)..".wav",self:LocalToWorld(self.PantRPos),65,math.random(90,120),volume) end

                    -- Sparking probability
                    local probability = math.Clamp(1-(self.MotorPower/2),0,1)
                    if state and (math.random() > probability) then
                        local effectdata = EffectData()
                        if i == 1 then effectdata:SetOrigin(self:LocalToWorld(self.PantLPos)) end
                        if i == 2 then effectdata:SetOrigin(self:LocalToWorld(self.PantRPos)) end
                        effectdata:SetNormal(Vector(0,0,-1))
                        util.Effect("stunstickimpact", effectdata, true, true)

                        local light = ents.Create("light_dynamic")
                        light:SetPos(effectdata:GetOrigin())
                        light:SetKeyValue("_light","100 220 255")
                        light:SetKeyValue("style", 0)
                        light:SetKeyValue("distance", 256)
                        light:SetKeyValue("brightness", 5)
                        light:Spawn()
                        light:Fire("TurnOn","","0")
                        light.Time = CurTime()
                        hook.Add("Think",light,function(self)
                            if CurTime()-self.Time > 0.1 then self:Remove() end
                        end)
                        sound.Play("subway_trains/bogey/spark.mp3",effectdata:GetOrigin(),75,math.random(100,150),volume)
                        --self.Train:PlayOnce("zap",sound_source,0.7*volume,50+math.random(90,120))
                    end
                end
            end
        end
    end

    -- Voltage spikes
    self.VoltageDrop = math.max(-30,math.min(30,self.VoltageDrop + (0 - self.VoltageDrop)*10*dT))

    local feeder = self.Feeder and Metrostroi.Voltages[self.Feeder]
    local volt = feeder or Metrostroi.Voltage or 750
    -- Non-metrostroi maps
    if ((GetConVarNumber("metrostroi_train_requirethirdrail") <= 0)) then-- or
       --(not Metrostroi.MapHasFullSupport()) then
        self.Voltage = volt + self.VoltageDrop
        return
    end
    -- Detect voltage
    self.Voltage = 0
    self.DropByPeople = 0
    for i=1,2 do
        if self.ContactStates[i] then self.Voltage = volt + self.VoltageDrop
        elseif IsValid(self.Connectors[i]) and self.Connectors[i].Coupled == (i >  2 and self.Train.RearBogey or self) then
            self.Voltage = self.Connectors[i].Power and Metrostroi.Voltage or 0
        else self.Connectors[i] = nil end
    end
    if self.VoltageDropByTouch > 0 then
        local Rperson = 0.613
        local Iperson = Metrostroi.Voltage / (Rperson/(self.VoltageDropByTouch + 1e-9))
        self.DropByPeople = Iperson
    end
end

function ENT:Think()
    -- Re-initialize wheels
    if (not self.Wheels) or
        (not self.Wheels:IsValid()) or
        (self.Wheels:GetNW2Entity("TrainBogey") ~= self) then
        self:InitializeWheels()

        if IsValid(self:GetNW2Entity("TrainEntity")) then
            constraint.NoCollide(self.Wheels,self:GetNW2Entity("TrainEntity"),0,0)
            constraint.NoCollide(self.Wheels,self,0,0)
        end
    end

    -- Update timing
    self.PrevTime = self.PrevTime or CurTime()
    self.DeltaTime = (CurTime() - self.PrevTime)
    self.PrevTime = CurTime()
    self.Angle = self.Wheels.Angle

    self:SetNW2Entity("TrainWheels",self.Wheels)
    self:CheckVoltage(self.DeltaTime)

    -- Skip physics related stuff
    if not IsValid(self.Wheels) or not self.Wheels:GetPhysicsObject():IsValid() or self.NoPhysics then
        self:SetMotorPower(self.MotorPower or 0)
        self:SetSpeed(self.Speed or 0)
        self:NextThink(CurTime())
        return true
    end

    -- Get speed of bogey in km/h
    local localSpeed = -self:GetVelocity():Dot(self:GetAngles():Forward()) * 0.06858
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
        motorPower = self.MotorPower
    else
        motorPower = self.MotorPower*sign
    end
    motorPower = math.max(-1.0,motorPower)
    motorPower = math.min(1.0,motorPower)
    -- Increace forces on slopes
    local slopemul = 1--+math.Clamp(Train:GetAngles():Forward(),0,1)*0.2
    local slopemulb = 1
    local pitch = self:GetAngles().pitch*sign
    if motorPower < 0 and pitch > 3 then
        slopemul = slopemul + math.Clamp((math.abs(pitch)-3)/3,0,1)--[[ *(math.Clamp((self.Speed-55)/5,0,1))--]] *1.5
    else
        slopemul = slopemul + math.Clamp((pitch-3)/3,0,1)*1.5
    end
    if -3 > pitch or pitch > 3 then
        slopemulb = slopemulb + math.Clamp((math.abs(pitch)-3)/3,0,1)*0.7
    end
    -- Final brake cylinder pressure
    local pneumaticPow = self.PneumaticPow or 1
    local pB = not self.DisableParking and self.ParkingBrakePressure or 0
    local BrakeCP = (((self.BrakeCylinderPressure/2.7+pB/1.6)^pneumaticPow)*2.7)/4.5-- + (self.ParkingBrake and 1 or 0)
    if (BrakeCP*4.5 > 1.5-math.Clamp(math.abs(pitch)/1,0,1)) and (absSpeed < 1) then
        self.Wheels:GetPhysicsObject():SetMaterial("gmod_silent")
    else
        self.Wheels:GetPhysicsObject():SetMaterial("gmod_ice")
    end

    -- Calculate forces
    local motorForce = self.MotorForce*motorPower*slopemul
    local pneumaticFactor = math.max(0,math.min(1,0.5*self.Speed))*(1+(math.max(0,math.min(1,(2-self.Speed)/2)))*0.5)
    local pneumaticForce = 0
    if BrakeCP >= 0.05 then
        pneumaticForce = -sign*pneumaticFactor*self.PneumaticBrakeForce*BrakeCP*slopemulb
    end

    -- Compensate forward friction
    local compensateA = self.Speed / 86
    local compensateF = sign * self:GetPhysicsObject():GetMass() * compensateA
    -- Apply sideways friction
    local sideSpeed = -self:GetVelocity():Dot(self:GetAngles():Right()) * 0.06858
    if sideSpeed < 0.5 then sideSpeed = 0 end
    local sideForce = sideSpeed * 0.5 * self:GetPhysicsObject():GetMass()

    -- Apply force
    local dt_scale = 66.6/(1/self.DeltaTime)
    --print(pneumaticForce)
    local force = dt_scale*(motorForce + pneumaticForce + compensateF)

    local side_force = dt_scale*(sideForce)

    if self.Reversed then
        self:GetPhysicsObject():ApplyForceCenter( self:GetAngles():Forward()*force + self:GetAngles():Right()*side_force)
    else
        self:GetPhysicsObject():ApplyForceCenter(-self:GetAngles():Forward()*force + self:GetAngles():Right()*side_force)
    end

    -- Apply Z axis damping
    local avel = self:GetPhysicsObject():GetAngleVelocity()
    local avelz = math.min(20,math.max(-20,avel.z))
    local damping = Vector(0,0,-avelz) * 0.75 * dt_scale
    self:GetPhysicsObject():AddAngleVelocity(damping)

    -- Calculate brake squeal
    self.SquealSensitivity = 1
    local k = ((self.SquealSensitivity or 0.5) - 0.5)*2
    local BCPress = math.abs(self.BrakeCylinderPressure)
    self.RattleRandom = self.RattleRandom or 0.5+math.random()*0.2
    local PnF1 = math.Clamp((BCPress-0.6)/0.6,0,2)
    local PnF2 = math.Clamp((BCPress-self.RattleRandom)/0.6,0,2)
    --local PnF3 = math.Clamp((BCPress-self.RattleRandom+0.15)/0.6,0,1)
    local brakeSqueal1 = (PnF1*PnF2)*pneumaticFactor
    --local brakeSqueal2 = (PnF1*PnF3)*pneumaticFactor
    -- Send parameters to client
    if self.DisableSound < 1 then
        self:SetMotorPower(motorPower)
    end

    if self.DisableSound < 2 then
        local brakeRamp = math.min(1.0,math.max(0.0,self.Speed/2.0))
        if self.Speed > 2 then
            --brakeRamp = 1 - math.min(1.0,math.max(0.0,(self.Speed-3)/10.0))
        end
    --  if brakeRamp > 0.01 and brakeSqueal > 0 then
        if self:GetNWBool("Async") then
            local bcP = self.BrakeCylinderPressure
            self:SetNW2Float("BrakeSqueal",(bcP-0.9)/1.7)--3/(absSpeed+bcP^3)*(bcP^3)*0.5)
        else
            self:SetNW2Float("BrakeSqueal1",brakeSqueal1)
            --self:SetNW2Float("BrakeSqueal2",brakeSqueal2)
        end
        --self:SetBrakeSqueal(self.BrakeSqueal or brakeSqueal)
--      end
    end
    if self.DisableSound < 3 then
        self:SetSpeed(absSpeed)
    end
    self:NextThink(CurTime())

    -- Trigger outputs
    if Wire_TriggerOutput then
        Wire_TriggerOutput(self, "Speed", absSpeed)
        Wire_TriggerOutput(self, "Voltage", self.Voltage)
        Wire_TriggerOutput(self, "BrakeCylinderPressure", self.BrakeCylinderPressure)
    end
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
--92 ЮНИТА РАССТОЯНИЕ МЕЖДУ СЦЕПКОЙ И ПЕРВОЙ КОЛПАРОЙ

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local DECOUPLE_TIMEOUT      = 2     -- Time after decoupling furing wich a Coupler cannot couple
local COUPLE_MAX_DISTANCE   = 20    -- Maximum distance between couple offsets
local COUPLE_MAX_ANGLE      = 18    -- Maximum angle between Couplers on couple

--------------------------------------------------------------------------------
COUPLE_MAX_DISTANCE = COUPLE_MAX_DISTANCE ^ 2
COUPLE_MAX_ANGLE = math.cos(math.rad(COUPLE_MAX_ANGLE))
--Model,Couple pos,Snake pos,Snake ang
ENT.Types = {
    ["717"] = {"models/metrostroi_train/bogey/metro_couple_717.mdl",Vector(65,0,0),Vector(65.1,1,-4.9),Angle(0,-90,0)},
    ["702"] = {"models/metrostroi_train/bogey/metro_couple_ezh.mdl",Vector(65,0,0),Vector(65.1,1,-4.9),Angle(0,-90,0)},
    ["722"] = {"models/metrostroi_train/bogey/metro_couple_noekk.mdl",Vector(65,0,0),Vector(65.1,1,-4.9),Angle(0,-90,0)},
    def={"models/metrostroi_train/bogey/metro_couple_717.mdl",Vector(65,0,0),Vector(65.25,0,6.5),Angle(0,90,0)},
}

function ENT:SetParameters()
    local typ = self.Types[self.CoupleType or "def"]
    self:SetModel(typ and typ[1] or "models/metrostroi_train/bogey/metro_couple.mdl")
    self.CouplingPointOffset = typ and typ[2] or Vector(65,0,0)
    self.SnakePos = typ and typ[3] or Vector(65,0,0)
    self.SnakeAng = typ and typ[4] or Angle(180,90,0)
end

function ENT:Initialize()
    self:SetParameters()
    if not self.NoPhysics then
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
    end
    self:SetUseType(SIMPLE_USE)

    -- Set proper parameters for the Coupler
    if IsValid(self:GetPhysicsObject()) then
        self:GetPhysicsObject():SetMass(5000)
    end
end


function ENT:OnRemove()
    if self.CoupledEnt ~= nil then
        self:Decouple()
    end
end
local function AreCoupled(ent1,ent2)
    if ent1.Coupled or ent2.Coupled then return false end
    local constrainttable = constraint.FindConstraints(ent1,"Weld")
    local coupled = false
    for k,v in pairs(constrainttable) do
        if v.Type == "Weld" then
            if( (v.Ent1 == ent1 or v.Ent1 == ent2) and (v.Ent2 == ent1 or v.Ent2 == ent2)) then
                coupled = true
            end
        end
    end

    return coupled
end

-- Adv ballsockets ents by their CouplingPointOffset
function ENT:Couple(ent)
    local strain = self:GetNW2Entity("TrainEntity")
    local etrain = ent:GetNW2Entity("TrainEntity")
    if IsValid(strain) then
        --self:SetPos(strain:LocalToWorld(self.SpawnPos))
        self:SetAngles(strain:LocalToWorldAngles(self.SpawnAng))
    end
    if IsValid(etrain) then
        --ent:SetPos(etrain:LocalToWorld(ent.SpawnPos))
        ent:SetAngles(etrain:LocalToWorldAngles(ent.SpawnAng))
    end
    ent:SetPos(self:LocalToWorld(self.CouplingPointOffset*Vector(2,-1,-1)))
    ent:SetAngles(self:LocalToWorldAngles(Angle(0,180,0)))
    self:SetPos(ent:LocalToWorld(ent.CouplingPointOffset*Vector(2,-1,-1)))
    self:SetAngles(ent:LocalToWorldAngles(Angle(0,180,0)))
    if IsValid(constraint.Weld(
        self,
        ent,
        0, --bone
        0, --bone
        --self.CouplingPointOffset,
        --ent.CouplingPointOffset,
        0 --forcelimit
        ----0, --torquelimit
        ---25, --xmin
        ---10, --ymin
        ---25, --zmin
        --25, --xmax
        --10, --ymax
        --25, --zmax
        --0, --xfric
        --0, --yfric
        --0, --zfric
        --0, --rotonly
        --1 --nocollide
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
    return ent1:GetForward():Dot(ent2:GetForward()) < - COUPLE_MAX_ANGLE
end

function ENT:IsInTimeOut()
    return (((self.DeCoupleTime or 0) + DECOUPLE_TIMEOUT) > CurTime())
end

function ENT:CanCouple()
    if self.CoupledEnt then return false end
    if self:IsInTimeOut() then return false end
    if not constraint.CanConstrain(self,0) then return false end
    return true
end

-- This feels so wrong, any ideas how to improve this?
local function CanCoupleTogether(ent1,ent2)
    if not (ent1.CanCouple and ent1:CanCouple()) then return false end
    if not (ent2.CanCouple and ent2:CanCouple()) then return false end
    if      ent2:GetClass() ~= ent1:GetClass() then return false end
    if not AreInCoupleDistance(ent1,ent2) then return false end
    if not AreFacingEachother(ent1,ent2) then return false end
    return true
end

-- Used the couple with other Couplers
function ENT:StartTouch(ent)
    if CanCoupleTogether(self,ent) then
        self:Couple(ent)
    end
end


util.AddNetworkString("metrostroi-coupler-menu")
-- Used to decouple
function ENT:Use(ply)
    local train = self:GetNW2Entity("TrainEntity")
    local isfront = self:GetNW2Bool("IsForwardCoupler")
    net.Start("metrostroi-coupler-menu")
        net.WriteEntity(self)
        net.WriteBool(not self.CPPICanUse or self:CPPICanUse(ply))
        net.WriteBool(self.CoupledEnt ~= nil)
        if IsValid(train) then
            if isfront and train.FrontBrakeLineIsolation and train.FrontTrainLineIsolation then
                net.WriteBool(true)
                net.WriteBool(train.FrontBrakeLineIsolation.Value>0 and train.FrontTrainLineIsolation.Value>0)
            elseif not isfront and train.RearBrakeLineIsolation and train.RearTrainLineIsolation then
                net.WriteBool(true)
                net.WriteBool(train.RearBrakeLineIsolation.Value>0 and train.RearTrainLineIsolation.Value>0)
            else
                net.WriteBool(false)
                net.WriteBool(false)
            end
        else
            net.WriteBool(false)
            net.WriteBool(false)
        end
        net.WriteBool(self.CoupleType=="722")
        net.WriteBool(self.EKKDisconnected)
    net.Send(ply)
    --[[ if self.CoupledEnt ~= nil then
        local tr = ply:GetEyeTrace()
        if not tr.Hit then return end
        if self:LocalToWorld(self.CouplingPointOffset):Distance(tr.HitPos) < 25 then
            self:Decouple()
        end
    end--]]
end

function ENT:ElectricDisconnected()
    if not IsValid(self.CoupledEnt) then return end
    return self.EKKDisconnected or self.CoupledEnt.EKKDisconnected
end

net.Receive("metrostroi-coupler-menu",function(_,ply)
    local bogey = net.ReadEntity()
    local train = bogey:GetNW2Entity("TrainEntity")
    local isfront = bogey:GetNW2Bool("IsForwardCoupler")

    if bogey.CPPICanUse and not bogey:CPPICanUse(ply) then return end
    local id = net.ReadUInt(8)
    if id==0 and bogey.CoupledEnt ~= nil then bogey:Decouple() end
    if id==1 then
        if not IsValid(train) then return end
        if isfront and train.FrontBrakeLineIsolation and train.FrontTrainLineIsolation then
            local state = train.FrontBrakeLineIsolation.Value>0 or train.FrontTrainLineIsolation.Value>0
            train.FrontBrakeLineIsolation:TriggerInput("Set",state and 0 or 1)
            train.FrontTrainLineIsolation:TriggerInput("Set",state and 0 or 1)
            if IsValid(train.FrontTrain)then
                local ftrain = train.FrontTrain
                if ftrain.RearTrain==train and train.RearBrakeLineIsolation and train.RearTrainLineIsolation then
                    ftrain.RearBrakeLineIsolation:TriggerInput("Set",state and 0 or 1)
                    ftrain.RearTrainLineIsolation:TriggerInput("Set",state and 0 or 1)
                elseif ftrain.FrontTrain==train and ftrain.FrontBrakeLineIsolation and ftrain.FrontTrainLineIsolation then
                    ftrain.FrontBrakeLineIsolation:TriggerInput("Set",state and 0 or 1)
                    ftrain.FrontTrainLineIsolation:TriggerInput("Set",state and 0 or 1)
                end
            end
        elseif not isfront and train.RearBrakeLineIsolation and train.RearTrainLineIsolation then
            local state = train.RearBrakeLineIsolation.Value>0 or train.RearTrainLineIsolation.Value>0
            train.RearBrakeLineIsolation:TriggerInput("Set",state and 0 or 1)
            train.RearTrainLineIsolation:TriggerInput("Set",state and 0 or 1)
            if IsValid(train.RearTrain)then
                local rtrain = train.RearTrain
                if rtrain.RearTrain==train and train.RearBrakeLineIsolation and train.RearTrainLineIsolation then
                    rtrain.RearBrakeLineIsolation:TriggerInput("Set",state and 0 or 1)
                    rtrain.RearTrainLineIsolation:TriggerInput("Set",state and 0 or 1)
                elseif rtrain.FrontTrain==train and rtrain.FrontBrakeLineIsolation and rtrain.FrontTrainLineIsolation then
                    rtrain.FrontBrakeLineIsolation:TriggerInput("Set",state and 0 or 1)
                    rtrain.FrontTrainLineIsolation:TriggerInput("Set",state and 0 or 1)
                end
            end
        end
    end
    if id==2 then
        bogey.EKKDisconnected = not bogey.EKKDisconnected
        if bogey.CoupledEnt ~= nil then
            bogey.CoupledEnt.EKKDisconnected = bogey.EKKDisconnected
            if IsValid(train) then train:OnConnectDisconnect() end
            local coupledTrain = bogey.CoupledEnt:GetNW2Entity("TrainEntity")
            if IsValid(coupledTrain) then coupledTrain:OnConnectDisconnect() end
        end
    end
end)

function ENT:ConnectDisconnect(status)
    local isfront = self:GetNW2Bool("IsForwardCoupler")
    local train = self:GetNW2Entity("TrainEntity")
    if IsValid(train) then
        if status ~= nil then
            if status then train:OnCouplerConnect(self, isfront) else train:OnCouplerDisconnect(self, isfront) end
        else
            if (train.FrontCoupledCouplerDisconnect and isfront) or (train.RearCoupledCouplerDisconnect and not isfront) then
                train:OnCouplerConnect(self, isfront)
                if IsValid(self.Coupled) then self.CoupledEnt:ConnectDisconnect(true) end
                return
            end
            if (not train.FrontCoupledCouplerDisconnect and isfront) or (not train.RearCoupledCouplerDisconnect and not isfront) then
                train:OnCouplerDisconnect(self, isfront)
                if IsValid(self.Coupled) then self.CoupledEnt:ConnectDisconnect(false) end
                return
            end
        end
    end
end

function ENT:GetConnectDisconnect()
    local isfront = self:GetNW2Bool("IsForwardCoupler")
    local train = self:GetNW2Entity("TrainEntity")
    if IsValid(train) then
        if (train.FrontCoupledCouplerDisconnect and isfront) or (train.RearCoupledCouplerDisconnect and not isfront) then
            return false
        end
        if (not train.FrontCoupledCouplerDisconnect and isfront) or (not train.RearCoupledCouplerDisconnect and not isfront) then
            return true
        end
    end
end

local function removeAdvBallSocketBetweenEnts(ent1,ent2)
    local constrainttable = constraint.FindConstraints(ent1,"Weld")
    for k,v in pairs(constrainttable) do
        if (v.Ent1 == ent1 or v.Ent1 == ent2) and (v.Ent2 == ent1 or v.Ent2 == ent2) then
            v.Constraint:Remove()
        end
    end
end

function ENT:Decouple()
    if IsValid(self.CoupledEnt) then
        sound.Play("buttons/lever8.wav",(self:GetPos()+self.CoupledEnt:GetPos())/2)
        removeAdvBallSocketBetweenEnts(self,self.CoupledEnt)
        self.CoupledEnt.CoupledEnt = nil
        self.CoupledEnt:Decouple()
    end
    self.CoupledEnt = nil

    -- Above this runs on initiator, below runs on both
    self.DeCoupleTime = CurTime()
    self:OnDecouple()
end


function ENT:OnCouple(ent)
    self.CoupledEnt = ent

    --Call OnCouple on our parent train as well
    local parent = self:GetNW2Entity("TrainEntity")
    local isforward = self:GetNW2Bool("IsForwardCoupler")
    if IsValid(parent) then
        parent:OnCouple(ent,isforward)
    end
    if self.OnCoupleSpawner then self:OnCoupleSpawner() end
end

function ENT:OnDecouple()
    --Call OnDecouple on our parent train as well
    local parent = self:GetNW2Entity("TrainEntity")
    local isforward = self:GetNW2Bool("IsForwardCoupler")

    if IsValid(parent) then
        parent:OnDecouple(isforward)
    end
end

function ENT:Think()
    self:NextThink(CurTime()+1)
    return true
end

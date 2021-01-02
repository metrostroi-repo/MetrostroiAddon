AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")



--------------------------------------------------------------------------------
function ENT:Initialize()
    self:SetModel("models/metrostroi_train/reversor/reversor_collection_box.mdl")
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then phys:Wake() end
    self.Owner._RevBlockSpawn = true
end

function ENT:OnRemove()
    -- Remove all linked objects
    constraint.RemoveAll(self)
    if IsValid(self.Cover) then
        SafeRemoveEntity(self.Cover)
    end
    self.Owner._RevBlockSpawn = false
end

function ENT:Use(_,ply)
    if ply~=self.Owner then return end
    if not self.Cover then
        self:SetModel(self.Code and "models/metrostroi_train/reversor/reversor_collection_box2.mdl" or "models/metrostroi_train/reversor/reversor_collection_box_empty.mdl")
        self.Cover = ents.Create("prop_physics")
        self.Cover:SetModel("models/metrostroi_train/reversor/reversor_collection_box2_cover.mdl")
        self.Cover:SetPos(self:LocalToWorld(Vector(0,0,5.7)))
        self.Cover:SetAngles(self:GetAngles())
        self.Cover:Spawn()
        self.Cover:SetOwner(self.Owner)
        local phys = self.Cover:GetPhysicsObject()
        phys:ApplyForceCenter(self.Cover:GetUp()*phys:GetMass()*40+self.Cover:GetRight()*phys:GetMass()*35 )
        if CPPI and IsValid(self.Owner) then
            self.Cover:CPPISetOwner(self.Owner)
        end
        if self.Code then self:SetNW2Int("Code",self.Code) end
    elseif self:GetModel() == "models/metrostroi_train/reversor/reversor_collection_box2.mdl" then
        ply:StripWeapon("train_kv_wrench")
        ply:Give("train_kv_wrench_gold")
        ply:SelectWeapon("train_kv_wrench_gold")
        local reverser = ply:GetWeapon("train_kv_wrench_gold")
        if IsValid(reverser) then
            reverser:SetCode(self.Code)
        end
        self:SetModel("models/metrostroi_train/reversor/reversor_collection_box_empty.mdl")
        self:SetNW2Int("Code",-1)
    end
end
function ENT:Think(dT)
end

function ENT:SpawnReverser(ent,code)
    if not code then
        ent.Owner:StripWeapon("train_kv_wrench_gold")
    end
    ent.Code = code
    ent:Spawn()
    ent:Activate()
end

function ENT:SpawnFunction(ply,tr,className)
    if not tr.Hit or ply.SpawningReverser or ply._RevBlockSpawn then return end
    ply.SpawningReverser = false

    local ent = ents.Create(className)

    local SpawnPos = tr.HitPos + tr.HitNormal * 10
    local SpawnAng = ply:EyeAngles()
    SpawnAng.p = 0
    SpawnAng.y = SpawnAng.y+90

    ent:SetPos( SpawnPos )
    ent:SetAngles( SpawnAng )

    ent.Owner = ply

    --ent.Code = code
    --ent:Spawn()
    --ent:Activate()

    Metrostroi.GetReverserID(ply,function(code)
        if not IsValid(ent) then return end
        ply.SpawningReverser = false
        self:SpawnReverser(ent,code)
    end,true)
    return ent
end
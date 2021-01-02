AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

SWEP.Weight             = 1
SWEP.AutoSwitchTo       = false
SWEP.AutoSwitchFrom     = true


function SWEP:Initialize()
end
function SWEP:SetCode(code)
    self.Code = code
    self:SetNW2Int("Code",code or 0)
    --print(Format("Your reverser wrench is %05d",self.Code or 0))
end
function SWEP:Equip(ply)
    local reverser = ply:GetWeapon("train_kv_wrench_gold")
    if IsValid(reverser) and not reverser.Removing then
        ply:StripWeapon("train_kv_wrench_gold")
    end
end
--[[
function SWEP:Holster()

    if CLIENT and IsValid(self.Owner) then
        local vm = self.Owner:GetViewModel()
        if IsValid(vm) then
            self:ResetBonePositions(vm)
        end
    end

    return true
end

function SWEP:OnRemove()
    self:Holster()
end
]]
function SWEP:Think()
end
function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire( CurTime()+0.5)
end

function SWEP:Reload()
    if self.LastCheck and CurTime()-self.LastCheck<1 then return end
    self.LastCheck = CurTime()
    local owner = self:GetOwner()
    local ID = Metrostroi.GetReverserID(owner,true)
    if ID then
        owner:Give("train_kv_wrench_gold")
        owner:SelectWeapon("train_kv_wrench_gold")
        local reverser = owner:GetWeapon("train_kv_wrench_gold")
        if IsValid(reverser) then
            reverser:SetCode(ID)
        end
        owner:StripWeapon("train_kv_wrench")
    end
    return true
end

function SWEP:OwnerChanged()
    Metrostroi.GetReverserID(self:GetOwner(),function(code)
        if not IsValid(self) then return end
        self:SetCode(code)
    end)
end
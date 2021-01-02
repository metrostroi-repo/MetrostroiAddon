AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

SWEP.Weight             = 1
SWEP.AutoSwitchTo       = false
SWEP.AutoSwitchFrom     = true

function SWEP:Initialize()
    if not self.Code then
        Metrostroi.GetReverserID(self.Owner,function(code)
            if not IsValid(self) then return end
            self:SetCode(code)
        end,true)
    end
    self.LastCheck = CurTime()
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
end

function SWEP:Equip(ply)
    if self.Code and CurTime()-self.LastCheck > 30 then
        Metrostroi.GetReverserID(ply,function(code)
            if not IsValid(self) then return end
            self:SetCode(code)
        end,true)
    end
end
function SWEP:SetCode(code)
    if not code or code <=0 then
        self:Reload()
        --print("Your don't own a reverser wrench")
    else
        self.Code = code
        self:SetNW2Int("Code",code)
        --print(Format("Your gold reverser wrench is %03d",self.Code or 0))
    end
end

function SWEP:Reload()
    self.Removing = true
    self.Owner:Give("train_kv_wrench")
    self.Owner:SelectWeapon("train_kv_wrench")
    self.Owner:StripWeapon("train_kv_wrench_gold")
end
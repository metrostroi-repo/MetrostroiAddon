include("shared.lua")

SWEP.PrintName			= "Button presser"
SWEP.Slot				= 3
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true

SWEP.HoldType = "normal"


function SWEP:Holster()
	return true
end

function SWEP:OnRemove()
end

function SWEP:Initialize()
end

function SWEP:Reload()

end

function SWEP:PrimaryAttack()
	if IsFirstTimePredicted() then
	end
	self:SetNextPrimaryFire( CurTime() + 10 )
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire( CurTime() + 0.5 )
end

function SWEP:Deploy()
end

function SWEP:Think()

end
function SWEP:DrawHUD()
	if self:GetNW2Int("Type") == 1 then
		draw.SimpleText("Current button:"..self:GetNW2String("Name","Unknown"),"CloseCaption_Bold",ScrW()/2, 0,Color(127,255,0),1)
	end
end

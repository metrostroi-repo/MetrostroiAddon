AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

SWEP.Weight				= 1
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= true


function SWEP:Initialize()
end
function SWEP:Think()
	local tr = util.GetPlayerTrace( self.Owner )
	tr.ignoreworld = true
	tr.filter = function(ent) if (ent:GetClass() == "func_door" or ent:GetClass() == "func_button") and ent:GetName():find("adminlock") then return true end end
	local trace = util.TraceLine( tr )
	if not trace.Hit or not IsValid(trace.Entity) then self:SetNW2Int("Type",0) return end
	self:SetNW2Int("Type",1)
end
function SWEP:PrimaryAttack()
	local tr = util.GetPlayerTrace( self.Owner )
	tr.ignoreworld = true
	tr.filter = function(ent) if (ent:GetClass() == "func_door" or ent:GetClass() == "func_button") and ent:GetName():find("adminlock") then return true end end
	local trace = util.TraceLine( tr )
	if not trace.Hit or not IsValid(trace.Entity) then return end
	trace.Entity:Fire("Toggle","","")
	trace.Entity:Fire("Press","","")

	self:SetNextPrimaryFire( CurTime()+0.5)
end

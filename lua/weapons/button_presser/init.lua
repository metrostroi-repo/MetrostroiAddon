AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

SWEP.Weight				= 1
SWEP.PrimAttack = false

function SWEP:Initialize()
end
function SWEP:Think()
	local tr = util.GetPlayerTrace( self.Owner )
	tr.ignoreworld = true
	tr.filter = function(ent) if (ent:GetClass() == "func_button" or ent:GetClass() == "momentary_rot_button") and not ent:GetName():find("adminlock") then return true end end

	if self.PrimAttack and IsValid(self.Entity) and self.Entity:GetClass() == "momentary_rot_button" then
		self.Entity:Fire("Use")
	end

	if self.PrimAttack ~= self.OldPrimAttack then
		local trace = util.TraceLine( tr )
		local rot
		if IsValid(trace.Entity) then
			rot = trace.Entity:GetClass() == "momentary_rot_button"
		end
		if trace.Hit and rot ~= nil and not IsValid(self.Entity) then
			self.Entity = trace.Entity
			if not rot then
				self.Entity:Fire("Press")
			end
		elseif not self.PrimAttack and IsValid(self.Entity) then
			self.Entity = nil
		end
		self.OldPrimAttack = self.PrimAttack
	end
	self.PrimAttack = false

	local trace = util.TraceLine( tr )
	if not trace.Hit or not IsValid(trace.Entity) then
		self:SetNW2String("Name","")
		self:SetNW2Int("Type",0)
		return
	end
	self:SetNW2Int("Type",1)
	self:SetNW2String("Name",trace.Entity:GetName())
end
function SWEP:PrimaryAttack()
	self.PrimAttack = true

end

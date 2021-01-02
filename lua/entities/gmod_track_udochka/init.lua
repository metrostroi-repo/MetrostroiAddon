AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/mus/depo/connector_feed_1.mdl")
	self.VMF = self.VMF or {}
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local physobj = self:GetPhysicsObject()
	if physobj:IsValid() then physobj:SetMass(25) end
end

local function removeWeldBetweenEnts(ent1,ent2)
	local constrainttable = constraint.FindConstraints(ent1,"Weld")
	for k,v in pairs(constrainttable) do
		if (v.Ent1 == ent1 or v.Ent1 == ent2) and (v.Ent2 == ent1 or v.Ent2 == ent2) then
			v.Constraint:Remove()
		end
	end
end
function ENT:Use(ply)
	if self.Coupled then
		sound.Play("buttons/lever8.wav",self:GetPos())
		removeWeldBetweenEnts(self,self.Coupled)
		removeWeldBetweenEnts(self.Coupled,self)

		self.Timer = CurTime()+2
	end
	self.Coupled = nil
	if ( self:IsPlayerHolding() ) then return end
	if ply.PickupObject then ply:PickupObject( self ) end
	self.LastPickup = ply
end
function ENT:Think()
	self.Power = self.VMF.power and self.VMF.power == "1"
	if self.Timer and CurTime() - self.Timer > 0 then
		self.Timer = nil
	end
	if IsValid(self.Coupled) then
		local coupled = false
		for k,v in pairs(constraint.FindConstraints(self,"Weld")) do
			if (v.Ent1 == self or v.Ent1 == self.Coupled) and (v.Ent2 == self or v.Ent2 == self.Coupled) then
				coupled = true
				break
			end
		end
		if not coupled then self:Use(self,self,0,0) end
	elseif self.Coupled then
		self:Use(self,self,0,0)
	end
	self:NextThink(CurTime() + 1)
	return true
end

function ENT:KeyValue(key, value)
	self.VMF = self.VMF or {}
	self.VMF[key] = value
end

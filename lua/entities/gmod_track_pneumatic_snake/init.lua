AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Pneumatic = {
	TrainLinePressure = 7.8,
	ReadOnly = true,
}
function ENT:Initialize()
	self:SetModel("models/mus/depo/connector_snake.mdl")
	self.VMF = self.VMF or {}
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local physobj = self:GetPhysicsObject()
	if physobj:IsValid() then physobj:SetMass(50) end
end
function ENT:Touch(ent)
	if IsValid(ent) and (ent:GetClass() == "gmod_train_bogey" and not ent.DontHaveCoupler or ent:GetClass() == "gmod_train_couple") then
		local pos = ent:WorldToLocal(self:GetPos())
		local cpos = ent.CouplingPointOffset
		local X = cpos.x - 13
		if not self.Timer and pos.x > X and self.CoupledWith ~= ent and not IsValid(ent.DepotPneumo) then
			self:SetPos(ent:LocalToWorld(ent.SnakePos or Vector(cpos.x+0.13,cpos.y+0,cpos.z+6.5)))
			self:SetAngles(ent:LocalToWorldAngles(ent.SnakeAng or Angle(0,90,0)))
			if IsValid(constraint.Weld(ent,self,0,0,0--[[33000]],true,false)) then
		    self.CoupledWith = ent
				ent.DepotPneumo = self
				if self.LastPickup and self:IsPlayerHolding() then
					self.LastPickup:DropObject()
				end
				sound.Play("buttons/lever2.wav",self:GetPos())
			end
		end
	end
end
local function removeWeldBetweenEnts(ent1,ent2)
	local constrainttable = constraint.FindConstraints(ent1,"Weld")
	for k,v in pairs(constrainttable) do
		if (v.Ent1 == ent1 or v.Ent1 == ent2) and (v.Ent2 == ent1 or v.Ent2 == ent2) then
			v.Constraint:Remove()
		end
	end
end
function ENT:Use(ply) --TODO: GravGunPickup
	if IsValid(self.CoupledWith) then
		sound.Play("buttons/lever8.wav",(self:GetPos()+self.CoupledWith:GetPos())/2)
		removeWeldBetweenEnts(self,self.CoupledWith)
		removeWeldBetweenEnts(self.CoupledWith,self)

		self.CoupledWith.DepotPneumo = nil
		self.Timer = CurTime()+2
	end
	self.CoupledWith = nil
	if ( self:IsPlayerHolding() ) then return end
	if ply.PickupObject then ply:PickupObject( self ) end
	self.LastPickup = ply
end
function ENT:Think()
	if self.Timer and CurTime() - self.Timer > 0 then
		self.Timer = nil
	end
	if IsValid(self.CoupledWith) and self.CoupledWith.DepotPneumo == self then
		local coupled = false
		for k,v in pairs(constraint.FindConstraints(self,"Weld")) do
			if (v.Ent1 == self or v.Ent1 == self.CoupledWith) and (v.Ent2 == self or v.Ent2 == self.CoupledWith) then
				coupled = true
				break
			end
		end
		if not coupled then self:Use(self,self,0,0) end
	end
	self:NextThink(CurTime() + 1)
	return true
end

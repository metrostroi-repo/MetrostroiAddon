AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")



--------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetModel(self.Model or "models/metrostroi/metro/metro_wheels.mdl")
	if not self.NoPhysics then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
	end
	self.Meters = 0
	self.Angle = 0
end
--[[
function ENT:Think(dT)
	-- Update timing
	self.PrevTime = self.PrevTime or CurTime()
	self.dT = (CurTime() - self.PrevTime)
	self.PrevTime = CurTime()
	local Bogey = self:GetNW2Entity("TrainBogey")

	--if not IsValid(Bogey) then return end
	--self.Meters = self.Meters + self.dT * Bogey.Speed * Bogey.SpeedSign


end
--]]
function ENT:PhysicsCollide(data,physobj)
	-- Generate junction sounds
	if data.HitEntity and data.HitEntity:IsValid() and data.HitEntity:GetClass() == "prop_door_rotating" then
		self.LastJunctionTime = self.LastJunctionTime or CurTime()
		local dt = CurTime() - self.LastJunctionTime

		if dt > 3.5 then
			local speed = self:GetVelocity():Length() * 0.06858
			if speed > 10 then
				self.LastJunctionTime = CurTime()

				local pitch_var = math.random(90,110)
				local pitch = pitch_var*math.max(0.8,math.min(1.3,speed/40))
				self:EmitSound("subway_trains/bogey/junct_"..math.random(1,4)..".wav",100,pitch )
			end
		end
	end
end

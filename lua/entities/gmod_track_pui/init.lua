AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:KeyValue(key, value)
	self.VMF = self.VMF or {}
	self.VMF[key] = value
end
--------------------------------------------------------------------------------
function ENT:Initialize()
	self:EntIndex()
	self.VMF = self.VMF or {}
	self.Model		= self.VMF.model or "models/metrostroi/mus_clock/pui_var_a.mdl"
	self:SetModel(self.Model)
	self.Work = false
	self.Last = 0
end
--ENT.Update = true
function ENT:Think()
	-- Time sync
	--[[if self.Update then
		self.BoardTime = CurTime()
		self.Work = true
		self.Update = false
	end]]
	self:SetNWBool("Work",self.Work == true)
	self:SetNWInt("Last",self.Last)
	self:SetNWInt("Time",self.BoardTime or 0)--math.floor((self.BoardTime or 0)-CurTime()))
	--self:SetNWBool("Lamp",self.Work and (self.Horlift and self:GetNWInt("Time") == 15 or self:GetNWInt("Time") == 8))
	self:SetNWBool("Lamp",self.Lamp)
	self:NextThink(0.1)
	return true
end

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
util.AddNetworkString "metrostroi-signs"

function ENT:Initialize()
	self:DrawShadow(false)
	self:SendUpdate()
end

function ENT:OnRemove()
end

function ENT:Think()
end

function ENT:SendUpdate()
	if not self.SignType then return end
	self:SetNWInt("Type",self.SignType or 1)
	self:SetNWVector("Offset",Vector(0,self.YOffset,self.ZOffset))
	self:SetNWBool("Left",self.Left or false)
end

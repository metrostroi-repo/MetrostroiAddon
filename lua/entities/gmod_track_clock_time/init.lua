AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:KeyValue(key, value)
	self.VMF = self.VMF or {}
	self.VMF[key] = value
end
function ENT:Initialize()
	self:EntIndex()
	self.VMF = self.VMF or {}
	self.Type		= (tonumber(self.VMF.Type) or 0)
	self.Light		= (tonumber(self.VMF.Light) or 0)
	if self.Type == 0 then
		self:SetModel("models/metrostroi/clock_time_moscow.mdl")
	else
		self:SetModel("models/metrostroi/clock_time_type2.mdl")
	end
	self:SetNW2Bool("Type",self.Type > 0)
	self:SetNW2Int("Light",self.Light+1)
end

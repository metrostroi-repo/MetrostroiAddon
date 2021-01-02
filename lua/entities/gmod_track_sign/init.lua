AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
end

--[[function ENT:MakeStationSign(rus_name,eng_name)
	self:SetNW2String("Type","station_sign")
	self:SetNW2Int("Style",2)
	self:SetNW2String("RusName",rus_name)
	self:SetNW2String("EngName",eng_name)
end]]--
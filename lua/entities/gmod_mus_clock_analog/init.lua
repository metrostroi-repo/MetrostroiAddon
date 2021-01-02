AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/metrostroi/signals/clock_analog_arrow_base.mdl")
end

function ENT:Think()
	self:NextThink(0.1)
	return true
end

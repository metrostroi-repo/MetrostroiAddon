AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/mus/ussr_clock_model/base.mdl")
end

function ENT:Think()
	self:SetSkin((os.time()-(os.time() - CurTime()))%1*2)
	self:NextThink(0.1)
	return true
end

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("TrackController")
local function ShowWindowOnCL(ply,ent)
	net.Start("TrackController")
		net.WriteEntity(ent)
	net.Send(ply)
end
function ENT:Initialize()
	self:SetModel("models/metrostroi/signals/clock_time.mdl")
end

function ENT:Think()
end
function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()

	ShowWindowOnCL(ply,ent)
	return ent

end
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString "MetrostroiTrainSpawner"
util.AddNetworkString "MetrostroiTrainCount"
util.AddNetworkString "MetrostroiMaxWagons"
CreateConVar("metrostroi_maxtrains",3,{FCVAR_ARCHIVE},"Maximum of allowed trains")
CreateConVar("metrostroi_maxwagons",3,{FCVAR_ARCHIVE},"Maximum of allowed wagons in 1 train")
CreateConVar("metrostroi_maxtrains_onplayer",1,{FCVAR_ARCHIVE},"Maximum of allowed trains by player")
local function MaxWagonsChangeCallback()
	SetGlobalInt("metrostroi_maxtrains",GetConVar("metrostroi_maxtrains"):GetInt())
	SetGlobalInt("metrostroi_maxtrains_onplayer",GetConVar("metrostroi_maxtrains_onplayer"):GetInt())
	SetGlobalInt("metrostroi_maxwagons",GetConVar("metrostroi_maxwagons"):GetInt())
	timer.Simple(0,function()
		net.Start("MetrostroiMaxWagons")
		net.Broadcast()
	end)
end

cvars.AddChangeCallback("metrostroi_maxtrains", MaxWagonsChangeCallback)
cvars.AddChangeCallback("metrostroi_maxtrains_onplayer", MaxWagonsChangeCallback)
cvars.AddChangeCallback("metrostroi_maxwagons", MaxWagonsChangeCallback)
local function ShowWindowOnCL(ply, id)
	SetGlobalInt("metrostroi_train_count",Metrostroi.TrainCount())
	timer.Simple(0,function()
		net.Start("MetrostroiTrainSpawner")
		--net.WriteTable(Metrostroi.Skins)
		net.Send(ply)
	end)
end
timer.Create("metrostroi-maxtrains-hook",5,0,MaxWagonsChangeCallback)
function ENT:SpawnFunction(ply, tr)
	if not ply:HasWeapon("gmod_tool") then
		--ply:Give("gmod_tool")
		return
	end
	ShowWindowOnCL(ply)
end

local C_DebugEnabled = CreateConVar("metrostroi_debugger_enabled",0,FCVAR_ARCHIVE,"Enable train systems debugger")
local C_DebugUpdateInterval = CreateConVar("metrostroi_debugger_update_interval",1,FCVAR_ARCHIVE,"Seconds between debugger data messages")

Metrostroi.Debugger = {}
Metrostroi.Debugger.Clients = {}
Metrostroi.Debugger.NameMap = {}
Metrostroi.Debugger.EntVarCounts = {}
local Debugger = Metrostroi.Debugger


util.AddNetworkString("metrostroi-debugger-dataupdate")
util.AddNetworkString("metrostroi-debugger-entremoved")
util.AddNetworkString("metrostroi-debugger-entnamemap")


if game.SinglePlayer() then
	C_DebugUpdateInterval:SetFloat(0.0)
end

local function SendNameMap(ply,ent)
	net.Start("metrostroi-debugger-entnamemap")
	net.WriteInt(ent:EntIndex(),16)
	net.WriteTable(ent:GetDebugVars())
	if ply then
		net.Send(ply)
	else
		net.Broadcast()
	end
end

--Add a new client to send an entities debugvars to
local function AddClient(ply,ent)
	if not Debugger.Clients[ply] then
		Debugger.Clients[ply]={}
	end
	if table.HasValue(Debugger.Clients[ply],ent) then return end
	table.insert(Debugger.Clients[ply],ent)

end

local function RemoveEnt(ply,ent)
	if ply and Debugger.Clients[ply] then
		if ent then
			table.RemoveByValue(Debugger.Clients[ply],ent)
		else
			Debugger.Clients[ply]=nil
		end
	else
		for k,v in pairs(Debugger.Clients) do
			table.RemoveByValue(v,ent)
		end
	end
end

--Handler for adding new ents to listen to
local function cmdinithandler(ply,cmd,args,fullstring)
	if not C_DebugEnabled:GetBool() then return end
	local ent = ply:GetEyeTrace().Entity
	if not IsValidEnt(ent) or not ent.GetDebugVars then return end

	AddClient(ply,ent)
end
concommand.Add("metrostroi_debugtrainsystems", cmdinithandler, nil, "Add aimed at entity to debugger")

-- Automatically engage debugger for train owner
function Metrostroi.DebugTrain(train,ply)
	if not ply then ply = train:GetPlayer() end
	if (not IsValidEnt(train)) or (not IsValidEnt(ply)) then return end

	AddClient(ply,train)
end

local nextthink = 0
local function think()
	if CurTime() < nextthink then return end
	nextthink = CurTime() + C_DebugUpdateInterval:GetFloat()
	--Loop over clients and their ents and send the collected data

	--Check for new entity variables
	for ply,entlist in pairs(Debugger.Clients) do
		for k,ent in pairs(entlist) do
			local count = table.Count(ent:GetDebugVars())
			if Debugger.EntVarCounts[ent] ~= count then
				SendNameMap(nil,ent)
				Debugger.EntVarCounts[ent] = count
			end
		end
	end

	--Send the bulk, nameless data
	for ply,entlist in pairs(Debugger.Clients) do

		net.Start("metrostroi-debugger-dataupdate")
			local count = table.Count(entlist)
			net.WriteInt(count,8)
			for k,ent in pairs(entlist) do
				local entvars = ent:GetDebugVars()
				local newtable = {}

				for k,v in SortedPairs(entvars) do
					table.insert(newtable,v)
				end

				net.WriteTable({ent:EntIndex(),newtable})
			end
		net.Send(ply)
	end
end

local function OnEntRemove(ent)
	RemoveEnt(nil,ent)	

	--Client doesn't get all removed ents, broadcast it manually to all
	net.Start("metrostroi-debugger-entremoved")
	net.WriteInt(ent:EntIndex(),16)
	net.Broadcast()
end

hook.Add("EntityRemoved","metrostroi-debugger-cleanup",OnEntRemove)
hook.Add("PlayerDisconnected","metrstroi-debugger-plycleanup",RemoveEnt)

-- Start/stop debugger think
if C_DebugEnabled:GetBool() then
	hook.Add("Think","metrostroi-debugger-think",think)
end

cvars.AddChangeCallback("metrostroi_debugger_enabled", function(convar, oldValue, newValue)
	if C_DebugEnabled:GetBool() then
		nextthink = 0
		hook.Add("Think","metrostroi-debugger-think",think)
	else
		hook.Remove("Think","metrostroi-debugger-think")
	end
end,"sv_debugger")

cvars.AddChangeCallback("metrostroi_debugger_update_interval", function(convar, oldValue, newValue)
	nextthink = CurTime() + C_DebugUpdateInterval:GetFloat()
end,"sv_debugger")

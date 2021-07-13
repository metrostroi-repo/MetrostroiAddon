--------------------------------------------------------------------------------
-- Track definition generator
-- Author: HunterNL
--------------------------------------------------------------------------------
-- Yes, this code is a mess



Metrostroi.TrackEditor = Metrostroi.TrackEditor or {}
Metrostroi.TrackEditor.Paths = Metrostroi.TrackEditor.Paths or {}

local ANGLE_LIMIT = 10			-- At what difference from last node do we make a new node
local MAX_NODE_DISTANCE = 512 	-- When do we force a new node regardless of angle difference
local MIN_NODE_DISTANCE = 100 	-- Minimal distance between nodes

-- Convert variables into something we can throw at the vector dot product and cheaper distance calculation
ANGLE_LIMIT = math.cos(math.rad(ANGLE_LIMIT))
MAX_NODE_DISTANCE = MAX_NODE_DISTANCE ^ 2
MIN_NODE_DISTANCE = MIN_NODE_DISTANCE ^ 2

local CurrentPath
local Active = false
local LastNode
local LastDir
local Train

local FileDir = "metrostroi_data"
local FilePath = string.format("%s/track_%s.txt",FileDir,game.GetMap())

local function GetFile()
	local name = game.GetMap()
	local tracktype = 0
	if file.Exists(Format("metrostroi_data/track_%s.txt",name),"DATA") then tracktype = bit.bor(tracktype,2) end
	if file.Exists(Format("metrostroi_data/track_%s.lua",name),"LUA") then tracktype = bit.bor(tracktype,1) end
	if tractype == 0 then print("Track definition file not found: metrostroi_data/track_"..name..".txt") return end

	if bit.band(tracktype,2) > 0 then
		paths= util.JSONToTable(file.Read(Format("metrostroi_data/track_%s.txt",name)))
		print("Metrostroi: Loading track definition...")
	end
	if not paths and bit.band(tracktype,1) > 0 then
		paths= util.JSONToTable(file.Read(Format("metrostroi_data/track_%s.lua",name),"LUA"))
		print("Metrostroi: Loading default track definition...")
	end
	return paths
end
local DataMsgName = "metrostroi_trackeditor_trackdata"
local StrMsgName = "metrostroi_trackeditor_message"

util.AddNetworkString(DataMsgName)
util.AddNetworkString(StrMsgName)

local function SendTable(i,tbl,ply)
	net.Start(DataMsgName)
		net.WriteInt(i,16)
		net.WriteTable(tbl)
	net.Send(ply)
end
local function SendClientUpdate(ply)
	net.Start(DataMsgName)
		net.WriteInt(0,16)
	net.Send(ply)
	local Paths = Metrostroi.TrackEditor.Paths
	for i=1,#Paths do
		--timer.Simple(i*0.5,function()
			SendTable(i,Paths[i],ply)
		--end)
	end
end

local function SendClientMsg(ply,msg)
	net.Start(StrMsgName)
	net.WriteString(msg)
	if ply then
		net.Send(ply)
	else
		net.Broadcast()
	end
end

local function DebugLine(p1,p2)
	debugoverlay.Line(p1,p2,10,Color(0,0,255),true)
end

local function DrawPath(path)
	local lastnode
	for k,v in pairs(path) do
		debugoverlay.Cross(v,10,10,Color(255,0,0),true)
		if lastnode then
			DebugLine(lastnode,v)
		end
		lastnode = v
	end
end

-- TODO: I know these are almost duplicates, will improve later
local function TeleStart(args,ply)
	if #args > 0 then
		ply:SetPos(Metrostroi.TrackEditor.Paths[tonumber(args[1])][1])
	end
end

local function TeleEnd(args,ply)
	if #args > 0 then
        local tbl = Metrostroi.TrackEditor.Paths[tonumber(args[1])]
		ply:SetPos(tbl[#tbl])
	end
end

local function TeleEntStart(args,ply)
	if #args > 0 and IsValid(Train) then
		Train:SetPos(Metrostroi.TrackEditor.Paths[tonumber(args[1])][1])

		if Train.Base == "gmod_subway_base" then
			Metrostroi.RerailTrain(Train)
		end
	end
end

local function TeleEntEnd(args,ply)
	if #args > 0 and IsValid(Train) then
        local tbl = Metrostroi.TrackEditor.Paths[tonumber(args[1])]
		Train:SetPos(ply:SetPos(tbl[#tbl]))

		if Train.Base == "gmod_subway_base" then
			Metrostroi.RerailTrain(Train)
		end
	end

end

local function ShowAll()
	local paths = Metrostroi.TrackEditor.Paths
	if not paths or #paths == 0 then return end

	for _,path in pairs(paths) do
		if #path > 0 then
			DrawPath(path)
		end
	end
end

local function ShowStatus(_,ply)
		SendClientUpdate(ply)
	local paths = Metrostroi.TrackEditor.Paths
	if paths and #paths > 0 then
		print(string.format("%d Paths:",#paths))
		for k,path in pairs(paths) do
			local suffix = ""

			if path == CurrentPath then
				suffix = "<<< Active"
			end

			if #path > 0 then
				print(string.format("\t %d: %d nodes %s",k,#path,suffix))
			else
				print("Erroneous empty path?!")
			end
		end
	else
		print("No recorded paths")
	end
end

local function Mark(args,ply)
	ent = ply:GetEyeTrace().Entity
	if IsEntity(ent) and IsValid(ent) then
		Train = ent
		print(Train," marked")
		SendClientMsg(ply,tostring(Train).." marked")
	end
end

local function NextNode()
	local pos = Train:LocalToWorld(Vector(Train:OBBMaxs().x,0,0))--Train:GetPos() + Train:OBBMins()*2*Train:GetAngles():Forward()
	if LastNode then
		DebugLine(pos,LastNode,10,Color(0,0,255),true)
		LastDir = (pos - LastNode):GetNormalized()
	end
	debugoverlay.Cross(pos,10,10,Color(0,100,255),true)
	table.insert(CurrentPath,pos)

	LastNode = pos
	--Metrostroi.TrackEditor.Paths[CurrentPath][table.insert(Metrostroi.TrackEditor.Paths[CurrentPathID],self.Train:GetPos())]
	--Lets not do that
	--PrintTable(self.Paths)
end

local function Think()
	if not Active then return end

	local pos = Train:LocalToWorld(Vector(Train:OBBMaxs().x,0,0))--Train:GetPos() + Train:OBBMins()*2*Train:GetAngles():Forward()

	if LastNode then
		CurrentDir = (pos-LastNode):GetNormalized()
	end


	if LastDir and (LastDir:Dot(CurrentDir) < ANGLE_LIMIT)
	and (LastNode:DistToSqr(pos) > MIN_NODE_DISTANCE)
	then
		NextNode()
	end

	if LastNode:DistToSqr(pos) > MAX_NODE_DISTANCE then
		NextNode()
	end
end
-- Unused
local function ClientDraw()
	if GetConVar("metrostroi_drawsignaldebug"):GetInt() <= 0 then return end
	if #Metrostroi.TrackEditor.Paths == 0 then return end

	local lastpos
	for _,path in pairs(Metrostroi.TrackEditor.Paths) do
		if #path > 0 then
			local drawcolor
			if path == CurrentPath then
				drawcolor = {0,255,0}
			else
				drawcolor = {0,0,255}
			end

			for k,node in pairs(path) do
				if lastpos then
					render.DrawLine(lastpos,node,drawcolor,false)
				end
				render.DrawWireframeSphere(node,10,2,2,drawcolor,false)
				lastpos = node
			end
		end
	end
end

local function FinishPath(args,ply)
	NextNode()
	CurrentPath = nil
	LastNode = nil
	LastDir = nil
	print("Path ended")
	SendClientMsg(ply,"Path ended")
end

local function RemovePath(args,ply)
	local id = tonumber(args[1])
	local path = Metrostroi.TrackEditor.Paths[id]
	if path == CurrentPath then
		FinishPath()
	end
	table.remove(Metrostroi.TrackEditor.Paths,id)
	SendClientUpdate(ply)
end

--Takes forward direction
local function StartPath(id)
	if id then
		print("Re-recording path "..id)
	else
		print("New Path")
	end

	if id then
		Metrostroi.TrackEditor.Paths[id] = {}
		CurrentPath = Metrostroi.TrackEditor.Paths[id]
	else
		local ID = table.insert(Metrostroi.TrackEditor.Paths,{})
		CurrentPath = Metrostroi.TrackEditor.Paths[ID]
	end

	local forward = forward or (Train and Train:GetAngles():Forward())
	LastDir = forward*-1

	NextNode()
end


local function Start(args,ply)
	if Active then
		print("Already started")
		SendClientMsg(ply,"Already started")
		return
	end

	if Train then
		StartPath(tonumber(args[1]))
		Active = true
		print("Started")
		SendClientMsg(ply,"Started")
	else
		print("No train!")
		SendClientMsg(ply,"No train!")
	end
end

local function Stop(args,ply)
	if Active then
		FinishPath()
		Active = false
		SendClientUpdate(ply)
	else
		print("Not active")
		SendClientMsg(ply,"Not active")
	end
end

local function Save(args,ply)
	if not file.Exists(FileDir,"DATA") then
		file.CreateDir(FileDir)
	end
	local data = util.TableToJSON(Metrostroi.TrackEditor.Paths,true)
	local path = FilePath
	file.Write(path,data)
	print("Saved to " .. path)
	SendClientMsg(ply,"Saved to file")
end

local function Load(args,ply)
	local tbl = GetFile()
	if tbl == nil then
		print("JSON Parse error reading from "..FilePath)
	else
		Metrostroi.TrackEditor.Paths = tbl -- Maybe requires hardcopy?
		print("Loaded from "..FilePath)
		SendClientMsg(ply,"Loaded from file")
		SendClientUpdate(ply)
	end
end


hook.Add("Think","metrostroi track editor",Think)

local function AddCmd(name,func,helptext,flags)
	concommand.Add(string.format("metrostroi_trackeditor_%s",name),function(ply,cmd,args,fullstring) if ply:IsAdmin() then func(args,ply) end end,flags,helptext)
end

AddCmd("start",Start,"Start recording a new path")
AddCmd("stop",Stop,"Stop recording a path")
AddCmd("removepath",RemovePath,"Remove path with given ID")
AddCmd("save",Save,"Save the current paths to file")
AddCmd("load",Load,"Load paths from file")
AddCmd("status",ShowStatus,"Show status")
AddCmd("mark",Mark,"Mark the given ent index as ent to record with")
AddCmd("teletostart",TeleStart,"Teleport to the start of the given path")
AddCmd("teletoend",TeleEnd,"Teleport to the end of the given path")
AddCmd("teleenttostart",TeleEntStart,"Teleport train to the end of the given path")
AddCmd("teleenttoend",TeleEntEnd,"Teleport train to the end of the given path")

--[[
if SERVER and false then
	concommand.Add("metrostroi_trackeditor_mark",function(ply,cmd,args,fullstring) Mark(ply:GetEyeTrace().Entity) end,nil,"Mark currently aimed at entity as track editing source")
	concommand.Add("metrostroi_trackeditor_start",function(ply,cmd,args,fullstring) Start() end,nil,"Start recording")
	concommand.Add("metrostroi_trackeditor_stop",function(ply,cmd,args,fullstring) Stop() end,nil,"Stop recording")
	concommand.Add("metrostroi_trackeditor_drawall",function(ply,cmd,args,fullstring) timer.Simple(0.05,ShowAll) end,nil,"Draw all paths")
	concommand.Add("metrostroi_trackeditor_status",function(ply,cmd,args,fullstring) ShowStatus() end,nil,"Show path status")
	concommand.Add("metrostroi_trackeditor_drawpath",function(ply,cmd,args,fullstring) timer.Simple(0.05,function() DrawPathID(args) end) end,nil,"Draw single path")
	concommand.Add("metrostroi_trackeditor_removepath",function(ply,cmd,args,fullstring) RemovePath(args) end,nil,"Remove a path")
	concommand.Add("metrostroi_trackeditor_save",function(ply,cmd,args,fullstring) Save(args) end,nil,"Save track")
	concommand.Add("metrostroi_trackeditor_load",function(ply,cmd,args,fullstring) Load(args) end,nil,"Load track")
end
--]]

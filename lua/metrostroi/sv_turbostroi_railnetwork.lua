if not TURBOSTROI and (not Turbostroi or not Turbostroi.SetMTAffinityMask) then return end
if not TURBOSTROI then
	Turbostroi.StartRailNetwork()

	--Turbostroi.RnSendMessage(ent_id, id, name, value)
	--Turbostroi.RnRecvMessages()
	return
end
--------------------------------------------------------------------------------
-- Turbostroi scripts (turbostroi side)
--------------------------------------------------------------------------------
print("[!] RailNetwork initialized!")
-- NEW API
local ffi = require("ffi")
local C = ffi.load("gmsv_turbostroi_win32")
ffi.cdef[[
bool RnThreadSendMessage(int ent_id, int id, const char* name, double value);
]]

function CurTime() return CurrentTime end
Metrostroi = {}
if not Metrostroi.Paths then
	-- Definition of paths used in runtime
	Metrostroi.Paths = {}
	-- Spatial lookup for nodes
	Metrostroi.SpatialLookup = {}

	-- List of signal entities for every track segment/node
	Metrostroi.SignalEntitiesForNode = {}
	-- List of nodes for every signal entity
	Metrostroi.SignalEntityPositions = {}
	-- List of track switches for every track segment/node
	Metrostroi.SwitchesForNode = {}
	-- List of trains for every segment/node
	Metrostroi.TrainsForNode = {}
	-- List of train positions
	Metrostroi.TrainPositions = {}
	--List of train directions on the way
	Metrostroi.TrainDirections = {}
	Metrostroi.GetARSJointCache = {}
	-- List of stations/platforms
	Metrostroi.Stations = {}

	-- List of ARS subsections
	Metrostroi.ARSSubSections = {}

	-- List of names for signals
	Metrostroi.SignalEntitiesByName = {}

	-- List of names for switches
	Metrostroi.SwitchesByName = {}

	-- Should position updates in switches and signals be ignores
	Metrostroi.IgnoreEntityUpdates = false

	Metrostroi.OldUpdateTime = 0
end

--------------------------------------------------------------------------------
-- Size of spatial cells into which all the 3D space is divided
local SPATIAL_CELL_WIDTH = 1024
local SPATIAL_CELL_HEIGHT = 256

-- Return spatial cell indexes for given XYZ
local function spatialPosition(pos)
	return math.floor(pos.x/SPATIAL_CELL_WIDTH),
		   math.floor(pos.y/SPATIAL_CELL_WIDTH),
		   math.floor(pos.z/SPATIAL_CELL_HEIGHT)
end

-- Return list of nodes in spatial cell kx,ky,kz
local empty_table = {}
local function spatialNodes(kx,ky,kz)
	if Metrostroi.SpatialLookup[kz] then
		if Metrostroi.SpatialLookup[kz][kx] then
			return Metrostroi.SpatialLookup[kz][kx][ky] or empty_table
		else
			return empty_table
		end
	else
		return empty_table
	end
end


--------------------------------------------------------------------------------
-- for nodeID,node in Metrostroi.NearestNodes(pos) do ... end
--
-- This is used for iterating through nodes around given position
--------------------------------------------------------------------------------
function Metrostroi.NearestNodes(pos)
	local kx,ky,kz = spatialPosition(pos)
	local t = {}
	for x=-1,1 do for y=-1,1 do for z=-1,1 do
		table.insert(t,spatialNodes(kx+x,ky+y,kz+z))
	end end end

	local i,j = 0,1
	return function ()
		-- Find next set of nodes that's not empty
		while (j <= #t) and (i >= #t[j]) do
			j = j + 1; i = 0
		end
		-- Should iterator end
		if j > #t then return nil end

		-- Iterate table like normal
		i = i + 1
		if i <= #t[j] then return t[j][i].id,t[j][i] end
	end
end

--------------------------------------------------------------------------------
-- Return position on track for target XYZ
--
-- Simply checks every line between two nodes, for all ndoes around position
--------------------------------------------------------------------------------
function Metrostroi.GetPositionOnTrack(pos,ang,opts)
	if not opts then opts = empty_table end

	-- Angle can be specified to determine if facing forward or backward
	ang = ang or Angle(0,0,0)

	-- Size of box which envelopes region of space that counts as being on track
	local X_PAD = 0
	local Y_PAD = opts.y_pad or opts.radius or 384/2
	local Z_PAD = opts.z_pad or 256/2

	-- Find position on any track
	local results = {}
	for nodeID,node in Metrostroi.NearestNodes(pos) do
		-- Get local coordinate system of a section
		local forward = node.dir
		local up = Vector(0,0,1)
		local right = forward:Cross(up)

		-- Transform position into local coordinates
		local local_pos = pos - node.pos
		local local_x = local_pos:Dot(forward)
		local local_y = local_pos:Dot(right)
		local local_z = local_pos:Dot(up)
		local yz_delta = math.sqrt(local_y^2 + local_z^2)

		-- Determine if facing forward or backward
		local local_dir = ang:Forward()
		local dir_delta = local_dir:Dot(forward)
		local dir_forward = dir_delta > 0
		local dir_angle = 90-math.deg(math.acos(dir_delta))

		-- If this position resides on track, add it to results
		if ((local_x > -X_PAD) and (local_x < node.vec:Length()+X_PAD) and
			(local_y > -Y_PAD) and (local_y < Y_PAD) and
			(local_z > -Z_PAD) and (local_z < Z_PAD)) and (node.path ~= opts.ignore_path) then

			table.insert(results,{
				node1 = node,
				node2 = node.next,
				path = node.path,

				angle = dir_angle,				-- Angle between forward vector and axis of track
				forward = dir_forward,			-- Is facing forward relative to track
				x = local_x*0.01905 + node.x,	-- Local coordinates in track curvilinear coordinates
				y = local_y*0.01905,			--
				z = local_z*0.01905,			--

				distance = yz_delta,			-- Distance to path axis
			})
		end
	end

	-- Sort results by distance
	table.sort(results, function(a,b) return a.distance < b.distance end)

	-- Return list of positions
	return results
end


--------------------------------------------------------------------------------
-- Return XYZ for given position on path
--------------------------------------------------------------------------------
function Metrostroi.GetTrackPosition(path,x)
	-- Build a lookup
	if not path.GetTrackPosition then
		path.GetTrackPosition = {}
		for nodeID,node in ipairs(path) do
			if not path.GetTrackPosition[math.floor(node.x/500)] then
				path.GetTrackPosition[math.floor(node.x/500)] = nodeID
			end
		end
	end

	-- Find offset on path path.GetTrackPosition[math.floor(x/200)] or
	local startNodeID = 1
	for nodeID=startNodeID,#path do
		local node = path[nodeID]
		if (node.x < x) and (path[nodeID+1]) and (path[nodeID+1].x > x) then
			local dir1 = node.dir
			local dir2 = path[nodeID+1].dir
			local t = (x - node.x)/node.length
			return (node.pos+node.vec*t),dir1*(1-t)+dir2*t,node
		end
	end
end

function Metrostroi.UpdateSignalNames()
	print("Metrostroi: Updating signal names...")
	Metrostroi.SignalEntitiesByName = {}
	Metrostroi.GetARSJointCache = {}
	local entities = ents.FindByClass("gmod_track_signal")
	for k,v in pairs(entities) do
		if v.Name then
			if Metrostroi.SignalEntitiesByName[v.Name] then--
				print(string.format("Metrostroi: Signal with this name %s already exists! Check signal names!\nInfo:\n\tFirst signal:  %s\n\tPos:    %s\n\tSecond signal: %s\n\tPos:    %s",
				v.Name, Metrostroi.SignalEntitiesByName[v.Name], Metrostroi.SignalEntitiesByName[v.Name]:GetPos(), v, v:GetPos()))
			else
				Metrostroi.SignalEntitiesByName[v.Name] = v
			end
		end
	end
end
--------------------------------------------------------------------------------
-- Update list of signal entities and signal positions on track
--------------------------------------------------------------------------------
function Metrostroi.UpdateSignalEntities()
	if Metrostroi.IgnoreEntityUpdates then return end
	if CurTime() - Metrostroi.OldUpdateTime < 0.05 then
		print("Metrostroi: Stopping all updates!")
		Metrostroi.IgnoreEntityUpdates = true
		timer.Simple(0.2, function()
			print("Metrostroi: Retrieve updates.")
			Metrostroi.IgnoreEntityUpdates = false
			Metrostroi.UpdateSignalEntities()
			Metrostroi.UpdateSwitchEntities()
			Metrostroi.UpdateARSSections()
		end)
		return
	end
	Metrostroi.OldUpdateTime = CurTime()
	local options = { z_pad = 256 }

	Metrostroi.UpdateSignalNames()

	Metrostroi.SignalEntitiesForNode = {}
	Metrostroi.SignalEntityPositions = {}

	local count = 0
	local repeater = 0
	local entities = ents.FindByClass("gmod_track_signal")
	print("Metrostroi: PreInitialize signals")
	for k,v in pairs(entities) do
		local pos = Metrostroi.GetPositionOnTrack(v:GetPos(),v:GetAngles() - Angle(0,90,0),options)[1]
		local pos2 = Metrostroi.GetPositionOnTrack(v:LocalToWorld(Vector(0,10,0)), v:GetAngles() - Angle(0,90,0),options)
		if pos then -- FIXME make it select proper path

			Metrostroi.SignalEntitiesForNode[pos.node1] =
				Metrostroi.SignalEntitiesForNode[pos.node1] or {}
			table.insert(Metrostroi.SignalEntitiesForNode[pos.node1],v)

			-- A signal belongs only to a single track
			Metrostroi.SignalEntityPositions[v] = pos
			v.TrackPosition = pos
			v.TrackX = pos.x
			if pos2 and pos2[1] then
				v.TrackDir = (pos2[1].x - v.TrackX) < 0
			else
				print(string.format("Metrostroi: Signal %s, second position not found, system can't detect direction of the signal!",v.Name))
				v.TrackDir = true
			end
			if not v.ARSOnly then
				--v.AutostopPos = Metrostroi.GetTrackPosition(pos.path,v.TrackX - (v.TrackDir and 2.5 or -2.5))
				--if not v.AutostopPos then print(string.format("Metrostroi: Signal %s, can't place autostop!",v.Name)) end
			end
		else
			if not v.Routes or v.Routes[1].NextSignal ~= "" then
				print(string.format("Metrostroi: Signal %s, position not found, system can't detect the track occupation!",v.Name))
			end
		end
		if not v.Routes[1] then ErrorNoHalt(string.format("Metrostroi: Signal %s don't have first route!",v.Name)) end
		if v.Routes and v.Routes[1].Repeater then
			repeater = repeater + 1
		end
		count = count + 1
		v:PreInitalize()
	end
	print(string.format("Metrostroi: Total signals: %u (normal: %u, repeaters: %u)", count, count-repeater, repeater))
end

function Metrostroi.PostSignalInitialize()
	if Metrostroi.IgnoreEntityUpdates then return end
	print("Metrostroi: PostInitialize signals")
	local entities = ents.FindByClass("gmod_track_*")
	for k,v in pairs(entities) do
		if v.PostInitalize then v:PostInitalize() end
	end
end

--------------------------------------------------------------------------------
-- Update lists of switches
--
-- This is used for searching where the switches belong on tracks. One switch
-- belongs to one track.
--------------------------------------------------------------------------------
function Metrostroi.UpdateSwitchEntities()
	if Metrostroi.IgnoreEntityUpdates then return end
	Metrostroi.SwitchesForNode = {}
	Metrostroi.SwitchesByName = {}

	local entities = ents.FindByClass("gmod_track_switch")
	for k,v in pairs(entities) do
		local pos = Metrostroi.GetPositionOnTrack(v:GetPos(),v:GetAngles() - Angle(0,90,0))[1]
		if pos then
			if not v.Name or v.Name == "" then
				--pos.path.id.."/"..pos.node1.id
				if not Metrostroi.SwitchesByName[pos.path.id] then Metrostroi.SwitchesByName[pos.path.id] = {} end
				Metrostroi.SwitchesByName[pos.path.id][pos.node1.id] = v
			end
			Metrostroi.SwitchesForNode[pos.node1] = Metrostroi.SwitchesForNode[pos.node1] or {}
			table.insert(Metrostroi.SwitchesForNode[pos.node1],v)
			v.TrackPosition = pos -- FIXME: check that one switch belongs to one track
		end
		if v.Name and v.Name ~= "" then
			Metrostroi.SwitchesByName[v.Name] = v
		end

	end
	Metrostroi.PostSignalInitialize()
end


--------------------------------------------------------------------------------
-- Add additional ARS element in the given node
--
-- These ARS elements do not isolate track signals, only isolate ARS signals
--------------------------------------------------------------------------------
function Metrostroi.AddARSSubSection(node,source)
	if true then return end
	local ent = ents.Create("gmod_track_signal")
	if not IsValid(ent) then return end

	local tr = Metrostroi.RerailGetTrackData(node.pos - node.dir*32,node.dir)
	if not tr then return end

	ent:SetPos(tr.centerpos - tr.up * 9.5)
	ent:SetAngles((-tr.right):Angle())
	ent:Spawn()

	-- Add to list of ARS subsections
	Metrostroi.ARSSubSections[ent] = true
	Metrostroi.ARSSubSectionCount = Metrostroi.ARSSubSectionCount + 1
end


--------------------------------------------------------------------------------
-- Update ARS sections (and add additional subsections (now not needed)
--------------------------------------------------------------------------------
function Metrostroi.UpdateARSSections()
	--[[
	Metrostroi.ARSSubSections = {}
	Metrostroi.ARSSubSectionCount = 0

	print("Metrostroi: Updating ARS subsections...")
	Metrostroi.IgnoreEntityUpdates = true
	for k,v in pairs(Metrostroi.SignalEntityPositions) do
		-- Find signal which sits BEFORE this signal
		local signal = Metrostroi.GetARSJoint(v.node1,v.x,true)

		--Metrostroi.GetNextTrafficLight(v.node1,v.x,not v.forward,true)
		if IsValid(k) and signal then
			local pos = Metrostroi.SignalEntityPositions[signal]
			--debugoverlay.Line(k:GetPos(),signal:GetPos(),10,Color(0,0,255),true)

			-- Interpolate between two positions and add intermediates
			local count = 0
			local offset = 0
			local delta_offset = 120 --100
			if (v.path == pos.path) and (pos.x < v.x) then
				--print(string.format("Metrostroi: Adding ARS sections between [%d] %.0f -> %.0f m",pos.path.id,pos.x,v.x))
				local node = pos.node1
				while (node) and (node ~= v.node1) do
					if (offset > delta_offset) and (math.abs(node.x - v.x) > delta_offset) then
						Metrostroi.AddARSSubSection(node,signal)
						offset = offset - delta_offset
						count = count + 1
					end

					node = node.next
					if node then
						offset = offset + node.length
					end
				end
			end
			--if count == 0 then
				--print("Could not add any signals for",k)
			--end
		end
	end
	Metrostroi.IgnoreEntityUpdates = false
	Metrostroi.UpdateSignalEntities()

	print(string.format("Metrostroi: Added %d ARS rail joints",Metrostroi.ARSSubSectionCount))
	]]
end


--------------------------------------------------------------------------------
-- Scans an isolated track segment and for every useable segment calls func
--------------------------------------------------------------------------------
local check_table = {}
function Metrostroi.ScanTrack(itype,node,func,x,dir,checked,startx,train)
	if not startx then startx = x end
	local light,ars,switch = itype == "light",itype == "ars",itype == "switch"
	-- Check if this node was already scanned
	if not node then return end
	if not checked then
		for k,v in pairs(check_table) do
			check_table[k] = nil
		end
		checked = check_table
	end
	if checked[node] then return end
	checked[node] = true
	-- Try to use entire node length by default
	local min_x = node.x
	local max_x = min_x + node.length

	-- Get range of node which can be actually sensed
	local isolateForward = false	-- Should scanning continue forward along track
	local isolateBackward = false	-- Should scanning continue backward along track
	if Metrostroi.SignalEntitiesForNode[node] then
		for k,v in pairs(Metrostroi.SignalEntitiesForNode[node]) do
			local isolating = false
			if IsValid(v) then
				if light then
					isolating = ((v.TrackDir == dir and not v.Routes[v.Route or 1].Repeater) or (v.TrackDir == dir and v.Routes[v.Route or 1].Repeater and tonumber(v.RouteNumber) == 9) or (tonumber(v.RouteNumber) ~= nil and v.Routes[v.Route or 1].Repeater)) and not v.PassOcc
				end
				if ars then
					isolating = v.TrackDir == dir
				end
				if switch then
					isolating = v.IsolateSwitches
				end
				--if itype == "ars" then isolating = true end
			end
			if isolating then
				-- If scanning forward, and there's a joint IN FRONT of current X
				if dir and (v.TrackX > x) then
					max_x = math.min(max_x,v.TrackX)
					isolateForward = true
				end
				-- If scanning forward, and there's a joint in current X
				-- This is triggered when traffic light searches for next light from its own X (then
				--  scan direction is defined by dir)
				if dir and (v.TrackX == x) then
					min_x = math.max(min_x,v.TrackX)
					isolateBackward = true
				end
				-- if scanning backward, and there's a joint BEHIND current X
				if (not dir) and (v.TrackX < x) then
					min_x = math.max(min_x,v.TrackX)
					isolateBackward = true
				end
				-- If scanning backward starting from current X, use dir for guiding scan
				if (not dir) and (v.TrackX == x) then
					max_x = math.min(max_x,v.TrackX)
					isolateForward = true
				end
			end
		end
	end

	-- Show the scanned path
	--[[if GetConVarNumber("metrostroi_drawdebug") == 1 then
		local T = CurTime()
		timer.Simple(0.05 + math.random()*0.05,function()
			if node.next then
				debugoverlay.Line(node.pos,node.next.pos,3,Color((T*1234)%255,(T*12345)%255,(T*12346)%255),true)
			end
		end)
	end]]--

	-- Call function for the determined portion of the node
	local results = {func(node,min_x,max_x)}
	if results[1] ~= nil then
		return unpack(results)
	end
	-- First check all the branches, whose positions fall within min_x..max_x
	if node.branches and not ars then
		for k,v in pairs(node.branches) do
			if (v[1] >= min_x) and (v[1] <= max_x) then
				-- FIXME: somehow define direction and X!
				local results = {Metrostroi.ScanTrack(itype,v[2],func,v[1],true,checked,startx)}
				if results[1] ~= nil then return unpack(results) end
			end
		end
	end
	-- If not isolated, continue scanning forward from the front end of node
	if (dir or switch)and (not isolateForward) then
		local results = {Metrostroi.ScanTrack(itype,node.next,func,max_x,true,checked,startx)}
		if results[1] ~= nil then
			return unpack(results)
		end
	end
	-- If not isolated, continue scanning backward from the rear end of node
	if (not dir or switch) and (not isolateBackward) then
		local results = {Metrostroi.ScanTrack(itype,node.prev,func,min_x,false,checked,startx)}
		if results[1] ~= nil then return unpack(results) end
	end
end

--------------------------------------------------------------------------------
-- Get one next traffic light within current isolated segment. Ignores ARS sections.
--------------------------------------------------------------------------------
function Metrostroi.GetSignalByName(signal_name)
	return Metrostroi.SignalEntitiesByName[signal_name]
end

--------------------------------------------------------------------------------
-- Get one next switch by name
--------------------------------------------------------------------------------
function Metrostroi.GetSwitchByName(switch_name)
	if 	Metrostroi.SwitchesByName[switch_name] then
		return Metrostroi.SwitchesByName[switch_name]
	end
	switch_name = tostring(switch_name)
	local Path = tonumber(switch_name:sub(1,1))
	local ID = tonumber(switch_name:sub(2,-1))
	if not Metrostroi.SwitchesByName[Path] then return end
	if switch_name:find("/") then
		if not Metrostroi.SwitchesByName[switch_name] then
			local Switch = string.Explode("/",switch_name)
			Path = tonumber(Switch[1])
			ID = tonumber(Switch[2])
			if not Metrostroi.SwitchesByName[Path] then return end
			Metrostroi.SwitchesByName[switch_name] = Metrostroi.SwitchesByName[Path][ID]
		end
		return Metrostroi.SwitchesByName[switch_name]
	end
	return Metrostroi.SwitchesByName[Path] and Metrostroi.SwitchesByName[Path][ID] or nil
end

--------------------------------------------------------------------------------
-- Get one next traffic light within current isolated segment. Ignores ARS sections.
--------------------------------------------------------------------------------
function Metrostroi.GetNextTrafficLight(src_node,x,dir,include_ars_sections,override_type)
	return Metrostroi.ScanTrack(override_type or "light",src_node,function(node,min_x,max_x)
		-- If there are no signals in node, keep scanning
		if (not Metrostroi.SignalEntitiesForNode[node]) or (#Metrostroi.SignalEntitiesForNode[node] == 0) then
			return
		end

		-- For every signal entity in node, check if it rests on path
		for k,v in pairs(Metrostroi.SignalEntitiesForNode[node]) do
			if IsValid(v) and
				((include_ars_sections) and (v.TrackX ~= x) and --(v:GetTrafficLights() > 0) or
				 (v.TrackX >= min_x) and (v.TrackX <= max_x)) then
				return v
			end
		end
	end,x,dir)
end

local function inRange(x, minx, maxx)
	return minx < x and x < maxx
end
local function ARSJointScan(node,min_x,max_x,train,dir,x)
	-- If there are no signals in node, keep scanning
	local tnode = Metrostroi.TrainPositions[train] and Metrostroi.TrainPositions[train][1]
	if IsValid(train) and Metrostroi.TrainsForNode[node] and #Metrostroi.TrainsForNode[node] > 0 then
		for k,v in pairs(Metrostroi.TrainsForNode[node]) do
			--local found = false
			--for _,train in pairs(train.WagonList) do if v == train then found=true;break end end
			--if found then continue end
			--if v == train or v == train.RearTrain or v == v.FrontTrain then continue end
			local pos = Metrostroi.TrainPositions[v]
			--print(train,v,pos[1].x,tnode.x)
			if pos[1]~=tnode then
				for k2,v2 in pairs(pos) do
					if v2.path == node.path then
						--local pos1 = Metrostroi.GetPositionOnTrack(v:LocalToWorld(Vector(0,1,0)), v:GetAngles())
						--if pos1 then pos1 = pos1[1] end
						--if pos1 and (((pos1.x - v2.x) < 0 and not dir)  or ((pos1.x - v2.x) > 0 and dir)) then continue end
						--local TrackX = v2.TrackX
						--local x1 = v2.x-1100*0.5
						--local x2 = v2.x+1100*0.5

						local x1,x2 = v2.x,v2.x
						if ((x1 >= min_x) and (x1 <= max_x)) then--[[ or
						   ((x2 >= min_x) and (x2 <= max_x)) or
						   ((x1 <= min_x) and (x2 >= max_x)) then]]
							--return false--return true,v
						end
					end
				end
			end
		end
	end
	if (not Metrostroi.SignalEntitiesForNode[node]) or (#Metrostroi.SignalEntitiesForNode[node] == 0) then
		return
	end
	-- For every signal entity in node, check if it rests on path
	for k,v in pairs(Metrostroi.SignalEntitiesForNode[node]) do
		if IsValid(v) then
			--print(dir,v.Name,v.TrackDir,train)
			if dir ~= v.TrackDir and ((v.OutputARS ~= 0) and (v.TrackX ~= x) and
			 (v.TrackX >= min_x) and (v.TrackX <= max_x)) then
				if dir and (v.TrackX > x) then return v end
				if (not dir) and (v.TrackX < x) then return v end
				--print("i lose signal")
			end
		end
	end
end
local function ARSJointScanBack(node,min_x,max_x,train,dir,x,forw)
	if (not Metrostroi.SignalEntitiesForNode[node]) or (#Metrostroi.SignalEntitiesForNode[node] == 0) then
		return
	end
	local node1 = Metrostroi.TrainPositions[train] and Metrostroi.TrainPositions[train][1]
	if not node1 then return false end
	if node.path.id ~= node1.path.id then return end
	-- For every signal entity in node, check if it rests on path
	for k,v in pairs(Metrostroi.SignalEntitiesForNode[node]) do
		if IsValid(v) then
			if dir ~= v.TrackDir and ((v.OutputARS ~= 0) and (v.TrackX ~= x) and
			 (v.TrackX <= min_x) and (v.TrackX >= max_x)) then
				if dir and (v.TrackX > x) then return v end
				if (not dir) and (v.TrackX < x) then return v end
				--print("i lose signal")
			end
		end
	end
end
--------------------------------------------------------------------------------
-- Get next/previous ARS section
--------------------------------------------------------------------------------
function Metrostroi.GetARSJoint(src_node,x,dir,train)
	local forw,back
	if train then
		--[[
		local data = Metrostroi.GetARSJointCache[train:EntIndex()]
		if data then
			if not train.SpeedSing or  (math.abs(train.Speed*train.SpeedSing or 99) > 2 and ((train.Speed*train.SpeedSing > 0 and data.speed > 0) or (train.Speed*train.SpeedSing < 0 and data.speed < 0))) then
				if inRange(x,data.StartX,data.EndX) or inRange(x,data.EndX,data.StartX) then
					--print(data.StartX-data.EndX,train:EntIndex())
					if data.signal and data.signal.TrackPosition and x - data.signal.TrackPosition.x > 4000 then print("Metrostroi:GetARSJoint: Signal is too far") data.signal = nil return end
					if data.signal and data.signal.TrackPosition and data.signal.TrackPosition.x - x > 4000 then print("Metrostroi:GetARSJoint: Signal is too far") data.signal = nil return end
					--if x < data.signal.TrackPosition.x then print(2) end
					if src_node.path.id == data.pathID then
						if data.signal then return data.signal,data.back end
					end
				end
			end
		end
		forw = Metrostroi.ScanTrack("ars",src_node,function(node,min_x,max_x) return ARSJointScan(node,min_x,max_x,train,dir,x) end,x,dir)
		back = Metrostroi.ScanTrack("ars",src_node,function(node,min_x,max_x) return ARSJointScanBack(node,max_x,min_x,train,not dir,x,forw) end,x,not dir)
		if IsValid(forw) and IsValid(back) and false then
			Metrostroi.GetARSJointCache[train:EntIndex()] = {
				StartX = forw.TrackPosition.x,
				EndX = back.TrackPosition.x,
				pathID = src_node.path.id,
				signal = forw,
				back = back,
				speed = train.SpeedSign*train.Speed,
			}
		else
			Metrostroi.GetARSJointCache[train:EntIndex()] = nil
		end]]
		forw = Metrostroi.ScanTrack("ars",src_node,function(node,min_x,max_x) return ARSJointScan(node,min_x,max_x,train,dir,x) end,x,dir)
		back = Metrostroi.ScanTrack("ars",src_node,function(node,min_x,max_x) return ARSJointScanBack(node,max_x,min_x,train,not dir,x,forw) end,x,not dir)
	else
		forw = Metrostroi.ScanTrack("ars",src_node,function(node,min_x,max_x) return ARSJointScan(node,min_x,max_x,train,dir,x) end,x,dir)
	end
	return forw,back
end


--------------------------------------------------------------------------------
-- Get all track switches in an isolated section
--------------------------------------------------------------------------------
function Metrostroi.GetTrackSwitches(src_node,x,dir)
	local switches = {}
	Metrostroi.ScanTrack("switch",src_node,function(node,min_x,max_x)
		-- If there are no signals in node, keep scanning
		if (not Metrostroi.SwitchesForNode[node]) or (#Metrostroi.SwitchesForNode[node] == 0) then
			return
		end

		-- For every entity in node, check if it rests on path
		for k,v in pairs(Metrostroi.SwitchesForNode[node]) do
			if v.TrackPosition and
				(v.TrackPosition.x >= min_x) and (v.TrackPosition.x <= max_x) then
				table.insert(switches,v)
			end
		end
	end,x,dir)

	-- Find similar switches and add them even if they aren't on the same section
	local ent_list = ents.FindByClass("gmod_track_switch")
	local extra_switches = {}
	for k,v in pairs(switches) do
		if v.TrackSwitches[1] then
			local name = v.TrackSwitches[1]:GetName()
			for _,v2 in pairs(ent_list) do
				if v2.TrackSwitches[1] and (v2 ~= v) and (name == v2.TrackSwitches[1]:GetName()) then
					table.insert(extra_switches,v2)
				end
			end
		end
	end

	for k,v in pairs(extra_switches) do table.insert(switches,v) end
	return switches
end


--------------------------------------------------------------------------------
-- Check if there is a train somewhere in the local isolated section. This
-- ignores ARS subsections (if they are unisolated), accounts for traffic lights
--------------------------------------------------------------------------------
function Metrostroi.IsTrackOccupied(src_node,x,dir,t)
	local Trains = {}
	Metrostroi.ScanTrack(t or "light",src_node,function(node,min_x,max_x)
		-- If there are no trains in node, keep scanning
		if (not Metrostroi.TrainsForNode[node]) or (#Metrostroi.TrainsForNode[node] == 0) then
			return
		end

		-- For every train in node, for every path it rests on, check if it's in range
		--print("SCAN TRACK",node.id,min_x,max_x)
		for k,v in pairs(Metrostroi.TrainsForNode[node]) do
			local pos = Metrostroi.TrainPositions[v]
			for k2,v2 in pairs(pos) do
				if v2.path == node.path then
					local x1,x2 = v2.x,v2.x
					if ((x1 >= min_x) and (x1 <= max_x)) or
					   ((x2 >= min_x) and (x2 <= max_x)) or
					   ((x1 <= min_x) and (x2 >= max_x)) then
						table.insert(Trains,v)--return true,v
					end
				end
			end
		end
	end,x,dir)

	return #Trains > 0,Trains[#Trains],Trains[1]
end

--------------------------------------------------------------------------------
-- Update train positions
--------------------------------------------------------------------------------
function Metrostroi.PredictTrainPositions()
	--[[ for train in pairs(Metrostroi.SpawnedTrains) do
		local localSpeed = train:GetVelocity():Dot(train:GetAngles():Forward()) * 0.01905
		local pos = Metrostroi.TrainPositions[train];pos = pos and pos[1]
		if pos then
			train.PosX = train.PosX + localSpeed*FrameTime()
			train.OldPos = pos.x+train.PosX
		end
	end--]]
end
function Metrostroi.UpdateTrainPositions()
	--[[ Metrostroi.TrainPositions = {}
	Metrostroi.TrainDirections = {}
	Metrostroi.TrainsForNode = {}
	-- Query all train types
	for train in pairs(Metrostroi.SpawnedTrains) do
		if train.ALS_ARS and train.ALS_ARS.IgnoreThisARS or train.NoTrain then continue end
		train.PosX = 0--(train:GetVelocity():Dot(train:GetAngles():Forward()) * 0.01905)*FrameTime()
		local pos1e = train.FrontBogey or train
		local positions = Metrostroi.GetPositionOnTrack(pos1e:GetPos(),train:GetAngles())
		local positions2
		if not positions or not positions[1] then
			positions =  Metrostroi.GetPositionOnTrack(train:LocalToWorld(Vector(0,0,0)),train:GetAngles())
			positions2 = Metrostroi.GetPositionOnTrack(train:LocalToWorld(Vector(25,0,0)), train:GetAngles())
		else
			positions2 = Metrostroi.GetPositionOnTrack(pos1e:LocalToWorld(Vector(-25,0,0)), train:GetAngles())
		end
		Metrostroi.TrainPositions[train] = {}
		Metrostroi.TrainDirections[train] = true
		if positions and positions[1] then
			Metrostroi.TrainPositions[train][1] = positions[1]
			if positions2 and positions2[1] then
				Metrostroi.TrainDirections[train] = (positions2[1].x - positions[1].x) > 0
			end
		end

		--print("TRAIN",train,positions[1].path.id,positions2[1].path.id)
		--for k,v in pairs(Metrostroi.TrainPositions[train]) do
			--print(string.format("\t[%d] Path #%d: (%.2f x %.2f x %.2f) m  Facing %s",k,v.path.id,v.x,v.y,v.z,v.forward and "forward" or "backward"))
		--end

		for _,pos in pairs(Metrostroi.TrainPositions[train]) do
			Metrostroi.TrainsForNode[pos.node1] = Metrostroi.TrainsForNode[pos.node1] or {}
			table.insert(Metrostroi.TrainsForNode[pos.node1],train)
		end
	end--]]
end

--------------------------------------------------------------------------------
-- Update stations list
--------------------------------------------------------------------------------
function Metrostroi.UpdateStations()
	Metrostroi.Stations = {}
	local platforms = ents.FindByClass("gmod_track_platform")
	for _,platform in pairs(platforms) do
		local station = Metrostroi.Stations[platform.StationIndex] or {}
		Metrostroi.Stations[platform.StationIndex] = station

		-- Position
		local dir = platform.PlatformEnd - platform.PlatformStart
		local pos1 = Metrostroi.GetPositionOnTrack(platform.PlatformStart,dir:Angle())[1]
		local pos2 = Metrostroi.GetPositionOnTrack(platform.PlatformEnd,dir:Angle())[1]
		if pos1 and pos2 then
			-- Add platform to station
			local platform_data = {
				x_start = pos1.x,
				x_end = pos2.x,
				length = math.abs(pos2.x - pos1.x),
				node_start = pos1.node1,
				node_end = pos2.node1,
				ent = platform,
			}
			if station[platform.PlatformIndex] then
				print(string.format("Metrostroi: Error, station %03d has two platforms %d with same index!",platform.StationIndex,platform.PlatformIndex))
			else
				station[platform.PlatformIndex] = platform_data
			end

			-- Print information
			print(string.format("\t[%03d][%d] %.3f-%.3f km (%.1f m) on path %d",
				platform.StationIndex,platform.PlatformIndex,pos1.x*1e-3,pos2.x*1e-3,
				platform_data.length,platform_data.node_start.path.id))
		else
			print(string.format("Metrostroi: Error, station %03d platform %d, cant find pos! \n\tStart%s \n\tEnd:%s",platform.StationIndex,platform.PlatformIndex,platform.PlatformStart,platform.PlatformEnd))
		end
	end
end


--------------------------------------------------------------------------------
-- Get travel time between two nodes in seconds
--------------------------------------------------------------------------------
function Metrostroi.GetTravelTime(src,dest)
	-- Determine direction of travel
	--assert(src.path == dest.path)
	local direction = src.x < dest.x

	-- Accumulate travel time
	local travel_time = 0
	local travel_dist = 0
	local travel_speed = 20
	local iter = 0
	function scan(node,path)
		local oldx
		local oldars
		while (node) and (node ~= dest) do
			local ars_speed
			local ars_joint = Metrostroi.GetARSJoint(node,node.x+0.01,path or true)
			if ars_joint then
				--[[if oldx and oldx ~= ars_joint.TrackPosition.x then
					print(string.format("\t\t\t%.2f:\t%s->%s",(ars_joint.TrackPosition.x - oldx)/18.8,oldars.Name,ars_joint.Name))
				end
				oldx = ars_joint.TrackPosition.x
				oldars = ars_joint]]
				--print(ars_joint.Name)
				local ARSLimit = ars_joint:GetMaxARS()
				--print(ARSLimit)
				if ARSLimit >= 4  then
					ars_speed = ARSLimit*10
				end
				--print(ars_speed)
			end
			if ars_speed then travel_speed = ars_speed end
			--print(string.format("[%03d] %.2f m   V = %02d km/h",node.id,node.length,ars_speed or 0))

			-- Assume 70% of travel speed
			local speed = travel_speed * 0.82

			-- Add to travel time
			travel_dist = travel_dist + node.length
			travel_time = travel_time + (node.length / (speed/3.6))
			node = node.next
			if not node then break end
			if src.path == dest.path and node.branches and node.branches[1][2].path == src.path then scan(node,src.x > node.branches[1][2].x) end
			if src.path == dest.path and node.branches and  node.branches[2] and node.branches[2][2].path == src.path then scan(node,src.x > node.branches[1][1].x) end
			assert(iter < 10000, "OH SHI~")
			iter = iter + 1
		end
	end
	scan(src)

	return travel_time,travel_dist
end


--------------------------------------------------------------------------------
-- Load track definition and sign definitions
--------------------------------------------------------------------------------

local function getFile(path,name,id)
	local typ = 0
	if file.Exists(string.format(path..".txt",name),"DATA") then typ = bit.bor(typ,2) end
	if file.Exists(string.format(path..".lua",name),"LUA") then typ = bit.bor(typ,1) end
	if typ == 0 then print(string.format("%s definition file not found: %s",id,string.format(path,name))) end
	return typ
end
function Metrostroi.Load(name,keep_signs)
	if not TrackLoadedData then return end
	-- Prepare spatial lookup table
	Metrostroi.SpatialLookup = {}
	local function addLookup(node)
		local kx,ky,kz = spatialPosition(node.pos)

		Metrostroi.SpatialLookup[kz] = Metrostroi.SpatialLookup[kz] or {}
		Metrostroi.SpatialLookup[kz][kx] = Metrostroi.SpatialLookup[kz][kx] or {}
		Metrostroi.SpatialLookup[kz][kx][ky] = Metrostroi.SpatialLookup[kz][kx][ky] or {}
		table.insert(Metrostroi.SpatialLookup[kz][kx][ky],node)
	end

	-- Create paths definition
	Metrostroi.Paths = {}
	if true then return end
	-- print(type(TrackLoadedData))
	for pathID,path in pairs(TrackLoadedData) do
		local currentPath = { id = pathID }
		Metrostroi.Paths[pathID] = currentPath

		-- Count length of path and offset in every node
		currentPath.length = 0
		local prevPos,prevNode
		for nodeID,nodePos in pairs(path) do
			-- Count distance
			local distance = 0
			if prevPos then
				distance = prevPos:Distance(nodePos)*0.01905
				currentPath.length = currentPath.length + distance
			end

			-- Add a node
			currentPath[nodeID] = {
				id = nodeID,
				path = currentPath,

				pos = nodePos,
				x = currentPath.length,
				prev = prevNode,
			}
			if prevNode then
				prevNode.next = currentPath[nodeID]
				prevNode.dir = (nodePos - prevNode.pos):GetNormalized()
				prevNode.vec = nodePos - prevNode.pos
				prevNode.length = distance
			end

			-- Add to spatial lookup
			addLookup(currentPath[nodeID])
			prevPos = nodePos
			prevNode = currentPath[nodeID]
		end

		if prevNode then
			prevNode.next = nil
			prevNode.dir = Vector(0,0,0)
			prevNode.vec = Vector(0,0,0)
			prevNode.length = 0
		end
	end

	-- Find places where tracks link up together
	for pathID,path in pairs(Metrostroi.Paths) do
		if #path == 0 then break end
		-- Find position of end nodes
		local node1,node2 = path[1],path[#path]
		local ignore_path = path
		if game.GetMap():find("orange") and node1.path.id == 1 then
			ignore_path = nil
			--print(node1)
		end
		local pos1 = Metrostroi.GetPositionOnTrack(node1.pos,nil,{ ignore_path = ignore_path })
		local pos2 = Metrostroi.GetPositionOnTrack(node2.pos,nil,{ ignore_path = ignore_path })
		-- Create connection
		local join1,join2
		if pos1[1] then join1 = pos1[1].node1 end
		if pos2[1] then join2 = pos2[1].node1 end

		-- Record it
		if join1 then
			join1.branches = join1.branches or {}
			table.insert(join1.branches,{ pos1[1].x, node1 })
			node1.branches = node1.branches or {}
			table.insert(node1.branches,{ node1.x, join1 })
		end
		if join2 then
			join2.branches = join2.branches or {}
			table.insert(join2.branches,{ pos2[1].x, node2 })
			node2.branches = node2.branches or {}
			table.insert(node2.branches,{ node2.x, join2 })
		end
	end

	-- Initialize stations list
	Metrostroi.UpdateStations()
	-- Print info
	Metrostroi.PrintStatistics()

	-- Ignore updates to prevent created/removed switches from constantly updating table of positions
	Metrostroi.IgnoreEntityUpdates = true

	-- Remove old entities
	if not keep_signs then
		local signals_ents = ents.FindByClass("gmod_track_signal")
		for k,v in pairs(signals_ents) do SafeRemoveEntity(v) end
		local switch_ents = ents.FindByClass("gmod_track_switch")
		for k,v in pairs(switch_ents) do SafeRemoveEntity(v) end
		local signs_ents = ents.FindByClass("gmod_track_signs")
		for k,v in pairs(signs_ents) do SafeRemoveEntity(v) end
		local auto_ents = ents.FindByClass("gmod_track_autodrive_plate")
		for _,v in pairs(auto_ents) do SafeRemoveEntity(v) end

		-- Create new entities (add a delay so the old entities clean up)
		print("Metrostroi: Loading signs, signals, switches...")
		local signs
		if bit.band(signstype,2) > 0 then
			signs= util.JSONToTable(file.Read(string.format("metrostroi_data/signs_%s.txt",name)))
			print("Metrostroi: Loading signs definition...")
		end
		if not signs and bit.band(signstype,1) > 0 then
			signs= util.JSONToTable(file.Read(string.format("metrostroi_data/signs_%s.lua",name),"LUA"))
			print("Metrostroi: Loading default signs definition...")
		end
		if not signs then print("Metrostroi: Signs file is corrupted!") end
		local version
		if signs then
			version = signs.Version
			if not version then
				print("Metrostroi: This signs file is incompatible with signs version")
				signs = nil
			else
				signs.Version = nil
			end
		end
		if signs then
			local TwoToSix = false
			if version ~= 1.2 then
				print(string.format("Metrostroi: !!Converting from version %.1f!! signals converted to %s.",version,TwoToSix and "2/6" or "1/5"))
				if game.GetMap():find("gm_mus_loop") then
					TwoToSix = true
				end
			end
			for k,v in pairs(signs) do
				local ent = ents.Create(v.Class)
				if IsValid(ent) then
					ent:SetPos(v.Pos)
					ent:SetAngles(v.Angles)
					if v.Class == "gmod_track_switch" then
						---CHANGE
						ent:SetChannel(v.Channel or 1)
						ent.LockedSignal = v.LockedSignal
						ent.NotChangePos = v.NotChangePos
						ent.Name = v.Name,
						ent:Spawn()
					end
					if v.Class == "gmod_track_signal" and v.Routes then
						ent.SignalType = v.SignalType
						ent.Name = v.Name
						ent.RouteNumberSetup = v.RouteNumberSetup
						ent.LensesStr = v.LensesStr
						ent.Lenses = string.Explode("-",v.LensesStr)
						ent.RouteNumber = v.RouteNumber
						ent.IsolateSwitches = v.IsolateSwitches
						ent.Routes = v.Routes
						ent.ARSOnly = v.ARSOnly
						ent.Left = v.Left
						ent.Double = v.Double
						ent.DoubleL = v.DoubleL
						ent.Approve0 = v.Approve0
						ent.TwoToSix = v.TwoToSix
						ent.NonAutoStop = v.NonAutoStop
						ent.PassOcc = v.PassOcc
						ent.Lenses = string.Explode("-",ent.LensesStr)
						ent.InS = nil
						for i = 1,#ent.Lenses do
							if ent.Lenses[i]:find("W") then
								ent.InS = i
							end
						end
						if version == 1 and ent.Left then
							print(string.format("Metrostroi: !!Converting from version %.1f!! signal %s rotated.",version,ent.Name))
							ent:SetAngles(ent:LocalToWorldAngles(ent:WorldToLocalAngles(ent:GetAngles())+Angle(0,180,0)))
						end
						if version ~= 1.2 then ent.TwoToSix = TwoToSix end
						ent:Spawn()
					elseif v.Class == "gmod_track_signs" then
						ent.SignType = v.SignType
						ent.YOffset = v.YOffset
						ent.ZOffset = v.ZOffset
						ent.Left = v.Left,
						ent:Spawn()
						ent:SendUpdate()
					elseif v.Class == "gmod_track_signal" then ent:Remove() end
				end
			end
		end

		local auto
		if bit.band(autotype,2) > 0 then
			auto= util.JSONToTable(file.Read(string.format("metrostroi_data/auto_%s.txt",name)))
			print("Metrostroi: Loading autodrive definition...")
		end
		if not auto and bit.band(autotype,1) > 0 then
			auto= util.JSONToTable(file.Read(string.format("metrostroi_data/auto_%s.lua",name),"LUA"))
			print("Metrostroi: Loading default autodrive definition...")
		end
		if auto then
			for k,v in pairs(auto) do
				local ent = ents.Create("gmod_track_autodrive_plate")
				-- print(k,v,ent)
				if IsValid(ent) then
					ent:SetPos(v.Pos)
					ent:SetAngles(v.Angles)
					ent.PlateType = v.Type
					ent.Right = v.Right
					ent.Mode = v.Mode
					ent.Model = v.Model
					ent:SetModel(ent.Model)
					ent:Spawn()
				end
			end
		else
			print("Metrostroi: Signs file is corrupted!")
		end
	end

	timer.Simple(0.05,function()
		-- No more ignoring updates
		Metrostroi.IgnoreEntityUpdates = false
		-- Load ARS entities
		Metrostroi.UpdateSignalEntities()
		-- Load switches
		Metrostroi.UpdateSwitchEntities()
		-- Add additional ARS sections
		Metrostroi.UpdateARSSections()
	end)

	-- Initialize signs
	print("Metrostroi: Initializing signs...")
	Metrostroi.InitializeSigns()
end

--------------------------------------------------------------------------------
-- Save track & sign definitions
--------------------------------------------------------------------------------
function Metrostroi.Save(name)
	if not file.Exists("metrostroi_data","DATA") then
		file.CreateDir("metrostroi_data")
	end
	name = name or game.GetMap()

	-- string.format signs, signal, switch data
	local signs = {}
	local signals_ents = ents.FindByClass("gmod_track_signal")
	if not signals_ents then print("Metrostroi: Signs file is corrupted!") end
	for k,v in pairs(signals_ents) do
		if not Metrostroi.ARSSubSections[v] then
			local Routes = table.Copy(v.Routes)
			for k,v in pairs(Routes) do
				v.LightsExploded = nil
				v.IsOpened = nil
			end
			table.insert(signs,{
				Class = "gmod_track_signal",
				Pos = v:GetPos(),
				Angles = v:GetAngles(),
				SignalType = v.SignalType,
				Name = v.Name,
				RouteNumberSetup = v.RouteNumberSetup,
				LensesStr = v.LensesStr,
				RouteNumber =	v.RouteNumber,
				IsolateSwitches = v.IsolateSwitches,
				ARSOnly = v.ARSOnly,
				Routes = Routes,
				Approve0 = v.Approve0,
				TwoToSix = v.TwoToSix,
				NonAutoStop = v.NonAutoStop,
				Left = v.Left,
				Double = v.Double,
				DoubleL = v.DoubleL,
				AutoStop = v.AutoStop,
				PassOcc = v.PassOcc,
			})
		end
	end
	local switch_ents = ents.FindByClass("gmod_track_switch")
	for k,v in pairs(switch_ents) do
		table.insert(signs,{
			Class = "gmod_track_switch",
			Pos = v:GetPos(),
			Angles = v:GetAngles(),
			Name = v.Name,
			Channel = v:GetChannel(),
			NotChangePos = v.NotChangePos,
			LockedSignal = v.LockedSignal,
		})
	end
	local signs_ents = ents.FindByClass("gmod_track_signs")
	for k,v in pairs(signs_ents) do
		table.insert(signs,{
			Class = "gmod_track_signs",
			Pos = v:GetPos(),
			Angles = v:GetAngles(),
			SignType = v.SignType,
			YOffset = v.YOffset,
			ZOffset = v.ZOffset,
			Left = v.Left,
		})
	end
	signs.Version = Metrostroi.SignalVersion
	-- Save data
	print("Metrostroi: Saving signs and track definition...")
	local data = util.TableToJSON(signs,true)
	file.Write(string.format("metrostroi_data/signs_%s.txt",name),data)
	print(string.format("Saved to metrostroi_data/signs_%s.txt",name))

	local auto = {}
	local auto_ents = ents.FindByClass("gmod_track_autodrive_plate")
	for k,v in pairs(auto_ents) do
		table.insert(auto,{
			Pos = v:GetPos(),
			Angles = v:GetAngles(),
			Type = v.PlateType,
			Right = v.Right,
			Mode = v.Mode,
			Model = v.Model,
		})
	end
	print("Metrostroi: Saving auto definition...")
	local adata = util.TableToJSON(auto,true)
	file.Write(string.format("metrostroi_data/auto_%s.txt",name),adata)
	print(string.format("Saved to metrostroi_data/auto_%s.txt",name))
end


Metrostroi.Load()

--------------------------------------------------------------------------------
-- Print statistics and information about the loaded rail network
--------------------------------------------------------------------------------
function Metrostroi.PrintStatistics()
	local totalLength = 0
	for pathNo,path in pairs(Metrostroi.Paths) do
		totalLength = totalLength + path.length
	end

	print(string.format("Metrostroi: Total %.3f km of paths defined:",totalLength/1000))
	for pathNo,path in pairs(Metrostroi.Paths) do
		print(string.format("\t[%d] %.3f km (%d nodes)",path.id,path.length/1000,#path))
	end

	local count = #Metrostroi.SpatialLookup
	local cells = {}
	for _,z in pairs(Metrostroi.SpatialLookup) do
		count = count + #z
		for _,x in pairs(z) do
			count = count + #x
			for _,y in pairs(x) do
				table.insert(cells,#y)
			end
		end
	end
	print(string.format("Metrostroi: %d tables used for spatial lookup (%d cells)",count,#cells))
	local maxn,avgn = 0,0
	for k,v in pairs(cells) do maxn = math.max(maxn,v) avgn = avgn + v end
	print(string.format("Metrostroi: Most nodes in cell: %d, average nodes in cell: %.2f",maxn,avgn/#cells))
end


local messageTimeout = 0
function Think()
	PervTimerIter = PervTimerIter or CurTime()
	if CurTime()-PervTimerIter <= 0.15 then
		Metrostroi.PredictTrainPositions()
	else
		PervTimerIter = CurTime()
		Metrostroi.UpdateTrainPositions()
	end
	if ((CurTime() - messageTimeout) > 1.0) then
		messageTimeout = CurTime()
		if TrainsPos then
			for ent_id,train in pairs(TrainsPos) do
				--print("ID: "..ent_id.." X: "..train[0].." Y: "..train[1].." Z: "..train[2])
			end
		end
	end
	--RnRecvMessages()
end

--TrackLoadedData - data/metrostroi_data/track_mapname.txt or lua/metrostroi_data/track_mapname.txt
--SignsLoadedData - data/metrostroi_data/signs_mapname.txt or lua/metrostroi_data/signs_mapname.txt
--SchedLoadedData - data/metrostroi_data/sched_mapname.txt or lua/metrostroi_data/sched_mapname.txt

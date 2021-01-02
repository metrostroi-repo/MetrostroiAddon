--------------------------------------------------------------------------------
-- Rerailing, testing whether train is on rails
--------------------------------------------------------------------------------
-- Z Offset for rerailing bogeys
local bogeyOffset = 31
local TRACK_GAUGE = 80 			--Distance between rails
local TRACK_WIDTH = 5.8 		--Width of a single rail
local TRACK_HEIGHT = 10 		--Height of a single rail
local TRACK_CLEARANCE = 150		--Vertical space above the rails that will always be clear of world, also used as rough estimation of train height

--------------------------------------------------------------------------------

local TRACK_SINGLERAIL = (TRACK_GAUGE + TRACK_WIDTH) / 2

local function dirdebug(v1,v2)
	debugoverlay.Line(v1,v1+v2*30,10,Color(255,0,0),true)
end

-- Takes datatable from getTrackData
local function debugtrackdata(data)
	dirdebug(data.centerpos,data.forward)
	dirdebug(data.centerpos,data.right)
	dirdebug(data.centerpos,data.up)
end

-- Helper for commonly used trace
local function traceWorldOnly(pos,dir,col)
	local tr = util.TraceLine({
		start = pos,
		endpos = pos+dir,
		mask = MASK_NPCWORLDSTATIC
	})
	if false then -- Shows all traces done by rerailer
		debugoverlay.Line(tr.StartPos,tr.HitPos,10,col or Color(0,0,255),true)
		debugoverlay.Sphere(tr.StartPos,2,10,Color(0,255,255),true)
	end
	return tr
end

-- Go over the enttable, bogeys and train and reset them
local function resetSolids(enttable,train)
	for k,v in pairs(enttable) do
		if IsValid(k) then
			k:SetSolid(v)
			k:GetPhysicsObject():EnableMotion(true)
		end
	end
	if train ~= nil and IsValid(train) then
		train.FrontBogey:GetPhysicsObject():EnableMotion(true)
		train.RearBogey:GetPhysicsObject():EnableMotion(true)
		if IsValid(train.FrontCouple) then
			train.FrontCouple:GetPhysicsObject():EnableMotion(true)
			train.RearCouple:GetPhysicsObject():EnableMotion(true)
		end

		train:GetPhysicsObject():EnableMotion(true)
	end
end

-- Elevates a position to track level
-- Requires a position in the center of the track
local function ElevateToTrackLevel(pos,right,up)
	local tr1 = traceWorldOnly(pos+up*TRACK_CLEARANCE+right*TRACK_SINGLERAIL,-up*TRACK_CLEARANCE*2)
	local tr2 = traceWorldOnly(pos+up*TRACK_CLEARANCE-right*TRACK_SINGLERAIL,-up*TRACK_CLEARANCE*2)
	--Trace from above the track down to the rails
	if not tr1.Hit or not tr2.Hit then return false end
	return (tr1.HitPos + tr2.HitPos)/2
end

-- Takes position and initial rough forward vector, return table of track data
-- Position needs to be between/below the tracks already, don't use a props origin
-- Only needs a rough forward vector, ent:GetAngles():Forward() suffices
local function getTrackData(pos,forward)
	--Trace down
	--debugoverlay.Cross(pos,5,10,Color(255,0,255),true)
	local tr = traceWorldOnly(pos,Vector(0,0,-500))
	if !tr or !tr.Hit then return false end


	--debugoverlay.Line(tr.StartPos,tr.HitPos,10,Color(0,255,0),true)
	local updir = tr.HitNormal
	local floor = tr.HitPos + updir * (TRACK_HEIGHT * 0.9)
	local right = forward:Cross(updir)

	--Trace right
	local tr = traceWorldOnly(floor,right*500)
	if not tr or not tr.Hit then return false end


	--debugoverlay.Line(tr.StartPos,tr.HitPos,10,Color(0,255,0),true)

	local trackforward = tr.HitNormal:Cross(updir)
	local trackright = trackforward:Cross(updir)

	debugoverlay.Axis(floor,trackforward:Angle(),10,5,true)

	--debugoverlay.Line(pos,pos+trackforward*30,10,Color(255,0,0),true)

	--Trace right with proper right
	local tr1 = traceWorldOnly(floor,trackright*TRACK_GAUGE)
	local tr2 = traceWorldOnly(floor,-trackright*TRACK_GAUGE)
	if not tr1 or not tr2 then return false end


	local floor = (tr1.HitPos+tr2.HitPos)/2

	debugoverlay.Cross(floor,5,10,Color(0,255,0),true)

	local centerpos = ElevateToTrackLevel(floor,trackright,updir)

	if not centerpos then return false end

	debugoverlay.Cross(centerpos,5,10,Color(255,0,0),true)

	local data = {
		forward = trackforward,
		right = trackright,
		up = updir,
		centerpos = centerpos
	}

	return data
end
Metrostroi.RerailGetTrackData = getTrackData


-- Helper function that tries to find trackdata at -z or -ent:Up()
local function getTrackDataBelowEnt(ent)
	local forward = ent:GetAngles():Forward()

	local tr = traceWorldOnly(ent:GetPos(),Vector(0,0,-500))
	if tr.Hit then
		local td = getTrackData(tr.HitPos,forward)
		if td then return td end
	end

	local tr = traceWorldOnly(ent:GetPos(),ent:GetAngles():Up()*-500)
	if tr.Hit then
		local td = getTrackData(tr.HitPos,forward)
		if td then return td end
	end

	return false
end

local function PlayerCanRerail(ply,ent)
	if CPPI and ent.CPPICanTool then
		return ent:CPPICanTool(ply,"metrostroi_rerailer")
	else
		return ply:IsAdmin() or (ent.Owner and ent.Owner == ply)
	end
end

-- ConCMD for rerailer
local function RerailConCMDHandler(ply,cmd,args,fullstring)
	local train = ply:GetEyeTrace().Entity
	if not IsValid(train) then return end


	--If we're aiming at bogeys or wheels
	local nwent = train:GetNW2Entity("TrainEntity")
	if nwent and nwent.SubwayTrain ~= nil then
		train = nwent
	end

	if not PlayerCanRerail(ply,train) then return end

	if train:GetClass() == "gmod_train_bogey" then
		Metrostroi.RerailBogey(train)
	else
		Metrostroi.RerailTrain(train)
	end
end
if SERVER then
	concommand.Add("metrostroi_rerail",RerailConCMDHandler)
end




--------------------------------------------------------------------------------
-- Rerails a single bogey
--------------------------------------------------------------------------------
function Metrostroi.RerailBogey(bogey)
	if timer.Exists("metrostroi_rerailer_solid_reset_"..bogey:EntIndex()) then return false end

	local trackData = getTrackDataBelowEnt(bogey)
	if not trackData then return false end
	bogey:SetPos(trackData.centerpos+trackData.up*(bogey.BogeyOffset or bogeyOffset))
	bogey:SetAngles(trackData.forward:Angle())

	bogey:GetPhysicsObject():EnableMotion(false)

	local solids = {}
	local wheels = bogey.Wheels

	solids[bogey]=bogey:GetSolid()
	bogey:SetSolid(SOLID_NONE)

	if wheels ~= nil then
		solids[wheels]=wheels:GetSolid()
		wheels:SetSolid(SOLID_NONE)
	end

	timer.Create("metrostroi_rerailer_solid_reset_"..bogey:EntIndex(),1,1,function() resetSolids(solids) end )
	return true
end




--------------------------------------------------------------------------------
-- Rerails given train entity
--------------------------------------------------------------------------------
function Metrostroi.RerailTrain(train)

	--Safety checks
	if not IsValid(train) or train.SubwayTrain == nil then return false end
	if train.NoPhysics or not IsValid(train:GetPhysicsObject()) then return false end
	if timer.Exists("metrostroi_rerailer_solid_reset_"..train:EntIndex()) then return false end
	--[[
	--Trace down to get the track
	local tr = traceWorldOnly(train:GetPos(),Vector(0,0,-500))
	if !tr or !tr.Hit then
		tr = traceWorldOnly(train:GetPos(),train:GetAngles():Up()*-500)
		if !tr or !tr.Hit then return false end
	end

	--Get track data below the train
	local trackdata = getTrackData(tr.HitPos+tr.HitNormal*3,train:GetAngles():Forward())
	if !trackdata then return false end
	--]]

	local trackdata = getTrackDataBelowEnt(train)
	if not trackdata then return false end
	local ang = trackdata.forward:Angle()


	--Get the positions of the bogeys if we'd rerail the train now
	local frontoffset=train:WorldToLocal(train.FrontBogey:GetPos())
	frontoffset:Rotate(ang)
	local frontpos = frontoffset+train:GetPos()

	local rearoffset = train:WorldToLocal(train.RearBogey:GetPos())
	rearoffset:Rotate(ang)
	local rearpos=rearoffset+train:GetPos()

	--Get thet track data at these locations
	local tr = traceWorldOnly(frontpos,-trackdata.up*500)
	if !tr or !tr.Hit then return false end
	local frontdata = getTrackData(tr.HitPos+tr.HitNormal*3,trackdata.forward)
	if !frontdata then return false end

	local tr = traceWorldOnly(rearpos,-trackdata.up*500)
	if !tr or !tr.Hit then return false end
	local reardata = getTrackData(tr.HitPos+tr.HitNormal*3,trackdata.forward)
	if !reardata then return false end

	--Find the current difference between the bogeys and the train's model center
	local TrainOriginToBogeyOffset = (train:WorldToLocal(train.FrontBogey:GetPos())+train:WorldToLocal(train.RearBogey:GetPos()))/2

	--Final trains pos is the average of the 2 bogey locations
	local trainpos = (frontdata.centerpos+reardata.centerpos)/2

	--Apply bogey-origin and bogey-track offsets
	trainpos = LocalToWorld(TrainOriginToBogeyOffset*-1,ang,trainpos,ang) + Vector(0,0,(train.FrontBogey.BogeyOffset or bogeyOffset))
	--Not sure if this is neccesary anymore, but I'm not touching this anytime soon

	--Store and set solids
	local entlist = {
		train,
		train.FrontBogey,
		train.RearBogey,
		train.FrontBogey.Wheels,
		train.RearBogey.Wheels,
		train.FrontCouple,
		train.RearCouple
	}

	local solids = {}
	for k,v in pairs(entlist) do
		solids[v]=v:GetSolid()
		v:SetSolid(SOLID_NONE)
	end

	train:SetPos(trainpos)
	train:SetAngles(ang)

	train.FrontBogey:SetPos(train:LocalToWorld(train.FrontBogey.SpawnPos))--frontdata.centerpos+frontdata.up*(train.FrontBogey.BogeyOffset or bogeyOffset))
	train.RearBogey:SetPos(train:LocalToWorld(train.RearBogey.SpawnPos))--reardata.centerpos+reardata.up*(train.FrontBogey.BogeyOffset or bogeyOffset))

	train.FrontBogey:SetAngles(train:LocalToWorldAngles(train.FrontBogey.SpawnAng))--(frontdata.forward*-1):Angle())
	train.RearBogey:SetAngles(train:LocalToWorldAngles(train.RearBogey.SpawnAng))--reardata.forward:Angle())


	if IsValid(train.FrontCouple) then
		train.FrontCouple:SetPos(train:LocalToWorld(train.FrontCouple.SpawnPos))
		train.RearCouple:SetPos(train:LocalToWorld(train.RearCouple.SpawnPos))
		train.FrontCouple:SetAngles(train:LocalToWorldAngles(train.FrontCouple.SpawnAng))
		train.RearCouple:SetAngles(train:LocalToWorldAngles(train.RearCouple.SpawnAng))

		train.FrontCouple:GetPhysicsObject():EnableMotion(false)
		train.RearCouple:GetPhysicsObject():EnableMotion(false)
	end

	train:GetPhysicsObject():EnableMotion(false)

	train.FrontBogey:GetPhysicsObject():EnableMotion(false)
	train.RearBogey:GetPhysicsObject():EnableMotion(false)

	timer.Create("metrostroi_rerailer_solid_reset_"..train:EntIndex(),1,1,function() resetSolids(solids,train) end )
	return true
end

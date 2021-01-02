--------------------------------------------------------------------------------
-- Schedule generator
--------------------------------------------------------------------------------
-- List of all unique routes that can be used in schedule generation
-- 		{ station, platform }
Metrostroi.ScheduleRoutes = Metrostroi.ScheduleRoutes or {}
Metrostroi.SchedulesInitialized = false

-- List of all time intervals in which schedules must be generated
-- 		{ start_time, end_time, route_name, train_interval,
Metrostroi.ScheduleConfiguration = Metrostroi.ScheduleConfiguration or {}

-- List of station names
Metrostroi.StationNames = Metrostroi.StationNames or {}
Metrostroi.StationTitles = Metrostroi.StationTitles or {}
Metrostroi.StationNamesConfiguration = Metrostroi.StationNamesConfiguration or {}

-- AI train behavior configuration
Metrostroi.AIConfiguration = Metrostroi.AIConfiguration or {}

-- Current server time
function Metrostroi.ServerTime()
	return (os.time() % 86400)
end

-- Departure time of last train from first station
Metrostroi.DepartureTime = Metrostroi.DepartureTime or {}
-- Schedule counter
Metrostroi.ScheduleID = Metrostroi.ScheduleID or 0


--------------------------------------------------------------------------------
local function timeToSec(str)
	local x = string.find(str,":")
	if not x then return tonumber(sec) or 0 end

	local min = tonumber(string.sub(str,1,x-1)) or 0
	local sec = tonumber(string.sub(str,x+1)) or 0
	return min*60+sec,min,sec
end

local function prepareRouteData(routeData,name)
	-- Prepare general route information
	routeData.Duration = 0
	routeData.Name = name

	-- Fix up every station
	for i,stationID in ipairs(routeData) do
		routeData[i].ID = i
		routeData[i].TimeOffset = routeData.Duration
		if routeData[i+1] then
			if not Metrostroi.Stations[routeData[i][1]]						then print(Format("No station %d",routeData[i][1])) return end
			if not Metrostroi.Stations[routeData[i][1]][routeData[i][2]]	then print(Format("No platform %d for station %d",routeData[i][2],routeData[i][1])) return end
			if not Metrostroi.Stations[routeData[i+1][1]]					then print(Format("No station %d",routeData[i+1][1])) return end
			if not Metrostroi.Stations[routeData[i+1][1]][routeData[i][2]]	then print(Format("No platform %d for station %d",routeData[i+1][2],routeData[i+1][1])) return end

			-- Get nodes
			local start_node =	Metrostroi.Stations[routeData[i  ][1]][routeData[i  ][2]].node_end
			local end_node =	Metrostroi.Stations[routeData[i+1][1]][routeData[i+1][2]].node_end
			if false and start_node.path ~= end_node.path then
				print(Format("Platform %d for station %d: path %d; Platform %d for station %d: path %d",
					routeData[i  ][2],routeData[i  ][1],start_node.path.id,
					routeData[i+1][2],routeData[i+1][1],end_node.path.id))
				return
			end

			-- Calculate travel time between two nodes
			local travelTime,travelDistance = Metrostroi.GetTravelTime(start_node,end_node)
			-- Add time for startup and slowdown
			travelTime = travelTime + 25

			-- Remember stats
			routeData.Duration = routeData.Duration + travelTime
			routeData[i].TravelTime = travelTime
			routeData[i].TravelDistance = travelDistance

			-- Print debug information
			print(Format("\t\t[%03d-%d]->[%03d-%d]  %02d:%02d min  %4.0f m  %4.1f km/h",
				routeData[i][1],routeData[i][2],
				routeData[i+1][1],routeData[i+1][2],
				math.floor(travelTime/60),math.floor(travelTime)%60,travelDistance,(travelDistance/travelTime)*3.6))
		else
			routeData.LastID = i
			routeData.LastStation = routeData[i][1]
		end
	end

	-- Add a quick lookup
	routeData.Lookup = {}
	for i,_ in ipairs(routeData) do
		routeData.Lookup[routeData[i][1]] = routeData[i]
	end
end

function Metrostroi.InitializeSchedules()
	if Metrostroi.SchedulesInitialized then return end
	Metrostroi.SchedulesInitialized = true

	-- Fix up all routes
	print("Metrostroi: Preparing routes...")
	for routeName,routeData in pairs(Metrostroi.ScheduleRoutes) do
		print(Format("\tTravel distances for preset route '%s':",routeName))
		prepareRouteData(routeData,routeName)
		print(Format("\t\tTotal duration: %02d:%02d min",math.floor(routeData.Duration/60),math.floor(routeData.Duration)%60))
	end
end

function Metrostroi.GenerateSchedule(routeID,starts,ends)
	Metrostroi.InitializeSchedules()
	if not Metrostroi.ScheduleRoutes[routeID] then print("Error generating schedule, line or path not found") return end
	local st = 1
	local fst = not starts
	local en = #Metrostroi.ScheduleRoutes[routeID]
	local fen = not ends
	for k,v in ipairs(Metrostroi.ScheduleRoutes[routeID]) do
		if v[1] == starts and not fst then
			st = k
			fst = true
		end
		if v[1] == ends and not fen then
			en = k
			fen = true
		end
		if fst and fen then break end
	end
	if not fst then print("Metrostroi: Warning! Station "..starts.." not found") st = 1 end
	if not fen then print("Metrostroi: Warning! Station "..ends.." not found") en = #Metrostroi.ScheduleRoutes[routeID] end

	-- Time padding (extra time before schedule starts, wait time between trains)
	local paddingTime = timeToSec("1:30")
	-- Current server time
	local serverTime = Metrostroi.ServerTime()/60
	-- hack
	if routeID == "Line1_Platform2" then
		paddingTime = timeToSec("3:00")
	end

	-- Determine schedule configuration
	local interval
	for _,config in pairs(Metrostroi.ScheduleConfiguration) do
		local t_start = timeToSec(config[1])
		local t_end = timeToSec(config[2])
		if (config[3] == routeID) and (t_start <= serverTime) and (t_end > serverTime) then
			interval = timeToSec(config[4])
		end
	end

	-- If no interval, then no schedules available
	if not interval then return end

	-- If no schedules started
	if not Metrostroi.DepartureTime[routeID] then
		Metrostroi.DepartureTime[routeID] = serverTime + paddingTime/60
	else
		-- If schedules started, depart with interval
		Metrostroi.DepartureTime[routeID] = math.max(Metrostroi.DepartureTime[routeID] + interval/60,serverTime + paddingTime/60)
	end

	-- Create new schedule
	Metrostroi.ScheduleID = Metrostroi.ScheduleID + 1
	local schedule = {
		ScheduleID = Metrostroi.ScheduleID,
		Interval = interval,
		Duration = Metrostroi.ScheduleRoutes[routeID].Duration,
	}

	-- Fill out all stations
	local currentTime = Metrostroi.DepartureTime[routeID]
	for id,stationData in ipairs(Metrostroi.ScheduleRoutes[routeID]) do
		if st > id or id > en then continue end
		-- Calculate stop time
		local stopTime = 15
--		if not stationData.TravelTime then stopTime = 0 end

		-- Add entry
		schedule[#schedule+1] = {
			stationData[1],				-- Station
			stationData[2],				-- Platform
			currentTime+stopTime/60,		-- Departure time
			currentTime,				-- Arrival time
		}

		schedule[#schedule].arrivalTimeStr =
			Format("%02d:%02d:%02d",
				math.floor(schedule[#schedule][3]/60),
				math.floor(schedule[#schedule][3])%60,
				math.floor(schedule[#schedule][3]*60)%60)

		-- Add travel time
		if stationData.TravelTime then
			currentTime = currentTime + (stationData.TravelTime + stopTime)/60
		end
	end

	-- Fill out start and end
	schedule.StartStation = schedule[1][1]
	schedule.EndStation = schedule[#schedule][1]
	schedule.StartTime = schedule[1][2]
	schedule.EndTime = schedule[#schedule][2]

	-- Print result
	print(Format("--- %03d --- From %03d to %03d --------------------",
		schedule.ScheduleID,schedule.StartStation,schedule.EndStation))
	for i,d in ipairs(schedule) do
		print(Format("\t%03d   %s",d[1],d.arrivalTimeStr))
	end
	return schedule
end

function Metrostroi.LoadSchedulesData(data)
	Metrostroi.ScheduleRoutes = data.Routes or {}
	Metrostroi.ScheduleConfiguration = data.Configuration or {}
	Metrostroi.StationNames = data.StationNames or {}
	Metrostroi.StationTitles = data.StationTitles or {}
	Metrostroi.AIConfiguration = data.AIConfiguration or {}
	Metrostroi.StationNamesConfiguration = data.StationNamesConfiguration or {}
	Metrostroi.SchedulesInitialized = false
	timer.Simple(3.0,function()
		Metrostroi.InitializeSchedules()
		Metrostroi.DepartureTime = {}
		Metrostroi.ScheduleID = 0
		for k,v in pairs(Metrostroi.TrainClasses) do
			if  v == "gmod_subway_base" then continue end
			local ents = ents.FindByClass(v)
			for k2,v2 in pairs(ents) do
				if v2.Schedule then v2.Schedule = nil end
			end
		end
	end)
end

concommand.Add("metrostroi_resetschedules", function(ply, _, args)
	if not ply:IsAdmin() then return end
	Metrostroi.DepartureTime = {}
	Metrostroi.ScheduleID = 0
	for k,v in pairs(Metrostroi.TrainClasses) do
		if  v == "gmod_subway_base" then continue end
		local ents = ents.FindByClass(v)
		for k2,v2 in pairs(ents) do
			if v2.Schedule then v2.Schedule = nil end
		end
	end
end)
concommand.Add("metrostroi_schedule1", function(ply, _, args)
	Metrostroi.GenerateSchedule("Line1_Platform1")
end)

concommand.Add("metrostroi_schedule2", function(ply, _, args)
	Metrostroi.GenerateSchedule("Line1_Platform2")
end)
concommand.Add("metrostroi_print_scheduleinfo", function(ply, _, args)
	for routeName,routeData in pairs(Metrostroi.ScheduleRoutes) do
		print(Format("\tTravel distances for preset route '%s':",routeName))
		prepareRouteData(routeData,routeName)
		print(Format("\t\tTotal duration: %02d:%02d min",math.floor(routeData.Duration/60),math.floor(routeData.Duration)%60))
	end
end)

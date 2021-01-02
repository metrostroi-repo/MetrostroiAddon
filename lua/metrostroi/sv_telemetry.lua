--local canPost = true
local function onDispatcherMessage(msg)
	if string.sub(msg,1,1) == "@" then
		local cmd = string.Explode(",",string.sub(msg,2))
		if cmd[1] == "red" then
			for k,v in pairs(Metrostroi.TrafficLights) do
				if v:IsValid() and (v.EquipmentID == tonumber(cmd[2])) then
					v.TelemetryOverrideToRed = true
					if Metrostroi.TrafficLightStates[v] then
						Metrostroi.TrafficLightStates[v].state = -1
					end
				end
			end
		elseif cmd[1] == "auto" then
			for k,v in pairs(Metrostroi.TrafficLights) do
				if v:IsValid() and (v.EquipmentID == tonumber(cmd[2])) then
					v.TelemetryOverrideToRed = nil
					if Metrostroi.TrafficLightStates[v] then
						Metrostroi.TrafficLightStates[v].state = -1
					end
				end
			end
		end
		
		print("Dispatcher command: "..msg)
	else
		PrintMessage(HUD_PRINTTALK,"Dispatcher: "..msg)
		print("Dispatcher: "..msg)
	
		Metrostroi.DriverChatBacklog["global"] =
			Metrostroi.DriverChatBacklog["global"] or {}
			
		table.insert(Metrostroi.DriverChatBacklog["global"],"Dispatcher: "..msg)
	end
end

local function onSuccess(content)
	local data = string.Explode("\n",content)
	if data[1] == "OK" then
		for i=2,#data do
			if data[i] and (data[i] ~= "") then
				onDispatcherMessage(data[i])
			end
		end
	end

--	print(content)
end
local function onFailure(reason)

end




--------------------------------------------------------------------------------
-- Sends asynchronous HTTP request
--------------------------------------------------------------------------------
--timer.Simple(0.01, function() require("socket") end)

local s
local http_data
function Metrostroi.HTTPRequest(request)
	if not socket then return end
	
	-- Process data
--	print(string.gsub(data," ","+"))

	-- Re-create socket
	if s then s:close() end
	s = socket.connect("foxworks.wireos.com", 80)
	s:settimeout(0.00)
--	s:send("GET /metrostroi/ms-act.php HTTP/1.1\n")
	s:send("POST /metrostroi/ms-act.php HTTP/1.0\n")
	s:send("Host: foxworks.wireos.com\n")
	s:send("User-Agent: GMod10\n")
	s:send("Connection: Close\n")
	s:send("Content-Type: application/x-www-form-urlencoded\n")
	s:send("Content-Length: "..#request.."\n")
	s:send("\n")
	s:send(request)
	http_data = ""

	-- Create timer
	timer.Create("Metrostroi_HTTPRequest",0.01,0,function()
		if not s then return end
		s:settimeout(0.00)
		local data, status, rdata = s:receive(2^10)
		data = data or rdata
		
		-- Gather HTTP data
		if data then http_data = http_data .. data end

		-- Check timeout/error
		if status and (status ~= "timeout") then
			local data = string.Explode("\r\n\r\n",http_data)
			table.remove(data,1)
			local content = string.Implode("\n\n",data)
			
			timer.Destroy("Metrostroi_HTTPRequest")
			onSuccess(content)
		end
	end)
end

	




--------------------------------------------------------------------------------
-- Generate HTTP request
--------------------------------------------------------------------------------
local function bool2str(b) if b then return "1" else return "0" end end
Metrostroi.TrafficLightStates = {}
Metrostroi.SwitchStates = {}
function Metrostroi.UpdateTelemetry()
	if true then return end
	if not Metrostroi.TrainPositions then return end
	
	local request = "query=update&r={ \"trains\": {"
	local f = false
	for train,data in pairs(Metrostroi.TrainPositions) do
		if train:IsValid() and train.WagonID then
			if f == true then request = request.."," end
			if f == false then f = true end

--			print(train.WagonID)
			request = request.."\""..train.WagonID.."\": {"
	
			request = request.."\"wid\":"..train.WagonID..","
			request = request.."\"tid\":"..train.TrainID..","
			request = request.."\"mod\":"..train.Mode..","
			request = request.."\"pos\":"..Format("%.1f",data.position)..","
			request = request.."\"sec\":"..Format("%d",	data.section)..","
			request = request.."\"pth\":"..Format("%d",	data.path)..","
			
			if train.NextLightRed then
				request = request.."\"nxt\":1,"
			elseif train.NextLightYellow then
				request = request.."\"nxt\":2,"
			else
				request = request.."\"nxt\":3,"
			end
			
			request = request.."\"spd\":"..Format("%.1f",train.Speed or 0)..","
			request = request.."\"ars\":"..Format("%.1f",train.ARSSpeed or -1)..","
			
			if train.Reverse then
				request = request.."\"d1\":"..bool2str(train.DoorState[1])..","
				request = request.."\"d2\":"..bool2str(train.DoorState[0])..","
			else
				request = request.."\"d1\":"..bool2str(train.DoorState[0])..","
				request = request.."\"d2\":"..bool2str(train.DoorState[1])..","
			end
			request = request.."\"l1\":"..bool2str(train.LightState[0])..","
			request = request.."\"l2\":"..bool2str(train.LightState[1])..","
			request = request.."\"r\":"..bool2str(train.Reverse)..","
			request = request.."\"m\":"..bool2str(train.MasterTrain == nil)..","
			request = request.."\"at\":"..bool2str(train.AlternateTrack)..","
			request = request.."\"sat\":"..bool2str(train.SelectAlternateTrack)..","
			request = request.."\"atb\":"..bool2str(train.AlternateTrackBlocked)
			
			--[[Metrostroi.DriverChatBacklog[train] = Metrostroi.DriverChatBacklog[train] or {}
			local chatlog = "{"
			for k,v in pairs(Metrostroi.DriverChatBacklog[train]) do
				chatlog = chatlog.."\""..k.."\":".."\""..v.."\""
				if k ~= #Metrostroi.DriverChatBacklog[train] then
					chatlog = chatlog..","
				end
			end
			Metrostroi.DriverChatBacklog[train] = {}
			request = request.."\"log\":"..chatlog.."}" ]]--
			
			request = request.."}"
		end
	end
	request = request.."},"
	request = request.."\"chat\":{"
	
	local i = 1
	local f = false
	for train,data in pairs(Metrostroi.DriverChatBacklog) do
		if (train ~= "global") and train:IsValid() then
			for k,v in pairs(data) do
				if f == true then request = request.."," end
				f = true
				
				request = request.."\""..i.."\":{"
					request = request.."\"t\":".."\""..v.."\","
					request = request.."\"w\":".."\""..train.WagonID.."\""
				request = request.."}"
				i = i + 1
			end
			Metrostroi.DriverChatBacklog[train] = {}
		else
			for k,v in pairs(data) do
				if f == true then request = request.."," end
				f = true
	
				request = request.."\""..i.."\":{"
					request = request.."\"t\":".."\""..v.."\","
					request = request.."\"w\":".."\"global\""
				request = request.."}"
				i = i + 1
			end
			Metrostroi.DriverChatBacklog[train] = {}
		end
	end

	request = request.."},"
	request = request.."\"lights\":{"
	local f = false
	for light,data in pairs(Metrostroi.TrafficLightPositions) do
		if light:IsValid() and light.EquipmentID then
			local bits = 0
			if light.LightStates[1] then bits = bits + 1 end
			if light.LightStates[2] then bits = bits + 2 end
			if light.LightStates[3] then bits = bits + 4 end
			
			if (not Metrostroi.TrafficLightStates[light]) or
				 (Metrostroi.TrafficLightStates[light].state ~= bits) or
				 (CurTime() - Metrostroi.TrafficLightStates[light].time > 120) then
				if f == true then request = request.."," end
				f = true
				Metrostroi.TrafficLightStates[light] = {
					state = bits,
					time = CurTime(),
				}
				
				request = request.."\""..light.EquipmentID.."\": {"
				request = request.."\"id\":"..light.EquipmentID..","
				request = request.."\"state\":"..bits..","
				request = request.."\"ovrd\":"..bool2str(light.TelemetryOverrideToRed)..","
				request = request.."\"pos\":"..Format("%.1f",data.position)..","
				request = request.."\"pth\":"..Format("%d",	data.path)..","
				request = request.."\"fwd\":"..bool2str(data.forward_facing)..","
				request = request.."\"lgh\":\""..string.lower(light.TrafficLight).."\" "
				request = request.."}"
			end
		end
	end
	--[[request = request.."\"switches\":{"
	local f = false
	for index,switch in pairs(Metrostroi.PicketSignByIndex) do
		if switch:IsValid() and switch.TrackSwitchName then
			local state = switch:GetTrackSwitchState()

			if (not Metrostroi.SwitchStates[switch]) or
				 (Metrostroi.SwitchStates[switch].state ~= bits) or
				 (CurTime() - Metrostroi.SwitchStates[switch].time > 120) then
				if f == true then request = request.."," end
				f = true
				Metrostroi.SwitchStates[switch] = {
					state = state,
					time = CurTime(),
				}

				request = request.."\""..index.."\": {"
				request = request.."\"id\":"..index..","
				request = request.."\"state\":"..bool2str(state)
				request = request.."}"
			end
		end
	end]]--
	request = request.."}}"
	Metrostroi.HTTPRequest(request)
--	print(request)
--	http.Post("http://foxworks.wireos.com/metrostroi/ms-act.php",{ r = request, query = "update" },onSuccess,onFailure)
--	print("POST",CurTime())
end

timer.Create("Metrostroi_UpdateTelemetry",1.0,0,Metrostroi.UpdateTelemetry)




--------------------------------------------------------------------------------
-- Get driver chats
--------------------------------------------------------------------------------
if not Metrostroi.DriverChatBacklog then
	Metrostroi.DriverChatBacklog = {}
end

--[[hook.Add("PlayerSay", "Metrostroi_PlayerSay", function(ply,text,team)
	local name = ply:GetName()
	local trains = ents.FindInSphere(ply:GetPos(),768) --512)
	local train = nil
	for k,v in pairs(trains) do
		if v.IsSubwayTrain then train = v end
	end
	
	if not train then
		local trains = ents.FindByClass("gmod_subway_81-717")
		if trains[1] then train = trains[1] end
		name = name.."[a]"
	end

	if train then
		Metrostroi.DriverChatBacklog[train] = Metrostroi.DriverChatBacklog[train] or {}
		table.insert(Metrostroi.DriverChatBacklog[train],name..": "..text)
	end
	return text
end)]]--
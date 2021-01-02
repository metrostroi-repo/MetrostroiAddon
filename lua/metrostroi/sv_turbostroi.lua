--------------------------------------------------------------------------------
-- Simulation acceleration DLL support
--------------------------------------------------------------------------------
if Turbostroi and Turbostroi.SetMTAffinityMask then return end
local turbostroiTrains = {}
if not TURBOSTROI then
	local FPS = 33
	local messageTimeout = 0
	local messageCounter = 0
	local dataCache = {{},{}}
	hook.Add("EntityRemoved","Turbostroi",function(ent)
		if dataCache[ent] then
			dataCache[ent] = nil
		end
		if turbostroiTrains[ent] then
			turbostroiTrains[ent] = nil
		end
	end)
	for k,ent in pairs(ents.GetAll()) do
		if ent.Base == "gmod_subway_base" and not ent.NoTrain and not ent.DontAccelerateSimulation then
			turbostroiTrains[ent] = true
		end
	end
	hook.Add("OnEntityCreated","Turbostroi",function(ent)
		timer.Simple(0,function()
			if IsValid(ent) and ent.Base == "gmod_subway_base" and not ent.NoTrain and not ent.DontAccelerateSimulation then
				turbostroiTrains[ent] = true
			end
		end)
	end)
	local inputCache = {}
	local id,system,name,index,value
	local function updateTrains(trains)
		--local recvMessage = Turbostroi.RecvMessage
		-- Get data packets from simulation
		for train in pairs(trains) do
			if not dataCache[train] then
				Turbostroi.SendMessage(train,5,"","",0,0)
				dataCache[train] = {wiresW = {}}

				for sys_name,system in pairs(train.Systems) do
					if system.OutputsList and system.DontAccelerateSimulation then
						for _,name in pairs(system.OutputsList) do
							local value = system[name] or 0
							if type(value) == "boolean" then value = value and 1 or 0 end
							if type(value) == "number" then
								if not dataCache[train][sys_name] then dataCache[train][sys_name] = {} end
								dataCache[train][sys_name][name] = math.Round(value)
							end
						end
					end
				end
			end
			local systems = train.Systems
			local twWritersID = train.TrainWireWritersID
			local twTurbostroi = train.TrainWireTurbostroi
			local tti = train.TriggerTurbostroiInput
			while true do
				id,system,name,index,value = Turbostroi.RecvMessage(train)
				--print(id,system,name,index,value)
			--while true do --OLDTURBOSTROI
				--id,system,name,index,value = Turbostroi.RecvMessage(train)
				if id == 1 then
					if systems[system] then
						systems[system][name] = value
						if tti then tti(train,system,name,value) end
					end
				end
				if id == 2 then
					if index == 0 and name ~= "bass" then index = nil end
					if value == 0 and name ~= "bass" then value = nil end
					if name == "" then name = nil end
						--net.WriteString(name)
					train:PlayOnce(system,name,index,value)
				end
				if id == 3 then
					if name == "on" then
						--print("[!]Wire "..index.." starts update! Value "..value)
						dataCache[train]["wiresW"][index] = value
						--train:WriteTrainWire(index,value)
						if not twWritersID[index] then twWritersID[index] = true end
						twTurbostroi[index] = value
						if tti then tti(train,"TrainWire",index,value) end
					else
						--print("[!]Wire "..index.." stop update!")
						dataCache[train]["wiresW"][index] = nil
					end
				end
				if id == 4 then
					if systems[system] then
						systems[system]:TriggerInput(name,value)
					end
				end
				--[[if id == 5 then
					for twid,value in pairs(dataCache[train]["wiresW"]) do
						--train:WriteTrainWire(twid,value)
					end
				end]]

				if not id then break end
				messageCounter = messageCounter + 1
			end
		--[[
		end
		-- Send train wire values
		-- Output all system values
		for train in pairs(trains) do
		]]
			for i in pairs(train.TrainWires) do
				if not dataCache[train]["wires"] then dataCache[train]["wires"] = {} end
				if dataCache[train]["wires"][i] ~= train:ReadTrainWire(i) then
					Turbostroi.SendMessage(train,3,"","",i,train:ReadTrainWire(i))
					dataCache[train]["wires"][i] = train:ReadTrainWire(i)
				end
			end
			for sys_name,system in pairs(train.Systems) do
				if system.OutputsList and system.DontAccelerateSimulation then
					for _,name in pairs(system.OutputsList) do
						local value = system[name] or 0
						if type(value) == "boolean" then
							value = value and 1 or 0
						end
						if type(value) == "number" then
							value = math.Round(value)
							if not dataCache[train][sys_name] then dataCache[train][sys_name] = {} end
							if dataCache[train][sys_name][name] ~= value then
								Turbostroi.SendMessage(train,1,sys_name,name,0,value)
								dataCache[train][sys_name][name] = value
							end
						end
					end
				end
			end
		end
	end

	if Turbostroi then
		function Turbostroi.TriggerInput(train,system,name,value)
			local v = value or 0
			if type(value) == "boolean" then v = value and 1 or 0 end
				Turbostroi.SendMessage(train,4,system,name,0,v)
			--end
		end
		hook.Add("Think", "Turbostroi_Think", function()
			if not Turbostroi then return end

			-- Proceed with the think loop
			Turbostroi.SetSimulationFPS(FPS)
			Turbostroi.SetTargetTime(CurTime())
			Turbostroi.Think()

			-- Update all types of trains
			--for k,v in ipairs(turbostroiTrains) do
				updateTrains(turbostroiTrains)
			--end

			-- HACK
			GLOBAL_SKIP_TRAIN_SYSTEMS = nil

			-- Print stats
			if ((CurTime() - messageTimeout) > 1.0) then
				messageTimeout = CurTime()
				--RunConsoleCommand("say",Format("Metrostroi: %d messages per second (%d per tick)",messageCounter,messageCounter / FPS))
				messageCounter = 0
			end
		end)
	end
	return
end




--------------------------------------------------------------------------------
-- Turbostroi scripts
--------------------------------------------------------------------------------
Metrostroi = {}
local dataCache = {wires = {},wiresW = {},wiresL = {}}
Metrostroi.BaseSystems = {} -- Systems that can be loaded
Metrostroi.Systems = {} -- Constructors for systems

LoadSystems = {} -- Systems that must be loaded/initialized
GlobalTrain = {} -- Train emulator
GlobalTrain.Systems = {} -- Train systems
GlobalTrain.TrainWires = {}
GlobalTrain.WriteTrainWires = {}

function CurTime() return CurrentTime end

function Metrostroi.DefineSystem(name)
	TRAIN_SYSTEM = {}
	Metrostroi.BaseSystems[name] = TRAIN_SYSTEM

	-- Create constructor
	Metrostroi.Systems[name] = function(train,...)
		local tbl = { _base = name }
		local TRAIN_SYSTEM = Metrostroi.BaseSystems[tbl._base]
		if not TRAIN_SYSTEM then print("No system: "..tbl._base) return end
		for k,v in pairs(TRAIN_SYSTEM) do
			if type(v) == "function" then
				tbl[k] = function(...)
					if not Metrostroi.BaseSystems[tbl._base][k] then
						print("ERROR",k,tbl._base)
					end
					return Metrostroi.BaseSystems[tbl._base][k](...)
				end
			else
				tbl[k] = v
			end
		end

		tbl.Initialize = tbl.Initialize or function() end
		tbl.Think = tbl.Think or function() end
		tbl.Inputs = tbl.Inputs or function() return {} end
		tbl.Outputs = tbl.Outputs or function() return {} end
		tbl.TriggerInput = tbl.TriggerInput or function() end
		tbl.TriggerOutput = tbl.TriggerOutput or function() end

		tbl.Train = train
		tbl:Initialize(...)
		tbl.OutputsList = tbl:Outputs()
		tbl.InputsList = tbl:Inputs()
		tbl.IsInput = {}
		for k,v in pairs(tbl.InputsList) do tbl.IsInput[v] = true end
		return tbl
	end
end

function GlobalTrain.LoadSystem(self,a,b,...)
	local name
	local sys_name
	if b then
		name = b
		sys_name = a
	else
		name = a
		sys_name = a
	end

    if not Metrostroi.Systems[name] then print("Error: No system defined: "..name) return end
    if self.Systems[sys_name] then print("Error: System already defined: "..sys_name)  return end

	self[sys_name] = Metrostroi.Systems[name](self,...)
	--if (name ~= sys_name) or (b) then self[sys_name].Name = sys_name end
	self[sys_name].Name = sys_name
	self[sys_name].BaseName = name
	self.Systems[sys_name] = self[sys_name]

	local no_acceleration = Metrostroi.BaseSystems[name].DontAccelerateSimulation

	-- Don't simulate on here
	if no_acceleration then
		self.Systems[sys_name].Think = function() end
		self.Systems[sys_name].TriggerInput = function(train,name,value)
			local v = value or 0
			if type(value) == "boolean" then v = value and 1 or 0 end
				SendMessage(4,sys_name,name,0,v) end

	--Precache values
	elseif self[sys_name].OutputsList then
		dataCache[sys_name] = {}
		for _,name in pairs(self[sys_name].OutputsList) do
			dataCache[sys_name][name] = 0--self[sys_name][name] or 0
		end
	end
end

function GlobalTrain.PlayOnce(self,soundid,location,range,pitch)
	SendMessage(2,soundid or "",location or "",range or 0,pitch or 0)
end

function GlobalTrain.ReadTrainWire(self,n)
	return self.TrainWires[n] or 0
end

function GlobalTrain.WriteTrainWire(self,n,v)
	self.WriteTrainWires[n] = v
end



local _GENREPORT = false
local _REPORT = {}

--------------------------------------------------------------------------------
-- Main train code (turbostroi side)
--------------------------------------------------------------------------------
print("[!] Train initialized!")
function Think()
	-- This is just blatant copy paste from init.lua of base train entity
	local self = GlobalTrain
	----------------------------------------------------------------------------
	self.PrevTime = self.PrevTime or CurTime()
	self.DeltaTime = (CurTime() - self.PrevTime)

	-- Is initialized?
	if not self.Initialized then return end

	-- Perform data exchange
	DataExchange()
	if not messageTimeout or ((CurTime() - messageTimeout) > 1.0) then
		messageTimeout = CurTime()
		--print(string.format("Metrostroi: %d messages per second (~%d per tick)",messageCounter,messageCounter / (1/self.DeltaTime)))

		if _GENREPORT then
			local totalALl = 0
			print("[!] Performance report:")
			for sys_name,iters in pairs(_REPORT) do
				if #iters == 1 then
					if self[sys_name].BaseName ~= "Relay" and iters[1] > 0 then print(string.format("[!] -System:%s took:%.3f ~fps:%03d",sys_name,iters[1],1/iters[1])) end
					totalALl = totalALl + iters[1]
				else
					--if self[sys_name].BaseName ~= "Relay" then print(string.format("[!] -System:%s",sys_name)) end
					local total = 0
					for i,took in ipairs(iters) do
						--print(string.format("[!] --I:%02d took:%.3f ~fps:%03d",i,took,1/took))
						total = total + took
					end
					if self[sys_name].BaseName ~= "Relay" and total > 0 then print(string.format("[!] -System:%s Total:%.3f ~fps:%03d",sys_name,total,1/total)) end
					totalALl = totalALl + total
				end
			end
			print(string.format("[!] -Total report:%.3f ~fps:%03d",totalALl,1/totalALl))
		end
		messageCounter = 0
	end
	-- Run iterations on systems simulation
	if _GENREPORT then
		_REPORT = {}
		-- Simulate according to schedule
		for i,s in ipairs(self.Schedule) do
			for k,v in ipairs(s) do
				if not _REPORT[v.Name] then _REPORT[v.Name] = {} end
				local time = os.clock()
				v:Think(self.DeltaTime / (v.SubIterations or 1),i)
				table.insert(_REPORT[v.Name],os.clock()-time)
			end
		end
	else
		-- Simulate according to schedule
		for i,s in ipairs(self.Schedule) do
			for k,v in ipairs(s) do
				v:Think(self.DeltaTime / (v.SubIterations or 1),i)
			end
		end
	end
	self.PrevTime = CurTime()
end


function Initialize()
	print("[!] Loading systems")
	local time = os.clock()
	for k,v in pairs(LoadSystems) do
		GlobalTrain:LoadSystem(k,v)
	end
	print(string.format("[!] -Took %.2fs",os.clock()-time))

	local iterationsCount = 1
	if (not GlobalTrain.Schedule) or (iterationsCount ~= GlobalTrain.Schedule.IterationsCount) then
		GlobalTrain.Schedule = { IterationsCount = iterationsCount }
		local SystemIterations = {}

		-- Find max number of iterations
		local maxIterations = 0
		for k,v in pairs(GlobalTrain.Systems) do
			SystemIterations[k] = (v.SubIterations or 1)
			maxIterations = math.max(maxIterations,(v.SubIterations or 1))
		end

		-- Create a schedule of simulation
		for iteration=1,maxIterations do
			GlobalTrain.Schedule[iteration] = {}
			-- Populate schedule
			for k,v in pairs(GlobalTrain.Systems) do
				if ((iteration)%(maxIterations/(v.SubIterations or 1))) == 0 then
					table.insert(GlobalTrain.Schedule[iteration],v)
				end

			end
		end
	end
	--dataCache = {}
	-- Output all variable values
	GlobalTrain.Initialized = true
end
messageCounter = 0
function DataExchange()
	-- Get data packets
	local id,system,name,index,value
	while true do
		id,system,name,index,value = RecvMessage()
		messageCounter = messageCounter + 1
		if id == 1 then
			if GlobalTrain.Systems[system] then
				GlobalTrain.Systems[system][name] = value
			end
		end
		if id == 3 then
			dataCache["wiresW"][index] = value
		end
		if id == 4 then
			if GlobalTrain.Systems[system] then
				GlobalTrain.Systems[system]:TriggerInput(name,value)
			end
		end
		if id == 5 then
			dataCache["wiresL"] = {}
		end
		if not id then break end
	end
	for twid,value in pairs(dataCache["wiresW"]) do
		GlobalTrain.TrainWires[twid] = value
	end

	-- Output all variable values
	for sys_name,system in pairs(GlobalTrain.Systems) do
		if system.OutputsList and (not system.DontAccelerateSimulation) then
			for _,name in pairs(system.OutputsList) do
				local value = (system[name] or 0)
				--if type(value) == "boolean" then value = value and 1 or 0 end
				if not dataCache[sys_name] then print(sys_name) end
				if dataCache[sys_name][name] ~= value then
					SendMessage(1, sys_name , name, 0, tonumber(value) or 0)
					dataCache[sys_name][name] = value
				end
			end
		end
	end
	--print(CurTime(),GlobalTrain.DeltaTime)
	-- Output train wire writes
	for twID,value in pairs(GlobalTrain.WriteTrainWires) do
		--local value = tonumber(value) or 0
		if dataCache["wires"][twID] ~= value then
			dataCache["wires"][twID] = value
			dataCache["wiresL"][twID] = false
		end
		if not dataCache["wiresL"][twID] or dataCache["wiresL"][twID]~=GlobalTrain.PrevTime then
			SendMessage(3, "", "on", tonumber(twID) or 0, dataCache["wires"][twID])
		end
		GlobalTrain.WriteTrainWires[twID] = nil
		dataCache["wiresL"][twID] = CurTime()
	end
	for twID,time in pairs(dataCache["wiresL"]) do
		if time~=CurTime() then
			SendMessage(3, "", "off", tonumber(twID) or 0, 0)
			--print("[!]Wire "..twID.." stops update!")
			dataCache["wiresL"][twID] = nil
		end
	end
	SendMessage(5,"","",0,0)
end

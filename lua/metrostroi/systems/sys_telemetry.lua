--------------------------------------------------------------------------------
-- Telemetry writer
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("Telemetry")

function TRAIN_SYSTEM:Initialize(parameters,extra_parameters)
	if extra_parameters then
		self.SystemsList = extra_parameters
		table.sort(self.SystemsList)
	end
	self.SubIterations = 1 -- Use many sub-iterations to record all transients
end

function TRAIN_SYSTEM:Inputs()
	return { }
end

function TRAIN_SYSTEM:Outputs()
	return { }
end

function TRAIN_SYSTEM:Think(dT)
	-- Generate file name
	if not self.DataName then
		self.DataName = "F:\\f\\subway\\metrostroi_telemetry\\telemetry_"..os.date("%Y%m%d_%H%M%S").."_"..string.format("%04d",1000*math.random())..".txt"
		self.Time = 0

		if not self.SystemsList then
			self.SystemsList = {}
			for k,v in pairs(self.Train.Systems) do
				table.insert(self.SystemsList,k)
			end
			table.sort(self.SystemsList)
		end
	end

	-- Write header for the telemetry file
	if (not self.WroteHeader) and (self.DataName) then
		local header = "Time\tSpeed\tAcceleration\t"
		for i=1,32 do
			header = header.."TW"..i.."\t"
		end
		for _,d in ipairs(self.SystemsList) do
			local k = d
			local v = self.Train.Systems[d]
			if v.OutputsList then
				for i=1,#v.OutputsList do
					header = header..k.."."..v.OutputsList[i].."\t"
				end
			end
		end
		header = header.."\n"

		local f = io.open(self.DataName,"w+")
		if not f then return end
		f:write(header)
		f:close()
		self.WroteHeader = true
	end

	-- Write actual telemetry
	if self.WroteHeader then
		local f = io.open(self.DataName,"a+")
		if not f then return end
		f:write((self.Time or 0).."\t")
		f:write((self.Train.Engines.Speed or 0).."\t")
		f:write((0 or 0).."\t")

		for i=1,32 do
			f:write((self.Train:ReadTrainWire(i) or 0).."\t")
		end
		for _,d in ipairs(self.SystemsList) do
			local k = d
			local v = self.Train.Systems[d]
			if v.OutputsList then
				for i=1,#v.OutputsList do
					f:write(tostring(v[ v.OutputsList[i] ] or 0).."\t")
				end
			end
		end
		f:write("\n")
		f:close()
		self.Time = self.Time + dT
	end
end

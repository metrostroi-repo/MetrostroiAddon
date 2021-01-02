--------------------------------------------------------------------------------
-- Радио-релейный информатор
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("RRI")
TRAIN_SYSTEM.DontAccelerateSimulation = true
if TURBOSTROI then return end
function TRAIN_SYSTEM:Inputs()
	return {}
end

function TRAIN_SYSTEM:Outputs()
	return {}
end

Metrostroi.RRIAnnouncments = {
  ["arr_108"]={14.063,"subway_announcer_riu/arr_108.mp3"},
  ["arr_109"]={4.466,"subway_announcer_riu/arr_109.mp3"},
  ["arr_110"]={10.703,"subway_announcer_riu/arr_110.mp3"},
  ["arr_111"]={4.502,"subway_announcer_riu/arr_111.mp3"},
  ["arr_112"]={10.586,"subway_announcer_riu/arr_112.mp3"},
  ["arr_113"]={9.536,"subway_announcer_riu/arr_113.mp3"},
  ["arr_114"]={3.661,"subway_announcer_riu/arr_114.mp3"},
  ["arr_115"]={14.681,"subway_announcer_riu/arr_115.mp3"},
  ["arr_116"]={10.077,"subway_announcer_riu/arr_116.mp3"},
  ["arr_117"]={9.804,"subway_announcer_riu/arr_117.mp3"},
  ["arr_118"]={5.911,"subway_announcer_riu/arr_118.mp3"},
  ["arr_119"]={4.404,"subway_announcer_riu/arr_119.mp3"},
  ["arr_121"]={9.337,"subway_announcer_riu/arr_121.mp3"},
  ["arr_122"]={4.619,"subway_announcer_riu/arr_122.mp3"},
  ["arr_123"]={14.355,"subway_announcer_riu/arr_123.mp3"},
  ["arr_321_I"]={5.032,"subway_announcer_riu/arr_321_I.mp3"},
  ["arr_321_II"]={11.413,"subway_announcer_riu/arr_321_II.mp3"},
  ["arr_322"]={15.998,"subway_announcer_riu/arr_322.mp3"},
  ["end_111"]={13.759,"subway_announcer_riu/end_111.mp3"},
  ["end_114"]={13.395,"subway_announcer_riu/end_114.mp3"},
  ["end_121"]={13.973,"subway_announcer_riu/end_121.mp3"},
  ["leave"]={11.283,"subway_announcer_riu/leave.mp3"},
  ["next_108"]={7.334,"subway_announcer_riu/next_108.mp3"},
  ["next_109"]={7.297,"subway_announcer_riu/next_109.mp3"},
  ["next_110"]={18.623,"subway_announcer_riu/next_110.mp3"},
  ["next_111"]={7.221,"subway_announcer_riu/next_111.mp3"},
  ["next_112"]={7.495,"subway_announcer_riu/next_112.mp3"},
  ["next_113"]={17.520,"subway_announcer_riu/next_113.mp3"},
  ["next_113_s"]={23.703,"subway_announcer_riu/next_113_s.mp3"},
  ["next_114"]={7.163,"subway_announcer_riu/next_114.mp3"},
  ["next_115"]={9.323,"subway_announcer_riu/next_115.mp3"},
  ["next_115_s"]={15.323,"subway_announcer_riu/next_115_s.mp3"},
  ["next_116"]={7.476,"subway_announcer_riu/next_116.mp3"},
  ["next_117"]={17.763,"subway_announcer_riu/next_117.mp3"},
  ["next_118"]={9.138,"subway_announcer_riu/next_118.mp3"},
  ["next_119_I"]={7.554,"subway_announcer_riu/next_119_I.mp3"},
  ["next_119_II"]={14.088,"subway_announcer_riu/next_119_II.mp3"},
  ["next_121_I"]={12.953,"subway_announcer_riu/next_121_I.mp3"},
  ["next_121_II"]={6.726,"subway_announcer_riu/next_121_II.mp3"},
  ["next_122_II"]={8.051,"subway_announcer_riu/next_122_II.mp3"},
  ["next_122_I_1"]={14.029,"subway_announcer_riu/next_122_I_1.mp3"},
  ["next_122_I_2"]={15.045,"subway_announcer_riu/next_122_I_3.mp3"},
  ["next_123"]={13.935,"subway_announcer_riu/next_123.mp3"},
  ["next_321_I"]={14.661,"subway_announcer_riu/next_321_I.mp3"},
  ["next_321_II"]={8.509,"subway_announcer_riu/next_321_II.mp3"},
  ["next_322"]={8.929,"subway_announcer_riu/next_322.mp3"},
  ["to_111"]={6.881,"subway_announcer_riu/to_111.mp3"},
  ["to_114"]={6.224,"subway_announcer_riu/to_114.mp3"},
  ["to_121"]={6.698,"subway_announcer_riu/to_121.mp3"},
}
for k,v in pairs(Metrostroi.RRIAnnouncments) do
	v[3] = k
end

--первая таблица - прибытие, вторая - следующая, если ИД находится в основной таблице - значит станция типа горлифт
--1 - разделение по пути
--2 - разделение по линии
--3 - разделение по пути и линии
TRAIN_SYSTEM.Setup = {
  [114] = true,
  {
    [321] = 1,
  },
  {
    [119] = 1,
    [121] = 1,
    [122] = {3,1},
    [321] = 1,
  }
}

function TRAIN_SYSTEM:Initialize()
	for _,v in pairs(Metrostroi.RRIAnnouncments) do
		util.PrecacheSound(v[2])
	end
  self.Path = 1
  self.Line = 1
  self.FirstStation = 1
  self.LastStation = #Metrostroi.WorkingStations[self.Line]
  self.CurrentStation = self.FirstStation
  self.Depeat = true
  self.IgnoreHorlift = true
  	self.TriggerNames = {
  		"Custom1",
  		"Custom2",
  		"Custom3",
  		"CustomC",
  		"R_Program1",
  		"R_Program2",
  	}
  	self.Triggers = {}
end


function TRAIN_SYSTEM:Queue(id)
  local ann = self.Train.Announcer
	if (not Metrostroi.RRIAnnouncments[id]) then return end
	if #ann.Schedule < 16 then
		local tbl = Metrostroi.RRIAnnouncments[id]
		table.insert(ann.Schedule, tbl)
	end
end

function TRAIN_SYSTEM:Inputs()
  return {}
end
function TRAIN_SYSTEM:Outputs()
  return {}
end

function TRAIN_SYSTEM:PlaySound(station,arrive)
  if arrive == nil then
  else
    local name = ""
    if arrive then
      name = name.."next_"
    else
      name = name.."arr_"
    end
    name = name..tostring(station)
    local spec
		local horlift = false
		if self.Setup[station] then
			spec = self.Setup[station]
			horlift = true
		else
			if self.Setup[station + (self.Path and 1 or -1)] then
				horlift = true
			end
			spec = self.Setup[arrive and 2 or 1][station]
		end
		if horlift and self.IgnoreHorlift and arrive then
			name = name.."_s"
		end
    if spec then
      if type(spec) == "table" then
        spec = spec[self.Path and 2 or 1]
      end
      if spec == 1 then
        name = name.."_"..(self.Path and "II" or "I")
      elseif spec == 2 then
        name = name.."_"..tostring(self.Line)
      elseif spec == 3 then
        name = name.."_"..(self.Path and "II" or "I").."_"..tostring(self.Line)
      end
    end
    self:Queue(name)
  end
end
function TRAIN_SYSTEM:Trigger(name)
	--self.CurrentStation = 9
  if name == "Custom3"  and #self.Train.Announcer.Schedule == 0 then
    if self.Depeat then
      if self.LastStation > self.FirstStation then
        self.CurrentStation = math.min(self.LastStation+1,self.CurrentStation + 1 + (self.Setup[Metrostroi.WorkingStations[self.Line][self.CurrentStation]+1] and 1 or 0))
      else
        self.CurrentStation = math.max(self.LastStation-1,self.CurrentStation - 1 - (self.Setup[Metrostroi.WorkingStations[self.Line][self.CurrentStation]-1] and 1 or 0))
      end
    end
    if (self.LastStation < self.FirstStation and self.CurrentStation < self.LastStation or self.LastStation > self.FirstStation and self.CurrentStation > self.LastStation) and self.Depeat then
      self.Depeat = false
      if Metrostroi.AnnouncerData[Metrostroi.WorkingStations[self.Line][self.CurrentStation]] and Metrostroi.AnnouncerData[Metrostroi.WorkingStations[self.Line][self.CurrentStation]][9] then
        self.CurrentStation = self.LastStation
        local tem = self.FirstStation
        self.FirstStation = self.LastStation
        self.LastStation = tem
        self.Depeat = not self.Depeat
      else
        self.CurrentStation = self.FirstStation
      end
    else
      self.Depeat = not self.Depeat
    end
    self:PlaySound(Metrostroi.WorkingStations[self.Line][self.CurrentStation],not self.Depeat)
  end
end

function TRAIN_SYSTEM:Think()
  self.Train.R_G:TriggerInput("Set",1)
  self.Train.R_ZS:TriggerInput("Set",1)
	local Train = self.Train
	if Train.VB.Value > 0.5 and Train.Battery.Voltage > 55  then
		for k,v in pairs(self.TriggerNames) do
			if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
				if Train[v].Value > 0.5 then
					self:Trigger(v)
				end
				self.Triggers[v] = Train[v].Value > 0.5
			end
		end
	end
  self.Path = self.Train.CustomC.Value > 0
  if self.FirstStation > self.LastStation and not self.Path or self.FirstStation < self.LastStation and self.Path then
    local temp = self.FirstStation
    self.FirstStation = self.LastStation
    self.LastStation = temp
		self.CurrentStation = self.FirstStation
		self.Depeat = true
  end
end

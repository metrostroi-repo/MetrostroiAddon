--------------------------------------------------------------------------------
-- ��� - ��������������
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("UPO")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.Bloks = {
		"PUAV",
		"PA-KSD",
		"PA-M",
		"PA-KSD-M",
	}
end

function TRAIN_SYSTEM:Outputs()
	return {}
end

function TRAIN_SYSTEM:Inputs()
	return {}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end

function TRAIN_SYSTEM:NotLast(path)
	local Announcer = self.Train.Announcer
    return 	self:GetSTNum(self.Last) > 1
end

function TRAIN_SYSTEM:GetSTNum(station)
	local Announcer = self.Train.Announcer
	local station = tonumber(station)
	if not Metrostroi.WorkingStations then return 0 end
	if not Metrostroi.WorkingStations[self.Line] then return 0 end
	if not Metrostroi.WorkingStations[self.Line][station] and station ~= 120 then return 0 end
	return station == 120 and 12 or Metrostroi.WorkingStations[self.Line][station]
end

function TRAIN_SYSTEM:End(station,path,next)
	if not station or station == 0 or not Metrostroi.AnnouncerData[station] then return true end
	if next then
		return (not Metrostroi.AnnouncerData[station][9])
			and (((self:GetSTNum(self.LastStation) > self:GetSTNum(station) or self:GetSTNum(station) > self:GetSTNum(self.FirstStation)) and path == 2)
			or ((self:GetSTNum(self.FirstStation) < self:GetSTNum(station) and self:GetSTNum(station) > self:GetSTNum(self.LastStation)) and path == 1)),Metrostroi.AnnouncerData[station][9]
	else
		return (not Metrostroi.AnnouncerData[station][9])
			and (((self:GetSTNum(self.LastStation) >= self:GetSTNum(station) or self:GetSTNum(station) > self:GetSTNum(self.FirstStation)) and path == 2)
			or ((self:GetSTNum(self.FirstStation) < self:GetSTNum(station) and self:GetSTNum(station) >= self:GetSTNum(self.LastStation)) and path == 1))
	end
end

function TRAIN_SYSTEM:PlayArriving(station,next,path)
	local Announcer = self.Train.Announcer
    Announcer:MultiQueue(0005,0003)
	if self:End(station,path) then
		Announcer:MultiQueue(0230,0222,0002,0221,station)
		if Metrostroi.AnnouncerData[station][2] then
			Announcer:MultiQueue(0215)
		end
		--Announcer:MultiQueue(0006)
		self.AnnState = 7
		Announcer:MultiQueue(0006)
		return
	end

	Announcer:MultiQueue(Metrostroi.AnnouncerData[station][6] and 0220 or nil,station)
	if Metrostroi.AnnouncerData[station][2] then
		Announcer:MultiQueue(0215)
	end
	if type(Metrostroi.AnnouncerData[station][7]) == "table" then
		Announcer:MultiQueue(0202,Metrostroi.AnnouncerData[Metrostroi.AnnouncerData[station][7][2]] and 0203 or nil,Metrostroi.AnnouncerData[station][7][2])
	elseif Metrostroi.AnnouncerData[station][7] > 0 then
		Announcer:MultiQueue(0202,Metrostroi.AnnouncerData[Metrostroi.AnnouncerData[station][7]] and 0203 or nil,Metrostroi.AnnouncerData[station][7])
	end

	if Metrostroi.AnnouncerData[station][8] and path == Metrostroi.AnnouncerData[station][8] then
		Announcer:MultiQueue(0230,0233,0210,path == 1 and self.LastStation or self.FirstStation)
	end

	if nextNonWorkingStation then
		Announcer:MultiQueue(0230,nextNonWorkingStation)
	end
	Announcer:MultiQueue(0002,0219,next)
	if Metrostroi.AnnouncerData[next][2] then
		Announcer:MultiQueue(0215)
	end

	if type(Metrostroi.AnnouncerData[next][7]) == "table" then
		Announcer:MultiQueue(0202,Metrostroi.AnnouncerData[Metrostroi.AnnouncerData[next][7][2]] and 0203 or nil,Metrostroi.AnnouncerData[next][7][2])
	elseif Metrostroi.AnnouncerData[next][7] > 0 then
		Announcer:MultiQueue(0202,Metrostroi.AnnouncerData[Metrostroi.AnnouncerData[next][7]] and 0203 or nil,Metrostroi.AnnouncerData[next][7])
	end

	if Metrostroi.AnnouncerData[next][8] and path == Metrostroi.AnnouncerData[next][8] then
		Announcer:MultiQueue(0230,0233,0210,path == 1 and self.LastStation or self.FirstStation)
	end
    Announcer:MultiQueue(0006)
end

function TRAIN_SYSTEM:PlayDepeate(station,next,path)
	local Announcer = self.Train.Announcer
    Announcer:MultiQueue(0005,0003)
	if self:NotLast(path) then
		Announcer:MultiQueue(0210,path == 1 and self.LastStation or self.FirstStation,0002)
	elseif Metrostroi.AnnouncerData[station][8] and path == Metrostroi.AnnouncerData[station][8] then
		Announcer:MultiQueue(0230,0233,0210,path == 1 and self.LastStation or self.FirstStation,0002)
	end
	Announcer:MultiQueue(0218)

	if self.NextNonWorkingStation then
		Announcer:MultiQueue(0230,self.NextNonWorkingStation)
	end
	Announcer:MultiQueue(0219,next)
	if Metrostroi.AnnouncerData[next][2] then
		Announcer:MultiQueue(0215)
	end

	if type(Metrostroi.AnnouncerData[next][7]) == "table" then
		Announcer:MultiQueue(0202,Metrostroi.AnnouncerData[Metrostroi.AnnouncerData[next][7][2]] and 0203 or nil,Metrostroi.AnnouncerData[next][7][2])
	elseif Metrostroi.AnnouncerData[next][7] > 0 then
		Announcer:MultiQueue(0202,Metrostroi.AnnouncerData[Metrostroi.AnnouncerData[next][7]] and 0203 or nil,Metrostroi.AnnouncerData[next][7])
	end

	if Metrostroi.AnnouncerData[next][8] and path == Metrostroi.AnnouncerData[next][8] then
		Announcer:MultiQueue(0230,0233,0210,path == 1 and self.LastStation or self.FirstStation)
	end
    Announcer:MultiQueue(0006)
end
function TRAIN_SYSTEM:II(ann)
	if self.Train.R_UPO.Value < 0.5 then return end
	local Announcer = self.Train.Announcer
    Announcer:MultiQueue(0005,0003)
	if ann == 1 then
		Announcer:MultiQueue(math.random() > 0.5 and 0207 or 0206)
	elseif ann == 2 then
		Announcer:MultiQueue(math.random() > 0.5 and 0209 or 0208)
	elseif ann == 3 then
		Announcer:MultiQueue(math.random() > 0.5 and 0204 or 0205)
	else
		if not self.IIalr then
			Announcer:MultiQueue(self.Type == 1 and 0229 or 0217)
			self.IIalr = true
		else
			Announcer:MultiQueue(0228)
			self.IIalr = false
		end
	end
    Announcer:MultiQueue(0006)
end

function TRAIN_SYSTEM:ReloadSigns()
	self.Train:PrepareSigns()
	if self.Train.SignsList[tonumber(self.LastStation)] then
		self.Train.SignsIndex = self.Train.SignsList[tonumber(self.LastStation)] or 1
		if self.Train.SignsList[self.Train.SignsIndex] then self.Train:SetNW2String("FrontText",self.Train.SignsList[self.Train.SignsIndex][2]) end
	end
	if #self.Train.WagonList > 1 then
		local LastTrain = self.Train.WagonList[#self.Train.WagonList]
		LastTrain:PrepareSigns()
		if LastTrain.SignsList[tonumber(self.FirstStation)] then
			LastTrain.SignsIndex = self.Train.SignsList[tonumber(self.FirstStation)] or 1
			if self.Train.SignsList[self.Train.SignsIndex] then LastTrain:SetNW2String("FrontText",self.Train.SignsList[self.Train.SignsIndex][2]) end
		end
	end
end

function TRAIN_SYSTEM:SetStations(line,first,last)
	self.Line = tonumber(line)
	self.FirstStation = tonumber(first)
	self.LastStation = tonumber(last)
	self:ReloadSigns()
end

function TRAIN_SYSTEM:Think()
	self.Path = self.Train:ReadCell(49170)--Metrostroi.PathConverter[self.Train:ReadCell(65510)] or 0
	self.Station = self.Train:ReadCell(49169)
	if self.Train.Autodrive.Corrections[self.Path or 0] then
		self.Distance = math.min(3072,self.Train:ReadCell(49165) + (self.Train.Autodrive.Corrections[self.Path or 0][self.Station] or -3.21))
	end
	if not self.Train.R_UPO or self.Train.R_UPO.Value < 0.5 or self.Blocks == 2 and self["PA-KSD"].Trainsit or (self.Train.KV.ReverserPosition == 0 and self.Train.KRU.Position == 0) then return end
	if (self:GetSTNum(self.LastStation) > self:GetSTNum(self.FirstStation) and self.Path == 2) or (self:GetSTNum(self.FirstStation) > self:GetSTNum(self.LastStation)  and self.Path == 1) then
		local old = self.LastStation
		self.LastStation = self.FirstStation
		self.FirstStation = old
		self:ReloadSigns()
	end
	if not self.FirstStation or not self.LastStation or self.FirstStation == 0 or self.LastStation == 0 or self.Station == 0 then return end
	if (self:End(self.Station,self.Path,true) or self:GetSTNum(self.LastStation) > self:GetSTNum(self.Station) and self.Path == 2 or self:GetSTNum(self.Station) < self:GetSTNum(self.FirstStation) and self.Path == 1) then return end
	if self.Distance < 75 and self.Arrived == nil and Metrostroi.WorkingStations[self.Line][self.Station] then
		self.Arrived = true
		local tbl = Metrostroi.WorkingStations[self.Line]
		self:PlayArriving(self.Station,tbl[tbl[self.Station] + (self.Path == 1 and 1 or -1)],self.Path)
	end
	if self.Arrived and 	self.Train.Panel.SD < 0.5 and not self.BoardTime then
		self.BoardTime = CurTime() + (self.Train.BoardTime or 0) + (20-(#self.Train.WagonList)*4)  + (self.Train.Horlift and 7 or 0)
		self.Ring = false
	end
	if (self.Arrived == nil or self.Train.Panel.SD > 0.5) and self.BoardTime then
		self.BoardTime = nil
		--self.Ring = nil
	end
	if self.Arrived and self.BoardTime and math.floor((self.BoardTime or CurTime()) - CurTime()) < (self.Train.Horlift and 15 or 8) and self.Arrived then
		if self:End(self.Station,self.Path) then
			self.Ring = 2
		else
			local tbl = Metrostroi.WorkingStations[self.Line]
			self:PlayDepeate(self.Station,tbl[tbl[self.Station] + (self.Path == 1 and 1 or -1)],self.Path)
		end
		self.ODZ = true
		self.Arrived = false
	end
	if self.Distance > 75 then self.Arrived = nil end
	if self.Arrived == nil then
		self.Ring = nil
	end
	if self.Ring == false and self.Train.Panel.SD > 0.5 and self.ODZ == nil  then
		self.Ring = 1
	end
	if self.Ring == false and self.Train.Panel.SD > 0.5 and self.ODZ ~= nil  then
		self.Ring = 0
	end
	if self.Train:ReadCell(48) == 218  then
		--self.ODZ = true
	end
	if self.ODZ and self.BoardTime and self.BoardTime - CurTime() < 0  then
		self.ODZ = false
		self.Ring = 2
	end
	if self.Ring == 2 and self.Train.Panel.SD > 0.5 then
		self.Ring = 0
	end
	if (self.Ring or self.Ring ~= 0) and self.Train.ALS_ARS.KVT then
		self.Ring = 0
	end
	if self.Ring == 0 and self.Arrived == nil then
		self.Ring = nil
	end
	if (self.Ring and self.Ring > 0) and not self.Train.ALS_ARS.Ring then
		self.Train.ALS_ARS:TriggerInput("Ring",1)
	end
	if (not self.Ring or self.Ring == 0) and self.Train.ALS_ARS.Ring then
		if not self.Train["PA-KSD"].Check and not self.Train["PA-M"].Check and not self.Train["PA-KSD-M"].Check then self.Train.ALS_ARS:TriggerInput("Ring",0) end
	end
	--[[
	if self.FirstStation and self.LastStation then
		if not self:End(self.Station,self.Path) then
			if self.Train.R_UPO.Value > 0 then
				local tbl = Metrostroi.WorkingStations[self.Line]
				self:PlayDepeate(self.Station,tbl[tbl[self.Station] + (self.Path == 1 and 1 or -1)],self.Path)
			end
		end
	end
	]]
end

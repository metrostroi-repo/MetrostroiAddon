--------------------------------------------------------------------------------
-- Announcer and announcer-related code
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("ASNP")
TRAIN_SYSTEM.DontAccelerateSimulation = true
if TURBOSTROI then return end

function table.GetLastKey(t)
    local lk = -math.huge
    for ki in pairs(t) do
        lk = math.max(lk,ki)
    end
    return lk
end


function TRAIN_SYSTEM:Initialize()
	self.TriggerNames = {
		"Custom1",
		"Custom2",
		"Custom3",
		"R_Program1",
		"R_Program2",
	}
	self.Triggers = {}
	self.State = 0
	self.Style = 1
	self.RealState = 99
	self.RouteNumber = "00"
	self.Depeat = false
	self.Train:LoadSystem("ASNPOn","Relay","Switch",{ normally_closed = true, bass = true })
end

function TRAIN_SYSTEM:ClientInitialize()
	self.STR1r = {}
	self.STR1x = 1

	self.End = false
	self.Right = false
	self.State = 0
	self.Right = false
end
if TURBOSTROI then return end

function TRAIN_SYSTEM:Inputs()
	return {}
end

function TRAIN_SYSTEM:Outputs()
	return {}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end
Metrostroi.AnnButtons = {"-","+","Меню"}
function TRAIN_SYSTEM:AnnDisplay(train,ezh3)
		-- Draw button labels
		if not ezh3 then
			for x=0,2 do
					draw.Text({
						text = string.Trim(Metrostroi.AnnButtons[x+1]),
						font = "MetrostroiSubway_VerySmallText3",
						pos = { 310+x*135,350+0*150},
						xalign = TEXT_ALIGN_CENTER,yalign = TEXT_ALIGN_CENTER,color = Color(0,0,0,255)})
			end
			draw.Text({
				text = "Manual",
				font = "MetrostroiSubway_VerySmallText3",
				pos = { 735,200},
				xalign = TEXT_ALIGN_CENTER,yalign = TEXT_ALIGN_CENTER,color = Color(0,0,0,255)})
			draw.Text({
				text = "Auto",
				font = "MetrostroiSubway_VerySmallText3",
				pos = { 735,100},
				xalign = TEXT_ALIGN_CENTER,yalign = TEXT_ALIGN_CENTER,color = Color(0,0,0,255)})
		end

		if not train:GetPackedBool(32) then return end
		if false then
			for i=1,25 do
				surface.SetDrawColor(Color(53,91,25))
				surface.DrawRect(235+(i-1)*18+1 - (ezh3 and 5 or 0),125+4,16,25)
				--draw.DrawText(string.upper(text1[i] or ""),"MetrostroiSubway_IGLA",287+(i-1)*17.7,125+0,Color(0,0,0,210))
			end
			for i=1,25 do
				surface.SetDrawColor(Color(53,91,25))
				surface.DrawRect(235+(i-1)*18+1 - (ezh3 and 5 or 0),125+31+4,16,25)
				--draw.DrawText(string.upper(text2[i] or ""),"MetrostroiSubway_IGLA",287+(i-1)*17.7,125+31,Color(0,0,0,210))
			end
		end

		for y = 0,#self.STR1r-1 do
			local xmin = 0
			local blink = false
			local checked = false
			local x = 0
			local iter = 0
			while((x <= math.min(24+xmin,#self.STR1r[y+1]-1+xmin))) do
			--for x = 0,math.min(19,#self.STR1r[y+1]-1)-xmin do
				local char = self.STR1r[y+1][x+1]
				if char == "|" then
					Metrostroi.DrawLine(235+9+(x-xmin)*18 - (ezh3 and 5 or 0),141 + y*30-10,235+9+(x-xmin)*18,141+ y*30+9, Color(0,0,0),3)
				elseif char == "_" then
					if CurTime()%0.5<=0.25 then
						draw.DrawText(char,"MetrostroiSubway_FixedSYS",236+(x-xmin)*18 - (ezh3 and 5 or 0),121 + y*30, Color(0,0,0))
					end
					xmin = xmin + 1
				else
					draw.DrawText(char,"MetrostroiSubway_FixedSYS",235+(x-xmin)*18 - (ezh3 and 5 or 0),125 + y*30, Color(0,0,0))
				end
				x = x + 1
			end
		end
		surface.SetAlphaMultiplier(1)
end
function TRAIN_SYSTEM:STR1(str,notchange)
	if type(str) == "number" then str = tostring(str) end
	if SERVER then return end
	if str == true then
		for i = 1,2 do
			self.STR1r[i] = ""
		end
		self.STR1x = 1
	else
		if self.STR1x > (notchange and 3 or 2)  then print("STR1:ERR:MAX",str) return end
		if notchange then
			self.STR1r[self.STR1x-1] = self.STR1r[self.STR1x-1]..str:upper()
		else
			self.STR1r[self.STR1x] = str:upper() or ""
			self.STR1x = self.STR1x + 1
		end
	end
end
function TRAIN_SYSTEM:DisplayStation(St,stay,max)
	max = (max or 25)-1
	local sz = stay and #self.STR1r[self.STR1x-1] or #self.STR1r[self.STR1x]
	local Siz = stay and #self.STR1r[self.STR1x-1] or #self.STR1r[self.STR1x]
	local StS = Metrostroi.AnnouncerData[St] and Metrostroi.AnnouncerData[St][1] or "Unknown"
	local StT = string.Explode(" ",StS)
	local str = ""
	if #StT > 1 then
		str = StT[1][1]..". "..table.concat(StT," ",2)
	elseif #StS > 26-sz-(25-max) then
		str = StS:sub(1,25-sz-2-(25-max)).."..."
	else
		str = StS
	end
	self:STR1(str,stay)
end
TRAIN_SYSTEM.LoadSeq = "/-\\|"
function TRAIN_SYSTEM:ClientThink()

	local State = self.Train:GetNW2Int("Announcer:State",-1)
	self:STR1(true)

	if State == -2 then
		self:STR1("ASNP Error")
		self:STR1("Map not supported")
	end
	if State == 0 then
		self:STR1("Welcome!          ver 0.8")
		self:STR1("loading:")
		self:STR1(self.LoadSeq[math.floor(CurTime()%0.5*8)+1],true)

		--self:STR1("ver 0.8")
	end

	if State == 1 then
		self:STR1("Welcome")
		if self.Train:GetNW2Bool("BPSNBuzzType",false) then
			self:STR1("    pnm    ",true)
		else
			self:STR1("    riu    ",true)
		end
		self:STR1("ver 0.8",true)

		self:STR1("press menu to start")
	end
	if State > 1 and (not Metrostroi.WorkingStations or not Metrostroi.EndStations) then
		self:STR1("Client error")
		self:STR1("WorkingStations nil")
		return
	end
	if State == 2 then
		local RouteNumber = self.Train:GetNW2String("Announcer:RouteNumber","00")
		local Pos = self.Train:GetNW2Int("Announcer:State2Pos",1)
		self:STR1("enter route number: ")
		if Pos == 1 then
			self:STR1("_",true)
		end
		self:STR1(RouteNumber[1],true)
		if Pos == 2 then
			self:STR1("_",true)
		end
		self:STR1(RouteNumber[2],true)
		if Pos == 3 then
			if CurTime()%3 > 1.5 then
				self:STR1("accept: menu")
			else
				self:STR1("cancel: +/-")
			end
		else
			self:STR1("confirm ")
			self:STR1(Pos,true)
			self:STR1(" digit: \"menu\"",true)
		end
	end
	if State > 2 and not Metrostroi.EndStations[self.Train:GetNW2Int("Announcer:Line",1)] then
		self:STR1("Client error")
		self:STR1("EndStations")
		return
	end
	if State > 2 and not Metrostroi.WorkingStations[self.Train:GetNW2Int("Announcer:Line",1)] then
		self:STR1("Client error")
		self:STR1("WorkingStations")
		return
	end

	if State == 3 then
		local Line = self.Train:GetNW2Int("Announcer:Line",1)
		local St = Metrostroi.EndStations[Line][1]
		local En = Metrostroi.EndStations[Line][#Metrostroi.EndStations[Line]]
		self:STR1("choose route")
		self:STR1("_")
		self:STR1(Line, true)
		local tim = CurTime()%4.5
		if tim < 1.5 then
			self:STR1(" ",true)
			self:STR1(St,true)
			self:STR1("->",true)
			self:STR1(En,true)
		elseif tim < 3 then
			self:STR1(" ST:",true)
			self:DisplayStation(St,true)
		else
			self:STR1(" EN:",true)
			self:DisplayStation(En,true)
		end
	end

	if State == 4 then
		local Line = self.Train:GetNW2Int("Announcer:Line",1)
		local StSt = self.Train:GetNW2Int("Announcer:FirstStation",1)
		local St =Metrostroi.EndStations[Line][StSt]
		self:STR1("Choose start station")
		if not St then
			self:STR1("Error, restart ASNP")
		else
			self:STR1(St )
			local tim = CurTime()%4.5
			self:STR1(":",true)
			self:DisplayStation(St,true)
		end
	end

	if State == 5 then
		local Line = self.Train:GetNW2Int("Announcer:Line",1)
		local StSt = self.Train:GetNW2Int("Announcer:LastStation",1)
		local St =Metrostroi.EndStations[Line][StSt]
		self:STR1("Choose end station")
		if not St then
			self:STR1("Error, restart ASNP")
		else
			self:STR1(St)
			local tim = CurTime()%4.5
			self:STR1(":",true)
			self:DisplayStation(St,true)
		end
	end

	if State == 6 then
		local Style = self.Train:GetNW2Int("Announcer:Style",1)
		self:STR1("Choose style")
		self:STR1(Metrostroi.PlayingStyles[Style])
	end

	if State == 7 then
		local Line = self.Train:GetNW2Int("Announcer:Line",1)
		local StStF = self.Train:GetNW2Int("Announcer:FirstStation",1)
		local StStL = self.Train:GetNW2Int("Announcer:LastStation",1)
		local StF =Metrostroi.EndStations[Line][StStF]
		local StL =Metrostroi.EndStations[Line][StStL]
		local Style = self.Train:GetNW2Int("Announcer:Style",1)
		self:STR1("Check settings")
		local tim = CurTime()%6
		if tim < 1.5 then
			self:STR1("Line:")
			self:STR1(Line,true)
		elseif tim < 3 then
			self:STR1("ST:")
			self:DisplayStation(StF,true)
		elseif tim < 4.5 then
			self:STR1("EN:")
			self:DisplayStation(StL,true)
		else
			self:STR1("Style:")
			self:STR1(Metrostroi.PlayingStyles[Style],true)
		end
	end
	if State < 8 then
		self.Right = false
		self.End = false
	end
	if State == 8 then
		local Depeat = self.Train:GetNW2Bool("Announcer:Depeat",false)

		local RouteNumber = self.Train:GetNW2String("Announcer:RouteNumber","00")

		local Line = self.Train:GetNW2Int("Announcer:Line",1)
		local StF = self.Train:GetNW2Int("Announcer:FirstStationW",1)
		local Stl = self.Train:GetNW2Int("Announcer:LastStationW",1)
		local StC = self.Train:GetNW2Int("Announcer:CurrentStation",2)

		local add = Stl > StF and 1 or -1
		local St =Metrostroi.WorkingStations[Line][StC]
		--local StN =Metrostroi.WorkingStations[Line][StC+add]
		local StL =Metrostroi.WorkingStations[Line][Stl]

		if Depeat then self:STR1("Dep.  ") else self:STR1("Arr.  ") end
		self:DisplayStation(St,true,22)
		self:STR1(string.rep(" ",23-#self.STR1r[self.STR1x-1]),true)
		--self.Right = Metrostroi.AnnouncerData[St][2]
		--if self.Right then self:STR1("*R",true) else self:STR1("*L",true) end

		if self.Train:GetNW2Int("Announcer:Locked",0) > 0 and self.Train:GetNW2Int("Announcer:Locked",0) ~= 2 then
			self:STR1("*L",true)
		else
			self:STR1(" L",true)
		end

		if not self.Train:GetNW2Bool("Announcer:Playing1",false) then
			if add > 0 then
				self:STR1("I  ")
			else
				self:STR1("II ")
			end
			self:STR1(string.format("%02d ",RouteNumber),true)
		end
		if self.Train:GetNW2Bool("Announcer:Playing1",false) then
			self:STR1("<<<   Goes Announce   >>>")
			--self:DisplayStation(St,true,23)
		elseif add > 0 and StC >= Stl or add < 0 and StC <= Stl then
			self:STR1("<<<LAST STATION>>>",true)
			self.End = true
		else
			self:DisplayStation(StL,true,22)
			self.End = false
		end
		self:STR1(string.rep(" ",23-#self.STR1r[self.STR1x-1]),true)
		if add > 0 and StC < StL or add < 0 and StC > StL then
			if not self.Train:GetNW2Bool("Announcer:Playing1",false) then
				--if self.Right then self:STR1("R",true) else self:STR1("L",true) end
			--else
				--if Metrostroi.AnnouncerData[StL][2] then self:STR1("*R",true) else self:STR1("*L",true) end
				if self.Train:GetNW2Int("Announcer:Locked",0) > 1 then
					self:STR1("*R",true)
				else
					self:STR1(" R",true)
				end
			end
		end
	end

	if State == 9 then
		local Choosed = self.Train:GetNW2Int("Announcer:Choosed",0)
		if Choosed == 0 then
			self:STR1(">Back")
			self:STR1(" Swap paths")
		elseif  Choosed == 1 then
			self:STR1(">Swap paths")
			self:STR1(" Reset")
		else
			self:STR1(" Swap paths")
			self:STR1(">Reset")
		end
	end
end


Metrostroi.PlayingStyles = {"Moscow","Kiev"}

function TRAIN_SYSTEM:ReloadSigns()
	if not self.Line or not Metrostroi.EndStations[self.Line] then return end
	local StL = Metrostroi.EndStations[self.Line][self.LastStation]
	if not StL then return end
	self.Train:PrepareSigns()


	if self.Train.SignsList[StL] then
		self.Train.SignsIndex = self.Train.SignsList[StL] or 1
		if self.Train.SignsList[self.Train.SignsIndex] then self.Train:SetNW2String("FrontText",self.Train.SignsList[self.Train.SignsIndex][2]) end
	end

	local StF= Metrostroi.EndStations[self.Line][self.FirstStation]
	if #self.Train.WagonList <= 1 or not StF then return end
	local LastTrain = self.Train.WagonList[#self.Train.WagonList]
	LastTrain:PrepareSigns()
	if LastTrain.SignsList[StF] then
		LastTrain.SignsIndex = self.Train.SignsList[StF] or 1
		if self.Train.SignsList[self.Train.SignsIndex] then LastTrain:SetNW2String("FrontText",self.Train.SignsList[self.Train.SignsIndex][2]) end
	end
end

function TRAIN_SYSTEM:UpdateAnnouncer()
	for k,v in pairs(self.Train.WagonList) do
		if v.ASNP then
			if v ~= self.Train then
				if self.Line then v.ASNP.Line = self.Line end
				if self.FirstStation then
					v.ASNP.LastStation = self.FirstStation
					v.ASNP.LastStationW = self.FirstStationW
				end
				if self.LastStation then
					v.ASNP.CurrentStation = self.LastStationW
					v.ASNP.FirstStation = self.LastStation
					v.ASNP.FirstStationW= self.LastStationW
					if Metrostroi.EndStations[self.Line] and Metrostroi.AnnouncerData[Metrostroi.EndStations[self.Line][self.LastStation]] and Metrostroi.AnnouncerData[Metrostroi.EndStations[self.Line][self.LastStation]][9] then
							v.ASNP.LastStation = self.LastStation
							v.ASNP.LastStationW = self.LastStationW
							v.ASNP.CurrentStation = self.FirstStationW
							v.ASNP.FirstStation = self.FirstStation
							v.ASNP.FirstStationW= self.FirstStationW
					end
				end

				v.ASNP.State = self.State
				v.ASNP.Style = self.Style
				v.ASNP.Depeat = true
				v.ASNP.RouteNumber = self.RouteNumber
			end
		end
		v:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
	end
	self:ReloadSigns()
end

function TRAIN_SYSTEM:Trigger(name,nosnd)
	if self.Train.KV.ReverserPosition == 0 and self.Train.KRU.Position == 0 then return end
	if self.State == 1 and name == "Custom3" then self:SetState(2) return end

	if self.State == 2 then
		if name == "Custom1" and self.State2Pos < 3  then
			local num = tonumber(self.RouteNumber[self.State2Pos]) - 1
			if num < 0 then num = 9 end
			self.RouteNumber = string.SetChar(self.RouteNumber,self.State2Pos,num)
			self:UpdateAnnouncer()
		end
		if name == "Custom2" and self.State2Pos < 3 then
			local num = tonumber(self.RouteNumber[self.State2Pos]) + 1
			if num > 9 then num = 0 end
			self.RouteNumber = string.SetChar(self.RouteNumber,self.State2Pos,num)
			self:UpdateAnnouncer()
		end
		if (name == "Custom1" or name == "Custom2") and self.State2Pos == 3 then
			self.State2Pos = 1
		end
		if name == "Custom3" then
			if self.State2Pos < 3 then
				self.State2Pos = self.State2Pos+1
			else
				self:SetState(3)
				return
			end
		end
	end

	if self.State == 3 then
		if name == "Custom1" then
			self.Line = self.Line - 1
			if self.Line < 1 then self.Line = #Metrostroi.WorkingStations end
			self:UpdateAnnouncer()
		end
		if name == "Custom2" then
			self.Line = self.Line + 1
			if self.Line > #Metrostroi.WorkingStations then self.Line = 1 end
			self:UpdateAnnouncer()
		end
		if name == "Custom3" then
			self:SetState(4)
			return
		end
	end

	if self.State == 4 then
		if name == "Custom1" then
			self.FirstStation = self.FirstStation - 1
			if self.FirstStation < 1 then self.FirstStation = #Metrostroi.EndStations[self.Line] end
			self:UpdateAnnouncer()
		end
		if name == "Custom2" then
			self.FirstStation = self.FirstStation + 1
			if self.FirstStation > #Metrostroi.EndStations[self.Line] then self.FirstStation = 1 end
			self:UpdateAnnouncer()
		end
		if name == "Custom3" then
			self:SetState(5)
			return
		end
	end

	if self.State == 5 then
		if name == "Custom1" then
			self.LastStation = self.LastStation - 1
			if self.LastStation < 1 then self.LastStation = #Metrostroi.EndStations[self.Line] end
			if self.LastStation == self.FirstStation then self:Trigger("Custom1") return end
			self:UpdateAnnouncer()
		end
		if name == "Custom2" then
			self.LastStation = self.LastStation + 1
			if self.LastStation > #Metrostroi.EndStations[self.Line] then self.LastStation = 1 end
			if self.LastStation == self.FirstStation then self:Trigger("Custom2") return end
			self:UpdateAnnouncer()
		end
		if name == "Custom3" and self.FirstStation ~= self.LastStation then
			self:SetState(6)
			return
		end
	end

	if self.State == 6 then
		if name == "Custom1" then
			self.Style = self.Style - 1
			if self.Style < 1 then self.Style = #Metrostroi.PlayingStyles end
			self:UpdateAnnouncer()
		end
		if name == "Custom2" then
			self.Style = self.Style + 1
			if self.Style > #Metrostroi.PlayingStyles then self.Style = 1 end
			self:UpdateAnnouncer()
		end
		if name == "Custom3" then
			self:SetState(7)
			return
		end
	end

	if self.State == 7 then
		if name == "Custom1" or name == "Custom2" then
			self:SetState(2)
			return
		end
		if name == "Custom3" and (self.Train.KV.ReverserPosition > 0 or self.Train.KRU.Position > 0) then
			self:SetState(8)
			self.Train.Announcer:MultiQueue(0006,0001,0005)
			self.Train.Announcer:MultiQueue(0201,0211,Metrostroi.EndStations[self.Line][self.FirstStation]+1000,Metrostroi.EndStations[self.Line][self.LastStation]+1000)

			self.Train.Announcer:MultiQueue(0006)
			return
		end
	end
	if self.State == 8 then
		if name == "Custom1" then
			if not self.Depeat then
				if self.LastStation < self.FirstStation then
					self.CurrentStation = math.min(self.FirstStationW,self.CurrentStation + 1)
				else
					self.CurrentStation = math.max(self.FirstStationW,self.CurrentStation - 1)
				end
			end

			if self.LastStation < self.FirstStation and self.CurrentStation >= self.FirstStationW or self.LastStation > self.FirstStation and self.CurrentStation <= self.FirstStationW then
				if Metrostroi.AnnouncerData[Metrostroi.WorkingStations[self.Line][self.CurrentStation]][9] then
					self.CurrentStation = self.FirstStationW
					local tem = self.FirstStation
					self.FirstStation = self.LastStation
					self.LastStation = tem
					self.Depeat = not self.Depeat
				else
					self.Depeat = true
				end
			else
				self.Depeat = not self.Depeat
			end
		end
		if name == "Custom2" then
			if self.Depeat then
				if self.LastStation > self.FirstStation then
					self.CurrentStation = math.min(self.LastStationW,self.CurrentStation + 1)
				else
					self.CurrentStation = math.max(self.LastStationW,self.CurrentStation - 1)
				end
			end

			if self.LastStation < self.FirstStation and self.CurrentStation <= self.LastStationW or self.LastStation > self.FirstStation and self.CurrentStation >= self.LastStationW then
				if Metrostroi.AnnouncerData[Metrostroi.WorkingStations[self.Line][self.CurrentStation]][9] then
					self.CurrentStation = self.LastStationW
					local tem = self.FirstStation
					self.FirstStation = self.LastStation
					self.LastStation = tem
					self.Depeat = not self.Depeat
				else
					self.Depeat = false
				end
			else
				self.Depeat = not self.Depeat
			end
		end
		if name == "Custom3" then
			self:SetState(9)
			return
		end

		if name == "R_Program1" and #self.Train.Announcer.Schedule == 0 and (self.Train.CustomC.Value < 0.5 or
			self.CurrentStation == math.Clamp(self.CurrentStation,path and self.LastStationW or self.FirstStationW,path and self.FirstStationW or self.LastStationW) and self.Depeat == true) then
			self:PlayAnnounce1()
			if self.Depeat and self.Train.CustomC.Value < 0.5 then
				if self.LastStation > self.FirstStation then
					self.CurrentStation = math.min(self.LastStationW,self.CurrentStation + 1)
				else
					self.CurrentStation = math.max(self.LastStationW,self.CurrentStation - 1)
				end
			end

			if (self.LastStation < self.FirstStation and self.CurrentStation <= self.LastStationW or self.LastStation > self.FirstStation and self.CurrentStation >= self.LastStationW) and not self.Depeat then
				self.Depeat = false
				if Metrostroi.AnnouncerData[Metrostroi.WorkingStations[self.Line][self.CurrentStation]][9] then
					self.CurrentStation = self.LastStationW
					local tem = self.FirstStation
					self.FirstStation = self.LastStation
					self.LastStation = tem
					self.Depeat = not self.Depeat
				else
					self.CurrentStation = self.FirstStationW
				end
			elseif  self.Train.CustomC.Value < 0.5 or self.Depeat == true then
				self.Depeat = not self.Depeat
			end
		end
	end

	if self.State == 9 then
		if name == "Custom1" then
			self.Choosed = math.max(0,self.Choosed-1)
		end
		if name == "Custom2" then
			self.Choosed = math.min(2,self.Choosed+1)
		end
		if name == "Custom3" then
			if self.Choosed == 0 then
				self.State = 8
			elseif self.Choosed == 1 then
				local tmp = self.FirstStation
				self.FirstStation = self.LastStation
				self.LastStation = tmp
				if self.FirstStation and self.Line and self.FirstStationW ~= self.FirstStation then
					self.FirstStationW = Metrostroi.WorkingStations[self.Line][Metrostroi.EndStations[self.Line][self.FirstStation]]
				end
				if self.LastStation and self.Line and self.LastStationW ~= self.LastStation then
					self.LastStationW = Metrostroi.WorkingStations[self.Line][Metrostroi.EndStations[self.Line][self.LastStation]]
				end
				if Metrostroi.AnnouncerData[Metrostroi.EndStations[self.Line][self.FirstStation]][9] then
					local tem = self.FirstStation
					self.FirstStation = self.LastStation
					self.LastStation = tem
				end
				self:SetState(7)
			else
				self:SetState(7)
			end
			return
		end
	end
end

function TRAIN_SYSTEM:PlayAnnounce1(val)
	local add = self.LastStation > self.FirstStation and 1 or -1
	local curr = Metrostroi.WorkingStations[self.Line][self.CurrentStation]
	local currt = Metrostroi.AnnouncerData[curr]
	local next = Metrostroi.WorkingStations[self.Line][self.CurrentStation + add]
	local nextt = Metrostroi.AnnouncerData[next]
	--local uvpass = false
	self.Train.Announcer:MultiQueue(0006,0001,0005) -- Щелчки и начало
	if self.Depeat then -- Отправление
			if Metrostroi.AnnouncerData[curr +add] and not Metrostroi.AnnouncerData[curr +add][1] then self.Train.Announcer:MultiQueue(0230,curr+add+1000,0001)  end

			self.Train.Announcer:MultiQueue(0218,0219,next+1000) -- ОДЗ СС
			if nextt and nextt[2] then self.Train.Announcer:MultiQueue(self.Style == 2 and 0215 or 0231) end -- Платформа справа(или киевский вариант)
			--[=[
			if nextt[7] and nextt[7] ~= 0 then
				if Metrostroi.AnnouncerData[nextt[7][1]] then
					self.Train.Announcer:MultiQueue(0202, 0203,nextt[7][1])
				else
					self.Train.Announcer:MultiQueue(0202, nextt[7][1])
				end
			end -- Переход
			]=]
			if nextt and nextt[5] and self.Style == 3 then self.Train.Announcer:MultiQueue(0213) end -- Прислоняться
			if nextt and nextt[3] then
				--uvpass = true
				if self.Style == 1 then	self.Train.Announcer:MultiQueue(0230) end
				self.Train.Announcer:MultiQueue(self.Style == 2 and 0214 or 0232) -- Вежливость
			end
			--if nextt[8] == (add > 0 and 1 or 2) then self.Train.Announcer:MultiQueue(0002,self.Style == 2 and 0210 or 0223,Metrostroi.EndStations[self.Line][self.LastStation]) end -- до станции
	else
			self.Train.Announcer:MultiQueue(0220,curr+1000) -- Станция
			if currt[2] then self.Train.Announcer:MultiQueue(self.Style == 2 and 0215 or 0231) end -- Платформа справа(или киевский вариант)
			if currt[7] and currt[7] ~= 0 then
				if Metrostroi.AnnouncerData[currt[7][1]] then
					self.Train.Announcer:MultiQueue(0202, 0203,currt[7][1]+1000)
				else
					self.Train.Announcer:MultiQueue(0202, currt[7][1])
				end
			end -- Переход

			if self.LastStation < self.FirstStation and self.CurrentStation <= self.LastStationW or self.LastStation > self.FirstStation and self.CurrentStation >= self.LastStationW then
				if not currt[9] then
					if self.Style == 1 then
						self.Train.Announcer:MultiQueue(0224,0002,0230,0226) -- Конечная
					else
						self.Train.Announcer:MultiQueue(0212) -- Конечная
					end
					self.Train.Announcer:MultiQueue(0006) -- Конечный щелчок
					return
				end
			end
			if currt[4] then
				--uvpass = true
				if self.Style == 1 then	self.Train.Announcer:MultiQueue(0230) end
				self.Train.Announcer:MultiQueue(0226+(currt[4] or 0)) -- Вещи
			end
			if add > 0 and self.LastStationW < #Metrostroi.WorkingStations[self.Line] or add < 0 and self.LastStationW > 1 then
				self.Train.Announcer:MultiQueue(0002,self.Style == 2 and 0210 or 0223,Metrostroi.EndStations[self.Line][self.LastStation]+1000) -- Следует до станции
			end
			if currt[8] == (add > 0 and 1 or 2) then self.Train.Announcer:MultiQueue(0002,self.Style == 2 and 0210 or 0223,Metrostroi.EndStations[self.Line][self.LastStation]+1000) end -- до станции
	end
	self.Train.Announcer:MultiQueue(0006) -- Конечный щелчок
end



function TRAIN_SYSTEM:GetTimer(val)
	return self.TimerMod and (CurTime() - self.Timer) > val
end
function TRAIN_SYSTEM:SetTimer(mod)
	if mod then
		if self.TimerMod == mod then return end
		self.TimerMod = mod
	else
		self.TimerMod = nil
	end
	self.Timer = CurTime()
end

function TRAIN_SYSTEM:SetState(state,state7,noupd)
	local Train = self.Train
	local ARS = Train.ALS_ARS
	local Announcer = Train.Announcer
	if state and self.State ~= state then
		self.State = state
		if state == 1 or state == 1.1 then
			self.NextState = add
		end
		self:SetTimer()
	elseif not state then
		state = self.NextState
		self.State = self.NextState
	else
		return
	end
	if state == 0 then
		self.LoadTimer = math.random(2,4)
	end
	if state == 2 then
		self.State2Pos = 1
	end
	if state == 3 then
		self.Line = self.Line or 1
	end
	if state == 4 then
		self.FirstStation = self.FirstStation or 1
		if self.FirstStation > #Metrostroi.EndStations[self.Line] then self.FirstStation = 1 end
		self:UpdateAnnouncer()
	end
	if state == 5 then
		self.LastStation = self.LastStation or self.LastStation ~= self.FirstStation and #Metrostroi.EndStations[self.Line] or 1
		if self.LastStation > #Metrostroi.EndStations[self.Line] then self.LastStation = 1 end
		self:UpdateAnnouncer()
	end
	if state == 6 then
		self.Style = self.Style or 1
	end
	if state == 8 and (self.Train.KV.ReverserPosition > 0 or self.Train.KRU.Position > 0) then
		if self.Train:ReadCell(49170) == 2  and false and self.LastStation > self.FirstStation then
			local tem = self.FirstStation
			self.FirstStation = self.LastStation
			self.LastStation = tem
		end
		if self.Train:ReadCell(49170) == 1  and false and self.LastStation < self.FirstStation then
			local tem = self.FirstStation
			self.FirstStation = self.LastStation
			self.LastStation = tem
		end

		if self.FirstStation and self.Line and self.FirstStationW ~= self.FirstStation then
			self.FirstStationW = Metrostroi.WorkingStations[self.Line][Metrostroi.EndStations[self.Line][self.FirstStation]]
		end
		if self.LastStation and self.Line and self.LastStationW ~= self.LastStation then
			self.LastStationW = Metrostroi.WorkingStations[self.Line][Metrostroi.EndStations[self.Line][self.LastStation]]
		end
		local curr = self.FirstStationW
    print(curr)
		local path = self.LastStation < self.FirstStation
		local st = self.Train:ReadCell(49169) > 0 and Metrostroi.WorkingStations[self.Line][self.Train:ReadCell(49169)] or 0
		if st > 0 then
			curr = math.Clamp(st,path and self.LastStationW or self.FirstStationW,path and self.FirstStationW or self.LastStationW)
		end
		self:UpdateAnnouncer()
    print(curr)
		self.CurrentStation = curr
		self.Depeat = true
	end
	if state < 8 then
		self.Train.ASNP31:TriggerInput("Set",0)
		self.Train.ASNP32:TriggerInput("Set",0)
	end
	if state == 9 then
		self.Choosed = 0
	end
end

--States:
-- -2 - Loaded in another cab
-- -1 - Starting up
--nil - First setUp and get settings from last
--1   - Welcome Screen
--2   - Route Choose
--3   - Choose start station
--4   - Choose end station
--5   - Choose path
--6   - Choose style of playing
--7   - Normal state
--8   - Confim a settings (on last stations)
function TRAIN_SYSTEM:Think()
	local Train = self.Train
	if Train.VB.Value > 0.5 and Train.Battery.Voltage > 55 and self.State > -1  then
		for k,v in pairs(self.TriggerNames) do
			if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
				if Train[v].Value > 0.5 then
					self:Trigger(v)
				end
				--print(v,self.Train[v].Value > 0.5)
				self.Triggers[v] = Train[v].Value > 0.5
			end
		end
	end
	if self.Train.R_Radio.Value > 0.5 and self.State == -1 then
		self:SetState(0)
	end
	if self.Train.R_Radio.Value < 0.5 and self.State ~= -1 then
		self:SetState(-1)
		return
	end
	if not Metrostroi.AnnouncerData and self.State ~= -2 then
		if self.State ~= -2 then self:SetState(-2) end
		return
	end

	if self.State == 0 then
		self:SetTimer(0)
		if self:GetTimer(self.LoadTimer) then
			self.LoadTimer = nil
			self:SetState(1)
		end
	end
	if self.State >= 8 then
		local Distance = math.min(3072,self.Train:ReadCell(49165))
		--local st = self.Train:ReadCell(49169) > 0 and Metrostroi.AnnouncerData[self.Train:ReadCell(49169)] or false
		local st = self.Train:ReadCell(49169)
		local right = st and Metrostroi.AnnouncerData[st] and Metrostroi.AnnouncerData[st][2]
		local unlock = Distance > 100 and self.Train.ALS_ARS.Speed <= 2
		local lock = self.Train.ALS_ARS.Speed > 2
		if self.Train.ASNPOn.Value > 0.5 and not unlock then
			if right then
				if self.Train.ASNP31.Value == 0 then self.Train.ASNP31:TriggerInput("Set",1) end

				--if not lock and
				if not lock and self.Train.ASNP32.Value == 1 then self.Train.ASNP32:TriggerInput("Set",0) end
				if lock and 	self.Train.ASNP32.Value == 0 then self.Train.ASNP32:TriggerInput("Set",1) end
			else
				--if not lock and
				if not lock and self.Train.ASNP31.Value == 1 then self.Train.ASNP31:TriggerInput("Set",0) end
				if lock and 	self.Train.ASNP31.Value == 0 then self.Train.ASNP31:TriggerInput("Set",1) end

				if self.Train.ASNP32.Value == 0 then self.Train.ASNP32:TriggerInput("Set",1) end
			end
		else
			if self.Train.ASNP32.Value == 1 then self.Train.ASNP32:TriggerInput("Set",0) end
			if self.Train.ASNP31.Value == 1 then self.Train.ASNP31:TriggerInput("Set",0) end
		end
	end
	if self.State == 8 and (self.Train.KV.ReverserPosition > 0 or self.Train.KRU.Position > 0) then
		if self.Train.CustomC.Value > 0.5 then
			local Distance = math.min(3072,self.Train:ReadCell(49165))
			local st = self.Train:ReadCell(49169) > 0 and Metrostroi.WorkingStations[self.Line][self.Train:ReadCell(49169)] or 0
			if Distance < 25 and self.AutoStation ~= st and self.Train:ReadCell(49169) > 0 and st == math.Clamp(st,path and self.LastStationW or self.FirstStationW,path and self.FirstStationW or self.LastStationW) then

				self.CurrentStation = math.Clamp(st,path and self.LastStationW or self.FirstStationW,path and self.FirstStationW or self.LastStationW)
				self.Depeat = false
				self:PlayAnnounce1()
				self.Depeat = true
				self.AutoStation = self.CurrentStation
			end
		end
	end
	self.Train:SetNW2Int("Announcer:State",self.State)
	self.Train:SetNW2Int("Announcer:Line",self.Line)
	self.Train:SetNW2Int("Announcer:FirstStation",self.FirstStation)
	self.Train:SetNW2Int("Announcer:LastStation",self.LastStation)
	self.Train:SetNW2String("Announcer:RouteNumber",self.RouteNumber)
	if self.State == 2 then
		self.Train:SetNW2Int("Announcer:State2Pos",self.State2Pos)
	end
	if self.State == 6 then
		self.Train:SetNW2String("Announcer:Style",self.Style)
	end
	if self.State == 8 then
		self.Train:SetNW2Int("Announcer:FirstStationW",self.FirstStationW)
		self.Train:SetNW2Int("Announcer:LastStationW",self.LastStationW)
		self.Train:SetNW2String("Announcer:CurrentStation",self.CurrentStation)
		self.Train:SetNW2Bool("Announcer:Depeat",self.Depeat)
		if self.Train.ASNP31.Value == 1 then
			if self.Train.ASNP32.Value == 1 then
				self.Train:SetNW2Int("Announcer:Locked",3)
			else
				self.Train:SetNW2Int("Announcer:Locked",1)
			end
		elseif self.Train.ASNP32.Value == 1 then
			self.Train:SetNW2Int("Announcer:Locked",2)
		else
			self.Train:SetNW2Int("Announcer:Locked",0)
		end

	end
	if self.State == 9 then
		self.Train:SetNW2Int("Announcer:Choosed",self.Choosed)
	end
	self.Train:SetNW2Bool("Announcer:Playing", self.Train.Announcer.ScheduleAnnouncement > 2)
	self.Train:SetNW2Bool("Announcer:Playing1", #self.Train.Announcer.Schedule > 0)
	if self.FirstStation and self.Line and self.FirstStationW ~= self.FirstStation then
		self.FirstStationW = Metrostroi.WorkingStations[self.Line][Metrostroi.EndStations[self.Line][self.FirstStation]]
	end
	if self.LastStation and self.Line and self.LastStationW ~= self.LastStation then
		self.LastStationW = Metrostroi.WorkingStations[self.Line][Metrostroi.EndStations[self.Line][self.LastStation]]
	end
end

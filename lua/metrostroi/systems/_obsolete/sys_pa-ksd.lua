--------------------------------------------------------------------------------
-- ПА-КСД Поездная Аппаратура-Комплексная Система Движения
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PA-KSD")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.Train:LoadSystem("Indicate","Relay","Switch",{bass = true,maxvalue = 3,defaultvalue = 1})
	self.Train:LoadSystem("VPA","Relay","Switch",{bass = true,defaultvalue = 1,maxvalue = 2})
	self.Train:LoadSystem("BCCD","Relay","Switch",{bass = true})
	self.Train:LoadSystem("VZP","Relay","Switch",{bass = true})
	self.Train:LoadSystem("B7","Relay","Switch",{bass = true})
	self.Train:LoadSystem("B8","Relay","Switch",{bass = true})
	self.Train:LoadSystem("B9","Relay","Switch",{bass = true})
	self.Train:LoadSystem("B4","Relay","Switch",{bass = true})
	self.Train:LoadSystem("B5","Relay","Switch",{bass = true})
	self.Train:LoadSystem("B6","Relay","Switch",{bass = true})
	self.Train:LoadSystem("BUp","Relay","Switch",{bass = true})
	self.Train:LoadSystem("B1","Relay","Switch",{bass = true})
	self.Train:LoadSystem("B2","Relay","Switch",{bass = true})
	self.Train:LoadSystem("B3","Relay","Switch",{bass = true})
	self.Train:LoadSystem("BDown","Relay","Switch",{bass = true})
	self.Train:LoadSystem("BLeft","Relay","Switch",{bass = true})
	self.Train:LoadSystem("B0","Relay","Switch",{bass = true})
	self.Train:LoadSystem("BMinus","Relay","Switch",{bass = true})
	self.Train:LoadSystem("BPlus","Relay","Switch",{bass = true})
	self.Train:LoadSystem("BEnter","Relay","Switch",{bass = true})

	self.Train:LoadSystem("R25p","Relay","KPD-110E", { bass = true })

	self.TriggerNames = {
		"B7",
		"B8",
		"B9",
		"BLeft",
		"B4",
		"B5",
		"B6",
		"BUp",
		"B1",
		"B2",
		"B3",
		"BDown",
		"B0",
		"BMinus",
		"BPlus",
		"BEnter",
	}
	self.Triggers = {}
	self.Pass = "31173"
	self.EnteredPass = ""
	self.Timer = CurTime()
	self.Line = 1
	self.State = 0
	self.RealState = 99
	self.RouteNumber = ""
	self.State4Choosed = 1
	self.FirstStation = ""
	self.LastStation = ""
	self.KSZD = false
	self.AutoTimer = false
	 self.State74 = 1
	 self.State75 = 1
end
function TRAIN_SYSTEM:ClientInitialize()
	self.STR1r = {}
	self.STR2r = {}
	self.STR1x = 1
	self.STR2x = 1
	self.Positions = {
		[-3] = "T2",
		[-2] = "T1a",
		[-1] = "T1",
		[0]  = "0",
		[1]  = "X1",
		[2]  = "X2",
		[3]  = "X3",
		--[4]  = "RR0",
		[5]  = "0XT",
		[6]  = "T2",
	}
	self.Positions2 = {"PS","PP","PT",}
	self.Types = {
		[0] = "EPV",
		[1] = "AV",
		[2] = "OD",
		[3] = "KV",
		[4] = "UA",
		[5] = "SL",
	}
	self.StataionData =
	{
		[0] = "ERR",
		[108] = "AV",
		[109] = "IND",
		[110] = "MOSK",
		[111] = "OKT",
		[112] = "PLMI",
		[113] = "NOV",
		[114] = "VOK",
		[115] = "KOM",
		[116] = "ELE",
		[117] = "TEPL",
		[118] = "PP",
		[119] = "SINE",
		[120] = "LES X",
		[121] = "MNSK",
		[122] = "TSVO",
		[123] = "MZHD",
		[321] = "MUSK",
		[322] = "AVUZ",
		[1215] = "LEN",
		--ORANGE LINE
		[401] = "SLS",
		[402] = "LITE",
		[403] = "PA",
		[404] = "MAST",
		[405] = "GFC",
		[406] = "UB",
		[407] = "VHE",
		[408] = "TGM",
		[501] = "AERO",
		[502] = "SENT",
		[503] = "LIT",
	}
	self.Train.Autodrive.AutodriveEnabled = false
	self.KSZD = false
	self.AutoTimer = false
end

if TURBOSTROI then return end
CreateConVar("metrostroi_paksd_autoopen",0,{FCVAR_ARCHIVE},"PA-KSD:Auto open doors")
function TRAIN_SYSTEM:Inputs()
	return {  "Press" }
end

function TRAIN_SYSTEM:PAKSD1(train)
	--print(self,train,self==train)
	if train:GetPackedBool("Indicate3") then return end
	if train:GetPackedBool("Indicate2") then return end
	for y = 0,#self.STR1r-1 do
		local xmin = 0
		local blink = false
		local checked = false
		for x = 0,math.min(19,#self.STR1r[y+1]-1) do
			local char = self.STR1r[y+1][x+1]
			if char == "@" then
				blink = true
				xmin = xmin + 1
			elseif char == "$" then
				checked = true
				xmin = xmin + 1
			elseif blink then
				if CurTime()%1<=0.5 then
					surface.SetDrawColor(0,255,127)
					surface.DrawRect((x-xmin)*16+1,y*28+5,14,20)
					surface.SetDrawColor(0,0,0)
					draw.DrawText(char,"MetrostroiSubway_IGLA",(x-xmin)*16,y*28, Color(0,0,0))
					--xmin = xmin + 1
				else
					draw.DrawText(char,"MetrostroiSubway_IGLA",(x-xmin)*16,y*28, Color(0,255,127))
					--xmin = xmin + 1
				end
			elseif checked then
				surface.SetDrawColor(0,255,127)
				surface.DrawRect((x-xmin)*16+1,y*28+5,14,20)
				surface.SetDrawColor(0,0,0)
				draw.DrawText(self.STR1r[y+1][x+1],"MetrostroiSubway_IGLA",(x-xmin)*16,y*28, Color(0,0,0))
			elseif char == "_" then
				if CurTime()%0.65<=0.4 then
					surface.SetDrawColor(0,255,127)
					surface.DrawRect((x-xmin)*16,y*28+5,16,20)
				end
			elseif char == "#" then
				surface.SetDrawColor(0,255,127)
				surface.DrawRect(x*16+1,y*28+5,14,20)
			elseif self.STR1r[y+1][x+2] == "%" then
				if CurTime()%0.5<=0.25 then
					surface.SetDrawColor(0,255,127)
					surface.DrawRect((x-xmin)*16+1,y*28+5,14,20)
					surface.SetDrawColor(0,0,0)
					draw.DrawText(self.STR1r[y+1][x+1],"MetrostroiSubway_IGLA",(x-xmin)*16,y*28, Color(0,0,0))
					xmin = xmin + 1
				else
					draw.DrawText(char,"MetrostroiSubway_IGLA",(x-xmin)*16,y*28, Color(0,255,127))
					xmin = xmin + 1
				end
			elseif char ~= "%" then
				draw.DrawText(char,"MetrostroiSubway_IGLA",(x-xmin)*16,y*28, Color(0,255,127))
			end
		end
	end
	surface.SetAlphaMultiplier(1)
end
function TRAIN_SYSTEM:PAKSD2(train)
	if train:GetPackedBool("Indicate3") then return end
	if not train:GetPackedBool("Indicate1") and not train:GetPackedBool("Indicate2") then return end
	for y = 0,#self.STR2r-1 do
		for x = 0,math.min(19,#self.STR2r[y+1]-1) do
			local char = self.STR2r[y+1][x+1]
			if char == "_" then
				if CurTime()%0.5>0.25 then
					char = ""
				else
					surface.SetDrawColor(0,255,127)
					surface.DrawRect(x*16-3,y*40 + 15,16,28)
				end
			end
			draw.DrawText(char,"MetrostroiSubway_IGLA",x*16-3,y*40 + 15, Color(0,255,127))
		end
	end
	surface.SetAlphaMultiplier(1)
end

function TRAIN_SYSTEM:STR1(str,notchange)
	if SERVER then return end
	if str == true then
		for i = 1,4 do
			self.STR1r[i] = ""
		end
		self.STR1x = 1
	else
		if self.STR1x > 4 then print("STR1:ERR:MAX",str) return end
		if notchange then
			self.STR1r[self.STR1x-1] = self.STR1r[self.STR1x-1]..str
		else
			self.STR1r[self.STR1x] = str or ""
			self.STR1x = self.STR1x + 1
		end
	end
end
function TRAIN_SYSTEM:STR2(str,notchange)
	if SERVER then return end
	if str == true then
		for i = 1,2 do
			self.STR2r[i] = ""
		end
		self.STR2x = 1
	else
		if self.STR2x > 2 then print("STR2:ERR:MAX",str) return end
		if notchange then
			self.STR2r[self.STR2x] = self.STR2r[self.STR2x]..(str or "")
		else
			self.STR2r[self.STR2x] = str or ""
			self.STR2x = self.STR2x + 1
		end
	end
end
function TRAIN_SYSTEM:ClientThink()
	if not self.Train.Blok or self.Train.Blok ~= 2 then return end
	self.Time = self.Time or CurTime()
	if (CurTime() - self.Time) > 0.1 then
		--print(1)
		self.Time = CurTime()
		--self.STR1 = string.Explode("\n",self.Train:GetNW2String("PAKSD1"))
		--self.STR2 = string.Explode("\n",self.Train:GetNW2String("PAKSD2"))
		self:STR1(true)
		self:STR2(true)
		local State = self.Train:GetNW2Int("PAKSD:State",0)
		if State == -1 or State == -9 or State >= 1 and State < 6 then
			self:STR2("<*>")
		end
		local Announcer = self.Train.Announcer
		if State == 8 then
			self:STR1("<*>")
			self:STR2("<*>")
		elseif State == -2 then
			self:STR2("_")
		elseif State == 1 then
			self:STR1("+INITIAL TEST")
			self:STR1("+INITIAL SETUP")
			self:STR1("V 0.3")
			self:STR1("     PRESS ENTER")
		elseif State == 2 then
			self:STR1("ENTER PASSWORD")
			self:STR1("TO ENTER SYSTEM>")
			self:STR1(self.Train:GetNW2Int("PAKSD:Pass",0) ~= -1 and string.rep("*",self.Train:GetNW2Int("PAKSD:Pass",0)) or "ACCESS ERROR")
		elseif State == 3 then
			self:STR1(" 1 GO TO LINE")
			if self.Train:GetNW2Bool("PAKSD:Restart",false) then self:STR1(" 2 RESTART") end
			--if self.FirstStation ~= "" and self.LastStation ~= "" then self:STR1("\n 2 RESTART" end
		elseif State == 4 then
			local State4Choosed = self.Train:GetNW2Int("PAKSD:State4",1)
			if State4Choosed < 4 then
				local Line = self.Train:GetNW2Int("PAKSD:Line",0)
				local FirstStation = self.Train:GetNW2Int("PAKSD:FirstStation",-1)
				local LastStation = self.Train:GetNW2Int("PAKSD:LastStation",-1)
				local tbl = Metrostroi.EndStations
				self:STR1("LINE "..Line..(State4Choosed == 1 and "_" or " ").." ")
				if tbl[Line] then
					local Routelength = #Metrostroi.EndStations[Line]
					self:STR1("<"..tbl[Line][1].."->"..tbl[Line][Routelength]..">",true)
				else
					self:STR1("<ERR->ERR>",true)
				end
				local st = ""
				if tbl[Line] and tbl[Line][FirstStation] and Metrostroi.AnnouncerData[FirstStation] then
					st = Metrostroi.AnnouncerData[FirstStation][1]:sub(1,10)
				end
				self:STR1("FIRST "..(FirstStation ~= -1 and FirstStation or "")..(State4Choosed == 2 and "_" or " ")..st:upper())
				st = ""
				if tbl[Line] and tbl[Line][LastStation] and Metrostroi.AnnouncerData[LastStation] then
					st = Metrostroi.AnnouncerData[LastStation][1]:sub(1,10)
				end
				self:STR1("LAST  "..(LastStation ~= -1 and LastStation or "")..(State4Choosed == 3 and "_" or " ")..st:upper())
				self:STR1("        VVVV        ")
			else
				local RouteNumber = self.Train:GetNW2Int("PAKSD:RouteNumber",-1)
				self:STR1("ROUTEn "..(RouteNumber ~= -1 and RouteNumber or "").."_")
				self:STR1("\"ENTER\" FOR CONFIRM")
			end
		elseif State == 49 then
			local State4Choosed = self.Train:GetNW2Int("PAKSD:State4",1)
			local Line = self.Train:GetNW2Int("PAKSD:Line",0)
			local LastStation = self.Train:GetNW2Int("PAKSD:LastStation",-1)
			local RouteNumber = self.Train:GetNW2Int("PAKSD:RouteNumber",-1)
			local tbl = Metrostroi.EndStations
			self:STR1("LINE "..Line..(State4Choosed == 1 and "_" or " ").." ")
			if tbl[Line] then
				local Routelength = #Metrostroi.EndStations[Line]
				self:STR1("<"..tbl[Line][1].."->"..tbl[Line][Routelength]..">",true)
			else
				self:STR1("<ERR->ERR>",true)
			end
			local st = ""
			if tbl[Line] and tbl[Line][LastStation] and Metrostroi.AnnouncerData[LastStation] then
				st = Metrostroi.AnnouncerData[LastStation][1]:sub(1,10)
			end
			self:STR1("LAST  "..(LastStation ~= -1 and LastStation or "")..(State4Choosed == 2 and "_" or " ")..st:upper())
			self:STR1("ROUTEn "..(RouteNumber ~= -1 and RouteNumber or "")..(State4Choosed == 3 and "_" or " "))
			self:STR1("\"ENTER\" FOR CONFIRM")
		elseif State == 48 or State == 45 then
			self:STR1("ERROR WHEN ENTER")
			self:STR1("SOURCE DATA")
			self:STR1("FOR CONTINUE")
			self:STR1("PRESS ENTER")
		elseif State == 5 then
			self:STR1(" TRAIN CHECK")
			self:STR1(" APPROVED")
			self:STR1(" WHEN CHECK")
			self:STR1(" PRESS ENTER")
		elseif State == 6 then
			self:STR1("ENTER")
			self:STR1("TO WORKING MODE?")
			self:STR1("")
			self:STR1("YES-\"ENTER\" NO-\"<-\"")
		elseif State > 6 then

			local speed = math.floor(self.Train:GetPackedRatio(3)*100.0)
			local station = self.Train:GetNW2Int("PAKSD:Station",0)
			local spd = self.Train:GetNW2Bool("PAKSD:UOS", false) and 35 or self.Train:GetNW2Bool("PAKSD:VRD",false) and 20 or self.Train:GetPackedBool(46) and 80 or self.Train:GetPackedBool(45) and 70 or self.Train:GetPackedBool(44) and 60 or self.Train:GetPackedBool(43) and 40 or self.Train:GetPackedBool(42) and "00" or "H4"
			local VZ = (self.Train:GetNW2Bool("PAKSD:VZ1",false) and "B1" or "").." "..(self.Train:GetNW2Bool("PAKSD:VZ2",false) and "B2" or "")
			if self.OldVRD ~= self.Train:GetNW2Bool("PAKSD:VRD",false) then
				self.OldVRD = self.Train:GetNW2Bool("PAKSD:VRD",false)
				if self.OldVRD then
					self.VRDTimer = CurTime() + 7
				end
			end
			local distance = self.Train:GetNW2Int("PAKSD:Distance",-99)
			local pos =self.Positions[self.Train:GetNW2Int("PAKSD:KV",0)]
			local typ = self.Types[self.Train:GetNW2Int("PAKSD:Type",0)]
			local RK = (self.Positions2[self.Train:GetNW2Int("PAKSD:PPT",1)]).."="..tostring(self.Train:GetNW2Int("PAKSD:RK",0))
			if speed < 10 then
				speed = "0"..speed
			end
			if State == 71 then
				self:STR1("CONFIRM")
				self:STR1("Autodrive MODE?")
				self:STR1()
				self:STR1("YES-\"ENTER\"  NO-\"<-\"")
			elseif State == 72 then
				self:STR1("CONFIRM")
				self:STR1("SC MODE? ")
				self:STR1()
				self:STR1("YES-\"ENTER\"  NO-\"<-\"")
			elseif State == 73 then
				self:STR1("CONFIRM")
				self:STR1("SL MODE? ")
				self:STR1()
				self:STR1("YES-\"ENTER\"  NO-\"<-\"")
			elseif State == 74 then
				local State74 = self.Train:GetNW2Int("PAKSD:State74",1)
				local SD = self.Train:GetNW2Bool("PAKSD:KD",false)
				if State74 < 4 then
					self:STR1("1"..(State74 == 1 and "%" or "")..":"..(State74 == 1 and "$" or "").."ROLLING CHECK")
					self:STR1("2"..(State74 == 2 and "%" or "")..":"..(State74 == 2 and "$" or "").."DRIVE "..(SD and "WITH" or "WITHOUT").." SD")
					self:STR1("3"..(State74 == 3 and "%" or "")..":"..(State74 == 3 and "$" or "").."SETTINGS CHANGE")
					self:STR1("        VVVV        ")
				elseif State74 < 7 then
					self:STR1("4"..(State74 == 4 and "%" or "")..":"..(State74 == 4 and "$" or "")..(self.Train:GetNW2Bool("PAKSD:Transit",false) and "DIS " or "").."TRANSIT MODE")
					self:STR1("5"..(State74 == 5 and "%" or "")..":"..(State74 == 5 and "$" or "").."DRIVE WITH Vd=0")
					self:STR1("6"..(State74 == 6 and "%" or "")..":"..(State74 == 6 and "$" or "").."ZONED TURN")
					self:STR1("        VVVV        ")
				else
					self:STR1("7"..(State74 == 7 and "%" or "")..":"..(State74 == 7 and "$" or "").."FIX STATION")
					self:STR1("8"..(State74 == 8 and "%" or "")..":"..(State74 == 8 and "$" or "").."STATION MODE")
				end
			elseif State == 75 then
				local State75 = self.Train:GetNW2Int("PAKSD:State75",1)
				self:STR1("1"..(State75 == 1 and "%" or "")..":"..(State75 == 1 and "$" or "").."GO OUT FROM TRAIN")
				self:STR1("2"..(State75 == 2 and "%" or "")..":"..(State75 == 2 and "$" or "").."ENTRY FASTER")
				self:STR1("3"..(State75 == 3 and "%" or "")..":"..(State75 == 3 and "$" or "").."RELEASE DOORS")
				self:STR1("4"..(State75 == 4 and "%" or "")..":"..(State75 == 4 and "$" or "").."TRAIN DEPEAT SOON")
			elseif State == 76 then
				self:STR1("CONTINUE MOVEMENT")
				self:STR1("WITH VD=0? ")
				self:STR1()
				self:STR1("YES-\"ENTER\"  NO-\"<-\"")
			elseif State == 77 then
				self:STR1("ACCEPT")
				self:STR1("ROLLING CHECK?")
				self:STR1()
				self:STR1("YES-\"ENTER\"  NO-\"<-\"")
				--self:STR1("5:DRIVE WITH Vd = 0")
				--self:STR1("6:ZONED TURN")
			--[[
			elseif State == 79 then
				self:STR1("FOR TRANSIT MODE")
				self:STR1("PRESS ENTER")
				self:STR1("FOR CANCEL")
				self:STR1("PRESS \"-\"")
			elseif State == 75 then
				self:STR1("FOR ROLL MODE")
				self:STR1("PRESS ENTER")
				self:STR1("FOR CANCEL")
				self:STR1("PRESS \"-\"")
			elseif State == 77 then
				self:STR1("FOR STATION GO MODE")
				self:STR1("PRESS ENTER")
				self:STR1("FOR CANCEL")
				self:STR1("PRESS \"-\"")
			]]
			elseif self.Train:GetNW2Bool("PAKSD:Nakat",false) then
				self:STR1("ROLLING CHECK")
				self:STR1("DISTANCE:"..Format("%.2f",self.Train:GetNW2Float("PAKSD:Meters",0)))
				self:STR1("DIRECTION:"..(self.Train:GetNW2Bool("PAKSD:Sign",false) and "BACKWARD" or "FORWARD"))
				self:STR1(typ.."="..pos..string.rep(" ",6-#typ-#pos)..VZ..string.rep(" ",20-5-#VZ-6-1).."Vf="..speed)
			else
				local State7 = self.Train:GetNW2Int("PAKSD:State7",0)
				if State7 == 0 then
					self:STR1("  EXIT TO THE LINE")
					local date = os.date("!*t",os_time)
					self:STR1("    Tm="..Format("%02d:%02d:%02d",date.hour,date.min,date.sec))
					self:STR1()
					if self.VRDTimer and CurTime() - self.VRDTimer < 0 then
						self:STR1("@ACC MOV WITH Vd=0")
					elseif self.Train:GetNW2Bool("PAKSD:Transit",false) then
						self:STR1("TRANSIT MODE")
					else
						self:STR1(typ.."="..pos..string.rep(" ",6-#typ-#pos)..VZ..string.rep(" ",20-5-#VZ-6-1).."Vd="..spd)
						self.VRDTimer = nil
					end
				elseif State7 == 1 and Metrostroi.AnnouncerData then
					local path =  self.Train:GetNW2Int("PAKSD:Path",0)
					local bt = tostring(self.Train:GetNW2Int("PAKSD:BoardTime",0))
					local date = os.date("!*t",os_time)
					local tm = Format("%02d:%02d:%02d",date.hour,date.min,date.sec)
					self:STR1((Metrostroi.AnnouncerData[station] and Metrostroi.AnnouncerData[station][1]) and Metrostroi.AnnouncerData[station][1]:upper() or "UNK")
					self:STR1("TO "..Metrostroi.AnnouncerData[self.Train:GetNW2Int("PAKSD:LastStation",108)][1]:upper())
					self:STR1("ST "..bt..string.rep(" ",20-8-3-#bt)..tm)
					if self.VRDTimer and CurTime() - self.VRDTimer < 0 then
						self:STR1("@ACC MOV WITH Vd=0")
					elseif self.Train:GetNW2Bool("PAKSD:Transit",false) then
						self:STR1("TRANSIT MODE")
					else
						self:STR1(typ.."="..pos..string.rep(" ",6-#typ-#pos)..VZ..string.rep(" ",20-6-4-#VZ)..(path == 1 and "I " or "II" ).."P")
						self.VRDTimer = nil
					end
				else
					local name = self.Train:GetNW2String("PAKSD:SName","ERR")
					local curr = string.rep("#",speed/4.7-1)
					local max = string.rep("-",(spd ~= "H4" and spd or 0)/4.7-1)
					self:STR1(curr.."<"..string.rep(" ",20-#curr-3)..speed)
					self:STR1(max.."^"..string.rep(" ",20-#max-3)..spd)
					self:STR1("TC="..name..string.rep(" ",20-9-#name)..math.min(9999,math.floor(distance)).." m")
					if self.VRDTimer and CurTime() - self.VRDTimer < 0 then
						self:STR1("@ACC MOV WITH Vd=0")
					elseif self.Train:GetNW2Bool("PAKSD:Transit",false) then
						self:STR1("TRANSIT MODE")
					else
						self:STR1(typ.."="..pos..string.rep(" ",6-#typ-#pos)..VZ..string.rep(" ",20-2-6-1-#VZ-math.max(4,#self.StataionData[station])).."<"..self.StataionData[station]..">")
						self.VRDTimer = nil
					end
				end
			end
			self:STR2("V+= "..speed.." Vd= "..spd.." S= "..(station == 0 and "unk" or math.min(999,math.floor(distance))))
			self:STR2(typ.."= "..pos..string.rep(" ",6-#typ-#pos)..RK..string.rep(" ",20-7-4-3-#RK).."T= "..(self.Train:GetPackedRatio(3)*100.0 > 0.25 and math.min(999,math.floor(distance/(speed*1000/3600))) or "inf"))
		end
	end
end

function TRAIN_SYSTEM:UpdateUPO()
	for k,v in pairs(self.Train.WagonList) do
		if v.UPO then v.UPO:SetStations(self.Line,self.FirstStation,self.LastStation,v == self.Train) end
		v:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
	end
end

function TRAIN_SYSTEM:Trigger(name,nosnd)
	local Announcer = self.Train.Announcer
	if self.State == 1 and name == "BEnter" then
		self:SetState(2)
	elseif self.State == 2 then
		if name == "BEnter" then
			if self.Pass ~= self.EnteredPass then
				self.EnteredPass = "/"
			else
			self:SetState(3)
			end
		else
			if self.EnteredPass == "/" then self.EnteredPass = "" end
			local Char = tonumber(name:sub(2,2))
			if Char and #self.EnteredPass < 6 then self.EnteredPass = self.EnteredPass..tonumber(name:sub(2,2)) end
		end
	elseif self.State == 3 then
		if name == "B1" then
			self:SetState(4)
		end
		if name == "B2" and self.FirstStation ~= "" and self.LastStation ~= "" then
			self:SetState(49)
		end
	elseif self.State == 4 then
		--print(name)
		if name == "BDown" then
			self.State4Choosed = math.min(4,self.State4Choosed + 1)
		end
		if name == "BUp" then
			self.State4Choosed = math.max(1,self.State4Choosed - 1)
		end
		if name == "BLeft" then
			if self.State4Choosed == 2 then
				self.FirstStation= self.FirstStation:sub(1,-2)
			end
			if self.State4Choosed == 3 then
				self.LastStation= self.LastStation:sub(1,-2)
			end
			if self.State4Choosed == 4 then
				self.RouteNumber= self.RouteNumber:sub(1,-2)
			end
			self:UpdateUPO()
		end
		if name == "BEnter" then
			if not Metrostroi.EndStations[self.Line] or
				not Metrostroi.EndStations[self.Line][tonumber(self.FirstStation)] or
				not Metrostroi.AnnouncerData[tonumber(self.FirstStation)] or
				not Metrostroi.EndStations[self.Line][tonumber(self.LastStation)] or
				not Metrostroi.AnnouncerData[tonumber(self.LastStation)] or
				#self.RouteNumber < 3 then
				self:SetState(45)
			else
				self:SetState(5)
			end
		end
		local Char = tonumber(name:sub(2,2))
		if Char then
			if self.State4Choosed == 1 then
				self.Line = Char
				if Metrostroi.EndStations[self.Line] then
					local Routelength = #Metrostroi.EndStations[self.Line]
					self.FirstStation = tostring(Metrostroi.EndStations[self.Line][1])
					self.LastStation = tostring(Metrostroi.EndStations[self.Line][Routelength])
				end
			end
			if self.State4Choosed == 2 and #self.FirstStation < 3 then
				self.FirstStation= self.FirstStation..tostring(Char)
			end
			if self.State4Choosed == 3 and #self.LastStation < 3 then
				self.LastStation= self.LastStation..tostring(Char)
			end
			if self.State4Choosed == 4 and #self.RouteNumber < 3 then
				self.RouteNumber= self.RouteNumber..tostring(Char)
			end
			self:UpdateUPO()
		end
	elseif self.State == 49 then
		if name == "BDown" then
			self.State4Choosed = math.min(3,self.State4Choosed + 1)
		end
		if name == "BUp" then
			self.State4Choosed = math.max(1,self.State4Choosed - 1)
		end
		if name == "BLeft" then
			if self.State4Choosed == 2 then
				self.LastStation= self.LastStation:sub(1,-2)
			end
			if self.State4Choosed == 3 then
				self.RouteNumber= self.RouteNumber:sub(1,-2)
			end
			self:UpdateUPO()
		end
		if name == "BEnter" then
			if not Metrostroi.EndStations[self.Line] or
				not Metrostroi.EndStations[self.Line][tonumber(self.LastStation)] or
				not Metrostroi.AnnouncerData[tonumber(self.LastStation)] or
				#self.RouteNumber < 3 then
				self:SetState(48)
			else
				self:SetState(7)
			end
		end
		local Char = tonumber(name:sub(2,2))
		if Char then
			if self.State4Choosed == 1 then
				self.Line = Char
				if Metrostroi.EndStations[self.Line] then
					local Routelength = #Metrostroi.EndStations[self.Line]
					self.FirstStation = self.FirstStation ~= "" and self.FirstStation or tostring(Metrostroi.EndStations[self.Line][1])
					self.LastStation = tostring(Metrostroi.EndStations[self.Line][Routelength])
					if tonumber(self.LastStation) < tonumber(self.FirstStation) then
						local temp = self.FirstStation
						self.FirstStation = self.LastStation
						self.LastStation = temp
					end
				end
			end
			if self.State4Choosed == 2 and #self.LastStation < 3 then
				self.LastStation= self.LastStation..tostring(Char)
			end
			if self.State4Choosed == 3 and #self.RouteNumber < 3 then
				self.RouteNumber= self.RouteNumber..tostring(Char)
			end
			self:UpdateUPO()
		end
	elseif self.State == 45 then
		if name == "BEnter" then
			self:SetState(4,nil,true)
		end
	elseif self.State == 48 then
		if name == "BEnter" then
			self:SetState(49,nil,true)
		end
	elseif self.State == 5 then
		if name == "BEnter" and self.Check == false then
			self:SetState(6)
		end
	elseif self.State == 6 then
		if name == "BLeft" then
			self:SetState(3)
		end
		if name == "BEnter" then
			self:SetState(7)
		end
	elseif self.State == 7 and not self.Nakat then
		if name == "B1" then
			if not self.AutodriveWorking and self.Train.ALS_ARS["33G"] < 0.5 then
				self:SetState(71)
			end
		elseif name == "B2" then
			if (self.AutodriveWorking or self.VRD or self.UOS) and not self.Trainsit then
				self:SetState(72)
			end
		elseif name == "B3" then
			--print(self.Train.ALS_ARS.Signal0,self.Train.ALS_ARS.RealNoFreq)
			if not self.UOS and not self.Train.ALS_ARS.EnableARS then
				self:SetState(73)
			end
		elseif name == "BEnter" then
			self:SetState(74)
		elseif name == "BPlus" then
			self:SetState(75)
		end
		--[[
		elseif name == "B5" then
			if not self.Transit and not self.VRD then
				self:SetState(74)
			end
		elseif name == "B6" then
			if not self.Nakat and not self.VRD then
				self:SetState(75)
			end
		elseif name == "B7" then
			if not self.Stancionniy and not self.VRD then
				self:SetState(77)
			end
		elseif name == "BUp" then
			self:AnnII(4)
		elseif name == "BDown" then
			self:AnnII(3)
		elseif name == "BPlus" then
			self:AnnII(2)
		elseif name == "BMinus" then
			self:AnnII(1)
		end
		]]
	elseif self.State == 7 and self.Nakat then
		self.Nakat = false
		if self.Train:ReadTrainWire(1) < 1 then
			self.Train.ALS_ARS.Nakat = false
		end
	elseif self.State == 71 then
		if name == "BEnter" then
			self.AutodriveWorking = true
			self.UOS = false
			self:SetState(7,nil,true)
		end
		if name == "BLeft" then
			self:SetState(7,nil,true)
		end
	elseif self.State == 72 then
		if name == "BEnter" then
			self.AutodriveWorking = false
			self.UOS = false
			self:SetState(7,nil,true)
		end
		if name == "BLeft" then
			self:SetState(7,nil,true)
		end
	elseif self.State == 73 then
		if name == "BEnter" then
			self.AutodriveWorking = false
			self.UOS = true
			self:SetState(7,nil,true)
		end
		if name == "BLeft" then
			self:SetState(7,nil,true)
		end
	elseif self.State == 74 then
		if name == "BUp" then
			self.State74 = math.max(1,self.State74 - 1)
			--if self.State74 == 4 and self.Transit then
				--self:Trigger("BUp",true)
			--else
			if self.State74 == 5 and (self.VRD or not (self.Train.ALS_ARS.Signal0 and not self.Train.ALS_ARS.RealNoFreq and not self.Train.ALS_ARS.Signal40 and not self.Train.ALS_ARS.Signal60 and not self.Train.ALS_ARS.Signal70 and not self.Train.ALS_ARS.Signal80)) then
				self:Trigger("BUp",true)
			elseif self.State74 == 6 then
				if self.LastStation == tostring(self.Train.UPO.Station) then
					self:Trigger("BUp",true)
				end
			elseif self.State74 == 7 then
				if self.FirstStation == tostring(self.Train.UPO.Station) then
					self:Trigger("BUp",true)
				end
			end
		end
		if name == "BDown" then
			self.State74 = math.min(8,self.State74 + 1)
			--if self.State74 == 4 and self.Transit then
				--self:Trigger("BDown",true)
			--else
			if self.State74 == 5 and (self.VRD or not (self.Train.ALS_ARS.Signal0 and not self.Train.ALS_ARS.RealNoFreq and not self.Train.ALS_ARS.Signal40 and not self.Train.ALS_ARS.Signal60 and not self.Train.ALS_ARS.Signal70 and not self.Train.ALS_ARS.Signal80)) then
				self:Trigger("BDown",true)
			elseif self.State74 == 6 then
				if self.LastStation == tostring(self.Train.UPO.Station) then
					self:Trigger("BDown",true)
				end
			elseif self.State74 == 7 then
				if self.FirstStation == tostring(self.Train.UPO.Station) then
					self:Trigger("BDown",true)
				end
			end
		end
		if name == "BLeft" then
			self:SetState(7,nil,true)
		end
		if name == "BEnter" then
			if self.State74 == 1 and self.Train.Speed < 0.5 and self.Train.ALS_ARS.SpeedLimit > 20 then
				self:SetState(77)
			elseif self.State74 == 2 then
				self.KD = not self.KD
			elseif self.State74 == 3 then
				self:SetState(3)
			elseif self.State74 == 4 then
				self.Transit = not self.Transit
				self.AutodriveWorking = false
			elseif self.State74 == 5 then
				self:SetState(76)
			elseif self.State74 == 6 then
				if Metrostroi.EndStations[self.Line][self.Train.UPO.Station] then
					self.LastStation = tostring(self.Train.UPO.Station)
				end
			elseif self.State74 == 7 then
				if Metrostroi.EndStations[self.Line][self.Train.UPO.Station] then
					self.FirstStation = tostring(self.Train.UPO.Station)
				end
			elseif self.State74 == 8 and not self.Arrived then
				self.Arrived = true
			end
			if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self:SetState(7,nil,true) end
		end
		if self.State74 > 6 then
			if name == "B7" then
				if Metrostroi.EndStations[self.Line][self.Train.UPO.Station] then
					self.FirstStation = tostring(self.Train.UPO.Station)
					if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self:SetState(7,nil,true) end
				end
			end
			if name == "B8"  and not self.Arrived == nil then
				self.Arrived = true
				if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self:SetState(7,nil,true) end
			end
		elseif self.State74 > 3 then
			if name == "B4" then
				self.Transit = not self.Transit
				self.AutodriveWorking = false
				if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self:SetState(7,nil,true) end
			end
			if name == "B5" then
				self:SetState(76)
				if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self:SetState(7,nil,true) end
			end
			if name == "B6" then
				if Metrostroi.EndStations[self.Line][self.Train.UPO.Station] then
					self.LastStation = tostring(self.Train.UPO.Station)
					if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self:SetState(7,nil,true) end
				end
			end
		else
			if name == "B1" and self.Train.Speed < 0.5 and self.Train.ALS_ARS.SpeedLimit > 20 then
				self:SetState(77)
				if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self:SetState(7,nil,true) end
			end
			if name == "B2" then
				self.KD = not self.KD
				if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self:SetState(7,nil,true) end
			end
			if name == "B3" then
				self:SetState(3)
				if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self:SetState(7,nil,true) end
			end
		end
	elseif self.State == 75 then
		if name == "BUp" then
			self.State75 = math.max(1,self.State75 - 1)
		end
		if name == "BDown" then
			self.State75 = math.min(4,self.State75 + 1)
		end
		if name == "BLeft" then
			self:SetState(7,nil,true)
		end
		if name == "BEnter" then
			self.Train.UPO:II(self.State75)
			self:SetState(7,nil,true)
		end
		local Char = tonumber(name:sub(2,2))
		if Char and Char > 0 and Char < 5 then
			self.Train.UPO:II(Char)
			self:SetState(7,nil,true)
		end
	elseif self.State == 76 then
		if name == "BEnter" then
			self.AutodriveWorking = false
			self.VRD = true
			self:SetState(7,nil,true)
		end
		if name == "BLeft" then
			self:SetState(7,nil,true)
		end
	elseif self.State == 77 then
		if name == "BEnter" then
			if self.Train.Speed < 0.5 and self.Train.ALS_ARS.SpeedLimit > 20 then
				self.AutodriveWorking = false
				self.VRD = false
				self.Nakat = true
			end
			self:SetState(7,nil,true)
		end
		if name == "BLeft" then
			self:SetState(7,nil,true)
		end

		--[[
	elseif self.State == 74 then
		if name == "BEnter" then
			self.AutodriveWorking = false
			self.UOS = false
			self.VRD = false
			self.Transit = true
			self.Nakat = false
			self.Stancionniy = false
			self:SetState(7,nil,true)
		end
		if name == "BMinus" then
			self:SetState(7,nil,true)
		end
	elseif self.State == 75 then
		if name == "BEnter" then
			self.AutodriveWorking = false
			self.UOS = false
			self.VRD = false
			self.Transit = false
			self.Nakat = true
			self.Stancionniy = false
			self:SetState(7,nil,true)
		end
		if name == "BMinus" then
			self:SetState(7,nil,true)
		end
	elseif self.State == 77 then
		if name == "BEnter" then
			self.AutodriveWorking = false
			self.UOS = false
			self.VRD = false
			self.Transit = false
			self.Nakat = false
			self.Stancionniy = true
			self:SetState(7,nil,true)
		end
		if name == "BMinus" then
			self:SetState(7,nil,true)
		end
		]]
	end
end
--[[
function TRAIN_SYSTEM:PAKSD1()
	surface.SetDrawColor(0,255,127)
	for x = 1,20 do
		for y = 0,3 do
			for x1 = 1,5 do
				for y1 = 1,7 do
					self.Train:DrawCircle(5+x1*2 + x*12,5+y1*2 + y*16,1)
				end
			end
		end
	end
end
function TRAIN_SYSTEM:PAKSD2()
	surface.SetDrawColor(0,255,127)
	for i = 0,1 do
		for x = 1,5 do
			for y = 1,7 do
				self.Train:DrawCircle(5+x*2,5+y*2 + i*16,1)
			end
		end
	end
end
]]

function TRAIN_SYSTEM:SetState(state,state7,noupd)
	local Train = self.Train
	local ARS = Train.ALS_ARS
	local Announcer = Train.Announcer
	if state and self.State ~= state then
		self.State = state
		if noupd then return end
		self:SetTimer()
		if state == -2 then
			self.Train:PlayOnce("paksd","cabin",0.75,200.0)
		end
		if state == 2 then
			self.EnteredPass = ""
		end
		if state == 4 then
			self.Line = self.Train.UPO.Line or 1
			self.RouteNumber = ""
			self.State4Choosed = 1
			if Metrostroi.EndStations[self.Line] then
				self.FirstStation = self.Train.UPO.FirstStation or tostring(self.Train.UPO.Path == 2 and Metrostroi.EndStations[self.Line][#Metrostroi.EndStations[self.Line]] or Metrostroi.EndStations[self.Line][1])
				self.LastStation = self.Train.UPO.LastStation or tostring(self.Train.UPO.Path == 1 and Metrostroi.EndStations[self.Line][#Metrostroi.EndStations[self.Line]] or Metrostroi.EndStations[self.Line][1])
			else
				self.FirstStation = "111"
				self.LastStation = "123"
			end
			self:UpdateUPO()
		end
		if state == 49 then
			self.State4Choosed = 1
		end
		if state == 5 then
			self.Check = nil
		else
			self.Train.ALS_ARS:TriggerInput("Ring",0)
		end
		if state == 7 then
			if not state7 then
				for k,v in pairs(self.Train.WagonList) do
					if v ~= self.Train and v["PA-KSD"] then
						v["PA-KSD"]:SetState(7,true)
					end
				end
			end
		end
		if state == 74 then
			self.State74 = 1
		end
		if state == 75 then
			self.State75 = 1
		end
	end
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

function TRAIN_SYSTEM:Think(dT)
	--print(self.Train.PAKSD_VUD.Value)
	if self.Train.Blok ~= 2 then self:SetState(0) return end
	if self.VPA and self.Train.VPA.Value < 1 and not self.OffTimer then
		self.OffTimer = CurTime() + 1
		self.OnTimer = nil
	end
	if self.Train.VPA.Value == 1 and self.OffTimer then
		self.OffTimer = nil
		self.OnTimer = nil
	end
	if not self.VPA and self.Train.VPA.Value > 1 and not self.OnTimer then
		self.OffTimer = nil
		self.OnTimer = CurTime() + 1
	end
	if self.OnTimer and (CurTime() - self.OnTimer) > 0 then
		for k,v in pairs(self.Train.WagonList) do
			if v["PA-KSD"] then v["PA-KSD"].VPA = true end
		end
		self.OnTimer = nil
	end
	if self.OffTimer and (CurTime() - self.OffTimer) > 0 then
		for k,v in pairs(self.Train.WagonList) do
			if v["PA-KSD"] then v["PA-KSD"].VPA = false end
		end
		self.OffTimer = nil
	end
	if self.Train.VB.Value > 0.5 and self.Train.Battery.Voltage > 55 and self.VPA and self.State >= -1  then
		for k,v in pairs(self.TriggerNames) do
			if self.Train[v] and (self.Train[v].Value > 0.5) ~= self.Triggers[v] then
				if self.Train[v].Value > 0.5 then
					self:Trigger(v)
					self.Train:PlayOnce("paksd","cabin",0.75,160.0)
				end
				--print(v,self.Train[v].Value > 0.5)
				self.Triggers[v] = self.Train[v].Value > 0.5
			end
		end
	end
	--print(self.Train.Owner)
	local ARS = self.Train.ALS_ARS
	local Announcer = self.Train.Announcer
	--self.Train.UPO.Station = self.Train:ReadCell(49160) > 0 and self.Train:ReadCell(49160) or self.Train:ReadCell(49161)
	--self.Train.UPO.Path = Metrostroi.PathConverter[self.Train:ReadCell(65510)] or 0
	--self.Train.UPO.Distance = self.Train:ReadCell(49165) + (self.Train.Autodrive.Corrections[self.Train.UPO.Station] or 0)
	--print(self.Train.VB.Value < 0.5 or self.Train.Battery.Voltage < 55)
	if self.Train.VB.Value < 0.5 or self.Train.Battery.Voltage < 55 or not self.VPA  then self:SetState(0) elseif self.State == 0 then self:SetState(-2) end
	--if not ARS.EnableARS and self.State > 6 then self.State = -1 end
	if self.Train.KV.ReverserPosition == 0 and self.State > 6 and self.State ~= 8 then self:SetState(8) end
	if self.Train.KV.ReverserPosition == 0 and self.State > 0 and self.State < 6 and self.State ~= -9 then self:SetState(-9) end
	if self.Train.KV.ReverserPosition ~= 0 and self.State == -9 then self:SetState(1) end
	if self.Train.KV.ReverserPosition ~= 0 and self.State == 8 then
		self:SetState(7,nil,true)
	end
	if self.State == -2 then
		self:SetTimer(0.5)
		if self:GetTimer(5) then
			self.State = -1
			return
		end
	elseif self.State == -1 then
		if self.Train.KV.ReverserPosition == 0 then
			self:SetState(1)
		else
			self:SetState(-9)
		end
	elseif self.State == 5 then
		if self.Check == nil then ARS:TriggerInput("Ring",1) end
		--print(ARS.KVT)
		if ARS.KVT and self.Check == nil then
			self.Check = true
			self:SetTimer(4)
		end
		if not ARS.KVT and self.Check ~= false then
			self.Check = nil
			self:SetTimer()
		end
		if ARS.KVT and self:GetTimer(1) then
			self.Check = false
			ARS:TriggerInput("Ring",0)
			self:SetTimer()
		end
	elseif self.State > 6 and self.State ~= 8 and self.State ~= 49 and self.State ~= 45 and self.State ~= 48 then
		if self.VRD and (not ARS.Signal0 or ARS.Signal0 and (ARS.Signal40 or ARS.Signal60 or ARS.Signal70 or ARS.Signal80)) then self.VRD = false end
		if self.Train.UPO.Distance > 40 and (self.Train.UPO.Distance) < (160+35*self.Train.Autodrive.MU - (ARS.SpeedLimit == 40 and 30 or 0)) then
			self.Train.UPO.StationAutodrive = true
		end
		if (self.Train.UPO:GetSTNum(self.LastStation) > self.Train.UPO:GetSTNum(self.FirstStation) and self.Train.UPO.Path == 2) or (self.Train.UPO:GetSTNum(self.FirstStation) > self.Train.UPO:GetSTNum(self.LastStation)  and self.Train.UPO.Path == 1) then
			local old = self.LastStation
			self.LastStation = self.FirstStation
			self.FirstStation = old
			self:UpdateUPO()
		end
		self.State7 = (self.Train.UPO:End(self.Train.UPO.Station,self.Train.UPO.Path,true) or self.Train.UPO:GetSTNum(self.LastStation) > self.Train.UPO:GetSTNum(self.Train.UPO.Station) and self.Train.UPO.Path == 2 or self.Train.UPO:GetSTNum(self.Train.UPO.Station) < self.Train.UPO:GetSTNum(self.FirstStation) and self.Train.UPO.Path == 1) and 0 or self.Arrived ~= nil and 1 or 2
		if self.State7 ~= 0 then
			if (self.RealState == 8 or self.RealState == 6 or self.RealState == 49) and not self.Transit then
				if self.Train.UPO.Distance < 75 and not self.Arrived and Metrostroi.WorkingStations[self.Line][self.Train.UPO.Station] and ARS.Speed <= 1 then
					self.Arrived = true
				end
			end
			if not self.Transit and 45 < self.Train.UPO.Distance and self.Train.UPO.Distance < 75 and not self.Arrived and Metrostroi.WorkingStations[self.Line][self.Train.UPO.Station] then
				self.Arrived = true
			end
			if self.Transit then self.Arrived = nil end
			if self.Train.UPO.Distance > 75 then
				self.Arrived = nil
			else
				--if self.Train.Panel.SD < 0.5 then self.Arrived = true end
			end
			if self.Arrived then
				if self.Train.UPO.BoardTime and math.floor((self.Train.UPO.BoardTime or CurTime()) - CurTime()) < (self.Train.Horlift and 15 or 8) and self.Arrived then
					self.Arrived = false
				end
			end
			if self.Nakat then
				if not self.Meters then self.Meters = 0 end
				self.Meters = self.Meters + ARS.Speed*self.Train.SpeedSign/3600*1000*dT
				if math.abs(self.Meters) > 2.5 then
					self.Nakat = false
					if self.Train:ReadTrainWire(1) < 1 then
						ARS.Nakat = true
					end
				end
			else
				self.Meters = nil
			end
		end
	end
	if self.State ~= self.RealState then
		self.RealState = self.State
		self.TimeOverride = true
	end

	self.Time = self.Time or CurTime()
	if (CurTime() - self.Time) > 0.1 or self.TimeOverride then
		self.TimeOverride = nil
		--print(1)
		self.Time = CurTime()
		--if self.STR1 ~= self.STR1Real then
			--self.Train:SetNW2String("PAKSD1",self.STR1)
			--self.STR1 = self.STR1Real
		--end
		--if self.STR2 ~= self.STR2Real then
			--self.Train:SetNW2String("PAKSD2",self.STR2)
			--self.STR2 = self.STR2Real
		--end
		--self.Train:SetNW2String("PAKSD2","V+= 59 VD= 70 self.Train.UPO.Distance= 307\nKB=T1       Tx= -2c")
		self.Train:SetNW2Int("PAKSD:State",self.State)
		if self.State == 2 then self.Train:SetNW2Int("PAKSD:Pass",self.EnteredPass ~= "/" and #self.EnteredPass or -1)
		elseif self.State == 3 then self.Train:SetNW2Bool("PAKSD:Restart",self.FirstStation ~= "" and self.LastStation ~= "")
		elseif self.State == 4 then
			self.Train:SetNW2Int("PAKSD:State4",self.State4Choosed)
			if self.State4Choosed < 4 then
				self.Train:SetNW2Int("PAKSD:FirstStation",tonumber(self.FirstStation) or -1)
				self.Train:SetNW2Int("PAKSD:LastStation",tonumber(self.LastStation) or -1)
				self.Train:SetNW2Int("PAKSD:Line",self.Line)
			else
				self.Train:SetNW2Int("PAKSD:RouteNumber",tonumber(self.RouteNumber ~= "" and self.RouteNumber or -1))
			end
		elseif self.State == 49 then
			self.Train:SetNW2Int("PAKSD:State4",self.State4Choosed)
			self.Train:SetNW2Int("PAKSD:LastStation",tonumber(self.LastStation) or -1)
			self.Train:SetNW2Int("PAKSD:Line",self.Line)
			self.Train:SetNW2Int("PAKSD:RouteNumber",tonumber(self.RouteNumber ~= "" and self.RouteNumber or -1))
		elseif self.State == 7 then
			self.Train:SetNW2Int("PAKSD:LastStation",tonumber(self.LastStation))
			self.Train:SetNW2Int("PAKSD:State7",self.State7)
			self.Train:SetNW2Int("PAKSD:Nakat",self.Nakat)
			self.Train:SetNW2Bool("PAKSD:VRD",self.VRD)
			self.Train:SetNW2Bool("PAKSD:Transit",self.Transit)
			self.Train:SetNW2Int("PAKSD:Station",self.Train.UPO.Station)
			self.Train:SetNW2Int("PAKSD:Distance",self.Train.UPO.Distance)
			self.Train:SetNW2Int("PAKSD:Type",(self.Train.Pneumatic.EmergencyValveEPK and 0 or self.Train.ALS_ARS.UAVAContacts and 4 or self.UOS and 5 or self.VRD and 2 or (self.Train.AutodriveEnabled or self.Train.UPO.StationAutodrive) and 1 or 3))
			self.Train:SetNW2Int("PAKSD:PPT",math.Clamp(math.floor(self.Train.PositionSwitch.Position + 0.5),1,3))
			self.Train:SetNW2Int("PAKSD:RK",math.floor(self.Train.RheostatController.Position+0.5))
			self.Train:SetNW2Int("PAKSD:KV",self.Train.Autodrive.AutodriveEnabled and (self.Rotating and -3 or self.Brake and -1 or self.Accelerate and 3 or 0) or (ARS["33G"] > 0 or (self.UOS and (ARS["8"] + (1-self.Train.RPB.Value)) > 0)) and 5 or self.Train.KV.RealControllerPosition)
			self.Train:SetNW2Bool("PAKSD:VZ1", self.Train:ReadTrainWire(29) > 0)
			self.Train:SetNW2Bool("PAKSD:VZ2", self.Train.PneumaticNo2.Value > 0)
			self.Train:SetNW2Bool("PAKSD:UOS", self.UOS)

			--self.Train:SetNW2Int("PAKSD:ARS",ARS.Signal80 and 80 or ARS.Signal70 and 70 or ARS.Signal60 and 60 or ARS.Signal40 and 40 or ARS.Signal0 and 0 or -1)
			--local speed = tostring(math.floor(ARS.Speed))

			if self.State7 == 1 then
				self.Train:SetNW2Int("PAKSD:BoardTime",math.floor((self.Train.UPO.BoardTime or CurTime()) - CurTime()))
				self.Train:SetNW2Int("PAKSD:Path",self.Train.UPO.Path)
			elseif self.State7 == 2 then
				self.Train:SetNW2String("PAKSD:SName",ARS.Signal and ARS.Signal.RealName or "ERR")
			end
			if self.Nakat then
				self.Train:SetNW2Float("PAKSD:Meters",math.Round(math.abs(self.Meters or 0),1))
				self.Train:SetNW2Bool("PAKSD:Sign",ARS.Speed > 0.5 and self.Train.SpeedSign < 0)
			end
		elseif self.State == 74 then
			self.Train:SetNW2Int("PAKSD:State74",self.State74)
			self.Train:SetNW2Bool("PAKSD:KD",self.KD)
			self.Train:SetNW2Bool("PAKSD:Transit",self.Transit)
		elseif self.State == 75 then
			self.Train:SetNW2Int("PAKSD:State75",self.State75)
		elseif self.State == 8 then
			self.Train:SetNW2Bool("PAKSD:VRD",self.VRD)
			self.AutodriveWorking = false
			self.UOS = false
			self.VRD = false
			self.Transit = false
			self.Nakat = false
			self.Stancionniy = false
		end
	end
	if self.Train.VZP.Value > 0.5 and self.AutodriveWorking then
		self.Train.Autodrive:Enable()
	end
	self.RouteNumber = string.gsub(self.Train.RouteNumber or "","^(0+)","")
	if self.State > 4 and self.State ~= 49 then
		self.Line = self.Train.UPO.Line
		self.FirstStation = tostring(self.Train.UPO.FirstStation or "")
		self.LastStation = tostring(self.Train.UPO.LastStation or "")
	end
end

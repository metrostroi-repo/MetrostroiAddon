AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString "metrostroi-signal"
util.AddNetworkString "metrostroi-signal-state"
function ENT:SetSprite(index,active,model,scale,brightness,pos,color)
	if active and self.Sprites[index] then return end
	if not active and not self.Sprites[index] then return end
	if not active and self.Sprites[index] then
		SafeRemoveEntity(self.Sprites[index])
		self.Sprites[index] = nil
	end

	if active then
		local sprite = ents.Create("env_sprite")
		sprite:SetParent(self)
		sprite:SetLocalPos(pos)
		sprite:SetLocalAngles(self:GetAngles())

		-- Set parameters
		sprite:SetKeyValue("rendercolor",
			Format("%i %i %i",
				color.r*brightness,
				color.g*brightness,
				color.b*brightness
			)
		)
		sprite:SetKeyValue("rendermode", 9) -- 9: WGlow, 3: Glow
		sprite:SetKeyValue("renderfx", 14)
		sprite:SetKeyValue("model", model)
		sprite:SetKeyValue("scale", scale)
		sprite:SetKeyValue("spawnflags", 1)

		-- Turn sprite on
		sprite:Spawn()
		self.Sprites[index] = sprite
	end
end
function ENT:OpenRoute(route)
	self.LastOpenedRoute = route
	if self.Routes[route].Manual then self.Routes[route].IsOpened = true end
	if not self.Routes[route].Switches then return end
	local Switches = string.Explode(",",self.Routes[route].Switches)

	for i1 =1, #Switches do
		if not Switches[i1] or Switches[i1] == "" then continue end

		local SwitchState = Switches[i1]:sub(-1,-1) == "-"
		local SwitchName = Switches[i1]:sub(1,-2)
		--if not self.Switches[SwitchName] then self.Switches[SwitchName] = Metrostroi.GetSwitchByName(SwitchName) end
		if not Metrostroi.GetSwitchByName(SwitchName) then print(self.Name,"switch not found") continue end
		--If route go right from this switch - add it
		if SwitchState ~= (Metrostroi.GetSwitchByName(SwitchName):GetSignal() ~= 0) then
			Metrostroi.GetSwitchByName(SwitchName):SendSignal(SwitchState and "alt" or "main",nil,true)
			--RunConsoleCommand("say","changing",SwitchName)
		end
	end
end

function ENT:CloseRoute(route)
	if self.Routes[route].Manual then self.Routes[route].IsOpened = false end
	if not self.Routes[route].Switches then return end

	local Switches = string.Explode(",",self.Routes[route].Switches)
	for i1 =1, #Switches do
		if not Switches[i1] or Switches[i1] == "" then continue end

		--local SwitchState = Switches[i1]:sub(-1,-1) == "-"
		local SwitchName = Switches[i1]:sub(1,-2)
		--if not self.Switches[SwitchName] then self.Switches[SwitchName] = Metrostroi.GetSwitchByName(SwitchName) end
		if not Metrostroi.GetSwitchByName(SwitchName) then print(self.Name,"switch not found") continue end
		--If route go right from this switch - add it
		if SwitchState ~= (Metrostroi.GetSwitchByName(SwitchName):GetSignal() ~= 0) then
			Metrostroi.GetSwitchByName(SwitchName):SendSignal("main",nil,true)
			--RunConsoleCommand("say","changing",SwitchName)
		end
	end
end

function MSignalSayHook(ply, comm, fromULX)
	if ulx and not fromULX then return end
	for i,sig in pairs(ents.FindByClass("gmod_track_signal")) do
		local comm = comm
		if comm:sub(1,8) == "!sactiv " then
			comm = comm:sub(9,-1):upper()

			comm = string.Explode(":",comm)
			if sig.Routes then
				for k,v in pairs(sig.Routes) do
					if (v.RouteName and v.RouteName:upper() == comm[1] or comm[1] == "*") and v.Emer then
						if sig.LastOpenedRoute and k ~= sig.LastOpenedRoute then sig:CloseRoute(sig.LastOpenedRoute) end
						v.IsOpened = true
						break
					end
				end
			end
		elseif comm:sub(1,10) == "!sdeactiv " then
			comm = comm:sub(11,-1):upper()

			comm = string.Explode(":",comm)
			if sig.Routes then
				for k,v in pairs(sig.Routes) do
					if (v.RouteName and v.RouteName:upper() == comm[1] or comm[1] == "*") and v.Emer then
						v.IsOpened = false
						break
					end
				end
			end
		elseif comm:sub(1,8) == "!sclose " then
			comm = comm:sub(9,-1):upper()

			comm = string.Explode(":",comm)
			if comm[1] == sig.Name then
				if sig.Routes[1] and sig.Routes[1].Manual then
					sig:CloseRoute(1)
				else
					if not sig.Close then
						sig.Close = true
					end
					if sig.InvationSignal then
						sig.InvationSignal = false
					end
					if (sig.LastOpenedRoute and sig.LastOpenedRoute == 1) or sig.Routes[1].Repeater then
						sig:CloseRoute(1)
					else
						sig:OpenRoute(1)
					end
				end
			elseif sig.Routes then
				for k,v in pairs(sig.Routes) do
					if v.RouteName and v.RouteName:upper() == comm[1] then
						if sig.LastOpenedRoute and k ~= sig.LastOpenedRoute then sig:CloseRoute(sig.LastOpenedRoute) end
						sig:CloseRoute(k)
					end
				end
			end
		elseif comm:sub(1,7) == "!sopen " then
			comm = comm:sub(8,-1):upper()
			comm = string.Explode(":",comm)
			if comm[1] == sig.Name then
				if comm[2] then
					if sig.NextSignals[comm[2]] then
						local Route
						for k,v in pairs(sig.Routes) do
							if v.NextSignal == comm[2] then Route = k break end
						end
						sig:OpenRoute(Route)
					end
				else
					if sig.Routes[1] and sig.Routes[1].Manual then
						sig:OpenRoute(1)
					elseif sig.Close then
						sig.Close = false
					end
				end
			elseif sig.Routes then
				for k,v in pairs(sig.Routes) do
					if v.RouteName and v.RouteName:upper() == comm[1] then
						if sig.LastOpenedRoute and k ~= sig.LastOpenedRoute then sig:CloseRoute(sig.LastOpenedRoute) end
						sig:OpenRoute(k)
					end
				end
			end
		elseif comm:sub(1,7) == "!sopps " then
			comm = comm:sub(8,-1):upper()
			comm = string.Explode(":",comm)
			if comm[1] == sig.Name then
				sig.InvationSignal = true
			end
		elseif comm:sub(1,7) == "!sclps " then
			comm = comm:sub(8,-1):upper()
			comm = string.Explode(":",comm)
			if comm[1] == sig.Name then
				sig.InvationSignal = false
			end
		elseif comm:sub(1,7) == "!senao " then
			comm = comm:sub(8,-1):upper()
			comm = string.Explode(":",comm)
			if comm[1] == sig.Name then
				if sig.AODisabled then sig.AODisabled = false end
			end
		elseif comm:sub(1,8) == "!sdisao " then
			comm = comm:sub(9,-1):upper()
			comm = string.Explode(":",comm)
			if comm[1] == sig.Name then
				if sig.ARSSpeedLimit == 2 then sig.AODisabled = true end
			end
		end
	end
end
hook.Add("PlayerSay","metrostroi-signal-say", function(ply, comm) MSignalSayHook(ply,comm) end)
function ENT:Initialize()
	self:SetModel(self.TrafficLightModels[self.SignalType or 0].ArsBox.model)
	self.Sprites = {}
	self.Sig = ""
	self.FreeBS = 1
	self.OldBSState = 1
	self.OutputARS = 1
	self.EnableDelay = {}
	self.PostInitalized = true

	self.Controllers = nil
	self.OccupiedOld = false
	self.ControllerLogicCheckOccupied = false
	self.ControllerLogicOverride325Hz = false
	self.Override325Hz = false
end

function ENT:PreInitalize()
	self.AutostopOverride = nil
	if not self.Routes or self.Routes[1].NextSignal == "" then
		self.AutostopOverride = true
	end
	if self.Sprites then
		for k,v in pairs(self.Sprites) do
			SafeRemoveEntity(v)
			self.Sprites[k] = nil
		end
	end
	self.NextSignals = {}
	--self.Switches = {}
	for k,v in ipairs(self.Routes) do
		if v.NextSignal == "" then
			self.NextSignals[""] = nil--self
		elseif v.NextSignal == "*" then
		else
			if not v.NextSignal then
				ErrorNoHalt(Format("Metrostroi: No next signal name in signal %s! Check it now!\n", self.Name))
				self.AutostopOverride = true
			else
				self.NextSignals[v.NextSignal] = Metrostroi.GetSignalByName(v.NextSignal)
				if not self.NextSignals[v.NextSignal] then
					print(Format("Metrostroi: Signal %s, signal not found(%s)", self.Name, v.NextSignal))
					self.AutostopOverride = true
				end
			end
		end
	end
	self.MU = false
	for k,v in ipairs(self.Lenses) do
		if v:find("M") then self.MU = true break end
	end
end
function ENT:PostInitalize()
	if not self.Routes or #self.Routes == 0 then print(self, "NEED SETUP") return end
	for k,v in ipairs(self.Routes) do
		if v.NextSignal == "*" and self.TrackPosition then
			local sig
			local cursig = self
			while true do
				cursig = Metrostroi.GetARSJoint(cursig.TrackPosition.node1,cursig.TrackPosition.x,cursig.TrackDir,false)
				if not IsValid(cursig) then break end
				sig = cursig
				if not cursig.PassOcc then break end
			end
			if IsValid(sig) then
				self.NextSignals["*"] = sig
			else
				self.AutostopOverride = true
				print(Format("Metrostroi: Signal %s, cant automaticly find signal", self.Name))
			end
		end
	end
	local pos = self.TrackPosition
	local node = pos and pos.node1 or nil
	self.Node = node

	self.SwitchesFunction = {}
	self.Switches = {}
	for i = 1,#self.Routes do
		if not self.Routes[i].Switches then continue end

		local Switches = string.Explode(",",self.Routes[i].Switches)
		local SwitchesTbl = {}
		--local GoodSwitches = true
		--Checking all route switches
		for i1 =1, #Switches do
			if not Switches[i1] or Switches[i1] == "" then continue end

			local SwitchState = Switches[i1]:sub(-1,-1) == "-"
			local SwitchName = Switches[i1]:sub(1,-2)
			if not Metrostroi.GetSwitchByName(SwitchName) then
				print(Format("Metrostroi: %s, switch not found(%s)", self.Name, SwitchName))
				continue
			end
			--If route go right from this switch - add it
			table.insert(SwitchesTbl,{n = SwitchName,s = SwitchState})
		end
		self.Switches[i] = SwitchesTbl
		if #SwitchesTbl == 0 then continue end
		self.SwitchesFunction[i] = function()
			local GoodSwitches = true
			for i1 = 1,#self.Switches[i] do
				if not self.Switches[i][i1] or not IsValid(Metrostroi.GetSwitchByName(self.Switches[i][i1].n)) then continue end
				if self.Switches[i][i1].s ~= (Metrostroi.GetSwitchByName(self.Switches[i][i1].n):GetSignal() > 0) then
					GoodSwitches = false
					break
				end
			end
			return GoodSwitches
		end
	end
	for k,v in pairs(self.Routes) do
		if not v.Lights then continue end
		v.LightsExploded = string.Explode("-",v.Lights)
	end
	if not self.RouteNumberSetup or not self.RouteNumberSetup:find("W") then
		self.GoodInvationSignal = 0
		local index = 1
		for k,v in ipairs(self.Lenses) do
			if v ~= "M" then
				for i = 1,#v do
					if v[i] == "W" then self.GoodInvationSignal = index end
					index = index + 1
				end
			end
		end
	else
		self.GoodInvationSignal = -1
	end
	if self.Left then
		self:SetModel(self.TrafficLightModels[self.SignalType or 0].ArsBoxMittor.model)
	else
		self:SetModel(self.TrafficLightModels[self.SignalType or 0].ArsBox.model)
	end
	self.PostInitalized = false

end

function ENT:OnRemove()
	Metrostroi.UpdateSignalEntities()
	Metrostroi.PostSignalInitialize()
end

function ENT:GetARS(ARSID,Force1_5,Force2_6)
	if self.OverrideTrackOccupied then return ARSID == 2 end
	if not self.ARSSpeedLimit then return false end
	local nxt = self.ARSNextSpeedLimit == 2 and 0 or self.ARSNextSpeedLimit ~= 1 and self.ARSNextSpeedLimit
	return self.ARSSpeedLimit == ARSID or ((self.TwoToSix and not Force1_5 or Force2_6) and nxt and nxt == ARSID and self.ARSSpeedLimit > nxt)
end
--[[ function ENT:GetRS()
	if not self.TwoToSix or not self.ARSSpeedLimit then return false end
	--if self.ARSSpeedLimit == 1 or self.ARSSpeedLimit == 2 then return false end
	if self.ARSSpeedLimit <= 2 then return false end
	return self.OverrideTrackOccupied  or self.ARSSpeedLimit == 0 or (not self.ARSNextSpeedLimit or self.ARSNextSpeedLimit == 1) or self.ARSSpeedLimit <= self.ARSNextSpeedLimit
end--]]

function ENT:GetRS()
	if self.OverrideTrackOccupied or not self.TwoToSix or not self.ARSSpeedLimit then return false end
	--if self.ARSSpeedLimit == 1 or self.ARSSpeedLimit == 2 then return false end
	if self.ARSSpeedLimit ~= 0 and self.ARSSpeedLimit== 2 then return false end
	if self.ControllerLogic and self.ControllerLogicOverride325Hz then return self.Override325Hz end
	return (self.ARSSpeedLimit > 4 or self.ARSSpeedLimit == 4 and self.Approve0) and (not self.ARSNextSpeedLimit or self.ARSNextSpeedLimit >= self.ARSSpeedLimit)
end

function ENT:Get325HzAproove0()
	if self.OverrideTrackOccupied or not self.ARSSpeedLimit then return false end
	return self.ARSSpeedLimit == 0 and self.Approve0
end

function ENT:GetMaxARS()
	local ARSCodes = self.Routes[1].ARSCodes
	if not self.Routes[1] or not ARSCodes then return 1 end
	return tonumber(ARSCodes[#ARSCodes]) or 1
end
function ENT:GetMaxARSNext()
	local Routes = self.NextSignalLink and self.NextSignalLink.Routes or self.Routes
	local ARSCodes = Routes[1] and Routes[1].ARSCodes
	local code = tonumber(ARSCodes[#ARSCodes]) or 1
	local This = self:GetMaxARS()
	if not ARSCodes then return This end
	if code > This then return This end
	--if not ARSCodes then return 1 end
	return tonumber(ARSCodes[#ARSCodes]) or 1
end

function ENT:CheckOccupation()
	--print(self.FoundedAll)
	--if not self.FoundedAll then return end
	if not self.Close and not self.KGU then --not self.OverrideTrackOccupied and
		if self.Node and  self.TrackPosition then
			self.Occupied,self.OccupiedBy,self.OccupiedByNow = Metrostroi.IsTrackOccupied(self.Node, self.TrackPosition.x,self.TrackPosition.forward,self.ARSOnly and "ars" or "light", self)
		end
		if self.Routes[self.Route] and self.Routes[self.Route].Manual then
			self.Occupied = self.Occupied or not self.Routes[self.Route].IsOpened
		end
		if self.OccupiedByNowOld ~= self.OccupiedByNow then
			self.InvationSignal = false
			self.AODisabled = false
			self.OccupiedByNowOld = self.OccupiedByNow
		end
	else
		self.NextSignalLink = nil
		self.Occupied = self.Close or self.KGU --self.OverrideTrackOccupied or
	end
end
function ENT:ARSLogic(tim)
	--print(self.FoundedAll)
	--if not self.FoundedAll then return end
	if not self.Routes or not self.NextSignals then return end
	-- Check track occuping
	if not self.Routes[self.Route or 1].Repeater  then
		self:CheckOccupation()
		if self.Occupied then
			if self.Routes[self.Route or 1].Manual then self.Routes[self.Route or 1].IsOpened = false end
		end
		if self.Occupied or not self.NextSignalLink or not self.NextSignalLink.FreeBS then
			self.FreeBS = 0
		else
			self.FreeBS = math.min(30,self.NextSignalLink.FreeBS + 1) -- old 10 freebs - костыль
		end
		if self.FreeBS - (self.OldBSState or self.FreeBS) > 1 then
			local Free = self.FreeBS
			timer.Simple(tim+0.1,function()
				if not IsValid(self) then return end
				if self.NextSignalLink and self.NextSignalLink.FreeBS + 1 - self.OldBSState > 1 then
					self.FreeBS = Free
					self.OldBSState = Free
				end
			end)
			self.FreeBS = self.OldBSState
		end
		self.OldBSState = self.FreeBS
		if self.FreeBS == 1 then
			self.OccupiedBy = self
		elseif self.FreeBS > 1 then
			self.AutostopEnt = nil
		end
		if self.OccupiedByNow ~= self.AutostopEnt and self.AutostopEnt ~= self.CurrentAutostopEnt then
			self.AutostopEnt = nil
		end
	end
	if self.OldRoute ~= self.Route then
		self.InvationSignal = false
		self.AODisabled = false
		self.OldRoute = self.Route
	end
	--Removing NSL
	self.NextSignalLink = nil
	--Set the first route, if no switches in route or no switches
	--or not self.Switches
	if #self.Routes == 1 and (self.Routes[1].Switches == "" or not self.Routes[1].Switches) then
		self.NextSignalLink = self.NextSignals[self.Routes[1].NextSignal]
		self.Route = 1
	else
		local route
		--Finding right route
		for i = 1,#self.Routes do

			--If all switches right - get this route!
			if self.SwitchesFunction[i] and self.SwitchesFunction[i]() and (not self.Routes[i].Manual and not self.Routes[i].Emer or self.Routes[i].IsOpened) then
				--if self.Route ~= i then
				route = i
					--self.NextSignalLink = nil
				--end
			elseif not self.SwitchesFunction[i] and (not self.Routes[i].Manual and not self.Routes[i].Emer or self.Routes[i].IsOpened) then
				route = i
				--self.NextSignalLink = nil
			end
		end
		if self.Route ~= route and (not self.Routes[route] or not self.Routes[route].Emer) then
			self.Route = route
			self.NextSignalLink = false
		else
			if self.Route ~= route then self.Route = route end
			self.NextSignalLink = self.Routes[route] and self.NextSignals[self.Routes[route].NextSignal]
		end
	end
	if self.NextSignalLink == nil then
		if self.Occupied then
			self.NextSignalLink = self
			self.FreeBS = 0
			--self.Route = 1
		end
	end
	if self.Routes[self.Route] then
		if self.Routes[self.Route or 1].Repeater then
			self.RealName = IsValid(self.NextSignalLink) and self.NextSignalLink.RealName or self.Name
		else
			self.RealName = self.Name
		end
		if self.Routes[self.Route or 1].Repeater then
			self.RealName = IsValid(self.NextSignalLink) and self.NextSignalLink.Name or self.Name
			self.ARSSpeedLimit = IsValid(self.NextSignalLink) and self.NextSignalLink.ARSSpeedLimit or 1
			self.ARSNextSpeedLimit = IsValid(self.NextSignalLink) and self.NextSignalLink.ARSNextSpeedLimit or 1
			self.FreeBS = IsValid(self.NextSignalLink) and self.NextSignalLink.FreeBS or 0
		elseif self.Routes[self.Route].ARSCodes then
			local ARSCodes = self.Routes[self.Route].ARSCodes
			self.ARSNextSpeedLimit = IsValid(self.NextSignalLink) and self.NextSignalLink.ARSSpeedLimit or tonumber(ARSCodes[1])
			self.ARSSpeedLimit = tonumber(ARSCodes[math.min(#ARSCodes, self.FreeBS+1)]) or 0
			if self.AODisabled and self.ARSSpeedLimit ~= 2 then self.AODisabled = false end
			if (self.InvationSignal or self.AODisabled) and self.ARSSpeedLimit == 2 then self.ARSSpeedLimit = 1 end
		end
	end
	if self.NextSignalLink ~= false and (self.Occupied or not self.NextSignalLink or not self.NextSignalLink.FreeBS) then
		if self.Routes[self.Route or 1].Manual then self.Routes[self.Route or 1].IsOpened = false end
	end
end

function ENT:Think()
	if self.PostInitalized then return end
	--DEBUG
	if Metrostroi.SignalDebugCV:GetBool() then
		self:SetNW2Bool("Debug",true)
		local next = self.NextSignalLink
		local pos = self.TrackPosition
		local prev = self.PrevSig
		if next then
			next.PrevSig = self
			local nextpos = self.NextSignalLink.TrackPosition
			self:SetNW2String("NextSignalName",next.Name)
			if pos and nextpos then
				self:SetNW2Float("DistanceToNext",nextpos.x - pos.x)
			else
				self:SetNW2Float("DistanceToNext",0)
			end
			self:SetNW2Int("NextPosID",nextpos and nextpos.path and nextpos.path.id or 0)
			self:SetNW2Float("NextPos",nextpos and nextpos.x or 0)
		else
			self:SetNW2String("NextSignalName","N/A")
			self:SetNW2Float("DistanceToNext",0)
			self:SetNW2Float("NextPos",0)
			self:SetNW2Float("NextPosID",0)
		end
		if prev then
			local prevpos = prev.TrackPosition
			if pos and prevpos then
				self:SetNW2Float("DistanceToPrev",-prevpos.x + pos.x)
			else
				self:SetNW2Float("DistanceToPrev",0)
			end
			self:SetNW2String("PrevSignalName",self.PrevSig.Name)
			self:SetNW2Int("PrevPosID",prevpos and prevpos.path and prevpos.path.id or 0)
			self:SetNW2Float("PrevPos",prevpos and prevpos.x or 0)
		else
			self:SetNW2String("PrevSignalName","N/A")
			self:SetNW2Int("PrevPosID",0)
			self:SetNW2Float("PrevPos",0)
		end
		self:SetNW2Float("Pos",pos and pos.x or 0)
		self:SetNW2Int("PosID",pos and pos.path and pos.path.id or 0)

		self:SetNW2Bool("CurrentRoute",self.Route or -1)
		self:SetNW2Bool("Occupied",self.Occupied)
		self:SetNW2Bool("2/6",self.TwoToSix)
		self:SetNW2Int("FreeBS",self.FreeBS)
		self:SetNW2Bool("LinkedToController",self.Controllers ~= nil)
		self:SetNW2Int("ControllersNumber",self.Controllers ~= nil and #self.Controllers or -1)
		self:SetNW2Bool("BlockedByController",self.ControllerLogic)
		for i=0,8 do
			if i==3 or i==5 then continue end
			self:SetNW2Bool("CurrentARS"..i,self:GetARS(i))
		end
		self:SetNW2Bool("CurrentARS325",self:GetRS())
		self:SetNW2Bool("CurrentARS325_2",self:Get325HzAproove0())
	end
	if not self.ControllerLogic then
		if not self.Routes or #self.Routes == 0 then
			ErrorNoHalt(Format("Metrostroi:Signal %s don't have a routes!\n",self.Name))
			return
		end
		if not self.Routes[self.Route or 1] then
			ErrorNoHalt(Format("Metrostroi:Signal %s have a null %s route!!\n",self.Name,self.Route))
			return
		end

		self.PrevTime = self.PrevTime or 0
		if (CurTime() - self.PrevTime) > 1.0 then
			self.PrevTime = CurTime()+math.random(0.5,1.5)
			self:ARSLogic(self.PrevTime - CurTime())
		end
		self.RouteNumberOverrite = nil
		local number = ""
		if self.MU or self.ARSOnly or self.RouteNumberSetup and self.RouteNumberSetup ~= "" or self.RouteNumber and self.RouteNumber ~= "" then
			if self.NextSignalLink then
				if not self.NextSignalLink.Red and not self.Red then
					self.RouteNumberOverrite = self.NextSignalLink.RouteNumberOverrite ~= "" and self.NextSignalLink.RouteNumberOverrite or self.NextSignalLink.RouteNumber
				else
					self.RouteNumberOverrite = self.RouteNumber
				end
				if (not self.Red or self.InvationSignal) and self.Routes[self.Route or 1].EnRou then
					if self.NextSignalLink.RouteNumberOverrite then
						number = number..self.NextSignalLink.RouteNumberOverrite
					end
					if self.NextSignalLink.RouteNumber and not self.AutoEnabled then
						number = number..self.NextSignalLink.RouteNumber
					end
				end
				--print(self.Name,self.NextSignalLink.RouteNumberOverrite)
				self.RouteNumberOverrite = (self.RouteNumberOverrite or "")..number
			else
				self.RouteNumberOverrite = self.RouteNumber
			end
		end
		if self.InvationSignal and self.GoodInvationSignal == -1 then
			number = number.."W"
		end
		if self.KGU then number = number.."K" end
		if number then self:SetNW2String("Number",number) end

		if self.Occupied ~= self.OccupiedOld then
			hook.Run("Metrostroi.Signaling.ChangeRCState", self.Name, self.Occupied, self)
			self.OccupiedOld = self.Occupied
		end	

		if self.ARSOnly then
			if self.Sprites then
				for k,v in pairs(self.Sprites) do
					SafeRemoveEntity(v)
					self.Sprites[k] = nil
				end
				if self.ARSOnly and self.Sprites then
					self.Sprites = nil
				end
			end
			self:SetNW2String("Signal","")
			self.AutoEnabled = not self.ARSOnly
			return
		end

		self.AutoEnabled = false
		self.Red = nil
		if not self.Routes[self.Route or 1].Lights then return end
		local Route = self.Routes[self.Route or 1]
		local index = 1
		local offset = self.RenderOffset[self.SignalType] or Vector(0,0,0)
		self.Sig = ""
		self.Colors = ""
		for k,v in ipairs(self.Lenses) do
			if self.Routes[self.Route or 1].Repeater and IsValid(self.NextSignalLink) and (not self.Routes[self.Route or 1].Lights or self.Routes[self.Route or 1].Lights == "") then
				break
			end
			if v ~= "M" then
				--get the some models data
				local data = #v ~= 1 and self.TrafficLightModels[self.SignalType][#v-1] or self.TrafficLightModels[self.SignalType][self.Signal_IS]
				if not data then continue end
				for i = 1,#v do
					--Get the LightID and check, is this light must light up
					local LightID = IsValid(self.NextSignalLink) and math.min(#Route.LightsExploded,self.FreeBS+1) or 1
					local AverageState = Route.LightsExploded[LightID]:find(tostring(index)) or ((v[i] == "W" and self.InvationSignal and self.GoodInvationSignal == index) and 1 or 0)
					local MustBlink = (v[i] == "W" and self.InvationSignal and self.GoodInvationSignal == index) or (AverageState > 0 and Route.LightsExploded[LightID][AverageState+1] == "b") --Blinking, when next is "b" (or it's invasion signal')
					self.Sig = self.Sig..(AverageState > 0 and (MustBlink and 2 or 1) or 0)

					if AverageState > 0 then
						if self.GoodInvationSignal ~= index then self.Colors = self.Colors..(MustBlink and v[i]:lower() or v[i]:upper()) end
						if v[i] == "R" then
							self.AutoEnabled = not self.NonAutoStop
							self.Red = true
						end
					end
					index = index + 1
				end
			end
		end
	else
		local number = self.RouteNumberReplace or ""
		if self.ControllerLogicCheckOccupied then
			self.PrevTime = self.PrevTime or 0
			if (CurTime() - self.PrevTime) > 0.5 then
				self.PrevTime = CurTime() + math.random(0.5,1.5)
				if self.Node and self.TrackPosition then
					self.Occupied,self.OccupiedBy,self.OccupiedByNow = Metrostroi.IsTrackOccupied(self.Node, self.TrackPosition.x,self.TrackPosition.forward,self.ARSOnly and "ars" or "light", self)
				end
			end
			if self.Occupied ~= self.OccupiedOld then
				hook.Run("Metrostroi.Signaling.ChangeRCState", self.Name, self.Occupied, self)
				self.OccupiedOld = self.Occupied
			end
		
		end
		--[[
		if self.MU or self.ARSOnly or self.RouteNumberSetup and self.RouteNumberSetup ~= "" or self.RouteNumber and self.RouteNumber ~= "" then
			if self.NextSignalLink then
				if not self.NextSignalLink.AutoEnabled and not self.AutoEnabled then
					self.RouteNumberOverrite = self.NextSignalLink.RouteNumberOverrite ~= "" and self.NextSignalLink.RouteNumberOverrite or self.NextSignalLink.RouteNumber
				else
					self.RouteNumberOverrite = self.RouteNumber
				end
				if self.NextSignalLink.RouteNumberOverrite and not self.AutoEnabled and (self.Routes[self.Route or 1].EnRou or self.InvationSignal) then
					number = number..self.NextSignalLink.RouteNumberOverrite
				end
				if self.NextSignalLink.RouteNumber and (self.Routes[self.Route or 1].EnRou and not self.AutoEnabled or self.InvationSignal) then
					number = number..self.NextSignalLink.RouteNumber
				end
				--print(self.Name,self.NextSignalLink.RouteNumberOverrite)
				self.RouteNumberOverrite = (self.RouteNumberOverrite or "")..number
			else
				self.RouteNumberOverrite = self.RouteNumber
			end
		end]]
		if self.InvationSignal and self.GoodInvationSignal == -1 then
			number = number.."W"
		end
		if self.KGU then number = number.."K" end
		if number then self:SetNW2String("Number",number) end
		local index = 1
		self.Colors = ""
		for k,v in ipairs(self.Lenses) do
			if v ~= "M" then
				--get the some models data
				local data = #v ~= 1 and self.TrafficLightModels[self.SignalType][#v-1] or self.TrafficLightModels[self.SignalType][self.Signal_IS]
				if not data then continue end
				for i = 1,#v do
					if (self.Sig[index] == "1" or self.Sig[index] == "2") then self.Colors = self.Colors..v[i]:lower() end
					index = index + 1
				end
			end
		end
	end

	if self.Controllers then
		for k,v in pairs(self.Controllers) do
			if self.Sig ~= v.Sig then
				local Route = self.Routes[self.Route or 1]
				local LightID = IsValid(self.NextSignalLink) and math.min(#Route.LightsExploded,self.FreeBS+1) or 1
				local lights = Route.LightsExploded[LightID]
				v:TriggerOutput("LenseEnabled",self,Route.LightsExploded[LightID])
				v.Sig = self.Sig
			end
			if v.OldIS ~= self.InvationSignal then
				if self.InvationSignal then
					v:TriggerOutput("LenseEnabled",self,"I")
				else
					v:TriggerOutput("LenseDisabled",self,"I")
				end
				v.OldIS = self.InvationSignal
			end
		end
	end
	self:SetNW2String("Signal",self.Sig)
	if not self.AutostopPresent then self:SetNW2Bool("Autostop",self.AutoEnabled) end

	self:NextThink(CurTime() + 0.25)
	return true
end

--Net functions
--Send update, if parameters have been changed
function ENT:SendUpdate(ply)
	net.Start("metrostroi-signal")
		net.WriteEntity(self)
		net.WriteInt(self.SignalType or 0,3)
		net.WriteString(self.Name or "NOT LOADED")
		net.WriteString(self.ARSOnly and "ARSOnly" or self.LensesStr)
		net.WriteString(self.SignalType == 0 and self.RouteNumberSetup or "")
		net.WriteBool(self.Left)
		net.WriteBool(self.Double)
		net.WriteBool(self.DoubleL)
		net.WriteBool(not self.NonAutoStop)
	if ply then net.Send(ply) else net.Broadcast() end
end

--On receive update request, we send update
net.Receive("metrostroi-signal", function(_, ply)
	local ent = net.ReadEntity()
	if not IsValid(ent) or not ent.SendUpdate then return end
	ent:SendUpdate(ply)
end)

Metrostroi.OptimisationPatch()

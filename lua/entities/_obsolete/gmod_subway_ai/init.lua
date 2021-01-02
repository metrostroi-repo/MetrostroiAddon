AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--------------------------------------------------------------------------------
function ENT:Initialize()
	-- Defined train information
	self.SubwayTrain = {
		Type = "AI",
		Name = "",
	}
	if not self.TrainType then self.TrainType = "81-717" end
	-- Set model and initialize
	self.NoPhysics = true
	if self.TrainType == "81-717" then self:SetModel("models/metrostroi/81/81-7036.mdl") end
	if self.TrainType == "81-714" then self:SetModel("models/metrostroi/81/81-7037.mdl") end
	self.BaseClass.Initialize(self)

	-- Create bogeys
	self.FrontBogey = self:CreateBogey(Vector( 325-20,0,-75),Angle(0,180,0),true)
	self.RearBogey  = self:CreateBogey(Vector(-325-10,0,-75),Angle(0,0,0),false)

	-- Seats
	if self.TrainType == "81-717" then 
		self.DriverSeat = self:CreateSeat("driver",Vector(410,-2,-23))
		--self.InstructorsSeat = self:CreateSeat("instructor",Vector(410,35,-28))
		--self.ExtraSeat = self:CreateSeat("instructor",Vector(410,-35,-28))
	end
	--[[
	for i=1,1 do --17
		local pos = Vector(280-(i-1)*30-math.floor((i-1)/5)*80,-47,-32)
		local p1 = self:CreateSeat("passenger",pos,Angle(0,90,0))
		pos.y = -pos.y
		local p2 = self:CreateSeat("passenger",pos,Angle(0,270,0))
	end]]

	-- Setup door positions
	self.LeftDoorPositions = {}
	self.RightDoorPositions = {}
	for i=0,3 do
		table.insert(self.LeftDoorPositions,Vector(353.0 - 35*0.5 - 231*i,65,-1.8))
		table.insert(self.RightDoorPositions,Vector(353.0 - 35*0.5 - 231*i,-65,-1.8))
	end
	
	-- Find SOME sort of route
	local route
	for k,v in pairs(Metrostroi.AIConfiguration) do
		if not route then route = k end
	end

	-- Initial setup
	if not self.Route then self.Route = route end
	if (not self.PathID) and (route) and Metrostroi.AIConfiguration[route] then
		self.PathID = Metrostroi.AIConfiguration[route].Path
	end
	self.Position = self.Position or 100
	self.Velocity = 0
	self.RheostatPosition = 0

	-- Lights
	if self.TrainType == "81-717" then 
		self.Lights = {
			-- Head
			[1] = { "headlight",		Vector(465,0,-20), Angle(0,0,0), Color(176,161,132), fov = 100 },
			[2] = { "glow",				Vector(460, 51,-23), Angle(0,0,0), Color(255,255,255), brightness = 2 },
			[3] = { "glow",				Vector(460,-51,-23), Angle(0,0,0), Color(255,255,255), brightness = 2 },
			[4] = { "glow",				Vector(460,-8, 55), Angle(0,0,0), Color(255,255,255), brightness = 0.3 },
			[5] = { "glow",				Vector(460,-8, 55), Angle(0,0,0), Color(255,255,255), brightness = 0.3 },
			[6] = { "glow",				Vector(460, 2, 55), Angle(0,0,0), Color(255,255,255), brightness = 0.3 },
			[7] = { "glow",				Vector(460, 2, 55), Angle(0,0,0), Color(255,255,255), brightness = 0.3 },
				
			-- Reverse
			[8] = { "light",			Vector(458,-45, 55), Angle(0,0,0), Color(255,0,0),     brightness = 10, scale = 1.0 },
			[9] = { "light",			Vector(458, 45, 55), Angle(0,0,0), Color(255,0,0),     brightness = 10, scale = 1.0 },
				
			-- Cabin
			[10] = { "dynamiclight",	Vector( 420, 0, 35), Angle(0,0,0), Color(255,255,255), brightness = 0.1, distance = 550 },
				
			-- Interior
			[12] = { "dynamiclight",	Vector(   0, 0, 5), Angle(0,0,0), Color(255,255,255), brightness = 3, distance = 400 },
				
			-- Side lights
			[14] = { "light",			Vector(-50, 68, 54), Angle(0,0,0), Color(255,0,0), brightness = 0.5, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
			[15] = { "light",			Vector(4,   68, 54), Angle(0,0,0), Color(150,255,255), brightness = 0.6, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
			[16] = { "light",			Vector(1,   68, 54), Angle(0,0,0), Color(0,255,0), brightness = 0.5, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
			[17] = { "light",			Vector(-2,  68, 54), Angle(0,0,0), Color(255,255,0), brightness = 0.5, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
				
			[18] = { "light",			Vector(-50, -69, 54), Angle(0,0,0), Color(255,0,0), brightness = 0.5, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
			[19] = { "light",			Vector(5,   -69, 54), Angle(0,0,0), Color(150,255,255), brightness = 0.6, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
			[20] = { "light",			Vector(2,   -69, 54), Angle(0,0,0), Color(0,255,0), brightness = 0.5, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
			[21] = { "light",			Vector(-1,  -69, 54), Angle(0,0,0), Color(255,255,0), brightness = 0.5, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		}
	end
	if self.TrainType == "81-714" then
		self.Lights = {
			-- Interior
			[12] = { "dynamiclight",	Vector(   0, 0, 5), Angle(0,0,0), Color(255,255,255), brightness = 3, distance = 400 },
				
			-- Side lights
			[14] = { "light",			Vector(-50, 68, 54), Angle(0,0,0), Color(255,0,0), brightness = 0.5, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
			[15] = { "light",			Vector(4,   68, 54), Angle(0,0,0), Color(150,255,255), brightness = 0.6, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
			[16] = { "light",			Vector(1,   68, 54), Angle(0,0,0), Color(0,255,0), brightness = 0.5, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
			[17] = { "light",			Vector(-2,  68, 54), Angle(0,0,0), Color(255,255,0), brightness = 0.5, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
				
			[18] = { "light",			Vector(-50, -69, 54), Angle(0,0,0), Color(255,0,0), brightness = 0.5, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
			[19] = { "light",			Vector(5,   -69, 54), Angle(0,0,0), Color(150,255,255), brightness = 0.6, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
			[20] = { "light",			Vector(2,   -69, 54), Angle(0,0,0), Color(0,255,0), brightness = 0.5, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
			[21] = { "light",			Vector(-1,  -69, 54), Angle(0,0,0), Color(255,255,0), brightness = 0.5, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		}	
	end

	-- Prop-protection related
	if CPPI and IsValid(self.Owner) then
		self:CPPISetOwner(self.Owner)
	end
	-- Spawn a dummy consist
	if (self.TrainType == "81-717") and (not self.TrainHead) then
		for i=2,5 do
			local ent = ents.Create("gmod_subway_ai")
			if i == 5 
			then ent.TrainType = "81-717"
			else ent.TrainType = "81-714"
			end
			ent.TrainIndex = i
			ent.TrainHead = self
			ent.Owner = self.Owner
			ent:Spawn()
			table.insert(self.TrainEntities,ent)
		end
	end
	--self:Remove()
	-- Type
	self:SetNW2String("TrainType",self.TrainType)
end

--[[concommand.Add("metrostroi_ai_spawn", function(ply, _, args)
	if (ply:IsValid()) and (not ply:IsAdmin()) then return end

	local pathid = tonumber(args[2]) or 1
	local trainCounter = tonumber(args[1]) or 1
	local prevEnt
	timer.Create("metrostroi-ai-spawntimer-"..pathid,1.0,0,function()
		if prevEnt then
			if (pathid == 1) and (prevEnt.Position < 260) then
				return
			end
			if (pathid == 2) and (prevEnt.Position < 960) then
				return
			end
		end
		if trainCounter < 1 then return end

		local ent = ents.Create("gmod_subway_ai")
		ent.Position = 150
		ent.PathID = pathid
		ent:Spawn()
		prevEnt = ent
		trainCounter = trainCounter - 1
		print("Spawning AI trains (path "..pathid.."), left: "..trainCounter)
	end)
end)

concommand.Add("metrostroi_ai_clear", function(ply, _, args)
	if (ply:IsValid()) and (not ply:IsAdmin()) then return end
	for k,v in pairs(ents.FindByClass("gmod_subway_ai")) do
		SafeRemoveEntity(v)
		if args[1] then print("Removed one") return end
	end
	--timer.Create("metrostroi-ai-spawntimer",1.0,0,function()end)
end)]]--

concommand.Add("metrostroi_ai_info", function(ply, _, args)
	if (ply:IsValid()) and (not ply:IsAdmin()) then return end
	for k,v in pairs(ents.FindByClass("gmod_subway_ai")) do
		if not v.TrainHead then
			print(Format("Train to [%03d][%02d] (%.0f m %.02f km/h, left %0.3f m)",
				v.TargetStation or 0,v.TargetPlatform or 0,v.Position,v.Speed,
				(v.PlatformEdgeX or 0) - v.Position))
		end
	end
end)




--------------------------------------------------------------------------------
-- Train driving AI
--------------------------------------------------------------------------------
function ENT:DoAI(dT)
	-- Get a schedule
	if self.Schedule and (#self.Schedule == 0) then
		self.Schedule = nil
	end
	if (not self.Schedule) and (not self.NoStation) then
		self.Schedule = Metrostroi.GenerateSchedule(self.Route)
		self.StopTimer = 10
	end
	
	-- See if must move to next station
	if self.Schedule then
		if ((Metrostroi.ServerTime()+10000 > (self.Schedule[1][3]*60)) and (self.StopTimer < 0)) or
		   (self.StopTimer < -200) then
			table.remove(self.Schedule,1)
			self.StopTimer = 10
		end
	end

	-- Get current target station info
	local platformEdgeX
	if self.Schedule and self.Schedule[1] then
		local targetStation = self.Schedule[1][1]
		local targetPlatform = self.Schedule[1][2]
		local stationData = Metrostroi.Stations[targetStation]
		local platformData
		if stationData then platformData = stationData[targetPlatform] end
		if platformData then 
			platformEdgeX = math.max(platformData.x_end,platformData.x_start)
		end
		if platformData and platformData.node_end then
			if platformData.node_end.path.id ~= self.PathID then
				--print("WRONG PATH")
				platformEdgeX = nil
			end
		end
		self.TargetStation = targetStation
		self.TargetPlatform = targetPlatform
	else
		self.NoStation = true
	end
	self.PlatformEdgeX = platformEdgeX

	if platformEdgeX then
		if self.Position > platformEdgeX then
			--print("Overrun!",self.Position,platformEdgeX)
			table.remove(self.Schedule,1)
			self.StopTimer = 10
		end
	end
	
	-- Get current information on driving
	local speedLimit = self.ALS_ARS.SpeedLimit
	local nextLimit = self.ALS_ARS.NextLimit
	local targetSpeed = nextLimit
	--print()
	if nextLimit == 0 then targetSpeed = speedLimit end
	
	-- Move at slow speed to next red light or blocked section
	if targetSpeed == 0 then targetSpeed = 20 end
	-- If there is a red light ahead, stop once in its range
	if self.RedLightDistance and (self.RedLightDistance < 20) then
		targetSpeed = 0
	end
	
	-- Stop at station gradually
	if platformEdgeX and (platformEdgeX > self.Position)  then
		local dX = platformEdgeX - self.Position
		if dX < 100 then
			targetSpeed = math.min(targetSpeed,55) * (math.max(0.0,math.min(1.0,(dX-12)/90))^0.5)
			if dX > 18 then targetSpeed = math.max(targetSpeed,20) end
			if self.Speed < 1 then
				self.StopTimer = self.StopTimer - dT
			end
		end
	end

	-- Wait for schedule start
	if (self.PathID == 1) and (self.Position < 250) and
		(self.Schedule) and (self.Schedule[1]) then
		local dT = self.Schedule[1][3]*60 - Metrostroi.ServerTime()
		--if dT > 90 then targetSpeed = 0 end
	end
	--targetSpeed = 0
	-- Reached target speed, stop accelerating
	if self.Speed > (targetSpeed-2) then
		self.Accelerating = false
	end
	-- Speed is below required, try to accelerate
	if self.Speed < (targetSpeed-10) then
		self.Accelerating = true
	end
	-- Exceeding speed limit, apply brakes
	if self.Speed > targetSpeed then
		self.Braking = true
	end
	-- Braked enough, stop braking
	if (self.Speed < (targetSpeed-5)) and (self.Braking) then
		self.Braking = false
	end
	
	-- ARS system logic
	if false and self.ALS_ARS.LVD then
		self.Braking = true
		self.Accelerating = false
	end
	--print(self.ALS_ARS.LVD)
	if self.ALS_ARS.LVD
	then self.ALS_ARS.AttentionPedal = true
	else self.ALS_ARS.AttentionPedal = false
	end
	if speedLimit == 0 then self.ALS_ARS.AttentionPedal = true end
	
	-- Apply pneumatic brakes if overspeeding much or stopped
	self.Pneumo = false
	if (self.Speed < 7) and (not self.Accelerating) then
		self.Pneumo = true
	end
	if (self.Speed > (targetSpeed+5)) then
		--self.Pneumo = true
	end
	
	-- Save for statistics
	self.TargetSpeed = targetSpeed
	--if self.RedLightDistance and (self.RedLightDistance < 30) then self.Pneumo = true end
end



--------------------------------------------------------------------------------
-- Train physics
--------------------------------------------------------------------------------
function ENT:DoPhysics(dT)
	-- Slopes code
	local slopeAngle = self:GetAngles().p
	if slopeAngle > 180 then slopeAngle = slopeAngle-360 end
	local slopeFactor = math.min(8.0,math.max(-8.0,slopeAngle))/8.0

	-- Motor code
	local motorPower = 0
	if self.Accelerating then	motorPower = 1.0 end
	if self.Braking then		motorPower = -1.0 end
	
	local motorForce = 0
	if motorPower > 0 then motorForce = 1.25*motorPower end
	if motorPower < 0 then motorForce = -1.3*math.abs(motorPower) * math.max(-1.0,math.min(1.0,0.25*self.Velocity)) end

	-- Brake code
	local brakeForce = 0
	if self.Pneumo then
		brakeForce = -1.4*math.max(-1.0,math.min(1.0,3.0*self.Velocity))
		slopeFactor = slopeFactor*math.max(-1.0,math.min(1.0,3.0*self.Velocity))
	end
	self.PneumoForce = brakeForce

	-- Integrate position and velocity
	self.Acceleration = 0
		+motorForce
		+brakeForce
		-self.Velocity*0.0045
		+slopeFactor*1.52
	self.Velocity = self.Velocity + dT*self.Acceleration
	self.Position = self.Position + dT*self.Velocity
	--print(Format("%.2f/%.2f km/h  %.0f m  A-%s B-%s P-%s",
		--self.Speed,self.TargetSpeed,self.Position,
		--tostring(self.Accelerating),tostring(self.Braking),tostring(self.Pneumo)))

	-- Info
	self.MotorPower = motorPower
end

function ENT:Think()
	-- Basic think loop
	self.PrevTime = self.PrevTime or CurTime()
	self.DeltaTime = (CurTime() - self.PrevTime)
	self.PrevTime = CurTime()
	
	--self:RecvPackedData()
	self:NextThink(CurTime()+0.10)
	
	-- Simulate equipment specific to trains
	local dT = self.DeltaTime
	if (self.TrainType == "81-717") and (not self.TrainHead) then
		self.ALS_ARS:Think(dT,1)
	end

	-- Select path
	if (not self.PathID) or (not self.Route) then return true end
	local path = Metrostroi.Paths[self.PathID]
	local config = Metrostroi.AIConfiguration[self.Route]
	if self.Position > config.EndPosition then		
		self.Route = config.NextRoute
		config = Metrostroi.AIConfiguration[self.Route]
		self.PathID = config.Path
		self.Position = config.SpawnPosition
		self.Velocity = 0
		
		self.Schedule = nil
		self.NoStation = false
	end
	--self.Velocity = 0

	----------------------------------------------------------------------------
	-- If needed, update train physics and AI
	if not self.TrainHead then
		self:DoAI(dT)
		self:DoPhysics(dT)
	else
		if not IsValid(self.TrainHead) then
			SafeRemoveEntity(self)
			return
		end

		self.Route = self.TrainHead.Route
		self.PathID = self.TrainHead.PathID
		self.Position = self.TrainHead.Position - 18.6*(self.TrainIndex-1)
		self.Velocity = self.TrainHead.Velocity
		self.MotorPower = self.TrainHead.MotorPower
		self.PneumoForce = self.TrainHead.PneumoForce
	end


	----------------------------------------------------------------------------	
	-- Lighting
	if self.TrainType == "81-717" then
		self:SetLightPower(1, self.TrainHead == nil)
		self:SetLightPower(2, self.TrainHead == nil)
		self:SetLightPower(3, self.TrainHead == nil)
		self:SetLightPower(4, self.TrainHead == nil)
		self:SetLightPower(5, self.TrainHead == nil)
		self:SetLightPower(6, self.TrainHead == nil)
		self:SetLightPower(7, self.TrainHead == nil)
		self:SetLightPower(8, self.TrainHead ~= nil)
		self:SetLightPower(9, self.TrainHead ~= nil)
		self:SetLightPower(10, (CurTime() % 60) > 0.1)
		self:SetLightPower(12, (CurTime() % 60) > 0.1)
	end
	if self.TrainType == "81-714" then
		self:SetLightPower(12, (CurTime() % 60) > 0.1)
	end
	-- Pneumatic brakes
	self.PneumaticPressure = self.PneumaticPressure or 0
	self.PneumaticPressure_dPdT = self.PneumaticPressure_dPdT or 0
	if self.Pneumo 
	then self.PneumaticPressure_dPdT = 0.65*(1.5 - self.PneumaticPressure)
	else self.PneumaticPressure_dPdT = 0.65*(0.0 - self.PneumaticPressure)
	end
	self.PneumaticPressure = self.PneumaticPressure + self.PneumaticPressure_dPdT*dT

	-- Minor state
	if self.TrainHead then
		self.LeftDoorsOpen = self.TrainHead.LeftDoorsOpen
		self.RightDoorsOpen = self.TrainHead.RightDoorsOpen
	else
		self.LeftDoorsOpen = self.StopTimer and (self.StopTimer < 9)
		self.RightDoorsOpen = self.StopTimer and (self.StopTimer < 9)
	end
	if self.LeftDoorsOpen ~= self.PrevLeftDoorsOpen then
		self.PrevLeftDoorsOpen = self.LeftDoorsOpen
		if self.LeftDoorsOpen then
			self:PlayOnce("door_open1")
		else
			self:PlayOnce("door_close1")
		end
	end
	if self.RightDoorsOpen ~= self.PrevRightDoorsOpen then
		self.PrevRightDoorsOpen = self.RightDoorsOpen
		if self.RightDoorsOpen then
			self:PlayOnce("door_open1")
		else
			self:PlayOnce("door_close1")
		end
	end
	self:SetPackedBool(21,self.LeftDoorsOpen)
	self:SetPackedBool(22,self.LeftDoorsOpen)
	self:SetPackedBool(23,self.LeftDoorsOpen)
	self:SetPackedBool(24,self.LeftDoorsOpen)
	self:SetPackedBool(25,self.RightDoorsOpen)
	self:SetPackedBool(26,self.RightDoorsOpen)
	self:SetPackedBool(27,self.RightDoorsOpen)
	self:SetPackedBool(28,self.RightDoorsOpen)
	self:SetPackedBool(52,1)
	self:SetPackedBool(39,self.ALS_ARS.LVD and (not self.TrainHead))
	
	-- Update state of all objects and sounds
	self.Speed = math.abs(self.Velocity/0.277778)
	self.FrontBogey.Speed = self.Speed
	self.RearBogey.Speed = self.Speed
	self.FrontBogey.MotorPower = self.MotorPower
	self.RearBogey.MotorPower = self.MotorPower
	self.FrontBogey.BrakeCylinderPressure_dPdT = -self.PneumaticPressure_dPdT
	self.RearBogey.BrakeCylinderPressure_dPdT = -self.PneumaticPressure_dPdT
	self.FrontBogey.BrakeSqueal = math.min(1,(3*math.abs(self.PneumoForce or 0))^1)
	self.RearBogey.BrakeSqueal = math.min(1,(3*math.abs(self.PneumoForce or 0))^1)
	

	----------------------------------------------------------------------------
	-- Update train position
	local vec,dir,node = Metrostroi.GetTrackPosition(path,self.Position)
	if vec then
		--local vec1,dir1 = Metrostroi.GetTrackPosition(path,self.Position+0)
		local vec2,dir2 = Metrostroi.GetTrackPosition(path,self.Position-5)
		if dir2 then
			dir = dir2
		end

		if self.TrainHead then dir = -dir end
		--[[local trace = {
			start = vec,
			endpos = vec + Vector(0,0,-384),
			mask = MASK_NPCWORLDSTATIC
		}
		local result = util.TraceLine(trace)]]--
		local rollAngle = Angle(0,0,0)--Angle(0,0,(180.0/math.pi)*math.acos(result.HitNormal.z))

		self:SetPos(vec)
		self:SetAngles(dir:Angle() + rollAngle)
	end

	-- Update information about restrictions in driving
	self.RestrictionTimeout = self.RestrictionTimeout or 0
	if (CurTime() - self.RestrictionTimeout) > 0.50 then
		self.RestrictionTimeout = CurTime()
		if node and (not self.TrainHead) then
			self.RedLightDistance = nil
	
			-- Check ARS signal/traffic light being red
			local nextARS = Metrostroi.GetARSJoint(node,self.Position,true)
			if nextARS and nextARS.AutoEnabled then
				local arsOffset = (nextARS.ARSOffset or self.Position)
				local dX = math.abs(arsOffset - self.Position)
				if (not self.PlatformEdgeX) or (arsOffset < self.PlatformEdgeX) then
					self.RedLightDistance = dX
				end
			end
	
			-- Find other trains on the same line
			if not self.RedLightDistance then
				for k,v in pairs(ents.FindByClass("gmod_subway_ai")) do
					if (v.PathID == self.PathID) and (v ~= self) and (v.Position > self.Position) then
						self.RedLightDistance = math.abs(v.Position - self.Position)
					end 
				end
			end
		end
	end

--	self:SendPackedData()
	return true
end
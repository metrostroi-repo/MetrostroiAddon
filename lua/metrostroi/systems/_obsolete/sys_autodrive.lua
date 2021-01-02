--------------------------------------------------------------------------------
-- Автоведение
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("Autodrive")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.MU = -0.25
	self.Horlifts = {
		[114] = true,
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

TRAIN_SYSTEM.Corrections = {
		[0] = {
		},
		[1] = {
			[108] = -3.23,
			[109] = -2.79,
			[110] = -3.09,
			[111] = -3.17,
			[112] = -3.17,
			[113] = -3.18,
			[114] = -3.21,
			[115] = -3.21,
			[116] = -3.22,
			[117] = -3.21,
			[118] = -3.02,
			[119] = -3.20,
			[121] = -3.17,
			[122] = -4.10,
			[123] = -1.98,
		},
		[2] = {
			[123] = -1.98,
			[122] = -4.10,--
			[121] = -3.17,
			[119] = -3.20,
			[118] = -3.02,
			[117] = -3.21,
			[116] = -3.22,
			[115] = -3.21,
			[114] = -3.21,
			[113] = -3.18,
			[112] = -3.17,
			[111] = -3.17,
			[110] = -3.09,
			[109] = -2.79,
			[108] = -3.23,
		}
	}
function TRAIN_SYSTEM:GetStationRK(dX,horlift)
	-- Calculate RK position based on distance and autodrive profile
	local TargetBrakeRKPosition = 1
	local speed = self.Train.ALS_ARS.Speed
	if dX < 160   then TargetBrakeRKPosition = speed > 55 and 3 or 1 end
	if dX < 86.25 then TargetBrakeRKPosition = 6 end
	if dX < 53.21 + (horlift and 10 or 0) then TargetBrakeRKPosition = 10 end
	if dX < 20.13 then TargetBrakeRKPosition = 15 end
	if dX < 8 then
		TargetBrakeRKPosition = 15
		--if dX < 10 and speed > 15 then TargetBrakeRKPosition = 18
		--else
		--else
		if dX < 6 then TargetBrakeRKPosition = 16 end
		--if dX < 2.64 then TargetBrakeRKPosition = 18 end
		if horlift and dX < 4 and speed > 6 then TragetBrakeRKPosition = 17 end
		if dX < 3 then TargetBrakeRKPosition = 18 end
		--if horlift and dX < 1.5 then TargetBrakeRKPosition = 19 end
		--if VZ then TargetBrakeRKPosition = 18 end
	end
	--if dX < 15 then TargetBrakeRKPosition = 16 end
	return TargetBrakeRKPosition
end

function TRAIN_SYSTEM:Autodrive(StationBraking)
	local Train= self.Train
	-- Calculate distance to station
	local dX = self.Train.UPO.Distance
	--local speedLimit = (Train.ALS_ARS.Signal0 or Train.ALS_ARS.RealNoFreq) and 0 or Train.ALS_ARS.Signal40 and 40 or Train.ALS_ARS.Signal60 and 60 or Train.ALS_ARS.Signal70 and 70 or Train.ALS_ARS.Signal80 and 80 or 0
	local speedLimit = 0--(self.Train.ALS_ARS.Signal0 or self.Train.ALS_ARS.RealNoFreq) and 0 or self.Train.ALS_ARS.Signal40 and 40 or self.Train.ALS_ARS.Signal60 and 60 or self.Train.ALS_ARS.Signal70 and 70 or self.Train.ALS_ARS.Signal80 and 80 or 0
	if self.Train.ALS_ARS.AVSpeedLimit and self.Train.ALS_ARS.AVSpeedLimit > 20 then
		speedLimit = self.Train.ALS_ARS.AVSpeedLimit
	end
	local OnStation = dX < (160+35*self.MU - (speedLimit == 40 and 30 or 0)) and not self.StartMoving and Metrostroi.AnnouncerData[self.Train.UPO.Station]and Metrostroi.AnnouncerData[self.Train.UPO.Station][1]
	if StationBraking and (dX >= (160+35*self.MU - (speedLimit == 40 and 30 or 0)) or not OnStation) then self.Train.UPO.StationAutodrive = false return end
	-- Target and real RK position (0 if not braking)
	local TargetBrakeRKPosition = 0

	local RKPosition = math.floor(Train.RheostatController.Position+0.5)

	-- Calculate next speed limit

	-- Get angle
	local Slope = Train:GetAngles().pitch

	-- Check speed constraints
	if Train.ALS_ARS.Speed > (speedLimit - 6) then self.NoAcceleration = true end
	if Train.ALS_ARS.Speed < (speedLimit - 10) then self.NoAcceleration = false end

	local Brake = false
	local Accelerate = false

	local threshold = 1.0 + (Slope > 1 and 1 or 0)

	-- Slow down on slopes
	if Train.ALS_ARS.Speed > speedLimit - 5 - (self.NoAcceleration and 4 or 7) then
		if Slope > 1 then
			if speedLimit == 40 then
				TargetBrakeRKPosition = 7
			elseif speedLimit > 40  then
				TargetBrakeRKPosition = 1
				Brake = (Train.ALS_ARS.Speed > speedLimit - 4)
			end
		end
	end

	-- Slow down if overspeeding soon
	if (Train.ALS_ARS.Speed > (speedLimit - threshold)) then
		TargetBrakeRKPosition = 18
	end

	-- How smooth braking should be (higher self.MU = more gentle braking)
	-- Full stop command
	if Train.ALS_ARS.SpeedLimit < 30 then TargetBrakeRKPosition = 18 Brake = true end
	-- Calculate RK position based on distance and autodrive profile
	if OnStation then
		TargetBrakeRKPosition = self:GetStationRK(dX)
	else
		if dX > (160+35*self.MU - (speedLimit == 40 and 30 or 0)) then self.StartMoving = nil end
	end

	-- Generate commands
	local ElectricBrakeActive = FullStop or TargetBrakeRKPosition > 0
	local AcceleratingActive = not ElectricBrakeActive and not self.NoAcceleration and Slope <  1

	-- Generate brake rheostat rotation
	local RheostatBrakeRotating = Brake or RKPosition < TargetBrakeRKPosition
	-- Generate accel rheostat rotation
	local PP = math.floor(Train.PositionSwitch.Position + 0.5) == 2

	local AmpNorm = true --Train.Electric.Itotal < (350 - (Train:GetPhysicsObject():GetMass()-30000)/24) * math.floor(Train.PositionSwitch.Position + 0.5)
	local RheostatAccelRotating = AcceleratingActive

	if Slope < -2 and (math.floor(Train.PositionSwitch.Position + 0.5) == 2 and RKPosition == 10 and Train.Electric.Itotal > 500) then
		--if PP and (8 <= RKPosition and RKPosition <= 12) then
			RheostatAccelRotating = false
		--end
	end
	local PneumaticValve1 = ((dX < 1.55) and (Train.ALS_ARS.Speed > 0.1) and OnStation and TargetBrakeRKPosition == 18) or (Train.ALS_ARS.Speed > (Train.ALS_ARS.SpeedLimit - threshold))
	--or (Train:ReadCell(6) > 0 and Train:ReadCell(18) < 1 and Slope > 1)
	if dX < 2 and Train.ALS_ARS.Speed < 0.5 then self.AutodriveReset = true end
	--Disable autodrive on end of station brake
	--local StatID = Metrostroi.WorkingStations[self.Train.UPO.Station] or Metrostroi.WorkingStations[self.Train.UPO.Station + (self.Path == 1 and 1 or -1)] or 0

	if (TargetBrakeRKPosition == 18 and Train.ALS_ARS.Speed < 0.1 and not self.StartMoving and OnStation) or (self.StartMoving and 10 < dX and dX < 160) then
		if (TargetBrakeRKPosition == 18 and Train.ALS_ARS.Speed < 0.1 and not self.StartMoving and OnStation) then
			self.Train.UPO.StationAutodrive = false

			--
			--self.VUDOverride = true
			--[[
			--local self.Train.UPO.Station = self.Train:ReadCell(49160) > 0 and self.Train:ReadCell(49160) or self.Train:ReadCell(49161)
			if self.Train.UPO.Station == 0 then return end
			local StatID = Metrostroi.WorkingStations[self.Train.UPO.Station] or Metrostroi.WorkingStations[self.Train.UPO.Station + (self.Path == 1 and 1 or -1)] or 0
			if not StationBraking then--GetConVarNumber("metrostroi_paksd_autoopen",0) > 0 and not StationBraking then
				local Curr = Metrostroi.AnnouncerData[self.Train.UPO.Station]
				if Curr[2] then
					Train:WriteCell(32,1)
				else
					Train:WriteCell(31,1)
				end
				timer.Simple(0.1,function()
					if not IsValid(Train) then return end
					Train:WriteCell(32,0)
					Train:WriteCell(31,0)
				end)
				Train.ADoorDisable:TriggerInput("Set",1)
			end
			]]
		end
		self.AutodriveReset = true
		return
	end

	-- Enter commands
	--Train:WriteCell(1, AcceleratingActive and 1 or 0) --Engage engines
	--Train:WriteCell(2, (RheostatAccelRotating or (ElectricBrakeActive and (RheostatBrakeRotating or RKPosition == 18 and not OnStation))) and 1 or 0) --X2/T2
	--Train:WriteCell(3, (Train.ALS_ARS.Speed > 30 and RheostatAccelRotating) and 1 or 0) --X3
	--Train:WriteCell(6, ElectricBrakeActive and 1 or 0) --Engage brakes
	--Train:WriteCell(20,(ElectricBrakeActive or not self.NoAcceleration) and 1 or 0) -- Engage power circuits
	local KVPos = 0
	if ElectricBrakeActive then
		if (RheostatBrakeRotating or RKPosition == 18 and not OnStation) and not Train:GetPackedBool(35) then
			KVPos = -3
		else
			KVPos = -1
		end
	elseif AcceleratingActive then
		if Train.ALS_ARS.Speed > 30 and RheostatAccelRotating and not Train:GetPackedBool(35) then
			KVPos = 3
		elseif RheostatAccelRotating and not Train:GetPackedBool(35) then
			KVPos = 2
		else
			KVPos = 1
		end
	end
	if (KVPos == -1) and Train:GetPackedBool(35) then
		if not self.VZTimer1 then self.VZTimer1 = CurTime() + 1 end
	else
		self.VZTimer1 = nil
	end
	if self.VZTimer1 and self.VZTimer1 < CurTime() then
		PneumaticValve1 = true
	end
	if OnStation then
		self.Train.R25p:TriggerInput("Set",self.OldRheostatBrakeRotating ~= RheostatBrakeRotating)
		self.OldRheostatBrakeRotating = RheostatBrakeRotating	
	end
	Train:WriteCell(29, PneumaticValve1 and 1 or 0) -- Engage PN1
	Train:TriggerInput("KVControllerAutodriveSet",KVPos)
	--Train:WriteCell(25,(ElectricBrakeActive and self.TargetBrakeRKPosition > 17) and 1 or 0) -- Engage power circuits
	self.Brake = ElectricBrakeActive
	self.Accelerate = AcceleratingActive
	self.Rotating = RheostatBrakeRotating and true or RheostatAccelRotating and false or nil
end

TRAIN_SYSTEM.Commands = {
	{
		[108] = {
			{9999,2.5},
		},		
		[109] = {
			{9999,2.5},
			{1366,0},
			{1217,3},
			{981,0},
			{684,3},
			{338,0},
			{259,2.5},
			{152,-6},
		},
		[110] = {
			{9999,2.5},
			{1003,0},
			{1016,-1},
			{820,0},
			{136,-6},
		},
		[111] = {
			{9999,2.5},
			{860,0},
			{335,-1},
			{233,0},
			{153,-6},
		},
		[112] = {
			{9999,2.5},
			{1809,3},
			{1645,0},
			{1446,-4},
			{1402,-4},
			{1286,0},
			{1220,-4},
			{1049,0},
			{541,-5},
			{403,0},
			{138,-6},
		},
	},
	{
		[111] = {
			{9999,2.5},
			{1651,3},
			{1464,0},
			{1260,2.5},
			{1232,2.5},
			{893,0},
			{847,2.5},
			{712,0},
			{491,-4},
			{288,0},
			{216,2.5},
			{156,0},
			{170,-6},
		},
		[110] = {
			{9999,2.5},
			{805,3},
			{770,0},
			{127,-6},
		},
		[109] = {
			{9999,3},
			{1043,0},
			{419,2.5},
			{353,3},
			{224,0},
			{176,-6},
		},
		[108] = {
			{9999,2.5},
			{1433,0},
			{1345,-1},
			{1339,-2},
			{1167,-1},
			{1075,0},
			{817,-1},
			{650,0},
			{167,-6},
		},
	}
}
function TRAIN_SYSTEM:GetCurrentCommand()
	self.Commands = {
		{
			[108] = {
				{9999,2.5},
			},		
			[109] = {
				{9999,2.5},
				{1366,0},
				{1217,3},
				{981,0},
				{684,3},
				{338,0},
				{259,2.5},
				{152,-6},
			},
			[110] = {
				{9999,2.5},
				{1003,0},
				{1016,-1},
				{850,0},
				{150,-6},
			},
			[111] = {
				{9999,2.5},
				{860,0},
				{335,-1},
				{233,0},
				{153,-6},
			},
			[112] = {
				{9999,2.5},
				{1809,3},
				{1645,0},
				{1446,-4},
				--{1402,-4},
				{1286,0},
				{1220,-4},
				{1018,0}, --1049
				{541,-5},
				{390,0},
				{150,-6},
			},
			[113] = {
				{9999,2.5},
				{678,0},
				{294,-1},
				{130,-6},
			},
			[114] = {
				{9999,3},
				{540,0},
				{150,-7},
			},
			[115] = {
				{9999,2.5},
				{1470,0},
				{1400,-4},
				{1288,0},
				{1207,2.5},
				{1101,3},
				{940,0},
				{896,-5},
				{761,0},
				{180,-6},
			},
			[116] = {
				{9999,3},
				{1190,0},
				{684,-5},
				{560,0},
				{140,-6},
			},
			[117] = {
				{9999,3},
				{1482,0},
				{974,-5},
				{866,0},
				{140,-6},
			},
			[118] = {
				{9999,3},
				{1780,0},
				{1750,-2},
				{1621,0},
				{1490,-4},
				{1273,0},
				{844,-4},
				{637,0},
				{557,-4},
				{416,0},
				{204,2.5},
				{165,0},
				{90,-6},
			},
			[119] = {
				{9999,2.5},
				{1650,0},
				{1148,2.5},
				{894,0},
				{630,-5},
				{498,0},
				{380,-2},
				{288,0},
				{222,-6},
			},
			[120] = {
				{9999,2.5},
				{1659,0},
				{1489,-5},
				{1405,0},
				{677,-1},
				{442,0},
				{158,-1},
				{80,-2},
				{75,-1},
				{65,-2},
				{60,-1},
				{55,-2},
				{50,-1},
			},
			[121] = {
				{9999,0},
				{3040,2.5},
				{2946,3},
				{2703,0},
				{1994,3},
				{1787,0},
				{1440,-5},
				{1311,0},
				{1074,-1},
				{1008,-2},
				{935,0},
				{145,-6},
			},
			[122] = {
				{9999,2.5},
				{2054,3},
				{1840,0},
				{1567,-5},
				{1370,0},
				{1154,-5},
				{870,0},
				{634,-5},
				{370,-0},
				{147,-6},
			},
			[123] = {
				{9999,3},
				{2855,0},
				{2684,-1},
				{2532,0},
				{1793,-5},
				{1548,0},
				{757,-1},
				{652,0},
				{137,-6},
			}
		},
		{
			[111] = {
				{9999,2.5},
				{1651,3},
				{1464,0},
				{1260,2.5},
				{1232,2.5},
				{893,0},
				{847,2.5},
				{712,0},
				{491,-4},
				{288,0},
				{216,2.5},
				{156,0},
				{170,-6},
			},
			[110] = {
				{9999,2.5},
				{805,3},
				{770,0},
				{150,-6},
			},
			[109] = {
				{9999,3},
				{1043,0},
				{419,2.5},
				{353,3},
				{224,0},
				{176,-6},
			},
			[108] = {
				{9999,2.5},
				{1433,0},
				{1345,-1},
				{1339,-2},
				{1167,-1},
				{1075,0},
				{817,-1},
				{650,0},
				{167,-6},
			},
		}
	}
	if (Metrostroi.TrainPositions[self.Train] and Metrostroi.TrainPositions[self.Train][1]) then
		self.PathID = Metrostroi.TrainPositions[self.Train][1].path.id
	end
	if not self.Commands[self.PathID] or not self.Commands[self.PathID][self.Train.UPO.Station] then return 2 end
	if self.Train:ReadCell(49165) < 20 and not self.OnStation then return 2 end
	local max-- = self.Train:ReadCell(49165)
	local pos = 0
	for k,v in ipairs(self.Commands[self.PathID][self.Train.UPO.Station]) do
		if v[1] > self.Train:ReadCell(49165) then
			max = v[1]
			pos = v[2]
		end
	end
	local speedLimit = 0--(self.Train.ALS_ARS.Signal0 or self.Train.ALS_ARS.RealNoFreq) and 0 or self.Train.ALS_ARS.Signal40 and 40 or self.Train.ALS_ARS.Signal60 and 60 or self.Train.ALS_ARS.Signal70 and 70 or self.Train.ALS_ARS.Signal80 and 80 or 0
	if self.Train.ALS_ARS.AVSpeedLimit and self.Train.ALS_ARS.AVSpeedLimit > 20 then
		speedLimit = self.Train.ALS_ARS.AVSpeedLimit
	end
	--if self.Train.Speed > speedLimit-1 and pos > 0 then pos = 0 end
	local RKPosition = math.floor(self.Train.RheostatController.Position+0.5)
	local PP = math.floor(self.Train.PositionSwitch.Position + 0.5) == 2
	if pos == 2.5 then
		return (not PP or RKPosition >= 7) and 3 or 1
	elseif pos > -4 then
		return pos
	elseif pos == -4 then
		return not self.Train:GetPackedBool(35) and RKPosition < 7 and -3 or -1
	elseif pos == -5 then
		return self.Train.Speed > speedLimit-5 and -2 or -1
	elseif pos == -6 or pos == -7 then
		self.OnStation = true
		local S = self.Train.UPO.Distance
		local RK = self:GetStationRK(S,pos == -7)

		if (RK >= 18 and self.Train.ALS_ARS.Speed < 0.1 and not self.StartMoving and self.OnStation) then
			self.Train.UPO.StationAutodrive = false
			--self.VUDOverride = true

			--local self.Train.UPO.Station = self.Train:ReadCell(49160) > 0 and self.Train:ReadCell(49160) or self.Train:ReadCell(49161)
			if self.Train.UPO.Station == 0 then self.AutodriveReset = true return end
			--local StatID = Metrostroi.WorkingStations[self.Train.UPO.Station] or Metrostroi.WorkingStations[self.Train.UPO.Station + (self.Path == 1 and 1 or -1)] or 0
			if not StationBraking then
				local Curr = Metrostroi.AnnouncerData[self.Train.UPO.Station]
				if Curr[2] then
					self.Train:WriteCell(32,1)
				else
					self.Train:WriteCell(31,1)
				end
				timer.Simple(0.1,function()
					if not IsValid(self.Train) then return end
					self.Train:WriteCell(32,0)
					self.Train:WriteCell(31,0)
				end)
				self.Train.ADoorDisable:TriggerInput("Set",1)
			end
			self.AutodriveReset = true
			self.KVPos = 0
		end
		return (not self.Train:GetPackedBool(35) and (RK > RKPosition or RK >= 18)) and (RK == 19 and -4 or-3) or -1 
	end
end
function TRAIN_SYSTEM:BoardAutodrive()
	local Train= self.Train
	
	-- Calculate distance to station
	local dX = self.Train.UPO.Distance
	if dX > 160 then self.StartMoving = nil end
	local OnStation = dX < 160 and not self.StartMoving and Metrostroi.AnnouncerData[self.Train.UPO.Station]and Metrostroi.AnnouncerData[self.Train.UPO.Station][1]
	--if StationBraking and (dX >= (160+35*self.MU - (speedLimit == 40 and 30 or 0)) or not OnStation) then self.Train.UPO.StationAutodrive = false return end
	-- Target and real RK position (0 if not braking)
	local TargetBrakeRKPosition = 0

	local Command = self:GetCurrentCommand()
	local KVPos = Command
	local VZP = self.Train.KSAUP and self.Train.VZP.Value > 0.5
	local Vn2 = KVPos == -4
	if VZP and KVPos > 0 then
		KVPos = 0
	elseif ElectricBrakeActive then
		if (RheostatBrakeRotating or RKPosition == 18 and not OnStation) and not Train:GetPackedBool(35) then
			KVPos = -3
		else
			KVPos = -1
		end
	elseif AcceleratingActive then
		if Train.ALS_ARS.Speed > 30 and RheostatAccelRotating and not Train:GetPackedBool(35) then
			KVPos = 3
		elseif RheostatAccelRotating and not Train:GetPackedBool(35) then
			KVPos = 2
		else
			KVPos = 1
		end
	end
	if Vn2 then KVPos = 0 end
	if OnStation then
		self.Train.R25p:TriggerInput("Set",self.OldRheostatBrakeRotating ~= RheostatBrakeRotating)
		self.OldRheostatBrakeRotating = RheostatBrakeRotating	
	end
	--Train:WriteCell(29, PneumaticValve1 and 1 or 0) -- Engage PN1
	Train:TriggerInput("KVControllerAutodriveSet",KVPos)
	--Train:WriteCell(25,(ElectricBrakeActive and self.TargetBrakeRKPosition > 17) and 1 or 0) -- Engage power circuits
	self.Brake = ElectricBrakeActive
	self.Accelerate = AcceleratingActive
	self.KVPos = KVPos
	self.Rotating = RheostatBrakeRotating and true or RheostatAccelRotating and false or nil
end

function TRAIN_SYSTEM:Enable()
	if not self.AutodriveEnabled and not self.AutodriveReset then
		self.AutodriveEnabled = true
		self.StartMoving = true
	end
end
function TRAIN_SYSTEM:Disable()
	self.AutodriveReset = true
end
function TRAIN_SYSTEM:Think()
	self.TrainCorrections = {
		["Em"] = 0,
		["717"] = 0,
	}
	local S = self.Train.UPO.Distance
	self.Time = self.Time or CurTime()
 	if (CurTime() - self.Time) > 0.1 and self.Train.A29 and self.Train.A29.Value < 0.5 then
		self.Time = CurTime()
		--RunConsoleCommand("say",Format("station:%.2f,%.2f\t distance:%.2f",self.Train.UPO.Station,self.Train:ReadCell(49165),S))
	end
	if self.Train.KSAUP then return end
	if self.Train.VZP then
		if self.Train.BCCD and self.Train.BCCD.Value > 0 and self.Train.ADoorDisable.Value > 0 then
			self.Train.ADoorDisable:TriggerInput("Set",0)
			self.OnStation = false
			self.AutodriveEnabled = false
			self.ReadyToStart = true
		end
		--[[if Train:CPPIGetOwner() and Train:CPPIGetOwner():GetName() ~= "glebqip(RUS)" and (self.AutodriveEnabled or not self.AutodriveReset) then
			self.AutodriveReset = true
		else]]

		if self.AutodriveReset then
			self.Train:TriggerInput("KVControllerAutodriveSet",0)
			self.NoAcceleration = nil
			self.Train:WriteCell(8,0)
			self.Train:WriteCell(29,0)
			self.AutodriveEnabled = false
			self.OnStation = false
		end

		if (self.Train.VZP.Value < 0.5 or (self.Train.Blok and self.Train.Blok == 4)) and self.AutodriveReset then
			self.AutodriveReset = false
		end
		--Disable autodrive, if KV pos is not zero, ARS or ALS not enabled, Reverser position is not forward or Driver value pos is > 2
		if self.Train.Blok and self.Train.Blok ~= 1 then
			if (self.Train.Pneumatic.BrakeLinePressure < 4.8 or self.Train.Pneumatic.BrakeCylinderPressure > 1.8) and not self.BCTimer then
				self.BCTimer = CurTime()+3
			end
			if self.Train.Pneumatic.BrakeLinePressure >= 4.8 and self.Train.Pneumatic.BrakeCylinderPressure <= 1.8 then
				self.BCTimer = nil
			end
			if self.BCTimer and CurTime() - self.BCTimer > 0 then
				self:Disable()
			end
			if self.Train.KV.ControllerPosition ~= 0.0 or not self.Train.ALS_ARS.EnableARS or self.Train.KV.ReverserPosition ~= 1.0 or self.Train.Panel.SD < 0.5 then
				self:Disable()
			end
			if self.Train.ALS_ARS["33G"] > 0.5 then
				self:Disable()
			end
		end
		--if self.OnStation and self.Train.UPO.StationAutodrive and self.AutodriveWorking and not self.VRD and self.Train.ALS_ARS.EnableARS and self.Train.KV.ReverserPosition == 1.0 and self.Train.Pneumatic.DriverValvePosition <= 2 and self.self.Train.Panel.SD > 0.5 then
			--self:Autodrive(true)
		--elseif self.Train.UPO.StationAutodrive then
			--self.Train.UPO.StationAutodrive = false
		--end
		if self.AutodriveEnabled then
			if self.Train.Blok ~= 1 and not self.KSAUP  then
				self:Autodrive()
			else
				self:BoardAutodrive()
			end
		end
		if self.ReadyToStart and self.Train.Panel["SD"] > 0.5 then
			self.ReadyToStart = nil
			self.AutodriveReset = false
		end
		if self.Blocks == 2 and self["PA-KSD"].StationAutodrive then
			self:Autodrive(true)
		end
		--end
	end
	if self.RealControllerPosition ~= self.Train.KV.RealControllerPosition and self.Train.Blok == 1  and self.Train.A5 and self.Train.A5.Value > 0.5 then
		local dX = self.Train.UPO.Distance
		--RunConsoleCommand("say",self.Train.KV.RealControllerPosition,dX,self.Train.UPO.Station,(Metrostroi.TrainPositions[self.Train] and Metrostroi.TrainPositions[self.Train][1]) and Metrostroi.TrainPositions[self.Train][1].path.id or "unk",math.floor(self.Train.RheostatController.Position+0.5))
		--file.Append("puav.txt",Format("%d\t%s\t%d\t%s\t%d\n",self.Train.KV.RealControllerPosition,dX,self.Train.UPO.Station,(Metrostroi.TrainPositions[self.Train] and Metrostroi.TrainPositions[self.Train][1]) and Metrostroi.TrainPositions[self.Train][1].path.id or "unk",math.floor(self.Train.RheostatController.Position+0.5)))
		self.RealControllerPosition = self.Train.KV.RealControllerPosition
	end
	--self:GetCurrentCommand()
end

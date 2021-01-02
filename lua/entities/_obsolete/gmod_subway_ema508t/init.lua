AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner

---------------------------------------------------
-- Defined train information
-- Types of wagon(for wagon limit system):
-- 0 = Head or intherim
-- 1 = Only head
-- 2 = Only intherim
---------------------------------------------------
ENT.SubwayTrain = {
	Type = "E",
	Name = "Em508T",
	Manufacturer = "MVM",
	WagType = 2,
}

function ENT:Initialize()

	-- Set model and initialize
	self:SetModel("models/metrostroi/81/ema508t.mdl")
	self.BaseClass.Initialize(self)
	self:SetPos(self:GetPos() + Vector(0,0,140))

	-- Create bogeys
	self.FrontBogey = self:CreateBogey(Vector( 325-20,0,-80),Angle(0,180,0),true)
	self.RearBogey  = self:CreateBogey(Vector(-325-10,0,-80),Angle(0,0,0),false)
    local pneumoPow = 0.8+(math.random()^0.4)*0.3
    self.FrontBogey.PneumaticPow = pneumoPow
    self.RearBogey.PneumaticPow = pneumoPow

	self.InteractionZones = {
		{	Pos = Vector(458,-30,-55),
			Radius = 16,
			ID = "FrontBrakeLineIsolationToggle" },
		{	Pos = Vector(458, 30,-55),
			Radius = 16,
			ID = "FrontTrainLineIsolationToggle" },
		{	Pos = Vector(458, 60,-55),
			Radius = 16,
			ID = "ParkingBrakeToggle" },
		{	Pos = Vector(-482,30,-55),
			Radius = 16,
			ID = "RearBrakeLineIsolationToggle" },
		{	Pos = Vector(-482, -30,-55),
			Radius = 16,
			ID = "RearTrainLineIsolationToggle" },
		{	Pos = Vector(154,62.5,-65),
			Radius = 16,
			ID = "GVToggle" },
		{	Pos = Vector(446.0,0.0,50),
			Radius = 16,
			ID = "VBToggle" },
		{	Pos = Vector(-180,68.5,-50),
			Radius = 20,
			ID = "AirDistributorDisconnectToggle" },
		{	Pos = Vector(-482,-38,-1),
			Radius = 24,
			ID = "RearDoor" },
		{	Pos = Vector(458,38,-1),
			Radius = 24,
			ID = "FrontDoor" },
	}

	-- Lights
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
		[11] = { "dynamiclight",	Vector( 250, 0, 5), Angle(0,0,0), Color(255,255,255), brightness = 3, distance = 400 },
		[12] = { "dynamiclight",	Vector(   0, 0, 5), Angle(0,0,0), Color(255,255,255), brightness = 3, distance = 400 },
		[13] = { "dynamiclight",	Vector(-250, 0, 5), Angle(0,0,0), Color(255,255,255), brightness = 3, distance = 400 },

		-- Side lights
		[14] = { "light",			Vector(-50, 68, 51.9), Angle(0,0,0), Color(255,0,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[15] = { "light",			Vector(6,   68, 51.9), Angle(0,0,0), Color(150,255,255), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[16] = { "light",			Vector(3,   68, 51.9), Angle(0,0,0), Color(50,255,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[17] = { "light",			Vector(-0,  68, 51.9), Angle(0,0,0), Color(255,255,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },

		[18] = { "light",			Vector(-50, -69, 51.9), Angle(0,0,0), Color(255,0,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[19] = { "light",			Vector(6,   -69, 51.9), Angle(0,0,0), Color(150,255,255), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[20] = { "light",			Vector(3,   -69, 51.9), Angle(0,0,0), Color(50,255,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[21] = { "light",			Vector(-0,  -69, 51.9), Angle(0,0,0), Color(255,255,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },

		-- Green RP
		[22] = { "light",			Vector(439.4,12.5-9.6,-5.7), Angle(0,0,0), Color(100,255,0), brightness = 1.0, scale = 0.020 },
		-- AVU
		[23] = { "light",			Vector(441.2,12.5-20.3,-3.7), Angle(0,0,0), Color(255,40,0), brightness = 1.0, scale = 0.020 },
		-- LKTP
		[24] = { "light",			Vector(441.2,12.5-23.0,-3.7), Angle(0,0,0), Color(255,40,0), brightness = 1.0, scale = 0.020 },
	}

	for i = 1,23 do
		self.Lights[69+i] = { "light", Vector(-470 + 35*i, 0, 65), Angle(180,0,0), Color(255,220,180), brightness = 0.25, scale = 0.75}
		--self:SetLightPower(69+i,RealTime()%1*2>1)
	end

	-- Cross connections in train wires
	self.TrainWireInverts = {
		[18] = true,
		[34] = true,
	}
	self.TrainWireCrossConnections = {
		[5] = 4, -- Reverser F<->B
		[31] = 32, -- Doors L<->R
	}

	-- Setup door positions
	self.LeftDoorPositions = {}
	self.RightDoorPositions = {}
	for i=0,3 do
		table.insert(self.LeftDoorPositions,Vector(353.0 - 35*0.5 - 231*i,65,-1.8))
		table.insert(self.RightDoorPositions,Vector(353.0 - 35*0.5 - 231*i,-65,-1.8))
	end
	self.RearDoor = false
	self.FrontDoor = false
	self:UpdateTextures()
end

function ENT:UpdateTextures()
	local texture = Metrostroi.Skins["train"][self.Texture]
	local passtexture = Metrostroi.Skins["pass"][self.PassTexture]

	for k,v in pairs(self:GetMaterials()) do
		self:SetSubMaterial(k-1,"")
	end
	for k,v in pairs(self:GetMaterials()) do
		if v == "models/metrostroi_train/81/int02" then
			if not Metrostroi.Skins["717_schemes"] or not Metrostroi.Skins["717_schemes"]["m"] then
				self:SetSubMaterial(k-1,Metrostroi.Skins["717_schemes"][""])
			else
				if not self.Adverts or self.Adverts ~= 4 then
					self:SetSubMaterial(k-1,Metrostroi.Skins["717_schemes"]["m"].adv)
				else
					self:SetSubMaterial(k-1,Metrostroi.Skins["717_schemes"]["m"].clean)
				end
			end
		end
		local tex = string.Explode("/",v)
		tex = tex[#tex]
		if passtexture and passtexture.textures[tex] then
			self:SetSubMaterial(k-1,passtexture.textures[tex])
		end
		if texture and texture.textures[tex] then
			self:SetSubMaterial(k-1,texture.textures[tex])
		end

	end
	self:SetNW2String("texture",self.Texture)
	self:SetNW2String("passtexture",self.PassTexture)
end

--------------------------------------------------------------------------------
function ENT:Think()
	local retVal = self.BaseClass.Think(self)

	self.Electric:TriggerInput("TrainMode",1)

	-- Interior/cabin lights
--	self:SetLightPower(10, (self.Panel["CabinLight"] > 0.5))
	--self:SetLightPower(12, self.PowerSupply.XT3_4 > 65.0)
--	self:SetLightPower(13, self.PowerSupply.XT3_4 > 65.0)
	self:SetLightPower(11, self.PowerSupply.XT3_4 > 65.0, 0.8)
	self:SetLightPower(12, self.Panel["EmergencyLight"] > 0.5,0.1 + ((self.PowerSupply.XT3_4 > 65.0) and 0.7 or 0))
	self:SetLightPower(13, self.PowerSupply.XT3_4 > 65.0, 0.8)

	local lightsActive2 = self.PowerSupply.XT3_4 > 65.0
	local lightsActive1 = self.Panel["EmergencyLight"] > 0.5
	self:SetLightPower(11, lightsActive2, 0.8)
	self:SetLightPower(12, lightsActive1,0.1 + ((self.PowerSupply.XT3_4 > 65.0) and 0.7 or 0))
	self:SetLightPower(13, lightsActive2, 0.8)
	for i = 1,23 do
		self:SetLightPower(69+i,lightsActive2 and true or lightsActive1 and i%5==1 or false)
	end

	-- Side lights
	self:SetLightPower(15, self.Panel["TrainDoors"] > 0.5)
	self:SetLightPower(19, self.Panel["TrainDoors"] > 0.5)
	self:SetLightPower(16, (self.Panel["GreenRP"] or 0) > 0.5)
	self:SetLightPower(20, (self.Panel["GreenRP"] or 0) > 0.5)
	self:SetLightPower(17, self.Panel["TrainBrakes"] > 0.5)
	self:SetLightPower(21, self.Panel["TrainBrakes"] > 0.5)

	-- Switch and button states
	self:SetPackedBool(0,self:IsWrenchPresent())
	self:SetPackedBool(5,self.GV.Value == 1.0)
	self:SetPackedBool(7,self.VB.Value == 1.0)
	self:SetPackedBool(20,self.Pneumatic.Compressor == 1.0)
	self:SetPackedBool(21,self.Pneumatic.LeftDoorState[1] > 0.5)
	self:SetPackedBool(22,self.Pneumatic.LeftDoorState[2] > 0.5)
	self:SetPackedBool(23,self.Pneumatic.LeftDoorState[3] > 0.5)
	self:SetPackedBool(24,self.Pneumatic.LeftDoorState[4] > 0.5)
	self:SetPackedBool(25,self.Pneumatic.RightDoorState[1] > 0.5)
	self:SetPackedBool(26,self.Pneumatic.RightDoorState[2] > 0.5)
	self:SetPackedBool(27,self.Pneumatic.RightDoorState[3] > 0.5)
	self:SetPackedBool(28,self.Pneumatic.RightDoorState[4] > 0.5)
	self:SetPackedBool(112,(self.RheostatController.Velocity ~= 0.0))
	self:SetPackedBool(156,self.RearDoor)
	self:SetPackedBool(157,self.FrontDoor)

	self:SetPackedBool(160,self.ParkingBrake)

	-- Signal if doors are open or no to platform simulation
	self.LeftDoorsOpen =
		(self.Pneumatic.LeftDoorState[1] > 0.5) or
		(self.Pneumatic.LeftDoorState[2] > 0.5) or
		(self.Pneumatic.LeftDoorState[3] > 0.5) or
		(self.Pneumatic.LeftDoorState[4] > 0.5)
	self.RightDoorsOpen =
		(self.Pneumatic.RightDoorState[1] > 0.5) or
		(self.Pneumatic.RightDoorState[2] > 0.5) or
		(self.Pneumatic.RightDoorState[3] > 0.5) or
		(self.Pneumatic.RightDoorState[4] > 0.5)

	-- BPSN
	self:SetPackedBool(52,self.PowerSupply.XT3_1 > 0)

	-- AV states
	for i,v in ipairs(self.Panel.AVMap) do
		if tonumber(v) then
			if self["A"..v].Value < 1 then
				self["A"..v]:TriggerInput("Set",1)
			end
			self:SetPackedBool(64+(i-1),self["A"..v].Value == 1.0)
		elseif self[v] then
			if self[v].Value < 1 then
				self[v]:TriggerInput("Set",1)
			end
			self:SetPackedBool(64+(i-1),self[v].Value == 1.0)
		end
	end

	-- Feed packed floats
	self:SetPackedRatio(0, 1-self.Pneumatic.DriverValvePosition/5)
	--self:SetPackedRatio(1, (self.KV.ControllerPosition+3)/7)
	--self:SetPackedRatio(2, 1-(self.KV.ReverserPosition+1)/2)
	self:SetPackedRatio(4, self.Pneumatic.ReservoirPressure/16.0)
	self:SetPackedRatio(5, self.Pneumatic.TrainLinePressure/16.0)
	self:SetPackedRatio(6, self.Pneumatic.BrakeCylinderPressure/6.0)
	self:SetPackedRatio(7, self.Electric.Power750V/1000.0)
	self:SetPackedRatio(8, math.abs(self.Electric.I24)/1000.0)
	--self:SetPackedRatio(9, self.Pneumatic.BrakeLinePressure_dPdT or 0)
	if self.Pneumatic.TrainLineOpen then
		self:SetPackedRatio(9, (-self.Pneumatic.TrainLinePressure_dPdT or 0)*6)
	else
		self:SetPackedRatio(9, self.Pneumatic.BrakeLinePressure_dPdT or 0)
	end
	--self:SetPackedRatio(10,(self.Panel["V1"] * self.Battery.Voltage) / 100.0)

	-- Exchange some parameters between engines, pneumatic system, and real world
	self.Engines:TriggerInput("Speed",self.Speed)
	if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and not self.IgnoreEngine then
		local A = 2*self.Engines.BogeyMoment
		self.FrontBogey.MotorForce = 30300+25000*(A < 0 and 1 or 0)
		self.FrontBogey.Reversed = (self.RKR.Value > 0.5)
		self.RearBogey.MotorForce  = 30300+25000*(A < 0 and 1 or 0)
		self.RearBogey.Reversed = (self.RKR.Value < 0.5)

		-- These corrections are required to beat source engine friction at very low values of motor power
		local A = 2*self.Engines.BogeyMoment
		local P = math.max(0,0.04449 + 1.06879*math.abs(A) - 0.465729*A^2)
		if math.abs(A) > 0.4 then P = math.abs(A) end
		if math.abs(A) < 0.05 then P = 0 end
		if self.Speed < 10 then P = P*(1.0 + 0.5*(10.0-self.Speed)/10.0) end
		self.RearBogey.MotorPower  = P*0.5*((A > 0) and 1 or -1)
		self.FrontBogey.MotorPower = P*0.5*((A > 0) and 1 or -1)

		-- Apply brakes
		self.FrontBogey.PneumaticBrakeForce = 50000.0
		self.FrontBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
		self.FrontBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
		self.FrontBogey.ParkingBrake = self.ParkingBrake.Value > 0.5
		self.RearBogey.PneumaticBrakeForce = 50000.0
		self.RearBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
		self.RearBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
		--self.RearBogey.ParkingBrake = self.ParkingBrake.Value > 0.5
	end

	return retVal
end


--------------------------------------------------------------------------------
function ENT:OnCouple(train,isfront)
    if isfront and self.FrontAutoCouple then
        self.FrontBrakeLineIsolation:TriggerInput("Open",1.0)
        self.FrontTrainLineIsolation:TriggerInput("Open",1.0)
        self.FrontAutoCouple = false
    elseif not isfront and self.RearAutoCouple then
        self.RearBrakeLineIsolation:TriggerInput("Open",1.0)
        self.RearTrainLineIsolation:TriggerInput("Open",1.0)
        self.RearAutoCouple = false
    end
	self.BaseClass.OnCouple(self,train,isfront)
end
function ENT:OnButtonPress(button,ply)
	if button == "AirDistributorDisconnectToggle" then return end
	if button == "VBToggle" then
		if self.VB.Value == 1 then
			self:PlayOnce("vu22_on",nil)
		else
			self:PlayOnce("vu22_off",nil)
		end
		return
	end
	if button == "GVToggle" then
		if self.GV.Value > 0.5 then
			self:PlayOnce("revers_f",nil,0.7)
		else
			self:PlayOnce("revers_b",nil,0.7)
		end
		return
	end

	-- Generic button or switch sound
	if string.find(button,"Set") then
		self:PlayOnce("switch")
	end
	if string.find(button,"Toggle") then
		self:PlayOnce("switch2")
	end
	if button == "FrontDoor" then
		self.FrontDoor = not self.FrontDoor
		if self.FrontDoor then self:PlayOnce("door_open_tor") else self:PlayOnce("door_close_tor") end
	end
	if button == "RearDoor" then
		self.RearDoor = not self.RearDoor
		if self.RearDoor then self:PlayOnce("door_open_tor") else self:PlayOnce("door_close_tor") end
	end
end

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
	Name = "E",
	WagType = 1,
	ARS = {
		HaveASNP = false,
	}
}
function ENT:Initialize()
	-- Set model and initialize
	self:SetModel("models/metrostroi_train/e/e.mdl")
	self.BaseClass.Initialize(self)
	self:SetPos(self:GetPos() + Vector(0,0,140))

	-- Create seat entities
	self.DriverSeat = self:CreateSeat("driver",Vector(418+9.15,-41,-48+6+2.5),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")
	self.InstructorsSeat = self:CreateSeat("instructor",Vector(430,40,-48+6+2.5),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")
	self.ExtraSeat1 = self:CreateSeat("instructor",Vector(443,0,-48+6+2.5),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")
	self.ExtraSeat2 = self:CreateSeat("instructor",Vector(420,-20,-48+6),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")

	-- Hide seats
	self.DriverSeat:SetColor(Color(0,0,0,0))
	self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
	self.InstructorsSeat:SetColor(Color(0,0,0,0))
	self.InstructorsSeat:SetRenderMode(RENDERMODE_TRANSALPHA)

	self.ExtraSeat1:SetColor(Color(0,0,0,0))
	self.ExtraSeat1:SetRenderMode(RENDERMODE_TRANSALPHA)
	self.ExtraSeat2:SetColor(Color(0,0,0,0))
	self.ExtraSeat2:SetRenderMode(RENDERMODE_TRANSALPHA)

	-- Create bogeys
	self.FrontBogey = self:CreateBogey(Vector( 313,0,-80),Angle(0,180,0),true)
	self.RearBogey  = self:CreateBogey(Vector(-313,0,-80),Angle(0,0,0),false)
    local pneumoPow = 0.8+(math.random()^0.4)*0.3
    self.FrontBogey.PneumaticPow = pneumoPow
    self.RearBogey.PneumaticPow = pneumoPow

	-- Initialize key mapping
	self.KeyMap = {
		[KEY_1] = "KVSetX1",
		[KEY_2] = "KVSetX2",
		[KEY_3] = "KVSetX3",
		[KEY_4] = "KVSet0",
		[KEY_5] = "KVSetT1",
		[KEY_6] = "KVSetT1AB",
		[KEY_7] = "KVSetT2",
		[KEY_8] = "KRP",

		[KEY_EQUAL] = "R_Program1Set",
		[KEY_MINUS] = "R_Program2Set",

		[KEY_G] = "VozvratRPSet",

		[KEY_0] = "KVReverserUp",
		[KEY_9] = "KVReverserDown",
		[KEY_PAD_PLUS] = "KVReverserUp",
		[KEY_PAD_MINUS] = "KVReverserDown",
		[KEY_W] = "KVUp",
		[KEY_S] = "KVDown",
		[KEY_F] = "PneumaticBrakeUp",
		[KEY_R] = "PneumaticBrakeDown",

		[KEY_A] = "KDL",
		[KEY_D] = "KDP",
		[KEY_V] = "VUD1Toggle",
		[KEY_L] = "HornEngage",
		[KEY_N] = "VZ1Set",
		[KEY_PAD_1] = "PneumaticBrakeSet1",
		[KEY_PAD_2] = "PneumaticBrakeSet2",
		[KEY_PAD_3] = "PneumaticBrakeSet3",
		[KEY_PAD_4] = "PneumaticBrakeSet4",
		[KEY_PAD_5] = "PneumaticBrakeSet5",
		[KEY_PAD_6] = "PneumaticBrakeSet6",
		[KEY_PAD_7] = "PneumaticBrakeSet7",
		[KEY_PAD_DIVIDE] = "KRPSet",
		[KEY_PAD_MULTIPLY] = "KAHSet",

		[KEY_SPACE] = "PBSet",
		[KEY_BACKSPACE] = "EmergencyBrake",

		[KEY_PAD_0] = "DriverValveDisconnect",
		[KEY_PAD_DECIMAL] = "EPKToggle",
		[KEY_LSHIFT] = {
			[KEY_W] = "KVUp_Unlocked",
			[KEY_SPACE] = "KVTSet",

			[KEY_A] = "DURASelectAlternate",
			[KEY_D] = "DURASelectMain",
			[KEY_V] = "DURAToggleChannel",
			[KEY_1] = "DIPonSet",
			[KEY_2] = "DIPoffSet",
			[KEY_4] = "KVSet0Fast",
			[KEY_L] = "DriverValveDisconnect",

			[KEY_7] = "KVWrenchNone",
			[KEY_8] = "KVWrenchKRU",
			[KEY_9] = "KVWrenchKV",
			[KEY_0] = "KVWrench0",
			[KEY_6] = "KVSetT1A",
		},

		[KEY_RSHIFT] = {
			[KEY_7] = "KVWrenchNone",
			[KEY_8] = "KVWrenchKRU",
			[KEY_9] = "KVWrenchKV",
			[KEY_0] = "KVWrench0",
			[KEY_L] = "DriverValveDisconnect",
			[KEY_F] = "BCCDSet",
			[KEY_R] = "VZPSet",
		},
		[KEY_LALT] = {
			[KEY_V] = "VUD1Toggle",
			[KEY_L] = "EPKToggle",
		},
		[KEY_RALT] = {
			[KEY_L] = "EPKToggle",
		},
	}

	self.InteractionZones = {
		{	Pos = Vector(-470,-38,9),
			Radius = 28,
			ID = "RearDoor" },
		{	Pos = Vector(450,38,9),
			Radius = 28,
			ID = "FrontDoor1" },
		{	Pos = Vector(450,38,-16),
			Radius = 28,
			ID = "FrontDoor2" },
		{	Pos = Vector(382,-38,9),
			Radius = 28,
			ID = "PassengerDoor" },
		{	Pos = Vector(445,61,25),
			Radius = 16,
			ID = "CabinDoor1" },
		{	Pos = Vector(445,61,-25),
			Radius = 16,
			ID = "CabinDoor2" },
		{	Pos = Vector(380,67,25),
			Radius = 28,
			ID = "CabinDoor3" },
		{	Pos = Vector(380,67,-25),
			Radius = 28,
			ID = "CabinDoor4" },
	}

	self.Lights = {
		-- Head
		[1] = { "headlight",		Vector(465+11,0,-20), Angle(0,0,0), Color(216,161,92), fov = 100 },
		[2] = { "glow",				Vector(469.4, 45.43,-30.7), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 1.0 },
		[3] = { "glow",				Vector(469.4,-45.43,-30.7), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 1.0 },
		[4] = { "glow",				Vector(458+9,-14.86, 58), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 0.5 },
		[5] = { "glow",				Vector(458+9,0,  58), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 0.5 },
		[6] = { "glow",				Vector(458+9, 14.86,  58), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 0.5 },

		-- Reverse
		[8] = { "light",			Vector(458+11,-30.7, 54.2), Angle(0,0,0), Color(255,0,0),     brightness = 10, scale = 1.0 },
		[9] = { "light",			Vector(458+11, 30.7, 54.2), Angle(0,0,0), Color(255,0,0),     brightness = 10, scale = 1.0 },

		-- Cabin
		[10] = { "dynamiclight",	Vector(435,0,20), Angle(0,-0,0), Color(255,107,50), brightness = 0.004, distance = 600, shadows = 1},

		-- Interior
		[11] = { "dynamiclight",	Vector( 250, 0, 0), Angle(0,0,0), Color(255,95,10), brightness = 5, distance = 300 , fov=180,farz = 128 },
		[12] = { "dynamiclight",	Vector(   0, 0, 0), Angle(0,0,0), Color(255,95,10), brightness = 5, distance = 400, fov=180,farz = 128 },
		[13] = { "dynamiclight",	Vector(-300, 0, 0), Angle(0,0,0), Color(255,95,10), brightness = 5, distance = 400 , fov=180,farz = 128 },

		-- Side lights
		--//[14] = { "light",			Vector(390+12.15, 69, 54), Angle(0,0,0), Color(255,0,0), brightness = 0.5, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		--[15] = { "light",			Vector(390+12.15, 69, 51), Angle(0,0,0), Color(150,255,255), brightness = 0.6, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		--[16] = { "light",			Vector(390+12.15, 69, 48), Angle(0,0,0), Color(50,255,0), brightness = 0.5, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		--[17] = { "light",			Vector(390+12.15, 69, 45), Angle(0,0,0), Color(255,255,0), brightness = 0.5, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },

		--[18] = { "light",			Vector(390+12.15, -69, 54), Angle(0,0,0), Color(255,0,0), brightness = 0.5, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		--[19] = { "light",			Vector(390+12.15, -69, 51), Angle(0,0,0), Color(150,255,255), brightness = 0.6, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		--[20] = { "light",			Vector(390+12.15, -69, 48), Angle(0,0,0), Color(50,255,0), brightness = 0.5, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		--[21] = { "light",			Vector(390+12.15, -69, 45), Angle(0,0,0), Color(255,255,0), brightness = 0.5, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },

		[15] = { "light",			Vector(402.202942,69.270073,44.79285), Angle(0,0,0), Color(150,255,255), brightness = 0.9, scale = 0.10, texture = "sprites/light_glow02.vmt" },
		[16] = { "light",			Vector(402.202942,69.270073,41.509621), Angle(0,0,0), Color(50,255,0), brightness = 0.9, scale = 0.10, texture = "sprites/light_glow02.vmt" },
		[17] = { "light",			Vector(402.202942,69.270073,37.3862), Angle(0,0,0), Color(255,255,0), brightness = 0.9, scale = 0.10, texture = "sprites/light_glow02.vmt" },

		--[19] = { "light",			Vector(15,   -69, 58.3), Angle(0,0,0), Color(150,255,255), brightness = 0.9, scale = 0.10, texture = "sprites/light_glow02.vmt" },
		--[20] = { "light",			Vector(12,   -69, 58.3), Angle(0,0,0), Color(50,255,0), brightness = 0.9, scale = 0.10, texture = "sprites/light_glow02.vmt" },
		--[21] = { "light",			Vector(9,  -69, 58.3), Angle(0,0,0), Color(255,255,0), brightness = 0.9, scale = 0.10, texture = "sprites/light_glow02.vmt" },
		[32] = { "headlight", 		Vector(450.70,-56.3,28), Angle(-90,0,-45), Color(216,161,92), farz = 6, nearz = 4, shadows = 0, brightness = 2, fov = 77 },
		[33] = { "headlight", 		Vector(450.70,-56.3,32), Angle(-90,0,-45), Color(216,161,92), farz = 6, nearz = 4, shadows = 0, brightness = 2, fov = 77 },

		[34] = { "headlight", 		Vector(448.65,-56.40,22.60), Angle(-30,0,-45), Color(216,161,92), farz = 6, nearz = 4, shadows = 0, brightness = 2, fov = 140 },

		[35] = { "headlight", 		Vector(450.6,-55.84,12.73), Angle(-90,-90,-180), Color(216,161,92), farz = 7, nearz = 4, shadows = 0, brightness = 2, fov = 130 },

		[36] = { "headlight", 		Vector(455.2,-53.2,5.35), Angle(-90,-90,-180), Color(216,161,92), farz = 4, nearz = 4, shadows = 0, brightness = 2, fov = 130 },

		[37] = { "headlight", 		Vector(458.3,-20.32,19.6), Angle(-90,-120,-180), Color(216,161,92), farz = 4, nearz = 4, shadows = 0, brightness = 3, fov = 160 },

		[38] = { "headlight",	Vector( -20, 0, 30), Angle(90,0,90), Color(255,95,10), brightness = 1, distance = 999,fov=179, shadows = 0, farz = 500},
		[39] = { "headlight",	Vector( -20, 0, 10), Angle(-90,0,90), Color(255,95,10), brightness = 1, distance = 999,fov=179, shadows = 0, farz = 500},

	}
	-- Lights
		--[[
	for i = 1,23 do
		self.Lights[69+i] = { "light", Vector(-470 + 35*i, 0, 65), Angle(180,0,0), Color(255,220,180), brightness = 0.25, scale = 0.75}
		--self:SetLightPower(69+i,RealTime()%1*2>1)
	end]]

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

	-- KV wrench mode
	self.KVWrenchMode = 0

	-- Parking brake ratio
	self.ManualBrake = 0.0
	self.RearDoor = false
	self.FrontDoor = false
	self.CabinDoor = false
	self.PassengerDoor = false

--	self.A5:TriggerInput("Set",0)
	self:UpdateTextures()
end
function ENT:UpdateTextures()
	local texture = Metrostroi.Skins["train"][self.Texture]
	local passtexture = Metrostroi.Skins["pass"][self.PassTexture]
	local cabintexture = Metrostroi.Skins["cab"][self.CabTexture]

	for k,v in pairs(self:GetMaterials()) do
		self:SetSubMaterial(k-1,"")
	end
	for k,v in pairs(self:GetMaterials()) do
		if v == "models/metrostroi_train/81/int02" then
			if not Metrostroi.Skins["717_schemes"] or not Metrostroi.Skins["717_schemes"]["m"] then
				--self:SetSubMaterial(k-1,Metrostroi.Skins["717_schemes"][""])
			else
				if not self.Adverts or self.Adverts ~= 4 then
					--self:SetSubMaterial(k-1,Metrostroi.Skins["717_schemes"]["m"].adv)
				else
					--self:SetSubMaterial(k-1,Metrostroi.Skins["717_schemes"]["m"].clean)
				end
			end
		end
		local tex = string.Explode("/",v)
		tex = tex[#tex]
		if cabintexture and cabintexture.textures[tex] then
			self:SetSubMaterial(k-1,cabintexture.textures[tex])
		end
		if passtexture and passtexture.textures[tex] then
			self:SetSubMaterial(k-1,passtexture.textures[tex])
		end
		if texture and texture.textures[tex] then
			self:SetSubMaterial(k-1,texture.textures[tex])
		end
	end
	self:SetNW2String("texture",self.Texture)
	self:SetNW2String("passtexture",self.PassTexture)
	self:SetNW2String("cabtexture",self.CabTexture)
end

--------------------------------------------------------------------------------
function ENT:Think()
	if self.ARSType then self.ARSType = nil end
	self.TextureTime = self.TextureTime or CurTime()
	if (CurTime() - self.TextureTime) > 1.0 then
		--print(1)
		self.TextureTime = CurTime()
		if self.Texture then
			for k,v in pairs(self:GetMaterials()) do
				if v:find("ewagon") then
					self:SetSubMaterial(k-1,self.Texture)
				else
					self:SetSubMaterial(k-1,"")
				end
			end
			self:SetNW2String("texture",self.Texture)
		end
	end
	self.RetVal = self.BaseClass.Think(self)

	-- Check if wrench was pulled out
	if self.DriversWrenchPresent then
		self.KV:TriggerInput("Enabled",self:IsWrenchPresent() and 1 or 0)
	end
	self:SetLightPower(1, self.Panel["HeadLights3"] > 0.5,(math.min(1,self.Panel["HeadLights1"])*0.50 +
						math.min(1,self.Panel["HeadLights2"])*0.25 +
						math.min(1,self.Panel["HeadLights3"])*0.25)
	)
	self:SetLightPower(2, self.Panel["HeadLights2"] > 0.5)
	self:SetLightPower(3, self.Panel["HeadLights2"] > 0.5)
	self:SetLightPower(4, self.Panel["HeadLights1"] > 0.5)
	self:SetLightPower(5, self.Panel["HeadLights1"] > 0.5)
	self:SetLightPower(6, self.Panel["HeadLights1"] > 0.5)
	--self:SetLightPower(7, self.Panel["HeadLights2"] > 0.5)
	-- Reverser lights
	self:SetLightPower(8, self.Panel["RedLightRight"] > 0.5)
	self:SetLightPower(9, self.Panel["RedLightLeft"] > 0.5)

	-- Interior/cabin lights
	self:SetLightPower(10, self.Panel["CabinLight"] > 0.5)

	local lightsActive2 = self.PowerSupply.XT3_4 > 65.0
	local lightsActive1 = self.Panel["EmergencyLight"] > 0.5 or lightsActive2
	self:SetPackedBool("Lamps_emer",lightsActive1)
	self:SetPackedBool("Lamps_full",lightsActive2)
	--local I = math.Round((self.Electric.I24-150)/1000.0,1.5)
	local Light
	if self.Pneumatic.Compressor == 1 then
		Light = (lightsActive2 and 0.6 or 0.3)
		--[[
		if I > 0 then
			Light = Light*(1-math.abs(I*0.1))
		end
		]]
		self:SetLightPower(11, lightsActive1, Light)
		self:SetLightPower(12, lightsActive1, Light)
		self:SetLightPower(13, lightsActive1, Light)
	else
		Light = (lightsActive2 and 0.8 or 0.4)
		--[[
		if I > 0 then
			Light = Light*(1-math.abs(I*0.1))
		end
		]]
		self:SetLightPower(11, lightsActive1, Light)
		self:SetLightPower(12, lightsActive1, Light)
		self:SetLightPower(13, lightsActive1, Light)
	end
	self:SetPackedRatio("LampsI",math.Round((self.Electric.I24-150)/1000.0,1.5))

	--[[local lightsActive2 = self.PowerSupply.XT3_4 > 65.0
	local lightsActive1 = self.Panel["EmergencyLight"] > 0.5
	self:SetPackedBool("Lamps",lightsActive2)
	local I = math.Round((self.Electric.I24-150)/1000.0,1.5)
	if self.Pneumatic.Compressor == 1 then
		local Light = 0.6
		if I > 0 then
			Light = Light*(1-math.abs(I*0.1))
		end
		self:SetLightPower(11, lightsActive2, Light)
		self:SetLightPower(12, lightsActive2, Light)
		self:SetLightPower(13, lightsActive2, Light)
	else
		local Light = 0.8
		if I > 0 then
			Light = Light*(1-math.abs(I*0.1))
		end
		self:SetLightPower(11, lightsActive2, Light)
		self:SetLightPower(12, lightsActive2, Light)
		self:SetLightPower(13, lightsActive2, Light)
	end]]
	--self:SetLightPower(12, lightsActive1,0.1 + ((self.PowerSupply.XT3_4 > 65.0) and 0.7 or 0))
	--self:SetLightPower(13, lightsActive2, 0.8)
	--for i = 1,23 do
		--self:SetLightPower(69+i,lightsActive2 and true or lightsActive1 and i%5==1 or false)
	--end
	--self:SetLightPower(12, self.Panel["EmergencyLight"] > 0.5)
	--self:SetLightPower(13, self.PowerSupply.XT3_4 > 65.0)

	-- Side lights
	self:SetLightPower(15, self.Panel["TrainDoors"] > 0.5)
	--self:SetLightPower(19, self.Panel["TrainDoors"] > 0.5)

	self:SetLightPower(16, self.Panel["GreenRP"] > 0.5)
	--self:SetLightPower(20, self.Panel["GreenRP"] > 0.5)

	self:SetLightPower(17, self.Panel["TrainBrakes"] > 0.5)
	--self:SetLightPower(21, self.Panel["TrainBrakes"] > 0.5)

	self:SetLightPower(32,self.L_3.Value > 0.5)
	self:SetLightPower(33,self.L_3.Value > 0.5)
	self:SetLightPower(34,self.L_3.Value > 0.5)
	self:SetLightPower(35,self.L_3.Value > 0.5)
	self:SetLightPower(36,self.L_3.Value > 0.5)
	self:SetLightPower(37,self.L_3.Value > 0.5)
	-- Total temperature
	local IGLA_Temperature = math.max(self.Electric.T1,self.Electric.T2)

	-- Switch and button states
	self:SetPackedBool(0,self:IsWrenchPresent())
	self:SetPackedBool(1,self.VUS.Value == 1.0)
	self:SetPackedBool(2,self.VozvratRP.Value == 1.0)
	self:SetPackedBool(3,self.DIPon.Value == 1.0)
	self:SetPackedBool(4,self.DIPoff.Value == 1.0)
	self:SetPackedBool(5,self.GV.Value == 1.0)
	self:SetPackedBool(7,self.VB.Value == 1.0)
	self:SetPackedBool(8,self.RezMK.Value == 1.0)
	self:SetPackedBool(9,self.KU1.Value == 1.0)
	self:SetPackedBool(10,self.VAH.Value == 1.0)
	self:SetPackedBool(11,self.VAD.Value == 1.0)
	self:SetPackedBool(12,self.VUD1.Value == 0.0)
	self:SetPackedBool(13,self.VUD2.Value == 1.0)
	self:SetPackedBool(14,self.VDL.Value == 1.0)
	self:SetPackedBool(15,self.KDL.Value == 1.0)
	self:SetPackedBool(16,self.KDP.Value == 1.0)
	self:SetPackedBool(17,self.KRZD.Value == 1.0)
	self:SetPackedBool(18,self.KSN.Value == 1.0)
	self:SetPackedBool(19,self.OtklAVU.Value == 1.0)
	self:SetPackedBool(20,self.Pneumatic.Compressor == 1.0)
	self:SetPackedBool(21,self.Pneumatic.LeftDoorState[1] > 0.5)
	self:SetPackedBool(22,self.Pneumatic.ValveType == 2)
	--self:SetPackedBool(22,self.Pneumatic.LeftDoorState[2] > 0.5)
	--self:SetPackedBool(23,self.Pneumatic.LeftDoorState[3] > 0.5)
	--self:SetPackedBool(24,self.Pneumatic.LeftDoorState[4] > 0.5)
	self:SetPackedBool(24,self.DURA.Power)
	self:SetPackedBool(25,self.Pneumatic.RightDoorState[1] > 0.5)
	--self:SetPackedBool(26,self.Pneumatic.RightDoorState[2] > 0.5)
	--self:SetPackedBool(27,self.Pneumatic.RightDoorState[3] > 0.5)
	self:SetPackedBool(27,self.KVWrenchMode == 2)
	--self:SetPackedBool(28,self.Pneumatic.RightDoorState[4] > 0.5)
	self:SetPackedBool(28,self.KVT.Value == 1.0)
	--self:SetPackedBool(156,self.KB.Value == 1.0)
	self:SetPackedBool(29,self.DURA.SelectAlternate == false)
	self:SetPackedBool(30,self.DURA.SelectAlternate == true)
	self:SetPackedBool(31,self.DURA.Channel == 2)
	self:SetPackedBool(56,self.ARS.Value == 1.0)
	self:SetPackedBool(57,self.ALS.Value == 1.0)
	self:SetPackedBool(58,self.Panel["CabinLight"] > 0.5)
	self:SetPackedBool(112,(self.RheostatController.Velocity ~= 0.0))
	self:SetPackedBool(114,self.Custom1.Value == 1.0)
	self:SetPackedBool(115,self.Custom2.Value == 1.0)
	self:SetPackedBool(116,self.Custom3.Value == 1.0)
	self:SetPackedBool(124,self.CustomC.Value == 1.0)
	--[[self:SetPackedBool(117,self.Custom4.Value == 1.0)
	self:SetPackedBool(118,self.Custom5.Value == 1.0)
	self:SetPackedBool(119,self.Custom6.Value == 1.0)
	self:SetPackedBool(120,self.Custom7.Value == 1.0)
	self:SetPackedBool(121,self.Custom8.Value == 1.0)
	self:SetPackedBool(122,self.CustomA.Value == 1.0)
	self:SetPackedBool(124,self.CustomC.Value == 1.0)]]--
--	self:SetLightPower(35,self.CustomD.Value == 1.0)
--	self:SetLightPower(36,self.CustomE.Value == 1.0)
--	self:SetLightPower(37,self.CustomF.Value == 1.0)
--	self:SetLightPower(38,self.CustomG.Value == 1.0)
	self:SetPackedBool(125,self.R_G.Value == 1.0)
	self:SetPackedBool(126,self.R_Radio.Value == 1.0)
	self:SetPackedBool(127,self.R_UNch.Value == 1.0)
	self:SetPackedBool(128,self.R_Program1.Value == 1.0)
	self:SetPackedBool(129,self.R_Program2.Value == 1.0)
	self:SetPackedBool(130,self.RC1.Value == 1.0)
	self:SetPackedBool(132,self.ManualBrake <= 0.001)
	self:SetPackedBool(133,self.ManualBrake >= 0.999)
	self:SetPackedBool(134,self.UOS.Value == 1.0)
	self:SetPackedBool(135,self.BPS.Value == 1.0)
	self:SetPackedBool(152,self.UAVA.Value == 1.0)
	self:SetPackedBool(153,self.DURA.Channel1Alternate)
	self:SetPackedBool(154,self.DURA.Channel2Alternate)
	self:SetPackedBool(156,self.RearDoor)
	self:SetPackedBool(157,self.FrontDoor)
	self:SetPackedBool(158,self.PassengerDoor)
	self:SetPackedBool(159,self.CabinDoor)
	self:SetPackedBool("DriverValveBLDisconnect",self.DriverValveBLDisconnect.Value == 1.0)
	self:SetPackedBool("DriverValveTLDisconnect",self.DriverValveTLDisconnect.Value == 1.0)
	self:SetPackedBool("EPK",self.EPK.Value == 1.0)

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
	self:WriteTrainWire(35,(self.Pneumatic.BrakeCylinderPressure > 0.1) and 1 or 0)

	-- DIP/power
	self:SetPackedBool(32,self.Panel["V1"] > 0.5)
	-- LxRK
	self:SetPackedBool(33,false)--self.RheostatController.MotorCoilState ~= 0.0)
	-- NR1
	self:SetPackedBool(34,(self.NR.Value == 1.0) or (self.RPU.Value == 1.0))
	-- Red RP
	local TW18 = self:GetTrainWire18()
	if self:ReadTrainWire(20) == 0 or (self.Panel["V1"] < 0.5) then TW18 = 0 end--(self.KV.ControllerPositionAutodrive == 0 and self.KV.ControllerPosition == 0)
	self:SetPackedBool(35,TW18 > 0.5)
	self:SetPackedBool(131,TW18 > 0)
	-- Green RP
	self:SetPackedBool(36,self.Panel["GreenRP"] > 0.5)
	-- Cabin heating
	self:SetPackedBool(37,self.Panel["KUP"] > 0.5)
	-- AVU
	self:SetPackedBool(38,self.Panel["AVU"] > 0.5)
	-- Ring
	self:SetPackedBool(39,self.Panel["Ring"] > 0.5)
	-- SD
	self:SetPackedBool(40,self.Panel["SD"] > 0.5)
	-- OCh
	self:SetPackedBool(41,self.ALS_ARS.NoFreq)
	-- 0
	self:SetPackedBool(42,self.ALS_ARS.Signal0)
	-- 40
	self:SetPackedBool(43,self.ALS_ARS.Signal40)
	-- 60
	self:SetPackedBool(44,self.ALS_ARS.Signal60)
	-- 75
	self:SetPackedBool(45,self.ALS_ARS.Signal70)
	-- 80
	self:SetPackedBool(46,self.ALS_ARS.Signal80)
	-- KT
	self:SetPackedBool(47,self.ALS_ARS.LKT)
	-- KVD
	self:SetPackedBool(48,self.ALS_ARS.LVD)
	-- LST
	self:SetPackedBool(49,self:ReadTrainWire(6) > 0.5)
	-- LVD
	self:SetPackedBool(50,self:ReadTrainWire(1) > 0.5)

	self:SetPackedBool(165,self.PB.Value > 0)

	-- AV states
	-- for i,v in ipairs(self.Panel.AVMap) do
		-- if tonumber(v)
		-- then self:SetPackedBool(64+(i-1),self["A"..v].Value == 1.0)
		-- elseif self[v] then self:SetPackedBool(64+(i-1),self[v].Value == 1.0)
		-- end
	-- end

	self:SetPackedBool(62,self.L_3.Value > 0.5)
	self:SetPackedBool(64+19,self.VU1.Value > 0.5)
	self:SetPackedBool(64+12,self.VU.Value > 0.5)
	self:SetPackedBool(64+24,self.RST.Value > 0.5)
	self:SetPackedBool(64+7  ,self.AV8B.Value > 0.5)
	self:SetPackedBool(64+36,self.VU2.Value > 0.5)
	self:SetPackedBool(64+13,self.VU3.Value > 0.5)
	self:SetPackedBool("VPR",self.RST.Value == 1.0 and self.Panel["V1"])
	-- Feed packed floats
	self:SetPackedRatio(0, 1-self.Pneumatic.DriverValvePosition/7)
	self:SetPackedRatio(1, (self.KV.ControllerPosition+3)/7)
	self:SetPackedRatio(2, 1-(self.KV.ReverserPosition+1)/2)
	if self.Pneumatic.ValveType == 1 then
		self:SetPackedRatio(4, self.Pneumatic.ReservoirPressure/12.0)
	else
		self:SetPackedRatio(4, self.Pneumatic.BrakeLinePressure/12.0)
	end
	self:SetPackedRatio(5, self.Pneumatic.TrainLinePressure/12.0)
	self:SetPackedRatio(6,  math.min(2.7,self.Pneumatic.BrakeCylinderPressure + 4.0*self.ManualBrake)/6.0)
	self:SetPackedRatio(7, self.Electric.Power750V/1000.0)
	self:SetPackedRatio(8, math.abs(self.Electric.I24)/1000.0)
	--self:SetPackedRatio(9, self.Pneumatic.BrakeLinePressure_dPdT or 0)
	if self.Pneumatic.TrainLineOpen then
		self:SetPackedRatio(9, (-self.Pneumatic.TrainLinePressure_dPdT or 0)*6)
	else
		self:SetPackedRatio(9, self.Pneumatic.BrakeLinePressure_dPdT or 0)
	end
	self:SetPackedRatio(10,(self.Panel["V1"] * self.Battery.Voltage) / 100.0)
	self:SetPackedRatio(11,IGLA_Temperature)

	-- Update ARS system
	self:SetPackedRatio(3, self.ALS_ARS.Speed/100.0)
	self:SetPackedRatio("Speed", self.Speed/120)
	if (self.ALS_ARS.Ring == true) then
		self:SetPackedBool(39,true)
	end

	-- RUT test
	local weightRatio = math.max(0,math.min(1,(self:GetNW2Float("PassengerCount")/300)))
	if math.abs(self:GetAngles().pitch) > 2.5 then weightRatio = weightRatio + 1.00 end
	self.YAR_13A:TriggerInput("WeightLoadRatio",math.max(0,math.min(1.00,weightRatio)))

	-- Exchange some parameters between engines, pneumatic system, and real world
	self.Engines:TriggerInput("Speed",self.Speed)
	if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and not self.IgnoreEngine then
		local A = 2*self.Engines.BogeyMoment
		self.FrontBogey.MotorForce = 30300+25000*(A < 0 and 1 or 0)
		self.FrontBogey.Reversed = (self.RKR.Value > 0.5)
		self.RearBogey.MotorForce  = 30300+25000*(A < 0 and 1 or 0)
		self.RearBogey.Reversed = (self.RKR.Value < 0.5)

		-- These corrections are required to beat source engine friction at very low values of motor power
		local P = math.max(0,0.04449 + 1.06879*math.abs(A) - 0.465729*A^2)
		if math.abs(A) > 0.4 then P = math.abs(A) end
		if math.abs(A) < 0.05 then P = 0 end
		if self.Speed < 10 then P = P*(1.0 + 0.5*(10.0-self.Speed)/10.0) end
		self.RearBogey.MotorPower  = P*0.5*((A > 0) and 1 or -1)
		self.FrontBogey.MotorPower = P*0.5*((A > 0) and 1 or -1)

		-- Apply brakes
		self.FrontBogey.PneumaticBrakeForce = 50000.0
		self.FrontBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure + 7.0*self.ManualBrake
		self.FrontBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
		self.FrontBogey.ParkingBrake = false
		self.RearBogey.PneumaticBrakeForce = 50000.0
		self.RearBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure + 7.0*self.ManualBrake
		self.RearBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
		--self.RearBogey.ParkingBrake = self.ManualBrake.Value > 0.5
	end

	-- Generate bogey sounds
	local jerk = math.abs((self.Acceleration - (self.PrevAcceleration or 0)) / self.DeltaTime)
	self.PrevAcceleration = self.Acceleration

	if jerk > (2.0 + self.Speed/15.0) then
		self.PrevTriggerTime1 = self.PrevTriggerTime1 or CurTime()
		self.PrevTriggerTime2 = self.PrevTriggerTime2 or CurTime()

		if ((math.random() > 0.00) or (jerk > 10)) and (CurTime() - self.PrevTriggerTime1 > 1.5) then
			self.PrevTriggerTime1 = CurTime()
			self.FrontBogey:EmitSound("subway_trains/chassis_"..math.random(1,3)..".wav", 70, math.random(90,110))
		end
		if ((math.random() > 0.00) or (jerk > 10)) and (CurTime() - self.PrevTriggerTime2 > 1.5) then
			self.PrevTriggerTime2 = CurTime()
			self.RearBogey:EmitSound("subway_trains/chassis_"..math.random(1,3)..".wav", 70, math.random(90,110))
		end
	end

	-- Temporary hacks
	--self:SetNW2Float("V",self.Speed)
	--self:SetNW2Float("A",self.Acceleration)

	return self.RetVal
end

--------------------------------------------------------------------------------
function ENT:OnButtonPress(button,ply)
	-- Parking brake
	if button == "ParkingBrakeLeft" then
		self.ManualBrake = math.max(0.0,(self.ManualBrake or 0) - 0.008)
		if self.ManualBrake == 0.0 then return end
		--print(self.ManualBrake)
	end
	if button == "ParkingBrakeRight" then
		self.ManualBrake = math.min(1.0,(self.ManualBrake or 0) + 0.008)
		if self.ManualBrake == 1.0 then return end
		--print(self.ManualBrake)
	end
	if string.find(button,"PneumaticBrakeSet") then
		self.Pneumatic:TriggerInput("BrakeSet",tonumber(button:sub(-1,-1)))
		return
	end
	if button:find("FrontDoor") then
		self.FrontDoor = not self.FrontDoor
		if self.FrontDoor then self:PlayOnce("door_open_tor","cabin") else self:PlayOnce("door_close_tor","cabin") end
	end
	if button:find("RearDoor") then
		self.RearDoor = not self.RearDoor
		if self.RearDoor then self:PlayOnce("door_open_tor") else self:PlayOnce("door_close_tor") end
	end
	if button:find("PassengerDoor") then
		self.PassengerDoor = not self.PassengerDoor
		if self.PassengerDoor then self:PlayOnce("door_open_tor","cabin") else self:PlayOnce("door_close_tor","cabin") end
	end
	if button:find("CabinDoor") then
		self.CabinDoor = not self.CabinDoor
		if self.CabinDoor then self:PlayOnce("door_open_tor","cabin") else self:PlayOnce("door_close_tor","cabin") end
	end
	if button == "VAHToggle" then
		local state = self.VAH.TargetValue < 0.5 and "enabled" or "disabled"
		RunConsoleCommand("say",ply:GetName().." "..state.." VAH!")
	end
	if button == "OtklAVUToggle" then
		local state = self.OtklAVU.TargetValue < 0.5 and "enabled" or "disabled"
		RunConsoleCommand("say",ply:GetName().." "..state.." OtklAVU!")
	end
	if button == "VADToggle" then
		local state = self.VAD.TargetValue < 0.5 and "enabled" or "disabled"
		RunConsoleCommand("say",ply:GetName().." "..state.." VAD!")
	end
	if button == "RC1Toggle" then
		local state = self.RC1.TargetValue < 0.5 and "enabled" or "disabled"
		RunConsoleCommand("say",ply:GetName().." "..state.." RC1!")
	end
	if button == "UOSToggle" then
		local state = self.UOS.TargetValue < 0.5 and "enabled" or "disabled"
		RunConsoleCommand("say",ply:GetName().." "..state.." UOS!")
	end
	if button == "UAVAToggle" then
		local state = self.UAVA.TargetValue < 0.5 and "enabled" or "disabled"
		RunConsoleCommand("say",ply:GetName().." "..state.." UAVA!")
	end
	if button == "BPSToggle" then
		local state = self.BPS.TargetValue < 0.5 and "enabled" or "disabled"
		RunConsoleCommand("say",ply:GetName().." "..state.." BPS!")
	end
	if button == "NextSign" then
		self:PrepareSigns()
		self.SignsIndex = self.SignsIndex + 1
		if self.SignsIndex > #self.SignsList then self.SignsIndex = 1 end

		self:SetNW2String("FrontText",self.SignsList[self.SignsIndex][2])
	end
	if button == "PrevSign" then
		self:PrepareSigns()
		self.SignsIndex = self.SignsIndex - 1
		if self.SignsIndex < 1 then self.SignsIndex = #self.SignsList end

		self:SetNW2String("FrontText",self.SignsList[self.SignsIndex][2])
	end

	if button == "Num1P" then
		if not self.RouteNumber then self.RouteNumber = "00" end
		local num = tonumber(self.RouteNumber[2])
		num = num + 1
		if num > 9 then num = 0 end
		self.RouteNumber = string.SetChar(self.RouteNumber,2, num)
		self:SetNW2String("RouteNumber",self.RouteNumber)
		local trn = self.WagonList[#self.WagonList]
		if IsValid(trn) and trn ~= self then
			trn.RouteNumber = self.RouteNumber
			trn:SetNW2String("RouteNumber",self.RouteNumber)
		end
	end
	if button == "Num1M" then
		if not self.RouteNumber then self.RouteNumber = "00" end
		local num = tonumber(self.RouteNumber[2])
		num = num - 1
		if num < 0 then num = 9 end
		self.RouteNumber = string.SetChar(self.RouteNumber,2, num)
		self:SetNW2String("RouteNumber",self.RouteNumber)
		local trn = self.WagonList[#self.WagonList]
		if IsValid(trn) and trn ~= self then
			trn.RouteNumber = self.RouteNumber
			trn:SetNW2String("RouteNumber",self.RouteNumber)
		end
	end
	if button == "Num2P" then
		if not self.RouteNumber then self.RouteNumber = "00" end
		local num = tonumber(self.RouteNumber[1])
		num = num + 1
		if num > 9 then num = 0 end
		self.RouteNumber = string.SetChar(self.RouteNumber,1, num)
		self:SetNW2String("RouteNumber",self.RouteNumber)
		local trn = self.WagonList[#self.WagonList]
		if IsValid(trn) and trn ~= self then
			trn.RouteNumber = self.RouteNumber
			trn:SetNW2String("RouteNumber",self.RouteNumber)
		end
	end
	if button == "Num2M" then
		if not self.RouteNumber then self.RouteNumber = "00" end
		local num = tonumber(self.RouteNumber[1])
		num = num - 1
		if num < 0 then num = 9 end
		self.RouteNumber = string.SetChar(self.RouteNumber,1, num)
		self:SetNW2String("RouteNumber",self.RouteNumber)
		local trn = self.WagonList[#self.WagonList]
		if IsValid(trn) and trn ~= self then
			trn.RouteNumber = self.RouteNumber
			trn:SetNW2String("RouteNumber",self.RouteNumber)
		end
	end

	-- Parking brake
	if button == "ManualBrakeLeft" then
		self.ManualBrake = math.max(0.0,self.ManualBrake - 0.008)
		if self.ManualBrake == 0.0 then return end
		--print(self.ManualBrake)
	end
	if button == "ManualBrakeRight" then
		self.ManualBrake = math.min(1.0,self.ManualBrake + 0.008)
		if self.ManualBrake == 1.0 then return end
		--print(self.ManualBrake)
	end

	if button == "KVUp" then
		if self.KV.ControllerPosition ~= -1 then
			self.KV:TriggerInput("ControllerUp",1.0)
		end
	end
	if button == "KVUp_Unlocked" then
		self.KV:TriggerInput("ControllerUp",1.0)
	end
	if button == "KVDown" then
		self.KV:TriggerInput("ControllerDown",1.0)
	end

	-- KRU
	if (self.KVWrenchMode == 2) and (button == "KVReverserUp") then
		self.KRU:TriggerInput("Up",1)
		self:OnButtonPress("KRUUp")
	end
	if (self.KVWrenchMode == 2) and (button == "KVReverserDown") then
		self.KRU:TriggerInput("Down",1)
		self:OnButtonPress("KRUDown")
	end
	if (self.KVWrenchMode == 2) and (button == "KVSetX1") then
		self.KRU:TriggerInput("SetX1",1)
		self:OnButtonPress("KRUSetX1")
	end
	if (self.KVWrenchMode == 2) and (button == "KVSetX2") then
		self.KRU:TriggerInput("SetX2",1)
		self:OnButtonPress("KRUSetX2")
	end
	if (self.KVWrenchMode == 2) and (button == "KVSetX3") then
		self.KRU:TriggerInput("SetX3",1)
		self:OnButtonPress("KRUSetX3")
	end
	if (self.KVWrenchMode == 2) and (button == "KVSet0") then
		self.KRU:TriggerInput("Set0",1)
		self:OnButtonPress("KRUSet0")
	end

	if button == "KVSetT1AB" then
		if self.KV.ControllerPosition == -2 then
			self.KV:TriggerInput("ControllerSet",-1)
			timer.Simple(0.20,function()
				self.KV:TriggerInput("ControllerSet",-2)
			end)
		else
			self.KV:TriggerInput("ControllerSet",-2)
		end
	end
	if button == "KVWrench0" then
		if self.KVWrenchMode == 3 or self.KVWrenchMode == 1 then
			if self.KVWrenchMode ~= 1 then
				self:PlayOnce("revers_in","cabin",0.7)
			end
			self.KVWrenchMode = 0
			self.DriversWrenchPresent = false
			self.DriversWrenchMissing = false
			self.KV:TriggerInput("Enabled",1)
			self.KRU:TriggerInput("Enabled",0)
		end
	end
	if button == "KVWrenchKV" then
		if self.KVWrenchMode == 3 or self.KVWrenchMode == 0 then
			if self.KVWrenchMode ~= 0 then
				self:PlayOnce("revers_in","cabin",0.7)
			end
			self.KVWrenchMode = 1
			self.DriversWrenchPresent = true
			self.DriversWrenchMissing = false
			self.KV:TriggerInput("Enabled",1)
			self.KRU:TriggerInput("Enabled",0)
		end
	end
	--THERE IS NO KRU IN THIS EZH MODEL
	--[[
	if button == "KVWrenchKRU" then
		if self.KVWrenchMode == 3 then
			self:PlayOnce("kru_in","cabin",0.7)
			self.KVWrenchMode = 2
			self.DriversWrenchPresent = false
			self.DriversWrenchMissing = true
			self.KV:TriggerInput("Enabled",0)
			self.KRU:TriggerInput("Enabled",1)
			self.KRU:TriggerInput("LockX3",1)
		end
	end]]
	if button == "KVWrenchNone" then
		if self.KVWrenchMode ~= 3 and self.KV.ReverserPosition == 0 then
			if self.KVWrenchMode == 2 then
				self:PlayOnce("kru_out","cabin",0.7)
			else
				self:PlayOnce("revers_out","cabin",0.7)
			end
			self.KVWrenchMode = 3
			self.DriversWrenchPresent = false
			self.DriversWrenchMissing = true
			self.KV:TriggerInput("Enabled",0)
			self.KRU:TriggerInput("Enabled",0)
		end
	end
	--if button == "KVT2Set" then self.KVT:TriggerInput("Close",1) end
	if button == "KDL" and self.VUD1.Value < 1 then self.KDL:TriggerInput("Close",1) self:OnButtonPress("KDLSet") end
	if button == "KDP" and self.VUD1.Value < 1 then self.KDP:TriggerInput("Close",1) self:OnButtonPress("KDPSet") end
	if button == "VDL" and self.VUD1.Value < 1 then self.VDL:TriggerInput("Close",1) self:OnButtonPress("VDLSet") end
	if button == "KRP" then
		self.KRP:TriggerInput("Set",1)
		self:OnButtonPress("KRPSet")
	end
	if button == "EmergencyBrake" then
		self.KV:TriggerInput("ControllerSet",-3)
		self.Pneumatic:TriggerInput("BrakeSet",7)
		self.DriverValveDisconnect:TriggerInput("Set",1)
		return
	end
	-- Special logic
	if (button == "VDL") or (button == "KDL") or (button == "KDP") then
		--self.VUD1:TriggerInput("Open",1)
	end
	if (button == "KDP") then
		--self.DoorSelect:TriggerInput("Close",1)
	end
	if (button == "VUD1Set") or (button == "VUD1Toggle") or
	   (button == "VUD2Set") or (button == "VUD2Toggle") then
		self.VDL:TriggerInput("Open",1)
		self.KDL:TriggerInput("Open",1)
		self.KDP:TriggerInput("Open",1)
	end

	if button == "GVToggle" then
		if self.GV.Value > 0.5 then
			self:PlayOnce("revers_f",nil,0.7)
		else
			self:PlayOnce("revers_b",nil,0.7)
		end
		return
	end


	if (button == "UAVAToggle") then
		if self.UAVA then
			if self.UAVA.Value > 0.5 then
				self:PlayOnce("uava_off","cabin")
			else
				self:PlayOnce("uava_off","cabin")
			end
		end
		return
	end

	if button == "DriverValveDisconnect" then
		if self.DriverValveBLDisconnect.Value == 0 or self.DriverValveTLDisconnect.Value == 0 then
			self.DriverValveBLDisconnect:TriggerInput("Set",1)
			self.DriverValveTLDisconnect:TriggerInput("Set",1)
		else
			self.DriverValveBLDisconnect:TriggerInput("Set",0)
			self.DriverValveTLDisconnect:TriggerInput("Set",0)
		end
		if self.DriverValveBLDisconnect.Value == 1.0 then
			if self.EPK.Value == 1 then self:PlayOnce("epv_off","cabin",0.9) end
		else
			if self.EPK.Value == 1 then self:PlayOnce("epv_on","cabin",0.9) end
		end
		return
	end

	if button == "DriverValveBLDisconnectToggle" then
		if self.DriverValveBLDisconnect.Value == 1.0 then
			if self.EPK.Value == 1 then self:PlayOnce("epv_off","cabin",0.9) end
		else
			if self.EPK.Value == 1 then self:PlayOnce("epv_on","cabin",0.9) end
		end
		return
	end
	if button == "EPKToggle" and self.DriverValveBLDisconnect.Value == 1.0 then
		if self.EPK.Value == 0.0 then
			self:PlayOnce("epv_off","cabin",0.9)
		else
			self:PlayOnce("epv_on","cabin",0.9)
		end
		return
	end
end

function ENT:OnButtonRelease(button)
	if string.find(button,"PneumaticBrakeSet") then
		return
	end
	--if button == "KVT2Set" then self.KVT:TriggerInput("Open",1) end
	if button == "KDL" and self.VUD1.Value < 1 then self.KDL:TriggerInput("Open",1) self:OnButtonRelease("KDLSet") end
	if button == "KDP" and self.VUD1.Value < 1 then self.KDP:TriggerInput("Open",1) self:OnButtonRelease("KDPSet") end
	if button == "VDL" and self.VUD1.Value < 1 then self.VDL:TriggerInput("Open",1) self:OnButtonRelease("VDLSet") end
	if button == "KRP" then
		self.KRP:TriggerInput("Set",0)
		self:OnButtonRelease("KRPSet")
	end

	--[[
	if (button == "PneumaticBrakeDown") and (self.Pneumatic.DriverValvePosition == 1) then
		self.Pneumatic:TriggerInput("BrakeSet",2)
	end
	if self.Pneumatic.ValveType == 1 then
		if (button == "PneumaticBrakeUp") and (self.Pneumatic.DriverValvePosition == 5) then
			self.Pneumatic:TriggerInput("BrakeSet",4)
		end
	end
	]]

	if (not string.find(button,"KVT")) and string.find(button,"KV") then return end
	if string.find(button,"KRU") then return end
end

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

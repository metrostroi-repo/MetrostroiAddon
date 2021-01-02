include("shared.lua")

--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false

--------------------------------------------------------------------------------
function ENT:Props81717()
	--if self.PropsInit then return end
	--self.PropsInit = true

	local function GetDoorPosition(i,k,j)
		if j == 0 
		then return Vector(349.0 - 32*k     - 230*i,-65*(1-2*k),-2.8)
		else return Vector(349.0 - 32*(1-k) - 230*i,-65*(1-2*k),-2.8)
		end
	end
	for i=0,3 do
		for k=0,1 do
			self.ClientProps["door"..i.."x"..k.."a"] = {
				model = "models/metrostroi/81/81-7036_door1.mdl",
				pos = GetDoorPosition(i,k,0),
				ang = Angle(0,180*(1-k),0)
			}
			self.ClientProps["door"..i.."x"..k.."b"] = {
				model = "models/metrostroi/81/81-7036_door2.mdl",
				pos = GetDoorPosition(i,k,1),
				ang = Angle(0,180*(1-k),0)
			}
		end
	end
	self.ClientProps["d1"] = {
		model = "models/metrostroi/81/81-7036_door4.mdl",
		pos = Vector(-487.0,-2.2,-4.5),
		ang = Angle(0,0,0)
	}
	self.ClientProps["d2"] = {
		model = "models/metrostroi/81/81-7036_door3.mdl",
		pos = Vector(414.0,65.0,-1.8),
		ang = Angle(0,0,0)
	}
	self.ClientProps["d3"] = {
		model = "models/metrostroi/81/81-7036_door5.mdl",
		pos = Vector(414.3,-65.0,-1.8),
		ang = Angle(0,0,0)
	}
end

function ENT:Think()
	self.BaseClass.Think(self)

	local trainType = self:GetNW2String("TrainType")
	if trainType == "81-717" and not self.ClientProps["d1"] then
		--self:Props81717()
	end
	
	-- Animate doors
	for i=0,3 do
		for k=0,1 do
			local n_l = "door"..i.."x"..k.."a"
			local n_r = "door"..i.."x"..k.."b"
			local animation = self:Animate(n_l,self:GetPackedBool(21+i+4-k*4) and 1 or 0,0,1, 0.8 + (-0.2+0.4*math.random()),0)
			local offset_l = Vector(math.abs(31*animation),0,0)
			local offset_r = Vector(math.abs(32*animation),0,0)
			if self.ClientEnts[n_l] and IsValid(self.ClientEnts[n_l]) then
				self.ClientEnts[n_l]:SetPos(self:LocalToWorld(self.ClientProps[n_l].pos + (1.0 - 2.0*k)*offset_l))
			end
			if self.ClientEnts[n_r] and IsValid(self.ClientEnts[n_r]) then
				self.ClientEnts[n_r]:SetPos(self:LocalToWorld(self.ClientProps[n_r].pos - (1.0 - 2.0*k)*offset_r))
			end
		end
	end

	-- Brake-related sounds
	local brakeLinedPdT = self:GetPackedRatio(9)
	local dT = self.DeltaTime
	self.BrakeLineRamp1 = self.BrakeLineRamp1 or 0

	if (brakeLinedPdT > -0.001)
	then self.BrakeLineRamp1 = self.BrakeLineRamp1 + 2.0*(0-self.BrakeLineRamp1)*dT
	else self.BrakeLineRamp1 = self.BrakeLineRamp1 + 2.0*((-0.4*brakeLinedPdT)-self.BrakeLineRamp1)*dT
	end
	self:SetSoundState("release2",self.BrakeLineRamp1,1.0)

	self.BrakeLineRamp2 = self.BrakeLineRamp2 or 0
	if (brakeLinedPdT < 0.001)
	then self.BrakeLineRamp2 = self.BrakeLineRamp2 + 2.0*(0-self.BrakeLineRamp2)*dT
	else self.BrakeLineRamp2 = self.BrakeLineRamp2 + 2.0*(0.02*brakeLinedPdT-self.BrakeLineRamp2)*dT
	end
	self:SetSoundState("release3",self.BrakeLineRamp2,1.0)

	-- Compressor
	local state = self:GetPackedBool(20)
	self.PreviousCompressorState = self.PreviousCompressorState or false
	if self.PreviousCompressorState ~= state then
		self.PreviousCompressorState = state
		if state then
			self:SetSoundState("compressor",1,1)
		else
			self:SetSoundState("compressor",0,0)
			self:PlayOnce("compressor_end",nil,0.75)		
		end
	end
	
	-- ARS/ringer alert
	local state = self:GetPackedBool(39)
	self.PreviousAlertState = self.PreviousAlertState or false
	if self.PreviousAlertState ~= state then
		self.PreviousAlertState = state
		if state then
			self:SetSoundState("ring",0.20,1)
		else
			self:SetSoundState("ring",0,0)
			self:PlayOnce("ring_end","cabin",0.45)		
		end
	end
	
	-- DIP sound
	self:SetSoundState("bpsn1",self:GetPackedBool(52) and 1 or 0,1.0)
end

function ENT:OnRemove()
	self.BaseClass.OnRemove(self)
	for k,v in pairs(self.ClientProps) do
		self.ClientProps[k] = nil
	end
	for k,v in pairs(self.ClientEnts) do
		v:Remove()
	end
	self.ClientEnts = nil
	self.ClientProps = {}
end
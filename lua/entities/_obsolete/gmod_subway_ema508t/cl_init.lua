include("shared.lua")


--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.ButtonMap["FrontPneumatic"] = {
	pos = Vector(460.0,-45.0,-50.0),
	ang = Angle(0,90,90),
	width = 900,
	height = 100,
	scale = 0.1,
}
ENT.ButtonMap["RearPneumatic"] = {
	pos = Vector(-483.0,45.0,-50.0),
	ang = Angle(0,270,90),
	width = 900,
	height = 100,
	scale = 0.1,
}
ENT.ButtonMap["Test1"] = {
	pos = Vector(460.0,-15,46.5),
	ang = Angle(0,90,90),
	width = 32,
	height = 96,
	scale = 1,
}
ENT.ButtonMap["AirDistributor"] = {
	pos = Vector(-180,70,-50),
	ang = Angle(0,180,90),
	width = 80,
	height = 40,
	scale = 0.1,
}

-- Wagon numbers
ENT.ButtonMap["TrainNumber1"] = {
	pos = Vector(30,-67.6,-12),
	ang = Angle(0,0,90),
	width = 130,
	height = 55,
	scale = 0.20,
}
ENT.ButtonMap["TrainNumber2"] = {
	pos = Vector(30+28,67.7,-12),
	ang = Angle(0,180,90),
	width = 130,
	height = 55,
	scale = 0.20,
}

--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false
ENT.ClientProps["train_line"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(447.10,-14.4,58),
	ang = Angle(90,0,180)
}
ENT.ClientProps["brake_line"] = {
	model = "models/metrostroi/81-717/red_arrow.mdl",
	pos = Vector(447.00,-14.4,58),
	ang = Angle(90,0,180)
}
ENT.ClientProps["brake_cylinder"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos =Vector(447.10,-18.8,57.9),
	ang = Angle(90,0,180)
}
--------------------------------------------------------------------------------
ENT.ClientProps["ampermeter"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(447.00,11.0,57.3),
	ang = Angle(90,0,180)
}
ENT.ClientProps["voltmeter"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(447.00,15.5,57.3),
	ang = Angle(90,0,180)
}
ENT.ClientProps["volt1"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(447.00,-9.7,58),
	ang = Angle(90,0,180)
}
--------------------------------------------------------------------------------
ENT.ClientProps["battery"] = {
	model = "models/metrostroi/81-717/switch01.mdl",
	pos = Vector(446.0,0.0,55),
	ang = Angle(90,0,180)
}
ENT.ClientProps["gv"] = {
	model = "models/metrostroi/81-717/gv.mdl",
	pos = Vector(154,62.5+1.5,-65),
	ang = Angle(-90,0,-90)
}
ENT.ClientProps["gv_wrench"] = {
	model = "models/metrostroi/81-717/reverser.mdl",
	pos = Vector(154,62.5+1.5,-65),
	ang = Angle(0,0,0)
}
--------------------------------------------------------------------------------
--[[for x=0,11 do
	for y=0,3 do
		ENT.ClientProps["a"..(x+12*y)] = {
			model = "models/metrostroi/81-717/circuit_breaker.mdl",
			pos = Vector(393.8,-52.5+x*2.75,37.5-y*8),
			ang = Angle(90,0,0)
		}
	end
end]]--
--[[Metrostroi.ClientPropForButton("battery",{
	panel = "Battery",
	button = "VBToggle",
	model = "models/metrostroi/81-717/switch01.mdl",
	z = -10.7,
})]]--

--------------------------------------------------------------------------------
-- Add doors
local function GetDoorPosition(i,k,j)
	if j == 0
	then return Vector(351.0 - 34*k     - 231*i,-65*(1-2*k),-2.8)
	else return Vector(351.0 - 34*(1-k) - 231*i,-65*(1-2*k),-2.8)
	end
end
for i=0,3 do
	for k=0,1 do
		ENT.ClientProps["door"..i.."x"..k.."a"] = {
			model = "models/metrostroi/e/em508_door1.mdl",
			pos = GetDoorPosition(i,k,0),
			ang = Angle(0,180*k,0)
		}
		ENT.ClientProps["door"..i.."x"..k.."b"] = {
			model = "models/metrostroi/e/em508_door2.mdl",
			pos = GetDoorPosition(i,k,1),
			ang = Angle(0,180*k,0)
		}
	end
end
ENT.ClientProps["door1"] = {
	model = "models/metrostroi/e/em508_door5.mdl",
	pos = Vector(455.5,0.5,-5),
	ang = Angle(0,0,0)
}
ENT.ClientProps["door2"] = {
	model = "models/metrostroi/e/em508_door5.mdl",
	pos = Vector(-479.5,.0,-5),
	ang = Angle(0,180,0)
}


ENT.FrontDoor = 0
ENT.RearDoor = 0
ENT.PassengerDoor = 0
ENT.CabinDoor = 0
--------------------------------------------------------------------------------

function ENT:UpdateTextures()
	local texture = Metrostroi.Skins["train"][self:GetNW2String("texture")]
	local passtexture = Metrostroi.Skins["pass"][self:GetNW2String("passtexture")]
	local cabintexture = Metrostroi.Skins["cab"][self:GetNW2String("cabtexture")]
	for _,ent in pairs(self.ClientEnts) do
		if not IsValid(ent) then continue end
		for k,v in pairs(ent:GetMaterials()) do
			local tex = string.Explode("/",v)
			tex = tex[#tex]
			if cabintexture and cabintexture.textures[tex] then
				ent:SetSubMaterial(k-1,cabintexture.textures[tex])
			end
			if passtexture and passtexture.textures[tex] then
				ent:SetSubMaterial(k-1,passtexture.textures[tex])
			end
			if texture and texture.textures[tex] then
				ent:SetSubMaterial(k-1,texture.textures[tex])
			end
		end
	end
end
--------------------------------------------------------------------------------
function ENT:Think()
	self.BaseClass.Think(self)
	if self.Texture ~= self:GetNW2String("texture") then
		self.Texture = self:GetNW2String("texture")
		self:UpdateTextures()
	end
	if self.PassTexture ~= self:GetNW2String("passtexture") then
		self.PassTexture = self:GetNW2String("passtexture")
		self:UpdateTextures()
	end
	if self.CabinTexture ~= self:GetNW2String("cabtexture") then
		self.CabinTexture = self:GetNW2String("cabtexture")
		self:UpdateTextures()
	end

	if self.RearDoor < 90 and self:GetPackedBool(156) or self.RearDoor > 0 and not self:GetPackedBool(156) then
		local RearDoorData = self.ClientProps["door2"]
		--RearDoor:SetLocalPos(RearDoorData.pos + Vector(-2,-0,0))
		self.RearDoor = math.max(0,math.min(90,self.RearDoor + (self:GetPackedBool(156)  and 1 or -1)*self.DeltaTime*180))
	end
	if not self.ClientPropsMatrix["door2"] or self.ClientPropsMatrix["door2"]:GetAngles().yaw ~= self.RearDoor then
		self:ApplyMatrix("door2",Vector(0,-16,0),Angle(0,self.RearDoor,0))
	end
	if self.FrontDoor < 90 and self:GetPackedBool(157) or self.FrontDoor > 0 and not self:GetPackedBool(157) then
		local FrontDoorData = self.ClientProps["door1"]
		--FrontDoor:SetLocalPos(FrontDoorData.pos + Vector(-2,-0,0))
		self.FrontDoor = math.max(0,math.min(90,self.FrontDoor + (self:GetPackedBool(157)  and 1 or -1)*self.DeltaTime*180))
		self:ApplyMatrix("door1",Vector(0,-16,0),Angle(0,self.FrontDoor,0))
	end
	if not self.ClientPropsMatrix["door1"] or self.ClientPropsMatrix["door1"]:GetAngles().yaw ~= self.FrontDoor then
		self:ApplyMatrix("door1",Vector(0,-16,0),Angle(0,self.FrontDoor,0))
	end
	local transient = (self.Transient or 0)*0.05
	if (self.Transient or 0) ~= 0.0 then self.Transient = 0.0 end

	-- Simulate pressure gauges getting stuck a little
	--self:Animate("brake", 			self:GetPackedRatio(0)^0.5, 		0.00, 0.65,  256,24)
	--self:Animate("controller",		self:GetPackedRatio(1),				0.30, 0.70,  384,24)
	--self:Animate("reverser",		1-self:GetPackedRatio(2),			0.25, 0.75,  4,false)
	self:Animate("volt1", 			self:GetPackedRatio(10),			0.38,0.64)
	--self:ShowHide("reverser",		self:GetPackedBool(0))

	self:Animate("brake_line",		self:GetPackedRatio(4),				0.16, 0.84,  256)--,,2,0.01)
	self:Animate("train_line",		self:GetPackedRatio(5)-transient,	0.16, 0.84,  256)--,,2,0.01)
	self:Animate("brake_cylinder",	self:GetPackedRatio(6),	 			0.17, 0.86,  256)--,,2,0.03)
	self:Animate("voltmeter",		self:GetPackedRatio(7),				0.38, 0.63)
	self:Animate("ampermeter",		self:GetPackedRatio(8),				0.38, 0.63)
	--self:Animate("volt2",			0, 									0.38, 0.63)

	self:Animate("battery",			self:GetPackedBool(7) and 1 or 0, 	0,1, 16, false)

	-- Animate AV switches
	for i,v in ipairs(self.Panel.AVMap) do
		local value = self:GetPackedBool(64+(i-1)) and 1 or 0
		self:Animate("a"..(i-1),value,0,1,8,false)
	end

	-- Main switch
	if self.LastValue ~= self:GetPackedBool(5) then
		self.ResetTime = CurTime()+2.0
		self.LastValue = self:GetPackedBool(5)
	end
	self:Animate("gv_wrench",	(self:GetPackedBool(5) and 1 or 0), 	0,0.51, 128,  1,false)
	self:ShowHide("gv_wrench",	CurTime() < self.ResetTime)

	-- Animate doors
	for i=0,3 do
		for k=0,1 do
			local n_l = "door"..i.."x"..k.."a"
			local n_r = "door"..i.."x"..k.."b"
			local animation = self:Animate(n_l,self:GetPackedBool(21+i+4-k*4) and 1 or 0,0,1, 0.8 + (-0.2+0.4*math.random()),0)
			local offset_l = Vector(math.abs(31*animation),0,0)
			local offset_r = Vector(math.abs(32*animation),0,0)
			if self.ClientEnts[n_l] then
				self.ClientEnts[n_l]:SetPos(self:LocalToWorld(self.ClientProps[n_l].pos + (1.0 - 2.0*k)*offset_l))
				self.ClientEnts[n_l]:SetSkin(self:GetSkin())
			end
			if self.ClientEnts[n_r] then
				self.ClientEnts[n_r]:SetPos(self:LocalToWorld(self.ClientProps[n_r].pos - (1.0 - 2.0*k)*offset_r))
				self.ClientEnts[n_r]:SetSkin(self:GetSkin())
			end
		end
	end
	if self.ClientEnts["door1"] then self.ClientEnts["door1"]:SetSkin(self:GetSkin()) end
	if self.ClientEnts["door2"] then self.ClientEnts["door2"]:SetSkin(self:GetSkin()) end


	-- Brake-related sounds
	local brakeLinedPdT = self:GetPackedRatio(9)
	local dT = self.DeltaTime
	self.BrakeLineRamp1 = self.BrakeLineRamp1 or 0

	if (brakeLinedPdT > -0.001)
	then self.BrakeLineRamp1 = self.BrakeLineRamp1 + 4.0*(0-self.BrakeLineRamp1)*dT
	else self.BrakeLineRamp1 = self.BrakeLineRamp1 + 4.0*((-0.6*brakeLinedPdT)-self.BrakeLineRamp1)*dT
	end
	self.BrakeLineRamp1 = math.Clamp(self.BrakeLineRamp1,0,1)
	self:SetSoundState("release2_w",self.BrakeLineRamp1^1.65,1.0)

	self.BrakeLineRamp2 = self.BrakeLineRamp2 or 0
	if (brakeLinedPdT < 0.001)
	then self.BrakeLineRamp2 = self.BrakeLineRamp2 + 4.0*(0-self.BrakeLineRamp2)*dT
	else self.BrakeLineRamp2 = self.BrakeLineRamp2 + 8.0*(0.1*brakeLinedPdT-self.BrakeLineRamp2)*dT
	end
	self.BrakeLineRamp2 = math.Clamp(self.BrakeLineRamp2,0,1)
	self:SetSoundState("release3_w",self.BrakeLineRamp2 + math.max(0,self.BrakeLineRamp1/2-0.15),1.0)

	self:SetSoundState("cran1_w",math.min(1,self:GetPackedRatio(4)/50*(self:GetPackedBool(6) and 1 or 0)),1.0)

	-- Compressor
	local state = self:GetPackedBool(20)
	self.PreviousCompressorState = self.PreviousCompressorState or false
	if self.PreviousCompressorState ~= state then
		self.PreviousCompressorState = state
		if 	state then
			self:SetSoundState("compressor_ezh",1,1)
		else
			self:SetSoundState("compressor_ezh",0,1)
			self:SetSoundState("compressor_ezh_end",0,1)
			self:SetSoundState("compressor_ezh_end",1,1)
			--self:PlayOnce("compressor_e_end",nil,1,nil,true)
		end
	end

	-- RK rotation
	if self:GetPackedBool(112) then self.RKTimer = CurTime() end
	local state = (CurTime() - (self.RKTimer or 0)) < 0.2
	self.PreviousRKState = self.PreviousRKState or false
	if self.PreviousRKState ~= state then
		self.PreviousRKState = state
		if state then
			self:SetSoundState("rk_spin",0.7,1,nil,0.75)
		else
			self:SetSoundState("rk_spin",0,0,nil,0.75)
			self:SetSoundState("rk_stop",0,1,nil,0.75)
			self:SetSoundState("rk_stop",0.7,1,nil,0.75)
		end
	end

	-- DIP sound
	--self:SetSoundState("bpsn1",self:GetPackedBool(52) and 1 or 0,1.0)
end

function ENT:Draw()
	self.BaseClass.Draw(self)
end

function ENT:DrawPost()
	self:DrawOnPanel("FrontPneumatic",function()
		draw.DrawText(self:GetNW2Bool("FbI") and "Isolated" or "Open","Trebuchet24",150,30,Color(0,0,0,255))
		draw.DrawText(self:GetNW2Bool("FtI") and "Isolated" or "Open","Trebuchet24",650,30,Color(0,0,0,255))
		draw.DrawText(self:GetPackedBool(160) and "Brake" or "Released","Trebuchet24",950,30,Color(0,0,0,255))
	end)
	self:DrawOnPanel("RearPneumatic",function()
		draw.DrawText(self:GetNW2Bool("RbI") and "Isolated" or "Open","Trebuchet24",150,30,Color(0,0,0,255))
		draw.DrawText(self:GetNW2Bool("RtI") and "Isolated" or "Open","Trebuchet24",650,30,Color(0,0,0,255))
	end)
	self:DrawOnPanel("AirDistributor",function()
		draw.DrawText(self:GetNW2Bool("AD") and "Air Distributor ON" or "Air Distributor OFF","Trebuchet24",0,0,Color(0,0,0,255))
	end)

	self:DrawOnPanel("AirDistributor",function()
		draw.DrawText(self:GetNW2Bool("AD") and "Air Distributor ON" or "Air Distributor OFF","Trebuchet24",0,0,Color(0,0,0,255))
	end)
	-- Draw train numbers
	local dc = render.GetLightColor(self:GetPos())
	self:DrawOnPanel("TrainNumber1",function()
		draw.DrawText(Format("%04d",self:EntIndex()),"MetrostroiSubway_LargeText3",0,0,Color(255*dc.x,255*dc.y,255*dc.z,255))
	end)
	self:DrawOnPanel("TrainNumber2",function()
		draw.DrawText(Format("%04d",self:EntIndex()),"MetrostroiSubway_LargeText3",0,0,Color(255*dc.x,255*dc.y,255*dc.z,255))
	end)
	--render.DrawLine( self:LocalToWorld(self.ClientProps["door1"].pos - Vector(0,16,0)), self:LocalToWorld(self.ClientProps["door1"].pos + Vector(0,16,0)), Color(0,0,255), false)
end

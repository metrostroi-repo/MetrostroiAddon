include("shared.lua")

hook.Add("PostDrawOpaqueRenderables", "metrostroi_sign_debug_draw", function(isDD)
		if isDD then return end
		if GetConVarNumber("metrostroi_drawsignaldebug") == 0 then return end
		--print(2)
		for _,self in pairs(ents.FindByClass("gmod_track_signs")) do
			local pos = self:LocalToWorld(Vector(0,0,0))
			local ang = self:LocalToWorldAngles(Angle(0,90,90))
			cam.Start3D2D(pos , ang, 0.25)
				surface.SetDrawColor(125, 125, 0, 255)
				surface.DrawRect(-40, -20, 80, 20)
			cam.End3D2D()
		end
end )

function ENT:Initialize()
	--self.ModelProp = self:GetNWInt("Model")
end

function ENT:OnRemove()
	self:RemoveModels()
	--self.LightType = 0
	--hook.Remove("PostDrawOpaqueRenderables")
end
function ENT:RemoveModels()
	SafeRemoveEntity(self.Model)
	self.Model = nil
end
function ENT:Think()
	self:NextThink(CurTime()+5)
	--if self.SendReq == nil or (self.SendReq and CurTime() - self.SendReq <= 0) then return true elseif self.SendReq then self.SendReq = false end
	if self:IsDormant() or Metrostroi and Metrostroi.ReloadClientside then
		if IsValid(self.Model) then
			self.Model:Remove()
			self.Model = nil
		end
		self.MustDraw = false
		return true
	else
		self.MustDraw = true
	end
	if self:GetNWInt("Type") ~= self.Type or self:GetNWBool("Left") ~= self.Left or self.Offset ~= self:GetNWVector("Offset") then
		self.Type = self:GetNWInt("Type")
		self.ModelProp = self.SignModels[self.Type-1]
		self.Left = self:GetNWBool("Left",false)
		if self.Left then
			self.Offset = self:GetNWVector("Offset")
		else
			self.Offset = self:GetNWVector("Offset")
		end
		self:RemoveModels()
	end
	if not self.ModelProp then return true end
	if not IsValid(self.Model) then
		--ents.CreateClientProp("models/metrostroi/81-717/reverser.mdl")
	    --hook.Add("MetrostroiBigLag",self.Model,function(ent)
		--		ent:SetPos(self:LocalToWorld(pos))
		--		ent:SetAngles(self:LocalToWorldAngles(ang))
	    --  --if ent.Spawned then hook.Remove("MetrostroiBigLag",ent) end
	    --  --ent.Spawned = true
	    --end)
		if self.Left and not self.ModelProp.noleft then
			if self.ModelProp.model:find("_r.mdl") then
				self.Model = ClientsideModel(self.ModelProp.model:Replace("_r.mdl","_l.mdl"), RENDERGROUP_OTHER)
				--self.Model:SetModel(self.ModelProp.model:Replace("_r.mdl","_l.mdl"))
			else
				self.Model = ClientsideModel(self.ModelProp.model:Replace("_l.mdl","_r.mdl"), RENDERGROUP_OTHER)
				--self.Model:SetModel(self.ModelProp.model:Replace("_l.mdl","_r.mdl"))
			end
		else
			self.Model = ClientsideModel(self.ModelProp.model, RENDERGROUP_OTHER)
			--self.Model:SetModel(self.ModelProp.model)
		end
		local RAND = math.random(-10,10)
		local pos = self.ModelProp.pos + self.Offset
		local ang = self.ModelProp.angles
		if not self.ModelProp.noauto then pos = pos+Vector(0,0,RAND/5); ang = ang+Angle(0,0,RAND) end
		if self.Left then pos = pos*Vector(1,-1,1) end
		if self.Left and self.ModelProp.rotate then ang = ang-Angle(0,180,0) end
		self.Model:SetParent(self)
		self.Model:SetPos(self:LocalToWorld(pos))
		self.Model:SetAngles(self:LocalToWorldAngles(ang))
	end
	return true
end

function ENT:Draw()
end

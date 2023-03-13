include("shared.lua")

local debug = GetConVar("metrostroi_drawsignaldebug")
local function enableDebug()
    if debug:GetBool() then
        hook.Add("PostDrawTranslucentRenderables","MetrostroiSignDebug",function(bDrawingDepth,bDrawingSkybox)
            for _,ent in pairs(ents.FindByClass("gmod_track_signs")) do
                if bDrawingDepth and LocalPlayer():GetPos():DistToSqr(sig:GetPos()) < 262144 then
                    local pos = sig:LocalToWorld(Vector(0,0,0))
                    local ang = sig:LocalToWorldAngles(Angle(0,90,90))
                    cam.Start3D2D(pos, ang, 0.25)
						surface.SetDrawColor(125, 125, 0, 255)
						surface.DrawRect(-40, -20, 80, 20)
                    cam.End3D2D()
                end
            end
        end)
    else
        hook.Remove("PostDrawTranslucentRenderables","MetrostroiSignDebug")
    end
end
hook.Remove("PostDrawTranslucentRenderables","MetrostroiSignDebug")
cvars.AddChangeCallback( "metrostroi_drawsignaldebug", enableDebug)
enableDebug()

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
	self:SetNextClientThink(CurTime()+5)
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
	if not self.ModelProp then
		self:SetNextClientThink(CurTime()+1)
		return true
	end
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
		if not self.ModelProp.noauto then
			pos = pos+Vector(0,0,RAND/5)
			if self.ModelProp.axis == 1 then
				ang = ang+Angle(RAND,0,0)
			elseif self.ModelProp.axis == 2 then
				ang = ang+Angle(0,RAND,0)
			else
			ang = ang+Angle(0,0,RAND)
			end
		end
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

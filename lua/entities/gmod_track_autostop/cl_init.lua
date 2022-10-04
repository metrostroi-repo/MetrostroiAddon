include("shared.lua")


function ENT:Initialize()
    self.Anims = {}
end

hook.Add("InitPostEntity","metrostroi autostop entity get animate signal",function()
	scripted_ents.GetStored("gmod_track_autostop").t.Animate = scripted_ents.GetStored("gmod_track_signal").t.Animate
end)

function ENT:Think()
    self:SetNextClientThink(CurTime() + 0.0333)
    local RealTime = RealTime()
    self.PrevTime = self.PrevTime or RealTime
    self.DeltaTime = (RealTime - self.PrevTime)
    self.PrevTime = RealTime
    if not self:GetNoDraw() then self:SetNoDraw(true) end
    if IsValid(self.ClientModel) then 
        self.ClientModel:SetPoseParameter("position",self:Animate("Autostop", self:GetNW2Bool("Autostop") and 1 or 0,     0,1, 0.4,false))
        return true
    end

    self.ClientModel = ClientsideModel(self.ModelPath,RENDERGROUP_OPAQUE)
    self.ClientModel:SetPos(self:LocalToWorld(self.Offset))
    self.ClientModel:SetAngles(self:GetAngles())
    self.ClientModel:SetParent(self)
    return true
end


function ENT:OnRemove()
    SafeRemoveEntity(self.ClientModel)
end

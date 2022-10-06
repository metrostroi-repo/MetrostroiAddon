include("shared.lua")


function ENT:Initialize()
    self.Anims = {}
end

hook.Add("InitPostEntity","metrostroi autostop entity get animate signal",function()
	scripted_ents.GetStored("gmod_track_autostop").t.Animate = scripted_ents.GetStored("gmod_track_signal").t.Animate
end)


local C_RenderDistance = GetConVar("metrostroi_signal_distance")
timer.Create("MetrostroiRenderAutostops",0.5,0,function()
    local plyPos = LocalPlayer():GetPos()
    local dist = C_RenderDistance:GetInt()^2
    for _,sig in pairs(ents.FindByClass("gmod_track_autostop")) do
        if not IsValid(sig) then continue end
        local sigPos = sig:GetPos()
        sig.RenderDisable = sigPos:DistToSqr(plyPos) > dist or math.abs(plyPos.z - sigPos.z) > 1500 or sig:IsDormant() or Metrostroi.ReloadClientside
    end
end)

function ENT:Think()
    self:SetNextClientThink(CurTime() + 0.0333)
    local RealTime = RealTime()
    self.PrevTime = self.PrevTime or RealTime
    self.DeltaTime = (RealTime - self.PrevTime)
    self.PrevTime = RealTime    

    if not self:GetNoDraw() then self:SetNoDraw(true) end
    
    if self.RenderDisable then
        if IsValid(self.ClientModel) then
            SafeRemoveEntity(self.ClientModel)
            self.ClientModel = nil 
            return true 
        end
        return
    end
    
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

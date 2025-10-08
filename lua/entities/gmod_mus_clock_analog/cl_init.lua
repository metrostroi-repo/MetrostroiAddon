include("shared.lua")

function ENT:Initialize()
    self.Arrows = {}
        self.OldSec = 0
        self.SecPull = CurTime()
end

function ENT:Think()
    for i=1,3 do
        if not IsValid(self.Arrows[i]) then
            local model = "models/metrostroi/signals/clock_analog_arrow_"..(i==1 and "h" or i==2 and "m" or "s")..".mdl"
            --self.Arrows[i] = ents.CreateClientProp("models/metrostroi/81-717/reverser.mdl")
            --self.Arrows[i]:SetModel( model )
            self.Arrows[i] = ClientsideModel(model,RENDERGROUP_OPAQUE)
            if not IsValid(self.Arrows[i]) then break end
            self.Arrows[i]:SetPos(self:GetPos())
            self.Arrows[i]:SetAngles(self:GetAngles())
            self.Arrows[i]:SetParent(self)
        end
    end
    local d = os.date("!*t",Metrostroi.GetSyncTime())
    if self.OldSec ~= d.sec then
        self:EmitSound("mus/clock_click"..math.random(1,8)..".wav",65,math.random(95,105),0.5)
        self.OldSec = d.sec
        self.SecPull = RealTime()+0.05
        if IsValid(self.Arrows[1]) then self.Arrows[1]:SetPoseParameter("position",(0.5+d.hour/24+d.min/1440)%1) end
        if IsValid(self.Arrows[2]) then self.Arrows[2]:SetPoseParameter("position",d.min/60+d.sec/3600) end
    end
    if IsValid(self.Arrows[3]) then
        if RealTime()-self.SecPull > 0 or d.sec < 30 then
            self.Arrows[3]:SetPoseParameter("position",d.sec/60)
        else
            self.Arrows[3]:SetPoseParameter("position",d.sec/60 +(d.sec-15)/60*0.002)
        end
    end

    --[[
        ]]
end

function ENT:OnRemove()
  for _,v in pairs(self.Arrows) do
        SafeRemoveEntity(v)
    end
end
function ENT:Draw()
    self:DrawModel()
end

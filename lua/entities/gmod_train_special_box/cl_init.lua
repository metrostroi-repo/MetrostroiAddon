include("shared.lua")

function ENT:Initialize()
    self.Digits = {}
end

function ENT:SpawnDigit(id,i)

    local cent = ClientsideModel(Format("models/metrostroi_train/reversor/revers_number0%d.mdl",id),RENDERGROUP_OPAQUE)
    cent:SetParent(self)
    cent:SetPos(self:LocalToWorld(Vector(-0.65+i*0.3,0.3,4.49+i*0.005)))
    cent:SetAngles(self:LocalToWorldAngles(Angle(-1,0,0)))
    self.Digits[i] = cent
end

function ENT:OnRemove()
    for i,v in pairs(self.Digits) do
        SafeRemoveEntity(v)
    end
    self.Digits = {}
end

function ENT:Think()
    if #self.Digits > 0 and self:GetModel()=="models/metrostroi_train/reversor/reversor_collection_box_empty.mdl" then
        self:OnRemove()
    end
    if self.Code ~= self:GetNW2Int("Code",-1) then
        self:OnRemove()
        self.Code = self:GetNW2Int("Code",-1)
        if self.Code>0 then
            for i=0,2 do
                local num = math.floor(self.Code%(10^(i+1))/10^i)
                self:SpawnDigit(num,i)
            end
        else
            self:OnRemove()
        end
    end
end
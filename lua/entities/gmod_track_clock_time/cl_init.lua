include("shared.lua")
ENT.DigitPositions = {
    {Vector(35,-8.5,0)},
    {Vector(22,-8.5,0)},
    {Vector(6,-8.5,0)},
    {Vector(-7,-8.5,0)},
    {Vector(-23,-8.5,0)},
    {Vector(-36,-8.5,0)},
    {Vector(15,-8.5,0),true},
    {Vector(-14,-8.5,0),true},
}

function ENT:Initialize()
        self.Digits = {}
end
function ENT:Think()
    if self:IsDormant() then self:OnRemove();return end
    for k,v in pairs(self.DigitPositions) do
        if not IsValid(self.Digits[k]) and (not v[2] or self:GetNW2Bool("Type") or not self:GetNW2Bool("Type") and k==7) then
            local model
            if v[2] then
                model = "models/metrostroi/mus_clock/ind_"..(self:GetNW2Bool("Type") and "spb" or "msk").."_type"..tostring(self:GetNW2Int("Light",1)).."_dot.mdl"
            else
                model = "models/metrostroi/mus_clock/ind_"..(self:GetNW2Bool("Type") and "spb" or "msk").."_type"..tostring(self:GetNW2Int("Light",1)).."_numb.mdl"
            end
            --self.Digits[k] = ents.CreateClientProp("models/metrostroi/81-717/reverser.mdl")
            --self.Digits[k]:SetModel(model)
            --hook.Add("MetrostroiBigLag",self.Digits[k],function(ent)
            --  ent:SetPos(self:LocalToWorld(v[1]))
            --  --if ent.Spawned then hook.Remove("MetrostroiBigLag",ent) end
            --  --ent.Spawned = true
            --end)
            self.Digits[k] = ClientsideModel(model,RENDERGROUP_OPAQUE)
            self.Digits[k]:SetPos(self:LocalToWorld(v[1]))
            self.Digits[k]:SetAngles(self:GetAngles())
            self.Digits[k]:SetSkin(10)
            self.Digits[k]:SetParent(self)
        end
    end

    local d = os.date("!*t",Metrostroi.GetSyncTime())
    if IsValid(self.Digits[1]) then self.Digits[1]:SetSkin(math.floor(d.hour / 10)) end
    if IsValid(self.Digits[2]) then self.Digits[2]:SetSkin(math.floor(d.hour % 10)) end
    if IsValid(self.Digits[3]) then self.Digits[3]:SetSkin(math.floor(d.min  / 10)) end
    if IsValid(self.Digits[4]) then self.Digits[4]:SetSkin(math.floor(d.min  % 10)) end
    if IsValid(self.Digits[5]) then self.Digits[5]:SetSkin(math.floor(d.sec  / 10)) end
    if IsValid(self.Digits[6]) then self.Digits[6]:SetSkin(math.floor(d.sec  % 10)) end
end
function ENT:OnRemove()
        for _,v in pairs(self.Digits) do
            SafeRemoveEntity(v)
        end
end
function ENT:Draw()
    self:DrawModel()
end

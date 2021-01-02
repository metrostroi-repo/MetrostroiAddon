include("shared.lua")
ENT.DigitPositions = {
    {Vector(0.1,0,0),"minus"},
    {Vector(0.1,0,0),"numb"},
    {Vector(0.1,6,0),"numb"},
    {Vector(0.1,0,0),"dots"},
    {Vector(0.1,13.28, 0),"numb"},
    {Vector(0.1,19.28,0),"numb"},
    {Vector(0.1,0,0),"station"},
}

function ENT:Initialize()
        self.Digits = {}
        self.Anims = {}
end

function ENT:Animate(clientProp, value, min, max, speed)
    local id = clientProp
    if not self.Anims[id] then
        self.Anims[id] = {}
        self.Anims[id].val = value
        self.Anims[id].V = 0.0
    end
    -- Prepare speed limiting
    local delta = math.abs(value - self.Anims[id].val)
    local max_speed = 1.5*delta / self.DeltaTime
    local max_accel = 0.5 / self.DeltaTime

    -- Simulate
    local dX2dT = (speed or 128)*(value - self.Anims[id].val) - self.Anims[id].V * (damping or 8.0)
    if dX2dT >  max_accel then dX2dT =  max_accel end
    if dX2dT < -max_accel then dX2dT = -max_accel end

    self.Anims[id].V = self.Anims[id].V + dX2dT * self.DeltaTime
    if self.Anims[id].V >  max_speed then self.Anims[id].V =  max_speed end
    if self.Anims[id].V < -max_speed then self.Anims[id].V = -max_speed end

    self.Anims[id].val = math.max(0,math.min(1,self.Anims[id].val + self.Anims[id].V * self.DeltaTime))

    -- Check if value got stuck
    if (math.abs(dX2dT) < 0.001) and stickyness and (self.DeltaTime > 0) then
        self.Anims[id].stuck = true
    end
    return min + (max-min)*self.Anims[id].val
end
function ENT:Think()
    self.PrevTime = self.PrevTime or RealTime()
    self.DeltaTime = (RealTime() - self.PrevTime)
    self.PrevTime = RealTime()
    if self:IsDormant() then self:OnRemove();return end
    for k,v in pairs(self.DigitPositions) do
        if not IsValid(self.Digits[k]) and (k>6 or (k>1 or self:GetNWInt("Time",0) < 0) and k<=6 and self:GetNWBool("Work",false)) then
            --self.Digits[k] = ents.CreateClientProp("models/metrostroi/81-717/reverser.mdl")
            --self.Digits[k]:SetModel("models/metrostroi/mus_clock/pui_ind_"..v[2]..".mdl")
            --hook.Add("MetrostroiBigLag",self.Digits[k],function(ent)
            --    ent:SetPos(self:LocalToWorld(v[1]))
            --    ent:SetAngles(self:GetAngles())
            --    --if ent.Spawned then hook.Remove("MetrostroiBigLag",ent) end
            --    --ent.Spawned = true
            --end)
            self.Digits[k] = ClientsideModel("models/metrostroi/mus_clock/pui_ind_"..v[2]..".mdl",RENDERGROUP_OPAQUE)
            self.Digits[k]:SetPos(self:LocalToWorld(v[1]))
            self.Digits[k]:SetAngles(self:GetAngles())
            self.Digits[k]:SetSkin(1)
            self.Digits[k]:SetParent(self)
        elseif IsValid(self.Digits[k]) and(
            (k>1 or self:GetNWInt("Time",0) >= 0 or not self:GetNWBool("Work",false))
            and k<=6 and (k == 1 or not self:GetNWBool("Work",false))) then
            SafeRemoveEntity(self.Digits[k])
        end
    end
    local lamp = self:Animate("Lamp",self:GetNWBool("Lamp",false) and 1 or 0,   0,1, 1024)
    if not IsValid(self.Digits[0]) and lamp > 0 then
        --self.Digits[0] = ents.CreateClientProp("models/metrostroi/81-717/reverser.mdl")
        --self.Digits[0]:SetModel("models/metrostroi/mus_clock/pui_lamp.mdl")
        --hook.Add("MetrostroiBigLag",self.Digits[0],function(ent)
        --    ent:SetPos(self:GetAttachment(self:LookupAttachment("lamp")).Pos)
        --    ent:SetAngles(self:GetAngles())
        --    --if ent.Spawned then hook.Remove("MetrostroiBigLag",ent) end
        --    --ent.Spawned = true
        --end)
        self.Digits[0] = ClientsideModel("models/metrostroi/mus_clock/pui_lamp.mdl",RENDERGROUP_OPAQUE)
        self.Digits[0]:SetPos(self:GetAttachment(self:LookupAttachment("lamp")).Pos)
        self.Digits[0]:SetAngles(self:GetAngles())
        self.Digits[0]:SetParent(self)
        self.Digits[0]:SetRenderMode( RENDERMODE_TRANSALPHA )
        self.Digits[0]:SetColor(Color(255,255,255,lamp*255))
    elseif IsValid(self.Digits[0]) and lamp > 0 then
        self.Digits[0]:SetColor(Color(255,255,255,lamp*255))
    elseif IsValid(self.Digits[0]) and lamp == 0 then
        SafeRemoveEntity(self.Digits[0])
    end
    if self:GetNWBool("Work",false) then
        local time = Format("%02d%02d",math.floor(math.abs((self:GetNWInt("Time"))/60)),math.abs(self:GetNWInt("Time"))%60)
        if IsValid(self.Digits[2]) then self.Digits[2]:SetSkin(time[1]) end
        if IsValid(self.Digits[3]) then self.Digits[3]:SetSkin(time[2]) end
        if IsValid(self.Digits[5]) then self.Digits[5]:SetSkin(time[3]) end
        if IsValid(self.Digits[6]) then self.Digits[6]:SetSkin(time[4]) end
    end
    if self:GetNWInt("Last",0) == 0 then
        if IsValid(self.Digits[7]) then self.Digits[7]:SetSkin(0) end
    else
        if IsValid(self.Digits[7]) then self.Digits[7]:SetSkin(self.StationConverter[self:GetNWInt("Last",0)] or 8) end
    end
end
function ENT:OnRemove()
        for _,v in pairs(self.Digits) do
            SafeRemoveEntity(v)
        end
end
function ENT:Draw()
    self:DrawModel()
end

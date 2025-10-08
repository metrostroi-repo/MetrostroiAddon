include("shared.lua")

ENT.DigitPositions = {
  {
        {Vector(7.61,-26.57,25.16),4,4},
        {Vector(7.59,-27.33,13.00),5,4},
    },
  {
    {Vector(7.41,-27.54,25.26),1,4},
    {Vector(7.41,-27.54,14.00),2,1},
        {Vector(7.43,4.46,25.26),3},
        {Vector(7.43,4.46,14.00),3},
    }
}
ENT.ModelNames = {
    "models/metrostroi/signals/mus/lamp_base.mdl",
    "models/metrostroi/signals/mus/lamp_base.mdl",
    "models/metrostroi/signals/mus/lamp_lens.mdl",
    "models/metrostroi/signals/mus/lamp_base_horlift_square.mdl",
    "models/metrostroi/signals/mus/lamp_base_horlift_dots.mdl",
}
function ENT:Initialize()
    self.Models = {}
    self.Anims = {}
end
function ENT:Animate(clientProp, value, min, max, speed, damping, stickyness)
    local id = clientProp
    if not self.Anims[id] then
        self.Anims[id] = {}
        self.Anims[id].val = value
        self.Anims[id].V = 0.0
    end
    --if self["_anim_old_"..id] == value then return self["_anim_old_"..id] end
    -- Generate sticky value
    if stickyness and damping then
        self.Anims[id].stuck = self.Anims[id].stuck or false
        self.Anims[id].P = self.Anims[id].P or value
        if (math.abs(self.Anims[id].P - value) < stickyness) and (self.Anims[id].stuck) then
            value = self.Anims[id].P
            self.Anims[id].stuck = false
        else
            self.Anims[id].P = value
        end
    end

    if damping == false then
        local dX = speed * self.DeltaTime
        if value > self.Anims[id].val then
            self.Anims[id].val = self.Anims[id].val + dX
        end
        if value < self.Anims[id].val then
            self.Anims[id].val = self.Anims[id].val - dX
        end
        if math.abs(value - self.Anims[id].val) < dX then
            self.Anims[id].val = value
        end
    else
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
    end
    --print(id,min + (max-min)*self.Anims[id].val,value, min + (max-min)*value)
    --self["_anim_old_"..id] = min + (max-min)*self.Anims[id].val
    return min + (max-min)*self.Anims[id].val
end
------
function ENT:AnimateFrom(clientProp,from)
    if IsValid(self.ClientEnts[clientProp]) then
        self.ClientEnts[clientProp]:SetPoseParameter("position",self.Anims[from].val)
    end
    return self.Anims[from].val
end

function ENT:OnRemove()
    self:RemoveModels()
end


function ENT:RemoveModels()
    if self.Models then
        for k,v in pairs(self.Models) do v:Remove() end
    end
    self.Models = {}
end
function ENT:Think()
  if self:IsDormant() then self:OnRemove();return end
    self.PrevTime = self.PrevTime or RealTime()
    self.DeltaTime = (RealTime() - self.PrevTime)
    self.PrevTime = RealTime()
    self.Type = self:GetNWInt("Type")
    self.YellowSignal = not self:GetNWBool("Yellow")
    self.WhiteSignal = not self:GetNWBool("White")
    self.PeopleGoing = not  self:GetNWBool("White2")
    if self.Type ~= self.OldType then
        if self.Models then
            for k,v in pairs(self.Models) do v:Remove() end
        end
        self.OldType = self.Type
    end
    for k,v in pairs(self.DigitPositions[self.Type+1]) do
        if not IsValid(self.Models[k]) then
            --self.Models[k] = ents.CreateClientProp("models/metrostroi/81-717/reverser.mdl")
            --self.Models[k]:SetModel(self.ModelNames[v[2]])
            --hook.Add("MetrostroiBigLag",self.Models[k],function(ent)
            --  ent:SetPos(self:LocalToWorld(v[1]))
            --  --if ent.Spawned then hook.Remove("MetrostroiBigLag",ent) end
            --  --ent.Spawned = true
            --end)
            self.Models[k] = ClientsideModel(self.ModelNames[v[2]],RENDERGROUP_OPAQUE)
            if not IsValid(self.Models[k]) then break end
            self.Models[k]:SetPos(self:LocalToWorld(v[1]))
            self.Models[k]:SetAngles(self:LocalToWorldAngles(Angle(v[2]==5 and 90 or 0,0,0)))
            if k < 3 then
                self.Models[k]:SetRenderMode(RENDERMODE_TRANSALPHA)
            end
            if v[3] then
                self.Models[k]:SetSkin(v[3])
            end
            self.Models[k]:SetParent(self)
        end
    end
    if self.Type == 0 then
        local State = self:Animate("white", self.WhiteSignal and 1 or 0,    0,1, 256)
        if IsValid(self.Models[1]) then
            self.Models[1]:SetColor(Color(255,255,255,State*255))
        end
        State = self:Animate("white1",  self.PeopleGoing and 1 or 0,    0,1, 256)
        if IsValid(self.Models[2]) then
            self.Models[2]:SetColor(Color(255,255,255,State*255))
        end
    else
        local State = self:Animate("white", self.WhiteSignal and 1 or 0,    0,1, 256)
        if IsValid(self.Models[1]) then
            self.Models[1]:SetColor(Color(255,255,255,State*255))
        end
        State = self:Animate("yellow",  self.YellowSignal and 1 or 0,   0,1, 256)
        if IsValid(self.Models[2]) then
            self.Models[2]:SetColor(Color(255,255,255,State*255))
        end
    end
end

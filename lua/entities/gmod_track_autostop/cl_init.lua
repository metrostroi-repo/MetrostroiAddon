include("shared.lua")


function ENT:Initialize()
    self.Anims = {}
end

function ENT:Animate(clientProp, value, min, max, speed, damping, stickyness)
    local id = clientProp
    if not self.Anims[id] then
        self.Anims[id] = {}
        self.Anims[id].val = value
        self.Anims[id].V = 0.0
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
    return min + (max-min)*self.Anims[id].val
end

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

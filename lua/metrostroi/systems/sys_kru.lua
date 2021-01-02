--------------------------------------------------------------------------------
-- Emergency controller
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("KRU")

function TRAIN_SYSTEM:Initialize()
    self.Enabled = 0
    self.LockX3 = 0
    self.Position = 0
    self.RealPosition = 0

    self.Matrix = {
        {"14/1",        "B3"    },
        {   0,  1,  1,  1       },
        {"1/3",         "ZM31"  },
        {   0,  1,  1,  1       },
        {"2/3",         "ZM31"  },
        {   0,  0,  1,  1       },
        {"5/3",         "ZM31"  },
        {   0,  1,  1,  1       },
        {"3/3",         "ZM31"  },
        {   0,  0,  0,  1       },
        {"20/3",        "ZM31"  },
        {   0,  1,  1,  1       },
        {"11/3",        "FR1"   },
        {   0,  1,  1,  1       },
        {"11/3",        "D1/1"  },
        {   0,  1,  1,  1       },
        {"15/2",        "D8"    },
        {   1,  0,  0,  0       },
    }

    -- Initialize contacts values
    for i=1,#self.Matrix/2 do
        local v = self.Matrix[i*2-1]
        self[v[1].."-"..v[2]] = 0
    end
end

function TRAIN_SYSTEM:Inputs()
    return { "LockX3", "Enabled", "Set", "Up", "Down", "SetX1", "SetX2", "SetX3", "Set0","14/1-B3" }
end

function TRAIN_SYSTEM:Outputs()
    return { "Position","14/1-B3" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    local prevReverserPosition = self.ReverserPosition
    -- Change position
    if name == "Enabled" then
        self.Enabled = math.floor(value)
    elseif name == "LockX3" then
        self.LockX3 = math.floor(value)
    elseif name == "Set" then
        if (self.Enabled ~= 0) and (math.floor(value) ~= self.Position) then
            local prevPosition = self.Position
            self.Position = math.floor(value)

            -- Limit motion
            if self.LockX3 == 0 then
                if self.Position > 3 then self.Position = 3 end
            else
                if self.Position > 2 then self.Position = 2 end
            end
            if self.Position < 0 then self.Position = 0 end
            --[[
            -- Play sounds
            if prevPosition < self.Position then
                local P,R = prevPosition,self.Position
                if P == 0 and R == 1 then self.Train:PlayOnce("kru_0_1", "cabin",0.9) end
                if P == 1 and R == 2 then self.Train:PlayOnce("kru_1_2", "cabin",0.9) end
            end

            if prevPosition > self.Position then
                local P,R = prevPosition,self.Position
                if P == 1 and R == 0 then self.Train:PlayOnce("kru_1_0", "cabin",0.9) end
                if P == 2 and R == 1 then self.Train:PlayOnce("kru_2_1", "cabin",0.9) end
            end
            ]]
        end
    elseif (name == "Up") and (value > 0.5) then
        self:TriggerInput("Set",self.Position+1)
    elseif (name == "Down") and (value > 0.5) then
        self:TriggerInput("Set",self.Position-1)
    elseif (name == "SetX1") and (value > 0.5) then
        self:TriggerInput("Set",1)
    elseif (name == "SetX2") and (value > 0.5) then
        self:TriggerInput("Set",2)
    elseif (name == "SetX3") and (value > 0.5) then
        self:TriggerInput("Set",3)
    elseif (name == "Set0") and (value > 0.5) then
        self:TriggerInput("Set",0)
    end
end


function TRAIN_SYSTEM:Think()
    local Train = self.Train
    if (self.Enabled == 0) and (self.Position ~= 0) then
        self.Position = 0
    end

    -- Move controller
    self.Timer = self.Timer or CurTime()
    if ((CurTime() - self.Timer > 0.15) and (self.Position > self.RealPosition)) then
        local P,R = self.RealPosition,self.Position
        if P == 0 and R == 1 then self.Train:PlayOnce("kru_0_1", "cabin",0.9) end
        if P == 1 and R == 2 then self.Train:PlayOnce("kru_1_2", "cabin",0.9) end
        if P == 2 and R == 3 then self.Train:PlayOnce("kru_2_3", "cabin",0.9) end
        self.Timer = CurTime()
        self.RealPosition = self.RealPosition + 1
            -- Play sounds
    end
    if ((CurTime() - self.Timer > 0.15) and (self.Position < self.RealPosition)) then
        local P,R = self.RealPosition,self.Position
        if P == 1 and R == 0 then self.Train:PlayOnce("kru_1_0", "cabin",0.9) end
        if P == 2 and R == 1 then self.Train:PlayOnce("kru_2_1", "cabin",0.9) end
        if P == 3 and R == 2 then self.Train:PlayOnce("kru_3_2", "cabin",0.9) end
        self.Timer = CurTime()
        self.RealPosition = self.RealPosition - 1
    end

    -- Update contacts
    for i=1,#self.Matrix/2 do
        local v = self.Matrix[i*2-1]
        local d = self.Matrix[i*2]
        self[v[1].."-"..v[2]] = d[self.RealPosition+1]
    end
end

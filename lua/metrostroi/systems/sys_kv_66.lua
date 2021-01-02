--------------------------------------------------------------------------------
-- KV-66 controller
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("KV_66")

function TRAIN_SYSTEM:Initialize()
    self.Enabled = 1
    self.RCU = 1
    self.ControllerPosition = 0
    self.ReverserPosition = 0
    self.RealControllerPosition = 0
    self.ChangeSpeed = 0.10

    self.ReverserMatrix = {
        { "U2"   , "4"  },
        {   1,  0,  0   },
        { "U2"   , "5"  },
        {   0,  0,  1   },
        { "D"   , "D1"  },
        {   1,  0,  1   },
        { "B2"   , "F1" },
        {   1,  1,  0   },
        { "10"   , "14A"},
        {   1,  1,  0   },
        { "0"   ,  "4"  },
        {   0,  0,  1   },
        { "F"   , "F7"  },
        {   0,  0,  1   },
        { "7D"  , "7G"  },
        {   1,  0,  1   },
    }
    self.ControllerMatrix = {
        {"10",                      "8" },
        {   1,  0,  0,  0,  0,  0,  0   },
        {"U2",                      "10AK"},
        {   1,  1,  1,  0,  1,  1,  1   },
        {"U2",                      "2" },
        {   1,  1,  0,  0,  0,  1,  1   },
        {"U2",                      "3" },
        {   0,  0,  0,  0,  0,  0,  1   },
        {"33",                      "10AK"},
        {   0,  0,  0,  0,  1,  1,  1     },
        {"10AK",                       "1"},
        {   0,  0,  0,  1,  1,  1,  1   },
        {"U2",                      "6"   },
        {   1,  1,  1,  0,  0,  0,  0     },
        {"U2",                      "20"},
        {   1,  1,  1,  0,  1,  1,  1   },
        {"6",                       "25"},
        {   0,  1,  0,  0,  0,  0,  0   },
        {"10AK",                    "17"},
        {   0,  0,  0,  1,  0,  0,  0   },
        {"15A",                     "15B"},
        {   1,  1,  1,  1,  0,  0,  0   },
        {"14A",                     "14B"},
        {   0,  0,  0,  1,  1,  1,  1   },
    }

    -- Initialize contacts values
    for i=1,#self.ReverserMatrix/2 do
        local v = self.ReverserMatrix[i*2-1]
        self[v[1].."-"..v[2]] = 0
    end
    for i=1,#self.ControllerMatrix/2 do
        local v = self.ControllerMatrix[i*2-1]
        self[v[1].."-"..v[2]] = 0
    end
end

function TRAIN_SYSTEM:Inputs()
    return { "Enabled", "RCU","ControllerSet", "ReverserSet",
             "ControllerUp","ControllerDown","ReverserUp","ReverserDown",
             "SetX1", "SetX2", "SetX3", "Set0", "Set0Fast", "SetT1", "SetT1A", "SetT2",}
end

function TRAIN_SYSTEM:Outputs()
    return { "ControllerPosition","RealControllerPosition", "ReverserPosition", "10AS-33","D4-15","RCU" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    local prevReverserPosition = self.ReverserPosition
    -- Change position
    if name == "Type" then
        self.Type = math.floor(value)
    elseif name == "Enabled" then
        self.Enabled = math.floor(value)
    elseif name == "RCU" then
        if self.RCU ~= math.floor(value) then
            self.RCU = math.floor(value)
            self.Train:PlayOnce(self.RCU==1 and "rcu_on" or "rcu_off", "cabin",0.9)
        end
    elseif name == "ControllerSet" then
        if (self.Enabled ~= 0) and (self.ReverserPosition ~= 0) and (math.floor(value) ~= self.ControllerPosition) then
            local prevControllerPosition = self.ControllerPosition
            self.ControllerPosition = math.floor(value)

            -- Limit motion
            if self.ControllerPosition >  3 then self.ControllerPosition =  3 end
            if self.ControllerPosition < -3 then self.ControllerPosition = -3 end
        end
    elseif name == "ReverserSet" then
        if (self.Enabled ~= 0) and (math.floor(value) ~= self.ReverserPosition) and self.ControllerPosition == 0 then
            local prevReverserPosition = self.ReverserPosition
            self.ReverserPosition = math.floor(value)
            if self.ReverserPosition >  1 then self.ReverserPosition =  1 end
            if self.ReverserPosition < -1 then self.ReverserPosition = -1 end
            if prevReverserPosition ~= self.ReverserPosition then
                if self.ReverserPosition == -1 then self.Train:PlayOnce("ezh3_revers_0-b","cabin",1) end
                if self.ReverserPosition == 0  then
                    if prevReverserPosition == -1 then
                        self.Train:PlayOnce("ezh3_revers_b-0","cabin",1)
                    else
                        self.Train:PlayOnce("ezh3_revers_f-0","cabin",1)
                    end
                end
                if self.ReverserPosition == 1  then self.Train:PlayOnce("ezh3_revers_0-f","cabin",1) end
            end
        end
    elseif (name == "ControllerUp") and (value > 0.5) then
        self:TriggerInput("ControllerSet",self.ControllerPosition+1)
        self.Timer = CurTime()-self.ChangeSpeed
        self.SecondSound = true
    elseif (name == "ControllerDown") and (value > 0.5) then
        self:TriggerInput("ControllerSet",self.ControllerPosition-1)
        self.Timer = CurTime()-self.ChangeSpeed
        self.SecondSound = true
        elseif (name == "ReverserUp") and (value > 0.5) then
        self:TriggerInput("ReverserSet",self.ReverserPosition+1)
    elseif (name == "ReverserDown") and (value > 0.5) then
        self:TriggerInput("ReverserSet",self.ReverserPosition-1)
    elseif (name == "SetX1") and (value > 0.5) then
        self:TriggerInput("ControllerSet",1)
    elseif (name == "SetX2") and (value > 0.5) then
        self:TriggerInput("ControllerSet",2)
    elseif (name == "SetX3") and (value > 0.5) then
        self:TriggerInput("ControllerSet",3)
    elseif (name == "Set0") and (value > 0.5) then
        self:TriggerInput("ControllerSet",0)
    elseif (name == "Set0Fast") and (value > 0.5) then
        self:TriggerInput("ControllerSet",0)
        self.ChangeSpeed = 0.05
    elseif (name == "SetT1") and (value > 0.5) then
        self:TriggerInput("ControllerSet",-1)
    elseif (name == "SetT1A") and (value > 0.5) then
        self:TriggerInput("ControllerSet",-2)
    elseif (name == "SetT2") and (value > 0.5) then
        self:TriggerInput("ControllerSet",-3)
    end
end


function TRAIN_SYSTEM:Think()
    local Train = self.Train

    if (self.Enabled == 0) and (self.ReverserPosition ~= 0) then
        self.ReverserPosition = 0
        self.ControllerPosition = 0
    end
    if (self.ReverserPosition == 0) and (self.ControllerPosition ~= 0) then
        self.ReverserPosition = 0
        self.ControllerPosition = 0
    end

    -- Move controller
    self.Timer = self.Timer or CurTime()
    if ((CurTime() - self.Timer > self.ChangeSpeed) and (self.ControllerPosition > self.RealControllerPosition)) then
        local previousPosition = self.RealControllerPosition
        self.Timer = CurTime()
        self.RealControllerPosition = self.RealControllerPosition + 1

        local A,B = previousPosition,self.RealControllerPosition

        if (A == -3) and (B == -2) then self.Train:PlayOnce("kv66_t2_t1a",  "cabin",1) end
        if (A == -2) and (B == -1) then self.Train:PlayOnce("kv66_t1a_t1",  "cabin",1) end
        if self.SecondSound and (A == -1) and (B ==  0) then self.Train:PlayOnce("kv66_t1_0",  "cabin",1) end
        if not self.SecondSound and (A == -1) and (B ==  0) then self.Train:PlayOnce("kv66_t1_0",  "cabin",1) end

        if (A ==  0) and (B ==  1) then self.Train:PlayOnce("kv66_0_x1", "cabin",1) end
        if (A ==  1) and (B ==  2) then self.Train:PlayOnce("kv66_x1_x2", "cabin",1) end
        if (A ==  2) and (B ==  3) then self.Train:PlayOnce("kv66_x2_x3", "cabin",1) end
        self.SecondSound = nil
    end
    if ((CurTime() - self.Timer > self.ChangeSpeed) and (self.ControllerPosition < self.RealControllerPosition)) then
        local previousPosition = self.RealControllerPosition
        self.Timer = CurTime()
        self.RealControllerPosition = self.RealControllerPosition - 1

        local A,B = previousPosition,self.RealControllerPosition
        if (A ==  3) and (B ==  2) then self.Train:PlayOnce("kv66_x3_x2", "cabin",0.9) end
        if (A ==  2) and (B ==  1) then self.Train:PlayOnce("kv66_x2_x1", "cabin",0.9) end
        if (A ==  1) and (B ==  0) then self.Train:PlayOnce("kv66_x1_0", "cabin",0.9) end

        if (A ==  0) and (B == -1) then self.Train:PlayOnce("kv66_0_t1",  "cabin",0.8) end
        if (A == -1) and (B == -2) then self.Train:PlayOnce("kv66_t1_t1a",  "cabin",0.8) end
        if (A == -2) and (B == -3) then self.Train:PlayOnce("kv66_t1a_t2",  "cabin",0.8) end
        self.SecondSound = nil
    end
    if self.RealControllerPosition == 0 then self.ChangeSpeed = 0.10 end
    local position = self.RealControllerPosition
    -- Update contacts
    for i=1,#self.ReverserMatrix/2 do
        local v = self.ReverserMatrix[i*2-1]
        local d = self.ReverserMatrix[i*2]
        self[v[1].."-"..v[2]] = d[self.ReverserPosition+2]
    end
    for i=1,#self.ControllerMatrix/2 do
        local v = self.ControllerMatrix[i*2-1]
        local d = self.ControllerMatrix[i*2]
        self[v[1].."-"..v[2]] = d[(position)+4]
    end
end

--------------------------------------------------------------------------------
-- 81-718 controller reverser
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_718_KR")

function TRAIN_SYSTEM:Initialize()
    self.Position = 0

    self.Matrix = {
        {"317B"  , "386"},
        {  1,   0,   0  },
        {"317B"  , "388"},
        {  0,   0,   1  },
        {"317A"  , "387"},
        {  0,   1,   0  },
        {"320"   ,"320A"},
        {  0,   1,   0  },
        {"319"   , "369"},
        {  1,   0,   1  },
        {"673"   ,"673A"},
        {  1,   0,   1  },
        {"673"   , "679"},
        {  1,   0,   1  },
    }

    -- Initialize contacts values
    for i=1,#self.Matrix/2 do
        local v = self.Matrix[i*2-1]
        self[v[1].."-"..v[2]] = 0
    end
end

function TRAIN_SYSTEM:Inputs()
    return { "Set" }
end

function TRAIN_SYSTEM:Outputs()
    return { "Position" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    local prevPosition = self.Position
    -- Change position
    if name == "Set" then
        if (math.floor(value) ~= self.Position) then
            local prevPosition = self.Position
            self.Position = math.floor(value)
            if self.Position >  1 then self.Position =  1 end
            if self.Position < -1 then self.Position = -1 end
            if prevPosition ~= self.Position then
                self.Train:PlayOnce("kr_"..prevPosition.."_"..self.Position,"cabin",1)
            end
        end
    end
end


function TRAIN_SYSTEM:Think()
    for i=1,#self.Matrix/2 do
        local v = self.Matrix[i*2-1]
        local d = self.Matrix[i*2]
        self[v[1].."-"..v[2]] = d[self.Position+2]
    end
end

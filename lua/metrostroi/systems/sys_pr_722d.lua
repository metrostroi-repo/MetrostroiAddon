--------------------------------------------------------------------------------
-- Reverser (PR-722D)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PR_722D")

function TRAIN_SYSTEM:Initialize()
    self.Position = 0
    --Contacts
    self.VP = 0
    self.NZ = 0

    --Setters
    self.VPS = 0
    self.NZS = 0

    --Parameters
    self.Speed = 0
    self.RotationRate = 2
end

function TRAIN_SYSTEM:Inputs()
    return {"VP","NZ"}
end
function TRAIN_SYSTEM:Outputs()
    return {"VP","NZ","VPS","NZS","Speed","Position"}
end
local min = math.min
local max = math.max
function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "VP" then self.VPS = max(0,min(1,value)) end
    if name == "NZ" then self.NZS = max(0,min(1,value)) end
end
function TRAIN_SYSTEM:Think(dT)
    -- Move reversor
    if self.VPS == 0 and self.NZS == 0 then
        self.Speed = 0
    else
        self.Speed = math.max(-1,math.min(1,self.Speed+dT*(self.VPS-self.NZS)*0.9))
    end
    self.Position = math.max(0,math.min(1,self.Position + self.RotationRate*self.Speed))
    if self.OldVP ~= self.VP then
        self.OldVP = self.VP
        self.Train:PlayOnce("RKR","bass",1,1)
    end
    self.NZ = self.Position <  0.5 and 1 or 0
    self.VP = self.Position >= 0.5 and 1 or 0
end

--------------------------------------------------------------------------------
-- 81-720 reverser
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_720_RV")

TRAIN_SYSTEM.KROMatrix = {
    {"KRO9",   "10"},
    {   1 , 0,  1 },
    {"KRO11",  "12"},
    {   0,  0,  1 },
    {"KRO15",   "16"},
    {   1,  0,  0 },
    {"KRO13",  "14"},
    {   1,  0,  1 },
    {"KRO1",   "2" },
    {   1,  0,  1 },
    {"KRO5",   "6" },
    { 0,  1,  0 },
    {"KRO3",   "4" },
    { 0,  0,  1 },
    {"KRO7",   "8" },
    { 1,  1,  0 },
}
TRAIN_SYSTEM.KRRMatrix = {
    {"KRR7",   "8" },
    { 1,  0,  1 },
    {"KRR3",   "4" },
    { 0,  0,  1 },
    {"KRR13",  "14"},
    {   1,  0,  0 },
    {"KRR11",  "12"},
    {   1,  0,  1 },
    {"KRR1",   "2" },
    {   1,  0,  1 },
    {"KRR15",   "16"},
    {   1,  0,  1 },
    {"KRR5",   "6" },
    { 0,  0,  1 },
    {"KRR9",   "10"},
    {   1 , 0,  0 },
}
function TRAIN_SYSTEM:Initialize()
    self.KROPosition = 0
    self.KRRPosition = 0
    self.ChangeSpeed = 0.10

    -- Initialize contacts values
    for i=1,#self.KROMatrix/2 do
        local v = self.KROMatrix[i*2-1]
        self[v[1].."-"..v[2]] = 0
    end
    for i=1,#self.KRRMatrix/2 do
        local v = self.KRRMatrix[i*2-1]
        self[v[1].."-"..v[2]] = 0
    end
end

function TRAIN_SYSTEM:Inputs()
    return { "KROSet", "KRRSet", }
end
local outputs = { "KROPosition","KRRPosition"}
for i=1,#TRAIN_SYSTEM.KROMatrix/2 do
    local v = TRAIN_SYSTEM.KROMatrix[i*2-1]
    table.insert(outputs,v[1].."-"..v[2])
end
for i=1,#TRAIN_SYSTEM.KRRMatrix/2 do
    local v = TRAIN_SYSTEM.KRRMatrix[i*2-1]
    table.insert(outputs,v[1].."-"..v[2])
end
function TRAIN_SYSTEM:Outputs()
    return outputs
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    local prevKROPosition = self.KROPosition
    -- Change position
    if name == "KROSet" then
        if (self.Enabled ~= 0) and (math.floor(value) ~= self.KROPosition) then
            local prevKROPosition = self.KROPosition
            self.KROPosition = math.floor(value)
            if self.KROPosition >  1 then self.KROPosition =  1 end
            if self.KROPosition < -1 then self.KROPosition = -1 end
            if prevKROPosition ~= self.KROPosition then
                self.Train:PlayOnce("kro_"..prevKROPosition.."_"..self.KROPosition,"cabin",1)
            end
        end
    end
    if name == "KRRSet" then
        if (self.Enabled ~= 0) and (math.floor(value) ~= self.KRRPosition) then
            local prevKRRPosition = self.KRRPosition
            self.KRRPosition = math.floor(value)
            if self.KRRPosition >  1 then self.KRRPosition =  1 end
            if self.KRRPosition < -1 then self.KRRPosition = -1 end
            if prevKRRPosition ~= self.KRRPosition then
                self.Train:PlayOnce("krr_"..prevKRRPosition.."_"..self.KRRPosition,"cabin",1)
            end
        end
    end
end


function TRAIN_SYSTEM:Think()
    local Train = self.Train
    -- Move controller
    self.Timer = self.Timer or CurTime()
    -- Update contacts
    for i=1,#self.KROMatrix/2 do
        local v = self.KROMatrix[i*2-1]
        local d = self.KROMatrix[i*2]
        self[v[1].."-"..v[2]] = d[self.KROPosition+2]
    end
    for i=1,#self.KRRMatrix/2 do
        local v = self.KRRMatrix[i*2-1]
        local d = self.KRRMatrix[i*2]
        self[v[1].."-"..v[2]] = d[self.KRRPosition+2]
    end
end

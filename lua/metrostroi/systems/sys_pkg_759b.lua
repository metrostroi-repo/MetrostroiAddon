--------------------------------------------------------------------------------
-- Reverser and relays panel (PKG-759B) for 81-702,
-- used on underground subway lines
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PKG_759B")

function TRAIN_SYSTEM:Initialize()
    --Brake selector configuration
    self.Configuration = self.Configuration or {
    --   ##      1  2  3  4  5  6  7  8  9 10 11 12
        [ 1] = { 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1},-- X
        [ 2] = { 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0},-- T
    }
    -- Resistance value of all contactors
    for k,v in ipairs(self.Configuration[1]) do self[k] = 1e15 end
    --Brake selector
    self.TPPosition = 0 --Position
    self.TPM = 0 --Contatcts
    self.TPT = 0
    self.TPMS = 0 --Setters
    self.TPTS = 0
    self.TPSpeed = 0 --Parameter


    --Reverser
    self.ReverserPosition = 0 --Position
    self.VP = 0 --Contacts
    self.NZ = 0
    self.VPS = 0 --Setters
    self.NZS = 0
    self.ReverserSpeed = 0 --Parameter

    self.RotationRate = 2

    -- Реле времени РВ
    self.Train:LoadSystem("RV","Relay","",{ open_time = 0.3 })
    -- Реле ускорения, торможения (РУТ)
    self.Train:LoadSystem("RU","Relay","R-52B")
    -- Extra coils for some relays
    self.Train.RUpod = 0
    self.Train.RUreg = 0
    self.Train.RUavt = 1
    self.Train.RVuderzh = 0
    self.Train.RVpod = 0
end

function TRAIN_SYSTEM:Inputs()
    return {"VP","NZ","TPM","TPT"}
end
function TRAIN_SYSTEM:Outputs()
    return {"VP","NZ","TPM","TPT"}
end
function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "VP" then self.VPS = value end
    if name == "NZ" then self.NZS = value end
    if name == "TPM" then self.TPMS = value end
    if name == "TPT" then self.TPTS = value end
end
function TRAIN_SYSTEM:Think(dT)
    -- Move reversor
    if self.VPS == 0 and self.NZS == 0 then
        self.ReverserSpeed = 0
    else
        self.ReverserSpeed = math.max(-1,math.min(1,self.ReverserSpeed+dT*(self.VPS-self.NZS)*0.9))
    end
    self.ReverserPosition = math.max(0,math.min(1,self.ReverserPosition + self.RotationRate*self.ReverserSpeed))

    if self.TPMS == 0 and self.TPTS == 0 then
        self.TPSpeed = 0
    else
        self.TPSpeed = math.max(-1,math.min(1,self.TPSpeed+dT*(self.TPTS-self.TPMS)*0.9))
    end
    self.TPPosition = math.max(0,math.min(1,self.TPPosition + self.RotationRate*self.TPSpeed))
    self.NZ = self.ReverserPosition <  0.5 and 1 or 0
    self.VP = self.ReverserPosition >= 0.5 and 1 or 0
    self.TPM = self.TPPosition <  0.5 and 1 or 0
    self.TPT = self.TPPosition >= 0.5 and 1 or 0
    if self.OldVP ~= self.VP then
        self.OldVP = self.VP
        self.Train:PlayOnce("RKR","bass",1,1)
    end
    if self.OldTPM ~= self.TPM then
        self.OldTPM = self.TPM
        self.Train:PlayOnce("T","bass",1,1)
    end


    -- Lock contacts as defined in the configuration
    for k,v in ipairs(self.Configuration[math.floor(self.TPPosition+1.5)]) do
        self[k] = 1e-15 + 1e15 * (1-v)
    end

    local Train = self.Train

    -- RU operation
    self.RUCurrent = (math.abs(Train.Electric.I13) + math.abs(Train.Electric.I24))/2
    self.RUTarget = 280 + 70*Train.RUavt*self.Train.Pneumatic.WeightLoadRatio+80*Train.RUreg--+30

    if Train.RUpod > 0.5
    then Train.RU:TriggerInput("Close",1.0)
    else Train.RU:TriggerInput("Set",self.RUCurrent > self.RUTarget)
    end
end

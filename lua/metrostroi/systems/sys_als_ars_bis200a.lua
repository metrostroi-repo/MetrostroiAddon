--------------------------------------------------------------------------------
-- ARS-D/ARS-Ezh3/BKBD safety system BIS-200 unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("ALS_ARS_BIS200")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("BIS_R0","Relay","ARS",{open_time=7,bass=true,bass_separate=true})
    self.Train:LoadSystem("BIS_PR0","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BIS_R1","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BIS_R2","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BIS_R3","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BIS_R4","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BIS_R5","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BIS_R6","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BIS_R7","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BIS_R8","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BIS_R10","Relay","ARS",{bass=true,bass_separate=true})

    self.Power = 0
    self.R0 = 0
    self.Speed = 0
end

function TRAIN_SYSTEM:Outputs()
	return {}
end

function TRAIN_SYSTEM:Inputs()
	return {}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end

local function C(val)
    return val and 1 or 0
end
local function inrange(val,min,max)
    return C(min < val and val < max)
end

function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    local speed = Train.ALSCoil.Speed

    --vv При торможении смещение на 2км\ч vv
    --self.SAdd = self.SAdd or 0
    --self.SAdd = math.max(-1,math.min(0,self.SAdd+(speed-self.Speed)*dT*4))
    --self.Speed = speed
    --speed = speed-self.SAdd*2
    --^^ При торможении смещение на 2км\ч ^^
    self.R0 = self.Power*C(speed<7)--11.5)
    Train.BIS_R1:TriggerInput("Set",self.Power*inrange(speed,5.5,11.5))
    Train.BIS_R2:TriggerInput("Set",self.Power*inrange(speed,10,21.5))
    Train.BIS_R3:TriggerInput("Set",self.Power*inrange(speed,20,31.5))
    Train.BIS_R4:TriggerInput("Set",self.Power*inrange(speed,30,41.5))
    Train.BIS_R5:TriggerInput("Set",self.Power*inrange(speed,40,51.5))
    Train.BIS_R6:TriggerInput("Set",self.Power*inrange(speed,50,61.5))
    Train.BIS_R7:TriggerInput("Set",self.Power*inrange(speed,60,71.5))
    Train.BIS_R8:TriggerInput("Set",self.Power*inrange(speed,70,81.5))
    Train.BIS_R10:TriggerInput("Set",self.Power*C(speed>80))
end

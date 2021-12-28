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

    self.SAdd = 0
end

function TRAIN_SYSTEM:Outputs()
	return {}
end

function TRAIN_SYSTEM:Inputs()
	return {"SpeedDec"}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "SpeedDec" then self.SpeedDec = value > 0 end
end

local function C(val)
    return val and 1 or 0
end
--[[local function inrange(val,min,max)
    return C(min < val and val < max)
end]]

local function inrange(val,min,max,min2,max2,state)
    if state then
        return C(min2 < val and val < max2)
    else
        return C(min < val and val < max)
    end
end

function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    local speed = Train.ALSCoil.Speed

    --vv При торможении смещение на 2км\ч vv
    ----[[
    if self.SpeedDec then
        Train.BIS_R1:TriggerInput("Set", self.Power*inrange(speed,5.5,11.5 ,3.5 ,14.0 ,Train.BIS_R1.Value > 0))
        Train.BIS_R2:TriggerInput("Set", self.Power*inrange(speed,10 ,21.5 ,8.2 ,25.7 ,Train.BIS_R2.Value > 0))
        Train.BIS_R3:TriggerInput("Set", self.Power*inrange(speed,20 ,31.5 ,17.6,35.7 ,Train.BIS_R3.Value > 0))
        Train.BIS_R4:TriggerInput("Set", self.Power*inrange(speed,30 ,41.5 ,27.6,45.7 ,Train.BIS_R4.Value > 0))
        Train.BIS_R5:TriggerInput("Set", self.Power*inrange(speed,40 ,51.5 ,37.6,55.7 ,Train.BIS_R5.Value > 0))
        Train.BIS_R6:TriggerInput("Set", self.Power*inrange(speed,50 ,61.5 ,47.3,65.7 ,Train.BIS_R6.Value > 0))
        Train.BIS_R7:TriggerInput("Set", self.Power*inrange(speed,60 ,71.5 ,56.7,75.6 ,Train.BIS_R7.Value > 0))
        Train.BIS_R8:TriggerInput("Set", self.Power*inrange(speed,70 ,81.5 ,66.7,85.7 ,Train.BIS_R8.Value > 0))
        Train.BIS_R10:TriggerInput("Set",self.Power*inrange(speed,80 ,101.5,74.5,108.4,Train.BIS_R10.Value > 0))

        --[[
        if speed > self.Speed then
            self.SAdd = math.min(1,math.max(-0.3,self.SAdd-(speed-self.Speed)*0.6))
        else
            self.SAdd = math.min(1,math.max(-0.3,self.SAdd-(speed-self.Speed)*0.3))
        end
        local add = math.max(0,self.SAdd)
        --self.R0 = self.Power*C(speed<7)--11.5)
        Train.BIS_R1:TriggerInput("Set", self.Power*inrange(speed,5.5-add*2  ,11.5 +add*2.5))
        Train.BIS_R2:TriggerInput("Set", self.Power*inrange(speed,10 -add*1.8,21.5 +add*4.2))
        Train.BIS_R3:TriggerInput("Set", self.Power*inrange(speed,20 -add*2.4,31.5 +add*4.2))
        Train.BIS_R4:TriggerInput("Set", self.Power*inrange(speed,30 -add*2.4,41.5 +add*4.2))
        Train.BIS_R5:TriggerInput("Set", self.Power*inrange(speed,40 -add*2.4,51.5 +add*4.2))
        Train.BIS_R6:TriggerInput("Set", self.Power*inrange(speed,50 -add*2.7,61.5 +add*4.2))
        Train.BIS_R7:TriggerInput("Set", self.Power*inrange(speed,60 -add*3.3,71.5 +add*4.1))
        Train.BIS_R8:TriggerInput("Set", self.Power*inrange(speed,70 -add*3.3,81.5 +add*4.2))
        Train.BIS_R10:TriggerInput("Set",self.Power*inrange(speed,80 -add*5.5,101.5+add*6.9))]]
    else
        --self.R0 = self.Power*C(speed<7)--11.5)
        Train.BIS_R1:TriggerInput("Set",self.Power*inrange(speed,5.5,11.5))
        Train.BIS_R2:TriggerInput("Set",self.Power*inrange(speed,10,21.5))
        Train.BIS_R3:TriggerInput("Set",self.Power*inrange(speed,20,31.5))
        Train.BIS_R4:TriggerInput("Set",self.Power*inrange(speed,30,41.5))
        Train.BIS_R5:TriggerInput("Set",self.Power*inrange(speed,40,51.5))
        Train.BIS_R6:TriggerInput("Set",self.Power*inrange(speed,50,61.5))
        Train.BIS_R7:TriggerInput("Set",self.Power*inrange(speed,60,71.5))
        Train.BIS_R8:TriggerInput("Set",self.Power*inrange(speed,70,81.5))
        Train.BIS_R10:TriggerInput("Set",self.Power*inrange(speed,80,101.5))
        --Train.BIS_R10:TriggerInput("Set",self.Power*C(speed>80))
        end--]]
    --^^ При торможении смещение на 2км\ч ^^
    self.Speed = speed
end
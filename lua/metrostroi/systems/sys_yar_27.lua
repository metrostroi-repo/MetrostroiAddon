--------------------------------------------------------------------------------
-- Box with relays (YaR-27)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("YAR_27")

function TRAIN_SYSTEM:Initialize(parameters)
    -- Реле дверей (РД)
    self.Train:LoadSystem("RD","Relay","REV-821",{ close_time = 0.1 })
    -- Реле включения освещения (РВО)
    self.Train:LoadSystem("RVO","Relay","REV-814T",{ open_time = 4.0 })
    -- Реле времени торможения (РВ3)
    self.Train:LoadSystem("RV3","Relay","REV-813T",{ open_time = 2.3 })
    -- Реле тока (РТ2)
    self.Train:LoadSystem("RT2","Relay","REV-830",{ trigger_level = 130 }) -- A
    -- Реле контроля тормозного тока (РКТТ)
    self.Train:LoadSystem("RKTT","Relay","R-52B")
    self.Train.RKTTsh = 1
    if parameters=="Ezh3" then self.NoRKTT = true end
end

function TRAIN_SYSTEM:Inputs()
    return {  }
end
function TRAIN_SYSTEM:Outputs()
    --return { "RKTTClose" , "RKTTOpen", "RKTTCurrent"}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end

function TRAIN_SYSTEM:Think()
    local Train = self.Train
    -- RT2 relay operation
    Train.RT2:TriggerInput("Set",Train.Electric.IRT2)
    if self.NoRKTT then return end
    --self.RUTTarget = 250 + 150*self.WeightLoadRatio
    self.RKTTCurrent = Train.Electric.IRT2*Train.RKTTsh--(math.abs(Train.Electric.I13) + math.abs(Train.Electric.I24))*Train:ReadTrainWire(6)
    --self.RKTTClose  = 275 + 50*self.WeightLoadRatio --125
    --self.RKTTOpen = 370 + 52*self.WeightLoadRatio --130
    --self.RKTTClose  = 240 + 100*self.Train.Pneumatic.WeightLoadRatio --125
    --self.RKTTOpen = 335 + 130*self.Train.Pneumatic.WeightLoadRatio --130

    --self.RKTTClose  = 380 + 120*self.Train.Pneumatic.WeightLoadRatio*Train.RUTavt --125
    --self.RKTTOpen = 460 + 120*self.Train.Pneumatic.WeightLoadRatio*Train.RUTavt --130
    self.RKTTClose  = 500 - 120*(1-self.Train.Pneumatic.WeightLoadRatio)*Train.RUTavt --125
    self.RKTTOpen = 580 - 120*(1-self.Train.Pneumatic.WeightLoadRatio)*Train.RUTavt --130
    if self.RKTTCurrent < self.RKTTClose then
        Train.RKTT:TriggerInput("Set",false)
    else
        Train.RKTT:TriggerInput("Set",self.RKTTCurrent >= self.RKTTOpen)
    end
end

--------------------------------------------------------------------------------
-- Automatic switches unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_718_BVA")

function TRAIN_SYSTEM:Initialize()
    self.Power = 0
    self.Train:LoadSystem("QF1","Relay","BV",{bass=true})
    self.DiableScheme = 0
    self.BVGood = 0
    self.Disable = 0
end

function TRAIN_SYSTEM:Inputs()
	return { "Enable" }
end

function TRAIN_SYSTEM:Outputs()
	return {  }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "Enable" then
        self.Power = 1
        self.Reset = 1
        self.Train.QF1:TriggerInput("Close",1)
    end
end

function TRAIN_SYSTEM:Think()
    local Train = self.Train
    local Electric = Train.Electric
    self.BVGood = Train.QF1.Value --802 провод
    if self.Disable == 0 and self.DiableScheme and self.Reset > 0 and Train.QF1.Value == 0 then
        Train.QF1:TriggerInput("Close",1)
    end
    if ((self.Disable+self.DiableScheme) > 0 or self.Power == 0) and Train.QF1.Value > 0 then
        Train.QF1:TriggerInput("Open",1)
    end
    local I13,I24 = math.abs(Electric.I13),math.abs(Electric.I24)
    if I13 > 800 or I24 > 800 or I13+I24>1500 then
        Train.QF1:TriggerInput("Open",1)
    end
end

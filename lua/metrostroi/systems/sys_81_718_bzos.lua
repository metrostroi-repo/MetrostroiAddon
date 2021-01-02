--------------------------------------------------------------------------------
-- Security alarm unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_718_BZOS")

function TRAIN_SYSTEM:Initialize()
    self.Power = 0
    self.VH1 = 0
    self.Ring = 0
    self.Ready = 0
    self.VH2 = 0
end

function TRAIN_SYSTEM:Inputs()
	return {  }
end

function TRAIN_SYSTEM:Outputs()
	return { "Ring","VH1","VH2" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end

function TRAIN_SYSTEM:Think()
    local Train = self.Train
    self.VH1 = self.Power*Train.SAB1.Value
    self.Ready = self.VH1*(self.Ready*(1-Train.SQ3.Value)+Train.SQ3.Value)
    self.VH2 = self.Ready*math.min(1,(self.Ring==1 and 0 or 1)*self.VH2+(1-Train.SQ3.Value))
end

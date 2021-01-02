--------------------------------------------------------------------------------
-- Emergency control panel for 81-502
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PRU_502")

function TRAIN_SYSTEM:Initialize()
	self.Train:LoadSystem("RO1","Relay","KPD-110E",{ bass = true }) --KPD-110E???
	self.Train:LoadSystem("RO2","Relay","KPD-110E",{ bass = true }) --KPD-110E???
end

function TRAIN_SYSTEM:Inputs()
	return {}
end

function TRAIN_SYSTEM:Outputs()
	return {}
end


function TRAIN_SYSTEM:Think()
end

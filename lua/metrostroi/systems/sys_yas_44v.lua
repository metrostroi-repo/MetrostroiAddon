--------------------------------------------------------------------------------
-- Box with rheostats (YaS-44V)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("YAS_44V")

function TRAIN_SYSTEM:Initialize()
	self.Resistors = {
		["P13-P33"]	= 51,
		["MK1-MK2"]	= 18.75,
		["P33-P42"]	= 300,
	}

	for k,v in pairs(self.Resistors) do
		self[k] = v
	end
end
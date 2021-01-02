--------------------------------------------------------------------------------
-- I/O between UPPS and electric schemes
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("UPPS_VV")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize()
    self.Power = 0
    self.KB = 0
end

function TRAIN_SYSTEM:Outputs()
	return {"Power","KB"}
end

function TRAIN_SYSTEM:Inputs()
	return {}
end
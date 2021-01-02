--------------------------------------------------------------------------------
-- I/O between RRI and electric schemes
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_71_RRI_VV")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize()
    self.Power = 0
    self.AmplifierPower = 0
    self.CabinSpeakerPower = 0
end

function TRAIN_SYSTEM:Outputs()
	return {"Power","AmplifierPower","CabinSpeakerPower"}
end

function TRAIN_SYSTEM:Inputs()
	return {}
end
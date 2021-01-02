--------------------------------------------------------------------------------
-- ARS-D/ARS-Ezh3/BKBD safety system BSM unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("ALS_ARS_BSM")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize(typ)
    self.Train:LoadSystem("BSM_GE","Relay","ARS",{close_time=0.5,open_time=1,bass=true,bass_separate=true})
    self.Train:LoadSystem("BSM_SIR1","Relay","ARS",{close_time=0,open_time=0.05, bass=true,bass_separate=true})
    self.Train:LoadSystem("BSM_SIR2","Relay","ARS",{close_time=0,open_time=0.05, bass=true,bass_separate=true})
    self.Train:LoadSystem("BSM_SIR3","Relay","ARS",{close_time=0,open_time=0.05, bass=true,bass_separate=true})
    self.Train:LoadSystem("BSM_SIR4","Relay","ARS",{close_time=0,open_time=0.05, bass=true,bass_separate=true})
    self.Train:LoadSystem("BSM_SIR5","Relay","ARS",{close_time=0,open_time=0.05, bass=true,bass_separate=true})
    if typ==1 then
        self.Train:LoadSystem("BSM_SR1","Relay","ARS",{close_time=0.04,open_time=0.5, bass=true,bass_separate=true})
        self.Train:LoadSystem("BSM_SR2","Relay","ARS",{close_time=0.04,open_time=0.5, bass=true,bass_separate=true})
        self.Train:LoadSystem("BSM_KSR1","Relay","ARS",{open_time=0.25, bass=true,bass_separate=true})
        self.Train:LoadSystem("BSM_KSR2","Relay","ARS",{open_time=0.25, bass=true,bass_separate=true})
    else
        self.Train:LoadSystem("BSM_SR1","Relay","ARS",{close_time=0.04,open_time=0.6, bass=true,bass_separate=true})
        self.Train:LoadSystem("BSM_SR2","Relay","ARS",{close_time=0.04,open_time=0.6, bass=true,bass_separate=true})
        self.Train:LoadSystem("BSM_KSR1","Relay","ARS",{open_time=0.25, bass=true,bass_separate=true})
        self.Train:LoadSystem("BSM_KSR2","Relay","ARS",{open_time=0.25, bass=true,bass_separate=true})
    end


    self.Train:LoadSystem("BSM_KRO","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BSM_KRH","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BSM_KRT","Relay","ARS",{bass=true,bass_separate=true})

    self.Train:LoadSystem("BSM_BR1","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BSM_BR2","Relay","ARS",{bass=true,bass_separate=true})
    if typ==1 then
        self.Train:LoadSystem("BSM_RVV","Relay","ARS",{open_time=9,bass=true,bass_separate=true})
        self.Train:LoadSystem("BSM_RUT","Relay","ARS",{bass=true,bass_separate=true})
    else
        self.Train:LoadSystem("BSM_PR1","Relay","ARS",{bass=true,bass_separate=true})

        self.Train:LoadSystem("BSM_RNT1","Relay","ARS",{--[[ open_time=0.1,--]] bass=true,bass_separate=true})
    end
    self.Train:LoadSystem("BSM_RNT","Relay","ARS",{--[[ open_time=0.1,--]] bass=true,bass_separate=true})
end

function TRAIN_SYSTEM:Outputs()
	return {}
end

function TRAIN_SYSTEM:Inputs()
	return {}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end


function TRAIN_SYSTEM:Think(dT)
	local Train = self.Train
	local ALS = Train.ALSCoil
	local ARS = Train.ALS_ARS
end

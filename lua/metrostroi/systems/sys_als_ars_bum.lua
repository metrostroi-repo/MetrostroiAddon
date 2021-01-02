--------------------------------------------------------------------------------
-- АРС-АЛС
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("ALS_ARS_BUM")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize(typ)
    self.Train:LoadSystem("BUM_RVD1","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BUM_RVD2","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BUM_RUVD","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BUM_RB","Relay","ARS",{bass=true,bass_separate=true})
    if typ==1 then
        self.Train:LoadSystem("BUM_TR","Relay","ARS",{close_time=0.15, bass=true,bass_separate=true})
        self.Train:LoadSystem("BUM_PTR","Relay","ARS",{open_time=2.3, bass=true,bass_separate=true})
        self.Train:LoadSystem("BUM_KRD","Relay","ARS",{bass=true,bass_separate=true})

        self.Train:LoadSystem("BUM_RVEK1","Relay","ARS",{bass=true,bass_separate=true})
        self.Train:LoadSystem("BUM_RVEK2","Relay","ARS",{bass=true,bass_separate=true})

        --self.Train:LoadSystem("BUM_KPP","Relay","ARS",{bass=true,bass_separate=true})
    else
        self.Train:LoadSystem("BUM_TR","Relay","ARS",{close_time=typ==2 and 0.02 or 0.15, bass=true,bass_separate=true})
        --self.Train:LoadSystem("BUM_PTR","Relay","ARS",{open_time=0.15, bass=true,bass_separate=true})
        --self.Train:LoadSystem("BUM_PTR1","Relay","ARS",{open_time=1.4, bass=true,bass_separate=true})
        self.Train:LoadSystem("BUM_PTR","Relay","ARS",{open_time=1.0, bass=true,bass_separate=true})
        self.Train:LoadSystem("BUM_PTR1","Relay","ARS",{open_time=0.9, bass=true,bass_separate=true})

        self.Train:LoadSystem("BUM_RIPP","Relay","ARS",{bass=true,bass_separate=true})
        self.Train:LoadSystem("BUM_PEK","Relay","ARS",{bass=true,bass_separate=true})

        self.Train:LoadSystem("BUM_KPP","Relay","ARS",{bass=true,bass_separate=true})
    end
    self.Train:LoadSystem("BUM_EK","Relay","ARS",{open_time=3.3, bass=true,bass_separate=true})
    self.Train:LoadSystem("BUM_EK1","Relay","ARS",{open_time=3.3, bass=true,bass_separate=true})
    self.Train:LoadSystem("BUM_RVZ1","Relay","ARS",{bass=true,bass_separate=true})


    self.Train:LoadSystem("BUM_RET","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BUM_LTR1","Relay","ARS",{open_time=1, bass=true,bass_separate=true})

    self.Train:LoadSystem("BUM_RVT1","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BUM_RVT2","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BUM_RVT4","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BUM_RVT5","Relay","ARS",{bass=true,bass_separate=true})
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
end

--------------------------------------------------------------------------------
-- ARS-D/ARS-Ezh3/BKBD safety system BLPM unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("ALS_ARS_BLPM")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("BLPM_1R1","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BLPM_1R2","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BLPM_1R3","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BLPM_2R1","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BLPM_2R2","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BLPM_2R3","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BLPM_3R1","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BLPM_3R2","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BLPM_3R3","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BLPM_4R1","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BLPM_4R2","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BLPM_4R3","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BLPM_5R1","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BLPM_5R2","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BLPM_5R3","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BLPM_6R1","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BLPM_6R2","Relay","ARS",{bass=true,bass_separate=true})
    self.Train:LoadSystem("BLPM_6R3","Relay","ARS",{bass=true,bass_separate=true})

    self.Power = 0
    self.NoneFreq = 0
    self.OneFreq = 0
    self.TwoFreq = 0
    self.BadFreq = 0
end

function TRAIN_SYSTEM:Outputs()
	return {}
end

function TRAIN_SYSTEM:Inputs()
	return {}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end

local S = {}
function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    local ALS = Train.ALSCoil
    if Train.KPK2 and Train.KPK2.Value > 0 then
        S["TW94"] = Train:ReadTrainWire(self.PKWire or 94)
        S["F6"] = bit.band(S["TW94"],32)/32
        S["F5"] = bit.band(S["TW94"],16)/16
        S["F4"] = bit.band(S["TW94"],8)/8
        S["F3"] = bit.band(S["TW94"],4)/4
        S["F2"] = bit.band(S["TW94"],2)/2
        S["F1"] = bit.band(S["TW94"],1)/1
    else
        S["F6"] = ALS.F6
        S["F5"] = ALS.F5
        S["F4"] = ALS.F4
        S["F3"] = ALS.F3
        S["F2"] = ALS.F2
        S["F1"] = ALS.F1
    end
    local freqCount = self.Power*(S["F6"]+S["F5"]+S["F4"]+S["F3"]+S["F2"]+S["F1"])
    self.NoneFreq =freqCount==0 and 1 or 0
    self.OneFreq = freqCount==1 and 1 or 0
    self.TwoFreq = freqCount==2 and 1 or 0
    self.BadFreq = freqCount>2 and 1 or 0


    Train.BLPM_1R1:TriggerInput("Set",self.Power*S["F1"])
    Train.BLPM_1R2:TriggerInput("Set",self.Power*S["F1"])
    Train.BLPM_1R3:TriggerInput("Set",(1-Train.BLPM_1R1.Value)*(1-Train.BLPM_1R2.Value))

    Train.BLPM_2R1:TriggerInput("Set",self.Power*S["F2"])
    Train.BLPM_2R2:TriggerInput("Set",self.Power*S["F2"])
    Train.BLPM_2R3:TriggerInput("Set",(1-Train.BLPM_2R1.Value)*(1-Train.BLPM_2R2.Value))

    Train.BLPM_3R1:TriggerInput("Set",self.Power*S["F3"])
    Train.BLPM_3R2:TriggerInput("Set",self.Power*S["F3"])
    Train.BLPM_3R3:TriggerInput("Set",(1-Train.BLPM_3R1.Value)*(1-Train.BLPM_3R2.Value))

    Train.BLPM_4R1:TriggerInput("Set",self.Power*S["F4"])
    Train.BLPM_4R2:TriggerInput("Set",self.Power*S["F4"])
    Train.BLPM_4R3:TriggerInput("Set",(1-Train.BLPM_4R1.Value)*(1-Train.BLPM_4R2.Value))

    Train.BLPM_5R1:TriggerInput("Set",self.Power*S["F5"])
    Train.BLPM_5R2:TriggerInput("Set",self.Power*S["F5"])
    Train.BLPM_5R3:TriggerInput("Set",(1-Train.BLPM_5R1.Value)*(1-Train.BLPM_5R2.Value))

    if Train.PD1 then
        Train.BLPM_6R1:TriggerInput("Set",self.Power*S["F6"]*Train.PD1.Value)
        Train.BLPM_6R2:TriggerInput("Set",self.Power*S["F6"]*Train.PD2.Value)
        Train.BLPM_6R3:TriggerInput("Set",(1-Train.BLPM_6R1.Value)*(1-Train.BLPM_6R2.Value))
    else
        Train.BLPM_6R1:TriggerInput("Set",self.Power*S["F6"])
        Train.BLPM_6R2:TriggerInput("Set",self.Power*S["F6"])
        Train.BLPM_6R3:TriggerInput("Set",(1-Train.BLPM_6R1.Value)*(1-Train.BLPM_6R2.Value))
    end

    if Train.GetDriver and Train:GetDriver() then
        --print(123,Train.KPK2.Value,Train:ReadTrainWire(94))
        --print("\nBLPM")
        --print("1  2  3  4  5  6")
        --print("123123123123123123")
        --print(Train.BLPM_1R1.Value..Train.BLPM_1R2.Value..Train.BLPM_1R3.Value..Train.BLPM_2R1.Value..Train.BLPM_2R2.Value..Train.BLPM_2R3.Value..Train.BLPM_3R1.Value..Train.BLPM_3R2.Value..Train.BLPM_3R3.Value..Train.BLPM_4R1.Value..Train.BLPM_4R2.Value..Train.BLPM_4R3.Value..Train.BLPM_5R1.Value..Train.BLPM_5R2.Value..Train.BLPM_5R3.Value..Train.BLPM_6R1.Value..Train.BLPM_6R2.Value..Train.BLPM_6R3.Value,Train.KPK2.Value)


        --print("\nSIR")
        --print("54321 12")
        --print(Train.BSM_SIR5.Value..Train.BSM_SIR4.Value..Train.BSM_SIR3.Value..Train.BSM_SIR2.Value..Train.BSM_SIR1.Value.." "..Train.BSM_SR1.Value..Train.BSM_SR2.Value)
    end
end

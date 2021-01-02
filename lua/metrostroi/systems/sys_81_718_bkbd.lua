--------------------------------------------------------------------------------
-- 81-718 "BKBD" safety system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_718_BKBD")
function TRAIN_SYSTEM:Initialize()
    self.FMM1 = 0
    self.FMM2 = 0
    self.PD = 0
    self.VP = 0
    self.ALS = 0
    self.KB = 0
    self.NGPower = 0
    self.DA = 0
    self.KT = 0

    self.Train:LoadSystem("ALSCoil")

    self.Train:LoadSystem("BIS200","ALS_ARS_BIS200")
    self.Train:LoadSystem("BLPM","ALS_ARS_BLPM")

    self.Train.BLPM.PKWire = 85
    self.Train:LoadSystem("BSM","ALS_ARS_BSM",2)
    self.Train:LoadSystem("BUM","ALS_ARS_BUM",2)

    self.Train:LoadSystem("RPB","Relay","REV-813T", { bass = true, open_time = 2.5,})
    self.Train:LoadSystem("ROT1","Relay")
    self.Train:LoadSystem("ROT2","Relay")

    self.Train:LoadSystem("EPKC","Relay")

    self.Train:LoadSystem("KPK1","Relay","",{bass=true,bass_separate=true}) --Коммутация ПК
    self.Train:LoadSystem("KPK2","Relay","",{bass=true,bass_separate=true}) --Коммутация ПК
    self.Train:LoadSystem("FMM1","Relay","",{bass=true,bass_separate=true}) --Фиксация местонахождения машиниста
    self.Train:LoadSystem("FMM2","Relay","",{bass=true,bass_separate=true}) --Фиксация местонахождения машиниста
    self.Train:LoadSystem("PD1","Relay","",{bass=true,bass_separate=true}) --Переключение дешифратора
    self.Train:LoadSystem("PD2","Relay","",{bass=true,bass_separate=true}) --Переключение дешифратора
    self.Train:LoadSystem("ARS_VP","Relay","",{bass=true,bass_separate=true}) --Режим ВП
    self.Train:LoadSystem("ARS_RT","Relay","",{bass=true,bass_separate=true}) --Реле торможения от АРС-Р
    self.Train:LoadSystem("NG","Relay","",{bass=true,bass_separate=true})
    self.Train:LoadSystem("NH","Relay","",{bass=true,bass_separate=true})

    -- ARS wires
    self["33D"] = 0
    self["33G"] = 0
    self["2"] = 0
    self["6"] = 0
    self["8"] = 0
    self["20"] = 0
    --self["21"] = 0
    self["48"] = 0
    self["31"] = 0
    self["32"] = 0
    self.Ring = 0
    self.LN = 0

    self.EPK = 0
end

function TRAIN_SYSTEM:Outputs()
    return {
        "2", "8", "20", "48", "33D", "33G", "48",
        "NoFreq","F1","F2","F3","F4","F5","F6","LN",
        "EPK",
    }
end

function TRAIN_SYSTEM:Inputs()
    return {}
end

local S = {}
function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    local ALS = Train.ALSCoil
    local BLPM = Train.BLPM
    local Panel = Train.Panel

    Train.FMM1:TriggerInput("Set",self.FMM1)
    Train.FMM2:TriggerInput("Set",self.FMM2)

    S["RVZ"] = self.GE*((Train.BSM_KRO.Value+Train.BSM_KRT.Value)*(1-Train.BSM_KRH.Value)+Train.BSM_BR2.Value)*(1-Train.BIS_R2.Value)*(1-Train.BIS_R3.Value)*(1-Train.BIS_R4.Value)*(1-Train.BIS_R5.Value)*(1-Train.BIS_R6.Value)*(1-Train.BIS_R7.Value)*(1-Train.BIS_R8.Value)*(1-Train.BIS_R10.Value)
    --Train.BIS_R0:TriggerInput("NoOpenTime",Train.BIS_R1.Value+(1-Train.BIS_R0.Value))

    Train.BIS_R0:TriggerInput("NoOpenTime",(1-Train.BIS_R0.Value)+Train.BIS_R1.Value)
    Train.BIS_R0:TriggerInput("Set",(self.GE*(1-Train.BSM_GE.Value)+S["RVZ"]*(Train.BIS_R1.Value+Train.BIS_R0.Value))*Train.BIS200.R0)

    S["RVZ1"] = S["RVZ"]*Train.BIS_R0.Value*(1-Train.BIS_R1.Value)
    S["EK0"] = S["RVZ1"]*(1-Train.BSM_GE.Value)

    Train.ARS_VP:TriggerInput("Set",self.VP)
    Train.PD1:TriggerInput("Set",self.PD)
    Train.PD2:TriggerInput("Set",self.PD)

    Train.BSM_GE:TriggerInput("Set",self.GE)


    -- LN 1/5 Light fix
    --S["FMM_28"] = self.NGPower*Train.BLPM_5R3.Value*(1-Train.BLPM_4R3.Value)*(Train.PD2.Value*(1-Train.BLPM_6R3.Value) + (1-Train.PD2.Value)*Train.BLPM_6R3.Value)*Train.BLPM_3R3.Value*Train.BLPM_2R3.Value*Train.BLPM_1R3.Value
    -- Original
    S["FMM_28"] = self.NGPower*Train.BLPM_5R3.Value*(1-Train.BLPM_4R3.Value)*(Train.PD2.Value*(1-Train.BLPM_6R3.Value))*Train.BLPM_3R3.Value*Train.BLPM_2R3.Value*Train.BLPM_1R3.Value
    Train.NG:TriggerInput("Set",S["FMM_28"]*Train.FMM1.Value+self.NGPower*Train.NG.Value*(1-Train.NH.Value))
    Train.NH:TriggerInput("Set",S["FMM_28"]*(1-Train.FMM1.Value)+self.NGPower*Train.NH.Value*(1-Train.NG.Value))

    S["GE"]= self.GE*Train.BSM_GE.Value
    local EnableALS = ((S["GE"]+self.ALS)--[[ *Train.KPK1.Value*Train.SA15.Value+(1-Train.KPK2.Value)--]] )*Train.FMM1.Value
    if EnableALS ~= ALS.Enabled then
        ALS:TriggerInput("Enable",EnableALS)
    end

    --FreqProtect
    --SR1,SR2
    S["FQCheckPower"] = S["GE"]+self.ALS
    S["LUDS"] = (self.GE+self.ALS--[[ *Train.FMM1.Value--]] )*Train.BSM_SR1.Value
    S["5P31F"] = BLPM.OneFreq*Train.BLPM_5R3.Value*(1-Train.ARS_VP.Value)
    S["SRPower"] = S["FQCheckPower"]*(S["5P31F"]*(1-Train.PD1.Value)+BLPM.TwoFreq*(1-Train.ARS_VP.Value)*Train.PD1.Value)
    S["NF"] = (S["FQCheckPower"]*(BLPM.TwoFreq*((1-Train.PD1.Value)+Train.ARS_VP.Value)+BLPM.NoneFreq+BLPM.BadFreq+BLPM.OneFreq*((1-Train.BLPM_5R3.Value)*(1-Train.BLPM_5R1.Value)*(1-Train.BLPM_5R2.Value)+Train.ARS_VP.Value))*(1-Train.BSM_SIR5.Value)*(1-Train.BSM_SIR4.Value)*(1-Train.BSM_SIR3.Value)*(1-Train.BSM_SIR2.Value)*(1-Train.BSM_SIR1.Value))
    S["1SIR"] = S["SRPower"]*(1-Train.BLPM_1R3.Value)*Train.BLPM_1R1.Value*Train.BLPM_1R2.Value
    S["2SIR"] = S["SRPower"]*Train.BLPM_1R3.Value*(1-Train.BLPM_2R3.Value)*Train.BLPM_2R1.Value*Train.BLPM_2R2.Value
    S["3SIR"] = S["SRPower"]*Train.BLPM_1R3.Value*Train.BLPM_2R3.Value*(1-Train.BLPM_3R3.Value)*Train.BLPM_3R1.Value*Train.BLPM_3R2.Value
    S["4SIR"] = S["5P31F"]*(1-S["NF"])*Train.PD1.Value+(S["SRPower"]*Train.BLPM_1R3.Value*Train.BLPM_2R3.Value*Train.BLPM_3R3.Value)*(1-Train.BLPM_4R3.Value)*Train.BLPM_4R1.Value*Train.BLPM_4R2.Value
    S["5SIR"] = S["FQCheckPower"]*BLPM.OneFreq*(1-Train.BLPM_5R3.Value)*Train.BLPM_5R1.Value*Train.BLPM_5R2.Value

    Train.BSM_SIR1:TriggerInput("Set",
        S["FQCheckPower"]*Train.BSM_SR1.Value*Train.BSM_SIR1.Value+
        S["1SIR"]*(1-Train.BSM_SR1.Value)--*(1-Train.BSM_SR2.Value)
    )
    Train.BSM_SIR2:TriggerInput("Set",
        S["FQCheckPower"]*Train.BSM_SR1.Value*(Train.BSM_SIR1.Value+Train.BSM_SIR2.Value)+
        S["2SIR"]*(1-Train.BSM_SR1.Value)--*(1-Train.BSM_SR2.Value)
    )
    Train.BSM_SIR3:TriggerInput("Set",
        S["FQCheckPower"]*Train.BSM_SR1.Value*(Train.BSM_SIR2.Value+Train.BSM_SIR3.Value)+
        S["3SIR"]*(1-Train.BSM_SR1.Value)--*(1-Train.BSM_SR2.Value)
    )
    Train.BSM_SIR4:TriggerInput("Set",
        S["FQCheckPower"]*Train.BSM_SR1.Value*(Train.BSM_SIR3.Value+Train.BSM_SIR4.Value)+
        S["4SIR"]*(1-Train.BSM_SR1.Value)--*(1-Train.BSM_SR2.Value)
    )
    Train.BSM_SIR5:TriggerInput("Set",
        S["FQCheckPower"]*Train.BSM_SR1.Value*(Train.BSM_SIR1.Value+Train.BSM_SIR2.Value+Train.BSM_SIR3.Value+Train.BSM_SIR4.Value+Train.BSM_SIR5.Value)+
        S["5SIR"]*(1-Train.BSM_SR1.Value)--*(1-Train.BSM_SR2.Value)
    )
    S["SRSIR5"] = (S["NF"]*(1-Train.BSM_SIR5.Value)+S["5SIR"]*Train.BSM_SIR5.Value)
    S["SRSIR4"] = (S["4SIR"]*Train.BSM_SIR4.Value)
    S["SRSIR3"] = (S["3SIR"]*Train.BSM_SIR3.Value)
    S["SRSIR2"] = (S["2SIR"]*Train.BSM_SIR2.Value)
    S["SRSIR1"] = (S["1SIR"]*Train.BSM_SIR1.Value)
    ---[[
    S["SR"] =
        S["SRSIR5"]*(1-Train.BSM_SIR4.Value)*(1-Train.BSM_SIR3.Value)*(1-Train.BSM_SIR2.Value)*(1-Train.BSM_SIR1.Value)+
        S["SRSIR4"]*(1-Train.BSM_SIR3.Value)*(1-Train.BSM_SIR2.Value)*(1-Train.BSM_SIR1.Value)+
        S["SRSIR3"]*(1-Train.BSM_SIR2.Value)*(1-Train.BSM_SIR1.Value)+
        S["SRSIR2"]*(1-Train.BSM_SIR1.Value)+
        S["SRSIR1"]

    Train.BSM_SR1:TriggerInput("Set",S["SR"])
    Train.BSM_SR2:TriggerInput("Set",S["SR"])

    S["BSM_KSR1"] = S["GE"]*Train.BSM_SR1.Value
    S["BIS1"] = S["BSM_KSR1"]*(
        ((1-Train.BIS_R0.Value)*Train.BIS_R2.Value+Train.BIS_R0.Value*(1-Train.BIS_R2.Value))+
        ((1-Train.BIS_R6.Value)*Train.BIS_R8.Value+Train.BIS_R6.Value*(1-Train.BIS_R8.Value))+
        ((1-Train.BIS_R3.Value)*Train.BIS_R5.Value+Train.BIS_R3.Value*(1-Train.BIS_R5.Value))+
        ((1-Train.BIS_R10.Value)*Train.BIS_R7.Value+Train.BIS_R10.Value*(1-Train.BIS_R7.Value))+
        ((1-Train.BIS_R1.Value)*Train.BIS_R4.Value+Train.BIS_R1.Value*(1-Train.BIS_R4.Value))
    )
    S["R10"] = S["BIS1"]*(1-Train.BIS_R10.Value)
    S["R8"] = S["R10"]*(1-Train.BIS_R8.Value)
    S["R7"] = S["R8"]*(1-Train.BIS_R7.Value)
    S["R5"] = S["R7"]*(1-Train.BIS_R6.Value)*(1-Train.BIS_R5.Value)
    S["R3"] = S["R5"]*(1-Train.BIS_R4.Value)*(1-Train.BIS_R3.Value)

    S["BR1_14"] =
        S["R10"]*Train.BSM_SIR1.Value+
        S["R8"]*Train.BSM_SIR2.Value*(1-Train.BSM_SIR1.Value)+
        S["R7"]*Train.BSM_SIR3.Value*(1-Train.BSM_SIR2.Value)*(1-Train.BSM_SIR1.Value)+
        S["R5"]*Train.BSM_SIR4.Value*(1-Train.BSM_SIR3.Value)*(1-Train.BSM_SIR2.Value)*(1-Train.BSM_SIR1.Value)
    S["BR1_C"] = S["R3"]*Train.BSM_SIR5.Value
    S["BR1_16"] = S["R5"]*Train.BSM_SIR3.Value+S["BR1_C"]*(1-Train.BSM_SIR3.Value)
    S["BR2_16"] = S["R3"]*(1-Train.BSM_SIR5.Value)
    S["BR1_C2"] = S["BR1_C"]*Train.BSM_BR1.Value
    -- LN 1/5 Original without PD fix
    --S["BR2_14"] =
    --  (Train.BSM_BR1.Value*S["BR1_16"]+(1-Train.BSM_BR1.Value)*S["BR1_14"])
    --  *(Train.FMM2.Value*Train.NG.Value+(1-Train.FMM2.Value)*Train.NH.Value*(1-Train.NG.Value))+
    --  S["BR1_C2"]*((1-Train.NH.Value)*(1-Train.NG.Value)+Train.FMM2.Value*Train.NH.Value*(1-Train.NG.Value)+(1-Train.FMM2.Value)*Train.NG.Value)
    -- LN 1/5 With PD fix
    S["BR2_14"] =
        (Train.BSM_BR1.Value*S["BR1_16"]+(1-Train.BSM_BR1.Value)*S["BR1_14"])
        *(Train.FMM2.Value*(Train.NG.Value+(1-Train.PD1.Value))+(1-Train.FMM2.Value)*(Train.NH.Value+(1-Train.PD2.Value))*(1-Train.NG.Value))+
        S["BR1_C2"]*((1-Train.NH.Value)*(1-Train.NG.Value)+Train.FMM2.Value*Train.NH.Value*(1-Train.NG.Value)+(1-Train.FMM2.Value)*Train.NG.Value)

    S["KSR2"] = S["BR2_16"]*Train.BSM_BR2.Value+S["BR2_14"]*(1-Train.BSM_BR2.Value)

    S["KSR"] = S["KSR2"]*(Train.BUM_PTR1.Value+Train.BSM_RNT.Value*Train.BSM_RNT1.Value)
    Train.BSM_KSR1:TriggerInput("Set",S["KSR"])
    Train.BSM_KSR2:TriggerInput("Set",S["KSR"])

    Train.BSM_BR1:TriggerInput("Set",self.KB*((Train.BSM_BR1.Value+Train.BSM_SIR5.Value)*(1-Train.BSM_BR2.Value)))
    Train.BSM_BR2:TriggerInput("Set",self.KB*((1-Train.BSM_SIR5.Value)*(1-Train.BSM_BR1.Value)))
    S["BR12"] = Train.BSM_BR1.Value+Train.BSM_BR2.Value
    S["RNT"] = self.GE*(S["BR12"]+(Train.BSM_RNT.Value*Train.BSM_RNT1.Value)*(Train.BSM_KSR1.Value*Train.BSM_KSR2.Value+Train.BSM_KRT.Value))
    Train.BSM_RNT:TriggerInput("Set",S["RNT"])
    Train.BSM_RNT1:TriggerInput("Set",S["RNT"])
    self.Ring = self.GE*((1-Train.BSM_RNT.Value)+(1-Train.BSM_RNT1.Value))

    --Train.BSM_BR1:TriggerInput("Set",)
    S["LUDS70"] = S["LUDS"]*(Train.BLPM_5R3.Value*Train.BLPM_4R3.Value*Train.BLPM_3R3.Value*(1-Train.BLPM_2R3.Value)*Train.BLPM_2R1.Value*Train.BLPM_2R2.Value+(1-Train.BSM_SIR1.Value))
    S["LUDS60"] = S["LUDS"]*(Train.BLPM_5R3.Value*Train.BLPM_4R3.Value*(1-Train.BLPM_3R3.Value)*Train.BLPM_3R1.Value*Train.BLPM_3R2.Value+(1-Train.BSM_SIR2.Value)*(1-Train.BSM_SIR1.Value))
    S["LUDS40"] = S["LUDS"]*(Train.BLPM_5R3.Value*(1-Train.BLPM_4R3.Value)*Train.BLPM_4R1.Value*Train.BLPM_4R2.Value+(1-Train.BSM_SIR3.Value)*(1-Train.BSM_SIR2.Value)*(1-Train.BSM_SIR1.Value))
    S["LUDS0"] = S["LUDS"]*((1-Train.BLPM_5R3.Value)*Train.BLPM_5R1.Value*Train.BLPM_5R2.Value+(1-Train.BSM_SIR4.Value)*(1-Train.BSM_SIR3.Value)*(1-Train.BSM_SIR2.Value)*(1-Train.BSM_SIR1.Value))
    S["AR80"] = S["LUDS"]*Train.BSM_SIR1.Value
    S["AR70"] = S["LUDS70"]*Train.BSM_SIR2.Value
    S["AR60"] = S["LUDS60"]*Train.BSM_SIR3.Value
    S["AR40"] = S["LUDS40"]*Train.BSM_SIR4.Value
    S["AR0"] =  S["LUDS0"]*Train.BSM_SIR5.Value
    S["AR04"] = S["LUDS0"]*(1-Train.BSM_SIR5.Value)

    Train.KPK1:TriggerInput("Set",self.NGPower*((1-Train.ARS_VP.Value)*Train.FMM1.Value+Train.ARS_VP.Value*(1-Train.FMM1.Value)))
    Train.KPK2:TriggerInput("Set",self.NGPower*((1-Train.ARS_VP.Value)*(1-Train.FMM2.Value)+Train.ARS_VP.Value*Train.FMM2.Value))


    S["GEKSR"] = --[[ S["FQCheckPower"]*--]]self.GE*Train.BSM_KSR1.Value*Train.BSM_KSR2.Value
    Train.BUM_RUVD:TriggerInput("Set",S["GEKSR"]*(Train.BSM_KRO.Value+Train.BUM_RUVD.Value))
    S["RVD"] = S["GEKSR"]*(Train.BUM_RUVD.Value)
    Train.BUM_RVD1:TriggerInput("Set",S["RVD"])
    Train.BUM_RVD2:TriggerInput("Set",S["RVD"])
    Train.BUM_TR:TriggerInput("Set",S["GEKSR"])
    --Train.BUM_PTR:TriggerInput("Set",self.GE*Train.BSM_RNT.Value*Train.BSM_RNT1.Value*Train.BUM_TR.Value)
    Train.BUM_PTR:TriggerInput("Set",self.GE*Train.BUM_TR.Value)
    Train.BUM_RVT5:TriggerInput("Set",self.GE*(1-Train.BUM_TR.Value))

    S["RVT1"] = self.GE*((1-Train.BSM_SIR4.Value)*(1-Train.BUM_TR.Value)+(1-Train.BUM_PTR1.Value))
    Train.BUM_RVT1:TriggerInput("Set",S["RVT1"])
    Train.BUM_RVT2:TriggerInput("Set",S["RVT1"])
    Train.BUM_RVT4:TriggerInput("Set",S["RVT1"])
    Train.BUM_RET:TriggerInput("Set",self.GE*(1-Train.BUM_TR.Value)*Train.BUM_PTR1.Value)
    Train.BUM_PTR1:TriggerInput("Set",self.GE*Train.BUM_TR.Value)
    Train.BUM_RVZ1:TriggerInput("Set",S["RVZ1"]*(1-Train.BSM_BR2.Value))


    --EPK
    --
    S["EKR0on"] =
        self.GE*(
            Train.BSM_KRH.Value*(1-Train.BSM_KRT.Value)*(1-Train.BSM_KRO.Value)
            +(1-Train.BSM_KRH.Value)*(
                Train.BSM_PR1.Value
                +Train.BSM_BR2.Value)
            )
        +self.KT*Train.BSM_KSR1.Value*Train.BSM_KSR2.Value


    S["EKR0"] = (
            S["EKR0on"]*Train.BIS_R0.Value*(1-Train.BIS_R1.Value)
            +self.GE*((1-Train.BIS_R0.Value)+Train.BIS_R1.Value)
            --[[S["EKR0on"]*Train.BIS_R0.Value
            +self.GE*(1-Train.BIS_R0.Value)]]
        )*Train.BSM_KSR1.Value*Train.BSM_KSR2.Value*Train.BUM_PTR.Value
    S["EK1"] = S["EKR0"]+self.KT*Train.BSM_GE.Value*(1-Train.BSM_KSR1.Value)*(1-Train.BSM_KSR2.Value)*(1-Train.BUM_PTR.Value)*(1-Train.BUM_PTR1.Value)
    S["EK"] = S["EK0"]+S["EK1"]*Train.BUM_PEK.Value*Train.BUM_RIPP.Value
    S["EKt"] = 3+3*math.max(0,Train.BUM_PEK.Value*(Train.BIS_R2.Value+Train.BIS_R3.Value))

    Train.BUM_EK:TriggerInput("Set",S["EK"])
    Train.BUM_EK1:TriggerInput("Set",S["EK"])
    Train.BUM_EK:TriggerInput("OpenTime",S["EKt"])
    Train.BUM_EK:TriggerInput("OpenTime",S["EKt"])

    self.EPK = self.GE*Train.BUM_EK.Value*Train.BUM_EK1.Value
    Train.BUM_PEK:TriggerInput("Set",self.EPK)
    Train.BUM_RIPP:TriggerInput("Set",self.EPK)
    self["48"] = self.GE*(Train.BUM_RET.Value+Train.BUM_RVZ1.Value)
    self["8"] = self.GE*Train.BUM_RVT5.Value
    self["20"] = self.DA*Train.BUM_RVT1.Value
    self["33G"] = self.DA*Train.BUM_RVT2.Value
    self["2"] = self.DA*Train.BUM_RVT4.Value

    Train:WriteTrainWire(85,(1-Train.KPK2.Value)*bit.bor(ALS.F1*1,ALS.F2*2,ALS.F3*4,ALS.F4*8,ALS.F5*16,ALS.F6*32))
    Train:WriteTrainWire(73,S["LUDS"]*(1-Train.BLPM_6R3.Value)*(Train.BLPM_6R2.Value)*(Train.BLPM_6R1.Value))
    Train:WriteTrainWire(80,S["AR80"])
    Train:WriteTrainWire(79,S["AR70"])
    Train:WriteTrainWire(78,S["AR60"])
    Train:WriteTrainWire(77,S["AR40"])
    Train:WriteTrainWire(76,S["AR0"])
    Train:WriteTrainWire(75,S["AR04"])
    Train:WriteTrainWire(81,self.GE*Train.BUM_KPP.Value)
    Train:WriteTrainWire(82,S["GE"]*(Train.NG.Value*Train.FMM1.Value+Train.NH.Value*(1-Train.FMM1.Value)))
    Panel.RS = Train:ReadTrainWire(73)
    Panel.AR80 = Train:ReadTrainWire(80)
    Panel.AR70 = Train:ReadTrainWire(79)
    Panel.AR60 = Train:ReadTrainWire(78)
    Panel.AR40 = Train:ReadTrainWire(77)
    Panel.AR0  = Train:ReadTrainWire(76)
    Panel.AR04 = Train:ReadTrainWire(75)
    Panel.KT = Train:ReadTrainWire(81)
    Panel.LN = S["GE"]*Train.NG.Value+Train:ReadTrainWire(82)*Train.FMM1.Value
    --Train:WriteTrainWire(83,self.EPK*(1-Train.ARS.Value))
    --Train.EPKC:TriggerInput("Set",self.EPK+Train:ReadTrainWire(83))
end

--------------------------------------------------------------------------------
-- ARS-Ezh3 safety system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("ALS_ARS_Ezh3")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("ALSCoil")

    self.Train:LoadSystem("BIS200","ALS_ARS_BIS200")
    self.Train:LoadSystem("BLPM","ALS_ARS_BLPM")
    self.Train:LoadSystem("BSM","ALS_ARS_BSM",1)
    self.Train:LoadSystem("BUM","ALS_ARS_BUM",1)

    self.Train:LoadSystem("ROT1","Relay")
    self.Train:LoadSystem("ROT2","Relay")

    self.Train:LoadSystem("EPKC","Relay")

    -- ARS wires
    self["33D"] = 0
    self["33G"] = 0
    self["33Zh"] = 0
    self["2"] = 0
    self["6"] = 0
    self["8"] = 0
    self["20"] = 0
    --self["21"] = 0
    self["48"] = 0
    self.Ring = 0
    self.LN = 0

    self.EPK = 0
end

function TRAIN_SYSTEM:Outputs()
    return {
        "2", "8", "20", "48", "33Zh","33D", "33G", "48",
        "NoFreq","F1","F2","F3","F4","F5","F6","LN",
        "EPK",
    }
end

function TRAIN_SYSTEM:Inputs()
    return { "IgnoreThisARS","AttentionPedal","Ring" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    local Train = self.Train
    if name == "AttentionPedal" then
        self.AttentionPedal = value > 0.5
        if Train and Train.PB then
            Train.PB:TriggerInput("Set",value)
        end
    end
    if name == "IgnoreThisARS" then
        self.IgnoreThisARS = value > 0.5
    end
end

local S = {}
function TRAIN_SYSTEM:Think(dT)
    --self.CurTime = self.CurTime or CurTime()
    --if CurTime()-self.CurTime < 0.05 then return end
    --self.DeltaTime = CurTime()-self.CurTime
    --self.CurTime = CurTime()
    local Train = self.Train
    local ALS = Train.ALSCoil
    local BLPM = Train.BLPM
    local Panel = Train.Panel
---[[
    S["R0"] = ((self.GE*Train.BSM_BR2.Value
            +self.KT*Train.BSM_GE.Value*(
                 Train.BSM_KSR1.Value*Train.BSM_KSR2.Value
                *(1-Train.BSM_KRH.Value)
                *(Train.BSM_KRO.Value+Train.BSM_KRT.Value)
            )
        )*Train.BIS_R0.Value
        +self.GE*(
            (1-Train.BSM_GE.Value)
            +Train.BUM_KRD.Value
            +Train.BSM_KRO.Value*Train.BSM_KRH.Value
        )
    )*(1-Train.BIS_R2.Value)*(1-Train.BIS_R3.Value)*(1-Train.BIS_R4.Value)*(1-Train.BIS_R5.Value)*(1-Train.BIS_R6.Value)*(1-Train.BIS_R7.Value)*(1-Train.BIS_R8.Value)*(1-Train.BIS_R10.Value)
        --[[ (
         Train.BSM_KSR1.Value*Train.BSM_KSR2.Value
        *(1-Train.BSM_KRH.Value)
        *(Train.BSM_KRO.Value+Train.BSM_KRT.Value)
        *(1-Train.BIS_R2.Value)*(1-Train.BIS_R3.Value)*(1-Train.BIS_R4.Value)*(1-Train.BIS_R5.Value)*(1-Train.BIS_R6.Value)*(1-Train.BIS_R7.Value)*(1-Train.BIS_R8.Value)*(1-Train.BIS_R10.Value)
        )--]]
    --Train.BIS_R0:TriggerInput("NoOpenTime",Train.BIS_R1.Value+(1-Train.BIS_R0.Value))

    Train.BIS_R0:TriggerInput("NoOpenTime",(1-Train.BIS_R0.Value)+Train.BIS_R1.Value)
    Train.BIS_R0:TriggerInput("Set",S["R0"])

    --[[ S["RVZ1"] = S["RVZ"]*Train.BIS_R0.Value*(1-Train.BIS_R1.Value)
    S["EK0"] = S["RVZ1"]*(1-Train.BSM_GE.Value)--]]
--]]
    self.ARS = self.ARS or 0
    self.ALS = self.ALS or 0
    self.KB = self.KB or 0
    -- self.NGPower = self.NGPower or 0
    -- self.DA = self.DA or 0
    -- self.KT = self.KT or 0
    Train.BSM_GE:TriggerInput("Set",self.GE)

    S["GE"]= self.GE*Train.BSM_GE.Value
    local EnableALS = self.ALS
    if EnableALS ~= ALS.Enabled then
        ALS:TriggerInput("Enable",EnableALS)
    end

    --SR1,SR2
    S["SRPower"] = self.ALS*(1-Train.BSM_GE.Value)+S["GE"]
    S["1SIR"] = S["SRPower"]*(1-Train.BLPM_1R3.Value)*Train.BLPM_1R1.Value*Train.BLPM_1R2.Value
    S["2SIR"] = S["SRPower"]*Train.BLPM_1R3.Value*(1-Train.BLPM_2R3.Value)*Train.BLPM_2R1.Value*Train.BLPM_2R2.Value
    S["3SIR"] = S["SRPower"]*Train.BLPM_1R3.Value*Train.BLPM_2R3.Value*(1-Train.BLPM_3R3.Value)*Train.BLPM_3R1.Value*Train.BLPM_3R2.Value
    S["4SIR"] = S["SRPower"]*Train.BLPM_1R3.Value*Train.BLPM_2R3.Value*Train.BLPM_3R3.Value*(1-Train.BLPM_4R3.Value)*Train.BLPM_4R1.Value*Train.BLPM_4R2.Value
    S["5SIR"] = S["SRPower"]*Train.BLPM_1R3.Value*Train.BLPM_2R3.Value*Train.BLPM_3R3.Value*Train.BLPM_4R3.Value*(1-Train.BLPM_5R3.Value)*Train.BLPM_5R1.Value*Train.BLPM_5R2.Value
    S["NF"] = S["SRPower"]*Train.BLPM_1R3.Value*Train.BLPM_2R3.Value*Train.BLPM_3R3.Value*Train.BLPM_4R3.Value*Train.BLPM_5R3.Value

    Train.BSM_SIR1:TriggerInput("Set",
        S["SRPower"]*Train.BSM_SR1.Value*Train.BSM_SIR1.Value+
        S["1SIR"]*(1-Train.BSM_SR1.Value)--*(1-Train.BSM_SR2.Value)
    )
    Train.BSM_SIR2:TriggerInput("Set",
        S["SRPower"]*Train.BSM_SR1.Value*(Train.BSM_SIR1.Value+Train.BSM_SIR2.Value)+
        S["2SIR"]*(1-Train.BSM_SR1.Value)--*(1-Train.BSM_SR2.Value)
    )
    Train.BSM_SIR3:TriggerInput("Set",
        S["SRPower"]*Train.BSM_SR1.Value*(Train.BSM_SIR2.Value+Train.BSM_SIR3.Value)+
        S["3SIR"]*(1-Train.BSM_SR1.Value)--*(1-Train.BSM_SR2.Value)
    )
    Train.BSM_SIR4:TriggerInput("Set",
        S["SRPower"]*Train.BSM_SR1.Value*(Train.BSM_SIR3.Value+Train.BSM_SIR4.Value)+
        S["4SIR"]*(1-Train.BSM_SR1.Value)--*(1-Train.BSM_SR2.Value)
    )
    Train.BSM_SIR5:TriggerInput("Set",
        S["SRPower"]*Train.BSM_SR1.Value*(Train.BSM_SIR1.Value+Train.BSM_SIR2.Value+Train.BSM_SIR3.Value+Train.BSM_SIR4.Value+Train.BSM_SIR5.Value)+
        S["5SIR"]*(1-Train.BSM_SR1.Value)--*(1-Train.BSM_SR2.Value)
    )
    S["SRSIR5"] = (S["5SIR"]*Train.BSM_SIR5.Value)
    S["SRSIR4"] = (S["4SIR"]*Train.BSM_SIR4.Value)
    S["SRSIR3"] = (S["3SIR"]*Train.BSM_SIR3.Value)
    S["SRSIR2"] = (S["2SIR"]*Train.BSM_SIR2.Value)
    S["SRSIR1"] = (S["1SIR"]*Train.BSM_SIR1.Value)
    ---[[
    S["SR"] =
            S["NF"]*(1-Train.BSM_SIR5.Value)*(1-Train.BSM_SIR4.Value)*(1-Train.BSM_SIR3.Value)*(1-Train.BSM_SIR2.Value)*(1-Train.BSM_SIR1.Value)+
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
        S["R8"]*Train.BSM_SIR2.Value+
        S["R7"]*Train.BSM_SIR3.Value+
        S["R5"]*Train.BSM_SIR4.Value

    S["BR1_16"] = S["R3"]*Train.BSM_SIR5.Value
    S["BR2_16"] = S["R3"]*(1-Train.BSM_SIR5.Value)

    S["KSR"] = S["BR1_14"]*(1-Train.BSM_BR1.Value)*(1-Train.BSM_BR2.Value)+S["BR1_16"]*Train.BSM_BR1.Value+S["BR2_16"]*Train.BSM_BR2.Value
    Train.BSM_KSR1:TriggerInput("Set",S["KSR"])
    Train.BSM_KSR2:TriggerInput("Set",S["KSR"])

    Train.BSM_BR1:TriggerInput("Set",S["SRPower"]*Train.PB.Value*((Train.BSM_BR1.Value+Train.BSM_SIR5.Value)*(1-Train.BSM_BR2.Value)))
    Train.BSM_BR2:TriggerInput("Set",S["SRPower"]*Train.PB.Value*((Train.BSM_BR2.Value+(1-Train.BSM_SIR5.Value))*(1-Train.BSM_BR1.Value)))

    --Old RNT with confirmation from PB OR KVT
    --Train.BSM_RNT:TriggerInput("Set",self.ALS*(Train.BSM_BR1.Value+Train.BSM_BR2.Value+Train.KVT.Value+Train.BSM_RNT.Value*(Train.BSM_KSR1.Value*Train.BSM_KSR2.Value+Train.BSM_KRT.Value)))
    
    -- New RNT with confirmation only from KVT
    Train.BSM_RNT:TriggerInput("Set",self.ALS*(Train.KVT.Value+Train.BSM_RNT.Value*(Train.BSM_BR1.Value+Train.BSM_BR2.Value+Train.BSM_KSR1.Value*Train.BSM_KSR2.Value+Train.BSM_KRT.Value)))

    self.Ring = self.GE*(1-Train.BSM_RNT.Value)*(1-Train.BSM_RVV.Value)

    S["LUDS"] = S["SRPower"]*Train.BSM_SR1.Value*Train.BSM_SR2.Value
    S["AR80"] = S["LUDS"]*Train.BSM_SIR1.Value
    S["AR70"] = S["LUDS"]*(1-Train.BSM_SIR1.Value)*Train.BSM_SIR2.Value 
    S["AR60"] = S["LUDS"]*(1-Train.BSM_SIR1.Value)*(1-Train.BSM_SIR2.Value)*Train.BSM_SIR3.Value
    S["AR40"] = S["LUDS"]*(1-Train.BSM_SIR1.Value)*(1-Train.BSM_SIR2.Value)*(1-Train.BSM_SIR3.Value)*Train.BSM_SIR4.Value
    S["AR0"] =  S["LUDS"]*(1-Train.BSM_SIR1.Value)*(1-Train.BSM_SIR2.Value)*(1-Train.BSM_SIR3.Value)*(1-Train.BSM_SIR4.Value)*Train.BSM_SIR5.Value
    S["AR04"] = S["LUDS"]*(1-Train.BSM_SIR1.Value)*(1-Train.BSM_SIR2.Value)*(1-Train.BSM_SIR3.Value)*(1-Train.BSM_SIR4.Value)*(1-Train.BSM_SIR5.Value)

    Train.BSM_RVV:TriggerInput("Set",Train.ARS.Value*(1-Train.KVT.Value)*Train.BSM_RNT.Value)

    S["GEKSR"] = S["GE"]*Train.BSM_RVV.Value*Train.BSM_KSR1.Value*Train.BSM_KSR2.Value
    Train.BUM_RB:TriggerInput("Set",S["GEKSR"])
    Train.BUM_RUVD:TriggerInput("Set",S["GEKSR"]*(Train.BSM_KRO.Value+Train.BUM_RUVD.Value))
    S["RVD"] = S["GEKSR"]*(1-Train.BSM_KRT.Value)*Train.BUM_RUVD.Value
    Train.BUM_RVD1:TriggerInput("Set",S["RVD"])
    Train.BUM_RVD2:TriggerInput("Set",S["RVD"])
    Train.BUM_TR:TriggerInput("Set",self.ALS*Train.BSM_RVV.Value*Train.BSM_KSR1.Value*Train.BSM_KSR2.Value)
    --Train.BUM_PTR:TriggerInput("Set",self.GE*Train.BUM_TR.Value)
    --Train.BUM_RVT5:TriggerInput("Set",self.GE*(1-Train.BUM_TR.Value))
    S["RVT1"] = self.GE*(1-Train.BUM_TR.Value)
    Train.BUM_RVT1:TriggerInput("Set",S["RVT1"])
    Train.BUM_RVT2:TriggerInput("Set",S["RVT1"])
    Train.BUM_RVT4:TriggerInput("Set",S["RVT1"])
    Train.BUM_RET:TriggerInput("Set",S["RVT1"])
    Train.BUM_RVT5:TriggerInput("Set",S["RVT1"]*(1-Train.BUM_PTR.Value))

    Train.BUM_PTR:TriggerInput("Set",self.GE*Train.BUM_TR.Value)
    Train.BUM_RVZ1:TriggerInput("Set",self.GE*(1-Train.BSM_BR2.Value)*(1-Train.BSM_KRH.Value)*(1-Train.BSM_BR1.Value)*Train.BIS_R0.Value)
    Train.BSM_RUT:TriggerInput("Set",self.DA*(Train.BIS_R6.Value+Train.BIS_R7.Value+Train.BIS_R8.Value+Train.BIS_R10.Value))
    --EPK
    --
    --[=[ S["EKR0on"] =
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
--]=]
    S["AntiRol"] = (1-Train.BIS_R0.Value)*(1-Train.BIS_R1.Value)*(1-Train.BIS_R2.Value)*(1-Train.BIS_R3.Value)*(1-Train.BIS_R4.Value)*(1-Train.BIS_R5.Value)*(1-Train.BIS_R6.Value)*(1-Train.BIS_R7.Value)*(1-Train.BIS_R8.Value)*(1-Train.BIS_R10.Value)*Train.BSM_KRH.Value*Train.BSM_SIR5.Value
    S["EKt60"] = (1-Train.BIS_R10.Value)*(1-Train.BIS_R8.Value)*(1-Train.BIS_R7.Value)
    S["EKt50"] = S["EKt60"]*(1-Train.BIS_R6.Value)
    S["EKt30"] = S["EKt50"]*(1-Train.BIS_R5.Value)*(1-Train.BIS_R4.Value)
    S["EKt"] = (3.2+S["EKt60"]*0.7+S["EKt50"]*1.3+S["EKt30"]*2.7)--*(Train.BIS_R0.Value+Train.BIS_R1.Value+)
    S["EK"] = (self.KT*((1-Train.BSM_KSR1.Value)*(1-Train.BSM_KSR2.Value)+Train.BIS_R0.Value)+S["GE"]*(Train.BUM_KRD.Value+Train.BSM_KSR1.Value*Train.BSM_KSR2.Value)*((1-Train.BIS_R0.Value*Train.BSM_SIR5.Value)))*Train.BUM_RVEK1.Value*Train.BUM_RVEK2.Value+S["R0"]*(1-Train.BSM_GE.Value)
    Train.BUM_EK:TriggerInput("Set",S["EK"])
    --Train.BUM_EK1:TriggerInput("Set",S["EK"])
    Train.BUM_EK:TriggerInput("OpenTime",S["EKt"])
    Train.BUM_EK:TriggerInput("NoOpenTime",S["AntiRol"])

    --Train.BUM_EK:TriggerInput("OpenTime",S["EKt"])

    self.EPK = self.GE*Train.BUM_EK.Value
    Train.BUM_RVEK1:TriggerInput("Set",self.EPK)
    Train.BUM_RVEK2:TriggerInput("Set",self.EPK)
    self["48"] = self.GE*Train.BUM_RVZ1.Value
    self["8"] = self.GE*Train.BUM_RVT5.Value
    self["20"] = self.DAR*Train.BUM_RVT1.Value
    self["33D"] = Train.BUM_RVD1.Value
    self["33G"] = self.DAR*Train.BUM_RVT2.Value
    self["33Zh"] = Train.BUM_RB.Value
    self["2"] = self.DA*Train.BUM_RVT4.Value
    Panel.AR80 = S["AR80"]
    Panel.AR70 = S["AR70"]
    Panel.AR60 = S["AR60"]
    Panel.AR40 = S["AR40"]
    Panel.AR0  = S["AR0"]
    Panel.AR04 = S["AR04"]
    Panel.KT = self.KT*Train.BSM_GE.Value
    Panel.KVD = self.GE*(1-Train.BUM_RUVD.Value)
    --Train:WriteTrainWire(90,self.EPK*(1-Train.ARS.Value))
    Train.EPKC:TriggerInput("Set",self.EPK)
end

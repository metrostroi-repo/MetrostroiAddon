--------------------------------------------------------------------------------
-- I/O module between PA and electric schemes
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PAM_VV")
function TRAIN_SYSTEM:Initialize()
    self.Power = 0
    self.KGR = 0
    self.KRR = 0 --Контроль нулевого положения реверсивной рукоятки головного вагона
    self.KRR1 = 0 --Контроль нулевого положения реверсивной рукоятки хвостового вагона
    self.KRR2 = 0 --Контроль реверсивной рукоятки, установленной в положение «Назад»
    self.KRT = 0
    self.KRH = 0
    self.KB = 0
    self.KZP = 0
    self.KET = 0
    self.LPT = 0
    self.KSOT = 0
    self.KSZD = 0
    self.KPRK = 0
    self.KDL = 0
    self.KDP = 0

    self.ZD = 0
    self.K16 = 0
    self.KD = 0
    self.KRU = 0

    self.KVARS = 0
    self.KTARS = 0
    self.VRD = 0

    self.V1 = 0
    self.V2 = 0

    self.I2 = 0
    self.I3 = 0
    self.I25 = 0
    self.I33G = 0
    self.I33 = 0
end


--if TURBOSTROI then return end
function TRAIN_SYSTEM:Inputs()
    return {
    }
end
function TRAIN_SYSTEM:Outputs()
    return {
        "Power",
        "KGR","KRR","KRR1","KRR2","KRT","KRH","KB","KZP","KET","LPT","KSOT","KSZD","KPRK","KDL","KDP","ZD","K16","KD","KRU","KVARS","KTARS","VRD",
        "V1","V2",
        "I2","I3","I25","I33G","I33"
    }
end

--------------------------------------------------------------------------------
-- 81-717 Moscow and SPB electric schemes
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_717_Electric")
TRAIN_SYSTEM.MVM = 1
TRAIN_SYSTEM.LVZ_1 = 2 --BARS
TRAIN_SYSTEM.LVZ_2 = 3 --PUAV
TRAIN_SYSTEM.LVZ_3 = 4 --PAM
TRAIN_SYSTEM.LVZ_4 = 5 --PA-KSD
function TRAIN_SYSTEM:Initialize(typ1,typ2)
    self.TrainSolver = "81_717"
    self.ThyristorController = true
    self.Type = self.Type or self.MVM

    -- Load all functions from base
    Metrostroi.BaseSystems["Electric"].Initialize(self)
    for k,v in pairs(Metrostroi.BaseSystems["Electric"]) do
        if not self[k] and type(v) == "function" then
            self[k] = v
        end
    end
end

if CLIENT then return end
function TRAIN_SYSTEM:Inputs(...)
    return { "Type", "NoRT2", "HaveRO", "GreenRPRKR","X2PS", "HaveVentilation" }
end
function TRAIN_SYSTEM:Outputs(...)
    return Metrostroi.BaseSystems["Electric"].Outputs(self,...)
end
function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "Type" then
        self.Type = value
    end
    if name == "NoRT2" then self.NoRT2 = value > 0 end
    if name == "HaveRO" then self.HaveRO = value > 0 end
    if name == "GreenRPRKR" then self.GreenRPRKR = value > 0 end
    if name == "X2PS" then self.X2PS = value > 0 end
    if name == "HaveVentilation" then self.Vent = value > 0 end
end

-- Node values
local S = {}
-- Converts boolean expression to a number
local function C(x) return x and 1 or 0 end

local min = math.min
local max = math.max

function TRAIN_SYSTEM:SolveAllInternalCircuits(Train,dT,firstIter)
    local P     = Train.PositionSwitch
    local RheostatController = Train.RheostatController
    local RK    = RheostatController.SelectedPosition
    local B     = (Train.Battery.Voltage > 55) and 1 or 0
    local BO    = B*Train.VB.Value
    local T     = Train.SolverTemporaryVariables
    local elType = self.Type
    local isMVM = elType == 1
    local isLVZ = elType ~= 1
    local isPUAV = isLVZ and elType < 4
    local isPA = isLVZ and not isPUAV
    local isKSD = isPA and elType==5

    local KV = Train.KV
    local KRU = Train.KRU
    local Panel = Train.Panel
    Panel.V1 = BO
    local RC1 = Train.RC1.Value
    local ARS = Train.ALS_ARS
    local RC2,AVI,AVO

    S["10AK"] = T[10]*Train.A54.Value*Train.A84.Value
    S["U2"] = S["10AK"]*KV["U2-10AK"] --10AK-KV-U2

    --Reverser
    S["7D"] = T[10]*Train.A48.Value
    S["7G"] = S["7D"]*KV["10-7G"] --10-A48-RV-7G --FIXME 34w ARS
    S["B3"] = B*Train.A44.Value
    S["14a"] = S["B3"]*KRU["14/1-B3"]
    S["14b"] = S["14a"]*Train.A17.Value
    S["F"] = T[10]*Train.A29.Value
    S["F7"] = S["F"]*KV["F-F7"]+S["14b"]*KRU["11/3-FR1"]

    Train:WriteTrainWire(5,S["10AK"]*KV["10AK-5"] + KRU["5/3-ZM31"]*-10)
    Train:WriteTrainWire(4,S["10AK"]*KV["10AK-4"]*(1-T[4]*KV["4-0"]*-10))

    Panel.LST = T[6]*Train.A40.Value
    Panel.LhRK = T[2]*Train.A57.Value
    Panel.LVD = T[1]*Train.A60.Value
    Panel.LUDS = T[10]*Train.AIS.Value
    if isLVZ then
        RC2 = isKSD and RC1 or Train.RC2.Value

        Panel.LSN = (math.max(0,T[20])+S["14b"])*T[18]
        --[[ S["7Ga"] = S["7G"]*Train.A79.Value
        ARS.FMM1 = S["14a"]*Train.A42.Value+S["7Ga"]
        ARS.FMM2 = S["F7"]
        ARS.GE = (ARS.FMM1*Train.ARS.Value+T[87]*(1-Train.ARS.Value))*RC1
        Train:WriteTrainWire(87,S["B3"]*Train.ARSR.Value*(1-RC1))
        Train:WriteTrainWire(91,(S["B3"]*Train.ARSR.Value+T[87]+ARS.FMM1*Train.ARS.Value)*Train.PB.Value+T[87]*Train.ARSR.Value*Train.KVTR.Value)
        ARS.VP = ARS.FMM1*Train.VP.Value
        Train:WriteTrainWire(88,ARS.FMM1*Train.ALSFreq.Value*(1-Train.VP.Value))
        ARS.PD = T[88]
        ARS.ALS = T[10]*Train.A43.Value*Train.ALS.Value
        Train.BLPM.Power = ARS.ALS
        ARS.NGPower = S["7D"]*RC1
        Train.BIS200.Power = T[10]*Train.A43.Value*(Train.ALS.Value+Train.ARS.Value)
        ARS.KB=T[91]*RC1+(ARS.ALS*(1-Train.BSM_GE.Value)+ARS.GE*Train.BSM_GE.Value)*Train.KVT.Value
--]]
        S["14bx"] = S["14b"]*Train.KRP.Value
        S["KRH"] = max(0,T[1])+S["14bx"]
        ARS.KRH = S["KRH"]*RC1
        ARS.KRO = S["7G"]*(1-Train.KRP.Value)*KV["7GA-RC27"]*RC1
        ARS.KRT = (max(0,Panel.LST)+max(0,T[8]))*RC1
        S["14G"] = S["7G"]*Train.A42.Value+S["14a"]*Train.A42.Value
        ARS.ARSPower = S["14G"]*Train.ARS.Value*RC1
        ARS.ALS = S["14G"]
        ARS.ALSPower = ARS.ALS*Train.ALS.Value*RC1
        ARS.VRD = S["14G"]*Train.VRD.Value*RC1
        ARS.KB=S["14G"]*(Train.PB.Value+Train.KVT.Value)*RC1
        if isPUAV then
            Train:WriteTrainWire(53,S["14G"]*Train.A61.Value)
        else
            Train:WriteTrainWire(53,(S["10AK"]*KV["10AK-DA"]+S["14a"]*Train.A42.Value)*Train.A61.Value)
        end
        Train:WriteTrainWire(54,0)
        --ARS.KRO = (T[87]+S["7Ga"]*KV["7GA-RC27"]+S["14a"]*Train.A42.Value*(1-Train.KRP.Value))*(1-Train.BSM_KRH.Value)

        --Train.ROT1:TriggerInput("Set",ARS["33G"]*RC1+(1-RC1))
        --Train.ROT2:TriggerInput("Set",ARS["33G"]*RC1+(1-RC1))
        --Panel.LKVD = ARS.GE*(1-Train.BUM_RVD2.Value)+T[87]*(1-Train.ROT2.Value)

        S["7Gv"] = S["14G"]*RC1*Train.ARS.Value*ARS.EPK*Train.A43.Value

        if isPUAV then
            AVI = Train.PUAV
            AVO = Train.PUAV

            --AVI.KRT = T[6]*RC2
            AVI.Power = T[10]*Train.VAU.Value*Train.A58.Value
            AVI.ALSPower = S["14G"]*Train.A55.Value
            AVI.KRT = (max(0,Panel.LST)+max(0,T[8]))*RC2
            AVI.KRH = S["KRH"]*RC2
            AVI.KGR = KV["15A-15B"]
            AVI.KRR1 = BO*Train.VAU.Value*Train.A59.Value*KV["10-7G"]--T[53]
            AVI.KRR2 = T[54]
            AVI.KRR3 = T[4]
            AVI.KPRK = RheostatController.Position
            AVI.KOAT = T[64]
            AVI.KET = T[34]*T[-34]
            AVI.KSOT = Train.SOT.Value
            AVI.RK1 = C(RK==1)
            AVI.KRU = KRU["14/1-B3"]
            AVI.K16 = T[16]

            AVI.KVARS = ARS.ARSPower
            AVI.KTARS = ARS["6"]
            AVI.VRD = S["14G"]*Train.VRD.Value*RC2
            AVI.VAV = Train.VAV.Value
            AVI.KH3 = Train.KH.Value
            AVI.VZP = Train.VZP.Value
            AVI.KSZD = Train.KSZD.Value
            AVI.KB=S["14G"]*(Train.PB.Value+Train.KVT.Value)*RC2
            Panel.BURPower = BO*Train.A66.Value
        else
            AVI = Train.PAM_VV
            AVO = Train.PAM

            S["10-58"] = T[10]*Train.A58.Value
            if isKSD then
                Train:WriteTrainWire(99,S["10-58"]*(Train.VPAOn.Value+Train.KSD_VAU.Value))
                Train:WriteTrainWire(98,S["10-58"]*Train.VPAOff.Value)
                Train.KSD_VAU:TriggerInput("Set",(T[99]+S["10-58"]*Train.KSD_VAU.Value)*max(0,1-T[98])*RC1)
                AVI.Power = S["10-58"]*Train.KSD_VAU.Value*RC1
                RC2 = RC1
            else
                AVI.Power = S["10-58"]*Train.VAU.Value*RC2
                AVI.KVARS = ARS.ARSPower*RC1
                AVI.KTARS = ARS["6"]*RC1
            end
            AVI.KGR = KV["15A-15B"]
            AVI.KRR = T[53]*RC2
            AVI.KRR1 = T[54]*RC2
            AVI.KRR2 = T[4]*RC2

            --AVI.KRT = T[6]*RC2
            AVI.KRT = (max(0,Panel.LST)+max(0,T[8]))*RC2
            AVI.KRH = S["KRH"]*RC2
            AVI.KB=S["14G"]*(Train.PB.Value+Train.KVT.Value)*RC2

            AVI.KZP = Train.VZP.Value
            AVI.KET = T[34]*T[-34]
            AVI.LPT = T[64]

            AVI.KSOT = Train.SOT.Value*RC2
            AVI.KSZD = Train.KSZD.Value*RC2

            AVI.KPRK = RheostatController.Position*RC2
            --AVI.RK1 = C(RK==1)
            AVI.K16 = T[16]
            AVI.KRU = BO*KRU["14/1-B3"]*RC2

            AVI.VRD = S["14G"]*Train.VRD.Value*RC2

            AVI.V1 = T[48]*RC2
            AVI.V2 = T[39]*RC2
        end
        ARS.DA = S["10AK"]*KV["10AK-DA"]

        Train:WriteTrainWire(39,S["14G"]*(1-Train.OVT.Value)*(1-Train.RPB.Value)+AVO["39"]*RC2)

        if isKSD then
            S["7Ga"] = AVI.Power*AVO["7GA"]*RC1
            S["7Gb"] = (1-RC1)*Train.PB.Value
            Train.RPB:TriggerInput("Set",S["14G"]*(S["7Ga"]+S["7Gb"]))

            S["33Yu"] = S["7G"]*KV["7G-33Yu"]*(AVO["033"]*RC1+(1-RC1)) --7G-SOT/UOS-KV
            S["33Yu0"] = (Train.RPB.Value+Train.VAH.Value)*(Train.KD.Value+Train.VAD.Value) --RVT-RPB/VAH-KD/VAD-0
            Train.RV2:TriggerInput("Set",S["33Yu"]*S["33Yu0"])

            Train:WriteTrainWire(1,S["10AK"]*Train.R1_5.Value+KRU["1/3-ZM31"]*-10)
            Train:WriteTrainWire(2,S["U2"]*KV["U2-2"]+AVO["2"]*RC1+KRU["2/3-ZM31"]*-10) --U2-KV-2 FIXME ARS?
            Train:WriteTrainWire(3,S["U2"]*KV["U2-3"]+AVO["3"]*RC1+T[2]*KRU["2/3-ZM31"])
            Train:WriteTrainWire(6,S["10AK"]*Train.K6.Value)
            Train:WriteTrainWire(8,BO*(KV["10-8"]+AVO["8"]*RC1)*Train.A41.Value)--10-KV-8 FIXME ARS
            --Train:WriteTrainWire(14,S["14bx"]*(AVO["033"]*RC1))
            Train:WriteTrainWire(14,S["14bx"]*(1-Train.Rp8.Value))
            Train:WriteTrainWire(20,S["U2"]*KV["U2-20a"]*(AVO["20X"]*RC1+(1-RC1))+(AVO["20"]*RC1+S["U2"]*KV["U2-20b"])+KRU["20/3-ZM31"]*-10)
            Train:WriteTrainWire(25,(S["U2"]*KV["U2-25"]*Train.A55.Value+AVO["25"]*RC1)*Train.K25.Value)
            Train.Rp8:TriggerInput("Set",T[8])

            S["U2a"] = AVO["33G"]*RC1+S["U2"]*KV["U2-U2a"] --U2-KV-U2a
            S["19B"] = S["10AK"]*KV["10AK-DA"]*(AVO["033"]*RC1+(1-RC1)) --DA-19B
            Train:WriteTrainWire(19,(S["19B"]*(KV["19B-19"]+Train.RO.Value)*(AVO["19"]*RC1+(1-RC1))+S["10AK"]*KV["10AK-DA"]*KV["U2-25"]*Train.RO.Value)*Train.A71.Value) --19B-KV/RO-A71-19

            S["33"] = (S["19B"]*Train.RV2.Value+AVO["33"]*RC1)*Train.UAVAC.Value*(Train.AVU.Value+Train.OtklAVU.Value)
            Train.R1_5:TriggerInput("Set",S["33"])
            Train.RVT:TriggerInput("Set",S["U2a"])
            Train.K25:TriggerInput("Set",S["U2a"]*(AVO["025"]*RC1+(1-RC1)))
            Train.K6:TriggerInput("Set",S["10AK"]*Train.RVT.Value) --10AK-K6

            AVI["I2"]   = S["U2"]*KV["U2-2"]*RC1
            AVI["I3"]   = S["U2"]*KV["U2-3"]*RC1
            AVI["I25"]  = S["U2"]*KV["U2-25"]*Train.A55.Value*RC1
            AVI["I33G"] = S["U2"]*KV["U2-U2a"]*RC1
            AVI["I33"]  = min(1,S["33Yu"]*S["33Yu0"]*RC1)
            Train.EPKC:TriggerInput("Set",AVO["EPK"])
            Panel.LKVD = 0
        else
            Train.EPKC:TriggerInput("Set",S["7Gv"])
            S["7Ga"] = Train.A42.Value*Train.ARS.Value*RC1
            S["7Gb"] = ((1-RC2) + AVI.Power)*(1-RC1)*Train.PB.Value
            Train.RPB:TriggerInput("Set",S["14G"]*(S["7Ga"]+S["7Gb"]))

            S["33Yu"] = S["7G"]*(Train.SOT.Value*RC1+(1-RC1))*KV["7G-33Yu"]*(AVO["033"]*RC2+(1-RC2)) --7G-SOT/UOS-KV
            S["33Yu0"] = (Train.RPB.Value+Train.VAH.Value)*(Train.KD.Value+Train.VAD.Value) --RVT-RPB/VAH-KD/VAD-0
            Train.RV2:TriggerInput("Set",S["33Yu"]*S["33Yu0"])

            Train:WriteTrainWire(1,S["10AK"]*Train.R1_5.Value+KRU["1/3-ZM31"]*-10)
            Train:WriteTrainWire(2,S["U2"]*KV["U2-2"]+ARS["6"]*RC1+AVO["2"]*RC2+KRU["2/3-ZM31"]*-10) --U2-KV-2 FIXME ARS?
            Train:WriteTrainWire(3,S["U2"]*KV["U2-3"]+AVO["3"]*RC2+T[2]*KRU["2/3-ZM31"])
            Train:WriteTrainWire(6,S["10AK"]*Train.K6.Value)
            Train:WriteTrainWire(8,BO*(KV["10-8"]+--[[ math.max(0,--]] ARS["8"]*RC1--[[ )--]] +AVO["8"]*RC2)*Train.A41.Value)--10-KV-8 FIXME ARS
            Train:WriteTrainWire(14,S["14bx"]*(1-Train.Rp8.Value))
            Train:WriteTrainWire(20,S["U2"]*KV["U2-20a"]*(ARS["33G"]*RC1+(1-RC1))*(AVO["20X"]*RC2+(1-RC2))+(ARS["6"]*RC1+AVO["20"]*RC2+S["U2"]*KV["U2-20b"])+KRU["20/3-ZM31"]*-10)
            Train:WriteTrainWire(25,(S["U2"]*KV["U2-25"]*Train.A55.Value+AVO["25"]*RC2)*Train.K25.Value)
            Train.Rp8:TriggerInput("Set",T[8])

            ARS.K25 = S["U2"]*KV["U2-25"]*Train.A55.Value
            S["U2a"] = ARS["6"]*RC1+AVO["33G"]*RC2+S["U2"]*KV["U2-U2a"] --U2-KV-U2a
            S["19B"] = S["10AK"]*KV["10AK-DA"]*(ARS["33G"]*RC1+(1-RC1))*(AVO["033"]*RC2+(1-RC2)) --DA-19B
            Train:WriteTrainWire(19,(S["19B"]*(KV["19B-19"]+Train.RO.Value)*(AVO["19"]*RC2+(1-RC2))+S["10AK"]*KV["10AK-DA"]*KV["U2-25"]*Train.RO.Value)*Train.A71.Value) --19B-KV/RO-A71-19

            S["33"] = (S["19B"]*Train.RV2.Value+AVO["33"]*RC2)*Train.UAVAC.Value*(Train.AVU.Value+Train.OtklAVU.Value)
            Train.R1_5:TriggerInput("Set",S["33"])
            Train.RVT:TriggerInput("Set",S["U2a"])
            Train.K25:TriggerInput("Set",S["U2a"]*(ARS["33Zh"]*RC1+(1-RC1))*(AVO["025"]*RC2+(1-RC2)))
            Train.K6:TriggerInput("Set",S["10AK"]*Train.RVT.Value) --10AK-K6

            AVI["I2"]   = S["U2"]*KV["U2-2"]*RC2
            AVI["I3"]   = S["U2"]*KV["U2-3"]*RC2
            AVI["I25"]  = S["U2"]*KV["U2-25"]*Train.A55.Value*RC2
            AVI["I33G"] = S["U2"]*KV["U2-U2a"]*RC2
            AVI["I33"]  = min(1,S["33Yu"]*S["33Yu0"]*RC2)

            Panel.LKVD =ARS.KVD
        end


        S["U4"] = S["10AK"]*KV["10AK-U4"]*Train.A74.Value--10AK-KV-U4
        Train:WriteTrainWire(17,S["U4"]*Train.VozvratRP.Value*(AVO["17"]*RC2+(1-RC2)))
        Train:WriteTrainWire(71,S["U4"]*Train.OtklBV.Value)
        Train:WriteTrainWire(24,Panel.LSN*Train.KSN.Value)
        Panel.M8 = T[10]*Train.AV1.Value*Train.PVK.Value

        Train:WriteTrainWire(66,S["F"]*(1-Train.VSOSD.Value))
        Train:WriteTrainWire(67,T[66]*Train.VSOSD.Value)
        Panel.SOSD = T[67]*(1-Train.KD.Value)

        local ASNP_VV = Train.ASNP_VV
        Panel.UPOPower = BO*(KV["10AK-DA"]+S["14a"])
        ASNP_VV.AmplifierPower = Panel.UPOPower*Train.R_UPO.Value*(KV["UPO-13"]+S["14a"])*Train.UPO.LineOut
        Train:WriteTrainWire(13,ASNP_VV.AmplifierPower)
        Train:WriteTrainWire(-13,ASNP_VV.AmplifierPower*Train.PowerSupply.X2_2)
        ASNP_VV.CabinSpeakerPower = ASNP_VV.AmplifierPower*Train.R_G.Value

        Train:WriteTrainWire(13,ASNP_VV.AmplifierPower)

        Panel.AnnouncerPlaying = T[13]
        Panel.AnnouncerBuzz = T[-13]

        Panel.NMLow = BO*C(Train.Pneumatic.TrainLinePressure < 5.8 or Train.Pneumatic.TrainLinePressure > 8.3)
        Panel.UAVATriggered = BO*(1-Train.UAVAC.Value+Train.PneumaticNo1.Value*C(Train.Pneumatic.BrakeCylinderPressure < 0.6))
    else
        Panel.LSN = S["U2"]*T[18]
        --ARSD
        S["7Ga"] = S["7G"]*Train.A79.Value
        ARS.FMM1 = S["14a"]*Train.A42.Value+S["7Ga"]
        ARS.FMM2 = S["F7"]
        ARS.GE = (ARS.FMM1*Train.ARS.Value+T[87]*(1-Train.ARS.Value))*RC1
        Train:WriteTrainWire(87,S["B3"]*Train.ARSR.Value*(1-RC1))
        Train:WriteTrainWire(91,(S["B3"]*Train.ARSR.Value+T[87]+ARS.FMM1*Train.ARS.Value)*Train.PB.Value+T[87]*Train.ARSR.Value*Train.KVTR.Value)
        ARS.VP = ARS.FMM1*Train.VP.Value
        Train:WriteTrainWire(88,ARS.FMM1*Train.ALSFreq.Value*(1-Train.VP.Value))
        ARS.PD = T[88]
        ARS.ALS = T[10]*Train.A43.Value*Train.ALS.Value
        Train.BLPM.Power = ARS.ALS
        ARS.NGPower = S["7D"]*RC1
        Train.BIS200.Power = T[10]*Train.A43.Value*(Train.ALS.Value+Train.ARS.Value)*Train.AIS.Value
        ARS.KB=T[91]*RC1+(ARS.ALS*(1-Train.BSM_GE.Value)+ARS.GE*Train.BSM_GE.Value)*Train.KVT.Value

        Train.BSM_KRT:TriggerInput("Set",(max(0,T[6])+max(0,T[8]))*RC1)
        Train.BSM_KRH:TriggerInput("Set",(max(0,T[1])+T[14])*RC1)
        Train.BSM_KRO:TriggerInput("Set",(T[87]+S["7Ga"]*KV["7GA-RC27"]+S["14a"]*Train.A42.Value*(1-Train.KRP.Value))*(1-Train.BSM_KRH.Value))

        Panel.LKVD = ARS.GE*(1-Train.BUM_RVD2.Value)+T[87]*(1-Train.ROT2.Value)

        Train.ARS_RT:TriggerInput("Set",T[4]*RC1)
        ARS.DA = S["10AK"]*(KV["10AK-DA"]+Train.ARS_RT.Value)
        Train.UPPS_VV.Power = S["7G"]*Train.UPPS_On.Value
        Train.UPPS_VV.KB = Train.UPPS_VV.Power*(Train.KVT.Value+Train.PB.Value)

        Train:WriteTrainWire(92,ARS.DA*RC1*Train.BUM_RVD1.Value+S["7D"]*(1-RC1)*Train.A58.Value*Train.KAH.Value)
        Train:WriteTrainWire(93,ARS.GE*Train.BUM_RVD2.Value*RC1+S["B3"]*(1-RC1)*Train.A59.Value*Train.KAH.Value)
        Train.ROT1:TriggerInput("Set",T[92])
        Train.ROT2:TriggerInput("Set",T[93])
        --ARSDEnd

        --Old logic
        --Train:WriteTrainWire(39,S["7G"]*(1-Train.OVT.Value)*(1-Train.RPB.Value))
        --S["7Gb"] = S["7Ga"]*(Train.PB.Value+(Train.ARS.Value+T[91]+(T[87]+S["B3"]*Train.ARSR.Value)*(1-RC1))*(1-Train.UOS.Value))

        Train:WriteTrainWire(39,(S["7G"]+S["B3"]*KRU["14/1-B3"])*(1-Train.OVT.Value)*(1-Train.RPB.Value))

        S["7Gb"] = ARS.FMM1*(Train.PB.Value+(Train.ARS.Value+T[91]+(T[87]+S["B3"]*Train.ARSR.Value)*(1-RC1))*(1-Train.UOS.Value))
        Train.RPB:TriggerInput("Set",S["7Gb"])
        S["33Yu"] = S["7G"]*(Train.SOT.Value+Train.UOS.Value)*Train.ROT1.Value*KV["7G-33Yu"] --7G-SOT/UOS-KV
        S["33Yu0"] = (Train.RPB.Value+Train.VAH.Value)*(Train.KD.Value+Train.VAD.Value) --RVT-RPB/VAH-KD/VAD-0
        Train.RV2:TriggerInput("Set",S["33Yu"]*S["33Yu0"])
        Train:WriteTrainWire(1,S["10AK"]*Train.R1_5.Value + KRU["1/3-ZM31"]*-10)
        Train:WriteTrainWire(2,S["U2"]*KV["U2-2"]+ARS["2"]*RC1 + KRU["2/3-ZM31"]*-10) --U2-KV-2 FIXME ARS?
        Train:WriteTrainWire(3,S["U2"]*KV["U2-3"])
        Train:WriteTrainWire(6,S["10AK"]*Train.K6.Value)
        Train:WriteTrainWire(8,BO*(KV["10-8"]+ARS["8"]*RC1)*Train.A41.Value)--10-KV-8 FIXME ARS
        Train:WriteTrainWire(20,S["U2"]*KV["U2-20a"]*Train.ROT1.Value+(ARS["33G"]*RC1+S["U2"]*KV["U2-20b"])+KRU["20/3-ZM31"]*-10)
        Train:WriteTrainWire(25,S["U2"]*KV["U2-25"]*Train.A55.Value*Train.K25.Value)

        S["U2a"] = ARS["33G"]*RC1+S["U2"]*KV["U2-U2a"] --U2-KV-U2a
        S["19B"] = S["10AK"]*KV["10AK-DA"]*Train.ROT1.Value --DA-19B
        if self.HaveRO then
            Train:WriteTrainWire(19,S["19B"]*(KV["19B-19"]+Train.RO.Value)*Train.A71.Value) --19B-KV/RO-A71-19
        else
            Train:WriteTrainWire(19,S["19B"]*KV["19B-19"]*Train.A71.Value) --19B-KV/RO-A71-19
        end
        Train.R1_5:TriggerInput("Set",S["19B"]*Train.RV2.Value*Train.UAVAC.Value*(Train.AVU.Value+Train.OtklAVU.Value))
        Train.RVT:TriggerInput("Set",S["U2a"])
        Train.K25:TriggerInput("Set",S["U2a"]*(Train.ROT1.Value+(1-RC1)))
        Train.K6:TriggerInput("Set",S["10AK"]*Train.RVT.Value) --10AK-K6
        --Train.Rp8:TriggerInput("Set",T[8])


        S["U4"] = S["10AK"]*KV["10AK-U4"]*Train.A74.Value--10AK-KV-U4
        Train:WriteTrainWire(17,S["U4"]*Train.VozvratRP.Value)
        Train:WriteTrainWire(71,S["U4"]*Train.OtklBV.Value)
        Train:WriteTrainWire(24,S["U2"]*Train.A73.Value*Train.KSN.Value)
        S["V2"] = T[10]*Train.AV1.Value
        if self.Vent then
            Train:WriteTrainWire(59,S["V2"]*Train.V11.Value)
            Train:WriteTrainWire(60,S["V2"]*Train.V12.Value)
            Train:WriteTrainWire(58,BO*Train.A49.Value*(1-Train.V11.Value)*(1-Train.V12.Value)*Train.V13.Value)
            Panel.L1 = T[57]
        end
        Panel.M8 = S["V2"]*Train.PVK.Value

        local ASNP_VV = Train.ASNP_VV
        ASNP_VV.Power = BO*Train.AS1.Value*Train.R_ASNPOn.Value
        ASNP_VV.AmplifierPower = ASNP_VV.Power*Train.ASNP.LineOut*Train.R_UNch.Value*Train.A26.Value
        Train:WriteTrainWire(13,ASNP_VV.AmplifierPower)
        Train:WriteTrainWire(-13,ASNP_VV.AmplifierPower*Train.PowerSupply.X2_2)
        ASNP_VV.CabinSpeakerPower = ASNP_VV.Power*Train.ASNP.LineOut*Train.R_G.Value

        Panel.AnnouncerPlaying = T[13]
        Panel.AnnouncerBuzz = T[-13]+ASNP_VV.CabinSpeakerPower*Train.PowerSupply.X2_2
        Train:WriteTrainWire(14,S["14a"]*(Train.SOT.Value+Train.UOS.Value)*Train.KRP.Value*Train.ROT2.Value)

        Panel.CBKIPower = BO*Train.A76.Value
    end

    --Вагонная часть
    S["10A"] = BO*Train.A30.Value
    S["ZR"] = (1-Train.RRP.Value)+(B*Train.A39.Value*(1-Train.RPvozvrat.Value)*Train.RRP.Value)*-1

    if isMVM then
        S["1A"] = T[1]*Train.A1.Value*Train.IGLA_PCBK.KVC
    else
        S["1A"] = T[1]*Train.A1.Value
    end
    S["6A"] = T[6]*Train.A6.Value
    Train.TR1:TriggerInput("Set",S["6A"])
    --1A-PMU-1T-NR/RPU-1P(6^)

    S["1P"] = S["1A"]*P.PM*(Train.NR.Value+Train.RPU.Value)+S["6A"]*P.PT

    --1P-RK1-18-AVT-!RP-RKR-DR1-DR2-1G
    S["1G"] = S["1P"]*C(1 <= RK and RK <= 18)*Train.AVT.Value*(1-Train.RPvozvrat.Value)*Train.RKR.Value--FIXME
    S["1L"] = S["1G"]*C(RK==1)*(Train.KSB1.Value+Train.KSH1.Value)*Train.LK2.Value
    S["1Zh"] = (S["1L"]+S["1G"]*Train.LK3.Value)*S["ZR"]
    Train.LK1:TriggerInput("Set",S["1Zh"]*P.PM)
    Train.LK3:TriggerInput("Set",S["1Zh"])
    Train.LK4:TriggerInput("Set",S["1Zh"]*Train.LK3.Value)
    S["3A"] = T[3]*Train.A3.Value
    S["6G1"] = S["6A"]*P.PT*C(RK==1)
    self.ThyristorControllerWork = S["6G1"]*(Train.KSB1.Value+Train.KSB2.Value)*Train.LK2.Value
    S["6G2"] = S["6G1"]*(1-Train.RSU.Value)
    Train.KSB1:TriggerInput("Set",S["6G2"])
    Train.KSB2:TriggerInput("Set",S["6G2"])
    --20-A20-20A-Rp-20B
    if isMVM then
        S["20A"] = T[20]*Train.A20.Value*Train.IGLA_PCBK.KVC
    else
        S["20A"] = T[20]*Train.A20.Value
    end
    Train.RPL:TriggerInput("Set",--[[ S["20A"]--]] BO*(1-Train.RPvozvrat.Value)*(Train.DR1.Value+Train.DR2.Value+(1-Train.BV.State)))
    S["20B"] = S["20A"]*(1-Train.RPvozvrat.Value)
    S["20K"] = S["20B"]*P.PS
    Train.LK2:TriggerInput("Set",S["20K"]*S["ZR"])
    Train.LK5:TriggerInput("Set",S["20B"]*Train.LK1.Value*S["ZR"])

    if self.X2PS then
        S["1M"] = C(1<=RK and RK<=5)*S["3A"]+S["20A"]*Train.KSH2.Value
        S["1R"] = (S["1A"]*C(RK==1)+S["1M"]*P.PP)*S["ZR"]
        Train.KSH1:TriggerInput("Set",S["1R"])
        Train.KSH2:TriggerInput("Set",S["1R"])
        P:TriggerInput("PP",S["3A"]*Train.LK5.Value*C(RK==18)*S["ZR"])--1A-1D
    else
        S["1M"] = C(1<=RK and RK<=5)*S["3A"]+T[10]*Train.KSH2.Value
        S["1R"] = (S["1A"]*C(RK==1)*P.PS + S["1M"]*P.PP)*S["ZR"]
        Train.KSH1:TriggerInput("Set",S["1R"])
        Train.KSH2:TriggerInput("Set",S["1R"])
        P:TriggerInput("PP",S["1A"]*C(RK==18)*S["ZR"])--1A-1D
    end


    local Reverser = Train.Reverser
    S["4A"] = T[4]*Train.A4.Value
    Reverser:TriggerInput("NZ",S["4A"]*Reverser.VP*(1-Train.LK1.Value)*S["ZR"])
    S["5A"] = T[5]*Train.A5.Value
    Reverser:TriggerInput("VP",S["5A"]*Reverser.NZ*(1-Train.LK1.Value)*S["ZR"])
    --Train.RKR:TriggerInput("Set",(S["4A"]*Reverser.NZ+S["5A"]*Reverser.VP)) --81-717.5(м) МСК
    Train.RKR:TriggerInput("Set",(S["4A"]*Reverser.NZ+S["5A"]*Reverser.VP)*Train.BV.State*S["ZR"]) --81-717.5 Харько*S["ZR"]в
    --+B
    S["1N"] = C(11<=RK and RK<=18)*(1-Train.LK4.Value)
    Train.RR:TriggerInput("Set",S["10A"]*S["1N"] + P.PS*Train.LK4.Value)

    S["5Zh"] = S["10A"]*(1-Train.LK3.Value)
    P:TriggerInput("PS",S["5Zh"]*(P.PP))
    P:TriggerInput("PM",S["5Zh"]*(1-Train.TR1.Value)*Train.KSH2.Value)
    P:TriggerInput("PT",S["5Zh"]*(P.PM)*(1-Train.KSH2.Value))
    --P:TriggerInput("PP",S["5Zh"]*(P.PM))
    S["2A"] = T[2]*Train.A2.Value
    S["2T"] = S["2A"]*Train.TR1.Value
    Train.RSU:TriggerInput("Set",S["2T"]*Train.ThyristorBU5_6.Value)
    Train.RU:TriggerInput("Set",S["2T"])
    S["2B"] = S["2A"]*((1-Train.KSB1.Value)*(1-Train.KSB2.Value)+(1-Train.TR1.Value))

    S["2Ca"] = P.PS*C(1<=RK and RK<=17)*Train.RR.Value --CHECK
    S["2Cb"] = P.PP*(C(6<=RK and RK<=18)+C(2<=RK and RK<=5)*Train.KSH1.Value)*(1-Train.RR.Value) --CHECK
    S["2C"] = S["2B"]*(S["2Ca"]+S["2Cb"])*Train.LK4.Value
    S["10R"] = S["10A"]*(1-Train.LK3.Value)*C(2<=RK and RK<=18)*(1-Train.LK4.Value)
    S["2U"] = S["10R"]+S["2C"]*S["ZR"]
    Train.SR1:TriggerInput("Set",S["2U"])
    Train.RV1:TriggerInput("Set",S["2U"])
    S["2Zh"] = S["2A"]*Train.TR1.Value*C(17<=RK and RK<=18)
    if self.NoRT2 then
        Train.PneumaticNo1:TriggerInput("Set",S["2Zh"]+T[48]*Train.A72.Value)
    else
        Train.PneumaticNo1:TriggerInput("Set",S["2Zh"]+T[48]*Train.A72.Value*(1-Train.RT2.Value))
    end
    S["8A"] = T[8]*Train.A8.Value*(1-Train.RV1.Value)*(1-Train.RT2.Value)*(1-Train.RV3.Value)
    Train.PneumaticNo2:TriggerInput("Set",S["8A"]+T[39]*Train.A52.Value)
    Train.RV3:TriggerInput("Set",T[19]*Train.A19.Value)
    S["25A"] = T[25]*Train.A25.Value
    S["10X"] = (--[[ S["1N"]*P.PS+--]] Train.LK4.Value+C(RK==1)*Train.LK2.Value)
    Train["RRTpod"] = S["10A"]*RheostatController.RKM2*S["10X"]
    Train["RRTuderzh"] = S["25A"]
    Train["RUTpod"] = S["10A"]*RheostatController.RKM1*S["10X"]
    Train["RUTavt"] = Train.A70.Value*B
    Train.RRT:TriggerInput("Close",Train.RRTuderzh*Train.RRTpod)
    Train.RRT:TriggerInput("Open",(1-Train.RRTuderzh))

    Train.RRP:TriggerInput("Set",T[14]*Train.A14.Value)--14A
    --СДРК Б+ провод
    S["10A3"] = BO*Train.A28.Value
    S["10BG"] = S["10A3"]*(Train.TR1.Value + Train.RV1.Value)
    RheostatController:TriggerInput("MotorCoilState",min(1,S["10A"]*(S["10BG"]*Train.RR.Value - S["10BG"]*(1-Train.RR.Value))))
    Train.RVO:TriggerInput("Set",S["10A3"]*Train.NR.Value)
    self.ThyristorControllerPower = S["10A3"]
    --[[ S["10Ra"] = T[10]*RheostatController.RKM1
    S["10Rb"] = T[10]*Train.SR1.Value
    S["10RbA"] = S["10Rb"]*(1-Train.RRT.Value)*(1-Train.RUT.Value)+S["10Ra"]
    S["10RbB"] = S["10Rb"]*Train.RUT.Value
    S["10RB"] = S["10RbA"]+S["10RbB"]*Train.RRT.Value+S["10RbB"]*(1-Train.SR1.Value)

    S["10Rc"] = T[10]*Train.LK3.Value*C(RK>=18 or RK<=1)
    S["10RS"] = S["10Ra"]+S["10RB"]*(1-RheostatController.RKP)*S["10Rc"]--]]
    S["10Yu"] = S["10A"]*Train.SR1.Value
    S["10M"] = S["10Yu"]*(1-Train.RRT.Value)*(1-Train.RUT.Value)
    S["10N"] = S["10A"]*RheostatController.RKM1+S["10M"]
    S["10T"] = (Train.RUT.Value+Train.RRT.Value+(1-Train.SR1.Value))*(RheostatController.RKP)+S["10A"]*Train.LK3.Value*C(RK>=18 and RK<=1)
    RheostatController:TriggerInput("MotorState",S["10N"]+S["10T"]*(-10))

    Train.RZ_2:TriggerInput("Set",T[24]*(1-Train.LK4.Value))
    S["17A"] = T[17]*Train.A18.Value
    Train.BV:TriggerInput("Power",B*Train.A80.Value)
    Train.BV:TriggerInput("Enable",S["17A"]*Train.A81.Value)
    if isMVM then
        Train.BV:TriggerInput("Disable",T[71]*Train.A66.Value)
        Panel.PCBKPower = T[10]
    end
    Train.RPvozvrat:TriggerInput("Open",S["17A"]) --FIXME Mayve more right RP code
    --
    --Вспом цепи
    Train:WriteTrainWire(10,BO*Train.A56.Value)
    --B->A44->KMMK->23
    Train:WriteTrainWire(23,S["B3"]*Train.RezMK.Value)
    S["10AT"] = T[10]*(1-Train.AVU.Value)
    Panel.AVU = S["10AT"]

    if isKSD then
        S["48A"] = S["10AT"]*(1-Train.OtklAVU.Value)+BO*Train.A49.Value*Train.VZ1.Value+AVO["48"]*RC2
    elseif isLVZ then
        S["48A"] = S["10AT"]*(1-Train.OtklAVU.Value)+BO*Train.A49.Value*Train.VZ1.Value+ARS["48"]*RC1+AVO["48"]*RC2
    else
        S["48A"] = S["10AT"]*(1-Train.OtklAVU.Value)+T[10]*Train.AV1.Value*Train.VZ1.Value+ARS["48"]*RC1
    end
    if self.NoRT2 then
        Train:WriteTrainWire(48,S["48A"]+Train.A72.Value*S["2Zh"]) --FIXME ARS
    else
        Train:WriteTrainWire(48,S["48A"]+Train.A72.Value*S["2Zh"]*(1-Train.RT2.Value)) --FIXME ARS
    end
    if self.HaveRO then
        if isKSD then
            Train.RO:TriggerInput("Set",(T[48]+AVO["48"])*RC1)
        elseif isMVM then
            Train.RO:TriggerInput("Set",(T[48]+ARS["48"])*RC1)
        else
            Train.RO:TriggerInput("Set",(T[48]+ARS["48"])*(RC1+RC2))
        end
    end

    S["B9"] = B*Train.A53.Value
    S["22B"] = T[10]*Train.A10.Value*Train.VMK.Value
    Train:WriteTrainWire(22,(S["22B"]+T[44])*Train.AK.Value)
    Train:WriteTrainWire(44,(S["22B"])*Train.AK.Value)
    S["UO"] = T[10]*Train.A27.Value
    Train:WriteTrainWire(27,S["UO"]*Train.L_1.Value)
    S["F1"] = S["B9"]*KV["B9-F1"]
    if isLVZ then
        if isKSD then
            S["TU"] = S["F1"]*Train.Ring.Value
            Train:WriteTrainWire(7,S["TU"]+T[71]*Train.OhrSig.Value)
        else
            S["TU"] = S["F1"]*Train.A7.Value*Train.Ring.Value
            Train:WriteTrainWire(7,S["TU"]+T[71]*Train.OhrSig.Value+ARS.Ring)
        end
        Panel.OhrSig = T[71]
        Train:WriteTrainWire(71,S["UO"]*(1-Train.SQ3.Value)+S["TU"]*Train.OhrSig.Value)
    else
        Train:WriteTrainWire(7,S["UO"]*Train.Ring.Value+ARS.Ring+Train.BZOS.VH2*0.4)
        Train.BZOS.Power = T[10]*Train.A27.Value
        Train.BZOS.Ring = T[7]
    end
    --[[if isPA then
        Panel.Ring = T[7]+AVO.Ring -- FIXME ARS
    else
        Panel.Ring = T[7] -- FIXME ARS
    end]]
    Panel.Ring = T[7]

    if self.GreenRPRKR then
        S["10AN"] = Train.RPvozvrat.Value+(1-Train.RKR.Value) --81-717 Харьков
    else
        S["10AN"] = Train.RPvozvrat.Value --81-717 МСК
    end
    S["18A"] = (S["10AN"]*100+(1-Train.LK4.Value))*Train.A38.Value
    Train:WriteTrainWire(18,S["18A"])
    Panel.TW18 = S["18A"]
    Panel.GreenRP = S["10AN"]*S["UO"]

    S["36N"] = BO*Train.A45.Value
    Train:WriteTrainWire(37,Train.ConverterProtection.Value)
    Train:WriteTrainWire(69,S["36N"]*Train.BPSNon.Value)
    Train:WriteTrainWire(36,T[69]*(1-Train.BPSNon.Value))
    Panel.LKVP = T[36]
    Panel.RZP = T[36]*T[61]

    S["B9a"] = S["B9"]*Train.VB.Value
    Train.KVC:TriggerInput("Set",S["B9a"])
    Train.KUP:TriggerInput("Set",S["B9a"]*Train.A75.Value)
    Panel.KUP = S["B9a"]*Train.KUP.Value

    S["D4"] = BO*Train.A13.Value
    S["D1"] = T[10]*Train.A21.Value*KV["D-D1"]+S["14b"]*KRU["11/3-D1/1"]
    if isLVZ then
        S[16] = S["D1"]*Train.VUD1.Value*Train.VUD2.Value
        Train:WriteTrainWire(16,S[16]+AVO["16"]*RC2)
        Train:WriteTrainWire(68,S["D1"]*Train.VOPD.Value)
        S[31] = S["D1"]*(1-Train.DoorSelect.Value)--*(1-Train.VUD1.Value)
        S[32] = S["D1"]*Train.DoorSelect.Value--*(1-Train.VUD1.Value)
        AVI.KDL = S[31]*(Train.KDL.Value+Train.KDLR.Value)
        AVI.KDP = S[32]*Train.KDP.Value
        S[31] = S[31]*(1-Train.VUD1.Value)
        S[32] = S[32]*(1-Train.VUD1.Value)
    else
        Train:WriteTrainWire(16,S["D1"]*(Train.VUD1.Value*Train.VUD2.Value))
        S[31] = S["D1"]*(1-Train.DoorSelect.Value)
        S[32] = S["D1"]*Train.DoorSelect.Value
    end
    Train:WriteTrainWire(12,S["D1"]*Train.KRZD.Value)
    Panel.DoorsLeft = S[31]
    Panel.DoorsRight = S[32]
    if isLVZ then
        if isPA then AVI.ZD = S[16] end
        Train:WriteTrainWire(31,S[31]*(Train.KDL.Value*(1-RC2)+Train.VDL.Value)+AVO["31"]*RC2)
        Train:WriteTrainWire(32,S[32]*(Train.KDP.Value)*(1-RC2)+AVO["32"]*RC2)
    else
        Train:WriteTrainWire(31,S[31]*(Train.KDL.Value+Train.KDLR.Value+Train.VDL.Value)*(Train.ASNP.K1+(1-Train.VBD.Value)))
        Train:WriteTrainWire(32,S[32]*Train.KDP.Value*(Train.ASNP.K2+(1-Train.VBD.Value)))
    end


    if isMVM then
        S["15B"] = T[15]*(KV["15A-15B"]+Train.KD.Value)
    else
        S["15B"] = T[15]
    end
    if isLVZ then AVI.KD = min(1,S["15B"]) end
    Train.KD:TriggerInput("Set",S["15B"])
    Panel.SD = S["15B"]
    --FIXME ARS FMM2
    --F1->F2->BPF
    S["F8"] = S["F7"]*Train.L_4.Value
    Train.Panel.Headlights1 = S["F8"]*Train.A46.Value
    Train.Panel.Headlights2 = S["F8"]*Train.VUS.Value*Train.A47.Value
    if isKSD then
        S["F1"] = min(1,S["F1"]+T[71]*Train.OhrSig.Value*Train.Ring.Value)
        Train.Panel.RedLight1 = S["F1"]*Train.A7.Value
    elseif isLVZ then
        Train.Panel.RedLight1 = (S["F1"]+T[71]*Train.OhrSig.Value*Train.Ring.Value)*Train.A7.Value
        S["F1"] = min(1,S["F1"]+Train.Panel.RedLight1*Train.A9.Value)
    else
        Train.Panel.RedLight1 = S["F1"]*Train.A7.Value
    end
    Train.Panel.RedLight2 = S["F1"]*Train.A9.Value

    if isPUAV then
        Train:WriteTrainWire(-34,S["F1"])
        Panel.KT = (S["F1"]+T[34]*T[-34])*ARS.LKT*RC1
        ARS.KT = T[34]*T[-34]
    elseif isLVZ then
        Train:WriteTrainWire(-34,S["F1"])
        Panel.KT = S["F1"]+T[34]*T[-34]
        ARS.KT = T[34]*T[-34]
    else
        --S["KT"] = ARS.FMM1*(1-Train.BSM_GE.Value)
        S["KT"] = S["7D"]*(1-Train.BSM_GE.Value)
        Train:WriteTrainWire(-34,S["KT"])
        ARS.KT = T[34]*T[-34]*Train.BSM_GE.Value
        Train.BUM_KPP:TriggerInput("Set",S["KT"]*(1-Train.BSM_GE.Value)+ARS.KT)
    end
    Train:WriteTrainWire(34,Train.RKTT.Value+Train.DKPT.Value)

    --[[ if isLVZ then
        S[-28] = S["D4"]*KV["D4-15"]+S["14b"]
    else
        S[-28] = S["D4"]*KV["D4-15"]
    end
    Train:WriteTrainWire(-28,S[-28])--]]
    Train:WriteTrainWire(-28,S["D4"]*KV["D4-15"]+S["14b"])
    Train:WriteTrainWire(28,T[-28]*Train.RD.Value)
    S[15] = T[28]*KV["D8-15A"]*KRU["15/2-D8"]
    Train:WriteTrainWire(15,S[15])

    S[64] = S["UO"]*Train.BPT.Value
    Train:WriteTrainWire(64,S[64])
    Panel.BrW = S[64]
    Panel.BrT = T[64]

    Panel.KVC = S["UO"]*(1-Train.KVC.Value)
    Panel.CabLights = S["UO"]*Train.L_2.Value
    Panel.EqLights = T[10]*Train.A11.Value
    Panel.PanelLights = T[10]*Train.L_3.Value


    --Вспом цепи приём
    Panel.EmergencyLights = BO*Train.A49.Value*Train.A15.Value
    Train.RPU:TriggerInput("Set",T[37]*Train.A37.Value)
    Train.Schemes = S

    S["D6"] = S["D4"]*Train.BD.Value
    Train.RD:TriggerInput("Set",S["D6"])
    Panel.DoorsW = S["D4"]*(1-Train.RD.Value)
    Train.VDZ:TriggerInput("Set",T[16]*Train.A16.Value*(1-Train.RD.Value))
    S["12A"] = T[12]*Train.A12.Value
    S["31A"] = T[31]*Train.A31.Value
    S["32A"] = T[32]*Train.A32.Value
    Train.VDOL:TriggerInput("Set",S["31A"]+S["12A"])
    Train.VDOP:TriggerInput("Set",S["32A"]+S["12A"]+T[68]*Train.A68.Value)

    S["36A"] = T[36]*Train.A51.Value*Train.RVO.Value--36
    Train.KVP:TriggerInput("Set",S["36A"]*Train.KPP.Value)
    Train.KPP:TriggerInput("Set",S["36A"]*(1-Train.RZP.Value)*Train.KVC.Value)
    S["27A"] = T[27]*Train.A50.Value
    Train.KO:TriggerInput("Set",S["27A"])
    --S["22A"] = (T[23]*Train.A23.Value+T[22]*Train.A22.Value) --FIXME 714
    S["22A"] = T[22]*Train.A22.Value
    Train.KK:TriggerInput("Set",S["22A"]*(1-Train.TRK.Value))

    if isLVZ then
        Panel.VPR = BO*Train.AR63.Value*Train.R_VPR.Value+B*Train.AV3.Value*Train.R_VPR.Value
    else
        Panel.VPR = BO*Train.AR63.Value*Train.R_VPR.Value
        Panel.PCBKPower = BO
    end

    --BPSN
    local BPSN = Train.PowerSupply
    Train.Battery:TriggerInput("Charge",BPSN.X2_2*Train.A24.Value*BO)
    BPSN:TriggerInput("5x2",BO*Train.A65.Value*Train.KVP.Value)
    Panel.MainLights = BPSN.X6_2*Train.KO.Value
    Train.RPU:TriggerInput("Set",T[37]*Train.A37.Value)
    Train.RZP:TriggerInput("Open",T[37]*Train.A37.Value*Train.RPU.Value)
    Train:WriteTrainWire(61,Train.RZP.Value)

    if self.Vent then
        Train.KV1:TriggerInput("Set",T[59]*Train.AV4.Value*Train.RVO.Value)
        Train.KV2:TriggerInput("Set",T[60]*Train.AV5.Value)
        Train.KV3:TriggerInput("Set",T[58]*Train.AV6.Value)
        S["AV2"] = T[10]*Train.AV2.Value
        Panel.M1_3 = S["AV2"]*Train.KV1.Value
        Panel.M4_7 = S["AV2"]*Train.KV2.Value+B*Train.AV3.Value*Train.KV3.Value
        Train.R1:TriggerInput("Set",S["AV2"]*C(Panel.M1_3 > 0.5 and Panel.M4_7 > 0.5))
        Train:WriteTrainWire(57,T[59]*(1-Train.R1.Value))
    end
    return S
end
function TRAIN_SYSTEM:SolveRKInternalCircuits(Train,dT,firstIter)
    local P     = Train.PositionSwitch
    local RheostatController = Train.RheostatController
    local RK    = RheostatController.SelectedPosition
    local B     = (Train.Battery.Voltage > 55) and 1 or 0
    local BO    = B*Train.VB.Value
    local T     = Train.SolverTemporaryVariables

    --Вагонная часть
    S["10A"] = BO*Train.A30.Value
    S["ZR"] = (1-Train.RRP.Value)+(B*Train.A39.Value*(1-Train.RPvozvrat.Value)*Train.RRP.Value)*-1


    S["1N"] = C(11<=RK and RK<=18)*(1-Train.LK4.Value)
    Train.RR:TriggerInput("Set",S["10A"]*S["1N"] + P.PS*Train.LK4.Value)

    S["2A"] = T[2]*Train.A2.Value
    S["2B"] = S["2A"]*((1-Train.KSB1.Value)*(1-Train.KSB2.Value)+(1-Train.TR1.Value))

    S["2Ca"] = P.PS*C(1<=RK and RK<=17)*Train.RR.Value --CHECK
    S["2Cb"] = P.PP*(C(6<=RK and RK<=18)+C(2<=RK and RK<=5)*Train.KSH1.Value)*(1-Train.RR.Value) --CHECK
    S["2C"] = S["2B"]*(S["2Ca"]+S["2Cb"])*Train.LK4.Value
    S["10R"] = S["10A"]*(1-Train.LK3.Value)*C(2<=RK and RK<=18)*(1-Train.LK4.Value)
    S["2U"] = S["10R"]+S["2C"]*S["ZR"]
    Train.SR1:TriggerInput("Set",S["2U"])
    Train.RV1:TriggerInput("Set",S["2U"])


    S["25A"] = T[25]*Train.A25.Value
    S["10X"] = (Train.LK4.Value+C(RK==1)*Train.LK2.Value)
    Train["RRTpod"] = S["10A"]*RheostatController.RKM2*S["10X"]
    Train["RRTuderzh"] = S["25A"]
    Train["RUTpod"] = S["10A"]*RheostatController.RKM1*S["10X"]
    Train.RRT:TriggerInput("Close",Train.RRTuderzh*Train.RRTpod)
    Train.RRT:TriggerInput("Open",(1-Train.RRTuderzh))

    --СДРК Б+ провод
    S["10A3"] = BO*Train.A28.Value
    S["10BG"] = S["10A3"]*(Train.TR1.Value + Train.RV1.Value)
    RheostatController:TriggerInput("MotorCoilState",min(1,S["10A"]*(S["10BG"]*Train.RR.Value - S["10BG"]*(1-Train.RR.Value))))

    S["10Yu"] = S["10A"]*Train.SR1.Value
    S["10M"] = S["10Yu"]*(1-Train.RRT.Value)*(1-Train.RUT.Value)
    S["10N"] = S["10A"]*RheostatController.RKM1+S["10M"]
    S["10T"] = (Train.RUT.Value+Train.RRT.Value+(1-Train.SR1.Value))*(RheostatController.RKP)+S["10A"]*Train.LK3.Value*C(RK>=18 and RK<=1)
    RheostatController:TriggerInput("MotorState",S["10N"]+S["10T"]*(-10))

    return S
end

local wires = {1,2,3,4,5,6,7,8,10,12,14,15,16,17,18,19,20,22,23,24,27,-28,28,25,13,-13,31,32,36,37,39,44,48,53,54,57,59,60,58,57,64,34,36,-34,61,64,66,67,68,69,71,87,88,91,92,93,98,99}
function TRAIN_SYSTEM:SolveInternalCircuits(Train,dT,firstIter)
    local T     = Train.SolverTemporaryVariables
    if not T then
        T = {}
        for i,v in ipairs(wires) do T[v] = 0 end
        Train.SolverTemporaryVariables = T
    end
    if firstIter then
        for i,v in ipairs(wires) do T[v] = min(Train:ReadTrainWire(v),1) end
        self:SolveAllInternalCircuits(Train,dT)
    else
        self:SolveRKInternalCircuits(Train,dT)
    end
end



--------------------------------------------------------------------------------
function TRAIN_SYSTEM:SolvePowerCircuits(Train,dT)
    self.ExtraResistanceLK5 = 0--Train.KF_47A["L2-L4"  ]*(1-Train.LK5.Value)
    self.ExtraResistanceLK2 = Train.KF_47A["L12-L13"]*(1-Train.LK2.Value)
    if Train.PositionSwitch.PT > 0 then -- PT
        self.R1 = Train.ResistorBlocks.R1C1(Train)
        self.R2 = Train.ResistorBlocks.R2C1(Train)
        self.R3 = 0
    elseif Train.PositionSwitch.PS > 0 then -- PS
        self.R1 = Train.ResistorBlocks.R1C1(Train)
        self.R2 = Train.ResistorBlocks.R2C1(Train)
        self.R3 = 0.0
    elseif Train.PositionSwitch.PP > 0 then --PP
        self.R1 = Train.ResistorBlocks.R1C2(Train)
        self.R2 = Train.ResistorBlocks.R2C2(Train)
        self.R3 = 0.0
    else
        self.R1 = 1e9
        self.R2 = 1e9
        self.R3 = 1e9
    end
    -- Apply LK3, LK4 contactors
    self.R1 = self.R1 + 1e9*(1 - Train.LK3.Value)
    self.R2 = self.R2 + 1e9*(1 - Train.LK4.Value)

    -- Shunt resistance
    self.Rs1 = Train.ResistorBlocks.S1(Train) + 1e9*(1 - Train.KSH1.Value)
    self.Rs2 = Train.ResistorBlocks.S2(Train) + 1e9*(1 - Train.KSH2.Value)

    -- Thyristor contrller
    if self.ThyristorController then
        self.Rs1 = ((self.ThyristorResistance^(-1)) + (self.Rs1^(-1)))^(-1)
        self.Rs2 = ((self.ThyristorResistance^(-1)) + (self.Rs2^(-1)))^(-1)
    end

    -- Calculate total resistance of engines winding
    local RwAnchor = Train.Engines.Rwa*2 -- Double because each set includes two engines
    local RwStator = Train.Engines.Rws*2
    -- Total resistance of the stator + shunt
    self.Rstator13  = (RwStator^(-1) + self.Rs1^(-1))^(-1)
    self.Rstator24  = (RwStator^(-1) + self.Rs2^(-1))^(-1)
    -- Total resistance of entire motor
    self.Ranchor13  = RwAnchor
    self.Ranchor24  = RwAnchor

    if Train.PositionSwitch.PT> 0 then -- PS
        self:SolvePT(Train)
    elseif Train.PositionSwitch.PS > 0 then -- PS
        self:SolvePS(Train)
    elseif Train.PositionSwitch.PP > 0 then
        self:SolvePP(Train,Train.RheostatController.SelectedPosition >= 17)
    else
        self:SolvePT(Train)
    end

    -- Calculate current through rheostats 1, 2
    self.IR1 = self.I13
    self.IR2 = self.I24

    -- Calculate induction properties of the motor
    self.I13SH = self.I13SH or self.I13
    self.I24SH = self.I24SH or self.I24

    -- Time constant
    --local T13const1 = math.max(16.00,math.min(28.0,(self.R13^2) * 2.0)) -- R * L
    --local T24const1 = math.max(16.00,math.min(28.0,(self.R24^2) * 2.0)) -- R * L
    local T13const1 = math.max(16.00,math.min(36.0,(self.R13^2) * 2.0)) -- R * L
    local T24const1 = math.max(16.00,math.min(36.0,(self.R24^2) * 2.0)) -- R * L

    -- Total change
    local dI13dT = T13const1 * (self.I13 - self.I13SH) * dT
    local dI24dT = T24const1 * (self.I24 - self.I24SH) * dT

    -- Limit change and apply it
    if dI13dT > 0 then dI13dT = math.min(self.I13 - self.I13SH,dI13dT) end
    if dI13dT < 0 then dI13dT = math.max(self.I13 - self.I13SH,dI13dT) end
    if dI24dT > 0 then dI24dT = math.min(self.I24 - self.I24SH,dI24dT) end
    if dI24dT < 0 then dI24dT = math.max(self.I24 - self.I24SH,dI24dT) end
    self.I13SH = self.I13SH + dI13dT
    self.I24SH = self.I24SH + dI24dT
    self.I13 = self.I13SH
    self.I24 = self.I24SH

    -- Re-calculate total current and simulate infinite resistance in circuit
    if Train.PositionSwitch.PT > 0 then
        self.I13 = self.I13*Train.LK3.Value*Train.LK4.Value
        self.I24 = self.I24*Train.LK4.Value*Train.LK3.Value

        self.Itotal = self.I13 + self.I24
    elseif Train.PositionSwitch.PS > 0 then -- PS
        self.I13 = self.I13 * (Train.LK3.Value * Train.LK4.Value * Train.LK1.Value)
        self.I24 = self.I24 * (Train.LK3.Value * Train.LK4.Value * Train.LK1.Value)

        self.I24 = (self.I24 + self.I13)*0.5
        self.I13 = self.I24
        self.Itotal = self.I24
    elseif Train.PositionSwitch.PP > 0 then -- PP
        self.I13 = self.I13 * Train.LK3.Value * Train.LK1.Value
        self.I24 = self.I24 * Train.LK4.Value * Train.LK1.Value

        self.Itotal = self.I13 + self.I24
    end

    -- Calculate extra information
    self.Uanchor13 = self.I13 * self.Ranchor13
    self.Uanchor24 = self.I24 * self.Ranchor24
    self.Ianchor13 = self.I13
    self.Ianchor24 = self.I24



    ----------------------------------------------------------------------------
    -- Calculate current through stator and shunt
    self.Ustator13 = self.I13 * self.Rstator13
    self.Ustator24 = self.I24 * self.Rstator24

    self.Ishunt13  = self.Ustator13 / self.Rs1
    self.Istator13 = self.Ustator13 / RwStator
    self.Ishunt24  = self.Ustator24 / self.Rs2
    self.Istator24 = self.Ustator24 / RwStator

    if Train.PositionSwitch.PT > 0 then
        local I1,I2 = self.Ishunt13,self.Ishunt24
        self.Ishunt13 = -I2
        self.Ishunt24 = -I1

        I1,I2 = self.Istator13,self.Istator24
        self.Istator13 = -I2
        self.Istator24 = -I1
    end

    -- Calculate current through RT2 relay
    self.IRT2 = math.abs(self.Itotal * Train.PositionSwitch.PT)

    -- Sane checks
    if self.R1 > 1e5 then self.IR1 = 0 end
    if self.R2 > 1e5 then self.IR2 = 0 end

    -- Calculate power and heating
    local K = 12.0*1e-5
    local H = (10.00+(15.00*Train.Engines.Speed/80.0))*1e-3
    self.P1 = (self.IR1^2)*self.R1
    self.P2 = (self.IR2^2)*self.R2
    self.T1 = (self.T1 + self.P1*K*dT - (self.T1-25)*H*dT)
    self.T2 = (self.T2 + self.P2*K*dT - (self.T2-25)*H*dT)
    self.Overheat1 = math.min(1-1e-12,
        self.Overheat1 + math.max(0,(math.max(0,self.T1-750.0)/400.0)^2)*dT )
    self.Overheat2 = math.min(1-1e-12,
        self.Overheat2 + math.max(0,(math.max(0,self.T2-750.0)/400.0)^2)*dT )

    -- Energy consumption
    self.ElectricEnergyUsed = self.ElectricEnergyUsed + math.max(0,self.EnergyChange)*dT
    self.ElectricEnergyDissipated = self.ElectricEnergyDissipated + math.max(0,-self.EnergyChange)*dT
end
function TRAIN_SYSTEM:SolveThyristorController(Train, dT)
    -- General state
    local Active = self.ThyristorControllerPower > 0 and self.ThyristorControllerWork > 0 and Train.KSB1.Value>0
    local I = (math.abs(self.I13) + math.abs(self.I24)) / 2
    --local I = math.abs(Train.Electric.I13 + Train.Electric.I24)/2
    --print(Train.RSU.Value,Active,Train.TR1.Value)
    -- Controllers resistance
    local Resistance = 0.036
    -- Update RV controller signal
    -- Update thyristor controller signal
    local done = true
    if not Active then
        self.ThyristorTimeout = CurTime()
        self.PrepareElectric = CurTime()
        self.ThyristorState = 0.00
    --[[elseif not Active then
        if Train.LK2.Value == 0.0 then
            self.ThyristorTimeout = CurTime()
            self.PrepareElectric = CurTime()
            self.ThyristorState = 0.00
        end--]]
    else
        local T = 180.0 + (100.0 * Train.Pneumatic.WeightLoadRatio + 80.0) * Train.RU.Value
        -- Generate control signal
        local rnd = T / 20 --+math.random()*(10)
        local dC = math.min(math.max((T - I), -20), 20)

        if self.PrepareElectric then
            self.ThyristorState = 0.92
            if I > 162 then--I > T * 0.9 then
                self.PrepareElectric = false
                self.ThyristorState = (1 - math.max(0, math.min(1, ((Train.Engines.Speed - 50) / 32)) ^ 0.5)) * 0.9
            end
        else
            self.ThyristorState = math.max(0, math.min(1, self.ThyristorState + dC / rnd * dT))
        end
        --print(self.ThyristorState)

        --print(self.ThyristorState)
        -- Generate resistance
        local keypoints = {0.10, 0.008, 0.20, 0.018, 0.30, 0.030, 0.40, 0.047, 0.50, 0.070, 0.60, 0.105, 0.70, 0.165, 0.80, 0.280, 0.90, 0.650, 1.00, 15.00}
        local TargetField = 0.48 + 0.52 * self.ThyristorState
        local Found = false

        for i = 1, #keypoints / 2 do
            local X1, Y1 = keypoints[(i - 1) * 2 + 1], keypoints[(i - 1) * 2 + 2]
            local X2, Y2 = keypoints[(i) * 2 + 1], keypoints[(i) * 2 + 2]

            if (not Found) and (not X2) then
                Resistance = Y1
                Found = true
            elseif (TargetField >= X1) and (TargetField < X2) then
                local T = (TargetField - X1) / (X2 - X1)
                Resistance = Y1 + (Y2 - Y1) * T
                Found = true
            end
        end

        done = self.PrepareElectric and (CurTime() - self.PrepareElectric) > 0.8 or not self.PrepareElectric and self.ThyristorState > 0.92
    end

    -- Allow or deny using manual brakes
    --Train.ThyristorBU5_6:TriggerInput("Set",not self.PrepareElectric and self.ThyristorState > 0.90)
    Train.ThyristorBU5_6:TriggerInput("Set", Active and done)
    -- Set resistance
    self.ThyristorResistance = Resistance + 1e9 * (Active and 0 or 1)
end

function TRAIN_SYSTEM:Think(...)
    if not self.ResistorBlocksInit then
        self.ResistorBlocksInit  = true
        if false and self.Type ~= 1 then
            self.Train:LoadSystem("ResistorBlocks","Gen_Res_717_SPB")
        else
            self.Train:LoadSystem("ResistorBlocks","Gen_Res_717")
        end
        self.Train.ResistorBlocks.InitializeResistances_81_717(self.Train)
    end
    return Metrostroi.BaseSystems["Electric"].Think(self,...)
end
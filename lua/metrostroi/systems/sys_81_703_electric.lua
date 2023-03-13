----------------------------------------------------------------------------
-- 81-703, 81-707 electric schemes
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_703_Electric")
TRAIN_SYSTEM.E = 1
TRAIN_SYSTEM.Ezh = 2
TRAIN_SYSTEM.Em = 3
function TRAIN_SYSTEM:Initialize(typ1,typ2)
    self.RRI = 0
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
    return { "Type", "RRI" }
end
function TRAIN_SYSTEM:Outputs(...)
    return Metrostroi.BaseSystems["Electric"].Outputs(self,...)
end
function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "Type" then
        self.Type = value
    end
    if name == "RRI" then self.RRI = value end
end

-- Node values
local S = {}
-- Converts boolean expression to a number
local function C(x) return x and 1 or 0 end
local min = math.min
local max = math.max

function TRAIN_SYSTEM:SolveAllInternalCircuits(Train)
    ---[[
    local RheostatController = Train.RheostatController
    local P = Train.PositionSwitch.SelectedPosition
    local RK = RheostatController.SelectedPosition
    local B = (Train.Battery.Voltage > 55) and 1 or 0
    local T = Train.SolverTemporaryVariables

    local elType = self.Type

    local isE = elType == 1
    local isEzh = elType == 2
    local isEm = elType == 3

    local BO = min(1,B * Train.VB.Value+T[10])--B * Train.VB.Value
    local KV = Train.KV
    local KRU = Train.KRU
    local Panel = Train.Panel
    local ARS = Train.ALS_ARS
    local RC
    if isEzh then RC = Train.RC1.Value end

    Panel.V1 = BO

    Train:WriteTrainWire(10,B*Train.VB.Value)
    Panel.GRP = BO*Train.RPvozvrat.Value
    S["10AK"] = BO*Train.VU.Value

    if isE then
        S["U2"] = S["10AK"]*(KV["U2-10AK"]+Train.R1_5.Value)
    else
        S["U2"] = S["10AK"]*KV["U2-10AK"]
    end

    if isEzh then
        Train:WriteTrainWire(14,(BO*KRU["14/1-B3"]+T[5]*Train.KRR.Value)*(Train.ROT2.Value+Train.KAH.Value)*(Train.UOS.Value+Train.SOT.Value)*Train.KU14.Value)
    elseif isEm then
        Train:WriteTrainWire(14,(BO*KRU["14/1-B3"]+T[5]*Train.KRR.Value)*Train.KU14.Value)
    end
    Panel.RRP = S["U2"]*T[18]
    if isEzh then
        Train:WriteTrainWire(4,S["10AK"]*KV["U2-4"])
        Train:WriteTrainWire(5,S["10AK"]*KV["U2-5"]+KRU["5/3-ZM31"]*-10*(1-Train.KRR.Value)+BO*KRU["14/1-B3"]*Train.KRR.Value)
        Panel.Sequence = T[2]
        if self.RRI> 0 then
            local RRI_VV = Train.RRI_VV
            RRI_VV.Power = BO*Train.RRIEnable.Value
            RRI_VV.AmplifierPower = BO*Train.RRIAmplifier.Value
            Train:WriteTrainWire(13,RRI_VV.AmplifierPower*Train.RRI.LineOut)
            --RRI_VV.CabinSpeakerPower = T[13]
        else
            local ASNP_VV = Train.ASNP_VV
            ASNP_VV.Power = BO*Train.R_Radio.Value*Train.R_ASNPOn.Value
            ASNP_VV.AmplifierPower = ASNP_VV.Power*Train.ASNP.LineOut
            Train:WriteTrainWire(13,ASNP_VV.AmplifierPower)
            Panel.CBKIPower = T[10]
            --Train:WriteTrainWire(-13,ASNP_VV.AmplifierPower*Train.PowerSupply.X2_2)
            --ASNP_VV.CabinSpeakerPower = ASNP_VV.Power*Train.ASNP.LineOut*Train.R_G.Value
        end
    elseif isEm then
        Train:WriteTrainWire(4,S["10AK"]*KV["U2-4"])
        Train:WriteTrainWire(5,S["10AK"]*KV["U2-5"]+KRU["5/3-ZM31"]*-10*(1-Train.KRR.Value)+BO*KRU["14/1-B3"]*Train.KRR.Value)
        --Panel.Sequence = T[2]
        Panel.UKS = BO*Train.UKS.UKSEngaged
        Panel.UKSb = BO*Train.UKS.UKSTriggered
        if self.RRI> 0 then
            local RRI_VV = Train.RRI_VV
            RRI_VV.Power = BO*Train["50V"].Value*Train.RRIEnable.Value
            RRI_VV.AmplifierPower = BO*Train.RRIAmplifier.Value
            Train:WriteTrainWire(13,RRI_VV.AmplifierPower*Train.RRI.LineOut)
            --RRI_VV.CabinSpeakerPower = T[13]
        else
            local ASNP_VV = Train.ASNP_VV
            ASNP_VV.Power = BO*Train["50V"].Value*Train.R_ASNPOn.Value
            ASNP_VV.AmplifierPower = ASNP_VV.Power*Train.ASNP.LineOut
            Train:WriteTrainWire(13,ASNP_VV.AmplifierPower)
            Panel.CBKIPower = T[10]*Train["50V"].Value
            --Train:WriteTrainWire(-13,ASNP_VV.AmplifierPower*Train.PowerSupply.X2_2)
            --ASNP_VV.CabinSpeakerPower = ASNP_VV.Power*Train.ASNP.LineOut*Train.R_G.Value
        end
    else
        local RRI_VV = Train.RRI_VV
        RRI_VV.Power = BO*Train.RRIEnable.Value
        RRI_VV.AmplifierPower = BO*Train.RRIAmplifier.Value
        Train:WriteTrainWire(13,RRI_VV.AmplifierPower*Train.RRI.LineOut)

        Train:WriteTrainWire(4,S["U2"]*KV["U2-4"])
        Train:WriteTrainWire(5,S["U2"]*KV["U2-5ZH"]*(Train.UAVAC.Value+KV["5ZH-5"]))
    end
    Panel.AnnouncerPlaying = T[13]
    Train:WriteTrainWire(24,S["U2"]*Train.KU8.Value)
    if isE then
        Train:WriteTrainWire(14,BO*KV["10-14B"]*KV["14-14B"])
        Train:WriteTrainWire(1,S["10AK"]*Train.R1_5.Value)
        Train:WriteTrainWire(2,S["U2"]*KV["U2-2"])
        Train:WriteTrainWire(3,S["U2"]*KV["U2-3"])
        Train:WriteTrainWire(25,S["U2"]*KV["U2-25"])
        Train:WriteTrainWire(20,S["U2"]*KV["U2-20"])
        Train:WriteTrainWire(6,S["U2"]*KV["U2-6"])
        Train.RV2:TriggerInput("Set",S["10AK"]*KV["10AK-7A"])
        Train.R1_5:TriggerInput("Set",S["10AK"]*Train.RV2.Value)
        Train:WriteTrainWire(17,S["10AK"]*Train.KU9.Value)

        Train:WriteTrainWire(8,BO*KV["10-8"])
    elseif isEzh then
        S["10a"] = BO*KV["10a-8"]
        ARS.ALS  = S["10a"]*Train.ALS.Value*RC
        ARS.GE = S["10a"]*Train.ARS.Value*RC

        --Train:WriteTrainWire(-34,S["10AK"]*(1-ARS.GE))
        --Train:WriteTrainWire(34,Train.RKTT.Value+Train.DKPT.Value)

        ARS.KT = T[34]*T[-34]*ARS.GE

        ARS.KRT = max(0,T[6])*RC
        ARS.KRH = (max(0,T[1])+T[14])*RC
        ARS.KRO = S["10a"]*(1-Train.KU14.Value)*KV["U4-10AK"]*RC
        --ARS.KRO = (T[87]+S["7Ga"]*KV["7GA-RC27"]+S["14a"]*Train.A42.Value*(1-Train.KRP.Value))*(1-Train.BSM_KRH.Value)
        ARS.Freq = BO*KV["7D-7G"]*Train.ALSFreq.Value

        ARS.KB=ARS.GE*(Train.KVT.Value+Train.PB.Value)*RC

        Train:WriteTrainWire(-34,BO*(1-ARS.GE))
        Train:WriteTrainWire(34,Train.RKTT.Value+Train.DKPT.Value)
        Panel.KT = T[-34]*T[34]

        Train.ROT1:TriggerInput("Set",ARS.GE*ARS["33"]+(1-RC)*Train.KAH.Value)
        Train.ROT2:TriggerInput("Set",ARS.GE*ARS["33"]+(1-RC)*Train.KAH.Value)
        Train:WriteTrainWire(1,S["10AK"]*Train.R1_5.Value+KRU["1/3-ZM31"]*-10)
        Train:WriteTrainWire(2,S["U2"]*KV["U2-2"]+ARS["2"]*RC+KRU["2/3-ZM31"]*-10)
        Train:WriteTrainWire(3,S["U2"]*KV["U2-3"]+ARS["2"]*RC+KRU["3/3-ZM31"]*-10)
        --Train:WriteTrainWire(25,S["U2"]*KV["25-6"]*(ARS["25"]*RC+(1-RC)))
        Train:WriteTrainWire(25,S["U2"]*KV["25-6"]*(Train.ROT1.Value+(1-RC)*Train.KAH.Value))
        Train:WriteTrainWire(20,S["U2"]*KV["U2-20"]+ARS["20"]*RC+KRU["20/3-ZM31"]*-10)
        Train:WriteTrainWire(6,S["10AK"]*Train.RVT.Value)

        Train.RVT:TriggerInput("Set",S["10AK"]*KV["U2-6"]+ARS["33G"]*RC)
        Train.RV2:TriggerInput("Set",S["10AK"]*KV["33-10AK"]*Train.ROT1.Value*(Train.AVU.Value+Train.OtklAVU.Value)*(1-Train.RVT.Value)*Train.UAVAC.Value*(Train.KAH.Value+Train.RPB.Value)*(Train.UOS.Value+Train.SOT.Value))
        Train.R1_5:TriggerInput("Set",S["10AK"]*Train.RV2.Value)
        Train:WriteTrainWire(17,S["10AK"]*Train.KU9.Value*(ARS["17"]*RC+(1-RC)))
        Train.RPB:TriggerInput("Set",S["10a"]*(Train.PB.Value+Train.ARS.Value*(1-Train.UOS.Value)))
        Train:WriteTrainWire(8,BO*(KV["10-8"]+KV["10a-8"]*(1-Train.KAH.Value)*(1-Train.RPB.Value))+ARS["8"]*RC)
        Train.RO:TriggerInput("Set",ARS["48"])
        Train:WriteTrainWire(44,BO*Train.RO.Value*RC)
    else
        S["10a"] = BO*KV["10a-8"]

        Train:WriteTrainWire(1,S["10AK"]*Train.R1_5.Value+KRU["1/3-ZM31"]*-10)
        Train:WriteTrainWire(2,S["U2"]*KV["U2-2"]+KRU["2/3-ZM31"]*-10)
        Train:WriteTrainWire(3,S["U2"]*KV["U2-3"]+KRU["3/3-ZM31"]*-10)
        --Train:WriteTrainWire(25,S["U2"]*KV["25-6"]*(ARS["25"]*RC+(1-RC)))
        Train:WriteTrainWire(25,S["U2"]*KV["25-6"])
        Train:WriteTrainWire(20,S["U2"]*KV["U2-20"]+KRU["20/3-ZM31"]*-10)
        Train:WriteTrainWire(6,S["10AK"]*Train.RVT.Value)

        Train.RVT:TriggerInput("Set",S["10AK"]*KV["U2-6"])
        Train.RV2:TriggerInput("Set",S["10AK"]*KV["33-10AK"]*(Train.AVU.Value+Train.OtklAVU.Value)*Train.UAVAC.Value*(1-Train.UKS.UKSTriggered))
        Train.R1_5:TriggerInput("Set",S["10AK"]*Train.RV2.Value)
        Train:WriteTrainWire(17,S["10AK"]*Train.KU9.Value)
        Train:WriteTrainWire(8,BO*KV["10-8"])
        Train:WriteTrainWire(44,S["10AK"]*Train.UV1.Value)
    end






    local RUM = KV.RCU
    if isE then
        S["ZR"] = 1
    else
        S["ZR"] = (1-Train.RRP.Value)+(B*Train.RRP.Value)*-1
    end

    Train.RZ_2:TriggerInput("Set",T[24]*RUM*(1-Train.LK4.Value))
    S["18A"] = RUM*(Train.RPvozvrat.Value*100+(1-Train.LK4.Value))
    Train:WriteTrainWire(18,S["18A"])
    Panel.TW18 = S["18A"]

    local Reverser = Train.Reverser
    S["4A"] = T[4]*RUM
    S["5A"] = T[5]*RUM
    Reverser:TriggerInput("NZ",S["4A"]*Reverser.VP)
    Reverser:TriggerInput("VP",S["5A"]*Reverser.NZ)
    Train.LK4:TriggerInput("Set",(S["4A"]*Reverser.NZ+S["5A"]*Reverser.VP)*(1-Train.RPvozvrat.Value)*Train.LK3.Value*S["ZR"])

    if isE then
        Train.PneumaticNo1:TriggerInput("Set",T[8]*C(P == 4 and 1 <= RK and RK <= 5))
        Train.PneumaticNo2:TriggerInput("Set",T[8]*(1-Train.RV3.Value)*(1-Train.LK4.Value))
        Train.RS:TriggerInput("Set",T[12]*RUM)
        Train.RV3:TriggerInput("Set",T[14]*RUM)
        Train.Panel.PP1 = T[1]
        Train.Panel.PP6 = T[6]
    else
        if isEzh then
            Train:WriteTrainWire(48,BO*Train.RO.Value*RC+C(P == 4 and 1 <= RK and RK <= 5))
        else
            Train:WriteTrainWire(48,C(P == 4 and 1 <= RK and RK <= 5)+BO*Train.UV1.Value)
        end
        Train.PneumaticNo1:TriggerInput("Set",(T[8]+T[44])*T[48])
        Train.PneumaticNo2:TriggerInput("Set",T[8]*(1-Train.LK4.Value))
    end

    S["10A"] = BO*RUM

    --РУТ
    --СДРК
    S["10B"] = S["10A"]*(Train.RV1.Value+Train.TSH.Value)
    if isE then
        S["25B"] = (1-Train.TSH.Value)*Train.LK2.Value
        S["25A"] = (Train.KSH2.Value + Train.RS.Value)
        Train["RUTreg"] = S["10A"]*(S["25B"]-S["25A"])
        S["10I"] = S["10A"]*RheostatController.RKM2
        Train["RUTpod"] = S["10I"]*Train.LK4.Value
        Train["RRTpod"] = S["10I"]*(1-Train.LK2.Value)
    else
        S["25B"] = S["10B"]*(1-Train.TSH.Value)*Train.LK1.Value
        S["25A"] = Train.KSH2.Value
        Train["RUTreg"] = S["10A"]*(S["25B"]-S["25A"])
        S["10I"] = S["10A"]*RheostatController.RKM2
        Train["RUTpod"] = S["10I"]*Train.LK4.Value
        Train["RRTpod"] = S["10I"]*(1-Train.LK1.Value)
    end
    Train.RRT:TriggerInput("Close",Train.RRTuderzh*Train.RRTpod)
    Train.RRT:TriggerInput("Open",(1-Train.RRTuderzh))
    local SDRKr = 0
    if isE then
        SDRKr = 1-Train.LK4.Value*(0.2+0.3*C(2 <=RK and RK <= 7 and (P==1 or P==3 or P==4)))
    else
        SDRKr = 1-Train.LK2.Value*(0.2+0.3*C(2 <=RK and RK <= 7 and (P==1 or P==3 or P==4)))
    end
    RheostatController:TriggerInput("MotorCoilState",min(1,S["10A"]*(S["10B"]*Train.RR.Value - S["10B"]*(1-Train.RR.Value)))*SDRKr)

    S["10N"] = S["10A"]*(RheostatController.RKM1+Train.SR1.Value*(1-Train.RUT.Value))
    S["10T"] = --[[ S["10N"]*--]] ((1-Train.SR1.Value)+Train.RUT.Value)*(RheostatController.RKP)
    RheostatController:TriggerInput("MotorState",(S["10N"]+S["10T"]*(-10)))
    --СДПП
    S["10AV"] = S["10A"]*(1-Train.LK3.Value)*C(2<=RK and RK<=18)*(1-Train.LK4.Value)
    S["10E"] = S["10A"]*((1-Train.LK3.Value)+Train.Rper.Value+Train.PositionSwitch.PMPos)
    if isE then
        Train.SR2:TriggerInput("Set",S["10E"]*((C(P==3 or P==4)+Train.KSH2.Value))*(1-Train.LK4.Value))

        S["10AD"] = (1-Train.LK1.Value)*Train.SR2.Value
        S["10AZh"] = S["10AD"]*Train.TSH.Value*C(P==1 or P==2 or P==4)
    else
        S["10AD"] = (1-Train.LK1.Value)*(C(P==3 or P==4)+Train.LK2.Value)
        S["10AZh"] = S["10AD"]*Train.TSH.Value*Train.KSH2.Value*C(P==1 or P==2 or P==4)
    end
    S["10AR"] = S["10AD"]*(1-Train.KSH3.Value)*(1-Train.TSH.Value)*C(2<=P and P<=4)
    S["10Ya"] = Train.LK3.Value*C(RK==18 and (P==1 or P==3))
    S["10AG"] = S["10E"]*(S["10AR"]+S["10AZh"]+S["10Ya"])
    Train.PositionSwitch:TriggerInput("MotorState",-1.0 + 2.0*math.max(0,S["10AG"]))
    S["2A"] = T[2]*RUM
    S["2G"] = S["2A"]*(C(P==1 or P==3)*C(1<=RK and RK<=17)+C(P==2 or P==4)*(C(5<=RK and RK<=18)+C(2<=RK and RK<=4)*Train.KSH1.Value))
    if isE then
        S["2E"] = S["2G"]*(1-Train.SR2.Value)*Train.LK4.Value+S["10AV"]
    else
        S["2E"] = S["2G"]*Train.LK4.Value+S["10AV"]
    end
    Train.RV1:TriggerInput("Set",S["2E"]*S["ZR"])
    Train.SR1:TriggerInput("Set",S["2E"]*(1-Train.RRT.Value)*S["ZR"])

    Train.Rper:TriggerInput("Set",T[3]*RUM*C(17<=RK and RK<=18)*S["ZR"])

    S["1P"] = T[1]*RUM*C(P == 1 or P == 2)*Train.NR.Value
    S["6A"] = T[6]*RUM
    Train.TSH:TriggerInput("Set",S["6A"])
    S["1G"] = (S["1P"]+S["6A"]*C(P==3 or P==4))*Train.AVT.Value*(1-Train.RPvozvrat.Value)
    S["1Zh"] = S["1G"]*(Train.LK3.Value+Train.KSH2.Value*C(RK==1 and (P==1 or P==3)))
    Train.LK1:TriggerInput("Set",S["1Zh"]*C(P==1 or P==2)*S["ZR"])
    Train.LK3:TriggerInput("Set",S["1Zh"]*S["ZR"])
    Train.RR:TriggerInput("Set",S["1Zh"]*C(P==1 or P==3)*S["ZR"])

    Train["RUTavt"] = S["6A"]*(1-Train.KSH2.Value)
    if isE then
        S["6K"] = S["6A"]*C(RK==1)*(1-Train.LK1.Value)
    else
        S["6K"] = S["6A"]*C(RK==1)*(1-Train.LK1.Value)
    end
    Train.KSH3:TriggerInput("Set",S["6K"])
    Train.KSH4:TriggerInput("Set",S["6K"])

    Train.RPvozvrat:TriggerInput("Open",T[17]*RUM) --FIXME Mayve more right RP code
    S["20A"] = T[20]*RUM
    if isE then
        Train.LK2:TriggerInput("Set",S["20A"]*Train.LK1.Value*S["ZR"])
    else
        Train.LK2:TriggerInput("Set",S["20A"]*(1-Train.RPvozvrat.Value)*S["ZR"])
    end
    S["20V"] = C((RK==1 or RK==18) and P==1)
    S["20G"] = C(1<=RK and RK<=5 and (P==2 or P==3))
    if isE then
        S["20D"] = S["20A"]*(S["20G"]+S["20V"]*((1-Train.Rper.Value)+Train.KSH1.Value))
        Train.KSH2:TriggerInput("Set",S["20D"])
        Train.KSH1:TriggerInput("Set",S["20D"])--+S["20V"]*(1-Train.Rper.Value))
    else
        S["20D"] = S["10A"]*(S["20G"]+S["20V"]*((1-Train.Rper.Value)+Train.KSH1.Value))
        Train.KSH2:TriggerInput("Set",S["20D"]*(Train.LK2.Value+Train.LK4.Value))
        Train.KSH1:TriggerInput("Set",S["20D"]*(Train.LK2.Value+Train.LK4.Value))--+S["20V"]*(1-Train.Rper.Value))
    end
    Train["RRTuderzh"] = T[25]

    --Вспом цепи низкого напряжения
    Train:WriteTrainWire(11,BO*Train.VU2.Value)
    if isE then
        S["23A"] = BO*Train.KU1.Value
        Train:WriteTrainWire(22,(S["23A"]+T[23])*(Train.AK.Value))
        Train:WriteTrainWire(23,S["23A"])
    else
        Train:WriteTrainWire(22,BO*Train.KU1.Value*(Train.AK.Value))
        Train:WriteTrainWire(23,BO*Train.KU15.Value)
    end
    Panel.AVU = BO*(1-Train.AVU.Value)
    Train:WriteTrainWire(27,BO*Train.KU4.Value)
    Train:WriteTrainWire(28,BO*Train.KU5.Value)

    if isE then
        S["D1"] = BO*KV["D-D1"]
        S["F7"] = BO*KV["F-F7"]
        Train:WriteTrainWire(31,S["D1"]*(Train.KU10.Value+Train.KU6.Value+Train.KU13.Value))
        Train:WriteTrainWire(32,S["D1"]*(Train.KU10.Value+Train.KU7.Value))
        Train:WriteTrainWire(12,S["F7"]*Train.KU12.Value)
        Panel.RedLights = BO*KV["10-F1"]
    else
        S["D1"] = BO*(KV["D-D1"]+KRU["11/3-D1/1"])
        S["F7"] = (BO*KV["F-F7"]+KRU["11/3-FR1"])
        Train.RRP:TriggerInput("Set",T[14])
        if isEm then
            Train:WriteTrainWire(31,S["D1"]*(Train.KU6.Value+Train.KU13.Value)+T[12]+Train.KU10R.Value)
            Train:WriteTrainWire(32,S["D1"]*Train.KU7.Value+T[12]+Train.KU10R.Value)
            Train:WriteTrainWire(12,S["D1"]*Train.KU10.Value)
        else
            Train:WriteTrainWire(31,S["D1"]*(Train.KU6.Value+Train.KU13.Value)+T[12])
            Train:WriteTrainWire(32,S["D1"]*Train.KU7.Value+T[12])
            Train:WriteTrainWire(12,S["D1"]*Train.KU10.Value)
        end
        Panel.RedLights = BO*KV["B2-F1"]
    end
    Train:WriteTrainWire(16,S["D1"]*Train.KU2.Value*Train.KU3.Value)
    Panel.Headlights1 = S["F7"]
    Panel.Headlights2 = S["F7"]*Train.KU16.Value


    if isE then
        S["11A"] = T[11]*(1-Train.KZ1.Value)
        Panel.Ring = S["11A"]+T[28]
    elseif isEm then
        S["11A"] = T[11]*(1-Train.NR.Value)
        Panel.Ring = S["11A"]+T[28]
    else
        S["11A"] = T[11]*(1-Train.NR.Value)
        Panel.Ring = ARS.Ring+S["11A"]+T[28]
    end
    Panel.EmergencyLights1 = BO*Train.VU3.Value+S["11A"]*(1-Train.VU3.Value)
    Panel.EmergencyLights2 = S["11A"]
    Panel.MainLights1 = math.max(0,math.min(1,
        (
            self.Aux750V-100
            -self.Itotal*0.25*C(Train.PositionSwitch.SelectedPosition >= 3)
            -25*Train.KK.Value
        )/750*(0.5+0.5*B*Train.VB.Value*Train.KZ1.Value)
    ))
    Panel.MainLights2 = Panel.MainLights1*Train.KO.Value
    Train.Battery:TriggerInput("Charge", Train.VB.Value*Panel.MainLights1)

    Panel.VPR = BO*Train.RST.Value

    if isE then
        Train.KK:TriggerInput("Set",T[22])
    else
        Train.KK:TriggerInput("Set",(T[22]+T[23])*(1-Train.TRK.Value))
    end
    Train.KO:TriggerInput("Close",T[27])
    Train.KO:TriggerInput("Open",T[28])

    local BD = 1-Train.BD.Value
    Train:WriteTrainWire(15,BD*(1-Train.KU11.Value))--Заземление 15 провода
    Train.Panel.SD = (S["D1"]+BO*Train.KU11.Value)*(T[15]*(1-Train.KU11.Value)+BD)
    Train.Panel.SDW = BO*BD

    Train.VDZ:TriggerInput("Set",T[16]*BD)
    if isE then
        Train.VDOL:TriggerInput("Set",T[31])
        Train.VDOP:TriggerInput("Set",T[32])
    else
        Train.VDOL:TriggerInput("Set",T[31]+T[12])
        Train.VDOP:TriggerInput("Set",T[32]+T[12])
        if isEm then
            Panel.PCBKPower = T[10]*Train["50V"].Value
        else
            Panel.PCBKPower = T[10]
        end
    end
    return S
end

function TRAIN_SYSTEM:SolveRKInternalCircuits(Train)
    ---[[
    local RheostatController = Train.RheostatController
    local P = Train.PositionSwitch.SelectedPosition
    local RK = RheostatController.SelectedPosition
    local B = (Train.Battery.Voltage > 55) and 1 or 0
    local T = Train.SolverTemporaryVariables

    local isE = self.Type == 1

    local BO = min(1,B * Train.VB.Value+T[10])--B * Train.VB.Value

    local RUM = Train.KV.RCU
    if isE then
        S["ZR"] = 1
    else
        S["ZR"] = (1-Train.RRP.Value)+(B*Train.RRP.Value)*-1
    end

    S["10A"] = BO*RUM
    --РУТ
    --СДРК
    S["10B"] = S["10A"]*(Train.RV1.Value+Train.TSH.Value)
    if isE then
        S["25B"] = (1-Train.TSH.Value)*Train.LK2.Value
        S["25A"] = min(1,Train.KSH2.Value + Train.RS.Value)
        Train["RUTreg"] = S["10A"]*(S["25B"]-S["25A"])
        S["10I"] = S["10A"]*RheostatController.RKM2
        Train["RUTpod"] = S["10I"]*Train.LK4.Value
        Train["RRTpod"] = S["10I"]*(1-Train.LK2.Value)
    else
        S["25B"] = S["10B"]*(1-Train.TSH.Value)*Train.LK1.Value
        S["25A"] = Train.KSH2.Value
        Train["RUTreg"] = S["10A"]*(S["25B"]-S["25A"])
        S["10I"] = S["10A"]*RheostatController.RKM2
        Train["RUTpod"] = S["10I"]*Train.LK4.Value
        Train["RRTpod"] = S["10I"]*(1-Train.LK1.Value)
    end
    Train.RRT:TriggerInput("Close",Train.RRTuderzh*Train.RRTpod)
    Train.RRT:TriggerInput("Open",(1-Train.RRTuderzh))
    local SDRKr = 0
    if isE then
        SDRKr = 1-Train.LK4.Value*(0.2+0.3*C(2 <=RK and RK <= 7 and (P==1 or P==3 or P==4)))
    else
        SDRKr = 1-Train.LK2.Value*(0.2+0.3*C(2 <=RK and RK <= 7 and (P==1 or P==3 or P==4)))
    end
    RheostatController:TriggerInput("MotorCoilState",min(1,S["10A"]*(S["10B"]*Train.RR.Value - S["10B"]*(1-Train.RR.Value)))*SDRKr)

    S["10N"] = S["10A"]*(RheostatController.RKM1+Train.SR1.Value*(1-Train.RUT.Value))
    S["10T"] = --[[ S["10N"]*--]] ((1-Train.SR1.Value)+Train.RUT.Value)*(RheostatController.RKP)
    RheostatController:TriggerInput("MotorState",(S["10N"]+S["10T"]*(-10)))
    --СДПП
    S["10AV"] = S["10A"]*(1-Train.LK3.Value)*C(2<=RK and RK<=18)*(1-Train.LK4.Value)
    S["10E"] = S["10A"]*((1-Train.LK3.Value)+Train.Rper.Value+Train.PositionSwitch.PMPos)
    if isE then
        Train.SR2:TriggerInput("Set",S["10E"]*((C(P==3 or P==4)+Train.KSH2.Value))*(1-Train.LK4.Value))

        S["10AD"] = (1-Train.LK1.Value)*Train.SR2.Value
        S["10AZh"] = S["10AD"]*Train.TSH.Value*C(P==1 or P==2 or P==4)
    else
        S["10AD"] = (1-Train.LK1.Value)*(C(P==3 or P==4)+Train.LK2.Value)
        S["10AZh"] = S["10AD"]*Train.TSH.Value*Train.KSH2.Value*C(P==1 or P==2 or P==4)
    end
    S["10AR"] = S["10AD"]*(1-Train.KSH3.Value)*(1-Train.TSH.Value)*C(2<=P and P<=4)
    S["10Ya"] = Train.LK3.Value*C(RK==18 and (P==1 or P==3))
    S["10AG"] = S["10E"]*(S["10AR"]+S["10AZh"]+S["10Ya"])
    Train.PositionSwitch:TriggerInput("MotorState",-1.0 + 2.0*math.max(0,S["10AG"]))
    S["2A"] = T[2]*RUM
    S["2G"] = S["2A"]*(C(P==1 or P==3)*C(1<=RK and RK<=17)+C(P==2 or P==4)*(C(5<=RK and RK<=18)+C(2<=RK and RK<=4)*Train.KSH1.Value))
    if isE then
        S["2E"] = S["2G"]*(1-Train.SR2.Value)*Train.LK4.Value+S["10AV"]
    else
        S["2E"] = S["2G"]*Train.LK4.Value+S["10AV"]
    end
    Train.RV1:TriggerInput("Set",S["2E"]*S["ZR"])
    Train.SR1:TriggerInput("Set",S["2E"]*(1-Train.RRT.Value)*S["ZR"])

    Train.Rper:TriggerInput("Set",T[3]*RUM*C(17<=RK and RK<=18)*S["ZR"])

    S["6A"] = T[6]*RUM
    Train["RUTavt"] = S["6A"]*(1-Train.KSH2.Value)

    return S
end

local wires = {1,2,3,4,5,6,8,10,11,12,13,14,15,16,17,18,20,22,23,24,25,27,28,31,32,-34,34,44,48}
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
    self.ExtraResistanceLK2 = Train.KF_47A["L1-L2"]*(1-Train.LK2.Value)*Train.LK1.Value
    if Train.PositionSwitch.SelectedPosition == 1 then -- PP
        self.R1 = Train.ResistorBlocks.R1C1(Train)
        self.R2 = Train.ResistorBlocks.R2C1(Train)
        self.R3 = 0.0
    elseif Train.PositionSwitch.SelectedPosition == 2 then -- PP
        self.R1 = Train.ResistorBlocks.R1C2(Train)
        self.R2 = Train.ResistorBlocks.R2C2(Train)
        self.R3 = 0.0
    elseif Train.PositionSwitch.SelectedPosition >= 3 then -- PT
        self.R1 = Train.ResistorBlocks.R1C3(Train)
        self.R2 = Train.ResistorBlocks.R2C3(Train)
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
    local Brake = Train.TSH.Value*--[[ Train.KSH1.Value*--]] Train.LK3.Value*Train.LK4.Value*C(Train.PositionSwitch.SelectedPosition>=3)
    local Magnetization = self.Aux750V/750
    self.Magnetization = (self.Magnetization+(1-self.Magnetization)*dT*(0.5+Magnetization*1.5))*Brake
    self.Rs1 = Train.ResistorBlocks.S1(Train) + 1e9*(1 - Train.KSH1.Value)
    self.Rs2 = Train.ResistorBlocks.S2(Train) + 1e9*(1 - Train.KSH2.Value)
    --self.Rs1 = 0.09+Train.ResistorBlocks.S1(Train) + 1e9*(1 - Train.KSH1.Value)
    --self.Rs2 = 0.09+Train.ResistorBlocks.S2(Train) + 1e9*(1 - Train.KSH2.Value)
    --self.Rs1 = 0.392*0.17*Train.KSH1.Value+Train.ResistorBlocks.S1(Train)*0.83 + 1e9*(1 - Train.KSH1.Value)
    --self.Rs2 = 0.392*0.17*Train.KSH2.Value+Train.ResistorBlocks.S2(Train)*0.83 + 1e9*(1 - Train.KSH2.Value)

    -- Calculate total resistance of engines winding
    local RwAnchor = Train.Engines.Rwa*2 -- Double because each set includes two engines
    local RwStator = Train.Engines.Rws*2
    -- Total resistance of the stator + shunt
    self.Rstator13  = (RwStator^(-1) + self.Rs1^(-1))^(-1)
    self.Rstator24  = (RwStator^(-1) + self.Rs2^(-1))^(-1)
    -- Total resistance of entire motor
    self.Ranchor13  = RwAnchor
    self.Ranchor24  = RwAnchor

    if Train.PositionSwitch.SelectedPosition == 1 then -- PS
        self:SolvePS(Train)
    elseif Train.PositionSwitch.SelectedPosition == 2 then -- PS
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
    local T13const1 = math.max(14.00,math.min(280.0,(self.R13^2) * 2.0)) -- R * L
    local T24const1 = math.max(14.00,math.min(280.0,(self.R24^2) * 2.0)) -- R * L

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
    if Train.PositionSwitch.SelectedPosition == 1 then -- PS
        self.I13 = self.I13 * (Train.LK3.Value * Train.LK4.Value * Train.LK1.Value)
        self.I24 = self.I24 * (Train.LK3.Value * Train.LK4.Value * Train.LK1.Value)

        self.I24 = (self.I24 + self.I13)*0.5
        self.I13 = self.I24
        self.Itotal = self.I24
    elseif Train.PositionSwitch.SelectedPosition == 2 then -- PS
        self.I13 = self.I13 * Train.LK3.Value * Train.LK4.Value * Train.LK1.Value
        self.I24 = self.I24 * Train.LK3.Value * Train.LK4.Value * Train.LK1.Value

        self.Itotal = self.I13 + self.I24
    else -- PT
        self.I13 = self.I13 * Train.LK3.Value*Train.LK4.Value
        self.I24 = self.I24 * Train.LK4.Value*Train.LK3.Value

        self.Itotal = self.I13 + self.I24
    end

    -- Calculate extra information
    self.Uanchor13 = self.I13 * self.Ranchor13
    self.Uanchor24 = self.I24 * self.Ranchor24


    ----------------------------------------------------------------------------
    -- Calculate current through stator and shunt
    --print(250*Train.TSH.Value*Train.Electric.Main750V/750*self.Rstator13)
    --local RR = math.max(0,(Train.Engines.RotationRate-1500)/1500)
    self.Ustator13 = (self.I13) * self.Rstator13--+UshuntAdd*RR
    self.Ustator24 = (self.I24) * self.Rstator24--+UshuntAdd*RR
    self.Ishunt13  = (self.Ustator13) / self.Rs1
    self.Istator13 = (self.Ustator13) / RwStator
    self.Ishunt24  = (self.Ustator24) / self.Rs2
    self.Istator24 = (self.Ustator24) / RwStator

    if Train.PositionSwitch.SelectedPosition >= 3 then
        local I1,I2 = self.Ishunt13,self.Ishunt24
        self.Ishunt13 = -I2
        self.Ishunt24 = -I1

        I1,I2 = self.Istator13,self.Istator24
        self.Istator13 = -I2
        self.Istator24 = -I1
    end

    -- Calculate current through RT2 relay
    if Train.PositionSwitch.SelectedPosition >= 3 then
        self.IRT2 = math.abs(self.Itotal)
    else
        self.IRT2 = 0
    end

    -- Sane checks
    if self.R1 > 1e5 then self.IR1 = 0 end
    if self.R2 > 1e5 then self.IR2 = 0 end

    -- Calculate power and heating
    local K = 12.0*1e-5
    local H = (10.00+(15.00*Train.Engines.Speed/80.0))*1e-3
    self.P1 = (self.IR1^2)*self.R1
    self.P2 = (self.IR2^2)*self.R2
    --self.T1 = (self.T1 + self.P1*K*dT - (self.T1-25)*H*dT)
    --self.T2 = (self.T2 + self.P2*K*dT - (self.T2-25)*H*dT)
    self.Overheat1 = math.min(1-1e-12,
        self.Overheat1 + math.max(0,(math.max(0,self.T1-750.0)/400.0)^2)*dT )
    self.Overheat2 = math.min(1-1e-12,
        self.Overheat2 + math.max(0,(math.max(0,self.T2-750.0)/400.0)^2)*dT )

    -- Energy consumption
    self.ElectricEnergyUsed = self.ElectricEnergyUsed + math.max(0,self.EnergyChange)*dT
    self.ElectricEnergyDissipated = self.ElectricEnergyDissipated + math.max(0,-self.EnergyChange)*dT
end

local Cosumers = {
    LK1 = 0.05,
    LK2 = 0.05,
    LK3 = 0.05,
    LK4 = 0.05,
    LK5 = 0.05,
    KSH1 = 0.05,
    KSH2 = 0.05,
    KSH3 = 0.05,
    KSH4 = 0.05,
    TSH = 0.05,
    PR = 0.02,
    RV1 = 0.02,
    SR1 = 0.02,
    SR2 = 0.02,
    PneumaticNo1 = 0.03,
    PneumaticNo2 = 0.03,
    Rper = 0.03,
    RRT = 0.03,
    VDOL = 0.03,
    VDOP = 0.03,
    VDZ = 0.03,
}
function TRAIN_SYSTEM:Think(dT,iter)
    local Train = self.Train
    if not self.ResistorBlocksInit then
        self.ResistorBlocksInit  = true
        Train:LoadSystem("ResistorBlocks","Gen_Res_703")
    end
    if iter == 1 then Train.ResistorBlocks.InitializeResistances_81_703(Train) end
    ----------------------------------------------------------------------------
    -- Voltages from the third rail
    ----------------------------------------------------------------------------
    self.Main750V = Train.TR.Main750V
    self.Aux750V  = Train.TR.Main750V*Train.AV.Value
    self.Power750V = self.Main750V * Train.GV.Value


    ----------------------------------------------------------------------------
    -- Solve circuits
    ----------------------------------------------------------------------------
    self:SolvePowerCircuits(Train,dT)
    self:SolveInternalCircuits(Train,dT,iter==1)
    if iter==1 then
        --local time = SysTime()
        local count = 0
        for k,v in pairs(Cosumers) do
            count = count + Train[k].Value*v
        end
        count = count + math.abs(Train.RheostatController.Velocity*0.015)
        count = count + math.abs(Train.PositionSwitch.Velocity*0.02)
        count = count + math.abs(Train.Reverser.Speed)
        self.Cosume = count
    end


    ----------------------------------------------------------------------------
    -- Calculate current flow out of the battery
    ----------------------------------------------------------------------------
    --local totalCurrent = 5*A30 + 63*A24 + 16*A44 + 5*A39 + 10*A80
    --local totalCurrent = 20 + 60*DIP
end

--------------------------------------------------------------------------------
function TRAIN_SYSTEM:SolvePS(Train)
    -- Calculate total resistance of the entire series circuit
    local Rtotal = self.Ranchor13 + self.Ranchor24 + self.Rstator13 + self.Rstator24 +
        self.R1 + self.R2 + self.R3 + self.ExtraResistanceLK2
    local CircuitClosed = (self.Power750V*Train.LK1.Value > 0) and 1 or 0

    -- Calculate total current
    self.Utotal = (self.Power750V - Train.Engines.E13 - Train.Engines.E24)*Train.LK1.Value
    self.Itotal = (self.Utotal / Rtotal)*CircuitClosed

    -- Total resistance (for induction RL circuit)
    self.R13 = Rtotal
    self.R24 = Rtotal

    -- Calculate everything else
    self.I13 = self.Itotal
    self.I24 = self.Itotal
    self.U13 = self.Utotal*(1/2)
    self.U24 = self.Utotal*(1/2)

    -- Energy consumption
    self.EnergyChange = math.abs((self.Itotal^2)*Rtotal)
end

function TRAIN_SYSTEM:SolvePP(Train,inTransition)
    -- Temporary hack for transition to parallel circuits
    local extraR = 0.00 --inTransition and 0.909 or 0.00

    -- Calculate total resistance of each branch
    local R1 = self.Ranchor13 + self.Rstator13 + self.R1 + extraR + self.ExtraResistanceLK2
    local R2 = self.Ranchor24 + self.Rstator24 + self.R2 + extraR + self.ExtraResistanceLK2
    local R3 = 0
    local CircuitClosed = (self.Power750V*Train.LK1.Value > 0) and 1 or 0

    -- Main circuit parameters
    local V = self.Power750V*Train.LK1.Value
    local E1 = Train.Engines.E13
    local E2 = Train.Engines.E24

    -- Calculate current through engines 13, 24
    self.I13 = -((E1*R2 + E1*R3 - E2*R3 - R2*V)/(R1*R2 + R1*R3 + R2*R3))*CircuitClosed
    self.I24 = -((E2*R1 - E1*R3 + E2*R3 - R1*V)/(R1*R2 + R1*R3 + R2*R3))*CircuitClosed

    -- Total resistance (for induction RL circuit)
    self.R13 = R1
    self.R24 = R2

    -- Calculate everything else
    self.U13 = self.I13*R1
    self.U24 = self.I24*R2
    self.Utotal = (self.U13 + self.U24)/2
    self.Itotal = self.I13 + self.I24

    -- Energy consumption
    self.EnergyChange = math.abs((self.I13^2)*R1) + math.abs((self.I24^2)*R2)
end

function TRAIN_SYSTEM:SolvePT(Train)
    -- Winding resistances
    local R1 = self.Ranchor13 + self.Rstator13
    local R2 = self.Ranchor24 + self.Rstator24
    -- Total resistance of the entire braking rheostat
    local R3 = self.R1 + self.R2 + self.R3

    -- Main circuit parameters
    local V = self.Power750V*Train.LK1.Value
    local E1 = Train.Engines.E13
    local E2 = Train.Engines.E24

    -- Calculate current through engines 13, 24
    self.I13 = -((E1*R2 + E1*R3 - E2*R3 - R2*V)/(R1*R2 + R1*R3 + R2*R3))*(Train.BV and Train.BV.State or 1)
    self.I24 = -((E2*R1 - E1*R3 + E2*R3 - R1*V)/(R1*R2 + R1*R3 + R2*R3))*(Train.BV and Train.BV.State or 1)

    -- Total resistance (for induction RL circuit)
    self.R13 = R3+((R1^(-1) + R2^(-1))^(-1))
    self.R24 = R3+((R1^(-1) + R2^(-1))^(-1))
    -- Calculate everything else
    self.U13 = self.I13*R1
    self.U24 = self.I24*R2
    self.Utotal = (self.U13 + self.U24)/2
    self.Itotal = self.I13 + self.I24

    -- Energy consumption
    self.EnergyChange = -math.abs(((0.5*self.Itotal)^2)*self.R13)
end

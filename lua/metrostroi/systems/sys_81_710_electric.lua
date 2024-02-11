--------------------------------------------------------------------------------
-- 81-710 electric schemes
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_710_Electric")
function TRAIN_SYSTEM:Initialize(typ1,typ2)
    self.ThyristorController = true

    -- Load all functions from base
    Metrostroi.BaseSystems["Electric"].Initialize(self)
    for k,v in pairs(Metrostroi.BaseSystems["Electric"]) do
        if not self[k] and type(v) == "function" then
            self[k] = v
        end
    end

    self.RRI = 0
end

if CLIENT then return end
function TRAIN_SYSTEM:Inputs(...) 
    return { "Type", "RRI" }
end
function TRAIN_SYSTEM:Outputs(...)
    return Metrostroi.BaseSystems["Electric"].Outputs(self,...)
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "RRI" then self.RRI = value end
end
-- Node values
local S = {}
-- Converts boolean expression to a number
local function C(x) return x and 1 or 0 end

local min = math.min
local max = math.max

function TRAIN_SYSTEM:SolveAllInternalCircuits(Train,dT,firstIter)
    local RheostatController = Train.RheostatController
    local P     = Train.PositionSwitch.SelectedPosition
    local RK    = Train.RheostatController.SelectedPosition
    local B     = Train.PR1.Value*((Train.Battery.Voltage > 55) and 1 or 0)
    local T     = Train.SolverTemporaryVariables

    local BO = min(1,B * Train.VB.Value+T[10])--B * Train.VB.Value
    local KV = Train.KV
    local KRU = Train.KRU
    local Panel = Train.Panel
    local ARS = Train.ALS_ARS
    local RUM = Train.RUM.Value
    local BC = (Panel.MainLights1+Panel.MainLights2)

    
    Train:WriteTrainWire(10,B*Train.VB.Value)
    Panel.V1 = BO
    S["10AK"] = BO*Train.PRL24.Value*Train.VU.Value 
    --10AK->AV --FIXME SAMM
    S["U2"] = S["10AK"]*KV["U2-10AK"]
    S["F7"] = BO*(KV["F-F7"]+(KRU["11/3-FR1"]*Train.PRL6A.Value))
    Train:WriteTrainWire(1,S["10AK"]*KV["10AK-1"]*Train.R1_5.Value+(KRU["1/3-ZM31"]*Train.PRL6A.Value)*-10) --FIXME KRU
    Train:WriteTrainWire(2,S["U2"]*KV["U2-2"]+(KRU["2/3-ZM31"]*Train.PRL6A.Value)*-10+ARS["2"]*RUM) --FIXME ARS SAMM KRU
    Train:WriteTrainWire(3,S["U2"]*KV["U2-3"]+(KRU["3/3-ZM31"]*Train.PRL6A.Value)*-10) --FIXME SAMM KRU
    Train:WriteTrainWire(4,S["10AK"]*KV["U2-4"])
    Train:WriteTrainWire(5,S["10AK"]*KV["U2-5"]+(KRU["5/3-ZM31"]*Train.PRL6A.Value)*-10*(1-Train.KRR.Value)+BO*(KRU["14/1-B3"]*Train.PRL6A.Value)*Train.KRR.Value)
    Train:WriteTrainWire(6,S["10AK"]*Train.RVT.Value)--FIXME ARS SAMM
    Train:WriteTrainWire(8,BO*KV["10-8"]+S["F7"]*(1-Train.RPB.Value)*(1-Train.VAH.Value)+(ARS["8"]*Train.PRL33.Value*RUM))--FIXME ARS
    --Train:WriteTrainWire(9, BO)
    Train:WriteTrainWire(14,(BO*(KRU["14/1-B3"]*Train.PRL6A.Value)+T[5]*Train.KRR.Value)*Train.KU10.Value)--BO*KV["10-14A"]*KV["14A-14B"]*(ARS["33D"]*RUM+(1-RUM)))--FIXME ARS SAMM
    Train:WriteTrainWire(17,S["10AK"]*KV["10AK-17"]*Train.KU9.Value)--FIXME SAMM
    Train:WriteTrainWire(20,S["U2"]*KV["U2-20"]+(KRU["20/3-ZM31"]*Train.PRL3A.Value)*-10+ARS["20"]*RUM) --FIXME ARS SAMM KRU
    Train:WriteTrainWire(29,ARS["48"]*RUM)--(BO*(KRU["14/1-B3"]*Train.PRL6A.Value)+T[5]*Train.KRR.Value)*Train.KU10.Value)
    Train:WriteTrainWire(24,S["U2"]*Train.KU8.Value)
    Train:WriteTrainWire(25,S["U2"]*KV["U2-6"]*KV["6-25"]*Train.K25.Value) --FIXME ARS SAMM KRU
    Train:WriteTrainWire(30,BO*Train.BSM_RUT.Value) --FIXME ARS SAMM KRU

    Train.RVT:TriggerInput("Set",S["U2"]*KV["U2-6"]+ARS["33G"]*RUM) --FIXME ARS SAMM
    Train.K25:TriggerInput("Set",S["U2"]*KV["U2-6"]*(ARS["33Zh"]*RUM+(1-RUM))) --FIXME ARS SAMM
    Train.RV2:TriggerInput("Set",S["10AK"]*KV["33-10AK"]) --FIXME SAMM
    Train.R1_5:TriggerInput("Set",S["10AK"]*Train.RV2.Value*Train.UAVAC.Value*(Train.RPB.Value+Train.VAH.Value)*((ARS["33D"]*Train.SOT.Value)*RUM+(1-RUM))) --FIXME SAMM
    if self.RRI> 0 then
        local RRI_VV = Train.RRI_VV
        RRI_VV.Power = BO*Train.R_Radio.Value*Train.RRIEnable.Value*Train.PRL4A.Value
        RRI_VV.AmplifierPower = BO*Train.RRIAmplifier.Value*Train.PRL4A.Value
        RRI_VV.CabinSpeakerPower = RRI_VV.Power*Train.RRI.LineOut*Train.R_G.Value
        Train:WriteTrainWire(13,RRI_VV.AmplifierPower*Train.RRI.LineOut)
        --RRI_VV.CabinSpeakerPower = T[13]
    else
        local ASNP_VV = Train.ASNP_VV
        ASNP_VV.Power = BO*Train.R_ASNPOn.Value*Train.R_Radio.Value*Train.PRL4A.Value
        ASNP_VV.AmplifierPower = ASNP_VV.Power*Train.ASNP.LineOut*Train.R_UNch.Value
        ASNP_VV.CabinSpeakerPower = ASNP_VV.Power*Train.ASNP.LineOut*Train.R_G.Value
        Train:WriteTrainWire(13,ASNP_VV.AmplifierPower)
        --Train:WriteTrainWire(-13,ASNP_VV.AmplifierPower*Train.PowerSupply.X2_2)
        --ASNP_VV.CabinSpeakerPower = ASNP_VV.Power*Train.ASNP.LineOut*Train.R_G.Value
        Panel.CBKIPower = T[10]*Train.PRL4A.Value
    end
    Panel.AnnouncerPlaying = T[13]

    ARS.ALS = S["F7"]*Train.ALS.Value*Train.PRL32.Value*RUM
    ARS.GE = S["F7"]*Train.PRL32.Value*Train.ARS.Value*RUM
    ARS.DAR = S["10AK"]*Train.BUM_RET.Value*RUM
    ARS.DA = S["10AK"]*Train.BUM_RET.Value*RUM
    Train.BLPM.Power = ARS.ALS*Train.PRL30.Value
    Train.BIS200.Power = ARS.ALS*Train.PRL30.Value
    Train:WriteTrainWire(-21,S["10AK"]*(1-Train.BSM_GE.Value))
    Train:WriteTrainWire(21,Train.RKTT.Value+Train.DKPT.Value)
    ARS.KT = T[21]*T[-21]*Train.BSM_GE.Value
    Train.BSM_KRT:TriggerInput("Set",max(0,T[6])*RUM)

    Train.BUM_KRD:TriggerInput("Set",(T[31]+T[32]+T[12])*RUM)
    Train.BSM_KRH:TriggerInput("Set",S["10AK"]*KV["33-10AK"]*RUM)
    Train.BSM_KRO:TriggerInput("Set",S["10AK"]*KV["10AK-1"]*RUM)

    Train.RPB:TriggerInput("Set",S["F7"]*(Train.PB.Value+ARS.GE*RUM))

    Panel.RRP = S["U2"]*T[18]

    Panel.LKVT = ARS.GE*Train.BSM_GE.Value*(1-Train.BSM_RNT.Value)

    local RCU = KV.RCU

    S["ZR"] = (1-Train.RRU.Value)+(B*Train.RRU.Value)*-1
    Train.RZ_2:TriggerInput("Set",T[24]*RCU*(1-Train.LK4.Value))
    S["18A"] = RCU*(Train.RPvozvrat.Value*100+(1-Train.LK4.Value))
    Train:WriteTrainWire(18,S["18A"])
    Panel.TW18 = S["18A"]

    local Reverser = Train.Reverser
    S["4A"] = T[4]*RCU
    S["5A"] = T[5]*RCU
    Reverser:TriggerInput("NZ",S["4A"]*Reverser.VP)
    Reverser:TriggerInput("VP",S["5A"]*Reverser.NZ)
    Train.LK4:TriggerInput("Set",(S["4A"]*Reverser.NZ+S["5A"]*Reverser.VP)*(1-Train.RPvozvrat.Value)*Train.LK3.Value*S["ZR"])

    Train.PneumaticNo1:TriggerInput("Set",T[8]*Train.PRL23.Value*C(17 <= RK and RK <= 18)+T[29])
    Train.PneumaticNo2:TriggerInput("Set",T[8]*Train.PRL23.Value*(1-Train.RT2.Value)*((1-Train.LK4.Value)+C(RK==1)))

    S["10A"] = BO*RCU
    self.ThyristorControllerPower = S["10A"]

    S["10B"] = Train.PRL16.Value*S["10A"]*(Train.RV1.Value+Train.TR1.Value)

    --Train["RUTreg"] = T[9]
    S["10I"] = S["10A"]*RheostatController.RKM2
    --Train.Panel.Sequence =S["10A"]*RheostatController.RKM1
    Train["RUTpod"] = S["10I"]*Train.LK4.Value
    Train["RRTpod"] = S["10I"]*(1-Train.LK1.Value)
    Train.RRT:TriggerInput("Close",Train.RRTuderzh*Train.RRTpod)
    Train.RRT:TriggerInput("Open",(1-Train.RRTuderzh))

    local SDRKr = 1-Train.LK2.Value*(0.25*C(2 <=RK and RK <= 7 and P==1))
    RheostatController:TriggerInput("MotorCoilState",min(1,S["10A"]*(S["10B"]*Train.RR.Value - S["10B"]*(1-Train.RR.Value)))*SDRKr)

    S["10N"] = S["10A"]*(RheostatController.RKM1+Train.SR1.Value*(1-Train.RUT.Value))
    S["10T"] = ((1-Train.SR1.Value)+Train.RUT.Value)*(RheostatController.RKP)

    RheostatController:TriggerInput("MotorState",(S["10N"]+S["10T"]*(-10)))

    --СДПП
    S["10AV"] = S["10A"]*(1-Train.LK3.Value)*C(2<=RK and RK<=18)*(1-Train.LK4.Value)
    S["10E"] = S["10A"]*Train.PRL28.Value*((1-Train.LK3.Value)+Train.Rper.Value+Train.PositionSwitch.PMPos)
    Train.SR2:TriggerInput("Set",S["10E"]*((C(P==3 or P==4)+Train.LK2.Value))*(1-Train.LK4.Value))

    S["10AD"] = (1-Train.LK1.Value)*Train.SR2.Value
    S["10AYu"] = S["10AD"]*(1-Train.RPP.Value)
    S["10AZh"] = S["10AD"]* Train.TR1.Value*C(P==1 or P==2 or P==4)
    S["10AR"] = S["10AYu"]*(1-Train.TR1.Value)*C(2<=P and P<=4)
    S["10Ya"] = Train.PRL28.Value*Train.LK3.Value*C(RK==18 and (P==1))
    S["10AG"] = S["10E"]*(S["10AR"]+S["10AZh"]+S["10Ya"])
    Train.PositionSwitch:TriggerInput("MotorState",-1.0 + 2.0*math.max(0,S["10AG"]))

    S["2A"] = T[2]*RCU
    S["2G"] = S["2A"]*((1-Train.TR1.Value)+(1-Train.KSB1.Value)+Train.ThyristorBU5_6.Value)*(
           C(1<=RK and RK<=17 and (P==1 or P==3)
        or (6<=RK and RK<=18
            or 2<=RK and RK<=5 and Train.KSH1.Value>0
            ) and (P==2 or P==4)
        )
    )
    S["2E"] = S["2G"]*Train.LK4.Value+S["10AV"]
    Train.RV1:TriggerInput("Set",S["2E"]*S["ZR"])
    Train.SR1:TriggerInput("Set",S["2E"]*(1-Train.RRT.Value)*S["ZR"])
    Train.Rper:TriggerInput("Set",T[3]*RCU*C(17<=RK and RK<=18)*S["ZR"])
    Train.RU:TriggerInput("Set",S["2A"])

    Train.RRU:TriggerInput("Set",T[14])

    S["6A"] = T[6]*RCU
    Train.TR1:TriggerInput("Set",S["6A"])
    Train.RPP:TriggerInput("Set",S["6A"])
    S["6G"] = S["6A"]*C(P==3 or P==4)
    S["6Yu"] = S["6G"]*C(1<=RK and RK<=2)
    Train.KSB1:TriggerInput("Set",S["6Yu"])
    Train.KSB2:TriggerInput("Set",S["6Yu"])
    Train.RUP:TriggerInput("Set",S["6Yu"])
    self.ThyristorControllerWork = (S["6Yu"]+S["6G"]*Train.RUP.Value)*Train.LK4.Value

    S["1A"] = T[1]*RCU
    S["1R"] = S["1A"]*((1-Train.RV1.Value)*C(P==1)+C(1<=RK and RK<=5 and P==2))
    Train.KSH2:TriggerInput("Set",S["1R"]*S["ZR"]) --Идет обратная цепь от ЛК к 1 проводу, но мне лень
    Train.KSH1:TriggerInput("Set",S["1R"]*S["ZR"]) --Идет обратная цепь от ЛК к 1 проводу, но мне лень

    S["1P"] = S["1A"]*C(P == 1 or P == 2)*(Train.NR.Value+Train.RPU.Value)+S["6A"]*C(P==3 or P==4)
    Train["RUTavt"] = S["1P"]*(Train.KSB1.Value+Train.KSH2.Value)*S["ZR"] --Идет обратная цепь от ЛК к 1 проводу, но мне лень
    S["1G"] = S["1P"]*Train.AVT.Value*(1-Train.RPvozvrat.Value)
    S["1Zh"] = S["1G"]*(Train.LK3.Value+C(RK==1)*(Train.KSH2.Value+Train.KSB1.Value*Train.KSB2.Value)*C(P==1 or P==3)*Train.LK5.Value)
    Train.LK1:TriggerInput("Set",S["1Zh"]*C(P==1 or P==2)*S["ZR"])
    Train.LK3:TriggerInput("Set",S["1Zh"]*S["ZR"])
    Train.RR:TriggerInput("Set",S["1Zh"]*C(P==1 or P==3)*S["ZR"])
    Train.RPvozvrat:TriggerInput("Open",T[17]*RCU) --FIXME Mayve more right RP code
    S["20A"] = T[20]*RCU
    Train.LK2:TriggerInput("Set",S["20A"]*S["ZR"])
    Train.LK5:TriggerInput("Set",S["20A"]*(1-Train.RPvozvrat.Value)*S["ZR"])
    Train["RRTuderzh"] = T[25]
    Train.RKTTsh = T[30]

    --Вспом цепи низкого напряжения
    Train:WriteTrainWire(7,BO*Train.Ring.Value)
    Train:WriteTrainWire(11,BO*Train.VU2.Value*Train.PRL25.Value)
    Train:WriteTrainWire(22,BO*Train.PRL20.Value*Train.V1.Value*Train.AK.Value)
    Train:WriteTrainWire(23,BO*Train.KU15.Value)
    Train:WriteTrainWire(27,BO*Train.PRL21.Value*Train.V4.Value)
    Train:WriteTrainWire(28,BO*Train.PRL21.Value*Train.V5.Value)
    Panel.GRP = BO*Train.PRL21.Value*Train.RPvozvrat.Value
    Panel.Headlights1 = S["F7"]*Train.PRL15.Value
    Panel.Headlights2 = S["F7"]*Train.PRL15.Value*Train.VU14.Value
    Panel.RedLight1 = BO*Train.PRL26.Value*KV["B2-F1"]
    Panel.RedLight2 = BO*Train.PRL12.Value*KV["B2-F1"]
    S["D1"] = BO*Train.PRL22.Value*(KV["D-D1"]+(KRU["11/3-D1/1"]*Train.PRL6A.Value))
    Train:WriteTrainWire(31,S["D1"]*(Train.V6.Value+Train.KU12.Value))
    Train:WriteTrainWire(32,S["D1"]*Train.KU7.Value)
    Train:WriteTrainWire(12,S["D1"]*Train.V10.Value)
    Train:WriteTrainWire(16,S["D1"]*Train.V2.Value*Train.V3.Value)
    Train.RPU:TriggerInput("Set",T[27])
    Panel.LPU = Train.RPU.Value*T[1]

    Panel.PanelLights = BO*Train.PLights.Value
    Panel.GaugeLights = BO*Train.GLights.Value
    S["11A"] = T[11]*(1-Train.NR.Value)
    Panel.Ring = (ARS.Ring+S["11A"]+T[7])*Train.PRL34.Value
    Panel.EmergencyLights1 = (BO*Train.PRL21.Value*Train.VU3.Value)+(S["11A"]*(1-Train.VU3.Value))
    Panel.EmergencyLights2 = Train.PRL13.Value*S["11A"]
    Panel.MainLights1 = math.max(0,math.min(1,(self.Aux750V*Train.PR4.Value*Train.PR9.Value-100-self.Itotal*0.25*C(Train.PositionSwitch.SelectedPosition >= 3)-25*Train.KK.Value)/750*(0.5+0.5*B*Train.VB.Value*Train.PR6.Value)))
    Panel.MainLights2 = math.max(0,math.min(1,(self.Aux750V*Train.PR4.Value*Train.KO.Value*Train.PR8.Value-100-self.Itotal*0.25*C(Train.PositionSwitch.SelectedPosition >= 3)-25*Train.KK.Value)/750*(0.5+0.5*B*Train.VB.Value*Train.PR6.Value)))
    Panel.LightPower = math.max(0,math.min(1,(self.Aux750V-100-self.Itotal*0.25*C(Train.PositionSwitch.SelectedPosition >= 3)-25*Train.KK.Value)/750*(0.5+0.5*B*Train.VB.Value*Train.PR6.Value)))
    Train.Battery:TriggerInput("Charge", Train.PR1.Value*BC*Train.PR6.Value)
    Panel.VPR = BO*Train.RST.Value*Train.PRL4A.Value

    Train.KK:TriggerInput("Set",(T[22]*Train.PRL14.Value)+(T[23]*Train.PRL31.Value))
    Train.KO:TriggerInput("Close",T[27])
    Train.KO:TriggerInput("Open",T[28])

    local BD = 1-Train.BD.Value
    Train:WriteTrainWire(15,BD*(1-Train.KU11.Value))--Заземление 15 провода
    Train.Panel.SD = (S["D1"]+BO*Train.PRL22.Value*Train.KU11.Value)*(T[15]*(1-Train.KU11.Value)+BD)

    Train.VDZ:TriggerInput("Set",T[16]*Train.PRL17.Value*BD)
    Train.VDOL:TriggerInput("Set",(T[31]*Train.PRL18.Value)+(T[12]*Train.PRL2A.Value))
    Train.VDOP:TriggerInput("Set",(T[32]*Train.PRL19.Value)+(T[12]*Train.PRL2A.Value))
    Panel.PCBKPower = T[10]*Train.PRL4A.Value
end
function TRAIN_SYSTEM:SolveRKInternalCircuits(Train,dT,firstIter)
    local RheostatController = Train.RheostatController
    local P     = Train.PositionSwitch.SelectedPosition
    local RK    = Train.RheostatController.SelectedPosition
    local B     = (Train.Battery.Voltage > 55) and 1 or 0
    local T     = Train.SolverTemporaryVariables

    local BO = min(1,B * Train.VB.Value+T[10])--B * Train.VB.Value
    --local KV = Train.KV
    --local Panel = Train.Panel

    local RCU = Train.KV.RCU
    S["ZR"] = (1-Train.RRU.Value)+(B*Train.RRU.Value)*-1

    S["10A"] = BO*RCU 
    S["10I"] = S["10A"]*RheostatController.RKM2
    Train["RUTpod"] = S["10I"]*Train.LK4.Value
    Train["RRTpod"] = S["10I"]*(1-Train.LK1.Value)
    Train["RRTuderzh"] = T[25]
    Train.RRT:TriggerInput("Close",Train.RRTuderzh*Train.RRTpod)
    Train.RRT:TriggerInput("Open",(1-Train.RRTuderzh))

    local SDRKr = 1-Train.LK2.Value*(0.2+0.3*C(2 <=RK and RK <= 7 and P==1))
    RheostatController:TriggerInput("MotorCoilState",min(1,S["10A"]*(S["10B"]*Train.RR.Value - S["10B"]*(1-Train.RR.Value)))*SDRKr)

    S["10N"] = S["10A"]*(RheostatController.RKM1+Train.SR1.Value*(1-Train.RUT.Value))
    S["10T"] = ((1-Train.SR1.Value)+Train.RUT.Value)*(RheostatController.RKP)
    RheostatController:TriggerInput("MotorState",S["10N"]+S["10T"]*(-10))

    S["2A"] = T[2]*RCU
    S["2G"] = S["2A"]*((1-Train.TR1.Value)+(1-Train.KSB1.Value)+Train.ThyristorBU5_6.Value)*(
           C(1<=RK and RK<=17 and (P==1 or P==3)
        or (6<=RK and RK<=18
            or 2<=RK and RK<=5 and Train.KSH1.Value>0
            ) and (P==2 or P==4)
        )
    )
    S["2E"] = S["2G"]*Train.LK4.Value+S["10AV"]
    Train.RV1:TriggerInput("Set",S["2E"]*S["ZR"])
    Train.SR1:TriggerInput("Set",S["2E"]*(1-Train.RRT.Value)*S["ZR"])
    Train.Rper:TriggerInput("Set",T[3]*RCU*C(17<=RK and RK<=18)*S["ZR"])

    --[[ S["1A"] = T[1]*RCU
    S["1R"] = S["1A"]*((1-Train.RV1.Value)*C(P==1)+C(1<=RK and RK<=5 and P==2))
    Train.KSH2:TriggerInput("Set",S["1R"]*S["ZR"]) --Идет обратная цепь от ЛК к 1 проводу, но мне лень
    Train.KSH1:TriggerInput("Set",S["1R"]*S["ZR"]) --Идет обратная цепь от ЛК к 1 проводу, но мне лень
    Train.NR:TriggerInput("Set",1)
    S["1P"] = S["1A"]*C(P == 1 or P == 2)*Train.NR.Value+S["6A"]*C(P==3 or P==4)
    Train["RUTavt"] = S["1P"]*(Train.KSB1.Value+Train.KSH2.Value)*S["ZR"] --Идет обратная цепь от ЛК к 1 проводу, но мне лень
    S["1G"] = S["1P"]*Train.AVT.Value*(1-Train.RPvozvrat.Value)
    S["1Zh"] = S["1G"]*(Train.LK3.Value+C(RK==1)+(Train.KSH2.Value+Train.KSB1.Value*Train.KSB2.Value+C(P==1 or P==3))*Train.LK5.Value)
    Train.LK1:TriggerInput("Set",S["1Zh"]*C(P==1 or P==2)*S["ZR"])
    Train.LK3:TriggerInput("Set",S["1Zh"]*S["ZR"])
    Train.RR:TriggerInput("Set",S["1Zh"]*C(P==1 or P==3)*S["ZR"])--]]
    return S
end

local wires = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,-21,22,23,24,25,27,28,29,30,31,32}

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
    self.ExtraResistanceLK5 = Train.KF_47A["L2-L4"  ]*(1-Train.LK5.Value)
    self.ExtraResistanceLK2 = Train.KF_47A["L12-L13"]*(1-Train.LK2.Value)
    if Train.PositionSwitch.SelectedPosition == 1 then -- PP
        self.R1 = Train.ResistorBlocks.R1C1(Train)
        self.R2 = Train.ResistorBlocks.R2C1(Train)
        self.R3 = 0.0
    elseif Train.PositionSwitch.SelectedPosition == 2 then -- PP
        self.R1 = Train.ResistorBlocks.R1C2(Train)
        self.R2 = Train.ResistorBlocks.R2C2(Train)
        self.R3 = 0.0
    elseif Train.PositionSwitch.SelectedPosition >= 3 then -- PT
        self.R1 = Train.ResistorBlocks.R1C1(Train)
        self.R2 = Train.ResistorBlocks.R2C1(Train)
        self.R3 = Train.ResistorBlocks.R3(Train)
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
    local T13const1 = math.max(16.00,math.min(28.0,(self.R13^2) * 2.0)) -- R * L
    local T24const1 = math.max(16.00,math.min(28.0,(self.R24^2) * 2.0)) -- R * L

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
function TRAIN_SYSTEM:SolveThyristorController(Train, dT,iter)
    -- General state
    local Active = self.ThyristorControllerPower > 0 and self.ThyristorControllerWork > 0 and Train.KSB1.Value>0
    local I = (math.abs(self.I13) + math.abs(self.I24)) / 2

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
        local T = 150.0 + (110.0  - max(0,min(1,(Train.Engines.Speed-60)/15))*40) * Train.RU.Value
        -- Generate control signal
        local rnd = 1--T / 20 --+math.random()*(10)
        local dC = math.min(math.max((T - I), -150), 150)

        if self.PrepareElectric then
            self.ThyristorState = 0.92
            if I > 130 then--I > T * 0.9 then
                self.PrepareElectric = false
                self.ThyristorState = (1 - math.max(0, math.min(1, ((Train.Engines.Speed - 50) / 32)) ^ 0.5)) * 0.9
            end
        else
            self.ThyristorState = math.max(0, math.min(1, self.ThyristorState + dC / rnd * dT))
        end
        -- Generate resistance
        local keypoints = {0.10, 0.008, 0.20, 0.018, 0.30, 0.030, 0.40, 0.047, 0.50, 0.070, 0.60, 0.105, 0.70, 0.165, 0.80, 0.280, 0.90, 0.650, 1.00, 15.00}
        local TargetField = 0.20 + 0.80 * self.ThyristorState
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
        done = --[[ Train.ThyristorBU5_6.Value > 0 or --]] self.PrepareElectric and (CurTime() - self.PrepareElectric) > 0.8 or not self.PrepareElectric and self.ThyristorState >= 1
    end

    -- Allow or deny using manual brakes
    --Train.ThyristorBU5_6:TriggerInput("Set",not self.PrepareElectric and self.ThyristorState > 0.90)
    Train.ThyristorBU5_6:TriggerInput("Set", Active and done)
    -- Set resistance
    self.ThyristorResistance = Resistance + 1e9 * (Active and 0 or 1)
end

function TRAIN_SYSTEM:Think(dT,iter)
    local Train = self.Train
    if not self.ResistorBlocksInit then
        self.ResistorBlocksInit  = true
        self.Train:LoadSystem("ResistorBlocks","Gen_Res_710")
    end
    if iter == 1 then Train.ResistorBlocks.InitializeResistances_81_710(Train) end
    ----------------------------------------------------------------------------
    -- Voltages from the third rail
    ----------------------------------------------------------------------------
    self.Main750V = Train.TR.Main750V
    self.Aux750V  = Train.TR.Main750V*Train.AV.Value*Train.PR5.Value
    self.Power750V = self.Main750V * Train.GV.Value
    self.NR750V    = self.Aux750V


    ----------------------------------------------------------------------------
    -- Solve circuits
    ----------------------------------------------------------------------------
    self:SolvePowerCircuits(Train,dT)
    self:SolveInternalCircuits(Train,dT,iter==1)
    self:SolveThyristorController(Train,dT,iter==1)
end
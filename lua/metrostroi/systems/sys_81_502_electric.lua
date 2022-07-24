--------------------------------------------------------------------------------
-- 81-502 electric schemes
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_502_Electric")
TRAIN_SYSTEM.NVL = 1
TRAIN_SYSTEM.KVL = 2
function TRAIN_SYSTEM:Initialize(typ1,typ2)
    self.Type = self.Type or self.NVL
    -- Load all functions from base
    Metrostroi.BaseSystems["Electric"].Initialize(self)
    for k,v in pairs(Metrostroi.BaseSystems["Electric"]) do
        if not self[k] and type(v) == "function" then
            self[k] = v
        end
    end
    self.SolvePowerCircuits = Metrostroi.BaseSystems["81_703_Electric"].SolvePowerCircuits
    self.SolvePS = Metrostroi.BaseSystems["81_703_Electric"].SolvePS
    self.SolvePP = Metrostroi.BaseSystems["81_703_Electric"].SolvePP
    self.SolvePT = Metrostroi.BaseSystems["81_703_Electric"].SolvePT
end

if CLIENT then return end
function TRAIN_SYSTEM:Inputs(...)
    return { "Type" }
end
function TRAIN_SYSTEM:Outputs(...)
    return Metrostroi.BaseSystems["Electric"].Outputs(self,...)
end
function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "Type" then
        self.Type = value
    end
end

-- Node values
local S = {}
-- Converts boolean expression to a number
local function C(x) return x and 1 or 0 end
local min = math.min
local max = math.max
function TRAIN_SYSTEM:SolveAllInternalCircuits(Train, dT)
    ---[[
    local RheostatController = Train.RheostatController
    local P = Train.PositionSwitch.SelectedPosition
    local RK = RheostatController.SelectedPosition
    local B = (Train.Battery.Voltage > 55) and 1 or 0
    local T = Train.SolverTemporaryVariables

    local elType = self.Type
    local KVL = elType == 2

    local BO = min(1,B * Train.VB.Value+T[10])
    local KV = Train.KV
    local Panel = Train.Panel
    local ARS = KVL and Train.KSAUP or Train.MARS
    local BPS = Train.BPS
    Panel.V1 = BO

    Train:WriteTrainWire(10,B*Train.VB.Value)
    S["10AK"] = BO*Train.VU.Value

    S["U2"] = S["10AK"]*KV["U2-10AK"]

    Panel.S4 = T[4]
    Panel.S5 = T[5]
    Panel.S20 = T[20]
    Panel.S6 = T[6]
    Panel.S1 = T[1]
    Panel.S1P = T[44]
    Panel.S3 = T[3]
    Panel.S2 = T[2]
    Panel.SSN = --[[ S["U2"]--]] T[20]*T[18] --FIXME
    Panel.SDT = T[34]

    Panel.L16 = T[16]
    Panel.LRU = T[9]

    if KVL then
        local RCAV3 = Train.RCAV3.Value
        local RCAV4 = Train.RCAV4.Value
        local RCAV5 = Train.RCAV5.Value
        S[8] = BO*(KV["10-8"]+KV["10-8a"]*Train.OVT.Value*(1-Train.RPB.Value))
        Train:WriteTrainWire(8,S[8]+ARS[8]*RCAV4)
        ARS["8"] = S[8]*RCAV4
        S["8a"] = ARS["8a"]*RCAV3+BO*KV["10-8a"]*(1-RCAV3)
        Train.RPB:TriggerInput("Set", S["8a"]*Train.PB.Value)
        ARS["I8"] = S["8a"]*KV["8-8a"] --FIXME
        Train:WriteTrainWire(4,S["10AK"]*KV["10AK-4"])


        S[5] = S["10AK"]*KV["10AK-5"]
        S["9a"] = BO*KV["F-F7"]*Train.VRU.Value+(S[5])*Train.RO2.Value
        S[30] = S["9a"]*Train.RO2.Value
        Train:WriteTrainWire(9,S["9a"]*Train.VAK.Value)
        Train:WriteTrainWire(5,S[5]+S[30])
        Train:WriteTrainWire(30,S[5]+S[30])
        ARS.VRD = S["10AK"]*KV["10AK-VRD"]*Train.VRD.Value
        Panel.RD = ARS.RD

        S[17] = S["10AK"]*Train.VozvratRP.Value
        S[2] = S["U2"]*KV["U2-2a"]
        S[20] = S["U2"]*KV["U2-20"]
        S[25] = S["U2"]*KV["U2-25"]
        S[3] = S["U2"]*KV["U2-3"]
        --print(self.Train,1,(ARS[1]))
        Train:WriteTrainWire(1,S["10AK"]*KV["1-10AK"]*Train.RV2.Value+(BO*Train.RO1.Value))
        Train:WriteTrainWire(17,(ARS[17]*RCAV5+S[17]*(1-RCAV5))) --FIXME AV
        Train:WriteTrainWire(6,S["10AK"]*Train.RVT.Value) --FIXME AV
        Train:WriteTrainWire(2,S["U2"]*KV["U2-2"]+(ARS[2]*RCAV4+S[2]*(1-RCAV4))+(BO*Train.RO1.Value)) --FIXME AV
        Train:WriteTrainWire(20,(ARS[20]*RCAV4+S[20]*(1-RCAV4))+(BO*Train.RO2.Value)) --FIXME AV
        Train:WriteTrainWire(25,(ARS[25]*RCAV5+S[25]*(1-RCAV5))) --FIXME AV
        Train:WriteTrainWire(3,S[3]+ARS[3]+(BO*Train.RO2.Value)) --FIXME AV

        S[1] =(T[-15]*T[15]+S["10AK"]*Train.KAD.Value)*KV["33-10AK"]
        S[6] = S["U2"]*KV["U2-RVT"]
        Train.RVT:TriggerInput("Set",S[6]+ARS[6]*RCAV5) --FIXME AV
        Train.RV2:TriggerInput("Set",(ARS[1]*RCAV5+S[1]*(1-RCAV5))*KV["33-10AK"]*(Train.AVU.Value+Train.KPVU.Value)*(1-Train.RVT.Value)*Train.UAVAC.Value*(Train.RPB.Value+Train.KAH.Value)) --FIXME AV

        ARS["1"] = S[1]*RCAV5
        ARS["17"] = S[17]*RCAV5
        ARS["6"] = S[6]*RCAV5
        ARS["2"] = S[2]*RCAV4
        ARS["20"] = S[20]*RCAV4
        ARS["25"] = S[25]*RCAV5
        ARS["3"] = S[3]*RCAV5

        S["DA"] = S["10AK"]*KV["10AK-DA"]
        ARS.Power = BO*Train.VBA.Value*RCAV3
        ARS.KZP = S["DA"]*Train.VZP.Value*RCAV5
        ARS.KDZ = S["DA"]*Train.VDZ.Value*RCAV5
        ARS.KRR = S["DA"]*RCAV3
        ARS.KOS = S["DA"]*Train.KOS.Value
        ARS.KRR2 = (T[4]+T[5])*RCAV3
        ARS.KGR = S["U2"]*KV["U2-FA"]*RCAV4

        Panel.LMK = T[23]
    else
        S["DA"] = BO*KV["10AK-DA"]
        local RCARS = Train.RCARS.Value
        local RCBPS = Train.RCBPS.Value
        Train:WriteTrainWire(8,BO*(KV["10-8"]+KV["10-8a"]*Train.OVT.Value*(1-Train.RPB.Value))+BPS[8]*RCBPS+ARS[8]*RCARS)
        --S["8a"] =
        Train.RPB:TriggerInput("Set", BO*KV["10-8a"]*Train.PB.Value+S["DA"]*Train.ARS.Value*RCARS)
        Train:WriteTrainWire(4,S["10AK"]*KV["10AK-4"])
        --Train:WriteTrainWire(5,S["10AK"]*(KV["10AK-5"]*Train.UAVAC.Value+KV["5-5a"]))
        S[5] = S["10AK"]*(KV["10AK-5"]*(Train.UAVAC.Value+KV["5-5a"]))
        S["9a"] = BO*KV["F-F7"]*Train.VRU.Value+(S[5])*Train.RO2.Value
        S[30] = S["9a"]*Train.RO2.Value
        Train:WriteTrainWire(9,S["9a"]*Train.VAK.Value)
        Train:WriteTrainWire(5,S[5]+S[30])
        Train:WriteTrainWire(30,S[5]+S[30])

        S[17] = S["10AK"]*Train.VozvratRP.Value
        S[2] = S["U2"]*KV["U2-2a"]
        S[20] = S["U2"]*KV["U2-20"]
        S[25] = S["U2"]*KV["U2-25"]
        S[3] = S["U2"]*KV["U2-3"]
        Train:WriteTrainWire(1,S["10AK"]*KV["1-10AK"]*Train.RV2.Value+(BO*Train.RO1.Value))
        Train:WriteTrainWire(6,S["10AK"]*Train.RVT.Value) --FIXME AV
        Train:WriteTrainWire(17,S[17])
        Train:WriteTrainWire(2,S["U2"]*KV["U2-2"]+(ARS[2]*RCARS+S[2]*(1-RCARS))+(BO*Train.RO1.Value)) --FIXME AV
        Train:WriteTrainWire(20,(ARS[20]*RCARS+S[20]*(1-RCARS))+(BO*Train.RO2.Value)) --FIXME AV
        Train:WriteTrainWire(25,(ARS[25]*RCARS+S[25]*(1-RCARS))) --FIXME AV
        Train:WriteTrainWire(3,S[3]+ARS[3]+(BO*Train.RO2.Value)) --FIXME AV

        S[1] =S["10AK"]*KV["33-10AK"]
        S[6] = S["U2"]*KV["U2-RVT"]
        Train.RVT:TriggerInput("Set",S[6]+ARS[6]*RCARS) --FIXME AV
        Train.RV2:TriggerInput("Set",(ARS[1]*RCARS+S[1]*(1-RCARS))*(Train.KD.Value+Train.KAD.Value)*(Train.RPB.Value+Train.KAH.Value)*(Train.AVU.Value+Train.KPVU.Value)*(1-Train.RVT.Value)) --FIXME AV

        ARS["1"] = S[1]
        ARS["17"] = S[17]
        ARS["6R"] = S[6]
        ARS["6"] = T[6]
        ARS["2"] = S[2]
        ARS["20"] = S[20]
        ARS["25"] = S[25]
        ARS["3"] = S[3]

        ARS.Power = S["DA"]*Train.ARS.Value
        ARS.ALS = S["DA"]*Train.ALS.Value
        ARS.ALSPower = Train.ALS.Value
        Train:WriteTrainWire(44,ARS[44]*RCARS)

        BPS.Power = S["DA"]
        BPS.KRR = T[4]
        BPS.KRH = S[1]
        Train:WriteTrainWire(39,BPS[39]*RCBPS)

        Panel.LMK = T[22]
        Panel.NMLow = BO*C(Train.Pneumatic.TrainLinePressure < 5.8 or Train.Pneumatic.TrainLinePressure > 8.3)
        Panel.UAVATriggered = BO*(1-Train.UAVAC.Value+Train.PneumaticNo1.Value*C(Train.Pneumatic.BrakeCylinderPressure < 0.6))
    end
    Panel.UPOPower = BO*KV["10AK-DA"]
    Train:WriteTrainWire(13,Panel.UPOPower*Train.R_UPO.Value--[[*KV["UPO-13"]]*Train.UPO.LineOut)
    Train:WriteTrainWire(29,0)

    local RUM = KV.RCU


    local Reverser = Train.Reverser
    S["4A"] = T[4]+T[29]-10*Train.RO2.Value*KV["0-4"]
    S["5A"] = T[5]+T[30]

    Reverser:TriggerInput("NZ",min(1,S["4A"]*Reverser.VP))
    Reverser:TriggerInput("VP",min(1,S["5A"]*Reverser.NZ))
    Train.LK4:TriggerInput("Set",(S["4A"]*Reverser.NZ+S["5A"]*Reverser.VP)*(1-Train.RPvozvrat.Value)*Train.LK3.Value)

    S["2A"] = (T[2]+BO*Train.RO1.Value)*RUM
    Train.PneumaticNo2:TriggerInput("Set",T[8]*(1-Train.LK4.Value)+T[39])

    if KVL then
        S["48A"] = C(P==4 and 1 <= RK and RK <= 5)
        Train:WriteTrainWire(48,S["48A"])
        Train.PneumaticNo1:TriggerInput("Set",(S["2A"]*Train.PR.Value)*(T[48]*RUM+S["48A"]))
    else
        S["48A"] = C(P==4 and 1 <= RK and RK <= 5)+ARS[48]*Train.RCARS.Value
        Train:WriteTrainWire(48,S["48A"])
        Train.PneumaticNo1:TriggerInput("Set",(S["2A"]*Train.PR.Value+T[44])*(T[48]*RUM+S["48A"]))
    end

    Train.RZ_2:TriggerInput("Set",T[24]*RUM*(1-Train.LK4.Value)) --FIXME RDR
    S["18A"] = RUM*(Train.RPvozvrat.Value*100+(1-Train.LK4.Value)) --FIXME RDR
    Train:WriteTrainWire(18,S["18A"])
    Panel.TW18 = S["18A"]

    S["10A"] = BO*RUM
    --РУТ
    --СДРК
    S["25B"] = Train.LK2.Value*(1-Train.TSH.Value)
    S["25A"] = Train.KSH2.Value
    Train["RUTreg"] = S["10A"]*(S["25B"]-S["25A"])
    S["10I"] = S["10A"]*RheostatController.RKM2
    Train["RUTpod"] = S["10I"]*Train.LK4.Value

    S["25A"] = T[25]*RUM
    Train["RRTpod"] = S["25A"]*min(1,Train["RRTpod"]+S["10I"])
    Train.RRT:TriggerInput("Set",S["25A"]*Train["RRTpod"])

    S["DT"] = BO*Train.BPT.Value
    Panel.BrY = S["DT"]
    Train:WriteTrainWire(34,S["DT"])

    if KVL then
        ARS.DT = S["DT"]
        S["10B"] = S["10A"]*(Train.RV1.Value+Train.TSH.Value*(1-Train.KSH3.Value))
    else
        S["10B"] = S["10A"]*(Train.RV1.Value+Train.TSH.Value)
    end
    RheostatController:TriggerInput("MotorCoilState",min(1,S["10A"]*(S["10B"]*Train.RR.Value - S["10B"]*(1-Train.RR.Value))))

    S["10N"] = S["10A"]*(RheostatController.RKM1+Train.SR1.Value*(1-Train.RUT.Value))
    S["10T"] = --[[ S["10N"]*--]] ((1-Train.SR1.Value)+Train.RUT.Value)*RheostatController.RKP
    RheostatController:TriggerInput("MotorState",S["10N"]+S["10T"]*(-10))
    --СДПП
    S["10E"] = S["10A"]*((1-Train.LK3.Value)+Train.Rper.Value)
    Train.SR2:TriggerInput("Set",S["10E"]*((C(P==3 or P==4)+Train.KSH2.Value*Train.LK5.Value))*(1-Train.LK4.Value))

    S["10AD"] = (1-Train.LK1.Value)*Train.SR2.Value

    S["10AZh"] = S["10AD"]*Train.TSH.Value*C(P==1 or P==2 or P==4)
    S["10AR"] = S["10AD"]*(1-Train.KSH3.Value)*(1-Train.TSH.Value)*C(2<=P and P<=4)
    S["10Ya"] = Train.LK3.Value*C(RK==18 and (P==1 or P==3))

    S["10AG"] = S["10E"]*(S["10AR"]+S["10AZh"]+S["10Ya"])
    Train.PositionSwitch:TriggerInput("MotorState",-1.0 + 2.0*math.max(0,S["10AG"]))

    if false and KVL then
        S["2G"] = S["2A"]*(C(P==1 or P==3)*C(1<=RK and RK<=17)+C(P==2 or P==4)*(C(5<=RK and RK<=18)+C(2<=RK and RK<=4 and P==4))) --ВТФ КВЛ, почему нету ОП
    else
        S["2G"] = S["2A"]*(C(P==1 or P==3)*C(1<=RK and RK<=17)+C(P==2 or P==4)*(C(5<=RK and RK<=18)+C(2<=RK and RK<=4 and P==4)+Train.KSH1.Value*C(2<=RK and RK<=5 and P==2))) --ВТФ КВЛ, почему нету ОП
    end
    --S["2G"] = S["2A"]*(C(P==1 or P==3)*C(1<=RK and RK<=17)+C((P==2 or P==4) and 2 <= RK and RK <= 18))
    S["10AV"] = S["10A"]*(1-Train.LK3.Value)*C(2<=RK and RK<=18)*(1-Train.LK4.Value)
    S["2E"] = S["2G"]*(1-Train.SR2.Value)*Train.LK4.Value+S["10AV"]

    Train.RV1:TriggerInput("Set",S["2E"])
    Train.SR1:TriggerInput("Set",S["2E"]*(1-Train.RRT.Value))

    Train.Rper:TriggerInput("Set",(T[3]+BO*Train.RO2.Value)*RUM*C(17<=RK and RK<=18))

    S["1P"] = (T[1]+BO*Train.RO1.Value)*RUM*C(P == 1 or P == 2)*Train.NR.Value
    S["6A"] = T[6]*RUM--+S["1P"]*C(P==3 or P==4)
    S["1G"] = (S["1P"]+S["6A"]*C(P==3 or P==4))*Train.AVT.Value*(1-Train.RPvozvrat.Value)
    S["1Zh"] = S["1G"]*(Train.LK3.Value+Train.KSH2.Value*C(RK==1 and (P==1 or P==3)))
    Train.LK3:TriggerInput("Set",S["1Zh"])
    Train.LK1:TriggerInput("Set",S["1Zh"]*C(P==1 or P==2))
    Train.RR:TriggerInput("Set",S["1Zh"]*C(P==1 or P==3))

    Train.TSH:TriggerInput("Set",S["6A"]*Train.LK5.Value)
    Train.PR:TriggerInput("Set",S["6A"])
    Train["RUTavt"] = S["6A"]*(1-Train.KSH2.Value)

    S["6K"] = S["6A"]*C(RK==1)*(1-Train.LK1.Value)
    Train.KSH3:TriggerInput("Set",S["6K"])
    Train.KSH4:TriggerInput("Set",S["6K"])

    S["20A"] = (T[20]+BO*Train.RO2.Value)*RUM
    Train.LK2:TriggerInput("Set",S["20A"]*Train.LK1.Value*(1-Train.RPvozvrat.Value))
    Train.LK5:TriggerInput("Set",S["20A"]*(1-Train.RPvozvrat.Value))

    Train.RPvozvrat:TriggerInput("Open",T[17]*RUM) --FIXME Mayve more right RP code

    Train.RO1:TriggerInput("Set",T[9])
    Train.RO2:TriggerInput("Set",T[9]*Train.RO1.Value)
    S["20G"] = C(1<=RK and RK<=5 and (P==2 or P==3))
    S["20V"] = C((RK==1 or RK==18) and P==1)+S["20G"]*Train.KSH1.Value
    S["20D"] = S["10A"]*(S["20G"]+S["20V"]*(1-Train.Rper.Value))*(Train.LK5.Value+Train.LK4.Value)
    Train.KSH2:TriggerInput("Set",S["20D"])
    Train.KSH1:TriggerInput("Set",S["20D"])--+S["20V"]*(1-Train.Rper.Value))

    --Вспом цепи низкого напряжения
    Train:WriteTrainWire(11,BO*Train.VU2.Value)
    Train:WriteTrainWire(23,BO*Train.VMK.Value)
    Train:WriteTrainWire(22,T[23]*Train.AK.Value)

    Train:WriteTrainWire(27,BO*Train.LOn.Value)
    Train:WriteTrainWire(28,BO*Train.LOff.Value)

    S["F7"] = BO*KV["F-F7"]
    if KVL then
        Panel.Headlights1 = S["F7"]
        Panel.Headlights2 = S["F7"]*Train.VUS.Value
    else
        Panel.Headlights1 = S["F7"]*Train.Headlights.Value
        Panel.Headlights2 = S["F7"]*Train.VUS.Value
    end

    S["F1"] = (B*Train.VKF.Value+BO*(1-Train.VKF.Value))*KV["B2-F1"]
    if KVL then
        ARS.F1 = S["F1"]
        Train:WriteTrainWire(42,BO*Train.Ring.Value+T[11]*Train.BD2.Value+ARS.Ring)
        Train:WriteTrainWire(44,S["F1"]*C(RK==1 and P==4))
        Train:WriteTrainWire(46,S["F1"]*C(1<=RK and RK<=17 and P==3)) --FIXME RCA
        ARS[44] = T[44]
        ARS[46] = T[46]
        --print(S["F1"]*C(RK==1 and P==4))
        Panel.RedLights = S["F1"]+T[44]
    else
        Train:WriteTrainWire(42,S["F1"]*Train.Ring.Value+T[11]*Train.BD2.Value+ARS.Ring*Train.RCARS.Value)
        Panel.RedLights = S["F1"]
    end

    S["D1"] = BO*KV["D-D1"]
    if KVL then
        S[31] = S["D1"]*(Train.KDL.Value)
        S[32] = S["D1"]*(Train.KDP.Value)
        local RCA = Train.RCAV3.Value
        Train:WriteTrainWire(31,S["D1"]*(Train.VDL.Value+Train.KRZD.Value)+(ARS[31]*RCA+S[31]*(1-RCA))) --FIXME AV
        Train:WriteTrainWire(32,S["D1"]*(Train.KRZD.Value)+(ARS[32]*RCA+S[32]*(1-RCA))) --FIXME AV
        Train:WriteTrainWire(16,S["D1"]*Train.VUD.Value+ARS[16]) --FIXME AV
        Train:WriteTrainWire(45,S["D1"]*Train.KDPH.Value)
        ARS["31"] = S[31]
        ARS["32"] = S[32]
        ARS["16"] = T[16]
    else
        S[31] = S["D1"]*(Train.KDL.Value)
        S[32] = S["D1"]*(Train.KDP.Value)
        Train:WriteTrainWire(31,S["D1"]*(Train.KDL.Value+Train.VDL.Value+Train.KRZD.Value))
        Train:WriteTrainWire(32,S["D1"]*(Train.KDP.Value+Train.KRZD.Value))
        Train:WriteTrainWire(16,S["D1"]*Train.VUD.Value) --FIXME AV
        Train:WriteTrainWire(45,S["D1"]*Train.KDPH.Value)
    end
    Panel.AnnouncerPlaying = T[13]
    Train:WriteTrainWire(24,T[20]*Train.KSN.Value)
    if KVL then
        Train:WriteTrainWire(19,BO*KV["D4-19"]*Train.RD.Value)
        S[15] = T[19]*Train.RD.Value*KV["D4-15"]
        Train:WriteTrainWire(-15,S[15])
        Train:WriteTrainWire(15,Train.RD.Value)
    else
        Train:WriteTrainWire(19,T[16]*KV["D4-19"]*Train.RD.Value)
        S[15] = T[19]*Train.RD.Value*KV["D4-15"]
        Train:WriteTrainWire(-15,S[15])
        Train:WriteTrainWire(15,Train.RD.Value)
    end
    Panel.SSD = (S[15]+T[-15]*T[15])
    Train.KD:TriggerInput("Set",Panel.SSD)

    S["11A"] = T[11]*(1-Train.NR.Value)
    Panel.EmergencyLights1 = BO*Train.VU3.Value+S["11A"]*(1-Train.VU3.Value)
    Panel.EmergencyLights2 = S["11A"]
    --Panel.Ring = S["11A"]*T[42]
    Panel.MainLights1 = math.max(0,math.min(1,
        (
            self.Aux750V-100
            -self.Itotal*0.25*C(Train.PositionSwitch.SelectedPosition >= 3)
            -25*Train.KK.Value
        )/750*(0.5+0.5*B*Train.VB.Value*Train.KZ1.Value)
    ))
    Panel.MainLights2 = Panel.MainLights1*Train.KO.Value
    Train.Battery:TriggerInput("Charge", Train.VB.Value*Panel.MainLights1)
    
    Panel.VPR = B*(1-Train.VR.Value)+T[10]*Train.VR.Value

    Panel.Ring = T[42]
    Train.KK:TriggerInput("Set",T[22]*(1-Train.TRK.Value))
    Train.KO:TriggerInput("Close",T[27])
    Train.KO:TriggerInput("Open",T[28])

    Train.RD:TriggerInput("Set",BO*Train.BD.Value)
    if KVL then
        Panel.DoorsWC = BO*(1-Train.RD.Value)*Train.KSD.Value
        Panel.DoorsW = BO*(1-Train.RD.Value)
    else
        Panel.DoorsWC = BO*(1-Train.RD.Value)*Train.KSD.Value
        Panel.DoorsW = BO*(1-Train.RD.Value)
    end
    Panel.GreenRP = BO*Train.RPvozvrat.Value
    --Panel.SSD = (S["D1"]+T[10]*Train.KU11.Value)*(T[15]*(1-Train.KU11.Value)+BD)
    Train.VDZ:TriggerInput("Set",T[16]*(1-Train.RD.Value))
    Train.VDOL:TriggerInput("Set",T[31])
    Train.VDOP:TriggerInput("Set",(T[32]+T[45]))
    --Схема подзаряда
    Train:WriteTrainWire(40,BO*Train.VSOSD.Value)
    Train:WriteTrainWire(12,T[40]*(1-Train.VSOSD.Value))
    Panel.SOSD = T[12]*(1-Train.KD.Value)
    Train.Scheme = S
    return S
end

function TRAIN_SYSTEM:SolveRKInternalCircuits(Train, dT)
    ---[[
    local RheostatController = Train.RheostatController
    local P = Train.PositionSwitch.SelectedPosition
    local RK = RheostatController.SelectedPosition
    local B = (Train.Battery.Voltage > 55) and 1 or 0
    local T = Train.SolverTemporaryVariables

    local elType = self.Type
    local KVL = elType == 2

    local BO = min(1,B * Train.VB.Value+T[10])
    local RUM = Train.KV.RCU


    S["10A"] = BO*RUM
    S["25B"] = Train.LK2.Value*(1-Train.TSH.Value)
    S["25A"] = Train.KSH2.Value
    Train["RUTreg"] = S["10A"]*(S["25B"]-S["25A"])
    S["10I"] = S["10A"]*RheostatController.RKM2
    Train["RUTpod"] = S["10I"]*Train.LK4.Value

    S["25A"] = T[25]*RUM
    Train["RRTpod"] = S["25A"]*min(1,Train["RRTpod"]+S["10I"])
    Train.RRT:TriggerInput("Set",S["25A"]*Train["RRTpod"])

    if KVL then
        S["10B"] = S["10A"]*(Train.RV1.Value+Train.TSH.Value*(1-Train.KSH3.Value))
    else
        S["10B"] = S["10A"]*(Train.RV1.Value+Train.TSH.Value)
    end
    RheostatController:TriggerInput("MotorCoilState",min(1,S["10A"]*(S["10B"]*Train.RR.Value - S["10B"]*(1-Train.RR.Value))))

    S["10N"] = S["10A"]*(RheostatController.RKM1+Train.SR1.Value*(1-Train.RUT.Value))
    S["10T"] = --[[ S["10N"]*--]] ((1-Train.SR1.Value)+Train.RUT.Value)*RheostatController.RKP
    RheostatController:TriggerInput("MotorState",S["10N"]+S["10T"]*(-10))
    --СДПП
    S["10E"] = S["10A"]*((1-Train.LK3.Value)+Train.Rper.Value)
    Train.SR2:TriggerInput("Set",S["10E"]*((C(P==3 or P==4)+Train.KSH2.Value*Train.LK5.Value))*(1-Train.LK4.Value))

    S["10AD"] = (1-Train.LK1.Value)*Train.SR2.Value

    S["10AZh"] = S["10AD"]*Train.TSH.Value*C(P==1 or P==2 or P==4)
    S["10AR"] = S["10AD"]*(1-Train.KSH3.Value)*(1-Train.TSH.Value)*C(2<=P and P<=4)
    S["10Ya"] = Train.LK3.Value*C(RK==18 and (P==1 or P==3))

    S["10AG"] = S["10E"]*(S["10AR"]+S["10AZh"]+S["10Ya"])
    Train.PositionSwitch:TriggerInput("MotorState",-1.0 + 2.0*math.max(0,S["10AG"]))

    S["2A"] = (T[2]+BO*Train.RO1.Value)*RUM
    if false and KVL then
        S["2G"] = S["2A"]*(C(P==1 or P==3)*C(1<=RK and RK<=17)+C(P==2 or P==4)*(C(5<=RK and RK<=18)+C(2<=RK and RK<=4 and P==4))) --ВТФ КВЛ, почему нету ОП
    else
        S["2G"] = S["2A"]*(C(P==1 or P==3)*C(1<=RK and RK<=17)+C(P==2 or P==4)*(C(5<=RK and RK<=18)+C(2<=RK and RK<=4 and P==4)+Train.KSH1.Value*C(2<=RK and RK<=5 and P==2))) --ВТФ КВЛ, почему нету ОП
    end
    --S["2G"] = S["2A"]*(C(P==1 or P==3)*C(1<=RK and RK<=17)+C((P==2 or P==4) and 2 <= RK and RK <= 18))
    S["10AV"] = S["10A"]*(1-Train.LK3.Value)*C(2<=RK and RK<=18)*(1-Train.LK4.Value)
    S["2E"] = S["2G"]*(1-Train.SR2.Value)*Train.LK4.Value+S["10AV"]

    Train.RV1:TriggerInput("Set",S["2E"])
    Train.SR1:TriggerInput("Set",S["2E"]*(1-Train.RRT.Value))

    Train.Rper:TriggerInput("Set",(T[3]+BO*Train.RO2.Value)*RUM*C(17<=RK and RK<=18))

    S["1P"] = (T[1]+BO*Train.RO1.Value)*RUM*C(P == 1 or P == 2)*Train.NR.Value
    S["6A"] = T[6]*RUM--+S["1P"]*C(P==3 or P==4)
    S["1G"] = (S["1P"]+S["6A"]*C(P==3 or P==4))*Train.AVT.Value*(1-Train.RPvozvrat.Value)
    S["1Zh"] = S["1G"]*(Train.LK3.Value+Train.KSH2.Value*C(RK==1 and (P==1 or P==3)))
    Train.RR:TriggerInput("Set",S["1Zh"]*C(P==1 or P==3))

    return S
end
local wires = {1,2,3,4,5,6,8,9,10,11,12,13,-15,15,16,17,18,19,20,22,23,24,25,27,28,29,30,31,32,34,39,40,42,44,45,46,48,}
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
--[[
--------------------------------------------------------------------------------
function TRAIN_SYSTEM:SolvePowerCircuits(Train,dT,iter)
    self.ExtraResistanceLK5 = Train.KF_47A["L4-L5"]*(1-Train.LK5.Value)
    self.ExtraResistanceLK2 = Train.KF_47A["L1-L2"]*(1-Train.LK2.Value)
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
    self.Rs1 = Train.ResistorBlocks.S1(Train) + 1e9*(1 - Train.KSH1.Value)
    self.Rs2 = Train.ResistorBlocks.S2(Train) + 1e9*(1 - Train.KSH2.Value)

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
        self:SolvePP(Train)
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
        self.Magnetization = 0
    elseif Train.PositionSwitch.SelectedPosition == 2 then -- PS
        self.I13 = self.I13 * Train.LK3.Value * Train.LK4.Value * Train.LK1.Value
        self.I24 = self.I24 * Train.LK3.Value * Train.LK4.Value * Train.LK1.Value

        self.Itotal = self.I13 + self.I24
        self.Magnetization = 0
    else -- PT
        self.I13 = self.I13 * Train.LK3.Value*Train.LK4.Value
        self.I24 = self.I24 * Train.LK4.Value*Train.LK3.Value

        self.Itotal = self.I13 + self.I24
        self.Magnetization = self.Main750V*Train.TSH.Value/8*Train.AV.Value
    end

    -- Calculate extra information
    self.Uanchor13 = self.I13 * self.Ranchor13
    self.Uanchor24 = self.I24 * self.Ranchor24


    ----------------------------------------------------------------------------
    -- Calculate current through stator and shunt
    self.Ustator13 = self.I13 * self.Rstator13
    self.Ustator24 = self.I24 * self.Rstator24
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
--]]
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
    	self.Train.YAR_13A.NoRRT = true
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
    self:SolvePowerCircuits(Train,dT,iter==1)
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
--[[
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

function TRAIN_SYSTEM:SolvePP(Train)
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
    local R1 = self.Ranchor13 + self.Rstator13 + self.ExtraResistanceLK5
    local R2 = self.Ranchor24 + self.Rstator24 + self.ExtraResistanceLK5
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
--]]
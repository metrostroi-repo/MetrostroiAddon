--------------------------------------------------------------------------------
-- 81-508t electric schemes
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_508T_Electric")
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
    self.SolvePowerCircuits = Metrostroi.BaseSystems["81_710_Electric"].SolvePowerCircuits
    self.SolveThyristorController = Metrostroi.BaseSystems["81_710_Electric"].SolveThyristorController
    self.Think = Metrostroi.BaseSystems["81_710_Electric"].Think
end

if CLIENT then return end
function TRAIN_SYSTEM:Inputs(...)
    return { "Type", "RRI" }
end
function TRAIN_SYSTEM:Outputs(...)
    return Metrostroi.BaseSystems["Electric"].Outputs(self,...)
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
    if not T then
        T = {}
        for i=1,100 do T[i] = 0 end
        Train.SolverTemporaryVariables = T
    end

    local BO = min(1,B * Train.VB.Value+T[10])--B * Train.VB.Value
    local KV = Train.KV
    local KRU = Train.KRU
    local Panel = Train.Panel
    local BC = (Panel.MainLights1+Panel.MainLights2)


    Panel.V1 = BO
    Train:WriteTrainWire(10,B*Train.VB.Value)

    S["10AK"] = BO*Train.PRL24.Value*Train.VU.Value
    --10AK->AV --FIXME SAMM
    S["U2"] = S["10AK"]*KV["U2-10AK"]
    S["7G"] = BO*KV["7D-7G"]
    Train:WriteTrainWire(1,S["10AK"]*KV["10AK-1"]*Train.R1_5.Value)
    Train:WriteTrainWire(2,S["U2"]*KV["U2-2"])
    Train:WriteTrainWire(3,S["U2"]*KV["U2-3"])
    Train:WriteTrainWire(4,S["10AK"]*KV["U2-4"])
    Train:WriteTrainWire(5,S["10AK"]*KV["U2-5"])
    Train:WriteTrainWire(6,S["10AK"]*Train.RVT.Value)
    Train:WriteTrainWire(7,BO*Train.Ring.Value)
    Train:WriteTrainWire(8,BO*KV["10-8"])
    --Train:WriteTrainWire(14,BO*KV["10-14A"]*KV["14A-14B"])
    Train:WriteTrainWire(17,S["10AK"]*KV["10AK-17"]*Train.KU9.Value)
    Train:WriteTrainWire(20,S["U2"]*KV["U2-20"])
    Train:WriteTrainWire(24,S["U2"]*Train.KU8.Value)
    Train:WriteTrainWire(25,S["U2"]*KV["U2-6"]*KV["6-25"]*Train.K25.Value)

    Train.RVT:TriggerInput("Set",S["U2"]*KV["U2-6"])
    Train.K25:TriggerInput("Set",S["U2"]*KV["U2-6"])
    Train.RV2:TriggerInput("Set",S["10AK"]*KV["33-10AK"])
    Train.R1_5:TriggerInput("Set",S["10AK"]*Train.RV2.Value)
    Panel.AnnouncerPlaying = T[13]

    Train:WriteTrainWire(21,Train.RKTT.Value+Train.DKPT.Value)
    Panel.RRP = S["U2"]*T[18]

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
    Train["RUTpod"] = S["10I"]*Train.LK4.Value
    Train["RRTpod"] = S["10I"]*(1-Train.LK1.Value)
    Train.RRT:TriggerInput("Close",Train.RRTuderzh*Train.RRTpod)
    Train.RRT:TriggerInput("Open",(1-Train.RRTuderzh))

    local SDRKr = 1-Train.LK2.Value*(0.2+0.3*C(2 <=RK and RK <= 7 and P==1))
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
    --print(S["6Yu"])
    Train.KSB1:TriggerInput("Set",S["6Yu"])
    Train.KSB2:TriggerInput("Set",S["6Yu"])
    Train.RUP:TriggerInput("Set",S["6Yu"])
    self.ThyristorControllerWork = S["6Yu"]+S["6G"]*Train.RUP.Value

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
    Train:WriteTrainWire(11,BO*Train.VU2.Value*Train.PRL25.Value)
    Train:WriteTrainWire(22,BO*Train.PRL20.Value*Train.V1.Value*Train.AK.Value)
    Train:WriteTrainWire(23,BO*Train.KU15.Value)
    Train:WriteTrainWire(27,BO*Train.PRL21.Value*Train.V4.Value)
    Train:WriteTrainWire(28,BO*Train.PRL21.Value*Train.V5.Value)
    Panel.GRP = BO*Train.PRL21.Value*Train.RPvozvrat.Value
    S["F7"] = BO*Train.PRL15.Value*KV["F-F7"]
    Panel.Headlights1 = S["F7"]
    Panel.Headlights2 = S["F7"]*Train.VU14.Value
    Panel.RedLight1 = BO*Train.PRL26.Value*KV["B2-F1"]
    Panel.RedLight2 = BO*Train.PRL12.Value*KV["B2-F1"]
    S["D1"] = BO*Train.PRL22.Value*KV["D-D1"]
    Train:WriteTrainWire(31,S["D1"]*(Train.V6.Value+Train.KU12.Value))
    Train:WriteTrainWire(32,S["D1"]*Train.KU7.Value)
    Train:WriteTrainWire(12,S["D1"]*Train.V10.Value)
    Train:WriteTrainWire(16,S["D1"]*Train.V2.Value*Train.V3.Value)
    Train.RPU:TriggerInput("Set",T[27])
    S["11A"] = T[11]*(1-Train.NR.Value)
    Panel.EmergencyLights1 = (BO*Train.PRL21.Value*Train.VU3.Value)+(S["11A"]*(1-Train.VU3.Value))
    Panel.EmergencyLights2 = Train.PRL13.Value*S["11A"]
    Panel.Ring = (S["11A"]+T[7])*Train.PRL34.Value
    Panel.MainLights1 = math.max(0,math.min(1,(self.Aux750V*Train.PR4.Value*Train.PR9.Value-100-self.Itotal*0.25*C(Train.PositionSwitch.SelectedPosition >= 3)-25*Train.KK.Value)/750*(0.5+0.5*B*Train.VB.Value*Train.PR6.Value)))
    Panel.MainLights2 = math.max(0,math.min(1,(self.Aux750V*Train.PR4.Value*Train.KO.Value*Train.PR8.Value-100-self.Itotal*0.25*C(Train.PositionSwitch.SelectedPosition >= 3)-25*Train.KK.Value)/750*(0.5+0.5*B*Train.VB.Value*Train.PR6.Value)))
    Panel.LightPower = math.max(0,math.min(1,(self.Aux750V-100-self.Itotal*0.25*C(Train.PositionSwitch.SelectedPosition >= 3)-25*Train.KK.Value)/750*(0.5+0.5*B*Train.VB.Value*Train.PR6.Value)))
    Train.Battery:TriggerInput("Charge", Train.PR1.Value*BC*Train.PR6.Value)
    Train.KK:TriggerInput("Set",(T[22]*Train.PRL14.Value)+(T[23]*Train.PRL31.Value))
    Train.KO:TriggerInput("Close",T[27])
    Train.KO:TriggerInput("Open",T[28])

    local BD = 1-Train.BD.Value
    Train:WriteTrainWire(15,BD*(1-Train.KU11.Value))--Заземление 15 провода
    Train.Panel.SD = (S["D1"]+BO*Train.PRL22.Value*Train.KU11.Value)*(T[15]*(1-Train.KU11.Value)+BD)

    Train.VDZ:TriggerInput("Set",T[16]*Train.PRL17.Value*BD)
    Train.VDOL:TriggerInput("Set",(T[31]*Train.PRL18.Value)+(T[12]*Train.PRL2A.Value))
    Train.VDOP:TriggerInput("Set",(T[32]*Train.PRL19.Value)+(T[12]*Train.PRL2A.Value))

    Panel.CBKIPower = T[10]*Train.PRL4A.Value
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
    Train.Panel.Sequence =S["10A"]*RheostatController.RKM1
    Train["RUTpod"] = S["10I"]*Train.LK4.Value
    Train["RRTpod"] = S["10I"]*(1-Train.LK1.Value)
    Train["RRTuderzh"] = T[25]
    Train.RRT:TriggerInput("Close",Train.RRTuderzh*Train.RRTpod)
    Train.RRT:TriggerInput("Open",(1-Train.RRTuderzh))

    local SDRKr = 1-Train.LK2.Value*(0.2+0.3*C(2 <=RK and RK <= 7 and P==1))
    RheostatController:TriggerInput("MotorCoilState",min(1,S["10A"]*(S["10B"]*Train.RR.Value - S["10B"]*(1-Train.RR.Value)))*SDRKr)

    S["10N"] = S["10A"]*(RheostatController.RKM1+Train.SR1.Value*(1-Train.RUT.Value))
    S["10T"] = ((1-Train.SR1.Value)+Train.RUT.Value)*(RheostatController.RKP)
    RheostatController:TriggerInput("MotorState",(S["10N"]+S["10T"]*(-10)))

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

local wires = {1,2,3,4,5,6,7,8,10,9,13,14,17,18,20,25,11,12,15,16,21,-21,22,23,24,27,28,29,30,31,32}
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
----------------------------------------------------------------------------
-- 81-703, 81-707 intherim electric schemes
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_703I_Electric")
TRAIN_SYSTEM.E = 1
TRAIN_SYSTEM.Ezh = 2
TRAIN_SYSTEM.KVL = 3
function TRAIN_SYSTEM:Initialize(typ1,typ2)
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
    return { "Type"}
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
    local isKVL = elType == 3

    local BO = min(1,B * Train.VB.Value+T[10])--B * Train.VB.Value
    local KV = Train.KV
    local Panel = Train.Panel


    Panel.V1 = BO

    Train:WriteTrainWire(10,B*Train.VB.Value)
    Panel.GRP = BO*Train.RPvozvrat.Value
    S["10AK"] = BO*Train.VU.Value

    if isE then
        S["U2"] = S["10AK"]*(KV["U2-10AK"]+Train.R1_5.Value)
    else
        S["U2"] = S["10AK"]*KV["U2-10AK"]
    end

    Panel.RRP = S["U2"]*T[18]
    Train:WriteTrainWire(4,S["U2"]*KV["U2-4"])
    Train:WriteTrainWire(5,S["U2"]*KV["U2-5ZH"]*(Train.UAVAC.Value+KV["5ZH-5"]))
    Panel.AnnouncerPlaying = T[13]
    Train:WriteTrainWire(24,S["U2"]*Train.KU8.Value)
    if isKVL then
        Train:WriteTrainWire(1,S["10AK"]*Train.R1_5.Value+(BO*Train.RO1.Value))
        Train:WriteTrainWire(2,S["U2"]*KV["U2-2"]+(BO*Train.RO1.Value))
        Train:WriteTrainWire(3,S["U2"]*KV["U2-3"]+(BO*Train.RO2.Value))
        Train:WriteTrainWire(20,S["U2"]*KV["U2-20"]+(BO*Train.RO2.Value))
    else
        if isE then 
            Train:WriteTrainWire(14,BO*KV["10-14B"]*KV["14-14B"])
        end

        Train:WriteTrainWire(1,S["10AK"]*Train.R1_5.Value)
        Train:WriteTrainWire(2,S["U2"]*KV["U2-2"])
        Train:WriteTrainWire(3,S["U2"]*KV["U2-3"])
        Train:WriteTrainWire(20,S["U2"]*KV["U2-20"])
    end
    Train:WriteTrainWire(25,S["U2"]*KV["U2-25"])
    Train:WriteTrainWire(6,S["U2"]*KV["U2-6"])
    Train.RV2:TriggerInput("Set",S["10AK"]*KV["10AK-7A"])
    Train.R1_5:TriggerInput("Set",S["10AK"]*Train.RV2.Value)
    Train:WriteTrainWire(17,S["10AK"]*Train.KU9.Value)
    Train:WriteTrainWire(8,BO*KV["10-8"])

    if isKVL then Panel.UPOPower = BO*KV["D-D1"] end

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
    if isKVL then
        S["4A"] = T[4]+T[29]-10*Train.RO2.Value*KV["U2-5ZH"]
        S["5A"] = T[5]+T[30]
    else
        S["4A"] = T[4]*RUM
        S["5A"] = T[5]*RUM
    end

    Reverser:TriggerInput("NZ",S["4A"]*Reverser.VP)
    Reverser:TriggerInput("VP",S["5A"]*Reverser.NZ)
    Train.LK4:TriggerInput("Set",(S["4A"]*Reverser.NZ+S["5A"]*Reverser.VP)*(1-Train.RPvozvrat.Value)*Train.LK3.Value*S["ZR"])
    if isKVL then
        S["2A"] = (T[2]+BO*Train.RO1.Value)*RUM
        Train.PneumaticNo2:TriggerInput("Set",T[8]*(1-Train.LK4.Value)+T[39])
        S["48A"] = C(P==4 and 1 <= RK and RK <= 5)
        Train:WriteTrainWire(48,S["48A"])
        Train.PneumaticNo1:TriggerInput("Set",(S["2A"]*Train.PR.Value)*(T[48]*RUM+S["48A"]))

        S["DT"] = BO*Train.BPT.Value
        Panel.BrY = S["DT"]
        Train:WriteTrainWire(34,S["DT"])
    elseif isE then
        Train.PneumaticNo1:TriggerInput("Set",T[8]*C(P == 4 and 1 <= RK and RK <= 5))
        Train.PneumaticNo2:TriggerInput("Set",T[8]*(1-Train.RV3.Value)*(1-Train.LK4.Value))
        Train.RS:TriggerInput("Set",T[12]*RUM)
        Train.RV3:TriggerInput("Set",T[14]*RUM)
    else
        Train:WriteTrainWire(48,C(P == 4 and 1 <= RK and RK <= 5))
        Train.PneumaticNo1:TriggerInput("Set",(T[8]+T[44])*T[48])
        Train.PneumaticNo2:TriggerInput("Set",T[8]*(1-Train.LK4.Value))
    end

    S["10A"] = BO*RUM

    --РУТ
    --СДРК
    if isKVL then
        S["10B"] = S["10A"]*(Train.RV1.Value+Train.TSH.Value*(1-Train.KSH3.Value))
    else
        S["10B"] = S["10A"]*(Train.RV1.Value+Train.TSH.Value)
    end
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
    if isKVL then
        S["2A"] = (T[2]+BO*Train.RO1.Value)*RUM
    else
        S["2A"] = T[2]*RUM
    end
    S["2G"] = S["2A"]*(C(P==1 or P==3)*C(1<=RK and RK<=17)+C(P==2 or P==4)*(C(5<=RK and RK<=18)+C(2<=RK and RK<=4)*Train.KSH1.Value))
    if isE then
        S["2E"] = S["2G"]*(1-Train.SR2.Value)*Train.LK4.Value+S["10AV"]
    else
        S["2E"] = S["2G"]*Train.LK4.Value+S["10AV"]
    end
    Train.RV1:TriggerInput("Set",S["2E"]*S["ZR"])
    Train.SR1:TriggerInput("Set",S["2E"]*(1-Train.RRT.Value)*S["ZR"])

    if isKVL then
        Train.Rper:TriggerInput("Set",(T[3]+BO*Train.RO2.Value)*RUM*C(17<=RK and RK<=18))
    else
        Train.Rper:TriggerInput("Set",T[3]*RUM*C(17<=RK and RK<=18)*S["ZR"])
    end

    if isKVL then
        S["1P"] = (T[1]+BO*Train.RO1.Value)*RUM*C(P == 1 or P == 2)*Train.NR.Value
    else
        S["1P"] = T[1]*RUM*C(P == 1 or P == 2)*Train.NR.Value
    end
    S["6A"] = T[6]*RUM
    Train.TSH:TriggerInput("Set",S["6A"])
    if isKVL then Train.PR:TriggerInput("Set",S["6A"]) end
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

    if isKVL then
        Train.RO1:TriggerInput("Set",T[9])
        Train.RO2:TriggerInput("Set",T[9]*Train.RO1.Value)
    end
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
    if isKVL then
        Train:WriteTrainWire(23,BO*Train.KU1.Value)
        Train:WriteTrainWire(22,T[23]*Train.AK.Value)
    else
        S["23A"] = BO*Train.KU1.Value
        Train:WriteTrainWire(22,(S["23A"]+T[23])*(Train.AK.Value))
    end

    Panel.AVU = BO*(1-Train.AVU.Value)
    Train:WriteTrainWire(27,BO*Train.KU4.Value)
    Train:WriteTrainWire(28,BO*Train.KU5.Value)

    S["D1"] = BO*KV["D-D1"]
    S["F7"] = BO*KV["F-F7"]
    if isE then
        Train:WriteTrainWire(31,S["D1"]*(Train.KU10.Value+Train.KU6.Value+Train.KU13.Value))
        Train:WriteTrainWire(32,S["D1"]*(Train.KU10.Value+Train.KU7.Value))
        Train:WriteTrainWire(12,S["F7"]*Train.KU12.Value)
    else
        Train.RRP:TriggerInput("Set",T[14])
        if isKVL then
            Train:WriteTrainWire(31,S["D1"]*(Train.KU6.Value+Train.KU13.Value))
            Train:WriteTrainWire(32,S["D1"]*Train.KU7.Value)
        else
            Train:WriteTrainWire(31,S["D1"]*(Train.KU6.Value+Train.KU13.Value)+T[12])
            Train:WriteTrainWire(32,S["D1"]*Train.KU7.Value+T[12])
        end
        Train:WriteTrainWire(12,S["D1"]*Train.KU10.Value)
    end
    Train:WriteTrainWire(16,S["D1"]*Train.KU2.Value*Train.KU3.Value)
    Panel.Headlights1 = S["F7"]
    Panel.Headlights2 = S["F7"]*Train.KU16.Value

    if isKVL then
        S["F1"] = BO*KV["10-F1"]
        Train:WriteTrainWire(42,T[11]*Train.BD2.Value)
        Train:WriteTrainWire(44,S["F1"]*C(RK==1 and P==4))
        Train:WriteTrainWire(46,S["F1"]*C(1<=RK and RK<=17 and P==3))
    end

    if isE then
        S["11A"] = T[11]*(1-Train.KZ1.Value)
    else
        S["11A"] = T[11]*(1-Train.NR.Value)
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

    if isKVL or isE then
        Train.KK:TriggerInput("Set",T[22])
    else
        Train.KK:TriggerInput("Set",(T[22]+T[23])*(1-Train.TRK.Value))
    end
    Train.KO:TriggerInput("Close",T[27])
    Train.KO:TriggerInput("Open",T[28])

    local BD = 1-Train.BD.Value
    if isKVL then
        Train:WriteTrainWire(15,T[-15]*Train.RD.Value)
        Train.RD:TriggerInput("Set",BO*Train.BD.Value)
        Panel.SD = BO*BD
    else
        Train:WriteTrainWire(15,BD*(1-Train.KU11.Value))
        Panel.SD = (S["D1"]+BO*Train.KU11.Value)*(T[15]*(1-Train.KU11.Value)+BD)
    end

    Train.VDZ:TriggerInput("Set",T[16]*BD)
    if isE or isKVL then
        Train.VDOL:TriggerInput("Set",T[31])
        Train.VDOP:TriggerInput("Set",T[32])
    else
        Train.VDOL:TriggerInput("Set",T[31]+T[12])
        Train.VDOP:TriggerInput("Set",T[32]+T[12])
        Panel.PCBKPower = T[10]
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
    local isEzh = self.Type == 2
    local isKVL = self.Type == 3

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
    if isKVL then
        S["10B"] = S["10A"]*(Train.RV1.Value+Train.TSH.Value*(1-Train.KSH3.Value))
    else
        S["10B"] = S["10A"]*(Train.RV1.Value+Train.TSH.Value)
    end
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
    if isKVL then
        S["2A"] = (T[2]+BO*Train.RO1.Value)*RUM
    else
        S["2A"] = T[2]*RUM
    end
    S["2G"] = S["2A"]*(C(P==1 or P==3)*C(1<=RK and RK<=17)+C(P==2 or P==4)*(C(5<=RK and RK<=18)+C(2<=RK and RK<=4)*Train.KSH1.Value))
    if isE then
        S["2E"] = S["2G"]*(1-Train.SR2.Value)*Train.LK4.Value+S["10AV"]
    else
        S["2E"] = S["2G"]*Train.LK4.Value+S["10AV"]
    end
    Train.RV1:TriggerInput("Set",S["2E"]*S["ZR"])
    Train.SR1:TriggerInput("Set",S["2E"]*(1-Train.RRT.Value)*S["ZR"])

    if isKVL then
        Train.Rper:TriggerInput("Set",(T[3]+BO*Train.RO2.Value)*RUM*C(17<=RK and RK<=18))
    else
        Train.Rper:TriggerInput("Set",T[3]*RUM*C(17<=RK and RK<=18)*S["ZR"])
    end

    S["6A"] = T[6]*RUM
    Train["RUTavt"] = S["6A"]*(1-Train.KSH2.Value)

    return S
end

local wires = {1,2,3,4,5,6,8,9,10,11,12,13,14,-15,15,16,17,18,20,22,23,24,25,27,28,29,30,31,32,-34,34,39,44,48}
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

function TRAIN_SYSTEM:Think(...)
    return Metrostroi.BaseSystems["81_703_Electric"].Think(self,...)
end
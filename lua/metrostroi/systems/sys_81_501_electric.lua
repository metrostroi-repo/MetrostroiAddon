--------------------------------------------------------------------------------
-- 81-501 electric schemes
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_501_Electric")
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
    Panel.V1 = BO

    Train:WriteTrainWire(10,B*Train.VB.Value)
    S["10AK"] = T[10]*Train.VU.Value

    S["U2"] = S["10AK"]*KV["U2-10AK"]

    Panel.S6 = T[6]
    Panel.S1 = T[1]
    Panel.S2 = T[2]
    Panel.SSN = T[20]*T[18]

    if KVL then
        S["DA"] = S["10AK"]*KV["10AK-DA"]
        Train:WriteTrainWire(8,T[10]*KV["10-8"])
        Train:WriteTrainWire(4,S["10AK"]*KV["10AK-4"])
        Train:WriteTrainWire(5,S["10AK"]*KV["10AK-5"]*(Train.UAVAC.Value+KV["5-5a"]))

        Train:WriteTrainWire(1,S["10AK"]*KV["1-10AK"]*Train.RV2.Value+(BO*Train.RO1.Value))
        Train:WriteTrainWire(17,S["10AK"]*Train.VozvratRP.Value)
        Train:WriteTrainWire(6,S["10AK"]*Train.RVT.Value)
        Train:WriteTrainWire(2,S["U2"]*KV["U2-2a"]+(BO*Train.RO1.Value))
        Train:WriteTrainWire(20,S["U2"]*KV["U2-20"]+(BO*Train.RO2.Value))
        Train:WriteTrainWire(25,S["U2"]*KV["U2-25"])
        Train:WriteTrainWire(3,S["U2"]*KV["U2-3"]+(BO*Train.RO2.Value))

        Train.RVT:TriggerInput("Set",S["U2"]*KV["U2-RVT"])
        Train.RV2:TriggerInput("Set",S["10AK"]*KV["33-10AK"]*(1-Train.RVT.Value))

    else
        S["DA"] = T[10]*KV["10AK-DA"]
        Train:WriteTrainWire(8,BO*KV["10-8"])
        Train:WriteTrainWire(4,S["10AK"]*KV["10AK-4"])
        Train:WriteTrainWire(5,S["10AK"]*(KV["10AK-5"]*(Train.UAVAC.Value+KV["5-5a"])))

        Train:WriteTrainWire(1,S["10AK"]*KV["1-10AK"]*Train.RV2.Value+(BO*Train.RO1.Value))
        Train:WriteTrainWire(6,S["10AK"]*Train.RVT.Value)
        Train:WriteTrainWire(17,S["10AK"]*Train.VozvratRP.Value)
        Train:WriteTrainWire(2,S["U2"]*KV["U2-2a"]+(BO*Train.RO1.Value))
        Train:WriteTrainWire(20,S["U2"]*KV["U2-20"]+(BO*Train.RO2.Value))
        Train:WriteTrainWire(25,S["U2"]*KV["U2-25"])
        Train:WriteTrainWire(3,S["U2"]*KV["U2-3"]+(BO*Train.RO2.Value))

        Train.RVT:TriggerInput("Set",S["U2"]*KV["U2-RVT"])
        Train.RV2:TriggerInput("Set",S["10AK"]*KV["33-10AK"]*(1-Train.RVT.Value))
    end
    Panel.UPOPower = BO*KV["10AK-DA"]

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
        S["48A"] = C(P==4 and 1 <= RK and RK <= 5)
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
    Train:WriteTrainWire(11,T[10]*Train.VU2.Value)
    Train:WriteTrainWire(23,BO*Train.VMK.Value)
    Train:WriteTrainWire(22,T[23]*Train.AK.Value)

    Train:WriteTrainWire(27,T[10]*Train.LOn.Value)
    Train:WriteTrainWire(28,T[10]*Train.LOff.Value)

    S["F7"] = BO*KV["F-F7"]
    Panel.Headlights1 = S["F7"]
    Panel.Headlights2 = S["F7"]*Train.VUS.Value

    S["F1"] = BO*(1-Train.VKF.Value)*KV["B2-F1"]
    Train:WriteTrainWire(42,T[11]*Train.BD2.Value)
    if KVL then
        Train:WriteTrainWire(44,S["F1"]*C(RK==1 and P==4))
        Train:WriteTrainWire(46,S["F1"]*C(1<=RK and RK<=17 and P==3))
    end

    S["D1"] = T[10]*KV["D-D1"]
    S[31] = S["D1"]*(Train.KDL.Value)
    S[32] = S["D1"]*(Train.KDP.Value)
    Train:WriteTrainWire(31,S["D1"]*(Train.KDL.Value+Train.VDL.Value+Train.KRZD.Value))
    Train:WriteTrainWire(32,S["D1"]*(Train.KDP.Value+Train.KRZD.Value))
    Train:WriteTrainWire(16,S["D1"]*Train.VUD.Value) --FIXME AV
    Panel.AnnouncerPlaying = T[13]
    --Train:WriteTrainWire(45,S["D1"]*Train.KDPH.Value)
    Train:WriteTrainWire(24,T[20]*Train.KSN.Value)
    Train:WriteTrainWire(15,T[-15]*Train.RD.Value)
    Panel.SSD = T[-15]*T[15]

    S["11A"] = T[11]*(1-Train.NR.Value)
    Panel.EmergencyLights1 = T[10]*Train.VU3.Value+S["11A"]*(1-Train.VU3.Value)
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

    Train.KK:TriggerInput("Set",T[22]*(1-Train.TRK.Value))
    Train.KO:TriggerInput("Close",T[27])
    Train.KO:TriggerInput("Open",T[28])

    Train.RD:TriggerInput("Set",BO*Train.BD.Value)
    if KVL then
        Panel.DoorsWC = BO*(1-Train.RD.Value)*Train.KSD.Value
    else
        Panel.DoorsWC = T[10]*(1-Train.RD.Value)*Train.KSD.Value
    end
    Panel.DoorsW = BO*(1-Train.RD.Value)

    Panel.GreenRP = T[10]*Train.RPvozvrat.Value

    Train.VDZ:TriggerInput("Set",T[16]*(1-Train.RD.Value))
    Train.VDOL:TriggerInput("Set",T[31])
    Train.VDOP:TriggerInput("Set",T[32])
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

local wires = {1,2,3,4,5,6,8,9,10,11,13,-15,15,16,17,18,20,22,23,24,25,27,28,29,30,31,32,39,42,44,48,}
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
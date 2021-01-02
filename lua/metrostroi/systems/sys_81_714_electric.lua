--------------------------------------------------------------------------------
-- 81-714 Moscow and SPB electric schemes
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_714_Electric")
TRAIN_SYSTEM.MVM = 1
TRAIN_SYSTEM.LVZ_1 = 2
TRAIN_SYSTEM.LVZ_2 = 3
TRAIN_SYSTEM.LVZ_3 = 4
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

    self.SolvePowerCircuits = Metrostroi.BaseSystems["81_717_Electric"].SolvePowerCircuits
    self.SolveThyristorController = Metrostroi.BaseSystems["81_717_Electric"].SolveThyristorController
    self.Think = Metrostroi.BaseSystems["81_717_Electric"].Think
end

if CLIENT then return end
function TRAIN_SYSTEM:Inputs(...)
    return { "Type", "NoRT2", "HaveRO", "GreenRPRKR","X2PS", "HaveVentilation" }
end
function TRAIN_SYSTEM:Outputs(...)
    return Metrostroi.BaseSystems["81_717_Electric"].Outputs(self,...)
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

    local isMVM = self.Type == 1

    local Panel = Train.Panel
    Panel.V1 = BO

    --Поездная часть
    S["33D"] = T[10]*Train.A54.Value*Train.A84.Value
    Train:WriteTrainWire(1, S["33D"]*C(Train.RV.Value~=1))
    Train:WriteTrainWire(20,S["33D"]*C(Train.RV.Value~=1))
    Train:WriteTrainWire(4, S["33D"]*C(Train.RV.Value==2)*Train.Start.Value)
    Train:WriteTrainWire(5, S["33D"]*C(Train.RV.Value==0)*Train.Start.Value)
    Train:WriteTrainWire(17,S["33D"]*Train.VozvratRP.Value)
    if isMVM then
        Train:WriteTrainWire(71,S["33D"]*Train.OtklBV.Value)
    end
    --Вагонная часть
    S["10A"] = BO*Train.A30.Value
    S["ZR"] = (1-Train.RRP.Value)+(B*Train.A39.Value*(1-Train.RPvozvrat.Value)*Train.RRP.Value)*-1

    S["1A"] = T[1]*Train.A1.Value*Train.IGLA_PCBK.KVC
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
    S["20A"] = T[20]*Train.A20.Value*Train.IGLA_PCBK.KVC
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
    end
    Train.RPvozvrat:TriggerInput("Open",S["17A"]) --FIXME Mayve more right RP code
    --
    --Вспом цепи
    Train:WriteTrainWire(10,BO*Train.A56.Value)

    if self.NoRT2 then
        Train:WriteTrainWire(48,Train.A72.Value*S["2Zh"]) --FIXME ARS
    else
        Train:WriteTrainWire(48,Train.A72.Value*S["2Zh"]*(1-Train.RT2.Value)) --FIXME ARS
    end

    Train:WriteTrainWire(22,T[10]*Train.A10.Value*Train.AK.Value)
    S["UO"] = T[10]*Train.A27.Value
    Train:WriteTrainWire(27,S["UO"]*Train.L_1.Value)
    S["36N"] = BO*Train.A45.Value
    Train:WriteTrainWire(36,S["36N"]*Train.BPSNon.Value)
    Train:WriteTrainWire(37,S["36N"]*Train.ConverterProtection.Value)

    if self.GreenRPRKR then
        S["10AN"] = Train.RPvozvrat.Value+(1-Train.RKR.Value) --81-717 Харьков
    else
        S["10AN"] = Train.RPvozvrat.Value --81-717 МСК
    end
    S["18A"] = (S["10AN"]*100+(1-Train.LK4.Value))*Train.A38.Value
    Train:WriteTrainWire(18,S["18A"])
    Panel.TW18 = S["18A"]
    Panel.GreenRP = S["10AN"]*S["UO"]

    --S["36N"] = BO*Train.A45.Value
    --Train:WriteTrainWire(37,Train.ConverterProtection.Value)
    --Train:WriteTrainWire(36,S["36N"]*(1-Train.BPSNon.Value))
    --Train:WriteTrainWire(69,T[36]*Train.BPSNon.Value)

    S["B9"] = B*Train.A53.Value
    S["B9a"] = S["B9"]*Train.VB.Value
    Train.KVC:TriggerInput("Set",S["B9a"])
    --Train.KUP:TriggerInput("Set",S["B9a"]*Train.A75.Value)
    S["D4"] = BO*Train.A13.Value
    Panel.RZP = T[36]*T[61]
    --[[S["14b"] = S["14a"]*Train.A17.Value
    S["D1"] = ["10"]*Train.A21.Value*KV["D-D1"]+S["14b"]*KRU["11/3-D1/1"]
    if isLVZ then
        Train:WriteTrainWire(16,S["D1"]*(Train.VUD1.Value*Train.VUD2.Value+AVO["16"]*RC2))
    else
        Train:WriteTrainWire(16,S["D1"]*(Train.VUD1.Value*Train.VUD2.Value))
    end
    Train:WriteTrainWire(12,S["D1"]*Train.KRZD.Value)
    S[31] = S["D1"]*(1-Train.DoorSelect.Value)
    S[32] = S["D1"]*Train.DoorSelect.Value
    Train:WriteTrainWire(31,S[31]*(Train.KDL.Value+Train.KDLR.Value+Train.VDL.Value))
    Train:WriteTrainWire(32,S[32]*Train.KDP.Value)

    S["F7"] = T[10]*Train.A29.Value*KV["F-F7"]+S["14b"]*KRU["11/3-FR1"]
    S["F1"] = S["B9"]*KV["B9-F1"]--]]

    Train:WriteTrainWire(34,Train.RKTT.Value+Train.DKPT.Value)
    Train:WriteTrainWire(28,T[-28]*Train.RD.Value)

    S[64] = S["UO"]*Train.BPT.Value
    Train:WriteTrainWire(64,S[64])
    Panel.BrW = S[64]

    --Вспом цепи приём
    Panel.EmergencyLights = BO*Train.A49.Value*Train.A15.Value
    Train.RPU:TriggerInput("Set",T[37]*Train.A37.Value)

    S["D6"] = S["D4"]*Train.BD.Value
    Train.RD:TriggerInput("Set",S["D6"])
    Panel.DoorsW = S["D4"]*(1-Train.RD.Value)
    Train.VDZ:TriggerInput("Set",T[16]*Train.A16.Value*(1-Train.RD.Value))
    S["12A"] = T[12]*Train.A12.Value
    S["31A"] = T[31]*Train.A31.Value
    S["32A"] = T[32]*Train.A32.Value
    Train.VDOL:TriggerInput("Set",S["31A"]+S["12A"])
    Train.VDOP:TriggerInput("Set",S["32A"]+S["12A"])

    S["36A"] = T[36]*Train.A51.Value*Train.RVO.Value--36
    Train.KVP:TriggerInput("Set",S["36A"]*Train.KPP.Value)
    Train.KPP:TriggerInput("Set",S["36A"]*(1-Train.RZP.Value)*Train.KVC.Value)
    S["27A"] = T[27]*Train.A50.Value
    Train.KO:TriggerInput("Set",S["27A"])
    --S["22A"] = (T[23]*Train.A23.Value+T[22]*Train.A22.Value) --FIXME 714

    Train.RV2:TriggerInput("Set",T[23]*Train.A23.Value)
    Train.KK:TriggerInput("Set",(
        T[22]*Train.A22.Value*(1-Train.RV2.Value)+
        T[23]*Train.A23.Value*Train.RV2.Value
    )*(1-Train.TRK.Value))

    --if isMVM then
        Panel.AnnouncerPlaying = T[13]
        Panel.AnnouncerBuzz = T[-13]
    --end

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

local wires = {10,1,6,3,20,4,5,2,48,8,39,19,25,13,-13,14,24,17,71,36,-28,37,16,12,31,32,69,27,23,22,23,37,59,60,58,61}
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
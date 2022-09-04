----------------------------------------------------------------------------
-- 81-702 electric schemes
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_702_Electric")
TRAIN_SYSTEM.Dc = 1
TRAIN_SYSTEM.Do = 2
TRAIN_SYSTEM.DcI = 3
TRAIN_SYSTEM.DoI = 4
function TRAIN_SYSTEM:Initialize(typ1,typ2)
    self.Type = self.Type or self.Dc
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
local wires = {1,2,3,4,5,6,7,8,11,10,12,13,15,16,17,18,20,22,23,24,27,28,31,32,}
function TRAIN_SYSTEM:SolveAllInternalCircuits(Train, dT)
    ---[[
    local RheostatController = Train.RheostatController
    local P = Train.PositionSwitch
    local RK = RheostatController.SelectedPosition
    local B = (Train.Battery.Voltage > 55) and 1 or 0
    local T = Train.SolverTemporaryVariables

    local BO = min(1,B * Train.VB.Value+T[10])--B * Train.VB.Value
    local KV = Train.KV
    local Panel = Train.Panel
    local isInt = self.Type>2

    Panel.V1 = BO
    Train:WriteTrainWire(10,B*Train.VB.Value)


    S["10AK"] = BO*Train.VU.Value

    S["U2"] = S["10AK"]*KV["U2-10AK"]
    Train:WriteTrainWire(8,T[10]*KV["10-8"])
    Train:WriteTrainWire(1,S["U2"]*KV["U2-1"])
    Train:WriteTrainWire(2,S["U2"]*KV["U2-2"])
    Train:WriteTrainWire(3,S["U2"]*KV["U2-3"])
    Train:WriteTrainWire(6,S["U2"]*KV["U2-6"])
    Train:WriteTrainWire(7,S["U2"]*KV["U2-7"])
    Train:WriteTrainWire(17,S["10AK"]*KV["10AK-17"]*Train.VRP.Value)
    Train:WriteTrainWire(12,-KV["0-12"])
    Train:WriteTrainWire(20,S["10AK"]*Train.VZ.Value)
    Train:WriteTrainWire(24,S["U2"]*Train.SN.Value)

    Train:WriteTrainWire(4,S["U2"]*KV["U2-4"])
    Train:WriteTrainWire(5,(S["U2"]*KV["U2-5M"])*(Train.UAVAC.Value+KV["5M-5"]))
    Panel.RRP = S["U2"]*T[18]
    Panel.GRP = BO*Train.RPvozvrat.Value

    S["A2"] = math.max(0,math.min(1,(self.Aux750V-100)/670))
    S["D1"] = BO*KV["D-D1"]
    S["D2"] = BO*KV["D-D2"]
    Panel.Headlights1 = S["A2"]*KV["F-F7"]
    Panel.Headlights2 = Panel.Headlights1
    if not isInt then
        local RRI_VV = Train.RRI_VV
        RRI_VV.Power = BO*Train.RRIEnable.Value
        RRI_VV.AmplifierPower = BO*Train.RRIAmplifier.Value
        Train:WriteTrainWire(13,RRI_VV.AmplifierPower*Train.RRI.LineOut)
    end
    Panel.AnnouncerPlaying = T[13]

    S["RA"] = -T[12]
    local RUM = KV.RCU

    Train.RZ_2:TriggerInput("Set",T[24]*RUM*(1-Train.LK3.Value))
    S["18A"] = RUM*(Train.RPvozvrat.Value*100+(1-Train.LK3.Value))
    Train:WriteTrainWire(18,S["18A"])
    Panel.TW18 = S["18A"]

    Train.PneumaticNo2:TriggerInput("Set",T[8]*(1-Train.LK3.Value))
    Train.PneumaticNo1:TriggerInput("Set",T[8]*C(14<=RK and RK<=20)*S["RA"]+T[20])
    P:TriggerInput("VP",T[5]*RUM*P.NZ*S["RA"])
    P:TriggerInput("NZ",T[4]*RUM*P.VP*S["RA"])
    Train.LK2:TriggerInput("Set",(T[5]*RUM*P.VP+T[4]*RUM*P.NZ)*Train.AVT.Value*(1-Train.RPvozvrat.Value)*(Train.M.Value+Train.LK1.Value*Train.LK2.Value)*S["RA"])
    Train.RVuderzh = T[7]*RUM*S["RA"]

    Train.RPvozvrat:TriggerInput("Open",T[17]*RUM)

    P:TriggerInput("TPT",T[6]*RUM*(1-Train.LK1.Value)*S["RA"])
    P:TriggerInput("TPM",T[1]*RUM*(1-Train.M.Value)*S["RA"])

    S["2G"]= (T[2]*RUM*((1-Train.RV.Value)*P.TPT*C(1<=RK and RK<=18)+P.TPM*(C(1<=RK and RK<=11 or 14<=RK and RK<=18)+Train.SH1.Value*C(12==RK or RK==19)))+T[3]*RUM*C(RK==13))*(1-Train.RU.Value)
    S["2E"] = BO*RUM*(RheostatController.PV2+(C(2<=RK and RK<=20)*(1-Train.M.Value)*(1-Train.LK1.Value)+S["2G"]*Train.LK3.Value)*RheostatController.PV1)

    Train.RVpod = BO*RUM*RheostatController.PV2
    Train.RUpod = BO*RUM*RheostatController.PV2--+C(2<=RK and RK<=20)*(1-Train.M.Value)*(1-Train.LK1.Value)*RheostatController.PV1)
    RheostatController:TriggerInput("RK2",S["2E"]*RheostatController.PV3)
    RheostatController:TriggerInput("RK1",S["2E"]*(1-RheostatController.PV3))

    Train.RV:TriggerInput("Close",Train.RVuderzh*Train.RVpod)
    Train.RV:TriggerInput("Open",(1-Train.RVuderzh))

    S["1B"] = T[6]*RUM*P.TPT+T[1]*RUM*P.TPM
    Train.RUavt = S["1B"]*S["RA"]

    S["1D"] = S["1B"]*(1-Train.RPvozvrat.Value)
    Train.LK3:TriggerInput("Set",S["1D"]*Train.LK2.Value*S["RA"])
    S["1V"] = S["1D"]*(Train.LK2.Value+C(RK==1))
    Train.M:TriggerInput("Set",S["1V"]*(P.TPT+Train.NR.Value*C(1<=RK and RK<=13))*S["RA"])
    Train.LK1:TriggerInput("Set",S["1V"]*(Train.NR.Value*P.TPM)*S["RA"])
    Train.RUreg = S["1V"]*C(2<=RK and RK<=10)*P.TPM*S["RA"]-BO*RUM*C(RK==3 or RK==18 or RK==19)*0.75


    S["1L"] = (C(RK==1)+C(RK==12 or RK==13 or RK==19 or RK==20)*P.TPM)*S["RA"]
    Train.SH1:TriggerInput("Set",S["1B"]*S["1L"])
    Train.SH2:TriggerInput("Set",S["1B"]*S["1L"])


    Train:WriteTrainWire(11,BO*Train.VU2.Value)
    Train:WriteTrainWire(23,BO*Train.KU3.Value)
    Train:WriteTrainWire(22,T[23]*Train.AK.Value)
    Train:WriteTrainWire(27,BO*Train.KU1.Value)
    Train:WriteTrainWire(28,BO*Train.KU2.Value)

    Train:WriteTrainWire(16,S["D1"]*Train.KU7.Value*Train.KU8.Value)
    Train:WriteTrainWire(31,S["D1"]*(Train.KU4.Value+Train.KU10.Value+Train.KU5.Value))
    Train:WriteTrainWire(32,S["D1"]*(Train.KU6.Value+Train.KU5.Value))


    S["11A"] = T[11]*(1-Train.NR.Value)
    Panel.EmergencyLights1 = --[[ T[10]--]] BO*Train.VU3.Value+S["11A"]*(1-Train.VU3.Value)
    Panel.EmergencyLights2 = S["11A"]
    Panel.MainLights1 = math.max(0,math.min(1,
        (
            self.Aux750V-100
            -self.Itotal*0.25*P.TPM
            -25*Train.KK.Value
        )/750*(0.5+0.5*B*Train.VB.Value*Train.KZ1.Value)
    ))
    Panel.MainLights2 = Panel.MainLights1*Train.KO.Value
    Train.Battery:TriggerInput("Charge", Train.VB.Value*Panel.MainLights1)

    Panel.VPR = C(self.Aux750V>250)

    Train.KK:TriggerInput("Set",T[22])
    Train.KO:TriggerInput("Close",T[27])
    Train.KO:TriggerInput("Open",T[28])
    Panel.Ring = T[11]*(1-Train.KZ1.Value)+T[28]

    local BD = 1-Train.BD.Value
    Train:WriteTrainWire(15,BD*(1-Train.KU9.Value))--Заземление 15 провода
    Train.Panel.SD = (S["D1"]+ BO*Train.KU9.Value)*(T[15]*(1-Train.KU9.Value)+BD)
    Train.VDZ:TriggerInput("Set",T[16]*BD)
    Train.VDOL:TriggerInput("Set",T[31])
    Train.VDOP:TriggerInput("Set",T[32])

    if not isInt then
        Panel.RedLights = BO*KV["10-F1"]
    end
    Train.Scheme = S
    return S
end
function TRAIN_SYSTEM:SolveRKInternalCircuits(Train, dT)
    ---[[
    local RheostatController = Train.RheostatController
    local P = Train.PositionSwitch
    local RK = RheostatController.SelectedPosition
    local B = (Train.Battery.Voltage > 55) and 1 or 0
    local T = Train.SolverTemporaryVariables

    local BO = min(1,B * Train.VB.Value+T[10])--B * Train.VB.Value

    local RUM = Train.KV.RCU

    S["RA"] = -T[12]
    P:TriggerInput("VP",T[5]*RUM*P.NZ*S["RA"])
    P:TriggerInput("NZ",T[4]*RUM*P.VP*S["RA"])

    P:TriggerInput("TPT",T[6]*RUM*(1-Train.LK1.Value)*S["RA"])
    P:TriggerInput("TPM",T[1]*RUM*(1-Train.M.Value)*S["RA"])

    S["2G"]= (T[2]*RUM*((1-Train.RV.Value)*P.TPT*C(1<=RK and RK<=18)+P.TPM*(C(1<=RK and RK<=11 or 14<=RK and RK<=18)+Train.SH1.Value*C(12==RK or RK==19)))+T[3]*RUM*C(RK==13))*(1-Train.RU.Value)
    S["2E"] = BO*RUM*(RheostatController.PV2+(C(2<=RK and RK<=20)*(1-Train.M.Value)*(1-Train.LK1.Value)+S["2G"]*Train.LK3.Value)*RheostatController.PV1)

    Train.RVpod = BO*RUM*RheostatController.PV2
    Train.RUpod = BO*RUM*RheostatController.PV2--+C(2<=RK and RK<=20)*(1-Train.M.Value)*(1-Train.LK1.Value)*RheostatController.PV1)
    RheostatController:TriggerInput("RK2",S["2E"]*RheostatController.PV3)
    RheostatController:TriggerInput("RK1",S["2E"]*(1-RheostatController.PV3))

    Train.RV:TriggerInput("Close",Train.RVuderzh*Train.RVpod)
    Train.RV:TriggerInput("Open",(1-Train.RVuderzh))
    return S
end
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
    --self.ExtraResistanceLK5 = 0--Train.KF_47A["L2-L4"  ]*(1-Train.LK5.Value)
    --self.ExtraResistanceLK2 = Train.KF_47A["L1-L2"]*(1-Train.LK2.Value)*Train.LK1.Value
    if Train.M.Value == 1 then -- PP
        local res = Train.ResistorBlocks.R1(Train)
        self.R1 = res/2
        self.R2 = res/2
        self.R3 = 0.0
    else
        self.R1 = Train.ResistorBlocks.R2C2(Train)
        self.R2 = Train.ResistorBlocks.R2C2(Train)
        self.R3 = 0.0
    end
    -- Apply LK3, LK4 contactors
    self.R1 = self.R1 + 1e9*(1 - Train.LK2.Value)*(1 - Train.LK3.Value)
    self.R2 = self.R2 + 1e9*(1 - Train.LK2.Value)*(1 - Train.LK3.Value)

    -- Shunt resistance
    self.Rs1 = Train.ResistorBlocks.S1(Train) + 1e9*(1 - Train.SH1.Value)
    self.Rs2 = Train.ResistorBlocks.S2(Train) + 1e9*(1 - Train.SH2.Value)

    -- Calculate total resistance of engines winding
    local RwAnchor = Train.Engines.Rwa*2 -- Double because each set includes two engines
    local RwStator = Train.Engines.Rws*2
    -- Total resistance of the stator + shunt
    self.Rstator13  = (RwStator^(-1) + self.Rs1^(-1))^(-1)
    self.Rstator24  = (RwStator^(-1) + self.Rs2^(-1))^(-1)
    -- Total resistance of entire motor
    self.Ranchor13  = RwAnchor
    self.Ranchor24  = RwAnchor

    if Train.PositionSwitch.TPM > 0 then -- X
        if Train.M.Value == 1 then -- PS
            self:SolvePS(Train)
        else --PP
            self:SolvePP(Train,Train.RheostatController.SelectedPosition >= 17)
        end
    else -- T
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
    if Train.PositionSwitch.TPM > 0 then -- X
        if Train.M.Value == 1 then -- PS
            self.I13 = self.I13 * Train.LK1.Value * Train.LK2.Value * Train.LK3.Value
            self.I24 = self.I24 * Train.LK1.Value * Train.LK2.Value * Train.LK3.Value

            self.I24 = (self.I24 + self.I13)*0.5
            self.I13 = self.I24
            self.Itotal = self.I24
        else
            self.I13 = self.I13 * Train.LK1.Value * Train.LK2.Value * Train.LK3.Value
            self.I24 = self.I24 * Train.LK1.Value * Train.LK2.Value * Train.LK3.Value

            self.Itotal = self.I13 + self.I24
        end
        self.Magnetization = 0
    else -- PS -- PT
        self.I13 = self.I13 * Train.LK2.Value * Train.LK3.Value
        self.I24 = self.I24 * Train.LK2.Value * Train.LK3.Value

        self.Itotal = self.I13 + self.I24
        local Magnetization = self.Aux750V/750
        self.Magnetization = (self.Magnetization+(1-self.Magnetization)*dT*(0.5+Magnetization*1.5))*Train.LK2.Value*Train.LK3.Value
        --print(self.Magnetization)
    end

    -- Calculate extra information
    self.Uanchor13 = self.I13 * self.Ranchor13
    self.Uanchor24 = self.I24 * self.Ranchor24


    ----------------------------------------------------------------------------
    -- Calculate current through stator and shunt
    --print(250*Train.TSH.Value*Train.Electric.Main750V/750*self.Rstator13)
    --local RR = math.max(0,(Train.Engines.RotationRate-1500)/1500)
    --self.Magnetization = self.Main750V*Train.TSH.Value/8*Train.AV.Value
    self.Ustator13 = self.I13 * self.Rstator13--+UshuntAdd*RR
    self.Ustator24 = self.I24 * self.Rstator24--+UshuntAdd*RR
    self.Ishunt13  = (self.Ustator13) / self.Rs1
    self.Istator13 = (self.Ustator13) / RwStator
    self.Ishunt24  = (self.Ustator24) / self.Rs2
    self.Istator24 = (self.Ustator24) / RwStator

    if Train.PositionSwitch.TPT > 0 then
        local I1,I2 = self.Ishunt13,self.Ishunt24
        self.Ishunt13 = -I2
        self.Ishunt24 = -I1

        I1,I2 = self.Istator13,self.Istator24
        self.Istator13 = -I2
        self.Istator24 = -I1
    end

    -- Calculate current through RT2 relay
    if Train.PositionSwitch.TPT > 0 then
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
    SH1 = 0.05,
    SH2 = 0.05,
    M = 0.05,
    RV = 0.02,
    PneumaticNo1 = 0.03,
    PneumaticNo2 = 0.03,
    VDOL = 0.03,
    VDOP = 0.03,
    VDZ = 0.03,
}
function TRAIN_SYSTEM:Think(dT,iter)
    local Train = self.Train
    if not self.ResistorBlocksInit then
        self.ResistorBlocksInit  = true
        Train:LoadSystem("ResistorBlocks","Gen_Res_702c")
    end
    if iter == 1 then Train.ResistorBlocks.InitializeResistances_81_702(Train) end
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
        count = count + math.abs(Train.PositionSwitch.TPSpeed*0.02)
        count = count + math.abs(Train.PositionSwitch.ReverserSpeed)
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
        self.R1 + self.R2-- + self.R3 + self.ExtraResistanceLK2
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
    local R1 = self.Ranchor13 + self.Rstator13 + self.R1 + extraR-- + self.ExtraResistanceLK2
    local R2 = self.Ranchor24 + self.Rstator24 + self.R2 + extraR-- + self.ExtraResistanceLK2
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
    local R3 = self.R1 + self.R2-- + self.R3

    -- Main circuit parameters
    local V = self.Power750V*Train.LK1.Value
    local E1 = Train.Engines.E13
    local E2 = Train.Engines.E24

    -- Calculate current through engines 13, 24
    self.I13 = -((E1*R2 + E1*R3 - E2*R3 - R2*V)/(R1*R2 + R1*R3 + R2*R3))
    self.I24 = -((E2*R1 - E1*R3 + E2*R3 - R1*V)/(R1*R2 + R1*R3 + R2*R3))

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

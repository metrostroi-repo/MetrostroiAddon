--------------------------------------------------------------------------------
-- 81-719 electric schemes
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_719_Electric")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize()
    -- General power output
    Metrostroi.BaseSystems["81_718_Electric"].Initialize(self)
    for k,v in pairs(Metrostroi.BaseSystems["81_718_Electric"]) do
        if not self[k] and type(v) == "function" then
            self[k] = v
        end
    end
end

function TRAIN_SYSTEM:Inputs()
    return { }
end

function TRAIN_SYSTEM:Outputs()
    return { "I13","I24","Itotal",
             "Main750V", "Power750V",
        }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end


--------------------------------------------------------------------------------
function TRAIN_SYSTEM:Think(dT,iter)
    local Train = self.Train
    --  local dT = dT/8
    ----------------------------------------------------------------------------
    -- Voltages from the third rail
    ----------------------------------------------------------------------------
    self.Main750V = Train.TR.Main750V
    self.Aux750V  = Train.TR.Main750V
    self.Power750V = self.Main750V*Train.GV.Value


    ----------------------------------------------------------------------------
    -- Information only
    ----------------------------------------------------------------------------
    self.Aux80V = BBE and 82 or 65
    self.Lights80V = BBE and 82 or 0
    self.Battery80V = 65--(Train.VB.Value > 0) and (BBE and 82 or 65) or 0

    ----------------------------------------------------------------------------
    -- Some internal electric
    ----------------------------------------------------------------------------
    local P = self.Battery80V > 62 and 1 or 0
    local HV = 550 < self.Main750V and self.Main750V < 975 and 1 or 0


    ----------------------------------------------------------------------------
    -- Solve circuits
    ----------------------------------------------------------------------------
    self:SolvePowerCircuits(Train,dT)
    if iter == 1 then
        self:SolveControlCircuits(Train,dT)
    end


    ----------------------------------------------------------------------------
    -- Calculate current flow out of the battery
    ----------------------------------------------------------------------------
    --local totalCurrent = 5*A30 + 63*A24 + 16*A44 + 5*A39 + 10*A80
    --local totalCurrent = 20 + 60*DIP
end
local S = {}
local wires = {1,2,3,4,5,6,7,8,9,10,11,-11,12,13,14,15,16,17,18,19,20,22,23,24,26,27,28,29,30,31,32,33,34,35,36,37,38,40,41,42,44,45,47,48,49,50,51,-51,54,55,56,57,58,59,67,74,83,84,87,88,89,90,-34,}
local min = math.min
local max = math.max

local function clamp(val)
    return max(-1,min(1,val))
end
function TRAIN_SYSTEM:SolveControlCircuits(Train,dT)
    local B     = (Train.Battery.Voltage > 62) and 1 or 0
    local T     = Train.SolverTemporaryVariables
    if not T then
        T = {}
        for i,v in ipairs(wires) do T[v] = 0 end
        Train.SolverTemporaryVariables = T
    end
    for i,v in ipairs(wires) do T[v] = min(Train:ReadTrainWire(v),1) end
    local BUP = Train.BUP
    local BUV = Train.BUV

    local BKVA = Train.BKVA
    local BUVS = Train.BUVS
    local BBE = Train.BBE

    local Panel = Train.Panel

    --S[303] = B*Train.VB.Value
    S[305] = clamp(B+T[50]*Train.SF2.Value)*Train.VB.Value
    --S[305] = S[303]
    --S[310] = B*Train.VB.Value
    S[550] = S[305]*Train.SF2.Value --310
    Train:WriteTrainWire(50,S[550])
    --S[311] = B*Train.VB.Value
    S[334] = S[305]*Train.SF45.Value --311
    S[312] = S[305]*Train.SF3.Value --311
    BBE.KMPower = S[334]
    BBE.Power = S[305]
    Panel.V1 = S[312]

    --1.2. Цепи заряда аккумуляторной батареи. Включение ББЭ. Страница 7
    BBE.Activate = T[18]*Train.SF12.Value--S[324] --Включение ББЭ


    --1.5. Аварийное отключение ББЭ и сигнализации Страница 9
    Train:WriteTrainWire(20,BBE.Error)
    BBE.Deactivate = T[19]*Train.SF13.Value --Включение ББЭ

    --2.1. Освещение вагонов основное. Страница 9
    BBE.KM2Power = T[38]*Train.SF16.Value

    Panel.EL7_30 = S[305]*BBE.KM2*Train.SF44.Value--S[409]


    --2.2. Аварийное освещение салонов и кабины. Страница 10
    --S[407] = S[312]*Train.SF44.Value
    Panel.EL3_6 = S[312]*Train.SF44.Value
    S[322] = T[50]*Train.SF11.Value
    Panel.EL1 = S[322]
    S[321] = T[50]*Train.SF10.Value
    --2.4. Подсветка прибора. Страница 10
    S[328] = T[50]*Train.SF72.Value

    Train:WriteTrainWire(29,Train.SF56.Value*T[50]*Train.SP1.Value) --S[529]

    BKVA.KM2 = clamp(T[29]+T[30]*Train.SF22.Value)--[[*тепловое реле]]
    Train.KK:TriggerInput("Set",(self.Main750V > 200 and 1 or 0)*BKVA.KM2)--S[208]

    --5.1. Вентиляция салонов. Страница 13
    S[307] = S[312]*Train.SF34.Value

    BUVS.KM1 = T[40]*Train.SF23.Value
    BUVS.KV1 = S[307]*BUVS.KM1 --Контроль
    Train:WriteTrainWire(42,1-BUVS.KV1)--Сигнализация

    BUVS.KM2 = T[41]*Train.SF23.Value
    BUVS.KV2 = S[307]*BUVS.KM2 --Контроль
    Train:WriteTrainWire(49,1-BUVS.KV2) --Сигнализация


    --352-353-354
    S[354] =(1-BKVA.KM4)
    Train.U1:TriggerInput("Set", T[32]*S[354])

    S[358] = T[33]*Train.SF19.Value
    --[[ S[357] = T[36]*Train.SF18.Value+S[358]
    S[359] = T[37]*Train.SF20.Value+S[358]
    Train.U2:TriggerInput("Set",S[357])
    Train.U3:TriggerInput("Set",S[359])--]]
    Train.U2:TriggerInput("Set",T[36]*Train.SF18.Value+S[358])
    Train.U3:TriggerInput("Set",T[37]*Train.SF20.Value+S[358])

    --8.3. Контроль положения дверей. Страницы 19-20
    --312-SA15..SA22-351
    BKVA.KM4 = S[312]*Train.SAD.Value--S[351]
    Train:WriteTrainWire(34,T[-34]*Train.SAD.Value) --Разрыв питания онцевых переключателей
    Panel.HL13 = S[312]*S[354]

    --9. БЛОКИРОВКА ПОСТОВ УПРАВЛЕНИЯ И ФОРМИРОВАНИЕ ЦЕПЕЙ УПРАВЛЕНИЯ ДВИЖЕНИЕМ СОСТАВА
    --Страница 20-21
    --9.4
    --[[ S[335] = T[15]*Train.SF14.Value
    S[337] = T[16]*Train.SF5.Value
    BKVA.KM3 = S[335]+S[337]--]]
    BKVA.KM3 = T[15]*Train.SF14.Value+T[16]*Train.SF5.Value

    --S[517] = (1-BKVA.KM3)
    Train:WriteTrainWire(17,(1-BKVA.KM3))--S[517]

    --10. ЦЕПИ БЕЛЫХ ФАР И ЛАМП СИГНАЛИЗАЦИИ СТОЯНОЧНОГО ТОРМОЗА
    --Страница 322


    --316-SF41-365-KM2/6-390
    --390-SA1/1(SA2/1)-367(368)-R9(R10)-HL17-19(HL20-22)
    S[512] = S[328]*Train.SQ1.Value
    Train:WriteTrainWire(12,S[512])
    Panel.HL46 = S[512]

    --11. ЗАЩИТА СИЛОВЫХ ЦЕПЕЙ. ЦЕПИ КОНТРОЛЯ СОСТОЯНИЯ ЗАЩИТЫ.
    --11.1. Цепи быстродействующих автоматических выключателей.
    --Страница 23
    S[306] = S[312]*Train.SF27.Value
    Train.BVA.Power = S[306]
    S[3061] = S[306]*Train.SF46.Value
    Train.BVA.ControlPower = S[3061]

    --312=314
    S[314] = clamp(S[312]*Train.SF4.Value*BKVA.KM3+S[3061]*BUV.O75V)
    BUV.Power = S[314]
    Train.BSKA.Power = S[314]
    Train.PTTI.Power = S[314]


    --S[526] = T[45]*Train.SB12.Value
    Train.BVA.Reset = T[26]

    --11.4
    Train.BVA.Disable = T[22]
    Panel.HL25 = S[3061]*BUV.ORP
    --Мы получаем землю
    S[528] = Panel.HL25*100+BUV.OIZ
    Train:WriteTrainWire(28,S[528])
    Panel.HL6 = T[28]
    Panel.TW28= S[528]

    --14.1. Ходовые режимы основного управления. Страница 32-33
    Train.KMR1:TriggerInput("Set",BUV.OVP*(1-Train.KMR2.Value)*S[314])
    Train.KMR2:TriggerInput("Set",BUV.ONZ*(1-Train.KMR1.Value)*S[314])
    BUV.IRV = S[314]*Train.KMR1.Value
    BUV.IRN = S[314]*Train.KMR2.Value

    BUV.IRV = S[314]*Train.KMR1.Value
    BUV.IRN = S[314]*Train.KMR2.Value
    Train.K1:TriggerInput("Set",S[314]*BUV.OLK)
    Train.K2:TriggerInput("Set",S[314]*BUV.OKX)
    Train.K3:TriggerInput("Set",S[314]*BUV.OKT)

    BUV.IKX = Train.K2.Value
    BUV.IKT = Train.K3.Value
    BUV.ILT = Train.K1.Value

    --15. УПРАВЛЕНИЕ СИЛОВЫМ ПРИВОДОМ В ТОРМОЗНЫХ РЕЖИМАХ Страница 36-37
    --КТ
    --БКБД головного-511-К4БУВС-БКБД хвостового
    --S[5092] = S[5091]+T[08]*(1-BUVS.KM3)
    --S[5092] = T[09]*Train.SF26.Value+T[08]*(1-BUVS.KM3)
    BUVS.KM3 = S[314]*BUV.ORMT
    BUVS.KM4 = S[314]*BUV.ORKT
    Train.U6:TriggerInput("Set",T[09]*Train.SF26.Value+T[08]*(1-BUVS.KM3))--S[5092]

    Train:WriteTrainWire(11,BUVS.KM4+Train.SP4.Value)

    Train.U7:TriggerInput("Set",T[10]+Train.SF29.Value*BUV.OV1)

    Train:WriteTrainWire(23,BUV.Power*BUV.OSN)

    --19. УПРАВЛЕНИЕ ОТЖАТИЕМ ТОКОПРИЕМНИКОВ
    Train.U5:TriggerInput("Set",T[24]*T[59])

    Panel.AnnouncerPlaying = T[51]
    Panel.AnnouncerBuzz = T[-51]


    --Передача сигналов с поездных проводов в БУВ
    local BUVPower = BUV.Power
    BUV.IX     = BUVPower*T[01]
    BUV.IT     = BUVPower*T[02]
    BUV.IU1    = BUVPower*T[03]
    BUV.IU2    = BUVPower*T[04]
    BUV.IVP    = BUVPower*T[05]
    BUV.INZ    = BUVPower*T[06]
    BUV.ITARS  = BUVPower*T[07]
    BUV.ITEM   = BUVPower*T[14]
    BUV.IM     = BUVPower*T[13]
    BUV.IVZ    = BUVPower*T[26]
    BUV.IPROV  = BUVPower*T[27]
    BUV.IPROV0 = BUVPower*T[47]
    BUV.IXP    = BUVPower*T[55]
    BUV.IU1R   = BUVPower*T[56]
    BUV.IVR    = BUVPower*T[57]
    BUV.INR    = BUVPower*T[58]
    BUV.IAVR   = BUVPower*(1-Train.SP3.Value) --737-700 14.3. Режим "МАНЕВР".
    --BUV. =    BUVPower*Train:ReadTrainWire(45)
    self.Schemes = S
end
--[=[
--------------------------------------------------------------------------------
function TRAIN_SYSTEM:SolvePowerCircuits(Train,dT)
    -- Apply K2, K3 contactors
    self.R1 = self.R1 + 1e9*(1 - math.min(1,Train.K2.Value+Train.K3.Value))
    self.R2 = self.R2 + 1e9*(1 - math.min(1,Train.K2.Value+Train.K3.Value))

    -- Thyristor contrller
    self.Rs1 = Train.PTTI.RVResistance or 1e9
    self.Rs2 = Train.PTTI.RVResistance or 1e9

    -- Calculate total resistance of engines winding
    local RwAnchor = Train.Engines.Rwa*2 -- Double because each set includes two engines
    local RwStator = Train.Engines.Rws*2
    -- Total resistance of the stator + shunt
    self.Rstator13  = (RwStator^(-1) + self.Rs1^(-1))^(-1)
    self.Rstator24  = (RwStator^(-1) + self.Rs2^(-1))^(-1)
    -- Total resistance of entire motor
    self.Ranchor13  = RwAnchor
    self.Ranchor24  = RwAnchor

    -- Calculate electric power network
    --FIXME
    if Train.PTTI.State < 0 then
        self:SolvePT(Train)
    else
        self:SolvePP(Train)
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

    --FIXME
     if Train.PTTI.State > 0 then -- PS
        self.I13 = self.I13 * Train.K2.Value * Train.K1.Value
        self.I24 = self.I24 * Train.K2.Value * Train.K1.Value

        self.Itotal = Train.Electric.I13 + Train.Electric.I24
    else  -- PT
        self.I13 = self.I13 * Train.K3.Value
        self.I24 = self.I24 * Train.K3.Value

        self.Itotal = Train.Electric.I13 + Train.Electric.I24
    end

    -- Calculate extra information
    self.Uanchor13 = self.I13 * self.Ranchor13
    self.Uanchor24 = self.I24 * self.Ranchor24



    ----------------------------------------------------------------------------
    -- Calculate current through stator and shunt
    self.Ustator13 = self.I13 * self.Rstator13
    self.Ustator24 = self.I24 * self.Rstator24

    self.Ishunt13  = self.Ustator13 / self.Rs1
    self.Istator13 = self.Ustator13 / RwStator
    self.Ishunt24  = self.Ustator24 / self.Rs2
    self.Istator24 = self.Ustator24 / RwStator

    --FIXME
    if Train.PTTI.State < 0 then
        local I1,I2 = self.Ishunt13,self.Ishunt24
        self.Ishunt13 = -I2
        self.Ishunt24 = -I1

        I1,I2 = self.Istator13,self.Istator24
        self.Istator13 = -I2
        self.Istator24 = -I1
    end


    -- Sane checks
    if self.R1 > 1e5 then self.IR1 = 0 end
    if self.R2 > 1e5 then self.IR2 = 0 end

    -- Calculate power and heating --FIXME
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

function TRAIN_SYSTEM:SolvePP(Train)
    -- Calculate total resistance of each branch
    local R1 = self.Ranchor13 + self.Rstator13
    local R2 = self.Ranchor13 + self.Rstator13
    local CircuitClosed = (self.Power750V*Train.K1.Value > 0) and 1 or 0

    -- Main circuit parameters
    local V = self.Power750V*Train.K1.Value*Train.PTTI.RNState
    local E1 = Train.Engines.E13
    local E2 = Train.Engines.E24

    -- Calculate current through engines 13, 24
    self.I13 = math.max(0,((V - E1)/R1)*CircuitClosed)
    self.I24 = math.max(0,((V - E2)/R2)*CircuitClosed)

    -- Total resistance (for induction RL circuit)
    self.R13 = R1
    self.R24 = R2

    -- Calculate everything else
    self.U13 = self.I13*R1
    self.U24 = self.I24*R2
    self.Utotal = (self.U13 + self.U24)/2
    self.Itotal = Train.Electric.I13 + Train.Electric.I24
    -- Energy consumption
    self.EnergyChange = math.abs((self.I13^2)*R1) + math.abs((self.I24^2)*R2)
end

function TRAIN_SYSTEM:SolvePT(Train)
    -- Winding resistances
    local R1 = self.Ranchor13 + self.Rstator13
    local R2 = self.Ranchor24 + self.Rstator24
    -- Total resistance of the entire braking rheostat
    local R3 = --[[ (1.730+0.4)*--]] 2.8*(1-0.95*Train.PTTI.RNState)--0.84
    -- Main circuit parameters
    local V = self.Power750V*Train.K1.Value
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
    self.Itotal = Train.Electric.I13 + Train.Electric.I24

    -- Energy consumption
    self.EnergyChange = -math.abs(((0.5*self.Itotal)^2)*self.R13)
end
--]=]
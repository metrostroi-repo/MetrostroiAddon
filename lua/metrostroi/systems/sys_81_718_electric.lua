--------------------------------------------------------------------------------
-- 81-718 electric schemes
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_718_Electric")
TRAIN_SYSTEM.DontAccelerateSimulation = false



function TRAIN_SYSTEM:Initialize()
    -- General power output
    self.Main750V = 0.0
    self.Aux750V = 0.0
    self.Power750V = 0.0
    self.Aux80V = 0.0
    self.Lights80V = 0.0
    self.Battery80V = 0.0

    -- Resistances
    self.R1 = 1e9
    self.R2 = 1e9
    self.Rs1 = 1e9
    self.Rs2 = 1e9

    self.Rstator13 = 1e9
    self.Rstator24 = 1e9
    self.Ranchor13  = 1e9
    self.Ranchor24  = 1e9

    -- Electric network info
    self.Itotal = 0.0
    self.I13 = 0.0
    self.I24 = 0.0
    self.Ustator13 = 0.0
    self.Ustator24 = 0.0
    self.Ishunt13  = 0.0
    self.Istator13 = 0.0
    self.Ishunt24  = 0.0
    self.Istator24 = 0.0
    self.Utotal = 0.0
    -- Calculate current through rheostats 1, 2
    self.IR1 = self.Itotal
    self.IR2 = self.Itotal
    self.IRT2 = self.Itotal
    self.T1 = 25
    self.T2 = 25
    self.P1 = 0
    self.P2 = 0
    self.Overheat1 = 0
    self.Overheat2 = 0

    -- Total energy used by train
    self.ElectricEnergyUsed = 0 -- joules
    self.ElectricEnergyDissipated = 0 -- joules
    self.EnergyChange = 0

    --Train wire outside power
    -- Need many iterations for engine simulation to converge
    self.SubIterations = 16

    self.Train:LoadSystem("KK","Relay","KPP-110",{ bass = true })
    self.Train:LoadSystem("BV","Relay")
    self.Train:LoadSystem("GV","Relay","GV_10ZH",{bass=true})


    --Регулятор давления
    self.Train:LoadSystem("RD","Relay","AK-11B")
    --self.Train:LoadSystem("Telemetry",nil,"",{"Electric","Panel","Engines"})
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

    local BKCU = Train.BKCU
    local BKVA = Train.BKVA
    local BUVS = Train.BUVS
    local BBE = Train.BBE
    local BKBD = Train.BKBD
    local RC = Train.RC.Value

    local Panel = Train.Panel

    S[303] = B*Train.VB.Value
    S[305] = clamp(B+T[50]*Train.SF2.Value)*Train.VB.Value
    --S[305] = S[303]
    S[315] = S[305]*Train.SF5.Value
    --S[310] = B*Train.VB.Value
    S[550] = S[305]*Train.SF2.Value --310
    Train:WriteTrainWire(50,S[550])
    S[316] = clamp(S[315]+T[50]) --+ДИОД
    --S[311] = B*Train.VB.Value
    S[334] = S[305]*Train.SF45.Value --311
    S[312] = S[305]*Train.SF3.Value --311
    BBE.KMPower = S[334]
    BBE.Power = S[305]
    Panel.V1 = S[312]

    --1.2. Цепи заряда аккумуляторной батареи. Включение ББЭ. Страница 7
    S[318] = S[316]*Train.SF7.Value
    S[518] = S[318]*Train.SB15.Value
    Train:WriteTrainWire(18,S[518])
    --S[324] = T[18]*Train.SF12.Value
    BBE.Activate = T[18]*Train.SF12.Value--S[324] --Включение ББЭ

    --1.4. Отключение ББЭ. Страница 8
    --S[519] = S[318]*Train.SB16.Value
    Train:WriteTrainWire(19,S[318]*Train.SB16.Value)
    --S[333] = T[19]*Train.SF13.Value

    --1.5. Аварийное отключение ББЭ и сигнализации Страница 9
    Train:WriteTrainWire(20,BBE.Error)
    Panel.HL7 = S[318]*T[20]
    BBE.Deactivate = T[19]*Train.SF13.Value --Включение ББЭ

    --2.1. Освещение вагонов основное. Страница 9
    --S[544] = S[318]*Train.SAP8.Value
    Train:WriteTrainWire(44,S[318]*Train.SAP8.Value)
    --S[538] = (1-Train.SAP8.Value)*T[44]
    Train:WriteTrainWire(38,(1-Train.SAP8.Value)*T[44])
    --S[340] = T[38]*Train.SF16.Value
    BBE.KM2Power = T[38]*Train.SF16.Value

    --S[408] = S[305]*BBE.KM2
    --S[409] = S[408]*Train.SF44.Value --END
    --305-BKM2-408-SF44-409
    Panel.EL7_30 = S[305]*BBE.KM2*Train.SF44.Value--S[409]

    --2.2. Аварийное освещение салонов и кабины. Страница 10
    --S[407] = S[312]*Train.SF44.Value
    Panel.EL3_6 = S[312]*Train.SF44.Value
    S[322] = T[50]*Train.SF11.Value
    Panel.EL1 = S[322]
    S[321] = T[50]*Train.SF10.Value
    --S[385] = S[321]*Train.SAP13.Value
    Panel.EL2 = S[321]*Train.SAP13.Value--S[385]
    --2.3. Освещение аппаратных отсеков. Страница 10
    --S[384] = S[322]*Train.SAP12.Value
    Panel.EL31 = S[322]*Train.SAP12.Value--S[384]
    --2.4. Подсветка прибора. Страница 10
    S[328] = T[50]*Train.SF72.Value
    --S[131] = S[328]*Train["SA4/1"].Value
    Panel.HL52 = S[328]*Train["SA4/1"].Value--S[131]
    Panel.VD1 = Train["SA5/1"].Value--S[131]
    Panel.RouteNumber = S[312]

    --3.1 Основное управление ЭК. Страница 11
    --S[531] = S[318]*(1-Train.SA16.Value)
    Train:WriteTrainWire(31,S[318]*(1-Train.SA16.Value)) --S[531]
    --S[410] = Train.SA16.Value*T[31] + Train.SF56.Value*T[55]    --3.3. Особенности управления ЭК в неполном составе. Страница 12
    --S[529] = S[410]*Train.SP1.Value
    --410-...-529
    Train:WriteTrainWire(29,clamp(Train.SA16.Value*T[31] + Train.SF56.Value*T[50])*Train.SP1.Value) --S[529]


    --3.2. Резервное управление ЭК. Страница 10
    S[320] = S[316]*Train.SF9.Value
    --S[530] = S[320]*Train.SB14.Value
    Train:WriteTrainWire(30,S[320]*Train.SB14.Value)--S[530]
    --S[348] = T[30]*Train.SF22.Value

    --S[347] = T[29]
    --BKVA.KM2 = (S[347]+S[348])--[[*тепловое реле]]
    BKVA.KM2 = clamp(T[29]+T[30]*Train.SF22.Value)--[[*тепловое реле]]

    --S[206] = self.Main750V > 200 and 1 or 0
    --S[208] = S[206]*BKVA.KM2
    --Train.KK:TriggerInput("Set",S[208])
    Train.KK:TriggerInput("Set",(self.Main750V > 200 and 1 or 0)*BKVA.KM2)--S[208]

    --4.1. Обогрев кабины. Страница 13
    --S[383] = S[321]*Train.SAP11.Value
    BKVA.KM1 = S[321]*Train.SAP11.Value--S[383]

    --5.1. Вентиляция салонов. Страница 13
    --[[ S[540] = S[321]*Train.SAP9.Value --Включение
    Train:WriteTrainWire(40,S[540])
    S[375] = T[40]*Train.SF23.Value
    BUVS.KM1 = S[375]
    S[307] = S[312]*Train.SF34.Value --Контроль
    S[379] = S[307]*BUVS.KM1
    BUVS.KV1 = S[379]
    S[542] = 1-BUVS.KV1 --Сигнализация
    Train:WriteTrainWire(42,S[542])
    Panel.VS1 = T[42]*S[321]

    S[541] = S[322]*Train.SAP10.Value --Включение
    Train:WriteTrainWire(41,S[541])
    S[377] = T[41]*Train.SF23.Value
    BUVS.KM2 = S[377]
    S[381] = S[307]*BUVS.KM2 --Контроль
    BUVS.KV2 = S[381]
    S[549] = 1-BUVS.KV2 --Сигнализация
    Train:WriteTrainWire(49,S[549])
    Panel.VS2 = T[49]*S[322]--]]
    S[307] = S[312]*Train.SF34.Value

    Train:WriteTrainWire(40,S[321]*Train.SAP9.Value)--Включение
    BUVS.KM1 = T[40]*Train.SF23.Value
    BUVS.KV1 = S[307]*BUVS.KM1 --Контроль
    Train:WriteTrainWire(42,1-BUVS.KV1)--Сигнализация
    Panel.VS1 = T[42]*S[321]

    Train:WriteTrainWire(41,S[322]*Train.SAP10.Value) --Включение
    BUVS.KM2 = T[41]*Train.SF23.Value
    BUVS.KV2 = S[307]*BUVS.KM2 --Контроль
    Train:WriteTrainWire(49,1-BUVS.KV2) --Сигнализация
    Panel.VS2 = T[49]*S[322]

    -- 5.2. Питание двигателя вентилятора кабины. Страница 13
    Panel.M1 = S[312]*Train.SF65.Value*Train.PVK.Value


    --6.1. Звуковая сигнализация. Страница 14
    --S[613] = B*(1-Train.VB.Value)
    --S[675] = S[613]*Train.SF55.Value
    --S[548] = S[318]*Train.SB5.Value + S[675]*Train.SP7.Value
    Train:WriteTrainWire(48,min(1,S[318]*Train.SB5.Value + B*(1-Train.VB.Value)*Train.SF55.Value*Train.SP7.Value+BKBD.Ring+Train.BZOS.VH2*0.4))
    Train.BZOS.Ring = min(1,S[318]*Train.SB5.Value+T[48])

    --6.3. Пожарная сигнализация. Страница 15 --TODO
    S[326] = T[50]*Train.SF76.Value
    --6.2. Охранная сигнализация. Страница 14
    Train.BZOS.Power = S[326]

    --7.2. Цепи "нулевого" положения КР и КРУ. Цепи габаритных фонарей. Страница 16
    S[317] = S[316]*Train.SF6.Value
    BKCU.KM3 = S[317]*Train.KRU["317-317A"]*Train.KR["317A-387"]*(1-BKCU.KM1)*(1-BKCU.KM2)
    S[320] = S[316]*Train.SF9.Value
    BKCU.KM7 = S[320]*Train.KRU["320A-393"]*(1-BKCU.KM5)*(1-BKCU.KM6)
    --S[366] = S[316]*Train.SF41.Value
    --Panel.H11 = S[366]*(1-BKCU.KM2)
    Panel.H11 = S[316]*Train.SF41.Value*(1-BKCU.KM2)

    --7.3. Цепи положения "ВПЕРЕД" КР. Страница 17
    S[3178] = S[317]*Train.KRU["317-317A"]*(1-BKCU.KM8)*(1-BKCU.KM4) --FIXME
    S[3174] = S[317]*Train.KRU["317-317A"]*(BKCU.KM1+BKCU.KM2)
    BKCU.KM2 = S[3178]*Train.KR["317B-388"]
    S[673] = S[316]*Train.SF51.Value
    --673-679 - Гребнесмазыватель
    --S[369] = S[316]*Train.SF8.Value*Train.KR["673-679"]

    --7.4. Цепи положения "НАЗАД" КР. Страница 17
    BKCU.KM1 = S[3178]*Train.KR["317B-386"]

    --7.5. Цепи положения "ВПЕРЕД" КРУ. Страница 17
    S[3208] = S[320]*Train.KR["320-320A"]*(1-BKCU.KM8)*(1-BKCU.KM4) --FIXME
    BKCU.KM6 = S[3208]*Train.KRU["320B-392"]
    --S[319] = S[316]*Train.SF8.Value
    --S[369] = S[319]*(Train.KR["319-369"]+Train.KRU["319-369"])
    S[369] = S[316]*Train.SF8.Value*clamp(Train.KR["319-369"]+Train.KRU["319-369"])

    S[680] = S[316]*Train.SF52.Value
    --S[620] = S[680]*Train.KRU["680-680A"] + S[673]*Train.KR["673-673A"]
    --BKBD.FMM1 = S[620]*Train.SF61.Value
    --611
    BKBD.FMM1 = (S[680]*Train.KRU["680-680A"] + S[673]*Train.KR["673-673A"])*Train.SF61.Value
    BKBD.GE = (BKBD.FMM1*Train.SA13.Value+T[87]*(1-Train.SA13.Value))*RC

    BKCU.KM5 = S[3208]*Train.KRU["320B-394"]

    --8.1. Открытие дверей. Страница 18
    --S[536] = S[369]*(Train.SB1.Value*(1-Train.SA7.Value)+Train.SA24.Value+Train.SBP4.Value)
    --Train:WriteTrainWire(36,S[536])
    Train:WriteTrainWire(36,S[369]*(Train.SB1.Value*(1-Train.SA7.Value)+Train.SA24.Value+Train.SBP4.Value))
    Panel.HL3 = S[369]*(1-Train.SA7.Value)
    --S[357] = T[36]*Train.SF18.Value+S[358]

    --8.1.4 Открытие правых дверей Страница 19
    --S[537] = S[369]*(Train.SB2.Value*Train.SA7.Value+Train.SBP6.Value)
    --Train:WriteTrainWire(37,S[537])
    Train:WriteTrainWire(37,S[369]*(Train.SB2.Value*Train.SA7.Value+Train.SBP6.Value))
    Panel.HL4 = S[369]*Train.SA7.Value
    --S[359] = T[37]*Train.SF20.Value+S[358]

    --8.2. Закрытие дверей. Страница 19
    --S[532] = S[369]*Train.SA5.Value*Train.SA6.Value
    --Train:WriteTrainWire(32,S[532])
    Train:WriteTrainWire(32,S[369]*Train.SA5.Value*Train.SA6.Value)

    --352-353-354
    S[354] =(1-BKVA.KM4)
    Train.U1:TriggerInput("Set", T[32]*S[354])

    --8.2.2
    --[[ S[533] = S[369]*Train.SB3.Value
    Train:WriteTrainWire(33,S[533])--]]
    Train:WriteTrainWire(33,S[369]*Train.SB3.Value)

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

    --312-KM2/1-534(-34)-Концевые каждого вагона(34)-Замкнутый КМ3 БКЦУ-36 провод
    --[[ S[534] = S[312]*(BKCU.KM1+BKCU.KM2)+S[320]*(BKCU.KM5+BKCU.KM6)*(1-BKCU.KM7)
    Train:WriteTrainWire(-34,S[534]) --Подача питания на 34 провод
    Train:WriteTrainWire(34,T[-34]*Train.SAD.Value) --Разрыв питания онцевых переключателей
    S[535] = T[34]*BKCU.KM3*BKCU.KM7
    Train:WriteTrainWire(35,S[535])--]]
    Train:WriteTrainWire(-34,clamp(S[312]*(BKCU.KM1+BKCU.KM2)+S[320]*(BKCU.KM5+BKCU.KM6)*(1-BKCU.KM7))) --Подача питания на 34 провод
    Train:WriteTrainWire(34,T[-34]*Train.SAD.Value) --Разрыв питания онцевых переключателей
    Train:WriteTrainWire(35,T[34]*BKCU.KM3*BKCU.KM7)

    Panel.SD = T[35]
    Panel.HL13 = S[312]*S[354]

    --9. БЛОКИРОВКА ПОСТОВ УПРАВЛЕНИЯ И ФОРМИРОВАНИЕ ЦЕПЕЙ УПРАВЛЕНИЯ ДВИЖЕНИЕМ СОСТАВА
    --Страница 20-21
    --317Г
    S[515] = S[317]*(BKCU.KM1+BKCU.KM2)-->V
    Train:WriteTrainWire(15,S[515])-->V
    BKCU.KM4 = T[15]*min(1,BKCU.KM3+BKCU.KM4)
    --320Г
    S[516] = S[320]*(BKCU.KM5+BKCU.KM6)-->V
    Train:WriteTrainWire(16,S[516])-->V
    BKCU.KM8 = T[16]*min(1,BKCU.KM7+BKCU.KM8)
    BUP.Power = S[3174]
    BUP.IKDV = max(0,BUP.Power*T[35])
    BUP.INKDV = BUP.Power*(1-BUP.IKDV)

    BUP.IBBUP = T[67]

    --9.4
    --[[ S[335] = T[15]*Train.SF14.Value
    S[337] = T[16]*Train.SF5.Value
    BKVA.KM3 = S[335]+S[337]--]]
    BKVA.KM3 = T[15]*Train.SF14.Value+T[16]*Train.SF5.Value

    --S[517] = (1-BKVA.KM3)
    Train:WriteTrainWire(17,(1-BKVA.KM3))--S[517]
    Panel.CUV = T[15]*T[17]--Питание с 15 провода и земля с 17

    --10. ЦЕПИ БЕЛЫХ ФАР И ЛАМП СИГНАЛИЗАЦИИ СТОЯНОЧНОГО ТОРМОЗА
    --Страница 322


    --316-SF41-365-KM2/6-390
    S[390] = S[316]*Train.SF41.Value*(BKCU.KM2+BKCU.KM6)
    --390-SA1/1(SA2/1)-367(368)-R9(R10)-HL17-19(HL20-22)
    S[512] = S[328]*Train.SQ1.Value
    Train:WriteTrainWire(12,S[512])
    Panel.HL46 = S[512]
    Panel.ST = T[12]

    Panel.HL17 = S[390]*Train["SA1/1"].Value
    Panel.HL20 = S[390]*Train["SA2/1"].Value
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

    --317Г + 320Г
    --S[522] = S[515]*Train.SB13.Value
    Train:WriteTrainWire(22,S[515]*Train.SB13.Value)--S[522]

    --11.4
    Train.BVA.Disable = T[22]
    --360А-Лампа-БУВ-725
    Panel.HL25 = S[3061]*BUV.ORP
    --Мы получаем землю
    S[528] = Panel.HL25*100+BUV.OIZ
    Train:WriteTrainWire(28,S[528])
    Panel.HL6 = T[28]
    Panel.TW28= S[528]

    --11.1.5
    --S[526] = (T[45]+T[54])*Train.SB12.Value
    Train:WriteTrainWire(26,(T[45]+T[54])*Train.SB12.Value)

    --12.2. Команды направления движения.
    BUP.IV = BUP.Power*S[317]*BKCU.KM2
    BUP.IN = BUP.Power*S[317]*BKCU.KM1

    --13.1. Формирование сигналов безопасности движения с включенной системой АРС.
    --626=363
    BKBD.FMM2 = S[390]
    S[626] = (BKBD.FMM1*Train.SA13.Value+T[87]*(1-Train.SA13.Value))*RC
    BKBD.Power = S[626]
    S[610] = clamp(Train.PB.Value*BKBD.FMM1 + (1-Train.SAP26.Value)*(S[626]+S[680]*Train.SA14.Value*(1-RC)))
    Train.RPB:TriggerInput("Set",S[610])
    BUP.IPB = BUP.Power*S[610]
    BUP.IARS = BUP.Power*(1-S[610])

    Train.ARS_RT:TriggerInput("Set",(T[6]+T[58])*RC)
    BKBD.DA = S[317]*(BKCU.KM1+BKCU.KM2+Train.ARS_RT.Value)*Train.SF53.Value--S["10AK"]*(KV["10AK-DA"]+Train.ARS_RT.Value)
    --13.2
    --[[ S[5908] = S[673]*(1-RC)
    S[5901] = S[5908]*Train.SF77.Value
    S[590] =  BKBD.Drive*RC + S[5901]*Train.SBR16.Value--]]
    Train:WriteTrainWire(90,BKBD.DA*RC*Train.BUM_RVD1.Value+S[673]*(1-RC)*Train.SF77.Value*Train.SB6.Value)
    Train:WriteTrainWire(89,BKBD.GE*Train.BUM_RVD2.Value*RC+S[680]*(1-RC)*Train.SF78.Value*(Train.SB6.Value+Train.SBR16.Value))
    Train.ROT1:TriggerInput("Set",T[90])
    Train.ROT2:TriggerInput("Set",T[89])
    --13.1
    BUP.IX = BUP.Power*T[90]
    BUP.IT = BUP.Power*T[07]
    BUP.IAVT = BUP.Power*T[14]
    Panel.KVD = T[87]*(1-Train.ROT2.Value)+BKBD.GE*(1-Train.BUM_RVD2.Value)

    --501Г-501В
    S[5012] = Train.ROT1.Value*BUP.OX
    S[5018] = S[5012]--*Train.UAVAContact.Value
    --501Б-501Е
    S[5016] = S[5018]*(Train.SP2.Value+Train.SA9.Value)
    S[5011] = S[5016]*(Train.SP5.Value+Train.SAP26.Value)
    S[501] = S[5011]*(Train.RPB.Value+Train.SA8.Value)
    --BUP.IX = S[501]
    BUP.IROT = BUP.Power*(1-S[5012])
    BUP.IPVU = BUP.Power*(1-S[5016])
    BUP.ISOT = BUP.Power*(1-S[5011])
    BUP.IRPB = BUP.Power*(1-S[501])
    Train:WriteTrainWire(1,S[501])

    Train.BSM_KRT:TriggerInput("Set",(T[2]+T[12])*RC)
    Train.BSM_KRH:TriggerInput("Set",(T[1]+T[55])*RC)
    Train.BSM_KRO:TriggerInput("Set",(T[45]+T[54])*RC)--(T[87]+S["7Ga"]*KV["7GA-RC27"]+S["14a"]*Train.A42.Value*(1-Train.KRP.Value))*(1-Train.BSM_KRH.Value))

    --S[649] = S[326]*(1-Train.SP2.Value)
    Panel.AVU = S[326]*(1-Train.SP2.Value)--S[649]

    --S[724] = S[515]*Train.SA2.Value
    --BUP.IBKDV = S[515]*Train.SA2.Value--S[724]
    BUP.IBKDV = BUP.Power*Train.SA2.Value


    --13.2. Формирование сигналов безопасности при отключении системы АРС. Страница 30
    --РПБ-
    --S[509] = BKBD.FMM1*(1-Train.RPB.Value)*(1-Train.SAP24.Value) + T[14]*Train.KRU["514-509"]--15.2
    Train:WriteTrainWire(09,BKBD.FMM1*(1-Train.RPB.Value)*(1-Train.SAP24.Value) + T[14]*Train.KRU["514-509"]) --S[509] --15.2
    --S[5091] = T[09]*Train.SF26.Value

    S[672] = S[316]*Train.SF60.Value
    --S[615]= S[672]*(Train.SA13.Value+Train.SA15.Value)
    --S[627] = S[672]*Train.SA15.Value
    BKBD.ALS = min(1,S[672]*(Train.SA13.Value+Train.SA15.Value))--S[615] --SA13???(13V)
    Train.BLPM.Power = BKBD.ALS*Train.SA15.Value
    BKBD.NGPower = S[673]*RC
    BKBD.Power75V = S[672]*Train.SA15.Value--S[627] --ALS???(75V)
    Train.BIS200.Power = BKBD.ALS*Train.SF50.Value--T[10]*Train.A43.Value*(Train.ALS.Value+Train.ARS.Value)
    Panel.Speedometer = S[316]*Train.SF50.Value


    --S[584] =  S[626]*Train.PB.Value + T[87]*Train.SA14.Value*Train.SB8.Value
    Train:WriteTrainWire(84,(S[626]+T[87]+T[83])*Train.PB.Value + T[87]*Train.SA14.Value*Train.SB8.Value)--S[584]
    BKBD.KB=T[84]*RC+(BKBD.ALS*(1-Train.BSM_GE.Value)+BKBD.GE*Train.BSM_GE.Value)*Train.SB9.Value

    --13.3 Формирование сигналов безопасности в режиме АРС-Р. Страница 31
    --[[ S[5875] = S[680]*Train.SA14.Value
    S[587] = S[5875]*(1-RC)
    Train:WriteTrainWire(87,S[587])--]]
    Train:WriteTrainWire(87,S[680]*Train.SA14.Value*(1-RC))


    --S[583] = S[606]*(1-Train.SA13.Value)
    S[606] = BKBD.EPK*RC
    Train:WriteTrainWire(83,S[606]*(1-Train.SA13.Value))--S[583]
    Train.U4:TriggerInput("Set",T[83]+S[606])

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

    --14.2. Резервное управление ходовыми режимами. Страница 34
    --[[ S[557] = S[320]*BKCU.KM6
    Train:WriteTrainWire(57,S[557])
    S[558] = S[320]*BKCU.KM5
    Train:WriteTrainWire(58,S[558])--]]
    Train:WriteTrainWire(57,S[320]*BKCU.KM6)
    Train:WriteTrainWire(58,S[320]*BKCU.KM5)

    --S[3205] = S[516]*(Train.ROT2.Value+Train.ROT1.Value)*Train.SP5.Value
    --S[555] = S[3205]*(Train.SBR14.Value+Train.SBR15.Value)
    S[555] = S[516]*(Train.ROT2.Value+Train.ROT1.Value)*--[[ Train.SP5.Value*--]] (Train.SBR14.Value+Train.SBR15.Value)
    Train:WriteTrainWire(55,S[555])
    --S[556] = S[555]*Train.SBR15.Value
    Train:WriteTrainWire(56,S[555]*Train.SBR15.Value)--S[556]
    --14.3. Режим "МАНЕВР". Страница 35
    --S[513] = S[515]*Train.SB7.Value
    Train:WriteTrainWire(13,S[515]*Train.SB7.Value)
    --15. УПРАВЛЕНИЕ СИЛОВЫМ ПРИВОДОМ В ТОРМОЗНЫХ РЕЖИМАХ Страница 36-37
    --КТ
    --БКБД головного-511-К4БУВС-БКБД хвостового
    --S[5092] = S[5091]+T[08]*(1-BUVS.KM3)
    --S[5092] = T[09]*Train.SF26.Value+T[08]*(1-BUVS.KM3)
    BUVS.KM3 = S[314]*BUV.ORMT
    BUVS.KM4 = S[314]*BUV.ORKT
    Train.U6:TriggerInput("Set",T[09]*Train.SF26.Value+T[08]*(1-BUVS.KM3))--S[5092]

    S["KT"] = S[673]*(1-Train.BSM_GE.Value)
    Train:WriteTrainWire(-11,S["KT"])
    BKBD.KT = T[11]*T[-11]*Train.BSM_GE.Value
    Train.BUM_KPP:TriggerInput("Set",S["KT"]*(1-Train.BSM_GE.Value)+BKBD.KT)
    Train:WriteTrainWire(11,BUVS.KM4+Train.SP4.Value)
    --S[5102] = T[10]+Train.SF29.Value*BUV.OV1
    Train.U7:TriggerInput("Set",T[10]+Train.SF29.Value*BUV.OV1)
    --15.2. Управление от АРС и контроль эффективности торможения. Страница 39
    --!!!7.5.4. замкнутыми контакта ми КРУ 514 КРУ → 509 КРУ объединяются цепи команд аварийного торможения ВЗ №2 от БКБД.
    --S[507] = S[626]*BKBD.Brake
    Train:WriteTrainWire(07,BKBD["20"]*RC)
    Train:WriteTrainWire(14,BKBD["8"]*RC)
    --16. ПЕРЕХОД В РЕЖИМ "ВЫБЕГ"
    --320Г-SB14/15
    --S[554] = S[516]*(1-Train.SBR14.Value)*(1-Train.SBR15.Value)
    Train:WriteTrainWire(54,S[516]*(1-Train.SBR14.Value)*(1-Train.SBR15.Value))--S[554]
    --17. РЕЖИМЫ РАБОТЫ ЭЛЕКТРИЧЕСКОЙ СХЕМЫ УПРАВЛЕНИЯ ВАГОНА И ЦЕПЕЙ КОНТРОЛЯ
    --[[ S[527] = S[318]*Train.SB4.Value
    Train:WriteTrainWire(27,S[527])
    S[523] = BUV.Power*BUV.OSN
    Train:WriteTrainWire(23,S[523])
    Panel.HL5 = S[318]*T[23]
    S[547] = S[515]*Train.SBP22.Value
    Train:WriteTrainWire(47,S[547])--]]
    Train:WriteTrainWire(27,S[318]*Train.SB4.Value)
    Train:WriteTrainWire(23,BUV.Power*BUV.OSN)
    Train:WriteTrainWire(47,S[515]*Train.SBP22.Value)
    Panel.HL5 = S[318]*T[23]

    --19. УПРАВЛЕНИЕ ОТЖАТИЕМ ТОКОПРИЕМНИКОВ
    --[[ S[524] = T[50]*((Train.VTPR.Value == 1 or Train.VTPR.Value == 2) and 1 or 0)
    S[525] = T[50]*((Train.VTPR.Value == 1 or Train.VTPR.Value == 3) and 1 or 0)
    S[559] = Train.VTPR.Value > 0 and 1 or 0
    Train:WriteTrainWire(24,S[524])
    Train:WriteTrainWire(25,S[525])
    Train:WriteTrainWire(59,S[559])--]]
    Train:WriteTrainWire(24,T[50]*((Train.VTPR.Value == 1 or Train.VTPR.Value == 2) and 1 or 0))
    Train:WriteTrainWire(25,T[50]*((Train.VTPR.Value == 1 or Train.VTPR.Value == 3) and 1 or 0))
    Train:WriteTrainWire(59,Train.VTPR.Value > 0 and 1 or 0)
    Train.U5:TriggerInput("Set",T[24]*T[59])

    --21
    local RRI_VV = Train.RRI_VV
    RRI_VV.Power = S[390]*Train.SF54.Value--*Train.SAP3.Value
    RRI_VV.AmplifierPower = RRI_VV.Power*Train.SAP3.Value
    Train:WriteTrainWire(51,RRI_VV.AmplifierPower*Train.RRI.LineOut)
    Train:WriteTrainWire(-51,RRI_VV.AmplifierPower*Train.BBE.KM1)
    RRI_VV.CabinSpeakerPower = RRI_VV.Power*Train.SAP39.Value*Train.RRI.LineOut
    Panel.AnnouncerPlaying = T[51]
    Panel.AnnouncerBuzz = T[-51]+RRI_VV.CabinSpeakerPower*Train.BBE.KM1

    Panel.KES = S[312]*Train.SAP36.Value
    --24. УПРАВЛЕНИЕ АППАРАТУРОЙ АРС ПРИ ДВИЖЕНИИ   СОСТАВА СО ВСПОМОГАТЕЛЬНЫМ ПОЕЗДОМ
    --[[ S[574] = BKBD.FMM1*Train.SAP23.Value
    Train:WriteTrainWire(74,S[574])
    S[588] = BKBD.FMM1*Train.SAP14.Value*(1-Train.SAP23.Value)
    Train:WriteTrainWire(88,S[588])--]]
    Train:WriteTrainWire(74,BKBD.FMM1*Train.SAP23.Value)
    BKBD.VP = T[74]
    Train:WriteTrainWire(88,BKBD.FMM1*Train.SAP14.Value*(1-Train.SAP23.Value))
    BKBD.PD = T[88]
    --Выдача сигналов БУП на поездные провода
    --Train:WriteTrainWire(01,BUP.OX)
    BUP.V0 = BUP.Power*RC*BKBD["48"]
    Train:WriteTrainWire(02,BUP.OT)
    Train:WriteTrainWire(03,BUP.OU1)
    Train:WriteTrainWire(04,BUP.OU2)
    Train:WriteTrainWire(05,BUP.OV)
    Train:WriteTrainWire(06,BUP.ON)
    Train:WriteTrainWire(08,BUP.OZPT*Train.SF40.Value)
    Train:WriteTrainWire(10,RC*BKBD["48"])
    Train:WriteTrainWire(45,BUP.O0)
    Train:WriteTrainWire(67,BUP.OBBUP)

    Panel.BOX = T[01]--OX
    Panel.BOT = T[02]--OT
    Panel.BOU1 = T[03]--OU1
    Panel.BOU2 = T[04]--OU2
    Panel.BOV = T[05]--OV
    Panel.BON = T[06]--ON
    Panel.BO0 = T[45]+T[54]--O0
    Panel.BOZPT = T[08]--OZPT
    --Panel.BOBBUP = T[67]--BOBBUP

    --Передача сигналов с поездных проводов в БУВ
    local BUVPower = BUV.Power
    BUV.IX     = --[[ BUVPower*--]] T[01]
    BUV.IT     = --[[ BUVPower*--]] T[02]
    BUV.IU1    = --[[ BUVPower*--]] T[03]
    BUV.IU2    = --[[ BUVPower*--]] T[04]
    BUV.IVP    = --[[ BUVPower*--]] T[05]
    BUV.INZ    = --[[ BUVPower*--]] T[06]
    BUV.ITARS  = --[[ BUVPower*--]] T[07]
    BUV.ITEM   = --[[ BUVPower*--]] T[14]
    BUV.IM     = --[[ BUVPower*--]] T[13]
    BUV.IVZ    = --[[ BUVPower*--]] T[26]
    BUV.IPROV  = --[[ BUVPower*--]] T[27]
    BUV.IPROV0 = --[[ BUVPower*--]] T[47]
    BUV.IXP    = --[[ BUVPower*--]] T[55]
    BUV.IU1R   = --[[ BUVPower*--]] T[56]
    BUV.IVR    = --[[ BUVPower*--]] T[57]
    BUV.INR    = --[[ BUVPower*--]] T[58]
    BUV.IAVR   = BUVPower*(1-Train.SP3.Value) --737-700 14.3. Режим "МАНЕВР".


    --25 Управление радиостанцией
    Panel.VPR = S[550]*Train.SF63.Value

    self.Schemes = S
end

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
--[[
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
        self.Overheat2 + math.max(0,(math.max(0,self.T2-750.0)/400.0)^2)*dT )--]]

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

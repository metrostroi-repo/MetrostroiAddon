--------------------------------------------------------------------------------
-- Internal systems simulation code
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("Gen_Int")

-- Node values
local S = {}
-- Converts boolean expression to a number
local function C(x) return x and 1 or 0 end

local min = math.min
local max = math.max


function TRAIN_SYSTEM.SolveEzh3(Train,Triggers)
	local P		= Train.PositionSwitch.SelectedPosition
	local RK	= Train.RheostatController.SelectedPosition
	local B		= (Train.Battery.Voltage > 55) and 1 or 0
	local T		= Train.SolverTemporaryVariables
	if not T then
		T = {}
		for i=1,100 do T[i] = 0 end
		Train.SolverTemporaryVariables = T
	end

	-- Solve all circuits
	--T["SDRK_ShortCircuit"] = -10*Train.RheostatController.RKP*(Train.RUT.Value+Train.RRT.Value+(1.0-Train.SR1.Value) )
	T["SDRK_ShortCircuit"] = -10*Train.RheostatController.RKP*(Train.RUT.Value+(1.0-Train.SR1.Value) )
	Triggers["SDRK_Shunt"]( 1.0 - (0.20+0.20*C((RK >= 2) and (RK <= 7))*C(P == 1))*Train.LK2.Value )
	S["33-33Aa"] = Train.KD.Value+Train.VAD.Value
	S["U2-20"] = Train.KV["U2-20a"]+Train.KV["U2-20b"]
	S["31V'-31V"] = Train.KDL.Value+Train.VDL.Value
	S["10AK-VAH1"] = Train.VAH.Value+Train.RPB.Value
	S["33B-33AVU"] = Train.AVU.Value+Train.OtklAVU.Value
	S["1T-1P"] = Train.NR.Value+Train.RPU.Value
	S["2Zh-2A"] = (1.0-Train.KSB1.Value)+(1.0-Train.TR1.Value)
	S["2Zh-2A"] = Train.ThyristorBU5_6.Value+S["2Zh-2A"]
	--S["2Zh-2A"] = Train.KSB2.Value+S["2Zh-2A"]
	S["8A-8Ye"] = C(RK == 1)+(1.0-Train.LK4.Value)
	S["15A-15B"] = Train.KV["15A-15B"]+Train.KD.Value
	S["10AYa-10E"] = (1.0-Train.LK3.Value)+Train.Rper.Value
	S["10AP-10AD"] = Train.LK2.Value+C((P == 3) or (P == 4))
	S["10AE-10B"] = Train.TR1.Value+Train.RV1.Value
	S["D1-32V"] = 1*Train.KDP.Value+Train.ALS_ARS["32"]
	S["TW[15]-15A"] = Train.KRU["15/2-D8"]*Train.KV["D8-15A"]+1
	S["1E-1Yu"] = Train.KSH2.Value+Train.KSB2.Value*Train.KSB1.Value
	S["2V-2G"] = C((RK >= 5) and (RK <= 18))+C((RK >= 2) and (RK <= 4))*Train.KSH1.Value
	S["10-8"] = Train.KV["10-8"]+(1.0-Train.VAH.Value)*Train.KV["FR1-10"]*(1.0-Train.RPB.Value)
	S["10AG-10AD"] = (1.0-Train.TR1.Value)*C((P == 2) or (P == 3) or (P == 4))*(1.0-Train.TR2.Value)+Train.TR2.Value*Train.TR1.Value*C((P == 1) or (P == 2) or (P == 4))
	S["1G-1Zh"] = Train.LK3.Value+C((P == 1) or (P == 3))*Train.LK5.Value*C(RK == 1)*S["1E-1Yu"]
	S["10N-10Zh"] = (1.0-Train.RRT.Value)*(1.0-Train.RUT.Value)*Train.SR1.Value+Train.RheostatController.RKM1
	S["10E-10AG"] = (1.0-Train.LK1.Value)*S["10AP-10AD"]*S["10AG-10AD"]+C(RK == 18)*C((P == 1))*Train.LK3.Value
	S["1A-1M"] = C((RK >= 1) and (RK <= 5))+C(RK == 6)*Train.RheostatController.RKM1
	S["2A-2G"] = C((P == 1) or (P == 3))*C((RK >= 1) and (RK <= 17))+C((P == 2) or (P == 4))*S["2V-2G"]
	S["D1-31V"] = Train.ALS_ARS["31"]+1*S["31V'-31V"]
	S["1A-1R"] = (1.0-Train.RV1.Value)*C((P == 1))+C((P == 2))*S["1A-1M"]
	S["10"] = 1*Train:ReadTrainWire(10)
	S["FR1/2"] = S["10"]*Train.KV["FR1-10"]
	S["15B"] = S["TW[15]-15A"]*S["15A-15B"]*Train:ReadTrainWire(15)
	S["10AL"] = S["10"]*Train.VU.Value
	S["10ALa"] = S["10AL"]*Train.VU3.Value
	S["Sh1-43"] = S["10AL"]*Train.ARS.Value--A45.Value
	S["10AS"] = S["10AL"]--*Train.A55.Value
	S["10AK"] = S["10AL"]--*Train.A54.Value --Pred:pr24
	S["6P"] = S["10AL"]--*Train.A61.Value
	S["6"] = S["6P"]*Train.RVT.Value
	S["2-7R-24"] = S["6P"]*(1.0-Train.AVU.Value)
	S["29"] = S["2-7R-24"]*(1.0-Train.OtklAVU.Value)+Train.ALS_ARS["29"]
	--????
	--23w*PR31+PR14*22
	S["22A"] = Train:ReadTrainWire(23)+T[6]--*Train.KU1.Value --Pred:PR20 --Train.A23.Value*1*Train:ReadTrainWire(23)+T[6]*Train.A22.Value
	S["10AN"] = (1.0-Train.RPvozvrat.Value)--*Train.A14.Value*1*1
	S["1-7R-8"] = S["10AS"]*Train.KV["10AS-U4"]*Train.VozvratRP.Value
	--S["1A"] = Train.A1.Value*(1-2*Train.RRP.Value)*((1-Train.RRP.Value) + Train.RRP.Value*Train.A39.Value)*Train:ReadTrainWire(1)
	--S["3A"] = Train.A3.Value*(1-2*Train.RRP.Value)*((1-Train.RRP.Value) + Train.RRP.Value*Train.A39.Value)*Train:ReadTrainWire(3)
	S["1A"] = (1-2*Train.RRP.Value)*((1-Train.RRP.Value) + Train.RRP.Value)*Train:ReadTrainWire(1)
	S["3A"] = (1-2*Train.RRP.Value)*((1-Train.RRP.Value) + Train.RRP.Value)*Train:ReadTrainWire(3)
	S["33V"] = S["10AK"]*Train.RV2.Value*S["10AK-VAH1"]*1*S["33B-33AVU"]
	S["1R"] = S["1A"]*S["1A-1R"]
	--S["20B"] = (1-2*Train.RRP.Value)*((1-Train.RRP.Value) + Train.RRP.Value*Train.A39.Value)*(1.0-Train.RPvozvrat.Value)*Train.A20.Value*Train:ReadTrainWire(20)
	S["20B"] = (1-2*Train.RRP.Value)*((1-Train.RRP.Value) + Train.RRP.Value)*(1.0-Train.RPvozvrat.Value)*Train:ReadTrainWire(20)
	S["4B"] = (1.0-Train.RKR.Value)*Train:ReadTrainWire(4)
	S["5B"] = Train.RKR.Value*Train:ReadTrainWire(5)
	S["5V"] = Train.RKR.Value*Train:ReadTrainWire(4)+T[8]*(1.0-Train.RKR.Value)
	S["5B'"] = S["5V"]*Train.LK3.Value
	S["6A"] = Train:ReadTrainWire(6)--Train.A6.Value*Train:ReadTrainWire(6)
	S["B12"] = 1*Train.VB.Value*B
	S["8A"] = Train:ReadTrainWire(8) --Pred:PR23 --Train.A8.Value*Train:ReadTrainWire(8)
	S["8Zh"] = S["8A"]*C((RK >= 17) and (RK <= 18))+T[10]*1
	S["12A"] = Train:ReadTrainWire(12)--Train.A12.Value*Train:ReadTrainWire(12)
	S["1"] = S["10AS"]*Train.R1_5.Value*Train.KV["10AS-33D"]*Train.ALS_ARS["33D"]+(-10*Train.KRU["1/3-ZM31"])
	S["8"] = S["10"]*S["10-8"]+Train.ALS_ARS["8"]
	S["16V"] = (1.0-Train.RD.Value)*Train:ReadTrainWire(16) --Train.A16.Value*(1.0-Train.RD.Value)*Train:ReadTrainWire(16)
	S["6Yu"] = S["6A"]*C((P == 3) or (P == 4))*C((RK >= 1) and (RK <= 2))
	S["17A"] = Train:ReadTrainWire(17) --Train.A17.Value*Train:ReadTrainWire(17)
	S["24V"] = (1.0-Train.LK4.Value)*Train:ReadTrainWire(24)
	--S["25A"] = Train.A25.Value*Train:ReadTrainWire(25)
	--S["27A"] = Train.A50.Value*Train:ReadTrainWire(27)
	--S["28A"] = Train.A51.Value*Train:ReadTrainWire(28)
	--S["31A"] = Train.A31.Value*Train:ReadTrainWire(31)+T[3]*1
	--S["32A"] = Train.A32.Value*Train:ReadTrainWire(32)+T[4]*1

	S["25A"] = Train:ReadTrainWire(25)
	S["27A"] = Train:ReadTrainWire(27)
	S["28A"] = Train:ReadTrainWire(28)
	S["31A"] = Train:ReadTrainWire(31)+T[3]*1
	S["32A"] = Train:ReadTrainWire(32)+T[4]*1
	S["B2"] = 1*Train.VB.Value*B
	--S["18A"] = (1.0-Train.RPvozvrat.Value)*Train.A14.Value*1+(-0.5*(1.0-Train.LK4.Value))
	S["18A"] = (1.0-Train.RPvozvrat.Value)+(-0.5*(1.0-Train.LK4.Value))
	S["B8"] = S["B2"]*Train.AV8B.Value
	S["B22"] = S["B8"]*Train.VU1.Value
	S["B28"] = S["B8"]*Train.KUP.Value
	S["36Ya"] = S["B8"]*Train.KVC.Value
	S["B13"] = S["B12"]--*Train.A24.Value
	S["B3"] = S["B2"]--*Train.A44.Value
	S["1-7R-29"] = S["B3"]*Train.RezMK.Value
	S["4"] = S["10AK"]*Train.KV["10AK-4"]+(-10*Train.KRU["5/3-ZM31"]*0 + Train.KRU["14/1-B3"]*S["B3"]*(1-Train.KRR.Value)*1)
	S["5"] = S["10AK"]*Train.KV["10AK-5"]+(-10*Train.KRU["5/3-ZM31"]*0 + Train.KRU["14/1-B3"]*S["B3"]*(Train.KRR.Value)*1)
	S["U2"] = S["10AS"]*Train.KV["U2-10AS"]
	S["24"] = S["U2"]*Train.KSN.Value
	S["2-7R-21"] = S["U2"]*1+(-1*max(0,Train:ReadTrainWire(18)))
	S["2"] = S["10AK"]*Train.KV["10AK-2"]+Train.ALS_ARS["2"]+(-10*Train.KRU["2/3-ZM31"])
	S["3"] = S["U2"]*Train.KV["U2-3"]+(-10*Train.KRU["3/3-ZM31"])
	S["33Aa"] = S["10AS"]*Train.KV["10AS-33"]*S["33-33Aa"]
	S["22V"] = S["22A"]*(1.0-Train.TRK.Value)
	--S["10/4"] = S["B12"]*Train.VB.Value*Train.A56.Value+(1-Train.VB.Value)*Train:ReadTrainWire(10)
	S["10/4"] = S["B12"]*Train.VB.Value+(1-Train.VB.Value)*Train:ReadTrainWire(10)
	S["1P"] = S["1A"]*C((P == 1) or (P == 2))*S["1T-1P"]+T[2]*C((P == 3) or (P == 4))
	S["25"] = S["U2"]*Train.KV["U2-25"]*Train.K25.Value
	S["1Zh"] = S["1P"]*Train.AVT.Value*(1.0-Train.RPvozvrat.Value)*S["1G-1Zh"]
	S["8G"] = S["8A"]*(1.0-Train.RT2.Value)*S["8A-8Ye"]
	S["11A"] = S["B2"]*(1.0-Train.RD.Value)
	S["1-7R-31"] = S["B3"]*Train.KRU["14/1-B3"]*Train.KRP.Value
	S["10AYa"] = S["B2"]--*Train.A80.Value
	S["10AE"] = S["B2"]--*Train.A30.Value
	S["20"] = S["U2"]*S["U2-20"]+Train.ALS_ARS["20"]+(-10*Train.KRU["20/3-ZM31"])
	S["10I"] = S["10AE"]*Train.RheostatController.RKM2
	S["10AH"] = S["10I"]*(1.0-Train.LK1.Value)+0
	S["10H"] = S["10I"]*Train.LK4.Value
	S["10B"] = S["10AE"]*S["10AE-10B"]
	S["10/4a"] = S["10/4"]*Train.VB.Value
	S["22K"] = S["10/4"]--*Train.A10.Value
	S["22E'"] = S["22K"]*Train.KU1.Value*Train.AK.Value*Train.AV8B.Value
	S["U0"] = S["10/4"]--*Train.A27.Value
	S["U0a"] = S["U0"]*1+(-10*S["10AN"])
	S["s3"] = S["U0"]*Train.DIPon.Value
	S["s10"] = S["U0"]*Train.DIPoff.Value
	S["F1"] = S["10/4"]*Train.KV["10/4-F1"]
	S["D4"] = S["10/4"]*(1.00-Train.KSD.Value)
	S["15"] = S["D4"]*Train.KV["D4-15"]+(-10*Train:ReadTrainWire(11)) + Train.KRU["14/1-B3"]*S["B3"]*20
	S["D4/3"] = S["D4"]*1
	--S["D1"] = S["10/4"]*Train.A21.Value*Train.KV["D-D1"]+(1*Train.KRU["11/3-D1/1"]*Train.KRU["14/1-B3"]*S["B3"])
	S["D1"] = S["10/4"]*Train.KV["D-D1"]+(1*Train.KRU["11/3-D1/1"]*Train.KRU["14/1-B3"]*S["B3"])
	S["11B"] = S["10/4"]*Train.KV["10/4-C3"]*(1.0-Train.NR.Value)+T[1]*1
	S["16"] = S["D1"]*Train.VUD1.Value*Train.VUD2.Value
	S["F2a"] = S["F1"]--*Train.A7.Value
	S["F1a"] = S["F1"]--*Train.A9.Value
	S["ST/1+ST/2"] = S["D4/3"]*Train.BPT.Value
	S["16V/1+16V/2"] = S["D4/3"]*(1.0-Train.RD.Value)
	S["D6/1"] = S["D4/3"]*Train.BD.Value
	S["1K"] = S["1Zh"]*C((P == 1) or (P == 2))
	S["1N"] = S["1Zh"]*C((P == 1) or (P == 3))
	S["10N"] = S["10AE"]*S["10N-10Zh"]*1+T["SDRK_ShortCircuit"]
	S["31V"] = S["D1"]*S["D1-31V"]
	S["10AG"] = S["10AYa"]*S["10E-10AG"]*S["10AYa-10E"]
	S["2Ye10AV"] = S["10AYa"]*(1.0-Train.LK3.Value)*C((RK >= 2) and (RK <= 18))*(1.0-Train.LK4.Value)+0
	S["32V"] = S["D1"]*S["D1-32V"]
	S["12"] = S["D1"]*Train.KRZD.Value
	S["F7"] = S["10"]*Train.KV["F7-10"]+(1*Train.KRU["11/3-FR1"]*Train.KRU["14/1-B3"]*S["B3"])
	S["F7/1"] = S["10"]*Train.KV["F7-10"]+(1*Train.KRU["11/3-FR1"]*Train.KRU["14/1-B3"]*S["B3"])
	S["33G"] = 1*Train.ALS_ARS["33G"]+S["U2"]*Train.KV["U2-33G"]
	--S["2Ye"] = Train.A2.Value*(1-2*Train.RRP.Value)*((1-Train.RRP.Value) + Train.RRP.Value*Train.A39.Value)*S["2Zh-2A"]*Train.LK4.Value*S["2A-2G"]*Train:ReadTrainWire(2)+(S["2Ye10AV"])
	S["2Ye"] = (1-2*Train.RRP.Value)*((1-Train.RRP.Value) + Train.RRP.Value)*S["2Zh-2A"]*Train.LK4.Value*S["2A-2G"]*Train:ReadTrainWire(2)+(S["2Ye10AV"])
	S["F13"] = S["F7"]--*Train.A46.Value
	S["F10"] = S["F7/1"]*Train.VUS.Value--*Train.A47.Value


	-- Call all triggers
	T[4] = min(1,S["12A"])
	Train.Panel["RedLightRight"] = S["F2a"]
	Train.RRP:TriggerInput("Set",Train:ReadTrainWire(14)*(1-Train.Rp8.Value))
	Train.RZ_2:TriggerInput("Set",S["24V"])
	Train.Panel["HeadLights2"] = S["F13"]
	Triggers["ReverserForward"](S["5B"])
	Train:WriteTrainWire(2,S["2"])
	Train.Panel["TrainDoors"] = S["16V/1+16V/2"]
	Train:WriteTrainWire(14,S["1-7R-31"])
	Train:WriteTrainWire(27,S["s3"])
	Train:WriteTrainWire(9,S["10/4a"])
	Train.RV1:TriggerInput("Set",S["2Ye"])
	Train.TR1:TriggerInput("Set",S["6A"])
	Train.SR1:TriggerInput("Set",S["2Ye"])
	Train.Panel["EmergencyLight"] = S["B12"]
	Triggers["XR3.4"](S["36Ya"])
	Train.Panel["AVU"] = S["2-7R-24"]
	Train.PneumaticNo2:TriggerInput("Set",S["8G"])
	Triggers["SDRK_Coil"](S["10B"])
	Train.RD:TriggerInput("Set",S["D6/1"])
	Triggers["XR3.6"](S["36Ya"])
	Train:WriteTrainWire(20,S["20"])
	Train:WriteTrainWire(32,S["32V"])
	T[6] = min(1,Train:ReadTrainWire(22))
	Train.KSH1:TriggerInput("Set",S["1R"])
	Train.Panel["KUP"] = S["B28"]
	Train:WriteTrainWire(23,S["1-7R-29"])
	Triggers["XR3.7"](S["36Ya"])
	Train.Panel["TrainBrakes"] = S["ST/1+ST/2"]
	Train:WriteTrainWire(31,S["31V"])
	Train.LK5:TriggerInput("Set",S["20B"])
	Train.LK1:TriggerInput("Set",S["1K"])
	Train:WriteTrainWire(4,S["4"])
	Train.VDOL:TriggerInput("Set",S["31A"])
	Triggers["SDRK"](S["10N"])
	Train.LK4:TriggerInput("Set",S["5B'"])
	Train:WriteTrainWire(16,S["16"])
	Train.R1_5:TriggerInput("Set",S["33V"])
	Train:WriteTrainWire(10,S["10/4a"])
	Triggers["XR3.2"](S["27A"])
	Train.KVC:TriggerInput("Set",S["B8"])
	T[8] = min(1,Train:ReadTrainWire(5))
	T[7] = min(1,S["5V"])
	Train.RVT:TriggerInput("Set",S["33G"])
	T[10] = min(1,Train:ReadTrainWire(29))
	Train.RPU:TriggerInput("Set",S["27A"])
	T[5] = min(1,S["22A"])
	Train:WriteTrainWire(25,S["25"])
	T[1] = min(1,S["28A"])
	Train.KK:TriggerInput("Set",S["22V"])
	Train:WriteTrainWire(5,S["5"])
	Triggers["RUTpod"](S["10H"])
	Train:WriteTrainWire(29,S["29"])
	Triggers["RRTpod"](S["10AH"])
	Train.Panel["GreenRP"] = S["U0a"]
	Triggers["SDPP"](S["10AG"])
	Train.Panel["CabinLight"] = S["10ALa"]
	T[2] = min(1,S["6A"])
	Triggers["XT3.1"](S["B13"])
	Triggers["XR3.3"](S["28A"])
	Train.KSB1:TriggerInput("Set",S["6Yu"])
	Triggers["RRTuderzh"](S["25A"])
	Train.Panel["V1"] = S["10/4"]
	Train.RR:TriggerInput("Set",S["1N"])
	T[3] = min(1,S["12A"])
	Train:WriteTrainWire(8,S["8"])
	Train:WriteTrainWire(1,S["1"])
	Train.Panel["SD"] = S["15B"]
	Train.TR2:TriggerInput("Set",S["6A"])
	Triggers["KPP"](S["27A"])
	Train:WriteTrainWire(24,S["24"])
	T[9] = min(1,S["8Zh"])
	Train:WriteTrainWire(3,S["3"])
	Train:WriteTrainWire(15,S["15"])
	Train.LK3:TriggerInput("Set",S["1Zh"])
	Train.KUP:TriggerInput("Set",S["B22"])
	Train.Rper:TriggerInput("Set",S["3A"])
	Train.Panel["RedRP"] = S["2-7R-21"]
	Train:WriteTrainWire(18,S["18A"])
	Triggers["RPvozvrat"](S["17A"])
	Train.VDZ:TriggerInput("Set",S["16V"])
	Train.Panel["RedLightLeft"] = S["F1a"]
	Train.KD:TriggerInput("Set",S["15B"])
	Train.LK2:TriggerInput("Set",S["20B"])
	Train.KSH2:TriggerInput("Set",S["1R"])
	Train.PneumaticNo1:TriggerInput("Set",S["8Zh"])
	Train.K25:TriggerInput("Set",Train.ALS_ARS["33Zh"])
	Train.KSB2:TriggerInput("Set",S["6Yu"])
	Train.RUP:TriggerInput("Set",S["6Yu"])
	Train:WriteTrainWire(17,S["1-7R-8"])
	Train.Panel["TrainRP"] = S["2-7R-21"]
	Train.Panel["Ring"] = S["11B"]
	Train:WriteTrainWire(28,S["s10"])
	Triggers["ReverserBackward"](S["4B"])
	Train.RV2:TriggerInput("Set",S["33Aa"])
	Train.Panel["HeadLights1"] = S["F10"]
	Train:WriteTrainWire(11,S["11A"])
	Train.Panel["HeadLights3"] = S["F13"]
	Train:WriteTrainWire(22,S["22E'"])
	Train.VDOP:TriggerInput("Set",S["32A"])
	Train:WriteTrainWire(6,S["6"])
	Train:WriteTrainWire(12,S["12"])
	return S
end

function TRAIN_SYSTEM.SolveEzh3RU1(Train,Triggers)
	local P		= Train.PositionSwitch.SelectedPosition
	local RK	= Train.RheostatController.SelectedPosition
	local B		= (Train.Battery.Voltage > 55) and 1 or 0
	local T		= Train.SolverTemporaryVariables
	if not T then
		T = {}
		for i=1,100 do T[i] = 0 end
		Train.SolverTemporaryVariables = T
	end

	-- Solve all circuits
	T["SDRK_ShortCircuit"] = -10*Train.RheostatController.RKP*(Train.RUT.Value+Train.RRT.Value+(1.0-Train.SR1.Value) )
	Triggers["SDRK_Shunt"]( 1.0 - (0.20+0.20*C((RK >= 2) and (RK <= 7))*C(P == 1))*Train.LK2.Value )
	S["33-33Aa"] = Train.KD.Value+Train.VAD.Value
	S["U2-20"] = Train.KV["U2-20a"]+Train.KV["U2-20b"]
	S["31V'-31V"] = (Train.KDL.Value+Train.VDL.Value)*(1-Train.ASNP31.Value)
	S["10AK-VAH1"] = Train.VAH.Value+Train.RPB.Value
	S["33B-33AVU"] = Train.AVU.Value+Train.OtklAVU.Value
	S["1T-1P"] = Train.NR.Value+Train.RPU.Value
	S["2Zh-2A"] = (1.0-Train.KSB1.Value)+(1.0-Train.TR1.Value)
	S["2Zh-2A"] = Train.ThyristorBU5_6.Value+S["2Zh-2A"]
	S["8A-8Ye"] = C(RK == 1)+(1.0-Train.LK4.Value)
	S["15A-15B"] = Train.KV["15A-15B"]+Train.KD.Value
	S["10AYa-10E"] = (1.0-Train.LK3.Value)+Train.Rper.Value
	S["10AP-10AD"] = Train.LK2.Value+C((P == 3) or (P == 4))
	S["10AE-10B"] = Train.TR1.Value+Train.RV1.Value
	S["D1-32V"] = (1*Train.KDP.Value+Train.ALS_ARS["32"])*(1-Train.ASNP32.Value)
	S["TW[15]-15A"] = Train.KRU["15/2-D8"]*Train.KV["D8-15A"]+1
	S["1E-1Yu"] = Train.KSH2.Value+Train.KSB2.Value*Train.KSB1.Value
	S["2V-2G"] = C((RK >= 5) and (RK <= 18))+C((RK >= 2) and (RK <= 4))*Train.KSH1.Value
	S["10-8"] = Train.KV["10-8"]+(1.0-Train.VAH.Value)*Train.KV["FR1-10"]*(1.0-Train.RPB.Value)
	S["10AG-10AD"] = (1.0-Train.TR1.Value)*C((P == 2) or (P == 3) or (P == 4))*(1.0-Train.TR2.Value)+Train.TR2.Value*Train.TR1.Value*C((P == 1) or (P == 2) or (P == 4))
	S["1G-1Zh"] = Train.LK3.Value+C((P == 1) or (P == 3))*Train.LK5.Value*C(RK == 1)*S["1E-1Yu"]
	S["10N-10Zh"] = (1.0-Train.RRT.Value)*(1.0-Train.RUT.Value)*Train.SR1.Value+Train.RheostatController.RKM1
	S["10E-10AG"] = (1.0-Train.LK1.Value)*S["10AP-10AD"]*S["10AG-10AD"]+C(RK == 18)*C((P == 1))*Train.LK3.Value
	S["1A-1M"] = C((RK >= 1) and (RK <= 5))+C(RK == 6)*Train.RheostatController.RKM1
	S["2A-2G"] = C((P == 1) or (P == 3))*C((RK >= 1) and (RK <= 17))+C((P == 2) or (P == 4))*S["2V-2G"]
	S["D1-31V"] = (Train.ALS_ARS["31"]+1*S["31V'-31V"])
	S["1A-1R"] = (1.0-Train.RV1.Value)*C((P == 1))+C((P == 2))*S["1A-1M"]
	S["10"] = 1*Train:ReadTrainWire(10)
	S["FR1/2"] = S["10"]*Train.KV["FR1-10"]
	S["15B"] = S["TW[15]-15A"]*S["15A-15B"]*Train:ReadTrainWire(15)
	S["10AL"] = S["10"]*Train.VU.Value
	Train.VU:TriggerInput("Check",S["10AL"]) if Train.VU.Value < 0.5 then S["10AL"] = 0 end
	S["10ALa"] = S["10AL"]*Train.A64.Value
	--Train.A64.TriggerInput("Check",S["10ALa"]) if Train.A64.Value < 0.5 then S["10ALa"] = 0 end --if Train.A.Value < 0.5 then S[""] = 0 end
	S["Sh1-43"] = S["10AL"]*Train.A45.Value
	--Train.A45.TriggerInput("Check",S["Sh1-43"]) if Train.A45.Value < 0.5 then S["Sh1-43"] = 0 end
	S["10AS"] = S["10AL"]*Train.A55.Value
	--Train.A55.TriggerInput("Check",S["10AS"]) if Train.A55.Value < 0.5 then S["10AS"] = 0 end
	S["10AK"] = S["10AL"]*Train.A54.Value
	--Train.A54.TriggerInput("Check",S["10AK"]) if Train.A54.Value < 0.5 then S["10AK"] = 0 end
	S["6P"] = S["10AL"]*Train.A61.Value
	--Train.A61.TriggerInput("Check",S["6P"]) if Train.A61.Value < 0.5 then S["6P"] = 0 end
	S["6"] = S["6P"]*Train.RVT.Value
	S["2-7R-24"] = S["6P"]*(1.0-Train.AVU.Value)
	S["29"] = S["2-7R-24"]*(1.0-Train.OtklAVU.Value)+Train.ALS_ARS["29"]
	S["22A"] = Train.A23.Value*1*Train:ReadTrainWire(23)+T[6]*Train.A22.Value
	--Train.A22.TriggerInput("Check",S["22A"]) if Train.A22.Value < 0.5 then S["22A"] = 0 end
	--Train.A23.TriggerInput("Check",S["22A"]) if Train.A23.Value < 0.5 then S["22A"] = 0 end
	S["10AN"] = (1.0-Train.RPvozvrat.Value)*Train.A14.Value*1*1
	--Train.A14.TriggerInput("Check",S["10AN"]) if Train.A14.Value < 0.5 then S["10AN"] = 0 end
	S["1-7R-8"] = S["10AS"]*Train.KV["10AS-U4"]*Train.VozvratRP.Value
	S["1A"] = Train.A1.Value*(1-2*Train.RRP.Value)*((1-Train.RRP.Value) + Train.RRP.Value*Train.A39.Value)*Train:ReadTrainWire(1)
	--Train.A1.TriggerInput("Check",S["1A"]) if Train.A1.Value < 0.5 then S["1A"] = 0 end
	--Train.A39.TriggerInput("Check",S["1A"]) if Train.A39.Value < 0.5 then S["1A"] = 0 end
	S["3A"] = Train.A3.Value*(1-2*Train.RRP.Value)*((1-Train.RRP.Value) + Train.RRP.Value*Train.A39.Value)*Train:ReadTrainWire(3)
	--Train.A1.TriggerInput("Check",S["3A"]) if Train.A1.Value < 0.5 then S["3A"] = 0 end
	--Train.A39.TriggerInput("Check",S["3A"]) if Train.A39.Value < 0.5 then S["3A"] = 0 end
	S["33V"] = S["10AK"]*Train.RV2.Value*S["10AK-VAH1"]*1*S["33B-33AVU"]
	S["1R"] = S["1A"]*S["1A-1R"]
	S["20B"] = (1-2*Train.RRP.Value)*((1-Train.RRP.Value) + Train.RRP.Value*Train.A39.Value)*(1.0-Train.RPvozvrat.Value)*Train.A20.Value*Train:ReadTrainWire(20)
	--Train.A39.TriggerInput("Check",S["20B"]) if Train.A39.Value < 0.5 then S["20B"] = 0 end
	--Train.A20.TriggerInput("Check",S["20B"]) if Train.A20.Value < 0.5 then S["20B"] = 0 end
	S["4B"] = (1.0-Train.RKR.Value)*Train:ReadTrainWire(4)
	S["5B"] = Train.RKR.Value*Train:ReadTrainWire(5)
	S["5V"] = Train.RKR.Value*Train:ReadTrainWire(4)+T[8]*(1.0-Train.RKR.Value)
	S["5B'"] = S["5V"]*Train.LK3.Value
	S["6A"] = Train.A6.Value*Train:ReadTrainWire(6)
	--Train.A6.TriggerInput("Check",S["6A"]) if Train.A6.Value < 0.5 then S["6A"] = 0 end
	S["B12"] = 1*Train.VB.Value*B
	S["8A"] = Train.A8.Value*Train:ReadTrainWire(8)
	--Train.A8.TriggerInput("Check",S["8A"]) if Train.A8.Value < 0.5 then S["8A"] = 0 end
	S["8Zh"] = S["8A"]*C((RK >= 17) and (RK <= 18))+T[10]*1
	S["12A"] = Train.A12.Value*Train:ReadTrainWire(12)
	--Train.A12.TriggerInput("Check",S["12A"]) if Train.A12.Value < 0.5 then S["12A"] = 0 end
	S["1"] = S["10AS"]*Train.R1_5.Value*Train.KV["10AS-33D"]*Train.ALS_ARS["33D"]+(-10*Train.KRU["1/3-ZM31"])
	S["8"] = S["10"]*S["10-8"]+Train.ALS_ARS["8"]
	S["16V"] = Train.A16.Value*(1.0-Train.RD.Value)*Train:ReadTrainWire(16)
	--Train.A16.TriggerInput("Check",S["16V"]) if Train.A16.Value < 0.5 then S["16V"] = 0 end
	S["6Yu"] = S["6A"]*C((P == 3) or (P == 4))*C((RK >= 1) and (RK <= 2))
	S["17A"] = Train.A17.Value*Train:ReadTrainWire(17)
	--Train.A17.TriggerInput("Check",S["17A"]) if Train.A17.Value < 0.5 then S["17A"] = 0 end
	S["24V"] = (1.0-Train.LK4.Value)*Train:ReadTrainWire(24)
	--Train.A24.TriggerInput("Check",S["24V"]) if Train.A24.Value < 0.5 then S["24V"] = 0 end
	S["25A"] = Train.A25.Value*Train:ReadTrainWire(25)
	--Train.A25.TriggerInput("Check",S["25A"]) if Train.A25.Value < 0.5 then S["25A"] = 0 end
	S["27A"] = Train.A50.Value*Train:ReadTrainWire(27)
	--Train.A50.TriggerInput("Check",S["27A"]) if Train.A50.Value < 0.5 then S["27A"] = 0 end
	S["28A"] = Train.A51.Value*Train:ReadTrainWire(28)
	--Train.A51.TriggerInput("Check",S["28A"]) if Train.A51.Value < 0.5 then S["28A"] = 0 end
	S["31A"] = Train.A31.Value*Train:ReadTrainWire(31)+T[3]*1
	--Train.A31.TriggerInput("Check",S["31A"]) if Train.A31.Value < 0.5 then S["31A"] = 0 end
	S["32A"] = Train.A32.Value*Train:ReadTrainWire(32)+T[4]*1
	--Train.A32.TriggerInput("Check",S["32A"]) if Train.A32.Value < 0.5 then S["32A"] = 0 end
	S["B2"] = 1*Train.VB.Value*B
	S["18A"] = (1.0-Train.RPvozvrat.Value)*Train.A14.Value*1+(-0.5*(1.0-Train.LK4.Value))
	--Train.A14.TriggerInput("Check",S["18A"]) if Train.A14.Value < 0.5 then S["18A"] = 0 end
	S["B8"] = S["B2"]*Train.A53.Value
	--Train.A53.TriggerInput("Check",S["B8"]) if Train.A53.Value < 0.5 then S["B8"] = 0 end
	S["B22"] = S["B8"]*Train.A75.Value
	--Train.A75.TriggerInput("Check",S["B22"]) if Train.A75.Value < 0.5 then S["B22"] = 0 end
	S["B28"] = S["B8"]*Train.KUP.Value
	S["36Ya"] = S["B8"]*Train.KVC.Value
	S["B13"] = S["B12"]*Train.A24.Value
	--Train.A24.TriggerInput("Check",S["B13"]) if Train.A24.Value < 0.5 then S["B13"] = 0 end
	S["B3"] = S["B2"]*Train.A44.Value
	--Train.A44.TriggerInput("Check",S["B3"]) if Train.A44.Value < 0.5 then S["B3"] = 0 end
	S["1-7R-29"] = S["B3"]*Train.RezMK.Value
	S["4"] = S["10AK"]*Train.KV["10AK-4"]
	S["5"] = S["10AK"]*Train.KV["10AK-5"]+(-10*Train.KRU["5/3-ZM31"]*0 + Train.KRU["14/1-B3"]*S["B3"]*1)
	S["U2"] = S["10AS"]*Train.KV["U2-10AS"]
	S["24"] = S["U2"]*Train.KSN.Value
	S["2-7R-21"] = S["U2"]*1+(-1*max(0,Train:ReadTrainWire(18)))
	S["2"] = S["10AK"]*Train.KV["10AK-2"]+Train.ALS_ARS["2"]+(-10*Train.KRU["2/3-ZM31"])
	S["3"] = S["U2"]*Train.KV["U2-3"]+(-10*Train.KRU["3/3-ZM31"])
	S["33Aa"] = S["10AS"]*Train.KV["10AS-33"]*S["33-33Aa"]
	S["22V"] = S["22A"]*(1.0-Train.TRK.Value)
	S["10/4"] = S["B12"]*Train.VB.Value*Train.A56.Value+(1-Train.VB.Value)*Train:ReadTrainWire(10)
	--Train.A56.TriggerInput("Check",S["10/4"]) if Train.A56.Value < 0.5 then S["10/4"] = 0 end
	S["1P"] = S["1A"]*C((P == 1) or (P == 2))*S["1T-1P"]+T[2]*C((P == 3) or (P == 4))
	S["25"] = S["U2"]*Train.KV["U2-25"]*Train.K25.Value
	S["1Zh"] = S["1P"]*Train.AVT.Value*(1.0-Train.RPvozvrat.Value)*S["1G-1Zh"]
	S["8G"] = S["8A"]*(1.0-Train.RT2.Value)*S["8A-8Ye"]
	S["11A"] = S["B2"]*(1.0-Train.RD.Value)
	S["1-7R-31"] = S["B3"]*Train.KRU["14/1-B3"]*Train.KRP.Value
	S["10AYa"] = S["B2"]*Train.A80.Value
	--Train.A80.TriggerInput("Check",S["10AYa"]) if Train.A80.Value < 0.5 then S["10AYa"] = 0 end
	S["10AE"] = S["B2"]*Train.A30.Value
	--Train.A30.TriggerInput("Check",S["10AE"]) if Train.A30.Value < 0.5 then S["10AE"] = 0 end
	S["20"] = S["U2"]*S["U2-20"]+Train.ALS_ARS["20"]+(-10*Train.KRU["20/3-ZM31"])
	S["10I"] = S["10AE"]*Train.RheostatController.RKM2
	S["10AH"] = S["10I"]*(1.0-Train.LK1.Value)+0
	S["10H"] = S["10I"]*Train.LK4.Value
	S["10B"] = S["10AE"]*S["10AE-10B"]
	S["10/4a"] = S["10/4"]*Train.VB.Value
	S["22K"] = S["10/4"]*Train.A10.Value
	--Train.A10.TriggerInput("Check",S["22K"]) if Train.A10.Value < 0.5 then S["22K"] = 0 end
	S["22E'"] = S["22K"]*Train.VMK.Value*Train.AK.Value
	S["U0"] = S["10/4"]*Train.A27.Value
	--Train.A27.TriggerInput("Check",S["U0"]) if Train.A27.Value < 0.5 then S["U0"] = 0 end
	S["U0a"] = S["U0"]*1+(-10*S["10AN"])
	S["s3"] = S["U0"]*Train.DIPon.Value
	S["s10"] = S["U0"]*Train.DIPoff.Value
	S["F1"] = S["10/4"]*Train.KV["10/4-F1"]
	S["D4"] = S["10/4"]*Train.A13.Value
	--Train.A13.TriggerInput("Check",S["D4"]) if Train.A13.Value < 0.5 then S["D4"] = 0 end
	S["15"] = S["D4"]*Train.KV["D4-15"]+(-10*Train:ReadTrainWire(11)) + Train.KRU["14/1-B3"]*S["B3"]*20
	S["D4/3"] = S["D4"]*1
	S["D1"] = S["10/4"]*Train.A21.Value*Train.KV["D-D1"]+(1*Train.KRU["11/3-D1/1"]*Train.KRU["14/1-B3"]*S["B3"])
	--Train.A21.TriggerInput("Check",S["D1"]) if Train.A21.Value < 0.5 then S["D1"] = 0 end
	S["11B"] = S["10/4"]*Train.KV["10/4-C3"]*(1.0-Train.NR.Value)+T[1]*1
	S["16"] = S["D1"]*Train.VUD1.Value*Train.VUD2.Value
	S["F2a"] = S["F1"]*Train.A7.Value
	--Train.A7.TriggerInput("Check",S["F2a"]) if Train.A7.Value < 0.5 then S["F2a"] = 0 end
	S["F1a"] = S["F1"]*Train.A9.Value
	--Train.A9.TriggerInput("Check",S["F1a"]) if Train.A9.Value < 0.5 then S["F1a"] = 0 end
	S["ST/1+ST/2"] = S["D4/3"]*Train.BPT.Value
	S["16V/1+16V/2"] = S["D4/3"]*(1.0-Train.RD.Value)
	S["D6/1"] = S["D4/3"]*Train.BD.Value
	S["1K"] = S["1Zh"]*C((P == 1) or (P == 2))
	S["1N"] = S["1Zh"]*C((P == 1) or (P == 3))
	S["10N"] = S["10AE"]*S["10N-10Zh"]*1+T["SDRK_ShortCircuit"]
	S["31V"] = S["D1"]*S["D1-31V"]
	S["10AG"] = S["10AYa"]*S["10E-10AG"]*S["10AYa-10E"]
	S["2Ye10AV"] = S["10AYa"]*(1.0-Train.LK3.Value)*C((RK >= 2) and (RK <= 18))*(1.0-Train.LK4.Value)+0
	S["32V"] = S["D1"]*S["D1-32V"]
	S["12"] = S["D1"]*Train.KRZD.Value
	S["F7"] = S["10"]*Train.KV["F7-10"]+(1*Train.KRU["11/3-FR1"]*Train.KRU["14/1-B3"]*S["B3"])
	S["F7/1"] = S["10"]*Train.KV["F7-10"]+(1*Train.KRU["11/3-FR1"]*Train.KRU["14/1-B3"]*S["B3"])
	S["33G"] = 1*Train.ALS_ARS["33G"]+S["U2"]*Train.KV["U2-33G"]
	S["2Ye"] = Train.A2.Value*(1-2*Train.RRP.Value)*((1-Train.RRP.Value) + Train.RRP.Value*Train.A39.Value)*S["2Zh-2A"]*Train.LK4.Value*S["2A-2G"]*Train:ReadTrainWire(2)+(S["2Ye10AV"])
	--Train.A2.TriggerInput("Check",S["2Ye"]) if Train.A2.Value < 0.5 then S["2Ye"] = 0 end
	--Train.A39.TriggerInput("Check",S["2Ye"]) if Train.A39.Value < 0.5 then S["2Ye"] = 0 end
	S["F13"] = S["F7"]*Train.A46.Value
	--Train.A46.TriggerInput("Check",S["F13"]) if Train.A46.Value < 0.5 then S["F13"] = 0 end
	S["F10"] = S["F7/1"]*Train.VUS.Value*Train.A47.Value
	--Train.A47.TriggerInput("Check",S["F10"]) if Train.A47.Value < 0.5 then S["F10"] = 0 end
	--Train.A.TriggerInput("Check",S[""])

	-- Call all triggers
	T[4] = min(1,S["12A"])
	Train.Panel["RedLightRight"] = S["F2a"]
	Train.RRP:TriggerInput("Set",Train:ReadTrainWire(14)*(1-Train.Rp8.Value))
	Train.RZ_2:TriggerInput("Set",S["24V"])
	Train.Panel["HeadLights2"] = S["F13"]
	Triggers["ReverserForward"](S["5B"])
	Train:WriteTrainWire(2,S["2"])
	Train.Panel["TrainDoors"] = S["16V/1+16V/2"]
	Train:WriteTrainWire(14,S["1-7R-31"])
	Train:WriteTrainWire(27,S["s3"])
	Train:WriteTrainWire(9,S["10/4a"])
	Train.RV1:TriggerInput("Set",S["2Ye"])
	Train.TR1:TriggerInput("Set",S["6A"])
	Train.SR1:TriggerInput("Set",S["2Ye"])
	Train.Panel["EmergencyLight"] = S["B12"]
	Triggers["XR3.4"](S["36Ya"])
	Train.Panel["AVU"] = S["2-7R-24"]
	Train.PneumaticNo2:TriggerInput("Set",S["8G"])
	Triggers["SDRK_Coil"](S["10B"])
	Train.RD:TriggerInput("Set",S["D6/1"])
	Triggers["XR3.6"](S["36Ya"])
	Train:WriteTrainWire(20,S["20"])
	Train:WriteTrainWire(32,S["32V"])
	T[6] = min(1,Train:ReadTrainWire(22))
	Train.KSH1:TriggerInput("Set",S["1R"])
	Train.Panel["KUP"] = S["B28"]
	Train:WriteTrainWire(23,S["1-7R-29"])
	Triggers["XR3.7"](S["36Ya"])
	Train.Panel["TrainBrakes"] = S["ST/1+ST/2"]
	Train:WriteTrainWire(31,S["31V"])
	Train.LK5:TriggerInput("Set",S["20B"])
	Train.LK1:TriggerInput("Set",S["1K"])
	Train:WriteTrainWire(4,S["4"])
	Train.VDOL:TriggerInput("Set",S["31A"])
	Triggers["SDRK"](S["10N"])
	Train.LK4:TriggerInput("Set",S["5B'"])
	Train:WriteTrainWire(16,S["16"])
	Train.R1_5:TriggerInput("Set",S["33V"])
	Train:WriteTrainWire(10,S["10/4a"])
	Triggers["XR3.2"](S["27A"])
	Train.KVC:TriggerInput("Set",S["B8"])
	T[8] = min(1,Train:ReadTrainWire(5))
	T[7] = min(1,S["5V"])
	Train.RVT:TriggerInput("Set",S["33G"])
	T[10] = min(1,Train:ReadTrainWire(29))
	Train.RPU:TriggerInput("Set",S["27A"])
	T[5] = min(1,S["22A"])
	Train:WriteTrainWire(25,S["25"])
	T[1] = min(1,S["27A"])
	Train.KK:TriggerInput("Set",S["22V"])
	Train:WriteTrainWire(5,S["5"])
	Triggers["RUTpod"](S["10H"])
	Train:WriteTrainWire(29,S["29"])
	Triggers["RRTpod"](S["10AH"])
	Train.Panel["GreenRP"] = S["U0a"]
	Triggers["SDPP"](S["10AG"])
	Train.Panel["CabinLight"] = S["10ALa"]
	T[2] = min(1,S["6A"])
	Triggers["XT3.1"](S["B13"])
	Triggers["XR3.3"](S["28A"])
	Train.KSB1:TriggerInput("Set",S["6Yu"])
	Triggers["RRTuderzh"](S["25A"])
	Train.Panel["V1"] = S["10/4"]
	Train.RR:TriggerInput("Set",S["1N"])
	T[3] = min(1,S["12A"])
	Train:WriteTrainWire(8,S["8"])
	Train:WriteTrainWire(1,S["1"])
	Train.Panel["SD"] = S["15B"]
	Train.TR2:TriggerInput("Set",S["6A"])
	Triggers["KPP"](S["27A"])
	Train:WriteTrainWire(24,S["24"])
	T[9] = min(1,S["8Zh"])
	Train:WriteTrainWire(3,S["3"])
	Train:WriteTrainWire(15,S["15"])
	Train.LK3:TriggerInput("Set",S["1Zh"])
	Train.KUP:TriggerInput("Set",S["B22"])
	Train.Rper:TriggerInput("Set",S["3A"])
	Train.Panel["RedRP"] = S["2-7R-21"]
	Train:WriteTrainWire(18,S["18A"])
	Triggers["RPvozvrat"](S["17A"])
	Train.VDZ:TriggerInput("Set",S["16V"])
	Train.Panel["RedLightLeft"] = S["F1a"]
	Train.KD:TriggerInput("Set",S["15B"])
	Train.LK2:TriggerInput("Set",S["20B"])
	Train.KSH2:TriggerInput("Set",S["1R"])
	Train.PneumaticNo1:TriggerInput("Set",S["8Zh"])
	Train.K25:TriggerInput("Set",Train.ALS_ARS["33Zh"])
	Train.KSB2:TriggerInput("Set",S["6Yu"])
	Train.RUP:TriggerInput("Set",S["6Yu"])
	Train:WriteTrainWire(17,S["1-7R-8"])
	Train.Panel["TrainRP"] = S["2-7R-21"]
	Train.Panel["Ring"] = S["11B"]
	Train:WriteTrainWire(28,S["s10"])
	Triggers["ReverserBackward"](S["4B"])
	Train.RV2:TriggerInput("Set",S["33Aa"])
	Train.Panel["HeadLights1"] = S["F10"]
	Train:WriteTrainWire(11,S["11A"])
	Train.Panel["HeadLights3"] = S["F13"]
	Train:WriteTrainWire(22,S["22E'"])
	Train.VDOP:TriggerInput("Set",S["32A"])
	Train:WriteTrainWire(6,S["6"])
	Train:WriteTrainWire(12,S["12"])
	return S
end

function TRAIN_SYSTEM.SolveEma508(Train,Triggers)
	local P		= Train.PositionSwitch.SelectedPosition
	local RK	= Train.RheostatController.SelectedPosition
	local B		= (Train.Battery.Voltage > 55) and 1 or 0
	local T		= Train.SolverTemporaryVariables
	if not T then
		T = {}
		for i=1,100 do T[i] = 0 end
		Train.SolverTemporaryVariables = T
	end

	-- Solve all circuits
	T["SDRK_ShortCircuit"] = -10*Train.RheostatController.RKP*(Train.RUT.Value+Train.RRT.Value+(1.0-Train.SR1.Value) )
	Triggers["SDRK_Shunt"]( 1.0 - (0.20+0.20*C((RK >= 2) and (RK <= 7))*C(P == 1))*Train.LK2.Value )
	S["1T-1P"] = Train.NR.Value+Train.RPU.Value
	S["2Zh-2A"] = (1.0-Train.KSB1.Value)+(1.0-Train.TR1.Value)
	S["2Zh-2A"] = Train.ThyristorBU5_6.Value+S["2Zh-2A"]
	S["8A-8Ye"] = C(RK == 1)+(1.0-Train.LK4.Value)
	S["10AYa-10E"] = (1.0-Train.LK3.Value)+Train.Rper.Value
	S["10AP-10AD"] = Train.LK2.Value+C((P == 3) or (P == 4))
	S["10AE-10B"] = Train.TR1.Value+Train.RV1.Value
	S["2V-2G"] = C((RK >= 5) and (RK <= 18))+C((RK >= 2) and (RK <= 4))*Train.KSH1.Value
	S["1E-1Yu"] = Train.KSH2.Value+Train.KSB2.Value*Train.KSB1.Value
	S["10Zh-10N"] = Train.RheostatController.RKM1+(1.0-Train.RUT.Value)*Train.SR1.Value*(1.0-Train.RRT.Value)
	S["1G-1Zh"] = Train.LK3.Value+C((P == 1) or (P == 3))*Train.LK5.Value*C(RK == 1)*S["1E-1Yu"]
	S["10AG-10AD"] = C((P == 2) or (P == 3) or (P == 4))*(1.0-Train.TR2.Value)*(1.0-Train.TR1.Value)+Train.TR2.Value*Train.TR1.Value*C((P == 1) or (P == 2) or (P == 4))
	S["1A-1M"] = C((RK >= 1) and (RK <= 5))+C(RK == 6)*Train.RheostatController.RKM1
	S["10E-10AG"] = Train.LK3.Value*C(RK == 18)*C((P == 1))+S["10AG-10AD"]*S["10AP-10AD"]*(1.0-Train.LK1.Value)
	S["1A-1R"] = (1.0-Train.RV1.Value)*C((P == 1))+C((P == 2))*S["1A-1M"]
	S["2A-2G"] = C((P == 2) or (P == 4))*S["2V-2G"]+C((P == 1) or (P == 3))*C((RK >= 1) and (RK <= 17))
	S["10"] = 1*Train:ReadTrainWire(10)
	S["3A"] = Train.A3.Value*(1-2*Train.RRP.Value)*((1-Train.RRP.Value) + Train.RRP.Value*Train.A39.Value)*Train:ReadTrainWire(3)
	S["4B"] = (1.0-Train.RKR.Value)*Train:ReadTrainWire(4)
	S["5B"] = Train.RKR.Value*Train:ReadTrainWire(5)
	S["5V"] = Train.RKR.Value*Train:ReadTrainWire(4)+T[37]*(1.0-Train.RKR.Value)
	S["5B'"] = S["5V"]*Train.LK3.Value
	S["6A"] = Train.A6.Value*Train:ReadTrainWire(6)
	S["8A"] = Train.A8.Value*Train:ReadTrainWire(8)
	S["8Zh"] = S["8A"]*C((RK >= 17) and (RK <= 18))+T[39]*1
	S["12A"] = Train.A12.Value*Train:ReadTrainWire(12)
	S["10AN"] = 1*(1.0-Train.RPvozvrat.Value)*Train.A14.Value*1
	S["16V"] = Train.A16.Value*(1.0-Train.RD.Value)*Train:ReadTrainWire(16)
	S["1A"] = Train.A1.Value*(1-2*Train.RRP.Value)*((1-Train.RRP.Value) + Train.RRP.Value*Train.A39.Value)*Train:ReadTrainWire(1)
	S["17A"] = Train.A17.Value*Train:ReadTrainWire(17)
	S["6Yu"] = S["6A"]*C((P == 3) or (P == 4))*C((RK >= 1) and (RK <= 2))
	S["24V"] = (1.0-Train.LK4.Value)*Train:ReadTrainWire(24)
	S["25A"] = Train.A25.Value*Train:ReadTrainWire(25)
	S["27A"] = Train.A50.Value*Train:ReadTrainWire(27)
	S["28A"] = Train.A51.Value*Train:ReadTrainWire(28)
	S["31A"] = Train.A31.Value*Train:ReadTrainWire(31)+T[32]*1
	S["32A"] = Train.A32.Value*Train:ReadTrainWire(32)+T[33]*1
	S["18A"] = (1.0-Train.RPvozvrat.Value)*Train.A14.Value*1+(-0.5*(1.0-Train.LK4.Value))
	S["B2"] = 1*Train.VB.Value*B
	S["8G"] = S["8A"]*(1.0-Train.RT2.Value)*S["8A-8Ye"]
	S["22A"] = Train.A23.Value*1*Train:ReadTrainWire(23)+T[35]*Train.A22.Value
	S["B12"] = 1*Train.VB.Value*B
	S["20B"] = Train.A20.Value*(1-2*Train.RRP.Value)*((1-Train.RRP.Value) + Train.RRP.Value*Train.A39.Value)*(1.0-Train.RPvozvrat.Value)*Train:ReadTrainWire(20)
	S["B8"] = S["B2"]*Train.A53.Value
	S["B22"] = S["B8"]*Train.A75.Value
	S["B28"] = S["B8"]*Train.KUP.Value
	S["36Ya"] = S["B8"]*Train.KVC.Value
	S["B13"] = S["B12"]*Train.A24.Value
	S["1R"] = S["1A"]*S["1A-1R"]
	S["22V"] = S["22A"]*(1.0-Train.TRK.Value)
	S["1P"] = S["1A"]*C((P == 1) or (P == 2))*S["1T-1P"]+T[31]*C((P == 3) or (P == 4))
	S["11A"] = S["B2"]*(1.0-Train.RD.Value)
	S["10/4"] = S["B12"]*Train.VB.Value*Train.A56.Value
	S["10AYa"] = S["B2"]*Train.A80.Value
	S["10AE"] = S["B2"]*Train.A30.Value
	S["10I"] = S["10AE"]*Train.RheostatController.RKM2
	S["10AH"] = S["10I"]*(1.0-Train.LK1.Value)
	S["10H"] = S["10I"]*Train.LK4.Value
	S["10B"] = S["10AE"]*S["10AE-10B"]
	S["22K"] = S["10/4"]*Train.A10.Value
	S["22E'"] = S["22K"]*Train.VMK.Value*Train.AK.Value
	S["1Zh"] = S["1P"]*Train.AVT.Value*(1.0-Train.RPvozvrat.Value)*S["1G-1Zh"]
	S["D4/3"] = S["10/4"]*Train.A13.Value*1
	S["2Ye10AV"] = S["10AYa"]*(1.0-Train.LK4.Value)*(1.0-Train.LK3.Value)*C((RK >= 2) and (RK <= 18))+0
	S["10/4a"] = S["10/4"]*Train.VB.Value
	S["D"] = S["10/4"]*Train.A21.Value
	S["10AK"] = S["10/4"]*Train.A54.Value
	S["1/1p"] = S["10AK"]*Train.PMP["3-4"]
	S["20/1p"] = S["10AK"]*Train.PMP["9-10"]
	S["10AKl"] = S["10AK"]*Train.KRP.Value
	S["4/1p"] = S["10AKl"]*Train.PMP["5-6"]
	S["5/1p"] = S["10AKl"]*Train.PMP["7-8"]
	S["10N"] = S["10AE"]*1*S["10Zh-10N"]+T["SDRK_ShortCircuit"]
	S["ST/1+ST/2"] = S["D4/3"]*Train.BPT.Value
	S["16V/1+16V/2"] = S["D4/3"]*(1.0-Train.RD.Value)
	S["D6/1"] = S["D4/3"]*Train.BD.Value
	S["U0"] = S["10/4"]*Train.A27.Value
	S["U0a"] = S["U0"]*1+(-10*S["10AN"])
	S["s3"] = S["U0"]*Train.BPSNon.Value*(1-Train:ReadTrainWire(35))
	S["1K"] = S["1Zh"]*C((P == 1) or (P == 2))
	S["1N"] = S["1Zh"]*C((P == 1) or (P == 3))
	S["10AG"] = S["10AYa"]*S["10E-10AG"]*S["10AYa-10E"]
	S["1-7R-29"] = S["U0"]*Train.A23.Value*Train.RezMK.Value
	S["17/1p"] = S["10AK"]*(1.0-Train.KRP.Value)*Train.VozvratRP.Value
	S["2Ye"] = S["2A-2G"]*Train.LK4.Value*Train.A2.Value*(1-2*Train.RRP.Value)*((1-Train.RRP.Value) + Train.RRP.Value*Train.A39.Value)*S["2Zh-2A"]*Train:ReadTrainWire(2)+(S["2Ye10AV"])

	-- Call all triggers
	Train.RRP:TriggerInput("Set",Train:ReadTrainWire(14))
	Train.RZ_2:TriggerInput("Set",S["24V"])
	Triggers["ReverserForward"](S["5B"])
	Train.Panel["TrainDoors"] = S["16V/1+16V/2"]
	Train.PneumaticNo1:TriggerInput("Set",S["8Zh"])
	Train:WriteTrainWire(27,S["s3"])
	Train:WriteTrainWire(9,S["10/4a"])
	Train.RV1:TriggerInput("Set",S["2Ye"])
	T[37] = min(1,Train:ReadTrainWire(5))
	Train.TR1:TriggerInput("Set",S["6A"])
	Train.SR1:TriggerInput("Set",S["2Ye"])
	T[34] = min(1,S["22A"])
	Train.Panel["EmergencyLight"] = S["B12"]
	Triggers["XR3.4"](S["36Ya"])
	Train.PneumaticNo2:TriggerInput("Set",S["8G"])
	Triggers["SDRK_Coil"](S["10B"])
	Triggers["RPvozvrat"](S["17A"])
	Triggers["XR3.6"](S["36Ya"])
	Train:WriteTrainWire(20,S["20/1p"])
	Triggers["XR3.2"](S["27A"])
	Train.KSH1:TriggerInput("Set",S["1R"])
	Train.Panel["KUP"] = S["B28"]
	Train:WriteTrainWire(23,S["1-7R-29"])
	Triggers["XR3.7"](S["36Ya"])
	Train.Panel["TrainBrakes"] = S["ST/1+ST/2"]
	Train.LK5:TriggerInput("Set",S["20B"])
	Train.LK1:TriggerInput("Set",S["1K"])
	Train:WriteTrainWire(4,S["4/1p"])
	Train.VDOL:TriggerInput("Set",S["31A"])
	Triggers["SDRK"](S["10N"])
	Train.LK4:TriggerInput("Set",S["5B'"])
	Train.KVC:TriggerInput("Set",S["B8"])
	Train.KSB2:TriggerInput("Set",S["6Yu"])
	Train.RPU:TriggerInput("Set",S["27A"])
	Train:WriteTrainWire(5,S["5/1p"])
	Train.Panel["GreenRP"] = S["U0a"]
	Triggers["SDPP"](S["10AG"])
	Triggers["XT3.1"](S["B13"])
	Train.KSB1:TriggerInput("Set",S["6Yu"])
	Triggers["RRTuderzh"](S["25A"])
	Train.RR:TriggerInput("Set",S["1N"])
	T[39] = min(1,Train:ReadTrainWire(29))
	Train:WriteTrainWire(22,S["22E'"])
	Train:WriteTrainWire(1,S["1/1p"])
	T[38] = min(1,S["8Zh"])
	Train.TR2:TriggerInput("Set",S["6A"])
	Triggers["KPP"](S["27A"])
	Train.RUP:TriggerInput("Set",S["6Yu"])
	Train.LK3:TriggerInput("Set",S["1Zh"])
	Train.KUP:TriggerInput("Set",S["B22"])
	Train.Rper:TriggerInput("Set",S["3A"])
	Train:WriteTrainWire(10,S["10/4a"])
	Triggers["XR3.3"](S["28A"])
	Train.LK2:TriggerInput("Set",S["20B"])
	Train:WriteTrainWire(18,S["18A"])
	T[35] = min(1,Train:ReadTrainWire(22))
	T[33] = min(1,S["12A"])
	Train:WriteTrainWire(17,S["17/1p"])
	T[32] = min(1,S["12A"])
	T[31] = min(1,S["6A"])
	Triggers["RUTpod"](S["10H"])
	Triggers["ReverserBackward"](S["4B"])
	Train.KK:TriggerInput("Set",S["22V"])
	Triggers["RRTpod"](S["10AH"])
	Train:WriteTrainWire(11,S["11A"])
	T[36] = min(1,S["5V"])
	Train.KSH2:TriggerInput("Set",S["1R"])
	Train.VDOP:TriggerInput("Set",S["32A"])
	Train.RD:TriggerInput("Set",S["D6/1"])
	Train.VDZ:TriggerInput("Set",S["16V"])
	return S
end

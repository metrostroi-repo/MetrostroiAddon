include("shared.lua")


--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}

-----
-- ALS Panel
-----
ENT.ButtonMap["ARSPanel"] = {
	pos = Vector(463.08,-52.68,28.05),
	ang = Angle(0,-90-29,90),
	width = 38,
	height = 240,
	scale = 0.0625,

	buttons = {
		{ID = "L80",		x=20,  y=24+39.5*0, radius = 15, tooltip="80: Ограничение скорости 80 км/ч\nSpeed limit 80 kph"},
		{ID = "L70",		x=19,  y=24+39.5*1, radius = 15, tooltip="70: Ограничение скорости 70 км/ч\nSpeed limit 70 kph"},
		{ID = "L60",		x=18,  y=24+39.5*2, radius = 15, tooltip="60: Ограничение скорости 60 км/ч\nSpeed limit 60 kph"},
		{ID = "L40",		x=18,  y=24+39.5*3, radius = 15, tooltip="40: Ограничение скорости 40 км/ч\nSpeed limit 40 kph"},
		{ID = "L0",			x=18,  y=24+39.5*4, radius = 15,tooltip="0: Ограничение скорости 0 км/ч\nSpeed limit 0 kph"},
		{ID = "LNF",		x=18,  y=24+39.5*5, radius = 15, tooltip="НЧ: Отсутствие частоты АРС\nNCh: No ARS frequency"},
	}
}
for k,v in pairs(ENT.ButtonMap["ARSPanel"].buttons) do
	Metrostroi.ClientPropForButton(v.ID,{
		panel = "ARSPanel",
		button = v.ID,
		model = "models/metrostroi_train/em/ars_"..v.ID:sub(2,-1)..".mdl",
		z = -4,
		ang = 90,
		staylabel = true,
	})
end
-- Main panel
ENT.ButtonMap["Main"] = {
	pos = Vector(459.7,-31.9,-0.69),
	ang = Angle(0,-90,90-26),
	width = 315,
	height = 240,
	scale = 0.0588,

	buttons = {
		{ID = "KVTSet",	x=44,  y=52, radius=27, tooltip="КБ: Кнопка Бдительности\nKB: Attention button"},
		{ID = "ARSLamp",		x=88.9, y=54.6, radius=15, tooltip="АРС: Лампа торможения АРС\nARS: ARS brake lamp"},
		{ID = "VZPToggle",	x=36+47*2,  y=56+58*0, radius=20, tooltip="Выключатель задержки поезда"},
		{ID = "VZDSet",	x=35+47*3,  y=55+58*0, radius=20, tooltip="Выключатель задержки дверей"},
		{ID = "AutodriveLamp",		x=220.7, y=54.5, radius=15, tooltip="Автоведение: Лампа хода от автоведения\nAutodrive: Autodrive drive lamp"},
		{ID = "KRZDSet",		x=269, y=56, radius=20, tooltip="КУ10: Кнопка резервного закрытия дверей\nKRZD: Emergency door closing"},

		{ID = "KDLSet",			x=33, y=56+58*1, radius=20, tooltip="КУ12: Кнопка левых дверей\nKDL: Left doors open"},
		{ID = "DIPonSet",		x=33+47*1,  y=56+58*1, radius=20, tooltip="КУ4:Включение освещения\nTurn interior lights on"},
		{ID = "DIPoffSet",		x=33+47*2,  y=56+58*1, radius=20, tooltip="КУ5:Отключение освещения\nTurn interior lights off"},
		{ID = "VozvratRPSet",	x=33+47*3,  y=56+58*1, radius=20, tooltip="КУ9:Возврат РП\nReset overload relay"},
		{ID = "KSNSet",			x=33+47*4,  y=56+58*1, radius=20,  tooltip="КУ8:Принудительное срабатывание РП на неисправном вагоне (сигнализация неисправности)\nKSN: Failure indication button"},
		{ID = "KDPSet",			x=33+47*5,  y=56+58*1, radius=20, tooltip="КДП:Правые двери\nKDP: Right doors open"},
		----Down Panel
		{ID = "KU1Toggle",			x=21,y=138,w=45,h=71, tooltip="КУ1:Включение мотор-компрессора\nTurn motor-compressor on"},
		{ID = "KTLamp",		x=79.8, y=178.5, radius=15, tooltip="КТ: Контроль тормоза(торможение эффективно)\nKT: Brake control(efficient brakes)"},
		{ID = "RingSet",		x=116.9,  y=176, radius=20, tooltip="Звонок передачи управления\nControl transfer ring"},
		{ID = "VUSToggle", x=153,y=180,radius=10, tooltip="Дальний свет\nDistant light"},
		{ID = "KAKSet",		x=189.2,y=176.8,radius=20, tooltip="АК: Аварийная кнопка(Х3 при резервном управлении)\nAK: Emergency button(X3 with emergency control)"},
		{ID = "VAutodriveToggle", x=226,y=180,radius=10, tooltip="Включение автоведения\nAutodrive enable"},
		{ID = "VUD1Toggle",		x=237.7,y=138,w=45,h=70, tooltip="КУ2: Закрытие дверей\nKU2: Door control toggle (close doors)"},
	}
}



Metrostroi.ClientPropForButton("DIPon",{
	panel = "Main",
	button = "DIPonSet",
	model = "models/metrostroi_train/em/buttonblack.mdl",
	ang = 90,
	z = 0,
})
Metrostroi.ClientPropForButton("VozvratRP",{
	panel = "Main",
	button = "VozvratRPSet",
	model = "models/metrostroi_train/em/buttonblack.mdl",
	ang = 90,
	z = 0,
})

Metrostroi.ClientPropForButton("ARSLamp",{
	panel = "Main",
	button = "ARSLamp",
	model = "models/metrostroi_train/Em/LampPult.mdl",
	z=3,
	staylabel = true,
})

Metrostroi.ClientPropForButton("VZP",{
	panel = "Main",
	button = "VZPToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90,
})
Metrostroi.ClientPropForButton("VZD",{
	panel = "Main",
	button = "VZDSet",
	model = "models/metrostroi_train/em/buttonblack.mdl",
	ang = 90,
	z = 0,
})

Metrostroi.ClientPropForButton("AutodriveLamp",{
	panel = "Main",
	button = "AutodriveLamp",
	model = "models/metrostroi_train/Em/LampPult.mdl",
	z=3,
	staylabel = true,
})

Metrostroi.ClientPropForButton("KVT",{
	panel = "Main",
	button = "KVTSet",
	model = "models/metrostroi_train/em/buttonbig.mdl",
	ang = 90,
	z = 0,
})
Metrostroi.ClientPropForButton("DIPoff",{
	panel = "Main",
	button = "DIPoffSet",
	model = "models/metrostroi_train/em/buttonred.mdl",
	ang = 90,
	z = 0,
})
Metrostroi.ClientPropForButton("KSN",{
	panel = "Main",
	button = "KSNSet",
	model = "models/metrostroi_train/em/buttonred.mdl",
	ang = 90,
	z = 0,
})
Metrostroi.ClientPropForButton("KDP",{
	panel = "Main",
	button = "KDPSet",
	model = "models/metrostroi_train/em/buttonred.mdl",
	ang = 90,
	z = 0,
})

Metrostroi.ClientPropForButton("KDL",{
	panel = "Main",
	button = "KDLSet",
	model = "models/metrostroi_train/em/buttonred.mdl",
	ang = 90,
	z = 0,
})
Metrostroi.ClientPropForButton("KRZD",{
	panel = "Main",
	button = "KRZDSet",
	model = "models/metrostroi_train/em/buttonblack.mdl",
	ang = 90,
	z = 0,
})

Metrostroi.ClientPropForButton("VUD",{
	panel = "Main",
	button = "VUD1Toggle",
	model = "models/metrostroi_train/switches/vudwhite.mdl",
	z=-23,
})
Metrostroi.ClientPropForButton("KU1",{
	panel = "Main",
	button = "KU1Toggle",
	model = "models/metrostroi_train/switches/vudbrown.mdl",
	z=-23,
})

Metrostroi.ClientPropForButton("KTLamp",{
	panel = "Main",
	button = "KTLamp",
	model = "models/metrostroi_train/Em/LampPult.mdl",
	z=3,
	staylabel = true,
})

Metrostroi.ClientPropForButton("VAutodrive",{
	panel = "Main",
	button = "VAutodriveToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90,
})
--RRP
Metrostroi.ClientPropForButton("KAK",{
	panel = "Main",
	button = "KAKSet",
	model = "models/metrostroi_train/em/buttonred.mdl",
	ang = 0,
	z = 0,
})
Metrostroi.ClientPropForButton("Ring",{
	panel = "Main",
	button = "RingSet",
	model = "models/metrostroi_train/em/buttonred.mdl",
	ang = 0,
	z = 0,
})
--VUSToggle
Metrostroi.ClientPropForButton("VUS",{
	panel = "Main",
	button = "VUSToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90,
})

--Lamps
ENT.ButtonMap["Lamps"] = {
	pos = Vector(464.42,-21.07,28.65),
	ang = Angle(0,-13.5,90),
	width = 24,
	height = 310,
	scale = 0.0625,

	buttons = {
		{ID = "LampAutodrive", x=12.6, y=16, radius=10, tooltip="Включение автоведения\nAutodrive enabled q"},
		{ID = "Lamp2", x=12.6, y=15.8 + 38*1, radius=10, tooltip="2: Лампа второго провода (ход реостатного контроллера)\n2: 2nd train wire lamp(rheostat controller motion)"},
		{ID = "Lamp1", x=12.6, y=18.2 + 38*2, radius=10, tooltip="1: Лампа первого провода (включение двигателей)\n1: 1st train wire lamp(engines engaged)"},
		{ID = "Lamp6", x=12.6, y=19 + 38*3, radius=10, tooltip="6: Лампа шестого провода (сигнализация торможения)\n6: 6th train wire lamp(brakes engaged)"},
		{ID = "DoorsWag", x=12.6, y=22 + 38*4, radius=10, tooltip="Двери вагона: Лампа проверки РД	при вклюёчнном КСД\nWagon doors: RD check lamp with enabled KSD"},
		{ID = "Doors", x=12.6, y=24.7 + 38*5, radius=10, tooltip="Двери: Сигнализация дверей\nDoors: Door state light (doors are closed)"},
		{ID = "GreenRP", x=12.6, y=25.4 + 38*6, radius=10, tooltip="РП вагона: Лампа реле перегрузки вагона (Сигнализация перегрузки)\nWagon RP: Wagon overload relay light (overload relay open on current train)"},
		{ID = "RedRP", x=12.6, y=27.8 + 38*7, radius=10, tooltip="РП поезда: Лампа реле перегрузки\nTrain RP: Overload relay light (power circuits failed to assemble)"},
	}
}
local i=1
for k,v in pairs(ENT.ButtonMap["Lamps"].buttons) do
	Metrostroi.ClientPropForButton(v.ID,{
		panel = "Lamps",
		button = v.ID,
		model = "models/metrostroi_train/em/lamp"..i..".mdl",
		staylabel = true,
	})
	i = i + 1
end

--Lamps
ENT.ButtonMap["Lamps2"] = {
	pos = Vector(466.38,-19.33,28.65),
	ang = Angle(0,180-13.5,90),
	width = 24,
	height = 310,
	scale = 0.0625,

	buttons = {
		{ID = "LampAutodrive", x=12, y=16, radius=10, tooltip="Включение автоведения\nAutodrive enabled q"},
		{ID = "Lamp2", x=12, y=15.8 + 38*1, radius=10, tooltip="2: Лампа второго провода (ход реостатного контроллера)\n2: 2nd train wire lamp(rheostat controller motion)"},
		{ID = "Lamp1", x=12, y=18.2 + 38*2, radius=10, tooltip="1: Лампа первого провода (включение двигателей)\n1: 1st train wire lamp(engines engaged)"},
		{ID = "Lamp6", x=12, y=19 + 38*3, radius=10, tooltip="6: Лампа шестого провода (сигнализация торможения)\n6: 6th train wire lamp(brakes engaged)"},
		{ID = "DoorsWag", x=12, y=22 + 38*4, radius=10, tooltip="Двери вагона: Лампа проверки РД	при вклюёчнном КСД\nWagon doors: RD check lamp with enabled KSD"},
		{ID = "Doors", x=12, y=24.7 + 38*5, radius=10, tooltip="Двери: Сигнализация дверей\nDoors: Door state light (doors are closed)"},
		{ID = "GreenRP", x=12, y=25.4 + 38*6, radius=10, tooltip="РП вагона: Лампа реле перегрузки вагона (Сигнализация перегрузки)\nWagon RP: Wagon overload relay light (overload relay open on current train)"},
		{ID = "RedRP", x=12, y=27.8 + 38*7, radius=10, tooltip="РП поезда: Лампа реле перегрузки\nTrain RP: Overload relay light (power circuits failed to assemble)"},
	}
}
local i=1
for k,v in pairs(ENT.ButtonMap["Lamps2"].buttons) do
	Metrostroi.ClientPropForButton(v.ID.."_p",{
		panel = "Lamps2",
		button = v.ID,
		model = "models/metrostroi_train/em/lamp"..i..".mdl",
		z=-2.5,
		staylabel = true,
	})
	i = i + 1
end

ENT.ButtonMap["RezMK"] = {
	pos = Vector(469.0,-20.75,37),
	ang = Angle(0,270,90),
	width = 50,
	height = 80,
	scale = 0.0625,

	buttons = {
		{ID = "RezMKSet", x=0, y=0, w=50, h=80, tooltip="КУ15:Резервное включение мотор-компрессора\nRezMKSet"},
	}
}
Metrostroi.ClientPropForButton("RezMK",{
	panel = "RezMK",
	button = "RezMKSet",
	model = "models/metrostroi_train/switches/vudblack.mdl",
})

ENT.ButtonMap["AVMain"] = {
	pos = Vector(408.06,40.8,56),
	ang = Angle(0,90,90),
	width = 335,
	height = 380,
	scale = 0.0625,

	buttons = {
		{ID = "AV8BToggle", x=0, y=0, w=300, h=380, tooltip="АВ-8Б: Автоматическй выключатель (Вспомогательные цепи высокого напряжения)\n"},
	}
}
Metrostroi.ClientPropForButton("AV8B",{
	panel = "AVMain",
	button = "AV8BToggle",
	model = "models/metrostroi_train/switches/automain.mdl",
	z=43,
})

ENT.ButtonMap["Tsepi"] = {
	pos = Vector(408.89,36.38,30.3),
	ang = Angle(0,90,90),
	width = 67,
	height = 50,
	scale = 0.0625,

	buttons = {
		--{ID = "VUSToggle", x=0, y=0, w=100, h=110, tooltip="Прожектор\nVUSoggle"},
		{x=0,y=0,w=67,h=50,tooltip="Напряжение цепей управления"},
	}
}

---AV1 Panel
ENT.ButtonMap["AV1"] = {
	pos = Vector(408.06,41,30),
	ang = Angle(0,90,90),
	width = 290+0,
	height = 155,
	scale = 0.0625,

	buttons = {
		{ID = "VU3Toggle", x=0, y=0, w=100, h=140, tooltip="ВУ3: Освещение кабины\n"},
		{ID = "VU2Toggle", x=100, y=0, w=100, h=140, tooltip="ВУ2: Аварийное освещение 25В\n"},
		{ID = "VU1Toggle", x=200, y=0, w=100, h=140, tooltip="ВУ1: Печь отопления кабины ПТ-6\n"},
	}
}
for k,v in pairs(ENT.ButtonMap["AV1"].buttons) do
	if not v.ID then continue end
	Metrostroi.ClientPropForButton(v.ID:sub(0,-7),{
		panel = "AV1",
		button = v.ID,
		model = "models/metrostroi_train/switches/autobl.mdl",
		z=10,
	})
end

ENT.ButtonMap["AV2"] = {
	pos = Vector(408.06,22.40,44.1),
	ang = Angle(0,90,90),
	width = 180,
	height = 136,
	scale = 0.0625,

	buttons = {
		{ID = "RSTToggle", x=0, y=0, w=90, h=136, tooltip="РСТ: Радиооповещение и поездная радио связь\nRST: Radio"},
		{ID = "RSTPl", x=0, y=80, w=90, h=56, tooltip="Пломба РСТ\nRST plomb"},
		{ID = "VSOSDToggle", x=90, y=0, w=90, h=136, tooltip="СОСД: Включение СОСД(светильник для горлифта)\nSOSD: SOSD enabler(horligt light)"},
	}
}
for k,v in pairs(ENT.ButtonMap["AV2"].buttons) do
	if not v.ID then continue end
	if v.ID:find("Pl") then
		Metrostroi.ClientPropForButton(v.ID,{
			panel = "AV2",
			button = v.ID:Replace("Pl","Toggle"),
			model = "models/metrostroi_train/switches/autoplombl.mdl",
			z=19,
			propname = false,
			ang=0,
		})
		continue
	end
	Metrostroi.ClientPropForButton(v.ID:sub(0,-7),{
		panel = "AV2",
		button = v.ID,
		model = "models/metrostroi_train/switches/autobl.mdl",
		z=20,
	})
end

-- AV panel
ENT.ButtonMap["AV"] = {
	pos = Vector(408.16,-58.2,35.5),
	ang = Angle(0,90,90),
	width = 85*7,
	height = 130,
	scale = 0.0625,

	buttons = {
		{ID = "VRUToggle",x=85*0,y=0,w=85,h=130 , tooltip="ВРУ: Выключатель резервного управления\nVRU: Emergency control enable"},
		{ID = "VAHToggle",x=85*1,y=0,w=85,h=130 , tooltip="КАХ: Включение аварийного хода (неисправность реле педали безопасности)\nКAH: Emergency driving mode (failure of RPB relay)"},
		{ID = "VAHPl",x=85*1,y=80,w=85,h=50 , tooltip="Пломба КАХ\nKAH plomb"},
		{ID = "VADToggle",x=85*2,y=0,w=85,h=130 , tooltip="КАД: Включение аварийного закрытия дверей (неисправность реле контроля дверей)\nKAD: Emergency door close override (failure of KD relay)"},
		{ID = "VADPl",x=85*2,y=80,w=85,h=50 , tooltip="Пломба КАД\nKAD plomb"},
		{ID = "OVTToggle",x=85*3,y=0,w=85,h=130 , tooltip="ОВТ: Отключение вентильных тормозов\nOVT: Pneumatic valves disabler"},
		{ID = "OVTPl",x=85*3,y=80,w=85,h=50 , tooltip="Пломба ОВТ\nOVT plomb"},
		{ID = "KSDToggle",x=85*4,y=0,w=85,h=130 , tooltip="КСД: Контроль сигнализации дверей(проверка СД)\nKSD: Door state controle(SD check)"},
		{ID = "DPToggle",x=85*5,y=0,w=85,h=130 , tooltip="ДП: Двери поезда\nDP: Train doors"},
		{ID = "VKFToggle",x=85*6,y=0,w=85,h=130 , tooltip="ВКФ: Выключатель красных фар(подключает КФ к батарее напрямую)\nVKF: Red lights enable(connect a red lights to battery)"},
	}
}
for k,v in pairs(ENT.ButtonMap["AV"].buttons) do
	if not v.ID then continue end
	if v.ID:find("Pl") then
		Metrostroi.ClientPropForButton(v.ID,{
			panel = "AV",
			button = v.ID:Replace("Pl","Toggle"),
			model = "models/metrostroi_train/switches/autoplomb"..(v.ID:find("OVT") and "l" or "r")..".mdl",
			z=14,
			propname = false,
			ang=0,
		})
		continue
	end

	Metrostroi.ClientPropForButton(v.ID:sub(0,-7),{
		panel = "AV",
		button = v.ID,
		model = "models/metrostroi_train/switches/autobl.mdl",
		z=15,
	})
end
-- Battery panel
ENT.ButtonMap["Battery"] = {
	pos = Vector(408.98,20.24,30.5),
	ang = Angle(0,90,90),
	width = 250,
	height = 136,
	scale = 0.0625,

	buttons = {
		{ID = "VBToggle", x=0, y=0, w=250, h=136, tooltip="АБ: Выключатель аккумуляторной батареи (Вспомогательные цепи низкого напряжения)\nVB: Battery on/off"},
	}
}
Metrostroi.ClientPropForButton("VB",{
	panel = "Battery",
	button = "VBToggle",
	model = "models/metrostroi_train/switches/autobl2.mdl",
	z=15,
})

--VU Panel
ENT.ButtonMap["VU"] = {
	pos = Vector(469.5,-17.5,45),
	ang = Angle(0,270,90),
	width = 100,
	height = 140,
	scale = 0.0625,

	buttons = {
		{ID = "VUToggle", x=0, y=0, w=100, h=140, tooltip="ВУ: Выключатель Управления\nVUToggle"},
	}
}
Metrostroi.ClientPropForButton("VU",{
	panel = "VU",
	button = "VUToggle",
	model = "models/metrostroi_train/switches/autobl.mdl",
	z=20,
})

ENT.ButtonMap["VRD"] = {
	pos = Vector(408.06,35.24,22),
	ang = Angle(0,90,90),
	width = 100,
	height = 140,
	scale = 0.0625,

	buttons = {
		{ID = "VRDToggle", x=0, y=0, w=100, h=140, tooltip="ВРД: Выключатель разрешающий движение(под 0)\nVRD: Accept moving(when 0 on ALS)"},
	}
}
Metrostroi.ClientPropForButton("VRD",{
	panel = "VRD",
	button = "VRDToggle",
	model = "models/metrostroi_train/switches/autobl.mdl",
	z=20,
})


ENT.ButtonMap["BatteryAV"] = {
	pos = Vector(409.55,-50.1,12.25),
	ang = Angle(0,90,90),
	width = 250,
	height = 136,
	scale = 0.0625,

	buttons = {
		{ID = "VBAToggle", x=0, y=0, w=250, h=136, tooltip="АБ: Выключатель аккумуляторной батареи автоведения(Включение АРС)(\nVBA: Autodrive battery on/off(ARS Enable)"},
	}
}
Metrostroi.ClientPropForButton("VBA",{
	panel = "BatteryAV",
	button = "VBAToggle",
	model = "models/metrostroi_train/switches/autobl2.mdl",
	z=15,
})


ENT.ButtonMap["RC"] = {
	pos = Vector(412.07,-28.72,22.80),
	ang = Angle(0,90,90),
	width = 127,
	height = 473,
	scale = 0.0625,

	buttons = {
		{ID = "RC2Toggle", x=0, y=0, w=127, h=213, tooltip="RC2"},
		{ID = "RC2Pl", x=0, y=213-213/4, w=127, h=213/4, tooltip="Пломба РЦ-2\nRC-2 plomb"},
		{ID = "RC1Toggle", x=0, y=473-213, w=127, h=213, tooltip="RC1"},
		{ID = "RC1Pl", x=0, y=473-213/4, w=127, h=213/4, tooltip="Пломба РЦ-1\nRC-1 plomb"},
	}
}
ENT.ClientProps["RC2"] = {
	model = "models/metrostroi_train/em/rc.mdl",
	pos = Vector(409.77,-24.81,9.73+2),
	ang = Angle(0,-90-55,0)
}
ENT.ClientProps["RC2Pl"] = {
	model = "models/metrostroi_train/switches/autoplombr.mdl",
	pos = Vector(411.143951,-22.746609,11.376095),
	ang = Angle(0.000000,90.000000,90.000000),
}

ENT.ClientProps["RC1"] = {
	model = "models/metrostroi_train/em/rc.mdl",
	pos = Vector(409.77,-24.81,-6.72+2),
	ang = Angle(0,-90-55,0)
}
ENT.ClientProps["RC1Pl"] = {
	model = "models/metrostroi_train/switches/autoplombr.mdl",
	pos = Vector(411.143951,-22.746609,-5.308110),
	ang = Angle(0.000000,90.000000,90.000000),
}


--[[
Metrostroi.ClientPropForButton("AVVB",{
	panel = "BatteryAV",
	button = "AVVBToggle",
	model = "models/metrostroi_train/switches/autobl2.mdl",
	z=15,
})
]]

-- Parking brake panel
ENT.ButtonMap["ParkingBrake"] = {
	pos = Vector(460,49.0,6.0),
	ang = Angle(0,-82,90),
	width = 400,
	height = 400,
	scale = 0.0625,

	buttons = {
		{ID = "ParkingBrakeLeft",x=0, y=0, w=200, h=400, tooltip="Поворот колеса ручного тормоза"},
		{ID = "ParkingBrakeRight",x=200, y=0, w=200, h=400, tooltip="Поворот колеса ручного тормоза"},
	}
}

-- Train driver helpers panel
ENT.ButtonMap["HelperPanel"] = {
	pos = Vector(455.13,58.99,24.44),
	ang = Angle(0,-17.5,90),
	width = 60,
	height = 188,
	scale = 0.0625,

	buttons = {
		{ID = "VDLSet",     x=30, y=42, radius=30, tooltip="ВДЛ: Выключатель левых дверей\nVDL: Left doors open"},
		{ID = "VUD2LToggle", x=0, y=110, w=60,h=20, tooltip="Блокировка ВУД2\nVUD2 lock"},
		{ID = "VUD2Toggle", x=30, y=138, radius=30, tooltip="ВУД2: Выключатель управления дверьми\nVUD2: Door control toggle (close doors)"},
	}
}
Metrostroi.ClientPropForButton("VUD2",{
	panel = "HelperPanel",
	button = "VUD2Toggle",
	model = "models/metrostroi_train/switches/vudwhite.mdl",
	z = 0,
})
Metrostroi.ClientPropForButton("VUD2l",{
	panel = "HelperPanel",
	button = "VUD2Toggle",
	model = "models/metrostroi_train/switches/vudlock.mdl",
	z = 0,
})
Metrostroi.ClientPropForButton("VDL",{
	panel = "HelperPanel",
	button = "VDLSet",
	model = "models/metrostroi_train/switches/vudblack.mdl",
	z = 0,
})

-- Help panel
ENT.ButtonMap["Help"] = {
	pos = Vector(422,-41,66),
	ang = Angle(0,90,90),
	width = 28,
	height = 20,
	scale = 0.5,

	buttons = {
		{ID = "ShowHelp", x=0, y=0, w=28,h=20, tooltip="Помощь в вождении поезда\nShow help on driving the train"},
	}
}
-- Pneumatic instrument panel 2
ENT.ButtonMap["PneumaticManometer"] = {
	pos = Vector(459.247131,-54.307846,16.197767),
	ang = Angle(0,-90-51,90),

	width = 70,
	height = 70,
	scale = 0.0625,

	buttons = {
		{x=35,y=35,radius=35,tooltip="Давление в магистралях (красная: тормозной, чёрная: напорной)\nPressure in pneumatic lines (red: brake line, black: train line)"},
	}
}
-- Pneumatic instrument panel
ENT.ButtonMap["PneumaticPanels"] = {
	pos = Vector(463.281189,-53.228256,11.310288),
	ang = Angle(0,-90-44,90),

	width = 70,
	height = 70,
	scale = 0.0625,

	buttons = {
		{x=35,y=35,radius=35,tooltip="Тормозной манометр: Давление в тормозных цилиндрах (ТЦ)\nBrake cylinder pressure"},
	}
}
ENT.ButtonMap["DriverValveBLDisconnect"] = {
	pos = Vector(453.57,-54.37,-27.61),
	ang = Angle(-90,0,0),
	width = 200,
	height = 90,
	scale = 0.0625,

	buttons = {
		{ID = "DriverValveBLDisconnectToggle", x=0, y=0, w=200, h=90, tooltip="Кран двойной тяги тормозной магистрали\nTrain line disconnect valve"},
	}
}
ENT.ButtonMap["DriverValveTLDisconnect"] = {
	pos = Vector(455.482483,-54,-15),
	ang = Angle(90,180-11.79,0),
	width = 200,
	height = 90,
	scale = 0.0625,

	buttons = {
		{ID = "DriverValveTLDisconnectToggle", x=0, y=0, w=200, h=90, tooltip="Кран двойной тяги напорной магистрали\nBrake line disconnect valve"},
	}
}
ENT.ButtonMap["EPKDisconnect"] = {
	pos = Vector(449.35,-57.78,-25.65),
	ang = Angle(0,90+56.59,0),
	width = 200,
	height = 90,
	scale = 0.0625,

	buttons = {
		{ID = "EPKToggle", x=0, y=0, w=200, h=90, tooltip="Кран ЭПК\nEPK disconnect valve"},
	}
}
ENT.ButtonMap["DURA"] = {
	pos = Vector(408+15+12.15,-58.0-5.3,-6.65),
	ang = Angle(0,180,0),
	width = 240,
	height = 80,
	scale = 0.0625,

	buttons = {
		{ID = "DURASelectMain", x=145, y=43, radius=20, tooltip="DURA Основной путь\nDURA Select Main"}, -- NEEDS TRANSLATING
		{ID = "DURASelectAlternate", x=180, y=43, radius=20, tooltip="DURA Альтернативный путь\nDURA Select Alternate"}, -- NEEDS TRANSLATING
		{ID = "DURAToggleChannel", x=100, y=60, radius=20, tooltip="DURA Выбор канала\nDURA Toggle Channel"}, -- NEEDS TRANSLATING
		{ID = "DURAPowerToggle", x=100, y=30, radius=20, tooltip="DURA Питание\nDURA Power"}, -- NEEDS TRANSLATING

	}
}

ENT.ButtonMap["DURADisplay"] = {
	pos = Vector(408+15-0.75+12.15,-58.0-5.3+1.5625,-6.65),
	ang = Angle(0,180,0),
	width = 240,
	height = 80,
	scale = 0.0625/3.2,
}


ENT.ButtonMap["Meters"] = {
	pos = Vector(461.65213,-56.696617,37.528275),
	ang = Angle(0,-148,90),
	width = 73,
	height = 140,
	scale = 0.0625,

	buttons = {
		{x=13, y=22, w=60, h=50, tooltip="Вольтметр высокого напряжения (кВ)\nHV voltmeter (kV)"},
		{x=13, y=81, w=60, h=50, tooltip="Амперметр (А)\nTotal ampermeter (A)"},
	}
}
ENT.ButtonMap["Speedometer"] = {
	pos = Vector(459.649109,-53.19582,26.624441),
	ang = Angle(0,-149,97),
	width = 110,
	height = 110,
	scale = 0.0625,

	buttons = {
		{x=0, y=0, w=110, h=110, tooltip="Скоростемер"},
	}
}


--These values should be identical to those drawing the schedule
local col1w = 80 -- 1st Column width
local col2w = 32 -- The other column widths
local rowtall = 30 -- Row height, includes -only- the usable space and not any lines

local rowamount = 16 -- How many rows to show (total)
--[[ENT.ButtonMap["Schedule"] = {
	pos = Vector(442.1,-60.7,26),
	ang = Angle(0,-110,90),
	width = (col1w + 2 + (1 + col2w) * 3),
	height = (rowtall+1)*rowamount+1,
	scale = 0.0625/2,

	buttons = {
		{x=1, y=1, w=col1w, h=rowtall, tooltip="М №\nRoute number"},
		{x=1, y=rowtall*2+3, w=col1w, h=rowtall, tooltip="П №\nPath number"},

		{x=col1w+2, y=1, w=col2w*3+2, h=rowtall, tooltip="ВРЕМЯ ХОДА\nTotal schedule time"},
		{x=col1w+2, y=rowtall+2, w=col2w*3+2, h=rowtall, tooltip="ИНТ\nTrain interval"},

		{x=col1w+2, y=rowtall*2+3, w=col2w, h=rowtall, tooltip="ЧАС\nHour"},
		{x=col1w+col2w+3, y=rowtall*2+3, w=col2w, h=rowtall, tooltip="МИН\nMinute"},
		{x=col1w+col2w*2+4, y=rowtall*2+3, w=col2w, h=rowtall, tooltip="СЕК\nSecond"},
		{x=col1w+2, y=rowtall*3+4, w=col2w*3+2, h=(rowtall+1)*(rowamount-3)-1, tooltip="Arrival times"}, -- NEEDS TRANSLATING

		{x=1, y=rowtall*3+4, w=col1w, h=(rowtall+1)*(rowamount-3)-1, tooltip="Station name"}, -- NEEDS TRANSLATING
	}
}]]

-- Temporary panels (possibly temporary)
ENT.ButtonMap["FrontPneumatic"] = {
	pos = Vector(475,-45.0,-50.0),
	ang = Angle(0,90,90),
	width = 900,
	height = 100,
	scale = 0.1,
	buttons = {
		{ID = "FrontBrakeLineIsolationToggle",x=150, y=50, radius=32, tooltip="Концевой кран тормозной магистрали"},
		{ID = "FrontTrainLineIsolationToggle",x=750, y=50, radius=32, tooltip="Концевой кран напорной магистрали"},
	}
}
ENT.ButtonMap["RearPneumatic"] = {
	pos = Vector(-475,45.0,-50.0),
	ang = Angle(0,270,90),
	width = 900,
	height = 100,
	scale = 0.1,
	buttons = {
		{ID = "RearTrainLineIsolationToggle",x=150, y=50, radius=32, tooltip="Концевой кран напорной магистрали"},
		{ID = "RearBrakeLineIsolationToggle",x=750, y=50, radius=32, tooltip="Концевой кран тормозной магистрали"},
	}
}
ENT.ButtonMap["GV"] = {
	pos = Vector(139,66,-54),
	ang = Angle(0,180,90),
	width = 170,
	height = 170,
	scale = 0.1,
	buttons = {
		{ID = "GVToggle",x=0, y=0, w= 170,h = 150, tooltip="Главный выключатель", model = {
			var="GV",sndid = "gv",
			sndvol = 0.8,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
			snd = function(val) return val and "gv_f" or "gv_b" end,
		}},
	}
}
ENT.ButtonMap["AirDistributor"] = {
	pos = Vector(-168,68.6,-50),
	ang = Angle(0,180,90),
	width = 170,
	height = 80,
	scale = 0.1,
	buttons = {
		{ID = "AirDistributorDisconnectToggle",x=0, y=0, w= 170,h = 80, tooltip="Выключение воздухораспределителя"},
	}
}


-- UAVA
ENT.ButtonMap["UAVAPanel"] = {
	pos = Vector(450,52,-20),
	ang = Angle(0,-70,90),
	width = 230,
	height = 170,
	scale = 0.0625,

	buttons = {
		{ID = "UAVAToggle",x=230/2, y=0, w=230/2, h=170, tooltip="УАВА: Универсальный Автоматический Выключатель Автостопа\nUAVA: Universal Automatic Autostop Disabler"},
		{ID = "UAVAContactSet",x=0, y=0, w=230/2, h=170, tooltip="УАВА: Универсальный Автоматический Выключатель Автостопа (восстановление контактов)\nUAVA: Universal Automatic Autostop Disabler(contacts reset)"},
	}
}



-- Wagon numbers
ENT.ButtonMap["TrainNumber1"] = {
	pos = Vector(-440,-68,-11),
	ang = Angle(0,0,90),
	width = 130,
	height = 55,
	scale = 0.20,
}
ENT.ButtonMap["TrainNumber2"] = {
	pos = Vector(416,68,-11),
	ang = Angle(0,180,90),
	width = 130,
	height = 55,
	scale = 0.20,
}

ENT.ButtonMap["InfoTableSelect"] = {
	pos = Vector(454.0+12.15,-27.0,50.0),
	ang = Angle(0,-90,90),
	width = 250,
	height = 100,
	scale = 0.1,


	buttons = {
		{ID = "PrevSign",x=0,y=0,w=50,h=100, tooltip="Предыдущая надпись\nPrevious sign"},
		{ID = "NextSign",x=50,y=0,w=50,h=100, tooltip="Следующая надпись\nNext sign"},

		{ID = "Num2P",x=150,y=0,w=50,h=50, tooltip="Маршрут: Увеличить число 2\nRoute: Increase 2nd number"},
		{ID = "Num2M",x=150,y=50,w=50,h=50, tooltip="Маршрут: Уменьшить число 2\nRoute: Decrease 2nd number"},
		{ID = "Num1P",x=200,y=0,w=50,h=50, tooltip="Маршрут: Увеличить число 1\nRoute: Increase 1st number"},
		{ID = "Num1M",x=200,y=50,w=50,h=50, tooltip="Маршрут: Уменьшить число 1\nRoute: Decrease 1st number"},
	}
}

ENT.ButtonMap["FrontDoor"] = {
	pos = Vector(472,16,43.4),
	ang = Angle(0,-90,90),
	width = 650,
	height = 1780,
	scale = 0.1/2,
	buttons = {
		{ID = "FrontDoor",x=0,y=0,w=650,h=1780, tooltip="Передняя дверь\nFront door"},
	}
}

ENT.ButtonMap["CabinDoor"] = {
	pos = Vector(420,64,43.4),
	ang = Angle(0,0,90),
	width = 642,
	height = 1780,
	scale = 0.1/2,
	buttons = {
		{ID = "CabinDoor1",x=0,y=0,w=642,h=1780, tooltip="Дверь в кабину машиниста\nCabin door"},
	}
}

ENT.ButtonMap["PassengerDoor"] = {
	pos = Vector(384,-16,43.4),
	ang = Angle(0,90,90),
	width = 642,
	height = 1900,
	scale = 0.1/2,
	buttons = {
		{ID = "PassengerDoor",x=0,y=0,w=642,h=1900, tooltip="Дверь из салона\nPassenger door"},
	}
}

--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false
ENT.ClientProps["brake"] = {
	model = "models/metrostroi_train/81/334cran.mdl",
	pos = Vector(460.11,-53.7,3.7),
	ang = Angle(0,34,0)
}
ENT.ClientProps["controller"] = {
	model = "models/metrostroi_train/em/kv.mdl",
	pos = Vector(461.65,-24.63,3.9),
	ang = Angle(0,-32,0)
}
ENT.ClientProps["reverser"] = {
	model = "models/metrostroi/81-717/reverser.mdl",
	pos = Vector(461.65,-24.63,3.2),
	ang = Angle(0,45,90)
}
ENT.ClientProps["brake_disconnect"] = {
	model = "models/metrostroi/81-717/uava.mdl",
	pos = Vector(452.9,-57.33,-25.61),
	ang = Angle(0,-90,0),
	color = Color(144,74,0),
}
ENT.ClientProps["train_disconnect"] = {
	model = "models/metrostroi/81-717/uava.mdl",
	pos = Vector(455.482483,-52.546734,-19.333017),
	ang = Angle(0.000000,-101.794258,0.000000),
	color = Color(0,212,255),
}

ENT.ClientProps["EPK_disconnect"] = {
	model = "models/metrostroi/81-717/uava.mdl",
	pos = Vector(449.35,-52.78,-25.65),
	ang = Angle(90,90+56.59,0),
}
ENT.ClientProps["parking_brake"] = {
	model = "models/metrostroi/81-717/ezh_koleso.mdl",
	pos = Vector(460.316742,37.144958,-6.000000),
	ang = Angle(-90.000000,8.000000,0.000000),
}

--------------------------------------------------------------------------------
ENT.ClientProps["train_line"] = {
	model = "models/metrostroi_train/e/small_pneumo_needle.mdl",
	pos = Vector(457.722778,-56.060150,13.877457),
	ang = Angle(314.669312,40.953403,-90.000000),
}
ENT.ClientProps["brake_line"] = {
	model = "models/metrostroi_train/e/small_pneumo_needle.mdl",
	pos = Vector(457.688568,-56.020660,13.877457),
	ang = Angle(314.669312,40.953403,-90.000000),
	color = Color(255,120,120),
}

ENT.ClientProps["brake_cylinder"] = {
	model = "models/metrostroi_train/e/small_pneumo_needle.mdl",
	pos = Vector(462.104797,-55.268986,9.050000),
	ang = Angle(313.335266,48.532555,-90.000000),
}
----------------------------------------------------------------
ENT.ClientProps["voltmeter"] = {
	model = "models/metrostroi_train/e/volt_needle.mdl",
	pos = Vector(458.990723,-57.425472,33.847416),
	ang = Angle(240.237274,33.392635,270.135559),
}

ENT.ClientProps["ampermeter"] = {
	model = "models/metrostroi_train/e/volt_needle.mdl",
	pos = Vector(459.078979,-57.376965,30.437996),
	ang = Angle(222.645691,33.392635,270.135559),
}

ENT.ClientProps["volt1"] = {
	model = "models/metrostroi_train/e/volt_bat_needle.mdl",
	pos = Vector(408.890015,38.459042,27.399431),
	ang = Angle(-46.365803,90.000000,90.000000),
}

ENT.ClientProps["speed1"] = {
	model = "models/metrostroi_train/e/black_pneumo_needle.mdl",
	pos = Vector(455.287048,-56.941986,21.128723),
	ang = Angle(96.164711,120.947121,0.000000),
}

-----------------------------------------------
Metrostroi.ClientPropForButton("SelectMain",{
	panel = "DURA",
	button = "DURASelectMain",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 4,
	z = 0,
})
Metrostroi.ClientPropForButton("SelectAlternate",{
	panel = "DURA",
	button = "DURASelectAlternate",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 4,
	z = 0,
})
Metrostroi.ClientPropForButton("SelectChannel",{
	panel = "DURA",
	button = "DURAToggleChannel",
	model = "models/metrostroi_train/81/tumbler2.mdl",
})
Metrostroi.ClientPropForButton("DURAPower",{
	panel = "DURA",
	button = "DURAPowerToggle",
	model = "models/metrostroi_train/81/tumbler2.mdl",
})
--------------------------------------------------------------------------------
ENT.ClientProps["gv"] = {
	model = "models/metrostroi/81-717/gv.mdl",
	pos = Vector(130,62.5,-65),
	ang = Angle(-90,0,-90)
}
ENT.ClientProps["gv_wrench"] = {
	model = "models/metrostroi/81-717/reverser.mdl",
	pos = Vector(130,62.5,-65),
	ang = Angle(0,0,0)
}
--------------------------------------------------------------------------------
ENT.ClientProps["book"] = {
	model = "models/props_lab/binderredlabel.mdl",
	pos = Vector(418,-28,61),
	ang = Angle(0,0,90)
}

ENT.ClientProps["Ema_salon"] = {
	model = "models/metrostroi_train/em/ema_salon.mdl",
	pos = Vector(0,0,0),
	ang = Angle(0,0,0)
}
ENT.ClientProps["Ema_salon2"] = {
	model = "models/metrostroi_train/em/ema_salon2.mdl",
	pos = Vector(0,0,0),
	ang = Angle(0,0,0)
}
ENT.ClientProps["Lamps_emer"] = {
	model = "models/metrostroi_train/em/lamps_emer.mdl",
	pos = Vector(0,0,0),
	ang = Angle(0,0,0)
}
ENT.ClientProps["Lamps_full"] = {
	model = "models/metrostroi_train/em/lamps_full.mdl",
	pos = Vector(0,0,0),
	ang = Angle(0,0,0)
}

ENT.ClientProps["PB"] = {--
	model = "models/metrostroi_train/81/pb.mdl",
	pos = Vector(461, -35.05, -35.31),
	ang = Angle(0,-90,18)
}

ENT.ClientProps["FrontBrake"] = {--
	model = "models/metrostroi_train/81/tmiso.mdl",
	pos = Vector(460, -30, -55),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["FrontTrain"] = {--
	model = "models/metrostroi_train/81/nmsio.mdl",
	pos = Vector(460, 30, -55),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["RearBrake"] = {--
	model = "models/metrostroi_train/81/tmiso.mdl",
	pos = Vector(-460, -30, -55),
	ang = Angle(0,90,0)
}
ENT.ClientProps["RearTrain"] = {--
	model = "models/metrostroi_train/81/nmsio.mdl",
	pos = Vector(-460, 30, -55),
	ang = Angle(0,90,0)
}


--------------------------------------------------------------------------------
-- Add doors
local function GetDoorPosition(i,k,j)
	if j == 0
	then return Vector(383.0 - 67.49*k     - 233.4*i,-64.56*(1-2*k),1)
	else return Vector(383.0 - 67.49*(1-k) - 233.4*i,-64.56*(1-2*k),1)
	end
end
for i=0,3 do
	for k=0,1 do
		ENT.ClientProps["door"..i.."x"..k.."a"] = {
			model = "models/metrostroi_train/em/doorright.mdl",
			pos = GetDoorPosition(i,k,0),
			ang = Angle(0,90 + 180*k,0)
		}
		ENT.ClientProps["door"..i.."x"..k.."b"] = {
			model = "models/metrostroi_train/em/doorleft.mdl",
			pos = GetDoorPosition(i,k,1),
			ang = Angle(0,90 + 180*k,0)
		}
	end
end
ENT.ClientProps["door1"] = {
	model = "models/metrostroi_train/em/doorfront.mdl",
	pos = Vector(471.71,-17.1,-1),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["door2"] = {
	model = "models/metrostroi_train/em/doorback.mdl",
	pos = Vector(-471.24,17.19,-1),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["door3"] = {
	model = "models/metrostroi_train/em/doorpass.mdl",
	pos = Vector(384.14,16.95,-2.2),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["door4"] = {
	model = "models/metrostroi_train/em/doorcab.mdl",
	pos = Vector(420.75,64.26,1.5),
	ang = Angle(0,-90,0)
}
--[[ENT.ClientProps["UAVA"] = {
	model = "models/metrostroi/81-717/uava_body.mdl",
	pos = Vector(400,61,-8),--Vector(415.0,-58.5,-18.2),
	ang = Angle(0,0,0)
}]]
ENT.ClientProps["UAVALever"] = {
	model = "models/metrostroi_train/81/uavalever.mdl",
	pos = Vector(452.84598,51,-21.813349),
	ang = Angle(0,90,90)
}

ENT.ClientProps["RedLights"] = {
	model = "models/metrostroi_train/Em/redlights.mdl",
	pos = Vector(474.674042,-0.885458,55.695278),
	ang = Angle(90.000000,-0.212120,0.000000),
}
ENT.ClientProps["DistantLights"] = {
	model = "models/metrostroi_train/Em/distantlights.mdl",
	pos = Vector(471.731842,-0.651488,54.413082),
	ang = Angle(90.000000,0.000000,0.000000),
}
ENT.ClientProps["WhiteLights"] = {
	model = "models/metrostroi_train/Em/whitelights.mdl",
	pos = Vector(475.597565,-0.525079,-29.160791),
	ang = Angle(90.267662,0.000000,0.000000),
}
ENT.ClientProps["RadioLamp"] = {
	model = "models/metrostroi_train/Em/radiolight.mdl",
	pos = Vector(465.569244,29.134933,-5.466231),
	ang = Angle(90.000000,0.000000,0.000000),
}
ENT.ClientProps["RadioLamp1"] = {
	model = "models/metrostroi_train/Em/radiolight.mdl",
	pos = Vector(465.451752,31.03,-5.436231),
	ang = Angle(90.000000,0.000000,0.000000),
}


ENT.Texture = "7"
ENT.OldTexture = nil
--local X = Material( "metrostroi_skins/81-717/6.png")

function ENT:UpdateTextures()
	local texture = Metrostroi.Skins["train"][self:GetNW2String("texture")]
	local passtexture = Metrostroi.Skins["pass"][self:GetNW2String("passtexture")]
	local cabintexture = Metrostroi.Skins["cab"][self:GetNW2String("cabtexture")]
	for _,self in pairs(self.ClientEnts) do
		if not IsValid(self) then continue end
		for k,v in pairs(self:GetMaterials()) do
			local tex = string.Explode("/",v)
			tex = tex[#tex]
			if cabintexture and cabintexture.textures[tex] then
				self:SetSubMaterial(k-1,cabintexture.textures[tex])
			end
			if passtexture and passtexture.textures[tex] then
				self:SetSubMaterial(k-1,passtexture.textures[tex])
			end
			if texture and texture.textures[tex] then
				self:SetSubMaterial(k-1,texture.textures[tex])
			end
		end
	end
end
--------------------------------------------------------------------------------
function ENT:Think()
	self.BaseClass.Think(self)
	if self.Texture ~= self:GetNW2String("texture") then
		self.Texture = self:GetNW2String("texture")
		self:UpdateTextures()
	end
	if self.PassTexture ~= self:GetNW2String("passtexture") then
		self.PassTexture = self:GetNW2String("passtexture")
		self:UpdateTextures()
	end
	if self.CabinTexture ~= self:GetNW2String("cabtexture") then
		self.CabinTexture = self:GetNW2String("cabtexture")
		self:UpdateTextures()
	end
	--print(self.FrontDoor,self:GetPackedBool(114))
	--print(self.RearDoor,self:GetPackedBool(156))
	--[[
	if self.FrontDoor < 90 and self:GetPackedBool(157) or self.FrontDoor > 0 and not self:GetPackedBool(157) then
		--local FrontDoorData = self.ClientProps["door1"]
		--FrontDoor:SetLocalPos(FrontDoorData.pos + Vector(-2,-0,0))
		self.FrontDoor = math.max(0,math.min(90,self.FrontDoor + (self:GetPackedBool(157)  and 1 or -1)*self.DeltaTime*180))
		self:ApplyMatrix("door1",Vector(0,-16,0),Angle(0,self.FrontDoor,0))
		if not self.ButtonMapMatrix["InfoTable"] then
			self.ButtonMapMatrix["InfoTable"] = {}
			self.ButtonMapMatrix["InfoTable"].scale = 0.1/2
		end
		self.ButtonMapMatrix["InfoTable"].ang = Angle(0,90+self.FrontDoor,90)
		self.ButtonMapMatrix["InfoTable"].pos = Vector(458.0,-16.0,12.0) + Vector(0,1.5,0)*self.FrontDoor/90

	end
	]]
	local transient = (self.Transient or 0)*0.05
	if (self.Transient or 0) ~= 0.0 then self.Transient = 0.0 end

	-- Parking brake animation
	self.ParkingBrakeAngle = self.ParkingBrakeAngle or 0
	self.TrueBrakeAngle = self.TrueBrakeAngle or 0
	self.TrueBrakeAngle = self.TrueBrakeAngle + (self.ParkingBrakeAngle - self.TrueBrakeAngle)*2.0*(self.DeltaTime or 0)
	if self.ClientEnts and self.ClientEnts["parking_brake"] then
		self.ClientEnts["parking_brake"]:SetPoseParameter("position",1.0-((self.TrueBrakeAngle % 360)/360))
	end
	local Lamps = self:GetPackedBool(20) and 0.6 or 1
	self:ShowHideSmooth("Lamps_emer",self:Animate("lamps_emer",self:GetPackedBool("Lamps_emer") and Lamps or 0,0,1,6,false))
	self:ShowHideSmooth("Lamps_full",self:Animate("lamps_full",self:GetPackedBool("Lamps_full") and Lamps or 0,0,1,6,false))
	--ALS Lamps
	self:ShowHideSmooth("LNF",self:Animate("LNF_hs",self:GetPackedBool(41) and 1 or 0,0,1,7,false))
	self:ShowHideSmooth("L0",self:Animate("L0_hs",self:GetPackedBool(42) and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("L40",self:Animate("L40_hs",self:GetPackedBool(43) and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("L60",self:Animate("L60_hs",self:GetPackedBool(44) and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("L70",self:Animate("L70_hs",self:GetPackedBool(45) and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("L80",self:Animate("L80_hs",self:GetPackedBool(46) and 1 or 0,0,1,5,false))


	self:ShowHideSmooth("LampAutodrive",self:Animate("LampAutodrive_hs",self:GetPackedBool("KSAUP:Work") and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("Lamp2",self:Animate("Lamp2_hs",self:GetPackedBool("Lamp2") and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("Lamp1",self:Animate("Lamp1_hs",self:GetPackedBool("Lamp1") and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("Lamp6",self:Animate("Lamp6_hs",self:GetPackedBool("Lamp6") and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("Doors",self:Animate("Doors_hs",self:GetPackedBool(40) and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("DoorsWag",self:Animate("DoorsWag_hs",self:GetPackedBool("DoorsWag") and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("GreenRP",self:Animate("GreenRP_hs",self:GetPackedBool(36) and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("RedRP",self:Animate("RedRP_hs",self:GetPackedBool(35) and 1 or 0,0,1,5,false) + self:Animate("RedLSN_hs",self:GetPackedBool(131) and 1 or 0,0,0.4,5,false))
	self:ShowHideSmoothFrom("LampAutodrive_p","LampAutodrive")
	self:ShowHideSmoothFrom("Lamp2_p","Lamp2")
	self:ShowHideSmoothFrom("Lamp1_p","Lamp1")
	self:ShowHideSmoothFrom("Lamp6_p","Lamp6")
	self:ShowHideSmoothFrom("Doors_p","Doors")
	self:ShowHideSmoothFrom("DoorsWag_p","DoorsWag")
	self:ShowHideSmoothFrom("GreenRP_p","GreenRP")
	self:ShowHideSmoothFrom("RedRP_p","RedRP")


	self:Animate("AV8B",self:GetPackedBool("AV8B") and 1 or 0, 	0,1, 8, false)

	self:Animate("RST",self:GetPackedBool("RST") and 0 or 1, 	0,1, 12, false)
	self:Animate("VSOSD",self:GetPackedBool("VSOSD") and 0 or 1, 	0,1, 12, false)
	self:HideButton("RSTToggle",self:GetPackedBool("RSTPl"))
	self:HideButton("RSTPl",not self:GetPackedBool("RSTPl"))

	self:SetCSBodygroup("RSTPl",1,self:GetPackedBool("RSTPl") and 0 or 1)

	self:Animate("VU1",self:GetPackedBool("VU1") and 0 or 1, 	0,1, 12, false)
	self:Animate("VU3",self:GetPackedBool("VU3") and 0 or 1, 	0,1, 12, false)
	self:Animate("VU2",self:GetPackedBool("VU2") and 0 or 1, 	0,1, 12, false)

	self:Animate("VU",self:GetPackedBool("VU") and 0 or 1, 	0,1, 12, false)
	self:Animate("RezMK",self:GetPackedBool("RezMK") and 1 or 0, 	0,1, 7, false)

	self:Animate("VRD",self:GetPackedBool("VRD") and 0 or 1, 	0,1, 12, false)

	self:Animate("VB",self:GetPackedBool("VB") and 0 or 1, 	0,1, 8, false)

	self:Animate("VBA",self:GetPackedBool("VBA") and 0 or 1, 	0,1, 8, false)


	self:Animate("RC1",self:GetPackedBool("RC1") and 1 or 0, 	1,0.694, 6, false)
	self:Animate("RC2",self:GetPackedBool("RC2") and 1 or 0, 	1,0.694, 6, false)
	self:HideButton("RC1Toggle",self:GetPackedBool("RC1Pl"))
	self:HideButton("RC1Pl",not self:GetPackedBool("RC1Pl"))
	self:HideButton("RC2Toggle",self:GetPackedBool("RC2Pl"))
	self:HideButton("RC2Pl",not self:GetPackedBool("RC2Pl"))
	self:SetCSBodygroup("RC1Pl",1,self:GetPackedBool("RC1Pl") and 0 or 1)
	self:SetCSBodygroup("RC2Pl",1,self:GetPackedBool("RC2Pl") and 0 or 1)

	self:Animate("VRU",self:GetPackedBool("VRU") and 0 or 1, 	0,1, 12, false)
	self:Animate("VAH",self:GetPackedBool("VAH") and 0 or 1, 	0,1, 12, false)
	self:Animate("VAD",self:GetPackedBool("VAD") and 0 or 1, 	0,1, 12, false)
	self:Animate("OVT",self:GetPackedBool("OVT") and 0 or 1, 	0,1, 12, false)
	self:Animate("KSD",self:GetPackedBool("KSD") and 0 or 1, 	0,1, 12, false)
	self:Animate("DP",self:GetPackedBool("DP") and 0 or 1, 	0,1, 12, false)
	self:Animate("VKF",self:GetPackedBool("VKF") and 0 or 1, 	0,1, 12, false)

	self:HideButton("VAHToggle",self:GetPackedBool("VAHPl"))
	self:HideButton("VAHPl",not self:GetPackedBool("VAHPl"))
	self:HideButton("VADToggle",self:GetPackedBool("VADPl"))
	self:HideButton("VADPl",not self:GetPackedBool("VADPl"))
	self:HideButton("OVTToggle",self:GetPackedBool("OVTPl"))
	self:HideButton("OVTPl",not self:GetPackedBool("OVTPl"))

	self:SetCSBodygroup("VAHPl",1,self:GetPackedBool("VAHPl") and 0 or 1)
	self:SetCSBodygroup("VADPl",1,self:GetPackedBool("VADPl") and 0 or 1)
	self:SetCSBodygroup("OVTPl",1,self:GetPackedBool("OVTPl") and 0 or 1)

	self:Animate("KVT",self:GetPackedBool("KVT") and 1 or 0, 	0,1, 8, false)
	self:ShowHideSmooth("ARSLamp",self:Animate("ARSLamp_hs",self:GetPackedBool(48) and 1 or 0,0,1,5,false))
	self:Animate("VZP",self:GetPackedBool("VZP") and 1 or 0, 	0,1, 12, false)
	self:Animate("VZD",self:GetPackedBool("VZD") and 1 or 0, 	0,1, 12, false)
	self:Animate("KRZD",self:GetPackedBool("KRZD") and 1 or 0, 	0,1, 12, false)
	self:ShowHideSmooth("AutodriveLamp",self:Animate("AutodriveLamp_hs",self:GetPackedBool("KSAUP:AutodriveEngage") and 1 or 0,0,1,5,false))

	self:ShowHideSmooth("RadioLamp",self:Animate("radiolamp",self:GetPackedBool("VPR") and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("RadioLamp1",self.Anims["radiolamp"].val)

	self:ShowHideSmooth("RedLights",self:Animate("redlights",self:GetPackedBool("RedLight") and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("WhiteLights",self:Animate("whitelights",self:GetPackedBool("HeadLights2") and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("DistantLights",self:Animate("distantlights",self:GetPackedBool("HeadLights1") and 1 or 0,0,1,5,false))

	self:Animate("KDL",self:GetPackedBool("KDL") and 1 or 0, 	0,1, 12, false)
	self:Animate("DIPon",self:GetPackedBool("DIPon") and 1 or 0, 	0,1, 12, false)
	self:Animate("DIPoff",self:GetPackedBool("DIPoff") and 1 or 0, 	0,1, 12, false)
	self:Animate("VozvratRP",self:GetPackedBool("VozvratRP") and 1 or 0, 	0,1, 12, false)
	self:Animate("KSN",self:GetPackedBool("KSN") and 1 or 0, 	0,1, 12, false)
	self:Animate("KDP",self:GetPackedBool("KDP") and 1 or 0, 	0,1, 12, false)

	self:Animate("KU1",self:GetPackedBool("KU1") and 1 or 0, 	0,1, 7, false)
	self:Animate("VUD",self:GetPackedBool("VUD1") and 1 or 0, 	0,1, 7, false)


	self:Animate("VDL",self:GetPackedBool("VDL") and 1 or 0, 	0,1, 7, false)
	self:ShowHideSmooth("KTLamp",self:Animate("KT_hs",self:GetPackedBool(47) and 1 or 0,0,1,5,false))
	self:Animate("Ring",self:GetPackedBool("Ring") and 1 or 0, 	0,1, 12, false)
	self:Animate("VUS",self:GetPackedBool("VUS") and 1 or 0, 	0,1, 12, false)
	self:Animate("KAK",self:GetPackedBool("KAK") and 1 or 0, 	0,1, 12, false)
	self:Animate("VAutodrive",self:GetPackedBool("VAutodrive") and 1 or 0, 	0,1, 12, false)

	self:HideButton("VUD2Toggle",self:GetPackedBool("VUD2Bl"))
	self:HideButton("VUD2LToggle",self:GetPackedBool("VUD2LBl"))
	self:Animate("VUD2",self:GetPackedBool("VUD2") and 0 or 1, 	0,1, 7, false)
	self:Animate("VUD2l",self:GetPackedBool("VUD2L") and 1 or 0, 	0,1, 7, false)

	self:Animate("PB",self:GetPackedBool("PB") and 1 or 0,0,0.2,  12,false)

	self:Animate("brake_disconnect",self:GetPackedBool("DriverValveBLDisconnect") and 1 or 0,0,0.5,  3,false)
	self:Animate("train_disconnect",self:GetPackedBool("DriverValveTLDisconnect") and 1 or 0,0,0.5,  3,false)
	self:Animate("EPK_disconnect",self:GetPackedBool("EPK") and 1 or 0,0.5,0,  3,false)

	-- DIP sound
	--self:SetSoundState("bpsn2",self:GetPackedBool(52) and 1 or 0,1.0)

	-- Simulate pressure gauges getting stuck a little
	self:Animate("brake", 		1-self:GetPackedRatio(0), 			0.00, 0.65,  256,24)
	self:Animate("controller",		self:GetPackedRatio(1),				0, 0.31,  2,false)
	self:Animate("reverser",		self:GetPackedRatio(2),				0.26, 0.35,  4,false)
	self:Animate("volt1", 			self:GetPackedRatio(10),			0,0.244,256,2)
	self:ShowHide("reverser",		self:GetPackedBool(0))

	self:Animate("brake_line",		self:GetPackedRatio(4),				0, 0.725,  256,2)--,,0.01)
	self:Animate("train_line",		self:GetPackedRatio(5)-transient,	0, 0.725,  256,2)--,,0.01)
	self:Animate("brake_cylinder",	self:GetPackedRatio(6),	 			0, 0.721,  256,2)--,,0.03)
	self:Animate("voltmeter",			self:GetPackedRatio(7),				0.014, 0.298,256,2)
	self:Animate("ampermeter",		self:GetPackedRatio(8),				0, 0.248,256,2)
	--self:Animate("volt2",			0, 									0.38, 0.63)

	local wheel_radius = 0.5*44.1 -- units
	local speed = self:GetPackedRatio(3)*100
	local ang_vel = speed/(2*math.pi*wheel_radius)

	-- Rotate wheel
	self.Angle = ((self.Angle or math.random()) + ang_vel*self.DeltaTime) % 1.0

	self:Animate("speed1", 			self:GetPackedRatio("Speed") + math.sin(math.pi*8*self.Angle)*1/120,			0.495, 0.716,				nil, nil,  256,2,0.01)
	--self:Animate("speed1", 			/120,			0.495, 0.716,				nil, nil,  256,2,0.01)

	----
	self:Animate("door1",	self:GetPackedBool(157) and (self.Door1 or 0.99) or 0,0,0.22, 1024, 1)
	self:Animate("door3",	self:GetPackedBool(158) and (self.Door2 or 0.99) or 0,0,0.25, 1024, 1)
	self:Animate("door2",	self:GetPackedBool(156) and (self.Door3 or 0.99) or 0,0,0.25, 1024, 1)
	self:Animate("door4",	self:GetPackedBool(159) and (self.Door2 or 0.99) or 0,1,0.77, 1024, 1)

	self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,0.35, 3, false)
	self:Animate("FrontTrain",	self:GetNW2Bool("FtI") and 0 or 1,0,0.35, 3, false)
	self:Animate("RearBrake",	self:GetNW2Bool("RbI") and 1 or 0,0,0.35, 3, false)
	self:Animate("RearTrain",	self:GetNW2Bool("RtI") and 1 or 0,0,0.35, 3, false)

	self:ShowHideSmooth("AVULight_light",self:Animate("AVUl",self:GetPackedBool(38) and 1 or 0,0,1,10,false))

	-- Main switch
	if self.LastValue ~= self:GetPackedBool(5) then
		self.ResetTime = CurTime()+1.5
		self.LastValue = self:GetPackedBool(5)
	end
	self:Animate("gv_wrench",	(self:GetPackedBool(5) and 1 or 0), 	0,0.51, 128,  1,false)
	self:ShowHide("gv_wrench",	CurTime() < self.ResetTime)

	-- Animate doors
	for i=0,4 do
		for k=0,1 do
			local n_l = "door"..i.."x"..k.."a"
			local n_r = "door"..i.."x"..k.."b"
			self:Animate(n_l,self:GetPackedBool(21+(1-k)*4) and 1 or 0,0.11,0.93, 0.8 + (-0.2+0.4*math.random()),0)
			self:Animate(n_r,self:GetPackedBool(21+(1-k)*4) and 1 or 0,0.11,0.93, 0.8 + (-0.2+0.4*math.random()),0)
		end
	end

	-- Brake-related sounds
	local brakeLinedPdT = self:GetPackedRatio(9)
	local dT = self.DeltaTime
	self.BrakeLineRamp1 = self.BrakeLineRamp1 or 0

	if (brakeLinedPdT > -0.001)
	then self.BrakeLineRamp1 = self.BrakeLineRamp1 + 4.0*(0-self.BrakeLineRamp1)*dT
	else self.BrakeLineRamp1 = self.BrakeLineRamp1 + 4.0*((-0.6*brakeLinedPdT)-self.BrakeLineRamp1)*dT
	end
	self.BrakeLineRamp1 = math.Clamp(self.BrakeLineRamp1,0,1)
	self:SetSoundState("release2",self.BrakeLineRamp1^1.65,1.0)

	self.BrakeLineRamp2 = self.BrakeLineRamp2 or 0
	if (brakeLinedPdT < 0.001)
	then self.BrakeLineRamp2 = self.BrakeLineRamp2 + 4.0*(0-self.BrakeLineRamp2)*dT
	else self.BrakeLineRamp2 = self.BrakeLineRamp2 + 8.0*(0.1*brakeLinedPdT-self.BrakeLineRamp2)*dT
	end
	self.BrakeLineRamp2 = math.Clamp(self.BrakeLineRamp2,0,1)
	self:SetSoundState("release3",self.BrakeLineRamp2 + math.max(0,self.BrakeLineRamp1/2-0.15),1.0)

	self:SetSoundState("cran1",math.min(1,self:GetPackedRatio(4)/50*(self:GetPackedBool(6) and 1 or 0)),1.0)

	-- Compressor
	local state = self:GetPackedBool(20)
	self.PreviousCompressorState = self.PreviousCompressorState or false
	if self.PreviousCompressorState ~= state then
		self.PreviousCompressorState = state
		if 	state then
			self:SetSoundState("compressor_ezh",1,1)
		else
			self:SetSoundState("compressor_ezh",0,1)
			self:SetSoundState("compressor_ezh_end",0,1)
			self:SetSoundState("compressor_ezh_end",1,1)
			--self:PlayOnce("compressor_e_end",nil,1,nil,true)
		end
	end
	-- ARS/ringer alert
	state = self:GetPackedBool(39)
	self.PreviousAlertState = self.PreviousAlertState or false
	if self.PreviousAlertState ~= state then
		self.PreviousAlertState = state
		if state then
			self:SetSoundState("ring4",1,1)
		else
			self:SetSoundState("ring4",0,0)
			self:SetSoundState("ring4_end",0,1)
			self:SetSoundState("ring4_end",1,1)
			--self:PlayOnce("ring4_end","cabin",0,101)
		end
	end

	state = self:GetPackedBool("VPR")
	self.PreviousVPRState = self.PreviousVPRState or false
	if self.PreviousVPRState ~= state then
		self.PreviousVPRState = state
		if state then
			self:SetSoundState("vpr",1,1)
		else
			self:SetSoundState("vpr",0,0)
			self:PlayOnce("vpr_end","cabin",1)
		end
	end

	-- RK rotation
	if self:GetPackedBool(112) then self.RKTimer = CurTime() end
	state = (CurTime() - (self.RKTimer or 0)) < 0.2
	self.PreviousRKState = self.PreviousRKState or false
	if self.PreviousRKState ~= state then
		self.PreviousRKState = state
		if state then
			self:SetSoundState("rk_spin",0.7,1,nil,0.75)
		else
			self:SetSoundState("rk_spin",0,0,nil,0.75)
			self:SetSoundState("rk_stop",0,1,nil,0.75)
			self:SetSoundState("rk_stop",0.7,1,nil,0.75)
		end
	end

	--DIP sound
	--self:SetSoundState("bpsn2",self:GetPackedBool(32) and 1 or 0,1.0)
end

function ENT:Draw()
	self.BaseClass.Draw(self)
end

function ENT:DrawPost()
	--local dc = render.GetLightColor(self:LocalToWorld(Vector(460.0,0.0,5.0)))
	if self.InfoTableTimeout and (CurTime() < self.InfoTableTimeout) then
		self:DrawOnPanel("InfoTableSelect",function()
			draw.Text({
				text = self:GetNW2String("RouteNumber",""),
				font = "MetrostroiSubway_InfoPanel",--..self:GetNW2Int("Style",1),
				pos = { 140, -50 },
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				color = Color(255,0,0,255)})
			draw.Text({
				text = self:GetNW2String("FrontText",""),
				font = "MetrostroiSubway_InfoPanel",--..self:GetNW2Int("Style",1),
				pos = { 140, -100 },
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				color = Color(255,0,0,255)})
		end)
	end

--[[
	self:DrawOnPanel("IGLA",function()
		local plus = ((not self:GetPackedBool(32) or not self:GetPackedBool(78)) and 1 or 0)
		surface.SetDrawColor(50 - plus*40,255 - plus*220,40 - plus*40)
		surface.DrawRect(0,-4,360,60)
		if not self:GetPackedBool(32) or not self:GetPackedBool(78) then return end
		local text1 = ""
		local text2 = ""
		local C1 = Color(0,0,0,255)
		local C2 = Color(50,200,50,255)
		local flash = false
		local T = self:GetPackedRatio(11)
		local Ptrain = self:GetPackedRatio(5)*16.0
		local Pcyl = self:GetPackedRatio(6)*6.0
		local date = os.date("!*t",os_time)
		-- Default IGLA text
		text1 = "IGLA-01K     RK TEMP"
		text2 = Format("%02d:%02d:%02d       %3d C",date.hour,date.min,date.sec,T)

		-- Modifiers and conditions
		if self:GetPackedBool(25) then text1 = " !!  Right Doors !!" end
		if self:GetPackedBool(21) then text1 = " !!  Left Doors  !!" end

		if T > 300 then text1 = "Temperature warning!" end

		if self:GetPackedBool(50) and (Pcyl > 1.1) then
			text1 = "FAIL PNEUMATIC BRAKE"
			flash = true
		end
		if self:GetPackedBool(35) and
		   self:GetPackedBool(28) then
			text1 = "FAIL AVU/BRAKE PRESS"
			flash = true
		end
		if self:GetPackedBool(35) and
		   (not self:GetPackedBool(40)) then
			text1 = "FAIL SD/DOORS OPEN  "
			flash = true
		end
		if self:GetPackedBool(36) then
			text1 = "FAIL OVERLOAD RELAY "
			flash = true
		end
		if Ptrain < 5.5 then
			text1 = "FAIL TRAIN LINE LEAK"
			flash = true
		end

		if T > 400 then flash = true end
		if T > 500 then text1 = "!Disengage circuits!" end
		if T > 750 then text1 = " !! PIZDA POEZDU !! " end

		-- Draw text
		if flash and ((RealTime() % 1.0) > 0.5) then
			C2,C1 = C1,C2
		end
		for i=1,20 do
			surface.SetDrawColor(C2)
			surface.DrawRect(3+(i-1)*17.7+1,0+4,16,22)
			draw.DrawText(string.upper(text1[i] or ""),"MetrostroiSubway_IGLA",3+(i-1)*17.7,0+0,C1)
		end
		for i=1,20 do
			surface.SetDrawColor(C2)
			surface.DrawRect(3+(i-1)*17.7+1,0+24+4,16,22)
			draw.DrawText(string.upper(text2[i] or ""),"MetrostroiSubway_IGLA",3+(i-1)*17.7,0+24,C1)
		end
	end)
	]]
	--[[
	self:DrawOnPanel("DURADisplay",function()
		if not self:GetPackedBool(32) or not self:GetPackedBool(24) then return end
		local function GetColor(id, text)
			if text then
				return self:GetPackedBool(id) and Color(255,0,0) or Color(0,0,0)
			else
				return not self:GetPackedBool(id) and Color(255,255,255) or Color(0,0,0)
			end
		end
		surface.SetAlphaMultiplier(0.4)
		surface.SetDrawColor(255,255,255)
		surface.DrawRect(0,3+22.8*0,211,22.8) -- 120
		surface.SetAlphaMultiplier(1.0)
		draw.DrawText("DURA V 1.0","MetrostroiSubway_IGLA",0,0+22.8*0, Color(0,0,0,255))

		surface.SetAlphaMultiplier(0.4)
		surface.SetDrawColor(GetColor(31)) surface.SetAlphaMultiplier(0.4)
		surface.DrawRect(0,3+22.8*1,211,23) -- 120
		surface.SetAlphaMultiplier(1.0)
		draw.DrawText("Channel:" .. (self:GetPackedBool(31) and "2" or "1"),"MetrostroiSubway_IGLA",0,0+22.8*1,GetColor(31, true))

		surface.SetAlphaMultiplier(0.4)
		surface.SetDrawColor(GetColor(153)) surface.SetAlphaMultiplier(0.4)
		surface.DrawRect(0,3+22.8*2,211,23) -- 120
		surface.SetAlphaMultiplier(1.0)
		draw.DrawText("Channel1:" .. (self:GetPackedBool(153) and "Alt" or "Main"),"MetrostroiSubway_IGLA",0,0+22.8*2,GetColor(153, true))

		surface.SetAlphaMultiplier(0.4)
		surface.SetDrawColor(GetColor(154))
		surface.DrawRect(0,3+22.8*3,211,23) -- 120
		surface.SetAlphaMultiplier(1.0)
		draw.DrawText("Channel2:" .. (self:GetPackedBool(154) and "Alt" or "Main"),"MetrostroiSubway_IGLA",0,0+22.8*3,GetColor(154, true))
		surface.SetAlphaMultiplier(0.4)
		surface.SetDrawColor(255,255,255)
		surface.DrawRect(0,3+22.8*4,211,23) -- 120
		surface.SetAlphaMultiplier(1)
	end)]]

	self:DrawOnPanel("FrontPneumatic",function()
		draw.DrawText(self:GetNW2Bool("FbI") and "Isolated" or "Open","Trebuchet24",150,0,Color(0,0,0,255))
		draw.DrawText(self:GetNW2Bool("FtI") and "Isolated" or "Open","Trebuchet24",670,0,Color(0,0,0,255))
	end)
	self:DrawOnPanel("RearPneumatic",function()
		draw.DrawText(self:GetNW2Bool("RbI") and "Isolated" or "Open","Trebuchet24",150,0,Color(0,0,0,255))
		draw.DrawText(self:GetNW2Bool("RtI") and "Isolated" or "Open","Trebuchet24",670,0,Color(0,0,0,255))
	end)
	self:DrawOnPanel("AirDistributor",function()
		draw.DrawText(self:GetNW2Bool("AD") and "Air Distributor ON" or "Air Distributor OFF","Trebuchet24",0,0,Color(0,0,0,255))
	end)

	-- Draw train numbers
	local dc = render.GetLightColor(self:GetPos())
	self:DrawOnPanel("TrainNumber1",function()
		draw.DrawText(Format("%04d",self:EntIndex()),"MetrostroiSubway_LargeText3",0,0,Color(255*dc.x,255*dc.y,255*dc.z,255))
	end)
	self:DrawOnPanel("TrainNumber2",function()
		draw.DrawText(Format("%04d",self:EntIndex()),"MetrostroiSubway_LargeText3",0,0,Color(255*dc.x,255*dc.y,255*dc.z,255))
	end)
end

function ENT:OnButtonPressed(button)
	if button == "ShowHelp" then
		RunConsoleCommand("metrostroi_train_manual")
	end
	local bp_press = self:GetPackedRatio(6)
	local blocked_l = self:GetPackedBool(132) and 0 or 1
	local blocked_r = self:GetPackedBool(133) and 0 or 1
	if button == "ParkingBrakeLeft" then
		self.ParkingBrakeAngle = (self.ParkingBrakeAngle or 0) - blocked_l*45
	end
	if button == "ParkingBrakeRight" then
		self.ParkingBrakeAngle = (self.ParkingBrakeAngle or 0) + blocked_r*45
	end
	if button == "ShowHelp" then
		RunConsoleCommand("metrostroi_train_manual")
	end

	if button == "PrevSign" then
		self.InfoTableTimeout = CurTime() + 2.0
	end
	if button == "NextSign" then
		self.InfoTableTimeout = CurTime() + 2.0
	end

	if button and button:sub(1,3) == "Num" then
		self.InfoTableTimeout = CurTime() + 2.0
	end
end

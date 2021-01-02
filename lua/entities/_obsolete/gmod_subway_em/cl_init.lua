include("shared.lua")


--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}

-- Main panel
ENT.ButtonMap["Main"] = {
	pos = Vector(460.968903,-32.25375,0.064331),
	ang = Angle(0,-90,90-27),
	width = 315,
	height = 240,
	scale = 0.0588,

	buttons = {
		{ID = "DIPonSet",		x=35 + 48.3*0,  y=96, radius=20, tooltip="КУ4:Включение ДИП и освещения\nTurn DIP and interior lights on"},
		{ID = "DIPoffSet",		x=35 + 48.3*1,  y=96, radius=20, tooltip="КУ5:Отключение ДИП и освещения\nTurn DIP and interior lights off"},
		{ID = "VozvratRPSet",	x=35 + 48.3*2,  y=96, radius=20, tooltip="КУ9:Возврат РП\nReset overload relay"},
		{ID = "KSNSet",			x=35 + 48.3*3,  y=96, radius=20,  tooltip="КУ8:Принудительное срабатывание РП на неисправном вагоне (сигнализация неисправности)\nKSN: Failure indication button"},
		{ID = "KDPSet",			x=35 + 48.3*5,  y=96, radius=20, tooltip="КДП:Правые двери\nKDP: Right doors open"},
		----Down Panel
		{ID = "KU1Toggle",			x=16,y=129,w=45,h=90, tooltip="КУ1:Включение мотор-компрессора\nTurn motor-compressor on"},
		{ID = "VUD1Toggle",		x=248,y=129,w=45,h=90, tooltip="КУ2: Закрытие дверей\nVUD: Door control toggle (close doors)"},
		----Lamps
		--{ID = "Lamp1",		x=42, y=30, radius=20, tooltip="ЛВД: Лампа включения двигателей\nLVD: Engines engaged"},
		--{ID = "Lamp6",		x=86, y=30, radius=20, tooltip="ЛСТ: Лампа сигнализации торможения\nLST: Brakes engaged"},
		--{ID = "Lamp2",	x=134, y=30, radius=20, tooltip="Красная лампа РК (Вращение Реостатного контроллера)\nRK: Rheostat controller motion "},
		--{ID = "DoorsWag",		x=134, y=30, radius=20, tooltip="Синяя лампа СД: Сигнализация дверей вагона\nBlue door state light (doors on wagon are closed)"},
		{ID = "RedRP",	x=177, y=30, radius=20, tooltip="Красная РП: Красная лампа реле перегрузки\nRP: Red overload relay  (power circuits failed to assemble)"},
		{ID = "GreenRP",	x=223, y=30, radius=20, tooltip="Зеленая РП: Зелёная лампа реле перегрузки (Сигнализация перегрузки)\nRP: Green overload relay  (overload relay open on current train)"},
		{ID = "DoorsWag",		x=265, y=30, radius=20, tooltip="Белая лампа СД: Сигнализация дверей поезда\nWhite door state light (doors on train are closed)"},

		{ID = "KDLSet",			x=92, y=169, radius=20, tooltip="КУ12: Кнопка левых дверей\nKDL: Left doors open"},
		{ID = "KRZDSet",		x=212, y=169, radius=20, tooltip="КУ10: Кнопка резервного закрытия дверей\nKRZD: Emergency door closing"},

	}
}

Metrostroi.ClientPropForButton("GreenRP",{
	panel = "Main",
	button = "GreenRP",
	model = "models/metrostroi_train/e/lampgreen.mdl",
	z = 6,
	ang = 90,
	staylabel = true,
})
Metrostroi.ClientPropForButton("RedRP",{
	panel = "Main",
	button = "RedRP",
	model = "models/metrostroi_train/e/lampred1.mdl",
	z = 6,
	ang = 90,
	staylabel = true,
})
Metrostroi.ClientPropForButton("DoorsWag",{
	panel = "Main",
	button = "DoorsWag",
	model = "models/metrostroi_train/e/lampblue.mdl",
	z = 6,
	ang = 90,
	staylabel = true,
})


Metrostroi.ClientPropForButton("DIPon",{
	panel = "Main",
	button = "DIPonSet",
	model = "models/metrostroi_train/em/buttonred.mdl",
	ang = 90,
	z = 0,
})
Metrostroi.ClientPropForButton("DIPoff",{
	panel = "Main",
	button = "DIPoffSet",
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
	z=-20,
})
Metrostroi.ClientPropForButton("KU1",{
	panel = "Main",
	button = "KU1Toggle",
	model = "models/metrostroi_train/switches/vudbrown.mdl",
	z=-20,
})

ENT.ButtonMap["RezMK"] = {
	pos = Vector(469.0,-19.75,37),
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
	pos = Vector(469.5,-18.5,20),
	ang = Angle(0,270,90),
	width = 90,
	height = 120,
	scale = 0.0625,

	buttons = {
		{ID = "VUToggle", x=0, y=0, w=90, h=120, tooltip="ВУ: Выключатель Управления\nVUToggle"},
		{ID = "VUPl", x=0, y=70, w=90, h=50, tooltip="Пломба ВУ\nVU plomb"},
	}
}
Metrostroi.ClientPropForButton("VU",{
	panel = "VU",
	button = "VUToggle",
	model = "models/metrostroi_train/switches/autobl.mdl",
	z=20,
})

Metrostroi.ClientPropForButton("VUPl",{
	panel = "VU",
	button = "VUToggle",
	model = "models/metrostroi_train/switches/autoplombr.mdl",
	z=19,
	propname = false,
	ang=0,
})
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
	pos = Vector(460.647858,-58.177208,35.553993),
	ang = Angle(237.732468,23.827326,270.135559),
}

ENT.ClientProps["ampermeter"] = {
	model = "models/metrostroi_train/e/volt_needle.mdl",
	pos = Vector(460.647858,-58.177208,32.055382),
	ang = Angle(222.645691,23.000584,270.135559),
}

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

ENT.ClientProps["Em_salon"] = {
	model = "models/metrostroi_train/em/em_salon.mdl",
	pos = Vector(0,0,0),
	ang = Angle(0,0,0)
}
ENT.ClientProps["Em_salon2"] = {
	model = "models/metrostroi_train/em/em_salon2.mdl",
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

ENT.ClientProps["Lamps_full2"] = {
	model = "models/metrostroi_train/em/lamps_full_em.mdl",
	pos = Vector(0.007439,0,0),
	ang = Angle(0,0,0)
}

ENT.ClientProps["Lamps_cab_em"] = {
	model = "models/metrostroi_train/em/lamps_cab_em.mdl",
	pos = Vector(0.007439,0,0),
	ang = Angle(0,0,0)
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
	pos = Vector(403.69,16.95,-2.2),
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
}
ENT.ClientProps["UAVALever"] = {
	model = "models/metrostroi_train/81/uavalever.mdl",
	pos = Vector(452.84598,51,-21.813349),
	ang = Angle(0,90,90)
}
]]
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
	self:ShowHideSmooth("Lamps_cab_em",self.Anims["lamps_full"].val)
	self:ShowHideSmooth("Lamps_full2",self.Anims["lamps_full"].val)

	--self:ShowHideSmooth("Lamp2",self:Animate("Lamp2_hs",self:GetPackedBool("Lamp2") and 1 or 0,0,1,5,false))
	--self:ShowHideSmooth("Lamp1",self:Animate("Lamp1_hs",self:GetPackedBool("Lamp1") and 1 or 0,0,1,5,false))
	--self:ShowHideSmooth("Lamp6",self:Animate("Lamp6_hs",self:GetPackedBool("Lamp6") and 1 or 0,0,1,5,false))
	--self:ShowHideSmooth("Doors",self:Animate("Doors_hs",self:GetPackedBool(40) and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("DoorsWag",self:Animate("DoorsWag_hs",self:GetPackedBool("DoorsWag") and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("GreenRP",self:Animate("GreenRP_hs",self:GetPackedBool(36) and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("RedRP",self:Animate("RedRP_hs",self:GetPackedBool(35) and 1 or 0,0,1,5,false) + self:Animate("RedLSN_hs",self:GetPackedBool(131) and 1 or 0,0,0.4,5,false))


	self:Animate("AV8B",self:GetPackedBool("AV8B") and 1 or 0, 	0,1, 8, false)

	self:Animate("VU1",self:GetPackedBool("VU1") and 0 or 1, 	0,1, 12, false)
	self:Animate("VU3",self:GetPackedBool("VU3") and 0 or 1, 	0,1, 12, false)
	self:Animate("VU2",self:GetPackedBool("VU2") and 0 or 1, 	0,1, 12, false)

	self:Animate("VU",self:GetPackedBool("VU") and 0 or 1, 	0,1, 12, false)
	self:Animate("RezMK",self:GetPackedBool("RezMK") and 1 or 0, 	0,1, 7, false)

	self:HideButton("VUToggle",self:GetPackedBool("VUPl"))
	self:HideButton("VUPl",not self:GetPackedBool("VUPl"))

	self:SetCSBodygroup("VUPl",1,self:GetPackedBool("VUPl") and 0 or 1)


	self:Animate("VB",self:GetPackedBool("VB") and 0 or 1, 	0,1, 8, false)


	self:Animate("KRZD",self:GetPackedBool("KRZD") and 1 or 0, 	0,1, 12, false)

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


--	self:Animate("VDL",self:GetPackedBool("VDL") and 1 or 0, 	0,1, 7, false)

	self:Animate("VUD2",self:GetPackedBool("VUD2") and 0 or 1, 	0,1, 7, false)
	self:Animate("VUD2l",self:GetPackedBool("VUD2L") and 1 or 0, 	0,1, 7, false)

	self:Animate("brake_disconnect",self:GetPackedBool("DriverValveBLDisconnect") and 1 or 0,0,0.5,  3,false)
	self:Animate("train_disconnect",self:GetPackedBool("DriverValveTLDisconnect") and 1 or 0,0,0.5,  3,false)

	-- DIP sound
	--self:SetSoundState("bpsn2",self:GetPackedBool(52) and 1 or 0,1.0)

	-- Simulate pressure gauges getting stuck a little
	self:Animate("brake", 		1-self:GetPackedRatio(0), 			0.00, 0.65,  256,24)
	self:Animate("controller",		self:GetPackedRatio(1),				0, 0.31,  2,false)
	self:Animate("reverser",		self:GetPackedRatio(2),				0.26, 0.35,  4,false)
	self:ShowHide("reverser",		self:GetPackedBool(0))

	self:Animate("brake_line",		self:GetPackedRatio(4),				0, 0.725,  256,2)--,,0.01)
	self:Animate("train_line",		self:GetPackedRatio(5)-transient,	0, 0.725,  256,2)--,,0.01)
	self:Animate("brake_cylinder",	self:GetPackedRatio(6),	 			0, 0.721,  256,2)--,,0.03)
	self:Animate("voltmeter",			self:GetPackedRatio(7),				0.014, 0.298,256,2)
	self:Animate("ampermeter",		self:GetPackedRatio(8),				0, 0.248,256,2)
	--self:Animate("volt2",			0, 									0.38, 0.63)
	----
	self:Animate("door1",	self:GetPackedBool(157) and (self.Door1 or 0.99) or 0,0,0.22, 1024, 1)
	self:Animate("door3",	self:GetPackedBool(158) and (self.Door2 or 0.99) or 0,0,0.25, 1024, 1)
	self:Animate("door2",	self:GetPackedBool(156) and (self.Door3 or 0.99) or 0,0,0.25, 1024, 1)
	self:Animate("door4",	self:GetPackedBool(159) and (self.Door2 or 0.99) or 0,1,0.77, 1024, 1)

	self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,0.35, 3, false)
	self:Animate("FrontTrain",	self:GetNW2Bool("FtI") and 0 or 1,0,0.35, 3, false)
	self:Animate("RearBrake",	self:GetNW2Bool("RbI") and 1 or 0,0,0.35, 3, false)
	self:Animate("RearTrain",	self:GetNW2Bool("RtI") and 1 or 0,0,0.35, 3, false)

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
	local state = self:GetPackedBool(39)
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

	-- RK rotation
	if self:GetPackedBool(112) then self.RKTimer = CurTime() end
	local state = (CurTime() - (self.RKTimer or 0)) < 0.2
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

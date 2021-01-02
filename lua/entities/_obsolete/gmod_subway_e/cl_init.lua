include("shared.lua")


--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}

-----
-- ALS Panel
-----
ENT.ButtonMap["OldARS"] = {
	pos = Vector(445.38,-57.98,18.49),
	ang = Angle(0,-90-37.9,90),
	width = 60,
	height = 140,
	scale = 0.0625,

	buttons = {
		{ID = "L80",		x=10,75,  y=13,57, w=25,h=12, tooltip="ALS80"},
		{ID = "L70",		x=10,75,  y=30,57, w=25,h=12, tooltip="ALS70"},
		{ID = "L60",		x=10,75,  y=46,57, w=25,h=12, tooltip="ALS60"},
		{ID = "L40",		x=10,75,  y=61,57, w=25,h=12, tooltip="ALS40"},
		{ID = "L0",			x=10,75,  y=76,7, w=25,h=12, tooltip="ALS0"},
		{ID = "LOCh",		x=10,75,  y=91,57, w=25,h=12, tooltip="OCH"},
	}
}

-- Main panel
ENT.ButtonMap["Main"] = {
	pos = Vector(439.7+12.15,-31.99,0.05),
	ang = Angle(0,-90,90-27),
	width = 315,
	height = 240,
	scale = 0.0588,

	buttons = {
		{ID = "DIPonSet",		x=39 + 51*0-1,  y=94, radius=20, tooltip="КУ4:Включение ДИП и освещения\nTurn DIP and interior lights on"},
		{ID = "DIPoffSet",		x=35 + 51*1.03-1,  y=94, radius=20, tooltip="КУ5:Отключение ДИП и освещения\nTurn DIP and interior lights off"},
		{ID = "VozvratRPSet",	x=35 + 51*2-1,  y=94, radius=20, tooltip="КУ9:Возврат РП\nReset overload relay"},
		{ID = "KSNSet",			x=35 + 51*2.98-1,  y=94, radius=20,  tooltip="КУ8:Принудительное срабатывание РП на неисправном вагоне (сигнализация неисправности)\nKSN: Failure indication button"},
		{ID = "KVTSet",	x=35 + 51*3.92-1,  y=94, radius=20, tooltip="КБ: Кнопка Бдительности\nKB: Attention button"},
		{ID = "KDPSet",			x=35 + 51*4.85-1,  y=94, radius=20, tooltip="КДП:Правые двери\nKDP: Right doors open"},
		----Down Panel
		{ID = "KU1Toggle",			x=17,y=128,w=45,h=90, tooltip="КУ1:Включение мотор-компрессора\nTurn motor-compressor on"},
		{ID = "KRPSet",		x=135,y=128,w=45,h=90, tooltip="КРР: Резервное реверсирование"},
		{ID = "VUD1Toggle",		x=253,y=128,w=45,h=90, tooltip="КУ2: Закрытие дверей\nVUD: Door control toggle (close doors)"},
		{ID = "ALSToggle", x=217,y=220,radius=20, tooltip="АЛС: Автоматическая локомотивная сигнализация\nAdditional lighning"},
		{ID = "L_3Toggle",		x=94, y=220, radius=20, tooltip="Освещение приборов\nPanel lighting"},
		----Lamps
		{ID = "GreenRPLight",	x=181, y=29.07, radius=20, tooltip="Зеленая РП: Зелёная лампа реле перегрузки (Сигнализация перегрузки)\nRP: Green overload relay light (overload relay open on current train)"},
		{ID = "RedRPLight",	x=226.8, y=29.07, radius=20, tooltip="Красная РП: Красная лампа реле перегрузки\nRP: Red overload relay light (power circuits failed to assemble)"},
		{ID = "RedRP2Light",	x=138, y=29.07, radius=20, tooltip="Красная лампа РК (Вращение Реостатного контроллера)\nRK: Rheostat controller motion light"},
		{ID = "LVD",		x=47, y=29.07, radius=20, tooltip="ЛВД: Лампа включения двигателей\nLVD: Engines engaged"},
		{ID = "LST",		x=90, y=29.07, radius=20, tooltip="ЛСТ: Лампа сигнализации торможения\nLST: Brakes engaged"},
		{ID = "BlueLight",		x=270.6, y=29.1, radius=20, tooltip="Синяя лампа СД: Сигнализация дверей поезда\nBlue door state light (doors are closed)"},


		--{ID = "RezMKSet",		x=66,  y=80, radius=20, tooltip="Резервное включение мотор-компрессора\nEmergency motor-compressor startup"},
		--{ID = "VAHToggle",		x=187, y=19, radius=20, tooltip="ВАХ: Включение аварийного хода (неисправность реле педали безопасности)\nVAH: Emergency driving mode (failure of RPB relay)"},
		--{ID = "VADToggle",		x=226, y=19, radius=20, tooltip="ВАД: Включение аварийного закрытия дверей (неисправность реле контроля дверей)\nVAD: Emergency door close override (failure of KD relay)"},

		--{ID = "ARSToggle",		x=187+77, y=19, radius=20, tooltip="АРС: Включение системы автоматического регулирования скорости\nARS: Automatic speed regulation"},
		--{ID = "ALSToggle",		x=226+77, y=19, radius=20, tooltip="АЛС: Включение системы автоматической локомотивной сигнализации\nALS: Automatic locomotive signalling"},

		--{ID = "OtklAVUToggle",	x=349, y=19, radius=20, tooltip="Отключение автоматического выключения управления (неисправность реле АВУ)\nTurn off automatic control disable relay (failure of AVU relay)"},
		--{ID = "VUD1Toggle",		x=393, y=80, radius=20, tooltip="ВУД1: Выключатель управления дверьми\nVUD1: Door control toggle (close doors)"},

		--{ID = "DoorSelectToggle",x=321, y=75, radius=20, tooltip="Выбор стороны открытия дверей\nSelect side on which doors will open"},
		{ID = "KDLSet",			x=97, y=168, radius=20, tooltip="КУ12: Кнопка левых дверей\nKDL: Left doors open"},
		{ID = "KRZDSet",		x=217, y=168, radius=20, tooltip="КУ10: Кнопка резервного закрытия дверей\nKRZD: Emergency door closing"},
		--{ID = "KDPSet",			x=349, y=122, radius=20, tooltip="КДП: Кнопка правых дверей\nKDP: Right doors open"},

		--{ID = "KVTSet",			x=240, y=122, radius=20, tooltip=""},
		--{ID = "KSNSet",			x=240, y=78, radius=20,  tooltip="КСН: Кнопка сигнализации неисправности\nKSN: Failure indication button"},
		--{ID = "KRPSet",			x=192, y=122, radius=20, tooltip="КРП: Кнопка резервного пуска"},

		--{ID = "R_Program1Set",	x=112, y=127, radius=20, tooltip="Программа 1\nProgram 1"},
		--{ID = "R_Program2Set",	x=149, y=127, radius=20, tooltip="Программа 2\nProgram 2"},

		--{ID = "R_UNchToggle",	x=112, y=30, radius=20, tooltip="УНЧ: Усилитель низких частот\nUNCh: Low frequency amplifier"},
		--{ID = "R_ZSToggle",		x=149, y=30, radius=20, tooltip="ЭС: Контроль экстренной связи\nES: Emergency communication control"},
		--{ID = "R_RadioToggle",	x=112, y=80, radius=20, tooltip="Радиоинформатор (встроеный)\nRadioinformator: Announcer (built-in)"},
		--{ID = "R_GToggle",		x=149, y=80, radius=20, tooltip="Громкоговоритель\nLoudspeaker: Sound in cabin enable"},

	}
}

--VU1 Panel
ENT.ButtonMap["VU1"] = {
	pos = Vector(451.0+9,-17.15,32),
	ang = Angle(0,270,90),
	width = 100,
	height = 240,
	scale = 0.0625,

	buttons = {
		{ID = "VUSToggle", x=0, y=0, w=100, h=110, tooltip="Прожектор\nVUSoggle"},
		{x=50,y=170,radius=50,tooltip="Напряжение цепей управления"},
	}
}
--VUSToggle
Metrostroi.ClientPropForButton("VUS",{
	panel = "VU1",
	button = "VUSToggle",
	model = "models/metrostroi_train/switches/autobr.mdl",
	ang = 270,
	z=20,
})

--VU Panel
ENT.ButtonMap["VU"] = {
	pos = Vector(451.0+8.6,-17.15,17.5),
	ang = Angle(0,270,90),
	width = 100,
	height = 240,
	scale = 0.0625,

	buttons = {
		{ID = "VUToggle", x=0, y=100, w=100, h=140, tooltip="ВУ: Выключатель Управления\nVUToggle"},
		{ID = "RezMKToggle", x=30, y=20, w=50, h=100, tooltip="КУ15:Резервное включение мотор-компрессора\nRezMKSet"},
	}
}

ENT.ButtonMap["AVMain"] = {
	pos = Vector(387.4+14.15,38.8,56),
	ang = Angle(0,90,90),
	width = 335,
	height = 500,
	scale = 0.0625,

	buttons = {
		{ID = "AV8BToggle", x=0, y=0, w=300, h=600, tooltip="АВ-8Б: Автоматическй выключатель (Вспомогательные цепи высокого напряжения)\n"},
	}
}
---AV1 Panel
ENT.ButtonMap["AV1"] = {
	pos = Vector(387.414+14.15,39,23),
	ang = Angle(0,90,90),
	width = 290+0,
	height = 155,
	scale = 0.0625,

	buttons = {
		{ID = "VU1Toggle", x=0, y=0, w=100, h=140, tooltip="ВУ1: Печь отопления кабины ПТ-6\n"},
		{ID = "VU2Toggle", x=100, y=0, w=100, h=140, tooltip="ВУ2: Аварийное освещение 25В\n"},
		{ID = "VU3Toggle", x=200, y=0, w=100, h=140, tooltip="ВУ3: Освещение кабины\n"},
	}
}

ENT.ButtonMap["AV2"] = {
	pos = Vector(401.4,19.15,45.3),
	ang = Angle(0,90,90),
	width = 295,
	height = 155,
	scale = 0.0625,

	buttons = {
		{ID = "RSTToggle", x=0, y=0, w=295, h=155, tooltip="РСТ: Радиооповещение и поездная радио связь\nVB: А62"},
	}
}

--[ARS/Speedometer panel
ENT.ButtonMap["ARS"] = {
	pos = Vector(449.1+12.15,-37.3,4.9),
	ang = Angle(0,-97.9,69),
	width = 410*10,
	height = 95*10,
	scale = 0.0625/10,

	buttons = {
		--{x=2045,y=406,tooltip="Индикатор скорости\nSpeed indicator",radius=130},
		--{x=2610,y=363,tooltip="РП: Красная лампа реле перегрузки\nRP: Red overload relay light (power circuits failed to assemble)",radius=120},
		--{x=2982,y=363,tooltip="РП: Красная лампа реле перегрузки\nRP: Red overload relay light (power circuits failed to assemble)",radius=120},
		--{x=1070+320*0,y=780,tooltip="ЛхРК: Лампа хода реостатного контроллера\nLhRK: Rheostat controller motion light",radius=120},
		--{x=1070+320*1,y=780,tooltip="КТ: Контроль тормоза\nKT: ARS braking indicator",radius=120},
		--{x=1070+320*2,y=780,tooltip="КВД: Контроль выключения двигателей\nKVD: ARS engine shutdown indicator",radius=120},
		--{x=1070+320*3,y=780,tooltip="НР1: Нулевое реле\nNR1: Zero relay state (high voltage enabled)",radius=120},
		--{x=1070+320*4,y=780,tooltip="ВПР: Контроль включения поездной радиосвязи\nVPR: Train radio equipment enabled",radius=120},
		--{x=1070+320*5,y=780,tooltip="ПЕЧЬ: Индикатор работы печи\nPECH: Cabin heating indicator",radius=120},
		--{x=1070+320*6,y=780,tooltip="АВУ: Автоматический выключатель управления\nAVU: Automatic control disabler active",radius=120},

		--{x=1070+380*0,y=570,tooltip="ОЧ: Отсутствие частоты АРС\nOCh: No ARS frequency",radius=120},
		--{x=1070+380*1,y=570,tooltip="0: Сигнал АРС остановки\n0: ARS stop signal",radius=120},
		--{x=1070+380*2,y=570,tooltip="40: Ограничение скорости 40 км/ч\nSpeed limit 40 kph",radius=120},
		--{x=1070+380*3,y=570,tooltip="60: Ограничение скорости 60 км/ч\nSpeed limit 60 kph",radius=120},
		--{x=1070+380*4,y=570,tooltip="70: Ограничение скорости 70 км/ч\nSpeed limit 70 kph",radius=120},
		--{x=1070+380*5,y=570,tooltip="80: Ограничение скорости 80 км/ч\nSpeed limit 80 kph",radius=120},

		--{x=1080+380*0,y=363,tooltip="СД: Сигнализация дверей\nSD: Door state light (doors are closed/door circuits are OK)",radius=120},
		--{x=1080+380*1,y=363,tooltip="РП: Зелёная лампа реле перегрузки\nRP: Green overload relay light (overload relay open on current train)",radius=120},
	}
}


ENT.ButtonMap["VAH"] = {
	pos = Vector(400.9,-26.24,38),
	ang = Angle(0,90,90),
	width = 150,
	height = 260,
	scale = 0.0625,

	buttons = {
		{ID = "VAHToggle",		x=30,y=0,w=90,h=130 , tooltip="ВАХ: Включение аварийного хода (неисправность реле педали безопасности)\nVAH: Emergency driving mode (failure of RPB relay)"},
		{ID = "VADToggle",		x=30,y=130,w=90,h=130 , tooltip="ВАД: Включение аварийного закрытия дверей (неисправность реле контроля дверей)\nVAD: Emergency door close override (failure of KD relay)"},
	}
}
-- AV panel
ENT.ButtonMap["AV"] = {
	pos = Vector(394.0+14,-53.5,44.5),
	ang = Angle(0,90,90),
	width = 520,
	height = 550,
	scale = 0.0625,

	buttons = {
		{ID = "ARSToggle",		x=152,y=212,w=230,h=140 , tooltip="ARS"},
		----------
		{x=33,y=411,tooltip="Регулятор давления АК",radius=70},
		{x=90,y=379,tooltip="Соединительные зажимы",w=375,h=230},
		{x=390,y=377,tooltip="Кнопка РРП",w=100,h=100},
	}
}
-- Battery panel
ENT.ButtonMap["Battery"] = {
	pos = Vector(387.414+12.15,19.2,28.8),
	ang = Angle(0,90,90),
	width = 290+0,
	height = 155,
	scale = 0.0625,

	buttons = {
		{ID = "VBToggle", x=0, y=0, w=290, h=155, tooltip="АБ: Выключатель аккумуляторной батареи (Вспомогательные цепи низкого напряжения)(\nVB: Battery on/off"},
	}
}

-- Parking brake panel
ENT.ButtonMap["ParkingBrake"] = {
	pos = Vector(454,43.0,2.0),
	ang = Angle(0,-84,90),
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
	pos = Vector(446.83,58,25),
	ang = Angle(0,-25,90),
	width = 64,
	height = 144,
	scale = 0.0625,

	buttons = {
		{ID = "VUD2Toggle", x=32, y=42, radius=32, tooltip="ВУД2: Выключатель управления дверьми\nVUD2: Door control toggle (close doors)"},
		{ID = "VDLSet",     x=32, y=138, radius=32, tooltip="ВДЛ: Выключатель левых дверей\nVDL: Left doors open"},
	}
}

-- Help panel
ENT.ButtonMap["Help"] = {
	pos = Vector(410,-45,62),
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
	pos = Vector(453.915771,-53.891716,19.525063),
	ang = Angle(0,-145,90),
	width = 110,
	height = 110,
	scale = 0.0625,

	buttons = {
		{x=55,y=55,radius=55,tooltip="Давление в магистралях (красная: тормозной, чёрная: напорной)\nPressure in pneumatic lines (red: brake line, black: train line)"},
	}
}
-- Pneumatic instrument panel
ENT.ButtonMap["PneumaticPanels"] = {
	pos = Vector(455.838104,-51.486084,9.136534),
	ang = Angle(0,-115,90),
	width = 60,
	height = 60,
	scale = 0.0625,

	buttons = {
		{x=30,y=30,radius=30,tooltip="Тормозной манометр: Давление в тормозных цилиндрах (ТЦ)\nBrake cylinder pressure"},
	}
}
ENT.ButtonMap["BLDisconnect"] = {
	pos = Vector(420+25.15,-56.0-6,-25),
	ang = Angle(90,180,0),
	width = 200,
	height = 90,
	scale = 0.0625,

	buttons = {
		{ID = "DriverValveBLDisconnectToggle", x=0, y=0, w=200, h=90, tooltip="Кран двойной тяги тормозной магистрали\nTrain line disconnect valve"},
	}
}
ENT.ButtonMap["TLDisconnect"] = {
	pos = Vector(420+25.15*1.1,-56.0+6-6,-25),
	ang = Angle(90,180,0),
	width = 200,
	height = 90,
	scale = 0.0625,

	buttons = {
		--{ID = "EPKToggle", x=0, y=0, w=200, h=90, tooltip="Кран ЭПК\nEPK disconnect valve"}
		{ID = "DriverValveTLDisconnectToggle", x=0, y=0, w=200, h=90, tooltip="Кран двойной тяги напорной магистрали\nBrake line disconnect valve"},
	}
}
ENT.ButtonMap["EPKDiscoonect"] = {
	pos = Vector(430.476318,-56.581806,-39.564163),
	ang = Angle(0,0,0),
	width = 200,
	height = 90,
	scale = 0.0625,

	buttons = {
		{ID = "EPKToggle", x=0, y=0, w=200, h=90, tooltip="Кран ЭПК\nEPK disconnect valve"}
		--{ID = "DriverValveTLDisconnectToggle", x=0, y=0, w=200, h=90, tooltip="Клапан разобщения\nDriver valve disconnect valve"},
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
ENT.ButtonMap["AVU"] = {
	pos = Vector(453.71597,-19.63482,39.93294),
	ang = Angle(-8,-90+21.5,90+15),
	width = 105,
	height = 85,
	scale = 0.0625,

	buttons = {
		{ID = "AVULight", x=30, y=20, radius=20, tooltip="АВУ: Автоматический выключатель управления\nAVU: Automatic control disabler active"},
		{ID = "OtklAVUToggle", x=30, y=60, radius=20, tooltip="Отключение автоматического выключения управления (неисправность АВУ)\nTurn off automatic control disable relay (failure of AVU)"},

	}
}

ENT.ButtonMap["DURADisplay"] = {
	pos = Vector(408+15-0.75+12.15,-58.0-5.3+1.5625,-6.65),
	ang = Angle(0,180,0),
	width = 240,
	height = 80,
	scale = 0.0625/3.2,
}

ENT.ButtonMap["Announcer"] = {
	pos = Vector(434.3+12.15,-50,40.4),
	ang = Angle(0,-130,90+50),
	width = 170,
	height = 100,
	scale = 0.0625,

	buttons = {

		{ID = "Custom2Set", x=155, y=15, radius=15, tooltip="+"},
		{ID = "Custom1Set", x=155, y=42, radius=15, tooltip="-"},
		{ID = "Custom3Set", x=85, y=72, radius=20, tooltip="Меню\nMenu"},
		{ID = "CustomCToggle", x=20, y=28, radius=20, tooltip="Автоинформатор\nAutoannouncer"},

		{ID = "CustomD", x=95+20*-3, y=72, radius=10, tooltip="Информатор: Конечная\nAnnouncer: Last statuon"},
		{ID = "CustomE", x=95+20*-2, y=72, radius=10, tooltip="Информатор: Платформа справа\nAnnouncer: Right side"},
		{ID = "CustomF", x=95+20*1, y=72, radius=10, tooltip="Информатор: Необходима настройка\nAnnouncer: Need setup"},
		{ID = "CustomG", x=95+20*2, y=72, radius=10, tooltip="Информатор: Проигрывание объявления\nAnnouncer: Playing announce"},
	}
}
-- Announcer panel
ENT.ButtonMap["AnnouncerDisplay"] = {
	pos = Vector(434.3+12.15,-50,40.4),
	ang = Angle(0,-130,90+50),
	width = 10,
	height = 10,
	scale = 0.012,
}

ENT.ButtonMap["Meters"] = {
	pos = Vector(453.844452,-56.7,38.7),
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
	pos = Vector(453.22702,-53.241482,28),
	ang = Angle(0,-145,90),
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
	pos = Vector(466,-45.0,-50.0),
	ang = Angle(0,90,90),
	width = 900,
	height = 100,
	scale = 0.1,
	buttons = {
		{ID = "FrontBrakeLineIsolationToggle",x=189, y=50, radius=32, tooltip="Концевой кран тормозной магистрали"},
		{ID = "FrontTrainLineIsolationToggle",x=710, y=50, radius=32, tooltip="Концевой кран напорной магистрали"},
	}
}
ENT.ButtonMap["RearPneumatic"] = {
	pos = Vector(-466,45.0,-50.0),
	ang = Angle(0,270,90),
	width = 900,
	height = 100,
	scale = 0.1,
	buttons = {
		{ID = "RearTrainLineIsolationToggle",x=189, y=50, radius=32, tooltip="Концевой кран напорной магистрали"},
		{ID = "RearBrakeLineIsolationToggle",x=710, y=50, radius=32, tooltip="Концевой кран тормозной магистрали"},
	}
}
ENT.ButtonMap["GV"] = {
	pos = Vector(160,66,-52),
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
	pos = Vector(-445,-68,-12.5),
	ang = Angle(0,0,90),
	width = 130,
	height = 55,
	scale = 0.20,
}
ENT.ButtonMap["TrainNumber2"] = {
	pos = Vector(396,68,-12.5),
	ang = Angle(0,180,90),
	width = 130,
	height = 55,
	scale = 0.20,
}

-- Front info table
ENT.ButtonMap["InfoTable"] = {
	pos = Vector(458.0+12.15,-16.0,12.0),
	ang = Angle(0,90,90),
	width = 646,
	height = 100,
	scale = 0.1/2,
}
ENT.ButtonMap["InfoTableSelect"] = {
	pos = Vector(454.0+12.15,-27.0,27.0),
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

ENT.ButtonMap["InfoRoute"] = {
	pos = Vector(451.29+12.15,39.9,24.2),
	ang = Angle(0,97.3,84),
	width = 100,
	height = 100,
	scale = 0.115,
}

ENT.ButtonMap["FrontDoor"] = {
	pos = Vector(455+12.15,16,48.4),
	ang = Angle(0,-90,90),
	width = 550,
	height = 1900,
	scale = 0.1/2,
	buttons = {
		{ID = "FrontDoor",x=0,y=0,w=550,h=1900, tooltip="Передняя дверь\nFront door"},
	}
}

ENT.ButtonMap["CabinDoor"] = {
	pos = Vector(408.9,64,50.8),
	ang = Angle(0,0,90),
	width = 642,
	height = 1900,
	scale = 0.1/2,
	buttons = {
		{ID = "CabinDoor1",x=0,y=0,w=642,h=1900, tooltip="Дверь в кабину машиниста\nCabin door"},
	}
}

ENT.ButtonMap["PassengerDoor"] = {
	pos = Vector(390+8,-16,48.4),
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
ENT.ClientProps["brake334"] = {
	model = "models/metrostroi_train/81/334cran.mdl",
	pos = Vector(449.2,-54.2,3.7),
	ang = Angle(0,47,0)
}
--[[ENT.ClientProps["brake334_body"] = {
	model = "models/metrostroi/81-717/brake334_body.mdl",
	pos = Vector(442+12.15,-56.85,1.0),
	ang = Angle(0,0,0)
}]]
ENT.ClientProps["controller"] = {
	model = "models/metrostroi_train/e/kv.mdl",
	pos = Vector(452.36,-25.6,2),
	ang = Angle(0,90+23,0)
}
ENT.ClientProps["reverser"] = {
	model = "models/metrostroi/81-717/reverser.mdl",
	pos = Vector(452.36,-25.6,2),
	ang = Angle(0,45,90)
}
ENT.ClientProps["brake_disconnect"] = {
	model = "models/metrostroi/81-717/uava.mdl",
	pos = Vector(442.73816,-58.73211,-32.45488),
	ang = Angle(0,-90,0),
}
ENT.ClientProps["train_disconnect"] = {
	model = "models/metrostroi/81-717/uava.mdl",
	pos = Vector(445.34006,-54.19079,-32.45488),
	ang = Angle(0,-90,0),
	color = Color(0,212,255),
}
ENT.ClientProps["EPK_disconnect"] = {
	model = "models/metrostroi/81-717/uava.mdl",
	pos = Vector(434.476318,-58.581806,-39.564163),
	ang = Angle(0.000000,-90.000000,-90.000000),
}
ENT.ClientProps["parking_brake"] = {
	model = "models/metrostroi/81-717/ezh_koleso.mdl",
	pos = Vector(450.58,31.19,-10.0),
	ang = Angle(-90,0,0),
}
--------------------------------------------------------------------------------
ENT.ClientProps["train_line"] = {
	model = "models/metrostroi_train/e/black_pneumo_needle.mdl",
	pos = Vector(451.33,-56.03,13.2),
	ang = Angle(87,-90-54,90)
}
ENT.ClientProps["brake_line"] = {
	model = "models/metrostroi_train/e/red_pneumo_needle.mdl",
	pos = Vector(451.3,-56.00,13.2),
	ang = Angle(87,-90-54,90)
}
ENT.ClientProps["brake_cylinder"] = {
	model = "models/metrostroi_train/e/small_pneumo_needle.mdl",
	pos = Vector(455.4155,-53.31028,7.21621),--pos = Vector(450.5,-32.9,10.4),
	ang = Angle(180,-90-24.96,90),
	scale = 1.5,
}
--------------------------------------------------------------------------------
ENT.ClientProps["voltmeter"] = {
	model = "models/metrostroi_train/e/volt_needle.mdl",
	pos = Vector(451.284607,-57.260746,35.1),
	ang = Angle(92,33.3,-90)
}
ENT.ClientProps["ampermeter"] = {
	model = "models/metrostroi_train/e/volt_needle.mdl",
	pos = Vector(451.302399,-57.287834,31.31461),
	ang = Angle(92,33.3,-90)
}
ENT.ClientProps["volt1"] = {
	model = "models/metrostroi_train/e/volt_bat_needle.mdl",
	pos = Vector(458.41455,-20.33349,19.95662),
	ang = Angle(1,90+2.299,-90)
}
ENT.ClientProps["speed1"] = {--
	--model = "models/metrostroi_train/e/speed_needle.mdl",
	model = "models/metrostroi_train/e/black_pneumo_needle.mdl",
	pos = Vector(448.42697,-56.81982,21.85731),
	ang = Angle(90,-145,90)
}
--[[ENT.ClientProps["volt2"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(447.6,-35.3,5.0),
	ang = Angle(90,0,180)
}]]




--------------------------------------------------------------------------------
--[[ENT.ClientProps["headlights"] = {
	model = "models/metrostroi/81-717/switch04.mdl",
	pos = Vector(443.1,-60.0,0.5),
	ang = Angle(-74,0,0)
}
ENT.ClientProps["panellights"] = {
	model = "models/metrostroi/81-717/switch04.mdl",
	pos = Vector(444.1,-59.3,3.3),
	ang = Angle(-74,0,0)
}]]
--------------------------------------------------------------------------------
--[[
		{ID = "DIPonSet",		x=35 + 50*0,  y=95, radius=20, tooltip="Включение ДИП и освещения\nTurn DIP and interior lights on"},
		{ID = "DIPoffSet",		x=35 + 50*1,  y=95, radius=20, tooltip="Выключение ДИП и освещения\nTurn DIP and interior lights off"},
		{ID = "VozvratRPSet",	x=35 + 50*2,  y=95, radius=20, tooltip="Возврат реле перегрузки\nReset overload relay"},
		{ID = "KSNSet",			x=35 + 50*3,  y=95, radius=20,  tooltip="КСН: Кнопка сигнализации неисправности\nKSN: Failure indication button"},
		{ID = "KDPSet",			x=35 + 50*4.95,  y=95, radius=20, tooltip="КДП: Кнопка правых дверей\nKDP: Right doors open"},

		{ID = "KDLSet",			x=95, y=170, radius=20, tooltip="КДЛ: Кнопка левых дверей\nKDL: Left doors open"},
		{ID = "KRZDSet",		x=217, y=170, radius=20, tooltip="КРЗД: Кнопка резервного закрытия дверей\nKRZD: Emergency door closing"},

		{ID = "KU1Toggle",			x=17,y=130,w=45,h=90, tooltip="Включение мотор-компрессора\nTurn motor-compressor on"},
		{ID = "VUD1Toggle",		x=253,y=130,w=45,h=90, radius=20, tooltip="ВУД: Выключатель управления дверьми\nVUD: Door control toggle (close doors)"},
]]
Metrostroi.ClientPropForButton("DIPon",{
	panel = "Main",
	button = "DIPonSet",
	model = "models/metrostroi_train/e/buttonwhite.mdl",
	ang = 0,
	z = -6,
})
Metrostroi.ClientPropForButton("VozvratRP",{
	panel = "Main",
	button = "VozvratRPSet",
	model = "models/metrostroi_train/e/buttonwhite.mdl",
	ang = 0,
	z = -6,
})
Metrostroi.ClientPropForButton("KVT",{
	panel = "Main",
	button = "KVTSet",
	model = "models/metrostroi_train/e/buttonwhite.mdl",
	ang = 0,
	z = -6,
})
Metrostroi.ClientPropForButton("DIPoff",{
	panel = "Main",
	button = "DIPoffSet",
	model = "models/metrostroi_train/e/buttonred1.mdl",
	ang = 0,
	z = 0,
})
Metrostroi.ClientPropForButton("KSN",{
	panel = "Main",
	button = "KSNSet",
	model = "models/metrostroi_train/e/buttonred1.mdl",
	ang = 0,
	z = 0,
})
Metrostroi.ClientPropForButton("KDP",{
	panel = "Main",
	button = "KDPSet",
	model = "models/metrostroi_train/e/buttonred1.mdl",
	ang = 0,
	z = -0,
})

Metrostroi.ClientPropForButton("KDL",{
	panel = "Main",
	button = "KDLSet",
	model = "models/metrostroi_train/e/buttonred1.mdl",
	ang = 0,
	z = 0,
})
Metrostroi.ClientPropForButton("KRZD",{
	panel = "Main",
	button = "KRZDSet",
	model = "models/metrostroi_train/e/buttonwhite.mdl",
	ang = 0,
	z = -6,
})

Metrostroi.ClientPropForButton("VUD",{
	panel = "Main",
	button = "VUD1Toggle",
	model = "models/metrostroi_train/switches/vudblack.mdl",
	z = -20,
})
Metrostroi.ClientPropForButton("KU1",{
	panel = "Main",
	button = "KU1Toggle",
	model = "models/metrostroi_train/switches/vudblack.mdl",
	z = -20,
})

Metrostroi.ClientPropForButton("VAH",{
	panel = "VAH",
	button = "VAHToggle",
	model = "models/metrostroi_train/switches/autobr.mdl",
})
Metrostroi.ClientPropForButton("VAD",{
	panel = "VAH",
	button = "VADToggle",
	model = "models/metrostroi_train/switches/autobr.mdl",
})
---------------------------------------------------------------------------------
Metrostroi.ClientPropForButton("VU1",{
	panel = "AV1",
	button = "VU1Toggle",
	model = "models/metrostroi_train/switches/autobr.mdl",
	z=10,
})
Metrostroi.ClientPropForButton("VU2",{
	panel = "AV1",
	button = "VU2Toggle",
	model = "models/metrostroi_train/switches/autobr.mdl",
	z=10,
})
Metrostroi.ClientPropForButton("VU3",{
	panel = "AV1",
	button = "VU3Toggle",
	model = "models/metrostroi_train/switches/autobr.mdl",
	z=10,
})

Metrostroi.ClientPropForButton("RST",{
	panel = "AV2",
	button = "RSTToggle",
	model = "models/metrostroi_train/switches/autobr2.mdl",
	z=20,
})

Metrostroi.ClientPropForButton("AV8B",{
	panel = "AVMain",
	button = "AV8BToggle",
	model = "models/metrostroi_train/switches/automain.mdl",
	z=31,
	skin=1,
})

Metrostroi.ClientPropForButton("VU",{
	panel = "VU",
	button = "VUToggle",
	model = "models/metrostroi_train/switches/autobr.mdl",
	z=0,
})
---------------------------------------------------
--RezMKSet
Metrostroi.ClientPropForButton("RezMK",{
	panel = "VU",
	button = "RezMKToggle",
	model = "models/metrostroi_train/switches/vudbrown.mdl",
	z=15,
})

--ALS
Metrostroi.ClientPropForButton("ALS",{
	panel = "Main",
	button = "ALSToggle",
	model = "models/metrostroi_train/81/tumbler1.mdl",
	ang = 0,
})
Metrostroi.ClientPropForButton("LOCh",{
	panel = "OldARS",
	button = "LOCh",
	model = "models/metrostroi_train/e/ars_04.mdl",
	z = 0,
	ang = 0,
})
Metrostroi.ClientPropForButton("L0",{
	panel = "OldARS",
	button = "L0",
	model = "models/metrostroi_train/e/ars_0.mdl",
	z = 0,
	ang = 0,
})
Metrostroi.ClientPropForButton("L40",{
	panel = "OldARS",
	button = "L40",
	model = "models/metrostroi_train/e/ars_40.mdl",
	z = 0,
	ang = 0,
})
Metrostroi.ClientPropForButton("L60",{
	panel = "OldARS",
	button = "L60",
	model = "models/metrostroi_train/e/ars_60.mdl",
	z = 0,
	ang = 0,
})
Metrostroi.ClientPropForButton("L80",{
	panel = "OldARS",
	button = "L80",
	model = "models/metrostroi_train/e/ars_80.mdl",
	z = 0,
	ang = 0,
})
Metrostroi.ClientPropForButton("L70",{
	panel = "OldARS",
	button = "L70",
	model = "models/metrostroi_train/e/ars_70.mdl",
	z = 0,
	ang = 0,
})
--RRP
Metrostroi.ClientPropForButton("KRP",{
	panel = "Main",
	button = "KRPSet",
	model = "models/metrostroi_train/switches/vudblack.mdl",
	z = -20,
})
--ARS
Metrostroi.ClientPropForButton("ARS",{
	panel = "AV",
	button = "ARSToggle",
	model = "models/metrostroi_train/switches/autobr2.mdl",
	ang = 270,
	z=-65
})
-- Panel lighning
Metrostroi.ClientPropForButton("L_3",{
	panel = "Main",
	button = "L_3Toggle",
	model = "models/metrostroi_train/81/tumbler1.mdl",
	ang = 90
})
-- MainPanel Lamps
Metrostroi.ClientPropForButton("SD",{
	panel = "Main",
	button = "BlueLight",
	model = "models/metrostroi_train/e/lampblue.mdl",
	z = 5.73,
	ang = 90,
})
Metrostroi.ClientPropForButton("gRP",{
	panel = "Main",
	button = "GreenRPLight",
	model = "models/metrostroi_train/e/lampgreen.mdl",
	z = 5.73,
	ang = 90,
})
Metrostroi.ClientPropForButton("rRP",{
	panel = "Main",
	button = "RedRPLight",
	model = "models/metrostroi_train/e/lampred1.mdl",
	z = 5.73,
	ang = 90,
})
Metrostroi.ClientPropForButton("r2RP",{
	panel = "Main",
	button = "RedRP2Light",
	model = "models/metrostroi_train/e/lampred1.mdl",
	z = 5.73,
	ang = 90,
})
Metrostroi.ClientPropForButton("LST",{
	panel = "Main",
	button = "LST",
	model = "models/metrostroi_train/e/lampwhite1.mdl",
	z = 5.73,
	ang = 90,
})
Metrostroi.ClientPropForButton("LVD",{
	panel = "Main",
	button = "LVD",
	model = "models/metrostroi_train/e/lampwhite1.mdl",
	z = 5.73,
	ang = 90,
})

Metrostroi.ClientPropForButton("AVULight",{
	panel = "AVU",
	button = "AVULight",
	model = "models/metrostroi_train/81/lamp.mdl",
	skin = 1,
	z = -10,
})
Metrostroi.ClientPropForButton("AVULight_light",{
	panel = "AVU",
	button = "AVULight",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	ignorepanel = true,
	skin = 1,
	z = -10,
})
Metrostroi.ClientPropForButton("OtklAVU",{
	panel = "AVU",
	button = "OtklAVUToggle",
	model = "models/metrostroi_train/81/tumbler1.mdl",
	ang = 90
})
-----------------------------------------------
Metrostroi.ClientPropForButton("SelectMain",{
	panel = "DURA",
	button = "DURASelectMain",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 4,
	z = -1,
})
Metrostroi.ClientPropForButton("SelectAlternate",{
	panel = "DURA",
	button = "DURASelectAlternate",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 4,
	z = -1,
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
Metrostroi.ClientPropForButton("VUD2",{
	panel = "HelperPanel",
	button = "VUD2Toggle",
	model = "models/metrostroi_train/switches/vudwhite.mdl",
	z = 0,
})
Metrostroi.ClientPropForButton("VDL",{
	panel = "HelperPanel",
	button = "VDLSet",
	model = "models/metrostroi_train/switches/vudwhite.mdl",
	z = 0,
})
Metrostroi.ClientPropForButton("Custom1",{
	panel = "Announcer",
	button = "Custom1Set",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 5,
	z = -1,
})
Metrostroi.ClientPropForButton("Custom2",{
	panel = "Announcer",
	button = "Custom2Set",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 5,
	z = -1,
})
Metrostroi.ClientPropForButton("Custom3",{
	panel = "Announcer",
	button = "Custom3Set",
	model = "models/metrostroi/81-717/button07.mdl"
})
Metrostroi.ClientPropForButton("CustomC",{
	panel = "Announcer",
	button = "CustomCToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
})

Metrostroi.ClientPropForButton("CustomD",{
	panel = "Announcer",
	button = "CustomD",
	model = "models/metrostroi/81-717/light01.mdl",
})
Metrostroi.ClientPropForButton("CustomE",{
	panel = "Announcer",
	button = "CustomE",
	model = "models/metrostroi/81-717/light03.mdl",
})
Metrostroi.ClientPropForButton("CustomF",{
	panel = "Announcer",
	button = "CustomF",
	model = "models/metrostroi/81-717/light04.mdl",
})
Metrostroi.ClientPropForButton("CustomG",{
	panel = "Announcer",
	button = "CustomG",
	model = "models/metrostroi/81-717/light02.mdl",
})

Metrostroi.ClientPropForButton("Battery",{
	panel = "Battery",
	button = "VBToggle",
	model = "models/metrostroi_train/switches/autobr3.mdl",
	z=40,
})

--------------------------------------------------------------------------------
ENT.ClientProps["gv"] = {
	model = "models/metrostroi/81-717/gv.mdl",
	pos = Vector(154,62.5,-65),
	ang = Angle(-90,0,-90)
}
ENT.ClientProps["gv_wrench"] = {
	model = "models/metrostroi/81-717/reverser.mdl",
	pos = Vector(154,62.5,-65),
	ang = Angle(0,0,0)
}
--------------------------------------------------------------------------------
ENT.ClientProps["book"] = {
	model = "models/props_lab/binderredlabel.mdl",
	pos = Vector(404,-32,58.7),
	ang = Angle(0,0,90)
}

ENT.ClientProps["E_salon"] = {
	model = "models/metrostroi_train/e/e_salon.mdl",
	pos = Vector(0,0,0),
	ang = Angle(0,0,0)
}
ENT.ClientProps["Lamps"] = {
	model = "models/metrostroi_train/e/lamps_on.mdl",
	pos = Vector(0,0,0),
	ang = Angle(0,0,0)
}
ENT.ClientProps["PB"] = {--
	model = "models/metrostroi_train/81/pb.mdl",
	pos = Vector(456.08691, -34.98815, -37.62471),
	ang = Angle(0,-90,40)
}

ENT.ClientProps["FrontBrake"] = {--
	model = "models/metrostroi_train/81/tmiso.mdl",
	pos = Vector(455, -26.0, -55),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["FrontTrain"] = {--
	model = "models/metrostroi_train/81/nmsio.mdl",
	pos = Vector(455, 26, -55),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["RearBrake"] = {--
	model = "models/metrostroi_train/81/tmiso.mdl",
	pos = Vector(-455, -26, -55),
	ang = Angle(0,90,0)
}
ENT.ClientProps["RearTrain"] = {--
	model = "models/metrostroi_train/81/nmsio.mdl",
	pos = Vector(-455, 26, -55),
	ang = Angle(0,90,0)
}


--------------------------------------------------------------------------------
-- Add doors
local function GetDoorPosition(i,k,j)
	if j == 0
	then return Vector(358.27 - 67.49*k     - 233.4*i,-64.56*(1-2*k),-1.55)
	else return Vector(358.27 - 67.49*(1-k) - 233.4*i,-64.56*(1-2*k),-1.55)
	end
end
for i=0,3 do
	for k=0,1 do
		ENT.ClientProps["door"..i.."x"..k.."a"] = {
			model = "models/metrostroi_train/e/doorright.mdl",
			pos = GetDoorPosition(i,k,0),
			ang = Angle(0,90 + 180*k,0)
		}
		ENT.ClientProps["door"..i.."x"..k.."b"] = {
			model = "models/metrostroi_train/e/doorleft.mdl",
			pos = GetDoorPosition(i,k,1),
			ang = Angle(0,90 + 180*k,0)
		}
	end
end
ENT.ClientProps["door1"] = {
	model = "models/metrostroi_train/e/doorfront.mdl",
	pos = Vector(464,-17.11,-3.98),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["door2"] = {
	model = "models/metrostroi_train/e/doorback.mdl",
	pos = Vector(-464,17.11,-3.98),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["door3"] = {
	model = "models/metrostroi_train/e/doorpass.mdl",
	pos = Vector(396.8,17.11,-6.1),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["door4"] = {
	model = "models/metrostroi_train/e/doorcab.mdl",
	pos = Vector(442.24,64.56,-2.51),
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

	local Lamps = self:GetPackedBool(20) and 0.4 or 1
	self:ShowHideSmooth("Lamps",self:Animate("lamps",self:GetPackedBool("Lamps") and Lamps or 0,0,1,6,false))

	--ALS Lamps
	self:ShowHideSmooth("LOCh",self:Animate("light_OCh",self:GetPackedBool(41) and 1 or 0,0,1,10,false))
	self:ShowHideSmooth("L0",self:Animate("light_0",self:GetPackedBool(42) and 1 or 0,0,1,10,false))
	self:ShowHideSmooth("L40",self:Animate("light_40",self:GetPackedBool(43) and 1 or 0,0,1,10,false))
	self:ShowHideSmooth("L60",self:Animate("light_60",self:GetPackedBool(44) and 1 or 0,0,1,10,false))
	self:ShowHideSmooth("L70",self:Animate("light_70",self:GetPackedBool(45) and 1 or 0,0,1,10,false))
	self:ShowHideSmooth("L80",self:Animate("light_80",self:GetPackedBool(46) and 1 or 0,0,1,10,false))

	--MainPanel Lamps
	self:ShowHideSmooth("SD",self:Animate("light_SD",self:GetPackedBool(40) and 1 or 0,0,1,10,false))
	self:ShowHideSmooth("gRP",self:Animate("light_gRP",self:GetPackedBool(36) and 1 or 0,0,1,10,false))
	self:ShowHideSmooth("rRP",self:Animate("light_rRP",self:GetPackedBool(35) and 1 or 0,0,1,12,false) + self:Animate("light_rLSN",self:GetPackedBool(131) and 1 or 0,0,0.2,12,false))
	self:ShowHideSmooth("r2RP",self:Animate("light_LhRK",self:GetPackedBool(112) and 1 or 0,0,1,10,false))
	self:ShowHideSmooth("LST",self:Animate("light_LST",self:GetPackedBool(49) and 1 or 0,0,1,10,false))
	self:ShowHideSmooth("LVD",self:Animate("light_LVD",self:GetPackedBool(50) and 1 or 0,0,1,5,false))

	-- DIP sound
	--self:SetSoundState("bpsn2",self:GetPackedBool(52) and 1 or 0,1.0)

	-- Simulate pressure gauges getting stuck a little
	self:Animate("brake334", 		1-self:GetPackedRatio(0), 			0.00, 0.65,  256,24)
	self:Animate("brake013", 		self:GetPackedRatio(0)^0.5,			0.00, 0.65,  256,24)
	self:Animate("controller",		self:GetPackedRatio(1),				0, 0.31,  2,false)
	self:Animate("reverser",		self:GetPackedRatio(2),				0.26, 0.35,  4,false)
	self:Animate("volt1", 			self:GetPackedRatio(10),			0.347,0.524)
	self:ShowHide("reverser",		self:GetPackedBool(0))

	self:ShowHide("brake013",		self:GetPackedBool(22))
	self:ShowHide("brake334",		not self:GetPackedBool(22))
	self:ShowHide("brake334_body",	not self:GetPackedBool(22))

	self:Animate("brake_line",		self:GetPackedRatio(4),				0.626, 0.88,  256,2)--,,0.01)
	self:Animate("train_line",		self:GetPackedRatio(5)-transient,	0.626, 0.88,  256,2)--,,0.01)
	self:Animate("brake_cylinder",	self:GetPackedRatio(6),	 			0.121, 0.865,  256,2)--,,0.03)
	self:Animate("voltmeter",			self:GetPackedRatio(7),				0.587, 0.874)
	self:Animate("ampermeter",		self:GetPackedRatio(8),				0.628, 0.875)
	--self:Animate("volt2",			0, 									0.38, 0.63)

	local wheel_radius = 0.5*44.1 -- units
	local speed = self:GetPackedRatio(3)*100
	local ang_vel = speed/(2*math.pi*wheel_radius)

	-- Rotate wheel
	self.Angle = ((self.Angle or math.random()) + ang_vel*self.DeltaTime) % 1.0

	self:Animate("speed1", 			self:GetPackedRatio("Speed") + math.sin(math.pi*8*self.Angle)*2/120,			0.525, 0.695,				nil, nil,  256,2,0.01)

	self:Animate("headlights",		self:GetPackedBool(1) and 1 or 0, 	0,1, 8, false)
	self:Animate("VozvratRP",		self:GetPackedBool(2) and 1 or 0, 	0,1, 16, false)
	self:Animate("DIPon",			self:GetPackedBool(3) and 1 or 0, 	0,1, 16, false)
	self:Animate("DIPoff",			self:GetPackedBool(4) and 1 or 0, 	0,1, 16, false)
	self:Animate("Battery",			self:GetPackedBool(7) and 1 or 0, 	1,0, 4, false)
	--self:Animate("bat2",			self:GetPackedBool(7) and 1 or 0, 	0,1, 16, false)
	--self:Animate("bat3",			self:GetPackedBool(7) and 1 or 0, 	0,1, 16, false)
	self:Animate("RezMK",			self:GetPackedBool(8) and 1 or 0, 	0,1.1, 16, false)
	self:Animate("VUS",			self:GetPackedBool(1) and 1 or 0, 	1,0.1, 16, false)
	self:Animate("KU1",				self:GetPackedBool(9) and 1 or 0, 	0,1, 16, false)
	self:Animate("VAH",				self:GetPackedBool(10) and 1 or 0, 	1,0, 4, false)
	self:Animate("VAD",				self:GetPackedBool(11) and 1 or 0, 	1,0, 4, false)
	self:Animate("VUD",			self:GetPackedBool(12) and 1 or 0, 	0,1, 16, false)
	self:Animate("VUD2",			self:GetPackedBool(13) and 1 or 0, 	0,1, 16, false)
	self:Animate("VDL",				self:GetPackedBool(14) and 1 or 0, 	0,1, 16, false)
	self:Animate("KDL",				self:GetPackedBool(15) and 1 or 0, 	0,1, 16, false)
	self:Animate("KDP",				self:GetPackedBool(16) and 1 or 0, 	0,1, 16, false)
	self:Animate("KRZD",			self:GetPackedBool(17) and 1 or 0, 	0,1, 16, false)
	self:Animate("KSN",				self:GetPackedBool(18) and 1 or 0, 	0,1, 16, false)
	self:Animate("OtklAVU",			self:GetPackedBool(19) and 0 or 1, 	0,1, 16, false)
	self:Animate("DURAPower",		self:GetPackedBool(24) and 1 or 0, 	0,1, 16, false)
	self:Animate("SelectMain",		self:GetPackedBool(29) and 1 or 0, 	0,1, 16, false)
	self:Animate("SelectAlternate",	self:GetPackedBool(30) and 1 or 0, 	0,1, 16, false)
	self:Animate("SelectChannel",	self:GetPackedBool(31) and 1 or 0, 	0,1, 16, false)
	self:Animate("ARS",				self:GetPackedBool(56) and 1 or 0, 	1,0, 4, false)
	self:Animate("ALS",				self:GetPackedBool(57) and 1 or 0, 	0,1, 16, false)
	self:Animate("KVT",				self:GetPackedBool(28) and 1 or 0, 	0,1, 16, false)
	----
	self:Animate("door1",	self:GetPackedBool(157) and (self.Door1 or 0.99) or 0,0,0.54/2, 1024, 1)
	self:Animate("door3",	self:GetPackedBool(158) and (self.Door2 or 0.99) or 0,0,0.51/2, 1024, 1)
	self:Animate("door2",	self:GetPackedBool(156) and (self.Door3 or 0.99) or 0,0,0.54/2, 1024, 1)
	self:Animate("door4",	self:GetPackedBool(159) and (self.Door2 or 0.99) or 0,0,0.51/2, 1024, 1)

	self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,0.35, 3, false)
	self:Animate("FrontTrain",	self:GetNW2Bool("FtI") and 0 or 1,0,0.35, 3, false)
	self:Animate("RearBrake",	self:GetNW2Bool("RbI") and 1 or 0,0,0.35, 3, false)
	self:Animate("RearTrain",	self:GetNW2Bool("RtI") and 1 or 0,0,0.35, 3, false)

	self:Animate("VUD2",			self:GetPackedBool(13) and 1 or 0, 	0,1, 16, false)
	self:Animate("L_3",			self:GetPackedBool(62) and 1 or 0, 0,1, 16, false)

	self:Animate("Custom1",			self:GetPackedBool(114) and 1 or 0, 0,1, 16, false)
	self:Animate("Custom2",			self:GetPackedBool(115) and 1 or 0, 0,1, 16, false)
	self:Animate("Custom3",			self:GetPackedBool(116) and 1 or 0, 0,1, 16, false)
	--[[self:Animate("Custom4",			self:GetPackedBool(117) and 1 or 0, 0,1, 16, false)
	self:Animate("Custom5",			self:GetPackedBool(118) and 1 or 0, 0,1, 16, false)
	self:Animate("Custom6",			self:GetPackedBool(119) and 1 or 0, 0,1, 16, false)
	self:Animate("Custom7",			self:GetPackedBool(120) and 1 or 0, 0,1, 16, false)
	self:Animate("Custom8",			self:GetPackedBool(121) and 1 or 0, 0,1, 16, false)
	self:Animate("CustomA",			self:GetPackedBool(122) and 1 or 0, 0,1, 16, false)
	self:Animate("CustomB",			self:GetPackedBool(123) and 1 or 0, 0,1, 16, false)]]--
	self:Animate("CustomC",			self:GetPackedBool(124) and 1 or 0, 0,1, 16, false)
	self:Animate("R_G",				self:GetPackedBool(125) and 1 or 0, 0,1, 16, false)
	self:Animate("R_Radio",			self:GetPackedBool(126) and 1 or 0, 0,1, 16, false)
	self:Animate("R_UNch",			self:GetPackedBool(127) and 1 or 0, 0,1, 16, false)
	self:Animate("Program1",		self:GetPackedBool(128) and 1 or 0, 0,1, 16, false)
	self:Animate("Program2",		self:GetPackedBool(129) and 1 or 0, 0,1, 16, false)
	self:Animate("rc1",				self:GetPackedBool(130) and 0.87 or 1, 	0,1, 1, false)
	self:Animate("UOS",				self:GetPackedBool(134) and 0.87 or 1, 	0,1, 1, false)
	self:Animate("BPS",				self:GetPackedBool(135) and 0.87 or 1, 	0,1, 1, false)
	self:Animate("UAVALever",	self:GetPackedBool(152) and 1 or 0, 	0,0.25, 128,  3,false)
	self:Animate("brake_disconnect",self:GetPackedBool("DriverValveBLDisconnect") and 1 or 0,0,0.5,  3,false)
	self:Animate("train_disconnect",self:GetPackedBool("DriverValveTLDisconnect") and 1 or 0,0,0.5,  3,false)
	self:Animate("EPK_disconnect",self:GetPackedBool("EPK") and 1 or 0,0,0.5,  3,false)

	self:Animate("PB",	self:GetPackedBool(165) and 1 or 0,0,0.2,  8,false)

	self:ShowHideSmooth("AVULight_light",self:Animate("AVUl",self:GetPackedBool(38) and 1 or 0,0,1,10,false))
	-- Animate AV switches
	for i,v in ipairs(self.Panel.AVMap) do
		local value = self:GetPackedBool(64+(i-1)) and 1 or 0
		--self:Animate("a"..(i-1),value,0,1,8,false)
	end
	self:Animate("VU1",self:GetPackedBool(64+19) and 1 or 0, 	1,0, 4, false)
	self:Animate("VU",self:GetPackedBool(64+12) and 1 or 0, 	1,0, 4, false)
	self:Animate("RST",self:GetPackedBool(64+24) and 1 or 0, 	1,0, 4, false)
	self:Animate("AV8B",self:GetPackedBool(64+7) and 1 or 0, 	0,1, 8, false)
	self:Animate("VU2",self:GetPackedBool(64+36) and 1 or 0, 	1,0, 4, false)
	self:Animate("VU3",self:GetPackedBool(64+13) and 1 or 0, 	1,0, 4, false)

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
			--[[
			local animation = self:Animate(n_l,self:GetPackedBool(21+(1-k)*4) and 1 or 0,0,1, 0.8 + (-0.2+0.4*math.random()),0)
			local offset_l = Vector(math.abs(31*animation),0,0)
			local offset_r = Vector(math.abs(32*animation),0,0)
			if self.ClientEnts[n_l] then
				--self.ClientEnts[n_l]:SetPos(self:LocalToWorld(self.ClientProps[n_l].pos + (1.0 - 2.0*k)*offset_l))
				--self.ClientEnts[n_l]:SetSkin(self:GetSkin())
			end
			if self.ClientEnts[n_r] then
				--self.ClientEnts[n_r]:SetPos(self:LocalToWorld(self.ClientProps[n_r].pos - (1.0 - 2.0*k)*offset_r))
				--self.ClientEnts[n_r]:SetSkin(self:GetSkin())
			end]]
		end
	end
	--if self.ClientEnts["door1"] then self.ClientEnts["door1"]:SetSkin(self:GetSkin()) end
	--if self.ClientEnts["door2"] then self.ClientEnts["door2"]:SetSkin(self:GetSkin()) end
	--if self.ClientEnts["door3"] then self.ClientEnts["door3"]:SetSkin(self:GetSkin()) end
	--if self.ClientEnts["door4"] then self.ClientEnts["door4"]:SetSkin(self:GetSkin()) end


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
			self:SetSoundState("compressor_e",1,1)
		else
			self:SetSoundState("compressor_e",0,1)
			self:SetSoundState("compressor_e_end",0,1)
			self:SetSoundState("compressor_e_end",1,1)
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
		end
	end

	local state = self:GetPackedBool("VPR")
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
	local dc = render.GetLightColor(self:LocalToWorld(Vector(460.0,0.0,5.0)))
	self:DrawOnPanel("InfoTable",function()
		surface.SetDrawColor(0,0,0) --255*dc.x,250*dc.y,220*dc.z)
		surface.DrawRect(50,0,540,100)
		draw.Text({
			text = self:GetNW2String("FrontText",""),
			font = "MetrostroiSubway_InfoPanel",--..self:GetNW2Int("Style",1),
			pos = { 320, 50 },
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			color = Color(250,200,20,255)})
	end)

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

	self:DrawOnPanel("InfoRoute",function()
		surface.SetDrawColor(142,132,101) --255*dc.x,250*dc.y,220*dc.z)
		--surface.DrawRect(0,100,88,70)
		draw.Text({
			text = self:GetNW2String("RouteNumber","  ")[1],
			font = "MetrostroiSubway_InfoRoute",--..self:GetNW2Int("Style",1),
			pos = { 20, 135 },
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			color = Color(0,0,0,255)})
		draw.Text({
			text = self:GetNW2String("RouteNumber","  ")[2],
			font = "MetrostroiSubway_InfoRoute",--..self:GetNW2Int("Style",1),
			pos = { 68, 135 },
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			color = Color(0,0,0,255)})
	end)
	self:DrawOnPanel("ARS",function()
		if not self:GetPackedBool(32) then return end

		local speed = self:GetPackedRatio(3)*100.0
		local d1 = math.floor(speed) % 10
		local d2 = math.floor(speed / 10) % 10
		self:DrawDigit((196+0) *10,	35*10, d2, 0.75, 0.55)
		self:DrawDigit((196+10)*10,	35*10, d1, 0.75, 0.55)

		--[[local b = self:Animate("light_rRP",self:GetPackedBool(35) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,50,0)
			surface.DrawRect(253*10,33*10,16*10,8*10)
			surface.SetAlphaMultiplier(1)
			draw.DrawText("РП","MetrostroiSubway_LargeText",253*10+30,33*10-19,Color(0,0,0,255))
		end

		local b = self:Animate("light_rLSN",self:GetPackedBool(131) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,50,0)
			surface.DrawRect(290*10,33*10,16*10,8*10)
			draw.DrawText("РП","MetrostroiSubway_LargeText",290*10+30,33*10-19,Color(0,0,0,255))
		end]]

		--[[b = self:Animate("light_gRP",self:GetPackedBool(36) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(50,255,50)
			surface.DrawRect(140*10,33*10,16*10,8*10)
			draw.DrawText("РП","MetrostroiSubway_LargeText",140*10+30,33*10-19,Color(0,0,0,255))
		end]]

		--[[b = self:Animate("light_gKT",self:GetPackedBool(47) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(50,255,50)
			surface.DrawRect(133*10,73*10,16*10,8*10)
			draw.DrawText("КТ","MetrostroiSubway_LargeText",133*10+30,73*10-20,Color(0,0,0,255))
		end	]]

		--[[b = self:Animate("light_gKVD",self:GetPackedBool(48) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(50,255,50)
			surface.DrawRect(165*10,73*10,16*10,8*10)
			draw.DrawText("КВД","MetrostroiSubway_LargeText",165*10,73*10-20,Color(0,0,0,255))
		end]]

		--[[b = self:Animate("light_LhRK",self:GetPackedBool(33) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,50,0)
			surface.DrawRect(101*10,73*10,16*10,8*10)
		end]]

		--[[b = self:Animate("light_NR1",self:GetPackedBool(34) and 0 or 1,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(50,255,50)
			surface.DrawRect(196*10,73*10,16*10,8*10)
			draw.DrawText("НР1","MetrostroiSubway_LargeText",196*10,73*10-20,Color(0,0,0,255))
		end]]

		--[[b = self:Animate("light_PECH",self:GetPackedBool(37) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,50,0)
			surface.DrawRect(260*10,73*10,16*10,8*10)
			draw.DrawText("ПЕЧЬ","MetrostroiSubway_SmallText",260*10,73*10-5,Color(0,0,0,255))
		end]]
		--[[
		b = self:Animate("light_AVU",self:GetPackedBool(38) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(50,255,50)
			surface.DrawRect(295*10,73*10,16*10,8*10)
			draw.DrawText("АВУ","MetrostroiSubway_LargeText",295*10,73*10-20,Color(0,0,0,255))
		end
		]]
		--[[b = self:Animate("light_SD",self:GetPackedBool(40) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(50,255,50)
			surface.DrawRect(102*10,33*10,16*10,8*10)
			draw.DrawText("СД","MetrostroiSubway_LargeText",102*10+30,33*10-20,Color(0,0,0,255))
		end]]

		------------------------------------------------------------------------
		--[[b = self:Animate("light_OCh",self:GetPackedBool(41) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,50,0)
			surface.DrawRect(102*10,53*10,16*10,8*10)
			draw.DrawText("ОЧ","MetrostroiSubway_LargeText",102*10+30,53*10-15,Color(0,0,0,255))
		end]]

		--[[b = self:Animate("light_0",self:GetPackedBool(42) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,50,0)
			surface.DrawRect(140*10,53*10,16*10,8*10)
			draw.DrawText("0","MetrostroiSubway_LargeText",140*10+55,53*10-10,Color(0,0,0,255))
		end]]

		--[[b = self:Animate("light_40",self:GetPackedBool(43) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,50,0)
			surface.DrawRect(176*10,53*10,16*10,8*10)
			draw.DrawText("40","MetrostroiSubway_LargeText",176*10+30,53*10-10,Color(0,0,0,255))
		end]]

		--[[b = self:Animate("light_60",self:GetPackedBool(44) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(50,255,50)
			surface.DrawRect(217*10,53*10,16*10,8*10)
			draw.DrawText("60","MetrostroiSubway_LargeText",217*10+30,53*10-10,Color(0,0,0,255))
		end]]

		--[[b = self:Animate("light_75",self:GetPackedBool(45) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(50,255,50)
			surface.DrawRect(255*10,53*10,16*10,8*10)
			draw.DrawText("70","MetrostroiSubway_LargeText",255*10+30,53*10-10,Color(0,0,0,255))
		end]]

		--[[b = self:Animate("light_80",self:GetPackedBool(46) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(50,255,50)
			surface.DrawRect(294*10,53*10,16*10,8*10)
			draw.DrawText("80","MetrostroiSubway_LargeText",294*10+30,53*10-10,Color(0,0,0,255))
		end]]

		surface.SetAlphaMultiplier(1.0)
	end)
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
	self:DrawOnPanel("AnnouncerDisplay",function()
		local plus = (not self:GetPackedBool(32) and 1 or 0)
		surface.SetDrawColor(50 - plus*40,255 - plus*220,40 - plus*40)
		surface.DrawRect(260,80,390,150)
		if not self:GetPackedBool(32) then return end

		-- Custom announcer display
		local C1 = Color(0,0,0,210)
		local C2 = Color(50,200,50,255)
		local flash = false
		text1 = self:GetNW2String("CustomStr0")
		text2 = self:GetNW2String("CustomStr1")

		-- Draw text
		if flash and ((RealTime() % 1.0) > 0.5) then
			C2,C1 = C1,C2
		end
		for i=1,20 do
			surface.SetDrawColor(C2)
			surface.DrawRect(280+(i-1)*17.7+1,124+4,16,20)
			draw.DrawText(string.upper(text1[i] or ""),"MetrostroiSubway_IGLA",280+(i-1)*17.7,124+0,C1)
		end
		for i=1,20 do
			surface.SetDrawColor(C2)
			surface.DrawRect(280+(i-1)*17.7+1,124+31+4,16,20)
			draw.DrawText(string.upper(text2[i] or ""),"MetrostroiSubway_IGLA",280+(i-1)*17.7,124+31,C1)
		end
	end)
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

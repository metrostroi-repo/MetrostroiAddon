include("shared.lua")


--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}


-- Main panel
ENT.ButtonMap["Main"] = {
	pos = Vector(445.5,-35.3,-1.0),
	ang = Angle(0,-97.5,20),
	width = 410,
	height = 145,
	scale = 0.0625,

	buttons = {
		{ID = "DIPonSet",		x=22,  y=19, radius=20, tooltip="Включение ДИП и освещения\nTurn DIP and interior lights on"},
		{ID = "DIPoffSet",		x=66,  y=19, radius=20, tooltip="Выключение ДИП и освещения\nTurn DIP and interior lights off"},
		{ID = "VozvratRPSet",	x=192, y=78, radius=20, tooltip="Возврат реле перегрузки\nReset overload relay"},
		{ID = "VMKToggle",		x=22,  y=73, radius=20, tooltip="Включение мотор-компрессора\nTurn motor-compressor on"},

		{ID = "RezMKSet",		x=66,  y=80, radius=20, tooltip="Резервное включение мотор-компрессора\nEmergency motor-compressor startup"},
		{ID = "VAHToggle",		x=187, y=19, radius=20, tooltip="ВАХ: Включение аварийного хода (неисправность реле педали безопасности)\nVAH: Emergency driving mode (failure of RPB relay)"},
		{ID = "VADToggle",		x=226, y=19, radius=20, tooltip="ВАД: Включение аварийного закрытия дверей (неисправность реле контроля дверей)\nVAD: Emergency door close override (failure of KD relay)"},

		{ID = "ARSToggle",		x=187+77, y=19, radius=20, tooltip="АРС: Включение системы автоматического регулирования скорости\nARS: Automatic speed regulation"},
		{ID = "ALSToggle",		x=226+77, y=19, radius=20, tooltip="АЛС: Включение системы автоматической локомотивной сигнализации\nALS: Automatic locomotive signalling"},

		{ID = "OtklAVUToggle",	x=349, y=19, radius=20, tooltip="Отключение автоматического выключения управления (неисправность реле АВУ)\nTurn off automatic control disable relay (failure of AVU relay)"},
		{ID = "KRZDSet",		x=393, y=19, radius=20, tooltip="КРЗД: Кнопка резервного закрытия дверей\nKRZD: Emergency door closing"},
		{ID = "VUD1Toggle",		x=393, y=73, radius=20, tooltip="ВУД1: Выключатель управления дверьми\nVUD1: Door control toggle (close doors)"},

		{ID = "DoorSelectToggle",x=321, y=75, radius=20, tooltip="Выбор стороны открытия дверей\nSelect side on which doors will open"},
		{ID = "KDLSet",			x=291, y=122, radius=20, tooltip="КДЛ: Кнопка левых дверей\nKDL: Left doors open"},
		{ID = "KDPSet",			x=349, y=122, radius=20, tooltip="КДП: Кнопка правых дверей\nKDP: Right doors open"},

		{ID = "KVTSet",			x=240, y=122, radius=20, tooltip=""},
		{ID = "KSNSet",			x=240, y=78, radius=20,  tooltip="КСН: Кнопка сигнализации неисправности\nKSN: Failure indication button"},
		{ID = "KRPSet",			x=192, y=122, radius=20, tooltip="КРП: Кнопка резервного пуска"},

		{ID = "R_Program1Set",	x=112, y=127, radius=20, tooltip="Программа 1\nProgram 1"},
		{ID = "R_Program2Set",	x=149, y=127, radius=20, tooltip="Программа 2\nProgram 2"},

		{ID = "R_GToggle",	x=112, y=30, radius=20, tooltip="УНЧ: Усилитель низких частот\nUNCh: Low frequency amplifier (Sound in cabin enable)"},
		{ID = "R_ZSToggle",		x=149, y=30, radius=20, tooltip="ЭС: Контроль экстренной связи\nES: Emergency communication control"},
		{ID = "R_RadioToggle",	x=112, y=80, radius=20, tooltip="Радиоинформатор (встроеный)\nRadioinformator: Announcer (built-in)"},
		{ID = "R_VPRToggle",		x=149, y=80, radius=20, tooltip="ВПР: Включение поездной радиосвязи\nVPR: Radiostation enable "},

	}
}

-- Front panel
ENT.ButtonMap["Front"] = {
	pos = Vector(447.6,-35.3,5.0),
	ang = Angle(0,-97.4,74),
	width = 410,
	height = 95,
	scale = 0.0625,

	buttons = {
		{ID = "VUSToggle",x=400, y=75, radius=15, tooltip="ВУС: Выключатель усиленого света ходовых фар\nVUS: Head lights bright/dim"},
		{ID = "L_3Toggle",x=388, y=28, radius=15, tooltip="Освещение пульта\nPanel lighting"},
		{x=25, y=30, w=57, h=40, tooltip="Напряжение цепей управления\nControl circuits voltage"},
	}
}

-- ARS/Speedometer panel
ENT.ButtonMap["ARS"] = {
	pos = Vector(449.1,-37.3,4.9),
	ang = Angle(0,-97.9,69),
	width = 410*10,
	height = 95*10,
	scale = 0.0625/10,

	buttons = {
		{x=2045,y=406,tooltip="Индикатор скорости\nSpeed indicator",radius=130},
		{x=2610,y=363,tooltip="РП: Красная лампа реле перегрузки\nRP: Red overload relay light (power circuits failed to assemble)",radius=120},
		{x=2982,y=363,tooltip="РП: Красная лампа реле перегрузки\nRP: Red overload relay light (power circuits failed to assemble)",radius=120},
		{x=1070+320*0,y=780,tooltip="ЛхРК: Лампа хода реостатного контроллера\nLhRK: Rheostat controller motion light",radius=120},
		{x=1070+320*1,y=780,tooltip="КТ: Контроль тормоза\nKT: ARS braking indicator",radius=120},
		{x=1070+320*2,y=780,tooltip="КВД: Контроль выключения двигателей\nKVD: ARS engine shutdown indicator",radius=120},
		{x=1070+320*3,y=780,tooltip="НР1: Нулевое реле\nNR1: Zero relay state (high voltage enabled)",radius=120},
		{x=1070+320*4,y=780,tooltip="ВПР: Контроль включения поездной радиосвязи\nVPR: Train radio equipment enabled",radius=120},
		{x=1070+320*5,y=780,tooltip="ПЕЧЬ: Индикатор работы печи\nPECH: Cabin heating indicator",radius=120},
		{x=1070+320*6,y=780,tooltip="АВУ: Автоматический выключатель управления\nAVU: Automatic control disabler active",radius=120},

		{x=1070+380*0,y=570,tooltip="ОЧ: Отсутствие частоты АРС\nOCh: No ARS frequency",radius=120},
		{x=1070+380*1,y=570,tooltip="0: Сигнал АРС остановки\n0: ARS stop signal",radius=120},
		{x=1070+380*2,y=570,tooltip="40: Ограничение скорости 40 км/ч\nSpeed limit 40 kph",radius=120},
		{x=1070+380*3,y=570,tooltip="60: Ограничение скорости 60 км/ч\nSpeed limit 60 kph",radius=120},
		{x=1070+380*4,y=570,tooltip="70: Ограничение скорости 70 км/ч\nSpeed limit 70 kph",radius=120},
		{x=1070+380*5,y=570,tooltip="80: Ограничение скорости 80 км/ч\nSpeed limit 80 kph",radius=120},

		{x=1080+380*0,y=363,tooltip="СД: Сигнализация дверей\nSD: Door state light (doors are closed/door circuits are OK)",radius=120},
		{x=1080+380*1,y=363,tooltip="РП: Зелёная лампа реле перегрузки\nRP: Green overload relay light (overload relay open on current train)",radius=120},
	}
}

-- ARS/Speedometer panel
ENT.ButtonMap["Autodrive"] = {
	pos = Vector(440.1,-37.3,4.9),
	ang = Angle(0,-97.9,69),
	width = 410*10,
	height = 95*10,
	scale = 0.0625/10,

	buttons = {
		{x=1080+380*1,y=363,tooltip="РП: Зелёная лампа реле перегрузки\nRP: Green overload relay light (overload relay open on current train)",radius=120},
	}
}

-- AV panel
ENT.ButtonMap["AV"] = {
	pos = Vector(394.0,-53.5,44.5),
	ang = Angle(0,90,90),
	width = 520,
	height = 550,
	scale = 0.0625,

	buttons = {
		{ID = "A61Toggle", x=16+44*0,  y=110+129*0, radius=30, tooltip="A61 Управление 6ым поездным проводом\nTrain wire 6 control"},
		{ID = "A55Toggle", x=16+44*1,  y=110+129*0, radius=30, tooltip="A55 Управление проводом 10АС\nTrain wire 10AS control"},
		{ID = "A54Toggle", x=16+44*2,  y=110+129*0, radius=30, tooltip="A54 Управление проводом 10АК\nTrain wire 10AK control"},
		{ID = "A56Toggle", x=16+44*3,  y=110+129*0, radius=30, tooltip="A56 Включение аккумуляторной батареи\nTurn on battery power to control circuits"},
		{ID = "A27Toggle", x=16+44*4,  y=110+129*0, radius=30, tooltip="A27 Turn on DIP and lighting"},
		{ID = "A21Toggle", x=16+44*5,  y=110+129*0, radius=30, tooltip="A21 Door control"},
		{ID = "A10Toggle", x=16+44*6,  y=110+129*0, radius=30, tooltip="A10 Motor-compressor control"},
		{ID = "A53Toggle", x=16+44*7,  y=110+129*0, radius=30, tooltip="A53 KVC power supply"},
		{ID = "A43Toggle", x=16+44*8,  y=110+129*0, radius=30, tooltip="A43 ARS 12V power supply"},
		{ID = "A45Toggle", x=16+44*9,  y=110+129*0, radius=30, tooltip="A45 ARS train wire 10AU"},
		{ID = "A42Toggle", x=16+44*10, y=110+129*0, radius=30, tooltip="A42 ARS 75V power supply"},
		{ID = "A41Toggle", x=16+44*11, y=110+129*0, radius=30, tooltip="A41 ARS braking"},
		------------------------------------------------------------------------
		{ID = "VUToggle",  x=16+44*0,  y=110+129*1, radius=30, tooltip="VU  Train control"},
		{ID = "A64Toggle", x=16+44*1,  y=110+129*1, radius=30, tooltip="A64 Cabin lighting"},
		{ID = "A63Toggle", x=16+44*2,  y=110+129*1, radius=30, tooltip="A63 IGLA/BIS"},
		{ID = "A50Toggle", x=16+44*3,  y=110+129*1, radius=30, tooltip="A50 Turn on DIP and lighting"},
		{ID = "A51Toggle", x=16+44*4,  y=110+129*1, radius=30, tooltip="A51 Turn off DIP and lighting"},
		{ID = "A23Toggle", x=16+44*5,  y=110+129*1, radius=30, tooltip="A23 Emergency motor-compressor turn on"},
		{ID = "A14Toggle", x=16+44*6,  y=110+129*1, radius=30, tooltip="A14 Train wire 18"},
		{ID = "A75Toggle", x=16+44*7,  y=110+129*1, radius=30, tooltip="A75 Cabin heating"},
		{ID = "A1Toggle",  x=16+44*8,  y=110+129*1, radius=30, tooltip="A1  XOD-1"},
		{ID = "A2Toggle",  x=16+44*9,  y=110+129*1, radius=30, tooltip="A2  XOD-2"},
		{ID = "A3Toggle",  x=16+44*10, y=110+129*1, radius=30, tooltip="A3  XOD-3"},
		{ID = "A17Toggle", x=16+44*11, y=110+129*1, radius=30, tooltip="A17 Reset overload relay"},
		------------------------------------------------------------------------
		{ID = "A62Toggle", x=16+44*0,  y=110+129*2, radius=30, tooltip="A62 Radio communications"},
		{ID = "A29Toggle", x=16+44*1,  y=110+129*2, radius=30, tooltip="A29 Radio broadcasting"},
		{ID = "A5Toggle",  x=16+44*2,  y=110+129*2, radius=30, tooltip="A5  "},
		{ID = "A6Toggle",  x=16+44*3,  y=110+129*2, radius=30, tooltip="A6  T-1"},
		{ID = "A8Toggle",  x=16+44*4,  y=110+129*2, radius=30, tooltip="A8  Pneumatic valves #1, #2"},
		{ID = "A20Toggle", x=16+44*5,  y=110+129*2, radius=30, tooltip="A20 Drive/brake circuit control, train wire 20"},
		{ID = "A25Toggle", x=16+44*6,  y=110+129*2, radius=30, tooltip="A25 Manual electric braking"},
		{ID = "A22Toggle", x=16+44*7,  y=110+129*2, radius=30, tooltip="A22 Turn on KK"},
		{ID = "A30Toggle", x=16+44*8,  y=110+129*2, radius=30, tooltip="A30 Rheostat controller motor power"},
		{ID = "A39Toggle", x=16+44*9,  y=110+129*2, radius=30, tooltip="A39 Emergency control"},
		{ID = "A44Toggle", x=16+44*10, y=110+129*2, radius=30, tooltip="A44 Emergency train control"},
		{ID = "A80Toggle", x=16+44*11, y=110+129*2, radius=30, tooltip="A80 Power circuit mode switch motor power"},
		------------------------------------------------------------------------
		{ID = "A65Toggle", x=16+44*0,  y=110+129*3, radius=30, tooltip="A65 Interior lighting"},
		--{ID = "A00Toggle", x=16+44*1,  y=110+129*3, radius=30, tooltip="A00"},
		{ID = "A24Toggle", x=16+44*2,  y=110+129*3, radius=30, tooltip="A24 Battery charging"},
		{ID = "A32Toggle", x=16+44*3,  y=110+129*3, radius=30, tooltip="A32 Open right doors"},
		{ID = "A31Toggle", x=16+44*4,  y=110+129*3, radius=30, tooltip="A31 Open left doors"},
		{ID = "A16Toggle", x=16+44*5,  y=110+129*3, radius=30, tooltip="A16 Close doors"},
		{ID = "A13Toggle", x=16+44*6,  y=110+129*3, radius=30, tooltip="A13 Door alarm"},
		{ID = "A12Toggle", x=16+44*7,  y=110+129*3, radius=30, tooltip="A12 Emergency door close"},
		{ID = "A7Toggle",  x=16+44*8,  y=110+129*3, radius=30, tooltip="A7  Red lamp"},
		{ID = "A9Toggle",  x=16+44*9,  y=110+129*3, radius=30, tooltip="A9  Red lamp"},
		{ID = "A46Toggle", x=16+44*10, y=110+129*3, radius=30, tooltip="A46 White lamp"},
		{ID = "A47Toggle", x=16+44*11, y=110+129*3, radius=30, tooltip="A47 White lamp"},
	}
}
-- AV panel
ENT.ButtonMap["BPS"] = {
	pos = Vector(392.0,-53.5,44.5),
	ang = Angle(0,90,90),
	width = 520,
	height = 630,
	scale = 0.0625,

	buttons = {
		{ID = "BPSToggle", x=16+51*9,  y=110+129*3+100, radius=30, tooltip="РЦ-БПС: Блок ПротивоСкатывания\nRC-BPS: Against Rolling System"},
	}
}
-- Battery panel
ENT.ButtonMap["Battery"] = {
	pos = Vector(394.5,29.5-5,28.0+5-5),
	ang = Angle(0,90,90),
	width = 200+0,
	height = 90+0/0.0625,
	scale = 0.0625,

	buttons = {
		{ID = "VBToggle", x=0, y=0, w=200+0/0.0625, h=90+0/0.0625, tooltip="ВБ: Выключатель батареи\nVB: Battery on/off"},
	}
}
-- Battery panel
ENT.ButtonMap["RC1"] = {
	pos = Vector(392.5,19.0,29),
	ang = Angle(0,90,90),
	width = 80,
	height = 130,
	scale = 0.0625,

	buttons = {
		{ID = "RC1Toggle", x=40, y=30, radius=35, tooltip="РЦ-1: Разъединитель цепей АРС\nRC-1: ARS circuits disconnect"},
		{ID = "UOSToggle", x=40, y=100, radius=35, tooltip="РЦ-УОС: Устройство ограничения скорости\nRC-UOS: Speed Limitation Device"},
	}
}

-- Parking brake panel
ENT.ButtonMap["ParkingBrake"] = {
	pos = Vector(447,41.0+12.5,2.0),
	ang = Angle(0,-84,90),
	width = 400,
	height = 400,
	scale = 0.0625,

	buttons = {
		{ID = "ParkingBrakeLeft",x=0, y=0, w=200, h=400, tooltip=""},
		{ID = "ParkingBrakeRight",x=200, y=0, w=200, h=400, tooltip=""},
	}
}

-- Train driver helpers panel
ENT.ButtonMap["HelperPanel"] = {
	pos = Vector(444.7,62,30.4),
	ang = Angle(0,-50,90),
	width = 64,
	height = 144,
	scale = 0.0625,

	buttons = {
		{ID = "VUD2Toggle", x=32, y=42, radius=32, tooltip="ВУД2: Выключатель управления дверьми\nVUD2: Door control toggle (close doors)"},
		{ID = "VDLSet",     x=32, y=108, radius=32, tooltip="ВДЛ: Выключатель левых дверей\nVDL: Left doors open"},
	}
}

-- Help panel
ENT.ButtonMap["Help"] = {
	pos = Vector(445.0,-36.0,30.0),
	ang = Angle(40+180,0,0),
	width = 20,
	height = 20,
	scale = 1,

	buttons = {
		{ID = "ShowHelp", x=10, y=10, radius=15, tooltip="Помощь в вождении поезда\nShow help on driving the train"},
	}
}

-- Pneumatic instrument panel
ENT.ButtonMap["PneumaticPanels"] = {
	pos = Vector(448,-30,16.0),
	ang = Angle(0,-77,90),
	width = 140,
	height = 160,
	scale = 0.0625,

	buttons = {
		{x=60,y=45,radius=30,tooltip="Давление в тормозных цилиндрах (ТЦ)\nBrake cylinder pressure"},
		{x=80,y=105,radius=30,tooltip="Давление в магистралях (красная: тормозной, чёрная: напорной)\nPressure in pneumatic lines (red: brake line, black: train line)"},
	}
}
ENT.ButtonMap["DriverValveDisconnect"] = {
	pos = Vector(420,-57.0,-25),
	ang = Angle(0,0,0),
	width = 200,
	height = 90,
	scale = 0.0625,

	buttons = {
		{ID = "DriverValveDisconnectToggle", x=0, y=0, w=200, h=90, tooltip="Клапан разобщения\nDriver valve disconnect valve"},
	}
}
ENT.ButtonMap["EPKDisconnect"] = {
	pos = Vector(420.0+10.5,-58.5,-25),
	ang = Angle(0,0,-90),
	width = 200,
	height = 120,
	scale = 0.0625,

	buttons = {
		{ID = "EPKToggle", x=0, y=0, w=200, h=120, tooltip="Кран ЭПВ\nEPK disconnect valve"},
	}
}
ENT.ButtonMap["DURA"] = {
	pos = Vector(408+15,-58.0-5.3,-6.65),
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
	pos = Vector(408+15-0.75,-58.0-5.3+1.5625,-6.65),
	ang = Angle(0,180,0),
	width = 240,
	height = 80,
	scale = 0.0625/3.2,
}

ENT.ButtonMap["Announcer"] = {
	pos = Vector(449.3,-53,17.4),
	ang = Angle(0,-127,90),
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
	pos = Vector(449.3,-53,17.4),
	ang = Angle(0,-127,90),
	width = 10,
	height = 10,
	scale = 0.012,
}
ENT.ButtonMap["IGLA"] = {
	pos = Vector(404.6,-59.985,27.9),
	ang = Angle(-0.5,180,90),
	width = 440,
	height = 100,
	scale = 0.014,
}
ENT.ButtonMap["Meters"] = {
	pos = Vector(449.3,-53,27.5),
	ang = Angle(0,-125,90),
	width = 170,
	height = 110,
	scale = 0.0625,

	buttons = {
		{x=22, y=24, w=55, h=45, tooltip="Вольтметр высокого напряжения (кВ)\nHV voltmeter (kV)"},
		{x=90, y=24, w=58, h=45, tooltip="Амперметр (А)\nTotal ampermeter (A)"},
	}
}


--These values should be identical to those drawing the schedule
local col1w = 80 -- 1st Column width
local col2w = 32 -- The other column widths
local rowtall = 30 -- Row height, includes -only- the usable space and not any lines

local rowamount = 20 -- How many rows to show (total)
ENT.ButtonMap["Schedule"] = {
	pos = Vector(452.9,-19.7,41),
	ang = Angle(0,-70,90),
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
}

-- Temporary panels (possibly temporary)
ENT.ButtonMap["FrontPneumatic"] = {
	pos = Vector(459.0,-45.0,-50.0),
	ang = Angle(0,90,90),
	width = 900,
	height = 100,
	scale = 0.1,
}
ENT.ButtonMap["RearPneumatic"] = {
	pos = Vector(-481.0,45.0,-50.0),
	ang = Angle(0,270,90),
	width = 900,
	height = 100,
	scale = 0.1,
}
ENT.ButtonMap["AirDistributor"] = {
	pos = Vector(-180,70,-50),
	ang = Angle(0,180,90),
	width = 80,
	height = 40,
	scale = 0.1,
}

-- Wagon numbers
ENT.ButtonMap["TrainNumber1"] = {
	pos = Vector(30,-67.7,-9.5),
	ang = Angle(0,0,90),
	width = 130,
	height = 55,
	scale = 0.20,
}
ENT.ButtonMap["TrainNumber2"] = {
	pos = Vector(30+28,67.7,-9.5),
	ang = Angle(0,180,90),
	width = 130,
	height = 55,
	scale = 0.20,
}

-- UAVA
ENT.ButtonMap["UAVAPanel"] = {
	pos = Vector(393,54,-2),
	ang = Angle(0,0,90),
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
	pos = Vector(30,-67.6,-10),
	ang = Angle(0,0,90),
	width = 130,
	height = 55,
	scale = 0.20,
}
ENT.ButtonMap["TrainNumber2"] = {
	pos = Vector(30+28,67.7,-10),
	ang = Angle(0,180,90),
	width = 130,
	height = 55,
	scale = 0.20,
}

-- Front info table
ENT.ButtonMap["InfoTable"] = {
	pos = Vector(458.0,-16.0,12.0),
	ang = Angle(0,90,90),
	width = 646,
	height = 100,
	scale = 0.1/2,
}
ENT.ButtonMap["InfoTableSelect"] = {
	pos = Vector(454.0,-27.0,27.0),
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
	pos = Vector(451.29,39.9,24.2),
	ang = Angle(0,97.3,84),
	width = 100,
	height = 100,
	scale = 0.115,
}

ENT.ButtonMap["FrontDoor"] = {
	pos = Vector(455,16,48.4),
	ang = Angle(0,-90,90),
	width = 642,
	height = 1900,
	scale = 0.1/2,
	buttons = {
		{ID = "FrontDoor",x=0,y=0,w=642,h=1900, tooltip="Передняя дверь\nFront door"},
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
	pos = Vector(390,-16,48.4),
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
ENT.ClientProps["brake013"] = {
	model = "models/metrostroi/81-717/brake.mdl",
	pos = Vector(431,-59.5,2.7),
	ang = Angle(0,180,0)
}
ENT.ClientProps["controller"] = {
	model = "models/metrostroi/81-717/ezh_controller.mdl",
	pos = Vector(447,-26,1.8),
	ang = Angle(0,90+45,0)
}
ENT.ClientProps["reverser"] = {
	model = "models/metrostroi/81-717/reverser.mdl",
	pos = Vector(447,-26,2.5),
	ang = Angle(0,45,90)
}
ENT.ClientProps["brake_disconnect"] = {
	model = "models/metrostroi/81-717/uava.mdl",
	pos = Vector(429.5,-61.0,-25),
	ang = Angle(-30,0,0)
}
ENT.ClientProps["EPK_disconnect"] = {
	model = "models/metrostroi/81-717/uava.mdl",
	pos = Vector(420.0+12.5,-57.5,-21.5),
	ang = Angle(0,180,0)
}
ENT.ClientProps["parking_brake"] = {
	model = "models/metrostroi/81-717/ezh_koleso.mdl",
	pos = Vector(446,41.0,-10.0),
	ang = Angle(-90,6,0)
}
--------------------------------------------------------------------------------
ENT.ClientProps["train_line"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(449.20,-35.00,9.45),
	ang = Angle(90,0,180-14)
}
ENT.ClientProps["brake_line"] = {
	model = "models/metrostroi/81-717/red_arrow.mdl",
	pos = Vector(449.15,-35.05,9.45),
	ang = Angle(90,0,180-14)
}
ENT.ClientProps["brake_cylinder"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(450.5,-32.9,13.4),
	ang = Angle(90,0,180-18)
}
--------------------------------------------------------------------------------
ENT.ClientProps["ampermeter"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(445.5,-59.5,23.3),
	ang = Angle(90,0,-45+180+80)
}
ENT.ClientProps["voltmeter"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(448.1,-55.7,23.3),
	ang = Angle(90,0,-45+180+80)
}
ENT.ClientProps["volt1"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(447.10,-38.15,0.4),
	ang = Angle(90-18,180,7)
}
ENT.ClientProps["volt2"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(452.3,-19.4,18.2),
	ang = Angle(90,0,180)
}




--------------------------------------------------------------------------------
ENT.ClientProps["headlights"] = {
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90,
	pos = Vector(443.1,-60.0,0.5),
	ang = Angle(-74,0,0)
}
Metrostroi.ClientPropForButton("L_3",{
	panel = "Front",
	button = "L_3Toggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90,
})
--------------------------------------------------------------------------------
Metrostroi.ClientPropForButton("R_VPR",{
	panel = "Main",
	button = "R_VPRToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90,
})
Metrostroi.ClientPropForButton("R_ZS",{
	panel = "Main",
	button = "R_ZSToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90,
})
Metrostroi.ClientPropForButton("R_G",{
	panel = "Main",
	button = "R_GToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90,
})
Metrostroi.ClientPropForButton("R_Radio",{
	panel = "Main",
	button = "R_RadioToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90,
})
Metrostroi.ClientPropForButton("DIPon",{
	panel = "Main",
	button = "DIPonSet",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 0,
	z = -4.5,
})
Metrostroi.ClientPropForButton("DIPoff",{
	panel = "Main",
	button = "DIPoffSet",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 1,
	z = -4.5,
})
Metrostroi.ClientPropForButton("VozvratRP",{
	panel = "Main",
	button = "VozvratRPSet",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 0,
	z = -4.5,
})
Metrostroi.ClientPropForButton("VMK",{
	panel = "Main",
	button = "VMKToggle",
	model = "models/metrostroi_train/81/vud.mdl",
	ang = 0,
	z = -15,
})
Metrostroi.ClientPropForButton("RezMK",{
	panel = "Main",
	button = "RezMKSet",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 0,
	z = -4.5,
})
Metrostroi.ClientPropForButton("VAH",{
	panel = "Main",
	button = "VAHToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90,
})
Metrostroi.ClientPropForButton("VAD",{
	panel = "Main",
	button = "VADToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90,
})
Metrostroi.ClientPropForButton("ALS",{
	panel = "Main",
	button = "ALSToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90,
})
Metrostroi.ClientPropForButton("ARS",{
	panel = "Main",
	button = "ARSToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90,
})
Metrostroi.ClientPropForButton("OtklAVU",{
	panel = "Main",
	button = "OtklAVUToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90,
})
Metrostroi.ClientPropForButton("KRZD",{
	panel = "Main",
	button = "KRZDSet",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 0,
	z = -4.5,
})
Metrostroi.ClientPropForButton("VUD1",{
	panel = "Main",
	button = "VUD1Toggle",
	model = "models/metrostroi_train/81/vud.mdl",
	ang = 0,
	z = -3,
	z = -15,
})
Metrostroi.ClientPropForButton("DoorSelect",{
	panel = "Main",
	button = "DoorSelectToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 0
})
Metrostroi.ClientPropForButton("KDL",{
	panel = "Main",
	button = "KDLSet",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 3,
	z = -4.5,
})
Metrostroi.ClientPropForButton("KDP",{
	panel = "Main",
	button = "KDPSet",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 3,
	z = -4.5,
})
Metrostroi.ClientPropForButton("KVT",{
	panel = "Main",
	button = "KVTSet",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 0,
	z=-4.5,
})
Metrostroi.ClientPropForButton("KSN",{
	panel = "Main",
	button = "KSNSet",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 1,
	z = -4.5,
})
Metrostroi.ClientPropForButton("KRP",{
	panel = "Main",
	button = "KRPSet",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 0,
	z = -4.5,
})
Metrostroi.ClientPropForButton("Program1",{
	panel = "Main",
	button = "R_Program1Set",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 0,
	z = -4.5,
})
Metrostroi.ClientPropForButton("Program2",{
	panel = "Main",
	button = "R_Program2Set",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 0,
	z = -4.5,
})

Metrostroi.ClientPropForButton("SelectMain",{
	panel = "DURA",
	button = "DURASelectMain",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 0,
	z = -4.5,
})
Metrostroi.ClientPropForButton("SelectAlternate",{
	panel = "DURA",
	button = "DURASelectAlternate",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 0,
	z = -4.5,
})
Metrostroi.ClientPropForButton("SelectChannel",{
	panel = "DURA",
	button = "DURAToggleChannel",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90,
})
Metrostroi.ClientPropForButton("DURAPower",{
	panel = "DURA",
	button = "DURAPowerToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90,
})
Metrostroi.ClientPropForButton("VUD2",{
	panel = "HelperPanel",
	button = "VUD2Toggle",
	model = "models/metrostroi_train/81/vud.mdl",
	ang = 0,
	z = -3,
})
Metrostroi.ClientPropForButton("VDL",{
	panel = "HelperPanel",
	button = "VDLSet",
	model = "models/metrostroi_train/81/vud.mdl",
	ang = 0,
	z = -3,
})
Metrostroi.ClientPropForButton("Custom1",{
	panel = "Announcer",
	button = "Custom1Set",
	model = "models/metrostroi/81-717/button10.mdl"
})
Metrostroi.ClientPropForButton("Custom2",{
	panel = "Announcer",
	button = "Custom2Set",
	model = "models/metrostroi/81-717/button10.mdl"
})
Metrostroi.ClientPropForButton("Custom3",{
	panel = "Announcer",
	button = "Custom3Set",
	model = "models/metrostroi/81-717/button07.mdl"
})
Metrostroi.ClientPropForButton("CustomC",{
	panel = "Announcer",
	button = "CustomCToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90,
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

Metrostroi.ClientPropForButton("rc1",{
	panel = "RC1",
	button = "RC1Toggle",
	model = "models/metrostroi/81-717/rc.mdl",
})

Metrostroi.ClientPropForButton("UOS",{
	panel = "RC1",
	button = "UOSToggle",
	model = "models/metrostroi/81-717/rc.mdl",
})

Metrostroi.ClientPropForButton("BPS",{
	panel = "BPS",
	button = "BPSToggle",
	model = "models/metrostroi/81-717/rc.mdl",
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
for x=0,11 do
	for y=0,3 do
		ENT.ClientProps["a"..(x+12*y)] = {
			model = "models/metrostroi/81-717/circuit_breaker.mdl",
			pos = Vector(393.8,-52.5+x*2.75,37.5-y*8),
			ang = Angle(90,0,0)
		}
	end
end
ENT.ClientProps["bat1"] = {
	model = "models/metrostroi_train/81/vud.mdl",
	pos = Vector(393.6,26.0+4.6*0,24.9),
	ang = Angle(0,90,90)
}
ENT.ClientProps["bat2"] = {
	model = "models/metrostroi_train/81/vud.mdl",
	pos = Vector(393.6,26.0+4.6*1,24.9),
	ang = Angle(0,90,90)
}
ENT.ClientProps["bat3"] = {
	model = "models/metrostroi_train/81/vud.mdl",
	pos = Vector(393.6,26.0+4.6*2,24.9),
	ang = Angle(0,90,90)
}
--------------------------------------------------------------------------------
ENT.ClientProps["book"] = {
	model = "models/props_lab/binderredlabel.mdl",
	pos = Vector(449.0,-40.0,45.0),
	ang = Angle(-135,0,85)
}




--------------------------------------------------------------------------------
-- Add doors
local function GetDoorPosition(i,k,j)
	if j == 0
	then return Vector(353.0 - 35*k     - 231*i,-65*(1-2*k),-1.8)
	else return Vector(353.0 - 35*(1-k) - 231*i,-65*(1-2*k),-1.8)
	end
end
for i=0,3 do
	for k=0,1 do
		ENT.ClientProps["door"..i.."x"..k.."a"] = {
			model = "models/metrostroi/e/em508_door1.mdl",
			pos = GetDoorPosition(i,k,0),
			ang = Angle(0,180*k,0)
		}
		ENT.ClientProps["door"..i.."x"..k.."b"] = {
			model = "models/metrostroi/e/em508_door2.mdl",
			pos = GetDoorPosition(i,k,1),
			ang = Angle(0,180*k,0)
		}
	end
end
ENT.ClientProps["door1"] = {
	model = "models/metrostroi/e/em508_door5.mdl",
	pos = Vector(456.5,0.4,-3.8),
	ang = Angle(0,0,0)
}
ENT.ClientProps["door2"] = {
	model = "models/metrostroi/e/em508_door5.mdl",
	pos = Vector(-479.5,-0.5,-3.8),
	ang = Angle(0,180,0)
}
ENT.ClientProps["door3"] = {
	model = "models/metrostroi/e/em508_door4.mdl",
	pos = Vector(386.5,0.4,5.2),
	ang = Angle(0,0,0)
}
ENT.ClientProps["door4"] = {
	model = "models/metrostroi/e/em508_door3.mdl",
	pos = Vector(425.6,65.2,-2.2),
	ang = Angle(0,0,0)
}
ENT.ClientProps["UAVA"] = {
	model = "models/metrostroi/81-717/uava_body.mdl",
	pos = Vector(400,61,-8),--Vector(415.0,-58.5,-18.2),
	ang = Angle(0,0,0)
}
ENT.ClientProps["UAVALever"] = {
	model = "models/metrostroi/81-717/real_uava.mdl",
	pos = Vector(404,60.7,-10.4),
	ang = Angle(-30,90,90)
}

ENT.FrontDoor = 0
ENT.RearDoor = 0
ENT.PassengerDoor = 0
ENT.CabinDoor = 0

ENT.Texture = "7"
ENT.OldTexture = nil
--local X = Material( "metrostroi_skins/81-717/6.png")
--------------------------------------------------------------------------------

function ENT:UpdateTextures()
	local texture = Metrostroi.Skins["train"][self:GetNW2String("texture")]
	local passtexture = Metrostroi.Skins["pass"][self:GetNW2String("passtexture")]
	local cabintexture = Metrostroi.Skins["cab"][self:GetNW2String("cabtexture")]
	for _,ent in pairs(self.ClientEnts) do
		if not IsValid(ent) then continue end
		for k,v in pairs(ent:GetMaterials()) do
			local tex = string.Explode("/",v)
			tex = tex[#tex]
			if cabintexture and cabintexture.textures[tex] then
				ent:SetSubMaterial(k-1,cabintexture.textures[tex])
			end
			if passtexture and passtexture.textures[tex] then
				ent:SetSubMaterial(k-1,passtexture.textures[tex])
			end
			if texture and texture.textures[tex] then
				ent:SetSubMaterial(k-1,texture.textures[tex])
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
	if not self.Animate then self.BaseClass = baseclass.Get("gmod_subway_base") end
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

	-- Simulate pressure gauges getting stuck a little
	self:Animate("brake013", 		self:GetPackedRatio(0)^0.5,			0.00, 0.65,  256,24)
	self:Animate("controller",		self:GetPackedRatio(1),				0.53, 0.80,  2,false)
	self:Animate("reverser",		self:GetPackedRatio(2),				0.20, 0.55,  4,false)
	self:Animate("volt1", 			self:GetPackedRatio(10),			0.38,0.64)
	self:ShowHide("reverser",		self:GetPackedBool(0))

	self:Animate("brake_line",		self:GetPackedRatio(4),				0.16, 0.84,  256,2)--,,0.01)
	self:Animate("train_line",		self:GetPackedRatio(5)-transient,	0.16, 0.84,  256,2)--,,0.01)
	self:Animate("brake_cylinder",	self:GetPackedRatio(6),	 			0.17, 0.86,  256,2)--,,0.03)
	self:Animate("voltmeter",		self:GetPackedRatio(7),				0.38, 0.63)
	self:Animate("ampermeter",		self:GetPackedRatio(8),				0.38, 0.63)
	self:Animate("volt2",			0, 									0.38, 0.63)

	self:Animate("headlights",		self:GetPackedBool(1) and 1 or 0, 	0,1, 8, false)
	self:Animate("L_3",		self:GetPackedBool("L_3") and 1 or 0, 	0,1, 8, false)
	self:Animate("VozvratRP",		self:GetPackedBool(2) and 1 or 0, 	0,1, 16, false)
	self:Animate("DIPon",			self:GetPackedBool(3) and 1 or 0, 	0,1, 16, false)
	self:Animate("DIPoff",			self:GetPackedBool(4) and 1 or 0, 	0,1, 16, false)
	self:Animate("brake_disconnect",self:GetPackedBool(6) and 1 or 0, 	0,0.7, 3, false)
	self:Animate("bat1",			self:GetPackedBool(7) and 1 or 0, 	0,1, 16, false)
	self:Animate("bat2",			self:GetPackedBool(7) and 1 or 0, 	0,1, 16, false)
	self:Animate("bat3",			self:GetPackedBool(7) and 1 or 0, 	0,1, 16, false)
	self:Animate("RezMK",			self:GetPackedBool(8) and 1 or 0, 	0,1, 16, false)
	self:Animate("VMK",				self:GetPackedBool(9) and 0 or 1, 	0,1, 16, false)
	self:Animate("VAH",				self:GetPackedBool(10) and 1 or 0, 	0,1, 16, false)
	self:Animate("VAD",				self:GetPackedBool(11) and 1 or 0, 	0,1, 16, false)
	self:Animate("VUD1",			self:GetPackedBool(12) and 1 or 0, 	0,1, 16, false)
	self:Animate("VUD2",			self:GetPackedBool(13) and 1 or 0, 	0,1, 16, false)
	self:Animate("VDL",				self:GetPackedBool(14) and 1 or 0, 	0,1, 16, false)
	self:Animate("KDL",				self:GetPackedBool(15) and 1 or 0, 	0,1, 16, false)
	self:Animate("KDP",				self:GetPackedBool(16) and 1 or 0, 	0,1, 16, false)
	self:Animate("KRZD",			self:GetPackedBool(17) and 1 or 0, 	0,1, 16, false)
	self:Animate("KSN",				self:GetPackedBool(18) and 1 or 0, 	0,1, 16, false)
	self:Animate("OtklAVU",			self:GetPackedBool(19) and 1 or 0, 	0,1, 16, false)
	self:Animate("DURAPower",		self:GetPackedBool(24) and 1 or 0, 	0,1, 16, false)
	self:Animate("SelectMain",		self:GetPackedBool(29) and 1 or 0, 	0,1, 16, false)
	self:Animate("SelectAlternate",	self:GetPackedBool(30) and 1 or 0, 	0,1, 16, false)
	self:Animate("SelectChannel",	self:GetPackedBool(31) and 1 or 0, 	0,1, 16, false)
	self:Animate("ARS",				self:GetPackedBool(56) and 1 or 0, 	0,1, 16, false)
	self:Animate("ALS",				self:GetPackedBool(57) and 1 or 0, 	0,1, 16, false)
	self:Animate("KVT",				self:GetPackedBool(28) and 1 or 0, 	0,1, 16, false)

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
	self:Animate("R_ZS",			self:GetPackedBool(127) and 1 or 0, 0,1, 16, false)
	self:Animate("R_VPR",			self:GetPackedBool("R_VPR") and 1 or 0, 0,1, 16, false)
	self:Animate("Program1",		self:GetPackedBool(128) and 1 or 0, 0,1, 16, false)
	self:Animate("Program2",		self:GetPackedBool(129) and 1 or 0, 0,1, 16, false)
	self:Animate("rc1",				self:GetPackedBool(130) and 0.87 or 1, 	0,1, 1, false)
	self:Animate("UOS",				self:GetPackedBool(134) and 0.87 or 1, 	0,1, 1, false)
	self:Animate("BPS",				self:GetPackedBool(135) and 0.87 or 1, 	0,1, 1, false)
	self:Animate("UAVALever",	self:GetPackedBool(152) and 1 or 0, 	0,0.25, 128,  3,false)
	self:Animate("EPK_disconnect",	self:GetPackedBool(155) and 1 or 0,0,0.5, 3, false)

	-- Animate AV switches
	for i,v in ipairs(self.Panel.AVMap) do
		local value = self:GetPackedBool(64+(i-1)) and 1 or 0
		self:Animate("a"..(i-1),value,0,1,8,false)
	end

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
			local animation = self:Animate(n_l,self:GetPackedBool(21+(1-k)*4) and 1 or 0,0,1, 0.8 + (-0.2+0.4*math.random()),0)
			local offset_l = Vector(math.abs(31*animation),0,0)
			local offset_r = Vector(math.abs(32*animation),0,0)
			if self.ClientEnts[n_l] then
				self.ClientEnts[n_l]:SetPos(self:LocalToWorld(self.ClientProps[n_l].pos + (1.0 - 2.0*k)*offset_l))
				--self.ClientEnts[n_l]:SetSkin(self:GetSkin())
			end
			if self.ClientEnts[n_r] then
				self.ClientEnts[n_r]:SetPos(self:LocalToWorld(self.ClientProps[n_r].pos - (1.0 - 2.0*k)*offset_r))
				--self.ClientEnts[n_r]:SetSkin(self:GetSkin())
			end
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
			self:SetSoundState("ring",0.95,1)
		else
			self:SetSoundState("ring",0,0)
			self:SetSoundState("ring_end",0.95,1)
			--self:PlayOnce("ring_end","cabin",0.45,101)
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

	-- DIP sound
	--self:SetSoundState("bpsn2",self:GetPackedBool(32) and 1 or 0,1.0)
end

function ENT:Draw()
	self.BaseClass.Draw(self)
end

function ENT:DrawPost()
	--local dc = render.GetLightColor(self:LocalToWorld(Vector(460.0,0.0,5.0)))
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
		surface.SetAlphaMultiplier(1)
		surface.SetDrawColor(255,255,255) --255*dc.x,250*dc.y,220*dc.z)
		--surface.DrawRect(0,100,88,70)
		local rn = self:GetNW2String("RouteNumber","00")
		surface.SetMaterial(Metrostroi.RouteTextures.m[rn[1]])
		surface.DrawTexturedRect(-2,100,44,70)
		surface.SetMaterial(Metrostroi.RouteTextures.m[rn[2]])
		surface.DrawTexturedRect(46,100,44,70)
		--[[
		draw.Text({
			text = self:GetNW2String("RouteNumber","00"),
			font = "MetrostroiSubway_InfoRoute",--..self:GetNW2Int("Style",1),
			pos = { 44, 135 },
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			color = Color(0,0,0,255)})
			]]
	end)//
	--[[
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
	end)]]
	self:DrawOnPanel("ARS",function()
		if not self:GetPackedBool(32) then return end

		local speed = self:GetPackedRatio(3)*100.0
		local d1 = math.floor(speed) % 10
		local d2 = math.floor(speed / 10) % 10
		self:DrawDigit((196+0) *10,	35*10, d2, 0.75, 0.55)
		self:DrawDigit((196+10)*10,	35*10, d1, 0.75, 0.55)

		local b = self:Animate("light_rRP",self:GetPackedBool(35) and 1 or 0,0,1,5,false)
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
		end

		b = self:Animate("light_gRP",self:GetPackedBool(36) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(50,255,50)
			surface.DrawRect(140*10,33*10,16*10,8*10)
			draw.DrawText("РП","MetrostroiSubway_LargeText",140*10+30,33*10-19,Color(0,0,0,255))
		end

		b = self:Animate("light_gKT",self:GetPackedBool(47) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(50,255,50)
			surface.DrawRect(133*10,73*10,16*10,8*10)
			draw.DrawText("КТ","MetrostroiSubway_LargeText",133*10+30,73*10-20,Color(0,0,0,255))
		end

		b = self:Animate("light_gKVD",self:GetPackedBool(48) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(50,255,50)
			surface.DrawRect(165*10,73*10,16*10,8*10)
			draw.DrawText("КВД","MetrostroiSubway_LargeText",165*10,73*10-20,Color(0,0,0,255))
		end

		b = self:Animate("light_LhRK",self:GetPackedBool(33) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,50,0)
			surface.DrawRect(101*10,73*10,16*10,8*10)
		end

		b = self:Animate("light_NR1",self:GetPackedBool(34) and 0 or 1,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(50,255,50)
			surface.DrawRect(196*10,73*10,16*10,8*10)
			draw.DrawText("НР1","MetrostroiSubway_LargeText",196*10,73*10-20,Color(0,0,0,255))
		end

		b = self:Animate("light_VPR",self:GetPackedBool("VPR") and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(0,255,50)
			surface.DrawRect(228*10,73*10,16*10,8*10)
			draw.DrawText("ВПР","MetrostroiSubway_LargeText",228*10,73*10-20,Color(0,0,0,255))
		end

		b = self:Animate("light_PECH",self:GetPackedBool(37) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,127,0)
			surface.DrawRect(260*10,73*10,16*10,8*10)
			draw.DrawText("ПЕЧЬ","MetrostroiSubway_SmallText",260*10,73*10-5,Color(0,0,0,255))
		end

		b = self:Animate("light_AVU",self:GetPackedBool(38) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(50,255,50)
			surface.DrawRect(295*10,73*10,16*10,8*10)
			draw.DrawText("АВУ","MetrostroiSubway_LargeText",295*10,73*10-20,Color(0,0,0,255))
		end

		b = self:Animate("light_SD",self:GetPackedBool(40) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(50,255,50)
			surface.DrawRect(102*10,33*10,16*10,8*10)
			draw.DrawText("СД","MetrostroiSubway_LargeText",102*10+30,33*10-20,Color(0,0,0,255))
		end

		------------------------------------------------------------------------
		b = self:Animate("light_OCh",self:GetPackedBool(41) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,50,0)
			surface.DrawRect(102*10,53*10,16*10,8*10)
			draw.DrawText("ОЧ","MetrostroiSubway_LargeText",102*10+30,53*10-15,Color(0,0,0,255))
		end

		b = self:Animate("light_0",self:GetPackedBool(42) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,50,0)
			surface.DrawRect(140*10,53*10,16*10,8*10)
			draw.DrawText("0","MetrostroiSubway_LargeText",140*10+55,53*10-10,Color(0,0,0,255))
		end

		b = self:Animate("light_40",self:GetPackedBool(43) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,127,0)
			surface.DrawRect(176*10,53*10,16*10,8*10)
			draw.DrawText("40","MetrostroiSubway_LargeText",176*10+30,53*10-10,Color(0,0,0,255))
		end

		b = self:Animate("light_60",self:GetPackedBool(44) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(50,255,50)
			surface.DrawRect(217*10,53*10,16*10,8*10)
			draw.DrawText("60","MetrostroiSubway_LargeText",217*10+30,53*10-10,Color(0,0,0,255))
		end

		b = self:Animate("light_75",self:GetPackedBool(45) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(50,255,50)
			surface.DrawRect(255*10,53*10,16*10,8*10)
			draw.DrawText("70","MetrostroiSubway_LargeText",255*10+30,53*10-10,Color(0,0,0,255))
		end

		b = self:Animate("light_80",self:GetPackedBool(46) and 1 or 0,0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(50,255,50)
			surface.DrawRect(294*10,53*10,16*10,8*10)
			draw.DrawText("80","MetrostroiSubway_LargeText",294*10+30,53*10-10,Color(0,0,0,255))
		end

		surface.SetAlphaMultiplier(1.0)
	end)

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

	self:DrawOnPanel("AnnouncerDisplay",function(...)
		local plus = (not self:GetPackedBool(32) and 1 or 0)
		surface.SetDrawColor(83,140,82)
		surface.DrawRect(230,80,450,150)
		if not self:GetPackedBool(32) then return end
		self.ASNP:AnnDisplay(self,true)
	end)

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
	end)

	self:DrawOnPanel("FrontPneumatic",function()
		draw.DrawText(self:GetNW2Bool("FbI") and "Isolated" or "Open","Trebuchet24",150,30,Color(0,0,0,255))
		draw.DrawText(self:GetNW2Bool("FtI") and "Isolated" or "Open","Trebuchet24",650,30,Color(0,0,0,255))
	end)
	self:DrawOnPanel("RearPneumatic",function()
		draw.DrawText(self:GetNW2Bool("RbI") and "Isolated" or "Open","Trebuchet24",150,30,Color(0,0,0,255))
		draw.DrawText(self:GetNW2Bool("RtI") and "Isolated" or "Open","Trebuchet24",650,30,Color(0,0,0,255))
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

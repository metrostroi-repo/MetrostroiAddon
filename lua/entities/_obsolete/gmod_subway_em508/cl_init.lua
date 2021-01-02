--------------------------------------------------------------------------------
-- All the models, materials, sounds belong to their corresponding authors. Permission is granted to only distribute these models through Garry's Mod Steam Workshop and the official Metrostroi GitHub accounts for use with Garry's Mod and Metrostroi Subway Simulator.
--
-- It is forbidden to use any of these models, materials, sounds and other content for any commercial purposes without an explicit permission from the authors. It is forbidden to make any changes in these files in any derivative projects without an explicit permission from the author.
--
-- The following models are (C) 2015-2017 oldy (Aleksandr Kravchenko). All rights reserved.
-- - 81-703 Е (models\metrostroi_train\81-703)
-- - 81-508 Еm508 (models\metrostroi_train\81-508)
-- - 81-707 Ezh (models\metrostroi_train\81-707)
-- - 81-708 Еzh1
-- - 81-710 Еzh3 (models\metrostroi_train\81-710)
-- - 81-508T Еm508T
-- - 81-720 Yauza (models\metrostroi_train\81-720)
-- - 81-721 Yauza (intermediate)
-- - 81-722 Yubileinyi (models\metrostroi_train\81-722)
-- - 81-723 Yubileinyi
-- - 81-724 Yubileinyi
--------------------------------------------------------------------------------
include("shared.lua")

--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.AutoAnimNames = {}
ENT.ClientSounds = {}

ENT.ButtonMap["Lamp"] = {
	pos = Vector(444.31597,-52.43482,37.93294),
	ang = Angle(-8,-90+21.5,180),
	width = 105,
	height = 85,
	scale = 0.0625,

	buttons = {
		{	ID = "L_3Toggle",	x=15, y=15, radius=100, tooltip="Лампа: Подсветка приборов\nLamp: Gauges lighting", model = {
			var="L_3",speed=16,
			sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
	}
}
ENT.ButtonMap["AVU"] = {
	pos = Vector(458.31597,-22.43482,32.93294),
	ang = Angle(-8,-90+21.5,90+15),
	width = 105,
	height = 85,
	scale = 0.0625,

	buttons = {
		{ID = "AVULight",			x=30, y=32, radius=20, tooltip="Лампа:Включен АВУ (Автоматический выключатель управления)\nLamp: Automatic control disabler is active", model = {
			model = "models/metrostroi_train/81-710/ezh3_slc77.mdl", skin = 3, z = -0,
			lamp = {model = "models/metrostroi_train/81/lamp_on.mdl",z = -1.6, var="AVU"}
		}},
		{	ID = "OtklAVUToggle",	 x=30, y=60, radius=20, tooltip="Отключение автоматического выключения управления (неисправность АВУ)\nTurn off automatic control disable relay (failure of AVU)", model = {
			model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-2,
			var="OtklAVU",speed=16,
			plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=24,z=-2,var="OtklAVUPl", ID="OtklAVUPl",},
			sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
	}
}
ENT.ButtonMap["LAMPS"] = {
	pos = Vector(455.349,-50.3,-12.12),
	ang = Angle(0,90,-65.5),
	width = 315,
	height = 100,
	scale = 0.0600,

	buttons = {
		{ID = "SN",			x=233,y=60, radius=10, tooltip="Индикатор: Cигнализация неисправности\nLamp: Overload relay light (overload relay open on current train)", model = {lamp = {
			model = "models/metrostroi_train/81-508/508_sn_lamp.mdl", z = 0,
			var=131,speed=16, color = Color(190,70,255),
		}}},
		{ID = "RedRP",			x=255,y=58.8, radius=10, tooltip="Индикатор: Красная лампа реле перегрузки\nLamp: Red overload relay light (power circuits failed to assemble)", model = {lamp = {
			model = "models/metrostroi_train/81-508/508_rp1_lamp.mdl", z = 0,
			var="RedRP",speed=5, color = Color(190,70,255),
			getfunc = function(ent) return ent:GetPackedRatio("LRP") end,
		}}},
		{ID = "SD",	x=170,y=58.8, radius=20, tooltip="Индикатор: Сигнализация дверей\nLamp: SD door state light (doors are open)", model = {lamp = {
			model = "models/metrostroi_train/81-508/508_sd_lamp.mdl", z = 0,
			var=40,speed=8, color = Color(180,180,50),
		}}},
		{ID = "GreenRP",		x=213.5, y=58.75, radius=10, tooltip="Индикатор: Зеленая лампа реле перегрузки\nLamp: Green overload relay light", model = {lamp = {
			model = "models/metrostroi_train/81-508/508_rp2_lamp.mdl", z = 0,
			var=36,speed=16, color = Color(50,180,180),
		}}},
		{ID = "UKS",		x=150, y=58.75, radius=10, tooltip="Индикатор: Устройство контроля скорости УКС-20М\nSpeed control device UKS-20M", model = {lamp = {
			model = "models/metrostroi_train/81-508/508_uks_lamp.mdl", z = 0,
			var="UKS",speed=16,
		}}},
		{ID = "Red",		x=130, y=58.75, radius=10, tooltip="Индикатор: Обогрев кабины\nLamp: The heater is on", model = {lamp = {
			model = "models/metrostroi_train/81-508/508_red_lamp.mdl", z = 0,
			var="Red",speed=16,
		}}},
		{ID = "AGS",		x=84, y=72, radius=10, tooltip="Лампа: Работа АГС (Автоматический гребне смазыватель)\nLamp: AGS (Automatic Creast Greaser", model = {lamp = {
			model = "models/metrostroi_train/common/lamps/svetodiod1.mdl", z = 20, color = Color(255,100,80),
			var="Red",speed=16,
		}}},
	}
}

-- Main panel

ENT.ButtonMap["AGS"] = {
	pos = Vector(455.65,-44.6,-8.62),
	ang = Angle(0,-90,60.44),
	width = 50,
	height = 50,
	scale = 0.0588,

	buttons = {
	{	ID = "VUSToggle",	x=0, y=0, w=22, h=20, tooltip="Переключатель: Ближний свет/Дальний свет\nSwitcher: Near Headlights(down)/Far Headlights (up)", model = {
			model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",ang = 180,z=2,
			var="VUS",speed=16,
			sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
	}
}

ENT.ButtonMap["Main"] = {
	pos = Vector(460.5,-30.9,-9.3),
	ang = Angle(0,-90,9.44),
	width = 315,
	height = 240,
	scale = 0.0588,

	buttons = {
		----Кнопки
		{	ID = "DoorSelectToggle",	x=165, y=180, radius=20, tooltip="Переключатель: Выбор стороны открытия дверей\nSwitcher:Select side on which doors will open", model = {
			model = "models/metrostroi_train/81-508/em508_switcher.mdl",ang = 180,z=2,
			var="DoorSelect",speed=16,
			sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
		{	ID = "DIPonSet",	x=50.88, y=137.3, radius=20, tooltip="Вкл. Осв.: Включение освещения\nSwithcer:Turn interior lights on", model = {
			model = "models/metrostroi_train/81-508/em508_button_black.mdl",ang = 180,z=0,
			var="DIPon",speed=16,
			sndvol = 0.10, snd = function(val) return val and "button2_on" or "button1_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
		}},
		{	ID = "DIPoffSet",	x=50.88+38.1*1, y=137.3, radius=20, tooltip="Выкл. Осв.: Отключение освещения\nSwithcer:Turn interior lights off", model = {
			model = "models/metrostroi_train/81-508/em508_button_black.mdl",ang = 180,z=0,
			var="DIPoff",speed=16,
			sndvol = 0.10, snd = function(val) return val and "button3_on" or "button4_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
		}},
		{	ID = "VozvratRPSet",	x=50.88+1.4+38.1*2, y=137.3, radius=20, tooltip="ВРП: Возврат РП\nKU:Reset overload relay", model = {
			model = "models/metrostroi_train/81-508/em508_button_red.mdl",ang = 180,z=0,
			var="VozvratRP",speed=16,
			sndvol = 0.10, snd = function(val) return val and "button4_on" or "button4_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
		}},
		{	ID = "KSNSet",	x=50.88+1.4+38.1*3, y=137.3, radius=20, tooltip="КСН:Принудительное срабатывание РП на неисправном вагоне (Сигнализация неисправности)\nKSN: Forced activation of the RP on the faulty wagon (Malfunction signaling)", model = {
			model = "models/metrostroi_train/81-508/em508_button_red.mdl",ang = 180,z=0,
			var="KSN",speed=16,
			sndvol = 0.10, snd = function(val) return val and "button4_on" or "button4_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
		}},
		{	ID = "KRZDSet",	x=50.88+2+38.1*5, y=137.3, radius=20, tooltip="КРЗД: Кнопка резервного закрытия дверей\nKRZD: Emergency door closing", model = {
			model = "models/metrostroi_train/81-508/em508_button_black.mdl",ang = 180,z=-0,
			var="KRZD",speed=16,
			sndvol = 0.10, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
		}},
		{	ID = "KSDSet",	x=50.88+2+38.1*4+2.2, y=137.3, radius=20, tooltip="КСД: Контроль сигнализации дверей(проверка СД)\nKSD: Door state controle(Door check)", model = {
			model = "models/metrostroi_train/81-508/em508_button_red.mdl",ang = 180,z=0,
			var="KSD",speed=16,vmin=1,vmax=0,
			sndvol = 0.10, snd = function(val) return val and "button1_on" or "button1_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
		}},
		{	ID = "KDPSet",	x=142+46, y=216, radius=20, radius=20, tooltip="КДП:Правые двери\nKDP: Right doors open", model = {
			model = "models/metrostroi_train/81-508/em508_button_red.mdl",ang = 180,z=-0,
			var="KDP",speed=16,
			sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
		}},
		{	ID = "KDLSet",	x=142, y=216, radius=20, tooltip="КДЛ: Кнопка левых дверей\nKDL: Left doors open", model = {
			model = "models/metrostroi_train/81-508/em508_button_red.mdl",ang = 180,z=0,
			var="KDL",speed=16,
			sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
		}},
		{	ID = "RezMKSet",	x=51.5, y=198,  radius=20, tooltip="РМК: Резервное включение мотор-компрессора\nEMC: Emergency motor-compressor enabling", model = {
			model = "models/metrostroi_train/switches/vudwhite.mdl", z=-19,
			var="RezMK",speed=6,
			sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),color = Color(78,65,38),
		}},
		{	ID = "KU1Toggle",	x=111,y=199,radius=20, tooltip="МК: Включение мотор-компрессора\nMK: Turn on motor-compressor", model = {
			model = "models/metrostroi_train/81-508/em508_switcher.mdl", z=-2,
			var="KU1",speed=6,
			sndvol = 1, snd = function(val) return val and "switch_on" or "switch_off" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
		{	ID = "VUD1Toggle",	x=238.6,y=198,radius=20, tooltip="ВУД: Закрытие дверей\nVUD: Door control toggle (close doors)", model = {
			model = "models/metrostroi_train/switches/vudwhite.mdl", z=-19,
			var="VUD1",speed=6,
			sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),color = Color(120,120,120),
		}},
	}
}

ENT.ButtonMap["IGLAButtons"] = {
	pos = Vector(420.4,-56.1,9.87),
	ang = Angle(-0,180-0.5,90),
	width = 87,
	height = 70,
	scale = 0.0625,
		buttons = {
			{ID = "IGLA1USet",x=11, y=39-6, w=12, h=7, tooltip="ИГЛА: Первая кнопка вверх"},
			{ID = "IGLA1Set",x=11, y=46-6, w=12, h=7, tooltip="ИГЛА: Первая кнопка"},
			{ID = "IGLA1DSet",x=11, y=53-6, w=12, h=7, tooltip="ИГЛА: Первая кнопка вниз"},
			{ID = "IGLA2USet",x=65, y=39-6, w=12, h=7, tooltip="ИГЛА: Вторая кнопка вверх"},
			{ID = "IGLA2Set",x=65, y=46-6, w=12, h=7, tooltip="ИГЛА: Вторая кнопка"},
			{ID = "IGLA2DSet",x=65, y=53-6, w=12, h=7, tooltip="ИГЛА: Вторая кнопка вниз"},
			{ID = "!IGLASR",x=17.9, y=10.5, radius=3, tooltip="ИГЛА: SR", model = {
				lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl", var="IGLASR",color=Color(175,250,20),z=-2.5},
			}},
			{ID = "!IGLARX",x=27.5, y=10.5, radius=3, tooltip="ИГЛА: RX", model = {
				lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl", var="IGLARX",color=Color(255,56,30),z=-2.5},
			}},
			{ID = "!IGLAErr",x=40.5, y=10.5, radius=3, tooltip="ИГЛА: Отказ", model = {
				lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl", var="IGLAErr",color=Color(255,168,000),z=-2.5},
			}},
			{ID = "!IGLAOSP",x=50, y=10.5, radius=3, tooltip="ИГЛА: ОСП", model = {
				lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl", var="IGLAOSP",color=Color(175,250,20),z=-2.5},
			}},
			{ID = "!IGLAPI",x=59.3, y=10.5, radius=3, tooltip="ИГЛА: ПИ", model = {
				lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl", var="IGLAPI",color=Color(255,56,30),z=-2.5},
			}},
			{ID = "!IGLAOff",x=68.3, y=10.5, radius=3, tooltip="ИГЛА: Откл", model = {
				lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl", var="IGLAOff",color=Color(255,56,30),z=-2.5},
			}},
		}
}
ENT.ButtonMap["IGLA"] = {
	pos = Vector(420.4-0.65,-56.1-0.15,9.87-1.15),
	ang = Angle(-0,180-0.5,90),
	width = 512,
	height = 128,
	scale = 0.025/2.96,
}

ENT.ButtonMap["Back1"] = {
	pos = Vector(405.5,-50.9,34.0),
	ang = Angle(0,90,90),
	width = 280,
	height = 250,
	scale = 0.1088,

	buttons = {
	{ID = "!ULSPM", x=121, y=71, radius=30, tooltip="УЛСПМ (Уствойство связи пассажир-машинист)\nULSPM"},
	{ID = "!TonalARS", x=191, y=71, radius=30, tooltip="Тональное устройство - Звонок\nRing"},
	{ID = "!PressureRelay", x=-9, y=236, radius=50, tooltip="Регулятор давления\nPressure controller"},
	{ID = "!Reproductor", x=90, y=9, radius=30, tooltip="Громкоговоритель\nSpeaker"},
	{ID = "!LVFuses", x=70, y=145, w=180, h=50, tooltip="Щиток с низковольтными предохранителями\nShield with low-voltage fuses"},
	{ID = "R_UNchToggle", x=-30, y=20, w=100, h=140, tooltip="Питание статива РРИ\nRadioinformator control", model = {
		model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=15, ang = 180,
		var="R_UNch",speed=6,
		sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
		sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,90),
	}},
	}
}

ENT.ButtonMap["Back2"] = {
	pos = Vector(405.5,25.9,4.0),
	ang = Angle(0,90,90),
	width = 280,
	height = 340,
	scale = 0.1088,

	buttons = {
	{ID = "!HVFuses", x=0, y=12, w=280, h=130, tooltip="Блок предохранителей\nBlock Fuse HV fuses"},
	{ID = "!Relays", x=0, y=170, w=300, h=270, tooltip="Ящик с аппаратами для подзаряда аккумуляторной батареи и дверной воздухораспределитель\nThe box with the devices for battery recharging and door pressure diffuser"},
	{ID = "!Heater", x=280, y=170, w=80, h=300, tooltip="Печка\nThe heater"},
	}
}

ENT.ButtonMap["Back3"] = {
	pos = Vector(405.5,-20,52.0),
	ang = Angle(0,90,90),
	width = 500,
	height = 200,
	scale = 0.1088,

	buttons = {
	{ID = "!RTM", x=394, y=191, radius=30, tooltip="Пульт диспетчерской радиосвязи\nRemote radio with dispatcher"},
	{ID = "!ULSPMSpeaker", x=289, y=66, radius=40, tooltip="Блок громкоговорителя связи пассажир-машинист\nRemote radio with dispatcher"},
	{ID = "!Amplifier", x=50, y=77, radius=40, tooltip="Блок усилителя поездной радиостанции\namplifier unit of train station"},
	}
}

--VU1 Panel
ENT.ButtonMap["VU1"] = {
	pos = Vector(456+7.6,-16.7,31.2),
	ang = Angle(0,270,90),
	width = 120,
	height = 300,
	scale = 0.0625,

	buttons = {
		{ID = "KRPSet",			x=43, y=210, w=50, h=110, tooltip="РРП: Резервный пуск \nRRP: Motor emergency toggle", model = {
			model = "models/metrostroi_train/switches/vudwhite.mdl", z=20,
			var="KRP",speed=6,
			sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0), color = Color(80,80,80),
		}},
	}
}


ENT.ButtonMap["KRR"] = {
	pos = Vector(402.5,-36.8,10),
	ang = Angle(0,90,90),
	width = 335,
	height = 380,
	scale = 0.0625,

	buttons = {
		{ID = "KRRSet", x=170, y=120,  radius=20, tooltip="KРР: Кнопка разворота реверсоров\nKRR: Button of enabling reversors", model = {
			model = "models/metrostroi_train/Equipment/button_ezh_6.mdl",z=15,
			var="KRR", speed=16, min=1,max=0,
			sndvol = 0.10, snd = function(val) return val and "button2_on" or "button1_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
		}},
	}
}

--VU Panel
ENT.ButtonMap["VU"] = {
	pos = Vector(456+7.6,-16.15,12.0),
	ang = Angle(0,270,90),
	width = 100,
	height = 220,
	scale = 0.0625,

	buttons = {
		{ID = "VUToggle", x=0, y=110, w=100, h=110, tooltip="ВУ: Выключатель Управления\nVU: Train control", model = {
			model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=20, ang = 180,
			var="VU",speed=6,
			sndvol = 0.5, snd = function(val) return val and "vu22_on" or "vu22_off" end,
			sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0), color = Color(200,200,250),
		}},

	}
}


ENT.ButtonMap["Stopkran"] = {
	pos = Vector(459+7,27,20.7),
	ang = Angle(0,-90,90),
	width = 200,
	height = 1300,
	scale = 0.1/2,
		buttons = {
			{ID = "EmergencyBrakeValveToggle",x=0, y=0, w=200, h=1300, tooltip="Стопкран\nEmergency brake"},
	}
}

ENT.ButtonMap["Tsepi"] = {
	pos = Vector(456+7.6,-16.15,10.5),
	ang = Angle(0,273,90),
	width = 85,
	height = 50,
	scale = 0.0625,

	buttons = {
		{x=0,y=0,w=85,h=50,tooltip="Напряжение цепей управления"},
	}
}

ENT.ButtonMap["AVMain"] = {
	pos = Vector(403.5,40.8,42),
	ang = Angle(0,90,90),
	width = 335,
	height = 380,
	scale = 0.0625,

	buttons = {
		{ID = "AV8BToggle", x=0, y=0, w=300, h=380, tooltip="АВ-8Б: Автоматическй выключатель (Вспомогательные цепи высокого напряжения)\n", model = {
			model = "models/metrostroi_train/switches/automain.mdl", z=43, ang = -90,
			var="AV8B",speed=6, vmin=0.0,vmax=1, skin=2,
			sndvol = 3, snd = function(val) return val and "av8_on" or "av8_off" end,
		}},
	}
}
---AV1 Panel
ENT.ButtonMap["AV1"] = {
	pos = Vector(403.5,41,16),
	ang = Angle(0,90,90),
	width = 290+0,
	height = 155,
	scale = 0.0625,

	buttons = {
		{ID = "VU3Toggle", x=0, y=0, w=100, h=140, tooltip="ВУ3: Освещение кабины\n", model = {
			model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=20, ang = 180,
			var="VU3",speed=6,
			sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
			sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
		}},
		{ID = "VU2Toggle", x=110, y=0, w=100, h=140, tooltip="ВУ2: Аварийное освещение\n", model = {
			model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=20, ang = 180,
			var="VU2",speed=6,
			sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
			sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
		}},
		{ID = "VU1Toggle", x=220, y=0, w=100, h=140, tooltip="ВУ1: Печь отопления кабины\n", model = {
			model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=20, ang = 180,
			var="VU1",speed=6,
			sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
			sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0), color = Color(150,150,150),
		}},
	}
}

ENT.ButtonMap["AV2"] = {
	pos = Vector(403.5,30.40,31.1),
	ang = Angle(0,90,90),
	width = 180,
	height = 136,
	scale = 0.0625,

	buttons = {
		{ID = "RSTToggle", x=0, y=0, w=100, h=136, tooltip="РСТ: Радиостанция\nRST: Radiostation", model = {
			model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=20, ang = 180,
			plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=24,z=0,var="RSTPl", ID="RSTPl",},
			var="RST",speed=6,
			sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
			sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
		}},
	}
}


-- Battery panel
ENT.ButtonMap["Battery"] = {
	pos = Vector(403.5,16,20.5),
	ang = Angle(0,90,90),
	width = 250,
	height = 300,
	scale = 0.0625,

	buttons = {
		{ID = "VBToggle", x=100, y=0, w=250, h=140, tooltip="АБ: Выключатель аккумуляторной батареи (Вспомогательные цепи низкого напряжения)\nVB: Battery on/off", model = {
			model = "models/metrostroi_train/Equipment/vu22_brown_3.mdl", z=15, ang = 180,
			var="VB",speed=6,
			sndvol = 1, snd = function(val) return val and "vu223_on" or "vu223_off" end,
			sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
		}},
		{ID = "R_RadioToggle", x=30, y=180, w=250, h=140, tooltip="Питание радиоинформатора +50В\nRadioinformator", model = {
			model = "models/metrostroi_train/Equipment/vu22_brown.mdl", z=15, ang = 180,
			var="R_Radio",speed=6,
			sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
			sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
		}},
	}
}

ENT.ButtonMap["ASNP"] = {
	pos = Vector(438.59+4,-55.33-1.78,43.99),
	ang = Angle(-.4,180,90),
	--pos = Vector(462.77,-51.43-1.3,5.85),
	--ang = Angle(-.4,230,90),
	width = 220,
	height = 100,
	scale = 0.0625,

	buttons = {
		{ID = "R_ASNPMenuSet",x=100, y=40, radius=8, tooltip = "Информатор: Меню",model = {
			model = "models/metrostroi_train/81-720/button_round.mdl",
			var="R_ASNPMenu",speed=12, vmin=0, vmax=0.9,
			sndvol = 0.8, snd = function(val) return val and "pnm_button1_on" or "pnm_button1_off" end,
			sndmin = 50, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
		{ID = "R_ASNPUpSet",x=140, y=8, radius=8, tooltip = "Информатор: Вверх",model = {
			model = "models/metrostroi_train/81-720/button_round.mdl",
			var="R_ASNPUp",speed=12, vmin=0, vmax=0.9,
			sndvol = 0.8, snd = function(val) return val and "pnm_button1_on" or "pnm_button1_off" end,
			sndmin = 50, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
		{ID = "R_ASNPDownSet",x=140, y=8+15, radius=8, tooltip = "Информатор: Вниз",model = {
			model = "models/metrostroi_train/81-720/button_round.mdl",
			var="R_ASNPDown",speed=12, vmin=0, vmax=0.9,
			sndvol = 0.8, snd = function(val) return val and "pnm_button1_on" or "pnm_button1_off" end,
			sndmin = 50, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
		{ID = "R_ASNPOnToggle",x=52, y=8, radius=8, tooltip = "Информатор: Включение",model = {
			model = "models/metrostroi_train/81-720/tumbler2.mdl", ang=0, z = 7,
			var="R_ASNPOn",speed=12, vmin=1, vmax=0,
			sndvol = 0.8, snd = function(val) return val and "pnm_on" or "pnm_off" end,
			sndmin = 50, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
	}
}

ENT.ButtonMap["ASNPScreen"] = {
	pos = Vector(438.59,-55.33-1.3,43.99),
	ang = Angle(-.4,180,90),
	width = 512,
	height = 128,
	scale = 0.025/3,
}


-- Parking brake panel
ENT.ButtonMap["ParkingBrake"] = {
	pos = Vector(460,46.0,-2.0),
	ang = Angle(0,-70,90),
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
	pos = Vector(452.5,61.5,18.44),
	ang = Angle(0,-17.5,90),
	width = 60,
	height = 200,
	scale = 0.0625,

	buttons = {
		{ID = "R_Program1Set",	x=12, y=200, radius=30, tooltip="Программа 1\nProgram 1", model = {
			model = "models/metrostroi_train/81-703/cabin_button_black.mdl", z=-26, color = Color(255,255,255),
			var="R_Program1",speed=6,
			sndvol = 1, snd = function(val) return val and "pnm_button1_on" or "pnm_button1_off" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
		{ID = "R_Program2Set",	x=47, y=200, radius=30, tooltip="Программа 2\nProgram 2", model = {
			model = "models/metrostroi_train/81-703/cabin_button_black.mdl", z=-26, color = Color(255,255,255),
			var="R_Program2",speed=6,
			sndvol = 1, snd = function(val) return val and "pnm_button1_on" or "pnm_button1_off" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
		{ID = "VDLSet",			 x=30, y=42, radius=30, tooltip="ВДЛ: Выключатель левых дверей\nVDL: Left doors open", model = {
			model = "models/metrostroi_train/switches/vudwhite.mdl", z=-3, color = Color(255,255,255),
			var="VDL",speed=6,
			sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
		{ID = "VUD2Toggle",			 x=30, y=138, radius=30, tooltip="ВУД2: Выключатель управления дверьми\nVUD2: Door control toggle (close doors)", model = {
			model = "models/metrostroi_train/switches/vudwhite.mdl", z=-3, color = Color(255,255,255),
			var="VUD2",speed=6,
			sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
	}
}


-- Pneumatic instrument panel 2
ENT.ButtonMap["PneumaticManometer"] = {
	pos = Vector(451.73+7.6,-54,14.04),
	ang = Angle(0,-144,90),
	width = 76,
	height = 70,
	scale = 0.0625,

	buttons = {
		{ID = "!LinesPressure", x=68,y=65,radius=68,tooltip="Давление в магистралях (красная: тормозной, чёрная: напорной)\nPressure in pneumatic lines (red: brake line, black: train line)"},
	}
}
-- Pneumatic instrument panel
ENT.ButtonMap["PneumaticPanels"] = {
	pos = Vector(454.07+7.6,-50.11,5.9),
	ang = Angle(0,-90-27,90),

	width = 76,
	height = 70,
	scale = 0.0625,

	buttons = {
		{ID = "!CylinderPressure", x=38,y=35,radius=35,tooltip="Тормозной манометр: Давление в тормозных цилиндрах (ТЦ)\nBrake cylinder pressure"},
	}
}
ENT.ButtonMap["DriverValveBLDisconnect"] = {
	pos = Vector(443.5+7,-53,-37.61),
	ang = Angle(-90,0,0),
	width = 200,
	height = 90,
	scale = 0.0625,

	buttons = {
		{ID = "DriverValveBLDisconnectToggle", x=0, y=0, w=95, h=100, tooltip="Кран двойной тяги тормозной магистрали\nTrain line disconnect valve", model = {
			var="DriverValveBLDisconnect",sndid="brake_disconnect",
			sndvol = 1, snd = function(val) return "disconnect_valve" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
	}
}
ENT.ButtonMap["DriverValveTLDisconnect"] = {
	pos = Vector(447+5,-46,-31),
	ang = Angle(-90,-10,0),
	width = 200,
	height = 90,
	scale = 0.0625,

	buttons = {
		{ID = "DriverValveTLDisconnectToggle", x=0, y=0, w=75, h=100, tooltip="Кран двойной тяги напорной магистрали\nBrake line disconnect valve", model = {
			var="DriverValveTLDisconnect",sndid="train_disconnect",
			sndvol = 1, snd = function(val) return val and "pneumo_TL_open" or "pneumo_TL_disconnect" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
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


-- Temporary panels (possibly temporary)
ENT.ButtonMap["FrontPneumatic"] = {
	pos = Vector(468+7,-45.0,-59.9),
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
	pos = Vector(-468-7,45.0,-59.9),
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
	pos = Vector(444+5,56,-5),
	ang = Angle(0,-70,90),
	width = 230,
	height = 170,
	scale = 0.0625,

	buttons = {
		{ID = "UAVAToggle",x=0, y=0, w=230/2, h=170, tooltip="УАВА: Универсальный Автоматический Выключатель Автостопа (отключение автостопа)\nUAVA: Universal Automatic Autostop Disabler (autostop disable)", model = {
			plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=-20,x=6,y=65,z=-122,var="UAVAPl", ID="UAVAPl",},
			var="UAVA",
			sndid="UAVALever",sndvol = 1, snd = function(val) return val and "uava_on" or "uava_off" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
		{ID = "UAVAContactSet",x=230/2, y=0, w=230/2, h=170, tooltip="УАВА: Универсальный Автоматический Выключатель Автостопа (восстановление контактов)\nUAVA: Universal Automatic Autostop Disabler(contacts reset)"},
	}
}



for i=0,4 do
	ENT.ClientProps["TrainNumberL"..i] = {
		model = "models/metrostroi_train/common/bort_numbers.mdl",
		pos = Vector(295+i*6.6-4*6.6/2,69,-26),
		ang = Angle(180,0,180),
		skin=0,
	}
end
for i=0,4 do
	ENT.ClientProps["TrainNumberR"..i] = {
		model = "models/metrostroi_train/common/bort_numbers.mdl",
		pos = Vector(295+i*6.6-4*6.6/2,-66.4,-26),
		ang = Angle(0,0,0),
		skin=0,
	}
end

ENT.ButtonMap["InfoTableSelect"] = {
	pos = Vector(455+7.0,35,14.0),
	ang = Angle(0,-90,90),
	width = 400,
	height = 100,
	scale = 0.1,


	buttons = {
		{ID = "PrevSign",x=300,y=0,w=50,h=100, tooltip="Предыдущая надпись\nPrevious sign"},
		{ID = "NextSign",x=350,y=0,w=50,h=100, tooltip="Следующая надпись\nNext sign"},

		{ID = "Num2P",x=0,y=0,w=50,h=50, tooltip="Маршрут: Увеличить число 2\nRoute: Increase 2nd number"},
		{ID = "Num2M",x=0,y=50,w=50,h=50, tooltip="Маршрут: Уменьшить число 2\nRoute: Decrease 2nd number"},
		{ID = "Num1P",x=50,y=0,w=50,h=50, tooltip="Маршрут: Увеличить число 1\nRoute: Increase 1st number"},
		{ID = "Num1M",x=50,y=50,w=50,h=50, tooltip="Маршрут: Уменьшить число 1\nRoute: Decrease 1st number"},
	}
}


ENT.ButtonMap["Front"] = {
	pos = Vector(468,16,43.4),
	ang = Angle(0,-90,90),
	width = 642,
	height = 1780,
	scale = 0.1/2,
	buttons = {
		{ID = "FrontDoor",x=0,y=0,w=642,h=1900, tooltip="Передняя дверь\nFront door", model = {
			var="door1",sndid="door1",
			sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
	}
}

ENT.ButtonMap["CabinDoor"] = {
	pos = Vector(416,64,43.4),
	ang = Angle(0,0,90),
	width = 642,
	height = 1780,
	scale = 0.1/2,
	buttons = {
		{ID = "CabinDoor",x=0,y=0,w=642,h=2000, tooltip="Дверь в кабину машиниста\nCabin door", model = {
			var="door2",sndid="door2",
			sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
	}
}

ENT.ButtonMap["PassengerDoor"] = {
	pos = Vector(384,-16,43.4),
	ang = Angle(0,90,90),
	width = 642,
	height = 1900,
	scale = 0.1/2,
	buttons = {
		{ID = "PassengerDoor",x=0,y=0,w=642,h=2000, tooltip="Дверь в кабину машиниста из салона\nPass door", model = {
			var="door3",sndid="door3",
			sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
	}
}
ENT.ButtonMap["PassengerDoor1"] = {
	pos = Vector(384,16,43.4),
	ang = Angle(0,-90,90),
	width = 642,
	height = 1900,
	scale = 0.1/2,
	buttons = {
		{ID = "PassengerDoor",x=0,y=0,w=642,h=2000, tooltip="Дверь в кабину машиниста из салона\nPass door", model = {
			var="door3",sndid="door3",
			sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
	}
}

ENT.ButtonMap["Back"] = {
	pos = Vector(-470,-15,43.4),
	ang = Angle(0,90,90),
	width = 642,
	height = 1780,
	scale = 0.1/2,
	buttons = {
		{ID = "BackDoor",x=0,y=0,w=642,h=1900, tooltip="Задняя дверь", model = {
			var="door4",sndid="door4",
			sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
			sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
		}},
	}
}

ENT.ClientPropsInitialized = false
if not ENT.ClientSounds["br_334"] then ENT.ClientSounds["br_334"] = {} end
table.insert(ENT.ClientSounds["br_334"],{"brake",function(ent,_,var) return "br_334_"..var end,1,1,50,1e3,Angle(-90,0,0)})
ENT.ClientProps["brake"] = {
	model = "models/metrostroi_train/81-703/cabin_cran_334.mdl",
	pos = Vector(448.62+7.6,-51.69,-3.0),
	ang = Angle(0,-133,0),
}
ENT.ClientProps["controller"] = {
	model = "models/metrostroi_train/81-707/kv_ezh.mdl",
	pos = Vector(451.36+6.4,-24.73,-3.5),
	ang = Angle(0,180+15,0)
}

ENT.ClientProps["reverser"] = {
	model = "models/metrostroi/81-717/reverser.mdl",
	pos = Vector(451.36+7.6,-23.43,-4.7),
	ang = Angle(0,45,90)
}
ENT.ClientProps["brake_disconnect"] = {
	model = "models/metrostroi_train/81-707/cran1.mdl",
	pos = Vector(441.0+8.2,-55.30,-33.91),
	ang = Angle(0,92,-90),
}

ENT.ClientProps["train_disconnect"] = {
	model = "models/metrostroi_train/81-707/cran3.mdl",
	pos = Vector(444.482483+8.4,-50.746734,-27.333017),
	ang = Angle(90,-100,90),
}
ENT.ClientProps["parking_brake"] = {
	model = "models/metrostroi_train/81-703/cabin_parking.mdl",
	pos = Vector(449.118378+7.6,33.493385,-14.713276),
	ang = Angle(-90.000000,8.000000,0.000000),
}

--------------------------------------------------------------------------------
ENT.ClientProps["train_line"] = {
	model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
	pos = Vector(448.20+7.87,-50.91-4,12.1),
	ang = Angle(-90,-90-48,90)
}
ENT.ClientProps["brake_line"] = {
	model = "models/metrostroi_train/Equipment/arrow_tm.mdl",
	pos = Vector(448.20+7.89,-50.94-4,12.1),
	ang = Angle(-90,-90-48,90)
}

ENT.ClientProps["brake_cylinder"] = {
	model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
	pos = Vector(453.199+7.4,-52.52,2.73000),
	ang = Angle(222,80,-90.000000),
}
----------------------------------------------------------------
ENT.ClientProps["voltmeter"] = {
	model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
	pos = Vector(450.284607+6.0,-56.887834,26.5+0),
	ang = Angle(-90,0,-60)
}

ENT.ClientProps["ampermeter"] = {
	model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
	pos = Vector(450.284607+5.9,-56.987834,30.5+0.4),
	ang = Angle(-90,0,-60)
}

ENT.ClientProps["volt1"] = {
	model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
	pos = Vector(458.81455+4.2,-19.63349,7.95662-1+0.4),
	ang = Angle(-90,0,0),
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

	ENT.ButtonMap["InfoTableSelect"] = {
	pos = Vector(464.0,15,22.0),
	ang = Angle(0,-90,90),
	width = 550,
	height = 100,
	scale = 0.1,


	buttons = {
		{ID = "PrevSign",x=0,y=0,w=50,h=100, tooltip="Предыдущая надпись\nPrevious sign"},
		{ID = "NextSign",x=50,y=0,w=50,h=100, tooltip="Следующая надпись\nNext sign"},

		{ID = "Num2P",x=450,y=0,w=50,h=50, tooltip="Маршрут: Увеличить число 2\nRoute: Increase 2nd number"},
		{ID = "Num2M",x=450,y=50,w=50,h=50, tooltip="Маршрут: Уменьшить число 2\nRoute: Decrease 2nd number"},
		{ID = "Num1P",x=500,y=0,w=50,h=50, tooltip="Маршрут: Увеличить число 1\nRoute: Increase 1st number"},
		{ID = "Num1M",x=500,y=50,w=50,h=50, tooltip="Маршрут: Уменьшить число 1\nRoute: Decrease 1st number"},
	}
}

ENT.ClientProps["Ema_salon"] = {
	model = "models/metrostroi_train/81-508/81-508_salon.mdl",
	pos = Vector(0,0,0),
	ang = Angle(0,0,0)
}
ENT.ClientProps["E_informator"] = {
	model = "models/metrostroi_train/81-703/703_asotp.mdl",
	pos = Vector(7,1.5,2),
	ang = Angle(0,0,0)
	}
ENT.ClientProps["tab"] = {
	model = "models/metrostroi_train/Equipment/tab.mdl",
	pos = Vector(-0.0,0,-0),
	ang = Angle(0,0,0),
	skin = 2,
	}
ENT.ClientProps["route"] = {
	model = "models/metrostroi_train/common/routes/ezh/route_holder.mdl",
	pos = Vector(0,0,0),
	ang = Angle(0,0,0)
}
	ENT.ClientProps["route1"] = {
	model = "models/metrostroi_train/common/routes/ezh/route_number1.mdl",
	pos = Vector(0,0,0),
	ang = Angle(0,0,0)
}
	ENT.ClientProps["route2"] = {
	model = "models/metrostroi_train/common/routes/ezh/route_number2.mdl",
	pos = Vector(0,0,0),
	ang = Angle(0,0,0)
	}
ENT.ClientProps["Ema_salon2"] = {
	model = "models/metrostroi_train/81-508/81-508_underwagon.mdl",
	pos = Vector(0,1,-18),
	ang = Angle(0,0,0)
}
ENT.ClientProps["Lamps_emer"] = {
	model = "models/metrostroi_train/81-508/81-508_lamps_emer.mdl",
	pos = Vector(0,0,0),
	ang = Angle(0,0,0),
}
ENT.ClientProps["Lamps_full"] = {
	model = "models/metrostroi_train/81-508/81-508_lamps.mdl",
	pos = Vector(0,0,0),
	ang = Angle(0,0,0),
}

ENT.ClientProps["FrontBrake"] = {--
	model = "models/metrostroi_train/81/tmiso.mdl",
	pos = Vector(445+7, -30, -68),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["FrontTrain"] = {--
	model = "models/metrostroi_train/81/nmsio.mdl",
	pos = Vector(445+7, 30, -68),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["RearBrake"] = {--
	model = "models/metrostroi_train/81/tmiso.mdl",
	pos = Vector(-450-6, -30, -68),
	ang = Angle(0,90,0)
}
ENT.ClientProps["RearTrain"] = {--
	model = "models/metrostroi_train/81/nmsio.mdl",
	pos = Vector(-450-6, 30, -68),
	ang = Angle(0,90,0)
}
----Циферблат
ENT.ClientProps["speedo1"] = {
	model = "models/metrostroi_train/81-508/digit.mdl",
	pos = Vector(456.79,-39.0,-8.93),
	ang = Angle(113,0,0),
	color = Color(255,170,60),
}
ENT.ClientProps["speedo2"] = {
	model = "models/metrostroi_train/81-508/digit.mdl",
	pos = Vector(456.79,-39.0+0.44,-8.93),
	ang = Angle(113,0,0),
	color = Color(255,170,60),
}


--------------------------------------------------------------------------------
-- Add doors
local function GetDoorPosition(i,k,j)
	if j == 0
	then return Vector(344.9-0.1*k     - 233.6*i,-63.86*(1-2.02*k),-5.75)
	else return Vector(344.9-0.1*(1-k) - 233.6*i,-63.86*(1-2.02*k),-5.75)
	end
end
for i=0,3 do
	for k=0,1 do
		ENT.ClientProps["door"..i.."x"..k.."a"] = {
			model = "models/metrostroi_train/81-508/81-508_door_right.mdl",
			pos = GetDoorPosition(i,k,0),
			ang = Angle(0,90 + 180*k,0)
		}
		ENT.ClientProps["door"..i.."x"..k.."b"] = {
			model = "models/metrostroi_train/81-508/81-508_door_left.mdl",
			pos = GetDoorPosition(i,k,1),
			ang = Angle(0,90 + 180*k,0)
		}
	end
end
ENT.ClientProps["door1"] = {
	model = "models/metrostroi_train/81-508/81-508_door_front.mdl",
	pos = Vector(460.62+7.4,-14.53,-7.23),
	ang = Angle(0,-90,0),
}
ENT.ClientProps["door2"] = {
	model = "models/metrostroi_train/81-508/81-508_door_front.mdl",
	pos = Vector(-462.6-8,16.53,-7.24),
	ang = Angle(0,90,0),
}
ENT.ClientProps["door3"] = {
	model = "models/metrostroi_train/81-508/81-508_door_pass.mdl",
	pos = Vector(396.7-13.2,-15.0,-13),
	ang = Angle(0,90,0),
}
ENT.ClientProps["door4"] = {
	model = "models/metrostroi_train/81-508/81-508_door_cab.mdl",
	pos = Vector(411.17+7.6,66.05,-6.38),
	ang = Angle(0,-90,0),
}
ENT.ClientProps["UAVALever"] = {
	model = "models/metrostroi_train/81-703/cabin_uava.mdl",
	pos = Vector(449+7.7,56.0,-10.24349),
	ang = Angle(0,-90,90)
}

ENT.ClientProps["RedLights"] = {
	model = "models/metrostroi_train/81-703/81-703_red_light.mdl",
	pos = Vector(-23+7.2,1,-191),
	ang = Angle(0,0,0.000000),
}
ENT.ClientProps["DistantLights"] = {
	model = "models/metrostroi_train/81-703/81-703_projcetor_light.mdl",
	pos = Vector(-23+8.2,1,-191),
	ang = Angle(00.000000,0.000000,0.000000),
}
ENT.ClientProps["WhiteLights"] = {
	model = "models/metrostroi_train/81-703/81-703_front_light.mdl",
	pos = Vector(-23+7.6,1,-191),
	ang = Angle(0,0,0),
}

ENT.Lights = {
	[1] = { "headlight",		Vector(475,0,-20), Angle(0,0,0), Color(169,130,88), brightness = 2 ,fov = 90 },
	[22] = { "headlight", 		Vector(432,-45,45.2), Angle(90,0,0), Color(255,125,25), hfov=90, vfov=90,farz=66,brightness = 9,shadows = 1, texture = "effects/flashlight/soft"},
}
function ENT:Initialize()
	self.BaseClass.Initialize(self)
	--self.Train:SetPackedRatio("EmergencyValve_dPdT", leak)
	--self.Train:SetPackedRatio("EmergencyValveEPK_dPdT", leak)
	--self.Train:SetPackedRatio("EmergencyBrakeValve_dPdT", leak)
	self.ASNP = self:CreateRT("717ASNP",512,128)
	self.IGLA = self:CreateRT("717IGLA",512,128)
	self.CraneRamp = 0
	self.ReleasedPdT = 0
	self.EmergencyValveRamp = 0
	self.EmergencyValveEPKRamp = 0
	self.EmergencyBrakeValveRamp = 0
end

function ENT:UpdateTextures()
	self.Texture = self:GetNW2String("texture")
	self.PassTexture = self:GetNW2String("passtexture")
	self.CabinTexture = self:GetNW2String("cabtexture")

	self.Number = self:GetWagonNumber()
	self.LastStation = self:GetNW2Int("LastStation")

	self.RouteNumber = self:GetNW2String("RouteNumber","00")

	local texture = Metrostroi.Skins["train"][self.Texture]
	local passtexture = Metrostroi.Skins["pass"][self.PassTexture]
	local cabintexture = Metrostroi.Skins["cab"][self.CabinTexture]
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

	local count = math.max(4,math.ceil(math.log10(self.Number)))
	for i=0,4 do
		self:ShowHide("TrainNumberL"..i,i<count)
		self:ShowHide("TrainNumberR"..i,i<count)
		if i< count then
			local num = math.floor(self.Number%(10^(i+1))/10^i)
			local leftNum = self.ClientEnts["TrainNumberL"..i]
			leftNum:SetPos(self:LocalToWorld(Vector(295+i*6.6-count*6.6/2,69,-26)))
			leftNum:SetSkin(num)
			local rightNum = self.ClientEnts["TrainNumberR"..i]
			rightNum:SetPos(self:LocalToWorld(Vector(-280-i*6.6-count*6.6/2,-66.6,-26)))
			rightNum:SetSkin(num)
		end
	end

	if IsValid(self.ClientEnts["route1"]) and IsValid(self.ClientEnts["route2"]) then
		local rn = Format("%02d",self:GetNW2String("RouteNumber","00"))
		self.ClientEnts["route1"]:SetSkin(rn[1])
		self.ClientEnts["route2"]:SetSkin(rn[2])
	end
end
--------------------------------------------------------------------------------
function ENT:Think()
	self.BaseClass.Think(self)
	if not self.RenderClientEnts or self.CreatingCSEnts then
		self.Number = false
		self.RouteNumber = false
		self.LastStation = false
		return
	end

	if self.Texture ~= self:GetNW2String("texture") then self:UpdateTextures()	end
	if self.PassTexture ~= self:GetNW2String("passtexture") then self:UpdateTextures()	end
	if self.CabinTexture ~= self:GetNW2String("cabtexture") then self:UpdateTextures()	end
	if self.LastStation ~= self:GetNW2Int("LastStation") then self:UpdateTextures()	end
	if self.RouteNumber ~= self:GetNW2String("RouteNumber","00") then self:UpdateTextures()	end
	if self.Number ~= self:GetWagonNumber() then self:UpdateTextures()	end

	self:SetLightPower(1,self:GetPackedRatio("Headlight") > 0,self:GetPackedRatio("Headlight"))
	if IsValid(self.GlowingLights[1]) then
		self.GlowingLights[1]:SetEnableShadows(true)
		if not self:GetPackedBool("HeadLights1") and self.GlowingLights[1]:GetFarZ() ~= 3144 then
			self.GlowingLights[1]:SetFarZ(3144)
		end
		if self:GetPackedBool("HeadLights1") and self.GlowingLights[1]:GetFarZ() ~= 5144 then
			self.GlowingLights[1]:SetFarZ(5144)
		end
	end
	local val = self.Anims["gauges_lit"] and self.Anims["gauges_lit"].value^3 or 0
	self:SetLightPower(22,val>0,val)--self:GetPackedBool("PanelLights"))

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
	self.TrueBrakeAngle = self.TrueBrakeAngle or 0
	self.TrueBrakeAngle = self.TrueBrakeAngle + (self:GetPackedRatio("ManualBrake")*360*3.2 - self.TrueBrakeAngle)*2.0*(self.DeltaTime or 0)
	if self.ClientEnts and self.ClientEnts["parking_brake"] then
		self.ClientEnts["parking_brake"]:SetPoseParameter("position",1.0-((self.TrueBrakeAngle % 360)/360))
	end
	local BAsnd = math.floor(self.TrueBrakeAngle/10)
	if self.BrakeAngleSND ~= BAsnd then
		if not IsValid(self.Sounds["parking_brake_rolling"]) or self.Sounds["parking_brake_rolling"]:GetState() ~= GMOD_CHANNEL_PLAYING then
			self:PlayOnce("parking_brake_rolling","bass",1,1)
		end
		self.BrakeAngleSND = BAsnd
	end
	local Lamps = self:GetPackedBool(20) and 0.6 or 1
	self:ShowHideSmooth("Lamps_emer",self:Animate("lamps_emer",self:GetPackedBool("Lamps_emer") and Lamps or 0,0,1,6,false))
	self:ShowHideSmooth("Lamps_full",self:Animate("lamps_full",self:GetPackedBool("Lamps_full") and Lamps or 0,0,1,6,false))
	self:ShowHideSmooth("Gauges_lit",self:Animate("gauges_lit",(self:GetPackedBool("L_3") and self:GetPackedBool("VB")) and 1 or 0,0,1,12,false))

	self:Animate("KRR",	self:GetPackedBool("KRR") and 0 or 1,0,1, 16, false)
	self:Animate("KRP",	self:GetPackedBool(113) and 1 or 0,0,1, 16, false)


	self:ShowHideSmooth("RedLights",self:Animate("redlights",self:GetPackedBool("RedLight") and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("WhiteLights",self:Animate("whitelights",self:GetPackedBool("HeadLights2") and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("DistantLights",self:Animate("distantlights",self:GetPackedBool("HeadLights1") and 1 or 0,0,1,5,false))

	self:Animate("brake_disconnect",self:GetPackedBool("DriverValveBLDisconnect") and 0 or 1,0.25,0.5,  4,false)
	self:Animate("train_disconnect",self:GetPackedBool("DriverValveTLDisconnect") and 1 or 0,0.25,0,  4,false)

	self:Animate("UAVALever",	self:GetPackedBool(152) and 0 or 1, 	0,0.25, 128,  3,false)



	-- Simulate pressure gauges getting stuck a little
	self:Animate("brake", 		1-self:GetPackedRatio(0), 			0.00, 0.48,  256,24)
	self:Animate("controller",		self:GetPackedRatio(1),				0, 0.31,  2,false)
	self:Animate("reverser",		self:GetPackedRatio(2),				0.26, 0.35,  4,false)
	self:Animate("volt1", 			self:GetPackedRatio(10),			0.6,0.5,45,3)
	self:ShowHide("reverser",		self:GetPackedBool(0))

	self:Animate("brake_line",		self:GetPackedRatio(4),				0.133, 0.907,  359,3)--,,0.01)
	self:Animate("train_line",		self:GetPackedRatio(5)-transient,	0.133, 0.907,  359,3)--,,0.01)
	self:Animate("brake_cylinder",	self:GetPackedRatio(6),	 			0, 0.95,  359,3)--,,0.03)
	self:Animate("voltmeter",		self:GetPackedRatio(7),				0.632,0.36,92,2)
	self:Animate("ampermeter",		self:GetPackedRatio(8),				0.632,0.36,				nil, nil,  92,20,3)


	local door1 = self:Animate("door1",	self:GetPackedBool(157) and 0.99 or 0,0,0.22, 1024, 1)
	local door2 = self:Animate("door2",	self:GetPackedBool(156) and 0.99 or 0,0,0.25, 1024, 1)
	local door3 = self:Animate("door3",	self:GetPackedBool(158) and 0.99 or 0,1,0.79, 1024, 1)
	local door4 = self:Animate("door4",	self:GetPackedBool(159) and 0.99 or 0,1,0.77, 1024, 1)

	if self.Door1 ~= (door1 > 0) then
		self.Door1 = door1 > 0
		self:PlayOnce("door1","bass",self.Door1 and 1 or 0)
	end
	if self.Door2 ~= (door2 > 0) then
		self.Door2 = door2 > 0
		self:PlayOnce("door2","bass",self.Door2 and 1 or 0)
	end
	if self.Door3 ~= (door3 > 0) then
		self.Door3 = door3 > 0
		self:PlayOnce("door3","bass",self.Door3 and 1 or 0)
	end
	if self.Door4 ~= (door4 > 0) then
		self.Door4 = door4 > 0
		self:PlayOnce("door4","bass",self.Door4 and 1 or 0)
	end

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

	---BIG Digits
	if self:GetPackedBool(32) then
		local speed = self:GetPackedRatio("Speed")*100.0
		if IsValid(self.ClientEnts["speedo1"])then
			self.ClientEnts["speedo1"]:SetSkin(math.floor(speed)%10)
		end
		if IsValid(self.ClientEnts["speedo2"])then
			self.ClientEnts["speedo2"]:SetSkin(math.floor(speed/10))
		end
	end

	self:ShowHide("speedo1",self:GetPackedBool(32))
	self:ShowHide("speedo2",self:GetPackedBool(32))

	-- Animate doors
--self:InitializeSounds()
	if not self.DoorStates then self.DoorStates = {} end
	if not self.DoorLoopStates then self.DoorLoopStates = {} end
	for i=0,3 do
		for k=0,1 do
			local st = k==1 and "DoorL" or "DoorR"
			local doorstate = self:GetPackedBool(st)
			local id,sid = st..(i+1),"door"..i.."x"..k
			local state = self:GetPackedRatio(id)
			--print(state,self.DoorStates[state])
			if (state ~= 1 and state ~= 0) ~= self.DoorStates[id] then
				if doorstate and state < 1 or not doorstate and state > 0 then
				else
					if state > 0 then
						self:PlayOnce(sid.."o","",1,math.Rand(0.8,1.2))
					else
						self:PlayOnce(sid.."c","",1,math.Rand(0.8,1.2))
					end
				end
				self.DoorStates[id] = (state ~= 1 and state ~= 0)
			end
			if (state ~= 1 and state ~= 0) then
				self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) + 2*self.DeltaTime,0,1)
			else
				self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) - 6*self.DeltaTime,0,1)
			end
			self:SetSoundState(sid.."r",self.DoorLoopStates[id],0.8+self.DoorLoopStates[id]*0.2)
			local n_l = "door"..i.."x"..k.."a"
			local n_r = "door"..i.."x"..k.."b"
			local dlo = 1
			local dro = 1
			if self.Anims[n_l] then
				dlo = math.abs(state-(self.Anims[n_l] and self.Anims[n_l].oldival or 0))
				if dlo <= 0 and self.Anims[n_l].oldspeed then dlo = self.Anims[n_l].oldspeed/14 end
			end
			self:Animate(n_l,state,0,1, dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
			self:Animate(n_r,state,0,1, dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
		end
	end

	-- Door transient
	if (self.Transient or 0) ~= 0.0 then self.Transient = 0.0 end
	local door_state1 = self:GetPackedBool(21)
	local door_state2 = self:GetPackedBool(25)
	if door_state1 ~= self.PrevDoorState1 then
		self.PrevDoorState1 = door_state1
		self.Transient = 1.00
	end
	if door_state2 ~= self.PrevDoorState2 then
		self.PrevDoorState2 = door_state2
		self.Transient = 1.00
	end

	local dT = self.DeltaTime
	local speed = self:GetPackedRatio("Speed")*100.0
	local rol10 = math.Clamp(speed/12,0,1)*(1-math.Clamp((speed-25)/8,0,1))
	local rol40 = math.Clamp((speed-23)/8,0,1)*(1-math.Clamp((speed-55)/8,0,1))
	local rol40p = Lerp((speed-23)/50,0.6,1)
	local rol70 = math.Clamp((speed-50)/8,0,1)*(1-math.Clamp((speed-72)/5,0,1))
	local rol70p = Lerp(0.8+(speed-65)/25*0.2,0.8,1.2)
	local rol80 = math.Clamp((speed-70)/5,0,1)
	local rol80p = Lerp(0.8+(speed-72)/15*0.2,0.8,1.2)
	self:SetSoundState("rolling_10",rol10,0.6)
	self:SetSoundState("rolling_40",rol40,rol40p)
	self:SetSoundState("rolling_70",rol70,rol70p)
	self:SetSoundState("rolling_80",rol80,rol80p)
	--[[
	local sign = 1
	if dPdT < 0 then sign = -1 end
	if self.PrevDpSign ~= sign then
		self.PrevDpSign = sign
		self:SetSoundState("release",0.0,0.0)
	end]]


	local dT = self.DeltaTime
	local threshold = 0.01
	local dPdT = self:GetPackedRatio("BrakeCylinderPressure_dPdT")
	self.ReleasedPdT = math.Clamp(self.ReleasedPdT + 4*(-self:GetPackedRatio("BrakeCylinderPressure_dPdT",0)-self.ReleasedPdT)*dT,0,1)
	--print(dPdT)
	self:SetSoundState("release1",math.Clamp(self.ReleasedPdT,0,1)^1.65,1.0)

	if self:GetPackedBool(22) then
		self.CraneRamp = self.CraneRamp + 1.0*((0.9*self:GetPackedRatio("Crane_dPdT",0))-self.CraneRamp)*dT
		self:SetSoundState("crane334_brake",0,1.0)
		self:SetSoundState("crane334_brake_slow",0,1.0)
		self:SetSoundState("crane334_release",0,1.0)
	else
		self.CraneRamp = math.Clamp(self.CraneRamp + 8.0*((1*self:GetPackedRatio("Crane_dPdT",0))-self.CraneRamp)*dT,-1,1)
		self:SetSoundState("crane334_brake",math.Clamp(((-self.CraneRamp)-0.5)/0.5,0,1),1.0)
		self:SetSoundState("crane334_brake_slow",math.Clamp((-self.CraneRamp)*2,0,1),1.0)
		self:SetSoundState("crane334_release",math.Clamp(self.CraneRamp,0,1),1.0)
	end
	local emergencyValveEPK = self:GetPackedRatio("EmergencyValveEPK_dPdT", 0)
	self.EmergencyValveEPKRamp = math.Clamp(self.EmergencyValveEPKRamp + 1.0*((0.5*emergencyValveEPK)-self.EmergencyValveEPKRamp)*dT,0,1)
	self:SetSoundState("epk_brake",self.EmergencyValveEPKRamp,1.0)
	if emergencyValveEPK > 0 and not self.EmergencyValveEPKStart then
		self:PlayOnce("epk_brake_start","bass",1,1)
		self.EmergencyValveEPKStart = true
	end
	if emergencyValveEPK <= 0 and self.EmergencyValveEPKStart then
		self.EmergencyValveEPKStart = false
	end

	local emergencyBrakeValve = self:GetPackedRatio("EmergencyBrakeValve_dPdT", 0)
	self.EmergencyBrakeValveRamp = math.Clamp(self.EmergencyBrakeValveRamp + 1.0*((0.5*emergencyBrakeValve)-self.EmergencyBrakeValveRamp)*dT,0,1)
	self:SetSoundState("valve_brake",self.EmergencyBrakeValveRamp,1.0)
	if emergencyBrakeValve > 0 and not self.EmergencyBrakeValveStart then
		self:PlayOnce("valve_brake_start","bass",1,1)
		self.EmergencyBrakeValveStart = true
	end
	if emergencyBrakeValve <= 0 and self.EmergencyBrakeValveStart then
		self.EmergencyBrakeValveStart = false
	end
	self:SetSoundState("pneumo_idle",math.min(1,self:GetPackedRatio(4)/50*(self:GetPackedBool(6) and 1 or 0)),1.0)

	local emergencyValve = self:GetPackedRatio("EmergencyValve_dPdT", 0)
	self.EmergencyValveRamp = math.Clamp(self.EmergencyValveRamp + 1.0*((0.5*emergencyValve)-self.EmergencyValveRamp)*dT,0,1)
	self:SetSoundState("emer_brake",self.EmergencyValveRamp,1.0)
	if emergencyValve > 0 and not self.EmergencyValveStart then
		self:PlayOnce("emer_brake_start","bass",1,1)
		self.EmergencyValveStart = true
	end
	if emergencyValve <= 0 and self.EmergencyValveStart then
		self.EmergencyValveStart = false
	end


	-- Compressor
	local state = self:GetPackedBool(20)
	self:SetSoundState("compressor",state and 0.6 or 0,1)
	-- ARS/ringer alert
	state = self:GetPackedBool(39)
	if state then
		self:SetSoundState("ring_old",0.05,0.75)
	else
		self:SetSoundState("ring_old",0,0)
	end

	state = self:GetPackedBool("VPR")
	if state then
		self:SetSoundState("vpr",1,1)
	else
		self:SetSoundState("vpr",0,0)
	end

	-- RK rotation
	if self:GetPackedBool(112) then self.RKTimer = CurTime() end
	state = (CurTime() - (self.RKTimer or 0)) < 0.2
	self:SetSoundState("rk",state and 0.7 or 0,1)

	local work = self:GetNW2Bool("ASNPPlay")
    local playing = self:GetNW2Bool("AnnouncerPlaying", false)
    self.NoiseVolume = self.NoiseVolume or 0
    local buzzvolume = 0
    if self.Sounds["announcer1"] and IsValid(self.Sounds["announcer1"]) then buzzvolume = (1-(self.Sounds["announcer1"]:GetLevel())*math.Rand(0.9,3))*1 end
    if self.NoiseVolume > buzzvolume then
        self.NoiseVolume = math.Clamp(self.NoiseVolume + 8*(buzzvolume-self.NoiseVolume)*dT,0.1,1)
    else
        self.NoiseVolume = math.Clamp(self.NoiseVolume + 0.5*(buzzvolume-self.NoiseVolume)*dT,0.1,1)
    end
    for k,v in ipairs(self.AnnouncerPositions) do
        local play = playing and work
        for i=1,2 do
            self:SetSoundState(Format("announcer_noise%d_%d",i,k),play and self.NoiseVolume or 0,1)
        end
	    if self.Sounds["announcer"..k] and IsValid(self.Sounds["announcer"..k]) then self.Sounds["announcer"..k]:SetVolume(play and 1 or 0) end
    end
end

function ENT:Draw()
	self.BaseClass.Draw(self)
end
function ENT:DrawPost(special)
	--local dc = render.GetLightColor(self:LocalToWorld(Vector(460.0,0.0,5.0)))

if self.InfoTableTimeout and (CurTime() < self.InfoTableTimeout) then
		self:DrawOnPanel("InfoTableSelect",function()
			local text = self:GetNW2String("FrontText","")
			local col = text:find("ЗЕЛ") and Color(100,200,0) or text:find("СИН") and Color(0,100,200) or text:find("МАЛ") and Color(200,100,200) or text:find("ОРА") and Color(200,200,0) or text:find("БИР") and Color(48,213,200) or Color(255,0,0)
			draw.DrawText(self:GetNW2String("RouteNumber","") .. " " .. text,"MetrostroiSubway_InfoPanel",260, -100,col,TEXT_ALIGN_CENTER)
		end)
	end


	self.RTMaterial:SetTexture("$basetexture", self.ASNP)
	self:DrawOnPanel("ASNPScreen",function(...)
		surface.SetMaterial(self.RTMaterial)
		surface.SetDrawColor(255,255,255)
		surface.DrawTexturedRectRotated(256,64,512,128,0)
	end)

	self.RTMaterial:SetTexture("$basetexture", self.IGLA)
	self:DrawOnPanel("IGLA",function(...)
		surface.SetMaterial(self.RTMaterial)
		surface.SetDrawColor(255,255,255)
		surface.DrawTexturedRectRotated(256,64+22,512,128+22,0)
	end)
	self:DrawOnPanel("FrontPneumatic",function()
		draw.DrawText(self:GetNW2Bool("FbI") and "Isolated" or "Open","Trebuchet24",150,30,Color(0,0,0,255))
		draw.DrawText(self:GetNW2Bool("FtI") and "Isolated" or "Open","Trebuchet24",650,30,Color(0,0,0,255))
	end)
	self:DrawOnPanel("RearPneumatic",function()
		draw.DrawText(self:GetNW2Bool("RtI") and "Isolated" or "Open","Trebuchet24",150,30,Color(0,0,0,255))
		draw.DrawText(self:GetNW2Bool("RbI") and "Isolated" or "Open","Trebuchet24",650,30,Color(0,0,0,255))
	end)
	self:DrawOnPanel("AirDistributor",function()
		draw.DrawText(self:GetNW2Bool("AD") and "Air Distributor ON" or "Air Distributor OFF","Trebuchet24",0,0,Color(0,0,0,255))
	end)
end

function ENT:OnButtonPressed(button)
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

function ENT:OnButtonPressed(button)
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

function ENT:OnPlay(soundid,location,range,pitch)
	if location == "stop" then
		if IsValid(self.Sounds[soundid]) then
			self.Sounds[soundid]:Pause()
			self.Sounds[soundid]:SetTime(0)
		end
		return
	end
	if location == "bass" then
		if soundid == "VDOL" then
			return range > 0 and "vdol_on" or "vdol_off",location,1,pitch
		end
		if soundid == "VDOP" then
			return range > 0 and "vdor_on" or "vdor_off",location,1,pitch
		end
		if soundid == "VDZ" then
			return range > 0 and "vdz_on" or "vdz_off",location,1,pitch
		end
		if soundid:sub(1,4) == "IGLA" then
			return range > 0 and "igla_on" or "igla_off",location,1,pitch
		end
		if soundid == "LK2" then
			local speed = self:GetPackedRatio("Speed")
			local id = range > 0 and "lk2_on" or "lk2_off"
			self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
			return id,location,1-Lerp(speed/10,0.2,0.8),pitch
		end
		if soundid == "LK3" then
			local speed = self:GetPackedRatio("Speed")
			local id = range > 0 and "lk3_on" or "lk3_off"
			self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
			return id,location,1-Lerp(speed/10,0.2,0.8),pitch
		end
		if soundid == "RVT" then
			return range > 0 and "rvt_on" or "rvt_off",location,1,pitch
		end
		if soundid == "R1_5" then
			return range > 0 and "r1_5_on" or "r1_5_off",location,1,pitch
		end
		if soundid == "RPB" then
			return range > 0 and "rpb_on" or "rpb_off",location,1,pitch
		end
		if soundid == "KD" then
			return range > 0 and "kd_on" or "kd_off",location,1,pitch
		end
		if soundid == "K25" then
			return range > 0 and "k25_on" or "k25_off",location,1,pitch
		end
		if soundid == "RO" then
			return range > 0 and "ro_on" or nil,location,1,pitch
		end
		if soundid == "AVU" then
			return range > 0 and "avu_on" or "avu_off",location,1,0.6
		end
	end
	return soundid,location,range,pitch
end

local dist = {
    Back1 = 550,
	AVMain = 550,
	AV1 = 550,
	AV2 = 550,
	Battery = 550,
}
for id,panel in pairs(ENT.ButtonMap) do
    if not panel.buttons then continue end
    for k,v in pairs(panel.buttons) do
        if v.model then
            local dist = dist[id] or 150
            if v.model.model then
                v.model.hideseat=dist
            elseif v.model.lamp then
                v.model.lamp.hideseat=dist
            end
        end
    end
end
Metrostroi.GenerateClientProps()

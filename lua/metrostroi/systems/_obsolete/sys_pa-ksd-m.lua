--------------------------------------------------------------------------------
-- ПА-КСД-М Поездная Аппаратура - Комплексная Система Движения - Модифицированная
-- PA-KSD-M Train Equipment - Integrated Traffic System - Modified
--------------------------------------------------------------------------------
-- Коды ошибок:
-- 0x0000 - норма
-- 0x0001 -
-- Error codes:
-- 0x0000 - Normal
-- 0x0001 - Rear PA Unit Loading
-- 0x9999 - Rear PA Unit Not Present
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PA-KSD-M")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.TriggerNames = {
		"B7",
		"B8",
		"B9",
		"BLeft",
		"BRight",
		"B4",
		"B5",
		"B6",
		"BUp",
		"B1",
		"B2",
		"B3",
		"BDown",
		"B0",
		"BMinus",
		"BPlus",
		"BEnter",
		"BEsc",
		"BF",
		"BM",
		"BP",
	}
	self.Triggers = {}
	self.Pass = "777"
	self.EnteredPass = ""
	self.Timer = CurTime()
	self.Line = 1
	self.State = 0
	self.RealState = 99
	self.RouteNumber = ""
	self.FirstStation = ""
	self.LastStation = ""
	self.AutodriveEnabled = false
	self.KSZD = false
	self.AutoTimer = false
	 self.MenuChoosed = 1
	 self.State75 = 1
	self.Corrections = {
		[110] =  1.50,
		[111] = -0.10,
		[113] = -0.05,
		--[114] = -0.05,
		[114] =  -0.25,
		[117] = -0.15,
		[118] =  1.40,
		[121] = -0.10,
		[122] = -0.10,
		[123] =  3.00,
		[322] =  3.00,
	}
end
function TRAIN_SYSTEM:ClientInitialize()
	self.STR1r = {}
	self.STR2r = {}
	self.STR1x = 1
	self.STR2x = 1
	self.Positions = {
		[-3] = "T2",
		[-2] = "T1a",
		[-1] = "T1",
		[0]  = "0",
		[1]  = "X1",
		[2]  = "X2",
		[3]  = "X3",
		--[4]  = "RR0",
		[5]  = "0ХТ",
		[6]  = "T2",
	}
	self.TypesRussian = {
		[0] = "ЭП",
		[1] = "КС",
		[2] = "ОД",
		[3] = "КВ",
		[4] = "УА",
		[5] = "ОС",
	}
	self.TypesEnglish = {
		[0] = "EP",
		[1] = "KS",
		[2] = "OD",
		[3] = "KV",
		[4] = "UA",
		[5] = "OS",
	}
	self.QuestionsRussian = {
		[01] = "Подтверди проверку наката?",
		[05] = "Подтверди движение с Vф=0?",
		[06] = {"Подтверди изменение","станции оборота"},
		[07] = {"Подтверди режим","фиксации станции"},
		[08] = {"Следи за графиком","Ты будешь виноват в задержке"},
		[11] = "Перейти в режим АВ?",
		[12] = "Перейти в режим КС?",
		[13] = "Перейти в режим ОД?",
	}
	self.QuestionsEnglish = {
		[01] = "Confirm overrun check?",
		[05] = "Confirm drive if Vf=0?",
		[06] = {"Confirm change", "station rotation"},
		[07] = {"Confirm lock", "station mode"},
		[08] = {"Mind the schedule", "Delays are your fault"},
		[11] = "Enter the AV mode?",
		[12] = "Enter the KS mode?",
		[13] = "Enter the OD mode?",
	}
	
	local translate = file.Read("metrostroi_data/language/paksdm_en.json")
	if translate then
		self.i18n = util.JSONToTable(translate)
	end
	self.T = function (source)
		if self.i18n and self.BlokEN and self.i18n[source] ~= nil then
			return self.i18n[source]
		else
			if self.i18n and self.BlokEN then print("Need translation for \""..source.."\"") end
			return source
		end
	end
	self.BlokEN=false
	self.Types=self.TypesRussian
	self.Questions=self.QuestionsRussian
	self.AutodriveEnabled = false
	self.KSZD = false
	self.AutoTimer = false
end

if TURBOSTROI then return end
function TRAIN_SYSTEM:Inputs()
	return {  "Press" }
end

if CLIENT then
	local gr_up = Material("vgui/gradient-d")
	function TRAIN_SYSTEM:PAKSDM(train)
		local Announcer = self.Train.Announcer
		surface.SetAlphaMultiplier(1)
		draw.NoTexture()
		
		if self.BlokEN ~= train:GetNW2Bool("BlokEN") then
			self.BlokEN = train:GetNW2Bool("BlokEN")
			if self.BlokEN then
				self.Types=self.TypesEnglish
				self.Questions=self.QuestionsEnglish
			else
				self.Types=self.TypesRussian
				self.Questions=self.QuestionsRussian
			end
		end
		
		if train:GetNW2Int("PAKSDM:State",-1) ~= -1 then
			surface.SetDrawColor(Color(20,20,20))
			surface.DrawRect(0,0,512,425)
		end
		if train:GetNW2Int("PAKSDM:State",-1) == -2 then
			if not self.BSODTimer then self.BSODTimer = CurTime() end
			surface.SetDrawColor(Color(0,0,172))
			surface.DrawRect(0,0,512,425)

            if  CurTime() - self.BSODTimer > 1/32*1 then draw.SimpleText("A problem has been detected and PA-KSD-M has been shut down to prevent damage","Metrostroi_PAMBSOD",5, 25,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 2/32*1 then draw.SimpleText("to your train.","Metrostroi_PAMBSOD",5, 35,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end

            if  CurTime() - self.BSODTimer > 4/32*1 then draw.SimpleText("The problem seems to be caused by the following file: CORE.SYS","Metrostroi_PAMBSOD",5, 55,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end

            if  CurTime() - self.BSODTimer > 6/32*1 then draw.SimpleText("VISITED_BY_KEK_POLICE_ERROR","Metrostroi_PAMBSOD",5, 75,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end

            if  CurTime() - self.BSODTimer > 7/32*1 then draw.SimpleText("If this is the first time you've seen this Stop error screen","Metrostroi_PAMBSOD",5, 95,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 8/32*1 then draw.SimpleText("restart your computer. If this screen appears again, follow","Metrostroi_PAMBSOD",5, 105,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 9/32*1 then draw.SimpleText("these steps:","Metrostroi_PAMBSOD",5, 115,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end

            if  CurTime() - self.BSODTimer > 11/32*1 then draw.SimpleText("Check to make sure any new hardware or software is properly installed.","Metrostroi_PAMBSOD",5, 135,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 12/32*1 then draw.SimpleText("If this is a new installation, ask your hardware or software manufacturer","Metrostroi_PAMBSOD",5, 145,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 13/32*1 then draw.SimpleText("for any Windows updates you might need.","Metrostroi_PAMBSOD",5, 155,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end

            if  CurTime() - self.BSODTimer > 15/32*1 then draw.SimpleText("If problems continue, disable or remove any newly installed hardware","Metrostroi_PAMBSOD",5, 175,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 16/32*1 then draw.SimpleText("or software. Disable BIOS memory options such as caching or shadowing.","Metrostroi_PAMBSOD",5, 185,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 17/32*1 then draw.SimpleText("If you need to use Safe Mode to remove or disable components, restart","Metrostroi_PAMBSOD",5, 195,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 18/32*1 then draw.SimpleText("your computer, press F8 to select Advanced Startup Options, and then","Metrostroi_PAMBSOD",5, 205,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 19/32*1 then draw.SimpleText("select Safe Mode.","Metrostroi_PAMBSOD",5, 215,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end

            if  CurTime() - self.BSODTimer > 21/32*1 then draw.SimpleText("Technical information:","Metrostroi_PAMBSOD",5, 235,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end

            if  CurTime() - self.BSODTimer > 22/32*1 then draw.SimpleText("*** STOP: 0x0000000A (0x0000000C, 0x00000002, 0x00000000, 3311BACE)","Metrostroi_PAMBSOD",5, 255,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end


            if  CurTime() - self.BSODTimer > 25/32*1 then draw.SimpleText("*** autodrive.sys - Address 3311BACE base at 5721DAC7, Date Stamp 533acb25","Metrostroi_PAMBSOD",5, 285,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end

            if  CurTime() - self.BSODTimer > 27/32*1 then draw.SimpleText("Beginning dump of physical memory.","Metrostroi_PAMBSOD",5, 305,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 28/32*1 then draw.SimpleText("Physical memory dump complete.","Metrostroi_PAMBSOD",5, 315,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 29/32*1 then draw.SimpleText("Contact your system administrator or technical support group for further","Metrostroi_PAMBSOD",5, 325,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 30/32*1 then draw.SimpleText("assistance.","Metrostroi_PAMBSOD",5, 335,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end

		else
			if self.BSODTimer then self.BSODTimer = nil end
		end
		if train:GetNW2Int("PAKSDM:State",-1) == 0 then
			if CurTime()%0.4 > 0.2 then draw.SimpleText("_","Metrostroi_PAM30",5, 0,Color(150,150,150,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_BOTTOM) end
		end
		if train:GetNW2Int("PAKSDM:State",-1) == 2 then
			surface.SetDrawColor(Color(0,0,255))
			surface.SetMaterial( Material("vgui/gradient_down"))
			surface.DrawTexturedRect(0,0,512,427)

			surface.SetDrawColor(Color(255,255,255))
			surface.SetMaterial( Material("vgui/gradient-d"))
			surface.DrawTexturedRect(0,200,512,50)
			surface.SetMaterial( Material("vgui/gradient-u"))
			surface.DrawTexturedRect(0,250,512,50)

			surface.SetDrawColor(Color(0,255,0))
			surface.SetMaterial( Material("vgui/gradient-d"))
			surface.DrawTexturedRect(0,200,512,227)

			draw.SimpleText(self.T("НИИ Фабрики SENT"),"Metrostroi_PAM30",256, 100,Color(0,155,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("Терминал машиниста (ПА-КСД-М)"),"Metrostroi_PAM30",256, 130,Color(0,155,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end

		if train:GetNW2Int("PAKSDM:State",-1) == 3 then
			self.ErrorCodes = {
				[0x9999] = {"",self.T("Терминал машиниста (ПА-КСД-М)")},
				[0x0001] = {"",self.T("Хвостовая ПА загружается")},
				[0x0002] = {"",self.T("Хвостовая ПА в режиме настройки")},
			}
			local ErrorCode = train:GetNW2Int("PAKSDM:ErrorCode",0)
			local BackErrorCode = train:GetNW2Int("PAKSDM:BErrorCode",0)

			surface.SetDrawColor(Color(200,200,200))
			surface.DrawRect(0,0,512,425)

			draw.SimpleText(self.T("НАЧАЛЬНЫЙ ТЕСТ ЗАКОНЧЕН"),"Metrostroi_PAM30",256, 30,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

			Metrostroi.DrawRectOutline(10, 80, 492, 210,Color(20,20,20),3 )

			surface.SetDrawColor(Color(200,200,200))
			surface.DrawRect(17,70,180,20)
			draw.SimpleText(self.T("РЕЗУЛЬТАТЫ"),"Metrostroi_PAM30",22, 80,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

			draw.SimpleText(self.T("Начальный тест"),"Metrostroi_PAM30",20, 125,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("норма"),"Metrostroi_PAM30",497, 125,Color(110,172,95),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("Начальная установка"),"Metrostroi_PAM30",20, 165,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("норма"),"Metrostroi_PAM30",497, 165,Color(110,172,95),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("Состояние \"хвостовой\" ПА"),"Metrostroi_PAM30",20, 205,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

			if not train:GetNW2Bool("PAKSDM:BackPA") or BackErrorCode == 0x9999 then
				draw.SimpleText(self.T("не норма"),"Metrostroi_PAM30",497, 205,Color(200,0,0),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			elseif BackErrorCode == 0x0001 then
				draw.SimpleText(self.T("загрузка"),"Metrostroi_PAM30",497, 205,Color(200,100,0),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			else
				draw.SimpleText(self.T("норма"),"Metrostroi_PAM30",497, 205,Color(110,172,95),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			end
			draw.SimpleText(self.T("Версия ПО БЦВМ     =     0.8"),"Metrostroi_PAM30",80, 245,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if not train:GetNW2Bool("PAKSDM:BackPA") then
				draw.SimpleText(self.T("Нет связи с хвостовым БЦВМ"),"Metrostroi_PAM30",256, 350,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			elseif BackErrorCode > 0 then
				draw.SimpleText(self.ErrorCodes[BackErrorCode] and self.ErrorCodes[BackErrorCode][2] or (self.T("Код ошибки:")..BackErrorCode),"Metrostroi_PAM30",256, 350,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			elseif not train:GetNW2Bool("PAKSDM:RR",false) then
				draw.SimpleText(self.T("ВСТАВЬТЕ РЕВЕРСИВНУЮ РУКОЯТКУ"),"Metrostroi_PAM30",256, 350,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			else
				draw.SimpleText(self.T("Для перехода в начальное меню нажмите \"Enter\""),"Metrostroi_PAM22",10, 320,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				--Metrostroi.DrawRectOL(100, 345, 75, 30,Color(20,20,20),3 ,Color(230,230,2300))
				--draw.SimpleText(self.T("нажми Enter"),"Metrostroi_PAM30",10, 360,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)T_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				Metrostroi.DrawTextRectOL(216, 340, 80, 40,Color(200,200,200),gr_up,2,Color(110,110,110))
				draw.SimpleText(self.T("Enter"),"Metrostroi_PAM30",256, 360,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			if train:GetNW2Bool("PAKSDM:BackPAErrorNoAccepted") then
				Metrostroi.DrawTextRectOL(102, 155, 308, 30,Color(42,58,148),gr_up,1,Color(110,110,110))
				Metrostroi.DrawRectOL(102, 175, 308, 86,Color(110,110,110),1,Color(200,200,200))
				draw.SimpleText(self.T("Ошибка задней ПА"),"Metrostroi_PAM25",256, 164,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				--Metrostroi.DrawRectOutline(106, 125, 300, 150,Color(20,20,20),3 )
				--surface.SetDrawColor(Color(200,200,200))
				--surface.DrawRect(108, 127, 295, 146 )
				draw.SimpleText(self.T("Задняя ПА сообщила об ошибке"),"Metrostroi_PAM22",256, 190,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				--draw.SimpleText(self.T("вводе данных"),"Metrostroi_PAM30",256, 190,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				--Metrostroi.DrawRectOutline(190, 220, 132, 40,Color(20,20,20),3 )
				--draw.SimpleText(self.T("ENTER"),"Metrostroi_PAM30",256, 240,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawTextRectOL(166, 210, 180, 40,train:GetNW2Bool("PAKSDM:NCCanc",false) and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText(self.T("Подтвердить"),"Metrostroi_PAM30",256, 230,train:GetNW2Bool("PAKSDM:NCCanc") and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

				--draw.SimpleText(self.Questions[train:GetNW2Int("PAKSDM:NeedConfirm",0)].."?","Metrostroi_PAM30",256, 180,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end

		end
		if train:GetNW2Int("PAKSDM:State",-1) == 4 then
			surface.SetDrawColor(Color(200,200,200))
			surface.DrawRect(0,0,512,425)
			--elf.Train:GetNW2Int("PAKSDM:Pass",0) ~= -1 and string.rep("*",self.Train:GetNW2Int("PAKSDM:Pass",0)) or "ACCESS ERROR"
			Metrostroi.DrawRectOutline(10, 80, 492, 170,Color(20,20,20),3 )
			if train:GetNW2Int("PAKSDM:Pass",0) == -1 then
				draw.SimpleText(self.T("ОШИБКА ДОСТУПА"),"Metrostroi_PAM30",256, 160,Color(200,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			else
				draw.SimpleText(self.T("Введи код доступа в систему"),"Metrostroi_PAM30",256, 130,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				if train:GetNW2Int("PAKSDM:Pass",0) > 0 then
					surface.SetDrawColor(Color(240,240,240))
					--surface.DrawTexturedRect(241 - train:GetNW2Int("PAKSDM:Pass",0)*12, 165, 30 + train:GetNW2Int("PAKSDM:Pass",0)*24, 40)
					Metrostroi.DrawTextRectOL(241 - train:GetNW2Int("PAKSDM:Pass",0)*12, 165, 30 + train:GetNW2Int("PAKSDM:Pass",0)*24, 40,Color(200,200,200),gr_up,2,Color(110,110,110))
					--Metrostroi.DrawRectOL(241 - train:GetNW2Int("PAKSDM:Pass",0)*12, 165, 30 + train:GetNW2Int("PAKSDM:Pass",0)*24, 40,Color(20,20,20),3,Color(230,230,2300))
					draw.SimpleText(string.rep("*",train:GetNW2Int("PAKSDM:Pass",0)),"Metrostroi_PAM80",256, 200,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				end
			end

			draw.SimpleText(self.T("Для ввода нажми \"Enter\""),"Metrostroi_PAM30",256, 300,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			Metrostroi.DrawTextRectOL(216, 320, 80, 40,Color(200,200,200),gr_up,2,Color(110,110,110))
			draw.SimpleText(self.T("Enter"),"Metrostroi_PAM30",256, 340,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		end
		if train:GetNW2Int("PAKSDM:State",-1) == 5 then
			surface.SetDrawColor(Color(200,200,200))
			surface.DrawRect(0,0,512,425)

			Metrostroi.DrawRectOutline(10, 30, 492, 333,Color(20,20,20),3)

			surface.SetDrawColor(Color(200,200,200))
			surface.DrawRect(17,15,310,30)
			draw.SimpleText(self.T("Депо. Начальное меню."),"Metrostroi_PAM30",20, 30,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			--elf.Train:GetNW2Int("PAKSDM:Pass",0) ~= -1 and string.rep("*",self.Train:GetNW2Int("PAKSDM:Pass",0)) or "ACCESS ERROR"

			Metrostroi.DrawTextRectOL(40, 140, 432, 40,train:GetNW2Int("PAKSDM:State5",1) == 1 and Color(42,58,148) or Color(230,230,230),gr_up,3,Color(110,110,110))
			draw.SimpleText("1","Metrostroi_PAM30",60, 160,train:GetNW2Int("PAKSDM:State5",1) == 1 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			Metrostroi.DrawLine(60,173,75,173,train:GetNW2Int("PAKSDM:State5",1) == 1 and Color(255,255,255) or Color(0,0,0),3)
			draw.SimpleText(self.T("Выход на линию"),"Metrostroi_PAM30",100, 160,train:GetNW2Int("PAKSDM:State5",1) == 1 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

			if train:GetNW2Bool("PAKSDM:Restart") then
				Metrostroi.DrawTextRectOL(40, 190, 432, 40,train:GetNW2Int("PAKSDM:State5",1) == 2 and Color(42,58,148) or Color(230,230,230),gr_up,3,Color(110,110,110))
				draw.SimpleText("2","Metrostroi_PAM30",60, 210,train:GetNW2Int("PAKSDM:State5",1) == 2 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				Metrostroi.DrawLine(60,222,75,222,train:GetNW2Int("PAKSDM:State5",1) == 2 and Color(255,255,255) or Color(0,0,0),3)
				draw.SimpleText(self.T("Перезапуск"),"Metrostroi_PAM30",100, 210,train:GetNW2Int("PAKSDM:State5",1) == 2 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			end

			Metrostroi.DrawTextRectOL(40, 240, 432, 40,train:GetNW2Int("PAKSDM:State5",1) == 3 and Color(42,58,148) or Color(230,230,230),gr_up,3,Color(110,110,110))
			--draw.SimpleText("1","Metrostroi_PAM30",60, 260,train:GetNW2Int("PAKSDM:State5",1) == 1 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			--Metrostroi.DrawLine(60,273,75,273,train:GetNW2Int("PAKSDM:State5",1) == 1 and Color(255,255,255) or Color(0,0,0),3)
			draw.SimpleText(self.T("Назад"),"Metrostroi_PAM30",100, 260,train:GetNW2Int("PAKSDM:State5",1) == 3 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
		end
		if train:GetNW2Int("PAKSDM:State",-1) == 6 then
			local Line = self.Train:GetNW2Int("PAKSDM:Line",0)
			local FirstStation = self.Train:GetNW2Int("PAKSDM:FirstStation",-1)
			local LastStation = self.Train:GetNW2Int("PAKSDM:LastStation",-1)
			local RouteNumber = self.Train:GetNW2Int("PAKSDM:RouteNumber",-1)
			local tbl = Metrostroi.WorkingStations
			Metrostroi.DrawTextRectOL(40, 40, 432, 30,Color(42,58,148),gr_up,1,Color(110,110,110))
			Metrostroi.DrawRectOL(40, 70, 432, 315,Color(110,110,110),1,Color(200,200,200))
			Metrostroi.DrawRectOutline(50, 90, 412, 275,Color(110,110,110),2)
			draw.SimpleText(self.T("Начальные данные"),"Metrostroi_PAM25",256, 53,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

			surface.SetDrawColor(Color(200,200,200))
			surface.DrawRect(170,80,172,20)
			draw.SimpleText(self.T("Ввод данных"),"Metrostroi_PAM30",256, 90,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("Линия"),"Metrostroi_PAM22",60, 130,Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			Metrostroi.DrawTextRectOL(310, 115, 140, 30,train:GetNW2Int("PAKSDM:State6",1) == 1 and Color(144,255,237) or Color(230,230,230),gr_up,1,Color(110,110,110))
			if Line > -1 then draw.SimpleText(Line,"Metrostroi_PAM30",380,130,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end

			draw.SimpleText(self.T("Начальная станция"),"Metrostroi_PAM22",60, 162,Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			Metrostroi.DrawTextRectOL(310, 147, 140, 30,train:GetNW2Int("PAKSDM:State6",1) == 2 and Color(144,255,237) or Color(230,230,230),gr_up,1,Color(110,110,110))
			if FirstStation > -1 then draw.SimpleText(FirstStation,"Metrostroi_PAM30",380,163,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end

			draw.SimpleText(self.T("Конечная станция"),"Metrostroi_PAM22",60, 194,Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			Metrostroi.DrawTextRectOL(310, 179, 140, 30,train:GetNW2Int("PAKSDM:State6",1) == 3 and Color(144,255,237) or Color(230,230,230),gr_up,1,Color(110,110,110))
			if LastStation > -1 then draw.SimpleText(LastStation,"Metrostroi_PAM30",380,195,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end

			draw.SimpleText(self.T("Маршрут"),"Metrostroi_PAM22",60, 226,Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			Metrostroi.DrawTextRectOL(310, 211, 140, 30,train:GetNW2Int("PAKSDM:State6",1) == 4 and Color(144,255,237) or Color(230,230,230),gr_up,1,Color(110,110,110))
			if RouteNumber > -1 then draw.SimpleText(RouteNumber,"Metrostroi_PAM30",380,225,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end


			Metrostroi.DrawTextRectOL(150, 330, 100, 30,Color(230,230,230),gr_up,1,Color(110,110,110))
			draw.SimpleText(self.T("Ввод"),"Metrostroi_PAM30",200, 344,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			Metrostroi.DrawTextRectOL(260, 330, 100, 30,Color(230,230,230),gr_up,1,Color(110,110,110))
			draw.SimpleText(self.T("Назад"),"Metrostroi_PAM30",310, 344,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			if train:GetNW2Int("PAKSDM:State6",1) == 2 and tbl[Line] then
				local i = 1
				for k,v in pairs(tbl[Line]) do
					if Metrostroi.AnnouncerData[v] and (tostring(v):find(FirstStation) or FirstStation == -1) then
						i = i + 1
						if i > 10 then break end
					end
				end
				if i > 1 then
					Metrostroi.DrawRectOL(310, 177, 200, -18 + i*18,Color(110,110,110),1,Color(250,250,250) )
					local i = 1
					for k,v in pairs(tbl[Line]) do
						if Metrostroi.AnnouncerData[v] and (tostring(v):find(FirstStation) or FirstStation == -1) then
						if i > 10 then break end
						draw.SimpleText(v,"Metrostroi_PAM1_20",311, 167+i*18,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
						draw.SimpleText(Metrostroi.AnnouncerData[v][1]:sub(1,19),"Metrostroi_PAM1_20",345, 167+i*18,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

							i = i + 1
						end
					end
					--Metrostroi.DrawLine(140, 155, 140, 145 + i*22,Color(20,20,20),3 )
				end
			end
			if train:GetNW2Int("PAKSDM:State6",1) == 3 and tbl[Line] then
				local i = 1
				for k,v in pairs(tbl[Line]) do
					if Metrostroi.AnnouncerData[v] and (tostring(v):find(LastStation) or LastStation == -1) then
						i = i + 1
						if i > 10 then break end
					end
				end
				if i > 1 then
					Metrostroi.DrawRectOL(310, 207, 200, -18 + i*18,Color(110,110,110),1,Color(250,250,250) )
					local i = 1
					for k,v in pairs(tbl[Line]) do
						if Metrostroi.AnnouncerData[v] and (tostring(v):find(LastStation) or LastStation == -1) then
							if i > 10 then break end
							draw.SimpleText(v,"Metrostroi_PAM1_20",311, 197+i*18,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
							draw.SimpleText(Metrostroi.AnnouncerData[v][1]:sub(1,19),"Metrostroi_PAM1_20",345, 197+i*18,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

							i = i + 1
						end
					end
					--Metrostroi.DrawLine(140, 155, 140, 145 + i*22,Color(20,20,20),3 )
				end
			end
			if train:GetNW2Bool("PAKSDM:State6Error",false) then
				Metrostroi.DrawTextRectOL(106, 125, 300, 30,Color(42,58,148),gr_up,1,Color(110,110,110))
				Metrostroi.DrawRectOL(106, 145, 300, 136,Color(110,110,110),1,Color(200,200,200))
				draw.SimpleText(self.T("Ошибка"),"Metrostroi_PAM25",256, 135,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				--Metrostroi.DrawRectOutline(106, 125, 300, 150,Color(20,20,20),3 )
				--surface.SetDrawColor(Color(200,200,200))
				--surface.DrawRect(108, 127, 295, 146 )
				draw.SimpleText(self.T("Ошибка при"),"Metrostroi_PAM30",256, 160,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("вводе данных"),"Metrostroi_PAM30",256, 190,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				--Metrostroi.DrawRectOutline(190, 220, 132, 40,Color(20,20,20),3 )
				--draw.SimpleText(self.T("ENTER"),"Metrostroi_PAM30",256, 240,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawTextRectOL(216, 220, 80, 40,Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText(self.T("Enter"),"Metrostroi_PAM30",256, 240,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
		end
		if train:GetNW2Int("PAKSDM:State",-1) == 7 then
			local Line = self.Train:GetNW2Int("PAKSDM:Line",0)
			local FirstStation = self.Train:GetNW2Int("PAKSDM:FirstStation",-1)
			local LastStation = self.Train:GetNW2Int("PAKSDM:LastStation",-1)
			local RouteNumber = self.Train:GetNW2Int("PAKSDM:RouteNumber",-1)
			local tbl = Metrostroi.WorkingStations
			Metrostroi.DrawTextRectOL(40, 40, 432, 30,Color(42,58,148),gr_up,1,Color(110,110,110))
			Metrostroi.DrawRectOL(40, 70, 432, 315,Color(110,110,110),1,Color(200,200,200))
			Metrostroi.DrawRectOutline(50, 90, 412, 275,Color(110,110,110),2)
			draw.SimpleText(self.T("Начальные данные"),"Metrostroi_PAM25",256, 53,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

			surface.SetDrawColor(Color(200,200,200))
			surface.DrawRect(170,80,172,20)
			draw.SimpleText(self.T("Ввод данных"),"Metrostroi_PAM30",256, 90,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("Линия"),"Metrostroi_PAM22",60, 130,Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			Metrostroi.DrawTextRectOL(310, 115, 140, 30,train:GetNW2Int("PAKSDM:State6",1) == 1 and Color(144,255,237) or Color(230,230,230),gr_up,1,Color(110,110,110))
			if Line > -1 then draw.SimpleText(Line,"Metrostroi_PAM30",380,130,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end

			draw.SimpleText(self.T("Конечная станция"),"Metrostroi_PAM22",60, 162,Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			Metrostroi.DrawTextRectOL(310, 147, 140, 30,train:GetNW2Int("PAKSDM:State6",1) == 2 and Color(144,255,237) or Color(230,230,230),gr_up,1,Color(110,110,110))
			if LastStation > -1 then draw.SimpleText(LastStation,"Metrostroi_PAM30",380,163,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end

			draw.SimpleText(self.T("Маршрут"),"Metrostroi_PAM22",60, 194,Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			Metrostroi.DrawTextRectOL(310, 179, 140, 30,train:GetNW2Int("PAKSDM:State6",1) == 3 and Color(144,255,237) or Color(230,230,230),gr_up,1,Color(110,110,110))
			if RouteNumber > -1 then draw.SimpleText(RouteNumber,"Metrostroi_PAM30",380,195,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end


			Metrostroi.DrawTextRectOL(150, 330, 100, 30,Color(230,230,230),gr_up,1,Color(110,110,110))
			draw.SimpleText(self.T("Ввод"),"Metrostroi_PAM30",200, 344,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			Metrostroi.DrawTextRectOL(260, 330, 100, 30,Color(230,230,230),gr_up,1,Color(110,110,110))
			draw.SimpleText(self.T("Назад"),"Metrostroi_PAM30",310, 344,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

			if train:GetNW2Int("PAKSDM:State6",1) == 2 and tbl[Line] then
				local i = 1
				for k,v in pairs(tbl[Line]) do
					if Metrostroi.AnnouncerData[v] and (tostring(v):find(LastStation) or LastStation == -1) then
						i = i + 1
						if i > 10 then break end
					end
				end
				if i > 1 then
					Metrostroi.DrawRectOL(310, 177, 200, -18 + i*18,Color(110,110,110),1,Color(250,250,250) )
					local i = 1
					for k,v in pairs(tbl[Line]) do
						if Metrostroi.AnnouncerData[v] and (tostring(v):find(LastStation) or LastStation == -1) then
						if i > 10 then break end
						draw.SimpleText(v,"Metrostroi_PAM1_20",311, 167+i*18,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
						draw.SimpleText(Metrostroi.AnnouncerData[v][1]:sub(1,19),"Metrostroi_PAM1_20",345, 167+i*18,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

							i = i + 1
						end
					end
					--Metrostroi.DrawLine(140, 155, 140, 145 + i*22,Color(20,20,20),3 )
				end
			end
			if train:GetNW2Bool("PAKSDM:State6Error",false) then
				Metrostroi.DrawTextRectOL(106, 125, 300, 30,Color(42,58,148),gr_up,1,Color(110,110,110))
				Metrostroi.DrawRectOL(106, 145, 300, 136,Color(110,110,110),1,Color(200,200,200))
				draw.SimpleText(self.T("Ошибка"),"Metrostroi_PAM25",256, 135,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				--Metrostroi.DrawRectOutline(106, 125, 300, 150,Color(20,20,20),3 )
				--surface.SetDrawColor(Color(200,200,200))
				--surface.DrawRect(108, 127, 295, 146 )
				draw.SimpleText(self.T("Ошибка при"),"Metrostroi_PAM30",256, 160,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("вводе данных"),"Metrostroi_PAM30",256, 190,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				--Metrostroi.DrawRectOutline(190, 220, 132, 40,Color(20,20,20),3 )
				--draw.SimpleText(self.T("ENTER"),"Metrostroi_PAM30",256, 240,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawTextRectOL(216, 220, 80, 40,Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText(self.T("Enter"),"Metrostroi_PAM30",256, 240,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
		end
		if train:GetNW2Int("PAKSDM:State",-1) == 8 then
			surface.SetDrawColor(Color(200,200,200))
			surface.DrawRect(0,0,512,425)
			draw.SimpleText(self.T("Проверка состава разрешена"),"Metrostroi_PAM1_25",256, 180,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("Для перехода в рабочий режим нажмите"),"Metrostroi_PAM1_25",256, 210,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			Metrostroi.DrawTextRectOL(216, 230, 80, 40,Color(230,230,230),gr_up,2,Color(110,110,110))
			draw.SimpleText(self.T("Enter"),"Metrostroi_PAM30",256, 250,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		end
		if train:GetNW2Int("PAKSDM:State",-1) == 9 then
			local Line = train:GetNW2Int("PAKSDM:Line",0)
			local Path = train:GetNW2Int("PAKSDM:Path",0)
			local Station = tonumber(train:GetNW2Int("PAKSDM:Station",0))
			local LastStation = tonumber(train:GetNW2Int("PAKSDM:LastStation",-1))
			local S = Format("%.2f",train:GetNW2Float("PAKSDM:Distance",0))
			local speed = math.floor(self.Train:GetPackedRatio(3)*100.0)
			local spd = self.Train:GetNW2Bool("PAKSDM:UOS", false) and 35 or self.Train:GetNW2Bool("PAKSDM:VRD",false) and 20 or self.Train:GetPackedBool(46) and 80 or self.Train:GetPackedBool(45) and 70 or self.Train:GetPackedBool(44) and 60 or self.Train:GetPackedBool(43) and 40 or self.Train:GetPackedBool(42) and 0 or "НЧ"
			--Metrostroi.DrawRectOutline(10, 6, 100, 40,Color(110,172,95),3 )
			local date = os.date("!*t",os_time)
			draw.SimpleText(Format("%02d.%02d.%04d",date.day,date.month,date.year),"Metrostroi_PAM25",59, 10,Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(Format("%02d:%02d:%02d",date.hour,date.min,date.sec),"Metrostroi_PAM25",59, 30,Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("Линия ")..Line,"Metrostroi_PAM25",150, 15,Color(254,237,142),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if Station > 0 and Metrostroi.AnnouncerData[LastStation] then
				draw.SimpleText(self.T("до ")..Metrostroi.AnnouncerData[LastStation][1],"Metrostroi_PAM20",508, 10,Color(212,212,212),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
				if Metrostroi.AnnouncerData[Station] then draw.SimpleText(Metrostroi.AnnouncerData[Station][1],"Metrostroi_PAM20",508, 30,Color(212,212,212),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER) end
			elseif  Metrostroi.AnnouncerData[LastStation] then
				draw.SimpleText(self.T("выход на линию"),"Metrostroi_PAM20",508, 13,Color(212,212,212),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
				draw.SimpleText(Metrostroi.AnnouncerData[LastStation][1],"Metrostroi_PAM20",508, 30,Color(212,212,212),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			else
				draw.SimpleText(self.T("ошибка в системе ПА"),"Metrostroi_PAM20",508, 13,Color(212,212,212),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Тек:")..Station..self.T(", Кон:")..LastStation,"Metrostroi_PAM20",508, 30,Color(212,212,212),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			end
			if Path and Path > 0 then
				draw.SimpleText(self.T("Путь ")..Path,"Metrostroi_PAM25",260, 15,Color(254,237,142),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			else
				draw.SimpleText(self.T("Путь N/A"),"Metrostroi_PAM25",260, 15,Color(254,237,142),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			end
			Metrostroi.DrawRectOutline(5, 95, 410, 30,Color(40,38,39), 5)

			surface.SetDrawColor(Color(5,30,17))
			surface.DrawRect(9,99,401,21)

			surface.SetDrawColor(Color(110,172,95))
			surface.DrawRect(9,99,401*self.Train:GetPackedRatio(3),21)

			Metrostroi.DrawLine(10 + (spd == "НЧ" and 20 or spd)*4-2, 93, 10 + (spd == "НЧ" and 20 or spd)*4-2, 125,(spd == "НЧ" and 20 or spd) > 20 and Color(254,237,142) or Color(200,0,0), 4)
			surface.SetDrawColor((spd == "НЧ" and 20 or spd) > 20 and Color(254,237,142) or  Color(200,0,0))

			draw.SimpleText((spd == "НЧ" and 20 or spd),"Metrostroi_PAM30",10 + (spd == "НЧ" and 20 or spd)*4, 135,(spd == "НЧ" and 20 or spd) > 20 and Color(254,237,142) or Color(200,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

			draw.SimpleText(speed,"Metrostroi_PAM50",480, 85,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(spd,"Metrostroi_PAM50",480, 120,(spd == "НЧ" and 20 or spd) > 20 and Color(254,237,142) or  Color(200,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

			--Metrostroi.DrawRectOutline(5, 155, 60, 30,Color(40,38,39), 1)
			--Metrostroi.DrawRectOutline(5, 185, 60, 30,Color(40,38,39), 1)
			--Metrostroi.DrawRectOutline(5, 215, 60, 30,Color(40,38,39), 1)
			--RunConsoleCommand("say",tostring(train:GetPackedBool("PAKSDM:KS")))
			draw.SimpleText(self.T("1 АВ"),"Metrostroi_PAM30",6, 170,train:GetNW2Bool("PAKSDM:AV",false) and Color(38,81,109) or Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("2 КС"),"Metrostroi_PAM30",6, 200,train:GetNW2Bool("PAKSDM:KS",false) and Color(38,81,109) or Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("3 ОС"),"Metrostroi_PAM30",6, 230,train:GetNW2Bool("PAKSDM:OD",false) and Color(38,81,109) or Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

			--Metrostroi.DrawRectOutline(429, 155, 80, 30,Color(40,38,39), 1)
			--Metrostroi.DrawRectOutline(429, 185, 80, 30,Color(40,38,39), 1)
			--Metrostroi.DrawRectOutline(429, 215, 80, 30,Color(40,38,39), 1)
			--Metrostroi.DrawRectOutline(429, 245, 80, 30,Color(40,38,39), 1)
			--Metrostroi.DrawRectOutline(429, 275, 80, 30,Color(40,38,39), 1)
			draw.SimpleText(self.T("4 СтП"),"Metrostroi_PAM30",430, 170,Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("6 Пож"),"Metrostroi_PAM30",430, 200,Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("7 Лин"),"Metrostroi_PAM30",430, 230,Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("8 Отм"),"Metrostroi_PAM30",430, 260,Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("9 ФСт"),"Metrostroi_PAM30",430, 290,Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

			Metrostroi.DrawLine(10 + (spd == "НЧ" and 20 or spd)*4, 93, 10 + (spd == "НЧ" and 20 or spd)*4, 125,(spd == "НЧ" and 20 or spd) > 20 and Color(254,237,142) or Color(200,0,0), 3)
			if train:GetNW2Bool("PAKSDM:Arrived",false) then
				draw.SimpleText(self.T("Tпр=00:00:00"),"Metrostroi_PAM28",6, 340,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Нагон="),"Metrostroi_PAM28",170, 340,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Тост = ")..math.max(-99,train:GetNW2Int("PAKSDM:BoardTime",0)),"Metrostroi_PAM28",290, 340,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("S= ")..S..self.T("м"),"Metrostroi_PAM28",506, 340,Color(110,172,95),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			else
				draw.SimpleText(self.T("РЦ= ")..train:GetNW2String("PAKSDM:SName",""),"Metrostroi_PAM30",6, 340,Color(254,237,142),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText(Format(self.T("Уклон= %.2f"),train:GetNW2Int("PAKSDM:Uklon",0)/100),"Metrostroi_PAM30",180, 340,Color(254,237,142),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("S= ")..S..self.T("м"),"Metrostroi_PAM30",506, 340,Color(110,172,95),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			end

			surface.SetDrawColor(Color(38,81,109))
			surface.DrawRect(0,360,120,52)
			draw.SimpleText(self.T("F Меню"),"Metrostroi_PAM25",70, 375,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("машиниста"),"Metrostroi_PAM25",60, 395,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			surface.DrawRect(392,360,120,52)
			draw.SimpleText(self.T("M Инж-ное"),"Metrostroi_PAM25",452, 375,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("меню"),"Metrostroi_PAM25",452, 395,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			surface.SetDrawColor(Color(180,180,180))
			surface.DrawRect(121,360,100,26)
			surface.DrawRect(222,360,57,26)
			surface.DrawRect(280,360,60,26)
			surface.DrawRect(341,360,50,26)
			draw.SimpleText(self.Types[train:GetNW2Int("PAKSDM:Type",1)].."="..self.Positions[train:GetNW2Int("PAKSDM:KV",1)],"Metrostroi_PAM30",171, 371,Color(20,20,20),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			if train:GetNW2Bool("PAKSDM:VZ1",false) or train:GetNW2Bool("PAKSDM:VZ2",false) then
				draw.SimpleText(train:GetNW2Bool("PAKSDM:VZ1",false) and (train:GetNW2Bool("PAKSDM:VZ2",false) and self.T("В1 2") or self.T("В1")) or self.T("В   2"),"Metrostroi_PAM30",224, 371,Color(20,20,20),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			end
			draw.SimpleText(self.T("ЛПТ"),"Metrostroi_PAM30",310, 371,train:GetPackedBool("PN") and Color(20,20,20) or Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			--
			draw.SimpleText(self.T("КД"),"Metrostroi_PAM30",366, 371,train:GetPackedBool(40) and Color(20,20,20) or Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			surface.DrawRect(121,387,80,26)
			surface.DrawRect(321,387,70,26)
			draw.SimpleText(self.T("АРС"),"Metrostroi_PAM30",161, 400,train:GetPackedBool(48) and Color(200,0,0) or Color(20,20,20)	,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			--[[
			surface.SetDrawColor(Color(200,200,200))
			if not train:GetNW2Bool("PAKSDM:RR",false) then
				surface.DrawRect(6,295,490,21)
				draw.SimpleText(self.T("Установи РР"),"Metrostroi_PAM30",251, 305,Color(20,20,20),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			surface.DrawRect(6,320,100,24)  surface.DrawRect(171,320,36,24) surface.DrawRect(212,320,54,24) --surface.DrawRect(266,320,40,20)
			draw.SimpleText(self.Types[train:GetNW2Bool("PAKSDM:Type",false)].."="..self.Positions[train:GetNW2Bool("PAKSDM:KV",false)],"Metrostroi_PAM30",56, 330,Color(20,20,20),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			if train:GetNW2Bool("PAKSDM:VZ1",false) or train:GetNW2Bool("PAKSDM:VZ2",false) then
				surface.DrawRect(111,320,55,24)
				draw.SimpleText(train:GetNW2Bool("PAKSDM:VZ1",false) and (train:GetNW2Bool("PAKSDM:VZ2",false) and "В12" or "В1") or "В2","Metrostroi_PAM30",111 + 55/2, 330,Color(20,20,20),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			draw.SimpleText(self.T("КД"),"Metrostroi_PAM30",171+35/2, 330,train:GetPackedBool(40) and Color(20,20,20) or Color(200,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("ЛПТ"),"Metrostroi_PAM30",239, 330,train:GetPackedBool("PN") and Color(200,0,0) or Color(20,20,20),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

			surface.DrawRect(6,355,100,21)-- surface.DrawRect(111,355,100,20) surface.DrawRect(215,355,50,20)
			draw.SimpleText(self.T("КВ АРС"),"Metrostroi_PAM30",56, 365,train:GetPackedBool(48) and Color(200,0,0) or Color(20,20,20),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			]]
			--[[
			Metrostroi.DrawRectOutline(370, 320, 130, 60,Color(110,172,95),3 )
			draw.SimpleText(self.T("Тпр. ")..(self.Train:GetPackedRatio(3)*100.0 > 0.25 and math.min(999,math.floor(S/(speed*1000/3600))) or "inf"),"Metrostroi_PAM20",375, 330,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			--draw.SimpleText(self.T("На   ="),"Metrostroi_PAM20",375, 347.5,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(self.T("Тост = ")..train:GetNW2Int("PAKSDM:BoardTime",0),"Metrostroi_PAM20",375, 365,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			]]
			if train:GetNW2Bool("PAKSDM:Arrived",false) then
				if Station > 0 then
					if Metrostroi.AnnouncerData[Station] then
						draw.SimpleText(Metrostroi.AnnouncerData[Station][1],"Metrostroi_PAM30",256, 200,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
						draw.SimpleText(Path .. self.T(" путь"),"Metrostroi_PAM30",256, 225,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					end
				end
				--draw.SimpleText(self.T("S= ")..S..self.T("м"),"Metrostroi_PAM30",256, 200,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				--draw.SimpleText(self.T("S= ")..S..self.T("м"),"Metrostroi_PAM30",256, 250,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			if train:GetNW2Int("PAKSDM:Menu",0) > 0 then
				Metrostroi.DrawRectOL(10, 140, 492, 180,Color(110,110,110),1,Color(200,200,200))
				Metrostroi.DrawTextRectOL(10, 140, 164, 45,train:GetNW2Int("PAKSDM:Menu",1) == 1 and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText("1","Metrostroi_PAM30",30, 162,train:GetNW2Int("PAKSDM:Menu",1) == 1 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Проверка"),"Metrostroi_PAM22",92, 154,train:GetNW2Int("PAKSDM:Menu",1) == 1 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("наката"),"Metrostroi_PAM22",92, 170,train:GetNW2Int("PAKSDM:Menu",1) == 1 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawTextRectOL(174, 140, 164, 45,train:GetNW2Int("PAKSDM:Menu",1) == 2 and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText("2","Metrostroi_PAM30",194, 162,train:GetNW2Int("PAKSDM:Menu",1) == 2 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Движение"),"Metrostroi_PAM22",256, 154,train:GetNW2Int("PAKSDM:Menu",1) == 2 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(train:GetNW2Bool("PAKSDM:KD") and self.T("с КД") or self.T("без КД"),"Metrostroi_PAM22",256, 170,train:GetNW2Int("PAKSDM:Menu",1) == 2 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawTextRectOL(338, 140, 164, 45,train:GetNW2Int("PAKSDM:Menu",1) == 3 and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText("3","Metrostroi_PAM30",358, 162,train:GetNW2Int("PAKSDM:Menu",1) == 3 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Смена"),"Metrostroi_PAM22",420, 154,train:GetNW2Int("PAKSDM:Menu",1) == 3 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("настроек"),"Metrostroi_PAM22",420, 170,train:GetNW2Int("PAKSDM:Menu",1) == 3 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

				Metrostroi.DrawTextRectOL(10, 185, 164, 45,train:GetNW2Int("PAKSDM:Menu",1) == 4 and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText("4","Metrostroi_PAM30",30, 207,train:GetNW2Int("PAKSDM:Menu",1) == 4 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Движение"),"Metrostroi_PAM22",92, 199,train:GetNW2Int("PAKSDM:Menu",1) == 4 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("транзитом"),"Metrostroi_PAM22",92, 215,train:GetNW2Int("PAKSDM:Menu",1) == 4 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawTextRectOL(174, 185, 164, 45,train:GetNW2Int("PAKSDM:Menu",1) == 5 and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText("5","Metrostroi_PAM30",194, 207,train:GetNW2Int("PAKSDM:Menu",1) == 5 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Движение"),"Metrostroi_PAM22",256, 199,train:GetNW2Int("PAKSDM:Menu",1) == 5 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("при Vф=0"),"Metrostroi_PAM22",256, 215,train:GetNW2Int("PAKSDM:Menu",1) == 5 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawTextRectOL(338, 185, 164, 45,train:GetNW2Int("PAKSDM:Menu",1) == 6 and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText("6","Metrostroi_PAM30",358, 207,train:GetNW2Int("PAKSDM:Menu",1) == 6 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Зонный"),"Metrostroi_PAM22",420, 199,train:GetNW2Int("PAKSDM:Menu",1) == 6 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("оборот"),"Metrostroi_PAM22",420, 215,train:GetNW2Int("PAKSDM:Menu",1) == 6 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

				Metrostroi.DrawTextRectOL(10, 230, 164, 45,train:GetNW2Int("PAKSDM:Menu",1) ==7 and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText("7","Metrostroi_PAM30",30, 252,train:GetNW2Int("PAKSDM:Menu",1) == 7 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Фиксация"),"Metrostroi_PAM22",92, 244,train:GetNW2Int("PAKSDM:Menu",1) == 7 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("станции"),"Metrostroi_PAM22",92, 260,train:GetNW2Int("PAKSDM:Menu",1) == 7 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

				Metrostroi.DrawTextRectOL(174, 230, 164, 45,train:GetNW2Int("PAKSDM:Menu",1) ==8 and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText("8","Metrostroi_PAM30",194, 252,train:GetNW2Int("PAKSDM:Menu",1) == 8 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("ИГРУФКИ"),"Metrostroi_PAM22",256, 252,train:GetNW2Int("PAKSDM:Menu",1) == 8 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				--draw.SimpleText(train:GetNW2Bool("PAKSDM:KD") and self.T("с КД") or self.T("без КД"),"Metrostroi_PAM22",256, 170,train:GetNW2Int("PAKSDM:Menu",1) == 1 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			--[[
				Metrostroi.DrawTextRectOL(338, 230, 164, 45,Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText("9","Metrostroi_PAM30",358, 162,train:GetNW2Int("PAKSDM:Menu",1) == 1 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Смена"),"Metrostroi_PAM22",420, 154,train:GetNW2Int("PAKSDM:Menu",1) == 1 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("настроек"),"Metrostroi_PAM22",420, 170,train:GetNW2Int("PAKSDM:Menu",1) == 1 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

				Metrostroi.DrawTextRectOL(10, 275, 164, 45,Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText("1","Metrostroi_PAM30",30, 162,train:GetNW2Int("PAKSDM:Menu",1) == 1 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Проверка"),"Metrostroi_PAM22",92, 154,train:GetNW2Int("PAKSDM:Menu",1) == 1 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("наката"),"Metrostroi_PAM22",92, 170,train:GetNW2Int("PAKSDM:Menu",1) == 1 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawTextRectOL(174, 230, 164, 45,Color(230,230,230),gr_up,2,Color(110,110,110))
				]]
				Metrostroi.DrawTextRectOL(338, 275, 164, 45,train:GetNW2Int("PAKSDM:Menu",1) == 12 and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText(self.T("Закрыть"),"Metrostroi_PAM22",420, 297,train:GetNW2Int("PAKSDM:Menu",1) == 12 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				--[[
				Metrostroi.DrawRectOutline(50, 150, 385, 24*8,Color(160,160,160), 3)
				surface.SetDrawColor(Color(200,200,200))
				surface.DrawRect(51,151,382,24*8-4)
				surface.SetDrawColor(Color(200,200,200))
				surface.DrawRect(51,127 + train:GetNW2Int("PAKSDM:Menu",0)*24,382,23)

				for i = 1,7 do
					Metrostroi.DrawLine(50,150+24*i,435,150+24*i,Color(160,160,160),3)
				end
				draw.SimpleText(self.T("Проверка наката"),"Metrostroi_PAM22",256, 162,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(train:GetNW2Bool("PAKSDM:KD") and self.T("Движение с КД") or self.T("Движение без КД"),"Metrostroi_PAM22",256, 186,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Смена настроек"),"Metrostroi_PAM22",256, 210,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Движение транзитом"),"Metrostroi_PAM22",256, 234,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Движение с  Vд = 0"),"Metrostroi_PAM22",256, 258,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Зонный оборот"),"Metrostroi_PAM22",256, 282,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Фиксация станции"),"Metrostroi_PAM22",256, 306,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Station mode"),"Metrostroi_PAM22",256, 330,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				]]
			end
			if train:GetNW2Int("PAKSDM:Ann",0) > 0 then
				Metrostroi.DrawRectOL(10, 140, 492, 180,Color(110,110,110),1,Color(200,200,200))
				Metrostroi.DrawTextRectOL(10, 140, 164, 45,train:GetNW2Int("PAKSDM:Ann",1) == 1 and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText("1","Metrostroi_PAM30",30, 162,train:GetNW2Int("PAKSDM:Ann",1) == 1 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Просьба"),"Metrostroi_PAM22",92, 150,train:GetNW2Int("PAKSDM:Ann",1) == 1 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("выйти"),"Metrostroi_PAM22",92, 162,train:GetNW2Int("PAKSDM:Ann",1) == 1 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("из вагонов"),"Metrostroi_PAM22",92, 174,train:GetNW2Int("PAKSDM:Ann",1) == 1 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawTextRectOL(174, 140, 164, 45,train:GetNW2Int("PAKSDM:Ann",1) == 2 and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText("2","Metrostroi_PAM30",194, 162,train:GetNW2Int("PAKSDM:Ann",1) == 2 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Заходите"),"Metrostroi_PAM22",266, 150,train:GetNW2Int("PAKSDM:Ann",1) == 2 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("и выходите"),"Metrostroi_PAM22",266, 162,train:GetNW2Int("PAKSDM:Ann",1) == 2 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("быстрее"),"Metrostroi_PAM22",266, 174,train:GetNW2Int("PAKSDM:Ann",1) == 2 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawTextRectOL(338, 140, 164, 45,train:GetNW2Int("PAKSDM:Ann",1) == 3 and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText("3","Metrostroi_PAM30",358, 162,train:GetNW2Int("PAKSDM:Ann",1) == 3 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Отпустите"),"Metrostroi_PAM22",440, 150,train:GetNW2Int("PAKSDM:Ann",1) == 3 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("пожалуйста"),"Metrostroi_PAM22",440, 162,train:GetNW2Int("PAKSDM:Ann",1) == 3 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("двери"),"Metrostroi_PAM22",440, 174,train:GetNW2Int("PAKSDM:Ann",1) == 3 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

				Metrostroi.DrawTextRectOL(10, 185, 164, 45,train:GetNW2Int("PAKSDM:Ann",1) == 4 and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText("4","Metrostroi_PAM30",30, 207,train:GetNW2Int("PAKSDM:Ann",1) == 4 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Поезд"),"Metrostroi_PAM22",92, 195,train:GetNW2Int("PAKSDM:Ann",1) == 4 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("скоро"),"Metrostroi_PAM22",92, 207,train:GetNW2Int("PAKSDM:Ann",1) == 4 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("отправится"),"Metrostroi_PAM22",92, 219,train:GetNW2Int("PAKSDM:Ann",1) == 4 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

				Metrostroi.DrawTextRectOL(338, 275, 164, 45,train:GetNW2Int("PAKSDM:Ann",1) == 5 and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText(self.T("Закрыть"),"Metrostroi_PAM22",420, 297,train:GetNW2Int("PAKSDM:Ann",1) == 5 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			if train:GetNW2Int("PAKSDM:NeedConfirm",0) > 0 then
				Metrostroi.DrawTextRectOL(106, 155, 300, 30,Color(42,58,148),gr_up,1,Color(110,110,110))
				Metrostroi.DrawRectOL(106, 175, 300, 86,Color(110,110,110),1,Color(200,200,200))
				draw.SimpleText(self.T("Подтверждение"),"Metrostroi_PAM25",256, 164,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				--Metrostroi.DrawRectOutline(106, 125, 300, 150,Color(20,20,20),3 )
				--surface.SetDrawColor(Color(200,200,200))
				--surface.DrawRect(108, 127, 295, 146 )
				if type(self.Questions[train:GetNW2Int("PAKSDM:NeedConfirm",0)]) == "table" then
					draw.SimpleText(self.Questions[train:GetNW2Int("PAKSDM:NeedConfirm",0)][1],"Metrostroi_PAM22",256, 182,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					draw.SimpleText(self.Questions[train:GetNW2Int("PAKSDM:NeedConfirm",0)][2],"Metrostroi_PAM22",256, 198,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				else
					draw.SimpleText(self.Questions[train:GetNW2Int("PAKSDM:NeedConfirm",0)],"Metrostroi_PAM22",256, 190,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				end
				--draw.SimpleText(self.T("вводе данных"),"Metrostroi_PAM30",256, 190,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				--Metrostroi.DrawRectOutline(190, 220, 132, 40,Color(20,20,20),3 )
				--draw.SimpleText(self.T("ENTER"),"Metrostroi_PAM30",256, 240,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawTextRectOL(111, 210, 140, 40,train:GetNW2Bool("PAKSDM:NCOk",false) and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText(self.T("Да - Enter"),"Metrostroi_PAM30",181, 230,train:GetNW2Bool("PAKSDM:NCOk",false) and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawTextRectOL(261, 210, 140, 40,train:GetNW2Bool("PAKSDM:NCCanc",false) and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText(self.T("Нет - Esc"),"Metrostroi_PAM30",331, 230,train:GetNW2Bool("PAKSDM:NCCanc") and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

				--draw.SimpleText(self.Questions[train:GetNW2Int("PAKSDM:NeedConfirm",0)].."?","Metrostroi_PAM30",256, 180,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			if train:GetNW2Bool("PAKSDM:Nakat") then
				Metrostroi.DrawTextRectOL(106, 155, 300, 30,Color(42,58,148),gr_up,1,Color(110,110,110))
				Metrostroi.DrawRectOL(106, 175, 300, 100,Color(110,110,110),1,Color(200,200,200))
				draw.SimpleText(self.T("Проверка наката"),"Metrostroi_PAM25",256, 164,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Расстояние: "),"Metrostroi_PAM30",111, 195,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText(Format("%.2f",self.Train:GetNW2Float("PAKSDM:Meters",0)),"Metrostroi_PAM30",300, 195,Color(254,237,142),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Направление: "),"Metrostroi_PAM30",111, 225,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.Train:GetNW2Bool("PAKSDM:Sign",false) and self.T("Назад") or self.T("Вперёд"),"Metrostroi_PAM30",300, 225,self.Train:GetNW2Bool("PAKSDM:Sign",false) and Color(200,0,0) or Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				Metrostroi.DrawTextRectOL(190-20, 240, 132+40, 30,train:GetNW2Bool("PAKSDM:NCCanc",false) and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText(self.T("Отмена - Esc"),"Metrostroi_PAM30",256, 255,train:GetNW2Bool("PAKSDM:NCCanc",false) and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			if train:GetNW2Bool("PAKSDM:SetupError",false) then
				Metrostroi.DrawTextRectOL(106, 125, 300, 30,Color(42,58,148),gr_up,1,Color(110,110,110))
				Metrostroi.DrawRectOL(106, 145, 300, 136,Color(110,110,110),1,Color(200,200,200))
				draw.SimpleText(self.T("Критическая ошибка"),"Metrostroi_PAM25",256, 135,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				--Metrostroi.DrawRectOutline(106, 125, 300, 150,Color(20,20,20),3 )
				--surface.SetDrawColor(Color(200,200,200))
				--surface.DrawRect(108, 127, 295, 146 )
				draw.SimpleText(self.T("Неообходимо"),"Metrostroi_PAM30",256, 160,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("уточнение"),"Metrostroi_PAM30",256, 180,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("данных"),"Metrostroi_PAM30",256, 200,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				--Metrostroi.DrawRectOutline(190, 220, 132, 40,Color(20,20,20),3 )
				--draw.SimpleText(self.T("ENTER"),"Metrostroi_PAM30",256, 240,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawTextRectOL(216, 220, 80, 40,Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText(self.T("Enter"),"Metrostroi_PAM30",256, 240,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end

			if train:GetNW2Int("PAKSDM:Fix",-1) > -1 or train:GetNW2Int("PAKSDM:Zon",-1) > -1 then
				local Line = train:GetNW2Int("PAKSDM:FLine",0)
				local Station = train:GetNW2Int("PAKSDM:FStation",0)
				local choosed = train:GetNW2Int("PAKSDM:Fix",-1) > -1 and train:GetNW2Int("PAKSDM:Fix",0) or train:GetNW2Int("PAKSDM:Zon",0)
				Metrostroi.DrawTextRectOL(40, 140, 432, 30,Color(42,58,148),gr_up,1,Color(110,110,110))
				Metrostroi.DrawRectOL(40, 170, 432, 160,Color(110,110,110),1,Color(200,200,200))
				draw.SimpleText(train:GetNW2Int("PAKSDM:Fix",-1) > -1 and self.T("Фиксация станции") or self.T("Зонный оборот"),"Metrostroi_PAM25",256, 153,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

				surface.SetDrawColor(Color(200,200,200))
				surface.DrawRect(170,180,172,20)
				draw.SimpleText(self.T("Ввод данных"),"Metrostroi_PAM30",256, 190,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.T("Линия"),"Metrostroi_PAM22",60, 220,Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				Metrostroi.DrawTextRectOL(280, 215, 170, 20,choosed == 0 and Color(144,255,237) or Color(230,230,230),gr_up,1,Color(110,110,110))
				if Line > -1 then draw.SimpleText(Line,"Metrostroi_PAM1_25",365,225,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end

				draw.SimpleText(self.T("Код станции"),"Metrostroi_PAM22",60, 243,Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				Metrostroi.DrawTextRectOL(280, 237, 170, 20,choosed == 1 and Color(144,255,237) or Color(230,230,230),gr_up,1,Color(110,110,110))

				local tbl = Metrostroi.WorkingStations
				if Station > -1 then
					draw.SimpleText(Station,"Metrostroi_PAM22",365,247,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					if tbl[Line] and tbl[Line][Station] and Metrostroi.AnnouncerData[Station] then
						draw.SimpleText(Metrostroi.AnnouncerData[Station][1],"Metrostroi_PAM22",256,270,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					end
				end
				Metrostroi.DrawTextRectOL(100, 286, 100, 30,train:GetNW2Bool("PAKSDM:NCOk",false) and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText(self.T("Ввод"),"Metrostroi_PAM30",150, 300,train:GetNW2Bool("PAKSDM:NCOk",false) and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawTextRectOL(294, 286, 115, 30,train:GetNW2Bool("PAKSDM:NCCanc",false) and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
				draw.SimpleText(self.T("Закрыть"),"Metrostroi_PAM30",349, 300,train:GetNW2Bool("PAKSDM:NCCanc",false) and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				if choosed == 1 and tbl[Line] and not Metrostroi.AnnouncerData[Station] then
					local i = 1
					for k,v in pairs(tbl[Line]) do
						if Metrostroi.AnnouncerData[v] and (tostring(v):find(Station) or Station == -1) then
							i = i + 1
							if i > 8 then break end
						end
					end
					if i > 1 then
						Metrostroi.DrawRectOL(280, 257, 200, -18 + i*18,Color(110,110,110),1,Color(250,250,250) )
						local i = 1
						for k,v in pairs(tbl[Line]) do
							if Metrostroi.AnnouncerData[v] and (tostring(v):find(Station) or Station == -1) then
							if i > 8 then break end
							draw.SimpleText(v,"Metrostroi_PAM1_20",281, 247+i*18,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
							draw.SimpleText(Metrostroi.AnnouncerData[v][1]:sub(1,19),"Metrostroi_PAM1_20",315, 247+i*18,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

								i = i + 1
							end
						end
						--Metrostroi.DrawLine(140, 155, 140, 145 + i*22,Color(20,20,20),3 )
					end
				end
				if train:GetNW2Bool("PAKSDM:State6Error",false) then
					Metrostroi.DrawTextRectOL(106, 125, 300, 30,Color(42,58,148),gr_up,1,Color(110,110,110))
					Metrostroi.DrawRectOL(106, 145, 300, 136,Color(110,110,110),1,Color(200,200,200))
					draw.SimpleText(self.T("Ошибка"),"Metrostroi_PAM25",256, 135,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					--Metrostroi.DrawRectOutline(106, 125, 300, 150,Color(20,20,20),3 )
					--surface.SetDrawColor(Color(200,200,200))
					--surface.DrawRect(108, 127, 295, 146 )
					draw.SimpleText(self.T("Ошибка при"),"Metrostroi_PAM30",256, 160,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					draw.SimpleText(self.T("вводе данных"),"Metrostroi_PAM30",256, 190,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					--Metrostroi.DrawRectOutline(190, 220, 132, 40,Color(20,20,20),3 )
					--draw.SimpleText(self.T("ENTER"),"Metrostroi_PAM30",256, 240,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					Metrostroi.DrawTextRectOL(216, 220, 80, 40,Color(230,230,230),gr_up,2,Color(110,110,110))
					draw.SimpleText(self.T("Enter"),"Metrostroi_PAM30",256, 240,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				end
			end
		end
		if train:GetNW2Bool("PAKSDM:2048") then
			Metrostroi.DrawTextRectOL(156, 100, 200, 30,Color(42,58,148),gr_up,1,Color(110,110,110))
			Metrostroi.DrawRectOL(156, 130, 200, 200,Color(110,110,110),1,Color(200,200,200))
			draw.SimpleText(self.T("2048 Счёт:")..train:GetNW2Int("PAKSDM:2048Score",0),"Metrostroi_PAM25",166, 113,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			self.g2048col = {
				Color(238,228,218),
				Color(236,224,200),
				Color(242,177,121),
				Color(245,149,99),
				Color(245,124,95),
				Color(246,93,59),
				Color(237,206,113),
				Color(237,204,97),
				Color(236,200,80),
				Color(237,197,63),
				Color(238,194,46),
			}
			for i = 0,15 do
				local val = train:GetNW2Int("PAKSDM:2048:"..math.floor(i/4+1)..":"..(i%4+1),0)
				if val ~= 0 then
					surface.SetDrawColor(self.g2048col[val] or Color(174,8,12))
					surface.DrawRect(156 + (i%4)*50,130 + math.floor(i/4)*50,50,50)
					draw.SimpleText(2^val,val < 10 and "Metrostroi_PAM25" or i < 13 and "Metrostroi_PAM22" or "Metrostroi_PAM20",181 + (i%4)*50, 155 + math.floor(i/4)*50,val > 2 and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				end
			end
			Metrostroi.DrawLine(156,180,356,180,Color(110,110,110),2)
			Metrostroi.DrawLine(156,230,356,230,Color(110,110,110),2)
			Metrostroi.DrawLine(156,280,356,280,Color(110,110,110),2)

			Metrostroi.DrawLine(206,130,206,330,Color(110,110,110),2)
			Metrostroi.DrawLine(256,130,256,330,Color(110,110,110),2)
			Metrostroi.DrawLine(306,130,306,330,Color(110,110,110),2)
			Metrostroi.DrawTextRectOL(156, 330, 200, 40,train:GetNW2Bool("PAKSDM:NCCanc") and Color(42,58,148) or Color(230,230,230),gr_up,2,Color(110,110,110))
			draw.SimpleText(self.T("Выход - Esc"),"Metrostroi_PAM30",256, 350,train:GetNW2Bool("PAKSDM:NCCanc") and Color(255,255,255) or Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
		surface.SetAlphaMultiplier(1-train:GetNW2Float("Motorola:Bright",1)*0.5)
		surface.SetDrawColor(Color(20,20,20))
		surface.DrawRect(0,0,512,512)
		surface.SetAlphaMultiplier(1)
	end
	function TRAIN_SYSTEM:ClientThink()
	end
end

function TRAIN_SYSTEM:FindAimButton(x,y,x1,y1,w,h)
	if x < x1 or x > x1+w then return false end
	if y < y1 or y > y1+h then return false end
	return true
end
function TRAIN_SYSTEM:UpdateUPO()
	for k,v in pairs(self.Train.WagonList) do
		if v.UPO then v.UPO:SetStations(self.Line,self.FirstStation,self.LastStation,v == self.Train) end
		v:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
	end
end
function TRAIN_SYSTEM:Touch(state,x,y)
	local Announcer = self.Train.Announcer
	if self.g2048 and self:FindAimButton(x,y,156, 330, 200, 40) then
		self.NCCanc = state
		if not state then
			self.g2048 = nil
		end
	end
	if self.State == 3 and self.BackPAEA  and self:FindAimButton(x,y,166, 210, 180, 40) then
		self.BackPAEA = nil
		return
	end
	if self.State == 3 and not self.BackPAEA and self.Train.KV.ReverserPosition ~= 0 and self.BackPA and not self.BackErrorCode and not self.ErrorCode and self:FindAimButton(x,y,216, 340, 80, 40) then
		self:SetState(1.1,(self.FirstStation ~= "" and self.LastStation ~= "") and 5 or 4)
		return
	end
	if self.State == 4 and self:FindAimButton(x,y,216, 320, 80, 40) then
		if self.EnteredPass == "31173" then
			self:SetState(1.1,-2)
			return
		elseif self.Pass ~= self.EnteredPass then
			self.EnteredPass = "/"
		else
			self:SetState(1.1,5)
			return
		end
	end
	if self.State == 5 and self:FindAimButton(x,y,40, 140, 432, 40) then
		if state then
			self.State5Choose = 1
		else
			self:SetState(1.1,6)
		end
	end
	if self.State == 5 and self.Train:GetNW2Bool("PAKSDM:Restart") and self:FindAimButton(x,y,40, 190, 432, 40) then
		if state then
			self.State5Choose = 2
		else
			self:SetState(1.1,7)
		end
	end
	if self.State == 5 and self:FindAimButton(x,y,40, 230, 432, 40) then
		if state then
			self.State5Choose = 3
		else
			self:SetState(1.1,3)
		end
	end
	if self.State == 6 and not self.State6Error and self:FindAimButton(x,y,150, 330, 100, 30) then
		if not Metrostroi.WorkingStations[self.Line] or
			not Metrostroi.WorkingStations[self.Line][tonumber(self.FirstStation)] or
			not Metrostroi.AnnouncerData[tonumber(self.FirstStation)] or
			not Metrostroi.WorkingStations[self.Line][tonumber(self.LastStation)] or
			not Metrostroi.AnnouncerData[tonumber(self.LastStation)] or
			#self.RouteNumber < 3 or self.LastStation == self.FirstStation then
			self.State6Error = not self.State6Error
		else
			self:SetState(1.1,8)
		end
	end
	if self.State == 6 and not self.State6Error and self:FindAimButton(x,y,260, 330, 100, 30) then
		self:SetState(1.1,5)
	end
	if self.State == 6 and self.State6Error and self:FindAimButton(x,y,216, 220, 80, 40) then
		self.State6Error = false
	end
	if self.State == 7 and not self.State6Error and self:FindAimButton(x,y,150, 330, 100, 30) then
		if not Metrostroi.WorkingStations[self.Line] or
			not Metrostroi.WorkingStations[self.Line][tonumber(self.FirstStation)] or
			not Metrostroi.AnnouncerData[tonumber(self.FirstStation)] or
			not Metrostroi.WorkingStations[self.Line][tonumber(self.LastStation)] or
			not Metrostroi.AnnouncerData[tonumber(self.LastStation)] or
			#self.RouteNumber < 3 or self.LastStation == self.FirstStation then
			self.State6Error = not self.State6Error
		else
			self:SetState(1.1,9)
		end
	end
	if self.State == 7 and not self.State6Error and self:FindAimButton(x,y,260, 330, 100, 30) then
		self:SetState(1.1,5)
	end
	if self.State == 7 and self.State6Error and self:FindAimButton(x,y,216, 220, 80, 40) then
		self.State6Error = false
	end
	if self.State == 8 and self.Check == false and self:FindAimButton(x,y,216, 240, 80, 40) then
		self:SetState(1.1,9)
	end
	if self.State == 9 then
		if self.Train:GetNW2Bool("PAKSDM:SetupError",false) then
			if self:FindAimButton(x,y,216, 220, 80, 40) then
				for k,v in pairs(self.Train.WagonList) do
					v["PA-KSD-M"]:SetState(3)
				end
			end
			return
		end
		if self.Nakat and self:FindAimButton(x,y,106, 175, 300, 100) then
			self.NCCanc = state
			if not state then
				self.Nakat = false
				if self.Train:ReadTrainWire(1) < 1 then
					self.Train.ALS_ARS.Nakat = false
				end
			end
		end
		if not self.NeedConfirm or self.NeedConfirm == 0 then
			if self.Zon or self.Fix then
				if self.Fix then
					if self:FindAimButton(x,y,294, 286, 115, 30) then
						self.NCCanc = state
						if not state then self.Fix = nil end
					end
					if self:FindAimButton(x,y,100, 286, 100, 30) then
						self.NCOk = state
						if not state then
							if not Metrostroi.WorkingStations[self.FLine] or
								not Metrostroi.WorkingStations[self.FLine][tonumber(self.EnteredStation)] or
								not Metrostroi.AnnouncerData[tonumber(self.EnteredStation)] or tonumber(self.EnteredStation) == self.FirstStation then
								self.State6Error = not self.State6Error
							else
								self.FirstStation = self.EnteredStation
								self.Line = self.FLine
								self.Fix = nil
								self:UpdateUPO()
							end
						end
					end
				else
					if self:FindAimButton(x,y,294, 286, 115, 30) then
						self.NCCanc = state
						if not state then self.Zon = nil end
					end
					if self:FindAimButton(x,y,100, 286, 100, 30) then
						self.NCOk = state
						if not state then
							if not Metrostroi.WorkingStations[self.FLine] or
								not Metrostroi.WorkingStations[self.FLine][tonumber(self.EnteredStation)] or
								not Metrostroi.AnnouncerData[tonumber(self.EnteredStation)] then
								self.State6Error = not self.State6Error
							else
								self.LastStation = self.EnteredStation
								self:UpdateUPO()
								self.Zon = nil
							end
						end
					end
				end
				if self.State6Error and self:FindAimButton(x,y,216, 220, 80, 40) then
					self.State6Error = false
				end
				return
			elseif self.MenuChoosed == 0 and self.AnnChoosed == 0 then
				if self:FindAimButton(x,y,0,360,120,52) then
					self.MenuChoosed = 1
				end
				if not self.AutodriveWorking and self.Train.ALS_ARS["33G"] < 0.5  and self:FindAimButton(x,y,5,155,60,30) then
					self.NeedConfirm = 11
				end
				if (self.AutodriveWorking or self.VRD or self.UOS) and not self.Trainsit and self:FindAimButton(x,y,5,185,60,30) then
					self.NeedConfirm = 12
				end
				if not self.UOS and not self.Train.ALS_ARS.EnableARS and self:FindAimButton(x,y,5,215,60,30) then
					self.NeedConfirm = 13
				end
				if self:FindAimButton(x,y,429, 275, 80, 30) then
					self.NeedConfirm = 7
				end
			elseif self.AnnChoosed == 0 then
				if self:FindAimButton(x,y,10, 140, 164, 45) then
					if state then
						self.MenuChoosed = 1
					else
						if self.MenuChoosed == 1 and self.Train.Speed < 0.5 then
							self.NeedConfirm = 1
						else
							self.MenuChoosed = 0
						end
					end
				end
				if self:FindAimButton(x,y,174, 140, 164, 45) then
					if state then
						self.MenuChoosed = 2
					else
						self.KD = not self.KD
						self.MenuChoosed = 0
					end
				end
				if self:FindAimButton(x,y,338, 140, 164, 45) then
					if state then
						self.MenuChoosed = 3
					else
						for k,v in pairs(self.Train.WagonList) do
							v["PA-KSD-M"]:SetState(3)
						end
						self.MenuChoosed = 0
					end
				end

				if self:FindAimButton(x,y,10, 185, 164, 45) then
					if state then
						self.MenuChoosed = 4
					else
						self.Transit = not self.Transit
						self.AutodriveWorking = false
						self.MenuChoosed = 0
					end
				end
				if self:FindAimButton(x,y,174, 185, 164, 45) and not (self.VRD or not (self.Train.ALS_ARS.Signal0 and not self.Train.ALS_ARS.RealNoFreq and not self.Train.ALS_ARS.Signal40 and not self.Train.ALS_ARS.Signal60 and not self.Train.ALS_ARS.Signal70 and not self.Train.ALS_ARS.Signal80))then
					if state then
						self.MenuChoosed = 5
					else
						self.NeedConfirm = 5
						--self.MenuChoosed = 0
					end
				end
				if self:FindAimButton(x,y,338, 185, 164, 45) then
					if state then
						self.MenuChoosed = 6
					else
						self.NeedConfirm = 6
						--self.MenuChoosed = 0
					end
				end

				if self:FindAimButton(x,y,10, 230, 164, 45) then
					if state then
						self.MenuChoosed = 7
					else
						self.NeedConfirm = 7
						--self.MenuChoosed = 0
					end
				end
				if self:FindAimButton(x,y,174, 230, 164, 45) then
					if state then
						self.MenuChoosed = 8
					else
						self.NeedConfirm = 8
						--self.MenuChoosed = 0
					end
				end

				if self:FindAimButton(x,y,338, 275, 164, 45) then
					if state then
						self.MenuChoosed = 12
					else
						self.MenuChoosed = 0
					end
				end
			else
				if self:FindAimButton(x,y,10, 140, 164, 45) then
					if state then
						self.AnnChoosed = 1
					else
						self.Train.UPO:II(self.AnnChoosed)
						self.AnnChoosed = 0
					end
				end
				if self:FindAimButton(x,y,174, 140, 164, 45) then
					if state then
						self.AnnChoosed = 2
					else
						self.Train.UPO:II(self.AnnChoosed)
						self.AnnChoosed = 0
					end
				end
				if self:FindAimButton(x,y,338, 140, 164, 45) then
					if state then
						self.AnnChoosed = 3
					else
						self.Train.UPO:II(self.AnnChoosed)
						self.AnnChoosed = 0
					end
				end
				if self:FindAimButton(x,y,10, 185, 164, 45) then
					if state then
						self.AnnChoosed = 4
					else
						self.Train.UPO:II(self.AnnChoosed)
						self.AnnChoosed = 0
					end
				end
				if self:FindAimButton(x,y,338, 275, 164, 45) then
					if state then
						self.AnnChoosed = 5
					else
						self.AnnChoosed = 0
					end
				end
			end
		else
			if self:FindAimButton(x,y,111, 210, 140, 40) then
				self.NCOk = state
				if not state then
					if self.NeedConfirm == 1 and self.Train.Speed < 0.5 then
						self.Nakat = true
					end
					if (self.Train.ALS_ARS.Signal0 and not self.Train.ALS_ARS.RealNoFreq and not self.Train.ALS_ARS.Signal40 and not self.Train.ALS_ARS.Signal60 and not self.Train.ALS_ARS.Signal70 and not self.Train.ALS_ARS.Signal80) then
						self.VRD = true
					end
					if self.NeedConfirm == 6 then
						self.Zon = 1
						self.EnteredStation = ""
						self.FLine = self.Line
						self.State6Error = false
					end
					if self.NeedConfirm == 7 then
						self.Fix = 0
						self.EnteredStation = ""
						self.FLine = nil
						self.State6Error = false
					end
					if self.NeedConfirm == 8 then
						self.g2048 = {}
						self.g2048s = 0
						self.g2048go = false
						self.g2048[math.random(0,15)] = 1
					end
					if not self.AutodriveWorking and self.Train.ALS_ARS["33G"] < 0.5 and self.NeedConfirm == 11 then
						self.AutodriveWorking = true
						self.UOS = false
					end
					if (self.AutodriveWorking or self.VRD or self.UOS) and not self.Trainsit and self.NeedConfirm == 12 then
						self.AutodriveWorking = false
						self.UOS = false
					end
					if not self.UOS and not self.Train.ALS_ARS.EnableARS and self.NeedConfirm == 13 then
						self.AutodriveWorking = false
						self.UOS = true
					end
					self.NeedConfirm = 0
					self.MenuChoosed = 0
				end
			end
			if self:FindAimButton(x,y,261, 210, 140, 40) then
				self.NCCanc = state
				if not state then
					self.NeedConfirm = 0
				end
			end
		end
	--[[
	elseif self.State == 71 then
		if name == "BEnter" then
			self.AutodriveWorking = true
			self.UOS = false
			self:SetState(7,nil,true)
		end
		if name == "BLeft" then
			self:SetState(7,nil,true)
		end
	elseif self.State == 72 then
		if name == "BEnter" then
			self.AutodriveWorking = false
			self.UOS = false
			self:SetState(7,nil,true)
		end
		if name == "BLeft" then
			self:SetState(7,nil,true)
		end
	elseif self.State == 73 then
		if name == "BEnter" then
			self.AutodriveWorking = false
			self.UOS = true
			self:SetState(7,nil,true)
		end
	]]
	end
	--print(x,y)
end
function TRAIN_SYSTEM:Trigger(name,nosnd)
	--self.Pass = "A"
	--self.State = 0
	local Announcer = self.Train.Announcer
	self.Pitches = {
		B1 = 166,
		B2 = 155 ,
		B3 = 144,
		B4 = 160,
		B5 = 150,
		B6 = 140,
		B7 = 150,
		B8 = 145,
		B9 = 140,
		BEsc = 140,
		B0 = 135,
		BEnter = 130,
		BLeft = 125,
		BDown = 120,
		BRight = 115,
		BF = 130,
		BUp = 125,
		BM = 120,
	}
	if not nosnd then self.Train:PlayOnce("paksd","cabin",0.75,self.Pitches[name] or 120.0) end
	if self.State == 3 and name == "BEnter" and self.BackPAEA then
		self.BackPAEA = nil
		return
	end
	if self.State == 3 and name == "BEnter" and self.Train.KV.ReverserPosition ~= 0 and self.BackPA and not self.ErrorCode and not self.BackErrorCode and not self.BackPAEA then
		self:SetState(1.1,(self.FirstStation ~= "" and self.LastStation ~= "") and 5 or 4)
	elseif self.State == 4 then
		if name == "BEnter" then
			if self.EnteredPass == "31173" then
				self:SetState(1.1,-2)
			elseif self.Pass ~= self.EnteredPass then
				self.EnteredPass = "/"
			else
				self:SetState(1.1,5)
			end
		else
			if self.EnteredPass == "/" then self.EnteredPass = "" end
			local Char = tonumber(name:sub(2,2))
			if Char and #self.EnteredPass < 11 then self.EnteredPass = self.EnteredPass..tonumber(name:sub(2,2)) end
		end
	elseif self.State == 5 then
		if name == "BDown" then
			self.State5Choose = math.min(3,(self.State5Choose or 1) + 1)
			if self.State5Choose == 2 and not self.Train:GetNW2Bool("PAKSDM:Restart") then self.State5Choose = self.State5Choose + 1 end
		end
		if name == "BUp" then
			self.State5Choose = math.max(1,(self.State5Choose or 1) - 1)
			if self.State5Choose == 2 and not self.Train:GetNW2Bool("PAKSDM:Restart") then self.State5Choose = self.State5Choose - 1 end
		end
		if name == "BEnter" then
			if self.State5Choose == 1 then
				self:SetState(1.1,6)
			elseif self.State5Choose == 2 then
				self:SetState(1.1,7)
			else
				self:SetState(1.1,3)
			end
		end
		if name == "B1" then
			self:SetState(1.1,6)
		end
		if name == "B2" and self.Train:GetNW2Bool("PAKSDM:Restart") then
			self:SetState(1.1,7)
		end
	elseif self.State == 6 then
		if self.State6Error then if name == "BEnter" then self.State6Error = false end return end
		if name == "BDown" then
			self.State6Choose = math.min(4,(self.State6Choose or 1) + 1)
		end
		if name == "BUp" then
			self.State6Error = false
			self.State6Choose = math.max(1,(self.State6Choose or 1) - 1)
		end
		if name == "BLeft" then
			if self.State6Choose == 2 then
				self.FirstStation= self.FirstStation:sub(1,-2)
			end
			if self.State6Choose == 3 then
				self.LastStation= self.LastStation:sub(1,-2)
			end
			if self.State6Choose == 4 then
				self.RouteNumber= self.RouteNumber:sub(1,-2)
			end
			self:UpdateUPO()
		end
		if name == "BEsc" then
			self:SetState(1.1,5)
		end
		if name == "BEnter" then
			if not Metrostroi.WorkingStations[self.Line] or
				not Metrostroi.WorkingStations[self.Line][tonumber(self.FirstStation)] or
				not Metrostroi.AnnouncerData[tonumber(self.FirstStation)] or
				not Metrostroi.WorkingStations[self.Line][tonumber(self.LastStation)] or
				not Metrostroi.AnnouncerData[tonumber(self.LastStation)] or
				#self.RouteNumber < 3 or self.LastStation == self.FirstStation then
				self.State6Error = not self.State6Error
			else
				self:SetState(1.1,8)
			end
		end
		local Char = tonumber(name:sub(2,2))
		if Char then
			if self.State6Choose == 1 then
				self.Line = Char
				if Metrostroi.WorkingStations[self.Line] then
					--local Routelength = #Metrostroi.WorkingStations[self.Line]
					--self.FirstStation = tostring(Metrostroi.WorkingStations[self.Line][1])
					--self.LastStation = tostring(Metrostroi.WorkingStations[self.Line][Routelength])
				end
			end
			if self.State6Choose == 2 and #self.FirstStation < 3 and (Char ~= 0 or #self.FirstStation > 0) then
				self.FirstStation= self.FirstStation..tostring(Char)
			end
			if self.State6Choose == 3 and #self.LastStation < 3 and (Char ~= 0 or #self.LastStation > 0) then
				self.LastStation= self.LastStation..tostring(Char)
			end
			if self.State6Choose == 4 and #self.RouteNumber < 3 then
				self.RouteNumber= self.RouteNumber..tostring(Char)
			end
			self:UpdateUPO()
		end
	elseif self.State == 7 then
		if self.State6Error then if name == "BEnter" then self.State6Error = false end return end
		if name == "BDown" then
			self.State6Choose = math.min(3,(self.State6Choose or 1) + 1)
		end
		if name == "BUp" then
			self.State6Error = false
			self.State6Choose = math.max(1,(self.State6Choose or 1) - 1)
		end
		if name == "BLeft" then
			if self.State6Choose == 2 then
				self.LastStation= self.LastStation:sub(1,-2)
			end
			if self.State6Choose == 3 then
				self.RouteNumber= self.RouteNumber:sub(1,-2)
			end
			self:UpdateUPO()
		end
		if name == "BEsc" then
			self:SetState(1.1,5)
		end
		if name == "BEnter" and self.State6Choose == 4 then
			if not Metrostroi.WorkingStations[self.Line] or
				not Metrostroi.WorkingStations[self.Line][tonumber(self.FirstStation)] or
				not Metrostroi.AnnouncerData[tonumber(self.FirstStation)] or
				not Metrostroi.WorkingStations[self.Line][tonumber(self.LastStation)] or
				not Metrostroi.AnnouncerData[tonumber(self.LastStation)] or
				#self.RouteNumber < 3 or self.LastStation == self.FirstStation then
				self.State6Error = not self.State6Error
			else
				self:SetState(1.1,9)
				for k,v in pairs(self.Train.WagonList) do
					if v ~= self.Train and v["PA-KSD-M"] then
						v["PA-KSD-M"]:SetState(9)
					end
					--if v.UPO then v.UPO:SetStations(self.Line,self.FirstStation,self.LastStation,false) end
				end
				--self.Train.UPO:SetStations(self.Line,self.FirstStation,self.LastStation,true)
			end
		end
		local Char = tonumber(name:sub(2,2))
		if Char then
			if self.State6Choose == 1 then
				self.Line = Char
				if Metrostroi.WorkingStations[self.Line] then
					local Routelength = #Metrostroi.WorkingStations[self.Line]
					self.FirstStation = self.FirstStation ~= "" and self.FirstStation or tostring(Metrostroi.WorkingStations[self.Line][1])
					self.LastStation = tostring(Metrostroi.WorkingStations[self.Line][Routelength])
					if tonumber(self.LastStation) < tonumber(self.FirstStation) then
						local temp = self.FirstStation
						self.FirstStation = self.LastStation
						self.LastStation = temp
					end
				end
			end
			if self.State6Choose == 2 and #self.LastStation < 3 and (Char ~= 0 or #self.LastStation > 0) then
				self.LastStation= self.LastStation..tostring(Char)
			end
			if self.State6Choose == 3 and #self.RouteNumber < 3 then
				self.RouteNumber= self.RouteNumber..tostring(Char)
			end
			self:UpdateUPO()
		end
	elseif self.State == 8 then
		if name == "BEnter" and self.Check == false then
			self:SetState(1.1,9)
		end
	elseif self.State == 9 then
		if self.Train:GetNW2Bool("PAKSDM:SetupError",false) then
			if name == "BEnter" then
				for k,v in pairs(self.Train.WagonList) do
					v["PA-KSD-M"]:SetState(3)
				end
			end
			return
		end
		if self.g2048 then
			if name == "BEsc" then
				self.g2048 = nil
			end
			local spawn = false
			if name == "BDown" then
				for i = 11,0,-1 do
					local add
					for i1 = 0,2 do
						add = 4*(3-math.floor(i/4)) - i1*4
						if not self.g2048[i+add] or self.g2048[i+add] == 0 or self.g2048[i+add] == self.g2048[i] then
							break
						end
						if i1 == 2 then add = 0 end
					end
					if self.g2048[i] and self.g2048[i] > 0 and add > 0 then
						if self.g2048[i+add] and self.g2048[i+add] > 0 then
							if self.g2048[i+add] == self.g2048[i] then
								self.g2048[i+add] = self.g2048[i] + 1
								self.g2048s = self.g2048s + 2^(self.g2048[i] + 1)
							end
						else
							self.g2048[i+add] = self.g2048[i]
						end
						self.g2048[i] = 0
						spawn = true
					end
				end
			end
			if name == "BUp" then
				for i = 3,15 do
					local add
					for i1 = 0,2 do
						add = 4*(math.floor(i/4)) - i1*4
						if not self.g2048[i-add] or self.g2048[i-add] == 0 or self.g2048[i-add] == self.g2048[i] then
							break
						end
						if i1 == 2 then add = 0 end
					end
					if self.g2048[i] and self.g2048[i] > 0 and add > 0 then
						if self.g2048[i-add] and self.g2048[i-add] > 0 then
							if self.g2048[i-add] == self.g2048[i] then
								self.g2048[i-add] = self.g2048[i] + 1
								self.g2048s = self.g2048s + 2^(self.g2048[i] + 1)
							end
						else
							self.g2048[i-add] = self.g2048[i]
						end
						self.g2048[i] = 0
						spawn = true
					end
				end
			end
			if name == "BLeft" then
				for i = 0,15 do
					if i%4 ~= 0 then
						local add
						for i1 = 0,2 do
							add  = math.floor(i%4) - i1
							if not self.g2048[i-add] or self.g2048[i-add] == 0 or self.g2048[i-add] == self.g2048[i] then
								break
							end
							if i1 == 2 then add = 0 end
						end
						if self.g2048[i] and self.g2048[i] > 0 and add > 0 then-- and i-add > 0 then
							if self.g2048[i-add] and self.g2048[i-add] > 0 then
								if self.g2048[i-add] == self.g2048[i] then
									self.g2048[i-add] = self.g2048[i] + 1
									self.g2048s = self.g2048s + 2^(self.g2048[i] + 1)
								end
							else
								self.g2048[i-add] = self.g2048[i]
							end
							self.g2048[i] = 0
							spawn = true
						end
					end
				end
			end
			if name == "BRight" then
				for i = 15,0,-1 do
					if i%4 ~= 3 then
						local add
						for i1 = 0,2 do
							add  = 3-math.floor(i%4) - i1
							if not self.g2048[i+add] or self.g2048[i+add] == 0 or self.g2048[i+add] == self.g2048[i] then
								break
							end
							if i1 == 2 then add = 0 end
						end
						if self.g2048[i] and self.g2048[i] > 0 and add > 0 then-- and i-add > 0 then
							if self.g2048[i+add] and self.g2048[i+add] > 0 then
								if self.g2048[i+add] == self.g2048[i] then
									self.g2048[i+add] = self.g2048[i] + 1
									self.g2048s = self.g2048s + 2^(self.g2048[i] + 1)
								end
							else
								self.g2048[i+add] = self.g2048[i]
							end
							self.g2048[i] = 0
							spawn = true
						end
					end
				end
			end
			local count = 0
			for i = 0,15 do
				if self.g2048[i] and self.g2048[i] > 0 then
					count = count + 1
				end
			end
			if (name == "BDown" or name == "BUp" or name == "BLeft" or name == "BRight") and count < 15 and spawn then
				while true do
					local choose = math.random(0,15)
					if not self.g2048[choose] or self.g2048[choose] == 0 then
						self.g2048[choose] = 1
						break
					end

					--x = x +1
				end
			end
			if count >= 15 then self.g2048go = true end
			return
		end
		if self.Fix then
			if self.State6Error then if name == "BEnter" then self.State6Error = false end return end
			if name == "BEsc" then
				if self.Fix == 1 and #self.EnteredStation > 0 then
					self.EnteredStation = ""
				end
			end
			if name == "BEnter" then
				if not Metrostroi.WorkingStations[self.FLine] or
					not Metrostroi.WorkingStations[self.FLine][tonumber(self.EnteredStation)] or
					not Metrostroi.AnnouncerData[tonumber(self.EnteredStation)] or tonumber(self.EnteredStation) == self.FirstStation then
					self.State6Error = not self.State6Error
				else
					self.FirstStation = self.EnteredStation
					self.Line = self.FLine
					self:UpdateUPO()
					self.Fix = nil
				end
			end
			if name == "BDown" then
				self.Fix = math.min(1,self.Fix + 1)
			end
			if name == "BUp" then
				self.State6Error = false
				self.Fix = math.max(0,self.Fix - 1)
			end
			local Char = tonumber(name:sub(2,2))
			if Char then
				if self.Fix == 0 then
					self.FLine = Char
				end
				if self.Fix == 1 and #self.EnteredStation < 3 and (Char ~= 0 or #self.EnteredStation > 0) then
					self.EnteredStation= self.EnteredStation..tostring(Char)
				end
			end
			return
		end
		if self.Zon then
			if self.State6Error then if name == "BEnter" then self.State6Error = false end return end
			if name == "BEsc" then
				if self.Fix == 1 and #self.EnteredStation > 0 then
					self.EnteredStation = ""
				end
			end
			if name == "BEnter" then
				if not Metrostroi.WorkingStations[self.FLine] or
					not Metrostroi.WorkingStations[self.FLine][tonumber(self.EnteredStation)] or
					not Metrostroi.AnnouncerData[tonumber(self.EnteredStation)] or tonumber(self.EnteredStation) == self.LastStation then
					self.State6Error = not self.State6Error
				else
					self.LastStation = self.EnteredStation
					self:UpdateUPO()
					self.Zon = nil
				end
			end
			--if name == "BDown" then
				--self.Fix = math.min(1,self.Fix + 1)
			--end
			--if name == "BUp" then
				--self.State6Error = false
				--self.Fix = math.max(0,self.Fix - 1)
			--end
			local Char = tonumber(name:sub(2,2))
			if Char then
				if self.Zon == 1 and #self.EnteredStation < 3 and (Char ~= 0 or #self.EnteredStation > 0) then
					self.EnteredStation= self.EnteredStation..tostring(Char)
				end
			end
			return
		end
		if name == "BF" then
			if self.MenuChoosed == 0 and self.AnnChoosed == 0 and not self.Zon and not self.Fix then
				self.MenuChoosed = 1
			end
		end
		if self.MenuChoosed == 0 and self.AnnChoosed == 0 then
			if name == "B1" and not self.AutodriveWorking and self.Train.ALS_ARS["33G"] < 0.5   and (not self.NeedConfirm or self.NeedConfirm == 0) then
				self.NeedConfirm = 11
			end
			if name == "B2" and (self.AutodriveWorking or self.VRD or self.UOS) and not self.Trainsit  and (not self.NeedConfirm or self.NeedConfirm == 0) then
				self.NeedConfirm = 12
			end
			if name == "B3" and not self.UOS and not self.Train.ALS_ARS.EnableARS  and (not self.NeedConfirm or self.NeedConfirm == 0) then
				self.NeedConfirm = 13
			end
		elseif self.AnnChoosed == 0 then
			local Char = tonumber(name:sub(2,2))
			if Char and Char < 8 and Char > 0 then
				self.MenuChoosed = Char
				if self.MenuChoosed == 1 and self.Train.Speed < 0.5 then
					self.NeedConfirm = 1
				elseif self.MenuChoosed == 2 then
					self.KD = not self.KD
				elseif self.MenuChoosed == 3 then
					for k,v in pairs(self.Train.WagonList) do
						v["PA-KSD-M"]:SetState(3)
					end
				elseif self.MenuChoosed == 4 then
					self.Transit = not self.Transit
					self.AutodriveWorking = false
				elseif self.MenuChoosed == 5 then
					self.NeedConfirm = 5
				elseif self.MenuChoosed == 6 then
					self.NeedConfirm = 6
				elseif self.MenuChoosed == 7 then
					self.NeedConfirm = 7
				elseif self.MenuChoosed == 8 and not self.Arrived then
					--self.Arrived = true
					--if self.Train.R_UPO.Value > 0 then
	--						local tbl = Metrostroi.WorkingStations[self.Line]
						--self.UPO:PlayArriving(self.Train.UPO.Station,tbl[tbl[self.Train.UPO.Station] + (self.Train.UPO.Path == 1 and 1 or -1)],self.Train.UPO.Path)
					--end
				end
				if self.NeedConfirm == 0 then self.MenuChoosed = 0 end
			end
		end
		if name == "BDown" then
			if self.MenuChoosed ~= 0 and (not self.NeedConfirm or self.NeedConfirm == 0) then
				self.MenuChoosed = math.min(7,self.MenuChoosed + 1)

				if self.MenuChoosed == 5 and (self.VRD or not (self.Train.ALS_ARS.Signal0 and not self.Train.ALS_ARS.RealNoFreq and not self.Train.ALS_ARS.Signal40 and not self.Train.ALS_ARS.Signal60 and not self.Train.ALS_ARS.Signal70 and not self.Train.ALS_ARS.Signal80)) then
					self:Trigger("BDown",true)
				elseif self.MenuChoosed == 6 then
					if self.LastStation == tostring(self.Train.UPO.Station) then
						self:Trigger("BDown",true)
					end
				elseif self.MenuChoosed == 7 then
					if self.FirstStation == tostring(self.Train.UPO.Station) then
						self:Trigger("BDown",true)
					end
				end
			end
			if self.AnnChoosed ~= 0 and not self.Zon and not self.Fix then
				self.AnnChoosed = math.min(4,self.AnnChoosed + 1)
			end
		end
		if name == "BUp" then
			if self.MenuChoosed ~= 0 and (not self.NeedConfirm or self.NeedConfirm == 0) then
				self.MenuChoosed = math.max(1,self.MenuChoosed - 1)
				if self.MenuChoosed == 5 and (self.VRD or not (self.Train.ALS_ARS.Signal0 and not self.Train.ALS_ARS.RealNoFreq and not self.Train.ALS_ARS.Signal40 and not self.Train.ALS_ARS.Signal60 and not self.Train.ALS_ARS.Signal70 and not self.Train.ALS_ARS.Signal80)) then
					self:Trigger("BUp",true)
				end
			end
			if self.MenuChoosed == 0 and self.AnnChoosed == 0 then
				self.AnnChoosed = 1
			end
			if self.AnnChoosed ~= 0 then
				self.AnnChoosed = math.max(1,self.AnnChoosed - 1)
			end
		end
		if name == "BEsc" then
			--if self.MenuChoosed ~= 0 then
				if (not self.NeedConfirm or self.NeedConfirm == 0) then self.MenuChoosed = 0 end
				self.AnnChoosed = 0
			--end
		end
		if (self.NeedConfirm and self.NeedConfirm > 0) then
			if name == "BEnter" then
				if self.NeedConfirm == 1 and self.Train.Speed < 0.5 then
					self.Nakat = true
				end
				if (self.Train.ALS_ARS.Signal0 and not self.Train.ALS_ARS.RealNoFreq and not self.Train.ALS_ARS.Signal40 and not self.Train.ALS_ARS.Signal60 and not self.Train.ALS_ARS.Signal70 and not self.Train.ALS_ARS.Signal80) then
					self.VRD = true
				end
				if self.NeedConfirm == 6 then
					self.Zon = 1
					self.EnteredStation = ""
					self.FLine = self.Line
					self.State6Error = false
				end
				if self.NeedConfirm == 7 then
					self.Fix = 0
					self.EnteredStation = ""
					self.FLine = nil
					self.State6Error = false
				end
				if self.NeedConfirm == 8 then
					self.g2048 = {}
					self.g2048s = 0
					self.g2048go = false
					self.g2048[math.random(0,15)] = 1
				end
				if not self.AutodriveWorking and self.Train.ALS_ARS["33G"] < 0.5 and self.NeedConfirm == 11 then
					self.AutodriveWorking = true
					self.UOS = false
				end
				if (self.AutodriveWorking or self.VRD or self.UOS) and not self.Trainsit and self.NeedConfirm == 12 then
					self.AutodriveWorking = false
					self.UOS = false
				end
				if not self.UOS and not self.Train.ALS_ARS.EnableARS and self.NeedConfirm == 13 then
					self.AutodriveWorking = false
					self.UOS = true
				end
				self.NeedConfirm = 0
				self.MenuChoosed = 0
			end
			if name == "BEsc" then
				self.NeedConfirm = 0
			end
		end
		if self.MenuChoosed ~= 0 and not self.Nakat and not self.Fix and not self.Zon and not self.g2048 then
			if name == "BEnter" and (not self.NeedConfirm or self.NeedConfirm == 0) then
				if self.MenuChoosed == 1 and self.Train.Speed < 0.5 then
					self.NeedConfirm = 1
				elseif self.MenuChoosed == 2 then
					self.KD = not self.KD
				elseif self.MenuChoosed == 3 then
					for k,v in pairs(self.Train.WagonList) do
						v["PA-KSD-M"]:SetState(3)
					end
				elseif self.MenuChoosed == 4 then
					self.Transit = not self.Transit
					self.AutodriveWorking = false
				elseif self.MenuChoosed == 5 then
					self.NeedConfirm = 5
				elseif self.MenuChoosed == 6 then
					self.NeedConfirm = 6
				elseif self.MenuChoosed == 7 then
					self.NeedConfirm = 7
				elseif self.MenuChoosed == 8 and not self.Arrived then
					--self.Arrived = true
					--if self.Train.R_UPO.Value > 0 then
--						local tbl = Metrostroi.WorkingStations[self.Line]
						--self.UPO:PlayArriving(self.Train.UPO.Station,tbl[tbl[self.Train.UPO.Station] + (self.Train.UPO.Path == 1 and 1 or -1)],self.Train.UPO.Path)
					--end
				end
				if self.NeedConfirm == 0 then self.MenuChoosed = 0 end
				--if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self.State = 7 end
			end
		end
		if self.AnnChoosed ~= 0 and not self.Nakat and not self.Fix and not self.Zon and not self.g2048 then
			if name == "BEnter" then
				if self.Train.R_UPO.Value > 0 then self.Train.UPO:II(self.AnnChoosed) end
				self.AnnChoosed = 0
			end
			local Char = tonumber(name:sub(2,2))
			if Char and Char > 0 and Char < 5 and self.Train.R_UPO.Value > 0 then
				self.Train.UPO:II(Char)
				self.AnnChoosed = 0
			end
		end

		if name == "BEsc" and self.Nakat then
			self.Nakat = false
			if self.Train:ReadTrainWire(1) < 1 then
				self.Train.ALS_ARS.Nakat = false
			end
		end
	end
end
function TRAIN_SYSTEM:GetTimer(val)
	return self.TimerMod and (CurTime() - self.Timer) > val
end
function TRAIN_SYSTEM:SetTimer(mod)
	if mod then
		if self.TimerMod == mod then return end
		self.TimerMod = mod
	else
		self.TimerMod = nil
	end
	self.Timer = CurTime()
end

function TRAIN_SYSTEM:SetState(state,add,state9)
	local Train = self.Train
	local ARS = Train.ALS_ARS
	local Announcer = Train.Announcer
	if state and self.State ~= state then
		self.State = state
		if state == 1 or state == 1.1 then
			self.NextState = add
		end
		self:SetTimer()
	elseif not state then
		state = self.NextState
		self.State = self.NextState
	else
		return
	end
	if state == 0 then
		self.LoadTimer = math.random(3,9)
	end
	if state == 2 then
		self.LoadTimer = math.random(2,6)
	end
	if state == 3 then
		self.ErrorCode = nil
		self.BackErrorCode = nil
	end
	if state == 4 then
		self.EnteredPass = ""
	end
	if state == 5 then
		self.State5Choose = 1
	end
	if state == 6 then
		self.State6Choose = 1
		self.Line = self.Train.UPO.Line or 1
		if Metrostroi.WorkingStations[self.Line] then
			local Routelength = #Metrostroi.WorkingStations[self.Line]
			self.FirstStation = tostring(self.Train.UPO.FirstStation or self.FirstStation or "")--tostring(self.Train.UPO.Path == 2 and Metrostroi.WorkingStations[self.Line][Routelength] or Metrostroi.WorkingStations[self.Line][1])
			self.LastStation = tostring(self.Train.UPO.LastStation or self.LastStation or "")--tostring(self.Train.UPO.Path == 1 and Metrostroi.WorkingStations[self.Line][Routelength] or Metrostroi.WorkingStations[self.Line][1])
		else
			self.FirstStation = "111"
			self.LastStation = "123"
		end
		self:UpdateUPO()
		self.State6Error = false
	end
	if state == 7 then
		self.State6Choose = 1
		self.State6Error = false
	end
	if state == 8 then
		self.Check = nil
		ARS:TriggerInput("PA-Ring",1)
		for k,v in pairs(self.Train.WagonList) do
			v.ENDis:TriggerInput("Set",1)
		end
		if not state9 then
			for k,v in pairs(self.Train.WagonList) do
				if v ~= self.Train and v["PA-KSD-M"] then
					v["PA-KSD-M"]:SetState(8,nil,true)
					--v["PA-KSD-M"].Line = self.Line
					--v["PA-KSD-M"].RouteNumber = self.RouteNumber
					--v["PA-KSD-M"].FirstStation = self.FirstStation
					--v["PA-KSD-M"].LastStation = self.LastStation
					--v:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
				end
				--if v.UPO then v.UPO:SetStations(self.Line,self.FirstStation,self.LastStation,false) end
			end
		end
		self.Train.UPO:SetStations(self.Line,self.FirstStation,self.LastStation,true)
	else
		for k,v in pairs(self.Train.WagonList) do
			v.ENDis:TriggerInput("Set",0)
			if v.ALS_ARS then v.ALS_ARS:TriggerInput("PA-Ring",0) end
		end
	end
	if state == 9 then
		if not state9 then
			for k,v in pairs(self.Train.WagonList) do
				if v ~= self.Train and v["PA-KSD-M"] then
					v["PA-KSD-M"]:SetState(9,nil,true)
					v["PA-KSD-M"].Line = self.Line
					v["PA-KSD-M"].RouteNumber = self.RouteNumber
					v["PA-KSD-M"].FirstStation = self.FirstStation
					v["PA-KSD-M"].LastStation = self.LastStation
					v.UPO:SetStations(self.Line,self.FirstStation,self.LastStation,false)
				end
			end
			self.Train.UPO:SetStations(self.Line,self.FirstStation,self.LastStation,true)
		end
		self.AnnChoosed = 0
		self.NeedConfirm = 0
		self.MenuChoosed = 0
		self.Fix = nil
		self.Zon = nil
		Train.UPO.BoardTime = nil
		self.ODZ = nil
	end
	if state == 0 then
		self.Train:PlayOnce("paksd","cabin",0.75,200.0)
		self.Train.ALS_ARS:TriggerInput("PA-Ring",0)
		self.EnteredPass = ""
	end
	if state == 3 then
		if IsValid(self.Train.DriverSeat) then
			self.Train.DriverSeat:EmitSound("subway_announcer/00_05.mp3", 73, 100)
		end
	end
end
function TRAIN_SYSTEM:Think(dT)
	if self.Train.Blok ~= 4 then self:SetState(-1) return end
	local Train = self.Train
	local ARS = Train.ALS_ARS
	local Announcer = Train.Announcer
	if self.Train.VPA.Value < 1 and not self.OffTimer then --self.VPA and
		self.OffTimer = CurTime() + 1
		self.OnTimer = nil
	end
	if self.Train.VPA.Value == 1 and self.OffTimer then
		self.OffTimer = nil
		self.OnTimer = nil
	end
	if self.Train.VPA.Value > 1 then --not self.VPA and
		for k,v in pairs(self.Train.WagonList) do
			if v["PA-KSD-M"] then v["PA-KSD-M"].VPA = true end
		end
	end
	if self.OnTimer and (CurTime() - self.OnTimer) > 0 then
	end
	if self.OffTimer and (CurTime() - self.OffTimer) > 0 then
		for k,v in pairs(self.Train.WagonList) do
			if v["PA-KSD-M"] then v["PA-KSD-M"].VPA = false end
		end
		self.OffTimer = nil
	end
	if Train.Panel["V1"] < 0.5 or Train.VB.Value < 0.5 then self.VPA = false end
	if not self.VPA then self:SetState(-1) end
	if self.VPA and self.State == -1 and Train.Panel["V1"] > 0.5 then self:SetState(0) end

	--self.Train.UPO.Station = self.Train:ReadCell(49160) > 0 and self.Train:ReadCell(49160) or self.Train:ReadCell(49161)
	--self.Train.UPO.Path = self.Train:ReadCell(49170)
	--self.Train.UPO.Distance = math.min(9999,self.Train:ReadCell(49165) + (Train.Autodrive.Corrections[self.Train.UPO.Station] or 0))
	if Train.VB.Value > 0.5 and Train.Battery.Voltage > 55 and self.State > -1  then
		for k,v in pairs(self.TriggerNames) do
			if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
				if Train[v].Value > 0.5 then
					self:Trigger(v)
				end
				--print(v,self.Train[v].Value > 0.5)
				self.Triggers[v] = Train[v].Value > 0.5
			end
		end
	end
	if self.Train.KV.ReverserPosition == 0 and self.State > 3 and self.State < 8 and self.State ~= -9 then self:SetState(3) end
	if self.State > 2 then
		local Back = self.Train.WagonList[#self.Train.WagonList]
		if #self.Train.WagonList > 1 and Back.SubwayTrain and Back.SubwayTrain.Type == "81" and Back.SubwayTrain.Manufacturer == "LVZ" then
			self.BackPA = Back["PA-KSD-M"]
		else
			self.BackPA = nil
		end
		if self.BackPA then
			if self.BackPA.State < 2 then
				self.BackErrorCode = 0x9999
			elseif self.BackPA.State == 3 then
				self.BackErrorCode = self.BackPA.ErrorCode
			elseif self.BackPA.State < 3 then
				self.BackErrorCode = 0x0001
			elseif self.BackPA.VPA then
				self.BackErrorCode = 0x0002
			end
		else
			self.BackErrorCode = nil
		end
		if self.BackErrorCode and self.BackErrorCode ~= 0x0002 and self.State > 3 then
			self:SetState(1,3)
			self.BackPAEA = true
		end
	end
	if self.State == 0 and self.RealState ~= 0 then
	elseif self.State == 0 then
		self:SetTimer(0.5)
		if self:GetTimer(self.LoadTimer) then
			self:SetState(1,2)
		end
	elseif self.State == 1 then
		self:SetTimer(1)
		if self:GetTimer(0.4) then
			self:SetState()
		end
	elseif self.State == 1.1 then
		self:SetTimer(1)
		if self:GetTimer(0.1) then
			self:SetState()
		end
	elseif self.State == 2 then
		self:SetTimer(0.5)
		if self:GetTimer(self.LoadTimer) then
			self:SetState(1,3)
		end
	elseif self.State == 8 then
		--print(ARS.KVT)
		if ARS.KVT and self.Check == nil then
			self.Check = true
			self:SetTimer(4)
		end
		if not ARS.KVT and self.Check ~= false then
			self.Check = nil
			self:SetTimer()
		end
		if ARS.KVT and self:GetTimer(1) then
			self.Check = false
			ARS:TriggerInput("PA-Ring",0)
			for k,v in pairs(self.Train.WagonList) do
				if v ~= self.Train and v.ALS_ARS then
					v.ALS_ARS:TriggerInput("PA-Ring",0)
				end
			end
			self:SetTimer()
		end
	elseif self.State == 9 then
		if (self.Train.UPO:GetSTNum(self.LastStation) > self.Train.UPO:GetSTNum(self.FirstStation) and self.Train.UPO.Path == 2) or (self.Train.UPO:GetSTNum(self.FirstStation) > self.Train.UPO:GetSTNum(self.LastStation)  and self.Train.UPO.Path == 1) then
			local old = self.LastStation
			self.LastStation = self.FirstStation
			self.FirstStation = old
		end
		if self.VRD and (not ARS.Signal0 or ARS.Signal0 and (ARS.Signal40 or ARS.Signal60 or ARS.Signal70 or ARS.Signal80)) then self.VRD = false end
		self.State9 = (Train.UPO:End(self.Train.UPO.Station,self.Train.UPO.Path,true) or Train.UPO:GetSTNum(self.LastStation) > Train.UPO:GetSTNum(self.Train.UPO.Station) and self.Train.UPO.Path == 2 or Train.UPO:GetSTNum(self.Train.UPO.Station) < Train.UPO:GetSTNum(self.FirstStation) and self.Train.UPO.Path == 1) and 0 or 1--self.Arrived ~= nil and 1 or 2
		if self.State9 ~= 0 and self.Train.KV.ReverserPosition ~= 0 then
			if not self.Trainsit then
				if self.Train.UPO.Distance < 100 and self.Train.Speed > 55 then
					self.StopTrain = true
				end
				if self.Train.UPO.Distance < 10 and self.Train.Speed > 20 then
					self.StopTrain = true
				end
				if self.Train.Speed < 0.5 and self.StopTrain then
					self.StopTrain = false
				end
				if self.StopTrain then
				end
			elseif self.StopTrain then
				self.StopTrain = false
			end

			if not self.Transit then
				if self.Train.UPO.Distance < 75 and self.Arrived == nil and Metrostroi.WorkingStations[self.Line][self.Train.UPO.Station] and ARS.Speed <= 1 then
					self.Arrived = true
				end
			end
			--[[
			if not self.Transit and 45 < self.Train.UPO.Distance and self.Train.UPO.Distance < 75 and not self.Arrived and Metrostroi.WorkingStations[self.Line][self.Train.UPO.Station] then
				self.Arrived = true
				if self.Train.R_UPO.Value > 0 then
					local tbl = Metrostroi.WorkingStations[self.Line]
					self.UPO:PlayArriving(self.Train.UPO.Station,tbl[tbl[self.Train.UPO.Station] + (self.Train.UPO.Path == 1 and 1 or -1)],self.Train.UPO.Path)
				end
			end
			]]
			if self.Transit then self.Arrived = nil end
			if self.Train.UPO.Distance > 75 then
				self.Arrived = nil
			else
				--if self.Train.Panel.SD < 0.5 then self.Arrived = true end
			end
			--if (self.Ring == nil or self.Ring == 0) and self.Train.Panel.SD < 0.5 then
				--self.Ring = false
			--end
			if self.Arrived then
				if Train.UPO.BoardTime and math.floor((Train.UPO.BoardTime or CurTime()) - CurTime()) < (self.Train.Horlift and 15 or 8) and self.Arrived then
					self.Arrived = false
				end
			end
			if (self.Train:ReadCell(1) > 0 or ARS.Speed > 1) and self.Arrived == false then self.Arrived = nil end
		end
		if self.Nakat then
			if not self.Meters then self.Meters = 0 end
			self.Meters = self.Meters + ARS.Speed*self.Train.SpeedSign/3600*1000*dT
			if math.abs(self.Meters) > 2.5 then
				self.Nakat = false
				if self.Train:ReadTrainWire(1) < 1 then
					ARS.Nakat = self.Meters < 0
				end
			end
		else
			self.Meters = nil
		end
	end
	if self.State ~= self.RealState then
		self.RealState = self.State
		self.TimeOverride = true
	end
	self.Time = self.Time or CurTime()
	if (CurTime() - self.Time) > 0.1 or self.TimeOverride then
		self.TimeOverride = nil
		--print(1)
		self.Time = CurTime()
		Train:SetNW2Int("PAKSDM:State",self.State)
		if self.State == 3 then
			Train:SetNW2Bool("PAKSDM:BackPAErrorNoAccepted",self.BackPAEA == true)
			Train:SetNW2Bool("PAKSDM:BackPA",self.BackPA ~= nil)
			Train:SetNW2Bool("PAKSDM:RR",self.Train.KV.ReverserPosition ~= 0)
			Train:SetNW2Int("PAKSDM:ErrorCode",self.ErrorCode or 0x0000)
			Train:SetNW2Int("PAKSDM:BErrorCode",self.BackErrorCode or 0x0000)
		elseif self.State == 4 then
			Train:SetNW2Int("PAKSDM:Pass",self.EnteredPass ~= "/" and #self.EnteredPass or -1)
		elseif self.State == 5 then
			Train:SetNW2Bool("PAKSDM:Restart",self.FirstStation ~= "" and self.LastStation ~= "")
			Train:SetNW2Int("PAKSDM:State5",self.State5Choose)
		elseif self.State == 6 then
			Train:SetNW2Int("PAKSDM:State6",self.State6Choose)
			Train:SetNW2Bool("PAKSDM:State6Error",self.State6Error)
			Train:SetNW2Int("PAKSDM:LastStation",tonumber(self.LastStation) or -1)
			Train:SetNW2Int("PAKSDM:FirstStation",tonumber(self.FirstStation) or -1)
			Train:SetNW2Int("PAKSDM:Line",self.Line)
			Train:SetNW2Int("PAKSDM:RouteNumber",tonumber(self.RouteNumber ~= "" and self.RouteNumber or -1))
		elseif self.State == 7 then
			Train:SetNW2Int("PAKSDM:State6",self.State6Choose)
			Train:SetNW2Bool("PAKSDM:State6Error",self.State6Error)
			Train:SetNW2Int("PAKSDM:LastStation",tonumber(self.LastStation) or -1)
			Train:SetNW2Int("PAKSDM:Line",self.Line)
			Train:SetNW2Int("PAKSDM:RouteNumber",tonumber(self.RouteNumber ~= "" and self.RouteNumber or -1))
			--Train:SetNW2Int("PAKSDM:LastStation",tonumber(self.LastStation) or -1)
			--Train:SetNW2Int("PAKSDM:Line",self.Line)
			--Train:SetNW2Int("PAKSDM:RouteNumber",tonumber(self.RouteNumber ~= "" and self.RouteNumber or -1))
		elseif self.State == 9 then
			Train:SetNW2Bool("PAKSDM:AV", self.AutodriveWorking)
			--print(not self.AutodriveWorking and not self.UOS)
			Train:SetNW2Bool("PAKSDM:KS", not self.AutodriveWorking and not self.UOS)
			Train:SetNW2Bool("PAKSDM:OD",self.UOS)
			Train:SetNW2Int("PAKSDM:Line",self.Line)
			Train:SetNW2Int("PAKSDM:Path",self.Train.UPO.Path)
			Train:SetNW2Int("PAKSDM:Station",self.State9 == 0 and 0 or self.Train.UPO.Station)
			Train:SetNW2Int("PAKSDM:LastStation",self.LastStation)
			Train:SetNW2Float("PAKSDM:Distance",math.Round(self.Train.UPO.Distance,2))
			Train:SetNW2String("PAKSDM:SName",ARS.Signal and ARS.Signal.RealName or "ERR")
			Train:SetNW2Bool("PAKSDM:RR",self.Train.KV.ReverserPosition ~= 0)
			Train:SetNW2Int("PAKSDM:Type",(self.Train.Pneumatic.EmergencyValveEPK and 0 or self.Train.ALS_ARS.UAVAContacts and 4 or self.UOS and 5 or self.VRD and 2 or (self.Train.Autodrive.AutodriveEnabled or self.Train.UPO.StationAutodrive) and 1 or 3))
			Train:SetNW2Int("PAKSDM:KV",self.Train.Autodrive.AutodriveEnabled and (self.Rotating and -3 or self.Brake and -1 or self.Accelerate and 3 or 0) or (ARS["33G"] > 0 or (self.UOS and (ARS["8"] + (1-self.Train.RPB.Value)) > 0)) and 5 or self.Train.KV.RealControllerPosition)
			Train:SetNW2Bool("PAKSDM:VZ1", self.Train:ReadTrainWire(29) > 0)
			Train:SetNW2Bool("PAKSDM:VZ2", self.Train.PneumaticNo2.Value > 0)
			Train:SetNW2Int("PAKSDM:Menu", self.MenuChoosed)
			Train:SetNW2Int("PAKSDM:Ann",self.AnnChoosed)
			Train:SetNW2Int("PAKSDM:NeedConfirm",self.NeedConfirm)
			if self.NeedConfirm > 0 then
				Train:SetNW2Bool("PAKSDM:NCOk",self.NCOk)
				Train:SetNW2Bool("PAKSDM:NCCanc",self.NCCanc)
			end
			Train:SetNW2Bool("PAKSDM:Arrived", Train.UPO.Arrived ~= nil and Train.UPO.BoardTime ~= nil)
			if Train.UPO.Arrived ~= nil and Train.UPO.BoardTime ~= nil then
				Train:SetNW2Int("PAKSDM:BoardTime",math.floor((Train.UPO.BoardTime or CurTime()) - CurTime()))
			end
			Train:SetNW2Bool("PAKSDM:SetupError",Metrostroi.AnnouncerData[tonumber(self.FirstStation)] == nil or Metrostroi.AnnouncerData[tonumber(self.LastStation)] == nil)
			Train:SetNW2Bool("PAKSDM:KD",self.KD)
			Train:SetNW2Bool("PAKSDM:LPT",self.LPT)
			Train:SetNW2Bool("PAKSDM:Nakat",self.Nakat)
			Train:SetNW2Int("PAKSDM:Uklon",math.floor(Train:GetAngles().pitch*100))
			if self.Nakat then
				Train:SetNW2Float("PAKSDM:Meters",math.Round(math.abs(self.Meters or 0),2))
				Train:SetNW2Bool("PAKSDM:Sign",ARS.Speed > 0.5 and self.Train.SpeedSign < 0)
				Train:SetNW2Bool("PAKSDM:NCCanc",self.NCCanc)
			end
			Train:SetNW2Bool("PAKSDM:2048",self.g2048 ~= nil)
			if self.g2048 then
				Train:SetNW2Int("PAKSDM:2048Score",self.g2048s)
				Train:SetNW2Bool("PAKSDM:2048GG",self.g2048go)
				for i = 0,4*4-1 do
					Train:SetNW2Int("PAKSDM:2048:"..math.floor(i/4+1)..":"..(i%4+1),self.g2048[i] or 0)
				end
				Train:SetNW2Bool("PAKSDM:NCCanc",self.NCCanc)
			end
			self.Train:SetNW2Int("PAKSDM:Fix",self.Fix or -1)
			self.Train:SetNW2Int("PAKSDM:Zon",self.Zon or -1)
			if self.Fix or self.Zon then
				Train:SetNW2Bool("PAKSDM:NCOk",self.NCOk)
				Train:SetNW2Bool("PAKSDM:NCCanc",self.NCCanc)
				Train:SetNW2Int("PAKSDM:FLine",self.FLine or -1)
				Train:SetNW2Int("PAKSDM:FStation",tonumber(self.EnteredStation) or -1)
				--Train:SetNW2Int("PAKSDM:FAc",tonumber(self.FStation) or -1)
				Train:SetNW2Bool("PAKSDM:State6Error",self.State6Error)
			end

		else
		end
	end
	if self.Train.VZP.Value > 0.5 and self.AutodriveWorking then
		Train.Autodrive:Enable()
	elseif not self.AutodriveWorking then
		Train.Autodrive:Disable()
	end
	self.RouteNumber = string.gsub(self.Train.RouteNumber or "","^(0+)","")
	if self.State > 7 then
		self.Line = self.Train.UPO.Line
		self.FirstStation = tostring(self.Train.UPO.FirstStation or "")
		self.LastStation = tostring(self.Train.UPO.LastStation or "")
	end
end

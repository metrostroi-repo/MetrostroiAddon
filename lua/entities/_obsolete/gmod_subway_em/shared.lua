ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.PrintNameTranslated       = "Entities.Em"
ENT.Author          = "Oldy"
ENT.Contact         = "oldy702@gmail.com"
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category		= "Metrostroi (trains)"

ENT.Spawnable       = false --NOT FINISHED
ENT.AdminSpawnable  = false --NOT FINISHED

function ENT:PassengerCapacity()
	return 300
end

function ENT:GetStandingArea()
	return Vector(-450,-30,-45),Vector(380,30,-45)
end

function ENT:InitializeSounds()
	self.BaseClass.InitializeSounds(self)
	self.SoundNames["relay_close2"] = nil
	self.SoundNames["rvt_close"] = nil
	self.SoundNames["r1_5_close"] = nil
	self.SoundNames["rvt_open"] = nil
	self.SoundNames["r1_5_open"] = nil
	--[[self.SoundNames["relay_close4"] = {"subway_trains/new/relay_7.wav","subway_trains/new/lsd_4.wav"}
	self.SoundNames["pneumo_switch"] = {
		"subway_trains/pneumo_8.wav",
		"subway_trains/pneumo_9.wav",
	}
	self.SoundNames["rk_spin"]		= "subway_trains/rk_3.wav"
	self.SoundNames["rk_stop"]		= "subway_trains/rk_4.wav"
	]]
end

function ENT:InitializeSystems()
	-- Электросистема 81-710
	self:LoadSystem("Electric","81_704_Electric")

	-- Токоприёмник
	self:LoadSystem("TR","TR_3B")
	-- Электротяговые двигатели
	self:LoadSystem("Engines","DK_117DM")

	-- Резисторы для реостата/пусковых сопротивлений
	self:LoadSystem("KF_47A","KF_47A")
	-- Резисторы для ослабления возбуждения
	self:LoadSystem("KF_50A")
	-- Ящик с предохранителями
	self:LoadSystem("YAP_57")

	-- Резисторы для цепей управления
	--self:LoadSystem("YAS_44V")
	-- Реостатный контроллер для управления пусковыми сопротивления
	self:LoadSystem("RheostatController","EKG_17B")
	-- Групповой переключатель положений
	self:LoadSystem("PositionSwitch","EKG_18B")
	-- Кулачковый контроллер
	self:LoadSystem("KV","KV_70")--_lite")
	-- Контроллер резервного управления
	self:LoadSystem("KRU")


	-- Ящики с реле и контакторами
	self:LoadSystem("LK_755A")
	self:LoadSystem("YAR_13A")
	self:LoadSystem("YAR_27")
	self:LoadSystem("YAK_36")
	self:LoadSystem("YAK_37E")
	self:LoadSystem("YAS_44V")
	self:LoadSystem("YARD_2")
	self:LoadSystem("PR_14X_Panels")

	-- Пневмосистема 81-710
	self:LoadSystem("Pneumatic","81_717_Pneumatic")
	self.Pneumatic.ValveType = 1
	-- Панель управления Е
	self:LoadSystem("Panel","81_704_Panel")
	-- Everything else
	self:LoadSystem("Battery")
	self:LoadSystem("PowerSupply","DIP_01K")
	self:LoadSystem("Horn")
	self:LoadSystem("Announcer")

	self:LoadSystem("ADoorDisable","Relay")

	self:LoadSystem("ALS_ARS","NoARS")
end

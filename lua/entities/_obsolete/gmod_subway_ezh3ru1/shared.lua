ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.PrintNameTranslated       = "Entities.Ezh3"
ENT.Author          = ""
ENT.Contact         = ""
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
	self.SoundNames["relay_close3"] = nil
	--[[self.SoundNames["relay_close4"] = {"subway_trains/new/relay_7.wav","subway_trains/new/lsd_4.wav"}
	self.SoundNames["pneumo_switch"] = {
		"subway_trains/pneumo_8.wav",
		"subway_trains/pneumo_9.wav",
	}]]
	self.SoundNames["rvt_close"] = "subway_trains/sbor.wav"
	self.SoundNames["r1_5_close"] = "subway_trains/sbor_hod.wav"
	self.SoundNames["rvt_open"] = "subway_trains/rasbor_t.wav"
	self.SoundNames["r1_5_open"] = "subway_trains/razbor_hod.wav"
	self.SoundNames["rk_spin"]		= "subway_trains/rk_3.wav"
	self.SoundNames["rk_stop"]		= "subway_trains/rk_4.wav"
	self.SoundNames["switch_off"] = {"subway_trains/tumbler_1_off.wav","subway_trains/tumbler_2_off.wav","subway_trains/tumbler_3_off.wav"}
	self.SoundNames["switch_on"] = {"subway_trains/tumbler_1_on.wav","subway_trains/tumbler_2_on.wav","subway_trains/tumbler_3_on.wav"}
	self.SoundNames["av_on"]			=  {
		"subway_trains/va21_2_1_on.wav",
		"subway_trains/va21_2_2_on.wav",
	}
	self.SoundNames["av_off"]			=  {
		"subway_trains/va21_2_1_off.wav",
		"subway_trains/va21_2_2_off.wav",
	}
end

function ENT:InitializeSystems()
	-- Электросистема 81-710
	self:LoadSystem("Electric","81_710RU1_Electric")

	-- Токоприёмник
	self:LoadSystem("TR","TR_3B")
	-- Электротяговые двигатели
	self:LoadSystem("Engines","DK_117DM")

	-- Резисторы для реостата/пусковых сопротивлений
	self:LoadSystem("KF_47A")
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
	self:LoadSystem("KV","KV_70")
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
	self.Pneumatic.ValveType = 2
	-- Панель управления 81-710
	self:LoadSystem("Panel","81_710RU1_Panel")
	-- Everything else
	self:LoadSystem("Battery")
	self:LoadSystem("PowerSupply","DIP_01K")
	self:LoadSystem("DURA")
	self:LoadSystem("ALS_ARS")
	self:LoadSystem("Horn")
	self:LoadSystem("Announcer")
	self:LoadSystem("ASNP")

	self:LoadSystem("IGLA")

	self:LoadSystem("ASNP31","Relay","Switch")
	self:LoadSystem("ASNP32","Relay","Switch")

	self:LoadSystem("Custom1","Relay","Switch")
	self:LoadSystem("Custom2","Relay","Switch")
	self:LoadSystem("Custom3","Relay","Switch")
	self:LoadSystem("CustomC","Relay","Switch")
	self:LoadSystem("CustomD","Relay","Switch")
	self:LoadSystem("CustomE","Relay","Switch")
	self:LoadSystem("CustomF","Relay","Switch")
	self:LoadSystem("CustomG","Relay","Switch")


end

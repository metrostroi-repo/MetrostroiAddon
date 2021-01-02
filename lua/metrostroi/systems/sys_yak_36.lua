--------------------------------------------------------------------------------
-- Box with switches (YaK-36)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("YAK_36")

function TRAIN_SYSTEM:Initialize()
	-- КВЦ (контактор высоковольтных цепей)
	self.Train:LoadSystem("KVC","Relay","KPP-110","750V")
	-- КК (контактор мотор-компрессора)
	self.Train:LoadSystem("KK","Relay","KPP-110",{ bass = true })
	-- КУП (включение прогрева кабины машиниста)
	self.Train:LoadSystem("KUP","Relay","KPP-110")
	-- ТРК (защита мотор-компрессора от перегрузки)
	self.Train:LoadSystem("TRK","Relay","TRTP-115")
end

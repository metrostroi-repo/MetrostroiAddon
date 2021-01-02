--------------------------------------------------------------------------------
-- HC switches case (LK-753V)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("LK_753V")

function TRAIN_SYSTEM:Initialize()
	-- Контактор шунтировкти (Ш1)
	self.Train:LoadSystem("SH1","Relay","PK-162",{bass = true,close_time=0.1})
	-- Контактор шунтировкти (Ш2)
	self.Train:LoadSystem("SH2","Relay","PK-162",{bass = true,close_time=0.1})
	-- Мостовой контактор (М)
	self.Train:LoadSystem("M","Relay","PK-162",{bass = true,close_time=0.1})
end
--------------------------------------------------------------------------------
-- Box with fuses (YAP-57)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("YAP_57")

function TRAIN_SYSTEM:Initialize()
	-- Предохранитель главной электрической цепи
	self.Train:LoadSystem("PNB_1250_1","Relay","PNB_1250_630_0", { normally_closed = true })
	self.Train:LoadSystem("PNB_1250_2","Relay","PNB_1250_630_0", { normally_closed = true })

	-- Предохранитель вспомагательных электрических цепей
	self.Train:LoadSystem("PP_28","Relay","PP-28", { normally_closed = true })
end
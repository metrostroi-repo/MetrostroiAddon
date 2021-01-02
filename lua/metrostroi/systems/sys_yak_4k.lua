--------------------------------------------------------------------------------
-- Box with switches (YaK-4K)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("YAK_4K")

function TRAIN_SYSTEM:Initialize()
	-- КК (контактор мотор-компрессора)
	self.Train:LoadSystem("KK","Relay","KPP-110",{ bass = true })
    -- Контактор освещения (КО)
    self.Train:LoadSystem("KO","Relay","KPP-110")
    self.Train:LoadSystem("KZ1","Relay","DB-982ZH-12")
    self.Train:LoadSystem("KZ2","Relay","DB-982ZH-17")
end

function TRAIN_SYSTEM:Think()
    self.Train.KZ1:TriggerInput("Set",self.Train.Electric.Aux750V > 200 and 1 or 0)
end

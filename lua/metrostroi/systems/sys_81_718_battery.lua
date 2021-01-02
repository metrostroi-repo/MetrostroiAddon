--------------------------------------------------------------------------------
-- 81-718 battery
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_718_Battery")

function TRAIN_SYSTEM:Initialize()
	-- Предохранители цепей (ПА1, ПА2)
	self.Train:LoadSystem("FU1","Relay","PP-28", { trigger_level = 20 }) -- A
	self.Train:LoadSystem("FU2","Relay","PP-28", { trigger_level = 20 }) -- A

	-- Battery parameters
	self.ElementCapacity 	= 80 -- A*hour
	self.ElementCount 		= 56 -- 52 on 81-717
	self.Capacity = self.ElementCapacity * self.ElementCount * 3600
	self.Charge = self.Capacity
	self.Voltage = 65
	-- Current through battery in amperes
	self.Current = 0
end

function TRAIN_SYSTEM:Outputs()
	return { "Capacity", "Charge", "Voltage" }
end

function TRAIN_SYSTEM:Think(dT)
	-- Calculate discharge
	self.Current = 0
	self.Charge = math.min(self.Capacity,self.Charge + self.Current * dT)

	-- Calculate battery voltage
	self.Voltage = 65*(self.Charge/self.Capacity) + (self.Train.BBE.KM1 > 0 and 17 or 0)
end
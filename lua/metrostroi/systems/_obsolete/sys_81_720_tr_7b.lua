--------------------------------------------------------------------------------
-- 81-720 TR-7B
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_720_TR_7B")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	-- Output voltage from contact rail
	self.Main750V = 0.0
end

function TRAIN_SYSTEM:Inputs()
	return { }
end

function TRAIN_SYSTEM:Outputs()
	return { "Main750V"}
end

function TRAIN_SYSTEM:Think(dT)
	-- Don't do logic if train is broken
	if (not IsValid(self.Train.FrontBogey)) or (not IsValid(self.Train.RearBogey)) then
		return
	end

	-- Too high current
	--print( self.Train.AsyncInverter.InverterVoltage*self.Main750V , ">", (750*1000))
	if self.Train.Electric.Utotal*self.Main750V > (750*1000) then
		self.Train:PlayOnce("spark","front_bogey",1.0,math.random(100,150))
		self.Train:PlayOnce("spark","rear_bogey",1.0,math.random(100,150))
	end
	self.Main750V = math.max(self.Train.FrontBogey.Voltage,self.Train.RearBogey.Voltage)
end

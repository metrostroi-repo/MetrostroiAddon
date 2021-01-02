--------------------------------------------------------------------------------
-- "DIP-01K" power supply
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("DIP_01K")

function TRAIN_SYSTEM:Initialize()
	self.XR3 = {
		[2] = 0,
		[3] = 0,
		[4] = 0,
		[5] = 0, -- Out only
		[6] = 0,
		[7] = 0,
	}
	self.XT3_1 = 0 -- General (battery) output
	self.XT3_4 = 0 -- Output for passenger lights
	self.XT1_2 = 0

	self.XT3_1ext = 0 -- External
	self.Active = 0
	self.LightsActive = 0
end

function TRAIN_SYSTEM:Inputs()
	return { "XR3.2", "XR3.3", "XR3.4", "XR3.5", "XR3.6", "XR3.7", "XT3.1" }
end

function TRAIN_SYSTEM:Outputs()
	return { "XT3_1", "XT3_4", "XT1_2" }
end


function TRAIN_SYSTEM:TriggerInput(name,value)
	if name == "XT3.1" then
		self.XT3_1ext = value
	else
		local idx = tonumber(string.sub(name,5,6)) or 0
		if self.XR3[idx] then
			if value > 0.5
			then self.XR3[idx] = 1.0
			else self.XR3[idx] = 0.0
			end
		end
	end
end

function TRAIN_SYSTEM:Think()
	local Train = self.Train

	-- Get high-voltage input
	self.XT1_2 = Train.Electric.Aux750V * Train.KPP.Value * 1 -- P4
	-- Get battery input
	local XT3_1 = self.XT3_1ext

	-- Check if enable signal is present
	if self.XR3[2] > 0 then self.Active = 1 end
	if self.XR3[3] > 0 then self.Active = 0 self.LightsActive = 0 end
	if self.XR3[4] > 0 then self.LightsActive = 1 end
	if self.XR3[6] > 0 then self.Active = 1 end
	if self.XR3[7] > 0 then self.LightsActive = 1 end

	-- Undervoltage/overvoltage
	local voltage_bat = XT3_1
	if (self.XT1_2 > 550) and (self.XT1_2 < 975) then voltage_bat = 75 end
	if voltage_bat < 55 then self.Active = 0 self.LightsActive = 0 end
	if voltage_bat > 85 then self.Active = 0 self.LightsActive = 0 end

	local voltage = 0
	if (self.XT1_2 > 550) and (self.XT1_2 < 975) then voltage = 75 end

	-- Generate output
	self.XT3_1 = voltage * self.Active
	self.XT3_4 = voltage * self.Active
	Train.KPP:TriggerInput("Open",1.0 - self.Active)
end
--------------------------------------------------------------------------------
-- ДУРА (Дополнительная Универсальная Радиоаппаратура)
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("DURA")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.SelectAlternate = nil
	self.Channel = 1
	self.Signal = 0
	self.Power = 1
end

function TRAIN_SYSTEM:Outputs()
	return { "Signal" }
end

function TRAIN_SYSTEM:Inputs()
	return { "SelectAlternate", "SelectMain", "SelectChannel", "ToggleChannel", "Power", "PowerToggle" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
	if (name == "SelectAlternate") and (value > 0.0) then
		self.SelectAlternate = true
		self.TimerToggle = true
	elseif (name == "SelectMain") and (value > 0.0) then
		self.SelectAlternate = false
		self.TimerToggle = true
	elseif (name == "ToggleChannel") and (value > 0.0) then
		if self.Channel == 1 then self.Channel = 2 else self.Channel = 1 end
	elseif (name == "SelectChannel") then
		self.Channel = math.floor(value)
	elseif (name == "PowerToggle") and (value > 0.0) then
		self.Power = not self.Power
    end
end

function TRAIN_SYSTEM:Think()
	-- Require 54 volts
	if self.Train.Battery and (self.Train.Battery.Voltage < 54) then return end
	if not self.Power then return end --or self.Train.ARSType == 3 then return end
	--self.Train:PlayOnce("dura2","cabin",0.4,100)
	-- Check ARS signals
	self.Timer = self.Timer or CurTime()
	if CurTime() - self.Timer > 2.00 or self.TimerToggle then
		self.TimerToggle = nil
		self.Timer = CurTime()

		-- Get train position
		local pos = Metrostroi.TrainPositions[self.Train]
		if pos then pos = pos[1] end

		-- Get all switches in current isolated section
		local no_switches = true
		local signal = 0
		local Alt1, Alt2
		if pos then
			-- Get traffic light in front
			local light = Metrostroi.GetNextTrafficLight(pos.node1,pos.x,pos.forward)
			local function getSignal(base,chan)
				if (chan == 1) and (base == "alt")  and light and light:GetInvertChannel1() then return "main" end
				if (chan == 2) and (base == "alt")  and light and light:GetInvertChannel2() then return "main" end
				return base
			end

			-- Get switches and trigger them all
			local switches = Metrostroi.GetTrackSwitches(pos.node1,pos.x,pos.forward)
			for _,switch in pairs(switches) do
				Alt1 = Alt1 or (switch:GetChannel() == 1 and switch:GetSignal() > 0)
				Alt2 = Alt2 or (switch:GetChannel() == 2 and switch:GetSignal() > 0)
				no_switches = false
				if self.SelectAlternate == true then
					if self.Channel == 1 then switch:SendSignal(getSignal("alt",1),1) end
					if self.Channel == 2 then switch:SendSignal(getSignal("alt",2),2) end
				elseif self.SelectAlternate == false then
					if self.Channel == 1 then switch:SendSignal(getSignal("main",1),1) end
					if self.Channel == 2 then switch:SendSignal(getSignal("main",2),2) end
				end
				signal = math.max(signal,switch:GetSignal())
			end
			
			-- Reset state selection
		end
		if signal > 0 then
			self.Train:PlayOnce("dura1","cabin",0.30,200)
		end
		self.Signal = signal
		self.Channel1Alternate = Alt1
		self.Channel2Alternate = Alt2
		-- If no switches, reset
		if (no_switches or not pos) and (self.SelectAlternate ~= nil) then
			self.Train:PlayOnce("dura2","cabin",0.30,220)
		end
		self.SelectAlternate = nil
	end
end
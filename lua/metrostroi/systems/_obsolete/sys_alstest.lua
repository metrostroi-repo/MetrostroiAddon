--------------------------------------------------------------------------------
-- Статив и приёмные катушки АЛС
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("ALSTest")
TRAIN_SYSTEM.DontAccelerateSimulation = true


function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("F6","Relay","Switch",{ bass = true })
    self.Train:LoadSystem("F5","Relay","Switch",{ bass = true })
    self.Train:LoadSystem("F4","Relay","Switch",{ bass = true })
    self.Train:LoadSystem("F3","Relay","Switch",{ bass = true })
    self.Train:LoadSystem("F2","Relay","Switch",{ bass = true })
    self.Train:LoadSystem("F1","Relay","Switch",{ bass = true })
    self.Train:LoadSystem("NF","Relay","Switch",{ bass = true })
    self.Train:LoadSystem("SpeedAdd","Relay","Switch",{ bass = true })
    self.Train:LoadSystem("SpeedRem","Relay","Switch",{ bass = true })

	self.TriggerNames = {
		"F6",
		"F5",
		"F4",
		"F3",
		"F2",
		"F1",
		"NF",
		"SpeedAdd",
		"SpeedRem",
	}
	self.Triggers = {}
	for k,v in pairs(self.TriggerNames) do
		if self.Train[v] then self.Triggers[v] = self.Train[v].Value > 0.5 end
	end
	self.Speed = 0
	self.Acceleration = 0
	-- ALS state
	self.F1 = 0
	self.F2 = 0
	self.F3 = 0
	self.F4 = 0
	self.F5 = 0
	self.F6 = 0
	self.NoFreq = 1
	self.NoFreqTimer = nil
	self.RealF5 = 1
	self.Speed = 0
	self.SpeedSign = 0
end

function TRAIN_SYSTEM:Outputs()
	return {
	}
end

function TRAIN_SYSTEM:Inputs()
	return {"Enable"}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
	if name == "Enable" then
		self.Enabled = value
	end
end

function TRAIN_SYSTEM:Trigger(name,value)
	local Train = self.Train
	if name == "SpeedAdd" then
		self.Speed = self.Speed + 2.5
		return
	end
	if name == "SpeedRem" then
		self.Speed = self.Speed - 2.5
		return
	end
	if not value then return end
	if name == "F6" then
		self.F6 = 1-self.F6
		return
	end
	if name == "NF" then
		self.F6 = 0
		self.F5 = 0
		self.F4 = 0
		self.F3 = 0
		self.F2 = 0
		self.F1 = 0
		self.NoFreq = 1
		return
	end
	self.F5 = name =="F5" and 1 or 0
	self.F4 = name =="F4" and 1 or 0
	self.F3 = name =="F3" and 1 or 0
	self.F2 = name =="F2" and 1 or 0
	self.F1 = name =="F1" and 1 or 0
	self.NoFreq = 0
end
function TRAIN_SYSTEM:Think(dT)
	local Train = self.Train

	for k,v in pairs(self.TriggerNames) do
		if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
			self:Trigger(v,Train[v].Value > 0.5)
			self.Triggers[v] = Train[v].Value > 0.5
		end
	end
end

--------------------------------------------------------------------------------
-- Токоприёмник контактного рельса (ТР-7Б)
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("TR_7B")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	-- Output voltage from contact rail
	self.Main750V = 0.0

	self.ContactState1 = 0
	self.ContactState2 = 0
	self.ContactState3 = 0
	self.ContactState4 = 0
end

function TRAIN_SYSTEM:Inputs()
	return { }
end

function TRAIN_SYSTEM:Outputs()
	return { "Main750V", "DropByPeople","ContactState1","ContactState2","ContactState3","ContactState4"}
end


function TRAIN_SYSTEM:Think(dT)
	-- Don't do logic if train is broken
	local fB,rB = self.Train.FrontBogey,self.Train.RearBogey
	if (not IsValid(fB)) or (not IsValid(rB)) then
		return
	end

	self.Main750V = 0
	if IsValid(fB) then
		self.Main750V = math.max(self.Main750V,fB.Voltage)
		self.ContactState1 = fB.NextStates[1] and 1 or 0
		self.ContactState2 = fB.NextStates[2] and 1 or 0
	else
		self.ContactState1 = 0
		self.ContactState2 = 0
	end
	if IsValid(rB) then
		self.Main750V = math.max(self.Main750V,rB.Voltage)
		self.ContactState3 = rB.NextStates[1] and 1 or 0
		self.ContactState4 = rB.NextStates[2] and 1 or 0
	else
		self.ContactState3 = 0
		self.ContactState4 = 0
	end
end

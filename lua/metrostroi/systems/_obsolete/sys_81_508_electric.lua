--------------------------------------------------------------------------------
-- Электрические цепи 81-508 и 81-509
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_508_Electric")

function TRAIN_SYSTEM:Initialize()
	self.TrainSolver = "E"
	self.ThyristorController = false

	-- Load all functions from base
	Metrostroi.BaseSystems["Electric"].Initialize(self)
	for k,v in pairs(Metrostroi.BaseSystems["Electric"]) do
		if type(v) == "function" then
			self[k] = v
		end
	end
end

function TRAIN_SYSTEM:Inputs(...)
	return Metrostroi.BaseSystems["Electric"].Inputs(self,...)
end
function TRAIN_SYSTEM:Outputs(...)
	return Metrostroi.BaseSystems["Electric"].Outputs(self,...)
end
function TRAIN_SYSTEM:TriggerInput(...)
	return Metrostroi.BaseSystems["Electric"].TriggerInput(self,...)
end
function TRAIN_SYSTEM:Think(...)
	return Metrostroi.BaseSystems["Electric"].Think(self,...)
end
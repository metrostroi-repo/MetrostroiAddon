--------------------------------------------------------------------------------
-- Пульт для манверовых передвижений вагонов
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PMP")

function TRAIN_SYSTEM:Initialize()
	self.Position = 0
	self.RealPosition = 0

	self.Matrix = {
		{"3",		"4"	},
		{	1,	0,	1	},
		{"9",		"10"},
		{	1,	0,	1	},
		{"5",		"6"	},
		{	1,	0,	0	},
		{"7",		"8"	},
		{	0,	0,	1	},
	}
	
	-- Initialize contacts values
	for i=1,#self.Matrix/2 do
		local v = self.Matrix[i*2-1]
		self[v[1].."-"..v[2]] = 0
	end	
end

function TRAIN_SYSTEM:Inputs()
	return { "Set", "Up", "Down" }
end

function TRAIN_SYSTEM:Outputs()
	return { "Position" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
	-- Change position
	if name == "Set" then
		if (self.Enabled ~= 0) and (math.floor(value) ~= self.Position) then
			local prevPosition = self.Position
			self.Position = math.floor(value)
			
			-- Limit motion
			if self.Position > 1  then self.Position = 1 end
			if self.Position < -1 then self.Position = -1 end
			
			-- Play sounds
			if prevPosition < self.Position then
				local P,R = prevPosition,self.Position
				if P == -1 and R == 0 then self.Train:PlayOnce("kru_0_1", "cabin",0.9) end
				if P == 0 and R == 1 then self.Train:PlayOnce("kru_1_2", "cabin",0.9) end
			end
	
			if prevPosition > self.Position then
				local P,R = prevPosition,self.Position
				if P == 0 and R == -1 then self.Train:PlayOnce("kru_1_0", "cabin",0.9) end
				if P == 1 and R == 0 then self.Train:PlayOnce("kru_2_1", "cabin",0.9) end
			end
		end		
	elseif (name == "Up") and (value > 0.5) then
		self:TriggerInput("Set",self.Position+1)
	elseif (name == "Down") and (value > 0.5) then
		self:TriggerInput("Set",self.Position-1)
	end
end


function TRAIN_SYSTEM:Think()
	local Train = self.Train
	if (self.Enabled == 0) and (self.Position ~= 0) then
		self.Position = 0
		self.Train:PlayOnce("kv1","cabin",0.6)
	end
	
	-- Move controller
	self.Timer = self.Timer or CurTime()
	if ((CurTime() - self.Timer > 0.15) and (self.Position > self.RealPosition)) then
		self.Timer = CurTime()
		self.RealPosition = self.RealPosition + 1
	end
	if ((CurTime() - self.Timer > 0.15) and (self.Position < self.RealPosition)) then
		self.Timer = CurTime()
		self.RealPosition = self.RealPosition - 1
	end
	
	-- Update contacts
	for i=1,#self.Matrix/2 do
		local v = self.Matrix[i*2-1]
		local d = self.Matrix[i*2]
		self[v[1].."-"..v[2]] = d[self.RealPosition+2]
	end
end

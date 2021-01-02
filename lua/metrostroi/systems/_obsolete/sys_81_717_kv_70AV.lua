--------------------------------------------------------------------------------
-- Кулачковый контроллер КВ-70
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("KV_70_AV")

function TRAIN_SYSTEM:Initialize()
	self.Enabled = 1
	self.ControllerPosition = 0
	self.AutodrivePosition = 0
	self.ReverserPosition = 0
	self.RealControllerPosition = 0
	self.ChangeSpeed = 0.10

	self.ReverserMatrix = {
		{"D",		"D1"	},
		{	1,	0,	1		},
		{"10/4",	"C3"	},
		{	0,	0,	1		},
		{"10/4",	"F1"	},
		{	1,	1,	0		},
		{"D4",		"15"	},
		{	1,	0,	1		},
		{"D8",		"15A"	},
		{	0,	1,	0		},
		{"3M35",	"4"		},
		{	0,	0,	1		},
		{"10AK",	"4"		},
		{	1,	0,	0		},
		{"10AK",	"5"		},
		{	0,	0,	1		},
		{"FR1",		"10"	},
		{	1,	0,	1		},
		{"F7",		"10"	},
		{	1,	0,	1		},
	}
	self.ControllerMatrix = {
		{"10",						"8"	},
		{	1,	0,	0,	0,	0,	0,	0	},
		{"U2",						"10AS"},
		{	1,	1,	1,	0,	1,	1,	1	},
		{"0",						"0"	},
		{	0,	0,	0,	1,	0,	0,	0	},
		{"10AK",					"2"	},
		{	1,	1,	0,	0,	0,	1,	1	},
		{"U2",						"3"	},
		{	0,	0,	0,	0,	0,	0,	1	},
		{"0",						"0"	},
		{	0,	0,	0,	1,	1,	1,	1	},
		{"10AS",					"33"},
		{	0,	0,	0,	0,	1,	1,	1	},
		{"10AS",					"33D"},
		{	0,	0,	0,	1,	1,	1,	1	},
		{"U2",						"33G"},
		{	1,	1,	1,	0,	0,	0,	0	},
		{"U2",						"20a"},
		{	0,	0,	0,	0,	1,	1,	1	},
		{"U2",						"25"},
		{	0,	1,	0,	0,	0,	0,	0	},
		{"10AS",					"U4"},
		{	0,	0,	0,	1,	0,	0,	0	},
		{"15A",						"15B"},
		{	1,	1,	1,	1,	0,	0,	0	},
		{"U2",						"20b"},
		{	1,	1,	1,	0,	0,	0,	0	},
	}

	-- Initialize contacts values
	for i=1,#self.ReverserMatrix/2 do
		local v = self.ReverserMatrix[i*2-1]
		self[v[1].."-"..v[2]] = 0
	end
	for i=1,#self.ControllerMatrix/2 do
		local v = self.ControllerMatrix[i*2-1]
		self[v[1].."-"..v[2]] = 0
	end
end

function TRAIN_SYSTEM:Inputs()
	return { "Enabled", "ControllerSet", "ReverserSet",
			 "ControllerUp","ControllerDown","ReverserUp","ReverserDown",
			 "SetX1", "SetX2", "SetX3", "Set0", "Set0Fast", "SetT1", "SetT1A", "SetT2", "ControllerUnlock",
			 "SetAutodrive" }
end

function TRAIN_SYSTEM:Outputs()
	return { "ControllerPosition","RealControllerPosition", "ReverserPosition", "10AS-33","10-8","D4-15","10AK-4","U2-25", "AutodrivePosition"}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
	local prevReverserPosition = self.ReverserPosition
	-- Change position
	if name == "Type" then
		self.Type = math.floor(value)
	elseif name == "Enabled" then
		self.Enabled = math.floor(value)
	elseif name == "ControllerSet" then
		if (self.Enabled ~= 0) and (self.ReverserPosition ~= 0) and (math.floor(value) ~= self.ControllerPosition) then
			local prevControllerPosition = self.ControllerPosition
			self.ControllerPosition = math.floor(value)

			-- Limit motion
			if self.ControllerPosition >  3 then self.ControllerPosition =  3 end
			if self.ControllerPosition < -3 then self.ControllerPosition = -3 end
		end
	elseif name == "ReverserSet" then
		if (self.Enabled ~= 0) and (math.floor(value) ~= self.ReverserPosition) and self.ControllerPosition == 0 then
			local prevReverserPosition = self.ReverserPosition
			self.ReverserPosition = math.floor(value)
			if self.ReverserPosition >  1 then self.ReverserPosition =  1 end
			if self.ReverserPosition < -1 then self.ReverserPosition = -1 end
			if prevReverserPosition ~= self.ReverserPosition then
				if self.ReverserPosition == -1 then self.Train:PlayOnce("revers_0-b","cabin",1) end
				if self.ReverserPosition == 0  then
					if prevReverserPosition == -1 then
						self.Train:PlayOnce("revers_b-0","cabin",1)
					else
						self.Train:PlayOnce("revers_f-0","cabin",1)
					end
				end
				if self.ReverserPosition == 1  then self.Train:PlayOnce("revers_0-f","cabin",1) end
			end
		end
	elseif (name == "ControllerUp") and (value > 0.5) then
		if self.ControllerPosition+1 == 0 and not self.Locker then return end
		self:TriggerInput("ControllerSet",self.ControllerPosition+1)
		self.Timer = CurTime()-self.ChangeSpeed
		self.SecondSound = true
	elseif (name == "ControllerDown") and (value > 0.5) then
		self:TriggerInput("ControllerSet",self.ControllerPosition-1)
		self.Timer = CurTime()-self.ChangeSpeed
		self.SecondSound = true
		elseif (name == "ReverserUp") and (value > 0.5) then
		self:TriggerInput("ReverserSet",self.ReverserPosition+1)
	elseif (name == "ReverserDown") and (value > 0.5) then
		self:TriggerInput("ReverserSet",self.ReverserPosition-1)
	elseif (name == "SetX1") and (value > 0.5) then
		self:TriggerInput("ControllerSet",1)
	elseif (name == "SetX2") and (value > 0.5) then
		self:TriggerInput("ControllerSet",2)
	elseif (name == "SetX3") and (value > 0.5) then
		self:TriggerInput("ControllerSet",3)
	elseif (name == "Set0") and (value > 0.5) then
		self:TriggerInput("ControllerSet",0)
	elseif (name == "Set0Fast") and (value > 0.5) then
		self:TriggerInput("ControllerSet",0)
		self.ChangeSpeed = 0.05
	elseif (name == "SetT1") and (value > 0.5) then
		self:TriggerInput("ControllerSet",-1)
	elseif (name == "SetT1A") and (value > 0.5) then
		self:TriggerInput("ControllerSet",-2)
	elseif (name == "SetT2") and (value > 0.5) then
		self:TriggerInput("ControllerSet",-3)
	elseif (name == "ControllerUnlock") then
		self.Locker = value > 0.5
		if self.Locker then
			self.Train:PlayOnce("kv70_fix_on", "cabin",1)
		else
			self.Train:PlayOnce("kv70_fix_off", "cabin",1)
		end
	elseif name == "SetAutodrive" then
		self.AutodrivePosition = value
	end
end


function TRAIN_SYSTEM:Think()
	local Train = self.Train

	if (self.Enabled == 0) and (self.ReverserPosition ~= 0) then
		self.ReverserPosition = 0
		self.ControllerPosition = 0
	end
	if (self.ReverserPosition == 0) and (self.ControllerPosition ~= 0) then
		self.ReverserPosition = 0
		self.ControllerPosition = 0
	end

	-- Move controller
	self.Timer = self.Timer or CurTime()
	if ((CurTime() - self.Timer > self.ChangeSpeed) and (self.ControllerPosition > self.RealControllerPosition)) then
		local previousPosition = self.RealControllerPosition
		self.Timer = CurTime()
		self.RealControllerPosition = self.RealControllerPosition + 1

		local A,B = previousPosition,self.RealControllerPosition

		if (A == -3) and (B == -2) then self.Train:PlayOnce("kv70_t2_t1a",  "cabin",1) end
		if (A == -2) and (B == -1) then self.Train:PlayOnce("kv70_t1a_t1",  "cabin",1) end
		if self.SecondSound and (A == -1) and (B ==  0) then self.Train:PlayOnce("kv70_t1_0",  "cabin",1) end
		if not self.SecondSound and (A == -1) and (B ==  0) then self.Train:PlayOnce("kv70_t1_0_fix",  "cabin",1) end

		if (A ==  0) and (B ==  1) then self.Train:PlayOnce("kv70_0_x1", "cabin",1) end
		if (A ==  1) and (B ==  2) then self.Train:PlayOnce("kv70_x1_x2", "cabin",1) end
		if (A ==  2) and (B ==  3) then self.Train:PlayOnce("kv70_x2_x3", "cabin",1) end
		self.SecondSound = nil
	end
	if ((CurTime() - self.Timer > self.ChangeSpeed) and (self.ControllerPosition < self.RealControllerPosition)) then
		local previousPosition = self.RealControllerPosition
		self.Timer = CurTime()
		self.RealControllerPosition = self.RealControllerPosition - 1

		local A,B = previousPosition,self.RealControllerPosition
		if (A ==  3) and (B ==  2) then self.Train:PlayOnce("kv70_x3_x2", "cabin",1) end
		if (A ==  2) and (B ==  1) then self.Train:PlayOnce("kv70_x2_x1", "cabin",1) end
		if (A ==  1) and (B ==  0) then self.Train:PlayOnce("kv70_x1_0", "cabin",1) end

		if (A ==  0) and (B == -1) then self.Train:PlayOnce("kv70_0_t1",  "cabin",1) end
		if (A == -1) and (B == -2) then self.Train:PlayOnce("kv70_t1_t1a",  "cabin",1) end
		if (A == -2) and (B == -3) then self.Train:PlayOnce("kv70_t1a_t2",  "cabin",1) end
		self.SecondSound = nil
	end
	if self.RealControllerPosition == 0 then self.ChangeSpeed = 0.10 end
	local position
	if self.AutodrivePosition ~= 0 and self.RealControllerPosition == 0 then
		position = self.AutodrivePosition
	elseif self.AutodrivePosition >= 0 and self.RealControllerPosition ~= 0 then
		position = self.RealControllerPosition
	else
		position = math.min(self.AutodrivePosition,self.RealControllerPosition)
	end
	-- Update contacts
	for i=1,#self.ReverserMatrix/2 do
		local v = self.ReverserMatrix[i*2-1]
		local d = self.ReverserMatrix[i*2]
		self[v[1].."-"..v[2]] = d[self.ReverserPosition+2]
	end
	for i=1,#self.ControllerMatrix/2 do
		local v = self.ControllerMatrix[i*2-1]
		local d = self.ControllerMatrix[i*2]
		self[v[1].."-"..v[2]] = d[(position)+4]
	end
end

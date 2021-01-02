--------------------------------------------------------------------------------
-- АРС-АЛС (модифицированная версия для составов Еж)
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("ARS_EZh3")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.Train:LoadSystem("ALSCoil")
	self.Train:LoadSystem("EPKContacts","Relay","",{close_time = 3})
	self.Alarm = false
	-- Internal state
	self.SpeedLimit = 0
	self.NextLimit = 0
	self.Ring = false
	self.Overspeed = false
	self.ElectricBrake = false
	self.PneumaticBrake1 = false
	self.PneumaticBrake2 = true
	self.AttentionPedal = false
	self.KVT = false
	self.LN = false
	self.IgnoreThisARS = false

	-- ARS wires
	self["33D"] = 0
	self["33G"] = 0
	self["33Zh"] = 0
	self["2"] = 0
	self["6"] = 0
	self["8"] = 0
	self["20"] = 0
	--self["21"] = 0
	self["29"] = 0
	self["31"] = 0
	self["32"] = 0

	-- Lamps
	---self.LKT = false
	self.LVD = false
end

function TRAIN_SYSTEM:Outputs()
	return { "2", "8", "20", "29", "33D", "33G", "33Zh",--"31", "32",
			 "Speed", "SpeedLimit", "Ring"}
end

function TRAIN_SYSTEM:Inputs()
	return { "IgnoreThisARS","AttentionPedal","Ring" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
	local Train = self.Train
	if name == "AttentionPedal" then
		self.AttentionPedal = value > 0.5
		if Train and Train.PB then
			Train.PB:TriggerInput("Set",value)
		end
	end
	if name == "IgnoreThisARS" then
		self.IgnoreThisARS = value > 0.5
	end
	if name == "Ring" then
		self.RingOverride = value > 0.5
	end
end



function TRAIN_SYSTEM:Think(dT)
	local Train = self.Train
	local ALS = Train.ALSCoil
	local speed = ALS.Speed
	--if GetConVarNumber("metrostroi_ars_printnext") == Train:EntIndex() then print(Train:ReadCell(49165)) end


	-- ALS, ARS state
	local power = Train.VB.Value > 0
	local KRUEnabled =  Train.KRU and Train.KRU["14/1-B3"] > 0
	local RVForward = power and (Train.KV["D4-15"] > 0 or KRUEnabled)
	local EnableARS = Train.VB.Value == 1.0 and Train.ARS.Value == 1.0 and RVForward
	local EnableALS = Train.VB.Value == 1.0 and Train.ALS.Value == 1.0 and RVForward
	if EnableALS ~= (ALS.Enabled==1) then
		ALS:TriggerInput("Enable",EnableALS and 1 or 0)
	end

	self.EnableARS = EnableARS
	self.EnableALS = EnableALS
	local EPKActivated = Train.EPK and Train.EPK.Value > 0.5 and Train.DriverValveBLDisconnect.Value > 0.5
	-- Pedal state
	local PB = Train.PB.Value > 0.5 or Train.KB.Value > 0.5
	self.KVT = Train.KVT.Value > 0.5
	if PB and not self.AttentionPedal then
		self.AttentionPedal = true
	end
	if not PB and self.AttentionPedal then
		self.AttentionPedal = false
	end

	-- Ignore pedal
	if self.IgnorePedal and self.AttentionPedal then
		self.AttentionPedal = false
	else
		self.IgnorePedal = false
	end
	-- Speed check and update speed data
	if CurTime() - (self.LastSpeedCheck or 0) > 0.5 then
		self.LastSpeedCheck = CurTime()
		--self.Speed = (Train.Speed or 0) --FIXME
	end
	--if RVForward then
		self.NoFreq = ALS.NoFreq
		self.F1 = ALS.F1*(1-self.NoFreq)
		self.F2 = ALS.F2*(1-self.NoFreq)
		self.F3 = ALS.F3*(1-self.NoFreq)
		self.F4 = ALS.F4*(1-self.NoFreq)
		self.F5 = ALS.F5*(1-self.NoFreq)
		self.F6 = ALS.F6*(1-self.NoFreq)
		self.RealF5 = self.F5*(1-(self.F4+self.F3+self.F2+self.F1))
		if EnableARS then self.NoFreq = self.NoFreq + (1-math.min(1,self.F5+self.F4+self.F3+self.F2+self.F1+self.NoFreq)) end
	--end


	if EnableALS then
		local V = math.floor(speed +0.05)
		local Vlimit = 20
		local VLimit2
		if self.F4 > 0 then Vlimit = 40 end
		if self.F3 > 0 then Vlimit = 60 end
		if self.F2 > 0 then Vlimit = 70 end
		if self.F1 > 0 then Vlimit = 80 end

		--if (    self.KVT) and (Vlimit ~= 0) and (V > Vlimit) then self.Overspeed = true end
		--if (    self.KVT) and (Vlimit == 0) and (V > 20) then self.Overspeed = true end
		--if (not self.KVT) and (V > Vlimit) and (V > (self.RealNoFreq and 0 or 3)) then self.Overspeed = true end
		--if (    self.KVT) and (Vlimit == 0) and self.Train.ARSType and self.Train.ARSType == 3 and not self.Train["PA-KSD"].VRD then self.Overspeed = true end
		--self.Ring = self.Overspeed and (speed > 5)

		-- Determine next limit and current limit
		self.SpeedLimit = VLimit2 or Vlimit--+0.5
	else
		local V = math.floor(speed +0.05)
		self.SpeedLimit = 0
	end


	if EnableARS then
		if self.EnableARS ~= EnableARS then Train.EPKContacts:TriggerInput("Set",Train.EPKContacts.Value) end
		local SpeedLimit = self.SpeedLimit
		if self.AttentionPedal then SpeedLimit = 20 end

		-- Check absolute stop
		if self.NoFreq > 0 and not self.PrevNoFreq then --and Train:ReadTrainWire(6) < 1 then
			self.IgnorePedal = true
		end
		if self.F5 > 0 and not self.PrevF5 then --and Train:ReadTrainWire(6) < 1 then
			self.IgnorePedal = self.PrevNoFreq
		end
		self.PrevNoFreq = self.NoFreq > 0
		self.PrevF5 = self.F5 > 0
		-- Check overspeed
		if speed > SpeedLimit and not self.ElectricBrake then
			self.ElectricBrake = true
			self.BSpeedLimit = SpeedLimit
			self.RVV = nil
		end
		if self.BSpeedLimit and speed < self.BSpeedLimit-4 and self.ElectricBrake and not self.ARSBrake then
			self.ElectricBrake = false
			self.RVV = CurTime()
		end
		if self.RVV and CurTime()-self.RVV > 8 then
			self.ARSBrake = true
			self.ElectricBrake = true
			self.RVV = nil
		end
		if  speed < SpeedLimit and self.ElectricBrake and not self.ARSBrake and self.KVT then
			self.RVV = nil
			self.ElectricBrake = false
		end
		if self.KVT and self.RVV then
			self.RVV = nil
		end

		if self.BSpeedLimit and SpeedLimit < self.BSpeedLimit then self.BSpeedLimit = SpeedLimit end

		if (not self.BSpeedLimit or speed < self.BSpeedLimit) and self.ElectricBrake and self.KVT then
			self.ARSBrake = false
			self.ElectricBrake = false
			self.PneumaticBrake2 = false
		end
		if (Train.KV["10AS-33"] > 0 and self.AntiRolling or Train:ReadTrainWire(31)> 0 or Train:ReadTrainWire(32) > 0 or Train:ReadTrainWire(12) > 0) and speed < 10 then
			self.AntiRolling = false
			self.RO = true
			self.ROBlock = Train.KV["10AS-33"] > 0
		end
		if self.ROBlock and Train.KV["10AS-33"] <= 0 then self.ROBlock = false end
		--[[
		if self.Speed <= 5.5 and not self.AntiRolling and not self.RO then
			self.AntiRolling = CurTime()
		end
		if self.Speed < 3 and Train:ReadTrainWire(6) > 0 and not self.RO and not self.AntiRolling then
			self.AntiRolling = CurTime()-8
		end]]
		if speed < 3 and not self.RO and not self.AntiRolling and self.NoFreq == 0 then
			self.AntiRolling = CurTime()-8
		end
		if self.AntiRolling and speed > 5.5 then
			self.AntiRolling = false
		end
		if not self.ROBlock and (Train.KV["10AS-33"] > 0 or self.AttentionPedal and not self.AttentionPedalRO) and self.RO == true then
			self.PneumaticBrake1 = false
			self.AttentionPedalRO = true
			self.RO = CurTime()
			if self.AntiRolling and CurTime()-self.AntiRolling > 8 then self.AntiRolling = false end
		end
		if self.AttentionPedalRO and not self.AttentionPedal then self.AttentionPedalRO = false end
		if self.RO and self.RO ~= true and (speed > 5.5 or CurTime()-self.RO > 7 or self.NoFreq > 0) then
			self.AntiRolling = speed <= 5.5 and CurTime()-8 or false
			if not self.ElectricBrake and not self.PneumaticBrake2 and self.AntiRolling and not self.AttentionPedal then
				Train.EPKContacts:TriggerInput("Open",1)
			end
			self.RO = false
		end
		if self.RO and self.RO ~= true and self.AttentionPedal then self.RO = false end
		if self.AntiRolling and self.AttentionPedal then self.AntiRolling = false end
		--[[
		-- Check use of valve #1 during overspeed
		--self.PV1Timer = self.PV1Timer or -1e9
		if self.PV1Timer and ((CurTime() - self.PV1Timer) >= 1) then
			if self.Overspeed then
				self.ElectricBrake = true
				if self.Speed <= 5 then
				    self.PneumaticBrake2 = true
				end
			else
				self.PneumaticBrake1 = false
			end
			self.PV1Timer = nil
		end]]
		local ElectricBrake = (self.ElectricBrake or self.AntiRolling and CurTime()-self.AntiRolling > 8)

		if (ElectricBrake or self.PN2Timer == false) and not self.PN2Timer then
			self.PN2Timer = CurTime()
		elseif not ElectricBrake and self.PN2Timer then
			self.PN2Timer = nil
		end
		local delay
		if 60 < speed then
			delay = 3.6--3.2
		elseif 30 < speed then
			delay = 4.2--3.9
		elseif 20 < speed then
			delay = 5.2
		else
			delay = 7.9
		end
		if (ElectricBrake or speed < 0.2 and not self.AttentionPedal) and Train:ReadTrainWire(34) == 0 then
			if not self.EPKTimer then self.EPKTimer = CurTime() end
		else
			self.EPKTimer = nil
		end
		if self.EPKTimer and CurTime()-self.EPKTimer > delay then Train.EPKContacts:TriggerInput("Open",1) end
		-- ARS signals
		local Ebrake, Abrake, Pbrake1,Pbrake2 =
			(ElectricBrake and 1 or 0),
			((ElectricBrake or self.RO==true)  and 1 or 0),
			--((self.SpeedLimit == 0 and not self.KVT and not self.ARSBrake) and 1 or 0),
			(self.RO == true and 1 or 0),
			((self.PneumaticBrake2 or self.PN2Timer and CurTime()-self.PN2Timer > 2.7 or SpeedLimit <= 20.5 and not self.AttentionPedal) and 1 or 0)
		-- Apply ARS system commands
		self["33D"] = (1 - Abrake)
		self["33G"] = Ebrake
		self["33Zh"] = (1 - Abrake)
		self["2"] = Ebrake
		self["20"] = Ebrake
		self["29"] = Pbrake1
		self["8"] = Pbrake2
		--print(self.ElectricBrake , self.AntiRolling,self.ARSBrake,self.RO,self.BSpeedLimit,Train:ReadTrainWire(2),Train:ReadTrainWire(8))
		self.LVD = math.min(1,self.LVD+self["33G"])
		if Train:ReadTrainWire(6) < 1 and self["33G"] < 0.5  then  self.LVD = 0 end
		self.Ring = self.ARSBrake and 1 or 0
		--[[
		торможении от АРС ЭПВ имеет 4 ступени задержки по времени на срабатывание:
		80-60 км/ч - 3с (округлённо)
		60-30 км/ч - 4с
		30-20 км/ч - 5с
		менее 10 км/ч - 8с
		if self.ElectricBrake or self.PneumaticBrake2 then
			if not self.LKT and not self.EPKTimer then
				self.EPKTimer = CurTime() + ((10 <= self.Speed and self.Speed <= 30) and 5.5 or 3.3)
			elseif self.LKT then
				self.EPKTimer = nil
			end
		else
			self.EPKTimer = nil
		end
		--if self.BPSActive then self.AntiRolling = false end
		if EPKActivated and not self.LKT and self.Speed < 0.05 and Train:ReadTrainWire(1) == 0 then -- or (self.AntiRolling and Train:ReadTrainWire(1) > 0) then
			if not self.EPKTimer2 then
				self.EPKTimer2 = CurTime()+1
			end
			if self.EPKTimer2 and CurTime() - self.EPKTimer2 > 0 and not Train.Pneumatic.EmergencyValveEPK then
				Train.Pneumatic.EmergencyValveEPK = true

				RunConsoleCommand("say","EPV braking (LKT off when stopped)",Train:GetDriverName())
				self.BeOffARS = nil
			end
		else
			self.EPKTimer2 = nil
		end]]
	else
		if Train.EPK.Value == 0 then Train.EPKContacts:TriggerInput("Set",1) end
		self.ElectricBrake = true
		self.ARSBrake = true
		self.RO = true
		self.PneumaticBrake2 = false
		self.AntiRolling = false
		self.BSpeedLimit = nil
		self.PN2Timer = false
		self["33D"] = 0
		self["33Zh"] = 1
		self["8"] = KRUEnabled and (1-Train.RPB.Value) or 0
		self["33G"] = 0
		self["2"] = 0
		self["20"] = 0
		self["29"] = 0

		---self.LKT = false
		self.LVD = 0
		self.Ring = 0
	end
	-- ARS signalling train wires
	if EnableARS then
		self.Train:WriteTrainWire(21,self.LVD)-----self.LKT and 1 or 0)
	else--if not EnableUOS then
		self.Train:WriteTrainWire(21,0)
	end
	-- RC1 operation
	if self.Train.RC1.Value == 0 then
		self["33D"] = 1
		self["33G"] = 0
		self["33Zh"] = 1--KAH
		--
		self["2"] = 0
		self["20"] = 0
		self["29"] = 0
		--
		self["31"] = 0
		self["32"] = 0
		self["8"] = KRUEnabled and (1-Train.RPB.Value) or 0
	end
	if Train.RV_2 then Train.RV_2:TriggerInput("Set",EnableARS and 1 or 0) end
	if (Train.Pneumatic and Train.Pneumatic.EmergencyValve) or self.UAVAContacts then self["33D"] = 0 end
	if Train.UAVAContact.Value > 0.5 and not Train.Pneumatic.EmergencyValve and self.UAVAContacts then
		self.UAVAContacts = nil
		Train:PlayOnce("uava_reset","bass",1)
	end
	local EPKActivated = Train.Pneumatic.EPKEnabled or Train.RC1.Value == 0
	if not EPKActivated or Train.EPKContacts.Value == 0 then
		self["33D"] = 0
	end
	--self.Ring = self.Ring and 1 or 0
	if Train.Rp8 then Train.Rp8:TriggerInput("Set",self["8"] + (1-self.Train.RC1.Value)*(1-self["33D"]))end
	--self.Ring = self.RingOverride or self.Ring
	Train.RPB:TriggerInput("Set",(self.Train.PB.Value + self.Train.KVT.Value + self.Train.RV_2.Value)*self.Train.VB.Value)
    Train:WriteTrainWire(34,Train.RKTT.Value+Train.DKPT.Value)
end

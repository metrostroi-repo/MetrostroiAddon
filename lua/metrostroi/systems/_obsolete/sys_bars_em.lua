--------------------------------------------------------------------------------
-- БАРС для Ем
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("BARS_Em")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.Train:LoadSystem("VRD","Relay","Switch", {av = true})
	self.Train:LoadSystem("RC2","Relay","Switch", {bass = true,normally_closed = true })
	-- ALS state
	self.Signal80 = false
	self.Signal70 = false
	self.Signal60 = false
	self.Signal40 = false
	self.Signal0 = false
	self.Special = false
	self.NoFreq = true
	self.RealNoFreq = true
	self.Alarm = false
	self.CheckedNF = 2

	-- Internal state
	self.Speed = 0
	self.SpeedLimit = 0
	self.NextLimit = 0
	self.Ring = false
	self.Overspeed = false
	self.ElectricBrake = false
	self.PneumaticBrake1 = false
	self.PneumaticBrake2 = true
	self.AttentionPedal = false
	self.KVT = false

	-- ARS wires
	self["33D"] = 0
	self["33G"] = 0
	self["33Zh"] = 1
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
	self.EPK = {}
end

function TRAIN_SYSTEM:Outputs()
	return { "2", "8", "20", "31", "32", "29", "33D", "33G", "33Zh",
			 "Speed", "Signal80","Signal70","Signal60","Signal40","Signal0","Special","NoFreq","RealNoFreq",
			 "SpeedLimit", "NextLimit","Ring","KVT","EnableARS","EnableALS","Signal", "UAVA"}
end

function TRAIN_SYSTEM:Inputs()
	return { "AttentionPedal","Ring" }
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

function TRAIN_SYSTEM:EPVBrake(reason,imm)
	if not self.EPK[reason] and not self.EPKOffTimer and not self.EPKActTimer then
		if imm then
			self.EPK[reason] = CurTime() - 1
		else
			self.EPK[reason] = CurTime() + ((10 <= self.Speed and self.Speed <= 30) and 5.5 or 3.3)
		end
	end
end

function TRAIN_SYSTEM:EPVDisableBrake(reason)
	if self.EPK[reason] then
		self.EPK[reason] = nil
	end
end
function TRAIN_SYSTEM:Think(dT)
	local Train = self.Train
	--if GetConVarNumber("metrostroi_ars_printnext") == Train:EntIndex() then print(Train:ReadCell(49165)) end
	self.LKT = true
	for i,train in ipairs(Train.WagonList) do
		--print(i,train.RKTT.Value,self["33G"],train.DKPT.Value)
		--if (train.RKTT and train.RKTT.Value < 0.5 and train.DKPT.Value < 0.5 and self["33G"] > 0) or (train.DKPT and train.DKPT.Value < 0.5 and self["33G"] == 0) then
		if (train.RKTT and train.RKTT.Value < 0.5 and train.DKPT.Value < 0.5) then-- or (train.DKPT and train.DKPT.Value < 0.5) then
			self.LKT = false
		end
	end

	-- ALS, ARS state
	local KRUEnabled =  Train.KRU and Train.KRU.Position > 0
	local EnableARS = Train.VB.Value == 1.0 and (Train.KV.ReverserPosition ~= 0.0 or KRUEnabled) and Train.VBA.Value == 1.0
	local EnableALS = Train.VB.Value == 1.0

	self.EnableARS = EnableARS
	self.EnableALS = EnableALS
	local EPKActivated = Train.EPK.Value > 0.5 and (Train.Pneumatic.ValveType == 2 and Train.DriverValveDisconnect.Value > 0.5 or Train.DriverValveBLDisconnect.Value > 0.5)
	if not self.EPKActivated and EPKActivated then
		self.EPKActivated = EPKActivated
	end
	if EPKActivated and self.EPKActTimer then
		self.EPKActTimer = nil
	end
	if not EPKActivated and self.EPKActivated and not self.EPKActTimer then
		self.EPKActTimer = CurTime() + 3
	end
	if self.EPKActTimer and CurTime() - self.EPKActTimer > 0 then
		self.EPKActivated = false
		--self.EPKBrake = false
		for k,v in pairs(self.EPK) do
			self.EPK[k] = nil
		end
	end

	local PB = Train.PB and Train.PB.Value > 0.5
	if PB and not self.AttentionPedalTimer and not self.Overspeed then
		self.AttentionPedalTimer = CurTime() + 1
	end

	if PB and self.AttentionPedalTimer and (CurTime() - self.AttentionPedalTimer) > 0  then
		self.AttentionPedal = true
	end
	if not PB and (self.AttentionPedalTimer or self.AttentionPedal) then
		self.AttentionPedal = false
		self.AttentionPedalTimer = nil
	end
	if PB or (Train.KVT) and Train.KVT.Value > 0.5 then self.KVT = true end
	if not PB and (Train.KVT) and Train.KVT.Value < 0.5 then self.KVT = false end

	-- Ignore pedal
	if self.IgnorePedal and self.KVT then
		self.KVT = false
	else
		self.IgnorePedal = false
	end

	-- Speed check and update speed data
	if CurTime() - (self.LastSpeedCheck or 0) > 0.5 then
		self.LastSpeedCheck = CurTime()
		self.Speed = (Train.Speed or 0)
	end

	if (Train.UAVA and Train.SpeedSign and Train.SpeedSign > 0 and self.Speed > 0.25) or EnableALS then
		local ars,arsback
		self.Timer = self.Timer or CurTime()
		if CurTime() - self.Timer > 1.00 then
			self.Timer = CurTime()
			-- Get train position
			local pos = Metrostroi.TrainPositions[Train] --Metrostroi.GetPositionOnTrack(Train:GetPos(),Train:GetAngles()) --(this metod laggy for dir checks)
			if pos then pos = pos[1] end
			-- Get previous ARS section
			if pos then
				ars,arsback = Metrostroi.GetARSJoint(pos.node1,pos.x,Metrostroi.TrainDirections[Train], Train)
			end

			if Train.UAVA and Train.SpeedSign > 0 then
				if IsValid(arsback) then
					if arsback == self.AutostopSignal then
						Train.Pneumatic.EmergencyValve = not Train.Pneumatic.UAVA
						self.UAVAContacts = not Train.Pneumatic.UAVA
						self.AutostopSignal = nil
						if not Train.Pneumatic.UAVA then
							RunConsoleCommand("say","Autostop braking",Train:GetDriverName(),arsback.Name)
						end
						if not IsValid(Train.FrontTrain) or not IsValid(Train.RearTrain)then
							RunConsoleCommand("say","Passed stop signal",Train:GetDriverName(),arsback.Name)
							local ply,mode = Train:GetDriverPly()
							hook.Run("MetrostroiPassedRed",Train,ply,mode,arsback.Name)
						end
					end
				end
				if IsValid(ars) then
					if ars.AutoEnabled then
						self.AutostopSignal = ars
						--print("enty")
					elseif self.AutostopSignal == ars then
						self.AutostopSignal = nil
						--print("entn")
					end
				end
			end
			if Train:ReadTrainWire(5) < 1 or self.Train.VU.Value < 0.5 then
				ars = nil
				self.RealNoFreq = true
				self.NoFreq = true
				self.CheckedNF = 2
			end

			if IsValid(ars) then
				self.CheckedNF = 0
				self.Alert = nil
				self.Signal80	= ars:GetARS(8,Train)
				self.Signal70	= ars:GetARS(7,Train)
				self.Signal60	= ars:GetARS(6,Train)
				self.Signal40	= ars:GetARS(4,Train)
				self.Signal0	= ars:GetARS(0,Train) or ars:GetARS(2,Train)
				self.Special	= ars:Get325HzAproove0() and not ars:GetARS(2,Train)
				self.NoFreq		= ars:GetARS(1,Train) or not (self.Signal80 or self.Signal70 or self.Signal60 or self.Signal40 or self.Signal0)
				if GetConVarNumber("metrostroi_ars_printnext") == Train:EntIndex() then RunConsoleCommand("say",ars.Name,tostring(arsback and arsback.Name),tostring(ars.NextSignalLink and ars.NextSignalLink.Name or "unknown"),tostring(pos.node1.path.id),tostring(Metrostroi.TrainDirections[Train])) end
				self.RealNoFreq = not (self.Signal80 or self.Signal70 or self.Signal60 or self.Signal40 or self.Signal0)
			else
				if GetConVarNumber("metrostroi_ars_printnext") == Train:EntIndex() then RunConsoleCommand("say","LOSE SIGNAL",tostring(pos and pos.node1.path.id or "unknown"),tostring(Metrostroi.TrainDirections[Train])) end
				if (self.CheckedNF  and self.CheckedNF > 1) or (self.CheckedNF == 0 and self.NoFreq) or self.RealNoFreq then
					self.Alert = nil
					self.Signal80 = false
					self.Signal70 = false
					self.Signal60 = false
					self.Signal40 = false
					self.Signal0 = false
					self.Special = false
					self.NoFreq = true
					self.RealNoFreq = true
					self.CheckedNF = 2
				else
					if not self.CheckedNF then self.CheckedNF = 0 end
					self.CheckedNF = self.CheckedNF + 1
					self.NoFreq = true
					self.Alert = CurTime() + 0.5
				end
			end
			self.Signal = ars
		end
	end
	-- Check ARS signals
	if not EnableALS --[[or EnableUOS]] then
		self.Signal80 = false
		self.Signal70 = false
		self.Signal60 = false
		self.Signal40 = false
		self.Signal0 = false
		self.Special = false
		self.NoFreq = EnableARS
		self.RealNoFreq = EnableARS
		self.CheckedNF = 2
		self.Alert = nil
	end

	-- ARS system placeholder logic
	if EnableALS then
		local V = math.floor(self.Speed +0.05)
		local Vlimit = 0
		if self.Signal40 then Vlimit = 40 end
		if self.Signal60 then Vlimit = 60 end
		if self.Signal70 then Vlimit = 70 end
		if self.Signal80 then Vlimit = 80 end

		self.Overspeed = false
		if self.AttentionPedal then
			Vlimit = 0
		end
		if (    self.KVT) and (Vlimit ~= 0) and (V > Vlimit) then self.Overspeed = true end
		if (    self.KVT) and (Vlimit == 0) and (V > 20) then self.Overspeed = true end
		Vlimit = Vlimit + 2
		if (not self.KVT) and (V > Vlimit) and (V > (self.RealNoFreq and 0 or 3)) then self.Overspeed = true end

		-- Determine next limit and current limit
		self.SpeedLimit = Vlimit
		self.NextLimit = Vlimit
		if self.Signal80 then self.NextLimit = 80 end
		if self.Signal70 then self.NextLimit = 70 end
		if self.Signal60 then self.NextLimit = 60 end
		if self.Signal40 then self.NextLimit = 40 end
		if self.Signal0  then self.NextLimit =  0 end

		if not EnableARS then
			self.ElectricBrake = false
			self.PneumaticBrake1 = false
			self.PneumaticBrake2 = false
		end
	else
		local V = math.floor(self.Speed +0.05)
		self.SpeedLimit = 0
		self.NextLimit = 0
		self.Overspeed = false
		if not self.KVT and V > 0 then self.Overspeed = true end
		if (    self.KVT) and (V > 20) then self.Overspeed = true end
	end
	------------------
	if self.SpeedLimit > 20 then self.SpeedLimit = self.SpeedLimit - 2 end
	if EnableARS then
		if self.ElectricBrake1 and self.ARSBrake and not (self.RealNoFreq and not self.KVT and not self.ARSBrake) then
			if self.ARSBrakeTimer == nil then self.ARSBrakeTimer = CurTime() + 5 end
		else
			self.ARSBrakeTimer = nil
		end

		if self.RealNoFreq and (not self.PrevNoFreq) and Train:ReadTrainWire(6) < 1 then
			self.IgnorePedal = true
		end
		self.PrevNoFreq = self.RealNoFreq
		-- Check overspeed
		if self.SpeedLimit > 20 then
			if self.Speed >= self.SpeedLimit + 1 then
				 if Train:ReadTrainWire(6) == 0 then
					self.ElectricBrake = true
					self.PneumaticBrake1 = true
				end
				self.ElectricBrake1 = true
				self.ARSBrake = true
			end
		end
		if self.Overspeed then
			self.ARSBrake = true
			self.ElectricBrake1 = true
			self.ElectricBrake = true
			self.PneumaticBrake1 = true
		end
		-- Check cancel of overspeed command
		if not self.Overspeed and not self.ElectricBrake1 and self.ARSBrake then
			self.PneumaticBrake1 = false

		end
		if (self.KVT or not self.ARSBrakeTimer) and (self.Speed < self.SpeedLimit - 1 and self.SpeedLimit > 20 or self.SpeedLimit < 20 and not self.Overspeed) and (self.ElectricBrake or self.ARSBrake) then
			self.ElectricBrake = false
			self.ElectricBrake1 = false
			self.ARSBrake = false
			self.PneumaticBrake1 = false
			self.PneumaticBrake2 = false
		end
		if self.Speed < self.SpeedLimit - 1 and (self.ARSBrake or self.ElectricBrake1) and not self.ElectricBrake then
			self.ARSBrake = false
			self.ElectricBrake1 = false
		end
		--print(Train:GetPackedBool(131))
		-- Check use of valve #1 during overspeed
		if self.ARSBrake and self.ElectricBrake1 and self.Speed < 0.25 then
			self.PneumaticBrake2 = true
		end

		if self.Speed < 0.25 then
 			self.PneumaticBrake1 = true
		end
		-- Parking brake limit
		local BPSWorking = Train:ReadTrainWire(5) > 0
		if BPSWorking then
			if self.Nakat ~= nil then
				self.PneumaticBrake1 = true
				self.AntiRolling = self.Nakat and true or nil
				self.Nakat = nil
			end
			if self.Speed*Train.SpeedSign < -0.5 then
				if not self.Meters then self.Meters = 0 end
				self.Meters = self.Meters + self.Speed/3600*1000*dT
				if self.Meters > 0.5 + (Train:ReadTrainWire(1) > 0 and 2.5 or 0) then
					self.AntiRolling = true
				end
			else
				if Train.KV.ControllerPosition <= 0 and self.AntiRolling then
					self.AntiRolling = false
				end
				if Train.KV.ControllerPosition > 0 and self.AntiRolling == false then
					self.AntiRolling = nil
				end
				self.Meters = nil
			end
		else
			self.AntiRolling = nil
		end

		--BPS Logic
		if not BPSWorking then
			self.StoppedOnSlopeByRP = false
			self.BPSActive = false
		end

		-- Check cancel pneumatic brake 1 command
		if ((Train:ReadTrainWire(1) > 0) or (Train.RRP and Train.RRP.Value > 0 and not self.ElectricBrake1)) then
			if (Train:ReadTrainWire(1) > 0 or (Train.RRP and Train.RRP.Value > 0 and not self.ElectricBrake1)) and self.PneumaticBrake1 and not self.Overspeed then
				self.PneumaticBrake1 = false
			end
		end
		if self.Signal0 and not self.Special and not self.RealNoFreq and not self.Signal40 and not self.Signal60 and not self.Signal70 and not self.Signal80 then
			if not self.NonVRD and self.Train.VRD.Value < 0.5 then
				self.VRDTimer = nil
			end

			self.NonVRD = self.Train.VRD.Value < 0.5
			if self.NonVRD then
				if self.VRDTimer and CurTime() - self.VRDTimer > 0 then
					self.VRDTimer = false
				elseif self.VRDTimer ~= false then
					if not self.VRDTimer and self.KVT then self.VRDTimer = CurTime() + 1 end
					if self.VRDTimer and not self.KVT then self.VRDTimer = nil end
				end
			else
				self.VRDTimer = false
			end
		else
			if self.NonVRD then self.NonVRD = false end
			self.VRDTimer = false
		end

		-- ARS signals
		local Ebrake, Abrake, NFBrake, Pbrake1,Pbrake2 =
			((self.ElectricBrake) and 1 or 0),
			((self.ARSBrake)  and 1 or 0),
			((self.SpeedLimit < 20 and not self.KVT and not self.ARSBrake) and 1 or 0),
			(self.PneumaticBrake1 and 1 or 0),
			(self.PneumaticBrake2 and 1 or 0)
		-- Apply ARS system commands
		self["33D"] = (1 - Abrake) *(1-NFBrake)*((self.NonVRD or self.VRDTimer ~= false or self.ElectricBrake1 or self.AntiRolling ~= nil) and 0 or 1) --*(2 - Pbrake2)
		self["33G"] = Ebrake + NFBrake + ((self.NonVRD or self.VRDTimer ~= false) and 1 or 0)
		self["33Zh"] = (1 - Abrake)*(1-NFBrake)*((self.NonVRD or self.VRDTimer ~= false or self.ElectricBrake1 or self.AntiRolling ~= nil) and 0 or 1)--*(2 - Pbrake2)
		--print(self["33Zh"])
		self["2"] = Ebrake + NFBrake + ((self.NonVRD or self.VRDTimer ~= false) and 1 or 0)
		self["20"] = Ebrake + NFBrake + ((self.NonVRD or self.VRDTimer ~= false) and 1 or 0)
		self["29"] = Pbrake1-- + (self.BPSActive and 1 or 0)
		--print(Train.Speed)
		--if GetConVarNumber("metrostroi_ars_printnext") == Train:EntIndex() then print(self.SpeedLimit,self.self.SpeedLimit <= 20 and not self.KVT) end
		--if StPetersburg then print(self.Train:EntIndex()) end
		self["8"] = Pbrake2
			+ (KRUEnabled and 1 or 0)*Ebrake
			+ ((self.SpeedLimit < 20 and not self.KVT or self.Speed > 20 and self.SpeedLimit < 20) and 1 or 0)
			+ (self.BPSActive and 1 or 0)
			+ (self.AntiRolling ~= nil and 1 or 0)
			+ (1 - ((self.EPKActivated and 1 or 0) or 1))

		---self.LKT = (self["33G"] > 0.5) or (self["29"] > 0.5) or (Train:ReadTrainWire(35) > 0)
		self.LVD = self.LVD or self["33D"] < 0.5
		if Train:ReadTrainWire(6) < 1 and self["33D"] > 0.5  then  self.LVD = false end
		self.Ring = ((self["33D"] < 0.5 and ((NFBrake < 1 and self.ARSBrakeTimer ~= nil and self.ARSBrakeTimer ~= false) or self.VRDTimer ~= false)) or self.KSZD)
		if self.ElectricBrake or self.PneumaticBrake2 then
			if not self.LKT then
				self:EPVBrake("LKT not light-up when ARS stopping")
			else
				self:EPVDisableBrake("LKT not light-up when ARS stopping")
			end
		else
			self:EPVDisableBrake("LKT not light-up when ARS stopping")
		end
		if self.KVT and self.ARSBrakeTimer then self.ARSBrakeTimer = false end
		if self.EPKActivated and not self.LKT and self.Speed < 0.05 and Train:ReadTrainWire(1) == 0 then -- or (self.AntiRolling ~= nil and Train:ReadTrainWire(1) > 0) then
			self:EPVBrake("LKT off when stopped")
		else
			self:EPVDisableBrake("LKT off when stopped")
		end
	else
		if (Train.RPB) and not self.AttentionPedal then
			--Train.RPB:TriggerInput("Open",1)
		end
		self.AntiRolling = nil
		self.ElectricBrake1 = true
		self.ElectricBrake = true
		self.PneumaticBrake1 = false
		self.PneumaticBrake2 = true
		self.ARSBrake = true
		self["33D"] = 0
		self["33Zh"] = 1
		self["8"] = KRUEnabled and (1-Train.RPB.Value) or 0
		self["33G"] = 0
		self["2"] = 0
		self["20"] = 0
		self["29"] = 0

		---self.LKT = false
		self.LVD = false
		self.Ring = false
	end
	-- ARS signalling train wires
	if EnableARS then
		self.Train:WriteTrainWire(21,self.LVD and 1 or 0)-----self.LKT and 1 or 0)
	else--if not EnableUOS then
		self.Train:WriteTrainWire(21,0)
	end
	-- RC1 operation
	if self.Train.RC1 and (self.Train.RC1.Value == 0) then
		local KAH = (Train.KAH ~= nil and Train.KAH.Value > 0.5) and 1 or 0
		--self["33D"] = 1
		self["33G"] = 0
		self["33Zh"] = 1--KAH
		--
		self["2"] = 0
		self["20"] = 0
		self["29"] = 0
		--
		self["31"] = 0
		self["32"] = 0
		--self["8"] = KRUEnabled and (1-Train.RPB.Value) or 0
		self["33D"] = (self.Speed + 0.5 > 9000) and 0 or 1
		--self["33G"] = (self.Speed + 0.5 > 35) and 1 or KRUEnabled and (1-Train.RPB.Value) or 0
		--self["33Zh"] = 1--(self.Speed + 0.5 > 40) and 0 or KAH
		self["8"] = (self.Speed + 0.5 > 9000) and 1 or KRUEnabled and (1-Train.RPB.Value) or 0
	else
		if (not self.EPKActivated) then
			self["33D"] = 0
			self["33Zh"] = 1
		end
	end

	if Train.RV_2 then
		Train.RV_2:TriggerInput("Set",EnableARS and 1 or 0)
	end

	if self.EPKActivated then
		--if self.EPKOffARS then
			--self:EPVBrake("Was the emergency brake",true)
		--end
		--self.EPKOffARS = nil
		--if self.EPKTimer then print(self.EPKTimer - CurTime(),self.EPKTimer < CurTime(),self.EPKTimer > CurTime() ) end
		if not EnableARS then
			self:EPVBrake("ARS disabled")
		else
			self:EPVDisableBrake("ARS disabled")
		end
		if self.ARSBrakeTimer then
			self:EPVBrake("Braking 3 seconds")
		else
			self:EPVDisableBrake("Braking 3 seconds")
		end
	else
		--self.EPKOffTimer = nil
		--[[if EnableARS and self.EPKOffARS == nil then
			self.EPKOffARS = true
		else
			self.EPKOffARS = false
		end]]
		--if self.EPKOffARS then
			--self.EPKOffARS = false
		--end
		if not EnableARS then
			self.EPKBrake = false
		end
	end
	--if not EPKActivated then
		--if EnableARS and self.EPKOffARS == nil then
			--print(self.EPKBrake)
			--self.EPKOffARS = self.EPKBrake
		--end
	--end
	--if GetConVarNumber("metrostroi_ars_printnext") == Train:EntIndex() then print(self.EPKOffARS,EnableARS) end
	if not EnableARS then self.EPKOffARS = false end
	-- 81-717 autodrive/autostop
	if (Train.Pneumatic and Train.Pneumatic.EmergencyValve) or self.UAVAContacts then
		self["33D"] = 0
		self["33Zh"] = 1
	end

	self["8"] = self["8"]*Train.OVT.Value
	self["29"] = self["29"]*Train.OVT.Value
	if Train.UAVAContact and Train.UAVAContact.Value > 0.5 and not Train.Pneumatic.EmergencyValve then
		self.UAVAContacts = nil
	end
	self.Ring = self.Ring or (self.Alert and self.Alert - CurTime() > 0)
	if Train.Rp8 then Train.Rp8:TriggerInput("Set",self["8"] + ((self.Train.RC1 and (self.Train.RC1.Value == 0)) and (1-self["33D"]) or 0)) end
	self.Ring = self.RingOverride or self.Ring

	for k,v in pairs(self.EPK) do
		if not self.EPKActivated then
			if self.EPK[k] then
				self.EPK[k] = nil
			end
		end
		if CurTime() - v > 0 and not self.EPKBrake then
			self.EPKBrake = true
			RunConsoleCommand("say","EPV braking ("..k..")",self.Train:GetDriverName())
		end
	end
	Train.Pneumatic.EmergencyValveEPK = self.EPKBrake and not self.EPKOffTimer and not self.EPKActTimer
end

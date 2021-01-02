--------------------------------------------------------------------------------
-- АРС-АЛС
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("BARS")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.Train:LoadSystem("RC2","Relay","Switch", {bass = true,normally_closed = true })
	self.Train:LoadSystem("VAU","Relay","Switch",{ bass = true,normally_closed = true })
	self.Train:LoadSystem("VRD","Relay","Switch",{ bass = true })

	self.Train:LoadSystem("ALSCoil")

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

	self["33D"] = 1
	self["33Zh"] = 1
	self["33G"] = 0
	self["2"] = 0
	self["20"] = 0
	self["29"] = 0
	self["8"] = 0
	self["31"] = 0
	self["32"] = 0
	-- Lamps
	self.LKT = false
	--self.EPK = {}
end

function TRAIN_SYSTEM:Outputs()
	return {
		"2", "8", "20", "29", "33D", "33G", "33Zh", "31", "32",
		"NoFreq","F1","F2","F3","F4","F5","F6","LN"
	}
end

function TRAIN_SYSTEM:Inputs()
	return { "IgnoreThisARS","AttentionPedal","Ring", "PA-Ring" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
	local Train = self.Train
	if name == "AttentionPedal" then
		self.AttentionPedal = value > 0.5
		if Train and Train.PB then
			Train.PB:TriggerInput("Set",value)
		end
	end
	if name == "Ring" then
		self.ARSRingOverride = value > 0.5
	end
	--[[if name == "PA-Ring" then
		self.PA_Ring= value > 0.5
	end]]
end

function TRAIN_SYSTEM:Think(dT)
	local Train = self.Train
	local PUAV = Train.Blok == 1
	if PUAV then return end
	local ALS = Train.ALSCoil
	local speed = math.Round(ALS.Speed or 0,1)


	local power = Train.VB.Value > 0
	-- ALS, ARS state
	local KRUEnabled =  Train.KRU and Train.KRU["14/1-B3"] > 0
	local RVForward = power and (Train.KV["D4-15"] > 0 or KRUEnabled)
	local EnableARS = power and RVForward and Train.A42.Value > 0 and Train.ARS.Value > 0
	local EnableALS = power and Train.A43.Value > 0 and Train.ALS.Value > 0

	if RVForward and EnableALS ~= (ALS.Enabled==1) then
		ALS:TriggerInput("Enable",RVForward and EnableALS and 1 or 0)
	end

	local PAKSDM = Train.Blok == 4
	local PAKSD = Train.Blok == 2
	local PAM = Train.Blok == 3
	local KSDType = Train.Blok == 4 and "PA-KSD-M" or Train.Blok == 2 and "PA-KSD" or "PA-M"
	--if self.Train.ARSType == 3 and self.Train:EntIndex() ~= 3472 then self.Train.ARSType = 1 end
	--[[
	if not OverrideState then
		if PAKSD then
			EnableARS = EnableARS and (self.Train[KSDType].State > 4 and self.Train[KSDType].State ~= 45 and self.Train[KSDType].State ~= 49) and self.Train.RC1.Value > 0.5
			EnableALS = EnableALS and Train[KSDType].VPA and (self.Train[KSDType].State > 0 or self.Train[KSDType].State == -1 or self.Train[KSDType].State == -9)
		elseif PAKSDM then
			EnableARS = EnableARS and (self.Train[KSDType].State > 7 or ((self.Train[KSDType].State == 1.1 or self.Train[KSDType].State == 1) and self.Train[KSDType].NextState > 8)) and self.Train.RC1.Value > 0.5
			EnableALS = EnableALS and (self.Train[KSDType].State > 2 or ((self.Train[KSDType].State == 1.1 or self.Train[KSDType].State == 1) and self.Train[KSDType].NextState > 3))
		else
			EnableARS = EnableARS and Train.ARS.Value == 1
			EnableALS = EnableALS and Train.ALS.Value == 1
		end
		EnableUOS = false--Train[KSDType].UOS--EnableUOS and Train[KSDType].UOS
	end]]
	self.EnableARS = EnableARS
	self.EnableALS = EnableALS
	--[[local EPKActivated
	if (PAKSD or PAKSDM) then
		EPKActivated = EnableARS
	else
		EPKActivated = Train.EPK.Value > 0.5 and (Train.Pneumatic.ValveType == 2 and Train.DriverValveDisconnect.Value > 0.5 or Train.DriverValveBLDisconnect.Value > 0.5)
	end
	if not self.EPKActivated and EPKActivated then
		self.EPKActivated = EPKActivated
	end
	if EPKActivated and self.EPKActTimer then
		self.EPKActTimer = nil
	end
	if not EPKActivated and self.EPKActivated and not (PAKSD or PAKSDM) and not self.EPKActTimer then
		self.EPKActTimer = CurTime() + 3
	end
	if not EPKActivated and self.EPKActivated and (PAKSD or PAKSDM) then
		self.EPKActivated = false
		--self.EPKBrake = false
		for k in pairs(self.EPK) do
			self.EPK[k] = nil
		end
	end
	if self.EPKActTimer and CurTime() - self.EPKActTimer > 0 then
		self.EPKActivated = false
		--self.EPKBrake = false
		for k in pairs(self.EPK) do
			self.EPK[k] = nil
		end
	end]]

	-- Pedallocal PB = Train.PB.Value > 0
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

	self.NoFreq = ALS.NoFreq
	self.F1 = ALS.F1*(1-self.NoFreq)
	self.F2 = ALS.F2*(1-self.NoFreq)
	self.F3 = ALS.F3*(1-self.NoFreq)
	self.F4 = ALS.F4*(1-self.NoFreq)
	self.F5 = ALS.F5*(1-self.NoFreq)
	self.F6 = ALS.F6*(1-self.NoFreq)
	self.RealF5 = self.F5*(1-(self.F4+self.F3+self.F2+self.F1))
	self.NoFreq = self.NoFreq + (1-math.min(1,self.F5+self.F4+self.F3+self.F2+self.F1))


	-- ARS system placeholder logic
	if EnableALS --[[or EnableUOS]] then
		if (ALS.F1+ALS.F2+ALS.F3+ALS.F4+ALS.F5+ALS.F6+self.NoFreq) == 0 then self.NoFreq = 1 end
		local V = math.floor(self.Speed +0.05)
		local Vlimit = 0
		if self.F4 > 0 then Vlimit = 40 end
		if self.F3 > 0 then Vlimit = 60 end
		if self.F2 > 0 then Vlimit = 70 end
		if self.F1 > 0 then Vlimit = 80 end

		self.Overspeed = false--[[
		if (PAKSD or PAM or PAKSDM) and self.Train[KSDType].VRD and not self.Signal0 and not self.RealNoFreq then
			self.Train[KSDType].VRD = false
		end
		if self.AttentionPedal then
			Vlimit = 0
		end]]

		--if (    self.KVT) and (Vlimit == 0) and self.Train.ARSType and self.Train.ARSType == 3 and not self.Train[KSDType].VRD then self.Overspeed = true end
		--self.Ring = self.Overspeed and (self.Speed > 5)

		-- Determine next limit and current limit
		self.SpeedLimit = Vlimit
	else
		local V = math.floor(self.Speed +0.05)
		self.SpeedLimit = 0
		self.NextLimit = 0
	end
	------------------
	if self.SpeedLimit > 20 then self.SpeedLimit = self.SpeedLimit - 2 end
	if EnableARS then
		local SpeedLimit = self.SpeedLimit
		if self.ElectricBrake1 and self.ARSBrake and not (self.RealNoFreq and not self.KVT and not self.ARSBrake) then
			if self.ARSBrakeTimer == nil then self.ARSBrakeTimer = CurTime() + 5 end
		else
			self.ARSBrakeTimer = nil
		end

		if self.RealNoFreq and (not self.PrevNoFreq) then
			self.IgnorePedal = true
		end
		self.PrevNoFreq = self.RealNoFreq
		-- Check overspeed
		--if self.Train.Owner:GetName():find("E11") then self.SpeedLimit = 25 end
		if SpeedLimit > 20 then
			--[[if (PAM or PAKSDM) and self.Train.YAR_13A.Slope == 0 and self.Speed >= self.SpeedLimit and not self.ARSBrake then
				self.ElectricBrake1 = true
			end]]
			if self.Speed >= SpeedLimit + 1 then
				 if Train:ReadTrainWire(6) == 0 then
					self.ElectricBrake = true
					--self.PneumaticBrake1 = true
				end
				self.ElectricBrake1 = true
				self.ARSBrake = true
			end
		end
		if self.ElectricBrake  then
			self.PneumaticBrake1 = self.Train.Electric.I24 > -50
			--print(self.PneumaticBrake1)
		end
		if self.Overspeed then
			self.ARSBrake = true
			self.ElectricBrake1 = true
			self.ElectricBrake = true
			--self.PneumaticBrake1 = true
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
		if (self.Signal0 or self.Special) then
			if not self.ZeroTimer then
				self.ZeroTimer = CurTime()+30
				self.ZeroTimerState = true
			end
			if self.ZeroTimerState and self.ZeroTimer and CurTime()-self.ZeroTimer > 7.5 and self.Speed < 0.25 then
				self.ZeroTimerState = false
				self.ZeroTimer = CurTime()+30
			end
		elseif self.ZeroTimer ~= nil then
			self.ZeroTimer = nil
		end
		if self.Speed < 1.25 then
 			self.PneumaticBrake1 = true
		end
		-- Parking brake limit
		local BPSWorking = Train:ReadTrainWire(5) > 0 and (not (PAKSD or PAM or PAKSDM) or not Train[KSDType].Nakat)
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
			if (PAKSD or PAM or PAKSDM) and Train[KSDType].Nakat then self.PneumaticBrake1 = false end
		end
		--if BPSWorking and self.EPKActivated and not Train[KSDType].Stancionniy and Train:ReadTrainWire(5) > 0 and self.Speed*self.Train.SpeedSign <  -5 and not self.EPKBrake then
			--self.EPKBrake = true
			--RunConsoleCommand("say","EPV braking (Driver rolling back)",Train:GetDriverName())
		--end

		--BPS Logic
		if not BPSWorking then
			self.StoppedOnSlopeByRP = false
			self.BPSActive = false
		end
		--if (Train.BPS == nil or Train.BPS.Value < 0.5) then self.AntiRolling = nil end
		-- Check cancel pneumatic brake 1 command
		if ((Train:ReadTrainWire(1) > 0) or (Train.RRP and Train.RRP.Value > 0 and not self.ElectricBrake1)) then
			if (Train:ReadTrainWire(1) > 0 or (Train.RRP and Train.RRP.Value > 0 and not self.ElectricBrake1)) and self.PneumaticBrake1 and not self.Overspeed then
				self.PneumaticBrake1 = false
			end
		end
		if self.Signal0 and not self.Special and not self.RealNoFreq and not self.Signal40 and not self.Signal60 and not self.Signal70 and not self.Signal80 then
			if not self.ReadyPeep then self.ReadyPeep = true end
			if not self.NonVRD and (not Train[KSDType].VRD and (PAKSD or PAKSDM) or self.Train.VRD.Value < 0.5 and (PAM or PUAV)) then
				self.VRDTimer = nil
			end

			self.NonVRD = (PAKSD or PAKSDM)  and not Train[KSDType].VRD or  (PAM or PUAV) and self.Train.VRD.Value < 0.5
			if self.NonVRD and self.Train:ReadTrainWire(6) < 0 then
				if self.VRDTimer and CurTime() - self.VRDTimer > 0 then
					self.VRDTimer = false
				elseif self.VRDTimer ~= false then
					if not self.VRDTimer and self.KVT then self.VRDTimer = CurTime() + 1 end
					if self.VRDTimer and not self.KVT then self.VRDTimer = nil end
				end
			elseif self.Train:ReadTrainWire(6) > 0  then
				self.VRDTimer = false
			else
				self.VRDTimer = false
			end
		else
			if self.ReadyPeep then
				self.ReadyPeep = nil
				self.PeepTimer = CurTime() + 0.1
			end
			if self.PeepTimer and self.PeepTimer - CurTime() < 0 then
				self.PeepTimer = nil
			end
			--	self.PeepTimer = nil
			--if self.ReadyPeep == nil then
				--self.ReadyPeep = true
			--end
			if self.NonVRD then self.NonVRD = false end
			self.VRDTimer = false
		end
		local VRDoff =  (PAKSD or PAKSDM ) and 0 or 1
		if (self.Train:ReadTrainWire(15) < 1.0) and (self.Speed < 1.0) and not Train[KSDType].KD and (PAKSD or PAM or PAKSDM) then
			self.KD = true
		elseif (PAKSD or PAM or PAKSDM) and Train[KSDType].AutodriveWorking and not self.Train.Autodrive.AutodriveEnabled then
			self.KD = true
		elseif Train[KSDType].KD or self.Train:ReadTrainWire(15) > 0.0 and (PAKSD or PAM or PAKSDM) then
			self.KD = false
		end
		-- ARS signals
		local Ebrake, Abrake, NFBrake, Pbrake1,Pbrake2 =
			((self.ElectricBrake) and 1 or 0),
			((self.ARSBrake)  and 1 or 0),
			((self.SpeedLimit < 20 and not self.KVT and not self.ARSBrake) and 1 or 0),
			(self.PneumaticBrake1 and 1 or 0),
			(self.PneumaticBrake2 and 1 or 0)
		local VRDBrake = self.NonVRD or self.VRDTimer ~= false

		-- Apply ARS system commands
		self["33D"] = (1 - Abrake) *(1-NFBrake)*((self.KD  or self.ElectricBrake1 or VRDBrake or self.AntiRolling ~= nil or Train[KSDType].StopTrain) and 0 or 1) --*(2 - Pbrake2)
		self["33G"] = Ebrake + NFBrake*VRDoff + ((VRDBrake) and 1 or 0)*VRDoff
		self["33Zh"] = (1 - Abrake)*(1-NFBrake*VRDoff)*((self.KD or VRDBrake or self.ElectricBrake1 or self.AntiRolling ~= nil or Train[KSDType].StopTrain) and 0 or 1)--*(2 - Pbrake2)
		--print(self["33Zh"])
		self["2"] = Ebrake + NFBrake*VRDoff + ((VRDBrake) and 1 or 0)*VRDoff
		self["20"] = Ebrake + NFBrake*VRDoff + ((VRDBrake) and 1 or 0)*VRDoff
		self["29"] = Pbrake1-- + (self.BPSActive and 1 or 0)
		--if GetConVarNumber("metrostroi_ars_printnext") == Train:EntIndex() then print(self.SpeedLimit,self.self.SpeedLimit <= 20 and not self.KVT) end
		--if StPetersburg then print(self.Train:EntIndex()) end
		self["8"] = Pbrake2
			+ (KRUEnabled and 1 or 0)*Ebrake
			+ ((self.SpeedLimit < 20 and not self.KVT and VRDBrake == 0 or self.Speed > 20 and self.SpeedLimit < 20) and 1 or 0)
			+ (self.BPSActive and 1 or 0)
			+ (self.AntiRolling ~= nil and 1 or 0)
			+ (1 - ((self.EPKActivated and 1 or 0) or 1)
			+ (Train[KSDType].StopTrain and 1 or 0))

		---self.LKT = (self["33G"] > 0.5) or (self["29"] > 0.5) or (Train:ReadTrainWire(35) > 0)
		self.LVD = self.LVD or self["33D"] < 0.5
		if Train:ReadTrainWire(6) < 1 and self["33D"] > 0.5  then  self.LVD = false end
		self.Ring = ((self["33D"] < 0.5 and ((NFBrake < 1 and self.ARSBrakeTimer ~= nil and self.ARSBrakeTimer ~= false) or self.VRDTimer ~= false)) or self.KSZD or (self.PeepTimer and self.PeepTimer-CurTime() > 0)) or math.max(20,self.SpeedLimit-1) < self.Speed and (PAKSDM or PAM)
		--self.ZeroTimer = nil
		if Train.PUAV.ZeroTimer then
			local timer = (CurTime()-Train.PUAV.ZeroTimer)
			if timer >= 0 and timer < 3.5 then
				self.Ring = true
			elseif timer >= 3.5 and timer < 3.5+4 and timer%1 < 0.5 then
				self.Ring = true
			end
		end
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
		if self.EPKActivated and not self.LKT and self.Speed < 0.05 and Train:ReadTrainWire(1) == 0 and (not (PAKSD or PAM or PAKSDM) or not Train[KSDType].Nakat) then -- or (self.AntiRolling ~= nil and Train:ReadTrainWire(1) > 0) then
			self:EPVBrake("LKT off when stopped")
		else
			self:EPVDisableBrake("LKT off when stopped")
		end
	else
		self.AntiRolling = nil
		self.ElectricBrake1 = true
		self.ElectricBrake = true
		self.PneumaticBrake1 = false
		self.PneumaticBrake2 = true
		self.ARSBrake = true
		self.ZeroTimer = nil
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
		if PAKSD or PAKSDM and not Train[KSDType].UOS then
			Train[KSDType].UOS = true
		end
		--self["33D"] = self.Speed > 55 and 0 or 1
		self["33G"] = 0
		self["33Zh"] = 1
		--
		self["2"] = 0
		self["20"] = 0
		self["29"] = 0
		--
		self["31"] = 0
		self["32"] = 0
		--self["8"] = KRUEnabled and (1-Train.RPB.Value) or 0
		self["33D"] = (self.Speed + 0.5 > 9000 and ((not PAKSD and not PAKSDM) or Train[KSDType].State > 0)) and 0 or 1
		--self["33G"] = (self.Speed + 0.5 > 35) and 1 or KRUEnabled and (1-Train.RPB.Value) or 0
		--self["33Zh"] = 1--(self.Speed + 0.5 > 40) and 0 or KAH
		self["8"] = (self.Speed + 0.5 > 9000 and ((not PAKSD and not PAKSDM) or Train[KSDType].State > 0)) and 1 or KRUEnabled and (1-Train.RPB.Value) or 0
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
		if (PAKSD or PAKSDM) and self.KVT and not self.EPKOffTimer and self.EPKBrake then
			self.EPKOffTimer = CurTime() + 1
			--self.EPKBrake = false
		end
		if self.EPKOffTimer and not self.KVT then
			self.EPKOffTimer = nil
			self.EPKBrake = true
		end
		if self.EPKOffTimer and CurTime()-self.EPKOffTimer > 0 then
			self.EPKOffTimer = nil
			self.EPKBrake = false
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

	-- 81-717 special VZ1 button
	if self.Train.VZ1 then
		self["29"] = self["29"] + self.Train.VZ1.Value
	end
	if Train.UAVAContact and Train.UAVAContact.Value > 0.5 and not Train.Pneumatic.EmergencyValve then
		self.UAVAContacts = nil
	end
	self["8"] = self["8"]*(self.Train.A41 and self.Train.A41.Value or 1)*(self.Train.A8 and self.Train.A8.Value or 1) + self.Train.OVT.Value
	self["29"] = self["29"]*(self.Train.A8 and self.Train.A8.Value or 1)
	self.Ring = self.Ring or (self.Alert and self.Alert - CurTime() > 0)
	if Train.Rp8 then Train.Rp8:TriggerInput("Set",self["8"] + ((self.Train.RC1 and (self.Train.RC1.Value == 0)) and (1-self["33D"]) or 0)) end
	self.Ring = self.PA_Ring or self.ARSRingOverride or self.Ring
	self.Ring = self.Ring or (PUAV and self.Train.PUAV.RingArmed and true)
	--[[
	if PAKSD and Train["PA-KSD"].State == 5 then
		self["33D"] = 1
		self["33Zh"] = 1
		self["33G"] = 0
		self["2"] = 0
		self["20"] = 0
		self["29"] = 0
		self["8"] = 0
	end
	if (PAM or PAKSDM) and Train["PA-M"].State == 8 then
		self["33D"] = 1
		self["33Zh"] = 1
		self["33G"] = 0
		self["2"] = 0
		self["20"] = 0
		self["29"] = 0
		self["8"] = 0
	end
	]]
	for k,v in pairs(self.EPK) do
		if CurTime() - v > 0 and not self.EPKBrake and (not self.KVT or not (PAKSD or PAKSDM)) then
			self.EPKBrake = true
			RunConsoleCommand("say","EPV braking ("..k..")",self.Train:GetDriverName())
		end
	end
	Train.Pneumatic.EmergencyValveEPK = self.EPKBrake and not self.EPKOffTimer and not self.EPKActTimer
end

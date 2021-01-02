--------------------------------------------------------------------------------
-- АРС-АЛС
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("ARS_Dnepr_SPB")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.Train:LoadSystem("BPS","Relay","Switch", {bass = true,normally_closed = true })
	self.Train:LoadSystem("BUD","Relay","Switch", {bass = true,normally_closed = true })
	self.Train:LoadSystem("RC2","Relay","Switch", {bass = true,normally_closed = true })
	self.Train:LoadSystem("VAU","Relay","Switch",{ bass = true,normally_closed = true })
	self.Train:LoadSystem("VRD","Relay","Switch",{ bass = true })
	self.Train:LoadSystem("ROT","Relay","Switch", {bass = true})

	self.Train:LoadSystem("ALSCoil")

	-- Internal state
	self.SpeedLimit = 0
	self.ARSRing = false
	self.Overspeed = false
	self.ElectricBrake = false
	self.PneumaticBrake1 = false
	self.PneumaticBrake2 = true
	self.AttentionPedal = false

	self.KVT = false
	self.LN = 0

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
	return {
		"2", "8", "20", "29", "33D", "33G", "33Zh", "31", "32",
		"NoFreq","F1","F2","F3","F4","F5","F6","LN"
	}
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
		self.ARSRingOverride = value > 0.5
	end
end


function TRAIN_SYSTEM:Think(dT)
	local Train = self.Train
	local PUAV = not Train.Blok or Train.Blok == 1
	if not PUAV then return end
	local ALS = Train.ALSCoil
	local speed = math.Round(ALS.Speed or 0,1)

	local power = Train.VB.Value > 0
	-- ALS, ARS state
	local KRUEnabled =  Train.KRU and Train.KRU["14/1-B3"] > 0
	local RVForward = power and (Train.KV["D4-15"] > 0 or KRUEnabled)
	local EnableARS = power and RVForward and (not Train.A42 or Train.A42.Value > 0) and Train.ARS.Value > 0
	local EnableALS = power and (not Train.A43 or Train.A43.Value > 0) and Train.ALS.Value > 0

	if (RVForward and EnableALS) ~= (ALS.Enabled==1) then
		ALS:TriggerInput("Enable",RVForward and EnableALS and 1 or 0)
	end

	self.EnableARS = EnableARS
	self.EnableALS = EnableALS

	--local EPKActivated = Train.EPK and Train.EPK.Value > 0.5 and (Train.Pneumatic.ValveType == 2 and Train.DriverValveDisconnect.Value > 0.5 or Train.DriverValveBLDisconnect.Value > 0.5)
	-- Pedal state
	--if (Train.PB) and Train.PB.Value > 0.5 then self.AttentionPedal = true end
	--if (Train.PB) and Train.PB.Value <  0.5 then self.AttentionPedal = false end
	local PB = Train.PB.Value > 0
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
	if EnableARS then self.NoFreq = self.NoFreq + (1-math.min(1,self.F5+self.F4+self.F3+self.F2+self.F1)) end

	-- ARS system placeholder logic
	if EnableALS then
		if (ALS.F1+ALS.F2+ALS.F3+ALS.F4+ALS.F5+ALS.F6+self.NoFreq) == 0 then self.NoFreq = 1 end
		local Vlimit = 0
		if self.F4 > 0 then Vlimit = 40 end
		if self.F3 > 0 then Vlimit = 60 end
		if self.F2 > 0 then Vlimit = 70 end
		if self.F1 > 0 then Vlimit = 80 end
		-- Determine next limit and current limit
		self.SpeedLimit = Vlimit
	else
		local V = math.floor(speed +0.05)
		self.SpeedLimit = 0
	end

	if EnableARS then
		if self.EnableARS ~= EnableARS then Train.EPKContacts:TriggerInput("Set",Train.EPKContacts.Value) end
		local SpeedLimit = self.SpeedLimit
		if SpeedLimit < 20 and self.KVT then SpeedLimit = 20 end
		-- Check absolute stop
		if self.NoFreq ~= self.PrevNoFreq and Train:ReadTrainWire(6) < 1 then
			self.IgnorePedal = self.NoFreq > 0 and Train:ReadTrainWire(6) < 1
			self.PrevNoFreq = self.NoFreq
		end
		local zero = (self.NoFreq+self.RealF5) > 0
		-- Enable PV1 and disassembly when we overspeed
		if speed > SpeedLimit+0.5 and not self.Disassembly then
			if zero then
				self.Disassembly = CurTime()-2
			else
				self.Disassembly = CurTime()
			end
			self.ElectricBrake = true
			self.ARSRing = true
		end
		if self.KVT and self.ARSRing then self.ARSRing = false end
		--We can disable brake, if speed < Vdop-3 and electric brake
		if not self.ARSRing and speed <= SpeedLimit-3 and self.ElectricBrake then
			self.ElectricBrake = false
			self.Disassembly = false
			self.PneumaticBrake2 = false
		end
		--We can disable ring if speed < Vdop and not electric brake
		if self.KVT and speed <= SpeedLimit and not self.ElectricBrake and self.ARSRing then self.ARSRing = false end
		--Disable PN1 when we overspeed and time of overspeed < 1.5
		if speed <= SpeedLimit and self.Disassembly and CurTime()-self.Disassembly < 1.5 then
			self.Disassembly = false
			self.ElectricBrake = false
		end
		--Engage electric when we overspeed and time of overspeed >= 1.5
		if self.Disassembly and not self.ElectricBrake and ((CurTime() - self.Disassembly) >= 1.5) then
			self.ElectricBrake = true
		end
		--PN2 when we brake to 0 speed
		if self.Disassembly and self.ElectricBrake and speed < 0.25 then self.PneumaticBrake2 = true end

		-- AntiRolling
		local Drive = (Train.KV["10AS-33"] > 0 or KRUEnabled)-- and Train.KRR.Value > 0)
		-- Engage RO
		if speed < 3 and self.RO ~= true and not Drive and self.KDReadyToRelease ~= false then self.RO = true end
		-- Check RO when we starting
		if self.RO and self.RO ~= true and (speed > 5 or CurTime()-self.RO > 7) then
			self.RO = nil
			self.PneumaticBrake2 = self.NoFreq == 0 and speed <= 5
			self.KDReadyToRelease = nil
		end
		-- Disable PN1 and start RO timer
		if Drive and self.RO == true then
			self.RO = CurTime()
		end

		local delay = 3.5
		if 10 < speed and speed < 30 then delay = 5.5 end
		if speed < 3 then delay = 10 end
		if (self.ElectricBrake or speed < 0.2) and Train.Panel.KT == 0 then
			if not self.EPKTimer then self.EPKTimer = CurTime() end
		else
			self.EPKTimer = nil
		end
		if self.EPKTimer and CurTime()-self.EPKTimer > delay then Train.EPKContacts:TriggerInput("Open",1) end
		-- ARS signals
		local Ebrake, Abrake, Pbrake1,Pbrake2 =
			((self.ElectricBrake) and 1 or 0),
			((self.Disassembly or self.ARSRing or self.ElectricBrake or zero and not self.KVT or self.F5 > 0 and Train.VRD.Value == 0)  and 1 or 0),
			((self.Disassembly and (zero or CurTime()-self.Disassembly < 1.5)  or self.RO == true) and 1 or 0),
			((self.PneumaticBrake2 or zero and not self.KVT) and 1 or 0)
		-- Apply ARS system commands
		self["33D"] = (1 - Abrake)*(1-Pbrake2)
		self["33G"] = Ebrake
		self["33Zh"] = (1 - Abrake)*(1-Pbrake2)
		self["2"] = Ebrake-- + NFBrake
		self["20"] = Ebrake-- + NFBrake
		self["29"] = Pbrake1-- + (self.BPSActive and 1 or 0)
		--print(Train.Speed)
		--if GetConVarNumber("metrostroi_ars_printnext") == Train:EntIndex() then print(self.SpeedLimit,self.self.SpeedLimit <= 20 and not self.KVT) end
		--if StPetersburg then print(self.Train:EntIndex()) end
		self["8"] = Pbrake2
			+ (KRUEnabled and 1 or 0)*Ebrake + (self.Disassembly and CurTime()-self.Disassembly >= 1.5 and 1 or 0)
			--+ (1 - ((EPKActivated and 1 or 0) or 1))
		---self.LKT = (self["33G"] > 0.5) or (self["29"] > 0.5) or (Train:ReadTrainWire(35) > 0)
		self.LVD = self.LVD or self["33D"] < 0.5
		if Train:ReadTrainWire(6) < 1 and self["33D"] > 0.5 then self.LVD = false end
		--self.ARSRing = ((self["33D"] < 0.5) or self.KSZD)
	else
		if Train.EPK.Value == 0 then Train.EPKContacts:TriggerInput("Set",1) end
		self.ElectricBrake = true
		self.PneumaticBrake1 = false
		self.PneumaticBrake2 = true
		self.Disassembly = CurTime()-5
		self.RO = true
		self["33D"] = 0
		self["33Zh"] = 1
		self["8"] = KRUEnabled and (1-Train.RPB.Value) or 0
		self["33G"] = 0
		self["2"] = 0
		self["20"] = 0
		self["29"] = 0

		---self.LKT = false
		self.LN = 0
		self.LVD = false
		self.ARSRing = true
	end
	-- ARS signalling train wires
	self.Train:WriteTrainWire(21,self.LVD and 1 or 0)
	-- RC1 operation
	if Train.RC1 and Train.RC1.Value == 0 then
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
		--[[
		if not EnableARS and EnableUOS then
			self["33D"] = speed > 35 and 0 or KAH
			--self["33Zh"] = 1--(self.Speed + 0.5 > 40) and 0 or KAH
			self["8"] = speed > 35 and 1 or KRUEnabled and (1-Train.RPB.Value) or 0
		else]]
		--end
	end
	local EPKActivated = Train.Pneumatic.EPKEnabled-- or Train.UOS.Value > 0
	if (not EPKActivated or Train.EPKContacts.Value == 0) and Train.RC1.Value > 0 then
		self["33D"] = 0
	end

	if Train.BPS.Value > 0 and Train.KV["10AK-4"] > 0 then
		if not self.BPSArmed then
			self.BPSMeter = self.BPSMeter or 0
			self.BPSMeter = self.BPSMeter + math.min(0,Train.Speed*Train.SpeedSign*1000/3600)*dT
			if Train.Speed*Train.SpeedSign > 0.1 then
				self.BPSMeter = 0
			end
			if -self.BPSMeter > 3 then
				self.BPSArmed = true
			end
		end
	else
		self.BPSArmed = false
		self.BPSMeter = 0
	end
	if self.BPSArmed then
		self["8"] = 1
		self["29"] = 1
		self["33D"] = 0
		self["33Zh"] = 0
	end

	Train.RV_2:TriggerInput("Set",(EnableARS and not self.BPSArmed) and 1 or 0)
	-- 81-717 special VZ1 button
	if self.Train.VZ1 then self["29"] = self["29"] + self.Train.VZ1.Value end
	if (Train.Pneumatic and Train.Pneumatic.EmergencyValve) or self.UAVAContacts then self["33D"] = 0 end
	if Train.UAVAContact.Value > 0.5 and not Train.Pneumatic.EmergencyValve and self.UAVAContacts then
		self.UAVAContacts = nil
		Train:PlayOnce("uava_reset","bass",1)
	end
	self["8"] = self["8"]*(self.Train.A41 and self.Train.A41.Value or 1)*(self.Train.A8 and self.Train.A8.Value or 1)
	self["29"] = self["29"]*(self.Train.A8 and self.Train.A8.Value or 1)
	--Train.Rp8:TriggerInput("Set",self["8"] + ((self.Train.RC1 and (self.Train.RC1.Value == 0)) and (1-self["33D"]) or 0))
	Train.Rp8:TriggerInput("Set",EnableARS and (Train:ReadTrainWire(6)*Train:ReadTrainWire(2)*(1-Train:ReadTrainWire(25))) or 0)

	--local P		= math.ceil(Train.PositionSwitch.Position) --FIXME
	local RK	= math.ceil(Train.RheostatController.Position)
	--print(RK,P,((RK >= 17 and RK <= 18) and 1 or 0),Train.KV["10-8"])
	--Train.RO:TriggerInput("Set",Train.A8.Value*Train:ReadTrainWire(8)*((RK >= 17 and RK <= 18) and 1 or 0) + ((EnableARS and self.RO==true) and 1 or 0))
	self.Ring = self.ARSRingOverride or self.ARSRing and EnableARS
	if Train.PUAV.ZeroTimer then
		local timer = (CurTime()-Train.PUAV.ZeroTimer)
		if timer >= 0 and timer < 3.5 then
			self.Ring = true
		elseif timer >= 3.5 and timer < 3.5+4 and timer%1 < 0.5 then
			self.Ring = true
		end
	end
	self.Ring = self.Ring or Train.PUAV.RingArmed
end

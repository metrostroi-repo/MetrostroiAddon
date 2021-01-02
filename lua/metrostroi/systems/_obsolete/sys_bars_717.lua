--------------------------------------------------------------------------------
-- БАРС
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("ARS_BARS_717")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize()
	self.Train:LoadSystem("VRD","Relay","Switch",{ bass = true })

	self.Train:LoadSystem("ALSCoil")
	--self.Train:LoadSystem("ALSCoil","ALSTest")

	self.Train:LoadSystem("ROT1","Relay")
	self.Train:LoadSystem("ROT2","Relay")
	self.Train:LoadSystem("EK","Relay")
	self.Train:LoadSystem("EK1","Relay",{close_time = 3})
	self.Train:LoadSystem("EPKC","Relay")

	-- Internal state
	self.Speed = 0
	self.SpeedLimit = 0
	self.ARSRing = false
	self.Overspeed = false
	self.ElectricBrake = false
	self.PneumaticBrake1 = false
	self.PneumaticBrake2 = true
	self.AttentionPedal = false

	self.KRT = 0
	self.KRH = 0
	self.K25 = 0
	self.KVT = false
	self.LN = 0
	self.Freq = 0
	self.NoFreq = 0
	self.F1 = 0
	self.F2 = 0
	self.F3 = 0
	self.F4 = 0
	self.F5 = 0
	self.F6 = 0
	self.RealF5 = 0

	-- ARS wires
	self["33D"] = 0
	self["33G"] = 0
	self["2"] = 0
	self["6"] = 0
	self["8"] = 0
	self["20"] = 0
	--self["21"] = 0
	self["48"] = 0
	self["31"] = 0
	self["32"] = 0

	self.Speed = 0

	-- Lamps
	---self.LKT = false
	self.LVD = 0
	self.Ring = 0
end

function TRAIN_SYSTEM:Outputs()
	return {
		"Ring","LVD",
		"NoFreq","F1","F2","F3","F4","F5","F6","LN","Speed"
	}
end

function TRAIN_SYSTEM:Inputs()
	return { "Confirm", "IgnoreThisARS","AttentionPedal","Ring" }
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

	if name == "Confirm" then self.ConfirmARS = true end
end


function TRAIN_SYSTEM:Think(dT)
	local Train = self.Train
    if Train.Electric.Type < 2 then return end
	local ALS = Train.ALSCoil
	local speed = math.Round(ALS.Speed or 0,1/3)
	self.SpeedoTimer = self.SpeedoTimer or CurTime()
	if CurTime()-self.SpeedoTimer > 0.4 then
		local time = (CurTime()-self.SpeedoTimer)
		self.Speed = math.max(0,self.Speed+(speed-self.Speed)*(0.4+math.max(0,math.min((self.Speed-5)*0.2,0.4))))
		self.SpeedoTimer = CurTime()
	end

	local power = Train.VB.Value > 0
	-- ALS, ARS state
	local KRUEnabled =  Train.KRU and Train.KRU["14/1-B3"] > 0
	local RVForward = power and (Train.KV["D4-15"] > 0 or KRUEnabled)
	local EnableARS = power and RVForward and --[[ (not Train.A42 or Train.A42.Value > 0)  and--]]  Train.ARS.Value > 0
	local EnableALS = power and --[[ (not Train.A43 or Train.A43.Value > 0) and--]]  Train.ALS.Value > 0
	if (RVForward and EnableALS) ~= (ALS.Enabled==1) then
		ALS:TriggerInput("Enable",RVForward and EnableALS and 1 or 0)
	end

	self.EnableARS = EnableARS
	self.EnableALS = EnableALS

	self.Power = self.EnableARS and 1 or 0

	--local EPKActivated = Train.EPK and Train.EPK.Value > 0.5 and (Train.Pneumatic.ValveType == 2 and Train.DriverValveDisconnect.Value > 0.5 or Train.DriverValveBLDisconnect.Value > 0.5)
	-- Pedal state
	--if (Train.PB) and Train.PB.Value > 0.5 then self.AttentionPedal = true end
	--if (Train.PB) and Train.PB.Value <  0.5 then self.AttentionPedal = false end
	local PB = Train.PB.Value > 0 or self.ConfirmARS
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

	local freq = ALS.F1*1+ALS.F2*2+ALS.F3*4+ALS.F4*8+ALS.F5*16+ALS.F6*32+ALS.NoFreq*64
	if freq ~= self.Freq and not self.FreqChangeTimer then self.FreqChangeTimer = CurTime() end
	if self.FreqChangeTimer and CurTime()-self.FreqChangeTimer > 0.5 then
		self.Freq = freq
		self.NoFreq = ALS.NoFreq
		self.F1 = ALS.F1*(1-self.NoFreq)
		self.F2 = ALS.F2*(1-self.NoFreq)
		self.F3 = ALS.F3*(1-self.NoFreq)
		self.F4 = ALS.F4*(1-self.NoFreq)
		self.F5 = ALS.F5*(1-self.NoFreq)
		self.F6 = ALS.F6*(1-self.NoFreq)
		self.RealF5 = self.F5*(1-(self.F4+self.F3+self.F2+self.F1))
		self.FreqChangeTimer = nil
	end
	--if EnableARS and self.NoFreq == 0 then self.NoFreq = (1-math.min(1,self.F5+self.F4+self.F3+self.F2+self.F1)) end

	-- ARS system placeholder logic
	if EnableALS then
		if freq == self.Freq and self.Freq == 0 then self.NoFreq = 1 end
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
		if self.Freq == 0 then self.NoFreq = 0 end
	end

	if EnableARS then
		Train.EK:TriggerInput("Close",Train.EK1.Value)
		local SpeedLimit = self.SpeedLimit
		if SpeedLimit < 20 and self.KVT then SpeedLimit = 20 end
		-- Check absolute stop
		if self.NoFreq ~= self.PrevNoFreq and self.KRT < 1 then
			self.IgnorePedal = self.NoFreq > 0 and self.KRT < 1
			self.PrevNoFreq = self.NoFreq
		end
		local zero = (self.NoFreq+self.RealF5) > 0
		-- Enable PV1 and disassembly when we overspeed
		if speed > SpeedLimit+0.5 and not self.Overspeed then
			self.Overspeed = self.KRT > 0 and CurTime()-1 or CurTime()
			self.ElectricBrake = true
			self.ARSRing = true
		end
		if self.KVT and self.ARSRing then self.ARSRing = false end
		--We can disable brake, if speed < Vdop-3 and electric brake
		if not self.ARSRing and speed <= SpeedLimit-2 and self.ElectricBrake then
			self.ElectricBrake = false
			self.Overspeed = false
			self.PneumaticBrake2 = false
		end
		--We can disable ring if speed < Vdop and not electric brake
		if self.KVT and speed <= SpeedLimit and not self.ElectricBrake and self.ARSRing then self.ARSRing = false end
		--Engage electric when we overspeed
		if self.Overspeed and not self.ElectricBrake and self.Overspeed then
			self.ElectricBrake = true
		end
		--PN2 when we brake to 0 speed
		--if self.Overspeed and self.ElectricBrake and speed < 0.25 then self.PneumaticBrake2 = true end

		-- AntiRolling
		local Drive = (--[[ Train.KV["10AS-33"] > 0 and--]]  self.KRH > 0)-- and Train.KRR.Value > 0)

		if speed > SpeedLimit-1 then self.BlockDrive = true end
		if speed < SpeedLimit-2 and not Drive then self.BlockDrive = false end

		-- Engage RO
		if speed < 3 and self.RO ~= true and not Drive then self.RO = true end
		-- Check RO when we starting
		if self.RO and self.RO ~= true and (speed > 5 or CurTime()-self.RO > 6) then
			self.RO = nil
			self.AntiRolling = self.NoFreq == 0 and speed <= 5 and CurTime()
		end
		if self.AntiRolling and Drive then self.AntiRolling = CurTime() elseif self.AntiRolling and CurTime()-self.AntiRolling > 3 then self.AntiRolling = false end
		-- Disable PN1 and start RO timer
		if Drive and self.RO == true then
			self.RO = CurTime()
		end

		local delay = 3.5
		if 10 < speed and speed < 30 then delay = 5.5 end
		--if speed < 3 then delay = 10 end
		if (self.ElectricBrake or speed < 0.2) and Train.Panel.KT == 0 or self.ARSRing then
			if not self.EPKTimer then self.EPKTimer = CurTime() end
		else
			self.EPKTimer = nil
		end
		if self.EPKTimer and CurTime()-self.EPKTimer > delay then Train.EK1:TriggerInput("Open",1) end
		-- ARS signals
		local zeroBrake =  self.Freq == 0 or zero and not self.KVT or self.F5 > 0 and Train.VRD.Value == 0 and self.F6 == 0
		local Ebrake, Abrake, Pbrake1,Pbrake2 =
			((self.ElectricBrake or zeroBrake) and 1 or 0),
			((self.BlockDrive or self.Overspeed or self.ARSRing or self.ElectricBrake or zeroBrake or self.AntiRolling)  and 1 or 0),
			((self.Overspeed and CurTime()-self.Overspeed < 1 or self.RO == true or self.AntiRolling) and 1 or 0),
			((self.PneumaticBrake2 or zeroBrake) and 1 or 0)
		-- Apply ARS system commands
		self["33D"] = (1 - Abrake)*(1 - Pbrake2)
		self["33G"] = Ebrake
		self["2"] = Ebrake-- + NFBrake
		self["20"] = Ebrake-- + NFBrake
		self["48"] = Pbrake1-- + (self.BPSActive and 1 or 0)
		--print(Train.Speed)
		self["8"] = self.K25*-10+Pbrake2
			+ (KRUEnabled and 1 or 0)*Ebrake + (self.Overspeed and CurTime()-self.Overspeed >= 1.5 and 1 or 0)
			--+ (1 - ((EPKActivated and 1 or 0) or 1))
		---self.LKT = (self["33G"] > 0.5) or (self["48"] > 0.5) or (Train:ReadTrainWire(35) > 0)
		self.LVD = math.min(1,self.LVD + (1-self["33D"]))
		if self.KRH < 1 and self["33D"] > 0.5 then self.LVD = 0 end
		--self.ARSRing = ((self["33D"] < 0.5) or self.KSZD)
	else
		Train.EK:TriggerInput("Open",1)
		Train.EK1:TriggerInput("Close",1)
		self.ElectricBrake = true
		self.PneumaticBrake1 = false
		self.PneumaticBrake2 = true
		self.Overspeed = CurTime()
		self.BlockDrive = false
		self.RO = true
		self.AntiRolling = false
		self["33D"] = 0
		self["8"] = KRUEnabled and (1-Train.RPB.Value) or 0
		self["33G"] = 0
		self["2"] = 0
		self["20"] = 0
		self["48"] = 0

		---self.LKT = false
		self.LN = 0
		self.LVD = 0
		self.ARSRing = true
	end
	-- ARS signalling train wires
	self.Train:WriteTrainWire(21,self.LVD and 1 or 0)
	if 0*Train.KV["10AK-4"] > 0 then
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
		self["48"] = 1
		self["33D"] = 0
	end

	--Train.RV_2:TriggerInput("Set",(EnableARS and not self.BPSArmed) and 1 or 0)

	--Train.Rp8:TriggerInput("Set",self["8"] + ((self.Train.RC1 and (self.Train.RC1.Value == 0)) and (1-self["33D"]) or 0))
	--Train.Rp8:TriggerInput("Set",EnableARS and (Train:ReadTrainWire(6)*Train:ReadTrainWire(2)*(1-Train:ReadTrainWire(25))) or 0)

	self.Ring = (self.ARSRingOverride or self.ARSRing and EnableARS) and 1 or 0
	--[[ if Train.PUAV.ZeroTimer then
		local timer = (CurTime()-Train.PUAV.ZeroTimer)
		if timer >= 0 and timer < 3.5 then
			self.Ring = true
		elseif timer >= 3.5 and timer < 3.5+4 and timer%1 < 0.5 then
			self.Ring = true
		end
	end
	self.Ring = self.Ring or (Train.PUAV.RingArmed and CurTime()-Train.PUAV.RingArmed > 0)--]]

	Train.ROT1:TriggerInput("Set",self["33D"])
	Train.ROT2:TriggerInput("Set",self["33D"])
	if self.ConfirmARS then self.ConfirmARS = false end
end

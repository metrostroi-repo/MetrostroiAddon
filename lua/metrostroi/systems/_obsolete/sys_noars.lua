--------------------------------------------------------------------------------
-- АРС-АЛС
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("NoARS")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()

	--self.Train:LoadSystem("UOS","Relay","Switch", {bass = true})
	--self.Train:LoadSystem("BPS","Relay","Switch",{ bass = true,normally_closed = true })
	-- ALS state
	self.Signal80 = false
	self.Signal70 = false
	self.Signal60 = false
	self.Signal40 = false
	self.Signal0 = false
	self.Special = false
	self.NoFreq = true
	self.RealNoFreq = true

	-- Internal state
	self.Speed = 0
	self.SpeedLimit = 0
	self.NextLimit = 0
	self.Ring = false
	self.Overspeed = false

	-- ARS wires
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
	self["8"] =0

	-- Lamps
	---self.LKT = false
	self.LVD = false
end

function TRAIN_SYSTEM:Outputs()
	return { "2", "8", "20", "31", "32", "29", "33D", "33G", "33Zh",
			 "Speed", "Signal80","Signal70","Signal60","Signal40","Signal0","Special","NoFreq","RealNoFreq",
			 "SpeedLimit", "NextLimit","Ring","KVT","EnableARS","EnableALS","Signal", "UAVA"}
end

function TRAIN_SYSTEM:Inputs()
	return { "IgnoreThisARS","AttentionPedal","Ring" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end

function TRAIN_SYSTEM:Think()

	if self.Train.RV_2.Value < 1 then self.Train.RV_2:TriggerInput("Set",1)
	end


	local Train = self.Train
	local tbl = Train.SubwayTrain and Train.SubwayTrain.ALS
	local haveautostop = tbl and tbl.HaveAutostop
	local autostop = haveautostop and Train.SpeedSign > 0 and Train.Speed > 0.1
	if autostop then
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

			if autostop then
				if IsValid(arsback) then
					if arsback == self.AutostopSignal then
						local ply,mode = Train:GetDriverPly()
						local nomsg = hook.Run("MetrostroiPassedRed",Train,ply,mode,arsback)
						Train.Pneumatic:TriggerInput("Autostop",nomsg and 0 or 1)
						if not nomsg and (not IsValid(Train.FrontTrain) or not IsValid(Train.RearTrain)) then
							RunConsoleCommand("say",Format("%s Passed stop %s signal [%s]",Train:GetDriverName(),arsback.InvationSignal and "InvationSignal" or "",arsback.Name))
						end
						self.AutostopSignal = nil
					end
				end
				if IsValid(ars) then
					if ars.AutoEnabled then
						self.AutostopSignal = ars
					elseif self.AutostopSignal == ars then
						self.AutostopSignal = nil
					end
				end
			end
		end
	end
	self["33D"] = ((Train.Pneumatic and Train.Pneumatic.EmergencyValve) or self.UAVAContacts) and 0 or 1
	if Train.UAVAContact and Train.UAVAContact.Value > 0.5 and not Train.Pneumatic.EmergencyValve then
		self.UAVAContacts = nil
	end
end

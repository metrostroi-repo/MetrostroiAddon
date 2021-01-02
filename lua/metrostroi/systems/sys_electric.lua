--------------------------------------------------------------------------------
-- Train electric base
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("Electric")
function TRAIN_SYSTEM:Initialize()
	-- General power output
	self.Main750V = 0.0
	self.Aux750V = 0.0
	self.Power750V = 0.0
	self.Aux80V = 0.0
	self.Lights80V = 0.0

	-- Resistances
	self.R1 = 1e9
	self.R2 = 1e9
	self.R3 = 1e9
	self.Rs1 = 1e9
	self.Rs2 = 1e9

	self.Rstator13 = 1e9
	self.Rstator24 = 1e9
	self.Ranchor13	= 1e9
	self.Ranchor24	= 1e9

	-- Load internal circuits
	--self.Train:LoadSystem("InternalCircuits","Gen_Int")

	-- Electric network info
	self.Itotal = 0.0
	self.I13 = 0.0
	self.I24 = 0.0
	self.Ustator13 = 0.0
	self.Ustator24 = 0.0
	self.Ishunt13  = 0.0
	self.Istator13 = 0.0
	self.Ishunt24  = 0.0
	self.Istator24 = 0.0

	self.Magnetization = 0

	-- Calculate current through rheostats 1, 2
	self.IR1 = self.Itotal
	self.IR2 = self.Itotal
	self.IRT2 = self.Itotal
	self.T1 = 25
	self.T2 = 25
	self.P1 = 0
	self.P2 = 0
	self.Overheat1 = 0
	self.Overheat2 = 0

	-- Total energy used by train
	self.ElectricEnergyUsed = 0 -- joules
	self.ElectricEnergyDissipated = 0 -- joules
	self.EnergyChange = 0

	-- Signal resistor
	self.RPSignalResistor = FailSim.AddParameter(self,"SignalResistor", { value = 1.0, precision = 0.20 })

	--Train wire outside power
	-- Need many iterations for engine simulation to converge
	self.SubIterations = 16

	self.Train:LoadSystem("GV","Relay","GV_10ZH",{bass=true})

	-- Thyristor contrller
	if self.ThyristorController then
		self.Train:LoadSystem("ThyristorBU5_6","Relay")
		self.ThyristorResistance = 1e9
		self.ThyristorState = 0.0
		self.ThyristorControllerPower = 0
		self.ThyristorControllerWork = 0
	end

	self.Cosume = 0
end


function TRAIN_SYSTEM:Inputs()
	return { "Type" }
end

function TRAIN_SYSTEM:Outputs()
	return { --[[ "R1","R2","R3","Rs1","Rs2",--]] "Itotal","I13","I24","IRT2",
			 --[[ "Ustator13","Ustator24","Ishunt13","Istator13","Ishunt24","Istator24",
			 "Uanchor13","Uanchor24",--]] "U13","U24","Utotal",
			 "T1", "T2", "P1", "P2",
			 "Overheat1","Overheat2",
			 "Main750V", "Power750V", "Aux750V", "Aux80V", "Lights80V",
			 --[[ "ThyristorResistance", "ThyristorState",
			 "ElectricEnergyUsed", "ElectricEnergyDissipated", "EnergyChange",
			 "RPSignalResistor", --]] "Cosume","Type",
			 "ElectricEnergyUsed", "ElectricEnergyDissipated","ThyristorControllerPower","ThyristorControllerWork"}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
	if name == "Type" then
		self.Type = value
	end
end

--------------------------------------------------------------------------------
function TRAIN_SYSTEM:Think(dT,iter)
	local Train = self.Train
	----------------------------------------------------------------------------
	-- Voltages from the third rail
	----------------------------------------------------------------------------
	self.Main750V = Train.TR.Main750V * Train.PNB_1250_1.Value
	self.Aux750V  = Train.TR.Main750V * Train.PNB_1250_2.Value * Train.KVC.Value
	self.Power750V = self.Main750V * Train.GV.Value


	----------------------------------------------------------------------------
	-- Information only
	----------------------------------------------------------------------------
	if Train.PowerSupply then
		self.Aux80V = Train.PowerSupply.XT3_1
		self.Lights80V = Train.PowerSupply.XT3_4
	end


	----------------------------------------------------------------------------
	-- Solve circuits
	----------------------------------------------------------------------------
	if self.ThyristorController then
		self:SolveThyristorController(Train,dT)
	end
	self:SolvePowerCircuits(Train,dT)
	self:SolveInternalCircuits(Train,dT,iter==1)


	----------------------------------------------------------------------------
	-- Calculate current flow out of the battery
	----------------------------------------------------------------------------
	--local totalCurrent = 5*A30 + 63*A24 + 16*A44 + 5*A39 + 10*A80
	--local totalCurrent = 20 + 60*DIP
end


--------------------------------------------------------------------------------
function TRAIN_SYSTEM:SolveInternalCircuits(Train,dT)
	if (self.TrainSolver == "Ezh3") or (self.TrainSolver == "Ema508") then
		local KSH1,KSH2 = 0,0
		local SDRK_Shunt = 1.0
		self.Triggers = { -- FIXME
			--["KSH1"]		= function(V) KSH1 = KSH1 + V end,
			--["KSH2"]		= function(V) KSH2 = KSH2 + V end,
			--["KSB1"]		= function(V) Train.KSB1:TriggerInput("Set",V) KSH1 = KSH1 + V end,
			--["KSB2"]		= function(V) Train.KSB2:TriggerInput("Set",V) KSH2 = KSH2 + V end,
			["KPP"]			= function(V) Train.KPP:TriggerInput("Close",V) end,

			["RPvozvrat"]	= function(V) Train.RPvozvrat:TriggerInput("Open",V) end,
			["RRTuderzh"]	= function(V) Train.RRTuderzh = V end,
			["RRTpod"]		= function(V) Train.RRTpod = V end,
			["RUTpod"]		= function(V) Train.RUTpod = V end,

			["SDPP"]		= function(V) Train.PositionSwitch:TriggerInput("MotorState",-1.0 + 2.0*math.max(0,V)) end,
			["SDRK_Shunt"]	= function(V) SDRK_Shunt = V end,
			["SDRK_Coil"]	= function(V) Train.RheostatController:TriggerInput("MotorCoilState",SDRK_Shunt*math.min(1,math.max(0,V))*(-1.0 + 2.0*Train.RR.Value)) end,
			["SDRK"]		= function(V) Train.RheostatController:TriggerInput("MotorState",V) end,

			["XR3.2"]		= function(V) Train.PowerSupply:TriggerInput("XR3.2",V) end,
			["XR3.3"]		= function(V) Train.PowerSupply:TriggerInput("XR3.3",V) end,
			["XR3.4"]		= function(V) end, --Train.PowerSupply:TriggerInput("XR3.4",V) end,
			["XR3.6"]		= function(V) end, --Train.PowerSupply:TriggerInput("XR3.6",V) end,
			["XR3.7"]		= function(V) end, --Train.PowerSupply:TriggerInput("XR3.7",V) end,
			["XT3.1"]		= function(V) Train.PowerSupply:TriggerInput("XT3.1",Train.Battery.Voltage*V) end,

			["ReverserForward"]		= function(V) Train.RKR:TriggerInput("Open",V) end,
			["ReverserBackward"]	= function(V) Train.RKR:TriggerInput("Close",V) end,
		}
		--local S = Train.InternalCircuits.SolveEzh3(Train,self.Triggers)
		--Train.KSH1:TriggerInput("Set",KSH1)
		--Train.KSH2:TriggerInput("Set",KSH2)

		if self.TrainSolver == "Ezh3" then
			Train.InternalCircuits.SolveEzh3(Train,self.Triggers)
		else
			Train.InternalCircuits.SolveEma508(Train,self.Triggers)
		end
	end
end

function TRAIN_SYSTEM:SolveThyristorController(Train,dT)
     -- General state
    local Active = ((Train.KSB1.Value > 0) or (Train.KSB2.Value > 0)) and (Train.LK2.Value == 1.0)-- and Train.RSU.Value == 0
    local I = (math.abs(Train.Electric.I13) + math.abs(Train.Electric.I24))/2
     --local I = math.abs(Train.Electric.I13 + Train.Electric.I24)/2
     --print(Train.RSU.Value,Active,Train.TR1.Value)
     -- Controllers resistance
     local Resistance = 0.036

     local rnd = 70+math.random()*(10)
     -- Update RV controller signal
    -- Update thyristor controller signal
    if self.ThyristorControllerPower == 0 then
        self.ThyristorTimeout = CurTime()
        self.PrepareElectric = CurTime()
        self.ThyristorState = 0.00
    elseif not Active then
        if Train.LK2.Value == 0.0 then
            self.ThyristorTimeout = CurTime()
            self.PrepareElectric = CurTime()
            self.ThyristorState = 0.00
        end
    else
        local T = 180.0 +
            --80.0*self.ThyristorState*(1-Train:ReadTrainWire(2)) +
            (100.0*Train.Pneumatic.WeightLoadRatio+80.0)*Train:ReadTrainWire(2)
          -- Generate control signal
          local dC = math.min(math.abs(T-I),50)
        if self.PrepareElectric then
            self.ThyristorState = 1
            if I > T*0.2 then
                self.PrepareElectric = false
                self.ThyristorState = 1-math.max(0,math.min(1,((Train.Engines.Speed-50)/32))^0.8)*0.75
            end
        elseif not self.ThyristorDone then
                if I<T then
                     self.ThyristorState = math.max(0,math.min(1,self.ThyristorState+dC*1/rnd*dT))
                else
                     self.ThyristorState = math.max(0,math.min(1,self.ThyristorState-dC*1/rnd*dT))
                end
          end

          -- Generate resistance
          local keypoints = {
                0.10,0.008,
                0.20,0.018,
                0.30,0.030,
                0.40,0.047,
                0.50,0.070,
                0.60,0.105,
                0.70,0.165,
                0.80,0.280,
                0.90,0.650,
                1.00,15.00,
          }
        local TargetField = 0.30 + 0.70*self.ThyristorState
          local Found = false
          for i=1,#keypoints/2 do
                local X1,Y1 = keypoints[(i-1)*2+1],keypoints[(i-1)*2+2]
                local X2,Y2 = keypoints[(i)*2+1],keypoints[(i)*2+2]

                if (not Found) and (not X2) then
                     Resistance = Y1
                     Found = true
                elseif (TargetField >= X1) and (TargetField < X2) then
                     local T = (TargetField-X1)/(X2-X1)
                     Resistance = Y1 + (Y2-Y1)*T
                     Found = true
                end
          end
     end
    -- Allow or deny using manual brakes
    --Train.ThyristorBU5_6:TriggerInput("Set",not self.PrepareElectric and self.ThyristorState > 0.90)
    Train.ThyristorBU5_6:TriggerInput("Set",(not self.PrepareElectric or CurTime()-self.PrepareElectric > 0.8) and self.ThyristorState > 0.95 and self.ThyristorControllerPower > 0)
    -- Set resistance
    self.ThyristorResistance = Resistance + 1e9 * (Active and 0 or 1)
end



--------------------------------------------------------------------------------
function TRAIN_SYSTEM:SolvePowerCircuits(Train,dT)
	if not self.ResistorBlocksInit then
		self.ResistorBlocksInit	 = true
		-- Load resistor blocks
		self.Train:LoadSystem("ResistorBlocks","Gen_Res_710")
		Train.ResistorBlocks.InitializeResistances_81_710(Train)
	end
	self.ExtraResistanceLK5 = Train.KF_47A["L2-L4"  ]*(1-Train.LK5.Value)
	self.ExtraResistanceLK2 = Train.KF_47A["L12-L13"]*(1-Train.LK2.Value)

	if Train.PositionSwitch.SelectedPosition == 1 then -- PS
		self.R1 = Train.ResistorBlocks.R1C1(Train)
		self.R2 = Train.ResistorBlocks.R2C1(Train)
		self.R3 = 0.0
	elseif Train.PositionSwitch.SelectedPosition == 2 then -- PP
		self.R1 = Train.ResistorBlocks.R1C2(Train)
		self.R2 = Train.ResistorBlocks.R2C2(Train)
		self.R3 = 0.0
	elseif Train.PositionSwitch.SelectedPosition >= 3 then -- PT
		self.R1 = Train.ResistorBlocks.R1C1(Train)
		self.R2 = Train.ResistorBlocks.R2C1(Train)
		self.R3 = Train.ResistorBlocks.R3(Train)
	end
	-- Apply LK3, LK4 contactors
	self.R1 = self.R1 + 1e9*(1 - Train.LK3.Value)
	self.R2 = self.R2 + 1e9*(1 - Train.LK4.Value)

	-- Shunt resistance
	self.Rs1 = Train.ResistorBlocks.S1(Train) + 1e9*(1 - Train.KSH1.Value)
	self.Rs2 = Train.ResistorBlocks.S2(Train) + 1e9*(1 - Train.KSH2.Value)

	-- Thyristor contrller
	if self.ThyristorController then
		self.Rs1 = ((self.ThyristorResistance^-1) + (self.Rs1^-1))^-1
		self.Rs2 = ((self.ThyristorResistance^-1) + (self.Rs2^-1))^-1
	end

	-- Calculate total resistance of engines winding
	local RwAnchor = Train.Engines.Rwa*2 -- Double because each set includes two engines
	local RwStator = Train.Engines.Rws*2
	-- Total resistance of the stator + shunt
	self.Rstator13	= (RwStator^-1 + self.Rs1^-1)^-1
	self.Rstator24	= (RwStator^-1 + self.Rs2^-1)^-1
	-- Total resistance of entire motor
	self.Ranchor13	= RwAnchor
	self.Ranchor24	= RwAnchor

	if Train.PositionSwitch.SelectedPosition == 1 then -- PS
		self:SolvePS(Train)
	elseif Train.PositionSwitch.SelectedPosition == 2 then -- PS
		self:SolvePP(Train,Train.RheostatController.SelectedPosition >= 17)
	else
		self:SolvePT(Train)
	end

	-- Calculate current through rheostats 1, 2
	self.IR1 = self.I13
	self.IR2 = self.I24

	-- Calculate induction properties of the motor
	self.I13SH = self.I13SH or self.I13
	self.I24SH = self.I24SH or self.I24

	-- Time constant
	local T13const1 = math.max(16.00,math.min(28.0,(self.R13^2) * 2.0)) -- R * L
	local T24const1 = math.max(16.00,math.min(28.0,(self.R24^2) * 2.0)) -- R * L

	-- Total change
	local dI13dT = T13const1 * (self.I13 - self.I13SH) * dT
	local dI24dT = T24const1 * (self.I24 - self.I24SH) * dT

	-- Limit change and apply it
	if dI13dT > 0 then dI13dT = math.min(self.I13 - self.I13SH,dI13dT) end
	if dI13dT < 0 then dI13dT = math.max(self.I13 - self.I13SH,dI13dT) end
	if dI24dT > 0 then dI24dT = math.min(self.I24 - self.I24SH,dI24dT) end
	if dI24dT < 0 then dI24dT = math.max(self.I24 - self.I24SH,dI24dT) end
	self.I13SH = self.I13SH + dI13dT
	self.I24SH = self.I24SH + dI24dT
	self.I13 = self.I13SH
	self.I24 = self.I24SH

	-- Re-calculate total current and simulate infinite resistance in circuit
	if Train.PositionSwitch.SelectedPosition == 1 then -- PS
		self.I13 = self.I13 * (Train.LK3.Value * Train.LK4.Value * Train.LK1.Value)
		self.I24 = self.I24 * (Train.LK3.Value * Train.LK4.Value * Train.LK1.Value)

		self.I24 = (self.I24 + self.I13)*0.5
		self.I13 = self.I24
		self.Itotal = self.I24
	elseif Train.PositionSwitch.SelectedPosition == 2 then -- PS
		self.I13 = self.I13 * Train.LK3.Value * Train.LK1.Value
		self.I24 = self.I24 * Train.LK4.Value * Train.LK1.Value

		self.Itotal = self.I13 + self.I24
	else -- PT
		self.I13 = self.I13 * Train.LK3.Value*Train.LK4.Value
		self.I24 = self.I24 * Train.LK4.Value*Train.LK3.Value

		self.Itotal = self.I13 + self.I24
	end

	-- Calculate extra information
	self.Uanchor13 = self.I13 * self.Ranchor13
	self.Uanchor24 = self.I24 * self.Ranchor24



	----------------------------------------------------------------------------
	-- Calculate current through stator and shunt
	self.Ustator13 = self.I13 * self.Rstator13
	self.Ustator24 = self.I24 * self.Rstator24

	self.Ishunt13  = self.Ustator13 / self.Rs1
	self.Istator13 = self.Ustator13 / RwStator
	self.Ishunt24  = self.Ustator24 / self.Rs2
	self.Istator24 = self.Ustator24 / RwStator

	if Train.PositionSwitch.SelectedPosition >= 3 then
		local I1,I2 = self.Ishunt13,self.Ishunt24
		self.Ishunt13 = -I2
		self.Ishunt24 = -I1

		I1,I2 = self.Istator13,self.Istator24
		self.Istator13 = -I2
		self.Istator24 = -I1
	end

	-- Calculate current through RT2 relay
	self.IRT2 = math.abs(self.Itotal * Train.PositionSwitch["10_contactor"])

	-- Sane checks
	if self.R1 > 1e5 then self.IR1 = 0 end
	if self.R2 > 1e5 then self.IR2 = 0 end

	-- Calculate power and heating
	local K = 12.0*1e-5
	local H = (10.00+(15.00*Train.Engines.Speed/80.0))*1e-3
	self.P1 = (self.IR1^2)*self.R1
	self.P2 = (self.IR2^2)*self.R2
	self.T1 = (self.T1 + self.P1*K*dT - (self.T1-25)*H*dT)
	self.T2 = (self.T2 + self.P2*K*dT - (self.T2-25)*H*dT)
	self.Overheat1 = math.min(1-1e-12,
		self.Overheat1 + math.max(0,(math.max(0,self.T1-750.0)/400.0)^2)*dT )
	self.Overheat2 = math.min(1-1e-12,
		self.Overheat2 + math.max(0,(math.max(0,self.T2-750.0)/400.0)^2)*dT )

	-- Energy consumption
	self.ElectricEnergyUsed = self.ElectricEnergyUsed + math.max(0,self.EnergyChange)*dT
	self.ElectricEnergyDissipated = self.ElectricEnergyDissipated + math.max(0,-self.EnergyChange)*dT
	--print(self.EnergyChange)
end




--------------------------------------------------------------------------------
function TRAIN_SYSTEM:SolvePS(Train)
	-- Calculate total resistance of the entire series circuit
	local Rtotal = self.Ranchor13 + self.Ranchor24 + self.Rstator13 + self.Rstator24 +
		self.R1 + self.R2 + self.R3 + self.ExtraResistanceLK5
	local CircuitClosed = (self.Power750V*Train.LK1.Value > 0) and 1 or 0

	-- Calculate total current
	self.Utotal = (self.Power750V - Train.Engines.E13 - Train.Engines.E24)*Train.LK1.Value
	self.Itotal = (self.Utotal / Rtotal)*CircuitClosed*(Train.BV and Train.BV.State or 1)

	-- Total resistance (for induction RL circuit)
	self.R13 = Rtotal
	self.R24 = Rtotal

	-- Calculate everything else
	self.I13 = self.Itotal
	self.I24 = self.Itotal
	self.U13 = self.Utotal*(1/2)
	self.U24 = self.Utotal*(1/2)

	-- Energy consumption
	self.EnergyChange = math.abs((self.Itotal^2)*Rtotal)
end

function TRAIN_SYSTEM:SolvePP(Train,inTransition)
	-- Temporary hack for transition to parallel circuits
	local extraR = 0.00 --inTransition and 0.909 or 0.00

	-- Calculate total resistance of each branch
	local R1 = self.Ranchor13 + self.Rstator13 + self.R1 + extraR + self.ExtraResistanceLK5
	local R2 = self.Ranchor24 + self.Rstator24 + self.R2 + extraR + self.ExtraResistanceLK5
	local R3 = 0
	local CircuitClosed = (self.Power750V*Train.LK1.Value > 0) and 1 or 0

	-- Main circuit parameters
	local V = self.Power750V*Train.LK1.Value
	local E1 = Train.Engines.E13
	local E2 = Train.Engines.E24

	-- Calculate current through engines 13, 24
	self.I13 = -((E1*R2 + E1*R3 - E2*R3 - R2*V)/(R1*R2 + R1*R3 + R2*R3))*CircuitClosed*(Train.BV and Train.BV.State or 1)
	self.I24 = -((E2*R1 - E1*R3 + E2*R3 - R1*V)/(R1*R2 + R1*R3 + R2*R3))*CircuitClosed*(Train.BV and Train.BV.State or 1)

	-- Total resistance (for induction RL circuit)
	self.R13 = R1
	self.R24 = R2

	-- Calculate everything else
	self.U13 = self.I13*R1
	self.U24 = self.I24*R2
	self.Utotal = (self.U13 + self.U24)/2
	self.Itotal = self.I13 + self.I24

	-- Energy consumption
	self.EnergyChange = math.abs((self.I13^2)*R1) + math.abs((self.I24^2)*R2)
end

function TRAIN_SYSTEM:SolvePT(Train)
	-- Winding resistances
	local R1 = self.Ranchor13 + self.Rstator13
	local R2 = self.Ranchor24 + self.Rstator24
	-- Total resistance of the entire braking rheostat
	local R3 = self.R1 + self.R2 + self.R3 + self.ExtraResistanceLK2

	-- Main circuit parameters
	local V = self.Power750V*Train.LK1.Value
	local E1 = Train.Engines.E13
	local E2 = Train.Engines.E24

	-- Calculate current through engines 13, 24
	self.I13 = -((E1*R2 + E1*R3 - E2*R3 - R2*V)/(R1*R2 + R1*R3 + R2*R3))*(Train.BV and Train.BV.State or 1)
	self.I24 = -((E2*R1 - E1*R3 + E2*R3 - R1*V)/(R1*R2 + R1*R3 + R2*R3))*(Train.BV and Train.BV.State or 1)
	-- Total resistance (for induction RL circuit)
	self.R13 = R3+((R1^-1 + R2^-1)^-1)
	self.R24 = R3+((R1^-1 + R2^-1)^-1)
	-- Calculate everything else
	self.U13 = self.I13*R1
	self.U24 = self.I24*R2
	self.Utotal = (self.U13 + self.U24)/2
	self.Itotal = self.I13 + self.I24

	-- Energy consumption
	self.EnergyChange = -math.abs(((0.5*self.Itotal)^2)*self.R13)
end

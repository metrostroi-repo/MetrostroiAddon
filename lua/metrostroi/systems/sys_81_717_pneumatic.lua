--------------------------------------------------------------------------------
-- 81-717 pneumatic system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_717_Pneumatic")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize(parameters)
    self.ValveType = 1
    self.DisconnectType = parameters and parameters.br013_1
    -- Position of the train drivers valve
    --  Type 1 (334)
    -- 1 Accelerated charge
    -- 2 Normal charge (brake release)
    -- 3 Closed
    -- 4 Service application
    -- 5 Emergency application
    --
    -- Type 2 (013)
    -- 1 Accelerated charge
    -- 2 Normal charge (brake release)
    -- 3 Closed
    -- 4 Service application
    -- 5 Emergency application
    self.DriverValvePosition = 2
    self.RealDriverValvePosition = self.DriverValvePosition


    -- Pressure in reservoir
    self.ParkingBrakePressure = 0
    self.ReservoirPressure = 0.0 -- atm
    -- Pressure in trains feed line
    self.TrainLinePressure = 8.0 -- atm
    -- Pressure in trains brake line
    self.BrakeLinePressure = 0.0 -- atm
    self.EPKPressure = 0.0 -- atm
    -- Pressure in brake cylinder
    self.BrakeCylinderPressure = 0.0 -- atm
    -- Pressure in the door line
    self.DoorLinePressure = 0.0 -- atm
    self.OldBrakeLinePressure = 0.0
    self.BCPressure = 0

    -- Air distrubutor part
    self.WorkingChamberPressure = 0.0
    --self.AirDistributorReady = false		--заменено на локальные
    --self.OverchargeReleaseValve = false	--переменные
    self.WCChargeValve = true
    self.PN1 = 0
    self.PN2 = 0
    self.cranPres = 0

    --DKPT
    self.Train:LoadSystem("DKPT","Relay","R-52B") --
    -- Valve #1
    self.Train:LoadSystem("PneumaticNo1","Relay")
    -- Valve #2
    self.Train:LoadSystem("PneumaticNo2","Relay")
    -- Автоматический выключатель торможения (АВТ)
    self.Train:LoadSystem("AVT","Relay","AVT-325")
    -- Регулятор давления (АК)
    self.Train:LoadSystem("AK","Relay","AK-11B")
    -- Автоматический выключатель управления (АВУ)
    self.Train:LoadSystem("AVU","Relay","AVU-045")
    -- Блокировка тормозов
    self.Train:LoadSystem("BPT","Relay","")
    -- Блокировка дверей
    self.Train:LoadSystem("BD","Relay","")
    -- Вентили дверного воздухораспределителя (ВДОЛ, ВДОП, ВДЗ)
    self.Train:LoadSystem("VDOL","Relay","", {bass = true})
    self.Train:LoadSystem("VDOP","Relay","", {bass = true})
    self.Train:LoadSystem("VDZ","Relay","", {bass = true})

    -- Разобщение клапана машиниста
    self.Train:LoadSystem("DriverValveDisconnect","Relay","Switch", {bass = true})
    -- Краны двойной тяги
    self.Train:LoadSystem("DriverValveTLDisconnect","Relay","Switch", {bass = true})
    self.Train:LoadSystem("DriverValveBLDisconnect","Relay","Switch", {bass = true})

    self.Train:LoadSystem("EmergencyBrakeValve","Relay","Switch")
    -- Воздухораспределитель
    self.Train:LoadSystem("AirDistributorDisconnect","Relay","Switch")
    --Срывной клапан
    self.Train:LoadSystem("AutostopValve","Relay","Switch")
    --УАВА
    self.Train:LoadSystem("UAVA","Relay","Switch",{ bass = true})
    --self.Train:LoadSystem("UAVAContact","Relay","Switch")
    self.Train:LoadSystem("UAVAC","Relay","",{normally_closed=true,bass=true})
    --Стояночный тормоз
    self.Train:LoadSystem("ParkingBrake","Relay","Switch",{bass = true})
    --ЭПК
    self.Train:LoadSystem("EPK","Relay","Switch",{ bass = true})
    self.Train:LoadSystem("SOT","Relay")
    -- Isolation valves
    self.Train:LoadSystem("FrontBrakeLineIsolation","Relay","Switch", { normally_closed = true, bass = true})
    self.Train:LoadSystem("RearBrakeLineIsolation","Relay","Switch", { normally_closed = true, bass = true})
    self.Train:LoadSystem("FrontTrainLineIsolation","Relay","Switch", { normally_closed = true, bass = true})
    self.Train:LoadSystem("RearTrainLineIsolation","Relay","Switch", { normally_closed = true, bass = true})

    self.Train:LoadSystem("SQ3","Relay","")

    -- Brake cylinder atmospheric valve open
    self.BrakeCylinderValve = 0

    -- Overpressure protection valve open
    self.TrainLineOverpressureValve = 0

    -- Compressor simulation
    self.Compressor = 0 --Simulate overheat with TRK FIXME

    -- Disconnect valve status
    self.DriverValveDisconnectPrevious = 0

    -- Doors state
    self.DoorLeft = false
    self.DoorRight = false
    if not TURBOSTROI then
        self.LeftDoorState = { 0,0,0,0 }
        self.RightDoorState = { 0,0,0,0 }
        self.LeftDoorDir = { 0,0,0,0 }
        self.RightDoorDir = { 0,0,0,0 }
        self.LeftDoorSpeed = {0,0,0,0}
        self.RightDoorSpeed = {0,0,0,0}
        self.LeftDoorStuck = {false, false, false, false}
        self.RightDoorStuck = {false, false, false, false}
        local start = math.Rand(0.6,0.8)
        -- 0.6-1
        self.DoorSpeedMain = -math.Rand(start,math.Rand(start+0.1,start+0.2))
        for i=1,#self.LeftDoorSpeed do
            if math.random() > 0.7 then
                self.LeftDoorSpeed[i] = math.Rand(self.DoorSpeedMain-0.1,self.DoorSpeedMain+0.2)
                self.RightDoorSpeed[i] = math.Rand(self.DoorSpeedMain-0.1,self.DoorSpeedMain+0.2)
            else
                self.LeftDoorSpeed[i] = math.Rand(self.DoorSpeedMain-0.1,self.DoorSpeedMain+0.1)
                self.RightDoorSpeed[i] = math.Rand(self.DoorSpeedMain-0.1,self.DoorSpeedMain+0.1)
            end
        end
    end
    self.TrainLineOpen = false
    self.BrakeLineOpen = false

    self.EmergencyValve = false
    self.EmergencyValveEPK = false
    self.OldValuePos = self.DriverValvePosition

    self.WeightLoadRatio = 0
    self.PassengerDoor = 0
end

function TRAIN_SYSTEM:Inputs()
    return { "BrakeUp", "BrakeDown", "BrakeSet", "ValveType", "Autostop" }
end

function TRAIN_SYSTEM:Outputs()
    return { "BrakeLinePressure", "BrakeCylinderPressure", "DriverValvePosition",
             "ReservoirPressure", "TrainLinePressure", "DoorLinePressure", "WeightLoadRatio", "WorkingChamberPressure" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "BrakeSet" then
        self.DriverValvePosition = math.floor(value)
        if self.ValveType == 1 then
            if self.DriverValvePosition < 1 then self.DriverValvePosition = 1 end
            if self.DriverValvePosition > 5 then self.DriverValvePosition = 5 end
        else
            if self.DriverValvePosition < 1 then self.DriverValvePosition = 1 end
            if self.DriverValvePosition > 7 then self.DriverValvePosition = 7 end
        end
    elseif (name == "BrakeUp") and (value > 0.5) then
        self:TriggerInput("BrakeSet",self.DriverValvePosition+1)
    elseif (name == "BrakeDown") and (value > 0.5) then
        self:TriggerInput("BrakeSet",self.DriverValvePosition-1)
    elseif name == "ValveType" then
        self.ValveType = math.floor(value)
    elseif name == "Autostop" then
        local HaveUAVA = not self.Train.SubwayTrain or not self.Train.SubwayTrain.ARS or not self.Train.SubwayTrain.ARS.NoUAVA
        if HaveUAVA and self.Train.UAVA.Value == 0 then
            self.EmergencyValve = true
            if value ~= 2 then
		self.Train.UAVAC:TriggerInput("Set",0)
		if not self.Train.AutoStopNotify then
		    self.Train.AutoStopNotify = true
		    RunConsoleCommand("say","Autostop braking",self.Train:GetDriverName())
		end
	    end
        end
    end
end


-- TODO: почистить это говно, сделать раздельные звуки пневмы
-- Calculate derivatives
function TRAIN_SYSTEM:equalizeCouplePressure(dT,pressure,train,valve_status,rate,close_rate)
    if not valve_status then return 0 end
    local other
    if IsValid(train) then other = train.Pneumatic end

    -- Get second pressure
    local P2 = 0
    if other then P2 = other[pressure] end
    if (not other) and (valve_status) then
        self.TrainLineOpen = (pressure == "TrainLinePressure")
        rate = close_rate or rate
        --self.TrainLinePressure_dPdT = 0.0
    end

    -- Calculate rate
    local dPdT = rate * (P2 - self[pressure])
    -- Calculate delta
    local dP = dPdT*dT
    if other and other.ReadOnly then
        dP = dP/250
    end
    -- Equalized pressure
    local P0 = (P2 + self[pressure]) / 2
    -- Update pressures
    if dP > 0 then
        self[pressure] = math.min(P0,self[pressure] + dP)
        if other and not other.ReadOnly then
            other[pressure] = math.max(P0,other[pressure] - dP)
        end
    else
        self[pressure] = math.max(P0,self[pressure] + dP)
        if other and not other.ReadOnly then
            other[pressure] = math.min(P0,other[pressure] - dP)
        end
    end
    -- Update delta if losing air
    if self.TrainLineOpen and (pressure == "TrainLinePressure") then
        self[pressure.."_dPdT"] = (self[pressure.."_dPdT"] or 0) + dPdT
    end
    return dP
end
-------------------------------------------------------------------------------
function TRAIN_SYSTEM:UpdatePressures(Train,dT)
    local frontBrakeOpen = Train.FrontBrakeLineIsolation.Value == 0
    local rearBrakeOpen = Train.RearBrakeLineIsolation.Value == 0
    local frontTrainOpen = Train.FrontTrainLineIsolation.Value == 0
    local rearTrainOpen = Train.RearTrainLineIsolation.Value == 0

    local Ft = IsValid(Train.FrontTrain) and Train.FrontTrain
    local Rt = IsValid(Train.RearTrain) and Train.RearTrain
    local Fc, Rc = Train.FrontCouple or Train.FrontBogey, Train.RearCouple or Train.RearBogey
    local Fb,Rb
    if IsValid(Fc) and Fc.DepotPneumo then Fb = Fc.DepotPneumo end
    if IsValid(Rc) and Rc.DepotPneumo then Rb = Rc.DepotPneumo end

    local frontBrakeLeak = false
    local rearBrakeLeak = false
    local frontTrainLeak = false
    local rearTrainLeak = false

    -- Check if both valve on this train and connected train are open
    if Ft and Ft.FrontBrakeLineIsolation then
        if Ft.FrontTrain == Train then -- Nose to nose
            frontBrakeLeak = frontBrakeOpen and Ft.FrontBrakeLineIsolation.Value==1 and 0.08
            frontTrainLeak = frontTrainOpen and Ft.FrontTrainLineIsolation.Value==1 and 0.08
        else -- Rear to nose
            frontBrakeLeak = frontBrakeOpen and Ft.RearBrakeLineIsolation.Value==1 and 0.08
            frontTrainLeak = frontTrainOpen and Ft.RearTrainLineIsolation.Value==1 and 0.08
        end
    else
        frontBrakeLeak = frontBrakeOpen and 0.7
        frontTrainLeak = frontTrainOpen and not Fb and 0.3
    end
    if Rt and Rt.FrontBrakeLineIsolation then
        if Rt.FrontTrain == Train then -- Nose to nose
            rearBrakeLeak = rearBrakeOpen and Rt.FrontBrakeLineIsolation.Value==1 and 0.08
            rearTrainLeak = rearTrainOpen and Rt.FrontTrainLineIsolation.Value==1 and 0.08
        else -- Rear to nose
            rearBrakeLeak = rearBrakeOpen and Rt.RearBrakeLineIsolation.Value==1 and 0.08
            rearTrainLeak = rearTrainOpen and Rt.RearTrainLineIsolation.Value==1 and 0.08
        end
    else
        rearBrakeLeak = rearBrakeOpen and 0.7
        rearTrainLeak = rearTrainOpen and not Rb and 0.3
    end

    -- Equalize pressure
    local Fl=math.min(0,self:equalizeCouplePressure(dT,"BrakeLinePressure",frontBrakeLeak==false and Ft,frontBrakeOpen,100,frontBrakeLeak or 0.08)*3)*(frontBrakeLeak and 1 or 0)
    local Rl=math.min(0,self:equalizeCouplePressure(dT,"BrakeLinePressure",rearBrakeLeak==false and Rt,rearBrakeOpen,100,rearBrakeLeak or 0.08)*3)*(rearBrakeLeak and 1 or 0)

    Fl=Fl+math.min(0,self:equalizeCouplePressure(dT,"TrainLinePressure",frontTrainLeak==false and Ft or Fb,frontTrainOpen,100,frontTrainLeak or 0.08)*10)*(frontTrainLeak and 1 or 0)
    Rl=Rl+math.min(0,self:equalizeCouplePressure(dT,"TrainLinePressure",rearTrainLeak==false and Rt or Rb,rearTrainOpen,100,rearTrainLeak or 0.08)*10)*(rearTrainLeak and 1 or 0)

    self.TrainLineOpen=frontTrainLeak or rearTrainLeak
    self.BraieLineOpen=frontBrakeLeak or rearBrakeLeak
    Train:SetPackedRatio("FrontLeak",Fl)
    Train:SetPackedRatio("RearLeak",Rl)
end

function TRAIN_SYSTEM:equalizePressure(dT,pressure,target,rate,fill_rate,no_limit,smooth)
    if fill_rate and (target > self[pressure]) then rate = fill_rate end

    -- Calculate derivative
    local dPdT = rate
    if target < self[pressure] then dPdT = -dPdT end
    local dPdTramp = math.min(1.0,math.abs(target - self[pressure])*(smooth or 0.5))
    dPdT = dPdT*dPdTramp

    -- Update pressure
    self[pressure] = self[pressure] + dT * dPdT
    self[pressure] = math.max(0.0,math.min(16.0,self[pressure]))
    self[pressure.."_dPdT"] = (self[pressure.."_dPdT"] or 0) + dPdT
    if no_limit ~= true then
        if self[pressure] == 0.0  then self[pressure.."_dPdT"] = 0 end
        if self[pressure] == 16.0 then self[pressure.."_dPdT"] = 0 end
    end
    return dPdT
end
-------------------------------------------------------------------------------
function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    self.WeightLoadRatio = math.max(0,math.min(1,(Train:GetNW2Float("PassengerCount")/200)))
    --self.WeightLoadRatio = (Train.R_ZS and Train.R_ZS.Value > 0 and 0.5 or 0) + (Train.R_G and Train.R_G.Value > 0 and 0.5 or 0)
    ----------------------------------------------------------------------------
    -- Accumulate derivatives
    self.TrainLinePressure_dPdT = 0.0
    self.BrakeLinePressure_dPdT = 0.0
    self.EPKPressure_dPdT = 0.0
    self.ReservoirPressure_dPdT = 0.0
    self.BrakeCylinderPressure_dPdT = 0.0
    self.ParkingBrakePressure_dPdT = 0.0
    self.WorkingChamberPressure_dPdT = 0.0

    local rnd = math.random(1,10)
    local offs = 0.1
    self.KM013offset = self.KM013offset or math.Clamp(5.1 + (rnd >= 3 and rnd <= 7 and offs or -offs),5.0,5.2)

    -- Reduce pressure for brake line
    self.TrainToBrakeReducedPressure = math.min(self.KM013offset,self.TrainLinePressure) -- * 0.725)
    -- Feed pressure to door line
    self.DoorLinePressure = self.TrainToBrakeReducedPressure * 0.90
    local trainLineConsumption_dPdT = 0.0
    local wagc = Train:GetWagonCount()
    local HaveEPK = not Train.SubwayTrain or not Train.SubwayTrain.ARS or not Train.SubwayTrain.ARS.NoEPK

    local BLDisconnect,pr_speed = true,1
    -- работа срывного клапана
    if Train.AutostopValve.Value > 0 then
	self:TriggerInput("Autostop",self.BrakeLinePressure > 1.86 and 1 or 2)	--value == 2 — просто открыть срывной клапан без размыкания контактов УАВА
    end

    if self.ValveType == 1 then
        BLDisconnect = Train.DriverValveBLDisconnect.Value > 0
        local TLDisconnect = Train.DriverValveTLDisconnect.Value > 0
        pr_speed = 1*wagc--*((self.BrakeLinePressure-self.ReservoirPressure)/0.6) --2
        if self.Leak or self.BraieLineOpen then pr_speed = pr_speed*0.3 end
        -- 334: 1 Fill reservoir from train line, fill brake line from train line
        if (self.RealDriverValvePosition == 1) then
            if TLDisconnect or self.ReservoirPressure > self.TrainLinePressure then
                self:equalizePressure(dT,"ReservoirPressure", self.TrainLinePressure, 1,nil,nil,2)
                if BLDisconnect then
                    self:equalizePressure(dT,"BrakeLinePressure", self.TrainLinePressure, pr_speed,nil,nil,2)
                end
            end
        end

        -- 334: 2 Brake line, reservoir replenished from brake line reductor
        if (self.RealDriverValvePosition == 2) then
            if TLDisconnect or self.ReservoirPressure > self.TrainToBrakeReducedPressure*1.05 then
                self:equalizePressure(dT,"ReservoirPressure", self.TrainToBrakeReducedPressure*1.05, 0.55,nil,nil,2)
            end
        end

        -- 334: 3 Close all valves
        if (self.RealDriverValvePosition == 3) then
            -- Typical leak
            self:equalizePressure(dT,"ReservoirPressure", 0.00, 0.001)
        end

        -- 334: 4 Reservoir open to atmosphere, brake line equalizes with reservoir
        if (self.RealDriverValvePosition == 4) then
            self:equalizePressure(dT,"ReservoirPressure", 0.0,0.55,nil,nil,2)--0.35)-0.55
        end

        -- 334: 5 Reservoir and brake line open to atmosphere
        if (self.RealDriverValvePosition == 5) then
            self:equalizePressure(dT,"ReservoirPressure", 0.0, 1.00)--,nil,nil,2)--1.70
            if BLDisconnect then
                self:equalizePressure(dT,"BrakeLinePressure", 0.0, pr_speed,nil,nil,2)
            end
        end
        if BLDisconnect and (TLDisconnect or self.ReservoirPressure < self.BrakeLinePressure) then
            --local pr_speed = wagc*(1.375) --2
            local pr_speed = 1.25*wagc
            if self.Leak or self.BraieLineOpen then pr_speed = pr_speed*0.3 end
            Train:SetPackedRatio("ReservoirPressure_dPdT",self:equalizePressure(dT,"BrakeLinePressure", self.ReservoirPressure,pr_speed,pr_speed*3,nil)/wagc*2)
        else
            Train:SetPackedRatio("ReservoirPressure_dPdT",0)
        end
        trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeLinePressure_dPdT)
        trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.ReservoirPressure_dPdT)*0.05
    else
        pr_speed = 1.25*wagc --2
        if self.Leak or self.BrakeLineOpen then pr_speed = pr_speed*0.7 end
        BLDisconnect = self.DisconnectType and Train.DriverValveBLDisconnect.Value > 0 or Train.DriverValveDisconnect.Value > 0
        local TLDisconnect = self.DisconnectType and Train.DriverValveTLDisconnect.Value > 0 or Train.DriverValveDisconnect.Value > 0
        -- 013: 1 Overcharge
        if (self.RealDriverValvePosition == 1) and BLDisconnect and (TLDisconnect or self.BrakeLinePressure > self.TrainLinePressure) then
	    self:equalizePressure(dT,"BrakeLinePressure", math.min(6.4,self.TrainLinePressure), pr_speed,Train.EPKC and Train.EPKC.Value==0 and Train.EPK.Value > 0 and pr_speed*2.2 or pr_speed*0.35, nil, 1.0)
        end

        -- 013: 2 Normal pressure
        if (self.RealDriverValvePosition == 2) and BLDisconnect and (TLDisconnect or self.BrakeLinePressure > 1.01*math.min(self.KM013offset,self.TrainToBrakeReducedPressure)) then
            self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(self.KM013offset,self.TrainToBrakeReducedPressure), pr_speed,Train.EPKC and Train.EPKC.Value==0 and Train.EPK.Value > 0 and pr_speed*2 or pr_speed*0.35, nil, 1.0)-- nil, 1.0)
        end

        -- 013: 3 4.3 Atm
        if (self.RealDriverValvePosition == 3) and BLDisconnect and (TLDisconnect or self.BrakeLinePressure > 1.01*math.min(4.3,self.TrainToBrakeReducedPressure)) then
            self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(4.3,self.TrainToBrakeReducedPressure), pr_speed,pr_speed*0.35, nil, 1.0)
        end

        -- 013: 4 4.0 Atm
        if (self.RealDriverValvePosition == 4) and BLDisconnect and (TLDisconnect or self.BrakeLinePressure > 1.01*math.min(4.0,self.TrainToBrakeReducedPressure)) then
            self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(4.0,self.TrainToBrakeReducedPressure), pr_speed,pr_speed*0.35, nil, 1.0)
        end

        -- 013: 5 3.7 Atm
        if (self.RealDriverValvePosition == 5) and BLDisconnect and (TLDisconnect or self.BrakeLinePressure > 1.01*math.min(3.7,self.TrainToBrakeReducedPressure)) then
            self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(3.7,self.TrainToBrakeReducedPressure), pr_speed,pr_speed*0.35, nil, 1.0)
        end

        -- 013: 6 3.0 Atm
        if (self.RealDriverValvePosition == 6) and BLDisconnect and (TLDisconnect or self.BrakeLinePressure > 1.01*math.min(3.0,self.TrainToBrakeReducedPressure)) then
            self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(3.0,self.TrainToBrakeReducedPressure), pr_speed,pr_speed*0.35, nil, 1.0)
        end

        -- 013: 7 0.0 Atm
        if (self.RealDriverValvePosition == 7) and BLDisconnect and (TLDisconnect or self.BrakeLinePressure > 0.0) then
            self:equalizePressure(dT,"BrakeLinePressure", 0.0, 0.6 + pr_speed*math.exp(math.min(0,self.BrakeLinePressure - 2.8)*1.0),pr_speed*0.35, nil, 1.0)
        end
        trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeLinePressure_dPdT)
    end
    local leak
    self.Leak = false
    local pr_speed = 1.25*wagc
    if HaveEPK and Train.EPKC then
        local leak = 0
        local epkDiff = math.abs(self.EPKPressure-self.BrakeLinePressure)
        if BLDisconnect and Train.EPK.Value>0 then
            if Train.EPKC.Value>0 then
                self:equalizePressure(dT,"EPKPressure", self.BrakeLinePressure,math.min(1,epkDiff)*6--[[ pr_speed*math.min(1,epkDiff)*2--]] ,math.min(1,epkDiff)*26,false,4*epkDiff*2)
            end
            if self.EPKPressure<self.BrakeLinePressure and math.abs(self.EPKPressure-self.BrakeLinePressure)>0.3 then
                leak = self:equalizePressure(dT,"BrakeLinePressure", self.EPKPressure,pr_speed*epkDiff/1.28,pr_speed*epkDiff/1.28)
                --[[ if self.ValveType==1 then
                    leak = self:equalizePressure(dT,"ReservoirPressure", self.EPKPressure,epkDiff/2,epkDiff/2)
                end--]]
            end
            self.Leak = self.Leak or leak<-0.1
        end
        if Train.EPK.Value == 0 or Train.EPKC.Value == 0 then
            leak = leak+self:equalizePressure(dT,"EPKPressure", 0,16,false,false,5)
        end
        if self.ValveType==2 and not BLDisconnect then
            self:equalizePressure(dT,"EPKPressure", 0,16,false,false,5)
        end
        Train:SetPackedRatio("EmergencyValveEPK_dPdT", -leak/wagc)
    end
    if self.ValveType == 1 then
        Train:SetPackedRatio("Crane_dPdT", self.ReservoirPressure_dPdT )
    else
        Train:SetPackedRatio("Crane_dPdT", self.BrakeLinePressure_dPdT/wagc*3 )
    end
    if self.EmergencyValveDisable then--and (self.BrakeLinePressure-self.OldBrakeLinePressure)>0.01 then
        self.EmergencyValveDisable=false
        self.EmergencyValve=false
	Train.AutoStopNotify=false
    end
    self.OldBrakeLinePressure = self.BrakeLinePressure
    local leak = 0
    if self.EmergencyValve then
	local leakst = BLDisconnect and math.max(0.3,math.log(self.BrakeLinePressure,1.2) - 2.5) or math.max(1.6,math.log(0.63*self.BrakeLinePressure,1.15))
        leak = self:equalizePressure(dT,"BrakeLinePressure", 0.0,leakst*wagc/6)--,false,false,10)
        if Train.UAVA.Value > 0 or (self.BrakeLinePressure < 1.8 and Train.AutostopValve.Value == 0) then	--пока держим ЛКМ нажатой, срывной клапан открыт
            self.EmergencyValveDisable = true
        end
        self.Leak = true
    end

    local UAVABlocked = (self.BrakeLinePressure>1.8 and Train.UAVA.Value==0)
    if (Train.UAVA.Blocked>0) ~= UAVABlocked then
        Train.UAVA:TriggerInput("Block",UAVABlocked and 1 or 0)
    end

    local UAVACBlocked = self.EmergencyValve and not self.EmergencyValveDisable
    if (Train.UAVAC.Blocked>0) ~= UAVACBlocked then
        Train.UAVAC:TriggerInput("Block",UAVACBlocked and 1 or 0)
    end

    Train:SetPackedRatio("EmergencyValve_dPdT", -1.8*leak/wagc)				--Регулировка свиста срывного клапана

    local leak = 0
    if Train.EmergencyBrakeValve and Train.EmergencyBrakeValve.Value > 0.5 then
        --local leakst = (1.6*(Train:GetWagonCount())*(self.BrakeLinePressure-math.min(2.5,self.TrainToBrakeReducedPressure))*0.9)
        leak = self:equalizePressure(dT,"BrakeLinePressure", 0.0,(1.1*wagc)*2,false,false,1)
        self.Leak = true
    end
    Train:SetPackedRatio("EmergencyBrakeValve_dPdT", -leak/wagc)
    ----------------------------------------------------------------------------
    -- Fill brake cylinders
    if self.WCChargeValve == true then
	self:equalizePressure(dT,"WorkingChamberPressure",self.BrakeLinePressure,0.107,nil,nil,1.0)	--simulate 0.8mm hole btw BL and working chambers
    end
    --self.AirDistributorReady = self.WorkingChamberPressure >= 2.2
    local aird_ready = self.WorkingChamberPressure >= 2.2
    self.WCChargeValve = not ((self.WorkingChamberPressure - self.BrakeLinePressure) > 0.2 and (self.WorkingChamberPressure - self.BrakeLinePressure) < 2.5)
    --self.OverchargeReleaseValve = self.WorkingChamberPressure > 5.2 and not self.WCChargeValve
    local KLSZ = self.WorkingChamberPressure > 5.2 and not self.WCChargeValve
    if KLSZ then	
	self:equalizePressure(dT,"WorkingChamberPressure",0.0,0.22)	-- КЛСЗ
    end

    --trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.WorkingChamberPressure_dPdT*0.2)
    local _offset2 = self.Train.AR63 and 2.5 or 2.4
    self.GN2Offset = self.GN2Offset or math.random(20,100)*0.002 + _offset2
    local _offset1 = self.Train.AR63 and 0.9 or 0.8
    self.GN1Offset = self.GN1Offset or math.random(20,100)*0.002 + _offset1
    self.BcBl = (self.GN2Offset + self.WeightLoadRatio*1.3)/1.93
    if Train.AirDistributorDisconnect.Value == 0 and aird_ready then
        -- Valve #1
        if (Train.PneumaticNo1.Value == 1.0) and (Train.PneumaticNo2.Value == 0.0) then
            if self.PN1 < self.GN1Offset then
                self.PN1 = math.min(self.TrainLinePressure,self.GN1Offset)
            end
        elseif Train.PneumaticNo1.Value == 0 and self.PN1 > 0.0 then
            self.PN1 = math.max(0,self.PN1-math.exp(3.6*(self.BrakeCylinderPressure - self.GN1Offset))*1.7*dT)
        end
        -- Valve #2
        if Train.PneumaticNo2.Value == 1.0 then
       	    self.PN2 = math.min(self.TrainLinePressure,(self.GN2Offset + self.WeightLoadRatio*1.3))
            if self.BePN2 == false and self.BrakeCylinderPressure > 1.6 then
                Train:PlayOnce("PN2end","stop")
            end
            self.BePN2 = true
        elseif self.PN2 > 0.0 then
            self.PN2 = self.BrakeCylinderPressure > 0.4 and 0.2 or self.PN2 - 0.5*dT
        end
        local WcBl = (self.BrakeLinePressure < 3.55 and 0.45*(self.WorkingChamberPressure - 2.2) or self.BrakeLinePressure > 3.65 and self.BrakeLinePressure*(self.BrakeLinePressure > 4.5 and self.BrakeLinePressure_dPdT > 0.02 and 1.06 or 1))
	--self.cranPres = WcBl and math.max(0,math.min(self.GN2Offset + self.WeightLoadRatio*1.3,self.BcBl*(self.WorkingChamberPressure - WcBl)*(self.BrakeLinePressure > self.KM013offset and 0.6 or 1))) or self.cranPres
        self.cranPres = WcBl and math.max(0,self.BcBl*(self.WorkingChamberPressure - WcBl)*(self.BrakeLinePressure > self.KM013offset and (0.56 + self.PN1*0.43) or 1)) or self.cranPres
	local targetPressure = math.max(0,math.min(self.GN2Offset + self.WeightLoadRatio*1.3, (self.cranPres < (self.PN1 + self.WeightLoadRatio*0.7) and (Train.PneumaticNo1.Value == 1.0) and (self.PN1 + self.WeightLoadRatio*0.7) or self.PN1) + self.PN2 + self.cranPres))
        if math.abs(self.BrakeCylinderPressure - targetPressure) > 0.150 then
            self.BrakeCylinderValve = 1
        end
        if math.abs(self.BrakeCylinderPressure - targetPressure) < 0.025 then
            self.BrakeCylinderValve = 0
        end
        if self.BrakeCylinderValve == 1 then
            --self:equalizePressure(dT,"BrakeCylinderPressure", math.min(self.GN2Offset + self.WeightLoadRatio*1.3,targetPressure), 1, 3.5, nil, (self.BrakeLinePressure_dPdT > 0.02) and (0.9+math.Clamp((1 - self.BrakeCylinderPressure)*0.9,0,1.8)) or 1)
            self:equalizePressure(dT,"BrakeCylinderPressure", math.min(self.GN2Offset + self.WeightLoadRatio*1.3,targetPressure), 1, 3.5, nil, 1)
        end
        trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeCylinderPressure_dPdT*0.5)
    elseif Train.AirDistributorDisconnect.Value ~= 0 then
        self:equalizePressure(dT,"BrakeCylinderPressure", 0.0, 2.00)
        self:equalizePressure(dT,"WorkingChamberPressure", 0.0, 2.00)	--имитируем потягивание за тросик отпускного клапана
    end
    if (self.BrakeCylinderPressure > 0.2 and self.BrakeCylinderPressure_dPdT > 0.1 or self.BrakeCylinderPressure_dPdT > 1) and not self.BrakeEngaged then
        self.BrakeEngaged = true
        Train:PlayOnce("brake","bass",1,math.Clamp(self.BrakeCylinderPressure_dPdT,0.7,1.2))
    end
    if self.BrakeCylinderPressure < 1 and self.BrakeCylinderPressure_dPdT < -0.1 and self.BrakeEngaged then
        self.BrakeEngaged = false
    end
    Train:SetPackedRatio("BrakeCylinderPressure_dPdT", self.BrakeCylinderPressure_dPdT)
    self.TrainLinePressure = self.TrainLinePressure-math.max(0,self.BrakeCylinderPressure_dPdT*0.002)
    if Train.PneumaticNo2.Value == 0 then
        if self.BePN2 == true then
            self.BePN2 = CurTime()
        elseif self.BePN2 and self.BrakeCylinderPressure_dPdT > -0.2 then
            Train:PlayOnce("PN2end","bass",math.Clamp(math.min(1,(CurTime()-self.BePN2)/1.3)*((3.2-self.BrakeCylinderPressure)/1.2),0,1))
            self.BePN2 = false
        end
    end
    if self.BePN2 == false and (self.BrakeCylinderPressure_dPdT >= 0.2) then
        self.BePN2 = nil
        Train:PlayOnce("PN2end","stop")
    end

    --Parking brake simulation
    local PBPressure = math.Clamp(self.TrainLinePressure/5,0,1)*2.7
    if Train.ParkingBrake.Value == 0 then
        self:equalizePressure(dT,"ParkingBrakePressure", PBPressure, 10,10,nil,0.5)
    else
        self:equalizePressure(dT,"ParkingBrakePressure", 0, 3,10,nil,0.5)
    end
    Train:SetPackedRatio("ParkingBrakePressure_dPdT",self.ParkingBrakePressure_dPdT)
    trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.ParkingBrakePressure_dPdT*0.5)

    -- Simulate cross-feed between different wagons
    self:UpdatePressures(Train,dT)

    ----------------------------------------------------------------------------
    -- Simulate compressor operation and train line depletion
    self.Compressor = Train.KK.Value * (Train.Electric.Aux750V > 550 and 1 or 0)
    self.TrainLinePressure = self.TrainLinePressure - 0.07*trainLineConsumption_dPdT*dT -- 0.190 --0.170
    if self.Compressor == 1 then self:equalizePressure(dT,"TrainLinePressure", 10.0, 0.04) end
    self:equalizePressure(dT,"TrainLinePressure", 0,0.001)
    -- Overpressure
    if self.TrainLinePressure > 9.2 then self.TrainLineOverpressureValve = 1 end
    if self.TrainLineOverpressureValve == 1 then
        self:equalizePressure(dT,"TrainLinePressure", 0.0, (self.TrainLinePressure-(self.Compressor == 1 and 6.5 or 4))*0.6)	--was 0.2
        self.TrainLineOpen = true
        if self.TrainLinePressure < 5.2 then self.TrainLineOverpressureValve = 0 end
    end

    ----------------------------------------------------------------------------
    -- Pressure triggered relays
    Train.AVT:TriggerInput("Open", self.BrakeCylinderPressure > 1.9) -- 1.8 - 2.0
    Train.AVT:TriggerInput("Close",self.BrakeCylinderPressure < 0.9) -- 0.9 - 1.5
    Train.AK:TriggerInput( "Open", self.TrainLinePressure > 8.2)
    Train.AK:TriggerInput( "Close",self.TrainLinePressure < 6.3)
    Train.AVU:TriggerInput("Open", self.BrakeLinePressure < 2.7) -- 2.7 - 2.9
    Train.AVU:TriggerInput("Close",self.BrakeLinePressure > 3.5) -- 3.5 - 3.7
    Train.SOT:TriggerInput("Open", self.EPKPressure < 1.3) -- 2.7 - 2.9
    Train.SOT:TriggerInput("Close", self.EPKPressure > 1.5) -- 2.7 - 2.9
    Train.BPT:TriggerInput("Set",  (IsValid(Train.FrontBogey) and Train.FrontBogey.BrakeCylinderPressure+(not Train.FrontBogey.DisableParking and Train.FrontBogey.ParkingBrakePressure or 0) or self.BrakeCylinderPressure)>0.3)
    Train.DKPT:TriggerInput("Set", self.BrakeCylinderPressure > 0.3) -- 1.8 - 2.0
    Train.SQ3:TriggerInput("Set",  Train.PassengerDoor and 0 or 1)

    ----------------------------------------------------------------------------
    -- Simulate doors opening, closing
    if self.DoorLinePressure > 3.5 then
        if (Train.VDOL.Value == 1.0) and (Train.VDOP.Value == 0.0) and not self.DoorLeft then
            self.DoorLeft = true
        end
        if (Train.VDOL.Value == 0.0) and (Train.VDOP.Value == 1.0) and not self.DoorRight then
            self.DoorRight = true
        end
        if (Train.VDZ.Value == 1.0 or Train.VDOL.Value == 1.0 and Train.VDOP.Value == 1.0 or self.RZDTimer) and (self.DoorLeft or self.DoorRight) then
            if not self.OpenWaitL or CurTime()-self.OpenWaitL < 0.2 then
                self.DoorLeft = false
            end
            if not self.OpenWaitR or CurTime()-self.OpenWaitR < 0.2 then
                self.DoorRight = false
            end
        else
            self.CloseValue = nil
        end
        if Train.VDOL.Value == 1.0 and Train.VDOP.Value == 1.0 then
            self.RZDTimer = CurTime()
        elseif self.RZDTimer and CurTime()-self.RZDTimer > 0.1 then
            self.RZDTimer = nil
        end
    end
    if self.VDOL ~= Train.VDOL.Value then
        self.VDOL = Train.VDOL.Value
        self:equalizePressure(dT,"TrainLinePressure", 0.0, 0.3)
        if self.VDLoud and self.VDOL > 0 and not Train.LeftDoorsOpen then Train:PlayOnce("vdol_loud"..self.VDLoudID,"bass",self.VDLoud) end
    end
    if self.VDOP ~= Train.VDOP.Value then
        self.VDOP = Train.VDOP.Value
        self:equalizePressure(dT,"TrainLinePressure", 0.0, 0.3)
        if self.VDLoud and self.VDOP > 0 and not Train.RightDoorsOpen then Train:PlayOnce("vdop_loud"..self.VDLoudID,"bass",self.VDLoud) end
    end
    if self.VDZ ~= Train.VDZ.Value then
        self.VDZ = Train.VDZ.Value
        self:equalizePressure(dT,"TrainLinePressure", 0.0, 0.3)
        if self.VDLoud and self.VDZ > 0 and (Train.RightDoorsOpen or Train.LeftDoorsOpen) then Train:PlayOnce("vzd_loud"..self.VDLoudID,"bass",self.VDLoud) end
    end
    if Train.CanStuckPassengerLeft then
        for i in ipairs(self.LeftDoorStuck) do
            self.LeftDoorStuck[i] = math.random() < (0.6+math.min(2,2-self.LeftDoorSpeed[i])*0.2)*Train.CanStuckPassengerLeft*0.6 and (math.random() > 0.7 and CurTime()+math.random()*15)
        end
        Train.CanStuckPassengerLeft = false
    end
    if Train.CanStuckPassengerRight then
        for i in ipairs(self.RightDoorStuck) do
            self.RightDoorStuck[i] = math.random() < (0.6+math.min(2,2-self.LeftDoorSpeed[i])*0.2)*Train.CanStuckPassengerRight*0.6 and (math.random() > 0.7 and CurTime()+math.random()*15)
        end
        Train.CanStuckPassengerRight = false
    end

    Train.LeftDoorsOpen = false
    Train.RightDoorsOpen = false
    local openL = true
    local openR = true
    for i=1,4 do
        self.LeftDoorDir[i] = math.Clamp(self.LeftDoorDir[i]+dT/(self.DoorLeft and self.LeftDoorSpeed[i] or -self.LeftDoorSpeed[i]),-1,1)
        self.RightDoorDir[i] = math.Clamp(self.RightDoorDir[i]+dT/(self.DoorRight and self.RightDoorSpeed[i] or -self.RightDoorSpeed[i]),-1,1)
        self.LeftDoorState[i]  = math.Clamp(self.LeftDoorState[i] + ((self.LeftDoorDir[i]/self.LeftDoorSpeed[i])*dT),self.LeftDoorStuck[i] and 0.3 or 0,1)
        if self.LeftDoorState[i] == 0 or self.LeftDoorState[i] == 1 then self.LeftDoorDir[i] = 0 end
        self.RightDoorState[i]  = math.Clamp(self.RightDoorState[i] + ((self.RightDoorDir[i]/self.RightDoorSpeed[i])*dT),self.RightDoorStuck[i] and 0.3 or 0,1)
        if self.RightDoorState[i] == 0 or self.RightDoorState[i] == 1 then self.RightDoorDir[i] = 0 end
        if not Train.LeftDoorsOpen and self.LeftDoorState[i] > 0 then
            Train.LeftDoorsOpen = true
        end
        if self.LeftDoorState[i] > self.LeftDoorSpeed[i]/20 then self.OpenWaitL = false end
        if self.RightDoorState[i] > self.LeftDoorSpeed[i]/20 then self.OpenWaitR = false end
        if self.LeftDoorState[i] > 0 then openL = false end
        if self.RightDoorState[i] > 0 then openR = false end
        if not Train.RightDoorsOpen and self.RightDoorState[i] > 0 then
            Train.RightDoorsOpen = true
        end
        Train:SetPackedRatio("DoorL"..i,self.LeftDoorState[i])
        Train:SetPackedRatio("DoorR"..i,self.RightDoorState[i])
        if self.LeftDoorStuck[i] and (self.DoorLeft or type(self.LeftDoorStuck[i]) == "number" and CurTime()-self.LeftDoorStuck[i] > 0) then
            self.LeftDoorStuck[i] = false
        end
        if self.RightDoorStuck[i] and (self.DoorRight or type(self.RightDoorStuck[i]) == "number" and CurTime()-self.RightDoorStuck[i] > 0) then
            self.RightDoorStuck[i] = false
        end
        Train:SetPackedBool("DoorLS"..i,self.LeftDoorStuck[i])
        Train:SetPackedBool("DoorRS"..i,self.RightDoorStuck[i])
    end
    if openL and not self.OpenWaitL then self.OpenWaitL = CurTime() end
    if openR and not self.OpenWaitR then self.OpenWaitR = CurTime() end
    Train:SetPackedBool("DoorL",self.DoorLeft)
    Train:SetPackedBool("DoorR",self.DoorRight)
    Train.BD:TriggerInput("Set",not Train.RightDoorsOpen and not Train.LeftDoorsOpen)
    Train.LeftDoorsOpening = self.DoorLeft
    Train.RightDoorsOpening = self.DoorRight

    ----------------------------------------------------------------------------
    if self.DriverValveDisconnectPrevious ~= Train.DriverValveDisconnect.Value then
        self.DriverValveDisconnectPrevious = Train.DriverValveDisconnect.Value
        if self.DriverValveDisconnectPrevious == 0 and self.TrainLinePressure>1 then
            self.DVDOffTimer = CurTime()
            Train:PlayOnce("pneumo_disconnect2","cabin",0.9)
        elseif self.TrainLinePressure>1 then
            self.DVDOffTimer = nil
            Train:PlayOnce("pneumo_disconnect1","cabin",0.9)
        end
    end
    if self.DVDOffTimer then
        if CurTime()-self.DVDOffTimer < 0.45 then
            local pr_speed = 1.3*(Train:GetWagonCount()) --2
            self:equalizePressure(dT,"BrakeLinePressure", 0,pr_speed)
        else
            self.DVDOffTimer = nil
        end
    end

    ----------------------------------------------------------------------------
    -- FIXME
    Train:SetNW2Bool("FbI",Train.FrontBrakeLineIsolation.Value ~= 0)
    Train:SetNW2Bool("RbI",Train.RearBrakeLineIsolation.Value ~= 0)
    Train:SetNW2Bool("FtI",Train.FrontTrainLineIsolation.Value ~= 0)
    Train:SetNW2Bool("RtI",Train.RearTrainLineIsolation.Value ~= 0)
    Train:SetNW2Bool("AD",Train.AirDistributorDisconnect.Value == 0)



    local ValveType = self.ValveType > 1
    self.Timer = self.Timer or CurTime()
    if ((CurTime() - self.Timer > 0.10) and (self.DriverValvePosition > self.RealDriverValvePosition)) then
        self.Timer = CurTime()
        if not ValveType then
            if self.RealDriverValvePosition ~= 3 then
                Train:PlayOnce("br_334",self.RealDriverValvePosition.."-"..(self.RealDriverValvePosition+1))
            end
        else
            Train:PlayOnce("br_013","cabin")
        end
        self.RealDriverValvePosition = self.RealDriverValvePosition + 1
    end
    if ((CurTime() - self.Timer > 0.10) and (self.DriverValvePosition < self.RealDriverValvePosition)) then
        self.Timer = CurTime()
        if not ValveType then
            if self.RealDriverValvePosition ~= 5 then
                Train:PlayOnce("br_334",self.RealDriverValvePosition.."-"..(self.RealDriverValvePosition-1))
            end
        else
            Train:PlayOnce("br_013","cabin")
        end
        self.RealDriverValvePosition = self.RealDriverValvePosition - 1
    end
end

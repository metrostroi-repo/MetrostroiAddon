--------------------------------------------------------------------------------
-- 81-720 pneumatic system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_720_Pneumatic")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    -- (013)
    -- 1 Accelerated charge
    -- 2 Normal charge (brake release)
    -- 3 Closed
    -- 4 Service application
    -- 5 Emergency application
    self.DriverValvePosition = 6
    self.RealDriverValvePosition = self.DriverValvePosition

    -- Pressure in parking brake
    self.ParkingBrakePressure = 0
    self.AirDistributorPressure = 0
    -- Pressure in reservoir
    self.ReservoirPressure = 0.0 -- atm
    -- Pressure in trains feed line
    self.TrainLinePressure = 8.0 -- atm
    -- Pressure in trains brake line
    self.BrakeLinePressure = 0.0 -- atm
    -- Pressure in brake cylinder
    self.BrakeCylinderPressure = 0.0 -- atm
    -- Pressure in the door line
    self.DoorLinePressure = 0.0 -- atm

    -- Блокировка дверей
    self.Train:LoadSystem("BD","Relay","")

    -- Регулятор давления (АК)
    self.Train:LoadSystem("AK","Relay","AK-11B")

    self.Train:LoadSystem("UAVA","Relay","Switch")

    self.Train:LoadSystem("K31","Relay","Switch", { normally_closed = true}) --KTO
    self.Train:LoadSystem("K29","Relay","Switch") --КРМШ

    self.V2 = 0 --Включение РУ
    self.V6 = false --Срыв от АРС(РВТБ)

    self.K1 = false
    self.K2 = false
    self.SD2 = 0
    self.SD3 = false
    -- Isolation valves
    self.Train:LoadSystem("FrontBrakeLineIsolation","Relay","Switch", { normally_closed = true, bass = true})
    self.Train:LoadSystem("RearBrakeLineIsolation","Relay","Switch", { normally_closed = true, bass = true})
    self.Train:LoadSystem("FrontTrainLineIsolation","Relay","Switch", { normally_closed = true, bass = true})
    self.Train:LoadSystem("RearTrainLineIsolation","Relay","Switch", { normally_closed = true, bass = true})

    -- Brake cylinder atmospheric valve open
    self.BrakeCylinderValve = 0

    -- Overpressure protection valve open
    self.TrainLineOverpressureValve = false

    -- Compressor simulation
    self.Compressor = 0 --Simulate overheat with TRK FIXME

    -- Disconnect valve status
    self.DriverValveDisconnectPrevious = 0
    self.EPKPrevious = 0

    -- Doors state
    --[[self.Train:LoadSystem("LeftDoor1","Relay",{ open_time = 0.5, close_time = 0.5 })
    self.Train:LoadSystem("LeftDoor2","Relay",{ open_time = 0.5, close_time = 0.5 })
    self.Train:LoadSystem("LeftDoor3","Relay",{ open_time = 0.5, close_time = 0.5 })
    self.Train:LoadSystem("LeftDoor4","Relay",{ open_time = 0.5, close_time = 0.5 })
    self.Train:LoadSystem("RightDoor1","Relay",{ open_time = 0.5, close_time = 0.5 })
    self.Train:LoadSystem("RightDoor2","Relay",{ open_time = 0.5, close_time = 0.5 })
    self.Train:LoadSystem("RightDoor3","Relay",{ open_time = 0.5, close_time = 0.5 })
    self.Train:LoadSystem("RightDoor4","Relay",{ open_time = 0.5, close_time = 0.5 })]]--
    self.DoorLeft = false
    self.DoorRight = false
    self.CloseDoors = false
    if not TURBOSTROI then
        self.LeftDoorState = { 0,0,0,0 }
        self.RightDoorState = { 0,0,0,0 }
        self.LeftDoorDir = { 0,0,0,0 }
        self.RightDoorDir = { 0,0,0,0 }
        self.LeftDoorSpeed = {0,0,0,0}
        self.RightDoorSpeed = {0,0,0,0}
        local start = math.Rand(0.4,0.7)
        self.DoorSpeedMain = math.Rand(start,math.Rand(start+0.1,start+0.3))
        for i=1,#self.LeftDoorSpeed do
            if math.random() > 0.7 then
                self.LeftDoorSpeed[i] = math.Rand(self.DoorSpeedMain-0.1,self.DoorSpeedMain+0.4)
                self.RightDoorSpeed[i] = math.Rand(self.DoorSpeedMain-0.1,self.DoorSpeedMain+0.4)
            else
                self.LeftDoorSpeed[i] = math.Rand(self.DoorSpeedMain-0.15,self.DoorSpeedMain+0.2)
                self.RightDoorSpeed[i] = math.Rand(self.DoorSpeedMain-0.15,self.DoorSpeedMain+0.2)
            end
        end
    end
    self.PlayOpen = 1e9
    self.PlayClosed = 1e9
    self.TrainLineOpen = false
    self.BrakeLineOpen = false

    self.EmergencyValve = false
    self.EmergencyValveEPK = false
    self.OldValuePos = self.DriverValvePosition

    self.WeightLoadRatio = 0
end

function TRAIN_SYSTEM:Inputs()
    return { "BrakeUp", "BrakeDown", "BrakeSet", "Autostop" }
end

function TRAIN_SYSTEM:Outputs()
    return { "BrakeLinePressure", "BrakeCylinderPressure", "DriverValvePosition",
             "ReservoirPressure", "TrainLinePressure", "DoorLinePressure", "WeightLoadRatio","SD2" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "BrakeSet" then
        self.DriverValvePosition = math.floor(value)
        if self.DriverValvePosition < 1 then self.DriverValvePosition = 1 end
        if self.DriverValvePosition > 6 then self.DriverValvePosition = 6 end
    elseif (name == "BrakeUp") and (value > 0.5) then
        self:TriggerInput("BrakeSet",self.DriverValvePosition+1)
    elseif (name == "BrakeDown") and (value > 0.5) then
        self:TriggerInput("BrakeSet",self.DriverValvePosition-1)
    elseif name == "Autostop" then
        self.EmergencyValve = self.Train.UAVA.Value == 0
        if self.EmergencyValve and value > 0 then RunConsoleCommand("say","Autostop braking",self.Train:GetDriverName()) end
    end
end


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

    -- Apply specific rate to equalize pressure
    local V2 = Train.K29.Value == 1 or Train.Electric.V2 > 0
    ----------------------------------------------------------------------------
    -- Accumulate derivatives
    self.TrainLinePressure_dPdT = 0.0
    self.BrakeLinePressure_dPdT = 0.0
    self.ReservoirPressure_dPdT = 0.0
    self.BrakeCylinderPressure_dPdT = 0.0
    self.AirDistributorPressure_dPdT = 0.0
    self.ParkingBrakePressure_dPdT = 0.0
    -- Reduce pressure for brake line
    self.TrainToBrakeReducedPressure = math.min(5.1,self.TrainLinePressure) -- * 0.725)
    -- Feed pressure to door line
    self.DoorLinePressure = self.TrainToBrakeReducedPressure * 0.90
    local trainLineConsumption_dPdT = 0.0
    local wagc = Train:GetWagonCount()
    local pr_speed = 1.25*wagc --2
    if self.Leak or self.BraieLineOpen then pr_speed = pr_speed*0.7 end
     -- 013: 1 Overcharge
    if (self.RealDriverValvePosition == 1) and V2 then
        self:equalizePressure(dT,"BrakeLinePressure", self.TrainLinePressure, pr_speed)
    end

    -- 013: 2 Normal pressure
    if (self.RealDriverValvePosition == 2) and V2 then
        self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(5.1,self.TrainToBrakeReducedPressure), pr_speed,nil, nil, 1.0)-- nil, 1.0)
    end

    -- 013: 3 4.3 Atm
    if (self.RealDriverValvePosition == 3) and V2 then
        self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(4.3,self.TrainToBrakeReducedPressure), pr_speed,nil, nil, 1.0)
    end

    -- 013: 4 4.0 Atm
    if (self.RealDriverValvePosition == 4) and V2 then
        self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(4.0,self.TrainToBrakeReducedPressure), pr_speed,nil, nil, 1.0)
    end

    -- 013: 5 3.7 Atm
    if (self.RealDriverValvePosition == 5) and V2 then
        self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(3.7,self.TrainToBrakeReducedPressure), pr_speed,nil, nil, 1.0)
    end

    -- 013: 6 3.0 Atm
    if (self.RealDriverValvePosition == 6) and V2 then
        self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(3.0,self.TrainToBrakeReducedPressure), pr_speed,nil, nil, 1.0)
    end


    if Train.BARS then
        local leak = 0
        if self.EmergencyValve then
            local leakst = 1.1*(Train:GetWagonCount())
            leak = self:equalizePressure(dT,"BrakeLinePressure", 0.0,pr_speed,false,false,0.4)
            if (leak >= -0.2*(Train:GetWagonCount()) or Train.UAVA.Value > 0) then
                self.EmergencyValve = false
            end
            self.Leak = true
        end
        self.Train:SetPackedRatio("EmergencyValve_dPdT", -leak)
    end
    self.Train:SetPackedRatio("Crane_dPdT", self.BrakeLinePressure_dPdT )
    trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeLinePressure_dPdT)
--[[
    local leak = 0
    if self.EmergencyValve then
        leak = self:equalizePressure(dT,"BrakeLinePressure", 0.0,2 + 1.375*(Train:GetWagonCount() - 1),false,false,0.4)
    end
    self.Train:SetPackedRatio("EmergencyValve_dPdT", -leak)
    local leak = 0
    if self.EmergencyValveEPK then
        leak = self:equalizePressure(dT,"BrakeLinePressure", 0.0,2 + 1.375*(Train:GetWagonCount() - 1),false,false,0.4)
    end
    self.Train:SetPackedRatio("EmergencyValveEPK_dPdT", -leak)
    local leak = 0
    if self.Train.EmergencyBrakeValve and self.Train.EmergencyBrakeValve.Value > 0.5 then
        leak = self:equalizePressure(dT,"BrakeLinePressure", 0.0,2 + 1.375*(Train:GetWagonCount() - 1),false,false,0.4)
    end
    self.Train:SetPackedRatio("EmergencyBrakeValve_dPdT", -leak)]]
    local count = 0
    local command = 0
    --[[
    for i=1,#Train.WagonList do
        local train = Train.WagonList[i]
        if train.BUKP then
            if train.BUKP.Loop == 0 then
                count = -99
            end
            if train.BUKP.BTB then
                count = count + 1
            end
        end
    end
    if Train.BUV.PN2 > 0 then
        command = 2
    elseif Train.BUV.PN1 > 0 then
        command = 1
    end]]
    local targetPressure = 0--math.max(0,math.min(5.2,1.5*(math.min(5.1,self.TrainToBrakeReducedPressure) - self.BrakeLinePressure)))
    --if self.BrakeLinePressure <= 3.3 then
    local PMPressure = 0
    local EPMPressure = 0
    local from = self.TrainToBrakeReducedPressure
    self:equalizePressure(dT,"AirDistributorPressure", math.Clamp(((from-self.BrakeLinePressure)/(from-3.2)),0,1)*(2.6+self.WeightLoadRatio*0.6)+0.01, 2.50, 2.50, nil, 1.3)

    self.EmergencyBrakeActive = (1-Train:ReadTrainWire(26))+(1-Train:ReadTrainWire(25)) > 0
    self.BTBReady = self.AirDistributorPressure >= (2.6+self.WeightLoadRatio*0.6)-0.1
    if self.EmergencyBrakeActive then
        PMPressure = self.AirDistributorPressure
        if self.BrakeCylinderPressure < self.AirDistributorPressure and self.AirDistributorPressure-self.BrakeCylinderPressure > 0.1 then
            self:equalizePressure(dT,"AirDistributorPressure",0, (self.AirDistributorPressure-self.BrakeCylinderPressure)*1, (self.AirDistributorPressure-self.BrakeCylinderPressure)*1, nil, 2)
        end
    end
    if Train:ReadTrainWire(28) > 0 then
        if Train:ReadTrainWire(27)*Train:ReadTrainWire(29) > 0 then
            EPMPressure = 1.7+self.WeightLoadRatio*0.7 --2 уставка
        elseif Train:ReadTrainWire(27)*Train:ReadTrainWire(30) > 0 then
            EPMPressure = 1 --1 уставка
        end
    else
        if Train.BUV.PN2 then
            EPMPressure = 1.7+self.WeightLoadRatio*0.7 --2 уставка
        elseif Train.BUV.PN1 then
            EPMPressure = 1 --1 уставка
        end
    end
    if EPMPressure > PMPressure then --Работа П1
        targetPressure = EPMPressure
    else
        targetPressure = PMPressure
    end
    self.DisableScheme = not Train.BUV:Get("Slope") and self.BrakeCylinderPressure > 0.6 or self.BrakeCylinderPressure > 1.8
    --end
    ----------------------------------------------------------------------------
    -- Fill brake cylinders
    if Train.K31.Value == 1 then
        if math.abs(self.BrakeCylinderPressure - targetPressure) > 0.150 then
            self.BrakeCylinderValve = 1
        end
        if math.abs(self.BrakeCylinderPressure - targetPressure) < 0.025 then
            self.BrakeCylinderValve = 0
        end
        local pneumaticValveConsumption_dPdT = 0
        trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,pneumaticValveConsumption_dPdT)
        if self.BrakeCylinderValve == 1 then
            self:equalizePressure(dT,"BrakeCylinderPressure", math.min(3.3,targetPressure), 2.50, 2.50, nil, self.BrakeCylinderPressure > targetPressure and 0.3+math.Clamp((self.BrakeCylinderPressure-0.4)/3.3,0,0.6) or 0.9)
        end
    else
        self:equalizePressure(dT,"BrakeCylinderPressure", 0.0, 2.00)
    end

    if (Train.BUV:Get("RVPB") or Train:ReadTrainWire(11) > 0) and Train.SFV22.Value > 0 and Train.Electric.Battery80V > 62  then
        self:equalizePressure(dT,"ParkingBrakePressure", self.TrainLinePressure, 0.4,1,nil,0.5)
    else
        self:equalizePressure(dT,"ParkingBrakePressure", 0, 0.4,1,nil,0.5)
    end
    Train:SetPackedRatio("ParkingBrakePressure_dPdT",self.ParkingBrakePressure_dPdT)
    trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeCylinderPressure_dPdT + self.ParkingBrakePressure_dPdT)
    self.Train:SetPackedRatio("BrakeCylinderPressure_dPdT", self.BrakeCylinderPressure_dPdT)

    -- Simulate cross-feed between different wagons
    self:UpdatePressures(Train,dT)

    ----------------------------------------------------------------------------
    -- Simulate compressor operation and train line depletion
    self.Compressor = Train.BUV.BBE and Train.Electric.BVKA_KM1 > 0--Train.KK.Value * ((not Train.Electric or Train.Electric.Power750V > 550) and 1 or 0)
    self.CompressorOver = self.CompressorOver or 0
    if self.Compressor then
        self.CompressorOver = self.CompressorOver + math.random(0.0215,0.0235)*dT
        if self.CompressorOver >= 1 then --Train.SF54.Value > 0.5 and self.CompressorOver >= 1 then
            self.CompressorOver = 0
            Train:PlayOnce("compressor_pn","cabin",1,1)
        end
    end
    local Ratio = 29/400
    self.TrainLinePressure = self.TrainLinePressure - 0.07*trainLineConsumption_dPdT*dT -- 0.190 --0.170
    if self.Compressor then self:equalizePressure(dT,"TrainLinePressure", 10.0, 0.039) end
    --self:equalizePressure(dT,"TrainLinePressure", 8.0, 0.4) --TEMP
    self:equalizePressure(dT,"TrainLinePressure", 0,0.001)
    -- Overpressure
    if self.TrainLinePressure > 9 then self.TrainLineOverpressureValve = true end
    if self.TrainLineOverpressureValve then
        --self:equalizePressure(dT,"TrainLinePressure", 0.0, 0.2)
        self:equalizePressure(dT,"TrainLinePressure", 0.0, 0.05)
        self.TrainLineOpen = true
        if self.TrainLinePressure < 6 then self.TrainLineOverpressureValve = false end
    end
    if self.BrakeLinePressure <= 2.6 and self.SD2~=1 then self.SD2 = 1  end
    if self.BrakeLinePressure >= 2.8 and self.SD2~=0 then self.SD2 = 0 end
    Train.AK:TriggerInput( "Open", self.TrainLinePressure > 8.2)
    Train.AK:TriggerInput( "Close",self.TrainLinePressure < 6.3)
    ----------------------------------------------------------------------------
    -- FIXME
    Train:SetNW2Bool("FbI",Train.FrontBrakeLineIsolation.Value ~= 0)
    Train:SetNW2Bool("RbI",Train.RearBrakeLineIsolation.Value ~= 0)
    Train:SetNW2Bool("FtI",Train.FrontTrainLineIsolation.Value ~= 0)
    Train:SetNW2Bool("RtI",Train.RearTrainLineIsolation.Value ~= 0)
    Train:SetNW2Bool("AD",Train.K31.Value == 0)

    self.Timer = self.Timer or CurTime()
    if ((CurTime() - self.Timer > 0.10) and (self.DriverValvePosition > self.RealDriverValvePosition)) then
        self.Timer = CurTime()
        self.Train:PlayOnce("br_013","cabin")
        self.RealDriverValvePosition = self.RealDriverValvePosition + 1
    end
    if ((CurTime() - self.Timer > 0.10) and (self.DriverValvePosition < self.RealDriverValvePosition)) then
        self.Timer = CurTime()
        self.Train:PlayOnce("br_013","cabin")
        self.RealDriverValvePosition = self.RealDriverValvePosition - 1
    end


    if self.V2Previous ~= V2 then
        self.V2Previous = V2
        if not V2 then
            self.V2OffTimer = CurTime()
            self.Train:PlayOnce("pneumo_disconnect_close","cabin")
        else
            self.V2OffTimer = nil
            self.Train:PlayOnce("pneumo_disconnect_open","cabin")
        end
    end
    if self.V2OffTimer then
        if CurTime()-self.V2OffTimer < 0.45 then
            local pr_speed = 2.2*(Train:GetWagonCount()) --2
            self:equalizePressure(dT,"BrakeLinePressure", 0,pr_speed)
        else
            self.V2OffTimer = nil
        end
    end


    local commandLeft =  (Train:ReadTrainWire(40) > 0 or Train.BUV.OpenLeft) and (Train:ReadTrainWire(38) > 0 or Train:ReadTrainWire(39) > 0) and Train.SFV13.Value > 0
    local commandRight =  (Train:ReadTrainWire(40) > 0 or Train.BUV.OpenRight) and (Train:ReadTrainWire(37) > 0 or Train:ReadTrainWire(39) > 0) and Train.SFV14.Value > 0
    local commandClose =  Train.BUV.CloseDoors and Train.SFV12.Value > 0
    if commandClose or commandLeft and commandRight then
        self.DoorLeft = false
        self.DoorRight = false
    elseif commandLeft then self.DoorLeft = true
    elseif commandRight then self.DoorRight = true end
    Train.LeftDoorsOpen = false
    Train.RightDoorsOpen = false
    for i=1,4 do
        self.LeftDoorDir[i] = math.Clamp(self.LeftDoorDir[i]+dT/(self.DoorLeft and 2*self.LeftDoorSpeed[i] or -self.LeftDoorSpeed[i]),-1.5,1)
        self.RightDoorDir[i] = math.Clamp(self.RightDoorDir[i]+dT/(self.DoorRight and 2*self.RightDoorSpeed[i] or -self.RightDoorSpeed[i]),-1.5,1)
        self.LeftDoorState[i]  = math.Clamp(self.LeftDoorState[i] + (self.LeftDoorDir[i]/self.LeftDoorSpeed[i]*dT),0,1)
        if self.LeftDoorState[i] == 0 or self.LeftDoorState[i] == 1 then self.LeftDoorDir[i] = 0 end
        self.RightDoorState[i]  = math.Clamp(self.RightDoorState[i] + (self.RightDoorDir[i]/self.RightDoorSpeed[i]*dT),0,1)
        if self.RightDoorState[i] == 0 or self.RightDoorState[i] == 1 then self.RightDoorDir[i] = 0 end
        if not Train.BUV.LeftDoorsOpen and self.LeftDoorState[i] > 0 then
            Train.LeftDoorsOpen = true
        end
        if not Train.BUV.LeftDoorsOpen and self.RightDoorState[i] > 0 then
            Train.RightDoorsOpen = true
        end
        Train.BUV.DoorsOpened = Train.LeftDoorsOpen or Train.RightDoorsOpen
        Train:SetPackedRatio("DoorL"..i,self.LeftDoorState[i])
        Train:SetPackedRatio("DoorR"..i,self.RightDoorState[i])
        --[[
        self.DoorSpeedMain = math.Rand(1.1,1.3)
        for i=1,#self.LeftDoorSpeed do
            self.LeftDoorSpeed[i] = math.Rand(self.DoorSpeedMain,self.DoorSpeedMain+0.2)
        end--]]
    end
    Train:SetPackedBool("DoorL",self.DoorLeft)
    Train:SetPackedBool("DoorR",self.DoorRight)
        --[[
    self.DoorLeft = false
    self.DoorRight = false
    self.CloseDoors = false
    self.LeftDoorState = { 0,0,0,0 }
    self.RightDoorState = { 0,0,0,0 }
    self.LeftDoorSpeed = {0,0,0,0}
    self.RightDoorSpeed = {0,0,0,0}
    for i=1,#self.LeftDoorSpeed do
        self.LeftDoorSpeed = math.random(2.8,3.2)
        self.RightDoorSpeed = math.random(2.8,3.2)
    end]]
end

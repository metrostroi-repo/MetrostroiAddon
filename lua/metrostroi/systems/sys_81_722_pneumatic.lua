--------------------------------------------------------------------------------
-- 81-722 pneumatic
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_722_Pneumatic")
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
    self.PMPressure = 0
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


    self.Train:LoadSystem("UAVA","Relay","Switch")
    self.Train:LoadSystem("EmergencyBrakeValve","Relay","Switch")

    self.Train:LoadSystem("K31","Relay","Switch", { normally_closed = true}) --KTO
    self.Train:LoadSystem("K9","Relay","Switch", { normally_closed = true}) --РВТБ
    self.Train:LoadSystem("K29","Relay","Switch") --КРМШ
    self.Train:LoadSystem("S1","Relay","") --Двери

    self.V4 = false --Включение РУ
    
    self.K1 = false
    self.K2 = false
    self.SD2 = 0
    self.SD3 = 0
    self.SD4 = 0
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
        self.LeftDoorStuck = {false, false, false, false}
        self.RightDoorStuck = {false, false, false, false}
        self.DoorSpeedMain = math.Rand(1.9,2.1)
        for i=1,#self.LeftDoorSpeed do
            self.LeftDoorSpeed[i] = math.Rand(self.DoorSpeedMain-0.3,self.DoorSpeedMain+0.3)
            self.RightDoorSpeed[i] = math.Rand(self.DoorSpeedMain-0.3,self.DoorSpeedMain+0.3)
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

    self.EPKLeaking = false
end

function TRAIN_SYSTEM:Inputs()
    return { "BrakeUp", "BrakeDown", "BrakeSet", "Autostop" }
end

function TRAIN_SYSTEM:Outputs()
    return { "BrakeLinePressure", "BrakeCylinderPressure", "DriverValvePosition",
             "ReservoirPressure", "TrainLinePressure", "DoorLinePressure", "WeightLoadRatio", "SD2","SD3","SD4" }
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

    local V4 = (Train.K29.Value == 1 or Train.Panel.V4>0)
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
    if (self.RealDriverValvePosition == 1) and V4 then
        self:equalizePressure(dT,"BrakeLinePressure", self.TrainLinePressure, pr_speed)
    end

    -- 013: 2 Normal pressure
    if (self.RealDriverValvePosition == 2) and V4 then
        self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(5.1,self.TrainToBrakeReducedPressure), pr_speed,nil, nil, 1.0)-- nil, 1.0)
    end

    -- 013: 3 4.3 Atm
    if (self.RealDriverValvePosition == 3) and V4 then
        self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(4.3,self.TrainToBrakeReducedPressure), pr_speed,nil, nil, 1.0)
    end

    -- 013: 4 4.0 Atm
    if (self.RealDriverValvePosition == 4) and V4 then
        self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(4.0,self.TrainToBrakeReducedPressure), pr_speed,nil, nil, 1.0)
    end

    -- 013: 5 3.7 Atm
    if (self.RealDriverValvePosition == 5) and V4 then
        self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(3.7,self.TrainToBrakeReducedPressure), pr_speed,nil, nil, 1.0)
    end

    -- 013: 6 3.0 Atm
    if (self.RealDriverValvePosition == 6) and V4 then
        self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(3.0,self.TrainToBrakeReducedPressure), pr_speed,nil, nil, 1.0)
    end
    local pr_speed = 1.25*wagc
    self.Leak = false
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
        local leak = 0
        if Train.K9.Value == 1 and V4 and Train.Electric.V6Power==0 then
            leak = self:equalizePressure(dT,"BrakeLinePressure", 0.0,pr_speed,pr_speed)
            self.Leak = true
        end
        self.EPKLeaking = self.Leak
        self.Train:SetPackedRatio("EmergencyValveEPK_dPdT", -leak*2)
    end
    local leak = 0
    if self.Train.EmergencyBrakeValve and self.Train.EmergencyBrakeValve.Value > 0.5 then
        leak = self:equalizePressure(dT,"BrakeLinePressure", 0.0,pr_speed,false,false,0.4)
        self.Leak = true
    end
    self.Train:SetPackedRatio("EmergencyBrakeValve_dPdT", -leak)
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
    local leak = 0]]--[[
    local count = 0
    local command = 0
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
    end--]]

    local Power = Train.Electric.BUFT > 0
    local targetPressure = 0--math.max(0,math.min(5.2,1.5*(math.min(5.1,self.TrainToBrakeReducedPressure) - self.BrakeLinePressure)))
    --if self.BrakeLinePressure <= 3.3 then
    local PMPressure = 0
    local EPMPressure = 0
    local from = self.TrainToBrakeReducedPressure
    local targetPM = math.Clamp(((from-self.BrakeLinePressure)/(from-3.2)),0,1)*(2.7+self.WeightLoadRatio*0.7)
    if self.PMPressure < targetPM then
        self.PMPressure = math.min(targetPM,self.PMPressure+(0.5+math.max(0,(targetPM-self.PMPressure)-0.2)*0.6)*dT)
    elseif self.PMPressure > targetPM then
        self.PMPressure = math.max(targetPM,self.PMPressure-2*dT)
    end
    self:equalizePressure(dT,"AirDistributorPressure", targetPM, 2.50, 2.50, nil, 1.3)
    --[[--]]
    self.EmergencyBrakeActive = (1-Train:ReadTrainWire(26))+(1-Train:ReadTrainWire(25)) > 0
    self.BTBReady = self.AirDistributorPressure >= (2.4+self.WeightLoadRatio*0.9)-0.1
    if self.EmergencyBrakeActive then
        PMPressure = self.AirDistributorPressure
        if self.BrakeCylinderPressure < self.AirDistributorPressure and self.AirDistributorPressure-self.BrakeCylinderPressure > 0.1 then
            self:equalizePressure(dT,"AirDistributorPressure",0, math.min(self.TrainLinePressure,self.AirDistributorPressure-self.BrakeCylinderPressure)*1, (self.AirDistributorPressure-self.BrakeCylinderPressure)*1, nil, 2)
        end
    end
    if Power then
        if Train:ReadTrainWire(27) > 0 then
            if Train:ReadTrainWire(29) > 0 then
                EPMPressure = 1.7+self.WeightLoadRatio*0.7 --2 уставка
            elseif Train:ReadTrainWire(30) > 0 then
                EPMPressure = 0.75+self.WeightLoadRatio*0.5 --1 уставка
            end
        else
            if Train.BUKV.PN2 then
                EPMPressure = 1.7+self.WeightLoadRatio*0.7 --2 уставка
            elseif Train.BUKV.PN1 then
                EPMPressure = 0.75+self.WeightLoadRatio*0.5 --1 уставка
            end
        end
    end
    if EPMPressure > PMPressure then --Работа П1
        targetPressure = EPMPressure
    else
        targetPressure = PMPressure
    end
    self.DisableScheme = self.BrakeCylinderPressure > 0.6
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
            self:equalizePressure(dT,"BrakeCylinderPressure", math.min(3.3,self.TrainLinePressure,targetPressure), 2.50, 2.50, nil, self.BrakeCylinderPressure > targetPressure and 0.3+math.Clamp((self.BrakeCylinderPressure-0.4)/3.3,0,0.6) or 0.9)
            --if self.DriversValve == 1 then
                --self:equalizePressure(dT,"BrakeCylinderPressure", targetPressure, 2.00, 3.50, nil, 1.0) --0.75, 1.25)
            --else

                --self:equalizePressure(dT,"BrakeCylinderPressure", math.min(2.7,targetPressure+PN1+PN2), self.TrainToBrakeReducedPressure*0.2, 5.50, nil, 0.6+math.Clamp((self.BrakeCylinderPressure-0.75)/2.1,0,1.3)) --0.75, 1.25)
                --print(self.TEMP-self.BrakeCylinderPressure)
                   --equalizePressure(dT,                                   pressure,       target,rate,fill_rate,no_limit,smooth)
            --end
        end
    else
        self:equalizePressure(dT,"BrakeCylinderPressure", 0.0, 2.00)
    end
    local w11, w31 = Train:ReadTrainWire(11), Train:ReadTrainWire(31)
    if w11*(1-w31) > 0 then
        self:equalizePressure(dT,"ParkingBrakePressure", 0, 0.4,1,nil,0.5)
    elseif w31*(1-w11) > 0 then
        self:equalizePressure(dT,"ParkingBrakePressure", self.TrainLinePressure, 0.4,1,nil,0.5)
    end
    Train:SetPackedRatio("ParkingBrakePressure_dPdT",self.ParkingBrakePressure_dPdT+0.02)
    trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeCylinderPressure_dPdT + self.ParkingBrakePressure_dPdT)
    self.Train:SetPackedRatio("BrakeCylinderPressure_dPdT", self.BrakeCylinderPressure_dPdT)

    -- Simulate cross-feed between different wagons
    self:UpdatePressures(Train,dT)
    ----------------------------------------------------------------------------
    -- Simulate compressor operation and train line depletion
    self.Compressor = Train.Electric.MK and Train.Electric.MK>0--Train.KK.Value * ((not Train.Electric or Train.Electric.Power750V > 550) and 1 or 0)
    self.CompressorOver = self.CompressorOver or 0
    if self.Compressor then
        self.CompressorOver = self.CompressorOver + math.random(0.0215,0.0235)*dT
        if Train.SF54.Value > 0.5 and self.CompressorOver >= 1 then
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
        self:equalizePressure(dT,"TrainLinePressure", 0.0, 0.2)
        self.TrainLineOpen = true
        if self.TrainLinePressure < 6 then self.TrainLineOverpressureValve = false end
    end

    if self.BrakeLinePressure <= 2.6 and self.SD2~=1 then self.SD2 = 1  end
    if self.BrakeLinePressure >= 2.8 and self.SD2~=0 then self.SD2 = 0 end
    if self.BrakeLinePressure <= 2.0 and self.SD3~=1 then self.SD3 = 1  end
    if self.BrakeLinePressure >= 2.2 and self.SD3~=0 then self.SD3 = 0 end    
    self.SD4 = (IsValid(Train.FrontBogey) and Train.FrontBogey.BrakeCylinderPressure+(not Train.FrontBogey.DisableParking and Train.FrontBogey.ParkingBrakePressure or 0) or self.BrakeCylinderPressure)>0.1 and 1 or 0
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
    if self.V4Previous ~= V4 then
        self.V4Previous = V4
        if not V4 then
            self.V4OffTimer = CurTime()
            self.Train:PlayOnce("pneumo_disconnect_close","cabin")
        else
            self.V4OffTimer = nil
            self.Train:PlayOnce("pneumo_disconnect_open","cabin")
        end
    end
    if self.V4OffTimer then
        if CurTime()-self.V4OffTimer < 0.45 then
            local pr_speed = 2.2*(Train:GetWagonCount()) --2
            self:equalizePressure(dT,"BrakeLinePressure", 0,pr_speed)
        else
            self.V4OffTimer = nil
        end
    end

--[[
    if Train.BUV.OpenLeft then
        self.DoorLeft = true
    end
    if Train.BUV.OpenRight then
        self.DoorRight = true
    end
    if Train.BUV.CloseDoors then
        self.DoorLeft = false
        self.DoorRight = false
    end--]]
    local commandLeft,commandRight,commandClose
    if Train:ReadTrainWire(34) > 0 then
        commandLeft = Train:ReadTrainWire(38) > 0
        commandRight = Train:ReadTrainWire(37) > 0
        commandClose = Train:ReadTrainWire(39) < 1
    else
        commandLeft = Train.BUKV.OpenLeft
        commandRight = Train.BUKV.OpenRight or Train.BUKV.OpenRightBack
        commandClose = Train.BUKV.CloseDoors
    end
    commandLeft  = commandLeft  and Train.SF41.Value > 0
    commandRight = commandRight and Train.SF42.Value > 0
    commandClose = commandClose and Train.SF43.Value > 0
    if commandClose or commandLeft and commandRight then
        self.DoorLeft = false
        self.DoorRight = false
    elseif commandLeft then self.DoorLeft = true
    elseif commandRight then self.DoorRight = true end
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
    for i=1,4 do
        self.LeftDoorDir[i] = math.Clamp(self.LeftDoorDir[i]+dT*(self.DoorLeft and self.LeftDoorSpeed[i] or -self.LeftDoorSpeed[i]),-1,1)
        self.RightDoorDir[i] = math.Clamp(self.RightDoorDir[i]+dT*(self.DoorRight and self.RightDoorSpeed[i] or -self.RightDoorSpeed[i]),-1,1)
        self.LeftDoorState[i]  = math.Clamp(self.LeftDoorState[i] + (1/self.LeftDoorSpeed[i]*dT*self.LeftDoorDir[i]),self.LeftDoorStuck[i] and 0.3 or 0,1)
        if self.LeftDoorState[i] == 0 or self.LeftDoorState[i] == 1 then self.LeftDoorDir[i] = 0 end
        self.RightDoorState[i]  = math.Clamp(self.RightDoorState[i] + (1/self.RightDoorSpeed[i]*dT*self.RightDoorDir[i]),self.RightDoorStuck[i] and 0.3 or 0,1)
        if self.RightDoorState[i] == 0 or self.RightDoorState[i] == 1 then self.RightDoorDir[i] = 0 end
        ---[[
        if self.LeftDoorState[i] > 0 then
            Train.LeftDoorsOpen = true
        end
        if self.RightDoorState[i] > 0 then
            Train.RightDoorsOpen = true
        end
        --Train.BUV.DoorsOpened = Train.LeftDoorsOpen or Train.RightDoorsOpen--]]
        Train:SetPackedRatio("DoorL"..i,self.LeftDoorState[i])
        Train:SetPackedRatio("DoorR"..i,self.RightDoorState[i])
        Train.S1:TriggerInput("Set",not Train.RightDoorsOpen and not Train.LeftDoorsOpen)
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

--------------------------------------------------------------------------------
-- 81-703 pneumatic system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_703_Pneumatic")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize(parameters)
    -- Position of the train drivers valve
    --  Type 1 (334)
    -- 1 Accelerated charge
    -- 2 Normal charge (brake release)
    -- 3 Closed
    -- 4 Service application
    -- 5 Emergency application
    self.DriverValvePosition = 2
    self.RealDriverValvePosition = self.DriverValvePosition


    -- Pressure in reservoir
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

    --DKPT
    self.Train:LoadSystem("DKPT","Relay","R-52B")
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

    -- Краны двойной тяги
    self.Train:LoadSystem("DriverValveTLDisconnect","Relay","Switch", {bass = true})
    self.Train:LoadSystem("DriverValveBLDisconnect","Relay","Switch", {bass = true})

    self.Train:LoadSystem("EmergencyBrakeValve","Relay","Switch")
    -- Воздухораспределитель
    self.Train:LoadSystem("AirDistributorDisconnect","Relay","Switch")
    --УАВА
    self.Train:LoadSystem("UAVA","Relay","Switch",{ bass = true})
    self.Train:LoadSystem("UAVAC","Relay","",{normally_closed=true,bass=true})
    --ЭПК
    self.Train:LoadSystem("EPK","Relay","Switch",{ bass = true})
    self.Train:LoadSystem("SOT","Relay")
    -- Isolation valves
    self.Train:LoadSystem("FrontBrakeLineIsolation","Relay","Switch", { normally_closed = true, bass = true})
    self.Train:LoadSystem("RearBrakeLineIsolation","Relay","Switch", { normally_closed = true, bass = true})
    self.Train:LoadSystem("FrontTrainLineIsolation","Relay","Switch", { normally_closed = true, bass = true})
    self.Train:LoadSystem("RearTrainLineIsolation","Relay","Switch", { normally_closed = true, bass = true})

    -- Brake cylinder atmospheric valve open
    self.BrakeCylinderValve = 0

    -- Overpressure protection valve open
    self.TrainLineOverpressureValve = 0

    -- Compressor simulation
    self.Compressor = 0 --Simulate overheat with TRK FIXME

    -- Disconnect valve status
    self.DriverValveDisconnectPrevious = 0

    -- Doors state
    --[[self.Train:LoadSystem("LeftDoor1","Relay",{ open_time = 0.5, close_time = 0.5 })
    self.Train:LoadSystem("LeftDoor2","Relay",{ open_time = 0.5, close_time = 0.5 })
    self.Train:LoadSystem("LeftDoor3","Relay",{ open_time = 0.5, close_time = 0.5 })
    self.Train:LoadSystem("LeftDoor4","Relay",{ open_time = 0.5, close_time = 0.5 })
    self.Train:LoadSystem("RightDoor1","Relay",{ open_time = 0.5, close_time = 0.5 })
    self.Train:LoadSystem("RightDoor2","Relay",{ open_time = 0.5, close_time = 0.5 })
    self.Train:LoadSystem("RightDoor3","Relay",{ open_time = 0.5, close_time = 0.5 })
    self.Train:LoadSystem("RightDoor4","Relay",{ open_time = 0.5, close_time = 0.5 })]]--
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

    self.WeightLoadRatio = 0--math.max(0,math.min(1,(self.Train:GetNW2Float("PassengerCount",0)/200)))

    self.HaveUAVA = not self.Train.SubwayTrain or not self.Train.SubwayTrain.ARS or not self.Train.SubwayTrain.ARS.NoUAVA
    self.HaveEPK = not self.Train.SubwayTrain or not self.Train.SubwayTrain.ARS or not self.Train.SubwayTrain.ARS.NoEPK
end

function TRAIN_SYSTEM:Inputs()
    return { "BrakeUp", "BrakeDown", "BrakeSet", "ValveType", "Autostop" , "PowerWithFuse"}
end

function TRAIN_SYSTEM:Outputs()
    return { "BrakeLinePressure", "BrakeCylinderPressure", "DriverValvePosition",
             "ReservoirPressure", "TrainLinePressure", "DoorLinePressure", "WeightLoadRatio" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "BrakeSet" then
        self.DriverValvePosition = math.floor(value)
        if self.DriverValvePosition < 1 then self.DriverValvePosition = 1 end
        if self.DriverValvePosition > 5 then self.DriverValvePosition = 5 end
    elseif (name == "BrakeUp") and (value > 0.5) then
        self:TriggerInput("BrakeSet",self.DriverValvePosition+1)
    elseif (name == "BrakeDown") and (value > 0.5) then
        self:TriggerInput("BrakeSet",self.DriverValvePosition-1)
    elseif name == "ValveType" then
        self.ValveType = math.floor(value)
    elseif name == "Autostop" then
        if self.HaveUAVA and self.Train.UAVA.Value == 0 then
            self.EmergencyValve = true
            self.Train.UAVAC:TriggerInput("Set",0)
            if value > 0 then RunConsoleCommand("say","Autostop braking",self.Train:GetDriverName()) end
        end
    elseif name == "PowerWithFuse" then
	    self.Fuse = 1
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

    -- Apply specific rate to equalize pressure


    ----------------------------------------------------------------------------
    -- Accumulate derivatives
    self.TrainLinePressure_dPdT = 0.0
    self.BrakeLinePressure_dPdT = 0.0
    self.EPKPressure_dPdT = 0.0
    self.ReservoirPressure_dPdT = 0.0
    self.BrakeCylinderPressure_dPdT = 0.0

    -- Reduce pressure for brake line
    self.TrainToBrakeReducedPressure = math.min(5.1,self.TrainLinePressure) -- * 0.725)
    -- Feed pressure to door line
    self.DoorLinePressure = self.TrainToBrakeReducedPressure * 0.90
    local trainLineConsumption_dPdT = 0.0
    local wagc = Train:GetWagonCount()
    local BLDisconnect = Train.DriverValveBLDisconnect.Value > 0
    local TLDisconnect = Train.DriverValveTLDisconnect.Value > 0
    local pr_speed = 1*wagc--*((self.BrakeLinePressure-self.ReservoirPressure)/0.6) --2
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
    if BLDisconnect then
        --print(self.BrakeLinePressure_dPdT,self.ReservoirPressure_dPdT,self.TrainLinePressure)
    end

    local leak
    local pr_speed = 1.25*wagc
    if self.HaveEPK and Train.EPKC then
        local leak = 0
        local epkDiff = math.abs(self.EPKPressure-self.BrakeLinePressure)
        if BLDisconnect and Train.EPK.Value>0 then
            if Train.EPKC.Value>0 then
                self:equalizePressure(dT,"EPKPressure", self.BrakeLinePressure,math.min(1,epkDiff)*6,false,false,4*epkDiff*2)
            end
            if self.EPKPressure<self.BrakeLinePressure and math.abs(self.EPKPressure-self.BrakeLinePressure)>0.3 then
                leak = self:equalizePressure(dT,"BrakeLinePressure", self.EPKPressure,pr_speed*epkDiff/2,pr_speed*epkDiff/2)
            end
            self.Leak = self.Leak or leak<-0.1
        end
        if Train.EPK.Value == 0 or Train.EPKC.Value == 0 then
            leak = leak+self:equalizePressure(dT,"EPKPressure", 0,8,false,false,5)
        end
        Train:SetPackedRatio("EmergencyValveEPK_dPdT", -leak/wagc)
    end
    Train:SetPackedRatio("Crane_dPdT", self.ReservoirPressure_dPdT )

    self.Leak = false
    local leak = 0
    if self.EmergencyValveDisable and (self.BrakeLinePressure-self.OldBrakeLinePressure)>0.01 then
        self.EmergencyValveDisable=false
        self.EmergencyValve=false
    end
    if Train.UKS and Train.UKS.UKSEmerTriggered > 0 and Train.UKSDisconnect.Value > 0 then
        self.EmergencyValve=true
    end

    self.OldBrakeLinePressure = self.BrakeLinePressure
    if self.EmergencyValve then
        local leakst = 1.1*(Train:GetWagonCount())*math.Clamp(self.BrakeLinePressure/4,0,1)
        leak = self:equalizePressure(dT,"BrakeLinePressure", 0.0,leakst*2,false,false,0.4)
        if (leak >= -0.2*(Train:GetWagonCount()) or Train.UAVA.Value > 0) then
            self.EmergencyValveDisable = true
        end
        self.Leak = true
    end
    local UAVABlocked = (self.BrakeLinePressure>3.5 and Train.UAVA.Value==0)
    if (Train.UAVA.Blocked>0) ~= UAVABlocked then
        Train.UAVA:TriggerInput("Block",UAVABlocked and 1 or 0)
    end

    local UAVACBlocked = self.EmergencyValve and not self.EmergencyValveDisable
    if (Train.UAVAC.Blocked>0) ~= UAVACBlocked then
        Train.UAVAC:TriggerInput("Block",UAVACBlocked and 1 or 0)
    end

    Train:SetPackedRatio("EmergencyValve_dPdT", -leak/wagc)

    local leak = 0
    if Train.EmergencyBrakeValve and Train.EmergencyBrakeValve.Value > 0.5 then
        --local leakst = (1.6*(Train:GetWagonCount())*(self.BrakeLinePressure-math.min(2.5,self.TrainToBrakeReducedPressure))*0.9)
        leak = self:equalizePressure(dT,"BrakeLinePressure", 0.0,(1.1*wagc)*2,false,false,0.4)
        self.Leak = true
    end
    Train:SetPackedRatio("EmergencyBrakeValve_dPdT", -leak/wagc)
    ----------------------------------------------------------------------------
    -- Fill brake cylinders
    if Train.AirDistributorDisconnect.Value == 0 then
        -- Valve #1
        self.BrakeCylinderRegulationError = self.BrakeCylinderRegulationError or (math.random()*0.20 - 0.10)
        local error = self.BrakeCylinderRegulationError
        if (Train.PneumaticNo1.Value == 1.0) and (Train.PneumaticNo2.Value == 0.0) then
            if self.PN1 == 0 then
                --1,2
                self.PN1 = math.min(self.TrainLinePressure,(1.1 + error + self.WeightLoadRatio*0.6))
            end
        elseif self.PN1 ~= 0 then
            self.PN1 = 0
        end
        -- Valve #2
        if Train.PneumaticNo2.Value == 1.0 then
            if self.PN2 == 0 then
                self.PN2 = math.min(self.TrainLinePressure,(2.5 + error + self.WeightLoadRatio*1.2))
                if self.BePN2 == false and self.BrakeCylinderPressure > 1.6 then
                    Train:PlayOnce("PN2end","stop")
                end
                self.BePN2 = true
            end
        elseif self.PN2 ~= 0 then
            self.PN2 = 0
        end
        local targetPres = math.max(0,math.min(5.2,1.5*(math.min(5.1,self.TrainToBrakeReducedPressure) - self.BrakeLinePressure)))
        if self.BCPressure < targetPres then
            self.BCPressure = math.min(targetPres,self.BCPressure+(0.5+math.max(0,(targetPres-self.BCPressure)-0.2)*0.6)*dT)
        elseif self.BCPressure > targetPres then
            self.BCPressure = math.max(targetPres,self.BCPressure-2*dT)
        end
        local targetPressure = self.PN1+self.PN2+self.BCPressure
        if math.abs(self.BrakeCylinderPressure - targetPressure) > 0.150 then
            self.BrakeCylinderValve = 1
        end
        if math.abs(self.BrakeCylinderPressure - targetPressure) < 0.025 then
            self.BrakeCylinderValve = 0
        end
        if self.BrakeCylinderValve == 1 then
            self:equalizePressure(dT,"BrakeCylinderPressure", math.min(2.7 + self.WeightLoadRatio*1.3,targetPressure), 1+math.Clamp((self.BrakeCylinderPressure-0.5)/2.8,0,0.7), 3.50, nil, 0.8+math.Clamp((self.BrakeCylinderPressure-0.75)/0.6,0,1)) --0.75, 1.25)
        end
        trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeCylinderPressure_dPdT*0.5)--]]
    else
        self:equalizePressure(dT,"BrakeCylinderPressure", 0.0, 2.00)
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

    -- Simulate cross-feed between different wagons
    self:UpdatePressures(Train,dT)

    ----------------------------------------------------------------------------
    -- Simulate compressor operation and train line depletion
	if self.Fuse then
        self.Compressor = Train.PR2.Value * Train.KK.Value * (Train.Electric.Aux750V > 550 and 1 or 0)
    else
	    self.Compressor = Train.KK.Value * (Train.Electric.Aux750V > 550 and 1 or 0)
	end
    self.TrainLinePressure = self.TrainLinePressure - 0.07*trainLineConsumption_dPdT*dT -- 0.190 --0.170
    if self.Compressor == 1 then self:equalizePressure(dT,"TrainLinePressure", 10.0, 0.02) end
    self:equalizePressure(dT,"TrainLinePressure", 0,0.001)
    -- Overpressure
    if self.TrainLinePressure > 9.2 then self.TrainLineOverpressureValve = 1 end
    if self.TrainLineOverpressureValve == 1 then
        self:equalizePressure(dT,"TrainLinePressure", 0.0, 0.2)
        self.TrainLineOpen = true
        if self.TrainLinePressure < 5.2 then self.TrainLineOverpressureValve = 0 end
    end

    ----------------------------------------------------------------------------
    -- Pressure triggered relays
    Train.AVT:TriggerInput("Open", self.BrakeCylinderPressure > 1.9) -- 1.8 - 2.0
    Train.AVT:TriggerInput("Close",self.BrakeCylinderPressure < 1.2) -- 0.9 - 1.5
    Train.AK:TriggerInput( "Open", self.TrainLinePressure > 8.2)
    Train.AK:TriggerInput( "Close",self.TrainLinePressure < 6.3)
    Train.AVU:TriggerInput("Open", self.BrakeLinePressure < 2.7) -- 2.7 - 2.9
    Train.AVU:TriggerInput("Close",self.BrakeLinePressure > 4.3) -- 3.5 - 3.7
    Train.SOT:TriggerInput("Open", self.EPKPressure < 1.3) -- 2.7 - 2.9
    Train.SOT:TriggerInput("Close", self.EPKPressure > 1.5) -- 2.7 - 2.9
    Train.BPT:TriggerInput("Set",  self.BrakeCylinderPressure > 0.4)
    Train.DKPT:TriggerInput("Set", self.BrakeCylinderPressure > 0.2) -- 1.8 - 2.0

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

    ----------------------------------------------------------------------------
    -- FIXME
    Train:SetNW2Bool("FbI",Train.FrontBrakeLineIsolation.Value ~= 0)
    Train:SetNW2Bool("RbI",Train.RearBrakeLineIsolation.Value ~= 0)
    Train:SetNW2Bool("FtI",Train.FrontTrainLineIsolation.Value ~= 0)
    Train:SetNW2Bool("RtI",Train.RearTrainLineIsolation.Value ~= 0)
    Train:SetNW2Bool("AD",Train.AirDistributorDisconnect.Value == 0)


    self.Timer = self.Timer or CurTime()
    if ((CurTime() - self.Timer > 0.10) and (self.DriverValvePosition > self.RealDriverValvePosition)) then
        self.Timer = CurTime()
        if self.RealDriverValvePosition ~= 3 then
            Train:PlayOnce("br_334",self.RealDriverValvePosition.."-"..(self.RealDriverValvePosition+1))
        end
        self.RealDriverValvePosition = self.RealDriverValvePosition + 1
    end
    if ((CurTime() - self.Timer > 0.10) and (self.DriverValvePosition < self.RealDriverValvePosition)) then
        self.Timer = CurTime()
        if self.RealDriverValvePosition ~= 5 then
            Train:PlayOnce("br_334",self.RealDriverValvePosition.."-"..(self.RealDriverValvePosition-1))
        end
        self.RealDriverValvePosition = self.RealDriverValvePosition - 1
    end
    --[=[
    --Pneumatic relays blocking
    if Train.LK1 then
        if self.TrainLinePressure < 3 and Train.LK1.Blocked < 1 then
            for i = 1,5 do
                --self.Train[Format("LK%d",i)]:TriggerInput("Open", 1)
                self.Train[LKNames[i]]:TriggerInput("Block", 1)
            end
            Train.RKR:TriggerInput("Block", 1)
        elseif self.TrainLinePressure > 3 and Train.LK1.Blocked > 0  then
            for i = 1,5 do
                self.Train[LKNames[i]]:TriggerInput("Block", 0)
            end
            Train.RKR:TriggerInput("Block", 0)
        end
    end--]=]
end

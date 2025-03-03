--------------------------------------------------------------------------------
-- 81-714 pneumatic system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_714_NewPneumatic")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize(parameters)
    self.ValveType = 1
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
    self.BrakeLinePressure = 3.0 -- atm
    -- Pressure in brake cylinder
    self.BrakeCylinderPressure = 0.0 -- atm
    -- Pressure in the door line
    self.DoorLinePressure = 0.0 -- atm
	self.LeftDoorCloseCylPressure = 0.0
	self.LeftDoorOpenCylPressure = 0.0
	self.RightDoorCloseCylPressure = 0.0
	self.RightDoorOpenCylPressure = 0.0
    self.LeftExhausted = false
    self.RightExhausted = false

    self.OldBrakeLinePressure = 0.0
    self.BCPressure = 0
    -- Air distrubutor part
    self.WorkingChamberPressure = 5.2
    -- Disconnected KM 334 vessels (trainline and brakeline parts between disconnect valve and KM itself) emulation
    self.TLDisconnectPressure = 0.0
    self.BLDisconnectPressure = 0.0
    self.WCChargeValve = false
    self.PN1 = 0
    self.PN2 = 0
    self.cranPres = 0
    self.KM013offset    = 5.2
    self.km013_overcharge = false

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
    --Стояночный тормоз
    self.Train:LoadSystem("ParkingBrake","Relay","Switch",{bass = true})
    -- Isolation valves
    self.Train:LoadSystem("FrontBrakeLineIsolation","Relay","Switch", { normally_closed = true, bass = true})
    self.Train:LoadSystem("RearBrakeLineIsolation","Relay","Switch", { normally_closed = true, bass = true})
    self.Train:LoadSystem("FrontTrainLineIsolation","Relay","Switch", { normally_closed = true, bass = true})
    self.Train:LoadSystem("RearTrainLineIsolation","Relay","Switch", { normally_closed = true, bass = true})
    ------------------------------------------------------------------------------------------------
	--Ручное управление дверьми
    --Краны выключения дверей и разобщительный кран ДВР
	self.Train:LoadSystem("DoorReleaseRight","Relay","Switch")
	self.Train:LoadSystem("DoorReleaseLeft","Relay","Switch")
	self.Train:LoadSystem("DVRDisconnect","Relay","Switch", { normally_closed = false, bass = true})
	--Механическая блокировка дверей
    self.Train:LoadSystem("IDLK1","Relay","VB-11", {bass = true})	--4 левый
    self.Train:LoadSystem("IDLK2","Relay","VB-11", {bass = true})	--3 левый
    self.Train:LoadSystem("IDLK3","Relay","VB-11", {bass = true})	--2 левый
    self.Train:LoadSystem("IDLK4","Relay","VB-11", {bass = true})	--1 левый
    self.Train:LoadSystem("IDLK5","Relay","VB-11", {bass = true})	--1 правый
    self.Train:LoadSystem("IDLK6","Relay","VB-11", {bass = true})	--2 правый
    self.Train:LoadSystem("IDLK7","Relay","VB-11", {bass = true})	--3 правый
    self.Train:LoadSystem("IDLK8","Relay","VB-11", {bass = true})	--4 правый
	--раздвинуть/сдвинуть створки руками
	self.Train:LoadSystem("iod1","Relay","Switch")
	self.Train:LoadSystem("iod2","Relay","Switch")
	self.Train:LoadSystem("iod3","Relay","Switch")
	self.Train:LoadSystem("iod4","Relay","Switch")
	self.Train:LoadSystem("iod5","Relay","Switch")
	self.Train:LoadSystem("iod6","Relay","Switch")
	self.Train:LoadSystem("iod7","Relay","Switch")
	self.Train:LoadSystem("iod8","Relay","Switch")
	self.Train:LoadSystem("icd1","Relay","Switch")
	self.Train:LoadSystem("icd2","Relay","Switch")
	self.Train:LoadSystem("icd3","Relay","Switch")
	self.Train:LoadSystem("icd4","Relay","Switch")
	self.Train:LoadSystem("icd5","Relay","Switch")
	self.Train:LoadSystem("icd6","Relay","Switch")
	self.Train:LoadSystem("icd7","Relay","Switch")
	self.Train:LoadSystem("icd8","Relay","Switch")

    -- Brake cylinder atmospheric valve open
    self.BrakeCylinderValve = 0

    -- Overpressure protection valve open
    self.TrainLineOverpressureValve = 0

    -- Compressor simulation
    self.Compressor = 0 --Simulate overheat with TRK FIXME

    -- Door release valve status
	self.DoorReleaseRightPrevious = 0
    self.DoorReleaseLeftPrevious = 0

    -- Doors state
    if not TURBOSTROI then
        self.LeftDoorState = self.LeftDoorState or { 0,0,0,0 }
        self.RightDoorState = self.RightDoorState or { 0,0,0,0 }
        --self.LeftDoorDir = { 0,0,0,0 }
        --self.RightDoorDir = { 0,0,0,0 }
        self.LeftDoorSpeed = {1,1,1,1}
        self.RightDoorSpeed = {1,1,1,1}
		self.DSprev = {{0,0},{0,0},{0,0},{0,0}}
        self.LeftDoorStuck = {false, false, false, false}
        self.RightDoorStuck = {false, false, false, false}

        local start = math.Rand(0.6,1.0)
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

    self.BLDisconnect = true
    self.TLDisconnect = true

    self.OldValuePos = self.DriverValvePosition

    self.WeightLoadRatio = 0
    self.PassengerDoor = 0
end

function TRAIN_SYSTEM:Inputs()
    return { "BrakeUp", "BrakeDown", "BrakeSet", "ValveType", "Autostop", "KM013offset" }
end

function TRAIN_SYSTEM:Outputs()
    return { "BrakeLinePressure", "BrakeCylinderPressure", "DriverValvePosition", "WorkingChamberPressure", "LeftDoorCloseCylPressure", "LeftDoorOpenCylPressure",
             "ReservoirPressure", "TrainLinePressure", "DoorLinePressure", "WeightLoadRatio", "RightDoorCloseCylPressure", "RightDoorOpenCylPressure" }
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
    elseif name == "KM013offset" then
        self.KM013offset = value
    elseif name == "KM013Over" then
        self.km013_overcharge = value
    elseif name:match("VZ%dOffset") then
        local idx = name:match("VZ(%d)Offset")
        self["GN"..idx.."Offset"] = math.random(2,10)*0.02 + value
        self["GN"..idx.."Start"] = value
        --PrintMessage(HUD_PRINTTALK, Format("Вагон %u; ВЗ-1: %.1f; ВЗ-2: %.1f",self.Train:GetWagonNumber(),self.GN1Offset or 0,self.GN2Offset or 0))
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
    local Fl=math.min(0,self:equalizeCouplePressure(dT,"BrakeLinePressure",frontBrakeLeak==false and Ft,frontBrakeOpen,50,frontBrakeLeak or 0.08)*3)*(frontBrakeLeak and 1 or 0)
    local Rl=math.min(0,self:equalizeCouplePressure(dT,"BrakeLinePressure",rearBrakeLeak==false and Rt,rearBrakeOpen,50,rearBrakeLeak or 0.08)*3)*(rearBrakeLeak and 1 or 0)

    Fl=Fl+math.min(0,self:equalizeCouplePressure(dT,"TrainLinePressure",frontTrainLeak==false and Ft or Fb,frontTrainOpen,100,frontTrainLeak or 0.08)*10)*(frontTrainLeak and 1 or 0)
    Rl=Rl+math.min(0,self:equalizeCouplePressure(dT,"TrainLinePressure",rearTrainLeak==false and Rt or Rb,rearTrainOpen,100,rearTrainLeak or 0.08)*10)*(rearTrainLeak and 1 or 0)

    self.TrainLineOpen=frontTrainLeak or rearTrainLeak
    self.BrakeLineOpen=frontBrakeLeak or rearBrakeLeak
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
    local retainer = Train:GetNW2Int("RetainerLoad", 4)
    self.WeightLoadRatio = retainer == 4 and math.max(0,math.min(1,(Train:GetNW2Float("PassengerCount")/200))) or (retainer-1)*0.5

    --if not Train.DoorSpeedsDone then
    --    local start
    --    if #Train.WagonList == Train.CarCount and Train.d_speeds then
    --        start = math.Rand(unpack(Train.d_speeds[math.random(1,#Train.d_speeds)]))
    --    end
    --    if start then
    --        MsgC(Color(200,200,200),"Setting doors speed for car "..tostring(self.Train).."; start = "..tostring(start).."...")
    --        self.DoorSpeedMain = start--math.Rand(start,math.Rand(start+0.1,start+0.2))
    --        for i=1,#self.LeftDoorSpeed do
    --            --if math.random() > 0.7 then
    --            --    self.LeftDoorSpeed[i] = math.Rand(self.DoorSpeedMain-0.2,self.DoorSpeedMain+0.2)
    --            --    self.RightDoorSpeed[i] = math.Rand(self.DoorSpeedMain-0.2,self.DoorSpeedMain+0.2)
    --            --else
    --                self.LeftDoorSpeed[i] = math.Rand(self.DoorSpeedMain-0.1,self.DoorSpeedMain)
    --                self.RightDoorSpeed[i] = math.Rand(self.DoorSpeedMain-0.1,self.DoorSpeedMain)
    --            --end
    --        end
    --        Train.DoorSpeedsDone = true
    --        MsgC(Color(200,200,200),"done\n")
    --    else
    --        MsgC(Color(200,200,200),"failed!\n")
    --    end
    --end
    if not Train.DoorSpeedsDone and Train.CarCount then
        local set
        if #Train.WagonList == Train.CarCount and Train.d_speeds then
            set = math.random(1,#Train.d_speeds)
            local a,b = unpack(Train.d_speeds[set])
            --MsgC(Color(200,200,200),"Setting doors speed for car "..tostring(self.Train).."; set = {"..a..", "..b.."} ...")
            for i=1,#self.LeftDoorSpeed do
                self.LeftDoorSpeed[i] = math.Rand(a,b)
                self.RightDoorSpeed[i] = math.Rand(a,b)
            end
            Train.DoorSpeedsDone = true
            --MsgC(Color(200,200,200),"done\n")
        else
            --MsgC(Color(200,200,200),"failed!\n")
        end
    end
    ----------------------------------------------------------------------------
    -- Accumulate derivatives
    self.TrainLinePressure_dPdT = 0.0
    self.BrakeLinePressure_dPdT = 0.0
    self.ReservoirPressure_dPdT = 0.0
    self.BrakeCylinderPressure_dPdT = 0.0
    self.ParkingBrakePressure_dPdT = 0.0
    self.WorkingChamberPressure_dPdT = 0.0

    -- Doors
	self.LeftDoorCloseCylPressure_dPdT = 0.0
	self.RightDoorCloseCylPressure_dPdT = 0.0
	self.LeftDoorOpenCylPressure_dPdT = 0.0
	self.RightDoorOpenCylPressure_dPdT = 0.0
	self.DoorLinePressure_dPdT = 0.0

    -- Reduce pressure for brake line
    self.TrainToBrakeReducedPressure = math.min(self.KM013offset,self.TrainLinePressure) -- * 0.725)
    -- Feed pressure to door line
    self.DoorLinePressure = Train.DVRDisconnect.Value == 0 and math.min(3.6,self.TrainLinePressure) or self.DoorLinePressure
    local trainLineConsumption_dPdT = 0.0
    local wagc = Train:GetBLConnectedWagonCount()
    local HaveEPK = not Train.SubwayTrain or not Train.SubwayTrain.ARS or not Train.SubwayTrain.ARS.NoEPK

    local pr_speed = 1

    if self.ValveType == 1 then
        self.BLDisconnect = Train.DriverValveBLDisconnect.Value > 0
        self.TLDisconnect = Train.DriverValveTLDisconnect.Value > 0 and self.RealDriverValvePosition ~= 3
        pr_speed = 1*6--wagc--*((self.BrakeLinePressure-self.ReservoirPressure)/0.6) --2
        if self.TLDisconnect then self.TLDisconnectPressure = self.TrainLinePressure end
        if self.Leak or self.BrakeLineOpen then pr_speed = pr_speed*0.3 end
        -- 334: 1 Fill reservoir from train line, fill brake line from train line
        if (self.RealDriverValvePosition == 1) then
            if self.TLDisconnect or self.ReservoirPressure ~= self.TLDisconnectPressure then
                if self.BLDisconnect then
                    self:equalizePressure(dT,"ReservoirPressure", self.TLDisconnectPressure, 1.4,nil,nil,2)
                    self:equalizePressure(dT,"ReservoirPressure", self.BrakeLinePressure, 0,1.2,nil,2)
                    self:equalizePressure(dT,"BrakeLinePressure", self.TLDisconnectPressure, 6.0,nil,nil,0.2)
                else
                    self:equalizePressure(dT,"ReservoirPressure", self.TLDisconnectPressure, 3.55,nil,nil,2)
                end
            end
        end

        -- 334: 2 Brake line, reservoir replenished from brake line reductor
        if (self.RealDriverValvePosition == 2) then
            if self.TLDisconnect then
                local a = 1
                if --[[self.EmergencyValve or ]]Train.EmergencyBrakeValve.Value > 0.5 then a = 1.85 end
                if self.BLDisconnect then
                    self:equalizePressure(dT,"ReservoirPressure", self.BrakeLinePressure,6,nil,nil,2)
                    self:equalizePressure(dT,"BrakeLinePressure", self.TrainToBrakeReducedPressure, pr_speed*0, pr_speed*0.6*a, nil, 1.6)
                    self.ReservoirPressure_dPdT = self.BrakeLinePressure_dPdT*0.8 
                else
                    self:equalizePressure(dT,"ReservoirPressure", self.TrainToBrakeReducedPressure,0,1.55,nil,2)
                end
            end
        end

        -- 334: 3 Close all valves
        if (self.RealDriverValvePosition == 3) then
            -- Typical leak
            self:equalizePressure(dT,"ReservoirPressure", 0.00, 0.001)
        end

        local res_dischrg_rate4 = self.BLDisconnect and 0.55 or 8
        local res_dischrg_rate5 = self.BLDisconnect and 1.12 or 8
        -- 334: 4 Reservoir open to atmosphere, brake line equalizes with reservoir
        if (self.RealDriverValvePosition == 4) then
            self:equalizePressure(dT,"ReservoirPressure", 0.0, res_dischrg_rate4, nil,nil,6)--0.35)-0.55
        end

        -- 334: 5 Reservoir and brake line open to atmosphere
        if (self.RealDriverValvePosition == 5) then
            self:equalizePressure(dT,"ReservoirPressure", 0.0, res_dischrg_rate5)--,nil,nil,2)--1.70
            local pr_speed = 1.25*6--wagc
            if self.Leak or self.BrakeLineOpen then pr_speed = pr_speed*0.3 end
            if self.BLDisconnect then
                if self.Leak then pr_speed = pr_speed*6.2 end
                self:equalizePressure(dT,"BrakeLinePressure", 0.0, pr_speed,nil,nil,2)
            end
        end
        -- утечка через неплотность уравнительного поршня
        if self.BLDisconnect then self:equalizePressure(dT, "ReservoirPressure", self.BrakeLinePressure, 0.06, 0) end
        if (self.RealDriverValvePosition > 2) and (self.RealDriverValvePosition < 5) then
            local pr_speed = 1.25*6--wagc
            if self.Leak or self.BrakeLineOpen then pr_speed = pr_speed*0.3 end
            local _a = 0
            for _i = 1, #Train.WagonList do
                if Train.WagonList[_i].Pneumatic.TLDisconnect and Train.WagonList[_i].Pneumatic.BLDisconnect and (Train.WagonList[_i].Pneumatic.RealDriverValvePosition == 2 or Train.WagonList[_i].Pneumatic.RealDriverValvePosition == 1) then
                    _a = _a + 1
                end
                if _a > 0 then break end
            end
            if _a > 0 then pr_speed = pr_speed*0.1 end
            if self.BLDisconnect and self.BrakeLinePressure - self.ReservoirPressure > (self.RealDriverValvePosition == 3 and 0 or self.RealDriverValvePosition == 4 and 0.2 or 100) then      --0.2 bar is a piston sensitivity
                self:equalizePressure(dT, "BrakeLinePressure", 0, pr_speed*math.abs(self.BrakeLinePressure - self.ReservoirPressure), nil, nil, 6)
            end
        end

        if not self.TLDisconnect then
            self.TLDisconnectPressure = math.max(0,self.TLDisconnectPressure - math.abs(self.ReservoirPressure_dPdT)*0.074)
        end
        self.ReservoirPressure_dPdT = self.ReservoirPressure_dPdT + self.BrakeLinePressure_dPdT*0.2
        Train:SetPackedRatio("ReservoirPressure_dPdT",self.ReservoirPressure_dPdT/wagc*2)
        --[[
            ---------------debug---------------------
            self.dlreadtimer = self.dlreadtimer or CurTime()
            if CurTime() - self.dlreadtimer > 1.0 then
                self.dlreadtimer = CurTime()
                if Train:GetDriver() then
                    PrintMessage(HUD_PRINTTALK, Format("Вагон %u; P ТМ: %.3f; P УР =%.3f; Утечка ТМ %.3f; TLDis = %.3f; pr_speed = %.3f",Train:GetWagonNumber(),self.BrakeLinePressure,self.ReservoirPressure,self.BrakeLinePressure_dPdT, self.TLDisconnectPressure, pr_speed))
                end
            end
            ---------------debug---------------------]]
        trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeLinePressure_dPdT)
        trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.ReservoirPressure_dPdT)*0.05
    else
        pr_speed = 2.8--1.25*wagc --2
        local pz_speed
        -- wagc | pr_speed
        ------------------
        -- 1    |   8.455
        -- 2    |   7.865
        -- 3    |   7.376
        -- 4    |   6.969
        -- 5    |   6.627
        -- 6    |   6.341
        -- 7    |   6.100
        -- 8    |   5.900
        --pr_speed = (0.4*math.exp(0.1*wagc-1)+1)*160/(2*wagc+20) --2
        --local frc = 0.6--0.35
        if self.Leak or self.BrakeLineOpen then pz_speed = pr_speed*0.25 else pz_speed = pr_speed*1.3 end--*frc end
        self.BLDisconnect = Train.DriverValveBLDisconnect.Value > 0
        self.TLDisconnect = Train.DriverValveTLDisconnect.Value > 0
        if self.km013_overcharge and self.RealDriverValvePosition > 4 and not self.km13_error2 then self.km13_error2 = math.random()*0.3+0.4 end
        -- 013: 1 Overcharge
        if (self.RealDriverValvePosition == 1) and self.BLDisconnect and (self.TLDisconnect or self.BrakeLinePressure > self.TrainLinePressure) then
	        self:equalizePressure(dT,"BrakeLinePressure", math.min(6.4,self.TrainLinePressure), pr_speed, pz_speed, nil, 1.0)
        end

        -- 013: 2 Normal pressure
        if (self.RealDriverValvePosition == 2) and self.BLDisconnect and (self.TLDisconnect or self.BrakeLinePressure > math.min(self.KM013offset,self.TrainToBrakeReducedPressure)) then--was pr_speed*2
            self:equalizePressure(dT,"BrakeLinePressure", math.min(self.KM013offset+(self.km13_error2 or 0),self.TrainLinePressure), pr_speed, pz_speed, nil, 2.5)-- nil, 1.0)
            if self.km13_error2 and self.BrakeLinePressure >= self.KM013offset+self.km13_error2-0.1 then
                self:equalizePressure(dT,"BrakeLinePressure", math.min(self.KM013offset,self.TrainToBrakeReducedPressure), 35, pz_speed, nil, 1)
                self.km13_error2 = nil
            end
        end

        -- 013: 3 4.3 Atm
        if (self.RealDriverValvePosition == 3) and self.BLDisconnect and (self.TLDisconnect or self.BrakeLinePressure > math.min(4.3,self.TrainToBrakeReducedPressure)) then
            self:equalizePressure(dT,"BrakeLinePressure", math.min(4.3,self.TrainToBrakeReducedPressure), pr_speed*1.5,pz_speed, nil, 2.5)
        end

        -- 013: 4 4.0 Atm
        if (self.RealDriverValvePosition == 4) and self.BLDisconnect and (self.TLDisconnect or self.BrakeLinePressure > math.min(4.0,self.TrainToBrakeReducedPressure)) then
            self:equalizePressure(dT,"BrakeLinePressure", math.min(4.0,self.TrainToBrakeReducedPressure), pr_speed*1.5,pz_speed, nil, 2.5)
        end

        -- 013: 5 3.7 Atm
        if (self.RealDriverValvePosition == 5) and self.BLDisconnect and (self.TLDisconnect or self.BrakeLinePressure > math.min(3.7,self.TrainToBrakeReducedPressure)) then
            self:equalizePressure(dT,"BrakeLinePressure", math.min(3.7,self.TrainToBrakeReducedPressure), pr_speed*1.5,pz_speed, nil, 2.5)
        end

        -- 013: 6 3.0 Atm
        if (self.RealDriverValvePosition == 6) and self.BLDisconnect and (self.TLDisconnect or self.BrakeLinePressure > math.min(3.0,self.TrainToBrakeReducedPressure)) then
            self:equalizePressure(dT,"BrakeLinePressure", math.min(3.0,self.TrainToBrakeReducedPressure), pr_speed*1.5,pz_speed, nil, 2.5)
        end

        -- 013: 7 0.0 Atm
        if (self.RealDriverValvePosition == 7) and self.BLDisconnect and (self.TLDisconnect or self.BrakeLinePressure > 0.0) then
            self:equalizePressure(dT,"BrakeLinePressure", 0.0, (0.6 + pr_speed*math.exp(math.min(0,self.BrakeLinePressure - 2.3)*1.0))*(0.15*wagc+1),pz_speed, nil, 2.5)
        end
        trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeLinePressure_dPdT)
    end
    self.Leak = false
    if wagc ~= Train.OldWagIsoCount or not Train.pr_spd_init then
        pr_speed = (0.4*math.exp(0.1*wagc-1)+1)*160/(2*wagc+20) --2
        Train.OldWagIsoCount = wagc
        Train.pr_spd_init = true
    end
    if self.ValveType == 1 then
        Train:SetPackedRatio("Crane_dPdT", self.ReservoirPressure_dPdT )
    else
        Train:SetPackedRatio("Crane_dPdT", self.BrakeLinePressure_dPdT/wagc*3 )
    end

    local leak = 0
    if Train.EmergencyBrakeValve and Train.EmergencyBrakeValve.Value > 0.5 then
	    local leakst = math.max(0.5,math.exp(0.5*self.BrakeLinePressure))
        leak = self:equalizePressure(dT,"BrakeLinePressure", 0.0,leakst)--,false,false,10) --was leakst*wagc/5
        self.Leak = true
    end
    Train:SetPackedRatio("EmergencyBrakeValve_dPdT", -leak/wagc)
    ----------------------------------------------------------------------------
    -- Fill brake cylinders
    if self.WCChargeValve == true then
	    self:equalizePressure(dT,"WorkingChamberPressure",self.BrakeLinePressure,0.094,nil,nil,1.0)	--simulate 0.8mm hole btw BL and working chambers
    end
    local aird_ready = self.WorkingChamberPressure >= 2.2
    self.WCChargeValve = not ((self.WorkingChamberPressure - self.BrakeLinePressure) > 0.2 and (self.WorkingChamberPressure - self.BrakeLinePressure) < 2.5)
    local KLSZ = self.WorkingChamberPressure > 5.2 and not self.WCChargeValve
    if KLSZ then
	    self:equalizePressure(dT,"WorkingChamberPressure",0.0,0.12)	-- КЛСЗ
    end

    trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.WorkingChamberPressure_dPdT*0.2)
    self.GN2Offset = self.GN2Offset or math.random(20,100)*0.002 + (self.GN2Start or 2.4)
    self.GN1Offset = self.GN1Offset or math.random(20,100)*0.002 + (self.GN1Start or 0.8)
    self.BcBl = (self.GN2Offset + self.WeightLoadRatio*(self.GN2Offset - 1.4))/1.82--1.92
    if Train.AirDistributorDisconnect.Value == 0 and aird_ready then
        -- Valve #1
        if (Train.PneumaticNo1.Value == 1.0) and (Train.PneumaticNo2.Value == 0.0) then
            if self.PN1 < self.GN1Offset then
                self.PN1 = math.min(self.TrainLinePressure,self.GN1Offset)
            end
        elseif Train.PneumaticNo1.Value == 0 and self.PN1 > 0.0 then
            self.PN1 = self.BrakeCylinderPressure > 0.2 and 0.05 or self.PN1 - 0.5*dT
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
        --[[
            ---------------debug---------------------
            self.brreadtimer = self.brreadtimer or CurTime()
            if CurTime() - self.brreadtimer > 1.0 then
                self.brreadtimer = CurTime()
                if Train:GetDriver() then
                    --PrintMessage(HUD_PRINTTALK, Format("br_threshold = %.3f; WcBl = %s",br_threshold, tostring(WcBl)))
                    --PrintMessage(HUD_PRINTTALK, Format("Это %s", isLVZ and "ЛВЗ" or "не ЛВЗ"))
                    --PrintMessage(HUD_PRINTTALK, Format("Вагон %u; Авторежим: %.3f",Train:GetWagonNumber(),self.WeightLoadRatio))
                    --PrintMessage(HUD_PRINTTALK, Format("wagc = %u; wagd = %u",wagc,wagd))
                end
            end
            ---------------debug---------------------]]                

        self.BchExh = self.WorkingChamberPressure < 4.8 and self.BrakeLinePressure < 3.4 and 0 or 1
        self.cranPres = math.max(0,self.BcBl*(self.WorkingChamberPressure - self.BrakeLinePressure*self.BchExh)*(self.BrakeLinePressure > self.KM013offset and (0.6 + self.PN1*0.43) or 1))
        local targetPressure = math.max(0,math.min(self.GN2Offset + self.WeightLoadRatio*1.3, (self.cranPres < (self.PN1 + self.WeightLoadRatio*0.7) and (Train.PneumaticNo1.Value == 1.0) and (self.PN1 + self.WeightLoadRatio*0.7) or self.PN1) + self.PN2 + self.cranPres))
        if math.abs(self.BrakeCylinderPressure - targetPressure) > 0.150 then
            self.BrakeCylinderValve = 1
        end
        if math.abs(self.BrakeCylinderPressure - targetPressure) < 0.025 then
            self.BrakeCylinderValve = 0
        end
        if self.BrakeCylinderValve == 1 then
            self:equalizePressure(dT,"BrakeCylinderPressure", math.min(self.GN2Offset + self.WeightLoadRatio*(self.GN2Offset - 1.4),targetPressure), 0.8, (Train.PneumaticNo1.Value > 0 or Train.PneumaticNo2.Value > 0) and 2.8 or 1.5, nil, 1.2)
        end
        trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeCylinderPressure_dPdT*0.5)
    elseif Train.AirDistributorDisconnect.Value ~= 0 then
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
    -- Simulate doors opening, closing
	local LeftRelease = Train.DoorReleaseLeft.Value == 0
	local RightRelease = Train.DoorReleaseRight.Value == 0
    if self.DoorLinePressure >= 1.4 then	--was > 2.6
        -- Simulate DVR engage lag
        if Train.VDOL.Value == 1.0 and not Train.VDOLEnergized then
            Train.VDOLEnergized = true
            Train.VDOLTime = RealTime()
        elseif Train.VDOL.Value == 0.0 then
            Train.VDOLEnergized = false
        end
        if Train.VDOP.Value == 1.0 and not Train.VDOPEnergized then
            Train.VDOPEnergized = true
            Train.VDOPTime = RealTime()
        elseif Train.VDOP.Value == 0.0 then
            Train.VDOPEnergized = false
        end
        if (Train.VDOL.Value == 1.0) and (Train.VDOP.Value == 0.0) and not self.DoorLeft then
            if Train.VDOLTime and RealTime() - Train.VDOLTime > (Train.DVRLag or 0) then self.DoorLeft = true end
            if self.VDOLLoud then Train:PlayOnce("vdol_loud","cabin",0.8+math.random()*0.2,self.VDOLLoud) end
        end
        if (Train.VDOL.Value == 0.0) and (Train.VDOP.Value == 1.0) and not self.DoorRight then
            if Train.VDOPTime and RealTime() - Train.VDOPTime > (Train.DVRLag or 0) then self.DoorRight = true end
            if self.VDORLoud then Train:PlayOnce("vdop_loud","cabin",0.8+math.random()*0.2,self.VDORLoud) end
        end
        if Train.DVRHiss == 2 then 
            if Train.RD.Value == 1 and Train.VDOL.Value == 1 and not self.LeftExhausted then
                Train:PlayOnce("dcyl_op_exh","bass",1,1)
                self.LeftExhausted = true
            end
            if Train.RD.Value == 1 and Train.VDOP.Value == 1 and not self.RightExhausted then
                Train:PlayOnce("dcyl_op_exh","bass",1,1)
                self.RightExhausted = true
            end
        end
        if (Train.VDZ.Value == 1.0 or Train.VDOL.Value == 1.0 and Train.VDOP.Value == 1.0 or self.RZDTimer) and (self.DoorLeft or self.DoorRight) then
            --if not self.OpenWaitL or CurTime()-self.OpenWaitL < 0.2 then
                self.DoorLeft = false
            --end
            --if not self.OpenWaitR or CurTime()-self.OpenWaitR < 0.2 then
                self.DoorRight = false
            --end
            if Train.DVRHiss == 2 then
                if Train.RD.Value == 0 and (self.LeftExhausted or self.RightExhausted) then
                    Train:PlayOnce("dcyl_cl_exh","bass",1,0.6)
                    self.LeftExhausted = false
                    self.RightExhausted = false
                end
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
	-- Тут было бы лучше сделать не 2 цилиндра на вагон, а 8, но тогда будет не 4 вызова функции, а 16...
    self:equalizePressure(dT,"RightDoorOpenCylPressure", self.DoorRight and self.DoorLinePressure or 0.0, 2.2, 10)
    self:equalizePressure(dT,"RightDoorCloseCylPressure", not self.DoorRight and RightRelease and self.DoorLinePressure or 0.0, 2.2, 10)
    self:equalizePressure(dT,"LeftDoorOpenCylPressure", self.DoorLeft and self.DoorLinePressure or 0.0, 2.2, 10)
    self:equalizePressure(dT,"LeftDoorCloseCylPressure", not self.DoorLeft and LeftRelease and self.DoorLinePressure or 0.0, 2.2, 10)
    self.DoorLinePressure = self.DoorLinePressure-math.max(0,self.RightDoorOpenCylPressure_dPdT*0.01)
    self.DoorLinePressure = self.DoorLinePressure-math.max(0,self.LeftDoorOpenCylPressure_dPdT*0.01)
    self.DoorLinePressure = self.DoorLinePressure-math.max(0,self.RightDoorCloseCylPressure_dPdT*0.01)
    self.DoorLinePressure = self.DoorLinePressure-math.max(0,self.LeftDoorCloseCylPressure_dPdT*0.01)
    Train:SetPackedRatio("RightDoorCloseCylPressure_dPdT",not RightRelease and self.RightDoorCloseCylPressure_dPdT or 0)
    Train:SetPackedRatio("LeftDoorCloseCylPressure_dPdT",not LeftRelease and self.LeftDoorCloseCylPressure_dPdT or 0)
	if self.DoorReleaseRightPrevious ~= Train.DoorReleaseRight.Value then
		self.DoorReleaseRightPrevious = Train.DoorReleaseRight.Value
		---[[
		if not self.DoorRight and self.DoorReleaseRightPrevious == 1 then
			self:equalizePressure(dT,"RightDoorCloseCylPressure", 0, 6)		--was DoorLinePressure
		end--]]
	end
	if self.DoorReleaseLeftPrevious ~= Train.DoorReleaseLeft.Value then
		self.DoorReleaseLeftPrevious = Train.DoorReleaseLeft.Value
		---[[
		if not self.DoorLeft and self.DoorReleaseLeftPrevious == 1 then
			self:equalizePressure(dT,"LeftDoorCloseCylPressure", 0, 6)		--was DoorLinePressure
		end--]]
	end
    if self.VDOL ~= Train.VDOL.Value then
        self.VDOL = Train.VDOL.Value
        self:equalizePressure(dT,Train.DVRDisconnect.Value == 0 and "TrainLinePressure" or "DoorLinePressure", 0.0, 0.05)	--was 0.3
    end
    if self.VDOP ~= Train.VDOP.Value then
        self.VDOP = Train.VDOP.Value
        self:equalizePressure(dT,Train.DVRDisconnect.Value == 0 and "TrainLinePressure" or "DoorLinePressure", 0.0, 0.05)	--was 0.3
    end
    if self.VDZ ~= Train.VDZ.Value then
        self.VDZ = Train.VDZ.Value
        self:equalizePressure(dT,Train.DVRDisconnect.Value == 0 and "TrainLinePressure" or "DoorLinePressure", 0.0, 0.05)	--was 0.3
    end
    trainLineConsumption_dPdT = trainLineConsumption_dPdT + (Train.DVRDisconnect.Value == 0 and math.max(0,self.DoorLinePressure_dPdT*0.2) or 0)
    if Train.CanStuckPassengerLeft then
        for i in ipairs(self.LeftDoorStuck) do
            self.LeftDoorStuck[i] = math.random() < (0.6+math.min(2,2-self.LeftDoorSpeed[i])*0.2)*Train.CanStuckPassengerLeft*0.6 and (math.random() > 0.7 and CurTime()+math.random()*15)
        end
        Train.CanStuckPassengerLeft = false
    end
    if Train.CanStuckPassengerRight then
        for i in ipairs(self.RightDoorStuck) do
            self.RightDoorStuck[i] = math.random() < (0.6+math.min(2,2-self.RightDoorSpeed[i])*0.2)*Train.CanStuckPassengerRight*0.6 and (math.random() > 0.7 and CurTime()+math.random()*15)
        end
        Train.CanStuckPassengerRight = false
    end


    Train.LeftDoorsOpen = false
    Train.RightDoorsOpen = false
    local openL = true
    local openR = true
	local llocked = false
	local rlocked = false
	local rmOpen = false							--|Right and left doors
	local rmClose = false							--|
	local lmOpen = false							--|
    local lmClose = false							--|manual opening-closing
	local v = "IDLK"
	local m = "iod"
	local n = "icd"
    for i=1,4 do
        rlocked = Train[v..i].Value > 0
		llocked = Train[v..tostring(9-i)].Value > 0
		rmOpen = Train[m..i].Value > 0
		lmOpen = Train[m..tostring(9-i)].Value > 0
		rmClose = Train[n..i].Value > 0
		lmClose = Train[n..tostring(9-i)].Value > 0
        --self.LeftDoorState[i] = math.Clamp(self.LeftDoorState[i] + (not llocked and ((lmOpen and 1.5 or lmClose and -1.5 or 0) + (self.DoorLinePressure > 1.0 and (math.Round(self.LeftDoorOpenCylPressure - self.LeftDoorCloseCylPressure,1))*0.36*(not (lmOpen or lmClose) and self.LeftDoorSpeed[i] or 1) or 0))*dT or 0),self.LeftDoorStuck[i] and 0.3 or 0,1)
        --self.RightDoorState[i] = math.Clamp(self.RightDoorState[i] + (not rlocked and ((rmOpen and 1.5 or rmClose and -1.5 or 0) + (self.DoorLinePressure > 1.0 and (math.Round(self.RightDoorOpenCylPressure - self.RightDoorCloseCylPressure,1))*0.36*(not (rmOpen or rmClose) and self.RightDoorSpeed[i] or 1) or 0))*dT or 0),self.RightDoorStuck[i] and 0.3 or 0,1)
        self.LeftDoorState[i] = math.Clamp(self.LeftDoorState[i] + (not llocked and ((lmOpen and 1.5 or lmClose and -1.5 or 0) + (self.DoorLinePressure > 1.4 and (self.LeftDoorOpenCylPressure - self.LeftDoorCloseCylPressure)*0.36*(not (lmOpen or lmClose) and self.LeftDoorSpeed[i] or 1) or 0))*dT or 0),self.LeftDoorStuck[i] and 0.3 or 0,1)
        self.RightDoorState[i] = math.Clamp(self.RightDoorState[i] + (not rlocked and ((rmOpen and 1.5 or rmClose and -1.5 or 0) + (self.DoorLinePressure > 1.4 and (self.RightDoorOpenCylPressure - self.RightDoorCloseCylPressure)*0.36*(not (rmOpen or rmClose) and self.RightDoorSpeed[i] or 1) or 0))*dT or 0),self.RightDoorStuck[i] and 0.3 or 0,1)
        if not Train.LeftDoorsOpen and self.LeftDoorState[i] > 0.02 then	--was 0.06
            Train.LeftDoorsOpen = true
        end
        if not Train.RightDoorsOpen and self.RightDoorState[i] > 0.02 then	--was 0.06
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
    Train:SetPackedBool("DoorL",self.DoorLeft)
    Train:SetPackedBool("DoorR",self.DoorRight)
    Train.BD:TriggerInput("Set",not Train.RightDoorsOpen and not Train.LeftDoorsOpen)
    Train.LeftDoorsOpening = self.DoorLeft
    Train.RightDoorsOpening = self.DoorRight

    ----------------------------------------------------------------------------
    -- Simulate compressor operation and train line depletion
    self.Compressor = Train.KK.Value * (Train.Electric.Aux750V > 550 and 1 or 0)
    self.TrainLinePressure = self.TrainLinePressure - (Train.AirConsumeRatio or 1)*trainLineConsumption_dPdT*dT -- 0.190 --0.170 --0.07
    if self.Compressor == 1 then self:equalizePressure(dT,"TrainLinePressure", 10.0, Train.CompressorEfficiency or 0.04) end -- 0.04
    self:equalizePressure(dT,"TrainLinePressure", 0,Train.AirLeakRatio or 0.003)
    -- Overpressure
    if self.TrainLinePressure > math.max(7.2, (9.2 - self.TrainLineOverpressureValve*0.2)) and self.TrainLineOverpressureValve%2 == 0 then self.TrainLineOverpressureValve = self.TrainLineOverpressureValve + 1 end
    if self.TrainLineOverpressureValve%2 == 1 then
        self:equalizePressure(dT,"TrainLinePressure", 0.0, 0.2)
        self.TrainLineOpen = true
        if self.TrainLinePressure < 5.2 and self.TrainLineOverpressureValve < 20 then self.TrainLineOverpressureValve = self.TrainLineOverpressureValve + 1 end
    end

    ----------------------------------------------------------------------------
    -- Pressure triggered relays
    Train.AVT:TriggerInput("Open", self.BrakeCylinderPressure > 1.9) -- 1.8 - 2.0
    Train.AVT:TriggerInput("Close",self.BrakeCylinderPressure < 0.9) -- 0.9 - 1.5
    Train.AK:TriggerInput( "Open", self.TrainLinePressure > 8.2)
    Train.AK:TriggerInput( "Close",self.TrainLinePressure < 6.3)
    Train.BPT:TriggerInput("Set",  (IsValid(Train.FrontBogey) and Train.FrontBogey.BrakeCylinderPressure+(not Train.FrontBogey.DisableParking and Train.FrontBogey.ParkingBrakePressure or 0) or self.BrakeCylinderPressure)>0.3)
    Train.DKPT:TriggerInput("Set", self.BrakeCylinderPressure > 0.3) -- 1.8 - 2.0

    ----------------------------------------------------------------------------
    -- FIXME
    Train:SetNW2Bool("FbI",Train.FrontBrakeLineIsolation.Value ~= 0)
    Train:SetNW2Bool("RbI",Train.RearBrakeLineIsolation.Value ~= 0)
    Train:SetNW2Bool("FtI",Train.FrontTrainLineIsolation.Value ~= 0)
    Train:SetNW2Bool("RtI",Train.RearTrainLineIsolation.Value ~= 0)
    Train:SetNW2Bool("AD",Train.AirDistributorDisconnect.Value == 0)
	Train:SetNW2Bool("DoorReleaseRight",Train.DoorReleaseRight.Value ~= 0)
	Train:SetNW2Bool("DoorReleaseLeft",Train.DoorReleaseLeft.Value ~= 0)

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

--------------------------------------------------------------------------------
-- 81-720 train control unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_720_BUKP")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.PowerCommand = 0
    self.PowerTarget = 0

    self.CurrentCab = false
    self.Train:LoadSystem("VityazF1","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VityazF2","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VityazF3","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VityazF4","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz1","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz4","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz7","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz2","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz5","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz8","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz0","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz3","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz6","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz9","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VityazF5","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VityazF6","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VityazF7","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VityazF8","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VityazF9","Relay","Switch",{bass=true})
    self.TriggerNames = {
        "VityazF1",
        "VityazF2",
        "VityazF3",
        "VityazF4",
        "Vityaz1",
        "Vityaz2",
        "Vityaz3",
        "Vityaz4",
        "Vityaz5",
        "Vityaz6",
        "Vityaz7",
        "Vityaz8",
        "Vityaz9",
        "Vityaz0",
        "VityazF5",
        "VityazF6",
        "VityazF7",
        "VityazF8",
        "VityazF9",
        "AttentionMessage"
    }
    self.Triggers = {}
    for k,v in pairs(self.TriggerNames) do
        if self.Train[v] then self.Triggers[v] = self.Train[v].Value > 0.5 end
    end
    self.State = 0
    self.State2 = 0
    self.Trains = {}
    self.Errors = {}
    self.Error = 0
    self.Counter = 0

    self.Password = ""

    self.Selected = 0

    self.Date = "0"
    self.Time = "0"
    self.RouteNumber = "0"
    self.WagNum = 0
    self.DepotCode = "0"
    self.DepeatStation = "0"
    self.Path = "0"
    self.Dir = "0"
    self.Deadlock = "0"
    self.BTB = false
    self.BRBK1 = true
    self.Loop = true

    self.Compressor = false

    self.BlockLeft = true
    self.BlockRight = true
    self.States = {}

    self.PVU = {}

    self.EnginesStrength = 0
    self.ControllerState = 0
end

function TRAIN_SYSTEM:Outputs()
    return {"State","ControllerState"}
end

function TRAIN_SYSTEM:Inputs()
    return {}
end
if TURBOSTROI then return end

function TRAIN_SYSTEM:TriggerInput(name,value)
end
if SERVER then
    function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
        if not self.Trains[-sourceid] then return end
        if textdata == "Get" then
            self.Reset = 1
        else
            self.Trains[-sourceid][textdata] = numdata
        end
    end
    function TRAIN_SYSTEM:CState(name,value,target,bypass)
        if self.Reset or self.States[name] ~= value or bypass then
            self.States[name] = value
            for i=1,self.WagNum do
                self.Train:CANWrite("BUKP",self.Train:GetWagonNumber(),target or "BUV",self.Trains[i],name,value)
            end
        end
    end

    function TRAIN_SYSTEM:CStateTarget(name,targetname,targetsys,targetid,value)
        if self.Reset or self.States[name] ~= value or bypass then
            self.States[name] = value
            self.Train:CANWrite("BUKP",self.Train:GetWagonNumber(),targetsys,targetid,targetname,value)
        end
    end

    TRAIN_SYSTEM.VityazPass = "1234"
    TRAIN_SYSTEM.Checks = {
        KAH=false,ALS=false,Ring=false,
        DoorSelectL=false,DoorSelectR=false,
        DoorBlock=false, DoorClose=false,AttentionMessage=false,Attention=false,AttentionBrake=false,
        DoorLeft=false, DoorRight=false,
        Pant1=false,Pant2=false,Vent1=false,Vent2=false,PassLight=false,
        TorecDoors=false,BBE=false,Compressor=false
    }

    function TRAIN_SYSTEM:Trigger(name,value)
        local Train = self.Train
        local char = name:gsub("Vityaz","");char = tonumber(char)
        if self.State == -3 then
            for k,v in pairs(self.TriggerNames) do
                if name == v then
                    Train:SetNW2Bool("VityazMNMM"..k,value)
                end
            end
        elseif self.State == 1 then
            if name == "VityazF5" and value then self.Password = self.Password:sub(1,-2) end
            if name == "VityazF8" and value then
                if self.Password == self.VityazPass then
                    self.State = 2
                    self.State2 = 0
                    self.Selected = 0
                else
                    self.Password = ""
                end
            end
            if char and #self.Password < 4 and value then self.Password = self.Password..char end
            Train:SetNW2String("VityazPass",self.Password)
        elseif self.State == 2 then
            if self.State2 == 0 then
                if self.Entering then
                    local num = (self.Selected==2 or self.Selected==3) and 4 or (self.Selected==8 or self.Selected==9) and 1 or self.Selected==6 and 3 or 2
                    if name == "VityazF8" and value and #self.Entering  == num then
                        if self.Selected == 2 then self.Date = self.Entering end
                        if self.Selected == 3 then self.Time = self.Entering end
                        if self.Selected == 4 then self.RouteNumber = self.Entering end
                        if self.Selected == 5 and tonumber(self.Entering) < 10 then self.WagNum = tonumber(self.Entering) end
                        if self.Selected == 6 then self.DepotCode = self.Entering end
                        if self.Selected == 7 then self.DepeatStation = self.Entering end
                        if self.Selected == 8 then self.Path = self.Entering end
                        if self.Selected == 9 then self.Dir = self.Entering end
                        if self.Selected == 10 then self.Deadlock = self.Entering end
                        self.Entering = false
                    end
                    if name == "VityazF9" and value then
                        self.Entering = false
                    end
                    if char and value then
                        if char and #self.Entering < num and value then
                            self.Entering = self.Entering..char
                        end
                    end
                    if name == "VityazF5" and value then self.Entering = self.Entering:sub(1,-2) end
                else
                    if name == "VityazF6" and value and self.Selected > 0 then
                        self.Selected = self.Selected - 1
                    end
                    if name == "VityazF7" and value and self.Selected < 10 then
                        self.Selected = self.Selected + 1
                    end
                    if name == "VityazF8" and value and self.WagNum > 0 then
                        self.State = 3
                        for i=1,self.WagNum do
                            Train:CANWrite("BUKP",Train:GetWagonNumber(),"BUV",self.Trains[i],"Orientate",i%2 > 0)
                        end
                    end
                    if name == "VityazF9" and value then
                        if self.Selected == 0 then self.State2 = 1 self.Selected = 0 end
                        if self.Selected == 1 then self.State2 = 2 self.Selected = 0 end
                        if self.Selected > 1 then self.Entering = "" end
                    end
                end
            elseif self.State2 == 1 then
                if name == "VityazF8" and value then
                    self.State2 = 0
                    self.Selected = 0
                end

            elseif self.State2 == 2 then
                if name == "VityazF8" and value then
                    if self.Entering and #self.Entering == 4 then
                        local wagnum = tonumber(self.Entering)
                        self.Trains[-wagnum] = {}
                        if not wagnum or wagnum == 0 then
                            self.Trains[-wagnum] = nil
                            wagnum = nil
                        end
                        self.Trains[self.Selected+1] = wagnum
                        self.Entering = false
                    elseif not self.Entering then
                        self.State2 = 0
                        self.Selected = 1
                    end
                end
                if name == "VityazF9" and value then
                    if self.Entering then
                            self.Entering = false
                    else
                        self.Entering = ""
                    end
                end
                if self.Entering then
                    if name == "VityazF5" and value then self.Entering = self.Entering:sub(1,-2) end
                    if char and #self.Entering < 4 and value then
                        self.Entering = self.Entering..char
                    end
                    Train:SetNW2String("VityazEnter",self.Entering)
                else
                    if name == "VityazF6" and value and self.Selected > 0 then
                        self.Selected = self.Selected - 1
                    end
                    if name == "VityazF7" and value and self.Selected < 8 then
                        self.Selected = self.Selected + 1
                    end
                end

            end
        elseif self.State == 3 and name == "VityazF8" and value then
            self.State = 2
        elseif self.State == 4 and name == "VityazF8" and value then
            self.State = 5
            self.Errors = {}
        elseif self.State == 5 and self.State2 == 0 and value then
            if name == "VityazF2" then self.State2 = 4 end
            if name == "Vityaz2" then self.State2 = 5 end
            if name == "VityazF6" then self.State2 = 1 end
            --[[ if (name == "VityazF1" or name == "VityazF9") and Train.VityazF9.Value*Train.VityazF1.Value > 0 then
                self.State2 = 6
                self.Selected = 1
            end--]]
            if name == "VityazF9" then
                self.State2 = 6
                self.Selected = 1
            end
            if name == "VityazF7" then
                self.State2 = 2
                self.Selected = 0
            end
            if name == "VityazF8" then
                self.State2 = 3
                self.Selected = 0
            end
        elseif self.State == 5 and self.State2 == 2 and value then
            if name == "VityazF6" and self.Selected > 0 then
                self.Selected = self.Selected - 1
            end
            if name == "VityazF7" and self.Selected < 3 then
                self.Selected = self.Selected + 1
            end
            if name == "VityazF9" then
                if self.Selected == 0 then self.State2 = 21 end
                if self.Selected == 1 then self.State2 = 22 end
                if self.Selected == 2 then self.State2 = 23 end
                if self.Selected == 3 then self.State2 = 24 end
            end
        elseif self.State == 5 and self.State2 == 3 and value then
            if name == "VityazF6" and self.Selected > 0 then
                self.Selected = self.Selected - 1
            end
            if name == "VityazF7" and self.Selected < 3 then
                self.Selected = self.Selected + 1
            end
        elseif self.State == 5 and self.State2 == 6 and value then
            local train = self.Trains[self.Selected]
            if not self.PVU[train] then self.PVU[train] = {} end
            if char then self.PVU[train][char] = not self.PVU[train][char] end
            if name == "VityazF6" and self.Selected > 1 then
                self.Selected = self.Selected - 1
            end
            if name == "VityazF7" and self.Selected < self.WagNum then
                self.Selected = self.Selected + 1
            end
        end
        if self.State == 5 and self.State2 > 0 and value then
            if name == "VityazF4" then
                self.State2 = 0
            end
        end
        if self.State == 5 and name == "AttentionMessage" and value then
            local currerr = 0
            for id,err in pairs(self.Errors) do
                if err and (currerr == 0 or id < currerr) then
                    currerr = id
                end
            end
            if (currerr == 10 or currerr > 11) and self.Errors[currerr] then
                self.Errors[currerr] = false
            end
        end
    end
    function TRAIN_SYSTEM:CheckError(id,cond)
        if cond then
            if self.Errors[id] ~= false then self.Errors[id] = CurTime() end
        elseif id < 12 and self.Errors[id] and self.Errors[id] ~= CurTime() or self.Errors[id] == false then
            self.Errors[id] = nil
        end
    end
    function TRAIN_SYSTEM:Think(dT)
        if self.State > 0 and self.Reset and self.Reset ~= 1 then self.Reset = false end
        local Train = self.Train
        local Panel = Train.Panel
        local Power = Train.BUV.Power > 0
        local VityazWork = Train.SF5.Value > 0 and Power
        if not VityazWork and self.State ~= (Power and -2 or 0) and (not Power or self.State ~= -3) then
            if self.State == 0 then
                self.State = -3
            else
                self.State = (Power and -2 or 0)
            end
            self.VityazTimer = nil
            self.Reset = nil
            self.Compressor = false
            self.Ring = false
            self.Error = 0
            self.ErrorRing = nil
        end
        if VityazWork and (self.State == 0 or self.State == -2 or Power and self.State == -3) then
            self.State = Power and -1 or -3
            self.VityazTimer = CurTime()
        end
        if self.State == -1 and CurTime()-self.VityazTimer > 1 then
            self.State = 1
            self.State2 = 0

            self.VityazTimer = false
            self.Counter = 0

            self.Password = ""
            Train:SetNW2String("VityazPass","")

            self.States = {}
            self.PVU = {}
            for k,v in ipairs(self.Trains) do
                if self.Trains[-v] then self.Trains[-v] = {} end
            end

            self.PTEnabled = nil
            self.HVBad = false
        end
        if self.State == -3 or self.State > 0 then
            for k,v in pairs(self.TriggerNames) do
                if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
                    self:Trigger(v,Train[v].Value > 0.5)
                    self.Triggers[v] = Train[v].Value > 0.5
                end
            end
            self.Counter = self.Counter + math.random(3,4)
            if self.Counter > 799 then
                self.Counter = 0
            end
            if Train.SF13.Value > 0 then Train:SetNW2Int("VityazCounter",self.Counter) end
        end
        if self.State > 0 then
            if self.State == 2 then
                Train:SetNW2String("VityazDate",self.Date)
                Train:SetNW2String("VityazTime",self.Time)
                Train:SetNW2String("VityazRouteNumber",self.RouteNumber)
                Train:SetNW2Int("VityazWagNum",self.WagNum)
                Train:SetNW2String("VityazDepotCode",self.DepotCode)
                Train:SetNW2String("VityazDepeatStation",self.DepeatStation)
                Train:SetNW2String("VityazPath",self.Path)
                Train:SetNW2String("VityazDir",self.Dir)
                Train:SetNW2String("VityazDeadlock",self.Deadlock)
                Train:SetNW2String("VityazEnter",self.Entering or "-")
            end
            if self.State == 3 then
                local initialized = true
                for i=1,self.WagNum do
                    local train = self.Trains[-self.Trains[i]]
                    if train then
                        if not train.WagNOrientated and train.BUVWork and not train.BadCombination then--and train.PTEnabled then
                            Train:SetNW2Bool("VityazWagI"..i,true)
                        else
                            Train:SetNW2Bool("VityazWagI"..i,false)
                            initialized = false
                        end
                    else
                        initialized = false
                    end
                end
                if initialized then
                    self.State = 4
                    local i = 1
                    for k,v in pairs(self.Checks) do
                        self.Checks[k] = false
                        Train:SetPackedBool("VityazBTest"..k,false)
                        i = i + 1
                    end
                    Train:SetNW2Int("VityazBTest",0)
                end
            end
            if self.State == 4 then
                local i = 1
                local num = 0
                for k,v in pairs(self.Checks) do
                    if Train[k].Value > 0 then
                        Train:SetNW2Bool("VityazBTest"..k,true)
                        self.Checks[k] = true
                    end
                    i = i + 1
                    if v then num = num + 1 end
                end
                Train:SetNW2Int("VityazBTest",num)
            end

            local stength = 0
            local EnginesStrength = 0
            local RV = (1-Train.RV["KRO5-6"]) + Train.RV["KRR15-16"] + (1-Train.SF2.Value)
            local doorLeft,doorRight,doorClose = false,false,false
            self.DoorClosed = false
            if self.State == 5 then
                local Back = false--Train:ReadTrainWire(4) > 0 and (Train.SF2.Value*(1-Train.RV["KRO5-6"]) or Train.SF3.Value*Train.RV["KRR15-16"]) > 0
                local err3,err4,err6,err7,err10,err11,err12,err17
                local HVBad = false
                for i=1,self.WagNum do
                    local train = self.Trains[-self.Trains[i]] or {}
                    if train.DriveStrength then EnginesStrength = EnginesStrength + train.DriveStrength end
                    if train.BrakeStrength then EnginesStrength = EnginesStrength + train.BrakeStrength end

                    if train.RV and self.Trains[i] ~= Train:GetWagonNumber() then
                        Back = true
                    end
                    if train.HVBad then HVBad = true end
                end
                if HVBad and not self.HVBad then self.HVBad = CurTime() end
                if not HVBad and self.HVBad then self.HVBad = false end
                self.SchemeEngaged = false
                if RV > 0 and not Back then
                    for i=1,self.WagNum do
                        Train:CANWrite("BUKP",Train:GetWagonNumber(),"BUV",self.Trains[i],"Orientate",i%2 > 0)
                    end
                    if self.Reset == nil then
                        self.Reset = true
                    end
                    --Door controls
                    if Train.BARS.Speed <= 0.1 and Train.Panel.DoorLeft > 0 then
                        doorLeft = true
                    end
                    if Train.BARS.Speed <= 0.1 and Train.Panel.DoorRight > 0 then
                        doorRight = true
                    end
                    if Panel.DoorClose > 0 then
                        doorClose = true
                    end
                    local min,max
                    self.DoorClosed = true
                    for i=1,self.WagNum do
                        local trainid = self.Trains[i]
                        local train = self.Trains[-trainid]
                        if train then
                            if not min or train.BCPressure < min then min = train.BCPressure end
                            if not max or train.BCPressure > max then max = train.BCPressure end
                        end
                        local doorclose = true
                        for i=1,8 do
                            if not train["Door"..i.."Closed"] then
                                doorclose = false
                                break
                            end
                        end
                        if not doorclose then
                            self.DoorClosed = false
                        end
                        err3 = err3 or not train.BUVWork
                        err4 = err4 or train.WagNOrientated
                        err6 = err6 or train.EmergencyBrake
                        err7 = err7 or train.ParkingBrakeEnabled
                        --err7 = err7 or train.WagNOrientated
                        err10 = err10 or train.PTEnabled
                        err11 = err11 or not doorclose
                        err12 = err12 or train.DoorBack and trainid ~= Train:GetWagonNumber()
                        err17 = err17 or not train.PassLightEnabled
                        --Errors
                        --self:CheckError(15,not train.MainLights)
                        --self:CheckError(16,not train.Vent1 or not Train)
                        Train:SetNW2Bool("VityazDoors"..i,doorclose)
                        Train:SetNW2Bool("VityazBV"..i,train.BVEnabled)
                        Train:SetNW2Bool("VityazScheme"..i,not train.NoAssembly)
                        self.SchemeEngaged = self.SchemeEngaged or not train.NoAssembly
                    end
                    local BARS = Train.BARS
                    self:CheckError(1,false)
                    self:CheckError(2,Train.SF2.Value == 0)
                    self:CheckError(3,err3)
                    self:CheckError(4,err4)
                    self:CheckError(5,BARS.DisableDrive or self.Errors[5] and Train.Panel.Controller > 0)
                    self:CheckError(6,err6)
                    self:CheckError(7,err7)
                    --self:CheckError(7,train.WagNOrientated)
                    self:CheckError(11,err11 or self.Errors[11] and Train.Panel.Controller > 0)
                    self:CheckError(12,err12)
                    self:CheckError(17,err17)
                    if Train.RV["KRO5-6"] == 0 then
                        if (BARS.Brake == 0 and BARS.Drive > 0 and (self.Error == 0 or self.Error >= 9 and self.Error ~= 11 or self.Error == 11 and Train.Panel.DoorBlock > 0)) or Train.Panel.Controller <= 0 then
                            stength = Train.Panel.Controller
                        end
                        if BARS.Brake > 0 then stength = -3 end
                    end
                    if err10 and stength > 0 and not self.PTEnabled then self.PTEnabled = CurTime() end
                    if (not err10 or stength <= 0) and self.PTEnabled then self.PTEnabled = nil end
                    self:CheckError(9,self.PTEnabled and CurTime()-self.PTEnabled > 1.5)
                    self:CheckError(10,self.HVBad and CurTime()-self.HVBad > 10)

                    Train:SetNW2Int("VityazType",stength ~= 0 and (stength < 0 and -1 or 1) or 0)
                    Train:SetNW2Int("VityazPMin",(min or 0)*10)
                    Train:SetNW2Int("VityazPMax",(max or 0)*10)
                    Train:SetNW2Int("VityazPNM",Train.Pneumatic.TrainLinePressure*10)
                    Train:SetNW2Int("VityazUbs",Train.Electric.Battery80V)
                    if self.State2  == 1 then
                        Train:SetNW2Int("VityazSpeed",Train.BARS.Speed)
                        Train:SetNW2Int("VityazSpeedLimit",Train.BARS.SpeedLimit)
                        if Train.BARS.BINoFreq > 0 then
                            Train:SetNW2Int("VityazSpeedLimitNext",-1)
                        else
                            Train:SetNW2Int("VityazSpeedLimitNext",Train.BARS.NextLimit)
                        end
                    elseif self.State2 == 21 then
                        for i=1,self.WagNum do
                            local train = self.Trains[-self.Trains[i]]
                            Train:SetNW2Int("VityazIMK"..i,train.MKVoltage*10)
                        end
                    elseif self.State2 == 22 then
                        for i=1,self.WagNum do
                            Train:SetNW2Int("VityazIVO"..i,self.Trains[-self.Trains[i]].VagEqConsumption*10)
                        end
                    elseif self.State2 == 23 then
                        for i=1,self.WagNum do
                            Train:SetNW2Int("VityazI13"..i,self.Trains[-self.Trains[i]].I13*10)
                        end
                    elseif self.State2 == 24 then
                        for i=1,self.WagNum do
                            Train:SetNW2Int("VityazI24"..i,self.Trains[-self.Trains[i]].I24*10)
                        end
                    elseif self.State2 == 3 then
                        if self.Selected == 0 then
                            for i=1,self.WagNum do
                                local train = self.Trains[-self.Trains[i]]
                                Train:SetNW2Bool("VityazBUVState"..i,train.BUVWork) --"БУВ"
                                Train:SetNW2Bool("VityazBTBReady"..i,train.BTBReady) --"БТБ ГОТ"
                                Train:SetNW2Bool("VityazPTGood"..i,train.PTEnabled) --"ПТ ЭФФ"
                                Train:SetNW2Bool("VityazEPTGood"..i,train.EmergencyBrakeGood) --"ЭТ ЭФФ"
                                Train:SetNW2Bool("VityazPTWork"..i,not train.PTBad) --"ТОРМ ОБ" !
                                Train:SetNW2Bool("VityazEmerActive"..i, not train.EmergencyBrake) --"ЭКС ТОРМ"
                                Train:SetNW2Bool("VityazEmPT"..i,not train.EmPT) --"ТОРМ РК"
                            end
                        elseif self.Selected == 1 then
                            for i=1,self.WagNum do
                                local train = self.Trains[-self.Trains[i]]
                                Train:SetNW2Bool("VityazPTApply"..i,not train.PTEnabled) --"ПТ ВКЛ"
                                Train:SetNW2Bool("VityazEDTBroken"..i,not train.EnginesBrakeBroke) --"ОТКАЗ ЭТ" FIXME
                                Train:SetNW2Bool("VityazEDTDone"..i,not train.EnginesDone) --"ИСТОЩ ЭТ" FIXME
                                Train:SetNW2Bool("VityazPBApply"..i,not train.ParkingBrakeEnabled) --"СТ ТОРМ"
                                --Train:SetNW2Bool("VityazEKKGood"..i,) --"МежВаг С"
                                Train:SetNW2Bool("VityazBBEProtection"..i,not train.BBEBroken) --"ЗАЩ ББЭ"
                                Train:SetNW2Bool("VityazBBEEnabled"..i,train.BBEEnabled) --"ББЭ"
                            end
                        elseif self.Selected == 2 then
                            for i=1,self.WagNum do
                                local train = self.Trains[-self.Trains[i]]
                                Train:SetNW2Bool("VityazLVGood"..i,not train.LVBad) --"НАПР БС"
                                Train:SetNW2Bool("VityazMKWork"..i,train.MKWork) --"МК"
                                Train:SetNW2Bool("VityazBVEnabled"..i,train.BVEnabled) --"ЗАЩИТ ТП"
                                Train:SetNW2Bool("VityazTPEnabled"..i,true) --"ТЯГ ПРИВ" FIXME
                                Train:SetNW2Bool("VityazPantDisabled"..i,not train.PantDisabled) --"ТКПР ОТЖ"
                                Train:SetNW2Bool("VityazBadCombination"..i,not train.BadCombination) --"ЗАПР КОМ"
                                Train:SetNW2Bool("VityazLightsWork"..i,train.PassLightEnabled) --"ОСВ ВКЛ"
                            end
                        elseif self.Selected == 3 then
                            for i=1,self.WagNum do
                                local train = self.Trains[-self.Trains[i]]
                                Train:SetNW2Bool("VityazVent1Work"..i,train.Vent1Enabled) --"ВЕНТИЛ 1"
                                Train:SetNW2Bool("VityazVent2Work"..i,train.Vent2Enabled) --"ВЕНТИЛ 2"
                                Train:SetNW2Bool("VityazHVGood"..i,not train.HVBad) --"НАПР КС"
                                Train:SetNW2Bool("VityazDoorBlock"..i,not train.DoorTorec) --"ТОРЦ ДВ" FIXME
                            end
                        end
                    elseif self.State2 == 4 then
                        for i=1,self.WagNum do
                            local train = self.Trains[-self.Trains[i]]
                            Train:SetNW2Bool("VityazWagOr"..i,train.Orientation)
                        end
                    elseif self.State2 == 5 then
                        for i=1,self.WagNum do
                            local train = self.Trains[-self.Trains[i]]
                            local orientation = train.Orientation
                            Train:SetNW2Bool("VityazWagOr"..i,orientation)
                            for d=1,4 do
                                Train:SetNW2Bool("VityazDoor"..d.."L"..i,train["Door"..(orientation and d or 9-d).."Closed"])
                                Train:SetNW2Bool("VityazDoor"..d.."R"..i,train["Door"..(orientation and d+4 or 5-d).."Closed"])
                            end
                        end
                    elseif self.State2 == 6 then
                        local train = self.Trains[self.Selected]
                        for i=1,9 do Train:SetNW2Bool("VityazPVU"..i,self.PVU[train] and self.PVU[train][i]) end
                    end
                    if not self.Slope and Train.AccelRate.Value > 0 and Train.BARS.Speed <= 2 then self.Slope = true end
                    if self.Slope and (self.SchemeEngaged or Train.BARS.Speed > 2) then self.Slope = false end
                else
                    self.Reset = nil
                    self.Slope = false
                    self.State2 = 0
                    if self.PTEnabled then self.PTEnabled = nil end
                    self:CheckError(1,false)
                    self:CheckError(2,false)
                    self:CheckError(3,false)
                    self:CheckError(4,false)
                    self:CheckError(5,false)
                    self:CheckError(6,false)
                    self:CheckError(7,false)
                    self:CheckError(9,false)
                    self:CheckError(10,false)

                    --self:CheckError(7,train.WagNOrientated)
                    self:CheckError(11,false)
                    self:CheckError(12,false)
                    self:CheckError(17,false)
                    if self.Error then self.Errors[self.Error] = false end
                end
                local currerr = 0
                for id,err in pairs(self.Errors) do
                    if err and (currerr == 0 or id < currerr) then
                        currerr = id
                    end
                end
                if self.Error ~= currerr then
                    if currerr > 0 and currerr < 11 then self.ErrorRing = CurTime() end
                    self.Error = currerr
                end
                if self.ErrorRing and (currerr == 0 or currerr > 11) then self.ErrorRing = nil end
                Train:SetNW2Int("VityazError",currerr or 0)
                Train:SetNW2Int("VityazMainMsg",Back and RV>0 and 3 or Back and 2 or RV==0 and 1 or 0)
            end
            for i=1,9 do
                Train:SetNW2Int("VityazWagNum"..i,self.Trains[i] or 0)
            end
            self:CState("OpenLeft",doorLeft)
            self:CState("OpenRight",doorRight)
            self:CState("CloseDoors",doorClose)
            self:CState("Slope",self.Slope)
            if self.WagNum > 0 then
                self.EnginesStrength = EnginesStrength/self.WagNum
            else
                self.EnginesStrength = 0
            end
            self:CState("RV",RV*Train.SF2.Value > 0,"BUKP")
            self:CState("RVPB",(1-Train.RV["KRO5-6"])*Train.SF2.Value > 0)
            self:CState("Ring",Train.Ring.Value > 0,"BUKP")
            self.ControllerState = stength
            self:CState("DriveStrength",math.abs(stength))
            self:CState("Brake",stength < 0 and 1 or 0)
            self:CState("PN1",Train.BARS.PN1)
            self:CState("PN2",Train.BARS.PN2+(self.Slope and 1 or 0))
            for t=1,self.WagNum do
                local train = self.Trains[t]
                if train then
                    for i=1,9 do
                        self:CStateTarget("PVU"..train.."_"..i,"PVU"..i,"BUV",train,self.PVU[train] and self.PVU[train][i])
                    end
                end
            end
            local ring = false
            for i=1,self.WagNum do
                local train = self.Trains[-self.Trains[i]]
                if train and train.Ring then
                    ring = true
                end
            end
            self.Ring = Train.BARS.Ring > 0 or ring or self.ErrorRing and CurTime()-self.ErrorRing < 2 or self.Error > 11

            if Train.Compressor.Value > 0 then
                self.Compressor = Train.AK.Value > 0
            else
                self.Compressor = false
            end
            self:CState("TP1",Train.Pant1.Value > 0)
            self:CState("TP2",Train.Pant2.Value > 0)
            self:CState("Vent1",Train.Vent1.Value > 0)
            self:CState("Vent2",Train.Vent2.Value > 0)
            self:CState("PassLight",Train.PassLight.Value > 0)
            self:CState("ParkingBrake",Train.ParkingBrake.Value > 0)

            self:CState("DoorTorec",Train.TorecDoors.Value > 0)
            self:CState("BBE",Train.BBE.Value > 0)
            self:CState("BVOn",Train.Panel.Controller == 0 and Train.EnableBV.Value > 0)
            self:CState("BVOff",Train.DisableBV.Value > 0)

            self:CState("Ticker",Train.Ticker.Value > 0)
            self:CState("PassScheme",Train.PassScheme.Value > 0)
            self:CState("Compressor", self.Compressor)
        end
        self:CState("BUPWork",self.State > 0)
        Train:SetNW2Int("VityazSelected",self.Selected)
        Train:SetNW2Int("VityazState2",self.State2)
        Train:SetNW2Int("VityazState",Train.SF13.Value*self.State)
        if self.State > 0 and self.Reset and self.Reset == 1 then self.Reset = false end
    end
else
    local function createFont(name,font,size,weight,blur,scanlines,underline)
        surface.CreateFont("Metrostroi_"..name, {
            font = font,
            size = size,
            weight = weight or 400,
            blursize = blur or false,
            antialias = true,
            underline = underline,
            italic = false,
            strikeout = false,
            symbol = false,
            rotary = false,
            shadow = true,
            additive = false,
            outline = false,
            extended = true,
            scanlines = scanlines or false,
        })
    end
    function TRAIN_SYSTEM:DrawBox(x,y,w,h,col)
        self:PrintText(x,y,"╔",col)
        self:PrintText(x,y+h+1,"╚",col)
        self:PrintText(x+w+1,y,"╗",col)
        self:PrintText(x+w+1,y+h+1,"╝",col)
        for i=1,h do
            self:PrintText(x,y+i,"║",col)
            self:PrintText(x+w+1,y+i,"║",col)
        end
        for i=1,w do
            self:PrintText(x+i,y,"═",col)
            self:PrintText(x+i,y+h+1,"═",col)
        end
    end
    createFont("Vityaz","FreeSans",90,400,3,4,false)
    createFont("VityazB","FreeSans",70,400,3,4,true)

    function TRAIN_SYSTEM:ClientThink()
        if not self.Train:ShouldDrawPanel("Vityaz") then return end
        local state = self.Train:GetNW2Int("VityazState",0)
        local counter = self.Train:GetNW2Int("VityazCounter",0)
        if self.Counter ~= counter or (state <= 0 and state ~= -2) and self.State ~= state then
            self.Counter = counter
            if state ~= -2 then
                self.State = state
            end
            render.PushRenderTarget(self.Train.Vityaz,0,0,1024, 1024)
            render.Clear(0, 0, 0, 0)
            cam.Start2D()
                self:VityazMonitor(self.Train)
            cam.End2D()
            render.PopRenderTarget()
        end
    end
    function TRAIN_SYSTEM:PrintText(x,y,text,col)
        local str = {utf8.codepoint(text,1,-1)}
        for i=1,#str do
            local char = utf8.char(str[i])
            if char == "█" then
                draw.SimpleText(char,"Metrostroi_VityazB",(x+i)*40-8,y*58+30,col,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            else
                draw.SimpleText(char,"Metrostroi_Vityaz",(x+i)*40-8,y*58+30,col,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            end
        end
    end

    local VO = {
        "БУВ","BUVState",
        "БТБ ГОТ","BTBReady",
        "ПТ ЭФФ","PTGood",
        "ЭТ ЭФФ","EPTGood",
        "ТОРМ ОБ","PTWork",
        "ЭКС ТОРМ","EmerActive",
        "ТОРМ РК","EmPT",
        "ПТ ВКЛ","PTApply",
        "ОТКАЗ ЭТ","EDTBroken",
        "ИСТОЩ ЭТ","EDTDone",
        "СТ ТОРМ","PBApply",
        "МежВаг С","EKKGood",
        "ЗАЩ ББЭ","BBEProtection",
        "ББЭ","BBEEnabled",
        "НАПР БС","LVGood",
        "МК","MKWork",
        "ЗАЩИТ ТП","BVEnabled",
        "ТЯГ ПРИВ","TPEnabled",
        "ТКПР ОТЖ","PantDisabled",
        "ЗАПР КОМ","BadCombination",
        "ОСВ ВКЛ","LightsWork",
        "ВЕНТИЛ 1","Vent1Work",
        "ВЕНТИЛ 2","Vent2Work",
        "НАПР КС","HVGood",
        "ТОРЦ ДВ","DoorBlock",
    }
    local Errors = {
            "Сбой КМ",
            "Сбой РВ",
            "Неиспр. БУВ",
            "Вагон не ориент.",
            "Запрет ТР от БАРС",
            "Экстренный тормоз",
            "Стояночный тормоз",
            "Дверной проем",
            "Пневмотормоз вкл.",
            "Uкс не в норме",
            "ДВ не закрыты",--11
            "Открыта кабина ХВ",
            "Кузов не в норме",
            "Защита ББЭ",
            "Буксы не в норме",
            "Неисправность МК",
            "Освещение не вкл.",
            "СОВ неисправен",
    }
    local ErrorNums = {
        21,23,25,62,38,79,54,12,61,84,83,37,85,47,69,77,78,43,34
    }
    local red = Color(200,130,200)--Color(200,100,150)
    local green = Color(100*0.8,200*1.0,150*0.8)--Color(100,200,150)
    local blue = Color(120*0.7,200*0.7,210*1.2)--Color(120,200,210)
    local yellow = Color(100,200,200)--Color(200,200,130)
    function TRAIN_SYSTEM:VityazMonitor(Train)
        local state2 = Train:GetNW2Int("VityazState2",0)
        local wagnum = Train:GetNW2Int("VityazWagNum",0)
        local mainmsg = Train:GetNW2Int("VityazMainMsg",0)
        local sel = Train:GetNW2Int("VityazSelected",0)
        local err = Train:GetNW2Int("VityazError")
        if self.State ~= 0 then
            surface.SetDrawColor(16,29,38,180)
            surface.DrawRect(0,0,1024,1024)
        end
        if self.State == -3 then
            self:PrintText(6,0,"ТЕСТ ММНМ",yellow)
            for i=1,4 do
                self:PrintText(4,0+i*2,"█",Train:GetNW2Bool("VityazMNMM"..i) and green or red)
                self:PrintText(16,0+i*2,"█",Train:GetNW2Bool("VityazMNMM"..(i+15)) and green or red)
            end
            for i=0,11 do
                if i~=9 then
                    self:PrintText(8+i%3*2,2+math.floor(i/3)*2,"█",Train:GetNW2Bool("VityazMNMM"..(i<9 and i+5 or i+4)) and green or red)
                end
            end
        elseif self.State == 1 then
            self:PrintText(3,3,"Введите пароль",yellow)
            local pass = Train:GetNW2String("VityazPass","")
            self:PrintText(8,5,pass..string.rep("█",4-#pass),yellow)
        elseif self.State == 2 then
            local enter = Train:GetNW2String("VityazEnter","-")
            if enter == "-" then enter = false end
            if state2 == 0 and sel < 6 then
                --[[
                Train:GetNW2String("VityazDepotCode","")
                Train:GetNW2String("VityazDepeatStation","")
                Train:GetNW2String("VityazPath","")
                Train:GetNW2String("VityazDir","")
                Train:GetNW2String("VityazDeadlock","")]]
                self:PrintText(5,0,"Режим депо",yellow)
                self:PrintText(0,1,"1 Коды типов",yellow)
                    self:PrintText(10,2,"вагонов",yellow)
                    self:PrintText(18,2,">",yellow)
                self:PrintText(0,3,"2 Номер вагонов",yellow)
                    self:PrintText(7,4,"в составе",yellow)
                    self:PrintText(18,4,">",yellow)
                self:PrintText(0,5,"3 Дата",yellow)
                    if sel==2 and enter then self:PrintText(15,5,enter..string.rep("█",4-#enter),yellow) else self:PrintText(15,5,Format("%04d", Train:GetNW2String("VityazDate","0")),yellow) end
                self:PrintText(0,6,"4 Время выдачи",yellow)
                    self:PrintText(7,7,"состава",yellow)
                    if sel==3 and enter then self:PrintText(15,7,enter..string.rep("█",4-#enter),yellow) else self:PrintText(15,7,Format("%04d", Train:GetNW2String("VityazTime","0")),yellow) end
                self:PrintText(0,8,"5 Номер маршрута",yellow)
                    if sel==4 and enter then self:PrintText(17,8,enter..string.rep("█",2-#enter),yellow) else self:PrintText(17,8,Format("%02d", Train:GetNW2String("VityazRouteNumber","0")),yellow) end
                self:PrintText(0,9,"6 Число вагонов",yellow)
                    if sel==5 and enter then self:PrintText(17,9,enter..string.rep("█",2-#enter),yellow) else self:PrintText(17,9,Format("%02d", Train:GetNW2Int("VityazWagNum","0")),yellow) end

                if sel == 0 then self:PrintText(19,2,"<",yellow) end
                if sel == 1 then self:PrintText(19,4,"<",yellow) end
                if sel == 2 then self:PrintText(19,5,"<",yellow) end
                if sel == 3 then self:PrintText(19,7,"<",yellow) end
                if sel == 4 then self:PrintText(19,8,"<",yellow) end
                if sel == 5 then self:PrintText(19,9,"<",yellow) end
            elseif state2 == 0 then
                self:PrintText(5,0,"Режим депо",yellow)
                self:PrintText(0,1,"7 Диаметр бандажа",yellow)
                    self:PrintText(3,2,"КП",yellow)
                    self:PrintText(16,2,"860",yellow)
                self:PrintText(0,3,"8 Код депо",yellow)
                    if sel==6 and enter then self:PrintText(16,3,enter..string.rep("█",3-#enter),yellow) else self:PrintText(16,3,Format("%03d", Train:GetNW2String("VityazDepotCode","0")),yellow) end
                self:PrintText(0,4,"9 Номер станции",yellow)
                    self:PrintText(4,5,"отправления",yellow)
                    if sel==7 and enter then self:PrintText(17,5,enter..string.rep("█",2-#enter),yellow) else self:PrintText(17,5,Format("%02d", Train:GetNW2String("VityazDepeatStation","0")),yellow) end
                self:PrintText(0,6,"10 Номер пути",yellow)
                    if sel==8 and enter then self:PrintText(18,6,enter..string.rep("█",1-#enter),yellow) else self:PrintText(18,6,Format("%d", Train:GetNW2String("VityazPath","0")),yellow) end
                self:PrintText(0,7,"11 Направление",yellow)
                    self:PrintText(6,8,"движения",yellow)
                    if sel==9 and enter then self:PrintText(18,8,enter..string.rep("█",1-#enter),yellow) else self:PrintText(18,8,Format("%d", Train:GetNW2String("VityazDir","0")),yellow) end
                self:PrintText(0,9,"12 Номер тупика",yellow)
                    if sel==10 and enter then self:PrintText(17,9,enter..string.rep("█",2-#enter),yellow) else self:PrintText(17,9,Format("%02d", Train:GetNW2String("VityazDeadlock","0")),yellow) end

                if sel == 6 then self:PrintText(19,3,"<",yellow) end
                if sel == 7 then self:PrintText(19,5,"<",yellow) end
                if sel == 8 then self:PrintText(19,6,"<",yellow) end
                if sel == 9 then self:PrintText(19,8,"<",yellow) end
                if sel == 10 then self:PrintText(19,9,"<",yellow) end
            elseif state2 == 1 then
            elseif state2 == 2 then
                self:PrintText(3,0,"Номера вагонов",yellow)
                self:PrintText(1,1,"№  тип",yellow)
                    self:PrintText(9,1,"заводской №",yellow)
                for i=1,9 do
                    self:PrintText(1,1+i,tostring(i),yellow)
                    self:PrintText(5,1+i,"1",yellow)
                    if not enter or sel ~= i-1 then
                        self:PrintText(13,1+i,Format("%04d",Train:GetNW2Int("VityazWagNum"..i)),yellow)
                    end
                end
                if enter then
                    self:PrintText(13,2+sel,enter..string.rep("█",4-#enter),yellow)
                end
                self:PrintText(19,2+sel,"<",yellow)
            end
        elseif self.State == 3 then
            self:PrintText(2,3,"Неиндентифиц ваг",yellow)
            for i=1,wagnum do
                self:PrintText(5+i+(9-wagnum)/2,5,"█",Train:GetNW2Bool("VityazWagI"..i,false) and green or red)
            end
        elseif self.State == 4 then
            self:PrintText(4,0,"Основной  ПУ",yellow)
            self:PrintText(5,1,"█",Train:GetNW2Bool("VityazBTestKAH") and green or red)
                self:PrintText(7,1,"█",Train:GetNW2Bool("VityazBTestALS") and green or red)
                self:PrintText(11,1,"█",Train:GetNW2Bool("VityazBTestRing") and green or red)
            self:PrintText(2,2,"█",Train:GetNW2Bool("VityazBTestDoorSelectL") and green or red)
                self:PrintText(4,2,"█",Train:GetNW2Bool("VityazBTestDoorSelectR") and green or red)
            self:PrintText(3,3,"█",Train:GetNW2Bool("VityazBTestDoorBlock") and green or red)
                self:PrintText(10,3,"█",Train:GetNW2Bool("VityazBTestDoorClose") and green or red)
                self:PrintText(12,3,"█",Train:GetNW2Bool("VityazBTestAttentionMessage") and green or red)
                self:PrintText(14,3,"█",Train:GetNW2Bool("VityazBTestAttention") and green or red)
                self:PrintText(16,3,"█",Train:GetNW2Bool("VityazBTestAttentionBrake") and green or red)
            self:PrintText(2,4,"█",Train:GetNW2Bool("VityazBTestDoorLeft") and green or red)
                self:PrintText(17   ,4,"█",Train:GetNW2Bool("VityazBTestDoorRight") and green or red)
            self:PrintText(1,6,"Вспомогательный ПУ",yellow)
            self:PrintText(3,7,"█",Train:GetNW2Bool("VityazBTestPant1") and green or red)
                self:PrintText(5,7,"█",Train:GetNW2Bool("VityazBTestPant2") and green or red)
                self:PrintText(7,7,"█",Train:GetNW2Bool("VityazBTestVent1") and green or red)
                self:PrintText(9,7,"█",Train:GetNW2Bool("VityazBTestVent2") and green or red)
                self:PrintText(13,7,"█",Train:GetNW2Bool("VityazBTestPassLight") and green or red)
            self:PrintText(6,8,"█",Train:GetNW2Bool("VityazBTestTorecDoors") and green or red)
                self:PrintText(10,8,"█",Train:GetNW2Bool("VityazBTestBBE") and green or red)
                self:PrintText(12,8,"█",Train:GetNW2Bool("VityazBTestCompressor") and green or red)
            self:PrintText(1,10,"Исправных клавиш",yellow)
            self:PrintText(18,10,tostring(Train:GetNW2Int("VityazBTest")),yellow)
        elseif self.State == 5 and mainmsg > 0 then
            if mainmsg == 3 then
                self:PrintText(3,0,"ВКЛЮЧЕНЫ 2 РВ",yellow)
            elseif mainmsg == 2 then
                self:PrintText(3,0,"ХВОСТОВОЙ ПУ",yellow)
            else
                self:PrintText(4,0,"РВ ВЫКЛЮЧЕНЫ",yellow)
            end
        elseif self.State == 5 and state2 == 0 then
            self:PrintText(3,0,"РЕЖИМ",yellow)
                local typ = Train:GetNW2Int("VityazType",0)
                if typ == 1 then self:PrintText(9,0,"ХОД",blue)
                elseif typ == 0 then self:PrintText(9,0,"ВЫБЕГ",blue)
                elseif typ == -1 then self:PrintText(9,0,"ТОРМОЗ",blue) end
            self:PrintText(1,2,"№ вагона:",yellow)
                for i=1,wagnum do
                    self:PrintText(9+i,2,tostring(i),yellow)
                end
            self:PrintText(4,4,"Двери:",yellow)
                for i=1,wagnum do
                    self:PrintText(9+i,4,"█",Train:GetNW2Bool("VityazDoors"..i,false) and green or red)
                end
            self:PrintText(7,5,"БВ:",yellow)
                for i=1,wagnum do
                    self:PrintText(9+i,5,"█",Train:GetNW2Bool("VityazBV"..i,false) and green or red)
                end
            self:PrintText(2,6,"Сбор СХ:",yellow)
                for i=1,wagnum do
                    self:PrintText(9+i,6,"█",Train:GetNW2Bool("VityazScheme"..i,false) and green or red)
                end
            self:PrintText(1,8,"Pmin",yellow)
                self:PrintText(1,9,Format("%.1f",Train:GetNW2Int("VityazPMin",0)/10),blue)
            self:PrintText(6,8,"Pmax",yellow)
                self:PrintText(6,9,Format("%.1f",Train:GetNW2Int("VityazPMax",0)/10),blue)
            self:PrintText(11,8,"Pнм",yellow)
                self:PrintText(11,9,Format("%.1f",Train:GetNW2Int("VityazPNM",0)/10),blue)
            self:PrintText(16,8,"Uбс",yellow)
                self:PrintText(16,9,tostring(Train:GetNW2Int("VityazUbs",0)),blue)
            if err > 0 then
                self:PrintText(0,10,Errors[err],yellow)
            end
        elseif self.State == 5 and state2 == 1 then
            local speed   = Train:GetNW2Int("VityazSpeed",0)
            local speedL  = Train:GetNW2Int("VityazSpeedLimit",0)
            local speedLN = Train:GetNW2Int("VityazSpeedLimitNext",-1)
            self:PrintText(1,1,"СКОРОСТЬ",yellow)
            self:PrintText(1,3,"ФАКТИЧ",yellow)
            self:PrintText(1,5,"РЕКОМ",yellow)
            self:PrintText(1,7,"ДОПУСТ",yellow)
            for i=0,2 do self:PrintText(11,3+i*2,"КМ\\Ч",yellow) end
            self:PrintText(8,3,Format("%02d",speed),green)
            if speedLN == -1 and speedL < 20 then
                self:PrintText(8,5,"ОЧ",yellow)
                self:PrintText(8,7,"ОЧ",red)
            elseif speedLN == -1 and speedL >= 20 then
                self:PrintText(8,5,Format("%02d",0),yellow)
                self:PrintText(8,7,Format("%02d",speedL),red)
            else
                self:PrintText(8,5,Format("%02d",speedLN),yellow)
                self:PrintText(8,7,Format("%02d",speedL),red)
            end
        elseif self.State == 5 and state2 == 2 then
            self:PrintText(2,0,"ПОТРЕБЛЯЕМЫЙ ТОК",yellow)
            self:PrintText(1,2,"МОТОР",yellow)
                self:PrintText(3,3,"КОМПРЕССОРА",yellow)
            self:PrintText(1,4,"ВАГОННОГО",yellow)
                self:PrintText(3,5,"ОБОРУДОВАНИЯ",yellow)
            self:PrintText(1,6,"1-Й ГР ТЯГОВЫХ",yellow)
                self:PrintText(3,7,"ДВИГАТЕЛЕЙ",yellow)
            self:PrintText(1,8,"2-Й ГР ТЯГОВЫХ",yellow)
                self:PrintText(3,9,"ДВИГАТЕЛЕЙ",yellow)
            if sel == 0 then self:PrintText(16,3,"<",yellow) end
            if sel == 1 then self:PrintText(16,5,"<",yellow) end
            if sel == 2 then self:PrintText(16,7,"<",yellow) end
            if sel == 3 then self:PrintText(16,9,"<",yellow) end
        elseif self.State == 5 and state2 == 21 then
            self:PrintText(2,0,"ПОТРЕБЛЯЕМЫЙ ТОК",yellow)
            self:PrintText(1,1,"МОТОР",yellow)
                    self:PrintText(3,2,"КОМПРЕССОРА",yellow)
                    for i=1,wagnum do
                        self:PrintText(1,2+i,i.." ВАГОН",yellow)
                        self:PrintText(10   ,2+i,Format("%04.1f А",Train:GetNW2Int("VityazIMK"..i,0)/10),yellow)
                end
        elseif self.State == 5 and state2 == 22 then
            self:PrintText(2,0,"ПОТРЕБЛЯЕМЫЙ ТОК",yellow)
            self:PrintText(1,1,"ВАГОННОГО",yellow)
                self:PrintText(3,2,"ОБОРУДОВАНИЯ",yellow)
                for i=1,wagnum do
                        self:PrintText(1,2+i,i.." ВАГОН",yellow)
                        self:PrintText(10,  2+i,Format("% 4.1f А",Train:GetNW2Int("VityazIVO"..i,0)/10),yellow)
                end
        elseif self.State == 5 and state2 == 23 then
            self:PrintText(2,0,"ПОТРЕБЛЯЕМЫЙ ТОК",yellow)
            self:PrintText(1,1,"1-Й ГР ТЯГОВЫХ",yellow)
                self:PrintText(3,2,"ДВИГАТЕЛЕЙ",yellow)
                for i=1,wagnum do
                        self:PrintText(1,2+i,i.." ВАГОН",yellow)
                        self:PrintText(10   ,2+i,Format("% 4.1f А",Train:GetNW2Int("VityazI13"..i,0)/10),yellow)
                end
        elseif self.State == 5 and state2 == 24 then
            self:PrintText(2,0,"ПОТРЕБЛЯЕМЫЙ ТОК",yellow)
            self:PrintText(1,1,"2-Й ГР ТЯГОВЫХ",yellow)
                self:PrintText(3,2,"ДВИГАТЕЛЕЙ",yellow)
                for i=1,wagnum do
                        self:PrintText(1,2+i,i.." ВАГОН",yellow)
                        self:PrintText(10   ,2+i,Format("% 4.1f А",Train:GetNW2Int("VityazI24"..i,0)/10),yellow)
                end
        elseif self.State == 5 and state2 == 3 then
            self:PrintText(4    ,0,"СОСТОЯНИЕ ВО",yellow)
            self:PrintText(1,2,"№ вагона:",yellow)
            for i=1,wagnum do
                self:PrintText(9+i,2,tostring(i),yellow)
            end
            for i=0,6 do
                local text,var = VO[i*2+sel*14+1],VO[i*2+sel*14+2]
                if text then
                    self:PrintText(1,4+i,text,yellow)
                    for w=1,wagnum do
                        self:PrintText(9+w,4+i,"█",Train:GetNW2Bool("Vityaz"..var..w,false) and green or red)
                    end
                end
            end
        elseif self.State == 5 and state2 == 4 then
            self:PrintText(0,0,"НОМЕРА ВАГ В СОСТАВЕ",yellow)
            self:PrintText(1,2,"№",yellow)
            self:PrintText(4,2,"зав №",yellow)
            self:PrintText(11,2,"ориент",yellow)
            for i=1,wagnum do
                self:PrintText(1,2+i,tostring(i),yellow)
                self:PrintText(4,2+i,Format("%04d",Train:GetNW2Int("VityazWagNum"..i)),yellow)
                if Train:GetNW2Bool("VityazWagOr"..i) then
                    self:PrintText(11,2+i,"ОДИНАК",yellow)
                else
                    self:PrintText(11,2+i,"ПРОТИВОП",yellow)
                end
            end
        elseif self.State == 5 and state2 == 5 then
            self:PrintText(2,0,"СОСТОЯНИЕ ДВЕРЕЙ",yellow)
            self:PrintText(1,2,"№",yellow)
            self:PrintText(4,2,"ЛЕВЫЕ",yellow)
            self:PrintText(10,2,"ПРАВЫЕ",yellow)
            self:PrintText(18,2,"Ор",yellow)
            for i=1,wagnum do
                self:PrintText(1,2+i,tostring(i),yellow)
                for d=1,4 do
                    self:PrintText(3+d,2+i,"█",Train:GetNW2Bool("VityazDoor"..d.."L"..i,false) and green or red)
                    self:PrintText(11+d,2+i,"█",Train:GetNW2Bool("VityazDoor"..d.."R"..i,false) and green or red)
                end
                if Train:GetNW2Bool("VityazWagOr"..i) then
                    self:PrintText(18,2+i,"О",yellow)
                else
                    self:PrintText(18,2+i,"П",yellow)
                end
            end
        elseif self.State == 5 and state2 == 6 then
            self:PrintText(0,0,"ПО ВАГОННОЕ УПРАВЛ-Е",yellow)
            self:PrintText(2,1,"вагон",yellow)
                self:PrintText(10,1,"№",yellow)
                self:PrintText(14,1,tostring(sel),yellow)
            self:PrintText(0,2,"1 БВ",yellow)
                self:PrintText(14,2,Train:GetNW2Bool("VityazPVU1") and "ВЫКЛ" or "ВКЛ",yellow)
            self:PrintText(0,3,"2 ДВЕРИ",yellow)
                self:PrintText(14,3,Train:GetNW2Bool("VityazPVU2") and "БЛОК" or "НЕБЛ",yellow)
            self:PrintText(0,4,"3 КОМПРЕССОР",yellow)
                self:PrintText(14,4,Train:GetNW2Bool("VityazPVU3") and "ВЫКЛ" or "ВКЛ",yellow)
            self:PrintText(0,5,"4 ТОКОПР",yellow)
                self:PrintText(14,5,Train:GetNW2Bool("VityazPVU4") and "ОТЖ" or "ПРИЖ",yellow)
            self:PrintText(0,6,"5 ОСВЕЩ",yellow)
                self:PrintText(14,6,Train:GetNW2Bool("VityazPVU5") and "ВЫКЛ" or "ВКЛ",yellow)
            self:PrintText(0,7,"6 БЛОКИР Т/ДВ",yellow)
                self:PrintText(14,7,Train:GetNW2Bool("VityazPVU6") and "ВЫКЛ" or "ВКЛ",yellow)
            self:PrintText(0,8,"7 ВЕНТИЛ",yellow)
                self:PrintText(14,8,Train:GetNW2Bool("VityazPVU7") and "ВЫКЛ" or "ВКЛ",yellow)
            self:PrintText(0,9,"8 ББЭ",yellow)
                self:PrintText(14,9,Train:GetNW2Bool("VityazPVU8") and "ВЫКЛ" or "ВКЛ",yellow)
            self:PrintText(0,10,"9 ТЯГ ПРИВОД",yellow)
                self:PrintText(14,10,Train:GetNW2Bool("VityazPVU9") and "ВЫКЛ" or "ВКЛ",yellow)
        end
        if self.State > 0 then
            self:PrintText(0,11,Format("H%03d",self.Counter),red)
            if mainmsg > 0 then
                self:PrintText(5,11,Format("0000%02d",ErrorNums[mainmsg]),yellow)
            else
                self:PrintText(5,11,Format("0000%02d",err > 0 and ErrorNums[err+3] or 0),yellow)
            end
            self:PrintText(13,11,Format("%02d%02d%02d",self.State,state2,sel),yellow)
        end
    end
end

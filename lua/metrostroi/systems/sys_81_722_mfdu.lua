--------------------------------------------------------------------------------
-- 81-722 multifunctional display
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_722_MFDU")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.Power = 0

    self.RouteNumber = 0
    self.StationNumber = 0
    self.DriverNumber = 0

    self.CurTime = CurTime()

    self.State = 0
    self.MFDUL2State = 0
    self.MFDUL3State = 0
    self.MFDUL4State = 0
    self.Errors = {}
    self.ErrorTimers = {}
    self.Log = {}
end

function TRAIN_SYSTEM:Outputs()
    return {"Power"}
end

function TRAIN_SYSTEM:Inputs()
    return {}
end
if TURBOSTROI then return end

function TRAIN_SYSTEM:TriggerInput(name,value)
end
TRAIN_SYSTEM.ErrorNames = {
    [1] = {"сбой РВ",1},
    [2] = {"сбой КУ",1},
    [3] = {"Блокировка режима «Ход» системой БАРС",1}, --
    [4] = {"Двери не закрыты на %d вагоне",1}, --
    [5] = {"Двери не закрыты",1}, --
    --[5] = {"Не закрыта Х левая дверь на вагоне",1},
    --[6] = {"Не закрыта Х правая дверь на вагоне",1},
    [7] = {"Приведение в действие экстренного торможения на %d вагоне",1}, --
    [8] = {"Не отпущен пневматический тормоз на %d вагоне",1},
    [9] = {"Использование стояночного тормоза на %d вагоне",1},--
    --[10] = {"Перегрев букс на %d вагоне",1},
    [11] = {"Сработала охранная сигнализация",2},
    [12] = {"%d вагон не ориентирован",1},
    [13] = {"Обрыв петли безопасности",1},
    [14] = {"Низкое давление в напорной магистрали",2},
    [15] = {"Включи МК",3},
    [16] = {"Нет связи с хвостовым БУКП",2},
    [17] = {"Нет освещения на %d вагоне ",3},
    --[18] = {"Пожар в вагоне",1},
    --[19] = {"Срыв муфты на %d вагоне",1},
    --[20] = {"Неисправность в пневматическом подвешивании на вагоне",1},
    --[21] = {"Низкое напряжение бортсети на вагоне",2},
    [22] = {"Отказ 1 канала системы БАРС",1},
    [23] = {"Отказ 2 канала системы БАРС",1},
    --[24] = {"Отказ МК на %d вагоне",2},
    [25] = {"Отказ вентиляции на вагоне",3},
    --[26] = {"Нет связи с ПСН на вагоне",2},
    --[27] = {"Нет связи с БУТП на вагоне",2},
    --[28] = {"Нет связи с АДУТ на %d вагоне",2},
    [29] = {"Открыта торцевая дверь на %d вагоне",3},
    --[30] = {"Отключение БВ на %d вагоне",2},
    --[31] = {"нет связи с СРПИ",3},
    [32] = {"нет связи с СБУЦИК",3},
    --[33] = {"Отказ инвертора на вагоне",2},
    --[34] = {"Срабатывание защиты инвертора на вагоне",2},
    --[35] = {"Перегрев инвертора на %d вагоне",2},
    --[36] = {"Нет синхронизации времени с СРПИ",3},
    [37] = {"Нет связи с БУВ %d вагона",1},
    [38] = {"Активны 2 кабины",1},
    [39] = {"Тормоз удержания от БАРС",3},
    [40] = {"Выбран режим «Движение без контроля дверей»",3},
    [41] = {"Разгон в режиме «Движение без контроля дверей»",3},
    [42] = {"Токоприемники на %d вагоне отключены",3},
    [43] = {"Экстренное торможение БАРС",1},
    --[44] = {"Нет связи с КПД",1},
    --[45] = {"нет связи с УПИ-2",1},
    --[46] = {"нет связи с БТБУ",1},
    --[47] = {"Не открывается Х левая дверь на %d вагоне",2},
    --[48] = {"Не открывается Х правая дверь на %d вагоне",2},
    [49] = {"Открытие левых дверей на хвостовом вагоне",3},
    --[50] = {"Отказ системы внутреннего видеонаблюдения на вагоне",3},
    --[51] = {"Вызов связи «Пассажир-Машинист» на вагоне",3},
    --[52] = {"Неисправность ключей КПД",1},
    [53] = {"Срабатывание замещения электротормоза на %d вагоне",3},
    [54] = {"Недопустимый ввод в эксплуатацию кабины хвостового вагона",1},
    [55] = {"Отсутствие напряжения контактного рельса на всех вагонах",1},
    [56] = {"Не открываются левые двери на %d вагоне",2},
    [57] = {"Не открываются правые двери на %d вагоне",2},
    [58] = {"Не выбрано направление движения",2},
    [59] = {"Выбрано направление движения «Назад»",3},
    [60] = {"Освещение салона выключено",3},
    [61] = {"Не выполнены все условия открытия дверей",2},
    --[62] = {"Неверная идентификация машиниста",1},
    [63] = {"Падение давления в тормозной магистрали на %d вагоне",2},
    [64] = {"Нет контроля дверей",1},
    [65] = {"Неполный состав",1},
}
if SERVER then
    function TRAIN_SYSTEM:ErrorRemove(ID,full)
        local err = self.Errors[ID]
        if err then
            if err[2] then
                table.remove(self.Errors,err[2])
                err[2] = nil
                for k,v in ipairs(self.Errors) do self.Errors[v][2] = k end
                --print(Format("Removed conf message with ErrID '%s'",ID))
            end
            if full then
                --print(Format("Removed message with ErrID '%s'",ID))
                self.Errors[ID] = nil
            end
        end
    end
    function TRAIN_SYSTEM:ErrorsReset()
        if not self.ErrorsCleaned then
            self.Errors = {}
            self.ErrorsCleaned = true
        end
    end
    function TRAIN_SYSTEM:ErrorCount()
        local errors = 0
        for i,err in pairs(self.Errors) do
            if type(i) == "string" and not err[5] then errors = errors + 1 end
        end
        return errors
    end
    function TRAIN_SYSTEM:ErrorGet(ID)
        if not ID then return false end
        local err = self.Errors[ID]
        if not err then return false end
        local logerr = self.Log[err[1]]
        if not logerr then return false end
        return logerr
    end
    function TRAIN_SYSTEM:Error(ErrID,WagID,status,time)
        local ID = ErrID.."_"..WagID
        local err = self.Errors[ID]
        if not err and status and time and (not self.ErrorTimers[ID] or CurTime()-self.ErrorTimers[ID]<0) then
            if not self.ErrorTimers[ID] then self.ErrorTimers[ID]=CurTime()+time end
            return
        elseif time then self.ErrorTimers[ID] = nil end

        if not err and status then
            if time then self.ErrorTimers[ID] = nil end
            self.ErrorsCleaned = false
            local logID = table.insert(self.Log,{ErrID,WagID,Metrostroi.GetSyncTime()})
            local index
            for i,v in ipairs(self.Errors) do
                local ErrIDT = self.Log[self.Errors[v][1]][1]
                if (not index or i<index) and self.ErrorNames[ErrIDT][2] > self.ErrorNames[ErrID][2] then
                    index = i
                end
            end
            if index then
                self.Errors[ID] = {logID,table.insert(self.Errors,index,ID)}
            else
                self.Errors[ID] = {logID,table.insert(self.Errors,ID)}
            end
            for k,v in ipairs(self.Errors) do self.Errors[v][2] = k end
            --print(Format("Message with ErrID '%s' have ID:%d",ID,logID))
        elseif err and not status then
            local logerr = self.Log[err[1]]
            if not logerr[5] then logerr[5] = true end
            if logerr[4] then
                self:ErrorRemove(ID,true)
            end
        end
    end
    function TRAIN_SYSTEM:ErrorConfirm(ID)
        local err = self.Errors[ID]
        local logerr = err and self.Log[err[1]]
        if logerr and (not logerr[4] or self.Errors[err[2]]) then
            --print(Format("Confirmed message with ErrID '%s' have ID:%d",ID,err[2]))
            self:ErrorRemove(ID)
            logerr[4] = Metrostroi.GetSyncTime()
        end
    end

    function TRAIN_SYSTEM:Touch(value,x,y)
        local Train = self.Train
        if self.State <= 0 or Train.BUKP.Back>0 or math.random() < 0.06 and value then return end
        local Active = Train.Electric.CabActive>0
        local lineSel = 0
        if self.MFDUL2State == 0 then --Мы на основном экране
            for i=2,Active and 9 or 2 do
                local px,py = 1+(i-1)*80,537
                if px < x and x < px+78 and py < y and y < py+62 and i~=6 then
                    if not value then --FIXME
                        self.MFDUL2State = i

                        if i==2 then --Номер маршрута и т.д
                            self.RouteN = self.RouteNumber
                            self.StationN = self.StationNumber
                            self.DriverN = self.DriverNumber
                            self.Selected = 0
                            self.NewActive = false
                        end
                        if i==3 then self.Selected = 0 self.LogSelected = 0 end
                        if i==4 or i==5 or i>=7 then --Пневмосистема
                            self.Selected = 0
                            self.Page = 0
                        end
                        x = 0
                        y = 0
                        selected = i
                    else
                        lineSel = i
                    end
                end
            end
            --отбитие ошибок
            if self.Errors[1] and 84 < x and x < 84+601 and 60 < y and y < 60+319 and value then
                self:ErrorConfirm(self.Errors[1])
            end
        end
        if self.MFDUL2State == 2 then --Номер маршрута и т.д
            local br = false
            for i=0,9 do
                local px,py = 416 + ((i-1)%3)*115,124+90*(math.ceil(i/3)-1)
                if i==0 then px,py=531,394 end
                if px < x and x < px+88 and py < y and y < py+73 then --Ввод циферок с тача
                    if not value then
                        if self.Selected == 1 and (not self.RouteN or self.RouteN < 99) then self.RouteN = tonumber((self.RouteN or "")..i) end
                        if self.Selected == 2 and (not self.StationN or self.StationN < 99) then self.StationN = tonumber((self.StationN or "")..i) end
                        if self.Selected == 3 and (not self.DriverN or self.DriverN < 9999) then self.DriverN = tonumber((self.DriverN or "")..i) end
                    else
                        lineSel = 11+i
                    end
                end
            end
            --Выбираем окошко и сбрасываем ввод
            if Active and 141 < x and x < 141+148 and 151 < y and y < 151+38 and self.Selected == 0 and not self.NewActive then
                self.Selected = 1
                self.RouteN = false
            end
            if Active and 141 < x and x < 141+148 and 257 < y and y < 257+38 and self.Selected == 0 and not self.NewActive then
                self.Selected = 2
                self.StationN = false
            end
            if Active and 98 < x and x < 98+248 and 363 < y and y < 363+38 and self.Selected == 0 and not self.NewActive then
                self.Selected = 3
                self.DriverN = false
            end
            if 98 < x and x < 98+248 and 438 < y and y < 438+86 then --А это у нас подтверждение кабины
                self.NewActive = true
            end
            --Сброс значения обратно
            if 721 < x and x < 721+78 and 537 < y and y < 537+62 then
                if value then
                    lineSel = 1
                elseif (self.Selected > 0 or self.NewActive) then
                    if self.Selected == 1 then self.RouteN = self.RouteNumber end
                    if self.Selected == 2 then self.StationN = self.StationNumber end
                    if self.Selected == 3 then self.DriverN = self.DriverNumber end
                    self.Selected = 0
                    self.NewActive = false
                    --br = true
                end
            end
            --Подтверждение значения
            if 561 < x and x < 561+78 and 537 < y and y < 537+62 then
                if value then
                    lineSel = 2
                else
                    if self.Selected == 1 then self.RouteN = self.RouteN or self.RouteNumber        self.RouteNumber = self.RouteN
                    elseif self.Selected == 2 then self.StationN = self.StationN or self.StationNumber  self.StationNumber = self.StationN
                    elseif self.Selected == 3 then self.DriverN = self.DriverN or self.DriverNumber     self.DriverNumber = self.DriverN end
                    if self.NewActive then
                        if Train.BUKP.Prepared == true then
                            Train.BUKP.Active = 1-Train.BUKP.Active
                        end
                    end
                    self.Selected = 0
                    self.NewActive = false
                    if Train.BUKP.Active==0 then self.MFDUL2State = 0 end
                end
            end
            if 391 < x and x < 391+78 and 537 < y and y < 537+62 then
                if value then
                    lineSel = 3
                elseif (self.Selected > 0 or self.NewActive) then
                    if self.Selected == 1 then self.RouteN = false end
                    if self.Selected == 2 then self.StationN = false end
                    if self.Selected == 3 then self.DriverN = false end
                    if self.NewActive then self.NewActive = false end
                end
            end
            Train:SetNW2Int("MFDUERouteNumber",self.RouteN or -1)
            Train:SetNW2Int("MFDUEStationNumber",self.StationN or -1)
            Train:SetNW2Int("MFDUEDriverNumber",self.DriverN or -1)
            Train:SetNW2Int("MFDUSelected",self.Selected)
            --if br then return end --Хак для блока кнопки Обратно
        end
        if self.MFDUL2State == 3 then
            for i=0,6 do
                if 1+80*i < x and x < 1+80*i+78 and 537 < y and y < 537+62 then
                    if value and i~=4 then
                        lineSel = i+1
                        if i<2 then
                            self.LogSelected = i==0 and 0 or (self.Selected==1 and self:ErrorCount() or #self.Log)-1
                        elseif i==2 then
                            self.LogSelected = math.max(self.LogSelected-1,0)
                        elseif i==3 then
                            self.LogSelected = math.min(self.LogSelected+1,(self.Selected==1 and self:ErrorCount() or #self.Log)-1)
                        end
                    else
                        if i>=5 then
                            self.Selected = i-5
                            self.LogSelected = 0
                        end
                    end
                end
            end
            Train:SetNW2Int("MFDUSelected",self.Selected)
        end
        if (self.MFDUL2State == 4 or self.MFDUL2State == 8 or self.MFDUL2State == 9) then --Номер маршрута и т.д
            local max = self.MFDUL2State == 8 and 4 or 2
            for i=0,max do
                if 1+80*i < x and x < 1+80*i+78 and 537 < y and y < 537+62 then
                    if value then
                        lineSel = i+1
                    else
                        self.Selected = i
                    end
                end
            end
            Train:SetNW2Int("MFDUSelected",self.Selected)
        end
        if self.MFDUL2State == 5 and value then
            local BUKP = Train.BUKP
            for i=1,#BUKP.Trains do
                if i>6+self.Page then break end
                local i = i-self.Page-1
                local pvu = BUKP.PVU[i+1]

                if 13+i*131 < x and x < 130+i*131 and 110+61*0 < y and y < 160+61*0 then
                    pvu[1] = not pvu[1]
                end
                if 13+i*131 < x and x < 130+i*131 and 110+61*1 < y and y < 160+61*1 then
                    pvu[2] = not pvu[2]
                end
                if BUKP.Trains[i+1].Type < 2 then
                    if 13+i*131 < x and x < 130+i*131 and 110+61*2 < y and y < 160+61*2 then
                        pvu[3] = not pvu[3]
                    end
                    if 13+i*131 < x and x < 130+i*131 and 110+61*3 < y and y < 160+61*3 then
                        pvu[4] = not pvu[4]
                    end
                    --[[ if 13+i*131 < x and x < 130+i*131 and 110+61*4 < y and y < 160+61*4 then
                        pvu[5] = not pvu[5]
                    end--]]
                    if 13+i*131 < x and x < 130+i*131 and 110+61*5 < y and y < 160+61*5 then
                        pvu[6] = not pvu[6]
                    end
                    if 13+i*131 < x and x < 130+i*131 and 110+61*6 < y and y < 160+61*6 then
                        pvu[7] = not pvu[7]
                    end
                end
            end
        end
        if (self.MFDUL2State == 4 or self.MFDUL2State == 5 or self.MFDUL2State == 7 or self.MFDUL2State == 8 or self.MFDUL2State == 9) then
            if 561 < x and x < 561+78 and 537 < y and y < 537+62 then
                if value then
                    lineSel=8
                else
                    self.Page = math.max(self.Page - 1,0)
                end
            end
            if 641 < x and x < 641+78 and 537 < y and y < 537+62 then
                if value then
                    lineSel=9
                else
                    self.Page = math.max(0,math.min(self.Page + 1,#Train.BUKP.Trains-6))
                end
            end
            Train:SetNW2Int("MFDUPage",self.Page)
        end
        local back = 721 < x and x < 721+78 and 537 < y and y < 537+62
        if self.MFDUL4State > 0 and back then
            if value then lineSel = 10 else self.MFDUL4State = 0 end
        elseif self.MFDUL3State > 0 and back then
            if value then lineSel = 10 else self.MFDUL3State = 0 end
        elseif self.MFDUL2State > 0 and back then
            if value then lineSel = 10 else self.MFDUL2State = 0 end
        end
        Train:SetNW2Int("MFDULineSel",lineSel)
    end

    function TRAIN_SYSTEM:Think(dT)
        local Train = self.Train
        local BUKP = Train.BUKP
        self.Power = Train.SF20.Value*Train.Electric.Power

        local Power = self.Power>0
        if not Power and self.State ~= 0 then
            self.State = 0
            self.MFDUTimer = nil
        end
        if Power and self.State == 0 then
            self.State = -1
            self.MFDUTimer = CurTime()-math.Rand(-0.5,1)
        end

        if self.State == -1 and self.MFDUTimer and CurTime()-self.MFDUTimer > 7 then
            self.State = -2
            self.MFDUTimer = CurTime()-math.Rand(-0.5,1)
        end
        if self.State == -2 then
            if self.MFDUTimer and CurTime()-self.MFDUTimer > 4 then
                self.State = -3
                self.MFDUTimer = CurTime()-math.Rand(-0.3,0.5)
                self.Windows95 = math.random() >= 0.98
                Train:SetNW2Bool("MFDUWin95Egg",self.Windows95)
            end
        end
        if self.State == -3 and self.Windows95 and self.MFDUTimer and CurTime()-self.MFDUTimer > 6 then
            self.State = -4
            self.MFDUTimer = CurTime()-math.Rand(-0.3,0.5)
        end
        if self.State == -3 and not self.Windows95 and self.MFDUTimer and CurTime()-self.MFDUTimer > 3 or self.State == -4 and self.Windows95 and self.MFDUTimer and CurTime()-self.MFDUTimer > 0.5 then
            self.State = 1
            self.MFDUL2State = 0
            self.MFDUL3State = 0
            self.MFDUL4State = 0
        end

        local Active = Train.Electric.CabActive>0
        local trains = BUKP.Trains
        if self.State > 0 then
            if (BUKP.Power == 0 or Train.Electric.Emer > 0) and not self.BUKPTimeout then self.BUKPTimeout = CurTime()-Train.Electric.Emer*2 end
            if BUKP.Power > 0 and Train.Electric.Emer == 0 and self.BUKPTimeout then self.BUKPTimeout = false end

            if Active and BUKP.Power then
                if BUKP.States.Brake then
                    Train:SetPackedRatio("MFDUPowerCommand",-BUKP.States.DriveStrength or 0)
                else
                    Train:SetPackedRatio("MFDUPowerCommand",BUKP.States.DriveStrength or 0)
                end
                Train:SetNW2Bool("MFDUARSBrake",BUKP.Braking)
                Train:SetNW2Int("MFDUSpeed",BUKP.Speed)
                Train:SetNW2Bool("MFDUBARSActive",Train.Panel.ARSPower>0)

                if self.MFDUL2State == 0 then
                    local BARS = Train.BARS
                    Train:SetNW2Int("MFDUSpeedLimit",BARS.F1>0 and 80 or BARS.F2>0 and 70 or BARS.F3>0 and 60 or BARS.F4>0 and 40 or BARS.F5>0 and 0 or -1)
                    Train:SetNW2Bool("MFDUALSActive",Train.Panel.ARSPower>0)

                end
            elseif not Active then
                if self.MFDUL2State > 2 then
                    self.MFDUL2State = 0
                end
                Train:SetPackedRatio("MFDUPowerCommand",0)
                Train:SetNW2Int("MFDUSpeed",0)
                self.MFDUL3State = 0
                self.MFDUL4State = 0
            end
        end
        if self.State==-10 then
            Train:SetNW2Int("MFDUSpeed",BUKP.Speed)
        end
        Train:SetNW2Int("MFDUState",self.State)
        if self.BUKPTimeout and CurTime()-self.BUKPTimeout > 0.2 then
            if self.State == -10 and BUKP.Power > 0 and Train.Electric.Emer==0 then
                self.State = 1
            elseif self.State > 0  then
                self.State = -10
                self.MFDUL2State = 0
                self.MFDUL3State = 0
                self.MFDUL4State = 0
            end
            Train:SetPackedBool("MFDUEmer",Train.Electric.Emer>0)
            self.BUKPTimeout = CurTime()
        end
        if CurTime()-self.CurTime < 0.1 then return end
        self.CurTime = CurTime()
        if self.State > 0 --[[ and #trains>0 --]] then
            Train:SetNW2Int("MFDUDriverNumber",self.DriverNumber)
            if self.MFDUL2State == 2 then
                Train:SetPackedBool("MFDUNewActive",self.NewActive)
            end

            if Active and BUKP.Power then
                for i,train in ipairs(trains) do
                    Train:SetNW2Int("MFDUWagNum"..i,train.ID)
                    Train:SetNW2Bool("MFDUWagHead"..i,train.Type==0)
                    Train:SetNW2Bool("MFDUWagTyp"..i,train.Type<=1)
                end

                if self.MFDUL2State == 0 then
                    Train:SetNW2Int("MFDUL2TL1",(trains[1].TLPressure or 0)*10)
                    Train:SetNW2Int("MFDUL2BL1",(trains[1].BLPressure or 0)*10)
                    local hv = 0
                    for i,train in ipairs(trains) do
                        if train.HVVoltage and train.HVVoltage > hv then
                            hv = train.HVVoltage
                        end
                        if train.HVVoltage then
                            Train:SetNW2Int("MFDUTrainErr"..i,not train.BUKVWork and 1 or train.PVU6 and 4 or train.AsyncFail and 2 or (BUKP.Speed>0.1 and train.NoHV) and 3 or train.NoAssembly==true and 6 or 0)
                        else
                            Train:SetNW2Int("MFDUTrainErr"..i,not train.BUKVWork and 1 or 0)
                        end
                    end
                    Train:SetNW2Int("MFDUTrainVoltage",hv)
                    local errors = self:ErrorCount()
                    Train:SetNW2Int("MFDUErrors",errors)
                    local err = self:ErrorGet(self.Errors[1])
                    Train:SetNW2Int("MFDUError",err and err[1] or 0)
                    Train:SetNW2Int("MFDUErrorWag",err and err[2] or 0)
                    Train:SetNW2Int("MFDUErrorTime",err and err[3] or 0)
                elseif self.MFDUL2State == 3 then
                    local errors = self:ErrorCount()
                    Train:SetNW2Int("MFDUErrorsA",#self.Log)
                    Train:SetNW2Int("MFDUErrorsB",errors)
                    local cerr = 1
                    if self.Selected == 0 then
                        for i=#self.Log-self.LogSelected,1,-1 do
                            local err = self.Log[i]
                            if err then
                                Train:SetNW2Int("MFDUErrorType"..cerr,err[1])
                                Train:SetNW2Int("MFDUErrorWag"..cerr,err[2])
                                Train:SetNW2Int("MFDUErrorTime"..cerr,err[3])
                                if cerr==1 then
                                    Train:SetNW2Bool("MFDUErrorSolved",err[5])
                                    Train:SetNW2Int("MFDUErrorConfirmT",err[4] or -1)
                                end
                                cerr = cerr+1
                            end
                            if cerr>18 then break end
                        end
                    else
                        local selskip = 0
                        for i=#self.Log,1,-1 do
                            local err = self.Log[i]
                            if err and not err[5] then
                                if selskip>=self.LogSelected  then
                                    Train:SetNW2Int("MFDUErrorType"..cerr,err[1])
                                    Train:SetNW2Int("MFDUErrorWag"..cerr,err[2])
                                    Train:SetNW2Int("MFDUErrorTime"..cerr,err[3])
                                    if cerr==1 then
                                        Train:SetNW2Bool("MFDUErrorSolved",err[5])
                                        Train:SetNW2Int("MFDUErrorConfirmT",err[4] or -1)
                                    end
                                    cerr = cerr+1
                                end
                                selskip = selskip+1
                            end
                            if cerr>18 then break end
                        end
                    end
                    Train:SetNW2Int("MFDULogSelected",self.LogSelected)
                    Train:SetNW2Int("MFDUErrorCount",math.min(18,(self.Selected==0 and #self.Log or errors)-self.LogSelected))
                elseif self.MFDUL2State == 4 then
                    if self.Selected == 0 then
                        for i,train in ipairs(trains) do
                            Train:SetNW2Int("MFDUL2BC"..i,train.BCPressure*10)
                        end
                        Train:SetNW2Int("MFDUL2TL1",trains[1].TLPressure*10)
                        Train:SetNW2Int("MFDUL2TL"..#trains,trains[#trains].TLPressure*10)
                    else
                        for i,train in ipairs(trains) do
                            Train:SetNW2Int("MFDUL2TL"..i,train.TLPressure*10)
                            Train:SetNW2Int("MFDUL2SK"..i,train.SKPressure*10)
                            Train:SetNW2Int("MFDUL2PB"..i,train.PBPressure*10)
                            Train:SetNW2Int("MFDUL2BL"..i,train.BLPressure*10)
                        end
                    end
                elseif self.MFDUL2State == 5 then
                    for i,train in ipairs(trains) do
                        for p=1,train.Type<2 and 7 or 2 do
                            Train:SetPackedBool("MFDUDPVUC"..i.."_"..p,BUKP.PVU[i][p])
                            Train:SetPackedBool("MFDUDPVUB"..i.."_"..p,train["PVU"..p])
                        end
                    end
                elseif self.MFDUL2State == 7 then
                    for i,train in ipairs(trains) do
                        if train.Orientation then
                            if train.Type==0 then
                                Train:SetPackedBool("MFDUDCabL"..i,train.TLeft)
                                Train:SetPackedBool("MFDUDCabR"..i,train.TRight)
                            end
                            Train:SetPackedBool("MFDUDF"..i,train.TFront)
                            Train:SetPackedBool("MFDUDB"..i,train.TRear)
                            for i2=0,3 do
                                Train:SetPackedBool("MFDUDL"..i2.."_"..i,not train["Door"..(i2+1).."Closed"])
                                Train:SetPackedBool("MFDUDR"..i2.."_"..i,not train["Door"..(i2+5).."Closed"])
                            end
                        else
                            if train.Type==0 then
                                Train:SetPackedBool("MFDUDCabL"..i,train.TRight)
                                Train:SetPackedBool("MFDUDCabR"..i,train.TLeft)
                            end
                            Train:SetPackedBool("MFDUDF"..i,train.TRear)
                            Train:SetPackedBool("MFDUDB"..i,train.TFront)
                            for i2=0,3 do
                                Train:SetPackedBool("MFDUDL"..i2.."_"..i,not train["Door"..(8-i2).."Closed"])
                                Train:SetPackedBool("MFDUDR"..i2.."_"..i,not train["Door"..(4-i2).."Closed"])
                            end
                        end
                    end
                elseif self.MFDUL2State == 8 then
                    if self.Selected == 0 then
                        for i,train in ipairs(trains) do
                            Train:SetPackedBool("MFDUPassLights"..i,train.LightsEnabled)
                            if train.DTorque then
                                Train:SetPackedBool("MFDUPSN"..i,train.PSNWork)
                                Train:SetPackedBool("MFDUMK"..i,train.MKWork)
                                Train:SetPackedBool("MFDUTP"..i,not train.PantDisabled)
                            end
                        end
                    elseif self.Selected == 2 then
                        for i,train in ipairs(trains) do
                            Train:SetPackedBool("MFDUDPBD1"..i,not train.DPBD1)
                        end
                    elseif self.Selected == 3 then
                        for i,train in ipairs(trains) do
                            Train:SetPackedBool("MFDUVentEnabled1"..i,train.Vent1Enabled)
                            Train:SetPackedBool("MFDUVentEnabled2"..i,train.Vent2Enabled)
                        end
                    end
                elseif self.MFDUL2State == 9 then
                    if self.Selected == 0 then
                        for i,train in ipairs(trains) do
                            if train.DTorque then
                                Train:SetNW2Int("MFDUTHD"..i,train.DTorque*10)
                                Train:SetNW2Int("MFDUTHB"..i,train.BTorque*10)
                                Train:SetNW2Int("MFDUTA"..i,train.Current*10)
                            end
                        end
                    else
                        for i,train in ipairs(trains) do
                            Train:SetPackedBool("MFDUScheme"..i,train.AsyncAssembly)
                            Train:SetPackedBool("MFDUInv"..i,not train.AsyncFail)
                            Train:SetPackedBool("MFDUAProt"..i,train.AsyncProtection)
                            Train:SetPackedBool("MFDUBadT"..i,train.AsyncEFail)
                            Train:SetPackedBool("MFDUBV"..i,train.BVState)
                            Train:SetPackedBool("MFDUKS"..i,not train.NoHV)
                        end
                    end
                end
            end

            --ErrorConfirm
            Train:SetNW2Bool("MFDUIdent",BUKP.Prepared ~= true or not Active)
            Train:SetPackedBool("MFDUActive",Active)
            Train:SetPackedBool("MFDUBackCab",BUKP.Back>0)

            Train:SetPackedBool("MFDUTrainSD",BUKP.LSD)
            Train:SetPackedBool("MFDUEmer",false)

            Train:SetNW2Int("MFDUL2State",self.MFDUL2State)
            Train:SetNW2Int("MFDUWagNum",#trains)
        end
    end
else
    local function createFont(name,font,size,weight)
        surface.CreateFont("Metrostroi_"..name, {
            font = font,
            size = size,
            weight = weight or 400,
            blursize = 0,
            antialias = true,
            underline = false,
            italic = false,
            strikeout = false,
            symbol = false,
            rotary = false,
            shadow = false,
            additive = false,
            outline = false,
            extended = true,
        })
    end
    createFont("BUKPSpeed","Eurostar Metrostroi",80)
    createFont("Calibri80","Calibri",80)
    createFont("Calibri40","Calibri",40)
    createFont("Calibri40B","Calibri",40,800)
    createFont("Calibri60","Calibri",60)
    createFont("Calibri30","Calibri",30)
    createFont("Calibri35","Calibri",35)
    createFont("Calibri25","Calibri",25,400)
    createFont("Calibri26","Calibri",26,800)
    createFont("Calibri23l","Calibri",23,400)
    createFont("Calibri23","Calibri",23,800)
    createFont("FixedSys35","FixedsysTTF",35)
    createFont("722LastStation","soviet font",59,800)
    local kontron_logo = surface.GetTextureID("models/metrostroi_train/81-722/screens/kontron_logo")

    local win95_splash = surface.GetTextureID("models/metrostroi_train/81-722/screens/windows95_splash")
    local windows95_load = surface.GetTextureID("models/metrostroi_train/81-722/screens/windows95_load")

    local emer_drive = surface.GetTextureID("models/metrostroi_train/81-722/screens/emer_drive")
    local comm_err = surface.GetTextureID("models/metrostroi_train/81-722/screens/commerr")
    local main_screen = surface.GetTextureID("models/metrostroi_train/81-722/screens/main_screen")

    local route_num = surface.GetTextureID("models/metrostroi_train/81-722/screens/route_num")

    local failures = surface.GetTextureID("models/metrostroi_train/81-722/screens/failures")

    local pneumo_system = surface.GetTextureID("models/metrostroi_train/81-722/screens/pneumo_system")
    local pneumo_system2 = surface.GetTextureID("models/metrostroi_train/81-722/screens/pneumo_system2")
    local pneumo_arrow = surface.GetTextureID("models/metrostroi_train/81-722/screens/pneumo_arrow")

    local pvu = surface.GetTextureID("models/metrostroi_train/81-722/screens/pvu")

    local common = surface.GetTextureID("models/metrostroi_train/81-722/screens/common")

    local diag = surface.GetTextureID("models/metrostroi_train/81-722/screens/diag")
    local ver = surface.GetTextureID("models/metrostroi_train/81-722/screens/ver")
    local amp = surface.GetTextureID("models/metrostroi_train/81-722/screens/amp")
    local volt = surface.GetTextureID("models/metrostroi_train/81-722/screens/volt")

    local doors = surface.GetTextureID("models/metrostroi_train/81-722/screens/doors")

    local vo = surface.GetTextureID("models/metrostroi_train/81-722/screens/vo")

    local tp1 = surface.GetTextureID("models/metrostroi_train/81-722/screens/tp2")
    local tp2 = surface.GetTextureID("models/metrostroi_train/81-722/screens/tp1")

    local box = surface.GetTextureID("models/metrostroi_train/81-722/screens/box")
    function TRAIN_SYSTEM:ClientThink(dT)
        if not self.Train:ShouldDrawPanel("Vityaz") then return end
        render.PushRenderTarget(self.Train.Vityaz,0,0,1024, 1024)
        if self.PrepareLoad then
            render.Clear(0, 0, 0, 0)
        end
        cam.Start2D()
            if self.Train:GetNW2Int("MFDUState",0) ~= -1 then
                surface.SetDrawColor(0,0,0)
                surface.DrawRect(0,0,800,600)
                self.PrepareLoad = true
            elseif self.PrepareLoad then
                surface.SetDrawColor(200,200,200)
                surface.DrawRect(1,0,799,600)
                self.PrepareLoad = false
            end
            self:BUKPMonitor(self.Train,dT)
        cam.End2D()
        render.PopRenderTarget()
    end
    local buttons = {
        "Настр.\nэкрана",
        "№ марш.\nстан.\nмаш.",
        "Отказы\n(%d)",
        "Пнев.\nсистема",
        "ПВУ",
        "Диагн",
        "Двери",
        "Вагон.\nоборуд.",
        "Тяговый\nпривод.",
        --"Теневой"
    }
    for i=1,#buttons do
        local x = {}
        for w in string.gmatch(buttons[i],"([^\n]+)") do
            table.insert(x,w)
        end
        buttons[i] = x
    end

    local mainerrs = {
        "K НЕТ",
        "П НЕТ",
        "U НЕТ",
        "П ОТКЛ",
        "УПР",
        true,
    }
    for i,str in ipairs(mainerrs) do
        if str~=true and str:find(" ") then
            mainerrs[i] = string.Explode(" ",mainerrs[i])
        end
    end

    local errorstates = {
        {"А",Color(255,0,0)},
        {"Б",Color(255,255,0)},
        {"В",Color(0,255,255)},
    }

    function TRAIN_SYSTEM:ClientInitialize()
        self.PowerCommand = 0
        self.PowerCommandSmooth = 0
    end

    local function drawButton(i,text,state,format,color)
        if state then
            if color then
                surface.SetDrawColor(color)
            else
                surface.SetDrawColor(0,220,0)
            end
        else
            surface.SetDrawColor(38,38,38)
        end
        surface.DrawRect(1+i*80,538,78,61)
        Metrostroi.DrawRectOutline(1+i*80,538,78,61,Color(129,129,129),1)
        if type(text)=="table" then
            if #text > 1 then
                for i1=1,#text do
                    local h = 40/(#text-#text%2)
                    draw.SimpleText(format and Format(text[i1],format) or text[i1],"Metrostroi_Calibri23",40+i*80,568-h+h*(i1-1)+(#text == 2 and h/2 or 0), state and Color(32,32,32) or Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                end
            else
                draw.SimpleText(format and Format(text[1],format) or text[1],"Metrostroi_Calibri23",40+i*80,568, state and Color(32,32,32) or Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            end
        else
            draw.SimpleText(format and Format(text,format) or text,"Metrostroi_Calibri23",40+i*80,568, state and Color(32,32,32) or Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
    end
    function TRAIN_SYSTEM:BUKPMonitor(Train,dT)
        local state = Train:GetNW2Int("MFDUState",0)
        local state2 = Train:GetNW2Int("MFDUL2State",0)
        local state3 = Train:GetNW2Int("MFDUL3State",0)
        local state4 = Train:GetNW2Int("MFDUL4State",0)
        local help = Train:GetPackedBool("MFDUHelp")
        local Active = Train:GetPackedBool("MFDUActive")
        local Back = Train:GetPackedBool("MFDUBackCab")
        local WagNum = Train:GetNW2Int("MFDUWagNum",0)
        if state == -1 then
            surface.SetDrawColor(255,0,0)
            surface.DrawRect(200,0,1,600)
            surface.SetDrawColor(0,0,20,15)
            surface.DrawRect(201,0,599,600)
        elseif state == -2 then
                surface.SetTexture(kontron_logo)
                surface.SetDrawColor(255,255,255)
                surface.DrawTexturedRectRotated(238,122,296,64,0)

                draw.SimpleText("Version 2.13.1215. Copyright (c) 2011 American Megatrends Inc.","Metrostroi_Calibri26",80, 196,Color(123,123,123),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText("Kontron version NTC1R111, 01/31/2012 10:47:49","Metrostroi_Calibri26",80, 216,Color(123,123,123),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText("Press <Del> or <F2> to enter Setup. <F7> for Boot menu","Metrostroi_Calibri26",80, 236,Color(123,123,123),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        elseif state == -3 and Train:GetPackedBool("MFDUWin95Egg") then
                render.SetScissorRect(2, 0, 800, 600, true)
                surface.SetTexture(win95_splash)
                surface.SetDrawColor(180,180,180)
                surface.DrawTexturedRectRotated(512,512,1024,1024,0)
                surface.SetTexture(windows95_load)
                surface.SetDrawColor(180,180,180)
                surface.DrawTexturedRectRotated(800+(RealTime()%4*200-400),591,800,14,0)
                surface.DrawTexturedRectRotated(800+(RealTime()%4*200-400)-800,591,800,14,0)
                render.SetScissorRect( 0, 0, 0, 0, false )
        elseif state == -10 then
            if Train:GetPackedBool("MFDUEmer") then
                surface.SetDrawColor(255,255,255)
                surface.SetTexture(emer_drive)
                surface.DrawTexturedRectRotated(512,512,1024,1024,0)
                draw.SimpleText(math.floor(Train:GetNW2Int("MFDUSpeed",0)),"Metrostroi_BUKPSpeed",400, 303,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText(os.date("!%H:%M:%S",Metrostroi.GetSyncTime()),"Metrostroi_Calibri35",400, 485,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            else
                surface.SetDrawColor(255,255,255)
                surface.SetTexture(comm_err)
                surface.DrawTexturedRectRotated(512,512,1024,1024,0)
            end
        elseif state == 1 then
            local PCmd = Train:GetPackedRatio("MFDUPowerCommand",0)
            local lineSel = Train:GetNW2Int("MFDULineSel")
            local dPCmd = math.abs(PCmd-self.PowerCommand)/0.8
            if dPCmd > 0.14 then
                self.PowerCommand = PCmd
            elseif self.PowerCommand < PCmd then
                self.PowerCommand = math.min(self.PowerCommand+dT*0.8,PCmd)
            elseif self.PowerCommand > PCmd then
                self.PowerCommand = math.max(self.PowerCommand-dT*0.8,PCmd)
            end
            if self.PowerCommandSmooth < PCmd and dPCmd > 0.14 and PCmd <= 0 then
                self.PowerCommandSmooth = PCmd
            else
                self.PowerCommandSmooth = self.PowerCommandSmooth+(self.PowerCommand-self.PowerCommandSmooth)*dT*20
            end
            if state2 == 0 then
                if Back then
                    draw.SimpleText("Задняя кабина","Metrostroi_Calibri35",400, 22,Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                else
                    draw.SimpleText("Основной экран","Metrostroi_Calibri35",400, 22,Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                end

                if Active then
                    if Train:GetNW2Bool("MFDUALSActive") then
                        local speedLimit = Train:GetNW2Int("MFDUSpeedLimit",-1)
                        if speedLimit == -1 then
                            draw.SimpleText("НЧ","Metrostroi_Calibri60",180, 80,Color(220,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                            draw.SimpleText("БАРС","Metrostroi_Calibri30",180, 110,Color(220,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        elseif speedLimit >= 0 then
                            local color = Color(speedLimit < 60 and 255 or 0,speedLimit > 20 and 255 or 0,0)
                            draw.SimpleText(speedLimit,"Metrostroi_Calibri60",180, 80,color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                            draw.SimpleText("БАРС","Metrostroi_Calibri30",180, 110,color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        end
                    end

                    local err = Train:GetNW2Int("MFDUError",0)
                    local errtbl = self.ErrorNames[err]
                    if err > 0 and errtbl then
                        local stbl = errorstates[errtbl[2]]
                        Metrostroi.DrawRectOutline(84,60,601,319,stbl[2],8  )
                        draw.SimpleText(stbl[1],"Metrostroi_Calibri60",687-30,57+40, Color(127,127,127),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        draw.SimpleText(Format(errtbl[1],Train:GetNW2Int("MFDUErrorWag")),"Metrostroi_Calibri30",384,300, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        draw.SimpleText(os.date("!%H:%M:%S",Train:GetNW2Int("MFDUErrorTime",0)),"Metrostroi_Calibri35",630, 92,Color(255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
                    else
                        draw.SimpleText(os.date("!%H:%M:%S",Metrostroi.GetSyncTime()),"Metrostroi_Calibri30",384, 352,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    end
                    if Train:GetNW2Bool("MFDUBARSActive") then
                        draw.SimpleText(math.floor(Train:GetNW2Int("MFDUSpeed",0)),"Metrostroi_BUKPSpeed",384, 220,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        draw.SimpleText("км/ч","Metrostroi_Calibri30",384, 260,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    else
                        draw.SimpleText(math.floor(Train:GetNW2Int("MFDUSpeed",0)),"Metrostroi_BUKPSpeed",384, 220,Color(255,255,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        draw.SimpleText("км/ч","Metrostroi_Calibri30",384, 260,Color(255,255,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    end

                else
                    if Back then
                        draw.SimpleText(os.date("!%H:%M:%S",Metrostroi.GetSyncTime()),"Metrostroi_Calibri30",384, 352,Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        draw.SimpleText(math.floor(Train:GetNW2Int("MFDUSpeed",0)),"Metrostroi_BUKPSpeed",384, 220,Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        draw.SimpleText("км/ч","Metrostroi_Calibri30",384, 260,Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    else
                        draw.SimpleText(os.date("!%H:%M:%S",Metrostroi.GetSyncTime()),"Metrostroi_Calibri40",384, 220,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    end
                end

                --draw.SimpleText(math.floor(Train:GetPackedRatio("FREQ",99)),"Metrostroi_BUKPSpeed",384, 150,Color(220,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                surface.SetDrawColor(38,38,38)
                surface.DrawRect(24,476,751,34)
                if Active and -0.01 > self.PowerCommandSmooth or self.PowerCommandSmooth > 0.01 then
                    surface.SetDrawColor(self.PowerCommandSmooth < 0 and 255 or 0,Train:GetNW2Bool("MFDUARSBrake",false) and 0 or 255,0)
                    surface.DrawRect(400,477,math.Clamp(self.PowerCommandSmooth*377,-375,375),32)
                end

                for i=1,WagNum>6 and 8 or 6 do
                    i = i-1
                    local w = WagNum > 6 and 40 or 52
                    Metrostroi.DrawRectOutline(9,57+i*(w+3),62,w,Color(129,129,129),1)
                    if Active then
                        local err = Train:GetNW2Int("MFDUTrainErr"..(i+1),0)
                        if err > 0 and mainerrs[err] then
                            local err = mainerrs[err]

                            if err==true then
                                surface.SetDrawColor(220,220,0)
                                surface.DrawRect(10,58+i*(w+3),59,(w-3))
                                draw.SimpleText(i+1,"Metrostroi_Calibri60",40,56+w/2+i*(w+3), Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                            elseif type(err) == "table" then
                                surface.SetDrawColor(220,0,0)
                                surface.DrawRect(10,58+i*(w+3),59,(w-3))
                                draw.SimpleText(err[1],"Metrostroi_Calibri26",40,56+w/2+i*(w+3)-11, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                                draw.SimpleText(err[2],"Metrostroi_Calibri26",40,56+w/2+i*(w+3)+11, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                            else
                                surface.SetDrawColor(220,0,0)
                                surface.DrawRect(10,58+i*(w+3),59,(w-3))
                                draw.SimpleText(err,"Metrostroi_Calibri26",40,56+w/2+i*(w+3), Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                            end
                        elseif i<WagNum then
                            surface.SetDrawColor(0,220,0)
                            surface.DrawRect(10,58+i*(w+3),59,(w-3))
                            draw.SimpleText(i+1,"Metrostroi_Calibri60",40,56+w/2+i*(w+3), Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        else
                            surface.SetDrawColor(38,38,38)
                            surface.DrawRect(10,58+i*(w+3),59,(w-3))
                        end

                    elseif i<WagNum then
                        surface.SetDrawColor(38,38,38)
                        surface.DrawRect(10,58+i*(w+3),59,(w-3))
                        draw.SimpleText(i+1,"Metrostroi_Calibri60",40,56+w/2+i*(w+3), Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    else
                        surface.SetDrawColor(38,38,38)
                        surface.DrawRect(10,58+i*(w+3),59,(w-3))
                    end
                end

                if not Back then
                    for i=0,8 do
                        surface.SetDrawColor(38,38,38)
                        surface.DrawRect(1+i*80,538,78,61)
                        Metrostroi.DrawRectOutline(1+i*80,538,78,61,Color(129,129,129),1)
                        if i==2 then
                            drawButton(i,buttons[i+1],lineSel==(i+1),Train:GetNW2Int("MFDUErrors",0),Color(0,255,255))
                        else
                            drawButton(i,buttons[i+1],lineSel==(i+1),nil,Color(0,255,255))
                        end
                    end
                end

                surface.SetDrawColor(255,255,255)
                surface.SetTexture(main_screen)
                surface.DrawTexturedRectRotated(512,512,1024,1024,0)

                if Active then
                    local voltage = Train:GetNW2Int("MFDUTrainVoltage",0)
                    if 550 <= voltage and voltage <= 975 then
                        surface.SetDrawColor(0,220,0)
                    else
                        surface.SetDrawColor(220,0,0)
                    end
                    surface.DrawRect(698,58,92,71)
                    draw.SimpleText("Напряж.","Metrostroi_Calibri26",744,93.50-23, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("К.Р.","Metrostroi_Calibri26",744,93.50, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText(Format("%d В",voltage),"Metrostroi_Calibri26",744,93.50+23, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                    if Train:GetNW2Bool("MFDUTrainSD") then
                        surface.SetDrawColor(200,200,200)
                    else
                        surface.SetDrawColor(220,0,0)
                    end
                    surface.DrawRect(698,141,92,71)
                    draw.SimpleText("Контроль","Metrostroi_Calibri26",744,176.50-11, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("дверей","Metrostroi_Calibri26",744,176.50+11, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                    local NMPress = Train:GetNW2Int("MFDUL2TL1",0)/10
                    if 6.4 <= NMPress and NMPress <= 8.1 then
                        surface.SetDrawColor(0,220,0)
                    else
                        surface.SetDrawColor(220,0,0)
                    end
                    surface.DrawRect(698,224,92,71)
                    draw.SimpleText("Давл. НМ.","Metrostroi_Calibri26",744,259.50-23, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText(Format("%.1f",NMPress),"Metrostroi_Calibri26",744,259.50, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("кгс/см²","Metrostroi_Calibri26",744,259.50+23, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                    local TMPress = Train:GetNW2Int("MFDUL2BL1",0)/10
                    if 2.8 <= TMPress and TMPress <= 5.4 then
                        surface.SetDrawColor(0,220,0)
                    else
                        surface.SetDrawColor(220,0,0)
                    end
                    surface.DrawRect(698,307,92,71)
                    draw.SimpleText("Давл. ТМ.","Metrostroi_Calibri26",744,342.50-23, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText(Format("%.1f",TMPress),"Metrostroi_Calibri26",744,342.50, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("кгс/см²","Metrostroi_Calibri26",744,342.50+23, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                else
                    draw.SimpleText("Напряж.","Metrostroi_Calibri26",744,93.50-23, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("К.Р.","Metrostroi_Calibri26",744,93.50, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("0 В","Metrostroi_Calibri26",744,93.50+23, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                    draw.SimpleText("Контроль","Metrostroi_Calibri26",744,176.50-11, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("дверей","Metrostroi_Calibri26",744,176.50+11, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                    draw.SimpleText("Давл. НМ.","Metrostroi_Calibri26",744,259.50-23, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("0.0","Metrostroi_Calibri26",744,259.50, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("кгс/см²","Metrostroi_Calibri26",744,259.50+23, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                    draw.SimpleText("Давл. ТМ.","Metrostroi_Calibri26",744,342.50-23, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("0.0","Metrostroi_Calibri26",744,342.50, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("кгс/см²","Metrostroi_Calibri26",744,342.50+23, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                end
            elseif state2 == 2 then
                local routen = Train:GetNW2Int("MFDUERouteNumber",-1)
                local stnum = Train:GetNW2Int("MFDUEStationNumber",-1)
                local drvnum = Train:GetNW2Int("MFDUEDriverNumber",-1)
                local sel = Train:GetNW2Int("MFDUSelected",0)
                local newAct = Train:GetNW2Bool("MFDUNewActive")
                surface.SetDrawColor(0,255,255)
                if sel == 3 then
                    surface.DrawRect(98,151+(sel-1)*106,248,38)
                elseif sel > 0 then
                    surface.DrawRect(148,151+(sel-1)*106,148,38)
                end
                if Active then
                    draw.SimpleText("№ МАРШРУТА","Metrostroi_Calibri35",220,136, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    Metrostroi.DrawRectOutline(148,151,148,38,Color(129,129,129),2)
                    if sel == 1 then
                        if routen > -1 then draw.SimpleText(Format("%d",routen),"Metrostroi_Calibri35",222,169, sel == 1 and Color(0,0,0) or Color(0,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end
                    else
                        draw.SimpleText(Format("%03d",routen),"Metrostroi_Calibri35",222,169, sel == 1 and Color(0,0,0) or Color(0,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    end
                    draw.SimpleText("№ СТАНЦИИ","Metrostroi_Calibri35",220,237, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    Metrostroi.DrawRectOutline(148,257,148,38,Color(129,129,129),2)
                    if sel == 2 then
                        if stnum > -1 then draw.SimpleText(Format("%d",stnum),"Metrostroi_Calibri35",222,275, sel == 2 and Color(0,0,0) or Color(0,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end
                    else
                        draw.SimpleText(Format("%03d",stnum),"Metrostroi_Calibri35",222,275, sel == 2 and Color(0,0,0) or Color(0,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    end
                    draw.SimpleText("№ МАШИНИСТА","Metrostroi_Calibri35",220,342, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    Metrostroi.DrawRectOutline(98,363,248,38,Color(129,129,129),2)
                    if sel == 3 then
                        if drvnum > -1 then draw.SimpleText(Format("%d",drvnum),"Metrostroi_Calibri35",222,381, sel == 3 and Color(0,0,0) or Color(0,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end
                    else
                        draw.SimpleText(Format("%010d",drvnum),"Metrostroi_Calibri35",222,381, sel == 3 and Color(0,0,0) or Color(0,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    end
                end
                surface.SetDrawColor(255,255,255)
                surface.SetTexture(route_num)
                surface.DrawTexturedRectRotated(512,512,1024,1024,0)

                if newAct then
                    surface.SetDrawColor(0,255,255)
                    surface.DrawRect(98,438,248,86)
                end
                for i=0,9 do
                    local px,py = 416 + ((i-1)%3)*115,124+90*(math.ceil(i/3)-1)
                    if i==0 then px,py=531,394 end
                    if lineSel == (i+11) then
                        surface.SetDrawColor(0,255,255)
                        surface.DrawRect(px+3,py+3,82,67)
                        draw.SimpleText(i,"Metrostroi_Calibri60",px+88/2,py+72/2, Color(32,32,32),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    else
                        draw.SimpleText(i,"Metrostroi_Calibri60",px+88/2,py+72/2, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    end
                end
                draw.SimpleText(Active and "ДЕАКТИВИРОВАТЬ" or "АКТИВИРОВАТЬ","Metrostroi_Calibri35",222,481-16, newAct and Color(0,0,0) or Color(128,128,128),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText("КАБИНУ","Metrostroi_Calibri35",222,481+16, newAct and Color(0,0,0) or Color(128,128,128),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                if lineSel == 3 then
                    surface.SetDrawColor(0,255,255)
                    surface.DrawRect(391,539,76,59)
                elseif lineSel == 2 then
                    surface.SetDrawColor(0,255,255)
                    surface.DrawRect(561,539,76,59)
                end


                draw.SimpleText("Исправ.","Metrostroi_Calibri23",30+5*80,568, lineSel==3 and Color(32,32,32) or Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                draw.SimpleText("ОК","Metrostroi_Calibri23",40+7*80,568, lineSel==2 and Color(32,32,32) or Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText("Помощь","Metrostroi_Calibri23",40+8*80,568, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            elseif state2 == 3 then
                local sel = Train:GetNW2Int("MFDUSelected",0)
                surface.SetDrawColor(127,127,127)
                surface.DrawRect(2,76,796,22,0)

                surface.SetDrawColor(255,255,255)
                surface.SetTexture(failures)
                surface.DrawTexturedRectRotated(512,512,1024,1024,0)

                drawButton(0,"Начало",lineSel==1,nil,Color(0,255,255))
                drawButton(1,"Конец",lineSel==2,nil,Color(0,255,255))
                drawButton(2,"↑",lineSel==3,nil,Color(0,255,255))
                drawButton(3,"↓",lineSel==4,nil,Color(0,255,255))

                drawButton(5,{"Все","(%d)"},sel == 0 or lineSel==6,Train:GetNW2Int("MFDUErrorsA",0),sel~=0 and Color(0,255,255))
                drawButton(6,{"Неустр.","(%d)"},sel == 1 or lineSel==7,Train:GetNW2Int("MFDUErrorsB",0),sel~=1 and Color(0,255,255))

                for i=1,Train:GetNW2Int("MFDUErrorCount",-1) do
                    local errID = Train:GetNW2Int("MFDUErrorType"..i,-1)
                    if errID>-1 then
                        local err = self.ErrorNames[errID]
                        draw.SimpleText(os.date("!%H:%M:%S",Train:GetNW2Int("MFDUErrorTime"..i,0)),"Metrostroi_Calibri23l",40,85+(i-1)*21.5, i==1 and Color(0,0,0) or Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        draw.SimpleText(errorstates[err[2]][1],"Metrostroi_Calibri23l",115,85+(i-1)*21.5, i==1 and Color(0,0,0) or Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        draw.SimpleText(Format(err[1],Train:GetNW2Int("MFDUErrorWag"..i,0)),"Metrostroi_Calibri23l",155,85+(i-1)*21.5, i==1 and Color(0,0,0) or Color(123,123,123),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                        --[[ if not err or self.Selected == 0 or err[5] then
                            Train:SetNW2Int("MFDUErrorWag"..i,err and err[1] or -1)
                            Train:SetNW2Int("MFDUErrorDate"..i,err and err[3] or -1)
                            --cerr = cerr+1
                        end--]]
                    end
                end
                if Train:GetNW2Int("MFDUErrorCount",-1) > 0 then
                    draw.SimpleText(os.date("!%H:%M:%S",Train:GetNW2Int("MFDUErrorTime1",0)),"Metrostroi_Calibri23l",128,496, Color(0,232,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    if Train:GetNW2Bool("MFDUErrorSolved") then
                        draw.SimpleText("УСТРАНЁННЫЙ","Metrostroi_Calibri23l",387,496, Color(0,232,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    else
                        draw.SimpleText("НЕУСТРАНЁННЫЙ","Metrostroi_Calibri23l",387,496, Color(232,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    end

                    local time = Train:GetNW2Int("MFDUErrorConfirmT",-1)
                    if time > -1 then
                        draw.SimpleText(os.date("!%H:%M:%S",Train:GetNW2Int("MFDUErrorConfirmT",0)),"Metrostroi_Calibri23l",680,496, Color(0,232,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    else
                        draw.SimpleText("НЕТ","Metrostroi_Calibri23l",680,496, Color(232,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    end


                end
            elseif state2 == 4 then
                local sel = Train:GetNW2Int("MFDUSelected",0)
                local page = Train:GetNW2Int("MFDUPage",0)
                for i=1+page,math.min(6+page,WagNum) do
                    if i>6+page then break end
                    local ix = i-page-1
                    Metrostroi.DrawRectOutline(13+ix*131,59,117,38,Color(129,129,129),1)
                    draw.SimpleText(Format("%05d",Train:GetNW2Int("MFDUWagNum"..i,0)),"Metrostroi_Calibri40",71+ix*131,78, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    if sel == 0 then
                        Metrostroi.DrawRectOutline(13+ix*131,149,117,38,Color(129,129,129),1)
                        draw.SimpleText(Format("%.1f",Train:GetNW2Int("MFDUL2BC"..i,0)/10),"Metrostroi_Calibri40",71+ix*131,168, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    else
                        Metrostroi.DrawRectOutline(13+ix*131,149,117,38,Color(129,129,129),1)
                        draw.SimpleText(Format("%.1f",Train:GetNW2Int("MFDUL2TL"..i,0)/10),"Metrostroi_Calibri40",71+ix*131,168, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                        Metrostroi.DrawRectOutline(13+ix*131,244,117,38,Color(129,129,129),1)
                        draw.SimpleText(Format("%.1f",Train:GetNW2Int("MFDUL2SK"..i,0)/10),"Metrostroi_Calibri40",71+ix*131,263, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                        Metrostroi.DrawRectOutline(13+ix*131,339,117,38,Color(129,129,129),1)
                        draw.SimpleText(Format("%.1f",Train:GetNW2Int("MFDUL2PB"..i,0)/10),"Metrostroi_Calibri40",71+ix*131,358, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                        Metrostroi.DrawRectOutline(13+ix*131,434,117,38,Color(129,129,129),1)
                        draw.SimpleText(Format("%.1f",Train:GetNW2Int("MFDUL2BL"..i,0)/10),"Metrostroi_Calibri40",71+ix*131,453, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    end
                end

                drawButton(0,"ПС1",sel == 0 or lineSel==1,nil,sel~=0 and Color(0,255,255))
                drawButton(1,"ПС2",sel == 1 or lineSel==2,nil,sel~=1 and Color(0,255,255))

                if sel == 0 then
                    surface.SetDrawColor(255,255,255)
                    surface.SetTexture(pneumo_system)
                    surface.DrawTexturedRectRotated(512,512,1024,1024,0)
                    surface.SetTexture(pneumo_arrow)
                    local value = Train:GetNW2Int("MFDUL2TL1")/10
                    local mat1 = Matrix()
                    mat1:Translate(Vector(249,391,0))
                    --mat1:Rotate(Angle(0,-136.5+value/12*272.5,0))
                    mat1:Rotate(Angle(0,-135+value/12*270,0))
                    mat1:Translate(Vector(0,-95,0))
                    if 7.5 < value and value < 9 then
                        surface.SetDrawColor(40,160,40)
                    else
                        surface.SetDrawColor(245,0,0)
                    end
                    cam.PushModelMatrix(mat1)
                        surface.DrawTexturedRectRotated(0,0,64,256,0)
                    cam.PopModelMatrix()
                    draw.SimpleText(Format("%.1f",value),"Metrostroi_Calibri40",249,391, Color(215,215,215),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                    value = Train:GetNW2Int("MFDUL2TL"..WagNum)/10
                    mat1 = Matrix()
                    mat1:Translate(Vector(546,391,0))
                    mat1:Rotate(Angle(0,-135+value/12*270,0))
                    mat1:Translate(Vector(0,-95,0))
                    if 7.5 < value and value < 9 then
                        surface.SetDrawColor(40,160,40)
                    else
                        surface.SetDrawColor(245,0,0)
                    end
                    cam.PushModelMatrix(mat1)
                        surface.DrawTexturedRectRotated(0,0,64,256,0)
                    cam.PopModelMatrix()
                    draw.SimpleText(Format("%.1f",value),"Metrostroi_Calibri40",546,391, Color(215,215,215),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                    draw.SimpleText(WagNum,"Metrostroi_Calibri25",508,505.5, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                end
                if sel == 1 then
                    surface.SetDrawColor(255,255,255)
                    surface.SetTexture(pneumo_system2)
                    surface.DrawTexturedRectRotated(512,512,1024,1024,0)
                end
                if page ~= 0 then drawButton(7,"←") end
                if 6+page < WagNum then drawButton(8,"→") end
            elseif state2 == 5 then
                local page = Train:GetNW2Int("MFDUPage",0)
                for i=1+page,math.min(6+page,WagNum) do
                    if i>6+page then break end
                    local ix = i-page-1
                        Metrostroi.DrawRectOutline(13+ix*131,59,117,38,Color(129,129,129),1)
                        draw.SimpleText(Format("%05d",Train:GetNW2Int("MFDUWagNum"..i,0)),"Metrostroi_Calibri40",71+ix*131,78, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        Metrostroi.DrawRectOutline(13+ix*131,110,117,50,Train:GetNW2Bool("MFDUDPVUC"..i.."_1") and Color(220,0,0) or Color(129,129,129),Train:GetNW2Bool("MFDUDPVUC"..i.."_1") and 6 or 1)
                        draw.SimpleText("Двери","Metrostroi_Calibri35",71+ix*131,132,Train:GetNW2Bool("MFDUDPVUB"..i.."_1") and Color(220,0,0) or Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        Metrostroi.DrawRectOutline(13+ix*131,171,117,50,Train:GetNW2Bool("MFDUDPVUC"..i.."_2") and Color(220,0,0) or Color(129,129,129),Train:GetNW2Bool("MFDUDPVUC"..i.."_2") and 6 or 1)
                        draw.SimpleText("Свет","Metrostroi_Calibri35",71+ix*131,193, Train:GetNW2Bool("MFDUDPVUB"..i.."_2") and Color(220,0,0) or Color(0,220,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        if Train:GetNW2Bool("MFDUWagTyp"..i,false) then
                            Metrostroi.DrawRectOutline(13+ix*131,232,117,50,Train:GetNW2Bool("MFDUDPVUC"..i.."_3") and Color(220,0,0) or Color(129,129,129),Train:GetNW2Bool("MFDUDPVUC"..i.."_3") and 6 or 1)
                            draw.SimpleText("ПСН","Metrostroi_Calibri35",71+ix*131,254, Train:GetNW2Bool("MFDUDPVUB"..i.."_3") and Color(220,0,0) or Color(0,220,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                            Metrostroi.DrawRectOutline(13+ix*131,293,117,50,Train:GetNW2Bool("MFDUDPVUC"..i.."_4") and Color(220,0,0) or Color(129,129,129),Train:GetNW2Bool("MFDUDPVUC"..i.."_4") and 6 or 1)
                            draw.SimpleText("МК","Metrostroi_Calibri35",71+ix*131,315, Train:GetNW2Bool("MFDUDPVUB"..i.."_4") and Color(220,0,0) or Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                            Metrostroi.DrawRectOutline(13+ix*131,354,117,50,Train:GetNW2Bool("MFDUDPVUC"..i.."_5") and Color(220,0,0) or Color(129,129,129),Train:GetNW2Bool("MFDUDPVUC"..i.."_5") and 6 or 1)
                            draw.SimpleText("БВ","Metrostroi_Calibri35",71+ix*131,376, Train:GetNW2Bool("MFDUDPVUB"..i.."_5") and Color(220,0,0) or Color(0,220,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                            Metrostroi.DrawRectOutline(13+ix*131,415,117,50,Train:GetNW2Bool("MFDUDPVUC"..i.."_6") and Color(220,0,0) or Color(129,129,129),Train:GetNW2Bool("MFDUDPVUC"..i.."_6") and 6 or 1)
                            draw.SimpleText("ТП","Metrostroi_Calibri35",71+ix*131,437, Train:GetNW2Bool("MFDUDPVUB"..i.."_6") and Color(220,0,0) or Color(0,220,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                            Metrostroi.DrawRectOutline(13+ix*131,476,117,50,Train:GetNW2Bool("MFDUDPVUC"..i.."_7") and Color(220,0,0) or Color(129,129,129),Train:GetNW2Bool("MFDUDPVUC"..i.."_7") and 6 or 1)
                            draw.SimpleText("ТкПр","Metrostroi_Calibri35",71+ix*131,498, Train:GetNW2Bool("MFDUDPVUB"..i.."_7") and Color(220,0,0) or Color(0,220,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        end


                    --[[
                    surface.SetDrawColor(38,38,38)
                    surface.DrawRect(11,58+ix*54,59,49)
                    Metrostroi.DrawRectOutline(10,57+ix*54,62,52,Color(129,129,129),1)
                    draw.SimpleText(Format("%05d",Train:GetNW2Int("MFDUWagNum"..i,0)),"Metrostroi_Calibri26",40,83+ix*54, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                    if Train:GetPackedBool("MFDUDisableDoors"..i) then
                        surface.SetDrawColor(220,0,0)
                        surface.DrawRect(92,64+ix*53,85,45)
                        Metrostroi.DrawRectOutline(91,63+ix*53,88,48,Color(129,129,129),1)
                        draw.SimpleText("Двери","Metrostroi_Calibri35",135,84+ix*53, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    else
                        surface.SetDrawColor(38,38,38)
                        surface.DrawRect(92,64+ix*53,85,45)
                        Metrostroi.DrawRectOutline(91,63+ix*53,88,48,Color(129,129,129),1)
                        draw.SimpleText("Двери","Metrostroi_Calibri35",135,84+ix*53, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    end

                    if Train:GetPackedBool("MFDUDisableLights"..i) then
                        surface.SetDrawColor(220,0,0)
                        surface.DrawRect(192,64+ix*53,85,45)
                        Metrostroi.DrawRectOutline(191,63+ix*53,88,48,Color(129,129,129),1)
                        draw.SimpleText("Свет","Metrostroi_Calibri35",235,84+ix*53, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    else
                        surface.SetDrawColor(38,38,38)
                        surface.DrawRect(192,64+ix*53,85,45)
                        Metrostroi.DrawRectOutline(191,63+ix*53,88,48,Color(129,129,129),1)
                        draw.SimpleText("Свет","Metrostroi_Calibri35",235,84+ix*53, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    end
                    if Train:GetNW2Bool("MFDUWagTyp"..i,false) then
                        if Train:GetPackedBool("MFDUDisablePSN"..i) then
                            surface.SetDrawColor(220,0,0)
                            surface.DrawRect(292,64+ix*53,85,45)
                            Metrostroi.DrawRectOutline(291,63+ix*53,88,48,Color(129,129,129),1)
                            draw.SimpleText("ПСН","Metrostroi_Calibri35",335,84+ix*53, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        else
                            surface.SetDrawColor(38,38,38)
                            surface.DrawRect(292,64+ix*53,85,45)
                            Metrostroi.DrawRectOutline(291,63+ix*53,88,48,Color(129,129,129),1)
                            draw.SimpleText("ПСН","Metrostroi_Calibri35",335,84+ix*53, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        end

                        if Train:GetPackedBool("MFDUDisableMK"..i) then
                            surface.SetDrawColor(220,0,0)
                            surface.DrawRect(392,64+ix*53,85,45)
                            Metrostroi.DrawRectOutline(391,63+ix*53,88,48,Color(129,129,129),1)
                            draw.SimpleText("МК","Metrostroi_Calibri35",435,84+ix*53, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        else
                            surface.SetDrawColor(38,38,38)
                            surface.DrawRect(392,64+ix*53,85,45)
                            Metrostroi.DrawRectOutline(391,63+ix*53,88,48,Color(129,129,129),1)
                            draw.SimpleText("МК","Metrostroi_Calibri35",435,84+ix*53, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        end

                        if Train:GetPackedBool("MFDUBV"..i) then
                            surface.SetDrawColor(220,0,0)
                            surface.DrawRect(492,64+ix*53,85,45)
                            Metrostroi.DrawRectOutline(491,63+ix*53,88,48,Color(129,129,129),1)
                            draw.SimpleText("БВ","Metrostroi_Calibri35",535,84+ix*53, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        else
                            surface.SetDrawColor(38,38,38)
                            surface.DrawRect(492,64+ix*53,85,45)
                            Metrostroi.DrawRectOutline(491,63+ix*53,88,48,Color(129,129,129),1)
                            draw.SimpleText("БВ","Metrostroi_Calibri35",535,84+ix*53, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        end

                        if Train:GetPackedBool("MFDUDisableTP"..i) then
                            surface.SetDrawColor(220,0,0)
                            surface.DrawRect(592,64+ix*53,85,45)
                            Metrostroi.DrawRectOutline(591,63+ix*53,88,48,Color(129,129,129),1)
                            draw.SimpleText("ТП","Metrostroi_Calibri35",635,84+ix*53, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        else
                            surface.SetDrawColor(38,38,38)
                            surface.DrawRect(592,64+ix*53,85,45)
                            Metrostroi.DrawRectOutline(591,63+ix*53,88,48,Color(129,129,129),1)
                            draw.SimpleText("ТП","Metrostroi_Calibri35",635,84+ix*53, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        end
                    end--]]
                end

                surface.SetDrawColor(255,255,255)
                surface.SetTexture(pvu)
                surface.DrawTexturedRectRotated(512,512,1024,1024,0)

                if page ~= 0 then drawButton(7,"←") end
                if 6+page < WagNum then drawButton(8,"→") end
            elseif state2 == 6 then
                surface.SetDrawColor(255,255,255)
                surface.SetTexture(diag)
                surface.DrawTexturedRectRotated(512,512,1024,1024,0)
            elseif state2 == 7 then
                local page = Train:GetNW2Int("MFDUPage",0)
                for i=1+page,math.min(6+page,WagNum) do
                    if i>6+page then break end
                    local ix = i-page-1
                    surface.SetDrawColor(38,38,38)
                    surface.DrawRect(11,58+ix*54,59,49)
                    Metrostroi.DrawRectOutline(10,57+ix*54,62,52,Color(129,129,129),1)
                    draw.SimpleText(Format("%05d",Train:GetNW2Int("MFDUWagNum"..i,0)),"Metrostroi_Calibri26",40,83+ix*54, Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                    if Train:GetNW2Bool("MFDUWagHead"..i) then
                        if Train:GetNW2Bool("MFDUDCabL"..i) then surface.SetDrawColor(220,0,0) else surface.SetDrawColor(0,220,0) end
                        surface.DrawRect(168,62+ix*54,17,44)

                        if Train:GetNW2Bool("MFDUDCabR"..i) then surface.SetDrawColor(220,0,0) else surface.SetDrawColor(0,220,0) end
                        surface.DrawRect(613,62+ix*54,17,44)

                        --if Train:GetNW2Bool("MFDUDF"..i) then surface.SetDrawColor(220,0,0) else surface.SetDrawColor(0,220,0) end
                        --surface.DrawRect(380,(i~=1 and 87 or 62)+ix*54,36,21)
                        --if Train:GetNW2Bool("MFDUDB"..i) then surface.SetDrawColor(220,0,0) else surface.SetDrawColor(0,220,0) end
                        --surface.DrawRect(380,(i==1 and 87 or 62)+ix*54,36,21)
                    --else
                    end
                    if Train:GetNW2Bool("MFDUDF"..i) then surface.SetDrawColor(220,0,0) else surface.SetDrawColor(0,220,0) end
                    surface.DrawRect(380,62+ix*54,36,21)
                    if Train:GetNW2Bool("MFDUDB"..i) then surface.SetDrawColor(220,0,0) else surface.SetDrawColor(0,220,0) end
                    surface.DrawRect(380,87+ix*54,36,21)

                    for i2=0,3 do
                        if Train:GetNW2Bool("MFDUDL"..i2.."_"..i) then surface.SetDrawColor(220,0,0) else surface.SetDrawColor(0,220,0) end
                        surface.DrawRect(211+i2*24,63+ix*54,17,44)
                        if Train:GetNW2Bool("MFDUDR"..i2.."_"..i) then surface.SetDrawColor(220,0,0) else surface.SetDrawColor(0,220,0) end
                        surface.DrawRect(501+i2*24,63+ix*54,17,44)
                    end
                end
                surface.SetDrawColor(38,38,38)
                surface.DrawRect(24,476,751,34)
                if -0.01 > self.PowerCommandSmooth or self.PowerCommandSmooth > 0.01 then
                    surface.SetDrawColor(self.PowerCommandSmooth < 0 and 255 or 0,Train:GetPackedBool("ARSComm",false) and 0 or 255,0)
                    surface.DrawRect(400,477,math.Clamp(self.PowerCommandSmooth*377,-375,375),32)
                end

                surface.SetDrawColor(255,255,255)
                surface.SetTexture(doors)
                surface.DrawTexturedRectRotated(512,512,1024,1024,0)

                local voltage = Train:GetNW2Int("MFDUTrainVoltage",0)
                if 550 <= voltage and voltage <= 975 then
                    surface.SetDrawColor(0,220,0)
                else
                    surface.SetDrawColor(220,0,0)
                end
                surface.DrawRect(698,58,92,71)
                draw.SimpleText("Напряж.","Metrostroi_Calibri26",744,93.50-23, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText("К.Р.","Metrostroi_Calibri26",744,93.50, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText(Format("%d В",voltage),"Metrostroi_Calibri26",744,93.50+23, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                if Train:GetNW2Bool("MFDUTrainSD") then
                    surface.SetDrawColor(200,200,200)
                else
                    surface.SetDrawColor(220,0,0)
                end
                surface.DrawRect(698,141,92,71)
                draw.SimpleText("Контроль","Metrostroi_Calibri26",744,176.50-11, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText("дверей","Metrostroi_Calibri26",744,176.50+11, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                local NMPress = Train:GetNW2Int("MFDUL2TL1",0)/10
                if 6.4 <= NMPress and NMPress <= 8.1 then
                    surface.SetDrawColor(0,220,0)
                else
                    surface.SetDrawColor(220,0,0)
                end
                surface.DrawRect(698,224,92,71)
                draw.SimpleText("Давл. НМ.","Metrostroi_Calibri26",744,259.50-23, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText(Format("%.1f",NMPress),"Metrostroi_Calibri26",744,259.50, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText("кгс/см²","Metrostroi_Calibri26",744,259.50+23, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                local TMPress = Train:GetNW2Int("MFDUL2BL1",0)/10
                if 2.8 <= TMPress and TMPress <= 5.4 then
                    surface.SetDrawColor(0,220,0)
                else
                    surface.SetDrawColor(220,0,0)
                end
                surface.DrawRect(698,307,92,71)
                draw.SimpleText("Давл. ТМ.","Metrostroi_Calibri26",744,342.50-23, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText(Format("%.1f",TMPress),"Metrostroi_Calibri26",744,342.50, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText("кгс/см²","Metrostroi_Calibri26",744,342.50+23, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                if page ~= 0 then drawButton(7,"←") end
                if 6+page < WagNum then drawButton(8,"→") end
            elseif state2 == 8 then
                local sel = Train:GetNW2Int("MFDUSelected",0)
                local page = Train:GetNW2Int("MFDUPage",0)
                if sel == 0 then
                    surface.SetDrawColor(255,255,255)
                    surface.SetTexture(vo)
                    surface.DrawTexturedRectRotated(512,512,1024,1024,0)

                    draw.SimpleText("Освещение","Metrostroi_Calibri25",96,135+41*0, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("ПСН","Metrostroi_Calibri25",96,135+41*1, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("ЗУ АКБ","Metrostroi_Calibri25",96,135+41*2, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("МК","Metrostroi_Calibri25",96,135+41*3, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("Токоприёмники","Metrostroi_Calibri25",96,135+41*4, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    for i=1+page,math.min(6+page,WagNum) do
                        if i>6+page then break end
                        local ix = i-page-1
                        draw.SimpleText(i,"Metrostroi_Calibri25",242 +ix*101,97, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                        surface.SetTexture(box)
                        if Train:GetPackedBool("MFDUPassLights"..i) then surface.SetDrawColor(0,220,0) else surface.SetDrawColor(220,0,0) end
                        surface.DrawTexturedRectRotated(242 +ix*101,135+41*0,32,62,0)
                        if Train:GetNW2Bool("MFDUWagTyp"..i,false) then
                            if Train:GetPackedBool("MFDUPSN"..i) then surface.SetDrawColor(0,220,0) else surface.SetDrawColor(220,0,0) end
                            surface.DrawTexturedRectRotated(242 +ix*101,135+41*1,32,62,0)
                            surface.SetDrawColor(220,0,0)
                            surface.DrawTexturedRectRotated(242 +ix*101,135+41*2,32,62,0)
                            if Train:GetPackedBool("MFDUMK"..i) then surface.SetDrawColor(0,220,0) else surface.SetDrawColor(220,0,0) end
                            surface.DrawTexturedRectRotated(242 +ix*101,135+41*3,32,62,0)
                            if Train:GetPackedBool("MFDUTP"..i) then surface.SetDrawColor(0,220,0) else surface.SetDrawColor(220,0,0) end
                            surface.DrawTexturedRectRotated(242 +ix*101,135+41*4,32,62,0)
                        end
                    end
                elseif sel == 1 then
                    surface.SetDrawColor(255,255,255)
                    surface.SetTexture(common)
                    surface.DrawTexturedRectRotated(512,512,1024,1024,0)

                    draw.SimpleText("Буксы","Metrostroi_Calibri35",400,24, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                    surface.SetTexture(box)
                    for i=1+page,math.min(6+page,WagNum) do
                        if i>6+page then break end
                        local ix = i-page-1
                        Metrostroi.DrawRectOutline(13+ix*131,59,117,38,Color(129,129,129),1)
                        draw.SimpleText(Format("%05d",Train:GetNW2Int("MFDUWagNum"..i,0)),"Metrostroi_Calibri40",71+ix*131,78, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                        for i2=1,8 do
                            surface.SetDrawColor(0,220,0)
                            surface.DrawTexturedRectRotated(71.5+ix*131,90+i2*41,75,62,0)
                            draw.SimpleText(i2,"Metrostroi_Calibri40",71.5+ix*131,90+i2*41, Color(32,32,32),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        end
                        --[[
                        local state = Train:GetPackedBool("MFDUVentEnabled"..(2-i2%2)..i)
                        for i2=1,8 do
                            if state then surface.SetDrawColor(0,220,0) else surface.SetDrawColor(220,0,0) end
                            surface.DrawTexturedRectRotated(71.5+ix*131,90+i2*41,75,62,0)
                            draw.SimpleText(i2,"Metrostroi_Calibri40",71.5+ix*131,90+i2*41, Color(32,32,32),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        end
                        --]]
                    end
                elseif sel == 2 then
                    surface.SetDrawColor(255,255,255)
                    surface.SetTexture(common)
                    surface.DrawTexturedRectRotated(512,512,1024,1024,0)

                    draw.SimpleText("ДПБТ","Metrostroi_Calibri35",400,24, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                    surface.SetTexture(box)
                    for i=1+page,math.min(6+page,WagNum) do
                        if i>6+page then break end
                        local ix = i-page-1
                        Metrostroi.DrawRectOutline(13+ix*131,59,117,38,Color(129,129,129),1)
                        draw.SimpleText(Format("%05d",Train:GetNW2Int("MFDUWagNum"..i,0)),"Metrostroi_Calibri40",71+ix*131,78, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                        local state = Train:GetPackedBool("MFDUDPBD1"..i)
                        for i2=1,8 do
                            if state then surface.SetDrawColor(0,220,0) else surface.SetDrawColor(220,0,0) end
                            surface.DrawTexturedRectRotated(71.5+ix*131,90+i2*41,75,62,0)
                            draw.SimpleText(i2,"Metrostroi_Calibri40",71.5+ix*131,90+i2*41, Color(32,32,32),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        end
                    end
                elseif sel == 3 then
                    surface.SetDrawColor(255,255,255)
                    surface.SetTexture(common)
                    surface.DrawTexturedRectRotated(512,512,1024,1024,0)

                    draw.SimpleText("Вентиляция","Metrostroi_Calibri35",400,24, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                    surface.SetTexture(box)
                    for i=1+page,math.min(6+page,WagNum) do
                        if i>6+page then break end
                        local ix = i-page-1
                        Metrostroi.DrawRectOutline(13+ix*131,59,117,38,Color(129,129,129),1)
                        draw.SimpleText(Format("%05d",Train:GetNW2Int("MFDUWagNum"..i,0)),"Metrostroi_Calibri40",71+ix*131,78, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                        for i2=Train:GetNW2Bool("MFDUWagHead"..i) and 2 or 1,8 do
                            local state = Train:GetPackedBool("MFDUVentEnabled"..(2-i2%2)..i)
                            if state then surface.SetDrawColor(0,220,0) else surface.SetDrawColor(38,38,38) end
                            surface.DrawTexturedRectRotated(71.5+ix*131,90+i2*41,75,62,0)
                            draw.SimpleText(i2,"Metrostroi_Calibri40",71.5+ix*131,90+i2*41, state and Color(32,32,32) or Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        end
                    end
                end
                drawButton(0,"ВО",              sel == 0 or lineSel==1,nil,sel~=0 and Color(0,255,255))
                drawButton(1,"Буксы",           sel == 1 or lineSel==2,nil,sel~=1 and Color(0,255,255))
                drawButton(2,"ДПБТ",            sel == 2 or lineSel==3,nil,sel~=2 and Color(0,255,255))
                drawButton(3,{"Венти-","ляция"},sel == 3 or lineSel==4,nil,sel~=3 and Color(0,255,255))

                if page ~= 0 then drawButton(7,"←") end
                if 6+page < WagNum then drawButton(8,"→") end
            elseif state2 == 9 then
                local page = Train:GetNW2Int("MFDUPage",0)
                local sel = Train:GetNW2Int("MFDUSelected",0)
                if sel == 0 then
                    for i=1+page,math.min(6+page,WagNum) do
                        if i>6+page then break end
                        local ix = i-page-1
                        Metrostroi.DrawRectOutline(13+ix*131,59,117,38,Color(129,129,129),1)
                        draw.SimpleText(Format("%05d",Train:GetNW2Int("MFDUWagNum"..i,0)),"Metrostroi_Calibri40",71+ix*131,78, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                        Metrostroi.DrawRectOutline(13+ix*131,149,117,38,Color(129,129,129),1)
                        Metrostroi.DrawRectOutline(13+ix*131,234,117,38,Color(129,129,129),1)
                        Metrostroi.DrawRectOutline(13+ix*131,359,117,38,Color(129,129,129),1)
                        if Train:GetNW2Bool("MFDUWagTyp"..i,false) then
                            draw.SimpleText(Format("%.1f",Train:GetNW2Int("MFDUTHD"..i,0)/10),"Metrostroi_Calibri40",71+ix*131,168, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                            draw.SimpleText(Format("%.1f",Train:GetNW2Int("MFDUTHB"..i,0)/10),"Metrostroi_Calibri40",71+ix*131,253, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                            draw.SimpleText(Format("%.1f",Train:GetNW2Int("MFDUTA"..i,0)/10),"Metrostroi_Calibri40",71+ix*131,378, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        end
                    end
                end

                drawButton(0,"ТП1",sel == 0 or lineSel==1,nil,sel~=0 and Color(0,255,255))
                drawButton(1,"ТП2",sel == 1 or lineSel==2,nil,sel~=1 and Color(0,255,255))

                if sel == 0 then
                    surface.SetDrawColor(255,255,255)
                    surface.SetTexture(tp1)
                    surface.DrawTexturedRectRotated(512,512,1024,1024,0)
                end
                if sel == 1 then
                    surface.SetDrawColor(255,255,255)
                    surface.SetTexture(tp2)
                    surface.DrawTexturedRectRotated(512,512,1024,1024,0)
                end
                if sel == 1 then
                    draw.SimpleText("Сбор схемы","Metrostroi_Calibri25",96,135+41*0, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("Отказ инвертора","Metrostroi_Calibri25",96,135+41*1, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("Защита инвертора","Metrostroi_Calibri25",96,135+41*2, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("Перегрев инвертора","Metrostroi_Calibri25",96,135+41*3, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("Отказ ЭТ","Metrostroi_Calibri25",96,135+41*4, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("БВ","Metrostroi_Calibri25",96,135+41*5, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText("КС","Metrostroi_Calibri25",96,135+41*6, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    surface.SetTexture(box)
                    local sel = Train:GetNW2Int("MFDUSelected",0)
                    local page = Train:GetNW2Int("MFDUPage",0)
                    for i=1+page,math.min(6+page,WagNum) do
                        if i>6+page then break end
                        local ix = i-page-1
                        draw.SimpleText(i,"Metrostroi_Calibri25",242 +ix*101,97, Color(129,129,129),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                        if Train:GetNW2Bool("MFDUWagTyp"..i,false) then
                            if Train:GetPackedBool("MFDUScheme"..i) then surface.SetDrawColor(0,220,0) else surface.SetDrawColor(220,0,0) end
                            surface.DrawTexturedRectRotated(242 +ix*101,135+41*0,32,62,0)
                            if Train:GetPackedBool("MFDUInv"..i) then surface.SetDrawColor(0,220,0) else surface.SetDrawColor(220,0,0) end
                            surface.DrawTexturedRectRotated(242 +ix*101,135+41*1,32,62,0)
                            surface.DrawTexturedRectRotated(242 +ix*101,135+41*3,32,62,0)
                            if Train:GetPackedBool("MFDUAProt"..i) then surface.SetDrawColor(220,0,0) else surface.SetDrawColor(0,220,0) end
                            surface.DrawTexturedRectRotated(242 +ix*101,135+41*2,32,62,0)
                            if Train:GetPackedBool("MFDUBadT"..i) then surface.SetDrawColor(220,0,0) else surface.SetDrawColor(0,220,0) end
                            surface.DrawTexturedRectRotated(242 +ix*101,135+41*4,32,62,0)
                            if Train:GetPackedBool("MFDUBV"..i) then surface.SetDrawColor(0,220,0) else surface.SetDrawColor(220,0,0) end
                            surface.DrawTexturedRectRotated(242 +ix*101,135+41*5,32,62,0)
                            if Train:GetPackedBool("MFDUKS"..i) then surface.SetDrawColor(0,220,0) else surface.SetDrawColor(220,0,0) end
                            surface.DrawTexturedRectRotated(242 +ix*101,135+41*6,32,62,0)
                        end
                    end
                end

                if page ~= 0 then drawButton(7,"←") end
                if 6+page < WagNum then drawButton(8,"→") end
            end
            if not Train:GetPackedBool("MFDUEmer") then
                if state > 0 then
                    draw.SimpleText(os.date("!%d.%m.%Y",Metrostroi.GetSyncTime()),"Metrostroi_Calibri26",101, 12,Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    draw.SimpleText(os.date("!%H:%M:%S",Metrostroi.GetSyncTime()),"Metrostroi_Calibri26",101, 36,Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                    if Train:GetNW2Bool("MFDUIdent") then
                        draw.SimpleText("Идентификация","Metrostroi_Calibri26",701, 22,Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    elseif state2 > 1 and state2 ~= 2 then
                        if Train:GetNW2Bool("MFDUBARSActive") then
                            draw.SimpleText(math.floor(Train:GetNW2Int("MFDUSpeed",0)),"Metrostroi_Calibri60",650, 22,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                            draw.SimpleText("км/ч","Metrostroi_Calibri30",720, 22,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        else
                            draw.SimpleText(math.floor(Train:GetNW2Int("MFDUSpeed",0)),"Metrostroi_Calibri60",650, 22,Color(255,255,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                            draw.SimpleText("км/ч","Metrostroi_Calibri30",720, 22,Color(255,255,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        end
                    else--if Active then
                        local drvnum = Train:GetNW2Int("MFDUDriverNumber",-1)
                        draw.SimpleText(Format("%010d",drvnum > -1 and drvnum or 0),"Metrostroi_Calibri26",701, 22,Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    --else
                        --draw.SimpleText("Идентификация","Metrostroi_Calibri26",701, 22,Color(123,123,123),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    end
                end
                if state2 > 0 then
                    drawButton(9,"Обратно",lineSel==10,nil,Color(0,255,255))
                end
            end
        end
        if state ~= 0 and state ~= -1 then
            surface.SetDrawColor(0,0,20,100)
            surface.DrawRect(0,0,800,600)
        end
    end
end

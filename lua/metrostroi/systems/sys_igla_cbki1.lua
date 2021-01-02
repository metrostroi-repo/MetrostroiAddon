--------------------------------------------------------------------------------
-- ASOTP "IGLA" white indicator unit for 81-720
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("IGLA_CBKI1")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.Log = {}
    self.States = {}
    self.Messages = {}
    self.MessagesCount = 0
    if not self.Train.IGLA1 then
        self.Train:LoadSystem("IGLA1","Relay","Switch",{bass = true})
        self.Train:LoadSystem("IGLA2","Relay","Switch",{bass = true})
        self.Train:LoadSystem("IGLA3","Relay","Switch",{bass = true})
        self.Train:LoadSystem("IGLA4","Relay","Switch",{bass = true})
    end
    self.TriggerNames = {
        "IGLA1",
        "IGLA2",
        "IGLA3",
        "IGLA4",
    }
    self.Triggers = {}
    self.State = 0
    self.Timer = 0
    if not TURBOSTROI then
        self.BVolt = 3.0+math.random()*0.4
        self.Train:SetNW2Int("IGLA:BVolt",self.BVolt*10)
    end
end
if TURBOSTROI then return end
function TRAIN_SYSTEM:Inputs()
    return {  "" }
end
if CLIENT then
    local Chars = {
        full  = utf8.char(0x2588),
        lhalf = utf8.char(0x258C),
        rhalf = utf8.char(0x2590),
        shade = utf8.char(0x2592),
        [1]   = utf8.char(0x2776),
        [2]   = utf8.char(0x2777),
        [3]   = utf8.char(0x2778),
        [4]   = utf8.char(0x2779),
        [5]   = utf8.char(0x277A),
        [6]   = utf8.char(0x277B),
        [7]   = utf8.char(0x277C),
        [8]   = utf8.char(0x277D),
        [9]   = utf8.char(0x277E),
        [0]   = utf8.char(0x24FF),
    }
    local Converter = {
        ["\1"]   = Chars[1],
        ["\2"]   = Chars[2],
        ["\3"]   = Chars[3],
        ["\4"]   = Chars[4],
        ["\5"]   = Chars[5],
        ["\6"]   = Chars[6],
        ["\7"]   = Chars[7],
        ["\8"]   = Chars[8],
        ["\9"]   = Chars[9],
        ["\0"]   = Chars[0],
    }
    local function FormatEnd1(num)
        if num == 1 then return " "
        elseif 1 < num and num < 5 then return "а" end
        return "ов"
    end
    local function FormatEnd2(num)
        if num == 1 then return "ка"
        elseif 1 < num and num < 5 then return "ки" end
        return "ок"
    end
    function TRAIN_SYSTEM:PrintText(x,y,text,col)
        local str = {utf8.codepoint(text,1,-1)}
        for i=1,#str do
            local char = utf8.char(str[i])
            local alpha = col.a
            if alpha > 1 then
                draw.SimpleText(char,"MetrostroiSubway_IGLAb",-8+(x+i)*25,30+y*43+1,ColorAlpha(col,alpha*0.08),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            end
            draw.SimpleText(char,"MetrostroiSubway_IGLA",-8+(x+i)*25,30+y*43,col,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
    end
  function TRAIN_SYSTEM:ClientThink()
    if not self.Train:ShouldDrawPanel("IGLA") then return end
    if not self.DrawTimer then
        render.PushRenderTarget(self.Train.IGLA,0,0,512, 128)
        render.Clear(0, 0, 0, 0)
        render.PopRenderTarget()
    end
    self.DrawTimer = self.DrawTimer or CurTime()
    if CurTime()-self.DrawTimer < 0.1 then return end
    self.DrawTimer = CurTime()
    render.PushRenderTarget(self.Train.IGLA,0,0,512, 128)
    render.Clear(0, 0, 0, 0)
    cam.Start2D()
        self:IGLA(self.Train)
    cam.End2D()
    render.PopRenderTarget()
  end

    local messages = {
        START = "питание цбки включ",
        CONN = "подключен",
        DISCONN = "потеря связи",
        SCHEME = "несбор сх ваг",
        RP = "сработка рп",
        DOORS = "открытые двери",
        BPSN = "выкл бпсн",
        PARKING = "вкл стоян торм",
        MANUAL = "вкл ручн торм",
        BRAKES = "вкл пневм торм",
        UAVA = "сраб срыв клап",
        UAVAK = "контакты уава",
        EPK = "сработка эпв",
        ARS = "прев арс 9км\\ч",
        RU = "резерв котнрол",
    }
    local colorb = Color(60,160,140,1)
    local colorf = Color(60,160,140,255)
    local colorh = Color(60,160,140,75)
    function TRAIN_SYSTEM:IGLA()
        local Train = self.Train
        surface.SetDrawColor(60*0.075,160*0.075,140*0.075)
        surface.DrawRect(0,0,512,107)
        self:PrintText(0,0,string.rep(Chars.full,20),colorb)
        self:PrintText(0,1,string.rep(Chars.full,20),colorb)
        local State = self.Train:GetNW2Int("IGLA:State",0)
        if State == -3 then
            self:PrintText(0,0,"обратитесь в службу",colorf)
            self:PrintText(0,1,"ремонта чайников",colorf)
        elseif State == 0 then
            if RealTime()%0.6 > 0.3 then
                self:PrintText(0,0,Chars.full,colorf)
            end
        elseif State == 1 then
            self.VoltRandom = self.VoltRandom or RealTime()
            if not self.Volt1 or CurTime()-self.VoltRandom > 0 then
                self.VoltRandom = CurTime()+0.2+math.random()*0.6
                self.Volt1 = 4.9+math.random()*0.2
                self.Volt2 = 3.0+math.random()*0.2
            end
            self:PrintText(0,0,"к 15в 5в 3.3в бт пчм",colorf)
            if not Train:GetNW2Bool("IGLA:E") or RealTime()%0.5 > 0.25 then
                self:PrintText(0,1,Format("%X",Train:GetNW2Int("IGLA:B")),colorf)
            end
                self:PrintText(2,1,"15",colorf)
                self:PrintText(5,1,Format("%.1f",self.Volt1 or 5),colorf)
                self:PrintText(9,1,Format("%.1f",self.Volt2 or 3.2),colorf)
                self:PrintText(13,1,Format("%.1f",Train:GetNW2Int("IGLA:BVolt",0)/10),colorf)
                if Train:GetNW2Bool("IGLA:P") then self:PrintText(17,1,".",colorf) end
                if Train:GetNW2Bool("IGLA:C") then self:PrintText(18,1,".",colorf) end
                self:PrintText(19,1,".",colorf)
        elseif State == 2 then
            local State2 = Train:GetNW2Int("IGLA:State2",0)
            --[[ for i=1,6 do
                self:PrintText((i-1)*3,0,Format("%02d",i),colorf)
                self:PrintText((i-1)*3,1,Format("%02d",Train:GetNW2Int("PUAV:RK" .. i,0)),colorf)
            end--]]
            if State2 == 0 then
                local Standby = Train:GetNW2Bool("IGLA:Standby")
                local ShowTime = Train:GetNW2Bool("IGLA:ShowTime")
                if not Standby then
                    local count = Train:GetNW2Int("IGLA:Count")
                    self:PrintText(0,0,"асотп",colorf)
                        self:PrintText(6,0,Format("%2d",count),colorf)
                        self:PrintText(9,0,"комплект",colorf)
                        self:PrintText(17,0,FormatEnd1(count),colorf)

                    local d = Metrostroi.GetSyncTime()
                    self:PrintText(0,1,os.date("!%d-%m-%y",d),colorf)
                        self:PrintText(12,1,os.date("!%H:%M:%S",d),colorf)
                elseif ShowTime then
                    local d = Metrostroi.GetSyncTime()
                    self:PrintText(0,1,os.date("!%d-%m-%y",d),colorh)
                        self:PrintText(12,1,os.date("!%H:%M:%S",d),colorh)
                end
            elseif State2 == 1 then
                local w = Train:GetNW2Int("IGLA:WagNumber")
                local m = Train:GetNW2String("IGLA:ErrorID")
                if messages[m] then m = messages[m] end
                self:PrintText(0,0,Format("%05d",w),colorf)
                    self:PrintText(6,0,m,colorf)
                self:PrintText(0,1,"^",colorf)
                    if Train:GetNW2Bool("IGLA:ButtonL2") then self:PrintText(6,1,"<-",colorf) end
                    if Train:GetNW2Bool("IGLA:ButtonL3") then self:PrintText(11,1,"->",colorf) end
                    self:PrintText(15,1,Format("[%03d]",Train:GetNW2Int("IGLA:MessagesCount")),colorf)
            elseif State2 == 2 then
                self:PrintText(0,0,"введите код:",colorf)
            elseif State2 == 3 then
                local w = Train:GetNW2Int("IGLA:WagNumber")
                local m = Train:GetNW2String("IGLA:LogID")
                if messages[m] then m = messages[m] end
                if w > 0 then
                    self:PrintText(0,0,Format("%05d",w),colorf)
                        self:PrintText(6,0,m,colorf)
                else
                    self:PrintText(0,0,m,colorf)
                end
            self:PrintText(0,1,"^",colorf)
            local d = Train:GetNW2Int("IGLA:LogDate")
                self:PrintText(3,1,os.date("!%d-%m-%y",d),colorf)
                    self:PrintText(12,1,os.date("!%H:%M:%S",d),colorf)
            end
        end
    end
else
    function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
        if self.State < 2 then return end
        if not self.States[sourceid] then
            self.States[sourceid] = {}
            table.insert(self.Log,{"CONN",sourceid,Metrostroi.GetSyncTime()})
        end
        self.States[sourceid][textdata] = numdata
    end
    function TRAIN_SYSTEM:CANWrite(name,value)
        self.Train:CANWrite("IGLA_CBKI",self.Train:GetWagonNumber(),"IGLA_PCBK",nil,name,value)
    end
    function TRAIN_SYSTEM:Trigger(name,value)
        if self.State == -3 then
            local ID = tonumber(name[5])
            if ID and bit.band(self.StartError,2^(ID-1)) == 0 then
                self.Reset = true
            end
        elseif self.State == 2 then
            local ID = tonumber(name[5])
            if self.State2 == 0 then
                if ID == 1 and self.MessagesCount > 0 and value then
                    self.State2 = 1
                    self.StandbyTimer = CurTime()
                    self.Selected = #self.Messages
                elseif ID == 4 and CurTime()-self.StandbyTimer > 10 and value then
                    self.ShowTimeTimer = CurTime()
                elseif ID==4 and not value and self.ShowTimeTimer then
                    if self.ShowTimeTimer ~= true then self.StandbyTimer = CurTime() end
                    self.ShowTimeTimer = nil
                end
            elseif self.State2 == 1 then
                self.StandbyTimer = CurTime()
                if ID==1 and value then
                    self.State2 = 0
                elseif ID==2 and value and self.Selected > 1 then
                    self.Selected = self.Selected - 1
                end
                if ID==3 and value and self.Selected < #self.Messages then
                    self.Selected = self.Selected + 1
                end
            elseif self.State2 == 2 and ID and value then
                self.Password = self.Password..ID
                if #self.Password > 3 then
                    if self.Password == "3241" then
                        self.State2 = 3
                        self.StandbyTimer = CurTime()
                        self.Selected = #self.Log
                    else
                        self.State2 = 0
                    end
                    self.Password = nil
                end
            elseif self.State2 == 3 then
                self.StandbyTimer = CurTime()
                if ID==1 and value then
                    self.State2 = 0
                elseif ID==2 and value and self.Selected > 1 then
                    self.Selected = self.Selected - 1
                end
                if ID==3 and value and self.Selected < #self.Log then
                    self.Selected = self.Selected + 1
                end
            end
        end
    end
    local Logging = {
        SCHEME = false,
        RP = true,
        DOORS = true,
        BPSN = true,
        PARKING = true,
        MANUAL = true,
        BRAKES = true,
        UAVA = true,
        UAVAK = true,
        EPK = true,
        ARS = true,
        RU = true,
    }

    function TRAIN_SYSTEM:CError(WagID,ErrID,status)
        local ID = WagID..ErrID
        if not self.Messages[ID] and status then
            self.Messages[ID] = table.insert(self.Messages,{ErrID,WagID,Metrostroi.GetSyncTime(),ID})
            if Logging[ErrID] then
                table.insert(self.Log,self.Messages[self.Messages[ID]])
            end
            --print(Format("Message with ErrID '%s' have ID:%d",ID,self.Messages[ID]))
        elseif self.Messages[ID] and not status then
            --print(Format("Removed message with ErrID '%s' have ID:%d",ID,self.Messages[ID]))
            table.remove(self.Messages,self.Messages[ID])
            self.Messages[ID] = nil
            for k,v in ipairs(self.Messages) do
                self.Messages[v[4]] = k
            end
        end
    end
    function TRAIN_SYSTEM:Think(dT)
        local Train = self.Train
        local Power = Train.Panel.CBKIPower > 0
        if Power and --[[ Train.A63.Value > 0.5 and--]]  self.State ~= -2  then
            for k,v in pairs(self.TriggerNames) do
                if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
                    self:Trigger(v,Train[v].Value > 0.5)
                    self.Triggers[v] = Train[v].Value > 0.5
                end
            end
        end
        if not Power or --[[ Train.A63.Value < 0.5 or--]]  self.Reset then
            self.Reset = false
            if self.State ~= -2 then
                self.State = -2
                self.Timer = nil
                self.Timer1 = nil
                self.Timer2 = nil
                self.ButtonL1 = false
                self.ButtonL2 = false
                self.ButtonL3 = false
                self.ButtonL4 = false
                self.Fire = 0
                self.Error = 0
                self.States = {}
                self.Messages = {}
            end
        end
        if self.State == -2 and Power --[[ and Train.A63.Value > 0.5--]]  then
            self.State = -1
            self.Timer = CurTime()+math.random()*0.3
            self.StartError = false
        end
        if self.State == -1 and CurTime()-self.Timer > 0.3 then
            self.State = 0
            Train:PlayOnce("igla_start2","cabin",nil,2)
            self.Timer = CurTime()+math.random()*0.4
        end
        if self.State == 0 and CurTime()-self.Timer > 0.6 then
            table.insert(self.Log,{"START",sourceid,Metrostroi.GetSyncTime()})
            self.State = 1
            Train:PlayOnce("igla_start1","cabin")
            self.Timer = CurTime()+math.random()*0.4
            self.Timer1 = 0.9+CurTime()+math.random()*0.2
            self.Timer2 = 1.0+CurTime()+math.random()*1.2
            self.StartError = Train.IGLA1.Value+Train.IGLA2.Value*2+Train.IGLA3.Value*4+Train.IGLA4.Value*8
            Train:SetNW2Bool("IGLA:E",self.StartError > 0)
        end
        if self.State == 1 then
            Train:SetNW2Bool("IGLA:P",CurTime()-self.Timer1 > 0)
            Train:SetNW2Bool("IGLA:C",CurTime()-self.Timer2 > 0)
            Train:SetNW2Int("IGLA:B",Train.IGLA1.Value+Train.IGLA2.Value*2+Train.IGLA3.Value*4+Train.IGLA4.Value*8)
            self.ButtonL1 = self.StartError > 0 or CurTime()-self.Timer < 3
            self.ButtonL2 = self.ButtonL1
            self.ButtonL3 = self.ButtonL1
            self.ButtonL4 = self.ButtonL1
            self.Fire = true
            self.Error = true
            --Train:SetNW2Bool("IGLA:M",CurTime()-self.Timer3 > 0)
            if CurTime()-self.Timer > 5 then
                self.State = self.StartError > 0 and -3 or 2
                self.State2 = 0
                self.StandbyTimer = CurTime()
                self.ShowTimeTimer = nil
                self.ShowTime = false

                Train:PlayOnce("igla_start2","cabin",nil,1)

                self.PCBKTimer = nil
            end
        elseif self.State == -3 then
            self.ButtonL1 = bit.band(self.StartError,1) == 0
            self.ButtonL2 = bit.band(self.StartError,2) == 0
            self.ButtonL3 = bit.band(self.StartError,4) == 0
            self.ButtonL4 = bit.band(self.StartError,8) == 0
            self.Fire = false
            self.Error = CurTime()%0.5 > 0.25
        elseif self.State == 2 then
            if #self.Log > 100 then table.remove(self.Log,1) end
            local Standby = CurTime()-self.StandbyTimer > 10
            if self.State2 > 0 and Standby then self.State2 = 0 end
            if self.ShowTimeTimer and self.ShowTimeTimer ~= true and CurTime()-self.ShowTimeTimer > 1.5 then
                self.ShowTime = not self.ShowTime
                self.ShowTimeTimer = true
            end
            if not self.PCBKTimer or CurTime()-self.PCBKTimer > 1.4 then
                self:CANWrite("Update",1)
                self.PCBKTimer = CurTime()+math.random()*0.4
            end

            local count = 0
            for k,v in pairs(self.States) do
                local timer = v.Timer and CurTime()-v.Timer or 10
                if timer <= 5 then
                    for id in pairs(Logging) do self:CError(k,id,v[id]) end
                    count = count + 1
                else
                    for k1,v1 in ipairs(self.Messages) do
                        if v1[2] == k then
                            --print(Format("Removed message with ErrID '%s' have ID:%d, PCBK discon",v1[4],self.Messages[v1[4]]))
                            self.Messages[v1[4]] = nil
                            table.remove(self.Messages,k1)
                        end
                    end
                    table.insert(self.Log,{"DISCONN",k,Metrostroi.GetSyncTime()})
                    self.States[k] = nil
                end
            end
            self.PCBKCount = count
            if self.MessagesCount ~= #self.Messages then
                local mess = #self.Messages
                if self.MessagesCount < mess then
                    --Train:PlayOnce("igla_alarm3","cabin",nil,1)
                    self.StandbyTimer = CurTime()
                    if self.State2 ~= 1 then
                        self.State2 = 1
                        self.Selected = mess
                    end
                    if self.Selected >= self.MessagesCount then
                        self.Selected = mess
                    end
                end
                if self.State2 == 1 and self.Selected > mess then self.Selected = mess end
                if self.State2 == 1 and mess == 0 then
                    self.State2 = 0
                end
                self.MessagesCount = mess
            end

            if self.State2 == 0 then
                if self.Triggers.IGLA2 and self.Triggers.IGLA3 then
                    self.Password = ""
                    self.State2 = 2
                    self.StandbyTimer = CurTime()
                end


                self.ButtonL1 = self.MessagesCount > 0
                self.ButtonL2 = false
                self.ButtonL3 = false
                self.ButtonL4 = Standby
            elseif self.State2 == 1 then
                local err = self.Messages[self.Selected]
                Train:SetNW2String("IGLA:ErrorID",err[1])
                Train:SetNW2Int("IGLA:WagNumber",err[2])


                self.ButtonL1 = true
                self.ButtonL2 = self.Selected > 1
                self.ButtonL3 = self.Selected < #self.Messages
                Train:SetNW2Int("IGLA:MessagesCount",self.MessagesCount)
                self.ButtonL4 = false
            elseif self.State2 == 2 then
                self.ButtonL1 = true
                self.ButtonL2 = true
                self.ButtonL3 = true
                self.ButtonL4 = true
            elseif self.State2 == 3 then
                if self.Selected >= #self.Log then self.Selected = #self.Log end
                local log = self.Log[self.Selected]
                Train:SetNW2String("IGLA:LogID",log[1])
                Train:SetNW2Int("IGLA:WagNumber",log[2])
                Train:SetNW2Int("IGLA:LogDate",log[3])
                for i=4,#log do
                    Train:SetNW2Int("IGLA:Log"..i,log[i])
                end


                self.ButtonL1 = true
                self.ButtonL2 = self.Selected > 1
                self.ButtonL3 = self.Selected < #self.Log
                self.ButtonL4 = false
            end
            Train:SetNW2Int("IGLA:Count",self.PCBKCount)
            Train:SetNW2Int("IGLA:State2",self.State2)
            Train:SetNW2Bool("IGLA:Standby",Standby)
            Train:SetNW2Bool("IGLA:ShowTime",self.ShowTime)
            self.Fire = false
            self.Error = false
        end
        Train:SetNW2Bool("IGLA:Messages",self.MessagesCount)
        Train:SetNW2Bool("IGLA:ButtonL1",self.ButtonL1)
        Train:SetNW2Bool("IGLA:ButtonL2",self.ButtonL2)
        Train:SetNW2Bool("IGLA:ButtonL3",self.ButtonL3)
        Train:SetNW2Bool("IGLA:ButtonL4",self.ButtonL4)
        Train:SetNW2Bool("IGLA:Fire",self.Fire)
        Train:SetNW2Bool("IGLA:Error",self.Error)

        Train:SetNW2Int("IGLA:State",self.State)
    end
end

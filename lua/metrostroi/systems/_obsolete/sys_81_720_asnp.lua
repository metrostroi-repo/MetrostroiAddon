--------------------------------------------------------------------------------
-- Announcer and announcer-related code
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_720_ASNP")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.TriggerNames = {
        "R_ASNPMenu",
        "R_ASNPUp",
        "R_ASNPDown",
        "R_ASNPOn",
        "R_Program1",
        "R_Program2",
        --R_Announcer
        --R_Line
    }
    self.Triggers = {}

    self.State = 0

    self.Line = 1
    self.Path = false
    self.Station = 1
    self.Arrived = true

    self.RouteNumber = 0

    self.Line = 1

    self.Train:LoadSystem("R_ASNPOn","Relay","Switch",{ normally_closed = true, bass = true })
    self.Train:LoadSystem("R_ASNPMenu","Relay","Switch",{bass = true })
    self.Train:LoadSystem("R_ASNPUp","Relay","Switch",{bass = true })
    self.Train:LoadSystem("R_ASNPDown","Relay","Switch",{bass = true })
end

if TURBOSTROI then return end
function TRAIN_SYSTEM:ClientInitialize()
end
if TURBOSTROI then return end

function TRAIN_SYSTEM:Inputs()
    return {}
end

function TRAIN_SYSTEM:Outputs()
    return {}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end
if CLIENT then
    local function createFont(name,font,size)
        surface.CreateFont("Metrostroi_"..name, {
            font = font,
            size = size,
            weight = 500,
            blursize = false,
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
            scanlines = false,
        })
    end
    createFont("ASNP","Liquid Crystal Display",30,400)
    function TRAIN_SYSTEM:ClientThink()
        --RunConsoleCommand("say","президент!!!")
        if not self.DrawTimer then
        render.PushRenderTarget(self.Train.ASNP,0,0,512, 128)
            render.Clear(0, 0, 0, 0)
            render.PopRenderTarget()
        end
        if self.DrawTimer and CurTime()-self.DrawTimer < 0.1 then return end
        self.DrawTimer = CurTime()
        render.PushRenderTarget(self.Train.ASNP,0,0,512, 128)
        --render.Clear(0, 0, 0, 0)
        cam.Start2D()
            self:ASNPScreen(self.Train)
        cam.End2D()
        render.PopRenderTarget()
    end
    function TRAIN_SYSTEM:PrintText(x,y,text,inverse)
        local str = {utf8.codepoint(text,1,-1)}
        for i=1,#str do
            local char = utf8.char(str[i])
            if inverse then
                draw.SimpleText(string.char(0x7f),"Metrostroi_ASNP",(x+i)*20.5+5,y*40+40,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText(char,"Metrostroi_ASNP",(x+i)*20.5+5,y*40+40,Color(140,190,0,150),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            else
                draw.SimpleText(char,"Metrostroi_ASNP",(x+i)*20.5+5,y*40+40,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            end
        end
    end

    TRAIN_SYSTEM.LoadSeq = "/-\\|"
    function TRAIN_SYSTEM:ASNPScreen(Train)
        local State = self.Train:GetNW2Int("ASNP:State",-1)
        if State ~= 0 then
            surface.SetDrawColor(140,190,0,self.Warm and 130 or 255)
            self.Warm = true
        else
            surface.SetDrawColor(20,50,0,230)
            self.Warm = false
        end
        surface.DrawRect(0,0,512,128)
        if State == 0 then
            return
        end


        if State == -2 then
            self:PrintText(0,0,"Ошибка памяти")
            self:PrintText(0,1,"Карта не поддерживается")
            return
        end

        if State == 1 then
            self:PrintText(0,0,"Нажмиие \"MENU\"")
            self:PrintText(0 ,1,"для начала настройки")
        end
        if State > 1 and not Metrostroi.ASNPSetup then
            self:PrintText(0,0,"Client error")
            self:PrintText(0,1,"ASNPSetup nil")
            return
        end
        if State == 2 then
            local RouteNumber = Format("%02d",Train:GetNW2Int("ASNP:RouteNumber",0))
            local sel = Train:GetNW2Int("ASNP:Selected",0)
            self:PrintText(0,0,"Номер маршрута:")
            if sel == 2 then
                local timer = math.ceil(RealTime()%7.5/1.5)
                if timer == 1 then self:PrintText(4,1,"Для подтверждения")
                elseif timer == 2 then self:PrintText(6,1,"нажмите \"МЕНЮ\"")
                elseif timer == 3 then self:PrintText(6,1,"Для возврата к")
                elseif timer == 4 then self:PrintText(5,1,"предыдущей цифре")
                elseif timer == 5 then self:PrintText(4,1,"нажмите \"+\" или \"-\"") end
            else
                local timer = math.ceil(RealTime()%7.5/1.5)
                if timer == 1 then self:PrintText(5,1,"Для ввода номера")
                elseif timer == 2 then self:PrintText(4,1,"нажмите \"+\" или \"-\"")
                elseif timer == 3 then self:PrintText(6,1,"Для перехода к")
                elseif timer == 4 then self:PrintText(5,1,"следующей цифре")
                elseif timer == 5 then self:PrintText(6,1,"нажмите \"МЕНЮ\"") end
            end

            self:PrintText(0,1,RouteNumber[1],sel==0 and  RealTime()%1 > 0.5)
            self:PrintText(1,1,RouteNumber[2],sel==1 and  RealTime()%1 > 0.5)
        end

        local stbl = Metrostroi.ASNPSetup and Metrostroi.ASNPSetup[Train:GetNW2Int("Announcer",1)]
        if State > 2 and not stbl then
            self:PrintText(0,0,"Client error")
            self:PrintText(0,1,"ASNPSetup[ann] nil")
            return
        end

        if State == 3 then
            local Line = self.Train:GetNW2Int("ASNP:Line",1)
            local ltbl = stbl[Line]
            local St,En = ltbl[1],ltbl[#ltbl]
            self:PrintText(0,0,"Маршрут"..(ltbl.Loop and " ()" or ""))
            local timer = math.ceil(RealTime()%7.5/1.5)
            if timer == 1 then self:PrintText(0,1,(ltbl.Name or "Нет названия"))
            elseif timer == 2 then self:PrintText(0,1,"От:");self:PrintText(3,1,St[2]);self:PrintText(21,1,tostring(St[1]))
            elseif timer == 3 then self:PrintText(0,1,"До:");self:PrintText(3,1,En[2]);self:PrintText(21,1,tostring(En[1]))
            elseif timer == 4 then self:PrintText(4,1,"Для подтверждения")
            elseif timer == 5 then self:PrintText(6,1,"нажмите \"МЕНЮ\"") end
        end

        if State == 4 then
            local Line = Train:GetNW2Int("ASNP:Line",1)
            local ltbl = stbl[Line]
            if ltbl.Loop then
                local Path = Train:GetNW2Bool("ASNP:Path")
                self:PrintText(0,0,"Путь")
                self:PrintText(0,1,Path and "II (второй)" or " I (первый)")
            else
                local St = ltbl[Train:GetNW2Int("ASNP:FirstStation",1)]
                self:PrintText(0,0,"Начальная станция")
                self:PrintText(0,1,St[1]..":"..St[2])
            end
        end

        if State == 5 then
            local Line = Train:GetNW2Int("ASNP:Line",1)
            local ltbl = stbl[Line]
            if ltbl.Loop then
                local station = Train:GetNW2Int("ASNP:LastStation",1)
                local En = ltbl[station]
                self:PrintText(0,0,"Конечная станция")
                if station == 0 then
                    self:PrintText(0,1," ():".."Кольцевой")
                else
                    self:PrintText(0,1,En[1]..":"..En[2])
                end
            else
                local En = ltbl[Train:GetNW2Int("ASNP:LastStation",1)]
                self:PrintText(0,0,"Конечная станция")
                self:PrintText(0,1,En[1]..":"..En[2])
            end
        end

        if State == 6 then
            local Line = Train:GetNW2Int("ASNP:Line",1)
            local ltbl = stbl[Line]
            local Path = Train:GetNW2Bool("ASNP:Path")
            self:PrintText(0,0,"Проверьте данные")
            self:PrintText(18,0,Format("%02d",Line))
            self:PrintText(22,0,Path and "II" or "I")
            self:PrintText(22,1,Format("%02d",Train:GetNW2Int("ASNP:RouteNumber",0)))
            if ltbl.Loop then
                local station = Train:GetNW2Int("ASNP:LastStation",1)
                local En = ltbl[station]
                self:PrintText(20,0,"()")
                local timer = math.ceil(RealTime()%9/1.5)
                if timer == 1 then self:PrintText(0,1,"()"..(ltbl.Name or "Нет названия"))
                elseif timer == 2 and station > 0 then self:PrintText(0,1,"До:");self:PrintText(3,1,En[2]);self:PrintText(21,1,tostring(En[1]))
                elseif timer == 2 and station == 0 then self:PrintText(0,1,"До:Кольцевой")
                --elseif timer == 3 then self:PrintText(0,1,"До:");self:PrintText(3,1,En[2]);self:PrintText(21,1,tostring(En[1]))
                elseif timer == 3 then self:PrintText(2,1,"Для подтверждения")
                elseif timer == 4 then self:PrintText(4,1,"нажмите \"МЕНЮ\"")
                elseif timer == 5 then self:PrintText(6,1,"Для отмены")
                elseif timer == 6 then self:PrintText(1,1,"нажмите \"+\" или \"-\"") end
            else
                local St = ltbl[Train:GetNW2Int("ASNP:FirstStation",1)]
                local En = ltbl[Train:GetNW2Int("ASNP:LastStation",1)]
                if Path then
                    local StT = En;En=St;St=StT
                end
                local timer = math.ceil(RealTime()%10.5/1.5)
                if timer == 1 then self:PrintText(0,1,(ltbl.Name or "Нет названия"))
                elseif timer == 2 then self:PrintText(0,1,"От:");self:PrintText(3,1,St[2]);self:PrintText(21,1,tostring(St[1]))
                elseif timer == 3 then self:PrintText(0,1,"До:");self:PrintText(3,1,En[2]);self:PrintText(21,1,tostring(En[1]))
                elseif timer == 4 then self:PrintText(2,1,"Для подтверждения")
                elseif timer == 5 then self:PrintText(4,1,"нажмите \"МЕНЮ\"")
                elseif timer == 6 then self:PrintText(6,1,"Для отмены")
                elseif timer == 7 then self:PrintText(1,1,"нажмите \"+\" или \"-\"") end
            end
        end
        if State == 7 then
            local Line = Train:GetNW2Int("ASNP:Line",1)
            local ltbl = stbl[Line]

            local Path = Train:GetNW2Bool("ASNP:Path")

            local St = ltbl[Train:GetNW2Int("ASNP:FirstStation",1)]
            local En
            if Path and not ltbl.Loop then
                En = ltbl[Train:GetNW2Int("ASNP:FirstStation",1)]
            else
                En = ltbl[Train:GetNW2Int("ASNP:LastStation",1)]
            end

            local Station = ltbl[Train:GetNW2Int("ASNP:Station",1)]
            local Dep = self.Train:GetNW2Bool("ASNP:Arrived",false)


            if Dep then self:PrintText(0,0,"Отпр.") else self:PrintText(0,0,"Приб.") end
            self:PrintText(6,0,Station[2])
            --if self.Train:GetNW2Int("ASNP:Locked",0) > 1 then self:PrintText(20,0,"Бл*Л") else self:PrintText(20,0,"Пл Л") end
            if Train:GetNW2Bool("ASNP:Playing",false) then
                self:PrintText(0,1,"<<<  ИДЕТ ОБЪЯВЛЕНИЕ  >>>")
            --elseif Station == En then
            --  self:PrintText(0,1,"<<<      КОНЕЧАЯ      >>>")
            else
                --self:PrintText(0,1,string.rep("I",Path and 2 or 1))
                self:PrintText(0,1,string.format("%02d",Train:GetNW2Int("ASNP:RouteNumber",0)))
                if ltbl.Loop and Train:GetNW2Int("ASNP:LastStation",1) == 0 then
                    self:PrintText(6,1,"Кольцевой")
                else
                    self:PrintText(6,1,En[2]:upper())
                end
                --if self.Train:GetNW2Int("ASNP:Locked",0) > 1 then self:PrintText(20,1,"Бл*П") else self:PrintText(20,1,"Пл П") end
            end
        end
    end
    return
end

function TRAIN_SYSTEM:Zero()
    self.Station = self.Path and self.LastStation or self.FirstStation
    self.Arrived = true
    self:UpdateBoards()
end

function TRAIN_SYSTEM:Next()
    local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
    if tbl.Loop then
        if self.Arrived then
            if self.Path then
                self.Station = self.Station - 1
            else
                self.Station = self.Station + 1
            end
            if self.Station == 0 or self.Station > #tbl then
                self.Station = self.Station == 0 and #tbl or 1
            end
            if self.Station == 0 or self.Station > #tbl then
                self.Station = self.Station == 0 and (self.LastStation > 0 and self.LastStation or #tbl) or 1
            end
            self.Arrived = false
            --self.Station = 1
        else
            self.Arrived = true
        end
    else
        if self.Arrived then
                if self.Station ~= (self.Path and self.FirstStation or self.LastStation) then
                if self.Path then
                    self.Station = math.max(self.FirstStation,self.Station - 1)
                else
                    self.Station = math.min(self.LastStation,self.Station + 1)
                end
                self.Arrived = false
            end
        else
            self.Arrived = true
        end
    end
    self:UpdateBoards()
end
function TRAIN_SYSTEM:Prev()
    local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
    if tbl.Loop then
        if not self.Arrived then
            if self.Path then
                self.Station = self.Station + 1
            else
                self.Station = self.Station - 1
            end
            if self.Station == 0 or self.Station > #tbl then
                self.Station = self.Station == 0 and (self.LastStation > 0 and self.LastStation or #tbl) or 1
            end
            --self.Station = 1
            self.Arrived = true
        else
            self.Arrived = false
        end
    else
        if not self.Arrived then
            if self.Path then
                self.Station = math.min(self.LastStation,self.Station + 1)
            else
                self.Station = math.max(self.FirstStation,self.Station - 1)
            end
            self.Arrived = true
        else
            if self.Station ~= (self.Path and self.LastStation or self.FirstStation) then
                self.Arrived = false
            end
        end
    end
    self:UpdateBoards()
end
function TRAIN_SYSTEM:AnnQueue(msg)
        local Announcer = self.Train.Announcer
        if msg and type(msg) ~= "table" then
                Announcer:Queue{msg}
        else
                Announcer:Queue(msg)
        end
end
function TRAIN_SYSTEM:Play(dep,not_last)
    local message
    local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
    local stbl = tbl[self.Station]
    local last,lastst
    if tbl.Loop then
        last = self.LastStation
        lastst = not dep and self.LastStation > 0 and self.Station == last and tbl[last].arrlast
    else
        last = self.Path and self.FirstStation or self.LastStation
        lastst = not dep and self.Station == last and tbl[last].arrlast
    end
    if dep then
        message = stbl.dep[self.Path and 2 or 1]
    else
        if lastst then
            message = stbl.arrlast[self.Path and 2 or 1]
        else
            message = stbl.arr[self.Path and 2 or 1]
        end
    end
    self:AnnQueue{"click1"}
    self:AnnQueue(message)
    if lastst then table.insert(message,1,-1) end
    local stbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line][self.Station]
    if self.LastStation > 0 and not dep and self.Station ~= last and tbl[last].not_last and (stbl.have_inrerchange or math.abs(last-self.Station) <= 3) then
        self:AnnQueue(tbl[last].not_last)
    end
    self:AnnQueue{"click2"}
    self:UpdateBoards()
end
function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
    if sourceid == self.Train:GetWagonNumber() then return end
    if textdata == "RouteNumber" then self.RouteNumber = numdata end
    if textdata == "Path" then self.Path = numdata > 0 end
    if textdata == "Line" then self.Line = numdata end
    if textdata == "FirstStation" then self.FirstStation = numdata end
    if textdata == "LastStation" then self.LastStation = numdata end
    if textdata == "Activate" then
        local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
        self.Station = tbl.Loop and 1 or self.Path and self.LastStation or self.FirstStation
        self.Arrived = true
        self.State = 7
        local last = self.Path and not tbl.Loop and self.FirstStation or self.LastStation
        local lastst = tbl[last] and tbl[last][1]
        if lastst then self.Train:SetNW2Int("LastStation",lastst) end
        self.Train:SetNW2Int("RouteNumber",self.RouteNumber)
    end
end
function TRAIN_SYSTEM:SyncASNP()
    local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
    local last = self.Path and self.FirstStation or self.LastStation
    local lastst = tbl[last] and tbl[last][1]
    if lastst then self.Train:SetNW2Int("LastStation",lastst) end
    self.Train:SetNW2Int("RouteNumber",self.RouteNumber)
    self.Train:CANWrite("ASNP",self.Train:GetWagonNumber(),"ASNP",nil,"RouteNumber",self.RouteNumber)
    self.Train:CANWrite("ASNP",self.Train:GetWagonNumber(),"ASNP",nil,"Path",self.Path and 0 or 1)
    self.Train:CANWrite("ASNP",self.Train:GetWagonNumber(),"ASNP",nil,"Line",self.Line)
    self.Train:CANWrite("ASNP",self.Train:GetWagonNumber(),"ASNP",nil,"FirstStation",self.FirstStation)
    self.Train:CANWrite("ASNP",self.Train:GetWagonNumber(),"ASNP",nil,"LastStation",self.LastStation)
    self.Train:CANWrite("ASNP",self.Train:GetWagonNumber(),"ASNP",nil,"Activate")
end
function TRAIN_SYSTEM:UpdateBoards()
    if self.State < 7 then
        return
    end
    local BUKP = self.Train.BUKP
    local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
    local stbl = tbl.LED
    local curr = 0
    if self.Path then
        for i=#stbl,self.Station+1,-1 do curr = curr + stbl[i] end
    else
        for i=1,self.Station-1 do curr = curr + stbl[i] end
    end
    local nxt = 0
    if self.Arrived then
        curr = curr + stbl[self.Station]
    else
        nxt = stbl[self.Station]
    end
    BUKP:CState("PassSchemeCurr",curr,nil,true)
    BUKP:CState("PassSchemeArr",nxt,nil,true)
    --[[
    if Train:GetNW2Bool("PassSchemesRotated") then
        --BUKP:CState("PassSchemePath",not self.Path,nil,true)
    else
        --BUKP:CState("PassSchemePath",self.Path,nil,true)
    end]]
    BUKP:CState("PassSchemePath",self.Path,nil,true)
    BUKP:CState("TickerNext",not self.Arrived,nil,true)
    BUKP:CState("TickerCurr",tbl[self.Station][2],nil,true)
end

function TRAIN_SYSTEM:Trigger(name,value)
    local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)]
    if name == "R_Program2" and value and #self.Train.Announcer.Schedule==0 then
        if self.State ~= 7 and tbl[self.Line] and tbl[self.Line].spec_last then
            self:AnnQueue{"click1"}
            self:AnnQueue(-1)
            self:AnnQueue(tbl[self.Line].spec_last)
            self:AnnQueue{"click2"}
        elseif self.State == 7 then
            local ltbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
            local last,lastst
            if self.Arrived then
                if tbl.Loop then
                    ltbl = self.LastStation
                    lastst = self.LastStation > 0 and self.Station == last and ltbl[last].arrlast
                else
                    last = self.Path and self.FirstStation or self.LastStation
                    lastst = self.Station == last and ltbl[last].arrlast
                end
            end
            if lastst then
                self:AnnQueue{"click1"}
                self:AnnQueue(-1)
                self:AnnQueue(ltbl.spec_last)
                self:AnnQueue{"click2"}
            else
                self.StopMessage = not self.StopMessage
                self:AnnQueue{"click1"}
                self:AnnQueue(ltbl.spec_wait[self.StopMessage and 1 or 2])
                self:AnnQueue{"click2"}
            end
        end
    end
    if self.State == 1 and name == "R_ASNPMenu" and value then
        self.State = 2
        self.Selected = 0
    elseif self.State == 2 and value then
        if name == "R_ASNPMenu" then
            self.Selected = self.Selected + 1
            if self.Selected > 2 then
                self.State = 3
            end
        end
        if (name == "R_ASNPUp" or name == "R_ASNPDown") and self.Selected < 2 then
            local sel = 1-self.Selected
            local num = Format("%02d",self.RouteNumber)[self.Selected+1]
            if name == "R_ASNPUp" then if num == "9" then self.RouteNumber = self.RouteNumber - 10^sel*9 else self.RouteNumber = self.RouteNumber + 10^sel end end
            if name == "R_ASNPDown" then if num == "0" then self.RouteNumber = self.RouteNumber + 10^sel*9 else self.RouteNumber = self.RouteNumber - 10^sel end end
        end
        if (name == "R_ASNPUp" or name == "R_ASNPDown") and self.Selected == 2 then self.Selected = 0 end
    elseif self.State == 3 and value then
        if name == "R_ASNPDown" and value then
            self.Line =self.Line + 1
            if self.Line > #tbl then self.Line = 1 end
        end
        if name == "R_ASNPUp" and value then
            self.Line = math.max(1,self.Line - 1)
            if self.Line < 1 then self.Line = #tbl end
        end
        if name == "R_ASNPMenu" and value then
            if not tbl[self.Line].Loop then
                self.FirstStation = 1
            end
            self.State = 4
        end
    elseif self.State == 4 and value and not tbl[self.Line].Loop then --Не кольцевой
        local stbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
        if name == "R_ASNPDown" then
            local found = false
            for i=self.FirstStation+1,#stbl do
                if stbl[i].arrlast then self.FirstStation = i;found=true;break end
            end
            if not found then
                for i=1,#stbl do
                    if stbl[i].arrlast then self.FirstStation = i;break end
                end
            end
        end
        if name == "R_ASNPUp" then
            local found = false
            for i=self.FirstStation-1,1,-1 do
                if stbl[i].arrlast then self.FirstStation = i;found=true;break end
            end
            if not found then
                for i=#stbl,1,-1 do
                    if stbl[i].arrlast then self.FirstStation = i;break end
                end
            end
        end
        if name == "R_ASNPMenu" then
            self.State = 5
            for i=#stbl,1,-1 do
                if i ~= self.FirstStation and stbl[i].arrlast then self.LastStation = i;break end
            end
        end
    elseif self.State == 4 and value and tbl[self.Line].Loop then --Кольцевой
        if name == "R_ASNPDown" or name == "R_ASNPUp" then
            self.Path = not self.Path
        end
        if name == "R_ASNPMenu" then
            self.LastStation = 0
            self.FirstStation = 0
            self.State = 5
        end
    elseif self.State == 5 and value and not tbl[self.Line].Loop then --Не кольцевой
        local stbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
        if name == "R_ASNPDown" then
            local found = false
            for i=self.LastStation+1,#stbl do
                if i ~= self.FirstStation and stbl[i].arrlast then self.LastStation = i;found=true;break end
            end
            if not found then
                for i=1,#stbl do
                    if i ~= self.FirstStation and stbl[i].arrlast then self.LastStation = i;break end
                end
            end
        end
        if name == "R_ASNPUp" then
            local found = false
            for i=self.LastStation-1,1,-1 do
                if i ~= self.FirstStation and stbl[i].arrlast then self.LastStation = i;found=true;break end
            end
            if not found then
                for i=#stbl,1,-1 do
                    if i ~= self.FirstStation and stbl[i].arrlast then self.LastStation = i;break end
                end
            end
        end
        if name == "R_ASNPMenu" then
            self.Path = self.FirstStation > self.LastStation
            self.Station = self.FirstStation
            if self.Path then
                local first = self.LastStation
                self.LastStation = self.FirstStation
                self.FirstStation = first
            end
            self.Arrived = true
            self.State = 6
        end
    elseif self.State == 5 and value and tbl[self.Line].Loop then --Кольцевой
        local stbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
        if name == "R_ASNPDown" then
            local found = false
            for i=self.LastStation+1,#stbl do
                if stbl[i].arrlast then self.LastStation = i;found=true;break end
            end
            if not found and self.LastStation ~= 0 then
                self.LastStation = 0
            end
        end
        if name == "R_ASNPUp" then
            local found = false
            if self.LastStation == 1 then
                self.LastStation = 0
                found = true
            end
            for i=self.LastStation-1,1,-1 do
                if stbl[i].arrlast and stbl[i].arrlast[self.Path and 2 or 1] then self.LastStation = i;found=true;break end
            end
            if not found then
                for i=#stbl,1,-1 do
                    if stbl[i].arrlast and stbl[i].arrlast[self.Path and 2 or 1] then self.LastStation = i;break end
                end
            end
        end
        if name == "R_ASNPMenu" then
            self.State = 6
            self.Station = 1
            self.Arrived = true
        end
    elseif self.State == 6 and value then
        local stbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
        if name == "R_ASNPDown" or name == "R_ASNPUp" then
            self.State = 2
            self.Selected = 0
        end
        if name == "R_ASNPMenu" then
            if self.FirstStation ~= 0 then
                if self.Path then
                    self.Train.Announcer:Queue{"click1","announcer_ready",stbl[self.LastStation].arrlast[3],stbl[self.FirstStation].arrlast[3],"click2"}
                else
                    self.Train.Announcer:Queue{"click1","announcer_ready",stbl[self.FirstStation].arrlast[3],stbl[self.LastStation].arrlast[3],"click2"}
                end
            end
            self.State = 7
            self:UpdateBoards()
            self:SyncASNP()
            self.StopMessage = false
        end
    elseif self.State == 7 then
        local stbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
        if name == "R_ASNPMenu" and value then self.ReturnTimer = CurTime() end
        if name == "R_ASNPMenu" and not value and self.ReturnTimer and self.ReturnTimer - CurTime() < 0.7 then
            self.ReturnTimer = nil
        end
        if name == "R_ASNPDown" and value then self:Next() end
        if name == "R_ASNPUp" and value then self:Prev() end
        if name == "R_Program1" and value and #self.Train.Announcer.Schedule==0 then
            if self.Arrived and self.Station == (self.Path and self.FirstStation or self.LastStation) then
                self:Zero()
            end
            self:Play(self.Arrived)
            self:Next()
        end
    end
end

--States:
-- -2 - Loaded in another cab
-- -1 - Starting up
--nil - First setUp and get settings from last
--1   - Welcome Screen
--2   - Route Choose
--3   - Choose start station
--4   - Choose end station
--5   - Choose path
--6   - Choose style of playing
--7   - Normal state
--8   - Confim a settings (on last stations)
function TRAIN_SYSTEM:Think()
    local Train = self.Train
    local Power = Train.Electric.Battery80V > 62
--[[
    if self.Train.R_ZS.Value < 0.5 and self.Train.KV.ReverserPosition == 1.0 then
        Train:WriteTrainWire(47,1)
    else
        Train:WriteTrainWire(47,0)
    end
    Train:SetNW2Bool("ASNPPlay",Power and Train:ReadTrainWire(47) > 0)]]
    local ASNPWork = Power and Train.R_ASNPOn.Value > 0.5
    if not ASNPWork and self.ASNPState ~= 0 then
        self.State = 0
        self.ASNPTimer = nil
    end
    if ASNPWork and self.State == 0 then
        self.State = -1
        self.ASNPTimer = CurTime()-math.Rand(-0.3,0.3)
    end
    if self.State == -1 and self.ASNPTimer and CurTime()-self.ASNPTimer > 1 then
        self.State = Metrostroi.ASNPSetup and 1 or -2
    end
    if ASNPWork and self.State > -1  then
        for k,v in pairs(self.TriggerNames) do
            if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
                self:Trigger(v,Train[v].Value > 0.5)
                self.Triggers[v] = Train[v].Value > 0.5
            end
        end
    end
    if not Metrostroi.ASNPSetup and self.State > 0 then
        self.State = -2
    end
    if self.PassSchemeWork ~= (Train.PassScheme.Value>0 and self.State==7) then
        self:UpdateBoards()
        self.PassSchemeWork = Train.PassScheme.Value>0 and self.State==7
    end

    if self.ReturnTimer and CurTime()-self.ReturnTimer > 0.7 then
        if self.State == 7 then self.State = 6 end
        self.ReturnTimer = nil
    end
    Train:SetNW2Int("ASNP:State",self.State)
    Train:SetNW2Int("ASNP:RouteNumber",self.RouteNumber)

    Train:SetNW2Int("ASNP:Selected",self.Selected)
    Train:SetNW2Int("ASNP:Line",self.Line)
    Train:SetNW2Int("ASNP:FirstStation",self.FirstStation)
    Train:SetNW2Int("ASNP:LastStation",self.LastStation)
    Train:SetNW2Bool("ASNP:Path",self.Path)

    Train:SetNW2Bool("ASNP:Station",self.Station)
    Train:SetNW2Bool("ASNP:Arrived",self.Arrived)
    Train:SetNW2Bool("ASNP:Playing",#Train.Announcer.Schedule>0)
end

--------------------------------------------------------------------------------
-- 81-722 "Sarmat-UPO" announcer system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_722_sarmat")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("SarmatUp","Relay","Switch")
    self.Train:LoadSystem("SarmatDown","Relay","Switch")
    self.Train:LoadSystem("SarmatEnter","Relay","Switch")
    self.Train:LoadSystem("SarmatEsc","Relay","Switch")
    self.Train:LoadSystem("SarmatF1","Relay","Switch")
    self.Train:LoadSystem("SarmatF2","Relay","Switch")
    self.Train:LoadSystem("SarmatF3","Relay","Switch")
    self.Train:LoadSystem("SarmatF4","Relay","Switch")
    self.Train:LoadSystem("SarmatPath","Relay","Switch")
    self.Train:LoadSystem("SarmatLine","Relay","Switch")
    self.Train:LoadSystem("SarmatZero","Relay","Switch")
    self.Train:LoadSystem("SarmatStart","Relay","Switch")
    self.TriggerNames = {
        "SarmatUp",
        "SarmatDown",
        "SarmatEnter",
        "SarmatEsc",
        "SarmatF1",
        "SarmatF2",
        "SarmatF3",
        "SarmatF4",
        "SarmatPath",
        "SarmatLine",
        "SarmatZero",
        "SarmatStart",
    }
    self.Triggers = {}
    for k,v in pairs(self.TriggerNames) do
        if self.Train[v] then self.Triggers[v] = self.Train[v].Value > 0.5 end
    end
    self.SarmatState = 0
    self.SarmatAnnState = 1
    self.SarmatCamState = 1

    self.Line = 1
    self.Path = false
    self.Station = 1
    self.Arrived = true

    self.Selected = 0

    self.LineEnabled = false

    self.UPOActive = 0
    self.LineOut = 0
end

function TRAIN_SYSTEM:Outputs()
    return {"UPOActive","LineOut"}
end

function TRAIN_SYSTEM:Inputs()
    return {"CheckUPO"}
end
if TURBOSTROI then return end
function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "CheckUPO" then
        local UPOActive = (math.random()>0.05 and not self.Arrived or self.Arrived and not self.Depeating) and self.LineOut==0
        if UPOActive then
            if self.Arrived and not self.Depeating then
                --self.Train.BUKP.CloseRing = self.Train.BUKP.CloseRing or CurTime()+3
                self.Depeating = true
            elseif not self.Arrived then
                self.Arrived = true

                local stbl = Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer",1)]
                local stbll = stbl[self.Line]
                local last = (self.Path and not stbll.Loop) and self.StartStation or self.EndStation
                self.Last = self.Station == last
            end
            self:UpdateSarmat()
        end
        self.UPOActive = UPOActive and 1 or 0
        self.UPOLock = UPOActive and CurTime()
        return UPOActive
    end
end
TRAIN_SYSTEM.Specials = {[-4]="Еду на море",[-3]="На порезку",[-2]="Обкатка",[-1]="Перегонка",[0]="В депо"}
if SERVER then
    local function InRange(x,y,px,py,pw,ph)
        local hpw,hph = pw/2,ph/2
        return (px-hpw < x and x < px+hpw) and (py-hph < y and y < py+hph)
    end
    function TRAIN_SYSTEM:Touch(value,x,y)
        local Train = self.Train
        if self.SarmatCamState == 1 and value then
            local WagNum = #Train.WagonList
            if InRange(x,y,124,140,113,40,"Левые") then
                self.Cam1,self.Cam1E = CurTime()+math.Rand(0.4,4),Train
                self.Cam2,self.Cam2E = CurTime()+math.Rand(0.4,4),Train.WagonList[WagNum]
                self.Cam3,self.Cam4 = false,false
                self.SarmatCamState,self.SarmatCamCount,self.SarmatCamType = 2,2,1
            end
            if InRange(x,y,242,140,113,40,"Передние") then
                self.Cam1,self.Cam1E = CurTime()+math.Rand(0.4,4),Train
                self.Cam2,self.Cam2E = CurTime()+math.Rand(0.4,4),Train
                self.Cam3,self.Cam4 = false,false
                self.SarmatCamState,self.SarmatCamCount,self.SarmatCamType = 2,2,2
            end
            if InRange(x,y,360,140,113,40,"Вокруг") then
                self.Cam1,self.Cam1E = CurTime()+math.Rand(0.4,4),Train
                self.Cam2,self.Cam2E = CurTime()+math.Rand(0.4,4),Train
                self.Cam3,self.Cam3E = CurTime()+math.Rand(0.4,4),Train.WagonList[WagNum]
                self.Cam4,self.Cam4E = CurTime()+math.Rand(0.4,4),Train.WagonList[WagNum]
                self.SarmatCamState,self.SarmatCamCount,self.SarmatCamType = 4,4,3
            end
            if InRange(x,y,478,140,113,40,"Задние") then
                self.Cam1,self.Cam1E = CurTime()+math.Rand(0.4,4),Train.WagonList[WagNum]
                self.Cam2,self.Cam2E = CurTime()+math.Rand(0.4,4),Train.WagonList[WagNum]
                self.Cam3,self.Cam4 = false,false
                self.SarmatCamState,self.SarmatCamCount,self.SarmatCamType = 3,2,4
            end
            if InRange(x,y,596,140,113,40,"Правые") then
                self.Cam1,self.Cam1E = CurTime()+math.Rand(0.4,4),Train
                self.Cam2,self.Cam2E = CurTime()+math.Rand(0.4,4),Train.WagonList[WagNum]
                self.Cam3,self.Cam4 = false,false
                self.SarmatCamState,self.SarmatCamCount,self.SarmatCamType = 3,2,5
            end

            for i=1+self.Selected,math.min(WagNum,6+self.Selected) do
                if InRange(x,y,65+(i-1-self.Selected)*118+118*math.max(0,6-WagNum)/2    ,235,113,40,"Вагон "..i) then
                    self.Cam1,self.Cam1E = CurTime()+math.Rand(0.4,4),Train.WagonList[i]
                    self.Cam2,self.Cam2E = CurTime()+math.Rand(0.4,4),Train.WagonList[i]
                    self.Cam3,self.Cam3E = CurTime()+math.Rand(0.4,4),Train.WagonList[i]
                    self.Cam4,self.Cam4E = CurTime()+math.Rand(0.4,4),Train.WagonList[i]
                    self.SarmatCamState,self.SarmatCamCount,self.SarmatCamType = 5,4,6
                end
            end

            if InRange(x,y,220,350,113,40,"Вагон 1") then
                self.Cam1,self.Cam1E = CurTime()+math.Rand(0.4,4),Train
                self.Cam2,self.Cam3,self.Cam4 = false,false
                self.SarmatCamState,self.SarmatCamCount,self.SarmatCamType = 6,1,7
            end
            if InRange(x,y,500,350,113,40,"Вагон "..WagNum) then
                self.Cam1,self.Cam1E = CurTime()+math.Rand(0.4,4),Train.WagonList[WagNum]
                self.Cam2,self.Cam3,self.Cam4 = false,false
                self.SarmatCamState,self.SarmatCamCount,self.SarmatCamType = 6,1,8
            end

            if InRange(x,y,220,465,113,40,"Вагон 1") then
                self.Cam1,self.Cam1E = CurTime()+math.Rand(0.4,4),Train
                self.Cam2,self.Cam3,self.Cam4 = false,false
                self.SarmatCamState,self.SarmatCamCount,self.SarmatCamType = 7,1,9
            end
            if InRange(x,y,500,465,113,40,"Вагон "..WagNum) then
                self.Cam1,self.Cam1E = CurTime()+math.Rand(0.4,4),Train.WagonList[WagNum]
                self.Cam2,self.Cam3,self.Cam4 = false,false
                self.SarmatCamState,self.SarmatCamCount,self.SarmatCamType = 7,1,10
            end
            --surface.DrawTexturedRectRotated(110,590,200,40,0)
            --draw.SimpleText("Esc","Metrostroi_Arial20",110,590, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)


            if InRange(x,y,320,590,200,40,"<-") then
                self.Selected = math.max(self.Selected - 1,0)
            end
            if InRange(x,y,530,590,200,40,"->") then
                self.Selected = math.Clamp(self.Selected + 1,0,#Train.WagonList-6)
            end
        end
        if self.SarmatCamState > 1 and value then
            if InRange(x,y,110,590,200,40,"Esc") then
                self.SarmatCamState = 1
                self.Cam1 = false
                self.Cam2 = false
                self.Cam3 = false
                self.Cam4 = false
                self.Selected = 0
            end
        end
        Train:SetNW2Int("SarmatCamSelected",self.Selected)
    end

    function TRAIN_SYSTEM:Zero()
        local stbl = Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer",1)]
        local stbll = stbl[self.Line]
        if not stbll then
            self:UpdateSarmat()
            return
        end
        if stbll.Loop then
            self.Station = self.Path and #stbll or 1
        else
            self.Station = self.Path and self.EndStation or self.StartStation
        end
        self.Arrived = true
        self.Depeating = false
        self:UpdateSarmat()
    end

    function TRAIN_SYSTEM:Next()
        local stbl = Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer",1)]
        local stbll = stbl[self.Line]
        if not stbll then return end
        local last = (self.Path and not stbll.Loop) and self.StartStation or self.EndStation
        if stbll.Loop then
            if self.Arrived then
                if self.Path then
                    self.Station = math.max(0,self.Station - 1)
                    if self.Station <= 0 then self.Station = #stbll end
                else
                    local max = #stbll
                    if self.Station >= max then self.Station = 0 end
                    self.Station = math.min(max,self.Station + 1)
                end
                self.Arrived = false
            else
                if self.Station ~= (self.EndStation > 0 and self.EndStation or -1) then
                    self.Arrived = true
                end
            end
        else
            if self.Last then
                self.Station = self.Path and self.EndStation or self.StartStation
                self.Arrived = true
            elseif self.Arrived then
                if self.Path then
                    self.Station = math.max(self.StartStation,self.Station - 1)
                else
                    self.Station = math.min(self.EndStation,self.Station + 1)
                end
                self.Arrived = false
            else
                if self.Station ~= (self.Path and self.StartStation or self.EndStation) then
                    self.Arrived = true
                end
            end
        end
        self.Last = self.Station == last
        self.Depeating = false
        self:UpdateSarmat()
    end
    function TRAIN_SYSTEM:Prev()
        local stbl = Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer",1)]
        local stbll = stbl[self.Line]
        if not stbll then return end
        if stbll.Loop then
            if not self.Arrived then
                if self.Path then
                    if self.Station >= #stbll then self.Station = 0 end
                    self.Station = math.min(#stbll,self.Station + 1)
                else
                    self.Station = math.max(0,self.Station - 1)
                    if self.Station <= 0 then self.Station = #stbll end
                    if self.Station == self.EndStation then
                        self:Prev()
                    end
                end
                self.Arrived = true
            else
                self.Arrived = false
            end
        else
            if not self.Arrived then
                if self.Path then
                    self.Station = math.min(self.EndStation,self.Station + 1)
                else
                    self.Station = math.max(self.StartStation,self.Station - 1)
                end
                self.Arrived = true
            else
                if self.Station ~= (self.Path and self.EndStation or self.StartStation) then
                    self.Arrived = false
                end
            end
        end
        self.Last = self.Station == last
        self.Depeating = false
        self:UpdateSarmat()
    end

    function TRAIN_SYSTEM:AnnQueue(msg)
        local Announcer = self.Train.Announcer
        if msg and type(msg) ~= "table" then
            Announcer:Queue{msg}
        else
            Announcer:Queue(msg)
        end
    end

    function TRAIN_SYSTEM:Play(dep)
        local ltbl = Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
        if not ltbl then return end
        local stbl = ltbl[self.Station]
        local last = (self.Path and not ltbl.Loop) and self.StartStation or self.EndStation
        local lastst = self.Station == last
        if dep then
            local message = stbl.dep[self.Path and 2 or 1]
            if message and not lastst then
                self.Train.Announcer:TriggerInput("Reset","AnnouncementsSarmatUPO")
                self:AnnQueue("tone")
                if stbl.odz then self:AnnQueue(stbl.odz) end
                self:AnnQueue(message)
            end
        else
            local message
            if lastst then
                message = stbl.arrlast[self.Path and 2 or 1]
            else
                message = stbl.arr[self.Path and 2 or 1]
            end
            if message then
                self.Train.Announcer:TriggerInput("Reset","AnnouncementsSarmatUPO")
                self:AnnQueue("tone")
                if lastst and not stbl.ignorelast then self:AnnQueue(-1) end
                self:AnnQueue(message)
            end
        end
        self.Last = lastst
        self:UpdateSarmat()
    end

    function TRAIN_SYSTEM:UpdateSarmat()
        if not self.Active then return end
        local tbl = Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
        if not tbl then
            self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"PassSchemes",nil,"Current",0)
            self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"PassSchemes",nil,"Arrival",32)
            self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"PassSchemes",nil,"Path",self.Path)

            self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"Prev",self.Specials[self.Line])
            self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"PrevEn",false)
            self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"Next",self.Specials[self.Line])
            self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"NextEn",false)
            self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"NextRight",false)
            self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"Curr",self.Specials[self.Line])
            self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"CurrEn",false)
            self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"CurrRight",false)
            self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"Arrived",true)
            self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"Last",false)
            self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"Closing",false)
            if self.Specials[self.Line] then
                self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"Special","%g"..self.Specials[self.Line].."\n%r"..self.Specials[self.Line])
            end
            return
        end
        local stbl = tbl.LED
        local last = self.Path and self.FirstStation or self.LastStation

        local curr=0
        if self.Path then
            for i=#stbl,self.Station+(self.Depeating and 0 or 1),-1 do curr = curr + stbl[i] end
        else
            for i=1,self.Station-(self.Depeating and 0 or 1) do curr = curr + stbl[i] end
        end
        local nxt = 0
        if self.Arrived and not self.Depeating then
            curr = curr + stbl[self.Station]
        else
            nxt = stbl[self.Station]
        end
        self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"PassSchemes",nil,"Current",curr)
        self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"PassSchemes",nil,"Arrival",nxt)
        self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"PassSchemes",nil,"Path",self.Path)

        local curr,prev,nxt = tbl[self.Station],tbl[self.Station-(self.Path and -1 or 1)],tbl[self.Station-(self.Path and 1 or -1)]
        if not self.Arrived then prev = curr nxt = curr end
        self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"Prev",prev and prev[2])
        self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"PrevEn",prev and prev[3])
        self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"Next",nxt and nxt[2])
        self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"NextEn",nxt and nxt[3])
        self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"NextRight",nxt and nxt.right_doors)
        self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"Curr",curr and curr[2])
        self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"CurrEn",curr and curr[3])
        self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"CurrRight",curr and curr.right_doors)
        self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"Arrived",self.Arrived and not self.Depeating)
        self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"Last",self.Last)
        self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"Closing",self.Depeating)
        self.Train:CANWrite("Sarmat",self.Train:GetWagonNumber(),"Tickers",nil,"Special",not self.Last and (self.Arrived and (self.Depeating and curr.messagedep or not self.Depeating and curr.messagearr) or not self.Arrived and prev.messagedep))
    end

    function TRAIN_SYSTEM:Trigger(name,value)
        local Train = self.Train
        if self.SarmatAnnState == 1 then
            if name == "SarmatZero" and value then
                self:Zero()
                if self.ZeroTimer then
                    if CurTime()-self.ZeroTimer < 0.3 then self.SarmatAnnState = 2 end
                    self.ZeroTimer = nil
                end
                if not self.ZeroTimer then self.ZeroTimer = CurTime() end
            end
            if name == "SarmatLine" and value then
                self.LineEnabled = not self.LineEnabled
            end
            if name == "SarmatStart" and value and self.LineOut==0 then
                if not self.Arrived then
                    self:Play(false)
                elseif self.Arrived then
                    self:Play(true)
                end
            end
            local stbl = Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer",1)]
            if name == "SarmatPath" and value then
                self.Path = not self.Path
                if not stbl[self.Line] then
                    self.LastStationName = self.Specials[self.Line]
                elseif self.EndStation == 0 then
                    self.LastStationName = "Кольцевой"
                else
                    self.LastStationName = stbl[self.Line][self.Path and not stbl[self.Line].Loop and self.StartStation or self.EndStation][2]
                end
                self:Zero()
            end
            if name == "SarmatF1" and value and stbl[self.Line] then
                self.SarmatAnnState = 3
                self.Select = 1
            end
            if name == "SarmatF2" and value and stbl[self.Line] then
                self.SarmatAnnState = 4
                self.Select = 1
            end
            if name == "SarmatF3" and value and stbl[self.Line] then
                self.SarmatAnnState = 5
                self.Select = 1
            end
            if name == "SarmatF4" and value then
                self.SarmatAnnState = 6
                self.Select = 1
            end
            if name == "SarmatDown" and value then
                self:Next()
            end
            if name == "SarmatUp" and value then
                self:Prev()
            end
        end
        if self.SarmatAnnState == 2 then
            local stbl = Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer",1)]
            if name == "SarmatDown" and value then
                self.Line = math.min(#stbl,self.Line + 1)
            end
            if name == "SarmatUp" and value then
                self.Line = math.max(-4,self.Line - 1)
            end
            if name == "SarmatEnter" and value then
                self.SarmatAnnState = 1
                self.StartStation = 1
                if stbl[self.Line] then
                    if stbl[self.Line].Loop then
                        self.EndStation = 0
                    else
                        self.EndStation = #stbl[self.Line]
                    end
                    if self.EndStation == 0 then
                        self.LastStationName = "Кольцевой"
                    else
                        self.LastStationName = stbl[self.Line][self.Path and not stbl[self.Line].Loop and self.StartStation or self.EndStation][2]
                    end
                else
                    self.EndStation = 0
                    self.LastStationName = self.Specials[self.Line]
                end
                self:Zero()
            end
        end
        if self.SarmatAnnState == 3 then
            local stbl = Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer",1)]
            local stbll = stbl[self.Line]
            if name == "SarmatDown" and value then
                for i=self.Select+1,#stbll do
                    if i==1 or i==#stbll or stbll[i].arrlast then
                        self.Select = i
                        break
                    end
                end
            end
            if name == "SarmatUp" and value then
                local selected = false
                for i=self.Select-1,1,-1 do
                    if i==1 or i==#stbll or stbll[i].arrlast then
                        self.Select = i
                        selected = true
                        break
                    end
                end
                if stbll.Loop and not selected then
                    self.Select = 0
                end
            end
            if name == "SarmatF1" and value and not stbll.Loop then
                if self.Select < self.EndStation then
                    self.StartStation = self.Select
                    self.LastStationName = stbl[self.Line][self.Path and not stbl[self.Line].Loop and self.StartStation or self.EndStation][2]
                    self:Zero()
                end
            end
            if name == "SarmatF2" and value then
                if self.Select > self.StartStation or stbll.Loop then
                    self.EndStation = self.Select
                    if self.EndStation == 0 then
                        self.LastStationName = "Кольцевой"
                    else
                        self.LastStationName = stbl[self.Line][self.Path and not stbl[self.Line].Loop and self.StartStation or self.EndStation][2]
                    end
                    self:Zero()
                end
            end
            if (name == "SarmatEnter" or name == "SarmatEsc") and value then
                self.SarmatAnnState = 1
                self:Zero()
            end
        end
        if self.SarmatAnnState == 4 then
            if (name == "SarmatEnter" or name == "SarmatEsc") and value then
                self.SarmatAnnState = 1
            end
        end
        if self.SarmatAnnState == 5 then
            if (name == "SarmatEnter" or name == "SarmatEsc") and value then
                self.SarmatAnnState = 1
            end
        end
        if self.SarmatAnnState == 6 then
            if (name == "SarmatEnter" or name == "SarmatEsc") and value then
                self.SarmatAnnState = 1
            end
        end
        Train:SetNW2Int("SarmatSelect",self.Select)
    end
    function TRAIN_SYSTEM:Think(dT)
        local Train = self.Train
        local Power = Train.Electric.Power > 0 and Train.SF17.Value > 0

        if not Power and self.SarmatState ~= 0 then
            self.SarmatState = 0
            self.SarmatTimer = nil
        end
        if Power and self.SarmatState == 0 then
            self.SarmatState = -1
            self.SarmatTimer = CurTime()-math.Rand(-0.5,1)
            self.SarmatAnnState = 1
            self.SarmatCamState = 1
            self.Cam1,self.Cam1E = false,NULL
            self.Cam2,self.Cam2E = false,NULL
            self.Cam3,self.Cam3E = false,NULL
            self.Cam4,self.Cam4E = false,NULL
            self.Selected = 0
            Train:SetNW2Int("SarmatCamSelected",self.Selected)
        end
        if self.SarmatState == -1 and self.SarmatTimer and CurTime()-self.SarmatTimer > 2 then
            self.SarmatState = -2
            self.SarmatTimer = CurTime()-math.Rand(-0.5,1.5)
        end
        if self.SarmatState == -2 and self.SarmatTimer and CurTime()-self.SarmatTimer > 14 then
            self.SarmatState = -3
            self.SarmatTimer = CurTime()-math.Rand(-0.3,0.5)
        end
        if self.SarmatState == -3 and self.SarmatTimer and CurTime()-self.SarmatTimer > 1 then
            if Metrostroi.SarmatUPOSetup and Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer",1)] then
                self.SarmatState = 1
            else
                self.SarmatState = -4
                return
            end

            local stbl = Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer",1)]
            self.StartStation = self.StartStation or 1
            if stbl[self.Line].Loop then
                self.EndStation = self.EndStation or 0
            else
                self.EndStation = self.EndStation or #stbl[self.Line]
            end
            if self.EndStation == 0 then
                self.LastStationName = "Кольцевой"
            else
                self.LastStationName = stbl[self.Line][self.Path and not stbl[self.Line].Loop and self.StartStation or self.EndStation][2]
            end
            self:Zero()
        end
        if self.SarmatState > 0 and Train.BUKP.Active > 0 then
            if self.SarmatCamState > 1 then
                Train:SetNW2Int("SarmatCamType",self.SarmatCamType)
                local cam1,cam2,cam3,cam4 = false,false,false,false
                for i=1,#Train.WagonList do
                    local train = Train.WagonList[i]
                    if self.Cam1 and self.Cam1E == train then cam1 = true end
                    if self.Cam2 and self.Cam2E == train then cam2 = true end
                    if self.Cam3 and self.Cam3E == train then cam3 = true end
                    if self.Cam4 and self.Cam4E == train then cam4 = true end
                end
                if self.Cam1 == true and (not IsValid(self.Cam1E) or not cam1) then self.Cam1 = false end
                if self.Cam2 == true and (not IsValid(self.Cam2E) or not cam2) then self.Cam2 = false end
                if self.Cam3 == true and (not IsValid(self.Cam3E) or not cam3) then self.Cam3 = false end
                if self.Cam4 == true and (not IsValid(self.Cam4E) or not cam4) then self.Cam4 = false end
                if self.Cam1 == true then
                    Train:SetNW2Bool("SarmatCam1C",true)
                    Train:SetNW2Entity("SarmatCam1E",self.Cam1E)
                else
                    if self.Cam1 and self.Cam1 ~= true and CurTime()-self.Cam1 > 0 then self.Cam1 = true end
                    Train:SetNW2Bool("SarmatCam1C",false)
                end
                if IsValid(self.Cam1E) then Train:SetNW2Int("SarmatCam1EN",self.Cam1E:GetWagonNumber()) end
                if self.Cam2 == true then
                    Train:SetNW2Bool("SarmatCam2C",true)
                    Train:SetNW2Entity("SarmatCam2E",self.Cam2E)
                else
                if self.Cam2 and self.Cam2 ~= true and CurTime()-self.Cam2 > 0 then self.Cam2 = true end
                    Train:SetNW2Bool("SarmatCam2C",false)
                end
                if IsValid(self.Cam2E) then Train:SetNW2Int("SarmatCam2EN",self.Cam2E:GetWagonNumber()) end
                if self.Cam3 == true then
                    Train:SetNW2Bool("SarmatCam3C",true)
                    Train:SetNW2Entity("SarmatCam3E",self.Cam3E)
                else
                if self.Cam3 and self.Cam3 ~= true and CurTime()-self.Cam3 > 0 then self.Cam3 = true end
                    Train:SetNW2Bool("SarmatCam3C",false)
                end
                if IsValid(self.Cam3E) then Train:SetNW2Int("SarmatCam3EN",self.Cam3E:GetWagonNumber()) end
                if self.Cam4 == true then
                    Train:SetNW2Bool("SarmatCam4C",true)
                    Train:SetNW2Entity("SarmatCam4E",self.Cam4E)
                else
                if self.Cam4 and self.Cam4 ~= true and CurTime()-self.Cam4 > 0 then self.Cam4 = true end
                    Train:SetNW2Bool("SarmatCam4C",false)
                end
                if IsValid(self.Cam4E) then Train:SetNW2Int("SarmatCam4EN",self.Cam4E:GetWagonNumber()) end
                Train:SetNW2Int("SarmatCamC",self.SarmatCamCount)
            end


            Train:SetNW2Int("SarmatCamState",self.SarmatCamState)
        else
            Train:SetNW2Int("SarmatCamState",0)
            Train:SetNW2Bool("SarmatCam1C",false)
            Train:SetNW2Bool("SarmatCam2C",false)
            Train:SetNW2Bool("SarmatCam3C",false)
            Train:SetNW2Bool("SarmatCam4C",false)
        end
        if self.SarmatState > 0 and Train.BUKP.Active > 0 then
            if not self.Active then self.Active = true self:UpdateSarmat()  end
            for k,v in pairs(self.TriggerNames) do
                if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
                    self:Trigger(v,Train[v].Value > 0.5)
                    --print(v,self.Train[v].Value > 0.5)
                    self.Triggers[v] = Train[v].Value > 0.5
                end
            end
            local OpenDoors = Train.BUKP.OpenLeft or Train.BUKP.OpenRight
            local CloseDoors = not not Train.BUKP.CloseRing
            local UPOPlaying = self.UPOActive>0 and Train.UPO.LineOut>0
            if not self.Depeating and (OpenDoors or UPOPlaying) and not self.Arrived then
                self.Arrived = true
                if self.UPOActive==0 then self:Play(false) end
            end
            if OpenDoors and self.Depeating then
                self.Depeating = false
                self:UpdateSarmat()
            end
            if self.Arrived and (CloseDoors~=self.CloseDoors and CloseDoors or UPOPlaying) then
                --local ltbl = Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
                if self.UPOActive==0 and not self.Depeating then
                    self.Depeating = true
                    self:Play(true)
                end
                --self:UpdateSarmat()
            end
            self.CloseDoors = CloseDoors
            if self.UPOActive>0 and not UPOPlaying and (not self.UPOLock or CurTime()-self.UPOLock)>0.5 then
                self.UPOActive = 0
                self.UPOLock = false
            end
            if self.Depeating and Train.BUKP.Speed>3 then
                self:Next()
            end
        else
            if self.Depeating then
                self:Next()
            end
            self.UPOActive = 0
            self.UPOLock = false
            self.CloseDoors = false
            self.Active = false
            --self.CloseTimer = CurTime()
        end
        Train:SetNW2Bool("SarmatMonitor",Train.Electric.Power>0 and Train.SF16.Value > 0)
        Train:SetNW2Int("SarmatState",self.SarmatState)
        Train:SetNW2Int("WagNum",#Train.WagonList)

        Train:SetNW2Int("SarmatAnnState",self.SarmatAnnState)

        Train:SetNW2Int("SarmatLine",self.Line)
        Train:SetNW2Bool("SarmatPath",self.Path)
        Train:SetNW2Int("SarmatStation",self.Station)
        Train:SetNW2Bool("SarmatStationArr",self.Arrived)

        Train:SetNW2Bool("SarmatLineEnabled",self.LineEnabled)

        Train:SetNW2Int("SarmatStartStation",self.StartStation)
        Train:SetNW2Int("SarmatEndStation",self.EndStation)

        local Ann = Train.Announcer
        self.LineOut = (Ann.AnnTable=="AnnouncementsSarmatUPO" and Ann.AnnounceTimer) and 1 or 0
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
    --createFont("BUKPSpeed","Eurostar Metrostroi",80)
    createFont("Arial15","Arial",15,800)
    createFont("Arial20","Arial",20,800)
    createFont("Arial22","Arial",22,400)
    createFont("Arial25","Arial",25,400)
    createFont("Arial30","Arial",30,400)
    local ubuntu_load = surface.GetTextureID("models/metrostroi_train/81-722/screens/sarmat_upo/ubuntu_load")
    local button = surface.GetTextureID("models/metrostroi_train/81-722/screens/sarmat_upo/button")



    function TRAIN_SYSTEM:ClientInitialize()
        self.Cam1 = self.Train:CreateRT("720SarmatC1",256,256,true)
        self.Cam2 = self.Train:CreateRT("720SarmatC2",256,256,true)
        self.Cam3 = self.Train:CreateRT("720SarmatC3",256,256,true)
        self.Cam4 = self.Train:CreateRT("720SarmatC4",256,256,true)
    end
    local CamRT = surface.GetTextureID( "pp/rt" )
    local CamRTM = Material( "pp/rt" )
    local SarPos = Vector(470,41,-6)
    function TRAIN_SYSTEM:ClientThink()
        if not self.Train:ShouldDrawPanel("Sarmat") then return end
        local train = self.Train
        local state = train:GetNW2Int("SarmatState",0)
        local camstate = train:GetNW2Int("SarmatCamState",1)
        local Cam1,Cam1E = train:GetNW2Bool("SarmatCam1C"),train:GetNW2Entity("SarmatCam1E")
        local Cam2,Cam2E = train:GetNW2Bool("SarmatCam2C"),train:GetNW2Entity("SarmatCam2E")
        local Cam3,Cam3E = train:GetNW2Bool("SarmatCam3C"),train:GetNW2Entity("SarmatCam3E")
        local Cam4,Cam4E = train:GetNW2Bool("SarmatCam4C"),train:GetNW2Entity("SarmatCam4E")
        if state > 0 then
            if camstate == 2 then
                if Cam1 then Metrostroi.RenderCamOnRT(train,SarPos,"Cam1",math.Rand(0.2,0.5),self.Cam1,Cam1E,Vector(425,65,40),Angle(5,180-5,0),256,256,2,64,64) end
                if Cam2 then Metrostroi.RenderCamOnRT(train,SarPos,"Cam2",math.Rand(0.2,0.5),self.Cam2,Cam2E,Vector(425,-65,40),Angle(5,180+5,0),256,256,2,64,64) end
            end
            if camstate == 3 then
                if Cam1 then Metrostroi.RenderCamOnRT(train,SarPos,"Cam1",math.Rand(0.2,0.5),self.Cam1,Cam1E,Vector(425,-65,40),Angle(5,180+5,0),256,256,2,64,64) end
                if Cam2 then Metrostroi.RenderCamOnRT(train,SarPos,"Cam2",math.Rand(0.2,0.5),self.Cam2,Cam2E,Vector(425,65,40),Angle(5,180-5,0),256,256,2,64,64) end
            end
            if camstate == 4 then
                if Cam1 then Metrostroi.RenderCamOnRT(train,SarPos,"Cam1",math.Rand(0.2,0.5),self.Cam1,Cam1E,Vector(425,65,40),Angle(5,180-5,0),256,256,2,64,64) end
                if Cam2 then Metrostroi.RenderCamOnRT(train,SarPos,"Cam2",math.Rand(0.2,0.5),self.Cam2,Cam2E,Vector(425,-65,40),Angle(5,180+5,0),256,256,2,64,64) end
                if Cam3 then Metrostroi.RenderCamOnRT(train,SarPos,"Cam3",math.Rand(0.2,0.5),self.Cam3,Cam3E,Vector(425,-65,40),Angle(5,180+5,0),256,256,2,64,64) end
                if Cam4 then Metrostroi.RenderCamOnRT(train,SarPos,"Cam4",math.Rand(0.2,0.5),self.Cam4,Cam4E,Vector(425,65,40),Angle(5,180-5,0),256,256,2,64,64) end
            end
            if camstate == 5 then
                if Cam1 then Metrostroi.RenderCamOnRT(train,SarPos,"Cam1",math.Rand(0.2,0.5),self.Cam1,Cam1E,Vector(360,-45,30),Angle(15,180-15,0),256,256,1) end
                if Cam2 then Metrostroi.RenderCamOnRT(train,SarPos,"Cam2",math.Rand(0.2,0.5),self.Cam2,Cam2E,Vector(360,45,30),Angle(15,180+15,0),256,256,1) end
                if Cam3 then Metrostroi.RenderCamOnRT(train,SarPos,"Cam3",math.Rand(0.2,0.5),self.Cam3,Cam3E,Vector(-360,-45,30),Angle(15,15,0),256,256) end
                if Cam4 then Metrostroi.RenderCamOnRT(train,SarPos,"Cam4",math.Rand(0.2,0.5),self.Cam4,Cam4E,Vector(-360,45,30),Angle(15,-15,0),256,256) end
            end
            if camstate == 6 then
                if Cam1 then Metrostroi.RenderCamOnRT(train,SarPos,"Cam1",math.Rand(0.2,0.5),self.Cam1,Cam1E,Vector(408,35,37),Angle(25,-15,0),256,256,1) end
            end
            if camstate == 7 then
                if Cam1 then Metrostroi.RenderCamOnRT(train,SarPos,"Cam1",math.Rand(0.2,0.5),self.Cam1,Cam1E,Vector(490,6,-7),Angle(0,0,0),256,256,1) end
            end
        end
        --debugoverlay.Sphere(self.Train:LocalToWorld(Vector(425,-65,46)),2,1,Color( 255, 255, 255 ),true)
        render.PushRenderTarget(self.Train.Sarmat,0,0,1024, 1024)
        render.Clear(0, 0, 0, 0)
        cam.Start2D()
            surface.SetDrawColor(0,0,0)
            surface.DrawRect(0,0,1024,640)
            self:SarmatMonitor(self.Train)
        cam.End2D()
        render.PopRenderTarget()
    end

    local function drawButton(x,y,w,h,text)
        surface.DrawTexturedRectRotated(x,y,w,h,0)
        draw.SimpleText(text,"Metrostroi_Arial20",x,y, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end
    local names = {
        "Левые камеры",
        "Передние камеры",
        "Все левые/правые камеры",
        "Задние камеры",
        "Правые камеры",
        "Салонные камеры",
        "Камера на посте машиниста",
        "Камера на посте машиниста",
        "Путевая камера",
        "Путевая камера",
    }
    local types = {
        {"Левая камера 1 вагона","Левая камера %d вагона"},
        {"Левая камера 1 вагона","Правая камера 1 вагона"},
        {"Левая камера 1 вагона","Правая камера 1 вагона","Левая камера %d вагона","Правая камера %d вагона"},
        {"Левая камера %d вагона","Правая камера %d вагона"},
        {"Правая камера 1 вагона","Правая камера %d вагона"},
        {"Передняя правая камера салона","Передняя левая камера салона","Задняя правая камера салона","Задняя левая камера салона"},
        {"Камера кабины 1 вагона"},
        {"Камера кабины %d вагона"},
        {"Путевая камера 1 вагона"},
        {"Путевая камера %d вагона"},
    }
    local inverts = {
        {true,false},
        {true,true},
        {true,true,false,false},
        {false,false},
        {true,false},
        {true,true,false,false},
        {false},
        {false},
        {false},
        {false},
    }
    --SarmatCam2T
    function TRAIN_SYSTEM:SarmatMonitor(Train)
        local state = Train:GetNW2Int("SarmatState",0)
        local annstate = Train:GetNW2Int("SarmatAnnState",1)
        local camstate = Train:GetNW2Int("SarmatCamState",1)
        local WagNum = Train:GetNW2Int("WagNum",0)
        if not Train:GetNW2Bool("SarmatMonitor") then return end
        if state == -2 then
            surface.SetDrawColor(255,255,255)
            surface.DrawRect(0,0,1024,640)
            surface.SetDrawColor(220,83,13)
            surface.DrawRect(450+math.ceil(CurTime()%4-1)*32,341,6,6)
            surface.SetTexture(ubuntu_load)
            surface.SetDrawColor(255,255,255)
            surface.DrawTexturedRectRotated(512,512,1024,1024,0)
        elseif state == 1 then
            surface.SetDrawColor(15,15,15)
            surface.DrawRect(0,0,1024,640)

            local line = Train:GetNW2Int("SarmatLine")
            local path = Train:GetNW2Bool("SarmatPath")
            local station = Train:GetNW2Int("SarmatStation",1)
            local stationarr = Train:GetNW2Bool("SarmatStationArr")

            local st = Train:GetNW2Int("SarmatStartStation")
            local en = Train:GetNW2Int("SarmatEndStation")

            local lineenabled = Train:GetNW2Bool("SarmatLineEnabled")
            local sel = Train:GetNW2Int("SarmatSelect",1)
            local stbl = Metrostroi.SarmatUPOSetup[Train:GetNW2Int("Announcer",1)]
            Metrostroi.DrawRectOutline(820,5,96,26,lineenabled and Color(0,200,0) or Color(50,50,50),3)
            draw.SimpleText("ЛИНИЯ","Metrostroi_Arial15",868,17, lineenabled and Color(0,200,0) or Color(50,50,50),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            Metrostroi.DrawRectOutline(916,5,96,26,Color(200,200,200),3)
            draw.SimpleText("ПУТЬ "..(path and 2 or 1),"Metrostroi_Arial15",964,17, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

            if annstate == 1 then
                local ann = stbl[line]


                --render.DrawTextureToScreenRect(self.Cam3,0,260,260,260)
                --render.DrawTextureToScreenRect(self.Cam4,260,260,260,260)
                if not ann then
                    draw.SimpleText(Format("Линия: -%s-",self.Specials[line]),"Metrostroi_Arial20",870,60, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                else
                    draw.SimpleText(Format("Линия: %s-%s%s",ann[1][2],ann[#ann][2],ann.Loop and "[кол]" or ""),"Metrostroi_Arial20",870,60, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    local count = stationarr and 0.5 or 1
                    local last
                    if ann.Loop then
                        last =  path and station-16 or 16+station
                    else
                        last = (path and st or en)
                    end
                    for i=station,last,path and -1 or 1 do
                        i = (i-1)%(#ann)+1
                        local stat = ann[i]
                        if ann.Loop and en > 0 and count > 1 and i == en+(path and -1 or 1) then
                            break
                        end
                        if ann.Loop or (path and i < station or i > station) or not stationarr then
                            if count > 9 and stationarr then
                                draw.SimpleText("...","Metrostroi_Arial22",760,30+count*54, Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                                break
                            elseif count >= 1 then
                                draw.SimpleText(stat[2],"Metrostroi_Arial22",760,30+count*54, Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                            end
                        end
                        if count > 8 and not stationarr then
                            draw.SimpleText("...","Metrostroi_Arial22",760,57+count*54, Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                            break
                        end
                        if (path and not ann.Loop and i~=st or (not path or ann.Loop and en > 0) and i~=en or ann.Loop and en == 0) then
                            draw.SimpleText(stat[2].." отпр.","Metrostroi_Arial22",760,57+count*54, Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                        else
                            draw.SimpleText(stat[2].." кон.","Metrostroi_Arial22",760,57+count*54, Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                        end
                        count = count + 1
                    end
                end
            end
            if annstate == 2 then
                draw.SimpleText("Выбор линии:","Metrostroi_Arial20",870,60, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                for cline=-4,#stbl do
                    if cline>0 then
                        local ann = stbl[cline]
                        draw.SimpleText(Format("%s-%s%s",ann[1][2],ann[#ann][2],ann.Loop and "[кол]" or ""),"Metrostroi_Arial22",760,60+(cline+5)*30, cline == line and Color(80,120,150) or Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    else
                        draw.SimpleText(Format("-%s-",self.Specials[cline]),"Metrostroi_Arial22",760,60+(cline+5)*30, cline == line and Color(80,120,150) or Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    end
                end
            end
            if annstate == 3 then
                draw.SimpleText("Выбор начальной и конечной:","Metrostroi_Arial20",870,60, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                local count = stbl[line].Loop and 2 or 1
                if stbl[line].Loop then
                    draw.SimpleText("Кольцевой","Metrostroi_Arial22",760,60+30, 0 == sel and Color(80,120,150) or Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    if en == 0 then
                        draw.SimpleText("К","Metrostroi_Arial22",750,60+30, Color(200,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                    end
                end
                for i=1,#stbl[line] do
                    local ann = stbl[line][i]
                    if i==1 or i==#stbl[line] or ann.arrlast then
                        draw.SimpleText(ann[2],"Metrostroi_Arial22",760,60+count*30, i == sel and Color(80,120,150) or Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                        if not stbl[line].Loop and st==i then
                            draw.SimpleText("Н","Metrostroi_Arial22",750,60+count*30, Color(0,200,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        elseif en == i then
                            draw.SimpleText("К","Metrostroi_Arial22",750,60+count*30, Color(200,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        end
                        count = count + 1
                    end
                end
            end

            surface.SetDrawColor(127,127,127)
            surface.SetTexture(button)
            if camstate == 0 then
                draw.SimpleText("Система видеонаблюдения","Metrostroi_Arial25",360  ,25, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText("Не активна","Metrostroi_Arial20",360,85, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            end
            if camstate == 1 then
                local selected = Train:GetNW2Int("SarmatCamSelected",0)
                draw.SimpleText("Система видеонаблюдения","Metrostroi_Arial25",360  ,25, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText("Наружные камеры","Metrostroi_Arial20",360,85, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                drawButton(124,140,113,40,"Левые")
                draw.SimpleText("Вагон 1","Metrostroi_Arial20",235,106, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                drawButton(242,140,113,40,"Передние")
                draw.SimpleText("Все вагоны","Metrostroi_Arial20",360,106, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                drawButton(360,140,113,40,"Вокруг")
                draw.SimpleText("Вагон "..WagNum,"Metrostroi_Arial20",485,106, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                drawButton(478,140,113,40,"Задние")
                drawButton(596,140,113,40,"Правые")

                draw.SimpleText("Камеры в салоне","Metrostroi_Arial20",360,200, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                for i=1+selected,math.min(WagNum,6+selected) do
                    drawButton(65+(i-1-selected)*118+118*math.max(0,6-WagNum)/2 ,235,113,40,"Вагон "..i)
                end

                draw.SimpleText("Камеры на постах машиниста","Metrostroi_Arial20",360,315, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                drawButton(220,350,113,40,"Вагон 1")
                drawButton(500,350,113,40,"Вагон "..WagNum)

                draw.SimpleText("Путевые камеры","Metrostroi_Arial20",360,430, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                drawButton(220,465,113,40,"Вагон 1")
                drawButton(500,465,113,40,"Вагон "..WagNum)
                --surface.DrawTexturedRectRotated(110,590,200,40,0)
                --draw.SimpleText("Esc","Metrostroi_Arial20",110,590, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                if selected ~= 0 then drawButton(320,590,200,40,"<-") end
                if 6+selected < WagNum then drawButton(530,590,200,40,"->") end
                --render.DrawTextureToScreenRect(self.Cam1,15,50,690,510)
            end
            if camstate > 1 then
                local camtype = Train:GetNW2Int("SarmatCamType")
                draw.SimpleText(names[camtype] or "Система видеонаблюдения","Metrostroi_Arial25",15 ,25, Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                local CamCount = Train:GetNW2Int("SarmatCamC")
                local Cam1 = Train:GetNW2Bool("SarmatCam1C")
                local Cam2 = Train:GetNW2Bool("SarmatCam2C")
                local Cam3 = Train:GetNW2Bool("SarmatCam3C")
                local Cam4 = Train:GetNW2Bool("SarmatCam4C")
                if CamCount > 0 then
                    local invert = inverts[camtype][1]
                    local w,h = 340,250
                    if CamCount < 2 then w = 690 end
                    if CamCount < 3 then h = 510 end
                    if Cam1 then
                        surface.SetDrawColor(255,255,255,255)
                        if invert then render.DrawTextureToScreenRect(self.Cam1,15+w,50,-w,h) else render.DrawTextureToScreenRect(self.Cam1,15,50,w,h) end
                        draw.SimpleText("связь","Metrostroi_Arial20",15+w-5,50+h-10, Color(50,200,50),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
                    else
                        surface.SetDrawColor(0,0,0,255)
                        surface.DrawRect(15,50,w,h)
                        draw.SimpleText("Подключение к камере...","Metrostroi_Arial30",15+w/2,50+h/2, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        draw.SimpleText("нет связи","Metrostroi_Arial20",15+w-5,50+h-10, Color(200,50,50),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
                    end
                    draw.SimpleText("[1]"..Format(types[camtype][1],WagNum),"Metrostroi_Arial20",15+5,50+10, Color(200,150,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    draw.SimpleText(Format("Вагон №%d",Train:GetNW2Int("SarmatCam1EN")),"Metrostroi_Arial20",15+5,50+30, Color(200,150,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    Metrostroi.DrawRectOutline(15,50,w,h,Color(40,40,40),2)
                end
                if CamCount > 1 then
                    local h = 250
                    if CamCount < 3 then h = 510 end
                    if Cam2 then
                        local invert = inverts[camtype][2]
                        surface.SetDrawColor(255,255,255,255)
                        if invert then render.DrawTextureToScreenRect(self.Cam2,340+15+10+340,50,-340,h) else render.DrawTextureToScreenRect(self.Cam2,340+15+10,50,340,h) end
                        draw.SimpleText("связь","Metrostroi_Arial20",365+340-5,50+h-10, Color(50,200,50),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
                    else
                        surface.SetDrawColor(0,0,0,255)
                        surface.DrawRect(340+15+10,50,340,h)
                        draw.SimpleText("Подключение к камере...","Metrostroi_Arial30",365+340/2,50+h/2, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        draw.SimpleText("нет связи","Metrostroi_Arial20",365+340-5,50+h-10, Color(200,50,50),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
                    end
                    draw.SimpleText("[2]"..Format(types[camtype][2],WagNum),"Metrostroi_Arial20",365+5,50+10, Color(200,150,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    draw.SimpleText(Format("Вагон №%d",Train:GetNW2Int("SarmatCam2EN")),"Metrostroi_Arial20",365+5,50+30, Color(200,150,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    Metrostroi.DrawRectOutline(340+15+10,50,340,h,Color(40,40,40),2)
                end
                if CamCount > 2 then
                    if Cam3 then
                        local invert = inverts[camtype][3]
                        surface.SetDrawColor(255,255,255,255)
                        if invert then render.DrawTextureToScreenRect(self.Cam3,15+340,50+250+10,-340,250) else render.DrawTextureToScreenRect(self.Cam3,15,50+250+10,340,250) end
                        draw.SimpleText("связь","Metrostroi_Arial20",15+340-5,300+250, Color(50,200,50),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
                    else
                        surface.SetDrawColor(0,0,0,255)
                        surface.DrawRect(15,50+250+10,340,250)
                        draw.SimpleText("Подключение к камере...","Metrostroi_Arial30",15+340/2,310+250/2, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        draw.SimpleText("нет связи","Metrostroi_Arial20",15+340-5,300+250, Color(200,50,50),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
                    end
                    draw.SimpleText("[3]"..Format(types[camtype][3],WagNum),"Metrostroi_Arial20",15+5,310+10, Color(200,150,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    draw.SimpleText(Format("Вагон №%d",Train:GetNW2Int("SarmatCam3EN")),"Metrostroi_Arial20",15+5,310+30, Color(200,150,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    Metrostroi.DrawRectOutline(15,50+250+10,340,250,Color(40,40,40),2)
                end
                if CamCount > 3 then
                    local invert = inverts[camtype][4]
                    if Cam4 then
                        surface.SetDrawColor(255,255,255,255)
                        if invert then render.DrawTextureToScreenRect(self.Cam4,340+15+10+340,50+250+10,-340,250) else render.DrawTextureToScreenRect(self.Cam4,340+15+10,50+250+10,340,250) end
                        draw.SimpleText("связь","Metrostroi_Arial20",365+340-5,300+250, Color(50,200,50),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
                    else
                        surface.SetDrawColor(0,0,0,255)
                        surface.DrawRect(340+15+10,50+250+10,340,250)
                        draw.SimpleText("Подключение к камере...","Metrostroi_Arial30",365+340/2,310+250/2, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                        draw.SimpleText("нет связи","Metrostroi_Arial20",365+340-5,300+250, Color(200,50,50),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
                    end
                    draw.SimpleText("[4]"..Format(types[camtype][4],WagNum),"Metrostroi_Arial20",365+5,310+10, Color(200,150,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    draw.SimpleText(Format("Вагон №%d",Train:GetNW2Int("SarmatCam4EN")),"Metrostroi_Arial20",365+5,310+30, Color(200,150,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    Metrostroi.DrawRectOutline(340+15+10,50+250+10,340,250,Color(40,40,40),2)
                end
                surface.SetDrawColor(127,127,127)
                surface.SetTexture(button)
                drawButton(110,590,200,40,"Esc")
                --drawButton(320,590,200,40,"<-")
                --drawButton(530,590,200,40,"->")
            end
            --surface.SetTexture( self.Cam1 )
            --surface.SetDrawColor( 255, 0, 0, 255 )
            --[[



            --]
            --[[
            render.DrawTextureToScreenRect(self.Cam1,15,50,340,510)
            render.DrawTextureToScreenRect(self.Cam2,340+15+10,50,340,510)--]]
            --[[
            for i=1,#Metrostroi.WorkingStations[line] do
                local st = Metrostroi.WorkingStations[line][i]
                draw.SimpleText(Metrostroi.AnnouncerTranslate[st],"Metrostroi_Arial25",760,80+i*30, Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            end]]
            --draw.SimpleText("Блок неактивен","Metrostroi_Arial25",870,100, Color(200,200,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
        if state ~= 0 then
            surface.SetDrawColor(0,0,20,100)
            surface.DrawRect(0,0,1024,640)
        end
    end
end

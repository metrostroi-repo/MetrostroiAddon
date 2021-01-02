--------------------------------------------------------------------------------
-- RRI announcer and announcer-related code for 81-70*/81-71* trains
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_71_RRI")
TRAIN_SYSTEM.DontAccelerateSimulation = true
function TRAIN_SYSTEM:Initialize(tbl)
    self.LineOut = 0

    self.TriggerNames = {
        "RRIAmplifier",
        "R_Program1",
        "R_Program2",
        "R_Program1H",
        "R_Program2H",
        "SB10",
        "SB11",
        "SB20",
        "SB21",
    }
    self.Triggers = {}

    self.State = 0

    self.Selected = 0
    self.AnnTable = tbl

    self.Arrived = true
    if not self.Train.RRIEnable then
        self.Train:LoadSystem("RRIEnable","Relay","Switch",{bass = true})
        self.Train:LoadSystem("RRIRewind","Relay","Switch",{bass = true,maxvalue=2,defaultvalue=1})
        self.Train:LoadSystem("RRIAmplifier","Relay","Switch",{bass = true})
    end
end

if TURBOSTROI then return end

function TRAIN_SYSTEM:Inputs()
    return {"Disable","Up","Down","Left","Right"}
end

function TRAIN_SYSTEM:Outputs()
    return {"LineOut"}
end

if CLIENT then
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
    createFont("Arial10","Arial",10,400)
    createFont("Arial11","Arial",11,400)
    createFont("Arial13","Arial",13,400)
    createFont("Arial15","Arial",15,400)
    createFont("Arial15B","Arial",15,800)
    createFont("Arial20","Arial",20,800)
    function TRAIN_SYSTEM:Draw(Train)
        local line = Train:GetNW2Int("RRI:Line",-1)
        local rriL = self.CurrentTable and self.CurrentTable[line]

        if not rriL then
            draw.DrawText("No cassete","Metrostroi_Arial13",10,0,Color(255,100,50))
            return
        end
        local firststation = rriL[Train:GetNW2Int("RRI:FirstStation",-1)]
        local laststation = rriL[Train:GetNW2Int("RRI:LastStation",-1)]
        local currstation = rriL[Train:GetNW2Int("RRI:Station",-1)]
        local arrived = Train:GetNW2Bool("RRI:Arrived")

        local selected = Train:GetNW2Int("RRI:Selected",0)
        draw.SimpleText("▪","Metrostroi_Arial20",5,5+selected*10,Color(100,200,50),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        draw.SimpleText(Format("Ln [%d] %s",line,rriL.NameEn or rriL.Name),"Metrostroi_Arial13",10,5,Color(200,100,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        if firststation then
            draw.SimpleText(Format("FSt[%d] %s",firststation[1],firststation[3] or firststation[2]),"Metrostroi_Arial13",10,15,Color(200,100,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        else
            draw.SimpleText("FSt ERR","Metrostroi_Arial13",10,15,Color(200,100,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end
        if laststation then
            draw.SimpleText(Format("LSt[%d] %s",laststation[1],laststation[3] or laststation[2]),"Metrostroi_Arial13",10,25,Color(200,100,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        else
            draw.SimpleText("LSt ERR","Metrostroi_Arial13",10,25,Color(200,100,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end
        if currstation then
            draw.SimpleText(Format("CSt[%d] %s",currstation[1],currstation[3] or currstation[2]),"Metrostroi_Arial13",10,35,Color(200,100,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        else
            draw.SimpleText("CSt ERR","Metrostroi_Arial13",10,35,Color(200,100,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end
        draw.SimpleText(arrived and "Depeating" or "Arriving","Metrostroi_Arial13",10,45,Color(200,100,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText("Controls:","Metrostroi_Arial13",60,55,Color(200,100,50),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        draw.SimpleText("▲","Metrostroi_Arial13",30,60,Color(200,100,50),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        draw.SimpleText("▼","Metrostroi_Arial13",30,80,Color(200,100,50),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        draw.SimpleText("◄","Metrostroi_Arial13",20,70,Color(200,100,50),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        draw.SimpleText("►","Metrostroi_Arial13",40,70,Color(200,100,50),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        if not Train:GetPackedBool("RRIOn") then
            draw.DrawText("Block is inactive","Metrostroi_Arial13",10,85,Color(255,50,50))
        end
    end
    function TRAIN_SYSTEM:ClientThink()
        if not self.DrawTimer then
            render.PushRenderTarget(self.Train.RRIScreen,0,0,128, 128)
            render.Clear(0, 0, 0, 0)
            render.PopRenderTarget()
        end
        if not self.Train:ShouldDrawPanel("RRIScreen") or self.DrawTimer and CurTime()-self.DrawTimer < 0.1 then return end

        if self.Announcer ~= self.Train:GetNW2Int("Announcer",-1) then
            if self.AnnTable then
                self.Announcer = self.Train:GetNW2Int("Announcer",-1)
                self.CurrentTable = self.AnnTable[self.Announcer]
            else
                self.CurrentTable = Metrostroi.RRISetup
            end
        end
        self.DrawTimer = CurTime()
        render.PushRenderTarget(self.Train.RRIScreen,0,0,121, 103)
        render.Clear(0, 0, 0, 0)
        cam.Start2D()
            self:Draw(self.Train)
        cam.End2D()
        render.PopRenderTarget()
    end

    function TRAIN_SYSTEM:ClientInitialize(tbl)
        self.AnnTable = tbl
    end
    return
end

function TRAIN_SYSTEM:Zero()
    self.Station = self.Path and self.LastStation or self.FirstStation
    self.Arrived = true
end

function TRAIN_SYSTEM:Next()
    local tbl = self.CurrentTable[self.Train:GetNW2Int("Announcer",1)][self.Line]
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
end
function TRAIN_SYSTEM:Prev()
    local tbl = self.CurrentTable[self.Train:GetNW2Int("Announcer",1)][self.Line]
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
end
function TRAIN_SYSTEM:AnnQueue(msg)
    local Announcer = self.Train.Announcer
    if msg and type(msg) ~= "table" then
        Announcer:Queue{msg}
    else
        Announcer:Queue(msg)
    end
end
function TRAIN_SYSTEM:Play()
    local message
    local tbl = self.CurrentTable[self.Line]
    local stbl = tbl[self.Station]
    local last = self.LastStation
    local lastst

    local path = self.FirstStation > self.LastStation
    if tbl.Loop then
        lastst = not self.Arrived and self.LastStation > 0 and self.Station == last and tbl[last].arrlast
    else
        lastst = not self.Arrived and self.Station == last and tbl[last].arrlast
    end
    if self.Arrived then
        message = stbl.dep[path and 2 or 1]
    else
        if lastst then
            message = stbl.arrlast[path and 2 or 1]
        else
            message = stbl.arr[path and 2 or 1]
        end
    end
    self:AnnQueue{0.5,"click_start","buzz_start",0.6}
    if lastst and not stbl.ignorelast then self:AnnQueue(-1) end
    self:AnnQueue(message)
    --local stbl = self.CurrentTable[self.Train:GetNW2Int("Announcer",1)][self.Line][self.Station]
    if self.LastStation > 0 and not self.Arrived and self.Station ~= last and tbl[last].not_last and (stbl.have_inrerchange or math.abs(last-self.Station) <= 3) then
        self:AnnQueue(tbl[last].not_last)
    end
    self:AnnQueue{2,"click_end","buzz_end",0.3}
    --self:UpdateBoards()
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "Disable" then
        self.Disable = value>0
        if self.Disable then self:Initialize() end
    end
    if self.Disable or value~=1 then return end
    local rri = self.CurrentTable
    if name == "Down" and self.Selected < 3 then
        self.Selected = self.Selected + 1
        self.Train:SetNW2Int("RRI:Selected",self.Selected)
    end
    if name == "Up" and self.Selected > 0 then
        self.Selected = self.Selected - 1
        self.Train:SetNW2Int("RRI:Selected",self.Selected)
    end
    if name == "Left" or name == "Right" then
        local rriL = rri[self.Line]
        if self.Selected == 0 then
            if name == "Right" then
                self.Line = self.Line+1
                if self.Line > #rri then self.Line = 1 end
            end
            if name == "Left" then
                self.Line = self.Line-1
                if self.Line < 1 then self.Line = #rri end
            end
            self.FirstStation = 0
            self.LastStation = #rri[self.Line]+1

            repeat
                self.FirstStation = self.FirstStation + 1
                if self.FirstStation > #rriL then self.FirstStation = 1 end
            until (not rriL[self.FirstStation] or rriL[self.FirstStation].arrlast)-- and self.FirstStation ~= self.LastStation
            repeat
                self.LastStation = self.LastStation - 1
                if self.LastStation < 1 then self.LastStation = #rriL end
            until (not rriL[self.LastStation] or rriL[self.LastStation].arrlast) and self.LastStation ~= self.FirstStation

            self.Arrived = true
        end

        if self.Selected == 1 then
            if name == "Right" then
                repeat
                    self.FirstStation = self.FirstStation + 1
                    if self.FirstStation > #rriL then self.FirstStation = 1 end
                until (not rriL[self.FirstStation] or rriL[self.FirstStation].arrlast)-- and self.FirstStation ~= self.LastStation
            end
            if name == "Left" then
                repeat
                    self.FirstStation = self.FirstStation - 1
                    if self.FirstStation < 1 then self.FirstStation = #rriL end
                until (not rriL[self.FirstStation] or rriL[self.FirstStation].arrlast)-- and self.FirstStation ~= self.LastStation
            end
            self.Station = self.FirstStation
            self.Arrived = true

            self.LastStation = #rri[self.Line]+1
            repeat
                self.LastStation = self.LastStation - 1
                if self.LastStation < 1 then self.LastStation = #rriL end
            until (not rriL[self.LastStation] or rriL[self.LastStation].arrlast)
            if self.FirstStation==self.LastStation then
                self.LastStation = 0
                repeat
                    self.LastStation = self.LastStation + 1
                    if self.LastStation > #rriL then self.LastStation = 1 end
                until (not rriL[self.LastStation] or rriL[self.LastStation].arrlast) and self.LastStation ~= self.FirstStation
            end
        end
        if self.Selected == 2 then
            if name == "Right" then
                repeat
                    self.LastStation = self.LastStation + 1
                    if self.LastStation > #rriL then self.LastStation = 1 end
                until (not rriL[self.LastStation] or rriL[self.LastStation].arrlast) and self.LastStation ~= self.FirstStation
            end
            if name == "Left" then
                repeat
                    self.LastStation = self.LastStation - 1
                    if self.LastStation < 1 then self.LastStation = #rriL end
                until (not rriL[self.LastStation] or rriL[self.LastStation].arrlast) and self.LastStation ~= self.FirstStation
            end
        end
        if self.Selected == 3 then
            if name == "Right" then
                if self.Station == self.LastStation then
                    self.Arrived = true
                    self.Station = self.FirstStation
                elseif not self.Arrived then
                    self.Arrived = true
                else
                    if self.FirstStation > self.LastStation then
                        self.Station = self.Station - 1
                    else
                        self.Station = self.Station + 1
                    end
                    self.Arrived = false
                end
            end
            if name == "Left" then
                if self.Station == self.FirstStation then
                    self.Arrived = false
                    self.Station = self.LastStation
                elseif self.Arrived then
                    self.Arrived = false
                else
                    if self.FirstStation > self.LastStation then
                        self.Station = self.Station + 1
                    else
                        self.Station = self.Station - 1
                    end
                    self.Arrived = true
                end
            end
        end
    end
end

function TRAIN_SYSTEM:Trigger(name,value)
    if self.Power and (name == "R_Program1" or name == "R_Program1H" or name == "SB10" or name == "SB20") and self.LineOut==0  and value > 0 then
        self:Play()
        if self.Station == self.LastStation then
            self.Arrived = true
            self.Station = self.FirstStation
        elseif not self.Arrived then
            self.Arrived = true
        else
            if self.FirstStation > self.LastStation then
                self.Station = self.Station - 1
            else
                self.Station = self.Station + 1
            end
            self.Arrived = false
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
    if self.Disable then return end
    local Train = self.Train
    local VV = Train.RRI_VV
    self.Power = VV.Power > 0

    for k,v in pairs(self.TriggerNames) do
        if Train[v] and Train[v].Value ~= self.Triggers[v] then
            self:Trigger(v,Train[v].Value)
            self.Triggers[v] = Train[v].Value
        end
    end
    if self.Announcer ~= self.Train:GetNW2Int("Announcer",-1) then
        self.Announcer = self.Train:GetNW2Int("Announcer",-1)
        if self.AnnTable then
            self.CurrentTable = self.AnnTable[self.Announcer]
        else
            self.CurrentTable = Metrostroi.RRISetup
        end
        if self.CurrentTable and self.CurrentTable[1] then
            self.Line = 1

            self.FirstStation = 1
            self.LastStation = #self.CurrentTable[self.Line]
            self.Station = self.FirstStation
        else
            self.Line = -1

            self.FirstStation = -1
            self.LastStation = -1
            self.Station = -1
        end
    end
    Train:SetNW2Int("RRI:Line",self.Line)
    Train:SetNW2Int("RRI:FirstStation",self.FirstStation)
    Train:SetNW2Int("RRI:LastStation",self.LastStation)
    Train:SetNW2Int("RRI:Station",self.Station)
    Train:SetNW2Bool("RRI:Arrived",self.Arrived)

    self.LineOut = #Train.Announcer.Schedule>0 and 1 or 0
end

--------------------------------------------------------------------------------
-- 81-722 tickers
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_722_Tickers")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
end

function TRAIN_SYSTEM:Outputs()
    return {}
end

function TRAIN_SYSTEM:Inputs()
    return {}
end
if TURBOSTROI then return end
function TRAIN_SYSTEM:TriggerInput(name,value)
end
if SERVER then
    function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
        if textdata=="Arrived" then
            if self.Arrived ~= numdata then
                self.TimerRand = math.Rand(-10,10)
                self.Arrived = numdata
            end
        else
            self[textdata]=numdata
        end
    end
    function TRAIN_SYSTEM:Think(dT)
        local Train = self.Train
        local Power = Train.Panel.PassSchemePowerL>0 and Train.Panel.PassSchemePowerR>0
        if Power then
            if not self.TimerRand then self.TimerRand = math.Rand(-10,10) end
            Train:SetNW2Int("TickersRandom",self.TimerRand*10)
            Train:SetNW2String("TickersPrev",self.Prev or "")
            Train:SetNW2String("TickersPrevEn",self.PrevEn or "")
            Train:SetNW2String("TickersNext",self.Next or "")
            Train:SetNW2Bool("TickersNextRight",self.NextRight)
            Train:SetNW2String("TickersNextEn",self.NextEn or "")
            Train:SetNW2String("TickersCurr",self.Curr or "")
            Train:SetNW2String("TickersCurrEn",self.CurrEn or "")
            Train:SetNW2Bool("TickersCurrRight",self.CurrRight)
            Train:SetNW2Bool("TickersArrived",self.Arrived or "")
            Train:SetNW2Bool("TickersLast",self.Last)
            Train:SetNW2Bool("TickersClosing",self.Closing)
            Train:SetNW2String("TickersSpecial",self.Special or "")
        elseif self.TimerRand then
            self.TimerRand = nil
        end
        Train:SetNW2Bool("TickersPower",Power)
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
    --createFont("Arial15","Arial",15,800)
    --createFont("Arial20","Arial",20,800)
    --createFont("Arial22","Arial",22,400)
    --createFont("Arial40","Arial",30,400)
    createFont("TNR30","Times new roman",30,400)
    createFont("TNR60","Times new roman",60,400)

    function TRAIN_SYSTEM:ClientInitialize()
        self.TimerCorrection = 0
    end
    function TRAIN_SYSTEM:ClientThink()
        if not self.Train:ShouldDrawPanel("Tickers") then return end
        local train = self.Train
        render.PushRenderTarget(self.Train.Tickers,0,0,1024, 128)
        render.Clear(0, 0, 0, 0)
        cam.Start2D()
            surface.SetDrawColor(0,0,0)
            surface.DrawRect(0,0,600,128)
            self:Tickers(self.Train)
        cam.End2D()
        render.PopRenderTarget()
    end

    --SarmatCam2T
    function TRAIN_SYSTEM:Tickers(Train)
        surface.SetDrawColor(0,0,0,80)
        surface.DrawRect(0,0,600,128)
        local state = Train:GetNW2Bool("TickersPower",false)
        if state then
            local arr = Train:GetNW2Bool("TickersArrived")
            local last = Train:GetNW2Bool("TickersLast")
            local closing = Train:GetNW2Bool("TickersClosing")
            local nxt,nxtEn,nxtR = Train:GetNW2String("TickersNext",""),Train:GetNW2String("TickersNextEn",""),Train:GetNW2Bool("TickersNextRight")
            local prev = Train:GetNW2String("TickersPrev",""),Train:GetNW2String("TickersPrevEn","")
            local curr,currEn,currR = Train:GetNW2String("TickersCurr",""),Train:GetNW2String("TickersCurrEn",""),Train:GetNW2Bool("TickersCurrRight")
            local special = Train:GetNW2String("TickersSpecial","")
            local str = ""
            if (arr or closing) and last then
                str = Format("Поезд прибыл\nна конечную станцию\n%s",curr or "...")
                if currR then str = str..",\nвыход на правую сторону" end
                if currEn~="" then
                    str=str..Format("\nTrain arrived\nto last station\n%s",currEn)
                    if currR then str = str..",\nexit to the right side" end
                end
            elseif arr then
                str = curr or "..."
                if currR then str = str..",\nвыход на правую сторону" end
                if currEn~="" then
                    str = str.."\n%y"..currEn.." station"
                    if currR then str = str..",\nexit to the right side" end
                end

                str = str..Format("\nСледующая станция\n%s",nxt)
                if nxtR then str = str..",\nвыход на правую сторону" end
                if special~="" then
                    if special:sub(1,2) == "%c" then str = str.."," end
                    str = str.."\n"..special
                end
                if nxtEn~="" then
                    str = str..Format("\n%%yNext station is\n%s",nxtEn)
                    if nxtR then str = str..",\nexit to the right side" end
                end
            elseif not arr and (self.Closing or closing) then
                str = Format("%%rДвери закрываются\n%%yСледующая станция\n%s",nxt)
                if nxtR then str = str..",\nвыход на правую сторону" end
                if nxtEn~="" then
                    str = str..Format("\nNext station is\n%s",nxtEn)
                    if nxtR then str = str..",\nexit to the right side" end
                end
                if special~="" then
                    str = str.."\n"..special
                end
            else
                str = "."
            end
            local tbl = string.Explode("\n",str)

            local otime = CurTime()+Train:GetNW2Int("TickersRandom",0)/10
            if self.OldArr ~= arr then
                self.OldArr = arr
                self.TimerCorrection = -otime
            end
            local ctime = otime+self.TimerCorrection
            local time = math.floor(ctime%(#tbl*3)/3)+1
            if not self.Closing and closing and time>1 then self.Closing = true end
            if time==1 and not closing and self.Closing then
                self.Closing = false
            end
            local message = tbl[time]
            if message:find("%%y") or time==1 then self.Color = nil end
            if message:find("%%r") then self.Color = Color(220,65,85) end
            if message:find("%%g") then self.Color = Color(50,120,80) end
            draw.SimpleText(message:gsub("%%[rgyc]",""),"Metrostroi_TNR60",300,64, self.Color or Color(245,235,170),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            --local prevStation = stbl[line][path and st+1 or st-1]
            if arr and prev~="" then draw.SimpleText("< "..prev,"Metrostroi_TNR30",10,16, Color(200,200,200),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            --local nextStation = stbl[line][path and st-1 or st+1]
            if nxt~="" then draw.SimpleText(nxt.." >","Metrostroi_TNR30",586,16, Color(200,200,200),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER) end
        end
    end
end

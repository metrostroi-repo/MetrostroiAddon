--------------------------------------------------------------------------------
-- 81-722 BIT-20 system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_722_BIT")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.State = 0
    self.Data = {
        Left = "< ",
        Right = " >",
        TextStr = "---",
        Text = {"---"},
        Loop = 1
    }
    self.TextTimer = 0
    -- self.DopText = "---"
    self.ShowTime = false
    if not TURBOSTROI then
        self.IP = self.Train:GetWagonNumber()%255
    end
end

function TRAIN_SYSTEM:Outputs()
    return {}
end

function TRAIN_SYSTEM:Inputs()
    return {}
end
if TURBOSTROI then return end

local function setBitValue(targetVar, value, offset, bitCount)
    value = bit.band(value,bit.lshift(1,bitCount)-1)
    return bit.bor(targetVar,bit.lshift(value,offset))
end

local function getBitValue(value, offset, bitCount)
    local mask = bit.lshift(bit.lshift(1,bitCount)-1,offset)
    return bit.rshift(bit.band(value,mask),offset)
end

TRAIN_SYSTEM.CAN_ACTIVATE  = 0x01
TRAIN_SYSTEM.CAN_CIKSTATE  = 0x02

TRAIN_SYSTEM.CAN_BMTS_TEXT = 0x10

TRAIN_SYSTEM.CAN_CURR      = 0x21
TRAIN_SYSTEM.CAN_NEXT      = 0x22
TRAIN_SYSTEM.CAN_PATH      = 0x23
TRAIN_SYSTEM.CAN_CLOSERING = 0x24
TRAIN_SYSTEM.CAN_VOLUMES   = 0x25
TRAIN_SYSTEM.CAN_SPEED     = 0x26

TRAIN_SYSTEM.CAN_BITTEXT   = 0x30
TRAIN_SYSTEM.CAN_BITDOPMSG = 0x31
TRAIN_SYSTEM.CAN_BITTIME   = 0x32

if SERVER then
    function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
        if self.State < 1 then return end
        if textdata == self.CAN_ACTIVATE then
            self.State = 1
            self.CurrentShowIndex = 1
        end
        if textdata == self.CAN_BITTEXT then
            self.TextTimer = CurTime()-1
            self.Data.Text = numdata.Text
            self.Data.Left  = numdata.Left  or "< "
            self.Data.Right = numdata.Right or " >"
            self.Data.Loop = numdata.Loop or 1
            self.CurrentShowIndex = 0
        end
        if textdata == self.CAN_BITTIME then
           self.ShowTime = numdata
        end
    end
    function TRAIN_SYSTEM:Think(dT)
        local Train = self.Train
        local Power = Train.Panel.PassSchemePowerL>0 or Train.Panel.PassSchemePowerR>0
        if Power then
            if self.State > 0 then
                if self.State == 1 then
                    if CurTime() > self.TextTimer then
                        self.TextTimer = CurTime()+math.Rand(2,2.2)
                        self.CurrentShowIndex = self.CurrentShowIndex + 1
                        if self.CurrentShowIndex > #self.Data.Text then
                            self.CurrentShowIndex = self.Data.Loop
                        end

                        Train:SetNW2String("BIT:Text",self.Data.Text[self.CurrentShowIndex])
                        Train:SetNW2String("BIT:TextLeft",self.Data.Left)
                        Train:SetNW2String("BIT:TextRight",self.Data.Right)
                    end
                    
                elseif self.State == 2 then
                    if CurTime() > self.TextTimer then
                        self.TextTimer = CurTime()+2.1
                        self.ShowIP = not self.ShowIP
                    end

                    local ip = 0
                    ip = setBitValue(ip,self.ShowIP and 1 or 0,0,1)
                    ip = setBitValue(ip,self.IP,1,8)
                    Train:SetNW2Int("BIT:IP",ip)
                end
                Train:SetNW2Bool("BIT:Time",self.ShowTime)
            elseif self.State < 0 then
                if self.LoadingTimer and CurTime() > self.LoadingTimer then
                    if self.State == -3 then
                        self.State = -2
                        self.LoadingTimer = CurTime()+math.Rand(3,4)
                    elseif self.State == -2 then
                        self.State = -1
                        self.LoadingTimer = CurTime()+math.Rand(9,11)
                    elseif self.State == -1 then
                        self.State = 2
                        self.TextTimer = CurTime()+2
                        self.ShowIP = true
                        self.LoadingTimer = nil
                    end
                end
            else
                self.State = -3
                self.LoadingTimer = CurTime()+math.Rand(1,3)
            end
        else
            if self.State ~= 0 then
                self.State = 0
                self.Data = {
                    Left = "< ",
                    Right = " >",
                    TextStr = "---",
                    Text = {"---"},
                    Loop = 1
                }
                self.CurrentShowIndex = 1
                self.TextTimer = 0
                -- self.DopText = "---"
            end
        end
        
        Train:SetNW2Int("BIT:State",self.State)
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

    local function drawText(text,x,y,xalign,yalign)
        if (xalign or yalign) then
            local w,h = surface.GetTextSize( text )
            if (xalign == TEXT_ALIGN_CENTER) then
                x = x - w / 2
            elseif (xalign == TEXT_ALIGN_RIGHT) then
                x = x - w
            end
    
            if (yalign == TEXT_ALIGN_CENTER) then
                y = y - h / 2
            elseif (yalign == TEXT_ALIGN_BOTTOM) then
                y = y - h
            end
        end
        surface.SetTextPos(x,y)
        surface.DrawText(text)
    end

    createFont("BIT1","Ubuntu Condensed",54)
    createFont("BIT2","Liberation Serif",103)
    createFont("BIT3","Liberation Serif",30)

    local tDay = {"пн","вт","ср","чт","пт","сб","вс"}
	local tMonth = {"янв","фев","мар","апр","мая","июня","июля","авг","сен","окт","ноя","дек"}

    function TRAIN_SYSTEM:ClientInitialize()
    end
    function TRAIN_SYSTEM:ClientThink()
        if not self.Train:ShouldDrawPanel("BIT1") then return end
        render.PushRenderTarget(self.Train.BITScr,0,0,1024, 256)
        render.Clear(0, 0, 0, 0)
        cam.Start2D()
            self:BIT(self.Train)
        cam.End2D()
        render.PopRenderTarget()
    end

    local white = Color(255,255,255)
    local yellow = Color(255,235,100)
    local green = Color(50,120,50)
    local red = Color(255,65,85)
    local blue = Color(40,60,255)

    local fontTop = "Metrostroi_BIT1"
    local fontMain = "Metrostroi_BIT2"
    local fontBottom = "Metrostroi_BIT3"
    function TRAIN_SYSTEM:BIT(Train)
        local state = Train:GetNW2Int("BIT:State",0)
        if state == 0 then return end
        surface.SetDrawColor(20,10,20)
        surface.DrawRect(0,0,1024,192)

        if state > 0 then
            local showTime = Train:GetNW2Bool("BIT:Time")
            local leftHeaderText = Train:GetNW2String("BIT:TextLeft","< ")
            local rightHeaderText = Train:GetNW2String("BIT:TextRight"," >")
            
            if state == 1 then
                local bitText = Train:GetNW2String("BIT:Text","---")
                local yellowText = bitText:find("%%y")
                local greenText = bitText:find("%%g")
                local redText = bitText:find("%%r")
                local blueText = bitText:find("%%b")
                surface.SetFont(fontMain)
                if yellowText then
                    surface.SetTextColor(yellow:Unpack())
                    bitText = bitText:sub(yellowText+2)
                elseif greenText then
                    surface.SetTextColor(green:Unpack())
                    bitText = bitText:sub(greenText+2)
                elseif redText then
                    surface.SetTextColor(red:Unpack())
                    bitText = bitText:sub(redText+2)
                elseif blueText then
                    surface.SetTextColor(blue:Unpack())
                    bitText = bitText:sub(blueText+2)
                else
                    surface.SetTextColor(white:Unpack())
                end
                
                drawText(bitText,512,48,TEXT_ALIGN_CENTER)
                
                -- TODO: Задел на предупредительные сообщения
                draw.SimpleText("---",fontBottom,512,168, white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            elseif state == 2 then
                local ipNW2 = Train:GetNW2Int("BIT:IP",0)
                local showIP = getBitValue(ipNW2,0,1) > 0
                local IP = getBitValue(ipNW2,1,8)

                draw.SimpleText(showIP and "ip = 192.168.5."..IP or "ООО “НПП “Сармат”",fontMain,512,100,yellow,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

                draw.SimpleText("Продукция ООО “НПП “Сармат”",fontBottom,501,168, Color(50,120,50),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
                draw.SimpleText("* (с) 2014-2022, г. Ростов-на-Дону",fontBottom,508,168,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            end

            local leftHeaderBorder = draw.SimpleText(leftHeaderText,fontTop,0,26,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            local rightHeaderBorder = 1024-draw.SimpleText(rightHeaderText,fontTop,1024,26,white,TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
            
            if showTime then
                local d = os.date("!*t",Metrostroi.GetSyncTime())
                local time = Format("%d %s, %s, %02d:%02d",d.day,tMonth[d.month],tDay[d.wday],d.hour,d.min)
                local timeW = surface.GetTextSize(time)
                local timeX = math.max(math.min(512-timeW/2,rightHeaderBorder-timeW-8),leftHeaderBorder+8)
                surface.SetTextColor(yellow:Unpack())
                drawText(time,timeX,-1)
            end
        elseif state == -2 then
            surface.SetDrawColor(255,255,255)
            surface.DrawRect(0,0,1024,192)
        
        end
        
    end
end

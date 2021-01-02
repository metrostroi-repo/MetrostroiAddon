--------------------------------------------------------------------------------
-- 81-720 tickers
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_720_Ticker")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
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
    function TRAIN_SYSTEM:ClientInitialize()
    end
  local function createFont(name,font,size)
    surface.CreateFont("Metrostroi_"..name, {
        font = font,
        size = size,
        weight = 400,
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
  createFont("Tickers","Advanced LED Board-7",49,400)
  function TRAIN_SYSTEM:ClientThink()
        local str = self.Train:GetNW2String("TickerMessage","")
        local pos = self.Train:GetNW2Int("TickerState",0)
        if self.Train:ShouldDrawPanel("Tickers") and (self.Text ~= str or self.Position ~= pos) then
            self.Text = str
            self.Position = pos
            render.PushRenderTarget(self.Train.Tickers,0,0,852, 64)
            render.Clear(0, 0, 0, 0)
            cam.Start2D()
                self:Tickers(self.Train)
            cam.End2D()
            render.PopRenderTarget()
        end
  end
  function TRAIN_SYSTEM:PrintText(x, text, inverse)
      local str = {utf8.codepoint(text, 1, -1)}

      for i = 0, #str - 1 do
          local xpos = i * 26.5 + x * 3.005

          --if i*26.5+x*3.005+20 < 0 then continue end
          --if (i-33)*26.5+x*3.005+20 > 0 then continue end
          if -26.5 < xpos and xpos < 26.5 * 32 then
              local char = utf8.char(str[i + 1])
              draw.SimpleText(char, "Metrostroi_Tickers", xpos + 20, 24, Color(50, 160, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
          end
      end
  end
  --draw.SimpleText(char,"Metrostroi_Tickers",(x+i)*20.5+8,34,Color(0,255,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

  function TRAIN_SYSTEM:Tickers(Train)
        if self.Text  ~= "" then
        self:PrintText(self.Position,self.Text)
        end
  end
  return
end
function TRAIN_SYSTEM:Initialize()
    self.Advert = -1
    self.AdvertSymbol = 0
    self.CurrentAdvert = ""
end
function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
    if textdata == "Curr" then
        self.TickerCurr = numdata
    end
    if textdata == "Next" then
        self.TickerNext = numdata
    end
    if textdata == "Last" then
        self.TickerLast = numdata
    end
    self.NextAdvertStation = true
    self.BeStation=false
    --if textdata == "Arrival" then self.Path = numdata > 0 end
    --if textdata == "Path" then self.Line = numdata end
end
function TRAIN_SYSTEM:Think()
    local Train = self.Train
    local Power = Train.Panel.TickerPower>0
    local Work = Train.Panel.TickerWork>0 and Metrostroi.TickerAdverts
    if Power and (Work or self.Advert ~= -1) then
        self.AdvertSymbol = self.AdvertSymbol - 90*Train.DeltaTime
        if self.AdvertSymbol < -utf8.len(self.CurrentAdvert)*10-20 then
            self.AdvertSymbol = 40*(7+math.random(0,3))--40*7
            if Work then
                if self.NextAdvertStation then
                    self.Advert = 0
                    self.NextAdvertStation = false
                else
                    local rnd
                    repeat rnd = math.random(0,#Metrostroi.TickerAdverts) until rnd ~= self.Advert
                    self.Advert = rnd
                end
                if self.BeStation then
                    self.CurrentAdvert = Format("ПОЕЗД СЛЕДУЕТ ДО СТАНЦИИ %s",self.TickerLast):gsub("Й","й")
                    self.BeStation=false
                elseif self.Advert == 0 then
                    if not self.TickerCurr then
                        self.CurrentAdvert = ",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"
                    elseif self.TickerNext then
                        self.CurrentAdvert = Format("СЛЕДУЮЩАЯ СТАНЦИЯ %s",self.TickerCurr):gsub("Й","й")
                        self.BeStation=self.TickerLast
                    else
                        self.CurrentAdvert = Format("СТАНЦИЯ %s",self.TickerCurr):gsub("Й","й")
                        self.BeStation=self.TickerLast
                    end
                else
                    self.CurrentAdvert = Metrostroi.TickerAdverts[self.Advert]:gsub("Й","й")
                end
            else
                self.CurrentAdvert = "НИИ Фабрики SENT БЕГУЩАЯ СТРОКА v1.1 0123456789"
                self.Advert = -1
                self.AdvertSymbol = 40*8
            end
        end
    else
        self.AdvertSymbol = 40*8
        self.CurrentAdvert = "НИИ Фабрики SENT БЕГУЩАЯ СТРОКА v1.1 0123456789"
        self.Advert = -1
    end
    --[[
    local str = ""
    for p, c in utf8.codes(self.CurrentAdvert) do
        str = str..utf8.char(c+10)
    end]]
    Train:SetNW2String("TickerMessage",self.CurrentAdvert)
    --Train:SetNW2Int("TickerState",math.ceil(math.min(0,self.AdvertSymbol)))
    Train:SetNW2Int("TickerState",math.ceil(self.AdvertSymbol))
end

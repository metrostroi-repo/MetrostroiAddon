--------------------------------------------------------------------------------
-- ASOTP "IGLA" black indicator unit for 81-720
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("IGLA_CBKI2")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.Log = {}
    self.States = {}
    self.Messages = {}
    self.MessagesCount = 0
    if not self.Train.IGLA1U then
        self.Train:LoadSystem("IGLA1U","Relay","Switch",{bass = true})
        self.Train:LoadSystem("IGLA1","Relay","Switch",{bass = true})
        self.Train:LoadSystem("IGLA1D","Relay","Switch",{bass = true})
        self.Train:LoadSystem("IGLA2U","Relay","Switch",{bass = true})
        self.Train:LoadSystem("IGLA2","Relay","Switch",{bass = true})
        self.Train:LoadSystem("IGLA2D","Relay","Switch",{bass = true})
    end

    self.TriggerNames = {
        "IGLA1U",
        "IGLA1",
        "IGLA1D",
        "IGLA2U",
        "IGLA2",
        "IGLA2D",
    }
    self.Triggers = {}
    self.State = -2
end
if TURBOSTROI then return end
function TRAIN_SYSTEM:Inputs()
    return {  "Disable" }
end
if CLIENT then
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
    surface.CreateFont("Metrostroi_ILGAo", {
        font = "Liquid Crystal Display",
        size = 40,
        weight = 800,
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
  function TRAIN_SYSTEM:PrintText(x,text,inverse)
    local str = {utf8.codepoint(text,1,-1)}
    for i=1,#str do
        local char = utf8.char(str[i])
      if inverse then
        draw.SimpleText(string.char(0x7f),"Metrostroi_ILGAo",(x+i)*30,42,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        draw.SimpleText(char,"Metrostroi_ILGAo",(x+i)*30,42,Color(140,190,0,150),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
      else
        draw.SimpleText(char,"Metrostroi_ILGAo",(x+i)*30,42,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
      end
    end
  end
  function TRAIN_SYSTEM:ClientThink()
    if not self.Train:ShouldDrawPanel("IGLA") then return end
    --RunConsoleCommand("say","президент!!!")
    if not self.DrawTimer then
        render.PushRenderTarget(self.Train.IGLA,0,0,512, 128)
        render.Clear(0, 0, 0, 0)
        render.PopRenderTarget()
    end
    if self.DrawTimer and CurTime()-self.DrawTimer < 0.1 then return end
    self.DrawTimer = CurTime()
    render.PushRenderTarget(self.Train.IGLA,0,0,512, 128)
    --render.Clear(0, 0, 0, 0)
    cam.Start2D()
        self:IGLA(self.Train)
    cam.End2D()
    render.PopRenderTarget()
  end

    local messages = {
        START = "пит цбки вкл",
        CONN = "подкл",
        DISCONN = "отк пцбк",
        SCHEME = "несб сх",
        RP = "сраб рп",
        DOORS = "откр дв",
        BPSN = "выкл дип",
        PARKING = "вкл ст т",
        MANUAL = "вкл рч т",
        BRAKES = "вкл пн т",
        UAVA = "сраб СК",
        UAVAK = "кон уава",
        EPK = "сраб эпв",
        ARS = "прев арс",
        RU = "вкл ру",
    }
    function TRAIN_SYSTEM:IGLA()
        local Train = self.Train
        local State = self.Train:GetNW2Int("IGLA:State",0)
        if State > -2 then
            surface.SetDrawColor(81,223,0,self.Warm and 100 or 255)
            surface.DrawRect(0,0,512,80)
            self.Warm = true
        else
            surface.SetDrawColor(81*0.2,223*0.2,0,230)
            surface.DrawRect(0,0,512,80)
            self.Warm = false
        end

        if State == 0 then
            self:PrintText(0,"Chip test Ok Ok")
        elseif State == 1 then
            self:PrintText(0,"АСОТП-\"ИГЛА\" V02")
        elseif State == 2 then
            local State2 = Train:GetNW2Int("IGLA:State2",0)
            if State ~= self.OldState then
                self.Timer = RealTime()
                self.OldState = State
            end
            if State2 == 0 then
                --self:PrintText(0,"")
                self:PrintText(0,Format("[%03d]",Train:GetNW2Int("IGLA:Messages")))
                self:PrintText(7,"ПЦБК-"..Train:GetNW2Int("IGLA:Count",0))
            elseif State2 == 1 then
                local w = Train:GetNW2Int("IGLA:WagNumber")
                local m = Train:GetNW2String("IGLA:LogID")
                local s = Train:GetNW2Int("IGLA:Selected")
                if s ~= self.OldSel then
                    self.Timer = RealTime()-0.01
                    self.OldSel = s
                end
                if messages[m] then m = messages[m] end
                local timer = math.ceil((RealTime()-self.Timer)%3)
                if w > 0 then self:PrintText(0,Format("[%05d]",w)) else self:PrintText(0,"[]") end
                if timer == 1 then
                    if w > 0 then
                        self:PrintText(7,m)
                    else
                        self:PrintText(2,m)
                    end
                elseif timer == 2 then
                    local d = Train:GetNW2Int("IGLA:LogDate")
                    self:PrintText(w > 0 and 7 or 2,os.date("!%H:%M:%S",d))
                else
                    local d = Train:GetNW2Int("IGLA:LogDate")
                    self:PrintText(w > 0 and 7 or 2,os.date("!%d-%m-%y",d))
                end
                if Train:GetNW2Int("IGLA:Arrow") == -1 then
                    self:PrintText(15,"<")
                elseif Train:GetNW2Int("IGLA:Arrow") == 1 then
                    self:PrintText(15,">")
                else
                    self:PrintText(15,"<")
                    self:PrintText(15,">")
                end
            elseif State2 == 2 then
                local w = Train:GetNW2Int("IGLA:WagNumber")
                local m = Train:GetNW2String("IGLA:ErrorID")
                local s = Train:GetNW2Int("IGLA:Selected")
                if s ~= self.OldSel then
                    self.Timer = RealTime()-0.01
                    self.OldSel = s
                end
                if messages[m] then m = messages[m] end
                local timer = math.ceil((RealTime()-self.Timer)%3)
                if w > 0 then self:PrintText(0,Format("[%05d]",w)) else self:PrintText(0,"[]") end
                if timer == 1 then
                    if w > 0 then
                        self:PrintText(7,m)
                    else
                        self:PrintText(2,m)
                    end
                elseif timer == 2 then
                    local d = Train:GetNW2Int("IGLA:LogDate")
                    self:PrintText(w > 0 and 7 or 2,os.date("!%H:%M:%S",d))
                else
                    local d = Train:GetNW2Int("IGLA:LogDate")
                    self:PrintText(w > 0 and 7 or 2,os.date("!%d-%m-%y",d))
                end
                if Train:GetNW2Int("IGLA:Arrow") == -1 then
                    self:PrintText(15,"<")
                elseif Train:GetNW2Int("IGLA:Arrow") == 1 then
                    self:PrintText(15,">")
                else
                    self:PrintText(15,"<")
                    self:PrintText(15,">")
                end
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
    function TRAIN_SYSTEM:TriggerInput(name,value)
        if name == "Disable" then
            self.Disable = value>0
            if self.Disable then self:Initialize() end
        end
    end
    function TRAIN_SYSTEM:Trigger(name,value)
        if self.State == 2 then
            if self.State2 == 0 then
                if name == "IGLA2D"  and value and #self.Log > 0 then
                    self.State2 = 1
                    self.StandbyTimer = CurTime()
                    self.Selected = #self.Log
                end
                if name == "IGLA1D"  and value and #self.Messages > 0 then
                    self.State2 = 2
                    self.StandbyTimer = CurTime()
                    self.Selected = #self.Messages
                end
            elseif self.State2 == 1 then
                self.StandbyTimer = CurTime()
                if name == "IGLA2D"  and value and self.Selected > 1 then
                    self.Selected = self.Selected - 1
                end
                if name == "IGLA2"  and value then
                    self.State2 = 0
                end
                if name == "IGLA2U"  and value and self.Selected < #self.Log then
                    self.Selected = self.Selected + 1
                end
            elseif self.State2 == 2 then
                self.StandbyTimer = CurTime()
                if name == "IGLA1D"  and value and self.Selected > 1 then
                    self.Selected = self.Selected - 1
                end
                if name == "IGLA1"  and value then
                    self.State2 = 0
                end
                if name == "IGLA1U"  and value and self.Selected < #self.Messages then
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
        if self.Disable then return end
        local Train = self.Train
        local Power = Train.Panel.CBKIPower > 0
        if Power and self.State ~= -2  then
            for k,v in pairs(self.TriggerNames) do
                if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
                    self:Trigger(v,Train[v].Value > 0.5)
                    self.Triggers[v] = Train[v].Value > 0.5
                end
            end
        end
        if not Power or self.Reset then
            self.Reset = false
            if self.State ~= -2 then
                self.State = -2
                self.Timer = nil
                self.Fire = false
                self.Error = false
                self.PCBKCount = 0
                self.States = {}
                self.Messages = {}
            end
        end
        if self.State == -2 and Power then
            self.State = -1
            self.Timer = CurTime()+math.random()*0.3
            self.StartError = false
        end
        if self.State == -1 and CurTime()-self.Timer > 0.3 then
            self.State = 0
            Train:PlayOnce("igla_start1","cabin")
            self.Timer = CurTime()+math.random()*0.6
        end
        if self.State == 0 and CurTime()-self.Timer > 3.4 then
            table.insert(self.Log,{"START",sourceid,Metrostroi.GetSyncTime()})
            self.State = 1
            Train:PlayOnce("igla_start2","cabin")
            self.Timer = CurTime()+math.random()*0.4
        end
        if self.State == 1 then
            self.Fire = true
            self.Error = true
            if CurTime()-self.Timer > 4 then
                self.State = 2
                self.State2 = 0
                self.StandbyTimer = CurTime()
                self.ShowTimeTimer = nil
                self.ShowTime = false

                self.PCBKTimer = nil
            end
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
                local timer = v.Timer and CurTime()-v.Timer or 100
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
            if  self.MessagesCount ~= #self.Messages then
                local mess = #self.Messages
                if self.MessagesCount < mess then
                    Train:PlayOnce("igla_start2","cabin",nil,1)
                    self.StandbyTimer = CurTime()
                    if self.State2 ~= 2 then
                        self.State2 = 2
                        self.Selected = mess
                    end
                    if self.Selected >= self.MessagesCount then
                        self.Selected = mess
                    end
                end
                if self.State2 == 2 and self.Selected > mess then self.Selected = mess end
                if self.State2 == 2 and mess == 0 then
                    self.State2 = 0
                end
                self.MessagesCount = mess
            end

            if self.State2 == 0 then
                self.Fire = false
                self.Error = self.MessagesCount > 0
            elseif self.State2 == 1 then
                if self.Selected >= #self.Log then self.Selected = #self.Log end
                local log = self.Log[self.Selected]
                Train:SetNW2Int("IGLA:Selected",self.Selected)
                Train:SetNW2String("IGLA:LogID",log[1])
                Train:SetNW2Int("IGLA:WagNumber",log[2])
                Train:SetNW2Int("IGLA:LogDate",log[3])
                for i=4,#log do
                    Train:SetNW2Int("IGLA:Log"..i,log[i])
                end
                if CurTime()-self.StandbyTimer > 10 then self.State2 = 0 end
                Train:SetNW2Int("IGLA:Arrow",self.Selected == 1 and 1 or self.Selected == #self.Log and -1 or 0)
                self.Error = false
            elseif self.State2 == 2 then
                local err = self.Messages[self.Selected]
                Train:SetNW2Int("IGLA:Selected",self.Selected)
                Train:SetNW2String("IGLA:ErrorID",err[1])
                Train:SetNW2Int("IGLA:WagNumber",err[2])
                Train:SetNW2Int("IGLA:Arrow",self.Selected == 1 and 1 or self.Selected == #self.Messages and -1 or 0)

                if CurTime()-self.StandbyTimer > 10 then self.State2 = 0 end
                self.Fire = false
            end
        end
        self.Error = self.MessagesCount > 0
        Train:SetNW2Int("IGLA:Count",self.PCBKCount)
        Train:SetNW2Int("IGLA:State2",self.State2)
        Train:SetNW2Bool("IGLA:Messages",#self.Log)
        Train:SetNW2Bool("IGLASR",self.State > -2)
        Train:SetNW2Bool("IGLARX",self.State > -2 and self.PCBKCount == 0)
        Train:SetNW2Bool("IGLAErr",self.State > 0 and self.Error or self.State == 1)
        Train:SetNW2Bool("IGLAOSP", self.State == 1)
        Train:SetNW2Bool("IGLAPI", self.State == 1)
        Train:SetNW2Bool("IGLAOff", self.State == 1)






        Train:SetNW2Int("IGLA:State",self.State)
    end
end

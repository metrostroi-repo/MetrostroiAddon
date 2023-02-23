--------------------------------------------------------------------------------
-- 81-722 TNM-01 system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_722_TNM")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("RouteNumber1","Relay")
    self.Train:LoadSystem("RouteNumber2","Relay")
    self.Train:LoadSystem("RouteNumber3","Relay")
    self.TriggerNames = {
        "RouteNumber1",
        "RouteNumber2",
        "RouteNumber3",
    }
    self.Triggers = {}
    for k,v in pairs(self.TriggerNames) do
        if self.Train[v] then self.Triggers[v] = self.Train[v].Value > 0.5 end
    end

    self.State = 0
    self.Brightness = 100
    self.BrightKeys = 0
    self.NumberState = 42
    if not TURBOSTROI then
        self.Number = IsValid(self.Train.Owner) and tonumber(self.Train.Owner:GetInfo("metrostroi_route_number","61")) or 777
    end
end
if TURBOSTROI then return end

function TRAIN_SYSTEM:Trigger(name,value)
    if value then
        if self.State == 1 then
            if name == "RouteNumber1" then self.BrightKeys = self.BrightKeys + 1 end
            if name == "RouteNumber3" then self.BrightKeys = self.BrightKeys + 1 end
        elseif self.State == 2 then
            if name == "RouteNumber1" then
                self.BrightKeys = self.BrightKeys + 1
            elseif name == "RouteNumber3" then
                self.BrightKeys = self.BrightKeys + 1
            end
        end
    else
        if self.State == 1 then
            if not self.NewNumber then self.NewNumber = self.Number end
            local rNum = self.NewNumber
            local rNum1,rNum2,rNum3 = math.floor(rNum/100)%10,math.floor(rNum/10)%10,math.floor(rNum)%10
            if name == "RouteNumber1" then
                self.BrightKeys = math.max(0,self.BrightKeys-1)
                if self.BrightKeys < 1 and not self.KeysLock then
                    rNum1 = rNum1 + 1
                    if rNum1 > 9 then rNum1 = 0 end
                end
            elseif name == "RouteNumber2" then
                if self.BrightKeys < 1 and not self.KeysLock then
                    rNum2 = rNum2 + 1
                    if rNum2 > 9 then rNum2 = 0 end
                end
            elseif name == "RouteNumber3" then
                self.BrightKeys = math.max(0,self.BrightKeys-1)
                if self.BrightKeys < 1 and not self.KeysLock then
                    rNum3 = rNum3 + 1
                    if rNum3 > 9 then rNum3 = 0 end
                end
            end
            self.NewNumber = rNum1*100+rNum2*10+rNum3
            if self.NewNumber ~= self.Number then self.NewNumberTimer = CurTime()+5 end
        elseif self.State == 2 then
            local bright = self.Brightness
            local bright1,bright2,bright3 = math.floor(bright/100)%10,math.floor(bright/10)%10,math.floor(bright)%10
            if name == "RouteNumber1" then
                self.BrightKeys = math.max(0,self.BrightKeys-1)
                if self.BrightKeys < 1 and not self.KeysLock then
                    bright1 = bright1 + 1
                    if bright1 > 1 then bright1 = 0 end
                end
            elseif name == "RouteNumber2" then
                if self.BrightKeys < 1 and not self.KeysLock then
                    bright2 = bright2 + 1
                    if bright2 > 9 then bright2 = 0 end
                end
            elseif name == "RouteNumber3" then
                self.BrightKeys = math.max(0,self.BrightKeys-1)
                if self.BrightKeys < 1 and not self.KeysLock then
                    bright3 = bright3 + 1
                    if bright3 > 9 then bright3 = 0 end
                end
            end
            self.Brightness = math.min(100,bright1*100+bright2*10+bright3)
        end
        if self.KeysLock and self.BrightKeys == 0 then self.KeysLock = false end
    end
end
if SERVER then
    function TRAIN_SYSTEM:Think(dT)
        local Train = self.Train
        local Power = Train.Electric.Power > 0
        if Power then
            for k,v in pairs(self.TriggerNames) do
                if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
                    self:Trigger(v,Train[v].Value > 0.5)
                    self.Triggers[v] = Train[v].Value > 0.5
                end
            end
            if self.State == 1 then
                if self.BrightKeys > 1 then
                    if not self.BrightTimer then self.BrightTimer = CurTime()+1 end
                    if CurTime() > self.BrightTimer then self.State=2 self.BrightTimer=nil self.KeysLock = true end
                else
                    if self.BrightTimer then self.BrightTimer = nil end
                end
                Train:SetNW2Int("TNM:Number",self.NewNumber or self.Number)
            elseif self.State == 0 then
                self.State = 1
            elseif self.State == 2 then
                if self.BrightKeys > 1 and not self.KeysLock then
                    self.State = 1
                    self.KeysLock = true
                end
                Train:SetNW2Int("TNM:Number",self.Brightness)
            end

            if self.State > 0 then
                if self.NewNumberTimer and CurTime()>self.NewNumberTimer then
                    if not self.NumberUpdate then self.NumberUpdate = CurTime()+0.1 end
                    self.NewNumberTimer = nil
                end
                if self.NumberUpdate and CurTime() > self.NumberUpdate then
                    self.NumberUpdate = CurTime()+0.1
                    if self.Number ~= self.NewNumber then
                        self.NumberState = math.max(0,self.NumberState - 1)
                        Train:PlayOnce("blinker_off"..(self.NumberState%2+1),"bass",0.6+math.random()*0.3,1)
                        if self.NumberState == 0 then self.Number = self.NewNumber end
                    elseif self.Number == self.NewNumber then
                        self.NumberState = math.min(42,self.NumberState + 1)
                        Train:PlayOnce("blinker_on"..(self.NumberState%2+1),"bass",0.6+math.random()*0.3,1)
                        if self.NumberState == 42 then self.NewNumber = nil self.NumberUpdate = nil end
                    end
                end
                Train:SetNW2Int("TNM:Number2",self.Number)
            end
            Train:SetNW2Int("TNM:NumberState",self.NumberState)
            Train:SetNW2Int("TNM:Bright",self.NumberUpdate and 0 or self.Brightness)
        else
            if self.State ~= 0 then
                self.BrightTimer = nil
                self.NewNumber = nil
                self.NewNumberTimer = nil
                self.NumberUpdate = nil
                self.State = 0
            end
        end
        
        Train:SetNW2Int("TNM:State",self.State)
    end
else    
    local TNMPixels = surface.GetTextureID("models/metrostroi_train/81-722/screens/sarmat_upo/tnm")

    function TRAIN_SYSTEM:ClientInitialize()
        self.Brightness = 100
        self.NumberState = 42
        self.Number = 61
        self.NeedUpdate = true
    end

    function TRAIN_SYSTEM:ClientThink(dT)
        -- ТНМ-1.02 АВДБ.687240.049-10
        local Train = self.Train
        local bright = (4.5-(Train:GetNW2Int("TNM:Bright",1)/100)*math.min(1,Train:GetNW2Int("TNM:State",0))*3.5)
        local number = Train:GetNW2Int("TNM:Number2",777)
        local rnState = Train:GetNW2Int("TNM:NumberState",42)
        if self.Brightness ~= bright then
            self.Brightness = bright
            self.NeedUpdate = true
        end
        if self.NumberState ~= rnState then
            self.NumberState = rnState
            self.NeedUpdate = true
        end
        if self.Number ~= number then
            self.Number = number
            self.NeedUpdate = true
        end
        -- self.NeedUpdate = true
        if self.NeedUpdate then
            render.PushRenderTarget(Train.TNMScr,0,0,256,128)
            render.Clear(0, 0, 0, 0)
            cam.Start2D()
                self:TNM(Train)
            cam.End2D()
            render.PopRenderTarget()
            self.NeedUpdate = false
        end
    end

    local numbers = {
        [0] = {0x3E,0x7F,0x63,0x63,0x63,0x63,0x63,0x63,0x63,0x63,0x63,0x63,0x7F,0x3E},
        [1] = {0x0C,0x1C,0x3C,0x0C,0x0C,0x0C,0x0C,0x0C,0x0C,0x0C,0x0C,0x0C,0x3F,0x3F},
        [2] = {0x3E,0x7F,0x63,0x03,0x03,0x03,0x06,0x0C,0x18,0x30,0x60,0x60,0x7F,0x7F},
        [3] = {0x3E,0x7F,0x63,0x03,0x03,0x03,0x1E,0x1E,0x03,0x03,0x03,0x63,0x7F,0x3E},
        [4] = {0x63,0x63,0x63,0x63,0x63,0x63,0x63,0x7F,0x7F,0x03,0x03,0x03,0x03,0x03},
        [5] = {0x7F,0x7F,0x60,0x60,0x60,0x60,0x7E,0x7F,0x03,0x03,0x03,0x63,0x7F,0x3E},
        [6] = {0x3E,0x7F,0x63,0x60,0x60,0x60,0x7E,0x7F,0x63,0x63,0x63,0x63,0x7F,0x3E},
        [7] = {0x7F,0x7F,0x63,0x03,0x03,0x06,0x0C,0x18,0x30,0x60,0x60,0x60,0x60,0x60},
        [8] = {0x3E,0x7F,0x63,0x63,0x63,0x63,0x3E,0x3E,0x63,0x63,0x63,0x63,0x7F,0x3E},
        [9] = {0x3E,0x7F,0x63,0x63,0x63,0x63,0x7F,0x3F,0x03,0x03,0x03,0x63,0x7F,0x3E},
    }
    TRAIN_SYSTEM.TNMFont = {}
    for i=0,9 do
        TRAIN_SYSTEM.TNMFont[i] = {}
        for iy=0,13 do
            TRAIN_SYSTEM.TNMFont[i][iy] = {}
            for ix=0,6 do
                TRAIN_SYSTEM.TNMFont[i][iy][ix] = bit.band(bit.rshift(numbers[i][iy+1],6-ix),1) > 0
            end
        end
    end
    function TRAIN_SYSTEM:TNM(Train)
        local rNum = self.Number
        local bright = self.Brightness
        local tnmState = self.NumberState
        
        for i=0,2 do
            local rnstate = math.ceil((tnmState-i*14)/2)*2
            local rnstate2 = math.floor((tnmState-i*14)/2)*2
            local rNum = math.floor(rNum/10^(2-i))%10
            for ix=0,6 do
                for iy=0,13 do
                    if self.TNMFont[rNum][iy][ix] and ((14-rnstate2) <= iy or ((14-rnstate) <= iy and (ix%2 > 0 and iy%2 == 0 or ix%2 == 0 and iy%2 > 0))) then
                        surface.SetDrawColor(150/bright,255/bright,50/bright)
                    else
                        surface.SetDrawColor(0,0,0,120)
                    end
                    surface.DrawRect(2+ix*8+i*72,2+iy*8,7,7)
                end
            end
        end

        -- Pixels mask
        render.OverrideBlend(true,BLEND_ZERO,BLEND_ONE,BLENDFUNC_MIN)
        surface.SetDrawColor(255,255,255)
        surface.SetTexture(TNMPixels)
        surface.DrawTexturedRectRotated(130,66,256,128,0)
        render.OverrideBlend(false)
    end
end

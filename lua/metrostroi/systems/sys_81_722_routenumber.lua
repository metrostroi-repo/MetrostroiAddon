--------------------------------------------------------------------------------
-- 81-722 route number
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_722_RouteNumber")
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

    self.CurrentRouteNumber = 777
    self.RouteNumber = 777
    self.RouteNumberState = 42
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
    function TRAIN_SYSTEM:Trigger(name,value)
        local Train = self.Train
        if value then
            if not self.NextRouteNumberTimer then
                self.NextRouteNumber = Format("%03d",self.CurrentRouteNumber)
            end
            self.NextRouteNumberTimer = CurTime()
        end
        if name == "RouteNumber1" and value then
            local num = tonumber(self.NextRouteNumber[1]+1)
            if num > 9 then num = 0 end
            self.NextRouteNumber = self.NextRouteNumber:SetChar(1,num)
        end
        if name == "RouteNumber2" and value then
            local num = tonumber(self.NextRouteNumber[2]+1)
            if num > 9 then num = 0 end
            self.NextRouteNumber = self.NextRouteNumber:SetChar(2,num)
        end
        if name == "RouteNumber3" and value then
            local num = tonumber(self.NextRouteNumber[3]+1)
            if num > 9 then num = 0 end
            self.NextRouteNumber = self.NextRouteNumber:SetChar(3,num)
        end
    end
    function TRAIN_SYSTEM:Think(dT)
        local Train = self.Train
        local Panel = Train.Panel
        local Work = Train.Electric.Power --and Train.SF19.Value > 0
        if Work then
            for k,v in pairs(self.TriggerNames) do
                if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
                    self:Trigger(v,Train[v].Value > 0.5)
                    self.Triggers[v] = Train[v].Value > 0.5
                end
            end
            if self.NextRouteNumberTimer and CurTime()-self.NextRouteNumberTimer > 5 and self.RouteNumberState == 42 then
                self.NextRouteNumberTimer = nil
                self.CurrentRouteNumber = tonumber(self.NextRouteNumber)
            end
            if not self.RouteNumberUpdateDelay or self.RouteNumberUpdateDelay and CurTime()-self.RouteNumberUpdateDelay > 0.1 then
                if self.RouteNumberState >= 0 and self.RouteNumber ~= self.CurrentRouteNumber then
                    self.RouteNumberState = self.RouteNumberState-1
                    Train:PlayOnce("blinker_off"..(self.RouteNumberState%2+1),"bass",0.6+math.random()*0.3,1)

                end
                if self.RouteNumberState < 42 and self.RouteNumber == self.CurrentRouteNumber then
                    self.RouteNumberState = self.RouteNumberState+1
                    Train:PlayOnce("blinker_on"..(self.RouteNumberState%2+1),"bass",0.6+math.random()*0.3,1)
                end
                if self.RouteNumberState < 0 and self.RouteNumber ~= self.CurrentRouteNumber then
                    self.RouteNumber = self.CurrentRouteNumber
                    self.RouteNumberState = self.RouteNumberState+1
                    Train:PlayOnce("blinker_on"..(self.RouteNumberState%2+1),"bass",0.6+math.random()*0.3,1)
                end
                self.RouteNumberUpdateDelay = CurTime()
            end
        end

        Train:SetNW2Bool("RouteNumberWork",Work)
        Train:SetNW2Int("RouteNumberBright",10)
        Train:SetNW2Int("RouteNumberState",self.RouteNumberState)
        Train:SetNW2String("RouteNumberLastStation",Train.SarmatUPO.LastStationName)
        Train:SetNW2Bool("RouteNumberLastStationWork",Work and Train.SF18.Value > 0 and Train.SarmatUPO.SarmatState > 0)
        Train:SetNW2Int("RouteNumber",self.RouteNumber)
        Train:SetNW2Int("RouteNumberSet",self.NextRouteNumber or self.RouteNumber)
    end
else
    function TRAIN_SYSTEM:ClientInitialize()
        self.CurrentRouteNumber = 0
        self.RouteNumberState = 42
        self.RouteNumberNeedUpdate = true
        self.Work = false
        self.RouteNumberBright = 0
    end
    function TRAIN_SYSTEM:ClientThink()
        if self.Train:ShouldDrawPanel("RouteNumber") and self.RouteNumberNeedUpdate then
            render.PushRenderTarget(self.Train.RouteNumber,0,0,256, 128)
            render.Clear(0, 0, 0, 0)
            cam.Start2D()
                surface.SetDrawColor(0,0,0)
                --surface.DrawRect(0,0,54,32)
                self:RouteNumber(self.Train)
            cam.End2D()
            render.PopRenderTarget()
            self.RouteNumberNeedUpdate = false
        end
        if self.LastStationNeedUpdate then
            render.PushRenderTarget(self.Train.LastStation,0,0,512, 64)
            render.Clear(0, 0, 0, 0)
            cam.Start2D()
                surface.SetDrawColor(0,0,0)
                --surface.DrawRect(0,0,54,32)
                self:LastStation(self.Train)
            cam.End2D()
            render.PopRenderTarget()
            self.LastStationNeedUpdate = false
        end
        local number = self.Train:GetNW2Int("RouteNumber",0)
        local work = self.Train:GetNW2Bool("RouteNumberWork",false)
        if not work and self.CurrentRouteNumber == number then
            if work ~= self.Work then
                self.RouteNumberBright = 0
                self.Work = false
                self.RouteNumberNeedUpdate = true
            end
        else
            local state = self.Train:GetNW2Int("RouteNumberState",0)
            local bright = self.Train:GetNW2Int("RouteNumberBright",0)
            if self.RouteNumberState ~= state or self.CurrentRouteNumber ~= number or work ~= self.Work or bright ~= self.RouteNumberBright then
                self.RouteNumberNeedUpdate = true
                self.Work = work
                self.RouteNumberBright = bright
                self.RouteNumberState = state
                self.CurrentRouteNumber = number
            end
        end
        local lswork = self.Train:GetNW2Bool("RouteNumberLastStationWork")
        if not lswork then
            if lswork ~= self.LastStationWork then
                self.LastStationWork = false
                self.LastStationNeedUpdate = true
            end
        else
            local laststation = self.Train:GetNW2String("RouteNumberLastStation","")
            if self.LastStationName ~= laststation or self.LastStationWork ~= lswork then
                self.LastStationWork = lswork
                self.LastStationName = laststation
                self.LastStationNeedUpdate = true
            end
        end
    end

    local numbers = {
        ["0"] = {"0111110","1111111","1100011","1100011","1100011","1100011","1100011","1100011","1100011","1100011","1100011","1100011","1111111","0111110",},
        ["1"] = {"0001100","0011100","0111100","0001100","0001100","0001100","0001100","0001100","0001100","0001100","0001100","0001100","0111111","0111111",},
        ["2"] = {"0222220","2222222","2200022","0000022","0000022","0000022","0000220","0002200","0022000","0220000","2200000","2200000","2222222","2222222",},
        ["3"] = {"0333330","3333333","3300033","0000033","0000033","0000033","0033330","0033330","0000033","0000033","0000033","3300033","3333333","0333330",},
        ["4"] = {"4400044","4400044","4400044","4400044","4400044","4400044","4400044","4444444","4444444","0000044","0000044","0000044","0000044","0000044",},
        ["5"] = {"5555555","5555555","5500000","5500000","5500000","5500000","5555550","5555555","0000055","0000055","0000055","5500055","5555555","0555550",},
        ["6"] = {"0666660","6666666","6600066","6600000","6600000","6600000","6666660","6666666","6600066","6600066","6600066","6600066","6666666","0666660",},
        ["7"] = {"7777777","7777777","7700077","0000077","0000770","0007700","0077000","0770000","7700000","7700000","7700000","7700000","7700000","7700000",},
        ["8"] = {"0888880","8888888","8800088","8800088","8800088","8800088","0888880","0888888","8800088","8800088","8800088","8800088","8888888","0888880",},
        ["9"] = {"0999990","9999999","9900099","9900099","9900099","9900099","9999999","0999999","0000099","0000099","0000099","9900099","9999999","0999990",},
    }
    TRAIN_SYSTEM.RouteNumberFont = {}
    for i,num in pairs(numbers) do
        if not TRAIN_SYSTEM.RouteNumberFont[i] then TRAIN_SYSTEM.RouteNumberFont[i] = {} end
        local numtbl = TRAIN_SYSTEM.RouteNumberFont[i]
        for ir,row in pairs(num) do
            if not numtbl[ir] then numtbl[ir] = {} end
            local rowtbl = numtbl[ir]
            for ic=1,#row do
                rowtbl[ic] = (row[ic] ~= "0")
            end
        end
    end
    function TRAIN_SYSTEM:LastStation(Train)
        if self.LastStationWork then
            draw.SimpleText(self.LastStationName,"Metrostroi_722LastStation",256, 24,Color(255,100,60),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
    end
    function TRAIN_SYSTEM:RouteNumber(Train)
        local bright = (5-self.RouteNumberBright*0.4)
        if self.RouteNumberState < 42 or not self.Work then bright = 5 end
        surface.SetDrawColor(150,255,50,255)
        surface.SetDrawColor(150/bright,255/bright,50/bright,255)
        --surface.SetDrawColor(150,220,50,255)
        local num = Format("%03d",self.CurrentRouteNumber)
        --print(self.RouteNumberState,math.ceil(self.RouteNumberState/2),self.CurrentRouteNumber,num,type(num),bright)
        local rnstate = math.ceil(self.RouteNumberState/2)*2
        local rnstate2 = math.floor(self.RouteNumberState/2)*2
        local half = self.RouteNumberState ~= rnstate
        for i=1,3 do
            local rnstate = math.ceil((self.RouteNumberState-(i-1)*14)/2)*2
            local rnstate2 = math.floor((self.RouteNumberState-(i-1)*14)/2)*2
            local number = self.RouteNumberFont[num[i]]
            if number then
                --print(number)
                for x=0,6 do
                    for y=0,13 do
                        if number[y+1][x+1] and ((14-rnstate2) <= y or ((14-rnstate) <= y and  (x%2 > 0 and y%2 == 0 or x%2 == 0 and y%2 > 0))) then
                            surface.DrawRect((i-1)*64+x*8,1+y*8,7,7)
                        end
                    end
                end
            end
        end
    end
end

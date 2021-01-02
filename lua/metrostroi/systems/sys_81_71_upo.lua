--------------------------------------------------------------------------------
-- UPO annoncer system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_71_UPO")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.Line = 1
    self.Path = false
    self.Station = 1
    self.Arrived = true
    self.Selected = 0
    self.LineEnabled = false

    self.LineOut = 0
end

function TRAIN_SYSTEM:Outputs()
    return {"LineOut"}
end

function TRAIN_SYSTEM:Inputs()
    return {"ArriveRandom"}
end

if TURBOSTROI then return end

function TRAIN_SYSTEM:TriggerInput(name, value)
    if name == "ArriveRandom" then self.ArriveRandom = value>0 end
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
    local tbl = Metrostroi.UPOSetup
    if not tbl then return end
    self.Train.Announcer:TriggerInput("Reset","AnnouncementsUPO")
    local stbl = tbl[self.Station]
    local path = self.Path and 2 or 1
    if not stbl or dep and not stbl.dep or not dep and not stbl.arr and not stbl.arrlast then return end
    if dep and stbl.dep and stbl.dep[path] and (not self.Train.OnUPOArrived or self.Train:OnUPOArrived()) then
        self:AnnQueue(-2)
        self:AnnQueue{"noise_end","buzz_end_upo"}
        if self.Buzz then self:AnnQueue{"buzz_start_upo",self.Buzz} else self:AnnQueue("buzz_end_upo") end
        if self.Clicks then self:AnnQueue("click1") end
        self:AnnQueue(math.Rand(0.0,0.2))
        if self.Noise then self:AnnQueue{"noise_start",self.Noise} else self:AnnQueue("noise_end") end
        self:AnnQueue{math.Rand(0.0,0.2), stbl.tone or "tone"}
        self:AnnQueue(stbl.dep[path])
        self:AnnQueue{math.Rand(0.1,0.4),"noise_end","buzz_end_upo"}
        if self.Clicks then self:AnnQueue("click2") end
    elseif not dep then
        local msg,lastst
        if stbl.arr then msg = stbl.arr[path] end

        if not msg and stbl.arrlast then
            msg = stbl.arrlast[path]
            lastst = true
        end
        if msg and (not self.Train.OnUPOArrived or self.Train:OnUPOArrived()) then
            self:AnnQueue(-2)
            self:AnnQueue{"noise_end","buzz_end_upo"}
            if self.Buzz then self:AnnQueue{"buzz_start_upo",self.Buzz} else self:AnnQueue("buzz_end_upo") end
            if self.Clicks then self:AnnQueue("click1") end
            self:AnnQueue(math.Rand(0.0,0.2))
            if self.Noise then self:AnnQueue{"noise_start",self.Noise} else self:AnnQueue("noise_end") end
            self:AnnQueue{math.Rand(0.0,0.2), stbl.tone or "tone"}
            if lastst then self:AnnQueue{-1} end
            self:AnnQueue(msg)
            self:AnnQueue{math.Rand(0.1,0.4),"noise_end","buzz_end_upo"}
            if self.Clicks then self:AnnQueue("click2") end
        end
    end
end

function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    local tbl = Metrostroi.UPOSetup
    if not tbl then
        self.State = false

        return
    end
    --local KRUEnabled = Train.KRU and Train.KRU["14/1-B3"] > 0
    --local RVForward = (Train.KV["D4-15"] > 0 or KRUEnabled)
    local UPOWork = Train.Panel.UPOPower>0

    --self.LastStationName = stbl[self.Line][self.Path and self.StartStation or self.EndStation][2]
    if UPOWork then
        local path = Train:ReadCell(49170) --Metrostroi.PathConverter[self.Train:ReadCell(65510)] or 0
        self.Path = path == 2
        local station = Train:ReadCell(49169)
        local stbl
        local distance = math.min(3072, self.Train:ReadCell(49165))
        --Find my station
        self.Station = nil
        for i2, v in ipairs(tbl) do
            if v[1] == station then
                stbl = v
                self.Station = i2
                break
            end
        end
        --local stbl = tbl[self.Line] and tbl[self.Line][self.Station]
        local dist = stbl and stbl.dist or 75
        --print(self.Path,stbl.arr[self.Path and 2 or 1][3],self.Path and 2 or 1)
        if station ~= self.CurrentStation and distance < dist and self.UPOArrived == nil then
            self.UPOArrived = true
            self.CurrentStation = station
            self.Noise = stbl and stbl.noise or 0
            if not self.AnnouncerPlay and stbl then
                self.Clicks = math.random() > 0.4
                self:Play(false)
            end
        end
        if self.UPOArrived and self.AnnouncerPlay then
            self.UPOArrived = false
            if stbl then
                self.Clicks = math.random() > 0.4
                self:Play(true)
            end
        end

        if self.UPOArrived == false and Train.Speed > 0.1 then
            self.UPOArrived = nil
        end
        if distance < 0 or  distance > dist and self.CurrentStation then
            if #Train.Announcer.Schedule > 0 then
                Train.Announcer:Reset()
                --Train.Announcer:Queue{"click2"}
                --Train:WriteTrainWire(47, 0)
            end
            self.UPOArrived = nil
            self.CurrentStation = nil
        end
    else
        --self.UPOArrived = nil
        --self.CurrentStation = nil
    end
    local Ann = Train.Announcer
    self.LineOut = (Ann.AnnTable=="AnnouncementsUPO" and Ann.AnnounceTimer) and Train.Panel.UPOPower or 0
end
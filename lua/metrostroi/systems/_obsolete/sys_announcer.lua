--------------------------------------------------------------------------------
-- Announcer and announcer-related code
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("Announcer")
TRAIN_SYSTEM.DontAccelerateSimulation = true
if TURBOSTROI then return end

function table.GetLastKey(t)
    local lk = -math.huge
    for ki in pairs(t) do
        lk = math.max(lk,ki)
    end
    return lk
end
--[[
Metrostroi.AnnouncementSequences = {
    [1101] = { 0211, 0308, 0321 },
    [1102] = { 0211, 0321, 0308 },

    [1108] = { 0220, 0308 },
    [1109] = { 0220, 0309 },
    [1110] = { 0220, 0310, 0231 },
    [1111] = { 0220, 0311 },
    [1112] = { 0220, 0312 },
    [1113] = { 0220, 0313 },
    [1114] = { 0220, 0314 },
    [1115] = { 0220, 0315, 0231, 0202, 0203, 0415 },
    [1116] = { 0220, 0316 },
    [1117] = { 0220, 0317 },
    [1118] = { 0220, 0318, 0231 },
    [1119] = { 0220, 0319 },
    [1120] = { },
    [1121] = { 0220, 0321 },
    [1122] = { 0220, 0322 },
    [1123] = { 0220, 0323 },

    [1208] = { 0218, 0219, 0308 },
    [1209] = { 0218, 0219, 0309 },
    [1210] = { 0218, 0219, 0310 },
    [1211] = { 0218, 0219, 0311 },
    [1212] = { 0218, 0219, 0312 },
    [1213] = { 0218, 0219, 0313 },
    [1214] = { 0218, 0219, 0314 },
    [1215] = { 0218, 0219, 0315 },
    [1216] = { 0218, 0219, 0316 },
    [1217] = { 0218, 0219, 0317 },
    [1218] = { 0218, 0219, 0318 },
    [1219] = { 0218, 0219, 0319 },
    [1220] = { },
    [1221] = { 0218, 0219, 0321 },
    [1222] = { 0218, 0219, 0322 },
    [1223] = { 0218, 0219, 0323 },
}]]
--[[ Quick lookup
for k,v in pairs(Metrostroi.Announcements) do
    v[3] = k
end
for k,v in pairs(Metrostroi.AnnouncementsPNM) do
    v[3] = k
end]]

local function recurprecache(tbl)
  if not tbl then return end
  for k,v in pairs(tbl) do
    if type(v[2]) == "string" then
      util.PrecacheSound(v[2])
    elseif type(v) == "table" then
      recurprecache(v)
    else ErrorNoHalt("Metrtostroi: Can't precache "..k..", because v("..tostring(v).." !table") end
  end
end

--------------------------------------------------------------------------------
function TRAIN_SYSTEM:Initialize()
  recurprecache(Metrostroi.Announcements)

  self.AnnouncerType = 0
    -- Currently playing announcement
    self.Announcement = 0
    -- End time of the announcement
    self.EndTime = -1e9
    -- Announcement schedule
    self.Schedule = {}
    -- Fake wire 49
    self.Fake48 = 0
end


function TRAIN_SYSTEM:Inputs()
    return { "Queue" }
end
function TRAIN_SYSTEM:Outputs()
    return { "AnnMap" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if (name == "Queue") and (value > 0.0) then
        self:Queue(math.floor(value))
  end
end


function TRAIN_SYSTEM:Queue(id)
    if self.Train and self.Train.SubwayTrain and self.Train.SubwayTrain.Type and self.Train.SubwayTrain.Type == "E" and
        (id == 5 or id == 6) then return end
    -- Add announcement to queue
    if #self.Schedule < 16 then
        --[[if Metrostroi.AnnouncementSequences[id] then
            for k,i in pairs(Metrostroi.AnnouncementSequences[id]) do
                self:Queue(i)
            end
        else]]
        local tbl = Metrostroi.Announcements[self.AnnouncerType][id]
        if id >= 1000 then
            tbl = Metrostroi.Announcements[self.AnnouncerType].stations[id-1000]
        end
        if not tbl then  print(id) end
        table.insert(self.Schedule, {id,tbl[1]})
    end
end


function TRAIN_SYSTEM:ClientInitialize()
end

function TRAIN_SYSTEM:ClientThink()
  if self.AnnouncerType ~= self.Train:GetNW2Int("Announcer") then
    self.AnnouncerType = self.Train:GetNW2Int("Announcer")
    if Metrostroi.Announcements[self.AnnouncerType] then
      self.Train.SoundNames["bpsn_ann"] = Metrostroi.Announcements[self.AnnouncerType][0007][2]
      self.Train.SoundNames["bpsn_ann_cab"] = Metrostroi.Announcements[self.AnnouncerType][0007][2]
    end
  end
    local active = self.Train:GetNW2Bool("BPSNBuzz",false)
    self.Train:SetSoundState("bpsn_ann",(active and self.Train:GetPackedBool("buzz")) and 0.175 or 0,1)
    self.Train:SetSoundState("bpsn_ann_cab",(active and self.Train:GetPackedBool("buzz_cab")) and 0.175 or 0,1)
end

function TRAIN_SYSTEM:MultiQueue(...)
    for _,v in pairs({...}) do
        local v = tonumber(v)
        if v ~= nil then
            self:Queue(v)
        end
    end
end

function TRAIN_SYSTEM:Think()
    -- Check if new announcement must be started from train wire
    local targetAnnouncement = self.Train:ReadTrainWire(47)
    if targetAnnouncement < 0 then targetAnnouncement = 0 end
    local onlyCabin = false
    if (targetAnnouncement == 0) then targetAnnouncement = self.Fake48 or 0  onlyCabin = true end
    if (targetAnnouncement > 0) and (targetAnnouncement ~= self.Announcement) and (CurTime() > self.EndTime) then
        self.Announcement = targetAnnouncement
        local tbl = Metrostroi.Announcements[self.AnnouncerType][targetAnnouncement]
    if targetAnnouncement >= 1000 then
      tbl = Metrostroi.Announcements[self.AnnouncerType].stations[targetAnnouncement-1000]
    end
        if tbl then
            --if not Metrostroi["Announcements" .. (self.Train.PNM and "PNM" or "")][targetAnnouncement] then print(targetAnnouncement) end
            self.Sound = tbl[2]
            self.EndTime = CurTime() + tbl[1]

            -- Emit the sound
            if self.Sound ~= "" then
                if self.Train.DriverSeat and (not self.Train.R_G or self.Train.R_G.Value > 0.5) then
                    self.Train.DriverSeat:EmitSound(self.Sound, 73, 100)
                end
                if onlyCabin == false then
                    self.Train:EmitSound(self.Sound, 85, 100)
                end
            if tbl[3] == 2 then
                    self.Train.AnnouncementToLeaveWagon = true
                    self.Train.AnnouncementToLeaveWagonAcknowledged = false
                --else
                    --self.Train.AnnouncementToLeaveWagon = false
                end
                if self.Train:GetNW2Float("PassengerCount") == 0 then
                    self.Train.AnnouncementToLeaveWagon = false
                end
            end
            -- BPSN buzz
            if tbl[3] == 1 and self.Train.PNM then timer.Simple(0.1,function() self.Train:SetNW2Bool("BPSNBuzz",true) end) end
            if tbl[3] == 1 and not self.Train.PNM then timer.Simple(0.2,function() self.Train:SetNW2Bool("BPSNBuzz",true) end) end
            if tbl[3] == 0 then
                self.Train:SetNW2Bool("BPSNBuzz",false)
                    --[[
                    if self.Train.PNM then
                    self.Train:SetNW2Bool("BPSNBuzz",false)
                    self.BPSNBuzzTimeout1 = CurTime() + 0
                else
                    self.BPSNBuzzTimeout1 = CurTime() + 0.4
                    --timer.Simple(0.4,function() if not IsValid(self.Train) then return end self.Train:SetNW2Bool("BPSNBuzz",false) end)
                end
                ]]
            end
            self.BPSNBuzzTimeout = CurTime() + 10.0
        end
    elseif (targetAnnouncement == 0) then
        self.Announcement = 0
    end

    -- Buzz timeout
    if self.BPSNBuzzTimeout and (CurTime() > self.BPSNBuzzTimeout) then
        self.BPSNBuzzTimeout = nil
        self.Train:SetNW2Bool("BPSNBuzz",false)
    end
    if self.BPSNBuzzTimeout1 and (CurTime() > self.BPSNBuzzTimeout1) then
        self.BPSNBuzzTimeout1 = nil
        self.Train:SetNW2Bool("BPSNBuzz",false)
    end
    -- Check if new announcement must be started from schedule
    if (self.ScheduleAnnouncement == 0) and (self.Schedule[1]) then
        self.ScheduleAnnouncement = self.Schedule[1][1]
        self.ScheduleEndTime = CurTime() + self.Schedule[1][2]
        table.remove(self.Schedule,1)
    end


    -- Check if schedule announcement is playing
    if self.ScheduleAnnouncement ~= 0 then
        if self.Train.DriverSeat and ((self.Train.R_ZS and self.Train.R_ZS.Value < 0.5) or (self.Train.R_UPO and self.Train.R_UPO.Value < 0.5)) then
            self.Fake48 = self.ScheduleAnnouncement
        else
            self.Train:WriteTrainWire(47,self.ScheduleAnnouncement)
            self.Fake48 = 0
        end
        if CurTime() > (self.ScheduleEndTime or -1e9) then
            self.ScheduleAnnouncement = 0
            self.Fake48 = 0
            self.Train:WriteTrainWire(47,0)
        end
    end
    if self.Train.R_ZS and self.Train.KV then
        if self.Train.R_ZS.Value < 0.5 and self.Train.KV.ReverserPosition == 1.0 then
            self.Train:WriteTrainWire(47,-1)
        elseif self.Train:ReadTrainWire(47) == -1 then
            self.Train:WriteTrainWire(47,0)
        end
    end
    if self.Train.R_UPO and self.Train.KV then
        if self.Train.R_UPO.Value < 0.5 and self.Train.KV.ReverserPosition == 1.0 then
            self.Train:WriteTrainWire(47,-1)
        elseif self.Train:ReadTrainWire(47) == -1 then
            self.Train:WriteTrainWire(47,0)
        end
    end
end

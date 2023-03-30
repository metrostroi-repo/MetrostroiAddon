--------------------------------------------------------------------------------
-- 81-722 BNT-12 system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_722_BNT")
TRAIN_SYSTEM.DontAccelerateSimulation = true

TRAIN_SYSTEM.CAN_ACTIVATE  = 0x01
TRAIN_SYSTEM.CAN_BMTS_TEXT = 0x10
TRAIN_SYSTEM.CAN_CURR      = 0x21
TRAIN_SYSTEM.CAN_NEXT      = 0x22
TRAIN_SYSTEM.CAN_PATH      = 0x23
TRAIN_SYSTEM.CAN_CLOSERING = 0x24
TRAIN_SYSTEM.CAN_VOLUMES   = 0x25
TRAIN_SYSTEM.CAN_SPEED     = 0x26

-- self.AnnouncerPositions[4]:
--      0x43 - Cabin speaker
--      0x4C - Left side
--      0x52 - Right side
function TRAIN_SYSTEM:Initialize()
    self.Volumes = {
        Speed = 0,
        Ann = 5,
        UPO = 5,
        V5 = 0
    }
    self.Left = {
        Power = false,
        CloseRing = false,
        CloseRingState = false,
        Init = false,
        Curr = 0,
        Next = 0,
        Back = false
    }
    self.Right = {
        Power = false,
        CloseRing = false,
        CloseRingState = false,
        Init = false,
        Curr = 0,
        Next = 0,
        Back = false
    }
end

if TURBOSTROI then return end

function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
    if textdata == self.CAN_SPEED then
        self.Volumes.Speed = numdata
        return
    end
    if textdata == self.CAN_CURR then
        self.Left.Init = true
        self.Right.Init = true
        self.Left.Curr = self.Left.Power and numdata or 0
        self.Right.Curr = self.Right.Power and numdata or 0
    end
    if textdata == self.CAN_NEXT then
        self.Left.Init = true
        self.Right.Init = true
        self.Left.Next = self.Left.Power and numdata or 0
        self.Right.Next = self.Right.Power and numdata or 0
    end
    if textdata == self.CAN_PATH then
        self.Left.Init = true
        self.Right.Init = true
        self.Left.Back = self.Left.Power and numdata or false
        self.Right.Back = self.Right.Power and numdata or false
    end
    if textdata == self.CAN_CLOSERING then
        self.Left.CloseRing = self.Left.Power and numdata or false
        self.Right.CloseRing = self.Right.Power and numdata or false
    end
    if textdata == self.CAN_VOLUMES then
        self.Volumes.Ann = numdata[1]
        self.Volumes.UPO = numdata[2]
        self.Volumes.V5 = numdata[3]
    end
    if textdata == self.CAN_ACTIVATE then
        for k,v in ipairs(self.Train.AnnouncerPositions) do
            if (v[4] == 0x4C and self.Left.Power) or (v[4] == 0x52 and self.Right.Power) then
                self.Train:PlayOnce("announcer_sarmat_start"..k,nil,self.Volumes.Ann/10,1)
            end
        end
    end
end

local function setBitValue(targetVar, value, offset, bitCount)
    value = bit.band(value,bit.lshift(1,bitCount)-1)
    return bit.bor(targetVar,bit.lshift(value,offset))
end

function TRAIN_SYSTEM:Think()
    local Train = self.Train
    self.BNT(self.Left,self.Train.Panel.PassSchemePowerL > 0)
    self.BNT(self.Right,self.Train.Panel.PassSchemePowerR > 0)

    local doorAlarm = 0
    doorAlarm = setBitValue(doorAlarm,self.Left.CloseRing and 1 or self.Right.CloseRing and 1 or 0,0,1)
    doorAlarm = setBitValue(doorAlarm,self.Left.CloseRingState                          and 1 or 0,1,1)
    doorAlarm = setBitValue(doorAlarm,self.Right.CloseRingState                         and 1 or 0,2,1)
    Train:SetNW2Int("BNT:DoorAlarm",doorAlarm)

    local volumes = 0
    local volAnn = self.Volumes.Ann
    local volUPO = self.Volumes.UPO
    if self.Volumes.Speed > 5 then
        volAnn = math.min(10,self.Volumes.Ann + self.Volumes.V5)
        volUPO = math.min(10,self.Volumes.UPO + self.Volumes.V5)
    end
    volumes = setBitValue(volumes,volAnn,0,4)
    volumes = setBitValue(volumes,volUPO,4,4)
    Train:SetNW2Int("BNT:Volumes",volumes)

    local statesLeft,statesRight = 0,0
    statesLeft = setBitValue(statesLeft,self.Left.Power and 1 or 0,0,1)
    statesLeft = setBitValue(statesLeft,self.Left.Init  and 1 or 0,1,1)
    statesLeft = setBitValue(statesLeft,self.Left.Back  and 1 or 0,2,1)
    statesLeft = setBitValue(statesLeft,self.Left.Next,            3,6)
    statesLeft = setBitValue(statesLeft,self.Left.Curr,            9,6)

    statesRight = setBitValue(statesRight,self.Right.Power and 1 or 0,0,1)
    statesRight = setBitValue(statesRight,self.Right.Init  and 1 or 0,1,1)
    statesRight = setBitValue(statesRight,self.Right.Back  and 1 or 0,2,1)
    statesRight = setBitValue(statesRight,self.Right.Next,            3,6)
    statesRight = setBitValue(statesRight,self.Right.Curr,            9,6)

    Train:SetNW2Int("BNT:Left",statesLeft)
    Train:SetNW2Int("BNT:Right",statesRight)
end

function TRAIN_SYSTEM:BNT(Power)
    if Power and not self.Power then
        self.Power = true
    end
    if not Power and self.Power then
        self.Power = false
        self.CloseRing = false
        self.CloseRingState = false
        self.CloseRingTimer = nil
        self.CurrTimer = nil
        self.Init = false
        self.Curr = 0
        self.Next = 0
        self.Back = false
    end
    
    if not self.Power then return end

    if self.CloseRing then
        if not self.CloseRingTimer then self.CloseRingTimer = CurTime() end
        self.CloseRingState = (CurTime() - self.CloseRingTimer)%1<0.5
        if CurTime() - self.CloseRingTimer > 30 then
            self.CloseRing = false
        end
    else
        if self.CloseRingTimer then
            self.CloseRingTimer = nil
            self.CloseRingState = false
        end
    end

    if not self.Init then
        if not self.CurrTimer then self.CurrTimer = CurTime() end
        if CurTime() - self.CurrTimer > 0.5 then
            self.Curr = self.Curr + 1
            if self.Curr > 32 then self.Curr = 0 end
            self.CurrTimer = CurTime()
        end
    else
        if self.CurrTimer then self.CurrTimer = nil end
    end
end
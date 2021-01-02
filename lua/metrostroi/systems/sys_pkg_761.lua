--------------------------------------------------------------------------------
-- Position switch (PKG-761)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PKG_761")

function TRAIN_SYSTEM:Initialize()
    --Positions
    self.PPS = 0
    self.PMT = 0
    --Contacts
    self.PS = 0
    self.PP = 0
    self.PM = 0
    self.PT = 0

    --Resistors
    self.RPS = 1e-15
    self.RPP = 1e-15
    self.RPM = 1e-15
    self.RPT = 1e-15

    --States
    self.PPSState = 0
    self.PMTState = 0
    self.RotationRate = 1.0/0.30
    --[[ self.Configuration = {}
    self.WrapsAround = true
--]]
    -- Rate of rotation (positions per second
    --self.RotationRate = 1.0/0.30

    -- Реле РПУ
    self.Train:LoadSystem("RPU","Relay","RPU-3",{normal_level = 2})
end

function TRAIN_SYSTEM:Inputs()
    return {"PS","PP","PM","PT"}
end
function TRAIN_SYSTEM:Outputs()
    return {"PS","PP","PM","PT"}
end
function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "PS" and value > 0 then
        self.PPSState = -1
    end

    if name == "PP" and value > 0 then
        self.PPSState =  1
    end

    if name == "PM" and value > 0 then
        self.PMTState = -1
    end

    if name == "PT" and value > 0 then
        self.PMTState =  1
    end
end
function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train

    -- Get currently selected position
    local PPSPos = math.floor(self.PPS+0.5)
    local PMTPos = math.floor(self.PMT+0.5)

    -- Move motor
    --local threshold = self.RotationRate -- Maximum single step of motor per frame
    self.PPS = math.max(0,math.min(1,self.PPS + self.RotationRate*dT*self.PPSState))
    self.PMT = math.max(0,math.min(1,self.PMT + self.RotationRate*dT*self.PMTState))


    self.PS = self.PPS <= 0.5 and 1 or 0
    self.PP = self.PPS >  0.5 and 1 or 0
    self.PM = self.PMT <= 0.5 and 1 or 0
    self.PT = self.PMT >  0.5 and 1 or 0
    self.RPS = 1e-15 + 1e15 * (1-self.PS)
    self.RPP = 1e-15 + 1e15 * (1-self.PP)
    self.RPM = 1e-15 + 1e15 * (1-self.PM)
    self.RPT = 1e-15 + 1e15 * (1-self.PT)
end

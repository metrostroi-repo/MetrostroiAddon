--------------------------------------------------------------------------------
-- ASOTP "IGLA" wagon controller unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("IGLA_PCBK")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.States = {}
    self.State = -1
    self.Timer = 0
    self.Time = 0

    self.KVC = 1

end
if TURBOSTROI then return end
function TRAIN_SYSTEM:Inputs()
    return {  "" }
end
function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
    if textdata== "Update" then
        self.Update = true
    end
end
function TRAIN_SYSTEM:CANWrite(name,value)
    self.Train:CANWrite("IGLA_PCBK",self.Train:GetWagonNumber(),"IGLA_CBKI",nil,name,value)
end
function TRAIN_SYSTEM:CState(name,value)
    if self.Update or self.States[name] ~= value then
        self.States[name] = value
        self.Train:CANWrite("IGLA_PCBK",self.Train:GetWagonNumber(),"IGLA_CBKI",nil,name,value)
    end
end
function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    if Train.VB.Value < 0.5 or self.Reset then
        self.Reset = false
        if self.State ~= -1 then
            self.State = -1
            self.Timer = nil
        end
    end
    if self.State == -1 and (Train.VB.Value > 0.5 and (not Train.A63 or Train.A63.Value > 0.5)) then
        self.State = 0
        self.Timer = CurTime()+math.random()*0.3
    end
    if self.State == 0 and CurTime()-self.Timer > 1.2 then
        self.State = 1
        self.Time = CurTime()
        self.EngageTimer = nil
    end
    if self.State == 1 and (CurTime() - self.Time) > 1.4 then
        if self.Update then
            self:CANWrite("Timer",CurTime())
        end
        self.Time= CurTime()+math.random()*0.4
        local schengaged = Train:ReadTrainWire(20)>0
        local schengagedD = schengaged and Train:ReadTrainWire(1)>0
        local schengagedB = schengaged and Train:ReadTrainWire(6)>0
        local RP = Train.RPvozvrat.Value > 0.5
        local DOORS = false
        local BPSN = false--Train.PowerSupply.XT3_1 <= 50
        local PARKING = false
        local MANUAL = false
        local BRAKES = false
        local SCHEME = false
        if schengaged then
            DOORS = Train.RD.Value < 0.5 and not schengagedB
            PARKING = Train.ParkingBrake and Train.ParkingBrake.Value > 0.5 and not schengagedB
            MANUAL = Train.ManualBrake and Train.ManualBrake > 0 and not schengagedB
            BRAKES = Train.Pneumatic.BrakeCylinderPressure > 0.5 and not schengagedB
            SCHEME = Train.LK4.Value == 0
            if BPSN and schengagedD and not self.BPSNTimer then self.BPSNTimer = CurTime() end
        else
            if (not BPSN or not self.States.BPSN) and self.BPSNTimer then self.BPSNTimer = nil end
        end
        if schengaged and SCHEME then
            if not self.EngageTimer then self.EngageTimer = CurTime() end
            if BRAKES and not self.BrakesTimer then self.BrakesTimer = CurTime() end
            if not BRAKES and self.BrakesTimer then self.BrakesTimer = nil end
        else
            if self.EngageTimer then self.EngageTimer = nil end
            if self.BrakesTimer then self.BrakesTimer = nil end
        end
        --[[ self:CState("SCHEME",self.EngageTimer and CurTime()-self.EngageTimer > 3)
        self:CState("RP",RP)
        self:CState("DOORS",DOORS)
        self:CState("BPSN",self.BPSNTimer and CurTime()-self.BPSNTimer > 7)
        self:CState("PARKING",PARKING)
        self:CState("MANUAL",MANUAL)
        self:CState("BRAKES",self.BrakesTimer and CurTime()-self.BrakesTimer > 3)
        self:CState("UAVA",Train.Pneumatic.EmergencyValve)
        if Train.IGLA_CBKI then
            --self:CState("EPK",Train.Pneumatic.EPKEnabled and Train.EPKContacts.Value == 0)
            --self:CState("UAVAK",Train.KV["10AS-33"] > 0 and Train.ALS_ARS.UAVAContacts)

            if Train.ALS_ARS then self:CState("ARS",Train.ALS_ARS.EnableARS and Train.KV["D4-15"] > 0 and math.max(20,Train.ALS_ARS.SpeedLimit)+9 < Train.ALSCoil.Speed) end
            self:CState("RU",Train.KRU and Train.KRU["14/1-B3"] > 0)
        end--]]
        self.Update = false
    end
end

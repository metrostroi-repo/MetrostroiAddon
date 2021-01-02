--------------------------------------------------------------------------------
-- ASOTP "IGLA" black wagon controller unit for 81-720
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_720_IGLA_PCBK")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.States = {}
    self.State = -1
    self.Timer = 0
    self.Time = 0

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
    local power = Train.Panel.PCBKPower > 0
    if not power or self.Reset then
        self.Reset = false
        if self.State ~= -1 then
            self.State = -1
            self.Timer = nil
        end
    end
    if self.State == -1 and power then
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
        local schengaged = Train.BUV.Brake > 0 or Train.BUV.Drive > 0
        local schengagedD = Train.BUV.Drive > 0
        local schengagedB = Train.BUV.Brake > 0
        local BV = Train.BV.Value  < 0.5
        local DOORS = false
        local BBE = Train.BUV.BBE == 0
        local PARKING = false
        local BRAKES = false
        local SCHEME = false
        if schengaged then
            for i=1,4 do
                DOORS = Train.Pneumatic.LeftDoorState[i] > 0 or Train.Pneumatic.RightDoorState[i] > 0
                if DOORS then break end
            end
            --PARKING = Train.ParkingBrake.Value > 0.5 and not schengagedB
            BRAKES = Train.Pneumatic.BrakeCylinderPressure > 0.5 and not schengagedB
            SCHEME = Train.K2.Value+Train.K3.Value == 0
            if BBE and schengagedD and not self.BBETimer then self.BBETimer = CurTime() end
        else
            if (not BBE or not self.States.BBE) and self.BBETimer then self.BBETimer = nil end
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
        self:CState("BV",BV)
        self:CState("DOORS",DOORS)
        self:CState("BBE",self.BBETimer and CurTime()-self.BBETimer > 7)
        self:CState("PARKING",PARKING)
        self:CState("BRAKES",self.BrakesTimer and CurTime()-self.BrakesTimer > 3)
        self:CState("UAVA",Train.Pneumatic.EmergencyValve)
        if Train.IGLA_CBKI then
            self:CState("ARS",Train.BARS.Active > 0 and Train.BUKP.ControllerState > 0 and math.max(20,Train.BARS.SpeedLimit)+9 < Train.ALSCoil.Speed)
            self:CState("RU",Train.RV["KRR15-16"] > 0)
        end--]]
        self.Update = false
    end
end

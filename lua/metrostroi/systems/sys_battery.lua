--------------------------------------------------------------------------------
-- Battery (HKH-80 type NiCd battery)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("Battery")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    -- Предохранители цепей (ПА1, ПА2)
    self.Train:LoadSystem("PA1","Relay","PP-28", { trigger_level = 31.5 }) -- A
    self.Train:LoadSystem("PA2","Relay","PP-28", { trigger_level = 31.5 }) -- A

    -- Battery parameters
    self.ElementCapacity    = 80                                -- A*hour
    self.Capacity = self.ElementCapacity * 3600
    self.Charge = self.Capacity
    -- Current through battery in amperes
    self.Current = 0
    self.Charging = 0
    self.ElementCount                   = 52
    self.StartVoltage                   = 75                    -- 1.44 volt per fully charged new NiCd-cell
    self.Voltage = self.StartVoltage
    self.IResistance                    = 0.018*52              -- 0.018 Ohm is a standard internal resistance of a fully-charged and rested new 80 Ah NiCd-cell
    self.SoC0v                          = 52                    -- 52 volts at 0% state of charge assuming 1.0 volt per fully discharged cell
    self.SoC                            = 100                   -- fully charged
    self.CutoffVoltage                  = 54.7                  -- 52 Volts actually, but due to lack of CC's current simulation train devices won't ever be shut down with this value
    self.Ibatt                          = 0
    self.eds_eq                         = 0
    self.hvcounter                      = 0
    self.Dischar = false
    self.ComputerCar = false
end

function TRAIN_SYSTEM:Inputs()
    return { "Charge", "Dischargeable", "InitialVoltage", "CarType" }
end
function TRAIN_SYSTEM:Outputs()
    return { "Capacity", "Charge", "Voltage" }
end
function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "Charge" then self.Charging = value end
    if name == "Dischargeable" then self.Dischar = value end
    if name == "InitialVoltage" then self.StartVoltage = value end
    if name == "CarType" then self.CarType = value end
end
function TRAIN_SYSTEM:Think(dT)
    if self.CarType == 1 then
        self.SoC = 100 * (self.Voltage - self.SoC0v)/(75 - self.SoC0v)
        if self.SoC > 60 then
            self.IResistance = 1e-4 * self.SoC + 0.012
        elseif 20 <= self.SoC and self.SoC <= 60 then
            self.IResistance = 0.018
        elseif self.SoC < 20 then
            self.IResistance = math.min(1.1, 0.018 + 1.56^(12-1.48*self.SoC))       -- just made it up by myself >_>
        end
        self.IResistance = self.IResistance * self.ElementCount
        
        if self.Train.ComputerCar then
            local nodecurr_sum, branchcond_sum = 0, 0
            local eds_eq = 0
            local hvcounter = 0
            for k,v in ipairs(self.Train.WagonList) do
                if v.PowerSupply.X2_2 > 0 and v.A24.Value > 0 then
                    hvcounter = hvcounter + 1
                end
            end
            --a "two-node method" of 10's wire voltage computing
            for k,v in ipairs(self.Train.WagonList) do
                nodecurr_sum = nodecurr_sum + v.A56.Value*(v.VB.Value*v.Battery.Voltage/v.Battery.IResistance + v.PowerSupply.X2_1*v.A24.Value*v.PowerSupply.VoltageOut/v.PowerSupply.IResistance)
                --+ 1/((1 - v.VB.Value*v.A49.Value)*1e12 + 1e3)
                branchcond_sum = branchcond_sum + 1/(v.LK4.Value > 0 and 20 or 1e12) + 1/(v.RV1.Value > 0 and 10 or 1e12) + 1/(v.KK.Value > 0 and 24 or 1e12) + 1/(1e3) + v.A56.Value*(v.VB.Value/v.Battery.IResistance + v.PowerSupply.X2_1*v.A24.Value/v.PowerSupply.IResistance)
            end
            eds_eq = nodecurr_sum/branchcond_sum
            for k,v in ipairs(self.Train.WagonList) do
                v.PowerSupply.car_control_load = eds_eq*(1/(v.LK4.Value > 0 and 20 or 1e12) + 1/(v.RV1.Value > 0 and 10 or 1e12) + 1/(v.KK.Value > 0 and 24 or 1e12))
                v.Battery.Ibatt = math.min(60,(math.min(1,(v.VB.Value*v.A56.Value+v.A24.Value))*v.VB.Value*((v.A56.Value*(eds_eq - v.Battery.Voltage) + v.PowerSupply.X2_1*(1-v.A56.Value)*(v.PowerSupply.VoltageOut*v.A24.Value - v.Battery.Voltage))))/v.Battery.IResistance) -- math.max(0,(2.4*(v.Battery.Voltage/v.Battery.StartVoltage)-2.39))
                v.Battery.eds_eq = eds_eq
                v.Battery.hvcounter = hvcounter
                v.eds_eq = v.Battery.eds_eq
                --print(v.PowerSupply.car_control_load,v.Battery.Ibatt,v.Battery.IResistance)
            end
        end
        -- Calculate discharge
        if self.Dischar then
            self.Train.BattCurrent = self.Ibatt*self.Train.A24.Value
            self.Train.PA1:TriggerInput("Close",self.Ibatt)
            self.Train.PA2:TriggerInput("Close",self.Ibatt)
            self.Charge = math.min(self.Capacity,self.Charge + self.Ibatt * (self.Ibatt < 0 and 1000/self.SoC0v or 500/self.SoC0v)* dT)--1.33*Capacity
        end
        -- Calculate battery voltage
        local batt_calc_voltage = math.max(self.StartVoltage,self.eds_eq*self.Train.VB.Value*self.Train.A56.Value,self.Train.PowerSupply.VoltageOut*self.Train.VB.Value*self.Train.A24.Value*self.Train.PowerSupply.X2_1)
        self.Voltage = batt_calc_voltage*(self.Charge/self.Capacity)
        --self.Voltage = self.StartVoltage*(self.Charge/self.Capacity)
    else
        -- Calculate discharge
        self.Current = 0--self.Train.KVC.Value*90*(self.Train.PowerSupply.XT3_1 > 0 and 3 or -1 + 4*self.Train:ReadTrainWire(27))*50*self.Train.Panel["V1"]
        --print(self.Train.Panel["V1"])
        self.Charge = math.min(self.Capacity,self.Charge + self.Current * dT)

        -- Calculate battery voltage
        if self.Train.PowerSupply then
            self.Voltage = 65*(self.Charge/self.Capacity) + ((self.Train.PowerSupply.XT3_1 or self.Charging) > 0 and 17 or 0)
        else
            self.Voltage = 65*(self.Charge/self.Capacity) + (self.Charging > 0 and 17 or 0)
        end
    end
    --print(self.eds_eq)
end
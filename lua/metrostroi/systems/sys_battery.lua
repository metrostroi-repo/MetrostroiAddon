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
    self.Train:LoadSystem("PA1","Relay","PP-28", { trigger_level = 31.5 })  -- A
    self.Train:LoadSystem("PA2","Relay","PP-28", { trigger_level = 31.5 })  -- A

    -- Battery parameters
    self.ElementCapacity                = 80                                -- A*hour
    self.Capacity                       = self.ElementCapacity * 3600
    self.Charge                         = self.Capacity
    self.FullCapacity                   = self.Capacity
    -- Current through battery in amperes
    self.Current = 0
    self.Charging = 0
    self.ElementCount                   = 52
    self.StartVoltage                   = 75                                -- 1.44 volt per fully charged new NiCd-cell
    self.Voltage = self.StartVoltage
    self.TargetVoltage                  = self.Voltage
    self.Vpart                          = 0
    self.CellIRes                       = 0.009                             -- 9 mOhm is a standard^w fake internal resistance of a fully-charged and rested new HKH-80 Ah NiCd-cell
    self.IResistance                    = self.CellIRes*self.ElementCount
    self.SoC0v                          = 52                                -- 52 volts at 0% state of charge assuming 1.0 volt per fully discharged cell
    self.SoC                            = 1.00                              -- fully charged
    self.CutoffVoltage                  = 45                                -- we want deep discharge <_<
    self.EthaCE0                        = 0.94                              -- Coulomb efficiency coeff
    self.EthaCE                         = self.EthaCE0
    self.Ibatt                          = 0
    self.eds_eq                         = 0
    self.hvcounter                      = 0
    self.Consumers                      = {}
    --self.Ibatt_sigma                    = 0
    --self.CCcurrent_sigma                = 0
    self.Dischar                        = false
    self.ComputerCar                    = false

    ---------------------------------------------
    -- 10 mV/min — voltage covery/recovery speed during first 30 minutes after charging/discharging stopped
    -- 1.0 (1.2) Volt/cell    - fully discharged under load (OCV)
    -- 1.7 (1.44) Volt/cell    - fully charged under load (OCV)
    ---------------------------------------------

    for k,v in pairs(self.Train.Systems) do
        if v.hasCoil and not self.Consumers[v] then
            --print("Registering relay",v.Name, "Train: ", self.Train)
            self.Consumers[v] = {0,v.coil_res,0}
        end
    end
    --print "------------------\n"
end

-- TODO: - расставить параметры для всех оставшихся реле (убедиться, что подъемный ток ниже номинального)

-- self.Consumers is a table of relays with the next structure:
--      [<relay>] = {<relay.Value>, <relay.coil_res>, <relay.current>}

function TRAIN_SYSTEM:Inputs()
    return { "Charge", "Dischargeable", "InitialVoltage", "CarType", "Computer" }
end
function TRAIN_SYSTEM:Outputs()
    return { "Capacity", "Charge", "Voltage", "eds_eq" }
end
function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "Charge" then self.Charging = value end
    if name == "Dischargeable" then self.Dischar = value end
    if name == "InitialVoltage" then self.StartVoltage = value end
    if name == "CarType" then self.CarType = value end
end

local function GetBranchCondSum(consumers)
    local br = 1e-12
    for m,n in pairs(consumers) do
        br = br + 1/(n[1] > 0 and n[2] or 1e12)
    end
    return br
end

function TRAIN_SYSTEM:Think(dT)
    if self.CarType == 1 then

        for k,v in pairs(self.Consumers) do
            v[1] = k.Value
            v[3] = k.Current
        end

        if self.Train.ComputerCar then
            local nodecurr_sum, branchcond_sum = 0.0, 0.0
            local eds_eq = 0.0
            local hvcounter = 0
            --self.Ibatt_sigma = 0
            --self.CCcurrent_sigma = 0

            for k,v in ipairs(self.Train.WagonList) do
                if v.PowerSupply.X2_2 > 0 and v.A24.Value > 0 then
                    hvcounter = hvcounter + 1
                end
            end
            --a "two-node method" of 10's wire voltage computing
            for k,v in ipairs(self.Train.WagonList) do
                nodecurr_sum = nodecurr_sum + v.A56.Value*(v.VB.Value*v.Battery.Voltage/v.Battery.IResistance + v.PowerSupply.X2_1*v.A24.Value*v.PowerSupply.VoltageOut/v.PowerSupply.IResistance)
                --+ 1/((1 - v.VB.Value*v.A49.Value)*1e12 + 1e3)
                branchcond_sum = branchcond_sum + GetBranchCondSum(v.Battery.Consumers) + v.A56.Value*(v.VB.Value/v.Battery.IResistance + v.PowerSupply.X2_1*v.A24.Value/v.PowerSupply.IResistance)

                --[[branchcond_sum = branchcond_sum + 1/(v.LK4.Value > 0 and 20 or 1e12) + 1/(v.RV1.Value > 0 and 10 or 1e12)
                                                + 1/(v.KK.Value > 0 and 24 or 1e12) + 1/(1e3)
                                                + 1/(v.RC1 and v.RC1.Value > 0 and 32 or 1e12)
                                                + 1/(v.Panel.Headlights1 and v.Panel.Headlights1 > 0 and 38 or 1e12)
                                                + 1/(v.Panel.Headlights2 and v.Panel.Headlights2 > 0 and 38 or 1e12)
                                                + v.A56.Value*(v.VB.Value/v.Battery.IResistance + v.PowerSupply.X2_1*v.A24.Value/v.PowerSupply.IResistance)]]
            end
            eds_eq = nodecurr_sum/branchcond_sum
            --print(eds_eq, nodecurr_sum, branchcond_sum)
            for k,v in ipairs(self.Train.WagonList) do
                v.PowerSupply.car_control_load = eds_eq*GetBranchCondSum(v.Battery.Consumers)
                --[[v.PowerSupply.car_control_load = eds_eq*(1/(v.LK4.Value > 0 and 20 or 1e12) + 1/(v.RV1.Value > 0 and 10 or 1e12)
                                                        + 1/(v.RC1 and v.RC1.Value > 0 and 32 or 1e12)
                                                        + 1/(v.Panel.Headlights1 and v.Panel.Headlights1 > 0 and 38 or 1e12)
                                                        + 1/(v.Panel.Headlights2 and v.Panel.Headlights2 > 0 and 38 or 1e12)
                                                        + 1/(v.KK.Value > 0 and 24 or 1e12))]]
                v.Battery.Ibatt = math.min(1,(2-self.Train.PA1.Value-self.Train.PA2.Value))
                            *(math.min(1,(v.VB.Value*v.A56.Value+v.A24.Value))*v.VB.Value*((v.A56.Value*(eds_eq - v.Battery.Voltage)
                            + v.PowerSupply.X2_1*(1-v.A56.Value)*(v.PowerSupply.VoltageOut*v.A24.Value - v.Battery.Voltage))))/v.Battery.IResistance -- math.max(0,(2.4*(v.Battery.Voltage/v.Battery.StartVoltage)-2.39))
                --self.Ibatt_sigma = self.Ibatt_sigma + v.Battery.Ibatt
                --self.CCcurrent_sigma = self.CCcurrent_sigma + v.PowerSupply.car_control_load
                v.Battery.eds_eq = eds_eq
                v.Battery.hvcounter = hvcounter
                v.eds_eq = v.Battery.eds_eq
                if self.Train.R_VPR and self.Train.R_VPR.Value < 0.5 then
                    print(v.eds_eq, nodecurr_sum, branchcond_sum)
                    --print(v.PowerSupply.car_control_load,v.Battery.Ibatt,v.Battery.IResistance)
                end
            end
            --for k,v in ipairs(self.Train.WagonList) do
                --v.Battery.Ibatt_sigma = self.Ibatt_sigma
                --v.Battery.CCcurrent_sigma = self.CCcurrent_sigma
            --end
        end
        -- Calculate state of charge, internal resistance and battery voltage
        if self.Dischar then
            self.Capacity = self.Capacity - dT * (self.FullCapacity*0.1/86400)               -- make capacity loss ~ 10% per day (just a game abstraction)
            if self.Ibatt > 0 then
                if self.Ibatt >= 8 then
                    local kCE = (self.EthaCE0 - 0.5)/72
                    local aCE = kCE*80 + 0.5
                    self.EthaCE = aCE - kCE * math.abs(self.Ibatt)
                else
                    self.EthaCE = 0.94-5*math.exp(-self.Ibatt)
                end
            else
                if self.SoC <= 1.0 then
                    self.EthaCE = 1
                else
                    self.EthaCE = 0.5*math.exp(2.6*self.SoC) - 5.73         -- не бывает!
                end
            end

            if self.SoC <= 0 or self.SoC >= 1.0 then self.EthaCE = 0 end

            -- Возможно, надо ввести ток саморазряда, а не ебаться с выдуманной зависимостью EthaCE от SoC выше 100% (которого не бывает >_>)
            --local CellIResTarget, irt_sign = self.CellIRes, 0
            self.SoC = self.SoC + self.EthaCE*self.Ibatt*dT/self.Capacity
            local SoC = math.max(0,math.min(100,self.SoC*100))
            if 50 <= SoC and SoC <= 100 then
                self.CellIRes = 0.009
            elseif SoC >= 0.5 then
                self.CellIRes = (9+0.1*(50-SoC))*10^(-3)
            -- 0.035C and 0.08C (idk why...)
            elseif self.Ibatt < -0.035*self.ElementCapacity or (0.014 < self.CellIRes and self.CellIRes < 0.8296 and self.Ibatt > 0.08*self.ElementCapacity) then
                -- SoC less than 0.5% and discharging or Vbatt approx. 62 - 52 V and charging
                if 55 <= self.Voltage and self.Voltage < 62 then
                    self.CellIRes = 112 - 14*(self.Voltage - 55)
                elseif 50 <= self.Voltage and self.Voltage < 55 then
                    self.CellIRes = 1308 - 239.2*(self.Voltage - 50)
                end
                --irt_sign = self.CellIRes > CellIResTarget and -1 or 1
                --self.CellIRes = self.CellIRes + irt_sign*0.001
            end
            self.IResistance = self.CellIRes * self.ElementCount

            --self.Train.BattCurrent = self.Ibatt*self.Train.A24.Value
            self.Train.PA1:TriggerInput("Close",math.abs(self.Ibatt)/2)     -- Это неправильно, но я уже заебалась
            self.Train.PA2:TriggerInput("Close",math.abs(self.Ibatt)/2)
            -- Supposed battery voltage range from 29 to 82 volts
            --self.Charge = math.max(-self.Capacity,math.min(1.32*self.Capacity,self.Charge + self.Ibatt * --[[(self.Ibatt < 0 and 1000/self.SoC0v or 500/self.SoC0v)*]] dT))
        end                                                                                                    --                     ^
        -- Calculate battery voltage                                                                           --                     |
        --self.Voltage = self.StartVoltage*(self.Charge/self.Capacity)                                         -- симуляция потери емкости батареи (future feature) — хуюче

        -- Polynomials for battery OCV calculation during charge and discharge (source: https://www.mdpi.com/1996-1073/16/21/7291)
        -- Roughly, Vbatt_charge = EMF(SOC) + 𝑈ℎ(SOC), Vbatt_discharge = EMF(SOC) - 𝑈ℎ(SOC)

        --EMF(SOC)=−0.68175SOC^8+8.82823SOC^7−24.43179SOC^6+31.87221SOC^5−23.97881SOC^4+11.24774SOC^3−3.40685SOC^2+0.74692SOC+1.22076
        --𝑈ℎ(SOC)=2.62496SOC^8−12.77132SOC^7+22.37586SOC^6−18.04921SOC^5+6.14667SOC^4+0.26467SOC^3−0.82125SOC^2+0.21246SOC+0.02641

        -- open circuit voltage calculation
        local EMF_soc, Uh_soc, tvb_sign
        EMF_soc=-0.68175*self.SoC^8+8.82823*self.SoC^7-24.43179*self.SoC^6+31.87221*self.SoC^5-23.97881*self.SoC^4+11.24774*self.SoC^3-3.40685*self.SoC^2+0.74692*self.SoC+1.22076
        Uh_soc=2.62496*self.SoC^8-12.77132*self.SoC^7+22.37586*self.SoC^6-18.04921*self.SoC^5+6.14667*self.SoC^4+0.26467*self.SoC^3-0.82125*self.SoC^2+0.21246*self.SoC+0.02641

        -- Need to implement:
        -- Battery voltage (EMF in our case) growth rate at SoC > 90%:      0.25 volt per 10%
        -- Battery voltage (EMF in our case) decrease rate at SoC < 10%:    0.20 volt per 10%
        --[[local i_bat = math.abs(self.Ibatt)
        if self.SoC > 1.0 then
            self.Voltage = 75 + math.exp(2-9*self.SoC)
        elseif self.SoC > 0.2 then
            local Kmin, Kmax = 3/0.8, 13/0.8
            local KaCe = (Kmax - Kmin)/(63-8)
            local Akc = Kmax-63*KaCe
            local Kdis = Akc+KaCe*i_bat
            local Avb = 75
            TargVbatt = Avb - Kdis*self.SoC
        else
            local Ka = (75-68)/(64-8)
            local Ai = (64-i_bat)*Ka+68
            local Kb = (24-13)/(64-8)
            local Bi = (i_bat-8)*Kb+13
            TargVbatt = Ai - Bi*math.exp(-7*self.SoC)
        end]]
        if self.Ibatt > 0.005*self.ElementCapacity then
            self.TargetVoltage = EMF_soc + Uh_soc
            if self.SoC > 0.9 and self.Ibatt > 0.005*self.ElementCapacity then
                if self.Vpart < 0 then self.Vpart = 0 end
                self.Vpart = math.min(0.3,self.Vpart + 0.05)
                self.TargetVoltage =  math.min(self.eds_eq/self.ElementCount, self.TargetVoltage + self.Vpart)
            end
        else
            self.TargetVoltage = EMF_soc - Uh_soc
            if self.SoC < 0.1 and self.Ibatt < -0.005*self.ElementCapacity then
                if self.Vpart > 0 then self.Vpart = 0 end
                self.Vpart = math.max(-0.2, self.Vpart - 0.05)
                self.TargetVoltage = math.max(0.8, self.TargetVoltage + self.Vpart)
            end
        end
        self.TargetVoltage = self.TargetVoltage*self.ElementCount
        --print("Target Voltage = "..TargVbatt, self.Train)

        tvb_sign = self.Voltage > self.TargetVoltage and -1 or 1
        self.Voltage = self.Voltage + tvb_sign*0.05
        --self.Voltage = self.Voltage + (TargVbatt - self.Voltage)*dT*0.05
        --self.Voltage = (75-self.SoC0v)*(self.Charge/self.Capacity)+self.SoC0v

        -- DEBUG
        -- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if self.Train.R_VPR and self.Train.R_VPR.Value < 0.5 then
            --local tval = 1
            --print("Target Voltage = "..self.TargetVoltage, "self.Voltage = "..self.Voltage, "train:",self)
            --print("self.SoC = "..self.SoC, "self.Ibatt = "..self.Ibatt)
            --print("self.eds_eq = "..self.eds_eq)
            --print("self.EthaCE = "..self.EthaCE, "self.IResistance = "..self.IResistance)
            --print("self.Capacity = "..self.Capacity)
            --[[
            EMF_soc=-0.68175*tval^8+8.82823*tval^7-24.43179*tval^6+31.87221*tval^5-23.97881*tval^4+11.24774*tval^3-3.40685*tval^2+0.74692*tval+1.22076
            Uh_soc=2.62496*tval^8-12.77132*tval^7+22.37586*tval^6-18.04921*tval^5+6.14667*tval^4+0.26467*tval^3-0.82125*tval^2+0.21246*tval+0.02641
            print("EMF_soc = "..EMF_soc, "Uh_soc = "..Uh_soc)--]]
        end
        -- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
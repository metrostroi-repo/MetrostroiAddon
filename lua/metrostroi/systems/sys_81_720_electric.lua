--------------------------------------------------------------------------------
-- 81-720 electric schemes
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_720_Electric")
TRAIN_SYSTEM.DontAccelerateSimulation = false



function TRAIN_SYSTEM:Initialize()
    -- Линейный контактор К1 (КР)
    self.Train:LoadSystem("K1","Relay","PK-162",{bass = true,close_time=0.1})
    -- Линейный контактор К2 (Ход)
    self.Train:LoadSystem("K2","Relay","PK-162",{bass = true,close_time=0.1})
    -- Линейный контактор К3 (Тормоз)
    self.Train:LoadSystem("K3","Relay","PK-162",{bass = true,close_time=0.1})

    -- Контактор(ы) реверса "Вперёд"
    self.Train:LoadSystem("KMR1","Relay","PK-162",{bass = true,close_time=0.1})
    -- Контактор(ы) реверса "Назад"
    self.Train:LoadSystem("KMR2","Relay","PK-162",{bass = true,close_time=0.1})

    -- General power output
    self.Main750V = 0.0
    self.Aux750V = 0.0
    self.Power750V = 0.0
    self.Aux80V = 0.0
    self.Lights80V = 0.0
    self.Battery80V = 0.0

    -- Resistances
    self.R1 = 1e9
    self.R2 = 1e9
    self.R3 = 1e9
    self.Rs1 = 1e9
    self.Rs2 = 1e9

    self.Rstator13 = 1e9
    self.Rstator24 = 1e9
    self.Ranchor13  = 1e9
    self.Ranchor24  = 1e9

    -- Electric network info
    self.Itotal = 0.0
    self.I13 = 0.0
    self.I24 = 0.0
    self.Ustator13 = 0.0
    self.Ustator24 = 0.0
    self.Ishunt13  = 0.0
    self.Istator13 = 0.0
    self.Ishunt24  = 0.0
    self.Istator24 = 0.0
    self.Utotal = 0.0
    -- Calculate current through rheostats 1, 2
    self.IR1 = self.Itotal
    self.IR2 = self.Itotal
    self.IRT2 = self.Itotal
    self.T1 = 25
    self.T2 = 25
    self.P1 = 0
    self.P2 = 0
    self.Overheat1 = 0
    self.Overheat2 = 0

    -- Total energy used by train
    self.ElectricEnergyUsed = 0 -- joules
    self.ElectricEnergyDissipated = 0 -- joules
    self.EnergyChange = 0

    --Train wire outside power
    -- Need many iterations for engine simulation to converge
    self.SubIterations = 16

    self.Train:LoadSystem("BV","Relay")
    self.Train:LoadSystem("GV","Relay","GV_10ZH",{bass=true})
    -- Thyristor contrller
    self.IX = 0
    self.IT = 0


    self.BTB = 0
    self.KTR = 0
    self.V2 = 0
    self.V1 = 0
    self.BVKA_KM1 = 0
    self.BVKA_KM2 = 0
    self.BVKA_KM3 = 0
    self.BVKA_KM4 = 0
    self.BVKA_KM5 = 0
    self.Vent1 = 0
    self.Vent2 = 0
    self.BSKA = 0

    self.BPTI_V = 0
    self.BPTI_ZKK = 0

    self.BUTP = 0
    self.ISet = 0
    --self.Train:LoadSystem("Telemetry",nil,"",{"Electric","Panel","Engines"})
end


function TRAIN_SYSTEM:Inputs()
    return { }
end

function TRAIN_SYSTEM:Outputs()
    return { "I13","I24","Itotal", "IT", "IX",
        --[[
                    "Rs1","Rs2","Itotal","I13","I24","IRT2",
                 "Ustator13","Ustator24","Ishunt13","Istator13","Ishunt24","Istator24",
                 "Uanchor13","Uanchor24","U13","U24","Utotal","RVState",--]]
             "Main750V", "Power750V", "Aux750V", "Aux80V", "Lights80V", "Battery80V", --[[
             "ElectricEnergyUsed", "ElectricEnergyDissipated", "EnergyChange",
             "RPSignalResistor"]]
             "RNState", "RN",
             "BTB","V2","V1",
             "BVKA_KM1","BVKA_KM2","BVKA_KM3","BVKA_KM4","BVKA_KM5",
             "Vent1","Vent2",
             "BSKA","BPTI_V","BPTI_ZKK","BUTP","ISet"
        }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end



--------------------------------------------------------------------------------
function TRAIN_SYSTEM:Think(dT,iter)
    local Train = self.Train
    --  local dT = dT/8
    ----------------------------------------------------------------------------
    -- Voltages from the third rail
    ----------------------------------------------------------------------------
    self.Main750V = Train.TR.Main750V
    self.Aux750V  = Train.TR.Main750V
    self.Power750V = self.Main750V*Train.GV.Value


    ----------------------------------------------------------------------------
    -- Information only
    ----------------------------------------------------------------------------
    local BBE = Train.BUV.BBE > 0
    self.Aux80V = BBE and 82 or 65
    self.Lights80V = BBE and 82 or 0--Train.PowerSupply.XT3_4

    self.Battery80V = (Train.Battery.Value > 0) and (BBE and 82 or 65) or 0
    Train:WriteTrainWire(1,self.Battery80V > 62 and 1 or 0)

    ----------------------------------------------------------------------------
    -- Some internal electric
    ----------------------------------------------------------------------------
    local P = self.Battery80V > 62 and 1 or 0
    local HV = 550 < self.Main750V and self.Main750V < 975 and 1 or 0
    --(RV)
    local Panel = Train.Panel
    if Train.RV then
        local RV = Train.RV
        Train:WriteTrainWire(2,P*Train.SF19.Value*Train.EnableBVEmer.Value)
        Train:WriteTrainWire(34,P*(RV["KRO1-2"]*Train.SF2.Value + RV["KRR1-2"]*Train.SF3.Value))
        Train:WriteTrainWire(36,Train.SF3.Value*Train.EmergencyControls.Value)

        Train:WriteTrainWire(19,P*RV["KRR7-8"]*Train.SF10.Value*Train.BARS.BTB*Train.EmerX1.Value)
        Train:WriteTrainWire(45,P*RV["KRR7-8"]*Train.SF10.Value*Train.BARS.BTB*Train.EmerX2.Value)
        Train:WriteTrainWire(3,P*(RV["KRO9-10"]+RV["KRR7-8"])*Train.SF10.Value)
        Train:WriteTrainWire(4,0)
        local KM1 = P*Train.SF6.Value*RV["KRO11-12"]
        local KM2 = P*Train.SF6.Value*RV["KRO15-16"]
        Train:WriteTrainWire(11,P*Train.ParkingBrake.Value)
        Train:WriteTrainWire(12,P*(RV["KRR3-4"]+KM1)*Train.SF11.Value)
        Train:WriteTrainWire(13,P*(RV["KRR9-10"]+KM2)*Train.SF11.Value)

        self.V2 = P*(RV["KRO13-14"]*Train.SF19.Value + RV["KRR11-12"]*Train.SF20.Value)
        self.V1 = P*(RV["KRO13-14"]*Train.SF19.Value + RV["KRR11-12"]*Train.SF20.Value)*Train.HornB.Value

        local BTBp = P*(RV["KRO13-14"]*Train.SF19.Value + RV["KRR11-12"]*Train.SF20.Value)*(1-Train.Pneumatic.SD2)
        Train:WriteTrainWire(27,BTBp)
        local BTBm = (Train.BARS.BTB+Train.ALS.Value*(Train.BARSBlock.Value==3 and 1 or 0))
        local BTB = math.min(1,BTBp*BTBm)
        Panel.EmerBrakeWork = BTB*Train.EmerBrake.Value
        Train:WriteTrainWire(28,Panel.EmerBrakeWork)
        --BTB KT KO Logic
        if Panel.EmerBrakeWork > 0 then
            if Train.EmerBrakeAdd.Value > 0 and not self.KT then
                self.KTR = math.min(3,self.KTR + 1)
                self.KT = true
            elseif Train.EmerBrakeAdd.Value == 0 then
                self.KT = false
            end
            if Train.EmerBrakeRelease.Value > 0 and not self.KO then
                self.KTR = math.max(0,self.KTR - 1)
                self.KO = true
            elseif Train.EmerBrakeRelease.Value == 0 then
                self.KO = false
            end
            Train:WriteTrainWire(29,self.KTR>1 and 1 or 0)
            Train:WriteTrainWire(30,self.KTR>0 and 1 or 0)
        else
            if self.KTR > 0 then self.KTR = 0 end
            Train:WriteTrainWire(29,0)
            Train:WriteTrainWire(30,0)
        end
        --[[ Train:WriteTrainWire(24,BTB*(1-Train.EmergencyBrake.Value))
        Train:WriteTrainWire(25,BTB == 0 and Train:ReadTrainWire(26) > 0 and Train:ReadTrainWire(24)*self.BTB or 0)
        Train:WriteTrainWire(26,BTB*(Train.BARS.BTB))
        if Train:ReadTrainWire(26) > 0 and Train:ReadTrainWire(24) == 0 then self.BTB = 0 elseif Train:ReadTrainWire(26) == 0 then self.BTB = 1 end--]]

        if BTB > 0 then
            if self.BTBTimer == nil then self.BTBTimer = CurTime() end
            if self.BTBTimer and CurTime()-self.BTBTimer>0.3 then self.BTBTimer = false end
        else
            self.BTBTimer = nil
        end
        self.BTB = math.min(1,(self.BTBTimer~=false and 1 or 0)+self.BTB*Train:ReadTrainWire(26))
        Train:WriteTrainWire(26,(1-BTB)*Train:ReadTrainWire(24)*(1-Train.EmergencyBrake.Value))
        Train:WriteTrainWire(24,BTB*(1-Train.EmergencyBrake.Value))
        Train:WriteTrainWire(25,BTB*self.BTB*(self.KTR==3 and 0 or 1))
        Train:WriteTrainWire(10,P*Train.EmergencyCompressor.Value)

        Train:WriteTrainWire(40,P*Train.EmergencyDoors.Value)
        Train:WriteTrainWire(39,P*Train.SF22.Value*Train.EmerCloseDoors.Value)
        Train:WriteTrainWire(38,P*Train.SF21.Value*Train.DoorLeft.Value)
        Train:WriteTrainWire(37,P*Train.SF21.Value*Train.DoorRight.Value)

        local ASNP_VV = Train.ASNP_VV
        Panel.R_Announcer = P*Train.SF8.Value*Train.R_Announcer.Value
        Panel.R_Line = P*Train.SF8.Value*Panel.R_Announcer*Train.R_Line.Value
        ASNP_VV.Power = P*Train.SF8.Value*Train.R_ASNPOn.Value
        ASNP_VV.AmplifierPower = ASNP_VV.Power*Train.ASNP.LineOut*Train.R_Announcer.Value*(1-Train.R_Line.Value)
        Train:WriteTrainWire(20,ASNP_VV.AmplifierPower)
        --ASNP_VV.CabinSpeakerPower = ASNP_VV.Power*Train.ASNP.LineOut*Train.R_G.Value
        Panel.DoorLeft = P*Train.SF21.Value*Train.DoorSelectL.Value*(1-Train.DoorSelectR.Value)
        Panel.DoorRight = P*Train.SF21.Value*Train.DoorSelectR.Value*(1-Train.DoorSelectL.Value)
        Panel.DoorClose = P*Train.SF22.Value*Train.DoorClose.Value
        Panel.DoorBlock = P*Train.DoorBlock.Value
        Panel.Ticker = P*Train.SF8.Value*Train.Ticker.Value
        Panel.PassScheme = P*Train.SF8.Value*Train.PassScheme.Value
        Train:WriteTrainWire(15,Panel.Ticker)
        Train:WriteTrainWire(16,Panel.PassScheme)
        Panel.PassSchemeControl = Panel.PassScheme*(RV["KRO9-10"]+RV["KRR7-8"])*Train.SF10.Value
        Panel.KAH = P*Train.KAH.Value
        Panel.ALS = P*Train.ALS.Value
        --Panel.AccelRate = P*Train.AccelRate.Value
        Panel.EqLights = P*Train.SF15.Value*Train.AppLights1.Value
        Panel.CabLights = P*Train.SF15.Value*Train.CabLight.Value*(0.5+Train.CabLightStrength.Value*0.5)

        Panel.Headlights1 = P*(RV["KRO3-4"]+RV["KRR5-6"])*Train.Headlights1.Value*Train.SF12.Value
        Panel.Headlights2 = P*(RV["KRO3-4"]+RV["KRR5-6"])*Train.Headlights2.Value*Train.SF13.Value
        Panel.RedLights = P*(RV["KRO7-8"]+RV["KRR9-10"])*Train.SF14.Value
        Panel.CBKIPower = P*Train.SF7.Value
    end
    Panel.PCBKPower = P*Train.SFV10.Value
    Panel.AnnouncerPlaying = Train:ReadTrainWire(20)*Train.SFV16.Value
    Panel.TickerPower = P*Train.SFV30.Value
    Panel.TickerWork = Panel.TickerPower*Train:ReadTrainWire(15)
    Panel.PassSchemePower = P*Train.SFV16.Value
    Panel.PassSchemeWork = Panel.PassSchemePower*Train:ReadTrainWire(16)
    self.BVKA_KM1 = P*HV*Train.SFV11.Value*(Train.BUV.MK+Train:ReadTrainWire(10))
    local KM2 = P*(Train:ReadTrainWire(34)*Train.SFV4.Value + Train:ReadTrainWire(36)*Train.SFV5.Value)*Train.SFV1.Value
    if self.BVKA_KM2 ~= KM2 then
        if self.BVKA_KM2 == 0 then
            Train:PlayOnce("batt_on","bass",1)
        end
        self.BVKA_KM2 = KM2
    end
    self.BVKA_KM3 = P*HV*Train.SFV23.Value*(Train.BUV.Vent1)
    self.BVKA_KM4 = P*HV*Train.SFV24.Value*(Train.BUV.Vent2)
    self.BVKA_KM5 = P
    self.BSKA = P*Train.SFV6.Value*self.BVKA_KM2

    self.Vent1 = P*Train.SFV25.Value*self.BVKA_KM3
    self.Vent2 = P*Train.SFV26.Value*self.BVKA_KM4

    self.BPTI_V = P*Train.SFV27.Value*self.BVKA_KM5
    self.BPTI_ZKK = P*Train.SFV28.Value

    local emer = Train:ReadTrainWire(45)+Train:ReadTrainWire(19)
    self.BUTP = P*self.BVKA_KM2*Train.SFV3.Value*Train.SFV6.Value

    --Train:WriteTrainWire(12,RV["KRO9-10"]*Train.SF10.Value)
    --Train:WriteTrainWire(13,RV["KRO9-10"]*Train.SF10.Value)
    ----------------------------------------------------------------------------
    -- Solve circuits
    ----------------------------------------------------------------------------
    local bv = Train.BV.Value
    local strength,brake,drive = 0,0,0
    if emer > 0 then
        strength = Train:ReadTrainWire(45) > 0 and 4 or Train:ReadTrainWire(19) > 0 and 1 or 0
        drive = strength*self.BUTP*bv
    else
        brake = Train.BUV.Brake*self.BUTP
        drive = Train.BUV.Drive*self.BUTP*HV*bv
        strength = Train.BUV.DriveStrength
    end

    self.VP = self.BSKA*(drive+brake)*Train:ReadTrainWire(12)*(1-Train:ReadTrainWire(13))
    self.NZ = self.BSKA*(drive+brake)*Train:ReadTrainWire(13)*(1-Train:ReadTrainWire(12))
    self.IX = drive*(1-brake)*(self.VP+self.NZ)
    self.IT = brake*(1-drive)*(self.VP+self.NZ)
    if bv==0 or Train.BPTI.Zero or self.IX==0 and self.IT==0 and self.BPTIState==0 then
        Train.KMR1:TriggerInput("Set",0)
        Train.KMR2:TriggerInput("Set",0)

        Train.K1:TriggerInput("Set",0)
        Train.K2:TriggerInput("Set",0)
        Train.K3:TriggerInput("Set",0)
        self.Shunt = false
    elseif self.IX>0 and Train.BPTI.State >= 0 then
        Train.KMR1:TriggerInput("Set",self.VP)
        Train.KMR2:TriggerInput("Set",self.NZ)

        Train.K1:TriggerInput("Set",self.IX)
        Train.K2:TriggerInput("Set",self.IX)
        Train.K3:TriggerInput("Set",0)
    elseif self.IT>0 and Train.BPTI.State <= 0  then
        Train.KMR1:TriggerInput("Set",self.VP)
        Train.KMR2:TriggerInput("Set",self.NZ)

        Train.K1:TriggerInput("Set",0)
        Train.K2:TriggerInput("Set",0)
        Train.K3:TriggerInput("Set",self.IT)
    end
    if bv==0 then
        self.ISet = 0
        self.BPTIState = 0
    elseif Train.K2.Value > 0 and self.IX > 0 then
        self.BPTIState = 1
        if strength == 1 then
            self.ISet = 100
        elseif strength == 2 then
            self.ISet = 200 + 60*Train.Pneumatic.WeightLoadRatio
        elseif strength == 3 then
            self.ISet = 260 + 60*Train.Pneumatic.WeightLoadRatio
        elseif strength == 4 then
            self.ISet = 330 + 60*Train.Pneumatic.WeightLoadRatio
        end
    elseif Train.K3.Value > 0 and self.IT > 0 then
        self.BPTIState = -1
        if strength == 1 then
            self.ISet = 150 + 50*Train.Pneumatic.WeightLoadRatio
        elseif strength == 2 then
            self.ISet = 230 + 70*Train.Pneumatic.WeightLoadRatio
        elseif strength == 3 then
            self.ISet = 310 + 120*Train.Pneumatic.WeightLoadRatio
        end
    elseif Train.BPTI.Zero then
        self.ISet = 0
        self.BPTIState = 0
    elseif Train.BPTI.State == 1 and drive == 0 or Train.BPTI.State == -1 and brake == 0 then
        self.ISet = 0
    end
    local Current = math.abs(self.I13 + self.I24)/2
    Train.BV:TriggerInput("Open",(Current > 1000) and 1 or 1-Train.SFV9.Value)
    self:SolvePowerCircuits(Train,dT,iter)


    ----------------------------------------------------------------------------
    -- Calculate current flow out of the battery
    ----------------------------------------------------------------------------
    --local totalCurrent = 5*A30 + 63*A24 + 16*A44 + 5*A39 + 10*A80
    --local totalCurrent = 20 + 60*DIP
end


--------------------------------------------------------------------------------
function TRAIN_SYSTEM:SolvePowerCircuits(Train,dT,iter)
    self.Rs1 = Train.BPTI.RVResistance
    self.Rs2 = Train.BPTI.RVResistance

    -- Calculate total resistance of engines winding
    local RwAnchor = Train.Engines.Rwa*2 -- Double because each set includes two engines
    local RwStator = Train.Engines.Rws*2
    -- Total resistance of the stator + shunt
    self.Rstator13  = (RwStator^(-1) + self.Rs1^(-1))^(-1)
    self.Rstator24  = (RwStator^(-1) + self.Rs2^(-1))^(-1)
    -- Total resistance of entire motor
    self.Ranchor13  = RwAnchor
    self.Ranchor24  = RwAnchor

    if Train.BPTI.State < 0 then
        self:SolvePT(Train)
    else
        self:SolvePP(Train)
    end
    -- Calculate current through rheostats 1, 2
    self.IR1 = self.I13
    self.IR2 = self.I24

    -- Calculate induction properties of the motor
    self.I13SH = self.I13SH or self.I13
    self.I24SH = self.I24SH or self.I24

    -- Time constant
    local T13const1 = math.max(16.00,math.min(28.0,(self.R13^2) * 2.0)) -- R * L
    local T24const1 = math.max(16.00,math.min(28.0,(self.R24^2) * 2.0)) -- R * L
    -- Total change
    local dI13dT = T13const1 * (self.I13 - self.I13SH) * dT
    local dI24dT = T24const1 * (self.I24 - self.I24SH) * dT

    -- Limit change and apply it
    if dI13dT > 0 then dI13dT = math.min(self.I13 - self.I13SH,dI13dT) end
    if dI13dT < 0 then dI13dT = math.max(self.I13 - self.I13SH,dI13dT) end
    if dI24dT > 0 then dI24dT = math.min(self.I24 - self.I24SH,dI24dT) end
    if dI24dT < 0 then dI24dT = math.max(self.I24 - self.I24SH,dI24dT) end
    self.I13SH = self.I13SH + dI13dT
    self.I24SH = self.I24SH + dI24dT
    self.I13 = self.I13SH
    self.I24 = self.I24SH

     if Train.BPTI.State > 0 then -- PS
        self.I13 = self.I13 * Train.K2.Value * Train.K1.Value
        self.I24 = self.I24 * Train.K2.Value * Train.K1.Value

        self.Itotal = Train.Electric.I13 + Train.Electric.I24
    else
        self.I13 = self.I13 * Train.K3.Value
        self.I24 = self.I24 * Train.K3.Value

        self.Itotal = Train.Electric.I13 + Train.Electric.I24
    end
    -- Calculate extra information
    self.Uanchor13 = self.I13 * self.Ranchor13
    self.Uanchor24 = self.I24 * self.Ranchor24



    ----------------------------------------------------------------------------
    -- Calculate current through stator and shunt
    self.Ustator13 = self.I13 * self.Rstator13
    self.Ustator24 = self.I24 * self.Rstator24

    self.Ishunt13  = self.Ustator13 / self.Rs1
    self.Istator13 = self.Ustator13 / RwStator
    self.Ishunt24  = self.Ustator24 / self.Rs2
    self.Istator24 = self.Ustator24 / RwStator

    if Train.BPTI.State < 0 then
        local I1,I2 = self.Ishunt13,self.Ishunt24
        self.Ishunt13 = -I2
        self.Ishunt24 = -I1

        I1,I2 = self.Istator13,self.Istator24
        self.Istator13 = -I2
        self.Istator24 = -I1
    end

    -- Calculate power and heating
    local K = 12.0*1e-5
    local H = (10.00+(15.00*Train.Engines.Speed/80.0))*1e-3
    self.P1 = (self.IR1^2)*self.R1
    self.P2 = (self.IR2^2)*self.R2
    self.T1 = (self.T1 + self.P1*K*dT - (self.T1-25)*H*dT)
    self.T2 = (self.T2 + self.P2*K*dT - (self.T2-25)*H*dT)
    self.Overheat1 = math.min(1-1e-12,
        self.Overheat1 + math.max(0,(math.max(0,self.T1-750.0)/400.0)^2)*dT )
    self.Overheat2 = math.min(1-1e-12,
        self.Overheat2 + math.max(0,(math.max(0,self.T2-750.0)/400.0)^2)*dT )

    -- Energy consumption
    self.ElectricEnergyUsed = self.ElectricEnergyUsed + math.max(0,self.EnergyChange)*dT
    self.ElectricEnergyDissipated = self.ElectricEnergyDissipated + math.max(0,-self.EnergyChange)*dT
    --print(self.EnergyChange)
end

function TRAIN_SYSTEM:SolvePP(Train,inTransition)

    -- Calculate total resistance of each branch
    local R1 = self.Ranchor13 + self.Rstator13-- + self.ExtraResistanceK5
    local R2 = self.Ranchor13 + self.Rstator13-- + self.ExtraResistanceK5
    local CircuitClosed = (self.Power750V*Train.K1.Value > 0) and 1 or 0
    -- Main circuit parameters
    local V = self.Power750V*Train.K1.Value*Train.BPTI.RNState
    local E1 = Train.Engines.E13
    local E2 = Train.Engines.E24

    -- Calculate current through engines 13, 24
    self.I13 = math.max(0,((V - E1)/R1)*CircuitClosed)
    self.I24 = math.max(0,((V - E2)/R2)*CircuitClosed)

    -- Total resistance (for induction RL circuit)
    self.R13 = R1
    self.R24 = R2
    --if inTransition then print("InPP1",self.I13,Format("(%.2f-%.2f)/%.2f=%.2f",V , E1,R1,(V - E1)/R1),Train.K1.Value,Train.K3_4.Value,self.RVState,self.RNState) end

    -- Calculate everything else
    self.U13 = self.I13*R1
    self.U24 = self.I24*R2
    self.Utotal = (self.U13 + self.U24)/2
    self.Itotal = Train.Electric.I13 + Train.Electric.I24
    -- Energy consumption
    self.EnergyChange = math.abs((self.I13^2)*R1) + math.abs((self.I24^2)*R2)
end

function TRAIN_SYSTEM:SolvePT(Train,inTransition)
    -- Winding resistances
    local R1 = self.Ranchor13 + self.Rstator13-- + self.ExtraResistanceK5
    local R2 = self.Ranchor24 + self.Rstator24-- + self.ExtraResistanceK5
    -- Total resistance of the entire braking rheostat
    --local R3 = 1.730*(1-0.860*Train.BPTI.RNState)
    local R3 = --[[ (1.730+0.4)*--]] 2.8*(1-0.95*Train.BPTI.RNState)--0.84

    -- Main circuit parameters
    local V = self.Power750V*Train.K1.Value
    local E1 = Train.Engines.E13
    local E2 = Train.Engines.E24

    -- Calculate current through engines 13, 24
    self.I13 = -((E1*R2 + E1*R3 - E2*R3 - R2*V)/(R1*R2 + R1*R3 + R2*R3))
    self.I24 = -((E2*R1 - E1*R3 + E2*R3 - R1*V)/(R1*R2 + R1*R3 + R2*R3))

    -- Total resistance (for induction RL circuit)
    self.R13 = R3+((R1^(-1) + R2^(-1))^(-1))
    self.R24 = R3+((R1^(-1) + R2^(-1))^(-1))

    -- Calculate everything else
    self.U13 = self.I13*R1
    self.U24 = self.I24*R2
    self.Utotal = (self.U13 + self.U24)/2
    self.Itotal = Train.Electric.I13 + Train.Electric.I24

    -- Energy consumption
    self.EnergyChange = -math.abs(((0.5*self.Itotal)^2)*self.R13)
end

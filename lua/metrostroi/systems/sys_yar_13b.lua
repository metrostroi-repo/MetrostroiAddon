--------------------------------------------------------------------------------
-- Box with relays (YaR-13B)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("YAR_13B")

function TRAIN_SYSTEM:Initialize()
    -- Реле перегрузки (РПЛ)
    self.Train:LoadSystem("RPL","Relay","RM3001", {coil_res = 73, pickup_current = 0.012, hasCoil = true})--, { trigger_level = 1300 })
    -- Групповое реле перегрузки 1-3 (РП1-3)
    self.Train:LoadSystem("RP1_3","Relay","RM3001",{ trigger_level = 760 }) --630 })
    -- Групповое реле перегрузки 2-4 (РП2-4)
    self.Train:LoadSystem("RP2_4","Relay","RM3001",{ trigger_level = 760 }) --630 })

    -- Нулевое реле (НР)
    --   Does not use any power source defined, as the operation is calculated from bus voltage
    self.Train:LoadSystem("NR","Relay","R3150", { power_source = "None", coil_res = 690,pickup_current = 0.001, hasCoil = true })
    -- Реле системы управления
    self.Train:LoadSystem("RSU","Relay","R3100", {coil_res = 275,pickup_current = 0.003, hasCoil = true})
    self.Train:LoadSystem("RU","Relay","R3100")

    -- Реле заземления (РЗ-1, РЗ-2, РЗ-3)
    self.Train:LoadSystem("RZ_1","Relay","RM3001", {coil_res    = 338,pickup_current = 0.003, hasCoil = true})
    self.Train:LoadSystem("RZ_2","Relay","RM3001", {coil_res    = 73,pickup_current = 0.012, hasCoil = true})
    self.Train:LoadSystem("RZ_3","Relay","RM3001")
    -- Возврат реле перегрузки (РПвозврат)
    self.Train:LoadSystem("RPvozvrat","Relay","RM3001",{
        latched = true,             -- RPvozvrat latches into place
        power_open = "None",        -- Power source for the open signal
        power_close = "Mechanical", -- Power source for the close signal
        coil_res = 73,
        pickup_current = 0.012,
        hasCoil = true
    })

    -- Реле времени РВ1
    self.Train:LoadSystem("RV1","Relay","RM3100",{ open_time = 0.7, coil_res = 31.7,pickup_current = 0.004, hasCoil = true })  --указаны сопротивления обмоток СДРК
    -- Реле времени РВ2 (задерживает отключение ЛК2)
    self.Train:LoadSystem("RV2","Relay","RM3100",{ open_time = 0.7, coil_res = 200,pickup_current = 0.004, hasCoil = true })
    self.Train:LoadSystem("RR","Relay","RPU-116T", { coil_res = 160, pickup_current = 0.005, hasCoil = true })

    -- Реле ручного тормоза (РРТ)
    self.Train:LoadSystem("RRT","Relay", {coil_res = 28, hasCoil = true})
    -- Реле резервного пуска (РРП)
    self.Train:LoadSystem("RRP","Relay", {coil_res = 162,pickup_current = 0.005, hasCoil = true})
    -- Стоп-реле (СР1)
    self.Train:LoadSystem("SR1","Relay","RM3000",{ iterations=16,open_time=0,coil_res=3.34,pickup_current = 0.003, hasCoil = true })   --указаны сопротивления обмоток СДРК
    -- Реле контроля реверсоров
    self.Train:LoadSystem("RKR","Relay","RM3000", {coil_res = 372,pickup_current = 0.003, hasCoil = true})
    -- Реле ускорения, торможения (РУТ)
    self.Train:LoadSystem("RUT","Relay","R-52B", {coil_res = 25, hasCoil = true})


    -- Only in Ezh
    -- Реле перехода (Рпер)
    self.Train:LoadSystem("Rper","Relay")
    self.Train:LoadSystem("RUP","Relay")

    -- Extra coils for some relays
    self.Train.RUTpod = 0
    self.Train.RRTuderzh = 0
    self.Train.RRTpod = 0
    self.Train.RUTavt = 1

    -- Need many iterations for engine simulation to converge
    self.SubIterations = 4
end

function TRAIN_SYSTEM:Inputs()
    return {  }
end
function TRAIN_SYSTEM:Outputs()
    return { "RRTuderzh","RRTpod","RUTTarget" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end

function TRAIN_SYSTEM:Think()
    local Train = self.Train
    -- Zero relay operation
    Train.NR:TriggerInput("Close",Train.Electric.Aux750V > 360) -- 360 - 380 V
    Train.NR:TriggerInput("Open", Train.Electric.Aux750V < 150) -- 120 - 190 V
    -- Overload relays operation
    Train.RP1_3:TriggerInput("Set",math.abs(Train.Electric.I13))
    Train.RP2_4:TriggerInput("Set",math.abs(Train.Electric.I24))
    --Train.RPL:TriggerInput("Set",Train.Electric.Itotal)
    -- RUT operation
    self.RUTCurrent = (math.abs(Train.Electric.I13) + math.abs(Train.Electric.I24))/2
    self.RUTTarget = 310 + 85*Train.Pneumatic.WeightLoadRatio*Train.RUTavt--(Train.RUTreg or 0)*40
    if Train.RUTpod > 0.5
    then Train.RUT:TriggerInput("Close",1.0)
    else Train.RUT:TriggerInput("Set",self.RUTCurrent > self.RUTTarget)
    end
    --self.RUTTarget = 250 + 150*self.Train.Pneumatic.WeightLoadRatio
    -- RPvozvrat operation
	--local A = Train.RPvozvrat.VozRpPressed ~= 0
    Train.RPvozvrat:TriggerInput("Close", Train:ReadTrainWire(17) == 0 and    -- condition added to override the blocking action of the energized RP relays on RPVozvrat
        ((Train.DR1.Value == 1.0) or
        (Train.DR2.Value == 1.0) or
        (Train.RPL.Value == 1.0) or
        (Train.RP1_3.Value == 1.0) or
        (Train.RP2_4.Value == 1.0) or
        (Train.RZ_1.Value == 1.0) or
        (Train.RZ_2.Value == 1.0) or
        (Train.RZ_3.Value == 1.0)))
end

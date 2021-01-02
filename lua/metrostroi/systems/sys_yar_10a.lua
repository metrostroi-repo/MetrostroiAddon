--------------------------------------------------------------------------------
-- Box with relays (YaR-10A)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("YAR_10A")

function TRAIN_SYSTEM:Initialize()
    -- Реле перегрузки (РПЛ)
    self.Train:LoadSystem("RPL","Relay","RM3001", { trigger_level = 1400 })
    -- Групповое реле перегрузки 1-3 (РП1-3)
    self.Train:LoadSystem("RP1_3","Relay","RM3001",{ trigger_level = 760 }) --630 })
    -- Групповое реле перегрузки 2-4 (РП2-4)
    self.Train:LoadSystem("RP2_4","Relay","RM3001",{ trigger_level = 760 }) --630 })

    -- Нулевое реле (НР)
    self.Train:LoadSystem("NR","Relay","R3150", { power_source = "None" })
    -- Реле управления
    --self.Train:LoadSystem("RSU","Relay","R3100")

    -- Реле заземления (РЗ-1, РЗ-2, РЗ-3)
    self.Train:LoadSystem("RZ_1","Relay","RM3001")
    self.Train:LoadSystem("RZ_2","Relay","RM3001")
    self.Train:LoadSystem("RZ_3","Relay","RM3001")
    -- Возврат реле перегрузки (РПвозврат)
    self.Train:LoadSystem("RPvozvrat","Relay","RM3001",{
        latched = true,             -- RPvozvrat latches into place
        power_open = "None",        -- Power source for the open signal
        power_close = "Mechanical", -- Power source for the close signal
    })

    -- Реле ручного тормоза (РРТ)
    self.Train:LoadSystem("RRT","Relay")
    self.Train:LoadSystem("RS","Relay")

    -- Need many iterations for engine simulation to converge
    self.SubIterations = 4
end

function TRAIN_SYSTEM:Inputs()
    return {  }
end
function TRAIN_SYSTEM:Outputs()
    return {  }
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
    Train.RPL:TriggerInput("Set",Train.Electric.Itotal)

    -- RPvozvrat operation
    Train.RPvozvrat:TriggerInput("Close",
        --(Train.DR1.Value == 1.0) or
        --(Train.DR2.Value == 1.0) or
        (Train.RPL.Value == 1.0) or
        (Train.RP1_3.Value == 1.0) or
        (Train.RP2_4.Value == 1.0) or
        (Train.RZ_1.Value == 1.0) or
        (Train.RZ_2.Value == 1.0) or
        (Train.RZ_3.Value == 1.0))
end

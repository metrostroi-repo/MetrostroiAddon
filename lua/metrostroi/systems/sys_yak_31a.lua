--------------------------------------------------------------------------------
-- Box with switches (YaK-31A)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("YAK_31A")

function TRAIN_SYSTEM:Initialize()
    -- КШ1, КШ2 (ослабление возбуждения тяговых электродвигателей)
    self.Train:LoadSystem("KSH1","Relay","KPP-113")
    self.Train:LoadSystem("KSH2","Relay","KPP-113")
    self.Train:LoadSystem("KSH3","Relay","KPP-113")
    self.Train:LoadSystem("KSH4","Relay","KPP-113")

    -- Контактор освещения (КО)
    self.Train:LoadSystem("KO","Relay","KPP-110")

    self.Train:LoadSystem("KZ1","Relay","DB-982ZH-12")
    self.Train:LoadSystem("KZ2","Relay","DB-982ZH-17")

    -- ТШ (переключение в цепях управления для перехода на тормозной режим)
    self.Train:LoadSystem("TSH","Relay","KPP-113")

    self.Train:LoadSystem("RVT","Relay","REV-811T", { bass   = true, open_time = 0.7, close_time = 0.1 })
    self.Train:LoadSystem("PR" ,"Relay","REV-811T", { bass   = true })
end
function TRAIN_SYSTEM:Think()
    self.Train.KZ1:TriggerInput("Set",self.Train.Electric.Aux750V > 200 and 1 or 0)
end

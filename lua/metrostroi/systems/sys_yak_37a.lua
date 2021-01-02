--------------------------------------------------------------------------------
-- Box with switches (YaK-37A)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("YAK_37A")

function TRAIN_SYSTEM:Initialize()
    -- КШ1, КШ2 (ослабление возбуждения тяговых электродвигателей)
    self.Train:LoadSystem("KSH1","Relay","KPP-113",{bass=true})
    self.Train:LoadSystem("KSH2","Relay","KPP-113")

    -- Контактор освещения (КО)
    self.Train:LoadSystem("KO","Relay","KPP-110")

    -- КСБ1, КСБ2 (включение тиристорных ключей регулирования поля для тормозных режимов)
    self.Train:LoadSystem("KSB1","Relay","KPP-113")
    self.Train:LoadSystem("KSB2","Relay","KPP-113")

    -- РРП2 (подача напряжения в цепь управления при резервном пуске)
    self.Train:LoadSystem("RRU","Relay","KPD-110")
    -- ТР1,ТР2 (переключение в цепях управления для перехода на тормозной режим)
    self.Train:LoadSystem("TR1","Relay","RPUZ-114-T-UHLZA")
    self.Train:LoadSystem("TR2","Relay","RPUZ-114-T-UHLZA")

    self.Train:LoadSystem("KZ1","Relay","DB-982ZH-12")
end
function TRAIN_SYSTEM:Think()
    self.Train.KZ1:TriggerInput("Set",self.Train.Electric.Aux750V > 200 and 1 or 0)
end
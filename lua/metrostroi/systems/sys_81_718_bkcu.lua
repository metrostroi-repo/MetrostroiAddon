--------------------------------------------------------------------------------
-- 81-718 control circuit switching unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_718_BKCU")

function TRAIN_SYSTEM:Initialize()
    self.KM1 = 0 --Контактор-повторитель КР "Назад"
    self.KM2 = 0 --Контактор-повторитель КР "Вперёд"
    self.KM3 = 0 --Контактор-повторитель КР "0"
    self.KM4 = 0 --Реле блокировки постов управления
    self.KM5 = 0 --Контактор-повторитель КРУ "Назад"
    self.KM6 = 0 --Контактор-повторитель КРУ "Вперёд"
    self.KM7 = 0 --Контактор-повторитель КРУ "0"
    self.KM8 = 0 --Реле блокировки постов управления

    --Контроллер
    self.Controller = 0
    self.TargetController = 0
end

function TRAIN_SYSTEM:Inputs()
    return { "KVUp", "KVDown", "KV1", "KV2", "KV3", "KV4", "KV5", "KV6", "KV7", "ControllerUnlock"}
end

function TRAIN_SYSTEM:Outputs()
    return { "Controller" }
end
--if not TURBOSTROI then return end
function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "KVUp" and value > 0 and self.Controller < 3 then
        if self.TargetController+1 == 0 and not self.Locker then return end
        self.TargetController = self.TargetController + 1
    end
    if name == "KVDown" and value > 0 and self.TargetController > -3 then
        self.TargetController = self.TargetController - 1
    end
    if name == "KV3" and value > 0 then self.TargetController = 3 end
    if name == "KV2" and value > 0 then self.TargetController = 2 end
    if name == "KV1" and value > 0 then self.TargetController = 1 end
    if name == "KV4" and value > 0 then self.TargetController = 0 end
    if name == "KV5" and value > 0 then self.TargetController = -1 end
    if name == "KV6" and value > 0 then self.TargetController = -2 end
    if name == "KV7" and value > 0 then self.TargetController = -3 end
    if name == "ControllerUnlock" then self.Locker = value > 0.5 end
    self.ControllerTimer = CurTime()-1
end
function TRAIN_SYSTEM:Think()
    if self.ControllerTimer and CurTime() - self.ControllerTimer > 0.03 and self.Controller ~= self.TargetController then
        local previousPosition = self.Controller
        self.ControllerTimer = CurTime()
        if self.TargetController > self.Controller then
            self.Controller = self.Controller + 1
        else
            self.Controller = self.Controller - 1
        end
        self.Train:PlayOnce("KV_"..previousPosition.."_"..self.Controller, "cabin",0.5)
    end
    if self.Controller == self.TargetController then
        self.ControllerTimer = nil
    end
end

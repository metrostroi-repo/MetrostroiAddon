Metrostroi.DefineModule("Test Module") -- Объявление модуля

-- Вызывается при запуске модуля

function MOD:Initialize()
    self["__enabled"] = false -- Выключен
end

--
-- Вызывается в конце функции Initialize в gmod_subway_base
-- Применение:
-- Подключение систем
-- Добавление кастомных пропов
-- Аргументы:
-- Вагон

function MOD:TrainInitialize(ENT)
    --[[
    if SERVER then return end

    if ENT:GetClass() ~= "gmod_subway_81-717_mvm" then return end

    ENT.ClientProps["booba"] = {
        model = "models/props_c17/FurnitureBathtub001a.mdl",
        pos = Vector(0,0,0),
        ang = Angle(0,0,0),
    }
    ]]
end

--
-- gmod_subway_base:Initialize -> gmod_subway_81-717_mvm:Initalize -> TrainPostInitialize
--
-- Применение:
-- сами придумайте
-- Аргументы:
-- Вагон

function MOD:TrainPostInitialize(ENT)

end

function MOD:TrainPostThink(ENT)

end

--
-- gmod_subway_base:InitializeSounds -> gmod_subway_81-717_mvm:InitializeSounds -> TrainInitializeSounds
--
-- Применение:
-- Установка звуков
-- Аргументы:
-- Вагон


function MOD:TrainInitializeSounds(ENT)
    --[[
    
    local allowed = {
        ["gmod_subway_81-717_mvm"] = true,
        ["gmod_subway_81-714_mvm"] = true,
    }

    if not allowed[ENT:GetClass()] then return end

    ENT.SoundNames["bpsn4"] = {"subway_trains/717/bpsn/bpsn_zl1.wav", loop=true}
    ENT.SoundPositions["bpsn4"] = {600,1e9,Vector(0,45,-448),0.05}
    ]]
end

--
-- Вызывается при выборе вагона в спавн меню и при нажатии кнопки "Спавн"
-- Применение:
-- Установка кастомных параметров
-- Аргументы:
-- Настройки трейн спавнера (trainSpawner)
-- ENT.Spawner вагона (entSpawner)
--
-- Для добавления своего параметра смотрите shared.lua в ENT.Spawner любого состава
-- Пример:
--                            Имя NW2   Отображаемое имя    Тип параметра             Данные (для List)
-- table.insert(entSpawner,  {"Test", "Тестовый параметр",     "List",       {"Выбор 1", "Выбор 2"}})
-- table.insert(entSpawner, {"Test2", "Тестовый параметр 2",  "Boolean"})

function MOD:TrainSpawnerSettings(trainSpawner, entSpawner, forSWEP)
    --table.insert(entSpawner, {"BPSNCustom", "БПСН ЗЛ", "Boolean"})
end

function MOD:TrainSpawnerUpdate(ENT)

end

function MOD:TrainShouldDrawClientEnts(ENT)
    -- Перезаписать?  Значение
    --return false,       false
end
function MOD:TrainShouldDrawClientEnt(ENT, k, v)
    -- Перезаписать?  Значение
    --local train = LocalPlayer():GetTrain()
    --if train ~= ENT then return true, false end
    --return false,       false
end

Metrostroi.ReloadModule() -- Перезапуск модуля (быстрая перезагрузка модуля)
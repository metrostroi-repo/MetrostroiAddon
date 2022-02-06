Metrostroi.DefineModule("TestModule") -- Объявление модуля

-- Вызывается при запуске модуля

function MOD:Initialize()
    self["__enabled"] = false -- Выключен
end

function MOD:TrainInitialize(ENT)
    
end
function MOD:TrainPostInitialize(ENT)

end
function MOD:TrainPostThink(ENT)

end
function MOD:TrainInitializeSounds(ENT)

end
function MOD:TrainSpawnerSettings(trainSpawner, entSpawner, forSWEP)

end
function MOD:TrainSpawnerUpdate(ENT)

end
function MOD:TrainShouldDrawClientEnts(ENT)
    
end
function MOD:TrainShouldDrawClientEnt(ENT, k, v)
    
end

Metrostroi.ReloadModule() -- Перезапуск модуля (быстрая перезагрузка модуля)
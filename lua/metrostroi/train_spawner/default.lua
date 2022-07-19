
-- Metrostroi.TrainSpawner.GetProperty("gmod_subway_81-717_mvm_custom", "Type")
-- Metrostroi.TrainSpawner.GetProperty("gmod_subway_81-717_mvm_custom", "BodyType")

-- Metrostroi.TrainSpawner.GetProperties("gmod_subway_81-717_mvm_custom")

-- Metrostroi.TrainSpawner.RegisterProperty("gmod_subway_81-717_mvm_custom", {"Kek", "Кек название", "List", {"1", "2", "3"}})

-- Metrostroi.TrainSpawner.UnregisterProperty("gmod_subway_81-717_mvm_custom", "Kek")

Metrostroi.TrainSpawner.RegisterProperty("gmod_subway_81-717_mvm_custom", {"Kek", "Кек название", "List", {"1", "2", "3"}})

hook.Remove("MetrostroiTrainSpawnerPreview-WagonSpawn", "MetrostroiTrainSpawner-Default")

hook.Add("MetrostroiTrainSpawnerPreview-WagonSpawn", "MetrostroiTrainSpawner-Default-717-714", function(consistFrame, previewFrame, trainClass, settings, pos, maxWagons)
    local spawnerClass = consistFrame.TrainClass

    if spawnerClass != "gmod_subway_81-717_mvm" and spawnerClass != "gmod_subway_81-717_mvm_custom" then return end

    local dot5 = settings.Type == 2
    local lvz = settings.BodyType == 2

    print(dot5, lvz)

    if trainClass == "gmod_subway_81-717_mvm" then
        
    end
    if trainClass == "gmod_subway_81-714_mvm" then
        
    end
end)

hook.Add("MetrostroiTrainSpawnerPreview-PreventSpawnerModels", "MetrostroiTrainSpawner-Default", function(consistFrame, previewFrame, trainClass)
    if trainClass == "gmod_subway_81-717_mvm" then
        return true
    end
end)
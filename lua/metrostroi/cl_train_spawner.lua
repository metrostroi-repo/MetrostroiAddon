Metrostroi = Metrostroi or {}

Metrostroi.TrainSpawner = Metrostroi.TrainSpawner or {}

Metrostroi.TrainSpawner.RegisteredProperties = Metrostroi.TrainSpawner.RegisteredProperties or {}

Metrostroi.TrainSpawner.CopiedClass = Metrostroi.TrainSpawner.CopiedClass or {}

function Metrostroi.TrainSpawner.GetProperties(class)
    if isstring(Metrostroi.TrainSpawner.CopiedClass[class]) then
        local from = Metrostroi.TrainSpawner.CopiedClass[class]

        local base = Metrostroi.TrainSpawner.GetProperties(from)

        if not base then return end

        local tbl = table.Copy(base)

        table.Add(tbl, Metrostroi.TrainSpawner.RegisteredProperties[class] or {})

        return tbl
    else
        local ent = scripted_ents.GetStored(class).t

        if not ent then return end

        local spawner = ent.Spawner

        if not spawner then return end

        local tbl = {}

        for k, v in ipairs(spawner) do
            tbl[k] = v
        end

        table.Add(tbl, Metrostroi.TrainSpawner.RegisteredProperties[class] or {})

        return tbl
    end        
end

function Metrostroi.TrainSpawner.GetProperty(class, property)
    local properties = Metrostroi.TrainSpawner.GetProperties(class)

    if not properties then return end

    for k, v in pairs(properties) do
        if v[1] == property then
            return v
        end
    end
end

function Metrostroi.TrainSpawner.RegisterProperty(class, property)
    if not Metrostroi.TrainSpawner.RegisteredProperties[class] then Metrostroi.TrainSpawner.RegisteredProperties[class] = {} end

    if not istable(property) then return end

    local tbl = Metrostroi.TrainSpawner.RegisteredProperties[class]

    local name = property[1]

    if not isstring(name) then
        table.insert(tbl, {})
        return
    end
    
    local pos = -1

    for k, v in pairs(tbl) do
        if name == (v[1] or "") then
            pos = k
        end
    end

    if pos == -1 then
        table.insert(tbl, property) 
    else
        tbl[pos] = property
    end
end

function Metrostroi.TrainSpawner.UnregisterProperty(class, property)
    if not Metrostroi.TrainSpawner.RegisteredProperties[class] then return end

    local tbl = Metrostroi.TrainSpawner.RegisteredProperties[class]

    for k, v in pairs(tbl) do
        if property == (v[1] or "") then
            tbl[k] = nil
            return
        end
    end
end

function Metrostroi.TrainSpawner.CopyProperties(toClass, fromClass)
    Metrostroi.TrainSpawner.CopiedClass[toClass] = fromClass
end

function Metrostroi.TrainSpawner.AddSpacer(class)
    Metrostroi.TrainSpawner.RegisterProperty(class, {})
end

timer.Simple(0.1, function()
    for _,filename in pairs(file.Find("metrostroi/train_spawner/*.lua","LUA")) do include("metrostroi/train_spawner/"..filename) end
end)
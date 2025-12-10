
for _,filename in pairs(file.Find("metrostroi/train_spawner/*.lua","LUA")) do
    AddCSLuaFile("metrostroi/train_spawner/"..filename)
end
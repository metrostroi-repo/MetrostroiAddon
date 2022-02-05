Metrostroi.Modules = Metrostroi.Modules or {}

Metrostroi.Modules.Loaded = {}
Metrostroi_Modules_Loaded = Metrostroi.Modules.Loaded

function Metrostroi.DefineModule(name)
    MOD = {}

    MOD.name = name
    MOD_NAME = name
end

function Metrostroi.ReloadModule()
    local name = MOD_NAME

    if DONT_RELOAD then return end

    if string.StartWith(Metrostroi_Modules_Loaded[name]["__filename"], "!Dynamic") then
        Metrostroi.Modules.RegisterModuleTable(MOD, name)
    else
        Metrostroi.Modules.RegisterModule(Metrostroi_Modules_Loaded[name]["__filename"])
    end
end

local pairs = pairs

function Metrostroi.Modules.DispatchEvent(event, ENT, a, b, c, d)
    local tbl = Metrostroi_Modules_Loaded
    for k, v in pairs(tbl) do
        if not v["__enabled"] then return false end
        local func = v[event]
        if not func then return end
        local res, x, y, z, w = func(v, ENT, a, b, c, d)

        if res then
            return x, y, z, w
        end
    end
    return false
end

Metrostroi_Modules_DispatchEvent = Metrostroi.Modules.DispatchEvent

function Metrostroi.Modules.RegisterModule(filename)
    DONT_RELOAD = true
    include(filename)
    DONT_RELOAD = nil

    local tbl = MOD
    local name = MOD_NAME
    MOD = nil
    MOD_NAME = nil
    
    tbl.Initialize = tbl.Initialize or function() return end

    tbl["__filename"] = filename
    tbl["__enabled"] = true

    Metrostroi.Modules.Loaded[name] = tbl

    tbl:Initialize()
end

function Metrostroi.Modules.RegisterModuleTable(tbl, name)
    tbl.Initialize = tbl.Initialize or function() return end

    tbl["__filename"] = Format("!Dynamic:%s", name)
    tbl["__enabled"] = true

    Metrostroi.Modules.Loaded[name] = tbl

    tbl:Initialize()
end

function Metrostroi.Modules.EnableModule(name)
    local mod = Metrostroi_Modules_Loaded[name]
    if not mod then return end
    mod["__enabled"] = true
end

function Metrostroi.Modules.DisableModule(name)
    local mod = Metrostroi_Modules_Loaded[name]
    if not mod then return end
    mod["__enabled"] = false
end

Metrostroi.Modules.CacheFunctions = Metrostroi.Modules.CacheFunctions or {}
function Metrostroi.Modules.Inject()
    for k, v in pairs(Metrostroi.TrainClasses) do
        local ENT = scripted_ents.GetStored(v).t

        if not Metrostroi.Modules.CacheFunctions[v] then Metrostroi.Modules.CacheFunctions[v] = {} end

        local oldInitialize = Metrostroi.Modules.CacheFunctions[v]["Initialize"] or ENT.Initialize
        local oldThink = Metrostroi.Modules.CacheFunctions[v]["Think"] or ENT.Think
        local oldTrainSpawner = Metrostroi.Modules.CacheFunctions[v]["TrainSpawnerUpdate"] or ENT.TrainSpawnerUpdate or function() return end
        local oldInitializeSounds = Metrostroi.Modules.CacheFunctions[v]["InitializeSounds"] or ENT.InitializeSounds or function() return end
        local oldDrawPost = Metrostroi.Modules.CacheFunctions[v]["DrawPost"] or ENT.DrawPost or function() return end
        
        ENT.Initialize = function(ent)
            oldInitialize(ent)
            Metrostroi_Modules_DispatchEvent("TrainPostInitialize", ent)
        end
        ENT.Think = function(ent)
            local res = oldThink(ent)
            Metrostroi_Modules_DispatchEvent("TrainPostThink", ent)
            return res
        end
        ENT.TrainSpawnerUpdate = function(ent, a, b, c, d)
            local x, y, z, w = oldTrainSpawner(ent, a, b, c, d)
            Metrostroi_Modules_DispatchEvent("TrainSpawnerUpdate", ent)
            return x, y, z, w
        end
        ENT.InitializeSounds = function(ent)
            oldInitializeSounds(ent)
            Metrostroi_Modules_DispatchEvent("TrainInitializeSounds", ent)
        end
        ENT.DrawPost = function(ent, a)
            oldDrawPost(ent, a)
            Metrostroi_Modules_DispatchEvent("TrainDrawPost", ent)
        end

        Metrostroi.Modules.CacheFunctions[v]["Initialize"] = oldInitialize
        Metrostroi.Modules.CacheFunctions[v]["Think"] = oldThink
        Metrostroi.Modules.CacheFunctions[v]["TrainSpawnerUpdate"] = oldTrainSpawner
        Metrostroi.Modules.CacheFunctions[v]["InitializeSounds"] = oldInitializeSounds
        Metrostroi.Modules.CacheFunctions[v]["DrawPost"] = oldDrawPost
    end
end

Metrostroi.Modules.Inject()

hook.Add("InitPostEntity", "Metrostroi_Modules_Inject", Metrostroi.Modules.Inject)

if SERVER then -- Loading Modules
    files = file.Find("metrostroi/modules/*.lua","LUA")
    for _,filename in pairs(files) do AddCSLuaFile("metrostroi/modules/"..filename) end
end
local files = file.Find("metrostroi/modules/*.lua","LUA")
for _,short_filename in pairs(files) do
    local filename = "metrostroi/modules/"..short_filename

    print(Format("Metrostroi: Registering module [%s]", filename))

    if SERVER
    then Metrostroi.Modules.RegisterModule(filename)
    else timer.Simple(0.05, function() Metrostroi.Modules.RegisterModule(filename) end)
    end
end

if SERVER then

    util.AddNetworkString("metrostroi-modules-set")

    concommand.Add("metrostroi_modules_list", function(ply)
        local function print_msg(str)
            if IsValid(ply) then
                ply:PrintMessage(HUD_PRINTCONSOLE, str)
            else
                print(str)
            end
        end

        print_msg("Current loaded modules:")
        local text = {}
        for k, v in pairs(Metrostroi_Modules_Loaded) do
            local t = Format("%s [%s] - %s", v.name, v["__filename"], v["__enabled"] and "Enabled" or "Disabled")
            table.insert(text, t)
        end
        print_msg(table.concat(text, "\n"))
    end)

    concommand.Add("metrostroi_modules_enable", function(ply, _, args)
        local function print_msg(str)
            if IsValid(ply) then
                ply:PrintMessage(HUD_PRINTCONSOLE, str)
            else
                print(str)
            end
        end

        if IsValid(ply) then
            if not ply:IsAdmin() then return print_msg("Missing permissions") end
        end

        local name = args[1]

        if not Metrostroi_Modules_Loaded[name] then return print_msg("Module not found") end

        Metrostroi.Modules.EnableModule(name)
        net.Start("metrostroi-modules-set")
        net.WriteUInt(1, 8)
        net.WriteString(name)
        net.Broadcast()

        print_msg("Module " .. name .. " enabled")
    end)

    concommand.Add("metrostroi_modules_disable", function(ply, _, args)
        local function print_msg(str)
            if IsValid(ply) then
                ply:PrintMessage(HUD_PRINTCONSOLE, str)
            else
                print(str)
            end
        end

        if IsValid(ply) then
            if not ply:IsAdmin() then return print_msg("Missing permissions") end
        end

        local name = args[1]

        if not Metrostroi_Modules_Loaded[name] then return print_msg("Module not found") end

        Metrostroi.Modules.DisableModule(name)
        net.Start("metrostroi-modules-set")
        net.WriteUInt(2, 8)
        net.WriteString(name)
        net.Broadcast()

        print_msg("Module " .. name .. " disabled")
    end)
else
    net.Receive("metrostroi-modules-set", function()
        local typ = net.ReadUInt(8)
        local name = net.ReadString()
        if typ == 1 then -- Enable module
            Metrostroi.Modules.EnableModule(name)
        elseif typ == 2 then -- Disable module
            Metrostroi.Modules.DisableModule(name)
        end
    end)
end
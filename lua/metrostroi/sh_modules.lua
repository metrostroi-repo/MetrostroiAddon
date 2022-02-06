Metrostroi.Modules = Metrostroi.Modules or {}

Metrostroi.Modules.Loaded = Metrostroi.Modules.Loaded or {}

function Metrostroi.DefineModule(name)
    MOD = {}

    MOD.name = name
    MOD_NAME = name
end

function Metrostroi.ReloadModule()
    local name = MOD_NAME

    if DONT_RELOAD then return end
    if not Metrostroi.Modules.Loaded[name] then return end

    if string.StartWith(Metrostroi.Modules.Loaded[name]["__filename"], "!Dynamic") then
        Metrostroi.Modules.RegisterModuleTable(MOD, name)
    else
        Metrostroi.Modules.RegisterModule(Metrostroi.Modules.Loaded[name]["__filename"])
    end
end

local pairs = pairs

function Metrostroi.Modules.DispatchEvent(event, ENT, a, b, c, d)
    for k, v in pairs(Metrostroi.Modules.Loaded) do
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
    local mod = Metrostroi.Modules.Loaded[name]
    if not mod then return end
    mod["__enabled"] = true
end

function Metrostroi.Modules.DisableModule(name)
    local mod = Metrostroi.Modules.Loaded[name]
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
            Metrostroi.Modules.DispatchEvent("TrainPostInitialize", ent)
        end
        ENT.Think = function(ent)
            local res = oldThink(ent)
            Metrostroi.Modules.DispatchEvent("TrainPostThink", ent)
            return res
        end
        ENT.TrainSpawnerUpdate = function(ent, a, b, c, d)
            local x, y, z, w = oldTrainSpawner(ent, a, b, c, d)
            Metrostroi.Modules.DispatchEvent("TrainSpawnerUpdate", ent)
            return x, y, z, w
        end
        ENT.InitializeSounds = function(ent)
            oldInitializeSounds(ent)
            Metrostroi.Modules.DispatchEvent("TrainInitializeSounds", ent)
        end
        ENT.DrawPost = function(ent, a)
            oldDrawPost(ent, a)
            Metrostroi.Modules.DispatchEvent("TrainDrawPost", ent)
        end

        Metrostroi.Modules.CacheFunctions[v]["Initialize"] = oldInitialize
        Metrostroi.Modules.CacheFunctions[v]["Think"] = oldThink
        Metrostroi.Modules.CacheFunctions[v]["TrainSpawnerUpdate"] = oldTrainSpawner
        Metrostroi.Modules.CacheFunctions[v]["InitializeSounds"] = oldInitializeSounds
        Metrostroi.Modules.CacheFunctions[v]["DrawPost"] = oldDrawPost
    end
end

timer.Simple(3, function()
    Metrostroi.Modules.Inject()
end)

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
    util.AddNetworkString("metrostroi-modules-msg")
    

    concommand.Add("metrostroi_modules_list", function(ply)
        local function print_msg(...)
            if IsValid(ply) then
                local args = {...}
                net.Start("metrostroi-modules-msg")
                    net.WriteUInt(#args, 32)
                    for k, v in ipairs(args) do
                        net.WriteType(v)
                    end
                net.Send(ply)
            else
                MsgC(...)
            end
        end


        local enabled = {}
        local disabled = {}
        local text = "Current loaded modules:"
        local width = string.len(text)
        for k, v in pairs(Metrostroi.Modules.Loaded) do
            local t = Format("%s [%s]", v.name, v["__filename"])
            if #t > width then width = #t end
            table.insert(v["__enabled"] and enabled or disabled, t)
            --print_msg(color_white, "│ ", color, t, "\n")
        end

        print_msg(color_white, "┌", string.rep("─", width+2), "┐", "\n")
        print_msg(color_white, "│ Current loaded modules:", string.rep( " ", width-#text ), " │", "\n")
        for k, v in pairs(enabled) do
            print_msg(color_white, "│ ", Color(0, 255, 0), v, color_white, string.rep( " ", width-#v ), " │", "\n")
        end
        for k, v in pairs(disabled) do
            print_msg(color_white, "│ ", Color(255, 0, 0), v, color_white, string.rep( " ", width-#v ), " │", "\n")
        end
        print_msg(color_white, "└", string.rep("─", width+2), "┘", "\n")
    end)

    concommand.Add("metrostroi_modules_enable", function(ply, _, args)
        local function print_msg(...)
            if IsValid(ply) then
                local args = {...}
                net.Start("metrostroi-modules-msg")
                    net.WriteUInt(#args, 32)
                    for k, v in ipairs(args) do
                        net.WriteType(v)
                    end
                net.Send(ply)
            else
                MsgC(...)
            end
        end

        if IsValid(ply) then
            if not ply:IsAdmin() then return print_msg(Color(255, 0, 0), "Metrostroi: Missing permissions", "\n") end
        end

        local name = args[1]

        if not Metrostroi.Modules.Loaded[name] then return print_msg("Metrostroi: Module not found", "\n") end

        Metrostroi.Modules.EnableModule(name)
        net.Start("metrostroi-modules-set")
        net.WriteUInt(1, 8)
        net.WriteString(name)
        net.Broadcast()

        print_msg(Color(0, 255, 0), "Metrostroi: Module '" .. name .. "' enabled", "\n")
    end)

    concommand.Add("metrostroi_modules_disable", function(ply, _, args)
        local function print_msg(...)
            if IsValid(ply) then
                local args = {...}
                net.Start("metrostroi-modules-msg")
                    net.WriteUInt(#args, 32)
                    for k, v in ipairs(args) do
                        net.WriteType(v)
                    end
                net.Send(ply)
            else
                MsgC(...)
            end
        end

        if IsValid(ply) then
            if not ply:IsAdmin() then return print_msg(Color(255, 0, 0), "Metrostroi: Missing permissions", "\n") end
        end

        local name = args[1]

        if not Metrostroi.Modules.Loaded[name] then return print_msg("Metrostroi: Module not found", "\n") end

        Metrostroi.Modules.DisableModule(name)
        net.Start("metrostroi-modules-set")
        net.WriteUInt(2, 8)
        net.WriteString(name)
        net.Broadcast()

        print_msg(Color(255, 102, 0), "Metrostroi: Module '" .. name .. "' disabled", "\n")
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

    net.Receive("metrostroi-modules-msg", function()
        local len = net.ReadUInt(32)
        local tbl = {}
        for i = 1, len do
            local val = net.ReadType()
            table.insert(tbl, val)
        end
        MsgC(unpack(tbl))
    end)
end
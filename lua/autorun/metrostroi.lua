--------------------------------------------------------------------------------
-- Add all required clientside files
--------------------------------------------------------------------------------
local function resource_AddDir(dir)
    local files,dirs = file.Find(dir.."/*","GAME")
    for _, fdir in pairs(dirs) do
        resource_AddDir(dir.."/"..fdir)
    end

    for _,v in pairs(files) do
        resource.AddFile(dir.."/"..v)
    end
end
if SERVER then
    util.AddNetworkString("metrostroi-mouse-move")
    util.AddNetworkString("metrostroi-cabin-button")
    util.AddNetworkString("metrostroi-cabin-reset")
    util.AddNetworkString("metrostroi-panel-touch")
    
    util.PrecacheModel("models/metrostroi_train/reversor/reversor_classic.mdl")
    util.PrecacheModel("models/metrostroi_train/reversor/reversor_gold.mdl")

    --[[resource_AddDir("materials/metrostroi/props")
    resource_AddDir("materials/models/metrostroi_signs")
    resource_AddDir("materials/models/metrostroi_train")
    resource_AddDir("materials/models/metrostroi_passengers")
    resource_AddDir("materials/models/metrostroi_signals")

    resource_AddDir("models/metrostroi/signs")
    resource_AddDir("models/metrostroi/81-717")
    resource_AddDir("models/metrostroi/e")
    resource_AddDir("models/metrostroi/81")
    resource_AddDir("models/metrostroi/81-703")
    resource_AddDir("models/metrostroi/81-508")
    resource_AddDir("models/metrostroi/metro")
    resource_AddDir("models/metrostroi/passengers")
    resource_AddDir("models/metrostroi/signals")
    resource_AddDir("models/metrostroi/tatra_t3")

    resource_AddDir("sound/subway_trains")
    resource_AddDir("sound/subway_announcer")
    resource_AddDir("sound/subway_stations_test1")
    resource_AddDir("sound/subway_trains/new")]]
end


------ --------------------------------------------------------------------------
-- Create metrostroi global library
--------------------------------------------------------------------------------
if not Metrostroi then
    -- Global library
    Metrostroi = {}

    -- Supported train classes
    Metrostroi.TrainClasses = {}
    Metrostroi.IsTrainClass = {}
    -- Supported train classes
    Metrostroi.TrainSpawnerClasses = {}
    timer.Simple(0.05, function()
        for name in pairs(scripted_ents.GetList()) do
            local prefix = "gmod_subway_"
            if string.sub(name,1,#prefix) == prefix and scripted_ents.Get(name).Base == "gmod_subway_base" and not scripted_ents.Get(name).NoTrain then
                table.insert(Metrostroi.TrainClasses,name)
                Metrostroi.IsTrainClass[name] = true
            end
        end
    end)

    -- List of all systems
    Metrostroi.Systems = {}
    Metrostroi.BaseSystems = {}
end

--List of spawned trains
Metrostroi.SpawnedTrains = {}
for k,ent in pairs(ents.GetAll()) do
    if ent.Base == "gmod_subway_base" or ent:GetClass() == "gmod_subway_base" then
        Metrostroi.SpawnedTrains[ent] = true
    end
end

hook.Add("EntityRemoved","MetrostroiTrains",function(ent)
    if Metrostroi.SpawnedTrains[ent] then
        Metrostroi.SpawnedTrains[ent] = nil
    end
end)
if SERVER then
    hook.Add("OnEntityCreated","MetrostroiTrains",function(ent)
        if ent.Base == "gmod_subway_base" or  ent:GetClass() == "gmod_subway_base" then
            Metrostroi.SpawnedTrains[ent] = true
        end
    end)
else
    hook.Add("OnEntityCreated","MetrostroiTrains",function(ent)
        if ent:GetClass() == "gmod_subway_base" or scripted_ents.IsBasedOn(ent:GetClass(), "gmod_subway_base") then
            Metrostroi.SpawnedTrains[ent] = true
        end
    end)
end

------------------------
-- Metrostroi version --
------------------------
Metrostroi.Version = 1623941696
Metrostroi.Loaded = false

--------------------------------------------------------------------------------
-- Add skins function
--  category - a skin category(pass, cab, train)
--  name - name of skin(must be unique) or skin table(table must have a name)
--  tbl - skin table
-- Skin table:
-- {
--      typ = "81-717_lvz", (it's a gmod_subway_*(gmod_subway_81-717_lvz))
--      name = "NAME",(or you can send name to function)
--  textures = {
--          texture_name = "path_to_texture",
--          b01a = "myskin/mycoolskin",
--  }
-- }
-- List of trains and manufacturers:
-- 81-717_mvm
-- 81-717_lvz
-- Ezh3
-- Em
-- E
--------------------------------------------------------------------------------
function Metrostroi.AddSkin(category,name,tbl)
    if type(name) == "table" then
        local Table = name
        name = Table.name
        Table.name = nil
        tbl = Table
    end
    if CLIENT and tbl.textures then
        local nofind
        for k,v in pairs(tbl.textures) do
            if not file.Exists("materials/"..v..".vmt","GAME") and not file.Exists("materials/models/"..v..".vmt","GAME") then
                nofind = true
                ErrorNoHalt(Format("Metrostroi: %s texture: %s, not found. Check folder and addons!\n",category,v))
            end
        end
        if nofind then return end
    end
    if not Metrostroi.Skins[category] then
        print(Format("Metrostroi: Added a %s skin category",category))
        Metrostroi.Skins[category] = {}
    end
    if not tbl.typ then ErrorNoHalt(Format("Metrostroi:Skin error: %s wont have a typ direvtive!\n",tbl.name or name)) return end
    Metrostroi.Skins[category][name] = tbl
    Metrostroi.Skins.GetTable = function(id,name,tbl,typ)
        local SkinsType = ENT and ENT.SkinsType
        return {id,name,"List",function()
            if SkinsType then
                tbl = {}
                for k,v in pairs(Metrostroi.Skins[typ]) do
                    if v.typ == SkinsType and not hook.Run("MetrostroiSkinsCheck",SkinsType,typ,v.name or k,k) then tbl[k] = v.name or k end
                end
                return tbl
            end
        end,nil,function(ent,val)
            if not Metrostroi.Skins or not Metrostroi.Skins[typ] then return end
            local texture = Metrostroi.Skins[typ][val]
            if not texture or hook.Run("MetrostroiSkinsCheck",texture.typ,typ,texture.name or val,val) then return end
            ent:SetNW2String(id,val)
            --[[ if texture.textures then
                ent:SetNW2String(id,texture.func and texture.func(ent) or val)
            elseif texture.func then
                ent:SetNW2String(id,texture.func(ent))
            end--]]
        end,function(List,VGUI)
            if not Metrostroi.Skins or not Metrostroi.Skins[typ] then return end
            local texture = Metrostroi.Skins[typ][List:GetOptionData(List:GetSelectedID())]
            if not texture or not texture.defaults then return end
            for k,v in pairs(texture.defaults) do
                local id = VGUI[k].ID
                -- print(List:GetOptionData(List:GetSelectedID()),id,VGUI[id],v)
                if id and VGUI[id] then
                    VGUI[id](v,true)
                end
            end
        end}
    end
end

--------------------------------------------------------------------------------
-- Function for announcer adding
--------------------------------------------------------------------------------
Metrostroi.AnnouncementsASNP = {}
Metrostroi.ASNPSetup = {}
function Metrostroi.AddANSPAnnouncer(name,soundtable,datatable)
    if not soundtable or not datatable then return end
    for k,v in pairs(datatable) do
        if not istable(v) then continue end
        for k2,stbl in pairs(v) do
            if not istable(stbl) then continue end
            if stbl.have_inrerchange then stbl.have_interchange = true end
        end
    end
    for k,v in pairs(Metrostroi.AnnouncementsASNP) do
        if v.name == name then
            Metrostroi.AnnouncementsASNP[k] = soundtable
            Metrostroi.AnnouncementsASNP[k].name = name
            Metrostroi.ASNPSetup[k] = datatable
            Metrostroi.ASNPSetup[k].name = name
            print("Metrostroi: Changed \""..name.."\" ASNP announcer.")
            return
        end
    end
    local id = table.insert(Metrostroi.AnnouncementsASNP,soundtable)
    Metrostroi.AnnouncementsASNP[id].name = name

    local id = table.insert(Metrostroi.ASNPSetup,datatable)
    Metrostroi.ASNPSetup[id].name = name
    print("Metrostroi: Added \""..name.."\" ASNP announcer.")
end

Metrostroi.AnnouncementsSarmatUPO = {}
Metrostroi.SarmatUPOSetup = {}
function Metrostroi.AddSarmatUPOAnnouncer(name,soundtable,datatable)
    if not soundtable or not datatable then return end
    for k,v in pairs(Metrostroi.AnnouncementsSarmatUPO) do
        if v.name == name then
            Metrostroi.AnnouncementsSarmatUPO[k] = soundtable
            Metrostroi.AnnouncementsSarmatUPO[k].name = name
            Metrostroi.SarmatUPOSetup[k] = datatable
            Metrostroi.SarmatUPOSetup[k].name = name
            print("Metrostroi: Changed \""..name.."\" Sarmat UPO(UPO2) announcer.")
            return
        end
    end
    local id = table.insert(Metrostroi.AnnouncementsSarmatUPO,soundtable)
    Metrostroi.AnnouncementsSarmatUPO[id].name = name

    local id = table.insert(Metrostroi.SarmatUPOSetup,datatable)
    Metrostroi.SarmatUPOSetup[id].name = name

    print("Metrostroi: Added \""..name.."\" Sarmat UPO(UPO2) announcer.")
end

Metrostroi.AnnouncementsUPO = {}
Metrostroi.UPOSetup = {}
function Metrostroi.SetUPOAnnouncer(soundtable,datatable)
    if not soundtable or not datatable then return end
    Metrostroi.AnnouncementsUPO = {soundtable}
    Metrostroi.UPOSetup = datatable
    --Generating noise
    for k,v in pairs(Metrostroi.UPOSetup or {}) do
        if v.noises and v.noiserandom < math.random() then
            v.noise = table.Random(v.noises)
        end
    end

    print("Metrostroi: Set UPO announcer and generated nosies.")
end
Metrostroi.AnnouncementsRRI = {}
Metrostroi.RRISetup = {}
function Metrostroi.SetRRIAnnouncer(soundtable,datatable)
    if not soundtable or not datatable then return end
    Metrostroi.AnnouncementsRRI = {soundtable}
    for k,v in pairs(datatable) do
        if not istable(v) then continue end
        for k2,stbl in pairs(v) do
            if not istable(stbl) then continue end
            if stbl.have_inrerchange then stbl.have_interchange = true end
        end
    end
    Metrostroi.RRISetup = datatable

    print("Metrostroi: Set RRI announcer.")
end

function Metrostroi.AddPassSchemeTex(id,name,schTbl)
    id = id.."_schemes"
    if not Metrostroi.Skins[id] then
        Metrostroi.Skins[id] = {}
    end
    local tbl = Metrostroi.Skins[id]
    for k,v in ipairs(tbl) do
        if name == v.name then
            tbl[k] = schTbl
            tbl[k].name = name
            return
        end
    end
    tbl[table.insert(tbl,schTbl)].name = name
end

local defaults = {
    ["702_routes"] = {
        "models/metrostroi_schemes/destination_table_black/label_cross",
        "models/metrostroi_schemes/destination_table_black/label_dev",
        "models/metrostroi_schemes/destination_table_black/label_freight",
    },
    ["710_routes"] = {
        "models/metrostroi_train/81-710/route_empty",
        "models/metrostroi_schemes/destination_table_white/label_cross",
        "models/metrostroi_schemes/destination_table_white/label_dev",
        "models/metrostroi_schemes/destination_table_white/label_freight",
    },
    ["717_routes"] = {
        "models/metrostroi_schemes/destination_table_white/label_cross",
        "models/metrostroi_schemes/destination_table_white/label_dev",
        "models/metrostroi_schemes/destination_table_white/label_freight",
    },
    ["720_routes"] = {
        "models/metrostroi_train/81-720/labels/label_empty",
        "models/metrostroi_schemes/destination_table_white/label_cross",
        "models/metrostroi_schemes/destination_table_white/label_freight",
    }
}
function Metrostroi.AddLastStationTex(id,stIndex,texture)
    id = id.."_routes"
    if not Metrostroi.Skins[id] then
        Metrostroi.Skins[id] = {}
        if defaults[id] then
            if type(defaults[id]) == "table" then
                Metrostroi.Skins[id].default = defaults[id][1]
                for i=2,#defaults[id] do
                    Metrostroi.AddLastStationTex(id:sub(1,-8),1000+(i-1),defaults[id][i])
                end
            else
                Metrostroi.Skins[id].default = defaults[id]
            end
        end
    end
    local tbl = Metrostroi.Skins[id]
    for k,v in pairs(tbl) do
        if k == index then
            tbl[v] = texture
            return
        end
    end
    tbl[stIndex] = table.insert(tbl,texture)
end
--------------------------------------------------------------------------------
-- Load core files and skins
--------------------------------------------------------------------------------
if SERVER then
    local OSes = {
        Windows = "win32",
		Windows64 = "win64",
        Linux = "linux",
		Linux64 = "linux64",
        BSD = "linux",
        POSIX = "linux",
        OSX = "osx",
    }
    DISABLE_TURBOSTROI = false
    if not DISABLE_TURBOSTROI then
        print(Format("Metrostroi: Trying to load simulation acceleration DLL for %s %s...",jit.os,jit.arch))
        --TODO: OS specific check
        if jit.arch == "x86" and OSes[jit.os] and file.Exists(Format("lua/bin/gmsv_turbostroi_%s.dll",OSes[jit.os]), "GAME") then
            if not pcall(require,"turbostroi") then
                if system.IsWindows() then
                    ErrorNoHalt("======================================================\nMetrostroi: Turbostroi library can't be loaded because of missing libraries!\nCheck, that you have Microsoft visual c++ 2010 and 2017 redistributable(x86) installed\nYou can download it from:\n")
                    MsgC(Color(255,0,0),"https://www.microsoft.com/en-us/download/details.aspx?id=26999 (2010 x86)\nhttps://aka.ms/vs/15/release/vc_redist.x86.exe (2017 x86)\n")
                    ErrorNoHalt("======================================================\n")
                else
                    ErrorNoHalt("Metrostroi: Turbostroi library can't be loaded!\n")
                end
            else
                print("Metrostroi: Turbostroi library loaded successfuly.")
            end
        elseif jit.arch == "x64" and OSes[jit.os.."64"] and file.Exists(Format("lua/bin/gmsv_turbostroi_%s.dll",OSes[jit.os.."64"]), "GAME") then
			if not pcall(require,"turbostroi") then
                if system.IsWindows() then
                    ErrorNoHalt("======================================================\nMetrostroi: Turbostroi library can't be loaded because of missing libraries!\nCheck, that you have Microsoft visual c++ 2010 and 2017 redistributable(x64) installed\nYou can download it from:\n")
                    MsgC(Color(255,0,0),"https://www.microsoft.com/en-us/download/details.aspx?id=26999 (2010 x64)\nhttps://aka.ms/vs/15/release/vc_redist.x64.exe (2017 x64)\n")
                    ErrorNoHalt("======================================================\n")
                else
                    ErrorNoHalt("Metrostroi: Turbostroi library can't be loaded!\n")
                end
            else
                print("Metrostroi: Turbostroi library loaded successfuly.")
            end
        elseif system.IsWindows() then
            ErrorNoHalt("======================================================\nMetrostroi: Turbostroi DLL not found.\nYou can found turbostroi for Windows at \n")
            MsgC(Color(255,0,0),"https://metrostroi.net/turbostroi\n")
            ErrorNoHalt("Just place this .dll to garrysmod/lua/bin folder.\nIf bin folder doesn't exists - create it.\nDon't forget to install Microsoft visual c++ 2010 and 2017 redistributable(x86)\nYou can download it from:\n")
            MsgC(Color(255,0,0),"https://www.microsoft.com/en-us/download/details.aspx?id=26999 (2010 x86)\nhttps://aka.ms/vs/15/release/vc_redist.x86.exe (2017 x86)\n")
            ErrorNoHalt("======================================================\n")
        else
            ErrorNoHalt("Metrostroi: Turbostroi DLL not found.\n")
        end
    else
        Turbostroi = nil
    end

    if Turbostroi
    then print("Metrostroi: Simulation acceleration ENABLED!")
    else print("Metrostroi: Simulation acceleration DISABLED")
    end

    -- Load all lua translations
    local files = file.Find("metrostroi_data/languages/*.lua","LUA")
    for _,filename in pairs(files) do
        AddCSLuaFile("metrostroi_data/languages/"..filename)
    end
    -- Loadall serverside lua files
    files = file.Find("metrostroi/sv_*.lua","LUA")
    for _,filename in pairs(files) do include("metrostroi/"..filename) end
    -- Load all shared files serverside

    include("metrostroi/convars.lua")
    files = file.Find("metrostroi/sh_*.lua","LUA")
    for _,filename in pairs(files) do include("metrostroi/"..filename) end

    files = file.Find("metrostroi/cl_*.lua","LUA")
    for _,filename in pairs(files) do AddCSLuaFile("metrostroi/"..filename) end
    -- Add all shared files
    AddCSLuaFile("metrostroi/convars.lua")
    files = file.Find("metrostroi/sh_*.lua","LUA")
    for _,filename in pairs(files) do AddCSLuaFile("metrostroi/"..filename) end
    -- Add all system files
    files = file.Find("metrostroi/systems/sys_*.lua","LUA")
    for _,filename in pairs(files) do AddCSLuaFile("metrostroi/systems/"..filename) end
    -- Add skin
    Metrostroi.Skins = {["717_schemes"]={p={},m={}}}
    files = file.Find("metrostroi/skins/*.lua","LUA")
    for _,filename in pairs(files) do
        AddCSLuaFile("metrostroi/skins/"..filename)
        include("metrostroi/skins/"..filename)
    end

    files = file.Find("metrostroi/maps/*.lua","LUA")
    for _,filename in pairs(files) do
        AddCSLuaFile("metrostroi/maps/"..filename)
        include("metrostroi/maps/"..filename)
    end
else
    --[[
    concommand.Add( "metrostroi_reload_spawnmenu", function()
    if IsValid( g_SpawnMenu ) then
        g_SpawnMenu:Remove()
        g_SpawnMenu = nil
    end
        hook.Call("OnGamemodeLoaded")
    end)]]
    include("metrostroi/convars.lua")
    -- Load all clientside files
    local files = file.Find("metrostroi/cl_*.lua","LUA")
    for _,filename in pairs(files) do include("metrostroi/"..filename) end
    -- Load all shared files
    files = file.Find("metrostroi/sh_*.lua","LUA")
    for _,filename in pairs(files) do include("metrostroi/"..filename) end

    -- Add skins
    Metrostroi.Skins = {["717_schemes"]={p={},m={}}}
    files = file.Find("metrostroi/skins/*.lua","LUA")
    for _,filename in pairs(files) do include("metrostroi/skins/"..filename) end
    --Include map scripts
    files = file.Find("metrostroi/maps/*.lua","LUA")
    for _,filename in pairs(files) do   include("metrostroi/maps/"..filename) end
end
Metrostroi.AddLastStationTex("710","obkatka","metrostroi_skins/81-710_names/route_obkatka")
Metrostroi.AddLastStationTex("720","obkatka","metrostroi_skins/81-720_names/label_obkatka")
--------------------------------------------------------------------------------
-- Load systems
--------------------------------------------------------------------------------
if not Metrostroi.TurbostroiRegistered then
    Metrostroi.TurbostroiRegistered = {}
end

function Metrostroi.DefineSystem(name)
    if not Metrostroi.BaseSystems[name] then
        Metrostroi.BaseSystems[name] = {}
    end
    TRAIN_SYSTEM = Metrostroi.BaseSystems[name]
    TRAIN_SYSTEM_NAME = name
end

local function loadSystem(filename)
    -- Get the Lua code
    include(filename)

    -- Load train systems
    if TRAIN_SYSTEM then TRAIN_SYSTEM.FileName = filename end
    local name = TRAIN_SYSTEM_NAME or "UndefinedSystem"
    TRAIN_SYSTEM_NAME = nil

    -- Register system with turbostroi
    if Turbostroi and (not Metrostroi.TurbostroiRegistered[name]) then
        Turbostroi.RegisterSystem(name,filename)
        Metrostroi.TurbostroiRegistered[name] = true
    end

    -- Load up the system
    Metrostroi.Systems["_"..name] = TRAIN_SYSTEM
    Metrostroi.BaseSystems[name] = TRAIN_SYSTEM
    Metrostroi.Systems[name] = function(train,...)
        local tbl = { _base = name }
        local TRAIN_SYSTEM = Metrostroi.BaseSystems[tbl._base]
        if not TRAIN_SYSTEM then print("No system: "..tbl._base) return end
        for k,v in pairs(TRAIN_SYSTEM) do
            if type(v) == "function" then
                tbl[k] = function(...)
                    if not Metrostroi.BaseSystems[tbl._base][k] then
                        print("ERROR",k,tbl._base)
                    end
                    return Metrostroi.BaseSystems[tbl._base][k](...)
                end
            else
                tbl[k] = v
            end
        end

        tbl.Initialize = tbl.Initialize or function() end
        tbl.ClientInitialize = tbl.ClientInitialize or function() end
        tbl.Think = tbl.Think or function() end
        tbl.ClientThink = tbl.ClientThink or function() end
        tbl.ClientDraw = tbl.ClientDraw or function() end
        tbl.Inputs = tbl.Inputs or function() return {} end
        tbl.Outputs = tbl.Outputs or function() return {} end
        tbl.TriggerOutput = tbl.TriggerOutput or function() end
        tbl.TriggerInput = tbl.TriggerInput or function() end

        tbl.Train = train
        if SERVER then
            tbl:Initialize(...)
        else
            tbl:ClientInitialize(...)
        end
        tbl.OutputsList = tbl:Outputs()
        tbl.InputsList = tbl:Inputs()
        tbl.IsInput = {}
        for _,v in pairs(tbl.InputsList) do tbl.IsInput[v] = true end
        return tbl
    end
end

-- Load all systems
local files = file.Find("metrostroi/systems/sys_*.lua","LUA")
for _,short_filename in pairs(files) do
    local filename = "metrostroi/systems/"..short_filename

    -- Load the file
    if SERVER
    then loadSystem(filename)
    else timer.Simple(0.05, function() loadSystem(filename) end)
    end
end
local function loadAnn ()
    if Metrostroi.WorkingStations then
        for k, v in pairs(Metrostroi.WorkingStations) do
            for k1, v1 in pairs(v) do
                Metrostroi.WorkingStations[k][v1] = k1
            end
        end
    end

    if Metrostroi.EndStations then
        for k, v in pairs(Metrostroi.EndStations) do
            for k1, v1 in pairs(v) do
                Metrostroi.EndStations[k][v1] = k1
            end
        end
    end
end
if SERVER
then loadAnn()
else timer.Simple(0.1, loadAnn)
end
if SERVER then
    util.AddNetworkString "MetrostroiMessages"
    local function CheckErr(ply)
        if not Turbostroi and IsValid(ply) and (ply:IsSuperAdmin() or not game.IsDedicated()) then
            net.Start "MetrostroiMessages"
                net.WriteString("Turbostroi is not installed!\nTurbostroi is accelerating train calculations by using multiple\ncores. Check "..(game.IsDedicated() and "server" or "game").." logs for more information.\nYou can download it at:\nhttps://metrostroi.net/turbostroi")
                net.WriteString("https://metrostroi.net/turbostroi")
            net.Send(ply)
        end
        if not game.IsDedicated() then
            net.Start "MetrostroiMessages"
                net.WriteString("For comfort and smooth experience, you need to\njoin to server or host a dedicated server.\nIt's required because Garry's mod using only\n1 core, and now it using it for client and server code.\nWhen you join or host server you can separate server\nand client processes to different cores.\nInformation about how to host server:\nhttp://wiki.garrysmod.com/page/Hosting_A_Dedicated_Server")
                net.WriteString("http://wiki.garrysmod.com/page/Hosting_A_Dedicated_Server")
            net.Send(ply)
        end
    end
    local m_adm = {}
    for _,v in pairs(player.GetHumans()) do
        if IsValid(v) and v:IsAdmin() then
            table.insert(m_adm,v)
        end
    end
    CheckErr(m_adm)
    hook.Add("PlayerInitialSpawn","MetrostroiWarnMessage",CheckErr)
else
    local function err(msg, url)
        local count = #msg:gsub("[^\n]+","")
        local size = 83+count*18
        local warn = vgui.Create("DFrame")
        warn:SetDeleteOnClose(true)
        warn:SetTitle("Warning")
        warn:SetSize(380, size)
        warn:SetDraggable(false)
        warn:SetSizable(false)
        warn:Center()
        warn:MakePopup()
        local wrn = warn.Paint
        warn.Paint = function(self, w, h)
            wrn(self, w, h)
            draw.DrawText(msg, "Trebuchet18", w/2, 30, color_white, 1)
        end

        local Close = vgui.Create("DButton", warn)
        Close:SetText("I understand")
        Close:SetPos(290, size-30)
        Close:SetSize(80, 25)
        Close.DoClick = function()
            warn:Close()
        end

        local Open = vgui.Create("DButton", warn)
        Open:SetText("Open link")
        Open:SetPos(15, size-30)
        Open:SetSize(80, 25)
        Open.DoClick = function()
            Close:SetText("Close window")
            gui.OpenURL(url)
        end

        local Copy = vgui.Create("DButton", warn)
        Copy:SetText("Copy link")
        Copy:SetPos(100, size-30)
        Copy:SetSize(80, 25)
        Copy.DoClick = function()
            Close:SetText("Close window")
            SetClipboardText(url)
        end
    end
    net.Receive("MetrostroiMessages", function()
        err(net.ReadString(),net.ReadString())
    end)
end
hook.Run("MetrostroiLoaded")
Metrostroi.Loaded = true

if SERVER then
    ---------------------------------------------------
    --          Metrostroi reverser ID get           --
    --===============================================--
    -- If you read this,  please, don't try to spam  --
    --       metrostroi.net site with requests       --
    --           Thanks for understanding            --
    --===============================================--
    --  Если ты читаешь это,  пожалуйта, не пытайся  --
    --    спамить запросами на сайт metrostroi.net   --
    --              Спасибо за понимание             --
    ---------------------------------------------------
    --Cvars
    local R_Disabled = CreateConVar("metrostroi_reverser_local",0, FCVAR_ARCHIVE,"Switch reverser IDs to local mode")

    Metrostroi.ReverserIDs = Metrostroi.ReverserIDs or {SS = {},SG = {}}
    Metrostroi.ReverserID = Metrostroi.ReverserID or 0
    local function claimID(ply,id,typ,isLocal)
        if not id then return end
        if typ then
            Metrostroi.ReverserIDs.SG[ply] = id
        else
            Metrostroi.ReverserIDs.SS[id] = not isLocal
            Metrostroi.ReverserIDs.SS[ply] = id
        end
    end

    local function isNotLocal(id)
        if not id then return end
        return Metrostroi.ReverserIDs.SS[id]
    end

    local function getLocalID(ply)
        if Metrostroi.ReverserIDs.SS[ply] then return Metrostroi.ReverserIDs.SS[ply] end

        repeat
            Metrostroi.ReverserID = Metrostroi.ReverserID + 1
        until Metrostroi.ReverserIDs.SS[Metrostroi.ReverserID]==nil

        claimID(ply,Metrostroi.ReverserID,false,true)
        return Metrostroi.ReverserID
    end

    local function removeGolden(ply)
        if Metrostroi.ReverserIDs.SG[ply] then Metrostroi.ReverserIDs.SG[ply] = nil end
    end

    function Metrostroi.GetReverserID(ply,callback,typ)

        if not IsValid(ply) or ply:IsBot() then return end
        if callback == true then return Metrostroi.ReverserIDs.SG[ply] end
        if game.SinglePlayer() then callback(1) return end
        if not typ then
            local ID = hook.Run("MetrostroiGetReverserID",ply)
            if ID and type(ID)=="number" then callback(ID) return end
            if R_Disabled:GetBool() then callback(getLocalID(ply)) return end
            if isNotLocal(Metrostroi.ReverserIDs.SS[ply]) then callback(Metrostroi.ReverserIDs.SS[ply]) return end
        end

        http.Post("https://api.metrostroi.net/get_info",{[typ and "SG" or "SS"]=ply:SteamID()},function(result,_,_,statusCode)
            if not IsValid(ply) then return end
            local ID = statusCode == 200 and tonumber(result)

            claimID(ply,ID,typ)
            callback(ID or not typ and getLocalID(ply))

            if typ and not ID then removeGolden(ply) end
        end,function()
            if not IsValid(ply) then return end

            callback(not typ and getLocalID(ply))

            if typ then removeGolden(ply) end
        end)
    end

    ---------------------------------------------------
    --         Metrostroi servers monitoring         --
    --===============================================--
    -- If you read this,  please, don't try to break --
    --      monitoring by sending wrong data to      --
    --  metrostroi.net.  Monitoring not created for  --
    --      break it.  Thanks for understanding      --
    --===============================================--
    --   Если ты читаешь это, пожалуйта, не пытайся  --
    --  сломать мониторинг  отправкой не достоверных --
    --   данных на сайт metrostroi.net.  Мониторинг  --
    --     создан не для того, чтобы его пытались    --
    --         сломать. Спасибо за понимание         --
    ---------------------------------------------------
    --Cvars
    local CV_Enabled = CreateConVar("metrostroi_monitoring_allow",1, FCVAR_ARCHIVE,"Enables metrostroi servers monitoring for this server. Send only basic info(map,ip,port,hostname) for metrostroi servers list")
    local CV_Key     = CreateConVar("metrostroi_monitoring_key","", FCVAR_ARCHIVE,"Unique key for metrostroi servers monitoring. Used for server identification for servers with dynamic IP")
    local CV_Pass    = GetConVar("sv_password")
    local State,LastSend,LastRec,LastSucc = 0
    local LastErr

    local metrostroiMonitoring
    local function monitoringStarted() return timer.Exists("MetrostroiMonitoring") or timer.Exists("MetrostroiMonitoringPass") end

    local function adjustTimer(time,force)
        if not force and not timer.Exists("MetrostroiMonitoring") then return end
        timer.Create("MetrostroiMonitoring",time,0,metrostroiMonitoring)
        --MsgC(Color(255,0,255),"MetrostroiMon: ",Color(255,255,255),"Timer ",time,"\n")
    end
    local function destroy()
        hook.Remove("PlayerInitialSpawn","MetrostroiMonitoring")
        hook.Remove("PlayerDisconnected","MetrostroiMonitoring")
        timer.Remove("MetrostroiMonitoring")
        timer.Remove("MetrostroiMonitoringPass")
        --cvars.RemoveChangeCallback("metrostroi_monitoring_allow", "metrostroiMonitoring")

        --MsgC(Color(255,0,255),"MetrostroiMon: ",Color(255,255,255),"Destroy\n")

        State = 0
    end
    local oldPass = CV_Pass:GetString()
    local function init()
        if monitoringStarted() then destroy() end
        if not CV_Enabled:GetBool() then return end
        adjustTimer(10,true)
        --Post, if new player joined
        hook.Add("PlayerInitialSpawn","MetrostroiMonitoring",function(ply) if not ply:IsBot() then metrostroiMonitoring(1,ply) end end)
        hook.Add("PlayerDisconnected","MetrostroiMonitoring",function(ply) if not ply:IsBot() then metrostroiMonitoring(0,ply) end end)
        --MsgC(Color(255,0,255),"MetrostroiMon: ",Color(255,255,255),"Init\n")

        State = 1
        LastErr = false
    end

    local codes = {
        [402] = "No SourceQuery answer",
        [403] = "IP rejected",
        [404] = "Wrong parameters",
    }

    local function metrostroiMonitoringSucc(responseText, _,  _, statusCode)
        --if not monitoringStarted() then return end
        if statusCode == 401 then return end
        LastRec = CurTime()
        if monitoringStarted() and State==1 then State=2 end
        if codes[statusCode] then
            RunConsoleCommand("metrostroi_monitoring_stop")
            LastErr = codes[statusCode]
        elseif statusCode == 500 then --Error in site
            adjustTimer(30)
            LastErr = "Internal server error (500). "..responseText
        elseif statusCode==200 then
            if #responseText==0 then
                adjustTimer(60)
                LastErr = false
                LastSucc = CurTime()
            else
                local code = responseText:sub(1,2)
                local response = responseText:sub(3,-1)
                if code == "01" then
                    CV_Key:SetString(response)
                    adjustTimer(30)
                elseif code=="02" then
                    if LastErr ~= "Server requested update (203)" then
                        LastErr = "Server requested update (203)"
                        metrostroiMonitoring()
                    end
                    adjustTimer(30)
                elseif code == "03" then
                    MsgC(Color(255,255,255),"Your code: ",Color(255,0,255),response:sub(1,6),"\n")
                    MsgC(Color(255,255,255),"Your ServerID: ",Color(255,0,255),response:sub(7,-1),"\n")
                    MsgC(Color(255,255,255),"Do not show this code and ServerID to third parties!\n")
                elseif code == "04"then
                    MsgC(Color(255,0,0),"This server is already confirmed\n")
                    MsgC(Color(255,0,0),"If you didn't do it, write to\n")
                    MsgC(Color(255,0,255),"https://metrostroi.net/tickets",Color(255,0,0)," about it.\n")
                end
                LastErr = code=="02" and LastErr or false
                LastSucc = CurTime()
            end
        --[[ elseif 200 <= statusCode and statusCode <= 202 then
            if statusCode == 201 and not responseText:find("SourceQuery") then
                CV_Key:SetString(responseText)
                adjustTimer(30)
            elseif statusCode == 200 then
                adjustTimer(60)
            end
            LastSucc = CurTime()
            LastErr = false
        elseif statusCode == 203 then
            if LastErr ~= "Server requested update (203)" then
                LastErr = "Server requested update (203)"
                metrostroiMonitoring()
            end
            adjustTimer(30)
        elseif statusCode == 204 then
            MsgC(Color(255,255,255),"Your code: ",Color(255,0,255),responseText,"\n")
            MsgC(Color(255,255,255),"Do not show this code to third parties!\n")
        elseif statusCode == 205 then
            MsgC(Color(255,0,0),"This server is already confirmed\n")
            MsgC(Color(255,0,0),"If you didn't do it, write to\n")
            MsgC(Color(255,0,255),"https://metrostroi.net/tickets",Color(255,0,0)," about it.\n")]]
        else --Unhandled error in site
            adjustTimer(30)
            LastErr = Format("Unhandled status code (%d)!\n%s",statusCode,responseText)
            RunConsoleCommand("metrostroi_monitoring_status")
        end
        --[[
        MsgC(Color(255,0,255),"MetrostroiMon:")
        MsgC(Color(255,255,255),"\n\tResponse  : ",Color(255,255,0),responseText)
        MsgC(Color(255,255,255),"\n\tStatusCode: ",Color(255,255,0),statusCode)
        Msg("\n")--]]
    end

    local function metrostroiMonitoringFail(errorMessage)
        --MsgC(Color(255,0,255),"MetrostroiMon: ",Color(255,0,0),"Failed\n")
        adjustTimer(20)
        LastErr = "Data send error! "..errorMessage
    end

    local function post(params)
        --PrintTable(params)
        --MsgC(Color(255,0,255),"MetrostroiMon: ",Color(255,255,255),"Post\n")
        http.Post("https://api.metrostroi.net/server_info",params,metrostroiMonitoringSucc,metrostroiMonitoringFail)
        LastSend = CurTime()
    end
    local function shutdown()
        if not monitoringStarted() then return end
        local key = CV_Key:GetString("metrostroi_monitoring_key")
        if #key ~= 128 then key = "" end
        post{
            status = "2",
            uid = key,
        }
        destroy()
    end

    metrostroiMonitoring = function(typ,ply)
        if not monitoringStarted() then return end
        if game.SinglePlayer() or not CV_Enabled:GetBool() or not Metrostroi.CurrentMap then
            destroy()
            return
        end
        local ip,port = string.match(game.GetIPAddress(),"([%d.]+):([%d]+)")
        local key = CV_Key:GetString("metrostroi_monitoring_key")
        if #key ~= 128 then key = "" end
        if  CV_Pass:GetString("sv_password") ~= "" then
            --if key ~= "" then
                post{
                    --[[ ip = ip,
                    port = port,
                    hostname = "",
                    map = "",
                    maxplayers = "0",
                    players = "0",
                    version = "0",--]]

                    status = "1",
                    uid = key,
                }
            --end
            destroy()
            --Detect sv_password changes for monitoring status change
            timer.Create("MetrostroiMonitoringPass",1,0,function()
                local value = CV_Pass:GetString()
                if oldPass ~= value and value == "" then
                    init()
                    timer.Remove("MetrostroiMonitoringPass")
                end
                oldPass = value
            end)
            State = -1
        elseif typ==2 then
            post{
                uid = key,
                owner = ply,
                status = "0",
            }
        else
            local players
            if LastErr == "Server requested update (203)" then
                players = {}
                for _,v in pairs(player.GetHumans()) do
                    if v:IsBot() then continue end
                    table.insert(players,v:SteamID())
                end
            end
            post{
                ip = ip,
                port = port,
                hostname = GetHostName(),
                map = game.GetMap(),
                maxplayers = tostring(game.MaxPlayers()),
                players = tostring(typ==0 and player.GetCount()-1 or player.GetCount()),
                version = tostring(Metrostroi.Version),
                status = "0",
                uid = key,
                connect = ply and tostring(typ),
                SID = ply and ply:SteamID(),
                players_list = players and util.TableToJSON(players),
            }
        end
    end

    init()
    concommand.Add("metrostroi_monitoring_start",function(ply)
        if IsValid(ply) then return end

        if not monitoringStarted() and CV_Enabled:GetBool() then
            init()
            MsgC(Color(255,0,255),"MetrostroiMon: ",Color(0,255,0),"Started.\n")
        elseif  CV_Enabled:GetBool() then
            MsgC(Color(255,0,255),"MetrostroiMon: ",Color(255,255,0),"Already started.\n")
        else
            MsgC(Color(255,0,255),"MetrostroiMon: ",Color(255,0,0),"Start blocked.",
                Color(255,255,0),"\n\tIf you want send monitoring data, type\n\t",Color(255,0,255),"metrostroi_monitoring_allow 1",Color(255,255,0)," to console\n")
        end
    end,nil,"Try to start monitoring")
    concommand.Add("metrostroi_monitoring_stop",function(ply)
        if IsValid(ply) then return end

        if monitoringStarted() then
            shutdown()
            MsgC(Color(255,0,255),"MetrostroiMon: ",Color(0,255,0),"Stopped.\n")
        else
            MsgC(Color(255,0,255),"MetrostroiMon: ",Color(255,255,0),"Already stopped.\n")
        end
    end,nil,"Try to stop monitoring")

    local function printTime(time)
        if not time then MsgC(Color(255,255,0),"N/A\n") return end
        local elapsed = CurTime()-time
        MsgC(
            Color(elapsed > 120 and 255 or 0,elapsed < 180 and 255 or 0,0),
            string.NiceTime(elapsed),"\n"
        )
    end
    concommand.Add("metrostroi_monitoring_status",function(ply)
        if IsValid(ply) then return end

        if State>0 then
            MsgC(Color(255,0,255),"MetrostroiMon:\t\t",Color(0,255,0),"Watchdog working\n")
            MsgC(Color(255,255,255),"\tStatus:\t\t")
            if State == 1 then
                MsgC(Color(255,255,0),"Initialization...\n")
            elseif State == 2 then
                MsgC(Color(0,255,0),"Working")
                if LastErr then MsgC(Color(255,0,0)," Errored") end
                MsgC("\n")
            end
            MsgC(Color(255,255,255),"\tNext send:\t",string.NiceTime(timer.TimeLeft("MetrostroiMonitoring")),"\n")
            MsgC(Color(255,255,255),"\tLast send:\t")
            printTime(LastSend)
            MsgC(Color(255,255,255),"\tLast receive:\t")
            printTime(LastRec)
            MsgC(Color(255,255,255),"\tLast success:\t")
            printTime(LastSucc)
            if LastErr then MsgC(Color(255,0,0),"\tLast error:\t",LastErr,"\n") end
        elseif State == -1 then
            MsgC(Color(255,0,255),"MetrostroiMon:\t\t",Color(255,255,0),"Suspended by sv_password\n")
            if LastErr then MsgC(Color(255,0,0),"\tLast error:\t",LastErr,"\n") end
        elseif CV_Enabled:GetBool() then
            MsgC(Color(255,0,255),"MetrostroiMon:\t\t",Color(0,255,0),"Watchdog stopped\n")
            if LastErr then MsgC(Color(255,0,0),"\tCaused by:\t",LastErr,"\n") end
        else
            MsgC(Color(255,0,255),"MetrostroiMon: ",Color(255,0,0),"Watchdog blocked.",
                Color(255,255,0),"\n\tIf you want send monitoring data,enter\n\t",Color(255,0,255),"metrostroi_monitoring_allow 1",Color(255,255,0)," to console\n")
            if LastErr then MsgC(Color(255,0,0),"\tLast error:\t",LastErr,"\n") end
        end
    end,nil,"Monitoring status")
    --Restart monitoring, if we want to start it
    concommand.Add("metrostroi_monitoring_restart",function(ply)
        if IsValid(ply) then return end

        RunConsoleCommand("metrostroi_monitoring_stop")
        RunConsoleCommand("metrostroi_monitoring_start")
    end,nil,"Restart monitoring")

    concommand.Add("metrostroi_monitoring_confirm",function(ply,_,_,str)
        if IsValid(ply) then return end

        if not monitoringStarted() or State<=1 then
            print("Monitoring is not started. It can be disabled or have a error.")
            print("You can check monitoring status by metrostroi_monitoring_status console command.")
        elseif #str==0 then
            print("Usage of the command:metrostroi_monitoring_confirm SteamID")
        elseif not str:match("^STEAM_[0-5]:[0-2]:[%d]+$") then
            print("Invalid argument. First argument must be valid SteamID.")
        else
            metrostroiMonitoring(2,str)
        end
    end,nil,"Confirm validity of server and set the owner of the server.")


    cvars.AddChangeCallback("metrostroi_monitoring_allow", function(cvar, old, value)
        if not monitoringStarted() and CV_Enabled:GetBool() then
            RunConsoleCommand("metrostroi_monitoring_start")
        elseif monitoringStarted() and not CV_Enabled:GetBool() then
            RunConsoleCommand("metrostroi_monitoring_stop")
        end
    end, "metrostroiMonitoring")
    hook.Add("ShutDown","MetrostroiMonitoring",shutdown)
end

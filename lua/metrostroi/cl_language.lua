---[=[
local function removeSpaces(str)
    return str:gsub("#[.*#]",""):gsub("([^\\#])#.*$","%1"):gsub("\\#","#"):gsub("^[ \t]+",""):gsub("[ \t]+$","")
end

--local LangTable = {}

--]=]


Metrostroi.Languages = Metrostroi.Languages or {}
Metrostroi.ChoosedLang = GetConVar("metrostroi_language"):GetString()
function Metrostroi.GetPhrase(phrase)
    if Metrostroi.CurrentLanguageTable and not Metrostroi.CurrentLanguageTable[phrase] then
        MsgC(Color(255,0,0),"No phrase:",Color(0,255,0),phrase,"\n")
    end
    return
        Metrostroi.CurrentLanguageTable and Metrostroi.CurrentLanguageTable[phrase] or phrase
end
function Metrostroi.HasPhrase(phrase)
    if Metrostroi.CurrentLanguageTable and not Metrostroi.CurrentLanguageTable[phrase] then
        MsgC(Color(255,0,0),"No phrase:",Color(0,255,0),phrase,"\n")
    end
    return
        Metrostroi.CurrentLanguageTable and Metrostroi.CurrentLanguageTable[phrase]
end

if not file.Exists("metrostroi_data","DATA") then file.CreateDir("metrostroi_data") end
if not file.Exists("metrostroi_data/languages","DATA") then file.CreateDir("metrostroi_data/languages") end
local function debugmsg(...)
    if GetConVar("metrostroi_drawdebug"):GetInt() == 0 then return end
    MsgC(...)
    MsgC("\n")
end
local function errmsg(...)
    if GetConVar("metrostroi_drawdebug"):GetInt() == 0 then return end
    MsgC(...)
    ErrorNoHalt("\n")
end
local function errnhmsg(...)
    if GetConVar("metrostroi_drawdebug"):GetInt() == 0 then return end
    ErrorNoHalt(...)
end
function Metrostroi.LoadLanguage(lang,force)
    if not Metrostroi.Languages[lang] then return end
    local ENTl = list.GetForEdit("SpawnableEntities")
    local SWEPl = list.GetForEdit("Weapon")
    Metrostroi.CurrentLanguageTable = Metrostroi.Languages[lang] or {}
    for id,phrase in pairs(Metrostroi.CurrentLanguageTable) do
        if id == "lang" then continue end
        if id:sub(1,9) == "Entities." then
            local tbl = string.Explode(".",id:sub(10,-1))
            if tbl[1] == "Category" then
                local cat = tbl[2]
                debugmsg(Color(255,0,255),"Add language ",lang," phrase:\t",Color(0,255,0),id,"=",phrase,Color(255,0,255)," for class ",Color(0,255,0),class)
                continue
            end
            local class = tbl[1]
            local ENT = scripted_ents.GetStored(class)
            if not ENT then
                errmsg(Color(255,0,0),"No entity ",Color(255,0,255),class,Color(255,0,0)," for phrase:",Color(0,255,0),id)
                continue
            else
                ENT = ENT.t
            end
            if tbl[2] == "Name" then
                if not ENTl[class] then
                    if ENT.Spawner then
                        ENT.Spawner.Name = phrase
                    else
                        errmsg(Color(255,0,0),"No spawnmenu for entity ",Color(255,0,255),class,Color(255,0,0)," for phrase:",Color(0,255,0),id)
                    end
                    continue
                end
                ENTl[class].PrintName = phrase
                debugmsg(Color(255,0,255),"Add language ",lang," phrase:\t",Color(0,255,0),id,"=",phrase,Color(255,0,255)," for class ",Color(0,255,0),class)
            elseif tbl[2] == "Buttons" then
                if not ENT.ButtonMap[tbl[3]] then
                    errnhmsg("Check translation for "..id.."! Can't find panel named "..tbl[3].."\n")
                    continue
                end
                if not ENT.ButtonMap[tbl[3]].buttons then
                    errnhmsg("Check translation for "..id.."! Can't find buttons in panel named "..tbl[3].."\n")
                end
                local button
                for k,v in pairs(ENT.ButtonMap[tbl[3]].buttons) do
                    if v.ID == tbl[4] then
                        v.tooltip = phrase
                        button = v
                        break
                    end
                end
                if not button then
                    errnhmsg("Check translation for "..id.."! Can't find button named "..tbl[4].." in panel "..tbl[3].."\n")
                end
            elseif tbl[2] == "Spawner" then
                if not ENT.Spawner then
                    errmsg(Color(255,0,0),"No spawner table for entity ",Color(255,0,255),class,Color(255,0,0)," for phrase:",Color(0,255,0),id)
                    continue
                end
                for i,v in pairs(ENT.Spawner) do
                    if type(v) == "function" then continue end
                    if v[1] == tbl[3] then
                        if tbl[4] == "Name" then
                            v[2] = phrase
                        elseif v[3] == "List" and v[4] then
                            local numb = tonumber(tbl[4])
                            if numb and type(v[4]) ~= "function" and v[4][numb] then
                                v[4][numb] = phrase
                            else
                                errmsg(Color(255,0,0),"No spawner list table for entity ",Color(255,0,255),class,Color(255,0,0)," for phrase:",Color(0,255,0),id)
                            end
                        else
                            errmsg(Color(255,0,0),"Spawner translate error for entity ",Color(255,0,255),class,Color(255,0,0)," for phrase:",Color(0,255,0),id)
                        end
                    end
                end
            end
        elseif id:sub(1,8) == "Weapons." then
            local tbl = string.Explode(".",id:sub(9,-1))
            local class = tbl[1]
            local SWEP = weapons.GetStored(class)
            if not SWEP then
                errmsg(Color(255,0,0),"No weapon ",Color(255,0,255),class,Color(255,0,0)," for phrase:",Color(0,255,0),id)
                continue
            end
            if tbl[2] == "Name" then
                SWEP.PrintName = phrase
                SWEPl[class].PrintName = phrase
            elseif tbl[2] == "Purpose" then
                SWEP.Purpose = phrase
                --SWEPl[class].Purpose = phrase
            elseif tbl[2] == "Instructions" then
                SWEP.Instructions = phrase
                --SWEPl[class].Instructions = phrase
            end
            debugmsg(Color(255,0,255),"Add language ",lang," phrase:\t",Color(0,255,0),id,"=",phrase,Color(255,0,255)," for class ",Color(0,255,0),class)
        else
            debugmsg(Color(255,0,255),"Add language ",lang," phrase:\t",Color(0,255,0),id,Color(255,0,255),"=",Color(0,255,0),phrase)
        end
    end
    if force or GetConVar("metrostroi_language_softreload"):GetInt()~=1 then
        RunConsoleCommand("spawnmenu_reload")
        hook.Run( "GameContentChanged" )
    end
end

cvars.AddChangeCallback("metrostroi_language", function(cvar, old, value)
    Metrostroi.LoadLanguage(value,true)
end, "language")

local function parseLangFile(filename,txt)
    local currlang
    local i = 0
    local ignoring = false
    for line in txt:gmatch("[^\n\r]+") do
        i = i + 1
        if ignoring and line:find("%][^\\]?#") then ignoring = false continue end
        if ignoring then continue end
        if line:find("[^\\]?#%[") then ignoring = true end
        local lang,founded = removeSpaces(line):gsub("^%[([%w]+)%]$","%1")
        if founded > 0 then
            currlang = lang
            Metrostroi.Languages[lang] = Metrostroi.Languages[lang] or {}
            continue
        end
        local founded = line:gsub("^%[([%w]+)%]$","%1")
        local k,v = line:match("([^=]+)=([^=]+)")
        if k and v then
            if not currlang then
                errnhmsg("Metrostroi: Language not selected\n")
                break
            end
            Metrostroi.Languages[currlang][removeSpaces(k)] = removeSpaces(v):gsub("\\n","\n"):gsub("\\t","\t")
            continue
        end
        if #line > 0 and line[1] ~="#" then
            errnhmsg(Format("Metrostroi: Language parse error in line %d: %s [%s]\n",i,line,filename))
            break
        end
    end
end

local function exportLangJSON(filename,txt)
    local langs = {}
    local currlang
    local i = 0
    local ignoring = false
    for line in txt:gmatch("[^\n\r]+") do
        i = i + 1
        if ignoring and line:find("%][^\\]?#") then ignoring = false continue end
        if ignoring then continue end
        if line:find("[^\\]?#%[") then ignoring = true end
        local lang,founded = removeSpaces(line):gsub("^%[([%w]+)%]$","%1")
        if founded > 0 then
            print("Selected lang",lang)
            currlang = lang
            if not langs[currlang] then langs[currlang] = "{" end
            continue
        end
        local founded = line:gsub("^%[([%w]+)%]$","%1")
        local k,v = line:match("([^=]+)=([^=]+)")
        if k and v then
            if not currlang then
                errnhmsg("Metrostroi: Language not selected\n")
                break
            end
            local str,addstr = langs[currlang],Format('\n\t"%s": "%s"',removeSpaces(k),removeSpaces(string.JavascriptSafe(v):gsub("\\\\([tn])","\\%1")))
            if langs[currlang] == "{" then
                langs[currlang] = str..addstr
            else
                langs[currlang] = str..","..addstr
            end
            continue
        end
        if #line > 0 and line[1] ~="#" then
            errnhmsg(Format("Metrostroi: Language parse error in line %d: %s [%s]\n",i,line,filename))
            break
        end
    end
    local str = ""
    for k,v in pairs(langs) do
        str = str.."["..k.."]\n"..v.."\n}"
    end
    SetClipboardText(str)
end


concommand.Add("metrostroi_language_exportjson", function(_, _, args)
    if not args[1] then return end
    print("metrostroi_data/languages/"..args[1]..".lua")
    exportLangJSON(args[1],include("metrostroi_data/languages/"..args[1]..".lua"))
end)

local function reloadLang()
    if not GAMEMODE or not Metrostroi then return end
    Metrostroi.Languages = {en = {}}
    --Load builtin default languages
    --[[ if Metrostroi.BuiltinLanguages then
        for k, lang in pairs(Metrostroi.BuiltinLanguages) do
            local JSON = util.JSONToTable(lang)
            if not JSON then ErrorNoHalt("Metrostroi: Error loading default language file: ",k,"\n") continue end
            if not Metrostroi.Languages[JSON.Lang] then Metrostroi.Languages[JSON.Lang] = {} end
            for id,phrase in pairs(JSON) do
                Metrostroi.Languages[JSON.Lang][id] = phrase
            end
        end
    end--]]

    --Load builtin lua languages/*_base.lua
    for k, filename in pairs(file.Find("metrostroi_data/languages/*_base.lua","LUA")) do
        local lang = include("metrostroi_data/languages/"..filename)
        if not lang then continue end
        parseLangFile(filename,lang)
    end
    --Load client languages
    for k, filename in pairs(file.Find( "metrostroi_data/languages/*_base.txt", "DATA")) do
        local lang = file.Read("metrostroi_data/languages/"..filename)
        parseLangFile(filename,lang)
    end

    --Load builtin lua languages
    for k, filename in pairs(file.Find("metrostroi_data/languages/*.lua","LUA")) do
        if filename:find("_base.lua") then continue end
        local lang = include("metrostroi_data/languages/"..filename)
        if not lang then continue end
        parseLangFile(filename,lang)
    end
    --Load client languages
    for k, filename in pairs(file.Find( "metrostroi_data/languages/*.txt", "DATA")) do
        if filename:find("_base.txt") then continue end
        local lang = file.Read("metrostroi_data/languages/"..filename)
        parseLangFile(filename,lang)
    end
    --shitcode yay(repace missing phrase with english)
    for lang,langtbl in pairs(Metrostroi.Languages) do
        if lang == "en" then continue end
        for id,phrase in pairs(Metrostroi.Languages.en) do
            if not langtbl[id] then
                langtbl[id] = phrase
                debugmsg(Color(255,0,0),"Founded missing phrase ",Color(255,0,255),id,Color(255,0,0)," in ",lang," translation! Replaced with en.")
            end
        end
    end
    for lang,tbl in pairs(Metrostroi.Languages) do
        for id,str in pairs(tbl) do
            local pos = 1
            local iter = 1
            repeat
                local start_pos,end_pos = str:find("@%[[^]]+%]",pos)
                if not start_pos then break end

                local repstr = tbl[str:match("@%[([^]]+)%]")]
                if not repstr then
                    pos = end_pos+1
                    continue
                end
                str = str:sub(1,start_pos-1)..repstr..str:sub(end_pos+1,-1)
                iter = iter + 1
            until iter > 1000
            if iter > 1 then tbl[id] = str end
        end
    end

    Metrostroi.LoadLanguage(Metrostroi.ChoosedLang)
    if not Metrostroi.CurrentLanguageTable then
        Metrostroi.ChoosedLang = GetConVar("gmod_language"):GetString()
        if not Metrostroi.Languages[Metrostroi.ChoosedLang] then Metrostroi.ChoosedLang = "en" end
        RunConsoleCommand("metrostroi_language",Metrostroi.ChoosedLang)
    end
end
hook.Add("OnGamemodeLoaded","MetrostroiLanguageSystem",reloadLang)
concommand.Add("metrostroi_language_reload",reloadLang)
reloadLang()




concommand.Add("metrostroi_language_checktranslation", function(_, _, args)
    if not Metrostroi.CurrentLanguageTable then return end
    local str = "[langname]\nlang=Langname\n\n"

    for class, t in pairs(scripted_ents.GetList()) do
        local ENT = t.t
        if ENT.ButtonMap or ENT.Cameras or ENT.Spawner then
            str = str.."#"..class.."\n"
        end
        if ENT.ButtonMap then
            str = str.."#Buttons:\n"
            for panelname, panel in pairs(ENT.ButtonMap) do
                if panel.buttons then
                    for buttonname, button in pairs(panel.buttons) do
                        if button.tooltip then
                            if not button.ID and args[1] then
                                MsgC(Color(255, 0, 0), ENT.ClassName, " ", (button.tooltip or "nil"):Replace("\n", "\\n"):Replace("\t", "\\t"):Replace("\"", "\\\""), "\n")
                            elseif button.ID and not args[1] then
                                local id = Format("Entities.%s.Buttons.%s.%s", class, panelname, button.ID)
                                --elseif button.ID and args[1] == "all" then
                                --print(Format("\"Entities.%s.Buttons.%s.%s\": \"%s\",",class,panelname,button.ID,button.tooltip:Replace("\n","\\n"):Replace("\t","\\t"):Replace("\"","\\\"")))
                                if not Metrostroi.CurrentLanguageTable[id] then
                                    local name = Format("%s = %s\n", id,button.tooltip:JavascriptSafe())
                                    MsgC(Color(255, 0, 0), name)
                                    str = str .. name
                                end
                            end
                        end
                    end
                end
            end
        end

        --Format("Entities.%s.Buttons.%s.%s",class,panelname,button.ID)
        if ENT.Cameras then
            str = str.."#Cameras:\n"
            for i, cam in pairs(ENT.Cameras) do
                if not cam[3] or type(cam[3])~="string" then continue end
                local id = cam[3]:JavascriptSafe()

                if not Metrostroi.CurrentLanguageTable[id] then
                    MsgC(Color(255, 0, 0), Format("%s = %s\n", id, id))
                    str = str .. Format("%s = %s\n", id, id)
                end
            end
        end
    --end

    --for class, t in pairs(scripted_ents.GetList()) do
        --local ENT = t.t

        if ENT.Spawner then
            str = str.."#Spawner:\n"
            for i, tbl in ipairs(ENT.Spawner) do
                if not args[1] and not Metrostroi.CurrentLanguageTable[Format("Entities.%s.Spawner.%s.Name", class, tbl[1])] and tbl[2] then
                    local name = tbl[2]

                    if name:sub(1, 8) == "Spawner." then
                        name = Metrostroi.GetPhrase(name)
                    end

                    name = name:JavascriptSafe()
                    print(Format("Entities.%s.Spawner.%s.Name = %s", class, tbl[1], name))
                    str = str .. Format("Entities.%s.Spawner.%s.Name = %s\n", class, tbl[1], name)
                end

                if tbl[3] == "List" and type(tbl[4])=="table" then
                    for k, v in ipairs(tbl[4]) do
                        if type(v) == "string" and not args[1] and not Metrostroi.CurrentLanguageTable[Format("Entities.%s.Spawner.%s.%s", class, tbl[1], k)] then
                            if v:sub(1, 8) == "Spawner." then
                                v = Metrostroi.GetPhrase(v)
                            end
                            v = v:JavascriptSafe()
                            print(Format("Entities.%s.Spawner.%s.%s = %s", class, tbl[1], k, v))
                            str = str .. Format("Entities.%s.Spawner.%s.%s = %s\n", class, tbl[1], k, v)
                        end
                    end
                end
            end
        end
    end

    SetClipboardText(str)
end)

Metrostroi.LanguageCache = Metrostroi.LanguageCache or {}
timer.Simple(0,function()
    net.Start("metrostroi_language_sync")
    net.SendToServer()
end)
net.Receive("metrostroi_language_sync",function()
    print("------RECV------")
    local id = net.ReadUInt(32)
    local maxf = net.ReadUInt(8)
    local currf = net.ReadUInt(8)
    local count = net.ReadUInt(8)
    local num = net.ReadUInt(8)
    print("ID:"..id)
    print(Format("Num:%02d/%02d",currf,maxf))
    print(Format("count:%02d/%02d",num,count))

    Metrostroi.LanguageCache[id] = Metrostroi.LanguageCache[id] or {}
    Metrostroi.LanguageCache[id][currf] = Metrostroi.LanguageCache[id][currf] or {}
    local size = net.ReadUInt(32)
    Metrostroi.LanguageCache[id][currf][num] = net.ReadData(size)

    print(Format("Metrostroi.LanguageCache[%d][%d] %s",id,currf,Metrostroi.LanguageCache[id][currf]))
    print("Size:"..size)

    local done = true

    for cf=1,maxf do
        if not Metrostroi.LanguageCache[id][cf] then done = false break end
        local tdata = Metrostroi.LanguageCache[id][cf]
        local pd = true
        if tdata and type(tdata) == "table" and true then
            for cd=0,#tdata do
                if not tdata[cd] then pd = false break end
            end
            if pd then
                print("Done receiving text data")
                local data = ""
                for i=0,#tdata do
                    data = data.. tdata[i]
                end
                Metrostroi.LanguageCache[id][cf] = data
            end
        end
        if not pd then done = false break end
    end
    if done then
        print("Done receiving all lang data")
        local langdata = Metrostroi.LanguageCache[id]
        Metrostroi.LanguageCache[id] = nil
        Metrostroi.BuiltinLanguages = {}
        for k,v in pairs(langdata) do Metrostroi.BuiltinLanguages[k] = util.Decompress(v) end
        --data = util.Decompress(data)
        reloadLang()
    end

end)

local CATEGORY_NAME = "Metrostroi"

------------------------------ Wagons ------------------------------
local waittime = 10
local lasttimeusage = -waittime
function ulx.wagons( calling_ply )
    if lasttimeusage + waittime > CurTime() then
        ULib.tsayError( calling_ply, "Please wait " .. math.Round(lasttimeusage + waittime - CurTime()) .. " seconds before using this command again", true )
        return
    end

    lasttimeusage = CurTime()

    ulx.fancyLog("Wagons on server: #s", Metrostroi.TrainCount())
    if CPPI then
        local N = {}
        for k,v in pairs(Metrostroi.TrainClasses) do
            if  v == "gmod_subway_base" then continue end
            local ents = ents.FindByClass(v)
            for k2,v2 in pairs(ents) do
                N[v2:CPPIGetOwner() or v2:GetNetworkedEntity("Owner", "N/A") or "(disconnected)"] = (N[v2:CPPIGetOwner() or v2:GetNetworkedEntity("Owner", "N/A") or "(disconnected)"] or 0) + 1
            end
        end
        for k,v in pairs(N) do
            ulx.fancyLog("#s wagons have #s",v,(type(k) == "Player" and IsValid(k)) and k:GetName() or k)
        end
    end
    ulx.fancyLog("Max trains: #s.\nMax wagons: #s.\nMax trains per player: #s", GetConVarNumber("metrostroi_maxtrains"), GetConVarNumber("metrostroi_maxwagons"), GetConVarNumber("metrostroi_maxtrains_onplayer"))
end
local wagons = ulx.command( CATEGORY_NAME, "ulx trains", ulx.wagons, "!trains" )
wagons:defaultAccess( ULib.ACCESS_ALL )
wagons:help( "Shows you the current wagons." )

function ulx.routes( calling_ply )
    --if lasttimeusage + waittime > CurTime() then
        --ULib.tsayError( calling_ply, "Please wait " .. math.Round(lasttimeusage + waittime - CurTime()) .. " seconds before using this command again", true )
        --return
    --end

    --lasttimeusage = CurTime()

    --ulx.fancyLog("Wagons on server: #s", Metrostroi.TrainCount())
    if CPPI then
        --local N = {}
        for k,v in pairs(Metrostroi.TrainClasses) do
            if  v == "gmod_subway_base" then continue end
            local ents = ents.FindByClass(v)
            for k2,v2 in pairs(ents) do
                --N[v2:CPPIGetOwner() or v2:GetNetworkedEntity("Owner", "N/A") or "(disconnected)"] = (N[v2:CPPIGetOwner() or v2:GetNetworkedEntity("Owner", "N/A") or "(disconnected)"] or 0) + 1
                if v2.GetDriverName and v2.RouteNumber then ulx.fancyLog("#s have a route:#d",v2:GetDriverName(),v2.RouteNumber) else ulx.fancyLog("#s don't have a route",v2:GetDriverName()) end
            end
        end
    end
    --ulx.fancyLog("Max trains: #s.\nMax wagons: #s.\nMax trains per player: #s", GetConVarNumber("metrostroi_maxtrains"), GetConVarNumber("metrostroi_maxwagons"), GetConVarNumber("metrostroi_maxtrains_onplayer"))
end
local routes = ulx.command( CATEGORY_NAME, "ulx routes", ulx.routes, "!routes" )
routes:defaultAccess( ULib.ACCESS_ALL )
routes:help( "Shows you the current routes." )
--[[
------------------------------ Checkwags ------------------------------
function ulx.checkwags( calling_ply )
    ulx.fancyLog("Wagons on server: #s", Metrostroi.TrainCount())
    if CPPI then
        local N = {}
        for k,v in pairs(Metrostroi.TrainClasses) do
            if  v == "gmod_subway_81-717" or v == "gmod_subway_ezh3" then
            local ents = ents.FindByClass(v)
            for k2,v2 in pairs(ents) do

            end
        end
        for k,v in pairs(N) do
            ulx.fancyLog("#s wagons have #s",v,(type(k) == "Player" and IsValid(k)) and k:GetName() or k)
        end
    end
    ulx.fancyLog("Max trains: #s.\nMax wagons: #s.\nMax trains per player: #s", GetConVarNumber("metrostroi_maxtrains"), GetConVarNumber("metrostroi_maxwagons"), GetConVarNumber("metrostroi_maxtrains_onplayer"))
end
local wagons = ulx.command( CATEGORY_NAME, "ulx trains", ulx.wagons, "!trains" )
wagons:defaultAccess( ULib.ACCESS_ALL )
wagons:help( "Shows you the current wagons." )
]]
------------------------------ Trainfuck ------------------------------
local Models = {
    "models/metrostroi/81/81-7036.mdl",
    "models/metrostroi/81/81-7037.mdl",
    "models/z-o-m-b-i-e/metro_2033/train/m_33_metro_train_01_one_part.mdl",
    "models/z-o-m-b-i-e/metro_2033/train/m_33_train_crush_02.mdl",
}
local function SpawnTrain( Pos, Direction )
        local train = ents.Create( "prop_physics" )
        local random = math.random(1,#Models)
        train:SetModel(Models[random])
        train:SetAngles( Direction:Angle() + Angle(0,string.find(Models[random],"metrostroi") and 0 or 270,0) )
        train:SetPos( Pos )
        if math.random() > 0.6 then train:SetColor( Color(math.random(0,255),math.random(0,255),math.random(0,255)) ) end
        train:SetSkin(math.random(0,2))
        train:Spawn()
        train:Activate()
        train:EmitSound( "ambient/alarms/train_horn2.wav", 100, 100 )
        train:GetPhysicsObject():SetVelocity( Direction * math.random(1e7,1e9) )

        --timer.Create( "TrainRemove_"..CurTime(), 5, 1, function( train ) train:Remove() end, train )
        timer.Simple( 5, function() train:Remove() end )
end

function ulx.trainfuck(calling_ply, target_plys)
    local affected_plys = {}

    local gm = GetConVarNumber("sbox_godmode")
    if gm > 0 then RunConsoleCommand("sbox_godmode",0) end
    for i=1, #target_plys do
        local v = target_plys[ i ]

        if ulx.getExclusive( v, calling_ply ) then
            ULib.tsayError( calling_ply, ulx.getExclusive( v, calling_ply ), true )
        elseif not v:Alive() then
            ULib.tsayError( calling_ply, v:Nick() .. " is already dead!", true )
        elseif v:IsFrozen() then
            ULib.tsayError( calling_ply, v:Nick() .. " is frozen!", true )
        else
            v:SetMoveType( MOVETYPE_WALK )
            v:GodDisable()
            SpawnTrain( v:GetPos() + v:GetForward() * 1000 + Vector(0,0,120), v:GetForward() * -1 )
            table.insert( affected_plys, v )
        end
    end
    timer.Simple(1,function()
        RunConsoleCommand("sbox_godmode",gm)
    end)

    ulx.fancyLogAdmin( calling_ply, "#A trainfucked #T", affected_plys )
end
local traunfuck = ulx.command( "Fun", "ulx trainfuck", ulx.trainfuck, "!trainfuck", true )
traunfuck:addParam{ type=ULib.cmds.PlayersArg }
traunfuck:defaultAccess( ULib.ACCESS_ADMIN )
traunfuck:help( "Trainfucks a player." )


function ulx.tps( calling_ply,station )
        station = string.PatternSafe(station:lower())

        --Обработка сообщений вида станция:номер для станций, которые имеют несоклько позиций
        local add = 0
        if station:find("[^:]+:%d+$") then
            local st,en = station:find(":%d+$")
            add = tonumber(station:sub(st+1,en))
            station = station:sub(1,st-1)
        end

        --Проверка на наличие таблицы
        if not Metrostroi.StationConfigurations then ULib.tsayError( calling_ply, "This map is not configured", true ) return end

        --Создание массива найденых станций по индкесу станции или куска имени
        local st = {}
        for k,v in pairs(Metrostroi.StationConfigurations) do
            if not v.positions then continue end
            if v.names then
                for _,stat in pairs(v.names) do
                    if stat:lower():find(station) then
                        table.insert(st,k)
                        break
                    end
                end
            end
            if tostring(k):find(station) then
                table.insert(st,k)
            end
        end

        if #st == 0 then
            ULib.tsayError( calling_ply, Format("Station not found %s",station), true )
            return
        elseif #st > 1 then
            ULib.tsayError( calling_ply,  Format("More than 1 station for name %s:",station), true )
            for k,v in pairs(st) do
                local tbl = Metrostroi.StationConfigurations[v]
                if tbl.names and tbl.names[1] then
                    ULib.tsayError( calling_ply, Format("\t%s=%s",v,tbl.names[1]), true )
                else
                    ULib.tsayError( calling_ply, Format("\t%s",k), true )
                end
            end
            ULib.tsayError( calling_ply, "Enter a more specific name or station ID", true )
            return
        end
        local key = st[1]
        st = Metrostroi.StationConfigurations[key]
        local ptbl
        if add > 0 then
            local pos = st.positions
            ptbl = pos[math.min(#pos,add+1)]
        else
            ptbl = st.positions and st.positions[1]
        end
        if IsValid(calling_ply) then
            if ptbl and ptbl[1] then
                if calling_ply:InVehicle() then calling_ply:ExitVehicle() end
                calling_ply.ulx_prevpos = calling_ply:GetPos()--ulx return
                calling_ply.ulx_prevang = calling_ply:EyeAngles()
                calling_ply:SetPos(ptbl[1])
                calling_ply:SetAngles(ptbl[2])
                calling_ply:SetEyeAngles(ptbl[2])
                ulx.fancyLogAdmin( calling_ply, "#A teleported to #s", st.names and st.names[1] or key)
            else
                ULib.tsayError( calling_ply, "Configuration error for station "..key, true )
                ulx.fancyLogAdmin( calling_ply, "Configuration error for station #s", key)
            end

        else
            if ptbl and ptbl[1] then
                print(Format("DEBUG1:Teleported to %s(%s) pos:%s ang:%s",st.names and st.names[1] or key,key,ptbl[1],ptbl[2]))
            else
                ulx.fancyLogAdmin( calling_ply, "Configuration error for station #s", station:gsub("^%l", string.upper))
            end
        end
end
local tps = ulx.command( "Metrostroi", "ulx station", ulx.tps, "!station" )
tps:addParam{ type=ULib.cmds.StringArg, hint="Station or station number", ULib.cmds.takeRestOfLine }
tps:defaultAccess( ULib.ACCESS_ALL )
tps:help( "Teleport between stations." )

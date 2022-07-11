local CATEGORY_NAME = "Metrostroi"
if SERVER then util.AddNetworkString("metrostroi_stations_gui") end

------------------------------ Wagons ------------------------------
local waittime = 10
local lasttimeusage = -waittime
function ulx.wagoncount( calling_ply )
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
    ulx.fancyLog("Max trains: #s.\nMax wagons: #s.\nMax trains per player: #s", GetConVar("metrostroi_maxtrains"):GetInt(), GetConVar("metrostroi_maxwagons"):GetInt(), GetConVar("metrostroi_maxtrains_onplayer"):GetInt())
end
local wagons = ulx.command( CATEGORY_NAME, "ulx trains", ulx.wagoncount, "!trains" )
wagons:defaultAccess( ULib.ACCESS_ALL )
wagons:help( "Shows you the current wagons count per player." )

function ulx.routes( calling_ply )
    --if lasttimeusage + waittime > CurTime() then
        --ULib.tsayError( calling_ply, "Please wait " .. math.Round(lasttimeusage + waittime - CurTime()) .. " seconds before using this command again", true )
        --return
    --end

    --lasttimeusage = CurTime()
    local wagTable = {}
    local trains = {}
    --ulx.fancyLog("Wagons on server: #s", Metrostroi.TrainCount())
    if CPPI then
        --local N = {}
        for k,v in pairs(Metrostroi.TrainClasses) do
            if  v == "gmod_subway_base" then continue end
            local ents = ents.FindByClass(v)
            for k2,ent in pairs(ents) do
                if ent.NoTrain or trains[ent] or (ent.FrontTrain and ent.RearTrain) then continue end
                if ent.WagonList then
                    local id = table.insert(wagTable,{})
                    for i,tr in ipairs(ent.WagonList) do
                        trains[tr] = id
                        table.insert(wagTable[id],tr)
                    end
                end
            end
        end
        for i,trains in ipairs(wagTable) do
            local owner = trains[1]:GetDriverName()
            local routelist = ""
            for  it,train in pairs(trains) do
                if (train.FrontTrain and train.RearTrain) then continue end
                local num = train.RouteNumber and train.RouteNumber.RouteNumber
                if num and tonumber(num) > 0 then
                    if routelist ~= "" then routelist = routelist.."," end
                    routelist = routelist..num:sub(1,train.RouteNumber.Max or -1)
                end
            end
            if routelist ~= ""  then
                ulx.fancyLog("#s route number #s",owner,routelist)
            else
                ulx.fancyLog("#s route number not set",owner)
            end
        end
        --[[
                --N[v2:CPPIGetOwner() or v2:GetNetworkedEntity("Owner", "N/A") or "(disconnected)"] = (N[v2:CPPIGetOwner() or v2:GetNetworkedEntity("Owner", "N/A") or "(disconnected)"] or 0) + 1
                if v2.GetDriverName then
                    ulx.fancyLog("#s have a route:#d",v2:GetDriverName(),v2.RouteNumber
                else
                    ulx.fancyLog("#s don't have a route",v2:GetDriverName())
                end
            end
        end]]
    end
    --ulx.fancyLog("Max trains: #s.\nMax wagons: #s.\nMax trains per player: #s", GetConVarNumber("metrostroi_maxtrains"), GetConVarNumber("metrostroi_maxwagons"), GetConVarNumber("metrostroi_maxtrains_onplayer"))
end
local routes = ulx.command( CATEGORY_NAME, "ulx routes", ulx.routes, "!routes" )
routes:defaultAccess( ULib.ACCESS_ALL )
routes:help( "Shows you the current routes." )

function ulx.trains( calling_ply, ToP )
    --if lasttimeusage + waittime > CurTime() then
        --ULib.tsayError( calling_ply, "Please wait " .. math.Round(lasttimeusage + waittime - CurTime()) .. " seconds before using this command again", true )
        --return
    --end

    --lasttimeusage = CurTime()

    local wagTable = {}
    local trains = {}
    local found = false
    for k,v in pairs(Metrostroi.TrainClasses) do
        if  v == "gmod_subway_base" then continue end
        local ents = ents.FindByClass(v)
        for k2,ent in pairs(ents) do
            if ent.NoTrain or trains[ent] or (ent.FrontTrain and ent.RearTrain) or not ent.WagonList then continue end

            local owner = CPPI and ent:CPPIGetOwner() or ent:GetOwner()
            local canShow = not ToP or ToP == "" or IsValid(owner) and owner:GetName():find(ToP)

            if not canShow and not tonumber(ToP) then continue end

            local consist = ""
            local routelist = ""
            local drivers = ""
            local signal
            for i,tr in ipairs(ent.WagonList) do
                if ToP then canShow = canShow or tr:GetWagonNumber() == tonumber(ToP) end

                if consist ~= "" then consist = consist.."-" end
                consist = consist..string.format("%04d",tr:GetWagonNumber())

                local num = tr.RouteNumber and tr.RouteNumber.RouteNumber
                if num then
                    if routelist ~= "" then routelist = routelist.."," end
                    routelist = routelist..num:sub(1,tr.RouteNumber.Max or -1)
                end

                local ALSCoil = tr.ALSCoil
                if ALSCoil and ALSCoil.Enabled > 0 and IsValid(ALSCoil.Signal) and (IsValid(ent:GetDriver()) or not signal) then
                    signal = ALSCoil.Signal
                end
                if IsValid(tr.DriverSeat) and IsValid(tr.DriverSeat:GetDriver()) then
                    if drivers ~= "" then drivers = drivers.."," end
                    drivers = drivers..string.format("%s in %04d driver",tr.DriverSeat:GetDriver():GetName(),tr:GetWagonNumber())
                end
                trains[tr] = true
            end

            if not canShow then continue end
            --[[ulx.fancyLog("Consist #s:\n\tOwner #s\n\tType #s\n\tRoute number:#s\n\tSignal:#s",
                consist,
                owner and owner:GetName() or "N/A",
                ent:GetClass():gsub("gmod_subway_",""),
                routelist=="" and "N/A" or routelist,
                signal and string.format("%s %s",signal.Name,(signal.Red or signal:GetARS(0,true)) and "(prohibited)" or "") or "N/A"
            )]]
            ulx.fancyLog("Consist #s:",consist)
            if IsValid(owner) then   ulx.fancyLog("\tOwner #s",owner:GetName()) end
            ulx.fancyLog("\tType #s",ent:GetClass():gsub("gmod_subway_",""))
            if routelist~="" then ulx.fancyLog("\tRoute number: #s",routelist) end
            if signal then ulx.fancyLog("\tSignal: #s",string.format("%s %s",signal.Name,(signal.Red or signal:GetARS(0,true)) and "(prohibited)" or "")) end
            if drivers ~= "" then ulx.fancyLog("\tDrivers: #s",drivers) end
            found = true
        end
    end
    if not found then ULib.tsayError( calling_ply, "Train not found",true) end
end
local trains = ulx.command( CATEGORY_NAME, "ulx traininfo", ulx.trains, "!tinfo" )
trains:defaultAccess( ULib.ACCESS_ALL )
trains:addParam{ type=ULib.cmds.StringArg, hint="Filter by player or wagon number", ULib.cmds.takeRestOfLine, invisible=true }
trains:help( "Shows you the detailed info about all consits" )


function ulx.traingoto( calling_ply, ToP)
    if not IsValid(calling_ply) then return end
    --if lasttimeusage + waittime > CurTime() then
        --ULib.tsayError( calling_ply, "Please wait " .. math.Round(lasttimeusage + waittime - CurTime()) .. " seconds before using this command again", true )
        --return
    --end

    --lasttimeusage = CurTime()
    local train = not ToP and IsValid(calling_ply.lastTrain) and calling_ply.lastTrain

    for k,v in pairs(Metrostroi.TrainClasses) do
        if  v == "gmod_subway_base" then continue end
        local ents = ents.FindByClass(v)
        for k2,ent in pairs(ents) do
            if ent.NoTrain then continue end

            local owner = CPPI and ent:CPPIGetOwner() or ent:GetOwner()
            local driver = ent:GetDriver()
            if not ToS and owner == calling_ply and not (ent.FrontTrain and ent.RearTrain) then train = ent break end
            if ToS and driver and driver:GetName():find(ToS) and not ulx.getExclusive(driver,calling_ply) then train = ent break end

            for i,tr in ipairs(ent.WagonList) do
                if ToP and tr:GetWagonNumber() == tonumber(ToP) then
                    train = tr
                    break
                end
            end

            if train then break end
        end
        if train then break end
    end
    if train then
        if calling_ply:InVehicle() then calling_ply:ExitVehicle() end
        calling_ply:SetMoveType(MOVETYPE_NOCLIP)

        if IsValid(train.DriverSeat) then
            calling_ply:SetPos(train.DriverSeat:LocalToWorld(Vector(-10,0,0)))
            calling_ply:SetEyeAngles(train:LocalToWorldAngles(-train.DriverSeat:GetAngles()))
            calling_ply:SetLocalVelocity( Vector( 0, 0, 0 ) ) -- Stop!
        else
            calling_ply:SetPos(train:LocalToWorld(Vector(0,0,20)))
            calling_ply:SetEyeAngles(train:GetAngles())
            calling_ply:SetLocalVelocity( Vector( 0, 0, 0 ) ) -- Stop!
        end

        ulx.fancyLogAdmin( calling_ply, "#A teleported to #s", train )
    else
        ULib.tsayError( calling_ply, "Train not found",true)
    end
end
local traingoto = ulx.command( CATEGORY_NAME, "ulx traingoto", ulx.traingoto, "!tgoto" )
traingoto:defaultAccess( ULib.ACCESS_ALL )
traingoto:addParam{ type=ULib.cmds.StringArg, hint="Filter by player or wagon number", ULib.cmds.takeRestOfLine, invisible=true }
traingoto:help( "Teleport you to trains" )

function ulx.trainback( calling_ply )
    if not IsValid(calling_ply) then return end
    if not IsValid(calling_ply.lastTrain) then
        ULib.tsayError( calling_ply, "Train not found",true)
        return
    end
    if calling_ply:InVehicle() then
        ULib.tsayError( calling_ply, "Leave vehicle first!",true)
        return
    end
    --if lasttimeusage + waittime > CurTime() then
        --ULib.tsayError( calling_ply, "Please wait " .. math.Round(lasttimeusage + waittime - CurTime()) .. " seconds before using this command again", true )
        --return
    --end

    --lasttimeusage = CurTime()
    local train = calling_ply.lastTrain

    local seat = IsValid(calling_ply.lastTrainSeat) and not IsValid(calling_ply.lastTrainSeat:GetDriver()) and calling_ply.lastTrainSeat

    if not seat and IsValid(train.DriverSeat) and not IsValid(train.DriverSeat:GetDriver()) then
        seat = train.DriverSeat
    end

    if not seat and IsValid(train.InstructorsSeat) and not IsValid(train.InstructorsSeat:GetDriver()) then
        seat = train.InstructorsSeat
    end
    if not seat then
        for i=1,5 do
            if IsValid(train["InstructorsSeat"..i]) and not IsValid(train["InstructorsSeat"..i]:GetDriver()) then
                seat = train["InstructorsSeat"..i]
                break
            end
            if IsValid(train["ExtraSeat"..i]) and not IsValid(train["ExtraSeat"..i]:GetDriver()) then
                seat = train["ExtraSeat"..i]
                break
            end
        end
    end
    if seat then
        --if calling_ply:InVehicle() then calling_ply:ExitVehicle() end
        calling_ply:SetPos(seat:LocalToWorld(Vector(0,0,20)))
        calling_ply:SetEyeAngles(train:LocalToWorldAngles(-seat:GetAngles()))
        calling_ply:EnterVehicle(seat)
    else
        ULib.tsayError( calling_ply, "Train not found",true)
    end
end
local trainback = ulx.command( CATEGORY_NAME, "ulx trainback", ulx.trainback, "!tback" )
trainback:defaultAccess( ULib.ACCESS_ALL )
trainback:help( "Teleport you back to your train" )


local function takeSeat(Player, OtherSeat)
    if not IsValid(OtherSeat) or IsValid(OtherSeat:GetDriver()) or not IsValid(OtherSeat:GetParent()) then
        return false
    end

    local Seat = Player:GetVehicle()
    Seat:SetVehicleEntryAnim(false)
    OtherSeat:SetVehicleEntryAnim(false)

    local OldMoveType = Player:GetMoveType( MOVETYPE_WALK )
    Player:ExitVehicle()
    Player:SetMoveType( MOVETYPE_NOCLIP )
    Player:SetPos(OtherSeat:LocalToWorld(Vector(0,0,20)))
    Player:SetEyeAngles(OtherSeat:GetParent():LocalToWorldAngles(-OtherSeat:GetAngles()))

    local timerName = "change_cab_"..OtherSeat:EntIndex()

    timer.Create(timerName, 0, 0, function()
        if not IsValid(Player) or not IsValid(OtherSeat) or IsValid(Player:GetVehicle()) then
            timer.Remove(timerName)

            Player:SetMoveType(OldMoveType)
            Seat:SetVehicleEntryAnim(false)
            OtherSeat:SetVehicleEntryAnim(false)
            return
        end

        Player:EnterVehicle(OtherSeat)

        if not IsValid(Player:GetVehicle()) then return end

        timer.Remove(timerName)

        --Player:SetPos(OtherSeat:LocalToWorld(Vector(0,0,20)))
        Player:SetEyeAngles(OtherSeat:GetParent():LocalToWorldAngles(-OtherSeat:GetAngles()))

        Seat:SetVehicleEntryAnim(false)
        OtherSeat:SetVehicleEntryAnim(false)
    end)

    return true
end

function ulx.changecab( calling_ply )
    if not IsValid(calling_ply) then return end
    local Wagon = calling_ply:GetTrain()
    if not IsValid(Wagon) then
        ULib.tsayError( calling_ply, "You must sit in train",true)
        return
    end

    local TargetWagon
    for i, wag in ipairs(Wagon.WagonList) do
        if not IsValid(wag) or Wagon == wag or (wag.FrontTrain and wag.RearTrain) then continue end
        TargetWagon = wag
        break
    end

    if not TargetWagon then
        ULib.tsayError( calling_ply, "Can't find back wagon in train!",true)
        return
    end

    local Seat = calling_ply:GetVehicle();

    if Seat == Wagon.DriverSeat then
        if not takeSeat(calling_ply, TargetWagon.DriverSeat) then
            ULib.tsayError( calling_ply, "Driver seat are occupied!",true)
        end
        return
    end

    if takeSeat(calling_ply, TargetWagon.InstructorsSeat) then return end
    for i=1,5 do
        if takeSeat(calling_ply, TargetWagon["InstructorsSeat"..i]) then return end
    end
    for i=1,5 do
        if takeSeat(calling_ply, TargetWagon["ExtraSeat"..i]) then return end
    end

    ULib.tsayError( calling_ply, "Cannot find propper seat...",true)
end
local changecab = ulx.command( CATEGORY_NAME, "ulx changecab", ulx.changecab, "!ccab" )
changecab:defaultAccess( ULib.ACCESS_ALL )

changecab:help( "Change cab" )
------------------------------ Trainfuck ------------------------------
local Models = {
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

    local gm = GetConVar("sbox_godmode"):GetInt()
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

function ulx.tps(calling_ply,station)
    station = string.PatternSafe(station:lower())
    
    -- Check stations table
    if not Metrostroi.StationConfigurations then ULib.tsayError(calling_ply,"This map is not configured",true) return end
    if not IsValid(calling_ply) then return end
    
    -- Open GUI with station list
    if station == "" then
        net.Start("metrostroi_stations_gui")
        net.Send(calling_ply)
        return
    end
    
    -- For input station like [Station name]:[Position]
    local posID
    if station:find("[^:]+:%w+$")then
        local st,en = station:find(":%w+$")
        posID = tostring(station:sub(st+1,en))
        station = station:sub(1,st-1)
    end
    
    -- Search input pattern
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
    
    -- Output same stations
    if #st == 0 then
        ULib.tsayError( calling_ply, Format("Station not found %s",station), true )
        return
    elseif #st > 1 then
        ULib.tsayError( calling_ply,  Format("More than 1 station for name %s:",station), true )
        for k,v in pairs(st) do
            local tbl = Metrostroi.StationConfigurations[v]
            if tbl.names and tbl.names[1] then
                ULib.tsayError( calling_ply, Format("\t%s = %s",v,tbl.names[1]), true )
            else
                ULib.tsayError( calling_ply, Format("\t%s",k), true )
            end
        end
        ULib.tsayError( calling_ply, "Enter a more specific name or station ID", true )
        return
    end
    
    -- Set target position
    local ID = st[1] 
    st = Metrostroi.StationConfigurations[ID]
    local ptbl
    if posID then
        for k,v in pairs(st.positions) do
            if tostring(k):find(posID) then
                ptbl = v
            end
        end
    else
        ptbl = st.positions and st.positions[1]
    end
    
    -- Teleport
    if ptbl and ptbl[1] then
        if calling_ply:InVehicle() then calling_ply:ExitVehicle() end
        calling_ply.ulx_prevpos = calling_ply:GetPos()
        calling_ply.ulx_prevang = calling_ply:EyeAngles()
        calling_ply:SetPos(ptbl[1])
        calling_ply:SetAngles(ptbl[2])
        calling_ply:SetEyeAngles(ptbl[2])
        ulx.fancyLogAdmin( calling_ply, "#A teleported to #s", st.names and st.names[1] or ID)
    else
        ULib.tsayError( calling_ply, "Configuration error for station "..ID, true )
        ulx.fancyLogAdmin( calling_ply, "Configuration error for station #s", ID)
    end
end

local tps = ulx.command( "Metrostroi", "ulx station", ulx.tps, {"!station","!stations"} )
tps:addParam{ type=ULib.cmds.StringArg, hint="Station or station number", ULib.cmds.optional }
tps:defaultAccess( ULib.ACCESS_ALL )
tps:help( "Teleport between stations." )


function ulx.sroutes( calling_ply, sig )
    if not IsValid(calling_ply) then return end
    local Train = calling_ply:GetTrain()
    if IsValid(Train) and (not sig or sig == "") then       
        local signal
        -- Get train position
        local pos = Metrostroi.TrainPositions[Train]
        if pos then pos = pos[1] end
        -- Get previous ARS section
        if pos then
            signal = Metrostroi.GetARSJoint(pos.node1,pos.x,Metrostroi.TrainDirections[Train], Train)
        end 
        if signal then
            local found = false
            for k,v in pairs(signal.Routes or {}) do
                if v.RouteName != "" then
                    found = true
                    break
                end
            end        
            if not found then
                ULib.tsayError( calling_ply, "Signal routes not found", true)
                return            
            end
            ulx.fancyLog("Routes of signal #s:", signal.Name)
            for k,v in pairs(signal.Routes) do
                if v.RouteName != "" then
                    ulx.fancyLog("#s", v.RouteName)
                end
            end    
        else
            ULib.tsayError( calling_ply, "Signal not found", true)
        end
    else
        local signal = Metrostroi.GetSignalByName(sig)
        if not signal and sig then
            signal = Metrostroi.GetSignalByName(sig:upper())
        end
        if not signal then
            ULib.tsayError( calling_ply, "Signal not found", true)
            return
        end

        local found = false
        for k,v in pairs(signal.Routes or {}) do
            if v.RouteName != "" then
                found = true
                break
            end
        end        
        if not found then
            ULib.tsayError( calling_ply, "Signal routes not found", true)
            return            
        end
        ulx.fancyLog("Routes of signal #s:", signal.Name)
        for k,v in pairs(signal.Routes) do
            if v.RouteName != "" then
                ulx.fancyLog("#s", v.RouteName)
            end
        end
    end
end
local sroutes = ulx.command( CATEGORY_NAME, "ulx sroutes", ulx.sroutes, "!sroutes" )
sroutes:addParam{ type=ULib.cmds.StringArg, hint="Signal", ULib.cmds.optional }
sroutes:defaultAccess( ULib.ACCESS_ALL )
sroutes:help( "Print routes of next signal" )


--Костылииии
function ulx.sopen( calling_ply, arg )
    MSignalSayHook(calling_ply,"!sopen "..arg, true)
end
local sopen = ulx.command( CATEGORY_NAME, "ulx sopen", ulx.sopen, "!sopen" )
sopen:addParam{ type=ULib.cmds.StringArg, hint="Signal or route name", ULib.cmds.takeRestOfLine }
sopen:defaultAccess( ULib.ACCESS_ALL )
sopen:help( "Open signal or route" )

function ulx.sclose( calling_ply, arg )
    MSignalSayHook(calling_ply,"!sclose "..arg, true)
end
local sclose = ulx.command( CATEGORY_NAME, "ulx sclose", ulx.sclose, "!sclose" )
sclose:addParam{ type=ULib.cmds.StringArg, hint="Signal or route name", ULib.cmds.takeRestOfLine }
sclose:defaultAccess( ULib.ACCESS_ALL )
sclose:help( "Close signal or route" )

function ulx.sactiv( calling_ply, arg )
    MSignalSayHook(calling_ply,"!sactiv "..arg, true)
end
local sactiv = ulx.command( CATEGORY_NAME, "ulx sactiv", ulx.sactiv, "!sactiv" )
sactiv:addParam{ type=ULib.cmds.StringArg, hint="Signal or route name", ULib.cmds.takeRestOfLine }
sactiv:defaultAccess( ULib.ACCESS_ALL )
sactiv:help( "Enable auxulary signals" )

function ulx.sdeactiv( calling_ply, arg )
    MSignalSayHook(calling_ply,"!sdeactiv "..arg, true)
end
local sdeactiv = ulx.command( CATEGORY_NAME, "ulx sdeactiv", ulx.sdeactiv, "!sdeactiv" )
sdeactiv:addParam{ type=ULib.cmds.StringArg, hint="Signal or route name", ULib.cmds.takeRestOfLine }
sdeactiv:defaultAccess( ULib.ACCESS_ALL )
sdeactiv:help( "Disable auxulary signals" )

function ulx.sopps( calling_ply, arg )
    MSignalSayHook(calling_ply,"!sopps "..arg, true)
end
local sopps = ulx.command( CATEGORY_NAME, "ulx sopps", ulx.sopps, "!sopps" )
sopps:addParam{ type=ULib.cmds.StringArg, hint="Signal or route name", ULib.cmds.takeRestOfLine }
sopps:defaultAccess( ULib.ACCESS_ALL )
sopps:help( "Open invitation signal" )

function ulx.sclps( calling_ply, arg )
    MSignalSayHook(calling_ply,"!sclps "..arg, true)
end
local sclps = ulx.command( CATEGORY_NAME, "ulx sclps", ulx.sclps, "!sclps" )
sclps:addParam{ type=ULib.cmds.StringArg, hint="Signal or route name", ULib.cmds.takeRestOfLine }
sclps:defaultAccess( ULib.ACCESS_ALL )
sclps:help( "Close invitation signal" )

function ulx.senao( calling_ply, arg )
    MSignalSayHook(calling_ply,"!senao "..arg, true)
end
local senao = ulx.command( CATEGORY_NAME, "ulx senao", ulx.senao, "!senao" )
senao:addParam{ type=ULib.cmds.StringArg, hint="Signal", ULib.cmds.takeRestOfLine }
senao:defaultAccess( ULib.ACCESS_ALL )
senao:help( "Enable absolute stop signal" )

function ulx.sdisao( calling_ply, arg )
    MSignalSayHook(calling_ply,"!sdisao "..arg, true)
end
local sdisao = ulx.command( CATEGORY_NAME, "ulx sdisao", ulx.sdisao, "!sdisao" )
sdisao:addParam{ type=ULib.cmds.StringArg, hint="Signal", ULib.cmds.takeRestOfLine }
sdisao:defaultAccess( ULib.ACCESS_ALL )
sdisao:help( "Disable absolute stop signal" )
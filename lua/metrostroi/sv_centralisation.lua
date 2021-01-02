
local function GetOccupation(tbl)
    if not tbl then return end
    for sID,signame in ipairs(tbl) do
        if signame[1] == "@" then
            local trigger = Metrostroi.ARMGet(signame:sub(2,-1), "trigger")
            --if not trigger then print(signame) end
            if not trigger or trigger.ARMTriggered then
                return true
            end
        elseif signame ~= "" then
            local signal = Metrostroi.ARMGet(signame, "signal")
            if not signal or signal.OccupiedBy and signal.OccupiedBy ~= signal then
                return true
            end
        end
    end
    return false
end

function Metrostroi.CentralisationPrepareRoute(station,route)
    if not Metrostroi.ARMTable[station].routes then Metrostroi.ARMTable[station].routes = {} end
    local Routes = Metrostroi.ARMTable[station].routes
    local stationT = Metrostroi.ARMConfigGenerated[station]
    if not Routes[route] then
        local segments = route.route
        for i,segm in pairs(segments) do
            if segm.inroute then
                RunConsoleCommand("say",Format("Station %d. Error building route %s, because there is already another route",station,route))
                return false
            end
            if route.ignores and (not route.ignores or not route.ignores[i]) and segm.occupied then
                RunConsoleCommand("say",Format("Station %d. Error building route %s. Route occupied!",station,route))
                return false
            end
        end
        if route.checks then
            for i,segm in pairs(route.checks) do
                if segm.inroute then
                    RunConsoleCommand("say",Format("Station %d. Error building route %s, because there is already another route on protective segments",station,route))
                    return false
                end
                if route.ignores and (not route.ignores or not route.ignores[i]) and segm.occupied then
                    RunConsoleCommand("say",Format("Station %d. Error building route %s. Protective segments occupied!",station,route))
                    return false
                end
            end
        end

        for _,segm in pairs(segments) do
            segm.inroute = true
        end
        Routes[route] = table.insert(Routes,route)
        RunConsoleCommand("say",Format("Station %d. Added route %s with ID:%d",station,route,Routes[route]))
        return true
    end
end
local function CentralistationCalculateFreeBS(segm,dir,sigconf,pSeg,rccount)
    if pSeg then
        local signal = dir and segm.signal2 or not dir and segm.signal1
        if signal then
            local ent = signal.ent
            if not ent then return 1 end
            local conf = sigconf[ent.Name]
            --return (ent.FreeBSARM or ent.FreeBS or 0)+(conf and conf.bs or 1),ent
            return (ent.FreeBSARM or ent.FreeBS or 0)+rccount,ent
        end
    end
    rccount = (rccount or 0) + 1
    if not segm or segm.occupied then
        return rccount
    end
    local alt,main = false,true
    if segm.switch then
        local switch = Metrostroi.ARMGet(segm.switch, "switch")
        main = switch and switch.MainTrack and not switch.AlternateTrack
        alt = switch and not switch.MainTrack and switch.AlternateTrack
        if not alt and not main then return 0 end
    end

    if pSeg and segm.next_a and (segm.next_a == pSeg and not alt or segm.next_m == pSeg and not main) then return 0 end
    local segmM,segmA = segm.next_m,segm.next_a
    local segmP = segm.prev


    local mainM = segmM and (dir and segmM.x > segm.x or not dir and segmM.x < segm.x)
    local mainP = segmP and (dir and segmP.x > segm.x or not dir and segmP.x < segm.x)
    if mainM then
        local next
        if alt  and segmA then next = segmA end
        if main and segmM then next = segmM end
        return CentralistationCalculateFreeBS(next,dir,sigconf,segm,rccount)
    end
    if segmP and mainP then
        return CentralistationCalculateFreeBS(segmP,dir,sigconf,segm,rccount)
    end
end
local function CentralisationSolveSignalLogic(signal,signalE,signalDir,station,segm)
    if not signalE then return end
    if station.signals and station.signals[signal] then
        local sigconf = station.signals[signal]
        signalE.ControllerLogic = station
        local target,codes = "",""
        local alt = false
        local occupied = segm.occupied
        if segm.switch then
            local switch = Metrostroi.ARMGet(segm.switch, "switch")
            local main = switch and switch.MainTrack and not switch.AlternateTrack
            alt = switch and not switch.MainTrack and switch.AlternateTrack
            if not alt and not main then occupied = true end
        end
        if alt then
            --occupied = occupied or segm.next_a and GetOccupation(segm.next_a)
        else
            --occupied = occupied or segm.next_m and GetOccupation(segm.next_m)
        end

        local route = sigconf.route
        local free,nextSignal = CentralistationCalculateFreeBS(segm,signalDir,station.signals)
        --print(free,signalE,signalE.Name)
        local dir = route and route.dir
        if route and dir ~= signalDir then
            print(signalE.Name,dir ,signalDir)
            route = nil
            occupied = true
        end
        if sigconf.Mode == 1 then
            if occupied then
                target = sigconf.R
                codes = "2"
            elseif route then
                if nextSignal then
                    local colors = nextSignal.Colors or ""
                    local segments = route[2]
                    --print(route)
                    local start = false
                    local specialS = sigconf.routes and sigconf.routes[route[1].name]
                    if free < (sigconf.bs or 1) then
                        target = sigconf.RY or sigconf.R
                    elseif route.mode == 3 then
                        target =  sigconf.W
                    elseif colors:find("[rR]+") and colors:find("[yY]+") then
                        target = sigconf.Y or sigconf.YG or sigconf.RY or sigconf.R
                    elseif colors:find("[rR]+") then
                        target = sigconf.Y or sigconf.RY or sigconf.R
                    elseif colors:find("[ygYG]+[ygYG]+") or colors:find("[gwGW]+") then
                        target = sigconf.G or sigconf.YG or sigconf.Y or sigconf.RY or sigconf.R
                    elseif colors:find("[yY]+") then
                        target = sigconf.YG or sigconf.G or sigconf.Y or sigconf.RY or sigconf.R
                    else
                        target = sigconf.R
                    end
                elseif route.mode == 3 then
                    target =  sigconf.W
                else
                    target = sigconf.R
                end
            else
                if free and free < 1 then
                    target = sigconf.R or sigconf.RY or ""
                else
                    target = sigconf.RY or sigconf.R
                end
                codes = "0"
            end
            signalE.Red = target==sigconf.R or target==sigconf.RY
            signalE.AutoEnabled = signalE.AutoEnabled
        else

        end
        local sig = ""
        for i=1,#target do
            local id = tonumber(target[i])
            if not id then continue end
            if #sig < id then sig = sig..string.rep("0",id-#sig) end
            sig = string.SetChar(sig,tonumber(target[i]),target[i+1]=="b" and "2" or "1")
        end
        signalE.Sig = sig
        signalE.FreeBSARM = occupied and 0 or free
        signalE.FreeBS = math.ceil(signalE.FreeBSARM or 0)
        --print(occupied,free,signalE.FreeBS)
        --print(signalE.Colors,target,signalE.Sig)
    end
end
local function CentralisationSolveRoutesLogic(stationID,station)
    local Routes = Metrostroi.ARMTable[stationID].routes
    local HasPrepared = true
    for k,route in ipairs(Routes) do
        local segments = route.route
        local directions = route.directions
        if route.prepared then
            --HasPrepared = true
            local done,occupiedN,halfroute = true--,100
            for segmID,segm in ipairs(segments) do
                if segm.occupied then
                    if not occupiedN or occupiedN < segmID then occupiedN = segmID end
                end
                if segm.route then done = false end
                if not segm.route then halfroute = true end
            end
            if occupiedN then
                for segmID,segm in ipairs(segments) do
                    if segmID > occupiedN then break end
                    if segm.route == route then
                        segm.route = false
                        segm.inroute = false
                        local signal = route[3] and segm.signal2 or not route[3] and segm.signal1
                        local sig = Metrostroi.ARMGet(signal and signal.name, "signal")
                    end
                end
            end
            if done or halfroute and not occupiedN then
                for _,segm in ipairs(segments) do
                    segm.inroute = false
                    segm.route = false
                end
                for i,signame in pairs(route.signals) do
                    if not station.signals[signame] then continue end
                    station.signals[signame].route = nil
                end
                RunConsoleCommand("say",Format("Station %d. Route %s(%d) has destroyed",stationID,route,Routes[route]))
                table.remove(Routes,Routes[route])
                Routes[route] = nil
                for i,v in pairs(Routes) do Routes[v] = i end
                route.prepared = false
            end
        else
            local Prepared = true
            --Check for occupation
            for i,segm in ipairs(segments) do
                if route.ignores and not route.ignores[i] and segm.occupied then Prepared = false break end
                if segm.route then Prepared = false break end
            end
            --If there is no occupation - check and prepare switches
            if Prepared then
                for segmID,segm in ipairs(segments) do
                    if not segm.switch then continue end
                    local switch = Metrostroi.ARMGet(segm.switch, "switch")
                    if not switch then continue end
                    local dir = directions[segmID]

                    local main = switch and switch.MainTrack and not switch.AlternateTrack
                    local alt = switch and not switch.MainTrack and switch.AlternateTrack
                    --print(route[3],switch,dir)
                    if dir and main or not dir and alt or (not main and not alt) then
                        switch:SwitchTo(dir and "alt" or "main")
                        Prepared = false
                        print("Move",segmID,segm.switch,switch,dir and "alt" or "main")
                    end
                    if not main and not alt then Prepared = false end
                end
            end
            if Prepared then
                for k,segm in ipairs(segments) do
                    segm.route = route
                    local signal = route[3] and segm.signal2 or not route[3] and segm.signal1
                    local sig = Metrostroi.ARMGet(signal and signal.name, "signal")
                end
                for i,signame in pairs(route.signals) do
                    if not station.signals[signame] then continue end
                    station.signals[signame].route = route
                end
                route.prepared = true
                RunConsoleCommand("say",Format("Station %d. Route %s(%d) has assembled",stationID,route,Routes[route]))
            end
        end
    end
    return HasPrepared
end

function Metrostroi.Centralisation()
    if not Metrostroi.ARMConfigGenerated then return end
    for stationID,station in pairs(Metrostroi.ARMConfigGenerated) do
        --Route logic
       local HasPrepared = CentralisationSolveRoutesLogic(stationID,station)

        for name, signal in pairs(station.signals) do
            if signal.sig then
                local ent = Metrostroi.ARMGet(name, "signal")
                signal.sig.ent = ent
                CentralisationSolveSignalLogic(name,ent,signal.sig.dir,station,signal.segm)
            end
        end
        for segmID, segm in ipairs(station) do
            segm.occupied = segm._occup or GetOccupation(segm.occup) or GetOccupation(segm.occupAlt)
            if true then
                if segm.switch then
                    local switch = Metrostroi.ARMGet(segm.switch, "switch")
                    local main = switch and switch.MainTrack and not switch.AlternateTrack
                    local alt = switch and not switch.MainTrack and switch.AlternateTrack
                    if switch and not segm.route and not segm.inroute and not segm.occupied and (alt or not main and not alt) then
                        switch:SwitchTo("main")
                        print("Reset",segm.switch,switch,segmID,segm.route)
                    end
                end
                --[[ if segm.signal1 then
                    local ent = Metrostroi.ARMGet(segm.signal1.name, "signal")
                    segm.signal1.ent = ent
                    CentralisationSolveSignalLogic(segm.signal1.name,ent,false,station,segm)
                end
                if segm.signal2 then
                    local ent = Metrostroi.ARMGet(segm.signal2.name, "signal")
                    segm.signal2.ent = ent
                    CentralisationSolveSignalLogic(segm.signal2.name,ent,true,station,segm)
                end--]]
                --[[ if segm.route and not HasPrepared then
                    segm.route = false
                    segm.inroute = false
                end--]]
            end
        end
    end
end

timer.Create("metrostroi_centralisation",0.1,0,Metrostroi.Centralisation)
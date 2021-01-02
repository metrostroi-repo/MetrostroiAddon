Metrostroi.ARMTable = {signal = {},switch = {},trigger = {}}

if SERVER then
    util.AddNetworkString "metrostroi-arm"
    hook.Add("Think","metrostroi_arm_remove",function()
        for i,v in ipairs(Metrostroi.ARMTable) do
            if IsValid(v.Controller) and v.Controller.Station ~= i then
                v.Controller = nil
                v.net = {}
            end
        end
    end)
    net.Receive("metrostroi-arm",function(_,ply)
        local station = net.ReadUInt(16)
        --print("Player "..tostring(ply).." request full sync."..station)
        net.Start("metrostroi-arm")
            net.WriteBool(true)
            net.WriteInt(station,16)
            net.WriteTable(Metrostroi.ARMTable[station].net)
        net.Send(ply)
    end)
    function Metrostroi.ARMGet(name,typ)
        if not name or not Metrostroi.ARMTable[typ] then return end
        if typ == "signal" then
            local signal = Metrostroi.ARMTable[typ][name]
            if not IsValid(signal) then
                Metrostroi.ARMTable[typ][name] = Metrostroi.GetSignalByName(name)
                return false
            end
            return signal
        end
        if typ == "switch" then
            local switch = Metrostroi.ARMTable[typ][name]
            if not IsValid(switch) then
                Metrostroi.ARMTable[typ][name] = Metrostroi.GetSwitchByName(name)
                return false
            end
            return switch
        end
        if typ == "trigger" then
            local trigger = Metrostroi.ARMTable[typ][name]
            if not IsValid(trigger) then
                local triggers = ents.FindByName(name)
                if #triggers == 1 then
                    trigger = triggers[1]
                    Metrostroi.ARMTable[typ][name] = trigger
                    trigger:Fire("AddOutput","OnEndTouchAll !self:ARMEndTouch::0:-1",0)
                    trigger:Fire("AddOutput","OnStartTouchAll !self:ARMStartTouch::0:-1",0)
                    trigger:Fire("AddOutput","OnTouching !self:ARMStartTouch::0:-1",0)
                    trigger:Fire("TouchTest")
                end
                return
            else
                return trigger
            end
        end
    end
    function Metrostroi.ARMSync(station,segmid,id,val)
        local tbl = Metrostroi.ARMTable[station]and Metrostroi.ARMTable[station].net
        if not tbl then return end
        if not tbl[segmid] then tbl[segmid] = {} end
        if val == false then val = nil end
        if tbl[segmid][id] == val then return end
        print("Syncing",station,segmid,id,val)
        net.Start("metrostroi-arm")
            net.WriteBool(false)
            net.WriteUInt(station,16)
            net.WriteUInt(segmid,16)
            net.WriteString(id)
            net.WriteType(val)
        net.Broadcast()
        tbl[segmid][id] = val
    end
else
    hook.Add("Think","arm_think",function()
        for i,station in ipairs(Metrostroi.ARMTable) do
            if (not station.LastSync or CurTime()-station.LastSync > 15) and (not Metrostroi.ARMTable.LastSyncRequest or CurTime()-Metrostroi.ARMTable.LastSyncRequest > 1) then
                print(CurTime(),UnPredictedCurTime(),RealTime(),tostring(IsFirstTimePredicted()))
                net.Start("metrostroi-arm")
                    net.WriteInt(i,16)
                net.SendToServer()
                print("Requesting full sync",i)
                Metrostroi.ARMTable.LastSyncRequest = CurTime()
            end
        end
    end)

    net.Receive("metrostroi-arm",function(_,ply)
        if net.ReadBool() then
            local station = net.ReadUInt(16)
            print("We got sync.",station)
            Metrostroi.ARMTable[station] = net.ReadTable()
            Metrostroi.ARMTable[station].LastSync = CurTime()
        else
            local station = net.ReadUInt(16)
            local segmid = net.ReadUInt(16)
            local id = net.ReadString()
            local val = net.ReadType()
            print("Received",station,segmid,id,val)
            if not Metrostroi.ARMTable[station] then Metrostroi.ARMTable[station] = {} end
            if not Metrostroi.ARMTable[station][segmid] then Metrostroi.ARMTable[station][segmid] = {} end
            Metrostroi.ARMTable[station][segmid][id] = val
        end
    end)


    function Metrostroi.GetARMInfo(station,segmid,id)
        local tbl = Metrostroi.ARMTable[station]
        if not tbl then return end
        if not tbl[segmid] then return end
        return tbl[segmid][id]
    end
end
if Metrostroi.ARMConfigGenerated then
    for k,v in ipairs(Metrostroi.ARMConfigGenerated) do
        Metrostroi.ARMTable[k] = {
            occChecks = {},
            net = {},
            signal = {},
            switch = {},
            trigger = {},
            routes = {},
        }
    end
end
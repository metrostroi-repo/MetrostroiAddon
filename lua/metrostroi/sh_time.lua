if CLIENT then
    local function getTime()
        return os.time()+GetGlobalFloat("MetrostroiTimeOffset",0)
    end
    function Metrostroi.GetTimedT(notsync)
        local T0 = GetGlobalFloat("MetrostroiT0",os.time())+GetGlobalFloat("MetrostroiTY")
        local T1 = GetGlobalFloat("MetrostroiT1",CurTime())
        local dT
        if notsync then
            dT = (os.time()-T0) - (CurTime()-T1)
        else
            dT = (os.time()-T0 + (CurTime() % 1.0)) - (CurTime()-T1)
        end
        return dT
    end
    function Metrostroi.GetSyncTime(notsync)
        return getTime()-Metrostroi.GetTimedT(notsync)
    end
    timer.Simple(0,function()
        net.Start("MetrostroiUpdateTimeSync")
        net.SendToServer()
    end)
    return
end

local C_TimeOffset = CreateConVar("metrostroi_time_offset",0,FCVAR_ARCHIVE,"Server time offset in seconds")
local C_TimeOld = CreateConVar("metrostroi_time_old",0,FCVAR_ARCHIVE,"Enables old time system without codepoints")
local function getTime()
    return os.time()+C_TimeOffset:GetFloat()
end

local function UpdateTimeSync()
    --if GetGlobalFloat("MetrostroiT0",0) == 0 then
        local year = os.time{hour=3,day=1,month=1,year=1971}
        SetGlobalFloat("MetrostroiTY",year*math.ceil((os.time())/year))
        SetGlobalFloat("MetrostroiT0",os.time()-GetGlobalFloat("MetrostroiTY"))
        SetGlobalFloat("MetrostroiT1",CurTime())
        SetGlobalFloat("MetrostroiTimeOffset",C_TimeOffset:GetFloat())
    --[[else
        print"GETSECOND"
        SetGlobalFloat("MetrostroiT0",GetGlobalFloat("MetrostroiT0"))
        SetGlobalFloat("MetrostroiT1",GetGlobalFloat("MetrostroiT1"))
    end]]
end
timer.Create("metrostroi_time_update",60,0,UpdateTimeSync)
util.AddNetworkString("MetrostroiUpdateTimeSync")
net.Receive("MetrostroiUpdateTimeSync",UpdateTimeSync)
cvars.AddChangeCallback("metrostroi_time_offset",UpdateTimeSync,"MetrostroiUpdateTimeSync")
hook.Add("PlayerInitialSpawn","metrostroi_time_sync",UpdateTimeSync)
UpdateTimeSync()


local function tonumberVar(...)
    local out = {}
    for i,num in ipairs{...} do out[i] = tonumber(num) or num ~= "" and num end
    return unpack(out)
end
local message =[[
metrostroi_time_set commang usage:
Date or time in DD.MM.YYYY HH:MM:SS format
Time offset in +24 or -24 format
Seconds and 12-hours(AM/PM) are optional
Examples:
metrostroi_time_set 12:00
metrostroi_time_set 01.01.2019
metrostroi_time_set 27.03.2019 10:14:30
metrostroi_time_set 26.10.1985 9:00AM
metrostroi_time_set +3
metrostroi_time_set 0 to reset]]

concommand.Add("metrostroi_time_set",function(ply,_,_,fargs)
    if IsValid(ply) then return end

    local tMinArr = os.date("*t")
    local tArr = os.date("!*t")
    local GMTMin = os.time(tMinArr)-os.time(tArr)
    local timeAdd = tonumber(string.match(fargs,"^+?-?[012]?%d$"))

    if timeAdd then
        if -24 <= timeAdd and timeAdd <= 24 then
            RunConsoleCommand("metrostroi_time_offset",timeAdd*3600)
            RunConsoleCommand("metrostroi_time")
        else
            print(message)
        end
    else
        local H,M,S,twH = tonumberVar(string.match(fargs,"(%d?%d):(%d%d):?(%d?%d?)%s?(P?A?M?)"))
        if H and M then
            if twH and twH ~= "AM" and twH ~= "PM" then MsgC(Color(255,0,0),"Bad metrostroi_time_set commang usage.\n12-hours parameter must be AM or PM\n") return end
            if H < 0 or (not twH and H > 24 or twH and H > 12) then MsgC(Color(255,0,0),"Bad metrostroi_time_set commang usage.\nHours must be in 0.."..(twH and 12 or 23).." range\n") return end
            if M < 0 or M > 59 then MsgC(Color(255,0,0),"Bad metrostroi_time_set commang usage.\nMinutes must be in 0..59 range\n") return end
            if S and (S < 0 or S > 59) then MsgC(Color(255,0,0),"Bad metrostroi_time_set commang usage.\nSeconds must be in 0..59 range\n") return end
            local isPM = twH and twH == "PM"
            if twH and H == 12 then H = 0 isPM = not isPM end
            tArr.changed = true
            tArr.hour = (isPM and H+12 or H)
            tArr.min = M
            tArr.sec = S or tArr.sec
        end
        local d,m,y = tonumberVar(string.match(fargs,"(%d%d)%.(%d%d?)%.(%d%d%d?%d?)"))
        if d and m and y then
            local maxDays = m == 2 and (y%4 == 0 and 29 or 28) or (m < 8 and m%2==1 or m >= 8 and m%2==0) and 31 or 30
            if y < 1970 or y > 2999 then MsgC(Color(255,0,0),"Bad metrostroi_time_set commang usage.\nYear must be in 1970..2999 range\n") return end
            if d < 1 or d > maxDays then MsgC(Color(255,0,0),"Bad metrostroi_time_set commang usage.\nDay must be in 1.."..maxDays.." range\n") return end
            if m < 1 or m > 12 then MsgC(Color(255,0,0),"Bad metrostroi_time_set commang usage.\nMonth must be in 1..12 range\n") return end
            tArr.changed = true
            tArr.day = d
            tArr.month = m
            tArr.year = y
        end
        if not tArr.changed then print(message) return end
        RunConsoleCommand("metrostroi_time_offset",-os.time()+os.time(tArr)+GMTMin)
        RunConsoleCommand("metrostroi_time")
    end
end,nil,"Sets current server date and time. metrostroi_time to more info.")

function Metrostroi.GetTimedT(notsync)
    local T0 = GetGlobalFloat("MetrostroiT0",os.time())+GetGlobalFloat("MetrostroiTY")
    local T1 = GetGlobalFloat("MetrostroiT1",CurTime())
    local dT
    if notsync then
        dT = (os.time()-T0) - (CurTime()-T1)
    else
        dT = (os.time()-T0 + (CurTime() % 1.0)) - (CurTime()-T1)
    end
    return dT
end
function Metrostroi.GetSyncTime(notsync)
    return getTime()-Metrostroi.GetTimedT(notsync)
end

local CV_PassScale = CreateConVar("metrostroi_passengers_scale",50,FCVAR_ARCHIVE,"Global passengers scale")
concommand.Add("metrostroi_time", function(ply, _, args)
    local time = Metrostroi.GetSyncTime()
    if IsValid(ply) then
        ply:PrintMessage(HUD_PRINTCONSOLE, os.date("!Server date: %d.%m.%Y Server time: %H:%M:%S ",time)..Format("Current scale %.1f (%d%%)",Metrostroi.PassengersScale,Metrostroi.PassengersScale/CV_PassScale:GetFloat()*100))

        --[=[local t = (time/60)%(60*24)
        local printed = false
        local train = ply:GetTrain()
        if IsValid(train) and train.Schedule then
            for k,v in ipairs(train.Schedule) do
                local prefix = ""
                if (not printed) and (t < v[3]) then
                    prefix = ">>>>"
                    printed = true
                end
                ply:PrintMessage(HUD_PRINTCONSOLE,
                    Format(prefix.."\t[%03d][%s] %02d:%02d:%02d",v[1],
                        Metrostroi.StationNames[v[1]] or "N/A",
                        math.floor(v[3]/60)%24,
                        math.floor(v[3])%60,
                        math.floor(v[3]*60)%60))

            end
        end]=]
    else
        print(os.date("!Server date: %d.%m.%Y Server time: %H:%M:%S ",time)..Format("Current scale %.1f (%d%%)",Metrostroi.PassengersScale,Metrostroi.PassengersScale/CV_PassScale:GetFloat()*100))
    end
end,nil,"Prints the current server time.")

Metrostroi.CodePoints = Metrostroi.CodePoints or {
    {23,1,0.2},
    {5.5,8.5,3},
    {10,13,1},
    {16,18,3},
    {20.5,22.5,0.5},
}

function Metrostroi.GetPassengersScale(time)
    for i,tA in ipairs(Metrostroi.CodePoints) do
        local pA,nA = (Metrostroi.CodePoints[i-1] or Metrostroi.CodePoints[#Metrostroi.CodePoints]),Metrostroi.CodePoints[i]
        local pTime,nTime = pA[2],nA[2]
        if pTime > nTime and (time < pTime and time > nTime) or pTime < nTime and (time < pTime or time > nTime) then continue end
        local time1,time2 = tA[1],tA[2]
        local pPoint, nPoint = pA[3],nA[3]
        if not pPoint then pPoint = Metrostroi.CodePoints[#Metrostroi.CodePoints] end
        if not nPoint then nPoint = Metrostroi.CodePoints[1] end
        if time1 > time2 and time >= time1 then time2 = time1+24+(time2-time1) end
        if time1 > time2 and time <= time2 then time1 = time2-24-(time2-time1) end
        if pPoint > nPoint then
            return math.Clamp(pPoint + (time-time1)/(time2-time1)*(nPoint-pPoint),nPoint,pPoint)*CV_PassScale:GetFloat()
        else
            return math.Clamp(pPoint + (time-time1)/(time2-time1)*(nPoint-pPoint),pPoint,nPoint)*CV_PassScale:GetFloat()
        end
    end
    return CV_PassScale:GetFloat()
end


local function timeStr(time)
    return Format("%02d:%02d",math.floor(time),math.floor(time*60)%60)
end
local function appendRight(str,sz)
    return str..string.rep(" ",sz-#str)
end

local function printArray(id)
    if #Metrostroi.CodePoints == 0 then
        print("No codepoints array. Current scale:"..Metrostroi.GetPassengersScale(0))
        return
    end

    for i,point in pairs(Metrostroi.CodePoints) do
        print(Format("[% 2d] %s-%s scale from %.2f to %.2f%s",i,timeStr(point[1]),timeStr(point[2]),(Metrostroi.CodePoints[i-1] or Metrostroi.CodePoints[#Metrostroi.CodePoints])[3],point[3],i == id and " <" or ""))
    end
    print("Time scale array:")
    for x=0,4 do
        for i=x*5,math.min(23.5,x*5+4) do Msg(appendRight(Format("%d",i),10)) end
        Msg("\n")
        for i=x*5,math.min(23.5,x*5+4.5),0.5 do Msg(appendRight(Format("%.2f",Metrostroi.GetPassengersScale(i)/CV_PassScale:GetFloat()),5)) end
        Msg("\n")
    end
end
concommand.Add("metrostroi_time_codepoints",function(ply,_,_,fargs)
    if IsValid(ply) then return end
    printArray()
end,nil,"Print current codepoints array")

local function getTime(str,st)
    local _,en,H,M,twH = tonumberVar(string.find(str,"(%d?%d):?(%d?%d?)%s?(P?A?M?)",st))
    if H then
        if twH and twH ~= "AM" and twH ~= "PM" then MsgC(Color(255,0,0),"Bad metrostroi_time_codepoint_add commang usage.\n12-hours parameter must be AM or PM\n") return end
        if H < 0 or (not twH and H > 24 or twH and H > 12) then MsgC(Color(255,0,0),"Bad metrostroi_time_codepoint_add commang usage.\nHours must be in 0.."..(twH and 12 or 23).." range\n") return end
        if M and (M < 0 or M > 59) then MsgC(Color(255,0,0),"Bad metrostroi_time_codepoint_add commang usage.\nMinutes must be in 0..59 range\n") return end
        local isPM = twH and twH == "PM"
        if twH and H == 12 then H = 0 isPM = not isPM end
        if isPM then H = H+12 end

        return M and H+M/60 or H,en
    end
end

local function checkTime(v1,v2,afterMid,id,arr)
    for i,point in ipairs(arr or Metrostroi.CodePoints) do
        if i == id then continue end
        if not afterMid and point[1] == v1 and point[2] == v2 or afterMid and point[1] == v2 and point[2] == v1
                or point[1] < point[2] and (
                    point[1] < v1 and v1 < point[2] or
                    point[1] < v2 and v2 < point[2] or
                    not afterMid and point[1] > v1 and point[2] < v2 or
                    afterMid and point[1] < v1 and point[2] > v2
                ) or point[1] > point[2] and (point[1] < v2 or point[2] > v1) then
            print("Time overlap!")
            print(Format("[% 2d] %s-%s our %s-%s",i,timeStr(point[1]),timeStr(point[2]),timeStr(v1),timeStr(v2)))
            return false
        end
    end
    return not id or (arr or Metrostroi.CodePoints)[id]
end

concommand.Add("metrostroi_time_add",function(ply,_,_,fargs)
    if IsValid(ply) then return end

    local v1, e1 = getTime(fargs)
    local v2, e2 = getTime(fargs,e1)
    local val = e2 and tonumber(string.sub(fargs,e2,-1))
    if not v1 or not v2 or not val then
        print("metrostroi_time_add usage:\nEnter scale change start and end time and then target scale at end of this time\nExamples:\nmetrostroi_time_add 10:00 11:00 2\nmetrostroi_time_add 12 13 1")
        return
    end

    local afterMid = v1 > v2
    if afterMid then
        local v = v1
        v1 = v2
        v2 = v
    end
    if not checkTime(v1,v2,afterMid) then return end
    if afterMid then
        table.insert(Metrostroi.CodePoints,{v2,v1,val})
    else
        table.insert(Metrostroi.CodePoints,{v1,v2,val})
    end
    table.sort(Metrostroi.CodePoints,function(a,b) return a[2] < b[2] end)
    for i,v in ipairs(Metrostroi.CodePoints) do
        if afterMid and v1 == v[2] and v2 == v[1] or not afterMid and v1 == v[1] and v2 == v[2] then
            printArray(i)
            print("Added at id "..i)
            return
        end
    end
end,nil,"Adds a new codepoint. metrostroi_time_add to more info.")

concommand.Add("metrostroi_time_edit",function(ply,_,_,fargs)
    if IsValid(ply) then return end
    local _,e1,id = tonumberVar(string.find(fargs,"([^%s]+)"))
    local v1, e2 = getTime(fargs,e1 and e1+1)
    local v2, e3 = getTime(fargs,e2)
    local val = e3 and tonumber(string.sub(fargs,e3,-1))

    if not id or not v1 or not v2 or not val then
        print("metrostroi_time_edit usage:\nEnter scale change start and end time and then target scale at end of this time\nExamples:\nmetrostroi_time_edit 10:00 11:00 2\nmetrostroi_time_edit 12 13 1")
        return
    end

    if not Metrostroi.CodePoints[id] then
        print("Codepoint at "..id.." id is not found!")
        return
    end

    local afterMid = v1 > v2
    if afterMid then
        local v = v1
        v1 = v2
        v2 = v
    end
    local points = checkTime(v1,v2,afterMid,id)
    if not points then return end
    if afterMid then
        points[1] = v2
        points[2] = v1
        points[3] = val
    else
        points[1] = v1
        points[2] = v2
        points[3] = val
    end
    table.sort(Metrostroi.CodePoints,function(a,b) return a[2] < b[2] end)
    printArray(id)
    print("Edited id "..id)
end,nil,"Edits an exist codepoint. metrostroi_time_edit to more info.")

concommand.Add("metrostroi_time_remove",function(ply,_,_,fargs)
    if IsValid(ply) then return end
    local id = tonumber(fargs)
    if not id then
        print("metrostroi_time_remove usage:\nEnter codepoint id to remove it\nExamples:\nmetrostroi_time_remove 2")
        return
    end
    if not Metrostroi.CodePoints[id] then
        print("Codepoint at "..id.." id is not found!")
        return
    end
    table.remove(Metrostroi.CodePoints,id)
    table.sort(Metrostroi.CodePoints,function(a,b) return a[2] < b[2] end)

    printArray(id-1)
    print("Removed id "..id)
end,nil,"Removes an exist codepoint. metrostroi_time_remove to more info.")

concommand.Add("metrostroi_time_clear",function(ply,_,_,fargs)
    if IsValid(ply) then return end
    Metrostroi.CodePoints = {}
    printArray()
    print("Codepoints array cleared ")
end,nil,"Fully clears codepoint array.")

concommand.Add("metrostroi_time_reset",function(ply,_,_,fargs)
    if IsValid(ply) then return end
    Metrostroi.CodePoints = {
        {23,1,0.2},
        {5.5,8.5,3},
        {10,13,1},
        {16,18,3},
        {20.5,22.5,0.5},
    }
    printArray()
    print("Codepoints array cleared ")
end,nil,"Resets codepoint array to default.")

function Metrostroi.LoadCodepoints()
    local arrayData = file.Read("metrostroi_data/time_codepoints.txt")
    local arr
    if arrayData then
        arr = {}

        for v1,v2,val in string.gmatch(arrayData,"([^%s]+)%s*([^%s]+)%s*([^\n\r]+)") do
            v1,v2,val = tonumberVar(v1,v2,val)
            if not v1 or not v2 or not val then
                arr = false
                break
            end
            table.insert(arr,{v1,v2,val})
        end
    end
    if arr then
        --table.sort(arr,function(a,b) return a[2] < b[2] end)
        local good = true
        for i,point in ipairs(arr) do
            if point[1] > point[2] and not checkTime(point[2],point[1],true,i,arr) or point[1] < point[2] and not checkTime(point[1],point[2],false,i,arr) then
                good = false
                break
            end
        end
        if good then
            Metrostroi.CodePoints = arr
            print("Metrostroi: Loaded time codepoints")
            return
        end
    end
    Metrostroi.CodePoints = {
        {23,1,0.2},
        {5.5,8.5,3},
        {10,13,1},
        {16,18,3},
        {20.5,22.5,0.5},
    }
    print("Metrostroi: Loaded default time codepoints")
end
function Metrostroi.SaveCodepoints()
    if not file.Exists("metrostroi_data","DATA") then
        file.CreateDir("metrostroi_data")
    end

    local arrayData = ""
    for i,v in ipairs(Metrostroi.CodePoints) do
        arrayData = arrayData..Format("%f %f %f\n",v[1],v[2],v[3])
    end
    file.Write("metrostroi_data/time_codepoints.txt",arrayData)
    print("Metrostroi: Saved time codepoints")
end
Metrostroi.LoadCodepoints()
concommand.Add("metrostroi_time_save", function(ply, _, args)
    if IsValid(ply) then return end
    Metrostroi.SaveCodepoints()
end,nil,"Save current codepoint array.")

concommand.Add("metrostroi_time_load", function(ply, _, args)
    if IsValid(ply) then return end
    Metrostroi.LoadCodepoints()
end,nil,"Load current codepoint array.")

local function getScale()
    if C_TimeOld:GetBool() then
        Metrostroi.PassengersScale = CV_PassScale:GetFloat()
    else
        Metrostroi.PassengersScale = Metrostroi.GetPassengersScale(Metrostroi.GetSyncTime()%86400/3600)
    end
end
timer.Create("PassScaleChecker", 10, 0, getScale)
getScale()
cvars.AddChangeCallback("metrostroi_time_old",getScale,"PassScaleChecker")
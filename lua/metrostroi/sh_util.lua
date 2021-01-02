function Metrostroi.VectorAngle(v,v1,v2)
    local vec1 = (v1-v):GetNormalized()
    local vec2 = (v2-v):GetNormalized()
    return math.deg(math.acos(vec1:Dot(vec2)))
end

function Metrostroi.GetLowVal(...)
    local valID,val
    for k,v in pairs{...} do
        if v and (not val or v < val) then
            valID = k
            val = v
        end
    end
    return valID,val
end

if not math.InRange then
    function math.InRangeXY(x,y,px1,py1,px2,py2)
        return (px1 < x and x < px2) and (py1 < y and y < py2)
    end
    function math.InRangeXYR(x,y,px,py,pw,ph)
        return (px < x and x < px+pw) and (py < y and y < py+ph)
    end
    function math.InRangeXYRC(x,y,px,py,pw,ph)
        local hpw,hph = pw/2,ph/2
        return (px-hpw < x and x < px+hpw) and (py-hph < y and y < py+hph)
    end
end

function Metrostroi.SortInSpawner(ent,id,name)
    if not ent.Spawner then return end
    local spawnerLine
    for _,var in ipairs(ent.Spawner) do
        if var[1] == id and type(var[4]) == "table" then
            spawnerLine = var
            if not spawnerLine.original then
                spawnerLine.original = table.Copy(var[4])
                spawnerLine.custom = {}
            end
            break
        end
    end
    if not spawnerLine then return end

    local retID = table.KeyFromValue(spawnerLine[4],name)
    if not retID then
        table.insert(spawnerLine.custom,name)
        table.sort(spawnerLine.custom)
        spawnerLine[4] = {}
        table.Add(spawnerLine[4],spawnerLine.original)
        table.Add(spawnerLine[4],spawnerLine.custom)
        retID = table.KeyFromValue(spawnerLine[4],name)
    end
    return retID,#spawnerLine[4]
end



--CHECK ME
Metrostroi.PatchedENTCache = Metrostroi.PatchedENTCache or {}
local MetrostroiENTCache = Metrostroi.PatchedENTCache

local function updateMeta()
    local meta = table.Copy(FindMetaTable("Entity"))
    function meta:__index( key )
        --__index function patch, because builtin function have shit with :GetTable,
        --which is slow, so i precache GetTable's result and use cached version of it
        local val = meta[ key ]
        if val ~= nil then return val end
        if not MetrostroiENTCache[self] then return end --FIXME какова хуя сука, почему оно становится невалидным :AAAA:
        val = MetrostroiENTCache[self][key]
        if val ~= nil then return val end
        if key == "Owner" then return meta.GetOwner(self) end
    end
    Metrostroi.PatchedMetatable = meta
end
hook.Add("OnGamemodeLoaded","MetrostroiOptimisationPatch",updateMeta)
updateMeta()

timer.Create("MetrostroiCacheWatchdog", 1, 0, function()
    for ent in pairs(MetrostroiENTCache) do
        if not IsValid(ent) then
            MetrostroiENTCache[ent] = nil
            print("Cleared cache",ent)
        end
    end
end)

function Metrostroi.OptimisationPatch(ent)
    if true or ent then
        --[[MetrostroiENTCache[ent] = ent:GetTable()
        debug.setmetatable(ent,Metrostroi.PatchedMetatable)
        print(tostring(ent).." patched...")]]
        return
    end
    if not ENT then error("This function must be runned at the end of entity initialisation") end
    if not ENT.Initialize then error("Can't get ENT.Initialize. Maybe you running function too early?") end
    print(ENT.Folder.." added to patched entities...")


    ENT.MetrostroiUnPatchedInitialize = ENT.Initialize
    ENT.Initialize = function(self,...)
        --[[local jitEnabled = jit.status()
        print(jitEnabled and "JIT was enabled" or "JIT was disabled")
        jit.on()
        local x
        local arr = self:GetTable()
        for i=1,1000000 do
            arr["i1"..i] = i*2
            arr["i2"..i] = i*2
            arr["i3"..i] = i*2
        end
        local time = SysTime()
        for i=1,1000000 do
            x = self["i3"..i]--*self["i3"..i]/self["i3"..i]^self["i3"..i]
        end
        local elapsed1 = SysTime()-time
        print("Before patch:"..elapsed1)

        local time = SysTime()
        for i=1,1000000 do
            x = arr["i2"..i]--*arr["i3"..i]/self["i3"..i]^self["i3"..i]
        end
        local elapsed3 = SysTime()-time
        print("Direct access:"..elapsed3)

        __MetrostroiENTCache[self] = self:GetTable()
        debug.setmetatable(self,Metrostroi.PatchedMetatable)
        local time = SysTime()
        for i=1,1000000 do
            x = self["i1"..i]--*self["i3"..i]/self["i3"..i]^self["i3"..i]
        end
        local elapsed2 = SysTime()-time
        print("After patch:"..elapsed2)

        print(Format("Patch is faster by %d%%\nPatch is faster than direct access by %d%%",elapsed1/elapsed2*100,elapsed3/elapsed2*100))
        print("BASE",getmetatable(self))
        jit.on()]]
        MetrostroiENTCache[self] = self:GetTable()
        debug.setmetatable(self,Metrostroi.PatchedMetatable)

        return self:MetrostroiUnPatchedInitialize(...)
    end
end
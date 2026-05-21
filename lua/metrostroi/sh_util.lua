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

-- Build sync table for entity network booleans
function Metrostroi.BuildSyncTable()
    if not ENT or not ENT.SyncTable then error("Metrostroi.BuildSyncTable() must be runned after ENT.SyncTable declaration") end

    ENT.iSyncTable = {}
    for i,v in ipairs(ENT.SyncTable) do
        ENT.iSyncTable[v] = i
    end
end 

-- Data storage for Metrostroi entities
MSCEnt = MSCEnt or {}
local cache = MSCEnt
local meta = FindMetaTable("MSTrain")

if not meta then
    print("Metrostroi: Registering metatable...")

    meta = table.Copy(FindMetaTable("Entity"))

    meta.MetaID = nil
    meta.MetaName = nil

    function meta:__index(key)
        local val = meta[key]
        if val ~= nil then return val end
        val = cache[self][key]
        if val ~= nil then return val end
        if key == "Owner" then return meta.GetOwner(self) end
    end

    RegisterMetaTable("MSTrain", meta)
end

local C_EntityPatch = CreateConVar("metrostroi_entity_patch", "1", FCVAR_ARCHIVE, 
                    "Performance patch for metrostroi entities. Reload server/client for apply this. (0 - disabled, 1 - auto, 2 - enabled)")
function Metrostroi.OptimisationPatch()
    local entPatch = C_EntityPatch:GetInt()
    if entPatch == 0 or (entPatch == 1 and jit.version_num == 20100) then return end -- On x64 branch this patch is laggy
    if not ENT then error("This function must be runned at the end of entity initialisation") end
    if not ENT.Initialize then error("Can't get ENT.Initialize. Maybe you running function too early?") end
    MsgC(Color(0,255,0,255), Format("Metrostroi: %s applied performance patch\n", ENT.Folder))

    ENT.OptInit = ENT.OptInit or ENT.Initialize
    local oInit = ENT.OptInit or (function() end)
    function ENT:Initialize(...)
        cache[self] = self:GetTable()
        debug.setmetatable(self,meta)
        oInit(self,...)
    end

    ENT.OptRemove = ENT.OptRemove or ENT.OnRemove
    local oRemove = ENT.OptRemove or (function() end)
    if SERVER then
        function ENT:OnRemove(...)
            self:SetTable(cache[self])
            debug.setmetatable(self,FindMetaTable("Entity"))
            cache[self] = {}
            oRemove(self,...)
        end
    else
        function ENT:OnRemove(fullUpdate,...)
            if fullUpdate == false then
                self:SetTable(cache[self])
                debug.setmetatable(self,FindMetaTable("Entity"))
                cache[self] = {}
            end
            oRemove(self,fullUpdate,...)
        end
    end
end
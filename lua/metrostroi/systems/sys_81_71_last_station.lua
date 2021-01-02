--------------------------------------------------------------------------------
-- Last station sign helper system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_71_LastStation")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize(texName)
    self.ID = 0
    if texName then
        self.TableName = texName.."_routes"
    end
    self.Texture = ""
end

function TRAIN_SYSTEM:Outputs()
    return {}
end

function TRAIN_SYSTEM:Inputs()
    return {"+","-"}
end
if TURBOSTROI then return end

if SERVER then
    function TRAIN_SYSTEM:TriggerInput(name,value)
        if not self.TableName  then return end
        local tbl = Metrostroi.Skins[self.TableName]
        if tbl and name=="+" and value>0 then
            self.ID = self.ID+1
            if self.ID>#tbl then self.ID = 0 end
        end
        if tbl and name=="-" and value>0 then
            self.ID = self.ID-1
            if self.ID<0 then self.ID = #tbl end
        end
        self.Train:SetNW2Int("LastStationID",self.ID)
    end
else
    function TRAIN_SYSTEM:ClientInitialize(texName,entName)
        self.Reloaded = false
        if texName then
            self.TableName = texName.."_routes"
        end
        self.EntityName = entName
    end

    function TRAIN_SYSTEM:ClientThink()
        local Train = self.Train
        local ent = Train.ClientEnts[self.EntityName]

        if self.Reloaded and self.ID ~= Train:GetNW2Int("LastStationID",-1) then
            self.ID = Train:GetNW2Int("LastStationID",-1)
            self.Reloaded = false
        end
        if not self.TableName or not Metrostroi.Skins[self.TableName] or not ent or self.Reloaded then return end

        self.Reloaded = true
        local texTable = Metrostroi.Skins[self.TableName]
        local tex = texTable[self.ID]
        for id,texName in pairs(ent:GetMaterials()) do
            if texName == texTable.default then
                ent:SetSubMaterial(id-1,texTable[self.ID])
            end
        end
    end
end

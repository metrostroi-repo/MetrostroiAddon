Metrostroi.DefineModule("81-717_ZL_BPSN") -- Простой скрипт который заменяет звук БПСН

function MOD:Initialize()

end

local allowed = {
    ["gmod_subway_81-717_mvm"] = true,
    ["gmod_subway_81-714_mvm"] = true,
}

function MOD:TrainInitialize(ent)
    if not allowed[ent:GetClass()] then return end

    local this = self

    self:WrapFunction(ent, "InitializeSounds", function(ent)
        this:TrainInitializeSounds(ent)
    end)
end


function MOD:TrainInitializeSounds(ENT)
    if not allowed[ENT:GetClass()] then return end

    if not ENT:GetNW2Bool("BPSNCustom", false) then return end

    local typ = ENT:GetNW2Int("BPSNType", 1)

    ENT.SoundNames["bpsn"..typ] = {"subway_trains/717/bpsn/bpsn_zl1.wav", loop=true}
    ENT.SoundPositions["bpsn"..typ] = {600,1e9,Vector(0,45,-448),0.03}
end

function MOD:TrainSpawnerSettings(trainSpawner, entSpawner, forSWEP)
    if trainSpawner.Train ~= "gmod_subway_81-717_mvm_custom" then return end

    table.insert(entSpawner, {"BPSNCustom", "БПСН ЗЛ", "Boolean"})
end

Metrostroi.ReloadModule()
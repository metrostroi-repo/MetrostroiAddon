Metrostroi.DefineModule("81-717_ZL_BPSN") -- Простой скрипт который заменяет звук БПСН

function MOD:Initialize()

end

local allowed = {
    ["gmod_subway_81-717_mvm_custom"] = true,
    ["gmod_subway_81-717_mvm"] = true,
    ["gmod_subway_81-714_mvm"] = true,
}

function MOD:TrainInitializeSounds(ENT)
    if not allowed[ENT:GetClass()] then return end

    ENT.SoundNames["bpsn_zl"] = {"subway_trains/717/bpsn/bpsn_zl1.wav", loop=true}
    ENT.SoundPositions["bpsn_zl"] = {600,1e9,Vector(0,45,-448),0.05}
end

function MOD:TrainSpawnerSettings(trainSpawner, entSpawner, forSWEP)
    if not allowed[trainSpawner.Train] then return end

    table.insert(entSpawner, {"BPSNCustom", "БПСН ЗЛ", "Boolean"})
end

function MOD:TrainPostThink(ENT)
    if SERVER then return end
    if not allowed[ENT:GetClass()] then return end

    local custombpsn = ENT:GetNW2Bool("BPSNCustom", false)
    
    if custombpsn then
        ENT:SetSoundState("bpsn"..ENT.BPSNType, 0, 1)
        ENT:SetSoundState("bpsn_zl", 1, 1)
    else
        ENT:SetSoundState("bpsn_zl", 0, 1)
    end
end

Metrostroi.ReloadModule()
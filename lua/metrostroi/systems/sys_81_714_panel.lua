--------------------------------------------------------------------------------
-- 81-714 controller panel
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_714_Panel")

function TRAIN_SYSTEM:Initialize()
    -- Выключатель батареи (ВБ)
    self.Train:LoadSystem("VB","Relay","VB-11", {bass = true})

    -- Педаль бдительности (ПБ)
    self.Train:LoadSystem("PB","Relay","Switch", {bass = true})

    -- Автоматические выключатели (АВ)
    self.Train:LoadSystem("A18","Relay","VA21-29")
    self.Train:LoadSystem("A49","Relay","VA21-29")
    self.Train:LoadSystem("A27","Relay","VA21-29")
    self.Train:LoadSystem("A10","Relay","VA21-29", { normally_closed = false })
    self.Train:LoadSystem("A53","Relay","VA21-29")

    self.Train:LoadSystem("A31","Relay","VA21-29")
    self.Train:LoadSystem("A32","Relay","VA21-29")
    self.Train:LoadSystem("A13","Relay","VA21-29")
    self.Train:LoadSystem("A1","Relay","VA21-29")
    self.Train:LoadSystem("A20","Relay","VA21-29")
    self.Train:LoadSystem("A25","Relay","VA21-29")
    self.Train:LoadSystem("A30","Relay","VA21-29")
    self.Train:LoadSystem("A56","Relay","VA21-29")
    self.Train:LoadSystem("A65","Relay","VA21-29")

    self.Train:LoadSystem("A2","Relay","VA21-29")
    self.Train:LoadSystem("A3","Relay","VA21-29")
    self.Train:LoadSystem("A4","Relay","VA21-29")
    self.Train:LoadSystem("A5","Relay","VA21-29")
    self.Train:LoadSystem("A6","Relay","VA21-29")
    self.Train:LoadSystem("A70","Relay","VA21-29")
    self.Train:LoadSystem("A14","Relay","VA21-29")
    self.Train:LoadSystem("A39","Relay","VA21-29")
    self.Train:LoadSystem("A28","Relay","VA21-29")
    self.Train:LoadSystem("A38","Relay","VA21-29")
    self.Train:LoadSystem("A22","Relay","VA21-29")
    self.Train:LoadSystem("A8","Relay","VA21-29")
    self.Train:LoadSystem("A12","Relay","VA21-29")
    self.Train:LoadSystem("A16","Relay","VA21-29")
    self.Train:LoadSystem("A37","Relay","VA21-29")
    self.Train:LoadSystem("A51","Relay","VA21-29")
    self.Train:LoadSystem("A24","Relay","VA21-29")
    self.Train:LoadSystem("A19","Relay","VA21-29")
    self.Train:LoadSystem("A50","Relay","VA21-29")
    self.Train:LoadSystem("A52","Relay","VA21-29")

    self.Train:LoadSystem("AV2","Relay","VA21-29")
    self.Train:LoadSystem("AV3","Relay","VA21-29")
    self.Train:LoadSystem("AV4","Relay","VA21-29")
    self.Train:LoadSystem("AV5","Relay","VA21-29")
    self.Train:LoadSystem("AV6","Relay","VA21-29")

    self.Train:LoadSystem("A55","Relay","VA21-29")
    self.Train:LoadSystem("A72","Relay","VA21-29")

    --Вагонные
    self.Train:LoadSystem("A45","Relay","VA21-29")
    self.Train:LoadSystem("A54","Relay","VA21-29", {normally_closed=false})
    self.Train:LoadSystem("A15","Relay","VA21-29")
    self.Train:LoadSystem("A23","Relay","VA21-29")

    self.Train:LoadSystem("A66","Relay","VA21-29")
    self.Train:LoadSystem("A80","Relay","VA21-29")
    self.Train:LoadSystem("A81","Relay","VA21-29")

    self.Train:LoadSystem("KV1","Relay","Switch",{bass=true})
    self.Train:LoadSystem("KV2","Relay","Switch",{bass=true})
    self.Train:LoadSystem("KV3","Relay","Switch",{bass=true})
    self.Train:LoadSystem("R1","Relay","Switch",{bass=true,open_time=2.3})

    --Shunt
    self.Train:LoadSystem("A84","Relay","VA21-29", {normally_closed=false})
    self.Train:LoadSystem("BPSNon","Relay","Switch", { bass = true })
    self.Train:LoadSystem("L_1","Relay","Switch",{bass = true})
    self.Train:LoadSystem("VozvratRP","Relay","Switch", {bass = true})
    self.Train:LoadSystem("OtklBV","Relay","Switch", {bass = true})
    self.Train:LoadSystem("Start","Relay","Switch", {bass = true})
    self.Train:LoadSystem("RV","Relay","Switch", {bass = true,defaultvalue=1,maxvalue=2})

    self.V1 = 0
    self.TW18 = 0
    self.GreenRP = 0
    self.BrW = 0
    self.EmergencyLights = 0
    self.DoorsW = 0
    self.MainLights = 0
    self.RZP = 0

    self.M1_3 = 0
    self.M4_7 = 0
    self.M8 = 0

    self.AnnouncerPlaying = 0
    self.AnnouncerBuzz = 0
    self.PCBKPower = 0
end

function TRAIN_SYSTEM:Outputs()
    return { "V1", "EmergencyLights","MainLights","DoorsW","GreenRP","BrW","TW18","L1","M1_3","M4_7","M8","AnnouncerPlaying","AnnouncerBuzz","PCBKPower","RZP"}
end

TRAIN_SYSTEM.AVMap = {
    "A53","A56","A24","A39","A23","A14","A13","A31","A32",
    "A16","A12","A49","A15","A27","A50","A8","A52","A19",
    "A22","A30","A1","A2","A3","A4","A5","A6","A72","A38","A20",
    "A25","A37","A55","A45","A66","A51","A65","A28","A70","AV2",
    "AV3","AV4","AV5","A81","AV6","A80",
}
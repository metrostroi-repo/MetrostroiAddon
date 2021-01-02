--------------------------------------------------------------------------------
-- 81-717 Moscow controller panel
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_717_Panel")

function TRAIN_SYSTEM:Initialize()
    -- Выключатель батареи (ВБ)
    self.Train:LoadSystem("VB","Relay","Switch",{bass = true})

    -- Buttons on the panel
    --self.Train:LoadSystem("DIPon","Relay","Switch", {bass = true})
    self.Train:LoadSystem("Ring","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VozvratRP","Relay","Switch", {bass = true})
    self.Train:LoadSystem("OtklBV","Relay","Switch", {bass = true})
    self.Train:LoadSystem("OtklBVK","Relay","Switch", {normally_closed=true,bass = true})
    self.Train:LoadSystem("RezMK","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VMK","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VAH","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VAD","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VUS","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VUD1","Relay","Switch", {bass = true })
    self.Train:LoadSystem("VUD2","Relay","Switch", {normally_closed=true,bass = true }) -- Doors close
    self.Train:LoadSystem("VDL","Relay","Switch", {bass = true}) -- Doors left open
    self.Train:LoadSystem("KDL","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KDLR","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KDP","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KRZD","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KSN","Relay","Switch", {bass = true})
    self.Train:LoadSystem("OtklAVU","Relay","Switch", {bass = true})
    self.Train:LoadSystem("OVT","Relay","Switch", {bass = true})
    self.Train:LoadSystem("ARS","Relay","Switch", {bass = true})
    self.Train:LoadSystem("ARSR","Relay","Switch", {bass = true})
    self.Train:LoadSystem("UOS","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VP","Relay","Switch", {bass = true})
    self.Train:LoadSystem("ALSFreq","Relay","Switch",{bass=true})
    self.Train:LoadSystem("ALS","Relay","Switch", {bass = true,normally_closed=true})
    self.Train:LoadSystem("KVT","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KVTR","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KRP","Relay","Switch", {bass = true})

    self.Train:LoadSystem("R_UNch","Relay","Switch", {bass = true})
    self.Train:LoadSystem("R_ZS","Relay","Switch", {bass = true})
    self.Train:LoadSystem("R_G","Relay","Switch", {bass = true})
    self.Train:LoadSystem("R_Radio","Relay","Switch", {bass = true})
    self.Train:LoadSystem("R_VPR","Relay","Switch", {bass = true,normally_closed = true})
    self.Train:LoadSystem("R_Program1","Relay","Switch", {bass = true})
    self.Train:LoadSystem("R_Program2","Relay","Switch", {bass = true})
    self.Train:LoadSystem("R_Program1H","Relay","Switch", {bass = true})
    self.Train:LoadSystem("R_Program2H","Relay","Switch", {bass = true})
    self.Train:LoadSystem("RC1","Relay","Switch",{ bass = true,normally_closed = true })

    self.Train:LoadSystem("Radio13","Relay","Switch", {bass = true})
    self.Train:LoadSystem("ARS13","Relay","Switch", {bass = true})

    -- Педаль бдительности (ПБ)
    self.Train:LoadSystem("PB","Relay","Switch", {bass = true})

    ----------------- БЗОС ----------------
    self.Train:LoadSystem("SAB1","Relay","Switch",{normally_closed=true, bass=true}) --Охранная сигнализация

    self.Train:LoadSystem("AIS","Relay","VA21-29")
    -- Автоматические выключатели (АВ)
    self.Train:LoadSystem("A11","Relay","VA21-29")
    self.Train:LoadSystem("A17","Relay","VA21-29")
    self.Train:LoadSystem("A44","Relay","VA21-29")
    self.Train:LoadSystem("A26","Relay","VA21-29")
    self.Train:LoadSystem("AR63","Relay","VA21-29")
    self.Train:LoadSystem("AS1","Relay","VA21-29")
    self.Train:LoadSystem("A21","Relay","VA21-29")
    self.Train:LoadSystem("A49","Relay","VA21-29")
    self.Train:LoadSystem("A27","Relay","VA21-29")
    self.Train:LoadSystem("A10","Relay","VA21-29")
    self.Train:LoadSystem("A53","Relay","VA21-29")
    self.Train:LoadSystem("A54","Relay","VA21-29")
    self.Train:LoadSystem("A84","Relay","VA21-29")

    self.Train:LoadSystem("A76","Relay","VA21-29")
    self.Train:LoadSystem("A48","Relay","VA21-29")
    self.Train:LoadSystem("A29","Relay","VA21-29")
    self.Train:LoadSystem("A46","Relay","VA21-29")
    self.Train:LoadSystem("A47","Relay","VA21-29")
    self.Train:LoadSystem("A79","Relay","VA21-29")
    self.Train:LoadSystem("A42","Relay","VA21-29")
    self.Train:LoadSystem("A74","Relay","VA21-29")
    self.Train:LoadSystem("A73","Relay","VA21-29")
    self.Train:LoadSystem("A71","Relay","VA21-29")
    self.Train:LoadSystem("A41","Relay","VA21-29")
    self.Train:LoadSystem("A45","Relay","VA21-29")
    self.Train:LoadSystem("A75","Relay","VA21-29")
    self.Train:LoadSystem("A58","Relay","VA21-29")
    self.Train:LoadSystem("A59","Relay","VA21-29")
    self.Train:LoadSystem("A43","Relay","VA21-29")
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
    self.Train:LoadSystem("A66","Relay","VA21-29")
    self.Train:LoadSystem("A18","Relay","VA21-29")
    self.Train:LoadSystem("A40","Relay","VA21-29")
    self.Train:LoadSystem("A80","Relay","VA21-29")
    self.Train:LoadSystem("A50","Relay","VA21-29")
    self.Train:LoadSystem("A52","Relay","VA21-29")

    self.Train:LoadSystem("AV2","Relay","VA21-29")
    self.Train:LoadSystem("AV3","Relay","VA21-29")
    self.Train:LoadSystem("AV4","Relay","VA21-29")
    self.Train:LoadSystem("AV5","Relay","VA21-29")
    self.Train:LoadSystem("AV6","Relay","VA21-29")
    self.Train:LoadSystem("AV1","Relay","VA21-29")

    self.Train:LoadSystem("A55","Relay","VA21-29")
    self.Train:LoadSystem("A57","Relay","VA21-29")
    self.Train:LoadSystem("A60","Relay","VA21-29")
    self.Train:LoadSystem("A81","Relay","VA21-29")
    self.Train:LoadSystem("A7","Relay","VA21-29")
    self.Train:LoadSystem("A9","Relay","VA21-29")
    self.Train:LoadSystem("A68","Relay","VA21-29")
    self.Train:LoadSystem("A72","Relay","VA21-29")

    --Вагонные
    self.Train:LoadSystem("A15","Relay","VA21-29")

    self.Train:LoadSystem("KDLK","Relay","Switch", { bass = true,normally_closed = true })
    self.Train:LoadSystem("KDLRK","Relay","Switch", { bass = true,normally_closed = true })
    self.Train:LoadSystem("KDPK","Relay","Switch", { bass = true,normally_closed = true })
    self.Train:LoadSystem("KAHK","Relay","Switch", { bass = true,normally_closed = true })

    -- 81-717 special
    self.Train:LoadSystem("BPSNon","Relay","Switch", { bass = true })
    self.Train:LoadSystem("L_1","Relay","Switch",{bass = true})
    self.Train:LoadSystem("L_2","Relay","Switch",{bass = true})
    self.Train:LoadSystem("L_3","Relay","Switch",{bass = true})
    self.Train:LoadSystem("L_4","Relay","Switch",{bass = true})
    self.Train:LoadSystem("DoorSelect","Relay","Switch", { bass = true, normally_closed = false })
    self.Train:LoadSystem("VZ1","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KAH","Relay","Switch", {bass = true})

    self.Train:LoadSystem("VBD","Relay","Switch",{bass = true,normally_closed=true})

    self.Train:LoadSystem("Wiper","Relay","Switch")

    self.Train:LoadSystem("PVK","Relay","Switch",{maxvalue=2,bass=true})
    self.Train:LoadSystem("V11","Relay","Switch",{bass=true})
    self.Train:LoadSystem("V12","Relay","Switch",{bass=true})
    self.Train:LoadSystem("V13","Relay","Switch",{bass=true})

    self.Train:LoadSystem("KV1","Relay","Switch",{bass=true})
    self.Train:LoadSystem("KV2","Relay","Switch",{bass=true})
    self.Train:LoadSystem("KV3","Relay","Switch",{bass=true})
    self.Train:LoadSystem("R1","Relay","Switch",{bass=true,close_time=2.3})

    self.V1 = 0
    self.LUDS = 0
    self.RedLight2 = 0
    self.RedLight1 = 0
    self.Headlights1 = 0
    self.Headlights2 = 0
    self.EqLights = 0
    self.CabLights = 0
    self.PanelLights = 0
    self.CabinLight = 0
    self.EmergencyLights = 0
    self.MainLights = 0
    self.DoorsLeft = 0
    self.DoorsRight = 0
    self.DoorsW = 0
    self.GreenRP = 0
    self.BrW = 0
    self.AVU = 0
    self.L1 = 0
    self.LKVP = 0
    self.RZP = 0
    self.KUP = 0
    self.BrT = 0
    self.LSN = 0
    self.Ring = 0
    self.SD = 0
    self.LST = 0
    self.LVD = 0
    self.LKVD = 0
    self.LhRK = 0
    self.KVC = 0
    self.SD = 0
    self.TW18 = 0

    self.KT = 0
    self.LN = 0
    self.RS = 0
    self.AR04 = 0
    self.AR0 = 0
    self.AR40 = 0
    self.AR60 = 0
    self.AR70 = 0
    self.AR80 = 0

    self.M1_3 = 0
    self.M4_7 = 0
    self.M8 = 0

    self.AnnouncerPlaying = 0
    self.AnnouncerBuzz = 0

    self.VPR = 0

    self.CBKIPower = 0
    self.PCBKPower = 0
end


function TRAIN_SYSTEM:Outputs()
    return { "V1","LUDS","RedLight2","RedLight1","Headlights1","Headlights2","EqLights","CabLights","EqLights","PanelLights","CabinLight","EmergencyLights","MainLights","DoorsLeft","DoorsRight","DoorsW","GreenRP","BrW","AVU","LKVP","RZP","KUP","BrT","LSN","Ring","SD","LST","LVD","LhRK","KVC","SD","TW18", "KT",
             "LKVD","LN","RS","AR04","AR0","AR40","AR60","AR70","AR80","L1","M1_3","M4_7","M8",
             "AnnouncerPlaying","AnnouncerBuzz","VPR",
             "CBKIPower","PCBKPower"}
end
TRAIN_SYSTEM.AVMap = {
    "A11","A17","A44","A26","AR63","A61",
    "A21","A49","A27","A10","A53","A54",
    "A84","A76","A48","AV1","A29","A46",
    "A47","A79","A42","A74","A73","A71",
    "A41","A45","A75","A58","A59","A43",
    "A31","A32","A13","A1","A20","A25",
    "A30","A56","A65","A2","A3","A4","A5",
    "A6","A70","A14","A39","A28","A38","A22",
    "A8","A12","A16","A37","A51","A24","A19",
    "A66","A18","A40","A80","A50","A52","AV2",
    "AV3","AV4","AV5","AV6","A55","A57","A60",
    "A81","A7","A9","A68","A72","A15",
}
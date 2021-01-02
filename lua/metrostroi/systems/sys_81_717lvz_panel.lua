--------------------------------------------------------------------------------
-- 81-717 SPB controller panel
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_717LVZ_Panel")

function TRAIN_SYSTEM:Initialize()
    -- Выключатель батареи (ВБ)
    self.Train:LoadSystem("VB","Relay","Switch",{bass = true})

    -- Buttons on the panel
    self.Train:LoadSystem("Ring","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VozvratRP","Relay","Switch", {bass = true})
    self.Train:LoadSystem("OtklBV","Relay","Switch", {bass = true})
    self.Train:LoadSystem("RezMK","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VMK","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VAH","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VAD","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VUS","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VUD1","Relay","Switch", {bass = true })
    self.Train:LoadSystem("VUD2","Relay","Switch", { normally_closed = true, bass = true }) -- Doors close
    self.Train:LoadSystem("VDL","Relay","Switch", {bass = true}) -- Doors left open
    self.Train:LoadSystem("KDL","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KDLR","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KDP","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VOPD","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KRZD","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KSN","Relay","Switch", {bass = true})
    self.Train:LoadSystem("OtklAVU","Relay","Switch", {bass = true})
    self.Train:LoadSystem("OVT","Relay","Switch", {bass = true})
    self.Train:LoadSystem("OVTPl","Relay","Switch", {bass = true})
    self.Train:LoadSystem("ARS","Relay","Switch", {bass = true})
    self.Train:LoadSystem("ALS","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VPAOn","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VPAOff","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KVT","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KRP","Relay","Switch", {bass = true})

    self.Train:LoadSystem("R_UNch","Relay","Switch", {bass = true})
    self.Train:LoadSystem("R_ZS","Relay","Switch", {bass = true})
    self.Train:LoadSystem("R_G","Relay","Switch", {bass = true})
    self.Train:LoadSystem("R_UPO","Relay","Switch", {bass = true})
    self.Train:LoadSystem("R_VPR","Relay","Switch", {bass = true})
    self.Train:LoadSystem("RC1","Relay","Switch",{ bass = true,normally_closed = true })
    self.Train:LoadSystem("VRD","Relay","Switch",{ bass = true})

    self.Train:LoadSystem("Radio13","Relay","Switch", {bass = true})
    self.Train:LoadSystem("ARS13","Relay","Switch", {bass = true})

    -- Педаль бдительности (ПБ)
    self.Train:LoadSystem("PB","Relay","Switch", {bass = true})

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
    self.Train:LoadSystem("AV1","Relay","VA21-29")
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
    self.Train:LoadSystem("A77","Relay","VA21-29")
    self.Train:LoadSystem("A78","Relay","VA21-29")
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
    self.Train:LoadSystem("AV3","Relay","VA21-29",{bass=true,normally_closed=false})
    self.Train:LoadSystem("AV4","Relay","VA21-29")
    self.Train:LoadSystem("AV5","Relay","VA21-29")
    self.Train:LoadSystem("AV6","Relay","VA21-29")
    self.Train:LoadSystem("A55","Relay","VA21-29")
    self.Train:LoadSystem("A57","Relay","VA21-29")
    self.Train:LoadSystem("A60","Relay","VA21-29")
    self.Train:LoadSystem("A81","Relay","VA21-29")
    self.Train:LoadSystem("A7","Relay","VA21-29")
    self.Train:LoadSystem("A9","Relay","VA21-29")
    self.Train:LoadSystem("A68","Relay","VA21-29")
    self.Train:LoadSystem("A72","Relay","VA21-29")

    self.Train:LoadSystem("AIS","Relay","VA21-29")

    --ПУАВ автоматы
    self.Train:LoadSystem("A58","Relay","VA21-29")
    self.Train:LoadSystem("A59","Relay","VA21-29")
    self.Train:LoadSystem("A61","Relay","VA21-29")

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
    self.Train:LoadSystem("L_5","Relay","VA21-29",{bass = true})
    self.Train:LoadSystem("DoorSelect","Relay","Switch", { bass = true, normally_closed = false })
    self.Train:LoadSystem("VZ1","Relay","Switch", {bass = true})

    self.Train:LoadSystem("Wiper","Relay","Switch")

    self.Train:LoadSystem("OhrSig","Relay","Switch", {bass = true, normally_closed = true})
    self.Train:LoadSystem("VSOSD","Relay","Switch", {bass = true})

    self.Train:LoadSystem("PVK","Relay","Switch",{maxvalue=2,bass=true})

    -- Map of AV switches to indexes on panel
    self:InitializeAVMap()

    self.V1 = 0
    self.LUDS = 0
    self.RedLight2 = 0
    self.RedLight1 = 0
    self.Headlights1 = 0
    self.Headlights2 = 0
    self.EqLights = 0
    self.CabLights = 0
    self.EqLights = 0
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
    self.LKVP = 0
    self.RZP = 0
    self.KUP = 0
    self.BrT = 0
    self.LSN = 0
    self.Ring = 0
    self.SD = 0
    self.LST = 0
    self.LKVD = 0
    self.LVD = 0
    self.LhRK = 0
    self.KVC = 0
    self.SD = 0
    self.TW18 = 0
    self.OhrSig = 0
    self.SOSD = 0
    self.KT = 0
    self.M8 = 0
    self.AnnouncerPlaying = 0
    self.AnnouncerBuzz = 0
    self.UPOPower = 0

    self.VPR = 0
    self.BURPower = 0

    self.NMLow = 0
    self.UAVATriggered = 0
end

function TRAIN_SYSTEM:ClientInitialize()
    self:InitializeAVMap()
end

function TRAIN_SYSTEM:Outputs()
    return { "V1","LUDS","RedLight2","RedLight1","Headlights1","Headlights2","EqLights","CabLights","EqLights","PanelLights","CabinLight","EmergencyLights","MainLights","DoorsLeft","DoorsRight","DoorsW","GreenRP","BrW","AVU","LKVP","RZP","KUP","BrT","LSN","Ring","SD","LST","LKVD","LVD","LhRK","KVC","SD","TW18","KT","OhrSig","SOSD","AnnouncerPlaying","AnnouncerBuzz","UPOPower","M8","VPR","BURPower","NMLow","UAVATriggered" }
end

function TRAIN_SYSTEM:InitializeAVMap()
    self.AVMap = {
          61,55,54,56,27,21,10,53,43,45,42,41,
        "VU",64,63,50,51,23,14,75, 1, 2, 3,17,
          62,29, 5, 6, 8,20,25,22,30,39,44,80,
          65,"L_5",24,32,31,16,13,12, 7, 9,46,47
    }
end

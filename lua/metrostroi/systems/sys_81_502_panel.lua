--------------------------------------------------------------------------------
-- 81-502 controller panel
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_502_Panel")

function TRAIN_SYSTEM:Initialize()
    -- Выключатель батареи (ВБ)
    self.Train:LoadSystem("VB","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VBA","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VR","Relay","Switch", {bass = true})
    self.Train:LoadSystem("AV","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VRD","Relay","Switch", {bass = true})

    self.Train:LoadSystem("VRU","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KAD","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KAH","Relay","Switch", {bass = true})
    self.Train:LoadSystem("OVT","Relay","Switch", {bass = true,normally_closed = true})
    self.Train:LoadSystem("KSD","Relay","Switch", {bass = true}) --???
    self.Train:LoadSystem("KPVU","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VKF","Relay","Switch", {bass = true})

    self.Train:LoadSystem("VU","Relay","Switch", {bass = true,normally_closed = true})

    self.Train:LoadSystem("VU1","Relay","Switch", {bass = true}) --Heater
    self.Train:LoadSystem("VU2","Relay","Switch", {bass = true}) --EmergencyLights
    self.Train:LoadSystem("VU3","Relay","Switch", {bass = true}) --CabLights

    self.Train:LoadSystem("KOS","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VZP","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VZD","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KRZD","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KDL","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KDLK","Relay","Switch", {bass = true})
    self.Train:LoadSystem("LOn","Relay","Switch", {bass = true})
    self.Train:LoadSystem("LOff","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VozvratRP","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KSN","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KDP","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KDPK","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VMK","Relay","Switch", {bass = true})
    self.Train:LoadSystem("Ring","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VUS","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VAK","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VAKK","Relay","Switch", {bass = true})
    self.Train:LoadSystem("Autodrive","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VUD","Relay","Switch", {bass = true,normally_closed=true})
    -- Педаль бдительности (ПБ)
    self.Train:LoadSystem("PB","Relay","Switch", {bass = true})

    self.Train:LoadSystem("R_UPO","Relay","Switch", {bass = true})

    self.Train:LoadSystem("ALS","Relay","Switch", {bass = true})
    self.Train:LoadSystem("ARS","Relay","Switch", {bass = true})
    self.Train:LoadSystem("Headlights","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VSOSD","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KB","Relay","Switch", {bass = true})

    self.Train:LoadSystem("VDL","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KDPH","Relay","Switch", {bass = true})

    self.Train:LoadSystem("RCARS","Relay","Switch", {bass = true,normally_closed = true})
    self.Train:LoadSystem("RCBPS","Relay","Switch", {bass = true,normally_closed = true})

    self.Train:LoadSystem("RCAV4","Relay","Switch", {bass = true,normally_closed = true})
    self.Train:LoadSystem("RCAV3","Relay","Switch", {bass = true,normally_closed = true})
    self.Train:LoadSystem("RCAV5","Relay","Switch", {bass = true,normally_closed = true})

    self.Train:LoadSystem("PanelLamp","Relay","Switch", {bass = true, normally_closed=true})

    self.V1 = 0

    self.S4 = 0
    self.S5 = 0
    self.S20 = 0
    self.S6 = 0
    self.S1 = 0
    self.S1P = 0
    self.S3 = 0
    self.S2 = 0
    self.SSN = 0
    self.SSD = 0
    self.SDT = 0
    self.LMK = 0
    self.L16 = 0
    self.LRU = 0
    self.TW18 = 0
    self.RD = 0

    self.Headlights1 = 0
    self.Headlights2 = 0
    self.RedLights = 0
    self.EmergencyLights1 = 0
    self.EmergencyLights2 = 0
    self.MainLights1 = 0
    self.MainLights2 = 0
    self.PanelLights = 0

    self.SOSD = 0

    self.Ring = 0

    self.BrY = 0
    self.DoorsW = 0
    self.DoorsWC = 0
    self.GreenRP = 0

    self.VPR = 0

    self.NMLow = 0
    self.UAVATriggered = 0

    self.AnnouncerPlaying = 0
    self.UPOPower = 0
end

function TRAIN_SYSTEM:Outputs()
    return { "V1","GreenRP","S4","S5","S20","S6","S1","S1P","S3","S2","SSN","SSD","SDT","LMK","L16","LRU","TW18","Headlights1","Headlights2","RedLights","EmergencyLights1","EmergencyLights2","MainLights1","MainLights2","Ring","BrY","DoorsW","DoorsWC","SOSD","VRD","RD","NMLow","UAVATriggered","VPR","AnnouncerPlaying","UPOPower"}
end

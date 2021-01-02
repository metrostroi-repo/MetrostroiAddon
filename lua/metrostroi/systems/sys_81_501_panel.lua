--------------------------------------------------------------------------------
-- 81-501 controller panel
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_501_Panel")

function TRAIN_SYSTEM:Initialize()
    -- Выключатель батареи (ВБ)
    self.Train:LoadSystem("VB","Relay","Switch", {bass = true})
    self.Train:LoadSystem("AV","Relay","Switch", {bass = true})

    self.Train:LoadSystem("KSD","Relay","Switch", {bass = true}) --???
    self.Train:LoadSystem("KPVU","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VKF","Relay","Switch", {bass = true})

    self.Train:LoadSystem("VU","Relay","Switch", {bass = true})

    self.Train:LoadSystem("VU1","Relay","Switch", {bass = true}) --Heater
    self.Train:LoadSystem("VU2","Relay","Switch", {bass = true}) --EmergencyLights
    self.Train:LoadSystem("VU3","Relay","Switch", {bass = true}) --CabLights

    self.Train:LoadSystem("KRZD","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KDL","Relay","Switch", {bass = true})
    self.Train:LoadSystem("LOn","Relay","Switch", {bass = true})
    self.Train:LoadSystem("LOff","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VozvratRP","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KSN","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KDP","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VMK","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VUS","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VUD","Relay","Switch", {bass = true})

    self.Train:LoadSystem("VDL","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KDPH","Relay","Switch", {bass = true})

    self.Train:LoadSystem("PanelLamp","Relay","Switch", {bass = true, normally_closed=true})

    self.V1 = 0

    self.S6 = 0
    self.S1 = 0
    self.S2 = 0
    self.SSN = 0
    self.SSD = 0
    self.TW18 = 0

    self.Headlights1 = 0
    self.Headlights2 = 0
    self.RedLights = 0
    self.EmergencyLights1 = 0
    self.EmergencyLights2 = 0
    self.MainLights1 = 0
    self.MainLights2 = 0

    self.BrY = 0
    self.DoorsW = 0
    self.DoorsWC = 0
    self.GreenRP = 0

    self.AnnouncerPlaying = 0
    self.UPOPower = 0
end

function TRAIN_SYSTEM:Outputs()
    return { "V1","GreenRP","S6","S1","S2","SSN","SSD","TW18","Headlights1","Headlights2","RedLights","EmergencyLights1","EmergencyLights2","MainLights1","MainLights2","BrY","DoorsW","DoorsWC","AnnouncerPlaying","UPOPower"}
end

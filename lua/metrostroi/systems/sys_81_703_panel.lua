--------------------------------------------------------------------------------
-- 81-703 controller panel
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_703_Panel")

function TRAIN_SYSTEM:Initialize()
    -- Выключатель батареи (ВБ)
    self.Train:LoadSystem("VB","Relay","Switch", {bass = true})
    self.Train:LoadSystem("AV","Relay","Switch", {bass = true})

    self.Train:LoadSystem("VU","Relay","Switch", {bass = true,normally_closed = true})

    self.Train:LoadSystem("VU1","Relay","Switch", {bass = true}) --Heater
    self.Train:LoadSystem("VU2","Relay","Switch", {bass = true}) --EmergencyLights
    self.Train:LoadSystem("VU3","Relay","Switch", {bass = true}) --CabLights
    -- Buttons on the panel
    self.Train:LoadSystem("KU1","Relay","Switch", {bass = true}) --MK
    self.Train:LoadSystem("KU2","Relay","Switch", {bass = true}) --VUD1
    self.Train:LoadSystem("KU3","Relay","Switch", {bass = true,normally_closed = true}) --VUD2
    self.Train:LoadSystem("KU4","Relay","Switch", {bass = true}) --Lights on
    self.Train:LoadSystem("KU5","Relay","Switch", {bass = true}) --Lights off
    self.Train:LoadSystem("KU6","Relay","Switch", {bass = true}) --KDL
    self.Train:LoadSystem("KU7","Relay","Switch", {bass = true}) --KDP
    self.Train:LoadSystem("KU6K","Relay","Switch", {bass = true}) --KDLK
    self.Train:LoadSystem("KU7K","Relay","Switch", {bass = true}) --KDPK
    self.Train:LoadSystem("KU8","Relay","Switch", {bass = true}) --KSN
    self.Train:LoadSystem("KU9","Relay","Switch", {bass = true}) --Vozvrat RP
    self.Train:LoadSystem("KU10","Relay","Switch", {bass = true}) --KRZD
    self.Train:LoadSystem("KU11","Relay","Switch", {bass = true}) --Door sig
    self.Train:LoadSystem("KU12","Relay","Switch", {bass = true}) --Scepleniye
    self.Train:LoadSystem("KU13","Relay","Switch", {bass = true}) --Left doors2
    self.Train:LoadSystem("KU15","Relay","Switch", {bass = true}) --RezMK
    self.Train:LoadSystem("KU16","Relay","Switch", {bass = true}) --Headlights

    self.Train:LoadSystem("RCU","Relay","Switch", {bass = true})

    self.Train:LoadSystem("OtklAVU","Relay","Switch", {bass = true})

    self.Train:LoadSystem("R_UNch","Relay","Switch", {bass = true})
    self.Train:LoadSystem("R_ZS","Relay","Switch", {bass = true})
    self.Train:LoadSystem("R_G","Relay","Switch", {bass = true})
    self.Train:LoadSystem("R_Radio","Relay","Switch", {bass = true})
    self.Train:LoadSystem("R_Program1","Relay","Switch", {bass = true})
    self.Train:LoadSystem("R_Program2","Relay","Switch", {bass = true})

    self.Train:LoadSystem("RST","Relay","Switch", {bass = true, normally_closed=true})

    self.Train:LoadSystem("PanelLamp","Relay","Switch", {bass = true, normally_closed=true})

    self.V1 = 0
    self.TW1 = 0
    self.GRP = 0
    self.RRP = 0
    self.TW18 = 0
    self.SD = 0
    self.PP1 = 0
    self.PP6 = 0
    self.SDW = 0
    self.Headlights1 = 0
    self.Headlights2 = 0
    self.RedLights = 0
    self.EmergencyLights2 = 0
    self.EmergencyLights1 = 0
    self.MainLights1 = 0
    self.MainLights2 = 0
    self.PanelLights = 0

    self.Ring = 0
    self.AVU = 0

    self.VPR = 0

    self.AnnouncerPlaying = 0

    self.PCBKPower = 0

    self.BrY = 0
end

function TRAIN_SYSTEM:ClientInitialize()
end

function TRAIN_SYSTEM:Outputs()
    return { "V1","GRP","RRP","TW18","SD","PP1","PP6","SDW","BrY","Headlights1","Headlights2","RedLights","EmergencyLights2","EmergencyLights1","MainLights1","MainLights2","PanelLights","AnnouncerPlaying","VPR","Ring","AVU","CBKIPower","PCBKPower"}
end
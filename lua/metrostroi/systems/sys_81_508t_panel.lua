--------------------------------------------------------------------------------
-- 81-508t controller panel
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_508T_Panel")

function TRAIN_SYSTEM:Initialize()
    -- Выключатель батареи (ВБ)
    self.Train:LoadSystem("VB","Relay","VB-11", {bass = true})

    -- Buttons on the panel
    self.Train:LoadSystem("V4","Relay","Switch", {bass = true}) --LOn
    self.Train:LoadSystem("V5","Relay","Switch", {bass = true}) --LOff
    self.Train:LoadSystem("KU9","Relay","Switch", {bass = true}) --VRP
    self.Train:LoadSystem("KU15","Relay","Switch", {bass = true}) --RezMK
    self.Train:LoadSystem("V1","Relay","Switch", {bass = true}) --VMK
    self.Train:LoadSystem("VU14","Relay","Switch", {bass = true}) --VUS
    self.Train:LoadSystem("V2","Relay","Switch", {bass = true }) --VDL1
    self.Train:LoadSystem("V3","Relay","Switch", { normally_closed = true, bass = true }) --VDL2
    self.Train:LoadSystem("V6","Relay","Switch", {bass = true}) --VDL
    self.Train:LoadSystem("KU12","Relay","Switch", {bass = true}) --KDL
    self.Train:LoadSystem("KU7","Relay","Switch", {bass = true}) --KDP
    self.Train:LoadSystem("V10","Relay","Switch", {bass = true}) --KRZD
    self.Train:LoadSystem("KU8","Relay","Switch", {bass = true}) --KSN
    self.Train:LoadSystem("KU11","Relay","Switch", {bass = true}) --KSD

    -- Автоматические выключатели (АВ)
    self.Train:LoadSystem("VU1","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VU2","Relay","Switch", {bass = true,  normally_closed = true})
    self.Train:LoadSystem("VU3","Relay","Switch", {bass = true})
    self.Train:LoadSystem("AV","Relay","Switch", {bass = true})
    self.Train:LoadSystem("VU","Relay","Switch", {bass = true, normally_closed = false})


    self.V1 = 0
    self.GRP = 0
    self.RRP = 0
    self.TW18 = 0
    self.SD = 0
    self.Headlights1 = 0
    self.Headlights2 = 0
    self.RedLights = 0
    self.EmergencyLights2 = 0
    self.EmergencyLights1 = 0
    self.MainLights1 = 0
    self.MainLights2 = 0
    self.PanelLights = 0
    self.GaugeLights = 0

    self.AnnouncerPlaying = 0

    self.BatteryVoltmeter = 0

    self.PCBKPower = 0
end

function TRAIN_SYSTEM:Outputs()
    return {"V1","GRP","RRP","TW18","SD","Headlights1","Headlights2","RedLights","EmergencyLights2","EmergencyLights1","MainLights1","MainLights2","PanelLights","GaugeLights","AnnouncerPlaying","BatteryVoltmeter","PCBKPower"}
end
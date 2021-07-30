--------------------------------------------------------------------------------
-- 81-508 controller panel
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2019 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_509_Panel")

function TRAIN_SYSTEM:Initialize()
    -- Выключатель батареи (ВБ)
    self.Train:LoadSystem("VB","Relay","Switch", {bass = true})
    self.Train:LoadSystem("AV","Relay","Switch", {bass = true})

    self.Train:LoadSystem("VU","Relay","Switch", {bass = true,normally_closed = true})

    self.Train:LoadSystem("VU1","Relay","Switch", {bass = true}) --Heater
    self.Train:LoadSystem("VU2","Relay","Switch", {bass = true}) --EmergencyLights
    self.Train:LoadSystem("VU3","Relay","Switch", {bass = true}) --CabLights

    -- Buttons on the panel
    self.Train:LoadSystem("DoorSelect","Relay","Switch", {bass = true, normally_closed = false })
    self.Train:LoadSystem("KU4","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KU5","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KU9","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KU14","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KU15","Relay","Switch", {bass = true})
    self.Train:LoadSystem("UV1","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KU1","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KU16","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KU2","Relay","Switch", {bass = true })
    self.Train:LoadSystem("KU3","Relay","Switch", { normally_closed = true, bass = true }) -- Doors close
    self.Train:LoadSystem("KU3L","Relay","Switch", { bass = true }) -- Doors close
    self.Train:LoadSystem("KU13","Relay","Switch", {bass = true}) -- Doors left open
    self.Train:LoadSystem("KU6","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KU7","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KU10","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KU10R","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KU8","Relay","Switch", {bass = true})
    self.Train:LoadSystem("KU11","Relay","Switch", {bass = true}) --Door sig

    self.Train:LoadSystem("KRR","Relay","Switch", {bass = true})

    self.Train:LoadSystem("OtklAVU","Relay","Switch", {bass = true})

    self.Train:LoadSystem("R_Program1","Relay","Switch", {bass = true})
    self.Train:LoadSystem("R_Program1H","Relay","Switch", {bass = true})
    self.Train:LoadSystem("R_Program2H","Relay","Switch", {bass = true})

    self.Train:LoadSystem("RST","Relay","Switch", {bass = true, normally_closed = true})
    self.Train:LoadSystem("50V","Relay","Switch", {bass = true, normally_closed = true})
    self.Train:LoadSystem("HPass","Relay","Switch", {bass = true}) --Door sig



    -- Педаль бдительности (ПБ)
    self.Train:LoadSystem("KU6K","Relay","Switch", {bass = true,  normally_closed = true})

    self.Train:LoadSystem("PanelLamp","Relay","Switch", {bass = true, normally_closed=true})

    self.V1 = 0
    self.GRP = 0
    self.RRP = 0
    self.TW18 = 0
    self.SD = 0
    self.UKS = 0
    self.UKSb = 0
    self.Headlights1 = 0
    self.Headlights2 = 0
    self.RedLights = 0
    self.EmergencyLights2 = 0
    self.EmergencyLights1 = 0
    self.MainLights1 = 0
    self.MainLights2 = 0
    self.Ring = 0
    self.AVU = 0

    self.VPR = 0

    self.AnnouncerPlaying = 0

    self.CBKIPower = 0
    self.PCBKPower = 0
end

function TRAIN_SYSTEM:Outputs()
    return { "V1","GRP","RRP","TW18","SD","UKS","UKSb","Headlights1","Headlights2","RedLights","EmergencyLights2","EmergencyLights1","MainLights1","MainLights2","Ring","AVU","VPR","AnnouncerPlaying","CBKIPower","PCBKPower" }
end

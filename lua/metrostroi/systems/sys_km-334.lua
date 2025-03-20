--------------------------------------------------------------------------------
-- KM 334 (Author: Blue Snooty)
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("KM334")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.PistonSens             = 0.2   -- bar
    self.PistonState            = 0     -- 0 - down (shut); 1 - up (opened)
    self.HandlePosition         = 1
    self.InputPres              = 0.0
    self.ReduOutPres            = 0.0
    self.OutPres                = 0.0
    self.ReduInpPres            = 0.0
    self.ResvPres               = 0.0
    self.ValvT                  = 0     -- TLDisconnect repeater
    self.ValvB                  = 0     -- BLDisconnect repeater
    self.TLineVol               = 420   -- volume in litres
    self.BLineVol               = 29    -- 81-717(714) — 29 l, E type — 38 l
    self.EqResVol               = 9.5
    self.ReduSetpoint           = 5.0

    self.Cham_H =   {
        pressure        = 0.0,
        volume          = 0.1,
        mass            = 0,
        dP              = 0.0,
    }
    self.Cham_T =   {
        pressure        = 0.0,
        volume          = 0.1,
        mass            = 0,
        dP              = 0.0,
    }
    self.Cham_UR =  {
        pressure        = 0.0,
        volume          = 9.5,
        mass            = 0,
        dP              = 0.0,
    }
    self.Cham_3K =  {
        pressure        = 0.0,
        volume          = 0.2,
        mass            = 0,
        dP              = 0.0,
    }
    self.Cham_Ex =  {
        pressure        = 0.0,
        volume          = 1e12,
        mass            = 0,
        dP              = 0.0,
    }

    self.OldHandlePosition      = self.HandlePosition
end

-- slide valve matrix
TRAIN_SYSTEM.SlideValve = {
    [1]      = {"Cham_H Cham_T 0.002", "Cham_H Cham_UR 0.0005"--[["Cham_H Cham_3K 0.01"]]},
    [2]      = {--[["Cham_H Cham_3K 0.05",]] "Cham_T Cham_UR 0.08"},
    [3]      = {},
    [4]      = {"Cham_UR Cham_Ex 0.05"},
    [5]      = {"Cham_T Cham_Ex 0.2","Cham_UR Cham_Ex 0.25","Cham_3K Cham_Ex 0.2"},
}

function TRAIN_SYSTEM:Outputs()
	return {"OutPres", "ReduInpPres", "MainRelease", "SideRelease", "ResvPres", "PistonState"}
end

function TRAIN_SYSTEM:Inputs()
	return {"InputPres", "HandlePosition", "ReduSetpoint", "ReduOutPres", "TLineVol", "BLineVol", "EqResVol", "ValvT", "ValvB"}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if self[name] then
        self[name] = value
    end
end

function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train

    if Train.Pneumatic.ValveType ~= 1 then
        if not self.KMSndOff then
            SetSoundState("crane334_brake_eq_high",0,1)
            SetSoundState("crane334_brake_eq_low",0,1)
            SetSoundState("crane334_release",0,1)
            SetSoundState("crane334_release_2",0,1)
            self.KMSndOff = true
        end
        return
    end

    self.KMSndOff = false
    self.Cham_H.dP = 0.0
    self.Cham_T.dP = 0.0
    self.Cham_UR.dP = 0.0
    self.Cham_3K.dP = 0.0
    self.Cham_H.dP = 0.0

    if self.HandlePosition ~= self.OldHandlePosition then
        -- reset working chambers pointers tables
        self.ch1 = {}
        self.ch2 = {}
        self.ch3 = {}
        for k,v in ipairs(self.SlideValve[self.HandlePosition]) do
            local cp, p = v:match("(%g+)()")
            self.ch1[k] = self[cp]
            cp, p = v:match("(%g+)()", p)
            self.ch2[k] = self[cp]
            self.ch3[k] = tonumber(v:match("%d+%.%d+",p))
        end
        self.OldHandlePosition = self.HandlePosition
    end

    -- main chambers process (through sliding valve)
    self.Cham_H.pressure = self.ValvT > 0 and self.InputPres or self.Cham_H.pressure
    self.Cham_H.volume = self.ValvT > 0 and self.TLineVol or 0.1
    self.Cham_T.pressure = self.ValvB > 0 and self.OutPres or self.Cham_T.pressure
    self.Cham_T.volume = self.ValvB > 0 and self.BLineVol or 0.1
    self.Cham_UR.volume = self.EqResVol
    self.Cham_Ex.pressure = 0
    for i = 1,#self.ch1 do
        local dP = self.ch1[i].pressure - self.ch2[i].pressure
        self.ch1[i].dP = dP
        if dP > 0.1 then
            self.ch1[i].mass = self.ch1[i].pressure*self.ch1[i].volume
            local dPV = self.ch1[i].mass*dT*dP*self.ch3[i]
            self.ch1[i].mass = math.max(0,self.ch1[i].mass - dPV)
            self.ch2[i].mass = math.max(0,self.ch2[i].mass + dPV)
        elseif dP < -0.1 then
                self.ch2[i].mass = self.ch2[i].pressure*self.ch2[i].volume
                local dPV = self.ch2[i].mass*dT*dP*self.ch3[i]
                self.ch2[i].mass = math.max(0,self.ch2[i].mass + dPV)
                self.ch1[i].mass = math.max(0,self.ch1[i].mass - dPV)
        end
        self.ch1[i].pressure = math.min(self.InputPres,self.ch1[i].mass/self.ch1[i].volume)
        self.ch2[i].pressure = math.min(self.InputPres,self.ch2[i].mass/self.ch2[i].volume)
    end
    --[[
    ---------------debug---------------------
    self.dlreadtimer = self.dlreadtimer or CurTime()
    if CurTime() - self.dlreadtimer > 0.5 then
        self.dlreadtimer = CurTime()
        if Train:GetDriver() then
            for i = 1,#self.ch1 do
                PrintMessage(HUD_PRINTTALK, Format("Cham_3K.mass = %.2f; Cham_T.mass = %.2f; Cham_UR.mass = %.2f",self.Cham_3K.mass,self.Cham_T.mass,self.Cham_UR.mass))
                PrintMessage(HUD_PRINTTALK, Format("Cham_3K.pressure = %.2f; Cham_T.pressure = %.2f; Cham_UR.pressure = %.2f",self.Cham_3K.pressure,self.Cham_T.pressure,self.Cham_UR.pressure))
            end
            PrintMessage(HUD_PRINTTALK, "-------------------------------------------------------------------------------")
        end
    end
    ---------------debug---------------------]]
    local dPiston = self.Cham_T.pressure - self.Cham_UR.pressure
    if dPiston >= 0.2 then
        self.PistonState = 1
    elseif dPiston < 0.08 then
        self.PistonState = 0
    end

    -- braking chamber discharge through side release valve
    if self.PistonState == 1 and self.Cham_T.pressure > 0 then
        local dP = 15*self.Cham_T.pressure*dT/self.Cham_T.volume
        self.Cham_T.pressure = math.max(0,self.Cham_T.pressure - dP)
        self.Cham_T.dP = self.Cham_T.dP + dP
    end

    -- pneumatic reducer 348 work
    if self.HandlePosition == 2 then
        if self.Cham_T.pressure - self.ReduSetpoint < 0 then
            local dP = self.Cham_H.pressure - self.Cham_T.pressure
            if dP > 0 then
                --self.ch1[i].mass = self.ch1[i].pressure*self.ch1[i].volume
                local dPV = self.Cham_H.mass*dT*dP*0.001
                self.Cham_H.mass = math.max(0,self.Cham_H.mass - dPV)
                self.Cham_T.mass = math.max(0,self.Cham_T.mass + dPV)
            end
            self.Cham_H.pressure = math.min(self.InputPres,self.Cham_H.mass/self.Cham_H.volume)
            self.Cham_T.pressure = math.min(self.InputPres,self.Cham_T.mass/self.Cham_T.volume)
        end
    end
        ---[[
            ---------------debug---------------------
            self.dlreadtimer = self.dlreadtimer or CurTime()
            if CurTime() - self.dlreadtimer > 0.5 then
                self.dlreadtimer = CurTime()
                if Train:GetDriver() then
                    PrintMessage(HUD_PRINTTALK, Format("Cham_UR.pressure = %.2f; Cham_T.pressure = %.2f; OutPres = %.2f; Piston: %u",self.Cham_UR.pressure,self.Cham_T.pressure,self.OutPres,self.PistonState))
                end
            end
            ---------------debug---------------------]]
        --[[
            ---------------debug---------------------
            self.dlreadtimer2 = self.dlreadtimer2 or CurTime()
                   PrintMessage(HUD_PRINTTALK, Format("Вагон %u; BLineVol = %.2f;",Train:GetWagonNumber(),self.BLineVol))
                end
            end
            ---------------debug---------------------]]

    -- Piston leak
    local dP = self.Cham_UR.pressure - self.Cham_T.pressure
    local Pavg = (self.Cham_UR.pressure + self.Cham_T.pressure)/2
    if dP > 0 and self.Cham_UR.pressure > Pavg or dP < 0 and self.Cham_T.pressure < Pavg then
        self.Cham_UR.pressure = self.Cham_UR.pressure - 0.003*dP*dT/self.Cham_UR.volume
        self.Cham_T.pressure = self.Cham_T.pressure + 0.003*dP*dT/self.Cham_T.volume
    end

    self.OutPres = self.Cham_T.pressure
    self.ResvPres = self.Cham_UR.pressure

    Train:SetSoundState("crane334_brake_eq_high",self.Cham_UR.dP,1)
    Train:SetSoundState("crane334_brake_eq_low",self.Cham_H.dP,1)
    Train:SetSoundState("crane334_release",self.Cham_T.dP,1)
    Train:SetSoundState("crane334_release_2",self.Cham_3K.dP,1)
end
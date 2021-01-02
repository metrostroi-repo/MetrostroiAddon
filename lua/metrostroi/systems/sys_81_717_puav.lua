--------------------------------------------------------------------------------
-- 81-717 "PUAV" safety system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PUAV")
TRAIN_SYSTEM.DontAccelerateSimulation = false
function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("KH","Relay","Switch",{ bass = true })
    self.Train:LoadSystem("VAV","Relay","Switch",{ bass = true })
    self.Train:LoadSystem("KSZD","Relay","Switch",{ bass = true })
    self.Train:LoadSystem("VZP","Relay","Switch",{ bass = true })
    self.Train:LoadSystem("VAU","Relay","Switch",{ bass = true, normally_closed = true })
    self.Train:LoadSystem("RC2","Relay","Switch",{ bass = true, normally_closed = true })

    self.Train:LoadSystem("P1","Relay","Switch",{ bass = true })
    self.Train:LoadSystem("P2","Relay","Switch",{ bass = true })
    self.Train:LoadSystem("P3","Relay","Switch",{ bass = true })
    self.Train:LoadSystem("P4","Relay","Switch",{ bass = true })
    self.Train:LoadSystem("P5","Relay","Switch",{ bass = true })

    self.Selected = true

    self.KRRBrake = false
    self.LK16 = 0
    self.LAVT = 0
    self.LOS = 0
    self.LRS = 0
    self.LKI1 = 0
    self.LKI2 = 0

    self.NoFreq = 0
    self.F5 = 0
    self.F4 = 0
    self.F3 = 0
    self.F2 = 0
    self.F1 = 0
    self.LRSTimer = false
    self.OldF5 = 0
    self.OldNF = 0

    self["2"] = 0 --Вращение РК
    self["3"] = 0 --Ход 3
    self["8"] = 0 --Замещение электрического торможения
    self["16"] = 0 --Закрытие дверей
    self["17"] = 0  -- Разрешение восстановления реле перегрузки
    self["19"] = 0 -- Разрешение замещения электрического торможения
    self["20"] = 0 -- Включение двигателей
    self["20X"] = 0 -- Разрешение включения двигателей в ходовые режимы
    self["025"] = 0 -- Разрешение ручного торможения
    self["25"] = 0 -- Ручное торможение
    self["31"] = 0 --Открытие открытия левых дверей
    self["32"] = 0 --Открытие правых дверей
    self["33"] = 0 --Включение ходового режима
    self["033"] = 0 --Разрешение включения ходового режима
    self["33G"] = 0 --Включение режима торможения
    self["39"] = 0 --Включение вентиля замещения № 2
    self["48"] = 0 --Включение вентиля замещения № 1

    self.Power = 0
    self.ALSPower = 0
    self.KRH = 0
    self.KRT = 0
    self.KGR = 0
    self.KRR1 = 0 --Контроль нулевого положения реверсивной рукоятки головного вагона
    self.KRR2 = 0 --Контроль нулевого положения реверсивной рукоятки хвостового вагона
    self.KRR3 = 0 --Контроль реверсивной рукоятки, установленной в положение «Назад»
    self.KD = 0
    self.KPRK = 0
    self.KOAT = 0
    self.KET = 0
    self.KSOT = 0
    self.KDL = 0
    self.KDP = 0
    self.RK1 = 0
    self.KRU = 0

    self.KVARS = 0
    self.KTARS = 0
    self.VAV = 0
    self.KH3 = 0
    self.VZP = 0
    self.KSZD = 0
    self.KB = 0
    self.RD = 0

    self.TargetKPRK = 1

    self.Ring = 0
    self.RingZero = 0

    self.State = -1

    --self:SetDriveMode = "Zero"
    --self.CurrentDoorMode = "DO"
    --self.CurrentPneumoMode = "NT"
end


--if TURBOSTROI then return end
function TRAIN_SYSTEM:Inputs()
    return {
        --Autodrive commands
        "CommandDoorsLeft","CommandDoorsRight",
        "CommandDrive", "CommandBrake","CommandBrakeCount","CommandBrakeElapsed"
    }
end
function TRAIN_SYSTEM:Outputs()
    return { "Ring","RingZero","LK16" , "LAVT", "LOS", "LRS", "LKI1", "LKI2", "NoFreq", "F5", "F4", "F3", "F2", "F1", "TargetKPRK" }
end

if CLIENT then
    local function createFont(name,font,size)
        surface.CreateFont("Metrostroi_"..name, {
            font = font,
            size = size,
            weight = 500,
            blursize = false,
            antialias = true,
            underline = false,
            italic = false,
            strikeout = false,
            symbol = false,
            rotary = false,
            shadow = false,
            additive = false,
            outline = false,
            extended = true,
            scanlines = false,
        })
    end
    createFont("PUAV","Liquid Crystal Display",38,400)
    function TRAIN_SYSTEM:ClientThink()
        if not self.Train:ShouldDrawPanel("PUAVOScreen") and not self.Train:ShouldDrawPanel("PUAVNScreen") then return end
        --RunConsoleCommand("say","президент!!!")
        if not self.DrawTimer then
        render.PushRenderTarget(self.Train.PUAV,0,0,512, 128)
            render.Clear(0, 0, 0, 0)
            render.PopRenderTarget()
        end
        if self.DrawTimer and CurTime()-self.DrawTimer < 0.1 then return end
        self.DrawTimer = CurTime()
        render.PushRenderTarget(self.Train.PUAV,0,0,512, 128)
        --render.Clear(0, 0, 0, 0)
        cam.Start2D()
            self:PUAVScreen(self.Train)
        cam.End2D()
        render.PopRenderTarget()
    end
    function TRAIN_SYSTEM:PrintText(x,y,text,inverse)
        local str = {utf8.codepoint(text,1,-1)}
        for i=1,#str do
            local char = utf8.char(str[i])
            if inverse then
                draw.SimpleText(string.char(0x7f),"Metrostroi_PUAV",(x+i)*27+15,y*50+30,Color(0,0,0,240),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText(char,"Metrostroi_PUAV",(x+i)*27+15,y*50+30,Color(140,190,0,150),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            else
                draw.SimpleText(char,"Metrostroi_PUAV",(x+i)*27+15,y*50+30,Color(0,0,0,240),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            end
        end
    end

    function TRAIN_SYSTEM:PUAVScreen(Train)
        local State = Train:GetNW2Bool("BURPower",false)
        if State then
            surface.SetDrawColor(75*0.8,165*0.8,0,self.Warm and 130 or 0)
            self.Warm = true
        else
            surface.SetDrawColor(20,50,0,150)
            self.Warm = false
        end
        surface.DrawRect(0,0,512,128)
        if not State then
            return
        end
        surface.SetDrawColor(75*0.3,165*0.3,0,35)
        for x=1,16 do
            for y=0,1 do
                surface.DrawRect(x*27+3,y*50+12,26,40)
            end
        end
        if Train:GetNW2Bool("SBPP:Debug") then
            self:PrintText(0,0,Train:GetNW2String("SBPP:Str1","Not available"))
            self:PrintText(0,1,Train:GetNW2String("SBPP:Str2","Not available"))


            --[[ if CurTime()%1>0.5 then
                self:PrintText(0,0,"СКом П СТН РСТ")
                self:PrintText(0,1,Train:GetNW2String("SBPP:DCMD","Нет"))
            else
                self:PrintText(0,0,"ПКом П СТН РСТ")
                self:PrintText(0,1,Train:GetNW2String("SBPP:PCMD","Нет"))
            end
            self:PrintText(5,1,tostring(Train:GetNW2Int("SBPP:Path",0)))
            self:PrintText(7,1,tostring(Train:GetNW2Int("SBPP:Station",0)))
            self:PrintText(11,1,Format("%.1f",Train:GetNW2Int("SBPP:Distance",0)))--]]

            --self:PrintText(0,1,os.date("%H:%M:%S   %d/%m",Metrostroi.GetSyncTime()))
        else
            self:PrintText(-2+9,0,"БУР")

            self:PrintText(0,1,os.date("!%H:%M:%S   %d/%m",Metrostroi.GetSyncTime()))
        end
        --self:PrintText(0,0,"010101010101")
        --self:PrintText(1,1,Format("РК:%02d",Train:GetNW2Int("PUAV:RK",0)))
        --self:PrintText(1,1,"(точнее криво)")
    end
end

function TRAIN_SYSTEM:Trigger(name,nosnd)
end

TRAIN_SYSTEM.DriveModes = {
    --Priority  2   3   8  017  19  20 20X  25 025  33 033 33G
    X3   = {1,  1,  1,  0,  0,  1,  1,  1,  0,  1,  1,  1,  0},
    X2   = {2,  1,  0,  0,  0,  1,  1,  1,  0,  1,  1,  1,  0},
    X1   = {3,  0,  0,  0,  0,  1,  1,  1,  0,  1,  1,  1,  0},
    OD   = {4,  0,  0,  0,  1,  1,  0,  1,  0,  1,  0,  1,  0},
    OXT  = {5,  0,  0,  0,  1,  1,  0,  0,  0,  1,  0,  0,  0},
    ST   = {6,  0,  0,  0,  0,  0,  1,  0,  0,  1,  0,  0,  1},
    VPR  = {7,  1,  0,  0,  0,  0,  1,  0,  1,  1,  0,  0,  1},
    AT1  = {8,  1,  0,  0,  0,  1,  1,  0,  0,  0,  0,  0,  1},
    AT   = {9,  1,  0,  1,  0,  0,  1,  0,  0,  0,  0,  0,  1},
    Zero = {10, 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
}
function TRAIN_SYSTEM:SetDriveMode(curMode,override)
    local mode = self.DriveModes[curMode]
    if mode and mode[1] > self.CurrentDriveModePriority then
        self.CurrentDriveMode = mode
        self.CurrentDriveModePriority = mode[1]
        self.DriveMode = curMode
    end
end
TRAIN_SYSTEM.PneumoModes = {
    --Priority 39  48
    NT  = {1,  0,  0,},
    V1  = {2,  0,  1,},
    V2  = {3,  1,  0,},
}
function TRAIN_SYSTEM:SetDoorMode(curMode,override)
    local mode = self.DoorModes[curMode]
    self.CurrentDoorMode = mode
end
TRAIN_SYSTEM.DoorModes = {
    --    16  31  32
    ZD = {1,  0,  0,},
    DL = {0,  1,  0,},
    DP = {0,  0,  1,},
    DO = {0,  0,  0,},
}
function TRAIN_SYSTEM:SetPneumoMode(curMode,override)
    if curMode == "V2" and self.Train.ALSCoil.Speed > 10 then self.SpeedError = true return end
    local mode = self.PneumoModes[curMode]
    if mode and (override or mode[1] > self.CurrentPneumoModePriority) then
        self.CurrentPneumoMode = mode
        self.CurrentPneumoModePriority = mode[1]
    end
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "CommandBrakeElapsed" and self.KRR2 == 0 and self.KRR1 > 0 and value ~= -1 and self.CrossCount then
        if self.Stage1 and value > 1 then self.Stage2Prepared = true end

        if self.CrossCount > 10 then self.Station = true end
        self.CrossCount = self.CrossCount+1
        if value*1000 < 80+46+2*(8*1.5) then
            if not self.Stage1 and self.BrakeProgramm then
                self.Stage1 = true
                self:SetTargetKPRK(14)
            end
            if self.Stage2Prepared then
                self.Stage2 = true
            end
        end
        --if self.VAV > 0 then print(self.Stage1,self.Stage2Prepared,self.Stage2,value*1000) end
    end
    if name == "CommandBrake" and self.KRR2 == 0 and self.KRR1 > 0 then
        self.BrakeProgramm = self.LAVT > 0
        self.CommandDrive = false
        self.DriveCommand = false

        if self.TargetKPRK and self.LastBrakeProgrammLoss and CurTime()-self.LastBrakeProgrammLoss > 0.3 then self:SetTargetKPRK(self.TargetKPRK+1) end
        if value<0 then self:SetTargetKPRK(-value) end
        self.LastBrakeProgrammLoss = value == 0 and CurTime()
        if self.BrakeProgrammLossDistance and self.BrakeProgrammLossDistance>15 then
            self.BrakeProgrammCurrentDistance=0
        elseif value == 0 then
            self.BrakeProgrammLossDistance = 0
        end
        if value ~= 0 then
            self.CrossCount = 0
        else
            self.CrossCount = nil
        end
    end
    if name == "CommandDrive" then
        if value < 0 then
            self.CommandDrive = false
            self.DriveCommand = false
            self.BrakeProgramm = false
        elseif value > 0 then
            self.CommandDrive = value
        else
            self.CommandDrive = false
        end
    end
    if name == "CommandDoorsLeft" then self.DoorsLeft = value > 0 end
    if name == "CommandDoorsRight" then self.DoorsRight = value > 0 end
end

function TRAIN_SYSTEM:SetTargetKPRK(val)
    self.TargetKPRK = val
    self.LastKRPK = self.KPRK
end

local IgnoreDoors = false
function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    if Train.Electric.Type > 3 then return end
    self.CurrentDriveModePriority = 0
    self.CurrentPneumoModePriority = 0
    --if self.KB > 0 and not self.KBimer then self.KBimer = CurTime() end
    --if self.KB == 0 and self.KBimer then self.KBimer = nil end
    local ALS = Train.ALSCoil

    local Ring = false
    local LKI = false

    local speed = math.Round(ALS.Speed or 0,1)
    local speedMpS = speed*0.2778
    local speedMpSS = speedMpS*ALS.SpeedSign

    local Power = self.Power>0
    local Reverser = (self.KRR1 > 0 or self.KRU > 0)
    local BackReverser = self.KRR2 > 0
    if Power and not BackReverser and self.Checked==true and Reverser then
        --KPRK
        if self.RK1 > 0 then self.RKPos = 1 end

        local OS = ((1-self.KVARS))+(1-self.KSOT)--0
        local RS = (1-OS)*self.KVARS*self.KSOT--1
        local AV = RS*self.VAV
        local KB = self.KB > 0
        --
        local ALSSh = (1-Train.ALS.Value)*Train.VRD.Value
        self.F1 = ALS.F1*(1-ALSSh)*self.ALSPower
        self.F2 = ALS.F2*(1-ALSSh)*self.ALSPower
        self.F3 = ALS.F3*(1-ALSSh)*self.ALSPower
        self.F4 = ALS.F4*(1-ALSSh)*self.ALSPower
        self.F5 = ALS.F5*(1-ALSSh)*self.ALSPower
        self.F6 = ALS.F6*(1-ALSSh)*self.ALSPower
        self.NoFreq = (1-math.min(1,self.F5+self.F4+self.F3+self.F2+self.F1))*self.ALSPower
        local NoFreq = self.NoFreq+(1-self.ALSPower)
        if self.ALSPower==0 then LKI=true end
        --Find current speedlimit
        local Vz = 0
        if self.F4 > 0 then Vz = 40 end
        if self.F3 > 0 then Vz = 60 end
        if self.F2 > 0 then Vz = 70 end
        if self.F1 > 0 then Vz = 80 end

        local Station = self.Station and 1 or self.F6
        local Vno = -1

        if self.IgnorePedal and not KB then self.IgnorePedal = false end
        if (NoFreq > 0 and self.OldF5 > 0 or self.F5+self.F6 > 0 and self.OldNF > 0) and self.IgnorePedal then
            KB = false
        end
        self.OldF5 = self.F5+self.F6
        self.OldNF = NoFreq
        if OS > 0 then
            if KB and Vz <= 40 then Vno = 20 end
            if KB and Vz > 40 then Vno = 35 end
            if self.F5 > 0 and self.IgnoreF6 == nil then self.IgnoreF6 = true end
            if self.F5 > 0 and self.IgnoreF6 and speed < 0.1 and self.KGR > 0 then self.IgnoreF6 = false end
            if self.F5 == 0 and self.IgnoreF6 ~= nil then self.IgnoreF6 = nil end
        else
            self.IgnoreF6 = nil
            Vno = Vz
            if self.VRD > 0 and Vno > 20 then Vno = -1 end
            if KB and Vno < 40 or KB and Vno >= 40 then Vno = 20 end
            if self.F5 > 0 and (Station+self.VRD) == 0 then Vno = -1 end
        end
        if self.F5 > 0 and (not KB or Station+self.VRD == 0 or self.VRD > 0 and self.IgnoreF6) then Vno = -1 end
        if NoFreq > 0 and not KB then Vno = -1 end
        if self.VRD > 0 and Vno > 20 then Vno = 20 end
        if self.KVARS*self.KTARS > 0 then self:SetDriveMode("OXT") end

        local prior = self.CurrentDriveModePriority
        local Vo = speed + math.max(0,ALS.Acceleration*(1+self.KRH-self.KRT))
        local Vko = Vno-4
        if Vo > Vno then
            if not self.OXT then
                self.OXT = true
                self.OXTTimer = CurTime()

                if NoFreq > 0 or self.F5*self.KD > 0 then self.RingArmed = self.RingArmed  or speed>0.1 and CurTime() end
            end
            if (self.OXTTimer and CurTime()-self.OXTTimer > 1.5 or speed > Vno) and not self.ST then
                self.ST = true
                self.RingArmed = self.RingArmed  or speed>0.1 and CurTime()
                --if Vz > 40 then self.RingArmed = true end
            end
            if self.ST and not self.STTimer and self.KRT==0 then
                self.STTimer = CurTime()
            end
            if self.ST and (self.STTimer and CurTime()-self.STTimer > 1 and speed > Vno or not self.STTimer and self.KRT>0) then
                self.AT = true
            end
        end
        if Vo < Vno and self.OXT and not self.ST and self.KGR > 0 then
            if not self.OXTTimer or CurTime()-self.OXTTimer > 1.5 then
                self.OXTTimer = false
                self.OXT = false
            end
        end
        --if Vo < Vko and self.ST and not self.RingArmed then --KB then
        if Vo < Vno and self.ST and not self.RingArmed then --KB then
            self.ST = false
            self.STTimer = false
            self.AT = false
        end
        if KB and self.RingArmed then self.RingArmed = false end

        if self.AT then
            self:SetDriveMode("AT")
        elseif self.ST then
            self:SetDriveMode("ST")
        elseif self.OXT then
            self:SetDriveMode("OXT")
        end
        local NoStation = (not self.BrakeProgramm or not self.DoorsLeft or not self.DoorRight) and self.NoStationTimer
        if NoStation and not self.NoStationTimer then self.NoStationTimer = CurTime() end
        if self.NoStationTimer and not NoStation then self.NoStationTimer = nil end
        local ResetBrake = self.KGR==0 and speed>10 and self.NoStationTimer and CurTime()-self.NoStationTimer>1
        if not self.BrakeProgramm or ResetBrake then
            --self.BrakeProgrammLossDistance = false
            --self.BrakeProgrammCurrentDistance = false
            self.Stage0 = false
            self.Stage1 = false
            self.Stage1Timer = false
            self.Stage2Prepared = false
            self.Stage2 = false
            self.Stage3 = false
            self.LastBrakeProgrammLoss = false
            self.TargetKPRK = false
            if ResetBrake then
                self.Station = false
                self.NoStationTimer = false
            end
        end

        if self.BrakeProgrammLossDistance then self.BrakeProgrammLossDistance = self.BrakeProgrammLossDistance+speedMpS*dT end
        if self.BrakeProgrammLossDistance and self.BrakeProgrammLossDistance > 30 then self.BrakeProgrammLossDistance = false end
        if self.BrakeProgrammCurrentDistance then
            if self.StationBrakeRing == nil then
                self.StationBrakeRing = self.KRT == 0 and CurTime()
            end
            self.BrakeProgrammCurrentDistance = self.BrakeProgrammCurrentDistance+speedMpS*dT
        end
        if self.StationBrakeRing and CurTime()-self.StationBrakeRing > 3 then self.StationBrakeRing = false end
        if not self.BrakeProgrammCurrentDistance and self.StationBrakeRing == false then self.StationBrakeRing = nil end
        if self.BrakeProgramm then
            self:SetDriveMode("OXT")
            if AV > 0 then
                if self.KRH == 0 then
                    self:SetDriveMode("ST")
                    if not self.TargetKPRK then self.TargetKPRK = 1 end
                end
                if self.TargetKPRK and self.TargetKPRK > 1 and self.KPRK < self.TargetKPRK-0.5 then
                    local diff = self.TargetKPRK-self.KPRK
                    if diff <= 1.4 then
                        self.VPR = CurTime()
                    else
                        self:SetDriveMode("AT")
                        self.VPR = false --FIXME
                    end
                elseif self.TargetKPRK == 5 and self.Stage0 then
                    self.Stage1Timer = CurTime()
                end
                if self.VPR then
                    if CurTime()-self.VPR < 0.5 then
                        self:SetDriveMode("VPR")
                        --print("VPR",self.TargetKPRK,self.KPRK)
                    else
                        self.VPR = false
                    end
                end
                if self.Stage2 then
                    self:SetDriveMode("AT1")
                end
                if self.Stage2 and not self.BrakeProgramm then
                    self:SetPneumoMode("V1")
                end
                if self.Stage1Timer and CurTime()-self.Stage1Timer > 5 then
                    self.Stage1 = true
                    self:SetTargetKPRK(15)
                end
            else
                self.BrakeProgramm = false
            end
            if self.BrakeProgrammCurrentDistance then
                if not self.BrakeProgrammTargetDistance and speed<36 then self.BrakeProgrammTargetDistance=(130-6*speedMpS-2*8) end
                if self.BrakeProgrammTargetDistance and (self.BrakeProgrammTargetDistance) < self.BrakeProgrammCurrentDistance and self.TargetKPRK < 5 then
                    self:SetTargetKPRK(5)
                    self.Stage0 = true
                end
            end
        end
        if self.BrakeProgrammCurrentDistance and (not self.BrakeProgrammTargetDistance or self.BrakeProgrammCurrentDistance > self.BrakeProgrammTargetDistance) then
            self.BrakeProgrammCurrentDistance = false
            self.BrakeProgrammTargetDistance = false
        end
        --if self.KH3 > 0 then self.SpeedError = true end
        if self.SpeedError and speed < 0.1 then self.SpeedError = false end
        if self.SpeedError and not self.LoseVf then self.LoseVf = CurTime() end
        if not self.SpeedError and self.LoseVf then self.LoseVf = false end
        if self.LoseVf then
            local LTimer = CurTime()-self.LoseVf
            if LTimer >= 2.5 then
                self:SetDriveMode("AT1")
            elseif LTimer >= 1.5 then
                self:SetDriveMode("ST")
            else
                self:SetDriveMode("OXT")
            end
            LKI = true
        end
        self:SetPneumoMode("NT")
        local AntiRollingAccept = not self.Stage2 and (NoFreq==0 or self.KB==0)
        if AntiRollingAccept and speed < 3.6 and self.KRH == 0 or self.KRT==0 and self.STTimer and CurTime()-self.STTimer < 0.8 then
            self:SetPneumoMode("V1")
        end
        self.LRS = RS
        self.LAVT = AV
        self.LOS = OS

        if self.KGR == 0 and NoFreq == 0 then
            if self.AntiRolling == nil then
                self.AntiRolling = CurTime()
            end
        elseif self.AntiRolling == false then
            self.AntiRolling = nil
            self.AntiRollingCount = false
        end
        if self.AntiRolling and not self.AntiRollingCount then self.AntiRollingCount = 0 end
        if self.AntiRollingCount then self.AntiRollingCount = self.AntiRollingCount+speedMpSS*dT end
        if self.AntiRolling and (self.AntiRollingCount<-(AntiRollingAccept and 0.35 or 5) or CurTime()-self.AntiRolling > 6) then
            local time = CurTime()-self.AntiRolling-6

            if self.KGR == 1 and speed < 0.1 then
                self.AntiRolling = false
                self.AntiRollingCount = false
            end
            self:SetDriveMode("OXT")
            LKI = true
            if time > 7 then
                self:SetPneumoMode("V2")
            else
                self:SetPneumoMode("V1")
                Ring = time > 5 or time%1 > 0.5
            end
        elseif self.AntiRollingCount and self.AntiRollingCount > 0.5 and self.AntiRolling then
            self.AntiRolling = false
            self.AntiRollingCount = false
        end
        if self.F5 > 0 and self.F6 == 0 then
            if self.F5Timer == nil then self.F5Timer = CurTime() end
        else
            self.F5Timer = nil
        end
        if self.F5Timer and CurTime()-self.F5Timer > 30 then
            local time = CurTime()-self.F5Timer-30
            self.RingZero = time<8 and 1 or 0--time < 3 or time%1 > 0.5
            if time > 7 then self.F5Timer = false end
        else self.RingZero = 0 end

        local KD = self.KD>0
        if KD and not self.KDTimer then self.KDTimer = CurTime() end
        if not KD then self.KDTimer = false end
        if KD and self.KDTimer and CurTime()-self.KDTimer < 0.3 then KD=false end
        --print(self.KD)-- ,self.KD>0 , NoFreq == 0 , Vz > 20 , self.KSOT > 0 , self.VZP*self.VAV  > 0 , self.KRT == 0 , self.KRR3 == 0)
        --Autodrive drive commands control
        local CanDrive = KD and NoFreq == 0 and Vz > 20 and self.KSOT > 0 and self.VZP*self.VAV  > 0 and self.KRT == 0 and self.KRR3 == 0 and self.KDCycle -- and self.KGR > 0 or speed > 0.1)
        local commandDrive = math.max(self.CommandDrive or 0,self.KH3*3--[[ *(Vz > 40 and 3 or 2)--]] ,self.DriveCommand or 0)
        if self.KH3*self.VAV>0 and self.KDOffTimer then
            self.CommandDrive = 3--Vz > 40 and 3 or 2
        end
        if CanDrive and commandDrive>0 then
            self.DriveCommand = commandDrive
        end
        --[=[ if CanDrive and --[[ not self.DriveCommand and--]]  self.KH3 > 0 then
            self.DriveCommand = (Vz > 40 or self.DriveCommand and self.DriveCommand>2) and 3 or 2
        end--]=]
        if (Vo > Vno or self.KTARS > 0 or self.VZP==0) then
            self.DriveCommand = false
        end
        if not CanDrive  then self.DriveCommand = false end
        if self.DriveCommand then
            if self.KRH > 0 and not self.KRHTimer then self.KRHTimer = CurTime() end
            if self.KRHTimer and CurTime()-self.KRHTimer > 1 then
                if     self.DriveCommand == 3 then self:SetDriveMode("X3")
                elseif self.DriveCommand > 0  then self:SetDriveMode("X2") end
            elseif not self.CommandDrive and self.KH3==0 then self.DriveCommand = false
            else  self:SetDriveMode("X1") end
        else
            self:SetDriveMode("OD")
            self.KRHTimer = false
        end

        if self.KD == 0 and not self.KDOffTimer then self.KDOffTimer = CurTime() end
        if self.KD > 0 and self.KDOffTimer then self.KDOffTimer = false end
        if commandDrive>0 and self.KDOffTimer and CurTime()-self.KDOffTimer > 5 then
            if self.KGR > 0 then self.BrakeProgramm = false end
            if (self.KRT == 0 or AV==0) and self.StationRing == nil then self.StationRing = CurTime() end
            self.KDCycle = true
        end
        if self.VAV==0 then self.KDCycle = nil end
        if self.StationRing and (self.KRH > 0 or self.KSZD > 0) then self.StationRing = false end
        if not self.KDOffTimer and self.StationRing ~= nil then self.StationRing = nil end

        --Doors control
        local CanOpen = speed <= 0.1 and self.KOAT > 0 and self.KSZD*self.VAV < 1
        --and (not self.StationRing or CurTime()-self.StationRing<4) --KEK
        local CanOpenLeft = CanOpen and (self.DoorsLeft or NoFreq > 0)
        local CanOpenRight = CanOpen and (self.DoorsRight or NoFreq > 0)

        if self.BrakeProgramm and self.Station and CanOpen--[[  and self.K16 == 0--]] then
            if self.OpenLeftTimer==nil and self.OpenRightTimer==nil then
                self.OpenLeftTimer = CanOpenLeft and CurTime()
                self.OpenRightTimer = CanOpenRight and CurTime()
            end
        else
            self.OpenLeftTimer = nil
            self.OpenRightTimer = nil
        end
        --if --[[ self.KH3 > 0 or--]]  speed < 0.1 and (not self.OpenLeftTimer and not self.OpenLeftTimer) or self.KD < 1 then self.BrakeProgramm = false end
        --if self.KH3 > 0 then self.Station = false end
        if self.OpenLeftTimer and CurTime()-self.OpenLeftTimer > 1 then self.OpenLeftTimer = false end
        if self.OpenRightTimer and CurTime()-self.OpenRightTimer > 1 then self.OpenRightTimer = false end
        if CanOpenLeft or CanOpenRight then
            self.CanOpen = true
        end
        if not CanOpen then self.CanOpen = false end
        if self.CanOpen then self:SetDoorMode("DO") else self:SetDoorMode("ZD") end
        if CanOpenLeft and (self.KDL > 0 or self.K16 == 0 and self.OpenLeftTimer) then
            self:SetDoorMode("DL")
        end
        if CanOpenRight and (self.KDP > 0 or self.K16 == 0 and self.OpenRightTimer) then
            self:SetDoorMode("DP")
        end

        --if self.VAV==0 or self.KDCycle and (not CanOpen or self.KD>0)  then self.KDCycle = nil end
        --if self.KD == 0 and CanOpen and self.KDCycle==nil then self.KDCycle = CurTime() end
        --if self.KDCycle and CurTime()-self.KDCycle>5 then self.KDCycle = false end)
        self.LKI1 = LKI and CurTime()%0.5 > 0.25 and 1 or 0
        self.LKI2 = LKI and CurTime()%0.5 <= 0.25 and 1 or 0
        self.LK16 = self.K16
        self.KRR1Brake = true
    else
        if self.Checked and not Power then self.Checked = false end
        self.OXTTimer = false
        self.OXT = false
        self.ST = false
        self.STTimer = false
        self.F5Timer = nil
        self.AT = false
        self.RingArmed = false
        self.BrakeProgramm = false
        self.LastBrakeProgrammLoss = false
        self.BrakeProgrammLossDistance = false
        self.BrakeProgrammTargetDistance = false
        self.BrakeProgrammCurrentDistance = false
        self.StationBrakeRing = false
        self.SpeedError = false
        self.LoseVf = false
        self.AntiRolling = false
        self.KRHTimer = false
        self.StationRing = false
        self.KDOffTimer = false
        self.CommandDrive = false
        --print(self.KRR1,self.KRR2)
        if Power and Reverser and not BackReverser and not self.Checked then
            self.Checked = CurTime()
        elseif not BackReverser and Power then
            if self.KRR1Brake then
                self:SetDriveMode("OD")
                self:SetPneumoMode("V1")
            else
                self:SetDriveMode("Zero")
                self:SetPneumoMode("NT")
            end
            self:SetDoorMode("DO")
            if speed > 1 then self.KRR1Brake = true end
            if self.Checked and self.Checked ~= true and CurTime()-self.Checked < 0.2 then
                Ring = true
            end
            if self.Checked and self.Checked ~= true and CurTime()-self.Checked > 1.5 then
                self.Checked = true
                self.RingArmed = CurTime()
            end
        else
            self:SetDriveMode("Zero")
            self:SetPneumoMode("NT")
        end

        self.LK16 = (self.Checked and self.Checked ~= true) and 1 or 0
        self.LRS = self.LK16
        self.LAVT = self.LK16
        self.LOS = self.LK16
        self.LKI1 = self.LK16
        self.LKI2 = self.LK16

        self.NoFreq = 0
        self.F1 = 0
        self.F2 = 0
        self.F3 = 0
        self.F4 = 0
        self.F5 = 0
        self.F6 = 0
        self.SpeedError = false
        self.RingZero = 0
    end
    if self.CurrentDriveMode then
        self["2"] = self.CurrentDriveMode[2]
        self["3"] = self.CurrentDriveMode[3]
        local pr8 = self.CurrentDriveMode[4]
        if pr8 ~= self.Target8 then
            if pr8 == 0 or self.pr8Timer and CurTime()-self.pr8Timer > 1.5 then
                self.Target8 = pr8
                self.pr8Timer = nil
            end
            if (--[[ (1-self.KOAT)*pr8 > 0 and--]]  speed>0.1) and not self.pr8Timer then self.pr8Timer = CurTime() end
        end
        if pr8 == 0 and self.pr8Timer then self.pr8Timer = CurTime() end
        self["8"] = (self.Target8+self.CurrentDriveMode[13]*self.KRU)*self.KRR1
        self["17"] = self.CurrentDriveMode[5]
        self["19"] = self.CurrentDriveMode[6]
        self["20"] = self.CurrentDriveMode[7]
        self["20X"] = self.CurrentDriveMode[8]
        self["25"] = self.CurrentDriveMode[9]
        self["025"] = self.CurrentDriveMode[10]
        self["33"] = self.CurrentDriveMode[11]
        self["033"] = self.CurrentDriveMode[12]
        self["33G"] = self.CurrentDriveMode[13]*(1-self.KRU)
    end
    if self.CurrentDoorMode then
        self["16"] = self.CurrentDoorMode[1]
        self["31"] = self.CurrentDoorMode[2]
        self["32"] = self.CurrentDoorMode[3]
    end
    if self.CurrentPneumoMode then
        self["39"] = self.CurrentPneumoMode[2]*self.KRR1
        self["48"] = self.CurrentPneumoMode[3]*self.Power
    end
    self.Ring = (Ring or self.RingArmed and (self.RingArmed-CurTime())%3 > 1.5 or self.StationRing or self.StationBrakeRing) and 1 or 0
    --[[
     for i,train in ipairs(Train.WagonList) do
        if train.RheostatController then
            Train:SetNW2Int("PUAV:RK"..i,math.floor(train.RheostatController.Position+0.5))
        end
    end--]]
end

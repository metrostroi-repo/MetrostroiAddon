--------------------------------------------------------------------------------
-- SBPP autodrive receiver
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("SBPP")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()

    self.Count = 0
    self.ProgrammX = 0
    self.ProgrammBrake = 0
    self.Path = 0
    self.Station = 0
end

function TRAIN_SYSTEM:Outputs()
    return {}
end

function TRAIN_SYSTEM:Inputs()
    return {}
end


local DrawDebug
if SERVER then
    CreateConVar("metrostroi_sbppdebug",0)
    DrawDebug = GetConVar("metrostroi_sbppdebug")
end
function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    function self:SetCommand(name,command)
        if command then
            Train.PUAV:TriggerInput(name,command)
            if name == "CommandDrive" then
                self.LastDrive = self.Drive
                self.Drive = command
                if command==-1 then self.LastBrake = false end
            end
            if name == "CommandBrake" then
                self.LastBrake = self.Brake
                self.Brake = command
                if command and command~=0 and self.Drive and self.Drive>0 then self.LastDrive = self.Drive self.Drive = 0 end
            end
        else
            Train.PUAV:TriggerInput(name,0)
        end
    end

    local Sensor = Train.SBPPSensor
    if not IsValid(Sensor) then return end

    local ProgrammType
    local Programm

    for k,v in ipairs(Sensor.Commands) do
        local isSBPP = v.PlateType==METROSTROI_SBPPSENSOR
        local command = v.SBPPType
        if isSBPP and Train:GetRight():Dot(v:GetUp())>0 then
            if not ProgrammType then
                Programm = v.Linked or v
                ProgrammType = command
            elseif ProgrammType ~= command then
                Programm = false
            end
        end
    end
    if self.Programm ~= Programm then
        self.Programm = Programm
        self.LastProgramm = Programm or self.LastProgramm
    end
    local ProgramDoorLeft
    local ProgramDoorRight
    local ProgrammX
    local ProgrammBrake = 0

    local CurrProgramm = Programm and Programm.SBPPType
    if CurrProgramm == 1 then
        if self.StationState~=1 then
            self.StationState = 1
            self.Distance = Programm.DistanceToOPV+1.40
            self.SensorDistance = self.Distance
        end
    elseif CurrProgramm == 2 then
        if self.StationState~=4 then
            self.StationState = 4
            self.Distance = Programm.DistanceToOPV+1.40
            self.SensorDistance = self.Distance
        end
    elseif CurrProgramm == 3 then
        self.Path = Programm.StationPath or 0
        self.Station = Programm.StationID or 0
        local btime = Train.BoardTimer or 0
        local wtime = Programm.WTime or 0
        if not Programm.IsDeadlock and btime<8 or wtime==0 and  Train.ALSCoil.Speed<0.2 and Programm.IsDeadlock then
            ProgrammX = Programm.DriveMode or 0
            if wtime>0 then self.DrivingTimer = CurTime()+wtime end
            self.StationState = nil
        end
        ProgramDoorRight = Programm.RightDoors
        ProgramDoorLeft = not ProgramDoorRight
    elseif CurrProgramm == 5 then
        local wtime = Programm.WTime or 0
        if wtime>0 then self.DrivingTimer = CurTime()+wtime end
        ProgrammX = 2
    elseif CurrProgramm == 6 then
        local wtime = Programm.WTime or 0
        if wtime>0 then self.DrivingTimer = CurTime()+wtime end
        ProgrammX = 3
    elseif CurrProgramm == 7 then
        local time = Programm.WTime or 0
        local RK = Programm.RKPos or 1
        if not self.BrakingRimer and time>0 then
            self.BrakingTimer = CurTime()+time
        else
            self.BrakingTimer = true
        end
        self.BrakingPos = RK
    end
    local PUAV = Train.PUAV
    if self.BrakingTimer then
        if self.BrakingPos > 1 and (not PUAV.TargetKPRK or PUAV.TargetKPRK<self.BrakingPos) then
            if self.LastBrakeTime then
                ProgrammBrake = 0
            else
                self.LastBrakeTime = CurTime()
            end
            if CurTime()-self.LastBrakeTime<0.35 then
                ProgrammBrake = 0
            else
                ProgrammBrake = 1
            end
            if CurTime()-self.LastBrakeTime > 0.4 then self.LastBrakeTime = CurTime() end--]]
        else
            ProgrammBrake = 1
        end
        if self.BrakingTimer~=true and CurTime()-self.BrakingTimer>0 then
            CurrProgramm = 4
        end
    end
    local pos = Metrostroi.TrainPositions[Train] pos = pos and pos[1]
    local speedMpS = Train.ALSCoil.Speed/3600*1000
    local delta = speedMpS*dT
    if pos and pos.path ~= self.OldPath then
        self.OldPath = pos.path
        self.OldPos = pos.x+Train.PosX
        delta = speedMpS*dT
    elseif pos then
        local x = pos.x+Train.PosX
        delta = (x-self.OldPos)*(Metrostroi.TrainDirections[Train] and 1 or -1)
        self.OldPos = x
    end
    if self.Distance then
        self.Distance = self.Distance-delta
        if self.Distance-self.SensorDistance>5 or self.Distance < -5 then
            self.Distance = false
            self.StationState = false
        end
    end
    if self.StationState then
        ProgrammBrake = 1
        if self.StationState==1 then
            if self.LossDistance then ProgrammBrake = 0 end
            if not self.LossDistance then
                self.LossDistance = self.Distance
            elseif self.LossDistance-self.Distance>20 then
                self.LossDistance = false
                self.StationState = 2
            end
        elseif self.StationState == 2 then
            if math.min(((self.Distance-32)/66)^0.6*66-1,66) < Train.ALSCoil.Speed then
                self:SetCommand("CommandBrakeElapsed",0)
                self.StationState = 3
            end
        elseif self.StationState == 4 then
            if math.min(((self.Distance-2)/12)^0.5*25-3,22) < Train.ALSCoil.Speed then
                self:SetCommand("CommandBrakeElapsed",0)
                self.StationState = 5
            end
        end
        if self.StationState>=2 then
            if not self.CrossTimer then self.CrossTimer = CurTime() end
            if self.CrossTimer and CurTime()-self.CrossTimer>0.15 then
                self.CrossTimer = CurTime()
                self:SetCommand("CommandBrakeElapsed",self.StationState==3 and 3 or 1)
            end
        end
    else
        self.CrossTimer = false
        self.LossDistance = false
    end
    if self.DrivingTimer and CurTime()-self.DrivingTimer > 0 then
        CurrProgramm = 4
    end
    if CurrProgramm == 4 then
        ProgrammX = -1
        ProgrammBrake = 0
        self.BrakingTimer = false
        self.DrivingTimer = false
    elseif not CurrProgramm and not self.BrakingTimer and not self.DrivingTimer then
        ProgrammX = 0
    end
    if self.ProgrammX and self.ProgrammX>0 and ProgrammX==0 and not self.DriveTimer then self.DriveTimer = CurTime() end
    if self.DriveTimer and not CurrProgramm and CurTime()-self.DriveTimer > 1.5 then self.DriveTimer = nil end

    if self.ProgramDoorLeft ~= ProgramDoorLeft then
        self:SetCommand("CommandDoorsLeft",ProgramDoorLeft and 1)
        self.ProgramDoorLeft = ProgramDoorLeft
    end
    if self.ProgramDoorRight ~= ProgramDoorRight then
        self:SetCommand("CommandDoorsRight",ProgramDoorRight and 1)
        self.ProgramDoorRight = ProgramDoorRight
    end
    --if ProgrammBrake and not ProgrammBrake.BrakeCommandFounded then ProgrammBrake = nil end
    if self.ProgrammBrake ~= ProgrammBrake then
        self:SetCommand("CommandBrake",ProgrammBrake)
        self.ProgrammBrake = ProgrammBrake
    end
    if self.ProgrammX ~= ProgrammX and(ProgrammX ~= 0 or not self.DriveTimer) then
        if ProgrammX == 3 then self:SetCommand("CommandDrive",3) --X3
        elseif ProgrammX == 2 then self:SetCommand("CommandDrive",2) --X2
        elseif ProgrammX == -1 then self:SetCommand("CommandDrive",-1) --X2
        elseif ProgrammX == 0 then self:SetCommand("CommandDrive",0) end
        self.ProgrammX = ProgrammX
    end

    if DrawDebug:GetBool() then
        Train:SetNW2Bool("SBPP:Debug",true)
        local str1 = ""
        local str2 = ""
        local page = math.floor(CurTime()%1.25/1.25*2)
        local cp = CurrProgramm or self.LastProgramm and self.LastProgramm.SBPPType
        if page==0 and cp then
            if CurrProgramm then
                str1 = str1.."СБПП"
            else
                str1 = str1.."сбпп"
            end
            if cp == 1 then str2 = str2.."СТ1 "
            elseif cp == 2 then str2 = str2.."СТ2 "
            elseif cp == 3 then str2 = str2.."ОПВ "
            elseif cp == 4 then str2 = str2.."ОД  "
            elseif cp == 5 then str2 = str2.."Х2  "
            elseif cp == 6 then str2 = str2.."Х3  "
            elseif cp == 7 then str2 = str2.."ТР  " end
        else
            str1 = str1.."ПУАВ"
        end
        if CurrProgramm == 3 then
            local btime = Train.BoardTimer or 0
            local wtime = Programm.WTime or 0
            ProgramDoorRight = Programm.RightDoors
            ProgramDoorLeft = not ProgramDoorRight
            if page==0 then
                str1 = str1.." П"
                str2 = str2.." "..self.Path
                str1 = str1.." СТ "
                str2 = str2..Format(" %03d",self.Station)
                str1 = str1.." РСТ"
                str2 = str2..Format(" %05.1f",(self.Distance or -1))
            else
                str1 = str1.." ОТП"
                str2 = str2..Format(" %+03d",math.Clamp(btime,-99,99))
                str1 = str1.." РЖ"
                if Programm.DriveMode == 3 then
                    str2 = str2.." Х3"
                elseif Programm.DriveMode == 2 then
                    str2 = str2.." Х2"
                end
                str1 = str1.." ВР"
                if Programm.WTime and Programm.WTime ~= 0 then
                    str2 = str2..Format(" %04.1f",math.Clamp(wtime,0,120))
                else
                    str2 = str2.." МАРК"
                end
            end
        end
        local PUAV = Train.PUAV
        if self.BrakingTimer then
            str1 = str1.." РК"
            str2 = str2..Format(" %02d",self.BrakingPos)
            if self.BrakingPos > Train.RheostatController.SelectedPosition then
                str1 = str1.."<"
            elseif self.BrakingPos < Train.RheostatController.SelectedPosition then
                str1 = str1..">"
            else
                str1 = str1.."="
            end
            if page==0 then
                str1 = str1.."кп"
                str2 = str2..Format(" %02d",PUAV.TargetKPRK or -1)
            else
                str1 = str1.."рк"
                str2 = str2..Format(" %02d",Train.RheostatController.SelectedPosition)
            end
            str1 = str1.." ВР"
            if self.BrakingTimer~=true then
                str2 = str2..Format(" %04.1f",math.Clamp(self.BrakingTimer-CurTime(),0,120))
            else
                str2 = str2.." МАРК"
            end
        end
        if self.StationState then
            str1 = str1.." РСТ"
            str2 = str2..Format(" %05.1f",(self.Distance or -1))
            if self.StationState == 2 then
                str1 = str1.."   РСК"
                str2 = str2..Format(" %04.1f",math.min(((self.Distance-32)/66)^0.6*66-1,66))
            elseif self.StationState == 4 then
                if page==0 then
                    str1 = str1.." П"
                    str2 = str2.." "..self.Path
                    str1 = str1.." СТ "
                    str2 = str2..Format(" %03d",self.Station)
                else
                    str1 = str1.."   РСК"
                    str2 = str2..Format(" %04.1f",math.min(((self.Distance-2)/12)^0.5*20-3,22))
                end
            end
        end
        if self.DrivingTimer and not CurrProgramm then
            str1 = str1.." ВР"
            if self.DrivingTimer~=true then
                str2 = str2..Format(" %04.1f",math.Clamp(self.DrivingTimer-CurTime(),0,120))
            else
                str2 = str2.." МАРК"
            end
        end
        if self.DriveTimer and not CurrProgramm then
            str1 = str1.." ХВР"
            str2 = str2..Format(" %04.1f",math.Clamp(1.5-(CurTime()-self.DriveTimer),0,120))
        end

        str1 = str1..string.rep(" ",15-#{utf8.codepoint(str1,1,-1)})..page

        if not cp or page==1 then
            if ProgramDoorLeft and ProgramDoorRight then str2 = "ЛП"..str2
            elseif ProgramDoorLeft then str2 = "Л-"..str2
            elseif ProgramDoorRight then str2 = "-П"..str2
            else str2 = "--"..str2 end
            if self.Brake==1 then str2 = "КП"..str2
            elseif self.Brake and self.Brake<0 then str2 = "Х3"..str2
            elseif self.Drive==3 then str2 = "Х3"..str2
            elseif self.Drive==2 then str2 = "Х2"..str2
            elseif self.Drive==-1 then str2 = "ОД"..str2
            elseif self.LastBrake==1 then str2 = "тп"..str2
            elseif self.LastBrake and self.LastBrake<0 then str2 = "кп"..str2
            elseif self.LastDrive==3 then str2 = "х3"..str2
            elseif self.LastDrive==2 then str2 = "х2"..str2
            elseif self.LastDrive==-1 then str2 = "од"..str2
            else str2 = "--"..str2 end
        end
        Train:SetNW2String("SBPP:Str1",str1~="" and str1 or "No data")
        Train:SetNW2String("SBPP:Str2",str2~="" and str2 or "No data")
    else
        Train:SetNW2Bool("SBPP:Debug",false)
    end
end

--------------------------------------------------------------------------------
-- ALS coils helper
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("ALSCoil")
TRAIN_SYSTEM.DontAccelerateSimulation = true


function TRAIN_SYSTEM:Initialize()
    self.Enabled = 0
    self.Speed = 0
    self.Acceleration = 0
    -- ALS state
    self.NoneFreq = 0
    self.OneFreq = 0
    self.TwoFreq = 0
    self.BadFreq = 0
    self.F1 = 0
    self.F2 = 0
    self.F3 = 0
    self.F4 = 0
    self.F5 = 0
    self.F6 = 0
    self.NoFreq = 1
    --self.NoFreqTimer = nil
    self.RealF5 = 1
    self.Speed = 0
    self.SpeedSign = 0

end

function TRAIN_SYSTEM:Outputs()
    return {
        "Enabled", "Speed", "SpeedSign", "Acceleration",
        "F1", "F2", "F3", "F4", "F5", "F6",
        "NoFreq", "RealF5", "OneFreq", "TwoFreq", "BadFreq"
    }
end

function TRAIN_SYSTEM:Inputs()
    return {"Enable"}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "Enable" then
        self.Enabled = value
    end
end

function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    local tbl = Train.SubwayTrain and Train.SubwayTrain.ALS

    local force1_5 = not tbl or not tbl.TwoToSix
    local HaveRS = not force1_5 and tbl and tbl.RSAs325Hz
    local Aproove0 = tbl and tbl.Aproove0As325Hz
    local haveautostop = tbl and tbl.HaveAutostop
    if self.Enabled == 0 then
        self.F1 = 0
        self.F2 = 0
        self.F3 = 0
        self.F4 = 0
        self.F5 = 0
        self.F6 = 0
        self.AO = false
        self.RealF5 = 0
        self.NoFreq = 0
        self.NoFreqTimer = 0
    end
    -- Speed check and update speed data
    if CurTime() - (self.LastSpeedCheck or 0) > 0.5 then
        self.LastSpeedCheck = CurTime()
    end
    self.Speed = (Train.Speed or 0)
    self.Acceleration = math.Round(Train.Acceleration,1)
    self.SpeedSign = Train.SpeedSign or 1

    local autostop = haveautostop and Train.SpeedSign > 0 and Train.Speed > 0.1
    if autostop or self.Enabled > 0 then
        local ars,arsback
        self.Timer = self.Timer or CurTime()
        if CurTime() - self.Timer > 1.00 then
            self.Timer = CurTime()
            -- Get train position
            local pos = Metrostroi.TrainPositions[Train]
            if pos then pos = pos[1] end
            -- Get previous ARS section
            if pos then
                ars,arsback = Metrostroi.GetARSJoint(pos.node1,pos.x,Metrostroi.TrainDirections[Train], Train)
            end
            if autostop then
                if IsValid(arsback) then
                    if arsback == self.AutostopSignal then
                        local ply,mode = Train:GetDriverPly()
                        local nomsg = IsValid(Train.FrontTrain) and IsValid(Train.RearTrain) or hook.Run("MetrostroiPassedRed",Train,ply,mode,arsback)
                        if self.AutostropEnabled then
                            Train.Pneumatic:TriggerInput("Autostop",nomsg and 0 or 1)
                        end
                        if not nomsg then
                            RunConsoleCommand("say",Format("%s Passed prohibited %s signal [%s]",Train:GetDriverName(),arsback.InvationSignal and "InvationSignal" or "",arsback.Name))
                        end
                        self.AutostopSignal = nil
                    end
                end
                if IsValid(ars) then
                    if ars.Red then
                        self.AutostopSignal = ars
                        self.AutostropEnabled = ars.AutoEnabled
                    elseif self.AutostopSignal == ars then
                        self.AutostopSignal = nil
                    end
                end
            end

            if self.Enabled > 0 and IsValid(ars) then
                if not ars:GetARS(1,Train) then
                    self.F1 = ars:GetARS(8,force1_5,force2_6) and 1 or 0
                    self.F2 = ars:GetARS(7,force1_5,force2_6) and 1 or 0
                    self.F3 = ars:GetARS(6,force1_5,force2_6) and 1 or 0
                    self.F4 = ars:GetARS(4,force1_5,force2_6) and 1 or 0
                    self.F5 = ars:GetARS(0,force1_5,force2_6) and 1 or 0
                    self.AO = ars:GetARS(2,true)
                    if HaveRS then
                        self.F6 = ars:GetRS() and 1 or 0
                    elseif Aproove0 then
                        self.F6 = ars:Get325HzAproove0() and 1 or 0
                    else
                        self.F6 = 0
                    end
                end
                local NoFreq = ars:GetARS(1,Train) or (self.F1+self.F2+self.F3+self.F4+self.F5) == 0 and not self.AO
                --if not NoFreq then self.NoFreq = 0 end
                --if NoFreq and self.NoFreqTimer == nil then self.NoFreqTimer = CurTime() - (ars:GetARS(1,Train) and 2 or 0) end
                --if not NoFreq and self.NoFreqTimer ~= nil then self.NoFreqTimer = nil end
                --if self.NoFreqTimer and CurTime()-self.NoFreqTimer > 2 then self.NoFreqTimer = false end
                --self.NoFreq = (NoFreq and self.NoFreqTimer == false) and 1 or 0
                self.NoFreq = NoFreq and 1 or 0
                if GetConVarNumber("metrostroi_ars_printnext") == Train:GetWagonNumber() then RunConsoleCommand("say",ars.Name,tostring(arsback and arsback.Name),tostring(ars.NextSignalLink and ars.NextSignalLink.Name or "unknown"),tostring(pos.node1.path.id),tostring(Metrostroi.TrainDirections[Train])) end
            elseif self.Enabled > 0 then
                if self.NoFreqTimer == nil then self.NoFreqTimer = CurTime() end

                if self.NoFreqTimer and CurTime()-self.NoFreqTimer > 2 then self.NoFreqTimer = false end
                self.NoFreq = (self.NoFreqTimer == false) and 1 or 0
            end
            self.F1 = self.F1*(1-self.NoFreq)
            self.F2 = self.F2*(1-self.NoFreq)
            self.F3 = self.F3*(1-self.NoFreq)
            self.F4 = self.F4*(1-self.NoFreq)
            self.F5 = self.F5*(1-self.NoFreq)
            self.F6 = self.F6*(1-self.NoFreq)
            self.AO = self.AO and self.NoFreq==0
            self.RealF5 = self.F5*(1-self.F4*self.F3*self.F2*self.F1)
        end
        if self.AO then
            if Aproove0 then
                self.F5 = 1
                self.F6 = 0
            else
                self.F5 = CurTime()%2 < 1 and 1 or 0
            end
        end
    end
    local freqCount = self.F6+self.F5+self.F4+self.F3+self.F2+self.F1
    self.NoneFreq =freqCount==0 and 1 or 0
    self.OneFreq = freqCount==1 and 1 or 0
    self.TwoFreq = freqCount==2 and 1 or 0
    self.BadFreq = freqCount>2 and 1 or 0
end

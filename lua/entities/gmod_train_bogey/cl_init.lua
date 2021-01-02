include("shared.lua")

--------------------------------------------------------------------------------
function ENT:ReinitializeSounds()
    -- Bogey-related sounds
    self.SoundNames = {}
    self.EngineSNDConfig = {}

    self.SoundNames["ted1_703"]  = "subway_trains/bogey/engines/703/speed_8.wav"
    self.SoundNames["ted2_703"]  = "subway_trains/bogey/engines/703/speed_16.wav"
    self.SoundNames["ted3_703"]  = "subway_trains/bogey/engines/703/speed_24.wav"
    self.SoundNames["ted4_703"]  = "subway_trains/bogey/engines/703/speed_32.wav"
    self.SoundNames["ted5_703"]  = "subway_trains/bogey/engines/703/speed_40.wav"
    self.SoundNames["ted6_703"]  = "subway_trains/bogey/engines/703/speed_48.wav"
    self.SoundNames["ted7_703"]  = "subway_trains/bogey/engines/703/speed_56.wav"
    self.SoundNames["ted8_703"]  = "subway_trains/bogey/engines/703/speed_64.wav"
    self.SoundNames["ted9_703"]  = "subway_trains/bogey/engines/703/speed_72.wav"
    self.SoundNames["ted10_703"] = "subway_trains/bogey/engines/703/speed_80.wav"
    self.SoundNames["ted11_703"] = "subway_trains/bogey/engines/703/speed_88.wav"
    --self.SoundNames["tedm_703"]  = "subway_trains/bogey/engines/703/engines_medium.wav"

    self.SoundNames["ted1_717"]  = "subway_trains/bogey/engines/717/engines_8.wav"
    self.SoundNames["ted2_717"]  = "subway_trains/bogey/engines/717/engines_16.wav"
    self.SoundNames["ted3_717"]  = "subway_trains/bogey/engines/717/engines_24.wav"
    self.SoundNames["ted4_717"]  = "subway_trains/bogey/engines/717/engines_32.wav"
    self.SoundNames["ted5_717"]  = "subway_trains/bogey/engines/717/engines_40.wav"
    self.SoundNames["ted6_717"]  = "subway_trains/bogey/engines/717/engines_48.wav"
    self.SoundNames["ted7_717"]  = "subway_trains/bogey/engines/717/engines_56.wav"
    self.SoundNames["ted8_717"]  = "subway_trains/bogey/engines/717/engines_64.wav"
    self.SoundNames["ted9_717"]  = "subway_trains/bogey/engines/717/engines_72.wav"
    self.SoundNames["ted10_717"] = "subway_trains/bogey/engines/717/engines_80.wav"

    self.SoundNames["ted11_720"] = "subway_trains/bogey/engines/720/speed_88.wav"
    self.SoundNames["ted1_720"]  = "subway_trains/bogey/engines/720/speed_8.wav"
    self.SoundNames["ted2_720"]  = "subway_trains/bogey/engines/720/speed_16.wav"
    self.SoundNames["ted3_720"]  = "subway_trains/bogey/engines/720/speed_24.wav"
    self.SoundNames["ted4_720"]  = "subway_trains/bogey/engines/720/speed_32.wav"
    self.SoundNames["ted5_720"]  = "subway_trains/bogey/engines/720/speed_40.wav"
    self.SoundNames["ted6_720"]  = "subway_trains/bogey/engines/720/speed_48.wav"
    self.SoundNames["ted7_720"]  = "subway_trains/bogey/engines/720/speed_56.wav"
    self.SoundNames["ted8_720"]  = "subway_trains/bogey/engines/720/speed_64.wav"
    self.SoundNames["ted9_720"]  = "subway_trains/bogey/engines/720/speed_72.wav"
    self.SoundNames["ted10_720"] = "subway_trains/bogey/engines/720/speed_80.wav"
    --*0.975
    --*1.025
    self.SoundNames["flangea"]      = "subway_trains/bogey/skrip1.wav"
    self.SoundNames["flangeb"]      = "subway_trains/bogey/skrip2.wav"
    self.SoundNames["flange1"]      = "subway_trains/bogey/flange_9.wav"
    self.SoundNames["flange2"]      = "subway_trains/bogey/flange_10.wav"
    self.SoundNames["brakea_loop1"]       = "subway_trains/bogey/braking_async1.wav"
    self.SoundNames["brakea_loop2"]       = "subway_trains/bogey/braking_async2.wav"
    self.SoundNames["brake_loop1"]       = "subway_trains/bogey/brake_rattle3.wav"
    self.SoundNames["brake_loop2"]       = "subway_trains/bogey/brake_rattle4.wav"
    self.SoundNames["brake_loop3"]       = "subway_trains/bogey/brake_rattle5.wav"
    self.SoundNames["brake_loop4"]       = "subway_trains/bogey/brake_rattle6.wav"
    self.SoundNames["brake_loopb"]       = "subway_trains/common/junk/junk_background_braking1.wav"
    self.SoundNames["brake2_loop1"]       = "subway_trains/bogey/brake_rattle2.wav"
    self.SoundNames["brake2_loop2"]       = "subway_trains/bogey/brake_rattle_h.wav"
    self.SoundNames["brake_squeal1"]       = "subway_trains/bogey/brake_squeal1.wav"
    self.SoundNames["brake_squeal2"]       = "subway_trains/bogey/brake_squeal2.wav"

    -- Remove old sounds
    if self.Sounds then
        for k,v in pairs(self.Sounds) do
            v:Stop()
        end
    end

    -- Create sounds
    self.Sounds = {}
    self.Playing = {}
    for k,v in pairs(self.SoundNames) do
        --if not file.Exists(v, "MOD") then
--          self.SoundNames[k] = nil
        --end
        util.PrecacheSound(v)
        local e = self
        if (k == "brake3a") and IsValid(self:GetNW2Entity("TrainWheels")) then
            e = self:GetNW2Entity("TrainWheels")
        end
        self.Sounds[k] = CreateSound(e, Sound(v))
    end

    self.Async = nil
    self.MotorSoundType = nil
end
function ENT:SetSoundState(sound,volume,pitch,name,level )
    if not self.Sounds[sound] then
        if self.SoundNames[name or sound] and (not wheels or IsValid(self:GetNW2Entity("TrainWheels"))) then
            self.Sounds[sound] = CreateSound(wheels and self:GetNW2Entity("TrainWheels") or self, Sound(self.SoundNames[name or sound]))
        else
            return
        end
    end
    local snd = self.Sounds[sound]
    if (volume <= 0) or (pitch <= 0) then
        if snd:IsPlaying() then
            snd:ChangeVolume(0.0,0)
            snd:Stop()
        end
        return
    end
    local pch = math.floor(math.max(0,math.min(255,100*pitch)) + math.random())
    local vol = math.max(0,math.min(255,2.55*volume)) + (0.001/2.55) + (0.001/2.55)*math.random()
    if name~=false and not snd:IsPlaying() or name==false and snd:GetVolume()==0 then
    --if not self.Playing[sound] or name~=false and not snd:IsPlaying() or name==false and snd:GetVolume()==0 then
        if level and snd:GetSoundLevel() ~= level then
            snd:Stop()
            snd:SetSoundLevel(level)
        end
        snd:PlayEx(vol,pch+1)
    end
    --snd:SetDSP(22)
    snd:ChangeVolume(vol,0)
    snd:ChangePitch(pch+1,0)
    --snd:SetDSP(22)
end

function ENT:Initialize()
    self.MotorPowerSound = 0
--  self:ReinitializeSounds()
end

function ENT:OnRemove()
    if self.Sounds then
        for k,v in pairs(self.Sounds) do
            v:Stop()
        end
        self.Sounds = nil
    end
end

--------------------------------------------------------------------------------
function ENT:Think()
    if not self.Sounds then
        self:ReinitializeSounds()
    end
    self.PrevTime = self.PrevTime or RealTime()-0.33
    self.DeltaTime = (RealTime() - self.PrevTime)
    self.PrevTime = RealTime()
    -- Get interesting parameters
    local train = self:GetNW2Entity("TrainEntity")

    --local rollingi = math.min(1,train.TunnelCoeff+math.Clamp((train.StreetCoeff-0.6)/0.3,0,1)*0.8)
    --print(self:GetPos())
    --local rollings = train.StreetCoeff
    local soundsmul = 1
    local streetC,tunnelC = 0,1
    if IsValid(train) then
        streetC,tunnelC = train.StreetCoeff or 0,train.TunnelCoeff or 1
        soundsmul = math.Clamp(tunnelC^1.5+(streetC^0.5)*0.2,0,1)
    end
    local motorPower = self:GetMotorPower()
    local speed = self:GetSpeed()
    if self.MotorSoundType ~= self:GetNWInt("MotorSoundType",1)then
        self.MotorSoundType = self:GetNWInt("MotorSoundType",1)
        for k,v in pairs(self.EngineSNDConfig) do self:SetSoundState(v[1],0,0) end
        self.EngineSNDConfig = {}
        if self.MotorSoundType==2 then
            table.insert(self.EngineSNDConfig,{"ted1_720" ,08,00,16,1*0.4})
            table.insert(self.EngineSNDConfig,{"ted2_720" ,16,08-4,24,1*0.43})
            table.insert(self.EngineSNDConfig,{"ted3_720" ,24,16-4,32,1*0.46})
            table.insert(self.EngineSNDConfig,{"ted4_720" ,32,24-4,40,1*0.49})
            table.insert(self.EngineSNDConfig,{"ted5_720" ,40,32-4,48,1*0.52})
            table.insert(self.EngineSNDConfig,{"ted6_720" ,48,40-4,56,1*0.55})
            table.insert(self.EngineSNDConfig,{"ted7_720" ,56,48-4,64,1*0.58})
            table.insert(self.EngineSNDConfig,{"ted8_720" ,64,56-4,72,1*0.61})
            table.insert(self.EngineSNDConfig,{"ted9_720" ,72,64-4,80,1*0.64})
            table.insert(self.EngineSNDConfig,{"ted10_720",80,72-4,88,1*0.67})
            table.insert(self.EngineSNDConfig,{"ted11_720",88,80-4   ,1*0.7})
        elseif self.MotorSoundType==0 then
            table.insert(self.EngineSNDConfig,{"ted1_703" ,08,00,16,1})
            table.insert(self.EngineSNDConfig,{"ted2_703" ,16,08-4,24,1})
            table.insert(self.EngineSNDConfig,{"ted3_703" ,24,16-4,32,1})
            table.insert(self.EngineSNDConfig,{"ted4_703" ,32,24-4,40,1})
            table.insert(self.EngineSNDConfig,{"ted5_703" ,40,32-4,48,1})
            table.insert(self.EngineSNDConfig,{"ted6_703" ,48,40-4,56,1})
            table.insert(self.EngineSNDConfig,{"ted7_703" ,56,48-4,64,1})
            table.insert(self.EngineSNDConfig,{"ted8_703" ,64,56-4,72,1})
            table.insert(self.EngineSNDConfig,{"ted9_703" ,72,64-4,80,1})
            table.insert(self.EngineSNDConfig,{"ted10_703",80,72-4,88,1})
            table.insert(self.EngineSNDConfig,{"ted11_703",88,80-4   ,1})
        else
            table.insert(self.EngineSNDConfig,{"ted1_717" ,08,00,16,1})
            table.insert(self.EngineSNDConfig,{"ted2_717" ,16,08-4,24,1})
            table.insert(self.EngineSNDConfig,{"ted3_717" ,24,16-4,32,1})
            table.insert(self.EngineSNDConfig,{"ted4_717" ,32,24-4,40,1})
            table.insert(self.EngineSNDConfig,{"ted5_717" ,40,32-4,48,1})
            table.insert(self.EngineSNDConfig,{"ted6_717" ,48,40-4,56,1})
            table.insert(self.EngineSNDConfig,{"ted7_717" ,56,48-4,64,1})
            table.insert(self.EngineSNDConfig,{"ted8_717" ,64,56-4,72,1})
            table.insert(self.EngineSNDConfig,{"ted9_717" ,72,64-4,80,1})
            table.insert(self.EngineSNDConfig,{"ted10_717",80,72-4   ,1})
        end
    end
    self.Async = self:GetNWBool("Async")
    -- Engine sound
    if not self:GetNWBool("DisableEngines") then
        self.MotorPowerSound = math.Clamp(self.MotorPowerSound + (motorPower - self.MotorPowerSound)*self.DeltaTime*3,-1,1)
        local t = RealTime()*2.5
        local modulation = (0.2 + 1.0*math.max(0,0.2+math.sin(t)*math.sin(t*3.12)*math.sin(t*0.24)*math.sin(t*4.0)))*math.Clamp(speed/4,0,1)
        local mod2 = 1.0-math.min(1.0,(math.abs(self.MotorPowerSound)/0.1))
        if (speed > -1.0) and (math.abs(self.MotorPowerSound)+modulation) >= 0.0 then
            --local startVolRamp = 0.2 + 0.8*math.max(0.0,math.min(1.0,(speed - 1.0)*0.5))
            local powerVolRamp
            if self.MotorSoundType==2 then
                powerVolRamp = 0.2*modulation*mod2 + 6*math.abs(self.MotorPowerSound)--2.0*(math.abs(motorPower)^2)
            else
                powerVolRamp = 0.3*modulation*mod2 + 2*math.abs(self.MotorPowerSound)--2.0*(math.abs(motorPower)^2)
            end
            --math.max(0.3,math.min(1.0,math.abs(motorPower)))

            --local k,x = 1.0,math.max(0,math.min(1.1,(speed-1.0)/80))
            --local motorPchRamp = (k*x^3 - k*x^2 + x)
            --local motorPitch = 0.03+1.85*motorPchRamp
            local volumemul = math.min(1,(speed/4)^3)
            local motorsnd = math.min(1.0,math.max(0.0,1.25*(math.abs(self.MotorPowerSound))))
            local motorvol = (soundsmul^0.3)*math.Clamp(motorsnd + powerVolRamp,0,1)*volumemul
            --local motorsnd = math.min(1.0,math.max(0.0,1.25*(math.abs(self.MotorPowerSound)-0.15) ))

            for i,snd in ipairs(self.EngineSNDConfig or {}) do
                local prev = self.EngineSNDConfig[i-1]
                local next = self.EngineSNDConfig[i+1]
                local volume = 1
                if prev and speed <= prev[4] then
                    volume = math.max(0,1-(prev[4]-speed)/(prev[4]-snd[3]))
                elseif next  and speed > next[3] then
                    volume = math.max(0,(snd[4]-speed)/(snd[4]-next[3]))
                end
                local pitch = math.max(0,speed/snd[2])+0.06*streetC
                if self.Async then
                    self:SetSoundState(snd[1].."1",motorvol*volume*(snd[5] or 1),math.Clamp(pitch,0,2),snd[1],false)
                    --self:SetSoundState(snd[1].."2",0,0,true)
                else
                    self:SetSoundState(snd[1].."1",motorvol*volume*(snd[5] or 1),math.Clamp(pitch,0,2),snd[1],false)
                    --self:SetSoundState(snd[1].."2",0,0,true)
                    --self:SetSoundState(snd[1].."1",((motorsnd + powerVolRamp)*volume)*(snd.vol or 1)*volumemul,pitch*0.975,snd[1],false)
                    --self:SetSoundState(snd[1].."2",((motorsnd + powerVolRamp)*volume)*(snd.vol or 1)*volumemul,pitch*1.025,snd[1],true)
                end
            end
            --[[ if self.MotorSoundType==0 then
                self:SetSoundState("tedm_703",math.min(1,(soundsmul^0.3)*motorsnd*2)*math.Clamp((speed-20)/10,0,1)*(1-math.Clamp((speed-38)/20,0,1))*0.18,math.max(0,speed/35.4)+0.06*streetC)
            else
                self:SetSoundState("tedm_703",0,0)
            end--]]
        else
            for k,v in pairs(self.EngineSNDConfig) do
                self:SetSoundState(v[1].."1",0,0,v[1],false)
            end
            self:SetSoundState(v[1].."2",0,0,v[1],true)
        end
    end
    -- Brake squeal sound
    --if speed > 2 then
        --brakeRamp = 1 - math.min(1.0,math.max(0.0,(speed-3)/10.0))
    --end
    if squealSound == 0 then squealSound = 1 end
    if squealSound == 3 then squealSound = 2 end
    if self.Async then
        local brakeSqueal = self:GetNW2Float("BrakeSqueal",0)
        if (brakeSqueal) > 0.0 then
            local nominalSqueal = self:GetNWFloat("SqualPitch",1)
            local secondSqueal = math.Clamp(1-(speed-2)/5,0,1)
            local squealPitch = nominalSqueal+secondSqueal*0.05
            local squealVolume = math.Clamp(speed/2,0,1)

            local volume = brakeSqueal*squealVolume
            self:SetSoundState("brakea_loop1",volume*(1-secondSqueal*0.5)*0.4,squealPitch,false,75)
            self:SetSoundState("brakea_loop2",volume*secondSqueal*0.4,squealPitch,false,75)
        else
            self:SetSoundState("brakea_loop1",0,0)
            self:SetSoundState("brakea_loop2",0,0)
        end
        self:SetSoundState("brake_loop1",0,0)
        self:SetSoundState("brake_loop2",0,0)
        self:SetSoundState("brake_loop3",0,0)
        self:SetSoundState("brake_loop4",0,0)
        self:SetSoundState("brake_loopb",0,0)
        self:SetSoundState("brake2_loop1",0,0)
        self:SetSoundState("brake2_loop2",0,0)
    else
        local squealSound = self:GetNW2Int("SquealSound",0)
        local brakeSqueal1 = math.max(0.0,math.min(2,self:GetNW2Float("BrakeSqueal1")))--FIXME math.max(0.0,math.min(1,self:GetNW2Float("BrakeSqueal1")))
        --local brakeSqueal2 = 0--FIXME local brakeSqueal2 = math.max(0.0,math.min(1,self:GetNW2Float("BrakeSqueal2")))
        --local brakeSqueal2 = math.max(0.0,math.min(1,self:GetNW2Float("BrakeSqueal2")))
        --local brakeRamp = math.min(1.0,math.max(0.0,speed/2.0))
        local brakeRamp1 = math.min(1.0,math.max(0.0,(speed-10)/50.0))^1.5
        local brakeRamp2 = math.min(1.0,math.max(0.0,speed/3.0))
        if true or (brakeSqueal1) > 0.0 then
            local ramp = 0.3+math.Clamp((40-speed)/40,0,1)*0.7
            local typ = self:GetNW2Int("SquealType",1)
            self:SetSoundState("brake_loop1",typ==1 and soundsmul*brakeSqueal1*ramp*0.2 or 0,1+0.05*(1.0-brakeRamp2))
            self:SetSoundState("brake_loop2",typ==2 and soundsmul*brakeSqueal1*ramp or 0,1+0.05*(1.0-brakeRamp2))
            self:SetSoundState("brake_loop3",typ==3 and soundsmul*brakeSqueal1*ramp or 0,1+0.05*(1.0-brakeRamp2))
            self:SetSoundState("brake_loop4",typ==4 and soundsmul*brakeSqueal1*ramp or 0,1+0.05*(1.0-brakeRamp2))
            self:SetSoundState("brake_loopb",typ<=4 and 0*soundsmul*brakeSqueal1*ramp*0.4 or 0,1+0.05*(1.0-brakeRamp2))
            --spb only
            local loop_h = soundsmul*brakeSqueal1*ramp*0.5
            if typ>=5 and loop_h > 0.1 and speed > 1.5 then
                if not self.HighLoop then
                    self.HighLoop = math.random()>0.5 and "brake_squeal2" or "brake_squeal1"
                end
                self:SetSoundState(self.HighLoop,loop_h*1.5,1)
            elseif loop_h<0.02 and self.HighLoop then
                self:SetSoundState(self.HighLoop,0,0)
                self.HighLoop = false
            end
            self.StartLoopStrength = loop_h
            self:SetSoundState("brake2_loop1",(typ==5 or typ==6) and math.Clamp(loop_h*0.5,0,0.5) or 0,1+0.06*(1.0-brakeRamp2))
            self:SetSoundState("brake2_loop2",typ>=6 and loop_h*0.3 or 0,1+0.06*(1.0-brakeRamp2))
            --self:SetSoundState("brake_loop2",brakeSqueal*brakeRamp2*0.2,1+0.06*(1.0-brakeRamp2))
        else
            self:SetSoundState("brake_loop1",0,0)
            self:SetSoundState("brake_loop2",0,0)
            self:SetSoundState("brake_loop3",0,0)
            self:SetSoundState("brake_loop4",0,0)
            self:SetSoundState("brake_loopb",0,0)
            self:SetSoundState("brake2_loop1",0,0)
            self:SetSoundState("brake2_loop2",0,0)
        end
        self:SetSoundState("brakea_loop1",0,0)
        self:SetSoundState("brakea_loop2",0,0)
    end

    -- Generate procedural landscape thingy
    local a = self:GetPos().x
    local b = self:GetPos().y
    local c = self:GetPos().z
    local f = 1--math.sin(c/200 + a*c/3e7 + b*c/3e7) --math.sin(a/3000)*math.sin(b/3000)
    -- Calculate flange squeal
    self.PreviousAngles = self.PreviousAngles or self:GetAngles()
    local deltaAngleYaw = math.abs(self:GetAngles().yaw - self.PreviousAngles.yaw)
    deltaAngleYaw = (deltaAngleYaw) % 360
    if deltaAngleYaw >= 180 then
        deltaAngleYaw = deltaAngleYaw - 360
    end
    --speed = 80
    local speedAdd = math.max(1,math.min(2,1-(speed-60)/40))
    local deltaAngle = deltaAngleYaw/math.max(0.1,self.DeltaTime)*speedAdd
    deltaAngle = math.max(math.min(1.0,f*10)*math.abs(deltaAngle),0)

    self.PreviousAngles = self:GetAngles()
    -- Smooth it out
    self.SmoothAngleDelta = self.SmoothAngleDelta or 0
    local speedSmooth = 4--20-math.Clamp((speed-10)/40,0,1)*16
    self.SmoothAngleDelta = math.min(7,self.SmoothAngleDelta + (deltaAngle - self.SmoothAngleDelta)*2*self.DeltaTime)
    --[[ if (not (self.SmoothAngleDelta <= 0)) and (not (self.SmoothAngleDelta >= 0)) then
        print(self.SmoothAngleDelta)
        self.SmoothAngleDelta = 0
    end--]]
    -- Create sound
    local speed_mod = math.min(1.0,math.max(0.0,speed/5))
    local flangea = math.Clamp((speed-18)/25,0,1)
    local x = self.SmoothAngleDelta
    local f1 = math.max(0,x-0.5)*0.1
    local f2 = math.max(0,x-3-flangea*1)*0.6
    local f3 = math.max(0,x-4.0-flangea*1.5)*0.6
    local t = RealTime()
    local modulation = 1.5*math.max(0,0.2+math.sin(t)*math.sin(t*3.12)*math.sin(t*0.24)*math.sin(t*4.0))
    local pitch40 = math.max(0.9,1.0+(speed-40.0)/160.0)
    local pitch60 = math.max(0.9,1.0+(speed-60.0)/160.0)
    -- Play it
    self:SetSoundState("flangea",(0.3+soundsmul*0.7)*(speed_mod)*math.Clamp(f2,0,1),pitch40)
    self:SetSoundState("flangeb",(0.3+soundsmul*0.7)*(speed_mod)*math.Clamp(f3*modulation,0,1),pitch40)
    self:SetSoundState("flange1",(0.3+soundsmul*0.7)*(speed_mod)*f1*modulation,pitch40)
    self:SetSoundState("flange2",(0.3+soundsmul*0.7)*(speed_mod)*f1,pitch40)
end


function ENT:Draw()
    self:DrawModel()
    --render.DrawLine(self:GetPos(),self:LocalToWorld(Vector(100,0,0)), Color(255,0,0), false)
end


local c_gui
if IsValid(c_gui) then c_gui:Close() end

local function addButton(parent,stext,state,scolor,btext,benabled,callback)
    --local a = v[1]
    local panel = vgui.Create("DPanel")
    panel:Dock( TOP )
    panel:DockMargin( 5, 0, 5, 5 )
    panel:DockPadding( 5, 5, 5, 5 )
    if benabled then
        local button = vgui.Create("DButton",panel)
        button:Dock(RIGHT)
        button:SetText(Metrostroi.GetPhrase(btext))
        button:DockPadding( 5, 5, 5, 5 )
        button:SizeToContents()
        button:SetContentAlignment(5)
        button:SetEnabled(benabled)
        button.DoClick = callback
    end

    --DrawCutText(panel,Metrostroi.GetPhrase("Workshop.Warning"),false,"DermaDefaultBold")
    vgui.MetrostroiDrawCutText(panel,Metrostroi.GetPhrase(stext),false,"DermaDefaultBold")
    vgui.MetrostroiDrawCutText(panel,Metrostroi.GetPhrase(state),scolor,"DermaDefaultBold")

    panel:InvalidateLayout( true )
    panel:SizeToChildren(true,true )
    parent:AddItem(panel)
end

function ENT:DrawGUI(tbl)
    if IsValid(c_gui) then  c_gui:Close() end
     local c_gui = vgui.Create("DFrame")
        c_gui:SetDeleteOnClose(true)
        c_gui:SetTitle(Metrostroi.GetPhrase("Common.Bogey.Title"))
        c_gui:SetSize(0, 0)
        c_gui:SetDraggable(true)
        c_gui:SetSizable(false)
        c_gui:MakePopup()
    local scrollPanel = vgui.Create( "DScrollPanel", c_gui )
    addButton(scrollPanel,"Common.Bogey.ContactState",tbl.relcontact and "Common.Bogey.CReleased" or "Common.Bogey.CPressed",tbl.relcontact and Color(150,50,0) or Color(0,150,0),tbl.relcontact and "Common.Bogey.CPress" or "Common.Bogey.CRelease",tbl.access,function(button)
        net.Start("metrostroi-bogey-menu")
            net.WriteEntity(self)
            net.WriteUInt(0,8)
        net.SendToServer()
        c_gui:Close()
    end)
    if tbl.havepb then
        addButton(scrollPanel,"Common.Bogey.ParkingBrakeState",tbl.pbdisabled and "Common.Bogey.PBDisabled" or "Common.Bogey.PBEnabled", Color(0,150,0),tbl.pbdisabled and "Common.Bogey.PBEnable" or "Common.Bogey.PBDisable",tbl.access,function(button)
            net.Start("metrostroi-bogey-menu")
                net.WriteEntity(self)
                net.WriteUInt(1,8)
            net.SendToServer()
            c_gui:Close()
        end)
    end

    scrollPanel:Dock( FILL )
    scrollPanel:InvalidateLayout( true )
    scrollPanel:SizeToChildren(false,true)
    local spPefromLayout = scrollPanel.PerformLayout
    function scrollPanel:PerformLayout()
        spPefromLayout(self)
        if not self.First then self.First = true return end
        local x,y = scrollPanel:ChildrenSize()
        if self.Centered then return end
        self.Centered = true
        c_gui:SetSize(512,math.min(350,y)+35)
        c_gui:Center()
    end
end


net.Receive("metrostroi-bogey-menu",function()
    local ent = net.ReadEntity()
    if not IsValid(ent) or IsValid(c_gui) and c_gui.Entity ~= ent then return end
    ent:DrawGUI{
        access = net.ReadBool(),
        relcontact=net.ReadBool(),
        havepb=net.ReadBool(),
        pbdisabled=net.ReadBool(),
    }
end)
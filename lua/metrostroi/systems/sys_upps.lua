--------------------------------------------------------------------------------
-- UPPS safety system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("UPPS")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("UPPS_VV")
    self.Train:LoadSystem("UPPS_On","Relay","Switch", {bass = true,normally_closed = true})
    self.Train:LoadSystem("UPPS_K1","Relay","Switch")

    self.Power = false

    self.Controlling = false
end

function TRAIN_SYSTEM:Outputs()
	return {}
end

function TRAIN_SYSTEM:Inputs()
	return {}
end

function TRAIN_SYSTEM:TriggerSensor(coil,plate)
    if self.Power == true and not self.Controlling and plate.DistanceToOPV then
        self.Controlling = plate.DistanceToOPV
        self.Train:PlayOnce("upps","cabin",1)
        self.KBTimer = CurTime()
    end
end
function TRAIN_SYSTEM:Think(dT)
	local Train = self.Train
    local ALS = Train.ALSCoil
    local speed = ALS.Speed*ALS.SpeedSign
    local VV = Train.UPPS_VV

    if VV.Power > 0 and not self.Power then self.Power = CurTime() end
    if VV.Power == 0 and self.Power then
        self.Power = false
        self.Controlling = false
        self.Stopping = false
        self.KBTimer = false
        Train:PlayOnce("upps","stop",1)
    end
    if self.Power and self.Power~=true and CurTime()-self.Power > 6 then
        Train:PlayOnce("upps","cabin",1)
        self.Power = true
    end
    if self.KBTimer and CurTime()-self.KBTimer > 3 then
        self.KBTimer = false
        --RunConsoleCommand("say","NO CANCEL")
        --print("NO CANCEL")
    end
    if self.Controlling and (Train.ALSCoil.Speed < 5.5 or self.KBTimer and VV.KB > 0) then
        --print("END. ",self.Controlling)
        --RunConsoleCommand("say","END. "..self.Controlling)
        self.Controlling = false
        self.Stopping = false
        self.KBTimer = false
    end
    if self.Controlling then
        local SchemeEngageDistance,_ACCEL,_ACCEL2
        local speedMS = speed/3600*1000
        local currA = -math.min(0,Train.Acceleration)
        if Train:ReadTrainWire(6) == 0 then
            _ACCEL = 1.2
            _ACCEL2 = _ACCEL*2

            local _SCHTime = (math.Clamp((45-(speed-10))/45,0,1)*2.5+1)*math.Clamp((_ACCEL-currA)/_ACCEL,0,1)

            SchemeEngageDistance = speedMS*_SCHTime+(_ACCEL*(_SCHTime^2))/2
            --print(Format("%.1f %.1f %.1f %.2f %.2f",(self.Controlling-SchemeEngageDistance),SchemeEngageDistance,(speedMS^2)/_ACCEL2,_SCHTime,currA,math.Clamp((0.7-(currA-0.7))/0.7,0,1)))
        else
            _ACCEL = 1.2 --1.45
            _ACCEL2 = _ACCEL*2

            local _SCHTime = (math.Clamp((50-(speed-10))/50,0,1)*1.3+0.7)*math.min((1-Train:ReadTrainWire(2)),1)*math.Clamp((1.2-currA)/1.2,0.2,1)
            --SchemeEngageDistance = speedMS*_SCHTime+(_ACCEL*(_SCHTime^2))/2-math.Clamp(3-(self.Controlling-10)/20,0,3)-3.5
            SchemeEngageDistance = speedMS*_SCHTime+(_ACCEL*(_SCHTime^2))/2-math.Clamp(5-(self.Controlling-10)/6,0,5)-3.5
            --local _SCHTime = (math.Clamp((45-(speed-10))/45,0,1)*2.5*(1-Train:ReadTrainWire(6))+1)*math.min((1-Train:ReadTrainWire(2))+Train:ReadTrainWire(25),1)*math.Clamp((1.4-currA)/1.4,0,1)
            --print(Format("%.1f %.1f %.1f %.2f %.2f",(self.Controlling-SchemeEngageDistance),SchemeEngageDistance,(speedMS^2)/_ACCEL2,_SCHTime,math.min(0,-Train.Acceleration),math.Clamp((0.7-(currA-0.7))/0.7,0,1)))
        end
        --local SchemeEngageDistance = speedMS*_SCHTime+(_ACCEL*(_SCHTime^2))/2-Train:ReadTrainWire(6)
        self.Controlling = self.Controlling + (-speedMS)*dT
        if (self.Controlling-SchemeEngageDistance) < (speedMS^2)/_ACCEL2 and not self.Stopping then
            self.Stopping = true
            Train:PlayOnce("upps","cabin",1)
            --print("!!!")
        end
    end
    Train.UPPS_K1:TriggerInput("Set",(self.Power and self.Controlling and self.Stopping) and 1 or 0)
end

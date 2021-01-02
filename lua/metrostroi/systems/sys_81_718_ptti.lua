--------------------------------------------------------------------------------
-- 81-718 traction controller
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_718_PTTI")

function TRAIN_SYSTEM:Initialize()
    self.State = 0
    self.PTTIState = 0


    self.Zero = false

    self.FreqStart = nil
    self.FreqState = 0
    self.FreqBlock = 0

    self.T = 0

    self.RN = 0
    self.RNState = 0
    self.RNResistance = 1e9
    self.RVState = 0.0
    self.RVResistance = 1e9
    self.SubIterations = 16
end

function TRAIN_SYSTEM:Inputs()
    return {  }
end

function TRAIN_SYSTEM:Outputs()
    return { "State","RN","RNState","RN","RNState","FreqState" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end

function TRAIN_SYSTEM:Think(dT,iter)
    local Train = self.Train
    local BUV = Train.BUV
    local T = math.abs(BUV.ISet or 0)
    local I = math.abs(Train.Electric.I13 + Train.Electric.I24)/2

    if self.State ~= BUV.PTTIState then
        --self.PTTIState = BUV.PTTIState or 0
        if self.State ~= 0 then
            self.State = 0
        else
            self.State = BUV.PTTIState or 0
        end
    end

    if self.State ~= 0 and T == 0 and not self.Zero and math.abs(I) < 25 then
        self.Zero = true
        self.State = 0
    end

    if self.State == 0 then
        self.Zero = false
        self.RN = 0
        self.RV = false
        self.RNState = 0
        self.RVState = 0
        self.FreqStart = nil
        self.FreqState = 0
        self.RNBrakeReset = false
        self.T = 0
        self.PrepareElectric = false
    end

    if self.State == 1 then
        if not self.RV and self.RN == 0 then
            self.RN = 1
            self.RV = false
            self.RNState = 0
            self.RVState = 0
            self.FreqState = 0
            self.FreqStart = nil
        end
        ---[[
        if BUV.FreqBlock == 0 and not self.FreqStart then self.FreqStart = CurTime() end
        if BUV.FreqBlock > 0 and T > 0 then
            self.FreqState = 1/3
            self.FreqStart = CurTime()
            T = 50
        elseif T > 0 and self.FreqStart and self.FreqStart ~= true then
            self.FreqState = 1/3+(math.max(0,math.floor((CurTime()-self.FreqStart)/2*12)/12))*(2/3)
            --print(math.floor((CurTime()-self.FreqStart)/1.5*12))
            --self.FreqState = 1/3+math.max(0,(CurTime()-self.FreqStart)*1*(2/3))--math.max(0,math.floor((CurTime()-self.FreqStart)*1.5*8)/8)*(2/3)
            T = self.FreqState*T
        end
        if self.FreqState > 1 and self.FreqStart then
            self.FreqStart = true
            self.FreqState = 1
        end--]]
    end

    if self.State == -1 then
        if self.PrepareElectric and (CurTime()-self.PrepareElectric > 0.8 or I > T*0.8) then
            --self.RVState = 0.01
            self.RN = self.RVState == 1 and 1 or 0
            self.RV = self.RVState < 1
            if self.RN == 0 then
                --self.RNBrakeReset = true
                self.RNState = 0
            end
            self.PrepareElectric = false
        end
        --[[ if self.RNState == 0 or self.RN > 0 then
            self.RNBrakeReset = false
        end
        if self.RNBrakeReset then
            self.RNState = math.max(0,math.min(1,self.RNState-0.3*dT))
        end--]]
        --[[ if not self.RV and self.RN == 0 or self.PrepareElectric then
            self.RN = 0
            self.RV = false
            self.RNState = 0.93-(math.max(0,math.min(1,(Train.Engines.Speed-18)/60))^0.6)*0.85
            self.RVState = 1-math.max(0,math.min(1,((Train.Engines.Speed-50)/32))^0.8)*0.75

            if not self.PrepareElectric then self.PrepareElectric = CurTime() end
        end--]]
        if not self.RV and self.RN == 0 and not self.PrepareElectric then
            self.RN = 0
            self.RV = false
            self.RNState = 0.93-(math.max(0,math.min(1,(Train.Engines.Speed-18)/60))^0.6)*0.85
            self.RVState = 1-(math.max(0,math.min(1,(Train.Engines.Speed-50)/32))^0.8)*0.75

            self.PrepareElectric = CurTime()
        end
    end
    if (self.RN > 0 or self.RV) and self.SpeedUp and I > T*0.8 then self.SpeedUp = false end
    --if self.RN == 0 and not self.RV and not self.SpeedUp then self.SpeedUp = true end

    if T < self.T then
        self.T = self.T+(T*(0.95+math.random()*0.1)-self.T)*dT*4--6
    else
        self.T = self.T+(T*(0.95+math.random()*0.1)-self.T)*dT*1.5--3
    end
    --if I > T then print(self.RNState,self.RVState,I,T,self.PrepareElectric) end

    self:SolveRV(Train,self.T,dT,I,self.State < 0)
    self:SolveRN(Train,self.T,dT,I,self.State < 0)
end

function TRAIN_SYSTEM:SolveRN(Train,T,dT,I,brake)
    -- General state
    local Active = self.RN > 0--and  T > 0
    --local I = math.abs(Train.Electric.I13 + Train.Electric.I24)/2
    self.RNPrevCurrent = Current

    local rnd = 30+math.random()*20
    if self.SpeedUp then
        rnd = brake and 25+((Train.Engines.Speed/80)^4)*100 or 25
        --print(rnd)
    end
    -- Update RN controller signal
    if Active then
        local sign = brake and 1 or 1
        -- Generate control signal
        local dC = math.min(math.abs(T-I),300)

        if T == 0 then
            self.RNState = math.max(0,self.RNState-5*dT*sign)
        elseif I > T then
            self.RNState = math.max(0,math.min(1,self.RNState-dC*1/rnd*dT*sign))
        else
            self.RNState = math.max(0,math.min(1,self.RNState+dC*1/rnd*dT*sign))
        end
        if (not brake and self.RNState == 1 or brake and self.RNState == 0) and self.RN > 0 and not self.RV then
            self.RV = true
            self.RN = 0
            self.RVState = brake and 0.99 or 0.01
        end
    end
end
function TRAIN_SYSTEM:SolveRV(Train,T,dT,I,brake)
    -- General state
    local Active = self.RV
    --local I = math.abs(Train.Electric.I13 + Train.Electric.I24)/2
    self.RNPrevCurrent = Current

    -- Controllers resistance
    local Resistance = 0.036

    local speedMul = math.max(0,math.min(1,(Train.Engines.Speed-40)/40))
    local rnd = 30+math.random()*(20)
    if self.SpeedUp then
        rnd = brake and 25+((Train.Engines.Speed/80)^4)*100 or 25
    end

    -- Update RV controller signal
    if Active then
        local sign = brake and -1 or 1
        -- Generate control signal

        local dC = math.min(math.max(math.abs(T-I),1,  300))
        if not self.PrepareElectric then
            if T == 0 then
                self.RVState = math.max(0,self.RVState-5*dT*sign)
            elseif brake and I<T or not brake and I > T then
                self.RVState = math.max(0,math.min(1,self.RVState-dC*1/rnd*dT*sign))
            else
                self.RVState = math.max(0,math.min(1,self.RVState+dC*1/rnd*dT*sign))
            end
        end

        -- Generate resistance
        local keypoints = {
            0.10,0.008,
            0.20,0.018,
            0.30,0.030,
            0.40,0.047,
            0.50,0.070,
            0.60,0.105,
            0.70,0.165,
            0.80,0.280,
            0.90,0.650,
            1.00,15.00,
        }
        local TargetField
        if self.State < 0 then
            TargetField = 0.4 + 0.6*self.RVState
        else
            TargetField = 0.4 + 0.6*(1-self.RVState)
        end
        --TargetField = 0.4 + 0.6*(1-self.RVState)
        local Found = false
        for i=1,#keypoints/2 do
            local X1,Y1 = keypoints[(i-1)*2+1],keypoints[(i-1)*2+2]
            local X2,Y2 = keypoints[(i)*2+1],keypoints[(i)*2+2]

            if (not Found) and (not X2) then
                Resistance = Y1
                Found = true
            elseif (TargetField >= X1) and (TargetField < X2) then
                local T = (TargetField-X1)/(X2-X1)
                Resistance = Y1 + (Y2-Y1)*T
                Found = true
            end
            if (self.State > 0 and self.RVState == 0 or self.State < 0 and self.RVState == 1) and self.RV and self.RN == 0 then
                self.RV = false
                self.RN = 1
                self.RNState = brake and 0.01 or 0.99
            end
        end
        --[[
        if Train:EntIndex() == 1275 and iter%4 == 0 then
            print(Format("[%04d]RV:% 3.01f/% 3.01f A % 3d%% %.2f+%.2f=%.2f % 3d km\\h F=%.02f",Train:EntIndex(),Current,T,self.RVState*100,A,B,C,Train.Speed,TargetField))
        end]]
    end
    -- Set resistance
    self.RVResistance = Resistance + 1e9 * (Active and 0 or 1)
end


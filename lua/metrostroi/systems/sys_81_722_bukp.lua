--------------------------------------------------------------------------------
-- 81-722 train control unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_722_BUKP")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.CurrentCab = false
    self.Trains = {}

    self.PVU = {}

    self.Power = 0
    self.Active = 0
    self.Back = 0

    self.SOSD = 0
    self.LPT = false

    self.Speed = 0

    self.PowerCommand = 0

    self.DoorLeft = 0
    self.DoorRight = 0
end

function TRAIN_SYSTEM:Outputs()
    return {"Active","Back","SOSD","PowerPrecent","DoorRight","DoorLeft"}
end

function TRAIN_SYSTEM:Inputs()
    return {}
end
if TURBOSTROI or CLIENT then return end

function TRAIN_SYSTEM:TriggerInput(name,value)
end

function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,data)
    if textdata == "Init" then
        self.UnInitialized[sourceid] = data
        return
    end
    if not self.Trains[sourceid] then return end
    if textdata == "Get" then
        self.Reset = CurTime()
    elseif self.Trains[sourceid] then
        self.Trains[self.Trains[sourceid]][textdata] = data
    end
end
function TRAIN_SYSTEM:CState(name,value,target,bypass)
    local BUKV = self.Train.BUKV
    if self.Reset or self.States[name] ~= value or bypass then
        for i,t in ipairs(self.Trains) do
            self.Train:CANWrite("BUKP",BUKV.TrainIndex,target or "BUKV",t.ID,name,value)
        end
        self.States[name] = value
    end
end

function TRAIN_SYSTEM:CStateTarget(name,targetname,targetsys,targetid,value)
    local BUKV = self.Train.BUKV
    if self.Reset or self.States[name] ~= value or bypass then
        self.States[name] = value
        self.Train:CANWrite("BUKP",BUKV.TrainIndex,targetsys,targetid,targetname,value)
    end
end
function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    local Electric = Train.Electric
    local BUKV = Train.BUKV
    self.Power = Train.SF19.Value*Train.Electric.Power
    local Power = self.Power>0
    if self.State ~= Power then
        if Power then
            self.States = {}
            self.Trains = {}
            self.Prepared = CurTime()-9.5
            self.CheckTrain = nil
        else
            self.Prepared = false
            self.CheckTrain = false
        end
        self.State = Power
    end

    if self.State and self.Prepared and self.Prepared ~=  true and CurTime()-self.Prepared > 10 then
        self.Prepared = CurTime()
        self.CheckTrain = CurTime()-0.8
        self.UnInitialized = {}
        self.BackCab = nil
        self.Trains = {}
        self.Strength = 0
        self.Train:CANWrite("BUKP",BUKV.TrainIndex,"BUKV",false,"Init")
    end
    if self.CheckTrain and CurTime()-self.CheckTrain > 1 then

        local builded = false
        local curr,new = BUKV.TrainIndex
        for i=1,8 do
            for k,t in pairs(self.UnInitialized) do
                if k == curr then
                    self.Trains[curr] = table.insert(self.Trains,{Type=t.type,ID=curr})
                    if i>1 and t.type==0 and (#self.Trains==3 or #self.Trains==6) then
                        builded = true
                        break
                    end
                    if not t.front and not t.rear then
                        break
                    end
                    if t.front and not self.Trains[t.front] then
                        new = t.front
                    elseif t.rear and not self.Trains[t.rear] then
                        new = t.rear
                    end
                    self.UnInitialized[k] = nil
                    break
                end
            end
            if not new or curr==new then
                break
            end
            curr=new
        end
        self.CheckTrain = false
        if builded then
            self.Prepared = true
            for i,t in ipairs(self.Trains) do
                self.Train:CANWrite("BUKP",BUKV.TrainIndex,"BUKV",t.ID,"Get")
                if t.Type == 0 and t.ID ~= BUKV.TrainIndex then
                    self.BackCab = t.ID
                end
                self.PVU[i] = {}
            end
        else
            self.Trains = {}
        end
    end

    self.LSD = true
    local back
    if self.Prepared==true then
        self.LPT = false
        local sosd,ring
        for i,train in ipairs(self.Trains) do
            for iD=1,8 do
                if not train["Door"..iD.."Closed"] then
                    self.LSD = false
                    break
                end
            end
            if train.DPBD1 then
                self.LPT = true
            end
            if train.OldBUKVTimer ~= train.BUKVTimer then
                train.BUKVWork = CurTime()
                train.OldBUKVTimer = train.BUKVTimer
            end
            if train.BUKVWork and CurTime()-train.BUKVWork>3 then
                train.BUKVWork = false
            end
            if not train.AsyncAssembly and not train.NoAssembly and self.PowerCommand ~= 0 then train.NoAssembly=CurTime() end
            if train.NoAssembly and (train.AsyncAssembly or self.PowerCommand==0) then train.NoAssembly=CurTime() end
            if train.NoAssembly and train.NoAssembly~=true and CurTime()-train.NoAssembly > 2 then train.NoAssembly=true end

            if train.Type == 0 and train.ID ~= BUKV.TrainIndex and train.CabActive then
                back = true
            end
            if train.SOSD then sosd = not sosd end
            if train.Ring then ring = true end
        end
        if back or Electric.CabActiveVRU>0 then self.Active = 0 end
        self.Back = (back and Electric.CabActive==0) and 1 or 0
        self.SOSD = sosd and 1 or 0
        self.Ring = ring or Train:GetNW2Int("MFDUError") == 11 or (Train:GetNW2Int("MFDUError") == 3 and self.Speed<3)

        self:CState("CabActive",Electric.CabActive>0,"BUKP")
        self:CState("SOSD",Train.SF24.Value>0 and Train.SOSDEnable.Value>0,"BUKP")
        self:CState("Ring",Train.Ring.Value > 0 and Electric.CabActive == 0,"BUKP")
        self.Speed = Train.Speed
    else
        self.LPT = false
        self.SOSD = 0
        self.Ring = 0
        self.Active = 0
        self.Speed = 0
        self.Back = 0
    end
    local RR = Train.KRO.Value~=1
    if self.Prepared==true and Electric.CabActive>0 and Electric.Emer == 0 then
        local MFDU = Train.MFDU
        local TrainCount = #self.Trains
        local TrainCHalf = TrainCount/2
        if not self.PVU.Sync then
            for i,t in ipairs(self.Trains) do
                for p=1,6 do
                    self.PVU[i][p] = t["PVU"..p]
                end
                Train:CANWrite("BUKP",Train:GetWagonNumber(),"BUKV",t.ID,"Orientate",i < #self.Trains/2)
            end
            self.PVU.Sync = true
        end
        local MK2c = 0
        local MK2m = 0
        local DriveCommand = self.PowerCommand>0
        local HVCount,NoHV = 0,0
        local pos = Train.BKCU.ControllerPosition

        local BARSPower = Train.BARS.Enabled>0
        --local block =
        MFDU:Error(3,1,(MFDU:ErrorGet("3_1") or pos>0 and not self.LastDrive) and BARSPower and Train.BARS.MOT==0)
        self.LastDrive = pos>0
        MFDU:Error(13,1,RR and (Train.Electric.BTBPower>0 and Train.Electric.BTB==0),0)
        MFDU:Error(14,1,Train.Pneumatic.TrainLinePressure<6.4)
        MFDU:Error(15,1,(MFDU:ErrorGet("15_1") or DriveCommand) and Train.Compressor.Value==0)
        MFDU:Error(38,1,back)
        --MFDU:Error(39,1,Train.VAD.Value>0)
        MFDU:Error(40,1,Train.VAD.Value>0)
        MFDU:Error(41,1,self.Speed>3 and Train.VAD.Value>0)
        MFDU:Error(43,1,BARSPower and Train.BARS.EPK==0,0)
        --MFDU:Error(16,1,DriveCommand and Train.Compressor.Value==0)
        MFDU:Error(55,1,NoHV>0 and NoHV==HVCount)
        MFDU:Error(59,1,(MFDU:ErrorGet("59_1") or DriveCommand) and Train.KRO.Value==0)
        MFDU:Error(60,1,(DriveCommand or MFDU:ErrorGet("60_1")) and Train.PassLight.Value==0)

        MFDU:Error(58,1,pos>0 and not RR)

        local errors = {[4]={},[7]={}}
        for i,t in ipairs(self.Trains) do
            for p=1,6 do
                self:CStateTarget("PVU"..i.."_"..p,"PVU"..p,"BUKV",t.ID,self.PVU[i][p])
            end
            if t.Type<=1 and Train.Compressor.Value == 1 then
                if i>TrainCHalf then--TrainCount<=3 and i>TrainCHalf or TrainCount>3 and i%2==0 then
                    MK2m = MK2m+1
                    if not t.MKTimeOut then t.MKTimeOut = CurTime() end
                    if t.MKTimeOut~=true or t.MKWork then MK2c = MK2c+1 end
                    if t.MKTimeOut and t.MKTimeOut ~= true and CurTime()-t.MKTimeOut>0.5 then t.MKTimeOut = true end
                end
                HVCount = HVCount + 1
                if t.NoHV then NoHV = NoHV+1 end
            else t.MKTimeOut = false end
            --MFDU:Error(4,i,DriveCommand and not t.DoorsClosed)
            --MFDU:Error(7,i,DriveCommand and t.EmergencyBrake)
            errors[4][i]=(MFDU:ErrorGet("4_"..i) or DriveCommand) and not t.DoorsClosed
            errors[7][i]=(MFDU:ErrorGet("7_"..i) or DriveCommand) and t.EmergencyBrake

            MFDU:Error(8,i,(MFDU:ErrorGet("8_"..i) or DriveCommand) and t.BCPressure>0.3,4)
            MFDU:Error(9,i,(MFDU:ErrorGet("9_"..i) or DriveCommand) and t.PBPressure<3)
            MFDU:Error(12,i,t.WagNOrientated,0.3)
            MFDU:Error(17,i,(MFDU:ErrorGet("17_"..i) or DriveCommand) and not t.LightsEnabled and Train.PassLight.Value>0)
            MFDU:Error(29,i,t.TFront or t.TRear or t.TLeft or t.TRight)
            if t.Type==0 then
                MFDU:Error(11,i,not t.CabActive and (t.TLeft or t.TRight or t.TFront),0.2)
            end

            MFDU:Error(37,i,not t.BUKVWork or CurTime()-t.BUKVWork > 3,0.5)
            MFDU:Error(42,i,t.DisablePant)
            if t.Orientation then
                MFDU:Error(56,i,not self.PVU[i][1] and self.States.OpenLeft and (t.Door1Closed or t.Door2Closed or t.Door3Closed or t.Door4Closed),1)
                MFDU:Error(57,i,not self.PVU[i][1] and self.States.OpenRight and (t.Door5Closed or t.Door6Closed or t.Door7Closed or t.Door8Closed),1)
            else
                MFDU:Error(56,i,not self.PVU[i][1] and self.States.OpenLeft and (t.Door5Closed or t.Door6Closed or t.Door7Closed or t.Door8Closed),1)
                MFDU:Error(57,i,not self.PVU[i][1] and self.States.OpenRight and (t.Door1Closed or t.Door2Closed or t.Door3Closed or t.Door4Closed),1)
            end
        end
        if #errors[4]<TrainCount then for i,v in ipairs(errors[4]) do MFDU:Error(4,i,v) end end
        if #errors[7]<TrainCount then for i,v in ipairs(errors[7]) do MFDU:Error(7,i,v) end end
        if pos == 2 then
            if self.PowerCommand < 0 then self.PowerCommand = 0 end
            self.PowerCommand = math.min(1,self.PowerCommand+dT*0.5)
            self.PowerDec = false
        elseif pos == 1 then
            if self.PowerCommand < 0 then self.PowerCommand = 0 end
            if self.PowerCommand < 0.2 then
                self.PowerCommand = math.min(0.2,self.PowerCommand+dT*0.5)
                self.PowerDec = false
            else
                local diff = math.Round((math.abs(self.PowerCommand*10)%1)/10,2)
                if diff>0 then
                    if self.PowerDec then
                        self.PowerCommand = math.max(self.PowerCommand-diff,self.PowerCommand-dT*0.5)
                    else
                        self.PowerCommand = math.min(self.PowerCommand+(0.1-diff),self.PowerCommand+dT*0.5)
                    end
                --else
                    --self.PowerCommand = math.max(self.PowerCommand+diff,self.PowerCommand+dT*0.5)
                end
            end
        elseif pos < -1 then
            self.PowerDec = true
            self.PowerCommand = math.max(-1,self.PowerCommand-dT*0.5)
        elseif pos < 0 then
            if self.PowerCommand > 0 then self.PowerCommand = 0 end
            if self.PowerCommand > -0.2 then
                self.PowerCommand = math.max(-0.2,self.PowerCommand-dT*0.5)
                self.PowerDec = true
            else
                local diff = math.Round((math.abs(self.PowerCommand*10)%1)/10,2)
                if diff>0 then
                    if self.PowerDec then
                        self.PowerCommand = math.max(self.PowerCommand-(0.1-diff),self.PowerCommand-dT*0.5)
                    else
                        self.PowerCommand = math.min(self.PowerCommand+diff,self.PowerCommand+dT*0.5)
                    end
                --else
                    --self.PowerCommand = math.max(self.PowerCommand+diff,self.PowerCommand+dT*0.5)
                end
            end
        elseif -0.1 > self.PowerCommand or self.PowerCommand > 0.1 then
            local sign = self.PowerCommand > 0 and -1 or 1
            if self.PowerCommand > 0 then
                self.PowerDec = true
                self.PowerCommand = math.max(0,self.PowerCommand-dT*0.5)
            else
                self.PowerDec = false
                self.PowerCommand = math.min(0,self.PowerCommand+dT*0.5)
            end
        else
            self.PowerCommand = 0
        end
        self.DoorsClosed = Train.Electric.LSD>0 and self.LSD and (self.DoorsClosed or pos<=0)
        MFDU:Error(64,1,Train.Electric.LSD==0 and (pos>0 or MFDU:ErrorGet("64_1")))
        --MFDU:Error(64,1,Train.Electric.LSD==0 and self.States.CloseDoors,4)
        MFDU:Error(5,1,not self.LSD and self.States.CloseDoors and (pos>0 or MFDU:ErrorGet("5_1")))
        if not RR or back or Train.BKCU.Emergency>0 then
            self.PowerCommand = 0
        elseif  self.PowerCommand>0 and (not self.DoorsClosed and Train.VAD.Value==0 or Train.BARS.MOT==0 and Train.RCARS.Value>0 or Train.RCARS.Value==0 and Train.PB.Value==0 and Train.VAH.Value==0 or self.Blocked) then
            self.PowerCommand = 0
            self.Blocked = true
        else
            self.Blocked = false
        --[[ elseif Train.BKCU.Emergency >0 then
            self.PowerCommand = -1--]]
        end
        local Command
        if Train.Pneumatic.EPKLeaking  then
            Command = 1
        elseif Train.BARS.T1 > 0 then
            Command = (Train.BARS.T1*0.5+Train.BARS.T2*0.4)
        end
        self.Braking = Command~=nil
        self:CState("DriveStrength",Command or math.abs(self.PowerCommand))
        self:CState("BrakeTPlus",pos < -1)
        self:CState("Brake",self.PowerCommand < 0 or Command~=nil)
        self:CState("ARSBrake",Train.BARS.T1 > 0)
        --Door controls
        self.DoorLeft = (RR and Train.DoorSelect.Value==0 and Train.DoorClose.Value==1 and self.Speed<3) and 1 or 0
        self.DoorRight = (RR and Train.DoorSelect.Value==1 and Train.DoorClose.Value==1 and self.Speed<3) and 1 or 0
        MFDU:Error(61,1,(Train.DoorLeft1.Value > 0 or Train.DoorLeft2.Value > 0) and self.DoorLeft == 0 or Train.DoorRight.Value > 0 and self.DoorRight == 0)
        self.OpenLeft = not self.States.CloseDoors and (Train.DoorLeft1.Value > 0 or Train.DoorLeft2.Value > 0) and self.DoorLeft > 0
        self.OpenRight = not self.States.CloseDoors and Train.DoorRight.Value > 0 and self.DoorRight > 0
        self:CState("OpenLeft",not self.States.CloseDoors and (self.States.OpenLeft or self.OpenLeft))
        self:CState("OpenRight",not self.States.CloseDoors and (self.States.OpenRight or self.OpenRight))
        if MFDU:ErrorGet("49_1") and MFDU:ErrorGet("49_1")[4] then
            if not self.BackDoors then
                self.BackDoors = CurTime()
            elseif self.BackDoors and CurTime()-self.BackDoors > 1 then
                self.BackDoors = nil
            end
        else
            self.BackDoors = nil
        end
        MFDU:Error(49,1,(Train.DoorBack.Value>0 and Train.DoorSelect.Value==1 or MFDU:ErrorGet("49_1") and self.BackDoors~=nil) and not self.States.CloseDoors)
        self:CState("OpenRightBack",self.BackDoors and self.BackDoors~=true)

        if self.CloseRing and (Train.DoorLeft1.Value > 0 or Train.DoorLeft2.Value > 0 or Train.DoorRight.Value > 0 or self.LSD) then self.CloseRing = false end
        if (not self.CloseRing or self.CloseRing and CurTime()-self.CloseRing<0) and Train.DoorClose.Value==2 and not self.LSD then self.CloseRing = CurTime() end
        self:CState("CloseDoors",RR and Train.SF7.Value>0 and (Train.DoorClose.Value == 0 or (not self.CloseRing and Train.DoorClose.Value==2 or self.CloseRing and CurTime()-self.CloseRing>4)))
        self:CState("PassLight",Train.PassLight.Value>0)
        self:CState("PassVent",Train.PassVent.Value-1)
        self:CState("ParkingBrake",Train.ParkingBrake.Value)

        self:CState("PN1",Train.BARS.V1>0)
        self:CState("PN2",Train.BARS.V2>0)
        self:CState("CloseRing",self.CloseRing and (CurTime()-self.CloseRing)%1<=0.5)
        --[[
        self:CState("RVPB",(1-Train.RV["KRO5-6"])*Train.SF2.Value > 0)
        self.ControllerState = stength
        self:CState("DriveStrength",math.abs(stength))
        self:CState("Brake",stength < 0 and 1 or 0)--]]
        local TL = self.Trains[1] and self.Trains[1].TLPressure or 0
        self.Compressor = self.Compressor and TL<8.2 or TL<6.5
        local DisableTP = Train.PantSC.Value*Train.SF13.Value+(1-Train.SF13.Value)
        for i,t in ipairs(self.Trains) do
            if self.Compressor then
                local compressor = Train.Compressor.Value==1 and (i>TrainCHalf--[[ TrainCount<=3 and i>TrainCHalf or TrainCount>3 and i%2==0--]] ) or Train.Compressor.Value==2 and i<=TrainCHalf or (Train.Compressor.Value==3) and i>TrainCHalf or Train.Compressor.Value==4
                if Train.Compressor.Value == 1 and MK2c<MK2m then
                    if t.MKWork then MK2c = MK2c+1 end
                    compressor=true
                end
                --if self.Compressor and Train.Compressor.Value==1
                Train:CANWrite("BUKP",Train:GetWagonNumber(),"BUKV",t.ID,"Compressor",compressor)
            else
                Train:CANWrite("BUKP",Train:GetWagonNumber(),"BUKV",t.ID,"Compressor",false)
            end
            Train:CANWrite("BUKP",Train:GetWagonNumber(),"BUKV",t.ID,"DisablePant",DisableTP == 2 and i>TrainCHalf or DisableTP==3 and i<=TrainCHalf or  DisableTP==4)
            --self:CStateTarget("Compressor","Compressor","BUV",t.id,false)
        end
        self.PowerPrecent = self.PowerCommand*100
    else
        if self.PVU and self.PVU.Sync then
            for i,t in ipairs(self.Trains) do
                Train:CANWrite("BUKP",Train:GetWagonNumber(),"BUKV",t.ID,"Compressor",false)
                --self:CStateTarget("Compressor","Compressor","BUV",t.id,false)
            end
            self.PVU.Sync = false
        end
        self.PowerCommand = 0
        self.PowerPrecent = 0
        self.DoorLeft = 0
        self.DoorRight = 0
        self.CloseRing = false
        Train.MFDU:ErrorsReset()
    end
    if self.Reset and self.Reset ~= CurTime() then
        if self.PVU then self.PVU.Sync = false end
        self.Reset = nil
    end
end

--------------------------------------------------------------------------------
-- 81-718 train control unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_718_BUP")

function TRAIN_SYSTEM:Initialize()
    self.Power = 0


    self.IV  = 0
    self.IN  = 0
    self.IX3 = 0
    self.IX2 = 0
    self.IX1 = 0
    self.I0  = 0
    self.IT1 = 0
    self.IT2 = 0
    self.IT3 = 0

    self.IBX3 = 0
    self.IBX2 = 0
    self.IBX1 = 0
    self.IB0 = 0
    self.IBT1 = 0
    self.IBT2 = 0
    self.IBT3 = 0

    self.IX = 0
    self.IT = 0

    self.IKDV = 0
    self.INKDV = 0
    self.IBKDV = 0
    self.IBBUP = 0
    self.IPB = 0
    self.IARS = 0
    self.IAVT = 0
    self.IPVU = 0
    self.IRPB = 0
    self.IV = 0
    self.IN = 0
    self.IROT = 0
    self.ISOT = 0

    self.BBUP = 0
    self.V0 = 0
    self.EKV = 0
    self.EBAV = 0
    self.EKR = 0
    self.EARS = 0

    self.OX = 0
    self.OXp = 0
    self.OT = 0
    self.OU1 = 0
    self.OU2 = 0
    self.OV = 0
    self.ON = 0
    self.O0 = 0
    self.OZPT = 0

    self.OBBAV = 0
    self.OBBUP = 0

    self.BlockX = 1
end

function TRAIN_SYSTEM:Inputs()
	return {  }
end

local outputs = {
    "Power",
    "IPB","IV","IN",
    "IX3","IX2","IX1","I0","IT1","IT2","IT3",
    "IBX3","IBX2","IBX1","IB0","IBT1","IBT2","IBT3",
    "IX","IT","IKDV","INKDV","IBKDV","IPB","IARS",
    "IAVT","IPVU","IRPB","IROT","ISOT",
    "BBUP","V0","EKV","EBAV","EKR","EARS",
    "OX","OT","OU1","OU2","OV","ON","O0","OZPT","OBBAV","OBBUP",
    }

function TRAIN_SYSTEM:Outputs()
	return outputs
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end

function TRAIN_SYSTEM:Think()
    self.CurTime = self.CurTime or CurTime()
    if CurTime()-self.CurTime < 0.05 then return end
    self.DeltaTime = CurTime()-self.CurTime
    self.CurTime = CurTime()
    local Train = self.Train
    local BKBD = Train.BKBD
    local BKCU = Train.BKCU

    if self.Power > 0 then
        --Обработка сигналов контроллера
        self.IX3 = Train.BKCU.Controller ==  3 and 1 or 0
        self.IX2 = Train.BKCU.Controller ==  2 and 1 or 0
        self.IX1 = Train.BKCU.Controller ==  1 and 1 or 0
        self.I0  = Train.BKCU.Controller ==  0 and 1 or 0
        self.IB0 = 1
        self.IT1 = Train.BKCU.Controller == -1 and 1 or 0
        self.IT2 = Train.BKCU.Controller == -2 and 1 or 0
        self.IT3 = Train.BKCU.Controller == -3 and 1 or 0

        self.BBUP = math.min(1,self.IBBUP*(1-self.OBBUP)+self.BBUP+self.LastBlock)
        if self.BBUP  == 0 then
            self.EKV = (self.IX3+self.IX2+self.IX1+self.I0+self.IT1+self.IT2+self.IT3)>1 and 1 or 0
            self.EKR = (self.IV+self.IN) > 1 and 1 or 0
            self.EARS = (self.IX+self.IT) > 1 and 1 or 0

            if self.EKV > 0 or self.EKR>0 then
                self.OX = 0
                self.OT = 0
            else
                local CanDrive = (self.IKDV+self.IBKDV)--*self.IPB
                if Train.BKCU.Controller > 0 then
                    self.OX =  (1-self.EARS)*(1-self.EKV)*CanDrive*(1-self.BlockX)*self.IX*(1-self.IT)*(1-self.IAVT) --501Г
                    self.BlockX = self.BlockX+(1-CanDrive)
                else
                    self.OX = 0
                    self.BlockX = 0
                end
                self.OT = Train.BKCU.Controller < 0 and 1 or 0 --502
            end
            if self.EKR > 0 then
                self.OV = 0
                self.ON = 0
            else
                self.OV = self.IV--505
                self.ON = self.IN--506
            end
            self.O0 = (1-self.OX)*(1-self.OT) --545
            if self.OX > 0 or self.OT > 0 then
                self.OU1 = math.abs(Train.BKCU.Controller) > 1 and 1 or 0 --503
                self.OU2 = math.abs(Train.BKCU.Controller) > 2 and 1 or 0 --504
            else
                self.OU1 = 0
                self.OU2 = 0
            end
            if self.IT>0 or self.IAVT>0 or self.OT > 0 and self.V0 == 0 then
                if not self.BrakeTimer then self.BrakeTimer = CurTime() end
            elseif self.BrakeTimer then
                self.BrakeTimer = false
            end
            if self.IT>0 then
                self.OT = 1
                self.OU1=1
                self.OU2=1
            end
            self.OZPT = self.BrakeTimer and CurTime()-self.BrakeTimer > 2.2 and math.min(1,self.OU2+self.IT) or 0

            self.OBBAV = self.OX+self.OT
            self.EBAV = (self.IBX3+self.IBX2+self.IBX1+self.IB0+self.IBT1+self.IBT2+self.IBT3)>1 and 1 or 0
            self.OBBUP = 1
        else
            self.EKV = 0
            self.EKR = 0
            self.EARS = 0

            self.OX = 0
            self.OT = 0
            self.OU1 = 0
            self.OU2 = 0
            self.OV = 0
            self.ON = 0
            self.O0 = 0
            self.OZPT = 0

            self.OBBAV = 0
            self.EBAV = 0
            self.OBBUP = 1
        end
    else
        self.BlockX = 1

        --self.IV  = 0
        --self.IN  = 0
        self.IX3 = 0
        self.IX2 = 0
        self.IX1 = 0
        self.I0  = 0
        self.IT1 = 0
        self.IT2 = 0
        self.IT3 = 0

        self.IBX3 = 0
        self.IBX2 = 0
        self.IBX1 = 0
        self.IB0 = 0
        self.IBT1 = 0
        self.IBT2 = 0
        self.IBT3 = 0
        --self.IX = 0
        --self.IT = 0

        --self.IKDV = 0
        --self.IBKDV = 0
        --self.IPB = 0
        self.IARS = 0
        --self.IAVT = 0
        self.IPVU = 0
        self.IRPB = 0
        self.IROT = 0
        self.ISOT = 0


        self.BBUP = 0
        self.LastBlock = self.IBBUP
        --self.V0 = 0
        self.EKV = 0
        self.EBAV = 0
        self.EKR = 0
        self.EARS = 0

        self.OX = 0
        self.OXp = 0
        self.OT = 0
        self.OU1 = 0
        self.OU2 = 0
        self.OV = 0
        self.ON = 0
        self.O0 = 0
        self.OZPT = 0

        self.OBBAV = 0
        self.OBBUP = 0
    end
end

--------------------------------------------------------------------------------
-- 81-718 wagon control unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_718_BUV")

function TRAIN_SYSTEM:Initialize()
    self.Power = 0
    --Индикация
    --Входные сигналы
    self.IVP=0;self.INZ=0;self.IVR=0;self.INR=0
    self.IX=0;self.IT=0;self.IU1=0;self.IU2=0;self.IM=0;self.IXP=0;self.IU1R=0
    self.ITARS=0;self.ITEM=0;self.IAVR=0
    self.IPROV=0;self.IPROV0=0;self.IVZ=0
    self.ITP1=0; self.ITP2=0; self.ITP3=0; self.ITP4=0;self.IKX=0;self.IKT=0;self.ILT=0;self.IRV=0;self.IRN=0;self.IBV=0
    --МАЛП 1,2
    self.FM=0;self.U400=0;self.E1350=0;self.DIF=0;self.E13650=0;self.E130=0
    --self.ARS=0;self.ITA=0;self.Tr=0;self.VN=0
    self.SN=0

    self.U800=0;self.U975= 0;self.E2450=0;self.E24650=0;self.E240=0
    self.BV=0
    --self.ITV=0
    self.MSU=0;self.MZK=0

    self.FreqBlock = 0
    --Выходные сигналы
    self.OVP=0;self.ONZ=0;self.OLK=0;self.OKX=0;self.OKT=0;self.OPV=0;self.OSN=0;self.ORP=0
    self.OIZ=0
    self.OV1=0;self.ORKT=0;self.ORMT=0
    self.O75V=0
    --МИВ
    self.ZZ=0;self.V1=0;self.SMA=0;self.SMB=0;
    --МВД
    self.OTK=0;self.RP=0;self.PROV=0
    --МЛУА
    self.SS = 0
end

function TRAIN_SYSTEM:Inputs()
	return {  }
end

local outputs = {"OTK","RP","FM","U400","E1350","DIF","E13650","E130","SN","U800","U975","E2450","E24650","E240","BV","MSU","MZK","ZZ","V1","SMA","SMB","IVP","INZ","IVR","INR","IX","IT","IU1","IU2","IM","IXP","IU1R","ITARS","ITEM","IAVR","IPROV","IPROV0","IVZ","ITP1","ITP2","ITP3","ITP4","IKX","IKT","ILT","IRV","IRN","IBV","OVP","ONZ","OLK","OKX","OKT","OPV","OSN","OIZ","ORP","OV1","ORKT","ORMT","O75V","SS"
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
    if self.Power > 0 then
        local I = math.abs(Train.Electric.I13 + Train.Electric.I24)/2
        --Управление
        local ARSBrake = self.ITARS > 0
        local Brake = self.IT > 0 or ARSBrake
        local Drive = (self.IX > 0 or  self.IM > 0) and not ARSBrake and not Brake
        local DriveEmer = self.IXP*(1-self.ITARS) > 0 and not ARSBrake
        local Combination = (Brake and 1 or 0)+(DriveEmer and 1 or 0)+(Drive and 1 or 0)
        local schemeCommands = Combination > 0

        local I13,I24 = math.abs(Train.Electric.I13),math.abs(Train.Electric.I24)
        local UHVp = Train.Electric.Power750V
        local UHV = Train.Electric.Main750V
        --self.MZK = 0
        if UHV > 1000 then self.FM = 1 end
        self.U400 = UHVp >= 400 and 1 or 0
        self.E1350 = I13 >= 40 and 1 or 0
        --Дифф защита не подключена
        --if math.abs(I13-I24) > 100 then self.DIF = 1 end
        if I13>650 then self.E13650 = 1 end
        if self.IPROV > 0 then self.E130 = 1-self.E1350 end
        --self.ARS = 0
        --self.ITA = 0
        --self.Tr = 0
        self.SN = 1-(self.IKX*self.ILT+self.IKT)*(self.IRV+self.IRN)
        --self.VN = 0

        --self.MSU = 0
        self.U800 = 650 < UHV and UHV < 975 and 1 or 0
        self.U975= UHV > 975 and 1 or 0
        self.E2450 = I24 >= 40 and 1 or 0
        if I24>650 then self.E24650 = 1 end
        if self.IPROV > 0 then self.E240 = 1-self.E2450 end
        self.BV = 1-Train.QF1.Value
        --self.ITV = 0

        --МВД
        self.OTK = (Train.PTTI.State == 0) and 1 or 1-self.E1350*self.E2450
        self.RP = self.FM+self.E13650+self.E130+self.E24650+self.E240+self.BV
        if schemeCommands and self.IPROV0 > 0 and (--[[ self.RP > 0 or --]] Train.PTTI.State == 0) then self.PROV = 1 end

        local disableScheme = self.RP+self.PROV+((ARSBrake and Train.PTTI.State > 0) and 1 or 0)+((Combination ~= 1 and Train.PTTI.State == 0) and 1 or 0)+self.IAVR
        self.MSU = disableScheme+((Drive or DriveEmer) and 1-self.U400 or 0)
        self.MZK = self.MSU

        if self.IVZ > 0 then
            self.PROV = 0
            self.FM = 0
            self.E13650 = 0
            self.E130 = 0
            self.E24650 = 0
            self.E240 = 0
            self.O75V = 0
        end
        if self.RP > 0 then self.O75V = 1 end
        --Управление ЛК и ПТТИ
        if disableScheme>0 or Train.PTTI.Zero then
            self.OVP = 0
            self.ONZ = 0
            self.OLK = 0
            self.OKX = 0
            self.OKT = 0
            self.Shunt = false
        elseif Drive and Train.PTTI.State >= 0 then
            self.OVP = self.IVP*(1-self.INZ)*(self.IX+self.IM)
            self.ONZ = self.INZ*(1-self.IVP)*(self.IX+self.IM)
            --self.OLK = self.OVP+self.ONZ--(self.IRV+self.IRN)
            self.OLK = (self.IRV+self.IRN)
            self.OKX = self.OLK--self.ILT
            self.OKT = 0
            self.Shunt = self.IM > 0--(self.Shunt or self.IM > 0) and self.IU1+self.IU2 == 0
        elseif DriveEmer and Train.PTTI.State >= 0  then
            self.OVP = self.IVR*(1-self.INR)*self.IXP
            self.ONZ = self.INR*(1-self.IVR)*self.IXP
            --self.OLK = self.OVP+self.ONZ--(self.IRV+self.IRN)
            self.OLK = (self.IRV+self.IRN)
            self.OKX = self.ILT
            self.OKT = 0
        elseif Brake and Train.PTTI.State <= 0 then
            self.OVP = self.IVP*(1-self.INZ)
            self.ONZ = self.INZ*(1-self.IVP)
            self.OLK = 0
            self.OKX = 0
            --self.OKT = self.OVP+self.ONZ--(self.IRV+self.IRN)
            self.OKT = (self.IRV+self.IRN)
        elseif Train.PTTI.State ~= 0 then
            self.Shunt = false
        end
        --Управление ПТТИ
        --if Train.PTTI.Zero then print(Train.PTTI.State,self.PTTIState,Train.PTTI.Zero) end

        local loadR = Train.Pneumatic.WeightLoadRatio*50
        if self.MZK > 0 then
            self.ISet = 0
            self.PTTIState = 0
        elseif self.IKX > 0 and Drive then
            self.PTTIState = 1
            self.FreqBlock = self.Shunt and 1 or 0--(((self.ITP1+self.ITP2+self.ITP3+self.ITP4) > 0 and not self.Shunt) and 0 or 1)
            self.ISet = ((self.ITP1+self.ITP2+self.ITP3+self.ITP4) > 0 and self.IM == 0) and 150+self.IU1*(90+loadR/2)+self.IU2*(90+loadR/2) or 150
        elseif self.IKX > 0 and DriveEmer then
            self.PTTIState = 1
            self.FreqBlock = 0
            self.ISet = 150+self.IU1R*280
        elseif self.IKT > 0 and Brake then
            self.PTTIState = -1
            if ARSBrake then
                self.ISet = -300
            else
                self.ISet = -(150+loadR+self.IU1*(75+loadR)+self.IU2*(75-loadR))
            end
        elseif Train.PTTI.Zero then
            self.ISet = 0
            self.PTTIState = 0
        elseif Train.PTTI.State == 1 and not Drive and not DriveEmer or Train.PTTI.State == -1 and not Brake then
            self.ISet = 0
        end

        --МЛУА
        self.SS = (self.IRV+self.IRN)*(Train.PTTI.State==1 and self.IKX or Train.PTTI.State==-1 and self.IKT or 0)
        --МИВ
        self.ZZ = math.floor(Train.PTTI.FreqState)
        self.V1 = (math.floor(Train.PTTI.RNState+0.03)+self.MSU)*self.OKT*self.IU1
        self.SMA = (Train.PTTI.State==-1 and Train.PTTI.RNState<=0.04 or Train.PTTI.State==1 and Train.PTTI.RNState>=0.96) and 1 or 0
        --self.SMA = (self.ISet ~= 0 and I13-20 < self.ISet and self.ISet < I13+20) and 1 or 0
        self.SMB = self.SMA--Train.PTTI.State==-1 and Train.PTTI.RNState<=0.04 or Train.PTTI.State==1 and Train.PTTI.RNState>=0.96
        --self.SMB = (self.ISet ~= 0 and I24-20 < self.ISet and self.ISet < I24+20) and 1 or 0
        --Входные сигналы
        --self.IVP = 0 --505
        --self.INZ = 0 --506
        --self.IVR = 0 --557
        --self.INR = 0 --558

        --self.IX = 0 --501
        --self.IT = 0 --502
        --self.IU1 = 0 --503
        --self.IU2 = 0 --504
        --self.IM = 0 --513
        --self.IXP = 0 --555
        --self.IU1R = 0 --556

        --self.ITARS = 0 --507
        --self.ITEM = 0 --514
        --self.IAVR = 0 --737


        --self.IPROV = 0 --527
        --self.IPROV0 = 0 --547
        --self.IVZ = 0 --526

        self.ITP1 = Train.TR.ContactState1
        self.ITP2 = Train.TR.ContactState2
        self.ITP3 = Train.TR.ContactState4
        self.ITP4 = Train.TR.ContactState3
        --self.IKX = 0 --738-739
        --self.IKT = 0 --740-741
        --self.ILT = 0 --742
        --self.IRV = 0 --743
        --self.IRN = 0 --744
        self.IBV = Train.QF1.Value --802 провод


        --Выходные сигналы
        --self.OLK = 0 -- 790
        --self.OKX = 0 -- 791
        --self.OKT = 0 -- 792
        --self.OPV = 0 -- 797
        self.OSN = schemeCommands and self.SN or 0
        self.OIZ = schemeCommands and self.OTK or 0
        --Train.BVA.DiableScheme = self.IPROV*self.OIZ + self.IPROV0*self.OSN
        self.ORP = (1-Train.QF1.Value)+self.E130+self.E240+self.PROV -- 528,725
        if ARSBrake then
            self.OV1 = Train.PTTI.RNState > 0.97 and 1 or 0
            self.ORKT = (I > -self.ISet*0.8) and 1 or 0
            self.ORMT = I>50 and 1 or 0
        elseif Brake then
            self.OV1 = Train.PTTI.RNState > 0.97 and self.IU1+self.IU2 or 0
            self.ORKT = (I > -self.ISet*0.8) and self.IU2 or 0
            self.ORMT = I>50 and 1 or 0
        else
            self.OV1 = 0 --795
            self.ORKT = 0 --804
            self.ORMT = 0 --805
        end
    else
        --Входные сигналы
        --self.IVP=0;self.INZ=0;self.IVR=0;self.INR=0

        --self.IX=0;self.IT=0;self.IU1=0;self.IU2=0;self.IM=0;self.IXP=0;self.IU1R=0

        --self.ITARS=0;self.ITEM=0;self.IAVR=0

        --self.IPROV=0;self.IPROV0=0;self.IVZ=0

        self.ITP1=0; self.ITP2=0; self.ITP3=0; self.ITP4=0;
        --self.IKX=0;self.IKT=0;self.ILT=0;self.IRV=0;self.IRN=0;
        self.IBV=0

        --МАЛП 1,2
        self.FM=0;self.U400=0;self.E1350=0;self.DIF=0;self.E13650=0;self.E130=0
        --self.ARS=0;self.ITA=0;self.Tr=0;self.VN=0
        self.SN=0

        self.U800=0;self.U975= 0;self.E2450=0;self.E24650=0;self.E240=0
        self.BV=0
        --self.ITV=0
        self.MSU=0;self.MZK=0
        --Выходные сигналы
        self.OVP=0;self.ONZ=0;self.OLK=0;self.OKX=0;self.OKT=0;self.OPV=0;self.OSN=0;self.ORP=0

        self.OIZ=0
        self.OV1=0;self.ORKT=0;self.ORMT=0
        self.O75V=0
        --МИВ
        self.ZZ=0;self.V1=0;self.SMA=0;self.SMB=0;
        --МВД
        self.OTK=0;self.RP=0;self.PROV=0
        --МЛУА
        self.SS = 0
    end
end

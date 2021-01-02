--------------------------------------------------------------------------------
-- Route number helper system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_71_RouteNumber")
TRAIN_SYSTEM.DontAccelerateSimulation = true
if TURBOSTROI then return end

function TRAIN_SYSTEM:Initialize(parameter)
    self.Max = parameter or 2
    self.RouteNumber = "000"
end

function TRAIN_SYSTEM:Outputs()
    return {}
end

function TRAIN_SYSTEM:Inputs()
    return {"1+","2+","3+","1-","2-","3-"}
end

if SERVER then
    function TRAIN_SYSTEM:TriggerInput(name,value)
        local Train = self.Train
        local id = tonumber(name[1])
        if name[2]=="+" and value>0 then
            local num = tonumber(self.RouteNumber[id])+1
            if num > 9 then num = 0 end
            self.RouteNumber = self.RouteNumber:SetChar(id,num)
            Train:SetNW2String("RouteNumber",self.RouteNumber)
        end
        if name[2]=="-" and value>0 then
            local num = tonumber(self.RouteNumber[id])-1
            if num < 0 then num = 9 end
            self.RouteNumber = self.RouteNumber:SetChar(id,num)
            Train:SetNW2String("RouteNumber",self.RouteNumber)
        end
    end
else
    function TRAIN_SYSTEM:ClientInitialize(parameter)
        self.Max = parameter or 2
        self.Reloaded = false
    end

    function TRAIN_SYSTEM:ClientThink()
        local Train = self.Train
        local scents = Train.ClientEnts

        if self.RouteNumber ~= Train:GetNW2String("RouteNumber","000") then
            self.RouteNumber = Train:GetNW2String("RouteNumber","000")
            self.Reloaded = false
        end
        if not scents["route1"] or self.Reloaded then return end

        self.Reloaded = true

        local rn = Format("%03d",self.RouteNumber)
        for i=1,self.Max do
            if IsValid(scents["route"..i]) then
                scents["route"..i]:SetSkin(rn[i])
            end
        end
    end
end

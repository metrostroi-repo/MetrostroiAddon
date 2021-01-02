--------------------------------------------------------------------------------
-- 81-722 I/O module
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_722_UPI")
TRAIN_SYSTEM.DontAccelerateSimulation = false
function TRAIN_SYSTEM:Initialize()
    self.ChangeTimer = CurTime()
    self.ControllerPosition = 0
    self.TControllerPosition = 0

    self.Emergency = 0

    self.Cache = {}
    self.OldTime = 0
end

function TRAIN_SYSTEM:Inputs()
	return {  }
end

function TRAIN_SYSTEM:Outputs()
	return { "Emergency", "ControllerPosition" }
end
--if not TURBOSTROI then return end
function TRAIN_SYSTEM:TriggerInput(name,value)
end
function TRAIN_SYSTEM:Think()
    local Train = self.Train
    local CPos = Train.Panel.Controller
    if self.TControllerPosition ~= CPos then
        if self.TControllerPosition<CPos and CPos>0 or self.TControllerPosition>CPos and CPos<0 or CPos==0 then
            table.insert(self.Cache,{CPos,CurTime()+0.2})
        else
            table.insert(self.Cache,{CPos,CurTime()+0.05})
        end
        self.TControllerPosition = CPos
    end
    if #self.Cache>0 and CurTime()-self.Cache[1][2] > 0 then
        self.ControllerPosition = self.Cache[1][1] or 0
        table.remove(self.Cache,1)
    end
    self.Emergency = CPos == -3 and 1 or 0
end

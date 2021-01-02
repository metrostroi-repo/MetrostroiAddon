--------------------------------------------------------------------------------
-- "IPAV" autodrive commands receiver
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("IPAV")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()

    self.Count = 0
end

function TRAIN_SYSTEM:Outputs()
    return {}
end

function TRAIN_SYSTEM:Inputs()
    return {}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "Enable" then
        self.Enabled = value
    end
end

function TRAIN_SYSTEM:SetCommand(name,command)
    local Train = self.Train
    local IPAVConfig = Train.SubwayTrain.IPAV
    for _,sys_name in ipairs(IPAVConfig.Systems) do
        if command then
            Train[sys_name]:TriggerInput(name,command)
        else
            Train[sys_name]:TriggerInput(name,0)
        end
    end
end

function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    local IPAVConfig = Train.SubwayTrain.IPAV
    if not IPAVConfig then return end
    local LeftCoil,RightCoil = Train.LeftAutoCoil,Train.RightAutoCoil
    if not IsValid(LeftCoil) or not IsValid(RightCoil) then return end

    local ProgrammX = false
    local ProgramDoorLeft = IgnoreDoors
    local ProgramDoorRight = IgnoreDoors
    local ProgrammBrake = false
    self.LastBrakeProgramTimer =  self.LastBrakeProgramTimer or CurTime()
    self.LastBrakeProgram =  self.LastBrakeProgram or false

    local haveCommand = 0
    for k,v in ipairs(LeftCoil.Commands) do
        local command = v.PlateType
        ProgramDoorLeft = ProgramDoorLeft or command == METROSTROI_ACOIL_DOOR
        ProgrammX = ProgrammX or command == METROSTROI_ACOIL_DRIVE and v.Power and v.Mode
        ProgrammBrake = ProgrammBrake or command == METROSTROI_ACOIL_SBRAKE and LeftCoil
        haveCommand = haveCommand + 1
    end
    for k,v in ipairs(RightCoil.Commands) do
        local command = v.PlateType
        ProgramDoorRight = ProgramDoorRight or command == METROSTROI_ACOIL_DOOR
        ProgrammX = ProgrammX or command == METROSTROI_ACOIL_DRIVE and v.Power and v.Mode
        ProgrammBrake = ProgrammBrake or command == METROSTROI_ACOIL_SBRAKE and RightCoil

        haveCommand = haveCommand + 1
    end
    if self.ProgramDoorLeft ~= ProgramDoorLeft then
        self:SetCommand("CommandDoorsLeft",ProgramDoorLeft and 1)
        self.ProgramDoorLeft = ProgramDoorLeft
    end
    if self.ProgramDoorRight ~= ProgramDoorRight then
        self:SetCommand("CommandDoorsRight",ProgramDoorRight and 1)
        self.ProgramDoorRight = ProgramDoorRight
    end
    if self.ProgrammX ~= ProgrammX then
        local type = 0
        if ProgrammX == 2 or ProgrammX == 4 then self:SetCommand("CommandDrive",3) --X3
        elseif ProgrammX == 1 or ProgrammX == 3 then self:SetCommand("CommandDrive",2) --X2
        elseif ProgrammX == 7 then self:SetCommand("CommandBrake",ProgrammBrake and 1 or 0)
        elseif ProgrammX then self:SetCommand("CommandDrive",-1)
        else self:SetCommand("CommandDrive",0) end
        self.ProgrammX = ProgrammX
    end
    if ProgrammBrake and not ProgrammBrake.BrakeCommandFounded then ProgrammBrake = nil end
    if self.ProgrammBrake ~= ProgrammBrake then
        self:SetCommand("CommandBrake",ProgrammBrake and 1 or 0)
        self.ProgrammBrake = ProgrammBrake
    end
    if ProgrammBrake then
        local passed = ProgrammBrake.BrakeProgrammPassed
        local passednow = CurTime()-ProgrammBrake.LastBrakeProgrammPassed
        --print("IPAV",passed,passednow)
        if passed ~= self.Passed then
            self.Count = self.Count + 1
            self:SetCommand("CommandBrakeElapsed",passed)
            self:SetCommand("CommandBrakeCount",self.Count)
            self.Passed = passed
        end
    else
        self.Count = 0
        if self.Passed then
            self:SetCommand("CommandBrakeElapsed",-1)
            self:SetCommand("CommandBrakeCount",0)
            self.Passed = nil
        end
    end
end

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel(self.Model or "models/props_building_details/Storefront_Template001a_Bars.mdl")

    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)


    self.Commands = {}
    self.LastBrakeProgrammPassed = CurTime()
    self.BrakeProgrammPassed = 1e9
end

function ENT:OnRemove()
end

function ENT:Trigger(plate)
    if self.IsSensor then
        --print("Sensor:TRIGGERED!")
        if IsValid(self.Train) and self.Train.TriggerLightSensor then self.Train:TriggerLightSensor(self,plate) end
    end
end
function ENT:Think()
    local dist
    local speedDist = 1e9
    local founded = false
    for _,ent in ipairs(self.Commands) do
        if ent.PlateType == METROSTROI_ACOIL_SBRAKE then
            founded = true
            dist = ent:WorldToLocal(self:GetPos()).x*0.01905+80
            if dist > 130 then break end
            for i,brakeDist in ipairs(ent.SpeedDetectors) do
                if brakeDist <= dist then
                    speedDist = brakeDist
                end
            end
        end
    end
    self.BrakeCommandFounded = dist and (dist < 130 or dist > 150)
    if self.SpeedDist ~= speedDist then
        if speedDist == 1e9 or self.SpeedDist == 1e9 then
            self.BrakeProgrammPassed = 1e9
        else
            self.BrakeProgrammPassed = (CurTime()-self.LastBrakeProgrammPassed)
        end
        self.LastBrakeProgrammPassed = CurTime()
        self.SpeedDist = speedDist
        --print(speedDist,self.BrakeProgrammPassed)
    end
    self:NextThink(CurTime())
    return true
    --if #self.Commands == 0 then self.BrakeProgrammPassed = 1e9 end
end
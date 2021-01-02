AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
util.AddNetworkString("metrostroi_auodrive_coils")
function ENT:Initialize()
    self:DrawShadow(false)

    self:SetModel(self.Model or "models/metrostroi/signals/autodrive/doska160.mdl")

    --self:PhysicsInit(MOVETYPE_VPHYSICS)
    self:PhysicsInitStatic(SOLID_VPHYSICS )
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_VPHYSICS)
    self:GetPhysicsObject():Sleep()
    --self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)

    self:SetTrigger(true)

    self.Touches = {}
    self.SpeedDetectors = {}
    self.Power = true
end


METROSTROI_ABRAKE_PRG = 92
METROSTROI_ABRAKE_DIST = 0.1
METROSTROI_ABRAKE_COEFF = 1.4
ENT.RELOAD = true
function ENT:Think()
    if self.PlateType == METROSTROI_LSENSOR then
        return
    end
    if self.StationID then
        if not IsValid(self.Station) then
            local stationT = Metrostroi.Stations[tonumber(self.StationID)]
            local platformT = stationT and stationT[tonumber(self.StationPath)]
            if platformT then
                self.Station = platformT.ent
            end
            self.Power = false
        else
            self.Power = self.Station.AnnouncerPlay
        end
    end
    --self:SetMoveType(MOVETYPE_NONE)
    --self:SetMoveType(MOVETYPE_VPHYSICS)
    -- if self.PlateType == METROSTROI_ACOIL_SBRAKE then
    --     if IsValid(self.Touches) then
    --         self.BrakeProgrammPassed = self.Touches.BrakeProgrammPassed
    --     else
    --         self.BrakeProgrammPassed = false
    --     end
    -- end
    if self.RELOAD and self.PlateType == METROSTROI_ACOIL_SBRAKE and     self.BrakeProps then for k,v in pairs(self.BrakeProps) do SafeRemoveEntity(v) end self.BrakeProps = false end
    if self.PlateType == METROSTROI_ACOIL_SBRAKE and not self.BrakeProps then
        self.BrakeProps = {}
        self.SpeedDetectors = {}
        --[=[  for i=0,METROSTROI_ABRAKE_PRG do
            local targetdist = 100/METROSTROI_ABRAKE_PRG*i
            local targetspeed = math.min((targetdist/6)^2*15,15) + math.max((targetdist-20)/(90-20),0)^2*(60)
            --local targetdist = math.min((targetspeed/(15))^3*20,20) + math.max((targetspeed-15)/(70-15),0)^2.5*(150-20)
            --local targetspeed = 70/METROSTROI_ABRAKE_PRG*i
            --local targetdist = math.min((targetspeed/(15))^3*20,20) + math.max((targetspeed-15)/(70-15),0)^2.5*(150-20)
            local targetProgDist = math.max(0.15,targetspeed/3600*1000*METROSTROI_ABRAKE_DIST)
            if dist > 100 then break end
            --[[ if speed > 15 then
                targetdist = ((speed)/65)^METROSTROI_ABRAKE_COEFF*150
            else
                targetdist = ((speed)/65)^METROSTROI_ABRAKE_COEFF*150
            end--]]
            --print(-2,i,speed,targetdist)
            if targetspeed ~= 15 and targetspeed <= 65 then
                local iter = 0
                while dist < targetdist and iter < 100 do
                    iter = iter + 1
                    if iter == 100 then print("InfiniteLoop") end
                    table.insert(self.SpeedDetectors,dist)
                    dist = dist + targetProgDist
                end
                --if targetdist > dist then print(targetdist-dist,prevdist) end
                print(Format("On %.1f m we must have %.1f km\\h, our interval = %.3f m, bpdist = %.3f, spd=%.1f",targetdist,targetspeed,targetProgDist,dist,(targetProgDist)/0.1/1000*3600))
               --[[  local prop = ents.Create("gmod_track_autodrive_plate")
                -- if i > 15 then
                --     prop:SetPos(self:LocalToWorld(Vector((((160 + 160 + 10)*(((i-16)/67)^1.3))-165+15)/0.01905,0,0)))
                -- else
                --     prop:SetPos(self:LocalToWorld(Vector((((160 + 160 + 10)*(((i)/80)^1.94))-165)/0.01905,0,0)))
                -- end
                prop:SetPos(self:LocalToWorld(Vector((dist*2-165)/0.01905,0,0)))
                prop:SetAngles(self:GetAngles())
                prop.Model = "models/hunter/blocks/cube025x025x025.mdl"
                prop.PlateType = METROSTROI_ACOIL_SBRAKECMD
                prop:Spawn()
                prop:SetMaterial("phoenix_storms/mrtire",true)
                table.insert(self.BrakeProps,prop)
                prop:SetParent(self)
                prop:ManipulateBoneScale(0,Vector(0.1,0.75,1))
                prop:GetPhysicsObject():SetPos(Vector(1000,0,0),true)

                prop:SetTrigger(true)--]]
            else
                dist = targetdist
            end
            prevdist = targetProgDist
            --dist = dist + targetProgDist
        end--]=]
        local dist = 0.05
        local prevdist = 0
        for i=0,12 do
            local targetdist = i
            local targetspeed = math.min((targetdist/12)^0.5*25-3,22)
            --local targetspeed = math.min((targetdist/14)^0.5*25-3,22)
            local targetProgDist = math.max(0.15,targetspeed/3600*1000*0.15)--0.096

            local iter = 0
            while dist < targetdist-targetProgDist and iter < 100 do
                iter = iter + 1
                assert(iter<100,"InfiniteLoop")
                table.insert(self.SpeedDetectors,dist)
                dist = dist + targetProgDist
            end
            --if targetdist > dist then print(targetdist-dist,prevdist) end
            --print(Format("On %.1f m we must have %.1f km\\h, our interval = %.3f m, bpdist = %.3f, spd=%.1f",targetdist,targetspeed,targetProgDist,dist,(targetProgDist)/0.15/1000*3600))
            prevdist = targetProgDist
            --dist = dist + targetProgDist
        end


        local dist = 30
        local prevdist = 30
        for i=30,100 do
            local targetdist = i
            local targetspeed = math.min(((targetdist-30)/66)^0.6*66-1,66)
            --local targetspeed = math.min(((targetdist-30)/65)^0.5*65-1,65)
            local targetProgDist = math.max(0,targetspeed/3600*1000*0.15)
            local iter = 0
            while dist < targetdist-targetProgDist and iter < 100 do
                iter = iter + 1
                assert(iter<100,"InfiniteLoop")
                table.insert(self.SpeedDetectors,dist)
                dist = dist + targetProgDist
            end
            --if targetdist > dist then print(targetdist-dist,prevdist) end
            --print(Format("On %.1f m we must have %.1f km\\h, our interval = %.3f m, bpdist = %.3f, spd=%.1f",targetdist,targetspeed,targetProgDist,dist,(targetProgDist)/0.15/1000*3600))
            prevdist = targetProgDist
            --dist = dist + targetProgDist
        end
        --print(#self.SpeedDetectors)
        ---[[
        net.Start("metrostroi_auodrive_coils")
            net.WriteEntity(self)
            net.WriteUInt(#self.SpeedDetectors,16)
            for k,v in ipairs(self.SpeedDetectors) do
                net.WriteFloat(v)
            end
        net.Broadcast()--]]


    end
    self.RELOAD = false
end



function ENT:StartTouch( ent )
    if not self:PassesTriggerFilters(ent) then return end
    --[[ if self.PlateType == METROSTROI_ACOIL_SBRAKECMD then
        ent.BrakeProgrammPassed = (CurTime()-ent.LastBrakeProgrammPassed)
        ent.LastBrakeProgrammPassed = CurTime()
    end--]]
    if not ent.Commands[self] then
        ent.Commands[self] = table.insert(ent.Commands,self)
    end
    --print("Coil:TRIGGER!")
    if ent.Trigger then
        --print("Coil:TRIGGERED!")
        ent:Trigger(self)
    end
    self.Touches[ent] = true
end
function ENT:EndTouch( ent )
    if not self:PassesTriggerFilters(ent) then return end
    if ent.Commands[self] then
        table.remove(ent.Commands,ent.Commands[self])
        ent.Commands[self] = nil
    end
    for k,v in ipairs(ent.Commands) do ent.Commands[v] = k end
    self.Touches[ent] = nil
end
function ENT:PassesTriggerFilters(ent)
    return IsValid(ent) and ent:GetClass() == "gmod_train_autodrive_coil"
end
function ENT:OnRemove()
    if self.Touches then
        for ent in pairs(self.Touches) do self:EndTouch(ent) end
    end
    if self.BrakeProps then for k,v in pairs(self.BrakeProps) do SafeRemoveEntity(v) end end
end

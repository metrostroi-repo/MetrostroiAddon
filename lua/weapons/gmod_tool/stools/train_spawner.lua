
--local TOOL = player.GetBySteamID("STEAM_0:1:31566374"):GetTool("train_spawner")
TOOL.AddToMenu = false

local C_MaxWagons = GetConVar("metrostroi_maxwagons")

if CLIENT then
    language.Add("Tool.train_spawner.name", "Train Spawner")
    language.Add("Tool.train_spawner.desc", "Spawn a train")
    language.Add("Tool.train_spawner.0", "Primary: Spawns a full train. Secondary: Reverse facing (yellow ed when facing the opposite side). Reload: Copy train settings.")
    language.Add("Undone_81-7036", "Undone 81-7036 (does not work)")
    language.Add("Undone_81-7037", "Undone 81-7037 (does not work)")
    language.Add("Undone_81-717", "Undone 81-717")
    language.Add("Undone_81-714", "Undone 81-714")
    language.Add("Undone_Ezh3", "Undone Ezh3")
    language.Add("Undone_Ema508T", "Undone Em508T")
    language.Add("SBoxLimit_spawner_wrong_pos","Wrong train position! Can't spawn")
    language.Add("SBoxLimit_spawner_restrict","This train is restricted for you")
end

local function Trace(ply,tr)
    local verticaloffset = 5 -- Offset for the train model
    local distancecap = 2000 -- When to ignore hitpos and spawn at set distanace
    local pos, ang = nil
    local inhibitrerail = false

    --TODO: Make this work better for raw base ent

    if tr.Hit then
        -- Setup trace to find out of this is a track
        local tracesetup = {}
        tracesetup.start=tr.HitPos
        tracesetup.endpos=tr.HitPos+tr.HitNormal*80
        tracesetup.filter=ply

        local tracedata = util.TraceLine(tracesetup)

        if tracedata.Hit then
            -- Trackspawn
            pos = (tr.HitPos + tracedata.HitPos)/2 + Vector(0,0,verticaloffset)
            ang = tracedata.HitNormal
            ang:Rotate(Angle(0,90,0))
            ang = ang:Angle()
            -- Bit ugly because Rotate() messes with the orthogonal vector | Orthogonal? I wrote "origional?!" :V
        else
            -- Regular spawn
            if tr.HitPos:Distance(tr.StartPos) > distancecap then
                -- Spawnpos is far away, put it at distancecap instead
                pos = tr.StartPos + tr.Normal * distancecap
                inhibitrerail = true
            else
                -- Spawn is near
                pos = tr.HitPos + tr.HitNormal * verticaloffset
            end
            ang = Angle(0,tr.Normal:Angle().y,0)
        end
    else
        -- Trace didn't hit anything, spawn at distancecap
        pos = tr.StartPos + tr.Normal * distancecap
        ang = Angle(0,tr.Normal:Angle().y,0)
    end
    return {pos,ang,inhibitrerail}
end

function UpdateGhostPos(pl)
    local trace = util.TraceLine(util.GetPlayerTrace(pl))
    local tbl =  Metrostroi.RerailGetTrackData(trace.HitPos,pl:GetAimVector())

    if not tbl then tbl = Trace(pl, trace) end
    local class = IsValid(trace.Entity) and trace.Entity:GetClass()

    local pos,ang = Vector(0,0,0),Angle(0,0,0)
    if tbl[3] ~= nil then
        pos = tbl[1]+Vector(0,0,55)
        ang = tbl[2]
        return pos,ang,false,not class or (class == "func_door" or class == "prop_door_rotating")
    else
        pos = tbl.centerpos + Vector(0,0,112)
        ang = tbl.right:Angle()+Angle(0,90,0)
        return pos,ang,true,not class or (class == "func_door" or class == "prop_door_rotating")
    end
end

function UpdateWagPos(pl)
    local trace = util.TraceLine(util.GetPlayerTrace(pl))
    local tbl =  Metrostroi.RerailGetTrackData(trace.HitPos,pl:GetAimVector())

    if not tbl then tbl = Trace(pl, trace) end
    local pos,ang = Vector(0,0,0),Angle(0,0,0)
    if tbl[3] ~= nil then
        pos = tbl[1]
        ang = tbl[2]
        return pos,ang,false
    else
        pos = tbl.centerpos + Vector(0,0,112-55)
        ang = tbl.right:Angle()+Angle(0,90,0)
        return pos,ang,true
    end
end


function TOOL:UpdateGhost()
    local good,canDraw
    for i,e in ipairs(self.GhostEntities) do
        local t = self.Model[i]
        local pos,ang
        if i==1 then
            pos,ang,good,canDraw = UpdateGhostPos(self:GetOwner())
            if self:GetOwner():GetNW2Bool("metrostroi_train_spawner_rev") then
                ang = ang+Angle(0,180,0)
            end
        elseif type(t) ~= "string" then
            pos,ang = self.GhostEntities[1]:LocalToWorld(t.pos or Vector(0,0,0)),self.GhostEntities[1]:LocalToWorldAngles(self.Model[i].ang or Angle(0,0,0))
        else
            pos,ang = self.GhostEntities[1]:GetPos(),self.GhostEntities[1]:GetAngles()
        end
        e:SetNoDraw(not canDraw)
        --if not pos then bad = true else pos,ang = rpos,rang end
        if not good then
            e:SetColor(Color(255,150,150,255))
        elseif self:GetOwner():GetNW2Bool("metrostroi_train_spawner_rev") then
            e:SetColor(Color(255,255,150,255))
        else
            e:SetColor(Color(255,255,255,255))
        end
        e:SetPos(pos)
        e:SetAngles(ang)
    end
end

function TOOL:Holster()
    if not IsFirstTimePredicted() or SERVER then return end
end

function TOOL:Think()
    if SERVER then return end

    if self.IsConsist then
        if not self.Consist then return end
        local entSpawner = scripted_ents.GetStored(self.Consist.Train).t.Spawner
        if not entSpawner.model then return end

        if not self.GhostEntities then self.GhostEntities = {} end
        if not IsValid(self.GhostEntities[1]) or self.Model ~= entSpawner.model then
            self.Model = entSpawner.model
            for _,e in pairs(self.GhostEntities) do SafeRemoveEntity(e) end
            self.GhostEntities = {}
            if type(self.Model) == "string" then
                self.GhostEntities[1] = ClientsideModel(self.Model,RENDERGROUP_OPAQUE)
                self.GhostEntities[1]:SetModel(self.Model)
            else
                for i,t in pairs(self.Model) do
                    if type(t) == "string" then
                        self.GhostEntities[i] = ClientsideModel(t,RENDERGROUP_OPAQUE)
                        self.GhostEntities[i]:SetModel(t)
                    else
                        self.GhostEntities[i] = ClientsideModel(t[1],RENDERGROUP_OPAQUE)
                        self.GhostEntities[i]:SetModel(t[1])
                    end
                end
            end
            for i,e in pairs(self.GhostEntities) do
                e:SetRenderMode(RENDERMODE_TRANSALPHA)
                e.GetBodyColor = function() return Vector(1,1,1) end
                e.GetDirtLevel = function() return 0.25 end
            end
            hook.Add("Think",self.GhostEntities[1],function()
                if not IsValid(self.Owner:GetActiveWeapon()) or self.Owner:GetActiveWeapon():GetClass()~="gmod_tool" or GetConVar("gmod_toolmode"):GetString() ~= "train_spawner" then
                    self:OnRemove()
                end
            end)

            local oldOR = self.GhostEntities[1].OnRemove
            self.GhostEntities[1].OnRemove = function(ent)
                hook.Remove("Think",ent)
                oldOR(ent)
            end
        else
            self:UpdateGhost()
        end
    else
        if not self.Train then return end
        if self.Train.Spawner.model then
            if not self.GhostEntities  then self.GhostEntities = {} end
            if not IsValid(self.GhostEntities[1]) or self.Model ~= self.Train.Spawner.model then
                self.Model = self.Train.Spawner.model
                for _,e in pairs(self.GhostEntities) do SafeRemoveEntity(e) end
                self.GhostEntities = {}
                if type(self.Model) == "string" then
                    self.GhostEntities[1] = ClientsideModel(self.Model,RENDERGROUP_OPAQUE)
                    self.GhostEntities[1]:SetModel(self.Model)
                else
                    for i,t in pairs(self.Model) do
                        if type(t) == "string" then
                            self.GhostEntities[i] = ClientsideModel(t,RENDERGROUP_OPAQUE)
                            self.GhostEntities[i]:SetModel(t)
                        else
                            self.GhostEntities[i] = ClientsideModel(t[1],RENDERGROUP_OPAQUE)
                            self.GhostEntities[i]:SetModel(t[1])
                        end
                    end
                end
                for i,e in pairs(self.GhostEntities) do
                    e:SetRenderMode(RENDERMODE_TRANSALPHA)
                    e.GetBodyColor = function() return Vector(1,1,1) end
                    e.GetDirtLevel = function() return 0.25 end
                end
                hook.Add("Think",self.GhostEntities[1],function()
                    if not IsValid(self.Owner:GetActiveWeapon()) or self.Owner:GetActiveWeapon():GetClass()~="gmod_tool" or GetConVar("gmod_toolmode"):GetString() ~= "train_spawner" then
                        self:OnRemove()
                    end
                end)

                local oldOR = self.GhostEntities[1].OnRemove
                self.GhostEntities[1].OnRemove = function(ent)
                    hook.Remove("Think",ent)
                    oldOR(ent)
                end
            else
                self:UpdateGhost()
            end
        end
    end
end

function TOOL:SetSettings(ent, ply, i,inth)
    local rot = false
    if i > 1 then
        rot = i == self.tbl.WagNum and true or math.random() > 0.5
    end
end

local function SetValue(ent,id,val)
    if type(val) == "number" then
        ent:SetNW2Int(id,val)
    elseif type(val) == "string" then
        ent:SetNW2String(id,val)
    elseif type(val) == "boolean" then
        ent:SetNW2Bool(id,val)
    end
end

local function SetSelectiveValue(ent,id,val)
    local num = ent.WagonNumber
    if num ~= nil then
        math.randomseed(num+817171)
    end
    table.Shuffle(val)
    ent:SetNW2Int(id, table.Random(val))
    math.randomseed(os.time())
end


function TOOL:OnRemove()
    self:Finish()
end

function TOOL:Finish()
    for _,e in pairs(self.GhostEntities or {}) do SafeRemoveEntity(e) end
    self.GhostEntities = {}
end

function TOOL:Reload(trace)
    if CLIENT then return end
    local ply = self:GetOwner()
    local consist = false

    if IsValid(trace.Entity) and trace.Entity._Settings then
        ply:ConCommand("gmod_tool train_spawner")
        ply:SelectWeapon("gmod_tool")

        local tool = ply:GetTool("train_spawner")

        tool.AllowSpawn = true
        tool.IsConsist = trace.Entity._IsConsist

        local settings = trace.Entity._Settings

        if tool.IsConsist then
            tool.Consist = settings
            consist = true
        else
            tool.Settings = settings
            consist = false

            local ENT = scripted_ents.Get(tool.Settings.Train)
            if not ENT then tool.AllowSpawn = false else tool.Train = ENT end
        end

        net.Start("train_spawner_open")
            net.WriteBool(tool.IsConsist)
            net.WriteTable(tool.IsConsist and tool.Consist or tool.Settings)
        net.Send(ply)
    end

    if not consist then
        local spawner = ents.Create("gmod_train_spawner")
        spawner:SpawnFunction(ply)
    end
end

function TOOL:SpawnWagon(trace)
    if CLIENT then return end
    local ply = self:GetOwner()

    local FIXFIXFIX = {}
    for i=1,math.random(12) do
        FIXFIXFIX[i] = ents.Create("env_sprite")
        FIXFIXFIX[i]:Spawn()
    end

    local LastRot,LastEnt = false
    local trains = {}
    for i=1,self.Settings.WagNum do
        local spawnfunc = self.Train.Spawner.spawnfunc
        local ent
        if i == 1 then
            if spawnfunc then
                ent = self.Train:SpawnFunction(ply,trace,spawnfunc(i,self.Settings,self.Train),self:GetOwner():GetNW2Bool("metrostroi_train_spawner_rev"),UpdateWagPos)
            else
                ent = self.Train:SpawnFunction(ply,trace,self.Train.Spawner.head or self.Train.ClassName,self:GetOwner():GetNW2Bool("metrostroi_train_spawner_rev"),UpdateWagPos)
            end
            --nil,self:GetOwner():GetNW2Bool("metrostroi_train_spawner_rev") and Angle(0,180,0) or Angle(0,0,0)) --Create a first entity in queue
            if ent then
                undo.Create(self.Train.Spawner.head or self.Train.ClassName)
            else
                self:GetOwner():LimitHit("spawner_wrong_pos")
                return false
            end
            --if self:GetOwner():GetNW2Bool("metrostroi_train_spawner_rev") then
                --ent:SetAngles(ent:LocalToWorldAngles(Angle(0,180,0)))
            --end
            --if self.Rot then
        end
        if i > 1 then
            local rot = (i==self.Settings.WagNum or math.random() > 0.5) -- Rotate last wagon or rotate it randomly
            if spawnfunc then
                ent = ents.Create(spawnfunc(i,self.Settings,self.Train))
            else
                ent = ents.Create(i~=self.Settings.WagNum and self.Train.Spawner.interim or self.Train.Spawner.head or self.Train.ClassName)
            end
            ent.Owner = ply
            ent:Spawn()
            -- Invert bogeys by rotation
            local bogeyL1,bogeyE1,bogeyE2
            local couplL1,couplE1,couplE2
            if LastRot then
                bogeyL1 = LastEnt.FrontBogey
                couplL1 = LastEnt.FrontCouple
            else
                bogeyL1 = LastEnt.RearBogey
                couplL1 = LastEnt.RearCouple
            end
            if rot then
                bogeyE1,bogeyE2 = ent.RearBogey,ent.FrontBogey
                couplE1,couplE2 = ent.FrontCouple,ent.RearCouple
            else
                bogeyE1,bogeyE2 = ent.FrontBogey,ent.RearBogey
                couplE1,couplE2 = ent.RearCouple,ent.FrontCouple
            end
            local haveCoupler = couplL1 ~= nil
            if haveCoupler then
                bogeyE1:SetAngles(ent:LocalToWorldAngles(bogeyE1.SpawnAng))
                bogeyE2:SetAngles(ent:LocalToWorldAngles(bogeyE1.SpawnAng))
                -- Set bogey position by our bogey couple offset and lastent bogey couple offset
                couplE1:SetPos(
                    couplL1:LocalToWorld(
                        Vector(
                            couplL1.CouplingPointOffset.x*1.1+couplE1.CouplingPointOffset.x*1.1,
                            couplL1.CouplingPointOffset.y-couplE1.CouplingPointOffset.y,
                            couplL1.CouplingPointOffset.z-couplE1.CouplingPointOffset.z
                        )
                    )
                )
                -- Set bogey angles
                couplE1:SetAngles(couplL1:LocalToWorldAngles(Angle(0,180,0)))
                -- Set entity position by bogey pos and bogey offset
                couplE2:SetAngles(couplE1:LocalToWorldAngles(Angle(0,180,0)))
                ent:SetPos(couplE1:LocalToWorld(couplE1.SpawnPos*Vector(rot and -1 or 1,-1,-1)))
                -- Set entity angles by last ent and rotation
                ent:SetAngles(LastEnt:LocalToWorldAngles(Angle(0,rot ~= LastRot and 180 or 0,0)))

                -- Set bogey pos
                bogeyE1:SetPos(ent:LocalToWorld(bogeyE1.SpawnPos))
                bogeyE2:SetPos(ent:LocalToWorld(bogeyE2.SpawnPos))
                -- Set bogey angles
                bogeyE1:SetAngles(ent:LocalToWorldAngles(bogeyE1.SpawnAng))
                bogeyE2:SetAngles(ent:LocalToWorldAngles(bogeyE1.SpawnAng))
            else
                -- Set bogey position by our bogey couple offset and lastent bogey couple offset
                bogeyE1:SetPos(
                            bogeyL1:LocalToWorld(
                                Vector(bogeyL1.CouplingPointOffset.x*1.1+bogeyE1.CouplingPointOffset.x*1.05,bogeyL1.CouplingPointOffset.y-bogeyE1.CouplingPointOffset.y,bogeyL1.CouplingPointOffset.z-bogeyE1.CouplingPointOffset.z)
                            )
                )
                -- Set bogey angles
                bogeyE1:SetAngles(bogeyL1:LocalToWorldAngles(Angle(0,180,0)))
                -- Set entity position by bogey pos and bogey offset
                bogeyE2:SetAngles(bogeyE1:LocalToWorldAngles(Angle(0,180,0)))
                ent:SetPos(bogeyE1:LocalToWorld(bogeyE1.SpawnPos*Vector(rot and -1 or 1,-1,-1)))
                -- Set entity angles by last ent and rotation
                ent:SetAngles(LastEnt:LocalToWorldAngles(Angle(0,rot ~= LastRot and 180 or 0,0)))
                -- Set second bogey pos
                bogeyE2:SetPos(ent:LocalToWorld(bogeyE2.SpawnPos))
            end

            Metrostroi.RerailTrain(ent) --Rerail train
            --LastEnt:LocalToWorld(bogeyL1:WorldToLocal(Vector))))

            LastRot = rot
        end
        ent._Settings = self.Settings
        ent._IsConsist = false
        table.insert(trains,ent)
        undo.AddEntity(ent)

        for _, set in ipairs(self.Train.Spawner) do
            local val = self.Settings[set[1]]
            if set[3] == "List" then
                if set[6] and type(set[6]) == "function" then   set[6](ent,val,LastRot,i,self.Settings.WagNum) else SetValue(ent,set[1],val) end
            elseif set[3] == "Boolean" then
                if set[5] and type(set[5]) == "function" then   set[5](ent,val,LastRot,i,self.Settings.WagNum) else ent:SetNW2Bool(set[1],val) end
            elseif set[3] == "Slider" then
                if set[8] and type(set[8]) == "function" then   set[8](ent,val,LastRot,i,self.Settings.WagNum) else ent:SetNW2Int(set[1],val) end
            elseif set[3] == "Selective" then
                if set[6] and type(set[6]) == "function" then   set[6](ent,val,LastRot,i,self.Settings.WagNum) else SetSelectiveValue(ent,set[1],val) end
            end
        end

        if self.Train.Spawner.func then self.Train.Spawner.func(ent,i,self.Settings.WagNum,LastRot) end
        if self.Train.Spawner.wagfunc then ent:GenerateWagonNumber(function(_,number) return self.Train.Spawner.wagfunc(ent,i,number) end) end
        if ent.TrainSpawnerUpdate then ent:TrainSpawnerUpdate() end
        for k,v in pairs(ent.CustomSpawnerUpdates) do if k ~= "BaseClass" then v(ent) end end
        hook.Run("MetrostroiSpawnerUpdate",ent,self.Settings)
        ent:UpdateTextures()
        ent.FrontAutoCouple = i > 1 and i < self.Settings.WagNum
        ent.RearAutoCouple = self.Settings.WagNum > 1
        LastEnt = ent
    end
    undo.SetPlayer(ply)
    undo.SetCustomUndoText("Undone a train")
    undo.Finish()
    if self.Train.Spawner.postfunc then self.Train.Spawner.postfunc(trains,self.Settings.WagNum) end
    local CoupledTrains,WagNum = 0,self.Settings.WagNum
    local function StopCoupling()
        if not IsValid(trains[1]) or not trains[1].IgnoreEngine then return end
        for _,train in ipairs(trains) do
            train.FrontBogey.BrakeCylinderPressure = 3
            train.RearBogey.BrakeCylinderPressure = 3
            train.FrontBogey.MotorPower = 0
            train.RearBogey.MotorPower = 0
            train.OnCoupled = nil
        end
        timer.Simple(1,function() for i,train in ipairs(trains) do train.IgnoreEngine = false end end)
    end
    for i,train in ipairs(trains) do
        train.IgnoreEngine = true
        train.RearBogey.MotorForce = 40000
        train.FrontBogey.MotorForce = 40000
        train.RearBogey.PneumaticBrakeForce = 50000
        train.FrontBogey.PneumaticBrakeForce = 50000
        if i==#trains then
            train.RearBogey.MotorPower = 1
            train.FrontBogey.MotorPower = 0
        else
            train.RearBogey.MotorPower = 0
            train.FrontBogey.MotorPower = 0
        end
        if i==1 then
            train.FrontBogey.BrakeCylinderPressure = 3
            train.RearBogey.BrakeCylinderPressure = 3
        else
            train.FrontBogey.BrakeCylinderPressure = 0
            train.RearBogey.BrakeCylinderPressure = 0
        end
        train.OnCoupled = function(ent)
            CoupledTrains = CoupledTrains + 0.5
            if CoupledTrains==WagNum-1 then StopCoupling() end
        end
    end
    timer.Simple(3+1*#trains,StopCoupling)
    for k,v in pairs(FIXFIXFIX) do SafeRemoveEntity(v) end
end

function TOOL:DefaultLeftClick(trace)
    if not self.Train then return end
    --PrintTable(self.Train)
    local class = IsValid(trace.Entity) and trace.Entity:GetClass()
    if class and (trace.Entity.Spawner or class ~= "func_door" and class ~= "prop_door_rotating")  then
        if SERVER then
            if trace.Entity.ClassName == (self.Train.Spawner.head or self.Train.ClassName) or trace.Entity.ClassName == self.Train.Spawner.interim then
                local LastEnt
                local trains = {}
                for k,ent in ipairs(trace.Entity.WagonList) do
                    local rot = ent.RearTrain == LastEnt
                    LastEnt = ent
                    for i, set in ipairs(self.Train.Spawner) do
                        local val = self.Settings[set[1]]
                        if set[3] == "List" then
                            if set[6] and type(set[6]) == "function" then   set[6](ent,val,rot,k,self.Settings.WagNum) else SetValue(ent,set[1],val) end
                        elseif set[3] == "Boolean" then
                            if set[5] and type(set[5]) == "function" then   set[5](ent,val,rot,k,self.Settings.WagNum) else ent:SetNW2Bool(set[1],val) end
                        elseif set[3] == "Slider" then
                            if set[8] and type(set[8]) == "function" then   set[8](ent,val,rot,k,self.Settings.WagNum) else ent:SetNW2Int(set[1],val) end
                        elseif set[3] == "Selective" then
                            if set[6] and type(set[6]) == "function" then   set[6](ent,val,rot,k,self.Settings.WagNum) else SetSelectiveValue(ent,set[1],val) end
                        end
                    end
                    if self.Train.Spawner.func then self.Train.Spawner.func(ent,k,self.Settings.WagNum,rot) end
                    ent:GenerateWagonNumber(self.Train.Spawner.wagfunc)
                    if ent.TrainSpawnerUpdate then ent:TrainSpawnerUpdate() end
                    for k,v in pairs(ent.CustomSpawnerUpdates) do if k ~= "BaseClass" then v(ent) end end
                    hook.Run("MetrostroiSpawnerUpdate",ent,self.Settings)
                    ent:UpdateTextures()
                    ent._Settings = self.Settings
                    table.insert(trains,ent)
                    
                end
                if self.Train.Spawner.postfunc then self.Train.Spawner.postfunc(trains,self.Settings.WagNum) end
            end
        end
        return
    end
    if not self.AllowSpawn or not self.Train then return end
    if SERVER then
        if self.Settings.WagNum > C_MaxWagons:GetInt() then
            self.Settings.WagNum = C_MaxWagons:GetInt()
        end

        if Metrostroi.TrainCountOnPlayer(self:GetOwner()) + self.Settings.WagNum > GetConVar("metrostroi_maxtrains_onplayer"):GetInt()*C_MaxWagons:GetInt()
            or Metrostroi.TrainCount() + self.Settings.WagNum > GetConVar("metrostroi_maxtrains"):GetInt()*C_MaxWagons:GetInt() then
                self:GetOwner():LimitHit("train_limit")
            return true
        end
        if hook.Run("MetrostroiSpawnerRestrict",self:GetOwner(),self.Settings,false) then
            self:GetOwner():LimitHit("spawner_restrict")
            return true
        end
    end
    self:SpawnWagon(trace)
    return
end

function TOOL:ConsistSpawnWagon(trace)
    local ply = self:GetOwner()

    local FIXFIXFIX = {}
    for i=1,math.random(12) do
        FIXFIXFIX[i] = ents.Create("env_sprite")
        FIXFIXFIX[i]:Spawn()
    end

    local Train = scripted_ents.Get(self.Consist.Train)

    local LastRot,LastEnt = false
    local trains = {}
    for i=1,self.Consist.WagNum do
        local wag = self.Consist.Wagons[i]
        local spawnfunc = Train.Spawner.spawnfunc
        local ent
        if i == 1 then
            if spawnfunc then
                ent = Train:SpawnFunction(ply,trace,spawnfunc(i,self.Consist,self.Train),self:GetOwner():GetNW2Bool("metrostroi_train_spawner_rev"),UpdateWagPos)
            else
                ent = Train:SpawnFunction(ply,trace,Train.Spawner.head or Train.ClassName,self:GetOwner():GetNW2Bool("metrostroi_train_spawner_rev"),UpdateWagPos)
            end
            if ent then
                undo.Create(Train.Spawner.head or Train.ClassName)
            else
                self:GetOwner():LimitHit("spawner_wrong_pos")
                return false
            end
        end
        if i > 1 then
            local rot = (i==self.Consist.WagNum or math.random() > 0.5) -- Rotate last wagon or rotate it randomly
            if spawnfunc then
                ent = ents.Create(spawnfunc(i,self.Consist,Train))
            else
                ent = ents.Create(i~=self.Consist.WagNum and Train.Spawner.interim or Train.Spawner.head or Train.ClassName)
            end
            ent.Owner = ply
            ent:Spawn()
            -- Invert bogeys by rotation
            local bogeyL1,bogeyE1,bogeyE2
            local couplL1,couplE1,couplE2
            if LastRot then
                bogeyL1 = LastEnt.FrontBogey
                couplL1 = LastEnt.FrontCouple
            else
                bogeyL1 = LastEnt.RearBogey
                couplL1 = LastEnt.RearCouple
            end
            if rot then
                bogeyE1,bogeyE2 = ent.RearBogey,ent.FrontBogey
                couplE1,couplE2 = ent.FrontCouple,ent.RearCouple
            else
                bogeyE1,bogeyE2 = ent.FrontBogey,ent.RearBogey
                couplE1,couplE2 = ent.RearCouple,ent.FrontCouple
            end
            local haveCoupler = couplL1 ~= nil
            if haveCoupler then
                bogeyE1:SetAngles(ent:LocalToWorldAngles(bogeyE1.SpawnAng))
                bogeyE2:SetAngles(ent:LocalToWorldAngles(bogeyE1.SpawnAng))
                -- Set bogey position by our bogey couple offset and lastent bogey couple offset
                couplE1:SetPos(
                    couplL1:LocalToWorld(
                        Vector(
                            couplL1.CouplingPointOffset.x*1.1+couplE1.CouplingPointOffset.x*1.1,
                            couplL1.CouplingPointOffset.y-couplE1.CouplingPointOffset.y,
                            couplL1.CouplingPointOffset.z-couplE1.CouplingPointOffset.z
                        )
                    )
                )
                -- Set bogey angles
                couplE1:SetAngles(couplL1:LocalToWorldAngles(Angle(0,180,0)))
                -- Set entity position by bogey pos and bogey offset
                couplE2:SetAngles(couplE1:LocalToWorldAngles(Angle(0,180,0)))
                ent:SetPos(couplE1:LocalToWorld(couplE1.SpawnPos*Vector(rot and -1 or 1,-1,-1)))
                -- Set entity angles by last ent and rotation
                ent:SetAngles(LastEnt:LocalToWorldAngles(Angle(0,rot ~= LastRot and 180 or 0,0)))

                -- Set bogey pos
                bogeyE1:SetPos(ent:LocalToWorld(bogeyE1.SpawnPos))
                bogeyE2:SetPos(ent:LocalToWorld(bogeyE2.SpawnPos))
                -- Set bogey angles
                bogeyE1:SetAngles(ent:LocalToWorldAngles(bogeyE1.SpawnAng))
                bogeyE2:SetAngles(ent:LocalToWorldAngles(bogeyE1.SpawnAng))
            else
                -- Set bogey position by our bogey couple offset and lastent bogey couple offset
                bogeyE1:SetPos(
                            bogeyL1:LocalToWorld(
                                Vector(bogeyL1.CouplingPointOffset.x*1.1+bogeyE1.CouplingPointOffset.x*1.05,bogeyL1.CouplingPointOffset.y-bogeyE1.CouplingPointOffset.y,bogeyL1.CouplingPointOffset.z-bogeyE1.CouplingPointOffset.z)
                            )
                )
                -- Set bogey angles
                bogeyE1:SetAngles(bogeyL1:LocalToWorldAngles(Angle(0,180,0)))
                -- Set entity position by bogey pos and bogey offset
                bogeyE2:SetAngles(bogeyE1:LocalToWorldAngles(Angle(0,180,0)))
                ent:SetPos(bogeyE1:LocalToWorld(bogeyE1.SpawnPos*Vector(rot and -1 or 1,-1,-1)))
                -- Set entity angles by last ent and rotation
                ent:SetAngles(LastEnt:LocalToWorldAngles(Angle(0,rot ~= LastRot and 180 or 0,0)))
                -- Set second bogey pos
                bogeyE2:SetPos(ent:LocalToWorld(bogeyE2.SpawnPos))
            end

            Metrostroi.RerailTrain(ent) --Rerail train
            --LastEnt:LocalToWorld(bogeyL1:WorldToLocal(Vector))))

            LastRot = rot
        end
        ent._Settings = self.Consist
        ent._IsConsist = true
        table.insert(trains,ent)
        undo.AddEntity(ent)

        for _, set in ipairs(Train.Spawner) do
            local val = self.Consist.Wagons[i][set[1]]
            if set[3] == "List" then
                if set[6] and type(set[6]) == "function" then   set[6](ent,val,LastRot,i,self.Consist.WagNum) else SetValue(ent,set[1],val) end
            elseif set[3] == "Boolean" then
                if set[5] and type(set[5]) == "function" then   set[5](ent,val,LastRot,i,self.Consist.WagNum) else ent:SetNW2Bool(set[1],val) end
            elseif set[3] == "Slider" then
                if set[8] and type(set[8]) == "function" then   set[8](ent,val,LastRot,i,self.Consist.WagNum) else ent:SetNW2Int(set[1],val) end
            elseif set[3] == "Selective" then
                if set[6] and type(set[6]) == "function" then   set[6](ent,val,LastRot,i,self.Consist.WagNum) else SetSelectiveValue(ent,set[1],val) end
            end
        end
        if Train.Spawner.func then Train.Spawner.func(ent,i,self.Consist.WagNum,LastRot) end
        if Train.Spawner.wagfunc then ent:GenerateWagonNumber(function(_,number) return Train.Spawner.wagfunc(ent,i,number) end) end
        print(Train)
        if ent.TrainSpawnerUpdate then ent:TrainSpawnerUpdate() end
        for k,v in pairs(ent.CustomSpawnerUpdates) do if k ~= "BaseClass" then v(ent) end end
        hook.Run("MetrostroiSpawnerUpdate",ent,self.Consist,true)
        ent:UpdateTextures()
        ent.FrontAutoCouple = i > 1 and i < self.Consist.WagNum
        ent.RearAutoCouple = self.Consist.WagNum > 1
        LastEnt = ent
    end
    undo.SetPlayer(ply)
    undo.SetCustomUndoText("Undone a train")
    undo.Finish()
    if Train.Spawner.postfunc then Train.Spawner.postfunc(trains,self.Consist.WagNum) end
    local CoupledTrains,WagNum = 0,self.Consist.WagNum
    local function StopCoupling()
        if not IsValid(trains[1]) or not trains[1].IgnoreEngine then return end
        for _,train in ipairs(trains) do
            train.FrontBogey.BrakeCylinderPressure = 3
            train.RearBogey.BrakeCylinderPressure = 3
            train.FrontBogey.MotorPower = 0
            train.RearBogey.MotorPower = 0
            train.OnCoupled = nil
        end
        timer.Simple(1,function() for i,train in ipairs(trains) do train.IgnoreEngine = false end end)
    end
    for i,train in ipairs(trains) do
        train.IgnoreEngine = true
        train.RearBogey.MotorForce = 40000
        train.FrontBogey.MotorForce = 40000
        train.RearBogey.PneumaticBrakeForce = 50000
        train.FrontBogey.PneumaticBrakeForce = 50000
        if i==#trains then
            train.RearBogey.MotorPower = 1
            train.FrontBogey.MotorPower = 0
        else
            train.RearBogey.MotorPower = 0
            train.FrontBogey.MotorPower = 0
        end
        if i==1 then
            train.FrontBogey.BrakeCylinderPressure = 3
            train.RearBogey.BrakeCylinderPressure = 3
        else
            train.FrontBogey.BrakeCylinderPressure = 0
            train.RearBogey.BrakeCylinderPressure = 0
        end
        train.OnCoupled = function(ent)
            CoupledTrains = CoupledTrains + 0.5
            if CoupledTrains==WagNum-1 then StopCoupling() end
        end
    end
    timer.Simple(3+1*#trains,StopCoupling)
    for k,v in pairs(FIXFIXFIX) do SafeRemoveEntity(v) end
end

function TOOL:ConsistLeftClick(trace)
    if not self.Consist then return end
    if CLIENT then return end

    local ent = trace.Entity
    local class = IsValid(ent) and ent:GetClass()

    if class and (ent.Spawner or class ~= "func_door" and class ~= "prop_door_rotating") then
        local entSpawner = scripted_ents.Get(self.Consist.Train).Spawner
        local headClass = entSpawner.head or self.Consist.Train
        local interimClass = entSpawner.interim or self.Consist.Train

        if ent.ClassName ~= headClass then return end
        if #ent.WagonList ~= self.Consist.WagNum then return end

        
        local lastent
        local trains = {}

        for k, ent in pairs(ent.WagonList) do
            local rot = ent.RearTrain == lastent
            lastent = ent
            for i, set in ipairs(entSpawner) do
                local val = self.Consist.Wagons[k][set[1]]
                if set[3] == "List" then
                    if set[6] and type(set[6]) == "function" then set[6](ent,val,rot,k,self.Consist.WagNum,true) else SetValue(ent,set[1],val) end
                elseif set[3] == "Boolean" then
                    if set[5] and type(set[5]) == "function" then set[5](ent,val,rot,k,self.Consist.WagNum,true) else ent:SetNW2Bool(set[1],val) end
                elseif set[3] == "Slider" then
                    if set[8] and type(set[8]) == "function" then set[8](ent,val,rot,k,self.Consist.WagNum,true) else ent:SetNW2Int(set[1],val) end
                elseif set[3] == "Selective" then
                    if set[6] and type(set[6]) == "function" then set[6](ent,val,rot,k,self.Consist.WagNum,true) else SetSelectiveValue(ent,set[1],val) end
                end
            end
            if entSpawner.func then entSpawner.func(ent,k,self.Consist.WagNum,rot) end

            ent:GenerateWagonNumber(entSpawner.wagfunc)

            if ent.TrainSpawnerUpdate then ent:TrainSpawnerUpdate() end

            for k,v in pairs(ent.CustomSpawnerUpdates) do if k ~= "BaseClass" then v(ent) end end

            hook.Run("MetrostroiSpawnerUpdate",ent,self.Consist.Wagons[k])
            ent:UpdateTextures()

            table.insert(trains,ent)
        end

        if entSpawner.postfunc then entSpawner.postfunc(trains,self.Consist.WagNum) end

        return
    end

    if self.Consist.WagNum > C_MaxWagons:GetInt() then
        self.Consist.WagNum = C_MaxWagons:GetInt()
    end

    if Metrostroi.TrainCountOnPlayer(self:GetOwner()) + self.Consist.WagNum > GetConVar("metrostroi_maxtrains_onplayer"):GetInt()*C_MaxWagons:GetInt()
        or Metrostroi.TrainCount() + self.Consist.WagNum > GetConVar("metrostroi_maxtrains"):GetInt()*C_MaxWagons:GetInt() then
            self:GetOwner():LimitHit("train_limit")
        return true
    end
    if hook.Run("MetrostroiSpawnerRestrict",self:GetOwner(),self.Consist,true) then
        self:GetOwner():LimitHit("spawner_restrict")
        return true
    end
    
    self:ConsistSpawnWagon(trace)
end

function TOOL:LeftClick(trace)
    if self.IsConsist then
        return self:ConsistLeftClick(trace)
    else
        return self:DefaultLeftClick(trace)
    end
end

function TOOL:DefaultRightClick(trace)
    if not self.Train then return end
    if IsValid(trace.Entity) then
        if SERVER then
            if trace.Entity.ClassName == (self.Train.Spawner.head or self.Train.ClassName) or trace.Entity.ClassName == self.Train.Spawner.interim then
                local LastEnt
                local trains = {}
                for k,ent in pairs(trace.Entity.WagonList) do
                    local rot = ent.RearTrain == LastEnt
                    LastEnt = ent
                    if ent ~= trace.Entity then continue end
                    for i, set in ipairs(self.Train.Spawner) do
                        local val = self.Settings[set[1]]
                        if set[3] == "List" then
                            if set[6] and type(set[6]) == "function" then set[6](ent,val,rot,k,self.Settings.WagNum,true) else SetValue(ent,set[1],val) end
                        elseif set[3] == "Boolean" then
                            if set[5] and type(set[5]) == "function" then set[5](ent,val,rot,k,self.Settings.WagNum,true) else ent:SetNW2Bool(set[1],val) end
                        elseif set[3] == "Slider" then
                            if set[8] and type(set[8]) == "function" then set[8](ent,val,rot,k,self.Settings.WagNum,true) else ent:SetNW2Int(set[1],val) end
                        elseif set[3] == "Selective" then
                            if set[6] and type(set[6]) == "function" then set[6](ent,val,rot,k,self.Settings.WagNum,true) else SetSelectiveValue(ent,set[1],val) end
                        end
                    end
                    if self.Train.Spawner.func then self.Train.Spawner.func(ent,k,self.Settings.WagNum,rot) end
                    ent:GenerateWagonNumber(self.Train.Spawner.wagfunc)
                    if ent.TrainSpawnerUpdate then ent:TrainSpawnerUpdate() end
                    for k,v in pairs(ent.CustomSpawnerUpdates) do if k ~= "BaseClass" then v(ent) end end
                    hook.Run("MetrostroiSpawnerUpdate",ent,self.Settings)
                    ent:UpdateTextures()
                    table.insert(trains,ent)
                    if self.Train.Spawner.postfunc then self.Train.Spawner.postfunc(trains,self.Settings.WagNum) end
                end
            end
        end
        return
    end
    if not self.AllowSpawn or not self.Train then return end
    if CLIENT then return end
    self.Rev = not self.Rev
    self:GetOwner():SetNW2Bool("metrostroi_train_spawner_rev",self.Rev)
end

function TOOL:ConsistRightClick(trace)
    if not self.Consist then return end
    if CLIENT then return end
    
    local ent = trace.Entity

    if not IsValid(ent) then
        if not self.AllowSpawn or not self.Consist then return end
        self.Rev = not self.Rev
        self:GetOwner():SetNW2Bool("metrostroi_train_spawner_rev",self.Rev)
        return
    end

    local entSpawner = scripted_ents.Get(self.Consist.Train).Spawner
    local headClass = entSpawner.head or self.Consist.Train
    local interimClass = entSpawner.interim or self.Consist.Train

    if ent.ClassName ~= headClass then return end
    if #ent.WagonList ~= self.Consist.WagNum then return end

    local lastent
    local trains = {}

    for k, ent in pairs(ent.WagonList) do
        local rot = ent.RearTrain == lastent
        lastent = ent
        if ent ~= trace.Entity then continue end
        for i, set in ipairs(entSpawner) do
            local val = self.Consist.Wagons[k][set[1]]
            if set[3] == "List" then
                if set[6] and type(set[6]) == "function" then set[6](ent,val,rot,k,self.Consist.WagNum,true) else SetValue(ent,set[1],val) end
            elseif set[3] == "Boolean" then
                if set[5] and type(set[5]) == "function" then set[5](ent,val,rot,k,self.Consist.WagNum,true) else ent:SetNW2Bool(set[1],val) end
            elseif set[3] == "Slider" then
                if set[8] and type(set[8]) == "function" then set[8](ent,val,rot,k,self.Consist.WagNum,true) else ent:SetNW2Int(set[1],val) end
            elseif set[3] == "Selective" then
                if set[6] and type(set[6]) == "function" then set[6](ent,val,rot,k,self.Consist.WagNum,true) else SetSelectiveValue(ent,set[1],val) end
            end
        end
        if entSpawner.func then entSpawner.func(ent,k,self.Consist.WagNum,rot) end

        ent:GenerateWagonNumber(entSpawner.wagfunc)

        if ent.TrainSpawnerUpdate then ent:TrainSpawnerUpdate() end

        for k,v in pairs(ent.CustomSpawnerUpdates) do if k ~= "BaseClass" then v(ent) end end

        hook.Run("MetrostroiSpawnerUpdate",ent,self.Consist.Wagons[k])
        ent:UpdateTextures()

        table.insert(trains,ent)
    end

    if entSpawner.postfunc then entSpawner.postfunc(trains,self.Consist.WagNum) end
end

function TOOL:RightClick(trace)
    if self.IsConsist then
        return self:ConsistRightClick(trace)
    else
        return self:DefaultRightClick(trace)
    end
end

function TOOL.BuildCPanel(panel)
    panel:SetName("#Tool.train_spawner.name")
    panel:Help("#Tool.train_spawner.desc")
end

if SERVER then
    util.AddNetworkString "train_spawner_open"
    net.Receive("train_spawner_open",function(len,ply)
        ply:ConCommand("gmod_tool train_spawner")
        ply:SelectWeapon("gmod_tool")
        local tool = ply:GetTool("train_spawner")
        tool.AllowSpawn = true
        local consist = net.ReadBool()
        if not consist then
            tool.IsConsist = false
            tool.Settings = net.ReadTable()
            tool:Finish()
            local ENT = scripted_ents.Get(tool.Settings.Train)
            if not ENT then tool.AllowSpawn = false else tool.Train = ENT end
        else
            tool.IsConsist = true
            tool.Consist = net.ReadTable()
            tool:Finish()
            local ENT = scripted_ents.Get(tool.Consist.Train)
            if not ENT then tool.AllowSpawn = false end
        end
    end)
    return
end

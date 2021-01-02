include("shared.lua")

--------------------------------------------------------------------------------
function ENT:Initialize()
    self.Sig = ""
    self.OldName = ""
    self.Models = {{},{},{}}
    self.Signals = {}
    self.Anims = {}
end

function ENT:Animate(clientProp, value, min, max, speed, damping, stickyness)
    local id = clientProp
    if not self.Anims[id] then
        self.Anims[id] = {}
        self.Anims[id].val = value
        self.Anims[id].V = 0.0
    end

    if damping == false then
        local dX = speed * self.DeltaTime
        if value > self.Anims[id].val then
            self.Anims[id].val = self.Anims[id].val + dX
        end
        if value < self.Anims[id].val then
            self.Anims[id].val = self.Anims[id].val - dX
        end
        if math.abs(value - self.Anims[id].val) < dX then
            self.Anims[id].val = value
        end
    else
        -- Prepare speed limiting
        local delta = math.abs(value - self.Anims[id].val)
        local max_speed = 1.5*delta / self.DeltaTime
        local max_accel = 0.5 / self.DeltaTime

        -- Simulate
        local dX2dT = (speed or 128)*(value - self.Anims[id].val) - self.Anims[id].V * (damping or 8.0)
        if dX2dT >  max_accel then dX2dT =  max_accel end
        if dX2dT < -max_accel then dX2dT = -max_accel end

        self.Anims[id].V = self.Anims[id].V + dX2dT * self.DeltaTime
        if self.Anims[id].V >  max_speed then self.Anims[id].V =  max_speed end
        if self.Anims[id].V < -max_speed then self.Anims[id].V = -max_speed end

        self.Anims[id].val = math.max(0,math.min(1,self.Anims[id].val + self.Anims[id].V * self.DeltaTime))

        -- Check if value got stuck
        if (math.abs(dX2dT) < 0.001) and stickyness and (self.DeltaTime > 0) then
            self.Anims[id].stuck = true
        end
    end
    return min + (max-min)*self.Anims[id].val
end
--------------------------
-- MAIN SPAWN FUNCTIONS --
--------------------------
function ENT:SpawnMainModels(pos,ang,LenseNum,add)
    local TLM = self.TrafficLightModels[self.LightType]
    for k,v in pairs(TLM) do
        if type(v) == "string" and not k:find("long") then
            if IsValid(self.Models[1][add and v..add or v]) then break else
                if TLM[k.."_long"] and LenseNum >= 7 then
                    self.Models[1][add and v..add or v] = ClientsideModel(TLM[k.."_long"],RENDERGROUP_OPAQUE)
                    self.LongOffset = Vector(0,0,TLM[k.."_long_pos"])
                else
                    self.Models[1][add and v..add or v] = ClientsideModel(v,RENDERGROUP_OPAQUE)
                end
                self.Models[1][add and v..add or v]:SetPos(self:LocalToWorld(pos))
                self.Models[1][add and v..add or v]:SetAngles(self:LocalToWorldAngles(ang))
                self.Models[1][add and v..add or v]:SetParent(self)
            end
        end
    end
end

function ENT:SpawnHeads(ID,model,pos,ang,glass,notM,add)
    if not IsValid(self.Models[1][ID]) then
        self.Models[1][ID] = ClientsideModel(model,RENDERGROUP_OPAQUE)
        self.Models[1][ID]:SetPos(self:LocalToWorld(pos))
        self.Models[1][ID]:SetAngles(self:LocalToWorldAngles(ang))
        self.Models[1][ID]:SetParent(self)
    end
    if self.RN and self.RN == self.RouteNumbers.sep then
        self.RN = self.RN + 1
    end
    local id = self.RN
    if id and not IsValid(self.Models[1]["rou"..id]) then
        local rnadd = ((self.RouteNumbers[id] and self.RouteNumbers[id][1] ~= "X") and (self.RouteNumbers[id][3] and not self.RouteNumbers[id][2] and "2" or "") or "5")
        self.Models[1]["rou"..id] = ClientsideModel("models/metrostroi/signals/mus/light_lampindicator"..rnadd..".mdl",RENDERGROUP_OPAQUE)
        self.Models[1]["rou"..id]:SetPos(self:LocalToWorld(pos-self.RouteNumberOffset*Vector(self.Left and 0.2 or 1)))
        self.Models[1]["rou"..id]:SetAngles(self:GetAngles())
        self.Models[1]["rou"..id]:SetParent(self)
        if self.RouteNumbers[id] then self.RouteNumbers[id].pos = pos-self.RouteNumberOffset*Vector(self.Left and 0.2 or 1) end
        self.RN = self.RN + 1
    end
    if notM then
        if glass then
            for i,tbl in pairs(glass) do
                if not IsValid(self.Models[1][tostring(ID).."_glass"..i]) then  --NEWLENSES
                    self.Models[1][tostring(ID).."_glass"..i] = ClientsideModel(tbl[1],RENDERGROUP_OPAQUE)
                    self.Models[1][tostring(ID).."_glass"..i]:SetPos(self:LocalToWorld(pos+tbl[2]*Vector(add and -1 or 1,1,1)))
                    self.Models[1][tostring(ID).."_glass"..i]:SetAngles(self:LocalToWorldAngles(ang))
                    self.Models[1][tostring(ID).."_glass"..i]:SetParent(self)
                end
            end
        end
    end
end

function ENT:SetLight(ID,ID2,pos,ang,skin,State,Change)
    if State >0 and Change and not IsValid(self.Models[3][ID..ID2]) then
        self.Models[3][ID..ID2] = ClientsideModel("models/metrostroi/signals/mus/lamp_base.mdl",RENDERGROUP_OPAQUE)
        self.Models[3][ID..ID2]:SetPos(self:LocalToWorld(pos))
        self.Models[3][ID..ID2]:SetAngles(self:LocalToWorldAngles(ang))
        self.Models[3][ID..ID2]:SetSkin(skin)
        self.Models[3][ID..ID2]:SetParent(self)
        self.Models[3][ID..ID2]:SetRenderMode(RENDERMODE_TRANSCOLOR)
        self.Models[3][ID..ID2]:SetColor(Color(255,255,255,0))
    end
    if IsValid(self.Models[3][ID..ID2]) then
        if State > 0 and Change then
            self.Models[3][ID..ID2]:SetColor(Color(255,255,255,State*255))
        elseif State == 0 then
            self.Models[3][ID..ID2]:Remove()
        end
    end
end

function ENT:SpawnLetter(i,model,pos,letter,double)
    if double ~= false and not IsValid(self.Models[2][i]) and (self.Double or not self.Left) and (not letter:match("s[1-3]") or letter == "s3" or self.Double and self.Left) then
        self.Models[2][i] = ClientsideModel(model,RENDERGROUP_OPAQUE)
        self.Models[2][i]:SetAngles(self:LocalToWorldAngles(Angle(0,180,0)))
        self.Models[2][i]:SetPos(self:LocalToWorld(self.BasePosition+pos))
        self.Models[2][i]:SetParent(self)
        for k,v in pairs(self.Models[2][i]:GetMaterials()) do
            if v:find("models/metrostroi/signals/let/let_start") then
                self.Models[2][i]:SetSubMaterial(k-1,"models/metrostroi/signals/let/"..letter)
            end
        end
    end
    if not double and not IsValid(self.Models[2][i.."d"]) and (self.Double or self.Left) and (not letter:match("s[1-3]") or letter == "s3" or self.Double and not self.Left) then
        self.Models[2][i.."d"] = ClientsideModel(model,RENDERGROUP_OPAQUE)
        self.Models[2][i.."d"]:SetAngles(self:LocalToWorldAngles(Angle(0,180,0)))
        self.Models[2][i.."d"]:SetPos(self:LocalToWorld((self.BasePosition+pos)*Vector(-1,1,1)))
        self.Models[2][i.."d"]:SetParent(self)
        for k,v in pairs(self.Models[2][i.."d"]:GetMaterials()) do
            if v:find("models/metrostroi/signals/let/let_start") then
                self.Models[2][i.."d"]:SetSubMaterial(k-1,"models/metrostroi/signals/let/"..letter)
            end
        end
    end
end

function ENT:OnRemove()
    self:RemoveModels()
end

function ENT:RemoveModels(final)
    if self.Models and  self.Models.have then
        for _,v in pairs(self.Models) do if type(v) == "table" then for _,v1 in pairs(v) do v1:Remove() end end end
    end
    self.Models = {{},{},{}}
    self.ModelsCreated = false
end

net.Receive("metrostroi-signal", function()
    local ent = net.ReadEntity()
    if not IsValid(ent) then return end
    ent.LightType = net.ReadInt(3)
    ent.Name = net.ReadString()
    --ent.Name = " BUDAPEiT"..string.gsub(ent.Name,"[A-Za-z]*","")
    ent.Lenses = net.ReadString()
    ent.ARSOnly = ent.Lenses == "ARSOnly"
    ent.RouteNumberSetup = net.ReadString()
    ent.Left = net.ReadBool()
    ent.Double = net.ReadBool()
    ent.DoubleL = net.ReadBool()
    ent.AutostopPresent = net.ReadBool()
    if not ent.ARSOnly then
        ent.LensesTBL = string.Explode("-",ent.Lenses)
    end
    if ent.RemoveModels then ent:RemoveModels() end
end)

function ENT:Think()
    self.PrevTime = self.PrevTime or RealTime()
    self.DeltaTime = (RealTime() - self.PrevTime)
    self.PrevTime = RealTime()
    if self:IsDormant() or Metrostroi and Metrostroi.ReloadClientside then
        if not self.ReloadModels and self.ModelsCreated then
            self:RemoveModels()
        end
        return
    end

    if self.ReloadModels then
        self.ReloadModels = false
        self:RemoveModels()
    end

    if not self.Name then
        if self.sended and (CurTime() - self.sended) > 0 then
            self.sended = nil
        end
        if not self.sended then
            net.Start("metrostroi-signal")
                net.WriteEntity(self)
            net.SendToServer()
            self.sended = CurTime() + 1.5
        end
        return
    end
    local TLM = self.TrafficLightModels[self.LightType]

    if not self.ModelsCreated then
        local ID = 0
        local ID2 = 0
        -- Create new clientside models
        if not self.ARSOnly then
            --SPAWN A OLD ROUTE Numbers
            local rn1 = {}
            local rn2 = {}
            self.RouteNumbers = {}
            self.SpecRouteNumbers = {}
            for i=1,#self.RouteNumberSetup do
                local CurRN = self.RouteNumberSetup[i]
                if self.OldRouteNumberSetup[1]:find(CurRN) then
                    table.insert(rn1,CurRN)
                elseif self.OldRouteNumberSetup[2]:find(CurRN) then
                    table.insert(rn2,CurRN)
                elseif self.OldRouteNumberSetup[3]:find(CurRN) then
                    table.insert(self.SpecRouteNumbers,{CurRN,CurRN == "F"})
                end
            end
            for i=1,#rn1,2 do
                table.insert(self.RouteNumbers,{rn1[i],rn1[i+1],true})
            end
            for k,v in pairs(rn2) do
                table.insert(self.RouteNumbers,{v})
            end
            self.Arrow = nil
            if #self.SpecRouteNumbers > 0 then
                for k,v in pairs(self.SpecRouteNumbers) do
                    if not v[2] then
                        self.Arrow = k
                        self.SpecRouteNumbers = v
                        break
                    end
                end
            end
            local LenseNum = self.Arrow and 1 or 0
            local OneLense = self.Arrow == nil
            for k,v in ipairs(self.LensesTBL) do
                if k > 1 and v:find("[RGBWYM]+") then
                    OneLense = false
                end
                for i=1,#v do
                    if v[i]:find("[RGBWYM]") then
                        LenseNum = LenseNum+1
                    end
                end
            end
            if LenseNum == 0 then OneLense = false end
            local offset = self.RenderOffset[self.LightType] or Vector(0,0,0)
            self.LongOffset = self.LongOffset or Vector(0,0,0)
            if not self.Left or self.Double then self:SpawnMainModels(self.BasePosition,Angle(0,0,0),LenseNum) end
            if self.Left or self.Double then self:SpawnMainModels(self.BasePosition*Vector(-1,1,1),Angle(0,180,0),LenseNum,self.Double and "d" or nil) end


            if not self.RouteNumbers.sep and #self.RouteNumbers > 1 then
                self.RouteNumbers.sep = 2
            elseif not self.RouteNumbers.sep and #self.RouteNumbers > 0 then
                self.RouteNumbers.sep = 1
            end
            if self.RouteNumbers.sep and self.RouteNumbers[self.RouteNumbers.sep][1] ~= "X" then
                local id = self.RouteNumbers.sep
                local rnadd = self.RouteNumbers[id][3] and not self.RouteNumbers[id][2] and "3" or "4"
                self.Models[1]["rous"] = ClientsideModel("models/metrostroi/signals/mus/light_lampindicator"..rnadd..".mdl",RENDERGROUP_OPAQUE)
                self.RouteNumbers[id].pos = (self.BasePosition+offset+self.LongOffset-Vector(8,0,0))
                if self.Left then self.RouteNumbers[id].pos = self.RouteNumbers[id].pos*Vector(-0.9,1,1) end
                self.Models[1]["rous"]:SetPos(self:LocalToWorld(self.RouteNumbers[id].pos))
                self.Models[1]["rous"]:SetAngles(self:GetAngles())
                self.Models[1]["rous"]:SetParent(self)
            end
            if #self.RouteNumbers > 0 and (#self.RouteNumbers ~= 1 or not self.RouteNumbers.sep) then
                self.RN = 1
                self.RouteNumberOffset = Vector(10,0,0)
                offset = offset + self.RouteNumberOffset*Vector(self.Left and -1 or 1,1,1)
            else
                self.RouteNumberOffset = nil
                self.RN = nil
            end
            if self.AutostopPresent then
                if not IsValid(self.Models[1]["autostop"]) then
                    self.Models[1]["autostop"] = ClientsideModel(self.AutostopModel[1],RENDERGROUP_OPAQUE)
                    self.Models[1]["autostop"]:SetPos(self:LocalToWorld(self.BasePosition+self.AutostopModel[2]))
                    self.Models[1]["autostop"]:SetAngles(self:GetAngles())
                    self.Models[1]["autostop"]:SetParent(self)
                end
            end
            self.NamesOffset = Vector(0,0,0)
            -- Create traffic light models
            --if self.LightType > 2 then self.LightType = 2 end
            --if self.LightType < 0 then self.LightType = 0 end
            local first = true
            for _,v in ipairs(self.LensesTBL) do
                local data
                if not self.TrafficLightModels[self.LightType][v] then
                    data = self.TrafficLightModels[self.LightType][#v-1]
                else
                    if v == "M" then
                        self.RouteNumber = ID
                    end
                    data = self.TrafficLightModels[self.LightType][v]
                end
                if not data then continue end
                if first then
                    first = false
                else
                    offset = offset - Vector(0,0,data[1])
                end

                self.NamesOffset = self.NamesOffset + Vector(0,0,data[1])
                if not self.Left or self.Double then    self:SpawnHeads(ID,data[2],self.BasePosition + offset + self.LongOffset,Angle(0,0,0),data[3] and data[3].glass,v~="M") end
                if self.Left or self.Double then self:SpawnHeads((self.Double and ID.."d" or ID),(not TLM.noleft) and data[2]:Replace(".mdl","_mirror.mdl") or data[2],self.BasePosition*Vector(-1,1,1) + offset + self.LongOffset,Angle(0,0,0),data[3] and data[3].glass,v~="M",true) end
                if v ~= "M" then
                    for i = 1,#v do
                        ID2 = ID2 + 1
                        if not self.Signals[ID2] then self.Signals[ID2] = {} end
                        if not self.DoubleL then
                            self:SetLight(ID,ID2,self.BasePosition*Vector(self.Left and -1 or 1,1,1) + offset + self.LongOffset + data[3][i-1]*Vector(self.Left and -1 or 1,1,1),Angle(0,0,0),self.SignalConverter[v[i]]-1,0    )
                        else
                            self:SetLight(ID,ID2,self.BasePosition*Vector( 1,1,1) + offset + self.LongOffset + data[3][i-1]*Vector(1,1,1),Angle(0,0,0),self.SignalConverter[v[i]]-1,0)
                            self:SetLight(ID,ID2.."x",self.BasePosition*Vector(-1,1,1) + offset + self.LongOffset + data[3][i-1]*Vector(-1,1,1),Angle(0,0,0),self.SignalConverter[v[i]]-1,0)
                        end
                    end
                end

                ID = ID + 1
            end
            if self.Arrow then
                local id = self.Arrow
                self.Models[1]["roua"] = ClientsideModel("models/metrostroi/signals/mus/light_lampindicator4.mdl",RENDERGROUP_OPAQUE)
                self.SpecRouteNumbers.pos = (self.BasePosition+offset+self.LongOffset-Vector(3,0,3))*Vector(self.Left and -1 or 1,1,self.Left and 0.85 or 1)-(self.RouteNumberOffset or Vector())
                self.Models[1]["roua"]:SetPos(self:LocalToWorld(self.SpecRouteNumbers.pos))
                self.Models[1]["roua"]:SetAngles(self:LocalToWorldAngles(Angle(self.Left and -90 or 90,0,0)))
                self.Models[1]["roua"]:SetParent(self)
            end
            offset = self.RenderOffset[self.LightType]+(OneLense and TLM.name_one or TLM.name)+(OneLense and self.RouteNumberOffset or Vector())
            if self.LightType == 1 then
                offset = offset - self.NamesOffset
            end
            local double = self.LightType ~= 1 and string.find(self.Name,"^[A-Z][A-Z]")
            if double then
                    if not self.Left or self.Double then
                        self:SpawnLetter(0,"models/metrostroi/signals/mus/sign_letter_small.mdl",offset - Vector(-1.5,0,0),(Metrostroi.LiterWarper[self.Name[0+1]] or self.Name[0+1]),true)
                        self:SpawnLetter(1,"models/metrostroi/signals/mus/sign_letter_small.mdl",offset - Vector(1.5,0,0),(Metrostroi.LiterWarper[self.Name[1+1]] or self.Name[1+1]),true)
                    end
                    if self.Left or self.Double then
                        self:SpawnLetter(0,"models/metrostroi/signals/mus/sign_letter_small.mdl",offset - Vector(1.5,0,0),(Metrostroi.LiterWarper[self.Name[0+1]] or self.Name[0+1]),false)
                        self:SpawnLetter(1,"models/metrostroi/signals/mus/sign_letter_small.mdl",offset - Vector(-1.5,0,0),(Metrostroi.LiterWarper[self.Name[1+1]] or self.Name[1+1]),false)
                    end
            end
            local min = 0
            for i = double and 2 or 0,#self.Name-1 do
                local id = (double and i-1 or i) - min
                if double and i == 2 then offset = offset + Vector(0,0,1.62) end
                if self.Name[i+1] == " " then continue end
                if self.Name[i+1] == "/" then min = min + 1; continue end
                --if not IsValid(self.Models[2][i]) then
                self:SpawnLetter(i,"models/metrostroi/signals/mus/sign_letter.mdl",offset - Vector(0,0,id*5.85),(Metrostroi.LiterWarper[self.Name[i+1]] or self.Name[i+1]))
                --end
            end
            if self.Name and self.Name:match("(/+)$") then
                local i = #self.Name
                local id = (double and i-1 or i) - min
                self:SpawnLetter(i,"models/metrostroi/signals/mus/sign_letter.mdl",offset - Vector(0,0,id*5.85),Format("s%d",math.min(3,#self.Name:match("(/+)$"))))
            end
        else
            local k = "m1"

            if not IsValid(self.Models[1][k]) then
                local v = TLM["m1"]
                self.Models[1][k] = ClientsideModel(v,RENDERGROUP_OPAQUE)
                self.Models[1][k]:SetPos(self:LocalToWorld(self.BasePosition*Vector(self.Left and -1 or 1,1,1)))
                self.Models[1][k]:SetAngles(self:LocalToWorldAngles(Angle(self.Left and -1 or 1,1,1)))
                self.Models[1][k]:SetParent(self)
            end
        end
        self.Models.have = true
        self.ModelsCreated = true
    else
        --TODO
        if self.AutostopPresent then
            if IsValid(self.Models[1]["autostop"]) then
                self.Models[1]["autostop"]:SetPoseParameter("position",self:Animate("Autostop", self:GetNW2Bool("Autostop") and 1 or 0,     0,1, 0.4,false))
            end
        end


        self.Sig = self:GetNW2String("Signal","")
        self.Num = self:GetNW2String("Number",nil)
        if self.OldNum ~= self.Num then
            self.NextNumWork = CurTime() + 1
        end
        self.OldNum = self.Num

        if (self.NextNumWork or CurTime()) - CurTime() >= 0 then
            self.Num = ""
        end
        if self.ARSOnly then return end
        local offset = (self.RenderOffset[self.LightType] or Vector(0,0,0))
        if self.RouteNumberOffset then offset = offset + self.RouteNumberOffset*Vector(self.Left and -1 or 1,1) end
        local ID = 0
        local ID2 = 0
        local first = true
        for _,v in ipairs(self.LensesTBL) do
            local data
            if not self.TrafficLightModels[self.LightType][v] then
                data = self.TrafficLightModels[self.LightType][#v-1]
            else
                data = self.TrafficLightModels[self.LightType][v]
            end
            if not data then continue end
            if first then
                first = false
            else
                offset = offset - Vector(0,0,data[1])
            end

            --self.NamesOffset = self.NamesOffset + Vector(0,0,data[1])
            if v ~= "M" then
                for i = 1,#v do
                    ID2 = ID2 + 1
                    if tonumber(self.Sig[ID2]) and self.Signals[ID2].RealState ~= (tonumber(self.Sig[ID2]) > 0) then
                        self.Signals[ID2].RealState = tonumber(self.Sig[ID2]) > 0
                        self.Signals[ID2].Stop = CurTime() + 0.5
                    end
                    if self.Signals[ID2].Stop and CurTime()-self.Signals[ID2].Stop > 0 then
                        self.Signals[ID2].Stop = nil
                    end
                    local State = self:Animate(ID.."/"..i,  ((tonumber(self.Sig[ID2]) == 1 or (tonumber(self.Sig[ID2]) == 2 and (RealTime() % 1.2 > 0.4))) and not self.Signals[ID2].Stop) and 1 or 0,  0,1, 128)
                    if not IsValid(self.Models[3][ID..ID2]) and State > 0 then self.Signals[ID2].State = nil end
                    if not self.DoubleL then
                        self:SetLight(ID,ID2,self.BasePosition*Vector(self.Left and -1 or 1,1,1) + offset + self.LongOffset + data[3][i-1]*Vector(self.Left and -1 or 1,1,1),Angle(0,0,0),self.SignalConverter[v[i]]-1,State,self.Signals[ID2].State ~= State)
                    else
                        self:SetLight(ID,ID2,self.BasePosition*Vector( 1,1,1) + offset + self.LongOffset + data[3][i-1]*Vector(1,1,1),Angle(0,0,0),self.SignalConverter[v[i]]-1,State,self.Signals[ID2].State ~= State)
                        self:SetLight(ID,ID2.."x",self.BasePosition*Vector(-1,1,1) + offset + self.LongOffset + data[3][i-1]*Vector(-1,1,1),Angle(0,0,0),self.SignalConverter[v[i]]-1,State,self.Signals[ID2].State ~= State)
                    end
                    self.Signals[ID2].State = State
                end
            else
                if Metrostroi.RoutePointer[self.Num[1]] and IsValid(self.Models[1][self.RouteNumber]) then self.Models[1][self.RouteNumber]:SetSkin(Metrostroi.RoutePointer[self.Num[1]]) end
            end

            ID = ID + 1
        end
        for k,v in pairs(self.RouteNumbers) do
            if k == "sep" then continue end
            local State1 = self:Animate("rou1"..k,self.Num:find(v[1]) and 1 or 0,   0,1, 256)
            local State2
            --if v[3] then
            if v[2] then State2 = self:Animate("rou2"..k,self.Num:find(v[2])and 1 or 0,     0,1, 256) end
            if not IsValid(self.Models[3]["rou1"..k]) and State1 > 0 then
                self.Models[3]["rou1"..k] = ClientsideModel("models/metrostroi/signals/mus/light_lampindicator_"..(v[3] and "numb" or "lamp")..".mdl",RENDERGROUP_OPAQUE)
                self.Models[3]["rou1"..k]:SetPos(self:LocalToWorld(v.pos + self.OldRouteNumberSetup[4]))
                self.Models[3]["rou1"..k]:SetAngles(self:GetAngles())
                self.Models[3]["rou1"..k]:SetParent(self)
                self.Models[3]["rou1"..k]:SetSkin(v[3] and self.OldRouteNumberSetup[5][v[1]] or self.OldRouteNumberSetup[6][v[1]] or tonumber(v[1])-1)
                self.Models[3]["rou1"..k]:SetRenderMode(RENDERMODE_TRANSCOLOR)
                self.Models[3]["rou1"..k]:SetColor(Color(255,255,255,0))
            end
            if IsValid(self.Models[3]["rou1"..k]) then
                if State1 > 0 then
                    self.Models[3]["rou1"..k]:SetColor(Color(255,255,255,State1*255))
                elseif State1 == 0 then
                    self.Models[3]["rou1"..k]:Remove()
                end
            end
            if not IsValid(self.Models[3]["rou2"..k]) and v[3] and v[2] and State2 > 0 then
                self.Models[3]["rou2"..k] = ClientsideModel("models/metrostroi/signals/mus/light_lampindicator_numb.mdl",RENDERGROUP_OPAQUE)
                self.Models[3]["rou2"..k]:SetPos(self:LocalToWorld(v.pos + self.OldRouteNumberSetup[4] + Vector(0,0,7.2)))
                self.Models[3]["rou2"..k]:SetAngles(self:GetAngles())
                self.Models[3]["rou2"..k]:SetParent(self)
                self.Models[3]["rou2"..k]:SetSkin(self.OldRouteNumberSetup[5][v[2]] or tonumber(v[2])-1)
                self.Models[3]["rou2"..k]:SetRenderMode(RENDERMODE_TRANSCOLOR)
                self.Models[3]["rou2"..k]:SetColor(Color(255,255,255,0))
            end
            if IsValid(self.Models[3]["rou2"..k]) then
                if State2 > 0 then
                    self.Models[3]["rou2"..k]:SetColor(Color(255,255,255,State2*255))
                elseif State2 == 0 then
                    self.Models[3]["rou2"..k]:Remove()
                end
            end
        end
        if self.Arrow then
            local State = self:Animate("roua",self.Num:find(self.SpecRouteNumbers[1]) and 1 or 0,   0,1, 256)
            if not IsValid(self.Models[3]["roua"]) and State > 0 then
                self.Models[3]["roua"] = ClientsideModel("models/metrostroi/signals/mus/light_lampindicator_lamp.mdl",RENDERGROUP_OPAQUE)
                self.SpecRouteNumbers.pos = (self.BasePosition+offset-Vector(3,-1,3))-self.RouteNumberOffset+ Vector(10.5,0,-6)
                if self.Left then self.SpecRouteNumbers.pos = self.SpecRouteNumbers.pos*Vector(-0.8,1,0.94) end
                self.Models[3]["roua"]:SetPos(self.Models[1]["roua"]:LocalToWorld(Vector(6.2,0,24.5)))
                self.Models[3]["roua"]:SetAngles(self.Models[1]["roua"]:LocalToWorldAngles(Angle(180,0,0)))
                self.Models[3]["roua"]:SetParent(self)
                if self.Left then
                    if self.Num[1] == "L" then
                        self.Models[3]["roua"]:SetSkin(self.OldRouteNumberSetup[6]["R"] or 0)
                    else
                        self.Models[3]["roua"]:SetSkin(self.OldRouteNumberSetup[6]["L"] or 0)
                    end
                else
                    self.Models[3]["roua"]:SetSkin(self.OldRouteNumberSetup[6][self.Num[1]] or 0)
                end
                self.Models[3]["roua"]:SetRenderMode(RENDERMODE_TRANSCOLOR)
                self.Models[3]["roua"]:SetColor(Color(255,255,255,0))
            end
            if IsValid(self.Models[3]["roua"]) then
                if State > 0 then
                    self.Models[3]["roua"]:SetColor(Color(255,255,255,State*255))
                elseif State == 0 then
                    self.Models[3]["roua"]:Remove()
                end
            end
        end
        --self.SpecRouteNumbers
    end
end

function ENT:Draw()
    -- Draw model
    self:DrawModel()
end
local debug = GetConVar("metrostroi_drawsignaldebug")

local ars = {
    {"275 Hz", "0 KM/H"},
    {"N/A Hz", "No frequency"},
    {"275-N/A", "Absolute stop"},
    nil,
    {"225 Hz", "40 KM/H"},
    nil,
    {"175 Hz", "60 KM/H"},
    {"125 Hz", "70 KM/H"},
    {"75  Hz", "80 KM/H"},
}
local function enableDebug()
    if debug:GetBool() then
        hook.Add("PostDrawTranslucentRenderables","MetrostroiSignalDebug",function(bDrawingDepth,bDrawingSkybox)
            for _,ent in pairs(ents.FindByClass("gmod_track_signal")) do
                if bDrawingDepth and LocalPlayer():GetPos():Distance(sig:GetPos()) < 384 then
                    local pos = sig:LocalToWorld(Vector(48,0,150))
                    local ang = sig:LocalToWorldAngles(Angle(0,180,90))
                    cam.Start3D2D(pos, ang, 0.25)

                        if sig:GetNW2Bool("Debug",false) then
                            surface.SetDrawColor(sig.ARSOnly and 255 or 125, 125, 0, 255)
                            surface.DrawRect(0, -60, 364, 210)
                            if not sig.ARSOnly then
                                surface.DrawRect(0, 155, 240, 170)
                                surface.DrawRect(0, 330, 240, 190)
                                surface.SetDrawColor(0,0,0, 255)
                                surface.DrawRect(245, 155, 119, 365)
                            else
                                surface.DrawRect(0, 155, 364, 150)
                                surface.DrawRect(0, 310, 364, 190)
                            end

                            if sig.Name then
                                draw.DrawText(Format("Joint main info (%d)",sig:EntIndex()),"Trebuchet24",5,-60,Color(200,0,0,255))
                                draw.DrawText("Signal name: "..sig.Name,"Trebuchet24",          15, -40,Color(0,0,0,255))
                                draw.DrawText("TrackID: "..sig:GetNW2Int("PosID",0),"Trebuchet24",  25, -20,Color(0,0,0,255))
                                    draw.DrawText(Format("PosX: %.02f",sig:GetNW2Float("Pos",0)),"Trebuchet24", 135, -20,Color(0,0,0,255))
                                draw.DrawText(Format("NextSignalName: %s",sig:GetNW2String("NextSignalName","N/A")),"Trebuchet24",  15, 0,Color(0,0,0,255))
                                draw.DrawText(Format("TrackID: %s",sig:GetNW2Int("NextPosID",0)),"Trebuchet24", 25, 20,Color(0,0,0,255))
                                    draw.DrawText(Format("PosX: %.02f",sig:GetNW2Float("NextPos",0)),"Trebuchet24", 135, 20,Color(0,0,0,255))
                                draw.DrawText(Format("Dist: %.02f",sig:GetNW2Float("DistanceToNext",0)),"Trebuchet24",  15, 40,Color(0,0,0,255))
                                draw.DrawText(Format("PrevSignalName: %s",sig:GetNW2String("PrevSignalName","N/A")),"Trebuchet24",  15, 60,Color(0,0,0,255))
                                draw.DrawText(Format("TrackID: %s",sig:GetNW2Int("PrevPosID",0)),"Trebuchet24", 25, 80,Color(0,0,0,255))
                                    draw.DrawText(Format("PosX: %.02f",sig:GetNW2Float("PrevPos",0)),"Trebuchet24", 135, 80,Color(0,0,0,255))
                                draw.DrawText(Format("DistPrev: %.02f",sig:GetNW2Float("DistanceToPrev",0)),"Trebuchet24",  15, 100,Color(0,0,0,255))
                                draw.DrawText(Format("Current route: %d",sig:GetNW2Int("CurrentRoute",-1)),"Trebuchet24",   15, 120,Color(0,0,0,255))

                                draw.DrawText("AB info","Trebuchet24",5,160,Color(200,0,0,255))
                                draw.DrawText(Format("Occupied: %s",sig:GetNW2Bool("Occupied",false) and "Y" or "N"),"Trebuchet24",5,180,Color(0,0,0,255))
                                draw.DrawText(Format("Linked to controller: %s",sig:GetNW2Bool("LinkedToController",false) and "Y" or "N"),"Trebuchet24",5,200,Color(0,0,0,255))
                                draw.DrawText(Format("Num: %d",sig:GetNW2Int("ControllersNumber",0)),"Trebuchet24",10,220,Color(0,0,0,255))
                                draw.DrawText(Format("Controller logic: %s",sig:GetNW2Bool("BlockedByController",false) and "Y" or "N"),"Trebuchet24",5,240,Color(0,0,0,255))
                                draw.DrawText(Format("Autostop: %s",not sig.ARSOnly and sig.AutostopPresent and (sig:GetNW2Bool("Autostop") and "Up" or "Down") or "No present"),"Trebuchet24",5,260,Color(0,0,0,255))
                                draw.DrawText(Format("2/6: %s",sig:GetNW2Bool("2/6",false) and "Y" or "N"),"Trebuchet24",5,280,Color(0,0,0,255))
                                draw.DrawText(Format("FreeBS: %d",sig:GetNW2Int("FreeBS")),"Trebuchet24",5,300,Color(0,0,0,255))

                                draw.DrawText("ARS info","Trebuchet24",5,335,Color(200,0,0,255))
                                local num = 0
                                for i,tbl in pairs(ars) do
                                    if not tbl then continue end
                                    if sig:GetNW2Bool("CurrentARS"..(i-1),false) then
                                        draw.DrawText(Format("(% s)",tbl[1]),"Trebuchet24",5,355+num*20,Color(0,100,0,255))
                                        draw.DrawText(Format("%s",tbl[2]),"Trebuchet24",105,355+num*20,Color(0,100,0,255))
                                    else
                                        draw.DrawText(Format("(% s)",tbl[1]),"Trebuchet24",5,355+num*20,Color(0,0,0,255))
                                        draw.DrawText(Format("%s",tbl[2]),"Trebuchet24",105,355+num*20,Color(0,0,0,255))
                                    end
                                    num = num+1
                                end
                                if sig:GetNW2Bool("CurrentARS325",false) or sig:GetNW2Bool("CurrentARS325_2",false) then
                                    draw.DrawText("(325 Hz)","Trebuchet24",5,355+num*20,Color(0,100,0,255))
                                    draw.DrawText(Format("LN:%s Apr0:%s",sig:GetNW2Bool("CurrentARS325",false) and "Y" or "N",sig:GetNW2Bool("CurrentARS325_2",false) and "Y" or "N"),"Trebuchet24",105,355+num*20,Color(0,100,0,255))
                                else
                                    draw.DrawText("(325 Hz)","Trebuchet24",5,355+num*20,Color(0,0,0,255))
                                    draw.DrawText(Format("LN:%s Apr0:%s",sig:GetNW2Bool("CurrentARS325",false) and "Y" or "N",sig:GetNW2Bool("CurrentARS325_2",false) and "Y" or "N"),"Trebuchet24",105,355+num*20,Color(0,0,0,255))
                                end

                                if not sig.ARSOnly then
                                    draw.DrawText("Signal info","Trebuchet24",250,160,Color(200,0,0,255))
                                    local ID = 0
                                    local ID2 = 0
                                    local first = true
                                    for _,v in ipairs(sig.LensesTBL) do
                                        local data
                                        if not sig.TrafficLightModels[sig.LightType][v] then
                                            data = sig.TrafficLightModels[sig.LightType][#v-1]
                                        else
                                            data = sig.TrafficLightModels[sig.LightType][v]
                                        end
                                        if not data then continue end

                                        --sig.NamesOffset = sig.NamesOffset + Vector(0,0,data[1])
                                        local cols = {
                                            R = Color(200,0,0),
                                            Y = Color(200,200,0),
                                            G = Color(0,200,0),
                                            W = Color(200,200,200),
                                            B = Color(0,0,200),
                                        }
                                        if v ~= "M" then
                                            for i = 1,#v do
                                                ID2 = ID2 + 1
                                                local State = tonumber(sig.Sig[ID2]) == 1 and "X" or (tonumber(sig.Sig[ID2]) == 2 and (RealTime() % 1.2 > 0.4)) and "B" or false
                                                draw.DrawText(Format(v[i],sig:EntIndex()),"Trebuchet24",250,160 + ID*20 + ID2*20,cols[v[i]])
                                                if State then
                                                    draw.DrawText(State,"Trebuchet24",280,160 + ID*20 + ID2*20,cols[v[i]])
                                                end
                                            end
                                        else
                                            ID2 = ID2 + 1
                                            draw.DrawText("M","Trebuchet24",250,160 + ID*20 + ID2*20,Color(200,200,200))
                                            draw.DrawText(sig.Num or "none","Trebuchet24",280,160 + ID*20 + ID2*20,Color(200,200,200))

                                            --if Metrostroi.RoutePointer[sig.Num[1]] then sig.Models[1][sig.RouteNumber]:SetSkin(Metrostroi.RoutePointer[sig.Num[1]]) end
                                        end

                                        ID = ID + 1
                                    end
                                end
                            else
                                draw.DrawText("No data...","Trebuchet24",5,0,Color(0,0,0,255))
                            end
                        else
                            surface.SetDrawColor(sig.ARSOnly and 255 or 125, 125, 0, 255)
                            surface.DrawRect(0, 0, 364, 25)
                            draw.DrawText("Debug disabled...","Trebuchet24",5,0,Color(0,0,0,255))
                        end
                    cam.End3D2D()
                end
            end
        end)
    else
        hook.Remove("PostDrawTranslucentRenderables","MetrostroiSignalDebug")
    end
end
hook.Remove("PostDrawTranslucentRenderables","MetrostroiSignalDebug")
cvars.AddChangeCallback( "metrostroi_drawsignaldebug", enableDebug)
enableDebug()

Metrostroi.OptimisationPatch()
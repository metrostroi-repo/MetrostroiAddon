AddCSLuaFile()
--Entity only for spawner!
function ENT:Initialize() self:Remove() end

ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"
ENT.PrintName = "81-717 SPB Custom"
ENT.SkinsType = "81-717_spb"

ENT.Spawnable       = false
ENT.AdminSpawnable  = false

ENT.SubwayTrain = {
    Type = "81",
    Name = "81-717.5m",
    WagType = 1,
    Manufacturer = "SPB",
}

ENT.Spawner = {
    model = {
        "models/metrostroi_train/81-717/81-717_spb.mdl",
        "models/metrostroi_train/81-717/interior_spb.mdl",
        "models/metrostroi_train/81-717/717_body_additional_spb.mdl",
        "models/metrostroi_train/81-717/brake_valves/334.mdl",
        "models/metrostroi_train/81-717/lamps_type1.mdl",
        "models/metrostroi_train/81-717/couch_old.mdl",
        "models/metrostroi_train/81-717/couch_cap_l.mdl",
        "models/metrostroi_train/81-717/handlers_old.mdl",
        "models/metrostroi_train/81-717/mask_spb_222.mdl",
        "models/metrostroi_train/81-717/couch_cap_r.mdl",
        "models/metrostroi_train/81-717/cabine_spb_central.mdl",
        "models/metrostroi_train/81-717/pult/body_spb_yellow.mdl",
        "models/metrostroi_train/81-717/pult/pult_spb_yellow.mdl",
        "models/metrostroi_train/81-717/pult/puav_new.mdl",
        "models/metrostroi_train/81-717/pult/ars_spb_yellow.mdl",
    },
    head = "gmod_subway_81-717_lvz",
    interim = "gmod_subway_81-714_lvz",
    func = function(train,i,max,LastRot)
        train.CustomSettings = true
        local typ = train:GetNW2Int("Type")
        if 1==i or i==max then
            train.NumberRangesID = typ==1 and math.ceil(math.random()+0.5) or typ+1
        else
            train.NumberRangesID = typ
        end
    end,
    {"Type","Spawner.717.Type","List",{"Spawner.717.Type.Line2","Spawner.717.Type.Line4","Spawner.717.Type.Line5"}},
    {"Scheme","Spawner.717.Schemes","List",function()
        local Schemes = {}
        for k,v in pairs(Metrostroi.Skins["717_new_schemes"] or {}) do Schemes[k] = v.name or k end
        return Schemes
    end},
    {},
    Metrostroi.Skins.GetTable("Texture","Spawner.Texture",false,"train"),
    Metrostroi.Skins.GetTable("PassTexture","Spawner.PassTexture",false,"pass"),
    Metrostroi.Skins.GetTable("CabTexture","Spawner.CabTexture",false,"cab"),
    {},
    {"SeatType","Spawner.717.SeatType","List",{"Spawner.717.Common.Random","Spawner.717.Common.Old","Spawner.717.Common.New","Spawner.717.Common.NewBlue"}},
    {},
    {"SpawnMode","Spawner.717.SpawnMode","List",{"Spawner.717.SpawnMode.Full","Spawner.717.SpawnMode.Deadlock","Spawner.717.SpawnMode.NightDeadlock","Spawner.717.SpawnMode.Depot"}, nil,function(ent,val,rot,i,wagnum,rclk)
        if rclk then return end
        if ent._SpawnerStarted~=val then
            ent.VB:TriggerInput("Set",val<=2 and 1 or 0)
            ent.ParkingBrake:TriggerInput("Set",val==3 and 1 or 0)
            if ent.AR63  then
                local first = i==1 or _LastSpawner~=CurTime()
                ent.OhrSig:TriggerInput("Set",val<4 and 1 or 0)
                ent.A53:TriggerInput("Set",val<=3 and 1 or 0)
                ent.AR63:TriggerInput("Set",val<=2 and 1 or 0)
                ent.R_UNch:TriggerInput("Set",val==1 and 1 or 0)
                ent.R_UPO:TriggerInput("Set",val<=2 and 1 or 0)
                if ent.Plombs.RC1 and val<=2 then
                    ent.VPAOn:TriggerInput("Set",1)
                    timer.Simple(1,function()
                        if not IsValid(ent) or val > 2 then return end
                            ent.VPAOn:TriggerInput("Set",0)
                    end)
                else
                    ent.VPAOn:TriggerInput("Set",0)
                end
                ent.VAU:TriggerInput("Set",(ent.Plombs.RC2 and val<=2) and 1 or 0)
                ent.L_4:TriggerInput("Set",val==1 and 1 or 0)
                ent.BPSNon:TriggerInput("Set",(val==1 and first) and 1 or 0)
                ent.VMK:TriggerInput("Set",(val==1 and first) and 1 or 0)
                ent.ARS:TriggerInput("Set",(ent.Plombs.RC1 and val==1 and first) and 1 or 0)
                ent.ALS:TriggerInput("Set",(ent.Plombs.RC1 and val==1) and 1 or 0)
                ent.L_1:TriggerInput("Set",val==1 and 1 or 0)
                ent.L_3:TriggerInput("Set",val==1 and 1 or 0)
                ent.L_4:TriggerInput("Set",val==1 and 1 or 0)
                ent.EPK:TriggerInput("Set",(ent.Plombs.RC1 and val==1) and 1 or 0)
                _LastSpawner=CurTime()
                ent.CabinDoor = val==4 and first
                ent.PassengerDoor = val==4
                ent.RearDoor = val==4
            else
                ent.FrontDoor = val==4
                ent.RearDoor = val==4
            end
            if val == 1 then
                timer.Simple(1,function()
                    if not IsValid(ent) then return end
                    ent.BV:TriggerInput("Enable",1)
                end)
            end
            ent.GV:TriggerInput("Set",val<4 and 1 or 0)
            ent._SpawnerStarted = val
        end
        ent.Pneumatic.TrainLinePressure = val==3 and math.random()*4 or val==2 and 4.5+math.random()*3 or 7.6+math.random()*0.6
        if val==4 then ent.Pneumatic.BrakeLinePressure = 5.2 end
    end},
}

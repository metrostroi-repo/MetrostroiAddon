AddCSLuaFile()
--Entity only for spawner!
function ENT:Initialize() self:Remove() end

ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"
ENT.PrintName = "81-717 MVM Custom"
ENT.SkinsType = "81-717_msk"

ENT.Spawnable       = false
ENT.AdminSpawnable  = false

ENT.SubwayTrain = {
    Type = "81",
    Name = "81-717.5m",
    WagType = 1,
    Manufacturer = "MVM",
}

local Announcer = {}
for k,v in pairs(Metrostroi.AnnouncementsASNP or {}) do Announcer[k] = v.name or k end
local Schemes = {}
for k,v in pairs(Metrostroi.Skins["717_new_schemes"] or {}) do Schemes[k] = v.name or k end

ENT.Spawner = {
    model = {
        "models/metrostroi_train/81-717/81-717_mvm.mdl",
        "models/metrostroi_train/81-717/interior_mvm.mdl",
        "models/metrostroi_train/81-717/717_body_additional.mdl",
        "models/metrostroi_train/81-717/brake_valves/334.mdl",
        "models/metrostroi_train/81-717/lamps_type1.mdl",
        "models/metrostroi_train/81-717/couch_old.mdl",
        "models/metrostroi_train/81-717/couch_cap_l.mdl",
        "models/metrostroi_train/81-717/handlers_old.mdl",
        "models/metrostroi_train/81-717/mask_222.mdl",
        "models/metrostroi_train/81-717/couch_cap_r.mdl",
        "models/metrostroi_train/81-717/cabine_mvm.mdl",
        "models/metrostroi_train/81-717/pult/body_classic.mdl",
        "models/metrostroi_train/81-717/pult/pult_mvm_classic.mdl",
        "models/metrostroi_train/81-717/pult/ars_old.mdl",
    },
    head = "gmod_subway_81-717_mvm",
    interim = "gmod_subway_81-714_mvm",
    func = function(train,i,max,LastRot)
        train.CustomSettings = true
        local typ = train:GetNW2Int("Type")
        local body = train:GetNW2Int("BodyType")

        if typ==1 then
            train.NumberRangesID = body>1 and 3 or (math.random()>0.5 and 2 or 1)
        else
            train.NumberRangesID = body>1 and (math.random()>0.5 and 6 or 7) or (math.random()>0.5 and 4 or 5)
        end
    end,
    {"Type","Spawner.717.Type","List",{"81-717","81-717.5"}},
    {"BodyType","Spawner.717.BodyType","List",{"Spawner.717.Type.MVM","Spawner.717.Type.LVZ"}},
    {"Scheme","Spawner.717.Schemes","List",Schemes},
    {},
    {"MaskType","Spawner.717.MaskType","List",{"2-2","2-2-2","1-4-1"}},
    {"Cran","Spawner.717.CranType","List",{"334","013"}},
    {"Announcer","Spawner.717.Announcer","List",Announcer},
    {"LampType","Spawner.717.LampType","List",{"Spawner.717.Common.Random","Spawner.717.Lamp.LPV02","Spawner.717.Lamp.LLV01"}},
    {"SeatType","Spawner.717.SeatType","List",{"Spawner.717.Common.Random","Spawner.717.Common.Old","Spawner.717.Common.New"}},
    {"ARSType","Spawner.717.ARS","List",{"Spawner.717.Common.Random","Spawner.717.ARS.1","Spawner.717.ARS.2","Spawner.717.ARS.3","Spawner.717.ARS.4","Spawner.717.ARS.5"}},
    Metrostroi.Skins.GetTable("Texture","Spawner.Texture",false,"train"),
    Metrostroi.Skins.GetTable("PassTexture","Spawner.PassTexture",false,"pass"),
    Metrostroi.Skins.GetTable("CabTexture","Spawner.CabTexture",false,"cab"),
    --{},
    {"RingType","Spawner.717.RingType","List",{"Spawner.717.Common.Random","Spawner.717.RingType.1","Spawner.717.RingType.2","Spawner.717.RingType.3","Spawner.717.RingType.4","Spawner.717.RingType.5","Spawner.717.RingType.6","Spawner.717.RingType.7","Spawner.717.RingType.8"}},
    {"BPSNType","Spawner.717.BPSNType","List",{"Spawner.717.Common.Random","Spawner.717.BPSNType.1","Spawner.717.BPSNType.2","Spawner.717.BPSNType.3","Spawner.717.BPSNType.4","Spawner.717.BPSNType.5","Spawner.717.BPSNType.6","Spawner.717.BPSNType.7","Spawner.717.BPSNType.8","Spawner.717.BPSNType.9","Spawner.717.BPSNType.10","Spawner.717.BPSNType.11","Spawner.717.BPSNType.12","Spawner.717.BPSNType.13"}},
    {},
    {"SpawnMode","Spawner.717.SpawnMode","List",{"Spawner.717.SpawnMode.Full","Spawner.717.SpawnMode.Deadlock","Spawner.717.SpawnMode.NightDeadlock","Spawner.717.SpawnMode.Depot"}, nil,function(ent,val,rot,i,wagnum,rclk)
        if rclk then return end
        if ent._SpawnerStarted~=val then
            ent.VB:TriggerInput("Set",val<=2 and 1 or 0)
            ent.ParkingBrake:TriggerInput("Set",val==3 and 1 or 0)
            if ent.AR63  then
                local first = i==1 or _LastSpawner~=CurTime()
                ent.A53:TriggerInput("Set",val<=2 and 1 or 0)
                ent.A49:TriggerInput("Set",val<=2 and 1 or 0)
                ent.AR63:TriggerInput("Set",val<=2 and 1 or 0)
                ent.R_UNch:TriggerInput("Set",val==1 and 1 or 0)
                ent.R_Radio:TriggerInput("Set",val==1 and 1 or 0)
                ent.L_4:TriggerInput("Set",val==1 and 1 or 0)
                ent.BPSNon:TriggerInput("Set",(val==1 and first) and 1 or 0)
                ent.VMK:TriggerInput("Set",(val==1 and first) and 1 or 0)
                ent.ARS:TriggerInput("Set",(ent.Plombs.RC1 and val==1 and first) and 1 or 0)
                ent.ALS:TriggerInput("Set",val==1 and 1 or 0)
                ent.L_1:TriggerInput("Set",val==1 and 1 or 0)
                ent.L_3:TriggerInput("Set",vall==1 and 1 or 0)
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
            if val == 1 then ent.BV:TriggerInput("Enable",1) end
            ent.GV:TriggerInput("Set",val<4 and 1 or 0)
            ent._SpawnerStarted = val
        end
        ent.Pneumatic.TrainLinePressure = val==3 and math.random()*4 or val==2 and 4.5+math.random()*3 or 7.6+math.random()*0.6
        if val==4 then ent.Pneumatic.BrakeLinePressure = 5.2 end
    end},
}

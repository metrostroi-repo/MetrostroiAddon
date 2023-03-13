--------------------------------------------------------------------------------
-- Assign train IDs
--------------------------------------------------------------------------------
if not Metrostroi.WagonID then
    Metrostroi.WagonID = 1
end
function Metrostroi.NextWagonID()
    local id = Metrostroi.WagonID
    Metrostroi.WagonID = Metrostroi.WagonID + 1
    if Metrostroi.WagonID > 99 then Metrostroi.WagonID = 1 end
    return id
end

Metrostroi.UsedNumbers = Metrostroi.UsedNumbers or {}
function Metrostroi.RemoveNumber(ent)
    if IsValid(ent) and ent.WagonNumber then
        local typ = ent.SubwayTrain and ent.SubwayTrain.Type or ent:GetClass()
        local tbl = Metrostroi.UsedNumbers[typ]
        if not tbl then return end
        print(Format("Removed number %05d to %s(%04d %s)",ent.WagonNumber,ent:GetClass(),ent:EntIndex(),typ))
        tbl[ent.WagonNumber] = nil
    end
end
hook.Add("EntityRemoved","WagonNumberRemove",Metrostroi.RemoveNumber)
function Metrostroi.GenerateNumber(train,tbl,func,retry)
    Metrostroi.RemoveNumber(train)
    if not tbl or not IsValid(train) then return 0 end
    local typ = train.SubwayTrain and train.SubwayTrain.Type or train:GetClass()
    if not Metrostroi.UsedNumbers[typ] then Metrostroi.UsedNumbers[typ] = {} end
    for i=1,1000 do
        local range = train.NumberRangesID and tbl[train.NumberRangesID] or tbl[math.random(1,#tbl)]
        local number
        if range[1]==true then
            local tblN = range[2]
            number = tblN[math.random(1,#tblN)]
        else
            number = math.random(range[1],range[2])
        end
        if func then number = func(train,number) or number end
        if number and number~=true and not Metrostroi.UsedNumbers[typ][number] then
            Metrostroi.UsedNumbers[typ][number] = true
            print(Format("Assigned number %05d to %s(%04d %s)",number,train:GetClass(),train:EntIndex(),typ))
            return number,range[3]
        end
    end
    if retry then
        ErrorNoHalt(Format("Metrostroi: Error generating number for train %s! Second try was failed.\n",train:GetClass()))
        return 0
    else
        ErrorNoHalt(Format("Metrostroi: Error generating number for train %s! Clearing wagon numbers table...\n",train:GetClass()))
        Metrostroi.UsedNumbers = {}
        return Metrostroi.GenerateNumber(train,tbl,func,true)
    end
end

if not Metrostroi.EquipmentID then
    Metrostroi.EquipmentID = 1
end
function Metrostroi.NextEquipmentID()
    local id = Metrostroi.EquipmentID
    Metrostroi.EquipmentID = Metrostroi.EquipmentID + 1
    return id
end


--------------------------------------------------------------------------------
-- Custom drop to floor that only checks origin and not bounding box
--------------------------------------------------------------------------------
function Metrostroi.DropToFloor(ent)
    local result = util.TraceLine({
        start = ent:GetPos(),
        endpos = ent:GetPos() - Vector(0,0,256),
        mask = -1,
        filter = { ent },
    })
    if result.Hit then ent:SetPos(result.HitPos) end
end




--------------------------------------------------------------------------------
-- Get random number that is same over a period of 1 minute
--------------------------------------------------------------------------------
local prediods = {}
local periodNumbers = {}
local randomPeriodStart = 0
local randomPeriodNumber = math.random()
function Metrostroi.PeriodRandomNumber(typ)
    typ = typ or 0
    if not prediods[typ] or (CurTime() - prediods[typ]) > 60 then
        periodNumbers[typ] = math.random()
    end

    -- Refresh the period
    prediods[typ] = CurTime()

    -- Return number
    return periodNumbers[typ]
end




--------------------------------------------------------------------------------
-- Joystick controls
-- Author: HunterNL
--------------------------------------------------------------------------------
if not Metrostroi.JoystickValueRemap then
    Metrostroi.JoystickValueRemap = {}
    Metrostroi.JoystickSystemMap = {}
end

function Metrostroi.RegisterJoystickInput (uid,analog,desc,min,max)
    if not joystick then
        Error("Joystick Input registered without joystick addon installed, get it at https://github.com/MattJeanes/Joystick-Module")
    end
    --If this is only called in a JoystickRegister hook it should never even happen

    if #uid > 20 then
        print("Metrostroi Joystick UID too long, trimming")
        local uid = string.Left(uid,20)
    end


    local atype
    if analog then
        atype = "analog"
    else
        atype = "digital"
    end

    local temp = {
        uid = uid,
        type = atype,
        description = desc,
        category = "Metrostroi" --Just Metrostroi for now, seperate catagories for different trains later?
        --Catergory is also checked in subway base, don't just change
    }


    --Joystick addon's build-in remapping doesn't work so well, so we're doing this instead
    if min ~= nil and max ~= nil and analog then
        Metrostroi.JoystickValueRemap[uid]={min,max}
    end

    jcon.register(temp)
end

-- Wrapper around joystick get to implement our own remapping
function Metrostroi.GetJoystickInput(ply,uid)
    local remapinfo = Metrostroi.JoystickValueRemap[uid]
    local jvalue = joystick.Get(ply,uid)
    if remapinfo == nil then
        return jvalue
    elseif jvalue ~= nil then
        return math.Remap(joystick.Get(ply,uid),0,255,remapinfo[1],remapinfo[2])
    else
        return jvalue
    end
end




--------------------------------------------------------------------------------
-- Player meta table magic
-- Author: HunterNL
--------------------------------------------------------------------------------
local Player = FindMetaTable("Player")

function Player:CanDriveTrains()
    return IsValid(self:GetWeapon("train_kv_wrench")) or self:IsAdmin()
end

function Player:GetTrain()
    local seat = self:GetVehicle()
    if IsValid(seat) then
        return seat:GetNW2Entity("TrainEntity"),seat
    end
end

hook.Add("PlayerEnteredVehicle","MetrostroiPlayerTrain",function(ply,veh)
    ply.InMetrostroiTrain = IsValid(veh:GetNW2Entity("TrainEntity")) and veh:GetNW2Entity("TrainEntity")
end)
hook.Add("PlayerLeaveVehicle","MetrostroiPlayerTrain",function(ply,veh)
    ply.InMetrostroiTrain = false
end)


--------------------------------------------------------------------------------
-- Train count
--------------------------------------------------------------------------------
function Metrostroi.TrainCount(...)
    local classnames = {...}
    if #classnames == 1 then
        return #ents.FindByClass(classnames[1])
    end

    local N = 0
    for k,v in pairs(#classnames > 0 and classnames or Metrostroi.TrainClasses) do
        if not baseclass.Get(v).SubwayTrain then continue end
        N = N + #ents.FindByClass(v)
    end
    return N
end

function Metrostroi.TrainCountOnPlayer(ply ,...)
    local classnames = {...}
    local typ
    if type(classnames[1]) == "number" then
        typ = classnames[1]
        classnames = {}
    end
    if CPPI then
        local N = 0
        for k,v in pairs(#classnames > 0 and classnames or Metrostroi.TrainClasses) do
            if not baseclass.Get(v).SubwayTrain then continue end
            local ents = ents.FindByClass(v)
            for k2,v2 in pairs(ents) do
                if ply == v2:CPPIGetOwner() and (not typ or v2.SubwayTrain.WagType == typ) then
                    N = N + 1
                end
            end
        end
        return N
    end
    return 0
end

concommand.Add("metrostroi_train_count", function(ply, _, args)
    print("Trains on server: "..Metrostroi.TrainCount())
    if CPPI then
        local N = {}
        for k,v in pairs(Metrostroi.TrainClasses) do
            if  v == "gmod_subway_base" then continue end
            local ents = ents.FindByClass(v)
            for k2,v2 in pairs(ents) do
                N[v2:CPPIGetOwner() or "(disconnected)"] = (N[v2:CPPIGetOwner() or "(disconnected)"] or 0) + 1
            end
        end
        for k,v in pairs(N) do
            print(k,"Trains count: "..v)
        end
    end
end)




--------------------------------------------------------------------------------
-- Simple hack to get a driving schedule
--------------------------------------------------------------------------------
concommand.Add("metrostroi_schedule", function(ply, _, args)
    if not IsValid(ply) then return end
    local train = ply:GetTrain()
    local pos = Metrostroi.TrainPositions[train]
    --if pos and pos[1] then
        local line = tonumber(args[1])
        local path = tonumber(args[2]) or 1
        local starts = tonumber(args[3])
        local ends = tonumber(args[4])
        train.Schedule = Metrostroi.GenerateSchedule("Line"..line.."_Platform"..path,starts,ends)
        if train.Schedule then
            train:SetNW2Int("_schedule_id",train.Schedule.ScheduleID)
            train:SetNW2Int("_schedule_duration",train.Schedule.Duration)
            train:SetNW2Int("_schedule_interval",train.Schedule.Interval)
            train:SetNW2Int("_schedule_N",#train.Schedule)
            train:SetNW2Int("_schedule_path",path)
            for k,v in ipairs(train.Schedule) do
                train:SetNW2Int("_schedule_"..k.."_1",v[1])
                train:SetNW2Int("_schedule_"..k.."_2",v[2])
                train:SetNW2Int("_schedule_"..k.."_3",v[3])
                train:SetNW2Int("_schedule_"..k.."_4",v[4])
                train:SetNW2String("_schedule_"..k.."_5",Metrostroi.StationNames[v[1]] or v[1])
            end
        end
    --end
end)




--------------------------------------------------------------------------------
-- Failures related stuff
--------------------------------------------------------------------------------
concommand.Add("metrostroi_failures", function(ply, _, args)
    local i = 0
    for _,class in pairs(Metrostroi.TrainClasses) do
        local trains = ents.FindByClass(class)
        for _,train in pairs(trains) do
            timer.Simple(0.1+i*0.2,function()
                print("Failures for train "..train:EntIndex())
                train:TriggerInput("FailSimStatus",1)
            end)
            i = i + 1
        end
    end
end)

concommand.Add("metrostroi_fail", function(ply, _, args)
    local trainList = {}
    if not IsValid(ply) then
        for _,class in pairs(Metrostroi.TrainClasses) do
            local trains = ents.FindByClass(class)
            for _,train in pairs(trains) do
                table.insert(trainList,train)
            end
        end
    else
        local train = ply:GetTrain()
        if IsValid(train) then
            train:UpdateWagonList()
            for k,v in pairs(train.WagonList) do
                trainList[k] = v
            end
        end
    end

    local train = table.Random(trainList)
    if train then
        if IsValid(ply) then
            ply:PrintMessage(HUD_PRINTCONSOLE,"Generating random failure in your train!")
            print(tostring(ply).." generated random failure in train "..train:EntIndex())
        else
            print("Generating random failure in train "..train:EntIndex())
        end
        train:TriggerInput("FailSimFail",1)
    else
        if IsValid(ply) then
            ply:PrintMessage(HUD_PRINTCONSOLE,"You must be inside a train to generate a failure!")
        end
    end
end)

concommand.Add("metrostroi_fail_reset", function(ply, _, args)
    local trainList = {}
    if not IsValid(ply) then
        for _,class in pairs(Metrostroi.TrainClasses) do
            local trains = ents.FindByClass(class)
            for _,train in pairs(trains) do
                table.insert(trainList,train)
            end
        end
    else
        local train = ply:GetTrain()
        if IsValid(train) then
            train:UpdateWagonList()
            for k,v in pairs(train.WagonList) do
                trainList[k] = v
            end
        end
    end

    if #trainList > 0 then
        if IsValid(ply) then
            ply:PrintMessage(HUD_PRINTCONSOLE,"Reset all failures in your train!")
            print(tostring(ply).." reset all failures in train "..trainList[1]:EntIndex())
        else
            print("Reset all failures in train "..trainList[1]:EntIndex())
        end
        for _,v in pairs(trainList) do v:TriggerInput("FailSimReset") end
    else
        if IsValid(ply) then
            ply:PrintMessage(HUD_PRINTCONSOLE,"You must be inside a train to reset all failures!")
        end
    end
end)

concommand.Add("metrostroi_wire", function(ply, _, args)
    local trainList = {}
    if not IsValid(ply) then
        for _,class in pairs(Metrostroi.TrainClasses) do
            local trains = ents.FindByClass(class)
            for _,train in pairs(trains) do
                table.insert(trainList,train)
            end
        end
    else
        local train = ply:GetTrain()
        if IsValid(train) then
            --train:UpdateWagonList()
            for k,v in pairs(train.WagonList) do
                trainList[k] = v
            end
        end
    end

    local train = table.Random(trainList)
    if train then
        if IsValid(ply) then
            args[1] = tonumber(args[1])
            if not args[1] then ply:PrintMessage(HUD_PRINTCONSOLE,"1st argument must be a number") return end
            if args[2] and not tonumber(args[2]) then ply:PrintMessage(HUD_PRINTCONSOLE,"2nd argument must be a number") return end
            args[2] = tonumber(args[2])
            ply:PrintMessage(HUD_PRINTCONSOLE,"sets outside power in train wire"..args[1]..(args[2] and "(from "..args[2].." wire)" or "").."!")
            print(tostring(ply).." sets outside power in train "..args[1].." wire"..(args[2] and "(from "..args[2].." wire)" or "").." failure in train number "..train:GetWagonNumber())
        else
            print("sets outside power in train wire "..train:EntIndex())
        end
        --if train.WriteTrainWire then train:WriteTrainWire(args[1],1) end
        train.TrainWireOutside[args[1]] = 1
        train.TrainWireOutsideFrom[args[1]] = args[2]
        --if train.WriteTrainWire then train:WriteTrainWire(args[1],1) end
    else
        if IsValid(ply) then
            ply:PrintMessage(HUD_PRINTCONSOLE,"You must be inside a train!")
        end
    end
end)
concommand.Add("metrostroi_wire_reset", function(ply, _, args)
    local trainList = {}
    if not IsValid(ply) then
        for _,class in pairs(Metrostroi.TrainClasses) do
            local trains = ents.FindByClass(class)
            for _,train in pairs(trains) do
                table.insert(trainList,train)
            end
        end
    else
        local train = ply:GetTrain()
        if IsValid(train) then
            --train:UpdateWagonList()
            for k,v in pairs(train.WagonList) do
                trainList[k] = v
            end
        end
    end

    if #trainList > 0 then
        if IsValid(ply) then
            if args[1] and not tonumber(args[1]) then ply:PrintMessage(HUD_PRINTCONSOLE,"Argument must be a number") return end
            ply:PrintMessage(HUD_PRINTCONSOLE,"reset "..(args[1] and args[1].." " or "").."wire outside power in train!")
            print(tostring(ply).." reset "..(args[1] and args[1].." wire " or "").."outside power in train ")
        else
            print("Reset outside power in trains ")
        end	
        args[1] = tonumber(args[1])
        if args[1] then
            for _,v in pairs(trainList) do 
                v.TrainWireOutside[args[1]] = nil 
                v.TrainWireOutsideFrom[args[1]] = nil
            end
        else
            for _,v in pairs(trainList) do
                v.TrainWireOutside = {} 
                v.TrainWireOutsideFrom = {}
            end
        end
    else
        if IsValid(ply) then
            ply:PrintMessage(HUD_PRINTCONSOLE,"You must be inside a train!")
        end
    end
end)
concommand.Add("metrostroi_can", function(ply, _, args)
    if not IsValid(ply) or not IsValid(ply:GetVehicle()) then return end
    local train = ply:GetVehicle():GetNW2Entity("TrainEntity")
    if not IsValid(train) then return end
    if not args[4] then return end
    local system = args[1]
    local id = tonumber(args[2])
    local name = args[3]
    local value = args[4]
    if args[4] == "curtime" then value = CurTime() end
    if args[4] == "true" then value = true end
    if args[4] == "false" then value = false end
    if tonumber(args[4]) then value = tonumber(args[4]) end
    local srcid = tonumber(args[5])
    ply:PrintMessage(HUD_PRINTCONSOLE,"Hacking CAN!")
    print(Format("%s hack CAN(%s->%s:%s %s=%s)",ply,srcid,system,id,name,value))
    train:CANWrite("Hacker",srcid or train:GetWagonNumber(),system,id,name,value)
end)

--------------------------------------------------------------------------------
-- Electric consumption stats
--------------------------------------------------------------------------------
-- Load total kWh
timer.Create("Metrostroi_TotalkWhTimer",5.00,0,function()
    file.Write("metrostroi_data/total_kwh.txt",Metrostroi.TotalkWh or 0)
end)
Metrostroi.TotalkWh = Metrostroi.TotalkWh or tonumber(file.Read("metrostroi_data/total_kwh.txt") or "") or 0
Metrostroi.TotalRateWatts = Metrostroi.TotalRateWatts or 0
Metrostroi.Voltage = 750
Metrostroi.Voltages = Metrostroi.Voltages or {}
Metrostroi.Currents = Metrostroi.Currents or {}
Metrostroi.Current = 0
Metrostroi.PeopleOnRails = 0
Metrostroi.VoltageRestoreTimer = 0

local function consumeFromFeeder(inCurrent, inFeeder)
    if inFeeder then
        Metrostroi.Currents[inFeeder] = Metrostroi.Currents[inFeeder] + inCurrent*0.4
    else
        Metrostroi.Current = Metrostroi.Current + inCurrent*0.4
    end
end

local prevTime
hook.Add("Think", "Metrostroi_ElectricConsumptionThink", function()
    -- Change in time
    prevTime = prevTime or CurTime()
    local deltaTime = (CurTime() - prevTime)
    prevTime = CurTime()

    -- Calculate total rate
    Metrostroi.TotalRateWatts = 0
    Metrostroi.Current = 0
    for k,v in pairs(Metrostroi.Currents) do Metrostroi.Currents[k] = 0 end
    local bogeys = ents.FindByClass("gmod_train_bogey")
    for _,bogey in pairs(bogeys) do
        if bogey.Feeder then
            Metrostroi.Currents[bogey.Feeder] = Metrostroi.Currents[bogey.Feeder] + bogey.DropByPeople
        else
            Metrostroi.Current = Metrostroi.Current + bogey.DropByPeople
        end
    end
    for _,class in pairs(Metrostroi.TrainClasses) do
        local trains = ents.FindByClass(class)
        for _,train in pairs(trains) do
            if train.Electric then
                if train.Electric.EnergyChange then Metrostroi.TotalRateWatts = Metrostroi.TotalRateWatts + math.max(0, train.Electric.EnergyChange) end
                local current = math.max(0, train.Electric.Itotal or 0) -  math.max(0, train.Electric.Iexit or 0)

                local fB = IsValid(train.FrontBogey) and train.FrontBogey
                local rB = IsValid(train.RearBogey) and train.RearBogey
                if fB and (not fB.ContactStates or (not fB.ContactStates[1] and not fB.ContactStates[2])) then fB = nil end -- Don't have contact with TR
                if rB and (not rB.ContactStates or (not rB.ContactStates[1] and not rB.ContactStates[2])) then rB = nil end -- Don't have contact with TR

                local fBfeeder = fB and fB.Feeder
                local rBfeeder = rB and rB.Feeder

                if fBfeeder then
                    if not rBfeeder or fBfeeder == rBfeeder then
                        consumeFromFeeder(current, fBfeeder) -- Feeders are same
                    else
                        consumeFromFeeder(current * 0.5, fBfeeder) -- Feeders are different
                    end
                end

                if rBfeeder then
                    if not fBfeeder then
                        consumeFromFeeder(current, rBfeeder) -- Feeders are same
                    elseif fBfeeder ~= rBfeeder  then
                        consumeFromFeeder(current * 0.5, rBfeeder) -- Feeders are different
                    end
                end
                if not rBfeeder and not fBfeeder then consumeFromFeeder(current) end
            end
        end
    end
    -- Ignore invalid values
    if Metrostroi.TotalRateWatts > 1e8 then Metrostroi.TotalRateWatts = 0 end
    if Metrostroi.TotalRateWatts > 0 then
        -- Calculate total kWh
        Metrostroi.TotalkWh = Metrostroi.TotalkWh + (Metrostroi.TotalRateWatts/(3.6e6))*deltaTime
    end
    -- Calculate total resistance of people on rails and current flowing through
    --local Rperson = 0.613
    --local Iperson = Metrostroi.Voltage / (Rperson/(Metrostroi.PeopleOnRails + 1e-9))
    --Metrostroi.Current = Metrostroi.Current + Iperson

    -- Check if exceeded global maximum current
    if Metrostroi.Current > GetConVar("metrostroi_current_limit"):GetInt() then
        Metrostroi.VoltageRestoreTimer = CurTime() + 7.0
        print(Format("[!] Power feed protection tripped: current peaked at %.1f A",Metrostroi.Current))
    end

    local voltage = math.max(0,GetConVar("metrostroi_voltage"):GetInt())

    -- Calculate new voltage
    local Rfeed = 0.03 --25
    Metrostroi.Voltage = voltage - Metrostroi.Current*Rfeed
    if CurTime() < Metrostroi.VoltageRestoreTimer then Metrostroi.Voltage = 0 end
    for i in pairs(Metrostroi.Voltages) do
        Metrostroi.Voltages[i] = math.max(0,voltage - Metrostroi.Currents[i]*Rfeed)
    end
    --print(Format("%5.1f v %.0f A",Metrostroi.Voltage,Metrostroi.Current))
end)

concommand.Add("metrostroi_electric", function(ply, _, args) -- (%.2f$) Metrostroi.GetEnergyCost(Metrostroi.TotalkWh),
    local m = Format("[%25s] %010.3f kWh, %.3f kW (%5.1f v, %4.0f A)","<total>",
        Metrostroi.TotalkWh,Metrostroi.TotalRateWatts*1e-3,
        Metrostroi.Voltage,Metrostroi.Current)
    if IsValid(ply)
    then ply:PrintMessage(HUD_PRINTCONSOLE,m)
    else print(m)
    end

    if CPPI then
        local U = {}
        local D = {}
        for _,class in pairs(Metrostroi.TrainClasses) do
            local trains = ents.FindByClass(class)
            for _,train in pairs(trains) do
                local owner = "(disconnected)"
                if train:CPPIGetOwner() then
                    owner = train:CPPIGetOwner():GetName()
                end
                if train.Electric then
                    U[owner] = (U[owner] or 0) + train.Electric.ElectricEnergyUsed
                    D[owner] = (D[owner] or 0) + train.Electric.ElectricEnergyDissipated
                end
            end
        end
        for player,_ in pairs(U) do --, n=%.0f%%
            --local m = Format("[%20s] %08.1f KWh (lost %08.1f KWh)",player,U[player]/(3.6e6),D[player]/(3.6e6)) --,100*D[player]/U[player]) --,D[player])
            local m = Format("[%25s] %010.3f kWh (%.2f$)",player,U[player]/(3.6e6),Metrostroi.GetEnergyCost(U[player]/(3.6e6)))
            if IsValid(ply)
            then ply:PrintMessage(HUD_PRINTCONSOLE,m)
            else print(m)
            end
        end
    end
end)

timer.Create("Metrostroi_ElectricConsumptionTimer",0.5,0,function()
    if CPPI then
        local U = {}
        local D = {}
        for _,class in pairs(Metrostroi.TrainClasses) do
            local trains = ents.FindByClass(class)
            for _,train in pairs(trains) do
                local owner = train:CPPIGetOwner()
                if owner and (train.Electric) then
                    U[owner] = (U[owner] or 0) + train.Electric.ElectricEnergyUsed
                    D[owner] = (D[owner] or 0) + train.Electric.ElectricEnergyDissipated
                end
            end
        end
        for player,_ in pairs(U) do
            if IsValid(player) then
                player:SetDeaths(10*U[player]/(3.6e6))
                player.MUsedEnergy = (player.MUsedEnergy or 0) + 10*U[player]/(3.6e6)
            end
        end
    end
end)

local function murder(v)
    local positions = Metrostroi.GetPositionOnTrack(v:GetPos())
    for k2,v2 in pairs(positions) do
        local y,z = v2.y,v2.z
        y = math.abs(y)

        local y1 = 0.91-0.10
        local y2 = 1.78 ---0.50
        if (y > y1) and (y < y2) and (z < -1.70) and (z > -1.72) and (Metrostroi.Voltage > 40) then
            local pos = v:GetPos()

            util.BlastDamage(v,v,pos,64,3.0*Metrostroi.Voltage)

            local effectdata = EffectData()
            effectdata:SetOrigin(pos + Vector(0,0,-16+math.random()*(40+0)))
            util.Effect("cball_explode",effectdata,true,true)

            sound.Play("ambient/energy/zap"..math.random(1,3)..".wav",pos,75,math.random(100,150),1.0)
            Metrostroi.PeopleOnRails = Metrostroi.PeopleOnRails + 1

            --if math.random() > 0.85 then
                --Metrostroi.VoltageRestoreTimer = CurTime() + 7.0
                --print("[!] Power feed protection tripped: "..(tostring(v) or "").." died on rails")
            --end
        end
    end
end
--[[
timer.Create("Metrostroi_PlayerKillTimer",0.1,0,function()
    if true then return end
    Metrostroi.PeopleOnRails = 0
    for k,v in pairs(player.GetAll()) do
        murder(v)
    end
    for k,v in pairs(ents.FindByClass("npc_*")) do
        murder(v)
    end
end)
]]
timer.Remove("Metrostroi_PlayerKillTimer")


--------------------------------------------------------------------------------
-- Does current map have any sort of metrostroi support
--------------------------------------------------------------------------------
function Metrostroi.MapHasFullSupport(typ)
    if not typ then
        return (#Metrostroi.Paths > 0)
    elseif typ=="ars" then
        return next(Metrostroi.SignalEntitiesByName)
    elseif typ=="auto" then
        return Metrostroi.HaveAuto
    elseif typ=="sbpp" then
        return Metrostroi.HaveSBPP
    elseif typ=="pa" then
        return next(Metrostroi.PAMConfTest)
    end
end

concommand.Add("metrostroi_insert_signs", function(ply,_,args)
    if IsValid(ply) then error("Metrostroi: This command can be run only from server console!") end
    local MAP_NAME = game.GetMap() --"gm_mus_loopline_a3"
    local MAP_VERSION = args and args[1] or ""

    local commands = {Format("session_begin %s %s",MAP_NAME,MAP_VERSION)}

    local function createSign(pos,ang,model)
        table.insert(commands,Format("entity_create prop_static %s",pos))
        table.insert(commands,Format("entity_set_keyvalue prop_static %s \"angles\" \"%s\"",pos,ang))--table.insert(commands,Format("entity_rotate_incremental prop_static %s %s",pos,ang))
        table.insert(commands,Format("entity_set_keyvalue prop_static %s \"model\" \"%s\"",pos,model))
    end

    for k,v in pairs(ents.FindByClass("gmod_track_signs")) do
        local data = v.SignModels[v.SignType-1]
        local left = v.Left
        local offset = Vector(0,v.YOffset,v.ZOffset)
        local model = data.model
        if left and not data.noleft then
            if model:find("_r.mdl") then
                model = model:Replace("_r.mdl","_l.mdl")
            else
                model = model:Replace("_l.mdl","_r.mdl")
            end
        end
        local RAND = math.random(-10,10)
        local pos = data.pos + offset
        local ang = data.angles
        if not data.noauto then pos = pos+Vector(0,0,RAND/5); ang = ang+Angle(0,0,RAND) end
        if left then pos = pos*Vector(1,-1,1) end
        if left and data.rotate then ang = ang-Angle(0,180,0) end

        createSign(v:LocalToWorld(pos),v:LocalToWorldAngles(ang),model)
    end

    table.insert(commands,"session_end")

    for k,v in pairs(commands) do
        local result = hammer.SendCommand(v)
        if result ~= "ok" then
            hammer.SendCommand("session_end")
            error(Format("Error \"%s\" on command %s(%d)",result,v,k))
        end
    end
end)
SafeRemoveEntity(Metrostroi.RTCamera)
function Metrostroi.GetCam()
    if not IsValid(Metrostroi.RTCamera) then
        Metrostroi.RTCamera = ents.Create( "point_camera" )
        Metrostroi.RTCamera:SetKeyValue( "GlobalOverride", 1 )
        Metrostroi.RTCamera:SetKeyValue( "fogEnable", 1 )
        Metrostroi.RTCamera:SetKeyValue( "fogStart", 1 )
        Metrostroi.RTCamera:SetKeyValue( "fogEnd", 4096  )
        Metrostroi.RTCamera:SetKeyValue( "fogColor", "0 0 0 127"     )
        Metrostroi.RTCamera:SetPos(Vector(0,0,-2^16))
        Metrostroi.RTCamera:SetNoDraw(true)
        Metrostroi.RTCamera:Activate()
        Metrostroi.RTCamera:Spawn()
        Metrostroi.RTCamera:Fire( "SetOff", "", 0.0 )
    end
    return Metrostroi.RTCamera
end
util.AddNetworkString("metrostroi_cam_update")
local function updateCam()
    timer.Simple(0,function()
        local cam = Metrostroi.GetCam()
        net.Start("metrostroi_cam_update")
            net.WriteUInt(cam:EntIndex(),16)
        net.Broadcast()
    end)
end
net.Receive("metrostroi_cam_update",updateCam)
updateCam()


function Metrostroi.FindNextStation(src,stationsPath,stations)
    -- Determine direction of travel
    --assert(src.path == dest.path)
    --local direction = src.x < dest.x
    print("start")

    local markersForNode = {}
    local sensorsForNode = {}
    local entities = ents.FindByClass("gmod_track_pa_marker")
    for k,v in pairs(entities) do
        if v.TrackPosition then
            local node = v.TrackPosition.node1
            if not markersForNode[node] then markersForNode[node] = {} end
            table.insert(markersForNode[node],v)
        end
    end

    local entities = ents.FindByClass("gmod_track_autodrive_plate")
    for k,v in pairs(entities) do
        --print(v.PlateType)
        if v.PlateType ~= METROSTROI_LSENSOR then continue end
        local results = Metrostroi.GetPositionOnTrack(v:GetPos(),v:GetAngles())
        --[[ for k,v in pairs(results) do
            print(k,v.x,v.node2.x)
        end--]]
        local pos = results[1]
        if pos then -- FIXME make it select proper path
            sensorsForNode[pos.node1] = sensorsForNode[pos.node1] or {}
            table.insert(sensorsForNode[pos.node1],v)

            -- A signal belongs only to a single track
            sensorsForNode[v] = pos
        end
    end
    -- Accumulate travel time
    local iter = 0
    local function scan(node,stations,path,trace,dist,branches)
        while node do
            local nextnode = path and node.next or not path and node.prev
            assert(iter < 1000000, "OH SHI~")
            iter = iter + 1
            if nextnode then
                local heightDist = (nextnode.pos.z-node.pos.z)*0.01905
                local slope = heightDist/node.length*1000
                if math.abs(slope)>2 then
                    if not trace.slopeCurrent then
                        trace.slopeCurrent = node.id
                        trace.slopeLength = node.length
                        trace.slope = {}
                    else
                        trace.slopeLength = trace.slopeLength+node.length
                    end
                    --print(dist,slope)
                    table.insert(trace.slope,{dist,slope})
                elseif trace.slopeCurrent then
                    local slm,slmx,slc = 0,0,0
                    --print(#trace.slope,trace.slopeLength)
                    local restbl = {}
                    for _,v in pairs(trace.slope) do
                        local sl = math.floor((v[2]+2.5)/5)*5
                        if slm~=sl then
                            local slmax = sl>0 and math.max(sl,slm) or math.min(sl,slm)
                            if (slc>2 or math.abs(slm-sl)>20) and (not restbl[#restbl] or restbl[#restbl][1] ~= slmax) then
                                table.insert(restbl,{slmax,slmx})
                                slmx = v[1]
                            end
                            if slmx==0 then slmx = v[1] end
                            slm = sl
                            slc = 0
                        else
                            slc = slc + 1
                        end
                        --print(k,v,)
                        --slc = slc+v[1]
                    end
                    if #restbl==0 and slm~=0  and math.abs(dist-slmx)>30 then table.insert(restbl,{slm,slmx,slc}) end
                    if #restbl~=0 then
                        table.insert(restbl,{0,dist})
                        for k,v in pairs(restbl) do
                            --print(k,v[1],v[2],v[3])
                            table.insert(trace.slopes,v)
                        end
                    end
                    --print("E---",node.pos)
                    trace.slopeCurrent = nil
                end
            end

            local targetStation = tonumber(stations[1])
            --local stationT = Metrostroi.Stations[tonumber(id)]
            if markersForNode[node] then
                for i,marker in ipairs(markersForNode[node]) do
                    if marker.PAType == 1 then
                        print("MAKR",marker.TrackX,marker.TrackPosition.x,marker.PAStationID,targetStation,marker.PAStationPath,stationsPath)
                        if marker.PAStationID ~= targetStation or tonumber(marker.PAStationPath) ~= stationsPath then return end
                        table.remove(stations,1)
                        --if marker.PAStationCorrection then print(targetStation) end
                        local distance = dist+(marker.TrackPosition.x-node.x)-(marker.PAStationCorrection or 0)
                        local lastSens,nearSens
                        for s=0,3 do
                            if not trace.sensors[#trace.sensors-s] or distance-trace.sensors[#trace.sensors-s] > 150 then break end
                            lastSens = #trace.sensors-s
                        end
                        table.insert(trace.stations,{
                            id=targetStation,
                            path=stationsPath,
                            pos=distance,
                            isHorlift = marker.PAStationHorlift,
                            hasSwitches = marker.PAStationHasSwtiches,
                            rightDoors = marker.PAStationRightDoors,
                            name = marker.PAStationName,
                            isLast = marker.PALastStation,
                            isInWrong = marker.PAWrongPath,
                            name_last = marker.PALastStationName,
                            dist_last_start = marker.PADeadlockStart and distance+marker.PADeadlockStart,
                            dist_last_end = marker.PADeadlockEnd and distance+marker.PADeadlockEnd,
                            linkedSensor = lastSens,
                        })
                        --print("MAKR GOOD",marker.TrackX,marker.TrackPosition.x,targetStation)
                        break
                    end
                end
            end
            if Metrostroi.SignalEntitiesForNode[node] then
                for k,signal in pairs(Metrostroi.SignalEntitiesForNode[node]) do
                    if signal.TrackDir ~= path then continue end
                    table.insert(trace.signals,{signal.Name,dist+(signal.TrackX-node.x)--[[ signal.TrackPosition.x--]] })
                end
            end
            if sensorsForNode[node] then
                local sensor = sensorsForNode[node][1]
                local x = sensorsForNode[sensor].x
                --print("SENS",node,dist,dist+(x-node.x))
                table.insert(trace.sensors,dist+(x-node.x)--[[ sensor.TrackPosition.x--]] )
            end
            dist = dist+node.length
            if node.branches then
                for k,v in pairs(node.branches) do
                    if branches[v[2]] or v[2].path == src.path then continue end
                    branches[v[2]] = true
                    local result = scan(v[2],table.Copy(stations),true,table.Copy(trace),dist,branches) or scan(v[2],table.Copy(stations),false,table.Copy(trace),dist,branches)
                    if result and #result[3] == 0 then return result end
                end
            end
            --[=[if node.branches and not branches[node.branches[1]] and node.branches[1][2].path ~= src.path then
                branches[node.branches[1]] = true
                local result = scan(node,table.Copy(stations),true,table.Copy(trace),dist,branches) or scan(node,table.Copy(stations),false,table.Copy(trace),dist,branches)
                if result and #stations == 0 then return result end
            end
            if node.branches and not node.branches[2] and branches[node.branches[2]] and node.branches[2][2].path ~= src.path then
                branches[node.branches[2]] = true
                local result = scan(node,table.Copy(stations),true,table.Copy(trace),dist,branches) or scan(node,table.Copy(stations),false,table.Copy(trace),dist,branches)
                if result and #stations == 0 then return result end
            end]=]
            node = nextnode
            if not node then break end
        end
        if #stations == 0 then print(debug.traceback()) end
        return #stations == 0 and {trace,dist,stations}
    end

    return scan(src,stations,true,{signals={},stations={},sensors={},slopes={}},0,{}) or scan(src,stations,false,{signals={},stations={},sensors={},slopes={}},0,{})
end
concommand.Add("metrostroi_pam_genconfig", function(ply, _, args)
    if not IsValid(ply) or not ply:IsAdmin() then return end

    if args[1] == "clear" then
        ply:PrintMessage(HUD_PRINTCONSOLE,"Cleared!")
        Metrostroi.PAMConfTest = {}
        return
    end

    local line = tonumber(table.remove(args,1) or false)
    local path = tonumber(table.remove(args,1) or false)
    if (not line or not path) or #args == 0 then
        ply:PrintMessage(HUD_PRINTCONSOLE,"Bad metrostroi_pam_genconfig use.\nmetrostroi_pam_genconfig line path station1 ... stationN-1 stationN")
        return
    end

    local badFind = false
    for k,id in pairs(args) do
        id = tonumber(id)
        if not id--[[  or not Metrostroi.Stations[id]--]]  then
            badFind = id
            break
        end
    end

    if badFind then
        ply:PrintMessage(HUD_PRINTCONSOLE,Format("Check station id %s!",badFind))
        return
    end

    -- Print interesting information
    local results = Metrostroi.GetPositionOnTrack(ply:GetPos(),ply:GetAimVector():Angle())
    for k,v in pairs(results) do
        --ply:PrintMessage(HUD_PRINTCONSOLE,Format("\t[%d] Path #%d, ID #%d: (%.2f x %.2f x %.2f) m  Facing %s",k,v.path.id,v.node1.id,v.x,v.y,v.z,v.forward and "forward" or "v.node1"))
        local result = Metrostroi.FindNextStation(v.node1,path,args)
        if not result then
            ply:PrintMessage(HUD_PRINTCONSOLE,Format("Config not generated! Can't find all stations"))
            return
        end
        PrintTable(result)
        if not Metrostroi.PAMConfTest then
            Metrostroi.PAMConfTest = {}
        end
        if not Metrostroi.PAMConfTest[line] then
            Metrostroi.PAMConfTest[line] = {}
        end
        --if not Metrostroi.PAMConfTest[line][path] then
            Metrostroi.PAMConfTest[line][path] = result
            ply:PrintMessage(HUD_PRINTCONSOLE,"Generated!")
        --end
        Metrostroi.PARebuildStations()
        --print(distance)
    end
end)
function Metrostroi.PARebuildStations()
    Metrostroi.PAMStations = {}
    Metrostroi.LineCount = 1
    for lineID,line in pairs(Metrostroi.PAMConfTest) do
        if type(lineID) ~= "number" then continue end
        Metrostroi.LineCount = math.max(Metrostroi.LineCount)
        for _,path in ipairs(line) do
            for _,station in ipairs(path[1].stations) do
                if not station.id then continue end
                if not Metrostroi.PAMStations[lineID] then Metrostroi.PAMStations[lineID] = {} end
                if not Metrostroi.PAMStations[lineID][station.id] then
                    Metrostroi.PAMStations[lineID][station.id] =table.insert(Metrostroi.PAMStations[lineID],station)
                end
            end
        end
    end
end

concommand.Add("metrostroi_pam_add_station", function(ply, _, args)
    if not IsValid(ply) or not ply:IsAdmin() then return end

    local line = tonumber(table.remove(args,1) or false)
    local path = tonumber(table.remove(args,1) or false)
    local station = tonumber(table.remove(args,1) or false)
    local dist = tonumber(table.remove(args,1) or false)
    if (not line or not path or not station) then
        ply:PrintMessage(HUD_PRINTCONSOLE,"Bad metrostroi_pam_add_station use.\nmetrostroi_pam_add_station line path station dist")
        return
    end
    if not Metrostroi.PAMConfTest[line][path] then
        ply:PrintMessage(HUD_PRINTCONSOLE,"Generate config first!")
        return
    end
    local PA
    if not dist then
        local train = ply:GetTrain()
        if IsValid(train) and train.PAM and train.PAM.Distance then
            dist = train.PAM.Distance
            PA = train.PAM
        end
    end
    if not dist then
        ply:PrintMessage(HUD_PRINTCONSOLE,"Bad metrostroi_pam_add_station use.\nCan't get dist, because it's not entered and not found train with PAM")
        return
    end
    local tbl = Metrostroi.PAMConfTest[line][path][1].stations
    local badFind = false
    for k,id in ipairs(tbl) do
        if id.id == station then
            if math.abs(id.pos-dist)>20 then
                ply:PrintMessage(HUD_PRINTCONSOLE,Format("Too big delta, pos %.1f station %d station pos %.1f delta %.1f",dist,station,id.pos,id.pos-dist))
                return
            end
            ply:PrintMessage(HUD_PRINTCONSOLE,Format("Set pos %.1f to station %d, prev dist %.1f",dist,station,id.pos))
            id.pos = dist
            if PA then
                PA.StationTable = PA:FindStation(PA.Line,PA.StationTable.path,PA.StationTable.id)
            end
            table.sort(tbl, function(a,b) return a.pos < b.pos end)
            return
        end
    end
    --[[ table.insert(Metrostroi.PAMConfTest[line][path][1].stations,{station,dist})
    table.sort(tbl, function(a,b) print(a,b,a[2],b[2]) return a[2] < b[2] end)
    Metrostroi.PARebuildStations()
    ply:PrintMessage(HUD_PRINTCONSOLE,"Setted!")--]]
end)

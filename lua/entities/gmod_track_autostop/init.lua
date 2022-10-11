AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:LinkToSignal()
    --есть таблица Metrostroi.SignalEntitiesByName[self.SignalLink], но она инициилизируется для меня слишком поздно (при загрузке из файла)
    self.Sig = nil
    if self.SignalLink then
        for k,v in pairs(ents.FindByClass("gmod_track_signal"))do
            if not IsValid(v) then continue end
            if v.Name == self.SignalLink then self.Sig = v break end
        end
    end
end

function ENT:Initialize()
    self.MaxSpeed = tonumber(self.MaxSpeed)
    if not self.SignalLink or self.SignalLink == "" then self.SignalLink = nil end
    self:LinkToSignal()
end

local et = {}
timer.Create("Metrostroi Autostop think",0.5,0,function()
    for _,ent in pairs(ents.FindByClass("gmod_track_autostop"))do
        if not IsValid(ent) then continue end
        ent:SetNW2Bool("Autostop", not (IsValid(ent.Sig) and not ent.Sig.Red))
    end
    
    --тут определение следующего и предыдущего автостопа по ноуду для каждого паравоза. и вызов Train.Pneumatic:TriggerInput("Autostop",nomsg and 0 or 1) при проезде
    for train,pos in pairs(Metrostroi.TrainPositions or et)do
        pos = pos[1]
        if not IsValid(train) or not train.SubwayTrain or not train.SubwayTrain.ALS or not train.SubwayTrain.ALS.HaveAutostop or not pos or Metrostroi.TrainDirections[train] == nil or not Metrostroi.AutostopsForNode or not Metrostroi.AutostopsForNode[pos.node1] or not Metrostroi.AutostopsForNode[pos.node1][Metrostroi.TrainDirections[train]] then continue end
        --сделано таблицами, потому что если сохранять только ближний автостоп, при близкостоящих автостопах и их быстром проезде нe сработает ни один
        local forws,backs = {}, {}
        for i = 0,1 do
            local res,minlen
            for _,autostop in pairs(Metrostroi.AutostopsForNode[pos.node1][Metrostroi.TrainDirections[train]][i==1] or et)do
                if not IsValid(autostop) then continue end
                if i == 1 then
                    if not (autostop.TrackDir and autostop.TrackX < pos.x or not autostop.TrackDir and autostop.TrackX > pos.x) then forws[autostop] = true end
                else
                    if not (autostop.TrackDir and autostop.TrackX > pos.x or not autostop.TrackDir and autostop.TrackX < pos.x) then backs[autostop] = true end
                end
            end
        end

        for backautostop in pairs(backs)do
            if train.AutostopsForw and train.AutostopsForw[backautostop] and backautostop:GetNW2Bool("Autostop") and (not backautostop.MaxSpeed or backautostop.MaxSpeed < train.Speed) then
                local nomsg = hook.Run("MetrostroiPassedAutostop",train,backautostop)
                train.Pneumatic:TriggerInput("Autostop",nomsg and 0 or 1)
            end
        end
        train.AutostopsForw = forws
        -- train.AutostopsBack = backs
        -- print(forw,back)
    end
end)

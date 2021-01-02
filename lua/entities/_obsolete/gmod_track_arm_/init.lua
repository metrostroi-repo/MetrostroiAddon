AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_combine/breendesk.mdl")
    self.BaseClass.Initialize(self)
    self.DriverSeat = self:CreateSeat("driver", Vector(-40, 0, 0), Angle(0, 0, 0), "models//nova/chair_office02.mdl")
    self.CursorX = 0
    self.CursorY = 0
    self:CursorMove(0, 0)
    self.Station = 0
end

hook.Add("AcceptInput", "metrostroi_arm_trigger_check", function(ent, inputName, activator, called, data)
    if inputName == "ARMStartTouch" then
        called.ARMTriggered = true
        print(called, called:GetName(), activator, "Enable")
    end

    if inputName == "ARMEndTouch" then
        called.ARMTriggered = false
        print(called, called:GetName(), activator, "Disable")
    end
end)


local function GetOccupation(tbl)
    for sID,signame in ipairs(tbl) do
        if signame[1] == "@" then
            local trigger = Metrostroi.ARMGet(signame:sub(2,-1), "trigger")
            if not trigger or trigger.ARMTriggered then
                return true
            end
        elseif signame ~= "" then
            local signal = Metrostroi.ARMGet(signame, "signal")
            if not signal or signal.OccupiedBy and signal.OccupiedBy ~= signal then
                return true
            end
        end
    end
    return false
end

function ENT:Think()
    local armTbl = Metrostroi.ARMTable
    local armConf = Metrostroi.ARMConfigGenerated
    local station = armConf[self.Station]
    local armTblStation = armTbl[self.Station]
    if not station then return end
    if not armTblStation or (IsValid(armTblStation.Controller) and armTblStation.Controller ~= self) then return end
    armTblStation.Controller = self
    for buttonID,button in ipairs(station.buttons) do
        --print(button,button.selected)
        Metrostroi.ARMSync(self.Station, 1000+buttonID, "buttonPressable",button.pressable)
        Metrostroi.ARMSync(self.Station, 1000+buttonID, "buttonSelected",button.selected)
    end
    for segmID, segm in ipairs(station) do
        if type(segm) == "table" then
            if segm.occup then
                Metrostroi.ARMSync(self.Station, segmID, "occup", GetOccupation(segm.occup) or segm.occupAlt and GetOccupation(segm.occupAlt))
            end

            if segm.occup2 then
                Metrostroi.ARMSync(self.Station, segmID, "occup2", GetOccupation(segm.occup2))
            end
            Metrostroi.ARMSync(self.Station, segmID, "route", segm.route and true)


            if segm.switch then
                local switch = Metrostroi.ARMGet(segm.switch, "switch")
                local main = switch and switch.MainTrack and not switch.AlternateTrack
                local alt = switch and not switch.MainTrack and switch.AlternateTrack
                Metrostroi.ARMSync(self.Station, segmID, "switch_m", main)
                Metrostroi.ARMSync(self.Station, segmID, "switch_a", alt)
                Metrostroi.ARMSync(self.Station, segmID, "switch_na", not main and not alt)
            end
            if segm.signal1 then
                local signal = Metrostroi.ARMGet(segm.signal1.name, "signal")
                local colors = signal and signal.Colors
                if segm.signal1.type > 1 then Metrostroi.ARMSync(self.Station, segmID, "signal1I", signal and signal.InvationSignal) end
                if segm.signal1.type > 2 then
                    local Y = #colors:gsub("[^yY]","") > 1
                    if Y then colors = colors:SetChar(colors:find("[yY]"),"") end
                    Metrostroi.ARMSync(self.Station, segmID, "signal1Y", Y)
                end
                Metrostroi.ARMSync(self.Station, segmID, "signal1", colors)
            end
            if segm.signal2 then
                local signal = Metrostroi.ARMGet(segm.signal2.name, "signal")
                local colors = signal and signal.Colors
                if segm.signal2.type > 1 then Metrostroi.ARMSync(self.Station, segmID, "signal2I", signal and signal.InvationSignal) end
                if segm.signal2.type > 2 then
                    local Y = #colors:gsub("[^yY]","") > 1
                    if Y then colors = colors:SetChar(colors:find("[yY]"),"") end
                    Metrostroi.ARMSync(self.Station, segmID, "signal2Y", Y)
                end
                Metrostroi.ARMSync(self.Station, segmID, "signal2", colors)
            end
        end
    end

    self:NextThink(CurTime() + 0.5)

    return true
end

function ENT:OnRemove()
end

function ENT:CursorMove(sys, dX, dY)
    self.CursorX = sys == "" and math.Clamp(self.CursorX + dX * 200, 0, 800) or dX
    self.CursorY = sys == "" and math.Clamp(self.CursorY + dY * 200, 0, 600) or dY
    self:SetNW2Int("CursorX", math.floor(self.CursorX))
    self:SetNW2Int("CursorY", math.floor(self.CursorY))
end

function ENT:PanelTouch(state, x, y)
    for i, v in ipairs(Metrostroi.ARMConfig) do
        if math.InRangeXYR(self.CursorX, self.CursorY, 20 + (i - 1) * 30, 20, 30, 20) then
            self.Station = i
            self:SetNW2Int("ARM:Station", i)
        end
    end
    if not state then return end
    local RouteChoosing = self.RouteChoosing
    self.RouteChoosing = nil
    if RouteChoosing then
        print("DISABLE")
        for k,v in pairs(RouteChoosing.routes) do
            if v[1].button then
                v[1].button.selected = false
            elseif v[1].isbutton then
                v[1].selected = false
            end
        end
    end
    local confGenStation = Metrostroi.ARMConfigGenerated[self.Station]
    for k,button in pairs(confGenStation.buttons) do
        local sx,sy = 100+button.x*36,100+button.y*70
        if button.type == "r" then
            local sw,sh = 15,25
            local xa,ya = 3,12
            local x,y = sx+xa,sy+ya
            if RouteChoosing then
                if math.InRangeXYR(self.CursorX, self.CursorY, x,y,sw,sh) then
                    for k,v in ipairs(RouteChoosing.routes) do
                        if v[1].button and button == v[1].button or v[1].isbutton and button==v[1] then
                            Metrostroi.CentralisationPrepareRoute(self.Station,v)
                        end
                    end
                end
            elseif not self.RouteChoosing and button.pressable then
                if math.InRangeXYR(self.CursorX, self.CursorY, x,y,sw,sh) then
                    self.RouteChoosing = button
                    for k,v in ipairs(button.routes) do
                        print(v[1],v[1].name,v[1].button)
                        if v[1].button then
                            v[1].button.selected = true
                        elseif v[1].isbutton then
                            v[1].selected = true
                            print(2)
                        end
                    end
                end
            end
        end
    end
end
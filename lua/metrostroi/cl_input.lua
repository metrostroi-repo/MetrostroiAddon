local C_DrawDebug           = GetConVar("metrostroi_drawdebug")
local C_DisableHUD          = GetConVar("metrostroi_disablehud")
local C_DisableHoverText    = GetConVar("metrostroi_disablehovertext")
local C_DisableHoverTextP   = GetConVar("metrostroi_disablehovertextpos")
local C_TooltipDelay        = GetConVar("metrostroi_tooltip_delay")
local C_CrosshairDelay      = GetConVar("metrostroi_crosshair_delay")

--------------------------------------------------------------------------------
-- Buttons/panel clicking
--------------------------------------------------------------------------------
--Thanks old gmod wiki!
--[[
Converts from world coordinates to Draw3D2D screen coordinates.
vWorldPos is a vector in the world nearby a Draw3D2D screen.
vPos is the position you gave Start3D2D. The screen is drawn from this point in the world.
scale is a number you also gave to Start3D2D.
aRot is the angles you gave Start3D2D. The screen is drawn rotated according to these angles.
]]--

local function WorldToScreen(vWorldPos, vPos, vScale, aRot)
    vWorldPos = vWorldPos - vPos
    vWorldPos:Rotate(Angle(0, -aRot.y, 0))
    vWorldPos:Rotate(Angle(-aRot.p, 0, 0))
    vWorldPos:Rotate(Angle(0, 0, -aRot.r))

    return vWorldPos.x / vScale, (-vWorldPos.y) / vScale
end

-- Calculates line-plane intersect location
local function LinePlaneIntersect(PlanePos,PlaneNormal,LinePos,LineDir)
    local dot = LineDir:Dot(PlaneNormal)
    local fac = LinePos-PlanePos
    local dis = -PlaneNormal:Dot(fac) / dot
    return LineDir * dis + LinePos
end

function Metrostroi.FindAimButton(train,panel)
    if panel == nil then
        local panelDist = 1e9
        for kp,pan in pairs(train.ButtonMap) do
            if not train:ShouldDrawPanel(kp) then continue end
            --If player is looking at this panel
            if pan.aimedAt and (pan.buttons or pan.sensor or pan.mouse) and pan.aimedAt < panelDist then
                panel = pan
                panelDist = pan.aimedAt
            end
        end
    end
    if not panel then return false end
    if panel.aimX and panel.aimY and (panel.sensor or panel.mouse) and math.InRangeXY(panel.aimX,panel.aimY,0,0,panel.width,panel.height) then return false,panel.aimX,panel.aimY,panel.system end
    if not panel.buttons then return false end

    local buttonTarget = false
    for _,button in pairs(panel.buttons) do
        if (train.Hidden[button.PropName] or train.Hidden.button[button.PropName]) and (not train.ClientProps[button.PropName] or not train.ClientProps[button.PropName].config or not train.ClientProps[button.PropName].config.staylabel) then continue end
        if (train.Hidden[button.ID] or train.Hidden.button[button.ID])  and (not train.ClientProps[button.ID] or not train.ClientProps[button.ID].config or not train.ClientProps[button.ID].config.staylabel) then continue end
        if button.w and button.h then
            if  panel.aimX >= button.x and panel.aimX <= (button.x + button.w)
            and panel.aimY >= button.y and panel.aimY <= (button.y + button.h) then
                buttonTarget = button
                --table.insert(foundbuttons,{button,panel.aimedAt})
            end
        else
            --If the aim location is withing button radis
            local dist = math.Distance(button.x,button.y,panel.aimX,panel.aimY)
            if dist < (button.radius or 10) then
                buttonTarget = button
                --table.insert(foundbuttons,{button,panel.aimedAt})
            end
        end
    end

    return buttonTarget
end
local findAimButton = Metrostroi.FindAimButton

--------------------------------------------------------------------------------
-- Checks what button/panel is being looked at and check for custom crosshair
--------------------------------------------------------------------------------
function Metrostroi.CalcPanelAim(ply,train,outside,x,y)
    local plyaimvec
    if not outside or g_ContextMenu:IsVisible() then
        --plyaimvec = util.AimVector( train.CamAngles, train.CamFOV,x,y,ScrW(),ScrH())
        --plyaimvec = ply:GetAimVector()
        plyaimvec = gui.ScreenToVector(x,y) -- ply:GetAimVector() is unreliable when in seats
    else
        plyaimvec = ply:GetAimVector()
    end

    -- Loop trough every panel
    local panelAimed,panelDist = false,1e9
    for kp,panel in pairs(train.ButtonMap) do
        if not train:ShouldDrawPanel(kp) then panel.aimedAt = false continue end
        local pang = train:LocalToWorldAngles(panel.ang)

        if plyaimvec:Dot(pang:Up()) < 0 then
            local campos = not outside and train.CamPos or ply:EyePos()
            local ppos = train:LocalToWorld(panel.pos)-- - Vector(math.Round((not outside and train.HeadAcceleration or 0),2),0,0))
            local isectPos = LinePlaneIntersect(ppos,pang:Up(),campos,plyaimvec)
            local localx,localy = WorldToScreen(isectPos,ppos,panel.scale,pang)

            panel.aimX = localx
            panel.aimY = localy
            if plyaimvec:Dot(isectPos - campos)/(isectPos-campos):Length() > 0 and localx > 0 and localx < panel.width and localy > 0 and localy < panel.height then
                panel.aimedAt = isectPos:Distance(campos)
                --If player is looking at this panel
                if panel.aimedAt < panelDist then
                    panelAimed = panel
                    panelDist = panel.aimedAt
                end
            else
                panel.aimedAt = false
            end
            panel.outside = outside
        else
            panel.aimedAt = false
        end
    end

    return panelAimed    
end
local calcPanelAim = Metrostroi.CalcPanelAim

--------------------------------------------------------------------------------
-- Draw crosshair with train panel info
--------------------------------------------------------------------------------
local lastAimButton = false
local lastAimButtonChange = 0
function Metrostroi.DrawGUIOverlay(train,x,y,panel,hideTime)
    local button = findAimButton(train,panel)

    -- Tooltip
    local toolTipText,_,toolTipColor
    local ttdelay = C_TooltipDelay:GetFloat()
    if not C_DisableHoverText:GetBool() and ttdelay >= 0 then
        if button and
            ((train.Hidden[button.ID] or train.Hidden[button.PropName]) and (not train.ClientProps[button.ID].config or not train.ClientProps[button.ID].config.staylabel) or
            (train.Hidden.button[button.ID] or train.Hidden.button[button.PropName]) and (not train.ClientProps[button.PropName].config or not train.ClientProps[button.PropName].config.staylabel)) then
            return
        end
        if button ~= lastAimButton then
            lastAimButtonChange = CurTime()
            lastAimButton = button
        end

        if button then
            if ttdelay == 0 or CurTime() - lastAimButtonChange > ttdelay then
                if C_DrawDebug:GetBool() then
                    toolTipText,toolTipColor = button.ID,Color(255,0,255)
                elseif button.plombed then
                    toolTipText,_,toolTipColor = button.plombed(train)
                else
                    toolTipText,toolTipColor = button.tooltip
                end
                --[[toolTipPosition = nil
                if button.tooltipState then
                    local newTT,newTTpos = button.tooltipState(train)
                    toolTipText = toolTipText..newTT
                    toolTipPosition = Metrostroi.GetPhrase(newTTpos)
                end]]
                if not C_DisableHoverTextP:GetBool() and button.tooltipState and button.tooltip then
                    toolTipText = toolTipText..button.tooltipState(train)
                end
            end
        end
    end

    -- Crosshair
    if g_ContextMenu:IsVisible() then
        -- Select cursor if aimed to button while holding C
        local isButton = button and button.ID and button and button.ID[1] ~= "!"
        local isPlombed = false
        if isButton and button.plombed then
            local v1,v2,v3 = button.plombed(train)
            isPlombed = (v3 ~= false)
        end
        g_ContextMenu:SetCursor(isPlombed and "no" or isButton and "hand" or "arrow")
        x = x+8
        y = y+8
    else
        local alpha = math.min(0.5,hideTime)*2*255
        surface.DrawCircle(ScrW()/2,ScrH()/2,4.1,button and Color(255,0,0) or Color(255,255,150,alpha))
    end

    if toolTipText ~= nil then
        surface.SetFont("MetrostroiLabels")
        surface.SetDrawColor(0,0,0,125)
        local texts = string.Explode("\n",toolTipText)
        for i,v in ipairs(texts) do
            if #v==0 then continue end
            local w2,h2 = surface.GetTextSize(v)
            local y2 = y+h2*i
            surface.DrawRect(x-w2/2-5, y2-h2/2, w2+10, h2)
            --[[if toolTipPosition and i==#texts then
                local st,en = v:find(toolTipPosition)
                local textSt,textEn = v:sub(1,st-1),v:sub(en+1,-1)
                local x1 = 0-w2/2
                local x2 = surface.GetTextSize(textSt)-w2/2
                local x3 = surface.GetTextSize(textSt)+surface.GetTextSize(toolTipPosition)-w2/2
                draw.SimpleText(textSt,"MetrostroiLabels",scrX+x1,y, toolTipColor or Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText(toolTipPosition,"MetrostroiLabels",scrX+x2,y, toolTipColor or Color(0,255,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText(textEn,"MetrostroiLabels",scrX+x3,y, toolTipColor or Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                Metrostroi.DrawLine(scrX+x2,y+h/2-3,scrX+x3,y+h/2-3,toolTipColor or Color(0,255,0),1)
            else]]
                draw.SimpleText(v,"MetrostroiLabels",x,y2,toolTipColor or Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            --end
        end
    end
end
local drawGUIOverlay = Metrostroi.DrawGUIOverlay

--------------------------------------------------------------------------------
-- Calculate player aim on train panels
--------------------------------------------------------------------------------
local lastCursorX, lastCursorY, lastMouseMove = 0,0,0
function Metrostroi.AimCabinPanel()
    if g_SpawnMenu:IsVisible() or IsValidPanel(vgui.GetHoveredPanel()) and not vgui.IsHoveringWorld() and vgui.GetHoveredPanel():GetParent() ~= vgui.GetWorldPanel() then return end

    -- Get cursor position
    local inputCursorX, inputCursorY = input.GetCursorPos()
    local cursorX, cursorY = ScrW()/2,ScrH()/2
    if system.HasFocus() and g_ContextMenu:IsVisible() then
        cursorX,cursorY = inputCursorX, inputCursorY
    end

    -- Check mouse move cooldown
    if lastCursorX ~= inputCursorX or lastCursorY ~= inputCursorY then
        lastCursorX = inputCursorX
        lastCursorY = inputCursorY
        lastMouseMove = CurTime()
    end

    local chDelay = C_CrosshairDelay:GetFloat()
    local hideTime = chDelay < 1 and 1 or (chDelay - (CurTime() - lastMouseMove))
    if hideTime < 0 then return end

    -- Get player's train
    local ply = LocalPlayer()
    local train, outside = Metrostroi.CheckTrainView(ply)
    if not IsValidEnt(train) or train.ButtonMap == nil then return end

    -- Get aimed panel and draw crosshair
    local panel = calcPanelAim(ply,train,outside,cursorX,cursorY)
    drawGUIOverlay(train,cursorX,cursorY,panel,hideTime)

    --If aimed at button, no cooldown
    if panel then lastMouseMove = CurTime() end
end
hook.Add("HUDPaint", "metrostroi-cabin-panel", Metrostroi.AimCabinPanel)

--------------------------------------------------------------------------------
-- Show/hide HUD if player disables HUD
--------------------------------------------------------------------------------
local whitelist = {
    ["CHudChat"] = true,
    ["CHudDeathNotice"] = true,
    ["CHudGMod"] = true,
}
hook.Add("HUDShouldDraw","MetrostroiHUDHider",function(name)
    if LocalPlayer().InMetrostroiTrain and C_DisableHUD:GetBool() and not whitelist[name] then return false end
end)

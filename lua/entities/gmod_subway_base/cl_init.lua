include("shared.lua")

--if LocalPlayer():GetName():find("iNok") then RunConsoleCommand("say","ЛВЗ говно, обажаю МВМ") end
surface.CreateFont("MetrostroiSubway_LargeText", {
    font = "Arial",
    size = 100,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
    extended = true
})
surface.CreateFont("MetrostroiSubway_SmallText", {
    font = "Arial",
    size = 70,
    weight = 1000,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
    extended = true
})
surface.CreateFont("MetrostroiSubway_VerySmallText", {
    font = "Arial",
    size = 45,
    weight = 1000,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
    extended = true
})
surface.CreateFont("MetrostroiSubway_VerySmallText2", {
    font = "Arial",
    size = 35,
    weight = 1000,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false
 })
 surface.CreateFont("MetrostroiSubway_VerySmallText3", {
    font = "Arial",
    size = 25,
    weight = 1000,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
    extended = true
})
surface.CreateFont("MetrostroiSubway_LargeText2", {
    font = "Arial",
    size = 86,
    weight = 1000,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
    extended = true
})
surface.CreateFont("MetrostroiSubway_LargeText3", {
    font = "Arial",
    size = 66,
    weight = 1000,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
    extended = true
})

surface.CreateFont("MetrostroiLabels", {
    font = "BudgetLabel",
    size = 15,
    weight = 400,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = true,
    additive = true,
    outline = true,
    extended = true
})
surface.CreateFont("MetrostroiSubway_IGLAb", {
    font = "IEE2",
    size = 30,
    weight = 0,
    blursize = 3,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = true,
    additive = true,
    outline = true,
    extended = true
})
surface.CreateFont("MetrostroiSubway_IGLA", {
    font = "IEE2",
    size = 30,
    weight = 0,
    blursize = 0,
    scanlines = 0,
    antialias = false,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
    extended = true
})
surface.CreateFont("MetrostroiSubway_FixedSYS", {
    font = "FixedsysTTF",
    size = 40,
    weight = 0,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
    extended = true
})
surface.CreateFont("MetrostroiSubway_Speed", {
    font = "LCD AT&T Phone Time/Date",
    size = 200,
    weight = 400,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false
})
surface.CreateFont("MetrostroiSubway_InfoPanel", {
    font = "Arial",
    size = 64,
    weight = 0,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
    extended = true
})
surface.CreateFont("MetrostroiSubway_InfoRoute", {
    font = "Arial",
    size = 80,
    weight = 800,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
    extended = true
})
surface.CreateFont("Trebuchet24", { --Creating BUILTIN font (idk what happened with this font')
    font = "Trebuchet",
    size = 24,
    weight = 400,
    blursize = 0,
    scanlines = 10,
    antialias =  true,
    additive = false,
    extended = true
})
--------------------------------------------------------------------------------
-- Console commands and convars
--------------------------------------------------------------------------------
concommand.Add("metrostroi_train_manual", function()--ply, _, args)
--[[    local w = ScrW() * 2/3
    local h = ScrH() * 2/3
    local browserWindow = vgui.Create("DFrame")
    browserWindow:SetTitle("Train Manual")
    browserWindow:SetPos((ScrW() - w)/2, (ScrH() - h)/2)
    browserWindow:SetSize(w,h)
    browserWindow.OnClose = function()
        browser = nil
        browserWindow = nil
    end
    browserWindow:MakePopup()

    local browser = vgui.Create("DHTML",browserWindow)
    browser:SetPos(10, 25)
    browser:SetSize(w - 20, h - 35)

    browser:OpenURL
    ]]--
    gui.OpenURL("http://phoenixblack.github.io/Metrostroi/manual.html")
end)
ENT.RTMaterial = CreateMaterial("MetrostroiRT1","UnlitGeneric",{
    ["$vertexcolor"] = 0,
    ["$vertexalpha"] = 1,
    ["$nolod"] = 1,
})
ENT.RTMaterial2 = CreateMaterial("MetrostroiRT2","UnlitGeneric",{
    ["$vertexcolor"] = 0,
    ["$vertexalpha"] = 0,
    ["$nolod"] = 1,
})
ENT.RTScanlineMaterial = CreateMaterial("MetrostroiRTScanline","UnlitGeneric",{
    ["$vertexcolor"] = 1,
    ["$vertexalpha"] = 1,
    ["$nolod"] = 1,
})

function ENT:CreateRT(name, w, h)
    local RT = GetRenderTarget("Metrostroi"..self:EntIndex()..":"..name, w or 512, h or 512)
    if not RT then Error("Can't create RT\n") end
    --mat:SetTexture("$basetexture", RT)
    return RT
end

local C_DisableHUD          = GetConVar("metrostroi_disablehud")
local C_RenderDistance      = GetConVar("metrostroi_renderdistance")
local C_SoftDraw            = GetConVar("metrostroi_softdrawmultipier")
local C_ScreenshotMode      = GetConVar("metrostroi_screenshotmode")
local C_DrawDebug           = GetConVar("metrostroi_drawdebug")
local C_CabFOV              = GetConVar("metrostroi_cabfov")
local C_CabZ                = GetConVar("metrostroi_cabz")
local C_FovDesired          = GetConVar("fov_desired")
local C_MinimizedShow       = GetConVar("metrostroi_minimizedshow")
local C_Shadows1            = GetConVar("metrostroi_shadows1")
local C_Shadows2            = GetConVar("metrostroi_shadows2")
local C_Shadows3            = GetConVar("metrostroi_shadows3")
local C_Shadows4            = GetConVar("metrostroi_shadows4")
local C_AA                  = GetConVar("mat_antialias")
local C_Sprites             = GetConVar("metrostroi_sprites")
local whitelist = {
    ["CHudChat"] = true,
    ["CHudDeathNotice"] = true,
    ["CHudGMod"] = true,
}
hook.Add("HUDShouldDraw","MetrostroiHUDHider",function(name)
    if LocalPlayer().InMetrostroiTrain and C_DisableHUD:GetBool() and not whitelist[name] then return false end
end)
--------------------------------------------------------------------------------
-- Buttons layout
--------------------------------------------------------------------------------
--ENT.ButtonMap = {} Leave nil if unused

-- General Panel
--[[table.insert(ENT.ButtonMap,{
    pos = Vector(7,0,0),
    ang = Angle(0,90,90),
    width = 300,
    height = 100,
    scale = 0.0625,

    buttons = {
        {ID=1, x=-117,  y=   0,  radius=20, tooltip="Test 1"},
        {ID=2, x= -80,  y=   0,  radius=20, tooltip="Test 2"},
    }
})]]--


--------------------------------------------------------------------------------
-- Decoration props
--------------------------------------------------------------------------------
ENT.ClientProps = {}

--------------------------------------------------------------------------------
-- Clientside entities support
--------------------------------------------------------------------------------
local lastButton
local lastTouch
local drawCrosshair
local canDrawCrosshair
local toolTipText
local toolTipColor
local lastAimButtonChange
local lastAimButton

function ENT:ShouldRenderClientEnts()
    return not self:IsDormant() and math.abs(LocalPlayer():GetPos().z - self:GetPos().z) < 500 and (system.HasFocus() or C_MinimizedShow:GetBool()) and (not Metrostroi or not Metrostroi.ReloadClientside)
end
function ENT:ShouldDrawPanel(v)
    return not self.HiddenPanelsDistance[v] and not self.HiddenPanels[v]
end
function ENT:ShouldDrawClientEnt(k,v)
    if self.Hidden[k] or self.Hidden.anim[k] then return false end
    v = v or self.ClientProps[k]
    if not v then return false end
    local distance =  LocalPlayer():GetPos():Distance(self:LocalToWorld(v.pos))
    local renderDist = C_RenderDistance:GetFloat()
    if v.nohide then return true end
    if v.hideseat then
        local seat = LocalPlayer():GetVehicle()
        if IsValid(seat) and self ~= seat:GetParent() then
            return false
        end
        if v.hideseat ~= true then
            return distance <= renderDist*v.hideseat
        end
    elseif v.hide then
        return distance <= renderDist*v.hide
    else
        return distance <= renderDist
    end
end
--util.PrecacheModel("models/metrostroi_train/81-720/81-720.mdl")
function ENT:SpawnCSEnt(k,override)
    if override and (self.Hidden[k] or self.Hidden.anim[k]) or not override and not self:ShouldDrawClientEnt(k,self.ClientProps[k]) then return false end
    local v = self.ClientPropsOv and self.ClientPropsOv[k] or self.ClientProps[k]
    if v and not IsValid(self.ClientEnts[k]) and  v.model ~= "" then
        --local cent = ents.CreateClientProp(LocalPlayer():GetModel())
        local model = v.model
        if v.modelcallback then model = v.modelcallback(self) or v.model end
        local cent = ClientsideModel(model,RENDERGROUP_OPAQUE)
        cent.GetBodyColor = function()
            if not IsValid(self) then return Vector(1) end
            return self:GetBodyColor()
        end
        cent.GetDirtLevel = function()
            if not IsValid(self) then return 0.25 end
            return self:GetDirtLevel()
        end
        --cent:SetModel( v.model )
        cent:SetParent(self)
        cent:SetPos(self:LocalToWorld(v.pos))
        cent:SetAngles(self:LocalToWorldAngles(v.ang))
        cent:SetLOD(C_ScreenshotMode:GetBool() and 0 or -1)
        --[[
        hook.Add("MetrostroiBigLag",cent,function(ent)
            --print(ent:GetLocalPos())
            ent:SetLocalPos(ent:GetLocalPos())
            ent:SetLocalAngles(ent:GetLocalAngles())
            --if ent.Spawned then hook.Remove("MetrostroiBigLag",ent) end
            --ent.Spawned = true
        end)]]
        cent:SetSkin(v.skin or 0)
        if v.scale then cent:SetModelScale(v.scale) end
        if v.bscale then cent:ManipulateBoneScale(0,v.bscale) end
        if self.Anims[k] and self.Anims[k].value and type(self.Anims[k].value) == "number" then
            cent:SetPoseParameter("position",self.Anims[k].value)
        end


        if v.bodygroup then
            for k1,v1 in pairs(v.bodygroup) do
                cent:SetBodygroup(v1,k1)
            end
        end
        if v.lamps then
            for i,k in ipairs(v.lamps) do
                self.HiddenLamps[k] = false
            end
        end
        cent.lamps = v.lamps

        local texture = Metrostroi.Skins["train"][self:GetNW2String("Texture")]
        local passtexture = Metrostroi.Skins["pass"][self:GetNW2String("PassTexture")]
        local cabintexture = Metrostroi.Skins["cab"][self:GetNW2String("CabTexture")]
        for k1,v1 in pairs(cent:GetMaterials() or {}) do
            local tex = v1:gsub("^.+/","")
            if cabintexture and cabintexture.textures and cabintexture.textures[tex] then
                if type(cabintexture.textures[tex]) ~= "table" then
                    cent:SetSubMaterial(k1-1,cabintexture.textures[tex])
                end
            end
            if passtexture and passtexture.textures and passtexture.textures[tex] then
                cent:SetSubMaterial(k1-1,passtexture.textures[tex])
            end
            if texture and texture.textures and texture.textures[tex] then
                cent:SetSubMaterial(k1-1,texture.textures[tex])
            end
        end

        self.ClientEnts[k] = cent
        if self.SmoothHide[k] then
            if self.SmoothHide[k] > 0 then
                cent:SetColor(ColorAlpha(v.color or color_white,self.SmoothHide[k]*255))
                cent:SetRenderMode(RENDERMODE_TRANSALPHA)
            else
                cent:Remove()
                self:ShowHide(k, false,true)
            end
        elseif v.colora then
            cent:SetRenderMode(RENDERMODE_TRANSCOLOR)
            cent:SetColor(v.colora)
        else
            cent:SetColor(v.color or color_white)
        end

        cent.BASSSounds = {}
        cent.DestroySound = self.DestroySound
        cent.Think = function(ent)
            for k,v in pairs(ent.BASSSounds) do
                if not IsValid(v) or v:GetState() == GMOD_CHANNEL_STOPPED then
                    self:DestroySound(v)
                    table.remove(ent.BASSSounds,k)
                end
            end
            ent:SetNextClientThink(CurTime()+0.5)
            return true
        end
        cent.CalcAbsolutePosition = function(ent,pos,ang)
            for k,v in pairs(ent.BASSSounds) do
                if IsValid(v) and v:GetState() ~= GMOD_CHANNEL_STOPPED then
                    v:SetPos(pos,ang:Forward())
                end
            end
        end
        if v.lamps then
            cent:CallOnRemove("RemoveLights", function(ent)
                if IsValid(self) then
                    for i,k in ipairs(ent.lamps) do
                        self:SetLightPower(k,false)
                        self.HiddenLamps[k] = true
                    end
                end
            end)
        end
        self:ShowHide(k, not self.Hidden[k],true)
        if v.callback then v.callback(self,cent) end
        return true
    end
    return false
end

function ENT:GetBodyColor()
    return self:GetNW2Vector("BodyColor",Vector(1,1,1))
end
function ENT:GetDirtLevel()
    return self:GetNW2Float("DirtLevel",0.25)
end
hook.Remove("Think","metrostroi_collect_garbage",function()
    if Metrostroi.CollectGarbage then
        collectgarbage("collect")
        Metrostroi.CollectGarbage = false
    end
end)
hook.Add("EntityRemoved","metrostroi_bass_disable",function(ent)
    if ent.BASSSounds then
        for k,v in pairs(ent.BASSSounds) do
            ent:DestroySound(v)
            ent.BASSSounds[k] = nil
        end
    end
end)
function ENT:SetCSBodygroup(csent,id,value)
    if not self.ClientProps[csent].bodygroup then self.ClientProps[csent].bodygroup = {} end
    self.ClientProps[csent].bodygroup[id] = value
    if IsValid(self.ClientEnts[csent]) then self.ClientEnts[csent]:SetBodygroup(id,value) end
end
local elapsed = SysTime()
local spawnedCount = 0
hook.Add("Think","SpawnElasped",function() elapsed = SysTime() spawnedCount = 0 end)
function ENT:CreateCSEnts()
    local mul = C_SoftDraw:GetFloat()/100
    local time = mul*0.01
    if self.ClientPropsOv then
        for k in pairs(self.ClientPropsOv) do
            if k ~= "BaseClass" and not IsValid(self.ClientEnts[k]) and self:SpawnCSEnt(k)then
                if SysTime()-elapsed > time then
                    return false
                end
            end
        end
    end
    --RunConsoleCommand("say","1:"..tostring(elapsed))
    for k in pairs(self.ClientProps) do
        if k ~= "BaseClass" and not IsValid(self.ClientEnts[k]) then
            if spawnedCount*mul*3 > 4 and SysTime()-elapsed > time then
                return false
            end
            if self:SpawnCSEnt(k) then spawnedCount = spawnedCount + 1 end
            --RunConsoleCommand("say","1:")
        end
    end
    return true
end

function ENT:RemoveCSEnt(id)
    if self.ClientEnts and self.ClientEnts[id] then
        SafeRemoveEntity(self.ClientEnts[id])
        self.ClientEnts[id] = nil
    end
end

function ENT:RemoveCSEnts()
    if self.ClientEnts then
        for _,v in pairs(self.ClientEnts) do
            if IsValid(v) then
                v:Remove()
            end
        end
    end
    if(self.GlowingLights) then
        for k,v in pairs(self.GlowingLights) do
            if IsValid(v) and v.Remove then
                v:Remove()
            end
        end
    end
    self.ClientEnts = {}
    self.GlowingLights = {}
    self.Sprites = {}
end


-- Checks if the player is driving a train, also returns said train
local function isValidTrainDriver(ply)
    if IsValid(ply.InMetrostroiTrain) then return ply.InMetrostroiTrain end

    local weapon = IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass()
    if weapon ~= "train_kv_wrench" and weapon ~= "train_kv_wrench_gold" then return end

    local train = util.TraceLine({
        start = LocalPlayer():GetPos(),
        endpos = LocalPlayer():GetPos() - LocalPlayer():GetAngles():Up() * 100,
        filter = function( ent ) if ent.ButtonMap ~= nil then return true end end
    }).Entity
    if not IsValid(train) then
        train = util.TraceLine({
            start = LocalPlayer():EyePos(),
            endpos = LocalPlayer():EyePos() + LocalPlayer():EyeAngles():Forward() * 300,
            filter = function( ent ) if ent.ButtonMap ~= nil then return true end end
        }).Entity
    end
    return IsValid(train) and train, true
end
--------------------------------------------------------------------------------
-- Clientside initialization
--------------------------------------------------------------------------------
function ENT:CanDrawThings()
    return not LocalPlayer().InMetrostroiTrain or self == LocalPlayer().InMetrostroiTrain
end
local function colAlpha(col,a)
    return Color(col.r*a,col.g*a,col.b*a)
end
hook.Add("PostDrawTranslucentRenderables", "metrostroi_base_draw", function(_,isDD)
    if isDD then return end
    local inSeat = LocalPlayer().InMetrostroiTrain
    for ent in pairs(Metrostroi.SpawnedTrains) do
        if ent:IsDormant() then continue end
        if MetrostroiStarted and MetrostroiStarted~=true or ent.RenderBlock then
            if not inSeat then
                local timeleft = (math.max(0,(MetrostroiStarted and MetrostroiStarted~=true) and 3-(RealTime()-MetrostroiStarted) or 3-(RealTime()-ent.RenderBlock)))+0.99
                cam.Start3D2D(ent:LocalToWorld(Vector(0,-150,100)),ent:LocalToWorldAngles(Angle(0,90,90)),1.5)
                    draw.SimpleText("Wait, train will be available across "..string.NiceTime(timeleft))
                cam.End3D2D()
                cam.Start3D2D(ent:LocalToWorld(Vector(0,150,100)),ent:LocalToWorldAngles(Angle(0,-90,90)),1.5)
                    draw.SimpleText("Wait, train will be available across "..string.NiceTime(timeleft))
                cam.End3D2D()
            end
            continue
        end
        cam.IgnoreZ(true)
        for i,vHandle in pairs(ent.Sprites) do
            local br = ent.LightBrightness[i]
            local lightData = ent.LightsOverride[i] or ent.Lights[i]
            if lightData[1] ~= "glow" and lightData[1] ~= "light" or br <= 0 then continue end

            local pos = ent:LocalToWorld(lightData[2])
            local visibility = util.PixelVisible(pos, lightData.size or 5, vHandle)--math.max(0,util.PixelVisible(pos, 5, vHandle)-0.25)/0.75
            if visibility > 0 then
                render.SetMaterial(lightData.mat)
                render.DrawSprite(pos,128*lightData.scale,128*(lightData.vscale or lightData.scale),colAlpha(lightData[4] or Color(255,255,255),visibility*br))
                --render.DrawQuadEasy( ent:GetPos(),-EyeVector(), 128*ent.Scale, 128*ent.Scale, ent:GetColor())
            end
        end
        cam.IgnoreZ(false)
        if not ent.ShouldRenderClientEnts or not ent:ShouldRenderClientEnts() then continue end

        if ent.DrawPost then ent:DrawPost(not ent:CanDrawThings()) end
        if not ent:CanDrawThings() then continue end
        ent.CLDraw = true

        if ent.Systems then
            for _,v in pairs(ent.Systems) do
                v:ClientDraw()
            end
        end
    end
end)

local function enableDebug()
    if C_DrawDebug:GetInt() > 0 then
        hook.Add("PostDrawTranslucentRenderables","MetrostroiTrainDebug",function(bDrawingDepth,bDrawingSkybox)
            if bDrawingSkybox then return end
            for ent in pairs(Metrostroi.SpawnedTrains) do
                -- Debug draw for buttons
                if ent.ButtonMap ~= nil then
                    draw.NoTexture()
                    for kp,panel in pairs(ent.ButtonMap) do
                        if kp ~= "BaseClass" and LocalPlayer():GetPos():DistToSqr(ent:LocalToWorld(panel.pos)) < 262144 then
                            ent:DrawOnPanel(kp,function()
                                surface.SetDrawColor(0,0,255)
                                if not ent:ShouldDrawPanel(kp) then surface.SetDrawColor(255,0,0) end
                                surface.DrawOutlinedRect(0,0,panel.width,panel.height)

                                if panel.aimX and panel.aimY then
                                    surface.SetTextColor(255,255,255)
                                    surface.SetFont("BudgetLabel")
                                    surface.SetTextPos(panel.width/2,5)
                                    surface.DrawText(string.format("%d %d",panel.aimX,panel.aimY))
                                end


                                --surface.SetDrawColor(255,255,255)
                                --surface.DrawRect(0,0,panel.width,panel.height)
                                if panel.buttons then

                                    surface.SetAlphaMultiplier(0.2)
                                    if ent.HiddenPanels[kp] then surface.SetAlphaMultiplier(0.1) end

                                    for kb,button in pairs(panel.buttons) do
                                        if ent.Hidden[button.PropName] or ent.Hidden[button.ID] or ent.Hidden.anim[button.PropName] or ent.Hidden.anim[button.ID] or ent.Hidden.button[button.PropName] or ent.Hidden.button[button.ID] then
                                            surface.SetDrawColor(255,255,0)
                                        elseif ent.Hidden[kb] or ent.Hidden.anim[kb] then
                                            surface.SetDrawColor(255,255,0)
                                        elseif ent.HiddenPanels[kp] then
                                            surface.SetDrawColor(100,0,0)
                                        elseif not button.ID or button.ID[1] == "!" then
                                            surface.SetDrawColor(25,40,180)
                                        elseif button.state then
                                            surface.SetDrawColor(255,0,0)
                                        else
                                            surface.SetDrawColor(0,255,0)
                                        end

                                        if button.w and button.h then
                                            surface.DrawRect(button.x, button.y, button.w, button.h)
                                            surface.DrawRect(button.x + button.w/2 - 8,button.y + button.h/2 - 8,16,16)
                                            else
                                                ent:DrawCircle(button.x,button.y,button.radius or 10)
                                            surface.DrawRect(button.x-8,button.y-8,16,16)
                                        end
                                    end

                                    --Gotta reset this otherwise the qmenu draws transparent as well
                                    surface.SetAlphaMultiplier(1)

                                end


                            end,true)
                        end
                    end
                end
            end
        end)
    else
        hook.Remove("PostDrawTranslucentRenderables","MetrostroiTrainDebug")
    end
end
hook.Remove("PostDrawTranslucentRenderables","MetrostroiTrainDebug")
cvars.AddChangeCallback( "metrostroi_drawdebug", enableDebug)
enableDebug()

local function recurePrecache(sound)
    if type(sound) == "table" then
        for k,snd in pairs(sound) do recurePrecache(snd) end
    elseif type(sound) == "string" then
        --util.PrecacheSound(sound)
    end
end


function ENT:GetWagonNumber()
    local number = self:GetNW2Int("WagonNumber",-1)
    if number <= 0 then
        number = self:EntIndex()
    end
    return number
end
function ENT:Initialize()
    -- Create clientside props
    self.ClientEnts = {}
    self.HiddenPanels = {}
    self.HiddenPanelsDistance = {}
    self.HiddenLamps = {}
    self.Hidden = {
        anim = {},button = {},override = {},
    }
    self.Anims = {}
    self.SmoothHide = {}
    -- Create sounds
    self:InitializeSounds()
    recurePrecache(self.SoundNames)
    self.Sounds = {
        loop = {},
        isloop = {},
    }
    self.CurrentCamera = 0
    self.Sprites = {}
    if self.NoTrain then return end
    self.ButtonMapMatrix = {}
    -- Passenger models
    self.PassengerEnts = {}
    self.PassengerEntsStucked = {}
    self.PassengerPositions = {}
    --self.HiddenQuele = {}
    -- Systems defined in the train
    self.Systems = {}
    -- Initialize train systems
    self:InitializeSystems()

    self.GlowingLights = {}
    self.LightBrightness = {}
    self.LightsOverride = {}
    if self.Lights then
        for i,lightData in pairs(self.Lights) do
            if lightData.changable then
                self.LightsOverride[i] = table.Copy(lightData)
            end
        end
    end
    --self:EntIndex()
    self.PassengerModels = {
        "models/metrostroi/passengers/f1.mdl",
        "models/metrostroi/passengers/f2.mdl",
        "models/metrostroi/passengers/f3.mdl",
        "models/metrostroi/passengers/f4.mdl",
        "models/metrostroi/passengers/m1.mdl",
        "models/metrostroi/passengers/m2.mdl",
        "models/metrostroi/passengers/m4.mdl",
        "models/metrostroi/passengers/m5.mdl",
    }

    self.WagonNumber = 0
    self:PostInitializeSystems()

    self.TunnelCoeff = 0
    self.StreetCoeff = 0
    self.Street = 0
end

function ENT:UpdateTextures()
    self.Texture = self:GetNW2String("Texture")
    self.PassTexture = self:GetNW2String("PassTexture")
    self.CabinTexture = self:GetNW2String("CabTexture")

    local texture = Metrostroi.Skins["train"][self.Texture]
    local passtexture = Metrostroi.Skins["pass"][self.PassTexture]
    local cabintexture = Metrostroi.Skins["cab"][self.CabinTexture]
    for id,ent in pairs(self.ClientEnts) do
        if not IsValid(ent) then continue end
        if self.ClientProps[id].callback then self.ClientProps[id].callback(self,ent) end
        for k in pairs(ent:GetMaterials()) do ent:SetSubMaterial(k-1,"") end
        for k,v in pairs(ent:GetMaterials()) do
            local tex = string.Explode("/",v)
            tex = tex[#tex]
            if cabintexture and cabintexture.textures and cabintexture.textures[tex] then
                ent:SetSubMaterial(k-1,cabintexture.textures[tex])
            end
            if passtexture and passtexture.textures and passtexture.textures[tex] then
                ent:SetSubMaterial(k-1,passtexture.textures[tex])
            end
            if texture and texture.textures and texture.textures[tex] then
                ent:SetSubMaterial(k-1,texture.textures[tex])
            end
        end
    end
end
function ENT:UpdateWagonNumber() end

ENT.Cameras = {}
function ENT:OnRemove(nfinal)
    self.RenderBlock = RealTime()
    if nfinal then
        drawCrosshair = false
        canDrawCrosshair = false
        toolTipText = nil
    end
    self:RemoveCSEnts()
    self.RenderClientEnts = false


    for _,v in pairs(self.Sounds) do
        if type(v) ~= "function" and type(v) ~= "table" then
            self:DestroySound(v)
        end
    end
    for k,v in pairs(self.Sounds.loop) do
        for i,sndt in ipairs(v) do
            self:DestroySound(sndt.sound)
        end
    end
    for _,v in pairs(self.PassengerEnts or {}) do
        SafeRemoveEntity(v)
    end
    for _,v in pairs(self.PassengerEntsStucked or {}) do
        SafeRemoveEntity(v)
    end
    if self.GUILocker then self:BlockInput(false) end
    self.Sounds = {loop = {},isloop = {}}
    self.PassengerEnts = {}
    self.PassengerEntsStucked = {}
end

function ENT:CalcAbsolutePosition(pos, ang)
    if self.RenderClientEnts then
        if self.Lights and self.GlowingLights then
            for id, light in pairs(self.GlowingLights) do
                if not IsValid(light) then continue end
                local lightData = self.Lights[id]
                light:SetPos(self:LocalToWorld(lightData[2]))
                light:SetAngles(self:LocalToWorldAngles(lightData[3]))
            end
        end
        for k,v in pairs(self.Sounds) do
            if type(v) == "IGModAudioChannel" then
                if not IsValid(v) then
                    self.Sounds[k] = nil
                    continue
                end
                if v:GetState() ~= GMOD_CHANNEL_STOPPED then
                    local tbl = self.SoundPositions[k]
                    if tbl then
                        local lpos,lang = LocalToWorld(tbl[3],Angle(0,0,0),pos,ang)
                        v:SetPos(lpos,ang:Forward())
                    else
                        v:SetPos(pos)
                    end
                    continue
                end
            end
        end
        for k,v in pairs(self.Sounds.loop) do
            local tbl = self.SoundPositions[k]
            for i,stbl in ipairs(v) do
                local snd = stbl.sound
                if not IsValid(snd) then continue end
                if snd:GetState() == GMOD_CHANNEL_PLAYING then
                    if tbl then
                        local lpos,lang = LocalToWorld(tbl[3],Angle(0,0,0),pos,ang)
                        snd:SetPos(lpos,ang:Forward())
                    end
                end
            end
        end
    end
    return pos, ang
end
--------------------------------------------------------------------------------
-- Default think function
--------------------------------------------------------------------------------
local function SoundTrace(startv,endv)
    local tr = util.TraceLine( {
        start = startv,
        endpos = endv,
        mask = MASK_NPCWORLDSTATIC,
    } )
    --debugoverlay.Line(startv,endv,FrameTime(),Color( 255, 0, tr.Hit and 255 or 0 ))
    if tr.Hit then
        --debugoverlay.Sphere(tr.HitPos,4,FrameTime(),Color( 255, 200, 100))
        return startv:Distance(tr.HitPos)
    end
    return 1000
end

MetrostroiStarted = MetrostroiStarted or nil
hook.Add("KeyPress","MetrostroiStarted",function(_,key)
    if key~=IN_FORWARD and key~=IN_BACK and key~=IN_MOVELEFT and key~=IN_MOVERIGHT then return end
    hook.Add("Think","MetrostroiStarted",function()
        if MetrostroiStarted == nil then
            MetrostroiStarted = RealTime()
        elseif MetrostroiStarted == true or MetrostroiStarted and RealTime()-MetrostroiStarted > 3 then
            MetrostroiStarted = true
            hook.Remove("Think","MetrostroiStarted")
        end
    end)
    hook.Remove("KeyPress","MetrostroiStarted")
end)

function ENT:Think()
    self.PrevTime = self.PrevTime or RealTime()
    self.DeltaTime = (RealTime() - self.PrevTime)
    self.PrevTime = RealTime()
    if MetrostroiStarted~=true then
        return
    end

    if not self.FirstTick then
        self.FirstTick = true
        self.RenderClientEnts = true
        self.CreatingCSEnts = false
        return
    end
    if self.RenderClientEnts ~= self:ShouldRenderClientEnts() then
        self.RenderClientEnts = self:ShouldRenderClientEnts()
        if self.RenderClientEnts then
            self.CreatingCSEnts = true
            self:BlockInput(self.HandleMouseInput)
            --self:CreateCSEnts()
            --if self.UpdateTextures then self:UpdateTextures() end
            --local _,ent = next(self.ClientEnts)
            --if not IsValid(ent) then self.RenderClientEnts = false end
        else
            self:OnRemove(true)
            return
        end
    end
    if not self.RenderClientEnts then return end

    if self.RenderBlock then
        if RealTime()-self.RenderBlock < 3 then
            self.ClientPropsInitialized = false
            return
        else
            self.RenderBlock = false
        end
    end

    if not self.ClientPropsInitialized then
        self.ClientPropsInitialized = true
        self:RemoveCSEnts()
        self:InitializeSounds()
        self.RenderClientEnts = false
        self.StopSounds = false
    end
    if self.GlowingLights and (
            self.HeadlightShadows ~= C_Shadows1:GetBool()
            or self.OtherShadows ~= C_Shadows2:GetBool()
            or self.RedLights ~= C_Shadows3:GetBool()
            or self.OtherLights ~= C_Shadows4:GetBool()
            or self.AAEnabled ~= (C_AA:GetInt() > 1)
            or self.SpritesEnabled ~= C_Sprites:GetBool()) then
        self.HeadlightShadows = C_Shadows1:GetBool()
        self.OtherShadows = C_Shadows2:GetBool()
        self.RedLights = C_Shadows3:GetBool()
        self.OtherLights = C_Shadows4:GetBool()
        self.SpritesEnabled = C_Sprites:GetBool()
        self.AAEnabled = C_AA:GetInt() > 1
        for k,v in pairs(self.GlowingLights) do
            if IsValid(v) then v:Remove() end
        end
        self.GlowingLights = {}
        self.LightBrightness = {}
        self.Sprites = {}
    end


    if self.RenderClientEnts and self.CreatingCSEnts then
        self.CreatingCSEnts = not self:CreateCSEnts()
        if not self.CreatingCSEnts then
            self:UpdateTextures()
            if self.Systems then
                for _,v in pairs(self.Systems) do
                    if v.ClientReload then v:ClientReload() end
                end
            end
        end
    end
    if not self.RenderClientEnts or self.CreatingCSEnts then return end

    if self.WagonNumber ~= self:GetWagonNumber() then
        self.WagonNumber = self:GetWagonNumber()
        self:UpdateWagonNumber()
    end

    if self.Texture ~= self:GetNW2String("Texture") then self:UpdateTextures() end
    if self.PassTexture ~= self:GetNW2String("PassTexture") then self:UpdateTextures() end
    if self.CabinTexture ~= self:GetNW2String("CabTexture") then self:UpdateTextures() end

    local hasGoldenReverser = self:GetNW2Bool("GoldenReverser")
    if self.HasGoldenReverser ~= hasGoldenReverser then
        self.HasGoldenReverser = hasGoldenReverser
        for id,v in pairs(self.ClientProps) do
            if v.model == "models/metrostroi_train/reversor/reversor_classic.mdl" and v.modelcallback and IsValid(self.ClientEnts[id]) then
                self:RemoveCSEnt(id)
                self:SpawnCSEnt(id)
            end
        end
    end

    if (GetConVar("metrostroi_disablecamaccel"):GetInt() == 0) then
        self.HeadAcceleration = (self:Animate("accel",((self:GetNW2Float("Accel",0)+1)/2),0,1, 4, 1)*30-15)
    else
        self.HeadAcceleration = 0
    end
    -- Simulate systems
    if self.Systems then
        for _,v in pairs(self.Systems) do
            v:ClientThink(self.DeltaTime)
        end
    end
    if not self.StopSounds then
        local soundPos = self.SoundPositions
        local soundNames = self.SoundNames
        for k,v in pairs(self.Sounds.loop) do

            local tbl = soundPos[k]
            local ntbl =  soundNames[k]
            local good = true
            for i,stbl in ipairs(v) do
                if not stbl.volume then good = false end
            end
            if not good then continue end
            for i,stbl in ipairs(v) do
                local snd = stbl.sound
                if not IsValid(snd) then continue end
                if snd:GetState() == GMOD_CHANNEL_PLAYING then
                    self:SetPitchVolume(snd,v.pitch or 1,stbl.volume,tbl)
                    if stbl.volume == 0 and not stbl.time then
                        snd:Pause()
                        snd:SetTime(0)
                    end
                end
                if snd:GetState() ~= GMOD_CHANNEL_PLAYING and stbl.volume ~= 0 then
                    stbl.volume = 0
                end
                if stbl.time then
                    local targetvol = stbl.state and v.volume or 0
                    if stbl.time == true then
                        stbl.volume = targetvol
                    else
                        stbl.volume = math.Clamp((stbl.volume or 0) + FrameTime()/(stbl.time/v.pitch)*(stbl.state and 1 or -1)*v.volume,0,v.volume)
                    end
                    if stbl.volume == targetvol then
                        stbl.time = nil
                    end
                end

                if i==1 then
                    local no1 = ntbl.loop and ntbl.loop==0
                    local endt = (ntbl.loop and snd:GetTime() > ntbl.loop or snd:GetTime()/snd:GetLength() >= 0.8) or no1
                    if stbl.state and stbl.volume < v.volume and not no1 then
                        if snd:GetState() ~= GMOD_CHANNEL_PLAYING then
                            snd:Play()
                            self:SetBASSPos(snd,tbl)
                        end
                        stbl.volume = v.volume
                        self:SetPitchVolume(snd,v.pitch,stbl.volume,tbl)
                        for i=2,3 do
                            if not v[i].volume or v[i].volume > 0 then
                                v[i].time=2
                                if v[i].GetState and v[i]:GetState() ~= GMOD_CHANNEL_PLAYING then
                                    v[i]:EnableLooping(i==2)
                                    v[i]:Play()
                                    self:SetBASSPos(v[i],tbl)
                                end
                                self:SetPitchVolume(v[i].sound,v.pitch,v[i].volume,tbl)
                            end
                        end
                        stbl.time = nil
                    end
                    if stbl.state and endt then
                        stbl.state = false
                        if no1 then
                            stbl.time = true
                            v[2].state = not v[3].state
                        end
                    end

                    if not stbl.state and stbl.volume == v.volume and not stbl.time then
                        stbl.time = not ntbl.loop or 0.1/v.pitch--endt and (snd:GetLength()-snd:GetTime())*0.8 or 0.05
                        v[2].state = not v[3].state
                    end
                end
                if i==2 then
                    if stbl.state and not stbl.time and stbl.volume == 0 then
                        if snd:GetState() ~= GMOD_CHANNEL_PLAYING then
                            snd:EnableLooping(true)
                            snd:Play()
                            self:SetBASSPos(snd,tbl)
                        end
                        if v[1].time == true then
                            stbl.volume = v.volume
                        elseif v[1].time then
                            stbl.time = v[1].time
                            stbl.volume = 0
                        end
                        self:SetPitchVolume(snd,v.pitch,stbl.volume,tbl)
                    end
                    if not stbl.state and not stbl.time and stbl.volume > 0 then
                        stbl.time = 0.07/v.pitch
                    end
                end
                if i==3 then
                    local time = v[2].time or v[1].time
                    if stbl.state and time and not stbl.time then
                        if snd:GetState() ~= GMOD_CHANNEL_PLAYING then
                            snd:Play()
                            self:SetBASSPos(snd,tbl)
                        end
                        stbl.volume = 0
                        self:SetPitchVolume(snd,v.pitch,stbl.volume,tbl)

                        stbl.time = 0.1/v.pitch
                        for i=1,2 do
                            if v[i].volume > 0 then
                                v[i].time=0.07/v.pitch
                                if v[i].GetState and v[i]:GetState() ~= GMOD_CHANNEL_PLAYING then
                                    v[i]:Play()
                                    self:SetBASSPos(v[i],tbl)
                                end
                                self:SetPitchVolume(v[i].sound,v.pitch,v[i].volume,tbl)
                            end
                        end
                    elseif (not stbl.state or (snd:GetTime()/snd:GetLength() >= 0.9)) and stbl.time then
                        stbl.time = nil
                        stbl.volume = 0
                        stbl.state = false
                    end
                end
            end
        end
    end
    if not self.NoTrain then
        self.SoundTraceI = self.SoundTraceI or 0
        local min, max = self:OBBMins(),self:OBBMaxs()
        local x = self.SoundTraceI==2 and max.x or self.SoundTraceI==1 and 0 or min.x
        local leftt = SoundTrace(self:LocalToWorld(Vector(x,min.y,0)),self:LocalToWorld(Vector(x,min.y-128,0)))
        local leftst = SoundTrace(self:LocalToWorld(Vector(x,min.y,-64)),self:LocalToWorld(Vector(x,min.y-48,-64)))
        local rightst = SoundTrace(self:LocalToWorld(Vector(x,max.y,-64)),self:LocalToWorld(Vector(x,max.y+48,-64)))
        local rightt = SoundTrace(self:LocalToWorld(Vector(x,max.y,0)),self:LocalToWorld(Vector(x,max.y+128,0)))
        local upt = SoundTrace(self:LocalToWorld(Vector(x,0,max.z)),self:LocalToWorld(Vector(x,0,max.z+256--[[ 384--]] )))
        self.SoundTraceI = self.SoundTraceI+1
        if self.SoundTraceI>2 then self.SoundTraceI=0 end
        if upt > 350 then
            local coeff =
                1-math.min(
                    (math.min(130,leftt)/130+math.min(130,rightt)/130)/2,
                    math.Clamp((leftst-10)/40,0,1),
                    math.Clamp((rightst-10)/40,0,1)
                )
                --print(math.Clamp((leftst-10)/40,0,1))
            --print(Format("%02d %.2f %02d %.2f",leftst,math.Clamp((leftst-30)/20,0,1),rightst,)
            --[[ if leftst < 30 or rightst < 30 then
                LocalPlayer():ChatPrint(Format("I AM ON A STREET STATION, %.2f",coeff))
            elseif coeff > 1.3 then
                LocalPlayer():ChatPrint(Format("I AM ON A STREET, %.2f",coeff))
            else
                LocalPlayer():ChatPrint(Format("I AM ON A STREET WITH WALLS, %.2f",coeff))
            end--]]
            self.TunnelCoeff = math.Clamp(self.TunnelCoeff+(              0-self.TunnelCoeff)*self.DeltaTime*4,0,1)
            self.StreetCoeff = math.Clamp(self.StreetCoeff+((0.8+coeff*0.2)-self.StreetCoeff)*self.DeltaTime*4,0,1)
            self.Street = 1
        else
            local coeff =
                1-math.min(
                    math.Clamp((leftt-80)/40,0,1)+math.Clamp((rightt-80)/40,0,1)/2,
                    (math.Clamp((leftst-10)/40,0,1)+math.Clamp((rightst-10)/40,0,1))/2
                    --,
                )--(math.Clamp((leftst-30)/20,0,1)+math.Clamp((rightst-30)/20,0,1))*0.6
            --[[ if (leftst < 30 or rightst < 30) and coeff > 1.2 then
                LocalPlayer():ChatPrint(Format("I AM ON A STATION L%.2f R%.2f C:%.2f",leftt/55,rightt/55,coeff))
            elseif coeff > 1.3 then
                LocalPlayer():ChatPrint(Format("I AM IN A BIG TUNNEL L%.2f R%.2f C:%.2f",leftt/55,rightt/55,coeff))
            else
                LocalPlayer():ChatPrint(Format("I AM IN A TUNNEL L%.2f R%.2f C:%.2f",leftt/55,rightt/55,coeff))
            end--]]
            self.TunnelCoeff = math.Clamp(self.TunnelCoeff+((0.4+coeff*0.6)-self.TunnelCoeff)*self.DeltaTime*4,0,1)
            self.StreetCoeff = math.Clamp(self.StreetCoeff+((0.5-math.max(0,self.TunnelCoeff-0.5))-self.StreetCoeff)*self.DeltaTime*4,0,1)
            self.Street = 0
        end
    end
    if not self.HandleMouseInput and self.ButtonMap then
        if self == LocalPlayer().InMetrostroiTrain then
            for kp,pan in pairs(self.ButtonMap) do
                if not self:ShouldDrawPanel(kp) then continue end
                --If player is looking at this panel
                if pan.mouse and not pan.outside and pan.aimX and pan.aimY then
                    local aimX,aimY = math.floor(math.Clamp(pan.aimX,0,pan.width)),math.floor(math.Clamp(pan.aimY,0,pan.height))
                    if pan.OldAimX ~= aimX or pan.OldAimY ~= aimY then
                        net.Start("metrostroi-mouse-move",true)
                            net.WriteEntity(self)
                            net.WriteString(kp)
                            net.WriteFloat(aimX)
                            net.WriteFloat(aimY)
                        net.SendToServer()
                        pan.OldAimX = aimX
                        pan.OldAimY = aimY
                    end
                end
            end
        end
    end

    if self.ButtonMap and (not self.LastCheck or RealTime()-self.LastCheck > 0.5) then
        self.LastCheck = RealTime()
        local screenshotMode = C_ScreenshotMode:GetBool()
        if self.ScreenshotMode ~= screenshotMode then
            self:SetLOD(screenshotMode and 0 or -1)
            for k,cent in pairs(self.ClientEnts) do
                if IsValid(cent) then
                    cent:SetLOD(screenshotMode and 0 or -1)
                end
            end
            self.ScreenshotMode = screenshotMode
        end
        for k in pairs(self.HiddenLamps) do
            self.HiddenLamps[k] = false
        end
        for k,v in pairs(self.ClientProps) do
            if not v.pos then continue end
            local cent = self.ClientEnts[k]

            if (v.nohide or screenshotMode) then
                if not IsValid(cent) then
                    self:SpawnCSEnt(k,true)
                end
                continue
            end
            local hidden = not self:ShouldDrawClientEnt(k,v)
            if IsValid(cent) and hidden then
                cent:Remove()
                self.ClientEnts[k] = nil
            elseif not IsValid(cent) and not hidden then
                self:SpawnCSEnt(k,true)
            end
            if v.lamps and hidden then
                for i,k in ipairs(v.lamps) do
                    self:SetLightPower(k,false)
                    self.HiddenLamps[k] = true
                end
            end
        end
        for k,v in pairs(self.Sounds) do
            if type(v) ~= "function" and type(v) ~= "table" and not self.Sounds.isloop[k] and (not IsValid(v) or v:GetState() == GMOD_CHANNEL_STOPPED) then
                self:DestroySound(v)
                self.Sounds[k] = nil
            end
        end
        for k,v in pairs(self.ButtonMap) do
            if not v.pos then continue end

            if not v.hide or (v.nohide or screenshotMode) then
                self.HiddenPanelsDistance[k] = v.screenHide
                continue
            end
            self.HiddenPanelsDistance[k] = not self:ShouldDrawClientEnt(k,self.ButtonMap[k])
        end
    end

    if self.AutoAnims && self.AutoAnimNames then
        local aAnims = self.AutoAnims
        local aAnimNames = self.AutoAnimNames
        local hidden = self.Hidden
        for i=1, #aAnims do
            if not aAnimNames[i] or not hidden[aAnimNames[i]] then
                aAnims[i](self)
            end
        end
    end
    if self.Lights and self.GlowingLights then
        for id, light in pairs(self.GlowingLights) do
            if light.Update then
                light:Update()
            end
        end
    end
    -- Update passengers
    if self.RenderClientEnts and self.PassengerEnts then
        local stucked = self.PassengerEntsStucked
        for i,v in ipairs(self.LeftDoorPositions) do
            if self:GetPackedBool("DoorLS"..i) and not IsValid(stucked[i]) then
                local ent = ClientsideModel(table.Random(self.PassengerModels),RENDERGROUP_OPAQUE)
                ent:SetPos(self:LocalToWorld(Vector(v.x,v.y,self:GetStandingArea().z)))
                ent:SetAngles(self:LocalToWorldAngles(Angle(0,v.y < 0 and -90 or 90,0)))
                ent:SetSkin(math.floor(ent:SkinCount()*math.random()))
                ent:SetModelScale(0.98 + (-0.02+0.04*math.random()),0)
                ent:SetParent(self)
                stucked[i] = ent
                if math.random() > 0.99 then
                    self:PlayOnceFromPos("PassStuckL"..i,"subway_trains/common/door/pass_stAAAck.mp3",5,0.9+math.random()*0.2,150,400,v)
                elseif math.random() > 0.95 then
                    self:PlayOnceFromPos("PassStuckL"..i,"subway_trains/common/door/tom.mp3",5,0.9+math.random()*0.2,150,400,v)
                elseif ent:GetModel():find("models/metrostroi/passengers/f") then
                    self:PlayOnceFromPos("PassStuckL"..i,"subway_trains/common/door/pass_stuck.mp3",5,1.6+math.random()*0.2,150,400,v)
                else
                    self:PlayOnceFromPos("PassStuckL"..i,"subway_trains/common/door/pass_stuck.mp3",5,0.9+math.random()*0.2,150,400,v)
                end
            elseif not self:GetPackedBool("DoorLS"..i) and IsValid(stucked[i]) then
                SafeRemoveEntity(stucked[i])
            end
        end
        for i,v in ipairs(self.RightDoorPositions) do
            if self:GetPackedBool("DoorRS"..i) and not IsValid(stucked[-i]) then
                local ent = ClientsideModel(table.Random(self.PassengerModels),RENDERGROUP_OPAQUE)
                ent:SetPos(self:LocalToWorld(Vector(v.x,v.y,self:GetStandingArea().z)))
                ent:SetAngles(self:LocalToWorldAngles(Angle(0,v.y < 0 and -90 or 90,0)))
                ent:SetSkin(math.floor(ent:SkinCount()*math.random()))
                ent:SetModelScale(0.98 + (-0.02+0.04*math.random()),0)
                ent:SetParent(self)
                stucked[-i] = ent
                if math.random() > 0.99 then
                    self:PlayOnceFromPos("PassStuckR"..i,"subway_trains/common/door/pass_stAAAck.mp3",5,0.9+math.random()*0.2,150,400,v)
                elseif math.random() > 0.95 then
                    self:PlayOnceFromPos("PassStuckR"..i,"subway_trains/common/door/tom.mp3",5,0.9+math.random()*0.2,150,400,v)
                elseif ent:GetModel():find("models/metrostroi/passengers/f") then
                    self:PlayOnceFromPos("PassStuckR"..i,"subway_trains/common/door/pass_stuck.mp3",5,1.6+math.random()*0.2,150,400,v)
                else
                    self:PlayOnceFromPos("PassStuckR"..i,"subway_trains/common/door/pass_stuck.mp3",5,0.9+math.random()*0.2,150,400,v)
                end
            elseif not self:GetPackedBool("DoorRS"..i) and IsValid(stucked[-i]) then
                SafeRemoveEntity(stucked[-i])
            end
        end
        if #self.PassengerEnts ~= self:GetNW2Float("PassengerCount") then
            -- Passengers go out
            while #self.PassengerEnts > self:GetNW2Float("PassengerCount") do
                local ent = self.PassengerEnts[#self.PassengerEnts]
                table.remove(self.PassengerPositions,#self.PassengerPositions)
                table.remove(self.PassengerEnts,#self.PassengerEnts)
                ent:Remove()
            end
            -- Passengers go in
            while #self.PassengerEnts < self:GetNW2Float("PassengerCount") do
                local min,max = self:GetStandingArea()
                local pos = min + Vector((max.x-min.x)*math.random(),(max.y-min.y)*math.random(),(max.z-min.z)*math.random())

                --local ent = ents.CreateClientProp("models/metrostroi/81-717/reverser.mdl")
                --ent:SetModel(table.Random(self.PassengerModels))
                local ent = ClientsideModel(table.Random(self.PassengerModels),RENDERGROUP_OPAQUE)
                ent:SetPos(self:LocalToWorld(pos))
                ent:SetAngles(Angle(0,math.random(0,360),0))
                --[[
                hook.Add("MetrostroiBigLag",ent,function(ent)
                    ent:SetPos(self:LocalToWorld(pos))
                    ent:SetAngles(Angle(0,math.random(0,360),0))
                    --if ent.Spawned then hook.Remove("MetrostroiBigLag",ent) end
                    --ent.Spawned = true
                end)]]
                ent:SetSkin(math.floor(ent:SkinCount()*math.random()))
                ent:SetModelScale(0.98 + (-0.02+0.04*math.random()),0)
                ent:SetParent(self)
                table.insert(self.PassengerPositions,pos)
                table.insert(self.PassengerEnts,ent)
            end
        end
    end
    for k,v in pairs(self.CustomThinks) do if k ~= "BaseClass" then v(self) end end
end
function ENT:BlockInput(block)
    if IsValid(LocalPlayer().InMetrostroiTrain) then
        if self ~= LocalPlayer().InMetrostroiTrain then
            block = false
        end
    end
    if block and not self.GUILocker then
        gui.EnableScreenClicker(true)
        self.GUILocker = vgui.Create("DPanel")

        self.GUILocker:SetPos(0,0)
        self.GUILocker:SetSize(ScrW(),ScrH())
        self.GUILocker:SetZPos(-32767)

        self.GUILocker.Paint = function() end

        self.GUILocker.Focus = self

        self.GUILocker.Think = function(panel)
            if panel.Focus ~= vgui.GetKeyboardFocus() then
                panel.Focus = vgui.GetKeyboardFocus()
                if IsValid(panel.Focus) then
                    self.GUILocker:SetCursor("")
                else
                    input.SetCursorPos( ScrW()/2, ScrH()/2)
                    self.GUILocker:SetCursor("blank")
                end
            end
        end
        self.GUILocker.OnCursorMoved = function(panel,cursorX,cursorY )
            if self.GUILocker.LastX ~= cursorX or self.GUILocker.LastY ~= cursorY then
                if not IsValid(vgui.GetKeyboardFocus()) then
                    local x,y = ScrW()/2, ScrH()/2
                    input.SetCursorPos(x,y)
                    net.Start("metrostroi-mouse-move",true)
                        net.WriteEntity(self)
                        net.WriteString("")
                        net.WriteFloat((cursorX-x)/(ScrW()/2))
                        net.WriteFloat((cursorY-y)/(ScrH()/2))
                    net.SendToServer()
                end
                self.GUILocker.LastX = cursorX
                self.GUILocker.LastY = cursorY
            end
            --end
        end
        self.GUILocker:RequestFocus()
        self.GUILocker:SetKeyboardInputEnabled(false)
        self.GUILocker:MoveToBack(true)
        self.GUILocker:SizeToChildren()
    elseif not block and self.GUILocker then
        self.GUILocker:Remove()
        self.GUILocker = nil
        gui.EnableScreenClicker(false)
    end
end

function ENT:HandleMouse(handle)
    if self.HandleMouseInput ~= handle then
        self.HandleMouseInput = handle
        self:BlockInput(self.HandleMouseInput)
    end
end

local function compensateSeat(val)
    local valAbs = math.abs(val)
    if valAbs < 10 then return 1 end
    if valAbs > 45 then return 0 end

    local sign = val < 0 and -1 or 1
    return 1-math.Clamp((valAbs-10)/6,0,2)+(math.Clamp((valAbs-30)/10,0,1))+(math.Clamp((valAbs-40)/5,0,1))
end

local OldTrainHandle,OldSeat
hook.Add("Think","metrostroi_mouse_handle",function()
    local train, outside = isValidTrainDriver(LocalPlayer())
    if outside then train = nil end

    if OldTrainHandle ~= train then
        if IsValid(OldTrainHandle) and OldTrainHandle.BlockInput then OldTrainHandle:BlockInput(false) end
        if IsValid(train) and train.BlockInput then train:BlockInput(train.HandleMouseInput) end
        if IsValid(train) then
            OldSeat = LocalPlayer():GetVehicle()
            --[=[train.CamAnglesComp = Angle(0,0,0)
            train.OldAng = false
            --OldSeat.CalcAbsolutePosition = function(...) return ... end
            if not OldSeat.OldCalcAbsolutePosition then
                OldSeat.OldCalcAbsolutePosition = OldSeat.CalcAbsolutePosition
            end
            OldSeat.CalcAbsolutePosition = function(ent,...)
                --[[local target_ang = Angle(0,0,0)
                local train = ent:GetNW2Entity("TrainEntity")
                if not IsValid(train) then return end
                target_ang:RotateAroundAxis(ent:GetAngles():Forward(),-train.CamAng.p)
                target_ang:RotateAroundAxis(ent:GetAngles():Up(),train.CamAng.y)
                target_ang:RotateAroundAxis(ent:GetAngles():Right(),train.CamAng.r)
                train.CamAnglesComp = target_ang
                print(target_ang)]]
                return ent:OldCalcAbsolutePosition(...)
            end
            print(OldSeat.OnAngleChangeID)--]=]
        elseif IsValid(OldSeat) then
            OldSeat.CalcAbsolutePosition = OldSeat.OldCalcAbsolutePosition or OldSeat.CalcAbsolutePosition
            OldSeat.OldCalcAbsolutePosition = nil
            OldSeat = nil
        end
        OldTrainHandle = train
    end
end)
--[[hook.Add("PlayerEnteredVehicle","metrostroi_mouse_handle",function(ply,veh)
    local train = veh:GetNW2Entity("TrainEntity")
    if IsValid(train) then
        train.CamAnglesComp = Angle(0,0,0)
        train.OldAng = false
        if train.BlockInput then train:BlockInput(train.HandleMouseInput) end
    end
end)
hook.Add("PlayerEnteredVehicle","metrostroi_mouse_handle",function(ply,veh)
    local train = veh:GetNW2Entity("TrainEntity")
    if IsValid(train) then
        train.CamAnglesComp = Angle(0,0,0)
        train.OldAng = false
        if train.BlockInput then train:BlockInput(train.HandleMouseInput) end
    end
end)]]
--[[ hook.Add("PlayerEnteredVehicle","metrostroi_mouse_handle",function(ply,veh)
    local train = veh:GetNW2Entity("TrainEntity")
    if IsValid(train) and train.BlockInput then
        train:BlockInput(train.HandleMouseInput)
    end
end)--]]
--------------------------------------------------------------------------------
-- Various rendering shortcuts for trains
--------------------------------------------------------------------------------
function ENT:DrawCircle(cx,cy,radius)
    local step = 2*math.pi/12
    local vertexBuffer = { {}, {}, {} }

    for i=1,12 do
        vertexBuffer[1].x = cx + radius*math.sin(step*(i+0))
        vertexBuffer[1].y = cy + radius*math.cos(step*(i+0))
        vertexBuffer[2].x = cx
        vertexBuffer[2].y = cy
        vertexBuffer[3].x = cx + radius*math.sin(step*(i+1))
        vertexBuffer[3].y = cy + radius*math.cos(step*(i+1))
        surface.DrawPoly(vertexBuffer)
    end
end

--------------------------------------------------------------------------------
-- Schedule Drawing
--
-- Reference: http://static.diary.ru/userdir/1/0/4/7/1047/28088395.jpg
--------------------------------------------------------------------------------
local function AddZero( s )
    if #s == 0 then
        return "00"
    elseif #s == 1 then
        return "0" .. s
    else
        return s
    end
end

local function HoursFromStamp( stamp )
    return AddZero(tostring(math.floor(stamp/3600)%24))
end

local function MinutesFromStamp( stamp )
    return AddZero(tostring(math.floor(stamp/60)%60))
end

local function SecondsFromStamp( stamp )
    return AddZero(tostring(stamp%60))
end

surface.CreateFont( "Schedule_Hand", {
    font = "Monotype Corsiva",
    size = 30,
    weight = 600
})
surface.CreateFont( "Schedule_Hand_Small", {
    font = "Monotype Corsiva",
    size = 18,
    weight = 600
})
surface.CreateFont( "Schedule_Machine", {
    font = "Arial",
    size = 22,
    weight = 500
})
surface.CreateFont( "Schedule_Machine_Small", {
    font = "Arial",
    size = 16,
    weight = 600
})

local DrawRect = surface.DrawRect
local DrawTextHand = function(txt, x, y, col)
    draw.SimpleText(txt, "Schedule_Hand", x, y, Color(0,15*col.y,85*col.z), 0, 0)
end
local DrawTextHandSmall = function(txt, x, y, col)
    draw.SimpleText(txt, "Schedule_Hand_Small", x, y, Color(0,15*col.y,85*col.z), 0, 0)
end
local DrawTextMachine = function(txt, x, y)
    draw.SimpleText(txt, "Schedule_Machine", x, y, Color(0,0,0), 0, 0)
end
local DrawTextMachineSmall = function(txt, x, y)
    draw.SimpleText(txt, "Schedule_Machine_Small", x, y, Color(0,0,0), 0, 0)
end

local function FineStationName(st)
    local StT = string.Explode(" ",st)
    local str = ""
    if #StT > 1 then
        str = StT[1][1]..". "..table.concat(StT," ",2)
    else
        str = st
    end
    return str
end
-- Placeholder code, to be removed when schedule system is in place
local Schedule = {
    stations = {
        {"Station 1", os.time() + 20},
        {"Station 2", os.time() + 46},
        {"Station 3", os.time() + 80},
        {"Station 4", os.time() + 95},
        {"Station 5", os.time() + 120}
    },
    total = 2000,
    interval = 300,
    routenumber = math.random(100,999),
    pathnumber = math.random(100,999)
}

local col1w = 80 -- 1st Column width
local col2w = 32 -- The other column widths
local rowtall = 30 -- Row height, includes -only- the usable space and not any lines
local rowtall2 = rowtall*2 -- Helper

local defaultlight = Vector(0.8,0.8,0.8) -- Light to be used when cabinlights are on
function ENT:DrawSchedule(panel)
    local w = panel.width
    local h = panel.height

    local light = defaultlight
    local cabinlights = self:GetPackedBool(58)
    if not cabinlights then
        light = render.GetLightColor(self:LocalToWorld(Vector(430,0,26))) -- GetLightColor is pretty shit but it works
    end

    --Background
    surface.SetDrawColor(Color(255 * light.x, 253 * light.y, 208 * light.z))
    DrawRect(0,0,w,h)

    --Lines
    surface.SetDrawColor(Color(0,0,0))

    --Horisontal lines
    DrawRect(0,0,1,h)
    DrawRect(1 + col1w,0,1,h)
    DrawRect(1 + col1w + 1 + col2w,rowtall2+2,1,h-rowtall2-2)
    DrawRect(1 + col1w + 1 + col2w + 1 + col2w,rowtall2+2,1,h-rowtall2-2)
    DrawRect(1 + col1w + 1 + col2w + 1 + col2w + 1 + col2w,0,1,h)

    --Vertical lines
    DrawRect(0,0,w,1)
    DrawRect(1 + col1w,rowtall+1,w - col1w - 1,1)
    DrawRect(1 + col1w,rowtall2+2,w - col1w - 1,1)
    for i=(rowtall+1)*3,h,rowtall+1 do
        DrawRect(0,i,w,1)
    end

    -- HACK get schedule from train
    local N = self:GetNW2Int("_schedule_N")
    Schedule = {
        stations = {},
        total = math.floor(self:GetNW2Int("_schedule_duration")/5+0.5)*5,
        interval = self:GetNW2Int("_schedule_interval"),
        routenumber = self:GetNW2Int("_schedule_id"),
        pathnumber = self:GetNW2Int("_schedule_path"),
    }
    for i=1,N do
        Schedule.stations[i] = {
            self:GetNW2String("_schedule_"..i.."_5"),
            math.floor(self:GetNW2Int("_schedule_"..i.."_3")*60/5)*5
        }
    end

    --Text
    local t = Schedule

    --Top info
    DrawTextMachine("М №", 3, 3)
    DrawTextHand(t.routenumber, 42, -2, light)

    DrawTextMachine("П №", 3, rowtall*2 + 3)
    DrawTextHand(t.pathnumber, 42, rowtall*2 - 2, light)

    DrawTextMachineSmall("ВРЕМЯ", col1w + 5, 1, light)
    DrawTextMachineSmall("ХОДА", col1w + 5, 15, light)
    DrawTextHand(MinutesFromStamp(t.total), w - 50, 1, light)
    DrawTextHandSmall(SecondsFromStamp(t.total), w - 25, 5, light)

    DrawTextMachineSmall("ИНТ", col1w + 5, rowtall + 8)
    DrawTextHand(MinutesFromStamp(t.interval), w - 50, rowtall, light)
    DrawTextHandSmall(SecondsFromStamp(t.interval), w - 25, rowtall + 4, light)

    DrawTextMachineSmall("ЧАС", col1w + 4, rowtall*2    + 8)
    DrawTextMachineSmall("МИН", col1w + col2w + 5, rowtall*2 + 8)
    DrawTextMachineSmall("СЕК", col1w + col2w*2 + 8, rowtall*2 + 8)

    --Schedule rows
    local lasthour = -1
    for i,v in pairs(t.stations) do
        local y = ((rowtall+1)*3+2) + (i-1)*(rowtall+1) -- Uhh..

        local st = FineStationName(v[1])
        surface.SetFont( "Schedule_Machine_Small" )
        local width = select(1, surface.GetTextSize(st))

        local szf = math.ceil(width/80)-1
        if szf > 0 then
            szf = math.ceil(#st/8)-1

            for i1 = 0,szf do
                DrawTextMachineSmall(st:Replace("'",""):sub(i1*8+1,8 + i1*8)..(szf ~= i1 and "-" or ""), 3, y + 6 -6 + 12/szf*i1) -- Stationname
            end
        else
            DrawTextMachineSmall(st, 3, y + 6) -- Stationname
        end

        local hours = HoursFromStamp(v[2])
        local minutes = MinutesFromStamp(v[2])
        local seconds = SecondsFromStamp(v[2])

        if hours ~= lasthour then -- Only draw hours if they've changed
            lasthour = hours

            DrawTextHand(hours, col1w + 3, y, light) -- Hours
        end

        DrawTextHand(minutes, col1w + col2w + 5, y, light) -- Minutes
        DrawTextHand(seconds, col1w + col2w + col2w + 5, y, light) -- Seconds
    end
end

--------------------------------------------------------------------------------
-- Default rendering function
--------------------------------------------------------------------------------
function ENT:Draw()

    -- Draw model
    self:DrawModel()
end


function ENT:DrawOnPanel(index,func,overr)
    if not overr and not self:ShouldDrawPanel(index) then return end
    local panel = self.ButtonMapMatrix and self.ButtonMapMatrix[index] or self.ButtonMap[index]
    cam.Start3D2D(self:LocalToWorld(panel.pos),self:LocalToWorldAngles(panel.ang),panel.scale)
        func(panel)
    cam.End3D2D()
end

function ENT:DrawRTOnPanel(index,rt,overr)
    if not overr and not self:ShouldDrawPanel(index) then return end
    local panel = self.ButtonMapMatrix[index] or self.ButtonMap[index]
    cam.Start3D2D(self:LocalToWorld(panel.pos),self:LocalToWorldAngles(panel.ang),panel.scale)
        surface.SetMaterial(rt.mat)
        --surface.DrawTexturedRect(0,0,panel.width,panel.height)
        surface.DrawTexturedRectRotated(panel.width/2,panel.height/2,panel.width,panel.height,0)
    cam.End3D2D()
end


--------------------------------------------------------------------------------
-- Animation function
--------------------------------------------------------------------------------
function ENT:Animate(clientProp, value, min, max, speed, damping, stickyness)
    local id = clientProp
    local anims = self.Anims
    if not anims[id] then
        anims[id] = {}
        anims[id].val = value
        anims[id].value = min + (max-min)*value
        anims[id].V = 0.0
        anims[id].block = false
        anims[id].stuck = false
        anims[id].P = value
    end
    if self.Hidden[id] or self.Hidden.anim[id] then return 0 end
    if anims[id].Ignore then
        if RealTime()-anims[id].Ignore < 0 then
            return anims[id].value
        else
            anims[id].Ignore = nil
        end
    end
    local val = anims[id].val
    if value ~= val then
        anims[id].block = false
    end
    if anims[id].block then
        if anims[id].reload and IsValid(self.ClientEnts[clientProp]) then
            self.ClientEnts[clientProp]:SetPoseParameter("position",anims[id].value)
            anims[id].reload = false
        end
        return anims[id].value--min + (max-min)*anims[id].val
    end
    --if self["_anim_old_"..id] == value then return self["_anim_old_"..id] end
    -- Generate sticky value
    if stickyness and damping then
        if (math.abs(anims[id].P - value) < stickyness) and (anims[id].stuck) then
            value = anims[id].P
            anims[id].stuck = false
        else
            anims[id].P = value
        end
    end
    local dT = FrameTime()--self.DeltaTime
    if damping == false then
        local dX = speed * dT
        if value > val then
            val = val + dX
        end
        if value < val then
            val = val - dX
        end
        if math.abs(value - val) < dX then
            val = value
            anims[id].V = 0
        else
            anims[id].V = dX
        end
    else
        -- Prepare speed limiting
        local delta = math.abs(value - val)
        local max_speed = 1.5*delta / dT
        local max_accel = 0.5 / dT

        -- Simulate
        local dX2dT = (speed or 128)*(value - val) - anims[id].V * (damping or 8.0)
        if dX2dT >  max_accel then dX2dT =  max_accel end
        if dX2dT < -max_accel then dX2dT = -max_accel end

        anims[id].V = anims[id].V + dX2dT * dT
        if anims[id].V >  max_speed then anims[id].V =  max_speed end
        if anims[id].V < -max_speed then anims[id].V = -max_speed end

        val = math.max(0,math.min(1,val + anims[id].V * dT))

        -- Check if value got stuck
        if (math.abs(dX2dT) < 0.001) and stickyness and (dT > 0) then
            anims[id].stuck = true
        end
    end
    local retval = min + (max-min)*val
    if IsValid(self.ClientEnts[clientProp]) then
        self.ClientEnts[clientProp]:SetPoseParameter("position",retval)
    end
    if math.abs(anims[id].V) == 0 and math.abs(val-value) == 0 and not anims[id].stuck then
        anims[id].block = true
    end

    anims[id].val = val
    anims[id].oldival = value
    anims[id].oldspeed = speed
    anims[id].value = retval
    return retval
end
function ENT:AnimateFrom(clientProp,from,min,max)
    if not self.Anims[from] then return 0 end
    local val = Lerp(self.Anims[from].value,min or 0,max or 1)
    if IsValid(self.ClientEnts[clientProp]) then
        self.ClientEnts[clientProp]:SetPoseParameter("position",val)
    end
    if not self.Anims[clientProp] then self.Anims[clientProp] = {} end
    self.Anims[clientProp].value = value
    return val
end

function ENT:ShowHide(clientProp, value, over)
    if self.Hidden.override[clientProp] then return end
    --if IsValid(self.ClientEnts[clientProp]) then
    if value == true and (self.Hidden[clientProp] or over) then
        self.Hidden[clientProp] = false
        if not IsValid(self.ClientEnts[clientProp]) and self:SpawnCSEnt(clientProp) then
            self.UpdateRender = true
        end
        --self.ClientEnts[clientProp]:SetRenderMode(RENDERMODE_NORMAL)
        --self.ClientEnts[clientProp]:SetColor(Color(255,255,255,255))
        --self.Hidden[clientProp] = false
        return true
    elseif value ~= true and (not self.Hidden[clientProp] or over) then
        if IsValid(self.ClientEnts[clientProp]) then
            self.ClientEnts[clientProp]:Remove()
            self.UpdateRender = true
        end
        self.Hidden[clientProp] = true
        --self.ClientEnts[clientProp]:SetRenderMode(RENDERMODE_NONE)
        --self.ClientEnts[clientProp]:SetColor(Color(0,0,0,0))
        --self.Hidden[clientProp] = true
        return true
    end
        --self.HiddenQuele[clientProp] = nil
    --else
    --end
end

function ENT:HideButton(clientProp, value)
    self.Hidden.button[clientProp] = value
end
function ENT:ShowHideSmooth(clientProp, value,color)
    if self.Hidden.override[clientProp] then return value end
    if not IsValid(self.ClientEnts[clientProp]) and self.SmoothHide[clientProp] then self.SmoothHide[clientProp] = 0 end
    if self.SmoothHide[clientProp] and (self.SmoothHide[clientProp] == value and not color) then return value end
    self.SmoothHide[clientProp] = value
    self.Hidden.anim[clientProp] = value == 0

    if value > 0 and not IsValid(self.ClientEnts[clientProp]) then
        if self:ShowHide(clientProp,true) then self.SmoothHide[clientProp] = nil end
    end
    if value == 0 and IsValid(self.ClientEnts[clientProp]) then
        if self:ShowHide(clientProp,false) then self.SmoothHide[clientProp] = nil end
    end
    if IsValid(self.ClientEnts[clientProp]) then
        local v = self.ClientPropsOv and self.ClientPropsOv[clientProp] or self.ClientProps[clientProp]
        self.ClientEnts[clientProp]:SetRenderMode(RENDERMODE_TRANSALPHA)
        if color then
            self.ClientEnts[clientProp]:SetColor(ColorAlpha(color,value*255))
        else
            self.ClientEnts[clientProp]:SetColor(ColorAlpha(v.color or color_white,value*255))
        end
    end
    return value
end
function ENT:ShowHideSmoothFrom(clientProp,from)
    self:ShowHideSmooth(clientProp,self.SmoothHide[from] or 0)
end
local digit_bitmap = {
    [1] = { 0,0,1,0,0,1,0 },
    [2] = { 1,0,1,1,1,0,1 },
    [3] = { 1,0,1,1,0,1,1 },
    [4] = { 0,1,1,1,0,1,0 },
    [5] = { 1,1,0,1,0,1,1 },
    [6] = { 1,1,0,1,1,1,1 },
    [7] = { 1,0,1,0,0,1,0 },
    [8] = { 1,1,1,1,1,1,1 },
    [9] = { 1,1,1,1,0,1,1 },
    [0] = { 1,1,1,0,1,1,1 },
}

local segment_poly = {
    [1] = {
        { x = 0,    y = 0 },
        { x = 100,  y = 0 },
        { x =  80,  y = 20 },
        { x =  20,  y = 20 },
    },
    [2] = {
        { x =  20,  y = 0 },
        { x =  80,  y = 0 },
        { x = 100,  y = 20 },
        { x =   0,  y = 20 },
    },
    [3] = {
        { x =  0,  y = 0 },
        { x = 20,  y = 20 },
        { x = 20,  y = 80 },
        { x =  0,  y = 100 },
    },
    [4] = {
        { x =  0,  y = 20 },
        { x = 20,  y = 0 },
        { x = 20,  y = 100 },
        { x =  0,  y = 80 },
    },
    [5] = {
        { x = 0,  y = 12 },
        { x = 20,  y = 0 },
        { x = 80,  y = 0 },
        { x = 100,  y = 12 },
        { x = 80,  y = 24 },
        { x = 20,  y = 24 },
    },
}

local polys = {}
function ENT:DrawSegment(i,x,y,scale_x,scale_y)
    if not polys[i] then polys[i] = {} end
    if not polys[i][k] then
        for k,v in pairs(segment_poly[i]) do
            polys[i][k] = {
                x = (v.x*scale_x) + x,
                y = (v.y*scale_y) + y,
            }
        end
    end

    surface.SetDrawColor(Color(100,255,0,255))
    draw.NoTexture()
    surface.DrawPoly(polys[i])
end

function ENT:DrawDigit(cx,cy,digit,scalex,scaley,thickness)
    scalex = scalex or 1
    scaley = scaley or scalex
    thickness = thickness or 1
    local bitmap = digit_bitmap[digit]
    if not bitmap then return end

    local sx = 0.9*scalex*thickness
    local sy = 0.9*scaley*thickness
    local dx = scalex
    local dy = scaley

    if bitmap[1] == 1 then self:DrawSegment(1,cx+5*dx,cy,           sx,sy)  end
    if bitmap[2] == 1 then self:DrawSegment(3,cx,cy+10*dy,          sx,sy)  end
    if bitmap[3] == 1 then self:DrawSegment(4,cx+80*dx,cy+10*dy,    sx,sy)  end
    if bitmap[4] == 1 then self:DrawSegment(5,cx+5*dx,cy+95*dy,     sx,sy)  end
    if bitmap[5] == 1 then self:DrawSegment(3,cx,cy+110*dy,         sx,sy)  end
    if bitmap[6] == 1 then self:DrawSegment(4,cx+80*dx,cy+110*dy,   sx,sy)  end
    if bitmap[7] == 1 then self:DrawSegment(2,cx+5*dx,cy+190*dy,    sx,sy)  end
end



--------------------------------------------------------------------------------
-- Get train acceleration at given position in train
--------------------------------------------------------------------------------
function ENT:GetTrainAccelerationAtPos(pos)
    local localAcceleration = self:GetTrainAcceleration()
    local angularVelocity = self:GetTrainAngularVelocity()

    return localAcceleration - angularVelocity:Cross(angularVelocity:Cross(pos*0.01905))
end


--------------------------------------------------------------------------------
-- Look into mirrors hook
--------------------------------------------------------------------------------
--[[hook.Add("InputMouseApply", "Metrostroi_TrainView", function(cmd,x,y,ang)
    local seat = LocalPlayer():GetVehicle()
    if (not seat) or (not seat:IsValid()) then
        return
    end
    local train = seat:GetNW2Entity("TrainEntity")
    if (not train) or (not train:IsValid()) then
        return
    end
    local target_ang = Angle(0,0,0)
    target_ang:RotateAroundAxis(seat:GetAngles():Forward(),-ang.p)
    target_ang:RotateAroundAxis(seat:GetAngles():Up(),ang.y)
    target_ang:RotateAroundAxis(seat:GetAngles():Right(),ang.r)
    train.CamAnglesComp = target_ang
    train.CamAng = ang
end)]]

hook.Add("CalcVehicleView", "Metrostroi_TrainView", function(seat,ply,tbl)
    local train = ply.InMetrostroiTrain
    if not IsValid(train) then
        return
    end

    --local hack = string.find(train:GetClass(),"81")
    --local dy = 0
    --if hack then dy = 3 end

    --[[-- Get acceleration in the train
    local headPos = train:WorldToLocal(pos)
    local acceleration = train:GetTrainAccelerationAtPos(headPos)
    train.Acceleration = train.Acceleration or Vector(0,0,0)
    train.Acceleration = train.Acceleration + 0.5*(acceleration - train.Acceleration)*train.DeltaTime
    if train.Acceleration:Length() > 100 then train.Acceleration = Vector(0,0,0) end

    -- Calculate direction
    local direction = train.Acceleration:GetNormalized()
    -- Calculate visual offset
    local a = train.Acceleration:Length()
    local factor = a * math.exp(-0.05*a)
    local offset = 4 * direction * factor

    print(train.Acceleration)
    -- Apply offset
    return {
        origin = train:LocalToWorld(headPos + 0.1*offset),
        angles = ang + Angle(offset.x,0,0),
    }]]--

    if seat:GetThirdPersonMode() and train.MirrorCams[1] then
        local trainAng = tbl.angles - train:GetAngles()
        if trainAng.y >  180 then trainAng.y = trainAng.y - 360 end
        if trainAng.y < -180 then trainAng.y = trainAng.y + 360 end
        if trainAng.y > 0 then
            train.CamPos =  train:LocalToWorld(train.MirrorCams[1])
            train.CamAngles =  train:LocalToWorldAngles(train.MirrorCams[2])
            return {
                origin = train.CamPos,
                angles = train.CamAngles,
                fov = train.MirrorCams[3],
            }
        else
            train.CamPos =  train:LocalToWorld(train.MirrorCams[4])
            train.CamAngles =  train:LocalToWorldAngles(train.MirrorCams[5])
            return {
                origin = train.CamPos,
                angles = train.CamAngles,
                fov = train.MirrorCams[6],
            }
        end
    elseif train.CurrentCamera > 0 and train.Cameras[train.CurrentCamera] then
        local camera = train.Cameras[train.CurrentCamera]
        train.CamPos = train:LocalToWorld(camera[1])
        local tFov = tbl.fov/C_FovDesired:GetFloat()*C_CabFOV:GetFloat()

        return {
            origin = train.CamPos,
            angles = tbl.angles,--+train:LocalToWorldAngles(camera[2]),
            fov = tFov,
        }
    else

        train.CamPos = train:LocalToWorld(train:WorldToLocal(tbl.origin)+Vector(train.HeadAcceleration,0,C_CabZ:GetFloat()))
        local tFov = tbl.fov/C_FovDesired:GetFloat()*C_CabFOV:GetFloat()
        return {
            origin = train.CamPos,
            angles = tbl.angles,--target_ang+train.CamAnglesComp,
            fov = tFov,
        }
    end
    return
end)




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

local function findAimButton(ply,train)
    local panel,panelDist = nil,1e9
    for kp,pan in pairs(train.ButtonMap) do
        if not train:ShouldDrawPanel(kp) then continue end
        --If player is looking at this panel
        if pan.aimedAt and (pan.buttons or pan.sensor or pan.mouse) and pan.aimedAt < panelDist then
            panel = pan
            panelDist = pan.aimedAt
        end
    end
    if not panel then return false end
    if panel.aimX and panel.aimY and (panel.sensor or panel.mouse) and math.InRangeXY(panel.aimX,panel.aimY,0,0,panel.width,panel.height) then return false,panel.aimX,panel.aimY,panel.system end
    if not panel.buttons then return false end

    local buttonTarget
    for _,button in pairs(panel.buttons) do
        if (train.Hidden[button.PropName] or train.Hidden.button[button.PropName]) and (not train.ClientProps[button.PropName] or not train.ClientProps[button.PropName].config or not train.ClientProps[button.PropName].config.staylabel) then continue end
        if (train.Hidden[button.ID] or train.Hidden.button[button.ID])  and (not train.ClientProps[button.ID] or not train.ClientProps[button.ID].config or not train.ClientProps[button.ID].config.staylabel) then  continue end
        if button.w and button.h then
            if  panel.aimX >= button.x and panel.aimX <= (button.x + button.w) and
                    panel.aimY >= button.y and panel.aimY <= (button.y + button.h) then
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

    if not buttonTarget then return false end

    return buttonTarget
end

-- Checks what button/panel is being looked at and check for custom crosshair
hook.Add("Think","metrostroi-cabin-panel",function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end

    toolTipText = nil
    drawCrosshair = false
    canDrawCrosshair = false

    local train, outside = isValidTrainDriver(ply)
    if not IsValid(train) then return end
    if gui.IsConsoleVisible() or gui.IsGameUIVisible() or IsValid(vgui.GetHoveredPanel()) and not vgui.IsHoveringWorld() and  vgui.GetHoveredPanel():GetParent() ~= vgui.GetWorldPanel() then return end
    if train.ButtonMap ~= nil then
        canDrawCrosshair = true
        local plyaimvec
        if outside then
            plyaimvec = ply:GetAimVector()
        else
            local x,y = input.GetCursorPos()
            --plyaimvec = util.AimVector( train.CamAngles, train.CamFOV,x,y,ScrW(),ScrH())
            --plyaimvec = ply:GetAimVector()
            plyaimvec = gui.ScreenToVector(x,y) -- ply:GetAimVector() is unreliable when in seats
        end

        -- Loop trough every panel
        for k2,panel in pairs(train.ButtonMap) do
            if not train:ShouldDrawPanel(kp2) then continue end
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
                    drawCrosshair = panel.aimedAt
                else
                    panel.aimedAt = false
                end
                panel.outside = outside
            else
                panel.aimedAt = false
            end
        end

        -- Tooltips
        local ttdelay = GetConVar("metrostroi_tooltip_delay"):GetFloat()
        if GetConVar("metrostroi_disablehovertext"):GetInt() == 0 and ttdelay and ttdelay >= 0 then
            local button = findAimButton(ply,train)
            --print(train.ClientProps[button.ID].button)
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
                    if C_DrawDebug:GetInt() > 0 then
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
                    if GetConVar("metrostroi_disablehovertextpos"):GetInt() == 0 and button.tooltipState and button.tooltip then
                        toolTipText = toolTipText..button.tooltipState(train)
                    end
                end
            end
        end
    end
end)


-- Takes button table, sends current status
local function sendButtonMessage(button,train,outside)
    local tooltip,buttID = nil,button.ID
    if button.plombed then
        tooltip,buttID = button.plombed(train)
    end
    if not buttID then Error(Format("Can't send button message! %s\n",button.ID)) return end
    net.Start("metrostroi-cabin-button")
        net.WriteEntity(train)
        net.WriteString(buttID:gsub("^.+:",""))
        net.WriteBit(button.state)
        net.WriteBool(outside)
    net.SendToServer()
    return buttID
    --RunConsoleCommand("metrostroi_button_press",button.ID..(button.state and 1 or 0))
end
-- Takes button table, sends current status
local function sendPanelTouch(panel,x,y,outside,state)
    net.Start("metrostroi-panel-touch")
    net.WriteString(panel or "")
    net.WriteUInt(x,11)
    net.WriteUInt(y,11)
    net.WriteBool(outside)
    net.WriteBool(state)
    net.SendToServer()
    --RunConsoleCommand("metrostroi_button_press",button.ID..(button.state and 1 or 0))
end

-- Goes over a train's buttons and clears them, sending a message if needed
function ENT:ClearButtons()
    if self.ButtonMap == nil then return end
    for _,panel in pairs(self.ButtonMap) do
        if panel.buttons then
            for _,button in pairs(panel.buttons) do
                if button.state == true then
                    button.state = false
                    sendButtonMessage(button,self)
                end
            end
        end
    end
end

function ENT:HidePanel(kp,hide)
    if hide and not self.HiddenPanels[kp] then
        self.HiddenPanels[kp] = true
        if self.ButtonMap[kp].props then
            for _,v in pairs(self.ButtonMap[kp].props) do
                --self.Hidden[v] = true
                self:ShowHide(v,false,true)
                self.Hidden.override[v] = true
            end
        end
    end
    if not hide and self.HiddenPanels[kp] then
        self.HiddenPanels[kp] = nil
        if self.ButtonMap[kp].props then
            for _,v in pairs(self.ButtonMap[kp].props) do
                --self.Hidden[v] = false
                self.Hidden.override[v] = false
                self:ShowHide(v,true,true)
            end
        end
    end
end
-- Args are player, IN_ enum and bool for press/release
local function handleKeyEvent(ply,key,pressed)
    if not game.SinglePlayer() and not IsFirstTimePredicted() then return end
    if gui.IsConsoleVisible() or gui.IsGameUIVisible() or IsValid(vgui.GetHoveredPanel()) and not vgui.IsHoveringWorld() and  vgui.GetHoveredPanel():GetParent() ~= vgui.GetWorldPanel() then return end
    if key ~= MOUSE_LEFT and key ~= MOUSE_RIGHT then return end
    local train, outside = isValidTrainDriver(ply)

    if not IsValid(train) then return end
    if train.ButtonMap == nil then return end
    if key == MOUSE_LEFT and not pressed then train:ClearButtons() end
    if pressed then
        local button,x,y,system = findAimButton(ply,train)
        local plombed = false
        if button and button.ID and button.ID[1] ~= "!" and (key ~= MOUSE_LEFT or not button.plombed or not ({button.plombed(train)})[3]) then
            button.state = true
            local buttID = sendButtonMessage(button,train,outside)
            lastButton = button
            lastButton.train = train
            if train.OnButtonPressed then
                train:OnButtonPressed(buttID:gsub("^.+:",""))
            end
        elseif not button and x and y and not lastTouch then
            sendPanelTouch(system,x,y,outside,true)
            lastTouch = {system,x,y}
        end
    else
        -- Reset the last button pressed
        if lastButton ~= nil then
            if lastButton.state == true then
                lastButton.state = false
                sendButtonMessage(lastButton,lastButton.train,outside)
            end
            if train.OnButtonReleased and button then
                local tooltip,buttID = nil,button.ID
                if button.plombed then
                    tooltip,buttID = button.plombed(train)
                end
                train:OnButtonReleased(buttID:gsub("^.+:",""))
            end
        end
        if lastTouch ~= nil then
            sendPanelTouch(lastTouch[1],lastTouch[2],lastTouch[3],outside,false)
            lastTouch = nil
        end
    end
end

-- Hook for clearing the buttons when player exits
net.Receive("metrostroi-cabin-reset",function()
    local ent = net.ReadEntity()
    if IsValid(ent) and ent.ClearButtons ~= nil then
        ent:ClearButtons()
    end
end)

local lastChanged = RealTime()
local camAnim = 0
local camStart = 0
local camEnd = 1
local function handleCam(ply,button)
    if not game.SinglePlayer() and not IsFirstTimePredicted() then return end
    if not input.IsShiftDown() then return end
    local train, outside = isValidTrainDriver(ply)
    if not IsValid(train) or outside then return end
    if not train.Cameras then return end
    local oldCam = train.CurrentCamera
    if button == KEY_LEFT then
        repeat
            train.CurrentCamera = train.CurrentCamera - 1
            if train.CurrentCamera < 0 then
                train.CurrentCamera = #train.Cameras
            end
        until not train.Cameras[train.CurrentCamera] or not train.Cameras[train.CurrentCamera][4] or train:ShouldDrawPanel(train.Cameras[train.CurrentCamera][4])
    end
    if button == KEY_RIGHT then
        repeat
            train.CurrentCamera = train.CurrentCamera + 1
            if train.CurrentCamera > #train.Cameras then
                train.CurrentCamera = 0
            end
        until not train.Cameras[train.CurrentCamera] or not train.Cameras[train.CurrentCamera][4] or train:ShouldDrawPanel(train.Cameras[train.CurrentCamera][4])
    end
    if button == KEY_DOWN then
        train.CurrentCamera = nil
    end
    if train.CurrentCamera ~= oldCam then
        if not train.CurrentCamera then train.CurrentCamera = 0 end
        if train.CurrentCamera > 0 then
            local camera = train.Cameras[train.CurrentCamera]
            local seatAng = ply:GetVehicle():GetAngles()
            LocalPlayer():SetEyeAngles(train:LocalToWorldAngles(camera[2]-seatAng))
        else
            LocalPlayer():SetEyeAngles(Angle(0,ply:GetVehicle():GetModel()=="models/nova/jeep_seat.mdl" and 90 or 0,0))
        end
        MsgC("Curent camera:",Color(255,0,0),train.CurrentCamera,"\n")
        if train.CamMoved then train:CamMoved() end
        lastChanged = RealTime()
        if camEnd == 1 then camStart = 0 end
        camEnd = 0
    end
end
hook.Add("PlayerButtonDown", "metrostroi-cabin-buttons", function(ply,key) handleKeyEvent(ply, key,true) handleCam(ply,key) end)
hook.Add("PlayerButtonUp", "metrostroi-cabin-buttons", function(ply,key) handleKeyEvent(ply, key,false) end)
if game.SinglePlayer() then
    net.Receive("PlayerButtonDown_metrostroi",function()
        local key = net.ReadUInt(16)
        handleCam(LocalPlayer(),key)
        handleKeyEvent(LocalPlayer(),key,true)
    end)
    net.Receive("PlayerButtonUp_metrostroi",function()
        handleKeyEvent(LocalPlayer(),net.ReadUInt(16),false)
    end)
end
local Gradient = Material("vgui/gradient-d")
local oldTrain
hook.Add( "HUDPaint", "metrostroi-draw-cameras", function()
    local train, outside = isValidTrainDriver(LocalPlayer())
    if not IsValid(train) or not train.Cameras or outside then
        if IsValid(oldTrain) then
            oldTrain.CurrentCamera = 0
            if oldTrain.CamMoved then oldTrain:CamMoved() end
            oldTrain = nil
            camStart = 0
            camEnd = 1
        end
        return
    end
    oldTrain = train
    local cam = train.Cameras[train.CurrentCamera]
    camAnim = camAnim+(train.CurrentCamera-camAnim)*FrameTime()*5
    if camStart < 1 then camStart = math.Clamp(camStart+FrameTime()*2,0,1) end
    if RealTime()-lastChanged > 5 and camEnd < 1 then camEnd = math.Clamp(camEnd+FrameTime()*0.5,0,1) end
    local a = math.Clamp(camStart*(1-camEnd)*255,0,255 )-- + math.Clamp(255-(255-RealTime()-lastChanged+4)*512,0,255 )
    if a<= 0 then return end
    surface.SetDrawColor(255,255,255,a)
    surface.DrawRect(15,40,384,40)
    render.SetScissorRect( 0, 60-15, 512, 60+15, true ) -- Enable the rect
        draw.SimpleText(Metrostroi.GetPhrase("Train.Common.Camera0"),"Trebuchet24",20,60-camAnim*50,Color( 0, 0, 0,a),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        for k,v in ipairs(train.Cameras) do
            draw.SimpleText(Metrostroi.GetPhrase(v[3]),"Trebuchet24",20,60+(k-camAnim)*50,Color( 0, 0, 0,a),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end
    render.SetScissorRect( 0, 0, 0, 0, false ) -- Disable after you are done
                --[[
    render.SetStencilEnable(true)
    render.SetStencilTestMask(255);render.SetStencilWriteMask(255);render.SetStencilReferenceValue(10)
    render.SetStencilPassOperation(STENCIL_REPLACE)
    render.SetStencilFailOperation(STENCIL_KEEP)
    render.SetStencilZFailOperation(STENCIL_KEEP)
    render.SetStencilCompareFunction(STENCIL_ALWAYS)

    render.SetStencilCompareFunction(STENCIL_EQUAL)

    render.SetStencilEnable(false)
    render.SetScissorRect(0,0,0,0,false)]]
end)
local ppMat = Material("pp/blurx")
hook.Add( "HUDPaint", "metrostroi-draw-crosshair-tooltip", function()
    --if not drawCrosshair then return end
    if IsValid(LocalPlayer()) then
        local scrX,scrY = ScrW(),ScrH()

        if canDrawCrosshair then
            surface.DrawCircle(scrX/2,scrY/2,4.1,drawCrosshair and Color(255,0,0) or Color(255,255,150))
        end

        if toolTipText ~= nil then
            surface.SetFont("MetrostroiLabels")
            local w,h = surface.GetTextSize("SomeText")
            local height = h*1.1
            local texts = string.Explode("\n",toolTipText)
            surface.SetDrawColor(0,0,0,125)
            for i,v in ipairs(texts) do
                local y = scrY/2+height*(i)
                if #v==0 then continue end
                local w2,h2 = surface.GetTextSize(v)
                surface.DrawRect(scrX/2-w2/2-5, scrY/2-h2/2+height*(i), w2+10, h2)
                --[[if toolTipPosition and i==#texts then
                    local st,en = v:find(toolTipPosition)
                    local textSt,textEn = v:sub(1,st-1),v:sub(en+1,-1)
                    local x1 = 0-w2/2
                    local x2 = surface.GetTextSize(textSt)-w2/2
                    local x3 = surface.GetTextSize(textSt)+surface.GetTextSize(toolTipPosition)-w2/2
                    draw.SimpleText(textSt,"MetrostroiLabels",scrX/2+x1,y, toolTipColor or Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    draw.SimpleText(toolTipPosition,"MetrostroiLabels",scrX/2+x2,y, toolTipColor or Color(0,255,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    draw.SimpleText(textEn,"MetrostroiLabels",scrX/2+x3,y, toolTipColor or Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    Metrostroi.DrawLine(scrX/2+x2,y+h/2-3,scrX/2+x3,y+h/2-3,toolTipColor or Color(0,255,0),1)
                else]]
                    draw.SimpleText(v,"MetrostroiLabels",scrX/2,y, toolTipColor or Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                --end
            end
            --[[
            local w1 = surface.GetTextSize(text1)
            local w2 = surface.GetTextSize(text2)

            surface.SetTextColor(toolTipColor or Color(255,255,255))
            surface.SetTextPos((scrX-w1)/2,scrY/2+10)
            surface.DrawText(text1)
            surface.SetTextPos((scrX-w2)/2,scrY/2+30)
            surface.DrawText(text2)]]
        end
    end
end)

language.Add("SBoxLimit_train_limit","Wagons limit")
--------------------------------------------------------------------------------
-- Turn light on or off
--------------------------------------------------------------------------------
function ENT:SetLightPower(index,power,brightness)
    if self.HiddenLamps[index] then return end
    local lightData = self.LightsOverride[index] or self.Lights[index]
    brightness = brightness or 1
    if lightData[1] == "glow" or lightData[1] == "light" then
        if lightData.panel and not self.SpritesEnabled or lightData.aa and self.AAEnabled then return end
        self.LightBrightness[index] = brightness * (lightData.brightness or 0.5)
        if power and self.Sprites[index] then return end
        self.Sprites[index] = nil
        if not power then return end
        self.Sprites[index] = util.GetPixelVisibleHandle()
        lightData.mat = Metrostroi.MakeSpriteTexture((lightData.texture or "sprites/light_glow02"),lightData[1] == "light")
        return
    end

    if power and IsValid(self.GlowingLights[index]) then
        if lightData[1] == "headlight" and IsValid(self.GlowingLights[index]) then
            -- Check if light already glowing
            if brightness ~= self.LightBrightness[index] then
                local light = self.GlowingLights[index]
                light:SetBrightness(brightness * (lightData.brightness or 1.25))
                light:Update()
                self.LightBrightness[index] = brightness
            end
            return
        elseif (lightData[1] == "glow") or (lightData[1] == "light") then
            local brightness = brightness * (lightData.brightness or 0.5)
            if brightness ~= self.LightBrightness[index] then
                local light = self.GlowingLights[index]
                light:SetBrightness(brightness)
                self.LightBrightness[index] = brightness
            end
            return
        elseif lightData[1] == "dynamiclight" then
            if brightness ~= self.LightBrightness[index] then
                local light = self.GlowingLights[index]
                light:SetLightStrength(brightness)
                self.LightBrightness[index] = brightness
            end
            return
        end
    end
    if IsValid(self.GlowingLights[index]) then
        self.GlowingLights[index]:Remove()
    end
    self.GlowingLights[index] = nil
    self.LightBrightness[index] = brightness
    if not power then return end
    -- Create light
    if lightData[1] == "light" or lightData[1] == "glow" then
        local light = ents.CreateClientside("gmod_train_sprite")
        light:SetPos(self:LocalToWorld(lightData[2]))
        --light:SetLocalAngles(lightData[3])

        -- Set parameters
        local brightness = brightness * (lightData.brightness or 0.5)
        light:SetColor(lightData[4])
        light:SetBrightness(brightness)
        light:SetTexture((lightData.texture or "sprites/light_glow02")..".vmt",lightData[1] == "light")
        light:SetSize(lightData.scale or 1.0)
        light:Set3D(false)

        self.GlowingLights[index] = light
    elseif (lightData[1] == "headlight") and (not lightData.backlight or self.RedLights) and (not lightData.panellight or self.OtherLights) then
        local light = ProjectedTexture()
        light:SetPos(self:LocalToWorld(lightData[2]))
        light:SetAngles(self:LocalToWorldAngles(lightData[3]))
        --light:SetParent(self)
        --light:SetLocalPos(lightData[2])
        --light:SetLocalAngles(lightData[3])

        -- Set parameters
        if lightData.headlight and self.HeadlightShadows or not lightData.headlight and self.OtherShadows then
            light:SetEnableShadows((lightData.shadows or 0)>0)
        else
            light:SetEnableShadows(false)
        end
        if (lightData.shadows or 0)>0 then
            light:SetFarZ(math.max(lightData.farz or 2048,10))
        else
            light:SetFarZ(lightData.farz or 2048)
        end
        light:SetNearZ(lightData.nearz or 16)
        if lightData.fov then light:SetFOV(lightData.fov or 120) end
        if lightData.hfov then light:SetHorizontalFOV(lightData.hfov) end
        if lightData.vfov then light:SetVerticalFOV(lightData.vfov or 120) end
        light:SetOrthographic(false)
        -- Set Brightness
        light:SetBrightness(brightness * (lightData.brightness or 1.25))
        light:SetColor(lightData[4])
        light:SetTexture(lightData.texture or "effects/flashlight001")

        -- Turn light on
        light:Update() --"effects/flashlight/caustics"
        self.GlowingLights[index] = light
    elseif lightData[1] == "dynamiclight" then
        local light = ents.CreateClientside("gmod_train_dlight")
        light:SetParent(self)

        -- Set position
        light:SetLocalPos(lightData[2])
        --light:SetLocalAngles(lightData[3])

        -- Set parameters
        light:SetDColor(lightData[4])
        light:SetSize(lightData.distance)
        light:SetBrightness(lightData.brightness or 2)
        light:SetLightStrength(brightness)

        -- Turn light on
        light:Spawn()
        self.GlowingLights[index] = light
    end
end

function ENT:OnStyk(soundid,location,range,pitch)
    local speed = self:GetNW2Float("TrainSpeed",0)/100
    --local str = ""
    if self.TunnelCoeff > 0.01 then
        --local snd = Format("b%dtunnel_%d%s",pitch,range%10+1,soundid)
        --str=str..Format("tun: %s=%s vol=%d pitch=",snd,self.SoundNames[snd],self.TunnelCoeff*(0.9-math.min(speed,1)*0.3),0.9+math.min(speed,1)*0.3)
        self:PlayOnce(Format("b%dtunnel_%d%s",pitch,range%10+1,soundid),"bass",self.TunnelCoeff*(0.9-math.min(speed,1)*0.3),0.9+math.min(speed,1)*0.2)
    end
    if self.StreetCoeff > 0.01 then
        --local snd = Format("b%dstreet_%d%s",pitch,range%14+1,soundid)
        --str=str..Format(", str: %s=%s vol=%d pitch=",snd,self.SoundNames[snd],self.StreetCoeff*(0.6-math.min(speed,1)*0.3),0.9+math.min(speed,1)*0.3)
        self:PlayOnce(Format("b%dstreet_%d%s",pitch,range%14+1,soundid),"bass",self.StreetCoeff*(0.6-math.min(speed,1)*0.3),0.9+math.min(speed,1)*0.2)
    end
    --RunConsoleCommand("say",str)
end

concommand.Add("metrostroi_reload_client",function()
    Metrostroi.ReloadClientside = true
    timer.Simple(0.5,function() if Metrostroi.ReloadClientside then Metrostroi.ReloadClientside = false end end)
end,nil,"Reload all clientside models")
Metrostroi.OptimisationPatch()
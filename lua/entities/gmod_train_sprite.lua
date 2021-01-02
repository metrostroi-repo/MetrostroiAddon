--[[-------------------------------------------------------------------------
Client sprite entity for metrostroi trains, trying to copy
env_sprite render behavior with oun functions
---------------------------------------------------------------------------]]
AddCSLuaFile()
ENT.Type            = "anim"
ENT.PrintName = "Clientside sprite"

ENT.Spawnable       = false
ENT.AdminSpawnable  = false

if SERVER then return end
MetrostroiSprites = MetrostroiSprites or {}
MetrostroiSprites2D = MetrostroiSprites2D or {}

local function colAlpha(col,a)
    return Color(col.r*a,col.g*a,col.b*a)
end

hook.Add("PostDrawTranslucentRenderables","MetrostroiClientSprite",function(_,isSkybox)
    --print(ENT.Sprites)
    if isSkybox then return end
    --cam.Start3D()

    --render.SetLightingMode(2)

    for i=1, #MetrostroiSprites do
        local ent = MetrostroiSprites[i]
        if not ent.Visible or ent.Brightness <= 0 then continue end


        local pos = ent:GetPos()
        local visibility = util.PixelVisible(pos, 5, ent.vHandle)--math.max(0,util.PixelVisible(pos, 5, vHandle)-0.25)/0.75
        if visibility > 0 then
            render.SetMaterial(ent.Material)
            render.DrawSprite(pos,128*ent.Scale,128*ent.Scale,colAlpha(ent:GetColor(),visibility*ent.Brightness))
        end
    end

    for i=1, #MetrostroiSprites2D do
        local ent = MetrostroiSprites2D[i]
        if not ent.Visible or ent.Brightness <= 0 then continue end


        local pos = ent:GetPos()
        local visibility = util.PixelVisible(pos, 5, ent.vHandle)--math.max(0,util.PixelVisible(pos, 5, vHandle)-0.25)/0.75
        if visibility > 0 then
            render.SetMaterial(ent.Material)
            cam.IgnoreZ(true)
                render.DrawSprite(pos,128*ent.Scale,128*ent.Scale,colAlpha(ent:GetColor(),visibility*ent.Brightness))
            cam.IgnoreZ(false)
            --render.DrawQuadEasy( ent:GetPos(),-EyeVector(), 128*ent.Scale, 128*ent.Scale, ent:GetColor())
        end
    end

    --render.SetLightingMode(0)
    --[[for i=1, #MetrostroiSprites2D do
        local ent = MetrostroiSprites2D[i]
        if not ent.Visible or ent.Brightness <= 0 then continue end

        ent._visibility = util.PixelVisible(ent:GetPos(), 5, ent.vHandle)--math.max(0,util.PixelVisible(pos, 5, vHandle)-0.25)/0.75
    end]]
    --cam.End3D()
end)

hook.Remove("PreDrawViewModel","MetrostroiClientSprite",function()
end)

function ENT:Initialize()
    self:SetSize(self.Scale or 1)
    self:SetTexture(self.Texture or "sprites/glow1.vmt")
    self:SetColor(self.Color or Color(255,255,255))
    self:SetBrightness(1)
    self:SetVisible(true)

    self.vHandle = util.GetPixelVisibleHandle()
    table.insert(MetrostroiSprites2D,self)
end

function ENT:OnRemove()
    if self.Is3D then
        for i,v in ipairs(MetrostroiSprites) do
            if self == v then table.remove(MetrostroiSprites,i) end
        end
    else
        for i,v in ipairs(MetrostroiSprites2D) do
            if self == v then table.remove(MetrostroiSprites2D,i) end
        end
    end
end

function ENT:SetSize(scale)
    self.Scale = math.max(scale,0)
end

__TEST = (__TEST or 0) + 1
function ENT:SetTexture(texture,isSprite)
    self.Texture = texture
    self.Material = Metrostroi.MakeSpriteTexture(texture,isSprite)
    --[[if isSprite then
        self.Material = CreateMaterial(texture..":sprite0000"..__TEST,"Sprite",{
            ["$basetexture"] = texture,
            ["$spriteorientation"] = "vp_parallel",
            ["$spriteorigin"] = "[ 0.50 0.50 ]",
            ["$illumfactor"] = 7,
            ["$spriterendermode"] = 3,
        })
    else
        self.Material =CreateMaterial(texture..":spriteug0000"..__TEST,"UnlitGeneric",{
            ["$basetexture"] = texture,
            ["$translucent"]= 1,
            ["$additive"] = 1,
            ["$vertexcolor"] = 1,
            --["$vertexalpha"] = 1,
        })
    end]]
end

function ENT:SetSColor(col)
    self.Color = colAlpha(col,col.a/255)
end
function ENT:SetBrightness(brightness)
    self.Brightness = brightness
end
function ENT:SetVisible(vis)
    self.Visible = vis
end
function ENT:Set3D(is3D)
    self:OnRemove()
    if is3D then
        table.insert(MetrostroiSprites,self)
    else
        table.insert(MetrostroiSprites2D,self)
    end
    self.Is3D = is3D
end
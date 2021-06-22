--[[-------------------------------------------------------------------------
Client light_dynamic entity
---------------------------------------------------------------------------]]
AddCSLuaFile()
ENT.Type            = "anim"
ENT.PrintName = "Clientside dlight"

ENT.Spawnable       = false
ENT.AdminSpawnable  = false

if SERVER then return end
MetrostroiDLights = MetrostroiDLights or 0

function ENT:Initialize()
    self.ID = 817200-MetrostroiDLights
    MetrostroiDLights = MetrostroiDLights + 3

    self.Strength = self.Strength or 1
    self.Color = self.Color or Color(255,220,80)
    self.Brightness = self.Brightness or 1

    if self.AffectW == nil then self.AffectW = true end

    self:SetSize(self.Size or 512)

    self:MakeDLight()
end

function ENT:Think()
        self:MakeDLight()
    --[[
    if not self.Created then
        self:MakeDLight()
        return
    end
    self.DLight.Pos = self:GetPos()
    --self.DLight.Brightness = 5
    self.DLight.Size = self.Size
    self.DLight.Decay = self.Size * 50
    self.DLight.DieTime = CurTime() + 1]]
end

function ENT:SetDColor(col)
    --[[if self.Created then
        self.DLight.r = col.r*self.Strength
        self.DLight.g = col.g*self.Strength
        self.DLight.b = col.b*self.Strength
    end]]
    self.Color = col
end

function ENT:SetLightStrength(br)
    --[[if self.Created then
        self.DLight.r = self.Color.r*br
        self.DLight.g = self.Color.g*br
        self.DLight.b = self.Color.b*br
    end]]
    self.Strength = br
end

function ENT:SetBrightness(br)
    --if self.Created then self.DLight.Brightness = br end
    self.Brightness = br
end
function ENT:SetSize(sz)
    self.Size = sz
end
function ENT:SetStyle(style)
    --[[if self.Created then
        self.DLight.Style = style
    end]]
    self.Style = style
end

function ENT:MakeDLight()
    if DLightFreeze ~= RealTime() then self.Created = true end
    DLightFreeze = RealTime()

    self.DLight = DynamicLight(self.ID, not self.AffectW)
    self.DLight.Style = self.Style
    self.DLight.r = self.Color.r*self.Strength
    self.DLight.g = self.Color.g*self.Strength
    self.DLight.b = self.Color.b*self.Strength
    self.DLight.nomodel = self.nomodel
    self.DLight.Brightness = self.Brightness

    self.DLight.Pos = self:GetPos()
    --self.DLight.Brightness = 5
    self.DLight.Size = self.Size
    self.DLight.Decay = self.Size * 50
    self.DLight.DieTime = CurTime() + 1
end

function ENT:AffectWorld(affect)
    --[[self.AffectW = affect
    self.Created = false
    self:DLight()]]
end
function ENT:OnRemove()
    if self.Created then
        self.DLight.DieTime = 0
    end
end
function ENT:AffectModels(affect)
    --[[if self.Created then
        self.DLight.nomodel = not affect
    end]]
    self.nomodel = not affect
end
function ENT:Draw() end
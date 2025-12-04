include("shared.lua")

local C_SignalDebug = GetConVar("metrostroi_drawsignaldebug")
local mat = Material("vgui/bg-lines")
function ENT:DrawTranslucent(flags)
    if not C_SignalDebug:GetBool() then
        self:SetNoDraw(true)
        return
    end

    self:DrawModel(flags)

    cam.Start3D()
        render.SetMaterial(mat)
        render.DrawQuadEasy(self:GetPos(),-self:GetAngles():Forward(),600,300,Color(255,0,0),0)
        render.DrawLine(self:GetPos(), self:LocalToWorld(Vector(50,0,0)), Color(255,0,0))
        render.DrawLine(self:GetPos(), self:LocalToWorld(Vector(0,50,0)), Color(0,255,0))
        render.DrawLine(self:GetPos(), self:LocalToWorld(Vector(0,0,50)), Color(0,0,255))
    cam.End3D()
end

cvars.AddChangeCallback("metrostroi_drawsignaldebug", function (name, oldValue, newValue)
    local noDraw = not C_SignalDebug:GetBool()
    for _,ent in pairs(ents.FindByClass("gmod_track_pa_marker")) do
        ent:SetNoDraw(noDraw)
    end
end)
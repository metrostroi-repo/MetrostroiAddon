include("shared.lua")

local C_SignalDebug = GetConVar("metrostroi_drawsignaldebug")

function ENT:Draw(flags)
    self:DrawModel(flags)

    if not C_SignalDebug:GetBool() then return end
    if LocalPlayer():GetPos():DistToSqr(self:GetPos()) > 200000 then return end

    local pos = self:LocalToWorld(Vector(30,0,75))
    local ang = self:LocalToWorldAngles(Angle(0,180,90))
    cam.Start3D2D(pos, ang, 0.25)
        surface.SetDrawColor(125, 125, 0, 255)
        surface.DrawRect(0, 0, 160, 24)
        
        draw.DrawText("SwitchID:"..self:GetNW2String("ID"),"Trebuchet24",5,0,Color(0,0,0,255))
    cam.End3D2D()
end

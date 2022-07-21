include("shared.lua")

local debug = GetConVar("metrostroi_drawsignaldebug")
local function enableDebug()
    if debug:GetBool() then
        hook.Add("PreDrawEffects","MetrostroiSwitchDebug",function()
            for _,ent in pairs(ents.FindByClass("gmod_track_switch")) do
                if IsValid(ent) and LocalPlayer():GetPos():DistToSqr(ent:GetPos()) < 262144 then
					local pos = ent:LocalToWorld(Vector(30,0,75))
					local ang = ent:LocalToWorldAngles(Angle(0,180,90))
					cam.Start3D2D(pos, ang, 0.25)
						surface.SetDrawColor(125, 125, 0, 255)
						surface.DrawRect(0, 0, 160, 24)

						draw.DrawText("SwitchID:"..ent:GetNW2String("ID"),"Trebuchet24",5,0,Color(0,0,0,255))
					cam.End3D2D()
                end
            end
        end)
    else
        hook.Remove("PreDrawEffects","MetrostroiSwitchDebug")
    end
end
hook.Remove("PreDrawEffects","MetrostroiSwitchDebug")
cvars.AddChangeCallback( "metrostroi_drawsignaldebug", enableDebug)
enableDebug()
include("shared.lua")

local mat = Material("vgui/bg-lines")
--[[
function ENT:Draw()
	if not self.CanDraw then return end
	cam.Start3D()
		render.SetMaterial(mat)
		--render.DrawQuadEasy(self:GetPos(),self:GetAngles():Forward(),600,600,Color(255,255,255),0)

		render.DrawQuadEasy(self:GetPos(),-self:GetAngles():Forward(),600,300,Color(255,0,0),0)
		render.DrawLine( self:GetPos(), self:LocalToWorld(Vector(50,0,0)), Color(255,0,0))
		render.DrawLine( self:GetPos(), self:LocalToWorld(Vector(0,50,0)), Color(0,255,0))
		render.DrawLine( self:GetPos(), self:LocalToWorld(Vector(0,0,50)), Color(0,0,255))
		--render.DrawSprite( pos, 16, 16, white )
	cam.End3D()
	self:DrawModel()
end]]

function ENT:Draw()
end

local debug = GetConVar("metrostroi_drawsignaldebug")
local function enableDebug()
    if debug:GetBool() then
        hook.Add("PostDrawTranslucentRenderables","MetrostroiPAMarkerDebug",function(bDrawingDepth,bDrawingSkybox)
            for _,ent in pairs(ents.FindByClass("gmod_track_autodrive_plate")) do
                if bDrawingDepth and LocalPlayer():GetPos():DistToSqr(sig:GetPos()) < 262144 then
                    cam.Start3D()
                        render.SetMaterial(mat)
                        --render.DrawQuadEasy(self:GetPos(),self:GetAngles():Forward(),600,600,Color(255,255,255),0)

                        render.DrawQuadEasy(ent:GetPos(),-ent:GetAngles():Forward(),600,300,Color(255,0,0),0)
                        render.DrawLine( ent:GetPos(), ent:LocalToWorld(Vector(50,0,0)), Color(255,0,0))
                        render.DrawLine( ent:GetPos(), ent:LocalToWorld(Vector(0,50,0)), Color(0,255,0))
                        render.DrawLine( ent:GetPos(), ent:LocalToWorld(Vector(0,0,50)), Color(0,0,255))
                        --render.DrawSprite( pos, 16, 16, white )
                    cam.End3D()
                    ent:DrawModel()
                end
            end
        end)
    else
        hook.Remove("PostDrawTranslucentRenderables","MetrostroiPAMarkerDebug")
    end
end
hook.Remove("PostDrawTranslucentRenderables","MetrostroiPAMarkerDebug")
cvars.AddChangeCallback( "metrostroi_drawsignaldebug", enableDebug)
enableDebug()
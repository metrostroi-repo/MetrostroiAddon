include("shared.lua")

function ENT:Initialize()
end

function ENT:OnRemove()
end
function ENT:RemoveModels()
end
function ENT:Think()
    self.CanDraw = GetConVarNumber("metrostroi_drawsignaldebug")>0
	self:NextThink(CurTime()+5)
	return true
end


local mat = Material("vgui/bg-lines")
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
end
cvars.AddChangeCallback("metrostroi_drawsignaldebug", function()
    for k,auto in pairs(ents.FindByClass("gmod_track_autodrive_coil")) do
        auto:Initialize()
    end
end,"PAMarker")
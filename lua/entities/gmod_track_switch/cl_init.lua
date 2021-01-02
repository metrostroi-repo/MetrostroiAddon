include("shared.lua")

function ENT:Initialize()
	hook.Add("PostDrawOpaqueRenderables", "metrostroi_switch_draw_"..self:EntIndex(), function()
			--print(1)
			if GetConVarNumber("metrostroi_drawsignaldebug") ~= 1 then return end
			--print(2)
			local pos = self:LocalToWorld(Vector(30,0,75))
			local ang = self:LocalToWorldAngles(Angle(0,180,90))
			cam.Start3D2D(pos, ang, 0.25)
				surface.SetDrawColor(125, 125, 0, 255)
				surface.DrawRect(0, 0, 160, 24)

				draw.DrawText("SwitchID:"..self:GetNW2String("ID"),"Trebuchet24",5,0,Color(0,0,0,255))
			cam.End3D2D()
	end )
end
function ENT:OnRemove()
	hook.Remove("PostDrawOpaqueRenderables", "metrostroi_switch_draw_"..self:EntIndex())
end
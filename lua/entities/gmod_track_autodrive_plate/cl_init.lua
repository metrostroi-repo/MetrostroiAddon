include("shared.lua")

hook.Add("PostDrawOpaqueRenderables", "gmod_track_autodrive_plate_debug_draw", function(isDD)
		if isDD then return end
		if GetConVarNumber("metrostroi_drawsignaldebug") == 0 then return end
		--print(2)
		for _,self in pairs(ents.FindByClass("gmod_track_autodrive_plate")) do
			local pos = self:LocalToWorld(Vector(0,0,0))
			local ang = self:LocalToWorldAngles(Angle(0,90,90))
			cam.Start3D2D(pos , ang, 0.25)
				surface.SetDrawColor(125, 125, 0, 255)
				surface.DrawRect(-40, -20, 80, 20)
			cam.End3D2D()
		end
end )


function ENT:Initialize()
end

function ENT:OnRemove()
end
function ENT:RemoveModels()
end
function ENT:Think()
	self:NextThink(CurTime()+5)
	return true
end

function ENT:Draw()
	self:DrawModel()
	if false and self.SpeedDetectors then
		cam.Start3D()
			for i,dist in ipairs(self.SpeedDetectors) do
				render.DrawLine(self:LocalToWorld(Vector((dist-80)/0.01905,-3.3,5.5)),self:LocalToWorld(Vector((dist-80)/0.01905,3.3,5.5)), Color(255,0,0),true)
				render.DrawLine(self:LocalToWorld(Vector((dist-80-0.02)/0.01905,-3.3,5.5)),self:LocalToWorld(Vector((dist-80+0.02)/0.01905,-3.3,5.5)), Color(255,0,0),true)
				render.DrawLine(self:LocalToWorld(Vector((dist-80-0.02)/0.01905,3.3,5.5)),self:LocalToWorld(Vector((dist-80+0.02)/0.01905,3.3,5.5)), Color(255,0,0),true)
			end
		cam.End3D()
	end
end

net.Receive("metrostroi_auodrive_coils",function()
	local ent = net.ReadEntity()
	if true or not ent then return end
	ent.SpeedDetectors = {}
	local count = net.ReadUInt(16)
	for i=1,count do
		table.insert(ent.SpeedDetectors,net.ReadFloat())
	end
	PrintTable(ent.SpeedDetectors)
end)
include("shared.lua")

local C_SignalDebug = GetConVar("metrostroi_drawsignaldebug")

function ENT:Draw(flags)
	self:DrawModel(flags)

	if not C_SignalDebug:GetBool() then return end
	if LocalPlayer():GetPos():DistToSqr(self:GetPos()) > 200000 then return end

	local pos = self:LocalToWorld(Vector(0,0,0))
	local ang = self:LocalToWorldAngles(Angle(0,90,90))
	cam.Start3D2D(pos, ang, 0.25)
		surface.SetDrawColor(125, 125, 0, 255)
		surface.DrawRect(-40, -20, 80, 20)
	cam.End3D2D()
	
	if self.SpeedDetectors then
		for i,dist in ipairs(self.SpeedDetectors) do
			render.DrawLine(self:LocalToWorld(Vector((dist-80)/0.01905,-3.3,5.5)),self:LocalToWorld(Vector((dist-80)/0.01905,3.3,5.5)), Color(255,0,0),true)
			render.DrawLine(self:LocalToWorld(Vector((dist-80-0.02)/0.01905,-3.3,5.5)),self:LocalToWorld(Vector((dist-80+0.02)/0.01905,-3.3,5.5)), Color(255,0,0),true)
			render.DrawLine(self:LocalToWorld(Vector((dist-80-0.02)/0.01905,3.3,5.5)),self:LocalToWorld(Vector((dist-80+0.02)/0.01905,3.3,5.5)), Color(255,0,0),true)
		end
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

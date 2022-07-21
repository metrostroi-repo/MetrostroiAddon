include("shared.lua")

local debug = GetConVar("metrostroi_drawsignaldebug")
local function enableDebug()
    if debug:GetBool() then
        hook.Add("PostDrawTranslucentRenderables","MetrostroiAutoDebug",function(bDrawingDepth,bDrawingSkybox)
            for _,ent in pairs(ents.FindByClass("gmod_track_autodrive_plate")) do
                if bDrawingDepth and LocalPlayer():GetPos():DistToSqr(sig:GetPos()) < 262144 then
                    local pos = sig:LocalToWorld(Vector(0,0,0))
                    local ang = sig:LocalToWorldAngles(Angle(0,90,90))
                    cam.Start3D2D(pos, ang, 0.25)
						surface.SetDrawColor(125, 125, 0, 255)
						surface.DrawRect(-40, -20, 80, 20)
                    cam.End3D2D()
                end
            end
        end)
    else
        hook.Remove("PostDrawTranslucentRenderables","MetrostroiAutoDebug")
    end
end
hook.Remove("PostDrawTranslucentRenderables","MetrostroiAutoDebug")
cvars.AddChangeCallback( "metrostroi_drawsignaldebug", enableDebug)
enableDebug()

function ENT:Initialize()
end

function ENT:OnRemove()
end
function ENT:RemoveModels()
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
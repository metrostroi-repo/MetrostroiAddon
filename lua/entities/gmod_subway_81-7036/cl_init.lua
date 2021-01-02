include("shared.lua")


--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}
--[[
ENT.ButtonMap["TestDraw"] = {
	pos = Vector(455,5,7),
	ang = Angle(0,-90,80),
	width = 512,
	height = 512,
	scale = 0.024,
}]]

--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false

ENT.ClientProps["door1"] = {
	model = "models/props_junk/PopCan01a.mdl",
	pos = Vector(410,71.1,55.2),
	ang = Angle(90,-0,0)
}
--------------------------------------------------------------------------------
-- Add doors
local function GetDoorPosition(i,k,j)
	if j == 0
	then return Vector(349.0 - 32*k     - 230*i,-65*(1-2*k),-2.8)
	else return Vector(349.0 - 32*(1-k) - 230*i,-65*(1-2*k),-2.8)
	end
end
for i=0,3 do
	for k=0,1 do
		ENT.ClientProps["door"..i.."x"..k.."a"] = {
			model = "models/metrostroi/81/81-7036_door1.mdl",
			pos = GetDoorPosition(i,k,0),
			ang = Angle(0,180*(1-k),0)
		}
		ENT.ClientProps["door"..i.."x"..k.."b"] = {
			model = "models/metrostroi/81/81-7036_door2.mdl",
			pos = GetDoorPosition(i,k,1),
			ang = Angle(0,180*(1-k),0)
		}
	end
end
table.insert(ENT.ClientProps,{
	model = "models/metrostroi/81/81-7036_door4.mdl",
	pos = Vector(-487.0,-2.2,-4.5),
	ang = Angle(0,0,0)
})
table.insert(ENT.ClientProps,{
	model = "models/metrostroi/81/81-7036_door3.mdl",
	pos = Vector(414.0,65.0,-1.8),
	ang = Angle(0,0,0)
})
table.insert(ENT.ClientProps,{
	model = "models/metrostroi/81/81-7036_door5.mdl",
	pos = Vector(414.3,-65.0,-1.8),
	ang = Angle(0,0,0)
})


Metrostroi.RTQuele = {
	entries = {}
}
Metrostroi.RTQueleFrame = 0
Metrostroi.PixVisHandle = util.GetPixelVisibleHandle()
local drawn = true
hook.Add("RenderScene","MetrostroiParallelView",function()
	Metrostroi.RTQueleFrame = Metrostroi.RTQueleFrame + 1
	if #Metrostroi.RTQuele > 0 and Metrostroi.RTQueleFrame > 1/FrameTime()/20*#Metrostroi.RTQuele then
		local id = table.remove(Metrostroi.RTQuele,1)
		Metrostroi.RTQuele.entries[id]()
		Metrostroi.RTQuele.entries[id] = nil
		Metrostroi.RTQueleFrame = 0
		--print("draw",1/FrameTime())
		drawn = false
	else
		--print("nodraw",1/FrameTime())
	end
end)
function Metrostroi.CanRenderCam(RT,func,draw)
	if not Metrostroi.RTQuele.entries[RT] and draw then
		table.insert(Metrostroi.RTQuele,RT)
		Metrostroi.RTQuele.entries[RT] = func
		return true
	end
	return false
end
--------------------------------------------------------------------------------
function ENT:Initialize()
	self.BaseClass.Initialize(self)
	--[[
	self.Cams = {}
	for i=1,3 do
		self.Cams[i] = self:CreateRT("cam"..i,false,128,128)
	end
	self.Test = self:CreateRT("cam",true)]]
end
function ENT:Think()
	self.BaseClass.Think(self)
	--[[
	Metrostroi.CanRenderCam("7036cam1", function()
		if not IsValid(self) then return end
		render.PushRenderTarget(self.Cams[1].rt,0,0,128, 128)
		render.Clear(0, 0, 0, 0)
	  cam.Start2D()
				surface.SetDrawColor(200,0,0)
				surface.DrawRect(0,0,64,64)
		    render.RenderView({
		      origin = self:LocalToWorld(Vector(410,73.1,55.2)), -- change to your liking
		      angles = self:LocalToWorldAngles(Angle( 0, 180+10, 0 )), -- change to your liking
		      x = 0,
		      y = 0,
		      w = 128,
		      h = 128,
		      fov = 70,
		     } )
		 		surface.SetDrawColor(255,0,0)
		 		surface.DrawRect(0,0,64,64)
 		cam.End2D()
 		render.PopRenderTarget()
	end,self)
	Metrostroi.CanRenderCam("7036cam2", function()
		if not IsValid(self) then return end
		render.PushRenderTarget(self.Cams[2].rt,0,0,128, 128)
		render.Clear(0, 0, 0, 0)
	  cam.Start2D()
	    render.RenderView({
	      origin = self:LocalToWorld(Vector(410,-73.1,55.2)), -- change to your liking
	      angles = self:LocalToWorldAngles(Angle( 0, 180-10, 0 )), -- change to your liking
	      x = 0,
	      y = 0,
	      w = 128,
	      h = 128,
	      fov = 70,
	     } )
		cam.End2D()
		render.PopRenderTarget()
	end,self)
	Metrostroi.CanRenderCam("7036cam3", function()
		if not IsValid(self) then return end
		render.PushRenderTarget(self.Cams[3].rt,0,0,128, 128)
		render.Clear(0, 0, 0, 0)
	  cam.Start2D()
 	    render.RenderView( {
 	      origin = self:LocalToWorld(Vector(410,0,55.2)), -- change to your liking
 	      angles = self:LocalToWorldAngles(Angle( 0, 180-10, 0 )), -- change to your liking
 	      x = 0,
 	      y = 0,
 	      w = 128,
 	      h = 128,
 	      fov = 70,
 	     } )
		cam.End2D()
		render.PopRenderTarget()
	end)]]
end

function ENT:Draw()
	self.BaseClass.Draw(self)
end
function ENT:DrawPost(special)
	--[[self:DrawOnPanel("TestDraw",function(...)
		surface.SetMaterial(self.Cams[1].mat)
		surface.SetDrawColor(255,255,255)
		surface.DrawTexturedRect(0,0,256,256,0)
		surface.SetMaterial(self.Cams[2].mat)
		surface.SetDrawColor(255,255,255)
		surface.DrawTexturedRect(256,0,256,256,0)
		surface.SetMaterial(self.Cams[3].mat)
		surface.SetDrawColor(255,255,255)
		surface.DrawTexturedRect(0,256,256,256,0)
	end)]]
end

function ENT:OnButtonPressed(button)
	if button == "ShowHelp" then
		RunConsoleCommand("metrostroi_train_manual")
	end
end

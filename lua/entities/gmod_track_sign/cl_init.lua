include("shared.lua")

surface.CreateFont("MetrostroiSubway_StationFont1", {
  font = "Arial",
  size = 96,
  weight = 0,
  blursize = 0,
  scanlines = 0,
  antialias = true,
  underline = false,
  italic = false,
  strikeout = false,
  symbol = false,
  rotary = false,
  shadow = false,
  additive = false,
  outline = false,
  extended = true
})

surface.CreateFont("MetrostroiSubway_StationFont2", {
  font = "Times New Roman",
  size = 128,
  weight = 0,
  antialias = true,
  extended = true
})

surface.CreateFont("MetrostroiSubway_StationList1", {
  font = "Arial",
  size = 28,
  weight = 1000,
  antialias = true,
  extended = true
})
surface.CreateFont("MetrostroiSubway_StationList2", {
  font = "Arial",
  size = 28,
  weight = 0,
  antialias = true,
  extended = true
})
surface.CreateFont("MetrostroiSubway_StationList3", {
  font = "Arial",
  size = 28,
  weight = 0,
  antialias = true,
  extended = true
})

function ENT:Initialize()
	self:SetRenderBounds(
		Vector(-16,-768,-64),
		Vector(16,768,64))
end

local P1 = -2
local P2 = 3
function ENT:DrawStation(x,y,ID,currentStation,R1,G1,B1,W,H,text1,text2,text3)
	local R2 = 225
	local G2 = 205
	local B2 = 0

	if currentStation then
		local R,G,B = R2,G2,B2
		R2,G2,B2 = R1,G1,B1
		R1,G1,B1 = R,G,B
	end

	self.LastColor = self.LastColor or Color(R1,G1,B1,255)

	surface.SetDrawColor(0,0,0,255)
	surface.DrawRect(x+P1,y,W-P1*2,H)

	surface.SetDrawColor(R1,G1,B1,255)
	surface.DrawRect(x+P1+P2,y+P2,W-P1*2-P2*2,H-P2*2)

	local cx = x+W*0.1
	local cy = y+H*0.5
	local N = 10
	local radius = 23
	local step = 2*math.pi/N
	local vertexBuffer = { {}, {}, {} }

	surface.SetDrawColor(255,255,255,255)
	for i=1,N do
		vertexBuffer[1].x = cx + radius*math.sin(step*(i+0))
		vertexBuffer[1].y = cy + radius*math.cos(step*(i+0))
		vertexBuffer[2].x = cx
		vertexBuffer[2].y = cy
		vertexBuffer[3].x = cx + radius*math.sin(step*(i+1))
		vertexBuffer[3].y = cy + radius*math.cos(step*(i+1))
		surface.DrawPoly(vertexBuffer)
	end

	draw.Text({
		text = text1,
		font = "MetrostroiSubway_StationList3",
		pos = { x+W*0.1, y+H*0.5},
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
		color = Color(0,0,0,255)})
	draw.Text({
		text = text2,
		font = "MetrostroiSubway_StationList1",
		pos = { x+W*0.55, y+H*0.25},
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
		color = Color(0,0,0,255)})
	draw.Text({
		text = text3,
		font = "MetrostroiSubway_StationList2",
		pos = { x+W*0.55, y+H*0.75},
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
		color = Color(0,0,0,255)})
end

function ENT:Draw()
	local pos = self:LocalToWorld(Vector(4,0,16))
	local ang = self:LocalToWorldAngles(Angle(0,90,90))
	cam.Start3D2D(pos, ang, 0.50)
		--surface.SetDrawColor(255,255,255,255)
		--surface.DrawRect(0, 0, 256, 320)

		draw.Text({
			text = self:GetNW2String("Name","Error"),
			font = "MetrostroiSubway_StationFont2",--..self:GetNW2Int("Style",1),
			pos = { 0, 0 },
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			color = Color(0,0,0,255)})
	cam.End3D2D()

	local pos = self:LocalToWorld(Vector(4,0,-32))
	local ang = self:LocalToWorldAngles(Angle(0,90,90))
	cam.Start3D2D(pos, ang, 0.125)
		draw.NoTexture()

		local N = self:GetNW2Int("StationList#")
		local W = 320
		local H = 64
		local X = -N*W*0.5
		self.LastColor = nil
		for i=1,N do
			local x = X+W*(i-1)
			local ID = self:GetNW2Int("StationList"..i.."[ID]")
			local currentStation = (self:GetNW2Int("ID") == ID)

			local R1 = self:GetNW2Int("StationList"..i.."[R]")
			local G1 = self:GetNW2Int("StationList"..i.."[G]")
			local B1 = self:GetNW2Int("StationList"..i.."[B]")

			self:DrawStation(x,0,ID,currentStation,R1,G1,B1,W,H,
				self:GetNW2String("StationList"..i.."[ID]"),
				self:GetNW2String("StationList"..i.."[Name1]"),
				self:GetNW2String("StationList"..i.."[Name2]"))

			-- Draw change
			if self:GetNW2Int("Change2") == tonumber(self:GetNW2String("StationList"..i.."[ID]")) then
				local Nc = self:GetNW2Int("Change2List#")
				local ChangeStation = self:GetNW2Int("Change2ID")
				local N2 = 0
				for j=1,Nc do
					if self:GetNW2Int("Change2List"..j.."[ID]") < ChangeStation then
						N2 = N2 + 1
					end
				end

				for j=1,Nc do
					local ID = self:GetNW2Int("Change2List"..j.."[ID]")
					local R2 = self:GetNW2Int("Change2List"..j.."[R]")
					local G2 = self:GetNW2Int("Change2List"..j.."[G]")
					local B2 = self:GetNW2Int("Change2List"..j.."[B]")

					local H2 = H*0.85
					local y = 0
					if j <= N2
					then y = -H2*(N2-j+1)
					else y = 0+H+H2*(j-N2-1)
					end

					self:DrawStation(x,y,ID,false,R2,G2,B2,W,H2,
						self:GetNW2String("Change2List"..j.."[ID]"),
						self:GetNW2String("Change2List"..j.."[Name1]"),
						self:GetNW2String("Change2List"..j.."[Name2]"))
				end
			end
		end

		-- Inner part of arrow
		local arrow = {
			{ x = 0,	y = 0 },
			{ x = 0,	y = H },
			{ x = -H/2,	y = H/2 },
		}
		for k,v in ipairs(arrow) do
			v.x = v.x - (N*0.5)*W - 2
		end

		surface.SetDrawColor(Color(0,0,0,255))
		surface.DrawPoly(arrow)

		-- Outer part of arrow
		arrow = {
			{ x = -P2,	y = 2*P2 },
			{ x = -P2,	y = H-2*P2 },
			{ x = -H/2+P2,	y = H/2 },
		}
		for k,v in ipairs(arrow) do
			v.x = v.x - (N*0.5)*W
		end

		surface.SetDrawColor(self.LastColor or Color(0,0,0,0))
		surface.DrawPoly(arrow)
	cam.End3D2D()
end

include("shared.lua")
local frame = nil
function CreateFrame()
	if !frame or !frame:IsValid() then
		local self = net.ReadEntity()
		local Map = game.GetMap() or ""
		if Map:find("gm_metrostroi") and Map:find("lite") then
			Map = "gm_metrostroi_lite"
		elseif Map:find("gm_metrostroi") then
			Map = "gm_metrostroi"
		elseif Map:find("gm_mus_orange_line") and Map:find("long") then
			Map = "gm_orange"
		elseif Map:find("gm_mus_orange_line") then
			Map = "gm_orange_lite"
		end
		frame = vgui.Create("DFrame")
			frame:SetDeleteOnClose(true)
			frame:SetTitle("Dispatch control")
			--frame:SetSize(275, 34+24*17)
			frame:SetDraggable(false)
			frame:SetSizable(false)
			frame:MakePopup()

		frame:SetSize(ScrW()-40,ScrH()-40)
		frame:Center()
		local StationChoose = vgui.Create( "DComboBox",frame )
			StationChoose:SetPos( 5, 30 )
			StationChoose:SetSize( 250, 20 )
			StationChoose:SetValue( "Choose station" )
			for k,v in pairs(Metrostroi.WorkingStations[Map][1]) do
				if Metrostroi.AnnouncerData[v] then StationChoose:AddChoice(Metrostroi.AnnouncerData[v][1]) end
			end

		local PlayerChoose = vgui.Create( "DComboBox",frame )
			PlayerChoose:SetPos( ScrW()-300,30 )
			PlayerChoose:SetSize( 250, 20 )
			PlayerChoose:SetValue( "Choose player" )
			for i = 1,20 do
				PlayerChoose:AddChoice(i)
			end

		local Main = vgui.Create( "DPanel",frame )
			Main:SetPos(0,60)
			Main:SetSize(frame:GetWide(),frame:GetTall()-60)
			Main.Paint = function(self,w,h)
				surface.DrawRect(5, 0, w-10, h-5)
			end
				
	end
end
function ENT:Initialize()
end
net.Receive("TrackController",CreateFrame)
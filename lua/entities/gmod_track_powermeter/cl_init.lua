include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	
	--self:SetNW2Float("Total",Metrostroi.TotalkWh)
	--self:SetNW2Float("Rate",Metrostroi.TotalRateWatts)

	local pos = self:LocalToWorld(Vector(4.6,-5.5,14))
	local ang = self:LocalToWorldAngles(Angle(0,90,90))
	cam.Start3D2D(pos, ang, 1/16)
		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawRect(6, 32+64*0, 192-24, 32)
		surface.DrawRect(6, 32+64*1, 192-24, 32)
		surface.DrawRect(6, 32+64*2, 192-24, 32)
		surface.DrawRect(6, 32+64*3, 192-24, 32)
		surface.DrawRect(6, 32+64*4, 192-24, 32)
		
		draw.DrawText(Format("%07.0f",self:GetTotal()*1000),"MetrostroiSubway_IGLA",6+4,32+64*0,Color(255,255,255,255))
		--draw.DrawText(",","MetrostroiSubway_IGLA",20+4+26,32+64*0,Color(255,255,255,255))
		draw.DrawText(".","MetrostroiSubway_IGLA",20+4+64+4,32+64*0+2,Color(255,255,255,255))
		draw.DrawText("E (watts-hour)","MetrostroiSubway_VerySmallText3",16,6+64*0,Color(0,0,0,255))
		
		draw.DrawText(Format("%07.1f",self:GetRate()*1e-3),"MetrostroiSubway_IGLA",6+4,32+64*1,Color(255,255,255,255))
		draw.DrawText("P (kW)","MetrostroiSubway_VerySmallText3",16,8+64*1,Color(0,0,0,255))
		
		draw.DrawText(Format("%7.2f",Metrostroi.GetEnergyCost(self:GetTotal())),"MetrostroiSubway_IGLA",6+4,32+64*2,Color(255,255,255,255))
		draw.DrawText("Cost ($)","MetrostroiSubway_VerySmallText3",16,8+64*2,Color(0,0,0,255))
		
		draw.DrawText(Format("%7.1f",self:GetV()),"MetrostroiSubway_IGLA",6+4,32+64*3,Color(255,255,255,255))
		draw.DrawText("Voltage (V)","MetrostroiSubway_VerySmallText3",16,8+64*3,Color(0,0,0,255))
		
		draw.DrawText(Format("%7.1f",self:GetA()),"MetrostroiSubway_IGLA",6+4,32+64*4,Color(255,255,255,255))
		draw.DrawText("Current (A)","MetrostroiSubway_VerySmallText3",16,8+64*4,Color(0,0,0,255))
		
		--Metrostroi.DrawClockDigit(56+170,48,2.0,0)

		--[[local T0 = self:GetNW2Float("T0",os.time())+1396011937
		local T1 = self:GetNW2Float("T1",CurTime())
		local dT = (os.time()-T0 + (CurTime() % 1.0)) - (CurTime()-T1)
		
		local digits = { 1,2,3,4,5,6 }
		local os_time = os.time()-dT
		local d = os.date("!*t",os_time)
		digits[1] = math.floor(d.hour / 10)
		digits[2] = math.floor(d.hour % 10)
		digits[3] = math.floor(d.min / 10)
		digits[4] = math.floor(d.min % 10)
		digits[5] = math.floor(d.sec / 10)
		digits[6] = math.floor(d.sec % 10)

		for i,v in ipairs(digits) do
			local j = i-1
			local x = 56+100*(i-1)+50*math.floor((i-1)/2)
			local y = 48
			Metrostroi.DrawClockDigit(x,y,1.7,v)
		end
		Metrostroi.DrawClockDigit(56+170,48,1.7,".")]]--
	cam.End3D2D()
	
	
end
--------------------------------------------------------------------------------
-- Debug: spawn train on metrostroi
--------------------------------------------------------------------------------
function Metrostroi.DebugTrain()
	local base = Vector(1000.284180,-15152.133789,24.219715-170)

	local ent = ents.Create("gmod_subway_81-717")
	ent:SetPos(base+0*Vector(-955,0,0))
	ent:SetAngles(Angle(0,180,0))
	ent:Spawn()
	
	local ent = ents.Create("gmod_subway_81-714")
	ent:SetPos(base+1*Vector(-955,0,0))
	ent:SetAngles(Angle(0,180,0))
	ent:Spawn()
	
	local ent = ents.Create("gmod_subway_81-714")
	ent:SetPos(base+2*Vector(-955,0,0))
	ent:SetAngles(Angle(0,180,0))
	ent:Spawn()
	
	local ent = ents.Create("gmod_subway_81-714")
	ent:SetPos(base+3*Vector(-955,0,0))
	ent:SetAngles(Angle(0,180,0))
	ent:Spawn()

	local ent = ents.Create("gmod_subway_81-717")
	ent:SetPos(base+4*Vector(-955,0,0))
	ent:SetAngles(Angle(0,0,0))
	ent:Spawn()
end
function Metrostroi.DebugTrain1()
	local base = Vector(15131.00,-11900,-369.720795-170)

	local ent = ents.Create("gmod_subway_81-717")
	ent:SetPos(base+0*Vector(0,-955,0))
	ent:SetAngles(Angle(0,270,0))
	ent:Spawn()

	local ent = ents.Create("gmod_subway_81-714")
	ent:SetPos(base+1*Vector(0,-955,0))
	ent:SetAngles(Angle(0,270,0))
	ent:Spawn()

	local ent = ents.Create("gmod_subway_81-714")
	ent:SetPos(base+2*Vector(0,-955,0))
	ent:SetAngles(Angle(0,270,0))
	ent:Spawn()

	local ent = ents.Create("gmod_subway_81-714")
	ent:SetPos(base+3*Vector(0,-955,0))
	ent:SetAngles(Angle(0,270,0))
	ent:Spawn()

	local ent = ents.Create("gmod_subway_81-717")
	ent:SetPos(base+4*Vector(0,-955,0))
	ent:SetAngles(Angle(0,90,0))
	ent:Spawn()
end

function Metrostroi.DebugTrain2()
	local base = Vector(14450.80,-11900,-369.720795-170)

	local ent = ents.Create("gmod_subway_81-717")
	ent:SetPos(base+0*Vector(0,-955,0))
	ent:SetAngles(Angle(0,270,0))
	ent:Spawn()

	local ent = ents.Create("gmod_subway_81-714")
	ent:SetPos(base+1*Vector(0,-955,0))
	ent:SetAngles(Angle(0,270,0))
	ent:Spawn()

	local ent = ents.Create("gmod_subway_81-714")
	ent:SetPos(base+2*Vector(0,-955,0))
	ent:SetAngles(Angle(0,270,0))
	ent:Spawn()

	local ent = ents.Create("gmod_subway_81-714")
	ent:SetPos(base+3*Vector(0,-955,0))
	ent:SetAngles(Angle(0,270,0))
	ent:Spawn()

	local ent = ents.Create("gmod_subway_81-717")
	ent:SetPos(base+4*Vector(0,-955,0))
	ent:SetAngles(Angle(0,90,0))
	ent:Spawn()
end

function Metrostroi.DebugTrain(base,ang)
	base = base + Vector(0,0,-160)
	
	local ent = ents.Create("gmod_subway_81-717")
	ent:SetPos(base+0*955*ang:Forward())
	ent:SetAngles(ang)
	ent:Spawn()

	local ent = ents.Create("gmod_subway_81-714")
	ent:SetPos(base+1*955*ang:Forward())
	ent:SetAngles(ang)
	ent:Spawn()

	local ent = ents.Create("gmod_subway_81-714")
	ent:SetPos(base+2*955*ang:Forward())
	ent:SetAngles(ang)
	ent:Spawn()

	local ent = ents.Create("gmod_subway_81-714")
	ent:SetPos(base+3*955*ang:Forward())
	ent:SetAngles(ang)
	ent:Spawn()

	local ent = ents.Create("gmod_subway_81-717")
	ent:SetPos(base+4*955*ang:Forward())
	ent:SetAngles(ang + Angle(0,180,0))
	ent:Spawn()
end

function Metrostroi.SpawnDepot1(idx)
	if (not idx) or (idx == 1) then Metrostroi.DebugTrain(Vector(-2235.816406,-7250.668457,-2486.183594),Angle(0,90-11.25,0)) end
	if (not idx) or (idx == 2) then Metrostroi.DebugTrain(Vector(-2233.157715,-8258.770508,-2486.118652),Angle(0,90-11.25,0)) end
	if (not idx) or (idx == 3) then Metrostroi.DebugTrain(Vector(-2231.008301,-9273.424805,-2486.197266),Angle(0,90-11.25,0)) end
end

--Metrostroi.DebugTrain()
--Metrostroi.DebugTrain2()

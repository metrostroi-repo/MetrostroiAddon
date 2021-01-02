ENT.Type            = "anim"

ENT.Category		= "Metrostroi (utility)"

ENT.Spawnable       = true
ENT.AdminSpawnable  = false

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "IntervalResetTime")
	self:NetworkVar("Float", 0, "IntervalResetTime")
end

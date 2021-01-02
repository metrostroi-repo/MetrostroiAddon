ENT.Type            = "anim"

ENT.Category		= "Metrostroi (utility)"

ENT.Spawnable       = true
ENT.AdminSpawnable  = false

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "Total" )
	self:NetworkVar("Float", 1, "Rate" )
	self:NetworkVar("Float", 2, "V")
	self:NetworkVar("Float", 3, "A" )
end

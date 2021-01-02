ENT.Type            = "anim"

ENT.Category		= "Metrostroi (utility)"

ENT.Spawnable       = true
ENT.AdminSpawnable  = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Channel")
end

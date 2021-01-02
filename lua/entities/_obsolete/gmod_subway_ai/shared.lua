ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.PrintNameT       = "AI Train"
ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category		= "Metrostroi (trains)"

ENT.Spawnable       = false --NOT FINISHED
ENT.AdminSpawnable  = false --NOT FINISHED

function ENT:PassengerCapacity()
	return 300
end

function ENT:GetStandingArea()
	return Vector(-450,-30,-45),Vector(380,30,-45)
end

function ENT:InitializeSystems()
	self:LoadSystem("ALS_ARS")
end

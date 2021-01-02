-- FIXME: this should be point, but for some reason it won't call init/think callbacks that way
--ENT.Type			= "point"
ENT.Type			= "anim"
ENT.PrintName		= "Train Platform"
ENT.Spawnable		= false
ENT.AdminSpawnable	= false

function ENT:PoolSize()
	return 1024
end

function ENT:Seed()
	return self:EntIndex()
end

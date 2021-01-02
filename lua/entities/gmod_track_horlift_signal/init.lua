AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--------------------------------------------------------------------------------
-- Load key-values defined in VMF
--------------------------------------------------------------------------------
function ENT:KeyValue(key, value)
	self.VMF = self.VMF or {}
	self.VMF[key] = value
end

function ENT:Initialize()
	self.VMF = self.VMF or {}
	self.Type		= (tonumber(self.VMF.Type) or 0)
	if self.Type == 0 then
		self:SetModel("models/metrostroi/signals/mus/light_2_horlift_out.mdl")
	else
		self:SetModel("models/metrostroi/signals/mus/light_2_horlift_in.mdl")
	end
	self:SetNWInt("Type",self.Type)

	self.YellowSignal = true
	self.WhiteSignal = false

end
function ENT:Think()
	self:SetNWBool("Yellow",self.YellowSignal)
	self:SetNWBool("White",self.WhiteSignal)
	self:SetNWBool("White2",self.PeopleGoing)
	self:NextThink(CurTime() + 0.50)
	return true
end

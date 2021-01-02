ENT.Type			= "anim"
ENT.PrintName		= "Horizontal Lift Station Signalling"
ENT.Category		= "Metrostroi (utility)"

ENT.Spawnable		= false
ENT.AdminSpawnable	= false


--------------------------------------------------------------------------------
function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "ActiveSignals")
end

local function addBitField(name)
	ENT["Set"..name.."Bit"] = function(self,idx,value)
		local packed_value = bit.lshift(value and 1 or 0,idx)
		local mask = bit.bnot(bit.lshift(1,idx))
		self["Set"..name](self,bit.bor(bit.band(self["Get"..name](self),mask),packed_value))
	end

	ENT["Get"..name.."Bit"] = function(self,idx)
		local mask = bit.lshift(1,idx)
		return bit.band(self["Get"..name](self),mask) ~= 0
	end
end

local function addBitParameter(name,field,bit)
	ENT["Set"..name] = function(self,value)
		self["Set"..field.."Bit"](self,bit,value)
	end

	ENT["Get"..name] = function(self)
		return self["Get"..field.."Bit"](self,bit)
	end
end

addBitField("ActiveSignals")
ENT.Type            = "anim"

ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "Metrostroi (utility)"

ENT.Spawnable       = true
ENT.AdminSpawnable  = false

physenv.AddSurfaceData([[
"gmod_silent"
{

	"impacthard"	"DoorSound.Null"
	"impactsoft"	"DoorSound.Null"

	"audiohardnessfactor" "0.0"
	"audioroughnessfactor" "0.0"

	"scrapeRoughThreshold" "1.0"
	"impactHardThreshold" "1.0"
	"gamematerial"	"X"
}
"gmod_ice"
{
	"friction"	"0.01"
	"elasticity"	"0.01"
	"audioroughnessfactor" "0.1"
	"gamematerial"	"X"
}
]])
function ENT:GetSpeed()
	return self:GetNW2Int("Speed")/5
end
function ENT:GetMotorPower()
	return self:GetNW2Int("MotorPower")/50
end
function ENT:GetBrakeSqueal()
	return self:GetNW2Int("BrakeSqueal")/10
end

if SERVER then
	function ENT:SetSpeed(val)
		if self.OldSpeed == math.floor(val*5) then return end
		self.OldSpeed = math.floor(val*5)
		self:SetNW2Int("Speed",self.OldSpeed)
	end

	function ENT:SetMotorPower(val)
		if self.OldMotorPower == math.floor(val*50) then return end
		self.OldMotorPower = math.floor(val*50)
		self:SetNW2Int("MotorPower",self.OldMotorPower)
	end

	function ENT:SetBrakeSqueal(val)
		if self.OldBrakeSqueal == math.floor(val*10) then return end
		self.OldBrakeSqueal = math.floor(val*10)
		self:SetNW2Int("BrakeSqueal",self.OldBrakeSqueal)
	end
end
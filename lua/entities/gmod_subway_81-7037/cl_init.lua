include("shared.lua")


--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}

--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false

--------------------------------------------------------------------------------
-- Add doors
local function GetDoorPosition(i,k,j)
	if j == 0 
	then return Vector(347.5 - 32*k     - 230*i,-65*(1-2*k),-2.8)
	else return Vector(347.5 - 32*(1-k) - 230*i,-65*(1-2*k),-2.8)
	end
end
for i=0,3 do
	for k=0,1 do
		ENT.ClientProps["door"..i.."x"..k.."a"] = {
			model = "models/metrostroi/81/81-7036_door1.mdl",
			pos = GetDoorPosition(i,k,0),
			ang = Angle(0,180*(1-k),0)
		}
		ENT.ClientProps["door"..i.."x"..k.."b"] = {
			model = "models/metrostroi/81/81-7036_door2.mdl",
			pos = GetDoorPosition(i,k,1),
			ang = Angle(0,180*(1-k),0)
		}
	end
end
table.insert(ENT.ClientProps,{
	model = "models/metrostroi/81/81-7036_door4.mdl",
	pos = Vector(-487.0,-2.2,-4.5),
	ang = Angle(0,0,0)
})
table.insert(ENT.ClientProps,{
	model = "models/metrostroi/81/81-7036_door4.mdl",
	pos = Vector(461.0,1.2,-4.5),
	ang = Angle(0,180,0)
})



--------------------------------------------------------------------------------
function ENT:Think()
	self.BaseClass.Think(self)
end

function ENT:Draw()
	self.BaseClass.Draw(self)
end
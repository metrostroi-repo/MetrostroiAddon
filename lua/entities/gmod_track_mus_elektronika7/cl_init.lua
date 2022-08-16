include("shared.lua")
ENT.DigitPositions = {
  Vector(0,17,0),
  Vector(0,7,0),
  Vector(0,-6.5,0),
  Vector(0,-16.5,0),
}

function ENT:Initialize()
    self.Digits = {}
end

function ENT:Think()
  if self:IsDormant() then self:OnRemove();return end
	for k,v in pairs(self.DigitPositions) do
        if not IsValid(self.Digits[k]) then
            --self.Digits[k] = ents.CreateClientProp("models/metrostroi/81-717/reverser.mdl")
            --self.Digits[k]:SetModel(("models/mus/ussr_clock_model/num_"..(k == 1 and "no" or "").."zero.mdl"))
            --hook.Add("MetrostroiBigLag",self.Digits[k],function(ent)
            --    ent:SetPos(self:LocalToWorld(v))
            --    ent:SetAngles(self:GetAngles())
            --    --if ent.Spawned then hook.Remove("MetrostroiBigLag",ent) end
            --    --ent.Spawned = true
            --end)
            self.Digits[k] = ClientsideModel("models/mus/ussr_clock_model/num_"..(k == 1 and "no" or "").."zero.mdl",RENDERGROUP_OPAQUE)
            if not IsValid(self.Digits[k]) then break end
            self.Digits[k]:SetPos(self:LocalToWorld(v))
            self.Digits[k]:SetAngles(self:GetAngles())
            self.Digits[k]:SetSkin(10)
            self.Digits[k]:SetParent(self)
        end
	end

	local d = os.date("!*t",Metrostroi.GetSyncTime())
	if IsValid(self.Digits[1]) then self.Digits[1]:SetSkin(math.floor(d.hour / 10)) end
	if IsValid(self.Digits[2]) then self.Digits[2]:SetSkin(math.floor(d.hour % 10)) end
	if IsValid(self.Digits[3]) then self.Digits[3]:SetSkin(math.floor(d.min  / 10)) end
	if IsValid(self.Digits[4]) then self.Digits[4]:SetSkin(math.floor(d.min  % 10)) end
end

function ENT:OnRemove()
  for _,v in pairs(self.Digits) do
		SafeRemoveEntity(v)
	end
end
function ENT:Draw()
	self:DrawModel()
end

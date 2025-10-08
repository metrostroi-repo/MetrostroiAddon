include("shared.lua")
ENT.DigitPositions = {
  {
    {Vector(16+7,-1,1)},
    {Vector(9+7,-1,1)},
    {Vector(-0+7,-1,1)},
    {Vector(-7+7,-1,1)},
    {Vector(-16+7,-1,1)},
    {Vector(-23+7,-1,1)},
    {Vector(-11+7-0.5,-1,0.7), true}, --точка
    {Vector(5+7-0.5,-1,0.7), true}, --точка
    {Vector(-7+7,-1,-11)},
    {Vector(-16+7,-1,-11)},
    {Vector(-23+7,-1,-11)},
    {Vector(-11+7-0.5,-1,-11.3), true}, -- точка
  },{
    {Vector(18.3,-0.3,0.8)},
    {Vector(12.8,-0.3,0.8)},
    {Vector( 7.3,-0.3,0.8)},
    {Vector( 1.8,-0.3,0.8)},
    {Vector(-3.7,-0.3,0.8)},
    {Vector(-9.2,-0.3,0.8)},
    {Vector( 8.8,-0.3,0.5), true}, --точка
    {Vector(-2.3,-0.3,0.5), true}, --точка
    {Vector(18.3,-0.3,-8.7)},
    {Vector(12.8,-0.3,-8.7)},
    {Vector( 7.3,-0.3,-8.7)},
    {Vector(14.2,-0.3,-9), true}, -- точка

  }
}

function ENT:Initialize()
    self.Digits = {}
end
function ENT:Think()
  if self:IsDormant() then self:OnRemove();return end
	for k,v in pairs(self.DigitPositions[self:GetNW2Int("Type") == 2 and 2 or 1]) do
		if not IsValid(self.Digits[k]) then
      local model
      if v[2] then
        if self:GetNW2Int("Type") == 2 then
    			model = "models/metrostroi/mus_clock/ind_small_orange_dot_spb.mdl"
        else
    			model = "models/metrostroi/mus_clock/ind_small_"..(self:GetNW2Int("Type") == 1 and "red" or "orange").."_dot.mdl"
        end
      else
        if self:GetNW2Int("Type") == 2 then
    			model = "models/metrostroi/mus_clock/ind_small_orange_numb_spb.mdl"
        else
    			model = "models/metrostroi/mus_clock/ind_small_"..(self:GetNW2Int("Type") == 1 and "red" or "orange").."_numb.mdl"
        end
      end
      --self.Digits[k] = ents.CreateClientProp("models/metrostroi/81-717/reverser.mdl")
      --self.Digits[k]:SetModel(model)
      --hook.Add("MetrostroiBigLag",self.Digits[k],function(ent)
      --  ent:SetPos(self:LocalToWorld(v[1]))
      --  --if ent.Spawned then hook.Remove("MetrostroiBigLag",ent) end
      --  --ent.Spawned = true
      --end)
      self.Digits[k] = ClientsideModel(model,RENDERGROUP_OPAQUE)
      if not IsValid(self.Digits[k]) then break end
      self.Digits[k]:SetPos(self:LocalToWorld(v[1]))
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
	if IsValid(self.Digits[5]) then self.Digits[5]:SetSkin(math.floor(d.sec  / 10)) end
	if IsValid(self.Digits[6]) then self.Digits[6]:SetSkin(math.floor(d.sec  % 10)) end

	--local dT = Metrostroi.GetTimedT()
	local interval = Metrostroi.GetSyncTime() - (self:GetIntervalResetTime()+GetGlobalFloat("MetrostroiTY"))
	if (interval <= (9*60+59)) and (interval >= 0) then
		if IsValid(self.Digits[9])  then self.Digits[9]:SetSkin(math.floor(interval/60)) end
		if IsValid(self.Digits[10]) then self.Digits[10]:SetSkin(math.floor((interval%60)/10)) end
		if IsValid(self.Digits[11]) then self.Digits[11]:SetSkin(math.floor((interval%60)%10)) end
	else
		for i = 9,11 do
			if IsValid(self.Digits[i]) then
				self.Digits[i]:SetSkin(10)
			end
		end
	end
end
function ENT:OnRemove()
    for _,v in pairs(self.Digits) do
			SafeRemoveEntity(v)
		end
end
function ENT:Draw()
	self:DrawModel()
end

include("shared.lua")

SWEP.PrintName			= "Train Reverser Wrench"
SWEP.Slot				= 3
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true

SWEP.HoldType = "normal"
SWEP.ViewModelFOV = 53
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["ValveBiped.eject"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.base"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.muzzle"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Finger12"] = { scale = Vector(1, 1, 1), pos = Vector(-0.172, -1.084, 0), angle = Angle(0, -58.672, 0) },
	["ValveBiped.square"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.hammer"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.clip"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
--Ironsights
SWEP.IronSightsPos = Vector(3.64, 0, 2.2)
SWEP.IronSightsAng = Vector(0, 0, 0)
--ViewModel
SWEP.VElements = {
	["Reverser"] = { type = "Model", model = "models/metrostroi_train/reversor/reversor_classic.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.93, 1.421, -7), angle = Angle(-4, 96, -95), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.VDigits = {
    Vector(0.3,-4.25-0.65+(-1)*0.3,0.9+0+0*0.005),
    Vector(0.3,-4.25-0.65+(-0)*0.3,0.9+0+1*0.005),
    Vector(0.3,-4.25-0.65+( 1)*0.3,0.9+0+2*0.005),
    Vector(0.3,-4.25-0.65+( 2)*0.3,0.9+0+3*0.005),
    Vector(0.3,-4.25-0.65+( 3)*0.3,0.9+0+4*0.005),
}
for i,v in pairs(SWEP.VDigits) do
    local reverser = SWEP.VElements.Reverser
    local pos,ang = LocalToWorld(v,Angle(0,-91,-91),reverser.pos,reverser.angle)
    SWEP.VElements["Digit"..i] = {
        type = "Model",
        model = "models/metrostroi_train/reversor/revers_number10.mdl",
        bone = "ValveBiped.Bip01_R_Hand", rel = "",
        pos = pos,
        angle = ang,
        size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}
    }
end
--WorldModel
SWEP.WElements = {
	["Reverser"] = { type = "Model", model = "models/metrostroi_train/reversor/reversor_classic.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.93-1, 1.421+1.5, -6.374+1), angle = Angle(-106+90+180, 175, -111+190), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:ResetBonePositions(vm)
	if (not vm:GetBoneCount()) then return end
	for i=0, vm:GetBoneCount() do
		vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
		vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
		vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
	end
end
function SWEP:Initialize()
	--self.VElements = table.FullCopy( self.VElements )
	--self.WElements = table.FullCopy( self.WElements )
	--self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

	self:CreateModels(self.VElements) --create viewmodels
	self:CreateModels(self.WElements) --create worldmodels

	if IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			--self:ResetBonePositions(vm)

			if (self.ShowViewModel == nil or self.ShowViewModel) then
				vm:SetColor(color_white)
			else
				vm:SetColor(color_transparent)

				vm:SetMaterial("Debug/hsv")
			end
		end
	end
end

function SWEP:Holster()

	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end

	return true
end

function SWEP:OnRemove()
	self:Holster()
end

SWEP.vRenderOrder = nil
function SWEP:ViewModelDrawn()

	local vm = self.Owner:GetViewModel()
	if not IsValid(vm) then return end

	if (not self.VElements) then return end

	self:UpdateBonePositions(vm)

	if (not self.vRenderOrder) then

		--we build a render order because sprites need to be drawn after models
		self.vRenderOrder = {}

		for k, v in pairs( self.VElements ) do
			if (v.type == "Model") then
				table.insert(self.vRenderOrder, 1, k)
			elseif (v.type == "Sprite" or v.type == "Quad") then
				table.insert(self.vRenderOrder, k)
			end
		end

	end

	for k, name in ipairs( self.vRenderOrder ) do

		local v = self.VElements[name]
		if (not v) then self.vRenderOrder = nil break end
		if (v.hide) then continue end
		if not IsValid(v.modelEnt) then
			self:CreateModels(self.VElements) --create viewmodels
		end
		local model = v.modelEnt
		local sprite = v.spriteMaterial
		if (not v.bone) then continue end

		local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )

		if (not pos) then continue end

		if (v.type == "Model" and IsValid(model)) then

			model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)

			model:SetAngles(ang)
			--model:SetModelScale(v.size)
			local matrix = Matrix()
			matrix:Scale(v.size)
			model:EnableMatrix( "RenderMultiply", matrix )

			if (v.material == "") then
				model:SetMaterial("")
			elseif (model:GetMaterial() ~= v.material) then
				model:SetMaterial( v.material )
			end

			if (v.skin and v.skin ~= model:GetSkin()) then
				model:SetSkin(v.skin)
			end

			if (v.bodygroup) then
				for k, v in pairs( v.bodygroup ) do
					if (model:GetBodygroup(k) ~= v) then
						model:SetBodygroup(k, v)
					end
				end
			end

			if (v.surpresslightning) then
				render.SuppressEngineLighting(true)
			end

			render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
			render.SetBlend(v.color.a/255)
			model:DrawModel()
			render.SetBlend(1)
			render.SetColorModulation(1, 1, 1)

			if (v.surpresslightning) then
				render.SuppressEngineLighting(false)
			end
		end
	end
end

SWEP.wRenderOrder = nil
function SWEP:DrawWorldModel()

	if (self.ShowWorldModel == nil or self.ShowWorldModel) then
		self:DrawModel()
	end

	if (not self.WElements) then return end

	if (not self.wRenderOrder) then

		self.wRenderOrder = {}

		for k, v in pairs( self.WElements ) do
			if (v.type == "Model") then
				table.insert(self.wRenderOrder, 1, k)
			end
		end

	end

	if (IsValid(self.Owner)) then
		bone_ent = self.Owner
	else
		--when the weapon is dropped
		bone_ent = self
	end

	for k, name in pairs( self.wRenderOrder ) do

		local v = self.WElements[name]
		if (not v) then self.wRenderOrder = nil break end
		if (v.hide) then continue end

		local pos, ang

		if (v.bone) then
			pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
		else
			pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
		end

		if (not pos) then continue end

		if not IsValid(v.modelEnt) then
			self:CreateModels(self.WElements) --create worldmodels
		end
		local model = v.modelEnt
		local sprite = v.spriteMaterial

		if (v.type == "Model" and IsValid(model)) then

			model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)

			model:SetAngles(ang)
			--model:SetModelScale(v.size)
			local matrix = Matrix()
			matrix:Scale(v.size)
			model:EnableMatrix( "RenderMultiply", matrix )

			if (v.material == "") then
				model:SetMaterial("")
			elseif (model:GetMaterial() ~= v.material) then
				model:SetMaterial( v.material )
			end

			if (v.skin and v.skin ~= model:GetSkin()) then
				model:SetSkin(v.skin)
			end

			if (v.bodygroup) then
				for k, v in pairs( v.bodygroup ) do
					if (model:GetBodygroup(k) ~= v) then
						model:SetBodygroup(k, v)
					end
				end
			end

			if (v.surpresslightning) then
				render.SuppressEngineLighting(true)
			end

			render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
			render.SetBlend(v.color.a/255)
			model:DrawModel()
			render.SetBlend(1)
			render.SetColorModulation(1, 1, 1)

			if (v.surpresslightning) then
				render.SuppressEngineLighting(false)
			end
		end
	end
end

function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )

	local bone, pos, ang
	if (tab.rel and tab.rel ~= "") then

		local v = basetab[tab.rel]

		if (not v) then return end

		--Technically, if there exists an element with the same name as a bone
		--you can get in an infinite loop. Let's just hope nobody's that stupid.
		pos, ang = self:GetBoneOrientation( basetab, v, ent )

		if (not pos) then return end

		pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
		ang:RotateAroundAxis(ang:Up(), v.angle.y)
		ang:RotateAroundAxis(ang:Right(), v.angle.p)
		ang:RotateAroundAxis(ang:Forward(), v.angle.r)

	else

		bone = ent:LookupBone(bone_override or tab.bone)

		if (not bone) then return end

		pos, ang = Vector(0,0,0), Angle(0,0,0)
		local m = ent:GetBoneMatrix(bone)
		if (m) then
			pos, ang = m:GetTranslation(), m:GetAngles()
		end

		if (IsValid(self.Owner) and self.Owner:IsPlayer() and
			ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
			ang.r = -ang.r --Fixes mirrored models
		end

	end

	return pos, ang
end

function SWEP:CreateModels( tab )

	if (not tab) then return end

	--Create the clientside models here because Garry says we can't do it in the render hook
	for k, v in pairs( tab ) do
		if (v.type == "Model" and v.model and v.model ~= "" and (not IsValid(v.modelEnt) or v.createdModel ~= v.model) and
				string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then

			v.modelEnt = ents.CreateClientProp("models/metrostroi_train/reversor/reversor_classic.mdl")
			v.modelEnt:SetModel(v.model)
			if (IsValid(v.modelEnt)) then
				v.modelEnt:SetPos(self:GetPos())
				v.modelEnt:SetAngles(self:GetAngles())
				v.modelEnt:SetParent(self)
				v.modelEnt:SetNoDraw(true)
				v.createdModel = v.model
			else
				v.modelEnt = nil
			end
		end
	end
end

local allbones
local hasGarryFixedBoneScalingYet = false

function SWEP:UpdateBonePositions(vm)
		if (not vm:GetBoneCount()) then return end

		--not not  WORKAROUND not not  --
		--We need to check all model names :/
		local loopthrough = self.ViewModelBoneMods
		if (not hasGarryFixedBoneScalingYet) then
			allbones = {}
			for i=0, vm:GetBoneCount() do
				local bonename = vm:GetBoneName(i)
				if (self.ViewModelBoneMods[bonename]) then
					allbones[bonename] = self.ViewModelBoneMods[bonename]
				else
					allbones[bonename] = {
						scale = Vector(1,1,1),
						pos = Vector(0,0,0),
						angle = Angle(0,0,0)
					}
				end
			end

			loopthrough = allbones
		end
		--not not  ----------- not not  --

		for k, v in pairs( loopthrough ) do
			local bone = vm:LookupBone(k)
			if (not bone) then continue end

			--not not  WORKAROUND not not  --
			local s = Vector(v.scale.x,v.scale.y,v.scale.z)
			local p = Vector(v.pos.x,v.pos.y,v.pos.z)
			local ms = Vector(1,1,1)
			if (not hasGarryFixedBoneScalingYet) then
				local cur = vm:GetBoneParent(bone)
				while(cur >= 0) do
					local pscale = loopthrough[vm:GetBoneName(cur)].scale
					ms = ms * pscale
					cur = vm:GetBoneParent(cur)
				end
			end

			s = s * ms
			--not not  ----------- not not  --

			if vm:GetManipulateBoneScale(bone) ~= s then
				vm:ManipulateBoneScale( bone, s )
			end
			if vm:GetManipulateBoneAngles(bone) ~= v.angle then
				vm:ManipulateBoneAngles( bone, v.angle )
			end
			if vm:GetManipulateBonePosition(bone) ~= p then
				vm:ManipulateBonePosition( bone, p )
			end
		end
end

--[[
	Global utility code

--Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
--Does not copy entities of course, only copies their reference.
--WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
function table.FullCopy( tab )
	if (not tab) then return nil end

	local res = {}
	for k, v in pairs( tab ) do
		if (type(v) == "table") then
			res[k] = table.FullCopy(v) --recursion honot
		elseif (type(v) == "Vector") then
			res[k] = Vector(v.x, v.y, v.z)
		elseif (type(v) == "Angle") then
			res[k] = Angle(v.p, v.y, v.r)
		else
			res[k] = v
		end
	end

	return res
end

]]--
SWEP.Choosed = 1
SWEP.Sounds = {
	"subway_trains/717/kv70/reverser_0-b_2.mp3",
	"subway_trains/717/kv70/reverser_0-f_1.mp3",
	"subway_trains/717/kv70/reverser_0-f_2.mp3",
	"subway_trains/717/kv70/reverser_b-0_1.mp3",
	"subway_trains/717/kv70/reverser_b-0_2.mp3",
	"subway_trains/717/kv70/reverser_f-0_1.mp3",
	"subway_trains/717/kv70/reverser_f-0_2.mp3",
	"subway_trains/717/kv70/reverser_0-b_1.mp3",
}
function SWEP:Precache()
	for _,v in pairs(self.Sounds) do
		util.PrecacheSound(v)
	end
end

function SWEP:Initialize()
	self:SetWeaponHoldType("melee")
end

function SWEP:Reload()

end

function SWEP:PrimaryAttack()
	if IsFirstTimePredicted() then
	end
	self:SetNextPrimaryFire( CurTime() + 10 )
end

function SWEP:SecondaryAttack()
	--[[
	if IsFirstTimePredicted() then
		if LocalPlayer() == self.Owner then
			self.Choosed = self.Choosed + 1
			print(self.Choosed)
			if self.Choosed > #self.Modes then
				self.Choosed = 1
			end
		end
		self.Weapon:EmitSound("buttons/button17.wav")
	end
	]]
	self:SetNextSecondaryFire( CurTime() + 0.5 )
end

function SWEP:Deploy()
   self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
end


function SWEP:Think()
    local count = 0
    if self.Code ~= self:GetNW2Int("Code",-1) then
        local code = self:GetNW2Int("Code",-1)
        if code > 0 then
            for k,v in pairs(self.VElements) do
                local ent = v.modelEnt
                if k=="Reverser" or not IsValid(ent) then continue end
                local i = tonumber(k:sub(6,-1))-1
                local num = math.floor(code%(10^(i+1))/10^i)
                ent:SetModel("models/metrostroi_train/reversor/revers_number1"..num..".mdl")
                count = count + 1
            end
            for k,v in pairs(self.WElements) do
                local ent = v.modelEnt
                if k=="Reverser" or not IsValid(ent) then continue end
                local i = tonumber(k:sub(6,-1))-1
                local num = math.floor(code%(10^(i+1))/10^i)
                ent:SetModel("models/metrostroi_train/reversor/revers_number1"..num..".mdl")
            end
        else
            count=5
        end
    end
    if count==5 then
        self.Code = self:GetNW2Int("Code",-1)
    end
end
function SWEP:DrawHUD()
end

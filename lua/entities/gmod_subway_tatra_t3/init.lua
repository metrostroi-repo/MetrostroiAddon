AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")



---------------------------------------------------
-- Defined train information                      
-- Types of wagon(for wagon limit system):
-- 0 = Head or intherim                           
-- 1 = Only head                                     
-- 2 = Only intherim                                
---------------------------------------------------
ENT.SubwayTrain = {
	Type = "Tatra",
	Name = "Tatra T3",
	WagType = 0,
	Manufacturer = "ChKD",
}

function ENT:Initialize()

	-- Set model and initialize
	self:SetModel("models/metrostroi/tatra_t3/tatra_t3.mdl")
	self.BaseClass.Initialize(self)
	self:SetPos(self:GetPos() + Vector(0,0,140))
	
	-- Create seat entities
	self.DriverSeat = self:CreateSeat("driver",Vector(305,10,-12))
	--self.InstructorsSeat = self:CreateSeat("instructor",Vector(395,35,-30))
	
	-- Create bogeys
	self.FrontBogey = self:CreateBogey(Vector( 160,0,-60),Angle(0,180,0),true,"tatra")
	self.RearBogey  = self:CreateBogey(Vector(-150,0,-60),Angle(0,0,0),false,"tatra")
	
	-- Create joins
	self.FrontJoin = self:CreateJoin(Vector(350,0,-50),false)
	self.RearJoin = self:CreateJoin(Vector(-350,0,-50),true)
	
	-- Initialize key mapping
	self.KeyMap = {
		[KEY_W] = "Drive",
		[KEY_S] = "Brake",
		[KEY_R] = "Reverse",
	}
end

function ENT:CreateJoin(pos,rev)
	local ang = Angle(0,0,0)
	if rev then ang = Angle(0,180,0) end
	local join = ents.Create("prop_physics")
	join:SetModel("models/metrostroi/tatra_t3/tatra_join.mdl")
	join:SetPos(self:LocalToWorld(pos))
	join:SetAngles(self:GetAngles() + ang)
	join:Spawn()
	join:SetOwner(self:GetOwner())

	-- Constraint join to the train
	--[[constraint.Axis(join,self,0,0,
		Vector(0,0,0),Vector(0,0,0),
		0,0,0,1,Vector(0,0,1),false)]]--
	local xmin = -5
	local xmax = 2
	if rev then
		xmin = -2
		xmax = 5
	end
	
	constraint.AdvBallsocket(
		join,
		self,
		0, --bone
		0, --bone
		Vector(-40,0,10),
		pos,
		0, --forcelimit
		0, --torquelimit
		xmin, --xmin
		0, --ymin
		-30, --zmin
		xmax, --xmax
		0, --ymax
		30, --zmax
		0, --xfric
		0, --yfric
		0, --zfric
		0, --rotonly
		1 --nocollide
	)

	-- Add to cleanup list
	table.insert(self.TrainEntities,join)
	return join
end
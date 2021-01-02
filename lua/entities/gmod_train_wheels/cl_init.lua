include("shared.lua")

function ENT:Think()
	if self:GetNW2Bool("Disabled") then return end
	-- Timing
	self.PrevTime = self.PrevTime or RealTime()
	local dT = (RealTime() - self.PrevTime)
	self.PrevTime = RealTime()

	-- Angular velocity
	local wheel_radius = 0.5*44.1 -- units
	local speed = -self:GetVelocity():Dot(self:GetAngles():Right())
	local ang_vel = speed/(2*math.pi*wheel_radius)

	-- Rotate wheel
	self.Angle = ((self.Angle or math.random()) + ang_vel*dT) % 1.0
	self:SetPoseParameter("position",1.0-self.Angle)
	self:InvalidateBoneCache()
end

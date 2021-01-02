AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/metrostroi/signals/mus/box.mdl")
	Metrostroi.DropToFloor(self)

	-- Initial state of the switch
	self.AlternateTrack = false
	self.OldAlternateTrack = false
	self.InhibitSwitching = false
	self.LastSignalTime = 0

	-- Find rotating parts which belong to this switch
	local list = ents.FindInSphere(self:GetPos(),game.GetMap():find("metrostroi") and 512 or 256)
	self.TrackSwitches = {}
	for k,v in pairs(list) do
		if (v:GetClass() == "prop_door_rotating") and (string.find(v:GetName(),"switch") or string.find(v:GetName(),"swh") or string.find(v:GetName(),"swit")) then
			table.insert(self.TrackSwitches,v)

			timer.Simple(0.05,function()
				debugoverlay.Line(v:GetPos(),self:GetPos(),10,Color(255,255,0),true)
			end)
		end
	end

	Metrostroi.UpdateSignalEntities()
	Metrostroi.UpdateSwitchEntities()
	Metrostroi.UpdateARSSections()
end

function ENT:OnRemove()
	Metrostroi.UpdateSignalEntities()
	Metrostroi.UpdateSwitchEntities()
	Metrostroi.UpdateARSSections()
end

function ENT:SendSignal(index,channel,route)
	if not route then
		if channel and channel ~= self:GetChannel() then return end

		-- Switch to alternate track
		if index == "alt" then self.AlternateTrack = true end
		-- Switch to main track
		if index == "main" then self.AlternateTrack = false end

		-- Remember this signal
		self.LastSignal = index
		self.LastSignalTime = CurTime()
	else
		if index == "alt" then
			for k,v in pairs(self.TrackSwitches) do v:Fire(self.Invertred and "Close" or "Open","","0") end
		elseif index == "main" then
			for k,v in pairs(self.TrackSwitches) do v:Fire(self.Invertred and "Open" or "Close","","0") end
		end
		if index == "alt" then self.AlternateTrack = true end
		if index == "main" then self.AlternateTrack = false end
	end

end

function ENT:SwitchTo(index)
	if index == "alt" then
		for k,v in pairs(self.TrackSwitches) do v:Fire(self.Invertred and "Close" or "Open","","0") end
	elseif index == "main" then
		for k,v in pairs(self.TrackSwitches) do v:Fire(self.Invertred and "Open" or "Close","","0") end
	end
end

function ENT:Think()
	-- Reset
	self.InhibitSwitching = false

	-- Check if local section of track is occupied or no

	if self.NotChangePos == nil then
		self.NotChangePos = false
	end
	-- Force door state state
	if self.NotChangePos then
		self.AlternateTrack = false
		self.MainTrack = false
		for k,v in pairs(self.TrackSwitches) do
			self.AlternateTrack = self.AlternateTrack or not self.Invertred and v:GetSaveTable().m_eDoorState == 2 or self.Invertred and v:GetSaveTable().m_eDoorState == 0
			self.MainTrack = self.MainTrack or not self.Invertred and v:GetSaveTable().m_eDoorState == 0 or self.Invertred and v:GetSaveTable().m_eDoorState == 2
		end
	else
		local pos = self.TrackPosition
		if pos and self.AlternateTrack then
			local trackOccupied = Metrostroi.IsTrackOccupied(pos.node1,pos.x,pos.forward,"switch")
			if trackOccupied then -- Prevent track switches from working when there's a train on segment
				self.InhibitSwitching = true
			end
		end
		if self.AlternateTrack then
			for k,v in pairs(self.TrackSwitches) do if IsValid(v) then v:Fire(self.Invertred and "Close" or "Open","","0") end end
		else
			for k,v in pairs(self.TrackSwitches) do if IsValid(v) then v:Fire(self.Invertred and "Open" or "Close","","0") end end
		end
		-- Return switch to original position
		if (self.InhibitSwitching == false) and (self.AlternateTrack == true) and
		   (CurTime() - self.LastSignalTime > 20.0) then
			self:SendSignal("main",self:GetChannel())
		end
		-- Force signal
		if self.LockedSignal then
			self:SendSignal(self.LockedSignal,self:GetChannel())
		end
	end
	if self.AlternateTrack ~= self.OldAlternateTrack then
		self.OldAlternateTrack = self.AlternateTrack
		hook.Run("MetrostroiChangedSwitch",self,self.AlternateTrack)
	end
	-- Process logic
	self:NextThink(CurTime() + 1.0)
	if self.Name and self.Name ~= "" then
		self:SetNW2String("ID",self.Name)
	elseif self.TrackPosition then
		--PrintTable(self.TrackPosition.node1)
		self:SetNW2String("ID",self.TrackPosition.path.id.."/"..self.TrackPosition.node1.id)
	end
	return true
end

function ENT:GetSignal()
	if self.InhibitSwitching and self.AlternateTrack then return 1 end
	if self.AlternateTrack then return 3 end
	return 0
end

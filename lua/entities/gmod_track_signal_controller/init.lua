AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/z-o-m-b-i-e/metro_2033/electro/m33_electro_box_08.mdl")
	self.Sig = ""
end

function ENT:OnRemove()
end

function ENT:Think()
	if not IsValid(self.SignalEntity) then
		self.SignalEntity = Metrostroi.GetSignalByName(self.Signal)
		if IsValid(self.SignalEntity) then
			print(Format("Metrostroi Signal Controller: Linked to signal %s",self.Signal))
			if not self.SignalEntity.Controllers then
				self.SignalEntity.Controllers = {}
				table.insert(self.SignalEntity.Controllers,self)
			end
			self.SignalEntity.ControllerLogic = self.DisableSignal
			for k,v in pairs(self.SignalEntity.Controllers) do
				if v == self then
					self:NextThink(CurTime() + 1.0)
					return true
				end
			end
			table.insert(self.SignalEntity.Controllers,self)
		end
	end
	self:NextThink(CurTime() + 1.0)
	return true
end

function ENT:KeyValue(key ,value)
    if key == "targetsignal" then
		self.Signal = value
    elseif key == "disablesignal" and value == "1" then
		self.DisableSignal = true
	elseif key == "LenseEnabled" then
		if not self.Entities then self.Entities = {} end
		local tbl = string.Explode(",",value)
		timer.Simple(0,function() table.insert(self.Entities,{ents.FindByName(tbl[1]),tbl[2]}) end)
		self:StoreOutput(key,value)
	elseif key == "LenseDisabled" then
		if not self.Entities then self.Entities = {} end
		local tbl = string.Explode(",",value)
		timer.Simple(0,function() table.insert(self.Entities,{ents.FindByName(tbl[1]),tbl[2],true}) end)
		self:StoreOutput(key,value)
	end
end

function ENT:TriggerOutput(output,_,data)
	if not self.Entities then return end
	for k,v in pairs(self.Entities) do
		if output == "LenseEnabled" and not v[3] or output == "LenseDisabled" and v[3] then
			for _,ent in pairs(v[1]) do
				ent:Fire(v[2],data)
			end
		end
	end
end

function ENT:AcceptInput( input, activator, called, data )
	if not IsValid(self.SignalEntity) then
		self.SignalEntity = Metrostroi.GetSignalByName(self.Signal)
		if not IsValid(self.SignalEntity) then
			if #ents.FindByClass("gmod_track_signal") > 0 then
				ErrorNoHalt(Format("\nMetrostroi Signal Controller: Can't find signal %s!\nCheck, that you use official verion of signal\n",self.Signal))
			else
				ErrorNoHalt("\nMetrostroi Signal Controller: Please, load a signals first!\n")
			end
		end
		return true
	end
	local sig = self.SignalEntity
	if input == "Open" then
		for k,v in pairs(sig.Routes) do
			if v.Manual then v.IsOpened = true end
		end
	elseif input == "OpenRoute" then
		for k,v in pairs(sig.Routes) do
			sig.Close = false
			if v.RouteName and v.RouteName:upper() == data then
				if v.Manual then v.IsOpened = true end
			else
				if v.Manual then v.IsOpened = false end
			end
		end
	elseif input == "Close" then
		for k,v in pairs(sig.Routes) do
			if v.Manual then v.IsOpened = false end
		end
	elseif input == "SetKGU" then
		sig.KGU = data == "1"
	elseif input == "SetIS" then
		sig.InvationSignal = data == "1"
	elseif input == "SetSignal" then
		local index = 0
		for k,v in ipairs(sig.Lenses) do
			if v ~= "M" then
				--get the some models data
				local dat = #v ~= 1 and sig.TrafficLightModels[sig.SignalType][#v-1] or sig.TrafficLightModels[sig.SignalType][sig.Signal_IS]
				if not dat then continue end
				for i = 1,#v do
					if index == tonumber(data) then
						sig.Sig = string.SetChar(sig.Sig,index,"1")
					end
					index = index + 1
				end
			end
		end
	elseif input == "ResetSignal" then
		sig.Sig = ""
		local index = 0
		for k,v in ipairs(sig.Lenses) do
			if v ~= "M" then
				--get the some models data
				local data = #v ~= 1 and sig.TrafficLightModels[sig.SignalType][#v-1] or sig.TrafficLightModels[sig.SignalType][sig.Signal_IS]
				if not data then continue end
				for i = 1,#v do
					index = index + 1
					sig.Sig = sig.Sig..0
				end
			end
		end
	elseif input == "SetFreq" then
		sig.ARSSpeedLimit = tonumber(data) or 1
	elseif input == "SetFreqMode26" then
		sig.TwoToSix = true
	elseif input == "SetFreqMode15" then
		sig.TwoToSix = false
	elseif input == "ResetFreq" then
		sig.ARSSpeedLimit = 1
	elseif input == "SetAutostop" then
		sig.AutoEnabled = true
	elseif input == "ResetAutostop" then
		sig.AutoEnabled = false
	elseif input == "SetRouteNumber" then
		sig.RouteNumberReplace = data
	elseif input == "ResetRouteNumber" then
		sig.RouteNumberReplace = data
	elseif input == "SetFreeBS" then
		sig.FreeBS = tonumber(data) or 0
	end
end

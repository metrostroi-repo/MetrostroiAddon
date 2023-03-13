ENT.Type            = "anim"

ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "Metrostroi (utility)"

ENT.Spawnable       = true
ENT.AdminSpawnable  = false


ENT.CustomThinks = ENT.CustomThinks or {}
ENT.CustomSpawnerUpdates = ENT.CustomSpawnerUpdates or {}

local function destroySound(snd,nogc)
	if IsValid(snd) then snd:Stop() end
	if not nogc and snd and snd.__gc then snd:__gc() end
end
function ENT:DestroySound(snd,nogc)
	destroySound(snd,nogc)
end
--------------------------------------------------------------------------------
-- Default initializer only loads up DURA
--------------------------------------------------------------------------------
function ENT:InitializeSystems()
	--self:LoadSystem("DURA")
	self:LoadSystem("ALSCoil")
	self.ALSCoil:TriggerInput("Enabled",1)
end

function ENT:PostInitializeSystems() end

function ENT:PassengerCapacity()
	return 0
end

function ENT:GetStandingArea()
	return Vector(-64,-64,0),Vector(64,64,0)
end

function ENT:BoardPassengers(delta)
	self:SetNW2Float("PassengerCount", math.max(0,math.min(self:PassengerCapacity(),self:GetNW2Float("PassengerCount") + delta)))
end

ENT.LeftDoorPositions = { Vector(0,0,0) }
ENT.RightDoorPositions = { Vector(0,0,0) }
ENT.MirrorCams = {
	Vector(450,71,24),Angle(1,180,0),15,
	Vector(450,-71,24),Angle(1,180,0),15,
}
--------------------------------------------------------------------------------
-- Load/define basic sounds
--------------------------------------------------------------------------------
function ENT:InitializeSounds()
	self.SoundPositions = {} -- Positions (used clientside)
	self.SoundNames = {}

	self.SoundNames["uava_on"]		= {
		"subway_trains/common/uava/uava_on1.mp3",
		"subway_trains/common/uava/uava_on2.mp3",
		"subway_trains/common/uava/uava_on3.mp3",
	}
	self.SoundNames["uava_off"]		= {
		"subway_trains/common/uava/uava_off1.mp3",
		"subway_trains/common/uava/uava_off2.mp3",
		"subway_trains/common/uava/uava_off3.mp3",
	}
	self.SoundNames["uava_reset"]		= {
		"subway_trains/common/uava/uava_reset1.mp3",
		"subway_trains/common/uava/uava_reset2.mp3",
		"subway_trains/common/uava/uava_reset4.mp3",
	}
	self.SoundNames["junk_small"] = {
		"subway_trains/common/junk/junk_small1.mp3",
		"subway_trains/common/junk/junk_small2.mp3",
		"subway_trains/common/junk/junk_small3.mp3",
		"subway_trains/common/junk/junk_small4.mp3",
		"subway_trains/common/junk/junk_small5.mp3",
		"subway_trains/common/junk/junk_small6.mp3",
	}
	self.SoundNames["junk_medium"] = {
		"subway_trains/common/junk/junk_medium1.mp3",
		"subway_trains/common/junk/junk_medium2.mp3",
		"subway_trains/common/junk/junk_medium3.mp3",
		"subway_trains/common/junk/junk_medium4.mp3",
		"subway_trains/common/junk/junk_medium5.mp3",
		"subway_trains/common/junk/junk_medium6.mp3",
	}
	self.SoundNames["junk_enginestart_speed"] = {
		"subway_trains/common/junk/junk_enginestart_speed1.mp3",
		"subway_trains/common/junk/junk_enginestart_speed2.mp3",
		"subway_trains/common/junk/junk_enginestart_speed3.mp3",
		"subway_trains/common/junk/junk_enginestart_speed4.mp3",
		"subway_trains/common/junk/junk_enginestart_speed5.mp3",
	}

	self.SoundNames["pb_on"]		= "subway_trains/common/switches/pb_on.mp3"
	self.SoundNames["pb_off"]	= "subway_trains/common/switches/pb_off.mp3"

	self.SoundNames["vu224_on"]		= {
			"subway_trains/common/switches/vu224/vu224_on1.mp3",
			"subway_trains/common/switches/vu224/vu224_on2.mp3",
			"subway_trains/common/switches/vu224/vu224_on3.mp3",
	}
	self.SoundNames["vu224_off"]		= {
			"subway_trains/common/switches/vu224/vu224_off1.mp3",
			"subway_trains/common/switches/vu224/vu224_off2.mp3",
			"subway_trains/common/switches/vu224/vu224_off3.mp3",
	}

	self.SoundNames["av_on"]			=  {
		"subway_trains/common/switches/va21/va21_on1.mp3",
		"subway_trains/common/switches/va21/va21_on2.mp3",
		"subway_trains/common/switches/va21/va21_on3.mp3",
		"subway_trains/common/switches/va21/va21_on4.mp3",
		"subway_trains/common/switches/va21/va21_on5.mp3",
		"subway_trains/common/switches/va21/va21_on6.mp3",
	}
	self.SoundNames["av_off"]			=  {
		"subway_trains/common/switches/va21/va21_off1.mp3",
		"subway_trains/common/switches/va21/va21_off2.mp3",
		"subway_trains/common/switches/va21/va21_off3.mp3",
		"subway_trains/common/switches/va21/va21_off4.mp3",
		"subway_trains/common/switches/va21/va21_off5.mp3",
		"subway_trains/common/switches/va21/va21_off6.mp3",
	}
		self.SoundNames["av_knock"]			=  {
		"subway_trains/common/switches/va21/va21_knock1.mp3",
		"subway_trains/common/switches/va21/va21_knock2.mp3",
		"subway_trains/common/switches/va21/va21_knock3.mp3",
	}
	self.SoundNames["br_334_1-2"]		= "subway_trains/common/334/334_02.mp3"
	self.SoundNames["br_334_2-1"]		= "subway_trains/common/334/334_01.mp3"
	self.SoundNames["br_334_2-3"]		= "subway_trains/common/334/334_02.mp3"
	self.SoundNames["br_334_3-2"]		= "subway_trains/common/334/334_03.mp3"
	self.SoundNames["br_334_4-3"]		= "subway_trains/common/334/334_03.mp3"
	self.SoundNames["br_334_4-5"]		= "subway_trains/common/334/334_05.mp3"

	self.SoundNames["br_013"]		= {
		"subway_trains/common/switches/013_1.mp3",
		"subway_trains/common/switches/013_2.mp3",
		"subway_trains/common/switches/013_3.mp3",
		"subway_trains/common/switches/013_4.mp3",
	}
	for i = 1,10 do
		local id1 = Format("b1tunnel_%d",i)
		local id2 = Format("b2tunnel_%d",i)
		self.SoundNames[id1.."a"] = "subway_trains/bogey/st"..i.."a.wav"
		self.SoundNames[id1.."b"] = "subway_trains/bogey/st"..i.."b.wav"
		self.SoundPositions[id1.."a"] = {700,1e9,Vector( 317-5,0,-84),1}
		self.SoundPositions[id1.."b"] = self.SoundPositions[id1.."a"]
		self.SoundNames[id2.."a"] = "subway_trains/bogey/st"..i.."a.wav"
		self.SoundNames[id2.."b"] = "subway_trains/bogey/st"..i.."b.wav"
		self.SoundPositions[id2.."a"] = {700,1e9,Vector(-317+0,0,-84),1}
		self.SoundPositions[id2.."b"] = self.SoundPositions[id2.."a"]
	end
	for i = 1,14 do
		local id1 = Format("b1street_%d",i)
		local id2 = Format("b2street_%d",i)
		self.SoundNames[id1.."a"] = "subway_trains/bogey/wheels/street_"..i.."a.mp3"
		self.SoundNames[id1.."b"] = "subway_trains/bogey/wheels/street_"..i.."b.mp3"
		self.SoundPositions[id1.."a"] = {700,1e9,Vector( 317-5,0,-84),1.5}
		self.SoundPositions[id1.."b"] = self.SoundPositions[id1.."a"]
		self.SoundNames[id2.."a"] = "subway_trains/bogey/wheels/street_"..i.."a.mp3"
		self.SoundNames[id2.."b"] = "subway_trains/bogey/wheels/street_"..i.."b.mp3"
		self.SoundPositions[id2.."a"] = {700,1e9,Vector(-317+0,0,-84),1.5}
		self.SoundPositions[id2.."b"] = self.SoundPositions[id2.."a"]
	end
end

--------------------------------------------------------------------------------
-- Sound functions
--------------------------------------------------------------------------------
--[[
function ENT:SetSoundState(sound,volume,pitch,timeout,range)
	--if not self.Sounds[sound] then return end
	--if sound == "ring" then sound = "zombie_loop" end
	if not self.Sounds[sound] then
		if self.SoundNames and self.SoundNames[sound] then
			local name = self.SoundNames[sound]
			if self.SoundPositions[sound] then
				local ent_nwID
				if self.SoundPositions[sound] == "cabin" then ent_nwID = "seat_driver" end

				local ent = self:GetNW2Entity(ent_nwID)
				if IsValid(ent) then
					self.Sounds[sound] = CreateSound(ent, Sound(name))
				else
					return
				end
			else
				self.Sounds[sound] = CreateSound(self, Sound(name))
			end
		else
			return
		end
	end
	local default_range = 0.80
	if (volume <= 0) or (pitch <= 0) then
		self.Sounds[sound]:SetSoundLevel(100*(range or default_range))
		self.Sounds[sound]:Stop()
		return
	end

	if soundid == "switch" then default_range = 0.50 end
	local pch = math.floor(math.max(0,math.min(255,100*pitch)) + math.random())
	self.Sounds[sound]:SetSoundLevel(100*(range or default_range))
	local vol = math.max(0,math.min(255,2.55*volume)) + (0.001/2.55) + (0.001/2.55)*math.random()
	self.Sounds[sound]:PlayEx(vol,pch+1)
	self.Sounds[sound]:ChangeVolume(vol,timeout or 0)
	self.Sounds[sound]:ChangePitch(pch+1,timeout or 0)
	self.Sounds[sound]:SetSoundLevel(100*(range or default_range))
end
]]
local function PauseBASS(snd)
	snd:Pause()
	snd:SetTime(0)
end
function ENT:CreateBASSSound(name,callback,noblock,onerr)
	if self.StopSounds or not self.ClientPropsInitialized or self.CreatingCSEnts then return end
	--if self.SoundSpawned and name:find(".wav") then return end
	--self.SoundSpawned = true
	sound.PlayFile(Sound("sound/"..name), "3d noplay mono"..(noblock and " noblock" or ""), function( snd,err,errName )
		if not IsValid(self) then destroySound(snd) return end
		if err then
			self:DestroySound(snd)
			if err == 4 or err == 37 then self.StopSounds = true end
			if err ~= 41 then
				MsgC(Color(255,0,0),Format("Sound:%s\n\tErrCode:%s, ErrName:%s\n",name,err,errName))
				if onerr then callback(false) end
			elseif GetConVar("metrostroi_drawdebug"):GetInt() ~= 0 then
				MsgC(Color(255,255,0),Format("Sound:%s\n\tBASS_ERROR_UNKNOWN (it's normal),ErrCode:%s, ErrName:%s\n",name,err,errName))
				self:CreateBASSSound(name,callback)
			end
			return
		elseif not self.Sounds then
			self:DestroySound(snd)
			if onerr then callback(false) end
		else
			callback(snd)
		end
	end )
end
function ENT:SetPitchVolume(snd,pitch,volume,tbl)
	if not IsValid(snd) then return end
	if tbl then
		if tbl[4] then
			snd:SetVolume(tbl[4]*volume)
		else
			snd:SetVolume(volume)
		end
	else
		snd:SetVolume(volume)
	end
	snd:SetPlaybackRate(pitch)
end

function ENT:SetBASSPos(snd,tbl)
	if tbl then
		snd:SetPos(self:LocalToWorld(tbl[3]),self:GetAngles():Forward())
	else
		snd:SetPos(self:GetPos())
	end
end
function ENT:SetBassParameters(snd,pitch,volume,tbl,looping,spec)
	if snd:GetState() ~= GMOD_CHANNEL_STOPPED and snd:GetState() ~= GMOD_CHANNEL_PAUSED then
		return
	end
	self:SetBASSPos(snd,tbl)
	if tbl then
		snd:Set3DFadeDistance(tbl[1],tbl[2])
		if tbl[4] then
			snd:SetVolume(tbl[4]*volume)
		else
			snd:SetVolume(volume)
		end
	else
		snd:Set3DFadeDistance(200,1e9)
		snd:SetVolume(volume)
	end
	snd:EnableLooping(looping or false)
	snd:SetPlaybackRate(pitch)
	local siz1,siz2 = snd:Get3DFadeDistance()--[[]
	debugoverlay.Sphere(snd:GetPos(),4,2,Color(0,255,0),true)
	debugoverlay.Sphere(snd:GetPos(),siz1,2,Color(255,0,0,100),false)]]
	--debugoverlay.Sphere(snd:GetPos(),siz2,2,Color(0,0,255,100),false)
end
function ENT:SetSoundState(soundid,volume,pitch,time)
	--volume = (input.IsKeyDown( KEY_LALT ) and soundid == "horn") and 0 or 1+math.sin(CurTime()*3)*0.2
	--pitch = (input.IsKeyDown( KEY_LALT ) and soundid == "horn") and 1 or 1+math.sin(CurTime()*3)*0.2
	if self.StopSounds or not self.ClientPropsInitialized or self.CreatingCSEnts then return end
	local name = self.SoundNames and self.SoundNames[soundid]
	local tbl = self.SoundPositions[soundid]
	local looptbl = type(name) == "table" and name
	if looptbl and #name > 1 then --triple-looped sound
		if not self.Sounds.loop[soundid] then self.Sounds.loop[soundid] = {state=false,newstate=false,pitch=0} end
		local sndtbl = self.Sounds.loop[soundid]
		if volume > 0 then sndtbl.volume = volume end
		if pitch > 0 then sndtbl.pitch = pitch end
		for i,v in ipairs(name) do
			if not sndtbl[i] then sndtbl[i] = {} end
			if not IsValid(sndtbl[i].sound) and sndtbl[i].sound ~= false then
				self:CreateBASSSound(v,function(snd)
					if not snd then
						destroySound(sndtbl[i].sound)
						sndtbl[i].sound = nil
						return
					end

					snd:SetPos(self:LocalToWorld(tbl[3]),self:GetAngles():Forward())
					sndtbl[i].sound = snd
					sndtbl[i].volume = volume > 0 and sndtbl.volume or volume or 0
					self:SetBassParameters(snd,pitch,sndtbl[i].volume,tbl,i==2)
				end,true,true)
				sndtbl[i].sound = false
			end
		end
		local state = volume > 0
		if sndtbl.state ~= state then
			sndtbl[1].state = state
			if not state then sndtbl[2].state = false end
			sndtbl[3].state = not state
			sndtbl.control = state and 1 or 3
			sndtbl.state = state
		end
	else
		if looptbl then name = name[1] end
		local snd = self.Sounds[soundid]
		if not IsValid(snd) and name and snd ~= false then
			self:CreateBASSSound(name,function(snd)
				if not snd then
					destroySound(self.Sounds[soundid])
					self.Sounds[soundid] = nil
					return
				end

				self.Sounds[soundid] = snd
				self.Sounds.isloop[soundid] = true
				self:SetBassParameters(snd,pitch,volume,tbl,looptbl and looptbl.loop)
			end,true,true)
			self.Sounds[soundid] = false
			return
		end

		if not IsValid(snd) then return end
		local default_range = 0.80
		if ((volume <= 0) or (pitch <= 0)) then
			if snd:GetTime() > 0 then
				PauseBASS(snd)
			end
			return
		end
		if snd:GetState() ~= GMOD_CHANNEL_PLAYING then
			if timeout then
				snd:SetTime(time)
			end
			snd:Play()
		end
		snd:SetPlaybackRate(pitch)
		if tbl and tbl[4] then
			snd:SetVolume(tbl[4]*volume)
		else
			snd:SetVolume(volume)
		end
	end


	if soundid == "switch" then default_range = 0.50 end
	local pch = math.floor(math.max(0,math.min(255,100*pitch)) + math.random())
	--self.Sounds[soundid]:SetSoundLevel(100*(range or default_range))
	--local vol = math.max(0,math.min(255,2.55*volume)) + (0.001/2.55) + (0.001/2.55)*math.random()
	--self.Sounds[soundid]:PlayEx(vol,pch+1)
	--self.Sounds[soundid]:ChangeVolume(vol,timeout or 0)
	--self.Sounds[soundid]:ChangePitch(pch+1,timeout or 0)
	--self.Sounds[soundid]:SetSoundLevel(100*(range or default_range))
end

--[[function ENT:CheckActionTimeout(action,timeout)
	self.LastActionTime = self.LastActionTime or {}
	self.LastActionTime[action] = self.LastActionTime[action] or (CurTime()-1000)
	if CurTime() - self.LastActionTime[action] < timeout then return true end
	self.LastActionTime[action] = CurTime()

	return false
end
]]--

if SERVER then
	util.AddNetworkString("metrostroi_client_sound")
else
	net.Receive("metrostroi_client_sound", function(size)
		local train = net.ReadEntity()
		if not IsValid(train) or not train.PlayOnce or not train:ShouldRenderClientEnts() then return end
		local snd = net.ReadString()
		local pos = net.ReadString()
		local range = net.ReadFloat()
		local pitch = net.ReadUInt(9)/100
		if pitch == 0 then pitch = 1 end
		if pos == "styk" and train.OnStyk then
			local opsnd,oppos,oprange,oppitch = train:OnStyk(snd,pos,range,pitch)
			if opsnd then
				train:PlayOnce(opsnd or snd,oppos or pos,oprange or range,oppitch or pitch)
			end
		elseif train.OnPlay then
			local opsnd,oppos,oprange,oppitch = train:OnPlay(snd,pos,range,pitch)
			if opsnd then
				train:PlayOnce(opsnd or snd,oppos or pos,oprange or range,oppitch or pitch)
			end
		elseif snd then
			train:PlayOnce(snd,pos,range,pitch)
		end
	end)
end
if SERVER then
	function ENT:PlayOnce(soundid,location,range,pitch,randoff)
		if self.OnPlay then
			soundid,location,range,pitch = self:OnPlay(soundid,location,range,pitch)
		end
		net.Start("metrostroi_client_sound",true)
			net.WriteEntity(self)
			net.WriteString(soundid)
			net.WriteString(location or "")
			net.WriteFloat(range or 0.8)
			net.WriteUInt((pitch or 1)*100,9)
		net.SendPAS(self:GetPos())
	end
else
	function ENT:PlayOnceFromPos(id,sndname,volume,pitch,min,max,location)
		if self.StopSounds or not self.ClientPropsInitialized or self.CreatingCSEnts then return end
		self:DestroySound(self.Sounds[id],true)
		self.Sounds[id] = nil
		if sndname == "_STOP" then return end
		self.SoundPositions[id] = {min,max,location}
		self:CreateBASSSound(sndname,function(snd)
			self.Sounds[id] = snd
			self:SetBassParameters(self.Sounds[id],pitch,volume,self.SoundPositions[id],false)
			snd:Play()
		end)
	end
	function ENT:PlayOnce(soundid,location,range,pitch,randoff)
		if self.StopSounds or not self.ClientPropsInitialized or self.CreatingCSEnts then return end
		if not soundid then
			ErrorNoHalt(debug.Trace())
		end

		-- Emit sound from right location
		if self.ClientSounds and self.ClientSounds[soundid] then
			local entsound = self.ClientSounds[soundid]
			for i,esnd in ipairs(entsound) do
				soundid = esnd[2](self,range,location)
				local soundname = self.SoundNames[soundid]
				if not soundname then print("NO SOUND",soundname,soundid) continue end
				if type(soundname) == "table" then soundname = table.Random(soundname) end
				if IsValid(self.ClientEnts[esnd[1]]) and not self.ClientEnts[esnd[1]].snd then
					local ent = self.ClientEnts[esnd[1]]
					sound.PlayFile( "sound/"..soundname, "3d noplay mono", function( snd,err,errName )
						if not IsValid(self) then destroySound(snd) return end
						if err then
							self:DestroySound(snd)
							if err == 4 or err == 37 then self.StopSounds = true end
							if err ~= 41 then
								MsgC(Color(255,0,0),Format("Sound:%s\n\tErrCode:%s, ErrName:%s\n",name,err,errName))
							elseif GetConVar("metrostroi_drawdebug"):GetInt() ~= 0 then
								MsgC(Color(255,255,0),Format("Sound:%s\n\tBASS_ERROR_UNKNOWN (it's normal),ErrCode:%s, ErrName:%s\n",name,err,errName))
								--self:PlayOnce(soundid,location,range,pitch,randoff)
							end
							return
						elseif not IsValid(ent) then
							self:DestroySound(snd)
						else
							snd:SetPos(ent:GetPos(),ent:LocalToWorldAngles(esnd[7]):Forward())
							snd:SetPlaybackRate(esnd[4])
							snd:SetVolume(esnd[3])
							if esnd[5] then
								snd:Set3DFadeDistance(esnd[5],esnd[6])
							end
							table.insert(ent.BASSSounds,snd)
							snd:Play()
							--local siz1,siz2 = snd:Get3DFadeDistance()
							--debugoverlay.Sphere(snd:GetPos(),4,2,Color(0,255,0),true)
							--debugoverlay.Sphere(snd:GetPos(),siz1,2,Color(255,0,0,100),false)
							--debugoverlay.Sphere(snd:GetPos(),siz2,2,Color(0,0,255,100),false)
						end
					end)
				end
			end
			return
		end

		local tbl = self.SoundPositions[soundid]

		local soundname = self.SoundNames[soundid]
		if type(soundname) == "table" then soundname = table.Random(soundname) end
		if not soundname or not tbl then
			--print("NO SOUND",soundname,soundid)
			return
		end

		if IsValid(self.Sounds[soundid]) then
			self:DestroySound(self.Sounds[soundid])
			self.Sounds[soundid] = nil
		end
		self:CreateBASSSound(soundname,function(snd)
			self.Sounds[soundid] = snd
			self:SetBassParameters(self.Sounds[soundid],pitch,range,tbl,false)
			snd:Play()
		end)
	end
end




--------------------------------------------------------------------------------
-- Load a single system with given name
--------------------------------------------------------------------------------
function ENT:LoadSystem(a,b,...)
	local name
	local sys_name
	if b then
		name = b
		sys_name = a
	else
		name = a
		sys_name = a
	end

	if not Metrostroi.Systems[name] then ErrorNoHalt("No system defined: "..name) return end
	if self.Systems[sys_name] then ErrorNoHalt("System already defined: "..sys_name)  return end

	local no_acceleration = Metrostroi.BaseSystems[name].DontAccelerateSimulation
	local run_everywhere = Metrostroi.BaseSystems[name].RunEverywhere
	if SERVER and Turbostroi and not self.DontAccelerateSimulation then
		-- Load system into turbostroi
		if (not GLOBAL_SKIP_TRAIN_SYSTEMS) then
			Turbostroi.LoadSystem(sys_name,name,...)
		end

		-- Load system locally (this may load any systems nested in the initializer)
		GLOBAL_SKIP_TRAIN_SYSTEMS = GLOBAL_SKIP_TRAIN_SYSTEMS or 0
		if GLOBAL_SKIP_TRAIN_SYSTEMS then GLOBAL_SKIP_TRAIN_SYSTEMS = GLOBAL_SKIP_TRAIN_SYSTEMS + 1 end
		self[sys_name] = Metrostroi.Systems[name](self,...)
		GLOBAL_SKIP_TRAIN_SYSTEMS = GLOBAL_SKIP_TRAIN_SYSTEMS - 1
		if GLOBAL_SKIP_TRAIN_SYSTEMS == 0 then GLOBAL_SKIP_TRAIN_SYSTEMS = nil end

		-- Setup nice name as normal
		--if (name ~= sys_name) or (b) then self[sys_name].Name = sys_name end
		self[sys_name].Name = sys_name
		self.Systems[sys_name] = self[sys_name]

		-- Create fake placeholder
		if not no_acceleration then
			if run_everywhere then
				local old_func = self[sys_name].TriggerInput
				self[sys_name].TriggerInput = function(system,name,value)
					old_func(self,sys_name,name,value)
					Turbostroi.TriggerInput(self,sys_name,name,value)
				end
			else
				self[sys_name].TriggerInput = function(system,name,value)
					Turbostroi.TriggerInput(self,sys_name,name,value)
				end
			end
			self[sys_name].Think = function() end
		end
	else
		-- Load system like normal
		self[sys_name] = Metrostroi.Systems[name](self,...)
		--if (name ~= sys_name) or (b) then self[sys_name].Name = sys_name end
		self[sys_name].Name = sys_name
		self.Systems[sys_name] = self[sys_name]

		--if SERVER then
			--[[self[sys_name].TriggerOutput = function(sys,name,value)
				local varname = (sys.Name or "")..name
				--self:TriggerOutput(varname, tonumber(value) or 0)
				self.DebugVars[varname] = value
			end]]--
		--end
	end
end

function ENT:SetupDataTables()
	self._NetData = {{},{}}
end
---------------------------------------------------------------------------------------
-- Sends and get float via NWVars
---------------------------------------------------------------------------------------
function ENT:SetPackedRatio(idx,value)
	--local idx = type(idx) == "number" and 999-idx or idx
	if self._NetData[2][idx] ~= nil and self._NetData[2][idx] == math.floor(value*1000+0.5) then return end
	self:SetNW2Int(idx,math.floor(value*1000+0.5))
end

function ENT:GetPackedRatio(idx)
	return self:GetNW2Int(idx)*0.001
end

--------------------------------------------------------------------------------
-- Sends and get bool via NWVars
--------------------------------------------------------------------------------
function ENT:SetPackedBool(idx,value)
	if self._NetData[1][idx] ~= nil and self._NetData[1][idx] == value then return end
	self:SetNW2Bool(idx,value)
end

function ENT:GetPackedBool(idx)
	return self:GetNW2Bool(idx)
end



ENT.SubwayTrain = {
	Type = "Base",
	Name = "Base",
	WagType = 2,
	ALS = {
		HaveAutostop = false,
		TwoToSix = true,
		RSAs325Hz = true,
		Aproove0As325Hz = false,
	},
}
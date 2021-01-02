AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
local OldVoltage
function ENT:Initialize()
	self:SetModel("models/z-o-m-b-i-e/metro_2033/electro/m33_electro_box_12_4.mdl")
	
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	if not Metrostroi.OldVoltage then
		Metrostroi.OldVoltage = 0
	end
end

function ENT:Use(ply)
	--if not ply:IsAdmin() then return end
	if Metrostroi.Voltage == 0 then
		RunConsoleCommand("metrostroi_voltage",Metrostroi.OldVoltage ~= 0 and Metrostroi.OldVoltage or 750)
		Metrostroi.OldVoltage = 0
	else
		Metrostroi.OldVoltage = GetConVarNumber("metrostroi_voltage")
		RunConsoleCommand("metrostroi_voltage",0)
		Metrostroi.Voltage = 0
		Metrostroi.VoltageOffByPlayerUse = true
	end
	self:EmitSound("buttons/lever8.wav",100,100)
end

function ENT:Think()
	self:SetTotal(Metrostroi.TotalkWh)
	self:SetRate(Metrostroi.TotalRateWatts)
	self:SetV(Metrostroi.Voltage)
	self:SetA(Metrostroi.Current)

	if Metrostroi.Voltage >= 10 then
		Metrostroi.VoltageOffByPlayerUse = nil
	end
	if Metrostroi.Voltage < 10 and not Metrostroi.VoltageOffByPlayerUse then
		self.SoundTimer = self.SoundTimer or CurTime()
		if (CurTime() - self.SoundTimer) > 1.0 then
			self:EmitSound("ambient/alarms/klaxon1.wav", 100, 100)
			self.SoundTimer = CurTime()
		end
	end
	
	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	if Metrostroi.Voltage == 0 then
		RunConsoleCommand("metrostroi_voltage",Metrostroi.OldVoltage ~= 0 and Metrostroi.OldVoltage or 750)
	end
end

	

	
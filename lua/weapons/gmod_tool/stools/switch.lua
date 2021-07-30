TOOL.Category   = "Metro"
TOOL.Name       = "Switch Tool"
TOOL.Command    = nil
TOOL.ConfigName = ""
if SERVER then util.AddNetworkString "metrostroi-stool-switch" end
TOOL.ClientConVar["name"] = ""
TOOL.ClientConVar["channel"] = 1
TOOL.ClientConVar["locked"] = 0
TOOL.ClientConVar["controllable"] = 1
TOOL.ClientConVar["invert"] = 0
if CLIENT then
	language.Add("Tool.switch.name", "Switch Tool")
	language.Add("Tool.switch.desc", "Sets switch tool channel")
	language.Add("Tool.switch.0", "Primary: Set channel 1\nSecondary: Set channel 2\nReload: Lock switch")
end

function TOOL:LeftClick(trace)
	if CLIENT then return true end

	local ply = self:GetOwner()
	if (ply:IsValid()) and (not ply:IsAdmin()) then return false end
	if not trace then return false end
	if trace.Entity and trace.Entity:IsPlayer() then return false end

	local entlist = ents.FindInSphere(trace.HitPos,64)
	for k,v in pairs(entlist) do
		if v:GetClass() == "gmod_track_switch" then
			v.Name = self:GetClientInfo("name") ~= "" and self:GetClientInfo("name") or nil
			v:SetChannel(self:GetClientNumber("channel"))
			v.LockedSignal = self:GetClientNumber("lock") == 1 and self:GetClientNumber("channel") or nil
			v.NotChangePos = self:GetClientNumber("controllable") == 0
			v.Invertred = self:GetClientNumber("invert") == 1
			print(Format("Name:%s, Channel:%d, It's %slocked, %scontrllable and %sinverted",self:GetClientInfo("name") ~= "" and self:GetClientInfo("name") or "track index",self:GetClientNumber("channel"),self:GetClientNumber("lock") == 1 and "not " or "",self:GetClientNumber("controllable") == 0 and "not " or "",self:GetClientNumber("invert") == 0 and "not " or ""))
		end
	end
	return true
end

function TOOL:RightClick(trace)
	if CLIENT then return true end
--[[
	local ply = self:GetOwner()
	if (ply:IsValid()) and (not ply:IsAdmin()) then return false end
	if not trace then return false end
	if trace.Entity and trace.Entity:IsPlayer() then return false end

	local entlist = ents.FindInSphere(trace.HitPos,64)
	for k,v in pairs(entlist) do
		if v:GetClass() == "gmod_track_switch" then
			v:SetChannel(2)
			print("Set channel 2")
		end
	end]]
	return true
end

function TOOL:Reload(trace)
	if CLIENT then return true end

	local ply = self:GetOwner()
	if (ply:IsValid()) and (not ply:IsAdmin()) then return false end
	if not trace then return false end
	if trace.Entity and trace.Entity:IsPlayer() then return false end

	local entlist = ents.FindInSphere(trace.HitPos,64)
	for k,v in pairs(entlist) do
		if v:GetClass() == "gmod_track_switch" then
			net.Start("metrostroi-stool-switch")
				net.WriteString(v.Name or "")
				net.WriteUInt(v:GetChannel(),2)
				net.WriteBool(v.LockedSignal)
				net.WriteBool(not v.NotChangePos)
				net.WriteBool(v.Invertred)
			net.Send(self:GetOwner())

			--if self:GetClientNumber("lock") == 1 then
				--if v.LockedSignal then v.LockedSignal = nil else v.LockedSignal = v.LastSignal end
				--print("Locked switch signal",v.LockedSignal)
			--else
			--not v.NotChangePos
				--print(v.NotChangePos and "Disabled" or "Enabled")
			--end
		end
	end
	return true
end

function TOOL.BuildCPanel(panel)
	panel = panel or controlpanel.Get("switch")
    panel:SetName("#Tool.switch.name")
    panel:Help("#Tool.switch.desc")
	panel:TextEntry("Name","switch_name")
    local CBChannel = panel:ComboBox( "Channel", "switch_channel" )
    CBChannel:AddChoice("None",0)
    CBChannel:AddChoice("1",1)
    CBChannel:AddChoice("2",2)
    panel:CheckBox("Locked","switch_locked")
    panel:CheckBox("Controllable","switch_controllable")
    panel:CheckBox("Invert","switch_invert")
end


net.Receive("metrostroi-stool-switch", function(_, ply)
	local TOOL = LocalPlayer and LocalPlayer():GetTool("signalling") or ply:GetTool("signalling")

	RunConsoleCommand("switch_name",net.ReadString())
	RunConsoleCommand("switch_channel",net.ReadUInt(2))
	RunConsoleCommand("switch_locked",net.ReadBool() and 1 or 0)
	RunConsoleCommand("switch_controllable",net.ReadBool() and 1 or 0)
	RunConsoleCommand("switch_invert",net.ReadBool() and 1 or 0)
end)
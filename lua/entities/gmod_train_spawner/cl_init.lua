include("shared.lua")
local MaxHorisontal = 14
local frame = nil
local MaxWagons = 0
local MaxWagonsOnPlayer = 0
local Settings = {
	Train = 1,
	WagNum = 3,
	AutoCouple = true,
}
ENT.Settings = Settings

if not file.Exists("metrostroi_train_spawner.txt","DATA") then
	file.Write("metrostroi_train_spawner.txt","")
end

local function UpdateConCMD()
	file.Write("metrostroi_train_spawner.txt",util.TableToJSON(Settings,true))
	--[[
	for k,v in pairs(Settings) do
		RunConsoleCommand("train_spawner_"..k:lower(), v)
	end]]
end

local function LoadConCMD()
	Settings = util.JSONToTable(file.Read("metrostroi_train_spawner.txt","DATA")) or Settings
	--PrintTable(Settings)
end
local Pos = 0
local VGUI = {}
local function CreateList(name,text,tbl,OnSelect,stbl)
	tbl = tbl or {}
	stbl = stbl or Settings[Settings.Train]
	if type(tbl)=="function" then tbl = tbl() or {} end
	local count = 0;for k,v in pairs(tbl) do count = count+1 end
	if count<=1 then
		stbl[name] = next(tbl)
		return
	end
	local ListLabel = vgui.Create("DLabel", frame)
	--	ListLabel:SetPos(5 + 300*math.floor(Pos/MaxHorisontal), 24+24*(Pos%MaxHorisontal))
	ListLabel:SetPos(5 + 270*math.floor(Pos/MaxHorisontal),24+24*(Pos%MaxHorisontal))
	ListLabel:SetSize(115,28)
	ListLabel:SetText(text)
	ListLabel:SetExpensiveShadow(1,Color(0,0,0,200))

	local List = vgui.Create("DComboBox", frame)--
	List:SetTooltip(text)
	List.Call = OnSelect
	List:SetPos(130 + 270*math.floor(Pos/MaxHorisontal),28+24*(Pos%MaxHorisontal))
	--	List:SetPos(130 + 300*math.floor(Pos/MaxHorisontal), 28+24*(Pos%MaxHorisontal))
	List:SetWide(120)
	if #tbl == count then
		for i=1,#tbl do
			List:AddChoice(tbl[i], i, stbl[name] == i)
		end
	else
		for k,v in pairs(tbl) do
			if type(v) == "table" and v.name then k = v.name end
			List:AddChoice(v, k, stbl[name] == k)
		end
	end
	if not List:GetOptionData(1)  then ListLabel:Remove() List:Remove() return end
	if not List:GetSelectedID() then
		local done
		for i,v in pairs(List.Choices) do
			if v:find("Random") then
				List:ChooseOptionID(i)
				stbl[name] = List:GetOptionData(i)
				done = true
				break
			end
		end
		if not done then
			List:ChooseOptionID(1)
			stbl[name] = List:GetOptionData(1)
		end
	end
	List.OnSelect = function(self,_, _, index)
		stbl[name] = index
		if OnSelect then OnSelect(List,VGUI) end
	end
	List.ID = table.insert(VGUI,function(val, disabled, reset)
		if reset then
			if List.Disable then List:SetDisabled(false) end
			return
		end
		if val or disabled then
			if val ~= nil then List:ChooseOptionID(val) end
			List:SetDisabled(disabled)
			List.Disable = disabled
			return
		end
		ListLabel:Remove()
		List:Remove()
		--local on = Types[Settings.Train]:find(name) and tbl
		--List:SetVisible(on)
		--ListLabel:SetVisible(on)
		--if on then
		--end
	end)
	VGUI[name] = List
	Pos = Pos + 1
	--if Types[Settings.Train]:find(name) and #tbl > 0  then Pos = Pos + 1 end
end

local function CreateSlider(name,decimals,min,max,text,OnSelect,stbl)
	stbl = stbl or Settings[Settings.Train]
	local Slider = vgui.Create("DNumSlider", frame)
	Slider.Call = OnSelect
	--Slider:SetPos(5 + 300*math.floor(Pos/MaxHorisontal), 28+24*(Pos%MaxHorisontal)-7)
	Slider:SetPos(5 + 270*math.floor(Pos/MaxHorisontal), 28+24*(Pos%MaxHorisontal)-7+4)
	Slider:SetWide(290)
	Slider:SetTall(28)
	Slider:SetMinMax(min, max)
	Slider:SetDecimals(decimals)
	Slider:SetText(text..":")
	--if stbl[name]  > max then stbl[name] = max end FIXME
	Slider:SetValue(stbl[name])
	Slider:SetTooltip(text)
	Slider.Label:SetExpensiveShadow(1,Color(0,0,0,200))
	Slider.Label:SetSize(125,28)
	Slider.TextArea:SetTextColor(Slider.Label:GetTextColor())

	--local _old = Slider.ValueChanged
	function Slider:Think(...)
		if not self.Editing and self:IsEditing() then
			self.Editing = true
		elseif self.Editing and not self:IsEditing() then
			self.Editing = false
			local val = self:GetValue()
			if OnSelect then val = OnSelect(Slider,VGUI) or val end
			stbl[name] = math.Round(val,decimals)
			Slider:SetValue(stbl[name])
		end
	end
	Slider.ID = table.insert(VGUI,function(val, disabled, reset)
	  if reset then
	    if Slider.Disable then Slider:SetDisabled(false) Slider.Disable = nil end
	    return
	  end
		if val or disabled then
			if val ~= nil then Slider:SetValue(val) end
			Slider:SetDisabled(disabled)
			Slider.Disable = disabled
			return
		end
		Slider:Remove()
		--local on = Types[Settings.Train]:find(name)
		--Slider:SetVisible(on)
		--if on then
		--end
	end)
	VGUI[name] = Slider
	Pos = Pos + 1
	--if Types[Settings.Train]:find(name) then Pos = Pos + 1 end
end

local function CreateCheckBox(name,text,OnSelect,stbl)
	stbl = stbl or Settings[Settings.Train]
	--if not Types[Settings.Train]:find(name) then return end
	local CBLabel = vgui.Create("DLabel", frame)--
	CBLabel:SetPos(5  + 270*math.floor(Pos/MaxHorisontal),27+24*(Pos%MaxHorisontal)-4)
	--CBLabel:SetPos(5 + 300*math.floor(Pos/MaxHorisontal), 25+24*(Pos%MaxHorisontal))
	CBLabel:SetText(text)
	CBLabel:SetWide(125)
	CBLabel:SetTall(28)
	CBLabel:ApplySchemeSettings(true)
	--CBLabel:SetAutoStretchVertical(true)
	CBLabel:SetExpensiveShadow(1,Color(0,0,0,200))
	local CB = vgui.Create("DCheckBox", frame)
	CB:SetTooltip(text)
	CB.Call = OnSelect
	CB:SetPos(130 + 270*math.floor(Pos/MaxHorisontal),31+24*(Pos%MaxHorisontal))
	--CB:SetPos(130 + 300*math.floor(Pos/MaxHorisontal), 28+24*(Pos%MaxHorisontal))
	CB:SetValue(stbl[name])
	CB.OnChange = function(self)
		stbl[name] = CB:GetChecked()
		if OnSelect then OnSelect(CB,VGUI) end
	end
	CB.ID = table.insert(VGUI,function(val, disabled, reset)
	  if reset then
	    if CB.Disable then CB:SetDisabled(false) CB.Disable = nil end
	    return
	  end
		if val or disabled then
			if val ~= nil then CB:SetValue(val) end
			CB:SetDisabled(disabled)
			CB.Disable = disabled
			return
		end
		CBLabel:Remove()
		CB:Remove()
		--local on = Types[Settings.Train]:find(name)
		--CBLabel:SetVisible(on)
		--CB:SetVisible(on)
		--if on then
		--end
	end)
	VGUI[name] = CB
	Pos = Pos + 1
	--if Types[Settings.Train]:find(name) then Pos = Pos + 1 end
end

local function UpdateTrainList()
	Pos = 2
	for k,v in ipairs(VGUI) do
		if k > 2 then
			v()
			VGUI[k] = nil
		end
	end
	if not VGUI.Train:GetSelectedID() then
		VGUI.Train:ChooseOptionID(1)
		Settings.Train = VGUI.Train:GetOptionData(1)
	end
	if not Settings[Settings.Train] then Settings[Settings.Train] = {} end
	for k,name in pairs(Metrostroi.TrainClasses) do
		local ENT = scripted_ents.Get(name)
		if not ENT.Spawner or ENT.ClassName ~= Settings.Train  then continue end
		for i, menu in ipairs(ENT.Spawner) do
			if menu[3] == "List" then
				if Settings[Settings.Train][menu[1]] == nil then
					Settings[Settings.Train][menu[1]] = menu[5]
				end
				CreateList(menu[1],menu[2],menu[4],menu[7])
			elseif menu[3] == "Boolean" then
				if Settings[Settings.Train][menu[1]] == nil then
					Settings[Settings.Train][menu[1]] = menu[4]
				end
				CreateCheckBox(menu[1],menu[2],menu[6])
			elseif menu[3] == "Slider" then
				if Settings[Settings.Train][menu[1]] == nil then
					Settings[Settings.Train][menu[1]] = menu[7]
				end
				CreateSlider(menu[1],menu[4],menu[5],menu[6],tostring(menu[2]))
				--"NM",1,0.1,9,"Train Line Pressure"
			elseif type(menu[1]) == "number" then
				Pos=Pos+menu[1]
			elseif #menu==0 then
				Pos=Pos+1
			end
			--Trains[k] = v.SubwayTrain.Name
		end
	end
	--defaults
	for k,v in pairs(VGUI) do
		if k ~= "Train" and type(v) ~= "function" and v.Call then v:Call(VGUI) end
	end
	VGUI.WagNum:ValueChanged()
	frame:SetSize(262 + 262*math.floor((Pos-1)/MaxHorisontal)+10, 58+24*math.min(MaxHorisontal,Pos))
	frame:Center()
	if VGUI.Close then VGUI.Close() end
	if VGUI.spawn then VGUI.spawn() end
end
local function Draw()
	local Trains = {}
	for _,name in pairs(Metrostroi.TrainClasses) do
		local ENT = scripted_ents.Get(name)
		if not ENT.Spawner or not ENT.SubwayTrain then continue end
		local ENTl = list.Get("SpawnableEntities")[name]
		--Trains[ENT.ClassName] = ENT.SubwayTrain.Name.."("..ENT.SubwayTrain.Manufacturer..")"
		Trains[ENT.ClassName] = ENTl and ENTl.PrintName or ENT.Spawner and ENT.Spawner.Name or ENT.SubwayTrain.Name.."("..ENT.SubwayTrain.Manufacturer..")"
	end
	CreateList("Train",Format("%s(%d/%d)\n%s:%d",Metrostroi.GetPhrase("Spawner.Trains1"),GetGlobalInt("metrostroi_train_count"),MaxWagons,Metrostroi.GetPhrase("Spawner.Trains2"),MaxWagonsOnPlayer),Trains,UpdateTrainList,Settings)
	CreateSlider("WagNum",0,1, GetGlobalInt("metrostroi_maxwagons"),Metrostroi.GetPhrase("Spawner.WagNum"),function(slider)
		local WagNumTable
		for k,name in pairs(Metrostroi.TrainClasses) do
			local ENT = scripted_ents.Get(name)
			if not ENT.Spawner or ENT.ClassName ~= Settings.Train  then continue end
			WagNumTable = ENT.Spawner.WagNumTable
			break
		end
		if WagNumTable then
			local retval = WagNumTable[1]
			for i=2,#WagNumTable do
				if WagNumTable[i] <= math.Round(slider:GetValue(),0) then
					retval = WagNumTable[i]
				end
			end
			return retval
		end
	end,Settings)
	--CreateCheckBox("AutoCouple",Metrostroi.GetPhrase("Spawner.AutoCouple"),nil,Settings)

	UpdateTrainList()
end
local function createFrame()
	MaxWagons = GetGlobalInt("metrostroi_maxtrains")*GetGlobalInt("metrostroi_maxwagons")
	MaxWagonsOnPlayer = GetGlobalInt("metrostroi_maxtrains_onplayer")*GetGlobalInt("metrostroi_maxwagons")
	--if GetConVarString("gmod_toolmode") == "train_spawner" then RunConsoleCommand("gmod_toolmode", "weld") end
	if !frame or !frame:IsValid() then
		Pos = 0
		VGUI = {}
		frame = vgui.Create("DFrame")
			frame:SetDeleteOnClose(true)
			frame:SetTitle(Metrostroi.GetPhrase("Spawner.Title"))
			--frame:SetSize(275, 34+24*17)
			frame:SetDraggable(false)
			frame:SetSizable(false)
			frame:MakePopup()
			frame.OnRemove = function(panel)
				UpdateConCMD()
			end

		LoadConCMD()
		Draw()

		frame:SetSize(262 + 262*math.floor((Pos-1)/MaxHorisontal)+10, 58+24*math.min(MaxHorisontal,Pos))
		frame:Center()
		local Close = vgui.Create("DButton", frame)
		Close:SetWide(80)
		Close:SetPos(5, frame:GetTall() - Close:GetTall() - 5)
		Close:SetText(Metrostroi.GetPhrase("Spawner.Close"))

		Close.DoClick = function()
			frame:Close()
		end
		VGUI["Close"] = function()
			if IsValid(Close) and IsValid(frame) then Close:SetPos(5, frame:GetTall() - Close:GetTall() - 5) end
		end
		local spawn = vgui.Create("DButton", frame)
		spawn:SetWide(80)
		spawn:SetPos(frame:GetWide() - Close:GetWide() - 5, frame:GetTall() - Close:GetTall() - 5)
		spawn:SetText(Metrostroi.GetPhrase("Spawner.Spawn"))
		VGUI["spawn"] = function()
			if IsValid(spawn) and IsValid(frame) then spawn:SetPos(frame:GetWide() - Close:GetWide() - 5, frame:GetTall() - Close:GetTall() - 5) end
		end

		spawn.DoClick = function()
			--[[
			local Tool = GetConVarString("gmod_toolmode")
			if Tool == "train_spawner" then Tool = "weld" end
			RunConsoleCommand("train_spawner_oldT", Tool)
			RunConsoleCommand("train_spawner_oldW", LocalPlayer():GetActiveWeapon():GetClass())
			RunConsoleCommand("gmod_tool", "train_spawner")
			]]
			local tbl = {}
			tbl = table.Copy(Settings[Settings.Train])
			tbl.Train = Settings.Train
			tbl.AutoCouple = Settings.AutoCouple
			tbl.WagNum = Settings.WagNum or 1
			net.Start("train_spawner_open")
				net.WriteTable(tbl)
			net.SendToServer()
			local tool = LocalPlayer():GetTool("train_spawner")
			tool.Settings = tbl
			local ENT = scripted_ents.Get(tool.Settings.Train)
			if ENT and ENT.Spawner then tool.Train = ENT end
			frame:Close()
		end
	end
end

net.Receive("MetrostroiTrainSpawner",createFrame)
net.Receive("MetrostroiMaxWagons", function()
	MaxWagons = GetGlobalInt("metrostroi_maxtrains")*GetGlobalInt("metrostroi_maxwagons")
	MaxWagonsOnPlayer = GetGlobalInt("metrostroi_maxtrains_onplayer")*GetGlobalInt("metrostroi_maxwagons")
	if trainTypeT and trainTypeT:IsValid() then
		trainTypeT:SetText(Format("%s(%d/%d)\n%s:%d",Metrostroi.GetPhrase("Spawner.Trains1"),GetGlobalInt("metrostroi_train_count"),MaxWagons,Metrostroi.GetPhrase("Spawner.Trains2"),MaxWagonsOnPlayer))
	end
end)
net.Receive("MetrostroiTrainCount", function()
	if trainTypeT and trainTypeT:IsValid() then
		trainTypeT:SetText(Format("%s(%d/%d)\n%s:%d",Metrostroi.GetPhrase("Spawner.Trains1"),GetGlobalInt("metrostroi_train_count"),MaxWagons,Metrostroi.GetPhrase("Spawner.Trains2"),MaxWagonsOnPlayer))
	end
end)

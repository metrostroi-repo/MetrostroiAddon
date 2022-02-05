include("shared.lua")
local MaxHorisontal = 14
local frame = nil
local pFrame = nil
local wFrame = nil
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
	if not Settings[Settings.Train] then Settings[Settings.Train] = {} end
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
        for _,v in ipairs(VGUI) do v(nil,nil,true) end
		stbl[name] = index
		if OnSelect then OnSelect(List,VGUI) end
	end
	List.ID = table.insert(VGUI,function(val, disabled, reset)
		if reset then
			if List.Disable then List:SetEnabled(true) end
		elseif val or disabled then
			if val ~= nil then List:ChooseOptionID(val) end
			List:SetEnabled(not disabled)
			List.Disable = disabled
		else
			ListLabel:Remove()
			List:Remove()
		end
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
	    if Slider.Disable then Slider:SetEnabled(true) Slider.Disable = nil end
	    return
	  end
		if val or disabled then
			if val ~= nil then Slider:SetValue(val) end
			Slider:SetEnabled(not disabled)
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
        for _,v in ipairs(VGUI) do v(nil,nil,true) end
		stbl[name] = CB:GetChecked()
		if OnSelect then OnSelect(CB,VGUI) end
	end
	CB.ID = table.insert(VGUI,function(val, disabled, reset)
	  if reset then
	    if CB.Disable then CB:SetEnabled(true) CB.Disable = nil end
	    return
	  end
		if val or disabled then
			if val ~= nil then CB:SetValue(val) end
			CB:SetEnabled(not disabled)
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

local function UpdateTrainList(fromPresets)
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
		local TrainSpawnerSettings = ENT.Spawner
		Metrostroi_Modules_DispatchEvent("TrainSpawnerSettings", Settings, TrainSpawnerSettings, false)
		for i, menu in ipairs(TrainSpawnerSettings) do
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
	if VGUI.Presets then VGUI.Presets() end
	if VGUI.Wagons then VGUI.Wagons() end
	if VGUI.PFrame and fromPresets ~= true then VGUI.PFrame(true) end
	if VGUI.WFrame then VGUI.WFrame() end
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

local function savePresetData(trainArr,presetArr)
	for k,v in pairs(trainArr) do
		if k == "Presets" or k == "Specials" then continue end
		presetArr[k] = v
	end
end

local function getPresetName(name, presets, ignoreOwn)
	local maxrep = tonumber(name:match("(.+)[%s*]%((%d+)%)$")) or 0

	for i,v in ipairs(presets) do
		local name2,nameid = v.PresetName:match("(.+)[%s*]%((%d+)%)$")
		if (not ignoreOwn or i ~= presets.Selected) and (v.PresetName == name or name2 == name) then
			maxrep = math.max(1,tonumber(nameid) or 1)
		end
	end
	return maxrep > 0 and Format("%s (%d)",name:match("(.+)[%s*]%(%d+%)$") or name,maxrep+1) or name
end

local function createPresetsFrame()
	if IsValid(pFrame) then return end
	pFrame = vgui.Create("DFrame",frame)
	pFrame:SetTitle(Metrostroi.GetPhrase("Spawner.PresetTitle"))
	pFrame:SetDrawOnTop(false)
	pFrame.btnMaxim:SetVisible(false)
	pFrame.btnMinim:SetVisible(false)
	--frame:SetSize(275, 34+24*17)
	pFrame:SetDraggable(true)
	pFrame:SetSizable(false)
	pFrame:MakePopup()
	pFrame:SetZPos(frame:GetZPos()+1)
	pFrame:SetSize(262+10, 58+24*1)
	--pFrame:Center()
	pFrame.OnRemove = function()
		if IsValid(WFrame) then
			VGUI.WFrame()
		end
	end

	--[[local ListLabel = vgui.Create("DLabel", frame)
	--	ListLabel:SetPos(5 + 300*math.floor(Pos/MaxHorisontal), 24+24*(Pos%MaxHorisontal))
	ListLabel:SetPos(5 + 270*math.floor(Pos/MaxHorisontal),24+24*(Pos%MaxHorisontal))
	ListLabel:SetSize(115,28)
	ListLabel:SetText(text)
	ListLabel:SetExpensiveShadow(1,Color(0,0,0,200))]]

	local Presets = vgui.Create("DComboBox", pFrame)--
	Presets:SetPos(5,28)
	--	Presets:SetPos(130 + 300*math.floor(Pos/MaxHorisontal), 28+24*(Pos%MaxHorisontal))
	Presets:SetWide(272-8-72-5)


	local PAdd = vgui.Create("DButton", pFrame)
	PAdd:SetWide(24)
	PAdd:SetPos(272-7-72, 28)
	PAdd:SetTooltip(Metrostroi.GetPhrase("Spawner.Preset.NewTooltip"))
	PAdd:SetImage("icon16/add.png")
	local PUpdate = vgui.Create("DButton", pFrame)
	PUpdate:SetWide(24)
	PUpdate:SetPos(272-6-48, 28)
	PUpdate:SetTooltip(Metrostroi.GetPhrase("Spawner.Preset.UpdateTooltip"))
	PUpdate:SetText("")
	PUpdate:SetImage("icon16/arrow_refresh.png")
	local PRemove = vgui.Create("DButton", pFrame)
	PRemove:SetWide(24)
	PRemove:SetPos(272-5-24, 28)
	PRemove:SetTooltip(Metrostroi.GetPhrase("Spawner.Preset.RemoveTooltip"))
	PRemove:SetText("")
	PRemove:SetImage("icon16/cross.png")

	local PNameLabel = vgui.Create("DLabel", pFrame)
	PNameLabel:SetPos(5,24+24*1+4)
	PNameLabel:SetSize(115,28)
	PNameLabel:SetText(Metrostroi.GetPhrase("Spawner.Presets.Name"))
	PNameLabel:SetWide(100)
	PNameLabel:SetExpensiveShadow(1,Color(0,0,0,200))
	local PName = vgui.Create("DTextEntry", pFrame)
	PName:SetPos(132,24+24*1+4)
	PName:SetSize(135,20)
	PName:SetText("")
	PName:SetPlaceholderText(Metrostroi.GetPhrase("Spawner.Presets.NamePlaceholder"))

	Presets.OnSelect = function(pnl,i, text)
		if i == 1 then
			PName:SetText("My preset name")
		else
			local presets = Settings[Settings.Train] and Settings[Settings.Train].Presets

			if presets and pnl.selected ~= -1 then
				if not presets.Selected or presets.Selected == 0 then
					if not presets[0] then presets[0] = {} end
					savePresetData(Settings[Settings.Train],presets[0])
				end
				presets.Selected = i-2
				for k,v in pairs(presets[presets.Selected] or {}) do
					if k == "PresetName" then continue end
					Settings[Settings.Train][k] = v
				end
				UpdateTrainList(true)
			end
			if i == 2 then
				PName:SetText("")
			else
				PName:SetText(text)
			end
		end
	end

	VGUI["PFrame"] = function(firstDraw)
		if not IsValid(pFrame) then return end
		local presets = Settings[Settings.Train] and Settings[Settings.Train].Presets

		Presets:Clear()
		Presets:AddChoice(Metrostroi.GetPhrase("Spawner.Preset.New"),-2,nil,"icon16/add.png")
		Presets:AddChoice(Metrostroi.GetPhrase("Spawner.Preset.Unsaved"),-1,nil,"icon16/disk.png")
		Presets:SetText(Metrostroi.GetPhrase("Spawner.Preset.NotSelected"))
		PName:SetText("")

		if firstDraw then Presets.selected = -1 end
		if presets then
			--presets.Selected = false
			for i,v in ipairs(presets) do
				Presets:AddChoice(v.PresetName or Format("N/A (%d)",i),i,not firstDraw and presets.Selected == i,nil and "icon16/add.png")
			end
		end
		if Presets:GetSelectedID() == -1 then
			Presets:ChooseOptionID(2)
			if presets then presets.Selected = false end
		end

		if not pFrame.Moved then
			local posX,posY = frame:GetPos()
			pFrame:SetPos(posX+5,posY+30)
			pFrame.Moved = true
		end
	end

	PName.MainPaint = PName.Paint
	PName.Paint = function(pnl, w, h)
		pnl.MainPaint(pnl,w,h)
		if pnl.Error then
			surface.SetDrawColor(255,100,0,150)
			surface.DrawRect(1,1,w-2,h-2)
		end
	end
	PName.CheckEmpty = function(pnl)
		pnl.Error = pnl:GetText():Trim() == ""
		if pnl.Error == "" then
			pnl:SetPlaceholderText(Metrostroi.GetPhrase("Spawner.Presets.NameError"))
		else
			pnl:SetPlaceholderText(Metrostroi.GetPhrase("Spawner.Presets.NamePlaceholder"))
		end
		pnl:SetUpdateOnType(pnl.Error)
		return pnl.Error
	end
	PName.OnValueChange = PName.CheckEmpty
	PAdd.DoClick = function()
		if PName:CheckEmpty() or not Settings[Settings.Train] then return end
		if not Settings[Settings.Train].Presets then Settings[Settings.Train].Presets = {} end
		local presets = Settings[Settings.Train].Presets

		presets.Selected = #presets+1
		local settings = {
			PresetName = getPresetName(PName:GetValue(),presets)
		}
		savePresetData(Settings[Settings.Train],settings)
		table.insert(presets,settings)

		VGUI.PFrame()
	end
	PUpdate.DoClick = function()
		local presets = Settings[Settings.Train] and Settings[Settings.Train].Presets
		if not presets or #presets == 0 or not presets.Selected or presets.Selected > #presets then return end

		local settings = {
			PresetName = getPresetName(PName:GetValue(),presets,true)
		}
		savePresetData(Settings[Settings.Train],settings)
		presets[presets.Selected] = settings

		VGUI.PFrame()
	end
	PRemove.DoClick = function()
		local presets = Settings[Settings.Train] and Settings[Settings.Train].Presets
		if not presets or #presets == 0 or not presets.Selected or presets.Selected > #presets then return end
		table.remove(presets,presets.Selected)
		presets.Selected = false

		VGUI.PFrame(true)
	end
	pFrame.OrigThink = pFrame.Think
	pFrame.Think = function(...)
		pFrame.OrigThink(...)
		if not pFrame:IsActive() and frame:IsActive() then pFrame:MakePopup() end
	end

	VGUI.PFrame(true)
end
local function createWagonsFrame()
	if IsValid(wFrame) then return end
	wFrame = vgui.Create("DFrame",frame)
	wFrame:SetTitle(Metrostroi.GetPhrase("Spawner.WagonsTitle"))
	wFrame:SetDrawOnTop(true)
	wFrame:SetZPos(frame:GetZPos())
	wFrame.btnMaxim:SetVisible(false)
	wFrame.btnMinim:SetVisible(false)
	--frame:SetSize(275, 34+24*17)
	wFrame:SetDraggable(true)
	wFrame:SetSizable(false)
	wFrame:MakePopup()
	wFrame:SetZPos(frame:GetZPos()+1)
	wFrame:SetSize(262 + 262*math.floor((1-1)/MaxHorisontal)+10, 58+24*math.min(MaxHorisontal,1))
	--wFrame:Center()
	VGUI["WFrame"] = function()
		if not IsValid(wFrame) then return end
		local posX,posY = frame:GetPos()
		wFrame:SetPos(posX+7,posY+32)
	end
	wFrame.OnRemove = function()
		if IsValid(PFrame) then
			VGUI.PFrame()
		end
	end
	VGUI.WFrame()
end
local function createFrame()
	MaxWagons = GetGlobalInt("metrostroi_maxtrains")*GetGlobalInt("metrostroi_maxwagons")
	MaxWagonsOnPlayer = GetGlobalInt("metrostroi_maxtrains_onplayer")*GetGlobalInt("metrostroi_maxwagons")
	--if GetConVar("gmod_toolmode"):GetString() == "train_spawner" then RunConsoleCommand("gmod_toolmode", "weld") end
	if IsValid(frame) then return end
	Pos = 0
	VGUI = {}
	frame = vgui.Create("DFrame")
	frame:SetDeleteOnClose(true)
	frame:SetTitle(Metrostroi.GetPhrase("Spawner.Title"))
	frame.btnMaxim:SetVisible(false)
	frame.btnMinim:SetVisible(false)
	--frame:SetSize(275, 34+24*17)
	frame:SetDraggable(false)
	frame:SetSizable(false)
	frame:MakePopup()
	frame.OnRemove = function(panel)
		if IsValid(pFrame) then pFrame:Remove() end
		if IsValid(wFrame) then wFrame:Remove() end
		UpdateConCMD()
	end

	--frame:SetSize(262 + 262*math.floor((Pos-1)/MaxHorisontal)+10, 58+24*math.min(MaxHorisontal,Pos))
	--frame:Center()
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
		local Tool = GetConVar("gmod_toolmode"):GetString()
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
		--[[
		if ENT and ENT.Spawner then 
			local TrainSpawnerSettings = ENT.Spawner
			Metrostroi_Modules_DispatchEvent("TrainSpawnerSettings", Settings, TrainSpawnerSettings, true)
			tool.Train = ENT
			tool.TrainSpawnerSettings = TrainSpawnerSettings
		end]]
		frame:Close()
	end

	local Presets = vgui.Create("DButton", frame)
	Presets:SetWide(24)
	--Presets:SetPos(5, spawn:GetPos() + 5)
	Presets:SetText("")
	Presets:SetImage("icon16/book.png")

	Presets.DoClick = function()
		if IsValid(pFrame) then pFrame:Remove() else
			createPresetsFrame()
			pFrame.OnRemove = function() if IsValid(Presets) then Presets:SetImage("icon16/book.png") end end
		end
		Presets:SetImage(IsValid(pFrame) and "icon16/book_edit.png" or "icon16/book.png")
	end
	VGUI["Presets"] = function()
		if not IsValid(Presets) or not IsValid(frame) then return end
		local posX,posY,width = Close:GetBounds()
		Presets:SetPos(posX + width + 5, posY)
	end

	local Wagons = vgui.Create("DButton", frame)
	Wagons:SetWide(24)
	--Wagons:SetPos(5, spawn:GetPos() + 5)
	Wagons:SetText("")
	Wagons:SetImage("icon16/table.png")

	Wagons.DoClick = function()
		if IsValid(wFrame) then wFrame:Remove() else
			createWagonsFrame()
			wFrame.OnRemove = function() Wagons:SetImage("icon16/table.png") end
		end
		Wagons:SetImage(IsValid(wFrame) and "icon16/table_edit.png" or "icon16/table.png")
	end
	VGUI["Wagons"] = function()
		if not IsValid(Wagons) or not IsValid(frame) then return end
		local posX,posY,width = Presets:GetBounds()
		Wagons:SetPos(posX + width + 5, posY)
	end

	LoadConCMD()
	Draw()
end

net.Receive("train_spawner_open",function()
	local tbl = net.ReadTable()
	local tool = LocalPlayer():GetTool("train_spawner")
	Settings[tbl.Train] = tbl
	Settings.Train = tbl.Train
	tool.Settings = tbl
	UpdateConCMD()
end)
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

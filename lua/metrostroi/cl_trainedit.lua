local Frame
local Train
local function AddButton(parent,func,label,tooltip)
	local Button = vgui.Create("DButton",parent)
	Button:SetText(label)
	Button:SizeToContents()
	Button.DoClick = func
	Button:SetSize(100,30)
	Button:DockMargin(2,2,2,2)
	Button:SetColor(color_black)
	Button:SetToolTip(tooltip)
	return Button
end

local function AddLabel(parent,str)
	local Label = vgui.Create("DLabel",parent)
	Label:SetText(str)
	Label:SizeToContents()
	Label:SetContentAlignment(5)
	Label:DockMargin(2,2,2,2)
	return Label
end
local function EditCSEnts()
	local CSFrame = vgui.Create("DFrame",Frame)
	local _,y = Frame:GetSize()
	CSFrame:SetPos(ScrW()/5+250,ScrH()/3-400/2+y/2)
	CSFrame:SetSize(400,420)
	CSFrame:SetTitle("CSEnts editor")
	CSFrame:SetVisible(true)
	CSFrame:SetDraggable(true)
	CSFrame:ShowCloseButton(true)
	CSFrame:MakePopup()
	CSFrame:SetScreenLock(true)
	--Mark entity button
	
	local CSEnts = vgui.Create( "DTextEntry",CSFrame)
	CSEnts:SetText("Choose a CSEnt")
	CSEnts:Dock(TOP)
	--for k,v in pairs(Train.ClientProps) do
		--CSEnts:AddChoice(k)
	--end
	CSEnts.OnChange = function(self)
		local val = self:GetValue()
		if not Train.ClientProps[val] and not Train.ClientPropsOv[val] then
			if val ~= "" then CSFrame.AddButton:SetVisible(true) end
			CSFrame.PropertiesPanel:SetVisible(false)
			return
		end
		local Properties = CSFrame.PropertiesPanel
		if not Train.ClientPropsOv[val] and Train.ClientProps[val] then
			Train.ClientPropsOv[val] = table.Copy(Train.ClientProps[val])
		end
		CSFrame.ChoosedProp = Train.ClientPropsOv[val]
		CSFrame.ChoosedEnt = function() return Train.ClientEnts[val] end
		CSFrame.ChoosedName = val
		Properties:SetVisible(true)
		Properties:GetCategory("Generic"):GetRow("Model"):SetValue(CSFrame.ChoosedProp.model)
		Properties:GetCategory("Generic"):GetRow("Skin"):SetValue(CSFrame.ChoosedProp.skin)
		Properties:GetCategory("Generic"):GetRow("Bodygroup"):SetValue(CSFrame.ChoosedProp.bodygroup)
		local color = CSFrame.ChoosedProp.color or Color(255,255,255)
		Properties:GetCategory("Generic"):GetRow("Ent Color(White for non change)"):SetValue(Vector(color.r/255,color.g/255,color.b/255))

		Properties:GetCategory("Position"):GetRow("X"):SetValue(CSFrame.ChoosedProp.pos.x)
		Properties:GetCategory("Position"):GetRow("Y"):SetValue(CSFrame.ChoosedProp.pos.y)
		Properties:GetCategory("Position"):GetRow("Z"):SetValue(CSFrame.ChoosedProp.pos.z)

		Properties:GetCategory("Angles"):GetRow("Pitch"):SetValue(CSFrame.ChoosedProp.ang.x)
		Properties:GetCategory("Angles"):GetRow("Yaw"):SetValue(CSFrame.ChoosedProp.ang.y)
		Properties:GetCategory("Angles"):GetRow("Roll"):SetValue(CSFrame.ChoosedProp.ang.z)
		
		CSFrame.AddButton:SetVisible(false)
	end
	local function ReloadCSEnt()
		local name = CSFrame.ChoosedName
		SafeRemoveEntity(CSFrame.ChoosedEnt())
		Train:SpawnCSEnt(name)
		--CSFrame.ChoosedEnt = Train.ClientEnts[name]
	end

	local Properties = vgui.Create( "DProperties", CSFrame )
	Properties:SetVisible(false)
	CSFrame.PropertiesPanel = Properties
	local Model = Properties:CreateRow( "Generic", "Model" ) Model:Setup( "Generic" )
	Model.DataChanged = function(_,val)
		CSFrame.ChoosedProp.model = val
		ReloadCSEnt()
	end
	local Skin = Properties:CreateRow( "Generic", "Skin" ) Skin:Setup("Int", {min=0,max=99}) Skin:SetValue(0)
	Skin.DataChanged = function(_,val)
		CSFrame.ChoosedProp.skin = val
		ReloadCSEnt()
	end
	local Bodygroup = Properties:CreateRow( "Generic", "Bodygroup" ) Bodygroup:Setup("Int", {min=0,max=10}) Bodygroup:SetValue(0)
	local EColor = Properties:CreateRow( "Generic", "Ent Color(White for non change)" ) EColor:Setup("VectorColor", {}) EColor:SetValue(Vector(1,1,1))
	EColor.DataChanged = function(self,val)
		local val = Vector(val)
		CSFrame.ChoosedProp.color = Color(val.x*255,val.y*255,val.z*255)
		ReloadCSEnt()
	end
	local Animation = Properties:CreateRow( "Generic", "Test animation" ) Animation:Setup("FloatEx", {min=0,max=1, dec = 3,fv=0.1}) Animation:SetValue(0)
	Animation.DataChanged = function(_,val)
		local name = CSFrame.ChoosedName
		local CSEnt = CSFrame.ChoosedEnt()
		
		if Train.Anims[name] then
			Train.Anims[name].Ignore = CurTime()+5
		end
		CSEnt:SetPoseParameter("position",val)
			
	end
	local Reload = Properties:CreateRow( "Generic", "Reload" ) Reload:Setup("Button")
	Reload.OnPress = function(self)
		CSEnts:OnChange(CSEnts:GetValue(),CSFrame.ChoosedName)
	end
	local Reset = Properties:CreateRow( "Generic", "Reset/Remove" ) Reset:Setup("Button")
	Reset.OnPress = function(self)
		CSEnts:OnChange()
		Train.ClientPropsOv[CSEnts:GetValue()] = nil
		CSEnts:OnChange()
		ReloadCSEnt(CSFrame.ChoosedName)
	end
	local PosX = Properties:CreateRow( "Position", "X" )
	PosX:Setup("FloatEx", {min=-500,max=500, zoom = 1000})
	PosX:SetValue(0)
	PosX.DataChanged = function(_,val)
		local pos = CSFrame.ChoosedProp.pos
		CSFrame.ChoosedProp.pos = Vector(val,pos.y,pos.z)
		ReloadCSEnt()
	end
	local PosY = Properties:CreateRow( "Position", "Y" )
	PosY:Setup("FloatEx", {min=-100,max=100, zoom=1000})
	PosY:SetValue(0)
	PosY.DataChanged = function(_,val)
		local pos = CSFrame.ChoosedProp.pos
		CSFrame.ChoosedProp.pos = Vector(pos.x,val,pos.z)
		ReloadCSEnt()
	end
	local PosZ = Properties:CreateRow( "Position", "Z" )
	PosZ:Setup("FloatEx", {min=-100,max=100, zoom=1000})
	PosZ:SetValue(0)
	PosZ.DataChanged = function(_,val)
		local pos = CSFrame.ChoosedProp.pos
		CSFrame.ChoosedProp.pos = Vector(pos.x,pos.y,val)
		ReloadCSEnt()
	end
	
	local LMX = Properties:CreateRow( "LocalMove", "X" )
	LMX:Setup("FloatEx", {min=-1,max=1, zoom = 1000, nodraw = true})
	LMX:SetValue(0)
	LMX.DataChanged = function(self,val)
		local pos = CSFrame.ChoosedProp.pos
		local ang = CSFrame.ChoosedProp.ang
		local rotated = Vector(val,0,0)
		rotated:Rotate(ang)
		CSFrame.ChoosedProp.pos = pos + rotated
		ReloadCSEnt()
		self:SetValue(0)
		Properties:GetCategory("Position"):GetRow("X"):SetValue(CSFrame.ChoosedProp.pos.x)
		Properties:GetCategory("Position"):GetRow("Y"):SetValue(CSFrame.ChoosedProp.pos.y)
		Properties:GetCategory("Position"):GetRow("Z"):SetValue(CSFrame.ChoosedProp.pos.z)
	end
	local LMY = Properties:CreateRow( "LocalMove", "Y" )
	LMY:Setup("FloatEx", {min=-1,max=1, zoom=1000})
	LMY:SetValue(0)
	LMY.DataChanged = function(self,val)
		local pos = CSFrame.ChoosedProp.pos
		local ang = CSFrame.ChoosedProp.ang
		local rotated = Vector(0,val,0)
		rotated:Rotate(ang)
		CSFrame.ChoosedProp.pos = pos + rotated
		ReloadCSEnt()
		self:SetValue(0)
		Properties:GetCategory("Position"):GetRow("X"):SetValue(CSFrame.ChoosedProp.pos.x)
		Properties:GetCategory("Position"):GetRow("Y"):SetValue(CSFrame.ChoosedProp.pos.y)
		Properties:GetCategory("Position"):GetRow("Z"):SetValue(CSFrame.ChoosedProp.pos.z)
	end
	local LMZ = Properties:CreateRow( "LocalMove", "Z" )
	LMZ:Setup("FloatEx", {min=-1,max=1, zoom=1000})
	LMZ:SetValue(0)
	LMZ.DataChanged = function(self,val)
		local pos = CSFrame.ChoosedProp.pos
		local ang = CSFrame.ChoosedProp.ang
		local rotated = Vector(0,0,val)
		rotated:Rotate(ang)
		CSFrame.ChoosedProp.pos = pos + rotated
		ReloadCSEnt()
		self:SetValue(0)
		Properties:GetCategory("Position"):GetRow("X"):SetValue(CSFrame.ChoosedProp.pos.x)
		Properties:GetCategory("Position"):GetRow("Y"):SetValue(CSFrame.ChoosedProp.pos.y)
		Properties:GetCategory("Position"):GetRow("Z"):SetValue(CSFrame.ChoosedProp.pos.z)
	end
	local AngP = Properties:CreateRow( "Angles", "Pitch" )
	AngP:Setup("FloatEx", {min=-360,max=360, dec=1, zoom=1000})
	AngP:SetValue(0)
	AngP.DataChanged = function(self,val)
		local ang = CSFrame.ChoosedProp.ang
		CSFrame.ChoosedProp.ang = Angle(val,ang.y,ang.r)
		ReloadCSEnt()
	end
	local AngY = Properties:CreateRow( "Angles", "Yaw" )
	AngY:Setup("FloatEx", {min=-360,max=360, zoom=1000})
	AngY:SetValue(0)
	AngY.DataChanged = function(_,val)
		local ang = CSFrame.ChoosedProp.ang
		CSFrame.ChoosedProp.ang = Angle(ang.p,val,ang.r)
		ReloadCSEnt()
	end
	local AngR = Properties:CreateRow( "Angles", "Roll" )
	AngR:Setup("FloatEx", {min=-360,max=360, zoom=1000})
	AngR:SetValue(0)
	AngR.DataChanged = function(_,val)
		local ang = CSFrame.ChoosedProp.ang
		CSFrame.ChoosedProp.ang = Angle(ang.p,ang.y,val)
		ReloadCSEnt()
	end
	Properties:Dock(FILL)

	local BottomPanel = vgui.Create("DPanel",CSFrame)
	BottomPanel:SetSize(20,50)
	BottomPanel:Dock(BOTTOM)
	BottomPanel:SetPaintBackground(false)

	local AddButt = AddButton(CSFrame,function()
		Train.ClientPropsOv[CSEnts:GetValue()] = {
			pos = Vector(0,0,0),
			ang = Angle(0,0,0),
			model = "",
			config = {},
		}
		CSEnts:OnChange()
	end,"Add","Add a new CSEnt") AddButt:Dock(BOTTOM) AddButt:SetVisible(false)
	CSFrame.AddButton = AddButt

	local CpSet = AddButton(BottomPanel,function()
		local name = CSFrame.ChoosedName
		local prop = CSFrame.ChoosedProp
		local model = prop.model
		local skin = prop.skin
		local color = prop.color
		local bodygroup = prop.bodygroup
		local pos = prop.pos
		local ang = prop.ang
		local set = "ENT.ClientProps[\""
		set = set..CSFrame.ChoosedName.."\"] = {\n"
		set = set..Format("\tmodel = \"%s\",\n",model)
		set = set..Format("\tpos = Vector(%f,%f,%f),\n",pos.x,pos.y,pos.z)
		set = set..Format("\tang = Angle(%f,%f,%f),\n",ang.p,ang.y,ang.r)
		if skin and skin > 0 then
			set = set..Format("\tskin = %d,\n",skin)
		end
		if color and color ~= Color(255,255,255) then
			set = set..Format("\tcolor = Color(%d,%d,%d),\n",color.r,color.g,color.b)
		end
		if bodygroup and bodygroup > 0 then
			set = set..Format("\tbodygroup = %d,\n",bodygroup)
		end
		set = set.."}\n"
		SetClipboardText(set)
	end,"Copy settings","Copy LUA part to clipboard and print it")
	CpSet:Dock(LEFT)
	CpSet:SetColor(color_black)

	local PrSet = AddButton(BottomPanel,function()
		local name = CSFrame.ChoosedName
		local prop = CSFrame.ChoosedProp
		local model = prop.model
		local skin = prop.skin
		local color = prop.color
		local bodygroup = prop.bodygroup
		local pos = prop.pos
		local ang = prop.ang
		local set = "ENT.ClientProps[\""
		set = set..CSFrame.ChoosedName.."\"] = {\n"
		set = set..Format("\tmodel = \"%s\",\n",model)
		set = set..Format("\tpos = Vector(%f,%f,%f),\n",pos.x,pos.y,pos.z)
		set = set..Format("\tang = Angle(%f,%f,%f),\n",ang.p,ang.y,ang.r)
		if skin and skin > 0 then
			set = set..Format("\tskin = %d,\n",skin)
		end
		if color and color ~= Color(255,255,255) then
			set = set..Format("\tcolor = Color(%d,%d,%d),\n",color.r,color.g,color.b)
		end
		if bodygroup and bodygroup > 0 then
			set = set..Format("\tbodygroup = %d,\n",bodygroup)
		end
		set = set.."}\n"
		-- print(set)
	end,"Print settings","Print LUA part to clipboard and print it")
	PrSet:Dock(RIGHT)
end

local function EditPanel()
	local PanelFrame = vgui.Create("DFrame",Frame)
	local _,y = Frame:GetSize()
	PanelFrame:SetPos(ScrW()/5+250,ScrH()/3-400/2+y/2)
	PanelFrame:SetSize(400,420)
	PanelFrame:SetTitle("Panel editor")
	PanelFrame:SetVisible(true)
	PanelFrame:SetDraggable(true)
	PanelFrame:ShowCloseButton(true)
	PanelFrame:MakePopup()
	PanelFrame:SetScreenLock(true)
	--Mark entity button
	
	local PanelEnts = vgui.Create( "DComboBox",PanelFrame)
	PanelEnts:SetText("Choose a PanelEnt")
	PanelEnts:Dock(TOP)
	for k,v in pairs(Train.ClientProps) do
		PanelEnts:AddChoice(k)
	end
	PanelEnts.OnSelect = function(self,_,val)
		local Properties = PanelFrame.PropertiesPanel
		if not Train.ClientPropsOv[val] then
			--Train.ClientPropsOv[val] = {}
			--table.CopyFromTo(Train.ClientProps[val],Train.ClientPropsOv[val])
		end
		--PanelFrame.ChoosedProp = Train.ClientPropsOv[val]
		PanelFrame.ChoosedEnt = Train.ClientEnts[val]
		PanelFrame.ChoosedName = val
		Properties:SetVisible(true)
	end
	local function ReloadCSEnt()
		local name = PanelFrame.ChoosedName
		SafeRemoveEntity(CSFrame.ChoosedEnt)
		Train:SpawnCSEnt(name)
		CSFrame.ChoosedEnt = Train.ClientEnts[name]
	end

	local Properties = vgui.Create( "DProperties", PanelFrame )
	Properties:SetVisible(false)
	PanelFrame.PropertiesPanel = Properties
	Properties:Dock(FILL)

	local BottomPanel = vgui.Create("DPanel",PanelFrame)
	BottomPanel:SetSize(20,100)
	BottomPanel:Dock(BOTTOM)
	BottomPanel:SetPaintBackground(false)
	
	local Reload = AddButton(BottomPanel,function()
		--PanelEnts:OnSelect(PanelEnts:GetSelectedID(),PanelFrame.ChoosedPanelEntName)
	end, "Reload", "Reload all settings")
	Reload:Dock(TOP)
	local Reset = AddButton(BottomPanel,function()
		--PanelEnts:OnSelect(PanelEnts:GetSelectedID(),PanelFrame.ChoosedPanelEntName)
		--Train.ClientPropsOv[PanelFrame.ChoosedPanelEntName] = nil
		--PanelEnts:OnSelect(PanelEnts:GetSelectedID(),PanelFrame.ChoosedPanelEntName)
		--ReloadPanelEnt(PanelFrame.ChoosedPanelEntName)
	end, "Reset", "Reset all settings")
	Reset:Dock(TOP)

	local CpSet = AddButton(BottomPanel,function()
		local set = ""
		SetClipboardText(set)
	end,"Copy settings","Copy LUA part to clipboard and print it")
	CpSet:Dock(LEFT)
	CpSet:SetColor(color_black)

	local PrSet = AddButton(BottomPanel,function()
		local set = ""
	end,"Print settings","Print LUA part to clipboard and print it")
	PrSet:Dock(RIGHT)
end

local function EditCLPFB()
	local CLPFBFrame = vgui.Create("DFrame",Frame)
	local _,y = Frame:GetSize()
	CLPFBFrame:SetPos(ScrW()/5+250,ScrH()/3-400/2+y/2)
	CLPFBFrame:SetSize(400,420)
	CLPFBFrame:SetTitle("ClientPropForButton editor")
	CLPFBFrame:SetVisible(true)
	CLPFBFrame:SetDraggable(true)
	CLPFBFrame:ShowCloseButton(true)
	CLPFBFrame:MakePopup()
	CLPFBFrame:SetScreenLock(true)
	--Mark entity button
	
	local CLPFBEnts = vgui.Create( "DTextEntry",CLPFBFrame)
	CLPFBEnts:SetText("Choose a ClientPropForButton")
	CLPFBEnts:Dock(TOP)
	--for k,v in pairs(Train.ClientProps) do
		--if v.config then CLPFBEnts:AddChoice(k) end
	--end
	CLPFBEnts.OnChange = function(self)
		local Properties = CLPFBFrame.PropertiesCLPFB
		local val = self:GetValue()
		if not Train.ClientProps[val] and not Train.ClientPropsOv[val] then
			if val ~= "" then CLPFBFrame.AddButton:SetVisible(true) end
			Properties:SetVisible(false)
			return
		end
		if not Train.ClientPropsOv[val] and Train.ClientProps[val] then
			Train.ClientPropsOv[val] = table.Copy(Train.ClientProps[val])
		end
		CLPFBFrame.ChoosedTable = function() return Train.ClientPropsOv[val].config end
		CLPFBFrame.ChoosedEnt = function() return Train.ClientEnts[val] end
		CLPFBFrame.ChoosedName = val
		--Properties:GetCategory("Generic"):GetRow("Panel"):SetValue(CLPFBFrame.ChoosedTable().panel)
		local panel = Properties:GetCategory("Generic"):GetRow("Panel")
		panel:Setup("Combo",{text="Select panel", values = {}})
		--PrintTable(panel.Panel:GetTable())
		--for i=1,100 do
			--print(panel:SetSelected(i))
		--end
		for k,v in pairs(Train.ButtonMap) do
			panel:AddChoice(k,k,k == CLPFBFrame.ChoosedTable().panel)
		end
	
		local button = Properties:GetCategory("Generic"):GetRow("Button")
		button:Setup("Combo",{text="Select button", values = {}})
		if Train.ButtonMap[CLPFBFrame.ChoosedTable().panel] then
			for k,v in pairs(Train.ButtonMap[CLPFBFrame.ChoosedTable().panel].buttons) do
				button:AddChoice(v.ID,v.ID,v.ID == CLPFBFrame.ChoosedTable().button)
			end
		end
		--Properties:GetCategory("Generic"):GetRow("Button"):SetValue(CLPFBFrame.ChoosedTable().button)
		Properties:GetCategory("Generic"):GetRow("Model"):SetValue(CLPFBFrame.ChoosedTable().model)
		Properties:GetCategory("Generic"):GetRow("Angles"):SetValue(CLPFBFrame.ChoosedTable().ang or 270)
		Properties:GetCategory("Generic"):GetRow("Z offset"):SetValue(CLPFBFrame.ChoosedTable().z)
		Properties:GetCategory("Generic"):GetRow("Skin"):SetValue(CLPFBFrame.ChoosedTable().skin)
		Properties:GetCategory("Generic"):GetRow("Ignore touch"):SetValue(CLPFBFrame.ChoosedTable().ignorepanel)
		local color = CLPFBFrame.ChoosedTable().color or Color(255,255,255)
		Properties:GetCategory("Generic"):GetRow("Ent Color(White for non change)"):SetValue(Vector(color.r/255,color.g/255,color.b/255))
		
		Properties:SetVisible(true)
		CLPFBFrame.AddButton:SetVisible(false)
	end
	local function ReloadCSEnt()
		local name = CLPFBFrame.ChoosedName
		Metrostroi.TempoaryClientPropForButton(Train,name,CLPFBFrame.ChoosedTable())
		SafeRemoveEntity(CLPFBFrame.ChoosedEnt())
		Train:SpawnCSEnt(name)
		--CLPFBFrame.ChoosedEnt() = Train.ClientEnts[name]
	end

	local Properties = vgui.Create( "DProperties", CLPFBFrame ) CLPFBFrame.PropertiesCLPFB = Properties
	Properties:SetVisible(false)
	Properties:Dock(FILL)
	
	local Panel = Properties:CreateRow("Generic","Panel")
		Panel:Setup("Combo",{text="Select panel", values = {}})
		--for k,v in pairs(Train.ButtonMap) do
			--if v.buttons then Panel:AddChoice(k,k) end
		--end
		Panel.DataChanged = function(self, data)
			local button = Properties:GetCategory("Generic"):GetRow("Button")
			button:Setup("Combo",{text="Select button", values = {}})
			for k,v in pairs(Train.ButtonMap[data].buttons) do
				button:AddChoice(v.ID,v.ID,v.ID == CLPFBFrame.ChoosedTable().button)
			end
			CLPFBFrame.ChoosedTable().panel = data
		end
		--for k,v in pairs(Train.ButtonMap) do
			--Panel:AddChoice(k,Train.ButtonMap.buttons)
	--local Button = Properties:CreateRow("General","Panel") Panel:Setup("Combo")
	local Button = Properties:CreateRow("Generic","Button")
		Button:Setup("Combo",{text="Select button", values = {}})
		Button.DataChanged = function(self,val)
			CLPFBFrame.ChoosedTable().button = val
			ReloadCSEnt()
		end
			
	local Model = Properties:CreateRow("Generic","Model") Model:Setup("Generic")
		Model.DataChanged = function(self,val)
			CLPFBFrame.ChoosedTable().model = val
			ReloadCSEnt()
		end
	local Ang = Properties:CreateRow("Generic","Angles") Ang:Setup("Int",{min=0,max=360}) Ang:SetValue(0)
		Ang.DataChanged = function(self,val)
			CLPFBFrame.ChoosedTable().ang = val
			ReloadCSEnt()
		end
	local Z = Properties:CreateRow("Generic","Z offset") Z:Setup("Float",{min=-30,max=30}) Z:SetValue(0)
		Z.DataChanged = function(self,val)
			CLPFBFrame.ChoosedTable().z = val
			ReloadCSEnt()
		end
	local Skin = Properties:CreateRow("Generic","Skin","Test") Skin:Setup("Int", {min=0,max=99}) Skin:SetValue(0)
		Skin.DataChanged = function(self,val)
			CLPFBFrame.ChoosedTable().skin = val
			ReloadCSEnt()
		end
	local IgnoreP = Properties:CreateRow("Generic","Ignore touch","Test") IgnoreP:Setup("Boolean") IgnoreP:SetValue(false)
		IgnoreP.DataChanged = function(self,val)
			CLPFBFrame.ChoosedTable().ignorepanel = val
			ReloadCSEnt()
		end
	local EColor = Properties:CreateRow( "Generic", "Ent Color(White for non change)" ) EColor:Setup("VectorColor", {}) EColor:SetValue(Vector(1,1,1))
		EColor.DataChanged = function(self,val)
			local val = Vector(val)
			CLPFBFrame.ChoosedTable().color = Color(val.x*255,val.y*255,val.z*255)
			ReloadCSEnt()
		end
	
	local Reload = Properties:CreateRow( "Generic", "Reload" ) Reload:Setup("Button")
	Reload.OnPress = function(self)
		CLPFBEnts:OnChange()
	end
	local Reset = Properties:CreateRow( "Generic", "Reset/Remove" ) Reset:Setup("Button")
	Reset.OnPress = function(self)
		CLPFBEnts:OnChange()
		Train.ClientPropsOv[CLPFBFrame.ChoosedName] = nil
		CLPFBEnts:OnChange()
		if Train.ClientPropsOv[CLPFBFrame.ChoosedName] then ReloadCSEnt() end
	end

	local BottomCLPFB = vgui.Create("DPanel",CLPFBFrame)
	BottomCLPFB:SetSize(20,50)
	BottomCLPFB:Dock(BOTTOM)
	BottomCLPFB:SetPaintBackground(false)
	local AddButt = AddButton(CLPFBFrame,function()
		Train.ClientPropsOv[CLPFBEnts:GetValue()] = {
			pos = Vector(0,0,0),
			ang = Angle(0,0,0),
			model = "",
			config = {},
		}
		CLPFBEnts:OnChange()
	end,"Add","Add a new ClientPropForButton") AddButt:Dock(BOTTOM) AddButt:SetVisible(false)
	CLPFBFrame.AddButton = AddButt

	local CpSet = AddButton(BottomCLPFB,function()
		local set = ""
		SetClipboardText(set)
	end,"Copy settings","Copy LUA part to clipboard and print it")
	CpSet:Dock(LEFT)
	CpSet:SetColor(color_black)

	local PrSet = AddButton(BottomCLPFB,function()
		local set = ""
	end,"Print settings","Print LUA part to clipboard and print it")
	PrSet:Dock(RIGHT)
end

local function markEntity(self)
	ent = LocalPlayer():GetEyeTrace().Entity
	if IsEntity(ent) and IsValid(ent) and ent.Base == "gmod_subway_base" then
		Train = ent
		if not Train.ClientPropsOv then Train.ClientPropsOv = {} end
		Frame.MessageLabel:SetText("Current train:"..tostring(Train:EntIndex()))
		local UtilsPanel = vgui.Create("DPanel",Frame)
		UtilsPanel:SetSize(20,90)
		UtilsPanel:DockMargin(2,2,2,2)
		UtilsPanel:Dock(TOP)
		local UtilsL = AddLabel(UtilsPanel,"Edit a:")
		UtilsL:Dock(TOP)
		UtilsL:SetTextColor(Color(3,3,3))
		
		--Start/stop buttons
		local b1 = AddButton(UtilsPanel,EditCSEnts,"CSEnts","Edits a panel in train"):Dock(TOP)
		local b2 = AddButton(UtilsPanel,EditPanel,"Panel","Edits a panel in train"):Dock(LEFT)
		local b2 = AddButton(UtilsPanel,EditCLPFB,"CLPFB","Edits a ClientPropForButton"):Dock(RIGHT)
		Frame:SetSize(250,210)
	else
		local Frame = vgui.Create("DFrame")
		Frame:SetPos(ScrW()/5,ScrH()/3)
		Frame:SetSize(250,85)
		Frame:SetTitle("Warning")
		Frame:SetVisible(true)
		Frame:SetDraggable(false)
		Frame:ShowCloseButton(true)
		Frame:MakePopup()
		Frame:Center()
		AddLabel(Frame,"You should look at valid train!"):Dock(TOP)
		AddButton(Frame,function() Frame:Close() end,"Close"):Dock(TOP)
	end
end
local xxx

local function OpenConfigWindow()
	--Main frame
	if not IsValid(Frame) then
		Frame = vgui.Create("DFrame")
		Frame:SetPos(ScrW()/5,ScrH()/3)
		Frame:SetSize(250,100)
		Frame:SetTitle("Metrostroi train editor")
		Frame:SetVisible(true)
		Frame:SetDraggable(true)
		Frame:ShowCloseButton(true)
		Frame:MakePopup()
		--Frame:KillFocus()
	else
		Frame:ToggleVisible()
		return
	end
	--Mark entity button
	local mb = AddButton(Frame,function() Frame:ToggleVisible() end,"Hide","Hide a panel")
	mb:DockMargin(2,2,2,2)
	mb:Dock(TOP)
	mb:SetColor(color_black)
	--Mark entity button
	local mb = AddButton(Frame,markEntity,"Mark Entity","Mark the entity you're looking at as the one to edit")
	mb:DockMargin(2,2,2,2)
	mb:Dock(TOP)
	mb:SetColor(color_black)
	if xxx then AddButton(Frame,function() Frame:Close() end,"Close"):Dock(TOP) end
	Frame.MessageLabel = AddLabel(Frame,"")
	Frame.MessageLabel:Dock(TOP)

end
concommand.Add("metrostroi_traineditor",OpenConfigWindow,nil,"Train editor for trains")
concommand.Add("metrostroi_traineditor_hide",function() Frame:SetVisible(false) end,nil,"Hide train editor")
concommand.Add("metrostroi_traineditor_close",function() Frame:Close() end,nil,"Close train editor")


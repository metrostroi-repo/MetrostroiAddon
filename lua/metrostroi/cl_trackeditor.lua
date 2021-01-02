local Paths = {}
local ServerMessage
local MessageLabel
local List 
local SelectedPath

local SelectedColor = Color(255,0,0)
local DeSelectedColor = color_white

local function RemovePath(pathid)
	RunConsoleCommand("metrostroi_trackeditor_removepath",pathid)
end

local function TeleToStart(pathid)
	RunConsoleCommand("metrostroi_trackeditor_teletostart",pathid)
end

local function TeleToEnd(pathid)
	RunConsoleCommand("metrostroi_trackeditor_teletoend",pathid)
end

local function TeleEntToStart(pathid)
	RunConsoleCommand("metrostroi_trackeditor_teleenttostart",pathid)
end

local function TeleEntToEnd(pathid)
	RunConsoleCommand("metrostroi_trackeditor_teleenttoend",pathid)
end

local function SetSelectedPath(self,lineID, line)
	SelectedPath = lineID
end

local function ShowRowMenu(self,lineID, line)
	local menu = DermaMenu()
	menu:AddOption("Teleport entity to start",function() TeleEntToStart(lineID) end)
	menu:AddOption("Teleport entity to end",function() TeleEntToEnd(lineID) end)
	menu:AddOption("Teleport me to start",function() TeleToStart(lineID) end)
	menu:AddOption("Teleport me to end",function() TeleToEnd(lineID) end)
	menu:AddOption("Delete",function() RemovePath(lineID) end)
	menu:Open()
end

local function UpdateList()
	if not List then return end
	List:Clear()
	for k,v in pairs(Paths) do
		List:AddLine(k,#v)
	end
end

net.Receive("metrostroi_trackeditor_trackdata",function(len,ply)
	local ID = net.ReadInt(16)
	print(Format("Received trackeditor path:%d",ID))
	if ID == 0 then
		Paths = {}
		return
	end
	Paths[ID] = net.ReadTable()
	UpdateList()
end)

net.Receive("metrostroi_trackeditor_message",function(len,ply) 
	ServerMessage = net.ReadString()
	if MessageLabel and ServerMessage and IsValid(MessageLabel) then
		MessageLabel:SetText(ServerMessage)
	end
end)
local ShowPaths=true
concommand.Add("metrostroi_trackeditor_togglenodes",function()
	ShowPaths=not ShowPaths
end)
local function OpenConfigWindow()
	
	local function AddButton(parent,cmd,label,tooltip)
		local Button = vgui.Create("DButton",parent)
		Button:SetText(label)
		Button:SizeToContents()
		Button:SetConsoleCommand(cmd)
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
	
	--Main frame
	local Frame = vgui.Create("DFrame")
	Frame:SetPos(surface.ScreenWidth()/5,surface.ScreenHeight()/3)
	Frame:SetSize(250,400)
	Frame:SetTitle("Metrostroi Track Recorder")
	Frame:SetVisible(true)
	Frame:SetDraggable(true)
	Frame:ShowCloseButton(true)
	
	--Mark entity button
	local mb = AddButton(Frame,"metrostroi_trackeditor_mark","Mark Entity","Mark the entity you're looking at as the one to record with")
	mb:DockMargin(2,2,2,2)
	mb:Dock(TOP)
	mb:SetColor(color_black)
	
	--Panel for path recording
	local PathPanel = vgui.Create("DPanel",Frame)
	PathPanel:SetSize(20,60)
	PathPanel:DockMargin(2,2,2,2)
	PathPanel:Dock(TOP)
	
	--Label for path recording panel
	local PathL = AddLabel(PathPanel,"Path Recording")
	PathL:Dock(TOP)
	PathL:SetDark(true)
	
	--Start/stop buttons
	local b1 = AddButton(PathPanel,"metrostroi_trackeditor_start","Start","Start recording a new path")
	local b2 = AddButton(PathPanel,"metrostroi_trackeditor_stop","Stop","Stop recording the current path")
	
	b1:Dock(LEFT)
	b2:Dock(RIGHT)
	
	--Save/load panel
	local LoadPanel = vgui.Create("DPanel",Frame)
	LoadPanel:SetSize(20,60)
	LoadPanel:DockMargin(2,2,2,2)
	LoadPanel:Dock(TOP)
	
	--Label for save/load panel
	local FileL = AddLabel(LoadPanel,"Save/load to file")
	FileL:Dock(TOP)
	FileL:SetDark(true)
	
	--Save/load buttons
	local b1 = AddButton(LoadPanel,"metrostroi_trackeditor_load","Load","Load the map's track data file")
	local b2 = AddButton(LoadPanel,"metrostroi_trackeditor_save","Save","Save all paths to the map's data file")
	
	b1:Dock(LEFT)
	b2:Dock(RIGHT)
	
	--Server message label
	MessageLabel = AddLabel(Frame,"")
	MessageLabel:Dock(TOP)
	
	local b3=AddButton(Frame,"metrostroi_trackeditor_togglenodes","Hide/Show Nodes","Toggle if node lines are shown or not.")
	b3:Dock(TOP)
	
	List = vgui.Create("DListView",Frame)
	List:DockMargin(2,2,2,2)
	List:Dock(FILL)
	List:SetMultiSelect(false)
	List:AddColumn("ID")
	List:AddColumn("Nodes")
	List:SetTall(100)
	List.OnRowSelected = SetSelectedPath
	List.OnRowRightClick = ShowRowMenu
	UpdateList()
	
	Frame:SizeToContents()
	Frame:MakePopup()
end
concommand.Add("metrostroi_trackeditor",OpenConfigWindow,nil,"GUI for track editor")



hook.Add("PostDrawTranslucentRenderables","metrostroi_trackeditor_draw",function()
	if ShowPaths then
		for k,path in pairs(Paths) do
		
			local lastnode = nil
			local col = Either(k==SelectedPath,SelectedColor,DeSelectedColor)
			
			for k2,node in pairs(path) do
				if lastnode then
					render.DrawLine(node,lastnode,col,true)
				end
				render.DrawWireframeSphere(node,10,2,2,col,true)
				lastnode = node
			end
		end
	end
end)
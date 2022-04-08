include("shared.lua")

if not file.Exists("metrostroi_train_spawner.txt","DATA") then
    file.Write("metrostroi_train_spawner.txt","")
end

if not file.Exists("metrostroi_consists/","DATA") then
    file.CreateDir("metrostroi_consists")
end

local function GetConsistsList()
    local files = file.Find("metrostroi_consists/*.txt", "DATA")
    for k, v in pairs(files) do
        files[k] = string.sub(v, 1, -5)
    end
    return files
end

local function ReadConsist(filename)
    local obj = util.JSONToTable(file.Read("metrostroi_consists/" .. filename .. ".txt"), "DATA") or {}
    return obj
end

local function WriteConsist(filename, obj)
    file.Write("metrostroi_consists/" .. filename .. ".txt", util.TableToJSON(obj or {}, false))
end

local function ExistsConsist(filename)
    return file.Exists("metrostroi_consists/" .. filename .. ".txt", "DATA")
end

local function DeleteConsist(filename)
    if ExistsConsist(filename) then
        file.Delete("metrostroi_consists/" .. filename .. ".txt")
    end
end

local function ReadSettings()
    return util.JSONToTable(file.Read("metrostroi_train_spawner.txt","DATA"))
end

local function WriteSettings(tbl)
    file.Write("metrostroi_train_spawner.txt", util.TableToJSON(tbl, true))
end

local function GetTrainName(class, consist)
    local ENT = scripted_ents.Get(class)
    if consist then
        if not (ENT.Spawner or ENT.SubwayTrain) then return end
    else
        if not ENT.Spawner or not ENT.SubwayTrain then return end
    end
    local ENT_list = list.Get("SpawnableEntities")[class]

    local name = ENT_list and ENT_list.PrintName or ENT.Spawner and ENT.Spawner.Name or ENT.SubwayTrain.Name.."("..ENT.SubwayTrain.Manufacturer..")"
    return name, ENT
end

local function GetPath(name)
    name = string.lower(name)
    name = string.Replace(name, "\\", "-") -- никто не объяснил как это сделать паттернами :(
    name = string.Replace(name, "/", "-")
    name = string.Replace(name, ":", "-")
    name = string.Replace(name, "*", "-")
    name = string.Replace(name, "?", "-")
    name = string.Replace(name, '"', "-")
    name = string.Replace(name, "<", "-")
    name = string.Replace(name, ">", "-")
    name = string.Replace(name, "|", "-")
    name = string.Replace(name, "+", "-")

    return name
end

FRAME = {}

function FRAME:Init() end

function FRAME:CreateError(msg)
    self.Error = vgui.Create("DLabel", self)
    self.Error:SetText("Error: " .. msg)
    self.Error:SetColor(Color(255, 0, 0))
    self.Error:Dock(FILL)
    self.Error:SetContentAlignment(5)
    self.Error:SetExpensiveShadow(1,Color(0,0,0,200))
end

function FRAME:Setup(train, settings, entSettings, frame)
    self.Settings = settings
    self.TrainClass = train

    local ent = scripted_ents.Get(train)
    if not ent then
        self:CreateError("ENT is nil\nTrain Class: " .. train)
        return
    end

    if not entSettings then
        self:CreateError("ENT №2 is nil\nTrain Class: " .. train)
        return
    end
    if not entSettings.Spawner then
        self:CreateError("ENT.Spawner is nil\nTrain Class: " .. train)
        return
    end

    self.Train = ent
    self.EntSettings = entSettings

    local isinterim = entSettings.Spawner.interim == ent.ClassName

    if entSettings.Spawner.forinterim and isinterim then
        self:PrepareSpawner()
    end

    self.Pos = 0
    self.MaxHorizontal = 20

    self.OffsetY = 4

    self.ConsistFrame = frame

    self:Load()
end

function FRAME:Paint(w, h)
    draw.RoundedBox(4, 0, 0, w, h, Color(72, 72, 72, self:GetAlpha()))
    draw.RoundedBox(4, 1, 1, w-2, h-2, Color(108, 111, 114, self:GetAlpha()))
end

function FRAME:PrepareSpawner()
    local tbl = {}
    local i = 1

    for _, menu in ipairs(self.EntSettings.Spawner) do
        if self.EntSettings.Spawner.forinterim[menu[1]] then
            tbl[i] = menu
            i = i + 1
        elseif type(menu[1]) == "number" then
            tbl[i] = menu
            i = i + 1
        elseif #menu==0 then
            tbl[i] = {}
            i = i + 1
        end
    end
    self.InterimSpawner = tbl
end

function FRAME:Load()
    local function incPos(a) self.Pos=self.Pos+(a or 1) end

    local def_settings = ReadSettings()
    local def_train = def_settings[self.EntSettings.ClassName]
    
    self.Objects = {}
    self.ObjectsTypes = {}

    local spawnertbl = self.InterimSpawner or self.EntSettings.Spawner

    for i, menu in ipairs(spawnertbl) do
        if menu[3] == "List" then
            if self.Settings[menu[1]] == nil then
                self.Settings[menu[1]] = def_train[menu[1]] or menu[5]
            end
            self.Objects[menu[1]] = self:CreateList(menu[1],menu[2],menu[4],menu[7])
            self.ObjectsTypes[menu[1]] = "List"
        elseif menu[3] == "Boolean" then
            if self.Settings[menu[1]] == nil then
                self.Settings[menu[1]] = def_train[menu[1]] or menu[4]
            end
            self.Objects[menu[1]] = self:CreateCheckBox(menu[1],menu[2],menu[6])
            self.ObjectsTypes[menu[1]] = "Boolean"
        elseif menu[3] == "Slider" then
            if self.Settings[menu[1]] == nil then
                self.Settings[menu[1]] = def_train[menu[1]] or menu[7]
            end
            self.Objects[menu[1]] = self:CreateSlider(menu[1],menu[4],menu[5],menu[6],tostring(menu[2]))
            self.ObjectsTypes[menu[1]] = "Slider"
        elseif menu[3] == "Selective" then
            if self.Settings[menu[1]] == nil then
                self.Settings[menu[1]] = def_train[menu[1]] or menu[5]
            end
            self.Objects[menu[1]] = self:CreateSelective(menu[1],menu[2],menu[4],menu[7])
            self.ObjectsTypes[menu[1]] = "Selective"
        elseif type(menu[1]) == "number" then
            incPos(menu[1])
        elseif #menu==0 then
            incPos()
        end
    end
end

function FRAME:CreateSelective(name, text, tbl, func, out_tbl)
    tbl = tbl or {}
    out_tbl = out_tbl or self.Settings
    
    if type(tbl)=="function" then tbl = tbl() or {} end

    local count = table.Count(tbl)

    out_tbl[name] = out_tbl[name] or { true }

    if count<=1 then
        out_tbl[name] = { true }
        return
    end

    local y = self.OffsetY
    local SelectiveLabel = vgui.Create("DLabel", self)
    SelectiveLabel:SetPos(5 + 270*math.floor(self.Pos/self.MaxHorizontal),y+24*(self.Pos%self.MaxHorizontal))
    SelectiveLabel:SetSize(115,28)
    SelectiveLabel:SetText(text)
    SelectiveLabel:SetExpensiveShadow(1,Color(0,0,0,200))

    local SelectiveButton = vgui.Create("DButton", self)
    SelectiveButton:SetTooltip(text)
    SelectiveButton:SetPos(130 + 270*math.floor(self.Pos/self.MaxHorizontal),y+4+24*(self.Pos%self.MaxHorizontal))
    SelectiveButton:SetWide(120)
    SelectiveButton:SetText(Metrostroi.GetPhrase("Spawner.Select"))
    SelectiveButton.DoClick = function(btn)
        local frame = vgui.Create("DFrame")
        frame:SetSize(500, 300)
        frame:Center()
        frame:MakePopup()
        frame:SetTitle(Metrostroi.GetPhrase("Spawner.Select"))

        local selective = vgui.Create("DListView", frame)
        selective:SetMultiSelect(true)
        selective:AddColumn(text)

        local item_count = 0

        if #tbl == count then
            for i=1,#tbl do
                local line = selective:AddLine(tbl[i])
                line:SetSelected(table.HasValue(out_tbl[name], i))
                item_count = item_count + 1
            end
        else
            for k,v in pairs(tbl) do
                if type(v) == "table" and v.name then k = v.name end
                local line = selective:AddLine(v)
                line:SetSelected(table.HasValue(out_tbl[name], k))
                item_count = item_count + 1
            end
        end

        if not selective:GetSelectedLine() then
            selective:SelectFirstItem()
            out_tbl[name][1] = true
        end

        local select = vgui.Create("DButton", frame)
        select:Dock(BOTTOM)
        select:SetText(Metrostroi.GetPhrase("Spawner.Select"))

        selective:Dock(FILL)
    
        select.DoClick = function()
            out_tbl[name] = {}
            for i=1, item_count do
                if selective.Lines[i]:IsLineSelected() then
                    out_tbl[name][#out_tbl[name] + 1] = i
                end
            end
            self.ConsistFrame:TriggerChange(out_tbl[name], name, self)
            frame:Remove()
        end
    end

    self.Pos = self.Pos + 1

    return SelectiveButton
end

function FRAME:CreateList(name, text, tbl, func, out_tbl)
    tbl = tbl or {}
    out_tbl = out_tbl or self.Settings
    
    if type(tbl)=="function" then tbl = tbl() or {} end

    local count = table.Count(tbl)

    if count<=1 then
        out_tbl[name] = next(tbl)
        return
    end

    local y = self.OffsetY
    local ListLabel = vgui.Create("DLabel", self)
    ListLabel:SetPos(5 + 270*math.floor(self.Pos/self.MaxHorizontal),y+24*(self.Pos%self.MaxHorizontal))
    ListLabel:SetSize(115,28)
    ListLabel:SetText(text)
    ListLabel:SetExpensiveShadow(1,Color(0,0,0,200))

    local List = vgui.Create("DComboBox", self)--
    List:SetTooltip(text)
    List:SetPos(130 + 270*math.floor(self.Pos/self.MaxHorizontal),y+4+24*(self.Pos%self.MaxHorizontal))
    List:SetWide(120)

    if #tbl == count then
        for i=1,#tbl do
            List:AddChoice(tbl[i], i, out_tbl[name] == i)
        end
    else
        for k,v in pairs(tbl) do
            if type(v) == "table" and v.name then k = v.name end
            List:AddChoice(v, k, out_tbl[name] == k)
        end
    end

    if not List:GetOptionData(1)  then ListLabel:Remove() List:Remove() return end
    if not List:GetSelectedID() then
        local done
        for i,v in pairs(List.Choices) do
            if v:find("Random") then
                List:ChooseOptionID(i)
                out_tbl[name] = List:GetOptionData(i)
                done = true
                break
            end
        end
        if not done then
            List:ChooseOptionID(1)
            out_tbl[name] = List:GetOptionData(1)
        end
    end

    local frame = self.ConsistFrame

    List.OnSelect = function(this,_, _, index)
        if frame.Block then return end
        out_tbl[name] = index
        if func then func(List, self) end
        frame:TriggerChange(out_tbl[name], name, self)
    end

    self.Pos = self.Pos + 1

    return List
end

function FRAME:CreateSlider(name, decimals, min, max, text, func, out_tbl)
    out_tbl = out_tbl or self.Settings
    local y = self.OffsetY
    local Slider = vgui.Create("DNumSlider", self)
    Slider:SetPos(5 + 270*math.floor(self.Pos/self.MaxHorizontal), y+4+24*(self.Pos%self.MaxHorizontal)-7+4)
    Slider:SetWide(290)
    Slider:SetTall(28)
    Slider:SetMinMax(min, max)
    Slider:SetDecimals(decimals)
    Slider:SetText(text..":")
    Slider:SetValue(out_tbl[name])
    Slider:SetTooltip(text)
    Slider.Label:SetExpensiveShadow(1,Color(0,0,0,200))
    Slider.Label:SetSize(125,28)
    Slider.TextArea:SetTextColor(Slider.Label:GetTextColor())

    local frame = self.ConsistFrame
    local tab = self

    function Slider:Think(...)
        if not self.Editing and self:IsEditing() then
            self.Editing = true
        elseif self.Editing and not self:IsEditing() then
            self.Editing = false
            local val = self:GetValue()
            if frame.Block then return end
            if func then val = func(Slider) or val end
            out_tbl[name] = math.Round(val,decimals)
            Slider:SetValue(out_tbl[name])
            frame:TriggerChange(out_tbl[name], name, tab)
        end
    end

    self.Pos = self.Pos + 1

    return Slider
end

function FRAME:CreateCheckBox(name, text, func, out_tbl)
    out_tbl = out_tbl or self.Settings
    local y = self.OffsetY
    local CBLabel = vgui.Create("DLabel", self)
    CBLabel:SetPos(5  + 270*math.floor(self.Pos/self.MaxHorizontal),y+3+24*(self.Pos%self.MaxHorizontal)-4)
    CBLabel:SetText(text)
    CBLabel:SetWide(125)
    CBLabel:SetTall(28)
    CBLabel:ApplySchemeSettings(true)
    CBLabel:SetExpensiveShadow(1,Color(0,0,0,200))
    local CB = vgui.Create("DCheckBox", self)
    CB:SetTooltip(text)
    CB:SetPos(130 + 270*math.floor(self.Pos/self.MaxHorizontal),y+7+24*(self.Pos%self.MaxHorizontal))
    CB:SetValue(out_tbl[name] or false)

    local frame = self.ConsistFrame

    CB.OnChange = function(cb)
        if frame.Block then return end
        out_tbl[name] = CB:GetChecked()
        if func then func(CB) end
        frame:TriggerChange(out_tbl[name], name, self)
    end

    self.Pos = self.Pos + 1

    return CB
end

function FRAME:CreateEntry(name, text, func, allowinput, out_tbl) end

vgui.Register("MSConsistTab", FRAME)

FRAME = {}

function FRAME:Init()
    self:SetDeleteOnClose(true)
    self:SetSize(824, 560)
end

function FRAME:GetSmallName(str)
    st = string.find(str, "%s*%(")
    if st then
        return string.Trim(utf8.sub(str, 1, st-1))
    else
        return str
    end
end

function FRAME:SaveConsist()
    local con = self.Consist
    for k, v in pairs(con) do
        if string.StartWith(k, "__") then -- delete temp __ fieilds
            con[k] = nil
        end
    end
    for i, wag in pairs(con.Wagons) do
        for k, v in pairs(wag) do
            if string.StartWith(k, "__") then -- delete temp __ fieilds
                con.Wagons[i][k] = nil
            end
            con.Wagons[i].Order = i
        end
    end
    WriteConsist(self.Filename, con)
end

function FRAME:UpdateNames(change, atab)
    if change then
        self.ShowLongName = not self.ShowLongName
    end

    local id
    for k, v in pairs(self.Sheet:GetItems()) do
        local tab = v.Tab
        if tab == (atab or self.Sheet:GetActiveTab()) then id = k break end
    end
    local name = GetTrainName(self.Wagons[id]["__class"], true)
    name = self.ShowLongName and name or self:GetSmallName(name)
    self:SetTitle(self.DefTitle .. " [" .. name .. "]")
end

function FRAME:OnRemove()
    self:SaveConsist()
end

function FRAME:TriggerChange(newval, name, tab)
    if not self.ApplyForAll then return end

    self.Block = true
    for k, v in pairs(self.Sheet:GetItems()) do
        local distTab = v.Panel
        if distTab == tab then continue end
        local typ = distTab.ObjectsTypes[name]
        local obj = distTab.Objects[name]
        
        self.Wagons[k][name] = newval
        
        if not obj or not typ then continue end

        if typ == "Slider" then
            obj:SetValue(newval)
        elseif typ == "List" then
            if type(newval) == "string" then
                for k2, v2 in pairs(obj.Data) do
                    if v2 == newval then obj:ChooseOptionID(k2) end
                end
            else
                obj:ChooseOptionID(newval)
            end
        elseif typ == "Boolean" then
            obj:SetChecked(newval)
        end
    end
    self.Block = false
end

function FRAME:Setup(con, filename)
    if not con then
        con = ReadConsist(filename)
        if #con == 0 then
            return
        end
    end

    local train = con.Train

    local ent = scripted_ents.Get(train)
    if not ent then
        error("ENT is nil\tTrain Class: " .. train)
    end
    if not ent.Spawner then
        error("ENT.Spawner is nil\tTrain Class: " .. train)
    end

    self.Train = ent
    self.TrainClass = train

    self.Consist = con
    self.Consist.Author = self.Consist.Author or LocalPlayer():Nick()
    self.Filename = filename

    self.DefTitle = Metrostroi.GetPhrase("Spawner.Consist.ConsistEditor") .. " (" .. con.Name .. ")"
    self:SetTitle(self.DefTitle)

    self.Head = ent.Spawner.head or train
    self.Interim = ent.Spawner.interim or train

    self.Sheet = vgui.Create("DPropertySheet", self)
    self.Sheet:Dock(FILL)
    self.Sheet.OnActiveTabChanged = function(_, _, tab)
        self:UpdateNames(false, tab)
    end

    local wagons = {}

    for i=1, self.Consist.WagNum do
        local wag = self.Consist.Wagons[i] or {}
        wag["__class"] = wag["__class"] or (i == 1 or i == self.Consist.WagNum) and self.Head or self.Interim
        local order = wag.Order or i
        wagons[order] = wag
        wag.Order = nil
    end

    self.Consist.Wagons = wagons
    self.Wagons = self.Consist.Wagons

    for k, v in pairs(self.Wagons) do
        local tab = vgui.Create("MSConsistTab", self.Sheet)
        local name = GetTrainName(v["__class"], true) or v["__class"]
        tab:Setup(v["__class"], self.Wagons[k], self.Train, self)

        self.Sheet:AddSheet(Format(Metrostroi.GetPhrase("Spawner.ConsistEditor.Wagon"), tonumber(k)), tab).Tab.ID = k
    end

    self.TabCount = #self.Wagons

    self.ShowLongName = true
    self.ApplyForAll = false
    self.Block = false

    self:UpdateNames()

    self.MenuButton = vgui.Create("DButton", self)
    self.MenuButton:SetSize(80, self.MenuButton:GetTall()-4)
    self.MenuButton:SetPos(self:GetWide()-self.MenuButton:GetWide()-100, 3)
    self.MenuButton:SetText(Metrostroi.GetPhrase("Spawner.ConsistEditor.Menu"))

    self.MenuButton.DoClick = function()
        local menu = DermaMenu()

        menu:AddOption(Metrostroi.GetPhrase("Spawner.ConsistEditor.Save"))
        menu:AddOption(Metrostroi.GetPhrase("Spawner.ConsistEditor.SaveAs"))
        menu:AddSpacer()
        menu:AddOption(Metrostroi.GetPhrase("Spawner.ConsistEditor.ShowLongName"), function() self:UpdateNames(true) end):SetIcon(self.ShowLongName and "icon16/tick.png" or "icon16/cross.png")
        menu:AddSpacer()
        menu:AddOption(Metrostroi.GetPhrase("Spawner.ConsistEditor.ApplyForAll"), function() self.ApplyForAll = not self.ApplyForAll end):SetIcon(self.ApplyForAll and "icon16/tick.png" or "icon16/cross.png")
        
        menu:Open()
    end

    
    self.InfoButton = vgui.Create("DButton", self)
    self.InfoButton:SetSize(80, self.InfoButton:GetTall()-4)
    self.InfoButton:SetPos(self:GetWide()-self.InfoButton:GetWide()*2-100, 3)
    self.InfoButton:SetText(Metrostroi.GetPhrase("Spawner.ConsistEditor.Info"))

    self.InfoButton.DoClick = function()
        local frame = vgui.Create("DFrame")
        frame:SetSize(500, 90)
        frame:Center()
        frame:MakePopup()
        frame:SetTitle(Metrostroi.GetPhrase("Spawner.ConsistEditor.Info"))
        
        local fields = {
            Metrostroi.GetPhrase("Spawner.ConsistEditor.HotKeys"),
            Metrostroi.GetPhrase("Spawner.ConsistEditor.HotKeys1"),
            Metrostroi.GetPhrase("Spawner.ConsistEditor.HotKeys2"),
        }

        local info = vgui.Create("DLabel", frame)
        info:SetText(table.concat(fields, "\n"))
        info:SizeToContents()
        info:Dock(TOP)
    end

    self.SpawnButton = vgui.Create("DButton", self)
    self.SpawnButton:SetSize(80, self.SpawnButton:GetTall()-4)
    self.SpawnButton:SetPos(self:GetWide()-self.SpawnButton:GetWide()*3-100, 3)
    self.SpawnButton:SetText(Metrostroi.GetPhrase("Spawner.Consist.Spawn"))

    self.SpawnButton.DoClick = function()
        self:SaveConsist()

		net.Start("train_spawner_open")
            net.WriteBool(true)
            net.WriteTable(self.Consist)
        net.SendToServer()
        local tool = LocalPlayer():GetTool("train_spawner")
        tool.IsConsist = true
        tool.Consist = self.Consist

        self:Close()
    end
end

function FRAME:OnKeyCodePressed( code )
    local num = code-1
    if num >= 0 and num <= 9 then
        local tab = self.Sheet:GetItems()[num]
        if not tab then return end
        self.Sheet:SetActiveTab(tab.Tab)
    end

    local curr = self.Sheet:GetActiveTab().ID
    if code == KEY_LEFT then
        if curr ~= 1 then
            curr = curr - 1
            local tab = self.Sheet:GetItems()[curr].Tab
            self.Sheet:SetActiveTab(tab)
        end
    end
    if code == KEY_RIGHT then
        if curr ~= self.TabCount then
            curr = curr + 1
            local tab = self.Sheet:GetItems()[curr].Tab
            self.Sheet:SetActiveTab(tab)
        end
    end
    if code == KEY_F and input.IsShiftDown() then
        self.ApplyForAll = not self.ApplyForAll
    end
    if code == KEY_G and input.IsShiftDown() then
        self:UpdateNames(true)
    end
end

vgui.Register("MSConsistFrame", FRAME, "DFrame")

FRAME = {}

local function ExtendedFrame()
    local frame = vgui.Create("DFrame")
    frame:SetSize(280, 200)
    frame:Center()
    frame:SetTitle(Metrostroi.GetPhrase("Spawner.Consist.ConsistEditor"))
    frame:MakePopup()

    local sel_con = vgui.Create("DComboBox", frame)
    sel_con:SetPos(5, 30)
    sel_con:SetSize(270, 20)
    sel_con:SetValue(Metrostroi.GetPhrase("Spawner.Select"))

    local info = vgui.Create("DLabel", frame)
    info:SetPos(5, 60)
    info:SetText(Metrostroi.GetPhrase("Spawner.Consist.InformationSelect"))
    info:SetExpensiveShadow(1,Color(0,0,0,200))
    info:SizeToContents()
    local col = info:GetColor()

    local fr_w = frame:GetWide()
    local fr_h = frame:GetTall()

    local spawn = vgui.Create("DButton", frame)
    local sp_h = spawn:GetTall()
    spawn:SetWide(fr_w - 10)
    spawn:SetPos(5, fr_h - sp_h*2 - 5)
    spawn:SetText(Metrostroi.GetPhrase("Spawner.Consist.Spawn"))
    spawn:SetEnabled(false)

    local edit = vgui.Create("DButton", frame)
    local ed_h = edit:GetTall()
    edit:SetWide((fr_w - 10) / 3)
    local ed_w = edit:GetWide()
    edit:SetPos(5, fr_h - ed_h - 5)
    edit:SetText(Metrostroi.GetPhrase("Spawner.Consist.Edit"))
    edit:SetEnabled(false)

    local new = vgui.Create("DButton", frame)
    new:SetWide((fr_w - 10) / 3)
    local nw_w = new:GetWide()
    new:SetPos((nw_w )*1 + 5, fr_h - ed_h - 5)
    new:SetText(Metrostroi.GetPhrase("Spawner.Consist.New"))

    
    local delete = vgui.Create("DButton", frame)
    delete:SetWide((fr_w - 10) / 3)
    local dl_w = delete:GetWide()
    delete:SetPos((dl_w)*2 + 5, fr_h - ed_h - 5)
    delete:SetText(Metrostroi.GetPhrase("Spawner.Consist.Delete"))
    delete:SetEnabled(false)

    local cons = GetConsistsList()

    for k, v in pairs(cons) do
        sel_con:AddChoice(v, k)
    end

    sel_con.OnSelect = function(self, i, t ,d)
        local con = ReadConsist(t)
        info:SetColor(col)
        if not con.Train then
            info:SetText(Metrostroi.GetPhrase("Spawner.Consist.Invalid"))
            info:SizeToContents()
            info:SetColor(Color(255, 0, 0))
            spawn:SetEnabled(false)
            edit:SetEnabled(false)
            delete:SetEnabled(false)
            return 
        end
        local name, ENT = GetTrainName(con.Train)
        if not ENT then
            info:SetText(Metrostroi.GetPhrase("Spawner.Consist.Invalid"))
            info:SizeToContents()
            info:SetColor(Color(255, 0, 0))
            spawn:SetEnabled(false)
            edit:SetEnabled(false)
            delete:SetEnabled(false)
            return
        end
        local txt = ""
        txt = txt .. "\n" .. Format(Metrostroi.GetPhrase("Spawner.Consist.Name"), con.Name or "GenericName")
        txt = txt .. "\n" .. Format(Metrostroi.GetPhrase("Spawner.Consist.Type"), name or "GenericTrain")
        txt = txt .. "\n" .. Format(Metrostroi.GetPhrase("Spawner.Consist.WagNum"), con.WagNum or 0)
        txt = txt .. "\n" .. Format(Metrostroi.GetPhrase("Spawner.Consist.Author"), con.Author or "N/A")
        
        info:SetText(Metrostroi.GetPhrase("Spawner.Consist.Information") .. txt)
        info:SizeToContents()
        spawn:SetEnabled(true)
        edit:SetEnabled(true)
        delete:SetEnabled(true)
    end

    edit.DoClick = function(self)
        local name = sel_con:GetOptionData(sel_con:GetSelectedID())

        local consisteditor = vgui.Create("MSConsistFrame")
        consisteditor:Center()
        consisteditor:MakePopup()
        consisteditor:Setup(ReadConsist(cons[name]), cons[name])

        frame:Remove()
    end

    new.DoClick = function(self)
        local MaxWagons = GetGlobalInt("metrostroi_maxtrains")*GetGlobalInt("metrostroi_maxwagons")
        local MaxWagonsOnPlayer = GetGlobalInt("metrostroi_maxtrains_onplayer")*GetGlobalInt("metrostroi_maxwagons")

        local frame_new = vgui.Create("DFrame")
        frame_new:SetSize(265, 150)
        frame_new:Center()
        frame_new:SetTitle(Metrostroi.GetPhrase("Spawner.Consist.New"))
        frame_new:MakePopup()

        local Settings = ReadSettings()
        local Train = Settings.Train or ""
        local WagNum = Settings.WagNum or 2

        WagNum = math.Clamp(WagNum, 1, GetGlobalInt("metrostroi_maxwagons"))
        
        --EXTREME GOVNOCODE START
        do
            local ListText = Format("%s(%d/%d)\n%s:%d",Metrostroi.GetPhrase("Spawner.Trains1"),GetGlobalInt("metrostroi_train_count"),MaxWagons,Metrostroi.GetPhrase("Spawner.Trains2"),MaxWagonsOnPlayer)
            local Trains = {}
            
            for _,class in pairs(Metrostroi.TrainClasses) do
                local name, ENT = GetTrainName(class)
                if not ENT then continue end

                Trains[ENT.ClassName] = name
            end

            local ListLabel = vgui.Create("DLabel", frame_new)
            ListLabel:SetPos(5 + 270*math.floor(0/14),24+24*(0%14))
            ListLabel:SetSize(115,28)
            ListLabel:SetText(ListText)
            ListLabel:SetExpensiveShadow(1,Color(0,0,0,200))

            local List = vgui.Create("DComboBox", frame_new)
            List:SetTooltip(ListText)
            List:SetPos(130 + 270*math.floor(0/14),28+24*(0%14))
            List:SetWide(120)

            for k,v in pairs(Trains) do
                List:AddChoice(v, k, k == Train)
            end

            if not List:GetSelectedID() then
                List:ChooseOptionID(1)
                Train = List:GetOptionData(1)
            end

            List.OnSelect = function(self,_, _, index)
                Train = index
                if func then func(List) end
            end
            
            local WagNumText = Metrostroi.GetPhrase("Spawner.WagNum")
            local Slider = vgui.Create("DNumSlider", frame_new)
            Slider:SetPos(5 + 270*math.floor(1/14), 28+24*(1%14)-7+4)
            Slider:SetWide(290)
            Slider:SetTall(28)
            Slider:SetMinMax(1, GetGlobalInt("metrostroi_maxwagons"))
            Slider:SetDecimals(0)
            Slider:SetText(WagNumText..":")
            Slider:SetValue(WagNum)
            Slider:SetTooltip(WagNumText)
            Slider.Label:SetExpensiveShadow(1,Color(0,0,0,200))
            Slider.Label:SetSize(125,28)
            Slider.TextArea:SetTextColor(Slider.Label:GetTextColor())

            function Slider:Think(...)
                if not self.Editing and self:IsEditing() then
                    self.Editing = true
                elseif self.Editing and not self:IsEditing() then
                    self.Editing = false
                    local val = self:GetValue()
                    local WagNumTable
                    for k,name in pairs(Metrostroi.TrainClasses) do
                        local ENT = scripted_ents.Get(name)
                        if not ENT.Spawner or ENT.ClassName ~= Train  then continue end
                        WagNumTable = ENT.Spawner.WagNumTable
                        break
                    end
                    if WagNumTable then
                        local retval = WagNumTable[1]
                        for i=2,#WagNumTable do
                            if WagNumTable[i] <= math.Round(Slider:GetValue(),0) then
                                retval = WagNumTable[i]
                            end
                        end
                        val = retval
                    end
                    WagNum = math.Round(val,decimals)
                    Slider:SetValue(WagNum)
                end
            end
        end
        --EXTREME GOVNOCODE END
        
        local name_label = vgui.Create("DLabel", frame_new)
        name_label:SetPos(5 + 270*math.floor(2/14),24+24*(2%14))
        name_label:SetSize(115,28)
        name_label:SetText(Metrostroi.GetPhrase("Spawner.Consist.CreateName"))
        name_label:SetExpensiveShadow(1,Color(0,0,0,200))

        local name_entry = vgui.Create("DTextEntry", frame_new)
        name_entry:SetPos(130 + 270*math.floor(2/14),28+24*(2%14))
        name_entry:SetWide(120)

        local create = vgui.Create("DButton", frame_new)
        create:SetWide(frame_new:GetWide() - 10)
        create:SetPos(5, frame_new:GetTall() - create:GetTall() - 5)
        create:SetText(Metrostroi.GetPhrase("Spawner.Consist.Create"))

        create.DoClick = function()
            local name = string.Trim(name_entry:GetValue())
            if name == "" then
                local err_label = vgui.Create("DLabel", frame_new)
                err_label:SetPos(5 + 270*math.floor(3/14),28+24*(3%14))
                err_label:SetText(Metrostroi.GetPhrase("Spawner.Consist.ErrorName"))
                err_label:SetWide(frame_new:GetWide() - 5)
                err_label:SetContentAlignment(5)
                err_label:SetColor(Color(255, 0, 0))
                err_label:SetExpensiveShadow(1,Color(0,0,0,200))

                timer.Simple(4, function()
                    err_label:Remove()
                end)

                return
            end
            
            local Filename = GetPath(name)

            local function createAndOpen()
                local Consist = {
                    Name = name,
                    WagNum = WagNum,
                    Train = Train,
                    Author = LocalPlayer():Nick(),
                    Wagons = {},
                }

                local consisteditor = vgui.Create("MSConsistFrame")
                consisteditor:Center()
                consisteditor:MakePopup()
                consisteditor:Setup(Consist, Filename)

                frame_new:Remove()
            end

            local Exists = ExistsConsist(Filename)
            if Exists then
                local exists_frame = vgui.Create("DFrame") -- Пирамида смайла
                exists_frame:SetSize(260, 80)
                exists_frame:Center()
                exists_frame:SetTitle(Metrostroi.GetPhrase("Spawner.Consist.Error"))
                exists_frame:MakePopup()

                exists_frame.OnRemove = function(self)
                    create:SetEnabled(true)
                end

                local exists_label = vgui.Create("DLabel", exists_frame)
                exists_label:Dock(FILL)
                exists_label:DockMargin(4, 2, 4, 4)
                exists_label:SetText(Metrostroi.GetPhrase("Spawner.Consist.ErrorNameExists"))
                exists_label:SetContentAlignment(8)

                local cancel = vgui.Create("DButton", exists_frame)
                cancel:SetWide(exists_frame:GetWide()/2-5)
                cancel:SetPos(5, exists_frame:GetTall() - cancel:GetTall() - 5)
                cancel:SetText(Metrostroi.GetPhrase("Spawner.Consist.Cancel"))
                cancel.DoClick = function()
                    exists_frame:Remove()
                    create:SetEnabled(true)
                end

                local overwrite = vgui.Create("DButton", exists_frame)
                overwrite:SetWide(exists_frame:GetWide()/2-5)
                overwrite:SetPos(5 + overwrite:GetWide(), exists_frame:GetTall() - overwrite:GetTall() - 5)
                overwrite:SetText(Metrostroi.GetPhrase("Spawner.Consist.Overwrite"))
                overwrite.DoClick = function()
                    exists_frame:Remove()
                    createAndOpen()
                end

                create:SetEnabled(false)

                return
            end

            createAndOpen()
        end

        frame:Remove()
    end

    delete.DoClick = function(self)
        local name = sel_con:GetOptionData(sel_con:GetSelectedID())
        DeleteConsist(cons[name])
        frame:Remove()

        ExtendedFrame()
    end

    spawn.DoClick = function(self)
        local name = sel_con:GetOptionData(sel_con:GetSelectedID())
        local con = ReadConsist(cons[name])
		net.Start("train_spawner_open")
            net.WriteBool(true)
            net.WriteTable(con)
        net.SendToServer()
        local tool = LocalPlayer():GetTool("train_spawner")
        tool.IsConsist = true
        tool.Consist = con
        frame:Close()
    end
end

function FRAME:Init()
    self:SetDeleteOnClose(true)
    self:SetTitle(Metrostroi.GetPhrase("Spawner.Title"))
    self:LoadSettings()
    self.Pos = 0
    self.MaxHorizontal = 14
    self.Resizeable = {}
    self:SetSize(800, 600)
    self:Center()

    self.Spawn = vgui.Create("DButton", self)
    self.Spawn:SetWide(80)
    self.Spawn:SetText(Metrostroi.GetPhrase("Spawner.Spawn"))

    self.Spawn.DoClick = function()
        local tbl = {}
        tbl = table.Copy(self.Settings[self.Settings.Train])
        tbl.Train = self.Settings.Train
        tbl.AutoCouple = true
        tbl.WagNum = self.Settings.WagNum
		net.Start("train_spawner_open")
            net.WriteBool(false)
            net.WriteTable(tbl)
        net.SendToServer()
        local tool = LocalPlayer():GetTool("train_spawner")
        tool.Settings = tbl
        tool.IsConsist = false
        local ENT = scripted_ents.Get(tool.Settings.Train)
        if ENT and ENT.Spawner then tool.Train = ENT end
        self:Close()
    end

    self.Extended = vgui.Create("DButton", self)
    self.Extended:SetWide(120)
    self.Extended:SetText(Metrostroi.GetPhrase("Spawner.Consist.ConsistEditor"))

    self.Extended.DoClick = function()
        ExtendedFrame()

        self:Close()
    end

    table.insert(self.Resizeable, 
    function(self)
        if not IsValid(self.Spawn) then return end
        self.Spawn:SetPos(self:GetWide() - self.Spawn:GetWide() - 5, self:GetTall() - self.Spawn:GetTall() - 5)
    end)

    table.insert(self.Resizeable, 
    function(self)
        if not IsValid(self.Extended) then return end
        self.Extended:SetPos( 5, self:GetTall() - self.Spawn:GetTall() - 5)
    end)

    self:ApplyResize()

    self.Objects = {}
    self.ObjectsNamed = {}
    self:Load()
end

function FRAME:ApplyResize()
    for k, v in pairs(self.Resizeable) do
        v(self)
    end
end

function FRAME:Load()
    local MaxWagons = GetGlobalInt("metrostroi_maxtrains")*GetGlobalInt("metrostroi_maxwagons")
    local MaxWagonsOnPlayer = GetGlobalInt("metrostroi_maxtrains_onplayer")*GetGlobalInt("metrostroi_maxwagons")

    local Trains = {}
    for _,class in pairs(Metrostroi.TrainClasses) do
        local name, ENT = GetTrainName(class)
        if not ENT then continue end

        Trains[ENT.ClassName] = name
    end

    self:CreateList("Train",Format("%s(%d/%d)\n%s:%d",Metrostroi.GetPhrase("Spawner.Trains1"),GetGlobalInt("metrostroi_train_count"),MaxWagons,Metrostroi.GetPhrase("Spawner.Trains2"),MaxWagonsOnPlayer),Trains,function() self:UpdateFrame() end,self.Settings)
    self:CreateSlider("WagNum",0,1, GetGlobalInt("metrostroi_maxwagons"),Metrostroi.GetPhrase("Spawner.WagNum"),function(slider)
        local WagNumTable
        for k,name in pairs(Metrostroi.TrainClasses) do
            local ENT = scripted_ents.Get(name)
            if not ENT.Spawner or ENT.ClassName ~= self.Settings.Train  then continue end
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
    end,self.Settings)

    self:UpdateFrame()
end

function FRAME:UpdateFrame()
    self.Pos = 2

    for k, v in pairs(self.Objects) do
        if k < 4 then continue end
        self.Objects[k]:Remove()
        self.Objects[k] = nil
    end

    for k, v in pairs(self.ObjectsNamed) do
        if k == "Train" or k == "WagNum" then continue end
        self.ObjectsNamed[k] = nil
    end

    if not self.ObjectsNamed["Train"]:GetSelectedID() then
        self.ObjectsNamed["Train"]:ChooseOptionID(1)
        self.Settings.Train = self.ObjectsNamed["Train"]:GetOptionData(1)
    end

    local function incPos(a) self.Pos=self.Pos+(a or 1) end

    if not self.Settings[self.Settings.Train] then self.Settings[self.Settings.Train] = {} end

    for k,name in pairs(Metrostroi.TrainClasses) do
        local ENT = scripted_ents.Get(name)
        if not ENT.Spawner or ENT.ClassName ~= self.Settings.Train  then continue end
        for i, menu in ipairs(ENT.Spawner) do
            if menu[3] == "List" then
                if self.Settings[self.Settings.Train][menu[1]] == nil then
                    self.Settings[self.Settings.Train][menu[1]] = menu[5]
                end
                self:CreateList(menu[1],menu[2],menu[4],menu[7])
            elseif menu[3] == "Boolean" then
                if self.Settings[self.Settings.Train][menu[1]] == nil then
                    self.Settings[self.Settings.Train][menu[1]] = menu[4]
                end
                self:CreateCheckBox(menu[1],menu[2],menu[6])
            elseif menu[3] == "Slider" then
                if self.Settings[self.Settings.Train][menu[1]] == nil then
                    self.Settings[self.Settings.Train][menu[1]] = menu[7]
                end
                self:CreateSlider(menu[1],menu[4],menu[5],menu[6],tostring(menu[2]))
            elseif menu[3] == "Selective" then
                if self.Settings[self.Settings.Train][menu[1]] == nil then
                    self.Settings[self.Settings.Train][menu[1]] = menu[5]
                end
                self:CreateSelective(menu[1],menu[2],menu[4],menu[7])
            elseif type(menu[1]) == "number" then
                incPos(menu[1])
            elseif #menu==0 then
                incPos()
            end
        end
    end

    self:SetSize(262 + 262*math.floor((self.Pos-1)/self.MaxHorizontal)+10, 58+24*math.min(self.MaxHorizontal,self.Pos))
    self:ApplyResize()
    self:Center()
end

function FRAME:CreateSelective(name, text, tbl, func, out_tbl)
    tbl = tbl or {}
    out_tbl = out_tbl or self.Settings[self.Settings.Train]
    
    if type(tbl)=="function" then tbl = tbl() or {} end

    local count = table.Count(tbl)

    out_tbl[name] = out_tbl[name] or { true }

    --[[
        structure in self.Settings
        name = Selective
        
        then

                                    numbers mean selected cells
        self.Settings[train]["Selective"] = {1, 2, 3, 5, 7} -- ✓

        or

        self.Settings[train]["Selective"] = {
            [1] = 1, -- selected
            [2] = 1, -- selected
            [3] = 1, -- selected
            [4] = 0, -- not selected
            [5] = 1, -- selected
            [6] = 0, -- not selected
            [7] = 1, -- selected
        }
    ]]

    if count<=1 then
        out_tbl[name] = { true }
        return
    end

    local SelectiveLabel = vgui.Create("DLabel", self)
    SelectiveLabel:SetPos(5 + 270*math.floor(self.Pos/self.MaxHorizontal),24+24*(self.Pos%self.MaxHorizontal))
    SelectiveLabel:SetSize(115,28)
    SelectiveLabel:SetText(text)
    SelectiveLabel:SetExpensiveShadow(1,Color(0,0,0,200))

    local SelectiveButton = vgui.Create("DButton", self)
    SelectiveButton:SetTooltip(text)
    SelectiveButton:SetPos(130 + 270*math.floor(self.Pos/self.MaxHorizontal),28+24*(self.Pos%self.MaxHorizontal))
    SelectiveButton:SetWide(120)
    SelectiveButton:SetText(Metrostroi.GetPhrase("Spawner.Select"))
    SelectiveButton.DoClick = function(btn)
        local frame = vgui.Create("DFrame")
        frame:SetSize(500, 300)
        frame:Center()
        frame:MakePopup()
        frame:SetTitle(Metrostroi.GetPhrase("Spawner.Select"))

        local selective = vgui.Create("DListView", frame)
        selective:SetMultiSelect(true)
        selective:AddColumn(text)

        local item_count = 0

        if #tbl == count then
            for i=1,#tbl do
                local line = selective:AddLine(tbl[i])
                line:SetSelected(table.HasValue(out_tbl[name], i))
                item_count = item_count + 1
            end
        else
            for k,v in pairs(tbl) do
                if type(v) == "table" and v.name then k = v.name end
                local line = selective:AddLine(v)
                line:SetSelected(table.HasValue(out_tbl[name], k))
                item_count = item_count + 1
            end
        end

        if not selective:GetSelectedLine() then
            selective:SelectFirstItem()
            out_tbl[name][1] = true
        end

        local select = vgui.Create("DButton", frame)
        select:Dock(BOTTOM)
        select:SetText(Metrostroi.GetPhrase("Spawner.Select"))

        selective:Dock(FILL)
    
        select.DoClick = function()
            out_tbl[name] = {}
            for i=1, item_count do
                if selective.Lines[i]:IsLineSelected() then
                    out_tbl[name][#out_tbl[name] + 1] = i
                end
            end
            frame:Remove()
        end
    end

    table.insert(self.Objects, SelectiveLabel)
    table.insert(self.Objects, SelectiveButton)
    self.ObjectsNamed[name] = SelectiveButton
    self.Pos = self.Pos + 1
end

function FRAME:CreateList(name, text, tbl, func, out_tbl)
    tbl = tbl or {}
    out_tbl = out_tbl or self.Settings[self.Settings.Train]
    
    if type(tbl)=="function" then tbl = tbl() or {} end

    local count = table.Count(tbl)

    if count<=1 then
        out_tbl[name] = next(tbl)
        return
    end

    local ListLabel = vgui.Create("DLabel", self)
    ListLabel:SetPos(5 + 270*math.floor(self.Pos/self.MaxHorizontal),24+24*(self.Pos%self.MaxHorizontal))
    ListLabel:SetSize(115,28)
    ListLabel:SetText(text)
    ListLabel:SetExpensiveShadow(1,Color(0,0,0,200))

    local List = vgui.Create("DComboBox", self)--
    List:SetTooltip(text)
    List:SetPos(130 + 270*math.floor(self.Pos/self.MaxHorizontal),28+24*(self.Pos%self.MaxHorizontal))
    List:SetWide(120)

    if #tbl == count then
        for i=1,#tbl do
            List:AddChoice(tbl[i], i, out_tbl[name] == i)
        end
    else
        for k,v in pairs(tbl) do
            if type(v) == "table" and v.name then k = v.name end
            List:AddChoice(v, k, out_tbl[name] == k)
        end
    end

    if not List:GetOptionData(1)  then ListLabel:Remove() List:Remove() return end
    if not List:GetSelectedID() then
        local done
        for i,v in pairs(List.Choices) do
            if v:find("Random") then
                List:ChooseOptionID(i)
                out_tbl[name] = List:GetOptionData(i)
                done = true
                break
            end
        end
        if not done then
            List:ChooseOptionID(1)
            out_tbl[name] = List:GetOptionData(1)
        end
    end

    List.OnSelect = function(_, _, _, index)
        out_tbl[name] = index
        if func then func(List, self) end
    end

    table.insert(self.Objects, ListLabel)
    table.insert(self.Objects, List)
    self.ObjectsNamed[name] = List
    self.Pos = self.Pos + 1
end

function FRAME:CreateSlider(name, decimals, min, max, text, func, out_tbl)
    out_tbl = out_tbl or self.Settings[self.Settings.Train]
    local Slider = vgui.Create("DNumSlider", self)
    Slider:SetPos(5 + 270*math.floor(self.Pos/self.MaxHorizontal), 28+24*(self.Pos%self.MaxHorizontal)-7+4)
    Slider:SetWide(290)
    Slider:SetTall(28)
    Slider:SetMinMax(min, max)
    Slider:SetDecimals(decimals)
    Slider:SetText(text..":")
    Slider:SetValue(out_tbl[name])
    Slider:SetTooltip(text)
    Slider.Label:SetExpensiveShadow(1,Color(0,0,0,200))
    Slider.Label:SetSize(125,28)
    Slider.TextArea:SetTextColor(Slider.Label:GetTextColor())

    function Slider:Think(...)
        if not self.Editing and self:IsEditing() then
            self.Editing = true
        elseif self.Editing and not self:IsEditing() then
            self.Editing = false
            local val = self:GetValue()
            if func then val = func(Slider) or val end
            out_tbl[name] = math.Round(val,decimals)
            Slider:SetValue(out_tbl[name])
        end
    end

    table.insert(self.Objects,Slider)
    self.ObjectsNamed[name] = Slider
    self.Pos = self.Pos + 1
end

function FRAME:CreateCheckBox(name, text, func, out_tbl)
    out_tbl = out_tbl or self.Settings[self.Settings.Train]
    local CBLabel = vgui.Create("DLabel", self)
    CBLabel:SetPos(5  + 270*math.floor(self.Pos/self.MaxHorizontal),27+24*(self.Pos%self.MaxHorizontal)-4)
    CBLabel:SetText(text)
    CBLabel:SetWide(125)
    CBLabel:SetTall(28)
    CBLabel:ApplySchemeSettings(true)
    CBLabel:SetExpensiveShadow(1,Color(0,0,0,200))
    local CB = vgui.Create("DCheckBox", self)
    CB:SetTooltip(text)
    CB:SetPos(130 + 270*math.floor(self.Pos/self.MaxHorizontal),31+24*(self.Pos%self.MaxHorizontal))
    CB:SetValue(out_tbl[name])
    CB.OnChange = function(self)
        out_tbl[name] = CB:GetChecked()
        if func then func(CB) end
    end

    table.insert(self.Objects, CBLabel)
    table.insert(self.Objects, CB)
    self.ObjectsNamed[name] = CB
    self.Pos = self.Pos + 1
end

local SetSettings = false

function FRAME:LoadSettings()
    local Settings = {
        Train = 1,
        WagNum = 3,
        AutoCouple = true,
    }

    self.Settings = ReadSettings() or Settings

    if SetSettings ~= false then 
        table.Merge(self.Settings, table.Copy(SetSettings))
        SetSettings = false
    end
end

function FRAME:SaveSettings()
    WriteSettings(self.Settings)
end

function FRAME:OnRemove()
    self:SaveSettings()
end

vgui.Register("MSSpawnerFrame", FRAME, "DFrame")

net.Receive("train_spawner_open",function()
    local consist = net.ReadBool()
    local tool = LocalPlayer():GetTool("train_spawner")
    if not consist then
        local tbl = net.ReadTable()
        local Settings = {}
        Settings[tbl.Train] = tbl
        Settings.Train = tbl.Train
        tool.IsConsist = false
        tool.Settings = tbl
        SetSettings = Settings
    else
        local tbl = net.ReadTable()
        if not tbl.Name or not tbl.Train then return end
        local Consist = {}
        Consist = tbl
        tool.IsConsist = true
        tool.Consist = tbl
        
        local filename = GetPath(tbl.Name)

        local consisteditor = vgui.Create("MSConsistFrame")
        consisteditor:Center()
        consisteditor:MakePopup()
        consisteditor:Setup(Consist, filename)
    end
end)
net.Receive("MetrostroiTrainSpawner", function()
    local frame = vgui.Create("MSSpawnerFrame")
    frame:MakePopup()
end)

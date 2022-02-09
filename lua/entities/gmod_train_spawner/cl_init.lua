include("shared.lua")

if not file.Exists("metrostroi_train_spawner.txt","DATA") then
    file.Write("metrostroi_train_spawner.txt","")
end

FRAME = {}

function FRAME:Init()
    self:SetDeleteOnClose(true)
    self:SetTitle(Metrostroi.GetPhrase("Spawner.Title"))
    self:LoadSettings()
    self.Pos = 0
    self.MaxHorizontal = 14
    self.Resizeable = {}
    self:SetSize(800, 600)

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
            net.WriteTable(tbl)
        net.SendToServer()
        local tool = LocalPlayer():GetTool("train_spawner")
        tool.Settings = tbl
        local ENT = scripted_ents.Get(tool.Settings.Train)
        if ENT and ENT.Spawner then tool.Train = ENT end
        self:Close()
    end

    table.insert(self.Resizeable, 
    function(self)
        if not IsValid(self.Spawn) then return end
        self.Spawn:SetPos(self:GetWide() - self.Spawn:GetWide() - 5, self:GetTall() - self.Spawn:GetTall() - 5)
    end)

    self:ApplyResize()

    self.Objects = {}
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
    for _,name in pairs(Metrostroi.TrainClasses) do
        local ENT = scripted_ents.Get(name)
        if not ENT.Spawner or not ENT.SubwayTrain then continue end
        local ENT_list = list.Get("SpawnableEntities")[name]

        Trains[ENT.ClassName] = ENT_list and ENT_list.PrintName or ENT.Spawner and ENT.Spawner.Name or ENT.SubwayTrain.Name.."("..ENT.SubwayTrain.Manufacturer..")"
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

    if not self.Objects[2]:GetSelectedID() then
        self.Objects[2]:ChooseOptionID(1)
        self.Settings.Train = self.Objects[2]:GetOptionData(1)
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

    out_tbl[name] = out_tbl[name] or {}

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

    List.OnSelect = function(self,_, _, index)
        out_tbl[name] = index
        if func then func(List) end
    end

    table.insert(self.Objects, ListLabel)
    table.insert(self.Objects, List)
    self.Pos = self.Pos + 1
end

function FRAME:CreateSlider(name, decimals, min, max, text, func, out_tbl)
    out_tbl = out_tbl or Settings[Settings.Train]
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
    self.Pos = self.Pos + 1
end

local SetSettings = false

function FRAME:LoadSettings()
    local Settings = {
        Train = 1,
        WagNum = 3,
        AutoCouple = true,
    }

    self.Settings = util.JSONToTable(file.Read("metrostroi_train_spawner.txt","DATA")) or Settings

    if SetSettings ~= false then 
        table.Merge(self.Settings, table.Copy(SetSettings))
        SetSettings = false
    end
end

function FRAME:SaveSettings()
    file.Write("metrostroi_train_spawner.txt", util.TableToJSON(self.Settings, true))
end

function FRAME:OnRemove()
    self:SaveSettings()
end

vgui.Register("MSSpawnerFrame", FRAME, "DFrame")

net.Receive("train_spawner_open",function()
    local tbl = net.ReadTable()
    local tool = LocalPlayer():GetTool("train_spawner")
    local Settings = {}
    Settings[tbl.Train] = tbl
    Settings.Train = tbl.Train
    tool.Settings = tbl
    SetSettings = Settings
    --UpdateConCMD()
end)
net.Receive("MetrostroiTrainSpawner", function()
    local frame = vgui.Create("MSSpawnerFrame")
    frame:MakePopup()
end)

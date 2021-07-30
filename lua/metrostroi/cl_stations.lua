local function OpenGUI()
    -- Main frame
    local Frame = vgui.Create("DFrame")
    Frame:SetSize(600,300)
    Frame:Center()
    Frame:SetTitle(Metrostroi.GetPhrase("StationList.Title"))
    Frame:MakePopup()
    Frame.OnClose = Frame.Remove
    
    -- Check stations table
    if not Metrostroi.StationConfigurations then
        local ErrorLabel = vgui.Create("DLabel",Frame)
        ErrorLabel:Dock(FILL)
        ErrorLabel:SetTextColor(Color(255,50,50))
        ErrorLabel:DockMargin(7,0,0,7)
        ErrorLabel:SetFont("CloseCaption_Bold")
        ErrorLabel:SetText(Metrostroi.GetPhrase("StationList.NoConfig"))
        return
    end
    
    -- Create list
    local StList = vgui.Create("DListView",Frame)
    StList:Dock(FILL)
    StList:SetMultiSelect(false)
    StList:AddColumn("ID"):SetWidth(10)
    StList:AddColumn(Metrostroi.GetPhrase("StationList.Name")):SetWidth(405)
    StList:AddColumn(Metrostroi.GetPhrase("StationList.NamePos")):SetWidth(5)
    
    local SelectedID,SelectedPosID = 1,1
    -- Adding stations
    for k,v in pairs(Metrostroi.StationConfigurations) do
        local tblPos = v.positions
        if not tblPos then continue end
        
        local stLine = StList:AddLine(k,table.concat(v.names,", "))
        stLine.StID = k
        
        if table.Count(tblPos) == 1 then continue end
        local PosSelector = vgui.Create("DComboBox",stLine)
        PosSelector:Dock(RIGHT)
        for idPos,tbl in pairs(tblPos) do
            PosSelector:AddChoice(idPos)
        end
        PosSelector:ChooseOptionID(1)
        function PosSelector:OnSelect(index,val)
            StList:ClearSelection()
            StList:SelectItem(stLine)
            SelectedID = k
            SelectedPosID = val
        end
    end
    StList:SortByColumn(1)
    
    -- Create teleport button
    local TpBtn = vgui.Create("DButton",Frame)
    TpBtn:Dock(BOTTOM)
    TpBtn:SetText(Metrostroi.GetPhrase("StationList.Select"))
    TpBtn:SetEnabled(false)
    function StList:OnRowSelected(rowIndex,row)
        TpBtn:SetEnabled(true)
        TpBtn:SetText(Metrostroi.GetPhrase("StationList.Teleport"))
        SelectedID = row.StID
    end
    function TpBtn:DoClick()
        RunConsoleCommand("ulx","station",tostring(SelectedID)..":"..tostring(SelectedPosID))
    end
end
concommand.Add("metrostroi_stations",OpenGUI,nil,"GUI for station list")
net.Receive("metrostroi_stations_gui",OpenGUI)
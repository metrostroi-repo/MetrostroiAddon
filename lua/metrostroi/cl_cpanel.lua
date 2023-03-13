-- Build admin panel
local function AdminPanel(panel)
    if not LocalPlayer():IsAdmin() then return end
    panel:CheckBox(Metrostroi.GetPhrase("Panel.RequireThirdRail"),"metrostroi_train_requirethirdrail")
end
-- Build regular client panel
local function ClientPanel(panel)
    panel:ClearControls()
    panel:SetPadding(0)
    panel:SetSpacing(0)
    panel:Dock( FILL )
    local Lang = vgui.Create("DComboBox")
        Lang:SetValue(Metrostroi.CurrentLanguageTable and Metrostroi.CurrentLanguageTable.lang or Metrostroi.GetPhrase("Panel.Language"))
        Lang:SetColor(color_black)
        for k,v in pairs(Metrostroi.Languages) do
            Lang:AddChoice(v.lang, k)
        end
        Lang.OnSelect = function(Lang,index,value,data)
            Metrostroi.ChoosedLang = data
            RunConsoleCommand("metrostroi_language",Metrostroi.ChoosedLang)
        end
    panel:AddItem(Lang)
    panel:ControlHelp(Metrostroi.GetPhrase("AuthorText"))
    if Metrostroi.HasPhrase("AuthorTextMetadmin") then
        panel:ControlHelp(Metrostroi.GetPhrase("AuthorTextMetadmin"))
    end
    
    panel:CheckBox(Metrostroi.GetPhrase("Panel.DrawCams"),"metrostroi_drawcams")
    panel:CheckBox(Metrostroi.GetPhrase("Panel.DisableHUD"),"metrostroi_disablehud")
    panel:CheckBox(Metrostroi.GetPhrase("Panel.DisableCamAccel"),"metrostroi_disablecamaccel")
    panel:CheckBox(Metrostroi.GetPhrase("Panel.DisableHoverText"),"metrostroi_disablehovertext")
    panel:CheckBox(Metrostroi.GetPhrase("Panel.DisableHoverTextP"),"metrostroi_disablehovertextpos")
    panel:CheckBox(Metrostroi.GetPhrase("Panel.DisableSeatShadows"), "metrostroi_disableseatshadows")
    panel:CheckBox(Metrostroi.GetPhrase("Panel.ScreenshotMode"),"metrostroi_screenshotmode")
    panel:CheckBox(Metrostroi.GetPhrase("Panel.ShadowsHeadlight"),"metrostroi_shadows1")
    panel:CheckBox(Metrostroi.GetPhrase("Panel.RedLights"),"metrostroi_shadows3")
    panel:CheckBox(Metrostroi.GetPhrase("Panel.ShadowsOther"),"metrostroi_shadows2")
    panel:CheckBox(Metrostroi.GetPhrase("Panel.PanelLights"),"metrostroi_shadows4")
    panel:CheckBox(Metrostroi.GetPhrase("Panel.PanelSprites"),"metrostroi_sprites")
    local DRouteNumber = panel:TextEntry(Metrostroi.GetPhrase("Panel.RouteNumber"),"metrostroi_route_number")
    panel:CheckBox(Metrostroi.GetPhrase("Panel.MinimizedShow"),"metrostroi_minimizedshow")
    panel:NumSlider(Metrostroi.GetPhrase("Panel.FOV"),"metrostroi_cabfov",65,100)
    panel:NumSlider(Metrostroi.GetPhrase("Panel.Z"),"metrostroi_cabz",-10,10)
    panel:NumSlider(Metrostroi.GetPhrase("Panel.RenderDistance"),"metrostroi_renderdistance",960,3072)
    panel:NumSlider(Metrostroi.GetPhrase("Panel.RenderSignals"),"metrostroi_signal_distance",6144,16384)
    panel:Button(Metrostroi.GetPhrase("Panel.ReloadClient"),"metrostroi_reload_client",true)

    function DRouteNumber:OnChange()
        local oldval = self:GetValue()
        local NewValue = ""
        for i = 1,math.min(3,#oldval) do
            NewValue = NewValue..((oldval[i] or ""):upper():match("[%d]+") or "")
        end
        local oldpos = self:GetCaretPos()
        self:SetText(NewValue)
        self:SetCaretPos(math.min(#NewValue,oldpos,3))
    end
end
local function ClientAdvanced(panel)
    panel:ClearControls()
    panel:SetPadding(0)
    panel:SetSpacing(0)
    panel:Dock( FILL )
    panel:CheckBox(Metrostroi.GetPhrase("Panel.DrawDebugInfo"),"metrostroi_drawdebug")
    panel:CheckBox(Metrostroi.GetPhrase("Panel.DrawSignalDebugInfo"),"metrostroi_drawsignaldebug")
    panel:Button(Metrostroi.GetPhrase("Panel.CheckAddons"),"metrostroi_addons_check")
    panel:Button(Metrostroi.GetPhrase("Panel.ReloadLang"),"metrostroi_language_reload",true)
    panel:NumSlider(Metrostroi.GetPhrase("Panel.SoftDraw"),"metrostroi_softdrawmultipier",25,400)
    panel:CheckBox(Metrostroi.GetPhrase("Panel.SoftReloadLang"),"metrostroi_language_softreload")
end

hook.Add("PopulateToolMenu", "Metrostroi cpanel", function()
    spawnmenu.AddToolMenuOption("Utilities", "Metrostroi", "metrostroi_admin_panel", Metrostroi.GetPhrase("Panel.Admin"), "", "", AdminPanel)
    spawnmenu.AddToolMenuOption("Utilities", "Metrostroi", "metrostroi_client_panel", Metrostroi.GetPhrase("Panel.Client"), "", "", ClientPanel)
    spawnmenu.AddToolMenuOption("Utilities", "Metrostroi", "metrostroi_clientadv_panel", Metrostroi.GetPhrase("Panel.ClientAdvanced"), "", "", ClientAdvanced)
end)

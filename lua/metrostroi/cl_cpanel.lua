--Helper function for common use
local function AddBox(panel,cmd,str)
    panel:AddControl("CheckBox",{Label=str, Command=cmd})
end
--Helper function for common use
local function AddTextBox(panel,cmd,str)
    panel:AddControl("TextBox",{Label=str, Command=cmd})
end
local function AddSlider(panel,cmd,str,min,max,fl)
    panel:AddControl("Slider",{Label=str, Command=cmd,min=min,max=max,type=fl and "float"})
end
-- Build admin panel
local function AdminPanel(panel)
    if not LocalPlayer():IsAdmin() then return end
    AddBox(panel,"metrostroi_train_requirethirdrail",Metrostroi.GetPhrase("Panel.RequireThirdRail"))
    --panel:AddControl("CheckBox",{Label="Trains require 3rd rail", Command = "metrostroi_train_requirethirdrail"})
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


    AddBox(panel,"metrostroi_drawcams",Metrostroi.GetPhrase("Panel.DrawCams"))
    AddBox(panel,"metrostroi_disablehud",Metrostroi.GetPhrase("Panel.DisableHUD"))
    AddBox(panel,"metrostroi_disablecamaccel",Metrostroi.GetPhrase("Panel.DisableCamAccel"))
    AddBox(panel,"metrostroi_disablehovertext",Metrostroi.GetPhrase("Panel.DisableHoverText"))
    AddBox(panel,"metrostroi_disablehovertextpos",Metrostroi.GetPhrase("Panel.DisableHoverTextP"))
    AddBox(panel,"metrostroi_screenshotmode",Metrostroi.GetPhrase("Panel.ScreenshotMode"))
    AddBox(panel,"metrostroi_shadows1",Metrostroi.GetPhrase("Panel.ShadowsHeadlight"))
    AddBox(panel,"metrostroi_shadows3",Metrostroi.GetPhrase("Panel.RedLights"))
    AddBox(panel,"metrostroi_shadows2",Metrostroi.GetPhrase("Panel.ShadowsOther"))
    AddBox(panel,"metrostroi_shadows4",Metrostroi.GetPhrase("Panel.PanelLights"))
    AddBox(panel,"metrostroi_sprites",Metrostroi.GetPhrase("Panel.PanelSprites"))
    local DRouteNumber = panel:TextEntry(Metrostroi.GetPhrase("Panel.RouteNumber"),"metrostroi_route_number")
    AddBox(panel,"metrostroi_minimizedshow",Metrostroi.GetPhrase("Panel.MinimizedShow"))
    AddSlider(panel,"metrostroi_cabfov",Metrostroi.GetPhrase("Panel.FOV"),65,100)
    AddSlider(panel,"metrostroi_cabz",Metrostroi.GetPhrase("Panel.Z"),-10,10,true)
    AddSlider(panel,"metrostroi_renderdistance",Metrostroi.GetPhrase("Panel.RenderDistance"),960,3072)
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
    AddBox(panel,"metrostroi_drawdebug",Metrostroi.GetPhrase("Panel.DrawDebugInfo"))
    AddBox(panel,"metrostroi_drawsignaldebug",Metrostroi.GetPhrase("Panel.DrawSignalDebugInfo"))
    panel:Button(Metrostroi.GetPhrase("Panel.CheckAddons"),"metrostroi_addons_check")
    panel:Button(Metrostroi.GetPhrase("Panel.ReloadLang"),"metrostroi_language_reload",true)
    AddSlider(panel,"metrostroi_softdrawmultipier",Metrostroi.GetPhrase("Panel.SoftDraw"),25,400)
    AddBox(panel,"metrostroi_language_softreload",Metrostroi.GetPhrase("Panel.SoftReloadLang"))
    --panel:AddControl("combobox","metrostroi_language",{Label="Language", options = {"Русский","Английский"}})
    --panel:AddControl("Checkbox",{Label="Draw debugging info", Command = "metrostroi_drawdebug"})
end

hook.Add("PopulateToolMenu", "Metrostroi cpanel", function()
    spawnmenu.AddToolMenuOption("Utilities", "Metrostroi", "metrostroi_admin_panel", Metrostroi.GetPhrase("Panel.Admin"), "", "", AdminPanel)
    spawnmenu.AddToolMenuOption("Utilities", "Metrostroi", "metrostroi_client_panel", Metrostroi.GetPhrase("Panel.Client"), "", "", ClientPanel)
    spawnmenu.AddToolMenuOption("Utilities", "Metrostroi", "metrostroi_clientadv_panel", Metrostroi.GetPhrase("Panel.ClientAdvanced"), "", "", ClientAdvanced)
end)

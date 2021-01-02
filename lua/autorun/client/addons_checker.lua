--[[-------------------------------------------------------------------------
Addons checker for metrostroi addon
---------------------------------------------------------------------------]]

if SERVER then return end
local RequiredAddons = {
    {
        --main
        wsid = 261801217,
        additional = {
            "models/metrostroi/passengers/f1.mdl",
            "models/metrostroi/passengers/f4.mdl",
            "models/metrostroi/passengers/m3.mdl",
            "models/metrostroi/signals/light_path.mdl",
            "models/metrostroi/tracks/dead_end.mdl",
            "models/metrostroi/tatra_t3/tatra_t3.mdl",
            "models/metrostroi/tracks/u002.mdl",
            "models/metrostroi/tracks/tunnel512_double_end.mdl",
            "models/z-o-m-b-i-e/metro_2033/electro/m33_transformator_01_1.mdl",
            "materials/metrostroi/metro_contactrail_001.vmt",
            "maps/gm_metrostroi_b46_lite.bsp",
            "resource/fonts/iee1.ttf"
        }
    },
    {
        --part1
        wsid = 1095094174,
        additional = {
            "materials/models/metrostroi_train/81-717/703windows.vmt",
            "materials/models/metrostroi_train/81-717/717_breakers_s.vtf",
            "materials/models/metrostroi_train/81-717/717_classic2_n.vtf",
            "materials/models/metrostroi_train/81-717/cabine_1006.vtf",
            "materials/models/metrostroi_train/81-717/pa_markers.vmt",
            "materials/models/metrostroi_train/81-717/buttons/lamps_spb_panel.vmt",
            "materials/models/metrostroi_train/81-717/pult/pult_panel_spb_blue_n.vtf",
            "materials/models/metrostroi_train/81-717/screens/pa/question.vtf",
            "materials/models/metrostroi_train/81-717/segments_spb/m2.vtf",
        }
    },
    {
        --part2
        wsid = 1095098251,
        additional = {
            "materials/metrostroi_skins/81-720_schemes/b50_1.vtf",
            "materials/models/metrostroi_train/81-722/apparats2.vtf",
            "materials/models/metrostroi_train/81-722/cabin_n.vmt",
            "materials/models/metrostroi_train/81-722/scepka.vtf",
            "materials/models/metrostroi_train/81-722/screens/failures.vtf",
            "models/metrostroi_train/81-717/pult/ars_mvm_old.mdl",
            "models/metrostroi_train/81-720/81-720.phy",
            "models/metrostroi_train/81-720/route/route1.dx90.vtx",
            "models/metrostroi_train/81-722/81-722_kran.mdl",
            "models/metrostroi_train/81-722/digits/digit.mdl",

        }
    },
    {
        --part3
        wsid = 1095100683,
        additional = {
            "materials/models/metrostroi_train/81_718/1002.vmt",
            "materials/models/metrostroi_train/81_718/marshrut_body_n.vtf",
            "materials/models/metrostroi_train/81-710/508t_blue.vmt",
            "materials/models/metrostroi_train/81-710/710_echs.vtf",
            "materials/models/metrostroi_train/equipment/rri_n.vtf",
            "materials/models/metrostroi_train/equipment/tab_e0.vtf",
            "materials/models/metrostroi_train/reversor/revers_gold.vmt",
            "models/metrostroi_train/81-710/81-508t.phy",
            "models/metrostroi_train/81-718/81-718_int.mdl",
            "models/metrostroi_train/81-718/labels/destination.dx80.vtx",
            "models/metrostroi_train/equipment/arrow_bc_old.dx90.vtx",
            "models/metrostroi_train/equipment/button_ezh_6.vvd",
            "models/metrostroi_train/reversor/reversor_collection_box2_cover.mdl"
        }
    },
    {
        --part4
        wsid = 1095105863,
        additional = {
            "materials/models/metrostroi_train/cabin717_030.vtf",
            "materials/models/metrostroi_train/switches/vud.vtf",
            "materials/models/metrostroi_train/common/lamps/svetodiod.vmt",
            "materials/models/metrostroi_train/bogey/couple_s.vtf",
            "materials/models/metrostroi_train/81-707/pipes_n.vtf",
            "materials/models/metrostroi_train/81-703/int1.vmt",
            "models/metrostroi_train/81-703/81-703.phy",
            "models/metrostroi_train/81-707/ezh_lamp_0.mdl",
            "models/metrostroi_train/bogey/disconnect_valve_blue.dx90.vtx",
            "models/metrostroi_train/common/routes/ezh/route_holder.dx80.vtx",
        }
    },
    {
        --part5
        wsid = 1095109617,
        additional = {
            "materials/models/metrostroi/re_sign/re_sign_light_off.vmt",
            "materials/models/metrostroi_schemes/map_2.vtf",
            "materials/models/metrostroi_train/81/18_det.vmt",
            "materials/models/metrostroi_train/81-502/labels/label_1.vtf",
            "materials/models/metrostroi_train/81-508/81-509_line4.vmt",
            "materials/models/metrostroi_train/81-702/body_n.vtf",
            "materials/models/metrostroi_train/81-720/labels/label_empty.vmt",
            "models/metrostroi_train/81/button_light.mdl",
            "models/metrostroi_train/81-502/81-502.phy",
            "models/metrostroi_train/81-502/indicators/ars_0.dx80.vtx",
            "models/metrostroi_train/81-508/81-508_underwagon.dx90.vtx",
            "models/metrostroi_train/81-702/81-702_red_light.vvd",
        }
    },
    {
        --part 6
        wsid = 1095111608,
        additional = {
            "materials/metrostroi_arm/2-switch_half.vtf",
            "materials/cyber_metrostroi/pc_arm/screen_arm.vmt",
            "models/cyber_metrostroi/pc_arm/pc_body.mdl",
            "models/metrostroi/re_sign/signal_outdoor_35.sw.vtx",
            "sound/udochka_connect.wav",
            "sound/subway_trains/718/tisu.wav",
            "sound/subway_trains/722/kuau/x_xp2.mp3",
            "sound/subway_trains/bogey/brake_squeal2.mp3",
            "sound/subway_trains/common/junk/junk_enginestart_speed3.mp3",
            "sound/subway_trains/717/bpsn/bpsn_old.wav",
            "sound/subway_trains/502/ring_ksaup.wav",

        }
    },
    --[[ {
        --Scripts
        wsid = 1095130789,
        additional = {
            "lua/autorun/metrostroi.lua",
            "lua/entities/gmod_mus_clock_analog/init.lua",
            "lua/entities/gmod_subway_81-717_mvm/init.lua",
            "lua/entities/gmod_track_signal/shared.lua",
            "lua/metrostroi/skins/default.lua",
            "lua/metrostroi/systems/sys_81_720_electric.lua",
            "lua/metrostroi/systems/sys_als_ars.lua",
            "lua/metrostroi/sv_railnetwork.lua",
            "lua/metrostroi/sv_turbostroi.lua",
            "lua/metrostroi_data/languages/en_base.lua",
            "lua/ulx/modules/sh/metrostroi.lua",
            "lua/weapons/gmod_tool/stools/switch.lua"

        }
    },--]]
    {
        --Github check
        name = "Metrostroi Github",
        additional = {
            "lua/entities/gmod_subway_rusich/cl_init.lua",
            "lua/entities/gmod_subway_ema/init.lua",
            "lua/entities/gmod_subway_ema508t/shared.lua",
            "lua/entities/gmod_subway_em508/cl_init.lua",
            "lua/entities/gmod_subway_em508_int/init.lua",
            "lua/metrostroi/systems/sys_81_704_panel.lua",
            "lua/metrostroi/systems/sys_81_717lvz_panel.lua",
            "lua/metrostroi/systems/sys_noars.lua",
            "sound/subway_announcer_riu/arr_108.mp3",
            "sound/subway_announcer_pnm/00_06.mp3",
        },
        reason="Workshop.ErrorGithub",
        single = true,
    },
    {
        --Legacy version
        wsid = 1098448386,
        additional = {
            "lua/entities/gmod_subway_81-717/cl_init.lua",
            "lua/entities/gmod_subway_81-717/init.lua",
            "lua/entities/gmod_subway_81-714/shared.lua",
            "lua/entities/gmod_subway_81-714/cl_init.lua",
            "sound/subway_announcer/02_02.mp3",
        },
        reason="Workshop.ErrorLegacy",
        single = true,
    },
    {
        --Some effects enhancers
        wsid = 259517980,
        reason="Workshop.ErrorEnhancers",
    },
    {
        --Some effects enhancers
        wsid = 111396485,
        reason="Workshop.ErrorEnhancers",
    },
    {
        --Driveable trams
        wsid = 707998439,
        reason="Workshop.Error1",
        single = true,
    },
    {
        --Gm_mus_orange_c_long
        wsid = 793374567,
        reason="Workshop.Error1",
        single = true,
    },
}


local function drawText(panel,text,color,font)
    local addonWarn = vgui.Create("DLabel",panel)
    addonWarn:Dock( TOP )
    addonWarn:SetFont(font or "DermaDefault")
    addonWarn:SetTextColor(color or Color(0,0,0))
    addonWarn:SetText(text or "N\\A")
    addonWarn:DockMargin( 0, -4, 0, -4)
    addonWarn:DockPadding( 0, -4, 0, -4)
end
function vgui.MetrostroiDrawCutText(panel,text,color,font)
    if text:find("\n") then
        for k,v in pairs(string.Explode("\n",text)) do
            vgui.MetrostroiDrawCutText(panel,v,color,font)
        end
        return
    end

    surface.SetFont(font or "DermaDefault")
    local doneText,width = "",0
    for i,v in pairs(string.Explode(" ",text)) do
        local phraseWidth = surface.GetTextSize(v)
        if width + phraseWidth < 390 then
            doneText = doneText.." "..v
            width=width+phraseWidth
        elseif width ~= 0 then
            drawText(panel,doneText,color,font)
            doneText = v
            width=phraseWidth
        else
            doneText = v
            width = phraseWidth
            break
        end
    end
    if #doneText > 0 and width > 390 then
        local fr = 1
        for ls=1,#doneText do
            local phraseWidth = surface.GetTextSize(doneText:sub(fr,ls))
            if phraseWidth > 390 then
                drawText(panel,doneText:sub(fr,ls-1),color,font)
                doneText = doneText:sub(ls,-1)
            end
        end
    end
    if #doneText > 0 then
        drawText(panel,doneText,color,font)
    end
end
local WaitAddons = 0
local function showAddons(ply)
    for _,v in ipairs(RequiredAddons) do
        v.error = nil; v.message = nil
        --Check some files in addon, if we install to addons folder
        local installed = -1
        if v.additional and #v.additional > 0 then
            installed=0
            for _,path in ipairs(v.additional) do
                if not file.Exists( path, "GAME") then --[[ print(v.name,path)--]]  break end
                installed = installed+1
            end
        end

        if installed~=-1 then
            if installed<#v.additional and not v.reason and (v.downloaded and v.mounted or not v.filename) then
                v.error = true
                if v.filename then
                    v.message = "Workshop.FilesMissing"
                else
                    v.message = "Workshop.FilesMissingLocaly"
                end
            elseif installed>=#v.additional and not v.filename then
                v.error = v.reason~=nil
                v.message = v.reason or "Workshop.InstalledLocaly"
            end
        end
        if not v.message and v.wsid then
            if v.reason then
                v.error = v.downloaded and v.mounted
                v.message = v.error and v.reason or "Workshop.NotInstalled"
            else
                v.error = not v.downloaded or not v.mounted
                v.message = not v.downloaded and "Workshop.NotInstalledE" or not v.mounted and "Workshop.Disabled" or "Workshop.Installed"
            end
        elseif v.reason and not v.message then
            v.error = false
            v.message = "Workshop.NotInstalled"
        end
        if v.message then
            v.message = Metrostroi.GetPhrase(v.message)
        else
            v.message = Metrostroi.GetPhrase("N\\A")
        end
        if GetConVarNumber("metrostroi_addons_check_ignore") > 0 and (v.error or not v.message) then
            RunConsoleCommand("metrostroi_addons_check_ignore",0)
        end
    end
    if GetConVarNumber("metrostroi_addons_check_ignore") > 0 and not ply or WaitAddons > 0 then return end

    if IsValid(MetrostroiWorkshopVGUI) then  MetrostroiWorkshopVGUI:Close() end
    local badCount = 0
    for i,a in ipairs(RequiredAddons) do if a.error or a.message == "N\\A" then badCount = badCount + 1 end end
    local frame = vgui.Create("DFrame")
    MetrostroiWorkshopVGUI = frame
        frame:SetDeleteOnClose(true)
        frame:SetTitle(Metrostroi.GetPhrase("Workshop.Title"))
        frame:SetSize(0, 0)
        frame:SetDraggable(true)
        frame:SetSizable(false)
        frame:MakePopup()
    --text:SetText(Metrostroi.GetPhrase("Workshop.Warn"))

    local scrollPanel = vgui.Create( "DScrollPanel", frame )
    --scrollPanel:SetMinimumSize(nil,450)
    for i,a in ipairs(RequiredAddons) do
        if badCount ~= 0 and not showall and GetConVarNumber("metrostroi_addons_check_skip_error") > 0 and not a.error and a.message ~= "N\\A"  or not a.error and a.reason then continue end

        --local a = v[1]
        local addon = vgui.Create("DPanel")
        addon:Dock( TOP )
        addon:DockMargin( 5, 0, 5, 5 )
        addon:DockPadding( 5, 5, 5, 5 )

        if a.notlocaly and a.message ~= "N\\A" then
            local openLink = vgui.Create("DButton",addon)
            openLink:Dock(RIGHT)
            openLink:SetText(Metrostroi.GetPhrase("Workshop.Open"))
            openLink:DockPadding( 5, 5, 5, 5 )
            openLink:SizeToContents()
            openLink:SetContentAlignment(5)
            openLink.id = a.wsid
            function openLink:DoClick()
                steamworks.ViewFile(self.id)
            end
        end


        --vgui.MetrostroiDrawCutText(addon,Metrostroi.GetPhrase("Workshop.Warning"),false,"DermaDefaultBold")
        vgui.MetrostroiDrawCutText(addon,a.name or "N\\A",false,"DermaDefaultBold")
        vgui.MetrostroiDrawCutText(addon,Format(a.message,a.filename),a.message == "N\\A" and Color(175,150,0) or a.error and Color(150,0,0) or Color(0,150,0),"DermaDefaultBold")
        if a.error and not scrollPanel.ScrollTo then scrollPanel.ScrollTo = addon end

        --[[ Metrostroi.GetPhrase("Workshop.Warning").."\n"
        ..a.name.."\n"
        ..a.badreason.."\n"--]]
        --addonWarn:SetFont("DermaDefaultBold")
        --addonWarn:SetAutoStretchVertical(true)
        --[[ local addonName = vgui.Create("DLabel",addon)
        addonName:SetWrap(true)
        addonName:SetTextColor(Color(0,0,0))
        addonName:SetTextInset( 0, 0 )
        addonName:SetText(a.name)
        addonName:SetFont("DermaDefaultBold")
        addonName:SetContentAlignment(5)
        addonName:SetAutoStretchVertical(true)
        addonName:Dock( TOP )
        addonName:StretchToParent()
        --addonName:SizeToChildren(true,true)
        local addonErr = vgui.Create("DLabel",addon)
        addonErr:SetWrap(true)
        addonErr:SetTextColor(Color(255,0,0))
        addonErr:SetTextInset( 0, 0 )
        addonErr:SetText(a.badreason)
        addonErr:SetFont("DermaDefaultBold")
        addonErr:SetContentAlignment(5)
        addonErr:SetAutoStretchVertical(true)
        addonErr:Dock( TOP )
        addonErr:StretchToParent()--]]
        --addonErr:SizeToChildren(true,true)

        addon:InvalidateLayout( true )
        addon:SizeToChildren(true,true )
        scrollPanel:AddItem(addon)
    end
    scrollPanel:Dock( FILL )
    scrollPanel:InvalidateLayout( true )
    scrollPanel:SizeToChildren(false,true)
    local spPefromLayout = scrollPanel.PerformLayout
    function scrollPanel:PerformLayout()
        spPefromLayout(self)
        if not self.First then self.First = true return end
        local x,y = scrollPanel:ChildrenSize()
        if self.Centered then return end
        self.Centered = true
        frame:SetSize(512,math.min(350,y)+35)
        frame:Center()
        if self.ScrollTo then self:ScrollToChild(self.ScrollTo) end
    end
    --frame:InvalidateLayout( true )
    --frame:SizeToChildren(false,true )
    if badCount == 0 then
        RunConsoleCommand("metrostroi_addons_check_ignore",1)
    end
end

local function checkAddons(ply)
    for kr,v in ipairs(RequiredAddons) do
        if v.single and not game.SinglePlayer() then continue end
        v.filename = nil; v.downloaded = nil; v.downloaded = nil; v.mounted = nil; v.error = nil; v.message = nil
        --find our addon installed from workshop
        local founded = false
        for ka,a in pairs(engine.GetAddons()) do
            if v.wsid and tonumber(a.wsid) == v.wsid then
                v.name = a.title
                v.filename = a.file
                v.downloaded = a.downloaded
                v.mounted = a.mounted
                founded = true
                v.notlocaly = true
            end
        end
        if not founded and v.wsid then
            WaitAddons = WaitAddons+1
            steamworks.FileInfo(v.wsid, function(a)
                v.name = a.title
                v.downloaded = a.installed
                v.mounted = a.disabled
                v.notlocaly = true
                WaitAddons = WaitAddons-1
                if WaitAddons<=0 then
                    showAddons(ply)
                end
            end)
        end
    end
    showAddons(ply)
end
checkAddons()
hook.Add("MetrostroiLoaded","AddonsChecked",checkAddons)
concommand.Add("metrostroi_addons_check",checkAddons,nil,"Run addons check")


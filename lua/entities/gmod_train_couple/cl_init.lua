include("shared.lua")

function ENT:Initialize()
end

function ENT:OnRemove()
end

--------------------------------------------------------------------------------
function ENT:Think()
end

local c_gui
if IsValid(c_gui) then c_gui:Close() end

local function addButton(parent,stext,state,scolor,btext,benabled,callback)
    --local a = v[1]
    local panel = vgui.Create("DPanel")
    panel:Dock( TOP )
    panel:DockMargin( 5, 0, 5, 5 )
    panel:DockPadding( 5, 5, 5, 5 )
    if benabled then
        local button = vgui.Create("DButton",panel)
        button:Dock(RIGHT)
        button:SetText(Metrostroi.GetPhrase(btext))
        button:DockPadding( 5, 5, 5, 5 )
        button:SizeToContents()
        button:SetContentAlignment(5)
        button:SetEnabled(benabled)
        button.DoClick = callback
    end

    --DrawCutText(panel,Metrostroi.GetPhrase("Workshop.Warning"),false,"DermaDefaultBold")
    vgui.MetrostroiDrawCutText(panel,Metrostroi.GetPhrase(stext),false,"DermaDefaultBold")
    vgui.MetrostroiDrawCutText(panel,Metrostroi.GetPhrase(state),scolor,"DermaDefaultBold")

    panel:InvalidateLayout( true )
    panel:SizeToChildren(true,true )
    parent:AddItem(panel)
end

function ENT:DrawGUI(tbl)
    if IsValid(c_gui) then  c_gui:Close() end
     local c_gui = vgui.Create("DFrame")
        c_gui:SetDeleteOnClose(true)
        c_gui:SetTitle(Metrostroi.GetPhrase("Common.Couple.Title"))
        c_gui:SetSize(0, 0)
        c_gui:SetDraggable(true)
        c_gui:SetSizable(false)
        c_gui:MakePopup()
    local scrollPanel = vgui.Create( "DScrollPanel", c_gui )
        addButton(scrollPanel,"Common.Couple.CoupleState",tbl.coupled and "Common.Couple.Coupled" or "Common.Couple.Uncoupled", Color(0,150,0),"Common.Couple.Uncouple",tbl.coupled and tbl.access,function(button)
            net.Start("metrostroi-coupler-menu")
                net.WriteEntity(self)
                net.WriteUInt(0,8)
            net.SendToServer()
            c_gui:Close()
        end)
        if tbl.isolpresent then
            addButton(scrollPanel,"Common.Couple.IsolState",tbl.isolated and "Common.Couple.Isolated" or "Common.Couple.Opened", Color(0,150,0),tbl.isolated and "Common.Couple.Open" or "Common.Couple.Isolate",tbl.access,function(button)
                net.Start("metrostroi-coupler-menu")
                    net.WriteEntity(self)
                    net.WriteUInt(1,8)
                net.SendToServer()
                c_gui:Close()
            end)
        end
        if tbl.haveEKK then
            addButton(scrollPanel,"Common.Couple.EKKState",tbl.ekk_disc and "Common.Couple.Disconnected" or "Common.Couple.Connected",tbl.ekk_disc and Color(150,50,0) or Color(0,150,0),tbl.ekk_disc and "Common.Couple.Connect" or "Common.Couple.Disconnect",tbl.access,function(button)
                net.Start("metrostroi-coupler-menu")
                    net.WriteEntity(self)
                    net.WriteUInt(2,8)
                net.SendToServer()
                c_gui:Close()
            end)
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
        c_gui:SetSize(512,math.min(350,y)+35)
        c_gui:Center()
    end
end


function ENT:DrawGUIHTML(tbl)
    if IsValid(c_gui) then  c_gui:Close() end
        c_gui = vgui.Create("DFrame")
        c_gui:SetDeleteOnClose(true)
        c_gui:SetTitle(Metrostroi.GetPhrase("Common.Couple.Title"))
        c_gui:SetSize(640, 400)
        c_gui:SetDraggable(true)
        c_gui:SetSizable(false)
        c_gui:Center()
        local html = vgui.Create( "DHTML" , c_gui )
        html:Dock( FILL )
        html:SetHTML( [[
<!DOCTYPE html>
<html lang="ru">
  <head>
    <meta charset="utf-8">
    <style type="text/css">
      .grid {overflow: hidden;}
      .segment_content {width: 100%;}
      .segment_content > .ui.header {display: inline-block;height: 1rem;}
      .segment_content > button {float: right;}
      #green_header {color:green;}
      #red_header {color: red;}
    </style>

    <link rel="stylesheet" href="https://test.metrostroi.net/tpl/semantic/semantic.css" type="text/css">
  </head>

  <body style="display: flex; min-height: 100vh; flex-direction: column;">
    <div class="ui container" style="flex: 1; margin-right: 3rem !important; margin-left: 3rem !important">
      <div class="ui main container" style="margin-top: 2rem; ">
        <h3 style="padding-bottom: 1rem;">Меню сцепки</h3>
        <div class="ui segment">
          <div class="segment_content">
            <h3 class="ui header">
              Состояние сцепки
              <div class="green sub header" id="green_header">Сцеплено</div>
            </h3>
            <button class="ui right floated button">Расцепить</button>
          </div>
        </div>
        <div class="ui segment">
          <div class="segment_content">
            <h3 class="ui header">
              Состояние концевых кранов
              <div class="green sub header" id="green_header">Открыты</div>
            </h3>
            <button class="ui right floated button">Закрыть</button>
          </div>
        </div>
        <div class="ui segment">
          <div class="segment_content">
            <h3 class="ui header">
              Состояние ЭКК
              <div class="green sub header" id="green_header">Разъединена</div>
            </h3>
            <button class="ui right floated button">Соеденить</button>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
        ]] )
    html:SetAllowLua( true )
    html:ConsoleMessage( print)
    html:AddFunction( "metrostroi", "getText", Metrostroi.GetPhrase)

    c_gui:MakePopup()


end
net.Receive("metrostroi-coupler-menu",function()
    local ent = net.ReadEntity()
    if not IsValid(ent) or IsValid(c_gui) and c_gui.Entity ~= ent then return end
    ent:DrawGUI{
        access = net.ReadBool(),
        coupled=net.ReadBool(),
        isolpresent=net.ReadBool(),
        isolated=net.ReadBool(),
        haveEKK=not net.ReadBool(),
        ekk_disc=net.ReadBool(),
    }
end)
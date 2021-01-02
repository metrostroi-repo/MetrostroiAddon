include("shared.lua")

--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.AutoAnimNames = {}
ENT.ClientSounds = {}
ENT.ClientPropsInitialized = false


ENT.ButtonMap["ARM"] = {
    pos = Vector(-4.9,9.1,50.3),
    ang = Angle(0,-90-1,90),
    width = 800,
    height = 600,
    scale = 0.02*1.2,
    mouse = true
}
ENT.ClientProps["ARMPK"] = {
    model = "models/cyber_metrostroi/pc_arm/pc_screen.mdl",
    pos = Vector(-5,0,31.2),
    ang = Angle(0,180,0),
    bscale = Vector(4/3,1,1),
}
ENT.ClientProps["ARMMonitor"] = {
    model = "models/cyber_metrostroi/pc_arm/pc_body.mdl",
    pos = Vector(-5,15,0),
    ang = Angle(0,180,0),
    bscale = Vector(4/3,1,1),
}
ENT.ClientProps["ARMKeyboard"] = {
    model = "models/cyber_metrostroi/pc_arm/pc_keyboard.mdl",
    pos = Vector(-15,-2,31),
    ang = Angle(0,180,0),
}
ENT.ClientProps["ARMMouse"] = {
    model = "models/cyber_metrostroi/pc_arm/pc_mouse.mdl",
    pos = Vector(-18,-20,32),
    ang = Angle(0,180,0),
}
ENT.ClientProps["ARMBreen"] = {
    model = "models/props_combine/breenglobe.mdl",
    pos = Vector(-11,30,39.5),
    ang = Angle(0,-180+45,0),
}

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.ARM = self:CreateRT("ARM",1024,1024)
    for k,v in pairs(self.Types) do
        for i,tex in pairs(v) do
            if type(tex) == "table" and type(tex[1]) == "string" then
                tex.mat = surface.GetTextureID(tex[1])
            end
        end
    end
end

function ENT:CamMoved()
    self:HandleMouse(false)
    gui.EnableScreenClicker(self.CurrentCamera ~= 0)
end

function ENT:Think()
    self.BaseClass.Think(self)
    if not self.RenderClientEnts or self.CreatingCSEnts then
        return
    end

    if not self.ARM then return end
    --self.MouseX = 0
    --self.MouseY = 0
    self.MouseX = self:GetNW2Int("CursorX",0)
    self.MouseY = self:GetNW2Int("CursorY",0)
    render.PushRenderTarget(self.ARM,0,0,1024, 1024)
    render.Clear(0, 0, 0, 0)
    cam.Start2D()
        render.OverrideAlphaWriteEnable(true, true)
        surface.SetDrawColor(0,0,0)
        surface.DrawRect(0,0,800,600)
        self:ARMMonitor()
    cam.End2D()
    render.PopRenderTarget()
end

function ENT:Draw()
    self.BaseClass.Draw(self)
end


function ENT:DrawPost()
    self.RTMaterial:SetTexture("$basetexture", self.ARM)
    self:DrawOnPanel("ARM",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,512,1024,1024,0)
    end)
end


local gray = Color(100,100,100)
local black = Color(0,0,0)
local white = Color(150,150,150)
local green = Color(0,50,0)

local function GetTextures(segm,typ)
    return segm[typ],segm.maintex or segm[typ]
end
--Get texture Width and Height
local function GetWH(segm,typ)
    local tex,dtex = GetTextures(segm,typ)
    return tex.w or dtex.w,tex.h or dtex.h
end
--Get real(original) texture Width and Height
local function GetRWH(segm,typ)
    local tex,dtex = GetTextures(segm,typ)
    return tex.rw or dtex.rw,tex.rh or dtex.rh
end
--Get X and Y adds
local function GetXYA(segm,typ)
    local tex,dtex = GetTextures(segm,typ)
    return tex.xa or dtex.xa or 0,tex.ya or dtex.ya or 0
end

local function GetXY(x,y)
    return 100+x*36,100+y*70
end
local function drawSegment(w,h,u0,v0,u1,v1,segm,typ,align)
    --local segm =  self.Types[typ]
    if not segm or not segm[typ] then return end
    local tex,dtex = GetTextures(segm,typ)
    if  dtex.mat then
        local sx,sy = GetXY(w,h)
        local sw,sh = GetWH(segm,typ)
        local sxa = tex.x or dtex.x or 0
        local xa,ya = GetXYA(segm,typ)
        local rw,rh = GetRWH(segm,typ)
        surface.SetDrawColor(tex.col or dtex.col or white)
        surface.SetTexture(tex.mat or dtex.mat)
        surface.DrawTexturedRectUV(sx+xa+sxa*u0,sy+ya-(rh-8)*v0,rw,rh,(rw/sw)*u0,(rh/sh)*v0,(rw/sw)*u1,(rh/sh)*v1)
    end
end
local function drawElement(sx,sy,u0,v0,u1,v1,segm,typ,col)
    --local segm =  self.Types[typ]
    if not segm or not segm[typ] then return end
    local tex =  segm[typ]
    local dtex =  segm.maintex or tex
    --local sx,sy = 100+w*36,100+h*70
    local sw,sh = tex.w or dtex.w,tex.h or dtex.h
    local sxa = tex.x or dtex.x or 0
    local xa,ya = tex.xa or dtex.xa or 0,tex.ya or dtex.ya or 0
    local rw,rh = tex.rw or dtex.rw,tex.rh or dtex.rh
    surface.SetDrawColor(col or tex.col or dtex.col or white)
    surface.SetTexture(tex.mat or dtex.mat)
    surface.DrawTexturedRectUV(sx+xa+sxa*u0,sy+ya-(rh-8)*v0 ,rw,rh,(rw/sw)*u0,(rh/sh)*v0,(rw/sw)*u1,(rh/sh)*v1)
end

local mouse = surface.GetTextureID("gui/info")

local function createFont(name,font,size,weight)
    surface.CreateFont("Metrostroi_"..name, {
        font = font,
        size = size,
        weight = weight or 400,
        blursize = 0,
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
        extended = true,
    })
end
createFont("Arial10","Arial",10,400)
createFont("Arial11","Arial",11,400)
createFont("Arial13","Arial",13,400)
createFont("Arial15","Arial",15,400)
createFont("Arial15B","Arial",15,800)
createFont("Arial20","Arial",20,800)

local colorConverter = {
    r = Color(0,0,0),
    y = Color(240,240,71),
    g = Color(41,202,26),
    b = Color(26,84,202),
    w = Color(255,255,255),
}
local function GetSegmPos(segm,alt)
    local x,y = segm.x,segm.y
    local segmt = segm.segm
        local u0,v0,u1,v1 = 0,0,1,1
        if segm.invertX then u0,u1 = 1,0 end
        if segm.invertY then v0,v1 = 1,0 end
    if alt == nil then
        return GetXY(x+segm.width*u0,y)
    elseif alt == false and segmt.next_m then
        return GetXY(x+segmt.next_m.x-segm.width*u0,y+segmt.next_m.y)
        --print(123,x,y)
    elseif alt and segmt.next_a then
        return GetXY(x+segmt.next_a.x*u1-segmt.next_a.x*u0+segmt.width*u0,y+segmt.next_a.y*v1-segmt.next_a.y*v0)
    end
end


function ENT:ARMMonitor()
    if self.FilterMag then
        render.PopFilterMag()
        render.PopFilterMin()
    end

    render.PushFilterMag( TEXFILTER.POINT )
    render.PushFilterMin( TEXFILTER.POINT )
    self.FilterMag = true
    surface.SetDrawColor(gray)
    surface.DrawRect(0,0,800,600)
    local station = self:GetNW2Int("ARM:Station",0)
    --draw.SimpleText("АРМ ДЫЫСЦЫПЫ","Metrostroi_BUKPSpeed",400, 300,Color(220,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    if station > 0 and Metrostroi.ARMConfigGenerated and Metrostroi.ARMConfigGenerated[station] then
        local armTable = Metrostroi.ARMConfigGenerated[station]
        for id,segm in ipairs(armTable) do
            local u0,v0,u1,v1 = 0,0,1,1
            if segm.invertX then u0,u1 = 1,0 end
            if segm.invertY then v0,v1 = 1,0 end
            drawSegment(segm.x,segm.y,u0,v0,u1,v1,segm.segm,"maintex")
        end
        local w,h = 0,0
        for id,segm in ipairs(armTable) do
            local u0,v0,u1,v1 = 0,0,1,1
            if segm.invertX then u0,u1 = 1,0 end
            if segm.invertY then v0,v1 = 1,0 end
            if Metrostroi.GetARMInfo(station,id,"occup2") then
                drawSegment(segm.x,segm.y,u0,v0,u1,v1,segm.segm,"occup_x")
            end
            if Metrostroi.GetARMInfo(station,id,"switch_m") then
                if Metrostroi.GetARMInfo(station,id,"occup") then drawSegment(segm.x,segm.y,u0,v0,u1,v1,segm.segm,"occup_m")
                elseif Metrostroi.GetARMInfo(station,id,"route") then drawSegment(segm.x,segm.y,u0,v0,u1,v1,segm.segm,"route_m") end
                drawSegment(segm.x,segm.y,u0,v0,u1,v1,segm.segm,"switch_m")
            elseif Metrostroi.GetARMInfo(station,id,"switch_a") then
                if Metrostroi.GetARMInfo(station,id,"occup") then drawSegment(segm.x,segm.y,u0,v0,u1,v1,segm.segm,"occup_a")
                elseif Metrostroi.GetARMInfo(station,id,"route") then drawSegment(segm.x,segm.y,u0,v0,u1,v1,segm.segm,"route_a") end
                drawSegment(segm.x,segm.y,u0,v0,u1,v1,segm.segm,"switch_a")
            elseif Metrostroi.GetARMInfo(station,id,"switch_na") then
                if Metrostroi.GetARMInfo(station,id,"occup") then
                    drawSegment(segm.x,segm.y,u0,v0,u1,v1,segm.segm,"occup_m")
                    drawSegment(segm.x,segm.y,u0,v0,u1,v1,segm.segm,"occup_a")
                end
                drawSegment(segm.x,segm.y,u0,v0,u1,v1,segm.segm,"switch_an")
                drawSegment(segm.x,segm.y,u0,v0,u1,v1,segm.segm,"switch_mn")
            else
                if Metrostroi.GetARMInfo(station,id,"occup") then drawSegment(segm.x,segm.y,u0,v0,u1,v1,segm.segm,"occup_m")
                elseif Metrostroi.GetARMInfo(station,id,"route") then drawSegment(segm.x,segm.y,u0,v0,u1,v1,segm.segm,"route_m") end
            end
            if segm.signal1 then
                local sig = segm.signal1
                local typ = self.Types["tl_"..sig.type]

                local x,y = 100+(segm.x+segm.width)*36,100+segm.y*70-(sig.top and -26 or 15)
                local rw,rh = GetRWH(typ,"maintex")
                local sx,sy = x-rw-2,y-rh-2

                draw.SimpleText(sig.name,"Metrostroi_Arial10",x, y-(sig.top and -7 or 15),Color(0,0,0),TEXT_ALIGN_RIGHT,TEXT_ALIGN_BOTTOM)
                drawElement(sx,sy,0,0,1,1,typ,"maintex")
                local colors = Metrostroi.GetARMInfo(station,id,"signal1") or ""
                if sig.type > 1 and Metrostroi.GetARMInfo(station,id,"signal1I") then
                    drawElement(sx+13*(sig.type-1),sy,0,0,1,1,typ,"full",colorConverter.w)
                end
                if sig.type > 2 and Metrostroi.GetARMInfo(station,id,"signal1Y") then
                    drawElement(sx+13*(sig.type-2),sy,0,0,1,1,typ,"full",colorConverter.y)
                end
                if colors ~= "" and #colors == 1 then
                    local color = colors:lower()
                    drawElement(sx,sy,0,0,1,1,typ,"full",colorConverter[color] or Color(0,0,0))
                elseif colors ~= "" and #colors == 2 then
                    local color = colors:lower()
                    drawElement(sx,sy,0,0,1,1,typ,"h1",colorConverter[color[1]] or Color(0,0,0))
                    drawElement(sx,sy,0,0,1,1,typ,"h2",colorConverter[color[2]] or Color(0,0,0))
                end
            end
            if segm.signal2 then
                local sig = segm.signal2
                local typ = self.Types["tl_"..sig.type]

                local rw,rh = GetRWH(typ,"maintex")
                local x,y = 100+(segm.x)*36+2,100+segm.y*70+(sig.top and -38 or 3)
                local sx,sy = x-1,y+rh

                draw.SimpleText(sig.name,"Metrostroi_Arial10",x, y+(sig.top and -2 or 20),Color(0,0,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
                drawElement(sx,sy,1,1,0,0,typ,"maintex")
                local colors = Metrostroi.GetARMInfo(station,id,"signal2") or ""
                if sig.type > 1 and Metrostroi.GetARMInfo(station,id,"signal2I") then
                    drawElement(sx+rw-12-13*(sig.type-1),sy,1,1,0,0,typ,"full",colorConverter.w)
                end
                if sig.type > 2 and Metrostroi.GetARMInfo(station,id,"signal2Y") then
                    drawElement(sx+rw-12-13*(sig.type-2),sy,1,1,0,0,typ,"full",colorConverter.y)
                end
                if colors ~= "" and #colors == 1 then
                    local color = colors:lower()
                    drawElement(sx+rw-12,sy,1,1,0,0,typ,"full",colorConverter[color] or Color(0,0,0))
                elseif colors ~= "" and #colors == 2 then
                    local color = colors:lower()
                    drawElement(sx+rw-12,sy,1,1,0,0,typ,"h1",colorConverter[color[1]] or Color(0,0,0))
                    drawElement(sx+rw-12,sy,1,1,0,0,typ,"h2",colorConverter[color[2]] or Color(0,0,0))
                end
            end
        end
        for id,obj in ipairs(armTable.objects) do
            if obj.type=="b" then
                local x1,y1 = GetXY(obj.x1,obj.y1)
                local x2,y2 = GetXY(obj.x2,obj.y2)
                local w,h = x2-x1,y2-y1
                --Metrostroi.DrawRectOL(x1,y1,x2-x1,y2-y1,Color(255,255,255),2,Color(200,200,200))
                surface.SetDrawColor(200,200,200)
                surface.DrawRect(x1,y1,w,h)
                surface.SetDrawColor(255,255,255)
                surface.DrawOutlinedRect(x1,y1,w,h)
                surface.SetFont("Metrostroi_Arial20")
                local fw,fh = 0,0
                local rows = string.Explode("\n",obj.name)
                for _,text in ipairs(rows) do
                    local w,h = surface.GetTextSize(text)
                    fw,fh = math.max(w,fw),math.max(h,fh)
                end
                for i=#rows,1,-1 do
                    local x,y = x1+w/2,y1+h/2+(i-1)*20-(#rows-1)*20/2
                    surface.SetDrawColor(150,150,150)
                    surface.DrawRect(x-fw/2-5,y-fh/2-5,fw+10,fh+10)
                    draw.SimpleText(rows[i],"Metrostroi_Arial20",x, y,Color(40,40,40),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                end
            end
            if obj.type=="cl" then
                local x,y = GetXY(obj.x,obj.y)
                if obj.right then x = x-50 y = y-30 end
                --Metrostroi.DrawRectOL(x1,y1,x2-x1,y2-y1,Color(255,255,255),2,Color(200,200,200))
                surface.SetDrawColor(60,60,60)
                surface.DrawRect(x,y,50,30)
                draw.SimpleText(Format("%02d:%02d",23,30),"Metrostroi_Arial15",x+4, y+4,Color(150,255,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
            end
        end
        for id,button in ipairs(armTable.buttons) do
            local sx,sy = 100+button.x*36,100+button.y*70
            local sw,sh = 15,25
            local xa,ya = 3,12
            if button.type=="r" then
                sw,sh = 15,25
                xa,ya = 3,12
            end
            if button.type=="pn" then
                sw,sh = 15,15
                xa,ya = -sw/2,-sh/2
            end
            if button.type=="rn" then
                surface.SetFont("Metrostroi_Arial15")
                local w,h = surface.GetTextSize(button.name)
                sw,sh = w+9,15
                xa,ya = -sw/2,-sh/2
            end
            local x,y = sx+xa,sy+ya
            if Metrostroi.GetARMInfo(station,1000+id,"buttonSelected") then
                surface.SetDrawColor(Color(80,80,180))
            elseif Metrostroi.GetARMInfo(station,1000+id,"buttonPressable") then
                surface.SetDrawColor(Color(220,220,220))
            else
                if button.type=="pn" then
                    surface.SetDrawColor(Color(20,20,20))
                else
                    surface.SetDrawColor(Color(120,120,120))
                end
            end
            surface.DrawRect(x,y,sw,sh)
            Metrostroi.DrawLine(x,y,x,y+sh,Color(240,240,240),2)
            Metrostroi.DrawLine(x-1,y,x+sw,y,Color(240,240,240),2)
            Metrostroi.DrawLine(x+sw,y,x+sw,y+sh,Color(60,60,60),2)
            Metrostroi.DrawLine(x,y+sh,x+sw+1,y+sh,Color(60,60,60),2)

            if button.type=="rn" then
                draw.SimpleText(button.name,"Metrostroi_Arial15B",x+sw/2, y+sh/2,Color(50,50,50),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            end
        end
        for id,text in ipairs(armTable.info) do
            local x,y = 100+text.x*36,100+text.y*70
            local w,h = 45,13
            if text.col then
                surface.SetDrawColor(text.col)
                surface.DrawRect(x,y,w,h)
            end
                draw.SimpleText(text.text,"Metrostroi_Arial13",x+2, y+h/2,Color(50,50,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            Metrostroi.DrawLine(x,y,x,y+h,Color(240,240,240),2)
            Metrostroi.DrawLine(x-1,y,x+w,y,Color(240,240,240),2)
            Metrostroi.DrawLine(x+w,y,x+w,y+h,Color(60,60,60),2)
            Metrostroi.DrawLine(x,y+h,x+w+1,y+h,Color(60,60,60),2)

            --[[ if button.type=="rn" then
                draw.SimpleText(button.name,"Metrostroi_Arial15B",x+sw/2, y+sh/2,Color(50,50,50),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            end--]]
        end
    end
    for i,v in ipairs(Metrostroi.ARMConfigGenerated) do
        if i == station then
            surface.SetDrawColor(Color(110,140,170))
        elseif math.InRangeXYR(self.MouseX,self.MouseY,20+(i-1)*30,20,30,20) then
            surface.SetDrawColor(Color(80,110,140))
        else
            surface.SetDrawColor(Color(100,130,160))
        end

        surface.DrawRect(20+(i-1)*31,20,30,20)
        draw.SimpleText(v.shortname or v.id,"Metrostroi_Arial20",35+(i-1)*31, 30,Color(40,60,170),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end
    if station > 0 and Metrostroi.ARMConfigGenerated and Metrostroi.ARMConfigGenerated[station] then
        local armTable = Metrostroi.ARMConfigGenerated[station]
        for id,segm in ipairs(armTable) do
            local u0,v0,u1,v1 = 0,0,1,1
            if segm.invertX then u0,u1 = 1,0 end
            if segm.invertY then v0,v1 = 1,0 end

---[[ DEBUG
            local w,h = GetXY(segm.x+segm.width*u0,segm.y)
            surface.SetDrawColor(Color(255,0,0))
            surface.DrawLine(w+5*u1-5*u0,h,w,h)
            surface.DrawLine(w,h+5,w,h)
            local w,h = GetSegmPos(segm,false)
            surface.SetDrawColor(Color(255,255,0))
            surface.DrawLine(w-6*u1+6*u0,h,w,h)
            surface.DrawLine(w,h-6,w,h)
            local w,h = GetSegmPos(segm,true)
            if w then
                surface.SetDrawColor(Color(0,255,0))
                surface.DrawLine(w-6*u1+6*u0,h,w,h)
                surface.DrawLine(w,h-6*v1+6*v0,w,h)
            end
            local x,y = 100+(segm.x+segm.width)*36,100+segm.y*70-4
            local rw,rh = GetRWH(segm.segm,"maintex")
            local sx,sy = x-rw-2,y-rh-2

            surface.SetDrawColor(Color(0,0,0,150))
            surface.DrawRect(sx,y-7,30,10)
            draw.SimpleText(Format("%.1f:%.1f",segm.x,segm.y),"Metrostroi_Arial11",sx, y-2,Color(255,255,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
--]]
        end
    end
    --if self.CurrentCamera == 0 then
        surface.SetDrawColor(255,255,255)
        surface.SetTexture(mouse)
        surface.DrawTexturedRectRotated(self.MouseX,self.MouseY,8,8,0)
    --end

    surface.SetDrawColor(0,0,0,200)
    surface.DrawRect(0,0,800,600)
    render.PopFilterMag()
    render.PopFilterMin()
    self.FilterMag = false
end
Metrostroi.GenerateClientProps()
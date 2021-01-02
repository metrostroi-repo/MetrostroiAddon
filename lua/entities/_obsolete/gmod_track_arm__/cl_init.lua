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

local function ARMFindNextSegm(station,csegm,alt,dir,deb)
    if dir then
        if alt and not csegm.segm.next_a then return end
        if not alt and not csegm.segm.next_m then return end
        for segmid,segm in ipairs(station) do
            if segm == csegm then continue end
            if segm.x <= csegm.x then continue end
            local txa,tya = GetSegmPos(csegm,alt)
            local tx,ty = GetXY(csegm.x+csegm.width*(csegm.invertX or 0),csegm.y)

            if not txa then continue end
            --if tx then print(1,segm.x,segm.y,GetSegmPos2(csegm,alt),csegm.invertX,csegm.invertY) end
            local sx,sy = GetXY(segm.x+segm.width*(segm.invertX or 0),segm.y)
            --if not alt then print(2,x,y,sx,sy,tx,ty,txa,tya) end
            if sx == tx and sy == ty then return segm,sx,sy  end
            if sx == txa and sy == tya then return segm,sx,sy  end
                  sx,sy = GetSegmPos(segm,false)
            --if sx and sx == tx and sy == ty then return segm,false end
            --if deb then print(sx,x) end
            if sx and sx == txa and sy == tya then return segm,sx,sy  end
                  sx,sy = GetSegmPos(segm,true)
            --if sx and sx == tx and sy == ty then return segm,false end
            if sx and sx == txa and sy == tya and (not alt or segm.y ~= csegm.y) then return segm,sx,sy end
        end
    else
        for segmid,segm in ipairs(station) do
            if segm == csegm then continue end
            if segm.x >= csegm.x then continue end
            local txa,tya = GetSegmPos(segm,alt)
            local tx,ty = GetXY(segm.x+segm.width*(segm.invertX or 0),segm.y)

            if not txa then continue end

            local sx,sy = GetXY(csegm.x+csegm.width*(csegm.invertX or 0),csegm.y)
            if sx == tx and sy == ty then return segm,sx,sy  end
            if sx == txa and sy == tya then return segm,sx,sy  end
                  sx,sy = GetSegmPos(csegm,false)

            if sx and sx == txa and sy == tya then return segm,sx,sy  end
                  sx,sy = GetSegmPos(csegm,true)

            if sx and sx == txa and sy == tya and (not alt or segm.y ~= csegm.y) then return segm,sx,sy end
        end
        --[[ for segmid,segm in ipairs(station) do
            if segm == csegm then continue end
            if segm.x >= csegm.x then continue end
            local txa,tya = GetSegmPos(segm,alt)
            local tx,ty = GetXY(segm.x+segm.width*(segm.invertX or 0),segm.y)
            if not txa then continue end
            --if tx then print(1,segm.x,segm.y,GetSegmPos2(csegm,alt),csegm.invertX,csegm.invertY) end
            local sx,sy = GetXY(csegm.x+csegm.width*(csegm.invertX or 0),csegm.y)
            --if not alt then print(2,x,y,sx,sy,tx,ty,txa,tya) end
            if sx == tx and sy == ty then return segm end
            if sx == txa and sy == tya then return segm  end
                  sx,sy = GetSegmPos(csegm,false)
            --if sx and sx == tx and sy == ty then return segm,false end
            --if deb then print(sx,x) end
            if sx and sx == txa and sy == tya then return segm  end
                  sx,sy = GetSegmPos(csegm,true)
            --if alt then print(3,x,y,sx,sy,tx,ty) end
            --if sx and sx == tx and sy == ty then return segm,false end
            if sx and sx == txa and sy == tya and (not alt or segm.y ~= csegm.y) then return segm end
        end--]]
    end
end

local function ARMSetNextCompare(posX,posY,segm,nsegm)
    local xp,yp = GetSegmPos(segm)
    local x,y = GetSegmPos(nsegm)
    if sx and posX == x and posY == y then
        nsegm.prev = segm
        return true
    end

    sx,sy = GetSegmPos(nsegm,false)
    if sx and posX == sx and posY == sy then
        nsegm.next_m = segm
        return true
    end
    if not nsegm.segm.next_a then return end
    sx,sy = GetSegmPos(nsegm,true)
    if x ~= xp and y ~= yp and sx and posX == sx and posY == sy then
        nsegm.next_a = segm
        if segm.id == 29 then
            local x1,y1 = GetSegmPos(nsegm)
            local x2,y2 = GetSegmPos(segm)
            print(-2,x1,y1,x2,y2)
        end
        return true
    end
end

local function ARMSetNext(station)
    for csegmid,csegm in ipairs(station) do
        for segmid,segm in ipairs(station) do
            if segm == csegm then continue end

            local posX,posY = GetSegmPos(csegm)
            if ARMSetNextCompare(posX,posY,csegm,segm) then
                csegm.prev = segm
                --break
            end
            local posOX,posOY = GetSegmPos(csegm,false)
            if ARMSetNextCompare(posOX,posOY,csegm,segm) then
                csegm.next_m = segm
                --break
            end
            local _,posAY = GetSegmPos(segm)
            if not csegm.segm.next_a or posX == posAX or posY == posAY then continue end
            posOX,posOY = GetSegmPos(csegm,true)
            if ARMSetNextCompare(posOX,posOY,csegm,segm) then
                csegm.next_a = segm
                --break
            end
        end
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

--[[
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
            end--]]
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
        for id,button in ipairs(armTable.buttons) do
            local sx,sy = 100+button.x*36,100+button.y*70
            local sw,sh = 15,25
            local xa,ya = 3,12
            if button.type=="r" then
                sw,sh = 15,25
                xa,ya = 3,12
            end
            local x,y = sx+xa,sy+ya
            if Metrostroi.GetARMInfo(station,1000+id,"buttonSelected") then
                surface.SetDrawColor(Color(80,80,180))
            elseif Metrostroi.GetARMInfo(station,1000+id,"buttonPressable") then
                surface.SetDrawColor(Color(220,220,220))
            else
                surface.SetDrawColor(Color(120,120,120))
            end
            surface.DrawRect(x,y,sw,sh)
            Metrostroi.DrawLine(x,y,x,y+sh,Color(240,240,240),2)
            Metrostroi.DrawLine(x-1,y,x+sw,y,Color(240,240,240),2)
            Metrostroi.DrawLine(x+sw,y,x+sw,y+sh,Color(60,60,60),2)
            Metrostroi.DrawLine(x,y+sh,x+sw+1,y+sh,Color(60,60,60),2)
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
--[=[
    local iter = 0
    local function ARMFindSegmSignals(station,segm,dir,signals,checked,restbl,trace,NextAlt)
        if not restbl then restbl = {} end
        if not checked then checked = {} end
        if not trace then trace = {} end
        if checked[segm] then return end
        checked[segm] = true
        local segmIndex = table.insert(trace,{segm.id})
        --trace[segm] = true

        iter = iter + 1
        if iter > 10000 then ARMGenError(Format("Routes generation error. Max iter reached!"),true) return false end
        local segmt = segm.segm
        local segmM,segmA = segmt.next_m,segmt.next_a
        if not segmM then return end

        local NextM = ARMFindNextSegm(station,segm,not NextAlt,dir)
        local NextA = ARMFindNextSegm(station,segm,NextAlt,dir)


        local xp,yp = GetXY(segm.x,segm.y)
        if NextA then
            local trace= table.Copy(trace)
            trace[segmIndex][2] = true
            local xn,yn = GetXY(NextA.x,NextA.y)
            local xa1,ya1 = GetSegmPos(segm,true)
            local xa2,ya2 = GetSegmPos(NextA,true)
            --trace[segmIndex][2] = true
            local nxt = xa1==xn and ya1==yn or
                                  xa2==xn and ya2==yn or
                                  xa1==xp and ya1==yp or
                                  xa2==xp and ya2==yp or
                                  xa1 and xa2 and xa1==xa2 and ya1==ya2
            --MsgN(Format("->A\n",segm.x,segm.y))
            local signal = dir and NextA.signal2 or NextA.signal1
            --print("A",segm.x,segm.y,NextA.x,NextA.y,signal and signal.name,dir)
            if signal  and table.HasValue(signals,signal.name) then--and not segmOnA.invertX then
                table.insert(restbl,{signal,table.Copy(trace)})
            end
            ARMFindSegmSignals(station,NextA,dir,signals,checked,restbl,trace,true)
        end
        if NextM then
            local xn,yn = GetXY(NextM.x,NextM.y)
            local xa1,ya1 = GetSegmPos(segm,true)
            local xa2,ya2 = GetSegmPos(NextM,true)
            local nxt = xa1==xn and ya1==yn or
                                  xa2==xn and ya2==yn or
                                  xa1==xp and ya1==yp or
                                  xa2==xp and ya2==yp or
                                  xa1 and xa2 and xa1==xa2 and ya1==ya2
            local signal = dir and NextM.signal2 or NextM.signal1
            --print("M",segm.x,segm.y,NextM.x,NextM.y,signal and signal.name,dir)
            if signal  and table.HasValue(signals,signal.name) then--and not segmOnA.invertX then
                table.insert(restbl,{signal,table.Copy(trace)})
            end
            ARMFindSegmSignals(station,NextM,dir,signals,checked,restbl,table.Copy(trace))
        end
        return restbl
    end
    local station = Metrostroi.ARMConfigGenerated[station]
    for _,button in pairs(station.buttons,station.routes["PT64"]) do
        if button.type == "r" and station.routes[button.signal] then
            --button.pressable = true
            local results = ARMFindSegmSignals(station,button.segm,false,station.routes[button.signal])
            if #results == 0 then
                results = ARMFindSegmSignals(station,button.segm,true,station.routes[button.signal])
            end
            for k,v in pairs(results) do
                local i = 0
                for k,v in pairs(v[2]) do
                    print(v[2])
                end
            end
            --print(results[1][1].name,results[1][1].segm)--]]
            --button.routes = results
        end
    end--]=]
--[=[
    local x = 0
    local founded = true
    local stat = Metrostroi.ARMConfigGenerated[station]
    local maxd = 3
    local x = 26-- or math.ceil((CurTime()%10)/10*#stat)
    local dir = true-- or CurTime()%20 > 10
    local function findt(station,segm,dir,i,depth,px,py )
        depth = depth or 0
        i = i or 0
        local segmt = segm.segm
        local segmM,segmA = segmt.next_m,segmt.next_a
        local NextM,NextMX,NextMY = ARMFindNextSegm(station,segm,false,dir)
        local NextA,NextAX,NextAY = ARMFindNextSegm(station,segm,true,dir)
        local xp,yp = GetXY(segm.x,segm.y)
        draw.SimpleText(i,"Metrostroi_Arial20",xp,yp,Color(255,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        draw.SimpleText(Format("%.1f:%.1f",segm.x,segm.y),"Metrostroi_Arial10",xp,yp-20,Color(255,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

        local xa1,ya1 = GetSegmPos(segm,true)
        if i==4 then print(xa1,ya1,px,py,xa1 == px and ya1 == py) end
        local alt = px and py ~= yp and xa1 == px and ya1 == py
        if NextA and depth+1 < maxd then
            --if i==3 then print(1) end
            local xn,yn = GetXY(NextA.x,NextA.y)
            local xa2,ya2 = GetSegmPos(NextA,true)
            local nalt = xa1==xn and ya1==yn or
               xa2==xn and ya2==yn or
               xa1==xp and ya1==yp or
               xa2==xp and ya2==yp or
               xa1 and xa2 and xa1==xa2 and ya1==ya2
            if nalt or alt then surface.SetDrawColor(Color(255,0,0))
               else surface.SetDrawColor(Color(0,255,0)) end
            surface.DrawLine(px or xp,py or yp,NextAX or xn,NextAY or yn)
            if findt(station,NextA,dir,i+1,depth+1,NextAX,NextAY) then return end
            --return true
            --if i==5 then print("RES",segm.x,segm.y,NextA.x,NextA.y) end
        end
        if NextM  and depth < maxd then
            local xn,yn = GetXY(NextM.x,NextM.y)
            local xa2,ya2 = GetSegmPos(NextM,true)
            local nalt = xa1==xn and ya1==yn or
               xa2==xn and ya2==yn or
               xa1==xp and ya1==yp or
               xa2==xp and ya2==yp or
               xa1 and xa2 and xa1==xa2 and ya1==ya2
            if alt then surface.SetDrawColor(Color(255,255,0))
               else surface.SetDrawColor(Color(0,255,0)) end
            surface.DrawLine(px or xp,py or yp,NextMX or xn,NextMY or yn)
            if findt(station,NextM,dir,i+1,depth,NextMX,NextMY) then return end
        end
    end
    --findt(stat,stat[x],dir)--]=]
   --[==[
   if Metrostroi.ARMConfigGenerated[station] then
        ARMSetNext(Metrostroi.ARMConfigGenerated[station])
       --[=[ for id,segm in ipairs(Metrostroi.ARMConfigGenerated[station]) do
            local ws,hs = GetSegmPos(segm)
            draw.SimpleText(segm.id,"Metrostroi_Arial20",ws,hs-15--[[ *(math.random()*5)--]] ,Color(0,255,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            if segm.next_m then
                local w,h = GetSegmPos(segm.next_m)
                surface.SetDrawColor(Color(0,255,0))
                surface.DrawLine(ws,hs,w,h)
                surface.DrawLine(ws-6,hs-6,ws+6,hs+6)
                surface.DrawLine(ws-6,hs+6,ws+6,hs-6)
                surface.DrawLine(w-6,h-2,w+6,h+2)
                surface.DrawLine(w-6,h+2,w+6,h-2)
            else
                local w,h = GetSegmPos(segm)
                w = w+segm.width*36/2
                surface.SetDrawColor(Color(255,0,255))
                surface.DrawLine(w-4,h-4,w+4,h+4)
                surface.DrawLine(w-4,h+4,w+4,h-4)
                continue
            end
            if segm.next_a then
                local w,h = GetSegmPos(segm.next_a)
                draw.SimpleText(segm.id,"Metrostroi_Arial20",w,h+15,Color(255,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                surface.SetDrawColor(Color(255,0,0))
                surface.DrawLine(ws,hs,w,h)
                surface.DrawLine(ws-7,hs-4,ws+7,hs+4)
                surface.DrawLine(ws-7,hs+4,ws+7,hs-4)
                surface.DrawLine(w-7,h-2,w+7,h+2)
                surface.DrawLine(w-7,h+2,w+7,h-2)
            end
        end--]=]
        local x = 0
        local founded = true
        local stat = Metrostroi.ARMConfigGenerated[station]
        local maxd = 2
        local x = 21-- or math.ceil((CurTime()%10)/10*#stat)
        local dir = true-- or CurTime()%20 > 10
        local function findt(station,segm,dir,i,depth,last )
            depth = depth or 0
            i = i or 0
            local segmP = segm.prev
            local segmM,segmA = segm.next_m,segm.next_a
            local x,y = GetXY(segm.x,segm.y)
            draw.SimpleText(i,"Metrostroi_Arial20",x,y,Color(255,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            draw.SimpleText(Format("%.1f:%.1f",segm.x,segm.y),"Metrostroi_Arial10",x,y-20,Color(255,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)


            local mainM = segmM and (dir and segmM.x > segm.x or not dir and segmM.x < segm.x)
            local mainP = segmP and (dir and segmP.x > segm.x or not dir and segmP.x < segm.x)
            if i==7 and last.next_a then
                draw.SimpleText(i,"Metrostroi_Arial20",x,y,Color(0,255,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                local x,y = GetXY(last.x,last.y)
                draw.SimpleText(i-1,"Metrostroi_Arial20",x,y,Color(255,255,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                --print(last.next_a,segm)
            end

            if segmA and mainM and depth+1 < maxd then
                --if i==3 then print(1) end
                local xn,yn = GetXY(segmA.x,segmA.y)
                surface.SetDrawColor(Color(255,0,0))
                surface.DrawLine(x,y,xn,yn)
                if findt(station,segmA,dir,i+1,depth+1,segm) then return end
                return true
                --if i==5 then print("RES",segm.x,segm.y,NextA.x,NextA.y) end
            end
            if segmM and mainM  and depth < maxd then
                local xn,yn = GetXY(segmM.x,segmM.y)
                surface.SetDrawColor(Color(0,255,0))
                surface.DrawLine(x,y,xn,yn)
                if findt(station,segmM,dir,i+1,depth,segm) then return end
            end
            if segmP and mainP  and depth < maxd then
                local xn,yn = GetXY(segmP.x,segmP.y)
                local alt = last and segm.next_a == last or segmP.next_a == segm
                if alt then surface.SetDrawColor(Color(255,255,0))
                   else surface.SetDrawColor(Color(0,255,255)) end
                surface.DrawLine(x,y,xn,yn)
                if findt(station,segmP,dir,i+1,depth,segm) then return end
            end
        end
        findt(stat,stat[x],dir)
    end--]==]
    --findt(stat,stat[6],false)
end
Metrostroi.GenerateClientProps()
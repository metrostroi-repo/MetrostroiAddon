--------------------------------------------------------------------------------
-- Clientside utility functions
--------------------------------------------------------------------------------
local bitmap_font_1 = {
    [10] = {
        0,0,0,0,
        0,0,0,0,
        0,0,0,0,
        0,0,0,0,
        0,0,0,0,
        0,0,0,0,
        0,0,0,0},
    ["."] = {
        0,0,0,0,
        0,0,0,0,
        0,0,0,0,
        0,0,0,0,
        0,0,0,0,
        0,0,0,0,
        0,0,1,0},
    [1] = {
        0,0,0,1,
        0,0,0,1,
        0,0,0,1,
        0,0,0,1,
        0,0,0,1,
        0,0,0,1,
        0,0,0,1},
    [2] = {
        1,1,1,1,
        0,0,0,1,
        0,0,0,1,
        1,1,1,1,
        1,0,0,0,
        1,0,0,0,
        1,1,1,1},
    [3] = {
        1,1,1,1,
        0,0,0,1,
        0,0,0,1,
        1,1,1,1,
        0,0,0,1,
        0,0,0,1,
        1,1,1,1},
    [4] = {
        1,0,0,1,
        1,0,0,1,
        1,0,0,1,
        1,1,1,1,
        0,0,0,1,
        0,0,0,1,
        0,0,0,1},
    [5] = {
        1,1,1,1,
        1,0,0,0,
        1,0,0,0,
        1,1,1,1,
        0,0,0,1,
        0,0,0,1,
        1,1,1,1},
    [6] = {
        1,1,1,1,
        1,0,0,0,
        1,0,0,0,
        1,1,1,1,
        1,0,0,1,
        1,0,0,1,
        1,1,1,1},
    [7] = {
        1,1,1,1,
        0,0,0,1,
        0,0,0,1,
        0,0,0,1,
        0,0,0,1,
        0,0,0,1,
        0,0,0,1},
    [8] = {
        1,1,1,1,
        1,0,0,1,
        1,0,0,1,
        1,1,1,1,
        1,0,0,1,
        1,0,0,1,
        1,1,1,1},
    [9] = {
        1,1,1,1,
        1,0,0,1,
        1,0,0,1,
        1,1,1,1,
        0,0,0,1,
        0,0,0,1,
        0,0,0,1},
    [0] = {
        1,1,1,1,
        1,0,0,1,
        1,0,0,1,
        1,0,0,1,
        1,0,0,1,
        1,0,0,1,
        1,1,1,1},
}



--------------------------------------------------------------------------------
-- Draw bitmap digit
function Metrostroi.DrawClockDigit(cx,cy,scale,digit)
    local bitmap = bitmap_font_1[digit]
    if not bitmap then return end

    local w=12*scale
    local p=8*scale
    for i=1,4*7 do
        local x = (i-1)%4
        local y = math.floor((i-1)/4)
        if bitmap[i] == 1 then
            for z=1,6,1 do
                surface.SetDrawColor(Color(255,60,0,math.max(0,30-1*z*z)))
                surface.DrawRect(cx+x*w-z*scale, cy+y*w-z*scale, p+2*z*scale, p+2*z*scale)
            end

            surface.SetDrawColor(Color(255,240,0,255))
            surface.DrawRect(cx+x*w, cy+y*w, p, p)
        end
    end
end





function Metrostroi.PositionFromPanel(panel,button_id_or_vec,z,x,y,train)
    local self = train or ENT
    local panel = self.ButtonMap[panel]
    if not panel then return Vector(0,0,0) end
    if not panel.buttons then return Vector(0,0,0) end

    -- Find button or read position
    local vec
    if type(button_id_or_vec) == "string" then
        local button
        for k,v in pairs(panel.buttons) do
            if v.ID == button_id_or_vec then
                button = v
                break
            end
        end
        vec = Vector(button.x + (button.radius and 0 or (button.w or 0)/2)+(x or 0),button.y + (button.radius and 0 or (button.h or 0)/2)+(y or 0),z or 0)
    else
        vec = button_id_or_vec
    end

    -- Convert to global coords
    vec.y = -vec.y
    vec:Rotate(panel.ang)
    return panel.pos + vec * panel.scale
end

function Metrostroi.AngleFromPanel(panel,ang,train)
    local self = train or ENT
    local panel = self.ButtonMap[panel]
    if not panel then return Vector(0,0,0) end
    local true_ang = panel.ang + Angle(0,0,0)
    if type(ang) == "Angle" then
        true_ang:RotateAroundAxis(panel.ang:Forward(),ang.pitch)
        true_ang:RotateAroundAxis(panel.ang:Right(),ang.yaw)
        true_ang:RotateAroundAxis(panel.ang:Up(),ang.roll)
    else
        true_ang:RotateAroundAxis(panel.ang:Up(),ang or -90)
    end
    return true_ang
end

Metrostroi.PrecacheModels = Metrostroi.PrecacheModels or {}
function Metrostroi.GenerateClientProps()
    local self = ENT
    if not self.AutoAnimNames then self.AutoAnimNames = {} end
    local ret = "self.table = {\n"
    --local reti = 0
    for id, panel in pairs(self.ButtonMap) do
        if not panel.buttons then continue end
        if not panel.props then panel.props = {} end
        for name, buttons in pairs(panel.buttons) do
            --if reti > 8 then reti=0; ret=ret.."\n" end

            if buttons.tooltipFunc then
                local func = buttons.tooltipFunc
                buttons.tooltipState = function(ent)
                    local str = func(ent)
                    if not str then return "" end
                    return "\n["..str:gsub("\n","]\n[").."]"
                end
            elseif buttons.varTooltip then
                local states = buttons.states or {"Train.Buttons.Off","Train.Buttons.On"}
                local count = (#states-1)
                buttons.tooltipState = function(ent)
                    return Format("\n[%s]",Metrostroi.GetPhrase(states[math.floor(buttons.varTooltip(ent)*count+0.5)+1]):gsub("\n","]\n["))
                end
            elseif buttons.var then
                local var = buttons.var
                local st1,st2 = "Train.Buttons.Off","Train.Buttons.On"
                if buttons.states then
                    st1 = buttons.states[1]
                    st2 = buttons.states[2]
                end
                buttons.tooltipState = function(ent)
                    return Format("\n[%s]",Metrostroi.GetPhrase(ent:GetPackedBool(var) and st2 or st1):gsub("\n","]\n["))
                end
            end
            if buttons.model then
                local config = buttons.model
                local name = config.name or buttons.ID

                if config.tooltipFunc then
                    local func = config.tooltipFunc
                    buttons.tooltipState = function(ent)
                        local str = func(ent)
                        if not str then return "" end
                        return "\n["..str:gsub("\n","]\n[").."]"
                    end
                elseif config.varTooltip then
                    local states = config.states or {"Train.Buttons.Off","Train.Buttons.On"}
                    local count = (#states-1)
                    local func = config.getfunc
                    if config.varTooltip == true and func then
                        buttons.tooltipState = function(ent)
                            return Format("\n[%s]",Metrostroi.GetPhrase(states[math.floor(config.func(ent)*count+0.5)+1]):gsub("\n","]\n["))
                        end
                    elseif config.varTooltip ~= true then
                        buttons.tooltipState = function(ent)
                            return Format("\n[%s]",Metrostroi.GetPhrase(states[math.floor(config.varTooltip(ent)*count+0.5)+1]):gsub("\n","]\n["))
                        end
                    end
                elseif (config.var and (not config.noTooltip and not buttons.ID:find("Set") or config.noTooltip==false)) then
                    local var = config.var
                    local st1,st2 = "Train.Buttons.Off","Train.Buttons.On"
                    if config.states then
                        st1 = config.states[1]
                        st2 = config.states[2]
                    end
                    buttons.tooltipState = function(ent)
                        return Format("\n[%s]",Metrostroi.GetPhrase(ent:GetPackedBool(var) and st2 or st1))
                    end
                end
                if config.model then
                    table.insert(panel.props,name)
                    self.ClientProps[name] = {
                        model = config.model or "models/metrostroi/81-717/button07.mdl",
                        pos = Metrostroi.PositionFromPanel(id,config.pos or buttons.ID,(config.z or 0.2),(config.x or 0),(config.y or 0)),
                        ang = Metrostroi.AngleFromPanel(id,config.ang),
                        color = config.color,
                        colora = config.colora,
                        skin = config.skin or 0,
                        config = config,
                        cabin = config.cabin,
                        hide = panel.hide or config.hide,
                        hideseat = panel.hideseat or config.hideseat,
                        bscale = config.bscale,
                        scale = config.scale,
                    }
                    --[[if config.varTooltip then
                        local states = config.states or {"Train.Buttons.On","Train.Buttons.Off"}
                        local count = (#states-1)
                        buttons.tooltipState = function(ent)
                            local text = "\n["
                            for i,t in ipairs(states) do
                                if i == #states then
                                    text = text..Metrostroi.GetPhrase(t)
                                else
                                    text = text..Metrostroi.GetPhrase(t).."|"
                                end
                            end
                            text = text.."]"
                            return text,states[math.floor(config.varTooltip(ent)+0.5)*count+1]
                        end
                    elseif (config.var and not config.noTooltip) then
                        local var = config.var
                        local st1,st2 = "Train.Buttons.On","Train.Buttons.Off"
                        if config.states then
                            st1 = config.states[1]
                            st2 = config.states[2]
                        end
                        buttons.tooltipState = function(ent)
                            return Format("\n[%s|%s]",Metrostroi.GetPhrase(st1),Metrostroi.GetPhrase(st2)),ent:GetPackedBool(var) and st1 or st2
                        end
                    end]]
                    if config.var then
                        local var = config.var
                        local vmin, vmax = config.vmin or 0,config.vmax or 1
                        local min,max = config.min or 0,config.max or 1
                        local speed,damping,stickyness = config.speed or 16,config.damping or false,config.stickyness or nil
                        local func = config.getfunc
                        local i
                        if func then
                            if config.disable then
                                i = table.insert(self.AutoAnims, function(ent)
                                    ent:Animate(name,func(ent,vmin,vmax,var),min,max,speed,damping,stickyness)
                                    ent:HideButton(config.disable,ent:GetPackedBool(var))
                                end)
                            elseif config.disableinv then
                                i = table.insert(self.AutoAnims, function(ent)
                                    ent:Animate(name,func(ent,vmin,vmax,var),min,max,speed,damping,stickyness)
                                    ent:HideButton(config.disableinv,not ent:GetPackedBool(var))
                                end)
                            elseif config.disableoff and config.disableon then
                                i = table.insert(self.AutoAnims, function(ent)
                                    ent:Animate(name,func(ent,vmin,vmax,var),min,max,speed,damping,stickyness)
                                    ent:HideButton(config.disableoff,ent:GetPackedBool(var))
                                    ent:HideButton(config.disableon,not ent:GetPackedBool(var))
                                end)
                            elseif config.disablevar then
                                i = table.insert(self.AutoAnims, function(ent)
                                    ent:HideButton(name,ent:GetPackedBool(config.disablevar))
                                    ent:Animate(name,func(ent,vmin,vmax,var),min,max,speed,damping,stickyness)
                                end)
                            else
                                i = table.insert(self.AutoAnims, function(ent) ent:Animate(name,func(ent,vmin,vmax),min,max,speed,damping,stickyness) end)
                            end
                        else
                            if config.disable then
                                i = table.insert(self.AutoAnims, function(ent)
                                    ent:Animate(name,ent:GetPackedBool(var) and vmax or vmin,min,max,speed,damping,stickyness)
                                    ent:HideButton(config.disable,ent:GetPackedBool(var))
                                end)
                            elseif config.disableinv then
                                i = table.insert(self.AutoAnims, function(ent)
                                    ent:Animate(name,ent:GetPackedBool(var) and vmax or vmin,min,max,speed,damping,stickyness)
                                    ent:HideButton(config.disableinv,not ent:GetPackedBool(var))
                                end)
                            elseif config.disableoff and config.disableon then
                                i = table.insert(self.AutoAnims, function(ent)
                                    ent:Animate(name,ent:GetPackedBool(var) and vmax or vmin,min,max,speed,damping,stickyness)
                                    ent:HideButton(config.disableoff,ent:GetPackedBool(var))
                                    ent:HideButton(config.disableon,not ent:GetPackedBool(var))
                                end)
                            elseif config.disablevar then
                                i = table.insert(self.AutoAnims, function(ent)
                                    ent:HideButton(name,ent:GetPackedBool(config.disablevar))
                                    ent:Animate(name,ent:GetPackedBool(var) and vmax or vmin,min,max,speed,damping,stickyness)
                                end)
                            else
                                i = table.insert(self.AutoAnims, function(ent) ent:Animate(name,ent:GetPackedBool(var) and vmax or vmin,min,max,speed,damping,stickyness) end)
                            end
                        end
                        self.AutoAnimNames[i] = name
                    end
                end
                if config.sound or config.sndvol and config.var then
                    local id = config.sound or config.var
                    local sndid = config.sndid or buttons.ID
                    local vol,pitch,min,max = config.sndvol, config.sndpitch,config.sndmin,config.sndmax
                    local func,snd = config.getfunc, config.snd
                    local vmin, vmax = config.vmin or 0,config.vmax or 1
                    local var = config.var
                    local ang = config.sndang
                    --if func then
                        --self.ClientSounds[id] = {sndid,function(ent,var) return snd(func(ent,vmin,vmax),var) end,vol or 1,pitch or 1,min or 100,max or 1000,ang or Angle(0,0,0)}
                    --else
                    if not self.ClientSounds[id] then self.ClientSounds[id] = {} end
                    table.insert(self.ClientSounds[id],{sndid,function(ent,var) return snd(var > 0,var) end,vol or 1,pitch or 1,min or 100,max or 1000,ang or Angle(0,0,0)})
                    --end
                end
                if config.plomb then
                    local pconfig = config.plomb
                    local pname = name.."_pl"
                    if pconfig.model then
                        table.insert(panel.props,pname)
                        self.ClientProps[pname] = {
                            model = pconfig.model,
                            pos = Metrostroi.PositionFromPanel(id,config.pos or buttons.ID,(config.z or 0.2)+(pconfig.z or 0.2),(config.x or 0)+(pconfig.x or 0),(config.y or 0)+(pconfig.y or 0)),
                            ang = Metrostroi.AngleFromPanel(id,pconfig.ang or config.ang),
                            color = pconfig.color or pconfig.color,
                            skin = pconfig.skin or config.skin or 0,
                            config = pconfig,
                            cabin = pconfig.cabin,
                            hide = panel.hide or config.hide,
                            hideseat = panel.hideseat or config.hideseat,
                            bscale = pconfig.bscale or config.bscale,
                            scale = pconfig.scale or config.scale,
                        }
                    end
                    if pconfig.var then
                        local var = pconfig.var
                        if pconfig.model then
                            local i = table.insert(self.AutoAnims, function(ent)
                                ent:SetCSBodygroup(pname,1,ent:GetPackedBool(var) and 0 or 1)
                            end)
                            self.AutoAnimNames[i] = pname
                        end
                        local id,tooltip = buttons.ID,buttons.tooltip
                        local pid,ptooltip = pconfig.ID,pconfig.tooltip
                        buttons.plombed = function(ent)
                            if ent:GetPackedBool(var) then
                                return Format("%s\n%s",buttons.tooltip,Metrostroi.GetPhrase("Train.Buttons.Sealed") or "Plombed"),pid,Color(255,150,150),true
                            else
                                return buttons.tooltip,id,false
                            end
                        end
                    end
                end
                if config.lamp then
                    local lconfig = config.lamp
                    local lname = name.."_lamp"
                    table.insert(panel.props,lname)
                    self.ClientProps[lname] = {
                        model = lconfig.model or "models/metrostroi/81-717/button07.mdl",
                        pos = Metrostroi.PositionFromPanel(id,config.pos or buttons.ID,(config.z or 0.2)+(lconfig.z or 0.2),(config.x or 0)+(lconfig.x or 0),(config.y or 0)+(lconfig.y or 0)),
                        ang = Metrostroi.AngleFromPanel(id,lconfig.ang or config.ang),
                        color = lconfig.color or config.color,
                        skin = lconfig.skin or config.skin or 0,
                        config = lconfig,
                        cabin = lconfig.cabin,
                        igrorepanel = true,
                        hide = panel.hide or config.hide,
                        hideseat = panel.hideseat or config.hideseat,
                        bscale = lconfig.bscale or config.bscale,
                        scale = lconfig.scale or config.scale,
                    }
                    if lconfig.anim then
                        local i = table.insert(self.AutoAnims, function(ent)
                            ent:AnimateFrom(lname,name)
                        end)
                        self.AutoAnimNames[i] = lname
                    end

                    if lconfig.lcolor then
                        self.Lights[lname] = { "headlight",
                            Metrostroi.PositionFromPanel(id,config.pos or buttons.ID,(config.z or 0.2)+(lconfig.z or 0.2)+(lconfig.lz or 0.2),(config.x or 0)+(lconfig.x or 0)+(lconfig.lx or 0),(config.y or 0)+(lconfig.y or 0)+(lconfig.ly or 0)),
                            Metrostroi.AngleFromPanel(id,lconfig.lang or lconfig.ang or config.ang)+Angle(90,0,0),
                            lconfig.lcolor,farz = lconfig.lfar or 8,nearz = lconfig.lnear or 1,shadows = lconfig.lshadows or 1,brightness = lconfig.lbright or 1,fov = lconfig.lfov,texture=lconfig.ltex or "effects/flashlight/soft",panellight=true,
                            hidden = lname,
                        }
                        --[[self.ClientProps[lname.."TEST"] = {
                            model = "models/metrostroi_train/81-703/cabin_cran_334.mdl",
                            pos = Metrostroi.PositionFromPanel(id,config.pos or buttons.ID,(config.z or 0.2)+(lconfig.z or 0.2)+(lconfig.lz or 0.2),(config.x or 0)+(lconfig.x or 0)+(lconfig.lx or 0),(config.y or 0)+(lconfig.y or 0)+(lconfig.ly or 0)),
                            ang = Metrostroi.AngleFromPanel(id,lconfig.lang or lconfig.ang or config.ang)+Angle(-180,180,0),
                            scale=0.1,
                        }]]
                        --[[table.insert(self.AutoAnims, function(ent)
                            ent:AnimateFrom(lname,name)
                        end)]]
                    end
                    if lconfig.var then
                        --ret=ret.."\""..lconfig.var.."\","
                        --reti = reti + 1
                        local var,animvar = lconfig.var,lname.."_anim"
                        local min,max = lconfig.min or 0,lconfig.max or 1
                        local speed = lconfig.speed or 10
                        local func = lconfig.getfunc
                        local light = lconfig.lcolor
                        if func then
                            table.insert(self.AutoAnims, function(ent)
                                local val = ent:Animate(animvar,func(ent,min,max,var),0,1,speed,false)
                                ent:ShowHideSmooth(lname,val)
                                if light then ent:SetLightPower(lname,val>0,val) end
                            end)
                        else
                            local i = table.insert(self.AutoAnims, function(ent)
                                --print(lname,ent.SmoothHide[lname])
                                local val = ent:Animate(animvar,ent:GetPackedBool(var) and max or min,0,1,speed,false)
                                ent:ShowHideSmooth(lname,val)
                                if light then ent:SetLightPower(lname,val>0,val) end
                            end)
                        end
                    end
                end
                if config.lamps then
                    for k,lconfig in ipairs(config.lamps) do
                        local lname = name.."_lamp"..k
                        table.insert(panel.props,lname)
                        self.ClientProps[lname] = {
                            model = lconfig.model or "models/metrostroi/81-717/button07.mdl",
                            pos = Metrostroi.PositionFromPanel(id,config.pos or buttons.ID,(config.z or 0.2)+(lconfig.z or 0.2),(config.x or 0)+(lconfig.x or 0),(config.y or 0)+(lconfig.y or 0)),
                            ang = Metrostroi.AngleFromPanel(id,lconfig.ang or config.ang),
                            color = lconfig.color or config.color,
                            skin = lconfig.skin or config.skin or 0,
                            config = lconfig,
                            cabin = lconfig.cabin,
                            igrorepanel = true,
                            hide = panel.hide or config.hide,
                            hideseat = panel.hideseat or config.hideseat,
                            bscale = lconfig.bscale or config.bscale,
                            scale = lconfig.scale or config.scale,
                        }
                        if lconfig.var then
                            --ret=ret.."\""..lconfig.var.."\","
                            --reti = reti + 1
                            local var,animvar = lconfig.var,lname.."_anim"
                            local min,max = lconfig.min or 0,lconfig.max or 1
                            local speed = lconfig.speed or 10
                            local func = lconfig.getfunc
                            if func then
                                table.insert(self.AutoAnims, function(ent)
                                    local val = ent:Animate(animvar,func(ent,min,max,var),0,1,speed,false)
                                    ent:ShowHideSmooth(lname,val)
                                end)
                            else
                                table.insert(self.AutoAnims, function(ent)
                                    --print(lname,ent.SmoothHide[lname])
                                    local val = ent:Animate(animvar,ent:GetPackedBool(var) and max or min,0,1,speed,false)
                                    ent:ShowHideSmooth(lname,val)
                                end)
                            end
                        end
                    end
                end
                if config.sprite then
                    local sconfig = config.sprite

                    local hideName = sconfig.hidden or config.lamp and name.."_lamp" or name
                    self.Lights[sconfig.lamp or name] = { sconfig.glow and "glow" or "light",
                        Metrostroi.PositionFromPanel(id,config.pos or buttons.ID,(config.z or 0.5)+(sconfig.z or 0.2),(config.x or 0)+(sconfig.x or 0),(config.y or 0)+(sconfig.y or 0)),
                        Metrostroi.AngleFromPanel(id, sconfig.ang or config.ang)+Angle(90,0,0),
                        sconfig.color or sconfig.color,
                        brightness = sconfig.bright,texture=sconfig.texture or "sprites/light_glow02",scale=sconfig.scale or 0.02,vscale=sconfig.vscale,
                        size = sconfig.size,
                        hidden = hideName,
                        aa = sconfig.aa,panel = sconfig.panel ~= false,
                    }
                    local i
                    if sconfig.getfunc then
                        local func = sconfig.getfunc
                        i = table.insert(self.AutoAnims, function(ent)
                            local val = func(ent)
                            ent:SetLightPower(name,not ent.Hidden[hideName] and val>0,val)
                        end)
                    elseif sconfig.var then
                        --ret=ret.."\""..lconfig.var.."\","
                        --reti = reti + 1
                        local var,animvar = sconfig.var,name.."_sanim"
                        local speed = sconfig.speed or 10
                        i = table.insert(self.AutoAnims, function(ent)
                            local val = ent:Animate(animvar,ent:GetPackedBool(var) and 1 or 0,0,1,speed,false)
                            ent:SetLightPower(name,val>0,val)
                        end)
                    elseif sconfig.lamp then
                        local lightName = sconfig.lamp
                        i = table.insert(self.AutoAnims, function(ent)
                            local val = ent.Anims[lightName] and ent.Anims[lightName].value or 0
                            ent:SetLightPower(lightName,val>0,val)
                        end)
                    elseif config.lamp and config.lamp.var then
                        local lname = name.."_lamp"
                        local lightName = lname.."_anim"
                        i = table.insert(self.AutoAnims, function(ent)
                            local val = ent.Anims[lightName] and ent.Anims[lightName].value or 0
                            ent:SetLightPower(name,val>0,val)
                        end)
                    end
                    if not i then
                        ErrorNoHalt("Bad sprite "..name.."/"..hideName..", no controlable function...\n")
                    else
                        self.AutoAnimNames[i] = hideName
                    end
                end
                if config.labels then
                    for k,aconfig in ipairs(config.labels) do
                        local aname = name.."_label"..k
                        table.insert(panel.props,aname)
                        self.ClientProps[aname] = {
                            model = aconfig.model or "models/metrostroi/81-717/button07.mdl",
                            pos = Metrostroi.PositionFromPanel(id,config.pos or buttons.ID,(config.z or 0.2)+(aconfig.z or 0.2),(config.x or 0)+(aconfig.x or 0),(config.y or 0)+(aconfig.y or 0)),
                            ang = Metrostroi.AngleFromPanel(id,aconfig.ang or config.ang),
                            color = aconfig.color or config.color,
                            colora = aconfig.colora or config.colora,
                            skin = aconfig.skin or config.skin or 0,
                            config = aconfig,
                            cabin = aconfig.cabin,
                            igrorepanel = true,
                            hide = panel.hide or config.hide,
                            hideseat = panel.hideseat or config.hideseat,
                            bscale = aconfig.bscale or config.bscale,
                            scale = aconfig.scale or config.scale,
                        }
                    end
                end
                buttons.model = nil
            end
        end
    end
    for k,v in pairs(self.ClientProps) do
        if not v.model then continue end
        Metrostroi.PrecacheModels[v.model] = true
    end
    for k,v in pairs(self.Lights or {}) do
        if not v.hidden then continue end
        local cP = self.ClientProps[v.hidden]
        if not cP then ErrorNoHalt("No clientProp "..v.hidden.." in entity "..self.Folder.."\n") continue end
        if not cP.lamps then cP.lamps = {} end
        table.insert(cP.lamps,k)
    end
    --ret = ret.."\n}"
    --SetClipboardText(ret)
end
--[[
timer.Simple(1,function()
    for k,ent in pairs(Metrostroi.PrecacheModels) do
        if ent==true or not IsValid(ent) then
            local model = ClientsideModel(k)
            model:SetPos(LocalPlayer():GetPos())
            Metrostroi.PrecacheModels[k] = model
        end
    end
    timer.Simple(2,function()
        for k,ent in pairs(Metrostroi.PrecacheModels) do
            if IsValid(ent) then
                SafeRemoveEntity(ent)
            end
        end
    end)
end)]]

function Metrostroi.InsertHide(panel,prop_name)
    local self = ENT
    if self.ButtonMap[panel] then
        if not self.ButtonMap[panel].props then self.ButtonMap[panel].props = {} end
        table.insert(self.ButtonMap[panel].props,prop_name)
    end
end






--------------------------------------------------------------------------------
-- Training markers
--------------------------------------------------------------------------------
local prevV = 0
local A = 0
local D1true = 0
local D2true = 0
local prevTime
hook.Add("PostDrawOpaqueRenderables", "metrostroi-draw-stopmarker",function()
    prevTime = prevTime or RealTime()
    local dT = math.max(0.001,RealTime() - prevTime)
    prevTime = RealTime()

    -- Skip if disabled
    if GetConVar("metrostroi_stop_helper"):GetInt() ~= 1 then return end

    -- Get train
    local train = LocalPlayer().InMetrostroiTrain
    if not IsValid(train) then return end

    -- Calculate acceleration
    local V = train:GetNW2Float("V",train:GetVelocity():Length()*0.01905)*0.277778
    local newA = (V - prevV)/dT
    prevV = V

    -- Calculate marker position
    A = train:GetNW2Float("A",A + (newA - A)*1.0*dT)
    local T1 = math.abs(V/(A+1e-8))
    local T2 = math.abs(V/(1.2+1e-8))
    local D1 = T1*V + (T1^2)*A/2
    local D2 = T2*V + (T2^2)*A/2

    -- Smooth out D
    D1 = math.min(200,math.max(0,D1))*0.65
    D2 = math.min(200,math.max(0,D2))*0.70
    D1true = D1true + (D1 - D1true)*12.0*dT
    D2true = D2true + (D2 - D2true)*12.0*dT
    local offset1 = D1true/0.01905
    local offset2 = D2true/0.01905

    -- Draw marker
    if A > -0.1 then return end
--  if D1 > 195 then return end
    if D2 > 195 then return end
    local base_pos1 = train:LocalToWorld(Vector(500+offset1,80,10))
    cam.Start3D2D(base_pos1,train:LocalToWorldAngles(Angle(0,-90,90)),1.0)
        surface.SetDrawColor(255,255,255)
        surface.DrawRect(-1,-1,8*20+2,4+2)
        for i=0,19 do
            surface.SetDrawColor(240,200,40)
            surface.DrawRect(8*i+0,0,4,4)
            surface.SetDrawColor(0,0,0)
            surface.DrawRect(8*i+4,0,4,4)
        end
        surface.SetDrawColor(255,255,255)
        surface.DrawRect(-1,-96,2,192)
        surface.DrawRect(8*20,-96,2,192)

--      surface.SetTextColor(255,255,255)
--      surface.SetFont("Trebuchet24")
--      surface.SetTextPos(64-128,-30)
--      surface.DrawText(Format("%.1f m  %.1f m/s %.1f m/s2",D,V,A))
--      surface.SetTextPos(64,-30)
--      surface.DrawText(Format("%.1f m %.0f sec",D,T))
    cam.End3D2D()

    local base_pos2 = train:LocalToWorld(Vector(500+offset2,80,10))
    cam.Start3D2D(base_pos2,train:LocalToWorldAngles(Angle(0,-90,90)),1.0)
        surface.SetDrawColor(240,40,40)
        surface.DrawRect(-1,-1,8*20+2,4+2)
        for i=0,19 do
            surface.SetDrawColor(0,0,0)
            surface.DrawRect(8*i+0,0,4,4)
            surface.SetDrawColor(240,40,40)
            surface.DrawRect(8*i+4,0,4,4)
        end

        surface.SetDrawColor(240,40,40)
        surface.DrawRect(-1,-1+110,8*20+2,16+2)
        for i=0,19 do
            surface.SetDrawColor(0,0,0)
            surface.DrawRect(8*i+0,110,4,16)
            surface.SetDrawColor(240,40,40)
            surface.DrawRect(8*i+4,110,4,16)
        end

        surface.SetDrawColor(240,40,40)
        surface.DrawRect(-6,-96,6,192)
        surface.DrawRect(8*20,-96,4,192)
    cam.End3D2D()
end)




--------------------------------------------------------------------------------
-- Fix for gm_metrostroi 3D sky
--------------------------------------------------------------------------------
local player_state = {}
if string.sub(game.GetMap(),1,13) == "gm_metrostroi" then
    timer.Create("Metrostroi_3DSkyFix",1.0,0,function()
        local player = LocalPlayer()
        if not IsValid(player) then return end

        RunConsoleCommand("r_3dsky", (player:GetPos().z < -1024) and "0" or "1")
    end)
end

timer.Simple(0,function()
    net.Start("metrostroi_cam_update") net.SendToServer()
end)
net.Receive("metrostroi_cam_update",function()
    local ent = Entity(net.ReadUInt(16))
    Metrostroi.RTCamera = ent
end)

local CamRT = surface.GetTextureID( "pp/rt" )
local CamWork = GetConVar("metrostroi_drawcams")
Metrostroi.CamTimers = Metrostroi.CamTimers or {}
Metrostroi.CamQueue = Metrostroi.CamQueue or {}
function Metrostroi.RenderCamOnRT(train,cpos,name,time,RT,post,pos,ang,x,y,scale,xmin,ymin)
    if not CamWork then  CamWork = GetConVar("metrostroi_drawcams") return end
    if not CamWork:GetBool() then return end
    name = train:EntIndex()..name
    --print(name,Metrostroi.CamQueue[name])
    if (not Metrostroi.CamTimers[name] or RealTime()-Metrostroi.CamTimers[name] > time) and not Metrostroi.CamQueue[name] then
        Metrostroi.CamQueue[name] = table.insert(Metrostroi.CamQueue,{train,cpos,name,time,RT,post,pos,ang,x,y,scale,xmin,ymin})
    end
end
function Metrostroi.SetCamPosAng(pos,ang)
    if IsValid(Metrostroi.RTCamera) then
        Metrostroi.RTCamera:SetPos(pos)
        Metrostroi.RTCamera:SetAngles(ang)
    end
end
hook.Add("Think","metrostroi_camera_move",function()
    if IsValid(Metrostroi.RTCamera) then
        Metrostroi.RTCamera:SetPos(Vector(0,0,-2^16))
        Metrostroi.RTCamera:SetAngles(Angle(90,0,0))
    end
    if Metrostroi.RenderCam and Metrostroi.RenderedCam ~= RealTime() then
        local camera = Metrostroi.RenderCam
        Metrostroi.RenderCam = nil
        if IsValid(camera[1]) then
            local distance = camera[1]:LocalToWorld(camera[2]):DistToSqr(LocalPlayer():GetPos())
            if distance > 65536 then return end
            local x,y = camera[9],camera[10]
            local scale = camera[11] or 1
            local xmin,ymin = camera[12] or 0,camera[13] or 0
            render.PushRenderTarget(camera[5],0,0,x, y)
            render.Clear(0, 0, 0, 0)
            cam.Start2D()
                surface.SetTexture( CamRT )
                surface.SetDrawColor( 255, 255, 255, 255 )
                surface.DrawTexturedRectRotated((x/2-xmin)*scale,(y/2-ymin)*scale,x*scale,y*scale,0)
            cam.End2D()
            render.PopRenderTarget()
        else
        end
    end
    if #Metrostroi.CamQueue > 0 and not Metrostroi.RenderCam then
        local cam = table.remove(Metrostroi.CamQueue,1)
        Metrostroi.CamQueue[cam[3]] = nil
        local name,time,post,pos,ang = cam[3],cam[4],cam[6],cam[7],cam[8]
        if IsValid(post) then
            debugoverlay.Sphere(post:LocalToWorld(pos),1,time,Color( 150, 105, 200 ),true)
            debugoverlay.Text(post:LocalToWorld(pos),name,time,Color( 150, 105, 200 ),true)
            debugoverlay.Line(post:LocalToWorld(pos),post:LocalToWorld(pos)+post:LocalToWorldAngles(ang):Forward()*25,time,Color( 150, 105, 200 ),true)
            Metrostroi.RenderCam = cam
            Metrostroi.SetCamPosAng(post:LocalToWorld(cam[7]),post:LocalToWorldAngles(cam[8]))
            Metrostroi.CamTimers[cam[3]] = RealTime()
        end
    end
end)

local function rect_ol(x,y,w,h,c)
    Metrostroi.DrawLine(x-1,y,x+w,y,c)
    Metrostroi.DrawLine(x+w,y,x+w,y+h,c)
    Metrostroi.DrawLine(x,y+h,x+w,y+h,c)
    Metrostroi.DrawLine(x,y,x,y+h,c)
end

function Metrostroi.DrawLine(x1,y1,x2,y2,col,sz)
    surface.SetDrawColor(col)
    if x1 == x2 then
        -- vertical line
        local wid =  (sz or 1) / 2
        surface.DrawRect(x1-wid, y1, wid*2, y2-y1)
    elseif y1 == y2 then
        -- horizontal line
        local wid =  (sz or 1) / 2
        surface.DrawRect(x1, y1-wid, x2-x1, wid*2)
    else
        -- other lines
        local x3 = (x1 + x2) / 2
        local y3 = (y1 + y2) / 2
        local wx = math.sqrt((x2-x1) ^ 2 + (y2-y1) ^ 2)
        local angle = math.deg(math.atan2(y1-y2, x2-x1))
        draw.NoTexture()
        surface.DrawTexturedRectRotated(x3, y3, wx, (sz or 1), angle)
    end
end
function Metrostroi.DrawRectOutline(x,y,w,h,col,sz)
    local wid = sz or 1
    if wid < 0 then
        for i=0, wid+1, -1 do
            rect_ol(x+i, y+i, w-2*i, h-2*i, col)
        end
    elseif wid > 0 then
        for i=0, wid-1 do
            rect_ol(x+i, y+i, w-2*i, h-2*i, col)
        end
    end
end

function Metrostroi.DrawRectOL(x,y,w,h,col,sz,col1)
    local wid = sz or 1
    if wid < 0 then
        for i=0, wid+1, -1 do
            rect_ol(x+i, y+i, w-2*i, h-2*i, col)
        end
    elseif wid > 0 then
        for i=0, wid-1 do
            rect_ol(x+i, y+i, w-2*i, h-2*i, col)
        end
    end
    surface.SetDrawColor(col1)
    surface.DrawRect(x+math.max(0,sz-1),y+math.max(0,sz-1),w-math.max(0,(sz-0.5)*2),h-math.max(0,(sz-0.5)*1.5))
end

function Metrostroi.DrawTextRect(x,y,w,h,col,mat)
    surface.SetDrawColor(col)
    surface.SetMaterial(mat)
    surface.DrawTexturedRect(x,y,w,h)
end

function Metrostroi.DrawTextRectOL(x,y,w,h,col,mat,sz,col1)
    local wid = sz or 1
    if wid < 0 then
        for i=0, wid+1, -1 do
            rect_ol(x+i, y+i, w-2*i, h-2*i, col1)
        end
    elseif wid > 0 then
        for i=0, wid-1 do
            rect_ol(x+i, y+i, w-2*i, h-2*i, col1)
        end
    end
    surface.SetDrawColor(col)
    surface.DrawRect(x+math.max(0,sz-1),y+math.max(0,sz-1),w-math.max(0,(sz-0.5)*2),h-math.max(0,(sz-0.5)*1.5))
    surface.SetDrawColor(Color(col.r - 40,col.g - 40,col.b - 40))
    surface.SetMaterial(mat)
    surface.DrawTexturedRect(x+math.max(0,sz-1),y+math.max(0,sz-1),w-math.max(0,(sz-0.5)*2),h-math.max(0,(sz-0.5)*2))
end


local function recurePrecache(sound)
    if type(sound) == "table" then
        for k,snd in pairs(sound) do recurePrecache(snd) end
    elseif type(sound) == "string" then
        util.PrecacheSound(sound)
    end
end
local function util_PrecacheSound(dir)
    local files,dirs = file.Find(dir.."/*","GAME")
    for _, fdir in pairs(dirs) do
        util_PrecacheSound(dir.."/"..fdir)
    end

    for _,v in pairs(files) do
        util.PrecacheSound(dir.."/"..v)
    end
end
--util_PrecacheSound("sound/subway_trains")
matproxy.Add{
    name = "TrainBodyColor",
    init = function( self, mat, values )
        -- Store the name of the variable we want to set
        if values then self._MATresultVarC = values.resultvar end
    end,
    bind = function( self, mat, ent )
        if ( self._MATresultVarC and ent.GetBodyColor ) then
            mat:SetVector( self._MATresultVarC, ent:GetBodyColor() )
        end
    end
}
matproxy.Add{
    name = "TrainBodyDecal",
    init = function( self, mat, values )
        -- Store the name of the variable we want to set
        if values then self._MATresultVarD = values.resultvar end
    end,
    bind = function( self, mat, ent )
        if ( self._MATresultVarD and ent.GetDirtLevel ) then
            mat:SetFloat( self._MATresultVarD, ent:GetDirtLevel() )
        end
    end
}

Metrostroi.RenderTargetNames = {
    "ASNP","IGLA","PUAV","PAM","Vityaz","Tickers","Sarmat","Cam1","Cam2","Cam3","Cam4",
}
function Metrostroi.AddCaptureRTName(name)
    if not table.HasValue(Metrostroi.RenderTargetNames,name) then
        table.insert(Metrostroi.RenderTargetNames,name)
    end
end

concommand.Add("metrostroi_capture_rt",function(_,_,args)
    local RTs = #args > 0 and args or Metrostroi.RenderTargetNames

    local train = LocalPlayer().InMetrostroiTrain
    if not IsValid(train) then return end

    local oldRt = render.GetRenderTarget() -- we'll save the old screen and draw on a new one!
    file.CreateDir("rt_captures")
    for i,v in ipairs(RTs) do
        local RT = train[v]
        if RT and type(RT) == "ITexture" then

            render.SetRenderTarget( train[v] )

            local data = render.Capture( { format = "png", quality = 100, x = 0, y = 0, h = RT:Height(), w = RT:Width() } )

            local pictureFile = file.Open("rt_captures/"..train:EntIndex().." "..v.." "..os.date("!%d%m%y_%H%M%S",os.time())..".png", "wb", "DATA" )
            pictureFile:Write( data )
            pictureFile:Close()
        end
    end

    render.SetRenderTarget( oldRt )
end)

--------------------------------------------------------------------------------
-- Player meta table magic
-- Author: HunterNL
--------------------------------------------------------------------------------
local Player = FindMetaTable("Player")

function Player:GetTrain()
    local seat = self:GetVehicle()
    if IsValid(seat) then
        return seat:GetNW2Entity("TrainEntity"),seat
    end
end
hook.Add("Think","MetrostroiGetTrain",function()
    local ply = LocalPlayer()
    local train = ply:GetTrain()
    if IsValid(train) then
        ply.InMetrostroiTrain =  train
    else
        ply.InMetrostroiTrain = false
    end
end)

RunConsoleCommand("r_rootlod",0) -- Train models only visible with High model quality

local matSprite = {
    ["$basetexture"] = "",
    ["$spriteorientation"] = "vp_parallel",
    ["$spriteorigin"] = "[ 0.50 0.50 ]",
    ["$illumfactor"] = 7,
    ["$spriterendermode"] = 3,
}
local matUnlit = {
    ["$basetexture"] = "",
    ["$translucent"]= 1,
    ["$additive"] = 1,
    ["$vertexcolor"] = 1,
    --["$vertexalpha"] = 1,
}
Metrostroi.SpriteCache1 = Metrostroi.SpriteCache1 or {}
Metrostroi.SpriteCache2 = Metrostroi.SpriteCache2 or {}
function Metrostroi.MakeSpriteTexture(path,isSprite)
    if isSprite then
        if Metrostroi.SpriteCache1[path] then return Metrostroi.SpriteCache1[path] end
        matSprite["$basetexture"] = path
        Metrostroi.SpriteCache1[path] = CreateMaterial(path..":sprite","Sprite",matSprite)
        return Metrostroi.SpriteCache1[path]
    else
        if Metrostroi.SpriteCache1[path] then return Metrostroi.SpriteCache1[path] end
        matUnlit["$basetexture"] = path
        Metrostroi.SpriteCache2[path] = CreateMaterial(path..":spriteug","UnlitGeneric",matUnlit)
        return Metrostroi.SpriteCache2[path]
    end
end
--------------------------------------------------------------------------------
-- Add skins function
--  category - a skin category(pass, cab, train)
--  name - name of skin(must be unique) or skin table(table must have a name)
--  tbl - skin table
-- Skin table:
-- {
--      typ = "81-717_spb", (it's a gmod_subway_*(gmod_subway_81-717_spb))
--      name = "NAME",(or you can send name to function)
--  textures = {
--          texture_name = "path_to_texture",
--          b01a = "myskin/mycoolskin",
--  }
-- }
-- List of trains and manufacturers:
-- 81-502
-- 81-702
-- 81-703
-- 81-707
-- 81-710
-- 81-717_msk
-- 81-717_spb
-- 81-718
-- 81-720
-- 81-722
--------------------------------------------------------------------------------

Metrostroi.AddSkin("train","Def_502Def",{
    name = "Default",
    typ = "81-502",
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        local colType = math.Round(math.Rand(1,2))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.4*math.random())*bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright-(0.1-0.4*math.random())*bright,bright,bright))
        end
    end,
    def=true,
})
Metrostroi.AddSkin("pass","Def_502Def",{
    name = "Default",
    typ = "81-502",
    textures = {},
    def=true,
})
Metrostroi.AddSkin("cab","Def_502Def",{
    name = "Default",
    typ = "81-502",
    textures = {},
    def=true,
})
Metrostroi.AddSkin("train","Def_702",{
    name = "Green",
    typ = "81-702",
    textures = {
        body_green = "models/metrostroi_train/81-702/body_green",
        body = "models/metrostroi_train/81-702/body_green",
    },
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        local colType = math.Round(math.Rand(1,2))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.4*math.random())*bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright,bright-(0.1-0.2*math.random())*bright,bright))
        end
    end
})
Metrostroi.AddSkin("train","Def_702Blue",{
    name = "Blue",
    typ = "81-702",
    textures = {
        body_green = "models/metrostroi_train/81-702/body_blue",
        body = "models/metrostroi_train/81-702/body_blue",
    },
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        local colType = math.Round(math.Rand(1,2))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.4*math.random())*bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright-(0.1-0.4*math.random())*bright,bright,bright))
        end
    end
})
Metrostroi.AddSkin("train","Def_702Random",{
    name = "Random",
    typ = "81-702",
    func = function(ent)
        local tbl = {}
        for k,v in pairs(Metrostroi.Skins.train) do
            if not v.norandom and v.typ == "81-702" and not v.norandom then
                table.insert(tbl,k)
            end
        end
        return table.Random(tbl)
    end,
    def=true,
    norandom = true,
})
Metrostroi.AddSkin("pass","Def_702Def",{
    name = "Default",
    typ = "81-702",
    textures = {},
    def=true,
})
Metrostroi.AddSkin("cab","Def_702Def",{
    name = "Default",
    typ = "81-702",
    textures = {},
    def=true,
})

Metrostroi.AddSkin("train","Def_703L1",{
    name = "Line 1 (Blue)",
    typ = "81-703",
    textures = {
        ["710_green3"] = "models/metrostroi_train/81-703/81-703_line1",
    },
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        local colType = math.Round(math.Rand(1,2))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.4*math.random())*bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright-(0.1-0.4*1)*bright,bright,bright))
        end
    end,
    rnd = 1,
})
Metrostroi.AddSkin("train","Def_703L2",{
    name = "Line 2 (Green)",
    typ = "81-703",
    textures = {
        ["710_green3"] = "models/metrostroi_train/81-703/81-703_line2",
    },
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        local colType = math.Round(math.Rand(1,2))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.3*math.random())*bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright,bright-(0.1-0.3*math.random())*bright,bright))
        end
    end,
    rnd = 1,
})
Metrostroi.AddSkin("train","Def_703L3",{
    name = "Line 3 (Green)",
    typ = "81-703",
    textures = {
        ["710_green3"] = "models/metrostroi_train/81-703/81-703_line3",
    },
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        local colType = math.Round(math.Rand(1,2))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.3*math.random())*bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright,bright-(0.1-0.3*math.random())*bright,bright))
        end
    end,
    rnd = 1,
})
Metrostroi.AddSkin("train","Def_703L4",{
    name = "Line 4 (Blue)",
    typ = "81-703",
    textures = {
        ["710_green3"] = "models/metrostroi_train/81-703/81-703_line4",
    },
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        local colType = math.Round(math.Rand(1,2))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.4*math.random())*bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright-(0.1-0.4*math.random())*bright,bright,bright))
        end
    end,
    rnd = 1,
})
Metrostroi.AddSkin("train","Def_703SPB",{
    name = "SPB",
    typ = "81-703",
    textures = {
        ["710_green3"] = "models/metrostroi_train/81-703/ema502_body",
    },
    --[[ postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright))
        local colType = math.Round(math.Rand(1,2))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.3*math.random())*bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright,bright-(0.1-0.3*math.random())*bright,bright))
        end
    end,]]
})
Metrostroi.AddSkin("train","Def_703Random1",{
    name = "Random",
    typ = "81-703",
    func = function(ent)
        local tbl = {}
        for k,v in pairs(Metrostroi.Skins.train) do
            if v.rnd==1 and v.typ == "81-703" and not v.norandom then
                table.insert(tbl,k)
            end
        end
        return table.Random(tbl)
    end,
    def=true,
    norandom = true,
})
Metrostroi.AddSkin("pass","Def_703Def",{
    name = "Default",
    typ = "81-703",
    textures = {},
    def=true,
})
Metrostroi.AddSkin("cab","Def_703Def",{
    name = "Default",
    typ = "81-703",
    textures = {},
    def=true,
})


Metrostroi.AddSkin("train","Def_710GR1",{
    name = "Line1 (Green)",
    typ = "81-710",
    textures = {
        ["710_green3"] = "models/metrostroi_train/81-710/710_green1",
		["508t_green3"] = "models/metrostroi_train/81-710/508t_green1",
    },
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        local colType = math.Round(math.Rand(1,2))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.3*math.random())*bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright,bright-(0.1-0.3*math.random())*bright,bright))
        end
    end,
    rnd = true,
})
Metrostroi.AddSkin("train","Def_710GR2",{
    name = "Line 7 (Green)",
    typ = "81-710",
    textures = {
        ["710_green3"] = "models/metrostroi_train/81-710/710_green2",
		["508t_green3"] = "models/metrostroi_train/81-710/508t_green2",
    },
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        local colType = math.Round(math.Rand(1,2))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.3*math.random())*bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright,bright-(0.1-0.3*math.random())*bright,bright))
        end
    end,
    rnd = true,
})
Metrostroi.AddSkin("train","Def_710BL1",{
    name = "Line 7 (Blue)",
    typ = "81-710",
    textures = {
        ["710_green3"] = "models/metrostroi_train/81-710/710_blue",
        ["508t_green3"] = "models/metrostroi_train/81-710/508t_blue",
    },
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        local colType = math.Round(math.Rand(1,2))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.4*math.random())*bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright-(0.1-0.4*math.random())*bright,bright,bright))
        end
    end,
    rnd = true,
})
Metrostroi.AddSkin("train","Def_710ev3",{
    name = "Budapest Ev3 (Blue)",
    typ = "81-710",
    textures = {
        ["710_green3"] = "models/metrostroi_train/81-710/710_ev3",
        ["508t_green3"] = "models/metrostroi_train/81-710/508t_ev3",
    },
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        local colType = math.Round(math.Rand(1,2))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.3*math.random())*bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright,bright-(0.1-0.3*math.random())*bright,bright))
        end
    end,
    norandom = true,
})
Metrostroi.AddSkin("train","Def_710ecs",{
    name = "Echs (81-709)",
    typ = "81-710",
    textures = {
        ["710_green3"] = "models/metrostroi_train/81-710/710_echs",
        ["508t_green3"] = "models/metrostroi_train/81-710/508t_echs",
    },
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright))
    end,
    norandom = true,
})
Metrostroi.AddSkin("train","Def_710Native",{
    name = "Line 7 (Dark)",
    typ = "81-710",
    textures = {
    },
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        local colType = math.Round(math.Rand(1,2))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.4*math.random())*bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright-(0.1-0.4*math.random())*bright,bright,bright))
        end
    end,
    rnd = true,
})
Metrostroi.AddSkin("train","Def_710Random",{
    name = "Random",
    typ = "81-710",
    func = function(ent)
        local tbl = {}
        for k,v in pairs(Metrostroi.Skins.train) do
            if not v.norandom and v.typ == "81-710" and v.rnd then
                table.insert(tbl,k)
            end
        end
        local tex = table.Random(tbl)
        return tex
    end,
    norandom = true,
    def=true,
})
---Eж3 салоны
Metrostroi.AddSkin("pass","Def_710pass1",{
    name = "Green interior 1971",
    typ = "81-710",
    textures = {
        ["int0"] = "models/metrostroi_train/81-710/int0_green",
        ["kvkm"] = "models/metrostroi_train/81-710/kvkm_plastic",
    },
    rnd=true,
})
Metrostroi.AddSkin("pass","Def_710pass2",{
    name = "Wood 1980",
    typ = "81-710",
    textures = {
        ["int0"] = "models/metrostroi_train/81-710/int0_wood",
        ["kvkm"] = "models/metrostroi_train/81-710/kvkm_plastic",
    },
    rnd=true,
})

Metrostroi.AddSkin("pass","Def_710pass3",{
    name = "Wood KVR",
    typ = "81-710",
    textures = {
        ["int0"] = "models/metrostroi_train/81-710/int0_wood1",
        ["kvkm"] = "models/metrostroi_train/81-710/kvkm_plastic",
    },
    rnd=true,
})

Metrostroi.AddSkin("pass","Def_710pass4",{
    name = "Dark-wood interior",
    typ = "81-710",
    textures = {
        ["int0"] = "models/metrostroi_train/81-710/int0_wood2",
    },
    rnd=true,
})


Metrostroi.AddSkin("pass","Def_710pass1",{
    name = "White plastic",
    typ = "81-710",
    textures = {
    },
    rnd=true,
})
Metrostroi.AddSkin("pass","Def_710Random",{
    name = "Random",
    typ = "81-710",
    func = function(ent)
        local tbl = {}
        for k,v in pairs(Metrostroi.Skins.pass) do
            if not v.norandom and v.typ == "81-710" and v.rnd then
                table.insert(tbl,k)
            end
        end
        local tex = table.Random(tbl)
        return tex
    end,
    norandom = true,
    def=true,
})
---Eж3 кабины
Metrostroi.AddSkin("cab","Def_710cab1",{
    name = "Wood",
    typ = "81-710",
    textures = {
        ["cab"] = "models/metrostroi_train/81-710/cab_wood",
    },
    rnd=true
})
Metrostroi.AddSkin("cab","Def_710cab2",{
    name = "Classic",
    typ = "81-710",
    textures = {},
    rnd=true
})
Metrostroi.AddSkin("cab","Def_710Random",{
    name = "Random",
    typ = "81-710",
    func = function(ent)
        local tbl = {}
        for k,v in pairs(Metrostroi.Skins.cab) do
            if not v.norandom and v.typ == "81-710" and v.rnd then
                table.insert(tbl,k)
            end
        end
        local tex = table.Random(tbl)
        return tex
    end,
    norandom = true,
    def=true,
})


--81-707
Metrostroi.AddSkin("train","Def_707L1",{
    name = "Line1 (Blue)",
    typ = "81-707",
    textures = {
        ["710_green3"] = "models/metrostroi_train/81-707/81-707_line1",
        ["508t_green3"] = "models/metrostroi_train/81-710/81-509_line1",
    },
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        local colType = math.Round(math.Rand(1,2))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.4*math.random())*bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright-(0.1-0.4*1)*bright,bright,bright))
        end
    end
})
Metrostroi.AddSkin("train","Def_707L2",{
    name = "Line2 (Green)",
    typ = "81-707",
    textures = {
        ["710_green3"] = "models/metrostroi_train/81-707/81-707_line2",
        ["508t_green3"] = "models/metrostroi_train/81-710/81-509_line2",
    },
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        local colType = math.Round(math.Rand(1,2))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.3*math.random())*bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright,bright-(0.1-0.3*math.random())*bright,bright))
        end
    end
})
Metrostroi.AddSkin("train","Def_707L3",{
    name = "Line3 (Blue)",
    typ = "81-707",
    textures = {
        ["710_green3"] = "models/metrostroi_train/81-707/81-707_line3",
        ["508t_green3"] = "models/metrostroi_train/81-710/81-509_line3",
    },
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        local colType = math.Round(math.Rand(1,2))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.3*math.random())*bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright,bright-(0.1-0.3*math.random())*bright,bright))
        end
    end
})
Metrostroi.AddSkin("train","Def_707L4",{
    name = "Line4 (Blue)",
    typ = "81-707",
    textures = {
        ["710_green3"] = "models/metrostroi_train/81-707/81-707_line4",
        ["508t_green3"] = "models/metrostroi_train/81-710/81-509_line4",
    },
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        local colType = math.Round(math.Rand(1,2))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.4*math.random())*bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright-(0.1-0.4*math.random())*bright,bright,bright))
        end
    end
})
Metrostroi.AddSkin("train","Def_707Random",{
    name = "Random",
    typ = "81-707",
    func = function(ent)
        local tbl = {}
        for k,v in pairs(Metrostroi.Skins.train) do
            if not v.norandom and v.typ == "81-707" then
                table.insert(tbl,k)
            end
        end
        local tex = table.Random(tbl)
        return tex
    end,
    norandom = true,
    def=true,
})
Metrostroi.AddSkin("train","Def_710M1",{
    name = "Budapest Ev (Dark Blue)",
    typ = "81-710",
    textures = {
        ["710_green3"] = "models/metrostroi_train/81-707/81-707_m1",
        ["508t_green3"] = "models/metrostroi_train/81-710/81-509_m1",
    },
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        local colType = math.Round(math.Rand(1,3))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.3*math.random())*bright))
        elseif colType == 2 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright-(0.1-0.3*math.random())*bright,bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright-(0.1-0.3*math.random())*bright,bright,bright))
        end
    end,
    norandom = true,
})
---Eж и Еж1 салоны
Metrostroi.AddSkin("pass","Def_707pass2",{
    name = "Blue interior 1970",
    typ = "81-707",
    textures = {
        ["int0"] = "models/metrostroi_train/81-710/int0_blue",
    }
})

Metrostroi.AddSkin("pass","Def_707pass3",{
    name = "Green interior 1971",
    typ = "81-707",
    textures = {
        ["int0"] = "models/metrostroi_train/81-710/int0_green",
    },
    norandom = true,
})

Metrostroi.AddSkin("pass","Def_707pass4",{
    name = "Wood interior 1980",
    typ = "81-707",
    textures = {
        ["int0"] = "models/metrostroi_train/81-710/int0_wood",
    }
})

Metrostroi.AddSkin("pass","Def_707pass5",{
    name = "Wood interior classic",
    typ = "81-707",
    textures = {
        ["int0"] = "models/metrostroi_train/81-710/int0_wood1",
    }
})

Metrostroi.AddSkin("pass","Def_707pass6",{
    name = "Dark Wood 1990",
    typ = "81-707",
    textures = {
        ["int0"] = "models/metrostroi_train/81-710/int0_wood2",
    }
})

Metrostroi.AddSkin("pass","Def_707pass1",{
    name = "White plastic 1972",
    typ = "81-707",
    textures = {
    }
})

Metrostroi.AddSkin("pass","Def_707Random",{
    name = "Random",
    typ = "81-707",
    func = function(ent)
        local tbl = {}
        for k,v in pairs(Metrostroi.Skins.pass) do
            if not v.norandom and v.typ == "81-707" and k ~= "Def_707Random" then
                table.insert(tbl,k)
            end
        end
        local tex = table.Random(tbl)
        return tex
    end,
    def=true,
})
Metrostroi.AddSkin("cab","Def_707Def",{
    name = "Default",
    typ = "81-707",
    textures = {},
    def=true,
})



Metrostroi.AddSkin("train","Def_717MSKClassic1",{
    name = "Line 1",
    typ = "81-717_msk",
    textures = {
        ["717_classic1"] = "models/metrostroi_train/81-717/717_classic1",
        ["717_kvr"] = "models/metrostroi_train/81-717/717_classic1",
    },
    random = true,
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        local colType = 2--math.Round(math.Rand(1,2))
        if colType == 1 then
            ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.1-0.2*math.random())*bright))
        else
            ent:SetNW2Vector("BodyColor",Vector(bright-(0.05-0.2*math.random())*bright,bright,bright))
        end
    end
})
Metrostroi.AddSkin("train","Def_717MSKClassic3",{
    name = "Line 5",
    typ = "81-717_msk",
    textures = {
        ["717_classic1"] = "models/metrostroi_train/81-717/717_classic3",
        ["717_kvr"] = "models/metrostroi_train/81-717/717_classic3",
    },
    random = true,
    postfunc = function(ent)
        local bright = math.Rand(1,1.1)
        ent:SetNW2Vector("BodyColor",Vector(bright,bright,bright-(0.05-0.2*math.random())*bright))
    end,
    def=true,
})
Metrostroi.AddSkin("pass","Def_717MSKBlue",{
    name = "Blue interior",
    typ = "81-717_msk",
    textures = {
        color_blue = "models/metrostroi_train/81-717/color_blue",
    },
    random = true,
})
Metrostroi.AddSkin("pass","Def_717MSKWhite",{
    name = "White interior",
    typ = "81-717_msk",
    textures = {
        color_blue = "models/metrostroi_train/81-717/color_white",
    },
    random = true,
})
Metrostroi.AddSkin("pass","Def_717MSKWood",{
    name = "Wood interior",
    typ = "81-717_msk",
    textures = {
        color_blue = "models/metrostroi_train/81-717/color_wood2",
    },
    random = true,
})

Metrostroi.AddSkin("pass","Def_717MSKWood3",{
    name = "Wood interior 2",
    typ = "81-717_msk",
    textures = {
        color_blue = "models/metrostroi_train/81-717/color_wood4",
    },
    random = true,
})

Metrostroi.AddSkin("pass","Def_717MSKWood2",{
    name = "Light-Wood interior",
    typ = "81-717_msk",
    textures = {
        color_blue = "models/metrostroi_train/81-717/color_wood3",
    },
    random = true,
})
Metrostroi.AddSkin("train","Def_717Random",{
    name = "Random",
    typ = "81-717_msk",
    func = function(ent)
        local tbl = {}
        for k,v in pairs(Metrostroi.Skins.train) do
            if v.typ == "81-717_msk" and v.random then
                table.insert(tbl,k)
            end
        end
        return table.Random(tbl)
    end,
    def=true,
})

Metrostroi.AddSkin("cab","Def_ClassicG",{
    name = "Variant 1",--"Classic + Gray body",
    typ = "81-717_msk",
    textures = {
        p_m_classic = "metrostroi_train/81-717/pult/p_m_classic",
        p_b_gray = "models/metrostroi_train/81-717/pult/p_b_gray",
    },
    def=true,
})
Metrostroi.AddSkin("cab","Def_ClassicY",{
    name = "Variant 2",--"Classic + Yellow body",
    typ = "81-717_msk",
    textures = {
        p_m_classic = "metrostroi_train/81-717/pult/p_m_classic",
        p_b_gray = "models/metrostroi_train/81-717/pult/p_b_yellow",
    },
    def=true,
})
Metrostroi.AddSkin("cab","Def_HammeriteG",{
    name = "Variant 3",--"Hammerite + Gray body",
    typ = "81-717_msk",
    textures = {
        p_m_classic = "models/metrostroi_train/81-717/pult/pult_hammerite",
        p_b_gray = "models/metrostroi_train/81-717/pult/p_b_gray",
    },
    def=true,
})
Metrostroi.AddSkin("cab","Def_HammeriteY",{
    name = "Variant 4",--"Hammerite + Yellow body",
    typ = "81-717_msk",
    textures = {
        p_m_classic = "models/metrostroi_train/81-717/pult/pult_hammerite",
        p_b_gray = "models/metrostroi_train/81-717/pult/p_b_yellow",
    },
    def=true,
})

Metrostroi.AddSkin("train","Def_717SPBDef",{
    name = "Default",
    typ = "81-717_spb",
    textures = {
        ["717_kvr"] = "models/metrostroi_train/81-717/717_kvr",
    },
    def=true,
})
Metrostroi.AddSkin("train","Def_717SPBWDef",{
    name = "Default w. white doors",
    typ = "81-717_spb",
    textures = {
        ["717_kvr"] = "models/metrostroi_train/81-717/skins/whitedoors",
    },
    def=true,
})

Metrostroi.AddSkin("pass","Def_717SPBWhite",{
    name = "White interior",
    typ = "81-717_spb",
    textures = {
        color_blue = "models/metrostroi_train/81-717/skins/color_white",
        interior_mvm = "models/metrostroi_train/81-717/interior_spb",
    },
})
Metrostroi.AddSkin("pass","Def_717SPBWhite2",{
    name = "White interior (KVR)",
    typ = "81-717_spb",
    textures = {
        color_blue = "models/metrostroi_train/81-717/skins/color_white",
        interior_mvm = "models/metrostroi_train/81-717/skins/interior_spb3",
    },
})

Metrostroi.AddSkin("pass","Def_717SPBCyanF",{
    name = "Cyan interior full",
    typ = "81-717_spb",
    textures = {
        color_blue = "models/metrostroi_train/81-717/skins/color_cian_full",
        interior_mvm = "models/metrostroi_train/81-717/skins/interior_spb"--[[..floor]],--ГЛЕб!!! флур=1 - дефолт, флур=2 -пиздаредко, запили рандом с вероятностью в не более 10% для флур2
    },
})
for i=1,5 do
    Metrostroi.AddSkin("pass","Def_717SPBCyanP"..i,{
        name = "Cyan interior partially"..i,
        typ = "81-717_spb",
        textures = {
            color_blue = "models/metrostroi_train/81-717/skins/color_cian_partly"..i,
            interior_mvm = "models/metrostroi_train/81-717/skins/interior_spb"--[[..floor]],--ГЛЕб!!! флур=1 - дефолт, флур=2 -пиздаредко, запили рандом с вероятностью в не более 10% для флур2
        },
    })
end
Metrostroi.AddSkin("pass","Def_717SPBGreenF",{
    name = "Green interior full",
    typ = "81-717_spb",
    textures = {
        color_blue = "models/metrostroi_train/81-717/skins/color_green_full",
        interior_mvm = "models/metrostroi_train/81-717/skins/interior_spb",
    },
})
for i=1,6 do
    Metrostroi.AddSkin("pass","Def_717SPBGreenP"..i,{
        name = "Green interior partially"..i,
        typ = "81-717_spb",
        textures = {
            color_blue = "models/metrostroi_train/81-717/skins/color_green_partly"..i,
            interior_mvm = "models/metrostroi_train/81-717/skins/interior_spb",
        },
    })
end

Metrostroi.AddSkin("pass","Def_717SPBWoodDark",{
    name = "Dark-Wood interior",
    typ = "81-717_spb",
    textures = {
        color_blue = "models/metrostroi_train/81-717/skins/color_wood_dark",
        interior_mvm = "models/metrostroi_train/81-717/skins/interior_spb",
    },
})

Metrostroi.AddSkin("pass","Def_717SPBWoodLight1",{
    name = "Light-Wood, dark ceiling",
    typ = "81-717_spb",
    textures = {
        color_blue = "models/metrostroi_train/81-717/skins/color_wood_light1",
        interior_mvm = "models/metrostroi_train/81-717/skins/interior_spb",
    },
})
Metrostroi.AddSkin("pass","Def_717SPBWoodLight2",{
    name = "Light-Wood, white ceiling",
    typ = "81-717_spb",
    textures = {
        color_blue = "models/metrostroi_train/81-717/skins/color_wood_light2",
        interior_mvm = "models/metrostroi_train/81-717/skins/interior_spb",
    },
})


Metrostroi.AddSkin("cab","Def_YellowOY",{
    name = "Yellow old + Yellow body",
    typ = "81-717_spb",
    textures = {
        pult_panel_yellow_old = "models/metrostroi_train/81-717/pult/pult_panel_yellow_old",
        p_b_yellow = "models/metrostroi_train/81-717/pult/p_b_yellow",
    },
    def=true,
})
Metrostroi.AddSkin("cab","Def_YellowOG",{
    name = "Yellow old + Gray body",
    typ = "81-717_spb",
    textures = {
        pult_panel_yellow_old = "models/metrostroi_train/81-717/pult/pult_panel_yellow_old",
        p_b_yellow = "models/metrostroi_train/81-717/pult/p_b_gray_spb",
    },
    def=true,
})
--[[
Metrostroi.AddSkin("cab","Def_YellowNY",{
    name = "Yellow new + Yellow body",
    typ = "81-717_spb",
    textures = {
        pult_panel_yellow_old = "models/metrostroi_train/81-717/pult/pult_panel_yellow_new",
        p_b_yellow = "models/metrostroi_train/81-717/pult/p_b_yellow",
    },
})
Metrostroi.AddSkin("cab","Def_YellowNG",{
    name = "Yellow new + Gray body",
    typ = "81-717_spb",
    textures = {
        pult_panel_yellow_old = "models/metrostroi_train/81-717/pult/pult_panel_yellow_new",
        p_b_yellow = "models/metrostroi_train/81-717/pult/p_b_gray_spb",
    },
})]]
Metrostroi.AddSkin("cab","Def_Gray",{
    name = "Gray",
    typ = "81-717_spb",
    textures = {
        pult_panel_yellow_old = "models/metrostroi_train/81-717/pult/pult_panel_spb_gray",
        p_b_yellow = "models/metrostroi_train/81-717/pult/p_b_gray_spb",
        p_ars_yellow = "models/metrostroi_train/81-717/pult/p_ars",
    },
    puav=true,
})
Metrostroi.AddSkin("cab","Def_Yellow",{
    name = "Yellow + Yellow body",
    typ = "81-717_spb",
    textures = {
        pult_panel_yellow_old = "models/metrostroi_train/81-717/pult/pult_panel_yellow_old",
        p_b_yellow = "models/metrostroi_train/81-717/pult/p_b_yellow",
        p_ars_yellow = "models/metrostroi_train/81-717/pult/p_ars_yellow",
    },
    puav=true,
})
Metrostroi.AddSkin("cab","Def_Blue",{
    name = "Blue",
    typ = "81-717_spb",
    textures = {
        pult_panel_yellow_old = "models/metrostroi_train/81-717/pult/pult_panel_spb_blue",
        p_b_yellow = "models/metrostroi_train/81-717/pult/p_b_gray_blue",
        p_ars_yellow = "models/metrostroi_train/81-717/pult/p_ars_blue",
    },
    paksdo=true,
})
Metrostroi.AddSkin("cab","Def_Yellow2",{
    name = "Yellow KSD",
    typ = "81-717_spb",
    textures = {
        pult_panel_yellow_old = "models/metrostroi_train/81-717/pult/pult_panel_spb_blue",
        p_b_yellow = "models/metrostroi_train/81-717/pult/p_b_gray",
        p_ars_yellow = "models/metrostroi_train/81-717/pult/p_ars_yellow",
    },
    paksdn=true,
})
Metrostroi.AddSkin("cab","Def_PUAV",{
    name = "PUAV",
    typ = "81-717_spb",
    func = function(ent)
        local tbl = {}
        for k,v in pairs(Metrostroi.Skins.cab) do
            if v.typ == "81-717_spb" and v.puav then
                table.insert(tbl,k)
            end
        end
        return table.Random(tbl)
    end,
})
Metrostroi.AddSkin("cab","Def_PAKSD",{
    name = "PAKSD",
    typ = "81-717_spb",
    func = function(ent)
        local tbl = {}
        for k,v in pairs(Metrostroi.Skins.cab) do
            if v.typ == "81-717_spb" and v.paksdo then
                table.insert(tbl,k)
            end
        end
        return table.Random(tbl)
    end,
})
Metrostroi.AddSkin("cab","Def_PAKSD2",{
    name = "PAKSD",
    typ = "81-717_spb",
    func = function(ent)
        local tbl = {}
        for k,v in pairs(Metrostroi.Skins.cab) do
            if v.typ == "81-717_spb" and v.paksdn then
                table.insert(tbl,k)
            end
        end
        return table.Random(tbl)
    end,
})


Metrostroi.AddSkin("train","Def_718Def",{
    name = "Default",
    typ = "81-718",
    textures = {},
    rnd=true,
})
Metrostroi.AddSkin("pass","Def_718Wood2",{
    name = "Wood",
    typ = "81-718",
    textures = {
        color_blue = "models/metrostroi_train/81-717/color_wood3",
    },
    rnd=true,
})


Metrostroi.AddSkin("cab","Def_708Def1",{
    name = "White cab",
    typ = "81-718",
    textures = {
        ["1003"] = "models/metrostroi_train/81_718/1003",
        ["1006"] = "models/metrostroi_train/81_718/1006",
    },
    default = true
})

Metrostroi.AddSkin("cab","Def2",{
    name = "Red cab",
    typ = "81-718",
    textures = {
        ["1003"] = "models/metrostroi_train/81_718/1003_red",
        ["1006"] = "models/metrostroi_train/81_718/1006_red",
    },
})
Metrostroi.AddSkin("cab","Def_718Random",{
    name = "Random",
    typ = "81-718",
    func = function(ent)
        local tbl = {}
        for k,v in pairs(Metrostroi.Skins.cab) do
            if v.typ == "81-718" and v.random then
                table.insert(tbl,k)
            end
        end
        return table.Random(tbl)
    end,
    def=true,
})


Metrostroi.AddSkin("train","Def_720Def",{
    name = "Default",
    typ = "81-720",
    texures = {},
    def=true,
})
Metrostroi.AddSkin("pass","Def_720Def",{
    name = "Default",
    typ = "81-720",
    textures = {},
    def=true,
})
Metrostroi.AddSkin("cab","Def_720Def",{
    name = "Default",
    typ = "81-720",
    textures = {},
    def=true,
})
Metrostroi.AddSkin("train","Def_722Def",{
    name = "Default",
    typ = "81-722",
    textures = {},
    def=true,
})
Metrostroi.AddSkin("pass","Def_722Def",{
    name = "Default",
    typ = "81-722",
    textures = {},
    def=true,
})
Metrostroi.AddSkin("cab","Def_722Def",{
    name = "Default",
    typ = "81-722",
    textures = {},
    def=true,
})
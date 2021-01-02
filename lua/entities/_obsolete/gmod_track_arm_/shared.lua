ENT.Type            = "anim"

--Inherit subway base for some need functions
ENT.Base            = "gmod_subway_base"
ENT.NoTrain = true

ENT.PrintNameTranslated       = "Entities.ARM"
ENT.Category		= "Metrostroi"

ENT.Spawnable       = false
ENT.AdminSpawnable  = true

ENT.Cameras = {
    {Vector(-18+3,0,43+2),Angle(0,0,0),"ARM.Monitor1",true},
}
ENT.Types = {
    --Main segments
    [0.25]={
        maintex = {"metrostroi_arm/sec025",w=8,h=8,rw=7,rh=8,},
        occup_m = {"metrostroi_arm/sec025_m",col=Color(255,255,255)},
        route_m = {"metrostroi_arm/sec025_m",col=Color(39,103,63)},
        width = 0.25,
        next_m = {x=0.25,y=0}
    },
    [0.5]={
        maintex = {"metrostroi_arm/sec05",w=16,h=8,rw=16,rh=8,},
        occup_m = {"metrostroi_arm/sec05_m",col=Color(255,255,255)},
        route_m = {"metrostroi_arm/sec05_m",col=Color(39,103,63)},
        width = 0.5,
        next_m = {x=0.5,y=0}
    },
    [1]={
        maintex = {"metrostroi_arm/sec1",w=64,h=8,rw=34,rh=8,},
        occup_m = {"metrostroi_arm/sec1_m",col=Color(255,255,255)},
        route_m = {"metrostroi_arm/sec1_m",col=Color(39,103,63)},
        width = 1,
        next_m = {x=1,y=0}
    },
    [2]={
        maintex = {"metrostroi_arm/sec2",w=128,h=8,rw=70,rh=8,},
        occup_m = {"metrostroi_arm/sec2_m",col=Color(255,255,255)},
        route_m = {"metrostroi_arm/sec2_m",col=Color(39,103,63)},
        width = 2,
        next_m = {x=2,y=0}
    },
    [3]={
        maintex = {"metrostroi_arm/sec3",w=128,h=8,rw=106,rh=8,},
        occup_m = {"metrostroi_arm/sec3_m",col=Color(255,255,255)},
        route_m = {"metrostroi_arm/sec3_m",col=Color(39,103,63)},
        width = 3,
        next_m = {x=3,y=0}
    },
    [4]={
        maintex = {"metrostroi_arm/sec4",w=256,h=8,rw=142,rh=8,},
        occup_m = {"metrostroi_arm/sec4_m",col=Color(255,255,255)},
        route_m = {"metrostroi_arm/sec4_m",col=Color(39,103,63)},
        width = 4,
        next_m = {x=4,y=0}
    },
    [5]={
        maintex = {"metrostroi_arm/sec5",w=256,h=8,rw=178,rh=8,},
        occup_m = {"metrostroi_arm/sec5_m",col=Color(255,255,255)},
        route_m = {"metrostroi_arm/sec5_m",col=Color(39,103,63)},
        width = 5,
        next_m = {x=5,y=0}
    },
    --Switches and helpers
    sw = {
        maintex = {"metrostroi_arm/switch",w=128,h=128,rw=70,rh=78,},
        occup_m = {"metrostroi_arm/switch_m",col=Color(255,255,255)},
        route_m = {"metrostroi_arm/switch_m",col=Color(39,103,63)},
        occup_a = {"metrostroi_arm/switch_a",col=Color(255,255,255)},
        route_a = {"metrostroi_arm/switch_a",col=Color(39,103,63)},
        switch_m = {"metrostroi_arm/switch_ms",col=Color(41,202,26)},
        switch_a = {"metrostroi_arm/switch_as",col=Color(240,240,71)},
        switch_mn = {"metrostroi_arm/switch_ms",col=Color(200,50,50)},
        switch_an = {"metrostroi_arm/switch_as",col=Color(200,50,50)},
        width = 2,
        next_m = {x=2,y=0},
        next_a = {x=2,y=1},
    },
    ["2sw"] = {
        maintex = {"metrostroi_arm/2-switch_half",w=128,h=256,rw=70,rh=143,},
        occup_m = {"metrostroi_arm/2-switch_half_m",col=Color(255,255,255)},
        route_m = {"metrostroi_arm/2-switch_half_m",col=Color(39,103,63)},
        occup_a = {"metrostroi_arm/2-switch_half_a",col=Color(255,255,255)},
        route_a = {"metrostroi_arm/2-switch_half_a",col=Color(39,103,63)},
        switch_m = {"metrostroi_arm/2-switch_half_ms",col=Color(41,202,26)},
        switch_a = {"metrostroi_arm/2-switch_half_as",col=Color(240,240,71)},
        switch_mn = {"metrostroi_arm/2-switch_half_as",col=Color(200,50,50)},
        switch_an = {"metrostroi_arm/2-switch_half_ms",col=Color(200,50,50)},
        width = 2,
        next_m = {x=2,y=0},
        next_a = {x=2,y=2},
    },
    ["2swm"] = {
        maintex = {"metrostroi_arm/2-switch-middle_half",w=128,h=128,rw=70,rh=73,},
        occup_m = {"metrostroi_arm/2-switch-middle_half_m",col=Color(255,255,255)},
        route_m = {"metrostroi_arm/2-switch-middle_half_m",col=Color(39,103,63)},
        occup_a = {"metrostroi_arm/2-switch-middle_half_a",col=Color(255,255,255)},
        route_a = {"metrostroi_arm/2-switch-middle_half_a",col=Color(39,103,63)},
        switch_m = {"metrostroi_arm/2-switch-middle_half_ms",col=Color(41,202,26)},
        switch_a = {"metrostroi_arm/2-switch-middle_half_as",col=Color(240,240,71)},
        switch_mn = {"metrostroi_arm/2-switch-middle_half_ms",col=Color(200,50,50)},
        switch_an = {"metrostroi_arm/2-switch-middle_half_as",col=Color(200,50,50)},
        width = 2,
        next_m = {x=2,y=0},
        next_a = {x=1.5,y=1},
    },
    ["4sw"] = {
        maintex = {"metrostroi_arm/4-switch_quarter",w=128,h=256,rw=73,rh=143,x=-3,},
        occup_m = {"metrostroi_arm/4-switch_quarter_m",col=Color(255,255,255)},
        route_m = {"metrostroi_arm/4-switch_quarter_m",col=Color(39,103,63)},
        occup_a = {"metrostroi_arm/4-switch_quarter_a1",col=Color(255,255,255)},
        route_a = {"metrostroi_arm/4-switch_quarter_a1",col=Color(39,103,63)},
        occup_x = {"metrostroi_arm/4-switch_quarter_a2",col=Color(255,255,255)},
        route_x = {"metrostroi_arm/4-switch_quarter_a2",col=Color(39,103,63)},
        switch_m = {"metrostroi_arm/4-switch_quarter_ms",col=Color(41,202,26)},
        switch_a = {"metrostroi_arm/4-switch_quarter_as",col=Color(240,240,71)},
        switch_mn = {"metrostroi_arm/4-switch_quarter_ms",col=Color(200,50,50)},
        switch_an = {"metrostroi_arm/4-switch_quarter_as",col=Color(200,50,50)},
        width = 2,
        next_m = {x=2,y=0},
        next_a = {x=2,y=2},
        acc_x = ">",
        acc_y = "!",
    },
    ["4sws"] = {
        maintex = {"metrostroi_arm/4-switch_quarter_small",w=64,h=128,rw=53,rh=78,x=-1,},
        occup_m = {"metrostroi_arm/4-switch_quarter_small_m",col=Color(255,255,255),x=-1,},
        route_m = {"metrostroi_arm/4-switch_quarter_small_m",col=Color(39,103,63),x=-1,},
        occup_a = {"metrostroi_arm/4-switch_quarter_small_a",col=Color(255,255,255),x=-1,},
        route_a = {"metrostroi_arm/4-switch_quarter_small_a",col=Color(39,103,63),x=-1,},
        switch_m = {"metrostroi_arm/4-switch_quarter_small_ms",col=Color(41,202,26)},
        switch_a = {"metrostroi_arm/4-switch_quarter_small_as",col=Color(240,240,71)},
        switch_mn = {"metrostroi_arm/4-switch_quarter_small_ms",col=Color(200,50,50)},
        switch_an = {"metrostroi_arm/4-switch_quarter_small_as",col=Color(200,50,50)},
        width = 1.5,
        next_m = {x=1.5,y=0},
        next_a = {x=1.5,y=1},
        acc_x = ">",
        acc_y = "!",
    },
    ofd = {
        maintex = {"metrostroi_arm/offset_down",w=64,h=256,rw=57,rh=143,},
        occup_m = {"metrostroi_arm/offset_down_m",col=Color(255,255,255)},
        route_m = {"metrostroi_arm/offset_down_m",col=Color(39,103,63)},
        width = 2,
        next_m = {x=2,y=2},
    },
    ofds = {
        maintex = {"metrostroi_arm/offsed_down_small",w=128,h=128,rw=70,rh=78,},
        occup_m = {"metrostroi_arm/offsed_down_small_m",col=Color(255,255,255)},
        route_m = {"metrostroi_arm/offsed_down_small_m",col=Color(39,103,63)},
        width = 2,
        next_m = {x=2,y=1},
    },
    ysw = {
        maintex = {"metrostroi_arm/Y-switch_half",w=128,h=128,rw=70,rh=108,},
        occup_m = {"metrostroi_arm/Y-switch_half_m",col=Color(255,255,255)},
        route_m = {"metrostroi_arm/Y-switch_half_m",col=Color(39,103,63)},
        occup_a = {"metrostroi_arm/Y-switch_half_a",col=Color(255,255,255)},
        route_a = {"metrostroi_arm/Y-switch_half_a",col=Color(39,103,63)},
        switch_m = {"metrostroi_arm/Y-switch_half_ms",col=Color(41,202,26)},
        switch_a = {"metrostroi_arm/Y-switch_half_as",col=Color(240,240,71)},
        switch_mn = {"metrostroi_arm/Y-switch_half_ms",col=Color(200,50,50)},
        switch_an = {"metrostroi_arm/Y-switch_half_as",col=Color(200,50,50)},
        width = 2,
        next_m = {x=2,y=0},
        next_a = {x=2,y=1},
    },
    --Signals
    tl_1 = {
        maintex = {"metrostroi_arm/tl_1",w=32,h=16,rw=21,rh=13},
        full = {"metrostroi_arm/tl_f",w=16,h=16,rw=12,rh=12},
        h1 = {"metrostroi_arm/tl_h1",w=16,h=16,rw=12,rh=12},
        h2 = {"metrostroi_arm/tl_h2",w=16,h=16,rw=12,rh=12},
    },
    tl_2 = {
        maintex = {"metrostroi_arm/tl_2",w=64,h=16,rw=34,rh=13},
        full = {"metrostroi_arm/tl_f",w=16,h=16,rw=12,rh=12},
        h1 = {"metrostroi_arm/tl_h1",w=16,h=16,rw=12,rh=12},
        h2 = {"metrostroi_arm/tl_h2",w=16,h=16,rw=12,rh=12},
    },
    tl_3 = {
        maintex = {"metrostroi_arm/tl_3",w=64,h=16,rw=47,rh=13},
        full = {"metrostroi_arm/tl_f",w=16,h=16,rw=12,rh=12},
        h1 = {"metrostroi_arm/tl_h1",w=16,h=16,rw=12,rh=12},
        h2 = {"metrostroi_arm/tl_h2",w=16,h=16,rw=12,rh=12},
    },
}
if CLIENT then
    for i,segm in pairs(ENT.Types) do
        for k,tex in pairs(segm) do
            if type(tex) ~= "table" or type(tex[1]) ~= "string" then continue end
            tex.mat = surface.GetTextureID(tex[1])
        end
        segm.id = i
    end
end

--------------
-- Syntax of table
-- {
-- station = "ID,abbreviation,full name"
-- First line of segments
-- {"segment type:occupation checkers,...,occupation checkers:lights:...:lights"},
-- Second line of segments
-- {x=x indent,skip=y indent(skips y segments vertically),"segment type:occupation checkers main,...,occupation checkers main:occupation checkers alt,...,occupation checkers alt:lights:...:lights"},
-- }
-- segment type can have > or ! on start, when we want mirror it vertically or horisontally
-- Occupation checkers can be triggers(have @ in start of trigger name) or signals
-- Lights can be empty, if we want take light name from occupation checkers
-- Lights can have ! when stay in right direction or !! when stay in opposite direction
-- Lights can have > when we want switch light location from bottom to top
-- Examples
--{
--    station = "001,ST,Station name",
--    {
--        {"1:L1:!","1:L3:!","sw:@sw1trigger:@sw3trigger"}
--        {x=1,"1:L2",">sw:@sw2trigger:@sw3rigger"},
--    }
--}
--------------
Metrostroi.ARMConfig = {
   {
        station = "451,ВБ,Уоллеса брина",
        {"0.5:1","0.5:1","0.5:1","0.5:1","1:1","1:1","1:1","sw:1","3:1","3:1"},
        {x=7,"0.5:1","4sws:1",">4sws:1","1:1","1:1"},{skip=1},
        {x=7,"0.5:1","!4sws:1",">!4sws:1","1:1","1:1"},
        {"0.5:1","0.5:1","0.5:1","0.5:1","1:1","1:1","1:1","!sw:1","3:1","3:1"},
    },{
        station="915,РЧ,Речная",
        {x=3.5,"0.5:RX22","1:RX22","1:RX20","0.5:RX98","4sw:::RX1:0",">4sw:::RX3:","1","2","2","1","1"},{skip=3},
        {"1:201","0.5:203","0.5:205","0.5:207","0.5:209","0.5:211","0.5:213","1:215","1:217","0.5:219","!4sw:::RX2::!!2RX95",">!4sw:::RX4:","1","2","2","1","1"},
    },{
        station="110,МД,Международная",
        {"1:19:!1","1:17:!1","1:15:!1","1:13:!1","3:11:!>1","sw:@wt_md_s1_1,@wt_md_s1_2:@wt_md_s1_3:MD1:!!>2D:!>2G","5:@wt_md_t1"},
        {x=9,"4sws:@wt_md_s3::MD3",">4sws:@wt_md_s5::MD5:!2MD1","2:@wt_md_t3"},{skip=1},
        {x=9,"!4sws:@wt_md_s4::MD4",">!4sws:@wt_md_s6::MD6:!>2MD2","2:@wt_md_t4"},
        {"1:MD16:!!2","1:MD14:!!2","1:MD12:!!2","1:MD10:!!2:!1 OP","1:MD8:!!2","1:MD8A","1:MD8B","!sw:@wt_md_s2_1,@wt_md_s2_2:@wt_md_s2_3:MD2:!!2MD6:!2E","5:@wt_md_t2"},
        buttons = {
            {type="r",y=4-0.6 ,x=4,     signal=" OP"},
            {type="r",y=4     ,x=6+0.4, signal="MD6"},
            {type="r",y=4-0.6 ,x=9,     signal="E"},
            {type="r",y=3     ,x=14,    signal="4I",target={12,3}},
            {type="r",y=1-0.6 ,x=14,    signal="3I",target={12,1}},
            {type="r",y=3     ,x=12,    signal="MD2"},
            {type="r",y=1-0.6 ,x=12,    signal="MD1"},
            --{type="r",y=0-0.6 ,x=4,     signal="13"},
            {type="r",y=0-0.6 ,x=6+0.4, signal="D",target={4,0}},
            {type="r",y=0     ,x=9,     signal="G"},
        },
        routes = {
            MD6={"4I","3I"},
            E={" OP"},
            MD2={" OP","D"},
            MD1={" OP","13"},
            D={"4I","3I"},
            G={"13"},
        }
    },{
        station="112,ПТ,Политехническая",
        {x=1,"1:PT2TB","2:PT2TA","2:PT2T:!!2PT2","2:PT4SA:!!2PT4",">2swm:@wt_pt_s4_1,@wt_pt_s4_2,@wt_pt_s4_3::PT4:!3PT968M:!!2G ","1:PT966A","2:PT966:!>2","sw:@wt_pt_s6_2,@wt_pt_s6_3::PT6:!>2PT964:!!>3A","1:962"},
        {x=15,"1:PT6SS","1:963"},
        {x=1,"1:77:!1","1:75:!1","1:73:!1","1:71:!>1",">2swm:@wt_pt_s1_1::PT1:!!>2B","!2swm:@wt_pt_s3_1:@wt_pt_s3_2:PT3:!>2PT69","1:PT67M:!2","1:PT65B","1:PT65A","1:PT65:!2","1:PT63:!2:!!1 OP ","1:PT61:!2","1:PT59:!2","1:PT57:!2"},{skip=1},
        {"1:PT70:!!2:!1 OP2 ","1:PT68:!!2","2:@wt_pt_s2_3:!!2PT66","!2swm:@wt_pt_s2_1:@wt_pt_s2_2:PT2:!!3PT64","2","2:62:!!1","1:60:!!1","2:60A","1:58M:!!1","1:56:!!1","1:54:!!1","1: 52:!!1"},
        {},
        labels = {

        },
        buttons = {
            {type="r",y=0-0.6 ,x=1,    signal="3T",target={1,0},flip=true},
            {type="r",y=0     ,x=3+0.4,signal="PT2",target={1,0},flip=true},

            {type="r",y=4-0.6 ,x=1,     signal=" OP2 "},
            {type="r",y=4     ,x=-1+0.4, signal="PT70"},
            {type="r",y=4     ,x=3+0.4, signal="2P",target={6,4}},
            --{type="r",y=4     ,x=7+0.4, signal="62"},
            {type="r",y=2     ,x=5,     signal="71"},
            {type="r",y=2-0.6 ,x=4+0.4, signal="B",target={5,2}},
            {type="r",y=2-0.6 ,x=17,    signal="PT57"},
            {type="r",y=2-0.6 ,x=10,    signal="PT67M"},
            {type="r",y=2     ,x=12+0.4,signal=" OP "},
            {type="r",y=0-0.6 ,x=10,    signal="PT968M",flip=true},
            {type="r",y=0     ,x=15,    signal="PT964",flip=true},
            {type="r",y=1-0.6 ,x=15,    signal="4O",target={15,1},flip=true},
            {type="r",y=0-0.6 ,x=12+0.4,signal="A",flip=true},
        },
        routes = {
            PT2 = {"A"},
            PT70 = {" OP ","A","2P"},
            --PT64 = {" OP ","A","PT64"},
            B = {" OP ","A"},
            PT57 = {"PT67M"},
            PT964 = {"PT968M"},
            PT67M = {"71"," OP2 "},
            PT968M = {"3T","71"," OP2 "},
            A={"4O"}
        }
    },{
        station="115,ОК,Октябрьская",
        {"1","1","1","1","3","sw:::OK1","1"},
        {x=9,"4sws:::OK3",">4sws:::OK5","1"},{skip=1},
        {x=9,"!4sws:::OK4",">!4sws:::OK6","1"},
        {"1","1","1","1","3","!sw:::OK2","5"},
    }
}

print("MetrostroiARM:Generating ARM table...")
local errors,warnings = 0,0
local function ARMGenError(text,err)
    MsgC(Color(255,err and 0 or 255,0),"MetrostroiARM:"..text.."\n")
    ErrorNoHalt()
    if err then errors = errors + 1 else warnings = warnings + 1 end
end

local function ParseARMTable(text,station,line,segm)
    local resultTbl = {}

    local tbl = string.Explode(":",text)

    local typ = tbl[1]
    if typ:find("^[>!]") then
        resultTbl.invertX = typ:find(">")
        resultTbl.invertY = typ:find("!")
        typ = typ:gsub("^[>!]+","")
    end
    local segmTyp = ENT.Types[tonumber(typ) or typ]
    if not segmTyp then return {error = 1,type = tbl[1]} end
    table.remove(tbl,1)

    for i,str in ipairs(tbl) do
        if str:find(",") then
            tbl[i] = string.Explode(",",str)
        end
        if str:sub(1,2) == "!!" then
            resultTbl.signal2 = str:sub(3,-1)
        elseif str[1] == "!" then
            resultTbl.signal1 = str:sub(2,-1)
        end
    end
    resultTbl.occup = type(tbl[1]) == "table" and tbl[1] or {tbl[1]}
    if segmTyp.occup_a then
        resultTbl.occupAlt = type(tbl[2]) == "table" and tbl[2] or {tbl[2]}
        resultTbl.switch = tbl[3]
        if segmTyp.occup_x then
            resultTbl.occup2 = type(tbl[4]) == "table" and tbl[4] or {tbl[4]}
        end
    end

    if resultTbl.signal1 then
        local signal = resultTbl.signal1:gsub("^[>]+","")
        local top = resultTbl.signal1:find("^>")

        local typ = tonumber(signal[1])
        local name = signal:sub(2,-1)
        if not typ then
            ARMGenError(Format("Parser warning. Signal type in id station %d line %d segm %d segment not found. Using default 1",station,line,segm),false)
            name = signal[1]..name
        elseif typ < 1 or typ > 3 then
            ARMGenError(Format("Parser warning. Signal type in id station %d line %d segm %d segment have wrong ID, must be in range 1..3. Using default 1",station,line,segm),false)
            typ = 1
        end
        if name == "" then name = resultTbl.occup[1] end
        resultTbl.signal1 = {name=name,type=typ or 1,top = top,segm=resultTbl}
    end
    if resultTbl.signal2 then
        local signal = resultTbl.signal2:gsub("^[>]+","")
        local top = resultTbl.signal2:find("^>")
        local typ = tonumber(signal[1])
        local name = signal:sub(2,-1)
        if not typ then
            ARMGenError(Format("Parser warning. Signal type in id station %d line %d segm %d segment not found. Using default 1",station,line,segm),false)
            name = signal[1]..name
        elseif typ < 1 or typ > 3 then
            ARMGenError(Format("Parser warning. Signal type in id station %d line %d segm %d segment have wrong ID, must be in range 1..3. Using default 1",station,line,segm),false)
            typ = 1
        end
        if name == "" then name = resultTbl.occup[1] end
        resultTbl.signal2 = {name=name,type=typ or 1,top = top,segm=resultTbl}
    end
    resultTbl.type = typ
    resultTbl.width = segmTyp.width or 1
    resultTbl.segm = segmTyp
    return resultTbl
end


Metrostroi.ARMConfigGenerated = {}
local id = 0
for i,station in ipairs(Metrostroi.ARMConfig) do
    if not Metrostroi.ARMConfigGenerated[i] then Metrostroi.ARMConfigGenerated[i] = {} end
    local genStation = Metrostroi.ARMConfigGenerated[i]
    local y = 0

    MsgC(Color(0, 222, 255),"MetrostroiARM:Solving station ",i,"\n")
    if #station == 0 then ARMGenError(Format("Parser warning. Empty station %d! Skipping...",i),false) continue end
    if not station.station then ARMGenError(Format("Parser error. Can't find station name in station %d! Skipping...",i),true) continue end

    local stationTbl = string.Explode(",",station.station)
    if not stationTbl or #stationTbl < 3 or not tonumber(stationTbl[1]) then ARMGenError(Format("Parser error. Malformed station data in station %d! Skipping...",i),true) continue end

    genStation.id = stationTbl[1]
    genStation.shortname = stationTbl[2]
    genStation.name = stationTbl[3]
    genStation.buttons = {}
    genStation.routes = station.routes or {}
    for lineID,line in ipairs(station) do
        local x = line.x or 0
        for segmID,segm in ipairs(line) do
            if type(segm) ~= "string" then
                ARMGenError(Format("Parser error on station %d line %d segm %d, excepted string,got %s. Skipping segment...",i,lineID,segmID,type(segm)),true)
                continue
            end
            local segmTbl=  ParseARMTable(segm,i,lineID,segmID)
            if segmTbl.error then
                ARMGenError(Format("Parser warning. Skipping station %d line %d segm %d segment, type error(type '%s' not found)",i,lineID,segmID,segmTbl.type),false)
                continue
            end
            segmTbl.x = x
            segmTbl.y = y
            segmTbl.id = table.insert(genStation,segmTbl)
            x = x + (segmTbl.width or 1)
        end
        y = y + (line.skip or 1)
    end
    if station.buttons then
        for _,button in pairs(station.buttons) do
            button.pressable = false
            button.selected = false
            button.isbutton = true
            if button.type == "r" then
                button.segm = ENT.Types.button_normal
                for k,v in ipairs(genStation) do
                    if v.signal1 and v.signal1.name == button.signal then
                        button.segm = v
                        v.signal1.button = button
                        break
                    end
                    if v.signal2 and v.signal2.name == button.signal then
                        button.segm = v
                        v.signal2.button = button
                        break
                    end
                    if button.target and button.target[1] == v.x and button.target[2] == v.y then
                        button.segm = v
                        v.button = button
                        if v.button then
                            v.button = nil
                            v.buttons = {v.button,button}
                        end
                        break
                    end
                end
            end
            table.insert(genStation.buttons,button)
        end
    end
end

local function GetXY(x,y)
    return 100+x*36,100+y*70
end

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
            local posAX,posAY = GetSegmPos(segm)
            if not csegm.segm.next_a or posX == posAX or posY == posAY then continue end
            posOX,posOY = GetSegmPos(csegm,true)
            if ARMSetNextCompare(posOX,posOY,csegm,segm) then
                csegm.next_a = segm
                --break
            end
        end
    end
end
for i,st in ipairs(Metrostroi.ARMConfigGenerated) do ARMSetNext(st) end


local function tcopy(from)
    local t = {}
    for k,v in pairs(from) do
        t[k] = v
    end
    return t
end
local iter = 1
local function ARMFindSegmSignals(station,segm,dir,signals,last,checked,restbl,trace)
    if not restbl then restbl = {} end
    if not checked then checked = {} end
    if not trace then trace = {} end
    if checked[segm] then return end
    checked[segm] = true
    local segmIndex = table.insert(trace,{segm.id})
    --trace[segm] = true

    iter = iter + 1
    if iter > 10000 then ARMGenError(Format("Routes generation error. Max iter reached!"),true) return false end
    local segmM,segmA = segm.next_m,segm.next_a
    local segmP = segm.prev


    local mainM = segmM and (dir and segmM.x > segm.x or not dir and segmM.x < segm.x)
    local mainP = segmP and (dir and segmP.x > segm.x or not dir and segmP.x < segm.x)
    if segmA and mainM then
        local trace= table.Copy(trace)

        trace[segmIndex][2] = true
        local signal = dir and segmA.signal2 or segmA.signal1
        local button = segmA.button

        if signal and table.HasValue(signals,signal.name) then
            table.insert(restbl,{signal,table.Copy(trace)})
        elseif button and table.HasValue(signals,button.signal) then
            table.insert(trace,{segmA.id})
            table.insert(restbl,{button,table.Copy(trace)})
        end
        ARMFindSegmSignals(station,segmA,dir,signals,segm,checked,restbl,trace)
    end
    if segmM and mainM then
        local signal = dir and segmM.signal2 or segmM.signal1
        local button = segmM.button
        if signal and table.HasValue(signals,signal.name) then
            table.insert(restbl,{signal,table.Copy(trace)})
        elseif button and table.HasValue(signals,button.signal) then
            table.insert(trace,{segmM.id})
            table.insert(restbl,{button,table.Copy(trace)})
        end
        ARMFindSegmSignals(station,segmM,dir,signals,segm,checked,restbl,trace)
    end
    if segmP and mainP then
        trace[segmIndex][2] = last and segm.next_a == last or nil-- or segmP.next_a == segm or nil
        local signal = dir and segmP.signal2 or segmP.signal1
        local button = segmP.button
        if signal and table.HasValue(signals,signal.name) then
            table.insert(restbl,{signal,table.Copy(trace)})
        elseif button and table.HasValue(signals,button.signal) then
            table.insert(trace,{segmP.id})
            table.insert(restbl,{button,table.Copy(trace)})
        end
        ARMFindSegmSignals(station,segmP,dir,signals,segm,checked,restbl,trace)
    end
    return restbl
end

for i,station in ipairs(Metrostroi.ARMConfigGenerated) do
    print("STATION",i)
    for _,button in pairs(station.buttons) do
        if button.type == "r" and station.routes[button.signal] then
            print(button.signal,button.segm)
            button.pressable = true
            local results = ARMFindSegmSignals(station,button.segm,false,station.routes[button.signal])
            if #results == 0 then
                results = ARMFindSegmSignals(station,button.segm,true,station.routes[button.signal])
            end
            for k,v in pairs(results) do
                local i = 0
                for k,v in pairs(v[2]) do i = i + 1 end
                print("--",k,v,v[1],v[2],i)
            end
            --print(results[1][1].name,results[1][1].segm)--]]
            button.routes = results
        end
        --[[ if segm.signal2 then
            local result = ARMFindNextSegm(station,segm,true,nil,nil,segm.signal2.name=="PT640")
            if result and #result > 0 then
                print(segm.signal2.name.."->")
                for k,v in ipairs(result) do print(" "..v.name) end
            end
        end
        if segm.signal1 then
            local result = ARMFindNextSegm(station,segm,false,nil,nil,segm.signal1.name=="MD01")
            if result and #result > 0 then
                print(segm.signal1.name.."->")
                for k,v in ipairs(result) do print(" "..v.name) end
            end
        end--]]
    end

end
if errors == 0 and warnings == 0 then
    MsgC(Color(0,255,0),"MetrostroiARM:Generate finished without errors and warnings.\n")
elseif errors == 0 then
    MsgC(Color(255,255,0),"MetrostroiARM:Generate finished with "..warnings.." warnings.\n")
else
    MsgC(Color(255,0,0),"MetrostroiARM:Generate finished with "..errors.." errors and "..warnings.." warnings!\n")
end
--PrintTable(Metrostroi.ARMConfigGenerated)

for k,v in ipairs(Metrostroi.ARMConfigGenerated) do
    Metrostroi.ARMTable[k] = {
        occChecks = {},
        net = {},
        signal = {},
        switch = {},
        routes = {},
    }
end
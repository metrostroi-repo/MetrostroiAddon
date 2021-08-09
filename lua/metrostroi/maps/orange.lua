local Map = game.GetMap():lower() or ""

if Map:find("gm_mus_crimson") then
    return
elseif Map:find("gm_mus") and Map:find("neoorange") then
    Metrostroi.PlatformMap = "orange"
    Metrostroi.CurrentMap = "gm_orange"
else
    return
end

Metrostroi.AddLastStationTex("702",401,"models/metrostroi_schemes/destination_table_black/label_ikarus")
Metrostroi.AddLastStationTex("702",404,"models/metrostroi_schemes/destination_table_black/label_aeroport")
Metrostroi.AddLastStationTex("702",408,"models/metrostroi_schemes/destination_table_black/label_park")
Metrostroi.AddLastStationTex("702",411,"models/metrostroi_schemes/destination_table_black/label_wallance_breen")
Metrostroi.AddLastStationTex("710",401,"models/metrostroi_schemes/destination_table_white/label_ikarus")
Metrostroi.AddLastStationTex("710",404,"models/metrostroi_schemes/destination_table_white/label_aeroport")
Metrostroi.AddLastStationTex("710",408,"models/metrostroi_schemes/destination_table_white/label_park")
Metrostroi.AddLastStationTex("710",411,"models/metrostroi_schemes/destination_table_white/label_wallance_breen")
Metrostroi.AddLastStationTex("717",401,"models/metrostroi_schemes/destination_table_white/label_ikarus")
Metrostroi.AddLastStationTex("717",404,"models/metrostroi_schemes/destination_table_white/label_aeroport")
Metrostroi.AddLastStationTex("717",408,"models/metrostroi_schemes/destination_table_white/label_park")
Metrostroi.AddLastStationTex("717",411,"models/metrostroi_schemes/destination_table_white/label_wallance_breen")
Metrostroi.AddLastStationTex("720",401,"models/metrostroi_schemes/destination_table_white/label_ikarus")
Metrostroi.AddLastStationTex("720",404,"models/metrostroi_schemes/destination_table_white/label_aeroport")
Metrostroi.AddLastStationTex("720",408,"models/metrostroi_schemes/destination_table_white/label_park")
Metrostroi.AddLastStationTex("720",411,"models/metrostroi_schemes/destination_table_white/label_wallance_breen")

Metrostroi.AddPassSchemeTex("717_new","1 Line",{
    "models/metrostroi_schemes/mus_neoorange",
})
Metrostroi.AddPassSchemeTex("720","Crossline",{
    "metrostroi_skins/81-720_schemes/oranger",
    "metrostroi_skins/81-720_schemes/orange",
})
Metrostroi.AddPassSchemeTex("722","Crossline",{
    "metrostroi_skins/81-722_schemes/oranger",
    "metrostroi_skins/81-722_schemes/orange",
})

Metrostroi.TickerAdverts = {"МЕТРОПОЛИТЕН ИМЕНИ ГАРРИ НЬЮМАНА ПРИГЛАШАЕТ НА РАБОТУ РЕАЛЬНЕ МАФЕНЕСТОВ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,ТЕЛЕФОН ДЛЯ СПРАВОК 8 (800) 555-35-35", "ЭЛЕКТРОДЕПО 'РАБА' ПРИГЛАШАЕТ НА РАБОТУ МОЙЩИКОВ", "В СВЯЗИ С ВВЕЕДЕНИЕМ ЭЛЕКТРОПОЕЗДОВ НОВОГО ПОКОЛЕНИЯ В ЭКСПЛУАТАЦИЮ, ЭЛЕКТРОДЕПО 'РАБА' ПРИГЛАШАЕТ НА РАБОТУ СЛЕСАРЕЙ ПОДИВЖНОГО СОСТАВА", "УПЦ МЕТРОПОЛИТЕНА ИМЕНИ ГАРРИ НЬЮМАНА ПРОВОДИТ НАБОР НА ОБУЧЕНИЕ ПО ПРОФЕССИИ 'МАШИНИСТ ЭЛЕКТРОПОЕЗДА'. ВО ВРЕМЯ ОБУЧЕНИЯ ВЫПЛАЧИВАЕТСЯ СТИПЕНДИЯ В РАЗМЕРЕ 10У.Е.,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,ТЕЛЕФОН ДЛЯ СПРАВОК 8 (800) 555-35-35", "СТАНЦИЯ СЛАВУТИЧ ПРИГЛАШАЕТ НА РАБОТУ МАШИНИСТОВ И ПОМОЩНИКОВ МАШИНИСТА ЭСКАЛАТОРА. ОПЛАТА 5 КУСОЧКОВ НОМЕРНОГО.", "ЭЛЕКТРОДЕПО ТЧ1АААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА"}
Metrostroi.SetUPOAnnouncer({
    tone = {"subway_announcers/upo/rhino/orange/tone.mp3", 1},
    click1 = {"subway_announcers/upo/click1.mp3", 0.3},
    click2 = {"subway_announcers/upo/click2.mp3", 0.1},

    aeroport = {"subway_announcers/upo/rhino/orange/aeroport.mp3", 0.835200},
    arsenal = {"subway_announcers/upo/rhino/orange/arsenal.mp3", 0.678600},
    flora = {"subway_announcers/upo/rhino/orange/flora.mp3", 0.600300},
    gcfscape = {"subway_announcers/upo/rhino/orange/gcfscape.mp3", 1.174500},
    ikarus = {"subway_announcers/upo/rhino/orange/ikarus.mp3", 0.652500},
    imeni_uollesa_brina = {"subway_announcers/upo/rhino/orange/imeni_uollesa_brina.mp3", 1.278900},
    last_aeroport = {"subway_announcers/upo/rhino/orange/last_aeroport.mp3", 9.787500},
    last_ikarus = {"subway_announcers/upo/rhino/orange/last_ikarus.mp3", 9.944100},
    last_imeni_uollesa_brina = {"subway_announcers/upo/rhino/orange/last_imeni_uollesa_brina.mp3", 10.779300},
    last_park = {"subway_announcers/upo/rhino/orange/last_park.mp3", 10.935900},
    litievaya = {"subway_announcers/upo/rhino/orange/litievaya.mp3", 0.730800},
    next_aeroport = {"subway_announcers/upo/rhino/orange/next_aeroport.mp3", 1.879200},
    next_arsenal = {"subway_announcers/upo/rhino/orange/next_arsenal.mp3", 1.800900},
    next_flora = {"subway_announcers/upo/rhino/orange/next_flora.mp3", 1.539900},
    next_gcfscape = {"subway_announcers/upo/rhino/orange/next_gcfscape.mp3", 3.732300},
    next_gcfscape1 = {"subway_announcers/upo/rhino/orange/next_gcfscape1.mp3", 2.166300},
    next_ikarus = {"subway_announcers/upo/rhino/orange/next_ikarus.mp3", 1.696500},
    next_imeni_uollesa_brina = {"subway_announcers/upo/rhino/orange/next_imeni_uollesa_brina.mp3", 2.427300},
    next_litievaya = {"subway_announcers/upo/rhino/orange/next_litievaya.mp3", 1.722600},
    next_park = {"subway_announcers/upo/rhino/orange/next_park.mp3", 3.053700},
    next_park1 = {"subway_announcers/upo/rhino/orange/next_park1.mp3", 1.487700},
    next_slavnaya_strana = {"subway_announcers/upo/rhino/orange/next_slavnaya_strana.mp3", 1.983600},
    next_slavutich = {"subway_announcers/upo/rhino/orange/next_slavutich.mp3", 1.774800},
    next_smrc = {"subway_announcers/upo/rhino/orange/next_smrk.mp3", 1.931400},
    next_vhe = {"subway_announcers/upo/rhino/orange/next_vhe.mp3", 2.322900},
    odz1 = {"subway_announcers/upo/rhino/orange/odz1.mp3", 2.088000+0.5},
    odz2 = {"subway_announcers/upo/rhino/orange/odz2.mp3", 2.192400+0.5},
    park = {"subway_announcers/upo/rhino/orange/park.mp3", 0.469800},
    slavnaya_strana = {"subway_announcers/upo/rhino/orange/slavnaya_strana.mp3", 1.017900},
    slavutich = {"subway_announcers/upo/rhino/orange/slavutich.mp3", 0.809100},
    smrk = {"subway_announcers/upo/rhino/orange/smrk.mp3", 0.809100},
    spec_attention_handrails = {"subway_announcers/upo/rhino/orange/spec_attention_handrails.mp3", 3.967200},
    spec_attention_politeness = {"subway_announcers/upo/rhino/orange/spec_attention_politeness.mp3", 5.533200},
    spec_line1 = {"subway_announcers/upo/rhino/orange/spec_line1.mp3", 1.800900},
    spec_line5 = {"subway_announcers/upo/rhino/orange/spec_line5.mp3", 1.722600},
    spec_line6 = {"subway_announcers/upo/rhino/orange/spec_line6.mp3", 1.957500},
    spec_line4 = {"subway_announcers/upo/rhino/orange/spec_line4.mp3", 1.905300},
    spec_line5 = {"subway_announcers/upo/rhino/orange/spec_line5.mp3", 1.748700},
    spec_line6 = {"subway_announcers/upo/rhino/orange/spec_line6.mp3", 1.722600},
    vhe = {"subway_announcers/upo/rhino/orange/vhe.mp3", 1.096200}
},{
    {
        462,
        "Икарус",
        arrlast = {nil, "last_ikarus"},
        dep = {{"odz1","next_smrc"}, nil},
        dist = 40,
        noises = {1,3},noiserandom = 0.3,
    },
    {
        461,
        "СМРК",
        arr = {{"smrk", 3, "next_flora",0.4,"spec_attention_politeness"}, {"smrk", 3, "next_ikarus",0.4,"spec_attention_handrails"}},
        dep = {{"odz2","next_flora"}, {"odz1","next_ikarus"}},
        dist = 40,
        noises = {2,3},noiserandom = 0.4,
    },
    {
        460,
        "Флора",
        arr = {{"flora", 3, "next_aeroport"}, {"flora", 3, "next_smrc"}},
        dep = {{"odz1","next_aeroport"}, {"odz2","next_smrc"}},
        dist = 40,
        noises = {2,1},noiserandom = 0.2,
    },
    {
        458,
        "Аэропорт",
        arr = {{"aeroport", 3, "next_slavnaya_strana", "spec_line6",0.4,"spec_attention_handrails"}, {"aeroport", 3, "next_flora",0.4,"spec_attention_politeness"}},
        dep = {{"odz2","next_slavnaya_strana"}, {"odz1","next_flora"}},
        dist = 40,
        noises = {1,2,3},noiserandom = 0.5,
    },
    {
        457,
        "Славная стр.",
        arr = {{"slavnaya_strana", 3, "next_litievaya", "spec_line5"}, {"slavnaya_strana", 3, "next_aeroport",0.4,"spec_attention_handrails"}},
        dep = {{"odz1","next_litievaya"}, {"odz2","next_aeroport"}},
        dist = 40,
        noises = {1},noiserandom = 0.2,
    },
    {
        456,
        "Литиевая",
        arr = {{"litievaya", 3, "next_arsenal",0.4,"spec_attention_politeness"}, {"litievaya", 3, "next_slavnaya_strana", "spec_line6"}},
        dep = {{"odz2","next_arsenal"}, {"odz1","next_slavnaya_strana"}},
        dist = 40,
        noises = {3},noiserandom = 0.6,
    },
    {
        455,
        "Арсенал",
        arr = {{"arsenal", 3, "next_park", "spec_line6",0.4,"spec_attention_handrails"}, {"arsenal", 3, "next_litievaya", "spec_line5"}},
        dep = {{"odz1","next_park1"}, {"odz2","next_litievaya"}},
        dist = 40,
        noises = {},noiserandom = 0.3,
    },
    {
        454,
        "Парк",
        arr = {{"park", 3, "next_gcfscape"}, {"park", 3, "next_arsenal",0.4,"spec_attention_handrails"}},
        dep = {{"odz1","next_gcfscape1"}, {"odz2","next_arsenal"}},
        dist = 40,
        noises = {1,2},noiserandom = 0.2,
    },
    {
        453,
        "GCFScape",
        arr = {{"gcfscape", 3, "next_vhe",0.4,"spec_attention_handrails"}, {"gcfscape", 3, "next_park", "spec_line6",0.4,"spec_attention_politeness"}},
        dep = {{"odz2","next_vhe"}, {"odz2","next_park1"}},
        dist = 40,
        noises = {3,2},noiserandom = 0.3,
    },
    {
        452,
        "VHE",
        arr = {{"vhe", 3, "next_imeni_uollesa_brina"}, {"vhe", 3, "next_gcfscape"}},
        dep = {{"odz1","next_imeni_uollesa_brina"}, {"odz1","next_gcfscape1"}},
        dist = 40,
        noises = {1,3},noiserandom = 0.2,
    },
    {
        451,
        "У. Брина",
        arrlast = {"last_imeni_uollesa_brina"},
        dep = {nil, {"odz1","next_vhe"}},
        dist = 40,
        noises = {2,1},noiserandom = 0.2,
    }
})

Metrostroi.AddSarmatUPOAnnouncer("UPO RHINO", {
    tone = {"subway_announcers/sarmat_upo/tone.mp3", 1.2},
    aeroport = {"subway_announcers/sarmat_upo/rhino/orange/aeroport.mp3", 0.835200},
    arsenal = {"subway_announcers/sarmat_upo/rhino/orange/arsenal.mp3", 0.678600},
    flora = {"subway_announcers/sarmat_upo/rhino/orange/flora.mp3", 0.600300},
    gcfscape = {"subway_announcers/sarmat_upo/rhino/orange/gcfscape.mp3", 1.174500},
    ikarus = {"subway_announcers/sarmat_upo/rhino/orange/ikarus.mp3", 0.652500},
    imeni_uollesa_brina = {"subway_announcers/sarmat_upo/rhino/orange/imeni_uollesa_brina.mp3", 1.278900},
    last_aeroport = {"subway_announcers/sarmat_upo/rhino/orange/last_aeroport.mp3", 9.787500},
    last_ikarus = {"subway_announcers/sarmat_upo/rhino/orange/last_ikarus.mp3", 9.944100},
    last_imeni_uollesa_brina = {"subway_announcers/sarmat_upo/rhino/orange/last_imeni_uollesa_brina.mp3", 10.779300},
    last_park = {"subway_announcers/sarmat_upo/rhino/orange/last_park.mp3", 10.935900},
    litievaya = {"subway_announcers/sarmat_upo/rhino/orange/litievaya.mp3", 0.730800},
    next_aeroport = {"subway_announcers/sarmat_upo/rhino/orange/next_aeroport.mp3", 1.879200},
    next_arsenal = {"subway_announcers/sarmat_upo/rhino/orange/next_arsenal.mp3", 1.800900},
    next_flora = {"subway_announcers/sarmat_upo/rhino/orange/next_flora.mp3", 1.539900},
    next_gcfscape = {"subway_announcers/sarmat_upo/rhino/orange/next_gcfscape.mp3", 3.732300},
    next_gcfscape1 = {"subway_announcers/sarmat_upo/rhino/orange/next_gcfscape1.mp3", 2.166300},
    next_ikarus = {"subway_announcers/sarmat_upo/rhino/orange/next_ikarus.mp3", 1.696500},
    next_imeni_uollesa_brina = {"subway_announcers/sarmat_upo/rhino/orange/next_imeni_uollesa_brina.mp3", 2.427300},
    next_litievaya = {"subway_announcers/sarmat_upo/rhino/orange/next_litievaya.mp3", 1.722600},
    next_park = {"subway_announcers/sarmat_upo/rhino/orange/next_park.mp3", 3.053700},
    next_park1 = {"subway_announcers/sarmat_upo/rhino/orange/next_park1.mp3", 1.487700},
    next_slavnaya_strana = {"subway_announcers/sarmat_upo/rhino/orange/next_slavnaya_strana.mp3", 1.983600},
    next_slavutich = {"subway_announcers/sarmat_upo/rhino/orange/next_slavutich.mp3", 1.774800},
    next_smrc = {"subway_announcers/sarmat_upo/rhino/orange/next_smrk.mp3", 1.931400},
    next_vhe = {"subway_announcers/sarmat_upo/rhino/orange/next_vhe.mp3", 2.322900},
    odz1 = {"subway_announcers/sarmat_upo/rhino/orange/odz1.mp3", 2.088000},
    odz2 = {"subway_announcers/sarmat_upo/rhino/orange/odz2.mp3", 2.192400},
    park = {"subway_announcers/sarmat_upo/rhino/orange/park.mp3", 0.469800},
    slavnaya_strana = {"subway_announcers/sarmat_upo/rhino/orange/slavnaya_strana.mp3", 1.017900},
    slavutich = {"subway_announcers/sarmat_upo/rhino/orange/slavutich.mp3", 0.809100},
    smrk = {"subway_announcers/sarmat_upo/rhino/orange/smrk.mp3", 0.809100},
    spec_attention_handrails = {"subway_announcers/sarmat_upo/rhino/orange/spec_attention_handrails.mp3", 3.967200},
    spec_attention_politeness = {"subway_announcers/sarmat_upo/rhino/orange/spec_attention_politeness.mp3", 5.533200},
    spec_line1 = {"subway_announcers/sarmat_upo/rhino/orange/spec_line1.mp3", 1.800900},
    spec_line5 = {"subway_announcers/sarmat_upo/rhino/orange/spec_line5.mp3", 1.722600},
    spec_line6 = {"subway_announcers/sarmat_upo/rhino/orange/spec_line6.mp3", 1.957500},
    spec_line4 = {"subway_announcers/sarmat_upo/rhino/orange/spec_line4.mp3", 1.905300},
    spec_line5 = {"subway_announcers/sarmat_upo/rhino/orange/spec_line5.mp3", 1.748700},
    spec_line6 = {"subway_announcers/sarmat_upo/rhino/orange/spec_line6.mp3", 1.722600},
    vhe = {"subway_announcers/sarmat_upo/rhino/orange/vhe.mp3", 1.096200}
},{
    {
        LED = {2, 2, 3, 3, 4, 3, 3, 3, 3, 3, 3},
        Name = "Line 1",
        -- Loop = false,
        {
            462,"Икарус","Ikarus",
            arrlast = {nil, "last_ikarus"},
            dep = {"next_smrc", nil},
            odz = "odz1",
            dist = 40,
        },
        {
            461,"СМРК","SMRC",
            arr = {{"smrk", 3, "next_flora",0.4,"spec_attention_politeness"}, {"smrk", 3, "next_ikarus",0.4,"spec_attention_handrails"}},
            dep = {"next_flora", "next_ikarus"},
            odz = "odz1",
            dist = 40,
        },
        {
            460,"Флора","Flora",
            arr = {{"flora", 3, "next_aeroport"}, {"flora", 3, "next_smrc",0.4,"spec_attention_politeness"}},
            dep = {"next_aeroport", "next_smrc"},
            odz = "odz2",
            dist = 40,
        },
        {
            458,"Аэропорт","Airport",
            arr = {{"aeroport", 3, "next_slavnaya_strana", "spec_line6"}, {"aeroport", 3, "next_flora",0.4,"spec_attention_handrails"}},
            dep = {"next_slavnaya_strana", "next_flora"},
            arrlast = {"last_aeroport", "last_aeroport"},
            odz = "odz2",
            dist = 40,
        },
        {
            457,"Славная стр.","Glorius c.",
            arr = {{"slavnaya_strana", 3, "next_litievaya", "spec_line5"}, {"slavnaya_strana", 3, "next_aeroport",0.4,"spec_attention_politeness"}},
            dep = {"next_litievaya", "next_aeroport"},
            odz = "odz1",
            dist = 40,
        },
        {
            456,"Литиевая","Lithium",
            arr = {{"litievaya", 3, "next_arsenal",0.4,"spec_attention_handrails"}, {"litievaya", 3, "next_slavnaya_strana", "spec_line6"}},
            dep = {"next_arsenal", "next_slavnaya_strana"},
            odz = "odz2",
            dist = 40,
        },
        {
            455,"Арсенал","Arsenal",
            arr = {{"arsenal", 3, "next_park", "spec_line6"}, {"arsenal", 3, "next_litievaya", "spec_line5",0.4,"spec_attention_politeness"}},
            dep = {"next_park1", "next_litievaya"},
            odz = "odz1",
            dist = 40,
        },
        {
            454,"Парк","Park",
            arr = {{"park", 3, "next_gcfscape",0.4,"spec_attention_politeness"}, {"park", 3, "next_arsenal",0.4,"spec_attention_handrails"}},
            dep = {"next_gcfscape1", "next_arsenal"},
            arrlast = {{"last_park", "spec_line6"}, {"last_park", "spec_line6"}},
            odz = "odz2",
            dist = 40,
        },
        {
            453,"GCFScape","GCFScape",
            arr = {{"gcfscape", 3, "next_vhe",0.4,"spec_attention_handrails"}, {"gcfscape", 3, "next_park", "spec_line6"}},
            dep = {"next_vhe", "next_park1"},
            odz = "odz2",
            dist = 40,
        },
        {
            452,"VHE","VHE",
            arr = {{"vhe", 3, "next_imeni_uollesa_brina"}, {"vhe", 3, "next_gcfscape",0.4,"spec_attention_politeness"}},
            dep = {"next_imeni_uollesa_brina", "next_gcfscape1"},
            odz = "odz1",
            dist = 40,
        },
        {
            451,"У. Брина","W. Breen",
            arrlast = {"last_imeni_uollesa_brina"},
            dep = {nil, "next_vhe"},
            odz = "odz1",
            dist = 40,
        }
    }
})

Metrostroi.AddANSPAnnouncer("ASNP Boiko + Pyaseckaya",{
    asnp = true,

    click1 = {"subway_announcers/asnp/boiko_new/click1.mp3",0.5},
    click2 = {"subway_announcers/asnp/boiko_new/click2.mp3",0.3},
    click3 = {"subway_announcers/asnp/boiko_new/click3.mp3",0.3},
    click_start = {"subway_announcers/asnp/boiko_new/click1.mp3",0.5},
    click_end = {"subway_announcers/asnp/boiko_new/click3.mp3",0.3},

    announcer_ready = {"subway_announcers/asnp/boiko_new/announcer_ready.mp3",3.295479},
    doors_closing_m = {"subway_announcers/asnp/boiko_new/doors_closing.mp3",3.782542},
    deadlock_m = {"subway_announcers/asnp/boiko_new/spec_attention_deadlock.mp3",9.352500},
    exit_m = {"subway_announcers/asnp/boiko_new/spec_attention_exit.mp3",5.363563},
    handrails_m = {"subway_announcers/asnp/boiko_new/spec_attention_handrails.mp3",4.221854},
    last_m = {"subway_announcers/asnp/boiko_new/spec_attention_last.mp3",4.425625},
    objects_m = {"subway_announcers/asnp/boiko_new/spec_attention_objects.mp3",4.674771},
    politeness_m = {"subway_announcers/asnp/boiko_new/spec_attention_politeness.mp3",9.057104},
    things_m = {"subway_announcers/asnp/boiko_new/spec_attention_things.mp3",4.559146},
    train_depeat_m = {"subway_announcers/asnp/boiko_new/spec_attention_train_depeat.mp3",4.633417},
    train_stop_m = {"subway_announcers/asnp/boiko_new/spec_attention_train_stop.mp3",6.501979},
    station_m = {"subway_announcers/asnp/boiko_new/station.mp3",0.943438},
    train_goes_to_m = {"subway_announcers/asnp/boiko_new/train_goes_to.mp3",2.077708},


    aeroport_m = {"subway_announcers/asnp/boiko_new/neoorange/aeroport.mp3",0.936042},
    arsenal_m = {"subway_announcers/asnp/boiko_new/neoorange/arsenal.mp3",0.897958},
    flora_m = {"subway_announcers/asnp/boiko_new/neoorange/flora.mp3",0.713271},
    gcfscape_m = {"subway_announcers/asnp/boiko_new/neoorange/gcfscape.mp3",2.977167},
    ikarus_m = {"subway_announcers/asnp/boiko_new/neoorange/ikarus.mp3",0.767938},
    imeni_uollesa_brina_m = {"subway_announcers/asnp/boiko_new/neoorange/imeni_uollesa_brina.mp3",1.710667},
    litiyevaya_arr_m = {"subway_announcers/asnp/boiko_new/neoorange/litiyevaya_arr.mp3",3.008667},
    litiyevaya_next_m = {"subway_announcers/asnp/boiko_new/neoorange/litiyevaya_next.mp3",1.011000},
    park_m = {"subway_announcers/asnp/boiko_new/neoorange/park.mp3",0.600000},
    park_arr_m = {"subway_announcers/asnp/boiko_new/neoorange/park_arr.mp3",3.896833},
    park_next_m = {"subway_announcers/asnp/boiko_new/neoorange/park_next.mp3",2.024271},
    slavnaya_strana_arr_m = {"subway_announcers/asnp/boiko_new/neoorange/slavnaya_strana_next.mp3",3.397833},
    slavnaya_strana_next_m = {"subway_announcers/asnp/boiko_new/neoorange/slavnaya_strana_arr.mp3",1.482604},
    smrc_m = {"subway_announcers/asnp/boiko_new/neoorange/smrc.mp3",1.083688},
    spec_attention_aeroport_m = {"subway_announcers/asnp/boiko_new/neoorange/spec_attention_aeroport.mp3",11.032125},
    vhe_m = {"subway_announcers/asnp/boiko_new/neoorange/vhe.mp3",1.387604},


    doors_closing_f = {"subway_announcers/asnp/pyaseckaya/doors_closing.mp3",2.340813},
    deadlock_f = {"subway_announcers/asnp/pyaseckaya/spec_attention_deadlock.mp3",10.501979},
    exit_f = {"subway_announcers/asnp/pyaseckaya/spec_attention_exit.mp3",5.111104},
    handrails_f = {"subway_announcers/asnp/pyaseckaya/spec_attention_handrails.mp3",4.675083},
    last_f = {"subway_announcers/asnp/pyaseckaya/spec_attention_last.mp3",4.878542},
    objects_f = {"subway_announcers/asnp/pyaseckaya/spec_attention_objects.mp3",5.323146},
    politeness_f = {"subway_announcers/asnp/pyaseckaya/spec_attention_politeness.mp3",10.685375},
    things_f = {"subway_announcers/asnp/pyaseckaya/spec_attention_things.mp3",5.144021},
    train_depeat_f = {"subway_announcers/asnp/pyaseckaya/spec_attention_train_depeat.mp3",4.481875},
    train_stop_f = {"subway_announcers/asnp/pyaseckaya/spec_attention_train_stop.mp3",6.395313},

    aeroport_f = {"subway_announcers/asnp/pyaseckaya/neoorange/aeroport.mp3",0.913667},
    arr_aeroport_f = {"subway_announcers/asnp/pyaseckaya/neoorange/arr_aeroport.mp3",1.800000},
    arr_arsenal_f = {"subway_announcers/asnp/pyaseckaya/neoorange/arr_arsenal.mp3",1.895021},
    arr_flora_f = {"subway_announcers/asnp/pyaseckaya/neoorange/arr_flora.mp3",1.536813},
    arr_gcfscape_f = {"subway_announcers/asnp/pyaseckaya/neoorange/arr_gcfscape.mp3",3.838000},
    arr_ikarus_f = {"subway_announcers/asnp/pyaseckaya/neoorange/arr_ikarus.mp3",1.810500},
    arr_imeni_uollesa_brina_f = {"subway_announcers/asnp/pyaseckaya/neoorange/arr_imeni_uollesa_brina.mp3",2.713104},
    arr_litiyevaya_f = {"subway_announcers/asnp/pyaseckaya/neoorange/arr_litiyevaya.mp3",4.139396},
    arr_park_f = {"subway_announcers/asnp/pyaseckaya/neoorange/arr_park.mp3",5.076708},
    arr_slavnaya_strana_f = {"subway_announcers/asnp/pyaseckaya/neoorange/arr_slavnaya_strana.mp3",4.527333},
    arr_smrc_f = {"subway_announcers/asnp/pyaseckaya/neoorange/arr_smrc.mp3",1.941479},
    arr_vhe_f = {"subway_announcers/asnp/pyaseckaya/neoorange/arr_vhe.mp3",2.162292},
    ikarus_f = {"subway_announcers/asnp/pyaseckaya/neoorange/ikarus.mp3",1.029813},
    next_aeroport_f = {"subway_announcers/asnp/pyaseckaya/neoorange/next_aeroport.mp3",2.693333},
    next_arsenal_f = {"subway_announcers/asnp/pyaseckaya/neoorange/next_arsenal.mp3",2.515958},
    next_flora_f = {"subway_announcers/asnp/pyaseckaya/neoorange/next_flora.mp3",2.473229},
    next_gcfscape_f = {"subway_announcers/asnp/pyaseckaya/neoorange/next_gcfscape.mp3",4.695188},
    next_ikarus_f = {"subway_announcers/asnp/pyaseckaya/neoorange/next_ikarus.mp3",2.365021},
    next_imeni_uollesa_brina_f = {"subway_announcers/asnp/pyaseckaya/neoorange/next_imeni_uollesa_brina.mp3",3.516208},
    next_litiyevaya_f = {"subway_announcers/asnp/pyaseckaya/neoorange/next_litiyevaya.mp3",2.865813},
    next_park_f = {"subway_announcers/asnp/pyaseckaya/neoorange/next_park.mp3",3.773146},
    next_slavnaya_strana_f = {"subway_announcers/asnp/pyaseckaya/neoorange/next_slavnaya_strana.mp3",3.161896},
    next_smrc_f = {"subway_announcers/asnp/pyaseckaya/neoorange/next_smrc.mp3",2.622750},
    next_vhe_f = {"subway_announcers/asnp/pyaseckaya/neoorange/next_vhe.mp3",2.779979},
    park_f = {"subway_announcers/asnp/pyaseckaya/neoorange/park.mp3",0.625875},
    spec_attention_aeroport3_f = {"subway_announcers/asnp/pyaseckaya/neoorange/spec_attention_aeroport3.mp3",11.147292},
    to_aeroport_f = {"subway_announcers/asnp/pyaseckaya/neoorange/to_aeroport.mp3",3.230083},
    to_park_f = {"subway_announcers/asnp/pyaseckaya/neoorange/to_park.mp3",2.990750},
},{
    {
        LED = {2, 1, 2, 3, 3, 3, 3, 3, 3, 3, 4},
        Name = "Line 1",
        spec_last = {"last_m",0.5,"things_m"},
        spec_last_f = {"last_f",0.5,"things_f"},
        spec_wait = {{"train_stop_m"},{"train_depeat_m"}},
        spec_wait_f = {{"train_stop_f"},{"train_depeat_f"}},
        Loop = false,
        BlockDoors = true,
        {
            462, "Икарус","Ikarus",
            arrlast = {nil, {"arr_ikarus_f",0.5,"last_f",2,"things_f",2,"deadlock_f"}, "ikarus_m"},
            dep = {{"doors_closing_m","smrc_m",0.1,"politeness_m"}},
            not_last_c = {nil,"not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
        },
        {
            461, "СМРК","SMRC",
            arr = {{"station_m","smrc_m"}, "arr_smrc_f"},
            dep = {{"doors_closing_m","flora_m", 0.1,"handrails_m"}, {"doors_closing_f","next_ikarus_f"}},
            not_last_c = {nil,"not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
        },
        {
            460, "Флора","Flora",
            arr = {{"station_m","flora_m"}, "arr_flora_f"},
            dep = {{"doors_closing_m","aeroport_m", 0.1,"things_m"}, {"doors_closing_f","next_smrc_f",0.1,"handrails_f"}},
            not_last_c = {nil,"not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
        },
        {
            458, "Аэропорт","Airport",
            arr = {{"station_m","aeroport_m",0.1,"objects_m"}, {"arr_aeroport_f",0.1,"things_f"}},
            dep = {{"doors_closing_m","slavnaya_strana_next_m"}, {"doors_closing_f","next_flora_f",0.1,"politeness_f"}},
            arrlast = {{"station_m","aeroport_m",0.5,"last_m",2,"things_m",2,"deadlock_m"}, {"arr_aeroport_f",0.5,"last_f",2,"things_f",2,"deadlock_f"}, "aeroport_m"},
            not_last = {3,"train_goes_to_m","aeroport_m"},
            not_last_f = {3,"to_aeroport_f"},
            not_last_c = {nil,"not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
            --not_last_c = {nil,"not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
        },
        {
            457, "Славная стр.","Glorius c.",
            arr = {{"station_m","slavnaya_strana_arr_m"}, "arr_slavnaya_strana_f"},
            dep = {{"doors_closing_m","litiyevaya_next_m",0.1,"politeness_m"}, {"doors_closing_f","next_aeroport_f"}},
            not_last_c = {nil,"not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
            have_interchange = true
        },
        {
            --male<->female
            456, "Литиевая","Lithium",
            arr = {{"station_m","litiyevaya_arr_m"}, {"station_m","litiyevaya_arr_m"}},
            dep = {{"doors_closing_f","next_arsenal_f"}, {"doors_closing_f","next_slavnaya_strana_f",0.1,"objects_f"}},
            not_last_c = {nil,"not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
            have_interchange = true
        },
        {
            455, "Арсенал","Arsenal",
            arr = {"arr_arsenal_f", {"station_m","arsenal_m"}},
            dep = {{"doors_closing_f","next_park_f",0.1,"handrails_f"}, {"doors_closing_m","litiyevaya_next_m",0.1,"handrails_m"}},
            not_last_c = {nil,"not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
        },
        {
            454, "Парк","Park",
            arr = {{"arr_park_f", 0.1,"things_f"}, {"station_m","park_arr_m",0.1,"things_m"}},
            dep = {{"doors_closing_f","next_gcfscape_f"}, {"doors_closing_m","arsenal_m",0.1,"objects_m"}},
            arrlast = {{"arr_park_f",0.5,"last_f",2,"things_f",2,"deadlock_f"}, {"station_m","park_arr_m",0.5,"last_m",2,"things_m",2,"deadlock_m"}, "aeroport_m"},
            not_last = {3,"train_goes_to_m","park_m"},
            not_last_f = {3,"to_park_f"},
            not_last_c = {nil,"not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
            have_interchange = true,
            right_doors = true,
        },
        {
            453, "GCFScape",
            arr = {"arr_gcfscape_f", {"station_m","gcfscape_m"}},
            dep = {{"doors_closing_f","next_vhe_f"}, {"doors_closing_m","park_next_m",0.1,"politeness_m"}},
            not_last_c = {"not_last_f"},spec_last_c = {"spec_last_f"}, spec_wait_c = {"spec_wait_f"},
            right_doors = true,
        },
        {
            452, "VHE",
            arr = {"arr_vhe_f", {"station_m","vhe_m"}},
            dep = {{"doors_closing_f","next_imeni_uollesa_brina_f",0.1,"exit_f"}, {"doors_closing_m","gcfscape_m"}},
            not_last_c = {"not_last_f"},spec_last_c = {"spec_last_f"}, spec_wait_c = {"spec_wait_f"},
            have_interchange = true
        },
        {
            451, "У. Брина","W. Breen",
            arrlast = {{"arr_imeni_uollesa_brina_f",0.5,"last_f",2,"things_f",2,"deadlock_f"}, nil, "imeni_uollesa_brina_m"},
            dep = {nil, {"doors_closing_m","vhe_m",0.1,"politeness_m"}},
            not_last_c = {"not_last_f"},spec_last_c = {"spec_last_f"}, spec_wait_c = {"spec_wait_f"},
        }
    }
})



Metrostroi.AddANSPAnnouncer("RIU Boiko + Pyaseckaya",{
    riu  = true,

    click1 = {"subway_announcers/riu/boiko_new/click1.mp3",0.5},
    click2 = {"subway_announcers/riu/boiko_new/click2.mp3",0.3},
    click3 = {"subway_announcers/riu/boiko_new/click3.mp3",0.3},
    click_start = {"subway_announcers/riu/boiko_new/click1.mp3",0.5},
    click_end = {"subway_announcers/riu/boiko_new/click3.mp3",0.3},


    announcer_ready = {"subway_announcers/riu/boiko_new/announcer_ready.mp3",3.785},
    doors_closing_m = {"subway_announcers/riu/boiko_new/doors_closing.mp3",5},
    deadlock_m = {"subway_announcers/riu/boiko_new/spec_attention_deadlock.mp3",9.608},
    exit_m = {"subway_announcers/riu/boiko_new/spec_attention_exit.mp3",5.985},
    handrails_m = {"subway_announcers/riu/boiko_new/spec_attention_handrails.mp3",4.929},
    last_m = {"subway_announcers/riu/boiko_new/spec_attention_last.mp3",4.556},
    objects_m = {"subway_announcers/riu/boiko_new/spec_attention_objects.mp3",5.278},
    politeness_m = {"subway_announcers/riu/boiko_new/spec_attention_politeness.mp3",10.335},
    things_m = {"subway_announcers/riu/boiko_new/spec_attention_things.mp3",5.101},
    train_depeat_m = {"subway_announcers/riu/boiko_new/spec_attention_train_depeat.mp3",5.209},
    train_stop_m = {"subway_announcers/riu/boiko_new/spec_attention_train_stop.mp3",7.370},
    station_m = {"subway_announcers/riu/boiko_new/station.mp3",1.2},
    train_goes_to_m = {"subway_announcers/riu/boiko_new/train_goes_to.mp3",2.540},

    aeroport_m = {"subway_announcers/riu/boiko_new/neoorange/aeroport.mp3",0.967891},
    arsenal_m = {"subway_announcers/riu/boiko_new/neoorange/arsenal.mp3",1.054218},
    flora_m = {"subway_announcers/riu/boiko_new/neoorange/flora.mp3",0.831474},
    gcfscape_m = {"subway_announcers/riu/boiko_new/neoorange/gcfscape.mp3",3.509569},
    ikarus_m = {"subway_announcers/riu/boiko_new/neoorange/ikarus.mp3",0.937528},
    imeni_uollesa_brina_m = {"subway_announcers/riu/boiko_new/neoorange/imeni_uollesa_brina.mp3",1.850499},
    litiyevaya_arr_m = {"subway_announcers/riu/boiko_new/neoorange/litiyevaya_arr.mp3",3.323265},
    litiyevaya_next_m = {"subway_announcers/riu/boiko_new/neoorange/litiyevaya_next.mp3",1.072630},
    park_m = {"subway_announcers/riu/boiko_new/neoorange/park.mp3",0.777211},
    park_arr_m = {"subway_announcers/riu/boiko_new/neoorange/park_arr.mp3",4.777211},
    park_next_m = {"subway_announcers/riu/boiko_new/neoorange/park_next.mp3",2.277211},
    slavnaya_strana_arr_m = {"subway_announcers/riu/boiko_new/neoorange/slavnaya_strana_arr.mp3",3.743923},
    slavnaya_strana_next_m = {"subway_announcers/riu/boiko_new/neoorange/slavnaya_strana_next.mp3",1.543129},
    smrc_m = {"subway_announcers/riu/boiko_new/neoorange/smrc.mp3",1.282971},
    spec_attention_aeroport_m = {"subway_announcers/riu/boiko_new/neoorange/spec_attention_aeroport.mp3",11.860317},
    vhe_m = {"subway_announcers/riu/boiko_new/neoorange/vhe.mp3",1.384308},

    doors_closing_f = {"subway_announcers/riu/pyaseckaya/doors_closing.mp3",2.994},
    deadlock_f = {"subway_announcers/riu/pyaseckaya/spec_attention_deadlock.mp3",10.133},
    exit_f = {"subway_announcers/riu/pyaseckaya/spec_attention_exit.mp3",5.466},
    handrails_f = {"subway_announcers/riu/pyaseckaya/spec_attention_handrails.mp3",4.744},
    last_f = {"subway_announcers/riu/pyaseckaya/spec_attention_last.mp3",4.506},
    objects_f = {"subway_announcers/riu/pyaseckaya/spec_attention_objects.mp3",5.219},
    politeness_f = {"subway_announcers/riu/pyaseckaya/spec_attention_politeness.mp3",10.221},
    things_f = {"subway_announcers/riu/pyaseckaya/spec_attention_things.mp3",5.154},
    train_depeat_f = {"subway_announcers/riu/pyaseckaya/spec_attention_train_depeat.mp3",4.829},
    train_stop_f = {"subway_announcers/riu/pyaseckaya/spec_attention_train_stop.mp3",7.240},


    aeroport_f = {"subway_announcers/riu/pyaseckaya/neoorange/aeroport.mp3",0.919796},
    arr_aeroport_f = {"subway_announcers/riu/pyaseckaya/neoorange/arr_aeroport.mp3",1.757120},
    arr_arsenal_f = {"subway_announcers/riu/pyaseckaya/neoorange/arr_arsenal.mp3",1.782177},
    arr_flora_f = {"subway_announcers/riu/pyaseckaya/neoorange/arr_flora.mp3",1.500068},
    arr_gcfscape_f = {"subway_announcers/riu/pyaseckaya/neoorange/arr_gcfscape.mp3",3.953605},
    arr_ikarus_f = {"subway_announcers/riu/pyaseckaya/neoorange/arr_ikarus.mp3",1.826327},
    arr_imeni_uollesa_brina_f = {"subway_announcers/riu/pyaseckaya/neoorange/arr_imeni_uollesa_brina.mp3",2.669433},
    arr_litiyevaya_f = {"subway_announcers/riu/pyaseckaya/neoorange/arr_litiyevaya.mp3",4.173039},
    arr_park_f = {"subway_announcers/riu/pyaseckaya/neoorange/arr_park.mp3",5.374286},
    arr_slavnaya_strana_f = {"subway_announcers/riu/pyaseckaya/neoorange/arr_slavnaya_strana.mp3",4.443878},
    arr_smrc_f = {"subway_announcers/riu/pyaseckaya/neoorange/arr_smrc.mp3",1.938571},
    arr_vhe_f = {"subway_announcers/riu/pyaseckaya/neoorange/arr_vhe.mp3",2.146213},
    ikarus_f = {"subway_announcers/riu/pyaseckaya/neoorange/ikarus.mp3",0.887551},
    next_aeroport_f = {"subway_announcers/riu/pyaseckaya/neoorange/next_aeroport.mp3",2.785510},
    next_arsenal_f = {"subway_announcers/riu/pyaseckaya/neoorange/next_arsenal.mp3",2.537188},
    next_flora_f = {"subway_announcers/riu/pyaseckaya/neoorange/next_flora.mp3",2.504785},
    next_gcfscape_f = {"subway_announcers/riu/pyaseckaya/neoorange/next_gcfscape.mp3",4.949478},
    next_ikarus_f = {"subway_announcers/riu/pyaseckaya/neoorange/next_ikarus.mp3",2.355102},
    next_imeni_uollesa_brina_f = {"subway_announcers/riu/pyaseckaya/neoorange/next_imeni_uollesa_brina.mp3",3.467687},
    next_litiyevaya_f = {"subway_announcers/riu/pyaseckaya/neoorange/next_litiyevaya.mp3",2.990249},
    next_park_f = {"subway_announcers/riu/pyaseckaya/neoorange/next_park.mp3",3.788617},
    next_slavnaya_strana_f = {"subway_announcers/riu/pyaseckaya/neoorange/next_slavnaya_strana.mp3",3.204467},
    next_smrc_f = {"subway_announcers/riu/pyaseckaya/neoorange/next_smrc.mp3",2.746145},
    next_vhe_f = {"subway_announcers/riu/pyaseckaya/neoorange/next_vhe.mp3",2.763560},
    park_f = {"subway_announcers/riu/pyaseckaya/neoorange/park.mp3",0.596961},
    spec_attention_aeroport3_f = {"subway_announcers/riu/pyaseckaya/neoorange/spec_attention_aeroport3.mp3",11.945805},
    to_aeroport_f = {"subway_announcers/riu/pyaseckaya/neoorange/to_aeroport.mp3",3.273401},
    to_park_f = {"subway_announcers/riu/pyaseckaya/neoorange/to_park.mp3",3.055488},
},{
    {
        LED = {2, 1, 2, 3, 3, 3, 3, 3, 3, 3, 4},
        Name = "Line 1",
        spec_last = {"last_m",0.5,"things_m"},
        spec_last_f = {"last_f",0.5,"things_f"},
        spec_wait = {{"train_stop_m"},{"train_depeat_m"}},
        spec_wait_f = {{"train_stop_f"},{"train_depeat_f"}},
        Loop = false,
        BlockDoors = true,
        {
            462, "Икарус","Ikarus",
            arrlast = {nil, {"arr_ikarus_f",0.5,"last_f",2,"things_f",2,"deadlock_f"}, "ikarus_m"},
            dep = {{"doors_closing_m","smrc_m",0.1,"politeness_m"}},
            not_last_c = {nil,"not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
        },
        {
            461, "СМРК","SMRC",
            arr = {{"station_m","smrc_m"}, "arr_smrc_f"},
            dep = {{"doors_closing_m","flora_m", 0.1,"handrails_m"}, {"doors_closing_f","next_ikarus_f"}},
            not_last_c = {nil,"not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
        },
        {
            460, "Флора","Flora",
            arr = {{"station_m","flora_m"}, "arr_flora_f"},
            dep = {{"doors_closing_m","aeroport_m", 0.1,"things_m"}, {"doors_closing_f","next_smrc_f",0.1,"handrails_f"}},
            not_last_c = {nil,"not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
        },
        {
            458, "Аэропорт","Airport",
            arr = {{"station_m","aeroport_m",0.1,"objects_m"}, {"arr_aeroport_f",0.1,"things_f"}},
            dep = {{"doors_closing_m","slavnaya_strana_next_m"}, {"doors_closing_f","next_flora_f",0.1,"politeness_f"}},
            arrlast = {{"station_m","aeroport_m",0.5,"last_m",2,"things_m",2,"deadlock_m"}, {"arr_aeroport_f",0.5,"last_f",2,"things_f",2,"deadlock_f"}, "aeroport_m"},
            not_last = {3,"train_goes_to_m","aeroport_m"},
            not_last_f = {3,"to_aeroport_f"},
            not_last_c = {nil,"not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
        },
        {
            457, "Славная стр.","Glorius c.",
            arr = {{"station_m","slavnaya_strana_arr_m"}, "arr_slavnaya_strana_f"},
            dep = {{"doors_closing_m","litiyevaya_next_m",0.1,"politeness_m"}, {"doors_closing_f","next_aeroport_f"}},
            not_last_c = {nil,"not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
            have_interchange = true
        },
        {
            --male<->female
            456, "Литиевая","Lithium",
            arr = {{"station_m","litiyevaya_arr_m"}, {"station_m","litiyevaya_arr_m"}},
            dep = {{"doors_closing_f","next_arsenal_f"}, {"doors_closing_f","next_slavnaya_strana_f",0.1,"objects_f"}},
            not_last_c = {nil,"not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
            have_interchange = true
        },
        {
            455, "Арсенал","Arsenal",
            arr = {"arr_arsenal_f", {"station_m","arsenal_m"}},
            dep = {{"doors_closing_f","next_park_f",0.1,"handrails_f"}, {"doors_closing_m","litiyevaya_next_m",0.1,"handrails_m"}},
            not_last_c = {"not_last_f"},spec_last_c = {"spec_last_f"}, spec_wait_c = {"spec_wait_f"},
        },
        {
            454, "Парк","Park",
            arr = {{"arr_park_f", 0.1,"things_f"}, {"station_m","park_arr_m",0.1,"things_m"}},
            dep = {{"doors_closing_f","next_gcfscape_f"}, {"doors_closing_m","arsenal_m",0.1,"objects_m"}},
            arrlast = {{"arr_park_f",0.5,"last_f",2,"things_f",2,"deadlock_f"}, {"station_m","park_arr_m",0.5,"last_m",2,"things_m",2,"deadlock_m"}, "aeroport_m"},
            not_last = {3,"train_goes_to_m","park_m"},
            not_last_f = {3,"to_park_f"},
            not_last_c = {"not_last_f"},spec_last_c = {"spec_last_f"}, spec_wait_c = {"spec_wait_f"},
            right_doors = true,
            have_interchange = true
        },
        {
            453, "GCFScape",
            arr = {"arr_gcfscape_f", {"station_m","gcfscape_m"}},
            dep = {{"doors_closing_f","next_vhe_f"}, {"doors_closing_m","park_next_m",0.1,"politeness_m"}},
            not_last_c = {"not_last_f"},spec_last_c = {"spec_last_f"}, spec_wait_c = {"spec_wait_f"},
            right_doors = true,
        },
        {
            452, "VHE",
            arr = {"arr_vhe_f", {"station_m","vhe_m"}},
            dep = {{"doors_closing_f","next_imeni_uollesa_brina_f",0.1,"exit_f"}, {"doors_closing_m","gcfscape_m"}},
            not_last_c = {"not_last_f"},spec_last_c = {"spec_last_f"}, spec_wait_c = {"spec_wait_f"},
            have_interchange = true
        },
        {
            451, "У. Брина","W. Breen",
            arrlast = {{"arr_imeni_uollesa_brina_f",0.5,"last_f",2,"things_f",2,"deadlock_f"}, nil, "imeni_uollesa_brina_m"},
            dep = {nil, {"doors_closing_m","vhe_m",0.1,"politeness_m"}},
            not_last_c = {"not_last_f"},spec_last_c = {"spec_last_f"}, spec_wait_c = {"spec_wait_f"},
        }
    }
})

Metrostroi.SetRRIAnnouncer({
    click_end = {"subway_announcers/rri/boiko/spec/click_end.mp3",0.1},
    click_start = {"subway_announcers/rri/boiko/spec/click_start.mp3",0.1},
    last = {"subway_announcers/rri/boiko/spec/last.mp3",22.264354},
    exit = {"subway_announcers/rri/boiko/spec/spec_attention_exit.mp3",5.446236},
    handrails = {"subway_announcers/rri/boiko/spec/spec_attention_handrails.mp3",4.594558},
    objects = {"subway_announcers/rri/boiko/spec/spec_attention_objects.mp3",5.143175},
    things = {"subway_announcers/rri/boiko/spec/spec_attention_things.mp3",05.093},
    politeness = {"subway_announcers/rri/boiko/spec/spec_attention_politeness.mp3",11.457075},
    train_depeat = {"subway_announcers/rri/boiko/spec/spec_attention_train_depeat.mp3",4.842222},
    train_stop = {"subway_announcers/rri/boiko/spec/spec_attention_train_stop.mp3",6.963424},

    arr_aeroport = {"subway_announcers/rri/boiko/orange/arr_aeroport.mp3",1.884000},
    arr_arsenal = {"subway_announcers/rri/boiko/orange/arr_arsenal.mp3",1.939388},
    arr_flora = {"subway_announcers/rri/boiko/orange/arr_flora.mp3",1.813628},
    arr_gcfscape = {"subway_announcers/rri/boiko/orange/arr_gcfscape.mp3",3.924717},
    arr_ikarus = {"subway_announcers/rri/boiko/orange/arr_ikarus.mp3",2.137075},
    arr_imeni_uollesa_brina = {"subway_announcers/rri/boiko/orange/arr_imeni_uollesa_brina.mp3",2.906961},
    arr_litiyevaya = {"subway_announcers/rri/boiko/orange/arr_litiyevaya.mp3",3.487029},
    arr_park = {"subway_announcers/rri/boiko/orange/arr_park.mp3",4.575147},
    arr_slavnaya_strana = {"subway_announcers/rri/boiko/orange/arr_slavnaya_strana.mp3",2.483492},
    arr_smrc = {"subway_announcers/rri/boiko/orange/arr_smrc.mp3",2.227914},
    arr_vhe = {"subway_announcers/rri/boiko/orange/arr_vhe.mp3",2.472018},
    next_aeroport = {"subway_announcers/rri/boiko/orange/next_aeroport.mp3",4.956000},
    next_arsenal = {"subway_announcers/rri/boiko/orange/next_arsenal.mp3",5.055873},
    next_flora = {"subway_announcers/rri/boiko/orange/next_flora.mp3",5.021905},
    next_gcfscape = {"subway_announcers/rri/boiko/orange/next_gcfscape.mp3",7.011995},
    next_ikarus = {"subway_announcers/rri/boiko/orange/next_ikarus.mp3",5.147483},
    next_imeni_uollesa_brina = {"subway_announcers/rri/boiko/orange/next_imeni_uollesa_brina.mp3",5.538209},
    next_litiyevaya = {"subway_announcers/rri/boiko/orange/next_litiyevaya.mp3",4.949320},
    next_park = {"subway_announcers/rri/boiko/orange/next_park.mp3",6.216032},
    next_slavnaya_strana = {"subway_announcers/rri/boiko/orange/next_slavnaya_strana.mp3",5.626304},
    next_smrc = {"subway_announcers/rri/boiko/orange/next_smrc.mp3",5.320068},
    next_vhe = {"subway_announcers/rri/boiko/orange/next_vhe.mp3",5.457755},
    spec_aeroport = {"subway_announcers/rri/boiko/orange/spec_aeroport.mp3",11.101020},
    to_aeroport = {"subway_announcers/rri/boiko/orange/to_aeroport.mp3",4.759955},
    to_park = {"subway_announcers/rri/boiko/orange/to_park.mp3",2.882993},

},{
    {
        Name = "Line 1",
        spec_last = {"last"},
        spec_wait = {{"train_stop"},{"train_depeat"}},
        {
            462, "Икарус","Ikarus",
            arrlast = {nil, {"arr_ikarus",0.5,"last"}},
            dep = {{"next_smrc",0.1,"politeness"}}
        },
        {
            461, "СМРК","SMRC",
            arr = {"arr_smrc", "arr_smrc"},
            dep = {{"next_flora", 0.1,"handrails"}, "next_ikarus"}
        },
        {
            460, "Флора","Flora",
            arr = {"arr_flora", "arr_flora"},
            dep = {{"next_aeroport", 0.1,"things"}, {"next_smrc",0.1,"handrails"}}
        },
        {
            458, "Аэропорт","Airport",
            arr = {{"arr_aeroport",0.1,"objects"}, {"arr_aeroport",0.1,"things"}},
            dep = {{"next_slavnaya_strana"}, {"next_flora",0.1,"politeness"}},
            arrlast = {{"arr_aeroport",0.5,"last"}, {"arr_aeroport",0.5,"last"}},
            not_last = {3,"to_aeroport"},
        },
        {
            457, "Славная стр.","Glorius c.",
            arr = {"arr_slavnaya_strana", "arr_slavnaya_strana"},
            dep = {{"next_litiyevaya",0.1,"politeness"}, "next_aeroport"},
            have_interchange = true
        },
        {
            --male<->female
            456, "Литиевая","Lithium",
            arr = {"arr_litiyevaya", "arr_litiyevaya"},
            dep = {"next_arsenal", {"next_slavnaya_strana",0.1,"objects"}},
            have_interchange = true
        },
        {
            455, "Арсенал","Arsenal",
            arr = {"arr_arsenal", "arr_arsenal"},
            dep = {{"next_park",0.1,"handrails"}, {"next_litiyevaya",0.1,"handrails"}},
        },
        {
            454, "Парк","Park",
            arr = {{"arr_park", 0.1,"things"}, {"arr_park",0.1,"things"}},
            dep = {{"next_gcfscape"}, {"next_arsenal",0.1,"objects"}},
            arrlast = {{"arr_park",0.5,"last"}, {"arr_park",0.5,"last"}},
            not_last = {3,"to_park"},
            have_interchange = true
        },
        {
            453, "GCFScape",
            arr = {"arr_gcfscape", {"arr_gcfscape"}},
            dep = {{"next_vhe"}, {"next_park",0.1,"politeness"}},
        },
        {
            452, "VHE",
            arr = {"arr_vhe", "arr_vhe"},
            dep = {{"next_imeni_uollesa_brina",0.1,"exit"}, "next_gcfscape"},
            have_interchange = true
        },
        {
            451, "У. Брина","W. Breen",
            arrlast = {{"arr_imeni_uollesa_brina",0.5,"last"}},
            dep = {nil, {"next_vhe",0.1,"politeness"}},
        }
    },
})

Metrostroi.StationSound = {
    {"subway_stations/announces/orange/orange_1.mp3",51.965563},
    {"subway_stations/announces/orange/orange_2.mp3",47.132875},
    {"subway_stations/announces/orange/orange_3.mp3",42.169625},
    {"subway_stations/announces/orange/orange_4.mp3",44.494500},
    {"subway_stations/announces/orange/orange_5.mp3",26.548438},
    {"subway_stations/announces/orange/orange_6.mp3",39.661875},
}
Metrostroi.StationConfigurations = {
    [462] = {
        names = {"икарус","Ikarus"},
        positions = {
            {Vector(-917,13102,5266-64),Angle(0,0,0)},
            {Vector(-838,12974,5266-64),Angle(0,180+30,0)},
            {Vector(-2100,13283,5266-64),Angle(0,30,0)},
            {Vector(7263,13279,5250-64),Angle(0,180,0)},

        }
    },
    [461] = {
        names = {"смрк","SMRC"},
        positions = {
            {Vector(-1632,-12568,4959-64),Angle(0,0,0)},
            {Vector(-238,-12856,4959-64),Angle(0,180+30,0)},
            {Vector(-2988,-12306,4959-64),Angle(0,30,0)},
        }
    },
    [460] = {
        names = {"флора","Flora"},
        positions = {
            {Vector(2526,-15264,4516-64),Angle(0,0,0)},
            {Vector(3858,-15680,4516-64),Angle(0,180+30,0)},
            {Vector(1132,-14838,4516-64),Angle(0,30,0)},
        }
    },
    [458] = {
        names = {"аэропорт","Airport"},
        positions = {
            {Vector(-995,-14800,3470-64),Angle(0,0,0)},
            {Vector(906,-15125,3470-64),Angle(0,180+30,0)},
            {Vector(-2156,-13920,3470-64),Angle(0,30,0)},
            {Vector(1076,-14700,3470-64),Angle(0,180-30,0)},
        }
    },
    [457] = {
        names = {"славная страна","Glorius country"},
        positions = {
            {Vector(-14068,315,2867-64),Angle(0,-90,0)},
            {Vector(-14533,-1031,2867-64),Angle(0,90+30,0)},
            {Vector(-13588,1816,2867-64),Angle(0,-90+30,0)},
        }
    },
    [456] = {
        names = {"литиевая","Lithium"},
        positions = {
            {Vector(-14761,2882,2264-64),Angle(0,-90,0)},
            {Vector(-15037,1342,2264-64),Angle(0,90+30,0)},
            {Vector(-14506,4438,2264-64),Angle(0,-90+30,0)},
        }
    },
    [455] = {
        names = {"арсенал","Arsenal"},
        positions = {
            {Vector(-638,14050,1626-64),Angle(0,180,0)},
            {Vector(-1892,14433,1626-64),Angle(0,30,0)},
            {Vector(878,13680,1626-64),Angle(0,180+30,0)},
        }
    },
    [454] = {
        names = {"парк","Park"},
        positions = {
            {Vector(10362,-536,988-64),Angle(0,48,0)},
            {Vector(10964,1870,988-64),Angle(0,270-48,0)},
            {Vector(10652,-8218,983-64),Angle(0,90,0)},
        }
    },
    [453] = {
        names = {"gcfscape"},
        positions = {
            {Vector(15050,3393,531-64),Angle(20,-90,0)},
            {Vector(14777,2290,347-64),Angle(0,90-30,0)},
            {Vector(15324,5121,347-64),Angle(0,-90-30,0)},
        }
    },
    [452] = {
        names = {"vhe"},
        positions = {
            {Vector(-1295,15124,-253-64),Angle(0,0,0)},
            {Vector(-107,14735,-253-64),Angle(0,180+30,0)},
            {Vector(-2838,15487,-253-64),Angle(0,30,0)},
        }
    },
    [451] = {
        names = {"уоллеса брина","Wallace breen"},
        positions = {
            {Vector(2616,11550,-854-64),Angle(0,90,0)},
            {Vector(3990,10843,-854-64),Angle(0,180+30,0)},
            {Vector(1180,12277,-854-64),Angle(0,30,0)},
            {Vector(4119,10804,-854-64),Angle(0,0,0)},
            {Vector(8345,469,-849-64),Angle(0,90,0)},
        }
    },
    depot = {
        names = {"депо"},
        positions = {
            {Vector(-9377,-233,5328-64), Angle(0,90,0)},
            {Vector(-9358,2668,5328-64), Angle(0,180,0)},
            {Vector(-13265,2284,5323-64), Angle(0,0,0)},
            {Vector(-9348,854,5328-64), Angle(0,-180,0)},
            {Vector(-12170,4269,5378-64), Angle(0,0,0)},
            {Vector(-13367,4753,5328-64), Angle(0,-10,0)},
        }
    }
}
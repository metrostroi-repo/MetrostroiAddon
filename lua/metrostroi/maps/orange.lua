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

Metrostroi.Skins["722_schemes"] = {
    {
        name = "Line 1",
        "metrostroi_skins/81-722_schemes/oranger",
        "metrostroi_skins/81-722_schemes/orange"
    },
    {
        name = "Crossline",
        "metrostroi_skins/81-722_schemes/crossline",
        "metrostroi_skins/81-722_schemes/crossliner",
    }
}

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
        Name = "Линия 1",
        -- Loop = false,
        {
            462,
            "Икарус","Ikarus",
            arrlast = {nil, "last_ikarus"},
            dep = {"next_smrc", nil},
            odz = "odz1",
            dist = 40,
        },
        {
            461,
            "СМРК","SMRC",
            arr = {{"smrk", 3, "next_flora",0.4,"spec_attention_politeness"}, {"smrk", 3, "next_ikarus",0.4,"spec_attention_handrails"}},
            dep = {"next_flora", "next_ikarus"},
            odz = "odz1",
            dist = 40,
        },
        {
            460,
            "Флора","Flora",
            arr = {{"flora", 3, "next_aeroport"}, {"flora", 3, "next_smrc",0.4,"spec_attention_politeness"}},
            dep = {"next_aeroport", "next_smrc"},
            odz = "odz2",
            dist = 40,
        },
        {
            458,
            "Аэропорт","Airport",
            arr = {{"aeroport", 3, "next_slavnaya_strana", "spec_line6"}, {"aeroport", 3, "next_flora",0.4,"spec_attention_handrails"}},
            dep = {"next_slavnaya_strana", "next_flora"},
            arrlast = {"last_aeroport", "last_aeroport"},
            odz = "odz2",
            dist = 40,
        },
        {
            457,
            "Славная стр.","Gl. country",
            arr = {{"slavnaya_strana", 3, "next_litievaya", "spec_line5"}, {"slavnaya_strana", 3, "next_aeroport",0.4,"spec_attention_politeness"}},
            dep = {"next_litievaya", "next_aeroport"},
            odz = "odz1",
            dist = 40,
        },
        {
            456,
            "Литиевая","Lithium",
            arr = {{"litievaya", 3, "next_arsenal",0.4,"spec_attention_handrails"}, {"litievaya", 3, "next_slavnaya_strana", "spec_line6"}},
            dep = {"next_arsenal", "next_slavnaya_strana"},
            odz = "odz2",
            dist = 40,
        },
        {
            455,
            "Арсенал","Arsenal",
            arr = {{"arsenal", 3, "next_park", "spec_line6"}, {"arsenal", 3, "next_litievaya", "spec_line5",0.4,"spec_attention_politeness"}},
            dep = {"next_park1", "next_litievaya"},
            odz = "odz1",
            dist = 40,
        },
        {
            454,
            "Парк","Park",
            arr = {{"park", 3, "next_gcfscape",0.4,"spec_attention_politeness"}, {"park", 3, "next_arsenal",0.4,"spec_attention_handrails"}},
            dep = {"next_gcfscape1", "next_arsenal"},
            arrlast = {{"last_park", "spec_line6"}, {"last_park", "spec_line6"}},
            odz = "odz2",
            dist = 40,
        },
        {
            453,
            "GCFScape","GCFScape",
            arr = {{"gcfscape", 3, "next_vhe",0.4,"spec_attention_handrails"}, {"gcfscape", 3, "next_park", "spec_line6"}},
            dep = {"next_vhe", "next_park1"},
            odz = "odz2",
            dist = 40,
        },
        {
            452,
            "VHE","VHE",
            arr = {{"vhe", 3, "next_imeni_uollesa_brina"}, {"vhe", 3, "next_gcfscape",0.4,"spec_attention_politeness"}},
            dep = {"next_imeni_uollesa_brina", "next_gcfscape1"},
            odz = "odz1",
            dist = 40,
        },
        {
            451,
            "У. Брина","W. Breen",
            arrlast = {"last_imeni_uollesa_brina"},
            dep = {nil, "next_vhe"},
            odz = "odz1",
            dist = 40,
        }
    }
})

Metrostroi.AddANSPAnnouncer("ASNP MakichOS", {
    click1 = {"subway_announcers/asnp/click.mp3", 0.3},
    click2 = {"subway_announcers/asnp/click2.mp3", 0.1},
    announcer_ready = {"subway_announcers/asnp/makich/announcer_ready.mp3", 3.575700},
    last = {"subway_announcers/asnp/makich/last.mp3", 20.358000},
    odz = {"subway_announcers/asnp/makich/odz.mp3", 2.427300},
    spec_attention_exit = {"subway_announcers/asnp/makich/spec_attention_exit.mp3", 5.220000},
    spec_attention_last = {"subway_announcers/asnp/makich/spec_attention_last.mp3", 5.063400},
    spec_attention_objects = {"subway_announcers/asnp/makich/spec_attention_objects.mp3", 4.176000},
    spec_attention_politeness = {"subway_announcers/asnp/makich/spec_attention_politeness.mp3", 8.952300},
    spec_attention_things = {"subway_announcers/asnp/makich/spec_attention_things.mp3", 4.698000},
    spec_attention_train_depeat = {"subway_announcers/asnp/makich/spec_attention_train_depeat.mp3", 4.332600},
    spec_attention_train_stop = {"subway_announcers/asnp/makich/spec_attention_train_stop.mp3", 5.246100},
    spec_attention_handrails = {"subway_announcers/asnp/makich/spec_attention_handrails.mp3", 4.880700},
    train_goes_to = {"subway_announcers/asnp/makich/train_goes_to.mp3", 2.322900},
    aeroport = {"subway_announcers/asnp/makich/orange/aeroport.mp3", 0.965700},
    arr_aeroport = {"subway_announcers/asnp/makich/orange/arr_aeroport.mp3", 2.009700},
    arr_arsenal = {"subway_announcers/asnp/makich/orange/arr_arsenal.mp3", 1.670400},
    arr_flora = {"subway_announcers/asnp/makich/orange/arr_flora.mp3", 1.592100},
    arr_gcfscape = {"subway_announcers/asnp/makich/orange/arr_gcfcape.mp3", 3.680100},
    arr_ikarus = {"subway_announcers/asnp/makich/orange/arr_ikarus.mp3", 1.722600},
    arr_imeni_uollesa_brina = {"subway_announcers/asnp/makich/orange/arr_imeni_uollesa_brina.mp3", 2.401200},
    arr_litievaya = {"subway_announcers/asnp/makich/orange/arr_litievaya.mp3", 3.784500},
    arr_park = {"subway_announcers/asnp/makich/orange/arr_park.mp3", 5.141700},
    arr_slavnaya_strana = {"subway_announcers/asnp/makich/orange/arr_slavnaya_strana.mp3", 4.228200},
    arr_smrc = {"subway_announcers/asnp/makich/orange/arr_smrk.mp3", 1.748700},
    arr_vhe = {"subway_announcers/asnp/makich/orange/arr_vhe.mp3", 1.983600},
    next_aeroport = {"subway_announcers/asnp/makich/orange/next_aeroport.mp3", 2.688300},
    next_arsenal = {"subway_announcers/asnp/makich/orange/next_arsenal.mp3", 2.296800},
    next_flora = {"subway_announcers/asnp/makich/orange/next_flora.mp3", 1.983600},
    next_gcfscape = {"subway_announcers/asnp/makich/orange/next_gcfcape.mp3", 4.384800},
    next_ikarus = {"subway_announcers/asnp/makich/orange/next_ikarus.mp3", 2.218500},
    next_imeni_uollesa_brina = {"subway_announcers/asnp/makich/orange/next_imeni_uollesa_brina.mp3", 3.158100},
    next_litievaya = {"subway_announcers/asnp/makich/orange/next_litievaya.mp3", 2.244600},
    next_park = {"subway_announcers/asnp/makich/orange/next_park.mp3", 3.836700},
    next_slavnaya_strana = {"subway_announcers/asnp/makich/orange/next_slavnaya_strana.mp3", 2.636100},
    next_smrc = {"subway_announcers/asnp/makich/orange/next_smrk.mp3", 2.375100},
    next_vhe = {"subway_announcers/asnp/makich/orange/next_vhe.mp3", 2.427300},
    park = {"subway_announcers/asnp/makich/orange/park.mp3", 0.626400},
    ikarus = {"subway_announcers/asnp/makich/orange/ikarus.mp3", 0.991800},
    vhe = {"subway_announcers/asnp/makich/orange/vhe.mp3", 1.409400}
},{
    {
        LED = {2, 1, 2, 3, 3, 3, 3, 3, 3, 3, 4},
        Name = "Линия 1",
        Loop = false,
        spec_last = {"spec_attention_last",0.5,"spec_attention_things"},
        spec_wait = {{"spec_attention_train_stop"},{"spec_attention_train_depeat"}},
        {
            462,
            "Икарус",
            arrlast = {nil, {"arr_ikarus", 0.5, "last"}, "ikarus"},
            dep = {{"odz", "next_smrc", 0.1, "spec_attention_politeness"}}
        },
        {
            461,
            "СМРК",
            arr = {"arr_smrc", "arr_smrc"},
            dep = {{"odz", "next_flora", 0.1, "spec_attention_handrails"}, {"odz", "next_ikarus"}}
        },
        {
            460,
            "Флора",
            arr = {"arr_flora", "arr_flora"},
            dep = {{"odz", "next_aeroport", 0.1, "spec_attention_things"}, {"odz", "next_smrc", 0.1, "spec_attention_handrails"}}
        },
        {
            458,
            "Аэропорт",
            arr = {{"arr_aeroport", 0.1, "spec_attention_objects"}, {"arr_aeroport", 0.1, "spec_attention_things"}},
            dep = {{"odz", "next_slavnaya_strana"}, {"odz", "next_flora", 0.1, "spec_attention_politeness"}},
            arrlast = {{"arr_aeroport", 0.5, "last"}, {"arr_aeroport", 0.5, "last"}, "aeroport"},
            not_last = {3, "train_goes_to", "aeroport"}
        },
        {
            457,
            "Славная стр.",
            arr = {"arr_slavnaya_strana", "arr_slavnaya_strana"},
            dep = {{"odz", "next_litievaya", 0.1, "spec_attention_politeness"}, {"odz", "next_aeroport"}},
            have_inrerchange = true
        },
        {
            456,
            "Литиевая",
            arr = {"arr_litievaya", "arr_litievaya"},
            dep = {{"odz", "next_arsenal"}, {"odz", "next_slavnaya_strana", 0.1, "spec_attention_objects"}},
            have_inrerchange = true
        },
        {
            455,
            "Арсенал",
            arr = {"arr_arsenal", "arr_arsenal"},
            dep = {{"odz", "next_park", 0.1, "spec_attention_handrails"}, {"odz", "next_litievaya", 0.1, "spec_attention_handrails"}}
        },
        {
            454,
            "Парк",
            arr = {{"arr_park", 0.1, "spec_attention_things"}, {"arr_park", 0.1, "spec_attention_things"}},
            dep = {{"odz", "next_gcfscape"}, {"odz", "next_arsenal", 0.1, "spec_attention_objects"}},
            arrlast = {{"arr_park", 0.5, "last"}, {"arr_park", 0.5, "last"}, "park"},
            not_last = {3, "train_goes_to", "park"},
            have_inrerchange = true
        },
        {
            453,
            "GCFScape",
            arr = {"arr_gcfscape", "arr_gcfscape"},
            dep = {{"odz", "next_vhe"}, {"odz", "next_park", 0.1, "spec_attention_politeness"}}
        },
        {
            452,
            "VHE",
            arr = {"arr_vhe", "arr_vhe"},
            dep = {{"odz", "next_imeni_uollesa_brina", 0.1, "spec_attention_exit"}, {"odz", "next_gcfscape"}},
            have_inrerchange = true
        },
        {
            451,
            "У. Брина",
            arrlast = {{"arr_imeni_uollesa_brina", 0.5, "last"}, nil, "arr_imeni_uollesa_brina"},
            dep = {nil, {"odz", "next_vhe", 0.1, "spec_attention_politeness"}}
        }
    }
})
Metrostroi.AddANSPAnnouncer("ASNP MakichOS + Concord En", {
    click1 = {"subway_announcers/asnp/click.mp3", 0.3},
    click2 = {"subway_announcers/asnp/click2.mp3", 0.1},
    announcer_ready = {"subway_announcers/asnp/makich/announcer_ready.mp3", 3.575700},
    last = {"subway_announcers/asnp/makich/last.mp3", 20.358000},
    odz = {"subway_announcers/asnp/makich/odz.mp3", 2.427300},
    spec_attention_exit = {"subway_announcers/asnp/makich/spec_attention_exit.mp3", 5.220000},
    spec_attention_last = {"subway_announcers/asnp/makich/spec_attention_last.mp3", 5.063400},
    spec_attention_objects = {"subway_announcers/asnp/makich/spec_attention_objects.mp3", 4.176000},
    spec_attention_politeness = {"subway_announcers/asnp/makich/spec_attention_politeness.mp3", 8.952300},
    spec_attention_things = {"subway_announcers/asnp/makich/spec_attention_things.mp3", 4.698000},
    spec_attention_train_depeat = {"subway_announcers/asnp/makich/spec_attention_train_depeat.mp3", 4.332600},
    spec_attention_train_stop = {"subway_announcers/asnp/makich/spec_attention_train_stop.mp3", 5.246100},
    spec_attention_handrails = {"subway_announcers/asnp/makich/spec_attention_handrails.mp3", 4.880700},
    train_goes_to = {"subway_announcers/asnp/makich/train_goes_to.mp3", 2.322900},
    aeroport = {"subway_announcers/asnp/makich/orange/aeroport.mp3", 0.965700},
    arr_aeroport = {"subway_announcers/asnp/makich/orange/arr_aeroport.mp3", 2.009700},
    arr_arsenal = {"subway_announcers/asnp/makich/orange/arr_arsenal.mp3", 1.670400},
    arr_flora = {"subway_announcers/asnp/makich/orange/arr_flora.mp3", 1.592100},
    arr_gcfscape = {"subway_announcers/asnp/makich/orange/arr_gcfcape.mp3", 3.680100},
    arr_ikarus = {"subway_announcers/asnp/makich/orange/arr_ikarus.mp3", 1.722600},
    arr_imeni_uollesa_brina = {"subway_announcers/asnp/makich/orange/arr_imeni_uollesa_brina.mp3", 2.401200},
    arr_litievaya = {"subway_announcers/asnp/makich/orange/arr_litievaya.mp3", 3.784500},
    arr_park = {"subway_announcers/asnp/makich/orange/arr_park.mp3", 5.141700},
    arr_slavnaya_strana = {"subway_announcers/asnp/makich/orange/arr_slavnaya_strana.mp3", 4.228200},
    arr_smrc = {"subway_announcers/asnp/makich/orange/arr_smrk.mp3", 1.748700},
    arr_vhe = {"subway_announcers/asnp/makich/orange/arr_vhe.mp3", 1.983600},
    next_aeroport = {"subway_announcers/asnp/makich/orange/next_aeroport.mp3", 2.688300},
    next_arsenal = {"subway_announcers/asnp/makich/orange/next_arsenal.mp3", 2.296800},
    next_flora = {"subway_announcers/asnp/makich/orange/next_flora.mp3", 1.983600},
    next_gcfscape = {"subway_announcers/asnp/makich/orange/next_gcfcape.mp3", 4.384800},
    next_ikarus = {"subway_announcers/asnp/makich/orange/next_ikarus.mp3", 2.218500},
    next_imeni_uollesa_brina = {"subway_announcers/asnp/makich/orange/next_imeni_uollesa_brina.mp3", 3.158100},
    next_litievaya = {"subway_announcers/asnp/makich/orange/next_litievaya.mp3", 2.244600},
    next_park = {"subway_announcers/asnp/makich/orange/next_park.mp3", 3.836700},
    next_slavnaya_strana = {"subway_announcers/asnp/makich/orange/next_slavnaya_strana.mp3", 2.636100},
    next_smrc = {"subway_announcers/asnp/makich/orange/next_smrk.mp3", 2.375100},
    next_vhe = {"subway_announcers/asnp/makich/orange/next_vhe.mp3", 2.427300},
    park = {"subway_announcers/asnp/makich/orange/park.mp3", 0.626400},
    ikarus = {"subway_announcers/asnp/makich/orange/ikarus.mp3", 0.991800},
    vhe = {"subway_announcers/asnp/makich/orange/vhe.mp3", 1.409400},
    arr_aeroport_en = {"subway_announcers/asnp/english/orange/arr_aeroport.mp3", 1.688},
    arr_aeroport_last_en = {"subway_announcers/asnp/english/orange/arr_aeroport_last.mp3", 3.781},
    arr_arsenal_en = {"subway_announcers/asnp/english/orange/arr_arsenal.mp3", 1.624},
    arr_flora_en = {"subway_announcers/asnp/english/orange/arr_flora.mp3", 1.538},
    arr_gcfscape_en = {"subway_announcers/asnp/english/orange/arr_gcfcape.mp3", 2.183},
    arr_ikarus_en = {"subway_announcers/asnp/english/orange/arr_ikarus.mp3", 3.806},
    arr_imeni_uollesa_brina_en = {"subway_announcers/asnp/english/orange/arr_imeni_uollesa_brina.mp3", 4.580},
    arr_litievaya_en = {"subway_announcers/asnp/english/orange/arr_litievaya.mp3", 3.585},
    arr_park_en = {"subway_announcers/asnp/english/orange/arr_park.mp3", 3.334},
    arr_park_last_en = {"subway_announcers/asnp/english/orange/arr_park_last.mp3", 5.427},
    arr_slavnaya_strana_en = {"subway_announcers/asnp/english/orange/arr_slavnaya_strana.mp3", 4.092},
    arr_smrc_en = {"subway_announcers/asnp/english/orange/arr_smrc.mp3", 1.934},
    arr_vhe_en = {"subway_announcers/asnp/english/orange/arr_vhe.mp3", 1.717},
    next_aeroport_en = {"subway_announcers/asnp/english/orange/next_aeroport.mp3", 2.427},
    next_arsenal_en = {"subway_announcers/asnp/english/orange/next_arsenal.mp3", 2.363},
    next_flora_en = {"subway_announcers/asnp/english/orange/next_flora.mp3", 2.277},
    next_gcfscape_en = {"subway_announcers/asnp/english/orange/next_gcfcape.mp3", 4.802},
    next_ikarus_en = {"subway_announcers/asnp/english/orange/next_ikarus.mp3", 2.451},
    next_imeni_uollesa_brina_en = {"subway_announcers/asnp/english/orange/next_imeni_uollesa_brina.mp3", 3.225},
    next_litievaya_en = {"subway_announcers/asnp/english/orange/next_litievaya.mp3", 2.335},
    next_park_en = {"subway_announcers/asnp/english/orange/next_park.mp3", 3.993},
    next_slavnaya_strana_en = {"subway_announcers/asnp/english/orange/next_slavnaya_strana.mp3", 2.871},
    next_smrc_en = {"subway_announcers/asnp/english/orange/next_smrc.mp3", 2.673},
    next_vhe_en = {"subway_announcers/asnp/english/orange/next_vhe.mp3", 2.456}
},{
    {
        LED = {2, 1, 2, 3, 3, 3, 3, 3, 3, 3, 4},
        Name = "Линия 1",
        Loop = false,
        spec_last = {"spec_attention_last",0.5,"spec_attention_things"},
        spec_wait = {{"spec_attention_train_stop"},{"spec_attention_train_depeat"}},
        {
            462,
            "Икарус",
            arrlast = {nil, {"arr_ikarus", "arr_ikarus_en", 0.5, "last"}, "ikarus"},
            dep = {{"odz", "next_smrc", "next_smrc_en", 0.1, "spec_attention_politeness"}}
        },
        {
            461,
            "СМРК",
            arr = {{"arr_smrc", "arr_smrc_en"}, {"arr_smrc", "arr_smrc_en"}},
            dep = {{"odz", "next_flora", "next_flora_en", 0.1, "spec_attention_handrails"}, {"odz", "next_ikarus", "next_ikarus_en"}}
        },
        {
            460,
            "Флора",
            arr = {{"arr_flora", "arr_flora_en"}, {"arr_flora", "arr_flora_en"}},
            dep = {{"odz", "next_aeroport", "next_aeroport_en", 0.1, "spec_attention_politeness"}, {"odz", "next_smrc", "next_smrc_en", 0.1, "spec_attention_handrails"}}
        },
        {
            458,
            "Аэропорт",
            arr = {{"arr_aeroport", "arr_aeroport_en", 0.1, "spec_attention_objects"}, {"arr_aeroport", "arr_aeroport_en", 0.1, "spec_attention_things"}},
            dep = {{"odz", "next_slavnaya_strana", "next_slavnaya_strana_en"}, {"odz", "next_flora", "next_flora_en", 0.1, "spec_attention_politeness"}},
            arrlast = {{"arr_aeroport", "arr_aeroport_last_en", 0.5, "last"}, {"arr_aeroport", "arr_aeroport_last_en", 0.5, "last"}, "aeroport"},
            not_last = {3, "train_goes_to", "aeroport"}
        },
        {
            457,
            "Славная стр.",
            arr = {{"arr_slavnaya_strana", "arr_slavnaya_strana_en"}, {"arr_slavnaya_strana", "arr_slavnaya_strana_en"}},
            dep = {{"odz", "next_litievaya", "next_litievaya_en", 0.1, "spec_attention_politeness"}, {"odz", "next_aeroport", "next_aeroport_en"}},
            have_inrerchange = true
        },
        {
            456,
            "Литиевая",
            arr = {{"arr_litievaya", "arr_litievaya_en"}, {"arr_litievaya", "arr_litievaya_en"}},
            dep = {{"odz", "next_arsenal", "next_arsenal_en"}, {"odz", "next_slavnaya_strana", "next_slavnaya_strana_en"}},
            have_inrerchange = true
        },
        {
            455,
            "Арсенал",
            arr = {{"arr_arsenal", "arr_arsenal_en", 0.1, "spec_attention_objects"}, {"arr_arsenal", "arr_arsenal_en"}},
            dep = {{"odz", "next_park", "next_park_en"}, {"odz", "next_litievaya", "next_litievaya_en", 0.1, "spec_attention_handrails"}}
        },
        {
            454,
            "Парк",
            arr = {{"arr_park", "arr_park_en", 0.1, "spec_attention_things"}, {"arr_park", "arr_park_en", 0.1, "spec_attention_things"}},
            dep = {{"odz", "next_gcfscape", "next_gcfscape_en"}, {"odz", "next_arsenal", "next_arsenal_en", 0.1, "spec_attention_politeness"}},
            arrlast = {{"arr_park", "arr_park_last_en", 0.5, "last"}, {"arr_park", "arr_park_last_en", 0.5, "last"}, "park"},
            not_last = {3, "train_goes_to", "park"},
            have_inrerchange = true
        },
        {
            453,
            "GCFScape",
            arr = {{"arr_gcfscape", "arr_gcfscape_en"}, {"arr_gcfscape", "arr_gcfscape_en"}},
            dep = {{"odz", "next_vhe", "next_vhe_en"}, {"odz", "next_park", "next_park_en", 0.1, "spec_attention_handrails"}}
        },
        {
            452,
            "VHE",
            arr = {{"arr_vhe", "arr_vhe_en"}, {"arr_vhe", "arr_vhe_en"}},
            dep = {{"odz", "next_imeni_uollesa_brina", "next_imeni_uollesa_brina_en", 0.1, "spec_attention_exit"}, {"odz", "next_gcfscape", "next_gcfscape_en"}},
            have_inrerchange = true
        },
        {
            451,
            "У. Брина",
            arrlast = {{"arr_imeni_uollesa_brina", "arr_imeni_uollesa_brina_en", 0.5, "last"}, nil, "arr_imeni_uollesa_brina"},
            dep = {nil, {"odz", "next_vhe", "next_vhe_en", 0.1, "spec_attention_politeness"}}
        }
    }
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
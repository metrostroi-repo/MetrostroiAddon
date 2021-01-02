local Map = game.GetMap():lower() or ""

if Map:find("gm_metrostroi") and not Map:find("lite") then
    Metrostroi.PlatformMap = "metrostroi"
    Metrostroi.CurrentMap = "gm_metrostroi"
    Metrostroi.BogeyOldMap = true
else
    return
end
Metrostroi.AddPassSchemeTex("717_new","Line 1",{
    "models/metrostroi_schemes/map_2",
})
Metrostroi.AddPassSchemeTex("720","Line 1",{
    "metrostroi_skins/81-720_schemes/b50_1",
    "metrostroi_skins/81-720_schemes/b50_1r",
})
Metrostroi.AddPassSchemeTex("720","Line 2",{
    "metrostroi_skins/81-720_schemes/b50_2",
    "metrostroi_skins/81-720_schemes/b50_2r",
})
Metrostroi.AddPassSchemeTex("722","Line 1",{
    "metrostroi_skins/81-722_schemes/b50_1",
    "metrostroi_skins/81-722_schemes/b50_1r",
})
Metrostroi.AddPassSchemeTex("722","Line 2",{
    "metrostroi_skins/81-722_schemes/b50_2",
    "metrostroi_skins/81-722_schemes/b50_2r",
})
Metrostroi.AddLastStationTex("702",108,"models/metrostroi_schemes/destination_table_black/label_avtozavodskaya")
Metrostroi.AddLastStationTex("702",111,"models/metrostroi_schemes/destination_table_black/label_oktyabrskaya")
Metrostroi.AddLastStationTex("702",112,"models/metrostroi_schemes/destination_table_black/label_ploshad_mira")
Metrostroi.AddLastStationTex("702",114,"models/metrostroi_schemes/destination_table_black/label_vokzalnaya")
Metrostroi.AddLastStationTex("702",115,"models/metrostroi_schemes/destination_table_black/label_komsomolskaya")
Metrostroi.AddLastStationTex("702",121,"models/metrostroi_schemes/destination_table_black/label_minskaya")
Metrostroi.AddLastStationTex("702",123,"models/metrostroi_schemes/destination_table_black/label_mezdustroiskaya")
Metrostroi.AddLastStationTex("702",322,"models/metrostroi_schemes/destination_table_black/label_avt_yujnaya")

Metrostroi.AddLastStationTex("710",108,"models/metrostroi_schemes/destination_table_white/label_avtozavodskaya")
Metrostroi.AddLastStationTex("710",111,"models/metrostroi_schemes/destination_table_white/label_oktyabrskaya")
Metrostroi.AddLastStationTex("710",112,"models/metrostroi_schemes/destination_table_white/label_ploshad_mira")
Metrostroi.AddLastStationTex("710",114,"models/metrostroi_schemes/destination_table_white/label_vokzalnaya")
Metrostroi.AddLastStationTex("710",115,"models/metrostroi_schemes/destination_table_white/label_komsomolskaya")
Metrostroi.AddLastStationTex("710",121,"models/metrostroi_schemes/destination_table_white/label_minskaya")
Metrostroi.AddLastStationTex("710",123,"models/metrostroi_schemes/destination_table_white/label_mezdustroiskaya")
Metrostroi.AddLastStationTex("710",322,"models/metrostroi_schemes/destination_table_white/label_avt_yujnaya")

Metrostroi.AddLastStationTex("717",108,"models/metrostroi_schemes/destination_table_white/label_avtozavodskaya")
Metrostroi.AddLastStationTex("717",111,"models/metrostroi_schemes/destination_table_white/label_oktyabrskaya")
Metrostroi.AddLastStationTex("717",112,"models/metrostroi_schemes/destination_table_white/label_ploshad_mira")
Metrostroi.AddLastStationTex("717",114,"models/metrostroi_schemes/destination_table_white/label_vokzalnaya")
Metrostroi.AddLastStationTex("717",115,"models/metrostroi_schemes/destination_table_white/label_komsomolskaya")
Metrostroi.AddLastStationTex("717",121,"models/metrostroi_schemes/destination_table_white/label_minskaya")
Metrostroi.AddLastStationTex("717",123,"models/metrostroi_schemes/destination_table_white/label_mezdustroiskaya")
Metrostroi.AddLastStationTex("717",322,"models/metrostroi_schemes/destination_table_white/label_avt_yujnaya")

Metrostroi.AddLastStationTex("720",108,"models/metrostroi_schemes/destination_table_white/label_avtozavodskaya")
Metrostroi.AddLastStationTex("720",111,"models/metrostroi_schemes/destination_table_white/label_oktyabrskaya")
Metrostroi.AddLastStationTex("720",112,"models/metrostroi_schemes/destination_table_white/label_ploshad_mira")
Metrostroi.AddLastStationTex("720",114,"models/metrostroi_schemes/destination_table_white/label_vokzalnaya")
Metrostroi.AddLastStationTex("720",115,"models/metrostroi_schemes/destination_table_white/label_komsomolskaya")
Metrostroi.AddLastStationTex("720",121,"models/metrostroi_schemes/destination_table_white/label_minskaya")
Metrostroi.AddLastStationTex("720",123,"models/metrostroi_schemes/destination_table_white/label_mezdustroiskaya")
Metrostroi.AddLastStationTex("720",322,"models/metrostroi_schemes/destination_table_white/label_avt_yujnaya")

Metrostroi.TickerAdverts = {"МЕТРОПОЛИТЕН ИМЕНИ ГАРРИ НЬЮМАНА ПРИГЛАШАЕТ НА РАБОТУ РЕАЛЬНЕ МАФЕНЕСТОВ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,ТЕЛЕФОН ДЛЯ СПРАВОК 8 (800) 555-35-35", "ЭЛЕКТРОДЕПО ТЧ-1 ПРИГЛАШАЕТ НА РАБОТУ МАППЕРОВ ДЛЯ РАССТАНОВКИ УДОЧЕК И ЗМЕЙ", "СТАНЦИЯ МОСКОВСКАЯ ПРИГЛАШАЕТ НА РАБОТУ МАШИНИСТОВ И ПОМОЩНИКОВ МАШИНИСТА ЭСКАЛАТОРА. ОПЛАТА 5 КУСОЧКОВ НОМЕРНОГО.", "ЭЛЕКТРОДЕПО ТЧ1 ПРИГЛАШАЕТ НА РАБООООООООООООООООООООООООООООООООООООООООООЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫГГГГГГГГГГГГГГГГГГГГГГГГГГГГГГГГГГ"}

Metrostroi.StationAnnouncesTo = {
    [122] = {1, 322, "subway_stations/inside/station_arr_to_322.mp3", "subway_stations/inside/station_dep_to_322.mp3"}
}

Metrostroi.StationAnnouncesToEnd = {
    [108] = {"subway_stations/inside/no_entry_arr_108.mp3", "subway_stations/inside/no_entry_dep_108.mp3"},
    [123] = {"subway_stations/inside/no_entry_arr_123.mp3", "subway_stations/inside/no_entry_dep_123.mp3"}
}

Metrostroi.StationData = {
    [109] = true,
    [110] = true,
    [118] = true
}


Metrostroi.SetRRIAnnouncer({
    click_end = {"subway_announcers/rri/boiko/spec/click_end.mp3",0.281451},
    click_start = {"subway_announcers/rri/boiko/spec/click_start.mp3",0.438118},
    last = {"subway_announcers/rri/boiko/spec/last.mp3",22.264354},
    exit = {"subway_announcers/rri/boiko/spec/spec_attention_exit.mp3",5.446236},
    handrails = {"subway_announcers/rri/boiko/spec/spec_attention_handrails.mp3",4.594558},
    objects = {"subway_announcers/rri/boiko/spec/spec_attention_objects.mp3",5.143175},
    things = {"subway_announcers/rri/boiko/spec/spec_attention_things.mp3",05.093},
    politeness = {"subway_announcers/rri/boiko/spec/spec_attention_politeness.mp3",11.457075},
    train_depeat = {"subway_announcers/rri/boiko/spec/spec_attention_train_depeat.mp3",4.842222},
    train_stop = {"subway_announcers/rri/boiko/spec/spec_attention_train_stop.mp3",6.963424},

    skip_lesnaya = {"subway_announcers/rri/boiko/b50/skip_lesnaya.mp3",5.501270},
    skip_vokzalnaya = {"subway_announcers/rri/boiko/b50/skip_vokzalnaya.mp3",5.792358},
    arr_avtozavodskaya = {"subway_announcers/rri/boiko/b50/1/arr_avtozavodskaya.mp3",2.500000},
    arr_elektrosila = {"subway_announcers/rri/boiko/b50/1/arr_elektrosila.mp3",2.502834},
    arr_industrialnaya = {"subway_announcers/rri/boiko/b50/1/arr_industrialnaya.mp3",2.410635},
    arr_komsomolskaya = {"subway_announcers/rri/boiko/b50/1/arr_komsomolskaya.mp3",6.525873},
    arr_mejdustroyskaya = {"subway_announcers/rri/boiko/b50/1/arr_mejdustroyskaya.mp3",3.867710},
    arr_minskaya = {"subway_announcers/rri/boiko/b50/1/arr_minskaya.mp3",1.716757},
    arr_moskovskaya = {"subway_announcers/rri/boiko/b50/1/arr_moskovskaya.mp3",3.636893},
    arr_novoarmeyskaya = {"subway_announcers/rri/boiko/b50/1/arr_novoarmeyskaya.mp3",2.318912},
    arr_oktyabrskaya = {"subway_announcers/rri/boiko/b50/1/arr_oktyabrskaya.mp3",2.235147},
    arr_park_pobedy = {"subway_announcers/rri/boiko/b50/1/arr_park_pobedy.mp3",3.625102},
    arr_ploschad_myra = {"subway_announcers/rri/boiko/b50/1/arr_ploschad_myra.mp3",2.527211},
    arr_sineozernaya = {"subway_announcers/rri/boiko/b50/1/arr_sineozernaya.mp3",2.137528},
    arr_teatralnaya_ploschad = {"subway_announcers/rri/boiko/b50/1/arr_teatralnaya_ploschad.mp3",2.527211},
    arr_tsarskiye_vorota = {"subway_announcers/rri/boiko/b50/1/arr_tsarskiye_vorota.mp3",2.524717},
    arr_vokzalnaya = {"subway_announcers/rri/boiko/b50/1/arr_vokzalnaya.mp3",2.213537},
    next_avtozavodskaya = {"subway_announcers/rri/boiko/b50/1/next_avtozavodskaya.mp3",5.483583},
    next_elektrosila = {"subway_announcers/rri/boiko/b50/1/next_elektrosila.mp3",4.693197},
    next_industrialnaya = {"subway_announcers/rri/boiko/b50/1/next_industrialnaya.mp3",5.509410},
    next_komsomolskaya = {"subway_announcers/rri/boiko/b50/1/next_komsomolskaya.mp3",6.685805},
    next_mejdustroyskaya = {"subway_announcers/rri/boiko/b50/1/next_mejdustroyskaya.mp3",6.323129},
    next_minskaya = {"subway_announcers/rri/boiko/b50/1/next_minskaya.mp3",5.326644},
    next_moskovskaya = {"subway_announcers/rri/boiko/b50/1/next_moskovskaya.mp3",6.832426},
    next_novoarmeyskaya = {"subway_announcers/rri/boiko/b50/1/next_novoarmeyskaya.mp3",5.227596},
    next_oktyabrskaya = {"subway_announcers/rri/boiko/b50/1/next_oktyabrskaya.mp3",5.492200},
    next_park_pobedy = {"subway_announcers/rri/boiko/b50/1/next_park_pobedy.mp3",6.588798},
    next_ploschad_myra = {"subway_announcers/rri/boiko/b50/1/next_ploschad_myra.mp3",5.653560},
    next_sineozernaya = {"subway_announcers/rri/boiko/b50/1/next_sineozernaya.mp3",5.245646},
    next_teatralnaya_ploschad = {"subway_announcers/rri/boiko/b50/1/next_teatralnaya_ploschad.mp3",5.059252},
    next_tsarskiye_vorota = {"subway_announcers/rri/boiko/b50/1/next_tsarskiye_vorota.mp3",5.482063},
    next_vokzalnaya = {"subway_announcers/rri/boiko/b50/1/next_vokzalnaya.mp3",5.194921},
    to_komsomolskaya = {"subway_announcers/rri/boiko/b50/1/to_komsomolskaya.mp3",4.835986},
    to_mejdustroyskaya = {"subway_announcers/rri/boiko/b50/1/to_mejdustroyskaya.mp3",4.359819},
    to_minskaya = {"subway_announcers/rri/boiko/b50/1/to_minskaya.mp3",4.384014},
    to_oktyabrskaya = {"subway_announcers/rri/boiko/b50/1/to_oktyabrskaya.mp3",2.956871},
    to_ploschad_myra = {"subway_announcers/rri/boiko/b50/1/to_ploschad_myra.mp3",4.712041},
    to_vokzalnaya = {"subway_announcers/rri/boiko/b50/1/to_vokzalnaya.mp3",2.808526},
    arr_akademicheskaya = {"subway_announcers/rri/boiko/b50/2/arr_akademicheskaya.mp3",2.259342},
    arr_derjavinskaya = {"subway_announcers/rri/boiko/b50/2/arr_derjavinskaya.mp3",2.276848},
    arr_kirovskaya = {"subway_announcers/rri/boiko/b50/2/arr_kirovskaya.mp3",1.750159},
    arr_leninskaya = {"subway_announcers/rri/boiko/b50/2/arr_leninskaya.mp3",4.512132},
    arr_ohotny_ryad = {"subway_announcers/rri/boiko/b50/2/arr_ohotny_ryad.mp3",3.689388},
    arr_profsoyuznaya = {"subway_announcers/rri/boiko/b50/2/arr_profsoyuznaya.mp3",2.278889},
    arr_sokol = {"subway_announcers/rri/boiko/b50/2/arr_sokol.mp3",1.876780},
    next_akademicheskaya = {"subway_announcers/rri/boiko/b50/2/next_akademicheskaya.mp3",5.546712},
    next_derjavinskaya = {"subway_announcers/rri/boiko/b50/2/next_derjavinskaya.mp3",5.031474},
    next_kirovskaya = {"subway_announcers/rri/boiko/b50/2/next_kirovskaya.mp3",5.105624},
    next_leninskaya = {"subway_announcers/rri/boiko/b50/2/next_leninskaya.mp3",5.129546},
    next_ohotny_ryad = {"subway_announcers/rri/boiko/b50/2/next_ohotny_ryad.mp3",6.871950},
    next_profsoyuznaya = {"subway_announcers/rri/boiko/b50/2/next_profsoyuznaya.mp3",5.099955},
    next_sokol = {"subway_announcers/rri/boiko/b50/2/next_sokol.mp3",4.716689},
    to_leninskaya = {"subway_announcers/rri/boiko/b50/2/to_leninskaya.mp3",3.299909},
    arr_avtostanciya_yujnaya = {"subway_announcers/rri/boiko/b50/3/arr_avtostanciya_yujnaya.mp3",2.634762},
    arr_muzey_skulptur = {"subway_announcers/rri/boiko/b50/3/arr_muzey_skulptur.mp3",2.595941},
    next_avtostanciya_yujnaya = {"subway_announcers/rri/boiko/b50/3/next_avtostanciya_yujnaya.mp3",5.735669},
    next_muzey_skulptur = {"subway_announcers/rri/boiko/b50/3/next_muzey_skulptur.mp3",5.769365},
    to_avtostanciya_yujnaya = {"subway_announcers/rri/boiko/b50/3/to_avtostanciya_yujnaya.mp3",5.443832},
},{
    {
        Name = "Industr.-Sineozern.",
        Loop = false,
        spec_last = {"last"},
        spec_wait = {{"train_stop"},{"train_depeat"}},
        {
            108,"Avtozavodskaya",
            arrlast = {nil, {"arr_avtozavodskaya", 0.5, "last"}, "avtozavodskaya"},
            dep = {{ "next_industrialnaya",0.1,"politeness"}}
        },
        {
            109,"Industrialnaya",
            arr = {"arr_industrialnaya", "arr_industrialnaya"},
            dep = {{ "next_moskovskaya"}, { "next_avtozavodskaya"}}
        },
        {
            110,"Moskovskaya",
            arr = {{"arr_moskovskaya",0.1,"politeness"}, "arr_moskovskaya"},
            dep = {{ "next_oktyabrskaya",0.1,"objects"}, { "next_industrialnaya",0.1,"handrails"}}
        },
        {
            111,"Oktyabrskaya",
            arr = {"arr_oktyabrskaya", "arr_oktyabrskaya"},
            dep = {{ "next_ploschad_myra"}, { "next_moskovskaya"}},
            arrlast = {{"arr_oktyabrskaya", 0.5, "last"}, {"arr_oktyabrskaya", 0.5, "last"}, "oktyabrskaya"},
            not_last = {3, "to_oktyabrskaya"}
        },
        {
            112,"Ploschad myra",
            arr = {{"arr_ploschad_myra",0.1,"things"}, "arr_ploschad_myra"},
            dep = {{ "next_novoarmeyskaya"}, { "next_oktyabrskaya"}},
            arrlast = {{"arr_ploschad_myra", 0.5, "last"}, {"arr_ploschad_myra", 0.5, "last"}, "ploschad_myra"},
            not_last = {3, "to_ploschad_myra"}
        },
        {
            113,"Novoarmeyskaya",
            arr = {{"arr_novoarmeyskaya", "skip_vokzalnaya"}, {"arr_novoarmeyskaya",0.1,"exit"}},
            dep = {{ "next_komsomolskaya",0.1,"handrails"}, { "next_ploschad_myra",0.1,"objects"}}
        },
        {
            115,"Komsomolskaya",
            arr = {{"arr_komsomolskaya",0.1,"things"}, {"arr_komsomolskaya", "skip_vokzalnaya",0.1,"objects"}},
            dep = {{ "next_elektrosila"}, { "next_novoarmeyskaya",0.1,"handrails"}},
            arrlast = {{"arr_komsomolskaya", 0.5, "last"}, {"arr_komsomolskaya", 0.5, "last"}, "komsomolskaya"},
            not_last = {3, "to_komsomolskaya"},
            have_inrerchange = true
        },
        {
            116,"Elektrosila",
            arr = {"arr_elektrosila", "arr_elektrosila"},
            dep = {{ "next_teatralnaya_ploschad"}, { "next_komsomolskaya"}}
        },
        {
            117,"Teatr. ploschad",
            arr = {{"arr_teatralnaya_ploschad",0.1,"handrails"}, "arr_teatralnaya_ploschad"},
            dep = {{ "next_park_pobedy",0.1,"exit"}, { "next_elektrosila",0.1,"exit"}}
        },
        {
            118,"Park pobedy",
            arr = {"arr_park_pobedy", {"arr_park_pobedy",0.1,"politeness"}},
            dep = {{ "next_sineozernaya"}, { "next_teatralnaya_ploschad"}}
        },
        {
            119,"Sineozernaya",
            arr = {"arr_sineozernaya", "arr_sineozernaya"},
            dep = {{ "next_minskaya",0.1,"things"}, { "next_park_pobedy",0.1,"objects"}}
        },
        {
            121,"Minskaya",
            arr = {{"arr_minskaya",0.1,"objects"}, {"arr_minskaya",0.1,"things"}},
            dep = {{ "next_tsarskiye_vorota"}, { "next_sineozernaya"}},
            arrlast = {{"arr_minskaya", 0.5, "last"}, {"arr_minskaya", 0.5, "last"}, "minskaya"},
            not_last = {3, "to_minskaya"}
        },
        {
            122,"Tsarskiye vorota",
            arr = {{"arr_tsarskiye_vorota", 3, "to_mejdustroyskaya"}, "arr_tsarskiye_vorota"},
            dep = {{ "next_mejdustroyskaya"}, { "next_minskaya"}}
        },
        {
            123,"Mejdustroyskaya",
            arr = {"arr_mejdustroyskaya", {"arr_mejdustroyskaya"}},
            arrlast = {{"arr_mejdustroyskaya", 0.5, "last"}, nil, "mejdustroyskaya"},
            dep = {nil, { "next_tsarskiye_vorota",0.1,"politeness"}}
        }
    },
    {
        Name = "Industr.-Av.Uj.",
        Loop = false,
        spec_last = {"last"},
        spec_wait = {{"train_stop"},{"train_depeat"}},
        {
            108,"Avtozavodskaya",
            arrlast = {nil, {"arr_avtozavodskaya", 0.5, "last"}, "avtozavodskaya"},
            dep = {{ "next_industrialnaya",0.1,"politeness"}}
        },
        {
            109,"Industrialnaya",
            arr = {"arr_industrialnaya", "arr_industrialnaya"},
            dep = {{ "next_moskovskaya"}, { "next_avtozavodskaya"}}
        },
        {
            110,"Moskovskaya",
            arr = {{"arr_moskovskaya",0.1,"politeness"}, "arr_moskovskaya"},
            dep = {{ "next_oktyabrskaya",0.1,"objects"}, { "next_industrialnaya",0.1,"handrails"}}
        },
        {
            111,"Oktyabrskaya",
            arr = {"arr_oktyabrskaya", "arr_oktyabrskaya"},
            dep = {{ "next_ploschad_myra"}, { "next_moskovskaya"}},
            arrlast = {{"arr_oktyabrskaya", 0.5, "last"}, {"arr_oktyabrskaya", 0.5, "last"}, "oktyabrskaya"},
            not_last = {3, "to_oktyabrskaya"}
        },
        {
            112,"Ploschad myra",
            arr = {{"arr_ploschad_myra",0.1,"things"}, "arr_ploschad_myra"},
            dep = {{ "next_novoarmeyskaya"}, { "next_oktyabrskaya"}},
            arrlast = {{"arr_ploschad_myra", 0.5, "last"}, {"arr_ploschad_myra", 0.5, "last"}, "ploschad_myra"},
            not_last = {3, "to_ploschad_myra"}
        },
        {
            113,"Novoarmeyskaya",
            arr = {{"arr_novoarmeyskaya", "skip_vokzalnaya"}, {"arr_novoarmeyskaya",0.1,"exit"}},
            dep = {{ "next_komsomolskaya",0.1,"handrails"}, { "next_ploschad_myra",0.1,"objects"}}
        },
        {
            115,"Komsomolskaya",
            arr = {{"arr_komsomolskaya",0.1,"things"}, {"arr_komsomolskaya", "skip_vokzalnaya",0.1,"objects"}},
            dep = {{ "next_elektrosila"}, { "next_novoarmeyskaya",0.1,"handrails"}},
            arrlast = {{"arr_komsomolskaya", 0.5, "last"}, {"arr_komsomolskaya", 0.5, "last"}, "komsomolskaya"},
            not_last = {3, "to_komsomolskaya"},
            have_inrerchange = true
        },
        {
            116,"Elektrosila",
            arr = {"arr_elektrosila", "arr_elektrosila"},
            dep = {{ "next_teatralnaya_ploschad"}, { "next_komsomolskaya"}}
        },
        {
            117,"Teatr. ploschad",
            arr = {{"arr_teatralnaya_ploschad",0.1,"handrails"}, "arr_teatralnaya_ploschad"},
            dep = {{ "next_park_pobedy",0.1,"exit"}, { "next_elektrosila",0.1,"exit"}}
        },
        {
            118,"Park pobedy",
            arr = {"arr_park_pobedy", {"arr_park_pobedy",0.1,"politeness"}},
            dep = {{ "next_sineozernaya"}, { "next_teatralnaya_ploschad"}}
        },
        {
            119,"Sineozernaya",
            arr = {"arr_sineozernaya", "arr_sineozernaya"},
            dep = {{ "next_minskaya",0.1,"things"}, { "next_park_pobedy",0.1,"objects"}}
        },
        {
            121,"Minskaya",
            arr = {{"arr_minskaya",0.1,"objects"}, {"arr_minskaya",0.1,"things"}},
            dep = {{ "next_tsarskiye_vorota"}, { "next_sineozernaya"}},
            arrlast = {{"arr_minskaya", 0.5, "last"}, {"arr_minskaya", 0.5, "last"}, "minskaya"},
            not_last = {3, "to_minskaya"}
        },
        {
            122,"Tsarskiye vorota",
            arr = {{"arr_tsarskiye_vorota", 3, "to_avtostanciya_yujnaya"}, "arr_tsarskiye_vorota"},
            dep = {{ "next_muzey_skulptur"}, { "next_minskaya"}}
        },
        {
            321,"Muzey skulptur",
            arr = {{"arr_muzey_skulptur",0.1,"politeness"}, {"arr_muzey_skulptur",0.1,"exit"}},
            dep = {{ "next_avtostanciya_yujnaya",0.1,"things"}, { "next_tsarskiye_vorota"}}
        },
        {
            322,"Avtostanciya yujnaya",
            arr = {"arr_avtostanciya_yujnaya", "arr_avtostanciya_yujnaya"},
            arrlast = {{"arr_avtostanciya_yujnaya", 0.5, "last"}, nil, "avtostanciya_yujnaya"},
            dep = {nil, { "next_muzey_skulptur",0.1,"handrails"}}
        }
    },
})

Metrostroi.AddANSPAnnouncer("ASNP Boiko + Pyaseckaya",{
    asnp = true,

    click1 = {"subway_announcers/asnp/boiko_new/click1.mp3",0.5},
    click2 = {"subway_announcers/asnp/boiko_new/click2.mp3",0.3},
    click3 = {"subway_announcers/asnp/boiko_new/click3.mp3",0.3},


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

    avtozavodskaya_m = {"subway_announcers/asnp/boiko_new/b50/1/avtozavodskaya.mp3",1.297188},
    elektrosila_m = {"subway_announcers/asnp/boiko_new/b50/1/elektrosila.mp3",1.084354},
    industrialnaya_m = {"subway_announcers/asnp/boiko_new/b50/1/industrialnaya.mp3",1.160792},
    komsomolskaya_m = {"subway_announcers/asnp/boiko_new/b50/1/komsomolskaya.mp3",1.144188},
    komsomolskaya_arr_m = {"subway_announcers/asnp/boiko_new/b50/1/komsomolskaya_arr.mp3",5.042271},
    komsomolskaya_next_m = {"subway_announcers/asnp/boiko_new/b50/1/komsomolskaya_next.mp3",2.497333},
    mejdustroyskaya_m = {"subway_announcers/asnp/boiko_new/b50/1/mejdustroyskaya.mp3",1.300000},
    mejdustroyskaya_arr_m = {"subway_announcers/asnp/boiko_new/b50/1/mejdustroyskaya_arr.mp3",2.727396},
    minskaya_m = {"subway_announcers/asnp/boiko_new/b50/1/minskaya.mp3",0.873375},
    moskovskaya_m = {"subway_announcers/asnp/boiko_new/b50/1/moskovskaya.mp3",2.484708},
    novoarmeyskaya_m = {"subway_announcers/asnp/boiko_new/b50/1/novoarmeyskaya.mp3",1.278167},
    oktyabrskaya_m = {"subway_announcers/asnp/boiko_new/b50/1/oktyabrskaya.mp3",1.017979},
    park_pobedy_m = {"subway_announcers/asnp/boiko_new/b50/1/park_pobedy.mp3",2.479792},
    ploschad_myra_m = {"subway_announcers/asnp/boiko_new/b50/1/ploschad_myra.mp3",1.123229},
    sineozernaya_m = {"subway_announcers/asnp/boiko_new/b50/1/sineozernaya.mp3",1.111458},
    skip_lesnaya_m = {"subway_announcers/asnp/boiko_new/b50/1/skip_lesnaya.mp3",5.215625},
    skip_vokzalnaya_m = {"subway_announcers/asnp/boiko_new/b50/1/skip_vokzalnaya.mp3",5.280792},
    teatralnaya_ploschad_m = {"subway_announcers/asnp/boiko_new/b50/1/teatralnaya_ploschad.mp3",1.436104},
    tsarskiye_vorota_m = {"subway_announcers/asnp/boiko_new/b50/1/tsarskiye_vorota.mp3",1.309313},
    vokzalnaya_m = {"subway_announcers/asnp/boiko_new/b50/1/vokzalnaya.mp3",1.039125},

    avtostanciya_yujnaya_m = {"subway_announcers/asnp/boiko_new/b50/3/avtostanciya_yujnaya.mp3",1.914771},
    muzey_skulptur_m = {"subway_announcers/asnp/boiko_new/b50/3/muzey_skulptur.mp3",1.138042},

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

    arr_avtozavodskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/arr_avtozavodskaya.mp3",2.202729},
    arr_elektrosila_f = {"subway_announcers/asnp/pyaseckaya/b50/1/arr_elektrosila.mp3",2.293104},
    arr_industrialnaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/arr_industrialnaya.mp3",2.040417},
    arr_komsomolskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/arr_komsomolskaya.mp3",6.179500},
    arr_mejdustroyskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/arr_mejdustroyskaya.mp3",3.846125},
    arr_minskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/arr_minskaya.mp3",2.087354},
    arr_moskovskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/arr_moskovskaya.mp3",3.358958},
    arr_novoarmeyskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/arr_novoarmeyskaya.mp3",2.356708},
    arr_oktyabrskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/arr_oktyabrskaya.mp3",2.000917},
    arr_park_pobedy_f = {"subway_announcers/asnp/pyaseckaya/b50/1/arr_park_pobedy.mp3",3.815313},
    arr_ploschad_myra_f = {"subway_announcers/asnp/pyaseckaya/b50/1/arr_ploschad_myra.mp3",2.391229},
    arr_sineozernaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/arr_sineozernaya.mp3",2.524604},
    arr_tetralnaya_ploschad_f = {"subway_announcers/asnp/pyaseckaya/b50/1/arr_tetralnaya_ploschad.mp3",2.729667},
    arr_tsarskiye_vorota_f = {"subway_announcers/asnp/pyaseckaya/b50/1/arr_tsarskiye_vorota.mp3",2.853583},
    arr_vokzalnaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/arr_vokzalnaya.mp3",1.961479},
    avtozavodskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/avtozavodskaya.mp3",1.345104},
    komsomolskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/komsomolskaya.mp3",1.166375},
    mejdustroyskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/mejdustroyskaya.mp3",1.499396},
    minskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/minskaya.mp3",0.991021},
    next_avtozavodskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/next_avtozavodskaya.mp3",3.068979},
    next_elektrosila_f = {"subway_announcers/asnp/pyaseckaya/b50/1/next_elektrosila.mp3",3.157750},
    next_industrialnaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/next_industrialnaya.mp3",2.989896},
    next_komsomolskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/next_komsomolskaya.mp3",4.301313},
    next_mejdustroyskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/next_mejdustroyskaya.mp3",4.650063},
    next_minskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/next_minskaya.mp3",2.874417},
    next_moskovskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/next_moskovskaya.mp3",4.207333},
    next_novoarmeyskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/next_novoarmeyskaya.mp3",2.971479},
    next_oktyabrskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/next_oktyabrskaya.mp3",2.852229},
    next_park_pobedy_f = {"subway_announcers/asnp/pyaseckaya/b50/1/next_park_pobedy.mp3",4.466313},
    next_ploschad_myra_f = {"subway_announcers/asnp/pyaseckaya/b50/1/next_ploschad_myra.mp3",3.302917},
    next_sineozernaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/next_sineozernaya.mp3",3.238208},
    next_tetralnaya_ploschad_f = {"subway_announcers/asnp/pyaseckaya/b50/1/next_tetralnaya_ploschad.mp3",3.369938},
    next_tsarskiye_vorota_f = {"subway_announcers/asnp/pyaseckaya/b50/1/next_tsarskiye_vorota.mp3",3.423333},
    next_vokzalnaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/next_vokzalnaya.mp3",2.890313},
    oktyabrskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/oktyabrskaya.mp3",1.225917},
    ploschad_myra_f = {"subway_announcers/asnp/pyaseckaya/b50/1/ploschad_myra.mp3",1.491229},
    skip_lesnaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/skip_lesnaya.mp3",6.511333},
    skip_vokzalnaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/skip_vokzalnaya.mp3",6.290542},
    to_komsomolskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/to_komsomolskaya.mp3",3.467458},
    to_mejdustroyskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/to_mejdustroyskaya.mp3",3.811167},
    to_minskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/to_minskaya.mp3",3.523042},
    to_oktyabrskaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/to_oktyabrskaya.mp3",3.334688},
    to_ploschad_myra_f = {"subway_announcers/asnp/pyaseckaya/b50/1/to_ploschad_myra.mp3",3.480750},
    to_vokzalnaya_f = {"subway_announcers/asnp/pyaseckaya/b50/1/to_vokzalnaya.mp3",3.464708},
    vokzalnaya = {"subway_announcers/asnp/pyaseckaya/b50/1/vokzalnaya.mp3",1.219938},

    arr_avtostanciya_yujnaya_f = {"subway_announcers/asnp/pyaseckaya/b50/3/arr_avtostanciya_yujnaya.mp3",2.790583},
    arr_muzey_skulptur_f = {"subway_announcers/asnp/pyaseckaya/b50/3/arr_muzey_skulptur.mp3",2.458417},
    avtostanciya_yujnaya_f = {"subway_announcers/asnp/pyaseckaya/b50/3/avtostanciya_yujnaya.mp3",2.082250},
    next_avtostanciya_yujnaya_f = {"subway_announcers/asnp/pyaseckaya/b50/3/next_avtostanciya_yujnaya.mp3",3.553896},
    next_muzey_skulptur_f = {"subway_announcers/asnp/pyaseckaya/b50/3/next_muzey_skulptur.mp3",3.205750},
    to_avtostanciya_yujnaya_f = {"subway_announcers/asnp/pyaseckaya/b50/3/to_avtostanciya_yujnaya.mp3",4.426438},
},
{
    {
        LED = {2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
        Name = "Индустриал.-Синеозёрн.",
        Loop = false,
        spec_last = {"last_m",0.5,"things_m"},
        spec_wait = {{"train_stop_m"},{"train_depeat_m"}},
        BlockDoors = true,
        {
            108,
            "Автозаводская",
            arrlast = {nil, {"arr_avtozavodskaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, "avtozavodskaya_m"},
            dep = {{"doors_closing_m", "industrialnaya_m",0.1,"politeness_m"}}
        },
        {
            109,
            "Индустриальная",
            arr = {{"station_m","industrialnaya_m"}, "arr_industrialnaya_f"},
            dep = {{"doors_closing_m", "moskovskaya_m"}, {"doors_closing_f", "next_avtozavodskaya_f"}},
            not_last_c = {nil,"not_last_f"}
        },
        {
            110,
            "Московская",
            arr = {{"station_m","moskovskaya_m",0.1,"politeness_m"}, "arr_moskovskaya_f"},
            dep = {{"doors_closing_m", "oktyabrskaya_m",0.1,"objects_m"}, {"doors_closing_f", "next_industrialnaya_f",0.1,"handrails_f"}},
            not_last_c = {nil,"not_last_f"},
            right_doors=true,
        },
        {
            111,
            "Октябрьская",
            arr = {{"station_m","oktyabrskaya_m"}, "arr_oktyabrskaya_f"},
            dep = {{"doors_closing_m", "ploschad_myra_m"}, {"doors_closing_f", "next_moskovskaya_f"}},
            arrlast = {{"station_m","oktyabrskaya_m", 0.5, "last_m",2,"things_m",2,"deadlock_m"}, {"arr_oktyabrskaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, "oktyabrskaya_m"},
            not_last = {3, "train_goes_to_m", "oktyabrskaya_m"},
            not_last_f = {3, "to_oktyabrskaya_f"},
            not_last_c = {nil,"not_last_f"}
        },
        {
            112,
            "Площадь мира",
            arr = {{"station_m","ploschad_myra_m",0.1,"things_m"}, "arr_ploschad_myra_f"},
            dep = {{"doors_closing_m", "novoarmeyskaya_m"}, {"doors_closing_f", "next_oktyabrskaya_f"}},
            arrlast = {{"station_m","ploschad_myra_m", 0.5, "last_m",2,"things_m",2,"deadlock_m"}, {"arr_ploschad_myra_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, "ploschad_myra_m"},
            not_last = {3, "train_goes_to_m", "ploschad_myra_m"},
            not_last_f = {3, "to_ploschad_myra_f"},
            not_last_c = {nil,"not_last_f"}
        },
        {
            113,
            "Новоармейская",
            arr = {{"station_m","novoarmeyskaya_m",0.1,"skip_vokzalnaya_m"}, {"arr_novoarmeyskaya_f",0.1,"exit_f"}},
            dep = {{"doors_closing_m", "komsomolskaya_next_m",0.1,"handrails_m"}, {"doors_closing_f", "next_ploschad_myra_f",0.1,"objects_f"}},
            not_last_c = {nil,"not_last_f"}
        },
        {
            115,
            "Комсомольская",
            arr = {{"arr_komsomolskaya_f",0.1,"things_f"}, {"station_m","komsomolskaya_arr_m",0.1,"objects_m",0.2,"skip_vokzalnaya_m"}},
            dep = {{"doors_closing_f", "next_elektrosila_f"}, {"doors_closing_m", "novoarmeyskaya_m",0.1,"handrails_m"}},
            arrlast = {{"arr_komsomolskaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, {"station_m","komsomolskaya_m", 0.5, "last_m",2,"things_m",2,"deadlock_m"}, "komsomolskaya_m"},
            not_last = {3, "train_goes_to_m", "komsomolskaya_m"},
            not_last_f = {3, "to_komsomolskaya_f"},
            not_last_c = {"not_last_f"},
            have_inrerchange = true,
            right_doors=true,
        },
        {
            116,
            "Электросила",
            arr = {"arr_elektrosila_f", {"station_m","elektrosila_m"}},
            dep = {{"doors_closing_f", "next_tetralnaya_ploschad_f"}, {"doors_closing_m", "komsomolskaya_next_m"}},
            not_last_c = {"not_last_f"}
        },
        {
            117,
            "Театр. площадь",
            arr = {{"arr_tetralnaya_ploschad_f",0.1,"handrails_f"}, {"station_m","teatralnaya_ploschad_m"}},
            dep = {{"doors_closing_f", "next_park_pobedy_f",0.1,"exit_f"}, {"doors_closing_m", "elektrosila_m",0.1,"exit_m"}},
            not_last_c = {"not_last_f"}
        },
        {
            118,
            "Парк победы",
            arr = {"arr_park_pobedy_f", {"station_m","park_pobedy_m",0.1,"politeness_m"}},
            dep = {{"doors_closing_f", "next_sineozernaya_f"}, {"doors_closing_m", "teatralnaya_ploschad_m"}},
            not_last_c = {"not_last_f"},
            right_doors=true,
        },
        {
            119,
            "Синеозёрная",
            arr = {"arr_sineozernaya_f", {"station_m","sineozernaya_m"}},
            dep = {{"doors_closing_f", "next_minskaya_f",0.1,"things_f"}, {"doors_closing_m", "park_pobedy_m",0.1,"objects_m"}},
            not_last_c = {"not_last_f"}
        },
        {
            121,
            "Минская",
            arr = {{"arr_minskaya_f",0.1,"objects_f"}, {"station_m","minskaya_m",0.1,"things_m"}},
            dep = {{"doors_closing_f", "next_tsarskiye_vorota_f"}, {"doors_closing_m", "sineozernaya_m"}},
            arrlast = {{"arr_minskaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, {"station_m","minskaya_m", 0.5, "last_m",2,"things_m",2,"deadlock_m"}, "minskaya_m"},
            not_last = {3, "train_goes_to_m", "minskaya_m"},
            not_last_f = {3, "to_minskaya_f"},
            not_last_c = {"not_last_f"}
        },
        {
            122,
            "Царские ворота",
            arr = {{"arr_tsarskiye_vorota_f", 3, "to_mejdustroyskaya_f"}, {"station_m","tsarskiye_vorota_m"}},
            dep = {{"doors_closing_f", "next_mejdustroyskaya_f"}, {"doors_closing_m", "minskaya_m"}},
            not_last_c = {"not_last_f"},
        },
        {
            123,
            "Междустройская",
            arr = {"arr_mejdustroyskaya_f"},
            arrlast = {{"arr_mejdustroyskaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, nil, "mejdustroyskaya_m"},
            dep = {nil, {"doors_closing_m", "tsarskiye_vorota_m",0.1,"politeness_m"}},
            right_doors=true,
        }
    },
    {
        LED = {2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        Name = "Индустриально-Авт.Юж.",
        Loop = false,
        spec_last = {"spec_attention_last",0.5,"spec_attention_things"},
        spec_wait = {{"spec_attention_train_stop"},{"spec_attention_train_depeat"}},
        BlockDoors = true,
        {
            108,
            "Автозаводская",
            arrlast = {nil, {"arr_avtozavodskaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, "avtozavodskaya_m"},
            dep = {{"doors_closing_m", "industrialnaya_m",0.1,"politeness_m"}}
        },
        {
            109,
            "Индустриальная",
            arr = {{"station_m","industrialnaya_m"}, "arr_industrialnaya_f"},
            dep = {{"doors_closing_m", "moskovskaya_m"}, {"doors_closing_f", "next_avtozavodskaya_f"}},
            not_last_c = {nil,"not_last_f"}
        },
        {
            110,
            "Московская",
            arr = {{"station_m","moskovskaya_m",0.1,"politeness_m"}, "arr_moskovskaya_f"},
            dep = {{"doors_closing_m", "oktyabrskaya_m",0.1,"objects_m"}, {"doors_closing_f", "next_industrialnaya_f",0.1,"handrails_f"}},
            not_last_c = {nil,"not_last_f"},
            right_doors=true,
        },
        {
            111,
            "Октябрьская",
            arr = {{"station_m","oktyabrskaya_m"}, "arr_oktyabrskaya_f"},
            dep = {{"doors_closing_m", "ploschad_myra_m"}, {"doors_closing_f", "next_moskovskaya_f"}},
            arrlast = {{"station_m","oktyabrskaya_m", 0.5, "last_m",2,"things_m",2,"deadlock_m"}, {"arr_oktyabrskaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, "oktyabrskaya_m"},
            not_last = {3, "train_goes_to_m", "oktyabrskaya_m"},
            not_last_f = {3, "to_oktyabrskaya_f"},
            not_last_c = {nil,"not_last_f"}
        },
        {
            112,
            "Площадь мира",
            arr = {{"station_m","ploschad_myra_m",0.1,"things_m"}, "arr_ploschad_myra_f"},
            dep = {{"doors_closing_m", "novoarmeyskaya_m"}, {"doors_closing_f", "next_oktyabrskaya_f"}},
            arrlast = {{"station_m","ploschad_myra_m", 0.5, "last_m",2,"things_m",2,"deadlock_m"}, {"arr_ploschad_myra_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, "ploschad_myra_m"},
            not_last = {3, "train_goes_to_m", "ploschad_myra_m"},
            not_last_f = {3, "to_ploschad_myra_f"},
            not_last_c = {nil,"not_last_f"}
        },
        {
            113,
            "Новоармейская",
            arr = {{"station_m","novoarmeyskaya_m",0.1,"skip_vokzalnaya_m"}, {"arr_novoarmeyskaya_f",0.1,"exit_f"}},
            dep = {{"doors_closing_m", "komsomolskaya_next_m",0.1,"handrails_m"}, {"doors_closing_f", "next_ploschad_myra_f",0.1,"objects_f"}},
            not_last_c = {nil,"not_last_f"}
        },
        {
            115,
            "Комсомольская",
            arr = {{"arr_komsomolskaya_f",0.1,"things_f"}, {"station_m","komsomolskaya_arr_m",0.1,"objects_m",0.2,"skip_vokzalnaya_m"}},
            dep = {{"doors_closing_f", "next_elektrosila_f"}, {"doors_closing_m", "novoarmeyskaya_m",0.1,"handrails_m"}},
            arrlast = {{"arr_komsomolskaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, {"station_m","komsomolskaya_m", 0.5, "last_m",2,"things_m",2,"deadlock_m"}, "komsomolskaya_m"},
            not_last = {3, "train_goes_to_m", "komsomolskaya_m"},
            not_last_f = {3, "to_komsomolskaya_f"},
            not_last_c = {"not_last_f"},
            have_inrerchange = true,
            right_doors=true,
        },
        {
            116,
            "Электросила",
            arr = {"arr_elektrosila_f", {"station_m","elektrosila_m"}},
            dep = {{"doors_closing_f", "next_tetralnaya_ploschad_f"}, {"doors_closing_m", "komsomolskaya_next_m"}},
            not_last_c = {"not_last_f"}
        },
        {
            117,
            "Театр. площадь",
            arr = {{"arr_tetralnaya_ploschad_f",0.1,"handrails_f"}, {"station_m","teatralnaya_ploschad_m"}},
            dep = {{"doors_closing_f", "next_park_pobedy_f",0.1,"exit_f"}, {"doors_closing_m", "elektrosila_m",0.1,"exit_m"}},
            not_last_c = {"not_last_f"}
        },
        {
            118,
            "Парк победы",
            arr = {"arr_park_pobedy_f", {"station_m","park_pobedy_m",0.1,"politeness_m"}},
            dep = {{"doors_closing_f", "next_sineozernaya_f"}, {"doors_closing_m", "teatralnaya_ploschad_m"}},
            not_last_c = {"not_last_f"},
            right_doors=true,
        },
        {
            119,
            "Синеозёрная",
            arr = {"arr_sineozernaya_f", {"station_m","sineozernaya_m"}},
            dep = {{"doors_closing_f", "next_minskaya_f",0.1,"things_f"}, {"doors_closing_m", "park_pobedy_m",0.1,"objects_m"}},
            not_last_c = {"not_last_f"}
        },
        {
            121,
            "Минская",
            arr = {{"arr_minskaya_f",0.1,"objects_f"}, {"station_m","minskaya_m",0.1,"things_m"}},
            dep = {{"doors_closing_f", "next_tsarskiye_vorota_f"}, {"doors_closing_m", "sineozernaya_m"}},
            arrlast = {{"arr_minskaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, {"station_m","minskaya_m", 0.5, "last_m",2,"things_m",2,"deadlock_m"}, "minskaya_m"},
            not_last = {3, "train_goes_to_m", "minskaya_m"},
            not_last_f = {3, "to_minskaya_f"},
            not_last_c = {"not_last_f"}
        },
        {
            122,
            "Царские ворота",
            arr = {{"arr_tsarskiye_vorota_f", 3, "to_avtostanciya_yujnaya_f"}, {"station_m","tsarskiye_vorota_m"}},
            dep = {{"doors_closing_f", "next_muzey_skulptur_f"}, {"doors_closing_m", "minskaya_m"}},
            not_last_c = {"not_last_f"},
        },
        {
            321,
            "Музей скульптур",
            arr = {"arr_muzey_skulptur_f", {"station_m","muzey_skulptur_m"}},
            dep = {{"doors_closing_f", "next_avtostanciya_yujnaya_f"}, {"doors_closing_m", "tsarskiye_vorota_m"}},
            not_last_c = {"not_last_f"},
        },
        {
            322,
            "Автостанция южная",
            arr = {"arr_avtostanciya_yujnaya_f"},
            arrlast = {{"arr_avtostanciya_yujnaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, nil, "avtostanciya_yujnaya_m"},
            dep = {nil, {"doors_closing_m", "muzey_skulptur_m",0.1,"politeness_m"}}
        },
    },
})

Metrostroi.AddANSPAnnouncer("RIU Boiko + Pyaseckaya",{
    riu = true,

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

    avtozavodskaya_m = {"subway_announcers/riu/boiko_new/b50/1/avtozavodskaya.mp3",1.390068},
    elektrosila_m = {"subway_announcers/riu/boiko_new/b50/1/elektrosila.mp3",1.269025},
    industrialnaya_m = {"subway_announcers/riu/boiko_new/b50/1/industrialnaya.mp3",1.483243},
    komsomolskaya_m = {"subway_announcers/riu/boiko_new/b50/1/komsomolskaya.mp3",1.220454},
    komsomolskaya_arr_m = {"subway_announcers/riu/boiko_new/b50/1/komsomolskaya_arr.mp3",5.675034},
    komsomolskaya_next_m = {"subway_announcers/riu/boiko_new/b50/1/komsomolskaya_next.mp3",2.854921},
    mejdustroyskaya_m = {"subway_announcers/riu/boiko_new/b50/1/mejdustroyskaya.mp3",1.497664},
    mejdustroyskaya_arr_m = {"subway_announcers/riu/boiko_new/b50/1/mejdustroyskaya_arr.mp3",3.011270},
    minskaya_m = {"subway_announcers/riu/boiko_new/b50/1/minskaya.mp3",0.973424},
    moskovskaya_m = {"subway_announcers/riu/boiko_new/b50/1/moskovskaya.mp3",2.823605},
    novoarmeyskaya_m = {"subway_announcers/riu/boiko_new/b50/1/novoarmeyskaya.mp3",1.396848},
    oktyabrskaya_m = {"subway_announcers/riu/boiko_new/b50/1/oktyabrskaya.mp3",1.317415},
    park_pobedy_m = {"subway_announcers/riu/boiko_new/b50/1/park_pobedy.mp3",2.724331},
    ploschad_myra_m = {"subway_announcers/riu/boiko_new/b50/1/ploschad_myra.mp3",1.281837},
    sineozernaya_m = {"subway_announcers/riu/boiko_new/b50/1/sineozernaya.mp3",1.276190},
    skip_vokzalnaya_m = {"subway_announcers/riu/boiko_new/b50/1/skip_vokzalnaya.mp3",6.786417},
    teatralnaya_ploschad_m = {"subway_announcers/riu/boiko_new/b50/1/teatralnaya_ploschad.mp3",1.667800},
    tsarskiye_vorota_m = {"subway_announcers/riu/boiko_new/b50/1/tsarskiye_vorota.mp3",1.366372},
    vokzalnaya_m = {"subway_announcers/riu/boiko_new/b50/1/vokzalnaya.mp3",1.185125},

    avtostanciya_yujnaya_m = {"subway_announcers/riu/boiko_new/b50/3/avtostanciya_yujnaya.mp3",2.336599},
    muzey_skulptur_m = {"subway_announcers/riu/boiko_new/b50/3/muzey_skulptur.mp3",1.446553},

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

    arr_avtozavodskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/arr_avtozavodskaya.mp3",2.269501},
    arr_elektrosila_f = {"subway_announcers/riu/pyaseckaya/b50/1/arr_elektrosila.mp3",2.226463},
    arr_industrialnaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/arr_industrialnaya.mp3",2.021995},
    arr_komsomolskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/arr_komsomolskaya.mp3",6.268594},
    arr_mejdustroyskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/arr_mejdustroyskaya.mp3",3.773764},
    arr_minskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/arr_minskaya.mp3",2.002063},
    arr_moskovskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/arr_moskovskaya.mp3",3.290907},
    arr_novoarmeyskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/arr_novoarmeyskaya.mp3",2.396190},
    arr_oktyabrskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/arr_oktyabrskaya.mp3",2.053832},
    arr_park_pobedy_f = {"subway_announcers/riu/pyaseckaya/b50/1/arr_park_pobedy.mp3",3.958390},
    arr_ploschad_myra_f = {"subway_announcers/riu/pyaseckaya/b50/1/arr_ploschad_myra.mp3",2.362041},
    arr_sineozernaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/arr_sineozernaya.mp3",2.476916},
    arr_tetralnaya_ploschad_f = {"subway_announcers/riu/pyaseckaya/b50/1/arr_tetralnaya_ploschad.mp3",2.726508},
    arr_tsarskiye_vorota_f = {"subway_announcers/riu/pyaseckaya/b50/1/arr_tsarskiye_vorota.mp3",2.827642},
    arr_vokzalnaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/arr_vokzalnaya.mp3",2.000000},
    avtozavodskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/avtozavodskaya.mp3",1.404308},
    komsomolskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/komsomolskaya.mp3",1.159615},
    mejdustroyskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/mejdustroyskaya.mp3",1.476440},
    minskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/minskaya.mp3",0.988980},
    next_avtozavodskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/next_avtozavodskaya.mp3",3.073039},
    next_elektrosila_f = {"subway_announcers/riu/pyaseckaya/b50/1/next_elektrosila.mp3",3.125510},
    next_industrialnaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/next_industrialnaya.mp3",3.000363},
    next_komsomolskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/next_komsomolskaya.mp3",4.254943},
    next_mejdustroyskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/next_mejdustroyskaya.mp3",4.575692},
    next_minskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/next_minskaya.mp3",2.992993},
    next_moskovskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/next_moskovskaya.mp3",4.171338},
    next_novoarmeyskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/next_novoarmeyskaya.mp3",3.179637},
    next_oktyabrskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/next_oktyabrskaya.mp3",3.000000},
    next_park_pobedy_f = {"subway_announcers/riu/pyaseckaya/b50/1/next_park_pobedy.mp3",4.765556},
    next_ploschad_myra_f = {"subway_announcers/riu/pyaseckaya/b50/1/next_ploschad_myra.mp3",3.326009},
    next_sineozernaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/next_sineozernaya.mp3",3.375941},
    next_tetralnaya_ploschad_f = {"subway_announcers/riu/pyaseckaya/b50/1/next_tetralnaya_ploschad.mp3",3.578753},
    next_tsarskiye_vorota_f = {"subway_announcers/riu/pyaseckaya/b50/1/next_tsarskiye_vorota.mp3",3.654376},
    next_vokzalnaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/next_vokzalnaya.mp3",2.899229},
    oktyabrskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/oktyabrskaya.mp3",1.357324},
    ploschad_myra_f = {"subway_announcers/riu/pyaseckaya/b50/1/ploschad_myra.mp3",1.503424},
    skip_lesnaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/skip_lesnaya.mp3",6.401995},
    skip_vokzalnaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/skip_vokzalnaya.mp3",6.232766},
    to_komsomolskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/to_komsomolskaya.mp3",3.429864},
    to_mejdustroyskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/to_mejdustroyskaya.mp3",3.560544},
    to_minskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/to_minskaya.mp3",3.489977},
    to_oktyabrskaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/to_oktyabrskaya.mp3",3.348458},
    to_ploschad_myra_f = {"subway_announcers/riu/pyaseckaya/b50/1/to_ploschad_myra.mp3",3.502449},
    to_vokzalnaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/to_vokzalnaya.mp3",3.545510},
    vokzalnaya_f = {"subway_announcers/riu/pyaseckaya/b50/1/vokzalnaya.mp3",1.223152},

    arr_avtostanciya_yujnaya_f = {"subway_announcers/riu/pyaseckaya/b50/3/arr_avtostanciya_yujnaya.mp3",2.928866},
    arr_muzey_skulptur_f = {"subway_announcers/riu/pyaseckaya/b50/3/arr_muzey_skulptur.mp3",2.384694},
    avtostanciya_yujnaya_f = {"subway_announcers/riu/pyaseckaya/b50/3/avtostanciya_yujnaya.mp3",2.112041},
    next_avtostanciya_yujnaya_f = {"subway_announcers/riu/pyaseckaya/b50/3/next_avtostanciya_yujnaya.mp3",3.654626},
    next_muzey_skulptur_f = {"subway_announcers/riu/pyaseckaya/b50/3/next_muzey_skulptur.mp3",3.192313},
    to_avtostanciya_yujnaya_f = {"subway_announcers/riu/pyaseckaya/b50/3/to_avtostanciya_yujnaya.mp3",4.618163},
},
{
    {
        LED = {2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
        Name = "Индустриал.-Синеозёрн.",
        Loop = false,
        BlockDoors = true,
        spec_last = {"last_m",0.5,"things_m"},
        spec_wait = {{"train_stop_m"},{"train_depeat_m"}},
        {
            108,
            "Автозаводская","Avtozavodskaya",
            arrlast = {nil, {"arr_avtozavodskaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, "avtozavodskaya_m"},
            dep = {{"doors_closing_m", "industrialnaya_m",0.1,"politeness_m"}}
        },
        {
            109,
            "Индустриальная","Industrialnaya",
            arr = {{"station_m","industrialnaya_m"}, "arr_industrialnaya_f"},
            dep = {{"doors_closing_m", "moskovskaya_m"}, {"doors_closing_f", "next_avtozavodskaya_f"}},
            not_last_c = {nil,"not_last_f"}
        },
        {
            110,
            "Московская","Moskovskaya",
            arr = {{"station_m","moskovskaya_m",0.1,"politeness_m"}, "arr_moskovskaya_f"},
            dep = {{"doors_closing_m", "oktyabrskaya_m",0.1,"objects_m"}, {"doors_closing_f", "next_industrialnaya_f",0.1,"handrails_f"}},
            not_last_c = {nil,"not_last_f"},
            right_doors=true,
        },
        {
            111,
            "Октябрьская","Oktyabrskaya",
            arr = {{"station_m","oktyabrskaya_m"}, "arr_oktyabrskaya_f"},
            dep = {{"doors_closing_m", "ploschad_myra_m"}, {"doors_closing_f", "next_moskovskaya_f"}},
            arrlast = {{"station_m","oktyabrskaya_m", 0.5, "last_m",2,"things_m",2,"deadlock_m"}, {"arr_oktyabrskaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, "oktyabrskaya_m"},
            not_last = {3, "train_goes_to_m", "oktyabrskaya_m"},
            not_last_f = {3, "to_oktyabrskaya_f"},
            not_last_c = {nil,"not_last_f"}
        },
        {
            112,
            "Площадь мира","Ploschad myra",
            arr = {{"station_m","ploschad_myra_m",0.1,"things_m"}, "arr_ploschad_myra_f"},
            dep = {{"doors_closing_m", "novoarmeyskaya_m"}, {"doors_closing_f", "next_oktyabrskaya_f"}},
            arrlast = {{"station_m","ploschad_myra_m", 0.5, "last_m",2,"things_m",2,"deadlock_m"}, {"arr_ploschad_myra_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, "ploschad_myra_m"},
            not_last = {3, "train_goes_to_m", "ploschad_myra_m"},
            not_last_f = {3, "to_ploschad_myra_f"},
            not_last_c = {nil,"not_last_f"}
        },
        {
            113,
            "Новоармейская","Novoarmeyskaya",
            arr = {{"station_m","novoarmeyskaya_m",0.1,"skip_vokzalnaya_m"}, {"arr_novoarmeyskaya_f",0.1,"exit_f"}},
            dep = {{"doors_closing_m", "komsomolskaya_next_m",0.1,"handrails_m"}, {"doors_closing_f", "next_ploschad_myra_f",0.1,"objects_f"}},
            not_last_c = {nil,"not_last_f"}
        },
        {
            115,
            "Комсомольская","Komsomolskaya",
            arr = {{"arr_komsomolskaya_f",0.1,"things_f"}, {"station_m","komsomolskaya_arr_m",0.1,"objects_m",0.2,"skip_vokzalnaya_m"}},
            dep = {{"doors_closing_f", "next_elektrosila_f"}, {"doors_closing_m", "novoarmeyskaya_m",0.1,"handrails_m"}},
            arrlast = {{"arr_komsomolskaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, {"station_m","komsomolskaya_m", 0.5, "last_m",2,"things_m",2,"deadlock_m"}, "komsomolskaya_m"},
            not_last = {3, "train_goes_to_m", "komsomolskaya_m"},
            not_last_f = {3, "to_komsomolskaya_f"},
            not_last_c = {"not_last_f"},
            have_inrerchange = true,
            right_doors=true,
        },
        {
            116,
            "Электросила","Elektrosila",
            arr = {"arr_elektrosila_f", {"station_m","elektrosila_m"}},
            dep = {{"doors_closing_f", "next_tetralnaya_ploschad_f"}, {"doors_closing_m", "komsomolskaya_next_m"}},
            not_last_c = {"not_last_f"}
        },
        {
            117,
            "Театр. площадь","Teatr. ploschad",
            arr = {{"arr_tetralnaya_ploschad_f",0.1,"handrails_f"}, {"station_m","teatralnaya_ploschad_m"}},
            dep = {{"doors_closing_f", "next_park_pobedy_f",0.1,"exit_f"}, {"doors_closing_m", "elektrosila_m",0.1,"exit_m"}},
            not_last_c = {"not_last_f"}
        },
        {
            118,
            "Парк победы","Park pobedy",
            arr = {"arr_park_pobedy_f", {"station_m","park_pobedy_m",0.1,"politeness_m"}},
            dep = {{"doors_closing_f", "next_sineozernaya_f"}, {"doors_closing_m", "teatralnaya_ploschad_m"}},
            not_last_c = {"not_last_f"},
            right_doors=true,
        },
        {
            119,
            "Синеозёрная","Sineozernaya",
            arr = {"arr_sineozernaya_f", {"station_m","sineozernaya_m"}},
            dep = {{"doors_closing_f", "next_minskaya_f",0.1,"things_f"}, {"doors_closing_m", "park_pobedy_m",0.1,"objects_m"}},
            not_last_c = {"not_last_f"}
        },
        {
            121,
            "Минская","Minskaya",
            arr = {{"arr_minskaya_f",0.1,"objects_f"}, {"station_m","minskaya_m",0.1,"things_m"}},
            dep = {{"doors_closing_f", "next_tsarskiye_vorota_f"}, {"doors_closing_m", "sineozernaya_m"}},
            arrlast = {{"arr_minskaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, {"station_m","minskaya_m", 0.5, "last_m",2,"things_m",2,"deadlock_m"}, "minskaya_m"},
            not_last = {3, "train_goes_to_m", "minskaya_m"},
            not_last_f = {3, "to_minskaya_f"},
            not_last_c = {"not_last_f"}
        },
        {
            122,
            "Царские ворота","Tsarskiye vorota",
            arr = {{"arr_tsarskiye_vorota_f", 3, "to_mejdustroyskaya_f"}, {"station_m","tsarskiye_vorota_m"}},
            dep = {{"doors_closing_f", "next_mejdustroyskaya_f"}, {"doors_closing_m", "minskaya_m"}},
            not_last_c = {"not_last_f"},
        },
        {
            123,
            "Междустройская","Mejdustroyskaya",
            arr = {"arr_mejdustroyskaya_f"},
            arrlast = {{"arr_mejdustroyskaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, nil, "mejdustroyskaya_m"},
            dep = {nil, {"doors_closing_m", "tsarskiye_vorota_m",0.1,"politeness_m"}},
            right_doors=true,
        }
    },
    {
        LED = {2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        Name = "Индустриально-Авт.Юж.",
        Loop = false,
        BlockDoors = true,
        spec_last = {"spec_attention_last",0.5,"spec_attention_things"},
        spec_wait = {{"spec_attention_train_stop"},{"spec_attention_train_depeat"}},
        {
            108,
            "Автозаводская","Avtozavodskaya",
            arrlast = {nil, {"arr_avtozavodskaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, "avtozavodskaya_m"},
            dep = {{"doors_closing_m", "industrialnaya_m",0.1,"politeness_m"}}
        },
        {
            109,
            "Индустриальная","Industrialnaya",
            arr = {{"station_m","industrialnaya_m"}, "arr_industrialnaya_f"},
            dep = {{"doors_closing_m", "moskovskaya_m"}, {"doors_closing_f", "next_avtozavodskaya_f"}},
            not_last_c = {nil,"not_last_f"}
        },
        {
            110,
            "Московская","Moskovskaya",
            arr = {{"station_m","moskovskaya_m",0.1,"politeness_m"}, "arr_moskovskaya_f"},
            dep = {{"doors_closing_m", "oktyabrskaya_m",0.1,"objects_m"}, {"doors_closing_f", "next_industrialnaya_f",0.1,"handrails_f"}},
            not_last_c = {nil,"not_last_f"},
            right_doors=true,
        },
        {
            111,
            "Октябрьская","Oktyabrskaya",
            arr = {{"station_m","oktyabrskaya_m"}, "arr_oktyabrskaya_f"},
            dep = {{"doors_closing_m", "ploschad_myra_m"}, {"doors_closing_f", "next_moskovskaya_f"}},
            arrlast = {{"station_m","oktyabrskaya_m", 0.5, "last_m",2,"things_m",2,"deadlock_m"}, {"arr_oktyabrskaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, "oktyabrskaya_m"},
            not_last = {3, "train_goes_to_m", "oktyabrskaya_m"},
            not_last_f = {3, "to_oktyabrskaya_f"},
            not_last_c = {nil,"not_last_f"}
        },
        {
            112,
            "Площадь мира","Ploschad myra",
            arr = {{"station_m","ploschad_myra_m",0.1,"things_m"}, "arr_ploschad_myra_f"},
            dep = {{"doors_closing_m", "novoarmeyskaya_m"}, {"doors_closing_f", "next_oktyabrskaya_f"}},
            arrlast = {{"station_m","ploschad_myra_m", 0.5, "last_m",2,"things_m",2,"deadlock_m"}, {"arr_ploschad_myra_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, "ploschad_myra_m"},
            not_last = {3, "train_goes_to_m", "ploschad_myra_m"},
            not_last_f = {3, "to_ploschad_myra_f"},
            not_last_c = {nil,"not_last_f"}
        },
        {
            113,
            "Новоармейская","Novoarmeyskaya",
            arr = {{"station_m","novoarmeyskaya_m",0.1,"skip_vokzalnaya_m"}, {"arr_novoarmeyskaya_f",0.1,"exit_f"}},
            dep = {{"doors_closing_m", "komsomolskaya_next_m",0.1,"handrails_m"}, {"doors_closing_f", "next_ploschad_myra_f",0.1,"objects_f"}},
            not_last_c = {nil,"not_last_f"}
        },
        {
            115,
            "Комсомольская","Komsomolskaya",
            arr = {{"arr_komsomolskaya_f",0.1,"things_f"}, {"station_m","komsomolskaya_arr_m",0.1,"objects_m",0.2,"skip_vokzalnaya_m"}},
            dep = {{"doors_closing_f", "next_elektrosila_f"}, {"doors_closing_m", "novoarmeyskaya_m",0.1,"handrails_m"}},
            arrlast = {{"arr_komsomolskaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, {"station_m","komsomolskaya_m", 0.5, "last_m",2,"things_m",2,"deadlock_m"}, "komsomolskaya_m"},
            not_last = {3, "train_goes_to_m", "komsomolskaya_m"},
            not_last_f = {3, "to_komsomolskaya_f"},
            not_last_c = {"not_last_f"},
            have_inrerchange = true,
            right_doors=true,
        },
        {
            116,
            "Электросила","Elektrosila",
            arr = {"arr_elektrosila_f", {"station_m","elektrosila_m"}},
            dep = {{"doors_closing_f", "next_tetralnaya_ploschad_f"}, {"doors_closing_m", "komsomolskaya_next_m"}},
            not_last_c = {"not_last_f"}
        },
        {
            117,
            "Театр. площадь","Teatr. ploschad",
            arr = {{"arr_tetralnaya_ploschad_f",0.1,"handrails_f"}, {"station_m","teatralnaya_ploschad_m"}},
            dep = {{"doors_closing_f", "next_park_pobedy_f",0.1,"exit_f"}, {"doors_closing_m", "elektrosila_m",0.1,"exit_m"}},
            not_last_c = {"not_last_f"}
        },
        {
            118,
            "Парк победы","Park pobedy",
            arr = {"arr_park_pobedy_f", {"station_m","park_pobedy_m",0.1,"politeness_m"}},
            dep = {{"doors_closing_f", "next_sineozernaya_f"}, {"doors_closing_m", "teatralnaya_ploschad_m"}},
            not_last_c = {"not_last_f"},
            right_doors=true,
        },
        {
            119,
            "Синеозёрная","Sineozernaya",
            arr = {"arr_sineozernaya_f", {"station_m","sineozernaya_m"}},
            dep = {{"doors_closing_f", "next_minskaya_f",0.1,"things_f"}, {"doors_closing_m", "park_pobedy_m",0.1,"objects_m"}},
            not_last_c = {"not_last_f"}
        },
        {
            121,
            "Минская","Minskaya",
            arr = {{"arr_minskaya_f",0.1,"objects_f"}, {"station_m","minskaya_m",0.1,"things_m"}},
            dep = {{"doors_closing_f", "next_tsarskiye_vorota_f"}, {"doors_closing_m", "sineozernaya_m"}},
            arrlast = {{"arr_minskaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, {"station_m","minskaya_m", 0.5, "last_m",2,"things_m",2,"deadlock_m"}, "minskaya_m"},
            not_last = {3, "train_goes_to_m", "minskaya_m"},
            not_last_f = {3, "to_minskaya_f"},
            not_last_c = {"not_last_f"}
        },
        {
            122,
            "Царские ворота","Tsarskiye vorota",
            arr = {{"arr_tsarskiye_vorota_f", 3, "to_avtostanciya_yujnaya_f"}, {"station_m","tsarskiye_vorota_m"}},
            dep = {{"doors_closing_f", "next_muzey_skulptur_f"}, {"doors_closing_m", "minskaya_m"}},
            not_last_c = {"not_last_f"},
        },
        {
            321,
            "Музей скульптур","Muzey skulptur",
            arr = {"arr_muzey_skulptur_f", {"station_m","muzey_skulptur_m"}},
            dep = {{"doors_closing_f", "next_avtostanciya_yujnaya_f"}, {"doors_closing_m", "tsarskiye_vorota_m"}},
            not_last_c = {"not_last_f"},
        },
        {
            322,
            "Автостанция южная","Avtostanciya yujnaya",
            arr = {"arr_avtostanciya_yujnaya_f"},
            arrlast = {{"arr_avtostanciya_yujnaya_f", 0.5, "last_f",2,"things_f",2,"deadlock_f"}, nil, "avtostanciya_yujnaya_m"},
            dep = {nil, {"doors_closing_m", "muzey_skulptur_m",0.1,"politeness_m"}}
        },
    },
})
Metrostroi.AddSarmatUPOAnnouncer("UPO RHINO",{
    tone = {"subway_announcers/sarmat_upo/tone.mp3", 1},
    avtozavodskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/avtozavodskaya.mp3", 1.070100},
    next_avtozavodskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_avtozavodskaya.mp3", 1.957500},
    last_avtozavodskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/last_avtozavodskaya.mp3", 10.100700},
    industrialnaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/industrialnaya.mp3", 1.017900},
    next_industrialnaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_industrialnaya.mp3", 1.983600},
    moskovskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/moskovskaya.mp3", 0.730800},
    next_moskovskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_moskovskaya.mp3", 3.158100},
    next_moskovskaya1 = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_moskovskaya1.mp3", 1.800900},
    oktyabrskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/oktyabrskaya.mp3", 0.887400},
    next_oktyabrskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_oktyabrskaya.mp3", 1.853100},
    last_oktyabrskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/last_oktyabrskaya.mp3", 10.074600},
    ploschad_myra = {"subway_announcers/sarmat_upo/rhino/metrostroi/ploschad_myra.mp3", 0.835200},
    next_ploschad_myra = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_ploschad_myra.mp3", 1.879200},
    last_ploschad_myra = {"subway_announcers/sarmat_upo/rhino/metrostroi/last_ploschad_myra.mp3", 10.283400},
    novoarmeyskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/novoarmeyskaya.mp3", 0.809100},
    next_novoarmeyskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_novoarmeyskaya.mp3", 1.879200},
    vokzalnaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/vokzalnaya.mp3", 0.783000},
    next_vokzalnaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_vokzalnaya.mp3", 1.748700},
    last_vokzalnaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/last_vokzalnaya.mp3", 9.865800},
    komsomolskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/komsomolskaya.mp3", 0.887400},
    next_komsomolskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_komsomolskaya.mp3", 3.340800},
    next_komsomolskaya1 = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_komsomolskaya1.mp3", 1.879200},
    last_komsomolskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/last_komsomolskaya.mp3", 11.327400},
    elektrosila = {"subway_announcers/sarmat_upo/rhino/metrostroi/elektrosila.mp3", 0.835200},
    next_elektrosila = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_elektrosila.mp3", 2.009700},
    teatralnaya_ploschad = {"subway_announcers/sarmat_upo/rhino/metrostroi/teatralnaya_ploschad.mp3", 1.122300},
    next_teatralnaya_ploschad = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_teatralnaya_ploschad.mp3", 2.192400},
    park_pobedy = {"subway_announcers/sarmat_upo/rhino/metrostroi/park_pobedy.mp3", 0.809100},
    next_park_pobedy = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_park_pobedy.mp3", 3.340800},
    next_park_pobedy1 = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_park_pobedy1.mp3", 1.853100},
    sineozernaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/sineozernaya.mp3", 0.887400},
    next_sineozernaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_sineozernaya.mp3", 1.957500},
    skip_lesnaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/skip_lesnaya.mp3", 4.202100},
    minskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/minskaya.mp3", 0.626400},
    next_minskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_minskaya.mp3", 1.644300},
    last_minskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/last_minskaya.mp3", 10.100700},
    tsarskiye_vorota = {"subway_announcers/sarmat_upo/rhino/metrostroi/tsarskiye_vorota.mp3", 1.044000},
    next_tsarskiye_vorota = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_tsarskiye_vorota.mp3", 1.983600},
    mejdustroyskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/mejdustroyskaya.mp3", 0.965700},
    next_mejdustroyskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_mejdustroyskaya.mp3", 3.445200},
    next_mejdustroyskaya1 = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_mejdustroyskaya1.mp3", 2.088000},
    last_mejdustroyskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/last_mejdustroyskaya.mp3", 11.353500},
    muzey_skulptur = {"subway_announcers/sarmat_upo/rhino/metrostroi/muzey_skulptur.mp3", 0.939600},
    next_muzey_skulptur = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_muzey_skulptur.mp3", 1.957500},
    avtostanciya_yujnaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/avtostanciya_yujnaya.mp3", 1.331100},
    next_avtostanciya_yujnaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_avtostanciya_yujnaya.mp3", 2.401200},
    last_avtostanciya_yujnaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/last_avtostanciya_yujnaya.mp3", 10.283400},
    akademicheskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/akademicheskaya.mp3", 0.965700},
    next_akademicheskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_akademicheskaya.mp3", 3.184200},
    next_akademicheskaya1 = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_akademicheskaya1.mp3", 1.800900},
    sokol = {"subway_announcers/sarmat_upo/rhino/metrostroi/sokol.mp3", 0.574200},
    next_sokol = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_sokol.mp3", 1.539900},
    ohotniy_ryad = {"subway_announcers/sarmat_upo/rhino/metrostroi/ohotniy_ryad.mp3", 0.861300},
    next_ohotniy_ryad = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_ohotniy_ryad.mp3", 3.419100},
    next_ohotniy_ryad1 = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_ohotniy_ryad1.mp3", 1.853100},
    kirovskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/kirovskaya.mp3", 0.704700},
    next_kirovskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_kirovskaya.mp3", 1.722600},
    profsoyuznaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/profsoyuznaya.mp3", 0.913500},
    next_profsoyuznaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_profsoyuznaya.mp3", 1.827000},
    last_profsoyuznaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/last_profsoyuznaya.mp3", 9.944100},
    leninskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/leninskaya.mp3", 0.835200},
    next_leninskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_leninskaya.mp3", 1.722600},
    last_leninskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/last_leninskaya.mp3", 9.761400},
    derjavinskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/derjavinskaya.mp3", 0.939600},
    next_derjavinskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/next_derjavinskaya.mp3", 1.800900},
    last_derjavinskaya = {"subway_announcers/sarmat_upo/rhino/metrostroi/last_derjavinskaya.mp3", 10.022400},
    spec_attention_handrails = {"subway_announcers/sarmat_upo/rhino/metrostroi/spec_attention_handrails.mp3", 3.967200},
    spec_attention_politeness = {"subway_announcers/sarmat_upo/rhino/metrostroi/spec_attention_politeness.mp3", 5.533200},
    spec_line1 = {"subway_announcers/sarmat_upo/rhino/metrostroi/spec_line1.mp3", 1.618200},
    spec_line2 = {"subway_announcers/sarmat_upo/rhino/metrostroi/spec_line2.mp3", 1.513800},
    spec_line3 = {"subway_announcers/sarmat_upo/rhino/metrostroi/spec_line3.mp3", 1.618200},
    odz1 = {"subway_announcers/sarmat_upo/rhino/metrostroi/odz1.mp3", 2.088000 + 0.3},
    odz2 = {"subway_announcers/sarmat_upo/rhino/metrostroi/odz2.mp3", 2.192400 + 0.3}
}, {
    {
        LED = {2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 4, 2, 2, 2},
        Name = "Индустриал.-Синеозёрн.",
        Loop = false,
        {
            108,
            "Автозаводская","Avtozavodskaya",
            arrlast = {nil, "last_avtozavodskaya"},
            dep = {"next_industrialnaya"},
            odz = "odz1"
        },
        {
            109,
            "Индустриальная","Industrialnaya",
            arr = {{"industrialnaya", 3, "next_moskovskaya","spec_attention_handrails"}, {"industrialnaya", 3, "next_avtozavodskaya","spec_attention_handrails"}},
            dep = {"next_moskovskaya1", "next_avtozavodskaya"},
            odz = "odz2"
        },
        {
            110,
            "Московская","Moskovskaya",
            arr = {{"moskovskaya", 3, "next_oktyabrskaya"}, {"moskovskaya", 3, "next_industrialnaya"}},
            dep = {"next_oktyabrskaya", "next_industrialnaya"},
            odz = "odz1",
            right_doors = true,
        },
        {
            111,
            "Октябрьская","Oktyabrskaya",
            arr = {{"oktyabrskaya", 3, "next_ploschad_myra","spec_attention_politeness"}, {"oktyabrskaya", 3, "next_moskovskaya","spec_attention_politeness"}},
            dep = {"next_ploschad_myra", "next_moskovskaya1"},
            odz = "odz1",
            arrlast = {"last_oktyabrskaya", "last_oktyabrskaya"}
        },
        {
            112,
            "Площадь мира","Ploschad myra",
            arr = {{"ploschad_myra", 3, "next_novoarmeyskaya"}, {"ploschad_myra", 3, "next_oktyabrskaya"}},
            dep = {"next_novoarmeyskaya", "next_oktyabrskaya"},
            odz = "odz2",
            arrlast = {"last_ploschad_myra", "last_ploschad_myra"}
        },
        {
            113,
            "Новоармейская","Novoarmeyskaya",
            arr = {{"novoarmeyskaya", 3, "next_vokzalnaya","spec_attention_handrails"}, {"novoarmeyskaya", 3, "next_ploschad_myra"}},
            dep = {"next_vokzalnaya", "next_ploschad_myra"},
            odz = "odz2"
        },
        {
            114,
            "Вокзальная","Vokzalnaya",
            arr = {{"vokzalnaya", 3, "next_komsomolskaya", "spec_line2"}, {"vokzalnaya", 3, "next_novoarmeyskaya","spec_attention_handrails"}},
            dep = {"next_komsomolskaya1", "next_novoarmeyskaya"},
            odz = "odz1",
            arrlast = {"last_vokzalnaya", "last_vokzalnaya"}
        },
        {
            115,
            "Комсомольская","Komsomolskaya",
            arr = {{"komsomolskaya", 3, "next_elektrosila"}, {"komsomolskaya", 3, "next_vokzalnaya"}},
            dep = {"next_elektrosila", "next_vokzalnaya"},
            odz = "odz1",
            arrlast = {"last_komsomolskaya", "last_komsomolskaya"},
            right_doors = true
        },
        {
            116,
            "Электросила","Elektrosila",
            arr = {{"elektrosila", 3, "next_teatralnaya_ploschad","spec_attention_handrails"}, {"elektrosila", 3, "next_komsomolskaya", "spec_line2"}},
            dep = {"next_teatralnaya_ploschad", "next_komsomolskaya1"},
            odz = "odz2"
        },
        {
            117,
            "Театр. площадь","Teatraln. ploschad",
            arr = {{"teatralnaya_ploschad", 3, "next_park_pobedy","spec_attention_politeness"}, {"teatralnaya_ploschad", 3, "next_elektrosila","spec_attention_politeness"}},
            dep = {"next_park_pobedy1", "next_elektrosila"},
            odz = "odz1"
        },
        {
            118,
            "Парк победы","Park pobedy",
            arr = {{"park_pobedy", 3, "next_sineozernaya","spec_attention_handrails"}, {"park_pobedy", 3, "next_teatralnaya_ploschad"}},
            dep = {"next_sineozernaya", "next_teatralnaya_ploschad"},
            odz = "odz1",
            right_doors = true,
        },
        {
            119,
            "Синеозёрная","Sineozernaya",
            arr = {{"sineozernaya", 3, "next_minskaya", "skip_lesnaya"}, {"sineozernaya", 3, "next_park_pobedy","spec_attention_handrails"}},
            dep = {"next_minskaya", "next_park_pobedy1"},
            odz = "odz2"
        },
        {
            121,
            "Минская","Minskaya",
            arr = {{"minskaya", 3, "next_tsarskiye_vorota", "spec_line3"}, {"minskaya", 3, "next_sineozernaya", "skip_lesnaya"}},
            dep = {"next_tsarskiye_vorota", "next_sineozernaya"},
            odz = "odz1",
            arrlast = {"last_minskaya", "last_minskaya"}
        },
        {
            122,
            "Царские ворота","Tsarskiye vorota",
            arr = {{"tsarskiye_vorota", 3, "next_mejdustroyskaya"}, {"tsarskiye_vorota", 3, "next_minskaya","spec_attention_politeness"}},
            dep = {"next_mejdustroyskaya1", "next_minskaya"},
            odz = "odz2"
        },
        {
            123,
            "Междустройская","Mejdustroyskaya",
            arrlast = {"last_mejdustroyskaya"},
            dep = {nil, "next_tsarskiye_vorota"},
            odz = "odz2",
            right_doors = true,
        }
    },
    {
        LED = {2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 4, 2, 2, 1, 1},
        Name = "Индустриально-Авт.Юж.",
        Loop = false,
        {
            108,
            "Автозаводская","Avtozavodskaya",
            arrlast = {nil, "last_avtozavodskaya"},
            dep = {"next_industrialnaya"},
            odz = "odz1"
        },
        {
            109,
            "Индустриальная","Industrialnaya",
            arr = {{"industrialnaya", 3, "next_moskovskaya","spec_attention_handrails"}, {"industrialnaya", 3, "next_avtozavodskaya","spec_attention_handrails"}},
            dep = {"next_moskovskaya1", "next_avtozavodskaya"},
            odz = "odz2"
        },
        {
            110,
            "Московская","Moskovskaya",
            arr = {{"moskovskaya", 3, "next_oktyabrskaya"}, {"moskovskaya", 3, "next_industrialnaya"}},
            dep = {"next_oktyabrskaya", "next_industrialnaya"},
            odz = "odz1",
            right_doors = true,
        },
        {
            111,
            "Октябрьская","Oktyabrskaya",
            arr = {{"oktyabrskaya", 3, "next_ploschad_myra","spec_attention_politeness"}, {"oktyabrskaya", 3, "next_moskovskaya","spec_attention_politeness"}},
            dep = {"next_ploschad_myra", "next_moskovskaya1"},
            odz = "odz1",
            arrlast = {"last_oktyabrskaya", "last_oktyabrskaya"}
        },
        {
            112,
            "Площадь мира","Ploschad myra",
            arr = {{"ploschad_myra", 3, "next_novoarmeyskaya"}, {"ploschad_myra", 3, "next_oktyabrskaya"}},
            dep = {"next_novoarmeyskaya", "next_oktyabrskaya"},
            odz = "odz2",
            arrlast = {"last_ploschad_myra", "last_ploschad_myra"}
        },
        {
            113,
            "Новоармейская","Novoarmeyskaya",
            arr = {{"novoarmeyskaya", 3, "next_vokzalnaya","spec_attention_handrails"}, {"novoarmeyskaya", 3, "next_ploschad_myra"}},
            dep = {"next_vokzalnaya", "next_ploschad_myra"},
            odz = "odz2"
        },
        {
            114,
            "Вокзальная","Vokzalnaya",
            arr = {{"vokzalnaya", 3, "next_komsomolskaya", "spec_line2"}, {"vokzalnaya", 3, "next_novoarmeyskaya","spec_attention_handrails"}},
            dep = {"next_komsomolskaya1", "next_novoarmeyskaya"},
            odz = "odz1",
            arrlast = {"last_vokzalnaya", "last_vokzalnaya"}
        },
        {
            115,
            "Комсомольская","Komsomolskaya",
            arr = {{"komsomolskaya", 3, "next_elektrosila"}, {"komsomolskaya", 3, "next_vokzalnaya"}},
            dep = {"next_elektrosila", "next_vokzalnaya"},
            odz = "odz1",
            arrlast = {"last_komsomolskaya", "last_komsomolskaya"},
            right_doors = true
        },
        {
            116,
            "Электросила","Elektrosila",
            arr = {{"elektrosila", 3, "next_teatralnaya_ploschad","spec_attention_handrails"}, {"elektrosila", 3, "next_komsomolskaya", "spec_line2"}},
            dep = {"next_teatralnaya_ploschad", "next_komsomolskaya1"},
            odz = "odz2"
        },
        {
            117,
            "Театр. площадь","Teatraln. ploschad",
            arr = {{"teatralnaya_ploschad", 3, "next_park_pobedy","spec_attention_politeness"}, {"teatralnaya_ploschad", 3, "next_elektrosila","spec_attention_politeness"}},
            dep = {"next_park_pobedy1", "next_elektrosila"},
            odz = "odz1"
        },
        {
            118,
            "Парк победы","Park pobedy",
            arr = {{"park_pobedy", 3, "next_sineozernaya","spec_attention_handrails"}, {"park_pobedy", 3, "next_teatralnaya_ploschad"}},
            dep = {"next_sineozernaya", "next_teatralnaya_ploschad"},
            odz = "odz1",
            right_doors = true,
        },
        {
            119,
            "Синеозёрная","Sineozernaya",
            arr = {{"sineozernaya", 3, "next_minskaya", "skip_lesnaya"}, {"sineozernaya", 3, "next_park_pobedy","spec_attention_handrails"}},
            dep = {"next_minskaya", "next_park_pobedy1"},
            odz = "odz2"
        },
        {
            121,
            "Минская","Minskaya",
            arr = {{"minskaya", 3, "next_tsarskiye_vorota", "spec_line3"}, {"minskaya", 3, "next_sineozernaya", "skip_lesnaya"}},
            dep = {"next_tsarskiye_vorota", "next_sineozernaya"},
            odz = "odz1",
            arrlast = {"last_minskaya", "last_minskaya"}
        },
        {
            122,
            "Царские ворота","Tsarskiye vorota",
            arr = {{"tsarskiye_vorota", 3, "next_muzey_skulptur"}, {"tsarskiye_vorota", 3, "next_minskaya"}},
            dep = {"next_mejdustroyskaya1", "next_minskaya"},
            odz = "odz2"
        },
        {
            321,
            "Музей скульптур","Muzey skulptur",
            arr = {{"muzey_skulptur", 3, "next_avtostanciya_yujnaya"}, {"muzey_skulptur", 3, "next_tsarskiye_vorota","spec_attention_politeness"}},
            dep = {"next_avtostanciya_yujnaya", "next_tsarskiye_vorota"},
            odz = "odz1"
        },
        {
            311,
            "Автостанция южная","Avtostanciya yujnaya",
            arrlast = {"last_avtostanciya_yujnaya"},
            dep = {nil, "next_muzey_skulptur"},
            odz = "odz2"
        },
    },
})
Metrostroi.SetUPOAnnouncer({
    name = "UPO RHINO",
    tone1 = {"subway_announcers/upo/rhino/metrostroi/line1/tone.mp3", 1.2},
    tone2 = {"subway_announcers/upo/rhino/metrostroi/line2/tone.mp3", 1.2},
    click1 = {"subway_announcers/upo/click1.mp3", 0.3},
    click2 = {"subway_announcers/upo/click2.mp3", 0.1},
    avtozavodskaya = {"subway_announcers/upo/rhino/metrostroi/line1/avtozavodskaya.mp3", 1.070100},
    next_avtozavodskaya = {"subway_announcers/upo/rhino/metrostroi/line1/next_avtozavodskaya.mp3", 1.957500},
    last_avtozavodskaya = {"subway_announcers/upo/rhino/metrostroi/line1/last_avtozavodskaya.mp3", 10.100700},
    industrialnaya = {"subway_announcers/upo/rhino/metrostroi/line1/industrialnaya.mp3", 1.017900},
    next_industrialnaya = {"subway_announcers/upo/rhino/metrostroi/line1/next_industrialnaya.mp3", 1.983600},
    moskovskaya = {"subway_announcers/upo/rhino/metrostroi/line1/moskovskaya.mp3", 0.730800},
    next_moskovskaya = {"subway_announcers/upo/rhino/metrostroi/line1/next_moskovskaya.mp3", 3.158100},
    next_moskovskaya1 = {"subway_announcers/upo/rhino/metrostroi/line1/next_moskovskaya1.mp3", 1.800900},
    oktyabrskaya = {"subway_announcers/upo/rhino/metrostroi/line1/oktyabrskaya.mp3", 0.887400},
    next_oktyabrskaya = {"subway_announcers/upo/rhino/metrostroi/line1/next_oktyabrskaya.mp3", 1.853100},
    last_oktyabrskaya = {"subway_announcers/upo/rhino/metrostroi/line1/last_oktyabrskaya.mp3", 10.074600},
    ploschad_myra = {"subway_announcers/upo/rhino/metrostroi/line1/ploschad_myra.mp3", 0.835200},
    next_ploschad_myra = {"subway_announcers/upo/rhino/metrostroi/line1/next_ploschad_myra.mp3", 1.879200},
    last_ploschad_myra = {"subway_announcers/upo/rhino/metrostroi/line1/last_ploschad_myra.mp3", 10.283400},
    novoarmeyskaya = {"subway_announcers/upo/rhino/metrostroi/line1/novoarmeyskaya.mp3", 0.809100},
    next_novoarmeyskaya = {"subway_announcers/upo/rhino/metrostroi/line1/next_novoarmeyskaya.mp3", 1.879200},
    vokzalnaya = {"subway_announcers/upo/rhino/metrostroi/line1/vokzalnaya.mp3", 0.783000},
    next_vokzalnaya = {"subway_announcers/upo/rhino/metrostroi/line1/next_vokzalnaya.mp3", 1.748700},
    last_vokzalnaya = {"subway_announcers/upo/rhino/metrostroi/line1/last_vokzalnaya.mp3", 9.865800},
    komsomolskaya = {"subway_announcers/upo/rhino/metrostroi/line1/komsomolskaya.mp3", 0.887400},
    next_komsomolskaya = {"subway_announcers/upo/rhino/metrostroi/line1/next_komsomolskaya.mp3", 3.340800},
    next_komsomolskaya1 = {"subway_announcers/upo/rhino/metrostroi/line1/next_komsomolskaya1.mp3", 1.879200},
    last_komsomolskaya = {"subway_announcers/upo/rhino/metrostroi/line1/last_komsomolskaya.mp3", 11.327400},
    elektrosila = {"subway_announcers/upo/rhino/metrostroi/line1/elektrosila.mp3", 0.835200},
    next_elektrosila = {"subway_announcers/upo/rhino/metrostroi/line1/next_elektrosila.mp3", 2.009700},
    teatralnaya_ploschad = {"subway_announcers/upo/rhino/metrostroi/line1/teatralnaya_ploschad.mp3", 1.122300},
    next_teatralnaya_ploschad = {"subway_announcers/upo/rhino/metrostroi/line1/next_teatralnaya_ploschad.mp3", 2.192400},
    park_pobedy = {"subway_announcers/upo/rhino/metrostroi/line1/park_pobedy.mp3", 0.809100},
    next_park_pobedy = {"subway_announcers/upo/rhino/metrostroi/line1/next_park_pobedy.mp3", 3.340800},
    next_park_pobedy1 = {"subway_announcers/upo/rhino/metrostroi/line1/next_park_pobedy1.mp3", 1.853100},
    sineozernaya = {"subway_announcers/upo/rhino/metrostroi/line1/sineozernaya.mp3", 0.887400},
    next_sineozernaya = {"subway_announcers/upo/rhino/metrostroi/line1/next_sineozernaya.mp3", 1.957500},
    skip_lesnaya = {"subway_announcers/upo/rhino/metrostroi/line1/skip_lesnaya.mp3", 4.202100},
    minskaya = {"subway_announcers/upo/rhino/metrostroi/line1/minskaya.mp3", 0.626400},
    next_minskaya = {"subway_announcers/upo/rhino/metrostroi/line1/next_minskaya.mp3", 1.644300},
    last_minskaya = {"subway_announcers/upo/rhino/metrostroi/line1/last_minskaya.mp3", 10.100700},
    tsarskiye_vorota = {"subway_announcers/upo/rhino/metrostroi/line1/tsarskiye_vorota.mp3", 1.044000},
    next_tsarskiye_vorota = {"subway_announcers/upo/rhino/metrostroi/line1/next_tsarskiye_vorota.mp3", 1.983600},
    mejdustroyskaya = {"subway_announcers/upo/rhino/metrostroi/line1/mejdustroyskaya.mp3", 0.965700},
    next_mejdustroyskaya = {"subway_announcers/upo/rhino/metrostroi/line1/next_mejdustroyskaya.mp3", 3.445200},
    next_mejdustroyskaya1 = {"subway_announcers/upo/rhino/metrostroi/line1/next_mejdustroyskaya1.mp3", 2.088000},
    last_mejdustroyskaya = {"subway_announcers/upo/rhino/metrostroi/line1/last_mejdustroyskaya.mp3", 11.353500},
    muzey_skulptur = {"subway_announcers/upo/rhino/metrostroi/line1/muzey_skulptur.mp3", 0.939600},
    next_muzey_skulptur = {"subway_announcers/upo/rhino/metrostroi/line1/next_muzey_skulptur.mp3", 1.957500},
    avtostanciya_yujnaya = {"subway_announcers/upo/rhino/metrostroi/line1/avtostanciya_yujnaya.mp3", 1.331100},
    next_avtostanciya_yujnaya = {"subway_announcers/upo/rhino/metrostroi/line1/next_avtostanciya_yujnaya.mp3", 2.401200},
    last_avtostanciya_yujnaya = {"subway_announcers/upo/rhino/metrostroi/line1/last_avtostanciya_yujnaya.mp3", 10.283400},
    spec_attention_handrails = {"subway_announcers/upo/rhino/metrostroi/line2/spec_attention_handrails.mp3", 3.967200},
    spec_attention_politeness = {"subway_announcers/upo/rhino/metrostroi/line2/spec_attention_politeness.mp3", 5.533200},
    spec_line1 = {"subway_announcers/upo/rhino/metrostroi/line1/spec_line1.mp3", 1.618200},
    spec_line2 = {"subway_announcers/upo/rhino/metrostroi/line1/spec_line2.mp3", 1.513800},
    spec_line3 = {"subway_announcers/upo/rhino/metrostroi/line1/spec_line3.mp3", 1.618200},
    odz = {"subway_announcers/upo/rhino/metrostroi/line1/odz.mp3",2.02},

    akademicheskaya = {"subway_announcers/upo/rhino/metrostroi/line2/akademicheskaya.mp3", 0.965700},
    next_akademicheskaya = {"subway_announcers/upo/rhino/metrostroi/line2/next_akademicheskaya.mp3", 3.184200},
    next_akademicheskaya1 = {"subway_announcers/upo/rhino/metrostroi/line2/next_akademicheskaya1.mp3", 1.800900},
    sokol = {"subway_announcers/upo/rhino/metrostroi/line2/sokol.mp3", 0.574200},
    next_sokol = {"subway_announcers/upo/rhino/metrostroi/line2/next_sokol.mp3", 1.539900},
    ohotniy_ryad = {"subway_announcers/upo/rhino/metrostroi/line2/ohotniy_ryad.mp3", 0.861300},
    next_ohotniy_ryad = {"subway_announcers/upo/rhino/metrostroi/line2/next_ohotniy_ryad.mp3", 3.419100},
    next_ohotniy_ryad1 = {"subway_announcers/upo/rhino/metrostroi/line2/next_ohotniy_ryad1.mp3", 1.853100},
    kirovskaya = {"subway_announcers/upo/rhino/metrostroi/line2/kirovskaya.mp3", 0.704700},
    next_kirovskaya = {"subway_announcers/upo/rhino/metrostroi/line2/next_kirovskaya.mp3", 1.722600},
    profsoyuznaya = {"subway_announcers/upo/rhino/metrostroi/line2/profsoyuznaya.mp3", 0.913500},
    next_profsoyuznaya = {"subway_announcers/upo/rhino/metrostroi/line2/next_profsoyuznaya.mp3", 1.827000},
    last_profsoyuznaya = {"subway_announcers/upo/rhino/metrostroi/line2/last_profsoyuznaya.mp3", 9.944100},
    leninskaya = {"subway_announcers/upo/rhino/metrostroi/line2/leninskaya.mp3", 0.835200},
    next_leninskaya = {"subway_announcers/upo/rhino/metrostroi/line2/next_leninskaya.mp3", 1.722600},
    last_leninskaya = {"subway_announcers/upo/rhino/metrostroi/line2/last_leninskaya.mp3", 9.761400},
    derjavinskaya = {"subway_announcers/upo/rhino/metrostroi/line2/derjavinskaya.mp3", 0.939600},
    next_derjavinskaya = {"subway_announcers/upo/rhino/metrostroi/line2/next_derjavinskaya.mp3", 1.800900},
    last_derjavinskaya = {"subway_announcers/upo/rhino/metrostroi/line2/last_derjavinskaya.mp3", 10.022400},
    spec_attention_handrails_2 = {"subway_announcers/upo/rhino/metrostroi/line2/spec_attention_handrails.mp3", 3.967200},
    spec_attention_politeness_2 = {"subway_announcers/upo/rhino/metrostroi/line2/spec_attention_politeness.mp3", 5.533200},
    spec_line1_2 = {"subway_announcers/upo/rhino/metrostroi/line2/spec_line1.mp3", 1.618200},
    spec_line2_2 = {"subway_announcers/upo/rhino/metrostroi/line2/spec_line2.mp3", 1.513800},
    spec_line3_2 = {"subway_announcers/upo/rhino/metrostroi/line2/spec_line3.mp3", 1.618200},
    odz1 = {"subway_announcers/upo/rhino/metrostroi/line2/odz1.mp3", 2.088000 + 0.3},
    odz2 = {"subway_announcers/upo/rhino/metrostroi/line2/odz2.mp3", 2.192400 + 0.3}
},{
    {
        108,
        "Автозаводская",
        arrlast = {nil, "last_avtozavodskaya"},
        dep = {"odz"},
        tone = "tone1", dist = 70,
        noises = {1,2,3},noiserandom = 0.2,
    },
    {
        109,
        "Индустриальная",
        arr = {{"industrialnaya", 0.5, "next_moskovskaya","spec_attention_handrails"}, {"industrialnaya", 0.5, "next_avtozavodskaya","spec_attention_handrails"}},
        dep = {"odz", "odz"},
        tone = "tone1", dist = 75,
        noises = {1,2,3},noiserandom = 0.1,
    },
    {
        110,
        "Московская",
        arr = {{"moskovskaya", 0.5, "next_oktyabrskaya"}, {"moskovskaya", 0.5, "next_industrialnaya"}},
        dep = {"odz", "odz"},
        tone = "tone1", dist = 85,
        noises = {2,3},noiserandom = 0.2,
    },
    {
        111,
        "Октябрьская",
        arr = {{"oktyabrskaya", 0.5, "next_ploschad_myra","spec_attention_politeness"}, {"oktyabrskaya", 0.5, "next_moskovskaya","spec_attention_politeness"}},
        dep = {"odz", "odz"},
        tone = "tone1", dist = 60,
        noises = {1,2,3},noiserandom = 0.1,
    },
    {
        112,
        "Площадь мира",
        arr = {{"ploschad_myra", 0.5, "next_novoarmeyskaya"}, {"ploschad_myra", 0.5, "next_oktyabrskaya"}},
        dep = {"odz", "odz"},
        tone = "tone1", dist = 80,
        noises = {1,2},noiserandom = 0.3,
    },
    {
        113,
        "Новоармейская",
        arr = {{"novoarmeyskaya", 0.5, "next_vokzalnaya","spec_attention_handrails"}, {"novoarmeyskaya", 0.5, "next_ploschad_myra"}},
        dep = {"odz", "odz"},
        tone = "tone1", dist = 60,
        noises = {1,2,3},noiserandom = 0.2,
    },
    {
        114,
        "Вокзальная",
        arr = {{"vokzalnaya", 0.5, "next_komsomolskaya", "spec_line2"}, {"vokzalnaya", 0.5, "next_novoarmeyskaya","spec_attention_handrails"}},
        dep = {"odz", "odz"},
        tone = "tone1", dist = 55,
        noises = {1,3},noiserandom = 0.4,
    },
    {
        115,
        "Комсомольская",
        arr = {{"komsomolskaya", 0.5, "next_elektrosila"}, {"komsomolskaya", 0.5, "next_vokzalnaya"}},
        dep = {"odz", "odz"},
        tone = "tone1", dist = 40,
        noises = {1,2,3},noiserandom = 0.4,
    },
    {
        116,
        "Электросила",
        arr = {{"elektrosila", 0.5, "next_teatralnaya_ploschad","spec_attention_handrails"}, {"elektrosila", 0.5, "next_komsomolskaya", "spec_line2"}},
        dep = {"odz", "odz"},
        tone = "tone1", dist = 65,
        noises = {1,2,3},noiserandom = 0.2,
    },
    {
        117,
        "Театр. площадь",
        arr = {{"teatralnaya_ploschad", 0.5, "next_park_pobedy","spec_attention_politeness"}, {"teatralnaya_ploschad", 0.5, "next_elektrosila","spec_attention_politeness"}},
        dep = {"odz", "odz"},
        tone = "tone1", dist = 80,
        noises = {3},noiserandom = 0.1,
    },
    {
        118,
        "Парк победы",
        arr = {{"park_pobedy", 0.5, "next_sineozernaya","spec_attention_handrails"}, {"park_pobedy", 0.5, "next_teatralnaya_ploschad"}},
        dep = {"odz", "odz"},
        tone = "tone1", dist = 60,
        noises = {2},noiserandom = 0.3,
    },
    {
        119,
        "Синеозёрная",
        arr = {{"sineozernaya", 0.5, "next_minskaya", "skip_lesnaya"}, {"sineozernaya", 0.5, "next_park_pobedy","spec_attention_handrails"}},
        dep = {"odz", "odz"},
        tone = "tone1", dist = 75,
        noises = {1,3},noiserandom = 0.2,
    },
    {
        121,
        "Минская",
        arr = {{"minskaya", 0.5, "next_tsarskiye_vorota"}, {"minskaya", 0.5, "next_sineozernaya", "skip_lesnaya"}},
        dep = {"odz", "odz"},
        tone = "tone1", dist = 75,
        noises = {1},noiserandom = 0.4,
    },
    {
        122,
        "Царские ворота",
        arr = {{"tsarskiye_vorota"}, {"tsarskiye_vorota", 0.5, "next_minskaya","spec_attention_politeness"}},
        dep = {"odz", "odz"},
        tone = "tone1", dist = 75,
        noises = {1,2,3},noiserandom = 0.5,
    },
    {
        123,
        "Междустройская",
        arrlast = {"last_mejdustroyskaya"},
        dep = {nil, "odz"},
        tone = "tone1", dist = 40,
    },


    {
        321,
        "Музей скульптур",
        arr = {{"muzey_skulptur", 0.5, "next_avtostanciya_yujnaya"}, {"muzey_skulptur", 0.5, "next_tsarskiye_vorota"}},
        dep = {"odz", "odz"},
        tone = "tone1", dist = 65,
        noises = {1,3},noiserandom = 0.1,
    },
    {
        322,
        "Автостан. юж.",
        arrlast = {"last_avtostanciya_yujnaya"},
        dep = {nil, "odz"},
        tone = "tone1", dist = 65,
        noises = {1,3},noiserandom = 0.1,
    },


    {
        210,
        "Академическая",
        arrlast = {nil, "last_akademicheskaya"},
        dep = {{"odz1","next_sokol"}},
        tone = "tone2", dist = 40,
        noises = {2,3},noiserandom = 0.1,
    },
    {
        211,
        "Сокол",
        arr = {{"sokol", 3, "next_ohotniy_ryad","spec_attention_handrails_2"}, {"sokol", 3, "next_akademicheskaya"}},
        dep = {{"odz2","next_ohotniy_ryad1"},{"odz1","next_akademicheskaya1"}},
        tone = "tone2", dist = 40,
        noises = {1,2},noiserandom = 0.20,
    },
    {
        212,
        "Охотный ряд",
        arr = {{"ohotniy_ryad", 3, "next_kirovskaya"}, {"ohotniy_ryad", 3, "next_sokol","spec_attention_politeness_2"}},
        dep = {{"odz1","next_kirovskaya"},{"odz2","next_sokol"}},
        tone = "tone2", dist = 40,
        noises = {1,2,3},noiserandom = 0.17,
    },
    {
        213,
        "Кировская",
        arr = {{"kirovskaya", 3, "next_profsoyuznaya","spec_attention_politeness_2"}, {"kirovskaya", 3, "next_ohotniy_ryad","spec_attention_handrails_2"}},
        dep = {{"odz2","next_profsoyuznaya"},{"odz2","next_ohotniy_ryad1"}},
        tone = "tone2", dist = 40,
        noises = {2,3},noiserandom = 0.03,
    },
    {
        214,
        "Профсоюзная",
        arr = {{"profsoyuznaya", 3, "next_leninskaya", "spec_line1_2"}, {"profsoyuznaya", 3, "next_kirovskaya"}},
        dep = {{"odz1","next_leninskaya"},{"odz1","next_kirovskaya"}},
        tone = "tone2", dist = 40,
    },
    {
        215,
        "Ленинская",
        arr = {{"leninskaya", 3, "next_derjavinskaya","spec_attention_handrails_2"}, {"leninskaya", 3, "next_profsoyuznaya","spec_attention_politeness_2"}},
        dep = {{"odz1","next_derjavinskaya"},{"odz2","next_profsoyuznaya"}},
        tone = "tone2", dist = 40,
        noises = {1,3},noiserandom = 0.05,
    },
    {
        216,
        "Державинская",
        arrlast = {"last_derjavinskaya"},
        dep = {nil, {"odz2","next_leninskaya"}},
        tone = "tone2", dist = 40,
        noises = {1,2},noiserandom = 0.05,
    }
})
Metrostroi.StationSound = {
    {"subway_stations/announces/b50/metrostroi_1.mp3",45.531375},
    {"subway_stations/announces/b50/metrostroi_2.mp3",41.848125},
    {"subway_stations/announces/b50/metrostroi_3.mp3",27.036688},
    {"subway_stations/announces/b50/metrostroi_4.mp3",53.524875},
    {"subway_stations/announces/b50/metrostroi_5.mp3",35.709375},
    {"subway_stations/announces/b50/metrostroi_6.mp3",47.777938},
}
Metrostroi.StationConfigurations = {
    [108] =
    {
        names = {"автозаводская","Avtozavodskaya"},
        positions = {
            {Vector(4820.791992, 5585.694336, -1603.769043),Angle(0,0,0)},
        }
    },
    [109] =
    {
        names = {"индустриальная","Industrialnaya"},
        positions = {
            {Vector(-15276.645508, 6032.157715, 640),Angle(0,0,0)},
        }
    },
    [110] =
    {
        names = {"московская","Moskovskaya"},
        positions = {
            {Vector(7205.387695, 7826.301758, 235.031235),Angle(0,0,0)},
        }
    },
    [111] =
    {
        names = {"октябрьская","Oktyabrskaya"},
        positions = {
            {Vector(14950.475586, 929.608032, -345.968750),Angle(0,0,0)},
        }
    },
    [112] =
    {
        names = {"площадь мира","Ploschad myra"},
        positions = {
            {Vector(8964.811523, -1026.779419, -2196.968750),Angle(0,0,0)},
        }
    },
    [113] =
    {
        names = {"новоармейская","Novoarmeyskaya"},
        positions = {
            {Vector(519.362549, -1849.162720, -2708.968750),Angle(0,0,0)},
        }
    },
    [114] =
    {
        names = {"вокзальная","Vokzalnaya"},
        positions = {
            {Vector(-10384.938477, -769.048767, -2708.968750),Angle(0,0,0)},
        }
    },
    [115] =
    {
        names = {"комсомольская","Komsomolskaya"},
        positions = {
            {Vector(-10550.576172, -2059.577148, -3732.968750),Angle(0,0,0)},
        }
    },
    [116] =
    {
        names = {"электросила","Elektrosila"},
        positions = {
            {Vector(7315.029785, -1850.208008, -4244.968750),Angle(0,0,0)},
        }
    },
    [117] =
    {
        names = {"театральная площадь","Teatralnaya ploschad"},
        positions = {
            {Vector(-372.223755, -15192.013672, -4757.968750),Angle(0,0,0)},
        }
    },
    [118] =
    {
        names = {"парк победы","Park pobedy"},
        positions = {
            {Vector(-898.368103, -2030.919312, -7456.968750),Angle(0,0,0)},
        }
    },
    [119] =
    {
        names = {"синеозёрная","Sineozernaya"},
        positions = {
            {Vector(-3195.315430, 9382.029297, -8467.968750),Angle(0,0,0)},
        }
    },
    [121] =
    {
        names = {"минская","Minskaya"},
        positions = {
            {Vector(-7236.259277, 632.344849, -10355),Angle(0,0,0)},
        }
    },
    [122] =
    {
        names = {"царские ворота","Tsarskiye vorota"},
        positions = {
            {Vector(-1507.229248, 14172.663086, -14281.968750),Angle(0,0,0)},
        }
    },
    [123] =
    {
        names = {"междустройская","Mejdustroyskaya"},
        positions = {
            {Vector(15273.905273, 1011.733582, -16056.282227),Angle(0,0,0)},
        }
    },
    [321] =
    {
        names = {"музей скульптур","muzey skulptur","museum"},
        positions = {
            {Vector(1514.049316, -10277.442383, -14801.968750),Angle(0,0,0)},
        }
    },
    [322] =
    {
        names = {"автостанция южная","Autostanciya yujnaya","autostation"},
        positions = {
            {Vector(7203.874512, -3788.718506, -13259.068359),Angle(0,0,0)},
        }
    },
    [210] =
    {
        names = {"академическая","Akademicheskaya"},
        positions = {
            {Vector(0,0,0),Angle(0,0,0)},
        }
    },
    [211] =
    {
        names = {"сокол","Sokol"},
        positions = {
            {Vector(671,3219,-12741),Angle(0,0,0)},
        }
    },
    [212] =
    {
        names = {"охотный ряд","Ohotniy ryad"},
        positions = {
            {Vector(15487,4007,-12741),Angle(0,0,0)},
        }
    },
    [213] =
    {
        names = {"кировская","Kirovskaya"},
        positions = {
            {Vector(-2588,5431,-11109),Angle(0,0,0)},
        }
    },
    [214] =
    {
        names = {"профсоюзная","Profsoyuznaya"},
        positions = {
            {Vector(-3219,6296 -8975),Angle(0,0,0)},
        }
    },
    [215] =
    {
        names = {"ленинская","Leninskaya"},
        positions = {
            {Vector(-9390,2248,-5318),Angle(0,0,0)},
        }
    },
    [216] =
    {
        names = {"державинская","Derjavinskaya"},
        positions = {
            {Vector(0,0,0),Angle(0,0,0)},
        }
    },

    depot = {
        names = {"депо"},
        positions = {
            {Vector(-3049.407959, -5360.429688, -11565.102539),Angle(0,0,0)},
        }
    }
}
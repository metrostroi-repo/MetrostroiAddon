local Map = game.GetMap() or ""

if Map:find("gm_metro_crossline_r") then
    Metrostroi.PlatformMap = "gm_metro_crossline"
    Metrostroi.CurrentMap = "gm_metro_crossline"
else
    return
end
Metrostroi.Skins["717_schemes"]["p"] = {
    adv = "metrostroi_skins/81-717_schemes/int_orange_spb_adv",
    clean = "metrostroi_skins/81-717_schemes/int_orange_spb_clean",
}
Metrostroi.Skins["717_schemes"]["m"] = {
    adv = "metrostroi_skins/81-717_schemes/int_orange_msk_adv",
    clean = "metrostroi_skins/81-717_schemes/int_orange_msk_noadv",
}
Metrostroi.AddPassSchemeTex("720","Crossline",{
    "metrostroi_skins/81-720_schemes/crossline",
    "metrostroi_skins/81-720_schemes/crossliner",
})
Metrostroi.AddPassSchemeTex("722","Crossline",{
    "metrostroi_skins/81-722_schemes/crossline",
    "metrostroi_skins/81-722_schemes/crossliner",
})
Metrostroi.AddLastStationTex("710",110,"metrostroi_skins/81-710_names/route_me")
Metrostroi.AddLastStationTex("710",115,"metrostroi_skins/81-710_names/route_oktober")
Metrostroi.AddLastStationTex("710",116,"metrostroi_skins/81-710_names/route_rechnaya")
Metrostroi.AddLastStationTex("720",110,"metrostroi_skins/81-720_names/label_mezhdunarodnaya")
Metrostroi.AddLastStationTex("720",115,"metrostroi_skins/81-720_names/label_okt")
Metrostroi.AddLastStationTex("720",116,"metrostroi_skins/81-720_names/label_rech")

Metrostroi.TickerAdverts = {
    "МЕТРОПОЛИТЕН ИМЕНИ ГАРРИ НЬЮМАНА ПРИГЛАШАЕТ НА РАБОТУ РЕАЛЬНЕ МАФЕНЕСТОВ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,ТЕЛЕФОН ДЛЯ СПРАВОК 8 (800) 555-35-35",
    "УВАЖАЕМЫЕ ПАССАЖИРЫ, ПРИ ВЫХОДЕ ИЗ ПОЕЗДА, НЕ ЗАБЫВАЙТЕ СВОИ ВЕЩИ",
    "ЭЛЕКТРОДЕПО КРОССЛАЙНА ПРИГЛАШАЕТ НА РАБОТУ МОДЕЛЕРОВ ДЛЯ ПОСТРОЙКИ ЭЛЕКТРОДЕПО",
    "СТАНЦИЯ РЕЧНАЯ ПРИГЛАШАЕТ НА РАБОТУ МАШИНИСТОВ И ПОМОЩНИКОВ МАШИНИСТА ЭСКАЛАТОРА. ОПЛАТА 5 КУСОЧКОВ НОМЕРНОГО.",
    "ЭЛЕКТРОДЕПО КРОССЛАЙА ПРИГЛАШААААААААААААААААААААААААААААААААААААААААААААААВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВВССССССССССССССССССССССССССССССССССССССССССССССССС",
    ".",
    "ЪЪъъЪЪЪъЪЪЪЪъъъЪЪЪЪЪъъЪЪъъЪЪЪъъЪЪъЪЪъЪъъЪЪЪЪъъъЪЪъъЪЪЪЪЪъъЪЪъъЪъЪЪЪЪЪъЪЪЪЪъъЪЪЪЪЪъъъЪЪъ",
}

Metrostroi.AddANSPAnnouncer("ASNP Boiko + Pyaseckaya",{
    asnp  = true,
    click1 = {"subway_announcers/asnp/boiko_new/click1.mp3",0.367833},
    click2 = {"subway_announcers/asnp/boiko_new/click2.mp3",0.209688},
    click3 = {"subway_announcers/asnp/boiko_new/click3.mp3",0.203479},


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

    kirovskaya_m = {"subway_announcers/asnp/boiko_new/crossline/1/kirovskaya.mp3",0.883667},
    mejdunarodnaya_m = {"subway_announcers/asnp/boiko_new/crossline/1/mejdunarodnaya.mp3",1.206667},
    molodejnaya_m = {"subway_announcers/asnp/boiko_new/crossline/1/molodejnaya.mp3",1.112917},
    nahimovskaya_m = {"subway_announcers/asnp/boiko_new/crossline/1/nahimovskaya.mp3",1.097292},
    oktyabrskaya_arr_m = {"subway_announcers/asnp/boiko_new/crossline/1/oktyabrskaya_arr.mp3",5.656979},
    oktyabrskaya_next_m = {"subway_announcers/asnp/boiko_new/crossline/1/oktyabrskaya_next.mp3",1.124083},
    olimpiyskaya_m = {"subway_announcers/asnp/boiko_new/crossline/1/olimpiyskaya.mp3",1.081750},
    park_kultury_m = {"subway_announcers/asnp/boiko_new/crossline/1/park_kultury.mp3",1.142833},
    politehnicheskaya_arr_m = {"subway_announcers/asnp/boiko_new/crossline/1/politehnicheskaya_next.mp3",2.674708},
    --politehnicheskaya_arr_m = {"subway_announcers/asnp/boiko_new/crossline/1/politehnicheskaya_arr.mp3",4.657938},
    politehnicheskaya_next_m = {"subway_announcers/asnp/boiko_new/crossline/1/politehnicheskaya_next.mp3",2.674708},
    proletarskaya_m = {"subway_announcers/asnp/boiko_new/crossline/1/proletarskaya.mp3",1.060521},
    prospekt_suvorova_m = {"subway_announcers/asnp/boiko_new/crossline/1/prospekr_suvorova.mp3",1.244667},
    rechnaya_m = {"subway_announcers/asnp/boiko_new/crossline/1/rechnaya.mp3",2.090708},
    spec_attention_politehnicheskaya_m = {"subway_announcers/asnp/boiko_new/crossline/1/spec_attention_politehnicheskaya.mp3",10.516479},
    spec_attention_rechnaya_m = {"subway_announcers/asnp/boiko_new/crossline/1/spec_attention_rechnaya.mp3",8.791000},
    kalininskaya_m = {"subway_announcers/asnp/boiko_new/crossline/2/kalininskaya.mp3",0.996938},
    pionerskaya_m = {"subway_announcers/asnp/boiko_new/crossline/2/pionerskaya.mp3",0.916688},
    politehnicheskaya2_arr_m = {"subway_announcers/asnp/boiko_new/crossline/2/politehnicheskaya_arr.mp3",3.165667},
    politehnicheskaya2_next_m = {"subway_announcers/asnp/boiko_new/crossline/2/politehnicheskaya_next.mp3",1.224833},
    timerazevskaya_m = {"subway_announcers/asnp/boiko_new/crossline/2/timerazevskaya.mp3",1.060000},
    vokzalnaya_arr_m = {"subway_announcers/asnp/boiko_new/crossline/2/vokzalnaya_arr.mp3",4.609771},
    vokzalnaya_next_m = {"subway_announcers/asnp/boiko_new/crossline/2/vokzalnaya_next.mp3",2.498896},


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


    arr_kirovskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/arr_kirovskaya.mp3",1.987917},
    arr_mejdunarodnaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/arr_mejdunarodnaya.mp3",2.185542},
    arr_molodejnaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/arr_molodejnaya.mp3",2.093146},
    arr_nahimovskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/arr_nahimovskaya.mp3",2.171021},
    arr_oktyabrskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/arr_oktyabrskaya.mp3",6.757750},
    arr_olimpiyskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/arr_olimpiyskaya.mp3",2.338708},
    arr_park_kultury_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/arr_park_kultury.mp3",2.171104},
    arr_politehnicheskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/arr_politehnicheskaya_old.mp3",6.295417},
    arr_proletarskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/arr_proletarskaya.mp3",2.334667},
    arr_prospekt_suvorova_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/arr_prospekt_suvorova.mp3",2.538375},
    arr_rechnaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/arr_rechnaya.mp3",3.408208},
    mejdunarodnaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/mejdunarodnaya.mp3",1.275063},
    molodejnaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/molodejnaya.mp3",1.196188},
    next_kirovskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/next_kirovskaya.mp3",2.771500},
    next_mejdunarodnaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/next_mejdunarodnaya.mp3",2.947417},
    next_molodejnaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/next_molodejnaya.mp3",2.818333},
    next_nahimovskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/next_nahimovskaya.mp3",2.930021},
    next_oktyabrskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/next_oktyabrskaya.mp3",2.702000},
    next_olimpiyskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/next_olimpiyskaya.mp3",2.996396},
    next_park_kultury_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/next_park_kultury.mp3",2.954438},
    next_politehnicheskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/next_politehnicheskaya.mp3",4.652875},
    next_proletarskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/next_proletarskaya.mp3",2.964667},
    next_prospekt_suvorova_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/next_prospekt_suvorova.mp3",3.674854},
    next_rechnaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/next_rechnaya.mp3",4.248000},
    oktyabrskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/oktyabrskaya.mp3",1.186063},
    olimpiyskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/olimpiyskaya.mp3",1.208104},
    politehnicheskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/politehnicheskaya.mp3",1.506854},
    spec_attemton_politehnicheskaya3_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/spec_attemton_politehnicheskaya3.mp3",12.349063},
    spec_rechnaya_doors_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/spec_rechnaya_doors.mp3",10.953646},
    to_molodejnaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/to_molodejnaya.mp3",3.460771},
    to_oktyabrskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/to_oktyabrskaya.mp3",3.355125},
    to_olimpiyskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/to_olimpiyskaya.mp3",3.424896},
    to_politehnicheskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/1/to_politehnicheskaya.mp3",3.638792},
    arr_kalininskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/2/arr_kalininskaya.mp3",2.369042},
    arr_pionerskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/2/arr_pionerskaya.mp3",2.146000},
    arr_politehnicheskaya2_f = {"subway_announcers/asnp/pyaseckaya/crossline/2/arr_politehnicheskaya.mp3",6.419542},
    arr_timerazevskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/2/arr_timerazevskaya.mp3",2.398271},
    arr_vokzalnaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/2/arr_vokzalnaya.mp3",5.819833},
    next_kalininskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/2/next_kalininskaya.mp3",2.845229},
    next_pionerskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/2/next_pionerskaya.mp3",2.837875},
    next_politehnicheskaya2_f = {"subway_announcers/asnp/pyaseckaya/crossline/2/next_politehnicheskaya.mp3",3.293792},
    next_timerazevskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/2/next_timerazevskaya.mp3",3.049167},
    next_vokzalnaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/2/next_vokzalnaya.mp3",4.291833},
    politehnicheskaya2_f = {"subway_announcers/asnp/pyaseckaya/crossline/2/politehnicheskaya.mp3",1.361250},
    timerazevskaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/2/timerazevskaya.mp3",1.352604},
    to_vokzalnaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/2/to_vokzalnaya.mp3",3.471125},
    vokzalnaya_f = {"subway_announcers/asnp/pyaseckaya/crossline/2/vokzalnaya.mp3",1.175854},
},{
    { --МАРШРУТ
        LED = {5,4,4,4,5,4,4},
        Name = "Линия 1",
        spec_last = {"last_m",0.5,"things_m"},
        spec_wait = {{"train_stop_m"},{"train_depeat_m"}},
        Loop = false,
        BlockDoors = true,
        {
            110,"Международная",
            arrlast = {nil,{"arr_mejdunarodnaya_f",0.5,"last_f",2,"things_f",2,"deadlock_f"},"mejdunarodnaya_m"},
            dep = {{"doors_closing_m","park_kultury_m"}},
        },
        {
            111,"Парк Культуры",
            arr = {{"station_m","park_kultury_m"},"arr_park_kultury_f"},
            dep = {{"doors_closing_m","politehnicheskaya_next_m",0.2,"politeness_m"},{"doors_closing_f","next_mejdunarodnaya_f",0.2,"politeness_f"}},
            not_last_c = {nil,"not_last_f"}
        },
        {
            112,"Политехнич.",
            arr = {{"station_m","politehnicheskaya_arr_m",0.2,"things_m"},{"arr_politehnicheskaya_f",0.2,"objects_f"}},
            dep = {{"doors_closing_m","prospekt_suvorova_m"},{"doors_closing_f","next_park_kultury_f"}},
            not_last_c = {nil,"not_last_f"},
            have_interchange = true,
            right_doors=true,
        },
        {
            113,"Пр. Суворова",
            arr = {{"station_m","prospekt_suvorova_m"},{"arr_prospekt_suvorova_f"}},
            dep = {{"doors_closing_m","nahimovskaya_m"},{"doors_closing_f","next_politehnicheskaya_f"}},
            not_last_c = {nil,"not_last_f"}
        },
        {
            114,"Нахимовская",
            arr = {{"station_m","nahimovskaya_m"},{"arr_nahimovskaya_f"}},
            dep = {{"doors_closing_m","oktyabrskaya_next_m"},{"doors_closing_f","next_prospekt_suvorova_f"}},
            not_last_c = {nil,"not_last_f"}
        },
        {
            115,"Октябрьская",
            arr = {{"station_m","oktyabrskaya_arr_m"},{"arr_oktyabrskaya_f"}},
            dep = {{"doors_closing_m","rechnaya_m","spec_attention_rechnaya_m"},{"doors_closing_f","next_nahimovskaya_f"}},
            arrlast = {{"station_m","oktyabrskaya_arr_m",0.5,"last_m",2,"things_m",2,"deadlock_m"},{"arr_oktyabrskaya_f",0.5,"last_f",2,"things_f",2,"deadlock_f"},"oktyabrskaya_next_m"},
            not_last = {3,"train_goes_to_m","oktyabrskaya_next_m"},
            not_last_f = {3,"to_oktyabrskaya_f"},
            not_last_c = {nil,"not_last_f"}
        },
        {
            116,"Речная",
            arr = {{"arr_rechnaya_f"},{"station_m","rechnaya_m"}},
            --arrlast = {{"station","oktyabrskaya_arr_m",0.5,"last_m",2,"things_m",2,"deadlock_m"},{"arr_oktyabrskaya_f",0.5,"last_f",2,"things_f",2,"deadlock_f"},"oktyabrskaya_next_m"},
            --not_last = {3,"train_goes_to_m","rechnaya_m"},
            --not_last_f = {3,""},
            dep = {{"doors_closing_f","next_proletarskaya_f"},{"doors_closing_m","oktyabrskaya_next_m"}},
            not_last_c = {"not_last_f"},
            right_doors = true,
        },
        {
            117,"Пролетарская",
            arr = {{"arr_proletarskaya_f"},{"station_m","proletarskaya_m"}},
            dep = {{"doors_closing_f","next_olimpiyskaya_f"},{"doors_closing_m","rechnaya_m"}},
            not_last_c = {"not_last_f"},
        },
        {
            118,"Олимпийская",
            arr = {{"arr_olimpiyskaya_f"},{"station_m","olimpiyskaya_m"}},
            dep = {{"doors_closing_f","next_kirovskaya_f"},{"doors_closing_m","proletarskaya_m"}},
            arrlast = {{"arr_olimpiyskaya_f",0.5,"last_f",2,"things_f",2,"deadlock_f"},{"station_m","olimpiyskaya_m",0.5,"last_m",2,"things_m",2,"deadlock_m"},"olimpiyskaya_m"},
            not_last_c = {"not_last_f"},
            not_last = {3,"train_goes_to_m","olimpiyskaya_m"},
            not_last_f = {3,"to_olimpiyskaya_f"},
        },
        {
            118,"Кировская",
            arr = {{"arr_kirovskaya_f",3,"to_molodejnaya_f"},{"station_m","kirovskaya_m"}},
            dep = {{"doors_closing_f","next_molodejnaya_f"},{"doors_closing_m","olimpiyskaya_m"}},
            not_last_c = {"not_last_f"},
        },
        {
            120,"Молодёжная",
            arrlast = {{"arr_molodejnaya_f",0.5,"last_f",2,"things_f",2,"deadlock_f"},nil,"molodejnaya_m"},
            dep = {nil,{"doors_closing_m","kirovskaya_m"}},
            not_last_c = {"not_last_f"},
        },
    },
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

    kirovskaya_m = {"subway_announcers/riu/boiko_new/crossline/1/kirovskaya.mp3",0.883667},
    mejdunarodnaya_m = {"subway_announcers/riu/boiko_new/crossline/1/mejdunarodnaya.mp3",1.206667},
    molodejnaya_m = {"subway_announcers/riu/boiko_new/crossline/1/molodejnaya.mp3",1.112917},
    nahimovskaya_m = {"subway_announcers/riu/boiko_new/crossline/1/nahimovskaya.mp3",1.097292},
    oktyabrskaya_arr_m = {"subway_announcers/riu/boiko_new/crossline/1/oktyabrskaya_arr.mp3",5.656979},
    oktyabrskaya_next_m = {"subway_announcers/riu/boiko_new/crossline/1/oktyabrskaya_next.mp3",1.124083},
    olimpiyskaya_m = {"subway_announcers/riu/boiko_new/crossline/1/olimpiyskaya.mp3",1.081750},
    park_kultury_m = {"subway_announcers/riu/boiko_new/crossline/1/park_kultury.mp3",1.142833},
    --politehnicheskaya_arr_m = {"subway_announcers/riu/boiko_new/crossline/1/politehnicheskaya_arr.mp3",4.657938},
    politehnicheskaya_arr_m = {"subway_announcers/riu/boiko_new/crossline/1/politehnicheskaya_next.mp3",2.674708},
    politehnicheskaya_next_m = {"subway_announcers/riu/boiko_new/crossline/1/politehnicheskaya_next.mp3",2.674708},
    proletarskaya_m = {"subway_announcers/riu/boiko_new/crossline/1/proletarskaya.mp3",1.060521},
    prospekt_suvorova_m = {"subway_announcers/riu/boiko_new/crossline/1/prospekr_suvorova.mp3",1.244667},
    rechnaya_m = {"subway_announcers/riu/boiko_new/crossline/1/rechnaya.mp3",2.090708},
    spec_attention_politehnicheskaya_m = {"subway_announcers/riu/boiko_new/crossline/1/spec_attention_politehnicheskaya.mp3",10.516479},
    spec_attention_rechnaya_m = {"subway_announcers/riu/boiko_new/crossline/1/spec_attention_rechnaya.mp3",8.791000},
    kalininskaya_m = {"subway_announcers/riu/boiko_new/crossline/2/kalininskaya.mp3",0.996938},
    pionerskaya_m = {"subway_announcers/riu/boiko_new/crossline/2/pionerskaya.mp3",0.916688},
    politehnicheskaya2_arr_m = {"subway_announcers/riu/boiko_new/crossline/2/politehnicheskaya_arr.mp3",3.165667},
    politehnicheskaya2_next_m = {"subway_announcers/riu/boiko_new/crossline/2/politehnicheskaya_next.mp3",1.224833},
    timerazevskaya_m = {"subway_announcers/riu/boiko_new/crossline/2/timerazevskaya.mp3",1.060000},
    vokzalnaya_arr_m = {"subway_announcers/riu/boiko_new/crossline/2/vokzalnaya_arr.mp3",4.609771},
    vokzalnaya_next_m = {"subway_announcers/riu/boiko_new/crossline/2/vokzalnaya_next.mp3",2.498896},


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


    arr_kirovskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/arr_kirovskaya.mp3",1.987917},
    arr_mejdunarodnaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/arr_mejdunarodnaya.mp3",2.185542},
    arr_molodejnaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/arr_molodejnaya.mp3",2.093146},
    arr_nahimovskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/arr_nahimovskaya.mp3",2.171021},
    arr_oktyabrskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/arr_oktyabrskaya.mp3",6.757750},
    arr_olimpiyskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/arr_olimpiyskaya.mp3",2.338708},
    arr_park_kultury_f = {"subway_announcers/riu/pyaseckaya/crossline/1/arr_park_kultury.mp3",2.171104},
    arr_politehnicheskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/arr_politehnicheskaya_old.mp3",6.295417},
    arr_proletarskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/arr_proletarskaya.mp3",2.334667},
    arr_prospekt_suvorova_f = {"subway_announcers/riu/pyaseckaya/crossline/1/arr_prospekt_suvorova.mp3",2.538375},
    arr_rechnaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/arr_rechnaya.mp3",3.408208},
    mejdunarodnaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/mejdunarodnaya.mp3",1.275063},
    molodejnaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/molodejnaya.mp3",1.196188},
    next_kirovskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/next_kirovskaya.mp3",2.771500},
    next_mejdunarodnaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/next_mejdunarodnaya.mp3",2.947417},
    next_molodejnaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/next_molodejnaya.mp3",2.818333},
    next_nahimovskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/next_nahimovskaya.mp3",2.930021},
    next_oktyabrskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/next_oktyabrskaya.mp3",2.702000},
    next_olimpiyskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/next_olimpiyskaya.mp3",2.996396},
    next_park_kultury_f = {"subway_announcers/riu/pyaseckaya/crossline/1/next_park_kultury.mp3",2.954438},
    next_politehnicheskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/next_politehnicheskaya.mp3",4.652875},
    next_proletarskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/next_proletarskaya.mp3",2.964667},
    next_prospekt_suvorova_f = {"subway_announcers/riu/pyaseckaya/crossline/1/next_prospekt_suvorova.mp3",3.674854},
    next_rechnaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/next_rechnaya.mp3",4.248000},
    oktyabrskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/oktyabrskaya.mp3",1.186063},
    olimpiyskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/olimpiyskaya.mp3",1.208104},
    politehnicheskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/politehnicheskaya.mp3",1.506854},
    spec_attemton_politehnicheskaya3_f = {"subway_announcers/riu/pyaseckaya/crossline/1/spec_attemton_politehnicheskaya3.mp3",12.349063},
    spec_rechnaya_doors_f = {"subway_announcers/riu/pyaseckaya/crossline/1/spec_rechnaya_doors.mp3",10.953646},
    to_molodejnaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/to_molodejnaya.mp3",3.460771},
    to_oktyabrskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/to_oktyabrskaya.mp3",3.355125},
    to_olimpiyskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/to_olimpiyskaya.mp3",3.424896},
    to_politehnicheskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/1/to_politehnicheskaya.mp3",3.638792},
    arr_kalininskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/2/arr_kalininskaya.mp3",2.369042},
    arr_pionerskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/2/arr_pionerskaya.mp3",2.146000},
    arr_politehnicheskaya2_f = {"subway_announcers/riu/pyaseckaya/crossline/2/arr_politehnicheskaya.mp3",6.419542},
    arr_timerazevskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/2/arr_timerazevskaya.mp3",2.398271},
    arr_vokzalnaya_f = {"subway_announcers/riu/pyaseckaya/crossline/2/arr_vokzalnaya.mp3",5.819833},
    next_kalininskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/2/next_kalininskaya.mp3",2.845229},
    next_pionerskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/2/next_pionerskaya.mp3",2.837875},
    next_politehnicheskaya2_f = {"subway_announcers/riu/pyaseckaya/crossline/2/next_politehnicheskaya.mp3",3.293792},
    next_timerazevskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/2/next_timerazevskaya.mp3",3.049167},
    next_vokzalnaya_f = {"subway_announcers/riu/pyaseckaya/crossline/2/next_vokzalnaya.mp3",4.291833},
    politehnicheskaya2_f = {"subway_announcers/riu/pyaseckaya/crossline/2/politehnicheskaya.mp3",1.361250},
    timerazevskaya_f = {"subway_announcers/riu/pyaseckaya/crossline/2/timerazevskaya.mp3",1.352604},
    to_vokzalnaya_f = {"subway_announcers/riu/pyaseckaya/crossline/2/to_vokzalnaya.mp3",3.471125},
    vokzalnaya_f = {"subway_announcers/riu/pyaseckaya/crossline/2/vokzalnaya.mp3",1.175854},
},{
    { --МАРШРУТ
        LED = {5,4,4,4,5,4,4},
        Name = "Линия 1",
        spec_last = {"last_m",0.5,"things_m"},
        spec_wait = {{"train_stop_m"},{"train_depeat_m"}},
        Loop = false,
        BlockDoors = true,
        {
            110,"Международная",
            arrlast = {nil,{"arr_mejdunarodnaya_f",0.5,"last_f",2,"things_f",2,"deadlock_f"},"mejdunarodnaya_m"},
            dep = {{"doors_closing_m","park_kultury_m"}},
        },
        {
            111,"Парк Культуры",
            arr = {{"station_m","park_kultury_m"},"arr_park_kultury_f"},
            dep = {{"doors_closing_m","politehnicheskaya_next_m",0.2,"politeness_m"},{"doors_closing_f","next_mejdunarodnaya_f",0.2,"politeness_f"}},
            not_last_c = {nil,"not_last_f"}
        },
        {
            112,"Политехнич.",
            arr = {{"station_m","politehnicheskaya_arr_m",0.2,"things_m"},{"arr_politehnicheskaya_f",0.2,"objects_f"}},
            dep = {{"doors_closing_m","prospekt_suvorova_m"},{"doors_closing_f","next_park_kultury_f"}},
            not_last_c = {nil,"not_last_f"},
            have_interchange = true,
            right_doors=true,
        },
        {
            113,"Пр. Суворова",
            arr = {{"station_m","prospekt_suvorova_m"},{"arr_prospekt_suvorova_f"}},
            dep = {{"doors_closing_m","nahimovskaya_m"},{"doors_closing_f","next_politehnicheskaya_f"}},
            not_last_c = {nil,"not_last_f"}
        },
        {
            114,"Нахимовская",
            arr = {{"station_m","nahimovskaya_m"},{"arr_nahimovskaya_f"}},
            dep = {{"doors_closing_m","oktyabrskaya_next_m"},{"doors_closing_f","next_prospekt_suvorova_f"}},
            not_last_c = {nil,"not_last_f"}
        },
        {
            115,"Октябрьская",
            arr = {{"station_m","oktyabrskaya_arr_m"},{"arr_oktyabrskaya_f"}},
            dep = {{"doors_closing_m","rechnaya_m","spec_attention_rechnaya_m"},{"doors_closing_f","next_nahimovskaya_f"}},
            arrlast = {{"station_m","oktyabrskaya_arr_m",0.5,"last_m",2,"things_m",2,"deadlock_m"},{"arr_oktyabrskaya_f",0.5,"last_f",2,"things_f",2,"deadlock_f"},"oktyabrskaya_next_m"},
            not_last = {3,"train_goes_to_m","oktyabrskaya_next_m"},
            not_last_f = {3,"to_oktyabrskaya_f"},
            not_last_c = {nil,"not_last_f"}
        },
        {
            116,"Речная",
            arr = {{"arr_rechnaya_f"},{"station_m","rechnaya_m"}},
            --arrlast = {{"station","oktyabrskaya_arr_m",0.5,"last_m",2,"things_m",2,"deadlock_m"},{"arr_oktyabrskaya_f",0.5,"last_f",2,"things_f",2,"deadlock_f"},"oktyabrskaya_next_m"},
            --not_last = {3,"train_goes_to_m","rechnaya_m"},
            --not_last_f = {3,""},
            dep = {{"doors_closing_f","next_proletarskaya_f"},{"doors_closing_m","oktyabrskaya_next_m"}},
            not_last_c = {"not_last_f"},
            right_doors = true,
        },
        {
            117,"Пролетарская",
            arr = {{"arr_proletarskaya_f"},{"station_m","proletarskaya_m"}},
            dep = {{"doors_closing_f","next_olimpiyskaya_f"},{"doors_closing_m","rechnaya_m"}},
            not_last_c = {"not_last_f"},
        },
        {
            118,"Олимпийская",
            arr = {{"arr_olimpiyskaya_f"},{"station_m","olimpiyskaya_m"}},
            dep = {{"doors_closing_f","next_kirovskaya_f"},{"doors_closing_m","proletarskaya_m"}},
            arrlast = {{"arr_olimpiyskaya_f",0.5,"last_f",2,"things_f",2,"deadlock_f"},{"station_m","olimpiyskaya_m",0.5,"last_m",2,"things_m",2,"deadlock_m"},"olimpiyskaya_m"},
            not_last_c = {"not_last_f"},
            not_last = {3,"train_goes_to_m","olimpiyskaya_m"},
            not_last_f = {3,"to_olimpiyskaya_f"},
        },
        {
            118,"Кировская",
            arr = {{"arr_kirovskaya_f",3,"to_molodejnaya_f"},{"station_m","kirovskaya_m"}},
            dep = {{"doors_closing_f","next_molodejnaya_f"},{"doors_closing_m","olimpiyskaya_m"}},
            not_last_c = {"not_last_f"},
        },
        {
            120,"Молодёжная",
            arrlast = {{"arr_molodejnaya_f",0.5,"last_f",2,"things_f",2,"deadlock_f"},nil,"molodejnaya_m"},
            dep = {nil,{"doors_closing_m","kirovskaya_m"}},
            not_last_c = {"not_last_f"},
        },
    },
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

    arr_kirovskaya = {"subway_announcers/rri/boiko/crossline/1/arr_kirovskaya.mp3",2.121701},
    arr_mejdunarodnaya = {"subway_announcers/rri/boiko/crossline/1/arr_mejdunarodnaya.mp3",2.160771},
    arr_molodejnaya = {"subway_announcers/rri/boiko/crossline/1/arr_molodejnaya.mp3",2.291270},
    arr_nahimovskaya = {"subway_announcers/rri/boiko/crossline/1/arr_nahimovskaya.mp3",2.197279},
    arr_oktyabrskaya = {"subway_announcers/rri/boiko/crossline/1/arr_oktyabrskaya.mp3",6.664853},
    arr_olimpiyskaya = {"subway_announcers/rri/boiko/crossline/1/arr_olimpiyskaya.mp3",1.951587},
    arr_park_kultury = {"subway_announcers/rri/boiko/crossline/1/arr_park_kultury.mp3",2.079796},
    arr_politehnicheskaya = {"subway_announcers/rri/boiko/crossline/1/arr_politehnicheskaya.mp3",5.529909},
    arr_proletarskaya = {"subway_announcers/rri/boiko/crossline/1/arr_proletarskaya.mp3",2.057959},
    arr_prospekt_suvorova = {"subway_announcers/rri/boiko/crossline/1/arr_prospekt_suvorova.mp3",3.038118},
    arr_rechnaya = {"subway_announcers/rri/boiko/crossline/1/arr_rechnaya.mp3",3.004853},
    next_kirovskaya = {"subway_announcers/rri/boiko/crossline/1/next_kirovskaya.mp3",5.574558},
    next_mejdunarodnaya = {"subway_announcers/rri/boiko/crossline/1/next_mejdunarodnaya.mp3",5.155261},
    next_molodejnaya = {"subway_announcers/rri/boiko/crossline/1/next_molodejnaya.mp3",5.864898},
    next_nahimovskaya = {"subway_announcers/rri/boiko/crossline/1/next_nahimovskaya.mp3",5.102834},
    next_oktyabrskaya = {"subway_announcers/rri/boiko/crossline/1/next_oktyabrskaya.mp3",5.102834},
    next_olimpiyskaya = {"subway_announcers/rri/boiko/crossline/1/next_olimpiyskaya.mp3",5.038776},
    next_park_kultury = {"subway_announcers/rri/boiko/crossline/1/next_park_kultury.mp3",5.226780},
    next_politehnicheskaya = {"subway_announcers/rri/boiko/crossline/1/next_politehnicheskaya.mp3",5.088367},
    next_proletarskaya = {"subway_announcers/rri/boiko/crossline/1/next_proletarskaya.mp3",5.155193},
    next_prospekt_suvorova = {"subway_announcers/rri/boiko/crossline/1/next_prospekt_suvorova.mp3",6.172585},
    next_rechnaya = {"subway_announcers/rri/boiko/crossline/1/next_rechnaya.mp3",6.388458},
    spec_politehnicheskaya = {"subway_announcers/rri/boiko/crossline/1/spec_politehnicheskaya.mp3",11.393311},
    spec_rechnaya_doors = {"subway_announcers/rri/boiko/crossline/1/spec_rechnaya_doors.mp3",9.786349},
    to_molodejnaya = {"subway_announcers/rri/boiko/crossline/1/to_molodejnaya.mp3",4.925374},
    to_oktyabrskaya = {"subway_announcers/rri/boiko/crossline/1/to_oktyabrskaya.mp3",4.578889},
    to_olimpiyskaya = {"subway_announcers/rri/boiko/crossline/1/to_olimpiyskaya.mp3",4.639796},
    to_politehnicheskaya = {"subway_announcers/rri/boiko/crossline/1/to_politehnicheskaya.mp3",4.665238},
    arr_kalininskaya = {"subway_announcers/rri/boiko/crossline/2/arr_kalininskaya.mp3",2.158163},
    arr_pionerskaya = {"subway_announcers/rri/boiko/crossline/2/arr_pionerskaya.mp3",2.090045},
    arr_politehnicheskaya2 = {"subway_announcers/rri/boiko/crossline/2/arr_politehnicheskaya.mp3",5.491179},
    arr_timeryazevskaya = {"subway_announcers/rri/boiko/crossline/2/arr_timeryazevskaya.mp3",2.062154},
    arr_vokzalnaya = {"subway_announcers/rri/boiko/crossline/2/arr_vokzalnaya.mp3",6.513039},
    next_kalininskaya = {"subway_announcers/rri/boiko/crossline/2/next_kalininskaya.mp3",5.364104},
    next_pionerskaya = {"subway_announcers/rri/boiko/crossline/2/next_pionerskaya.mp3",5.116485},
    next_politehnicheskaya2 = {"subway_announcers/rri/boiko/crossline/2/next_politehnicheskaya.mp3",7.010385},
    next_timeryazevskaya = {"subway_announcers/rri/boiko/crossline/2/next_timeryazevskaya.mp3",5.356667},
    next_vokzalnaya = {"subway_announcers/rri/boiko/crossline/2/next_vokzalnaya.mp3",5.007256},
    to_vokzalnaya = {"subway_announcers/rri/boiko/crossline/2/to_vokzalnaya.mp3",4.658980},
},{
    {
        Name = "Line 1",
        spec_last = {"last"},
        spec_wait = {{"train_stop"},{"train_depeat"}},
        {
            110,"Mezhdunarod.",
            arrlast = {nil,{"arr_mejdunarodnaya",0.5,"last"}},
            dep = {"next_park_kultury"},
        },
        {
            111,"Park Kultury",
            arr = {"arr_park_kultury","arr_park_kultury"},
            dep = {{"next_politehnicheskaya",0.2,"politeness"},{"next_mejdunarodnaya",0.2,"politeness"}},
        },
        {
            112,"Politehnich.",
            arr = {{"arr_politehnicheskaya",0.2,"things"},{"arr_politehnicheskaya",0.2,"objects"}},
            dep = {"next_prospekt_suvorova","next_park_kultury"},
        },
        {
            113,"Pr. Suvorova",
            arr = {{"arr_prospekt_suvorova",0.2,"objects"},{"arr_prospekt_suvorova",0.2,"things"}},
            dep = {"next_nahimovskaya","next_politehnicheskaya"},
        },
        {
            114,"Nahimovskaya",
            arr = {"arr_nahimovskaya","arr_nahimovskaya"},
            dep = {{"next_oktyabrskaya",0.2,"politeness"},"next_prospekt_suvorova"},
        },
        {
            115,"Oktabrskaya",
            arr = {"arr_oktyabrskaya","arr_oktyabrskaya"},
            dep = {{"next_rechnaya",0.5,"spec_rechnaya_doors"},"next_nahimovskaya"},
            arrlast = {{"arr_oktyabrskaya",0.5,"last"},{"arr_oktyabrskaya",0.5,"last"}},
            not_last = {3,"to_oktyabrskaya"}
        },
        {
            116,"Rechnaya",
            arr = {"arr_rechnaya","arr_rechnaya"},
            dep = {"next_proletarskaya","next_oktyabrskaya"},
            --arrlast = {{"arr_rechnaya",0.5,"last"},{"arr_rechnaya",0.5,"last"}},
            --not_last = {3,""
        },
        {
            117,"Proletarskaya",
            arr = {"arr_proletarskaya","arr_proletarskaya"},
            dep = {"next_olimpiyskaya",{"next_rechnaya",0.5,"spec_rechnaya_doors"}},
        },
        {
            118,"Olimpyiskaya",
            arr = {"arr_olimpiyskaya","arr_olimpiyskaya"},
            dep = {"next_kirovskaya","next_proletarskaya"},
            arrlast = {{"arr_olimpiyskaya",0.5,"last"},{"arr_olimpiyskaya",0.5,"last"}},
            not_last = {3,"to_olimpiyskaya"}
        },
        {
            119,"Kirovskaya",
            arr = {{"arr_kirovskaya",3,"to_molodejnaya"},{"arr_kirovskaya",0.2,"exit"}},
            dep = {"next_molodejnaya","next_olimpiyskaya"},
        },
        {
            120,"Molodejnaya",
            --arr = {"arr_rechnaya",{"arr_rechnaya"}},
            arrlast = {{"arr_molodejnaya",0.5,"last"},nil},
            dep = {nil,{"next_kirovskaya",0.2,"politeness"}},
        },
    },
})
Metrostroi.SetUPOAnnouncer({
    name = "UPO RHINO",
    tone = {"subway_announcers/upo/rhino/crossline/tone.mp3", 1.2},
    click1 = {"subway_announcers/upo/click1.mp3", 0.3},
    click2 = {"subway_announcers/upo/click2.mp3", 0.1},
    --proletarskaya = {"subway_announcers/upo/rhino/crossline/proletarskaya.mp3",0.809100},
    --next_proletarskaya = {"subway_announcers/upo/rhino/crossline/next_proletarskaya.mp3",1.853100},

    --olimpiyskaya = {"subway_announcers/upo/rhino/crossline/olimpiyskaya.mp3",0.835200},
    --next_olimpiyskaya = {"subway_announcers/upo/rhino/crossline/next_olimpiyskaya.mp3",1.800900},
    --last_olimpiyskaya = {"subway_announcers/upo/rhino/crossline/last_olimpiyskaya.mp3",9.735300},

    --kirovskaya = {"subway_announcers/upo/rhino/crossline/kirovskaya.mp3",0.678600},
    --next_kirovskaya = {"subway_announcers/upo/rhino/crossline/next_kirovskaya.mp3",1.644300},

    --molodejnaya = {"subway_announcers/upo/rhino/crossline/molodejnaya.mp3",0.704700},
    --next_molodejnaya = {"subway_announcers/upo/rhino/crossline/next_molodejnaya.mp3",1.696500},
    --last_molodejnaya = {"subway_announcers/upo/rhino/crossline/last_molodejnaya.mp3",10.100700},

    mejdunarodnaya = {"subway_announcers/upo/rhino/crossline/mejdunarodnaya.mp3",1.017900},
    next_mejdunarodnaya = {"subway_announcers/upo/rhino/crossline/next_mejdunarodnaya.mp3",1.800900},
    last_mejdunarodnaya = {"subway_announcers/upo/rhino/crossline/last_mejdunarodnaya.mp3",9.709200},

    park_kultury = {"subway_announcers/upo/rhino/crossline/park_kultury.mp3",0.887400},
    next_park_kultury = {"subway_announcers/upo/rhino/crossline/next_park_kultury.mp3",1.827000},

    politehnicheskaya = {"subway_announcers/upo/rhino/crossline/politehnicheskaya.mp3",0.965700},
    next_politehnicheskaya = {"subway_announcers/upo/rhino/crossline/next_politehnicheskaya.mp3",2.035800},

    prospekt_suvorova = {"subway_announcers/upo/rhino/crossline/prospekt_suvorova.mp3",1.044000},
    next_prospekt_suvorova = {"subway_announcers/upo/rhino/crossline/next_prospekt_suvorova.mp3",2.009700},

    nahimovskaya = {"subway_announcers/upo/rhino/crossline/nahimovskaya.mp3",0.861300},
    next_nahimovskaya = {"subway_announcers/upo/rhino/crossline/next_nahimovskaya.mp3",1.853100},

    oktyabrskaya = {"subway_announcers/upo/rhino/crossline/oktyabrskaya.mp3",0.835200},
    next_oktyabrskaya = {"subway_announcers/upo/rhino/crossline/next_oktyabrskaya.mp3",1.879200},

    rechnaya = {"subway_announcers/upo/rhino/crossline/rechnaya.mp3",0.678600},
    next_rechnaya = {"subway_announcers/upo/rhino/crossline/next_rechnaya.mp3",10.727100},
    next_rechnaya1 = {"subway_announcers/upo/rhino/crossline/next_rechnaya1.mp3",1.722600},
    last_rechnaya = {"subway_announcers/upo/rhino/crossline/last_rechnaya.mp3",10.727100},

    spec_attention_handrails = {"subway_announcers/upo/rhino/crossline/spec_attention_handrails.mp3",3.967200},
    spec_attention_politeness = {"subway_announcers/upo/rhino/crossline/spec_attention_politeness.mp3",5.533200},

    odz = {"subway_announcers/upo/rhino/crossline/odz.mp3",2.02},
},{
    {
        110,"Международная",
        arrlast = {nil,"last_mejdunarodnaya"},
        dep = {"odz"},
        noises = {2,3},noiserandom = 0.08,
    },
    {
        111,"Парк Культуры",
        arr = {{"park_kultury",0.5,"next_politehnicheskaya"},{"park_kultury",0.5,"next_mejdunarodnaya","spec_attention_politeness"}},
        dep = {"odz","odz"},
        noises = {1,2},noiserandom = 0.12,
    },
    {
        112,"Политехническая",
        arr = {{"politehnicheskaya",0.5,"next_prospekt_suvorova","spec_attention_politeness"},{"politehnicheskaya",0.5,"next_park_kultury","spec_attention_handrails"}},
        dep = {"odz","odz"},
        noises = {3},noiserandom = 0.05,
    },
    {
        113,"Пр. Суворова",
        arr = {{"prospekt_suvorova",0.5,"next_nahimovskaya","spec_attention_handrails"},{"prospekt_suvorova",0.5,"next_politehnicheskaya"}},
        dep = {"odz","odz"},
    },
    {
        114,"Нахимовская",
        arr = {{"nahimovskaya",0.5,"next_oktyabrskaya","spec_attention_politeness"},{"nahimovskaya",0.5,"next_prospekt_suvorova","spec_attention_politeness"}},
        dep = {"odz","odz"},
        noises = {1,2,3},noiserandom = 0.02,
    },
    {
        115,"Октябрьская",
        arr = {{"oktyabrskaya",0.5,"next_rechnaya"},{"oktyabrskaya",3,"next_nahimovskaya"}},
        dep = {"odz","odz"},
        noises = {1,2},noiserandom = 0.2,
    },
    {
        116,"Речная",
        arrlast = {"last_rechnaya"},
        dep = {nil,"odz"},
        noises = {1,3},noiserandom = 0.08,
    },
})
--[[Metrostroi.AddSarmatUPOAnnouncer("UPO RHINO",{
    tone                      = {"subway_announcers/sarmat_upo/tone.mp3",1},
    --proletarskaya = {"subway_announcers/sarmat_upo/rhino/crossline/proletarskaya.mp3",0.809100},
    --next_proletarskaya = {"subway_announcers/sarmat_upo/rhino/crossline/next_proletarskaya.mp3",1.853100},

    --olimpiyskaya = {"subway_announcers/sarmat_upo/rhino/crossline/olimpiyskaya.mp3",0.835200},
    --next_olimpiyskaya = {"subway_announcers/sarmat_upo/rhino/crossline/next_olimpiyskaya.mp3",1.800900},
    --last_olimpiyskaya = {"subway_announcers/sarmat_upo/rhino/crossline/last_olimpiyskaya.mp3",9.735300},

    --kirovskaya = {"subway_announcers/sarmat_upo/rhino/crossline/kirovskaya.mp3",0.678600},
    --next_kirovskaya = {"subway_announcers/sarmat_upo/rhino/crossline/next_kirovskaya.mp3",1.644300},

    --molodejnaya = {"subway_announcers/sarmat_upo/rhino/crossline/molodejnaya.mp3",0.704700},
    --next_molodejnaya = {"subway_announcers/sarmat_upo/rhino/crossline/next_molodejnaya.mp3",1.696500},
    --last_molodejnaya = {"subway_announcers/sarmat_upo/rhino/crossline/last_molodejnaya.mp3",10.100700},

    mejdunarodnaya = {"subway_announcers/sarmat_upo/rhino/crossline/mejdunarodnaya.mp3",1.017900},
    next_mejdunarodnaya = {"subway_announcers/sarmat_upo/rhino/crossline/next_mejdunarodnaya.mp3",1.800900},
    last_mejdunarodnaya = {"subway_announcers/sarmat_upo/rhino/crossline/last_mejdunarodnaya.mp3",9.709200},

    park_kultury = {"subway_announcers/sarmat_upo/rhino/crossline/park_kultury.mp3",0.887400},
    next_park_kultury = {"subway_announcers/sarmat_upo/rhino/crossline/next_park_kultury.mp3",1.827000},

    politehnicheskaya = {"subway_announcers/sarmat_upo/rhino/crossline/politehnicheskaya.mp3",0.965700},
    next_politehnicheskaya = {"subway_announcers/sarmat_upo/rhino/crossline/next_politehnicheskaya.mp3",2.035800},

    prospekt_suvorova = {"subway_announcers/sarmat_upo/rhino/crossline/prospekt_suvorova.mp3",1.044000},
    next_prospekt_suvorova = {"subway_announcers/sarmat_upo/rhino/crossline/next_prospekt_suvorova.mp3",2.009700},

    nahimovskaya = {"subway_announcers/sarmat_upo/rhino/crossline/nahimovskaya.mp3",0.861300},
    next_nahimovskaya = {"subway_announcers/sarmat_upo/rhino/crossline/next_nahimovskaya.mp3",1.853100},

    oktyabrskaya = {"subway_announcers/sarmat_upo/rhino/crossline/oktyabrskaya.mp3",0.835200},
    next_oktyabrskaya = {"subway_announcers/sarmat_upo/rhino/crossline/next_oktyabrskaya.mp3",1.879200},

    rechnaya = {"subway_announcers/sarmat_upo/rhino/crossline/rechnaya.mp3",0.678600},
    next_rechnaya = {"subway_announcers/sarmat_upo/rhino/crossline/next_rechnaya.mp3",10.727100},
    next_rechnaya1 = {"subway_announcers/sarmat_upo/rhino/crossline/next_rechnaya1.mp3",1.722600},
    last_rechnaya = {"subway_announcers/sarmat_upo/rhino/crossline/last_rechnaya.mp3",10.727100},

    spec_attention_handrails = {"subway_announcers/sarmat_upo/rhino/crossline/spec_attention_handrails.mp3",3.967200},
    spec_attention_politeness = {"subway_announcers/sarmat_upo/rhino/crossline/spec_attention_politeness.mp3",5.533200},

    odz1 = {"subway_announcers/sarmat_upo/rhino/crossline/odz1.mp3",2.088000+0.3},
    odz2 = {"subway_announcers/sarmat_upo/rhino/crossline/odz2.mp3",2.192400+0.3},
},{
    { --МАРШРУТ
        LED = {3,4,5,5,5,5,5},
        {
            909,"Международная",
            arr = {nil,"last_mejdunarodnaya"},
            arrlast = {nil,"last_mejdunarodnaya"},
            dep = {"next_park_kultury"},
            odz = "odz1",
            dist = 30,
        },
        {
            910,"Парк Культуры",
            arr = {{"park_kultury",3,"next_politehnicheskaya"},{"park_kultury",3,"next_mejdunarodnaya","spec_attention_politeness"}},
            dep = {"next_politehnicheskaya","next_mejdunarodnaya"},
            odz = "odz2",
            dist = 30,
        },
        {
            911,"Политехническая",
            arr = {{"politehnicheskaya",3,"next_prospekt_suvorova","spec_attention_politeness"},{"politehnicheskaya",3,"next_park_kultury","spec_attention_handrails"}},
            dep = {"next_prospekt_suvorova","next_park_kultury"},
            odz = "odz1",
            dist = 30,
        },
        {
            912,"Пр. Суворова",
            arr = {{"prospekt_suvorova",3,"next_nahimovskaya","spec_attention_handrails"},{"prospekt_suvorova",3,"next_politehnicheskaya"}},
            dep = {"next_nahimovskaya","next_politehnicheskaya"},
            odz = "odz2",
            dist = 30,
        },
        {
            913,"Нахимовская",
            arr = {{"nahimovskaya",3,"next_oktyabrskaya","spec_attention_politeness"},{"nahimovskaya",3,"next_prospekt_suvorova","spec_attention_politeness"}},
            dep = {"next_oktyabrskaya","next_prospekt_suvorova"},
            odz = "odz1",
            dist = 30,
        },
        {
            914,"Октябрьская",
            arr = {{"oktyabrskaya",3,"next_rechnaya"},{"oktyabrskaya",3,"next_nahimovskaya"}},
            dep = {"next_rechnaya1","next_nahimovskaya"},
            odz = "odz2",
            dist = 30,
        },
        {
            915,"Речная",
            arr = {"last_rechnaya"},
            arrlast = {"last_rechnaya"},
            dep = {nil,"next_oktyabrskaya"},
            odz = "odz1",
            dist = 30,
        },
    },
})--]]
Metrostroi.AddSarmatUPOAnnouncer("UPO Artur",{
    tone                      = {"subway_announcers/sarmat_upo/tone.mp3",1},
    rechnaya                  = {"subway_announcers/sarmat_upo/crossline_artur/rechnaya.mp3",0.939271},
    last_rechnaya             = {"subway_announcers/sarmat_upo/crossline_artur/last_rechnaya.mp3",12.962604},
    next_rechnaya             = {"subway_announcers/sarmat_upo/crossline_artur/next_rechnaya1.mp3",12.384375},
    next_rechnaya2            = {"subway_announcers/sarmat_upo/crossline_artur/next_rechnaya2.mp3",1.720896},

    oktyabrskaya              = {"subway_announcers/sarmat_upo/crossline_artur/oktyabrskaya.mp3",1.144646},
    next_oktyabrskaya         = {"subway_announcers/sarmat_upo/crossline_artur/next_oktyabrskaya.mp3",2.240396},

    nahimovskaya              = {"subway_announcers/sarmat_upo/crossline_artur/nahimovskaya.mp3",1.179146},
    next_nahimovskaya         = {"subway_announcers/sarmat_upo/crossline_artur/next_nahimovskaya.mp3",2.466563},

    prospekt_suvorova         = {"subway_announcers/sarmat_upo/crossline_artur/prospekt_suvorova.mp3",1.566375},
    next_prospekt_suvorova    = {"subway_announcers/sarmat_upo/crossline_artur/next_prospekt_suvorova.mp3",2.486813},

    politehnicheskaya         = {"subway_announcers/sarmat_upo/crossline_artur/politehnicheskaya.mp3",1.178271},
    next_politehnicheskaya    = {"subway_announcers/sarmat_upo/crossline_artur/next_politehnicheskaya.mp3",2.400917},

    park_kultury              = {"subway_announcers/sarmat_upo/crossline_artur/park_kultury.mp3",1.285271},
    next_park_kultury         = {"subway_announcers/sarmat_upo/crossline_artur/next_park_kultury.mp3",2.242479},

    mejdunarodnaya            = {"subway_announcers/sarmat_upo/crossline_artur/mejdunarodnaya.mp3",1.123333},
    next_mejdunarodnaya       = {"subway_announcers/sarmat_upo/crossline_artur/next_mejdunarodnaya.mp3",2.360938},
    last_mejdunarodnaya       = {"subway_announcers/sarmat_upo/crossline_artur/last_mejdunarodnaya.mp3",11.327729},
    --molodejnaya               = {"subway_announcers/sarmat_upo/crossline_artur/molodejnaya.mp3",1.064354},
    --next_molodejnaya          = {"subway_announcers/sarmat_upo/crossline_artur/next_molodejnaya.mp3",1.996167},
    --last_molodejnaya          = {"subway_announcers/sarmat_upo/crossline_artur/last_molodejnaya.mp3",11.295438},
    --kirovskaya                = {"subway_announcers/sarmat_upo/crossline_artur/kirovskaya.mp3",0.900000},
    --next_kirovskaya           = {"subway_announcers/sarmat_upo/crossline_artur/next_kirovskaya.mp3",2.142271},
    --olimpiyskaya              = {"subway_announcers/sarmat_upo/crossline_artur/olimpiyskaya.mp3",1.095958},
    --next_olimpiyskaya         = {"subway_announcers/sarmat_upo/crossline_artur/next_olimpiyskaya.mp3",2.446542},
    --last_olimpiyskaya         = {"subway_announcers/sarmat_upo/crossline_artur/last_olimpiyskaya.mp3",11.552521},
    --proletarskaya             = {"subway_announcers/sarmat_upo/crossline_artur/proletarskaya.mp3",1.111333},
    --next_proletarskaya        = {"subway_announcers/sarmat_upo/crossline_artur/next_proletarskaya.mp3",2.072313},
    odz1                      = {"subway_announcers/sarmat_upo/crossline_artur/odz.mp3",2.612750},
    odz2                      = {"subway_announcers/sarmat_upo/crossline_artur/odz2.mp3",2.392542},
    spec_attention_handrails  = {"subway_announcers/sarmat_upo/crossline_artur/spec_attention_handrails.mp3",3.972021},
    spec_attention_politeness = {"subway_announcers/sarmat_upo/crossline_artur/spec_attention_politeness.mp3",5.614417},
},{
    { --МАРШРУТ
        LED = {3,4,5,5,5,5,5},
        Name = "Кировская",
        {
            110,"Международная","Mezhdunarodnaya",
            arr = {nil,"last_mejdunarodnaya"},
            arrlast = {nil,"last_mejdunarodnaya"},
            dep = {"next_park_kultury"},
            odz = "odz1",
            messagedep = "Проверка обычная\n%rПроверка красная\n%gУважаемые пассажиры,\nво избежании травм\nдержитесь за поручни!",
        },
        {
            111,"Парк Культуры","Park kultury",
            arr = {{"park_kultury",3,"next_politehnicheskaya"},{"park_kultury",3,"next_mejdunarodnaya","spec_attention_politeness"}},
            dep = {"next_politehnicheskaya","next_mejdunarodnaya"},
            odz = "odz1",
        },
        {
            112,"Политехническая","Politehnicheskaya",
            arr = {{"politehnicheskaya",3,"next_prospekt_suvorova","spec_attention_politeness"},{"politehnicheskaya",3,"next_park_kultury","spec_attention_handrails"}},
            dep = {"next_prospekt_suvorova","next_park_kultury"},
            odz = "odz2",
            right_doors=true,
        },
        {
            113,"Пр. Суворова","Pr. Suvorova",
            arr = {{"prospekt_suvorova",3,"next_nahimovskaya","spec_attention_handrails"},{"prospekt_suvorova",3,"next_politehnicheskaya"}},
            dep = {"next_nahimovskaya","next_politehnicheskaya"},
            odz = "odz1",
        },
        {
            114,"Нахимовская","Nahimovskaya",
            arr = {{"nahimovskaya",3,"next_oktyabrskaya","spec_attention_politeness"},{"nahimovskaya",3,"next_prospekt_suvorova","spec_attention_politeness"}},
            dep = {"next_oktyabrskaya","next_prospekt_suvorova"},
            odz = "odz2",
            messagedep="%rЧто то интересное...",
        },
        {
            115,"Октябрьская","Oktyabrskaya",
            arr = {{"oktyabrskaya",3,"next_rechnaya"},{"oktyabrskaya",3,"next_nahimovskaya"}},
            dep = {"next_rechnaya2","next_nahimovskaya"},
            odz = "odz1",
            messagearr="%gУважаемые пассажиры!\nВо изжежании травм,\nдержитесь за поручни.",
            messagedep="На станции речная\nведётся установка\nи наладка\nстанционных дверей.\n%rБудьте внимательны!\nНекоторые двери\nмогут быть закрыты.",
        },
        {
            116,"Речная","Rechnaya",
            arr = {"last_rechnaya"},
            arrlast = {"last_rechnaya"},
            dep = {nil,"next_oktyabrskaya"},
            odz = "odz2",
            right_doors=true,
        },
    },
})

Metrostroi.StationConfigurations = {
    [110] =
    {
        names = {"международная","Mezhdunarodnaya"},
        positions = {
            {Vector(2593, -622, 1815),Angle(0,0,0)},
        }
    },
    [111] =
    {
        names = {"парк культуры","Park Kultury"},
        positions = {
            {Vector(1969, 14608, 2200),Angle(0,0,0)},
        }
    },
    [112] =
    {
        names = {"политехническая","Politehnicheskaya"},
        positions = {
            {Vector(13975, 2474, 3000),Angle(0,0,0)},
        }
    },
    [113] =
    {
        names = {"проспект суворова","Prospekt Suvorova"},
        positions = {
            {Vector(2238, 6440, 1830),Angle(0,0,0)},
        }
    },
    [114] =
    {
        names = {"нахимовская","Nahimovskaya"},
        positions = {
            {Vector(9856, 374, 907),Angle(0,0,0)},
        }
    },
    [115] =
    {
        names = {"октябрьская","Oktyabrskaya"},
        positions = {
            {Vector(-161, -6652, -340),Angle(0,0,0)},
        }
    },
    [116] =
    {
        names = {"речная","Rechnaya"},
        positions = {
            {Vector(2877, -12828, 318),Angle(0,0,0)},
        }
    },
    [117] =
    {
        names = {"пролетарская","Proletarskaya"},
        positions = {
            {Vector(5190, -15872, -928),Angle(0,0,0)},
        }
    },
    [118] =
    {
        names = {"олимпийская","Olimpyiskaya"},
        positions = {
            {Vector(0, 0, -0),Angle(0,0,0)},
        }
    },

    [119] =
    {
        names = {"кировская","Kirovskaya"},
        positions = {
            {Vector(0, 0, 0),Angle(0,0,0)},
        }
    },

    [120] =
    {
        names = {"молодежная","Molodezjnaya"},
        positions = {
            {Vector(0, 0, 0),Angle(0,0,0)},
        }
    },
--------------------------------------------------------------
    --[[[201] =
    {
        names = {"политехническая","Politehnicheskaya"},
        positions = {
            {Vector(13975, 2474, 3000),Angle(0,0,0)},
        }
    },]]

    [202] =
    {
        names = {"пионерская","Pionerskaya"},
        positions = {
            {Vector(-13676, -3965, 3684),Angle(0,0,0)},
        }
    },

    [203] =
    {
        names = {"вокзальная","Vokzalnaya"},
        positions = {
            {Vector(2826, -11557, 4830),Angle(0,0,0)},
        }
    },

    [204] =
    {
        names = {"калининская","kalininskaya"},
        positions = {
            {Vector(0, 0, 0),Angle(0,0,0)},
        }
    },

    [205] =
    {
        names = {"тимирязевская","temiryazevskaya"},
        positions = {
            {Vector(0, 0, 0),Angle(0,0,0)},
        }
    },

    depot = {
        names = {"депо"},
        positions = {
            {Vector(3900, 2595, 250),Angle(0,0,0)},
        }
    }
}
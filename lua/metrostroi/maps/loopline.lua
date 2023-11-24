local Map = game.GetMap():lower() or ""

if Map:find("gm_mus_loop") then
    Metrostroi.PlatformMap = "loop"
    Metrostroi.CurrentMap = "gm_loop"
    Metrostroi.BogeyOldMap = true
else
    return
end
Metrostroi.AddLastStationTex("702",651,"models/metrostroi_schemes/destination_table_black/label_first_april")
Metrostroi.AddLastStationTex("702",654,"models/metrostroi_schemes/destination_table_black/label_marine")
Metrostroi.AddLastStationTex("702",655,"models/metrostroi_schemes/destination_table_black/label_glorious_country")
Metrostroi.AddLastStationTex("702",656,"models/metrostroi_schemes/destination_table_black/label_pioneer")
Metrostroi.AddLastStationTex("710",651,"models/metrostroi_schemes/destination_table_white/label_first_april")
Metrostroi.AddLastStationTex("710",654,"models/metrostroi_schemes/destination_table_white/label_marine")
Metrostroi.AddLastStationTex("710",655,"models/metrostroi_schemes/destination_table_white/label_glorious_country")
Metrostroi.AddLastStationTex("710",656,"models/metrostroi_schemes/destination_table_white/label_pioneer")
Metrostroi.AddLastStationTex("717",651,"models/metrostroi_schemes/destination_table_white/label_first_april")
Metrostroi.AddLastStationTex("717",654,"models/metrostroi_schemes/destination_table_white/label_marine")
Metrostroi.AddLastStationTex("717",655,"models/metrostroi_schemes/destination_table_white/label_glorious_country")
Metrostroi.AddLastStationTex("717",656,"models/metrostroi_schemes/destination_table_white/label_pioneer")
Metrostroi.AddLastStationTex("720",651,"models/metrostroi_schemes/destination_table_white/label_first_april")
Metrostroi.AddLastStationTex("720",654,"models/metrostroi_schemes/destination_table_white/label_marine")
Metrostroi.AddLastStationTex("720",655,"models/metrostroi_schemes/destination_table_white/label_glorious_country")
Metrostroi.AddLastStationTex("720",656,"models/metrostroi_schemes/destination_table_white/label_pioneer")

Metrostroi.AddPassSchemeTex("717_new","1 Line",{
    "models/metrostroi_schemes/mus_loopline",
})
Metrostroi.AddPassSchemeTex("720","Crossline",{
    "metrostroi_skins/81-720_schemes/loopliner",
    "metrostroi_skins/81-720_schemes/loopline",
})
Metrostroi.AddPassSchemeTex("722","Crossline",{
    "metrostroi_skins/81-722_schemes/loopliner",
    "metrostroi_skins/81-722_schemes/loopline",
})
Metrostroi.TickerAdverts = {
    "МЕТРОПОЛИТЕН ИМЕНИ ГАРРИ НЬЮМАНА ПРИГЛАШАЕТ НА РАБОТУ РЕАЛЬНЕ МАФЕНЕСТОВ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,ТЕЛЕФОН ДЛЯ СПРАВОК 8 (800) 555-35-35",
    "ЭЛЕКТРОДЕПО 'РАБА' ПРИГЛАШАЕТ НА РАБОТУ МОЙЩИКОВ",
    "В СВЯЗИ С ВВЕЕДЕНИЕМ ЭЛЕКТРОПОЕЗДОВ НОВОГО ПОКОЛЕНИЯ В ЭКСПЛУАТАЦИЮ, ЭЛЕКТРОДЕПО 'РАБА' ПРИГЛАШАЕТ НА РАБОТУ СЛЕСАРЕЙ ПОДИВЖНОГО СОСТАВА",
    "УПЦ МЕТРОПОЛИТЕНА ИМЕНИ ГАРРИ НЬЮМАНА ПРОВОДИТ НАБОР НА ОБУЧЕНИЕ ПО ПРОФЕССИИ 'МАШИНИСТ ЭЛЕКТРОПОЕЗДА'. ВО ВРЕМЯ ОБУЧЕНИЯ ВЫПЛАЧИВАЕТСЯ СТИПЕНДИЯ В РАЗМЕРЕ 10У.Е.,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,ТЕЛЕФОН ДЛЯ СПРАВОК 8 (800) 555-35-35",
    "СТАНЦИЯ СЛАВУТИЧ ПРИГЛАШАЕТ НА РАБОТУ МАШИНИСТОВ И ПОМОЩНИКОВ МАШИНИСТА ЭСКАЛАТОРА. ОПЛАТА 5 КУСОЧКОВ НОМЕРНОГО.",
    "ЭЛЕКТРОДЕПО ТЧ1АААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА",
}

Metrostroi.AddSarmatUPOAnnouncer("UPO RHINO",{
    name = "UPO RHINO",
    tone                      = {"subway_announcers/sarmat_upo/tone.mp3",1},
    last_morskaya = {"subway_announcers/sarmat_upo/rhino/loop/last_morskaya.mp3",9.735300},
    last_pervoaprelskaya = {"subway_announcers/sarmat_upo/rhino/loop/last_pervoaprelskaya.mp3",9.996300},
    last_pionerskaya = {"subway_announcers/sarmat_upo/rhino/loop/last_pionerskaya.mp3",9.865800},
    last_slavnaya_strana = {"subway_announcers/sarmat_upo/rhino/loop/last_slavnaya_strana.mp3",10.074600},
    metrostroiteley = {"subway_announcers/sarmat_upo/rhino/loop/metrostroiteley.mp3",1.070100},
    morskaya = {"subway_announcers/sarmat_upo/rhino/loop/morskaya.mp3",0.652500},
    next_metrostroiteley = {"subway_announcers/sarmat_upo/rhino/loop/next_metrostroiteley.mp3",2.088000},
    next_morskaya = {"subway_announcers/sarmat_upo/rhino/loop/next_morskaya.mp3",1.670400},
    next_park = {"subway_announcers/sarmat_upo/rhino/loop/next_park.mp3",1.487700},
    next_pervoaprelskaya = {"subway_announcers/sarmat_upo/rhino/loop/next_pervoaprelskaya.mp3",2.009700},
    next_pionerskaya = {"subway_announcers/sarmat_upo/rhino/loop/next_pionerskaya.mp3",1.879200},
    next_slavnaya_strana = {"subway_announcers/sarmat_upo/rhino/loop/next_slavnaya_strana.mp3",1.983600},
    odz1 = {"subway_announcers/sarmat_upo/rhino/loop/odz1.mp3",2.088000},
    odz2 = {"subway_announcers/sarmat_upo/rhino/loop/odz2.mp3",2.192400},
    park = {"subway_announcers/sarmat_upo/rhino/loop/park.mp3",0.469800},
    pervoaprelskaya = {"subway_announcers/sarmat_upo/rhino/loop/pervoaprelskaya.mp3",0.913500},
    pionerskaya = {"subway_announcers/sarmat_upo/rhino/loop/pionerskaya.mp3",0.809100},
    slavnaya_strana = {"subway_announcers/sarmat_upo/rhino/loop/slavnaya_strana.mp3",1.017900},
    spec_attention_handrails = {"subway_announcers/sarmat_upo/rhino/loop/spec_attention_handrails.mp3",3.967200},
    spec_attention_politeness = {"subway_announcers/sarmat_upo/rhino/loop/spec_attention_politeness.mp3",5.533200},
    spec_line4 = {"subway_announcers/sarmat_upo/rhino/loop/spec_line4.mp3",1.905300},
    spec_line5= {"subway_announcers/sarmat_upo/rhino/loop/spec_line5.mp3",1.748700},
},{
    {
        LED = {5,6,5,6,5,5},
        Name = "Line 1",
        Loop = true,
        {
            651,"Первоапрельская","First april",
            arr = {{"pervoaprelskaya",3,"next_park","spec_line4"},{"pervoaprelskaya",3,"next_pionerskaya","spec_line5",0.4,"spec_attention_handrails"}},
            dep = {"next_park","next_pionerskaya"},
            arrlast = {"last_pervoaprelskaya","last_pervoaprelskaya"},
            odz = "odz1",
        },
        {
            652,"Парк","Park",
            arr = {{"park",3,"next_metrostroiteley","spec_line5"},{"park",3,"next_pervoaprelskaya",0.4,"spec_attention_politeness"}},
            dep = {"next_metrostroiteley","next_pervoaprelskaya"},
            odz = "odz2",
        },
        {
            653,"Метростроителей","Metrostroiteley",
            arr = {{"metrostroiteley",3,"next_morskaya",0.4,"spec_attention_politeness"},{"metrostroiteley",3,"next_park","spec_line4"}},
            dep = {"next_morskaya","next_park"},
            odz = "odz1",
        },
        {
            654,"Морская","Marine",
            arr = {{"morskaya",3,"next_slavnaya_strana","spec_line4"},{"morskaya",3,"next_metrostroiteley","spec_line5"}},
            dep = {"next_slavnaya_strana","next_metrostroiteley"},
            arrlast = {"last_morskaya","last_morskaya"},
            odz = "odz2",
        },
        {
            655,"Славная стр.","Glorious c.",
            arr = {{"slavnaya_strana",3,"next_pionerskaya","spec_line5"},{"slavnaya_strana",3,"next_morskaya"}},
            dep = {"next_pionerskaya","next_morskaya"},
            arrlast = {"last_slavnaya_strana","last_slavnaya_strana"},
            odz = "odz2",
        },
        {
            656,"Пионерская","Pionerskaya",
            arr = {{"pionerskaya",3,"next_pervoaprelskaya",0.4,"spec_attention_handrails"},{"pionerskaya",3,"next_slavnaya_strana","spec_line4"}},
            dep = {"next_pervoaprelskaya","next_slavnaya_strana"},
            arrlast = {"last_pionerskaya","last_pionerskaya"},
            odz = "odz1",
        },
    }
})
Metrostroi.SetUPOAnnouncer({
    tone                      = {"subway_announcers/upo/rhino/loop/tone.mp3",1},
    click1 = {"subway_announcers/upo/click1.mp3", 0.3},
    click2 = {"subway_announcers/upo/click2.mp3", 0.1},
    odz = {"subway_announcers/upo/rhino/loop/odz.mp3",2.02},
    last_morskaya = {"subway_announcers/upo/rhino/loop/last_morskaya.mp3",9.735300},
    last_pervoaprelskaya = {"subway_announcers/upo/rhino/loop/last_pervoaprelskaya.mp3",9.996300},
    last_pionerskaya = {"subway_announcers/upo/rhino/loop/last_pionerskaya.mp3",9.865800},
    last_slavnaya_strana = {"subway_announcers/upo/rhino/loop/last_slavnaya_strana.mp3",10.074600},
    metrostroiteley = {"subway_announcers/upo/rhino/loop/metrostroiteley.mp3",1.070100},
    morskaya = {"subway_announcers/upo/rhino/loop/morskaya.mp3",0.652500},
    next_metrostroiteley = {"subway_announcers/upo/rhino/loop/next_metrostroiteley.mp3",2.088000},
    next_morskaya = {"subway_announcers/upo/rhino/loop/next_morskaya.mp3",1.670400},
    next_park = {"subway_announcers/upo/rhino/loop/next_park.mp3",1.487700},
    next_pervoaprelskaya = {"subway_announcers/upo/rhino/loop/next_pervoaprelskaya.mp3",2.009700},
    next_pionerskaya = {"subway_announcers/upo/rhino/loop/next_pionerskaya.mp3",1.879200},
    next_slavnaya_strana = {"subway_announcers/upo/rhino/loop/next_slavnaya_strana.mp3",1.983600},
    park = {"subway_announcers/upo/rhino/loop/park.mp3",0.469800},
    pervoaprelskaya = {"subway_announcers/upo/rhino/loop/pervoaprelskaya.mp3",0.913500},
    pionerskaya = {"subway_announcers/upo/rhino/loop/pionerskaya.mp3",0.809100},
    slavnaya_strana = {"subway_announcers/upo/rhino/loop/slavnaya_strana.mp3",1.017900},
    spec_attention_handrails = {"subway_announcers/upo/rhino/loop/spec_attention_handrails.mp3",3.967200},
    spec_attention_politeness = {"subway_announcers/upo/rhino/loop/spec_attention_politeness.mp3",5.533200},
    spec_line4 = {"subway_announcers/upo/rhino/loop/spec_line4.mp3",1.905300},
    spec_line5= {"subway_announcers/upo/rhino/loop/spec_line5.mp3",1.748700},
},{
    {
        651,"Первоапрельская","First april",
        arr = {{"pervoaprelskaya",0.5,"next_park","spec_line4"},{"pervoaprelskaya",0.5,"next_pionerskaya","spec_line5",0.4,"spec_attention_handrails"}},
        dep = {"odz","odz"},
        arrlast = {"last_pervoaprelskaya","last_pervoaprelskaya"},
        noises = {1,3},noiserandom = 0.3,
    },
    {
        652,"Парк","Park",
        arr = {{"park",0.5,"next_metrostroiteley","spec_line5"},{"park",0.5,"next_pervoaprelskaya",0.4,"spec_attention_politeness"}},
        dep = {"odz","odz"},
        noises = {2,3},noiserandom = 0.2,
    },
    {
        653,"Метростроителей","Metrostroiteley",
        arr = {{"metrostroiteley",0.5,"next_morskaya",0.4,"spec_attention_politeness"},{"metrostroiteley",0.5,"next_park","spec_line4"}},
        dep = {"odz","odz"},
        noises = {1,2},noiserandom = 0.6,
    },
    {
        654,"Морская","Marine",
        arr = {{"morskaya",0.5,"next_slavnaya_strana","spec_line4"},{"morskaya",0.5,"next_metrostroiteley","spec_line5"}},
        dep = {"odz","odz"},
        arrlast = {"last_morskaya","last_morskaya"},
        noises = {1},noiserandom = 0.5,
    },
    {
        655,"Славная стр.","Glorious country",
        arr = {{"slavnaya_strana",0.5,"next_pionerskaya","spec_line5"},{"slavnaya_strana",0.5,"next_morskaya"}},
        dep = {"odz","odz"},
        arrlast = {"last_slavnaya_strana","last_slavnaya_strana"},
        noises = {2,3},noiserandom = 0.2,
    },
    {
        656,"Пионерская","Pionerskaya",
        arr = {{"pionerskaya",0.5,"next_pervoaprelskaya",0.4,"spec_attention_handrails"},{"pionerskaya",0.5,"next_slavnaya_strana","spec_line4"}},
        dep = {"odz","odz"},
        arrlast = {"last_pionerskaya","last_pionerskaya"},
        noises = {1,2,3},noiserandom = 0.1,
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

    metrostroiteley_arr_m = {"subway_announcers/asnp/boiko_new/loopline/metrostroiteley_arr.mp3",3.264208},
    metrostroiteley_next_m = {"subway_announcers/asnp/boiko_new/loopline/metrostroiteley_next.mp3",1.291229},
    morskaya_m = {"subway_announcers/asnp/boiko_new/loopline/morskaya.mp3",1.085170},
    park_arr_m = {"subway_announcers/asnp/boiko_new/loopline/park_arr.mp3",2.638146},
    park_next_m = {"subway_announcers/asnp/boiko_new/loopline/park_next.mp3",0.624333},
    pervoaprelskaya_m = {"subway_announcers/asnp/boiko_new/loopline/pervoaprelskaya.mp3",1.186750},
    pionerskaya_arr_m = {"subway_announcers/asnp/boiko_new/loopline/pionerskaya_arr.mp3",2.980854},
    pionerskaya_next_m = {"subway_announcers/asnp/boiko_new/loopline/pionerskaya_next.mp3",1.035500},
    skip_park_m = {"subway_announcers/asnp/boiko_new/loopline/skip_park.mp3",5.091938},
    slavnaya_strana_arr_m = {"subway_announcers/asnp/boiko_new/loopline/slavnaya_strana_arr.mp3",3.270875},
    slavnaya_strana_next_m = {"subway_announcers/asnp/boiko_new/loopline/slavnaya_strana_next.mp3",1.365604},

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

    arr_metrostroiteley_f = {"subway_announcers/asnp/pyaseckaya/loopline/arr_metrostroiteley.mp3",4.936458},
    arr_morskaya_f = {"subway_announcers/asnp/pyaseckaya/loopline/arr_morskaya.mp3",1.874917},
    arr_park_f = {"subway_announcers/asnp/pyaseckaya/loopline/arr_park.mp3",3.602146},
    arr_pervoaprelskaya_f = {"subway_announcers/asnp/pyaseckaya/loopline/arr_pervoaprelskaya.mp3",2.208521},
    arr_pionerskaya_f = {"subway_announcers/asnp/pyaseckaya/loopline/arr_pionerskaya.mp3",4.471729},
    arr_slavnaya_strana_f = {"subway_announcers/asnp/pyaseckaya/loopline/arr_slavnaya_strana.mp3",4.996729},
    morskaya_f = {"subway_announcers/asnp/pyaseckaya/loopline/morskaya.mp3",0.992667},
    next_metrostroiteley_f = {"subway_announcers/asnp/pyaseckaya/loopline/next_metrostroiteley.mp3",3.245333},
    next_morskaya_f = {"subway_announcers/asnp/pyaseckaya/loopline/next_morskaya.mp3",2.688708},
    next_park_f = {"subway_announcers/asnp/pyaseckaya/loopline/next_park.mp3",2.285958},
    next_pervoaprelskaya_f = {"subway_announcers/asnp/pyaseckaya/loopline/next_pervoaprelskaya.mp3",2.868479},
    next_pionerskaya_f = {"subway_announcers/asnp/pyaseckaya/loopline/next_pionerskaya.mp3",3.003958},
    next_slavnaya_strana_f = {"subway_announcers/asnp/pyaseckaya/loopline/next_slavnaya_strana.mp3",3.037104},
    pervoaprelskaya_f = {"subway_announcers/asnp/pyaseckaya/loopline/pervoaprelskaya.mp3",1.389958},
    pionerskaya_f = {"subway_announcers/asnp/pyaseckaya/loopline/pionerskaya.mp3",1.220271},
    skip_park_f = {"subway_announcers/asnp/pyaseckaya/loopline/skip_park.mp3",5.944917},
    slavnaya_strana_f = {"subway_announcers/asnp/pyaseckaya/loopline/slavnaya_strana.mp3",1.532729},
    to_morskaya_f = {"subway_announcers/asnp/pyaseckaya/loopline/to_morskaya.mp3",3.279521},
    to_pervoaprelskaya_f = {"subway_announcers/asnp/pyaseckaya/loopline/to_pervoaprelskaya.mp3",3.481292},
    to_pionerskaya_f = {"subway_announcers/asnp/pyaseckaya/loopline/to_pionerskaya.mp3",3.558833},
    to_slavnaya_strana_f = {"subway_announcers/asnp/pyaseckaya/loopline/to_slavnaya_strana.mp3",3.839063},
},{
    {
        LED = {5,5,5,5,5,5},
        Name = "Line 1",
        Loop = true,
        BlockDoors = true,
        spec_last = {"last_m",0.5,"things_m"},
        spec_last_f = {"last_f",0.5,"things_f"},
        spec_wait = {{"train_stop_m"},{"train_depeat_m"}},
        spec_wait_f = {{"train_stop_f"},{"train_depeat_f"}},
        {
            651,"Первоапрельская","First april",
            arr = {{"station_m","pervoaprelskaya_m","skip_park_m"},"arr_pervoaprelskaya_f"},
            dep = {{"doors_closing_m","metrostroiteley_next_m"},{"doors_closing_f","next_pionerskaya_f"}},
            arrlast = {nil,{"arr_pervoaprelskaya_f",0.5,"last_f",2,"things_f",2,"deadlock_f"},"pervoaprelskaya_m"},
            not_last = {3,"train_goes_to_m","pervoaprelskaya_m"},
            not_last_f = {3,"to_pervoaprelskaya_f"},
            not_last_c = {nil, "not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
        },
        --[[{
            652,"Парк",
            arr = {{"station_m","park_arr_m",0.1,"things_m"},{"arr_park_f",0.1,"objects_f"}},
            dep = {{"doors_closing_m","metrostroiteley_next_m"},{"doors_closing_f","next_pervoaprelskaya_f"}},
            have_interchange = true,
        },]]
        {
            653,"Метростроителей","Metrostroiteley",
            arr = {{"station_m","metrostroiteley_arr_m",0.1,"objects_m"},{"arr_metrostroiteley_f","skip_park_f",0.1,"things_f"}},
            dep = {{"doors_closing_m","morskaya_m"},{"doors_closing_f","next_pervoaprelskaya_f"}},
            not_last_c = {nil, "not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
            have_interchange = true,
        },
        {
            654,"Морская","Marine",
            arr = {{"station_m","morskaya_m"},"arr_morskaya_f"},
            dep = {{"doors_closing_m","slavnaya_strana_next_m"},{"doors_closing_f","next_metrostroiteley_f",0.1,"politeness_f"}},
            arrlast = {{"station_m","morskaya_m",0.5,"last_m",2,"things_m",2,"deadlock_m"},nil,"morskaya_m"},
            not_last = {3,"train_goes_to_m","morskaya_m"},
            not_last_f = {3,"to_morskaya_f"},
            not_last_c = {nil, "not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
        },
        {
            655,"Славная стр.","Glorious c.",
            arr = {{"station_m","slavnaya_strana_arr_m"},{"arr_slavnaya_strana_f",0.1,"exit_f"}},
            dep = {{"doors_closing_m","pionerskaya_next_m"},{"doors_closing_f","next_morskaya_f"}},
            arrlast = {nil,{"arr_slavnaya_strana_f",0.5,"last_f",2,"things_f",2,"deadlock_f"},"slavnaya_strana_next_m"},
            not_last = {3,"train_goes_to_m","slavnaya_strana_next_m"},
            not_last_f = {3,"to_slavnaya_strana_f"},
            not_last_c = {nil, "not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
            have_interchange = true,
        },
        {
            656,"Пионерская","Pionerskaya",
            arr = {{"station_m","pionerskaya_arr_m",0.1,"exit_m"},"arr_pionerskaya_f"},
            dep = {{"doors_closing_m","pervoaprelskaya_m"},{"doors_closing_f","next_slavnaya_strana_f"}},
            arrlast = {{"station_m","pionerskaya_arr_m",0.5,"last_m",2,"things_m",2,"deadlock_m"},{"arr_pionerskaya_f",0.5,"last_f",2,"things_f",2,"deadlock_f"},"pionerskaya_next_m"},
            not_last = {3,"train_goes_to_m","pionerskaya_next_m"},
            not_last_f = {3,"to_pionerskaya_f"},
            not_last_c = {nil, "not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
            have_interchange = true,
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

    metrostroiteley_arr_m = {"subway_announcers/riu/boiko_new/loopline/metrostroiteley_arr.mp3",3.434036},
    metrostroiteley_next_m = {"subway_announcers/riu/boiko_new/loopline/metrostroiteley_next.mp3",1.434036},
    morskaya_m = {"subway_announcers/riu/boiko_new/loopline/morskaya.mp3",0.983447},
    park_arr_m = {"subway_announcers/riu/boiko_new/loopline/park_arr.mp3",3.144943},
    park_next_m = {"subway_announcers/riu/boiko_new/loopline/park_next.mp3",0.794512},
    pervoaprelskaya_m = {"subway_announcers/riu/boiko_new/loopline/pervoaprelskaya.mp3",1.457211},
    pionerskaya_arr_m = {"subway_announcers/riu/boiko_new/loopline/pionerskaya_arr.mp3",3.234785},
    pionerskaya_next_m = {"subway_announcers/riu/boiko_new/loopline/pionerskaya_next.mp3",1.112290},
    skip_park_m = {"subway_announcers/riu/boiko_new/loopline/skip_park.mp3",5.925646},
    slavnaya_strana_arr_m = {"subway_announcers/riu/boiko_new/loopline/slavnaya_strana_arr.mp3",3.821610},
    slavnaya_strana_next_m = {"subway_announcers/riu/boiko_new/loopline/slavnaya_strana_next.mp3",1.592494},

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

    arr_metrostroiteley_f = {"subway_announcers/riu/pyaseckaya/loopline/arr_metrostroiteley.mp3",5.278526},
    arr_morskaya_f = {"subway_announcers/riu/pyaseckaya/loopline/arr_morskaya.mp3",1.893469},
    arr_park_f = {"subway_announcers/riu/pyaseckaya/loopline/arr_park.mp3",3.770590},
    arr_pervoaprelskaya_f = {"subway_announcers/riu/pyaseckaya/loopline/arr_pervoaprelskaya.mp3",2.302834},
    arr_pionerskaya_f = {"subway_announcers/riu/pyaseckaya/loopline/arr_pionerskaya.mp3",4.670862},
    arr_slavnaya_strana_f = {"subway_announcers/riu/pyaseckaya/loopline/arr_slavnaya_strana.mp3",5.182018},
    morskaya_f = {"subway_announcers/riu/pyaseckaya/loopline/morskaya.mp3",0.973741},
    next_metrostroiteley_f = {"subway_announcers/riu/pyaseckaya/loopline/next_metrostroiteley.mp3",3.265329},
    next_morskaya_f = {"subway_announcers/riu/pyaseckaya/loopline/next_morskaya.mp3",2.726259},
    next_park_f = {"subway_announcers/riu/pyaseckaya/loopline/next_park.mp3",2.282200},
    next_pervoaprelskaya_f = {"subway_announcers/riu/pyaseckaya/loopline/next_pervoaprelskaya.mp3",3.040998},
    next_pionerskaya_f = {"subway_announcers/riu/pyaseckaya/loopline/next_pionerskaya.mp3",3.051043},
    next_slavnaya_strana_f = {"subway_announcers/riu/pyaseckaya/loopline/next_slavnaya_strana.mp3",3.010068},
    pervoaprelskaya_f = {"subway_announcers/riu/pyaseckaya/loopline/pervoaprelskaya.mp3",1.402902},
    pionerskaya_f = {"subway_announcers/riu/pyaseckaya/loopline/pionerskaya.mp3",1.130952},
    skip_park_f = {"subway_announcers/riu/pyaseckaya/loopline/skip_park.mp3",5.990408},
    slavnaya_strana_f = {"subway_announcers/riu/pyaseckaya/loopline/slavnaya_strana.mp3",1.504286},
    to_morskaya_f = {"subway_announcers/riu/pyaseckaya/loopline/to_morskaya.mp3",3.354150},
    to_pervoaprelskaya_f = {"subway_announcers/riu/pyaseckaya/loopline/to_pervoaprelskaya.mp3",3.599660},
    to_pionerskaya_f = {"subway_announcers/riu/pyaseckaya/loopline/to_pionerskaya.mp3",3.646735},
    to_slavnaya_strana_f = {"subway_announcers/riu/pyaseckaya/loopline/to_slavnaya_strana.mp3",3.939138},
},{
    {
        LED = {5,5,5,5,5,5},
        Name = "Line 1",
        Loop = true,
        BlockDoors = true,
        spec_last = {"last_m",0.5,"things_m"},
        spec_last_f = {"last_f",0.5,"things_f"},
        spec_wait = {{"train_stop_m"},{"train_depeat_m"}},
        spec_wait_f = {{"train_stop_f"},{"train_depeat_f"}},
        {
            651,"Первоапрельская","First april",
            arr = {{"station_m","pervoaprelskaya_m","skip_park_m"},"arr_pervoaprelskaya_f"},
            dep = {{"doors_closing_m","metrostroiteley_next_m"},{"doors_closing_f","next_pionerskaya_f"}},
            arrlast = {nil,{"arr_pervoaprelskaya_f",0.5,"last_f",2,"things_f",2,"deadlock_f"},"pervoaprelskaya_m"},
            not_last = {3,"train_goes_to_m","pervoaprelskaya_m"},
            not_last_f = {3,"to_pervoaprelskaya_f"},
            not_last_c = {nil, "not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
        },
        --[[{
            652,"Парк",
            arr = {{"station_m","park_arr_m",0.1,"things_m"},{"arr_park_f",0.1,"objects_f"}},
            dep = {{"doors_closing_m","metrostroiteley_next_m"},{"doors_closing_f","next_pervoaprelskaya_f"}},
            have_interchange = true,
        },]]
        {
            653,"Метростроителей","Metrostroiteley",
            arr = {{"station_m","metrostroiteley_arr_m",0.1,"objects_m"},{"arr_metrostroiteley_f","skip_park_f",0.1,"things_f"}},
            dep = {{"doors_closing_m","morskaya_m"},{"doors_closing_f","next_pervoaprelskaya_f"}},
            not_last_c = {nil, "not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
            have_interchange = true,
        },
        {
            654,"Морская","Marine",
            arr = {{"station_m","morskaya_m"},"arr_morskaya_f"},
            dep = {{"doors_closing_m","slavnaya_strana_next_m"},{"doors_closing_f","next_metrostroiteley_f",0.1,"politeness_f"}},
            arrlast = {{"station_m","morskaya_m",0.5,"last_m",2,"things_m",2,"deadlock_m"},nil,"morskaya_m"},
            not_last = {3,"train_goes_to_m","morskaya_m"},
            not_last_f = {3,"to_morskaya_f"},
            not_last_c = {nil, "not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
        },
        {
            655,"Славная стр.","Glorious c.",
            arr = {{"station_m","slavnaya_strana_arr_m"},{"arr_slavnaya_strana_f",0.1,"exit_f"}},
            dep = {{"doors_closing_m","pionerskaya_next_m"},{"doors_closing_f","next_morskaya_f"}},
            arrlast = {nil,{"arr_slavnaya_strana_f",0.5,"last_f",2,"things_f",2,"deadlock_f"},"slavnaya_strana_next_m"},
            not_last = {3,"train_goes_to_m","slavnaya_strana_next_m"},
            not_last_f = {3,"to_slavnaya_strana_f"},
            not_last_c = {nil, "not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
            have_interchange = true,
        },
        {
            656,"Пионерская","Pionerskaya",
            arr = {{"station_m","pionerskaya_arr_m",0.1,"exit_m"},"arr_pionerskaya_f"},
            dep = {{"doors_closing_m","pervoaprelskaya_m"},{"doors_closing_f","next_slavnaya_strana_f"}},
            arrlast = {{"station_m","pionerskaya_arr_m",0.5,"last_m",2,"things_m",2,"deadlock_m"},{"arr_pionerskaya_f",0.5,"last_f",2,"things_f",2,"deadlock_f"},"pionerskaya_next_m"},
            not_last = {3,"train_goes_to_m","pionerskaya_next_m"},
            not_last_f = {3,"to_pionerskaya_f"},
            not_last_c = {nil, "not_last_f"},spec_last_c = {nil,"spec_last_f"}, spec_wait_c = {nil,"spec_wait_f"},
            have_interchange = true,
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

    arr_metrostroiteley = {"subway_announcers/rri/boiko/loopline/arr_metrostroiteley.mp3",4.055533},
    arr_morskaya = {"subway_announcers/rri/boiko/loopline/arr_morskaya.mp3",2.024943},
    arr_park = {"subway_announcers/rri/boiko/loopline/arr_park.mp3",3.762721},
    arr_pervoaprelskaya = {"subway_announcers/rri/boiko/loopline/arr_pervoaprelskaya.mp3",2.368798},
    arr_pionerskaya = {"subway_announcers/rri/boiko/loopline/arr_pionerskaya.mp3",4.074036},
    arr_slavnaya_strana = {"subway_announcers/rri/boiko/loopline/arr_slavnaya_strana.mp3",4.395465},
    next_metrostroiteley = {"subway_announcers/rri/boiko/loopline/next_metrostroiteley.mp3",4.841429},
    next_morskaya = {"subway_announcers/rri/boiko/loopline/next_morskaya.mp3",4.846440},
    next_park = {"subway_announcers/rri/boiko/loopline/next_park.mp3",5.244014},
    next_pervoaprelskaya = {"subway_announcers/rri/boiko/loopline/next_pervoaprelskaya.mp3",5.477551},
    next_pionerskaya = {"subway_announcers/rri/boiko/loopline/next_pionerskaya.mp3",5.424694},
    next_slavnaya_strana = {"subway_announcers/rri/boiko/loopline/next_slavnaya_strana.mp3",5.635828},
    skip_park = {"subway_announcers/rri/boiko/loopline/skip_park.mp3",5.650794},
    to_morskaya = {"subway_announcers/rri/boiko/loopline/to_morskaya.mp3",4.707687},
    to_pervoaprelskaya = {"subway_announcers/rri/boiko/loopline/to_pervoaprelskaya.mp3",5.230794},
    to_pionerskaya = {"subway_announcers/rri/boiko/loopline/to_pionerskaya.mp3",4.834286},
    to_slavnaya_strana = {"subway_announcers/rri/boiko/loopline/to_slavnaya_strana.mp3",5.505760},
},{
    {
        LED = {5,5,5,5,5,5},
        Loop = true,
        Name = "Line 1",
        spec_last = {"last"},
        spec_wait = {{"train_stop"},{"train_depeat"}},
        {
            651,"Первоапрельская","First april",
            arr = {{"arr_pervoaprelskaya","skip_park"},"arr_pervoaprelskaya"},
            dep = {{"next_metrostroiteley"},{"next_pionerskaya"}},
            arrlast = {nil,{"arr_pervoaprelskaya",0.5,"last",2,"things",2,"deadlock"}},
            not_last = {3,"to_pervoaprelskaya"},
        },
        {
            653,"Метростроителей","Metrostroiteley",
            arr = {{"arr_metrostroiteley",0.1,"objects"},{"arr_metrostroiteley","skip_park",0.1,"things"}},
            dep = {{"next_morskaya"},{"next_pervoaprelskaya"}},
            have_interchange = true,
        },
        {
            654,"Морская","Marine",
            arr = {{"arr_morskaya"},"arr_morskaya"},
            dep = {{"next_slavnaya_strana"},{"next_metrostroiteley",0.1,"politeness"}},
            arrlast = {{"morskaya",0.5,"last",2,"things",2,"deadlock"}},
            not_last = {3,"to_morskaya"},
        },
        {
            655,"Славная стр.","Glorious c.",
            arr = {{"arr_slavnaya_strana"},{"arr_slavnaya_strana",0.1,"exit"}},
            dep = {{"next_pionerskaya"},{"next_morskaya"}},
            arrlast = {nil,{"arr_slavnaya_strana",0.5,"last",2,"things",2,"deadlock"}},
            not_last = {3,"to_slavnaya_strana"},
            have_interchange = true,
        },
        {
            656,"Пионерская","Pionerskaya",
            arr = {{"arr_pionerskaya",0.1,"exit"},"arr_pionerskaya"},
            dep = {{"next_pervoaprelskaya"},{"next_slavnaya_strana"}},
            arrlast = {{"arr_pionerskaya",0.5,"last",2,"things",2,"deadlock"},{"arr_pionerskaya",0.5,"last",2,"things",2,"deadlock"}},
            not_last = {3,"to_pionerskaya"},
            have_interchange = true,
        },
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
    [651]  = {
        names = {"первоапрельская","First april"},
        positions = {
            {Vector(-1655,-390,-497),Angle(0,0,0)},
        },
    },
    [652]  = {
        names = {"парк","Park"},
        positions = {
            {Vector(2675,10622,-1004),Angle(0,0,0)},
        },
    },
    [653]  = {
        names = {"метростроителей","Metrostroiteley","Metrobuilder station"},
        positions = {
            {Vector(3544,-8880,-2034),Angle(0,0,0)},
        },
    },
    [654]  = {
        names = {"морская","Marine"},
        positions = {
            {Vector(14950, 4282, -5105),Angle(0,0,0)},
        },
    },
    [655]  = {
        names = {"славная страна","Glorious country"},
        positions = {
            {Vector(-10223,3444,-3057.97),Angle(0,0,0)},
        },
    },
    [656]  = {
        names = {"пионерская","Pionerskaya","Pioneer station"},
        positions = {
            {Vector(-15200,7954,-1010),Angle(0,0,0)},
        },
    },
    depot = {
        names = {"Депо","депо"},
        positions = {
            {Vector(-9315,-8450,918),Angle(0,0,0)},
        }
    },
    pto = {
        names = {"пто","ПТО"},
        positions = {
            {Vector(-4539,5624,-4597),Angle(0,0,0)},
        }
    }
}

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
        Name = "Линия 1",
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
            655,"Славная стр.","Glorious country",
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


Metrostroi.AddANSPAnnouncer("ASNP MakichOS", {
    click1 = {"subway_announcers/asnp/click.mp3", 0.3},
    click2 = {"subway_announcers/asnp/click2.mp3", 0.1},
    last = {"subway_announcers/asnp/makich/last.mp3", 20.358000},
    odz = {"subway_announcers/asnp/makich/odz.mp3", 2.427300},
    spec_attention_exit = {"subway_announcers/asnp/makich/spec_attention_exit.mp3", 5.220000},
    spec_attention_last = {"subway_announcers/asnp/makich/spec_attention_last.mp3", 5.063400},
    spec_attention_objects = {"subway_announcers/asnp/makich/spec_attention_objects.mp3", 4.176000},
    spec_attention_politeness = {"subway_announcers/asnp/makich/spec_attention_politeness.mp3", 8.952300},
    spec_attention_things = {"subway_announcers/asnp/makich/spec_attention_things.mp3", 4.698000},
    spec_attention_train_depeat = {"subway_announcers/asnp/makich/spec_attention_train_depeat.mp3", 4.332600},
    spec_attention_train_stop = {"subway_announcers/asnp/makich/spec_attention_train_stop.mp3", 5.246100},
    train_goes_to = {"subway_announcers/asnp/makich/train_goes_to.mp3", 2.322900},
    arr_metrostroiteley = {"subway_announcers/asnp/makich/loopline/arr_metrostroiteley.mp3", 3.993300},
    arr_morskaya = {"subway_announcers/asnp/makich/loopline/arr_morskaya.mp3", 1.696500},
    arr_park = {"subway_announcers/asnp/makich/loopline/arr_park.mp3", 3.680100},
    arr_pervoaprelskaya = {"subway_announcers/asnp/makich/loopline/arr_pervoaprelskaya.mp3", 2.035800},
    arr_pionerskaya = {"subway_announcers/asnp/makich/loopline/arr_pionerskaya.mp3", 3.810600},
    arr_slavnaya_strana = {"subway_announcers/asnp/makich/loopline/arr_slavnaya_strana.mp3", 4.410900},
    morskaya = {"subway_announcers/asnp/makich/loopline/morskaya.mp3", 0.887400},
    next_metrostroiteley = {"subway_announcers/asnp/makich/loopline/next_metrostroiteley.mp3", 2.871000},
    next_morskaya = {"subway_announcers/asnp/makich/loopline/next_morskaya.mp3", 2.192400},
    next_park = {"subway_announcers/asnp/makich/loopline/next_park.mp3", 2.061900},
    next_pervoaprelskaya = {"subway_announcers/asnp/makich/loopline/next_pervoaprelskaya.mp3", 2.662200},
    next_pionerskaya = {"subway_announcers/asnp/makich/loopline/next_pionerskaya.mp3", 2.505600},
    next_slavnaya_strana = {"subway_announcers/asnp/makich/loopline/next_slavnaya_strana.mp3", 2.818800},
    pervoaprelskaya = {"subway_announcers/asnp/makich/loopline/pervoaprelskaya.mp3", 1.226700},
    pionerskaya = {"subway_announcers/asnp/makich/loopline/pionerskaya.mp3", 0.991800},
    slavnaya_strana = {"subway_announcers/asnp/makich/loopline/slavnaya_strana.mp3", 1.305000},
},{
    {
        LED = {5,5,5,5,5,5},
        Name = "Линия 1",
        Loop = true,
        spec_last = {"spec_attention_last",0.5,"spec_attention_things"},
        spec_wait = {{"spec_attention_train_stop"},{"spec_attention_train_depeat"}},
        {
            651,"Первоапрельская",
            arr = {"arr_pervoaprelskaya","arr_pervoaprelskaya"},
            dep = {{"odz","next_park"},{"odz","next_pionerskaya"}},
            arrlast = {nil,{"arr_pervoaprelskaya",0.5,"last"},"pervoaprelskaya"},
            not_last = {3,"train_goes_to","pervoaprelskaya"},
        },
        {
            652,"Парк",
            arr = {{"arr_park",0.1,"spec_attention_things"},{"arr_park",0.1,"spec_attention_objects"}},
            dep = {{"odz","next_metrostroiteley"},{"odz","next_pervoaprelskaya"}},
            have_inrerchange = true,
        },
        {
            653,"Метростроителей",
            arr = {{"arr_metrostroiteley",0.1,"spec_attention_objects"},{"arr_metrostroiteley",0.1,"spec_attention_things"}},
            dep = {{"odz","next_morskaya"},{"odz","next_park"}},
            have_inrerchange = true,
        },
        {
            654,"Морская",
            arr = {"arr_morskaya","arr_morskaya"},
            dep = {{"odz","next_slavnaya_strana"},{"odz","next_metrostroiteley",0.1,"spec_attention_politeness"}},
            arrlast = {{"arr_morskaya",0.5,"last"},nil,"morskaya"},
            not_last = {3,"train_goes_to","morskaya"},
        },
        {
            655,"Славная стр.",
            arr = {"arr_slavnaya_strana",{"arr_slavnaya_strana",0.1,"spec_attention_exit"}},
            dep = {{"odz","next_pionerskaya"},{"odz","next_morskaya"}},
            arrlast = {nil,{"arr_slavnaya_strana",0.5,"last"},"slavnaya_strana"},
            not_last = {3,"train_goes_to","slavnaya_strana"},
            have_inrerchange = true,
        },
        {
            656,"Пионерская",
            arr = {{"arr_pionerskaya",0.1,"spec_attention_exit"},"arr_pionerskaya"},
            dep = {{"odz","next_pervoaprelskaya"},{"odz","next_slavnaya_strana"}},
            arrlast = {{"arr_pionerskaya",0.5,"last"},{"arr_pionerskaya",0.5,"last"},"pionerskaya"},
            not_last = {3,"train_goes_to","pionerskaya"},
            have_inrerchange = true,
        },
    },
})
Metrostroi.AddANSPAnnouncer("ASNP MakichOS + Concord En", {
    click1 = {"subway_announcers/asnp/click.mp3", 0.3},
    click2 = {"subway_announcers/asnp/click2.mp3", 0.1},
    last = {"subway_announcers/asnp/makich/last.mp3", 20.358000},
    odz = {"subway_announcers/asnp/makich/odz.mp3", 2.427300},
    spec_attention_exit = {"subway_announcers/asnp/makich/spec_attention_exit.mp3", 5.220000},
    spec_attention_last = {"subway_announcers/asnp/makich/spec_attention_last.mp3", 5.063400},
    spec_attention_objects = {"subway_announcers/asnp/makich/spec_attention_objects.mp3", 4.176000},
    spec_attention_politeness = {"subway_announcers/asnp/makich/spec_attention_politeness.mp3", 8.952300},
    spec_attention_things = {"subway_announcers/asnp/makich/spec_attention_things.mp3", 4.698000},
    spec_attention_train_depeat = {"subway_announcers/asnp/makich/spec_attention_train_depeat.mp3", 4.332600},
    spec_attention_train_stop = {"subway_announcers/asnp/makich/spec_attention_train_stop.mp3", 5.246100},
    train_goes_to = {"subway_announcers/asnp/makich/train_goes_to.mp3", 2.322900},
    arr_metrostroiteley = {"subway_announcers/asnp/makich/loopline/arr_metrostroiteley.mp3", 3.993300},
    arr_morskaya = {"subway_announcers/asnp/makich/loopline/arr_morskaya.mp3", 1.696500},
    arr_park = {"subway_announcers/asnp/makich/loopline/arr_park.mp3", 3.680100},
    arr_pervoaprelskaya = {"subway_announcers/asnp/makich/loopline/arr_pervoaprelskaya.mp3", 2.035800},
    arr_pionerskaya = {"subway_announcers/asnp/makich/loopline/arr_pionerskaya.mp3", 3.810600},
    arr_slavnaya_strana = {"subway_announcers/asnp/makich/loopline/arr_slavnaya_strana.mp3", 4.410900},
    morskaya = {"subway_announcers/asnp/makich/loopline/morskaya.mp3", 0.887400},
    next_metrostroiteley = {"subway_announcers/asnp/makich/loopline/next_metrostroiteley.mp3", 2.871000},
    next_morskaya = {"subway_announcers/asnp/makich/loopline/next_morskaya.mp3", 2.192400},
    next_park = {"subway_announcers/asnp/makich/loopline/next_park.mp3", 2.061900},
    next_pervoaprelskaya = {"subway_announcers/asnp/makich/loopline/next_pervoaprelskaya.mp3", 2.662200},
    next_pionerskaya = {"subway_announcers/asnp/makich/loopline/next_pionerskaya.mp3", 2.505600},
    next_slavnaya_strana = {"subway_announcers/asnp/makich/loopline/next_slavnaya_strana.mp3", 2.818800},
    pervoaprelskaya = {"subway_announcers/asnp/makich/loopline/pervoaprelskaya.mp3", 1.226700},
    pionerskaya = {"subway_announcers/asnp/makich/loopline/pionerskaya.mp3", 0.991800},
    slavnaya_strana = {"subway_announcers/asnp/makich/loopline/slavnaya_strana.mp3", 1.305000},

    arr_metrostroiteley_en = {"subway_announcers/asnp/english/loopline/arr_metrostroiteley.mp3",4.179200},
    arr_morskaya_en = {"subway_announcers/asnp/english/loopline/arr_morskaya.mp3",1.725800},
    arr_morskaya_last_en = {"subway_announcers/asnp/english/loopline/arr_morskaya_last.mp3",3.839900},
    arr_park_en = {"subway_announcers/asnp/english/loopline/arr_park.mp3",3.709400},
    arr_park_last_en = {"subway_announcers/asnp/english/loopline/arr_park_last.mp3",5.797400},
    arr_pervoaprelskaya_en = {"subway_announcers/asnp/english/loopline/arr_pervoaprelskaya.mp3",2.039000},
    arr_pervoaprelskaya_last_en = {"subway_announcers/asnp/english/loopline/arr_pervoaprelskaya_last.mp3",4.127000},
    arr_pionerskaya_en = {"subway_announcers/asnp/english/loopline/arr_pionerskaya.mp3",3.839900},
    arr_pionerskaya_last_en = {"subway_announcers/asnp/english/loopline/arr_pionerskaya_last.mp3",5.927900},
    arr_slavnaya_strana_en = {"subway_announcers/asnp/english/loopline/arr_slavnaya_strana.mp3",4.466300},
    arr_slavnaya_strana_last_en = {"subway_announcers/asnp/english/loopline/arr_slavnaya_strana_last.mp3",6.554300},
    next_metrostroiteley_en = {"subway_announcers/asnp/english/loopline/next_metrostroiteley.mp3",2.926400},
    next_morskaya_en = {"subway_announcers/asnp/english/loopline/next_morskaya.mp3",2.482700},
    next_park_en = {"subway_announcers/asnp/english/loopline/next_park.mp3",2.169500},
    next_pervoaprelskaya_en = {"subway_announcers/asnp/english/loopline/next_pervoaprelskaya.mp3",2.769800},
    next_pionerskaya_en = {"subway_announcers/asnp/english/loopline/next_pionerskaya.mp3",2.587100},
    next_slavnaya_strana_en = {"subway_announcers/asnp/english/loopline/next_slavnaya_strana.mp3",2.926400},
},{
    {
        LED = {5,5,5,5,5,5},
        Name = "Линия 1",
        Loop = true,
        spec_last = {"spec_attention_last",0.5,"spec_attention_things"},
        spec_wait = {{"spec_attention_train_stop"},{"spec_attention_train_depeat"}},
        {
            651,"Первоапрельская",
            arr = {{"arr_pervoaprelskaya","arr_pervoaprelskaya_en"},{"arr_pervoaprelskaya","arr_pervoaprelskaya_en"}},
            dep = {{"odz","next_park","next_park_en"},{"odz","next_pionerskaya","next_pionerskaya_en"}},
            arrlast = {nil,{"arr_pervoaprelskaya","arr_pervoaprelskaya_en",0.5,"last"},"pervoaprelskaya"},
            not_last = {3,"train_goes_to","pervoaprelskaya"},
        },
        {
            652,"Парк",
            arr = {{"arr_park","arr_park_en",0.1,"spec_attention_things"},{"arr_park","arr_park_en",0.1,"spec_attention_objects"}},
            dep = {{"odz","next_metrostroiteley","next_metrostroiteley_en"},{"odz","next_pervoaprelskaya","next_pervoaprelskaya_en"}},
            have_inrerchange = true,
        },
        {
            653,"Метростроителей",
            arr = {{"arr_metrostroiteley","arr_metrostroiteley_en",0.1,"spec_attention_objects"},{"arr_metrostroiteley","arr_metrostroiteley_en",0.1,"spec_attention_things"}},
            dep = {{"odz","next_morskaya","next_morskaya_en"},{"odz","next_park","next_park_en"}},
            have_inrerchange = true,
        },
        {
            654,"Морская",
            arr = {{"arr_morskaya","arr_morskaya_en"},{"arr_morskaya","arr_morskaya_en"}},
            dep = {{"odz","next_slavnaya_strana","next_slavnaya_strana_en"},{"odz","next_metrostroiteley","next_metrostroiteley_en",0.1,"spec_attention_politeness"}},
            arrlast = {{"arr_morskaya","arr_morskaya_en",0.5,"last"},nil,"morskaya"},
            not_last = {3,"train_goes_to","morskaya"},
        },
        {
            655,"Славная стр.",
            arr = {{"arr_slavnaya_strana","arr_slavnaya_strana_en"},{"arr_slavnaya_strana","arr_slavnaya_strana_en",0.1,"spec_attention_exit"}},
            dep = {{"odz","next_pionerskaya","next_pionerskaya_en"},{"odz","next_morskaya","next_morskaya_en"}},
            arrlast = {nil,{"arr_slavnaya_strana","arr_slavnaya_strana_en",0.5,"last"},"slavnaya_strana"},
            not_last = {3,"train_goes_to","slavnaya_strana"},
            have_inrerchange = true,
        },
        {
            656,"Пионерская",
            arr = {{"arr_pionerskaya","arr_pionerskaya_en",0.1,"spec_attention_exit"},{"arr_pionerskaya","arr_pionerskaya_en"}},
            dep = {{"odz","next_pervoaprelskaya","next_pervoaprelskaya_en"},{"odz","next_slavnaya_strana","next_slavnaya_strana_en"}},
            arrlast = {{"arr_pionerskaya","arr_pionerskaya_en",0.5,"last"},{"arr_pionerskaya","arr_pionerskaya_en",0.5,"last"},"pionerskaya"},
            not_last = {3,"train_goes_to","pionerskaya"},
            have_inrerchange = true,
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
        pto = {"пто","ПТО"},
        positions = {
            {Vector(-4539,5624,-4597),Angle(0,0,0)},
        }
    }
}
local Map = game.GetMap():lower() or ""

if Map:find("gm_metrostroi") and Map:find("lite") then
    Metrostroi.PlatformMap = "metrostroi"
    Metrostroi.CurrentMap = "gm_metrostroi_lite"
    Metrostroi.BogeyOldMap = true
else
    return
end

--[НОМЕР] = {НАЗВАНИЕ,ПРАВАЯ СТОРОНА,ВЕЖЛИВОСТЬ,ВЕЩИ,ПРИСЛНОЯТЬСЯ К ДВЕРЯМ,ИМЕЕТ В НАЗВАНИИ "СТАНЦИЯ",СТАНЦИЯ ПЕРЕХОДА,СТАНЦИЯ РАЗДЕЛЕНИЯ,НЕ КОНЕЧНАЯ(развернуть информатор)}
Metrostroi.AnnouncerData =
{
    [108] = {"Avtozavodskaya",                  false,false,false ,false ,false,0   },
    [109] = {"Industrial'naya",                     false,false ,false,true  ,false,0   },
    [110] = {"Moskovskaya",                     true ,true,false   ,false,false,0   },
    [111] = {"Oktyabrs'kaya",                   false,false,1       ,false,false,0   },
    [112] = {"Ploschad' Myra",                  false,false,false ,true ,false,0   },
    [113] = {"Novoarmeyskaya",              false,true ,0       ,false,false,0   },
    [114] = {"Vokzalnaya",                      false,false,1       ,false,false,0   },
}
Metrostroi.AnnouncerTranslate = {
    [108] = "Автозаводская",
    [109] = "Индустриальная",
    [110] = "Московская",
    [111] = "Октябрьская",
    [112] = "Площадь мира",
    [113] = "Новоармейская",
    [114] = "Вокзальная",
}

Metrostroi.WorkingStations = {
    {108,109,110,111,112,113,114},
}
Metrostroi.EndStations = {
    {108,111,114},
}
Metrostroi.Skins["717_schemes"]["p"] = {
    adv = "metrostroi_skins/81-717_schemes/int_b50_spb_adv",
    clean = "metrostroi_skins/81-717_schemes/int_b50_spb_clean",
}
Metrostroi.Skins["717_schemes"]["m"] = {
    adv = "metrostroi_skins/81-717_schemes/int_b50_msk_adv",
    clean = "metrostroi_skins/81-717_schemes/int_b50_msk_noadv",
}

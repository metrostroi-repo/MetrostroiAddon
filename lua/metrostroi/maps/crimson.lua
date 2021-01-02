local Map = game.GetMap():lower() or ""

if Map:find("gm_mus_crimson") and not Map:find("tox") then
	Metrostroi.PlatformMap = "crimson"
	Metrostroi.CurrentMap = "gm_orange_crimson"
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

Metrostroi.AnnouncementsSarmatUPO = {
	{
		name = "UPO RHINO",
		tone                      = {"subway_announcers/sarmat_upo/tone.mp3",1},
    aeroport = {"subway_announcers/sarmat_upo/rhino/crimson/aeroport.mp3",0.835200},
    brateevo = {"subway_announcers/sarmat_upo/rhino/crimson/brateevo.mp3",0.730800},
    fauna = {"subway_announcers/sarmat_upo/rhino/crimson/fauna.mp3",0.652500},
    last_pionerskaya = {"subway_announcers/sarmat_upo/rhino/crimson/last_pionerskaya.mp3",9.865800},
    metrostroiteley = {"subway_announcers/sarmat_upo/rhino/crimson/metrostroiteley.mp3",1.070100},
    next_aeroport = {"subway_announcers/sarmat_upo/rhino/crimson/next_aeroport.mp3",1.879200},
    next_brateevo = {"subway_announcers/sarmat_upo/rhino/crimson/next_brateevo.mp3",1.774800},
    next_fauna = {"subway_announcers/sarmat_upo/rhino/crimson/next_fauna.mp3",1.592100},
    next_metrostroiteley = {"subway_announcers/sarmat_upo/rhino/crimson/next_metrostroiteley.mp3",2.088000},
    next_pionerskaya = {"subway_announcers/sarmat_upo/rhino/crimson/next_pionerskaya.mp3",3.210300},
    next_pionerskaya1 = {"subway_announcers/sarmat_upo/rhino/crimson/next_pionerskaya1.mp3",1.879200},
    next_stalinskaya = {"subway_announcers/sarmat_upo/rhino/crimson/next_stalinskaya.mp3",1.748700},
    odz1 = {"subway_announcers/sarmat_upo/rhino/crimson/odz1.mp3",2.088000},
    odz2 = {"subway_announcers/sarmat_upo/rhino/crimson/odz2.mp3",2.192400},
    spec_attention_handrails = {"subway_announcers/sarmat_upo/rhino/crimson/spec_attention_handrails.mp3",3.967200},
    spec_attention_politeness = {"subway_announcers/sarmat_upo/rhino/crimson/spec_attention_politeness.mp3",5.533200},
    spec_line3 = {"subway_announcers/sarmat_upo/rhino/crimson/spec_line3.mp3",1.957500},
    stalinskaya = {"subway_announcers/sarmat_upo/rhino/crimson/stalinskaya.mp3",0.835200},
  }
}

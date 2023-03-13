return [[
#Base text for Hungarian language

[hu]
lang        = Magyar                         #Full language name
AuthorText  = Fordítók: Xenox, Lackó      #Author text

#Workshop errors
Workshop.Title              = Tartalom kezelő
Workshop.FilesMissing       = Néhány kiegészítő fájl hiányzik, vagy hibás.\nHa a Műhelyből lett(ek) telepítve, próbáld meg kitörölni ezt a fájlt:\nGarrysMod/garrysmod/%s.
Workshop.FilesMissingLocaly = Néhány kiegészítő fájl hiányzik, vagy hibás.
Workshop.InstalledLocaly    = Telepített (helyi)
Workshop.NotInstalledE      = Nem telepített.\nIratkozz fel a kiegészítőre, és ellenőrizd a "Bővítmények" menüben.
Workshop.NotInstalled       = Nem telepített.
Workshop.Disabled           = Kikapcsolt.\nKapcsold be az "Bővítmények" menüben.
Workshop.Installed          = Telepített
Workshop.Open               = Műhely
Workshop.ErrorGithub        = A Metrostroi GitHub verziója észlelhető. A jelenlegi Metrostroi verzió nem kompatibilis és nem működik a GitHub-os verzióval.
Workshop.ErrorLegacy        = A Metrostroi egyik régi verziója észlelhető. A jelenlegi Metrostroi verzió nem kompatibilis és nem működik a régi verzióval.
Workshop.ErrorEnhancers     = Ez a kiegészítő grafikus javításokat tartalmaz, amelyek esetleg ronthatják a játékélményt.
Workshop.Error1             = Ez a kiegészítő a Metrostroi régi szkriptjeit tartalmazza, amelyek zavarhatják a jelenlegieket. "Szkript hiba" és instabil működés léphet föl.
Workshop.ErrorOld           = Régi modellek észlelhetők (81-702 és 81-717 régi modelljei). Ellenőrizd és töröld a régi Metrostroi fájlokat, távolítsd el a "cache", "download" és "downloads" mappákat a "garrysmod" könyvtárból.

#Client settings
Panel.Admin             = Admin
Panel.RequireThirdRail  = Harmadik sín szükséges

Panel.Client            = Kliens
Panel.Language          = Nyelv választás
Panel.DrawCams          = Kamerák renderelése
Panel.DisableHUD        = HUD kikapcsolása a vezető ülésben
Panel.DisableCamAccel   = Kamera gyorsítás kikapcsolása
Panel.DisableHoverText  = Felvillanó szövegek kikapcsolása
Panel.DisableHoverTextP = Disable additional information\nin tooltips #NEW
Panel.DisableSeatShadows= Disable seat shadows #NEW
Panel.ScreenshotMode    = Képernyőmentés mód (ALACSONY FPS)
Panel.ShadowsHeadlight  = Fényszóró árnyékok bekapcsolása
Panel.RedLights         = \nZárjelző lámpák dinamikus fényének bekapcsolása
Panel.ShadowsOther      = \nEgyéb forrásokból származó árnyékok bekapcsolása
Panel.MinimizedShow     = Ne töltse be az elemeket, \nha a program tálcán van
Panel.FOV               = FOV
Panel.Z                 = Kamera magassága
Panel.RenderDistance    = Renderelési távolság
Panel.RenderSignals     = Traced signals #NEW #FIXME
Panel.ReloadClient      = Kliens oldal újraindítása

Panel.ClientAdvanced    = Kliens (haladó)
Panel.DrawDebugInfo     = Debug információk megjelenítése
Panel.DrawSignalDebugInfo     = Jelzők debug információi
Panel.CheckAddons       = Kiegészítők keresése
Panel.ReloadLang        = Nyelvek újratöltése
Panel.SoftDraw          = Vonatelemek betöltési ideje
Panel.SoftReloadLang    = Ne töltsön be új spawnmenü-t



#Common train
Train.Common.Camera0        = Vezető ülés
Train.Common.RouteNumber    = Forgalmi szám
Train.Common.LastStation    = Végállomás
Train.Common.HelpersPanel   = Segédvezetői panel
Train.Common.UAVA           = UAVA
Train.Common.PneumoPanels   = Pneumatikus szelepek
Train.Common.Voltmeters     = Volt- és ampermérők
Train.Common.CouplerCamera  = Csatlás
Common.ARM.Monitor1         = Monitor 1 ARM
Train.Buttons.Sealed        = Leplombált

#Train entities
Entities.gmod_subway_base.Name        = Metrókocsi alap
Entities.gmod_subway_81-502.Name      = 81-502 (Ema-502 vezér)
Entities.gmod_subway_81-501.Name      = 81-501 (Em-501 közbenső)
Entities.gmod_subway_81-702.Name      = 81-702 (D vezér)
Entities.gmod_subway_81-702_int.Name  = 81-702 (D közbenső)
Entities.gmod_subway_81-703.Name      = 81-703 (E vezér)
Entities.gmod_subway_81-703_int.Name  = 81-703 (E közbenső)
Entities.gmod_subway_ezh.Name         = 81-707 (Ezh vezér)
Entities.gmod_subway_ezh1.Name        = 81-708 (Ezh1 közbenső)
Entities.gmod_subway_ezh3.Name        = 81-710 (Ezh3 vezér)
Entities.gmod_subway_em508t.Name      = 81-508T (Em-508T közbenső)
Entities.gmod_subway_81-717_mvm.Name  = 81-717 (Moszkvai vezér)
Entities.gmod_subway_81-717_mvm_custom.Name     = 81-717 (Moszkvai egyedi)
Entities.gmod_subway_81-714_mvm.Name  = 81-714 (Moszkvai közbenső)
Entities.gmod_subway_81-717_lvz.Name  = 81-717 (Szentpétervári vezér)
Entities.gmod_subway_81-714_lvz.Name  = 81-714 (Szentpétervári közbenső)
Entities.gmod_subway_81-718.Name      = 81-718 (TISU vezér)
Entities.gmod_subway_81-719.Name      = 81-719 (TISU közbenső)
Entities.gmod_subway_81-720.Name      = 81-720 (Yauza vezér)
Entities.gmod_subway_81-721.Name      = 81-721 (Yauza közbenső)
Entities.gmod_subway_81-722.Name      = 81-722 (Yubileyniy vezér)
Entities.gmod_subway_81-723.Name      = 81-723 (Yubileyniy közbenső)
Entities.gmod_subway_81-724.Name      = 81-724 (Yubileyniy szabadonfutó)
Entities.gmod_subway_81-7036.Name     = 81-7036 (nem működik)
Entities.gmod_subway_81-7037.Name     = 81-7037 (nem működik)
Entities.gmod_subway_tatra_t3.Name    = Tátra T3

#Train util entities
Entities.gmod_train_bogey.Name        = Forgóváz
Entities.gmod_train_couple.Name       = Csatlás

#Other entities
Entities.gmod_track_pui.Name                = PUI
Entities.gmod_track_mus_elektronika7.Name   = "Electronika" óra
Entities.gmod_mus_clock_analog.Name         = Analóg óra
Entities.gmod_track_clock_time.Name         = Nagy térköz óra (idő)
Entities.gmod_track_clock_small.Name        = Kicsi térköz óra
Entities.gmod_track_clock_interval.Name     = Nagy térköz óra (térköz)
Entities.gmod_track_switch.Name             = Váltó
Entities.gmod_track_powermeter.Name         = Feszültségmérő
Entities.gmod_track_arm.Name                = ARM DSCP
Entities.gmod_track_udochka.Name            = Áram csatlakozó
Entities.gmod_train_spawner.Name            = Vonat lehelyező
Entities.gmod_train_special_box.Name        = Speciális csomag

#Weapons
Weapons.button_presser.Name                 = Gombnyomó
Weapons.button_presser.Purpose              = Pályákon lévő gombok megnyomására.
Weapons.button_presser.Instructions         = Mutass a megnyomandó gombra, majd kattints az "Támadás" gombra.
Weapons.train_key.Name                      = Adminisztrátori kulcs
Weapons.train_key.Purpose                   = Pályákon levő adminisztrátori gombok megnyomására.
Weapons.train_key.Instructions              = Mutass az adminisztrátori gombra, majd kattints az "Támadás" gombra.
Weapons.train_kv_wrench.Name                = Irányváltó kulcs
Weapons.train_kv_wrench.Purpose             = Metrókocsikban található gombok megnyomására való.
Weapons.train_kv_wrench.Instructions        = Mutass a megnyomandó gombra a vonatban, majd kattints az "Támadás" gombra.
Weapons.train_kv_wrench_gold.Name           = Az arany irányváltó kulcs

Weapons.train_kv_wrench_gold.Purpose        = @[Weapons.train_kv_wrench.Purpose]
Weapons.train_kv_wrench_gold.Instructions   = @[Weapons.train_kv_wrench.Instructions]

#Spawner common
Spawner.Title                           = Vonat lehelyező
Spawner.Spawn                           = Lehelyezés
Spawner.Close                           = Bezárás
Spawner.Trains1                         = Megengedett kocsik száma
Spawner.Trains2                         = Játékosonként
Spawner.WagNum                          = Kocsik száma
Spawner.PresetTitle                     = Szettek
Spawner.Preset.New                      = Új szett
Spawner.Preset.Unsaved                  = Jelenlegi szett mentése
Spawner.Preset.NewTooltip               = Létrehozás
Spawner.Preset.UpdateTooltip            = Frissítés
Spawner.Preset.RemoveTooltip            = Törlés
Spawner.Presets.NamePlaceholder         = Szett neve
Spawner.Presets.Name                    = Név
Spawner.Presets.NameError               = Érvénytelen név
Spawner.Preset.NotSelected              = Nincs szett kiválasztva
Common.Spawner.Texture                  = Külső festés
Common.Spawner.PassTexture              = Belső festés
Common.Spawner.CabTexture               = Fülke festés
Common.Spawner.Announcer                = Utastájékoztató típusa
Common.Spawner.Type1                    = 1-es típus
Common.Spawner.Type2                    = 2-es típus
Common.Spawner.Type3                    = 3-es típus
Common.Spawner.Type4                    = 4-es típus
Common.Spawner.SpawnMode                = Lehelyezési állapot
Common.Spawner.SpawnMode.Deadlock       = Kihúzó
Common.Spawner.SpawnMode.Full           = Üzemkész
Common.Spawner.SpawnMode.NightDeadlock  = Kihúzó, éjszaka után
Common.Spawner.SpawnMode.Depot          = Kikapcsolt
Spawner.Common.EType                    = Elektromos áramkörök típusa
Common.Spawner.Scheme                   = Vonal sémák
Common.Spawner.Random                   = Random
Common.Spawner.Old                      = Régi
Common.Spawner.New                      = Új
Common.Spawner.Type                     = Típus
Common.Spawner.SchemeInvert             = Fordított vonal sémák

#Coupler common
Common.Couple.Title         = Csatlás menü
Common.Couple.CoupleState   = Csatlás állapota
Common.Couple.Coupled       = Csatolva
Common.Couple.Uncoupled     = Nem csatolt
Common.Couple.Uncouple      = Szétcsatol
Common.Couple.IsolState     = Végelzáró csapok állapota
Common.Couple.Isolated      = Zárt
Common.Couple.Opened        = Nyitott
Common.Couple.Open          = Nyitva
Common.Couple.Isolate       = Zárva
Common.Couple.EKKState      = EKK állapota (elektromos csatlás)
Common.Couple.Disconnected  = Lecsatlakozva
Common.Couple.Connected     = Csatlakozva
Common.Couple.Connect       = Összeköt
Common.Couple.Disconnect    = Szétkapcsol

#Bogey common
Common.Bogey.Title              = Forgóváz menü
Common.Bogey.ContactState       = Áremszedők állapota
Common.Bogey.CReleased          = Kiengedve
Common.Bogey.CPressed           = Lenyomva
Common.Bogey.CPress             = Lenyomás
Common.Bogey.CRelease           = Elengedés
Common.Bogey.ParkingBrakeState  = Rögzítőfék állapota
Common.Bogey.PBDisabled         = Manuálisan kikapcsolva
Common.Bogey.PBEnabled          = Bekapcsolt
Common.Bogey.PBEnable           = Bekapcsol
Common.Bogey.PBDisable          = Manuális kikapcsolás

#Trains common
Common.ALL.Unsused1                         = Nem használt
Common.ALL.Unsused2                         = (Nem használt)
Common.ALL.Up                               = (fel)
Common.ALL.Down                             = (le)
Common.ALL.Left                             = (bal)
Common.ALL.Right                            = (jobb)
Common.ALL.CW                               = (óramutató járásával megegyezően)
Common.ALL.CCW                              = (óramutató járásával ellentétesen)
Common.ALL.VB                               = VB: Akkumulátor be/ki
Common.ALL.VSOSD                            = SOSD: Peronajtó nyitás lámpa
Common.ALL.VKF                              = VKF: Zárjelző lámpák áramellátása
Common.ALL.VB2                              = (Alacsony feszültségű áramkörök)
Common.ALL.VPR                              = VPR: Fedélzeti rádióállomás 
Common.ALL.VASNP                            = ASNP áramellátása
Common.ALL.UOS                              = RC-UOS: Sebességkorlátozó eszköz (EPV/EPK nélküli vezetéshez)
Common.ALL.VAH                              = VAH: Szükségmenet(RPB relé hiba) 
Common.ALL.KAH                              = KAH: Szükségmenet gombja ARS nélküli vezetéshez
Common.ALL.KAHK                             = KAH fedél
Common.ALL.VAD                              = VAD: Tartalék ajtózárás felülírása (KD relé meghibásodása esetén) 
Common.ALL.OVT                              = OVT: Pneumatikus fékek kikapcsolása
Common.ALL.VOVT                             = VOVT: Pneumatikus szelepfék kikapcsolása
Common.ALL.EmergencyBrakeValve              = Vészfék
Common.ALL.ParkingBrake                     = Rögzítőfék
Common.ALL.VU                               = VU: Vonatvezérlés kapcsoló
Common.ALL.KDP                              = KDP: Jobb oldali ajtók nyitása
Common.ALL.KDPL                             = Jobb oldali ajtók kiválasztva
Common.ALL.KDPK                             = Jobb oldali ajtók gombfedele
Common.ALL.KDL                              = KDL: Bal oldali ajtók nyitása
Common.ALL.KDLL                             = Bal oldali ajtók kiválasztva
Common.ALL.KDLK                             = Bal oldali ajtók gombfedele
Common.ALL.KDLPK                            = Ajtó gombok fedele
Common.ALL.KRZD                             = KRZD: Tartalék ajtózáró
Common.ALL.VSD                              = Ajtó oldal választó
Common.ALL.Ring                             = Csengő
Common.ALL.VUD                              = VUD: Ajtónyitás engedélyező (Ajtózáró)
Common.ALL.KDPH                             = Utolsó kocsi jobb oldali ajtajainak nyitása
Common.ALL.VUD2                             = VUD2: Segédvezetői ajtónyitás engedélyező
Common.ALL.Program1                         = Program I
Common.ALL.Program2                         = Program II
Common.ALL.VRP                              = VRP: Túlfeszültség relé visszaállítása
Common.ALL.VRPBV                            = VRP: Túlfeszültség relé visszaállítása, BV bekapcsolása
Common.ALL.KSN                              = KSN: Hibajelzés
Common.ALL.VMK                              = VMK: Kompresszor
Common.ALL.MK                               = Kompresszor
Common.ALL.VF1                              = Tompított fényszóró
Common.ALL.VF2                              = Távolsági fényszóró
Common.ALL.VF                               = Fényszóró kapcsoló
Common.ALL.VUS                              = VUS: Fényszórók (távolsági/tompított)
Common.ALL.GaugeLights                      = Műszerek világítása
Common.ALL.CabLights                        = Fülkevilágítás
Common.ALL.PassLights                       = Utastér világítás
Common.ALL.PanelLights                      = Műszerfal világítása
Common.ALL.RMK                              = RMK: Tartalék kompresszor
Common.ALL.KRP                              = KRP: Szükségindító
Common.ALL.VZP                              = VZP: Menet késleltetés kikapcsolása
Common.ALL.VZD                              = VZD: Ajtó késleltetés kikapcsolása
Common.ALL.VAV                              = VAV: Automatikus vonatvezérlés kapcsoló
Common.ALL.RouteNumber1+                    = Forgalmi szám első karakterének növelése
Common.ALL.RouteNumber1-                    = Forgalmi szám első karakterének csökkentése
Common.ALL.RouteNumber2+                    = Forgalmi szám második karakterének növelése
Common.ALL.RouteNumber2-                    = Forgalmi szám második karakterének csökkentése
Common.ALL.RouteNumber3+                    = Forgalmi szám harmadik karakterének növelése
Common.ALL.RouteNumber3-                    = Forgalmi szám harmadik karakterének csökkentése
Common.ALL.LastStation+                     = Következő végállomás
Common.ALL.LastStation-                     = Előző végállomás
Common.ALL.RRP                              = RP: Vörös túlfeszültség relé visszajelző (menet-/fékáram nem alakult ki)
Common.ALL.GRP                              = RP: Zöld túlfeszültség relé visszajelző (megakadályozza a motorok túláramát)
Common.ALL.RP                               = RP: Vörös túlfeszültség relé visszajelző (menet-/fékáram nem alakult ki vagy RP-s)
Common.ALL.SN                               = LSN: Hiba visszajelző lámpa (áramkörök nem működnek)
Common.ALL.PU                               = Csökkentett feszültségű mód visszajelző
Common.ALL.BrT                              = Vonat légfék üzemben
Common.ALL.BrW                              = Kocsi légfék üzemben
Common.ALL.ARS                              = ARS: Automatikus sebességszabályozó rendszer kapcsoló
Common.ALL.ARSR                             = ARS-R: Automatikus sebességszabályozó rendszer ARS-R mód kapcsoló
Common.ALL.ALS                              = ALS: Automatikus vonat jeladás
Common.ALL.RCARS                            = RC-ARS: ARS áramköreinek lekapcsolása
Common.ALL.RC1                              = RC-1: ARS áramköreinek lekapcsolása
Common.ALL.EPK                              = ARS elektropneumatikus szelep (EPK)
Common.ALL.EPV                              = ARS elektropneumatikus szelep (EPV)
Common.ARS.LN                               = LN: Irányjelző
Common.ARS.KT                               = KT: Fék visszajelző lámpa
Common.ARS.VD                               = VD: Vezérlés kikapcsolva ARS által
Common.ARS.Freq                             = ALS dekóder kapcsoló
Common.ARS.FreqD                            = (fel 1/5, le 2/6)
Common.ARS.FreqU                            = (fel 2/6, le 1/5)
Common.ARS.VP                               = "Tartalék vonat" mód
Common.ARS.RS                               = RS: Sebesség egyenlőség (a következő szakasz sebességkorlátozása egyenlő vagy gyorsabb az aktuális értéknél)
Common.ARS.AB                               = ARS Automatikus blokkolás mód
Common.ARS.ABButton                         = ARS Automatikus blokkolás mód gomb
Common.ARS.ABDriver                         = (vezetői)
Common.ARS.ABHelper                         = (segédvezetői)
Common.ARS.AV                               = Elsődleges ARS-MP egység hiba
Common.ARS.AV1                              = Tartalék ARS-MP egység hiba 
Common.ARS.AB2                              = Automatikus blokkolás mód gomb
Common.ARS.ARS                              = ARS mód
Common.ARS.LRD                              = LRD: Mozgatás engedély (ALS 0-ás jelzés esetén)
Common.ARS.VRD                              = VRD: Mozgatás engedély(ALS 0-ás jelzés esetén)
Common.ARS.KB                               = KB: Éberségi gomb/pedál
Common.ARS.KVT                              = KVT: Féknyugtázó gomb
Common.ARS.KVTR                             = KVT: ARS-R féknyugtázó gomb
Common.ARS.04                               = OCh: Nincs ARS frekvencia
Common.ARS.N4                               = NCh: Nincs ARS frekvencia
Common.ARS.0                                = 0: ARS stop jelzés
Common.ARS.40                               = Maximum megengedett sebesség 40 km/h
Common.ARS.60                               = Maximum megengedett sebesség 60 km/h
Common.ARS.70                               = Maximum megengedett sebesség 70 km/h
Common.ARS.80                               = Maximum megengedett sebesség 80 km/h
Common.ALL.RCBPS                            = RC-BPS: Megfutamodás elleni egység kapcsoló
Common.BPS.On                               = Megfutamodás elleni egység üzem
Common.BPS.Err                              = Megfutamodás elleni egység hiba
Common.BPS.Fail                             = Megfutamodás elleni egység meghibásodás
Commom.NMnUAVA.NMPressureLow                = Alacsony légvezetéki nyomás visszajelző
Commom.NMnUAVA.UAVATriggered                = UAVA kiiktatva
Common.ALL.LSD                              = Vonat ajtó állapot visszajelző (ajtók zárva)
Common.ALL.L1w                              = Első vezeték visszajelző (menet mód)
Common.ALL.L2w                              = Második vezeték visszajelző (reosztát kontroller mozgás)
Common.ALL.L6w                              = Hatodik vezeték visszajelző (fék mód)
Common.ALL.Horn                             = Kürt
Common.ALL.DriverValveBLDisconnect          = Fékvezeték elzáró csap
Common.ALL.DriverValveTLDisconnect          = Töltővezeték elzáró csap
Common.ALL.DriverValveDisconnect            = Légfék elzáró csap
Common.ALL.KRMH                             = KRMSH: Légfék vészeseti bekapcsoló
Common.ALL.RVTB                             = RVTB: Biztonsági fék szelep
Common.ALL.FrontBrakeLineIsolationToggle    = Fékvezeték elzáró csap
Common.ALL.FrontTrainLineIsolationToggle    = Töltővezeték elzáró csap
Common.ALL.RearTrainLineIsolationToggle     = Töltővezeték elzáró csap
Common.ALL.RearBrakeLineIsolationToggle     = Fékvezeték elzáró csap
Common.ALL.UAVA                             = UAVA: Automatikus autostop kikapcsoló\n(légvezetéki nyomás csökkentése esetén)
Common.ALL.UAVA2                            = UAVA: Automatikus autostop kikapcsoló
Common.ALL.UAVAContact                      = UAVA kontakt reset
Common.ALL.OAVU                             = OAVU: AVU kikapcsolása
Common.ALL.LAVU                             = AVU bekapcsolva
Common.ALL.GV                               = Főkapcsoló
Common.ALL.AirDistributor                   = VRN: Levegőelosztó megszakító
Common.ALL.CabinDoor                        = Fülkeajtó
Common.ALL.PassDoor                         = Ajtó az utastérbe
Common.ALL.FrontDoor                        = Átjáróajtó
Common.ALL.RearDoor                         = Átjáróajtó
Common.ALL.OtsekDoor1                       = Első hátfalszekrény nyitó fogantyú
Common.ALL.OtsekDoor2                       = Második hátfalszekrény nyitó fogantyú
Common.ALL.CouchCap                         = Ülés kiemelése

Common.ALL.UNCh                             = UNCh: Alacsony frekvenciás erősítő kapcsoló
Common.ALL.ES                               = ES: Vészhelyzeti kommunikációs kapcsoló
Common.ALL.GCab                             = Hangszóró: Kabinhangszóró kapcsoló
Common.ALL.UPO                              = UPO: Utastájékoztató
Common.ALL.R_Radio                          = Utastájékoztató
Common.ALL.AnnPlay                          = Utastájékoztató visszajelző lámpa

#RRI
Train.Common.RRI                            = RRI: Rádió-relé utastájékoztató
Common.RRI.RRIUp                            = RRI: Fel
Common.RRI.RRIDown                          = RRI: Le
Common.RRI.RRILeft                          = RRI: Balra
Common.RRI.RRIRight                         = RRI: Jobbra
Common.RRI.RRIEnableToggle                  = RRI: Áramellátás
Common.RRI.RRIRewindSet2                    = RRI: Előretekerés
Common.RRI.RRIRewindSet0                    = RRI: Visszatekerés
Common.RRI.RRIAmplifierToggle               = RRI: Erősítő
Common.RRI.RRIOn                            = RRI üzem visszajelző

#ASNP
Train.Common.ASNP           = ASNP
Common.ASNP.ASNPMenu        = ASNP: Menü
Common.ASNP.ASNPUp          = ASNP: Fel
Common.ASNP.ASNPDown        = ASNP: Le
Common.ASNP.ASNPOn          = ASNP: Áramellátás

#PVK
Common.CabVent.PVK-         = Fülkeszellőztetés erejének csökkentése
Common.CabVent.PVK+         = Fülkeszellőztetés erejének növelése

#IGLA
Train.Common.IGLA           = IGLA
Common.IGLA.Button1Up       = IGLA: Első gomb fel
Common.IGLA.Button1         = IGLA: Első gomb
Common.IGLA.Button1Down     = IGLA: Első gomb le
Common.IGLA.Button2Up       = IGLA: Második gomb fel
Common.IGLA.Button2         = IGLA: Második gomb
Common.IGLA.Button2Down     = IGLA: Második gomb le
Common.IGLA.Button23        = IGLA: Második és Harmadik gomb
Common.IGLA.Button3         = IGLA: Harmadik gomb
Common.IGLA.Button4         = IGLA: Negyedik gomb
Common.IGLA.IGLASR          = IGLA: Áramellátás
Common.IGLA.IGLARX          = IGLA: Nincs kapcsolat
Common.IGLA.IGLAErr         = IGLA: Hiba
Common.IGLA.IGLAOSP         = IGLA: Tűzoltó rendszer üzemben
Common.IGLA.IGLAPI          = IGLA: Tűz
Common.IGLA.IGLAOff         = IGLA: Nagyfeszültségű áramkörök ki

#BZOS
Common.BZOS.On      = Riasztó kapcsoló
Common.BZOS.VH1     = Riasztó bekapcsolva
Common.BZOS.VH2     = Riasztó kioldva
Common.BZOS.Engaged = Riasztó kioldva

#Train helpers common
Common.ALL.SpeedCurr        = Jelenlegi sebesség
Common.ALL.SpeedAccept      = Megengedett sebesség
Common.ALL.SpeedAttent      = Következő szakasz megengedett sebesség
Common.ALL.Speedometer      = Sebességmérő
Common.ALL.BLTLPressure     = Nyomás a légvezetékekben (piros: fékvezeték, fekete: töltővezeték)
Common.ALL.BCPressure       = Fékhenger nyomás
Common.ALL.EnginesCurrent   = Motor áramerősség (A)
Common.ALL.EnginesCurrent1  = Első vontatómotorok áramerőssége (A)
Common.ALL.EnginesCurrent2  = Második vontatómotorok áramerőssége (A)
Common.ALL.EnginesVoltage   = Motor feszültség (kV)
Common.ALL.BatteryVoltage   = Akkumulátor feszültség (V)
Common.ALL.BatteryCurrent   = Akkumulátor áramerősség (A)
Common.ALL.HighVoltage      = Magasfeszültség (kV)
]]
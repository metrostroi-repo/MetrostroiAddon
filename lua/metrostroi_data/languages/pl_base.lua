return [[
#Base text for Polish languagę

[pl]
lang        = Polski                            #Full language name
AuthorText  = Autor przekładu: Elkm             #Author text

#Workshop errors
Workshop.Title              = Menadżer addonów
Workshop.FilesMissing       = Brakuje niektórych plików addonu lub addon uszkodzony\nJeśli addon został zainstalowany za pośrednictwem Workshopu, spróbuj usunąć plik:\nGarrysMod/garrysmod/%s.
Workshop.FilesMissingLocaly = Brakuje niektórych plików addonu lub addon uszkodzny.
Workshop.InstalledLocaly    = Zainstalowany (lokalnie)
Workshop.NotInstalledE      = Niezainstalowany.\nZasubskrybuj addon i sprawdź go w menu "Addony".
Workshop.NotInstalled       = Niezainstalowany.
Workshop.Disabled           = Wyłączony.\nWłącz go w menu "Addony".
Workshop.Installed          = Zainstalowany.
Workshop.Open               = Workshop
Workshop.ErrorGithub        = Znaleziona wersja GitHub modu Metrostroi - jest ona niekompatybilna z wersją Legacy.
Workshop.ErrorLegacy        = Znaleziona wersja Legacy modu Metrostroi - jest ona niekompatybilna z wersją GitHub.
Workshop.ErrorEnhancers     = This addon contain a graphic enhancers that may interfere comfortable game.
Workshop.Error1             = Ten addon zawiera stary kod modu Metrostroi, który nie jest kompatybilny z zainstalowanym. Mogą pojawić się "Script errors" i zachodzić niestabilność addonu.
Workshop.ErrorOld           = Old models detected (81-702 and 81-717 old models). Check and remove old metrostroi content files, remove cache, download and downloads folders from garrysmod folder.

#Client settings
Panel.Admin             = Admin
Panel.RequireThirdRail  = Wymagaj trzeciej szyny

Panel.Client            = Klient
Panel.Language          = Wybierz język
Panel.DrawCams          = Renderuj obraz z kamer
Panel.DisableHUD        = Wyłącz HUD na miejscu maszynisty
Panel.DisableCamAccel   = Wyłącz ruch kamery (wrażenie przyspieszenia)
Panel.DisableHoverText  = Wyłącz podpowiedzi przycisków
Panel.DisableHoverTextP = Disable additional information\nin tooltips #NEW #FIXME
Panel.DisableSeatShadows= Disable seat shadows #NEW #FIXME
Panel.ScreenshotMode    = Tryb fotografii (NISKI FPS!)
Panel.ShadowsHeadlight  = Włącz dynamiczne cienie (lampy)
Panel.RedLights         = Enable dynamic light\nof red lights
Panel.ShadowsOther      = Włącz dynamiczne cienie (inne źródła)
Panel.MinimizedShow     = Nie zwalniaj zasobów podczas minimalizacji
Panel.PanelLights       = Enable dynamic lights\nfrom control panel lamps #NEW
Panel.RouteNumber       = Route number #NEW
Panel.FOV               = FOV (pole widzenia)
Panel.Z                 = Camera height #NEW
Panel.RenderDistance    = Odległość rysowania
Panel.RenderSignals     = Traced signals #NEW #FIXME
Panel.ReloadClient      = Przeładuj zasoby (klient)

Panel.ClientAdvanced    = Klient (zaawansowane)
Panel.DrawDebugInfo     = Pokaż dodatkowe informacje (debug)
Panel.DrawSignalDebugInfo     = Signalling debug info #FIXME
Panel.CheckAddons       = Przeskanuj addony
Panel.ReloadLang        = Przeładuj języki
Panel.SoftDraw          = Opóźnienie między rysowaniami
Panel.SoftReloadLang    = Nie przeładowywuj spawnmenu



#Common train

#Cameras
Train.Common.Camera0        = Miejsce maszynisty
Train.Common.RouteNumber    = Numer brygady
Train.Common.LastStation    = Stacja końcowa
Train.Common.HelpersPanel   = Panel pomocnika maszynisty
Train.Common.UAVA           = UAVA #FIXME
Train.Common.PneumoPanels   = Pneumatic valves #FIXME
Train.Common.Voltmeters     = Voltmeters and amperemeters #FIXME
Train.Common.CouplerCamera  = Coupler #FIXME
Common.ARM.Monitor1         = Monitor ARM 1

Train.Buttons.Sealed        = Zaplombowane
Train.Buttons.Active        = Active #NEW
Train.Buttons.Auto          = Auto #NEW
Train.Buttons.On            = On #NEW
Train.Buttons.Off           = Off #NEW
Train.Buttons.Closed        = Closed #NEW
Train.Buttons.Opened        = Opened #NEW
Train.Buttons.Disconnected  = Disconnected #NEW
Train.Buttons.Connected     = Connected #NEW
Train.Buttons.UAVAOff       = Control circuits is open #NEW (OFF)
Train.Buttons.UAVAOn        = Control circuits is closed #NEW (ON)
Train.Buttons.Freq1/5       = 1/5 autoblocking #NEW
Train.Buttons.Freq2/6       = 2/6 ALS-ARS #NEW
Train.Buttons.Left          = Left #NEW
Train.Buttons.Right         = Right #NEW
Train.Buttons.Low           = Low #NEW
Train.Buttons.High          = High #NEW #FIXME
Train.Buttons.LFar          = Bright #NEW #FIXME (headlights)
Train.Buttons.LNear         = Dim #NEW #FIXME (headlights)
Train.Buttons.0             = 0 #NEW
Train.Buttons.1             = 1 #NEW
Train.Buttons.2             = 2 #NEW
Train.Buttons.3             = 3 #NEW
Train.Buttons.4             = 4 #NEW
Train.Buttons.Forward       = Forward #NEW
Train.Buttons.Back          = Backward #NEW
Train.Buttons.VentHalf      = 1/2 of speed #NEW (of ventilation)
Train.Buttons.VentFull      = Full speed #NEW (of ventilation)
Train.Buttons.VTRF          = Forward oriented wagons #NEW
Train.Buttons.VTRB          = Back oriented wagons #NEW
Train.Buttons.VTR1          = Even wagons #NEW
Train.Buttons.VTR2          = Odd wagons #NEW
Train.Buttons.VTRH1         = First half of train #NEW
Train.Buttons.VTRH2         = Second half of train #NEW
Train.Buttons.VTRAll        = All wagons #NEW

Train.Buttons.BatteryVoltage = %d V #NEW
Train.Buttons.HighVoltage    = %d V #NEW
Train.Buttons.BatteryCurrent = %d A #NEW
Train.Buttons.EnginesCurrent = %d A #NEW
Train.Buttons.Speed          = %d km/h #NEW
Train.Buttons.SpeedAll       = %d km/h\nSpeed limit: %s km/h #NEW #FIXME
Train.Buttons.SpeedLimit     = %s km/h #NEW
Train.Buttons.SpeedLimitNext = %s km/h #NEW
Train.Buttons.04             = NF #NEW (no frequency)
Train.Buttons.BCPressure     = %.1f bar
Train.Buttons.BLTLPressure   = TL: %.1f bar\nBL: %.1f bar #NEW (TL: Train line, BL: Brake line acronyms)
Train.Buttons.Locked         = Locked #NEW
Train.Buttons.Unlocked       = Unlocked #NEW

#Train entities
Entities.gmod_subway_base.Name        = Baza pociągu metra
Entities.gmod_subway_81-502.Name      = 81-502 (Ema-502 końcowy)
Entities.gmod_subway_81-501.Name      = 81-501 (Em-501 środkowy)
Entities.gmod_subway_81-702.Name      = 81-702 (D końcowy)
Entities.gmod_subway_81-702_int.Name  = 81-702 (D środkowy)
Entities.gmod_subway_81-703.Name      = 81-703 (E końcowy)
Entities.gmod_subway_81-703_int.Name  = 81-703 (E środkowy)
Entities.gmod_subway_ezh.Name         = 81-707 (Ezh końcowy)
Entities.gmod_subway_ezh1.Name        = 81-708 (Ezh1 środkowy)
Entities.gmod_subway_ezh3.Name        = 81-710 (Ezh3 końcowy)
Entities.gmod_subway_em508t.Name      = 81-508T (Em-508T środkowy)
Entities.gmod_subway_81-717_mvm.Name  = 81-717 (moskiewski, końcowy)
Entities.gmod_subway_81-717_mvm_custom.Name     = 81-717 (Moscow custom) #FIXME
Entities.gmod_subway_81-714_mvm.Name  = 81-714 (moskiewski, środkowy)
Entities.gmod_subway_81-717_lvz.Name  = 81-717 (petersburski, końcowy)
Entities.gmod_subway_81-714_lvz.Name  = 81-714 (petersburski, środkowy)
Entities.gmod_subway_81-718.Name      = 81-718 (TISU końcowy)
Entities.gmod_subway_81-719.Name      = 81-719 (TISU środkowy)
Entities.gmod_subway_81-720.Name      = 81-720 (Yauza końcowy)
Entities.gmod_subway_81-721.Name      = 81-721 (Yauza środkowy)
Entities.gmod_subway_81-722.Name      = 81-722 (Yubileyniy końcowy)
Entities.gmod_subway_81-723.Name      = 81-723 (Yubileyniy środkowy silnikowy)
Entities.gmod_subway_81-724.Name      = 81-724 (Yubileyniy środkowy toczny)
Entities.gmod_subway_81-7036.Name     = 81-7036 (nie działa)
Entities.gmod_subway_81-7037.Name     = 81-7037 (nie działa)
Entities.gmod_subway_tatra_t3.Name    = Tatra T3

#Train util entities
Entities.gmod_train_bogey.Name        = Wózek
Entities.gmod_train_couple.Name       = Sprzęg

#Other entities
Entities.gmod_track_pui.Name                = PUI
Entities.gmod_track_mus_elektronika7.Name   = Zegar "Electronika"
Entities.gmod_mus_clock_analog.Name         = Zegar analogowy
Entities.gmod_track_clock_time.Name         = Duży stoper (czas)
Entities.gmod_track_clock_small.Name        = Mały stoper
Entities.gmod_track_clock_interval.Name     = Duży stoper (interwał)
Entities.gmod_track_switch.Name             = Zwrotnica (kontroler)
Entities.gmod_track_powermeter.Name         = Kilowatomierz
Entities.gmod_track_arm.Name                = Pulpit nastawczy
Entities.gmod_track_udochka.Name            = Konektor
Entities.gmod_train_spawner.Name            = Spawner
Entities.gmod_train_special_box.Name        = Special delivery #FIXME

#Weapons
Weapons.button_presser.Name                 = Button presser #FIXME
Weapons.button_presser.Purpose              = Used to press buttons on the maps. #FIXME
Weapons.button_presser.Instructions         = Hold to the button and click "Attack" button. #FIXME
Weapons.train_key.Name                      = Administrator key #FIXME
Weapons.train_key.Purpose                   = Used to activate the administrators buttons. #FIXME
Weapons.train_key.Instructions              = Hold to administrator button and press "Attack" button. #FIXME
Weapons.train_kv_wrench.Name                = Reverser wrench #FIXME
Weapons.train_kv_wrench.Purpose             = Used in metro train and for pressing buttons in them. #FIXME
Weapons.train_kv_wrench.Instructions        = Hold to button in the train and press "Attack" button. #FIXME
Weapons.train_kv_wrench_gold.Name           = The golden reverser wrench #FIXME

Weapons.train_kv_wrench_gold.Purpose        = @[Weapons.train_kv_wrench.Purpose]
Weapons.train_kv_wrench_gold.Instructions   = @[Weapons.train_kv_wrench.Instructions]

#Spawner common
Spawner.Title                           = Train spawner #FIXME
Spawner.Spawn                           = Spawn #FIXME
Spawner.Close                           = Close #FIXME
Spawner.Trains1                         = Wags. allowed #FIXME
Spawner.Trains2                         = Per player #FIXME
Spawner.WagNum                          = Wagons amount #FIXME
Spawner.PresetTitle                     = Konfiguracje
Spawner.Preset.New                      = Nowa konfiguracja
Spawner.Preset.Unsaved                  = Zapisz obecną
Spawner.Preset.NewTooltip               = Stwórz
Spawner.Preset.UpdateTooltip            = Nadpisz
Spawner.Preset.RemoveTooltip            = Usuń
Spawner.Presets.NamePlaceholder         = Nazwa konfiguracji
Spawner.Presets.Name                    = Nazwa
Spawner.Presets.NameError               = Nieprawidłowa nazwa
Spawner.Preset.NotSelected              = Konfiguracja niewybrana
Common.Spawner.Texture      = Malowanie
Common.Spawner.PassTexture  = Wnętrze
Common.Spawner.CabTexture   = Kabina
Common.Spawner.Announcer    = Zapowiedzi
Common.Spawner.Type1        = Typ 1
Common.Spawner.Type2        = Typ 2
Common.Spawner.Type3        = Typ 3
Common.Spawner.Type4        = Typ 4
Common.Spawner.SpawnMode                = Train state #FIXME
Common.Spawner.SpawnMode.Deadlock       = Dead-end #FIXME
Common.Spawner.SpawnMode.Full           = Fully started #FIXME
Common.Spawner.SpawnMode.NightDeadlock  = Dead-end after night #FIXME
Common.Spawner.SpawnMode.Depot          = Depot #FIXME
Spawner.Common.EType                    = Electric circuits type #FIXME
Common.Spawner.Scheme                   = Line schemes
Common.Spawner.Random                   = Random #FIXME
Common.Spawner.Old                      = Old #FIXME
Common.Spawner.New                      = New #FIXME
Common.Spawner.Type                     = Type #FIXME
Common.Spawner.SchemeInvert             = Invert line schemes #FIXME

#Coupler common
Common.Couple.Title         = Coupler menu #FIXME
Common.Couple.CoupleState   = Coupler state #FIXME
Common.Couple.Coupled       = Coupled #FIXME
Common.Couple.Uncoupled     = Not coupled #FIXME
Common.Couple.Uncouple      = Uncouple #FIXME
Common.Couple.IsolState     = Isolation valves state #FIXME
Common.Couple.Isolated      = Closed #FIXME
Common.Couple.Opened        = Opened #FIXME
Common.Couple.Open          = Open #FIXME
Common.Couple.Isolate       = Close #FIXME
Common.Couple.EKKState      = EKK state (electrical connection) #FIXME
Common.Couple.Disconnected  = Disconnected #FIXME
Common.Couple.Connected     = Connected #FIXME
Common.Couple.Connect       = Connect #FIXME
Common.Couple.Disconnect    = Disconnect #FIXME

#Bogey common
Common.Bogey.Title              = Bogie menu #FIXME
Common.Bogey.ContactState       = Current collectors state #FIXME
Common.Bogey.CReleased          = Released #FIXME
Common.Bogey.CPressed           = Pressed #FIXME
Common.Bogey.CPress             = Press #FIXME
Common.Bogey.CRelease           = Release #FIXME
Common.Bogey.ParkingBrakeState  = Parking brake state #FIXME
Common.Bogey.PBDisabled         = Manually disabled #FIXME
Common.Bogey.PBEnabled          = Enabled #FIXME
Common.Bogey.PBEnable           = Enable #FIXME
Common.Bogey.PBDisable          = Manual disable #FIXME

#Trains common
Common.ALL.Unsused1                         = Nieużywane
Common.ALL.Unsused2                         = (nieużywane)
Common.ALL.Up                               = (up) #FIXME
Common.ALL.Down                             = (down) #FIXME
Common.ALL.Left                             = (left) #FIXME
Common.ALL.Right                            = (right) #FIXME
Common.ALL.CW                               = (clockwise) #FIXME
Common.ALL.CCW                              = (counter-clockwise) #FIXME
Common.ALL.VB                               = VB: Wyłącznik baterii akumulatorów
Common.ALL.VSOSD                            = SOSD: Wyłącznik kontrolki otwarcia drzwi stacyjnych
Common.ALL.VKF                              = VKF: Wyłącznik bateryjnego zasilania reflektorów czerwonych
Common.ALL.VB2                              = (Obwody pomocnicze NN)
Common.ALL.VPR                              = VPR: Wyłącznik radiotelefonu
Common.ALL.VASNP                            = Wyłącznik ASNP
Common.ALL.UOS                              = RC-UOS: Urządzenie ograniczenia prędkości (jazda bez EPV/EPK)
Common.ALL.VAH                              = VAH: Wyłącznik jazdy awaryjnej
Common.ALL.KAH                              = KAH: Przycisk jazdy awaryjnej bez ARS
Common.ALL.KAHK                             = KAH button cover #FIXME
Common.ALL.VAD                              = VAD: Wyłącznik awaryjny drzwi
Common.ALL.OVT                              = OVT: Odłączenie hamulców pneumatycznych
Common.ALL.VOVT                             = VOVT: Wyłącznik odłączenia hamulców pneumatycznych
Common.ALL.EmergencyBrakeValve              = Hamulec bezpieczeństwa
Common.ALL.ParkingBrake                     = Parking brake #FIXME
Common.ALL.VU                               = VU: Wyłącznik sterowania
Common.ALL.KDP                              = KDP: Otwarcie drzwi prawych
Common.ALL.KDPL                             = Right doors side is selected #FIXME
Common.ALL.KDPK                             = Klapka przycisku drzwi prawych
Common.ALL.KDL                              = KDL: Otwarcie drzwi lewych
Common.ALL.KDLL                             = Left doors side is selected #FIXME
Common.ALL.KDLK                             = Klapka przycisku drzwi prawych
Common.ALL.KDLPK                            = Klapka przycisków drzwi
Common.ALL.KRZD                             = KRZD: Rezerwowe zamykanie drzwi
Common.ALL.VSD                              = Doors side selector #FIXME
Common.ALL.Ring                             = Dzwonek
Common.ALL.VUD                              = VUD: Zamykanie drzwi
Common.ALL.KDPH                             = Otwarcie prawych drzwi ostatniego wagonu
Common.ALL.VUD2                             = VUD2: Zamykanie drzwi od strony pomocnika
Common.ALL.Program1                         = Program I
Common.ALL.Program2                         = Program II
Common.ALL.VRP                              = VRP: Odblokowanie RP
Common.ALL.VRPBV                            = VRP: Reset overload relay, enable BV #FIXME
Common.ALL.KSN                              = KSN: Sygnał awarii
Common.ALL.VMK                              = VMK: Sprężarka
Common.ALL.MK                               = Compressor #FIXME (without acronym)
Common.ALL.VF1                              = Wyłącznik pierwszej grupy reflektorów
Common.ALL.VF2                              = Wyłącznik drugiej grupy reflektorów
Common.ALL.VF                               = Wyłącznik reflektorów
Common.ALL.VUS                              = VUS: Wyłącznik silniejszego światła reflektorów
Common.ALL.GaugeLights                      = Oświetlenie pulpitu
Common.ALL.CabLights                        = Oświetlenie kabiny
Common.ALL.PassLights                       = Passenger compartment lighting #FIXME
Common.ALL.PanelLights                      = Control panel lighting #FIXME
Common.ALL.RMK                              = RMK: Rezerwowe sterowanie sprężarki
Common.ALL.KRP                              = KRP: Rozruch rezerwowy
Common.ALL.VZP                              = VZP: Wyłącznik wstrzymania odjazdu systemu jazdy samoczynnej
Common.ALL.VZD                              = VZD: Wyłącznik wstrzymania drzwi
Common.ALL.VAV                              = VAV: Wyłącznik jazdy samoczynnej
Common.ALL.RouteNumber1+                    = Zwiększenie pierwszej cyfry numeru brygady
Common.ALL.RouteNumber1-                    = Zmniejszenie pierwszej cyfry numeru brygady
Common.ALL.RouteNumber2+                    = Zwiększenie drugiej cyfry numeru brygady
Common.ALL.RouteNumber2-                    = Zmniejszenie drugiej cyfry numeru brygady
Common.ALL.RouteNumber3+                    = Zwiększenie trzeciej cyfry numeru brygady
Common.ALL.RouteNumber3-                    = Zmniejszenie trzeciej cyfry numeru brygady
Common.ALL.LastStation+                     = Przewinięcie tablicy stacji końcowych naprzód
Common.ALL.LastStation-                     = Przewinięcie tablicy stacji końcowych w tył
Common.ALL.RRP                              = Czerwona kontrolka RP (brak załączenia obwodu głównego)
Common.ALL.GRP                              = Zielona kontrolka RP
Common.ALL.RP                               = RP: Czerwona kontrolka RP (zadziałanie RP na jednym z wagonów lub brak załączenia obwodu głównego)
Common.ALL.SN                               = LSN: Czerwona kontrolka RP (brak załączenia obwodu głównego jednego lub więcej wagonów)
Common.ALL.PU                               = Kontrolka niskiego rozruchu
Common.ALL.BrT                              = Kontrolka działania hamulca pneumatycznego pociągu
Common.ALL.BrW                              = Wagon pneumobrakes are engaged #FIXME
Common.ALL.ARS                              = ARS: Wyłącznik systemu ARS
Common.ALL.ARSR                             = ARS-R: Wyłącznik pracy systemu ARS w trybie ARS-R
Common.ALL.ALS                              = ALS: Wyłącznik ALS
Common.ALL.RCARS                            = RC-ARS: ARS circuits disconnect #FIXME (same as RC-1)
Common.ALL.RC1                            = RC-1: Odłącznik obwodów ARS
Common.ALL.EPK                              = EPK: elektropneumatyczny zawór ARS
Common.ALL.EPV                              = EPV: elektropneumatyczny zawór ARS
Common.ARS.LN                               = LN: Kontrolka jazdy w kierunku właściwym
Common.ARS.KT                               = KT: Kontrolka hamowania
Common.ARS.VD                               = VD: Kontrolka wyłączenia
Common.ARS.Freq                             = Przełączenie trybu pracy ALS
Common.ARS.FreqD                            = (w górę 1/5, w dół 2/6)
Common.ARS.FreqU                            = (w górę 2/6, w dół 1/5)
Common.ARS.VP                               = "Auxiliary train" mode #FIXME
Common.ARS.RS                               = RS: Lampa równości ograniczeń prędkości
Common.ARS.AB                               = Praca systemu ARS w trybie blokady liniowej
Common.ARS.ABButton                         = Przycisk przejścia w tryb blokady liniowej
Common.ARS.ABDriver                         = (maszynisty)
Common.ARS.ABHelper                         = (pomocnika)
Common.ARS.AV                               = Kontrolka awarii bloku głównego systemu ARS-MP
Common.ARS.AV1                              = Kontrolka awarii bloku rezerwowego systemu ARS-MP
Common.ARS.AB2                              = Przycisk przejścia w tryb blokady liniowej
Common.ARS.ARS                              = Zasadniczy tryb pracy systemu ARS
Common.ARS.LRD                              = LRD: Kontrolka zezwolenia jazdy podczas sygnału "stój"
Common.ARS.VRD                              = VRD: Zezwolenie jazdy podczas sygnału "stój"
Common.ARS.KB                               = KB: Przycisk czuwaka
Common.ARS.KVT                              = KVT: Przycisk kasowania hamowania
Common.ARS.KVTR                             = KVT: Przycisk kasowania hamowania w trybie ARS-R
Common.ARS.04                               = OCh: Brak sygnału ARS
Common.ARS.N4                               = NCh: No ARS frequency #FIXME (same as OCh but NCh)
Common.ARS.0                                = 0: Sygnał "stój"
Common.ARS.40                               = 40: Ograniczenie 40 km/h
Common.ARS.60                               = 60: Ograniczenie 60 km/h
Common.ARS.70                               = 70: Ograniczenie 70 km/h
Common.ARS.80                               = 80: Ograniczenie 80 km/h
Common.ALL.RCBPS                            = RC-BPS: Odłącznik obwodów systemu przeciwpoślizgowego
Common.BPS.On                               = Działanie systemu przeciwpoślizgowego
Common.BPS.Err                              = Błąd systemu przeciwpoślizgowego
Common.BPS.Fail                             = Awaria systemu przeciwpoślizgowego
Commom.NMnUAVA.NMPressureLow                = Kontrolka niskiego ciśnienia w przewodzie zasilającym
Commom.NMnUAVA.UAVATriggered                = Kontrolka otwarcia styków UAVA
Common.ALL.LSD                              = Train doors state light (doors are closed) #FIXME
Common.ALL.L1w                              = Kontrolka przewodu 1. (załączenie obwodu głównego - rozruch)
Common.ALL.L2w                              = Kontrolka przewodu 2. (praca kontrolera reostatu (PSR))
Common.ALL.L6w                              = Kontrolka przewodu 6. (załączenie obwodu głównego - hamowanie ED)
Common.ALL.Horn                             = Horn #FIXME
Common.ALL.DriverValveBLDisconnect          = Zawór dwudrożny przewodu głównego
Common.ALL.DriverValveTLDisconnect          = Zawór dwudrożny przewodu zasilającego
Common.ALL.DriverValveDisconnect            = Driver's valve disconnect valve #FIXME
Common.ALL.KRMH                             = KRMSH: Driver's valve emergency enable #FIXME
Common.ALL.RVTB                             = RVTB: Reserved valve of safety brake #FIXME
Common.ALL.FrontBrakeLineIsolationToggle    = Zawór przewodu głównego sprzęgu powietrznego
Common.ALL.FrontTrainLineIsolationToggle    = Zawór przewodu zasilającego sprzęgu powietrznego
Common.ALL.RearBrakeLineIsolationToggle     = Zawór przewodu głównego sprzęgu powietrznego
Common.ALL.RearTrainLineIsolationToggle     = Zawór przewodu zasilającego sprzęgu powietrznego
Common.ALL.UAVA                             = UAVA: Włączenie samoczynnego wyłącznika autostopu\n(możliwe dopiero po zmniejszeniu ciśnienia w przewodzie głównym)
Common.ALL.UAVA2                            = UAVA: Enable automatic autostop disabler #FIXME
Common.ALL.UAVAContact                      = Przywrócenie styków UAVA
Common.ALL.OAVU                             = OAVU: Wyłącznik odłączenia AVU
Common.ALL.LAVU                             = Kontrolka działania AVU
Common.ALL.GV                               = GV: Główny odłącznik
Common.ALL.AirDistributor                   = VRN: Wyłącznik zaworu rozrządrzego
Common.ALL.CabinDoor                        = Drzwi do kabiny
Common.ALL.PassDoor                         = Door to the passenger compartment #FIXME
Common.ALL.FrontDoor                        = Drzwi przednie
Common.ALL.RearDoor                         = Drzwi tylne
Common.ALL.OtsekDoor1                       = 1st equipment cupboard handle #FIXME
Common.ALL.OtsekDoor2                       = 2nd equipment cupboard handle #FIXME
Common.ALL.CouchCap                         = Pull out the seat #FIXME

Common.ALL.UNCh                             = UNCh: Włączenie wzmacniacza niskich częstotliwości
Common.ALL.ES                               = ES: Przełącznik kontroli łączności alarmowej
Common.ALL.GCab                             = Włączenie głośnika w kabinie
Common.ALL.UPO                              = UPO: Włączenie urządzeń rozgłaszania komunikatów dźwiękowych
Common.ALL.R_Radio                          = Włączenie systemu zapowiedzi głosowych
Common.ALL.AnnPlay                          = Kontrolka odtwarzania zapowiedzi głosowej

#RRI
Train.Common.RRI                            = RRI: Przekaźnikowy system zapowiedzi głosowych
Common.RRI.RRIUp                            = RRI: Konfiguracja w górę
Common.RRI.RRIDown                          = RRI: Konfiguracja w dół
Common.RRI.RRILeft                          = RRI: Konfiguracja w lewo
Common.RRI.RRIRight                         = RRI: Konfiguracja w prawo
Common.RRI.RRIEnableToggle                  = RRI: Zasilanie
Common.RRI.RRIRewindSet2                    = RRI: Przewijanie do przodu
Common.RRI.RRIRewindSet0                    = RRI: Przewijanie do tyłu
Common.RRI.RRIAmplifierToggle               = RRI: Wzmacniacz
Common.RRI.RRIOn                            = RRI: Kontrolka pracy RRI 

#ASNP
Train.Common.ASNP           = ASNP
Common.ASNP.ASNPMenu        = ASNP: Menu
Common.ASNP.ASNPUp          = ASNP: W górę
Common.ASNP.ASNPDown        = ASNP: W dół
Common.ASNP.ASNPOn          = Wyłącznik ASNP

#PVK
Common.CabVent.PVK-         = Decrease cabin ventilation power #FIXME
Common.CabVent.PVK+         = Increase cabin ventilation power #FIXME

#IGLA
Train.Common.IGLA           = IGLA
Common.IGLA.Button1Up       = IGLA: Pierwszy przycisk w górę
Common.IGLA.Button1         = IGLA: Pierwszy przycisk
Common.IGLA.Button1Down     = IGLA: Pierwszy przycisk w dół
Common.IGLA.Button2Up       = IGLA: Drugi przycisk w górę
Common.IGLA.Button2         = IGLA: Drugi przycisk
Common.IGLA.Button2Down     = IGLA: Drugi przycisk w górę
Common.IGLA.Button23        = IGLA: Second and third buttons #FIXME
Common.IGLA.Button3         = IGLA: Third button #FIXME
Common.IGLA.Button4         = IGLA: Fourth button #FIXME
Common.IGLA.IGLASR          = IGLA: Zasilanie
Common.IGLA.IGLARX          = IGLA: Brak łączności
Common.IGLA.IGLAErr         = IGLA: Błąd
Common.IGLA.IGLAOSP         = IGLA: Zadziałanie systemu przeciwpożarowego
Common.IGLA.IGLAPI          = IGLA: Pożar
Common.IGLA.IGLAOff         = IGLA: Odłączenie obwodów WN

#BZOS
Common.BZOS.On      = Security alarm switch #FIXME
Common.BZOS.VH1     = Security alarm is enabled #FIXME
Common.BZOS.VH2     = Security alarm is triggered #FIXME
Common.BZOS.Engaged = Security alarm is triggered #FIXME

#Train helpers common
Common.ALL.SpeedCurr        = Actual speed #FIXME
Common.ALL.SpeedAccept      = Allowed speed #FIXME
Common.ALL.SpeedAttent      = Allowed speed on the next section #FIXME
Common.ALL.Speedometer      = Prędkościomierz
Common.ALL.BLTLPressure     = Ciśnienie w przewodach: głównym (wsk. czerwona) i zasilającym (wsk. czarna)
Common.ALL.BCPressure       = Ciśnienie w cylindrach hamulcowych
Common.ALL.EnginesCurrent   = Prąd trakcyjny [A]
Common.ALL.EnginesCurrent1  = 1st traction motors current (A) #FIXME
Common.ALL.EnginesCurrent2  = 2nd traction motors current (A) #FIXME
Common.ALL.EnginesVoltage   = Napięcie trakcyjne [kV]
Common.ALL.BatteryVoltage   = Napięcie baterii [V]
Common.ALL.BatteryCurrent   = Battery current (A) #FIXME
Common.ALL.HighVoltage      = Woltomierz WN [kV]
]]
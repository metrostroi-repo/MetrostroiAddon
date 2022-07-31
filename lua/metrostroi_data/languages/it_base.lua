return [[
#Base text for Italian language

[it]
lang        = Italiano                         #Full language name
AuthorText  = Translation Author: PlayMaster6176[PoG]      #Author text

#Workshop errors
Workshop.Title              = Manager dei contenuti
Workshop.FilesMissing       = Addon mancanti o corrotti.\nse l'addon è stato installato dal workshop , prova a eliminare il seguente file:\nGarrysMod/garrysmod/%s.
Workshop.FilesMissingLocaly = Addon mancanti o corrotti.
Workshop.InstalledLocaly    = Installato (localmente)
Workshop.NotInstalledE      = Non installato.\nIscriviti all'addon e verifica che sia presente nel "Addons" menu.
Workshop.NotInstalled       = Non installato.
Workshop.Disabled           = Disabilitato.\nAbilitalo dal "Addons" menu.
Workshop.Installed          = Installato
Workshop.Open               = Workshop
Workshop.ErrorGithub        = Rilevato versione GitHub di Metrostroi. La seguente versione di metrostroi non è compatibile e non funziona con la versione GitHub di Metrostroi.
Workshop.ErrorLegacy        = Rilevata versione legacy di Metrostroi. La versione corrente di Metrostroi non è compatibile e non funziona con la versione legacy di Metrostroi.
Workshop.ErrorEnhancers     = Questo addon contiene un potenziatore grafico che potrebbe interferire con l'esperienza di gioco.
Workshop.Error1             = Questo addon contiene un vecchio codice script di Metrostroi che è in conflitto con la versione corrente. Può causare "scriptscript" e l'instabilità dell'addon.

#Client settings
Panel.Admin             = Admin
Panel.RequireThirdRail  = Richiede il terzo binario

Panel.Client            = Utente
Panel.Language          = Seleziona lingua
Panel.DrawCams          = Render telecamera
Panel.DisableHUD        = Disabilita l'HUD nella sedia del macchinista
Panel.DisableCamAccel   = Disabilita accellerazione della visuale
Panel.DisableHoverText  = Disable hover text
Panel.DisableHoverTextP = Disable additional information\nin tooltips #NEW
Panel.DisableSeatShadows= Disable seat shadows #NEW
Panel.ScreenshotMode    = Modalità screenshot (FPS Bassi)
Panel.ShadowsHeadlight  = Abilita ombre faro
Panel.RedLights         = Abilita le luci dinamiche\ndelle luci rosse
Panel.ShadowsOther      = Abilita le ombre dagli altri\nlight sources
Panel.MinimizedShow     = Non scaricare nessun elemento\nwhen minimizzato
Panel.FOV               = FOV
Panel.Z                 = Altezza della videocamera
Panel.RenderDistance    = Distanza di rendering
Panel.RenderSignals     = Traced signals #NEW #FIXME
Panel.ReloadClient      = Ricarica lato utente

Panel.ClientAdvanced    = Utente (Avanzato)
Panel.DrawDebugInfo     = Disegna le informazioni di debug
Panel.CheckAddons       = Verifica addons
Panel.DrawSignalDebugInfo     = Segnala informazioni di debug
Panel.ReloadLang        = Ricarica linguaggi
Panel.SoftDraw          = Tempo di caricamento degli elementi del treno
Panel.SoftReloadLang    = Non ricaricare uno spawnmenu



#Common train
Train.Common.Camera0        = Sedia del macchinista
Train.Common.RouteNumber    = Numero itinerario
Train.Common.LastStation    = Ultima stazione
Train.Common.HelpersPanel   = Pannello aiutanti
Train.Common.UAVA           = UAVA
Train.Common.PneumoPanels   = Valvola pneumatica
Train.Common.Voltmeters     = Voltometro e amperometro
Train.Common.CouplerCamera  = Accoppiamento
Common.ARM.Monitor1         = Monitor 1 Armato
Train.Buttons.Sealed        = Sigillato

#Train entities
Entities.gmod_subway_base.Name        = Metropolitana base
Entities.gmod_subway_81-502.Name      = 81-502 (Ema-502 Testa)
Entities.gmod_subway_81-501.Name      = 81-501 (Em-501 Intermedio)
Entities.gmod_subway_81-702.Name      = 81-702 (D Testa)
Entities.gmod_subway_81-702_int.Name  = 81-702 (D Intermedio)
Entities.gmod_subway_81-703.Name      = 81-703 (E Testa)
Entities.gmod_subway_81-703_int.Name  = 81-703 (E Intermedio)
Entities.gmod_subway_ezh.Name         = 81-707 (Ezh Testa)
Entities.gmod_subway_ezh1.Name        = 81-708 (Ezh1 Intermedio)
Entities.gmod_subway_ezh3.Name        = 81-710 (Ezh3 Testa)
Entities.gmod_subway_em508t.Name      = 81-508T (Em-508T Intermedio)
Entities.gmod_subway_81-717_mvm.Name  = 81-717 (Moscow Testa)
Entities.gmod_subway_81-717_mvm_custom.Name     = 81-717 (Moscow personalizzato)
Entities.gmod_subway_81-714_mvm.Name  = 81-714 (Moscow Intermedio)
Entities.gmod_subway_81-717_lvz.Name  = 81-717 (St. Petersburg Testa)
Entities.gmod_subway_81-714_lvz.Name  = 81-714 (St. Petersburg Intermedio)
Entities.gmod_subway_81-718.Name      = 81-718 (TISU Testa)
Entities.gmod_subway_81-719.Name      = 81-719 (TISU Intermedio)
Entities.gmod_subway_81-720.Name      = 81-720 (Yauza Testa)
Entities.gmod_subway_81-721.Name      = 81-721 (Yauza Intermedio)
Entities.gmod_subway_81-722.Name      = 81-722 (Yubileyniy Testa)
Entities.gmod_subway_81-723.Name      = 81-723 (Yubileyniy Intermedio motore)
Entities.gmod_subway_81-724.Name      = 81-724 (Yubileyniy Intermedio rimorchio)
Entities.gmod_subway_81-7036.Name     = 81-7036 (Non funziona)
Entities.gmod_subway_81-7037.Name     = 81-7037 (Non funziona)
Entities.gmod_subway_tatra_t3.Name    = Tatra T3

#Train util entities
Entities.gmod_train_bogey.Name        = Carrello
Entities.gmod_train_couple.Name       = Accoppiatore

#Other entities
Entities.gmod_track_pui.Name                = PUI
Entities.gmod_track_mus_elektronika7.Name   = "Electronika" Orologio
Entities.gmod_mus_clock_analog.Name         = Orologio analogico
Entities.gmod_track_clock_time.Name         = Grande orologio intervallo (Tempo)
Entities.gmod_track_clock_small.Name        = Piccolo orologio intervallo
Entities.gmod_track_clock_interval.Name     = Grande orologio (intervallo)
Entities.gmod_track_switch.Name             = Scambio 
Entities.gmod_track_powermeter.Name         = Misuratore corrente rotaie
Entities.gmod_track_arm.Name                = ARM DSCP
Entities.gmod_track_udochka.Name            = Connettore di corrente
Entities.gmod_train_spawner.Name            = Spawna treno
Entities.gmod_train_special_box.Name        = Consegna speciale

#Weapons
Weapons.button_presser.Name                 = Premi bottoni
Weapons.button_presser.Purpose              = Usato per premere i bottoni della mappa.
Weapons.button_presser.Instructions         = Guarda il pulsante e fai clic sul pulsante "Attacca".
Weapons.train_key.Name                      = Chiave dell'amministratore
Weapons.train_key.Purpose                   = Utilizzato per premere i pulsanti degli amministratori.
Weapons.train_key.Instructions              = Guarda il pulsante amministratore e premi il pulsante "Attacca".
Weapons.train_kv_wrench.Name                = Chiave dell'invertitore
Weapons.train_kv_wrench.Purpose             = Utilizzato nel treno per premere i pulsanti in essi.
Weapons.train_kv_wrench.Instructions        = premi il pulsante "Attacca" per interagire col treno.
Weapons.train_kv_wrench_gold.Name           = La chiave dell'invertitore dorata

Weapons.train_kv_wrench_gold.Purpose        = @[Weapons.train_kv_wrench.Purpose]
Weapons.train_kv_wrench_gold.Instructions   = @[Weapons.train_kv_wrench.Instructions]

#Spawner common
Spawner.Title                           = Spawner di treni
Spawner.Spawn                           = Spawn
Spawner.Close                           = Chiudi
Spawner.Trains1                         = Wags. permesso
Spawner.Trains2                         = Per player
Spawner.WagNum                          = Numero di vagoni
Spawner.PresetTitle                     = Preset
Spawner.Preset.New                      = Nuovo preset
Spawner.Preset.Unsaved                  = Salva il preset attuale
Spawner.Preset.NewTooltip               = Crea
Spawner.Preset.UpdateTooltip            = Aggiorna
Spawner.Preset.RemoveTooltip            = Elimina
Spawner.Presets.NamePlaceholder         = Nome del preset
Spawner.Presets.Name                    = Nome
Spawner.Presets.NameError               = Nome non valido
Spawner.Preset.NotSelected              = Preset non selezionato
Common.Spawner.Texture                  = Skin del treno
Common.Spawner.PassTexture              = Skin degli interni
Common.Spawner.CabTexture               = Skin della cabina
Common.Spawner.Announcer                = Tipo di annunciatore
Common.Spawner.Type1                    = Tipo 1
Common.Spawner.Type2                    = Tipo 2
Common.Spawner.Type3                    = Tipo 3
Common.Spawner.Type4                    = Tipo 4
Common.Spawner.SpawnMode                = Stato del treno
Common.Spawner.SpawnMode.Deadlock       = Completamente spento
Common.Spawner.SpawnMode.Full           = Completamente pronto
Common.Spawner.SpawnMode.NightDeadlock  = Completamente spento dopo la notte
Common.Spawner.SpawnMode.Depot          = Deposito
Spawner.Common.EType                    = Circuiti elettrici type
Common.Spawner.Scheme                   = Schema linea
Common.Spawner.Random                   = Casuale
Common.Spawner.Old                      = Vecchio
Common.Spawner.New                      = Nuovo
Common.Spawner.Type                     = Tipo
Common.Spawner.SchemeInvert             = Inverti schema linea

#Coupler common
Common.Couple.Title         = Menu accoppiatore
Common.Couple.CoupleState   = Stato dell' accoppiatore
Common.Couple.Coupled       = Accoppiato
Common.Couple.Uncoupled     = Non accoppiato
Common.Couple.Uncouple      = Sgancia
Common.Couple.IsolState     = Stato delle valvole di isolamento
Common.Couple.Isolated      = Isolato
Common.Couple.Opened        = Aperto
Common.Couple.Open          = Apri
Common.Couple.Isolate       = Isola
Common.Couple.EKKState      = EKK stato (Connessione elettrica)
Common.Couple.Disconnected  = Disconesso
Common.Couple.Connected     = Connesso
Common.Couple.Connect       = Connetti
Common.Couple.Disconnect    = Disconetti

#Bogey common
Common.Bogey.Title              = Menu carrello
Common.Bogey.ContactState       = Stato attuale dei contatti
Common.Bogey.CReleased          = Rilasciato
Common.Bogey.CPressed           = Premuto
Common.Bogey.CPress             = Premi
Common.Bogey.CRelease           = Rilascia
Common.Bogey.ParkingBrakeState  = Stato freno di parcheggio
Common.Bogey.PBDisabled         = Disabilitato manualmente
Common.Bogey.PBEnabled          = Abilitato
Common.Bogey.PBEnable           = Abilita
Common.Bogey.PBDisable          = Disabilitazione manuale

#Trains common
Common.ALL.Unsused1                         = Non utilizzato
Common.ALL.Unsused2                         = (non utilizzato)
Common.ALL.Up                               = (su)
Common.ALL.Down                             = (giù)
Common.ALL.Left                             = (sinistra)
Common.ALL.Right                            = (destra)
Common.ALL.CW                               = (senzo orario)
Common.ALL.CCW                              = (Contatore senzo orario)
Common.ALL.VB                               = VB: Batteria on/off
Common.ALL.VSOSD                            = SOSD: Indicatore apertura porte stazione
Common.ALL.VKF                              = VKF: Batteria per luci rosse
Common.ALL.VB2                              = (Basso voltaggio)
Common.ALL.VPR                              = VPR: Stazione radio treno
Common.ALL.VASNP                            = ASNP Corrente
Common.ALL.UOS                              = RC-UOS: Dispositivo limitazione velocità (Guida w/o EPV/EPK)
Common.ALL.VAH                              = VAH: Modalità guida d'emergenza (failure of RPB relay)
Common.ALL.KAH                              = KAH: Bottone per guida d'emergenza w/o ARS
Common.ALL.KAHK                             = KAH Copri bottone
Common.ALL.VAD                              = VAD: Emergenza oltrepassato porta chiusa (Errore del KD relay)
Common.ALL.OVT                              = OVT: Disabilita la valvola del freno pneumatico
Common.ALL.VOVT                             = VOVT: Disabilita i freni (valvola pneumatica)
Common.ALL.EmergencyBrakeValve              = Freno d'emergenza
Common.ALL.ParkingBrake                     = Freno di parcheggio
Common.ALL.VU                               = VU: Interruttore di controllo del treno
Common.ALL.KDP                              = KDP: Apri le porte di DESTRA
Common.ALL.KDPL                             = Selezionato apertura porte DESTRA
Common.ALL.KDPK                             = Copri bottone di apertura porte DESTRA
Common.ALL.KDL                              = KDL: Apri le porte di SINISTRA
Common.ALL.KDLL                             = Selezionato apertura porte SINISTRA
Common.ALL.KDLK                             = Copri bottone di apertura porte SINISTRA
Common.ALL.KDLPK                            = Copri bottoni porte
Common.ALL.KRZD                             = KRZD: Chiusura d'emergenza delle porte
Common.ALL.VSD                              = Selettore lato di apertura porte
Common.ALL.Ring                             = Squillo
Common.ALL.VUD                              = VUD: Interruttore di controllo delle porte (Chiudi porte)
Common.ALL.KDPH                             = Aprire le porte a destra dell'ultima vettura
Common.ALL.VUD2                             = VUD2: Close doors from the helper's side
Common.ALL.Program1                         = Programma I
Common.ALL.Program2                         = Programma II
Common.ALL.VRP                              = VRP: Ripristinare il relè di sovraccarico
Common.ALL.VRPBV                            = VRP: Ripristinare il relè di sovraccarico, abilitare BV
Common.ALL.KSN                              = KSN: Segnalatore di malfunzionamento
Common.ALL.VMK                              = VMK: Compressore
Common.ALL.MK                               = Compressore (without acronym)
Common.ALL.VF1                              = Fari primari
Common.ALL.VF2                              = Fari secondari
Common.ALL.VF                               = Interruttori fari
Common.ALL.VUS                              = VUS: Luci fari LUMINOSO / BASSO
Common.ALL.GaugeLights                      = Illuminazione strumenti
Common.ALL.CabLights                        = Luci cabina
Common.ALL.PassLights                       = Luci compartimento passeggieri
Common.ALL.PanelLights                      = Illuminazione del pannello di controllo
Common.ALL.RMK                              = RMK: Compressore d'emergenza
Common.ALL.KRP                              = KRP: Bottone partenza d'emergenza
Common.ALL.VZP                              = VZP: Disabilita il ritardo della guida
Common.ALL.VZD                              = VZD: Disabilita il ritardo delle porte
Common.ALL.VAV                              = VAV: Interruttore guida automatica
Common.ALL.RouteNumber1+                    = Aumenta la PRIMA cifra dell'itinerario
Common.ALL.RouteNumber1-                    = Diminuisci la PRIMA cifra dell'itinerario
Common.ALL.RouteNumber2+                    = Aumenta la SECONDA cifra dell'itinerario
Common.ALL.RouteNumber2-                    = Diminuisci la SECONDA cifra dell'itinerario
Common.ALL.RouteNumber3+                    = Aumenta la TERZA cifra dell'itinerario
Common.ALL.RouteNumber3-                    = Diminuisci la TERZA cifra dell'itinerario
Common.ALL.LastStation+                     = Prossima ultima stazione
Common.ALL.LastStation-                     = Ultima stazione precedente
Common.ALL.RRP                              = RP: Spia rossa sovraccarico del relè (i circuiti di alimetazione non sono riusciti a funzionare)
Common.ALL.GRP                              = RP: Spia verde sovraccarico del relè (impedisce la sovraccarico dei motori)
Common.ALL.RP                               = RP: Spia rossa sovraccarico del relè (i circuiti di potenza non sono riusciti a funzionare o RP attivo)
Common.ALL.SN                               = LSN: Failure indicator light (power circuits failed to assemble)
Common.ALL.PU                               = Indicatore modalità di alimentazione ridotta
Common.ALL.BrT                              = Freni pneumatici del treno in funzione
Common.ALL.BrW                              = Freni pneumatici dei vagoni in funzione
Common.ALL.ARS                              = ARS: Interruttore di regolazione della velocità automatico
Common.ALL.ARSR                             = ARS-R: Interruttore di regolazione della velocità automatico in modalita ARS-R
Common.ALL.ALS                              = ALS: Lettore segnali automatico del treno
Common.ALL.RCARS                            = RC-ARS: I circuiti del ARS si sono disconessi (same as RC-1)
Common.ALL.RC1                              = RC-1: I circuiti del ARS si sono disconessi
Common.ALL.EPK                              = ARS Valvola elettropneumatica (EPK)
Common.ALL.EPV                              = ARS Valvola elettropneumatica (EPV)
Common.ARS.LN                               = LN: Direzione del segnale
Common.ARS.KT                               = KT: Indicatore di controllo frenata
Common.ARS.VD                               = VD: Modalià di guida bloccata dall'ARS
Common.ARS.Freq                             = ALS interruttore del decoder
Common.ARS.FreqD                            = (su 1/5, giù 2/6)
Common.ARS.FreqU                            = (su 2/6, giù 1/5)
Common.ARS.VP                               = Modalità "Treno ausiliario"
Common.ARS.RS                               = RS: Indicatore velocità uguale (Per il prossimo segmento la velocità è uguale o maggiore)
Common.ARS.AB                               = Modalità autobloccante ARS
Common.ARS.ABButton                         = Bottone di modalità autobloccante ARS
Common.ARS.ABDriver                         = (Macchinista)
Common.ARS.ABHelper                         = (Aiutante)
Common.ARS.AV                               = Malfunzionamento dell'unità ARS-MP principale
Common.ARS.AV1                              = Malfunzionamento dell'unità ARS-MP di ricambio
Common.ARS.AB2                              = Pulsante di modalità ARS con blocco automatico
Common.ARS.ARS                              = Modalità ARS
Common.ARS.LRD                              = LRD: Permesso di movimento (quando 0 su ALS)
Common.ARS.VRD                              = VRD: Consenti il movimento(quando 0 su ALS)
Common.ARS.KB                               = KB: Pulsante di attenzione
Common.ARS.KVT                              = KVT: Pulsante di percezione del freno
Common.ARS.KVTR                             = KVT: Pulsante di percezione freno ARS-R 
Common.ARS.04                               = OCh: Nessuna frequenza ARS
Common.ARS.N4                               = NCh: Nessuna frequenza ARS (same as OCh but NCh)
Common.ARS.0                                = 0: ARS Segnale di stop
Common.ARS.40                               = Limite di velocità 40 km/h
Common.ARS.60                               = Limite di velocità 60 km/h
Common.ARS.70                               = Limite di velocità 70 km/h
Common.ARS.80                               = Limite di velocità 80 km/h
Common.ALL.RCBPS                            = RC-BPS: Interruttore unità antirollio
Common.BPS.On                               = Funzionamento dell'unità antirollio
Common.BPS.Err                              = Errore unità antirollio
Common.BPS.Fail                             = Malfunzionamento dell'unità antirollio
Commom.NMnUAVA.NMPressureLow                = Indicatore di bassa pressione
Commom.NMnUAVA.UAVATriggered                = UAVA Contatti aperti
Common.ALL.LSD                              = Luce indicatore delle porte del treno (le porte sono chiuse)
Common.ALL.L1w                              = Primo indicatore (modalità di guida abilitata)
Common.ALL.L2w                              = Secondo indicatore (movimento del controller reostato)
Common.ALL.L6w                              = Sesto indicatore (modalità di frenatura inserita)
Common.ALL.Horn                             = Clacson
Common.ALL.DriverValveBLDisconnect          = Brake line disconnect valve
Common.ALL.DriverValveTLDisconnect          = Train line disconnect valve
Common.ALL.DriverValveDisconnect            = Valvola di disconnessione valvola del conducente
Common.ALL.KRMH                             = KRMSH: Abilitazione di emergenza della valvola del conducente
Common.ALL.RVTB                             = RVTB: Valvola riservata del freno di sicurezza
Common.ALL.FrontBrakeLineIsolationToggle    = Valvola di isolamento della linea del freno
Common.ALL.FrontTrainLineIsolationToggle    = Valvola di isolamento della linea del treno
Common.ALL.RearTrainLineIsolationToggle     = Valvola di isolamento della linea del treno
Common.ALL.RearBrakeLineIsolationToggle     = Valvola di isolamento della linea del freno
Common.ALL.UAVA                             = UAVA: Abilita disabilitazione automatica del autostop \n(abilitata dopo la caduta di pressione del freno)
Common.ALL.UAVA2                            = UAVA: Abilita la disabilitazione automatica dell'autostop
Common.ALL.UAVAContact                      = UAVA: Resetta i contatti
Common.ALL.OAVU                             = OAVU: Interruttore disabilitazione AVU 
Common.ALL.LAVU                             = AVU è attivato
Common.ALL.GV                               = Switch principale
Common.ALL.AirDistributor                   = VRN: Disabilita distribuzione aria
Common.ALL.CabinDoor                        = Porta cabina del macchinista
Common.ALL.PassDoor                         = Porta dell'abitacolo
Common.ALL.FrontDoor                        = Porta anteriore
Common.ALL.RearDoor                         = Porta posteriore
Common.ALL.OtsekDoor1                       = Prima maniglia armadietto
Common.ALL.OtsekDoor2                       = Seconda maniglia armadietto
Common.ALL.CouchCap                         = Tira fuori il sedile

Common.ALL.UNCh                             = UNCh: Interruttore amplificatore di bassa frequenza 
Common.ALL.ES                               = ES: Interruttore controllo comunicazione di emergenza
Common.ALL.GCab                             = Altoparlante: Interruttore annuncio in cabina
Common.ALL.UPO                              = UPO: Annunciatore
Common.ALL.R_Radio                          = Annunciatore
Common.ALL.AnnPlay                          = Annunciatore in riproduzione

#RRI
Train.Common.RRI                            = RRI: Radio-relè annunciatore
Common.RRI.RRIUp                            = RRI: Imposta giù
Common.RRI.RRIDown                          = RRI: Imposta su
Common.RRI.RRILeft                          = RRI: Imposta sinistra
Common.RRI.RRIRight                         = RRI: Imposta destra
Common.RRI.RRIEnableToggle                  = RRI: Alimentazione
Common.RRI.RRIRewindSet2                    = RRI: Avanti veloce
Common.RRI.RRIRewindSet0                    = RRI: Riavvolgi
Common.RRI.RRIAmplifierToggle               = RRI: Amplificatore
Common.RRI.RRIOn                            = RRI: spia operazione

#ASNP
Train.Common.ASNP           = ASNP
Common.ASNP.ASNPMenu        = ASNP: Menu
Common.ASNP.ASNPUp          = ASNP: Su
Common.ASNP.ASNPDown        = ASNP: Giù
Common.ASNP.ASNPOn          = ASNP: Accenzione

#PVK
Common.CabVent.PVK-         = Diminuisci potenza ventilazione cabina
Common.CabVent.PVK+         = Aumenta potenza ventilazione cabina

#IGLA
Train.Common.IGLA           = IGLA
Common.IGLA.Button1Up       = IGLA: Primo pulsante su
Common.IGLA.Button1         = IGLA: Primo pulsante
Common.IGLA.Button1Down     = IGLA: Primo pulsante giù
Common.IGLA.Button2Up       = IGLA: Secondo pulsante su
Common.IGLA.Button2         = IGLA: Secondo pulsante
Common.IGLA.Button2Down     = IGLA: Secondo pulsante giù
Common.IGLA.Button23        = IGLA: Secondo e terzo pulsante
Common.IGLA.Button3         = IGLA: Terzo pulsante
Common.IGLA.Button4         = IGLA: Quarto pulsante
Common.IGLA.IGLASR          = IGLA: Alimentazione
Common.IGLA.IGLARX          = IGLA: Nessuna connessione
Common.IGLA.IGLAErr         = IGLA: Errore
Common.IGLA.IGLAOSP         = IGLA: Sistema di estinzione è attivo 
Common.IGLA.IGLAPI          = IGLA: Fuoco
Common.IGLA.IGLAOff         = IGLA: HV circuiti spenti

#BZOS
Common.BZOS.On      = Interruttore allarme di sicurezza#FIXME
Common.BZOS.VH1     = Allarme di sicurezza attivo
Common.BZOS.VH2     = Allarme di sicurezza innescato
Common.BZOS.Engaged = Allarme innescato

#Train helpers common
Common.ALL.SpeedCurr        = Velocità effettiva
Common.ALL.SpeedAccept      = Velocità autorizzata
Common.ALL.SpeedAttent      = Velocità autorizzate al prossimo segmento
Common.ALL.Speedometer      = Tachimetro
Common.ALL.BLTLPressure     = Pressione nelle linee pneumatiche (rosso: linea freni, nero: linea treno)
Common.ALL.BCPressure       = Pressione nel cilindro del freno
Common.ALL.EnginesCurrent   = Corrente motori (A)
Common.ALL.EnginesCurrent1  = Corrente di trazione motore 1 (A)
Common.ALL.EnginesCurrent2  = Corrente di trazione motore 2 (A)
Common.ALL.EnginesVoltage   = Voltaggio motori (kV)
Common.ALL.BatteryVoltage   = Voltaggio batteria (V)
Common.ALL.BatteryCurrent   = Corrente batteria (A)
Common.ALL.HighVoltage      = Alto voltaggio (kV)
]]
return [[
#Base text for French language

[fr]
lang        = Français                           #Full language name
AuthorText  = Traducteur: Link-Skywalker      #Author text

#Workshop errors
Workshop.Title              = Gestionnaire de contenu
Workshop.FilesMissing       = Certains fichiers d'extension sont manquants ou corrompus.\nSi l'extension a été installée via le Workshop, supprimez ce fichier :\nGarrysMod/garrysmod/%s.
Workshop.FilesMissingLocaly = Certains fichiers d'extension sont manquants ou corrompus.
Workshop.InstalledLocaly    = Installé (local)
Workshop.NotInstalledE      = Non installé.\nAbonnez vous à l'extension et vérifier le menu "Addons".
Workshop.NotInstalled       = Non installé.
Workshop.Disabled           = Désactivé.\nActivez-le dans le menu "Addons"
Workshop.Installed          = Installé
Workshop.Open               = Workshop
Workshop.ErrorGithub        = Version GitHub de Metrostroi détectée. La version actuelle de Metrostroi n'est pas pas compatible et ne fonctionne pas en version GitHub.
Workshop.ErrorLegacy        = Version Legacy (alpha) de Metrostroi détectée. La version actuelle de Metrostroi n'est pas pas compatible et ne fonctionne pas en version Legacy (alpha).
Workshop.ErrorEnhancers     = Cet addon contient un mod graphique susceptible d'interférer avec l'expérience de jeu.
Workshop.Error1             = Cette extension contient un ancien code de script de Metrostroi qui crée un conflit avec l'actuel. Cela peut créer des "Scripts errors" et une instabilité de l'extension.
Workshop.ErrorOld           = Anciens modèles détectés (ancien modèles des 81-702 et 81-717). Supprimez les anciens fichiers de contenu de Metrostroi du dossier "Addons", supprimez les fichiers "Cache", "Download" et "Downloads", du dossier principal Garry's Mod.

#Client settings
Panel.Admin             = Administrateur
Panel.RequireThirdRail  = Requiert un troisième rail

Panel.Client            = Client
Panel.Language          = Sélectionner la langue
Panel.DrawCams          = Rendu des caméras
Panel.DisableHUD        = Désactive le HUD sur le siège du conducteur
Panel.DisableCamAccel   = Désactive l'accéleration de caméra
Panel.DisableHoverText  = Désactive le texte de légende
Panel.DisableHoverTextP = Disable additional information\nin tooltips #NEW
Panel.DisableSeatShadows= Disable seat shadows #NEW
Panel.ScreenshotMode    = Mode screenshot (IPS bas)
Panel.ShadowsHeadlight  = Active les ombres des phares
Panel.RedLights         = Activer la lumière dynamique\ndes feux rouges
Panel.ShadowsOther      = Active les ombres d'autres\nsources de lumière
Panel.MinimizedShow     = Empêche la \ndisparition d'éléments
Panel.PanelLights       = Enable dynamic lights\nfrom panel lamps #NEW
Panel.RouteNumber       = Route number #NEW
Panel.FOV               = Champ de vision (FOV)
Panel.Z                 = Hauteur de caméra
Panel.RenderDistance    = Rendu à distance
Panel.RenderSignals     = Traced signals #NEW #FIXME
Panel.ReloadClient      = Redémarrer le client

Panel.ClientAdvanced    = Client (avancé)
Panel.DrawDebugInfo     = Afficher les informations de debug
Panel.DrawSignalDebugInfo     = Infos de débogage de signalisation
Panel.CheckAddons       = Rechercher les extensions
Panel.ReloadLang        = Recharger les langues
Panel.SoftDraw          = Temps de chargement des éléments de train
Panel.SoftReloadLang    = Désactive la recharge du spawnmenu



#Common train
Train.Common.Camera0        = Siège du conducteur
Train.Common.RouteNumber    = Numéro de route
Train.Common.LastStation    = Dernière station
Train.Common.HelpersPanel   = Tableau de bord de l'assistant
Train.Common.UAVA           = UAVA
Train.Common.PneumoPanels   = Valves pneumatiques
Train.Common.Voltmeters     = Voltmètres et ampèremètres
Train.Common.CouplerCamera  = Atteleur
Common.ARM.Monitor1         = Moniteur ARM 1

Train.Buttons.Sealed        = Scellé
Train.Buttons.Active        = Active #NEW
Train.Buttons.Auto          = Auto #NEW
Train.Buttons.On            = On #NEW
Train.Buttons.Off           = Off #NEW
Train.Buttons.Closed        = Closed #NEW
Train.Buttons.Opened        = Opened #NEW
Train.Buttons.Disconnected  = Disconnected #NEW
Train.Buttons.Connected     = Connected #NEW
Train.Buttons.UAVAOff       = Control circuits isolated #NEW
Train.Buttons.UAVAOn        = Control circuits active #NEW
Train.Buttons.Freq1/5       = 1/5 AB #NEW
Train.Buttons.Freq2/6       = 2/6 ALS-ARS #NEW
Train.Buttons.Left          = Left #NEW
Train.Buttons.Right         = Right #NEW
Train.Buttons.Low           = Low #NEW
Train.Buttons.High          = High #NEW
Train.Buttons.LFar          = Distant light #NEW #FIXME
Train.Buttons.LNear         = Near light #NEW #FIXME
Train.Buttons.0             = 0 #NEW
Train.Buttons.1             = 1 #NEW
Train.Buttons.2             = 2 #NEW
Train.Buttons.3             = 3 #NEW
Train.Buttons.4             = 4 #NEW
Train.Buttons.Forward       = Forward #NEW
Train.Buttons.Back          = Backward #NEW #FIXME
Train.Buttons.VentHalf      = 1/2 of speed #NEW
Train.Buttons.VentFull      = Full speed #NEW
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
Train.Buttons.SpeedAll       = %d km/h Speed limit:%s km/h #NEW
Train.Buttons.SpeedLimit     = %s km/h #NEW
Train.Buttons.SpeedLimitNext = %s km/h #NEW
Train.Buttons.04             = NF #NEW
Train.Buttons.BCPressure     = %.1f bar #NEW
Train.Buttons.BLTLPressure   = TL: %.1f bar BL:%.1f bar #NEW

#Train entities
Entities.gmod_subway_base.Name        = Base de métro
Entities.gmod_subway_81-502.Name      = 81-502 (Ema-502, tête)
Entities.gmod_subway_81-501.Name      = 81-501 (Em-501, intermédiaire)
Entities.gmod_subway_81-702.Name      = 81-702 (D, tête)
Entities.gmod_subway_81-702_int.Name  = 81-702 (D, intermédiaire)
Entities.gmod_subway_81-703.Name      = 81-703 (E, tête)
Entities.gmod_subway_81-703_int.Name  = 81-703 (E, intermédiaire)
Entities.gmod_subway_ezh.Name         = 81-707 (Ezh, tête)
Entities.gmod_subway_ezh1.Name        = 81-708 (Ezh1, intermédiaire)
Entities.gmod_subway_ezh3.Name        = 81-710 (Ezh3, tête)
Entities.gmod_subway_em508t.Name      = 81-508T (Em-508T intermédiaire)
Entities.gmod_subway_81-717_mvm.Name  = 81-717 (Moscou, tête)
Entities.gmod_subway_81-717_mvm_custom.Name     = 81-717 (Moscou, customisé)
Entities.gmod_subway_81-714_mvm.Name  = 81-714 (Moscou, intermédiaire)
Entities.gmod_subway_81-717_lvz.Name  = 81-717 (St. Petersbourg, tête)
Entities.gmod_subway_81-714_lvz.Name  = 81-714 (St. Petersbourg, intermédiaire)
Entities.gmod_subway_81-718.Name      = 81-718 (TISU, tête)
Entities.gmod_subway_81-719.Name      = 81-719 (TISU, intermédiaire)
Entities.gmod_subway_81-720.Name      = 81-720 (Yauza, tête)
Entities.gmod_subway_81-721.Name      = 81-721 (Yauza, intermédiaire)
Entities.gmod_subway_81-722.Name      = 81-722 (Yubileyniy, tête)
Entities.gmod_subway_81-723.Name      = 81-723 (Yubileyniy, intermédiaire automoteur)
Entities.gmod_subway_81-724.Name      = 81-724 (Yubileyniy, intermédiaire non moteur)
Entities.gmod_subway_81-7036.Name     = 81-7036 (Ne fonctionne pas)
Entities.gmod_subway_81-7037.Name     = 81-7037 (Ne fonctionne pas)
Entities.gmod_subway_tatra_t3.Name    = Tatra T3

#Train util entities
Entities.gmod_train_bogey.Name        = Bogie
Entities.gmod_train_couple.Name       = Coupleur

#Other entities
Entities.gmod_track_pui.Name                = PUI
Entities.gmod_track_mus_elektronika7.Name   = Horloge "Electronika"
Entities.gmod_mus_clock_analog.Name         = Horloge analogique
Entities.gmod_track_clock_time.Name         = Grande horloge digitale (heure)
Entities.gmod_track_clock_small.Name        = Petite horloge digitale
Entities.gmod_track_clock_interval.Name     = Grande horloge digitale (interval)
Entities.gmod_track_switch.Name             = Aiguillage
Entities.gmod_track_powermeter.Name         = Capteur de puissance
Entities.gmod_track_arm.Name                = ARM DSCP
Entities.gmod_track_udochka.Name            = Connecteur d'alimentation
Entities.gmod_train_spawner.Name            = Train spawneur
Entities.gmod_train_special_box.Name        = Livrée spéciale

#Weapons
Weapons.button_presser.Name                 = Appuyeur de bouton
Weapons.button_presser.Purpose              = Utilisé pour appuyer sur les boutons des maps.
Weapons.button_presser.Instructions         = Maintenez le bouton et appuyez sur le bouton "Attaquer".
Weapons.train_key.Name                      = Clé d'administrateur
Weapons.train_key.Purpose                   = UUtilisé pour activer les boutons réservés aux administrateurs.
Weapons.train_key.Instructions              = Maintenez le bouton et appuyez sur le bouton "Attaquer".
Weapons.train_kv_wrench.Name                = Clé d'inverseur
Weapons.train_kv_wrench.Purpose             = Utilisé dans le train pour appuyer sur les boutons à l'intérieur.
Weapons.train_kv_wrench.Instructions        = Maintenez le bouton dans le train et appuyez sur le bouton "Attaquer".
Weapons.train_kv_wrench_gold.Name           = La clé d'inverseur en or

Weapons.train_kv_wrench_gold.Purpose        = @[Weapons.train_kv_wrench.Purpose]
Weapons.train_kv_wrench_gold.Instructions   = @[Weapons.train_kv_wrench.Instructions]

#Spawner common
Spawner.Title                           = Train spawneur
Spawner.Spawn                           = Spawn
Spawner.Close                           = Fermer
Spawner.Trains1                         = Voit. autorisées
Spawner.Trains2                         = Par joueur
Spawner.WagNum                          = Nombre de voitures
Spawner.PresetTitle                     = Préréglages
Spawner.Preset.New                      = Nouveau préréglage
Spawner.Preset.Unsaved                  = Sauvegarder préréglage actuel
Spawner.Preset.NewTooltip               = Créer
Spawner.Preset.UpdateTooltip            = Mettre à jour
Spawner.Preset.RemoveTooltip            = Effacer
Spawner.Presets.NamePlaceholder         = Nom du préréglage
Spawner.Presets.Name                    = Nom
Spawner.Presets.NameError               = Nom invalide
Spawner.Preset.NotSelected              = Aucun préréglage sélectionné
Common.Spawner.Texture      = Skin d'extérieur
Common.Spawner.PassTexture  = Skin d'intérieur
Common.Spawner.CabTexture   = Skin de cabine
Common.Spawner.Announcer    = Type d'annonceur
Common.Spawner.Type1        = Type 1
Common.Spawner.Type2        = Type 2
Common.Spawner.Type3        = Type 3
Common.Spawner.Type4        = Type 4
Common.Spawner.SpawnMode                = Etat du train
Common.Spawner.SpawnMode.Deadlock       = Heurtoir
Common.Spawner.SpawnMode.Full           = Complètement démarré
Common.Spawner.SpawnMode.NightDeadlock  = Heurtoir de nuit
Common.Spawner.SpawnMode.Depot          = Dépot
Spawner.Common.EType                    = Type de circuits électriques
Common.Spawner.Scheme                   = Schémas de ligne
Common.Spawner.Random                   = Aléatoire
Common.Spawner.Old                      = Ancien
Common.Spawner.New                      = Neuf
Common.Spawner.Type                     = Type
Common.Spawner.SchemeInvert             = Inverser les schémas de ligne

#Coupler common
Common.Couple.Title         = Menu d'attelage
Common.Couple.CoupleState   = Etat des atteleurs
Common.Couple.Coupled       = Attelé
Common.Couple.Uncoupled     = Non attelé
Common.Couple.Uncouple      = Dételer
Common.Couple.IsolState     = Etat de l'isolation des valves
Common.Couple.Isolated      = Fermé
Common.Couple.Opened        = Ouvert
Common.Couple.Open          = Ouvrir
Common.Couple.Isolate       = Fermer
Common.Couple.EKKState      = Etat de l'EKK (connexion électrique)
Common.Couple.Disconnected  = Déconnecté
Common.Couple.Connected     = Connecté
Common.Couple.Connect       = Connecter
Common.Couple.Disconnect    = Déconnecter

#Bogey common
Common.Bogey.Title              = Menu des bogies
Common.Bogey.ContactState       = Etat des collecteurs de courant
Common.Bogey.CReleased          = Relâché
Common.Bogey.CPressed           = Appuyé
Common.Bogey.CPress             = Appuyer
Common.Bogey.CRelease           = Relâcher
Common.Bogey.ParkingBrakeState  = Etat du frein de parking
Common.Bogey.PBDisabled         = Manuellement désactivé
Common.Bogey.PBEnabled          = Activé
Common.Bogey.PBEnable           = Activer
Common.Bogey.PBDisable          = Désactiver manuellement

#Trains common
Common.ALL.Unsused1                         = Inutilisé
Common.ALL.Unsused2                         = (inutilisé)
Common.ALL.Up                               = (haut)
Common.ALL.Down                             = (bas)
Common.ALL.Left                             = (gauche)
Common.ALL.Right                            = (droite)
Common.ALL.CW                               = (Sens horaire)
Common.ALL.CCW                              = (Sens contre horaire)
Common.ALL.VB                               = VB: Batterie on/off
Common.ALL.VSOSD                            = SOSD: Lampe d'ouverture des portes en station
Common.ALL.VKF                              = VKF: Batterie d'alimentation pour lumières rouges
Common.ALL.VB2                              = (Circuits basse tension)
Common.ALL.VPR                              = VPR: Station radio du train
Common.ALL.VASNP                            = Alimentation ASNP
Common.ALL.UOS                              = RC-UOS: Limiteur de vitesse (conduite avec/sans EPV/EPK)
Common.ALL.VAH                              = VAH: Mode de conduite d'urgence (échec du relai RPB)
Common.ALL.KAH                              = KAH: Bouton de conduite d'urgence pour conduire avec/sans ARS
Common.ALL.KAHK                             = Couvercle du bouton KAH
Common.ALL.VAD                              = VAD: Outrepasseur de fermeture d'urgence des portes (échec du relai KD)
Common.ALL.OVT                              = OVT: Désactiver les valves de freins pneumatiques
Common.ALL.VOVT                             = VOVT: Eteindre le désactivateur des valves des freins pneumatiques
Common.ALL.EmergencyBrakeValve              = Freinage d'urgence
Common.ALL.ParkingBrake                     = Frein de parking
Common.ALL.VU                               = VU: Contrôle du train
Common.ALL.KDP                              = KDP: Ouvrir les portes à droite
Common.ALL.KDPL                             = Les portes du côté droit sont sélectionnées
Common.ALL.KDPK                             = Couvercle du bouton des portes de droite
Common.ALL.KDL                              = KDL: Ouvrir les portes à gauche
Common.ALL.KDLL                             = Les portes du côté gauche sont sélectionnées
Common.ALL.KDLK                             = Couvercle du bouton des portes de gauche
Common.ALL.KDLPK                            = Couvercles des boutons des portes
Common.ALL.KRZD                             = KRZD: Fermeture d'urgence des portes
Common.ALL.VSD                              = Sélecteur du côté des portes
Common.ALL.Ring                             = Alarme
Common.ALL.VUD                              = VUD: Contrôle des portes (fermer les portes)
Common.ALL.KDPH                             = Ouvrir les portes à droite dans la dernière voiture
Common.ALL.VUD2                             = VUD2: Fermer les portes du côté de l'assistant
Common.ALL.Program1                         = Programme I
Common.ALL.Program2                         = Programme II
Common.ALL.VRP                              = VRP: Recharger le relai de surcharge
Common.ALL.VRPBV                            = VRP: Redémarrer le relai de surcharge, activer le BV
Common.ALL.KSN                              = KSN: Malfonction de signalisation
Common.ALL.VMK                              = VMK: Compresseur
Common.ALL.MK                               = Compresseur
Common.ALL.VF1                              = 1er groupe de phares
Common.ALL.VF2                              = 2ème groupe de phares
Common.ALL.VF                               = Phares
Common.ALL.VUS                              = VUS: Phares lumineux/diminués
Common.ALL.GaugeLights                      = Eclairage des instruments
Common.ALL.CabLights                        = Eclairage de cabine
Common.ALL.PassLights                       = Eclairage du compatiment passager
Common.ALL.PanelLights                      = Eclairage du tableau de bord
Common.ALL.RMK                              = RMK: Compresseur d'urgence
Common.ALL.KRP                              = KRP: Bouton de démarrage d'urgence
Common.ALL.VZP                              = VZP: Départ automatique
Common.ALL.VZD                              = VZD: Ouverture/fermture automatique des portes
Common.ALL.VAV                              = VAV: Conduite automatique
Common.ALL.RouteNumber1+                    = Augmenter le premier chiffre du numéro de route
Common.ALL.RouteNumber1-                    = Diminuer le premier chiffre du numéro de route
Common.ALL.RouteNumber2+                    = Augmenter le deuxième chiffre du numéro de route
Common.ALL.RouteNumber2-                    = Diminuer le deuxième chiffre du numéro de route
Common.ALL.RouteNumber3+                    = Augmenter le troisième chiffre du numéro de route
Common.ALL.RouteNumber3-                    = Diminuer le troisième chiffre du numéro de route
Common.ALL.LastStation+                     = Terminus suivant
Common.ALL.LastStation-                     = Terminus précédent
Common.ALL.RRP                              = RP: Lampe relai de surcharge rouge (les circuits d'alimentation n'ont pas pu s'activer)
Common.ALL.GRP                              = RP: Lampe relai de surcharge verte (empêche la surintensité des moteurs)
Common.ALL.RP                               = RP: Lampe relai de surcharge rouge (les circuits d'alimentation n'ont pas pu s'activer ou RP activé)
Common.ALL.SN                               = LSN: Lampe d'indication d'échec (les circuits d'alimentation n'ont pas pu s'activer)
Common.ALL.PU                               = Le paramètre réduit est activé
Common.ALL.BrT                              = Les freins pneumatiques du train sont activés
Common.ALL.BrW                              = Les freins pneumatiques de voiture sont engagés
Common.ALL.ARS                              = ARS: Régulateur automatique de vitesse
Common.ALL.ARSR                             = ARS-R: Limiteur de vitesse en mode ARS-R
Common.ALL.ALS                              = ALS: Signallisation automatique de locomotive
Common.ALL.RCARS                            = RC-ARS: Déconnexion des circuits de l'ARS
Common.ALL.RC1                              = RC-1: Déconnexion des circuits de l'ARS
Common.ALL.EPK                              = ARS Valve électro-pneumatique (EPK)
Common.ALL.EPV                              = ARS Valve électro-pneumatique (EPV)
Common.ARS.LN                               = LN: Signal de direction
Common.ARS.KT                               = KT: Lampe de contrôle de frein
Common.ARS.VD                               = VD: Le mode de conduite est désactivé par l'ARS
Common.ARS.Freq                             = Décodeur de l'ALS
Common.ARS.FreqD                            = (haut 1/5, bas 2/6)
Common.ARS.FreqU                            = (haut 2/6, bas 1/5)
Common.ARS.VP                               = Mode "train auxiliaire"
Common.ARS.RS                               = RS: Lampe de vitesse positive (le prochain segment a une limite de vitesse supérieure ou égale à l'actuelle)
Common.ARS.AB                               = Mode d'autoblocage de l'ARS
Common.ARS.ABButton                         = Bouton du mode d'autoblocage de l'ARS
Common.ARS.ABDriver                         = (conducteur)
Common.ARS.ABHelper                         = (assistant)
Common.ARS.AV                               = Malfonction de l'unité ARS-MP principale
Common.ARS.AV1                              = Malfonction de l'unité ARS-MP auxiliaire
Common.ARS.AB2                              = Bouton du mode d'autoblocage de l'ARS
Common.ARS.ARS                              = Mode d'ARS
Common.ARS.LRD                              = LRD: Permission d'avancer (si 0 sur l'ALS)
Common.ARS.VRD                              = VRD: Autoriser le mouvement(si 0 sur l'ALS)
Common.ARS.KB                               = KB: Bouton d'avertissement
Common.ARS.KVT                              = KVT: Bouton de confirmation de freinage
Common.ARS.KVTR                             = KVT: Bouton de confirmation d'ARS-R
Common.ARS.04                               = OCh: Absence de fréquence ARS
Common.ARS.0                                = 0 : Signal d'arrêt ARS
Common.ARS.N4                               = NCh: Absence de fréquence ARS
Common.ARS.40                               = Limitation de vitesse : 40 km/h
Common.ARS.60                               = Limitation de vitesse : 60 km/h
Common.ARS.70                               = Limitation de vitesse : 70 km/h
Common.ARS.80                               = Limitation de vitesse : 80 km/h
Common.ALL.RCBPS                            = RC-BPS: Unité d'anti roulement
Common.BPS.On                               = Unité d'antiroulement activée
Common.BPS.Err                              = Erreur de l'unité d'anti roulement
Common.BPS.Fail                             = Malfonction de l'unité d'anti roulement
Commom.NMnUAVA.NMPressureLow                = Lampe de basse pression dans la conduite principale
Commom.NMnUAVA.UAVATriggered                = Les contacts de l'UAVA sont ouverts
Common.ALL.LSD                              = Lampe d'état des portes (Les portes sont fermées)
Common.ALL.L1w                              = Lampe du 1er câble (mode de conduite engagé)
Common.ALL.L2w                              = Lampe du 2ème câble (manette rhéostat en mouvement)
Common.ALL.L6w                              = Lampe du 6ème câble (mode frein engagé)
Common.ALL.Horn                             = Sifflet
Common.ALL.DriverValveBLDisconnect          = Déconnecter la valve de conduite générale
Common.ALL.DriverValveTLDisconnect          = Déconnecter la valve de conduite principale
Common.ALL.DriverValveDisconnect            = Valve de déconnexion de la valve du conducteur
Common.ALL.KRMH                             = Activer la valve d'urgence du conducteur
Common.ALL.RVTB                             = RVTB: Valve dédiée au frein de sécurité
Common.ALL.FrontBrakeLineIsolationToggle    = Robinet d'arrêt de la conduite générale
Common.ALL.FrontTrainLineIsolationToggle    = Robinet d'arrêt de la conduite principale
Common.ALL.RearTrainLineIsolationToggle     = Robinet d'arrêt de la conduite générale
Common.ALL.RearBrakeLineIsolationToggle     = Robinet d'arrêt de la conduite principale
Common.ALL.UAVA                             = UAVA: Désactiver l'autostop\n(peut être activé après que la pression de la conduite générale soit tombée)
Common.ALL.UAVA2                            = UAVA: Désactiver l'autostop
Common.ALL.UAVAContact                      = Réinitialiser les contacts de l'UAVA
Common.ALL.OAVU                             = OAVU: Désactiver l'AVU
Common.ALL.LAVU                             = L'AVU est activé
Common.ALL.GV                               = Interrupteur principal
Common.ALL.AirDistributor                   = VRN: Désactivateur du distributeur d'air
Common.ALL.CabinDoor                        = Porte de cabine
Common.ALL.PassDoor                         = Porte du compartiment passager
Common.ALL.FrontDoor                        = Porte avant
Common.ALL.RearDoor                         = Porte arrière
Common.ALL.OtsekDoor1                       = Poignée du 1er compartiment d'équipement
Common.ALL.OtsekDoor2                       = Poignée du 2ème compartiment d'équipement
Common.ALL.CouchCap                         = Extraire le siège

Common.ALL.UNCh                             = UNCh: Amplificateur de basse fréquence
Common.ALL.ES                               = ES: Contrôle des communications d'urgence
Common.ALL.GCab                             = Haut-parleur: Son en cabine
Common.ALL.UPO                              = UPO: Annonceur
Common.ALL.R_Radio                          = Annonceur
Common.ALL.AnnPlay                          = Lampe d'annonceur en playback

#RRI
Train.Common.RRI                            = RRI: Relai radio de l'annonceur
Common.RRI.RRIUp                            = RRI: Configuration haut
Common.RRI.RRIDown                          = RRI: Configuration bas
Common.RRI.RRILeft                          = RRI: Configuration gauche
Common.RRI.RRIRight                         = RRI: Configuration droite
Common.RRI.RRIEnableToggle                  = RRI: Alimentation
Common.RRI.RRIRewindSet2                    = RRI: Accélérer
Common.RRI.RRIRewindSet0                    = RRI: Rembobiner
Common.RRI.RRIAmplifierToggle               = RRI: Amplifier
Common.RRI.RRIOn                            = Lampe d'opération RRI

#ASNP
Train.Common.ASNP           = ASNP
Common.ASNP.ASNPMenu        = ASNP: Menu
Common.ASNP.ASNPUp          = ASNP: Haut
Common.ASNP.ASNPDown        = ASNP: Bas
Common.ASNP.ASNPOn          = ASNP: Alimentation

#PVK
Common.CabVent.PVK-         = Réduit l'alimentation de la ventilation en cabine
Common.CabVent.PVK+         = Augmente l'alimentation de la ventilation en cabine

#IGLA
Train.Common.IGLA           = IGLA
Common.IGLA.Button1Up       = IGLA: Premier bouton haut
Common.IGLA.Button1         = IGLA: Premier bouton
Common.IGLA.Button1Down     = IGLA: Premier bouton bas
Common.IGLA.Button2Up       = IGLA: Deuxième bouton haut
Common.IGLA.Button2         = IGLA: Deuxième bouton
Common.IGLA.Button2Down     = IGLA: Deuxième bouton bas
Common.IGLA.Button23        = IGLA: Deuxième et troisième boutons
Common.IGLA.Button3         = IGLA: Troisième bouton
Common.IGLA.Button4         = IGLA: Quatrième bouton
Common.IGLA.IGLASR          = IGLA: Alimentation
Common.IGLA.IGLARX          = IGLA: Pas de connexion
Common.IGLA.IGLAErr         = IGLA: Erreur
Common.IGLA.IGLAOSP         = IGLA: Les sytèmes d'extinction des feux sont activés
Common.IGLA.IGLAPI          = IGLA: Feu
Common.IGLA.IGLAOff         = IGLA: Circuits haute tension désactivés

#BZOS
Common.BZOS.On      = Interrupteur d'alarme de sécurité
Common.BZOS.VH1     = L'alarme de sécurité est activée 
Common.BZOS.VH2     = L'alarme de sécurité est déclenchée
Common.BZOS.Engaged = L'alarme de sécurité est déclenchée

#Train helpers common
Common.ALL.SpeedCurr        = Vitesse actuelle
Common.ALL.SpeedAccept      = Vitesse autorisée
Common.ALL.SpeedAttent      = Vitesse autorisée sur la prochaine section
Common.ALL.Speedometer      = Speedomètre
Common.ALL.BLTLPressure     = Pression dans les tyuaux pneumatiques (rouge: conduite générale, noir: conduite principale)
Common.ALL.BCPressure       = Pression des cylindres de frein
Common.ALL.EnginesCurrent   = Courant des moteurs (A)
Common.ALL.EnginesCurrent1  = Courant des 1ers moteurs de traction (A)
Common.ALL.EnginesCurrent2  = Courant des 2èmes moteurs de traction (A)
Common.ALL.EnginesVoltage   = Tension des moteurs (kV)
Common.ALL.BatteryVoltage   = Tension de batterie (V)
Common.ALL.BatteryCurrent   = Courant de batterie (A)
Common.ALL.HighVoltage      = Haute tension (kV)
]]
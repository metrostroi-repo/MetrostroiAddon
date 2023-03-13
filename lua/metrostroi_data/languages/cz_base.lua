return [[
#Base text for Czech language

[cz]
lang        = Čeština                           				#Full language name
AuthorText  = Autor překladu: Silverpilen_CZ |СПЕЦНАЗ|      #Author text

#Workshop errors
Workshop.Title              = Manažér součástí
Workshop.FilesMissing       = Chybějící součásti nebo chybný addon.\nPokud jste nainstalovali addon z Workshopu, zkuste smazat soubor:\nGarrysMod/garrysmod/%s.
Workshop.FilesMissingLocaly = Chybějící součásti nebo chybný addon.
Workshop.InstalledLocaly    = Nainstalováno (místní soubory)
Workshop.NotInstalledE      = Nenainstalováno.\nPotvrďte odběr addonu a zkontrolujte to v menu "Addony".
Workshop.NotInstalled       = Nenainstalováno.
Workshop.Disabled           = Vypnout.\nZapnout v menu "Addony".
Workshop.Installed          = Nainstalováno
Workshop.Open               = Workshop
Workshop.ErrorGithub        = Zjištěna GitHub verze módu Metrostroi. Současná verze módu Metrostroi není kompatibilní a nebude fungovat s GitHub verzí módu Metrostroi.
Workshop.ErrorLegacy        = Žjištěna Legacy verze módu Metrostroi. Současná verze módu Metrostroi není kompatibilní a nebude fungovat s Legacy verzí módu Metrostroi.
Workshop.ErrorEnhancers     = Tento addon obsahuje vylepšení grafiky, které může narušit plynulost hry.
Workshop.Error1             = Tento addon obsahuje starý script kód módu Metrostroi, který není kompatibilní se současnou verzí. Může se zobrazit hláška "Scrips errors", a může se projevit nestabilita addonu.
Workshop.ErrorOld           = Nalezeny staré modely (81-702 a 81-717). Odstraňte původní herní obsah hry Metrostroi (složka garrysmod/addons), a odstraňte složky "cache", "download" a "downloads" ze složky "garrysmod".

#Client settings
Panel.Admin             = Admin
Panel.RequireThirdRail  = Zapnout nutnost přítomnosti přívodní kolejnice

Panel.Client            = Klient
Panel.Language          = Zvolit jazyk
Panel.DrawCams          = Renderovací kamery
Panel.DisableHUD        = Vypnout HUD v pozici strojvedoucího
Panel.DisableCamAccel   = Vypnout akceleraci pohledu
Panel.DisableHoverText  = Vypnout vysvětlivky
Panel.DisableHoverTextP = Disable additional information\nin tooltips #NEW
Panel.DisableSeatShadows= Disable seat shadows #NEW
Panel.ScreenshotMode    = Mód snímku obrazovky (NÍZKÉ FPS)
Panel.RedLights         = Zapnout dynamická červená světla
Panel.ShadowsHeadlight  = Zapnout odrazy reflektorů
Panel.ShadowsOther      = Zapnout odrazy ostatních\nzdrojů světla
Panel.MinimizedShow     = Nenačítat znovu součásti\npři minimalizování
Panel.PanelLights       = Enable dynamic lights\nfrom panel lamps #NEW
Panel.RouteNumber       = Route number #NEW
Panel.FOV               = FOV
Panel.Z                 = Výška kamery
Panel.RenderDistance    = Vykreslovací\nvzdálenost
Panel.RenderSignals     = Traced signals #NEW #FIXME
Panel.ReloadClient      = Znovu načíst klienta

Panel.ClientAdvanced    = Klient (pokročilý)
Panel.DrawDebugInfo     = Zobrazit informace pro vývojáře
Panel.DrawSignalDebugInfo     = Informace pro vývojáře (Signalizace)
Panel.CheckAddons       = Zkontrolovat addony
Panel.ReloadLang        = Znovu načíst jazyky
Panel.SoftDraw          = Doba načítání prvků vlaku
Panel.SoftReloadLang    = Znovu nenahrávat spawnovací menu



#Common train
Train.Common.Camera0        = Sedadlo strojvedoucího
Train.Common.RouteNumber    = Číslo turnusu
Train.Common.LastStation    = Konečná stanice
Train.Common.HelpersPanel   = Pomocný panel
Train.Common.UAVA           = Autostop (UAVA)
Train.Common.PneumoPanels   = Pneumatické ventily
Train.Common.Voltmeters     = Voltmetry a ampérmetry
Train.Common.CouplerCamera  = Spřáhlo/Spřáhla
Common.ARM.Monitor1         = Monitor 1 ARM

Train.Buttons.Sealed        = Sealed
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
Train.Buttons.VTRH2         = Second half of train #NEW #FIXME
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
Train.Buttons.BCPressure     = %.1f kgf/cm² #NEW #FIXME bar?
Train.Buttons.BLTLPressure   = TL: %.1f kgf/cm² BL:%.1f kgf/cm² #NEW #FIXME bar?

#Train entities
Entities.gmod_subway_base.Name        = Vozová základna
Entities.gmod_subway_81-502.Name      = 81-502 (Ema-502 čelní)
Entities.gmod_subway_81-501.Name      = 81-501 (Em-501 vložený)
Entities.gmod_subway_81-702.Name      = 81-702 (D čelní)
Entities.gmod_subway_81-702_int.Name  = 81-702 (D vložený)
Entities.gmod_subway_81-703.Name      = 81-703 (E čelní)
Entities.gmod_subway_81-703_int.Name  = 81-703 (E vložený)
Entities.gmod_subway_ezh.Name         = 81-707 (Ež čelní)
Entities.gmod_subway_ezh1.Name        = 81-708 (Ež1 vložený)
Entities.gmod_subway_ezh3.Name        = 81-710 (Ež3 čelní)
Entities.gmod_subway_em508t.Name      = 81-508T (Em-508T vložený)
Entities.gmod_subway_81-717_mvm.Name  = 81-717 (Moskevský čelní)
Entities.gmod_subway_81-717_mvm_custom.Name     = 81-717 (Moskevský uživatelský)
Entities.gmod_subway_81-714_mvm.Name  = 81-714 (Moskevský vložený)
Entities.gmod_subway_81-717_lvz.Name  = 81-717 (Petrohradský čelní)
Entities.gmod_subway_81-714_lvz.Name  = 81-714 (Petrohradský vložený)
Entities.gmod_subway_81-718.Name      = 81-718 (TISU čelní)
Entities.gmod_subway_81-719.Name      = 81-719 (TISU vložený)
Entities.gmod_subway_81-720.Name      = 81-720 (Jauza čelní)
Entities.gmod_subway_81-721.Name      = 81-721 (Jauza vložený)
Entities.gmod_subway_81-722.Name      = 81-722 (Jubilejnij čelní)
Entities.gmod_subway_81-723.Name      = 81-723 (Jubilejnij vložený)
Entities.gmod_subway_81-724.Name      = 81-724 (Jubilejnij vložený - bez pohonu)
Entities.gmod_subway_81-7036.Name     = 81-7036 (nefunguje)
Entities.gmod_subway_81-7037.Name     = 81-7037 (nefunguje)
Entities.gmod_subway_tatra_t3.Name    = Tatra T3

#Train util entities
Entities.gmod_train_bogey.Name        = Podvozek
Entities.gmod_train_couple.Name       = Spřáhlo

#Other entities
Entities.gmod_track_pui.Name                = PUI (Programovatelné zobrazovací zařízení)
Entities.gmod_track_mus_elektronika7.Name   = Digitální hodiny
Entities.gmod_mus_clock_analog.Name         = Analogové hodiny
Entities.gmod_track_clock_time.Name         = Velké intervalové hodiny(čas)
Entities.gmod_track_clock_small.Name        = Malé intervalové hodiny
Entities.gmod_track_clock_interval.Name     = Velké intervalové hodiny(interval)
Entities.gmod_track_switch.Name             = Výhybka
Entities.gmod_track_powermeter.Name         = Měříč výkonu
Entities.gmod_track_arm.Name                = ARM DSCP
Entities.gmod_track_udochka.Name            = Napájecí kabel
Entities.gmod_train_spawner.Name            = Spawner vozů metra
Entities.gmod_train_special_box.Name        = Speciální zásilka

#Weapons
Weapons.button_presser.Name                 = Spínač tlačítek
Weapons.button_presser.Purpose              = Určen pro pohodlné stisknutí tlačítek na mapách.
Weapons.button_presser.Instructions         = Najeďte na tlačítko a stiskněte tlačítko "Útok".
Weapons.train_key.Name                      = Klíč správce
Weapons.train_key.Purpose                   = Určen pro použití na zablokovaná tlačítka (pouze pro správce).
Weapons.train_key.Instructions              = Najeďte na tlačítko pro správce a stiskněte tlačítko "Útok".
Weapons.train_kv_wrench.Name                = Klíč reversu
Weapons.train_kv_wrench.Purpose             = Určen pro používání ve vozech metra a stisknutí různých tlačítek v nich.
Weapons.train_kv_wrench.Instructions        = Najeďte na tlačítko ve vlaku a stiskněte tlačítko "Útok".
Weapons.train_kv_wrench_gold.Name           = Zlatý klíč reversu

Weapons.train_kv_wrench_gold.Purpose        = @[Weapons.train_kv_wrench.Purpose]
Weapons.train_kv_wrench_gold.Instructions   = @[Weapons.train_kv_wrench.Instructions]

#Spawner common
Spawner.Title                           = Spawner vozů metra
Spawner.Spawn                           = Spawnout
Spawner.Close                           = Zavřít
Spawner.Trains1                         = Max. počet vozů v soupravě
Spawner.Trains2                         = Na hráče
Spawner.WagNum                          = Počet vozů
Spawner.PresetTitle                     = Předvolby
Spawner.Preset.New                      = Nová předvolba
Spawner.Preset.Unsaved                  = Uložit předvolbu
Spawner.Preset.NewTooltip               = Vytvořit
Spawner.Preset.UpdateTooltip            = Aktualizovat
Spawner.Preset.RemoveTooltip            = Vymazat
Spawner.Presets.NamePlaceholder         = Název předvolby
Spawner.Presets.Name                    = Název
Spawner.Presets.NameError               = Neplatný název
Spawner.Preset.NotSelected              = Předvolba není vybraná
Common.Spawner.Texture      = Textura vozu
Common.Spawner.PassTexture  = Textura interiéru
Common.Spawner.CabTexture   = Textura kabiny
Common.Spawner.Announcer    = Vlakový rozhlas
Common.Spawner.Type1        = Typ 1
Common.Spawner.Type2        = Typ 2
Common.Spawner.Type3        = Typ 3
Common.Spawner.Type4        = Typ 4
Common.Spawner.SpawnMode                = Stav vlaku
Common.Spawner.SpawnMode.Deadlock       = Odstaven
Common.Spawner.SpawnMode.Full           = Uveden do provoz. stavu
Common.Spawner.SpawnMode.NightDeadlock  = Noční odstavení
Common.Spawner.SpawnMode.Depot          = Depo
Spawner.Common.EType                    = Typ elektrických obvodů
Common.Spawner.Scheme                   = Schéma metra nad dveřmi
Common.Spawner.Random                   = Náhodný
Common.Spawner.Old                      = Starý
Common.Spawner.New                      = Nový
Common.Spawner.Type                     = Typ
Common.Spawner.SchemeInvert             = Obrátit schéma metra

#Coupler common
Common.Couple.Title         = Menu spřáhla
Common.Couple.CoupleState   = Poloha spřáhla
Common.Couple.Coupled       = Spřaženo
Common.Couple.Uncoupled     = Nespřaženo
Common.Couple.Uncouple      = Odpřáhnout
Common.Couple.IsolState     = Poloha izolačních ventilů
Common.Couple.Isolated      = Zavřeny
Common.Couple.Opened        = Otevřeny
Common.Couple.Open          = Otevřít
Common.Couple.Isolate       = Zavřít
Common.Couple.EKKState      = Poloha EKK (Kontaktní svorkovnice spřáhla vozu)
Common.Couple.Disconnected  = Odpojena
Common.Couple.Connected     = Připojena
Common.Couple.Connect       = Připojit
Common.Couple.Disconnect    = Odpojit

#Bogey common
Common.Bogey.Title              = Menu podvozku
Common.Bogey.ContactState       = Poloha sběračů
Common.Bogey.CReleased          = Odpojeny
Common.Bogey.CPressed           = Připojeny
Common.Bogey.CPress             = Připojit
Common.Bogey.CRelease           = Odpojit
Common.Bogey.ParkingBrakeState  = Poloha parkovací brzy
Common.Bogey.PBDisabled         = Ručně vypnuta
Common.Bogey.PBEnabled          = Zapnuta
Common.Bogey.PBEnable           = Zapnout
Common.Bogey.PBDisable          = Ručně vypnout

#Trains common
Common.ALL.Unsused1                         = Nevyužito
Common.ALL.Unsused2                         = (nevyužito)
Common.ALL.Up                               = (nahoru)
Common.ALL.Down                             = (dolů)
Common.ALL.Left                             = (doleva)
Common.ALL.Right                            = (doprava)
Common.ALL.CW                               = (ve směru hodinových ručiček)
Common.ALL.CCW                              = (proti směru hodinových ručiček)
Common.ALL.VB                               = VB: Baterie zapnuto/vypnuto
Common.ALL.VSOSD                            = SOSD: Kontrolka otevření dveří ve stanici
Common.ALL.VKF                              = VKF: Napájení baterie (červená světla)
Common.ALL.VB2                              = (Nízkonapěťové jističe)
Common.ALL.VPR                              = VPR: Radiostanice
Common.ALL.VASNP                            = Napájení ASNP
Common.ALL.UOS                              = RC-UOS: Odpojovač obvodů omezovače rychlosti (jízda bez EPV/EPK)
Common.ALL.VAH                              = VAH: Nouzová jízda
Common.ALL.KAH                              = KAH: Tlačítko nouzové jízdy bez ARS
Common.ALL.KAHK                             = Krytka tlačítka KAH
Common.ALL.VAD                              = VAD: Jízda bez kontroly zavření dveří
Common.ALL.OVT                              = OVT: Odpojení vzduchových brzd
Common.ALL.VOVT                             = VOVT: Vypnout odpojovač vzduchových brzd
Common.ALL.EmergencyBrakeValve              = Záchranná brzda
Common.ALL.ParkingBrake                     = Parkovací brzda
Common.ALL.VU                               = VU: Řízení
Common.ALL.KDP                              = KDP: Otevřít pravé dveře
Common.ALL.KDPL                             = Kontrolka: Pravé dveře jsou zvoleny
Common.ALL.KDPK                             = Krytka tlačítka pravých dveří
Common.ALL.KDL                              = KDL: Otevřít levé dveře
Common.ALL.KDLL                             = Kontrolka: Levé dveře jsou zvoleny
Common.ALL.KDLK                             = Krytka tlačítka levých dveří
Common.ALL.KDLPK                            = Krytka tlačítek dveří
Common.ALL.KRZD                             = KRZD: Dveře nouze
Common.ALL.VSD                              = Kontrola dveří: Levé/pravé
Common.ALL.Ring                             = Zvonek
Common.ALL.VUD                              = VUD: Zavření dveří
Common.ALL.KDPH                             = Otevřít pravé dveře posledního vozu
Common.ALL.VUD2                             = VUD2: Zavření dveří z místa pomocníka strojvedoucího
Common.ALL.Program1                         = Start hlášení (Program 1)
Common.ALL.Program2                         = Start hlášení (Program 2)
Common.ALL.VRP                              = VRP: Resetovat přetížené relé
Common.ALL.VRPBV                            = VRP: Resetovat přetížené relé, zapnout BV
Common.ALL.KSN                              = KSN: Porucha řízení
Common.ALL.VMK                              = VMK: Kompresor
Common.ALL.MK                               = Kompresor
Common.ALL.VF1                              = Světla 1. skupiny
Common.ALL.VF2                              = Světla 2. skupiny
Common.ALL.VF                               = Přepínač světel
Common.ALL.VUS                              = VUS: Světla/Světla dálková
Common.ALL.GaugeLights                      = Osvětlení přístojů
Common.ALL.CabLights                        = Osvětlení kabiny
Common.ALL.PassLights                       = Osvěltení interiéru
Common.ALL.PanelLights                      = Osvětlení pultu
Common.ALL.RMK                              = RMK: Kompresor nouze
Common.ALL.KRP                              = KRP: Nouzové řízení
Common.ALL.VZP                              = VZP: Tlačítko pozastavení odjezdu soupravy (režim RAV)
Common.ALL.VZD                              = VZD: Tlačítko pozastavení zavření dveří (režim RAV)
Common.ALL.VAV                              = VAV: Režim automatického vedení (RAV)
Common.ALL.RouteNumber1+                    = Turnus: Zvýšit 1. číslo
Common.ALL.RouteNumber1-                    = Turnus: Snížit 1. číslo
Common.ALL.RouteNumber2+                    = Turnus: Zvýšit 2. číslo
Common.ALL.RouteNumber2-                    = Turnus: Snížit 2. číslo
Common.ALL.RouteNumber3+                    = Turnus: Zvýšit 1. číslo
Common.ALL.RouteNumber3-                    = Turnus: Snížit 3. číslo
Common.ALL.LastStation+                     = Další konečná stanice
Common.ALL.LastStation-                     = Předešlá konečná stanice
Common.ALL.RRP                              = RP: Červené světlo přetížení relé (nelze zkompletovat elektrické obvody)
Common.ALL.GRP                              = RP: Zelené světlo přehřátí relé (zabraňuje nadproudu trakčních motorů)
Common.ALL.RP                               = RP: Červené světlo přetížení relé (nelze zkompletovat elektrické obvody, nebo přehřátí relé)
Common.ALL.SN                               = LSN: Přetížení relé (nelze zkompletovat elektrické obvody)
Common.ALL.PU                               = Režim sníženého výkonu zapnut
Common.ALL.BrT                              = Pneumatické brzdy (souprava)
Common.ALL.BrW                              = Pneumatické brzdy (vůz)
Common.ALL.ARS                              = ARS: Automatická regulace rychlosti
Common.ALL.ARSR                             = ARS-R: Automatická regulace rychlosti (rezervní systém)
Common.ALL.ALS                              = ALS: Automatická lokomotivní signalizace
Common.ALL.RCARS                            = RC-ARS: Odpojovač řídicích obvodů ARS
Common.ALL.RC1                              = RC-1: Odpojovač řídicích obvodů ARS
Common.ALL.EPK                              = Elektropneumatický ventil ARS (EPK)
Common.ALL.EPV                              = Elektropneumatický ventil ARS (EPV)
Common.ARS.LN                               = LN: Kontrolka směru jízdy
Common.ARS.KT                               = KT: Indikátor brzdění
Common.ARS.VD                               = VD: Řízení vypnuto systémem ARS
Common.ARS.Freq                             = Dekodér: Přepínač kódování frekvencí ALS
Common.ARS.FreqD                            = (nahoru - 1/5, dolů - 2/6)
Common.ARS.FreqU                            = (nahoru - 2/6, dolů - 1/5)
Common.ARS.VP                               = Režim "Pomocná souprava"
Common.ARS.RS                               = RS: Předvěst (rychlost v dalším oddílu je stejná nebo vyšší)
Common.ARS.AB                               = Provoz v režimu automatického bloku
Common.ARS.ABButton                         = Provoz v režimu automatického bloku
Common.ARS.ABDriver                         = (tlačítko strojvedoucího)
Common.ARS.ABHelper                         = (tlačítko pomocníka strojvedoucího)
Common.ARS.AV                               = Závada hlavní jednotky ARS-MP
Common.ARS.AV1                              = Závada záložní jednotky ARS-MP
Common.ARS.AB2                              = Změna systému ARS do režimu AB
Common.ARS.ARS                              = Režim ARS
Common.ARS.LRD                              = LRD: Kontrolka, povolující jízdu proti návěsti Stůj! (ALS - Kód 0)
Common.ARS.VRD                              = VRD: Jízda proti návěsti Stůj! (ALS - Kód 0)
Common.ARS.KB                               = KB: Tlačítko bdělosti
Common.ARS.KVT                              = KVT: Tlačítko bdělosti
Common.ARS.KVTR                             = KVT: Tlačítko bdělosti (režim ARS-R)
Common.ARS.04                               = OČ: Bez kódu
Common.ARS.N4                               = NČ: Bez kódu
Common.ARS.0                                = 0: Kód 0 (Návěst zastavení)
Common.ARS.40                               = Rychlost 40 km/h
Common.ARS.60                               = Rychlost 60 km/h
Common.ARS.70                               = Rychlost 70 km/h
Common.ARS.80                               = Rychlost 80 km/h
Common.ALL.RCBPS                            = RC-BPS: Odpojovač protiskluzového bloku
Common.BPS.On                               = Protiskluzový blok zapnut
Common.BPS.Err                              = Chyba protiskluzového bloku
Common.BPS.Fail                             = Závada protiskluzového bloku
Commom.NMnUAVA.NMPressureLow                = Kontrolka: Nízký tlaku vzduchu (brzdy)
Commom.NMnUAVA.UAVATriggered                = Kontrolka: Kontakty Autostopu (UAVA) jsou rozpojeny
Common.ALL.LSD                              = Signalizace zavření dveří
Common.ALL.L1w                              = Kontrolka 1. vodiče (řídící režím zapojen)
Common.ALL.L2w                              = Kontrolka 2. vodiče (rotace reostatu)
Common.ALL.L6w                              = Kontrolka 6. vodiče (brzdový režim zapojen)
Common.ALL.Horn                             = Houkačka
Common.ALL.DriverValveBLDisconnect          = Ventil brzdového potrubí
Common.ALL.DriverValveTLDisconnect          = Ventil hlavního potrubí
Common.ALL.DriverValveDisconnect            = Ventil brzdiče
Common.ALL.KRMH                             = KRMSH: Nouzové zprovoznění brzdiče
Common.ALL.RVTB                             = RVTB: Rezervní ventil bezpečnostní brzdy
Common.ALL.FrontBrakeLineIsolationToggle    = Izolační ventil brzdového potrubí
Common.ALL.FrontTrainLineIsolationToggle    = Izolační ventil hlavního potrubí
Common.ALL.RearTrainLineIsolationToggle     = Izolační ventil hlavního potrubí
Common.ALL.RearBrakeLineIsolationToggle     = Izolační ventil brzdového potrubí
Common.ALL.UAVA                             = UAVA: Autostop\n(lze zapnout po snížení tlaku v hlavním potrubí)
Common.ALL.UAVA2                            = UAVA: Autostop
Common.ALL.UAVAContact                      = UAVA: Autostop (obnovení kontaktů)
Common.ALL.OAVU                             = OAVU: Tlačitko vypnutí AVU (Automatický odpojovač řízení)
Common.ALL.LAVU                             = AVU (Automatický odpojovač řízení) je aktivován
Common.ALL.GV                               = Hlavní vypínač
Common.ALL.AirDistributor                   = VRN: Vypínač rozdělovače vzduchu
Common.ALL.CabinDoor                        = Dveře kabiny
Common.ALL.PassDoor                         = Dveře z kabiny do interiéru
Common.ALL.FrontDoor                        = Přední dveře
Common.ALL.RearDoor                         = Zadní dveře
Common.ALL.OtsekDoor1                       = Klika: Otevřít 1. přístrojovou komoru
Common.ALL.OtsekDoor2                       = Klika: Otevřít 2. přístrojovou komoru
Common.ALL.CouchCap                         = Sklopení sedadla

Common.ALL.UNCh                             = UNCh: Zesilovač nízkích frekvencí
Common.ALL.ES                               = ES: Nouzové komunikační zařízení
Common.ALL.GCab                             = Vlakový rozhlas v kabině
Common.ALL.UPO                              = UPO: Vlakový rozhlas
Common.ALL.R_Radio                          = Vlakový rozhlas
Common.ALL.AnnPlay                          = Kontrolka přehrávání vlakového rozhlasu

#RRI
Train.Common.RRI                            = RRI: Radioreléový rozhlas
Common.RRI.RRIUp                            = RRI: Nastavení (nahoru)
Common.RRI.RRIDown                          = RRI: Nastavení (dolů)
Common.RRI.RRILeft                          = RRI: Nastavení (doleva)
Common.RRI.RRIRight                         = RRI: Nastavení (doprava)
Common.RRI.RRIEnableToggle                  = RRI: Napájení
Common.RRI.RRIRewindSet2                    = RRI: Přetočit dopředu
Common.RRI.RRIRewindSet0                    = RRI: Přetočit dozadu
Common.RRI.RRIAmplifierToggle               = RRI: Zesilovač
Common.RRI.RRIOn                            = Kontrolka chodu RRI

#ASNP
Train.Common.ASNP           = ASNP
Common.ASNP.ASNPMenu        = ASNP: Menu
Common.ASNP.ASNPUp          = ASNP: Nahoru
Common.ASNP.ASNPDown        = ASNP: Dolů
Common.ASNP.ASNPOn          = ASNP: Napájení

#PVK
Common.CabVent.PVK-         = Snížit výkon ventilace v kabině
Common.CabVent.PVK+         = Zvýšit výkon ventilace v kabině

#IGLA
Train.Common.IGLA           = IGLA
Common.IGLA.Button1Up       = IGLA: První tlačítko (nahoru)
Common.IGLA.Button1         = IGLA: První tlačítko
Common.IGLA.Button1Down     = IGLA: První tlačítko (dolů)
Common.IGLA.Button2Up       = IGLA: Druhé tlačítko (nahoru)
Common.IGLA.Button2         = IGLA: Druhé tlačítko
Common.IGLA.Button2Down     = IGLA: Druhé tlačítko (dolů)
Common.IGLA.Button23        = IGLA: Druhé a třetí tlačítko
Common.IGLA.Button3         = IGLA: Třetí tlačítko
Common.IGLA.Button4         = IGLA: Čtvrté tlačítko
Common.IGLA.IGLASR          = IGLA: Napájení
Common.IGLA.IGLARX          = IGLA: Bez připojení
Common.IGLA.IGLAErr         = IGLA: Chyba
Common.IGLA.IGLAOSP         = IGLA: Protipožární systém aktivován
Common.IGLA.IGLAPI          = IGLA: Požár
Common.IGLA.IGLAOff         = IGLA: Obvody hlavního vypínače odpojeny

#BZOS
Common.BZOS.On      = Vypínač poplašného zařízení
Common.BZOS.VH1     = Poplašné zařízení zapnuto
Common.BZOS.VH2     = Poplašné zařízení aktivováno
Common.BZOS.Engaged = Poplašné zařízení aktivováno

#Train helpers common
Common.ALL.SpeedCurr        = Skutečná rychlost
Common.ALL.SpeedAccept      = Povolená rychlost
Common.ALL.SpeedAttent      = Předvěst (povolená rychlost v příštím kolej. obvodu)
Common.ALL.Speedometer      = Rychloměr
Common.ALL.BLTLPressure     = Napájecí-brzdové potrubí (červená: brzdové potrubí, černá: hlavní potrubí)
Common.ALL.BCPressure       = Tlak v brzdovém válci
Common.ALL.EnginesCurrent   = Výkon trakčních motorů (A)
Common.ALL.EnginesCurrent1  = Výkon 1. skupiny trakčních motorů (A)
Common.ALL.EnginesCurrent2  = Výkon 2. skupiny trakčních motorů (A)
Common.ALL.EnginesVoltage   = Napětí trakčních motorů (kV)
Common.ALL.BatteryVoltage   = Napětí baterie (V)
Common.ALL.BatteryCurrent   = Proud baterie (A)
Common.ALL.HighVoltage      = Vysoké napětí (kV)
]]
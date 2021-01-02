return [[
#Base text for English language

[en]
lang        = English                           #Full language name
AuthorText  = Translation Author: Pollitto      #Author text

#Workshop errors
Workshop.Title              = Content manager
Workshop.FilesMissing       = Missing some addon files or addon is corrupted.\nIf addons has installed from Workshop, try to delete a file:\nGarrysMod/garrysmod/%s.
Workshop.FilesMissingLocaly = Missing some addon files or addon is corrupted.
Workshop.InstalledLocaly    = Installed (local)
Workshop.NotInstalledE      = Not installed.\nSubscribe to the addon and check it in the "Addons" menu.
Workshop.NotInstalled       = Not installed.
Workshop.Disabled           = Disabled.\nEnable it in the "Addons" menu.
Workshop.Installed          = Installed
Workshop.Open               = Workshop
Workshop.ErrorGithub        = Detected GitHub version of the Metrostroi. Current Metrostroi version is not compatible and cannot work with GitHub version of Metrostroi.
Workshop.ErrorLegacy        = Detected Legacy version of the Metrostroi. Current Metrostroi version is not compatible and cannot work with Legacy version of Metrostroi.
Workshop.ErrorEnhancers     = This addon contains a graphic enhancers that may interfere with the game experience.
Workshop.Error1             = This addon contain an old script code of the Metrostroi that conflicts with current. May be "Scripts errors" and unstable work of the addon.
Workshop.ErrorOld           = Old models detected (81-702 and 81-717 old models). Check and remove old metrostroi content files, remove "cache", "download" and "downloads" folders from "garrysmod" folder.

#Client settings
Panel.Admin             = Admin
Panel.RequireThirdRail  = Require third rail

Panel.Client            = Client
Panel.Language          = Select language
Panel.DrawCams          = Render cameras
Panel.DisableHUD        = Disable HUD in the driver seat
Panel.DisableCamAccel   = Disable camera acceleration
Panel.DisableHoverText  = Disable hover text
Panel.ScreenshotMode    = Screenshot mode (LOW FPS)
Panel.ShadowsHeadlight  = Enable headlight shadows
Panel.RedLights         = Enable dynamic light\nof red lights
Panel.ShadowsOther      = Enable shadows from other\nlight sources
Panel.MinimizedShow     = Don't unload an elements\nwhen minimized
Panel.FOV               = FOV
Panel.RenderDistance    = Render distance
Panel.ReloadClient      = Reload client side

Panel.ClientAdvanced    = Client (advanced)
Panel.DrawDebugInfo     = Draw debug information
Panel.DrawSignalDebugInfo     = Signalling debug info #FIXME
Panel.CheckAddons       = Scan addons
Panel.ReloadLang        = Reload languages
Panel.SoftDraw          = Elements "smooth\nloading" percent
Panel.SoftReloadLang    = Don't reload a spawnmenu



#Common train
Train.Common.Camera0        = Driver's seat
Train.Common.RouteNumber    = Route number
Train.Common.LastStation    = Last station
Train.Common.HelpersPanel   = Helper's panel
Train.Common.UAVA           = UAVA #FIXME
Train.Common.PneumoPanels   = Pneumatic valves #FIXME
Train.Common.Voltmeters     = Voltmeters and amperemeters #FIXME
Train.Common.CouplerCamera  = Coupler
Common.ARM.Monitor1         = Monitor 1 ARM
Train.Buttons.Sealed        = Sealed

#Train entities
Entities.gmod_subway_base.Name        = Subway base
Entities.gmod_subway_81-502.Name      = 81-502 (Ema-502 head)
Entities.gmod_subway_81-501.Name      = 81-501 (Em-501 intermediate)
Entities.gmod_subway_81-702.Name      = 81-702 (D head)
Entities.gmod_subway_81-702_int.Name  = 81-702 (D intermediate)
Entities.gmod_subway_81-703.Name      = 81-703 (E head)
Entities.gmod_subway_81-703_int.Name  = 81-703 (E intermediate)
Entities.gmod_subway_ezh.Name         = 81-707 (Ezh head)
Entities.gmod_subway_ezh1.Name        = 81-708 (Ezh1 intermediate)
Entities.gmod_subway_ezh3.Name        = 81-710 (Ezh3 head)
Entities.gmod_subway_em508t.Name      = 81-508T (Em-508T intermediate)
Entities.gmod_subway_81-717_mvm.Name  = 81-717 (Moscow head)
Entities.gmod_subway_81-717_mvm_custom.Name     = 81-717 (Moscow custom) #FIXME
Entities.gmod_subway_81-714_mvm.Name  = 81-714 (Moscow intermediate)
Entities.gmod_subway_81-717_lvz.Name  = 81-717 (St. Petersburg head)
Entities.gmod_subway_81-714_lvz.Name  = 81-714 (St. Petersburg intermediate)
Entities.gmod_subway_81-718.Name      = 81-718 (TISU head)
Entities.gmod_subway_81-719.Name      = 81-719 (TISU intermediate)
Entities.gmod_subway_81-720.Name      = 81-720 (Yauza head)
Entities.gmod_subway_81-721.Name      = 81-721 (Yauza intermediate)
Entities.gmod_subway_81-722.Name      = 81-722 (Yubileyniy head)
Entities.gmod_subway_81-723.Name      = 81-723 (Yubileyniy intermediate motor)
Entities.gmod_subway_81-724.Name      = 81-724 (Yubileyniy intermediate trailer)
Entities.gmod_subway_81-7036.Name     = 81-7036 (doesn't work)
Entities.gmod_subway_81-7037.Name     = 81-7037 (doesn't work)
Entities.gmod_subway_tatra_t3.Name    = Tatra T3

#Train util entities
Entities.gmod_train_bogey.Name        = Bogey
Entities.gmod_train_couple.Name       = Coupler

#Other entities
Entities.gmod_track_pui.Name                = PUI
Entities.gmod_track_mus_elektronika7.Name   = "Electronika" clock
Entities.gmod_mus_clock_analog.Name         = Analog clock
Entities.gmod_track_clock_time.Name         = Big interval clock (time)
Entities.gmod_track_clock_small.Name        = Small interval clock
Entities.gmod_track_clock_interval.Name     = Big interval clock (interval)
Entities.gmod_track_switch.Name             = Track switch
Entities.gmod_track_powermeter.Name         = Power meter
Entities.gmod_track_arm.Name                = ARM DSCP
Entities.gmod_track_udochka.Name            = Power connector
Entities.gmod_train_spawner.Name            = Train spawner
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
Common.Spawner.Texture                  = Body skin
Common.Spawner.PassTexture              = Interior skin
Common.Spawner.CabTexture               = Cabin skin
Common.Spawner.Announcer                = Announcer type
Common.Spawner.Type1                    = Type 1
Common.Spawner.Type2                    = Type 2
Common.Spawner.Type3                    = Type 3
Common.Spawner.Type4                    = Type 4
Common.Spawner.SpawnMode                = Train state #FIXME
Common.Spawner.SpawnMode.Deadlock       = Dead-end #FIXME
Common.Spawner.SpawnMode.Full           = Fully started #FIXME
Common.Spawner.SpawnMode.NightDeadlock  = Dead-end after night #FIXME
Common.Spawner.SpawnMode.Depot          = Cold and dark #FIXME
Spawner.Common.EType                    = Electric circuits type #FIXME
Common.Spawner.Scheme                   = Line schemes
Common.Spawner.Random                   = Random #FIXME
Common.Spawner.Old                      = Old #FIXME
Common.Spawner.New                      = New #FIXME
Common.Spawner.Type                     = Type #FIXME
Common.Spawner.SchemeInvert             = Invert line schemes

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
Common.ALL.Unsused1                         = Unused
Common.ALL.Unsused2                         = (unused)
Common.ALL.Up                               = (up) #FIXME
Common.ALL.Down                             = (down) #FIXME
Common.ALL.Left                             = (left) #FIXME
Common.ALL.Right                            = (right) #FIXME
Common.ALL.CW                               = (clockwise) #FIXME
Common.ALL.CCW                              = (counter-clockwise) #FIXME
Common.ALL.VB                               = VB: Battery on/off
Common.ALL.VSOSD                            = SOSD: Station doors opening lamp
Common.ALL.VKF                              = VKF: Battery power for red lights
Common.ALL.VB2                              = (Low voltage circuits)
Common.ALL.VPR                              = VPR: Train radiostation
Common.ALL.VASNP                            = ASNP power
Common.ALL.UOS                              = RC-UOS: Speed Limitation Device (driving w/o EPV/EPK)
Common.ALL.VAH                              = VAH: Emergency driving mode (failure of RPB relay)
Common.ALL.KAH                              = KAH: Emergency drive button for driving w/o ARS
Common.ALL.KAHK                             = KAH button cover #FIXME
Common.ALL.VAD                              = VAD: Emergency door close override (failure of KD relay)
Common.ALL.OVT                              = OVT: Disable pneumatic valves brake
Common.ALL.VOVT                             = VOVT: Turn off pneumatic valve brakes disabler
Common.ALL.EmergencyBrakeValve              = Emergency brake
Common.ALL.ParkingBrake                     = Parking brake #FIXME
Common.ALL.VU                               = VU: Train control switch
Common.ALL.KDP                              = KDP: Open right doors
Common.ALL.KDPL                             = Right doors side is selected #FIXME
Common.ALL.KDPK                             = Right doors button cover
Common.ALL.KDL                              = KDL: Open left doors
Common.ALL.KDLL                             = Left doors side is selected #FIXME
Common.ALL.KDLK                             = Left doors button cover
Common.ALL.KDLPK                            = Door buttons cover
Common.ALL.KRZD                             = KRZD: Emergency door closing
Common.ALL.VSD                              = Doors side selector #FIXME
Common.ALL.Ring                             = Ring
Common.ALL.VUD                              = VUD: Door control toggle (close doors)
Common.ALL.KDPH                             = Open right doors of the last car
Common.ALL.VUD2                             = VUD2: Close doors from the helper's side
Common.ALL.Program1                         = Program I
Common.ALL.Program2                         = Program II
Common.ALL.VRP                              = VRP: Reset overload relay
Common.ALL.VRPBV                            = VRP: Reset overload relay, enable BV #FIXME
Common.ALL.KSN                              = KSN: Malfunction signalling
Common.ALL.VMK                              = VMK: Compressor
Common.ALL.MK                               = Compressor #FIXME (without acronym)
Common.ALL.VF1                              = 1st headlight group
Common.ALL.VF2                              = 2nd headlight group
Common.ALL.VF                               = Headlights switch
Common.ALL.VUS                              = VUS: Head lights bright/dim
Common.ALL.GaugeLights                      = Gauges lighting
Common.ALL.CabLights                        = Cabin lighting
Common.ALL.PassLights                       = Passenger compartment lighting #FIXME
Common.ALL.PanelLights                      = Control panel lighting #FIXME
Common.ALL.RMK                              = RMK: Emergency compressor
Common.ALL.KRP                              = KRP: Emergency start button
Common.ALL.VZP                              = VZP: Disable drive delay
Common.ALL.VZD                              = VZD: Disable doors delay
Common.ALL.VAV                              = VAV: Autodrive switch
Common.ALL.RouteNumber1+                    = Increase first digit of the route number
Common.ALL.RouteNumber1-                    = Decrease first digit of the route number
Common.ALL.RouteNumber2+                    = Increase second digit of the route number
Common.ALL.RouteNumber2-                    = Decrease first digit of the route number
Common.ALL.RouteNumber3+                    = Increase third digit of the route number
Common.ALL.RouteNumber3-                    = Decrease first digit of the route number
Common.ALL.LastStation+                     = Next last station
Common.ALL.LastStation-                     = Previous last station
Common.ALL.RRP                              = RP: Red overload relay lamp (power circuits failed to assemble)
Common.ALL.GRP                              = RP: Green overload relay lamp (prevents overcurrent of engines)
Common.ALL.RP                               = RP: Red overload relay lamp (power circuits failed to assemble or RP activated)
Common.ALL.SN                               = LSN: Failure indicator light (power circuits failed to assemble)
Common.ALL.PU                               = Reduced power mode indicator
Common.ALL.BrT                              = Train pneumobrakes are engaged
Common.ALL.BrW                              = Wagon pneumobrakes are engaged #FIXME
Common.ALL.ARS                              = ARS: Automatic speed regulation switch
Common.ALL.ARSR                             = ARS-R: Automatic speed regulation in ARS-R mode switch
Common.ALL.ALS                              = ALS: Automatic locomotive signalling
Common.ALL.RCARS                            = RC-ARS: ARS circuits disconnect #FIXME (same as RC-1)
Common.ALL.RC1                              = RC-1: ARS circuits disconnect
Common.ALL.EPK                              = ARS electropneumatic valve (EPK)
Common.ALL.EPV                              = ARS electropneumatic valve (EPV)
Common.ARS.LN                               = LN: Direction signal
Common.ARS.KT                               = KT: Braking control lamp
Common.ARS.VD                               = VD: Drive mode has turned off by ARS
Common.ARS.Freq                             = ALS decoder switch
Common.ARS.FreqD                            = (up 1/5, down 2/6)
Common.ARS.FreqU                            = (up 2/6, down 1/5)
Common.ARS.VP                               = "Auxiliary train" mode #FIXME
Common.ARS.RS                               = RS: Speed equality light (next segment speed limit equal or greater to current)
Common.ARS.AB                               = Autoblocking ARS mode
Common.ARS.ABButton                         = Autoblocking ARS mode button
Common.ARS.ABDriver                         = (driver's)
Common.ARS.ABHelper                         = (helper's)
Common.ARS.AV                               = Main ARS-MP unit malfunction
Common.ARS.AV1                              = Spare ARS-MP unit malfunction
Common.ARS.AB2                              = Autoblocking ARS mode button
Common.ARS.ARS                              = ARS mode
Common.ARS.LRD                              = LRD: Move permission (when 0 on ALS)
Common.ARS.VRD                              = VRD: Allow movement(when 0 on ALS)
Common.ARS.KB                               = KB: Attention button
Common.ARS.KVT                              = KVT: Brake perception button
Common.ARS.KVTR                             = KVT: ARS-R brake perception button
Common.ARS.04                               = OCh: No ARS frequency
Common.ARS.N4                               = NCh: No ARS frequency #FIXME (same as OCh but NCh)
Common.ARS.0                                = 0: ARS stop signal
Common.ARS.40                               = Speed limit 40 km/h
Common.ARS.60                               = Speed limit 60 km/h
Common.ARS.70                               = Speed limit 70 km/h
Common.ARS.80                               = Speed limit 80 km/h
Common.ALL.RCBPS                            = RC-BPS: Anti-Rolling unit switch
Common.BPS.On                               = Anti-Rolling unit operation
Common.BPS.Err                              = Anti-Rolling unit error
Common.BPS.Fail                             = Anti-Rolling unit malfunction
Commom.NMnUAVA.NMPressureLow                = Low train line pressure lamp
Commom.NMnUAVA.UAVATriggered                = UAVA contacts are open
Common.ALL.LSD                              = Train doors state light (doors are closed) #FIXME
Common.ALL.L1w                              = 1st wire lamp (drive mode engaged)
Common.ALL.L2w                              = 2nd wire lamp (rheostat controller motion)
Common.ALL.L6w                              = 6th wire lamp (brake mode engaged)
Common.ALL.Horn                             = Horn #FIXME
Common.ALL.DriverValveBLDisconnect          = Brake line disconnect valve
Common.ALL.DriverValveTLDisconnect          = Train line disconnect valve
Common.ALL.DriverValveDisconnect            = Driver's valve disconnect valve #FIXME
Common.ALL.KRMH                             = KRMSH: Driver's valve emergency enable #FIXME
Common.ALL.RVTB                             = RVTB: Reserved valve of safety brake #FIXME
Common.ALL.FrontBrakeLineIsolationToggle    = Brake line isolation valve
Common.ALL.FrontTrainLineIsolationToggle    = Train line isolation valve
Common.ALL.RearTrainLineIsolationToggle     = Train line isolation valve
Common.ALL.RearBrakeLineIsolationToggle     = Brake line isolation valve
Common.ALL.UAVA                             = UAVA: Enable automatic autostop disabler\n(may be enabled after brake line pressure drop)
Common.ALL.UAVA2                            = UAVA: Enable automatic autostop disabler #FIXME
Common.ALL.UAVAContact                      = UAVA contacts reset
Common.ALL.OAVU                             = OAVU: Disable AVU switch
Common.ALL.LAVU                             = AVU is activated
Common.ALL.GV                               = Main switch
Common.ALL.AirDistributor                   = VRN: Air distributor disabler
Common.ALL.CabinDoor                        = Door to the driver's cabin
Common.ALL.PassDoor                         = Door to the passenger compartment #FIXME
Common.ALL.FrontDoor                        = Front door
Common.ALL.RearDoor                         = Rear door
Common.ALL.OtsekDoor1                       = 1st equipment cupboard handle #FIXME
Common.ALL.OtsekDoor2                       = 2nd equipment cupboard handle #FIXME
Common.ALL.CouchCap                         = Pull out the seat #FIXME

Common.ALL.UNCh                             = UNCh: Low frequency amplifier switch
Common.ALL.ES                               = ES: Emergency communication control switch
Common.ALL.GCab                             = Loudspeaker: Sound in cabin switch
Common.ALL.UPO                              = UPO: Announcer
Common.ALL.R_Radio                          = Announcer
Common.ALL.AnnPlay                          = Announcer playback lamp

#RRI
Train.Common.RRI                            = RRI: Radio-relay announcer
Common.RRI.RRIUp                            = RRI: Setup up
Common.RRI.RRIDown                          = RRI: Setup down
Common.RRI.RRILeft                          = RRI: Setup left
Common.RRI.RRIRight                         = RRI: Setup right
Common.RRI.RRIEnableToggle                  = RRI: Power
Common.RRI.RRIRewindSet2                    = RRI: Fast forward
Common.RRI.RRIRewindSet0                    = RRI: Rewind
Common.RRI.RRIAmplifierToggle               = RRI: Amplifier
Common.RRI.RRIOn                            = RRI operation lamp

#ASNP
Train.Common.ASNP           = ASNP
Common.ASNP.ASNPMenu        = ASNP: Menu
Common.ASNP.ASNPUp          = ASNP: Up
Common.ASNP.ASNPDown        = ASNP: Down
Common.ASNP.ASNPOn          = ASNP: Power

#PVK
Common.CabVent.PVK-         = Decrease cabin ventilation power #FIXME
Common.CabVent.PVK+         = Increase cabin ventilation power #FIXME

#IGLA
Train.Common.IGLA           = IGLA
Common.IGLA.Button1Up       = IGLA: First button up
Common.IGLA.Button1         = IGLA: First button
Common.IGLA.Button1Down     = IGLA: First button down
Common.IGLA.Button2Up       = IGLA: Second button up
Common.IGLA.Button2         = IGLA: Second button
Common.IGLA.Button2Down     = IGLA: Second button down
Common.IGLA.Button23        = IGLA: Second and third buttons #FIXME
Common.IGLA.Button3         = IGLA: Third button #FIXME
Common.IGLA.Button4         = IGLA: Fourth button #FIXME
Common.IGLA.IGLASR          = IGLA: Power
Common.IGLA.IGLARX          = IGLA: No connection
Common.IGLA.IGLAErr         = IGLA: Error
Common.IGLA.IGLAOSP         = IGLA: Fire-extinguishing system is activated
Common.IGLA.IGLAPI          = IGLA: Fire
Common.IGLA.IGLAOff         = IGLA: HV circuits off

#BZOS
Common.BZOS.On      = Security alarm switch #FIXME
Common.BZOS.VH1     = Security alarm is enabled #FIXME
Common.BZOS.VH2     = Security alarm is triggered #FIXME
Common.BZOS.Engaged = Security alarm is triggered #FIXME

#Train helpers common
Common.ALL.SpeedCurr        = Actual speed #FIXME
Common.ALL.SpeedAccept      = Allowed speed #FIXME
Common.ALL.SpeedAttent      = Allowed speed on the next section #FIXME
Common.ALL.Speedometer      = Speedometer
Common.ALL.BLTLPressure     = Pressure in pneumatic lines (red: brake line, black: train line)
Common.ALL.BCPressure       = Brake cylinder pressure
Common.ALL.EnginesCurrent   = Engines current (A)
Common.ALL.EnginesCurrent1  = 1st traction motors current (A) #FIXME
Common.ALL.EnginesCurrent2  = 2nd traction motors current (A) #FIXME
Common.ALL.EnginesVoltage   = Engines voltage (kV)
Common.ALL.BatteryVoltage   = Battery voltage (V)
Common.ALL.BatteryCurrent   = Battery current (A) #FIXME
Common.ALL.HighVoltage      = High voltage (kV)
]]
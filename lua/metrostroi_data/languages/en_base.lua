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

#Station list GUI
StationList.Title           = Station list
StationList.Name            = Name
StationList.NamePos         = Position
StationList.Select          = Select station
StationList.Teleport        = Teleport
StationList.NoConfig        = This map is not configured

#Client settings
Panel.Admin             = Admin
Panel.RequireThirdRail  = Require third rail

Panel.Client            = Client
Panel.Language          = Select language
Panel.DrawCams          = Render cameras
Panel.DisableHUD        = Disable HUD in the driver seat
Panel.DisableCamAccel   = Disable camera acceleration
Panel.DisableHoverText  = Disable tooltips
Panel.DisableHoverTextP = Disable additional information\nin tooltips #NEW #FIXME
Panel.DisableSeatShadows= Disable seat shadows #NEW #FIXME
Panel.ScreenshotMode    = Screenshot mode (LOW FPS)
Panel.ShadowsHeadlight  = Enable headlight shadows
Panel.RedLights         = Enable dynamic light\nof red lights
Panel.ShadowsOther      = Enable shadows from other\nlight sources
Panel.PanelSprites      = Enable sprites from control\npanel lamps
Panel.MinimizedShow     = Don't unload an elements\nwhen minimized
Panel.PanelLights       = Enable dynamic lights\nfrom control panel lamps #NEW
Panel.RouteNumber       = Route number #NEW
Panel.FOV               = FOV
Panel.Z                 = Camera height #NEW
Panel.RenderDistance    = Render distance
Panel.RenderSignals     = Traced signals #NEW #FIXME
Panel.ReloadClient      = Reload client side

Panel.ClientAdvanced    = Client (advanced)
Panel.DrawDebugInfo     = Draw debug information
Panel.DrawSignalDebugInfo     = Signalling debug info
Panel.CheckAddons       = Scan addons
Panel.ReloadLang        = Reload languages
Panel.SoftDraw          = Train elements loading time
Panel.SoftReloadLang    = Don't reload a spawnmenu



#Common train

#Cameras
Train.Common.Camera0        = Driver's seat
Train.Common.RouteNumber    = Route number
Train.Common.LastStation    = Last station
Train.Common.HelpersPanel   = Helper's panel
Train.Common.UAVA           = UAVA
Train.Common.PneumoPanels   = Pneumatic valves
Train.Common.Voltmeters     = Voltmeters and amperemeters
Train.Common.CouplerCamera  = Coupler
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
Train.Buttons.Acceleration   = % 4.2f m/s #NEW
Train.Buttons.04             = NF #NEW (no frequency)
Train.Buttons.BCPressure     = %.1f bar
Train.Buttons.BLTLPressure   = TL: %.1f bar\nBL: %.1f bar #NEW (TL: Train line, BL: Brake line acronyms)
Train.Buttons.Locked         = Locked #NEW
Train.Buttons.Unlocked       = Unlocked #NEW

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
Entities.gmod_subway_81-717_mvm_custom.Name     = 81-717 (Moscow custom)
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
Entities.gmod_train_special_box.Name        = Special delivery

#Weapons
Weapons.button_presser.Name                 = Button presser
Weapons.button_presser.Purpose              = Used to press buttons on the maps.
Weapons.button_presser.Instructions         = Aim to a button and click "Attack" button.
Weapons.train_key.Name                      = Administrator key
Weapons.train_key.Purpose                   = Used to activate the administrators buttons.
Weapons.train_key.Instructions              = Aim to the administrator button and press "Attack" button.
Weapons.train_kv_wrench.Name                = Reverser wrench
Weapons.train_kv_wrench.Purpose             = Used in metro train and for pressing buttons in them.
Weapons.train_kv_wrench.Instructions        = Aim to a button in the train and press "Attack" button.
Weapons.train_kv_wrench_gold.Name           = The golden reverser wrench

Weapons.train_kv_wrench_gold.Purpose        = @[Weapons.train_kv_wrench.Purpose]
Weapons.train_kv_wrench_gold.Instructions   = @[Weapons.train_kv_wrench.Instructions]

#Spawner common
Spawner.Title                           = Train spawner
Spawner.Spawn                           = Spawn
Spawner.Close                           = Close
Spawner.Trains1                         = Wags. allowed
Spawner.Trains2                         = Per player
Spawner.WagNum                          = Wagons amount
Spawner.PresetTitle                     = Presets
Spawner.Preset.New                      = New preset
Spawner.Preset.Unsaved                  = Save current preset
Spawner.Preset.NewTooltip               = Create
Spawner.Preset.UpdateTooltip            = Update
Spawner.Preset.RemoveTooltip            = Delete
Spawner.Presets.NamePlaceholder         = Preset name
Spawner.Presets.Name                    = Name
Spawner.Presets.NameError               = Invalid name
Spawner.Preset.NotSelected              = Preset not selected
Common.Spawner.Texture                  = Body skin
Common.Spawner.PassTexture              = Interior skin
Common.Spawner.CabTexture               = Driver's cab skin
Common.Spawner.Announcer                = Announcer type
Common.Spawner.Type1                    = Type 1
Common.Spawner.Type2                    = Type 2
Common.Spawner.Type3                    = Type 3
Common.Spawner.Type4                    = Type 4
Common.Spawner.SpawnMode                = Train state
Common.Spawner.SpawnMode.Deadlock       = Dead-end
Common.Spawner.SpawnMode.Full           = Fully started
Common.Spawner.SpawnMode.NightDeadlock  = Dead-end after night
Common.Spawner.SpawnMode.Depot          = Cold and dark
Spawner.Common.EType                    = Electric circuits type #FIXME
Common.Spawner.Scheme                   = Line schemes
Common.Spawner.Random                   = Random
Common.Spawner.Old                      = Old
Common.Spawner.New                      = New
Common.Spawner.Type                     = Type
Common.Spawner.SchemeInvert             = Invert line schemes

#Coupler common
Common.Couple.Title         = Coupler menu
Common.Couple.CoupleState   = Coupler state
Common.Couple.Coupled       = Coupled
Common.Couple.Uncoupled     = Not coupled
Common.Couple.Uncouple      = Uncouple
Common.Couple.IsolState     = Isolation valves state
Common.Couple.Isolated      = Closed
Common.Couple.Opened        = Opened
Common.Couple.Open          = Open
Common.Couple.Isolate       = Close
Common.Couple.EKKState      = EKK state (electrical box connection)
Common.Couple.Disconnected  = Disconnected
Common.Couple.Connected     = Connected
Common.Couple.Connect       = Connect
Common.Couple.Disconnect    = Disconnect

#Bogey common
Common.Bogey.Title              = Bogie menu
Common.Bogey.ContactState       = Current collectors state
Common.Bogey.CReleased          = Released
Common.Bogey.CPressed           = Pressed
Common.Bogey.CPress             = Press
Common.Bogey.CRelease           = Release
Common.Bogey.ParkingBrakeState  = Parking brake state
Common.Bogey.PBDisabled         = Manually disabled
Common.Bogey.PBEnabled          = Enabled
Common.Bogey.PBEnable           = Enable
Common.Bogey.PBDisable          = Manual disable

#Trains common
Common.ALL.Unsused1                         = Unused
Common.ALL.Unsused2                         = (unused)
Common.ALL.Up                               = (up)
Common.ALL.Down                             = (down)
Common.ALL.Left                             = (left)
Common.ALL.Right                            = (right)
Common.ALL.CW                               = (clockwise)
Common.ALL.CCW                              = (counter-clockwise)
Common.ALL.VB                               = VB: Battery on/off
Common.ALL.VSOSD                            = SOSD: Station doors opening lamp
Common.ALL.VKF                              = VKF: Battery power for red lights
Common.ALL.VB2                              = (Low voltage circuits)
Common.ALL.VPR                              = VPR: Train radiostation
Common.ALL.VASNP                            = ASNP power
Common.ALL.UOS                              = RC-UOS: Speed Limitation Device (driving w/o EPV/EPK)
Common.ALL.VAH                              = VAH: Emergency driving mode (failure of RPB relay)
Common.ALL.KAH                              = KAH: Emergency drive button for driving w/o ARS
Common.ALL.KAHK                             = KAH button cover
Common.ALL.VAD                              = VAD: Emergency door close override (failure of KD relay)
Common.ALL.OVT                              = OVT: Disable pneumatic valves brake
Common.ALL.VOVT                             = VOVT: Turn off pneumatic valve brakes disabler
Common.ALL.EmergencyBrakeValve              = Emergency brake
Common.ALL.ParkingBrake                     = Parking brake
Common.ALL.VU                               = VU: Train control switch
Common.ALL.KDP                              = KDP: Open right doors
Common.ALL.KDPL                             = Right doors side is selected
Common.ALL.KDPK                             = Right doors button cover
Common.ALL.KDL                              = KDL: Open left doors
Common.ALL.KDLL                             = Left doors side is selected
Common.ALL.KDLK                             = Left doors button cover
Common.ALL.KDLPK                            = Door buttons cover
Common.ALL.KRZD                             = KRZD: Emergency door closing
Common.ALL.VSD                              = Doors side selector
Common.ALL.Ring                             = Ring
Common.ALL.VUD                              = VUD: Door control toggle (close doors)
Common.ALL.KDPH                             = Open right doors of the last car
Common.ALL.VUD2                             = VUD2: Close doors from the helper's side
Common.ALL.Program1                         = Program I
Common.ALL.Program2                         = Program II
Common.ALL.VRP                              = VRP: Reset overload relay
Common.ALL.VRPBV                            = VRP: Reset overload relay, enable BV
Common.ALL.KSN                              = KSN: Malfunction signalling
Common.ALL.VMK                              = VMK: Compressor
Common.ALL.MK                               = Compressor # (without acronym)
Common.ALL.VF1                              = 1st headlight group
Common.ALL.VF2                              = 2nd headlight group
Common.ALL.VF                               = Headlights switch
Common.ALL.VUS                              = VUS: Head lights bright/dim
Common.ALL.GaugeLights                      = Gauges lighting
Common.ALL.CabLights                        = Driver's cab lighting
Common.ALL.PassLights                       = Passenger compartment lighting
Common.ALL.PanelLights                      = Control panel lighting
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
Common.ALL.BrW                              = Wagon pneumobrakes are engaged
Common.ALL.ARS                              = ARS: Automatic speed regulation
Common.ALL.ARSR                             = ARS-R: Automatic speed regulation in ARS-R mode
Common.ALL.ALS                              = ALS: Automatic locomotive signalling
Common.ALL.RCARS                            = RC-ARS: ARS circuits disconnect # (same as RC-1)
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
Common.ARS.AO                               = AO: Absolute stop signal
Common.ARS.04                               = OCh: No ARS frequency
Common.ARS.N4                               = NCh: No ARS frequency # (same as OCh but NCh)
Common.ARS.0                                = 0: ARS stop signal
Common.ARS.40                               = Speed limit 40 km/h
Common.ARS.60                               = Speed limit 60 km/h
Common.ARS.70                               = Speed limit 70 km/h
Common.ARS.80                               = Speed limit 80 km/h
Common.ALL.RCBPS                            = RC-BPS: Anti-Rollback unit
Common.BPS.On                               = Anti-Rollback unit operation
Common.BPS.Err                              = Anti-Rollback unit error
Common.BPS.Fail                             = Anti-Rollback unit malfunction
Commom.NMnUAVA.NMPressureLow                = Low train line pressure lamp
Commom.NMnUAVA.UAVATriggered                = UAVA contacts are open
Common.ALL.LSD                              = Train doors state light (doors are closed)
Common.ALL.L1w                              = 1st wire lamp (drive mode engaged)
Common.ALL.L2w                              = 2nd wire lamp (rheostat controller motion)
Common.ALL.L6w                              = 6th wire lamp (brake mode engaged)
Common.ALL.Horn                             = Horn
Common.ALL.DriverValveBLDisconnect          = Brake line disconnect valve
Common.ALL.DriverValveTLDisconnect          = Train line disconnect valve
Common.ALL.DriverValveDisconnect            = Driver's valve disconnect valve
Common.ALL.KRMH                             = KRMSH: Driver's valve emergency enable #FIXME
Common.ALL.RVTB                             = RVTB: Reserved valve of safety brake #FIXME
Common.ALL.FrontBrakeLineIsolationToggle    = Brake line isolation valve
Common.ALL.FrontTrainLineIsolationToggle    = Train line isolation valve
Common.ALL.RearTrainLineIsolationToggle     = Train line isolation valve
Common.ALL.RearBrakeLineIsolationToggle     = Brake line isolation valve
Common.ALL.UAVA                             = UAVA: Enable automatic autostop disabler\n(may be enabled after brake line pressure drop)
Common.ALL.UAVA2                            = UAVA: Enable automatic autostop disabler
Common.ALL.UAVAContact                      = UAVA contacts reset
Common.ALL.OAVU                             = OAVU: Disable AVU
Common.ALL.LAVU                             = AVU is activated
Common.ALL.GV                               = Main switch
Common.ALL.AirDistributor                   = VRN: Air distributor disabler
Common.ALL.CabinDoor                        = Door to the driver's cab
Common.ALL.PassDoor                         = Door to the passenger compartment
Common.ALL.FrontDoor                        = Front door
Common.ALL.RearDoor                         = Rear door
Common.ALL.OtsekDoor1                       = 1st equipment cupboard handle
Common.ALL.OtsekDoor2                       = 2nd equipment cupboard handle
Common.ALL.CouchCap                         = Pull out the seat

Common.ALL.UNCh                             = UNCh: Low frequency amplifier
Common.ALL.ES                               = ES: Emergency communication control
Common.ALL.GCab                             = Loudspeaker: Sound in the driver's cab
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
Common.ASNP.ASNPPath        = ASNP: Set path

#PVK
Common.CabVent.PVK-         = Decrease driver's cab ventilation power
Common.CabVent.PVK+         = Increase driver's cab ventilation power

#IGLA
Train.Common.IGLA           = IGLA
Common.IGLA.Button1Up       = IGLA: First button up
Common.IGLA.Button1         = IGLA: First button
Common.IGLA.Button1Down     = IGLA: First button down
Common.IGLA.Button2Up       = IGLA: Second button up
Common.IGLA.Button2         = IGLA: Second button
Common.IGLA.Button2Down     = IGLA: Second button down
Common.IGLA.Button23        = IGLA: Second and third buttons
Common.IGLA.Button3         = IGLA: Third button
Common.IGLA.Button4         = IGLA: Fourth button
Common.IGLA.IGLASR          = IGLA: Power
Common.IGLA.IGLARX          = IGLA: No connection
Common.IGLA.IGLAErr         = IGLA: Error
Common.IGLA.IGLAOSP         = IGLA: Fire-extinguishing system is activated
Common.IGLA.IGLAPI          = IGLA: Fire
Common.IGLA.IGLAOff         = IGLA: HV circuits off

#BZOS
Common.BZOS.On      = Security alarm switch
Common.BZOS.VH1     = Security alarm is enabled
Common.BZOS.VH2     = Security alarm is triggered
Common.BZOS.Engaged = Security alarm is triggered

#Train helpers common
Common.ALL.SpeedCurr        = Actual speed #FIXME
Common.ALL.SpeedAccept      = Allowed speed
Common.ALL.SpeedAttent      = Allowed speed on the next block
Common.ALL.Speedometer      = Speedometer
Common.ALL.BLTLPressure     = Pressure in pneumatic lines (red: brake line, black: train line)
Common.ALL.BCPressure       = Brake cylinder pressure
Common.ALL.EnginesCurrent   = Engines current (A)
Common.ALL.EnginesCurrent1  = 1st traction motors current (A)
Common.ALL.EnginesCurrent2  = 2nd traction motors current (A)
Common.ALL.EnginesVoltage   = Engines voltage (kV)
Common.ALL.BatteryVoltage   = Battery voltage (V)
Common.ALL.BatteryCurrent   = Battery current (A)
Common.ALL.HighVoltage      = High voltage (kV)
]]
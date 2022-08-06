return [[
#Base text for English language

[kr]
lang        = 한국어                           #Full language name
AuthorText  = Translation Author: Archerity      #Author text

#Workshop errors
Workshop.Title              = 컨텐츠 매니저
Workshop.FilesMissing       = 애드온 파일의 일부가 누락되거나 손상되었습니다.\n만약 창작마당을 통해 애드온을 내려 받았다면 다음 경로에서 파일을 지우세요.\nGarrysMod/garrysmod/%s.
Workshop.FilesMissingLocaly = 애드온 파일의 일부가 누락되거나 손상되었습니다.
Workshop.InstalledLocaly    = 설치 완료 (local)
Workshop.NotInstalledE      = 미설치 상태.\n애드온을 구독하고 "애드온" 메뉴를 확인하세요.
Workshop.NotInstalled       = 미설치 상태.
Workshop.Disabled           = 애드온 비활성중.\n"애드온" 메뉴에서 활성화 시키세요.
Workshop.Installed          = 설치 완료
Workshop.Open               = 창작마당
Workshop.ErrorGithub        = GitHub 버전의 Metrostroi가 감지되었습니다. 최신 버전의 Metrostroi는 GitHub 버전의 Metrostroi와 호환되거나 작동하지 않습니다.
Workshop.ErrorLegacy        = 기존 버전의 Metrostroi가 감지되었습니다. 최신 버전의 Metrostroi는 기존 버전의 Metrostroi와 호환되거나 작동하지 않습니다.
Workshop.ErrorEnhancers     = 이 애드온에는 원활한 게임 플레이를 방해할 수 있는 그래픽 향상 요소가 포함되어 있습니다.
Workshop.Error1             = 이 애드온은 현재 버전과 충돌을 일으킬 수 있는 Metrostroi의 구식 스크립트를 포함하고 있습니다. 스크립트 에러나 작동이 불안정할 가능성이 있습니다.
Workshop.ErrorOld           = 이전 버전의 모델이 감지되었습니다 (81-702, 81-717 의 옛날 모델). 이전 버전의 Metrostroi 컨텐츠가 남아 있는지 확인 후 삭제하고, 게리모드 폴더에 있는 "cache","download","downloads" 폴더를 삭제해주세요.

#Client settings
Panel.Admin             = 관리자
Panel.RequireThirdRail  = 3궤조 필요 여부

Panel.Client            = 사용자
Panel.Language          = 언어 선택
Panel.DrawCams          = 카메라 렌더링
Panel.DisableHUD        = 운전석 착석시 HUD 비활성
Panel.DisableCamAccel   = 시점 흔들림 사용 안함
Panel.DisableHoverText  = 주석 텍스트 표시 안함
Panel.DisableHoverTextP = Disable additional information\nin tooltips #NEW
Panel.DisableSeatShadows= Disable seat shadows #NEW
Panel.ScreenshotMode    = 스크린샷 모드 (낮은 FPS)
Panel.ShadowsHeadlight  = 전조등 그림자 활성
Panel.RedLights         = 적색등의 다이나믹 라이트 사용
Panel.ShadowsOther      = 기타 광원 그림자 활성
Panel.MinimizedShow     = 창 최소화시 구성요소 언로드 하지 않기
Panel.FOV               = 시야각(FOV)
Panel.Z                 = 시점 높이
Panel.RenderDistance    = 렌더링 거리
Panel.RenderSignals     = Traced signals #NEW #FIXME
Panel.ReloadClient      = 사용자 시스템 다시 불러오기

Panel.ClientAdvanced    = 사용자 (고급설정)
Panel.DrawDebugInfo     = 디버깅 정보 표시
Panel.DrawSignalDebugInfo     = 신호 디버그 정보
Panel.CheckAddons       = 애드온 스캔
Panel.ReloadLang        = 언어 다시 불러오기
Panel.SoftDraw          = 차량 구성요소 로딩 시간
Panel.SoftReloadLang    = 스폰 메뉴 다시 불러오지 않기



#Common train
Train.Common.Camera0        = 운전석
Train.Common.RouteNumber    = 경로 번호
Train.Common.LastStation    = 종착역
Train.Common.HelpersPanel   = 보조석 패널
Train.Common.UAVA           = UAVA
Train.Common.PneumoPanels   = 공압 밸브
Train.Common.Voltmeters     = 전압계, 전류계
Train.Common.CouplerCamera  = 연결기
Common.ARM.Monitor1         = ARM 모니터 1
Train.Buttons.Sealed        = 봉인 됨

#Train entities
Entities.gmod_subway_base.Name        = Subway base
Entities.gmod_subway_81-502.Name      = 81-502 (Ema-502 선두차량)
Entities.gmod_subway_81-501.Name      = 81-501 (Em-501 중간차량)
Entities.gmod_subway_81-702.Name      = 81-702 (D 선두차량)
Entities.gmod_subway_81-702_int.Name  = 81-702 (D 중간차량)
Entities.gmod_subway_81-703.Name      = 81-703 (E 선두차량)
Entities.gmod_subway_81-703_int.Name  = 81-703 (E 중간차량)
Entities.gmod_subway_ezh.Name         = 81-707 (Ezh 선두차량)
Entities.gmod_subway_ezh1.Name        = 81-708 (Ezh1 중간차량)
Entities.gmod_subway_ezh3.Name        = 81-710 (Ezh3 선두차량)
Entities.gmod_subway_em508t.Name      = 81-508T (Em-508T 중간차량)
Entities.gmod_subway_81-717_mvm.Name  = 81-717 (Moscow 선두차량)
Entities.gmod_subway_81-717_mvm_custom.Name     = 81-717 (Moscow custom)
Entities.gmod_subway_81-714_mvm.Name  = 81-714 (Moscow 중간차량)
Entities.gmod_subway_81-717_lvz.Name  = 81-717 (St. Petersburg 선두차량)
Entities.gmod_subway_81-714_lvz.Name  = 81-714 (St. Petersburg 중간차량)
Entities.gmod_subway_81-718.Name      = 81-718 (TISU 선두차량)
Entities.gmod_subway_81-719.Name      = 81-719 (TISU 중간차량)
Entities.gmod_subway_81-720.Name      = 81-720 (Yauza 선두차량)
Entities.gmod_subway_81-721.Name      = 81-721 (Yauza 중간차량)
Entities.gmod_subway_81-722.Name      = 81-722 (Yubileyniy 선두차량)
Entities.gmod_subway_81-723.Name      = 81-723 (Yubileyniy 중간차량[M])
Entities.gmod_subway_81-724.Name      = 81-724 (Yubileyniy 중간차량[T])
Entities.gmod_subway_81-7036.Name     = 81-7036 (사용 불가)
Entities.gmod_subway_81-7037.Name     = 81-7037 (사용 불가)
Entities.gmod_subway_tatra_t3.Name    = Tatra T3

#Train util entities
Entities.gmod_train_bogey.Name        = 대차
Entities.gmod_train_couple.Name       = 연결기

#Other entities
Entities.gmod_track_pui.Name                = PUI
Entities.gmod_track_mus_elektronika7.Name   = "Electronika" 시계
Entities.gmod_mus_clock_analog.Name         = 아날로그 시계
Entities.gmod_track_clock_time.Name         = 대형 배차간격 시계 (시간)
Entities.gmod_track_clock_small.Name        = 소형 배차간격 시계
Entities.gmod_track_clock_interval.Name     = 대형 배차간격 시계 (배차간격)
Entities.gmod_track_switch.Name             = 선로 분기기
Entities.gmod_track_powermeter.Name         = 전력계
Entities.gmod_track_arm.Name                = ARM DSCP
Entities.gmod_track_udochka.Name            = 급전 커넥터
Entities.gmod_train_spawner.Name            = 열차 스포너
Entities.gmod_train_special_box.Name        = 특별 배달

#Weapons
Weapons.button_presser.Name                 = 버튼 조작기
Weapons.button_presser.Purpose              = 맵에 있는 버튼을 누르기 위해 사용됩니다.
Weapons.button_presser.Instructions         = 버튼을 바라보고 "공격" 키를 누르세요.
Weapons.train_key.Name                      = 관리자용 키
Weapons.train_key.Purpose                   = 관리자용 버튼을 활성화하기 위해 사용됩니다.
Weapons.train_key.Instructions              = 관리자용 버튼을 바라보고 "공격" 키를 누르세요.
Weapons.train_kv_wrench.Name                = 역전간 핸들
Weapons.train_kv_wrench.Purpose             = 열차에 있는 버튼/스위치를 조작하기 위해 사용됩니다.
Weapons.train_kv_wrench.Instructions        = 열차에 있는 버튼/스위치를 바라보고 "공격" 키를 누르세요.
Weapons.train_kv_wrench_gold.Name           = 황금 역전간 핸들

Weapons.train_kv_wrench_gold.Purpose        = @[Weapons.train_kv_wrench.Purpose]
Weapons.train_kv_wrench_gold.Instructions   = @[Weapons.train_kv_wrench.Instructions]

#Spawner common
Spawner.Title                           = 열차 소환기
Spawner.Spawn                           = 소환
Spawner.Close                           = 닫기
Spawner.Trains1                         = 현재 열차 수
Spawner.Trains2                         = 최대 량수 (길이)
Spawner.WagNum                          = 열차 량수 (길이)
Spawner.PresetTitle                     = 프리셋
Spawner.Preset.New                      = 새 프리셋
Spawner.Preset.Unsaved                  = 현재 설정으로 저장
Spawner.Preset.NewTooltip               = 새로 만들기
Spawner.Preset.UpdateTooltip            = 업데이트
Spawner.Preset.RemoveTooltip            = 삭제
Spawner.Presets.NamePlaceholder         = 프리셋 이름
Spawner.Presets.Name                    = 이름
Spawner.Presets.NameError               = 잘못된 이름
Spawner.Preset.NotSelected              = 프리셋이 선택되지 않음
Common.Spawner.Texture      = 차량 외부 도색
Common.Spawner.PassTexture  = 차량 내부 인테리어
Common.Spawner.CabTexture   = 운전대 텍스쳐
Common.Spawner.Announcer    = 안내방송 유형
Common.Spawner.Type1        = 유형 1
Common.Spawner.Type2        = 유형 2
Common.Spawner.Type3        = 유형 3
Common.Spawner.Type4        = 유형 4
Common.Spawner.SpawnMode                = 차량 상태
Common.Spawner.SpawnMode.Deadlock       = 회차
Common.Spawner.SpawnMode.Full           = 완전 기동
Common.Spawner.SpawnMode.NightDeadlock  = 주박
Common.Spawner.SpawnMode.Depot          = 기지
Spawner.Common.EType                    = 전기 회로 종류
Common.Spawner.Scheme                   = 노선도
Common.Spawner.Random                   = 무작위
Common.Spawner.Old                      = 구형
Common.Spawner.New                      = 신형
Common.Spawner.Type                     = 종류
Common.Spawner.SchemeInvert             = 노선도 반전

#Coupler common
Common.Couple.Title         = 연결기 메뉴
Common.Couple.CoupleState   = 연결기 상태
Common.Couple.Coupled       = 연결 됨
Common.Couple.Uncoupled     = 연결 안됨
Common.Couple.Uncouple      = 분리
Common.Couple.IsolState     = 차단 밸브 상태
Common.Couple.Isolated      = 닫힘
Common.Couple.Opened        = 열림
Common.Couple.Open          = 열기
Common.Couple.Isolate       = 닫기
Common.Couple.EKKState      = EKK 상태 (전기 연결기)
Common.Couple.Disconnected  = 연결 끊김
Common.Couple.Connected     = 연결 됨
Common.Couple.Connect       = 연결
Common.Couple.Disconnect    = 연결 끊기

#Bogey common
Common.Bogey.Title              = 대차 메뉴
Common.Bogey.ContactState       = 집전 장치 상태
Common.Bogey.CReleased          = 사용 중지 됨
Common.Bogey.CPressed           = 사용 중
Common.Bogey.CPress             = 사용 하기
Common.Bogey.CRelease           = 사용 중지
Common.Bogey.ParkingBrakeState  = 주차 제동 상태
Common.Bogey.PBDisabled         = 수동 해제 됨
Common.Bogey.PBEnabled          = 체결 됨
Common.Bogey.PBEnable           = 체결
Common.Bogey.PBDisable          = 수동 해제

#Trains common
Common.ALL.Unsused1                         = 미사용
Common.ALL.Unsused2                         = (미사용)
Common.ALL.Up                               = (상)
Common.ALL.Down                             = (하)
Common.ALL.Left                             = (좌)
Common.ALL.Right                            = (우)
Common.ALL.CW                               = (시계 방향)
Common.ALL.CCW                              = (반시계 방향)
Common.ALL.VB                               = VB: 배터리 투입/차단
Common.ALL.VSOSD                            = SOSD: 승강장 안전문 열림 확인등
Common.ALL.VKF                              = VKF: 적색등용 배터리 전원
Common.ALL.VB2                              = (저전압 회로)
Common.ALL.VPR                              = VPR: 열차 무선국
Common.ALL.VASNP                            = ASNP 전원
Common.ALL.UOS                              = RC-UOS: 속도 제한 장치 (EPV/EPK 미사용 주행)
Common.ALL.VAH                              = VAH: 비상 운전 모드 (RPB 계전기 고장)
Common.ALL.KAH                              = KAH: 비상 운전 버튼 (ARS 미사용 주행)
Common.ALL.KAHK                             = KAX 버튼 커버
Common.ALL.VAD                              = VAD: 출입문 강제 닫힘 무시 (KD 계전기 고장)
Common.ALL.OVT                              = OVT: 공압 밸브 제동 비활성
Common.ALL.VOVT                             = VOVT: 공압 밸브 제동 비활성기 사용 중지
Common.ALL.EmergencyBrakeValve              = 비상 제동
Common.ALL.ParkingBrake                     = 주차 제동
Common.ALL.VU                               = VU: 차량 제어
Common.ALL.KDP                              = KDP: 우측 출입문 열림
Common.ALL.KDPL                             = 우측 출입문 선택 됨
Common.ALL.KDPK                             = 우측 출입문 열림 버튼 커버
Common.ALL.KDL                              = KDL: 좌측 출입문 열림
Common.ALL.KDLL                             = 좌측 출입문 선택 됨
Common.ALL.KDLK                             = 좌측 출입문 열림 버튼 커버
Common.ALL.KDLPK                            = 출입문 버튼 커버
Common.ALL.KRZD                             = KRZD: 출입문 강제 닫힘
Common.ALL.VSD                              = 출입문 열림 방향 선택
Common.ALL.Ring                             = 연락 부저
Common.ALL.VUD                              = VUD: 출입문 제어 스위치 (출입문 닫힘)
Common.ALL.KDPH                             = 마지막 객차 우측 출입문 열림
Common.ALL.VUD2                             = VUD2: 출입문 제어 스위치 (보조석)
Common.ALL.Program1                         = 안내방송 I
Common.ALL.Program2                         = 안내방송 II
Common.ALL.VRP                              = VRP: 과전류 계전기 리셋
Common.ALL.VRPBV                            = VRP: 과전류 계전기 리셋, BV 사용
Common.ALL.KSN                              = KSN: 오작동 신호 전달
Common.ALL.VMK                              = VMK: 공기 압축기
Common.ALL.MK                               = 공기 압축기
Common.ALL.VF1                              = 전조등 1번 그룹
Common.ALL.VF2                              = 전조등 2번 그룹
Common.ALL.VF                               = 전조등 스위치
Common.ALL.VUS                              = VUS: 전조등 상향
Common.ALL.GaugeLights                      = 계기류 조명
Common.ALL.CabLights                        = 운전실 조명
Common.ALL.PassLights                       = 객실 내부 조명
Common.ALL.PanelLights                      = 운전대 조명
Common.ALL.RMK                              = RMK: 공기 압축기 강제 기동
Common.ALL.KRP                              = KRP: 비상 기동 버튼
Common.ALL.VZP                              = VZP: 출발 스위치
Common.ALL.VZD                              = VZD: 출입문 스위치
Common.ALL.VAV                              = VAV: 자동 운전 버튼
Common.ALL.RouteNumber1+                    = 경로 번호: 첫째 자리 증가
Common.ALL.RouteNumber1-                    = 경로 번호: 첫째 자리 감소
Common.ALL.RouteNumber2+                    = 경로 번호: 둘째 자리 증가
Common.ALL.RouteNumber2-                    = 경로 번호: 둘째 자리 감소
Common.ALL.RouteNumber3+                    = 경로 번호: 셋째 자리 증가
Common.ALL.RouteNumber3-                    = 경로 번호: 셋째 자리 감소
Common.ALL.LastStation+                     = 다음 종착역
Common.ALL.LastStation-                     = 이전 종착역
Common.ALL.RRP                              = RP: 과전류 계전기 확인등 (적색) (전원 회로 연결 실패)
Common.ALL.GRP                              = RP: 과전류 계전기 확인등(녹색) (추진 장치 과전류 방지)
Common.ALL.RP                               = RP: 과전류 계전기 확인등 (적색) (전원 회로 연결 실패/RP 작동 중)
Common.ALL.SN                               = LSN: 고장 표시등 (전원 회로 연결 실패)
Common.ALL.PU                               = 공전 방지 장치 작동 중
Common.ALL.BrT                              = 공압 제동 작동 중
Common.ALL.BrW                              = 객차 공압 제동 작동 중
Common.ALL.ARS                              = ARS: 자동 속도 제한 스위치
Common.ALL.ARSR                             = ARS-R: 자동 속도 제한 (ARS-R 모드) 스위치
Common.ALL.ALS                              = ALS: 자동 차량 신호 스위치
Common.ALL.RCARS                            = RC-ARS: ARS 회로 차단
Common.ALL.RC1                              = RC-1: ARS 회로 차단
Common.ALL.EPK                              = ARS 전공 밸브 (EPK)
Common.ALL.EPV                              = ARS 전공 밸브 (EPV)
Common.ARS.LN                               = LN: 방향 신호
Common.ARS.KT                               = KT: 제동 제어 확인등
Common.ARS.VD                               = VD: ARS에 의해 구동 모드 작동 중지
Common.ARS.Freq                             = ALS 디코더 스위치
Common.ARS.FreqD                            = (위 1/5, 아래 2/6)
Common.ARS.FreqU                            = (위 2/6, 아래 1/5)
Common.ARS.VP                               = "보조 차량" 모드
Common.ARS.RS                               = RS: 속도 유지등 (다음 속도 제한 상향/지속)
Common.ARS.AB                               = 자동 폐색 ARS 모드
Common.ARS.ABButton                         = 자동 폐색 ARS 모드 버튼
Common.ARS.ABDriver                         = (운전사)
Common.ARS.ABHelper                         = (운전보조)
Common.ARS.AV                               = 주 ARS-MP 유닛 고장
Common.ARS.AV1                              = 보조 ARS-MP 유닛 고장
Common.ARS.AB2                              = 자동 폐색 ARS 모드 버튼
Common.ARS.ARS                              = ARS 모드
Common.ARS.LRD                              = LRD: 주행 허용 (ALS 신호 0 현시 시)
Common.ARS.VRD                              = VRD: 주행 허용 (ALS 신호 0 현시 시)
Common.ARS.KB                               = KB: 확인 버튼
Common.ARS.KVT                              = KVT: 제동 확인 버튼
Common.ARS.KVTR                             = KVT: ARS-R 제동 확인 버튼
Common.ARS.04                               = OCh: ARS 신호 없음
Common.ARS.N4                               = NCh: ARS 신호 없음
Common.ARS.0                                = 0: ARS 정지 신호
Common.ARS.40                               = 속도 제한 40 km/h
Common.ARS.60                               = 속도 제한 60 km/h
Common.ARS.70                               = 속도 제한 70 km/h
Common.ARS.80                               = 속도 제한 80 km/h
Common.ALL.RCBPS                            = RC-BPS: 차량 구름 방지 장치 스위치
Common.BPS.On                               = 차량 구름 방지 장치: 작동
Common.BPS.Err                              = 차량 구름 방지 장치: 오류
Common.BPS.Fail                             = 차량 구름 방지 장치: 고장
Commom.NMnUAVA.NMPressureLow                = 주 공기관 압력 부족 경고등
Commom.NMnUAVA.UAVATriggered                = UAVA 작동 (접점 열림)
Common.ALL.LSD                              = 출입문 상태 표시등 (출입문 닫힘 상태)
Common.ALL.L1w                              = 차량 회로 1 표시등 (구동 모드 작동)
Common.ALL.L2w                              = 차량 회로 2 표시등 (가변 저항 제어기 작동)
Common.ALL.L6w                              = 차량 회로 6 표시등 (제동 모드 작동)
Common.ALL.Horn                             = 경적
Common.ALL.DriverValveBLDisconnect          = 제동관 차단 밸브
Common.ALL.DriverValveTLDisconnect          = 주 공기관 차단 밸브
Common.ALL.DriverValveDisconnect            = 제동변 차단 밸브
Common.ALL.KRMH                             = KRMSH: 제동변 비상 사용
Common.ALL.RVTB                             = RVTB: 안전 제동 지정 밸브
Common.ALL.FrontBrakeLineIsolationToggle    = 제동관 해방 밸브
Common.ALL.FrontTrainLineIsolationToggle    = 주 공기관 해방 밸브
Common.ALL.RearTrainLineIsolationToggle     = 주 공기관 해방 밸브
Common.ALL.RearBrakeLineIsolationToggle     = 제동관 해방 밸브
Common.ALL.UAVA                             = UAVA: 자동 정지 장치 사용 중지\n(제동관 압력 감소 후 작동)
Common.ALL.UAVA2                            = UAVA: 자동 정지 장치 사용 중지
Common.ALL.UAVAContact                      = UAVA 복귀 (접점 리셋)
Common.ALL.OAVU                             = OAVU: AVU 스위치 사용 중지
Common.ALL.LAVU                             = AVU 작동 중
Common.ALL.GV                               = 고전압 스위치
Common.ALL.AirDistributor                   = VRN: 공압 제어기 사용 중지
Common.ALL.CabinDoor                        = 운전실 문
Common.ALL.PassDoor                         = 객실 문
Common.ALL.FrontDoor                        = 관통 문
Common.ALL.RearDoor                         = 관통 문
Common.ALL.OtsekDoor1                       = 1번 장비함 손잡이
Common.ALL.OtsekDoor2                       = 2번 장비함 손잡이
Common.ALL.CouchCap                         = 의자 당기기

Common.ALL.UNCh                             = UNCh: 저주파 증폭기 스위치
Common.ALL.ES                               = ES: 비상 교신 제어 스위치
Common.ALL.GCab                             = Loudspeaker: 운전실 내부 방송 재생
Common.ALL.UPO                              = UPO: 안내방송기
Common.ALL.R_Radio                          = 안내방송기
Common.ALL.AnnPlay                          = 안내방송기 재생 표시등

#RRI
Train.Common.RRI                            = RRI: 무선 중계 안내방송기
Common.RRI.RRIUp                            = RRI: 설정 위
Common.RRI.RRIDown                          = RRI: 설정 아래
Common.RRI.RRILeft                          = RRI: 설정 좌
Common.RRI.RRIRight                         = RRI: 설정 우
Common.RRI.RRIEnableToggle                  = RRI: 전원
Common.RRI.RRIRewindSet2                    = RRI: 빨리 감기
Common.RRI.RRIRewindSet0                    = RRI: 되감기
Common.RRI.RRIAmplifierToggle               = RRI: 증폭기
Common.RRI.RRIOn                            = RRI 작동 표시등

#ASNP
Train.Common.ASNP           = ASNP
Common.ASNP.ASNPMenu        = ASNP: 메뉴
Common.ASNP.ASNPUp          = ASNP: 위
Common.ASNP.ASNPDown        = ASNP: 아래
Common.ASNP.ASNPOn          = ASNP: 전원

#PVK
Common.CabVent.PVK-         = 운전실 환풍기 세기: -
Common.CabVent.PVK+         = 운전실 환풍기 세기: +

#IGLA
Train.Common.IGLA           = IGLA
Common.IGLA.Button1Up       = IGLA: [버튼 1] 위
Common.IGLA.Button1         = IGLA: [버튼 1]
Common.IGLA.Button1Down     = IGLA: [버튼 1] 아래
Common.IGLA.Button2Up       = IGLA: [버튼 2] 위
Common.IGLA.Button2         = IGLA: [버튼 2]
Common.IGLA.Button2Down     = IGLA: [버튼 3] 아래
Common.IGLA.Button23        = IGLA: [버튼 2/3]
Common.IGLA.Button3         = IGLA: [버튼 3]
Common.IGLA.Button4         = IGLA: [버튼 4]
Common.IGLA.IGLASR          = IGLA: 전원
Common.IGLA.IGLARX          = IGLA: 연결 없음
Common.IGLA.IGLAErr         = IGLA: 오류
Common.IGLA.IGLAOSP         = IGLA: 소화 장치 작동
Common.IGLA.IGLAPI          = IGLA: 화재
Common.IGLA.IGLAOff         = IGLA: 고전압 회로 차단

#BZOS
Common.BZOS.On      = 보안 경보 스위치
Common.BZOS.VH1     = 보안 경보 작동 중
Common.BZOS.VH2     = 보안 경보 감지 됨
Common.BZOS.Engaged = 보안 경보 감지 됨

#Train helpers common
Common.ALL.SpeedCurr            = 실제 속도
Common.ALL.SpeedAccept          = 허용 속도
Common.ALL.SpeedAttent          = 다음 구간 허용 속도
Common.ALL.Speedometer      = 속도계
Common.ALL.BLTLPressure     = 공기관 압력계 (적색: 제동관, 흑색: 주 공기관)
Common.ALL.BCPressure       = 제동통 압력계
Common.ALL.EnginesCurrent   = 추진 장치 전류계 (A)
Common.ALL.EnginesCurrent1   = 1번 견인 전동기 전류계 (A)
Common.ALL.EnginesCurrent2   = 2번 견인 전동기 전류계 (A)
Common.ALL.EnginesVoltage   = 추진 장치 전압계 (kV)
Common.ALL.BatteryVoltage   = 배터리 전압계 (V)
Common.ALL.BatteryCurrent   = 배터리 전류계 (A)
Common.ALL.HighVoltage      = 고전압계 (kV)
]]

--------------------------------------------------------------------------------
-- 81-722 BMCIK-01 system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_722_BMCIK")
TRAIN_SYSTEM.DontAccelerateSimulation = true
TRAIN_SYSTEM.TriggerNames = {
    "SarmatUp",
    "SarmatDown",
    "SarmatEnter",
    "SarmatEsc",
    "SarmatF1",
    "SarmatF2",
    "SarmatF3",
    "SarmatF4",
    "SarmatPath",
    "SarmatLine",
    "SarmatZero",
    "SarmatStart",
}

function TRAIN_SYSTEM:Initialize()
    self.Triggers = {}
    for k,v in pairs(self.TriggerNames) do
        self.Train:LoadSystem(v,"Relay","Switch")
        self.Triggers[v] = false
    end
    self.LineOut = 0
    self.UPOActive = 0
    if TURBOSTROI then return end

    self.State = 0
    self.Brightness = 1
    
    self.NIIP = {
        DOORS_closed = 0,
        RUCHKA = 0,
        SPEED = 0,
        UPO_STATE = 0,
        Evacuation = 0,
        Vzlom_kabiny = 0,
        CabActive = 0
    }

    self.BMTS = {
        State = 0,
        Text = "",
        Update = false
    }

    self.Announcer = {
        State = 0,
        CIKState = 0,
        Active = false,
        Line = 0,
        LimitStation = false,
        Path = false,
        PathSel = false,
        Station = 0,
        OnStation = false,
        Mode = 3,
        TrainTrain = false,
        BITTime = false,
        LineEnabled = false,
        Volumes = {
            Cabin = 5,
            Salon = 5,
            UPOCabin = 5,
            UPOSalon = 5,
            EmerCab = 5,
            V5 = 0
        }
    }

    self.List = {
        Count = 0,
        Selected = 1,
        Offset = 0,
        States = {}
    }

    self.Cam = {
        {Link = nil,Ent = NULL},
        {Link = nil,Ent = NULL},
        {Link = nil,Ent = NULL},
        {Link = nil,Ent = NULL},
        Page = 0,
        Wagon = 0,
        Fullscreen = 0
    }
end

function TRAIN_SYSTEM:Outputs()
    return {"UPOActive","LineOut"}
end

function TRAIN_SYSTEM:Inputs()
    return {}
end
if TURBOSTROI then return end

-- CAN messages
TRAIN_SYSTEM.CAN_ACTIVATE  = 0x01
TRAIN_SYSTEM.CAN_CIKSTATE  = 0x02

TRAIN_SYSTEM.CAN_BMTS_TEXT = 0x10

TRAIN_SYSTEM.CAN_CURR      = 0x21
TRAIN_SYSTEM.CAN_NEXT      = 0x22
TRAIN_SYSTEM.CAN_PATH      = 0x23
TRAIN_SYSTEM.CAN_CLOSERING = 0x24
TRAIN_SYSTEM.CAN_VOLUMES   = 0x25
TRAIN_SYSTEM.CAN_SPEED     = 0x26

TRAIN_SYSTEM.CAN_BITTEXT   = 0x30
TRAIN_SYSTEM.CAN_BITDOPMSG = 0x31
TRAIN_SYSTEM.CAN_BITTIME   = 0x32

-- Buttons
TRAIN_SYSTEM.Buttons = {
    {
        name = "Esc",
        id = 41,
        x = 10,y = 742,
        w = 218,h = 48,
        touch = function(self)
            if self.Cam.Page == 0 then return end
            if self.Cam.Fullscreen > 0 then
                self.Cam.Fullscreen = 0
            else
                self.Cam.Page = 0
                for i=1,4 do
                    self.Cam[i].Link = nil
                    self.Cam[i].Ent = NULL
                end
            end
        end,
        show = function(page)
            return true
        end
    },
    {
        name = "<-",
        id = 42,
        x = 234,y = 742,
        w = 217,h = 48,
        touch = function(self)
            if self.Cam.Page == 0 then return end
            if self.Cam.Fullscreen > 0 then return end
            self.Cam.Page = self.Cam.Page - 1
            if self.Cam.Page == 0 then
                self.Cam.Wagon = self.Cam.Wagon - 1
                if self.Cam.Wagon == 0 then
                    self.Cam.Wagon = self.Cam.WagNum
                end
                self.Cam.Page = self.Cam.Cameras[self.Cam.Wagon].Count
            end
            return true
        end,
        show = function(page)
            return true
        end
    },
    {
        name = "->",
        id = 43,
        x = 457,y = 742,
        w = 218,h = 48,
        touch = function(self)
            if self.Cam.Page == 0 then return end
            if self.Cam.Fullscreen > 0 then return end
            self.Cam.Page = self.Cam.Page + 1
            if self.Cam.Page > self.Cam.Cameras[self.Cam.Wagon].Count then
                self.Cam.Wagon = self.Cam.Wagon + 1
                if self.Cam.Wagon > self.Cam.WagNum then
                    self.Cam.Wagon = 1
                end
                self.Cam.Page = 1
            end
            return true
        end,
        show = function(page)
            return true
        end
    },
    {
        name = "☼",
        id = 44,
        x = 911,y = 9,
        w = 119,h = 32,
        touch = function(self)
            self.Brightness = self.Brightness + 0.25
            if self.Brightness > 1 then self.Brightness = 0.25 end
            self.Train:SetNW2Float("BMCIK:Brightness",self.Brightness)
        end,
        show = function(page)
            return true
        end
    },  

    -- Наружные камеры
    {
        name = "Левые",
        id = 1,
        x = 95,y = 183,
        w = 140,h = 60,
        touch = function(self)
            if self.Cam.Page > 0 then return end
            self.Cam.Wagon = 1
            self.Cam.Page = 2
            return true
        end,
        show = function(page)
            return page == 0
        end
    },
    {
        name = "Передние",
        id = 2,
        x = 241,y = 183,
        w = 140,h = 60,
        touch = function(self)
            if self.Cam.Page > 0 then return end
            self.Cam.Wagon = 1
            self.Cam.Page = 1
            return true
        end,
        show = function(page)
            return page == 0
        end
    },
    {
        name = "Вокруг",
        id = 3,
        x = 387,y = 183,
        w = 140,h = 60,
        touch = function(self)
            if self.Cam.Page > 0 then return end
            self.Cam.Wagon = 1
            self.Cam.Page = 4
            return true
        end,
        show = function(page)
            return page == 0
        end
    },
    {
        name = "Задние",
        id = 4,
        x = 533,y = 183,
        w = 140,h = 60,
        touch = function(self)
            if self.Cam.Page > 0 then return end
            self.Cam.Wagon = self.Cam.WagNum
            self.Cam.Page = 1
            return true
        end,
        show = function(page)
            return page == 0
        end
    },
    {
        name = "Правые",
        id = 5,
        x = 679,y = 183,
        w = 140,h = 60,
        touch = function(self)
            if self.Cam.Page > 0 then return end
            self.Cam.Wagon = 1
            self.Cam.Page = 3
            return true
        end,
        show = function(page)
            return page == 0
        end
    },

    -- Камеры на постах машиниста
    {
        name = "Вагон 1",
        id = 21,
        x = 215,y = 463,
        w = 140,h = 60,
        touch = function(self)
            if self.Cam.Page > 0 then return end
            self.Cam.Wagon = 1
            self.Cam.Page = 6
            return true
        end,
        show = function(page)
            return page == 0
        end
    },
    {
        name = "Вагон %d",
        id = 22,
        x = 559,y = 463,
        w = 140,h = 60,
        touch = function(self)
            if self.Cam.Page > 0 then return end
            self.Cam.Wagon = self.Cam.WagNum
            self.Cam.Page = 3
            return true
        end,
        show = function(page)
            return page == 0
        end
    },

    -- Путевые камеры
    {
        name = "Вагон 1",
        id = 31,
        x = 215,y = 603,
        w = 140,h = 60,
        touch = function(self)
            if self.Cam.Page > 0 then return end
            self.Cam.Wagon = 1
            self.Cam.Page = 5
            return true
        end,
        show = function(page)
            return page == 0
        end
    },
    {
        name = "Вагон %d",
        id = 32,
        x = 559,y = 603,
        w = 140,h = 60,
        touch = function(self)
            if self.Cam.Page > 0 then return end
            self.Cam.Wagon = self.Cam.WagNum
            self.Cam.Page = 2
            return true
        end,
        show = function(page)
            return page == 0
        end
    },
}
TRAIN_SYSTEM.Buttons.Count = #TRAIN_SYSTEM.Buttons
TRAIN_SYSTEM.CamConfig = {
    -- Dummy
    [0] = {
        Count = 0,
        {
            PageName = "",
            Count = 4,
            {"",Vector(0,0,0),Angle(0,0,0)},
            {"",Vector(0,0,0),Angle(0,0,0)},
            {"",Vector(0,0,0),Angle(0,0,0)},
            {"",Vector(0,0,0),Angle(0,0,0)}
        },
    },
    -- 722 Head
    {
        Count = 8,
        {
            PageName = "Передние зеркала",
            Count = 2,
            {
                "[1] Левый борт, переднее зеркало",
                Vector(425, 65,40),Angle(10, 170,0)
            },
            {
                "[2] Правый борт, переднее зеркало",
                Vector(425,-65,40),Angle(10,-170,0)
            }
        },
        {
            Count = 2,
            PageName = "Левые зеркала",
            
            {
                "[1] Левый борт, переднее зеркало",
                Vector(425, 65,40),Angle(10, 170,0)
            },
            {
                "[2] Левый борт, заднее зеркало",
                Vector(425,-65,40),Angle(10,-170,0),
                lastWag = true
            }
        },
        {
            PageName = "Правые зеркала",
            Count = 2,
            {
                "[1] Правый борт, переднее зеркало",
                Vector(425,-65,40),
                Angle(10,-170,0)
            },
            {
                "[2] Правый борт, заднее зеркало",
                Vector(425,65,40),Angle(10,170,0),
                lastWag = true
            }
        },
        {
            PageName = "Бортовые зеркала",
            Count = 4,
            {
                "[1] Левый борт, переднее зеркало",
                Vector(425,65,40),Angle(10,170,0)
            },
            {
                "[2] Правый борт, переднее зеркало",
                Vector(425,-65,40),Angle(10,-170,0)
            },
            {
                "[3] Левый борт, заднее зеркало",
                Vector(425,-65,40),Angle(10,-170,0),
                lastWag = true
            },
            {
                "[4] Правый борт, заднее зеркало",
                Vector(425,65,40),Angle(10,170,0),
                lastWag = true
            }
        },
        {
            PageName = "Путевые камеры",
            Count = 1,
            {
                "[1] Передняя путевая камера",
                Vector(490,10,-8),Angle(5,0,0)
            }
        },
        {
            PageName = "Кабина машиниста",
            Count = 1,
            {
                "[1] Передняя кабина",
                Vector(410,35,36.5),Angle(33,-15,0)
            }
        },
        {
            PageName = "Салонные камеры",
            Count = 4,
            {
                "[1] Камера в БИТ",
                Vector(375,-14,45),
                Angle(20,180,0)
            },
            {
                "[2] Камера в БИТ",
                Vector(5,-14,49),
                Angle(24,0,0)
            },
            {
                "[3] Камера в БИТ",
                Vector(-450,14,49),
                Angle(20,0,0)
            },
            {
                "[4] Камера в БИТ",
                Vector(-8,14,49),
                Angle(24,180,0)
            }
        },
        {
            PageName = "Салонные камеры",
            Count = 2,
            {
                "[1] Камера в БЭС",
                Vector(150,-50,20),
                Angle(5,95,0),
                wide = true
            },
            {
                "[2] Камера в БЭС",
                Vector(-156, 50,20),
                Angle(5,-85,0),
                wide = true
            }
        }
    },
    -- 722 Back
    {
        Count = 6,

        {
            PageName = "Задние зеркала",
            Count = 2,
            {
                "[1] Левый борт, заднее зеркало",
                Vector(425,-65,40),
                Angle(10,-170,0)
            },
            {
                "[2] Правый борт, заднее зеркало",
                Vector(425,65,40),
                Angle(10,170,0)
            }
        },
        {
            PageName = "Путевые камеры",
            Count = 1,
            {
                "[1] Задняя путевая камера",
                Vector(490,10,-8),
                Angle(5,0,0)
            }
        },
        {
            PageName = "Кабина машиниста",
            Count = 1,
            {
                "[1] Задняя кабина",
                Vector(410,35,36.5),
                Angle(33,-15,0)
            }
        },
        {
            PageName = "Салонные камеры",
            Count = 4,
            {
                "[1] Левое зеркало",
                Vector(425,-65,40),
                Angle(10,-170,0)
            },
            {
                "[2] Правое зеркало",
                Vector(425, 65,40),
                Angle(10, 170,0)
            },
            {
                "[3] Путевая камера",
                Vector(490,10,-8),
                Angle(5,0,0)
            },
            {
                "[4] Камера в кабине машиниста",
                Vector(410,35,36.5),
                Angle(33,-15,0)
            }
        },
        {
            PageName = "Салонные камеры",
            Count = 4,
            {
                "[1] Камера в БИТ",
                Vector(-450,14,49),
                Angle(20,0,0)
            },
            {
                "[2] Камера в БИТ",
                Vector(-8,14,49),
                Angle(24,180,0)
            },
            {
                "[3] Камера в БИТ",
                Vector(375,-14,45),
                Angle(20,180,0)
            },
            {
                "[4] Камера в БИТ",
                Vector(5,-14,49),
                Angle(24,0,0)
            }
        },
        {
            PageName = "Салонные камеры",
            Count = 2,
            {
                "[1] Камера в БЭС",
                Vector(150,-50,20),
                Angle(5,95,0),
                wide = true
            },
            {
                "[2] Камера в БЭС",
                Vector(-156, 50,20),
                Angle(5,-85,0),
                wide = true
            }
        }
    },
    -- 723/724 Intermediate
    {
        Count = 2,
        {
            PageName = "Салонные камеры",
            Count = 4,
            {
                "[1] Камера в БИТ",
                Vector(450,-14,49),
                Angle(20,180,0)
            },
            {
                "[2] Камера в БИТ",
                Vector(5,-14,49),
                Angle(24,0,0)
            },
            {
                "[3] Камера в БИТ",
                Vector(-450,14,49),
                Angle(20,0,0)
            },
            {
                "[4] Камера в БИТ",
                Vector(-8,14,49),
                Angle(24,180,0)
            }
        },
        {
            PageName = "Салонные камеры",
            Count = 2,
            {
                "[1] Камера в БЭС",
                Vector(150,-50,20),
                Angle(5,95,0),
                wide = true
            },
            {
                "[2] Камера в БЭС",
                Vector(-156, 50,20),
                Angle(5,-85,0),
                wide = true
            }
        }
    }
}
TRAIN_SYSTEM.SettingsList = {
    {"Ввод номера маршрута",nil},
    {"Режимы работы информатора","AnnModeList"},
    {"Режимы работы СОСТАВ-СОСТАВ",nil},
    {"Настройка громкости","AnnVolumeList"},
    {"Информация","InfoList"},
    {"Диагностика","DiagList"},
    {"Язык","LangList"},
    {"Время на БИТ","BITClockList"}
}
TRAIN_SYSTEM.AnnModeList = {
    "Режим 'Информатор'",
    "Режим 'УПО+Информатор'",
    "Режим 'УПО+Информатор+Пуск'",
    "Режим 'УПО'"
}
TRAIN_SYSTEM.AnnVolumeList = {
    {"Громкость инф. в кабине","Cabin",0,10},
    {"Громкость инф. в салоне","Salon",1,10},
    {"Громкость УПО в кабине","UPOCabin",0,10},
    {"Громкость УПО в салоне","UPOSalon",1,10},
    {"Громкость ЭКСТР./МЕЖКАБ.","EmerCab",0,10},
    {"Увеличение при V>5 на","V5",0,10}
}
TRAIN_SYSTEM.InfoList = {
    {"MIES firmware version 20181203",nil},
    {"NIIP DOORS_closed= ","BMCIK:AddInfoNIIPDoors"},
    {"NIIP RUCHKA= ",nil},
    {"NIIP SPEED= ","BMCIK:AddInfoNIIPSpeed"},
    {"NIIP UPO_STATE= ","BMCIK:AddInfoUPO"},
    {"NIIP Evacuation= ",nil},
    {"NIIP Vzlom_kabiny= ",nil},
    {"Video sended= ","BMCIK:AddInfoVideo"},
    {"AVT.State.State_byte= ",nil},
    {"AVT.Now_S.code= ",nil},
    {"AVT.Next_S.code= ",nil},
    {"AVT.Final_S.code= ",nil},
    {"AVT.Met= ",nil}
}
TRAIN_SYSTEM.DiagList = {
    "Advanced LAN diagnostics",
    "Advanced CAN diagnostics",
    "BMCIK 0/0",
    "MIES 0/0",
    "MDU 0/0",
    "MAR 0/0",
    "BES LAN 0/0",
    "BES CAN 0/0",
    "BNT(BUM) 0/0",
    "BIT 0/0",
    "BVK 0/0",
    "BMTS 0/0"
}
TRAIN_SYSTEM.LangList = {
    "Russian",
    -- "English",
    -- "Hungarian"
}
TRAIN_SYSTEM.BITClockList = {
    "Время выключено",
    "Время включено"
}

TRAIN_SYSTEM.CIKStatesNames = {
    [0] = "Готов",
    [1] = "Воспроизведение...",
    [2] = "Межкабинная связь активна",
    [3] = "Громкая связь",
    -- [4] = "Нет связи",
    -- [5] = "Связь восстановлена",
    -- [6] = "Линия свободна"
}

TRAIN_SYSTEM.HeaderNames = {
    [0] = "---",
    [1] = "---",
    [11] = "Предупредительные\nсообщения",
    [12] = "Ограничение маршрута",
    [13] = "Дополнительные сообщения",
    [14] = "Экстренные сообщения",
    [15] = "Выбор линии",
    [2] = "Меню настройки блока\nСБУЦИК",
    [21] = "Меню настройки блока\nСБУЦИК",
    [22] = "Режимы работы\nинформатора",
    [23] = "Режимы работы блока\nСБУЦИК",
    [24] = "Настройка громкости",
    [25] = "Additional information",
    [26] = "Диагностика (0%)",
    [27] = "Язык",
    [28] = "Отображение времени на\nБИТ"
}

local function setBitValue(targetVar, value, offset, bitCount)
    value = bit.band(value,bit.lshift(1,bitCount)-1)
    return bit.bor(targetVar,bit.lshift(value,offset))
end

local function getBitValue(value, offset, bitCount)
    local mask = bit.lshift(bit.lshift(1,bitCount)-1,offset)
    return bit.rshift(bit.band(value,mask),offset)
end

-- Announcer functions
function TRAIN_SYSTEM:Announcer_Reset(resetAnn)
    local Announcer = self.Announcer
    self:Announcer_Stop()
    self:Announcer_CabStop()
    Announcer.State = 0
    Announcer.CIKState = 0
    Announcer.Active = false
    if resetAnn then
        Announcer.Line = 0
        Announcer.Volumes.Cabin = 5
        Announcer.Volumes.Salon = 5
        Announcer.Volumes.UPOCabin = 5
        Announcer.Volumes.UPOSalon = 5
        Announcer.Volumes.EmerCab = 5
        Announcer.Volumes.V5 = 0

        Announcer.BITTime = false
    end
    
    Announcer.LimitStation = false
    Announcer.Path = false
    Announcer.PathSel = false
    Announcer.Station = 0
    Announcer.OnStation = false
    Announcer.Mode = 3
    Announcer.TrainTrain = false
    Announcer.LineEnabled = false

    self.Train:SetNW2Int("BMCIK:Announcer",0)
    self.Train:SetNW2Bool("BMCIK:LineEnabled",false)
end

function TRAIN_SYSTEM:Announcer_Activate(forceActive)
    local Announcer = self.Announcer
    if (not forceActive and Announcer.Active) or Announcer.Line == 0 then return end

    -- TODO: Try to implement better logic of UPO noise sync
    local Train = self.Train
    local noiseVolume = Train.UPONoiseVolume
    local upoVolume = Train.UPOVolume
    local wagList = Train.WagonList
    for i=1,#wagList do
        wagList[i]:SetNW2Float("UPONoiseVolume",noiseVolume)
        wagList[i]:SetNW2Float("UPOVolume",upoVolume)
    end

    self:Announcer_FindLimitStations()
    Announcer.LimitStation = false
    self:Announcer_Zero()
    self:Announcer_SetState(1,#Metrostroi.SarmatUPOSetup[Train:GetNW2Int("Announcer")][Announcer.Line]*2)
end

function TRAIN_SYSTEM:Announcer_SetState(state,count)
    local Announcer = self.Announcer
    self:List_Save(Announcer.State)
    Announcer.PrevState = Announcer.State
    Announcer.State = state
    self:List_Reset(count)
end

function TRAIN_SYSTEM:Announcer_FindLimitStations()
    local Announcer = self.Announcer
    local lTbl = Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer")][Announcer.Line]
    Announcer.LastStations = {}
    if lTbl.Loop then
        for i=1,#lTbl do
            if lTbl[i].arrlast then table.insert(Announcer.LastStations,i) end
        end
    else
        for i=2,#lTbl-1 do
            if lTbl[i].arrlast then table.insert(Announcer.LastStations,i) end
        end
    end
end

function TRAIN_SYSTEM:Announcer_Zero()
    local Announcer = self.Announcer
    local Train = self.Train
    local lTbl = Metrostroi.SarmatUPOSetup[Train:GetNW2Int("Announcer")][Announcer.Line]
    if Announcer.Line < 1 then return end

    self:Announcer_Stop()
    Announcer.Active = true
    Announcer.Path = Announcer.PathSel
    Announcer.Station = Announcer.Path and #lTbl or 1
    Announcer.OnStation = false
    Announcer.AVTDepart = false

    Train:CANWrite("BMCIK",nil,"BNT",nil,self.CAN_CLOSERING,false)
    Train:CANWrite("BMCIK",Train:GetWagonNumber(),"BMCIK",nil,self.CAN_ACTIVATE)
    Train:CANWrite("BMCIK",nil,"BNT",nil,self.CAN_ACTIVATE)
    Train:CANWrite("BMCIK",nil,"BIT",nil,self.CAN_ACTIVATE)
    Train:CANWrite("BMCIK",nil,"BNT",nil,self.CAN_VOLUMES,{Announcer.Volumes.Salon,Announcer.Volumes.UPOSalon,Announcer.Volumes.V5})

    self:BMTS_Update()
    self:CANUpdate()
end

function TRAIN_SYSTEM:Announcer_Prev()
    local Announcer = self.Announcer
    local lTbl = Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer")][Announcer.Line]
    if Announcer.OnStation then
        Announcer.OnStation = false
    else
        if Announcer.Path then
            if #lTbl > Announcer.Station then
                Announcer.Station = Announcer.Station+1
                Announcer.OnStation = true
            end
        else
            if Announcer.Station > 1 then
                Announcer.Station = Announcer.Station-1
                Announcer.OnStation = true
            end
        end
    end
end

function TRAIN_SYSTEM:Announcer_Next(returnToStart)
    local Announcer = self.Announcer
    local lTbl = Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer")][Announcer.Line]
    local maxStation = Announcer.LimitStation or (Announcer.Path and 1 or #lTbl)
    if Announcer.OnStation then
        if Announcer.Path then
            if Announcer.Station > maxStation then
                Announcer.Station = Announcer.Station-1
                Announcer.OnStation = false
            elseif returnToStart and maxStation == Announcer.Station then
                Announcer.Station = #lTbl
                Announcer.OnStation = false
                return true
            end
        else
            if maxStation > Announcer.Station then
                Announcer.Station = Announcer.Station+1
                Announcer.OnStation = false
            elseif returnToStart and maxStation == Announcer.Station then
                Announcer.Station = 1
                Announcer.OnStation = false
                return true
            end
        end
    else
        Announcer.OnStation = true
        local last = not lTbl.Loop and Announcer.Station == (Announcer.Path and 1 or #lTbl)
        if Announcer.LimitStation then
            last = Announcer.LimitStation == Announcer.Station
        end
        Announcer.CurrentLast = last
    end
end

function TRAIN_SYSTEM:Announcer_Queue(msg)
    local AnnouncerSys = self.Train.Announcer
    if msg and type(msg) ~= "table" then
        AnnouncerSys:Queue{msg}
    else
        AnnouncerSys:Queue(msg)
    end
end

function TRAIN_SYSTEM:Announcer_CabPlay()
    if self.LineOut > 0 then return end
    local Announcer = self.Announcer
    local lTbl = Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer")][Announcer.Line]
    if not lTbl then return end
    local sTbl = lTbl[Announcer.Station]

    Announcer.CabPlay = true
    self.Train:CANWrite("BMCIK",nil,"BNT",nil,self.CAN_VOLUMES,{0,0,0})

    self.Train.Announcer.AnnounceTimer = CurTime()+0.2 -- Silent sound fix at begin playing
    self:Announcer_Queue("tone")
    local message
    local last = not lTbl.Loop and Announcer.Station == (Announcer.Path and 1 or #lTbl)
    if Announcer.LimitStation then
        last = Announcer.LimitStation == Announcer.Station
    end
    if Announcer.OnStation then
        if sTbl.odz then self:Announcer_Queue(sTbl.odz) end
        message = sTbl.dep and sTbl.dep[Announcer.Path and 2 or 1]
    else
        if last then
            message = sTbl.arrlast and sTbl.arrlast[Announcer.Path and 2 or 1]
        else
            message = sTbl.arr and sTbl.arr[Announcer.Path and 2 or 1]
        end
    end

    if not message then return end
    self:Announcer_Queue(message)
end

function TRAIN_SYSTEM:Announcer_CabStop()
    local Announcer = self.Announcer
    if not Announcer.CabPlay then return end
    Announcer.CabPlay = false
    self.Train:CANWrite("BMCIK",nil,"BNT",nil,self.CAN_VOLUMES,{Announcer.Volumes.Salon,Announcer.Volumes.UPOSalon,Announcer.Volumes.V5})
end

function TRAIN_SYSTEM:Announcer_Play()
    local Announcer = self.Announcer
    if Announcer.UPOLock then return end
    if Announcer.Mode > 3 then return end
    local lTbl = Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer")][Announcer.Line]
    if not lTbl then return end
    local sTbl = lTbl[Announcer.Station]
    self:Announcer_Stop()
    self:Announcer_Queue("tone")
    local message
    local last = not lTbl.Loop and Announcer.Station == (Announcer.Path and 1 or #lTbl)
    if Announcer.LimitStation then
        last = Announcer.LimitStation == Announcer.Station
    end
    if Announcer.OnStation then
        if sTbl.odz then self:Announcer_Queue(sTbl.odz) end
        message = sTbl.dep and sTbl.dep[Announcer.Path and 2 or 1]
    else
        if last then
            message = sTbl.arrlast and sTbl.arrlast[Announcer.Path and 2 or 1]
            self:Announcer_Queue(-1)
        else
            message = sTbl.arr and sTbl.arr[Announcer.Path and 2 or 1]
        end
    end
    Announcer.CurrentLast = last
    if not message then return end
    self:Announcer_Queue(message)
end

function TRAIN_SYSTEM:Announcer_Stop()
    self:Announcer_CabStop()
    self.LineOut = 0
    self.UPOActive = 0
    self.Announcer.UPOLock = false
    self.Train.Announcer.AnnounceTimer = CurTime()+0.2 -- Silent sound fix at begin playing
    self.Train.Announcer:TriggerInput("Reset","AnnouncementsSarmatUPO")
end

-- Cameras control functions
function TRAIN_SYSTEM:Cam_Scan()
    local Cam = self.Cam
    local Train = self.Train
    local wagList = Train.WagonList
    Cam.WagNum = #wagList
    Cam.Cameras = {}

    local lastWag = wagList[Cam.WagNum]
    for w=1,Cam.WagNum do
        local iWag = wagList[w]
        local iWagType = w==1 and 1 or (iWag.SubwayTrain.WagType==1 and w==Cam.WagNum) and 2 or 3
        local wagCamTbl = self.CamConfig[iWagType]
        Cam.Cameras[w] = {
            wagEnt = iWag,
            wagNum = iWag:GetWagonNumber(),
            wagType = iWagType,
            Count = wagCamTbl.Count
        }
        for page=1,wagCamTbl.Count do
            Cam.Cameras[w][page] = {}
            for iCam=1,wagCamTbl[page].Count do
                Cam.Cameras[w][page][iCam] = wagCamTbl[page][iCam].lastWag and lastWag or iWag
            end
        end
    end
    Cam.TrainLen = Cam.WagNum*20
    Cam.LoadingTimer = nil
    Train:SetNW2Int("BMCIK:WagNum",Cam.WagNum)
end

function TRAIN_SYSTEM:Cam_Open(wagon,page)
    local Cam = self.Cam
    if Cam.Page > 0 then return end

    Cam.AutoOpen = true
    Cam.Distance = 0
    Cam.Wagon = wagon
    Cam.Page = page

    for i=1,4 do
        Cam[i].Link = CurTime()+math.Rand(0.2,1)
        Cam[i].Ent = Cam.Cameras[Cam.Wagon][Cam.Page][i]
        if i > #Cam.Cameras[Cam.Wagon][Cam.Page] then
            Cam[i].Link = nil
            Cam[i].Ent = NULL
        end
    end

    local Train = self.Train
    Train:SetNW2Int("BMCIK:CamWagIndex",Cam.Wagon)
    Train:SetNW2Int("BMCIK:CamType",Cam.Cameras[Cam.Wagon].wagType)
    Train:SetNW2Int("BMCIK:CamWagNumber",Cam.Cameras[Cam.Wagon].wagNum)
end

function TRAIN_SYSTEM:Cam_Close()
    local Cam = self.Cam
    Cam.Page = 0
    for i=1,4 do
        Cam[i].Link = nil
        Cam[i].Ent = NULL
    end

    local Train = self.Train
    Train:SetNW2Int("BMCIK:CamWagIndex",0)
    Train:SetNW2Int("BMCIK:CamType",0)
    Train:SetNW2Int("BMCIK:CamWagNumber",0)
end

function TRAIN_SYSTEM:Cam_Reset()
    local Cam = self.Cam
    Cam.Page = 0
    Cam.Wagon = 0
    Cam.Fullscreen = 0
    Cam.AutoOpen = false
    Cam[1] = {Link = nil,Ent = NULL}
    Cam[2] = {Link = nil,Ent = NULL}
    Cam[3] = {Link = nil,Ent = NULL}
    Cam[4] = {Link = nil,Ent = NULL}
end

-- List functions
function TRAIN_SYSTEM:List_Save(state)
    local List = self.List
    List.States[state] = {Count = List.Count,Selected = List.Selected,Offset = List.Offset}
end

function TRAIN_SYSTEM:List_Load(state)
    local List = self.List
    if not List.States[state] then return end
    local saveState = List.States[state]
    saveState.Selected = math.min(saveState.Selected,saveState.Count)
    local dOffset = saveState.Count - saveState.Offset - 21
    if dOffset < 0 then
        saveState.Offset = math.max(0,saveState.Offset + dOffset)
    end
    List.Count = saveState.Count
    List.Selected = saveState.Selected
    List.Offset = saveState.Offset
    List.States[state] = nil
end

function TRAIN_SYSTEM:List_Set(state, sel)
    local List = self.List
    if state and self.Announcer.State ~= state and List.States[state] then List = List.States[state] end
    if sel == List.Selected or sel > List.Count then return end 
    List.Selected = sel

    local cursorPos = List.Selected - List.Offset
    local dOffset
    if cursorPos < 1 then
        dOffset = cursorPos - 1
    elseif cursorPos > 21 then
        dOffset = cursorPos - 21
    end
    if dOffset then
        List.Offset =  math.Clamp(List.Offset + dOffset,0,List.Count-21)
    end
end

function TRAIN_SYSTEM:List_GetSelectedItem()
    return self.List.Selected
end

function TRAIN_SYSTEM:List_Prev(state)
    local List = self.List
    if state and self.Announcer.State ~= state and List.States[state] then List = List.States[state] end
    if List.Count < 2 then return end
    local lastSel = List.Selected
    List.Selected = math.max(1,List.Selected - 1)
    if List.Selected-List.Offset == 0 and List.Selected ~= lastSel then
        List.Offset = List.Offset-1
    end
end

function TRAIN_SYSTEM:List_Next(state)
    local List = self.List
    if state and self.Announcer.State ~= state and List.States[state] then List = List.States[state] end
    if List.Count < 2 then return end
    local lastSel = List.Selected
    List.Selected = math.min(List.Count,List.Selected + 1)
    if List.Selected-List.Offset > 21 and List.Selected ~= lastSel then
        List.Offset = List.Offset+1
    end
end

function TRAIN_SYSTEM:List_Reset(count)
    local List = self.List
    List.Selected = 1
    List.Offset = 0
    List.ListTimer = nil
    List.ListTimerDir = nil
    List.Count = count or 0
end

function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
    if textdata == self.CAN_BMTS_TEXT then
        self.BMTS.Text = numdata
        self.BMTS.Update = true
        return
    end
    if sourceid == self.Train:GetWagonNumber() then return end
    if textdata == self.CAN_ACTIVATE then
        if self.Announcer.Active then
            self.Announcer.Active = false
            self.Announcer.AVTDepart = false
            self:Cam_Close()
        end
    end
    if textdata == self.CAN_CIKSTATE then
        self.Announcer.CIKStateIntercab = numdata
    end
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if not self.Announcer.Active then return end
    if name == "OpenDoors" then
        if value == 0x4C then
            self:Cam_Open(1,2)
        elseif value == 0x52 then
            self:Cam_Open(1,3)
        end
    end
    local Announcer = self.Announcer
    if name == "CheckUPO" then
        if self.UPOActive == 0 or self.LineOut>0 or math.random()>0.95 then
            return false
        end
        if not Announcer.OnStation then
            self:Announcer_Next()
            self:List_Next(1)
            self:CANUpdate()
        end
        return true
    end
    
    if name == "ClosedDoors" then
        self.Train:CANWrite("BMCIK",nil,"BNT",nil,self.CAN_CLOSERING,false)
    end
    if name == "OpenDoors" then
        self.Train:CANWrite("BMCIK",nil,"BNT",nil,self.CAN_CLOSERING,false)
        if Announcer.AVTDepart then
            Announcer.AVTDepart = false
            self:CANUpdate()
            return
        end
        if not Announcer.OnStation then
            self:Announcer_Play()
            self:Announcer_Next()
            self:List_Next(1)
            self:CANUpdate()
        end
    end
    if name == "CloseDoorsAVT" then
        Announcer.AVTDepart = Announcer.OnStation
        if Announcer.AVTDepart then
            self:Announcer_Play()
            self:CANUpdate()
        end
        self.Train:CANWrite("BMCIK",nil,"BNT",nil,self.CAN_CLOSERING,true)
    end
end

function TRAIN_SYSTEM:CANUpdate()
    local Announcer = self.Announcer
    local lTbl = Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer")][Announcer.Line]
    local lTblCount = #lTbl
    local ledTbl = lTbl.LED
    local currLed, nextLed = 0,0
    local station = Announcer.Station
    if Announcer.AVTDepart then
        if Announcer.Path then
            station = station - 1
            if station < 1 then station = #ledTbl end
        else
            station = station + 1
            if station > #ledTbl then station = 1 end
        end
    end

    for i=(Announcer.Path and #ledTbl or 1),station,(Announcer.Path and -1 or 1) do
        currLed = currLed + ledTbl[i]
    end
    if Announcer.AVTDepart or not Announcer.OnStation then
        nextLed = ledTbl[station]
        currLed = currLed - nextLed
    end

    local sTbl = lTbl[station]
    local first,sTblPrev,sTblNext
    if lTbl.Loop and not Announcer.Limit then
        first = 0
        if Announcer.Path then
            sTblNext = ((station-1) < 1) and lTbl[lTblCount] or lTbl[station-1]
            sTblPrev = ((station+1) > lTblCount) and lTbl[1] or lTbl[station+1]
        else
            sTblPrev = ((station-1) < 1) and lTbl[lTblCount] or lTbl[station-1]
            sTblNext = ((station+1) > lTblCount) and lTbl[1] or lTbl[station+1]
        end
    else
        if Announcer.Path then
            first = lTblCount
            sTblPrev = station < lTblCount and lTbl[station+1]
            sTblNext = station > 1 and lTbl[station-1]
        else
            first = 1
            sTblPrev = station > 1 and lTbl[station-1]
            sTblNext = station < lTblCount and lTbl[station+1]
        end
    end
    
    local bitText  = "---"
    local bitLeft,bitRight
    local bitLoop = 1

    if not Announcer.AVTDepart and Announcer.OnStation then
        if Announcer.CurrentLast then
            bitLeft = ""
            bitRight = Format("%s >",sTbl[2])
            bitLoop = 4

            bitText = Format("%%rПоезд прибыл\n%%rна конечную станцию\n%%r%s",sTbl[2])
            if sTbl.right_doors then
                bitText = bitText..",\n%%rвыход\n%%rна правую сторону.\n"
                bitLoop = bitLoop + 2
            else
                bitText = bitText..".\n"
            end
        else
            bitLeft = sTblPrev and sTblPrev[2] or ""
            bitRight = sTblNext and Format("%s >",sTblNext[2])
            bitLoop = 5
            bitText = Format("%%yСтанция\n%%y%s",sTbl[2])
            if sTbl.right_doors then
                bitText = bitText..",\n%%yвыход\n%%yна правую сторону.\n"
                bitLoop = bitLoop + 2
            else
                bitText = bitText..".\n"
            end

            bitText = bitText..Format("%%yСледующая станция\n%%y%s",sTblNext[2])
            if sTblNext.right_doors then
                bitText = bitText..",\n%%yвыход\n%%yна правую сторону.\n"
                bitLoop = bitLoop + 2
            else
                bitText = bitText..".\n"
            end
        end

        if sTbl.messagearr then
            bitLoop = bitLoop + #string.Explode("\n",sTbl.messagearr)
            bitText = bitText..(sTbl.messagearr).."\n"
        end
        bitText = bitText.."\n."
    elseif Announcer.AVTDepart or station ~= first then
        bitLeft = sTblPrev and sTblPrev[2]
        bitRight = Format("%s >",sTbl[2])
        bitLoop = 5
        bitText = Format("%%rОсторожно,\n%%rдвери закрываются!\n%%yСледующая станция\n%%y%s",sTbl[2])
        if sTbl.right_doors then
            bitText = bitText..",\n%%yвыход\n%%yна правую сторону.\n"
            bitLoop = bitLoop + 2
        else
            bitText = bitText..".\n"
        end
        
        if sTblPrev.messagedep then
            bitLoop = bitLoop + #string.Explode("\n",sTblPrev.messagedep)
            bitText = bitText..(sTblPrev.messagedep).."\n"
        end
        bitText = bitText.."\n."
    end
    
    self.Train:CANWrite("BMCIK",nil,"BNT",nil,self.CAN_CURR,currLed)
    self.Train:CANWrite("BMCIK",nil,"BNT",nil,self.CAN_NEXT,nextLed)
    self.Train:CANWrite("BMCIK",nil,"BNT",nil,self.CAN_PATH,Announcer.Path)
    self.Train:CANWrite("BMCIK",nil,"BIT",nil,self.CAN_BITTEXT,{Text = string.Explode("\n",bitText), Left = bitLeft, Right = bitRight, Loop = bitLoop})
end

function TRAIN_SYSTEM:BMTS_Update()
    local lTbl = Metrostroi.SarmatUPOSetup[self.Train:GetNW2Int("Announcer")][self.Announcer.Line]
    local bmtsText = lTbl[self.Announcer.LimitStation or (self.Announcer.Path and 1 or #lTbl)][2]
    if lTbl.Loop and not self.Announcer.LimitStation then bmtsText = "КОЛЬЦЕВОЙ" end
    self.Train:CANWrite("BMCIK",nil,"BMCIK",nil,self.CAN_BMTS_TEXT,bmtsText)
end

local function InRange(px,py,x,y,w,h)
    return (px >= x and px <= (x+w) and py >= y and py <= (y+h))
end
function TRAIN_SYSTEM:Touch(value,x,y)
    if self.State < 1 then return end
    local btnID = 0
    local newPage = false

    if self.Cam.Page > 0 then
        if not value and self.Cam.Fullscreen == 0 then
            local camCountPage = #self.Cam.Cameras[self.Cam.Wagon][self.Cam.Page]
            if camCountPage == 4 then
                if InRange(x,y,24,58,430,328,"[1]") then
                    self.Cam.Fullscreen = 1
                elseif InRange(x,y,460,58,430,328,"[2]") then
                    self.Cam.Fullscreen = 2
                elseif InRange(x,y,24,392,430,328,"[3]") then
                    self.Cam.Fullscreen = 3
                elseif InRange(x,y,460,392,430,328,"[4]") then
                    self.Cam.Fullscreen = 4
                end
            elseif camCountPage == 2 then
                if InRange(x,y,24,58,430,662,"[1]") then
                    self.Cam.Fullscreen = 1
                elseif InRange(x,y,460,58,430,662,"[2]") then
                    self.Cam.Fullscreen = 2
                end
            end
        end
    else
        local wagNum = self.Cam.WagNum
        for i=1,wagNum do
            if (wagNum == 8 and InRange(x,y,350+(i-wagNum/2)*110,323,104,60))
            or (wagNum == 7 and InRange(x,y,334+(i-wagNum/2)*126,323,120,60))
            or (wagNum <= 6 and InRange(x,y,313+(i-wagNum/2)*147,323,141,60)) then
                btnID = 10 + i
                if not value then
                    self.Cam.Wagon = i
                    self.Cam.Page = self.Cam.Cameras[i].wagType == 1 and 7 or self.Cam.Cameras[i].wagType == 2 and 5 or 1
                    newPage = true
                end
            end
        end
    end

    for i=1,#self.Buttons do
        local btn = self.Buttons[i]
        if btn.show(self.Cam.Page) and InRange(x,y,btn.x,btn.y,btn.w,btn.h) then
            if not value and btn.touch then newPage = btn.touch(self) end
            btnID = btn.id
        end
    end

    if newPage then
        self.Cam.AutoOpen = false
        for i=1,4 do
            self.Cam[i].Link = CurTime()+math.Rand(0.2,1)
            self.Cam[i].Ent = self.Cam.Cameras[self.Cam.Wagon][self.Cam.Page][i]
            if i > #self.Cam.Cameras[self.Cam.Wagon][self.Cam.Page] then
                self.Cam[i].Link = nil
                self.Cam[i].Ent = NULL
            end
        end
        self.Train:SetNW2Int("BMCIK:CamWagIndex",self.Cam.Wagon)
        self.Train:SetNW2Int("BMCIK:CamType",self.Cam.Cameras[self.Cam.Wagon].wagType)
        self.Train:SetNW2Int("BMCIK:CamWagNumber",self.Cam.Cameras[self.Cam.Wagon].wagNum)
    end

    self.Train:SetNW2Int("BMCIK:IDTouched",btnID or 0)
end

function TRAIN_SYSTEM:Trigger(name,value)
    name = name:gsub("Sarmat","")
    if name ~= "Up" and name ~= "Down" and not value then return end
    local Train = self.Train
    local annTbl = Metrostroi.SarmatUPOSetup[Train:GetNW2Int("Announcer")]
    local Announcer = self.Announcer
    local annState = Announcer.State
    local selected = self:List_GetSelectedItem()

    if annState == 1 then
        if name == "Up" or name == "Down" or name == "Enter" or name == "Start" then
            Announcer.AVTDepart = false
        end
    end

    if annState == 12 and name == "Esc" then
        if Announcer.PrevLimitStation ~= Announcer.LimitStation then
            if Announcer.LimitStation then
                self.List.States[1].Count = (Announcer.Path and (#annTbl[Announcer.Line] - Announcer.LimitStation + 1) or Announcer.LimitStation)*2
                local lastStation = Announcer.Station
                if Announcer.Path then
                    Announcer.Station = math.max(Announcer.Station,Announcer.LimitStation)
                else
                    Announcer.Station = math.min(Announcer.Station,Announcer.LimitStation)
                end
                if lastStation ~= Announcer.Station then
                    Announcer.OnStation = true
                end
            else
                self.List.States[1].Count = #annTbl[Announcer.Line]*2
            end
            self:BMTS_Update()
            Announcer.PrevLimitStation = nil
        end
    end

    if annState == 23 and Announcer.TrainTrain and (name == "Esc" or name == "Zero") then
        Announcer.TrainTrain = false
        return
    end
    
    ---- ▲
    if name == "Up" then
        if value then
            self:List_Prev()
            if annState == 1 then self:Announcer_Prev() end
            if self.ListTimerDir == nil then
                self.ListTimer = CurTime()+0.4
                self.ListTimerDir = false
            end
        else
            self.ListTimer = nil
            self.ListTimerDir = nil
        end
    ---- ▼
    elseif name == "Down" then
        if value then
            self:List_Next()
            if annState == 1 then self:Announcer_Next() end
            if self.ListTimerDir == nil then
                self.ListTimer = CurTime()+0.4
                self.ListTimerDir = true
            end
        else
            self.ListTimer = nil
            self.ListTimerDir = nil
        end
    ---- Enter
    elseif name == "Enter" then
        if annState == 0 then return end
        if annState == 1 then
            self:Announcer_CabPlay()
        elseif annState == 2 then
            Announcer.PrevState2 = Announcer.PrevState
            local sTbl = self[self.SettingsList[selected][2]]
            self:Announcer_SetState(20+selected,sTbl and #sTbl or 1)
            if selected == 5 then
                local Cam = self.Cam
                local videoSended = (Cam[1].Link==true or Cam[2].Link==true or Cam[3].Link==true or Cam[4].Link==true) and 1 or 0
                Train:SetNW2Int("BMCIK:AddInfoNIIPDoors",self.NIIP.DOORS_closed)
                Train:SetNW2Int("BMCIK:AddInfoNIIPSpeed",self.NIIP.SPEED)
                Train:SetNW2Int("BMCIK:AddInfoUPO",self.UPOActive)
                Train:SetNW2Int("BMCIK:AddInfoVideo",videoSended)
            end
        elseif annState > 10 and annState < 20 then
            if annState == 12 then
                local selLast = Announcer.LastStations[selected]
                if Announcer.LimitStation == selLast then
                    Announcer.LimitStation = false
                else
                    Announcer.LimitStation = selLast
                end
            elseif annState == 15 then
                if Announcer.Active and selected == Announcer.Line then
                    self:List_Load(1)
                    Announcer.State = 1
                    return
                end
                Announcer.Line = selected 
                self:Announcer_Activate(true)
            end
        elseif annState > 20 then
            if annState == 22 then
                Announcer.Mode = selected
            elseif annState == 23 then
                if not Announcer.TrainTrain then Announcer.TrainTrain = true end
            elseif annState == 24 then
                local selItem = self.AnnVolumeList[selected]
                local volumes = self.Announcer.Volumes

                volumes[selItem[2]] = volumes[selItem[2]] + 1
                if volumes[selItem[2]] > selItem[4] then volumes[selItem[2]] = selItem[3] end

                -- -- from 0 to N with a resolution of 10. The value of N can be calculated using the formula N = 100 - P,
                -- -- where P - is the value of the volume level set in the line «Громкость инф. в салоне».
                -- -- TODO: See how it works in 81-765 and do it by analogy
                self.Train:CANWrite("BMCIK",nil,"BNT",nil,self.CAN_VOLUMES,{volumes.Salon,volumes.UPOSalon,volumes.V5})
            elseif annState == 28 then
                Announcer.BITTime = selected == 2
                self.Train:CANWrite("BMCIK",nil,"BIT",nil,self.CAN_BITTIME,Announcer.BITTime)
            end
        end
    ---- Esc
    elseif name == "Esc" then
        if annState == 1 then
            -- Single click delay
            if not self.EscBtnTimer then
                self.EscBtnTimer = CurTime() + 0.3
                return
            end

            -- Double click
            self.EscBtnTimer = nil    
            self:Announcer_SetState(14,1)
            return
        end
        if not Announcer.PrevState then return end
        self:List_Load(Announcer.PrevState)
        Announcer.State = Announcer.PrevState
        Announcer.PrevState = Announcer.PrevState2
        Announcer.PrevState2 = nil
    ---- F1
    elseif name == "F1" then
        if annState ~= 1 then return end
        self:Announcer_SetState(11,1)
    ---- F2
    elseif name == "F2" then
        if annState ~= 1 then return end
        Announcer.PrevLimitStation = Announcer.LimitStation
        self:Announcer_SetState(12,#Announcer.LastStations)
    ---- F3
    elseif name == "F3" then
        if annState ~= 1 then return end
        self:Announcer_SetState(13,1)
    ---- F4
    elseif name == "F4" then
        if annState > 1 then return end
        self:Announcer_SetState(2,#self.SettingsList)
    ---- ПУТЬ
    elseif name == "Path" then
        if Announcer.Line == 0 then return end
        Announcer.PathSel = not Announcer.PathSel
    --- >0<
    elseif name == "Zero" then
        if annState > 1 then return end
        -- Single click delay
        if not self.ZeroBtnTimer then 
            self.ZeroBtnTimer = CurTime() + 0.3
            return
        end

        -- Double click
        self.ZeroBtnTimer = nil
        local prevClear = annState == 0
        if annTbl then self:Announcer_SetState(15,#annTbl) end
        if prevClear then Announcer.PrevState = nil end
    ---- ЛИНИЯ
    elseif name == "Line" then
        Announcer.LineEnabled = not Announcer.LineEnabled
    ---- ПУСК
    elseif name == "Start" then
        if annState == 1 and Announcer.Mode == 3 then
            self:Announcer_Play()
            self:Announcer_Next()
            self:List_Next()
            -- if self:Announcer_Next(true) then
            --     self:List_Set(1,1)
            -- else
            --     self:List_Next(1)
            -- end
            self:CANUpdate()
        end
    end
end

function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train

    -- BMCIK-01 logic
    local Power = Train.Electric.Power > 0 and (Train.SF16.Value + Train.SF17.Value) > 0
    if Power then
        local Cam = self.Cam
        local Announcer = self.Announcer
        if self.State > 0 then
            ---- Buttons --------------------
            local valBtn = false
            for k,v in pairs(self.TriggerNames) do
                valBtn = Train[v].Value > 0.5
                if Train[v] and (valBtn) ~= self.Triggers[v] then
                    self:Trigger(v,valBtn)
                    self.Triggers[v] = valBtn
                end
            end

            if self.ZeroBtnTimer and CurTime() > self.ZeroBtnTimer then
                self.ZeroBtnTimer = nil
                if Announcer.State == 0 then
                    self:Announcer_Activate()
                elseif Announcer.State == 1 then
                    self:Announcer_Zero()
                    local lTbl = Metrostroi.SarmatUPOSetup[Train:GetNW2Int("Announcer")][Announcer.Line]
                    local countSt = Announcer.LimitStation and (Announcer.Path and #lTbl - Announcer.LimitStation + 1 or Announcer.LimitStation) or #lTbl
                    self:List_Reset(countSt*2)
                end
            end

            if self.EscBtnTimer and CurTime() > self.EscBtnTimer then
                self.EscBtnTimer = nil
            end

            ---- BUKP CAN -------------------
            if CurTime() > self.CAN_SU then
                self.CAN_SU = CurTime()+0.1

                local BUKP = Train.BUKP
                local niipSpeed = math.floor(BUKP.Speed)
                if self.NIIP.SPEED ~= niipSpeed then
                    Train:CANWrite("BMCIK",nil,"BNT",nil,self.CAN_SPEED,niipSpeed)
                    self.NIIP.SPEED = niipSpeed
                end
                self.NIIP.DOORS_closed = BUKP.LSD and 1 or 0
                
                local cabAcitve = Train.Electric.CabActive
                if self.NIIP.CabActive ~= cabAcitve then
                    if cabAcitve > 0 then -- ПГК
                        self:Announcer_Activate()
                    end
                    self.NIIP.CabActive = cabAcitve
                end
            end

            ---- Cameras --------------------
            if Cam.Page > 0 then
                local wags = {false,false,false,false}
                local wagList = Train.WagonList
                for i=1,Cam.WagNum do
                    local iWag = wagList[i]
                    if Cam[1].Link and Cam[1].Ent == iWag then wags[1] = true end
                    if Cam[2].Link and Cam[2].Ent == iWag then wags[2] = true end
                    if Cam[3].Link and Cam[3].Ent == iWag then wags[3] = true end
                    if Cam[4].Link and Cam[4].Ent == iWag then wags[4] = true end
                end

                local camC = 0
                for i=1,4 do
                    local iCam = Cam[i]
                    if iCam.Link == true then
                        Train:SetNW2Entity("BMCIK:CamE"..i,iCam.Ent)
                        if not wags[i] or iCam.Ent.Electric.Power < 1 then
                            iCam.Link = false
                        end
                    else
                        if iCam.Link and CurTime() > iCam.Link then
                            iCam.Link = wags[i]
                        end
                    end
                    camC = setBitValue(camC,iCam.Link==true and 1 or 0,i-1,1)
                end
                camC = setBitValue(camC,Cam.Fullscreen,4,3)
                Train:SetNW2Int("BMCIK:Cam",camC)

                if Cam.AutoOpen then
                    Cam.Distance = Cam.Distance + self.NIIP.SPEED*dT/3.6
                    if Cam.Distance > Cam.TrainLen then
                        self:Cam_Close()
                        Cam.AutoOpen = nil
                        Cam.Distance = nil
                    end
                end
            end
            Train:SetNW2Int("BMCIK:CamPage",Cam.Page)

            ---- Announcer ------------------
            local annPlaying = Train:GetNW2Bool("AnnouncerPlaying")
            if Announcer.State > 0 then
                if Announcer.Active then
                    if Announcer.AVTDepart then
                        if self.NIIP.SPEED > 3 then
                            if self:Announcer_Next(true) then
                                self:List_Set(1,1)
                            else
                                self:List_Next(1)
                            end
                            
                            Announcer.AVTDepart = false
                        end
                    end

                    if Announcer.CabPlay and not annPlaying and #Train.Announcer.Schedule == 0 then
                        self:Announcer_CabStop()
                    end

                    self.LineOut = (Train.Announcer.AnnTable=="AnnouncementsSarmatUPO" and annPlaying) and 1 or 0
                    self.UPOActive = Announcer.Mode > 1 and 1 or 0
                    if self.UPOActive > 0 then
                        Announcer.UPOLock = Train.UPO.LineOut > 0
                    end

                    Train:SetNW2Int("BMCIK:VolCab",Announcer.UPOLock and Announcer.Volumes.UPOCabin or Announcer.Volumes.Cabin)
                else
                    if Announcer.State == 1 or (Announcer.State > 10 and Announcer.State < 20 and Announcer.State ~= 15) then
                        self:Announcer_Stop()
                        Train:SetNW2Int("BMCIK:VolCab",0)
                        Announcer.State = 0
                    end
                end

                if self.ListTimer and CurTime() > self.ListTimer then
                    if self.ListTimerDir then
                        self:List_Next()
                        if Announcer.State == 1 then self:Announcer_Next() end
                    else
                        self:List_Prev()
                        if Announcer.State == 1 then self:Announcer_Prev() end
                    end
                    self.ListTimer = CurTime()+0.2
                end

                if Announcer.State > 20 then
                    if Announcer.State == 22 then
                        Train:SetNW2Int("BMCIK:AnnMode",Announcer.Mode)
                    elseif Announcer.State == 23 then
                        Train:SetNW2Bool("BMCIK:TrainTrain",Announcer.TrainTrain)
                    elseif Announcer.State == 24 then
                        local volumes = 0
                        local annVolumes = Announcer.Volumes
                        volumes = setBitValue(volumes,annVolumes.Cabin,0,4)
                        volumes = setBitValue(volumes,annVolumes.Salon,4,4)
                        volumes = setBitValue(volumes,annVolumes.UPOCabin,8,4)
                        volumes = setBitValue(volumes,annVolumes.UPOSalon,12,4)
                        volumes = setBitValue(volumes,annVolumes.EmerCab,16,4)
                        volumes = setBitValue(volumes,annVolumes.V5,20,4)
                        Train:SetNW2Int("BMCIK:VolumesPage",volumes)
                    elseif Announcer.State == 28 then
                        Train:SetNW2Bool("BMCIK:BITTime",Announcer.BITTime)
                    end
                end

                Train:SetNW2Int("BMCIK:ListSelect",self.List.Selected)
                Train:SetNW2Int("BMCIK:ListOffset",self.List.Offset)
            else
                Announcer.Active = false
                self.LineOut = annPlaying and 1 or 0
                self.UPOActive = 0
            end

            local cikState = 0
            if Train.Microphone.Value > 0 then
                if Announcer.LineEnabled then
                    cikState = 3 -- Громкая связь
                else
                    cikState = 2 -- Межкабинная связь активна
                end
            elseif self.LineOut + Train.UPO.LineOut > 0 then
                cikState = 1 -- Воспроизведение...
            else
                cikState = 0 -- Готов
            end
            if Announcer.CIKStateIntercab then
                cikState = Announcer.CIKStateIntercab
            end
            
            if Announcer.CIKState ~= cikState then
                if not Announcer.CIKStateIntercab then
                    Train:CANWrite("BMCIK",Train:GetWagonNumber(),"BMCIK",nil,self.CAN_CIKSTATE,cikState > 1 and cikState or nil)
                end

                if Announcer.Active and cikState == 3 and self.LineOut then self:Announcer_Stop() end
                Announcer.CIKState = cikState
            end

            local ann = 0
            ann = setBitValue(ann,Announcer.State,0,6)
            ann = setBitValue(ann,Announcer.CIKState,6,4)
            ann = setBitValue(ann,Announcer.Line,10,8)
            ann = setBitValue(ann,Announcer.LimitStation or 0,18,12)
            ann = setBitValue(ann,Announcer.Path and 1 or 0,30,1)
            ann = setBitValue(ann,Announcer.PathSel and 1 or 0,31,1)
            Train:SetNW2Int("BMCIK:Announcer",ann)
            Train:SetNW2Bool("BMCIK:LineEnabled",Announcer.LineEnabled)
        elseif self.State < 0 then
            if CurTime() > self.LoadingTimer then
                if self.State == -6 then
                    self.State = -5
                    self.LoadingTimer = CurTime()+math.Rand(0.9,1.5)
                elseif self.State == -5 then
                    self.State = -4
                    self.LoadingTimer = CurTime()+2
                elseif self.State == -4 then
                    self.State = -3
                    self.LoadingTimer = CurTime()+math.Rand(9,12)
                elseif self.State == -3 then
                    self.State = -2
                    self.LoadingTimer = CurTime()+math.Rand(1,3)
                elseif self.State == -2 then
                    self.State = -1
                    self.LoadingTimer = CurTime()+math.Rand(2,3)
                elseif self.State == -1 then
                    self.State = 1
                    self.CAN_SU = CurTime()
                    self:Cam_Scan()
                end
            end
            if self.State == -4 then Train:SetNW2Int("BMCIK:GRUBTimeout",self.LoadingTimer - CurTime() + 1) end
        else
            self.State = -6
            self.LoadingTimer = CurTime()+math.Rand(5,7)
            -- self.State = -2
            -- self.LoadingTimer = CurTime()+3
        end
    else
        if self.State ~= 0 then
            self:MemReset()
            self.State = 0
        end
    end

    -- BMTS-07 logic
    local BMTSPower = Train.Electric.Power > 0 and Train.SF18.Value > 0
    local BMTS = self.BMTS
    if BMTSPower and Train.SF18.Value > 0 then
        if BMTS.State == 0 then
            BMTS.State = -1
            BMTS.Loading = CurTime()+5
            BMTS.Update = true
        elseif self.BMTS.State == -1 then
            if CurTime() > BMTS.Loading then
                BMTS.State = 1
                BMTS.Text = ""
                BMTS.Loading = nil
                BMTS.Update = true
            end
        end
    else 
        if BMTS.State ~= 0 then
            BMTS.State = 0
            BMTS.Text = ""
            BMTS.Update = true
        end
    end

    Train:SetNW2Int("BMCIK:State",self.State)
    if BMTS.Update then
        BMTS.Update = false
        Train:SetNW2Int("BMTS:State",BMTS.State)
        Train:SetNW2String("BMTS:Text",BMTS.Text)
    end
end

function TRAIN_SYSTEM:MemReset(resetAnn)
    self.ZeroBtnTimer = nil
    self.EscBtnTimer = nil
    self.Brightness = 1

    self.NIIP.CabActive = false

    self:Cam_Reset()
    self:Announcer_Reset(resetAnn)
    self:List_Reset()

    self.Train:SetNW2Int("BMCIK:IDTouched",0)
    self.Train:SetNW2Float("BMCIK:Brightness",1)
    self.Train:SetNW2Int("BMCIK:VolCab",0)
end

if SERVER then return end

local font20 = "Metrostroi_Dejavu20"
local font21 = "Metrostroi_Dejavu21"
local font28 = "Metrostroi_Dejavu28"

-- Create fonts
local function createFont(name,font,size,weight,noAA)
    surface.CreateFont("Metrostroi_"..name, {
        font = font,
        size = size,
        weight = weight or 400,
        blursize = 0,
        antialias = not noAA,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
        extended = true,
    })
end
createFont("Dejavu20","Dejavu Sans",20)
createFont("Dejavu21","Dejavu Sans",21)
createFont("Dejavu22","Dejavu Sans",22)
createFont("Dejavu26","Dejavu Sans",26)
createFont("Dejavu28","Dejavu Sans",28)
createFont("BMTS1","Arial",14,800,true)
createFont("BMTS2","Arial",17,800,true)
createFont("BMTS3","Arial",22,800,true)
createFont("BMTS4","Arial",30,800,true)

local function drawText(text,x,y,xalign,yalign)
    if (xalign or yalign) then
        local w,h = surface.GetTextSize( text )
        if (xalign == TEXT_ALIGN_CENTER) then
            x = x - w / 2
        elseif (xalign == TEXT_ALIGN_RIGHT) then
            x = x - w
        end

        if (yalign == TEXT_ALIGN_CENTER) then
            y = y - h / 2
        elseif (yalign == TEXT_ALIGN_BOTTOM) then
            y = y - h
        end
    end
    surface.SetTextPos(x,y)
    surface.DrawText(text)
end

local scx,scy = 1,1 -- Multipliers for fix RT draw on screen
function TRAIN_SYSTEM:ClientInitialize()
    scx,scy = math.max(ScrW()/2048,1),math.max(ScrH()/1024,1)
    self.Cams = {
        {self.Train:CreateRT("722BVK1",512,512),0},
        {self.Train:CreateRT("722BVK2",512,512),0},
        {self.Train:CreateRT("722BVK3",512,512),0},
        {self.Train:CreateRT("722BVK4",512,512),0}
    }

    self.HeaderNames = table.Copy(self.HeaderNames)
    self.List = {
        Selected = 0,
        Offset = 0
    }
    self.BMTS = {
        State = 0,
        Text = "",
        Update = true
    }
end

local BMTSPixels = surface.GetTextureID("models/metrostroi_train/81-722/screens/sarmat_upo/bmts")
function TRAIN_SYSTEM:ClientThink(dT)
    -- БМЦИК-01 ЦИКВ.465122.049
    if self.Train:ShouldDrawPanel("BMCIK") then
        render.PushRenderTarget(self.Train.BMCIKScr,0,0,2048, 1024)
        render.Clear(0, 0, 0, 0)
        cam.Start2D()
            render.SetScissorRect(0,0,1280,800,true)
            surface.SetDrawColor(0,0,0)
            surface.DrawRect(0,0,1280,800)
            local state = self.Train:GetNW2Int("BMCIK:State",0)
            self:BMCIK01(self.Train,state)
            if state ~= 0 then
                surface.SetDrawColor(20,20,90,8)
                surface.DrawRect(0,0,1280,800)
            end
            render.SetScissorRect(0,0,0,0,false)
        cam.End2D()
        render.PopRenderTarget()
    end

    -- БМТС-07 ЦИКВ.402261.031
    if self.Train:ShouldDrawPanel("BMTS") then
        local BMTSText = self.Train:GetNW2String("BMTS:Text","")
        local BMTSState = self.Train:GetNW2Int("BMTS:State",0)
        if self.BMTS.State ~= BMTSState then
            self.BMTS.State = BMTSState
            self.BMTS.Update = true
        end
        if self.BMTS.State > 0 and self.BMTS.Text ~= BMTSText then
            self.BMTS.Text = BMTSText
            self.BMTS.Update = true
        end

        if self.BMTS.Update then
            render.PushRenderTarget(self.Train.BMTSScr,0,0,512,128)
            render.Clear(0, 0, 0, 0)
            cam.Start2D()
                self:BMTS07(self.Train)
                render.OverrideBlend(true,BLEND_ZERO,BLEND_ONE,BLENDFUNC_ADD,BLEND_ZERO,BLEND_ZERO,BLENDFUNC_MIN)
                    surface.SetDrawColor(255,255,255,200)
                    surface.SetTexture(BMTSPixels)
                    surface.DrawTexturedRectRotated(256,64,512,128,0)
                render.OverrideBlend(false)
            cam.End2D()                   
            render.PopRenderTarget()
            self.BMTS.Update = false
        end
    end
end

local sarmatLogo = surface.GetTextureID("models/metrostroi_train/81-722/screens/sarmat_upo/sarmat_logo")
local grubMenu = surface.GetTextureID("models/metrostroi_train/81-722/screens/sarmat_upo/grub")
function TRAIN_SYSTEM:BMCIK01(Train,state)
    if state == 0 then return end
    if state == -4 then
        local grubTimeout = Train:GetNW2Int("BMCIK:GRUBTimeout",0)
        surface.SetTexture(grubMenu)
        surface.SetDrawColor(255,255,255)
        
        local mat = Matrix()
        mat:SetScale(Vector(2,1.667))
        cam.PushModelMatrix(mat)
            surface.DrawTexturedRect(0,0,1024,512)
            surface.DrawTexturedRectUV(482,398,8,12,0.625+grubTimeout*0.0078125,0,0.6328125+grubTimeout*0.0078125,0.0234375)
        cam.PopModelMatrix()
    elseif state == -3 then
        if (CurTime()%0.5 > 0.25) then
            surface.SetTextColor(255,255,255)
            surface.SetFont(font28)
            drawText("_",2,2)
        end
    elseif state == -2 then
        draw.SimpleText("_",font28,2,16, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        surface.SetTexture(sarmatLogo)
        surface.SetDrawColor(250,190,0)
        surface.DrawTexturedRectRotated(955,685,640,320,0)
    elseif state == 1 then
        self:BMCIK01State1(Train)

        surface.SetAlphaMultiplier(1-self.Train:GetNW2Float("BMCIK:Brightness",1)^1.2)
        surface.SetDrawColor(Color(8,8,8))
        surface.DrawRect(0,0,1280,800,0)
        surface.SetAlphaMultiplier(1)
    end
end

function TRAIN_SYSTEM:BMCIK01State1(Train)
    self.WagNum = Train:GetNW2Int("BMCIK:WagNum",0)

    self:BMCIK01GUICameras(Train)
    self:BMCIK01GUIAnnouncer(Train)

    surface.SetFont(font28)
    surface.SetTextColor(255,255,255)
    drawText(os.date("!%d.%m.%y %H:%M:%S",Metrostroi.GetSyncTime()),681,742)
    drawText("Ver. 6",681,768)
end

local function drawButton(x,y,w,h,text,touched)
    draw.RoundedBox(8,x,y,w,h,Color(255,255,255))
    draw.RoundedBox(6,x+2,y+2,w-4,h-4,touched and Color(83,83,83) or Color(35,35,35))

    drawText(text,x+w/2,y+h/2,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
end

local BMCIKPos = Vector(472,37.4,-9)
local camFrame = surface.GetTextureID("models/metrostroi_train/81-722/screens/sarmat_upo/cam_frame")
function TRAIN_SYSTEM:BMCIK01GUICameras(Train)
    local wagNum = self.WagNum
    local camPage = Train:GetNW2Int("BMCIK:CamPage",0)
    local touchId = Train:GetNW2Int("BMCIK:IDTouched",0)

    surface.SetFont(font28)
    surface.SetTextColor(255,255,255)
    for i=1,self.Buttons.Count do
        local btn = self.Buttons[i]
        if btn.show(camPage) then
            drawButton(btn.x,btn.y,btn.w,btn.h,Format(btn.name,wagNum),touchId == btn.id)
        end
    end
    if camPage == 0 then
        drawText("Система видеонаблюдения",457,32,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

        for i=1,self.Buttons.Count do
            local btn = self.Buttons[i]
            drawButton(btn.x,btn.y,btn.w,btn.h,Format(btn.name,wagNum),touchId == btn.id)
        end

        drawText("Наружные камеры",457,129,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        drawText("1",74,185)
        drawText(wagNum,74,213)
        drawText("Вагон 1",311,163,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        drawText("Все вагоны",457,163,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        drawText("Вагон "..wagNum,603,163,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        drawText("1",825,185)
        drawText(wagNum,825,213)

        drawText("Камеры в салонах",457,303,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        for i=1,wagNum do
            if wagNum == 8 then
                drawButton(350+(i-wagNum/2)*110,323,104,60,"Вагон "..i,touchId == 10+i)
            elseif wagNum == 7 then
                drawButton(334+(i-wagNum/2)*126,323,120,60,"Вагон "..i,touchId == 10+i)
            else
                drawButton(313+(i-wagNum/2)*147,323,141,60,"Вагон "..i,touchId == 10+i)
            end
        end
        
        drawText("Камеры на постах машиниста",457,443,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        drawText("Путевые камеры",457,583,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    else
        -- Номер вагона, тип вагона, бортовой номер
        local camWagIndex = Train:GetNW2Int("BMCIK:CamWagIndex",0)
        local camWagType = Train:GetNW2Int("BMCIK:CamType",0)
        local camWagNum = Train:GetNW2Int("BMCIK:CamWagNumber",0)
        local camCurrConf = self.CamConfig[camWagType][camPage] or self.CamConfig[0][1]

        surface.SetFont("Metrostroi_Dejavu26")
        local headerCurr = Format("Вагон %d [%d] - %s - страница %d/%d",camWagIndex,camWagNum,camCurrConf.PageName,camPage,self.CamConfig[camWagType].Count)
        local headerCurrW = surface.GetTextSize(headerCurr)

        surface.SetDrawColor(255,255,255)
        surface.SetTexture(camFrame)
        surface.DrawTexturedRectRotated(530,542,1024,1024,0)

        surface.SetDrawColor(0,0,0)
        surface.DrawRect(457 - ((headerCurrW+10)/2-0.5),30,headerCurrW+10,1)
        drawText(headerCurr,457 - headerCurrW/2,20)

        local CamNW2 = Train:GetNW2Int("BMCIK:Cam",0)
        local Cam1 = getBitValue(CamNW2,0,1) > 0
        local Cam2 = camCurrConf.Count > 1 and getBitValue(CamNW2,1,1) > 0
        local Cam3 = camCurrConf.Count > 2 and getBitValue(CamNW2,2,1) > 0
        local Cam4 = camCurrConf.Count > 3 and getBitValue(CamNW2,3,1) > 0

        local camTbl
        if Cam1 then
            camTbl = camCurrConf[1]
            Metrostroi.RenderCamOnRT(Train,BMCIKPos,"Cam1",0.1+0.15*math.random(),self.Cams[1][1],Train:GetNW2Entity("BMCIK:CamE1"),camTbl[2],camTbl[3],512,512,not camTbl.wide and 1.4,not camTbl.wide and 74,not camTbl.wide and 74)
            self.Cams[1][2] = Metrostroi.CamQueue[1] and (Metrostroi.CamQueue[1][3]:EndsWith("1") and math.floor(1/Metrostroi.CamQueue[1][4])) or self.Cams[1][2]
        end
        if Cam2 then
            camTbl = camCurrConf[2]
            Metrostroi.RenderCamOnRT(Train,BMCIKPos,"Cam2",0.1+0.15*math.random(),self.Cams[2][1],Train:GetNW2Entity("BMCIK:CamE2"),camTbl[2],camTbl[3],512,512,not camTbl.wide and 1.4,not camTbl.wide and 74,not camTbl.wide and 74)
            self.Cams[2][2] = Metrostroi.CamQueue[1] and (Metrostroi.CamQueue[1][3]:EndsWith("2") and math.floor(1/Metrostroi.CamQueue[1][4])) or self.Cams[2][2]
        end
        if Cam3 then
            camTbl = camCurrConf[3]
            Metrostroi.RenderCamOnRT(Train,BMCIKPos,"Cam3",0.1+0.15*math.random(),self.Cams[3][1],Train:GetNW2Entity("BMCIK:CamE3"),camTbl[2],camTbl[3],512,512,not camTbl.wide and 1.4,not camTbl.wide and 74,not camTbl.wide and 74)
            self.Cams[3][2] = Metrostroi.CamQueue[1] and (Metrostroi.CamQueue[1][3]:EndsWith("3") and math.floor(1/Metrostroi.CamQueue[1][4])) or self.Cams[3][2]
        end
        if Cam4 then
            camTbl = camCurrConf[4]
            Metrostroi.RenderCamOnRT(Train,BMCIKPos,"Cam4",0.1+0.15*math.random(),self.Cams[4][1],Train:GetNW2Entity("BMCIK:CamE4"),camTbl[2],camTbl[3],512,512,not camTbl.wide and 1.4,not camTbl.wide and 74,not camTbl.wide and 74)
            self.Cams[4][2] = Metrostroi.CamQueue[1] and (Metrostroi.CamQueue[1][3]:EndsWith("4") and math.floor(1/Metrostroi.CamQueue[1][4])) or self.Cams[4][2]
        end
        
        local camFullScreen = getBitValue(CamNW2,4,3)
        surface.SetFont(font20)
        if camFullScreen > 0 then
            local tCam = getBitValue(CamNW2,camFullScreen-1,1) > 0
            if tCam then
                render.DrawTextureToScreenRect(self.Cams[camFullScreen][1],scx*24,scy*58,scx*866,scy*662)
                surface.SetTextColor(200,0,0)
                drawText("fps = "..(self.Cams[camFullScreen][2]),26,78)

                surface.SetTextColor(0,200,0)
                drawText("link",888,698,TEXT_ALIGN_RIGHT)
            else
                surface.SetTextColor(200,0,0)
                drawText("no link",888,698,TEXT_ALIGN_RIGHT)
            end
            Metrostroi.DrawRectOutline(24,58,867,663,Color(176,176,176))
            surface.SetTextColor(250,200,0)
            drawText(camCurrConf[camFullScreen][1],26,58)
        elseif camCurrConf.Count == 4 then
            -- Top left
            if Cam1 then
                render.DrawTextureToScreenRect(self.Cams[1][1],scx*24,scy*58,scx*430,scy*328)
                surface.SetTextColor(200,0,0)
                drawText("fps = "..(self.Cams[1][2]),26,78)

                surface.SetTextColor(0,200,0)
                drawText("link",451,364,TEXT_ALIGN_RIGHT)
            else
                surface.SetTextColor(200,0,0)
                drawText("no link",451,364,TEXT_ALIGN_RIGHT)
            end

            -- Top right
            if Cam2 then
                render.DrawTextureToScreenRect(self.Cams[2][1],scx*460,scy*58,scx*430,scy*328)
                surface.SetTextColor(200,0,0)
                drawText("fps = "..(self.Cams[2][2]),462,78)

                surface.SetTextColor(0,200,0)
                drawText("link",888,364,TEXT_ALIGN_RIGHT)
            else
                surface.SetTextColor(200,0,0)
                drawText("no link",888,364,TEXT_ALIGN_RIGHT)
            end

            -- Bottom left
            if Cam3 then
                render.DrawTextureToScreenRect(self.Cams[3][1],scx*24,scy*392,scx*430,scy*328)
                surface.SetTextColor(200,0,0)
                drawText("fps = "..(self.Cams[3][2]),26,414)

                surface.SetTextColor(0,200,0)
                drawText("link",451,698,TEXT_ALIGN_RIGHT)
            else
                surface.SetTextColor(200,0,0)
                drawText("no link",451,698,TEXT_ALIGN_RIGHT)
            end
            
            -- Bottom right
            if Cam4 then
                render.DrawTextureToScreenRect(self.Cams[4][1],scx*460,scy*392,scx*430,scy*328)
                surface.SetTextColor(200,0,0)
                drawText("fps = "..(self.Cams[4][2]),462,414)

                surface.SetTextColor(0,200,0)
                drawText("link",888,698,TEXT_ALIGN_RIGHT)
            else
                surface.SetTextColor(200,0,0)
                drawText("no link",888,698,TEXT_ALIGN_RIGHT)
            end


            Metrostroi.DrawRectOutline(24,58,431,329,Color(176,176,176))
            Metrostroi.DrawRectOutline(460,58,431,329,Color(176,176,176))
            Metrostroi.DrawRectOutline(24,392,431,329,Color(176,176,176))
            Metrostroi.DrawRectOutline(460,392,431,329,Color(176,176,176))

            surface.SetTextColor(250,200,0)
            drawText(camCurrConf[1][1],26,58)
            drawText(camCurrConf[2][1],462,58)
            drawText(camCurrConf[3][1],26,394)
            drawText(camCurrConf[4][1],462,394)
        elseif camCurrConf.Count == 2 then
            -- Left
            if Cam1 then
                render.DrawTextureToScreenRect(self.Cams[1][1],scx*24,scy*58,scx*430,scy*662)
                surface.SetTextColor(200,0,0)
                drawText("fps = "..(self.Cams[1][2]),26,78)

                surface.SetTextColor(0,200,0)
                drawText("link",451,698,TEXT_ALIGN_RIGHT)
            else
                surface.SetTextColor(200,0,0)
                drawText("no link",451,698,TEXT_ALIGN_RIGHT)
            end

            -- Right
            if Cam2 then
                render.DrawTextureToScreenRect(self.Cams[2][1],scx*460,scy*58,scx*430,scy*662)
                surface.SetTextColor(200,0,0)
                drawText("fps = "..(self.Cams[2][2]),462,78)

                surface.SetTextColor(0,200,0)
                drawText("link",888,698,TEXT_ALIGN_RIGHT)
            else
                surface.SetTextColor(200,0,0)
                drawText("no link",888,698,TEXT_ALIGN_RIGHT)
            end


            Metrostroi.DrawRectOutline(24,58,431,663,Color(176,176,176))
            Metrostroi.DrawRectOutline(460,58,431,663,Color(176,176,176))

            surface.SetTextColor(250,200,0)
            drawText(camCurrConf[1][1],26,58)
            drawText(camCurrConf[2][1],462,58)
        else
            if Cam1 then
                render.DrawTextureToScreenRect(self.Cams[1][1],scx*24,scy*58,scx*866,scy*662)
                surface.SetTextColor(200,0,0)
                drawText("fps = "..(self.Cams[1][2]),26,78)
                
                surface.SetTextColor(0,200,0)
                drawText("link",888,698,TEXT_ALIGN_RIGHT)
            else
                surface.SetTextColor(200,0,0)
                drawText("no link",888,698,TEXT_ALIGN_RIGHT)
            end
            Metrostroi.DrawRectOutline(24,58,867,663,Color(176,176,176))
            surface.SetTextColor(250,200,0)
            drawText(camCurrConf[1][1],26,58)
        end
    end
end

local listCursor = surface.GetTextureID("models/metrostroi_train/81-722/screens/sarmat_upo/list_cursor")
function TRAIN_SYSTEM:DrawListLine(text,pos,selected)
    pos = pos - self.List.Offset
    if selected then
        surface.SetTexture(listCursor)
        surface.SetDrawColor(176,176,176)
        surface.DrawTexturedRectRotated(1174,132+(pos-1)*24,512,32,0)

        surface.SetTextColor(0,0,0)
    else
        surface.SetTextColor(255,255,255)
    end
    
    drawText(tostring(text),selected and 924 or 920,94+pos*24)
end

local annFrame = surface.GetTextureID("models/metrostroi_train/81-722/screens/sarmat_upo/ann_frame")
local lineFrame = surface.GetTextureID("models/metrostroi_train/81-722/screens/sarmat_upo/line_frame")
local trainTrainMsg = surface.GetTextureID("models/metrostroi_train/81-722/screens/sarmat_upo/traintrain_msg")
function TRAIN_SYSTEM:BMCIK01GUIAnnouncer(Train)
    local listSelected = Train:GetNW2Int("BMCIK:ListSelect"); self.List.Selected = listSelected;
    local listOffset = Train:GetNW2Int("BMCIK:ListOffset"); self.List.Offset = listOffset;

    local annNW2 = Train:GetNW2Int("BMCIK:Announcer")
    local annState = getBitValue(annNW2,0,6)
    local annLine = getBitValue(annNW2,10,8)
    local annLimit = getBitValue(annNW2,18,12); annLimit = annLimit > 0 and annLimit
    local annPath = getBitValue(annNW2,30,1) > 0
    local annPathSel = getBitValue(annNW2,31,1) > 0

    local annTbl = Metrostroi.SarmatUPOSetup[Train:GetNW2Int("Announcer")]
    local lTbl = annTbl and annTbl[annLine]
    local lTblCount = lTbl and #lTbl or 0

    surface.SetFont(font28)
    surface.SetTextColor(255,255,255)
    drawText("линия",1054,11)
    drawText(lTbl and "ПУТЬ "..(annPathSel and 2 or 1) or "---",1213,25,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

    surface.SetTexture(lineFrame)
    if Train:GetNW2Bool("BMCIK:LineEnabled") then
        surface.SetDrawColor(0,255,0)
        surface.SetTextColor(0,255,0)
    else
        surface.SetDrawColor(59,59,59)
        surface.SetTextColor(59,59,59)
    end
    surface.DrawTexturedRectRotated(1096,25,128,32,0)
    drawText("линия",1053,10)

    -- Header
    surface.SetTextColor(255,255,255)
    if annState < 2 then
        local lNameHeader = "---"
        if lTbl then
            if lTbl.Name then
                lNameHeader = "Линия: "..lTbl.Name
            else
                local fSt = annPath and 1 or lTblCount
                local lSt = annLimit or (annPath and 1 or lTblCount)
                lNameHeader = Format("Линия: %s-%s",lTbl[fSt][2],lTbl[lSt][2]) -- "Линия: " = 92px
            end
            if surface.GetTextSize(lNameHeader) > 355 then
                lNameHeader = lNameHeader:gsub("-","-\n",1)
            end
        end
        self.HeaderNames[0] = lNameHeader
        self.HeaderNames[1] = self.HeaderNames[0]
    end
    local textHeader = string.Explode("\n",self.HeaderNames[annState])
    for i=1,#textHeader do
        drawText(textHeader[i],1091,78-(#textHeader-1)*14+(i-1)*28,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end

    -- White frame
    if annState > 0 and annState ~= 21 then
        surface.SetDrawColor(255,255,255)
        surface.SetTexture(annFrame)
        surface.DrawTexturedRectRotated(1169,623,512,1024,0)
    end

    -- Lists
    render.SetScissorRect(918,116,1264,637,true)
    surface.SetFont(font21)
    if annState == 0 then
        surface.SetFont(font28)
        drawText("Блок неактивен",992,112)
    elseif annState == 1 then
        if annPath then
            for i=lTblCount,1,-1 do
                if annLimit and i < annLimit then break end
                local iPos=(lTblCount-i+1)*2
                
                self:DrawListLine(lTbl[i][2],iPos-1,listSelected==(iPos-1))
                self:DrawListLine(lTbl[i][2].." отп",iPos,listSelected==iPos)
            end
        else
            for i=1,lTblCount do
                if annLimit and i > annLimit then break end
                local iPos=i*2
                
                self:DrawListLine(lTbl[i][2],i*2-1,listSelected==(i*2-1))
                self:DrawListLine(lTbl[i][2].." отп",i*2,listSelected==(i*2))
            end
        end
    elseif annState > 10 and annState < 20 then
        if annState == 11 then -- Предупредительные сообщения
            self:DrawListLine("Нет сообщений",1,true)
        elseif annState == 12 then -- Ограничения маршрута
            local iLast = 1
            if lTbl.Loop then
                for i=1,lTblCount do
                    if lTbl[i].arrlast then
                        self:DrawListLine((annLimit == i and "☑ " or "☐ ")..lTbl[i][2],iLast,listSelected==iLast)
                        iLast = iLast + 1
                    end
                end
            else
                for i=2,lTblCount-1 do
                    if lTbl[i].arrlast then
                        self:DrawListLine((annLimit == i and "☑ " or "☐ ")..lTbl[i][2],iLast,listSelected==iLast)
                        iLast = iLast + 1
                    end
                end
            end
        elseif annState == 13 then -- Дополнительные сообщения
            self:DrawListLine("Нет сообщений",1,true)
        elseif annState == 14 then -- Экстренные сообщение
            self:DrawListLine("Нет сообщений",1,true)
        elseif annState == 15 then -- Выбор линии
            for i=1,#annTbl do
                local lName = annTbl[i].Name or Format("%s-%s",annTbl[i][1][2],annTbl[i][#annTbl[i]][2])
                self:DrawListLine(lName,i,listSelected==i)
            end
        end
    elseif annState == 2 then -- Меню настройки блока СБУЦИК
        for i=1,#self.SettingsList do
            self:DrawListLine(self.SettingsList[i][1],i,listSelected==i)
        end
    elseif annState > 20 then
        if annState == 21 then -- Ввод номера маршрута
            surface.SetFont(font28)
            drawText("Ввод номера маршрута",945,112)
        elseif annState == 22 then -- Режимы работы информатора
            local mode = Train:GetNW2Int("BMCIK:AnnMode",0)
            for i=1,#self.AnnModeList do
                self:DrawListLine((mode == i and "☑ " or "☐ ")..self.AnnModeList[i],i,listSelected==i)
            end
        elseif annState == 23 then -- Режимы работы СОСТАВ-СОСТАВ
            local mode = Train:GetNW2Bool("BMCIK:TrainTrain")
            self:DrawListLine((mode and "☑ " or "☐ ").."Режим 'Состав-Состав'",1,true)
            if mode then
                render.SetScissorRect(0,0,0,0,false)
                surface.SetDrawColor(255,255,255)
                surface.DrawRect(900,400,378,250)
                surface.SetTexture(trainTrainMsg)
                surface.DrawTexturedRectRotated(1156,528,512,256,0)
            end
        elseif annState == 24 then -- Настройка громкости
            local volumes = Train:GetNW2Int("BMCIK:VolumesPage")
            local volumeList = self.AnnVolumeList
            for i=1,#volumeList do
                self:DrawListLine(volumeList[i][1],i,listSelected==i)
                drawText(getBitValue(volumes,(i-1)*4,4)*10,1230,118+(i-1)*24,TEXT_ALIGN_CENTER)
            end
        elseif annState == 25 then -- Информация
            local info = self.InfoList
            local infoNW2 = Train:GetNW2Int("BMCIK:AddInfo",0)
            for i=1,#info do
                local v = info[i][2] and Train:GetNW2Int(info[i][2]) or 0
                self:DrawListLine(info[i][1]..v,i,listSelected==i)
            end
        elseif annState == 26 then -- Диагностика
            for i=1,#self.DiagList do
                self:DrawListLine(self.DiagList[i],i,listSelected==i)
            end
        elseif annState == 27 then -- Язык
            -- TODO: Add translations support
            local mode = 1
            for i=1,#self.LangList do
                self:DrawListLine((mode==i and "☑ " or "☐ ")..self.LangList[i],i,listSelected==i)
            end
        elseif annState == 28 then -- Отображение времени на БИТ
            local mode = Train:GetNW2Bool("BMCIK:BITTime") and 2 or 1
            for i=1,#self.BITClockList do
                self:DrawListLine((mode==i and "☑ " or "☐ ")..self.BITClockList[i],i,listSelected==i)
            end
        end
    end
    render.SetScissorRect(0,0,0,0,false)

    surface.SetTextColor(255,255,255)
    surface.SetFont("Metrostroi_Dejavu22")
    drawText("Состав:",924,647)

    surface.SetFont(font28)
    local wagNum = self.WagNum
    for i=0,wagNum-1 do
        drawButton(1091+(i-wagNum/2)*41,673,40,48,i+1)
    end

    local cikState = getBitValue(annNW2,6,4)
    drawText(self.CIKStatesNames[cikState],913,756)
end

local function stringUpperCyrillic(str)
    if #str == 0 then return "" end
    local strtbl = {utf8.codepoint(str,1,-1)}
    local strUp = ""
    for i=1,#strtbl do
        local chartbl = strtbl[i]
        if chartbl > 0x042F and chartbl < 0x0450 then chartbl = chartbl - 0x20 -- [а,я] --> [A,Я]
        elseif chartbl == 0x0456 then chartbl = 0x0406 -- і -> І
        elseif chartbl == 0x0451 then chartbl = 0x0401 -- ё -> Ё
        elseif chartbl == 0x0457 then chartbl = 0x0407 -- ї -> Ї
        elseif chartbl == 0x0454 then chartbl = 0x0404 -- є -> Є
        elseif chartbl == 0x045E then chartbl = 0x040E -- ў -> Ў
        elseif chartbl == 0x0491 then chartbl = 0x0490 -- ґ -> Ґ
        end
        
        strUp = strUp..(utf8.char(chartbl))
    end
    return string.upper(strUp)
end

function TRAIN_SYSTEM:BMTS07(Train)
    local state = self.BMTS.State
    if state == 0 then return end
    if state == 1 then
        surface.SetFont("Metrostroi_BMTS4")
        surface.SetTextColor(255,120,0)
        local lastStation = stringUpperCyrillic(self.BMTS.Text)
        local lsW,lsY = surface.GetTextSize(lastStation),-5
        if lsW >= 230 then
            surface.SetFont("Metrostroi_BMTS1")
            lsW = surface.GetTextSize(lastStation)
            lsY = 3
        elseif lsW >= 168 then
            surface.SetFont("Metrostroi_BMTS2")
            lsW = surface.GetTextSize(lastStation)
            lsY = 2
        elseif lsW >= 126 then
            surface.SetFont("Metrostroi_BMTS3")
            lsW = surface.GetTextSize(lastStation)
            lsY = -1
        end
        local mat = Matrix()
        mat:Scale(Vector(4,4))
        cam.PushModelMatrix(mat)
            surface.SetTextPos(64-lsW/2, lsY)
            surface.DrawText(lastStation)
        cam.PopModelMatrix()
    elseif state == -1 then
        surface.SetDrawColor(255,120,0)
        surface.DrawRect(0,0,512,80)
    end
end
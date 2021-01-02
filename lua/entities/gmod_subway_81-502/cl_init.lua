--------------------------------------------------------------------------------
-- All the models, materials, sounds belong to their corresponding authors. Permission is granted to only distribute these models through Garry's Mod Steam Workshop and the official Metrostroi GitHub accounts for use with Garry's Mod and Metrostroi Subway Simulator.
--
-- It is forbidden to use any of these models, materials, sounds and other content for any commercial purposes without an explicit permission from the authors. It is forbidden to make any changes in these files in any derivative projects without an explicit permission from the author.
--
-- The following models are (C) 2015-2018 oldy (Aleksandr Kravchenko). All rights reserved.
-- models\metrostroi_train\81-502:
-- - 81-502  (Ema-502 head)
-- - 81-501  (Em-501 intermediate)
-- models\metrostroi_train\81-702:
-- - 81-702  (D head)
-- - 81-702  (D intermediate)
-- models\metrostroi_train\81-703:
-- - 81-703  (E head)
-- - 81-508  (E intermediate)
-- models\metrostroi_train\81-707:
-- - 81-707  (Ezh head)
-- - 81-708  (Ezh1 intermediate)
-- models\metrostroi_train\81-710:
-- - 81-710  (Ezh3 head)
-- - 81-508T (Em-508T intermediate)
-- models\metrostroi_train\81-717:
-- - 81-717  (Moscow head)
-- - 81-714  (Moscow intermediate)
-- - 81-717  (St. Petersburg head)
-- - 81-714  (St. Petersburg intermediate)
-- models\metrostroi_train\81-718:
-- - 81-718  (TISU head)
-- - 81-719  (TISU intermediate)
-- models\metrostroi_train\81-720:
-- - 81-720  (Yauza head)
-- - 81-721  (Yauza intermediate)
-- - 81-722  (Yubileyniy head)
-- models\metrostroi_train\81-722:
-- - 81-723  (Yubileyniy intermediate motor)
-- - 81-724  (Yubileyniy intermediate trailer)
--------------------------------------------------------------------------------
include("shared.lua")

-- hide = 2 - главные элементы
-- hide = 0.5 - мелкие кузовные элементы
-- hide = 0.8 - кабинные\салонные элемнеты, которые видны из кабины другого поезда
-- hide = 1.5  - кабинные\салонные элемнеты, которые видны вдали из кабины другого поезда
-- hideseat = 0.2 - мелкие кабинные элементы(кнопки, тумблера, лампы)

ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.AutoAnimNames = {}
ENT.ClientSounds = {}
ENT.ClientProps["pult1"] = {
    model = "models/metrostroi_train/81-502/controller_b.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
}
ENT.ClientProps["pult2"] = {
    model = "models/metrostroi_train/81-502/controller_a.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
}
ENT.ClientProps["panel1"] = {
    model = "models/metrostroi_train/81-502/panel_a.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0)
}
ENT.ClientProps["panel2"] = {
    model = "models/metrostroi_train/81-502/panel_b.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0)
}
ENT.ClientProps["panel1_04"] = {
    model = "models/metrostroi_train/81-502/indicators/ars_nch.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
}
ENT.ClientProps["panel1_0"] = {
    model = "models/metrostroi_train/81-502/indicators/ars_0.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
}
ENT.ClientProps["panel1_40"] = {
    model = "models/metrostroi_train/81-502/indicators/ars_40.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
}
ENT.ClientProps["panel1_60"] = {
    model = "models/metrostroi_train/81-502/indicators/ars_60.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
}
ENT.ClientProps["panel1_70"] = {
    model = "models/metrostroi_train/81-502/indicators/ars_70.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
}
ENT.ClientProps["panel1_80"] = {
    model = "models/metrostroi_train/81-502/indicators/ars_80.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
}

ENT.ClientProps["panel2_04"] = {
    model = "models/metrostroi_train/81-502/indicators/indicator_nch.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
}
ENT.ClientProps["panel2_0"] = {
    model = "models/metrostroi_train/81-502/indicators/indicator_0.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
}
ENT.ClientProps["panel2_40"] = {
    model = "models/metrostroi_train/81-502/indicators/indicator_40.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
}
ENT.ClientProps["panel2_60"] = {
    model = "models/metrostroi_train/81-502/indicators/indicator_60.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
}
ENT.ClientProps["panel2_70"] = {
    model = "models/metrostroi_train/81-502/indicators/indicator_70.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
}
ENT.ClientProps["panel2_80"] = {
    model = "models/metrostroi_train/81-502/indicators/indicator_80.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(200,200,200),
}
ENT.ClientProps["Ema_salon2"] = {
    model = "models/metrostroi_train/81-508/81-508_underwagon.mdl",
    pos = Vector(0,1,-18),
    ang = Angle(0,0,0),
    hide = 2.0
}
ENT.ClientProps["osp_label"] = {
	model = "models/metrostroi_train/81-717/labels/label_spb1.mdl",
	pos = Vector(381.722321,-42.139999,36.999210),
	ang = Angle(0.000000,0.000000,0.000000),
	hide = 1.0
}



--Lamps
ENT.ButtonMap["Lamps1_1"] = {
    pos = Vector(462.08+1.35,-21+2.9,21.5),
    ang = Angle(0,180,90),
    width = 24,
    height = 310,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "!LLampAutodrive", x=12, y=16, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_w_502.mdl",z = 0,color = Color(255,180,160) ,var="CPS_AV",
            lcolor = Color(255,180,160),lz = 20,lbright=1.5,lfov=100,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.1,size=0.25,scale=0.09,color=Color(255,180,160),z=3,}
        }},
        {ID = "!LLamp2", x=12, y=16 + 38.9*1, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_w_502.mdl",z = 0,color = Color(255,150,110),var="CPS_2",
            lcolor = Color(255,150,110),lz = 20,lbright=1.5,lfov=100,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.1,size=0.25,scale=0.09,color=Color(255,150,110),z=3,}
        }},
        {ID = "!LLamp1", x=12, y=16 + 38.9*2, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_w_502.mdl",z = 0,color = Color(105,217,115),var="CPS_1",
            lcolor = Color(105,217,115),lz = 20,lbright=1.5,lfov=100,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.1,size=0.25,scale=0.09,color=Color(105,217,115),z=3,}
        }},
        {ID = "!LLamp6", x=12, y=16 + 38.9*3, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_w_502.mdl",z = 0,color = Color(255,150,110),var="CPS_6",
            lcolor = Color(255,150,110),lz = 20,lbright=1.5,lfov=100,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.1,size=0.25,scale=0.09,color=Color(255,150,110),z=3,}
        }},
        {ID = "!LDoorsWag", x=12, y=16 + 38.9*4, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_w_502.mdl",z = 0,color = Color(80,150,255) ,var="DoorsWC",
            lcolor = Color(80,150,255),lz = 20,lbright=1.5,lfov=100,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.1,size=0.25,scale=0.09,color=Color(80,150,255),z=3,}
        }},
        {ID = "!LDoors", x=12, y=16 + 38.9*5, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_w_502.mdl",z = 0,color = Color(255,180,160),var="CPS_SD",
            lcolor = Color(255,180,160),lz = 20,lbright=1.5,lfov=100,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.1,size=0.25,scale=0.09,color=Color(255,180,160),z=3,}
        }},
        {ID = "!LGreenRP", x=12, y=16 + 38.9*6, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_w_502.mdl",color = Color(105,217,115),z = 0,var="CPS_RP",
            lcolor = Color(105,217,115),lz = 20,lbright=1.5,lfov=100,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.1,size=0.25,scale=0.09,color=Color(105,217,115),z=3,}
        }},
        {ID = "!LRedRP", x=12, y=16 + 38.9*7, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_w_502.mdl",color = Color(255,100,60) ,z = 0,var="CPS_SN1",getfunc = function(ent,_,_,var) return ent:GetPackedRatio(var) end,
            lcolor = Color(255,100,60) ,lz = 20,lbright=1.5,lfov=100,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.1,size=0.25,scale=0.09,color=Color(255,100,60),z=3, }
        }},
    }
}
ENT.ButtonMap["Lamps1_2"] = {
    pos = Vector(462.08,-21,21.5),
    ang = Angle(0,0,90),
    width = 24,
    height = 310,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "!RLampAutodrive", x=12, y=16, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_w_502.mdl",z = 0,color = Color(255,180,160) ,var="CPS_AV",
            lcolor = Color(255,180,160),lz = 20,lbright=1.5,lfov=100,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.1,size=0.25,scale=0.09,color=Color(255,180,160),z=3,}
        }},
        {ID = "!RLamp2", x=12, y=16 + 38.9*1, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_w_502.mdl",z = 0,color = Color(255,150,110),var="CPS_2",
            lcolor = Color(255,150,110),lz = 20,lbright=1.5,lfov=100,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.1,size=0.25,scale=0.09,color=Color(255,150,110),z=3,}
        }},
        {ID = "!RLamp1", x=12, y=16 + 38.9*2, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_w_502.mdl",z = 0,color = Color(105,217,115),var="CPS_1",
            lcolor = Color(105,217,115),lz = 20,lbright=1.5,lfov=100,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.1,size=0.25,scale=0.09,color=Color(105,217,115),z=3,}
        }},
        {ID = "!RLamp6", x=12, y=16 + 38.9*3, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_w_502.mdl",z = 0,color = Color(255,150,110) ,var="CPS_6",
            lcolor = Color(255,150,110),lz = 20,lbright=1.5,lfov=100,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.1,size=0.25,scale=0.09,color=Color(255,150,110),z=3,}
        }},
        {ID = "!RDoorsWag", x=12, y=16 + 38.9*4, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_w_502.mdl",z = 0,color = Color(80,150,255) ,var="DoorsWC",
            lcolor = Color(80,150,255),lz = 20,lbright=1.5,lfov=100,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.1,size=0.25,scale=0.09,color=Color(80,150,255),z=3,}
        }},
        {ID = "!RDoors", x=12, y=16 + 38.9*5, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_w_502.mdl",z = 0,color = Color(255,180,160),var="CPS_SD",
            lcolor = Color(255,180,160),lz = 20,lbright=1.5,lfov=100,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.1,size=0.25,scale=0.09,color=Color(255,180,160),z=3,}
        }},
        {ID = "!RGreenRP", x=12, y=16 + 38.9*6, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_w_502.mdl",z = 0,color = Color(105,217,115),var="CPS_RP",
            lcolor = Color(105,217,115),lz = 20,lbright=1.5,lfov=100,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.1,size=0.25,scale=0.09,color=Color(105,217,115),z=3,}
        }},
        {ID = "!RRedRP", x=12, y=16 + 38.9*7, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_w_502.mdl",z = 0,color = Color(255,100,60) ,var="CPS_SN1",getfunc = function(ent,_,_,var) return ent:GetPackedRatio(var) end,
            lcolor = Color(255,100,60),lz = 20,lbright=1.5,lfov=100,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.1,size=0.25,scale=0.09,color=Color(255,100,60),z=3, }
        }},
    }
}
ENT.ButtonMap["Lamps2_1"] = {
    pos = Vector(461.5,-20,10.5),
    ang = Angle(0,-90+14.315,90),
    width = 80,
    height = 150,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {

        {ID = "!CPS_KS",x=19.2+5.9, y=36.8+24.75*-1+2.2, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",z = -3,color = Color(105,217,115), var="CPS_KS"},
            sprite = {bright=0.2,size=0.25,scale=0.015,color=Color(105,217,115),z=0,}
        }},
        {ID = "!CPS_AV",x=19.2+23.8*2-6.2, y=36.8+24.75*-1+2.2, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",z = -3,color = Color(105,217,115), var="CPS_AV"},
            sprite = {bright=0.2,size=0.25,scale=0.015,color=Color(105,217,115),z=0,}
        }},
        {ID = "!CPS_4", x=19.2+23.8*0, y=36.8+24.75*0, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",z = -4,color = Color(255,50,45), var="CPS_4",},
            sprite = {bright=0.2,size=0.25,scale=0.03,color=Color(255,50,45),z=3,}
        }},
        {ID = "!CPS_5", x=19.2+23.8*1, y=36.8+24.75*0, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",z = -4,color = Color(105,217,115), var="CPS_5",},
            sprite = {bright=0.2,size=0.25,scale=0.03,color=Color(105,217,115),z=3,}
        }},
        {ID = "!CPS_DT",x=19.2+23.8*2, y=36.8+24.75*0, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",z = -4,color = Color(255,180,100), var="CPS_DT",},
            sprite = {bright=0.2,size=0.25,scale=0.03,color=Color(255,180,100),z=3,}
        }},

        {ID = "!CPS_1", x=19.2+23.8*0, y=36.8+24.75*1, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",z = -4,color = Color(105,217,115), var="CPS_1",},
            sprite = {bright=0.2,size=0.25,scale=0.03,color=Color(105,217,115),z=3,}
        }},
        {ID = "!CPS_20",x=19.2+23.8*1, y=36.8+24.75*1, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",z = -4,color = Color(105,217,115), var="CPS_20",},
            sprite = {bright=0.2,size=0.25,scale=0.03,color=Color(105,217,115),z=3,}
        }},
        {ID = "!CPS_6", x=19.2+23.8*2, y=36.8+24.75*1, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",z = -4,color = Color(255,180,100), var="CPS_6",},
            sprite = {bright=0.2,size=0.25,scale=0.03,color=Color(255,180,100),z=3,}
        }},

        {ID = "!CPS_2", x=19.2+23.8*1, y=36.8+24.75*2, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",z = -4,color = Color(255,180,100), var="CPS_2",},
            sprite = {bright=0.2,size=0.25,scale=0.03,color=Color(255,180,100),z=3,}
        }},
        {ID = "!CPS_1P",x=19.2+23.8*2, y=36.8+24.75*2, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",z = -4,color = Color(255,180,100), var="CPS_1P",},
            sprite = {bright=0.2,size=0.25,scale=0.03,color=Color(255,180,100),z=3,}
        }},


        {ID = "!CPS_SN1",x=19.2+23.8*0-4.1, y=36.8+24.75*3, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",z = -3,color = Color(255,50,45), var="CPS_SN1",getfunc = function(ent,_,_,var) return ent:GetPackedRatio(var) end},
            sprite = {bright=0.2,size=0.25,scale=0.015,color=Color(255,50,45),z=0,}
        }},
        {ID = "!CPS_SN2",x=19.2+23.8*0+3.7, y=36.8+24.75*3, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",z = -3,color = Color(255,50,45), var="CPS_SN2"},
            sprite = {bright=0.2,size=0.25,scale=0.015,color=Color(255,50,45),z=0,}
        }},
        {ID = "!CPS_3", x=19.2+23.8*1, y=36.8+24.75*3, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",z = -4,color = Color(255,180,100), var="CPS_3",},
            sprite = {bright=0.2,size=0.25,scale=0.03,color=Color(255,180,100),z=3,}
        }},
        {ID = "!CPS_SD1",x=19.2+23.8*2-4.1, y=36.8+24.75*3, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",z = -3,color = Color(80,140,255), var="CPS_SD"},
            sprite = {bright=0.2,size=0.25,scale=0.015,color=Color(80,140,255),z=0,}
        }},
        {ID = "!CPS_SD2",x=19.2+23.8*2+3.7, y=36.8+24.75*3, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",z = -3,color = Color(80,140,255), var="CPS_SD"},
            sprite = {bright=0.2,size=0.25,scale=0.015,color=Color(80,140,255),z=0,}
        }},


        {ID = "!CPS_RP", x=19.2+23.8*0, y=36.8+24.75*4, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",z = -4,color = Color(105,217,115), var="CPS_RP",},
            sprite = {bright=0.2,size=0.25,scale=0.015,color=Color(105,217,115),z=3,}
        }},
        {ID = "!CPS_DV", x=19.2+23.8*2, y=36.8+24.75*4, radius=10, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",z = -4,color = Color(255,50,45), var="CPS_DV",},
            sprite = {bright=0.2,size=0.25,scale=0.015,color=Color(255,50,45),z=3,}
        }},
    }
}

local function addTW10Cosume(panelName,ignores)
    for _,button in pairs(ENT.ButtonMap[panelName].buttons) do
        if not button.model or not button.model.lamp then continue end
        if not table.HasValue(ignores or {},button.ID) then
            local rand1 = 0.1
            local rand2 = math.Rand(0.5,3.5)
            if button.model.lamp.getfunc then
                local oldgetfunc = button.model.lamp.getfunc
                button.model.lamp.getfunc = function(ent,vmin,vmax,var)
                    return (rand1+ent:GetPackedRatio("LampsCount")^rand2)*oldgetfunc(ent,vmin,vmax,var)
                end
            else
                button.model.lamp.getfunc = function(ent,_,_,var) return ent:GetPackedBool(var) and rand1+ent:GetPackedRatio("LampsCount")^rand2 or 0 end
            end
        end

    end
end

local strength = {
    [0] = 0.86,
    [1] = 0.29,
    [2] = 0.71,
    [3] = 0.71,
    [4] = 0.57,
    [5] = 0.71,
    [6] = 0.86,
    [7] = 0.43,
    [8] = 1.00,
    [9] = 0.86,
}
ENT.ButtonMap["Lamps2_2"] = {
    pos = Vector(461.5-0.9,-15,10.5+8),
    ang = Angle(0,-90+14.315,90),
    width = 160,
    height = 120,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "!Speedometer1",  x=90,y=18,w=19,h=29,tooltip="", model = {
            name="SSpeed2",model = "models/metrostroi_train/81-502/indicators/indicators.mdl", color=Color(175,250,20),skin=0,z=-1,ang=Angle(0,0,90),
            tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.Speed"),ent:GetPackedRatio("CPS_Speed")*100) end,
            sprite = {bright=0.1,size=.5,scale=0.055,vscale=0.065,z=1,color=Color(225,250,20),getfunc= function(ent)
                if not ent:GetPackedBool("LUDS") then return 0 end
                return strength[math.floor(ent:GetNW2Int("ALSSpeed")*0.1)%10]
            end}
        }},
        {ID = "!Speedometer2",  x=113,y=18,w=19,h=29,tooltip="", model = {
            name="SSpeed1",model = "models/metrostroi_train/81-502/indicators/indicators.mdl", color=Color(175,250,20),skin=0,z=-1,ang=Angle(0,0,90),
            tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.Speed"),ent:GetPackedRatio("CPS_Speed")*100) end,
            sprite = {bright=0.1,size=.5,scale=0.055,vscale=0.065,z=1,color=Color(225,250,20),getfunc= function(ent)
                if not ent:GetPackedBool("LUDS") then return 0 end
                return strength[math.floor(ent:GetNW2Int("ALSSpeed"))%10]
            end}
        }},
        {ID = "!CPS_Pd",x=64, y=85, radius=5, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",z = -2,color = Color(255,50,45), var="CPS_Pd"},
            sprite = {bright=0.4,size=0.25,scale=0.015,color=Color(255,50,45),z=0,}
        }},

        {ID = "!ALS_04",x=29, y=91, w=13,h=13, tooltip="", model = {
            sprite = {bright=0.1,size=0.25,scale=0.04,color=Color(255, 77, 97),z=0,lamp = "light_04", hidden = "panel2_04"},
        }},
        {ID = "!ALS_00",x=60+18.5*0, y=91, w=13,h=13, tooltip="", model = {
            sprite = {bright=0.1,size=0.25,scale=0.04,color=Color(255, 77, 97),z=0,lamp = "light_0", hidden = "panel2_0"},
        }},
        {ID = "!ALS_40",x=60+18.5*1, y=91, w=13,h=13, tooltip="", model = {
            sprite = {bright=0.1,size=0.25,scale=0.04,color=Color(255, 255, 134),z=0,lamp = "light_40", hidden = "panel2_40"},
        }},
        {ID = "!ALS_60",x=60+18.5*2, y=91, w=13,h=13, tooltip="", model = {
            sprite = {bright=0.1,size=0.25,scale=0.04,color=Color(94, 255, 213),z=0,lamp = "light_60", hidden = "panel2_60"},
        }},
        {ID = "!ALS_70",x=60+18.5*3, y=91, w=13,h=13, tooltip="", model = {
            sprite = {bright=0.1,size=0.25,scale=0.04,color=Color(94, 255, 213),z=0,lamp = "light_70", hidden = "panel2_70"},
        }},
        {ID = "!ALS_80",x=60+18.5*4, y=91, w=13,h=13, tooltip="", model = {
            sprite = {bright=0.1,size=0.25,scale=0.04,color=Color(94, 255, 213),z=0,lamp = "light_80", hidden = "panel2_80"},
        }},
    }
}

ENT.ButtonMap["PanelLamp"] = {
    pos = Vector(453.7,-57.31,42),
    ang = Angle(180,275,-5),
    width = 100,
    height = 200,
    scale = 0.0588,

    buttons = {
        {ID = "PanelLampToggle", x=0, y=0, w=100, h=200, tooltip="",var="PanelLights"},
    }
}

-- Main panel
ENT.ButtonMap["Main1_2"] = {
    pos = Vector(464.1,-36.3,-3.5),
    ang = Angle(0,-97,90),
    width = 110,
    height = 30,
    scale = 0.0588,
    hideseat = 0.2,

    buttons = {
        {ID = "!LMK2", x=56, y=14, radius=15, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",z = -7,color = Color(255,180,100),  var="LMK"  },
            sprite = {bright=0.2,size=0.25,scale=0.04,color=Color(255,180,100),z=2,}
        }},
        {ID = "!LVRD2", x=93, y=14, radius=15, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",z = -7,color = Color(105,217,115),  var="CPS_Pd"},
            sprite = {bright=0.2,size=0.25,scale=0.04,color=Color(105,217,115),z=2,}
        }},
    }
}
ENT.ButtonMap["BPS"] = {
    pos = Vector(451.5,-58.08,31.39),
    ang = Angle(0,-130,90),
    width = 30,
    height = 110,
    scale = 0.0588,
    hideseat = 0.2,

    buttons = {
        {ID = "!BPSon", x=14, y=19, radius=15, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",z = -7,color = Color(105,217,115), var="BPSon"},
            sprite = {bright=0.2,size=0.25,scale=0.04,color=Color(105,217,115),z=2,}
        }},
        {ID = "!BPSErr", x=14, y=57, radius=15, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",z = -7,color = Color(255,180,100), var="BPSErr"},
            sprite = {bright=0.2,size=0.25,scale=0.04,color=Color(255,180,100),z=2,}
        }},
        {ID = "!BPSFail", x=14, y=95, radius=15, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",z = -7,color = Color(255,50,45), var="BPSFail"},
            sprite = {bright=0.2,size=0.25,scale=0.04,color=Color(255,50,45),z=2,}
        }},
    }
}
ENT.ButtonMap["NMnUAVA"] = {
    pos = Vector(453.7,-57.31,10.5),
    ang = Angle(0,-126,90),
    width = 40,
    height = 70,
    scale = 0.0588,
    hideseat = 0.2,

    buttons = {
        {ID = "!NMPressureLow", x=20, y=7, radius=8, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",z = -3.8,color = Color(255,50,45), var="NMLow"},
            sprite = {bright=0.5,size=0.25,scale=0.015,color=Color(255,50,45),z=0,}
        }},
        {ID = "!UAVATriggered", x=20, y=34, radius=8, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",z = -3.8,color = Color(255,50,45), var="UAVATriggered"},
            sprite = {bright=0.5,size=0.25,scale=0.015,color=Color(255,50,45),z=0,}
        }},
    }
}
ENT.ButtonMap["Main1"] = {
    pos = Vector(457.6,-32,-8.0),
    ang = Angle(0,-90,70),
    width = 260,
    height = 200,
    scale = 0.0588,
    hideseat = 0.2,

    buttons = {
        {ID = "2:VUSToggle", x=28.5, y=31.5, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-1.5,
            var="VUS",speed=16,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "2:HeadlightsToggle", x=62.5, y=31.5, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-1.5,
            var="Headlights",speed=16,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},

        {ID = "!LKTLight",      x=128.3, y=19.3, radius=20, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_w_502.mdl",z = 5,color = Color(240,200,160), var="CPS_DT" ,
            lcolor=Color(255,170,140),lz = 20,lbright=1.5,lfov=110,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.2,size=0.25,scale=0.06,color=Color(255,170,140),z=6,}
        }},
        {ID = "!LKVDLight",     x=128.3, y=45, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl", ignorepanel = true, skin = 2, z = -10,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=63,x=-0.3,y=-0.3,z=22.0,var="LKVD",color=Color(255,1,50)},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(255,1,50)},
        }},


        {ID = "2:ARSToggle", x=161.4, y=31.5, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-1.5,
            var="ARS",speed=16,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "2:ALSToggle", x=197.3, y=31.5, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-1.5,
            var="ALS",speed=16,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "2:KBSet", x=234, y=31.5, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="KB",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},

        {ID = "2:KDLSet", x=30+40*0, y=94, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="KDL",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "2:LOnSet", x=30+40*1, y=94, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="LOn",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "2:LOffSet", x=30+40*2, y=94, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="LOff",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "2:VozvratRPSet", x=30+40*3, y=94, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="VozvratRP",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "2:KSNSet", x=30+40*4, y=94, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="KSN",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "2:KDPSet", x=30+40*5, y=94, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="KDP",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},


        {ID = "2:VMKToggle",x=40,y=155-5,radius=20, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudwhite.mdl", z=-30,
            var="VMK",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "2:KRZDSet", x=40+44.75*1, y=155, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="KRZD",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "2:RingSet", x=40+44.75*2, y=155, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="Ring",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "2:VAKSet", x=40+44.75*3, y=155, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="VAK",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "2:VUDToggle",x=219,y=155-5,radius=20, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudwhite.mdl", z=-30,
            var="VUD",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Unlocked","Train.Buttons.Locked"},
        }},
    }
}

-- Main panel
ENT.ButtonMap["Main2"] = {
    pos = Vector(457.6,-32,-8.0),
    ang = Angle(0,-90,70),
    width = 260,
    height = 200,
    scale = 0.0588,
    hideseat = 0.2,

    buttons = {
        {ID = "KOSSet", x=30, y=40, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-502/buttons/button_big_1.mdl",ang = 180,z=14,
            var="KOS",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "!LMK", x=30+37, y=40-3.3, radius=20, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_g_502.mdl",z = 3.8,color = Color(255,255,255),  var="LMK",
            lcolor=Color(20,255,50),lz = 20,lbright=0.5,lfov=110,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.2,size=0.25,scale=0.06,color=Color(20,255,50),z=6,}
        }},
        {ID = "VZPToggle", x=30+40*2, y=40-3.3, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=1,
            var="VZP",speed=16,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "VZDSet", x=30+40*3, y=40-3.3, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="VZD",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "!L16", x=30+40*4+6.3, y=40-3.3, radius=20, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_g_502.mdl",z = 3.8,color = Color(255,255,255), var="L16",
            lcolor=Color(20,255,50),lz = 20,lbright=0.5,lfov=110,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.2,size=0.25,scale=0.06,color=Color(20,255,50),z=6,}
        }},
        {ID = "KRZDSet", x=30+40*5, y=40-3.3, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="KRZD",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},

        {ID = "KDLSet", x=30+40*0, y=98, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="KDL",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "LOnSet", x=30+40*1, y=98, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="LOn",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "LOffSet", x=30+40*2, y=98, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="LOff",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VozvratRPSet", x=30+40*3, y=98, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="VozvratRP",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KSNSet", x=30+40*4, y=98, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="KSN",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KDPSet", x=30+40*5, y=98, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="KDP",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KDPKToggle", x=30+40*5+12, y=98-33-2, radius=15, tooltip="", model = {
            model = "models/metrostroi_train/81-703/cabin_doors_cover.mdl",ang = 180-20,z=11,vmin=0,vmax=0.25,
            var="KDPK",speed=2,disableinv="KDPSet",
            sndvol = 0.10, snd = function(val) return val and "kr_left" or "kr_right" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},


        {ID = "VMKToggle",x=30-1.5,y=155-5,radius=20, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudwhite.mdl", z=-30,
            var="VMK",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "!RU", x=30+40*1-3, y=155.5, radius=20, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_w_502.mdl",z = 4.6,color = Color(240,200,160), var="LRU" },
            sprite = {bright=0.2,size=0.25,scale=0.06,color=Color(240,200,160),z=6,}
        }},
        {ID = "RingSet", x=30+40*2-7, y=155, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="Ring",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VUSToggle", x=30+40*3-16, y=155, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_b_a.mdl",ang = 180,z=1,
            var="VUS",speed=16,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "VAKSet", x=30+40*3+15, y=155, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",ang = 180-30,z=0,vmin=1,vmax=0,
            var="VAK",speed=16,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "AutodriveToggle", x=30+40*4+9, y=155, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_b_a.mdl",ang = 180,z=1,
            var="Autodrive",speed=16,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "VUDToggle",x=30+40*5+2,y=155-5,radius=20, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudwhite.mdl", z=-30,
            var="VUD",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Unlocked","Train.Buttons.Locked"},
        }},
    }
}

addTW10Cosume("Lamps1_1")
addTW10Cosume("Lamps1_2")
addTW10Cosume("Lamps2_1")
addTW10Cosume("Main1")
addTW10Cosume("Main2")

-- AV panel
ENT.ButtonMap["AV"] = {
    pos = Vector(403.5,-58.2,27.5),
    ang = Angle(0,90,90),
    width = 85*7,
    height = 120,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "VRUToggle",x=85*0,y=0,w=85,h=120 , tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=12,ang=90,z=20.9,x=0,y=-12.5}},
            plomb = {model = "models/metrostroi_train/equipment/vu_plomb_right.mdl",ang=Angle(-90,90,0),x=25,y=33,z=7,var="VRUPl", ID="VRUPl",},
            var="VRU",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "KAHToggle",x=85*1,y=0,w=85,h=120 , tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=7,ang=90,z=20.9,x=0,y=-12.5}},
            plomb = {model = "models/metrostroi_train/equipment/vu_plomb_right.mdl",ang=Angle(-90,90,0),x=25,y=33,z=7,var="KAHPl", ID="KAHPl",},
            var="KAH",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "KADToggle",x=85*2,y=0,w=85,h=120 , tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=8,ang=90,z=20.9,x=0,y=-12.5}},
            plomb = {model = "models/metrostroi_train/equipment/vu_plomb_right.mdl",ang=Angle(-90,90,0),x=25,y=33.2,z=9.3,var="KADPl", ID="KADPl",},
            var="KAD",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "OVTToggle",x=85*3,y=0,w=85,h=120 , tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=6,ang=90,z=20.9,x=0,y=-12.5}},
            plomb = {model = "models/metrostroi_train/equipment/vu_plomb_left.mdl",ang=Angle(-90,90,0),x=-8,y=33.7,z=9.3,var="OVTPl", ID="OVTPl",},
            var="OVT",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "KSDToggle",x=85*4,y=0,w=85,h=120 , tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=9,ang=90,z=20.9,x=0,y=-12.5}},
            var="KSD",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "KPVUToggle",x=85*5,y=0,w=85,h=120 , tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=10,ang=90,z=20.9,x=0,y=-12.5}},
            plomb = {model = "models/metrostroi_train/equipment/vu_plomb_right.mdl",ang=Angle(-90,90,0),x=25,y=33.2,z=9.3,var="KPVUPl", ID="KPVUPl",},
            var="KPVU",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "VKFToggle",x=85*6,y=0,w=85,h=120 , tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=5,ang=90,z=20.9,x=0,y=-12.5}},
            var="VKF",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}
--VU Panel
ENT.ButtonMap["VU"] = {
    pos = Vector(466,-16,32),
    ang = Angle(0,270,90),
    width = 100,
    height = 110,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "VUToggle", x=0, y=0, w=100, h=110, tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            var="VU",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}

ENT.ButtonMap["Stopkran"] = {
    pos = Vector(463,28.5,5),
    ang = Angle(0,-90,90),
    width = 200,
    height = 1300,
    scale = 0.1/2,
        buttons = {
            {ID = "EmergencyBrakeValveToggle",x=0, y=0, w=200, h=1300, tooltip="", tooltip="",tooltip="",states={"Train.Buttons.Closed","Train.Buttons.Opened"},var="EmergencyBrakeValve"},
    }
}
ENT.ClientProps["stopkran"] = {
    model = "models/metrostroi_train/81-717/stop_spb.mdl",
    pos = Vector(464.5-0.1,24.4,-3),
    ang = Angle(0,270,0),
    hide = 0.8,
}
ENT.ClientSounds["EmergencyBrakeValve"] = {{"stopkran",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}


ENT.ButtonMap["AVMain"] = {
    pos = Vector(402.3,38.8-1,36.3),
    ang = Angle(0,90,90),
    width = 335,
    height = 380,
    scale = 0.0625,
    hide=0.8,

    buttons = {
            {ID = "AVToggle", x=0, y=0, w=300, h=380, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_av8r.mdl", z=80, ang = Angle(90,0,0),
            var="AV",speed=0.85, vmin=0.73,vmax=0.80,
            sndvol = 1, snd = function(val) return val and "av8_on" or "av8_off" end,
        }},
    }
}


ENT.ButtonMap["VRD"] = {
    pos = Vector(403.1,-30.7,3),
    ang = Angle(0,90,90),
    width = 80,
    height = 105,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "VRDToggle", x=0, y=0, w=80,h=105, tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=2,ang=90,z=20.9,x=0,y=-12.5},},
            var="VRD",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}
ENT.ButtonMap["VRD2"] = {
    pos = Vector(403.1,-29.58,3.635),
    ang = Angle(0,90,90),
    width = 40,
    height = 80,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "2:VRDSet",           x=20, y=20, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl", z = 0,
            var="VRD",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button1_on" or "button2_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "!LVRD", x=20, y=60, radius=20, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/lamp_g_502.mdl",z = 3.5,color = Color(255,255,255),var="LVRD",
            lcolor=Color(20,255,50),lz = 20,lbright=1.5,lfov=110,lfar=16,lnear=8,lshadows=0},
            sprite = {bright=0.2,size=0.25,scale=0.06,color=Color(20,255,50),z=6,}
        }},
    }
}

ENT.ButtonMap["VBA"] = {
    pos = Vector(403.5,-45.7,6),
    ang = Angle(0,90,90),
    width = 250,
    height = 140,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "VBAToggle", x=0, y=0, w=250, h=140, tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black_2.mdl", z=15, ang=Angle(90,0,180),
            labels={
                {model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=1,ang=90,z=20.9,x=-50,y=-12.5},
                {model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=1,ang=90,z=20.9,x=50,y=-12.5},
            },
            var="VBA",speed=6,vmin=1,vmax=0,
            sndvol = 1, snd = function(val) return val and "vu223_on" or "vu223_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}
---AV1 Panel
ENT.ButtonMap["AV1"] = {
    pos = Vector(403.5,39.2,18),
    ang = Angle(0,90,90),
    width = 320,
    height = 140,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "VU3Toggle", x=0, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            var="VU3",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "VU2Toggle", x=110, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            var="VU2",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "VU1Toggle", x=220, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            var="VU1",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}

ENT.ButtonMap["AV2"] = {
    pos = Vector(403.5,23.2,32.4),
    ang = Angle(0,90,90),
    width = 210,
    height = 136,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "VSOSDToggle", x=0, y=0, w=100, h=136, tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=14,ang=90,z=20.9,x=0,y=-12.5}},
            var="VSOSD",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "VRToggle", x=110, y=0, w=100, h=136, tooltip="", model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=4,ang=90,z=20.9,x=0,y=-12.5}},
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=24,z=0,var="VRPl", ID="VRPl",},
            var="VR",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}

ENT.ButtonMap["UPO"] = {
    pos = Vector(403.5,30,23),
    ang = Angle(0,90,90),
    width = 20,
    height = 20,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "R_UPOToggle", x=10, y=10, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=-2,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=17,ang=90,z=2.5,x=0,y=-17}},
            var="R_UPO",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}


-- Battery panel
ENT.ButtonMap["Battery"] = {
    pos = Vector(403.5,22,17),
    ang = Angle(0,90,90),
    width = 250,
    height = 140,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "VBToggle", x=0, y=0, w=250, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_black_2.mdl", z=15, ang=Angle(90,0,180),
            labels={
                {model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=3,ang=90,z=20.9,x=-50,y=-12.5},
                {model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=3,ang=90,z=20.9,x=50,y=-12.5},
            },
            var="VB",speed=6,vmin=1,vmax=0,
            sndvol = 1, snd = function(val) return val and "vu223_on" or "vu223_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}

-- Parking brake panel
ENT.ButtonMap["ParkingBrake"] = {
    pos = Vector(457,46,-2.0),
    ang = Angle(0,-83,90),
    width = 340,
    height = 400,
    scale = 0.0625,

    buttons = {
        {ID = "ParkingBrakeLeft",x=0, y=0, w=170, h=400, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.ParkingBrake"),ent:GetPackedRatio("ManualBrake")*100) end},
        {ID = "ParkingBrakeRight",x=170, y=0, w=170, h=400, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.ParkingBrake"),ent:GetPackedRatio("ManualBrake")*100) end},
    }
}

-- Train driver helpers panel
ENT.ButtonMap["HelperPanel"] = {
    pos = Vector(453.6,59.15,24.5),
    ang = Angle(0,-52,90),
    width = 60,
    height = 280,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "VDLSet", x=10, y=32, w=40,h=80, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudwhite.mdl", z=-19, color = Color(255,255,255),
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=9,ang=90,z=18.9,x=0,y=-25.5}},
            var="VDL",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "KDPHSet", x=10, y=142, w=40,h=80, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudwhite.mdl", z=-19, color = Color(255,255,255),
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=11,ang=90,z=18.9,x=0,y=-25.5}},
            var="KDPH",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["BCPressure"] = {
    pos = Vector(461,-50.5,7.6),
    ang = Angle(0,-90-30,90),

    width = 76,
    height = 76,
    scale = 0.0625,

    buttons = {
        {ID = "!BCPressure", x=38,y=38,radius=38,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BCPressure"),ent:GetPackedRatio("BCPressure")*6) end},
    }
}
ENT.ButtonMap["BLTLPressure"] = {
    pos = Vector(458,-54.5,7.6),
    ang = Angle(0,-90-30,90),

    width = 76,
    height = 76,
    scale = 0.0625,

    buttons = {
        {ID = "!BLTLPressure", x=38,y=38,radius=38,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BLTLPressure"),ent:GetPackedRatio("TLPressure")*16,ent:GetPackedRatio("BLPressure")*16) end},
    }
}
ENT.ButtonMap["HVMeters"] = {
    pos = Vector(458.3,-55.4,28.2),
    ang = Angle(0,-115.3,90),

    width = 66,
    height = 152,
    scale = 0.0625,

    buttons = {
        {ID = "!EnginesVoltage", x=0,y=0,w=66,h=72,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesVoltage"),ent:GetPackedRatio("EnginesVoltage")*1000) end},
        {ID = "!EnginesCurrent", x=0,y=79,w=66,h=72,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesCurrent"),ent:GetPackedRatio("EnginesCurrent")*1000-500) end},
    }
}
ENT.ButtonMap["Speedometer"] = {
    pos = Vector(459.1,-53.4,17),
    ang = Angle(0,-115.3,90),

    width = 100,
    height = 85,
    scale = 0.0625,

    buttons = {
        {ID = "!Speedometer", x=0,y=0,w=100,h=85,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.Speed"),ent:GetPackedRatio("Speed")*100) end},
    }
}
ENT.ButtonMap["BatteryVoltage"] = {
    pos = Vector(404,32.6,23.2),
    ang = Angle(0,89,90),
    width = 68,
    height = 74,
    scale = 0.0625,

    buttons = {
        {ID = "!BatteryVoltage", x=0,y=0,w=68,h=74,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BatteryVoltage"),ent:GetPackedRatio("BatteryVoltage")*150) end},
    }
}
ENT.ButtonMap["ALSPanel"] = {
    pos = Vector(449,-57.1,23.3),
    ang = Angle(0,-126,90),

    width = 50,
    height = 250,
    scale = 0.0625,

    buttons = {
        {ID = "!ALS_80", x=25,y=28+39.5*0,radius=25,tooltip="", model = {
            sprite = {bright=0.1,size=0.25,scale=0.07,color=Color(94, 255, 213),z=5,lamp = "light_80", hidden = "panel1_80"},
        }},
        {ID = "!ALS_70", x=25,y=28+39.5*1,radius=25,tooltip="", model = {
            sprite = {bright=0.1,size=0.25,scale=0.07,color=Color(94, 255, 213),z=5,lamp = "light_70", hidden = "panel1_70"},
        }},
        {ID = "!ALS_60", x=25,y=28+39.5*2,radius=25,tooltip="", model = {
            sprite = {bright=0.1,size=0.25,scale=0.07,color=Color(94, 255, 213),z=5,lamp = "light_60", hidden = "panel1_60"},
        }},
        {ID = "!ALS_40", x=25,y=28+39.5*3,radius=25,tooltip="", model = {
            sprite = {bright=0.1,size=0.25,scale=0.07,color=Color(255, 255, 134),z=5,lamp = "light_40", hidden = "panel1_40"},
        }},
        {ID = "!ALS_00", x=25,y=28+39.5*4,radius=25,tooltip="", model = {
            sprite = {bright=0.1,size=0.25,scale=0.07,color=Color(255, 77, 97),z=5,lamp = "light_0", hidden = "panel1_0"},
        }},
        {ID = "!ALS_04", x=25,y=28+39.5*5,radius=25,tooltip="", model = {
            sprite = {bright=0.1,size=0.25,scale=0.07,color=Color(255, 77, 97),z=5,lamp = "light_04", hidden = "panel1_04"},
        }},
    }
}

ENT.ButtonMap["RCAV5"] = {
    pos = Vector(406.45,-56.75,19.7),
    ang = Angle(0,90,90),
    width = 140,
    height = 250,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "RCAV5Toggle",   x=0, y=0, w=140, h=250, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_sammrc.mdl", ang = Angle(90,180+45,0), z=-20,y=117,
            var="RCAV5",speed=2, vmax=0.3, vmin=0.7,
            plomb = {var="RCAV5Pl", ID="RCAV5Pl",},
            sndvol = 0.5, snd = function(val) return val and "rcav_0-2" or "rcav_2-0" end,
            sndmin = 60, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ClientProps["rcav5_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ButtonMap["RCAV5"].pos+Vector(-1.1,4.35,-15.15),
    ang = Angle(0,270-93,180),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}

ENT.ButtonMap["RCAV3"] = {
    pos = Vector(406.2,-48.7,-4.7),
    ang = Angle(0,90,90),
    width = 140,
    height = 250,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "RCAV3Toggle",   x=0, y=0, w=140, h=250, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_sammrc.mdl", ang = Angle(90,180+45,0), z=-20,y=117,
            var="RCAV3",speed=2, vmax=0.3, vmin=0.7,
            plomb = {var="RCAV3Pl", ID="RCAV3Pl",},
            sndvol = 0.5, snd = function(val) return val and "rcav_0-2" or "rcav_2-0" end,
            sndmin = 60, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ClientProps["rcav3_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ButtonMap["RCAV3"].pos+Vector(-1.1,4.35,-15.15),
    ang = Angle(0,270-93,180),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}


ENT.ButtonMap["RCAV4"] = {
    pos = Vector(406.2,-29.72,-4.7),
    ang = Angle(0,90,90),
    width = 140,
    height = 250,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "RCAV4Toggle",   x=0, y=0, w=140, h=250, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_sammrc.mdl", ang = Angle(90,180+45,0), z=-20,y=117,
            var="RCAV4",speed=2, vmax=0.3, vmin=0.7,
            plomb = {var="RCAV4Pl", ID="RCAV4Pl",},
            sndvol = 0.5, snd = function(val) return val and "rcav_0-2" or "rcav_2-0" end,
            sndmin = 60, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ClientProps["rcav4_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ButtonMap["RCAV4"].pos+Vector(-1.1,4.35,-15.15),
    ang = Angle(0,270-93,180),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}


ENT.ButtonMap["RCARS"] = {
    pos = Vector(406.45,-56.75,19.7),
    ang = Angle(0,90,90),
    width = 140,
    height = 250,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "RCARSToggle",   x=0, y=0, w=140, h=250, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_sammrc.mdl", ang = Angle(90,180+45,0), z=-20,y=117,
            var="RCARS",speed=2, vmax=0.3, vmin=0.7,
            plomb = {var="RCARSPl", ID="RCARSPl",},
            sndvol = 0.5, snd = function(val) return val and "rcav_0-2" or "rcav_2-0" end,
            sndmin = 60, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ClientProps["rcars_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ButtonMap["RCARS"].pos+Vector(-1.1,4.35,-15.15),
    ang = Angle(0,270-93,180),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}


ENT.ButtonMap["RCBPS"] = {
    pos = Vector(406.2,-48.7,-4.7),
    ang = Angle(0,90,90),
    width = 140,
    height = 250,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "RCBPSToggle",   x=0, y=0, w=140, h=250, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_sammrc.mdl", ang = Angle(90,180+45,0), z=-20,y=117,
            var="RCBPS",speed=2, vmax=0.3, vmin=0.7,
            plomb = {var="RCBPSPl", ID="RCBPSPl",},
            sndvol = 0.5, snd = function(val) return val and "rcav_0-2" or "rcav_2-0" end,
            sndmin = 60, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ClientProps["rcbps_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ButtonMap["RCBPS"].pos+Vector(-1.1,4.35,-15.15),
    ang = Angle(0,270-93,180),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}

ENT.ButtonMap["DriverValveBLDisconnect"] = {
    pos = Vector(450.5,-53,-37.61),
    ang = Angle(-90,0,0),
    width = 200,
    height = 90,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveBLDisconnectToggle", x=0, y=0, w=200, h=100, tooltip="", model = {
            var="DriverValveBLDisconnect",sndid="brake_disconnect",
            sndvol = 1, snd = function(val) return "disconnect_valve" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
    }
}
ENT.ButtonMap["DriverValveTLDisconnect"] = {
    pos = Vector(447+5,-47,-31),
    ang = Angle(-90,-10,0),
    width = 200,
    height = 90,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveTLDisconnectToggle", x=0, y=0, w=200, h=90, tooltip="", model = {
            var="DriverValveTLDisconnect",sndid="train_disconnect",
            sndvol = 0.2, snd = function(val) return val and "pneumo_TL_open_background" or "pneumo_TL_disconnect" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
    }
}

ENT.ButtonMap["FrontPneumatic"] = {
    pos = Vector(470,-45.0,-58.0),
    ang = Angle(0,90,90),
    width = 900,
    height = 100,
    scale = 0.1,

    buttons = {
        {ID = "FrontBrakeLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip="",var="FbI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
        {ID = "FrontTrainLineIsolationToggle",x=500, y=0, w=400, h=100, tooltip="",var="FtI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
    }
}
ENT.ClientProps["FrontBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(450+19, -30, -68.5),
    ang = Angle(-15,-90,0),
    hide = 2,
}
ENT.ClientProps["FrontTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(450+19, 30.5, -68.5),
    ang = Angle( 15,-90,0),
    hide = 2,
}
ENT.ClientSounds["FrontBrakeLineIsolation"] = {{"FrontBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["FrontTrainLineIsolation"] = {{"FrontTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ButtonMap["RearPneumatic"] = {
    pos = Vector(-473,45.0,-58.0),
    ang = Angle(0,270,90),
    width = 900,
    height = 100,
    scale = 0.1,

    buttons = {
        {ID = "RearBrakeLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip="",var="RbI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
        {ID = "RearTrainLineIsolationToggle",x=500, y=0, w=400, h=100, tooltip="",var="RtI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
    }
}
ENT.ClientProps["RearTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(-450-21, -30.5, -68.5),
    ang = Angle( 15,90,0),
    hide = 2,
}
ENT.ClientProps["RearBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(-450-21, 30, -68.5),
    ang = Angle(-15,90,0),
    hide = 2,
}
ENT.ClientSounds["RearBrakeLineIsolation"] = {{"RearBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["RearTrainLineIsolation"] = {{"RearTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}


ENT.ButtonMap["GV"] = {
    pos = Vector(170-3,50+20,-60),
    ang = Angle(0,225-15,90),
    width = 260,
    height = 260,
    scale = 0.1,
    buttons = {
        {ID = "GVToggle",x=0, y=0, w= 260,h = 260, tooltip="", model = {
            var="GV",sndid = "gv",
            sndvol = 0.8,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            snd = function(val) return val and "gv_f" or "gv_b" end,
            states={"Train.Buttons.Disconnected","Train.Buttons.On"}
        }},
    }
}
ENT.ClientProps["gv"] = {
    model = "models/metrostroi/81-717/gv.mdl",
    pos = Vector(153.5-3,36+20,-78),
    ang = Angle(-90,90,-90),
    color = Color(150,255,255),
    hide = 0.5,
}
ENT.ClientProps["gv_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["gv"].pos,
    ang = Angle(-90,0,0),
    hide = 0.5,
}

ENT.ButtonMap["AirDistributor"] = {
    pos = Vector(-215,69,-60),
    ang = Angle(0,180,90),
    width = 170,
    height = 260,
    scale = 0.1,
    hideseat=0.1,
    hide=true,
    screenHide = true,

    buttons = {
        {ID = "AirDistributorDisconnectToggle",x=0, y=0, w= 170,h = 260, tooltip="",var="AD",states={"Train.Buttons.On","Train.Buttons.Off"}},
    }
}

-- UAVA
ENT.ButtonMap["UAVAPanel"] = {
    pos = Vector(453,56,-3),
    ang = Angle(0,-70,90),
    width = 180,
    height = 200,
    scale = 0.0625,

    buttons = {
        {ID = "UAVAToggle",x=0, y=0, w=60, h=200, tooltip="", model = {
            plomb = {var="UAVAPl", ID="UAVAPl",},
            var="UAVA",
            sndid="UAVALever",sndvol = 1, snd = function(val) return val and "uava_on" or "uava_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "UAVACToggle",x=60, y=0, w=120, h=200, tooltip="",var="UAVAC",states={"Train.Buttons.UAVAOff","Train.Buttons.UAVAOn"}},
    }
}


for i=0,3 do
    ENT.ClientProps["TrainNumberL"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(295+i*6.6-4*6.6/2,69,-26),
        ang = Angle(180,0,180),
        skin=0,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end
for i=0,3 do
    ENT.ClientProps["TrainNumberR"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(295+i*6.6-4*6.6/2,-66.4,-26),
        ang = Angle(0,0,0),
        skin=0,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end

ENT.ButtonMap["FrontDoor"] = {
    pos = Vector(468,16,43.4),
    ang = Angle(0,-90,90),
    width = 650,
    height = 1780,
    scale = 0.1/2,
    buttons = {
        {ID = "FrontDoor",x=0,y=0,w=642,h=1900, tooltip="", model = {
            var="door1",sndid="door1",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}

ENT.ButtonMap["CabinDoor"] = {
    pos = Vector(417,64,43.4),
    ang = Angle(0,0,90),
    width = 680,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoor",x=0,y=0,w=680,h=2000, tooltip="", model = {
            var="door4",sndid="door4",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}

ENT.ButtonMap["PassengerDoor"] = {
    pos = Vector(384,-16,38),
    ang = Angle(0,90,90),
    width = 700,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=700,h=1900, tooltip="", model = {
            var="door3",sndid="door3",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}

ENT.ButtonMap["PassengerDoor1"] = {
    pos = Vector(384,19,38),
    ang = Angle(0,-90,90),
    width = 700,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=700,h=1900, tooltip=""},
    }
}
ENT.ButtonMap["RearDoor"] = {
    pos = Vector(-470,-16,38),
    ang = Angle(0,90,90),
    width = 700,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=700,h=1900, tooltip="", model = {
            var="door2",sndid="door2",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false
if not ENT.ClientSounds["br_334"] then ENT.ClientSounds["br_334"] = {} end
table.insert(ENT.ClientSounds["br_334"],{"brake",function(ent,_,var) return "br_334_"..var end,1,1,50,1e3,Angle(-90,0,0)})
ENT.ClientProps["brake"] = {
    model = "models/metrostroi_train/81-703/cabin_cran_334.mdl",
    pos = Vector(456.55,-52.55,-4.5),
    ang = Angle(0,-133,0),
    hideseat = 0.2,
}
ENT.ClientProps["controller"] = {
    model = "models/metrostroi_train/81-502/kv_white.mdl",
    pos = Vector(458.00,-23,-6),
    ang = Angle(0,180+5,0),
    hideseat = 0.2,
}

ENT.ClientProps["reverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["controller"].pos+Vector(0,0,-0.8),
    ang = Angle(180,90,180),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientProps["rcureverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["controller"].pos+Vector(-4.5,0.2,-1.5),
    ang = Angle(180,180-25,180),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientProps["brake_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran1.mdl",
    pos = Vector(450,-56.5,-34),
    ang = Angle(0,88,-90),
    hideseat = 0.2,
}
ENT.ClientProps["train_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran3.mdl",
    pos = Vector(453.5,-51.8,-27.33),
    ang = Angle(90,-100,90),
    hideseat = 0.2,
}

ENT.ClientProps["parking_brake"] = {
    model = "models/metrostroi_train/81-703/cabin_parking.mdl",
    pos = Vector(456.8,35,-14.71),
    ang = Angle(-90.00,7,0.00),
    hideseat = 0.2,
}

--------------------------------------------------------------------------------
ENT.ClientProps["train_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(457.091278,-56.829021,5.283177),
    ang = Angle(-88.920425,-32.279652,0.000000),
    hideseat = 0.2,
}

ENT.ClientProps["brake_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_tm.mdl",
    pos = Vector(457.091278,-56.829021,5.283177),
    ang = Angle(-88.920425,-32.279652,0.000000),
    hideseat = 0.2,
}
ENT.ClientProps["brake_cylinder"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(460.119690,-52.755959,5.250632),
    ang = Angle(-90.650009,-29.439659,0.000000),
    hideseat = 0.2,
}

----------------------------------------------------------------
ENT.ClientProps["voltmeter"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(457.766754,-57.440155,25.109106),
    ang = Angle(-90.000000,0.000000,-25.100000),
    hideseat = 0.2,
}
ENT.ClientProps["ampermeter"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(457.750427,-57.475105,20.387020),
    ang = Angle(-90.000000,0.000000,-25.100000),
    hideseat = 0.2,
}

ENT.ClientProps["volt1"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(403.582947,34.760574,20.441202),
    ang = Angle(0.000000,89.500000,90.000000),
    hideseat = 0.2,
}
ENT.ClientProps["speed_o"] = {
    model = "models/metrostroi_train/equipment/arrow_volt2.mdl",
    pos = Vector(458.156189,-56.589546,12.819487),
    ang = Angle(-90.000000,0.000000,-25.100000),
    hideseat = 0.2,
}


ENT.ClientProps["Ema_salon"] = {
    model = "models/metrostroi_train/81-502/ema_salon.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2.0,
}

ENT.ClientProps["bortlamps1"] = {
    model = "models/metrostroi_train/81-502/bort_lamps_body.mdl",
    pos = Vector(414.5,68.5,37),
    ang = Angle(0,0,0),
    hide = 2,
}
ENT.ClientProps["bortlamp1_w"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_b.mdl",
    pos = Vector(414.5,69.4,37+3.25),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamp1_g"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_g.mdl",
    pos = Vector(414.5,69.4,37-0.02),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamp1_y"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_y.mdl",
    pos = Vector(414.5,69.4,37-3.3),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamps2"] = {
    model = "models/metrostroi_train/81-502/bort_lamps_body.mdl",
    pos = Vector(414.5,-65.5,37),
    ang = Angle(0,180,0),
    hide = 2,
}
ENT.ClientProps["bortlamp2_w"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_b.mdl",
    pos = Vector(414.5,-66.4,37+3.25),
    ang = Angle(0,180,0),
    nohide = true,
}
ENT.ClientProps["bortlamp2_g"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_g.mdl",
    pos = Vector(414.5,-66.4,37-0.02),
    ang = Angle(0,180,0),
    nohide = true,
}
ENT.ClientProps["bortlamp2_y"] = {
    model = "models/metrostroi_train/equipment/bort_lamps_y.mdl",
    pos = Vector(414.5,-66.4,37-3.3),
    ang = Angle(0,180,0),
    nohide = true,
}

ENT.ClientProps["Ema_mirrors"] = {
    model = "models/metrostroi_train/81-502/mirrors_ema.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2.0,
}
ENT.ClientProps["Ema_cabine"] = {
    model = "models/metrostroi_train/81-502/ema502_cabine.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2.0,
}
ENT.ClientProps["rvs"] = {
    model = "models/metrostroi_train/81-502/rvc_lamps.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat = 2
}
ENT.ClientProps["sunprotectors"] = {
    model = "models/metrostroi_train/81-502/sun_protectors.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2,
}

ENT.ButtonMap["Route"] = {
    pos = Vector(465.7,37.9,3.5),
    ang = Angle(0,99,90),
    width = 230,
    height = 130,
    scale = 0.0625,
    buttons = {
        {ID = "RouteNumber1+",x=76.5*0,y=0, w=76.5,h=65, tooltip=""},
        {ID = "RouteNumber2+",x=76.5*1,y=0, w=76.5,h=65, tooltip=""},
        {ID = "RouteNumber3+",x=76.5*2,y=0, w=76.5,h=65, tooltip=""},
        {ID = "RouteNumber1-",x=76.5*0,y=65,w=76.5,h=65, tooltip=""},
        {ID = "RouteNumber2-",x=76.5*1,y=65,w=76.5,h=65, tooltip=""},
        {ID = "RouteNumber3-",x=76.5*2,y=65,w=76.5,h=65, tooltip=""},
    }
}
ENT.ClientProps["route"] = {
    model = "models/metrostroi_train/81-502/route/route_holder.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2,
}
ENT.ClientProps["route1"] = {
    model = "models/metrostroi_train/81-502/route/route_number.mdl",
    pos = Vector(465.3,40.16,-0.5),
    ang = Angle(90,189,180),
    skin=2,
    hide = 2,
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
}
ENT.ClientProps["route2"] = {
    model = "models/metrostroi_train/81-502/route/route_number.mdl",
    pos = Vector(464.53,45.03,-0.5),
    ang = Angle(90,189,180),
    skin=2,
    hide = 2,
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
}
ENT.ClientProps["route3"] = {
    model = "models/metrostroi_train/81-502/route/route_number.mdl",
    pos = Vector(463.8,49.72,-0.5),
    ang = Angle(90,189,180),
    skin=8,
    hide = 2,
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
}


ENT.ClientProps["fireextinguisher"] = {
    model = "models/metrostroi_train/81-502/fireextinguisher.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat = 2,
}

ENT.ClientProps["PB"] = {
    model = "models/metrostroi_train/81-720/720_pb.mdl",
    pos = Vector(452, -33, -50.5),
    ang = Angle(0,-90,-45),
    hideseat = 0.2,
}
ENT.ClientSounds["PB"] = {{"PB",function(ent,var) return var > 0 and "pb_on" or "pb_off" end,1,1,50,1e3,Angle(-90,0,0)}}
--[[
ENT.ClientProps["PBPresser1"] = {
    model = "models/props_c17/BriefCase001a.mdl",
    pos = Vector(446.5, -38, -46.5),
    ang = Angle(0,-90,-25),
    scale=0.7,
}
ENT.ClientProps["PBPresser2"] = {
    model = "models/props_c17/BriefCase001a.mdl",
    pos = Vector(408.5, -32, -46.5),
    ang = Angle(0,-90,35),
    scale=0.7,
}--]]

ENT.ClientProps["Lamps_cab1"] = {
    model = "models/metrostroi_train/81-502/cabin_lamp_light.mdl",
    pos = Vector(0,-0.08,-0.2),
    ang = Angle(0,0,0),
    hide = 0.8,
}
ENT.ClientProps["Lamps_pult"] = {
    model = "models/metrostroi_train/equipment/lamp_gauges.mdl",
    pos = Vector(446.027,-55.398,42.27),
    ang = Angle(-4.305,6.175,8),
    hideseat = 0.2,
}
ENT.ClientProps["Lamps_emer1"] = {
    model = "models/metrostroi_train/81-502/lights_emer2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    --color=Color(255,255,255),
    hide = 1.5,
}
ENT.ClientProps["Lamps_emer2"] = {
    model = "models/metrostroi_train/81-502/lights_emer.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    --color=Color(255,255,255),
    hide = 1.5,
}
ENT.ClientProps["Lamps_half1"] = {
    model = "models/metrostroi_train/81-502/lights_group1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["Lamps_half2"] = {
    model = "models/metrostroi_train/81-502/lights_group2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide = true,
}

ENT.ClientProps["tab"] = {
    model = "models/metrostroi_train/Equipment/tab.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    skin = 7,
    hide = 2,
}


--------------------------------------------------------------------------------
-- Add doors
--[=[
local function GetDoorPosition(i,k,j)
    if j == 0
    then return Vector(344.9-0.1*k     - 233.6*i,-63.86*(1-2.02*k),-5.75)
    else return Vector(344.9-0.1*(1-k) - 233.6*i,-63.86*(1-2.02*k),-5.75)
    end
end
for i=0,3 do
    for k=0,1 do
        ENT.ClientProps["door"..i.."x"..k.."a"] = {
            model = "models/metrostroi_train/81-502/81-502_door_right.mdl",
            pos = GetDoorPosition(i,k,0),
            ang = Angle(0,90 + 180*k,0),
            hide = 2.0,
        }
        --[[ ENT.ClientProps["door"..i.."x"..k.."b"] = {
            model = "models/metrostroi_train/81-502/81-502_door_left.mdl",
            pos = GetDoorPosition(i,k,1),
            ang = Angle(0,90 + 180*k,0),
            hide = 2.0,
        }--]]
    end
end--]=]
ENT.ClientProps["door0x1"] = {
    model = "models/metrostroi_train/81-502/81-502_doors_pos1.mdl",
    pos = Vector(344.692,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x1"] = {
    model = "models/metrostroi_train/81-502/81-502_doors_pos2.mdl",
    pos = Vector(110.668,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x1"] = {
    model = "models/metrostroi_train/81-502/81-502_doors_pos3.mdl",
    pos = Vector(-122.718,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x1"] = {
    model = "models/metrostroi_train/81-502/81-502_doors_pos4.mdl",
    pos = Vector(-356.091,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door0x0"] = {
    model = "models/metrostroi_train/81-502/81-502_doors_pos4.mdl",
    pos = Vector(344.692,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x0"] = {
    model = "models/metrostroi_train/81-502/81-502_doors_pos3.mdl",
    pos = Vector(110.668,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x0"] = {
    model = "models/metrostroi_train/81-502/81-502_doors_pos2.mdl",
    pos = Vector(-122.718,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x0"] = {
    model = "models/metrostroi_train/81-502/81-502_doors_pos1.mdl",
    pos = Vector(-356.091,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1"] = {
    model = "models/metrostroi_train/81-502/81-502_door_tor.mdl",
    pos = Vector(460.62+7.4,-14.53,-7.23),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door2"] = {
    model = "models/metrostroi_train/81-502/81-502_door_tor.mdl",
    pos = Vector(-462.6-8,16.53,-7.24),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door3"] = {
    model = "models/metrostroi_train/81-502/81-502_door_interior_b.mdl",
    pos = Vector(382.3,-15,-9.6),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door4"] = {
    model = "models/metrostroi_train/81-502/81-502_door_cab.mdl",
    pos = Vector(411.17+7.6,66.05,-6.38),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["UAVALever"] = {
    model = "models/metrostroi_train/81-703/cabin_uava.mdl",
    pos = Vector(449+8.1,56.0,-9.8),
    ang = Angle(0,-90+10,0),
    hideseat = 0.8,
}

ENT.ClientProps["RedLights"] = {
    model = "models/metrostroi_train/81-703/81-703_red_light.mdl",
    pos = Vector(-23+7.2,1,-191),
    ang = Angle(0,0,0.000000),
    nohide = true
}
ENT.ClientProps["DistantLights"] = {
    model = "models/metrostroi_train/81-703/81-703_projcetor_light.mdl",
    pos = Vector(-23+8.0,1,-191),
    ang = Angle(00.000000,0.000000,0.000000),
    nohide = true
}
ENT.ClientProps["WhiteLights"] = {
    model = "models/metrostroi_train/81-703/81-703_front_light.mdl",
    pos = Vector(-23+7.6,1,-191),
    ang = Angle(0,0,0),
    nohide = true
}



ENT.Lights = {
    [1] = { "headlight",        Vector(475,0,-20), Angle(0,0,0), Color(169,130,88), brightness = 3 ,fov = 90, texture = "models/metrostroi_train/equipment/headlight",shadows = 1,headlight=true},
    [2] = { "headlight",        Vector(465,0,45), Angle(-20,0,0), Color(255,0,0), fov=164 ,brightness = 0.3, farz=250,texture = "models/metrostroi_train/equipment/headlight2",shadows = 0,backlight=true},
    [20] = { "headlight",       Vector( 425,-56,-70),Angle(0,-90,0),Color(255,220,180),brightness = 0.3,distance = 300 ,fov=120,shadows = 1, texture="effects/flashlight/soft", hidden="Ema_salon2" },
    [21] = { "headlight",       Vector(445,-55,40), Angle(75, 70,45), Color(190, 130, 88), fov=125,farz=80,brightness = 1.5,shadows = 1, texture = "models/metrostroi_train/equipment/headlight", hidden="Lamps_pult"},
	[22] = { "headlight",       Vector(440,-60,31), Angle(20, 25,0), Color(200, 140, 98), fov=120,farz=100,brightness = 1,shadows = 1, texture = "models/metrostroi_train/equipment/headlight2", hidden="Lamps_pult"},
     -- Interior
    [9] = { "dynamiclight",    Vector(200, 0, -5), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 200},
    [10] = { "dynamiclight",    Vector(-150, 0, -5), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 200},
    [11] = { "dynamiclight",    Vector( 200, 0, -5), Angle(0,0,0), Color(255,220,180), brightness = 4, distance = 260},
    [12] = { "dynamiclight",    Vector(   0, 0, -5), Angle(0,0,0), Color(255,220,180), brightness = 4, distance = 260},
    [13] = { "dynamiclight",    Vector(-260, 0, -5), Angle(0,0,0), Color(255,220,180), brightness = 4, distance = 260},
    -- Cabin
    [23] = { "dynamiclight",        Vector(425,-10.0,40), Angle(0,0,0), Color(255,255,255), brightness = 0.0003, distance = 300, hidden="Ema_salon2"},


    [15] = { "light",Vector(414.5,69.4,37+3.25), Angle(0,0,0), Color(254,254,254), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [16] = { "light",Vector(414.5,69.4,37-0.02), Angle(0,0,0), Color(40,240,122), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [17] = { "light",Vector(414.5,69.4,37-3.3), Angle(0,0,0), Color(254,210,18), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [18] = { "light",Vector(414.5,-66.4,37+3.25), Angle(0,0,0), Color(254,254,254), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [19] = { "light",Vector(414.5,-66.4,37-0.02), Angle(0,0,0), Color(40,240,122), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },
    [20] = { "light",Vector(414.5,-66.4,37-3.3), Angle(0,0,0), Color(254,210,18), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02", size = 1.5 },

    [5] = { "light",Vector(465+5,-32, 48), Angle(0,0,0), Color(255,50,50),     brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2},
    [6] = { "light",Vector(465+5, 32, 48), Angle(0,0,0), Color(255,50,50),     brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2},
    [30]  = { "light",           Vector(465+5  ,   -45, -37), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2},
    [31]  = { "light",           Vector(465+5  ,   45, -37), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2},
    [32]  = { "light",           Vector(465+5  ,   0, 48), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02", size = 2},

    Lamps_pult = {"light", Vector(446.5,-55.5,42), Angle(0,0,0),Color(255,220,180),brightness = 0.35,scale = 0.4, texture = "sprites/light_glow02", hidden = "Lamps_pult"},
    Lamps_cab = {"light", Vector(404,1.2,56), Angle(0,0,0),Color(255,220,180),brightness = 0.25,scale = 0.3, texture = "sprites/light_glow02", hidden = "Lamps_cab1"},
}

function ENT:Initialize()
    self.BaseClass.Initialize(self)

    self.FrontLeak = 0
    self.RearLeak = 0

    self.CraneRamp = 0
    self.ReleasedPdT = 0
    self.EmergencyValveRamp = 0
    self.EmergencyBrakeValveRamp = 0
end

function ENT:UpdateWagonNumber()
    for i=0,3 do
        local leftNum,rightNum = self.ClientEnts["TrainNumberL"..i],self.ClientEnts["TrainNumberR"..i]
        local num = math.floor(self.WagonNumber%(10^(i+1))/10^i)
        if IsValid(leftNum) then
            leftNum:SetPos(self:LocalToWorld(Vector(295+i*6.6-3*6.6/2,69,-26)))
            leftNum:SetSkin(num)
        end
        if IsValid(rightNum) then
            rightNum:SetPos(self:LocalToWorld(Vector(-280-i*6.6-3*6.6/2,-66.6,-26)))
            rightNum:SetSkin(num)
        end
    end
end

--------------------------------------------------------------------------------
function ENT:Think()
    self.BaseClass.Think(self)
    --self:SetSoundState("horn1",1,1)
    if not self.RenderClientEnts then
        return
    end

    local Lamps = self:GetPackedRatio("LampsStrength")

    local emer1 = self:Animate("lamps_emer1",self:GetPackedBool("Lamps_emer1") and 1 or 0,0,1,5,false)
    local cab = self:Animate("lamps_cab",self:GetPackedBool("Lamps_emer1") and 1 or 0,0,1,5,false)
    local emer2 = self:Animate("lamps_emer2",self:GetPackedBool("Lamps_emer2") and 1 or 0,0,1,5,false)
    local half1 = self:Animate("lamps_half1",self:GetPackedBool("Lamps_half1") and 0.4+Lamps*0.6 or 0,0,1,5,false)
    local half2 = self:Animate("lamps_half2",self:GetPackedBool("Lamps_half2") and 0.4+Lamps*0.6 or 0,0,1,5,false)
    self:ShowHideSmooth("Lamps_emer1",emer1)
    self:ShowHideSmooth("Lamps_cab1",cab)
    self:ShowHideSmooth("Lamps_emer2",emer2)
    self:ShowHideSmooth("Lamps_half1",half1,Color(255,105+half1*150,105+half1*150))
    self:ShowHideSmooth("Lamps_half2",half2,Color(255,105+half2*150,105+half2*150))
    self:SetLightPower(23, cab > 0,cab)
    self:SetLightPower("Lamps_cab", cab > 0,cab)
    if not self:GetPackedBool("Lamps_half1") then
        self:SetLightPower(9,emer1 > 0,emer1*0.2+emer2*0.8)
        self:SetLightPower(10,emer2 > 0,emer2)
        self:SetLightPower(11, false)
        self:SetLightPower(12, false)
        self:SetLightPower(13, false)
    else
        self:SetLightPower(9,false)
        self:SetLightPower(10,false)
        self:SetLightPower(11, half1 > 0, half1*0.1+half2*0.9)
        self:SetLightPower(12, half1 > 0, half1*0.4+half2*0.6)
        self:SetLightPower(13, half1 > 0, half1*0.9+half2*0.1)
    end
    self:SetLightPower(20,self:GetPackedBool("SOSD"))

    -- Parking brake animation
    self.TrueBrakeAngle = self.TrueBrakeAngle or 0
    self.TrueBrakeAngle = self.TrueBrakeAngle + (self:GetPackedRatio("ManualBrake")*360*3.2 - self.TrueBrakeAngle)*2.0*(self.DeltaTime or 0)
    if self.ClientEnts and self.ClientEnts["parking_brake"] then
        self.ClientEnts["parking_brake"]:SetPoseParameter("position",1.0-((self.TrueBrakeAngle % 360)/360))
    end
    local BAsnd = math.floor(self.TrueBrakeAngle/10)
    if self.BrakeAngleSND ~= BAsnd then
        if not IsValid(self.Sounds["parking_brake_rolling"]) or self.Sounds["parking_brake_rolling"]:GetState() ~= GMOD_CHANNEL_PLAYING then
            self:PlayOnce("parking_brake_rolling","bass",1,1)
        end
        self.BrakeAngleSND = BAsnd
    end

    local typ = self:GetNW2Int("EMAType",1)
    if self.Type ~= typ then
        self:ShowHide("pult1",typ == 1)
        self:ShowHide("pult2",typ >= 2)
        self:HidePanel("Main1",typ ~= 1)
        self:HidePanel("Main1_2",typ ~= 1)
        self:HidePanel("BPS",typ ~= 1)
        self:HidePanel("NMnUAVA",typ ~= 1)
        self:HidePanel("Speedometer",typ == 3)
        self:HidePanel("ALSPanel",typ == 3)
        self:HidePanel("VRD",typ ~= 1)
        self:HidePanel("VRD2",typ == 1)
        self:HidePanel("VBA",typ == 1)
        self:HidePanel("Main2",typ < 2)
        self:ShowHide("panel1",typ < 3)
        self:ShowHide("panel2",typ == 3)
        self:ShowHide("panel1_04",typ < 3)
        self:ShowHide("panel1_0",typ < 3)
        self:ShowHide("panel1_40",typ < 3)
        self:ShowHide("panel1_60",typ < 3)
        self:ShowHide("panel1_70",typ < 3)
        self:ShowHide("panel1_80",typ < 3)
        self:ShowHide("panel2_04",typ == 3)
        self:ShowHide("panel2_0",typ == 3)
        self:ShowHide("panel2_40",typ == 3)
        self:ShowHide("panel2_60",typ == 3)
        self:ShowHide("panel2_70",typ == 3)
        self:ShowHide("panel2_80",typ == 3)
        self:HidePanel("Lamps1_1",typ == 3)
        self:HidePanel("Lamps1_2",typ == 3)
        self:HidePanel("Lamps2_1",typ ~= 3)
        self:HidePanel("Lamps2_2",typ ~= 3)
        self:ShowHide("speed_o",typ ~= 3)
        self:HidePanel("RCAV3",typ==1)
        self:HidePanel("RCAV4",typ==1)
        self:HidePanel("RCAV5",typ==1)
        self:HidePanel("RCARS",typ~=1)
        self:HidePanel("RCBPS",typ~=1)
        self:ShowHide("rcars_wrench",typ == 1)
        self:ShowHide("rcbps_wrench",typ == 1)
        self:ShowHide("rcav3_wrench",typ == 1)
        self:ShowHide("rcav4_wrench",typ ~= 1)
        self:ShowHide("rcav5_wrench",typ ~= 1)
    end
    local light_04 = self:Animate("light_04",self:GetPackedBool("ARS_04") and 1 or 0,0,1,5,false)
    local light_0  = self:Animate("light_0" ,self:GetPackedBool("ARS_00") and 1 or 0,0,1,5,false)
    local light_40 = self:Animate("light_40",self:GetPackedBool("ARS_40") and 1 or 0,0,1,5,false)
    local light_60 = self:Animate("light_60",self:GetPackedBool("ARS_60") and 1 or 0,0,1,5,false)
    local light_80 = self:Animate("light_80",self:GetPackedBool("ARS_70") and 1 or 0,0,1,8,false)
    local light_70 = self:Animate("light_70",self:GetPackedBool("ARS_80") and 1 or 0,0,1,6,false)
    if typ < 3 then
        self:Animate("speed_o",self:GetPackedRatio("Speed"),0.337,0.663,60,3)
        self:ShowHideSmooth("panel1_04", light_04)
        self:ShowHideSmooth("panel1_0", light_0)
        self:ShowHideSmooth("panel1_40", light_40)
        self:ShowHideSmooth("panel1_60", light_60)
        self:ShowHideSmooth("panel1_70", light_80)
        self:ShowHideSmooth("panel1_80", light_70)
    else
        self:ShowHideSmooth("panel2_04", light_04)
        self:ShowHideSmooth("panel2_0", light_0)
        self:ShowHideSmooth("panel2_40", light_40)
        self:ShowHideSmooth("panel2_60", light_60)
        self:ShowHideSmooth("panel2_70", light_80)
        self:ShowHideSmooth("panel2_80", light_70)
    end
    if typ == 1 then
        self:ShowHide("rcars_wrench",self.RCARSResetTime and CurTime()-self.RCARSResetTime<1.5)
        self:ShowHide("rcbps_wrench",self.RCBPSResetTime and CurTime()-self.RCBPSResetTime<1.5)
        if IsValid(self.ClientEnts.rcars_wrench) and self.Anims.RCARSToggle then
            self.ClientEnts.rcars_wrench:SetPoseParameter("position",1-self.Anims.RCARSToggle.value)
        end

        if IsValid(self.ClientEnts.rcbps_wrench) and self.Anims.RCBPSToggle then
            self.ClientEnts.rcbps_wrench:SetPoseParameter("position",1-self.Anims.RCBPSToggle.value)
        end
        if self.LastRCARSValue ~= self:GetPackedBool("RCARS") then
            self.RCARSResetTime = CurTime()+1.5
            self.LastRCARSValue = self:GetPackedBool("RCARS")
        end
        if self.LastRCBPSValue ~= self:GetPackedBool("RCBPS") then
            self.RCBPSResetTime = CurTime()+1.5
            self.LastRCBPSValue = self:GetPackedBool("RCBPS")
        end
    else
        self:ShowHide("rcav3_wrench",self.RCAV3ResetTime and CurTime()-self.RCAV3ResetTime<1.5)
        self:ShowHide("rcav4_wrench",self.RCAV4ResetTime and CurTime()-self.RCAV4ResetTime<1.5)
        self:ShowHide("rcav5_wrench",self.RCAV5ResetTime and CurTime()-self.RCAV5ResetTime<1.5)
        if IsValid(self.ClientEnts.rcav3_wrench) and self.Anims.RCAV3Toggle then
            self.ClientEnts.rcav3_wrench:SetPoseParameter("position",1-self.Anims.RCAV3Toggle.value)
        end
        if IsValid(self.ClientEnts.rcav4_wrench) and self.Anims.RCAV4Toggle then
            self.ClientEnts.rcav4_wrench:SetPoseParameter("position",1-self.Anims.RCAV4Toggle.value)
        end
        if IsValid(self.ClientEnts.rcav5_wrench) and self.Anims.RCAV5Toggle then
            self.ClientEnts.rcav5_wrench:SetPoseParameter("position",1-self.Anims.RCAV5Toggle.value)
        end
        if self.LastRCAV3Value ~= self:GetPackedBool("RCAV3") then
            self.RCAV3ResetTime = CurTime()+1.5
            self.LastRCAV3Value = self:GetPackedBool("RCAV3")
        end
        if self.LastRCAV4Value ~= self:GetPackedBool("RCAV4") then
            self.RCAV4ResetTime = CurTime()+1.5
            self.LastRCAV4Value = self:GetPackedBool("RCAV4")
        end
        if self.LastRCAV5Value ~= self:GetPackedBool("RCAV5") then
            self.RCAV5ResetTime = CurTime()+1.5
            self.LastRCAV5Value = self:GetPackedBool("RCAV5")
        end
        --print(self.Anims.rcav5_wrench.val,self.Anims.RCAV5Toggle.value)
        --self.Anims["rcav5_wrench"]=nil
        --self:Animate("rcav5_wrench",0,0,0.5,60,3)

    end

    local vpr = self:Animate("radiolamp",self:GetPackedBool("VPR") and 1 or 0,0,1,8,false)
    self:ShowHideSmooth("rvs",vpr)
    self:SetSoundState("vpr",vpr>0 and 1 or 0,1)

    local HL1 = self:Animate("whitelights",self:GetPackedBool("HeadLights1") and 1 or 0,0,1,5,false)
    local HL2 = self:Animate("distantlights",self:GetPackedBool("HeadLights2") and 1 or 0,0,1,5,false)
    local RL = self:Animate("redlights",self:GetPackedBool("RedLight") and 1 or 0,0,1,5,false)

    self:ShowHideSmooth("WhiteLights",HL1)
    self:ShowHideSmooth("DistantLights",HL2)
    self:ShowHideSmooth("RedLights",RL)
    self:SetLightPower(5,RL > 0,RL)
    self:SetLightPower(6,RL > 0,RL)
    self:SetLightPower(30,HL1 > 0, HL1)
    self:SetLightPower(31,HL1 > 0, HL1)
    self:SetLightPower(32,HL2 > 0, HL2)

    local PL = HL1*self:Animate("lamps_pult",self:GetPackedBool("PanelLights") and 1 or 0,0,1,12,false)
    self:SetLightPower("Lamps_pult",PL>0,PL)
    self:ShowHideSmooth("Lamps_pult",PL)
    self:SetLightPower(21,PL>0,PL)
    self:SetLightPower(22,PL>0,PL)

    local bright = HL1*0.3+HL2*0.7
    self:SetLightPower(1,bright>0,bright)
    self:SetLightPower(2,RL>0,RL)

    if IsValid(self.GlowingLights[1]) then
        if not self:GetPackedBool("HeadLights1") and self.GlowingLights[1]:GetFarZ() ~= 3144 then
            self.GlowingLights[1]:SetFarZ(3144)
        end
        if self:GetPackedBool("HeadLights1") and self.GlowingLights[1]:GetFarZ() ~= 5144 then
            self.GlowingLights[1]:SetFarZ(5144)
        end
    end

    local Bortlamp_w = self:Animate("Bortlamp_w",self:GetPackedBool("DoorsW") and 1 or 0,0,1,16,false)
    local Bortlamp_g = self:Animate("Bortlamp_g",self:GetPackedBool("GRP") and 1 or 0,0,1,16,false)
    local Bortlamp_y = self:Animate("Bortlamp_y",self:GetPackedBool("BrY") and 1 or 0,0,1,16,false)
    self:ShowHideSmooth("bortlamp1_w",Bortlamp_w)
    self:ShowHideSmooth("bortlamp1_g",Bortlamp_g)
    self:ShowHideSmooth("bortlamp1_y",Bortlamp_y)
    self:ShowHideSmooth("bortlamp2_w",Bortlamp_w)
    self:ShowHideSmooth("bortlamp2_g",Bortlamp_g)
    self:ShowHideSmooth("bortlamp2_y",Bortlamp_y)
    self:SetLightPower(15, Bortlamp_w > 0, Bortlamp_w)
    self:SetLightPower(18, Bortlamp_w > 0, Bortlamp_w)
    self:SetLightPower(16, Bortlamp_g > 0, Bortlamp_g)
    self:SetLightPower(19, Bortlamp_g > 0, Bortlamp_g)
    self:SetLightPower(17, Bortlamp_y > 0, Bortlamp_y)
    self:SetLightPower(20, Bortlamp_y > 0, Bortlamp_y)

    ---PB
    self:Animate("PB",self:GetPackedBool("PB") and 1 or 0,0,0.2,  12,false)

    self:Animate("UAVALever",   self:GetPackedBool("UAVA") and 1 or 0,     0,0.6, 128,  3,false)
    self:Animate("stopkran",   self:GetPackedBool("EmergencyBrakeValve") and 1 or 0,     0,0.23, 256,  3,false)

    self:Animate("brake_disconnect",self:GetPackedBool("DriverValveBLDisconnect") and 0 or 1,0.25,0.5,  4,false)
    self:Animate("train_disconnect",self:GetPackedBool("DriverValveTLDisconnect") and 1 or 0,0.25,0,  4,false)

    -- Simulate pressure gauges getting stuck a little
    self:Animate("brake",self:GetPackedRatio("CranePosition"), 0.00, 0.48, 256, 24)
    self:Animate("controller", self:GetPackedRatio("ControllerPosition"),0, 0.31,2,false)
    self:Animate("reverser",self:GetPackedRatio("ReverserPosition"),0.6, 0.4,  4,false)
    self:Animate("rcureverser",self:GetPackedBool("RCUPosition") and 1 or 0,0.77,0,3,false)
    self:Animate("volt1",self:GetPackedRatio("BatteryVoltage"),0.881,0.610,60,3)

    self:ShowHide("reverser",self:GetNW2Int("WrenchMode",0)==1)
    self:ShowHide("rcureverser",self:GetNW2Int("WrenchMode",0)==3)

    ---Animate brakes
    self:Animate("brake_line",      self:GetPackedRatio("BLPressure"),              0.142, 0.877+0.01, 256,2)--,,0.01)
    self:Animate("train_line",      self:GetPackedRatio("TLPressure"),    0.142, 0.877+0.01, 256,2)--,,0.01)
    self:Animate("brake_cylinder",  self:GetPackedRatio("BCPressure"),              0.141, 0.880-0.01, nil,2)--,,0.03)
    self:Animate("voltmeter",       self:GetPackedRatio("EnginesVoltage"),              0.631,0.376-0.01,92,2)
    self:Animate("ampermeter",      self:GetPackedRatio("EnginesCurrent"),             0.655,0.35,92,2)

    local door2 = self:Animate("door2", self:GetPackedBool("RearDoor") and 1 or 0,0,0.25, 8, 1)
    local door1 = self:Animate("door1", self:GetPackedBool("FrontDoor") and 1 or 0,0,0.22, 8, 1)
    local door3 = self:Animate("door3", self:GetPackedBool("PassengerDoor") and 1 or 0,1,0.79, 8, 1)
    local door4 = self:Animate("door4", self:GetPackedBool("CabinDoor") and 1 or 0,1,0.77, 8, 1)
    if self.Door1 ~= (door1 > 0) then
        self.Door1 = door1 > 0
        self:PlayOnce("door1","bass",self.Door1 and 1 or 0)
    end
    if self.Door2 ~= (door2 > 0) then
        self.Door2 = door2 > 0
        self:PlayOnce("door2","bass",self.Door2 and 1 or 0)
    end
    if self.Door3 ~= (door3 < 1) then
        self.Door3 = door3 < 1
        self:PlayOnce("door3","bass",self.Door3 and 1 or 0)
    end
    if self.Door4 ~= (door4 < 1) then
        self.Door4 = door4 < 1
        self:PlayOnce("door4","bass",self.Door4 and 1 or 0)
    end

    self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,1, 3, false)
    self:Animate("FrontTrain",  self:GetNW2Bool("FtI") and 1 or 0,0,1, 3, false)
    self:Animate("RearBrake",   self:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    self:Animate("RearTrain",   self:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)

    -- Main switch
    if self.LastGVValue ~= self:GetPackedBool("GV") then
        self.ResetTime = CurTime()+1.5
        self.LastGVValue = self:GetPackedBool("GV")
    end
    self:Animate("gv_wrench",self.LastGVValue and 1 or 0,0.5,0.9,128,1,false)
    self:ShowHideSmooth("gv_wrench",    CurTime() < self.ResetTime and 1 or 0.1)

    -- Animate doors
    if not self.DoorStates then self.DoorStates = {} end
    if not self.DoorLoopStates then self.DoorLoopStates = {} end
    for i=0,3 do
        for k=0,1 do
            local st = k==1 and "DoorL" or "DoorR"
            local doorstate = self:GetPackedBool(st)
            local id,sid = st..(i+1),"door"..i.."x"..k
            local state = self:GetPackedRatio(id)
            if (state ~= 1 and state ~= 0) ~= self.DoorStates[id] then
                --if doorstate and state < 1 or not doorstate and state > 0 then
                --else
                if doorstate and state == 1 or not doorstate and state == 0 then
                    if state > 0 then
                        self:PlayOnce(sid.."o","",1,math.Rand(0.8,1.2))
                    else
                        self:PlayOnce(sid.."c","",1,math.Rand(0.8,1.2))
                    end
                end
                self.DoorStates[id] = (state ~= 1 and state ~= 0)
            end
            if (state ~= 1 and state ~= 0) then
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) + 2*self.DeltaTime,0,1)
            else
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) - 6*self.DeltaTime,0,1)
            end
            self:SetSoundState(sid.."r",self.DoorLoopStates[id],0.8+self.DoorLoopStates[id]*0.2)
            local n_l = "door"..i.."x"..k--.."a"
            --local n_r = "door"..i.."x"..k.."b"
            local dlo = 1
            if self.Anims[n_l] then
                dlo = math.abs(state-(self.Anims[n_l] and self.Anims[n_l].oldival or 0))
                if dlo <= 0 and self.Anims[n_l].oldspeed then
                    dlo = self.Anims[n_l].oldspeed/14
                end
            end
            self:Animate(n_l,state,0.01,1, dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
            --self:Animate(n_r,state,0,1, dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
        end
    end

    self:ShowHide("SSpeed1",self:GetPackedBool("LUDS"))
    self:ShowHide("SSpeed2",self:GetPackedBool("LUDS"))
    local speed = self:GetPackedRatio("CPS_Speed")*100.0
    if IsValid(self.ClientEnts["SSpeed1"])then self.ClientEnts["SSpeed1"]:SetSkin(math.floor(speed)%10) end
    if IsValid(self.ClientEnts["SSpeed2"])then self.ClientEnts["SSpeed2"]:SetSkin(math.floor(speed/10)%10) end

    -- Brake-related sounds
    local dT = self.DeltaTime
    --self.TunnelCoeff = 0.8
    --self.StreetCoeff = 0
    local rollingi = math.min(1,self.TunnelCoeff+math.Clamp((self.StreetCoeff-0.82)/0.3,0,1))
    local rollings = math.max(self.TunnelCoeff*1,self.StreetCoeff)
    --if self:EntIndex() == 3239 then LocalPlayer():ChatPrint(Format("T: %.2f, S: %.2f",rollingi,rollings)) end
    -- Brake-related sounds
    local dT = self.DeltaTime
    local speed = self:GetPackedRatio("Speed")*100.0
    local rol5 = math.Clamp(speed/1,0,1)*(1-math.Clamp((speed-3)/8,0,1))
    local rol10 = math.Clamp(speed/12,0,1)*(1-math.Clamp((speed-25)/8,0,1))
    local rol40p = Lerp((speed-25)/12,0.6,1)
    local rol40 = math.Clamp((speed-23)/8,0,1)*(1-math.Clamp((speed-55)/8,0,1))
    local rol40p = Lerp((speed-23)/50,0.6,1)
    local rol70 = math.Clamp((speed-50)/8,0,1)*(1-math.Clamp((speed-72)/5,0,1))
    local rol70p = Lerp(0.8+(speed-65)/25*0.2,0.8,1.2)
    local rol80 = math.Clamp((speed-70)/5,0,1)
    local rol80p = Lerp(0.8+(speed-72)/15*0.2,0.8,1.2)
    self:SetSoundState("rolling_5",math.min(1,rollingi*(1-rollings)+rollings*0.8)*rol5,1)
    self:SetSoundState("rolling_10",rollingi*rol10,1)
    self:SetSoundState("rolling_40",rollingi*rol40,rol40p)
    self:SetSoundState("rolling_70",rollingi*rol70,rol70p)
    self:SetSoundState("rolling_80",rollingi*rol80,rol80p)

    local rol_motors = math.Clamp((speed-20)/40,0,1)
    self:SetSoundState("rolling_motors",math.max(rollingi,rollings*0.3)*rol_motors,speed/56)

    local rol10 = math.Clamp(speed/15,0,1)*(1-math.Clamp((speed-18)/35,0,1))
    local rol10p = Lerp((speed-15)/14,0.6,0.78)
    local rol40 = math.Clamp((speed-18)/35,0,1)*(1-math.Clamp((speed-55)/40,0,1))
    local rol40p = Lerp((speed-15)/66,0.6,1.3)
    local rol70 = math.Clamp((speed-55)/20,0,1)--*(1-math.Clamp((speed-72)/5,0,1))
    local rol70p = Lerp((speed-55)/27,0.78,1.15)
    --local rol80 = math.Clamp((speed-70)/5,0,1)
    --local rol80p = Lerp(0.8+(speed-72)/15*0.2,0.8,1.2)
    self:SetSoundState("rolling_low"    ,rol10*rollings,rol10p) --15
    self:SetSoundState("rolling_medium2",rol40*rollings,rol40p) --57
    --self:SetSoundState("rolling_medium1",0 or rol40*rollings,rol40p) --57
    self:SetSoundState("rolling_high2"  ,rol70*rollings,rol70p) --70

    self.ReleasedPdT = math.Clamp(self.ReleasedPdT + 2*(-self:GetPackedRatio("BrakeCylinderPressure_dPdT",0)-self.ReleasedPdT)*dT,0,1)
    local release1 = math.Clamp((self.ReleasedPdT-0.1)/0.8,0,1)^2
    self:SetSoundState("release1",release1,1)
    self:SetSoundState("release2",(math.Clamp(0.3-release1,0,0.3)/0.3)*(release1/0.3),1.0)

    self.FrontLeak = math.Clamp(self.FrontLeak + 10*(-self:GetPackedRatio("FrontLeak")-self.FrontLeak)*dT,0,1)
    self.RearLeak = math.Clamp(self.RearLeak + 10*(-self:GetPackedRatio("RearLeak")-self.RearLeak)*dT,0,1)
    self:SetSoundState("front_isolation",self.FrontLeak,0.9+0.2*self.FrontLeak)
    self:SetSoundState("rear_isolation",self.RearLeak,0.9+0.2*self.RearLeak)

    self.CraneRamp = math.Clamp(self.CraneRamp + 8.0*((1*self:GetPackedRatio("Crane_dPdT",0))-self.CraneRamp)*dT,-1,1)
    self:SetSoundState("crane334_brake_low",math.Clamp((-self.CraneRamp)*2,0,1)^2,1)
    local high = math.Clamp(((-self.CraneRamp)-0.5)/0.5,0,1)^1
    self:SetSoundState("crane334_brake_high",high,1.0)
    self:SetSoundState("crane013_brake2",high*2,1.0)
    self:SetSoundState("crane334_brake_eq_high",--[[ math.Clamp(-self.CraneRamp*0,0,1)---]] math.Clamp(-self:GetPackedRatio("ReservoirPressure_dPdT")-0.2,0,1)^0.8*1,1)
    self:SetSoundState("crane334_brake_eq_low",--[[ math.Clamp(-self.CraneRamp*0,0,1)---]] math.Clamp(-self:GetPackedRatio("ReservoirPressure_dPdT")-0.4,0,1)^0.8*1.3,1)

    self:SetSoundState("crane334_release",math.Clamp(self.CraneRamp,0,1)^2,1.0)

    local emergencyBrakeValve = self:GetPackedRatio("EmergencyBrakeValve_dPdT", 0)
    self.EmergencyBrakeValveRamp = math.Clamp(self.EmergencyBrakeValveRamp + (emergencyBrakeValve-self.EmergencyBrakeValveRamp)*dT*8,0,1)
    self:SetSoundState("valve_brake",self.EmergencyBrakeValveRamp,0.8+self.EmergencyBrakeValveRamp*0.4)

    local emergencyValve = self:GetPackedRatio("EmergencyValve_dPdT", 0)^0.4*1.2
    self.EmergencyValveRamp = math.Clamp(self.EmergencyValveRamp + (emergencyValve-self.EmergencyValveRamp)*dT*16,0,1)
    local emer_brake = math.Clamp((self.EmergencyValveRamp-0.9)/0.05,0,1)
    local emer_brake2 = math.Clamp((self.EmergencyValveRamp-0.2)/0.4,0,1)*(1-math.Clamp((self.EmergencyValveRamp-0.9)/0.1,0,1))
    self:SetSoundState("emer_brake",emer_brake,1)
    self:SetSoundState("emer_brake2",emer_brake2,math.min(1,0.8+0.2*emer_brake2))
    --self:SetSoundState("emer_brake",self.EmergencyValveRamp*0.8,1)
    --self:SetSoundState("emer_brake",self.EmergencyValveRamp*0.8,1)

    -- Compressor
	local compressorvoltage = Lerp(self:GetPackedRatio("LampsStrength"),0.75,1.05)
	local compressorb = self:GetPackedBool("AV") and compressorvoltage or 1
	local compressorspeed = self:GetPackedBool("VB") and compressorb or 0
    local state = self:GetPackedBool("Compressor")
    self:SetSoundState("compressor",state and 0.6 or 0,compressorspeed or 0)
    -- ARS/ringer alert
    self:SetSoundState("ring",self:GetPackedBool("KSRing") and 1 or 0,1)
    self:SetSoundState("ring2",self:GetPackedBool("MRing") and 1 or 0,0.92)

    -- RK rotation
    if self:GetPackedBool("RK") then self.RKTimer = CurTime() end
    state = (CurTime() - (self.RKTimer or 0)) < 0.2
    self.PreviousRKState = self.PreviousRKState or false
    if self.PreviousRKState ~= state then
        self.PreviousRKState = state
        if state then
            self:SetSoundState("rk",0.25,1)
        else
            self:SetSoundState("rk",0,0)
        end
    end

    local work = self:GetPackedBool("AnnPlay")
    local noise = self:GetNW2Int("AnnouncerNoise", -1)

    local volume = self:GetNW2Float("UPOVolume",0.6)
    local noisevolume = self:GetNW2Float("UPONoiseVolume",0.6)

    self.BPSNBuzzVolume = self.BPSNBuzzVolume or 0
    local buzzvolume = volume
    if self.Sounds["announcer1"] and IsValid(self.Sounds["announcer1"]) then buzzvolume = (1-(self.Sounds["announcer1"]:GetLevel())*math.Rand(0.9,3))*buzzvolume*2 end
    if self.BPSNBuzzVolume > buzzvolume then
        self.BPSNBuzzVolume = math.Clamp(self.BPSNBuzzVolume + 8*(buzzvolume-self.BPSNBuzzVolume)*dT,0.1,1)
    else
        self.BPSNBuzzVolume = math.Clamp(self.BPSNBuzzVolume + 0.4*(buzzvolume-self.BPSNBuzzVolume)*dT,0.1,1)
    end

    for k,v in ipairs(self.AnnouncerPositions) do
        volume = volume*(v[3] or 1)
        self:SetSoundState("announcer_noiseW"..k,noise>-1 and noisevolume*volume or 0,1)
        for i=1,3 do
            self:SetSoundState(Format("announcer_noise%d_%d",i,k),(work and i==noise) and volume*self.BPSNBuzzVolume*self:GetNW2Float("UPOBuzzVolume",1) or 0,1)
        end
    end
    for k,v in ipairs(self.AnnouncerPositions) do
        if IsValid(self.Sounds["announcer"..k]) then self.Sounds["announcer"..k]:SetVolume(work and v[3]*volume or 0) end
    end
end

function ENT:OnAnnouncer(volume)
    return self:GetPackedBool("AnnPlay") and self:GetNW2Float("UPOVolume",0.6)*volume  or 0
end

function ENT:Draw()
    self.BaseClass.Draw(self)
end
function ENT:DrawPost()
    self:DrawOnPanel("AirDistributor",function()
        draw.DrawText(self:GetNW2Bool("AD") and "Air Distributor ON" or "Air Distributor OFF","Trebuchet24",0,0,Color(0,0,0,255))
    end)

end


function ENT:OnPlay(soundid,location,range,pitch)
    if location == "stop" then
        if IsValid(self.Sounds[soundid]) then
            self.Sounds[soundid]:Pause()
            self.Sounds[soundid]:SetTime(0)
        end
        return
    end
    if location == "bass" then
        if soundid == "VDOL" then
            return range > 0 and "vdol_on" or "vdol_off",location,1,pitch
        end
        if soundid == "VDOP" then
            return range > 0 and "vdor_on" or "vdor_off",location,1,pitch
        end
        if soundid == "VDZ" then
            return range > 0 and "vdz_on" or "vdz_off",location,1,pitch
        end
        if soundid:sub(1,4) == "IGLA" then
            return range > 0 and "igla_on" or "igla_off",location,1,pitch
        end
        if soundid == "LK2" then
            local speed = self:GetPackedRatio("Speed")
            local id = range > 0 and "lk2_on" or "lk2_off"
            self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
            return id,location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "LK5" then
            local speed = self:GetPackedRatio("Speed")
            local id = range > 0 and "lk5_on" or "lk5_off"
            self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
            return id,location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "LK4" then
            local speed = self:GetPackedRatio("Speed")
            local id = range > 0 and "lk4_on" or "lk4_off"
            self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
            return id,location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "KK" then
            return range > 0 and "kk_on" or "kk_off",location,1,pitch--0.8
        end
        if soundid == "RPB" then
            return range > 0 and "rpb_on" or "rpb_off",location,1,pitch
        end
        if soundid == "KD" then
            return range > 0 and "kd_on" or "kd_off",location,1,pitch
        end
        if soundid == "AVU" then
            return range > 0 and "avu_on" or "avu_off",location,1,0.9
        end
        if soundid == "brake" then
            self:PlayOnce("brake_f",location,range,pitch)
            self:PlayOnce("brake_b",location,range,pitch)
            return
        end
        if soundid == "UAVAC" then
            return "uava_reset",location,range,pitch
        end
    end
    return soundid,location,range,pitch
end
--[[
local dist = {
    Back1 = 550,
    AVMain = 550,
    AV1 = 550,
    AV2 = 550,
    Battery = 550,
}
for id,panel in pairs(ENT.ButtonMap) do
    if not panel.buttons then continue end
    for k,v in pairs(panel.buttons) do
        if v.model then
            local dist = dist[id] or 150
            if v.model.model then
                v.model.hideseat=dist
            elseif v.model.lamp then
                v.model.lamp.hideseat=dist
            end
        end
    end
end--]]
Metrostroi.GenerateClientProps()
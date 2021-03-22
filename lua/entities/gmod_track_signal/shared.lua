ENT.Type			= "anim"
ENT.PrintName		= "Signalling Element"
ENT.Category		= "Metrostroi (utility)"

ENT.Spawnable		= false
ENT.AdminSpawnable	= false

ENT.TrafficLightModels = {}
ENT.RenderOffset = {}
ENT.BasePosition = Vector(-110,32,0)
ENT.ReloadModels = true
ENT.Signal_IS = "W"
Metrostroi.LiterWarper = {
	A = "f",B = ",",V = "d",G = "u",D = "l",E = "t",J = ";",Z = "p",
	I = "b",Y = "q",K = "r",L = "k",M = "v",N = "y",O = "j",P = "g",
	R = "h",S = "c",T = "n",U = "e",F = "a",H = "[",C = "w",
	--Y = "",--ЧЩЪЫЬЭЮ
	W = "o",Q = "z",
}

-- Lamp indexes
-- 0 Red
-- 1 Yellow
-- 2 Green
-- 3 Blue
-- 4 Second yellow (flashing yellow)
-- 5 White
--[[
Metrostroi.RoutePointer = {
	[""] = {
	false,false,false,false,false,
	false,false,false,false,false,
	false,false,false,false,false,
	false,false,false,false,false,
	false,false,false,false,false,
	false,false,false,false,false,
	false,false,false,false,false,
	},
	["1"] = {
	false,false,true ,false,false,
	false,true ,true ,false,false,
	true ,false,true ,false,false,
	false,false,true ,false,false,
	false,false,true ,false,false,
	false,false,true ,false,false,
	true ,true ,true ,true ,true ,
	},
	["2"] = {
	false,true ,true ,true ,false,
	true ,false,false,false,true ,
	false,false,false,false,true ,
	false,false,false,true,false,
	false,false,true ,false,false,
	false,true ,false,false,false,
	true ,true ,true ,true ,true ,
	},
	["3"] = {
	false,true ,true ,true ,false,
	true ,false,false,false,true ,
	false,false,false,false,true ,
	false,false,true ,true ,false,
	false,false,false,false,true ,
	true ,false,false,false,true ,
	false,true ,true ,true ,false,
	},
	["4"] = {
	false,false,false,true ,false,
	false,false,true ,true ,false,
	false,true ,false,true ,false,
	true ,false,false,true ,false,
	true ,true ,true ,true ,true ,
	false,false,false,true ,false,
	false,false,false,true ,false,
	},
	["5"] = {
	true ,true ,true ,true ,true ,
	true ,false,false,false,false,
	true ,true ,true ,true ,false,
	false,false,false,false,true ,
	false,false,false,false,true ,
	true ,false,false,false,true ,
	false,true ,true ,true ,false,
	},
	["6"] = {
	false,true ,true ,true ,false,
	true ,false,false,false,true ,
	true ,false,false,false,false,
	true ,true ,true ,true ,false,
	true ,false,false,false,true ,
	true ,false,false,false,true ,
	false,true ,true ,true ,false,
	},
	["7"] = {
	true ,true ,true ,true ,true ,
	false,false,false,false,true ,
	false,false,false,true ,false,
	false,false,true ,false,false,
	false,true ,false,false,false,
	false,true ,false,false,false,
	false,true ,false,false,false,
	},
	["8"] = {
	false,true ,true ,true ,false,
	true ,false,false,false,true ,
	true ,false,false,false,true ,
	false,true ,true ,true ,false,
	true ,false,false,false,true ,
	true ,false,false,false,true ,
	false,true ,true ,true ,false,
	},
	["9"] = {
	false,true ,true ,true ,false,
	true ,false,false,false,true ,
	true ,false,false,false,true ,
	false,true ,true ,true ,true ,
	false,false,false,false,true ,
	true ,false,false,false,true ,
	false,true ,true ,true ,false,
	},
	["0"] = {
	false,true ,true ,true ,false,
	true ,false,false,false,true ,
	true ,false,false,true ,true ,
	true ,false,true ,false,true ,
	true ,true ,false,false,true ,
	true ,false,false,false,true ,
	false,true ,true ,true ,false,
	},
	["D"] = {
	false,true ,true ,true ,false,
	false,true ,false,true ,false,
	false,true ,false,true ,false,
	false,true ,false,true ,false,
	false,true ,false,true ,false,
	true ,true ,true ,true ,true ,
	true ,false,false,false,true ,
	},
}]]
Metrostroi.RoutePointer = {
	[""] = 0,
	["0"] = 10,
	["D"] = 11,
}
for i = 1,9 do
	Metrostroi.RoutePointer[tostring(i)] = i
end
Metrostroi.Lenses = {
	["R"] = Color(255,0,0),
	["Y"] = Color(255,127,0),
	["G"] = Color(0,255,0),
	["W"] = Color(255,255,255),
	["B"] = Color(0,0,255),
}
--[[
ENT.LightType = 0
ENT.Name = ""
ENT.Lenses = {
}
ENT.RouteNumber = ""
ENT.OnlyARS = false

ENT.Routes = {
}
]]
ENT.AutostopModel = {
	"models/metrostroi/signals/mus/autostop.mdl",
	Vector(41,-0.5,1.5)
}

ENT.OldRouteNumberSetup = {
	"1234D",
	"WKFX","LR",
	Vector(6,0,10.5),
	{D=4},{["F"]=0,["L"]=2,["R"]=0,W=3,K=4}
}

--------------------------------------------------------------------------------
-- Inside
--------------------------------------------------------------------------------
ENT.RenderOffset[0] = Vector(0,0.5,113.35)
ENT.TrafficLightModels[0] = {
	m1	= "models/metrostroi/signals/mus/box.mdl",
	m2	= "models/metrostroi/signals/mus/pole_2.mdl",
	m2_long =  "models/metrostroi/signals/mus/pole_2_long.mdl",
	m2_long_pos = 46,
	m2_long_replace = "pole_",
	name	= Vector(-1.75,2.5,3),
	name_one	= Vector(7.41,0.5,1),
	[1]	= { 32, "models/metrostroi/signals/mus/light_2.mdl", {
				[0] = Vector(7.41,-27.54,25.26),
				[1] = Vector(7.41,-27.54,14.2),--
				["glass"]	= {
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(7.43,4.46,25)},
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(7.43,4.46,14)},
				}
			}},
	[2]	= { 43, "models/metrostroi/signals/mus/light_3.mdl", {
				[0] = Vector(7.41,-27.54,35.1),
				[1] = Vector(7.41,-27.54,25.26),
				[2] = Vector(7.41,-27.54,14.2),---27.54
				["glass"]	= {
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(7.43,4.46,35.2)},
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(7.43,4.46,25)},
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(7.43,4.46,14)},
				}
				}},

	M = { 24, "models/metrostroi/signals/mus/light_pathindicator.mdl",  Vector(13.1,2, 19.5), 1.75, 2.05, 4},
}


--------------------------------------------------------------------------------
-- Outside
--------------------------------------------------------------------------------
ENT.RenderOffset[1] = Vector(0,0,200)
ENT.TrafficLightModels[1] = {
	["m1"]	= "models/metrostroi/signals/mus/pole_1.mdl",
	name	= Vector(0,3,40),
	[1]	= { 46, "models/metrostroi/signals/mus/light_outside_2.mdl", {
				[0] = Vector(-0.51,-18.76,19.95),
				[1] = Vector(-0.51,-18.76,7.97),
				["glass"]	= {
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(0,13.3,19.95)},
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(0,13.3,7.97 )},
				}
				}},
	[2]	= { 56, "models/metrostroi/signals/mus/light_outside_3.mdl", {
				[0] = Vector(-0.51,-18.76,30.88),
				[1] = Vector(-0.51,-18.76,19.95),
				[2] = Vector(-0.51,-18.76,7.97),
				["glass"]	= {
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(0,13.3,30.88)},
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(0,13.3,19.95)},
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(0,13.3,7.97 )},
				}
				} },

	W = { 25, "models/metrostroi/signals/mus/light_outside_1.mdl" , {
				[0] = Vector(-0.51,-18.76,7.97),
				["glass"]	= {
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(0,13.3,7.97 )},
				}
				}},
	M = { 40, "models/metrostroi/signals/mus/light_pathindicator3.mdl",  Vector(7,11, 25), 3.6, 3.4, 5},
	noleft = true,
}

--------------------------------------------------------------------------------
-- Outside box
--------------------------------------------------------------------------------
ENT.RenderOffset[2] = Vector(0,0.,112)
ENT.TrafficLightModels[2] = {
	["m1"]	= "models/metrostroi/signals/mus/box_outside.mdl",
	["m2"]	= "models/metrostroi/signals/mus/pole_3.mdl",
	["name"]	= Vector(-3,2.5,7),
	name_one	= Vector(10.07,0.5,3),
	[1]	= { 42, "models/metrostroi/signals/mus/light_outside2_2.mdl", {
				[0] = Vector(10.07,-29.7,27.55),
				[1] = Vector(10.07,-29.7,16),
				["glass"]	= {
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(10.39,2.32,27.55)},
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(10.39,2.32,16)},
				}
				}},
	[2]	= { 47, "models/metrostroi/signals/mus/light_outside2_3.mdl", {
				[0] = Vector(10.07,-29.7,39.37),
				[1] = Vector(10.07,-29.7,27.55),
				[2] = Vector(10.07,-29.7,16),
				["glass"]	= {
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(10.39,2.32,39.37)},
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(10.39,2.32,27.55)},
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(10.39,2.32,16)},
				}
				}},
	[3]	= { 47, "models/metrostroi/signals/mus/light_outside2_4.mdl", {
				[0] = Vector(10.07,-29.7,50.45),
				[1] = Vector(10.07,-29.7,39.37),
				[2] = Vector(10.07,-29.7,27.55),
				[3] = Vector(10.07,-29.7,16),
				["glass"]	= {
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(10.39,2.32,50.45)},
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(10.39,2.32,39.37)},
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(10.39,2.32,27.55)},
					{"models/metrostroi/signals/mus/lamp_lens.mdl",Vector(10.39,2.32,16)},
				}
				}},

	M = { 24, "models/metrostroi/signals/mus/light_pathindicator.mdl",  Vector(13.8,2, 22.8), 1.8, 2.1, 4},
}
ENT.SignalConverter = {
	R = 1,
	Y = 2,
	G = 3,
	B = 4,
	W = 5
}


for i = 0,2 do
	--SERVER
	ENT.TrafficLightModels[i].ArsBox = {model = "models/metrostroi/signals/mus/ars_box.mdl"}
	ENT.TrafficLightModels[i].ArsBoxMittor = {model = "models/metrostroi/signals/mus/ars_box_mittor.mdl"}
	
	--CLIENT
	ENT.TrafficLightModels[i].LampIndicator = {model = "models/metrostroi/signals/mus/light_lampindicator", Vector(0.2), Vector(1), Vector(8), Vector(-0.9,1,1), Vector(3,0,3), Vector(-1,1,0.85)}
	ENT.TrafficLightModels[i].LampBase = {model = "models/metrostroi/signals/mus/lamp_base.mdl"}
	ENT.TrafficLightModels[i].SignLetterSmall = {model = "models/metrostroi/signals/mus/sign_letter_small.mdl", Vector(1.5,0,0), Vector(-1.5,0,0)}
	ENT.TrafficLightModels[i].SignLetter = {model = "models/metrostroi/signals/mus/sign_letter.mdl", z = 5.85}
	ENT.TrafficLightModels[i].LetMaterials = {str = "models/metrostroi/signals/let/"}
	
	ENT.TrafficLightModels[i].RouteNumberOffset = Vector(10,0,0)
	ENT.TrafficLightModels[i].DoubleOffset = Vector(0,0,1.62)
	ENT.TrafficLightModels[i].RouteNumberOffset2 = Vector(0,0,7.2)
	ENT.TrafficLightModels[i].SpecRouteNumberOffset = Vector(3,-1,3)
	ENT.TrafficLightModels[i].RouteNumberOffset3 = Vector(10.5,0,-6)
	ENT.TrafficLightModels[i].SpecRouteNumberOffset2 = Vector(-0.8,1,0.94)
	ENT.TrafficLightModels[i].RouaOffset = Vector(6.2,0,24.5)
end


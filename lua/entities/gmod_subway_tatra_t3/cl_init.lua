include("shared.lua")
--[[ENT.ClientProps = {}
ENT.ClientProps["body"] = {
    model = "models/tram/lm57/lm57_body.mdl",
    pos = Vector(0,0,-60),
    ang = Angle(0,0,0),
    hide = 2.0,
    scale = 100/2.54/0.75,
}
ENT.ClientProps["interior"] = {
    model = "models/tram/lm57/lm57_int.mdl",
    pos = Vector(0,0,-60),
    ang = Angle(0,0,0),
    hide = 2.0,
    scale = 100/2.54/0.75,
}
Metrostroi.GenerateClientProps()]]
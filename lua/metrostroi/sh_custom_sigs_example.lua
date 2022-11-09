--пример (поэтому скрипт выключен строкой do return end)
--файл должен лежать именно в папке metrostroi и его имя должно начинаться на sh_
do return end
Metrostroi.AddCustomSigs({
    name = "test1",
    model = "models/metrostroi/re_sign/t_och_r.mdl",
	pos = Vector(0,90,125),
	angles = Angle(0,0,0),
})

Metrostroi.AddCustomSigs({
    name = "test2",
	model = "models/metrostroi/re_sign/t_t_r.mdl",
	pos = Vector(0,0,-2),
	angles = Angle(0,0,0),
	noauto = true,
	noleft = true,
})


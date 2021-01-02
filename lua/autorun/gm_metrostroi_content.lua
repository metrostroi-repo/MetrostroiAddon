if CLIENT then
    return
end
local workshopid = {
    261801217, -- Original addon
    --1095088360,
    1095094174, -- Pack 1
    1095098251, -- Pack 2
    1095100683, -- Pack 3
    1095105863, -- Pack 4
    1095109617, -- Pack 5
    1095111608, -- Pack 6
    674649096,
    348429431,
}
print("-Starting adding metrostroi workshop addons...")
print("-Workshop addons in base:"..#workshopid)
for k,v in pairs(workshopid) do
	resource.AddWorkshop(tostring(v))
	print("--Added a "..v.." workshop addon.")
end
print("-End of adding workshop addons...")
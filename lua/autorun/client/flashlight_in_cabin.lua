--[[-------------------------------------------------------------------------
Allow toggling the flashlight while sitting in the driver's seat (#167)
---------------------------------------------------------------------------]]
-- GMod blocks the native flashlight toggle while the player is seated in
-- any prop_vehicle_*, which includes our driver seats (prop_vehicle_prisoner_pod,
-- see gmod_subway_base:CreateSeatEntity). Re-enable it manually, scoped to
-- our own seats only (seat:GetNW2Entity("TrainEntity") is set there).
if SERVER then return end

local function InMetrostroiSeat(ply)
    local veh = ply:GetVehicle()
    return IsValid(veh) and IsValid(veh:GetNW2Entity("TrainEntity"))
end

-- ponytail: bind name "+flashlight" and whether the engine even reaches
-- PlayerBindPress while InVehicle() is unverified without an in-game test.
-- Self-contained new file, no existing behavior touched if this turns out wrong.
hook.Add("PlayerBindPress", "Metrostroi_CabinFlashlight", function(ply, bind, pressed)
    if bind ~= "+flashlight" or not pressed then return end
    if not InMetrostroiSeat(ply) then return end

    ply:Flashlight(not ply:FlashlightIsOn())
    return true
end)

-- FIXME hack
function Metrostroi.GetEnergyCost(kWh)
    return kWh*0.08
end

--Not sure about the quirks related to shared convars like this
CreateConVar("metrostroi_train_requirethirdrail",1,FCVAR_ARCHIVE,"Whether or not Metrostroi trains require power from the third rail")
CreateConVar("metrostroi_debugger_update_interval",1,FCVAR_ARCHIVE,"Seconds between debugger data messages")

CreateConVar("metrostroi_arsmode",1,FCVAR_ARCHIVE)
CreateConVar("metrostroi_arsmode_nogreen",0,FCVAR_ARCHIVE)
CreateConVar("metrostroi_write_telemetry",0,FCVAR_ARCHIVE)

CreateConVar("metrostroi_voltage",750,FCVAR_ARCHIVE)
CreateConVar("metrostroi_current_limit",4000,FCVAR_ARCHIVE)
CreateConVar("metrostroi_ars_sfreq",1,FCVAR_ARCHIVE,"Enable second freq.")
CreateConVar("metrostroi_signal_debug",0,FCVAR_ARCHIVE,"Enable signal debug")


Metrostroi.SignalDebugCV = GetConVar("metrostroi_signal_debug")
if SERVER then
    util.AddNetworkString("metrostroi_expel_passengers")
    CreateConVar("metrostroi_ars_printnext",0,FCVAR_NONE,"Prints next signal to console on wagon with entered number")
    CreateConVar("metrostroi_maxtrains",3,{FCVAR_ARCHIVE},"Maximum of allowed trains")
    CreateConVar("metrostroi_maxwagons",3,{FCVAR_ARCHIVE},"Maximum of allowed wagons in 1 train")
    CreateConVar("metrostroi_maxtrains_onplayer",1,{FCVAR_ARCHIVE},"Maximum of allowed trains by player")


    local function BrokeAndSet(button,state,ply,train)
        local train = ply:GetTrain()

        if IsValid(train) then
            if train[button] then
                if train.Plombs[button] then train:BrokePlomb(button,ply) end
                train[button]:TriggerInput("Set",state)
            end
        end
    end
    concommand.Add("metrostroi_disablears",function(ply)
        if not IsValid(ply) then return end
        local train = ply:GetTrain()
        BrokeAndSet("KAH",1,ply)
        BrokeAndSet("ARS",0,ply)
        if train.BARSBlock then
            BrokeAndSet("ALS",1,ply)
            BrokeAndSet("BARSBlock",3,ply)
        end
        BrokeAndSet("VBA",0,ply)
        BrokeAndSet("EPK",0,ply)
        BrokeAndSet("EPV",0,ply)
        BrokeAndSet("U4",0,ply)
        BrokeAndSet("K9",0,ply)
        BrokeAndSet("KAHK",0,ply)
        BrokeAndSet("RC1",0,ply)
        BrokeAndSet("RUM",0,ply)
        BrokeAndSet("UOS",1,ply)
        BrokeAndSet("OVT",train.KPVU and 0 or 1,ply)
        BrokeAndSet("VAH",1,ply)
        BrokeAndSet("RC2",0,ply)
        BrokeAndSet("VAU",0,ply)
        BrokeAndSet("RUM",0,ply)
        BrokeAndSet("RCARS",0,ply)
        BrokeAndSet("RCAV3",0,ply)
        BrokeAndSet("RCAV4",0,ply)
        BrokeAndSet("RCAV5",0,ply)
        BrokeAndSet("UAVA",1,ply)
        BrokeAndSet("SAP26",1,ply)
        BrokeAndSet("SAP24",1,ply)
        BrokeAndSet("RC",0,ply)
        BrokeAndSet("SA8",1,ply)
        BrokeAndSet("SB6",1,ply)
        BrokeAndSet("PB",1,ply)
    end)
    net.Receive("metrostroi_expel_passengers",function(_,ply)
        if not IsValid(ply) then return end
        local train = ply:GetTrain()
        if not IsValid(train) or not train.WagonList or (train.CPPICanPickup and not train:CPPICanPickup(ply)) then return end

        for k,t in pairs(train.WagonList) do t.AnnouncementToLeaveWagon = true end
    end,nil,"Expel passengers from train")
    return
end
concommand.Add("metrostroi_expel_passengers",function()
    net.Start("metrostroi_expel_passengers") net.SendToServer()
end,nil,"Expel passengers from train")

CreateClientConVar("metrostroi_language","",true,true)
CreateClientConVar("metrostroi_language_softreload",0,true)

CreateClientConVar("metrostroi_stop_helper",0,true)

CreateClientConVar("metrostroi_drawdebug",0,true)
CreateClientConVar("metrostroi_drawsignaldebug",0,true)
CreateClientConVar("metrostroi_drawcams",1,true)
CreateClientConVar("metrostroi_cabfov",75,true)
CreateClientConVar("metrostroi_cabz",0,true)
CreateClientConVar("metrostroi_disablecamaccel",0,true)
CreateClientConVar("metrostroi_disablehovertext",0,true)
CreateClientConVar("metrostroi_disablehovertextpos",0,true)
CreateClientConVar("metrostroi_debugger_data_timeout",2,true,false)

CreateClientConVar("metrostroi_disablehud",0,true)
CreateClientConVar("metrostroi_renderdistance",1024,true)
CreateClientConVar("metrostroi_signal_distance",8192,true)
CreateClientConVar("metrostroi_screenshotmode",0,true)
CreateClientConVar("metrostroi_disableseatshadows",0,true)
CreateClientConVar("metrostroi_softdrawmultipier",100,true)

CreateClientConVar("metrostroi_route_number",61,true,true)
CreateClientConVar("metrostroi_shadows1",1,true)
CreateClientConVar("metrostroi_shadows2",1,true)
CreateClientConVar("metrostroi_shadows3",0,true)
CreateClientConVar("metrostroi_shadows4",0,true)
CreateClientConVar("metrostroi_sprites",1,true)
CreateClientConVar("metrostroi_minimizedshow",0,true)
local function reload()
    --Metrostroi.ReloadClientside = true
end
cvars.AddChangeCallback("metrostroi_shadows1",reload,"reload_shadows")
cvars.AddChangeCallback("metrostroi_shadows2",reload,"reload_shadows")
CreateClientConVar("metrostroi_tooltip_delay",0,true)

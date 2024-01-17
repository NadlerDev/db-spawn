RegisterCommand("spawn", function()
    TriggerEvent("db-spawn:client:Setup")
end)

RegisterNetEvent("db-spawn:client:Setup")
AddEventHandler("db-spawn:client:Setup", function()
    SendNUIMessage({ setup = true, locations = Config.Locations })
    Wait(100)
    SetNuiFocus(true, true)
    SendNUIMessage({ show = true })
end)

------------------------ DreamBox Development | https://discord.gg/dYUyXcFVwQ ------------------------

RegisterNUICallback("Preview", function(data)
    local Position = Config.Locations[data.location].coords
    PreviewSpawn(Position)
end)

------------------------ DreamBox Development | https://discord.gg/dYUyXcFVwQ ------------------------

RegisterNUICallback("Spawn", function(data)
    SetNuiFocus(false, false)
    SendNUIMessage({show = false})
    local Spawn = Config.Locations[data.spawn].coords
    SpawnPlayer(Spawn)
end)

------------------------ DreamBox Development | https://discord.gg/dYUyXcFVwQ ------------------------

function SpawnPlayer(Location)
    local Position = Location
    local Ped = PlayerPedId()
    DoScreenFadeOut(500)
    SetEntityCoords(Ped, Position.x, Position.y, Position.z)
    SetEntityCoords(Ped, Position.x, Position.y, Position.z)
    FreezeEntityPosition(Ped, false)
    RenderScriptCams(false, true, 500, true, true)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    SetCamActive(cam2, false)
    DestroyCam(cam2, true)
    SetEntityVisible(GetPlayerPed(-1), true)
    DoScreenFadeIn(250)
    SetNuiFocus(false, false)
end

function PreviewSpawn(Position)
    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Position.x, Position.y, Position.z + 1500, 300.00,0.00,0.00, 110.00, false, 0)
    PointCamAtCoord(cam2, Position.x, Position.y, Position.z + 75)
    SetCamActiveWithInterp(cam2, cam, 500, true, true)
    if DoesCamExist(cam) then DestroyCam(cam, true) end
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Position.x, Position.y, Position.z + 50, 300.00,0.00,0.00, 110.00, false, 0)
    PointCamAtCoord(cam, Position.x, Position.y, Position.z + 0)
    SetCamActiveWithInterp(cam, cam2, 1000, true, true)
    SetEntityCoords(GetPlayerPed(-1), Position.x, Position.y, Position.z)
end

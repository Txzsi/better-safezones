---@diagnostic disable: missing-parameter
local alert = false

Citizen.CreateThread(function()
    while true do
        local idle = 800
        local ped = GetPlayerPed(-1)
        local pedCoords = GetEntityCoords(ped)
        local zoneBypass = safezoneBypass()
        if (not zoneBypass) then
            for k, v in pairs(config.locations) do
                local distance = GetDistanceBetweenCoords(pedCoords.x, pedCoords.y, pedCoords.z, v.xyz)
                if (distance <= config.distance) then
                    notify(config.text.enteredZone)
                    idle = 0
                    enteredZone()
                    DisableControlAction(0, 24, true)
                    DisableControlAction(0, 257, true)
                    DisableControlAction(0, 263, true)
                    DisableControlAction(0, 264, true)
                    DisableControlAction(0, 257, true)
                    DisableControlAction(0, 140, true)
                    DisableControlAction(0, 141, true)
                    DisableControlAction(0, 142, true)
                    DisableControlAction(0, 143, true)
                    DisableControlAction(0, 81, true)
                    SetPlayerCanDoDriveBy(ped, false)
                    Draw(config.text.displayText, config.text.screenCoords.x, config.text.screenCoords.y, config.text.textSize, 8)
                    if (IsPedInAnyVehicle(ped) and config.reduceVehicleSpeed) then
                        local vehicle = GetVehiclePedIsIn(ped, false)
                        SetEntityMaxSpeed(vehicle, (config.vehicleSpeed / 2.236936))
                    end
                else
                    local Vehicle = GetVehiclePedIsIn(ped, false)
                    SetEntityMaxSpeed(Vehicle, GetVehicleHandlingFloat(Vehicle, "CHandlingData", "fInitialDriveMaxFlatVel"))
                    alert = false
                end
            end
        end
        Citizen.Wait(idle)
    end
end)

function safezoneBypass()
    local bypass = false
    if (config.framework.enabled) then
        local PlyId = GetPlayerServerId(PlayerId())
        local Framework = exports[config.framework.resourceName]:getclientdept(PlyId)
        for k, v in pairs(config.framework.bypassLevels) do
            if (v == Framework[PlyId].level) then
                bypass = true
                break;
            end
        end
    end
    return bypass
end

function enteredZone()
    if (not alert) then
        notify(config.text.enteredZone)
        alert = true
    end
end

function Draw(text, x, y, scale, font)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextOutline()
    SetTextJustification(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

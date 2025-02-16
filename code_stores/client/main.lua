local Config = Config
ESX = exports[Config.BaseName]:getSharedObject()

local PlayerData = ESX.GetPlayerData()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

local isStoreOpen = false
local hasShownText = false
local lastPressTime = 0

RegisterNetEvent("core:toggleStore")
AddEventHandler("core:toggleStore", function(items)
    if isStoreOpen then
        SendNUIMessage({ action = "hideUI" })
        SetNuiFocus(false, false)
        isStoreOpen = false
    else
        SendNUIMessage({ action = "showUI", items = items })
        SetNuiFocus(true, true)
        isStoreOpen = true
    end
end)

RegisterNUICallback("closeStore", function(_, cb)
    SetNuiFocus(false, false)
    isStoreOpen = false 
    cb("ok")
end)

RegisterNUICallback("sendNotification", function(data)
    lib.notify({
        title = data.title,
        description = data.description,
        type = data.type,
        position = 'top',
    })
end)

RegisterNetEvent("sendNotification")
AddEventHandler("sendNotification", function(data)
    lib.notify({
        title = data.title,
        description = data.description,
        type = data.type,
        position = 'top',
    })
end)

RegisterNetEvent("core:receiveStoreItems")
AddEventHandler("core:receiveStoreItems", function(items)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "loadStoreItems",
        items = items
    })
end)

RegisterNUICallback("processPurchase", function(data, cb)
    TriggerServerEvent("core:processPurchase", data.itemId, data.quantity, data.totalPrice)
    cb("ok")
end)

CreateThread(function()
    while true do
        Wait(0)
        local playerCoords = GetEntityCoords(cache.ped)
        local closestLocation, closestDist = nil, 5
        
        for _, location in pairs(Config.Locations) do
            local distance = #(playerCoords - vector3(location.x, location.y, location.z))
            if distance < closestDist then
                closestLocation, closestDist = location, distance
            end
        end
        
        if closestLocation then
            DrawMarker(6, closestLocation.x, closestLocation.y, closestLocation.z - 1.0, 0, 0, 180.0, 0, 0, 0, 1.0, 1.0, 1.0, 
                Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, 
                false, false, 2, false, nil, nil, false
            )
            if closestDist < 0.7 then
                if not hasShownText then
                    lib.showTextUI(Config.TextUIMessage)
                    hasShownText = true
                end
                
                if IsControlJustReleased(0, 38) and (GetGameTimer() - lastPressTime) > 500 then
                    lastPressTime = GetGameTimer()
                    if not isStoreOpen then
                        TriggerEvent("core:toggleStore", Config.StoreItems)
                    end
                end
            end
        else
            if hasShownText then
                lib.hideTextUI()
                hasShownText = false
            end
            Wait(350)
        end
    end
end)

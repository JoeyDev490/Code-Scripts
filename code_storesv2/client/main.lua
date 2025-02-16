local Config = Config
ESX = exports[Config.BaseName]:getSharedObject()
local PlayerData = ESX.GetPlayerData()

local isStoreOpen = false
local lastPressTime = 0
local hasShownText = false

-- Function to create blips on the map
CreateThread(function()
    if Config.BlipSettings.enabled then
        for _, location in pairs(Config.Locations) do
            local blip = AddBlipForCoord(location.x, location.y, location.z)
            SetBlipSprite(blip, Config.BlipSettings.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, Config.BlipSettings.scale)
            SetBlipColour(blip, Config.BlipSettings.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.BlipSettings.name)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

-- Store Marker and Interaction Logic
CreateThread(function()
    local sleepTime = 500
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
            -- Draw Store Marker
            DrawMarker(6, closestLocation.x, closestLocation.y, closestLocation.z - 1.0, 0, 0, 180.0, 0, 0, 0, 1.0, 1.0, 1.0, 
                Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, 
                false, false, 2, false, nil, nil, false
            )

            -- Show Text UI When Close to the Marker
            if closestDist < 0.7 then
                if not hasShownText then
                    lib.showTextUI(Config.TextUIMessage)
                    hasShownText = true
                end

                -- Press E to Open Store UI
                if IsControlJustReleased(0, 38) and (GetGameTimer() - lastPressTime) > 500 then
                    lastPressTime = GetGameTimer()
                    if not isStoreOpen then
                        TriggerServerEvent("store:getItems") -- Request items from the server
                        SendNUIMessage({ action = "toggleStore" })
                        SetNuiFocus(true, true)
                        isStoreOpen = true
                    end
                end
            else
                if hasShownText then
                    lib.hideTextUI()
                    hasShownText = false
                end
            end
        else
            sleepTime = 500
            if hasShownText then
                lib.hideTextUI()
                hasShownText = false
            end
            Wait(500)
        end
    end
end)

-- NUI Callbacks
RegisterNUICallback("closeUI", function(_, cb)
    SetNuiFocus(false, false)
    isStoreOpen = false
    cb("ok")
end)

RegisterNUICallback("purchaseItem", function(data, cb)
    TriggerServerEvent("store:purchaseItem", data.name, data.id, tonumber(data.quantity), tonumber(data.price))
    cb("ok")
end)

RegisterNetEvent("store:notify")
AddEventHandler("store:notify", function(title, description, type)
    lib.notify({
        title = title,
        description = description,
        type = type
    })
end)

RegisterNetEvent("store:receiveItems")
AddEventHandler("store:receiveItems", function(items)
    SendNUIMessage({
        action = "setItems",
        items = items
    })
end)

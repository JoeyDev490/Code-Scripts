local Config = Config
ESX = exports[Config.BaseName]:getSharedObject()

RegisterNUICallback("getPlayerID", function(data, cb)
    cb({ id = GetPlayerServerId(PlayerId()) })
end)


local scoreboardVisible = false

RegisterCommand("toggleScoreboard", function()
    scoreboardVisible = not scoreboardVisible
    SendNUIMessage({ action = scoreboardVisible and "showscoreboard" or "hidescoreboard" })
    SetNuiFocus(scoreboardVisible, scoreboardVisible)

    if scoreboardVisible then
        ESX.TriggerServerCallback("scoreboard:getPlayers", function(players)
            SendNUIMessage({ action = "updatePlayers", players = players })
        end)
        TriggerServerEvent("scoreboard:requestPlayerName") -- Request player name
        TriggerServerEvent("scoreboard:requestPlayerID")   -- Request player ID
    end
end, false)

RegisterKeyMapping('toggleScoreboard', 'Scoreboard', 'keyboard', 'f10')

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)
--         if IsControlJustPressed(0, 57) then -- F10 Key
--             ExecuteCommand("toggleScoreboard")
--         end
--     end
-- end)

RegisterNUICallback("getPlayers", function(data, cb)
    ESX.TriggerServerCallback("scoreboard:getPlayers", function(players)
        cb({ players = players })
    end)
end)

RegisterNUICallback("hideScoreboard", function(data, cb)
    SendNUIMessage({ action = "hidescoreboard" })
    SetNuiFocus(false, false)
    scoreboardVisible = false
    cb("ok")
end)

RegisterNetEvent("scoreboard:updatePlayers")
AddEventHandler("scoreboard:updatePlayers", function(players)
    SendNUIMessage({ action = "updatePlayers", players = players })
end)

RegisterNetEvent("scoreboard:updatePlayerAvatar")
AddEventHandler("scoreboard:updatePlayerAvatar", function(avatarUrl)
    SendNUIMessage({ action = "updateAvatar", avatar = avatarUrl })
end)

RegisterNetEvent("scoreboard:updatePlayerName")
AddEventHandler("scoreboard:updatePlayerName", function(playerName)
    SendNUIMessage({ action = "updatePlayerName", name = playerName })
end)

RegisterNetEvent("scoreboard:updatePlayerID")
AddEventHandler("scoreboard:updatePlayerID", function(playerID)
    SendNUIMessage({ action = "updatePlayerID", id = playerID })
end)

RegisterNetEvent("receiveJobTitle")
AddEventHandler("receiveJobTitle", function(jobTitle)
    SendNUIMessage({
        action = "updateJobTitle",
        jobTitle = jobTitle
    })
end)

-- Request the Job Title on Resource Start
Citizen.CreateThread(function()
    TriggerServerEvent("getJobTitle")
end)

RegisterNetEvent("receiveConnectionImage")
AddEventHandler("receiveConnectionImage", function(connectionImage)
    SendNUIMessage({
        action = "updateConnectionImage",
        connectionImage = connectionImage
    })
end)

-- Request the Connection Image on Resource Start
Citizen.CreateThread(function()
    TriggerServerEvent("getConnectionImage")
end)



local Config = Config
ESX = exports[Config.BaseName]:getSharedObject()

local function getDiscordID(player)
    for _, id in ipairs(GetPlayerIdentifiers(player)) do
        if string.find(id, "discord:") then
            return id:gsub("discord:", "")
        end
    end
    return nil
end

local function getDiscordAvatar(discordId, cb)
    local apiUrl = ("https://discord.com/api/users/%s"):format(discordId)
    local headers = {
        ["Authorization"] = "Bot " .. Config.token,
        ["Content-Type"] = "application/json"
    }

    PerformHttpRequest(apiUrl, function(statusCode, response, headers)
        if statusCode == 200 then
            local data = json.decode(response)
            if data and data.avatar then
                cb(("https://cdn.discordapp.com/avatars/%s/%s.png"):format(discordId, data.avatar))
            else
                cb("https://cdn.discordapp.com/embed/avatars/0.png")
            end
        else
            cb("https://cdn.discordapp.com/embed/avatars/0.png")
        end
    end, "GET", "", headers)
end

RegisterServerEvent("scoreboard:requestPlayerName")
AddEventHandler("scoreboard:requestPlayerName", function()
    local playerSource = source
    local playerName = GetPlayerName(playerSource)
    TriggerClientEvent("scoreboard:updatePlayerName", playerSource, playerName)
end)


ESX.RegisterServerCallback("scoreboard:getPlayers", function(source, cb)
    local players = {}
    local playerCount = 0
    local playerSource = source
    local playerDiscordID = getDiscordID(playerSource)

    for _, playerId in ipairs(GetPlayers()) do
        playerCount = playerCount + 1
        local playerName = GetPlayerName(playerId)
        local playerPing = GetPlayerPing(playerId)
        local xPlayer = ESX.GetPlayerFromId(playerId)
        local playerGroup = xPlayer and xPlayer.getGroup() or "Unknown"
        local playerJob = xPlayer and xPlayer.job.name or "Unemployed"
        local discordId = getDiscordID(playerId)

        local function addPlayer(avatarUrl)
            table.insert(players, {
                id = playerId,
                name = playerName,
                ping = playerPing,
                group = playerGroup,
                job = playerJob,
                avatar = avatarUrl
            })

            if #players == playerCount then
                cb(players, playerDiscordID)
            end
        end

        if discordId then
            getDiscordAvatar(discordId, addPlayer)
        else
            addPlayer("https://cdn.discordapp.com/embed/avatars/0.png")
        end
    end

    if playerDiscordID then
        getDiscordAvatar(playerDiscordID, function(avatarUrl)
            TriggerClientEvent("scoreboard:updatePlayerAvatar", playerSource, avatarUrl)
        end)
    end
end)

RegisterServerEvent("scoreboard:requestPlayerID")
AddEventHandler("scoreboard:requestPlayerID", function()
    local playerSource = source
    local playerID = playerSource -- Fix: Use `source` directly for player ID


    TriggerClientEvent("scoreboard:updatePlayerID", playerSource, playerID)
end)

RegisterNetEvent("getJobTitle")
AddEventHandler("getJobTitle", function()
    local src = source
    TriggerClientEvent("receiveJobTitle", src, Config.JobTitle)
end)

RegisterNetEvent("getConnectionImage")
AddEventHandler("getConnectionImage", function()
    local src = source
    TriggerClientEvent("receiveConnectionImage", src, Config.ConnectionImage)
end)

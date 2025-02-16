RegisterNetEvent("getDiscordID")
AddEventHandler("getDiscordID", function()
    local src = source
    local discordID = nil

    for _, id in ipairs(GetPlayerIdentifiers(src)) do
        if string.match(id, "discord:") then
            discordID = string.gsub(id, "discord:", "")
            break
        end
    end

    if discordID then
        print("Player Discord ID: " .. discordID)
        TriggerClientEvent("receiveDiscordID", src, discordID)
    else
        print("No Discord ID found for player " .. GetPlayerName(src))
    end
end)

function getDiscordID(src)
    for _, id in ipairs(GetPlayerIdentifiers(src)) do
        if string.match(id, "discord:") then
            return string.gsub(id, "discord:", "")
        end
    end
    return nil
end

function getUserDiscordInfo(targetSrc, cb)
    local discordID = getDiscordID(targetSrc)
    if not discordID then
        print("No Discord ID found for player ID " .. targetSrc)
        cb(nil, nil, nil)
        return
    end

    local url = ("https://discord.com/api/guilds/%s/members/%s"):format(Config.guildId, discordID)
    local headers = {
        ["Authorization"] = "Bot " .. Config.token,
        ["Content-Type"] = "application/json"
    }

    PerformHttpRequest(url, function(statusCode, response, _)
        if statusCode == 200 then
            local data = json.decode(response)
            local discordName = data.user and data.user.username or "Unknown"
            local avatarHash = data.user and data.user.avatar or nil
            local avatarURL = avatarHash and ("https://cdn.discordapp.com/avatars/%s/%s.png"):format(discordID, avatarHash) or "https://cdn.discordapp.com/embed/avatars/0.png"
            cb(discordName, avatarURL, data.roles)
        else
            print("Failed to fetch Discord info, Status Code: " .. statusCode)
            cb(nil, nil, nil)
        end
    end, "GET", "", headers)
end

function getAllRoles(cb)
    local url = ("https://discord.com/api/guilds/%s/roles"):format(Config.guildId)
    local headers = {
        ["Authorization"] = "Bot " .. Config.token,
        ["Content-Type"] = "application/json"
    }

    PerformHttpRequest(url, function(statusCode, response, _)
        if statusCode == 200 then
            local data = json.decode(response)
            local roleMap = {}

            for _, role in ipairs(data) do
                if role.icon then
                    roleMap[role.id] = ("<img src='https://cdn.discordapp.com/role-icons/%s/%s.png' width='16' height='16' style='vertical-align: middle; margin-right: 4px;'> %s"):format(role.id, role.icon, role.name)
                else
                    roleMap[role.id] = role.name
                end
            end

            cb(roleMap)
        else
            print("Failed to fetch all roles, Status Code: " .. statusCode)
            cb(nil)
        end
    end, "GET", "", headers)
end

RegisterCommand("who", function(source, args, rawCommand)
    local targetSrc = tonumber(args[1]) or source
    if not GetPlayerName(targetSrc) then
        TriggerClientEvent("sendChatMessage", source, "Invalid player ID")
        return
    end

    getUserDiscordInfo(targetSrc, function(discordName, avatarURL, userRoles)
        if not discordName or not userRoles then
            TriggerClientEvent("sendChatMessage", source, "No Discord data found for player ID " .. targetSrc)
            return
        end

        getAllRoles(function(roleMap)
            if not roleMap then
                TriggerClientEvent("sendChatMessage", source, "Failed to retrieve server roles.")
                return
            end

            local roleNames = {}
            for _, roleId in ipairs(userRoles) do
                if roleMap[roleId] then
                    table.insert(roleNames, roleMap[roleId])
                end
            end

            local roleMessage = #roleNames > 0 and table.concat(roleNames, ", ") or "Inga roller"

            -- Use Config to generate chat message
            local chatMessage = ('<div style="padding: %s; font-size: %s; background-color: %s; border-radius: %s; width: %s; display: flex; align-items: center;">'
                .. '<img src="%s" height="%s" width="%s" style="border-radius: %s; margin-left: 1%%;"></img>'
                .. '<text style="margin-left: 1.5%%;"><b>%s</b> (ID: %s) | <span style="color: %s;">Har Roller:</span> %s</text></div>')
                :format(
                    Config.Chat.padding, Config.Chat.fontSize, Config.Chat.backgroundColor, Config.Chat.borderRadius, Config.Chat.width,
                    avatarURL, Config.Chat.avatarSize, Config.Chat.avatarSize, Config.Chat.avatarBorderRadius,
                    discordName, targetSrc, Config.Chat.textColor, roleMessage
                )

            TriggerClientEvent("sendChatMessage", source, chatMessage)
        end)
    end)
end, false)
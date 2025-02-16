local Config = Config

ESX = exports[Config.BaseName]:getSharedObject()

RegisterNetEvent("receiveDiscordID")
AddEventHandler("receiveDiscordID", function(discordID)
    print("Your Discord ID: " .. discordID)
end)

TriggerServerEvent("getDiscordID")

RegisterNetEvent("receiveRoles")
AddEventHandler("receiveRoles", function(discordName, playerId, avatarURL, roleNames)
    if #roleNames > 0 then
        print(discordName .. " (ID " .. playerId .. ") has the roles: " .. table.concat(roleNames, ", "))
    else
        print(discordName .. " (ID " .. playerId .. ") has no Discord roles.")
    end
    print("Discord Profile Picture: " .. avatarURL)
end)

RegisterNetEvent("sendChatMessage")
AddEventHandler("sendChatMessage", function(message)
    TriggerEvent("chat:addMessage", {
        template = message,
        args = {}
    })
end)


RegisterNetEvent("roleCheckResult")
AddEventHandler("roleCheckResult", function(hasRole, roleName)
    if hasRole then
        print("You have the role: " .. roleName)
    else
        print("You do NOT have the role: " .. roleName)
    end
end)


AddEventHandler('gameEventTriggered', function(name, args)
    if name == 'CEventNetworkEntityDamage' then
        local victim = args[1]
        local attacker = args[2]

        if victim and attacker and IsPedAPlayer(attacker) then
            local attackerId = NetworkGetPlayerIndexFromPed(attacker)

            if attackerId == PlayerId() then
                local victimName = "NPC"


                if IsPedAPlayer(victim) then
                    local victimId = NetworkGetPlayerIndexFromPed(victim)
                    victimName = GetPlayerName(victimId)
                end

                if IsEntityDead(victim) then

                    SendNUIMessage({
                        action = 'showKillMessage',
                        name = victimName
                    })
                end
            end
        end
    end
end)


function FindPlayerByName(targetName)
    for _, playerId in ipairs(GetActivePlayers()) do
        if GetPlayerName(playerId) == targetName then
            return playerId
        end
    end
    return nil
end

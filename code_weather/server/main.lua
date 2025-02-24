local function getWeatherType(condition)
    local lowerCondition = string.lower(condition)
    if lowerCondition:find("clear") or lowerCondition:find("sunny") then
        return "EXTRASUNNY"
    elseif lowerCondition:find("cloud") or lowerCondition:find("overcast") then
        return "CLOUDS"
    elseif lowerCondition:find("rain") or lowerCondition:find("drizzle") then
        return "RAIN"
    elseif lowerCondition:find("thunder") then
        return "THUNDER"
    elseif lowerCondition:find("snow") then
        return "SNOW"
    elseif lowerCondition:find("fog") or lowerCondition:find("mist") then
        return "FOGGY"
    else
        return "EXTRASUNNY"
    end
end

local function updateWeather()
    local url = "https://wttr.in/" .. Config.City .. "?format=%C"
    PerformHttpRequest(url, function(statusCode, response, headers)
        if statusCode == 200 and response then
            local weatherType = getWeatherType(response)
            print("Fetched weather condition: " .. response .. " -> Setting in-game weather to: " .. weatherType)
            TriggerClientEvent('updateWeather', -1, weatherType)
        else
            print("Error retrieving weather data.")
        end
    end, "GET", "", {})
end

updateWeather()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(600000) -- 10 minuter
        updateWeather()
    end
end)
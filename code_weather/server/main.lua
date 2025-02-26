local function getWeatherType(condition)
    local lowerCondition = string.lower(condition)
    if lowerCondition:find("clear") or lowerCondition:find("sunny") then
        return "EXTRASUNNY"
    elseif lowerCondition:find("partly cloudy") or lowerCondition:find("cloud") or lowerCondition:find("overcast") then
        return "CLOUDS"
    elseif lowerCondition:find("rain") or lowerCondition:find("drizzle") then
        return "RAIN"
    elseif lowerCondition:find("thunder") or lowerCondition:find("storm") then
        return "THUNDER"
    elseif lowerCondition:find("snow") or lowerCondition:find("sleet") or lowerCondition:find("blizzard") then
        return "SNOW"
    elseif lowerCondition:find("fog") or lowerCondition:find("mist") or lowerCondition:find("haze") then
        return "FOGGY"
    elseif lowerCondition:find("windy") or lowerCondition:find("breeze") then
        return "OVERCAST"
    elseif lowerCondition:find("smoke") or lowerCondition:find("dust") or lowerCondition:find("sandstorm") then
        return "SMOG"
    else
        return "EXTRASUNNY"
    end
end

local function updateWeather()
    local url = "https://wttr.in/" .. Config.City .. "?format=%C+%t+%w"
    PerformHttpRequest(url, function(statusCode, response, headers)
        if statusCode == 200 and response then
            local condition, temperature, windSpeed = response:match("([^%s]+) ([^%s]+) ([^%s]+)")
            if condition then
                local weatherType = getWeatherType(condition)
                print("Weather: " .. condition .. " | Temp: " .. temperature .. " | Wind: " .. windSpeed .. " | Setting in-game weather: " .. weatherType)
                TriggerClientEvent('updateWeather', -1, weatherType, temperature, windSpeed)
            else
                print("Error parsing weather data: " .. response)
            end
        else
            print("Error retrieving weather data. Status code: " .. statusCode)
        end
    end, "GET", "", {})
end

updateWeather()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(600000) -- Uppdaterar var 10:e minut
        updateWeather()
    end
end)

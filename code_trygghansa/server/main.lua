function PrintAllPlatesAndIdentifiers()
    local result = MySQL.query.await("SELECT plate, identifier, insured FROM owned_vehicles")
    if result then
        for _, row in ipairs(result) do
            local user = MySQL.query.await("SELECT firstname, lastname FROM users WHERE identifier = ?", {row.identifier})
            local name = user[1] and (user[1].firstname .. " " .. user[1].lastname) or "Unknown"
            local insured = row.insured == "yes" and "Yes" or "No"
            print("Plate: " .. row.plate .. " | Identifier: " .. row.identifier .. " | Name: " .. name .. " | Insured: " .. insured)
        end
    end
end

RegisterNetEvent("requestPlatesData")
AddEventHandler("requestPlatesData", function()
    local src = source
    local result = MySQL.query.await("SELECT plate, identifier, insured FROM owned_vehicles")
    local vehicles = {}

    if result then
        for _, row in ipairs(result) do
            local user = MySQL.query.await("SELECT firstname, lastname FROM users WHERE identifier = ?", {row.identifier})
            local name = user[1] and (user[1].firstname .. " " .. user[1].lastname) or "Unknown"
            local insured = row.insured == "yes"

            table.insert(vehicles, { plate = row.plate, owner = name, insured = insured })
        end
    end

    TriggerClientEvent("sendPlatesData", src, vehicles)
end)

-- Add Insurance
RegisterNetEvent("updateVehicleInsurance")
AddEventHandler("updateVehicleInsurance", function(plate)
    local result = MySQL.query.await("SELECT insured FROM owned_vehicles WHERE plate = ?", {plate})

    if result and #result > 0 then
        if result[1].insured == "yes" then
            return
        end

        MySQL.query.await("UPDATE owned_vehicles SET insured = ? WHERE plate = ?", {"yes", plate})
    end
end)

-- Remove Insurance
RegisterNetEvent("removeVehicleInsurance")
AddEventHandler("removeVehicleInsurance", function(plate)
    local result = MySQL.query.await("SELECT insured FROM owned_vehicles WHERE plate = ?", {plate})

    if result and #result > 0 then
        if result[1].insured == "no" then
            return
        end

        MySQL.query.await("UPDATE owned_vehicles SET insured = ? WHERE plate = ?", {"no", plate})
    end
end)


-- RegisterCommand("plates", function(source)
--     PrintAllPlatesAndIdentifiers()
-- end, false)

-- CreateThread(function()
--     local resourceName = GetCurrentResourceName()

--     if resourceName ~= "ab_trygghansa" then
--         print("^1[ERROR] Resource folder must be named 'ab_trygghansa'. Server shutting down...^0")
--         os.exit() -- Shuts down the server
--     end
-- end)

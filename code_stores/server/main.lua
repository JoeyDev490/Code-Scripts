ESX = exports[Config.BaseName]:getSharedObject()

RegisterNetEvent("core:openStore")
AddEventHandler("core:openStore", function()
    local source = source
    local items = {}

    for _, item in ipairs(Config.StoreItems) do
        local imagePath = item.image or (Config.inventory .. item.id .. ".png")

        table.insert(items, {
            name = item.name,
            price = item.price,
            id = item.id,
            min = item.min,
            max = item.max,
            default = item.default,
            image = imagePath
        })
    end

    TriggerClientEvent("core:receiveStoreItems", source, items)
end)


RegisterCommand("store", function(source)
    local items = Config.StoreItems
    TriggerClientEvent("core:toggleStore", source, items)
end, false)


RegisterNetEvent("core:processPurchase")
AddEventHandler("core:processPurchase", function(itemId, quantity, totalPrice)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    local item = xPlayer.getInventoryItem(itemId)

    local storeItem = nil
    for _, i in ipairs(Config.StoreItems) do
        if i.id == itemId then
            storeItem = i
            break
        end
    end

    if not storeItem then
        TriggerClientEvent("sendNotification", source, {
            title = "Store",
            description = "Invalid item selected.",
            type = "error"
        })
        return
    end

    if item and item.count >= storeItem.max then
        -- print("[DEBUG] Player already has max " .. storeItem.name) -- Debugging
        TriggerClientEvent("sendNotification", source, {
            title = "Store",
            description = "You already own the maximum allowed amount of " .. storeItem.name .. "!",
            type = "error"
        })
        return
    end

    if xPlayer.getMoney() >= totalPrice then
        xPlayer.removeMoney(totalPrice)
        xPlayer.addInventoryItem(itemId, quantity)

        TriggerClientEvent("sendNotification", source, {
            title = "Store",
            description = "You purchased " .. quantity .. "x " .. storeItem.name .. " for $" .. totalPrice .. "!",
            type = "success"
        })
    else
        TriggerClientEvent("sendNotification", source, {
            title = "Store",
            description = "You don't have enough money to purchase this item!",
            type = "error"
        })
    end
end)
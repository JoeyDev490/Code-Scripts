local Config = Config
ESX = exports[Config.BaseName]:getSharedObject()

RegisterNetEvent("store:purchaseItem")
AddEventHandler("store:purchaseItem", function(itemName, itemid, itemQuantity, itemPrice)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then
        print("^1[ERROR]^0: Failed to get xPlayer (ESX)")
        return
    end

    local itemFound = nil
    for _, item in pairs(Config.StoreItems) do
        if item.id == itemid then
            itemFound = item
            break
        end
    end

    if not itemFound then
        print("^1[ERROR]^0: Attempted to buy an invalid item: " .. itemid)
        TriggerClientEvent("store:notify", src, "Purchase Failed", "Invalid item!", "error")
        return
    end

    local playerItemCount = xPlayer.getInventoryItem(itemid).count or 0

    if playerItemCount >= itemFound.maxQuantity then
        TriggerClientEvent("store:notify", src, "Purchase Failed", "You already have the maximum amount of this item!", "error")
        return
    end

    if itemQuantity < itemFound.minQuantity then
        TriggerClientEvent("store:notify", src, "Purchase Failed", "Invalid quantity!", "error")
        return
    end

    local maxAvailableToBuy = itemFound.maxQuantity - playerItemCount
    if itemQuantity > maxAvailableToBuy then
        TriggerClientEvent("store:notify", src, "Purchase Failed", ("You can only buy %s more of this item!"):format(maxAvailableToBuy), "error")
        return
    end

    local totalPrice = itemPrice * itemQuantity
    local playerMoney = xPlayer.getMoney()

    if playerMoney >= totalPrice then
        xPlayer.removeMoney(totalPrice)
        xPlayer.addInventoryItem(itemid, itemQuantity)

        TriggerClientEvent("store:notify", src, "Purchase Successful", ("You bought %sx %s for $%s"):format(itemQuantity, itemName, totalPrice), "success")
    else
        TriggerClientEvent("store:notify", src, "Purchase Failed", "You do not have enough money!", "error")
    end
end)

RegisterNetEvent("store:getItems")
AddEventHandler("store:getItems", function()
    local src = source
    TriggerClientEvent("store:receiveItems", src, Config.StoreItems)
end)

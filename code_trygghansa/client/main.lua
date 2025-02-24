local Config = Config

ESX = exports[Config.BaseName]:getSharedObject()
Functions = {}

local PlayerData = ESX.GetPlayerData()
local tablet = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterCommand("trygghansa", function()
    local playerData = ESX.GetPlayerData()

    if Config.JobName == "none" or playerData.job.name == Config.JobName then
        SetNuiFocus(true, true)
        SendNUIMessage({ action = "showMessage" })

        TriggerServerEvent("requestPlatesData")

        if Config.Tablet.Enabled then
            local playerPed = cache.ped
            RequestAnimDict(Config.Tablet.Dict)
            while not HasAnimDictLoaded(Config.Tablet.Dict) do
                Citizen.Wait(100)
            end

            TaskPlayAnim(playerPed, Config.Tablet.Dict, Config.Tablet.Anim, 3.0, -8.0, -1, 50, 0, false, false, false)


            if not tablet then
                tablet = CreateObject(Config.Tablet.Prop, 0, 0, 0, true, true, false)
                AttachEntityToEntity(tablet, playerPed, GetPedBoneIndex(playerPed, Config.Tablet.Bone), 
                    Config.Tablet.Offset.x, Config.Tablet.Offset.y, Config.Tablet.Offset.z, 
                    Config.Tablet.Rotation.x, Config.Tablet.Rotation.y, Config.Tablet.Rotation.z, 
                    true, true, false, true, 1, true)
            end
        end

        lib.notify(Config.Notifications.OpenPanel)
    else
        lib.notify(Config.Notifications.NoJobAccess)
    end
end, false)

RegisterCommand('+trygghansa', function()
    local playerData = ESX.GetPlayerData()
    if Config.JobName == "none" or playerData.job.name == Config.JobName then
    lib.showContext('trygghansa_jobmenu')
    end
end)

RegisterKeyMapping('+trygghansa', 'Open Trygghansa Job Menu', 'keyboard', 'F6')

lib.registerContext({
    
    id = 'trygghansa_jobmenu',
    title = 'Trygghansa Jobmenu',
    options = {
      {
        title = 'Open Job Panel',
        description = 'Opens the trygghansa insurance panel',
        icon = 'life-ring',
        onSelect = function()
          ExecuteCommand('trygghansa')
        end,
        metadata = {
          {label = 'Opens Trygghansa Insurance Menu'}
        },
      },        
      }
  })

RegisterNUICallback("closeMenu", function(data, cb)
    SetNuiFocus(false, false)
    local playerPed = cache.ped
    ClearPedTasks(playerPed)
    if tablet then
        DeleteEntity(tablet)
        tablet = false
    end

    lib.notify(Config.Notifications.ClosePanel)
    cb("ok")
end)

RegisterNetEvent("sendPlatesData")
AddEventHandler("sendPlatesData", function(vehicles)
    SendNUIMessage({
        action = "sendPlatesData",
        vehicles = vehicles
    })
end)

RegisterNUICallback("vehicleNotFound", function(data, cb)
    local plate = data.plate or "Unknown"

    local message = Config.Notifications.VehicleNotFound
    message.description = message.description:gsub("{plate}", plate)

    lib.notify(message)
    cb("ok")
end)
RegisterNUICallback("addInsurance", function(data, cb)
    local plate = data.plate
    TriggerServerEvent("updateVehicleInsurance", plate)
    cb("ok")
end)

RegisterNUICallback("removeInsurance", function(data, cb)
    local plate = data.plate
    TriggerServerEvent("removeVehicleInsurance", plate)
    cb("ok")
end)

RegisterNUICallback("alreadyInsured", function(data, cb)
    local plate = data.plate or "Unknown"

    local message = Config.Notifications.AlreadyInsured
    message.description = message.description:gsub("{plate}", plate)

    lib.notify(message)
    cb("ok")
end)

RegisterNUICallback("addedins", function(data, cb)
    local plate = data.plate or "Unknown"

    local message = Config.Notifications.InsuranceAdded
    message.description = message.description:gsub("{plate}", plate)

    lib.notify(message)
    cb("ok")
end)

RegisterNUICallback("removedins", function(data, cb)
    local plate = data.plate or "Unknown"

    local message = Config.Notifications.InsuranceRemoved
    message.description = message.description:gsub("{plate}", plate)

    lib.notify(message)
    cb("ok")
end)

ESX = exports[config.BaseName]:getSharedObject()
local GreenZones = config.GreenZones
local insideGreenzone = false

for _, zoneData in ipairs(GreenZones.Zones) do 
    local coordsList = type(zoneData.coords) == 'table' and zoneData.coords or { zoneData.coords }

    for _, coord in ipairs(coordsList) do
        local zone = lib.points.new(coord, zoneData.radius, { 
            ui = zoneData.showUI or true 
        })

        function zone:onEnter()
            SetCurrentPedWeapon(cache.ped, GetHashKey("WEAPON_UNARMED"), true)
            NetworkSetFriendlyFireOption(false)
            SetLocalPlayerAsGhost(true)
            SetGhostedEntityAlpha(220)

            if self.ui then 
                insideGreenzone = true
                SendNUIMessage({ action = "showGreenzone" })
            end
        end

        function zone:onExit() 
            if not IsPedInAnyVehicle(cache.ped, false) then 
                NetworkSetFriendlyFireOption(true)
                SetLocalPlayerAsGhost(false)
            end

            if self.ui then 
                insideGreenzone = false
                SendNUIMessage({ action = "hideGreenzone" })
            end
        end

        if zoneData.showOnMap then 
            local blip = AddBlipForRadius(coord.x, coord.y, coord.z, zoneData.radius)
            SetBlipHighDetail(blip, true)
            SetBlipColour(blip, 2)
            SetBlipAlpha(blip, 155)
        end
    end
end
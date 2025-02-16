Config = {}

Config.BaseName = "core"

Config.inventory = "nui://inventory/html/img/"

Config.TextUIMessage = "[E] - Open Store"

Config.MarkerColor = { r = 255, g = 0, b = 0, a = 150 }


Config.BlipSettings = {
    enabled = true,
    sprite = 52, 
    color = 1,
    scale = 0.8,
    name = "General Store"
}

Config.StoreItems = {
    { name = "Armour", price = 5000, image = Config.inventory .. "armour.png", id = "armour", min = 1, max = 250, default = 1 },
    { name = "Medkit", price = 2500, image = Config.inventory .. "medkit.png", id = "medkit", min = 2, max = 100, default = 1 },
    { name = "Clip", price = 1500, image = Config.inventory .. "clip.png", id = "clip", min = 1, max = 100, default = 1 },
    { name = "Tunerchip", price = 1500, image = Config.inventory .. "tunerchip.png", id = "tunerchip", min = 1, max = 1, default = 1 },
    { name = "Suppressor", price = 1500, image = Config.inventory .. "suppressor.png", id = "suppressor", min = 1, max = 5, default = 1 },
    { name = "RepairKit", price = 1500, image = Config.inventory .. "repairkit.png", id = "repairkit", min = 1, max = 10, default = 1 },
    { name = "Phone", price = 1500, image = Config.inventory .. "phone.png", id = "phone", min = 1, max = 1, default = 1 },
}



Config.Locations = {
    vec3(-48.5179, -1757.6620, 29.4210), -- Davis Avenue [GROVE]
    vec3(25.8664, -1347.9133, 29.4970), -- Strawberry
    vec3(-707.6210, -914.6075, 19.2156), -- Ginger Street
    vec3(-1222.3983, -906.4743, 12.3264), -- Vespucci Canals
    vec3(-1488.1385, -378.9018, 40.1634), -- Morningwood
    vec3(-1820.6632, 792.5426, 138.1148), -- Richman Glen
    vec3(1136.1292, -982.8175, 46.4159), -- Murrieta Heights
    vec3(1163.2271, -323.9810, 69.2050), -- Mirror Park
    vec3(373.9004, 325.4996, 103.5664), -- Downtown Vinewood
    vec3(2557.9800, 382.4533, 108.6229), -- Tataviam Mountains
    vec3(-2967.9060, 391.6733, 15.0433), -- Banham Canyon
    vec3(-3038.7883, 586.2313, 7.9089), -- Inenoso Road
    vec3(-3241.5559, 1001.5074, 12.8307), -- Barbareno Road
    vec3(547.3455, 2671.8093, 42.1566), -- Harmony
    vec3(1165.2738, 2709.0713, 38.1576), -- Grand Senora Dessert
    vec3(2679.3804, 3280.6013, 55.2411), -- Grand Senora Dessert
    vec3(1961.9133, 3740.2139, 32.3437), -- Sandy Shores
    vec3(1393.7982, 3605.3960, 34.9809), -- Sandy Shores
    vec3(1698.2484, 4924.7783, 42.0636), -- Grapeseed
    vec3(1728.8655, 6414.0210, 35.0372), -- Mount Chiliad   
}
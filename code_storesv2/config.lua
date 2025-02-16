Config = {} 
Config.BaseName = "core"

Config.StoreItems = {
    { id = "armour", name = "Armor", price = 10000, image = "https://r2.fivemanage.com/eJuQaZlWXYvPBKVnrGAQq/images/armor.png", minQuantity = 1, maxQuantity = 250 },
    { id = "clip", name = "Ammo Clip", price = 5000, image = "https://r2.fivemanage.com/eJuQaZlWXYvPBKVnrGAQq/images/armor.png", minQuantity = 1, maxQuantity = 10 },
    { id = "medkit", name = "Medkit", price = 7500, image = "https://r2.fivemanage.com/eJuQaZlWXYvPBKVnrGAQq/images/armor.png", minQuantity = 1, maxQuantity = 10 },
    { id = "bandage", name = "Bandage", price = 2000, image = "https://r2.fivemanage.com/eJuQaZlWXYvPBKVnrGAQq/images/armor.png", minQuantity = 1, maxQuantity = 20 }
}

Config.BlipSettings = {
    enabled = true,
    sprite = 52, 
    color = 1,
    scale = 0.8,
    name = "24/7 Store"
}

Config.TextUIMessage = "[E] - Open Store"

Config.MarkerColor = { r = 255, g = 0, b = 0, a = 150 }

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

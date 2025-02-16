
lua54 'yes'

fx_version 'cerulean'
game 'gta5'

author 'Joey, Melonen'
description 'Simple Trygghansa Script'
version '1.0'

shared_scripts {
    "config.lua",
    "@ox_lib/init.lua",
    '@core/imports.lua',
    "configs/main.lua"
}

server_scripts {
    "server/functions.lua",
    '@oxmysql/lib/MySQL.lua',
    "server/main.lua"
}

client_scripts {
    "client/functions.lua",
    "client/main.lua"
}

files({
    "html/index.html",
    "html/assets/*.js",
    "html/assets/*.css"
})

ui_page("html/index.html")

escrow_ignore {
    "config.lua"
}

server_scripts({
    "server/versionchecker.lua"
})
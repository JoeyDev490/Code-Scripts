shared_scripts({
    "@core/imports.lua"
})

lua54 'yes'
version '1.0'
author 'Joey, Melonen'

fx_version "cerulean"
game "gta5"

shared_scripts {
    "config.lua",
    "@ox_lib/init.lua"
}

server_scripts {
    "server/functions.lua",
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

shared_scripts({
    "config.lua"
})

server_scripts({
    "server/versionchecker.lua"
})
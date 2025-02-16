fx_version "cerulean"
game "gta5"
lua54 'yes'

shared_scripts {
    "config.lua"
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
    "configs/main.lua"
})

shared_scripts({
    "shared/locale.lua",
    "locales/*.lua"
})
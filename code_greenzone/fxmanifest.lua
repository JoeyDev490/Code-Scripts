shared_scripts({
    "@core/imports.lua"
})

fx_version 'cerulean'
game 'gta5'

author 'Joey, Melonen'
description 'Greenzone UI!'
version '1.0'

lua54 'yes'

shared_scripts {
    "config.lua",
    "@ox_lib/init.lua"
}

server_scripts {
    "server/functions.lua",
    "server/main.lua",
    "server/version.lua"
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

escrow_ignore {
    "config.lua"
}
fx_version "cerulean"
game "gta5"
author 'Joey, Melonen'
version '1.0'
lua54 'yes'

shared_scripts {
    "config.lua"
}

server_scripts {
    "server/main.lua"
}

client_scripts {
    "client/main.lua"
}

shared_scripts({
    "config.lua"
})

server_scripts({
    "server/versionchecker.lua"
})

escrow_ignore {
    "config.lua"
}
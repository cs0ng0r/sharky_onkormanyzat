fx_version 'cerulean'
game 'gta5'
author 'Csongor'
description 'Önkormányzat script'
version '1.0.0'
lua54 'yes'

client_scripts {
    'client/main.lua'
}

shared_scripts{
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
    'config.lua'
}

server_scripts {
    'server/main.lua'
}
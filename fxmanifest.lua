fx_version 'cerulean'
games { 'gta5' }

author 'takenncs'
description 'Bodycam Police Systems'
version '1.0.2'

lua54 'yes'

shared_scripts {
    'config.lua'
}

client_scripts {
    '@ox_lib/init.lua',
    'client.lua',
}

server_scripts {
    'server.lua',
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/script.js',
}

dependencies {
    'qb-core',
    'ox_lib' 
}

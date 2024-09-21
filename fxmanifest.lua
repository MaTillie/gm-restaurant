fx_version 'cerulean'
game 'gta5'
author 'Gaïus Mancini'
description 'gm-restaurants'
version '0.4'

shared_script {
    'config/*.lua',
    'config.lua',
    '@ox_lib/init.lua',
	'@qbx_core/modules/lib.lua',
    '@qbx_core/shared/locale.lua',
}

client_scripts {
    'config/*.lua',
    'config.lua',
    'client/*.lua',
    'bridge/client.lua',
}

server_scripts {
    'config/*.lua',
    'config.lua',
    'server/*.lua',
    'bridge/server.lua',    
}

ui_page 'web/index.html'

files {
    'web/index.html',
    'web/*.css',
    'web/image/**.**',
    'web/main.js',    
    'config.lua'
}

lua54 'yes'

dependency '/assetpacks'
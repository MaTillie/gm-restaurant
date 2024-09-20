fx_version 'cerulean'
game 'gta5'
author 'Gaïus Mancini'
description 'gm-restaurants'
version '0.4'

shared_script {
    '@ox_lib/init.lua',
	'@qbx_core/modules/lib.lua',
    '@qbx_core/shared/locale.lua',
    'config/*.lua'
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

ui_page 'web/index.html'

files {
    'web/index.html',
    'web/styles.css',
    'web/image/**.**',
    'web/main.js',    
    'config.lua'
}

lua54 'yes'

dependency '/assetpacks'
----------------------------------------------------------------
----                   DUSADEV.TEBEX.IO                    	----
----------------------------------------------------------------
fx_version 'bodacious'
game 'gta5'
author 'dusadev.tebex.io'
description 'Dusa Billing'
version '0.8'

shared_script {"config.lua",
    '@ox_lib/init.lua',
	'@qbx_core/modules/lib.lua',
    '@qbx_core/shared/locale.lua',
}

client_scripts {
    "client/*.lua",
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server/*.lua",
}

ui_page "web/index.html"

files {
    "web/index.html",
    "web/styles.css",
    "web/image/**.**",
    "web/main.js",
}

lua54 'yes'

dependency '/assetpacks'
function getConfig_towngrill()
Config = {}
Config.DebugMode = true


Config.Job = "towngrill"
Config.Ticket = true
Config.TrayLabel = "The Town Grill"

-- Titre de la facture
Config.invoiceWording = "Facture du The Town Grill"

Config.Menu = {
    -- Liste des item 
    -- à la carte si menu = true, sinon ce sont des ingrédients
	["town_ribs"] = {
	price = 50.0,
	menu = true,
	ingredients = {
		["leap_ingredient"] = {amount = 1},
	},
},
["town_tomahawk"] = {
	price = 95.0,
	menu = true,
	ingredients = {
		["leap_ingredient"] = {amount = 1},
	},
},
["town_grillades"] = {
	price = 65.0,
	menu = true,
	ingredients = {
		["leap_ingredient"] = {amount = 1},
	},
},
["town_brochette_tofu"] = {
	price = 50.0,
	menu = true,
	ingredients = {
		["leap_ingredient"] = {amount = 1},
	},
},
["town_poulet_frit"] = {
	price = 55.0,
	menu = true,
	ingredients = {
		["leap_ingredient"] = {amount = 1},
	},
},
["town_burger"] = {
	price = 65.0,
	menu = true,
	ingredients = {
		["leap_ingredient"] = {amount = 1},
	},
},
["town_cheesecake"] = {
	price = 20.0,
	menu = true,
	ingredients = {
		["leap_ingredient"] = {amount = 1},
	},
},
["town_banana_bread"] = {
	price = 20.0,
	menu = true,
	ingredients = {
		["leap_ingredient"] = {amount = 1},
	},
},
["town_carrot_cake"] = {
	price = 20.0,
	menu = true,
	ingredients = {
		["leap_ingredient"] = {amount = 1},
	},
},
["town_butter_tart"] = {
	price = 20.0,
	menu = true,
	ingredients = {
		["leap_ingredient"] = {amount = 1},
	},
},

}



 

Config.Kitchen = {
    [1] ={
        -- Cuisson vec3(-586.97, -277.55, 41.69)
        coords = vec3(1117.45, -634.47, 56.84),
        size = 0.5,
        title = "Préparer",
        duration = 5000,
        items = {
            "town_cheesecake",
			"town_banana_bread",
			"town_carrot_cake",
			"town_butter_tart"
        }
        -- Animation plus tard
    },
    [2] ={
        -- Cuisson vec3(-587.63, -278.46, 41.69)
        coords = vec3(1116.66, -634.66, 56.84),
        size = 0.5,
        title = "Chauffer",
        duration = 5000,
        items = {
            'town_ribs',
			'town_tomahawk',
			'town_grillades',
			'town_brochette_tofu',
			'town_poulet_frit',			
			"town_burger"		
        }
        -- Animation plus tard
    },
}

--# Fridge #--

Config.Fridge = {
    [1] ={
        coords = vec3(1118.35, -638.32, 56.82),
        size = 0.5,
        title = "Frigo",
        duration = 2000,
        items = {
            "leap_ingredient"
        }
        -- Animation plus tard
    },
}

--## Caisse ##--
Config.Carte ={
    [1] ={
        coords = vec3(1122.55, -640.13, 56.7),
        size = 0.7,
        title = "Afficher la carte",
    },
}

--## Delivery ##--

Config.NPCCoords = vec3(-594.76, -285.07, 35.45)
Config.NPCHeading = 227.13

Config.Delivery = {
    [1] = { coords = vec3(-639.91, 296.93, 82.46)}, 
    [2] = { coords = vec3(-1221.67, -329.82, 37.55)}, 
    [3] = { coords = vec3(-668.19, -971.63, 22.34)},
}
return Config
end
Config = {}
Config.DebugMode = true


Config.Job = "hogspub"
Config.Ticket = true
Config.TrayLabel = "Hos's Pub"

-- Titre de la facture
Config.invoiceWording = "Facture du Hog's Pub"

Config.Menu = {
    -- Liste des item 
    -- à la carte si menu = true, sinon ce sont des ingrédients
    ["fishnchips"] = {
        price = 20.0,
        menu = true,
        ingredients = {
            ["hogspub_fishmeatcooked"] = {amount = 1},
            ["hogspub_cuttedpotato"] = {amount = 1},
        },
    },
    ["bierreobeurre"] = {
        menu = true,
        price = 15.0,
        ingredients = {},
    },
    ["polynectar"] = {
        menu = true,
        price = 10.0,
        ingredients = {},
    },
    ["jusdecitrouille"] = {
        menu = true,
        price = 10.0,
        ingredients = {},
    },
    ["hogspub_cuttedpotato"] = {
        menu = false,
        price = 0,
        ingredients = {
            ["hogspub_potato"] = {amount = 1},
        },
    },
    ["bubblensqueak"] = {
        price = 20.0,
        menu = true,
        ingredients = {
            ["hogspub_cabbage"] = {amount = 1},
            ["hogspub_eggcooked"] = {amount = 1},
            ["hogspub_potato"] = {amount = 1},
        },
    },
    ["chickenpie"] = {
        price = 20.0,
        menu = true,
        ingredients = {
            ["hogspub_chickenmeatcooked"] = {amount = 1},
            ["hogspub_flour"] = {amount = 1},
        },
    },
    ["chocolapin"] = {
        price = 6.0,
        menu = true,
        ingredients = {
            ["hogspub_cacaobean"] = {amount = 1},
            ["hogspub_flour"] = {amount = 1},
        },
    },
    ["hogspub_fishmeat"] = {
        price = 7.0,
        menu = false,
        ingredients = {
            ["hogspub_fish"] = {amount = 1},
        },
    },
    ["hogspub_fishmeatcooked"] = {
        price = 7.0,
        menu = false,
        ingredients = {
            ["hogspub_fishmeat"] = {amount = 1},
        },
    },
    ["hogspub_chickenmeatcooked"] = {
        price = 7.0,
        menu = false,
        ingredients = {
            ["hogspub_chickenmeat"] = {amount = 1},
        },
    },
    ["hogspub_eggcooked"] = {
        price = 7.0,
        menu = false,
        ingredients = {
            ["hogspub_egg"] = {amount = 1},
        },
    },  
    ["peanuts"] = {
        price = 7.0,
        menu = true,
        ingredients = {
        },
    },
    ["chipscheese"] = {
        price = 7.0,
        menu = true,
        ingredients = {
        },
    },    
}

Config.Kitchen = {
    [1] ={
        -- Cuisson vec3(-586.97, -277.55, 41.69)
        coords = vec3(-587.51, -276.82, 41.69),
        size = 0.5,
        title = "Préparer",
        duration = 5000,
        items = {
            "hogspub_chickenmeatcooked",
            "hogspub_fishmeatcooked",
            "hogspub_eggcooked",
        }
        -- Animation plus tard
    },
    [2] ={
        -- Tonneau rez de chaussée
        coords = vec3(-592.61, -285.44, 36.00),
        size = 0.5,
        title = "Verser",
        duration = 2000,
        items = {
            "bierreobeurre",
            "polynectar",
            "jusdecitrouille",
        }
        -- Animation plus tard
    },   
    [3] ={
        -- Tonneau rooftop
        coords = vec3(-588.63, -284.09, 50.93),
        size = 0.5,
        title = "Verser",
        duration = 2000,
        items = {
            "bierreobeurre",
            "polynectar",
            "jusdecitrouille",
        }
        -- Animation plus tard
    },
    [4] ={
        -- Plance à découper
        coords = vec3(-586.15, -281.03, 41.50),
        size = 0.5,
        title = "Couper",
        duration = 2000,
        items = {
            "hogspub_cuttedpotato",
            "hogspub_fishmeat",
        }    
    },   
    [5] ={
        -- Cuisson vec3(-587.63, -278.46, 41.69)
        coords = vec3(-587.03, -279.30, 41.69),
        size = 0.5,
        title = "Préparer",
        duration = 5000,
        items = {
            "fishnchips",
            "bubblensqueak",
            "chickenpie",
            "chocolapin",
        }
        -- Animation plus tard
    },
}

--# Fridge #--

Config.Fridge = {
    [1] ={
        coords = vec3(-583.74, -280.97, 41.69),
        size = 0.5,
        title = "Frigo",
        duration = 2000,
        items = {
            "hogspub_fish",
            "hogspub_chickenmeat",
            "hogspub_flour",
            "hogspub_cabbage",
            "hogspub_cacaobean",
            "hogspub_egg",
            "hogspub_potato",
        }
        -- Animation plus tard
    },
}

--## Caisse ##--
Config.Carte ={
    [1] ={
        coords = vec3(-590.26, -289.18, 35.80),
        size = 0.7,
        title = "Afficher la carte",
    },
    [2] ={
        coords = vec3(-587.37, -282.88, 50.57),
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
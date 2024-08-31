Config = {}
Config.DebugMode = true

Config.Job = "hogspub"

Config.Menu = {
    -- Liste des item 
    -- à la carte si menu = true, sinon ce sont des ingrédients
    ["fishnchips"] = {
        name = "Fish and chips",
        price = 7.0,
        menu = true,
        ingredients = {
            ["fish"] = {amount = 1},
            ["cutted_potato"] = {amount = 1},
        },
    },
    ["bierreobeurre"] = {
        name = "Bièraubeurre",
        menu = true,
        price = 8.0,
        ingredients = {},
    },
    ["polynectar"] = {
        name = "Polynectar",
        menu = true,
        price = 8.0,
        ingredients = {},
    },
    ["jusdecitrouille"] = {
        name = "Jus de citrouille",
        menu = true,
        price = 8.0,
        ingredients = {},
    },
    ["cutted_potato"] = {
        name = "Pomme frite",
        menu = false,
        price = 0,
        ingredients = {
            ["potato"] = {amount = 1},
        },
    },
    ["bubblensqueak"] = {
        name = "Bubble and squeak",
        price = 7.0,
        menu = true,
        ingredients = {
            ["cabbage"] = {amount = 1},
            ["lcegg"] = {amount = 1},
            ["potato"] = {amount = 1},
        },
    },
    ["chickenpie"] = {
        name = "Chicken pie",
        price = 7.0,
        menu = true,
        ingredients = {
            ["chicken"] = {amount = 1},
        },
    },
}

Config.Kitchen = {
    [1] ={
        -- Cuisson
        coords = vec3(-587.36, -279.48, 41.69),
        size = 0.5,
        title = "Préparer",
        duration = 5000,
        items = {
            "fishnchips",
            "bubblensqueak",
            "chickenpie",
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
            "cutted_potato"
        }    
    },   
}

Config.Fridge = {
    [1] ={
        coords = vec3(-584.2, -280.29, 41.69),
        size = 0.5,
        title = "Frigo",
        duration = 2000,
        items = {
            "fish",
            "potato",
            "chicken",
            "cabbage",
            "lcegg",
        }
        -- Animation plus tard
    },
}
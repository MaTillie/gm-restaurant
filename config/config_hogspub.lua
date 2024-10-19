function getConfig_hogspub()
Config = {}
Config.DebugMode = true


Config.Job = "hogspub"
Config.Ticket = true
Config.TrayLabel = "Hos's Pub"

-- Titre de la facture
Config.invoiceWording = "Facture du Hog's Pub"

Config.Categorie ={
    [1]={
        name = "entree",
        label = "Entrées",
    },
    [2]={
        name = "plat",
        label = "Plats",
    },
    [3]={
        name = "dessert",
        label = "Dessert",
    },
    [4]={
        name = "alcool",
        label = "Alcool",
    },
    [5]={
        name = "soft",
        label = "Softs",
    },
    [6]={
        name = "side",
        label = "Accompagnements",
    },
    [7]={
        name = "snack",
        label = "Grignotte",
    },
}

Config.Menu = {
    ["gmr_dsh_hogspub_bierraubeurre"] = { price = 21.00, categorie = "alcool" },
    ["gmr_dsh_hogspub_polynectar"] = { price = 16.00, categorie = "alcool" },
    ["gmr_dsh_hogspub_tartelette_citrouille"] = { price = 20.00, categorie = "plat" },
    ["gmr_dsh_hogspub_soupe_chicaneur"] = { price = 20.00, categorie = "entree" },
    ["gmr_cpigd_caramel_magique"] = { price = 20.00, categorie = "plat" },
    ["gmr_dsh_hogspub_fishnchips"] = { price = 20.00, categorie = "plat" },
    ["gmr_dsh_hogspub_chocogrenouille"] = { price = 5.00, categorie = "dessert" },
    ["gmr_dsh_hogspub_jus_de_citrouille"] = { price = 11.00, categorie = "soft" },
    ["gmr_dsh_hogspub_bubblensqueak"] = { price = 20.00, categorie = "plat" },
    ["gmr_dsh_hogspub_chickenpie"] = { price = 20.00, categorie = "plat" },
}






Config.Kitchen = {
   /* [1] ={
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
    },*/
    [1] ={
        -- Cuisson vec3(-587.63, -278.46, 41.69)
        coords = vec3(-587.03, -279.30, 41.69),
        size = 0.5,
        title = "Préparer",
        duration = 5000,
        items = {
            "gmr_dsh_hogspub_fishnchips",
            "gmr_dsh_hogspub_bubblensqueak",
            "gmr_dsh_hogspub_chickenpie",
            "gmr_dsh_hogspub_chocogrenouille",
        }
    },
    [2] ={
        -- Tonneau rez de chaussée
        coords = vec3(-592.61, -285.44, 36.00),
        size = 0.5,
        title = "Verser",
        duration = 2000,
        items = {
            "gmr_dsh_hogspub_bierraubeurre",
            "gmr_dsh_hogspub_polynectar",
            "gmr_dsh_hogspub_jus_de_citrouille",
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
            "gmr_dsh_hogspub_bierraubeurre",
            "gmr_dsh_hogspub_polynectar",
            "gmr_dsh_hogspub_jus_de_citrouille",
        }
        -- Animation plus tard
    },
    /*[4] ={
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
            "gmr_dsh_hogspub_fishnchips",
            "gmr_dsh_hogspub_bubblensqueak",
            "gmr_dsh_hogspub_chickenpie",
            "gmr_dsh_hogspub_chocogrenouille",
        }
        -- Animation plus tard
    },*/
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

Config.RecipeBook ={
    [1] ={
        coords = vec3(-586.19, -276.94, 41.69),
        size = 0.7,
        title = "Afficher les recettes",
    },
}

Config.Management={
    [1] ={
        coords = vec3(-584.81, -285.24, 41.71),
        size = 0.7,
        title = "Gestion du restaurant",
    },    
}


    
    return Config
end
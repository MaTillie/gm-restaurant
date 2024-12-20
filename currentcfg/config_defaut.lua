function getConfig_defaut()
    Config = {}
    Config.DebugMode = true
    
    
    Config.Job = "jopizza"
    Config.Ticket = true
    Config.TrayLabel = "Jo'Pizza"
    
    -- Titre de la facture
    Config.invoiceWording = "Facture du Jo'Pizza"
    
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
    

    /*
        ##### Format #####
        ["dish"] = { price = 20.00, categorie = "plat" },
    */

    Config.Menu = {
        ["gmr_dsh_hogspub_bubblensqueak"] = { price = 20.00, categorie = "plat" },
        ["gmr_dsh_hogspub_bierraubeurre"] = { price = 20.00, categorie = "alcool" },
        ["gmr_dsh_hogspub_chocogrenouille"] = { price = 5.00, categorie = "dessert" },
        ["gmr_dsh_hogspub_fishnchips"] = { price = 20.00, categorie = "plat" },
        ["gmr_dsh_hogspub_jus_de_citrouille"] = { price = 11.00, categorie = "soft" },
        ["gmr_dsh_hogspub_polynectar"] = { price = 15.00, categorie = "alcool" },
        ["gmr_dsh_hogspub_chickenpie"] = { price = 20.00, categorie = "plat" },
    }
    
    
    
    
    
    
    Config.Kitchen = {
        [1] ={
            -- Cuisson vec3(-587.63, -278.46, 41.69)
            coords = vec3(-587.03, -279.30, 41.69),
            size = 0.5,
            title = "Préparer",
            duration = 5000,
            items = {
                "gmr_dsh_hogspub_bubblensqueak",
            }
        },
        [2] ={
            -- Tonneau rez de chaussée
            coords = vec3(-592.61, -285.44, 36.00),
            size = 0.5,
            title = "Verser",
            duration = 2000,
            items = {
                "gmr_dsh_hogspub_bubblensqueak",
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
                "gmr_dsh_hogspub_bubblensqueak",
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
            coords = vec3(-581.55, -284.26, 35.47),
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
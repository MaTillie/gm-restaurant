function getConfig_leapfrog()
    Config = {}
    Config.DebugMode = false
    
    
    Config.Job = "leapfrog"
    Config.Ticket = true
    Config.TrayLabel = "Leap Frog"
    
    -- Titre de la facture
    Config.invoiceWording = "Facture du Leap frog"
    
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
    ["gmr_dsh_new_recipe_1730163243268"] = { price = 20.00, categorie = "dessert" },
    ["gmr_dsh_new_recipe_1730163868173"] = { price = 20.00, categorie = "dessert" },
    ["gmr_dsh_new_recipe_1730057990443"] = { price = 20.00, categorie = "dessert" },
    ["gmr_dsh_new_recipe_1730057741279"] = { price = 20.00, categorie = "dessert" },
}






    
    
    
    
    
    
    Config.Kitchen = {
        [1] ={
            coords = vec3(1115.84, -634.8, 56.84),
            size = 1.5,
            title = "Préparer",
            duration = 5000,
            items = {
            }
        },
    }
    
    --# Fridge #--
    
    Config.Fridge = {
        [1] ={
            coords = vec3(1118.35, -638.32, 56.82),
            size = 1.0,
            title = "Frigo",
            duration = 2000,
            items = {
            }
            -- Animation plus tard
        },
    }
    
    --## Caisse ##--
    Config.Carte ={
        [1] ={
            coords = vec3(1116.34, -642.49, 56.81),
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
            coords = vec3(1116.09, -638.49, 56.82),
            size = 0.7,
            title = "Gestion du restaurant",
        },    
    }
    
        
        return Config
    end
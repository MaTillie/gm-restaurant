function getConfig_leapfrog()
    Config = {}
    Config.DebugMode = true
    
    
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

}




    
    
    
    
    
    
    Config.Kitchen = {
        [1] ={
            coords = vec3(-583.7, -289.17, 35.45),
            size = 0.5,
            title = "Préparer",
            duration = 5000,
            items = {
            }
        },
    }
    
    --# Fridge #--
    
    Config.Fridge = {
        [1] ={
            coords = vec3(-586.2, -290.61, 35.47),
            size = 0.5,
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
            coords = vec3(-584.37, -278.72, 35.45),
            size = 0.7,
            title = "Gestion du restaurant",
        },    
    }

    Config.Delivery ={
        NPCCoords = vec3(-594.76, -285.07, 35.45),
        NPCHeading = 227.13,
    }
    
        
        return Config
    end
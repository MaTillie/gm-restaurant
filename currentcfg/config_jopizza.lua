function getConfig_jopizza()
    Config = {}
    Config.DebugMode = false
    
    
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
    ["gmr_dsh_new_recipe_1729340090886"] = { price = 20.00, categorie = "side" },
    ["gmr_dsh_new_recipe_1729797744307"] = { price = 30.00, categorie = "plat" },
    ["gmr_dsh_new_recipe_1729342845872"] = { price = 40.00, categorie = "plat" },
    ["gmr_dsh_new_recipe_1729344023687"] = { price = 30.00, categorie = "plat" },
    ["gmr_dsh_new_recipe_1729340525596"] = { price = 30.00, categorie = "plat" },
    ["gmr_dsh_new_recipe_1729714171548"] = { price = 15.00, categorie = "soft" },
    ["gmr_dsh_new_recipe_1729797834422"] = { price = 40.00, categorie = "plat" },
    ["gmr_dsh_new_recipe_1729344279367"] = { price = 15.00, categorie = "soft" },
    ["gmr_dsh_new_recipe_1729797619052"] = { price = 30.00, categorie = "plat" },
    ["gmr_dsh_new_recipe_1729343066904"] = { price = 30.00, categorie = "plat" },
}




    
    
    Config.Kitchen = {
        [1] ={
            -- Cuisson vec3(-587.63, -278.46, 41.69)
            coords = vec3(546.35, 105.9, 96.55),
            size = 1,
            title = "Préparer",
            duration = 5000,
            items = {
            }
        }, 
    }
    
    --# Fridge #--
    
    Config.Fridge = {
        [1] ={
            coords = vec3(544.4, 111.86, 96.55),
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
            coords = vec3(541.99,106.43,96.55),
            size = 0.7,
            title = "Afficher la carte",
        },
    }
    
    Config.RecipeBook ={
        [1] ={
            coords = vec3(544.4, 111.86, 96.55),
            size = 0.7,
            title = "Afficher les recettes",
        },
    }
    
    Config.Management={
        [1] ={
            coords = vec3(550.26, 109.18, 96.55),
            size = 0.7,
            title = "Gestion du restaurant",
        },    
    }
    
        
        return Config
    end